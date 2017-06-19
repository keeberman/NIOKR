unit v_srch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_Eyes, Db, OracleData, vDbASUP, StdCtrls, ComCtrls, ToolWin, Buttons,
  Grids, DBGrids, ExtCtrls, TB97Ctls, Menus, RXDBCtrl, ImgList, Oracle,
  RxMemDS, Variants;

type
  TfmSearchList = class(TfmSearch)
    tbNavigator: TToolBar;
    sbPriorLevel: TToolButton;
    sbNextLevel: TToolButton;
    ToolButton1: TToolButton;
    sbDirectList: TToolbarButton97;
    stPath: TStaticText;
    ilNavBar: TImageList;
    ilNavBarHot: TImageList;
    ilNavBarDiz: TImageList;
    pmDirect: TPopupMenu;
    qrSearchID: TFloatField;
    qrSearchKOD: TIntegerField;
    qrSearchSNAIM: TStringField;
    qrSearchPNAIM: TStringField;
    qrSearchMIPODR_ID: TFloatField;
    qrSearchMIUROVEN_KOD: TIntegerField;
    qrSearchPATH: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RefreshInterface(DataSet: TDataSet);
    procedure MenuItemClick(Sender: TObject);
    procedure FillPopUpMenu;
    procedure qrSearchAfterQuery(Sender: TOracleDataSet);
    procedure LevelArrowClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FIdList: TList;
    FCaption: string;
    FHiLimit: Integer;
    { Private declarations }
  public
    property StartFormCaption: string read FCaption write FCaption;
    property HighLimit: Integer read FHiLimit write FHiLimit;
    { Public declarations }
  end;

var
  fmSearchList: TfmSearchList;

implementation

{$R *.DFM}
uses globals;

procedure TfmSearchList.FillPopUpMenu;
var
  NewItem: TMenuItem;
begin
  with TOracleQuery.Create(Self) do
  begin
    Session:= qrSearch.Session;
    SQL.Text:= 'SELECT SNAIM FROM MIUROVEN ORDER BY KOD';
    Execute;
    while not EOF do
    begin
      NewItem:= TMenuItem.Create(Self);
      NewItem.Caption:= FieldAsString(0);
      NewItem.OnClick:= MenuItemClick;
      pmDirect.Items.Add(NewItem);
      Next;
    end;
    Close;
    Free;
  end;
end;

procedure TfmSearchList.FormCreate(Sender: TObject);
begin
  inherited;
  FIdList:= TList.Create;
  qrSearch.SetSQLFields(['KOD','PNAIM']);
  FillPopUpMenu;
  StartFormCaption:= Caption;
  FHiLimit:= 0;
end;

procedure TfmSearchList.FormDestroy(Sender: TObject);
begin
  inherited;
  FIdList.Free;
end;

procedure TfmSearchList.RefreshInterface(DataSet: TDataSet);
begin
  inherited;
  stPath.Caption:= qrSearchPATH.AsString;
  sbPriorLevel.Enabled:= Integer(qrSearch.GetVariable('CUR_LEVEL'))>FHiLimit;
  sbNextLevel.Enabled:= (FIdList.Count<=pmDirect.Items.Count) and
                         not qrSearch.IsEmpty
end;

procedure TfmSearchList.MenuItemClick(Sender: TObject);
begin
  with Sender as TMenuItem do
  begin
    if qrSearch.Active then qrSearch.Close;
    qrSearch.SetVariable('CUR_LEVEL',MenuIndex);
    qrSearch.SetVariable('ANCESTOR',Null);
    FIdList.Clear;
    qrSearch.Execute;
  end;
end;

procedure TfmSearchList.qrSearchAfterQuery(Sender: TOracleDataSet);
begin
  inherited;
  RefreshInterface(Sender);
  Caption:= Concat( StartFormCaption,
                    pmDirect.Items[Integer(qrSearch.GetVariable('CUR_LEVEL'))].Caption);
end;

procedure TfmSearchList.LevelArrowClick(Sender: TObject);
var
  LevelVal: Integer;
begin
  LevelVal:= Integer(qrSearch.GetVariable('CUR_LEVEL'));
  if Sender=sbPriorLevel then
  begin
    Dec(LevelVal);
    if FIdList.Count>0 then
      FIdList.Delete(FIdList.Count-1);
    if FIdList.Count>0 then
       qrSearch.SetVariable('ANCESTOR',Integer(FIdList[FIdList.Count-1]))
    else  qrSearch.SetVariable('ANCESTOR',Null);
    qrSearch.SetVariable('CUR_LEVEL',LevelVal);
    qrSearch.Execute;
    qrSearch.Locate('ID',qrSearchMIPODR_ID.Value,[]);
  end
  else if Sender=sbNextLevel then
  begin
    Inc(LevelVal);
    FIdList.Add(Pointer(qrSearchID.AsInteger));
    qrSearch.SetVariable('ANCESTOR',qrSearchID.Value);
    qrSearch.SetVariable('CUR_LEVEL',LevelVal);
    qrSearch.Execute;
  end;

end;

procedure TfmSearchList.FormShow(Sender: TObject);
begin
  inherited;
  qrSearch.Execute;
end;

end.
