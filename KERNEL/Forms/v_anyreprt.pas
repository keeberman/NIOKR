unit v_anyreprt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyform, ExtCtrls, Qrctrls, quickrpt,qrprntr, Db, vdbASUP;

type
  TfrAnyReport = class(TfmAnyForm)
               //Форма-предок для контейнеров отчета
    qrMain: TQuickRep;
    ColumnHeaderBand: TQRBand;
    Detail: TQRBand;
    PageHeaderBand: TQRBand;
    SummaryBand: TQRBand;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    qsPageNumber: TQRSysData;
    qsPrintTime: TQRSysData;
    dsReport: TDataSource;
    qlReportTitle: TQRLabel;
    ID: TVEditFormID;
    QRLabel2: TQRLabel;
    qlCriteria: TQRLabel;
    procedure qrMainBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);//Обработчик события BeforePrint компонента qrMain

    procedure qrMainAfterAction(Sender: TObject);
              //Обработчик события AfterPrint компонента qrMain

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
              {Обработчик события OnClose формы. Удаляет форму
              после ее закрытия}

    procedure qrMainPreview(Sender: TObject);
              {Обработчик события OnPreview компонента qrMain.
              Создает форму предварительного просмотра отчета}
  private
    { Private declarations }
    FSavePlace:TBookMarkStr;
    FPrevForm: TForm;
  protected
    procedure CMProgressUpdate(var Message : TCM_QRProgressUpdate); Message CM_QRPROGRESSUPDATE;
              {Перехват сообщения CM_QRPROGRESSUPDATE.Используется
              для отображения динамики формирования отчета в MainProgressBar
              главной формы fmMainMenu}
  public
    { Public declarations }
    property PreviewForm: TForm read FPrevForm write FPrevForm;
  end;
 // TReportRef=class of TfrAnyReport;
var
  frAnyReport: TfrAnyReport;

implementation
uses MENUGnrl, v_prnprv,oracledata;

{$R *.DFM}
procedure TfrAnyReport.qrMainBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  if not Assigned(qrMain.DataSet) then
     qrMain.DataSet:= dsReport.DataSet;
  qrMain.ReportTitle:= qrMain.DataSet.Name;
  if not qrMain.DataSet.ControlsDisabled then
  begin
    FSavePlace:= qrmain.DataSet.Bookmark;
    TOracleDataSet(qrMain.DataSet).ForceMasterSynchronization:= true;
    qrMain.DataSet.DisableControls;
  end;
end;

procedure TfrAnyReport.qrMainAfterAction(Sender: TObject);
begin
  inherited;
  if qrMain.DataSet.ControlsDisabled then
  begin
    qrMain.DataSet.Bookmark:= FSavePlace;
    qrMain.DataSet.EnableControls;
    TOracleDataSet(qrMain.DataSet).ForceMasterSynchronization:= false;
  end;
end;

procedure TfrAnyReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfrAnyReport.qrMainPreview(Sender: TObject);
begin
  if not Assigned(qrMain.DataSet) then
     qrMain.DataSet:= dsReport.DataSet;
  FSavePlace:= qrMain.DataSet.Bookmark;
  FPrevForm:= TfmPreview.Create(Self);
  with FPrevForm as TfmPreview do
  begin
    QRPreview.QRPrinter:= TQRPrinter(Sender);
    Show;
  end;
end;

const
  RealRecCount : LongInt = -1;

procedure TfrAnyReport.CMProgressUpdate(var Message : TCM_QRProgressUpdate);
var Progress : Integer;
begin
 Progress := Message.Position;
 if RealRecCount = -1 then
    if (qrMain.DataSet is TVASUPQuery)
       and not TVASUPQuery(qrMain.DataSet).QueryAllRecords then
      RealRecCount := TVASUPQuery(qrMain.DataSet).SQLRecordCount
    else RealRecCount := qrMain.DataSet.RecordCount;
 if RealRecCount <> 0
  then Progress := (Longint(qrMain.DataSet.RecNo) * 100) div RealRecCount;
 PostMessage(Application.MainForm.Handle, UM_PROGRESSUPDATE, Progress, 0);
 if Progress >= 100 then RealRecCount := -1;
end;

end.
