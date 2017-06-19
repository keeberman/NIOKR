unit v_explorer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_GRIDFORM,vWORKFORM, Buttons, DBCtrls, Grids, DBGrids, StdCtrls, ExtCtrls, Globals,
  DB,vdbASUP, DBTables, ComCtrls,v_Child,v_anyform,{v_AnyReprt,} v_AnyFRep, Placemnt, RXDBCtrl,
  v_ASUPForm, Variants;

const
  CNoPrintData='Отсутствуют данные для печати';
  CSaveRptCap= 'Запрос "%s"';
  CSaveRptPrompt= 'Сохранить с именем';
  
type
  TFieldPackage= record
    Field: TField;
    OffSet: Integer;
  end;

  PFieldPackage= ^TFieldPackage;

  TfmExplorer = class(TfmGridForm)
    dsWork: TVMetaDataSource;
    fpExplorer: TFormPlacement;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    {Обработчик события OnClose. Подтверждает удаление формы,
    после ее закрытия}

    procedure FormCreate(Sender: TObject);
    //Обработчик события OnCreate

    procedure dsWorkMetaChange(DataSet: TDataSet; const NewIndex: Integer);
    {Обработчик события OnMetaChange компонента dsWork.
    Возникает при смене текущей таблицы в линейном списке
    таблиц компонента dsWork}

    procedure FormDestroy(Sender: TObject);
    //Обработчик события OnDestroy

    procedure dsWorkDataChange(Sender: TObject; Field: TField);
    {Обработчик события OnChange компонента dsWork.
    Обновляет состояние кнопок глобального навигатора главной
    формы приложения fmMainMenu}

    procedure FormActivate(Sender: TObject);
    {Обработчик события OnActivate.
    При наличии формы-редактора (FWorkForm) активизирует ее}

    procedure DBGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dsWorkMetaChanging(DataSet: TDataSet;
      const NewIndex: Integer);
    procedure fpExplorerRestorePlacement(Sender: TObject);
    procedure fpExplorerSavePlacement(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure DBGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure DBGridGetBtnParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; var SortMarker: TSortMarker;
      IsDown: Boolean);
    procedure DBGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridDblClick(Sender: TObject);
    {Обработчик события OnMouseMove сетки DBGrid.
    Используется для отображения подсказок к ячейкам DBGrid}

  private
    { Private declarations }
    FCell: TGridCoord;
    FShowMultiHint: bool;
    FRptQueryId: Integer;
    FCallForm: TCustomForm; //Рабочая форма, вызвавшая данный экземпляр
    FExecedRpt: boolean;
    FCanSaveQuery: bool;
    procedure SetRptQueryId(Value: Integer);
    procedure SaveMajors(RptQueryId: Integer);
    procedure SaveMinors(RptQueryId: Integer);
  protected
    FWorkForm: TForm;//Рабочая форма
    FWorkType: TFormClass;//Указатель на класс рабочей формы
    FReportType: TFormClass;//Указатель на класс формы-контейнера отчета
    FCaption: string;//Хранит превоначальный Caption формы
    FCurMode: Integer;//Текущий режим по UM_CHANGEMODE
    procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;
              {Перехват сообщения UM_CHANGEMODE(смена основного режима).
              Отображает рабочую форму массива (потомок FmWorkForm) в
              соответствующем режиме(запрос,просмотр,добавление и т.д.}

    procedure UMInitialize(var Message:TMessage);message UM_INITIALIZE;
              {Перехват сообщения UM_INITIALIZE(установка dsWork).
              Заполняет данными dsWork}

    procedure UMOTHERS(var Message:TMessage);message UM_OTHERS;
              {Перехват сообщения UM_OTHERS(остальное).
              Служит для обмена инструкциями с панелью
              инструментов главного окна}

    procedure UMFASTREPORT(var Message:TMessage);message UM_FASTREPORT;
              {Перехват сообщения UM_FASTREPORT(списочные отчеты).
              }

    procedure RestoreGridSavings;
              {Восстановление характеристик из системного реестра
              при помощи fpExplorer}

    procedure RefreshDirectList;virtual;
              {Обновление содержимого DropDownMenu кнопки sbDirectList
              главной формы согласно данным из dsWork}

    procedure RefreshNavigator;virtual;
              {Настройка кнопок навигации панели инструментов
              главной формы}

    function GetFieldHint(pFieldPack: PFieldPackage;var HintMsg:string):bool;virtual;
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

    procedure PrintData;
              {Создает форму-контейнер отчета и запускает диалог
              печати отчета}


    function GetMainDataSetOfForm : TDataSet; override;
              // Возвращает главный DataSet окна

    function GetInitASUPQueries : TArrayOfASUPQuery; override;
             // Возвращает ASUPQueries-ы, которые необходимо инициализировать
             // Метод вызывается только в InitASUPQueries
  public
    { Public declarations }
    property ShowMultiHint:bool read FShowMultiHint write FShowMultiHint;
    {В случае TRUE отображает подсказки к ячейкам DBGrid к полям,
    для которых GetFieldHint возвращает TRUE}
    property CallForm: TCustomForm read FCallForm write FCallForm;
    property RptQueryId: Integer read FRptQueryId write SetRptQueryId;
    property CanSaveQuery: bool read FCanSaveQuery write FCanSaveQuery;
    function SaveRptQuery: boolean;
  end;

var
  fmExplorer: TfmExplorer;

implementation

uses MENUGnrl{, v_prnshld, v_prnsh_c}
     ,registry, v_savqmod, v_prndlg,v_prndlgc,oracle;

{$R *.DFM}

procedure TfmExplorer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= CaFree;
  dsWork.Close;
  if FCanSaveQuery then
    Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYITEMS,0);
end;

procedure TfmExplorer.FormCreate(Sender: TObject);
begin
  inherited;
  FdsLocal:= dsWork;
  FCaption:= Caption;
  FCurMode:= IN_NONE;
  DBGrid.Columns.State:= csCustomized;
  FCell.X:=0;
  FCell.Y:=0;
  ShowMultiHint:= false;
end;

procedure TfmExplorer.UMChangeMode;
begin
  inherited;
  case Message.lParam of
    MS_NORMAL:
    begin
      if Message.wParam <> IN_NONE then
      begin
        if not Assigned(FWorkForm) then
        FWorkForm:= FWorkType.Create(Self);
        with FWorkForm  do
        begin
          Perform(UM_INITIALIZE,IN_SETDATASET,Integer(dsWork.DataSet));
          Perform(UM_INITIALIZE,IN_SETCALLBACKWIN,Integer(Self));
          Perform(UM_CHANGEMODE,Message.wParam,MS_NORMAL);
          Show;
        end;
      end;
    end;
    MS_CALLBACK:
    begin
      FCurMode:= Message.wParam;
      dsWork.Enabled:= FCurMode<> IN_QUERY;
    end;
  end;
end;

procedure TfmExplorer.UMInitialize;
begin
  case Message.wParam of
    IN_SETDATASET:
    begin
      dsWork.DataSetList.Clear;
      dsWork.AddToList(TDataSet(Message.lParam));
    end;
    IN_SETDATASETLIST:
    begin
      dsWork.DataSetList.Assign(TDataSets(Message.lParam));
    end;
  end;
  // dsWork.Start;
end;

procedure TfmExplorer.UMOTHERS;
var
  RptName: string;
function ToGridMsg(Value: Integer): Integer;
begin
  if Value= IN_PAGEUP then Result:= VK_PRIOR
  else Result:= VK_NEXT;
end;

begin
  case Message.wParam of
    IN_SORT:if FCurMode in [IN_NONE,IN_VIEW] then
               (dsWork.DataSet as TVASUPQuery).Mixer;
    IN_PRINT:if (FCurMode in [IN_NONE,IN_VIEW]) and (DataCount>0) then
                PrintData
             else MessageDlg(CNoPrintData,mtError,[mbOk],0);
    IN_PAGEUP,IN_PAGEDN: if FCurMode in [IN_NONE,IN_VIEW,IN_EDIT] then
               begin
                 DBGrid.SetFocus;
                 DBGrid.Perform(WM_KEYDOWN,ToGridMsg(Message.wParam),0)
               end;
    IN_PRIOR:  if FCurMode in [IN_NONE,IN_VIEW,IN_EDIT] then
                  dsWork.DataSet.Prior;
    IN_NEXT:   if FCurMode in [IN_NONE,IN_VIEW,IN_EDIT] then
                 dsWork.DataSet.Next;
    IN_ACTIVATE:
    begin
      inherited;
      if dsWork.DataSet is TVASUPQuery then
      begin
        Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
        RefreshDirectList;
        Perform(UM_OTHERS,IN_STATUS,0);
        RefreshNavigator;
      end;
    end;
    IN_CLOSE:
    begin
      FWorkForm:= nil;
      FCurMode:= IN_NONE;
      //DBGrid.Enabled:= true;
      dsWork.Enabled:= true;
      if ShowSQLDescriptForm then ShowSQLDescription;
    end;
    IN_QUIT:Close;
    IN_PRIORLEVEL: if FCurMode in [IN_NONE,IN_VIEW,IN_DELETE,IN_EDIT] then
                      dsWork.Prior;
    IN_NEXTLEVEL:  if FCurMode in [IN_NONE,IN_VIEW,IN_DELETE,IN_EDIT] then
                      dsWork.Next;
    IN_DIRECTMOVE: if FCurMode in [IN_NONE,IN_VIEW,IN_DELETE,IN_EDIT] then
                      dsWork.DirectMove(Message.lParam);
    IN_STORE:
    begin
      inherited;
      fpExplorer.SaveFormPlacement;
    end;
    IN_REFRESH: if FCurMode in [IN_NONE,IN_VIEW,IN_DELETE,IN_EDIT] then inherited;
    IN_SETRECORDCOUNT: DataCount:= Message.LParam;
    IN_EXECQUERY:  if (FCurMode= IN_QUERY) and Assigned(FWorkForm) then
       FWorkForm.Perform(UM_OTHERS,IN_EXECQUERY,0);
    IN_FORMQUERY_REPAINT: if (FCurMode= IN_QUERY) and Assigned(FWorkForm) then
       FWorkForm.Repaint;
    IN_SAVEQUERY: if FCanSaveQuery then
    begin
      dmSaveRptQuery:= TdmSaveRptQuery.Create(Self);
      try
        dmSaveRptQuery.osRptQuery.Open;
        if FRptQueryId<>0 then
        begin
          dmSaveRptQuery.osRptQuery.Locate('ID',FRptQueryId,[]);
          dmSaveRptQuery.osRptQuery.Edit;
        end
        else if dmSaveRptQuery.osRptQuery.State<>dsInsert then
             dmSaveRptQuery.osRptQuery.Insert;
        SaveRptQuery;
        FRptQueryId:= dmSaveRptQuery.osRptQueryID.AsInteger;
      finally
        dmSaveRptQuery.Free;
      end;
    end;
    IN_SAVEQUERYAS: if FCanSaveQuery then
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
                     
procedure TfmExplorer.PrintData;
var
  //RptForm: TfrAnyReport;
  RptForm: TfmAnyFRep;
begin
  {if Assigned(FReportType) then
  begin
    dsWork.DataSet.DisableControls;
    RptForm:= TfrAnyReport(FReportType.Create(Self));
    if not Assigned(RptForm.dsReport.DataSet) then
       RptForm.dsReport.DataSet:= dsWork.DataSet;
    if Length(RptForm.qrMain.ReportTitle)=0 then
       RptForm.qrMain.ReportTitle:= dsWork.DataSet.Name;
    fmPrintShld:= TfmPrintShld.Create(RptForm);
    fmPrintShld.ShowModal;
    RptForm.Free;
    dsWork.DataSet.EnableControls;
  end;}
  if Assigned(FReportType) then
  begin
    dsWork.DataSet.DisableControls;
    RptForm:= TfmAnyFRep(FReportType.Create(Self));
    if not Assigned(RptForm.dsReport.DataSet) then
       RptForm.dsReport.DataSet:= dsWork.DataSet;
    fmPrnDlgCom:= TfmPrnDlgCom.Create(RptForm);
    fmPrnDlgCom.ShowModal;
    RptForm.Free;
    dsWork.DataSet.EnableControls;
  end;
end;

procedure TfmExplorer.RefreshDirectList;
var
  DirectList: TStrings;
  I: Integer;
begin
  DirectList:= TStringList.Create;
  for I:= 0 to dsWork.Count-1 do
    DirectList.Add((dsWork[I] as TVASUPQuery).Caption);
  Application.MainForm.Perform(UM_OTHERS,IN_DIRECTLIST,Integer(DirectList));
  DirectList.Free;
end;

procedure TfmExplorer.RefreshNavigator;
var
  PNavigatorData: PTNavigatorData;
begin
  New(PNavigatorData);
  with PNavigatorData^ do
  begin
    ExploreState:= [];
    with dsWork do begin
      if not BOL then ExploreState:= ExploreState+[ebPrior];
      if not EOL and
      (not DataSet.IsEmpty) then ExploreState:= ExploreState+[ebNext];
      Path:= PathToDataSet('SNAIM');
    end;
  end;
  Application.MainForm.Perform(UM_OTHERS,IN_NAVIGATOR,Integer(PNavigatorData));
  Dispose(PNavigatorData);
end;

procedure TfmExplorer.dsWorkMetaChange(DataSet: TDataSet;
  const NewIndex: Integer);
var
  FLastMode: Integer;
begin
  RestoreGridSavings;
  ClearDataCount;
  FLastMode:= FCurMode;
  if DataSet is TVASUPQuery then
    with DataSet as TVASUPQuery do
    begin
      Self.Caption:= Concat(FCaption,Caption);
      AccessRights:= AccessLevel;
      FWorkType:= EditorClass;
      FReportType:= ReportClass;
      WorkState := wsView;
    end;
  FWorkForm.Free;
  Perform(UM_OTHERS,IN_ACTIVATE,0);
  if FLastMode<>IN_NONE then
     Perform(UM_CHANGEMODE,FLastMode,0);
end;

procedure TfmExplorer.FormDestroy(Sender: TObject);
begin
  Application.MainForm.Perform(UM_OTHERS,IN_CLOSE,0);
  Application.MainForm.Perform(UM_OTHERS,IN_NAVIGATOR,0);
  Application.MainForm.Perform(UM_OTHERS,IN_DIRECTLIST,0);
  inherited;
end;

procedure TfmExplorer.RestoreGridSavings;
begin
  if WindowState=wsNormal then
    fpExplorer.Options:= [fpPosition,fpState]
  else fpExplorer.Options:= [];
  dsWork.DataSet.DisableControls;
  fpExplorer.IniFileName:= StorageSection+dsWork.DataSet.Name;
  fpExplorer.RestoreFormPlacement;
  dsWork.DataSet.EnableControls;
end;

procedure TfmExplorer.dsWorkDataChange(Sender: TObject; Field: TField);
begin
  if not Assigned(Field) and (FCurMode<> IN_QUERY)
     then RefreshNavigator;
end;

procedure TfmExplorer.FormActivate(Sender: TObject);
var
  SQItems: Integer;
begin
  if (dsWork.DataSet is TVASUPQuery) and
     not (Assigned(FWorkForm) and FWorkForm.Visible)then
  // Установить dsWork.DataSet в статус wsView,
  // так как возможно только что были доступны другие формы,
  // а эти формы могли изменить статус у dsWork.DataSet
    TVASUPQuery(dsWork.DataSet).WorkState := wsView;
  inherited;
  if Assigned(FWorkForm) and FWorkForm.Visible then
   SetActiveWindow(FWorkForm.Handle)
  else DBGrid.SetFocus; 
  if FCanSaveQuery then
  begin
    SQItems:= 1;
    //Inc(SQItems,Integer(not (WorkStyle in [wsNone,wsQuery])));
    Inc(SQItems,Integer(FRptQueryId<>0)*2);
    Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYITEMS,SQItems);
  end;
  //if not (Assigned(FWorkForm) and FWorkForm.Visible) then
  // Оправить сообщение UM_CHANGEMODE,
  // так как возможно только что были доступны другие формы,
  // а эти формы могли работать в режимах отличающихся
  // от режима работы у данной формы.
  //  Perform(UM_CHANGEMODE,IN_QUERY,MS_CALLBACK);
end;

function TfmExplorer.IsHintAvailable(Field: TField):bool;
begin
  Result:= false;
end;

function TfmExplorer.GetFieldHint(pFieldPack: PFieldPackage;var HintMsg:string):bool;
begin
  Result:= false;
end;

procedure TfmExplorer.SeekForward(pFieldPackage: PFieldPackage);
begin
  with DBGrid.DataSource.DataSet do
  begin
    DisableControls;
    MoveBy(pFieldPackage^.OffSet);
  end;
end;

procedure TfmExplorer.SeekBack(pFieldPackage: PFieldPackage);
begin
  with DBGrid.DataSource.DataSet do
  begin
    MoveBy(-pFieldPackage^.OffSet);
    EnableControls;
  end;
end;

procedure TfmExplorer.DBGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  NewCell: TGridCoord;
  HintStr: string;
  HintRect: TRect;
  pFieldPack: PFieldPackage;

begin
  NewCell:= DBGrid.MouseCoord(X,Y);
  if (((NewCell.X<>FCell.X) or (NewCell.Y<>FCell.Y)) or not MultiHintWin.HandleAllocated)
     and (DBGrid.DataSource.State= dsBrowse) then
  begin
    if MultiHintWin.HandleAllocated then
       MultiHintWin.ReleaseHandle;
    FCell:= NewCell;
    if (NewCell.Y>0) and (NewCell.X>0) and ShowMultiHint
    and Assigned(DBGrid.Columns[NewCell.X-1].Field) then
    begin
      if ( DBGrid.Columns[NewCell.X-1].Field.Tag
           and CLICKED_FIELDTAG=CLICKED_FIELDTAG) then
      begin
        New(pFieldPack);
        with pFieldPack^ do
        begin
          Field:= DBGrid.Columns[NewCell.X-1].Field;
          OffSet:= NewCell.Y-DBGrid.Row;
        end;
        if GetFieldHint(pFieldPack,HintStr) then
        begin
          DBGrid.Hint:= '|Для отмены расшифровки Ctrl+лев.клав.мыши';
          HintRect:= MultiHintWin.CalcHintRect(Application.MainForm.ClientWidth-X,HintStr,nil);
          with HintRect do
          begin
            Left:= Left+X+5;
            Right:= Right+X+5;
            Top:= Top+Y+5;
            Bottom:= Bottom+Y+5;
            TopLeft:= DBGrid.ClientToScreen(TopLeft);
            BottomRight:= DBGrid.ClientToScreen(BottomRight);
          end;
          MultiHintWin.ActivateHint(HintRect,HintStr);
        end;
        Dispose(pFieldPack);
      end
      else if IsHintAvailable(DBGrid.Columns[NewCell.X-1].Field) then
         DBGrid.Hint:= '|Для расшифровки кода Ctrl+лев.клав.мыши'
         else DBGrid.Hint:= '';
    end
    else DBGrid.Hint:= '';
  end;
end;

procedure TfmExplorer.dsWorkMetaChanging(DataSet: TDataSet;
  const NewIndex: Integer);
begin
  RestoreSavings;
  // Очищаем устаревшие Bookmark-и
  ResetCurrBookmarkOfDataSet;
  // Инициализируем новые ASUPQueries-ы для данной формы
  InitASUPQueries;
end;

procedure TfmExplorer.fpExplorerRestorePlacement(Sender: TObject);
var
  I: Integer;
begin
  with TRegIniFile.Create(StorageSection+dsWork.DataSet.Name) do
  begin
    for I:= 0 to DBGrid.Columns.Count-1 do
    begin
      DBGrid.Columns[I].Width:=
        ReadInteger( DBGrid.Name,Format('%s.WIDTH',[DBGrid.Columns[I].FieldName])
                     ,DBGrid.Columns[I].Width);
      if Assigned(DBGrid.Columns[I].Field) and
         (DBGrid.Columns[I].Field.Tag and CLICKED_FIELDTAG=CLICKED_FIELDTAG) then
         DBGrid.Columns[I].Field.Tag:= DBGrid.Columns[I].Field.Tag-CLICKED_FIELDTAG;
    end;
    Free;
  end;
end;

procedure TfmExplorer.fpExplorerSavePlacement(Sender: TObject);
var
  I: Integer;
begin
  with TRegIniFile.Create(StorageSection+dsWork.DataSet.Name) do
  begin
    for I:= 0 to DBGrid.Columns.Count-1 do
      WriteInteger( DBGrid.Name,Format('%s.WIDTH',[DBGrid.Columns[I].FieldName])
                    ,DBGrid.Columns[I].Width);
    Free;
  end;
end;

procedure TfmExplorer.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[ssCtrl]) then
    case Key of
      VK_LEFT: Application.MainForm.Perform(UM_OTHERS,IN_PRIORLEVEL,MS_NORMAL);
      VK_RIGHT: Application.MainForm.Perform(UM_OTHERS,IN_NEXTLEVEL,MS_NORMAL);
    end;
end;

procedure TfmExplorer.SetRptQueryId(Value: Integer);
begin
  FRptQueryId:= Value;
  FExecedRpt:= false;
end;

procedure TfmExplorer.SaveMinors(RptQueryId: Integer);
begin
  with dmSaveRptQuery.quNewMinors do
  begin
    SetVariable('RptId', RptQueryId);
    SetVariable('OrderText', TVASUPQuery(dsWork.DataSet).Order);
    SetVariable('MainTable', TVASUPQuery(dsWork.DataSet).UpdatingTable);
    Execute;
  end;
end;

procedure TfmExplorer.SaveMajors(RptQueryId: Integer);

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
          SetVariable('Description', Blocks[J].Comment);
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
  if GlobalIndex>= 0 then
    with HostObj.LinkedQueryList.Nodes[GlobalIndex] do
    begin
      AddOneQObj(HostObj,SelfIndex);
      for I:= 0 to Count-1 do
        AddObjWithChildren(Nodes[I].Obj,Nodes[I].Index);
    end;
end;

begin
  AddObjWithChildren ( TVASUPQuery(dsWork.DataSet),
                       TVASUPQuery(dsWork.DataSet).IndexQuery)
end;

function TfmExplorer.SaveRptQuery;
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
      end;
    finally
      ActivateKeyboardLayOut(LastKL,0);
    end;
  end;
  {RptWin:= GetChildWindow(fmMainMenu,fmMainMenu.vpOpenQuery);
  if Assigned(RptWin) then RptWin.Perform(UM_OTHERS,IN_REFRESH,0);}
  Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYWIN,0);
end;

procedure TfmExplorer.FormDeactivate(Sender: TObject);
begin
  inherited;
  if FCanSaveQuery then
    Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYITEMS,0);
end;

procedure TfmExplorer.UMFASTREPORT(var Message:TMessage);
begin
  case Message.wParam of
    IN_DEFAULT_DATASET: Message.Result:= Integer(dsWork.DataSet);
    IN_SAVE_QUERY: Message.Result:= Integer(SaveRptQuery);
    IN_SET_FASTREPORT_ID: RptQueryId:= Message.lParam;
  end;
end;

procedure TfmExplorer.DBGridTitleBtnClick(Sender: TObject; ACol: Integer;
  Field: TField);
var
  curQuery: TVASUPQuery;
  SortFieldName: string;
  NewTag: Integer;
  I: Integer;
begin
  if DBGrid.DataSource.DataSet is TVASUPQuery then
  begin
    curQuery:= DBGrid.DataSource.DataSet as TVASUPQuery;
    if Length(Field.Origin)>0 then
      SortFieldName:= Field.Origin
    else SortFieldName:= Field.FieldName;
    if Field.Tag and SORT_ASC_FIELDTAG= SORT_ASC_FIELDTAG then
       NewTag:= (Field.Tag xor SORT_ASC_FIELDTAG) or SORT_DESC_FIELDTAG
    else if Field.Tag and SORT_DESC_FIELDTAG= SORT_DESC_FIELDTAG then
      NewTag:= Field.Tag xor SORT_DESC_FIELDTAG
    else NewTag:= Field.Tag or SORT_ASC_FIELDTAG;
    if NewTag and SORT_ASC_FIELDTAG= SORT_ASC_FIELDTAG then
      curQuery.Order:= SortFieldName+' ASC'
    else if NewTag and SORT_DESC_FIELDTAG= SORT_DESC_FIELDTAG then
      curQuery.Order:= SortFieldName+' DESC'
    else curQuery.Order:= '';
    Field.Tag:= NewTag;
    curQuery.Execute;
  end;
end;

procedure TfmExplorer.DBGridGetBtnParams(Sender: TObject; Field: TField;
  AFont: TFont; var Background: TColor; var SortMarker: TSortMarker;
  IsDown: Boolean);
begin
 if Field.Tag and SORT_ASC_FIELDTAG= SORT_ASC_FIELDTAG then
    SortMarker:= smUp
  else if Field.Tag and SORT_DESC_FIELDTAG= SORT_DESC_FIELDTAG then
    SortMarker:= smDown;
end;

procedure TfmExplorer.DBGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
 var
  GridCoord: TGridCoord;
begin
  if (Button=mbLeft) and (Shift=[ssCtrl,ssLeft ]) then
  begin
    GridCoord:= DBGrid.MouseCoord(X,Y);
     with DBGrid.Columns[GridCoord.X-1].Field do
       Tag:= Tag xor CLICKED_FIELDTAG;
  end;
end;

procedure TfmExplorer.DBGridDblClick(Sender: TObject);
begin
  Perform(UM_CHANGEMODE,IN_VIEW,MS_NORMAL);
end;

function TfmExplorer.GetMainDataSetOfForm : TDataSet;
begin
  Result := dsWork.DataSet;
end;

function TfmExplorer.GetInitASUPQueries : TArrayOfASUPQuery;
begin
  if dsWork.DataSet is TVASUPQuery then
  begin
    SetLength(Result, 1);
    Result[0] := TVASUPQuery(dsWork.DataSet);
  end
  else
    SetLength(Result, 0);
end;

end.
