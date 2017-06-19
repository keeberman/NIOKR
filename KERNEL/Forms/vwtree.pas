unit vwtree;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vworkform, vDbASUP, Menus, Db, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  ComCtrls, ImgList,v_explorer, RXDBCtrl, v_AnyForm, TB97, TB97Tlbr, TB97Ctls,
  oracledata, v_Child, v_ASUPForm, ComObj, Variants;

const
  CNodeChange= 'На закладке %s имеются несохраненные изменения. Сохранить?';
  CPageTitle1= 'Анкета';
  CPageTitle2= 'Анкета №%d';
  CPageTitle3 = '%s №%d';
  CResetTreeOrder= 'Вы уверены, что собираетесь восстановить '+
                   'стандартный порядок элементов ?'#13#10+
                   'Указанная сортировка произойдет после перезапуска программы.';
  SDefaultDecodePackageName= 'DECODE_UTIL';
  INIT_VAL= -1;

  // Button Kind Flags
  BK_MINOR_EXECUTE= $0001;
  BK_MAJOR_EXECUTE= $0002;
  BK_PRINT= $0004;

  // Master Panel Kind Flags
  MPK_SIPMLE_PANEL = $0001;

type
  TKeyList= class(TList)
              destructor Destroy;override;
              procedure Clear;
              function IndexOfField(AField: TField): Integer;
              function AddList(AField: TField; Keys: Array of TField): Integer;
            end;

  TfmTreeTopology = class(TfmWorkForm)
    Splitter: TSplitter;
    imlState: TImageList;
    paControl: TPanel;
    pcMain: TPageControl;
    tsList: TTabSheet;
    DBGrid: TRxDBGrid;
    pmTree: TPopupMenu;
    vpAutoHide: TMenuItem;
    vpSeparat: TMenuItem;
    vpHideTree: TMenuItem;
    paExplorer: TPanel;
    TreeView: TTreeView;
    paProc: TPanel;
    spExplorer: TSplitter;
    sboxTools: TScrollBox;
    Dock97: TDock97;
    Toolbar97: TToolbar97;
    vpSeparat2: TMenuItem;
    vpSaveTreeItemOrder: TMenuItem;
    vpResetTreeItemOrder: TMenuItem;
    dsActive: TDataSource;
    tmTreeView: TTimer;
    bbXLS: TSpeedButton;
    procedure GridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TreeViewChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ModeSwitchPopup(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    function IsCtrlQueried(Sender: TWinControl):boolean;
    procedure TreeViewEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pcMainEnter(Sender: TObject);
    procedure paMasterEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pcAdditionDrawTab(Control: TCustomTabControl;
                TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure vpAutoHideClick(Sender: TObject);
    procedure TreeViewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vpHideTreeClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TreeViewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure paProcResize(Sender: TObject);
    procedure Dock97RequestDock(Sender: TObject; Bar: TCustomToolWindow97;
      var Accept: Boolean);
    procedure ToolBarButtonClick(Sender:TObject);
    procedure FormActivate(Sender: TObject);
    procedure TreeViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure vpSaveTreeItemOrderClick(Sender: TObject);
    procedure vpResetTreeItemOrderClick(Sender: TObject);
    procedure dsActiveDataChange(Sender: TObject; Field: TField);
    procedure tmTreeViewTimer(Sender: TObject);
    procedure DBGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure DBGridGetBtnParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; var SortMarker: TSortMarker;
      IsDown: Boolean);
    procedure DBGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pcMainContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure bbXLSClick(Sender: TObject);
  private
    { Private declarations }
    FVertex: TVASUPQuery;
    FCell: TGridCoord;
    FShowMultiHint: bool;
    FMainCaption: string;
    FActivePages: TList; // Активные страницы на pcMain
    FMasterPanels: TStrings; //Панели с мастер-строками
    FMasterSets: TList;//DataSet'ы панелей с мастер-строками
    FMasterSources: TList;//DataSource'ы панелей с мастер-строками
    FMasterTags: TList;//Tag'ы панелей с мастер-строками
    FRptQueryId: Integer;
    FExecedRpt: boolean;
    FPreviousNode: TTreeNode;
    FTreeWidth: Integer;
    FNonQueryNodes: TList;
    FIniSortType: TSortType;
    FCurSortType: TSortType;
    FDecPackName: string;
    FDecPack: Pointer;
    FKeyList: TKeyList;
    FDownCancel : boolean;

    FActivePagesOfNodes : TStrings;
    {Активные страницы на pcMain для узлов дерева}

    FScrolling : boolean;
    // Курсор сейчас перемещаются


    function FixChanges(DataSet: TDataSet):boolean;
    procedure AddDetails(MasterNode: TTreeNode; MasterTable: TVASUPQuery);
    procedure SetVertex(Value: TVASUPQuery);
    function StyleToText(Message:TMessage) : string;override;
    procedure OpenTreeViSession(ANode: TTreeNode); overload;
    procedure OpenTreeViSession; overload;
    procedure OpenTreeViSession(DataSet: TDataSet); overload;
    procedure CloseTreeViSession; overload;
    procedure CloseTreeViSession(DataSet: TDataSet); overload;
    //procedure GetDatasIN_WSVIEW;
    procedure SaveMajors(RptQueryId: Integer);
    procedure SaveMinors(RptQueryId: Integer);
    procedure SetRptQueryId(Value: Integer);
    procedure CloseAllViSession;
    procedure CloseAllDataSets;
    procedure TreeCrossing(ANode: TTreeNode=nil);
    procedure FreeButtonList;
    procedure RepaintToolBarButtons;
    procedure RepaintRecordCount(Sender: TObject; Field: TField);
    procedure MasterSourceInit(Sender: TObject);
    procedure AddKeyValues(AField: TField);
    procedure CancelDataSets;
  protected
    // Связка для функций для GetFieldHint
    procedure UMOTHERS(var Message:TMessage);message UM_OTHERS;
              {Перехват сообщения UM_OTHERS(остальное).
              Служит для обмена инструкциями с панелью
              инструментов главного окна}
    procedure UMFASTREPORT(var Message:TMessage);message UM_FASTREPORT;
              {Перехват сообщения UM_FASTREPORT(списочные отчеты).}
    function IsDecoded(CodeField: TField;var DecodeField: TField):bool;virtual;
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

    procedure ChangeCurrentSet(NewDataSet: TDataSet);virtual;

    procedure RestoreGridSavings(ADBGrid: TDBGrid;
                                 const AlwaysResizeColWidth: boolean= false);

    procedure SaveGridCols(ADBGrid: TDBGrid=nil); virtual;

    procedure ResetSavedState;

    function GetMasterPanel(Page: TTabSheet): TCustomPanel;virtual;

    procedure NavigatorClick(_Sender: TObject);override;

    procedure GetData(ADataSet:TDataSet;STYLEPARAM: Integer);override;

    function OraclePerformance:boolean;override;

    procedure RepaintAllBtn;override;

    procedure RepaintTreeQueryState;

    function  PageByTabIndex( APageControl:TPageControl;
                                TabIndex: Integer): Integer;

    procedure RefreshNavigator;

    procedure HideTreeView;
    procedure TuneTreeViewWidth;
    procedure RefreshLine(DataSet: TOracleDataSet);
    function GetNodeLongName(TreeNode: TTreeNode):string;
    property NonQueryNodes: TList read FNonQueryNodes;
    function GetButtonKind(tlbButton: TToolBarButton97):Word;virtual;
    procedure ChangeMasterPanels( ForceUpdate:boolean=false;
                                  MaxLevel: Integer=-1);
    function  GetRelevantButton(const Flag:Word):TToolBarButton97;
    procedure ChangeActivePages;virtual;
    function FindAreaDataSet(Area: TWinControl):TDataSet;virtual;

    //function ApplyPageUpdates:boolean;virtual;
    procedure SetFormMode;virtual;
    procedure ActivateDataSet(ADataSet: TDataSet);virtual;
    procedure ChangeWorkStyle(var Message:TMessage);override;
    procedure DenyAccess;virtual;
    procedure SetAccess; virtual;
    procedure SpecifyToolBtnState;
    procedure ShowSQLDescription(AQuery:TVASUPQuery = nil);override;
    procedure ResizeMasterPanel(AOwner : TWinControl; AMasterPanel : TCustomPanel; ATag : Integer); virtual;
    //   Пересчитывает размеры мастер панели
    function NeedToSave(DataSet:TDataSet):bool;override;
    function GetQuestionAtSaving : String; override;

    function GetMainDataSetOfForm : TDataSet; override;
              // Возвращает главный DataSet окна

    function GetInitASUPQueries : TArrayOfASUPQuery; override;
              // Возвращает ASUPQueries-ы, которые необходимо инициализировать
              // Метод вызывается только в InitASUPQueries

    procedure AddActivePageOfNode(ATabSheet : TTabSheet; ANode : TVASUPQuery);
    { Добовляет активную страницу узла в список
      ATabSheet - активная страница узла на pcMain
      ANode     - DataSet узла дерева
    }

    procedure ClearActivePagesOfNodes;
    { Очищает список активных страниц узлов дерева
    }

    procedure SetActivePageOfNode;
    { Устанавливает активную страницу на pcMain,
      которая указана, как активная страница текущего узла дерева
      в списке активных страниц узлов дерева
    }

    procedure ApplyActivePageOfNodeSettings(FPrevNode : TDataSet = nil);
    { Определяет, есть ли необходимо установить активную страницу на pcMain,
      которая указана, как активная страница текущего узла дерева
      в списке активных страниц узлов дерева.
      Если есть необходимость, то устанавливает её.
      FPrevNode - TDataSet предыдущего узла дерева
    }

    {procedure SaveData; override; }
              {Метод сохраняет изменения данных формы в Oracle}
    {procedure CancelData; override; }
              {Метод отменяет изменения данных формы}

    procedure ChangeActivePageOnChangeMode(newMode : TWStyle); virtual;
    { Метод вызывается только в UMChangeMode,
      больше его ни где нельзя вызывать.
      Определяет, какая должна быть активная страница на pcMain
    }
  public
    { Public declarations }
    property Vertex: TVASUPQuery read FVertex write SetVertex;
    property ShowMultiHint:bool read FShowMultiHint write FShowMultiHint;
    {В случае TRUE отображает подсказки к ячейкам DBGrid к полям,
    для которых GetFieldHint возвращает TRUE}
    property RptQueryId: Integer read FRptQueryId write SetRptQueryId;
    procedure ResizeMasterPanels;
    // Пересчитывает размеры мастер панелей
    procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;
    function SaveRptQuery: boolean;
    procedure SetNodes4Button(Btn:TToolbarButton97;Lst: Array of TVASUPQuery;
                              RequiredLevel: TAccessLevel = alHost);
     // RequiredLevel должен входить как подмножество в AccessLevel
    // первого элемента списка Lst
    property DecodePackageName:string read FDecPackName write FDecPackName;
    procedure ReorderTreeView;
    procedure RestoreTreeViewOrder;
    procedure RestoreForm;virtual;
    procedure SaveForm;virtual;
    procedure SelectNode(AQueryNode: TVASUPQuery);
    procedure SetKeyFields(CodeField: TField; KeyList: Array of TField);

    procedure DoBeforeScroll(ASUPQuery: TVASUPQuery); override;
            // Метод вызывается объектом класса TVASUPQuery,
            // Когда курсор в ASUPQuery начинает перемещаться на другую запись

    procedure DoAfterScroll(ASUPQuery: TVASUPQuery); override;
            // Метод вызывается объектом класса TVASUPQuery,
            // Когда курсор в ASUPQuery переместился на другую запись
  end;

var
  fmTreeTopology: TfmTreeTopology;

function GetNodeByDataSet(ATreeView: TTreeView;ADataSet: TVASUPQuery):TTreeNode;

implementation
uses oracle,MenuGnrl,globals,registry, TypInfo, v_savqmod, Math, v_sqldesc;
{$R *.DFM}

destructor TKeyList.Destroy;
begin
  Clear;
  inherited;
end;

procedure TKeyList.Clear;
var
  I: Integer;
begin
  for I:= 0 to Count-1 do
  begin
    TList(Items[I]).Clear;
    TList(Items[I]).Free;
  end;
  inherited;
end;

function TKeyList.IndexOfField(AField: TField):Integer;
var
  I: Integer;
begin
  Result:= -1;
  I:= 0;
  while (Result<0) and (I<Count) do
    if TList(Items[I]).Items[0]=AField then
      Result:= I
    else Inc(I);
end;

function TKeyList.AddList(AField: TField; Keys: Array of TField): Integer;
var
  NewList: TList;
  I: Integer;
begin
  Result:= IndexOfField(AField);
  if Result<0 then
  begin
    NewList:= TList.Create;
    NewList.Add(AField);
    for I:= Low(Keys) to High(Keys) do
      NewList.Add(Keys[I]);
    Result:= Add(NewList);
  end
  else
  with TList(Items[Result]) do
  begin
    Clear;
    Add(AField);
    for I:= Low(Keys) to High(Keys) do Add(Keys[I]);
  end;
end;

function GetNodeByDataSet(ATreeView: TTreeView;ADataSet: TVASUPQuery):TTreeNode;
var
  I: Integer;
begin
  I:= 0;
  Result:= nil;
  while (I<ATreeView.Items.Count) and not Assigned(Result) do
    if ATreeView.Items[I].Data=ADataSet then
      Result:= ATreeView.Items[I]
    else Inc(I);
end;

function GetDataSource(AControl: TWinControl):TDataSource;
var
  I: Integer;
  PropInfo: PPropInfo;
begin
  with AControl do
  begin
    I:= 0;
    Result:= nil;
    while (I<ControlCount) and not Assigned(Result) do
    begin
      if (Controls[I] is TWinControl) then
      begin
        PropInfo:= GetPropInfo(Controls[I].ClassInfo,'DataSource');
        if Assigned(PropInfo) then
          Result:= TDataSource(GetOrdProp(Controls[I],PropInfo));
        if not Assigned(Result) then
          Result:= GetDataSource(Controls[I] as TWinControl)
      end;
      Inc(I);
    end;
  end;
end;
{procedure SetLongActive(DataSet: TOracleDataSet; const Value: boolean;
                        MasterStop: TOracleDataSet);
begin
  if Assigned(DataSet.Master)
     and (DataSet.Master<>MasterStop)then
  begin
    if not Value then DataSet.Active:= Value;
    SetLongActive(DataSet.Master,Value,MasterStop);
  end;
  if Value then DataSet.Active:= Value;
end;}

procedure TfmTreeTopology.AddDetails(MasterNode: TTreeNode;
                                     MasterTable: TVASUPQuery);
var
  DetailNode: TTreeNode;
  DetailTable: TVASUPQuery;
  I: Integer;
begin
  for I:= 0 to MasterTable.Owner.ComponentCount-1 do
    if MasterTable.Owner.Components[I] is TVASUPQuery then
    begin
      DetailTable:= (MasterTable.Owner.Components[I] as TVASUPQuery);
      if DetailTable.AccessLevel<>[] then
        with DetailTable do
          if Master= MasterTable then
          begin
            DetailNode:= TreeView.Items.AddChildObject(MasterNode,Caption,
                           DetailTable);
            if LinkDetailSQL then AddDetails(DetailNode,DetailTable);
          end;
    end;

end;

{function TfmTreeTopology.GetNodeByDataSet(ADataSet: TVASUPQuery):TTreeNode;
var
  I: Integer;
begin
  I:= 0;
  Result:= nil;
  while (I<TreeView.Items.Count) and not Assigned(Result) do
    if TreeView.Items[I].Data=ADataSet then
      Result:= TreeView.Items[I]
    else Inc(I);
end;}

procedure TfmTreeTopology.SetVertex(Value: TVASUPQuery);
var
  NewNode: TTreeNode;
begin
  dsCurrent.DataSet:= Value;
  FVertex:= Value;
  with TreeView do
  begin
    Items.Clear;
    Items.BeginUpdate;
    NewNode:= Items.AddObject(nil,Value.Caption,Value);
    AddDetails(NewNode,Value);
    Items.EndUpdate;
    FPreviousNode:= Items.GetFirstNode;
    Items.GetFirstNode.Selected:= True;
  end;
  // Сброс у DataSet-ов, старых Bookmark-ов
  ResetCurrBookmarkOfDataSet;

  // Инициализируем новые ASUPQueries-ы для данной формы
  InitASUPQueries;
end;

procedure TfmTreeTopology.SetKeyFields(CodeField: TField; KeyList: Array of TField);
begin
  FKeyList.AddList(CodeField,KeyList);
end;

function TfmTreeTopology.IsHintAvailable(Field: TField):bool;
begin
  Result:= Pos('_KOD',Field.FieldName)>0;
end;

function TfmTreeTopology.IsDecoded(CodeField: TField;var DecodeField: TField):bool;
begin
  DecodeField:= nil;
  Result:= Assigned(DecodeField);
end;

procedure TfmTreeTopology.AddKeyValues(AField: TField);
var
  idx: Integer;
  I: Integer;
begin
  idx:= FKeyList.IndexOfField(AField);
  if idx>=0 then
  with TList(FKeyList[idx]) do
    for I:= 1 to Count-1 do
      with TOraclePackage(FDecPack) do
        CallProcedure('AddKeyValue',[TField(Items[I]).Value]);
end;

function TfmTreeTopology.GetFieldHint(pFieldPack: PFieldPackage;var HintMsg:string):bool;
var
  DataSet: TOracleDataSet;
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
    begin
      DataSet:= pFieldPack^.Field.DataSet as TOracleDataSet;
      if not Assigned(FDecPack) then
      begin
        FDecPack:= TOraclePackage.Create(Self);
        TOraclePackage(FDecPack).Session:= DataSet.Session;
        TOraclePackage(FDecPack).PackageName:= FDecPackName;
      end;
      with TOraclePackage(FDecPack) do
      begin
        CallProcedure('begindecode',ParNone);
        AddKeyValues(pFieldPack^.Field);
        CallProcedure('decodeval',
          [pFieldPack^.Field.FieldName,
           DataSet.UpdatingTable,
           pFieldPack^.Field.Value,
           HintMsg]);
        HintMsg:= GetParameter(3);
        CallProcedure('enddecode',ParNone);
        Result:= Length(HintMsg)>0;
      end;
    end;
    SeekBack(pFieldPack);
  end;
end;


procedure TfmTreeTopology.SeekForward(pFieldPackage: PFieldPackage);
begin
  with pFieldPackage^.Field.DataSet do
  begin
    DisableControls;
    MoveBy(pFieldPackage^.OffSet);
  end;
end;

procedure TfmTreeTopology.SeekBack(pFieldPackage: PFieldPackage);
begin
  with pFieldPackage^.Field.DataSet do
  begin
    MoveBy(-pFieldPackage^.OffSet);
    EnableControls;
  end;
end;

procedure TfmTreeTopology.GridMouseMove(Sender: TObject; Shift: TShiftState;
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
              Hint:= '|Для отмены расшифровки Ctrl+лев.клав.мыши';
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
             Hint:= '|Для расшифровки кода Ctrl+лев.клав.мыши'
          else Hint:= '';

      end
      else Hint:= '';
    end;
  end;
end;

function TfmTreeTopology.NeedToSave(DataSet:TDataSet):bool;
var
  I: Integer;
begin
  if (WorkStyle <> wsQuery) and (DataSet.State = dsInsert) and (Vertex=DataSet) then
    Result := true
  else
    Result := inherited NeedToSave(DataSet);
end;

function TfmTreeTopology.GetQuestionAtSaving : String;
begin
  Result := Format(CNodeChange,[GetNodeLongName(TreeView.Selected)]);
end;

{function TfmTreeTopology.ApplyPageUpdates:boolean;
var
  select : Word;
begin
  Result:= true;
  if NeedToSave(dsCurrent.DataSet) then
  begin
    Result:= false;

    if Saved = sOther then
    begin
      select := MessageDlg( GetQuestionAtSaving
                           ,mtConfirmation,[mbYes, mbYesToAll, mbNo, mbNoToAll, mbCancel],0);
      case select of
        mrYesToAll : Saved := sYes;
        mrNoToAll  : Saved := sNo;
      end;
    end
    else
      select := mrCancel;

    if (Saved = sYes) or (select = mrYes) then
      try
        dsCurrent.DataSet.Post;
        Result:= true;
      except
        on E:Exception do
        begin
          MessageDlg(E.Message,mtError,[mbOk],0);
          Result:= false;
        end;
      end
    else if (Saved = sNo) or (select = mrNo) then
    begin
        dsCurrent.DataSet.Cancel;
        Result:= true;
    end;
  end;
end;}

procedure TfmTreeTopology.TreeViewChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  AllowChange := true;
  try
    if not (WorkStyle in [wsQuery, wsNone]) then
    begin
      if Assigned(ActiveControl) then
      begin
        ActiveControl.Perform(CM_EXIT,0,0);
        ActiveControl.Perform(CM_ENTER,0,0);
      end;
      dsCurrent.DataSet.CheckBrowseMode; // переключаем на режим просмотра
    end;
     { if NeedToSave(dsCurrent.DataSet) then
      begin
        AllowChange:= false;
        case MessageDlg( Format(CNodeChange,[GetNodeLongName(TreeView.Selected)])
                          ,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
          mrYes:
          try
            dsCurrent.DataSet.Post;
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
            dsCurrent.DataSet.Cancel;
            AllowChange:= true;
          end
        end;
      end;}
    if (FNonQueryNodes.IndexOf(Node.Data)>=0) and (WorkStyle= wsQuery) then
      AllowChange:= False;
    if AllowChange and Assigned(TreeView.Selected) then
       FPreviousNode:= TreeView.Selected;
  except
    on ECursorCanNotMoveAboutRecord do AllowChange := false; {Запрещено переходить на другую закладку}
  end;
end;

procedure TfmTreeTopology.TreeCrossing;
var
  lOld,lNew: TList;
  I,Idx: Integer;
  do_rollback: boolean;

procedure GetPath(Start: TTreeNode;path: TList);
var
  CurNode: TTreeNode;
begin
  CurNode:= Start;
  while Assigned(CurNode) do
  begin
    Path.Add(CurNode);
    CurNode:= CurNode.Parent;
  end;
end;

begin
  lOld:= TList.Create;
  lNew:= TList.Create;
  GetPath(FPreviousNode,lOld);
  GetPath(TreeView.Selected,lNew);
  I:= 0;
  Idx:= lNew.IndexOf(lOld[I]);
  do_rollback:= (I<lOld.Count) and (Idx<0);
  while (I<lOld.Count) and (Idx<0) do
  begin
    TVASUPQuery(TTreeNode(lOld[I]).Data).Close;
    Inc(I);
    if I<lOld.Count then
      Idx:= lNew.IndexOf(lOld[I]);
  end;
  for I:= lNew.Count-1 downto 0 do
    if not TVASUPQuery(TTreeNode(lNew[I]).Data).Active then
      //TVASUPQuery(TTreeNode(lNew[I]).Data).Execute;
        TVASUPQuery(TTreeNode(lNew[I]).Data).Open;
  lOld.Free;
  lNew.Free;
  if do_rollback then Vertex.Session.Rollback;
end;

procedure TfmTreeTopology.ChangeCurrentSet(NewDataSet: TDataSet);
var
  OldDataSet: TDataSet;
begin
  ClearDataCount;
  OldDataSet:= dsCurrent.DataSet;
  {if WorkSyle<>wsQuery then
  SetLongActive(TOracleDataSet(OldDataSet),False);}
  dsCurrent.DataSet:= NewDataSet;
  if not dsCurrent.DataSet.Active then
  begin
    RestoreORDERBY(TVASUPQuery(dsCurrent.DataSet));
    RestoreSavings;
    //SetLongActive(TOracleDataSet(dsCurrent.DataSet),True,nil);
  end;
  if WorkStyle<>wsQuery then TreeCrossing
  else OpenTreeViSession(GetNodeByDataSet(TreeView,TVASUPQuery(dsCurrent.DataSet)));
 { if Vertex.IsQuery then
    AccessRights:= [aqQuerying]
  else
    with dsCurrent.DataSet as TVASUPQuery do
    begin
      if Assigned(Master) and (Master.State=dsBrowse)
         and Master.IsEmpty then
        AccessRights:= AccessLevel - [aqEditing,aqInserting]
      else AccessRights:= AccessLevel;
    end; }
  {if OldDataSet<>NewDataSet then
    Perform(UM_OTHERS,IN_ACTIVATE,0);
  Perform(UM_OTHERS,IN_STATUS,0);}
  DenyAccess;
end;

procedure TfmTreeTopology.RestoreGridSavings(ADBGrid: TDBGrid;
                const AlwaysResizeColWidth: boolean= false);
var
  I: Integer;
begin
  if not Assigned(ADBGrid) then
    exit;
  with ADBGrid do
    if (DataSource.DataSet.Tag and RESTORED_FLAG<>RESTORED_FLAG) or AlwaysResizeColWidth then
    begin
      Enabled:= false;
      with TRegistry.Create do
      begin
        if OpenKey(StorageSection+Self.ClassName+'\'+Name+DataSource.DataSet.Name, True) then
        begin
          for I:= 0 to Columns.Count-1 do
          begin
            if ValueExists(Format('%s.WIDTH',[Columns.Items[I].FieldName])) then
              Columns.Items[I].Width :=
                StrToIntDef(ReadString(Format('%s.WIDTH',[Columns.Items[I].FieldName])),
                  Columns.Items[I].Width)
            else
              WriteString(Format('%s.WIDTH',[Columns.Items[I].FieldName]), IntToStr(Columns.Items[I].Width));
            if Assigned(Columns[I].Field) then
              with Columns[I].Field do
                if Tag and CLICKED_FIELDTAG=CLICKED_FIELDTAG then
                 Tag:= Tag-CLICKED_FIELDTAG;
          end;
          if OpenKey(TreeView.Name, False) then
          begin
            if ValueExists('WIDTH') then TreeView.Width := StrToIntDef(ReadString('WIDTH'), TreeView.Width);
            if ValueExists('AUTOHIDE') then vpAutoHide.Checked := ReadBool('AUTOHIDE');
          end;
        end;
        Free;
      end;

 {
      with TRegIniFile.Create(StorageSection+Self.ClassName) do
      begin
        if not KeyExists(Name+DataSource.DataSet.Name) then
        begin  // Чтобы было всегда
           CreateKey(Name+DataSource.DataSet.Name);
           for I:= 0 to Columns.Count-1 do
           begin
              WriteInteger( Name+DataSource.DataSet.Name, Format('%s.WIDTH',[Columns.Items[I].FieldName])
                   ,Columns.Items[I].Width);
           end;
        end else
        for I:= 0 to Columns.Count-1 do
        begin
          Columns.Items[I].Width:=
              ReadInteger( Name+DataSource.DataSet.Name,
                           Format('%s.WIDTH',[Columns.Items[I].FieldName])
                         ,Columns.Items[I].Width);
          if Assigned(Columns[I].Field) then
            with Columns[I].Field do
              if Tag and CLICKED_FIELDTAG=CLICKED_FIELDTAG then
               Tag:= Tag-CLICKED_FIELDTAG;
        end;
        ReadInteger( TreeView.Name,'WIDTH',TreeView.Width);
        ReadBool( TreeView.Name,'AUTOHIDE',vpAutoHide.Checked);
        Free;
      end;
}
      Enabled:= true;
      if not AlwaysResizeColWidth
         and(DataSource.DataSet.Tag and RESTORED_FLAG<>RESTORED_FLAG) then
      DataSource.DataSet.Tag:= DataSource.DataSet.Tag
                                        + RESTORED_FLAG;
    end;
end;


procedure TfmTreeTopology.SaveForm;
begin
  with TRegIniFile.Create(StorageSection+ClassName) do
  begin
    WriteInteger( TreeView.Name,'WIDTH',TreeView.Width);
    WriteBool( TreeView.Name,'AUTOHIDE',vpAutoHide.Checked);
    Free;
  end;
end;

procedure TfmTreeTopology.RestoreForm;
begin
  with TRegIniFile.Create(StorageSection+ClassName) do
  begin
    paExplorer.Width:= ReadInteger( TreeView.Name,'WIDTH',TreeView.Width);
    if paExplorer.Width>Splitter.MinSize then
      FTreeWidth:= paExplorer.Width;
    vpAutoHide.Checked:= ReadBool( TreeView.Name,'AUTOHIDE',vpAutoHide.Checked);
    paExplorer.Tag:= Integer(vpAutoHide.Checked);
    Free;
  end;
end;

procedure TfmTreeTopology.SaveGridCols;
var
  I: Integer;
  _DBGrid: TDBGrid;
begin
  FillPropertyList(dsCurrent.DataSet);
  dmGlobal.fsFields.SaveFormPlacement;
  if ADBGrid=nil then
    _DBGrid:= DBGrid
  else _DBGrid:= ADBGrid;
  with TRegIniFile.Create(StorageSection+Self.ClassName) do
  begin
    for I:= 0 to _DBGrid.Columns.Count-1 do
      WriteInteger( _DBGrid.Name+dsCurrent.DataSet.Name,
                    Format('%s.WIDTH',[_DBGrid.Columns.Items[I].FieldName])
                    ,_DBGrid.Columns.Items[I].Width);
    Free;
  end;
  SaveFieldIndexes(_DBGrid.DataSource.DataSet);
end;

procedure TfmTreeTopology.ResetSavedState;
begin
  with TRegIniFile.Create(StorageSection) do
  begin
    EraseSection(Self.ClassName);
    Free;
  end;
end;

procedure TfmTreeTopology.DenyAccess;
begin
   if Vertex.IsQuery then
  begin
    if dsCurrent.DataSet=Vertex then
      AccessRights:= [aqQuerying,aqInserting]*Vertex.AccessLevel
    else AccessRights:= [aqQuerying];

  end
  else
    with dsCurrent.DataSet as TVASUPQuery do
    begin
      if Assigned(Master) and (Master.State=dsBrowse)
         and Master.IsEmpty then
        AccessRights:= AccessLevel - [aqEditing,aqInserting]
      else AccessRights:= AccessLevel;

      if WorkStyle = wsAdd then
        AccessRights := AccessRights - [aqInserting,aqEditing,aqDeleting]
      else if WorkStyle = wsEdit then
        AccessRights := AccessRights - [aqEditing]

    end;

  SetAccess;
  if dsCurrent.DataSet is TVASUPQuery then
    AccessRights := AccessRights*TVASUPQuery(dsCurrent.DataSet).AccessLevel;
  //AccessRights := AccessRights*Vertex.AccessLevel;
  SpecifyToolBtnState;
  SetPopItems;

  if Application.MainForm.ActiveMDIChild=Self then
      Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
    Perform(UM_OTHERS,IN_STATUS,0);
end;

procedure TfmTreeTopology.SetAccess;
begin
end;

procedure TfmTreeTopology.SetFormMode;
var
  NewStyle: TWStyle;
begin
  if dsCurrent.DataSet=Vertex then
  begin
    WorkStyle:= (dsCurrent.DataSet as TVASUPQuery).WorkState;
    if WorkStyle= wsEdit then
       GetData(dsCurrent.DataSet,IN_EDIT);
    //SetActCtrl;
    RepaintAllBtn;
  end
  else
  begin
    if (dsCurrent.DataSet<>Vertex)
       and Vertex.IsEmpty then NewStyle:= wsView
    else
      if dsCurrent.DataSet.RecordCount=0 then
      begin
        //AccessRights:= AccessRights*[aqInserting,aqQuerying{,aqPrinting}];
        NewStyle:= wsView;
      end
      else NewStyle:= wsView;
    {if NewStyle<> WorkStyle then }WorkStyle:= NewStyle
    //else RepaintAllBtn;
  end;
end;

procedure TfmTreeTopology.ActivateDataSet(ADataSet: TDataSet);
var
  PrevActDataSet : TDataSet;
begin
  // Запоминаем, какая активная страница на pcMain у предыдущего узла дерева
  if (dsCurrent.DataSet is TVASUPQuery) and (dsCurrent.DataSet <> ADataSet) then
    AddActivePageOfNode(pcMain.ActivePage, TVASUPQuery(dsCurrent.DataSet));
  // Запоминаем предедущий текущий DataSet
  PrevActDataSet := dsCurrent.DataSet;

  // Изменяет текущий DataSet
  ChangeCurrentSet(ADataSet);
  ChangeActivePages;

  // Если необходимо, то устанавливаем активную страницу на pcMain,
  // которая указана для текущего узла  дерева
  // в списке активных страниц узлов дерева
  if dsCurrent.DataSet <> PrevActDataSet then
    ApplyActivePageOfNodeSettings(PrevActDataSet);

  RestoreGridSavings(DBGrid, True); {LAP: всегда из реестра}
  ChangeMasterPanels;
  ActiveControl:= nil;
  ControlArea:= pcMain.ActivePage;
  if not Vertex.IsQuery then SetFormMode;
  Caption:= StyleToText(Ws2Msg(WorkStyle));
  RepaintTreeQueryState;
  RefreshNavigator;
  RepaintToolBarButtons;
end;

procedure TfmTreeTopology.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  ActivateDataSet(TDataSet(Node.Data));
end;

procedure TfmTreeTopology.SpecifyToolBtnState;
begin
  with TfmMainMenu(Application.MainForm) do
  begin
    {sbSort.Enabled:= WorkStyle in [wsEdit,wsView,wsDelete];
    vpSort.Enabled:= sbSort.Enabled;}
    sbRefresh.Enabled:= WorkStyle in [wsEdit,wsView,wsDelete];
    vpRefresh.Enabled:= sbRefresh.Enabled;
  end;
end;

function TfmTreeTopology.GetNodeLongName(TreeNode: TTreeNode):string;
begin
  if not Assigned(TreeNode.Parent) then
    Result:= '\'+TreeNode.Text
  else Result:= '';
  while Assigned(TreeNode.Parent) do
  begin
    Result:= '\'+TreeNode.Text+Result;
    TreeNode:= TreeNode.Parent;
  end;
  Result:=FMainCaption+Result;
end;

function TfmTreeTopology.StyleToText(Message:TMessage) : string;
begin
  Result:= Format('%s:\%s',[ inherited StyleToText(Message),
                  GetNodeLongName(TreeView.Selected)]);
end;

function TfmTreeTopology.FindAreaDataSet(Area: TWinControl):TDataSet;
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

procedure TfmTreeTopology.TuneTreeViewWidth;
begin
  if GetSystemMetrics(SM_CXFULLSCREEN)<=Design_FullScreen_width then
  begin
    FTreeWidth:= paExplorer.Width;
    paExplorer.Width:= Splitter.MinSize;
    vpAutoHide.Checked:= True;
    paExplorer.Tag:= Integer(vpAutoHide.Checked);
  end;
end;

procedure TfmTreeTopology.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  FActivePagesOfNodes := TStringList.Create;
  FScrolling := false;
  inherited;
  FMainCaption:= Caption;
  for I:= pcMain.PageCount-1 downto 1 do
  begin
    pcMain.Pages[I].TabVisible:= False;
    pcMain.Pages[I].Tag:= Integer(FindAreaDataSet(pcMain.Pages[I]));
    //if (pcMain.Pages[I].Tag<>0) and
    //   (TObject(pcMain.Pages[I].Tag) is TVASUPQuery) then
    //  InitASUPQuery(TObject(pcMain.Pages[I].Tag) as TVASUPQuery);
  end;
  tsList.TabVisible:= False;
  FActivePages:= TList.Create;
  FMasterPanels:= TStringList.Create;
  FMasterSets:= TList.Create;
  FMasterTags := TList.Create;
  FMasterSources:= TList.Create;
  FNonQueryNodes:= TList.Create;
  TuneTreeViewWidth;
  FIniSortType:= TreeView.SortType;
  FCurSortType:= FIniSortType;
  FDecPackName:= SDefaultDecodePackageName;
  FDecPack:= nil;
  FKeyList:= TKeyList.Create;
  FDownCancel := false;
end;

procedure TfmTreeTopology.FormShow(Sender: TObject);
begin
  inherited;
  RestoreORDERBY(Vertex);
  RestoreSavings;
  RestoreTreeViewOrder;
  RestoreForm;
  dsCurrent.DataSet.Open;
  if dsCurrent.DataSet.IsEmpty then WorkStyle:= wsQuery
  else WorkStyle:= wsView;
  TreeView.FullExpand;
end;

procedure TfmTreeTopology.ChangeActivePages;
var
  I: Integer;
begin
  for I:= 0 to FActivePages.Count-1 do
    TTabSheet(FActivePages[I]).TabVisible:= False;
  FActivePages.Clear;
  for I:= 1 to pcMain.PageCount-1 do
    if TDataSet(pcMain.Pages[I].Tag)=dsCurrent.DataSet then
      FActivePages.Add(pcMain.Pages[I]);
  for I:= 0 to FActivePages.Count-1 do
  begin
    if FActivePages.Count>1 then
    begin
      if Length(TTabSheet(FActivePages[I]).Caption)=0 then
        TTabSheet(FActivePages[I]).Caption:= Format(CPageTitle2,[I+1])
    end
    else TTabSheet(FActivePages[I]).Caption:= CPageTitle1;
    TTabSheet(FActivePages[I]).TabVisible:= True;
  end;
  pcMain.ActivePage:= tsList;
  if (dsCurrent.DataSet.RecordCount<=1) or (WorkStyle=wsQuery) then
    pcMain.SelectNextPage(True);
end;

procedure TfmTreeTopology.FormDestroy(Sender: TObject);
var
  I : Integer;
begin
  inherited;
  FActivePages.Free;
  FMasterPanels.Free;
  FMasterSets.Free;
  FMasterSources.Free;
  FNonQueryNodes.Free;

  for I := FMasterTags.Count - 1 downto 0 do
    FreeMem(FMasterTags[I]);
  FMasterTags.Free;

  FKeyList.Free;
  FreeButtonList;
  Application.MainForm.Perform(UM_OTHERS,IN_NAVIGATOR,0);
  Application.MainForm.Perform(UM_OTHERS,IN_TREEMENU,0);

  FActivePagesOfNodes.Destroy;
end;

procedure TfmTreeTopology.ModeSwitchPopup(Sender: TObject);
var
  CurWorkState: TWStyle;
begin
 CurWorkState:= Vertex.WorkState;
  with (Application.MainForm as TfmMainMenu),(Sender as TPopUpMenu) do
    if (CurWorkState in [wsQuery,wsDelete,wsAdd])
       and (dsCurrent.DataSet<>Vertex) then
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

procedure TfmTreeTopology.ChangeMasterPanels( ForceUpdate:boolean=false;
                                  MaxLevel: Integer=-1);
var
  I,J: Integer;
  CurNode: TTreeNode;
  mPanel: TCustomPanel;
  MasterPanel: TWinControl;
  temp: TWinControl;
  MasterGrid: TRxDBGrid;
  FNewMasterPanels: TStrings;
  FNewMasterSets: TList;
  FNewMasterSources: TList;
  FNewMasterTags: TList;
  Idx: Integer;
  P : ^Integer;
  WindHeight : Integer;
function CreateSource(AOwner: TWinControl; ADataSet: TDataSet):TDataSource;
begin
  Result:= TDataSource.Create(AOwner);
  with Result do
  begin
    OnDataChange:= RepaintRecordCount;
    OnStateChange:= MasterSourceInit;
    DataSet:= ADataSet;
  end;
end;

procedure DeleteMasterPanel(m_ix: Integer);
var
  j: Integer;
begin
  for j:= FMasterPanels.Count-1 downto  m_ix+1 do
    with FMasterPanels.Objects[j] as TCustomPanel do
    begin
      temp:= Parent;
      Visible:= true;
      //paMaster.Height:= paMaster.Height - temp.Height;
      //Восстановление первоначального Parent'a
      Parent:= TWinControl(Tag);
      TabOrder:= 0;
      temp.Free;
      FMasterPanels.Delete(j);
      FMasterSets.Delete(j);
      FMasterSources.Delete(j);
      Tag := Integer((FMasterTags[j])^);
      FreeMem(FMasterTags[j]);
      FMasterTags.Delete(j);
    end;
end;

begin
  // Запоминаем высоту формы
  // иногда в этом методе происходит ошибка, и форма изменяет высоту,
  // в результате чего, на экране не видно кнопок: применить, выход идр
  // Чтобы этого не было, запоминаем в начале метода высоту формы,
  // а в конце метода присваиваем высоту формы,
  // которую запомнили
  WindHeight := Self.Height;


  FNewMasterPanels:= TStringList.Create;
  FNewMasterSets:= TList.Create;
  FNewMasterSources:= TList.Create;
  FNewMasterTags:= TList.Create;
  CurNode:= TreeView.Selected;
  if MaxLevel>=0 then
    while CurNode.Level>MaxLevel do
      CurNode:= CurNode.Parent;
  Idx:= -1;
  if ForceUpdate then
    DeleteMasterPanel(Idx);
  while Assigned(CurNode.Parent) and (Idx=-1) do
  begin
    mPanel:= nil;
    I:= 1;
    if not ForceUpdate then
      Idx:= FMasterSets.IndexOf(CurNode.Parent.Data);
    if Idx=-1 then
      while (I<pcMain.PageCount) and not Assigned(mPanel) do
      begin
        if pcMain.Pages[I].Tag= Integer(CurNode.Parent.Data) then
          mPanel:= GetMasterPanel(pcMain.Pages[I]);
        Inc(I);
      end;
    if Idx>=0 then
      DeleteMasterPanel(Idx)
    else
      if Assigned(mPanel) then
      begin
        GetMem(P, SizeOf(Integer));
        P^ := mPanel.Tag;
        FNewMasterTags.Insert(0,P);
        mPanel.Tag:= Integer(mPanel.Parent);
        FNewMasterPanels.InsertObject(0,CurNode.Parent.Text,mPanel);
        FNewMasterSets.Insert(0,CurNode.Parent.Data);
      end;
    CurNode:= CurNode.Parent;
  end;
  if Idx=-1 then
  begin
    for I:= FMasterPanels.Count-1 downto 0 do
    with FMasterPanels.Objects[I] as TCustomPanel do
    begin
      temp:= Parent;
      Visible:= True;
      //Восстановление первоначального Parent'a
      Parent:= TWinControl(Tag);
      TabOrder:= 0;
      temp.Free;
      Tag := Integer(FMasterTags[I]^);
      FreeMem(FMasterTags[I]);
    end;
    FMasterPanels.Clear;
    FMasterSets.Clear;
    FMasterSources.Clear;
    FMasterTags.Clear;
    //if FNewMasterPanels.Count>0 then paMaster.Height:= 5
    //else paMaster.Height:= 0;
  end;

  // Замена грида на панель в режиме запроса
  for I:= FMasterPanels.Count-1 downto 0 do
    with FMasterPanels.Objects[I] as TCustomPanel do
      if not Visible and TVASUPQuery(FMasterSets[I]).IsQuery then
      begin
        for J:= Parent.ControlCount-1 downto 0 do
          if Parent.Controls[J] is TRxDBGrid then
            Parent.Controls[J].Free;
        //paMaster.Height:= paMaster.Height - Parent.Height + Height + 20;
        {if (Integer(FMasterTags[I]^) and MPK_SIPMLE_PANEL) = 0 then
          Parent.Height:= Height + 20
        else
          Parent.Height:= Height;}
        Visible:= true;
      end;

  for I:= 0 to FNewMasterPanels.Count-1 do
  with FNewMasterPanels.Objects[I] as TCustomPanel do
  begin
    if (Integer(FNewMasterTags[I]^) and MPK_SIPMLE_PANEL) <> MPK_SIPMLE_PANEL then
    begin
      MasterPanel:=TGroupBox.Create(Self);
      TGroupBox(MasterPanel).Caption:= FNewMasterPanels[I];
      TGroupBox(MasterPanel).OnEnter:= paMasterEnter;//paMaster.OnEnter;
    end
    else
    begin
      MasterPanel := TPanel.Create(Self);
      TPanel(MasterPanel).OnEnter:= paMasterEnter;//paMaster.OnEnter;
      TPanel(MasterPanel).BevelOuter := bvNone;
    end;

    //GroupBox.Top:= paMaster.Height;
    if I > 0 then
      MasterPanel.Top := TControl(TDataSource(FNewMasterSources[I-1]).Owner).Top + TControl(TDataSource(FNewMasterSources[I-1]).Owner).Height
    else if FMasterSources.Count > 0 then
      MasterPanel.Top := TControl(TDataSource(FMasterSources[FMasterSources.Count-1]).Owner).Top +
                         TControl(TDataSource(FMasterSources[FMasterSources.Count-1]).Owner).Height
    else
      MasterPanel.Top := 0;
    MasterPanel.Align := alTop;
    MasterPanel.Parent := paControl;//paMaster;
    Parent:= MasterPanel;
    FNewMasterSources.Add(CreateSource(MasterPanel,FNewMasterSets[I]));

    if (WorkStyle<>wsQuery) and (TVASUPQuery(FNewMasterSets[I]).DisplayRowCount>1) then
    begin
      Visible:= false;
      MasterGrid:= TRxDBGrid.Create(MasterPanel);
      with MasterGrid do
      begin
        DataSource:= TDataSource(FNewMasterSources[I]);
        Font.Assign(DBGrid.Font);
        TitleFont.Assign(DBGrid.TitleFont);
        OnGetCellParams:= DBGrid.OnGetCellParams;
        Options:= DBGrid.Options;
        if (Integer(FNewMasterTags[I]^) and MPK_SIPMLE_PANEL) <> MPK_SIPMLE_PANEL then
          MasterPanel.Height:= 2*abs(Font.Height)*(TVASUPQuery(FNewMasterSets[I]).DisplayRowCount+1)+20
        else
          MasterPanel.Height:= 2*abs(Font.Height)*(TVASUPQuery(FNewMasterSets[I]).DisplayRowCount+1);
        Parent:= MasterPanel;
        Align:= alClient;
      end;
      RestoreGridSavings(MasterGrid);
    end;

    //FNewMasterSources.Add(CreateSource(GroupBox,FNewMasterSets[I]));
    {if (WorkStyle=wsQuery) or (TVASUPQuery(FNewMasterSets[I]).DisplayRowCount=1) then
    begin
      if (Integer(FNewMasterTags[I]^) and MPK_SIPMLE_PANEL) = 0 then
        MasterPanel.Height:= Height+20
      else
        MasterPanel.Height:= Height;
    end
    else
    begin
      Visible:= false;
      MasterGrid:= TRxDBGrid.Create(MasterPanel);
      with MasterGrid do
      begin
        DataSource:= TDataSource(FNewMasterSources[I]);
        Font.Assign(DBGrid.Font);
        TitleFont.Assign(DBGrid.TitleFont);
        OnGetCellParams:= DBGrid.OnGetCellParams;
        Options:= DBGrid.Options;
        if (Integer(FNewMasterTags[I]^) and MPK_SIPMLE_PANEL) = 0 then
          MasterPanel.Height:= 2*abs(Font.Height)*(TVASUPQuery(FNewMasterSets[I]).DisplayRowCount+1)+20
        else
          MasterPanel.Height:= 2*abs(Font.Height)*(TVASUPQuery(FNewMasterSets[I]).DisplayRowCount+1);
        Parent:= MasterPanel;
        Align:= alClient;
      end;
      RestoreGridSavings(MasterGrid);
    end;   }
    //paMaster.Height:= paMaster.Height + GroupBox.Height;
  end;
  for I:= 0 to FNewMasterPanels.Count-1 do
  begin
    FMasterPanels.AddObject(FNewMasterPanels[I],
                                FNewMasterPanels.Objects[I]);
    FMasterSets.Add(FNewMasterSets[I]);
    FMasterSources.Add(FNewMasterSources[I]);
    FMasterTags.Add(FNewMasterTags[I]);
  end;
  FNewMasterPanels.Free;
  FNewMasterSets.Free;
  FNewMasterSources.Free;
  FNewMasterTags.Free;

  ResizeMasterPanels;

  // Возвращаем высоту формы, которая была в начале метода!!!
  // иногда в этом методе происходит ошибка, и форма изменяет высоту,
  // в результате чего, на экране не видно кнопок: применить, выход идр
  // Чтобы этого не было, запоминаем в начале метода высоту формы,
  // а в конце метода присваиваем высоту формы,
  // которую запомнили
  Self.Height := WindHeight;
end;

function TfmTreeTopology.GetMasterPanel(Page: TTabSheet): TCustomPanel;
var
  I: Integer;
begin
  Result:= nil;
  I:= 0;
  while (I<Page.ControlCount) and not Assigned(Result) do
  begin
    if (Page.Controls[I] is TCustomPanel)
        and ((Page.Controls[I] as TCustomPanel).Align= alTop) then
      Result:= Page.Controls[I] as TCustomPanel;
    Inc(I);
  end;
end;

procedure TfmTreeTopology.RepaintAllBtn;
var
  MasterSource: TDataSource;
  PropInfo: PPropInfo;
  Laid : boolean;
  I : Integer;
begin
  MasterSource := nil;
  PropInfo := nil;
  bbCancel.Visible:= WorkStyle in [wsEdit,wsAdd];
  bbView.Visible:= not bbCancel.Visible;
  Laid := false;
  I := 0;
  while (I < FMasterPanels.Count) and (not Laid) do
  begin
    Laid := IsLyingOn(TControl(FMasterPanels.Objects[I]).Parent,ActiveControl);
    Inc(I);
  end;
  //if IsLyingOn(paMaster,ActiveControl) then
  if Laid then
  begin
    PropInfo:= GetPropInfo(ActiveControl.ClassInfo,'DataSource');
    if Assigned(PropInfo) then
      MasterSource:= TDataSource(GetOrdProp(ActiveControl,PropInfo));
    if Assigned(MasterSource) then
    begin
      //RepaintNaviBtn(MasterSource.DataSet);
      FdsNavi:= MasterSource;
      dsActive.DataSet:= MasterSource.DataSet;
    end;
  end
  else
  begin
    FdsNavi:= dsCurrent;
    dsActive.DataSet:= dsCurrent.DataSet;
  end;
  Application.MainForm.Perform(
       UM_OTHERS,IN_DATANAVIGATOR,Integer(FdsNavi.DataSet)
       );
  inherited;
end;

procedure TfmTreeTopology.NavigatorClick(_Sender: TObject);
var
  MasterTable: TVASUPQuery;
  PropInfo: PPropInfo;
  Laid : boolean;
  I : Integer;
begin
  try
    I := 0;
    Laid := false;
    while (I < FMasterPanels.Count) and (not Laid) do
    begin
      Laid := IsLyingOn(TControl(FMasterPanels.Objects[I]).Parent,ActiveControl);
      Inc(I);
    end;
    if (dsCurrent.DataSet=Vertex)
       or not Laid then
       //not IsLyingOn(paMaster,ActiveControl) then
       inherited
  {  begin
      inherited;
      if WorkStyle= wsQuery then pcMain.Invalidate;
    end }
    else
    begin
      PropInfo:= GetPropInfo(ActiveControl.ClassInfo,'DataSource');
      if Assigned(PropInfo) then
        MasterTable:= TVASUPQuery(TDataSource(GetOrdProp(
                            ActiveControl,PropInfo)).DataSet);
      if Assigned(MasterTable) then
      begin
        with MasterTable do
          case WorkStyle of
            wsAdd:
              begin
                //if not ApplyPageUpdates then
              //  Exit;
                //WorkStyle:= wsView;
                if Descander(_Sender,bbPrior) then Prior
                else if Descander(_Sender,bbNext) then Next;
                Application.MainForm.Perform(UM_OTHERS,IN_REFRESH,0);
                ClearDataCount;
                Perform(UM_OTHERS,IN_STATUS,0);
              end;
            wsQuery:
              begin
                if Descander(_Sender,bbPrior) then PriorViQuery
                else if Descander(_Sender,bbNext) then NextViQuery;
{                if not Assigned(fdsNavi) then RepaintNaviBtn(dsCurrent.DataSet)
                else RepaintNaviBtn(FdsNavi.DataSet);}
              end
              else
              begin
                //if not ApplyPageUpdates then
             //   Exit;
                if Descander(_Sender,bbPrior) then Prior
                else if Descander(_Sender,bbNext) then Next;
                Application.MainForm.Perform(UM_OTHERS,IN_REFRESH,0);
                ClearDataCount;
                Perform(UM_OTHERS,IN_STATUS,0);
                {if not Assigned(fdsNavi) then RepaintNaviBtn(dsCurrent.DataSet)
                else RepaintNaviBtn(FdsNavi.DataSet);}
              end;
          end
      end
      else inherited;
    end;
    if WorkStyle= wsQuery then
    begin
      RptQueryId:= 0;
      RepaintTreeQueryState;
    end;
    if not Assigned(fdsNavi) then RepaintNaviBtn(dsCurrent.DataSet)
    else RepaintNaviBtn(FdsNavi.DataSet);
  except
    on ECursorCanNotMoveAboutRecord do; // Пропускаем ошибку ECursorCanNotMoveAboutRecord
                                        // Эта ошибка возникает за того,
                                        // что запрещено перемещаться по записям
  end;
end;

procedure TfmTreeTopology.OpenTreeViSession;
begin
  OpenTreeViSession(TreeView.Selected);
end;

procedure TfmTreeTopology.OpenTreeViSession(ANode: TTreeNode);
var
  NodeList: TList;
  I: Integer;
begin
  NodeList:= TList.Create;
  while Assigned(ANode) do
  begin
    NodeList.Add(ANode);
    ANode:= ANode.Parent;
  end;
  for I:= NodeList.Count-1 downto 0 do
    OpenTreeViSession(TDataSet(TTreeNode(NodeList[I]).Data));
  NodeList.Free;
end;

procedure TfmTreeTopology.OpenTreeViSession(DataSet: TDataSet);
begin
  with DataSet as TVASUPQuery do
  begin
    if ReadOnly then
      Exit;
     {if Assigned(Master) then
      OpenTreeViSession(Master);}
    if not IsQuery then
    begin
      //WorkSpace:= Self;
      GetData(DataSet,IN_QUERY);
      WorkState := wsQuery;
    end;
  end;
end;

procedure TfmTreeTopology.ChangeWorkStyle(var Message:TMessage);
var
  SQItems: Integer;
begin
  inherited;
  DenyAccess;
  if vpAutoHide.Checked then HideTreeView;
  RepaintToolBarButtons;
  SQItems:= 0;
  Inc(SQItems,Integer(not (WorkStyle in [wsNone,wsQuery])));
  Inc(SQItems,Integer( not (WorkStyle in [wsNone,wsQuery]) and (FRptQueryId<>0) )*2);
  Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYITEMS,SQItems);
end;

procedure TfmTreeTopology.UMChangeMode(var Message:TMessage);
begin
  try
    if Message.wParam in [IN_QUERY, IN_VIEW, IN_INSERT, IN_EDIT] then
    begin
      if (workStyle IN [wsAdd, wsEdit]) and not FDownCancel then
      begin
        if Assigned(ActiveControl) then
        begin
          ActiveControl.Perform(CM_EXIT,0,0);
          ActiveControl.Perform(CM_ENTER,0,0);
        end;
        {для срабатывания события OnExit
         у компонентов TQueryEdit}

        //if not ApplyPageUpdates then
        //  Exit;
        {if not ((dsCurrent.DataSet is TVASUPQuery)  and
                (Message.wParam = IN_EDIT) and
                (TVASUPQuery(dsCurrent.DataSet).WorkState = wsEdit)) then}
          try
          dsCurrent.DataSet.CheckBrowseMode; // переключаем на режим просмотра
          except
            raise;
          end;
        //
      end;
    end;


    if Message.wParam IN [IN_INSERT, IN_EDIT] then
    begin
      CancelDataSets;
      if workStyle = wsQuery then
        CloseTreeViSession;
    end;

    FDownCancel := false;

    if Message.wParam=IN_QUERY then
    begin
      dsCurrent.DataSet.DisableControls;
      (*if (dsCurrent.State in [dsEdit,dsInsert])
          {and (WorkStyle<>wsQuery)}  then*)
      CancelDataSets;

      CloseTreeViSession;
      if WorkStyle=wsQuery then
      begin
        //WorkStyle:= wsNone;
        RepaintTreeQueryState;
      end;
      ClearDataCount;
      ChangeMasterPanels;
      dsCurrent.DataSet.EnableControls;
      OpenTreeViSession;
    end
    else
      RepaintTreeQueryState;

    ChangeActivePageOnChangeMode(Msg2Ws(Message.wParam));
    ControlArea:= pcMain.ActivePage;

    if ((WorkStyle in [wsQuery, wsNone]) and (Message.wParam<>IN_QUERY) and
                                            (Message.wParam<>IN_NONE))
       // При переключении с режима Query в другой режим
       or //или
       ((WorkStyle <> wsQuery) and (Message.wParam=IN_QUERY))
       // При переключении в режим Query
    then
      //должна происходить очистка активных страниц на pcMain узлов дерева
      ClearActivePagesOfNodes;

    //if Message.wParam=IN_VIEW then
    //  GetDatasIN_WSVIEW;

    inherited;
  except
    on ECursorCanNotMoveAboutRecord do; // Пропускаем ошибку ECursorCanNotMoveAboutRecord
                                        // Эта ошибка возникает за того,
                                        // что запрещено перемещаться по записям
  end;
end;

procedure TfmTreeTopology.GetData(ADataSet:TDataSet;STYLEPARAM: Integer);
var
  MasterStyle: Integer;
begin
  inherited GetData(ADataSet,STYLEPARAM);
  {if STYLEPARAM <> IN_QUERY then MasterStyle:= IN_VIEW
  else MasterStyle:= IN_QUERY;
  with ADataSet as TVASUPQuery do
    if Assigned(Master) and
       ((Master as TVASUPQuery).WorkState<>Msg2Ws(MasterStyle))
    then GetData(Master,MasterStyle);}
end;//GetData

function TfmTreeTopology.OraclePerformance:boolean;
var
  LastActPage: TTabSheet;
  AllowChange: boolean;
  ActiveNode: TTreeNode;
  ActiveDataSet : TDataSet;
begin
  if WorkStyle= wsQuery then
    with Vertex do
    begin
      ActiveDataSet := dsCurrent.DataSet;
      if ActiveDataSet <> Vertex then
        ChangeCurrentSet(Vertex);
      //ActiveNode:= TreeView.Selected;
      //TreeView.Items.GetFirstNode.Selected:= True;
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
        CloseTreeViSession;
        if ActiveDataSet <> Vertex then
          ChangeCurrentSet(ActiveDataSet)
        else
          OpenTreeViSession;
        MessageBeep(0);
        MessageDlg(EmptyQueryDataMsg,mtWarning,[mbOk],0);
        Result:= false;
        LinkedQueryList.Seek(IndexQuery);
        //LastViQuery;
        RepaintTreeQueryState;
        if ShowSQLDescriptForm then ShowSQLDescription(Vertex);
        DeleteQuery(True);
        ActiveControl:= nil;
        SetActCtrl;
      end
      else
      begin
        CloseTreeViSession;
        if ShowSQLDescriptForm then ShowSQLDescription;
        Result:= true;
      end;
      if Result then
      begin
        WorkStyle:= wsView;
        if RecordCount>1 then
        begin
          if ActiveDataSet <> Vertex then
            TreeView.Items.GetFirstNode.Selected:= True
          else
            TreeViewChange(TreeView,TreeView.Selected);
        end
        else if ActiveDataSet <> Vertex then
          TreeViewChange(TreeView,TreeView.Selected);
      end;
    end
  else Result:= inherited OraclePerformance;
  if Result then
  begin
    // AccessRights:= TVASUPQuery(dsCurrent.DataSet).AccessLevel;
     if WorkStyle= wsAdd then WorkStyle:= wsView;
     {Move(Pointer(Perform(UM_OTHERS,IN_GETACCESS,0))^,
     MDIChildAccessRights,SizeOf(MDIChildAccessRights));
     Application.MainForm.Perform(UM_OTHERS,IN_REFRESH,0);}
     Perform(UM_OTHERS,IN_STATUS,0);
  end;
  //if dsCurrent.DataSet is TVASUPQuery then
  //  TVASUPQuery(dsCurrent.DataSet).WorkState := WorkStyle;
end;

procedure TfmTreeTopology.CloseTreeViSession;
var
  I: Integer;
begin
  with TreeView.Items do
    for I:= Count-1 downto 0 do
      with TVASUPQuery(Item[I].Data) do
        if IsQuery then
          CloseTreeViSession(TVASUPQuery(Item[I].Data));
end;

{procedure  TfmTreeTopology.GetDatasIN_WSVIEW;
var
  I: Integer;
begin
  with TreeView.Items do
    for I:= Count-1 downto 0 do
      if not TVASUPQuery(Item[I].Data).ReadOnly then
        TVASUPQuery(Item[I].Data).WorkState := wsVIEW;
end;}

procedure TfmTreeTopology.CloseTreeViSession(DataSet: TDataSet);
begin
  with DataSet as TVASUPQuery do
  begin
    if IsQuery then
    begin
      //CloseViSession;
      //OracleDictionary.EnforceConstraints:= True;
      TVASUPQuery(DataSet).WorkState := wsView;
      GetData(DataSet,IN_VIEW);
     { if Assigned(Master) then
        CloseTreeViSession(Master)}
    end;
  end;
end;

procedure TfmTreeTopology.ButtonClick(Sender: TObject);
begin
  if Sender=bbOk then
  begin
    //ActiveControl:= nil;
    //bbOk.SetFocus;
    if Assigned(ActiveControl) then
    begin
      ActiveControl.Perform(CM_EXIT,0,0);
     {для срабатывания события OnExit
      у компонентов TQueryEdit}
      ActiveControl.Perform(CM_ENTER,0,0);
    end;

    if    (( not(WorkStyle in [wsAdd, wsEdit])) and OraclePerformance)
       or ((WorkStyle in [wsAdd, wsEdit]) and SaveData) then
    begin
      if WorkStyle<>wsEdit then
        WorkStyle:= wsView
      else
        WorkStyle:= wsEdit;
    end;
    //else

    Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
  end
  else if Sender= bbView then
  begin
    {if FWStyle= wsQuery then
      CloseAllViSession;}
    Close;
  end
  else if Sender= bbCancel then
  begin
    {dsCurrent.DataSet.Cancel;
    TVASUPQuery(dsCurrent.DataSet).WorkState:= wsNone;}
    FDownCancel := true;
    if WorkStyle in [wsAdd, wsEdit] then
      CancelData;
    if WorkStyle<>wsQuery then WorkStyle:= wsView
    else
    begin
      TVASUPQuery(dsCurrent.DataSet).LastViQuery; //Vertex.LastViQuery;
      if ShowSQLDescriptForm then ShowSQLDescription(dsCurrent.DataSet as TVASUPQuery);
    end;
    //WorkStyle:= WorkStyle;
  end;
end;

procedure TfmTreeTopology.DBGridDblClick(Sender: TObject);
begin
  pcMain.SelectNextPage(True);
end;

function TfmTreeTopology.IsCtrlQueried(Sender: TWinControl):boolean;
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

procedure TfmTreeTopology.TreeViewEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit:= False;
end;

procedure TfmTreeTopology.SaveMinors(RptQueryId: Integer);
begin
  with dmSaveRptQuery.quNewMinors do
  begin
    SetVariable('RptId', RptQueryId);
    SetVariable('OrderText', Vertex.Order);
    SetVariable('MainTable', Vertex.UpdatingTable);
    if Vertex.SQLFiltered then
      SetVariable('FilterText',Vertex.SQLFilter)
    else SetVariable('FilterText', Null);
    Execute;
  end;
end;

procedure TfmTreeTopology.SaveMajors(RptQueryId: Integer);

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
  with HostObj.LinkedQueryList.Nodes[GlobalIndex] do
  begin
    AddOneQObj(HostObj,SelfIndex);
    for I:= 0 to Count-1 do
      AddObjWithChildren(Nodes[I].Obj,Nodes[I].Index);
  end;
end;

begin
  AddObjWithChildren ( Vertex,Vertex.IndexQuery)
end;

function TfmTreeTopology.SaveRptQuery;
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

procedure TfmTreeTopology.UMOTHERS;
var
  ActiveGrid: TRxDBGrid;
  RptName: string;
  CurNode: TTreeNode;
  GoDown: boolean;
  I: Integer;
begin
  case Message.wParam of
    IN_ACTIVATE:
    begin
      inherited;
      Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
      Perform(UM_OTHERS,IN_STATUS,0);
      SpecifyToolBtnState;
      Application.MainForm.Perform(UM_OTHERS,IN_TREEMENU,Integer(TreeView.Items[0]));
      RefreshNavigator;
    end;
    IN_SORT: if FixChanges(dsCurrent.DataSet) then
                (dsCurrent.DataSet as TVASUPQuery).Mixer;
    IN_PAGEUP,IN_PAGEDN: if WorkStyle in [wsNone,wsView,wsEdit] then
               begin
                 pcMain.ActivePage:= tsList;
                 DBGrid.SetFocus;
                 if  Message.wParam= IN_PAGEUP then
                     DBGrid.Perform(WM_KEYDOWN,VK_PRIOR,0)
                 else DBGrid.Perform(WM_KEYDOWN,VK_NEXT,0);
               end;
    IN_PRIOR:  if ActiveControl <> DBGrid then
                 Perform(WM_KEYDOWN,VK_UP,0)
               else DBGrid.Perform(WM_KEYDOWN,VK_UP,0);
    IN_NEXT:  if ActiveControl <> DBGrid then
                 Perform(WM_KEYDOWN,VK_DOWN,0)
              else DBGrid.Perform(WM_KEYDOWN,VK_DOWN,0);
    IN_QUIT: Close;
    IN_EXECQUERY:  if WorkStyle= wsQuery then
                  begin
                    SetFocus;
                    bbOk.Click;
                  end;
    IN_FORMQUERY_REPAINT: Repaint;
    IN_PRIORLEVEL:
    begin
      TreeView.Selected.Parent.Selected:= true;
      ActiveControl:= nil;
      SetActCtrl;
    end;
    IN_NEXTLEVEL:
    begin
      CurNode:= TreeView.Selected;
      GoDown:= False;
      I:= 0;
      while not GoDown and (I<CurNode.Count) do
      begin
        CurNode.Item[I].Selected:= true;
        GoDown:= CurNode.Item[I].Selected;
        Inc(I);
      end;
      {I:= CurNode.Index;
       while not GoDown and Assigned(CurNode.Parent) do
        if I<CurNode.Parent.Count-1 then
        begin
          CurNode.Parent.Item[I+1].Selected:= true;
          GoDown:= CurNode.Parent.Item[I+1].Selected;
          Inc(I);
        end
        else
        begin
          CurNode:= CurNode.Parent;
          I:= CurNode.Index;
        end;
      if not GoDown then CurNode.Selected:= True;}
      ActiveControl:= nil;
      SetActCtrl;
    end;
    IN_STORE:
    begin
      SaveForm;
      SaveGridCols;
      inherited;
    end;
    IN_UNSTORE:
    begin
      ResetSavedState;//(DBGrid.Name+dsCurrent.DataSet.Name);
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
    IN_ACTIVATETREENODE:
    begin
      CurNode:= GetNodeByDataSet(TreeView, TVASUPQuery(Message.lParam));
      if Assigned(CurNode) then
        CurNode.Selected:= True;
    end
    else inherited;
  end;
end;

function TfmTreeTopology.FixChanges(DataSet: TDataSet):boolean;
var
  MsgResult: Word;
begin
  if (WorkStyle in [wsAdd,wsEdit])
     and DataSet.Modified then
  begin
    MsgResult:= MessageDlg( Format(CNodeChange,[tsList.Caption]),
                            mtConfirmation,[mbYes,mbNo,mbCancel],0);
    if MsgResult=mrYes then DataSet.Post;
    Result:= MsgResult<>mrCancel;
  end
  else Result:= true;
end;

procedure TfmTreeTopology.SetRptQueryId(Value: Integer);
begin
  FRptQueryId:= Value;
  FExecedRpt:= false;
end;

procedure TfmTreeTopology.UMFASTREPORT(var Message:TMessage);

procedure AddDataSets(Node: TTreeNode);
var
  I: Integer;
begin
  TList(Message.lParam).Add(Node.Data);
  for I:= 0 to Node.Count-1 do AddDataSets(Node.Item[I]);
end;

begin
  case Message.wParam of
    IN_DEFAULT_DATASET: Message.Result:= Integer(Vertex);
    IN_SAVE_QUERY: Message.Result:= Integer(SaveRptQuery);
    IN_SET_FASTREPORT_ID: RptQueryId:= Message.lParam;
    IN_ENABLE_DATASETS: AddDataSets(TreeView.Items.GetFirstNode);
  end;
end;

function TfmTreeTopology.GetRelevantButton(const Flag:Word):TToolBarButton97;
var
  I: Integer;
begin
  with ToolBar97 do
  begin
    I:= 0;
    Result:= nil;
    while (I<ControlCount) and not Assigned(Result) do
    begin
      if (Controls[I] is TToolBarButton97) then
      begin
        Result:= (Controls[I] as TToolBarButton97);
        if not Result.Visible or not Result.Enabled or
          (GetButtonKind(Result) and Flag<>Flag) then Result:= nil;
      end;
      Inc(I);
    end;
  end;
end;

procedure TfmTreeTopology.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Flag: Word;
  btn: TToolBarButton97;
begin
  Flag:= 0;
  case Key of
    VK_F9: if Shift=[] then
             Flag:= BK_MAJOR_EXECUTE
           else if Shift=[ssCtrl] then
             Flag:= BK_MINOR_EXECUTE;
    VK_F6: if Shift=[] then
             Flag:= BK_PRINT;
  end;
  if Flag>0 then
  begin
    btn:= GetRelevantButton(Flag);
    if Assigned(Btn) then Btn.Click;
  end;
  if not (ActiveControl is TCustomDBGrid) or (Key in [VK_RETURN,VK_F7]) then
    inherited;
end;

procedure TfmTreeTopology.HideTreeView;
begin
  if (paExplorer.Tag<>0) and (paExplorer.Width>Splitter.MinSize) then
  begin
    FTreeWidth := paExplorer.Width;
    {while paExplorer.Width>Splitter.MinSize do
      paExplorer.Width := Max(paExplorer.Width - 20,Splitter.MinSize);}
    paExplorer.Width:= Splitter.MinSize;
  end;
end;

procedure TfmTreeTopology.pcMainEnter(Sender: TObject);
begin
  RepaintAllBtn;
end;

procedure TfmTreeTopology.paMasterEnter(Sender: TObject);
begin
  RepaintAllBtn;
end;

procedure TfmTreeTopology.RepaintTreeQueryState;
var
  I: Integer;
begin
  with TreeView.Items do
    for I:= 0 to Count-1 do
      with TVASUPQuery(Item[I].Data)  do
      begin
        Item[I].ImageIndex:=  Integer(not IsEmptyScreen)-1;
        Item[I].SelectedIndex:= Item[I].ImageIndex;
      end;
  TreeView.Repaint;
end;

procedure TfmTreeTopology.CloseAllViSession;
var
  I: Integer;
begin
  with TreeView.Items do
    for I:= Count-1 downto 0 do
      with TVASUPQuery(Item[I].Data) do
        if IsQuery then
          CloseViSession;
end;

procedure TfmTreeTopology.CloseAllDataSets;
var
  I: Integer;
begin
  with TreeView.Items do
    for I:= Count-1 downto 0 do
      with TVASUPQuery(Item[I].Data) do
        Close;
end;

procedure TfmTreeTopology.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if WorkStyle= wsQuery then CloseAllViSession;
  CloseAllDataSets;
  Application.MainForm.Perform(UM_OTHERS,IN_REFRESH_SAVEDQUERYITEMS,0);
end;

procedure TfmTreeTopology.pcAdditionDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  DC: HDC;
  vRect: TRect;
  OldPen,NewPen: HPen;
  PageCtrl: TPageControl;
  PageIndex: Integer;
begin
  PageCtrl:= Control as TPageControl;
  DC:= GetDC(PageCtrl.Handle);
  SetbkMode(DC,TRANSPARENT);
  SelectObject(DC,PageCtrl.Font.Handle);
  vRect:= Rect;
  PageIndex:= PageByTabIndex(PageCtrl,TabIndex);
  if Active then
  begin
    NewPen:= CreatePen(PS_SOLID,2,GetSysColor(Color_BtnFace));
    OldPen:= SelectObject(DC,NewPen);
    Dec(vRect.Bottom,2);
    MoveToEx(DC,vRect.Left,vRect.Bottom,nil);
    LineTo(DC,vRect.Right,vRect.Bottom);
    SelectObject(DC,OldPen);
    DeleteObject(NewPen);
  end;
  if (WorkStyle<> wsQuery) or
     not IsCtrlQueried(PageCtrl.Pages[PageIndex]) then
     SetTextColor(DC,clBlack)
  else SetTextColor(DC,clRed);
  DrawText( DC, PChar(PageCtrl.Pages[PageIndex].Caption)
            ,length(PageCtrl.Pages[PageIndex].Caption)
            ,vRect, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  ReleaseDC(PageCtrl.Handle, DC);
end;

function TfmTreeTopology.PageByTabIndex( APageControl:TPageControl;
                                         TabIndex: Integer): Integer;
begin
  Result:= 0;
  while (Result<APageControl.PageCount)
        and (APageControl.Pages[Result].TabIndex<> TabIndex) do Inc(Result)
end;

procedure TfmTreeTopology.RefreshNavigator;
var
  PNavigatorData: PTNavigatorData;
  CurNode: TTreeNode;
begin
  New(PNavigatorData);
  with PNavigatorData^ do
  begin
    ExploreState:= [];
    CurNode:= TreeView.Selected;
    if Assigned(CurNode) then
    begin
      if CurNode.HasChildren{ or Assigned(CurNode.Parent)}
      then ExploreState:= ExploreState+[ebNext];
      if Assigned(CurNode.Parent) then ExploreState:= ExploreState+[ebPrior];
      Path:= '';
    end;
  end;
  Application.MainForm.Perform(UM_OTHERS,IN_NAVIGATOR,Integer(PNavigatorData));
  Dispose(PNavigatorData);
end;

procedure TfmTreeTopology.vpAutoHideClick(Sender: TObject);
begin
  vpAutoHide.Checked := not vpAutoHide.Checked;
  paExplorer.Tag := Integer(vpAutoHide.Checked);
  HideTreeView;
end;

procedure TfmTreeTopology.TreeViewMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  HideTreeView;
  ActiveControl:= nil;
  SetActCtrl;
end;

procedure TfmTreeTopology.vpHideTreeClick(Sender: TObject);
begin
  paExplorer.Tag:= 1;
  HideTreeView;
end;

procedure TfmTreeTopology.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if Assigned(ActiveControl) then
  begin
    ActiveControl.Perform(CM_EXIT,0,0);
    {для срабатывания события OnExit
      у компонентов TQueryEdit}
    ActiveControl.Perform(CM_ENTER,0,0);
  end;
  TreeViewChanging(TreeView,TreeView.Selected,CanClose);
end;

procedure TfmTreeTopology.TreeViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not tmTreeView.Enabled and (paExplorer.Tag<>0) then
    tmTreeView.Enabled:= true;
end;

procedure TfmTreeTopology.paProcResize(Sender: TObject);
var
  I: Integer;
begin
  if ToolBar97.Docked then
    for I:= 0 to ToolBar97.ControlCount-1 do
      if ToolBar97.Controls[I] is TToolBarButton97 then
       with ToolBar97.Controls[I] as TToolBarButton97 do
         Width:=paProc.Width+Margin;
  Dock97.Width:= paProc.Width;
end;

procedure TfmTreeTopology.SetNodes4Button(Btn:TToolbarButton97;Lst: Array of TVASUPQuery;
                                          RequiredLevel: TAccessLevel = alHost);
var
  I: Integer;
  List: TList;
begin
  if Btn.Tag<>0 then TList(Btn.Tag).Free;
  List:= TList.Create;
  Btn.Tag:= Integer(List);
  if RequiredLevel<=Lst[Low(Lst)].AccessLevel then
  begin
    for I:= Low(Lst) to High(Lst) do List.Add(Lst[I]);
    Btn.OnMouseMove:= TreeViewMouseMove;
  end
end;

procedure TfmTreeTopology.FreeButtonList;
var
  I: Integer;
begin
  for I:= 0 to ToolBar97.ControlCount-1 do
    if ToolBar97.Controls[I] is TToolBarButton97 then
     with ToolBar97.Controls[I] as TToolBarButton97 do
       if Tag<>0 then TList(Tag).Free;
end;

procedure TfmTreeTopology.RepaintToolBarButtons;
var
  I: Integer;
begin
  for I:= 0 to ToolBar97.ControlCount-1 do
    if ToolBar97.Controls[I] is TToolBarButton97 then
     with ToolBar97.Controls[I] as TToolBarButton97 do
       Visible:= (WorkStyle<>wsQuery) and
                 ((Tag=0) or (TList(Tag).IndexOf(dsCurrent.DataSet)>=0));
end;

procedure TfmTreeTopology.RefreshLine(DataSet: TOracleDataSet);
var
  Row_Id: String;
begin
  with DataSet do
  begin
    Row_Id:= RowId;
    DisableControls;
    Refresh;
    First;
    while (not EOF) and (RowId<>Row_Id) do Next;
    EnableControls;
  end;
  DataSet:= DataSet.Master;
  while Assigned(DataSet) do
  begin
    DataSet.RefreshRecord;
    DataSet:= DataSet.Master;
  end;
end;

procedure TfmTreeTopology.Dock97RequestDock(Sender: TObject;
  Bar: TCustomToolWindow97; var Accept: Boolean);
begin
  Accept:= Bar=Toolbar97;
end;

procedure TfmTreeTopology.ToolBarButtonClick(Sender:TObject);
begin
  if vpAutoHide.Checked then
    HideTreeView;
end;

procedure TfmTreeTopology.FormActivate(Sender: TObject);
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

procedure TfmTreeTopology.TreeViewCompare(Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
begin
  if TreeView.SortType=stData then
    Compare:= TVASUPQuery(Node1.Data).TreeNodeIndex -
              TVASUPQuery(Node2.Data).TreeNodeIndex
  else Compare:= CompareStr(TVASUPQuery(Node1.Data).Caption,
              TVASUPQuery(Node2.Data).Caption);
end;

procedure TfmTreeTopology.TreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Node: TTreeNode;
begin
  Node:= TreeView.GetNodeAt(X,Y);
  if (Source is TTreeView) and Assigned(Node) then
    Accept:= (TTreeView(Source).Selected.Parent=Node.Parent)
             and (Node<>TTreeView(Source).Selected)
  else Accept:= False;
end;

procedure TfmTreeTopology.TreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Node: TTreeNode;
begin
  Node:= TreeView.GetNodeAt(X,Y);
  TreeView.Selected.MoveTo(Node,naInsert);
end;

procedure TfmTreeTopology.vpSaveTreeItemOrderClick(Sender: TObject);
var
  I: Integer;
begin
  for I:= 0 to TreeView.Items.Count-1 do
    with (TObject(TreeView.Items[I].Data) as TVASUPQuery) do
      with TRegIniFile.Create(StorageSection+Name) do
      begin
        WriteInteger( '','TreeNodeIndex',TreeView.Items[I].Index);
        Free;
      end;
  FCurSortType:= stData;
end;

procedure TfmTreeTopology.ReorderTreeView;
begin
  TreeView.SortType:= stNone;
  TreeView.SortType:= FCurSortType;
  TreeView.SortType:= stNone;
end;

procedure TfmTreeTopology.RestoreTreeViewOrder;
var
  I: Integer;
  DoReOrder: bool;
  NewIndex: Integer;
begin
  DoReOrder:= false;
  for I:= 0 to TreeView.Items.Count-1 do
    with (TObject(TreeView.Items[I].Data) as TVASUPQuery) do
      with TRegIniFile.Create(StorageSection+Name) do
      begin
        TNIndexSync:= false;
        NewIndex:= ReadInteger( '','TreeNodeIndex',TreeNodeIndex);
        if not DoReOrder then
          DoReOrder:= TreeNodeIndex<>NewIndex;
        TreeNodeIndex:= NewIndex;
        TNIndexSync:= true;
        Free;
      end;
  if DoReOrder then FCurSortType:= stData
  else FCurSortType:= FIniSortType;
  ReorderTreeView;
end;

procedure TfmTreeTopology.vpResetTreeItemOrderClick(Sender: TObject);
var
  I: Integer;
  AQuery: TVASUPQuery;
begin
  if MessageDlg(CResetTreeOrder,mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    for I:= 0 to TreeView.Items.Count-1 do
    begin
      AQuery:= (TObject(TreeView.Items[I].Data) as TVASUPQuery);
      with TRegIniFile.Create(StorageSection+AQuery.Name) do
      begin
        DeleteKey('','TreeNodeIndex');
        Free;
      end;
    end;
    FCurSortType:= FIniSortType;
  end;
end;

procedure TfmTreeTopology.dsActiveDataChange(Sender: TObject;
  Field: TField);
begin
  if (Field=nil) and (dsActive.DataSet<>dsCurrent.DataSet) then
  begin
    ClearDataCount;
    Perform(UM_OTHERS,IN_STATUS,0);
  end;
end;

procedure TfmTreeTopology.RepaintRecordCount(Sender: TObject; Field: TField);
var
  strRecCnt: string;
  RecCnt: Integer;
  idx: Integer;
  I: Integer;
begin
  if Field=nil then
  begin
    idx:= FMasterSources.IndexOf(Sender);
    with Sender as TDataSource do
    begin
      if Tag=INIT_VAL then
      begin
        with DataSet as TVASUPQuery do
          if IsQuery then RecCnt:= 0
          else if QueryAllRecords then
            RecCnt:= RecordCount
          else RecCnt:= SQLRecordCount;
        Tag:= RecCnt;
      end;
      if (idx>=0) and ((Integer(FMasterTags[idx]^) and MPK_SIPMLE_PANEL) <> MPK_SIPMLE_PANEL) then
      begin
        if Tag<=1 then
          strRecCnt:= ''
        else strRecCnt:= Format(' (%d/%d)',[DataSet.RecNo,Tag]);
        (Owner as TGroupBox).Caption:= (DataSet as TVASUPQuery).Caption + strRecCnt;
      end;
    end;
    if idx>=0 then
      for I:= idx+1 to FMasterSources.Count-1 do
        MasterSourceInit(FMasterSources[I]);
  end;
end;

procedure TfmTreeTopology.MasterSourceInit(Sender: TObject);
begin
  with Sender as TDataSource do
  begin
    Tag:= INIT_VAL;
    if DataSet.Active then RepaintRecordCount(Sender,nil);
  end;
end;

function TfmTreeTopology.GetButtonKind(tlbButton: TToolBarButton97):Word;
begin
  Result:= 0;
end;

procedure TfmTreeTopology.tmTreeViewTimer(Sender: TObject);
begin
// Находится ли курсор мыши над компонентом
  if not (TreeView.GetHitTestInfoAt(Mouse.CursorPos.x,Mouse.CursorPos.y)
    <= [htToLeft,htToRight]) then
    if (paExplorer.Tag<>0) and (paExplorer.Width<FTreeWidth) then
    {while paExplorer.Width<FTreeWidth do
      paExplorer.Width := Min(paExplorer.Width + 15,FTreeWidth);}
    paExplorer.Width := FTreeWidth;
  tmTreeView.Enabled:= false;
end;

procedure TfmTreeTopology.SelectNode(AQueryNode: TVASUPQuery);
var
  I: Integer;
  Node: TTreeNode;
begin
  I:= 0;
  Node:= nil;
  while (I<TreeView.Items.Count) and (Node=nil) do
  begin
    if AQueryNode= TVASUPQuery(TreeView.Items[I].Data) then
      Node:= TreeView.Items[I];
    Inc(I);
  end;
  if Node<>nil then
    TreeView.Selected:= Node;
end;

procedure TfmTreeTopology.DBGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
var
  curQuery: TVASUPQuery;
  SortFieldName: string;
  NewTag: Integer;
  I: Integer;
begin
  With TCustomDBGrid(Sender).DataSource.DataSet.Fields do
  if TCustomDBGrid(Sender).DataSource.DataSet is TVASUPQuery then
  begin
    curQuery:= TCustomDBGrid(Sender).DataSource.DataSet as TVASUPQuery;
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
    curQuery.ReOrder;
  end;
end;

procedure TfmTreeTopology.DBGridGetBtnParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor;
  var SortMarker: TSortMarker; IsDown: Boolean);
begin
  if Field.Tag and SORT_ASC_FIELDTAG= SORT_ASC_FIELDTAG then
    SortMarker:= smUp
  else if Field.Tag and SORT_DESC_FIELDTAG= SORT_DESC_FIELDTAG then
    SortMarker:= smDown
end;

procedure TfmTreeTopology.DBGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  GridCoord: TGridCoord;
begin
  if (Button=mbLeft) and (Shift=[ssCtrl,ssLeft ]) then
  begin
    GridCoord:= TCustomDBGrid(Sender).MouseCoord(X,Y);
     with TDBGrid(Sender).Columns[GridCoord.X-1].Field do
       Tag:= Tag xor CLICKED_FIELDTAG;
  end;
end;

procedure TfmTreeTopology.CancelDataSets;
begin
  Vertex.Cancel;
end;

procedure TfmTreeTopology.ResizeMasterPanels;
var
  I : Integer;
  masterPanel : TCustomPanel;
begin
  for I := 0 to FMasterPanels.Count - 1 do
    if (WorkStyle=wsQuery) or (TVASUPQuery(FMasterSets[I]).DisplayRowCount=1) then
    begin
      masterPanel := TCustomPanel(FMasterPanels.Objects[I]);
      ResizeMasterPanel(masterPanel.Parent, masterPanel, Integer(FMasterTags[I]^));
    end;
end;

procedure TfmTreeTopology.ResizeMasterPanel(AOwner : TWinControl; AMasterPanel : TCustomPanel; ATag : Integer);
begin
  if (ATag and MPK_SIPMLE_PANEL) <> MPK_SIPMLE_PANEL then
    AOwner.Height:= AMasterPanel.Height + 20
  else
    AOwner.Height:= AMasterPanel.Height;
end;

function TfmTreeTopology.GetInitASUPQueries : TArrayOfASUPQuery;
var
  I, J : Integer;
begin
  // Устанавливаем размер выходного массива
  SetLength(Result, TreeView.Items.Count);
  J := 0;
  // Читаем DataSet-ы, на которые ссылаются узлы дерева
  for I := 0 to TreeView.Items.Count - 1 do
    if Assigned(TreeView.Items[I].Data) and (TObject(TreeView.Items[I].Data) is TVASUPQuery) then
    begin
      // I-ый узел дерева ссылается на DataSet
      // Заносим DataSet, на который ссылается i-ый узел дерева, в выходной массив
      Result[J] := TVASUPQuery(TreeView.Items[I].Data);
      Inc(J);
    end
    else
      // I-ый узел дерева не ссылается на DataSet
      // Уменьшаем размер выходного массива на единицу
      SetLength(Result, Length(Result) - 1);
end;

function TfmTreeTopology.GetMainDataSetOfForm : TDataSet;
begin
  Result := Vertex;
end;

procedure TfmTreeTopology.AddActivePageOfNode(ATabSheet : TTabSheet; ANode : TVASUPQuery);
var
  Ind : Integer;
  link : String;
begin
  // Ищем в списке активных страниц узлов дерева,
  // под каким индексом расположена ссылка активной странице на pcMain узла дерева,
  // который описан DataSet-ом ANode
  Ind := FActivePagesOfNodes.IndexOfObject(ANode);

  // Сохраняем ссылку активной страницы в строковом формате
  SetLength(link, SizeOf(Pointer));
  Pointer(Pointer(link)^) := ATabSheet;

  if ind < 0 then
    // ссылка не найдена
    // Добовляем новую ссылку активной странице на pcMain узла дерева в список
    FActivePagesOfNodes.AddObject(link, ANode)
  else
    // ссылка найдена
    // Заменяем устаревшую ссылку активной странице на pcMain узла дерева
    FActivePagesOfNodes[ind] := link;
end;

procedure TfmTreeTopology.ClearActivePagesOfNodes;
begin
  // Очищаем список активноых страниц  узлов дерева,
  FActivePagesOfNodes.Clear;
end;

procedure TfmTreeTopology.SetActivePageOfNode;
var
  Ind : Integer;
  TabSheet : TTabSheet;
begin
  // Ищем указатель активной страницы для текущего узла дерева
  //  из списке активных страниц узлов дерева
  Ind := FActivePagesOfNodes.IndexOfObject(dsCurrent.DataSet);
  if Ind >= 0 then
  begin
    // Ссылка найдена
    TabSheet := TTabSheet(Pointer(FActivePagesOfNodes[Ind])^);

    // проверяем атрибут видимости у закладки
    if Assigned(TabSheet) and TabSheet.TabVisible then
      // Устанавливаем найденную страницу активной
      pcMain.ActivePage := TabSheet;
  end;
end;

procedure TfmTreeTopology.ShowSQLDescription;
var
  CurQuery: TVASUPQuery;
  PartialSQLDescription: TTreeSQLDescription;
begin
  if ShowSQLDescriptForm then
  begin
    with Vertex do
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
           FTreeSQLDescription.Caption:= Vertex.Caption;
           
        PartialSQLDescription:= FTreeSQLDescription.FindNodeByQuery(CurQuery);
        PartialSQLDescription.Clear;
        CurQuery.GetSQLDescription(CurQuery.IndexQuery,PartialSQLDescription);
      end;
    fmSQLDescript.ShowSQL(FTreeSQLDescription);
    fmMainMenu.SetFocus;
  end;
end;

procedure TfmTreeTopology.ApplyActivePageOfNodeSettings(FPrevNode : TDataSet = nil);
var
  currDataSet : TVASUPQuery;
  Parental    : boolean;
  DetailList : TList;
begin
  // Определяем, DataSet текущего узла дерева является ли представителям класса TVASUPQuery
  if dsCurrent.DataSet is TVASUPQuery then
  begin
    // DataSet текущего узла дерева является представителям класса TVASUPQuery
    currDataSet := TVASUPQuery(dsCurrent.DataSet);

    // Определяем, новый текущий узел дерева является ли родительским узлом
    // по сравнению с предыдущим текущим узлом
    Parental := false;
    if Assigned(FPrevNode) then
    begin
      DetailList := TList.Create;
      currDataSet.GetDetailList(DetailList);
      if (DetailList.IndexOf(FPrevNode) >= 0) or (FPrevNode = currDataSet) then
        Parental := true;
      DetailList.Destroy;
    end;

    if Parental then
    begin
      // текущий узел дерева является родительским узлом
      // по сравнению с предыдущим текущим узлом дерева

      // Устанавливает активную страницу на pcMain,
      // которая указана, как активная страница текущего узла дерева
      // в списке активных страниц узлов дерева
      SetActivePageOfNode;
      Exit;
    end;

    // Определяем, был ли установлен курсор на запись в DataSet-е,
    // на которой он был ранее установлен
    if currDataSet.FoundedASUPBookmark then
      SetActivePageOfNode;
  end;
end;

{procedure TfmTreeTopology.SaveData;
begin
  if WorkStyle in [wsAdd, wsEdit] then
    bbOK.Click;
end;

procedure TfmTreeTopology.CancelData;
begin
  if WorkStyle in [wsAdd, wsEdit] then
    bbCancel.Click;
end;}

procedure TfmTreeTopology.DoBeforeScroll(ASUPQuery: TVASUPQuery);
begin
  if dsCurrent.DataSet = ASUPQuery then
    FScrolling := true;

  inherited DoBeforeScroll(ASUPQuery);
end;

procedure TfmTreeTopology.DoAfterScroll(ASUPQuery: TVASUPQuery);
begin
  if dsCurrent.DataSet = ASUPQuery then
    try
      inherited DoAfterScroll(ASUPQuery);
    finally
      FScrolling := false;
    end
  else
    inherited DoAfterScroll(ASUPQuery);
end;

procedure TfmTreeTopology.ChangeActivePageOnChangeMode(newMode : TWStyle);
begin
  if not FScrolling then
  begin
    tsList.TabVisible:= newMode<>wsQUERY;
    if (newMode<>wsVIEW) and (pcMain.ActivePage= tsList) then
      pcMain.SelectNextPage(True);
  end;
end;

procedure TfmTreeTopology.pcMainContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  Handled := ContextPopup(TWinControl(Sender), MousePos);
end;

procedure TfmTreeTopology.bbXLSClick(Sender: TObject);
var ea, ExSh, aVal: Variant;
  LastRow, cSize, bFirst, i,  l, b, lInd: Integer;
  lName, lVal: TStringList;
  s: string;

const bSize = 60;

 procedure ParentNext(DSet: TOracleDataSet; Ind: Integer);
 begin
  DSet.Next;
  if Assigned(DSet.Master) then
   while DSet.Eof and (not DSet.Master.Eof) do
     ParentNext(DSet.Master, Ind + 1);
  if (not DSet.Eof) and (DSet.Fields.Count > 0) then
  lVal[Ind] := DSet.Fields[0].AsString;
 end;

 procedure ParentFirst(DSet: TOracleDataSet; Ind: Integer);
 begin
  if Assigned(DSet.Master) then
  begin
    ParentFirst(DSet.Master, Ind + 1);
    if DSet.Eof then ParentNext(DSet.Master, Ind + 1);
  end;
  DSet.First;
  while (lName.Count -1 < Ind) do lName.Add('');
  while (lVal.Count -1 < Ind) do lVal.Add('');
  if DSet is TVASUPQuery then
    lName[Ind] :=  TVASUPQuery(DSet).Caption
  else
    lName[Ind] :=  DSet.Name;
  if (not DSet.Eof) and (DSet.Fields.Count > 0) then
  lVal[Ind] := DSet.Fields[0].AsString;
 end;

 function XLSColNameById(cid: Integer): string;
 var nc, i, chi, c: Integer;
 begin
  Result := '';
  nc := Ord('Z') - Ord('A') + 1;
  chi := cid;
  while (chi > 0) do
  begin
    i := chi div nc;
    c :=  chi - (i * nc);
    if c = 0 then
    begin
      c := nc;
      Dec(i);
    end;
    Result := Chr(Ord('A') - 1 + c) + Result;
    chi := i;
  end;
 end;

begin
  inherited;
  lName := TStringList.Create;
  lVal := TStringList.Create;
  try
    ea := CreateOleObject('Excel.Application');
    ExSh := ea.WorkbookS.Add.Worksheets[1];
    ea.Visible := True;
  except
    raise Exception.Create('Ощибка запуска Excel');
  end;

  ParentFirst(TOracleDataSet(DBGrid.DataSource.DataSet), 0);
  l := lName.Count;
  cSize := DBGrid.Columns.Count + l - 1;
  aVal  := VarArrayCreate([1, bSize, 1, cSize], varVariant);
  LastRow := 1;

  ExSh.Rows[1].Font.Bold := True;

  bFirst := 1;
  for i := 1 to l - 1 do
  begin
    ExSh.Columns[i].Font.Bold := True;
    aVal[bFirst, i] :=  lName[l - i];
  end;
  for i := 0 to DBGrid.Columns.Count - 1 do
    aVal[bFirst, i + l] := DBGrid.Columns[i].Field.DisplayName;

  Inc(bFirst);

  with DBGrid.DataSource.DataSet do
    while not eof do
    begin
      for b := bFirst to bSize do
       if not eof then
       begin
         for i := 1 to  l - 1 do
            aVal[b, i] := lVal[l - i];
         for i := 0 to DBGrid.Columns.Count - 1 do
           aVal[b,  i + l] := DBGrid.Columns[i].Field.AsString;
 	      ParentNext(TOracleDataSet(DBGrid.DataSource.DataSet), 0);
       end else
       begin
         for i := 1 to cSize do aVal[b, i] := Null;
       end;
      {Заслать значения в XLS}
	    s :=  Format('A%d:%s%d', [LastRow, XLSColNameById(cSize), LastRow + bSize - 1]);
       ExSh.Range[s].Value := aVal;
       bFirst := 1;
       Inc(LastRow, bSize);
       if LastRow > 65000 then
         ExSh.Cells[LastRow,1].Value := 'Очень много записей. Переполнение.';
    end;
  ExSh.Columns.AutoFit;
  lName.Free;
  lVal.Free;
  ExSh := Unassigned;
  ea := Unassigned;
  aVal := Unassigned;
end;

end.
