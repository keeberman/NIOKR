unit v_eyes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBTables, DB, Buttons, Grids, DBGrids, ExtCtrls, DBCtrls, Mask,
  vDbASUP, OracleData, ComCtrls, ToolWin, Menus,RxDBCtrl, ImgList, RxMemDS,
  Oracle, v_KrConsts;
const
  HotKey= #13;
  MaxSelRowCount= 200;
  SectionHeader= 'WatchEdit\';

type
  TShowMode= (smAuto,smCustom);

  TfmSearch = class(TForm)
    paMiddle: TPanel;
    paBottom: TPanel;
    dsSearch: TDataSource;
    qrSearch: TVASUPQuery;
    paTop: TPanel;
    ilToolbar: TImageList;
    ilToolbarHot: TImageList;
    paRight: TPanel;
    bbGood: TBitBtn;
    bbCancel: TBitBtn;
    ilToolBarDiz: TImageList;
    ToolBar: TToolBar;
    bPageDown: TToolButton;
    bNext: TToolButton;
    bPrior: TToolButton;
    bPageUp: TToolButton;
    ToolButton5: TToolButton;
    bbOrder: TToolButton;
    bbQuery: TToolButton;
    ToolButton8: TToolButton;
    meSQL: TMemo;
    pmSelect: TPopupMenu;
    itSelAll: TMenuItem;
    itSelNone: TMenuItem;
    pcMain: TPageControl;
    tsList: TTabSheet;
    DBGrid: TRxDBGrid;
    tsFilter: TTabSheet;
    mdFilter: TRxMemoryData;
    dsFilter: TDataSource;
    mdFilterqValue: TStringField;
    tlbQuery: TToolBar;
    tbAdd: TToolButton;
    tbDel: TToolButton;
    dbGridFilter: TRxDBGrid;
    mdFilterqField: TStringField;
    mdFilterqCond: TStringField;
    tlbCleanUp: TToolButton;
    bSaveSettings: TToolButton;
    bDropSavSettings: TToolButton;
    quFields: TOracleQuery;
    quFieldList: TOracleQuery;
    procedure bbQueryClick(Sender: TObject);
    procedure bbOrderClick(Sender: TObject);
    procedure bbGoodClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ItsQRYClick;
    procedure RunToGrid(myKey: Word);
    procedure dsSearchDataChange(Sender: TObject; Field: TField);
    procedure DBGridKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure dsSearchStateChange(Sender: TObject);
    procedure ArrowsClick(Sender: TObject);
    procedure StartLongClick(Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
    procedure FinishLongClick(Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
    procedure meSQLEnter(Sender: TObject);
    procedure meSQLExit(Sender: TObject);
    procedure SelectClick(Sender: TObject);
    procedure qrSearchAfterQuery(Sender: TOracleDataSet);
    procedure pcMainChange(Sender: TObject);
    procedure tbAddClick(Sender: TObject);
    procedure tbDelClick(Sender: TObject);
    procedure dbGridFilterKeyPress(Sender: TObject; var Key: Char);
    procedure tlbCleanUpClick(Sender: TObject);
    procedure mdFilterqFieldChange(Sender: TField);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure meSQLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bSaveSettingsClick(Sender: TObject);
    procedure qrSearchBeforeOpen(DataSet: TDataSet);
    procedure bDropSavSettingsClick(Sender: TObject);
    procedure qrSearchAfterOpen(DataSet: TDataSet);
  private
    FPrimField: TNumericField;
    FHlpField: TField;
    FCurKL: HKL;
    FMode: TShowMode;
    FNonDefMstr: TStrFldList;
    FOrderRestored: boolean;
    FFieldListRead: boolean;
    { Private declarations }
    procedure InitMemDataSet;
    procedure BuildFilterQuery;
    procedure RestoreSettings;
    procedure GetFieldList;
  public
    property PrimaryField:TNumericField read FPrimField write FPrimField;
    property HelpField:TField read FHlpField write FHlpField;
    property ShowMode: TShowMode read FMode write FMode;
    property FreeMasters: TStrFldList read FNonDefMstr write FNonDefMstr;
    procedure RestoreOrder;
    { Public declarations }
  end;

var
  fmSearch: TfmSearch;
  IniStorageSection: string;
  WatchEditTableName: string;
  WatchEditTableSchema: string;

implementation
uses v_utils,registry;
{$R *.DFM}

procedure TfmSearch.ItsQRYClick;
begin
  with qrSearch do
  begin
   SimpleQuery:= meSQL.Lines;
   Execute;
   if not EOF then ActiveControl:= DBGrid;
  end;
end;

procedure TfmSearch.bbQueryClick(Sender: TObject);
begin
  if pcMain.ActivePageIndex=0 then ItsQRYClick
  else bbGoodClick(bbGood);
end;

procedure TfmSearch.bbOrderClick(Sender: TObject);
begin
  qrSearch.Mixer;
end;


procedure TfmSearch.bbGoodClick(Sender: TObject);
begin
  if pcMain.ActivePageIndex=0 then ModalResult:= mrOk
  else
  begin
    meSQL.Lines.Clear;
    qrSearch.SimpleQuery:= meSQL.Lines;
    if mdFilter.State in [dsEdit,dsInsert] then
      mdFilter.Post;
    if not mdFilter.IsEmpty then
      BuildFilterQuery
    else qrSearch.QueryLibrary.Last;
    pcMain.ActivePageIndex:= 0;
    qrSearch.Execute;
  end;
end;

procedure TfmSearch.BuildFilterQuery;
var
  FilterQuery: TVisualQuery;
  Block: TSQL;
  filterBookMark: TBookMarkStr;
begin
  FilterQuery:= TVisualQuery.Create(qrSearch);
  with mdFilter do
  begin
    DisableControls;
    filterBookMark:= BookMark;
    First;
    while not EOF do
    begin
      with FilterQuery,Block do
      begin
        with dbGridFilter.Columns[0].PickList do
          FieldName:=
            TField(Objects[IndexOf(Fields[0].Value)]).FieldName;
        with dbGridFilter.Columns[1].PickList do
          Expr:= TSQLExpression(IndexOf(Fields[1].Value));
        Value:= Fields[2].AsString;
        ResType:= rtNone;
        Add(Block);
      end;
      Next;
    end;
    BookMark:= filterBookMark;
    EnableControls;
  end;
  qrSearch.QueryLibrary.Add(FilterQuery);
end;

procedure TfmSearch.FormShow(Sender: TObject);
var
  I: Integer;
begin
  dsSearch.Enabled:= true;
  pmSelect.AutoPopup:= dgMultiSelect in DBGrid.Options;
  with qrSearch do
    for I:= 0 to FieldCount-1 do
      dbGridFilter.Columns[0].PickList.AddObject(
        AnsiLowerCase(Fields[I].DisplayLabel),Fields[I]);
  (dbGridFilter.Columns[0].PickList as TStringList).Sort;
end;

procedure TfmSearch.InitMemDataSet;
begin
  with mdFilter.FieldDefs do begin
    Clear;
    with AddFieldDef do begin
      Name := 'qField';
      DataType := ftString;
      Required := True;
      Size:= 100;
    end;
    with AddFieldDef do begin
      Name := 'qCond';
      DataType := ftString;
      Required := True;
      Size:= 50
    end;
    with AddFieldDef do begin
      Name := 'qValue';
      DataType := ftString;
      Required := True;
      Size:= 100;
    end;
  end;
end;

procedure TfmSearch.FormCreate(Sender: TObject);
begin
  dsSearch.Enabled:= false;
  qrSearch.ShowShield:= false;
  FPrimField:= TNumericField.Create(Self);
  FHlpField:= TField.Create(Self);
  FOrderRestored:= false;
  FFieldListRead:= false;
  InitMemDataSet;
end;

procedure TfmSearch.RunToGrid;
begin
  ActiveControl:= DBGrid;
  if DBGrid.DataSource.DataSet.RecordCount>0 then begin
    if (myKey= vk_Up) and not (DBGrid.DataSource.DataSet.BOF) then
      DBGrid.DataSource.DataSet.Prior;
    if (myKey= vk_Down) and not (DBGrid.DataSource.DataSet.EOF) then
      DBGrid.DataSource.DataSet.Next;
  end;
end;

procedure TfmSearch.dsSearchDataChange(Sender: TObject; Field: TField);
begin
  if dsSearch.DataSet.IsEmpty then
  begin
    bPrior.Enabled:= false;
    bPageUp.Enabled:= false;
    bNext.Enabled:= false;
    bPageDown.Enabled:= false;
  end
  else
  begin
    if (dsSearch.DataSet.BOF) then
    begin
      bPrior.Enabled:= false;
      bPageUp.Enabled:= false;
      bNext.Enabled:= true;
      bPageDown.Enabled:= true
    end
    else if (dsSearch.DataSet.EOF) then
    begin
      bPrior.Enabled:= true;
      bPageUp.Enabled:= true;
      bNext.Enabled:= false;
      bPageDown.Enabled:= false
    end
    else
    begin
      bPrior.Enabled:= true;
      bPageUp.Enabled:= true;
      bNext.Enabled:= true;
      bPageDown.Enabled:= true;
    end
  end;
  bbGood.Enabled:= not dsSearch.DataSet.IsEmpty;
end;

procedure TfmSearch.DBGridKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=VK_RETURN then bbGoodClick(Sender);
end;

procedure TfmSearch.FormDestroy(Sender: TObject);
begin
  FPrimField.Free;
  FHlpField.Free;
end;

procedure TfmSearch.dsSearchStateChange(Sender: TObject);
var
  I,Idx: Integer;
begin
  if FMode=smAuto then
    with qrSearch do
      for I:= 0 to FieldCount-1 do
      begin
        if Assigned(FNonDefMstr) then
          Idx:= FNonDefMstr.IndexOf(Fields[I].FieldName)
        else Idx:= -1;
        if (Idx>=0) and (Fields[I] is TNumericField) then
          with (Fields[I] as TNumericField) do
          begin
            DisplayLabel:= FNonDefMstr.Displays[Idx].DLabel;
            DisplayWidth:= FNonDefMstr.Displays[Idx].DWidth;
            DisplayFormat:= FNonDefMstr.Displays[Idx].DFormat;
          end
        else if Fields[I].FieldName= FPrimField.FieldName then
        begin
          Fields[I].DisplayLabel:= FPrimField.DisplayLabel;
          if Fields[I] is TNumericField then
           with (Fields[I] as TNumericField) do
           begin
             DisplayWidth:= FPrimField.DisplayWidth;
             DisplayFormat:= FPrimField.DisplayFormat;
           end;
        end
        else Fields[I].DisplayLabel:= FHlpField.DisplayLabel;
      end;
  if dsSearch.State=dsBrowse then
    RestoreSettings;
end;

var
  StartTimer:bool;

procedure TfmSearch.ArrowsClick(Sender: TObject);
begin
  StartTimer:= true;
  if Descander(Sender,bPageDown) then
    DBGrid.Perform(WM_KEYDOWN,VK_NEXT,0)
    else if Descander(Sender,bNext)then
      DBGrid.DataSource.DataSet.Next
      else if Descander(Sender,bPrior)then
        DBGrid.DataSource.DataSet.Prior
        else if Descander(Sender,bPageUp)then
          DBGrid.Perform(WM_KEYDOWN,VK_PRIOR,0);
end;

procedure TfmSearch.StartLongClick(Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
begin
  StartTimer:= false;
  BeginRepeatCycle(Sender as TComponent,ClickDelay,ArrowsClick);
end;

procedure TfmSearch.FinishLongClick(Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
begin
  if not StartTimer then ArrowsClick(Sender);
  EndRepeatCycle;
  StartTimer:= false;
end;

procedure TfmSearch.meSQLEnter(Sender: TObject);
begin
  ReplaceKeyboardLayOut(FCurKL,CyrLayout);
end;

procedure TfmSearch.meSQLExit(Sender: TObject);
begin
  ActivateKeyboardLayout(FCurKL,0);
end;

const
  CTooManyRows= 'Слишком много строк. Выделение невозможно';

procedure TfmSearch.SelectClick(Sender: TObject);
begin
  if Sender= itSelAll then
    if qrSearch.SQLRecordCount>MaxSelRowCount then
       raise Exception.Create(CTooManyRows)
    else DBGrid.SelectAll
  else if Sender= itSelNone then DBGrid.UnselectAll;
end;

procedure TfmSearch.qrSearchAfterQuery(Sender: TOracleDataSet);
begin
  DBGrid.UnselectAll;
end;

procedure TfmSearch.pcMainChange(Sender: TObject);
begin
  if (pcMain.ActivePageIndex=1) and not (mdFilter.Active) then
    mdFilter.Active:= True;
end;

procedure TfmSearch.tbAddClick(Sender: TObject);
begin
  mdFilter.Insert;
end;

procedure TfmSearch.tbDelClick(Sender: TObject);
begin
  if not mdFilter.IsEmpty then mdFilter.Delete;
end;

procedure TfmSearch.dbGridFilterKeyPress(Sender: TObject; var Key: Char);
begin
  if dbGridFilter.SelectedIndex=2 then
    Key:= AnsiUpperCase(Key)[1]
  else Key:= AnsiLowerCase(Key)[1];
end;

procedure TfmSearch.tlbCleanUpClick(Sender: TObject);
begin
  mdFilter.EmptyTable;
end;

procedure TfmSearch.mdFilterqFieldChange(Sender: TField);
var
  Idx: Integer;
begin
  if not mdFilterqField.IsNull then
  begin
    Idx:= dbGridFilter.Columns[0].PickList.IndexOf(mdFilterqField.Value);
    if Idx>=0 then
      if mdFilterqValue.IsNull then
        if TField(dbGridFilter.Columns[0].PickList.Objects[Idx]).DataType=
           ftString then
          mdFilterqCond.Value:= dbGridFilter.Columns[1].PickList[Ord(piLike)]
        else
          mdFilterqCond.Value:= dbGridFilter.Columns[1].PickList[Ord(piEqual)]
  end;
end;

procedure TfmSearch.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in  Shift) then
  begin
    if (Key=Ord('S')) or (Key=Ord('s')) then
      bbOrderClick(bbOrder);
    if (Key=Ord('F')) or (Key=Ord('f')) then
      bbQueryClick(bbOrder);
  end;
  inherited;
end;

procedure TfmSearch.meSQLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (ssCtrl in  Shift) and (Key= VK_RETURN) then
  begin
    bbQueryClick(bbQuery);
    Key:= 0;
  end;
end;

procedure TfmSearch.bSaveSettingsClick(Sender: TObject);
var
  I: Integer;
begin
  with TRegIniFile.Create(SubSection+SectionHeader) do
  begin
    for I:= 0 to DBGrid.Columns.Count-1 do
      WriteInteger( qrSearch.UpdatingTable,
                    Format('%s.Width',[DBGrid.Columns.Items[I].FieldName])
                    ,DBGrid.Columns.Items[I].Width);
    for I:= 0 to qrSearch.FieldCount-1 do
      WriteInteger( qrSearch.UpdatingTable,
                    Format('%s_Index',
                    [qrSearch.Fields[I].FieldName])
                    ,qrSearch.Fields[I].Index);
    WriteString( qrSearch.UpdatingTable,
                  'Order',qrSearch.Order);
    Free;
  end;
end;

type
TPreIdx= record
           Field: TField;
           PreIndex: Integer;
         end;

PTPreIdx= ^TPreIdx;

function PreIdxCompare(Item1, Item2: Pointer): Integer;
begin
  Result:= PTPreIdx(Item1)^.PreIndex-PTPreIdx(Item2)^.PreIndex
end;

procedure TfmSearch.RestoreSettings;
var
  I: Integer;
  FieldList: TList;
  PreIdx: PTPreIdx;
begin
  with TRegIniFile.Create(SubSection+SectionHeader) do
  begin
    FieldList:= TList.Create;
    for I:= 0 to qrSearch.FieldCount-1 do
    begin
      New(PreIdx);
      PreIdx^.Field:= qrSearch.Fields[I];
      FieldList.Add(PreIdx);
    end;
    for I:= 0 to FieldList.Count-1 do
      PTPreIdx(FieldList[I])^.PreIndex:= ReadInteger( qrSearch.UpdatingTable,
                   Format('%s_Index',[PTPreIdx(FieldList[I])^.Field.FieldName])
                   ,PTPreIdx(FieldList[I])^.Field.Index);
    FieldList.Sort(PreIdxCompare);
    for I:= 0 to FieldList.Count-1 do
    begin
      PTPreIdx(FieldList[I])^.Field.Index:= PTPreIdx(FieldList[I])^.PreIndex;
      Dispose(PTPreIdx(FieldList[I]));
    end;
    FieldList.Free;
    with DBGrid do
      for I:= 0 to Columns.Count-1 do
      begin
        Columns.Items[I].Width:=
            ReadInteger( qrSearch.UpdatingTable,
                         Format('%s.Width',[Columns.Items[I].FieldName])
                       ,Columns.Items[I].Width);
        if Assigned(Columns[I].Field) then
          with Columns[I].Field do
            if Tag and CLICKED_FIELDTAG=CLICKED_FIELDTAG then
             Tag:= Tag-CLICKED_FIELDTAG;
      end;
    Free;
  end;
end;

procedure TfmSearch.RestoreOrder;
begin
  if not FOrderRestored then
    with TRegIniFile.Create(SubSection+SectionHeader) do
    begin
      qrSearch.Order:= ReadString(qrSearch.UpdatingTable,'Order',qrSearch.Order);
      FOrderRestored:= true;
      Free;
    end;
end;

procedure TfmSearch.qrSearchBeforeOpen(DataSet: TDataSet);
begin
  RestoreOrder;
end;

procedure TfmSearch.bDropSavSettingsClick(Sender: TObject);
begin
  with TRegIniFile.Create(SubSection+SectionHeader) do
  begin
    EraseSection(qrSearch.UpdatingTable);
    Free;
  end;
end;

procedure TfmSearch.GetFieldList;
var
  I: Integer;
  fld: TField;
begin
  if not FFieldListRead then
  begin
    quFields.Session:= qrSearch.Session;
    quFieldList.Session:= qrSearch.Session;
    quFields.SetComplexVariable('list',quFieldList);
    quFields.SetVariable('tab',qrSearch.ExtractTable_);
    quFields.SetVariable('sch',qrSearch.ExtractOwner_);
    quFields.Execute;
    quFieldList.Execute;
    if not quFieldList.EOF then
    begin
      qrSearch.DisableControls;
      for I:= 0 to qrSearch.FieldCount-1 do
        qrSearch.Fields[I].Visible:= false;
        I:= 0;
      while not quFieldList.EOF do
      begin
        fld:= qrSearch.FieldByName(quFieldList.FieldAsString(0));
        fld.Visible:= true;
        fld.Index:= I;
        quFieldList.Next;
        Inc(I);
      end;
      qrSearch.EnableControls;
    end;
    quFieldList.Close;
    quFields.Close;
    FFieldListRead:= true;
  end;
end;

procedure TfmSearch.qrSearchAfterOpen(DataSet: TDataSet);
begin
  qrSearch.AfterOpenPro(DataSet);
  GetFieldList;
end;

end.
