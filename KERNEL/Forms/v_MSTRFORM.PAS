unit v_MstrForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  NEWGFORM, Buttons, DBCtrls, Grids, DBGrids, StdCtrls, ExtCtrls, DB,vdbASUP,
  DBTables, ComCtrls,v_AnyForm,v_Child,vWORKFORM;
  
type
  TfmMasterDetail = class(TfmNewGrid)
    dsWorkMaster: TDataSource;
    DBGridMaster: TDBGridEx;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEnter(Sender: TObject);
    procedure DBGridMasterEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function GetActGrid: TDBGrid;
    { Private declarations }
  public
     LeStyleDet,LeStyleMas: TAccessLevel;
     FWorkMasterType: TWorkRef;
     FWorkDetailType: TWorkRef;
     MasterHint,DetailHint: string;
     property ActiveGrid: TDBGrid read GetActGrid;
     procedure WMOTHERS(var Message:TMessage);message WM_OTHERS;
     procedure PrintDataMaster;
    { Public declarations }
  end;

var
  fmMasterDetail: TfmMasterDetail;
  ASUPQueryMaster: TVASUPQuery;
  lvDetInit,lvMasInit: TAccessLevel;
  
implementation

uses dmSprav,Msprav,v_prnshld,v_rpnsim,OracleData;

{$R *.DFM}

function TfmMasterDetail.GetActGrid;
begin
  if DBGrid.DataSource=dsLocal then Result:= DBGrid
  else if DBGridMaster.DataSource=dsLocal then Result:= DBGridMaster
    else Result:= nil;
end;

procedure TfmMasterDetail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if dsWorkMaster.DataSet.Active then (dsWorkMaster.DataSet as TVASUPQuery).Sleep;
  dsWorkMaster.DataSet:= nil;
  inherited;
end;

procedure TfmMasterDetail.FormCreate(Sender: TObject);
var
  SafeMode: TfmWorkForm;
begin
  dsWorkMaster.DataSet:= ASUPQueryMaster;
  dsWork.DataSet:= ASUPQuery;
  if Assigned((dsWorkMaster.DataSet as TVASUPQuery).EditForm) then
    FWorkMasterType:= TWorkRef((dsWorkMaster.DataSet as TVASUPQuery).EditForm.ClassType);
  if Assigned((dsWork.DataSet as TVASUPQuery).EditForm) then
    FWorkDetailType:= TWorkRef((dsWork.DataSet as TVASUPQuery).EditForm.ClassType);
   LeStyleDet:= lvDetInit;
   LeStyleMas:= lvMasInit;
  // FReportType !!!!
   inFire(dsWorkMaster);
   FdsLocal:= dsWorkMaster;
   inFire(dsWork);
end;

procedure TfmMasterDetail.DBGridEnter(Sender: TObject);
begin
  Perform(WM_OTHERS,IN_DETAIL,0);
end;

procedure TfmMasterDetail.DBGridMasterEnter(Sender: TObject);
begin
  Perform(WM_OTHERS,IN_MASTER,0);
end;

procedure TfmMasterDetail.FormDestroy(Sender: TObject);
begin
  inherited;
  Application.MainForm.Perform(WM_OTHERS,IN_NOHAND,0)
end;

procedure TfmMasterDetail.WMOTHERS;
begin
  case Message.wParam of
    IN_ACTIVATE: begin
       inherited;
      Application.MainForm.Perform(WM_OTHERS,IN_HAND,0);
    end;
    IN_PAGEUP:dsLocal.DataSet.MoveBy(-DisplayCount(ActiveGrid));
    IN_PAGEDN:dsLocal.DataSet.MoveBy(DisplayCount(ActiveGrid));
    IN_MASTER: begin
      FdsLocal:= dsWorkMaster;
      FWorkType:= FWorkMasterType;
      AccessRights:= LeStyleMas;
      Perform(WM_OTHERS,IN_ACTIVATE,0);
      Application.MainForm.Perform(WM_OTHERS,IN_MASTER,0);
      DBGridMaster.SetFocus;
    end;
    IN_DETAIL: begin
      FdsLocal:= dsWork;
      FWorkType:= FWorkDetailType;
      AccessRights:= LeStyleDet;
      Perform(WM_OTHERS,IN_ACTIVATE,0);
      Application.MainForm.Perform(WM_OTHERS,IN_DETAIL,0);
      DBGrid.SetFocus;
    end ;
    IN_STATUS: with (Application.MainForm as TfmMainMenu).sbMain do begin
      Panels[1].Text:= Concat(TitleTC,
      IntTostr(RecordNumber),'.');
      if dsLocal=dsWork then Panels[2].Text:= DetailHint
      else Panels[2].Text:= MasterHint
    end;
    IN_PRINT: if not dsWorkMaster.DataSet.IsEmpty then PrintDataMaster
              else MessageDlg(CNoPrintData,mtError,[mbOk],0)
    else inherited;
  end;
end;

procedure TfmMasterDetail.PrintDataMaster;
var
  TempSource: TDataSource;
begin
  if Assigned(FReportType) then begin
    TempSource:= TDataSource.Create(Self);
    TempSource.DataSet:= dsWorkMaster.DataSet;
    (dsWork.DataSet as TVASUPQuery).Master:= TempSource.DataSet as TOracleDataSet;
    dsWork.Enabled:= false;
    dsWorkMaster.Enabled:= false;
    ReportForm:= FReportType.Create(Self);
    with ReportForm as TfrNSIMaster do begin
      dsReport.DataSet:= dsWorkMaster.DataSet;
      dsSubDetail.DataSet:= dsWork.DataSet;
      qrMain.ReportTitle:= dsWork.DataSet.Name;
      fmPrintShield:= TfmPrintShield.Create(Self);
      fmPrintShield.edTitle.Text:= Self.Caption;
      fmPrintShield.ShowModal;
      Free;
    end;
    dsWork.Enabled:= true;
    dsWorkMaster.Enabled:= true;
    (dsWork.DataSet as TVASUPQuery).Master:= dsWorkMaster.DataSet as TOracleDataSet;
    TempSource.Free;
  end;
end;

end.
