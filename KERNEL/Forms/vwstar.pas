unit vwstar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vworkform, vDbASUP, Menus, Db, StdCtrls, Buttons, ExtCtrls, ComCtrls, v_Anyform,
  Grids, DBGrids, RXDBCtrl,v_explorer, Placemnt, consts;

const
  CSheetChange= 'На вкладке ''''%s'''' имеются несохраненные изменения. Сохранить?';
  CSortDisabled= 'Сортировка записей невозможна в режиме ''''%s''''';
  CMasterNull= 'Не указан Master DataSet';
  CSaveRptCap= 'Запрос "%s"';
  CSaveRptPrompt= 'Сохранить с именем';

type

  TfmStarTopology = class(TfmWorkForm)
    pcMain: TPageControl;
    tsCentre: TTabSheet;
    dsCentre: TDataSource;
    DBGridMain: TRxDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure pcMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormShow(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure ModeSwitchPopup(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure paTopEnter(Sender: TObject);
    procedure pcMainEnter(Sender: TObject);
    procedure NavigatorClick(_Sender: TObject);override;
    procedure GridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
              {Обработчик события OnMouseMove сетки Grid.
              Используется для отображения подсказок к ячейкам сетки}

    procedure GridTitleClick(Column: TColumn);
    procedure dsCurrentDataChange(Sender: TObject; Field: TField);
    procedure dsCentreDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure pcMainDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
              {Обработчик события OnTitleClick сетки Grid.
              Используется для включения/отключения
              подсказок к ячейкам Grid}
  private
    { Private declarations }
    FCentralPageIndex: Integer;
    FMainCaption: string;
    FDataSets: TList;
    FCell: TGridCoord;
    FShowMultiHint: bool;
    FRptQueryId: Integer;
    FExecedRpt: boolean;
    FQueryCheckOn: boolean;
    function FixChanges(DataSet: TDataSet):boolean;
    function GetCentralState: TWStyle;
    procedure SpecifyToolBtnState;
    procedure SaveMajors(RptQueryId: Integer);
    procedure SaveMinors(RptQueryId: Integer);
    procedure SetRptQueryId(Value: Integer);
//    procedure ChangeSheetColor(PageIndex: Integer);
  protected
    procedure UMOTHERS(var Message:TMessage);message UM_OTHERS;
              {Перехват сообщения UM_OTHERS(остальное).
              Служит для обмена инструкциями с панелью
              инструментов главного окна}
    procedure UMFASTREPORT(var Message:TMessage);message UM_FASTREPORT;
              {Перехват сообщения UM_FASTREPORT(списочные отчеты).}
    procedure DefineDataSet;virtual;
    function OraclePerformance:boolean;override;
    function FindActiveGrid(Parent: TWinControl): TRxDBGrid;
    procedure ChangeCurrentSet(NewDataSet: TDataSet);
    function IsCentre(DataSet: TDataSet):boolean;
    procedure RepaintAllBtn;override;
    function NoDataInserting(DataSet:TDataSet):bool;virtual;
    function NeedToSave(DataSet:TDataSet):bool;virtual;
    procedure ReverseFormats;override;//Возврат полям их сохранненых форматов из FmtList
    procedure CopyFormats;override;
              {Сохранение форматов полей типа
               TIntegerField в списке FmtList}

    // Связка для функций для GetFieldHint
    function GetTableName(pFieldPack: PFieldPackage): string;virtual;
    function IsDecoded(CodeField: TField;var DecodeField: TField):bool;virtual;
    procedure AddAppendixConstr(SQL:TStrings; pFieldPack: PFieldPackage);virtual;
    function GetFieldHint(pFieldPack: PFieldPackage;var HintMsg:string):bool;
             {Возвращает TRUE в случае необходимости отображения подсказки
             к ячейке DBGrid поля из pFieldPack. В HintMsg помещается текст
             подсказки. Функция нуждается в переопределении у потомков}

    function IsHintAvailable(Field: TField):bool;virtual;
             {Определяет для Field необходимость отображения подсказки
             к ячейке DBGrid. Нуждается в переопределении у потомков}

    procedure SeekForward(pFieldPackage: PFieldPackage);
              {смещение в dsWork.DataSet согласно pFieldPackage }

    procedure SeekBack(pFieldPackage: PFieldPackage);
              {возврат к позиции в dsWork.DataSet до вызова SeekForward}

    procedure RestoreGridSavings(ActiveGrid: TRxDBGrid);

    procedure SaveGridCols(ActiveGrid: TRxDBGrid);

    procedure ResetSavedState(Section:string);

    function IsTabQueried(PageIndex: Integer):boolean;virtual;

    function IsCtrlQueried(Sender: TWinControl):boolean;

    function  PageByTabIndex( APageControl:TPageControl;
                                TabIndex: Integer): Integer;
    procedure DenyAccess;

    procedure ShowSQLDescription(AQuery:TVASUPQuery = nil);override;
  public
    { Public declarations }
    function SaveRptQuery: boolean;
    function StyleToText(Message: TMessage) : string;override;
    function GetObjectByTableName(const TabName: string): TVASUPQuery;
    procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;
    property CentralState: TWStyle read GetCentralState;
    property ShowMultiHint:bool read FShowMultiHint write FShowMultiHint;
    {В случае TRUE отображает подсказки к ячейкам DBGrid к полям,
    для которых GetFieldHint возвращает TRUE}
    property DataSets: TList read FDataSets;
    property RptQueryId: Integer read FRptQueryId write SetRptQueryId;
    property CentralPageIndex: Integer read FCentralPageIndex
                                write FCentralPageIndex;
    procedure PrepareNewQuery;virtual;
    procedure GetData(ADataSet:TDataSet;STYLEPARAM: Integer);override;
            {Определяет все DBAware-компоненты, с DataSource
            нацеленным на ADataSet и устанавливает
            их ReadOnly}
  end;

var
  fmStarTopology: TfmStarTopology;

implementation
uses TypInfo,MENUGnrl,globals
     ,oracle,registry,v_savqmod, oracledata, v_sqldesc;

{$R *.DFM}

procedure TfmStarTopology.SetRptQueryId(Value: Integer);
begin
  FRptQueryId:= Value;
  FExecedRpt:= false;
end;

function TfmStarTopology.GetObjectByTableName(const TabName: string): TVASUPQuery;
var
  I: Integer;
begin
  I:= 0;
  while (not (TDataSet(FDataSets[I]) is TVASUPQuery)
         or (TVASUPQuery(FDataSets[I]).Updatingtable<> TabName) )
        and (I<FDataSets.Count) do Inc(I);
  if I< FDataSets.Count then
     Result:= TVASUPQuery(FDataSets[I])
  else Result:= nil;
end;

procedure TfmStarTopology.FormCreate(Sender: TObject);
begin
  inherited;
  FDataSets:= TList.Create;
  FMainCaption:= Caption;
  AccessRights:=
    TVASUPQuery(dsCentre.DataSet).AccessLevel*[aqQuerying,aqInserting];
  pcMain.ActivePage:= tsCentre;
  FRptQueryId:= 0;
  pcMain.OwnerDraw:= true;
  FQueryCheckOn:= false;
  FCentralPageIndex:= 1;
end;

function TfmStarTopology.StyleToText(Message:TMessage) : string;
var
  UsingPage: TTabSheet;
begin
  if pcMain.ActivePage.PageIndex>0 then
     UsingPage:= pcMain.ActivePage
  else UsingPage:= pcMain.Pages[1];//Страница по основному массиву
  Result:= Format('%s.%s.%s',[ FMainCaption,UsingPage.Caption,
                               inherited StyleToText(Message)]);
end;

function TfmStarTopology.NoDataInserting(DataSet:TDataSet):bool;
begin
  Result:= IsEmptyRecord(DataSet,[nil]);
end;

function TfmStarTopology.NeedToSave(DataSet:TDataSet):bool;
var
  I: Integer;
begin
  if WorkStyle<> wsQuery then
    case DataSet.State of
      dsEdit:
      begin
        Result:= false;
        I:= 0;
        if DataSet.Modified then
        while not Result and (I<DataSet.FieldCount) do
        begin
          if DataSet.Fields[I].FieldKind= fkData then
             Result:= DataSet.Fields[I].OldValue<>DataSet.Fields[I].Value;
          Inc(I);
        end;
      end;
      dsInsert: Result:= IsCentre(DataSet) or not NoDataInserting(DataSet)
      else Result:= false;
    end
  else Result:= false;
end;

procedure TfmStarTopology.pcMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if WorkStyle<>wsQuery then
    if NeedToSave(TDataSet(pcMain.ActivePage.Tag)) then
    begin
      AllowChange:= false;
      case MessageDlg( Format(CSheetChange,[pcMain.ActivePage.Caption])
                                  ,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
        mrYes:
        try
          TDataSet(pcMain.ActivePage.Tag).Post;
          AllowChange:= true;
        except
          on E:Exception do
          begin
            MessageDlg(E.Message,mtError,[mbOk],0);
            AllowChange:= false;
          end;
        end;
        mrNo:
        begin
          TDataSet(pcMain.ActivePage.Tag).Cancel;
          AllowChange:= true;
        end
      end;
    end
    else if not IsCentre(TDataSet(pcMain.ActivePage.Tag)) then
    begin
      TDataSet(pcMain.ActivePage.Tag).Cancel;
      TDataSet(pcMain.ActivePage.Tag).Close;
    end;
  if AllowChange and (WorkStyle= wsQuery) and Assigned(ActiveControl) then
     ActiveControl.Perform(CM_EXIT,0,0);
end;

function FindAreaDataSet(Area: TWinControl):TDataSet;
var
  I: Integer;
  PropInfo: PPropInfo;
begin
  I:= 0;
  PropInfo:= nil;
  Result:= nil;
  while (I<Area.ControlCount)
        and not Assigned(PropInfo) do
  begin
    PropInfo:= GetPropInfo(Area.Controls[I].ClassInfo,'DataSource');
    if Assigned(PropInfo) then
      Result:= TDataSource(GetOrdProp(Area.Controls[I],PropInfo)).DataSet
    else Inc(I);
  end;
  I:= 0;
  while (I<Area.ControlCount) and not Assigned(Result) do
  begin
    if Area.Controls[I] is TWinControl then
    Result:= FindAreaDataSet(Area.Controls[I] as TWinControl);
    Inc(I);
  end;
end;

procedure TfmStarTopology.DefineDataSet;
var
  I: Integer;
begin
  for I:= 0 to pcMain.PageCount-1 do
  begin
    pcMain.Pages[I].Tag:=Integer(FindAreaDataSet(pcMain.Pages[I]));
    pcMain.Pages[I].TabVisible:= pcMain.Pages[I].TabVisible and
      (TVASUPQuery(pcMain.Pages[I].Tag).AccessLevel<>[]);
    TVASUPQuery(pcMain.Pages[I].Tag).WorkState:= wsNone;
    TVASUPQuery(pcMain.Pages[I].Tag).WorkSpace:= Self;
  end;
  FDataSets.Clear;
  for I:= 0 to ComponentCount-1 do
    if Components[I] is TDataSource then
    if Assigned(TDataSource(Components[I]).DataSet)
       and (TDataSource(Components[I]).DataSet is TVASUPQuery)
       and (FDataSets.IndexOf(TDataSource(Components[I]).DataSet)<0) then
       FDataSets.Add(TDataSource(Components[I]).DataSet);
end;

procedure TfmStarTopology.FormShow(Sender: TObject);
begin
  inherited;
  DefineDataSet;
  dsCurrent.DataSet:= dsCentre.DataSet;
  RestoreORDERBY(TVASUPQuery(dsCentre.DataSet));
  RestoreSavings;
  dsCentre.DataSet.Open;
  if dsCurrent.DataSet.IsEmpty then WorkStyle:= wsQuery
  else WorkStyle:= wsEdit;
  FQueryCheckOn:= true;
end;

function TfmStarTopology.PageByTabIndex( APageControl:TPageControl;
                                         TabIndex: Integer): Integer;
begin
  Result:= 0;
  while (Result<APageControl.PageCount)
        and (APageControl.Pages[Result].TabIndex<> TabIndex) do Inc(Result)
end;

{procedure TfmStarTopology.ChangeSheetColor(PageIndex: Integer);
begin

  if TVASUPQuery(pcMain.Pages[PageIndex].Tag).IsEmptyScreen then
  begin

  end;
end;}

procedure TfmStarTopology.pcMainChange(Sender: TObject);
var
  NewStyle: TWStyle;
begin
  if dsCurrent.DataSet<> TDataSet(pcMain.ActivePage.Tag) then
  begin
    ChangeCurrentSet(TDataSet(pcMain.ActivePage.Tag));
    RestoreGridSavings(FindActiveGrid(pcMain.ActivePage));
    ActiveControl:= nil;
    if IsCentre(TDataSet(pcMain.ActivePage.Tag)) then
    begin
      ControlArea:= nil;
      FWStyle:= (dsCurrent.DataSet as TVASUPQuery).WorkState;
      if FWStyle= wsEdit then
         GetData(dsCurrent.DataSet,IN_EDIT);
      SetActCtrl;
      RepaintAllBtn;
    end
    else
    begin
      ControlArea:= pcMain.ActivePage;
      if CentralState<> wsQuery then
      begin
        if not IsCentre(dsCurrent.DataSet)
           and dsCentre.DataSet.IsEmpty then
        begin
          AccessRights:= AccessRights*[aqQuerying{,aqPrinting}];
          NewStyle:= wsView;
        end
        else
          if dsCurrent.DataSet.RecordCount=0 then
          begin
            AccessRights:= AccessRights*[aqInserting,aqQuerying{,aqPrinting}];
            NewStyle:= wsView;
          end
          else NewStyle:= wsView
      end
      else NewStyle:= wsQuery;
      if NewStyle<> (dsCurrent.DataSet as TVASUPQuery).WorkState then
         WorkStyle:= NewStyle
      else
      begin
        FWStyle:= (dsCurrent.DataSet as TVASUPQuery).WorkState;
        SetActCtrl;
        RepaintAllBtn;
      end;
    end;
    Caption:= StyleToText(Ws2Msg(WorkStyle));
    DenyAccess;
    SpecifyToolBtnState;
  end
  else RestoreGridSavings(FindActiveGrid(pcMain.ActivePage));
  SetPopItems;
end;

procedure TfmStarTopology.DenyAccess;
begin
  if CentralState=wsQuery then
   if not IsCentre(dsCurrent.DataSet) then
          AccessRights:= [aqQuerying]
   else AccessRights:= [aqQuerying,aqInserting]
  else AccessRights:= TVASUPQuery(dsCurrent.DataSet).AccessLevel;
  Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
end;

function TfmStarTopology.FixChanges(DataSet: TDataSet):boolean;
var
  MsgResult: Word;
begin
  if (WorkStyle in [wsAdd,wsEdit])
     and DataSet.Modified then
  begin
    MsgResult:= MessageDlg( Format(CSheetChange,[pcMain.ActivePage.Caption]),
                            mtConfirmation,[mbYes,mbNo,mbCancel],0);
    if MsgResult=mrYes then DataSet.Post;
    Result:= MsgResult<>mrCancel;
  end
  else Result:= true;
end;

procedure TfmStarTopology.SpecifyToolBtnState;
begin
  with TfmMainMenu(Application.MainForm) do
  begin
    {sbSort.Enabled:= WorkStyle in [wsEdit,wsView,wsDelete];
    vpSort.Enabled:= sbSort.Enabled;}
    sbRefresh.Enabled:= WorkStyle in [wsEdit,wsView,wsDelete];
    vpRefresh.Enabled:= sbRefresh.Enabled;
  end;
end;

procedure TfmStarTopology.ResetSavedState(Section:string);
begin
  with TRegIniFile.Create(StorageSection+Self.ClassName) do
  begin
    EraseSection(Section);
    Free;
  end;
end;

procedure TfmStarTopology.SaveMinors(RptQueryId: Integer);
begin
  with dmSaveRptQuery.quNewMinors do
  begin
    SetVariable('RptId', RptQueryId);
    SetVariable('OrderText', TVASUPQuery(dsCentre.DataSet).Order);
    SetVariable('MainTable', TVASUPQuery(dsCentre.DataSet).UpdatingTable);
    if TVASUPQuery(dsCentre.DataSet).SQLFiltered then
      SetVariable('FilterText', TVASUPQuery(dsCentre.DataSet).SQLFilter)
    else SetVariable('FilterText', Null);
    Execute;
  end;
end;

procedure TfmStarTopology.SaveMajors(RptQueryId: Integer);

procedure AddObjWithChildren (HostObj: TVASUPQuery; GlobalIndex: Integer);
var
  I: Integer;

procedure AddOneQObj(QObj: TVASUPQuery; LocalIndex: Integer);
var
  J: Integer;
  CurViQuery: TVisualQuery;
  LOB: TLOBLocator;
  AutoCommit: boolean;

procedure SetLOBVar( Value: string);
var
  Buffer: PChar;
begin
  Buffer:= PChar(Value);
  LOB.Write(Buffer^,Length(Value));
end;

begin
  CurViQuery:= nil;
  if LocalIndex>=0 then
    CurViQuery:= TVisualQuery(QObj.QueryLibrary[LocalIndex]);
  AutoCommit:= dmSaveRptQuery.quNewMajors.Session.AutoCommit;
  dmSaveRptQuery.quNewMajors.Session.AutoCommit:= False;
  if Assigned(CurViQuery) then
    with CurViQuery do
      for J:= 0 to Count-1 do
        with dmSaveRptQuery.quNewMajors do
        begin
          SetVariable('RptId', RptQueryId);
          SetVariable('TabName', QObj.UpdatingTable);
          SetVariable('FldName',Blocks[J].FieldName);
          SetVariable('Value',Blocks[J].Value);
          SetVariable('Cond', Ord(Blocks[J].Expr));
          SetVariable('ResType', Ord(Blocks[J].ResType));
          SetVariable('Description',Blocks[J].Comment);
          LOB := TLOBLocator.Create(Session, otBLOB);
          SetComplexVariable('Res',LOB);
          Execute;
          case Blocks[J].ResType of
            rtString: SetLOBVar(String(Blocks[J].ResString));
            rtEnumList: SetLOBVar(Blocks[J].ResEnumList.FullText);
            rtDate:
              SetLOBVar(VarAsType(VarFromDateTime(Blocks[J].ResDate),varString));
          end;
          LOB.Free;
          Session.Commit;
        end;
   dmSaveRptQuery.quNewMajors.Session.AutoCommit:= AutoCommit;
end;

begin
  with HostObj.LinkedQueryList.Nodes[GlobalIndex] do
  begin
    AddOneQObj(HostObj,SelfIndex);
    for I:= 0 to Count-1 do
      AddObjWithChildren(Nodes[I].Obj,Nodes[I].Index);
  end;
end;

begin
  AddObjWithChildren ( TVASUPQuery(dsCentre.DataSet),
                       TVASUPQuery(dsCentre.DataSet).IndexQuery)
end;

function TfmStarTopology.SaveRptQuery;
var
  LastKL: HKL;
  RptName: string;
  RptCapDial: string;
  RptWin: TForm;
  RptWinClass: TField;
begin
  with dmSaveRptQuery do
  begin
    RptName:= osRptQueryNAME.AsString;
    ReplaceKeyboardLayOut(LastKL,CyrLayout);
    try
      if FRptQueryId=0 then RptCapDial:= Format(CSaveRptCap,['Новый'])
      else RptCapDial:= Format(CSaveRptCap,[RptName]);
      Result:= InputQuery(RptCapDial,CSaveRptPrompt,RptName);
      if Result then
      begin
        if FRptQueryId=0 then
        begin
          if osRptQuery.State<>dsInsert then
            osRptQuery.Insert
        end
        else
        begin
          osRptQuery.Locate('ID',FRptQueryId,[]);
          osRptQuery.Edit;
        end;
        osRptQueryNAME.AsString:= RptName;
        RptWinClass:= osRptQuery.FindField('WINCLASS');
        if Assigned(RptWinClass) then
          RptWinClass.AsString:= Self.ClassName;
        Self.Repaint;
        if FRptQueryId<>0 then
        begin
          quClear1.SetVariable('RptId',FRptQueryId);
          quClear2.SetVariable('RptId',FRptQueryId);
          quClear1.Execute;
          quClear2.Execute;
        end;
        osRptQuery.Post;
        SaveMinors(osRptQueryID.AsInteger);
        SaveMajors(osRptQueryID.AsInteger);
        FRptQueryId:= osRptQueryID.AsInteger;
      end;
    finally
      ActivateKeyboardLayOut(LastKL,0);
    end;
  end;
  {RptWin:= GetChildWindow(fmMainMenu,fmMainMenu.vpOpenQuery);
  if Assigned(RptWin) then RptWin.Perform(UM_OTHERS,IN_REFRESH,0);}
  Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYWIN,0);
end;

procedure TfmStarTopology.UMOTHERS;
var
  ActiveGrid: TRxDBGrid;
  RptName: string;
begin
  case Message.wParam of
    IN_ACTIVATE:
    begin
      inherited;
      Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
      Perform(UM_OTHERS,IN_STATUS,0);
      SpecifyToolBtnState;
    end;
    IN_SORT: if FixChanges(dsCurrent.DataSet) then
                (dsCurrent.DataSet as TVASUPQuery).Mixer;
    IN_PAGEUP,IN_PAGEDN: if WorkStyle in [wsNone,wsView,wsEdit] then
               begin
                 ActiveGrid:= FindActiveGrid(pcMain.ActivePage);
                 if Assigned(ActiveGrid) and ActiveGrid.Enabled
                    and ActiveGrid.Visible then
                 begin
                   ActiveGrid.SetFocus;
                   if  Message.wParam= IN_PAGEUP then
                       ActiveGrid.Perform(WM_KEYDOWN,VK_PRIOR,0)
                   else ActiveGrid.Perform(WM_KEYDOWN,VK_NEXT,0);
                 end;
               end;
    IN_PRIOR: Perform(WM_KEYDOWN,VK_UP,0);
    IN_NEXT:  Perform(WM_KEYDOWN,VK_DOWN,0);
    IN_QUIT: Close;
    IN_EXECQUERY:  if WorkStyle= wsQuery then
                   begin
                     SetFocus;
                     bbOk.Click;
                   end;
    IN_FORMQUERY_REPAINT: Repaint;
    IN_STORE:
    begin
      ActiveGrid:= FindActiveGrid(pcMain.ActivePage);
      if Assigned(ActiveGrid) then SaveGridCols(ActiveGrid)
      else inherited;
    end;
    IN_UNSTORE:
    begin
      ActiveGrid:= FindActiveGrid(pcMain.ActivePage);
      if Assigned(ActiveGrid) then
         ResetSavedState(ActiveGrid.Name);
      inherited;
    end;
    IN_SAVEQUERY:
    begin
      dmSaveRptQuery:= TdmSaveRptQuery.Create(Self);
      try
        dmSaveRptQuery.osRptQuery.Open;
        if FRptQueryId<>0 then
        begin
          dmSaveRptQuery.osRptQuery.Locate('ID',FRptQueryId,[]);
          dmSaveRptQuery.osRptQuery.Edit;
        end
        else dmSaveRptQuery.osRptQuery.Insert;
        SaveRptQuery;
        FRptQueryId:= dmSaveRptQuery.osRptQueryID.AsInteger;
      finally
        dmSaveRptQuery.Free;
      end;
    end;
    IN_SAVEQUERYAS:
    begin
      dmSaveRptQuery:= TdmSaveRptQuery.Create(Self);
      try
        dmSaveRptQuery.osRptQuery.Open;
        dmSaveRptQuery.osRptQuery.Locate('ID',FRptQueryId,[]);
        RptName:= dmSaveRptQuery.osRptQueryNAME.AsString;
        dmSaveRptQuery.osRptQuery.Insert;
        dmSaveRptQuery.osRptQueryNAME.AsString:= RptName;
        FRptQueryId:= 0;
        SaveRptQuery;
        FRptQueryId:= dmSaveRptQuery.osRptQueryID.AsInteger;
      finally
        dmSaveRptQuery.Free;
      end;
    end;
    else inherited;
  end;
end;

procedure TfmStarTopology.ButtonClick(Sender: TObject);
begin
  if Sender=bbOk then
  begin
    //ActiveControl:= nil;
    //bbOk.SetFocus;
    if Assigned(ActiveControl) then
      ActiveControl.Perform(CM_EXIT,0,0);
     {для срабатывания события OnExit
      у компонентов TQueryEdit}
    if OraclePerformance and (WorkStyle<>wsEdit) then
       WorkStyle:= wsView;
    Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
  end
  else if Sender= bbView then
  begin
    if FWStyle= wsQuery then
      (dsCurrent.DataSet as TVASUPQuery).CloseViSession;
    Close;
  end
  else if Sender= bbCancel then
  begin
    dsCurrent.DataSet.Cancel;
    TVASUPQuery(dsCurrent.DataSet).WorkState:= wsNone;
    if WorkStyle= wsAdd then
       WorkStyle:= wsView
    else WorkStyle:= WorkStyle;
  end;
end;

procedure TfmStarTopology.ModeSwitchPopup(Sender: TObject);
var
  CurWorkState: TWStyle;
begin
 CurWorkState:= CentralState;
  with (Application.MainForm as TfmMainMenu),(Sender as TPopUpMenu) do
    if (CurWorkState in [wsQuery,wsDelete,wsAdd])
       and not IsCentre(dsCurrent.DataSet) then
    begin
      Items[Ord(wsEdit)].Enabled:= false;
      Items[Ord(wsView)].Enabled:= false;
      Items[Ord(wsAdd)].Enabled:= sbAdd.Enabled and (CurWorkState=wsAdd);
      Items[Ord(wsDelete)].Enabled:= sbDelete.Enabled and (CurWorkState=wsDelete);
      Items[Ord(wsQuery)].Enabled:= sbQuery.Enabled and (CurWorkState=wsQuery);
    end
    else
    begin
      Items[Ord(wsAdd)].Enabled:= sbAdd.Enabled;
      Items[Ord(wsEdit)].Enabled:= sbEdit.Enabled;
      Items[Ord(wsDelete)].Enabled:= sbDelete.Enabled;
      Items[Ord(wsView)].Enabled:= sbView.Enabled;
      Items[Ord(wsQuery)].Enabled:= sbQuery.Enabled;
    end;
  PopUpMenu:= Sender as TPopUpMenu;
end;

procedure TfmStarTopology.UMChangeMode(var Message:TMessage);
var
  CurSet: TDataSet;
  ActiveGrid: TCustomGrid;
  FCurCtrlArea: TWinControl;
  SQItems: Integer;
begin
  if IsLyingOn(paRightBottom,ActiveControl) then
     ActiveControl:= nil;
  if not ( (TVASUPQuery(dsCurrent.DataSet).WorkState=wsQuery)
           and (Message.wParam= IN_QUERY) and IsCentre(dsCurrent.DataSet)
           ) then
  begin
    pcMain.Invalidate;
    {tsCentre.TabVisible:= (Message.wParam<>IN_QUERY) and
                          ( not IsCentre(dsCurrent.DataSet)
                            or (Message.wParam<>IN_INSERT));}
    tsCentre.Enabled:= (Message.wParam<>IN_QUERY) and
                          ( not IsCentre(dsCurrent.DataSet)
                            or (Message.wParam<>IN_INSERT));
    if not {tsCentre.TabVisible}tsCentre.Enabled
       and (pcMain.ActivePage= tsCentre) then
        pcMain.SelectNextPage(True);
    if IsCentre(dsCurrent.DataSet) then
    begin
      // ActiveControl:= nil;
      ControlArea:= nil;
    end;
    if Message.wParam= IN_QUERY then FRptQueryId:= 0;
    if (Message.wParam= IN_QUERY) and not IsCentre(dsCurrent.DataSet)
       and (CentralState<>wsQuery) then
    begin
      dsCurrent.DataSet.Cancel;
      CurSet:= dsCurrent.DataSet;
      dsCurrent.DataSet:= dsCentre.DataSet;
      FCurCtrlArea:= ControlArea;
      inherited;
      ActiveControl:= nil;
      ControlArea:= FCurCtrlArea;
      dsCurrent.DataSet:= CurSet;
      FWStyle:= wsNone;
    end;
    inherited;
    if (Message.wParam= IN_QUERY) and ShowSQLDescriptForm then
        ShowSQLDescription;
    SpecifyToolBtnState;
    bbCancel.Visible:= Message.wParam in [IN_EDIT,IN_INSERT];
    bbView.Visible:= true;
    ActiveGrid:= FindActiveGrid(pcMain.ActivePage);
    if Assigned(ActiveGrid) and (ActiveGrid<>DBGridMain) then
      ActiveGrid.Enabled:= not (Message.wParam in [IN_QUERY,IN_INSERT]);
    SQItems:= 0;
    Inc(SQItems,Integer(not (WorkStyle in [wsNone,wsQuery])));
    Inc(SQItems,Integer( not (WorkStyle in [wsNone,wsQuery]) and (FRptQueryId<>0) )*2);
    Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYITEMS,SQItems);
  end
  else PrepareNewQuery;
  if Assigned(ActiveControl) then
     ActiveControl.Perform(CM_ENTER,0,0);
  {для срабатывания события OnEnter
      у компонентов TQueryEdit}
end;

function TfmStarTopology.IsCentre(DataSet: TDataSet):boolean;
begin
  Result:= DataSet= dsCentre.DataSet;
end;

function TfmStarTopology.OraclePerformance:boolean;
var
  LastActPage: TTabSheet;
  AllowChange: boolean;

procedure ReturnLastQuery(MajorObj: TVASUPQuery);
{var
  I: Integer;
  MinorObj: TVASUPQuery;}
begin
 { with MajorObj do
   for I:= 0 to LinkedQueries.Count-1 do
   begin
     MinorObj:= TVASUPQuery(LinkedQueries[I]);
     MinorObj.Open;
     MinorObj.Insert;
     MinorObj.OnScreen(MinorObj.IndexViQuery);
     MinorObj.WorkState:= wsQuery;
     if MinorObj.IsLinkedSQL then
        ReturnLastQuery(MinorObj)
   end;
   }
end;

begin
  if WorkStyle= wsQuery then
    with (dsCentre.Dataset as TVASUPQuery) do
    begin
      ClearDataCount;
      Self.Enabled:= false;
      Screen.Cursor:= crSQLWait;
      SaveViQuery;
      try
        try
          Execute;
        finally
          Self.Enabled:= true;
          Screen.Cursor:= crDefault;
        end;
      except
        on E:EEmptyQuery do
        begin
          MessageDlg(E.Message,mtError,[mbOk],0);
          ActiveControl:= nil;
          SetActCtrl;
          Result:= false;
          exit;
        end
        else raise;
      end;
      {if (FRptQueryId<>0) then
        if FExecedRpt then FRptQueryId:= 0
        else FExecedRpt:= true;}
      if IsEmpty then
      begin
        MessageBeep(0);
        MessageDlg(EmptyQueryDataMsg,mtWarning,[mbOk],0);
        Result:= false;
        {Insert;
        WorkState:= wsQuery;
        OnScreen(IndexViQuery);}
        LinkedQueryList.Seek(IndexQuery);
        if ShowSQLDescriptForm then
          ShowSQLDescription(dsCentre.Dataset as TVASUPQuery);
        {if not IsLinkedSQL and not Filtered then }DeleteQuery(True);
        //ReturnLastQuery(TVASUPQuery(dsCentre.DataSet));
        ActiveControl:= nil;
        //ControlArea:= nil;
        SetActCtrl;
        pcMain.Invalidate;
      end
      else  Result:= true;
      if Result then
      begin
        FWStyle:= wsNone; // Против лишнего покраснения
        CloseViSession;
        ChangeCurrentSet(dsCentre.DataSet);
        if ShowSQLDescriptForm then ShowSQLDescription;
        if RecordCount>1 then
        begin
          pcMain.Invalidate;
          //tsCentre.TabVisible:= true;
          tsCentre.Enabled:= true;
          pcMain.ActivePage:= tsCentre;
          RestoreGridSavings(DBGridMain);
          WorkStyle:= wsView;
        end
        else
        begin
          LastActPage:= pcMain.ActivePage;
          pcMain.ActivePage:= pcMain.Pages[FCentralPageIndex];
          if LastActPage<>pcMain.ActivePage then
          begin
            WorkStyle:= wsView;
            AllowChange:= true;
            pcMainChanging(pcMain,AllowChange);
            if AllowChange then
            begin
              pcMain.ActivePage:= LastActPage;
              pcMainChange(pcMain);
            end;
          end
          else
          begin
            ControlArea:= pcMain.ActivePage;
            ActiveControl:= nil;
            WorkStyle:= wsView;
          end;
        end;
      end;
    end
  else Result:= inherited OraclePerformance;
  if Result then
  begin
     AccessRights:= TVASUPQuery(dsCurrent.DataSet).AccessLevel;
     if WorkStyle= wsAdd then WorkStyle:= wsView;
     Move(Pointer(Perform(UM_OTHERS,IN_GETACCESS,0))^,
     MDIChildAccessRights,SizeOf(MDIChildAccessRights));
     Application.MainForm.Perform(UM_OTHERS,IN_REFRESH,0);
  end;
end;

function TfmStarTopology.FindActiveGrid(Parent: TWinControl): TRxDBGrid;
var
  I: Integer;
begin
  I:= 0;
  Result:= nil;
  if not Assigned(Parent) then exit;
  while (I<Parent.ControlCount) and not Assigned(Result) do
    if (Parent.Controls[I] is TRxDBGrid) and
       ( (Parent.Controls[I] as TRxDBGrid).DataSource.DataSet=
         dsCurrent.DataSet) then Result:= Parent.Controls[I] as TRxDBGrid
    else Inc(I);
  if not Assigned(Result) then
  begin
    I:= 0;
    while (I<Parent.ControlCount) and not Assigned(Result) do
    begin
      if Parent.Controls[I] is TWinControl then
         Result:= FindActiveGrid(Parent.Controls[I] as TWinControl);
      Inc(I);
    end;
  end;
end;

procedure TfmStarTopology.ChangeCurrentSet(NewDataSet: TDataSet);
begin
  ClearDataCount;
  dsCurrent.DataSet:= NewDataSet;
  AccessRights:= TVASUPQuery(dsCurrent.DataSet).AccessLevel;
  if not dsCurrent.DataSet.Active then
  begin
    RestoreORDERBY(TVASUPQuery(dsCurrent.DataSet));
    RestoreSavings;
    dsCurrent.DataSet.Open;
  end;
  Perform(UM_OTHERS,IN_ACTIVATE,0);
  Perform(UM_OTHERS,IN_STATUS,0);
end;

function TfmStarTopology.GetCentralState:TWStyle;
begin
  Result:= (dsCentre.DataSet as TVASUPQuery).WorkState;
end;

procedure TfmStarTopology.RepaintAllBtn;
begin
  inherited;
  bbView.Visible:= true;
  bbCancel.Visible:= WorkStyle in [wsEdit,wsAdd];
  if IsLyingOn(paTop,ActiveControl) then
     RepaintNaviBtn(dsCentre.DataSet);
end;

procedure TfmStarTopology.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= true;
  if NeedToSave(dsCurrent.DataSet) then
  begin
    CanClose:= false;
    case MessageDlg( Format(CSheetChange,[pcMain.ActivePage.Caption])
                                ,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
      mrYes:
      begin
        dsCurrent.DataSet.Post;
        CanClose:= true;
      end;
      mrNo:
      begin
        dsCurrent.DataSet.Cancel;
        CanClose:= true;
      end
    end;
  end;
end;

procedure TfmStarTopology.ReverseFormats;
var
  J: Integer;

procedure RestoreFormats(DataSet: TDataSet);
var
  I: Integer;
  CurFmt: PNumFmt;
begin
  for I:= 0 to DataSet.FieldCount-1 do
    if (DataSet.Fields[I] is TIntegerField) then
    begin
      CurFmt:= FmtList.FindFmt(DataSet,DataSet.Fields[I].FieldNo);
      if Assigned(CurFmt) then
      with CurFmt^,(DataSet.Fields[I] as TIntegerField) do
      begin
        EditFormat:= EditFmt;
        DisplayFormat:= DisplayFmt;
      end;
    end;
end;

begin
  if Assigned(FmtList) then
  begin
    for J:= 0 to FDataSets.Count-1 do
      RestoreFormats(TDataSet(FDataSets[J]));
    FmtList.Clear;
  end;
end;

procedure TfmStarTopology.CopyFormats;
var
  J: Integer;

procedure SaveFormats(ADataSet:TDataSet);
var
  I: Integer;
  CurFmt: PNumFmt;
begin
  for I:= 0 to ADataSet.FieldCount-1 do
    if (ADataSet.Fields[I] is TIntegerField)
     and not Assigned( FmtList.FindFmt
                       ( ADataSet,
                         ADataSet.Fields[I].FieldNo)) then
    begin
      New(CurFmt);
      with CurFmt^,(ADataSet.Fields[I] as TIntegerField) do
      begin
        ID:= FieldNo;
        EditFmt:= EditFormat;
        DisplayFmt:= DisplayFormat;
        DataSet:= ADataSet;
      end;
      FmtList.Add(CurFmt)
    end;
end;

begin
  if not Assigned(FmtList) then FmtList:= TFmtList.Create
  else FmtList.Clear;
  for J:= 0 to FDataSets.Count-1 do
    SaveFormats(TDataSet(FDataSets[J]));
end;//CopyFormats

procedure TfmStarTopology.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  I: Integer;
begin
  for I:= 0 to pcMain.PageCount-1 do
    with pcMain.Pages[I] do
      if not IsCentre(TDataSet(Tag)) and TDataSet(Tag).Active then
        TDataSet(Tag).Close;
  inherited;
  dsCentre.DataSet.Close;
  {fmMainMenu.vpSaveQuery.Enabled:= false;
  fmMainMenu.vpSaveQueryAs.Enabled:= false;}
  Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYITEMS,0);
end;

procedure TfmStarTopology.FormDestroy(Sender: TObject);
begin
  FDataSets.Free;
  inherited;
end;

var
  GridPageTurning: bool;

procedure TfmStarTopology.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ActiveGrid: TRxDBGrid;
begin
  if  not (ActiveControl is TRxDBGrid) or
      not (WorkStyle in [wsView,wsEdit]) or (Key in [VK_RETURN,VK_F7]) then
  case Key of
    VK_PRIOR,VK_NEXT:if not GridPageTurning then
    begin
      ActiveGrid:= FindActiveGrid(pcMain.ActivePage);
      if Assigned(ActiveGrid) and  ActiveGrid.Enabled then
      begin
        GridPageTurning:= true;
        ActiveGrid.Perform(WM_KEYDOWN,Key,0);
      end;
    end
    else GridPageTurning:= false;
    else inherited;
  end;
end;

procedure TfmStarTopology.paTopEnter(Sender: TObject);
begin
{  if WorkStyle= wsQuery then
     bbPrior.Enabled:= (dsCentre.DataSet as TVASUPQuery).IndexViQuery>0;}
   if not IsCentre(dsCurrent.DataSet) then
   begin
     RepaintNaviBtn(dsCentre.DataSet);
     Application.MainForm.Perform(
       UM_INITIALIZE,IN_SETDATASET,Integer(dsCentre.DataSet));
   end;
end;

procedure TfmStarTopology.pcMainEnter(Sender: TObject);
begin
  {if WorkStyle= wsQuery then
     bbPrior.Enabled:= (dsCurrent.DataSet as TVASUPQuery).IndexViQuery>0;}
  if not IsCentre(dsCurrent.DataSet) then
  begin
    RepaintNaviBtn(dsCurrent.DataSet);
    Application.MainForm.Perform(
       UM_INITIALIZE,IN_SETDATASET,Integer(dsCurrent.DataSet));
  end;
end;

procedure TfmStarTopology.NavigatorClick(_Sender: TObject);
begin
  if WorkStyle= wsQuery then
  begin
    RptQueryId:= 0;
    pcMain.Invalidate;
  end;
  if IsCentre(dsCurrent.DataSet)
     or not IsLyingOn(paTop,ActiveControl) then
  begin
    inherited;
    //if WorkStyle= wsQuery then pcMain.Invalidate;
  end
  else with dsCentre.DataSet as TVASUPQuery do
    case WorkStyle of
      wsAdd:
      begin
        if NoDataInserting(dsCurrent.DataSet) then
           dsCurrent.DataSet.Cancel
        else dsCurrent.DataSet.Post;
        WorkStyle:= wsView;
        if Descander(_Sender,bbPrior) then Prior
        else if Descander(_Sender,bbNext) then Next;
        Application.MainForm.Perform(UM_OTHERS,IN_REFRESH,0);
        ClearDataCount;
        Perform(UM_OTHERS,IN_STATUS,0);
      end;
     wsQuery:
     begin
       //dsCurrent.DataSet.Cancel;
       if Descander(_Sender,bbPrior) then PriorViQuery
       else if Descander(_Sender,bbNext) then NextViQuery;
       if ShowSQLDescriptForm then ShowSQLDescription(dsCentre.DataSet as TVASUPQuery);
       bbPrior.Enabled:= not BOQ;
       {if not dsCurrent.DataSet.Active then dsCurrent.DataSet.Open;
       if dsCurrent.State<> dsInsert then
          dsCurrent.DataSet.Insert;
       (dsCurrent.DataSet as TVASUPQuery).WorkState:= wsQuery;}

     end
     else
     begin
       if Descander(_Sender,bbPrior) then Prior
       else if Descander(_Sender,bbNext) then Next;
       Application.MainForm.Perform(UM_OTHERS,IN_REFRESH,0);
       ClearDataCount;
       Perform(UM_OTHERS,IN_STATUS,0);
     end;
    end;
end;

function TfmStarTopology.IsHintAvailable(Field: TField):bool;
begin
  Result:= Pos('_KOD',Field.FieldName)>0;
end;

function TfmStarTopology.GetTableName(pFieldPack: PFieldPackage): string;
var
  I: Integer;
  C: Char;
begin
  if pFieldPack^.Field.FieldName='MIUPDR_KOD' then
     Result:= 'VKUPDR'
  else
  begin
    Result:= '';
    for I:= Length(pFieldPack^.Field.FieldName) downto 1 do
      Result:= Result+ pFieldPack^.Field.FieldName[I];
    I:= Pos('_',Result);
    Result:= Copy(Result,I+1,Length(Result));
    I:= Pos('_',Result);
    if I>0 then
       Result:= Copy(Result,1,I-1);
    for I:= 1 to Length(Result) div 2 do
    begin
      C:= Result[I];
      Result[I]:= Result[Length(Result)-I+1];
      Result[Length(Result)-I+1]:= C;
    end;
  end;
end;

function TfmStarTopology.IsDecoded(CodeField: TField;var DecodeField: TField):bool;
begin
  DecodeField:= nil;
  Result:= Assigned(DecodeField);
end;

procedure TfmStarTopology.AddAppendixConstr(SQL:TStrings; pFieldPack: PFieldPackage);
begin
end;

function TfmStarTopology.GetFieldHint(pFieldPack: PFieldPackage;var HintMsg:string):bool;
var
  TableName: string;
  HintField: TField;
begin
  Result:= false;
  if IsDecoded(pFieldPack^.Field,HintField) then
  begin
    SeekForward(pFieldPack);
    if not pFieldPack^.Field.IsNull then
    begin
      Result:= true;
      HintMsg:= HintField.AsString;
    end;
    SeekBack(pFieldPack);
  end
  else
  begin
    SeekForward(pFieldPack);
    if not pFieldPack^.Field.IsNull then
      with TOracleQuery.Create(Self) do
      begin
        TableName:= GetTableName(pFieldPack);
        Session:= dmGlobal.seOracle;
        SQL.Text:= Format( 'SELECT PNAIM FROM %s WHERE KOD=:P1',
                           [TableName]);
        DeclareVariable('P1',otInteger);
        SetVariable('P1',pFieldPack^.Field.AsInteger);
        AddAppendixConstr(SQL,pFieldPack);
        try
          Execute;
          Result:= true;
          if not EOF then
            HintMsg:= FieldAsString(0);
          Close;
        finally
          Free;
        end;
      end;
    SeekBack(pFieldPack);
  end;
end;


procedure TfmStarTopology.SeekForward(pFieldPackage: PFieldPackage);
begin
  with pFieldPackage^.Field.DataSet do
  begin
    DisableControls;
    MoveBy(pFieldPackage^.OffSet);
  end;
end;

procedure TfmStarTopology.SeekBack(pFieldPackage: PFieldPackage);
begin
  with pFieldPackage^.Field.DataSet do
  begin
    MoveBy(-pFieldPackage^.OffSet);
    EnableControls;
  end;
end;

procedure TfmStarTopology.GridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  NewCell: TGridCoord;
  HintStr: string;
  HintRect: TRect;
  pFieldPack: PFieldPackage;

begin
  with Sender as TRxDBGrid do
  begin
    NewCell:= MouseCoord(X,Y);
    if (((NewCell.X<>FCell.X) or (NewCell.Y<>FCell.Y)) or not MultiHintWin.HandleAllocated)
       and (DataSource.State in [dsBrowse,dsEdit]) then
    begin
      if MultiHintWin.HandleAllocated then
         MultiHintWin.ReleaseHandle;
      FCell:= NewCell;
      if (NewCell.Y>0) and (NewCell.X>0) and ShowMultiHint
      and Assigned(Columns[NewCell.X-1].Field) and
          IsHintAvailable(Columns[NewCell.X-1].Field) then
      begin
        if ( Columns[NewCell.X-1].Field.Tag
             and CLICKED_FIELDTAG=CLICKED_FIELDTAG) then
        begin
          New(pFieldPack);
          with pFieldPack^ do
          begin
            Field:= Columns[NewCell.X-1].Field;
            OffSet:= NewCell.Y-Row;
          end;
          try
            if GetFieldHint(pFieldPack,HintStr) then
            begin
              Hint:= '|Для отмены расшифровки щелкните по заголовку графы';
              HintRect:= MultiHintWin.CalcHintRect(Application.MainForm.ClientWidth-X,HintStr,nil);
              with HintRect do
              begin
                Left:= Left+X+5;
                Right:= Right+X+5;
                Top:= Top+Y+5;
                Bottom:= Bottom+Y+5;
                TopLeft:= ClientToScreen(TopLeft);
                BottomRight:= ClientToScreen(BottomRight);
              end;
              MultiHintWin.ActivateHint(HintRect,HintStr);
            end;
          finally
            Dispose(pFieldPack);
          end;
        end
        else
          if IsHintAvailable(Columns[NewCell.X-1].Field) then
             Hint:= '|Для расшифровки кода щелкните по заголовку графы'
          else Hint:= '';

      end
      else Hint:= '';
    end;
  end;
end;

procedure TfmStarTopology.GridTitleClick(Column: TColumn);
begin
  if Assigned(Column.Field) then
     with Column.Field do
       if Tag and CLICKED_FIELDTAG<>CLICKED_FIELDTAG then
          Tag:= Tag+CLICKED_FIELDTAG
       else Tag:= Tag-CLICKED_FIELDTAG
end;

procedure TfmStarTopology.RestoreGridSavings(ActiveGrid: TRxDBGrid);
var
  I: Integer;
begin
  if Assigned(ActiveGrid) and
     (ActiveGrid.DataSource.DataSet.Tag and RESTORED_FLAG<>RESTORED_FLAG) then
  begin
    ActiveGrid.Enabled:= false;
    with TRegIniFile.Create(StorageSection+Self.ClassName) do
    begin
      for I:= 0 to ActiveGrid.Columns.Count-1 do
      begin
        ActiveGrid.Columns.Items[I].Width:=
            ReadInteger( ActiveGrid.Name,
                         Format('%s.WIDTH',[ActiveGrid.Columns.Items[I].FieldName])
                       ,ActiveGrid.Columns.Items[I].Width);
        if Assigned(ActiveGrid.Columns[I].Field) then
          with ActiveGrid.Columns[I].Field do
            if Tag and CLICKED_FIELDTAG=CLICKED_FIELDTAG then
             Tag:= Tag-CLICKED_FIELDTAG;
      end;
      Free;
    end;
    ActiveGrid.Enabled:= true;
    ActiveGrid.DataSource.DataSet.Tag:= ActiveGrid.DataSource.DataSet.Tag
                                        + RESTORED_FLAG;
  end;
end;

procedure TfmStarTopology.SaveGridCols(ActiveGrid: TRxDBGrid);
var
  I: Integer;
begin
  FillPropertyList(ActiveGrid.DataSource.DataSet);
  dmGlobal.fsFields.SaveFormPlacement;
  with TRegIniFile.Create(StorageSection+Self.ClassName) do
  begin
    for I:= 0 to ActiveGrid.Columns.Count-1 do
      WriteInteger( ActiveGrid.Name,
                    Format('%s.WIDTH',[ActiveGrid.Columns.Items[I].FieldName])
                    ,ActiveGrid.Columns.Items[I].Width);
    Free;
  end;
  SaveFieldIndexes(ActiveGrid.DataSource.DataSet);
end;

procedure TfmStarTopology.dsCurrentDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if not Assigned(Field) and IsLyingOn(paTop,ActiveControl) then
     RepaintNaviBtn(dsCentre.DataSet);
end;

procedure TfmStarTopology.dsCentreDataChange(Sender: TObject;
  Field: TField);
begin
  if not Assigned(Field) and IsLyingOn(paTop,ActiveControl) then
     RepaintNaviBtn(dsCentre.DataSet);
  if not Assigned(Field) and not IsCentre(dsCurrent.DataSet)
     and (WorkStyle<> wsQuery) then
  begin
    if (WorkStyle<>wsView) and dsCurrent.DataSet.IsEmpty then
       WorkStyle:= wsView; 
    AccessRights:= TVASUPQuery(dsCurrent.DataSet).AccessLevel;
    Move(Pointer(Perform(UM_OTHERS,IN_GETACCESS,0))^,
    MDIChildAccessRights,SizeOf(MDIChildAccessRights));
    Application.MainForm.Perform(UM_OTHERS,IN_REFRESH,0);
  end;
end;

procedure TfmStarTopology.FormActivate(Sender: TObject);
var
  SQItems: Integer;
begin
  inherited;
  SQItems:= 0;
  Inc(SQItems,Integer(not (WorkStyle in [wsNone,wsQuery])));
  Inc(SQItems,Integer( not (WorkStyle in [wsNone,wsQuery]) and (FRptQueryId<>0) )*2);
  {fmMainMenu.vpSaveQuery.Enabled:=
  fmMainMenu.vpSaveQueryAs.Enabled:= not (WorkStyle in [wsNone,wsQuery])
                                     and (FRptQueryId<>0);}
  Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYITEMS,SQItems);
end;

procedure TfmStarTopology.FormDeactivate(Sender: TObject);
begin
  inherited;
  {fmMainMenu.vpSaveQuery.Enabled:= false;
  fmMainMenu.vpSaveQueryAs.Enabled:= false;}
  Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYITEMS,0);
end;

function TfmStarTopology.IsTabQueried(PageIndex: Integer):boolean;
begin
  if PageIndex= tsCentre.PageIndex then Result:= false
  else Result:= not TVASUPQuery(pcMain.Pages[PageIndex].Tag).IsEmptyScreen;
end;

procedure TfmStarTopology.pcMainDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  DC: HDC;
  vRect: TRect;
  PageIndex: Integer;
  OldPen,NewPen: HPen;
begin
  DC:= GetDC(pcMain.Handle);
  SetbkMode(DC,TRANSPARENT);
  SelectObject(DC,pcMain.Font.Handle);
  vRect:= Rect;
  PageIndex:= PageByTabIndex(pcMain,TabIndex);
  if Active then
  begin
    NewPen:= CreatePen(PS_SOLID,4,GetSysColor(Color_BtnFace));
    OldPen:= SelectObject(DC,NewPen);
    Dec(vRect.Bottom,2);
    MoveToEx(DC,vRect.Left,vRect.Bottom,nil);
    LineTo(DC,vRect.Right,vRect.Bottom);
    SelectObject(DC,OldPen);
    DeleteObject(NewPen);
  end;
  if not FQueryCheckOn or (WorkStyle<> wsQuery)
     or not IsTabQueried(PageIndex) then SetTextColor(DC,clBlack)
  else SetTextColor(DC,clRed);
  DrawText( DC, PChar(pcMain.Pages[PageIndex].Caption)
            ,length(pcMain.Pages[PageIndex].Caption)
            ,vRect, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  ReleaseDC(pcMain.Handle, DC);
end;

procedure TfmStarTopology.PrepareNewQuery;
var
  I: Integer;
begin
  FRptQueryId:= 0;
  Caption:= StyleToText(Ws2Msg(wsQuery));
  (*
    for I:= 0 to FDataSets.Count-1 do
      with TVASUPQuery(FDataSets[I])  do
        if (WorkState= wsQuery) and Active then ClearScreen{LastViQuery};
  *)
  (dsCentre.DataSet as TVASUPQuery).LastViQuery;
  if ShowSQLDescriptForm then ShowSQLDescription(dsCentre.DataSet as TVASUPQuery);
  RepaintNaviBtn(dsCurrent.DataSet);
  pcMain.Invalidate;
end;

procedure TfmStarTopology.GetData(ADataSet:TDataSet;STYLEPARAM: Integer);
begin
  inherited GetData(ADataSet,STYLEPARAM);
  if (ADataset<> dsCentre.DataSet)
     and (STYLEPARAM<> IN_QUERY)
     and (ADataSet is TOracleDataSet)
     and (TOracleDataSet(ADataSet).Master=dsCentre.DataSet) then
    inherited GetData(dsCentre.DataSet,IN_VIEW);
end;//GetData

function TfmStarTopology.IsCtrlQueried(Sender: TWinControl):boolean;
var
  I: Integer;
begin
  I:= 0;
  Result:= false;
  while (I<Sender.ControlCount)
        and not Result do
  begin
    if (Sender.Controls[I] is TVQryEdit) then
       Result:= (Sender.Controls[I] as TVQryEdit).QueryState<>piNone;
    Inc(I);
  end;
  I:= 0;
  while (not Result) and (I<Sender.ControlCount) do
  begin
    if Sender.Controls[I] is TWinControl then
        Result:= IsCtrlQueried(TWinControl(Sender.Controls[I]));
    Inc(I);
  end;
end;

procedure TfmStarTopology.UMFASTREPORT(var Message:TMessage);
var
  I: Integer;
begin
  case Message.wParam of
    IN_DEFAULT_DATASET: Message.Result:= Integer(dsCentre.DataSet);
    IN_SAVE_QUERY: Message.Result:= Integer(SaveRptQuery);
    IN_SET_FASTREPORT_ID: RptQueryId:= Message.lParam;
    IN_ENABLE_DATASETS:
      for I:= 0 to DataSets.Count-1 do
        TList(Message.lParam).Add(DataSets[I]);
  end;
end;

procedure TfmStarTopology.ShowSQLDescription;
var
  CurQuery: TVASUPQuery;
  PartialSQLDescription: TTreeSQLDescription;
begin
  if ShowSQLDescriptForm then
  begin
    with dsCentre.DataSet as TVASUPQuery do
      if not IsQuery then
      begin
        FTreeSQLDescription.Clear;
        GetSQLDescription(IndexQuery,FTreeSQLDescription)
      end
      else
      begin
        if Assigned(AQuery) then CurQuery:= AQuery
        else CurQuery:= dsCurrent.DataSet as TVASUPQuery;
         if (FTreeSQLDescription.Count=0) and
          (Length(FTreeSQLDescription.Caption)=0) then
           FTreeSQLDescription.Caption:=
             (dsCentre.DataSet as TVASUPQuery).Caption;
        PartialSQLDescription:= FTreeSQLDescription.FindNodeByQuery(CurQuery);
        PartialSQLDescription.Clear;
        CurQuery.GetSQLDescription(CurQuery.IndexQuery,PartialSQLDescription);
      end;
    fmSQLDescript.ShowSQL(FTreeSQLDescription);
    fmMainMenu.SetFocus;
  end;
end;

initialization
  GridPageTurning:= false;
end.
