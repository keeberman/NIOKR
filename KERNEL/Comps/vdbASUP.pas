{*******************************************************}
{                                                       }
{       Delphi Visual Component Library Support         }
{                                                       }
{   Copyright (c) 1997,98 ASUP, BelarusKali, SOLIGORSK  }
{                                                       }
{*******************************************************}

unit VDbASUP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, DBTables,DB, v_Hello, ExtCtrls,Buttons,
  Grids,DBGrids,Menus,BDE, designintf, Oracle,
  v_krconsts, vASUP_SQL, contnrs, Clipbrd, Variants, OracleData,
  PickDate, CommDlg, Consts, Dlgs, TypInfo, OracleTypes, ShellAPI, ExtDlgs;

const
  BadSettings=' Неверные параметры';
  BadFormatData='Неправильный формат данных';
  EmptyTableMess='Нет данных';
  OURError='Ошибка';
  RIPstring='-1';
  RIPCaption='не учитывать';
  LongDateFmtLine= 'DD.MM.YYYY';
  ShortDateFmtLine= 'dd.mm.yy';
  EmptyPassNumText='              ';
 // FIELD TAGS- Биты признаков для полей TField
  RECHANGED_FIELDTAG= $0001;
  FOREVER_HIDING_FIELDTAG= $0002;
  VISIBLE_FIELDTAG= $0004;
  CLICKED_FIELDTAG= $0008;
  RESERVED1_FIELDTAG= $00010;
  RESERVED2_FIELDTAG= $00020;
  RESERVED3_FIELDTAG= $00040;
  USEINSORT_FIELDTAG= $00080;
  GROUPFUNC_FIELDTAG= $00100;
  DUPLICATE_VALUE_TAG= $00200;
  CHANGING_FIELDTAG= $00400;
  SORT_ASC_FIELDTAG= $00800;
  SORT_DESC_FIELDTAG= $01000;

  // DATASET TAGS
  DIRECT_ACCESS_FLAG= $0001;
  REPLICATE_INSERT_FLAG= $0002;
  RESTORED_FLAG= $0004;
  OPENED_FLAG= $0008;
  DUPLICATE_INSERT_FLAG= $00010;

  // TYPE OF BOOKMARK VALUE
  BOOKMARK_NULL = $0001;

  // DbASUP BOOKMARK
  DBASUP_BOOKMARK = $80;

 // ASUPQuery  Missions
 USER_QUERY   = 'USER QUERY';
 USER_SQL_FILTER   = 'USER SQL FILTER';
 SQL_FILTER   = 'SQL FILTER';
 DETAIL_USER_QUERY = 'USER QUERY OF DETAIL ';
 SIMPLE_QUERY = 'SIMPLE QUERY';
 DEFAULT_ORDER_BY = 'DEFAULT ORDER BY';
 MASTER_DATASET   = 'MASTER DATASET';
type

  PPointer = ^Pointer;

  TSQLExpression= (piEqual,piNotEqual,piMore,piLess,
    piNotMore,piNotLess,piLike,piNotLike,piInto,piNone,
    //Невидимые состояния
    piUserDefined,piVariable,piTempVariable);

  TStatePUMenu= piEqual..piNone;

  TVParentPopMenuCD = class(TPopupMenu)
    constructor Create(AOwner: TComponent); override;
  private
    FCopy :TMenuItem;
    FPaste :TMenuItem;
    procedure InCopy;
    procedure InPaste;

  protected
    procedure InsertClipBoardInEditor(AEditor : TCustomEdit); // Вставка текста из буфера обмена в редактор
    procedure FillMenu; virtual;
    procedure DoPopup(Sender: TObject); override;
    procedure defineEnableCopy; virtual;
    procedure defineEnablePaste; virtual;
    procedure CreateSeparation;
    procedure ItCopy(Sender:TObject); virtual;
    procedure ItPaste(Sender:TObject); virtual;
  end;

  TVPopMenuCD= class(TVParentPopMenuCD)
  {Локальное(всплывающее) меню условий для запроса
  с опциями:
           = равно
           > больше
           < меньше и т.д.
   Используется наследниками класса TVQryEdit (свойство PopUpMenu)
   для формирования SQL-скрипта}
     constructor Create(AOwner: TComponent); override;
  private
    FState: TStatePUMenu;
    FAfterPop: TNotifyEvent;
    procedure InMenu(const ItemName: string);
    procedure SetState(const Value: TStatePUMenu);
    procedure PopItemClick(Your:TStatePUMenu);
    procedure ItClick(Sender:TObject);

  public
    property State:TStatePUMenu  read FState write SetState;
    {Текущее условие для запроса. Соответствующая опция меню
     отмечается флажком}
    property AfterPop:TNotifyEvent read FAfterPop write FAfterPop;
    {Событие, возникающее в обработчике
    события OnClick опций меню}
  protected
    procedure FillMenu; override;
    procedure defineEnableCopy; override;
    procedure defineEnablePaste; override;
    procedure ItCopy(Sender:TObject); override;
    procedure ItPaste(Sender:TObject); override;
  end;

const
  {Cимволы шрифта Symbol. Используются компонентами
  типа TLabel для визуального представления выбранной опции
  меню типа TPopUpCD}

  syNone=#0;
  syEqual=#61;
  syNotEqual=#185;
  syMore=#62;
  syLess=#60;
  syNotMore=#163;
  syNotLess=#179;
  syLike=#187;
  syNotLike=#33;
  syInto=#206;

type
  TServerControl= (scKeyBoard,scPopUp);

  TEnumLineStyle=(elSQL,elHint);

  TContainerState = (csNone,csPoint,csInterval);

  TArrayOfVariant = array of Variant;

  TVDataContainer= class(TPersistent)
  protected
    FPoint: Variant;
    FStart: Variant;
    FFinish: Variant;
    FState: TContainerState;
  public
    property Point: Variant read FPoint;
    property StartInt:Variant read FStart;
    property FinishInt:Variant read FFinish;
    property State:TContainerState read FState;
    function GetDisplayText( const EnumLnStyle:TEnumLineStyle;
                             Field: TField):string;
    procedure SetPoint(const Value:Variant);
    procedure SetInterval(const Start,Finish:Variant);
    procedure Assign(Source: TPersistent);override;
    function Equal(AContainer: TVDataContainer):boolean;
  end;

  TVQryEdit= class;

  TVEnumValueList= class;

  TSQLUnion= (unOR,unAND);

  TVEnumValueList= class(TStringList)
  private
    FOwner: TVQryEdit;
    FUnion: TSQLUnion;
    procedure CrackString(Line: String);
    function MakeString: String;
  public
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream);override;
    procedure Clear;override;
    procedure Delete(Index: Integer);override;
    procedure AddPoint(const pntText:string;const pntValue:Variant);
    procedure AddInterval(const intText:string;const intStartVal,intFinishVal:Variant);
    procedure Replicate(Source: TVEnumValueList);
    function GetDisplayText( Index: Integer;
                             const Style:TEnumLineStyle;
                             Field: TField): string;
    function Equal(AEnumValList: TVEnumValueList):boolean;
    constructor Create(OwnerEdit: TVQryEdit);
    property FullText: string read MakeString;
    property Union: TSQLUnion read FUnion write FUnion;
  end;

  TVQueryStateChangeEvent= procedure (Sender: TVQryEdit) of object;

  TVQryEdit = class(TCustomMaskEdit)
  {Компонент с всплывающим меню условий для запроса.
  Используется наследниками формы TfmWorkForm для
  создания визуальных запросов}
  private
    FDataLink: TFieldDataLink;
    FCanvas: TControlCanvas;
    FAlignment: TAlignment;
    //
    FEnumDesPlacemnt: TWindowPlacement;
    FPlacemntStored: bool;
    FPermit: bool;
    FLabel: TLabel;
    FDefaultState: TStatePUMenu;
    FState: TStatePUMenu;
    FSrvCtrl:TServerControl;
    FQValList: TVEnumValueList;
    FEnumDes: TForm;
    FEditFmt: string;
    FDisplayFmt: string;
    FForceReadOnly: boolean;
    FOnQueryStateChange: TVQueryStateChangeEvent;
    //
    procedure ActiveChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetTextMargins: TPoint;
    procedure ResetMaxLength;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMMOUSEMOVE(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure WMLBUTTONDBLCLK(var Message: TWMMouse); message WM_LBUTTONDBLCLK;
    //
    procedure CreateEnumList;
    procedure SetState(const Value: TStatePUMenu);
    procedure SetPermission(const Value:bool);
    procedure SetDefaultState(const ADefault: TStatePUMenu);
    procedure RepaintLabel;
    procedure SafeExit(Sender: TObject);
    function GetEnumLine(const Style:TEnumLineStyle):string;
    function GetSQLEnumLine:string;
    function GetHintEnumLine:string;
    //procedure SetLabelVisible;
    procedure SetLabelCoord;
  protected
    FFocused: Boolean;
    FPopa: TVPopMenuCD;
    FStandardPaint: bool;
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
    property Alignment: TAlignment read FAlignment;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Field: TField read GetField;
    property DefaultState: TStatePUMenu read FDefaultState write SetDefaultState;
             //Условие(>,<,= и т.д.) на значение поля по умолчанию

    property Permission: bool read FPermit write SetPermission ;
             {В случае TRUE отображает TLabel с условием(>,<,= и т.д.)
              на поле (слева от клиентской области) }

    property QueryState:TStatePUMenu  read FState write SetState;
             //Текущее условие(>,<,= и т.д.) на значение поля

    property EnumValuesLine: string read GetSQLEnumLine;
             {Отформатированная для SQL-скрипта строка значений
             для запроса по списку}

    property HintValuesLine: string read GetHintEnumLine;
             {Отформатированная для подсказки строка значений
             для запроса по списку}

    property QueryValuesList: TVEnumValueList read FQValList;
             //Значения для запроса по списку

    property QueryMenu:TVPopMenuCD read FPopa;

    property StandardPaint:bool read FStandardPaint write FStandardPaint;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint default true;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnQueryStateChange: TVQueryStateChangeEvent
    read FOnQueryStateChange write FOnQueryStateChange;
  end;

  TVDBEMath = class(TVQryEdit)
  {Используется для ввода числовой информации.
  Доступны все опции локального меню TStatePUMenu}
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

  TVDBEditChar = class(TVQryEdit)
  {Используется для ввода символьной информации.
  Доступны следующие опции локального меню TStatePUMenu:
  равно, неравно, подобно, неподобно}
    constructor Create(AOwner: TComponent);override;
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

const
  scAltDown = scAlt + vk_Down;
  DefEditBtnWidth = 16;

type

{ TVCustomEditwButton }

  TVEditButton = class(TSpeedButton)
  private
    FNoAction: Boolean;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
  end;

  TVCustomEditwButton = class(TVDBEditChar)
  private
    FButton: TVEditButton;
    FBtnControl: TWinControl;
    FClickKey: TShortCut;
    FCanvas: TControlCanvas;
    procedure SetEditRect;
    procedure UpdateBtnBounds;
    function GetMinHeight: Integer;
    function GetTextHeight: Integer;
    procedure SetShowCaret;
    function GetGlyph: TBitmap;
    procedure SetGlyph(Value: TBitmap);
    function GetNumGlyphs: TNumGlyphs;
    procedure SetNumGlyphs(Value: TNumGlyphs);
    function GetButtonWidth: Integer;
    procedure SetButtonWidth(Value: Integer);
    function GetButtonHint: string;
    procedure SetButtonHint(const Value: string);
    function BtnWidthStored: Boolean;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CNCtlColor(var Message: TMessage); message CN_CTLCOLOREDIT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    FDefNumGlyphs: TNumGlyphs;
    function GetDefaultBitmap(var DestroyNeeded: Boolean): TBitmap; virtual;
    procedure DoChange;
    procedure AcceptValue(const Value: Variant); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure EditButtonClick(Sender: TObject);dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoClick;
    property Button: TVEditButton read FButton;
    property ButtonHint: string read GetButtonHint write SetButtonHint;
  published
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property ButtonWidth: Integer read GetButtonWidth write SetButtonWidth
      stored BtnWidthStored;
    property NumGlyphs: TNumGlyphs read GetNumGlyphs write SetNumGlyphs;
    property ClickKey: TShortCut read FClickKey write FClickKey
      default scAltDown;
  end;

const
  Tail_All='%';
  FullRefresh = [roBeforeEdit, roAfterInsert, roAfterUpdate, roAllFields];


type

  TVCommentQuery = class(TOracleDataSet)
    {Автоматически заполненяет Fields[I].DisplayLabel
    комментариями на столбцы из Oracle, имеет расширенную обработку
    сообщений Oracle}

    procedure AfterOpenPro(DataSet:TDataSet);
    {Обработчик события AfterOpen.
    Заполняет Fields[I].DisplayLabel комментариями на столбцы из Oracle}

    constructor Create(AOwner: TComponent);override;
  private
   FReActive: bool;
   FCaption: string;
   FUseDefSchema: bool;
   FExtract: Integer;
   FTableOwner: string;
   FTableName: string;
   FROWIDAlias : String;
   // Наименования алиаса в SQL запросе, при помощи которого возвращается ROWID
   procedure SetComments;
   function FindUnique(const ConstraintName: string): string;
   function FindBadValue(const ConstraintName: string): string;
   procedure TriggerHandler(var Msg:string);
   procedure FindNullField(var Msg:string);
   function IsSynonym(var AOwner,ATableName:string):bool;
   { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    function ExtractTable: string;//Возвращает имя таблицы
    function ExtractOwner: string;//Возвращает имя владельца таблицы
    function ExtractTable_: string;//Возвращает имя таблицы
    function ExtractOwner_: string;//Возвращает имя владельца таблицы
    procedure AdvancedMessage(Sender: TOracleDataSet; ErrorCode: Integer;
                const ConstraintName: string; Action: Char; var Msg: string);
              //Расширенный обработчик сообщений Oracle
    function GetUpdatingTable: string; override;

    function GetUpdatingAlias: string; override;
  published
    property ReActive: bool read FReActive write FReActive default false;
             {В случае TRUE заполняет Fields[I].DisplayLabel
             комментариями на столбцы из Oracle после процедуры Open}

    property ROWIDAlias : String read FROWIDAlias write FROWIDAlias;
    // Наименования алиаса в SQL запросе, при помощи которого возвращается ROWID

    property Caption: string read FCaption write FCaption;
             // Комментарий на таблицу
    property RefreshOptions default FullRefresh;
    property UpdatingTable;
//    property RefreshMode default rmAfterUpdate;
//    property EnforceConstraints default true;
    { Published declarations }
  end;

const
  CNoDaMess='Нет данных|';
  CUnknownField= 'Неизвестные данные|';
  CEnterInvitation= 'Открыть справочник|Нажмите кнопку для входа в справочник';
  CDisplayLen= 25;

 const
   EmptyQueryMsg= 'Не задано условие для запроса';
   SpecNameByte= #01;

 type

 TReservedType=(rtNone,rtString,rtPointer,rtEnumList,rtdate,rtFilter);

 TSQL= record
         FieldName: string;
         Value: string;
         Comment: string;
         Expr:TSQLExpression;
         case ResType:TReservedType of
           rtNone: (UnUsed: Integer);
           rtString: (ResString:PChar);
           rtPointer: (ResPointer: Pointer);
           rtEnumList: (ResEnumList: TVEnumValueList);
           rtDate: (ResDate: TDateTime);
           rtFilter: (DontUsed: Integer);
       end;

 TPSQL= ^TSQL;

 TVisualQuery= class(TList)
   private
     FDataSet: TDataSet;
     function GetBlock(Index: Integer):TSQL;
     function l_GetSQLText: string; //Возвращает не полный SQL текст
     function GetSQLDescription:string;
   public
     property Blocks[Index: Integer]:TSQL read GetBlock;default;
     procedure Add(ASQL: TSQL);
     procedure Clear;override;
     procedure Delete(Index: Integer);
     destructor Destroy;override;
     constructor Create(ADataSet: TDataSet);
     function Equal(AVQuery:TVisualQuery):bool;
     function IndexOf(DataField: string;var Block: TSQL): Integer;
     property SQLText: string read l_GetSQLText;
     property SQLDescription: string read GetSQLDescription;
 end;

 TVQLibrary= class (TList)
   private
     FItem: Integer;
     function GetQuery(Index: Integer):TVisualQuery;
   public
     property ItemIndex: Integer read FItem write FItem;
     property Queries[Index: Integer]:TVisualQuery read GetQuery;default;
     procedure Add(AVQuery: TVisualQuery);
     procedure Delete(Index: Integer);
     procedure Clear;
     procedure First;
     procedure Last;
     procedure MoveBy(Index: Integer);
     procedure Next;
     procedure Prior;
     destructor Destroy;override;
     constructor Create;
 end;

 TAccessItems=(aqQuerying,aqInserting,aqEditing,aqDeleting,aqPrinting);

 TAccessLevel= set of TAccessItems;

const
  alHost= [aqQuerying,aqInserting,aqEditing,aqDeleting,aqPrinting];
  alGuest= [aqQuerying,aqPrinting];

type
 TWStyle=(wsQuery,wsAdd,wsEdit,wsDelete,wsView,wsNone);
 //Режимы работы TVASUPQuery

 TVEditFormID= class(TComponent)
  private
   FFormClass: TFormClass;
   FFormClassName: string;
   FDataSource: TDataSource;
   FPanel: TPanel;
  public
   property FormClass: TFormClass read FFormClass write FFormClass;
   property FormClassName: string read  FFormClassName write FFormClassName;
   constructor Create(AOwner: TComponent);override;
   procedure Assign(Source : TPersistent);override;
  published
    property DataSource: TDataSource read FDataSource write FDataSource;
    property Panel: TPanel read FPanel write FPanel;
  end;


 TSQLFrame= record
              ExprType: TSQLExpression;
              Content: string;
              Comment: string;
            end;

 TVASUPQuery= class;

 TSQLPrepareEvent= procedure (Sender: TVASUPQuery; Field:TField;
                              var SQLFrame: TSQLFrame;
                              var Action:boolean) of object;

 TBeforeVisualQueryEvent= procedure (DataSet :TDataSet) of object;

 TFilterChangeEvent= procedure (Sender: TVASUPQuery;
                               const Filtered: bool;
                               const Filter: string) of object;

 TSetFilterEvent= procedure (Sender: TVASUPQuery;
                               var Filtered: boolean;
                               var Filter: string;
                               var Comment: string) of object;

 TVASUPQueryEvent = procedure (Sender: TVASUPQuery) of object;

 TModifiedASUPQueryEvent = procedure (Sender: TVASUPQuery; var AModified : boolean) of object;

 TTreeSQLDescription= class;

 // тип для хранения текста описание запроса
 TTreeSQLDescription= class(TList)
 private
   FCaption: String;
   FText: String;
   function GetChild(Index: Integer):TTreeSQLDescription;
   procedure SetChild(Index: Integer;Value: TTreeSQLDescription);
 public
   procedure Clear;
   procedure Add(Value: TTreeSQLDescription);
   function FindNodeByQuery(AQuery: TVASUPQuery):TTreeSQLDescription;
   destructor Destroy;override;
   property Caption: String read FCaption write FCaption;
   property Text: String read FText write FText;
   property Children[Index: Integer]:TTreeSQLDescription read GetChild write SetChild;default; 
 end;

 EEmptyQuery= class(Exception);
 EInvalidBookmark = class(Exception);

 TLinkedQueryNode= record
   Obj: TVASUPQuery;
   Index: Integer;// индекс на активный элемент в LinkedQueryList
 end;

 PTLinkedQueryNode= ^TLinkedQueryNode;

 TLinkedQuery= class;

 TLinkedQuery= class(TList)
 private
   FSelfIndex: Integer;
   FSelfObj: TVASUPQuery;
   function GetNode(Index: Integer):TLinkedQueryNode;
   procedure SetNode(Index: Integer;Value: TLinkedQueryNode);
 public
   function Equal(AOther: TLinkedQuery):bool;
   function IsEmpty:bool;
   procedure Add(Value: TLinkedQueryNode);
   procedure Clear;
   destructor Destroy;override;
   property SelfIndex: Integer read FSelfIndex write FSelfIndex;
   property SelfObj: TVASUPQuery read FSelfObj write FSelfObj;
   property Nodes[Index:Integer]:TLinkedQueryNode read GetNode write SetNode;
 end;

 TLinkedQueryList= class(TList)
   constructor Create(AOwner: TVASUPQuery);
 private
   FOwner: TVASUPQuery;
   FIndex: Integer;
   FDefferedDelIndex: Integer;
   function GetNode(Index: Integer):TLinkedQuery;
   procedure SetNode(Index: Integer;Value: TLinkedQuery);
   procedure ClearZone;
 public
   procedure Seek(Index: Integer);
   procedure Delete(Index: Integer);
   procedure DefferedDelete;
   procedure Add(Value: TLinkedQuery);
   procedure Pack;
   procedure Clear;
   destructor Destroy;override;
   property Nodes[Index: Integer]: TLinkedQuery read GetNode write SetNode;
   property ItemIndex: Integer read FIndex write FIndex;
   property DefferedDelIndex: Integer read FDefferedDelIndex write FDefferedDelIndex;
 end;

 TCondSpot = (csWhere,csHaving);

 TLinkKind = (lkExists,lkIn);

 TQueryStatus= (qsIdle,qsExecution);

 TKindFields = (kfRowid, kfUniqueFields);

 TCommandUpdated = (cuPost, cuCancel, cuNone);
 { Тип описывает, какие необходимо выполнять команды при изменении данных
   cuPost   - команду Post
   cuCancel - команду Cancel
   cuNone   - неизвестно какую команду
 }

 ECursorCanNotMoveAboutRecord = class(EDatabaseError);
 { Ошибка возникает, когда запрещено перемещать курсор,
   но при этом происходит попытка переместить курсор на другую запись.
 }

 TVASUPQuery = class(TVCommentQuery)
 { Навороченный TOracleDataSet. Позволяет:
 а) формировать, отображать, хранить визуальные запросы
 б) осуществлять визуальную сортировку записей по любым реквизитам
 в) поддерживать связь master-detail}

    procedure Execute;
    {Произвести текущий визуальный запрос, либо
     запрос по форме SimpleQuery}

    procedure Mixer;//Диалог выбора полей для упорядочивfromsания

    function IsEmptyScreen: boolean;

    procedure FromScreen;
    {Построение на основе компонент, лежащих на WorkSpace
    визуального запроса}

    procedure OnScreen(LibIndex: Integer);
    //Вывод на экран визуального запроса с индексом LibIndex

    procedure DetailsOnScreen;
    //Вывод на экран визуальных запросов привязанных DataSet'ов

    procedure NextViQuery;
    {Вывод на экран визуального запроса с индексом
    следующим за текущим}

    procedure LastViQuery;
    {Вывод на экран визуального запроса с индексом
    следующим за текущим}

    procedure PriorViQuery;
    {Вывод на экран визуального запроса с индексом
    следующим за текущим}

    procedure SaveViQuery;//Сохранение текущего визуального запроса
    procedure DeleteQuery(Deffered:bool=False);//Удаление текущего визуального запроса
    procedure OpenViSession;//Открытие сессии визуальных запросов
    procedure CloseViSession;//Закрытие сессии визуальных запросов
    procedure Assign(Source: TPersistent);override;
    {Расширенный Assign для TOracleDataSet и TVASUPQuery}

    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;
  private
    { Private declarations }
    FLinkedQueries: TLinkedQueryList;
    FLib:TVQLibrary;
    //FWorkForm: TWinControl;
    FKeyWords: TStrings;
    FSQLBit: Variant;
    FShieldSh: bool;
    FOrder: string;
    FAcLevel: TAccessLevel;
    FEditorClassName: string;
    FReportClassName: string;
    FMaster: TOracleDataSet;
    FOnSQLPreparing: TSQLPrepareEvent;
    FBeforeVisualQuery: TBeforeVisualQueryEvent;
    FIsQuery: boolean;
    FWStyle: TWStyle;
    FLinkDetSQL: boolean;
    FLinkKind: TLinkKind;
    FIsLinked:boolean;
    FLinkedDetails: TList;
    FEmbSQLSlice: TStrings;
    FNoFullQuery:bool;{ Флаг запрещения "пустых" запросов,
                           возвращающих все строки}
    FUserFiltered:boolean;{ Флаг отображения записей, которые соответствуют  условиям запроса. }
    FUserCurrFiltered:boolean;{Значения Флага имеет только тогда смысл, когда в UserFiltered установлено значение TRUE
                               флаг указывает, что у текущего ASUPQuery отображать записи только те, которые соответствуют  условиям запроса,
                               если не установлен, то ASUPQuery отображаеть записи все, но с уравнями  более высокими
                               ASUPQuery будет отображатся записи толькоте, которые соответствуют  условиям запроса}
    FBOQ: bool; //Begin of Query List
    FEOQ: bool; //End Of Query List
    FOnFilterChange: TFilterChangeEvent;
    FModifiedASUPQuery : TModifiedASUPQueryEvent; // Событие определяет, были ли модифицированы данные
    FOnSetFilter: TSetFilterEvent;
    FUpdTabAlias: string;
    FRefreshing: bool;
    FSQLFilter: string;
    FSQLFiltered: boolean;
    FTreeNodeIndex: Integer;
    FTreeNodeIndexSync: boolean;
    FDisplayRowCount: Integer;
    FAutoMaster: boolean;
    FUserSQLQuery  : TPartSQLCode; // пользователский SQL запрос
    FUserSQLFilter : TPartSQLCode; // пользователский SQL фильтер
    FAllNoDefaultSQLVariables : THashOfSQLVariables; // Переменые SQL запроса
                                                     // которые не используются в DefaultSQL
    FBrockenSQL : TBrockenSQL; // Разобранный SQL код
    FKeysOfFilters : TStrings; // Ключи фильтров

    FFoundedFields : TKindFields; // Тип полей, по которым будет составляться bookmark и происходить поиск
    FComebackRecord: boolean;     // Возвращаеть ли курсор записи, при потере его по техническим причинам
                                  // например: во время обновления данных(refresh); закрытие и вновь открытие DataSet

    FMasterBookmark  : TBookmarkStr; // Bookmark записи мастера
    FCurrentBookmark : TBookmarkStr; // Bookmark текущей записи

    FFoundedASUPBookmark : boolean;
    { Поиск записи по ASUPBookmark
         true  - был удачный
         false - был не удачный
    }

    FPreWorkState : TWStyle;
    // Предыдущий режим

    FRegisterForms : TList; // Список форм, где используется объект данного класса

    FCancelling : integer; //Идет процесс отмены изменения данных
    FPosting    : boolean; //Идет процесс внесения в БД  изменения данных

    FChangingModeCommand : TCommandUpdated;
    // Какую необходимо выполнить команду, когда запись
    // внесены изменения и выполняется переключения DataSet-а в другой режим
    // cuPost   - команда Post
    // cuCancel - команда Cancel
    // cuNone   - неизвестно какая команда

    FOnChangeWorkState : TVASUPQueryEvent;

    FDataChanged : boolean;
    { Данные были изменены и не сохранены на сервере
    }

    FAfterQuery : TOracleDataSetEvent;

    function GetCencelling : boolean;

    procedure AfterQueryPro(Sender : TOracleDataSet);
    function GetEOQ: bool;
    function GetBOQ: bool;
    function GetChainWeight: Integer;
    procedure SlowOpen;
    function DoSQLCode:string;
    function GetIndexQRY:Integer;
    procedure SetOrder(const Value:string);
    procedure SetSimpleQRY(const Value:TStrings);
    procedure SetDefaultSQL(const Value: string);
    function GetDefaultSQL: string;
    procedure SetEmbeddedSQL(Value:TStrings);
    function GetEditorClass:TFormClass;
    function GetReportClass:TFormClass;
    procedure AfterExecute;
    procedure RegisterMasterVariables; // Объявление переменных мастер-полей
    procedure DropMasterVariables; // Удаление переменных мастер-полей
    procedure WorkWithMaster; // Обрабока активного/неактивного мастера
    function CheckUserDefinedSQL: boolean;
    procedure CancelScreen;
    procedure SetTreeNodeIndex(AValue: Integer);
    procedure SetDisplayRowCount(AValue: Integer);
    function UniqueNameOfVariable(AName : String) : String; overload;
    // Возвращает уникальное имя
    function UniqueNameOfVariable(AName : String; suffix : Integer; var newsuffix : Integer) : String; overload;
    // Возвращает уникальное имя
    // suffix - числовое значение, которое желательно было в конце уникального имени
    // newsuffix - возвращает числовое значение, которое в конце уникального имени

    procedure GetAttrVarOfField(AField : TField; var AVarType : Integer; var AVarName : String);
    // Возвращает имя и тип для создания новой SQL переменной
    // AField поля, с которым будут производится операции сравнения (или другие операции)
    // с  новой созданой переменной

    procedure getUserSQLQuery(  VisualQuery: TVisualQuery;
                        CondSpot: TCondSpot;Status:TQueryStatus;
                        AUserQuery : TPartSQLCode);

    function getUserSQLQueryForMaster(ASQLQuery : String) : String;
    // Возвращает условия для оператора WHERE в SQL запросе мастера

    function GetNameMissionDetailQuery(Detail : TDataSet) : String;
    // Возвращает под каким именем хранится пользовательский запрос Detail в FBrockenSQL

    procedure SetUserFiltered(AValue : boolean);

    procedure SetUserCurrFiltered(AValue : boolean);

    procedure WriteValueFromASUPBookmark(APValue : PChar; AValue : Variant);
    { Записывает в Bookmark значение AValue
      APValue - указатель на позицию в Bookmark-е, куда будет записано значение
    }

    function ReadValueFromASUPBookmark(APValue : PChar; var APNextValue : PChar; AType : Integer; ASize : Integer) : Variant;
    { Читает из Bookmark значение типа AType
      APValue - указатель на позицию в Bookmark-е, где записанно значение переменной
      ASize - кол. байт между позиции, на которую указывает указтель APValue, до конца выделнной памяти bookmark
      APNextValue - возвращает указатель на позицию в Bookmark-е, где записанно значение следующей переменной,
      если нет след. переменной то возвр NIL
    }

    function SizeOfASUPBookmarkValue(AValue : Variant) : Integer;
    { Возвращает количество байтов, которое будет занимать переменная AValue в Bookmark-е
    }

    function SizeOfASUPBookmarkValues(AValues : array of Variant) : Integer; overload;
    { Возвращает количество в байтов, которое будут занимать уникальные значения записи  в Bookmark
      AValues - Уникальные значения записи, которые будут записаны в Bookmark}

    function SizeASUPBookmark(ABookmarkValsSize : Integer) : Integer;
    { Возвращает размер в байтах Bookmark-па
      ABookmarkValsSize - размер в байтах уникальных значения записи,
                          которые будут записаны в Bookmark}

    function GetASUPBookmarkValues(ABookmark : TBookmarkStr) : TArrayOfVariant;
    { Возвращает уникальные значения записи из Bookmark
      Если Bookmark не корректный то, происходит вызов исключения EInvalideBookmark
    }

    function GetASUPBookmarkRecNo(ABookmark : TBookmarkStr) : Integer;
    { Возвращает предполагаемый номер записи, на который сcылается Bookmark}

    function GetRegistForm(Ind : Integer) : TForm;
    { Возвращает форму, которая использует объект данного класса
      Ind - индеск формы в списке
    }

    function GetRegistFormCount : Integer;
    { Возвращает количество форм, которые используют  объект этого класса }

    procedure finalForms;
    { Вызывает метод AnulRegisterASUPQuery у форм
      из списка форм использующих объект данного класса и
      очищает список.
      Метод вызывает только деструктор
    }

    function NoDataInserting(DataSet:TDataSet):bool;

    //procedure buildFinderSQL(ALinkedSQL : TLinkedSQL);
    //procedure breakFinderSQL;
  protected
    { Protected declarations }
    function GetSQLRecordCount: Integer;
    procedure InternalRefresh; override;

    procedure ClearUserSQLQuery;

    procedure DataEvent(Event: TDataEvent; Info: Longint); override;

    procedure ClearAllNoDefaultSQLVaiables;
    procedure ClearNoDefaultSQLVaiables(AMission : String);
    procedure DeclareNoDefaultSQLVariable(AName : String; AType : Integer; AMission : String); overload;
    procedure DeclareNoDefaultSQLVariable(AName : String; AType : Integer; AMission : String; AValue : Variant); overload;
    procedure DeleteNoDefaultSQLVariable(AName : String);
    procedure DeleteNoDefaultSQLVariables(AMission : String);
    procedure DeleteAllNoDefaultSQLVariables;
    function  GetNoDefaultSQLVariable(AName : String) : Variant;
    procedure SetNoDefaultSQLVariable(AName : String; AValue : Variant);
    function GetTypeOfNoDefaultSQLVariable(AName : String) : Integer;
    procedure GetMissions(AMissions : TStrings);

    procedure AddMission(ASQLCode : TPartSQLCode; AMission : String);
    { Добовляет часть кода в SQL запрос в раздел WHERE
    }

    procedure SetMission(ASQLCode : TPartSQLCode; AMission : String);
    procedure DeleteMission(AMission : String);
    procedure DeleteMissions;
    function ExistMission(AMission : String) : boolean;
    //procedure TakeOnMissions;
    //procedure TakeOffMissions;

    procedure SaveUserSQLQuery(CondSpot: TCondSpot;Status:TQueryStatus);

    procedure SaveDetailUserSQLQuery;

    function IsUserQuery : boolean;

    procedure GetFullUserSQLOfDetail(AUserQuery : TPartSQLCode);
    procedure GetUserSQLOfDetail(AUserQuery : TPartSQLCode; AFull : boolean);
    procedure BuildFullUserSQLQuery;
    procedure BuildUserSQLQuery(AUserQuery : TPartSQLCode = Nil);
    procedure BuildUserSQLQueryOfDetails;


    procedure RefrDUserQueryInFinalMaster(Detail : TVASUPQuery);
    { Обновляет пользовательский запрос Detail в FBrockenSQL и в SQL
    }

    procedure RefrDUserQueryInMaster(AUserQuery : TPartSQLCode;
                        Detail : TVASUPQuery; AFinalMaster : TVASUPQuery = nil);
    { Обновляет пользовательский запрос Detail в FBrockenSQL и в SQL,
      Затем вызывает обновление запроса Detail в FBrockenSQL и в SQL у своего мастера.
      AFinalMaster - DataSet который не будет вызывать
      обновление запроса Detail в FBrockenSQL и в SQL у своего мастера.
    }

    procedure RefreshSQL;
    { Записывает в SQL код, который содержится в FBrockenSQL
    }

    function ExistVariable(AVar : String) : boolean; overload;

    function ExistVariable(AVar : String; AMission : String) : boolean; overload;

    function GetVariables(AKey : String) : TSQLVariables;

    procedure SetWorkState(AWorkState : TWStyle); virtual;

    procedure SetActive(Value: Boolean); override;

    procedure SetFoundedFields(AFields : TKindFields); virtual;

    procedure SetComebackRecord(AComeback : boolean);  virtual;

    procedure SaveCurrRecBookmark; virtual;
    { Сохраняет Boormark текущей записи и Boormark мастера
    }

    procedure SetCurrRecBookmark; virtual;
    { Если ComebackRecord = true и текущая запись потеряла
      по каким-то причинам курсор (произошел Refresh или DataSet был закрыт,
      а затем его опять открыли и т.д.),
      то возвращает потерянный курсор текущей записи
    }

    function MakeASUPBookmark : TBookmarkStr; virtual;
    { Создает Bookmark для текущей записи
      В аргументе ABookmark возвращает Bookmark
      Функция возвращает размер Bookmark-а в байтах}

    procedure GotoASUPBookmark(ABookmark : TBookmarkStr); virtual;
    { Устанавливает курсор на запись, на которую ссылается ABookmark
    }

    function SizeOfASUPBookmarkValues(ABookmark : TBookmarkStr) : Integer; overload; virtual;
    { Возвращает количество в байтов, которое будут занимает уникальные значения в Bookmark
    }

    function CompareASUPBookmarks(Bookmark1, Bookmark2: TBookmarkStr): Integer; virtual;

    function IsControlForm(AForm : TForm) : boolean;
    // Возвращает true, если ASUPQuery может управлять формой AForm

    procedure  AfterChangeWorkState; virtual;
    // Метод вызывается при изменении значения WorkState
    // Самостоятельно вызывать его запрещено

    procedure DoAfterScroll; override;
    procedure DoBeforeScroll; override;

    procedure DoAfterPost; override;
    procedure DoBeforePost; override;

    procedure DoAfterCancel; override;
    procedure DoBeforeCancel; override;

    procedure DoAfterClose; override;
    procedure DoBeforeClose; override;

    procedure DoAfterInsert; override;
    procedure DoBeforeInsert; override;

    procedure DoAfterEdit; override;
    procedure DoBeforeEdit; override;

    procedure DoAfterOpen; override;
    procedure DoBeforeOpen; override;

    procedure DoAfterRefresh; override;
    procedure DoBeforeRefresh; override;

    procedure DoAfterDelete; override;
    procedure DoBeforeDelete; override;

    procedure SetAfterQuery(AEvent : TOracleDataSetEvent); virtual;

    procedure InternalPost; override;

    procedure InternalDelete; override;

    procedure CheckWorkState; virtual;
    {Проверяет, соответствует ли значение WorkState состоянию TVASUPQuery,
     если нет, то изменяет значение WorkState на правильное.}

    // Возвращает признак доступа фильтра, хранящихся под ключом  AKey
    // Если нет фильтра хранящихся под ключом, то возвратится false
    function GetEnabledFilterWithKey(AKey : String) : boolean;

    // Устанавливает признак доступа у фильтра, хранящихся под ключом  AKey
    // Если нет фильтра хранящихся под ключом, то ни чего не происходит
    procedure setEnabledFilterWithKey(AKey : String; AEnabled : boolean);
  public
    { Public declarations }

    function  UpdateStatus: TUpdateStatus; override;

    function iSQLText(  VisualQuery: TVisualQuery;
                        CondSpot: TCondSpot;Status:TQueryStatus): string;

    function SQLText(CondSpot: TCondSpot;Status:TQueryStatus): string;

    procedure Post; override;

    procedure ClearAllUserSQLQuerys;
    { Очищает пользователь запрос (очистка происходит даже у Derail-ов)
    }

    procedure RegisterForm(AForm : TForm);
    // регистрирует форму, которая использует объект данного класса
    // AForm - регистрируемая форма
    procedure AnulRegisterForm(AForm : TForm);
    // отменяет регистрацию формы
    // AForm - форма, которая уже не использует данный класс

    property RegistForms[index : Integer] : TForm read GetRegistForm;
    // Список форм, которые использует объект данного класса
    property RegistFormCount : Integer read GetRegistFormCount;
    { Число форм, которые используют  объект этого класса }

    property LinkedQueries: TList read  FLinkedDetails;

    property ChainWeight: Integer read GetChainWeight;

    property IsQuery:boolean read FIsQuery;
    //Находится ли компонент в состоянии ввода запроса

    property DefaultSQL: string read GetDefaultSQL write SetDefaultSQL;
    //SQL-Скрипт, выполняющийся по умолчанию

    //property WorkSpace: TWinControl read FWorkForm write FWorkForm;
    {Определяет владельца компонентов с данными для
    визуального запроса}

    property ShowShield: bool read FShieldSh write FShieldSh;
    //В случае TRUE отображает информационное окно при открытии

    procedure SetSQLFields(const ForeignData:Array of string);
    //Определяет имена полей, участвующих в простых запросах

    property IndexQuery: Integer read GetIndexQRY;
    //Индекс текущего визуального запроса

    property SimpleQuery: TStrings read FKeyWords write SetSimpleQRY;
    {Список значений для поиска по ключевым полям,
    определенным SetSQLFields}

    property BOQ:bool read GetBOQ;

    property EOQ:bool read GetEOQ;

    property FoundedASUPBookmark : boolean read FFoundedASUPBookmark;
    { Поиск записи по ASUPBookmark
         true  - был удачный
         false - был не удачный
    }

    property Cancelling : boolean read GetCencelling;
    //Идет процесс отмены изменения данных
    property Posting    : boolean read FPosting;
    //Идет процесс внесения в БД  изменения данных

    function MasterLinkText:string;
    {Возвращает строку в предложении WHERE с ограничениями
    на мастер-поля}

    procedure BeforeQueryPro(DataSet:TOracleDataSet);
    procedure AfterClosePro(DataSet: TDataSet);
    procedure ReOrder;//Переупорядочение
    procedure ClearDependents;

    function IRefreshRecord(AQuery: TOracleQuery):boolean;

    function CanRefresh : boolean;
    {Проверяет можно ли провести Refresh данных DataSet-а и его DetailSet-ов.
     Если DataSet или один из его DetailSet-ов находится в режиме вставки или редактирования,
     то Refresh нельзя проводить.
    }

    procedure RefrUserQuery(AFinalMaster : TVASUPQuery = nil);
    { Обновляет пользовательский запросы Detail в FBrockenSQL и в SQL у своих мастеров.
      AFinalMaster - DataSet который не будет вызывать
      обновление запроса Detail в FBrockenSQL и в SQL у своего мастера.
    }

    procedure SetUserFilter(AFilter : string);
    procedure DeleteUserFilter;

    procedure Cancel; override;

    procedure ClearCurrRecBookmark; virtual;
    { Очищает сохраненный Bookmark текущей записи
    }

    procedure ClearCurrRecBookmarks; virtual;
    { Очищает сохраненный Bookmark текущей записи и
      сохраненные Bookmark-ы текущих записей у Detail-ов
    }

    function ASUPBookmarkValid(ABookmark : TBookmarkStr) : boolean; virtual;
    {Проверяет на корретность ABookmark
     возвращает true, если ABookmark корректной,
     иначе возвращает false
    }

    property EditorClass: TFormClass read GetEditorClass;
    //Класс формы-редактора

    property ReportClass: TFormClass read GetReportClass;
    //Класс формы-отчета

    property SQLRecordCount: Integer read GetSQLRecordCount;
    //Возвращает кол-во строк по запросу select count(*)
    procedure FillNewVariable(const VarName: string;AField: TField);
    property WorkState: TWStyle read FWStyle write SetWorkState;
    property IsLinkedSQL:boolean read FIsLinked;
    property LinkedQueryList: TLinkedQueryList read FLinkedQueries;
    property QueryLibrary: TVQLibrary read FLib;
    procedure ClearScreen;
    procedure TakeQueryVariables(AQuery: TOracleQuery);
    property SQLFilter:string read FSQLFilter write FSQLFilter;
    property SQLFiltered: boolean read FSQLFiltered write FSQLFiltered;
    procedure SetAccessLevel(AAcLevel : TAccessLevel);
    procedure GetSQLDescription(Index: Integer; SQLDescription:TTreeSQLDescription);
    //property Executed: bool read FExecuted;
    property TNIndexSync: boolean read FTreeNodeIndexSync write FTreeNodeIndexSync;

    property ASUPBookmark : TBookmarkStr read MakeASUPBookmark write GotoASUPBookmark;
    {Нормальный работающий Bookmark, т.к. стандартный Bookmark реализован в DOA
     очень не удачно, и благодаря плохой реализации DOA
     переопределить его нельзя
     (при переопределении возникают в работе DOA ошибки)}

     function MyDataModified : boolean;
     { Возвращает true, если у данного DataSet, а не у Detail-ов,
       данные были изменены и изменения
       не были ни сохранены в БД, ни отменены;
       иначе возвратит false
     }

     function DetailDataModified : boolean;
     { Возвращает true, если данные были изменены в Detail-ах и изменения
       не были ни сохранены в БД, ни отменены;
       иначе возвратит false
     }

     function DataModified : boolean;
     { Возвращает true, если данные были изменены и изменения
       не были ни сохранены в БД, ни отменены;
       иначе возвратит false
     }

     procedure ResetCacheDataChanged;
     { Сброс в TVASUPQuery флажка, который отвечает за то что,
       есть ли в кэше не сохраненные изменения данных.
       Метод обязаетельно нада вызывать, если свойства CachedUpdates
       имеет значение true, в других случаях метод не обязательно вызывать.
       В случае, когда CachedUpdates = true и произошло сохранения
       или отмена изменения данных хранящих в кэше,
       то метод необходимо вызвать, так как по-другому сбросить
       флажок изменения данных нельзя ни как,
       так нет ни одного виртуального метода,
       который можно было переопределить где, и происходило сбрасывания флажка.
       В других случаях метод нельзя вызывать.
     }

     procedure ResetDetailCacheDataChanged;
     { Метод вызывает у всех Detail-ов метод ResetCacheDataChanged
     }

     procedure AddFilterWithKey(AKey : String;
                                ASQLCode : TPartSQLCode);
     {Добавляет SQL фильтр, который будет сохранен под ключом доступа AKey
      ASQLCode - фильтр
     }

     procedure SetFilterWithKey(AKey : String;
                                ANewSQLCode : TPartSQLCode);
     {Заменяет SQL фильтр, который сохранен под ключом доступа AKey
      ASQLCode - новый фильтр
     }

     procedure DeleteFilterWithKey(AKey : String);
     {Удаляет SQL фильтр, который сохранен под ключом доступа AKey
     }

     // Признак доступа фильтра хранящихся под ключом Key
     // при чтении признака доступа у не сохраненного фильтра под ключем Key возвращается значение false
     // при записи признака доступа у не сохраненного фильтра под ключем Key ни чего не происходит
     property EnabledFilterWithKey[Key : String] : boolean read getEnabledFilterWithKey write setEnabledFilterWithKey;
  published
  { Published declarations }

    property Order: string read FOrder write SetOrder;
    //Строка SQL-скрипта после ORDER BY вида: Field1 DESC,Field2 ASC

    property AccessLevel: TAccessLevel read FAcLevel write SetAccessLevel default alHost;
    //Определяет уровень доступа к таблице

    property EditorClassName: string read FEditorClassName write FEditorClassName;
    {имя класса формы-обработчика операций над таблицей
    (чаще форма-наследник TfmWorkForm) }

    property ReportClassName: string read FReportClassName write FReportClassName;
    {имя класса формы-отчета по таблице
    (чаще форма-наследник TfrAnyReport) }

    property LockingMode default lmLockImmediate;

    property OnSQLPreparing:TSQLPrepareEvent read FOnSQLPreparing write FOnSQLPreparing;
    {Событие, возинкающее в методе FromScreen,
     для определения нестандартных SQL-ограничений на поля}

    property OnFilterChange: TFilterChangeEvent read FOnFilterChange
             write FOnFilterChange;
    {Событие, возинкающее в методе OnScreen,
     для визуальных изменений при указании фильтра}

    property ModifiedASUPQuery : TModifiedASUPQueryEvent read FModifiedASUPQuery
                                                        write FModifiedASUPQuery;
    {Событие определяет, были ли модифицированы данные
    }

    property OnSetFilter: TSetFilterEvent read FOnSetFilter write FOnSetFilter;

    property OnChangeWorkState : TVASUPQueryEvent read FOnChangeWorkState
                                                 write FOnChangeWorkState;
    { События возникает при изменении WorkState
    }

    property BeforeVisualQuery: TBeforeVisualQueryEvent
               read FBeforeVisualQuery write FBeforeVisualQuery;
    {Событие перед открытием курсора,
     возникающее в методе Execute}

    property LinkDetailSQL: boolean read FLinkDetSQL write FLinkDetSQL default false;
    {В случае TRUE привязывает дополнительные SQL-предложения из
     привязанных к объекту DataSet'ов}

    property LinkKind:TLinkKind read FLinkKind write FLinkKind default lkExists;

    property EmbeddedSQLSlice:TStrings read FEmbSQLSlice write SetEmbeddedSQL;
    {часть SQL-предложения от FROM до WHERE для вложенного запроса}

    property NoFullQuery:bool read FNoFullQuery write FNoFullQuery default false;
    { Флаг запрещения "пустых" запросов, возвращающих все строки}

    property UpdTabAlias:string read FUpdTabAlias write FUpdTabAlias;

    property TreeNodeIndex:Integer read FTreeNodeIndex write SetTreeNodeIndex;

    property DisplayRowCount: Integer read FDisplayRowCount
                write SetDisplayRowCount default 1;

    property UserFiltered : boolean read FUserFiltered write SetUserFiltered default false;
    { Флаг отображения записей, которые соответствуют  условиям запроса. }

    property UserCurrFiltered:boolean read FUserCurrFiltered write SetUserCurrFiltered default true;
    {Значения Флага имеет только тогда смысл, когда в UserFiltered установлено значение TRUE
     флаг указывает, что у текущего ASUPQuery отображать записи только те, которые соответствуют  условиям запроса,
     если не установлен, то ASUPQuery отображаеть записи все, но с уравнями  более высокими
     ASUPQuery будет отображатся записи толькоте, которые соответствуют  условиям запроса}

    property FoundedFields : TKindFields read FFoundedFields write SetFoundedFields default kfRowid;
    {Тип полей, по которым будет составляться bookmark и происходить поиск}
    property ComebackRecord : boolean read FComebackRecord write SetComebackRecord default true;
    {Возвращаеть ли курсор записи, при потере его по техническим причинам
     например: во время обновления данных(refresh); закрытие и вновь открытие DataSet}

    property ChangingModeCommand : TCommandUpdated read FChangingModeCommand write FChangingModeCommand default cuNone;
    // Какую необходимо выполнить команду, когда запись
    // внесены изменения и выполняется переключения DataSet-а в другой режим
    // cuPost   - команда Post
    // cuCancel - команда Cancel
    // cuNone   - неизвестно какая команда

    property AfterQuery : TOracleDataSetEvent read FAfterQuery write SetAfterQuery;
  end;


  TVWatchEdit= class;


  TBtnClickEvent= procedure (Sender: TObject; var UseInherited: boolean) of
                  object;

  TAcceptValueEvent= procedure (Sender: TObject; var UseInherited: boolean) of
                  object;

  TDisplayInfo= record
                  DWidth: Integer;
                  DFormat: string[CDisplayLen];
                  DLabel: string[CDisplayLen];
                end;

  PTDisplayInfo= ^TDisplayInfo;

  TStrFldList= class(TStringList)
    constructor Create;
    destructor Destroy;override;
    private
      FDList: TList;
      function GetDisplays(Index: Integer):TDisplayInfo;
      procedure SetDisplays(Index: Integer;AValue:TDisplayInfo);
    public
      procedure AddPlus(NewString: string;ADWidth:Integer;NewObject: TObject);
      procedure Clear;override;
      property Displays[Index: Integer]:TDisplayInfo read GetDisplays write SetDisplays;
  end;

  TVWatchEdit= class(TVCustomEditwButton)
  {Используется для кодов,берущихся из справочных таблиц.
  Может отображать дополнительную информацию
  (например, наименование кода из справочника) в виде стандартной
  подсказки Delphi (Hint). Также поддерживает линейно-связанные
  справочные таблицы}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  private
    FTabName: string;
    FHintName: string;
    FKeyName: string;
    FCapEyes: string;
    FOwner: string;
    FSearch:TForm;
    FShowEyes:bool;
    FMaster: TVWatchEdit;
    FWeakMaster: TVWatchEdit;
    FClickEvent: TBtnClickEvent;
    FBeforeShowSearchForm: TNotifyEvent;
    FAcptValEvent: TAcceptValueEvent;
    FDetailList,FMasterList: TStrings;
    FAutoLocate: boolean;
    procedure SetOwnerTable(const Value: string);
    function GetTaName: string;
    procedure SetTaName(const Value:string);
    function GetCaption: string;
    function GetFieldLabel(const AFieldName: string): string;
    procedure OwnerTableByDefault;
    procedure One2Two;
    function GetKeyName:string;
    procedure SetKeyName(const Value:string);
    procedure SetHintName(const Value:string);
    procedure CloseEyes;
    procedure WorkProc;
    procedure GenerateList;
    function AFTER_WHERE(const FullList:boolean):string;
    function AFTER_SELECT:string;
    function GetEyesQuery: TVASUPQUery;
  protected
    FNonDefMstr: TStrFldList;
    FList: TStrings;
    procedure Settings;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMLBUTTONDBLCLK(var Message: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMMOUSEMOVE(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure WMKEYDOWN(var Message: TWMKey);message WM_KEYDOWN;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure EditButtonClick(Sender: TObject); override;
    procedure ClearHint(Sender: TObject);
  published
    property Master: TVWatchEdit read FMaster write FMaster;
             {Определяет компонент, отображающий Мастер-код
              (т.е. код, берущийся из справочной таблицы,
              являющейся главной для справочника данного компонента)}

    property WeakMaster: TVWatchEdit read FWeakMaster write FWeakMaster;
             {Определяет компонент, отображающий Мастер-код
              но поддержка связи осуществляется самостоятельно
              пользователем компонента}

    property KeyField: string read GetKeyName write SetKeyName;
             //Определяет имя ключевого поля в справочной таблице

    property HintField: string read FHintName write SetHintName;
             //Имя дополнительного поля из справочника для подсказки

    property OwnerTable: string read FOwner write SetOwnerTable;
             //Владелец справочной таблицы

    property TableName: string read GetTaName  write SetTaName;
             //Имя справочной таблицы

    property ShowEyes: bool read FShowEyes write FShowEyes default true;
             {В случае TRUE отображается диалог выбора
              данных из справочника при нажатии клавиши Пробел либо
              двойной щелчок мыши}

    property OnButtonClick:TBtnClickEvent read FClickEvent write FClickEvent;

    property OnAcceptValue:TAcceptValueEvent read FAcptValEvent write FAcptValEvent;

    property AutoLocate: boolean read FAutoLocate write FAutoLocate default false;

    property BeforeShowSearchForm: TNotifyEvent read FBeforeShowSearchForm write FBeforeShowSearchForm;
  public
    procedure OpenQRY(SearchForm: TForm);virtual;
              {Октрывает справочник в форме SearchForm}

    property TableCaption: string read GetCaption;
             //Заголовок справочной таблицы

    property EyesForm: TForm read FSearch;

    property EyesQuery: TVASUPQuery read GetEyesQuery;
  end;


 TVMyTable = class(TTable)
 private
   FEditorClassName: string;
   FReportClassName: string;
   FCaption: string;
   function GetEditorClass:TFormClass;
   function GetReportClass:TFormClass;
 public
   property EditorClass: TFormClass read GetEditorClass;
    //Класс формы-редактора

   property ReportClass: TFormClass read GetReportClass;
    //Класс формы-отчета
 published

   property Caption: string read FCaption write FCaption;
             // Комментарий на таблицу

   property EditorClassName: string read FEditorClassName write FEditorClassName;
    {имя класса формы-обработчика операций над таблицей
    (чаще форма-наследник TfmWorkForm) }

   property ReportClassName: string read FReportClassName write FReportClassName;
    {имя класса формы-отчета по таблице
    (чаще форма-наследник TfrAnyReport) }
 end;

{ TOrderProperty= class(TPropertyEditor)
   function GetAttributes: TPropertyAttributes;override;
   function GetValue:string;override;
   procedure SetValue(const Value: string);override;
   procedure Edit;override;
 end;
}
 { TVBuilder }

 TVBuilder = class(TComponent)
 {Для заполнения комментариями поля объектов типа TVASUPQuery
 в режиме DesignTime}
  private
    { Private declarations }
    FAction: boolean;
    procedure SetAct(const Value: boolean);
    procedure Building;
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  property Active:boolean read FAction write SetAct;
  {В случае TRUE переоткрывает все компоненты типа TVASUPQuery, лежащие
  на той же форме, предварительно установив ReActive в FALSE}
 end;

const
  CyrLayout : PChar = '00000419'; {LANG_RUSSIAN}
  USLayout  : PChar = '00000409'; {LANG_ENGLISH}

type

 TVDBERus = class(TVDBEditChar)
 { автоматическое переключение на русскую
 раскладку клавиатуры}
  constructor Create(AOwner: TComponent);override;
  private
    FRusWall: bool;
    FAutoSwitch: bool;
    FLayOut: HKL;
    function InLaw(Key:Char):bool;
    procedure SafePress(var KP: TWMCHAR);message wm_Char;
    { Private declarations }
  protected
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    { Protected declarations }
  public
    { Public declarations }
  published
    property RusCase: bool read FRusWall write FRusWall default true;
    property AutoSwitch: bool read FAutoSwitch write FAutoSwitch default true;
    // В случае TRUE запрещает ввод букв латинского алфавита
  end;

  TVDBEDate = class(TVCustomEditwButton)
  {Отображает календарь для выбора даты
   Двойной щелчок или клавиша Пробел}
   constructor Create(AOwner: TComponent);override;
  private
    FClickEvent: TBtnClickEvent;
    FInitDate: TDateTime;
    procedure ShowCalendarBody;
    procedure SetInitDate(Value: TDateTime);
    { Private declarations }
  protected
    procedure WMLBUTTONDBLCLK(var Message: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMKEYDOWN(var Message: TWMKey);message WM_KEYDOWN;
    procedure EditButtonClick(Sender: TObject); override;
    { Protected declarations }
  public
    { Public declarations }
    property InitDate: TDateTime read FInitDate write SetInitDate;
  published
    { Published declarations }
    property OnButtonClick:TBtnClickEvent read FClickEvent write FClickEvent;
  end;

const
  CDEFAULTCONTEXT='SNAIM';
  CDEFAULTKEY='KOD';
  CIncorrectParams='Неверные параметры';

type
 TManual= record
            Name: string;
            Key: string;
            Context:string;
          end;

 TPManual= ^TManual;

 TManuals= class(TList)
 private
   function GetSlice(Index: Integer):TManual;
 public
   function Add(const AName:string):Integer;
   function AddEx(const AName,AKey,AContext:string):Integer;
   procedure Delete(Index:Integer);
   procedure Clear;
   destructor Destroy;override;
   property Slices[Index:Integer]:TManual read GetSlice;default;
 end;

const
  ROOT_SYMBOL= '...';
  PATH_SEPARATOR= '\';

type
 TVMetaDataSource= class;

 TMetaChangeEvent= procedure (DataSet: TDataSet;const NewIndex: Integer) of Object;

 TCollectionDataSet= class(TCollectionItem)
 private
   FDataSet: TDataSet;
   FName: string;
 published
   property DataSet:TDataSet read FDataSet write FDataSet;
   property DataSetName: string read FName write FName;
 end;

 TDataSets= class(TCollection)
 private
   FOwner: TVMetaDataSource;
   function GetItem(Index:Integer):TCollectionDataSet;
 public
   constructor Create(AOwner:TVMetaDataSource);
   function IndexOf(ADataSet: TDataSet):Integer;
   procedure Assign(Source: TPersistent); override;
   property Items[Index: Integer]:TCollectionDataSet read GetItem;default;
 end;

 TVMetaDataSource=class(TDataSource)
   constructor Create(AOwner:TComponent);override;
   destructor Destroy;override;
 private
   FSets: TDataSets;
   FIndex: Integer;
   FOnMetaChanging: TMetaChangeEvent;
   FOnMetaChange: TMetaChangeEvent;
   procedure SetDataSetList(const Value: TDataSets);
   procedure SetIndex(const Value: Integer);
   function GetItem(Index: Integer): TDataSet;
   function GetCount:Integer;
 published
   property DataSetList:TDataSets read FSets write SetDataSetList;
   // Список объектов Dataset

   property OnMetaChange:TMetaChangeEvent read FOnMetaChange write FOnMetaChange;
   property OnMetaChanging:TMetaChangeEvent read FOnMetaChanging write FOnMetaChanging;
 public
   property Items[Index: Integer]:TDataSet read GetItem ;default;
   // Возвращает DataSet из списка с индеком Index

   property SelectedIndex:Integer read FIndex write SetIndex;
   // Индекс текущего DataSet в списке

   property Count:Integer read GetCount;//Длина списка объектов DataSet
   procedure Notification( AComponent: TComponent; Operation: TOperation);override;
   procedure Next;
   {Переход к следующему элементу списка,
    учитывая связь master-detail}

   procedure Prior;
   {Переход к предыдущему элементу списка,
    учитывая связь master-detail. При этом текущий DataSet закрывается}

   procedure Start;// Открытие первого элемента DataSet в списке (Index=0)
   procedure AddToList(ADataSet: TDataSet);// Добавить в список новый DataSet
   function PathToDataSet(const DisplayFieldName: string):string;
     { Отображение пути к текущему DataSet в стиле Internet Explorer,
      используя связь master-detail, согласно данным поля DisplayFieldName}

   function BOL:boolean; // Начало списка
   function EOL:boolean; // Конец списка
   procedure DirectMove(Index: Integer);
   {Переход к элементу DataSet с индексом Index,
   не учитывая связей master-detail}

   procedure Close;// Закрытие всех элементов списка
 end;

const
  CManyIDs='Only one TVEditFormID component is allowed on the selected form';
  CDefaulIDName='id';


{ * Public function }

function OriginFieldName(Field: TField):string;

function IsLyingOn(Area: TWinControl;Control: TControl):bool;
         {Определяет лежит ли Control на Area}

function FindActCtrl(ParentArea: TWinControl): TWinControl;
         {Возвращает первый активный Control в соответствии с TabOrder,
          принадлежащий дереву ParentArea}

procedure Cut(const SubStr:string; var S,Slice:string);
         {Вырезает из S первое вхождение строки SubStr, в Slice помещается
         текст S до строки, в S - текст после Substr}

function ReplaceSTR(Source:string;const OldSub,NewSub: string): string;
         {Заменяет каждое вхождение подстроки OldSub
          на подстроку NewSub}

function InBrack(const Poor:string):string;//Оборачивает Poor в одинарные кавычки
function InBrack2(const Poor:string):string;

procedure AskSingleManual( AQuery: TOracleQuery;const AName,AKey,AContext:string;
                           KeyField,ResField: TField);
{ Служит для выборки дополнительной информации из справочных таблиц.
  AQuery - Компонент для выполения SQL-скрипта. Создается заранее;
  AName - имя справочной таблицы;
  AKey  - имя ключевого поля таблицы AName;
  AContext - имя поля с требуемой информацией;
  KeyField - поле со значением для ключа AKey;
  ResField - поле, где сохраняется результат из поля AContext}

procedure AskHim( AQuery: TOracleQuery; const AName: string;
                  KeyField,ResField: TField);
{ Обертка вокруг AskSingleManual.
  AKey='KOD';
  AContext='SNAIM'}

procedure AskManuals( AQuery: TOracleQuery;Map: TManuals;
                      const Keys: Array of TField;const Results: Array of TField);
{ Обобщение процедуры AskSingleManual на множественное число справочников
  за одно обращение к серверу БД}

procedure AskThem( AQuery: TOracleQuery;const Manuals: Array of string;
                   const Keys: Array of TField;const Results: Array of TField);
{ Обертка вокруг AskManuals.
  Ключевое поле= 'KOD';
  Контекст= 'SNAIM'}

procedure Com_AskListOfThem( AQuery: TOracleQuery; const Manuals: Array of string;
                         ResFieldName: string; const Keys: Array of TField;
                         const Results: Array of TField);
{Выборка поля ResFieldName из справочника Manuals[High(Manuals)]
 учитывая master-detail связи в
 списке линейно-связанных справочников Manuals,
 согласно данным для полей 'KOD' }

procedure AskListOfThem( AQuery: TOracleQuery;const Manuals: Array of string;
                         const Keys: Array of TField;const Results: Array of TField);
{Выборка поля SNAIM из справочника Manuals[High(Manuals)]
 учитывая master-detail связи в
 списке линейно-связанных справочников Manuals,
 согласно данным для полей 'KOD' }

function GetWinUserName: string; //Определяет имя пользователя Windows

function Descander(Desc,Host: TObject):bool;
         {Возвращает TRUE в случае, когда Host=Desc
          или Host является владельцем Desc}

function FindDataControl(Owner: TComponent;Field:TField):TComponent;
         {Находит первый компонент,чьим владельцем является Owner
          , имеющий св-во DataField=Field.FieldName}

procedure ReplaceKeyboardLayOut(var LastKL: HKL;NewLName:PChar);
          {Установка русской раскладки клавиатуры
          в LastKL сохраняется предыдущая раскладка}

procedure MoveVariablesToQuery(Source:TOracleDataSet;Dest: TOracleQuery);
          // Объявление и заполнение данными переменных из Source в Dest

procedure MoveVariablesToSet(Source,Dest:TOracleDataSet);
          // Объявление и заполнение данными переменных из Source в Dest

procedure CreateFieldTemplates(Source,Dest: TDataSet);
          {Для Dest создает и заполняет компоненты типа TField,
          дублируя последних у Source}

function StatePUMenuToStr(const State: TStatePUMenu):string;

procedure StandardWeakMasterSupport(AWatchEdit: TVWatchEdit);
          {Поддержка свзяи master-detail при условии weak master}

function VarSize(const V: Variant): Integer;
          {Возвращает размер переменной в байтах}

function GetMemVar(const V: Variant): Pointer;
           {Сохраняет значение переменой в динамической памяти}

function MemVarToVar(const P : Pointer) : Variant;
           {Возвращет значение переменой из динамической памяти}

function TypeSize(const AType: Integer): Integer;
          {Возвращает размер типа в байтах}

function VarTypeField(const Field : TField): Integer;

function IsEmptyRecord( ADataSet: TDataSet;
                        const UnImportants:Array of TField):bool;

function IsFormWithWorkStyle(AForm : TForm) : boolean;
{ Проверяет, содержит ли форма свойства WorkStyle с типом TWStyle
}

function GetWorkStyleOfForm(AForm : TForm) : TWStyle;
// возвращает значения свойства WorkStyle формы AForm

const
  VARIANT_VALUETYPE= 0;
  FIELD_VALUETYPE= 1;
  NO_VALUETYPE= -1;

function RegisterTempVariable(AField: TField;
                              var AVarType : Integer):string; overload;
function RegisterTempVariable(AField: TField; ValueType:Integer;
                              const AValue: Variant):string; overload;
// регистрация временной переменной привязки

procedure CopyTempVariables(Receiver,Sender: TOracleDataSet); // старый код
// копирование временных переменных

procedure VarToField(const AValue: Variant; AField: TField);

function LPad(AString: String;Len:Integer;AChar: Char):string;

function RPad(AString: String;Len:Integer;AChar: Char):string;

// Строку разбивает на подстроки, разделителяем считаем точку запятой
procedure StringToStringsWithSemicolon(Value : String; AStrs : TStrings);

// Записывает в буфер обмена строку символов
procedure writeTextInClipboard(AValue : String);

// Читает из буфер обмена строку символов
function  readTextInClipboard : String;

implementation
{$D+}
uses v_Eyes, v_Sort, v_enumdes, v_ASUPForm;

type
  TFieldRef= class of TField;

  PInteger = ^Integer;
  PDateTime = ^TDateTime;

const
  TempVarHeader= ':TMPVAR$_';


function IsEmptyRecord( ADataSet: TDataSet;
                        const UnImportants:Array of TField):bool;
var
  I: Integer;

function InArray(Field:TField):bool;
var
  J: Integer;
begin
  J:= Low(UnImportants);
  Result:= false;
  while (J<= High(UnImportants)) and not Result do
  begin
    Result:= Field= UnImportants[J];
    Inc(J);
  end;
end;


begin
  I:= 0;
  while (I<ADataSet.FieldCount)
        and ( (ADataSet.Fields[I].FieldKind<> fkData) or
              ADataSet.Fields[I].IsNull or InArray(ADataSet.Fields[I])
              ) do Inc(I);
  Result:= I=ADataSet.FieldCount;
end;

function IsFormWithWorkStyle(AForm : TForm) : boolean;
var
  propInfo : PPropInfo;
  typeInfo : PTypeInfo;
begin
  result := false;

  if AForm is TfmASUPForm then
  begin
    // ПРоверяем, содержит ли форма свойство WorkStyle типа TWStyle
    propInfo := GetPropInfo(AForm, 'WorkStyle');
    if Assigned(propInfo) then
    begin
      // Форма содержит свойство WorkStyle
      // ПРоверяем является ли тип свойства WorkStyle типом TWStyle
      typeInfo := propInfo^.PropType^;
      if typeInfo^.Name = 'TWStyle' then
        Result := true;
    end;
  end;
end;

function GetWorkStyleOfForm(AForm : TForm) : TWStyle;
begin
  Result := wsNone;

  if IsFormWithWorkStyle(AForm) then
    // Читаем значения свойства WorkStyle формы AForm
    Result := TWStyle(GetOrdProp(AForm, 'WorkStyle'));
end;

procedure VarToField(const AValue: Variant; AField: TField);
begin
  if VarIsNull(AValue) or VarIsEmpty(AValue) then AField.Clear
  else AField.Value:= AValue;
end;

function RegisterTempVariable(AField: TField;
                              var AVarType : Integer):string;
begin
  case AField.DataType of
    ftString: AVarType:= otString;
    ftDateTime: AVarType:= otDate;
    ftFloat: AVarType:= otFloat;
    else AVarType:= otInteger
  end;
  Result:= TempVarHeader+UpperCase(AField.DataSet.Name)+'_'+
           IntToStr(AField.Index);
end;

function RegisterTempVariable(AField: TField; ValueType:Integer; const AValue: Variant):string;
var
  OraType: Integer;
begin
  case AField.DataType of
    ftString: OraType:= otString;
    ftDateTime: OraType:= otDate;
    ftFloat: OraType:= otFloat;
    else OraType:= otInteger
  end;
  Result:= TempVarHeader+UpperCase(AField.DataSet.Name)+'_'+
           IntToStr(AField.Index);
  //AField.FieldName;
  with AField.DataSet as TOracleDataSet do
  begin
    DeclareVariable(Result,OraType);
    case ValueType of
      VARIANT_VALUETYPE: SetVariable(Result,AValue);
      FIELD_VALUETYPE: SetVariable(Result,AField.Value);
    end;
  end;
end;


function  InBrack;
begin
  Result:= Concat('''',Poor,'''');
end;

function  InBrack2;
begin
  Result:= Concat('[ ',Poor,' ]');
end;

procedure MovingFields(Source,Dest: TField);
begin
  with Source do
  begin
    Dest.OnChange:= OnChange;
    Dest.Origin:= Origin;
    Dest.Required:= Required;
    Dest.Size:= Size;
    Dest.DisplayLabel:= DisplayLabel;
    Dest.DisplayWidth:= DisplayWidth;
    Dest.FieldName:= FieldName;
    Dest.Index:= Index;
    Dest.EditMask:= EditMask;
    Dest.Visible:= Visible;
    Dest.FieldKind:= FieldKind;
    Dest.Tag:=Tag ;
    if Source is TNumericField then
      with Source as TNumericField do
      begin
        (Dest as TNumericField).DisplayFormat:= DisplayFormat;
        (Dest as TNumericField).EditFormat:= EditFormat;
      end;
    if Source is TDateTimeField then
      with Source as TDateTimeField do
      begin
        (Dest as TDateTimeField).DisplayFormat:= DisplayFormat;
        (Dest as TDateTimeField).EditMask:= EditMask;
      end;
  end;
end;

procedure CreateFieldTemplates(Source,Dest: TDataSet);
var
  I: Integer;

procedure Creating(Sample: TField);
var
  Field: TField;
begin
  Field:= TFieldRef(Sample.ClassType).Create(Sample.DataSet);
  Field.Name:= Concat(Dest.Name,Sample.FieldName);
  MovingFields(Sample,Field);
  Field.DataSet:= Dest;
end;

begin
  with Source.Owner do
    for I:= 0 to ComponentCount-1 do
      if Components[I] is TField and ((Components[I] as TField).DataSet=Source)
        then Creating(TField(Components[I]));
end;

function EditorTextMargins(Editor: TVCustomEditwButton): TPoint;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  with Editor do begin
    if NewStyleControls then begin
      if BorderStyle = bsNone then I := 0
      else if Ctl3D then I := 1
      else I := 2;
      Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
      Result.Y := I;
    end
    else begin
      if BorderStyle = bsNone then I := 0
      else begin
        DC := GetDC(0);
        GetTextMetrics(DC, SysMetrics);
        SaveFont := SelectObject(DC, Font.Handle);
        GetTextMetrics(DC, Metrics);
        SelectObject(DC, SaveFont);
        ReleaseDC(0, DC);
        I := SysMetrics.tmHeight;
        if I > Metrics.tmHeight then I := Metrics.tmHeight;
        I := I div 4;
      end;
      Result.X := I;
      Result.Y := I;
    end;
  end;
end;

function PaintEditwButton(Editor: TVCustomEditwButton; const AText: string;
  AAlignment: TAlignment; UseStandardPaint: Boolean; var ACanvas: TControlCanvas;
  var Message: TWMPaint): Boolean;
var
  AWidth, ALeft: Integer;
  Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  ExStyle: DWORD;
const
  AlignStyle: array[Boolean, TAlignment] of DWORD =
   ((WS_EX_LEFT, WS_EX_RIGHT, WS_EX_LEFT),
    (WS_EX_RIGHT, WS_EX_LEFT, WS_EX_LEFT));
begin
  Result := True;
  with Editor do
  begin
    if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
    if UseStandardPaint and not
      (csPaintCopy in ControlState) then
    begin
      if SysLocale.MiddleEast and HandleAllocated and (IsRightToLeft) then
      begin { This keeps the right aligned text, right aligned }
        ExStyle := DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) and (not WS_EX_RIGHT) and
          (not WS_EX_RTLREADING) and (not WS_EX_LEFTSCROLLBAR);
        if UseRightToLeftReading then
          ExStyle := ExStyle or WS_EX_RTLREADING;
        if UseRightToLeftScrollbar then
          ExStyle := ExStyle or WS_EX_LEFTSCROLLBAR;
        ExStyle := ExStyle or
          AlignStyle[UseRightToLeftAlignment, AAlignment];
        if DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) <> ExStyle then
          SetWindowLong(Handle, GWL_EXSTYLE, ExStyle);
      end;
      Result := False;
      { return false if we need to use standard paint handler }
      Exit;
    end;
    { Since edit controls do not handle justification unless multi-line (and
      then only poorly) we will draw right and center justify manually unless
      the edit has the focus. }
    if ACanvas= nil then
    begin
       ACanvas := TControlCanvas.Create;
       ACanvas.Control := Editor;
    end;
    DC := Message.DC;
    if DC = 0 then DC := BeginPaint(Handle, PS);
    ACanvas.Handle := DC;
    try
      ACanvas.Font := Font;
      if not Enabled and NewStyleControls and not
        (csDesigning in ComponentState) and
        (ColorToRGB(Color) <> ColorToRGB(clGrayText)) then
        ACanvas.Font.Color := clGrayText;
      with ACanvas do
      begin
        R := ClientRect;
        if  not (NewStyleControls and Ctl3D) and
          (BorderStyle = bsSingle) then
        begin
          Brush.Color := clWindowFrame;
          FrameRect(R);
          InflateRect(R, -1, -1);
        end;
        Brush.Color := Color;
        S := AText;
        AWidth := TextWidth(S);
        Margins := EditorTextMargins(Editor);
        if ButtonWidth > 0 then Inc(AWidth);
        case AAlignment of
          taLeftJustify:
            ALeft := Margins.X;
          taRightJustify:
           // if Length(S)>0 then
              ALeft := ClientWidth - ButtonWidth - AWidth - Margins.X - 2;
            //else ALeft := Margins.X;
          else
            ALeft := (ClientWidth - ButtonWidth - AWidth) div 2;
        end;
        if SysLocale.MiddleEast then UpdateTextFlags;
        TextRect(R, ALeft, Margins.Y, S);
      end;
    finally
      ACanvas.Handle:= 0;
      if Message.DC = 0 then EndPaint(Handle, PS);
    end;
  end;
end;

function OriginFieldName(Field: TField):string;
begin
  Result:= Field.Origin;
  if Length(Result)=0 then Result:= Field.FieldName;
end;

const
  UnknownUser= 'НЕИЗВЕСТЕН';
  MaxUserLen= 30;

function GetWinUserName;
var
  Name:array[0..MaxUserLen] of char;
  SzBuffer: DWORD;
begin
  SzBuffer:= MaxUserLen;
  if not GetUserName(Name,SzBuffer) then
    Result:= UnknownUser
  else Result:= AnsiUpperCase(Name);
end;

procedure Cut(const SubStr:string; var S,Slice:string);
var
  SubPos:Integer;
begin
  SubPos:= Pos(SubStr,S);
  if SubPos=0 then
  begin
    Slice:= S;
    S:= '';
  end
  else
  begin
    Slice:= Copy(S,1,SubPos-1);
    S:= Copy(S,SubPos+Length(SubStr),Length(S));
  end;
end;

// Записывает в буфер обмена строку символов
procedure writeTextInClipboard(AValue : String);
var
  arr : PChar;
  len : Integer;
  I : Integer;
  GMen : HGLOBAL;
begin
  if OpenClipboard(Application.Handle) then
  begin
    try
      EmptyClipboard;
      len := Length(AValue);
      GMen := GlobalAlloc(GHND, len + 1);
      arr := GlobalLock(GMen);
      for I := 1 to len do
        arr[I - 1] := AValue[I];
      arr[len] := chr(0);
      GlobalUnlock(GMen);
      SetClipboardData(CF_TEXT, GMen);
    finally
      CloseClipboard;
    end;
  end;
end;

// Читает из буфер обмена строку символов
function readTextInClipboard : String;
var
  arr : PChar;
  len : Integer;
  I : Integer;
  GMen : HGLOBAL;
begin
  Result := '';
  if OpenClipboard(Application.Handle) then
  begin
    try
      GMen := GetClipboardData(CF_TEXT);
      arr := GlobalLock(GMen);

      len := 0;
      // Определяем длину строки
      while arr[len] <> chr(0) do
        inc(len);
      SetLength(Result, len);

      for I := 1 to len do
        Result[I] := arr[I - 1];

      GlobalUnlock(GMen);

    finally
      CloseClipboard;
    end;
  end;
end;

procedure StandardWeakMasterSupport(AWatchEdit: TVWatchEdit);
begin
  with AWatchEdit do
  begin
    SetFocus;
    with TVASUPQuery(EyesQuery) do
      if not WeakMaster.Field.IsNull then
      begin
        SQLFilter:= Format('%s=:P1',[WeakMaster.Field.FieldName]);
        DeclareVariable('P1',otInteger);
        SetVariable('P1',WeakMaster.Field.AsInteger);
        SQLFiltered:= true;
      end
      else SQLFiltered:= false;
  end;
end;

function FindActCtrl(ParentArea: TWinControl): TWinControl;
var
  I: Integer;
  MinIndex,MinTabOrder: Integer;
begin
  with ParentArea do
  if Showing and Enabled then
  begin
    MinTabOrder:= ControlCount;
    MinIndex:= -1;
    for I:= 0 to ControlCount-1 do
      if Controls[I] is TWinControl then
        with Controls[I] as TWinControl do
          if Showing and Enabled
             and ( ( (ControlCount>0)
                   and not Assigned(GetPropInfo( ClassInfo,'DataSource'))
                   ) or TabStop
                 )
             and (TabOrder<MinTabOrder) then
          begin
            MinTabOrder:= TabOrder;
            MinIndex:= I;
          end;
    if (MinTabOrder<ControlCount)
       and not Assigned(GetPropInfo( ParentArea.ClassInfo,'DataSource')) then
       Result:= FindActCtrl(Controls[MinIndex] as TWinControl)
    else Result:= ParentArea;
  end
  else Result:= nil;
end;

function EqualSent(S1,S2: string):bool;
var
  Pos1,Pos2: Integer;
begin
  Result:= true;
  repeat
    S1:= Trim(S1);
    S2:= Trim(S2);
    Pos1:= Pos(' ',S1);
    Pos2:= Pos(' ',S2);
    if (Pos1=0) or (Pos2=0) then Result:= CompareText(S1,S2)=0
    else begin
      if CompareText(Copy(S1,1,Pos1-1),Copy(S2,1,Pos2-1))=0 then begin
        S1:= Copy(S1,Pos1+1,Length(S1)-Pos1);
        S2:= Copy(S2,Pos2+1,Length(S2)-Pos2);
      end
      else Result:= false;
    end;
  until not Result or (Pos1=0) or (Pos2=0);
end;

procedure AskSingleManual;
var
  ManualList: TManuals;
begin
  ManualList:= TManuals.Create;
  ManualList.AddEx(AName,AKey,AContext);
  try
    AskManuals(AQuery,ManualList,[KeyField],[ResField]);
  finally
    ManualList.Free;
  end;
end;

procedure AskHim;
begin
  AskSingleManual(AQuery,AName,CDEFAULTKEY,CDEFAULTCONTEXT,
    KeyField,ResField);
end;

procedure AskManuals;
var
  I,J: Integer;
  Head,Body,Tail: string;
  ParamName: string;
begin
  if (Map.Count-1<>High(Keys)) or (High(Keys)<>High(Results)) or (Map.Count=0) then
    raise Exception.Create(CIncorrectParams)
  else
  begin
    Head:= '';
    Body:= '';
    Tail:= '';
    AQuery.DeleteVariables;
    for I:= 0 to Map.Count-1 do
      if not Keys[I].IsNull then
      begin
        if Head<>'' then Head:= Head+',';
        Head:= Head+Format('T%d.%s',[I,Map[I].Context]);
        if Body<>'' then Body:= Body+',';
        Body:= Body+Map[I].Name+Format(' T%d',[I]);
        if Tail<>'' then Tail:= Tail+' AND ';
        ParamName:= Format(':Param%d',[I]);
        Tail:= Tail+ Format('T%d.%s (+) = %s',[I,Map[I].Key,ParamName]);
        case Keys[I].DataType of
          ftDateTime: AQuery.DeclareVariable(ParamName,otDate);
          ftSmallInt,ftInteger: AQuery.DeclareVariable(ParamName,otInteger);
          ftFloat: AQuery.DeclareVariable(ParamName,otFloat);
          else AQuery.DeclareVariable(ParamName,otString);
        end;
        AQuery.SetVariable(ParamName,Keys[I].Value);
      end
      else Results[I].Clear;
    if Head<>'' then
    with AQuery do
    begin
      SQL.Text:= Format('SELECT %s FROM %s WHERE %s',[Head,Body,Tail]);
      Execute;
      DeleteVariables;
      if not EOF then
      begin
        J:= 0;
        for I:= 0 to Map.Count-1 do
        begin
          if Assigned(Results[I]) and not Keys[I].IsNull then
             Results[I].AsString:= FieldAsString(J);
          Inc(J);
        end
      end
      else for I:= 0 to High(Results) do
        if Assigned(Results[I]) then Results[I].Clear;
      Close;
    end
    else for I:= 0 to High(Results) do
      if Assigned(Results[I]) then Results[I].Clear;
  end;
end;

procedure AskThem;
var
  ManualList: TManuals;
  I: Integer;
begin
  ManualList:= TManuals.Create;
  for I:= 0 to High(Manuals) do ManualList.Add(Manuals[I]);
  try
    AskManuals(AQuery,ManualList,Keys,Results);
  finally
    ManualList.Free;
  end;
end;

procedure Com_AskListOfThem(AQuery: TOracleQuery;const Manuals: Array of string;
  ResFieldName: string; const Keys: Array of TField;
  const Results: Array of TField);

var
  I,J: Integer;
  Selects: TStrings;
  sqlWhere: string;
  FieldNames: TStrings;

procedure GenerateFieldNames(const N: Integer);
var
  K: Integer;

function WithOutOwner(const FullTableName: string):string;
var
  PosOfPoint: Integer;
begin
  PosOfPoint:= Pos('.',FullTableName);
  if PosOfPoint>0 then Result:= Copy(FullTableName,PosOfPoint+1,
                                     Length(FullTableName)-PosOfPoint)
  else Result:= FullTableName;
end;

begin
  if N>0 then
  begin
    GenerateFieldNames(N-1);
    sqlWhere:= '';
    for K:= 0 to FieldNames.Count-1 do
    begin
      FieldNames[K]:= Concat(WithOutOwner(Manuals[N-1]),'_',FieldNames[K]);
      sqlWhere:= Concat(sqlWhere,Format('AND %s = :KOD%d ',[FieldNames[K],K]));
    end;
  end;
  FieldNames.Add('KOD');
  sqlWhere:= Concat(sqlWhere,Format('AND KOD = :KOD%0:d ',[N]));
  sqlWhere:= Copy(sqlWhere,4,Length(sqlWhere));
  Selects.Add(Format('SELECT SNAIM FROM %s WHERE %s',
                   [Manuals[N],sqlWhere]));
end;

begin
  with AQuery do
  begin
    Selects:= TStringList.Create;
    try
      FieldNames:= TStringList.Create;
      try
        GenerateFieldNames(High(Keys));
      finally
        FieldNames.Free;
      end;
      for I:= 0 to High(Keys) do
      begin
        SQL.Text:= Selects[I];
        DeleteVariables;
        for J:= 0 to I do
        begin
          DeclareVariable(Format('KOD%d',[J]),otInteger);
          SetVariable(Format('KOD%d',[J]),Keys[J].Value);
        end;
        Execute;
        if not EOF then
          Results[I].AsString:= FieldAsString(0)
        else Results[I].AsString:= '';
        Close;
      end;
    finally
      Selects.Free;
    end;
  end;
end;//Com_AskListOfThem

procedure AskListOfThem(AQuery: TOracleQuery;const Manuals: Array of string;
          const Keys: Array of TField;const Results: Array of TField);
begin
  Com_AskListOfThem(AQuery,Manuals,'SNAIM',Keys,Results);
end;

function Descander(Desc,Host: TObject):bool;
begin
  Result:= Desc=Host;
  if Desc is TComponent then
    Result:= Result or ((Desc as TComponent).Owner=Host);
end;

function IsLyingOn(Area: TWinControl;Control: TControl):bool;
begin
  if not Assigned(Control) or not Assigned(Area) then Result:= false
  else if Area= Control.Parent then Result:= true
    else Result:= IsLyingOn(Area,Control.Parent);
end;

procedure StringToStringsWithSemicolon(Value : String; AStrs : TStrings);
var
  substr : String;
  str    : String;
  p      : INteger;
begin
  AStrs.Clear;

  str := Trim(Value);

  p := pos(';', str);
  while p > 0 do
  begin
    substr := Trim(copy(str, 1, p - 1));
    str    := Trim(copy(str, p + 1, Length(str) - p));
    AStrs.Add(substr);
    p := pos(';', str);
  end;

  if Length(str) > 0 then
    AStrs.Add(str);
end;

function VarSize(const V: Variant): Integer;
begin
  case VarType(V) of
    varEmpty    : Result := 0;
    varNull     : Result := 0;
    varSmallint : Result := SizeOf(Smallint);
    varInteger  : Result := SizeOf(Integer);
    varSingle   : Result := SizeOf(Single);
    varDouble   : Result := SizeOf(Double);
    varCurrency : Result := SizeOf(Currency);
    varDate     : Result := SizeOf(TDateTime);
    varOleStr   : Result := Length(V) * SizeOf(WideChar);
    varDispatch : Result := SizeOf(IDispatch);
    varError    : Result := 0;
    varBoolean  : Result := SizeOf(WordBool);
    varVariant  : Result := SizeOf(Variant);
    varUnknown  : Result := SizeOf(IUnknown);
    varByte     : Result := SizeOf(Byte);
    varString   : Result := Length(V);
    else
      Result := 0;
  end;
end;

function GetMemVar(const V: Variant): Pointer;
var
  Size : Integer;
  p : PChar;
  PVal : PChar;
  I : Integer;
  VType : Integer;
begin
  Size := VarSize(V);
  if Size > 0 then
  begin
    VType := VarType(V);

    // Определяем значение строка или нет
    if (VType = varString) or (VType = varOleStr) then
    begin
      // значение строка

      GetMem(Result, Size + 2*SizeOf(Integer));
      PInteger(Result)^ := VType;
      p := PChar(Result) + SizeOf(Integer);
      PInteger(p)^ := Size;
      p := p + SizeOf(Integer);

      // Запоминаем указатель на значения
      if VType = varString then
        PVal := PChar(String(V))
      else
        PVal := PChar(WideString(V));

      // Записываем строку в динамическую память
      for I := 0 to size - 1 do
      begin
        p^ :=  (PVal + I)^;
        inc(p);
      end;
    end
    else
    begin
      GetMem(Result, Size + SizeOf(Integer));
      PInteger(Result)^ := VType;
      p := PChar(Result) + SizeOf(Integer);

      PVal := @V;

      // Записываем значение в динамическую память
      for I := 0 to size - 1 do
      begin
        p^ :=  (PVal + I + (SizeOf(Variant) div 2))^;
        inc(p);
      end;
    end;
  end
  else
    Result := nil;
end;

function MemVarToVar(const P : Pointer) : Variant;
var
  VType : Integer;
  PVal : PChar;
  PResult : PChar;
  Size : Integer;
  I : Integer;
  str : String;
  wstr : WideString;
begin
  if Assigned(p) then
  begin
    VType := PInteger(p)^;
    PVal := PChar(p) + SizeOf(Integer);

    if (VType = varString) or (VType = varOleStr) then
    begin
      // строка

      // Читаем размер строки
      Size := PInteger(PVal)^;
      inc(PVal, 4);

      // Устанавливаем размер строки
      SetLength(Str, 0);
      SetLength(wstr, 0);
      if VType = varString then
      begin
        SetLength(Str, Size);
        PResult := PChar(Str);
      end
      else
      begin
        SetLength(wstr, Size div SizeOf(WideChar));
        PResult := PChar(wstr);
      end;

      // Читаем строку из динамической памяти
      for I := 0 to size - 1 do
      begin
        PResult^ := PVal^;

        inc(PResult);
        inc(PVal);
      end;

      if VType = varString then
        Result := Str
      else
        Result := wstr;
    end
    else
    begin

      // Определяем размер значения хранящегося в динамической памяти
      case VType of
        varSmallint : Size := SizeOf(Smallint);
        varInteger  : Size := SizeOf(Integer);
        varSingle   : Size := SizeOf(Single);
        varDouble   : Size := SizeOf(Double);
        varCurrency : Size := SizeOf(Currency);
        varDate     : Size := SizeOf(TDateTime);
        varDispatch : Size := SizeOf(IDispatch);
        varBoolean  : Size := SizeOf(WordBool);
        varVariant  : Size := SizeOf(Variant);
        varUnknown  : Size := SizeOf(IUnknown);
        varByte     : Size := SizeOf(Byte);
        else
                      Size := 0;
      end;

      // Читаем значение из динамической памяти
      if Size > 0 then
      begin
        Result := 0;
        Result  := VarAsType(Result, VType);
        PResult := PChar(@Result);

        inc(PResult, (SizeOf(Variant) div 2));

        for I := 0 to size - 1 do
        begin
          PResult^ :=  PVal^;
          inc(PResult);
          inc(PVal);
        end;
      end
      else
        Result := NULL;
    end;
  end
  else
    Result := NULL;
end;

function TypeSize(const AType: Integer): Integer;
begin
  case AType of
    varEmpty    : Result := SizeOf(Variant);
    varNull     : Result := SizeOf(Variant);
    varSmallint : Result := SizeOf(Smallint);
    varInteger  : Result := SizeOf(Integer);
    varSingle   : Result := SizeOf(Single);
    varDouble   : Result := SizeOf(Double);
    varCurrency : Result := SizeOf(Currency);
    varDate     : Result := SizeOf(TDateTime);
    varOleStr   : Result := SizeOf(WideString);
    varDispatch : Result := SizeOf(IDispatch);
    varError    : Result := SizeOf(Variant);
    varBoolean  : Result := SizeOf(WordBool);
    varVariant  : Result := SizeOf(Variant);
    varUnknown  : Result := SizeOf(IUnknown);
    varByte     : Result := SizeOf(Byte);
    varString   : Result := SizeOf(String);
    else
      Result := SizeOf(Variant);
  end;
end;

function VarTypeField(const Field : TField): Integer;
begin
  if Field is TIntegerField then
    Result := varInteger
  else if Field is TStringField then
    Result := varString
  else if Field is TDateTimeField then
    Result := varDate
  else if Field is TFloatField then
    Result := varDouble
  else if Field is TBCDField then
    Result := varCurrency
  else if Field is TBlobField then
    Result := varString
  else if Field is TBooleanField then
    Result := varBoolean
  else if Field is TIDispatchField then
    Result := varDispatch
  else if Field is TVariantField then
    Result := varDispatch
  else
    Result := varError;
end;

procedure TVPopMenuCD.PopItemClick;
var
  I,Max: TStatePUMenu;
  GoHome: boolean;
begin
  Max:= High(TStatePUMenu);
  I:= Low(TStatePUMenu);
  GoHome:= false;
  repeat
    if I=Your then
    begin
      Items[Ord(I)].Checked:= not Items[Ord(I)].Checked;
      if Items[Ord(I)].Checked then
         FState:= TStatePUMenu(I)
      else FState:= piNone;
    end
    else Items[Ord(I)].Checked:= false;
    I:= Succ(I);
  until GoHome or (I=Max) ;
  if assigned(FAfterPop) then FAfterPop(Self);
end;

procedure TVPopMenuCD.ItClick;
begin
  PopItemClick(TStatePUMenu(Items.IndexOf(Sender as TMenuItem)));
end;

procedure TVPopMenuCD.InMenu;
var
  NewItem: TMenuItem;
begin
  NewItem:= TMenuItem.Create(Self);
  NewItem.Caption:= ItemName;
  NewItem.OnClick:= ItClick;
  Items.Add(NewItem);
end;

procedure TVParentPopMenuCD.InCopy;
var
  NewItem: TMenuItem;
begin
  FCopy:= TMenuItem.Create(Self);
  FCopy.Caption:= 'копировать';
  FCopy.OnClick:= ItCopy;
  Items.Add(FCopy);
end;

procedure TVParentPopMenuCD.InPaste;
begin
  FPaste:= TMenuItem.Create(Self);
  FPaste.Caption:= 'вставить';
  FPaste.OnClick:= ItPaste;
  Items.Add(FPaste);
end;

procedure TVParentPopMenuCD.ItCopy(Sender:TObject);
var
  prop : TCustomEdit;
  propInfo : PPropInfo;
  LText : String;
begin
  propInfo := GetPropInfo(Owner, 'PopupEdit');
  prop := TCustomEdit(GetOrdProp(Owner, PropInfo));
  if prop.SelText <> '' then
    LText := prop.SelText
  else
    LText := prop.Text;
  writeTextInClipboard(LText);
end;

procedure TVParentPopMenuCD.ItPaste(Sender:TObject);
var
  prop : TCustomEdit;
  propInfo : PPropInfo;
begin
  propInfo := GetPropInfo(Owner, 'PopupEdit');
  prop := TCustomEdit(GetOrdProp(Owner, PropInfo));
  InsertClipBoardInEditor(prop);
end;

procedure TVParentPopMenuCD.InsertClipBoardInEditor(AEditor : TCustomEdit);
var
  str : String;
  pos : Integer;
begin
  str := readTextInClipboard;
  if str <> '' then
  begin
    pos := AEditor.SelStart;
    AEditor.Text := copy(AEditor.Text, 1, AEditor.SelStart) +
                    str +
                    copy(AEditor.Text, AEditor.SelStart + 1 + AEditor.SelLength, Length(AEditor.Text) - AEditor.SelStart - AEditor.SelLength);
    AEditor.SelStart := pos + Length(str);
    AEditor.Perform(EM_SCROLLCARET, 0, 0);
  end;
end;

procedure TVParentPopMenuCD.CreateSeparation;
var
  NewItem: TMenuItem;
begin
  NewItem:= TMenuItem.Create(Self);
  NewItem.Caption:= '-';
  Items.Add(NewItem);
end;

procedure TVParentPopMenuCD.FillMenu;
begin
  InCopy;
  InPaste;
end;

procedure TVPopMenuCD.FillMenu;
begin
  InMenu('равно');
  InMenu('не равно');
  InMenu('больше');
  InMenu('меньше');
  InMenu('меньше либо равно');
  InMenu('больше либо равно');
  InMenu('подобно');
  InMenu('не подобно');
  InMenu('среди');
  CreateSeparation;
  inherited;
end;

procedure TVPopMenuCD.defineEnableCopy;
begin
  if TCustomEdit(Owner).Text <> '' then
    FCopy.Enabled := true
  else
    FCopy.Enabled := false;
end;

procedure TVPopMenuCD.defineEnablePaste;
var
  typeProperty : TTypeKind;
  prop : TWStyle;
  propInfo : PPropInfo;
  DataSource : TDataSource;
  DataSet : TDataSet;
begin
  DataSource := TVQryEdit(Owner).DataSource;
  if Assigned(DataSource) then
  begin
    DataSet := DataSource.DataSet;
    if Assigned(DataSet) and (DataSet is TVASUPQuery) then
    begin
      if TVASUPQuery(DataSet).WorkState in [wsQuery, wsEdit, wsAdd] then
      begin
        if IsClipboardFormatAvailable(CF_LOCALE) then
          FPaste.Enabled := true
        else
          FPaste.Enabled := false;
      end
      else
        FPaste.Enabled := false;
    end
    else
      FPaste.Enabled := false;
  end
  else
    FPaste.Enabled := false;
end;

procedure TVPopMenuCD.ItCopy(Sender:TObject);
var
  LText : String;
begin
  with Owner as TCustomEdit do
    if SelText <> '' then
      LText := SelText
    else
      LText := Text;
  writeTextInClipboard(LText);
end;

procedure TVPopMenuCD.ItPaste(Sender:TObject);
begin
  InsertClipBoardInEditor(TCustomEdit(Owner));
end;

procedure TVPopMenuCD.SetState;
var
  I: TStatePUMenu;
begin
  for I:= Low(TStatePUMenu) to Pred(High(TStatePUMenu)) do
    if I= Value then Items[Ord(I)].Checked:= true
    else Items[Ord(I)].Checked:= false;
  FState:= Value;
end;

procedure TVParentPopMenuCD.DoPopup(Sender: TObject);
begin
  defineEnableCopy;
  defineEnablePaste;
end;

procedure TVParentPopMenuCD.defineEnableCopy;
var
  prop : TObject;
  propInfo : PPropInfo;
begin
  if PropIsType(Owner.ClassType, 'PopupEdit', tkClass) then
  begin
    propInfo := GetPropInfo(Owner, 'PopupEdit');
    prop := TObject(GetOrdProp(Owner, PropInfo));
    if Assigned(prop) and (prop is TCustomEdit) then
    begin
      if TCustomEdit(prop).Text <> '' then
        FCopy.Enabled := true
      else
        FCopy.Enabled := false;
    end
    else
      FCopy.Enabled := false;
  end
  else
    FCopy.Enabled := false;

end;

procedure TVParentPopMenuCD.defineEnablePaste;
var
  typeProperty : TTypeKind;
  prop : TWStyle;
  propInfo : PPropInfo;
begin
  if PropIsType(Owner.ClassType, 'WorkStyle', tkEnumeration) then
  begin
    propInfo := GetPropInfo(Owner, 'WorkStyle');
    prop := TWStyle(GetOrdProp(Owner, PropInfo));
    if prop in [wsQuery, wsEdit, wsAdd] then
    begin
      if IsClipboardFormatAvailable(CF_LOCALE) then
        FPaste.Enabled := true
      else
        FPaste.Enabled := false;
    end
    else
      FPaste.Enabled := false;
  end
  else
    FPaste.Enabled := false;
end;

function StatePUMenuToStr(const State: TStatePUMenu):string;
begin
  case State of
    piEqual: Result:= '=';
    piNotEqual: Result:= '!=';
    piMore: Result:= '>';
    piNotMore: Result:= '<=';
    piLess: Result:= '<';
    piNotLess: Result:= '>=';
    piLike: Result:= ' LIKE ';
    piNotLike:Result:= ' NOT LIKE ';
    else Result:= '';
  end;
end;

constructor TVParentPopMenuCD.Create;
begin
  inherited;
  FillMenu;
end;

constructor TVPopMenuCD.Create;
begin
  inherited;
  State:= piNone;
  AutoPopup:= false;
end;

{ * TVDataContainer *}
const
  OR_sql= ' OR ';
  OR_hint= ' или ';
  IN_sql= ' IN (';
  IN_hint=' среди (';
  IN_hint2= ' набор (';
  AND_sql=' AND ';
  AND_hint=' и ';
  BETWEEN_sql=' between ';
  BETWEEN_hint=' между ';
  NOTMORE_sql= ' <= ';
  NOTMORE_hint= 'не более ';
  NOTLESS_sql= ' >=';
  NOTLESS_hint=' не менее ';
  SQLDecimalSeparator= '.';

function TVDataContainer.Equal(AContainer: TVDataContainer):boolean;
begin
  Result:= FState=AContainer.State;
  if Result then
  case FState of
    csPoint: Result:= FPoint=AContainer.Point;
    csInterval: Result:= (FStart=AContainer.StartInt)
                         and (FFinish=AContainer.FinishInt);
  end;
end;

function TVDataContainer.GetDisplayText( const EnumLnStyle: TEnumLineStyle;
                                        Field: TField):string;

function varConverter(const Value:Variant):string;
begin
  if VarType(Value)= varDate then
  begin
     Result:= ''''+FormatDateTime(LongDateFmtLine,Value)+'''';
     if EnumLnStyle= elSQL then
        Result:= Format('TO_DATE(%s,%s)',[Result,''''+LongDateFmtLine+'''']);
  end
  else if (VarType(Value)=varString) then
          Result:= ''''+VarAsType(Value,varString)+''''
  else if (VarType(Value)= varSingle) or
          (VarType(Value)= varDouble) then
         Result:= ReplaceStr( VarAsType(Value,varString),DecimalSeparator,
                              SQLDecimalSeparator)
       else if Field is TIntegerField then
               Result:= FormatFloat(TIntegerField(Field).EditFormat,Value)
       else Result:= VarAsType(Value,varString)
end;

begin
  case EnumLnStyle of
    elSQL:case FState of
      csPoint: Result:= varConverter(FPoint);
      csInterval:
        if VarType(FFinish)=varNull then
           Result:= Concat( NOTLESS_sql,varConverter(FStart))
        else if VarType(FStart)=varNull then
           Result:= Concat( NOTMORE_sql,varConverter(FFinish))
        else Result:= Concat( BETWEEN_sql,varConverter(FStart),
                              AND_sql,varConverter(FFinish));
    end;
    elHint:case FState of
      csPoint: Result:= varConverter(FPoint);
      csInterval:
        if VarType(FFinish)=varNull then
           Result:= Concat( NOTLESS_hint,varConverter(FStart))
        else if VarType(FStart)=varNull then
           Result:= Concat( NOTMORE_hint,varConverter(FFinish))
        else Result:= Concat( BETWEEN_hint,varConverter(FStart),
                              AND_hint,varConverter(FFinish));
    end;
  end;
end;

procedure TVDataContainer.SetPoint(const Value:Variant);
begin
  FPoint:= Value;
  FState:= csPoint;
end;

procedure TVDataContainer.SetInterval(const Start,Finish:Variant);
begin
  FStart:= Start;
  FFinish:= Finish;
  FState:= csInterval;
end;

procedure TVDataContainer.Assign(Source: TPersistent);
begin
  if Source is TVDataContainer then
  begin
    FPoint:= TVDataContainer(Source).Point;
    FStart:= TVDataContainer(Source).StartInt;
    FFinish:= TVDataContainer(Source).FinishInt;
    FState:= TVDataContainer(Source).State;
  end;
end;

{ * TEnumList * }

function TVEnumValueList.Equal(AEnumValList: TVEnumValueList):boolean;
var
  I: Integer;
begin
  Result:= (Count=AEnumValList.Count)
           and (FUnion= AEnumValList.Union);
  I:= 0;
  while Result and (I<Count) do
  begin
    Result:= TVDataContainer(Objects[I]).Equal(
               TVDataContainer(AEnumValList.Objects[I])
               );
    Inc(I);
  end;
end;

procedure TVEnumValueList.LoadFromStream(Stream: TStream);
var
  Size: Integer;
  S: string;
begin
  BeginUpdate;
  try
    Size := Stream.Size - Stream.Position;
    SetString(S, nil, Size);
    Stream.Read(Pointer(S)^, Size);
    CrackString(S);
  finally
    EndUpdate;
  end;
end;

procedure TVEnumValueList.CrackString(Line: String);
var
  P, Start: PChar;
  S: string;
  Container: TVDataContainer;
  conState: TContainerState;

procedure FillVariants;
var
  VarData: TVarData;
  Var1,Var2: Variant;
begin
  with Container do
    case conState of
      csPoint:
      begin
        System.Move(P^,VarData,SizeOf(VarData));
        TVarData(Var1):= VarData;
        SetPoint(Var1);
        Inc(P,2*SizeOf(VarData));
      end;
      csInterval:
      begin
        System.Move(P^,VarData,SizeOf(VarData));
        TVarData(Var1):= VarData;
        Inc(P,SizeOf(VarData));
        System.Move(P^,VarData,SizeOf(VarData));
        TVarData(Var2):= VarData;
        Inc(P,SizeOf(VarData));
        SetInterval(Var1,Var2);
      end;
    end;
end;

begin
  BeginUpdate;
  try
    Clear;
    P := Pointer(Line);
    if P <> nil then
    begin
      System.Move(P^,FUnion,SizeOf(TSQLUnion));
      Inc(P,SizeOf(TSQLUnion));
      while P-Pointer(Line)<Length(Line) do
      begin
        Start := P;
        while P^ <>#0 do Inc(P);
        SetString(S, Start, P - Start);
        Inc(P);
        Container:= TVDataContainer.Create;
        with Container do
        begin
          System.Move(P^,conState,SizeOf(conState));
          Inc(P,SizeOf(conState));
          FillVariants;
        end;
        AddObject(S,Container);
      end;
    end;
  finally
    EndUpdate;
  end;
end;

function TVEnumValueList.MakeString: String;
var
  I, L, Size, Count: Integer;
  P: PChar;
  S: string;
  VarData: TVarData;
begin
  Count := GetCount;
  Size := 1;
  for I := 0 to Count - 1 do
    Inc(Size, Length(Get(I)) + 1 + SizeOf(TContainerState) + 2*SizeOf(TVarData));
  SetString(Result, nil, Size);
  P := Pointer(Result);
  System.Move(FUnion,P^,SizeOf(TSQLUnion));
  Inc(P,SizeOf(TSQLUnion));
  for I := 0 to Count - 1 do
  begin
    S := Get(I);
    L := Length(S);
    if L <> 0 then
    begin
      System.Move(Pointer(S)^, P^, L);
      Inc(P, L);
    end;
    P^ := #00;
    Inc(P);
    System.Move(TVDataContainer(Objects[I]).State,P^,SizeOf(TContainerState));
    Inc(P,SizeOf(TContainerState));
    if TVDataContainer(Objects[I]).State= csPoint then
    begin
      VarData:= TVarData(TVDataContainer(Objects[I]).Point);
      System.Move(VarData,P^,SizeOf(VarData));
      Inc(P,2*SizeOf(VarData));
    end
    else
    begin
      VarData:= TVarData(TVDataContainer(Objects[I]).StartInt);
      System.Move(VarData,P^,SizeOf(VarData));
      Inc(P,SizeOf(VarData));
      VarData:= TVarData(TVDataContainer(Objects[I]).FinishInt);
      System.Move(VarData,P^,SizeOf(VarData));
      Inc(P,SizeOf(VarData));
    end
  end;
end;

procedure TVEnumValueList.SaveToStream(Stream: TStream);
var
  S: string;
begin
  S := MakeString;
  Stream.WriteBuffer(Pointer(S)^, Length(S));
end;

constructor TVEnumValueList.Create(OwnerEdit: TVQryEdit);
begin
  inherited Create;
  FOwner:= OwnerEdit;
end;

procedure TVEnumValueList.Replicate(Source: TVEnumValueList);
var
  I: Integer;
  Container: TVDataContainer;
begin
  Clear;
  FOwner.Hint:= '';
  FUnion:= Source.Union;
  for I:= 0 to Source.Count-1 do
    if Assigned(Source.Objects[I]) then
    begin
      Container:= TVDataContainer.Create;
      Container.Assign(TVDataContainer(Source.Objects[I]));
      AddObject(Source[I],Container);
    end
    else Add(Source[I]);
end;

procedure TVEnumValueList.Delete(Index:Integer);
begin
  Objects[Index].Free;
  inherited;
end;

procedure TVEnumValueList.Clear;
var
  I: Integer;
begin
  for I:= 0 to Count-1 do Objects[I].Free;
  inherited;
end;

procedure TVEnumValueList.AddPoint(const pntText:string;const pntValue:Variant);
var
  Container: TVDataContainer;
begin
  Container:= TVDataContainer.Create;
  Container.SetPoint(pntValue);
  AddObject(pntText,Container);
end;

procedure TVEnumValueList.AddInterval( const intText:string;
                                      const intStartVal,intFinishVal:Variant);
var
  Container: TVDataContainer;
begin
  Container:= TVDataContainer.Create;
  Container.SetInterval(intStartVal,intFinishVal);
  AddObject(intText,Container);
  if Length(intText)=0 then
     Strings[Count-1]:= GetDisplayText(Count-1,elHint,FOwner.Field)
end;

function TVEnumValueList.GetDisplayText( Index: Integer;
                                        const Style:TEnumLineStyle;
                                        Field: TField): string;
begin
  Result:= TVDataContainer(Objects[Index]).GetDisplayText(Style,Field);
end;

{ * TVQryEdit }

procedure TVQryEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString, ftWideString]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

constructor TVQryEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
  //
  ShowHint:= true;
  if not(csDesigning in ComponentState) then
  begin
    FPopa:= TVPopMenuCD.Create(Self);
    with FPopa do
    begin
      Items[Ord(piLike)].Visible:= false;
      Items[Ord(piNotLike)].Visible:= false;
    end;
    PopupMenu:= FPopa;
    FPopa.AfterPop:= SafeExit;
    DefaultState:= piEqual;
    FState:= piNone;
    FQValList:= TVEnumValueList.Create(Self);
    FEditFmt:= '';
    FDisplayFmt:= '';
    FPlacemntStored:= false;
    FForceReadOnly:= false;
  end;
end;

destructor TVQryEdit.Destroy;
begin
  QueryState:= piNone;
  FLabel.Free;
  FLabel := nil;
  FQValList.Free;
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TVQryEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
  if not Assigned(FLabel) then
  begin
    FLabel:= TLabel.Create(Self);
    FLabel.Font.Name:='Symbol';
    FLabel.Font.Charset:= SYMBOL_CHARSET;
    FLabel.Font.Size:= Font.Size+2;
    FLabel.Font.Height:= Font.Height-2; // так как Font.Height меньше нуля
    FLabel.Width:= FLabel.Font.Size;
    FLabel.Height:= abs(FLabel.Font.Height);
    SetLabelCoord;
    FLabel.PopupMenu:=PopupMenu;
    FLabel.Caption:= syNone;
    FLabel.Parent:= Parent;
    //SetLabelVisible;
  end;
end;

procedure TVQryEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TVQryEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TVQryEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

procedure TVQryEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

function TVQryEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TVQryEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TVQryEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TVQryEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TVQryEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TVQryEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TVQryEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TVQryEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

function TVQryEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TVQryEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TVQryEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TVQryEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
end;

procedure TVQryEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAlignment <> FDataLink.Field.Alignment then
    begin
      EditText := '';  {forces update}
      FAlignment := FDataLink.Field.Alignment;
    end;
    EditMask := FDataLink.Field.EditMask;
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if FFocused and FDataLink.CanModify then
      Text := FDataLink.Field.Text
    else
    begin
      EditText := FDataLink.Field.DisplayText;
      //Text := FDataLink.Field.Text
      {if FDataLink.Editing and FDataLink.FModified then
        Modified := True;}
    end;
  end else
  begin
    FAlignment := taLeftJustify;
    EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name else
      EditText := '';
  end;
  Hint:= '';
end;

procedure TVQryEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TVQryEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  FDataLink.Field.Text := Text;
end;

procedure TVQryEdit.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TVQryEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TVQryEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TVQryEdit.CMEnter(var Message: TCMEnter);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  SetFocused(True);
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    inherited ReadOnly := False;
end;

procedure TVQryEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
  if FPermit then SafeExit(Self);
end;

procedure TVQryEdit.WMPaint(var Message: TWMPaint);
const
  AlignStyle : array[Boolean, TAlignment] of DWORD =
   ((WS_EX_LEFT, WS_EX_RIGHT, WS_EX_LEFT),
    (WS_EX_RIGHT, WS_EX_LEFT, WS_EX_LEFT));
var
  Left: Integer;
  Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  AAlignment: TAlignment;
  ExStyle: DWORD;
begin
  AAlignment := FAlignment;
  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
  if (((AAlignment = taLeftJustify) or FFocused) and
    not (csPaintCopy in ControlState)) or FStandardPaint then
  begin
    if SysLocale.MiddleEast and HandleAllocated and (IsRightToLeft) then
    begin { This keeps the right aligned text, right aligned }
      ExStyle := DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) and (not WS_EX_RIGHT) and
        (not WS_EX_RTLREADING) and (not WS_EX_LEFTSCROLLBAR);
      if UseRightToLeftReading then ExStyle := ExStyle or WS_EX_RTLREADING;
      if UseRightToLeftScrollbar then ExStyle := ExStyle or WS_EX_LEFTSCROLLBAR;
      ExStyle := ExStyle or
        AlignStyle[UseRightToLeftAlignment, AAlignment];
      if DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) <> ExStyle then
        SetWindowLong(Handle, GWL_EXSTYLE, ExStyle);
    end;
    inherited;
    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      Brush.Color := Color;
      if not Enabled then
        Font.Color := clGrayText;
      if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
      begin
        S := FDataLink.Field.DisplayText;
        case CharCase of
          ecUpperCase: S := AnsiUpperCase(S);
          ecLowerCase: S := AnsiLowerCase(S);
        end;
      end else
      S := EditText;
      if PasswordChar <> #0 then FillChar(S[1], Length(S), PasswordChar);
      Margins := GetTextMargins;
      case AAlignment of
        taLeftJustify: Left := Margins.X;
        taRightJustify: Left := ClientWidth - TextWidth(S) - Margins.X - 1;
      else
        Left := (ClientWidth - TextWidth(S)) div 2;
      end;
      if SysLocale.MiddleEast then UpdateTextFlags;
      TextRect(R, Left, Margins.Y, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

procedure TVQryEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TVQryEdit.GetTextMargins: TPoint;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  if NewStyleControls then
  begin
    if BorderStyle = bsNone then I := 0 else
      if Ctl3D then I := 1 else I := 2;
    Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
    Result.Y := I;
  end else
  begin
    if BorderStyle = bsNone then I := 0 else
    begin
      DC := GetDC(0);
      GetTextMetrics(DC, SysMetrics);
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextMetrics(DC, Metrics);
      SelectObject(DC, SaveFont);
      ReleaseDC(0, DC);
      I := SysMetrics.tmHeight;
      if I > Metrics.tmHeight then I := Metrics.tmHeight;
      I := I div 4;
    end;
    Result.X := I;
    Result.Y := I;
  end;
end;

function TVQryEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TVQryEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;


procedure TVQryEdit.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if Message.NotifyCode = EN_UPDATE then
  begin
    FSrvCtrl:= scKeyBoard;
    if (Length(EditText)>0)
       and (QueryState=piInto) and Modified then
    begin
      Hint:= '';
      QueryState:= piNone;
    end;
  end;
end;

procedure TVQryEdit.WMMOUSEMOVE(var Message: TWMMouse);
begin
  if QueryState= piInto then Hint:= Concat(HintValuesLine,'|');
  inherited;
end;

procedure TVQryEdit.CreateEnumList;
begin
  if Assigned(FEnumDes) then
    if not FenumDes.Visible then FEnumDes.Show
    else (FEnumDes as TEnumDesigner).RefreshList
  else
  begin
    FEnumDes:= TEnumDesigner.Create(Self);
    with FEnumDes as TEnumDesigner do
    begin
      if FPlacemntStored then
         SetWindowPlacement(Handle,@FEnumDesPlacemnt);
      QueryValList:= FQValList;
      QueryField:= DataSource.DataSet.FieldByName(DataField);
      Tag:= MaxLength;
      Show;
    end;
  end
end;

procedure TVQryEdit.WMLBUTTONDBLCLK(var Message: TWMMouse);
begin
  inherited;
  if (FState= piInto) and not (Message.Keys and MK_CONTROL=MK_CONTROL) then
    if Assigned(FEnumDes) then FEnumDes.Show
    else CreateEnumList;
end;

procedure TVQryEdit.SetState(const Value: TStatePUMenu);
begin
  if (Value in [piLike,piNotLike]) and
     not (FState in [piLike,piNotLike])
     and (Field is TIntegerField) then
  with Field as TIntegerField do
  begin
    FEditFmt:= EditFormat;
    FDisplayFmt:= DisplayFormat;
    EditFormat:= '';
    DisplayFormat:= '';
  end
  else if (FState in [piLike,piNotLike])
          and not (Value in [piLike,piNotLike])
          and (Field is TIntegerField) then
  with Field as TIntegerField do
  begin
    EditFormat:= FEditFmt;
    DisplayFormat:= FDisplayFmt;
  end;
  if (FState= piInto) and Assigned(FEnumDes) and (Value<>piInto) then
  begin
    FPlacemntStored:= true;
    GetWindowPlacement(FEnumDes.Handle, @FEnumDesPlacemnt);
    FEnumDes.Free;
    FEnumDes:= nil;
  end;
  if Assigned(FPopa) then
  begin
    if (FState= piInto) and (Value<>piInto) then
    begin
      FQValList.Clear;
      Hint:= '';
      if FForceReadOnly then
      begin
        Self.ReadOnly:= false;
        if Self.HandleAllocated then Self.Reset;
        FForceReadOnly:= false;
      end;
    end;
    if Value= piInto then
    begin
      if (FState= piEqual) and not Field.IsNull then
         FQValList.AddPoint(Field.DisplayText,Field.Value);
      Field.Value:= Null;
      CreateEnumList;
      if not Self.ReadOnly then
      begin
        Self.ReadOnly:= true;
        FForceReadOnly:= true;
      end;
    end;
    FState:= Value;
    FPopa.State:= Value;
  end;
  RepaintLabel;
  //SetLabelVisible;
  if Assigned(FOnQueryStateChange) then
    FOnQueryStateChange(Self);
end;

procedure TVQryEdit.SetDefaultState;
begin
  FDefaultState:= ADefault;
  FPopa.State:= FDefaultState;
  //SetLabelVisible;
end;

procedure TVQryEdit.RepaintLabel;
begin
  if FPermit and Assigned(FLabel) then
    with FLabel do
    begin
      case FPopa.State of
        piEqual: Caption:= syEqual;
        piNotEqual:Caption:= syNotEqual;
        piMore:Caption:= syMore;
        piLess:Caption:= syLess;
        piNotMore:Caption:= syNotMore;
        piNotLess:Caption:= syNotLess;
        piLike:Caption:= syLike;
        piNotLike:Caption:= syNotLike;
        piInto:Caption:= syInto;
        piNone:Caption:= syNone;
      end;
      if Visible then Repaint;
    end;
end;

procedure TVQryEdit.SafeExit;
begin
  if Sender=FPopa then
  begin
    FSrvCtrl:= scPopUp;
    QueryState:= FPopa.State;
  end;
  if Assigned(Field) and FPermit then
  begin
    if Field is TStringField then
    begin
      if (Length(Trim(Text))>0) and
         (FPopa.State=piNone) then QueryState:= DefaultState
      else if (Length(Trim(Text))=0) and
         (FPopa.State=DefaultState) then QueryState:= piNone;
    end
    else
    begin
      if not Field.IsNull and
        (FPopa.State=piNone) then
      begin
        QueryState:= DefaultState;
      end;
      if Field.IsNull and
        not (FPopa.State in [piEqual,piNotEqual,piInto]-[DefaultState])
        and (FSrvCtrl= scKeyBoard) then QueryState:= piNone;
    end;
  end;
end;

procedure TVQryEdit.SetPermission;
begin
  if FPermit<> Value then
  begin
    FPermit:= Value;
    PopUpMenu.AutoPopUp:= FPermit;
    if Assigned(FLabel) then
      FLabel.Visible:= FPermit;
    QueryState:= piNone;
    //SetLabelVisible;
  end;
end;

function SQLConcat(DataSet: TDataSet; Names1,Names2:string;AMaster:TVASUPQuery):string;
var
  Short1,Short2: string;
  PointPos: Integer;
begin
  Result:= '';
  while Length(Names1)>0 do
  begin
    Cut(';',Names1,Short1);
    Cut(';',Names2,Short2);
    Short1:= OriginFieldName(DataSet.FieldByName(Short1));
    Short2:= OriginFieldName(AMaster.FieldByName(Short2));
    if Pos('.',Short2)=0 then
      Short2:= AMaster.UpdTabAlias+'.'+Short2;
    if Length(Result)>0 then
       Result:= Format( '%s AND %s=%s',
                        [Result,Short1,Short2])
    else Result:= Format( '%s=%s',
                          [Short1,Short2]);
  end;
end;

function SQLConcat2(ADataSet: TVASUPQuery; Names:string):string;
var
  Short: string;
begin
  Result:= '';
  while Length(Names)>0 do
  begin
    Cut(';',Names,Short);
    Short:= OriginFieldName(ADataSet.FieldByName(Short));
    if Pos('.',Short)=0 then
      Short:= ADataSet.UpdTabAlias+'.'+Short;
    if Length(Result)>0 then
       Result:= Result+','+Short
    else Result:= Short;
  end;
end;

function TVQryEdit.GetEnumLine(const Style:TEnumLineStyle):string;
var
  InterLine,PointLine: string;
  I: Integer;
  Union_clause: string;

function ComplexFieldName:string;
begin
  Result:= OriginFieldName(Field);
end;

function GenerateMultiSQL: String;
var
  J,K: Integer;
  Template: string;
  DetailSet: TVASUPQuery;
  Val1,Val2,Val0: Integer;
  Cont: TVDataContainer;
begin
  Result:= '';
  DetailSet:= DataSource.DataSet as TVASUPQuery;
  if DetailSet.EmbeddedSQLSlice.Count=0 then
    case DetailSet.LinkKind of
      lkExists:
        Template:= Format( 'EXISTS (SELECT 1 FROM %S WHERE %s AND %S=%S AND %S) ',
                           [ DetailSet.UpdatingTable,
                             SQLConcat( DetailSet,DetailSet.DetailFields,
                                        DetailSet.MasterFields,
                                        TVASUPQuery(DetailSet.Master)),
                             ComplexFieldName,'%D','%S']);
      lkIn:
        Template:= Format( '(%s) IN (SELECT %s FROM %S %S WHERE %s AND %S=%S AND %S) ',
                           [ SQLConcat2( TVASUPQuery(DetailSet.Master),
                                        DetailSet.MasterFields
                                        ),
                             SQLConcat2( DetailSet,
                                        DetailSet.DetailFields
                                        ),
                             DetailSet.UpdatingTable,
                             DetailSet.UpdTabAlias,
                             ComplexFieldName,'%D','%S'])
    end
    else
      case DetailSet.LinkKind of
        lkExists:
          Template:= Format( 'EXISTS (SELECT 1 %S AND %s AND %S=%S AND %S) ',
                           [ DetailSet.EmbeddedSQLSlice.Text,
                             SQLConcat( DetailSet,DetailSet.DetailFields,
                                        DetailSet.MasterFields,
                                        TVASUPQuery(DetailSet.Master)),
                             ComplexFieldName,'%D','%S']);
        lkIn:
          Template:= Format( '(%s) IN (SELECT %s %S AND %S=%S AND %S) ',
                           [ SQLConcat2( TVASUPQuery(DetailSet.Master),
                                        DetailSet.MasterFields
                                        ),
                             SQLConcat2( DetailSet,
                                        DetailSet.DetailFields
                                        ),
                             DetailSet.EmbeddedSQLSlice.Text,
                             ComplexFieldName,'%D','%S'])
      end;
  for J:= 0 to FQValList.Count-1 do
  begin
    Cont:= TVDataContainer(FQValList.Objects[J]);
    if Cont.State= csPoint then
    begin
      Val1:= Cont.Point;
      if Length(Result)=0 then Result:= Format(Template,[Val1,'%S'])
      else Result:= Format(Result,[Format(Template,[Val1,'%S'])]);
    end
    else
    begin
      Val1:= Cont.StartInt;
      Val2:= Cont.FinishInt;
      if Val1>Val2 then
      begin
        Val0:= Val1;
        Val1:= Val2;
        Val2:= Val0;
      end;
      for K:= Val1 to Val2 do
        if Length(Result)=0 then Result:= Format(Template,[K,'%S'])
        else Result:= Format(Result,[Format(Template,[K,'%S'])]);
    end;
  end;
  Result:= Format(Result,['0=0']);
end;

begin
  if (QueryState=piInto) and
     (Style= elSQL) and (FQValList.Union= unAND) then
     Result:= GenerateMultiSQL
  else
  begin
    InterLine:= '';
    PointLine:= '';
    case Style of
      elSQL:Union_clause:= OR_sql;
      elHint:
        case FQValList.Union of
          unOR: Union_clause:= OR_hint;
          unAND: Union_clause:= AND_hint;
        end;
    end;
    if QueryState=piInto then
    begin
      for I:= 0 to FQValList.Count-1 do
        if Assigned(FQValList.Objects[I]) and
           (TVDataContainer(FQValList.Objects[I]).State= csInterval) then
        begin
          if Length(InterLine)>0 then
             InterLine:= Concat(InterLine,Union_clause);
          case Style of
            elSQL:InterLine:= Concat( InterLine,
                                      Format('(%s %s)',[ComplexFieldName,FQValList.GetDisplayText(I,elSQL,Field)]));
            elHint: InterLine:= Concat( InterLine,
                                        Format('(%s)',[FQValList.GetDisplayText(I,elHint,Field)]));
          end;
        end
        else
          case Style of
            elSQL: if Length(PointLine)=0 then
                      PointLine:= Concat( ComplexFieldName,IN_sql,
                                          FQValList.GetDisplayText(I,elSQL,Field))
                   else PointLine:= Concat(PointLine,',',FQValList.GetDisplayText(I,elSQL,Field));
            elHint: if Length(PointLine)=0 then
                    case FQValList.Union of
                      unOR: PointLine:= Concat(IN_hint,FQValList.GetDisplayText(I,elHint,Field));
                      unAND: PointLine:= Concat(IN_hint2,FQValList.GetDisplayText(I,elHint,Field));
                    end
                    else PointLine:= Concat(PointLine,',',FQValList.GetDisplayText(I,elHint,Field));
          end;
      if Length(PointLine)>0 then PointLine:= Concat(PointLine,')');
      Result:= PointLine;
      if Length(Result)=0 then Result:= InterLine
      else if Length(InterLine)>0 then Result:= Concat(Result,Union_clause,InterLine);
    end;
  end;
end;

function TVQryEdit.GetSQLEnumLine:string;
begin
  Result:= GetEnumLine(elSQL);
end;

function TVQryEdit.GetHintEnumLine:string;
begin
  Result:= GetEnumLine(elHint);
end;

{procedure TVQryEdit.SetLabelVisible;
begin
  if (not (csLoading in ComponentState)) and Assigned(FLabel) then
    FLabel.Visible := ((DefaultState <> QueryState) and Permission and (QueryState <> piNone));
end;}

procedure TVQryEdit.SetLabelCoord;
begin
  if  Assigned(FLabel) then
  begin
    FLabel.Top:= Top;
    FLabel.Left:= Left-FLabel.Width-4;
  end;
end;

procedure TVQryEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelCoord;
end;

{*  TVDBEditChar  *}

constructor TVDBEditChar.Create;
begin
  inherited Create(AOwner);
  if not(csDesigning in ComponentState) and Assigned(FPopa) then
  with FPopa do
  begin
    Items[Ord(piLike)].Visible:= true;
    Items[Ord(piNotLike)].Visible:= true;
  end;
end;

{ TDBEditwButton}

 { Utility routines }

function Min(i1,i2 : longint) : longint;
 begin
  if i1 < i1 then Result:=i1
             else Result:=i2;
 end;

{ TVEditButton }

constructor TVEditButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  ParentShowHint := True;
end;

procedure TVEditButton.Paint;
begin
  inherited Paint;
  if (FState <> bsDown) then
    with Canvas do begin
      if NewStyleControls then Pen.Color := clBtnFace
      else Pen.Color := clBtnShadow;
      MoveTo(0, 0);
      LineTo(0, Self.Height - 1);
      Pen.Color := clBtnHighlight;
      MoveTo(1, 1);
      LineTo(1, Self.Height - 2);
    end;
end;

procedure TVEditButton.Click;
begin
  if not FNoAction then inherited Click else FNoAction := False;
end;

{ TVCustomEditwButton }

procedure TVCustomEditwButton.KeyPress(var Key: Char);
begin
  if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) then
  begin
    { must catch and remove this, since is actually multi-line }
    GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
    if Key = Char(VK_RETURN) then
    begin
      inherited KeyPress(Key);
      Key := #0;
      Exit;
    end;
  end;
  inherited KeyPress(Key);
end;

constructor TVCustomEditwButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csCaptureMouse];
  AutoSize := False;
  FClickKey := scAltDown;
  FBtnControl := TWinControl.Create(Self);
  with FBtnControl do
    ControlStyle := ControlStyle + [csReplicatable];
  FBtnControl.Width := DefEditBtnWidth;
  FBtnControl.Height := 17;
  FBtnControl.Visible := True;
  FBtnControl.Parent := Self;
  FButton := TVEditButton.Create(Self);
  FButton.SetBounds(0, 0, FBtnControl.Width, FBtnControl.Height);
  FButton.Visible := True;
  FButton.Parent := FBtnControl;
  TVEditButton(FButton).OnClick := EditButtonClick;
  Height := 21;
  FDefNumGlyphs := 1;
end;

destructor TVCustomEditwButton.Destroy;
begin
  FCanvas.Free;
  FButton.OnClick := nil;
  inherited Destroy;
end;

procedure TVCustomEditwButton.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of Longword = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN
    or Alignments[FAlignment];
end;

procedure TVCustomEditwButton.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

procedure TVCustomEditwButton.DoChange;
begin
  inherited Change;
end;

procedure TVCustomEditwButton.AcceptValue(const Value: Variant);
begin
  if Text <> VarToStr(Value) then
  begin
    Text := Value;
    Modified := True;
    DoChange;
  end;
end;

procedure TVCustomEditwButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (FClickKey = ShortCut(Key, Shift)) and (ButtonWidth > 0) then
  begin
    EditButtonClick(Self);
    Key := 0;
  end;
end;

function TVCustomEditwButton.GetButtonWidth: Integer;
begin
  Result := FButton.Width;
end;

procedure TVCustomEditwButton.SetButtonWidth(Value: Integer);
begin
  if ButtonWidth <> Value then begin
    FBtnControl.Visible := Value > 1;
    if (csCreating in ControlState) then begin
      FBtnControl.Width := Value;
      FButton.Width := Value;
      with FButton do
        ControlStyle := ControlStyle - [csFixedWidth];
    end
    else if (Value <> ButtonWidth) and (Value < ClientWidth) then begin
      FButton.Width := Value;
      with FButton do
        ControlStyle := ControlStyle - [csFixedWidth];
      if HandleAllocated then RecreateWnd;
    end;
  end;
end;

function TVCustomEditwButton.GetButtonHint: string;
begin
  Result := FButton.Hint;
end;

procedure TVCustomEditwButton.SetButtonHint(const Value: string);
begin
  FButton.Hint := Value;
end;

function TVCustomEditwButton.GetGlyph: TBitmap;
begin
  Result := FButton.Glyph;
end;

procedure TVCustomEditwButton.SetGlyph(Value: TBitmap);
begin
  FButton.Glyph := Value;
end;

function TVCustomEditwButton.GetNumGlyphs: TNumGlyphs;
begin
  Result := FButton.NumGlyphs;
end;

procedure TVCustomEditwButton.SetNumGlyphs(Value: TNumGlyphs);
begin
  FButton.NumGlyphs := Value;
end;

procedure TVCustomEditwButton.SetEditRect;
var
  Loc: TRect;
begin
  SetRect(Loc, 0, 0, ClientWidth - FBtnControl.Width - 2, ClientHeight + 1);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
end;

procedure TVCustomEditwButton.UpdateBtnBounds;
var
  BtnRect: TRect;
begin
  if NewStyleControls then begin
    if Ctl3D and (BorderStyle = bsSingle) then
      BtnRect := Bounds(Width - FButton.Width - 4, 0,
        FButton.Width, Height - 4)
    else begin
      if BorderStyle = bsSingle then
        BtnRect := Bounds(Width - FButton.Width - 2, 2,
          FButton.Width, Height - 4)
      else
        BtnRect := Bounds(Width - FButton.Width, 0,
          FButton.Width, Height);
    end;
  end
  else
    BtnRect := Bounds(Width - FButton.Width, 0, FButton.Width, Height);
  with BtnRect do
    FBtnControl.SetBounds(Left, Top, Right - Left, Bottom - Top);
  FButton.Height := FBtnControl.Height;
  SetEditRect;
end;

procedure TVCustomEditwButton.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  UpdateBtnBounds;
end;

procedure TVCustomEditwButton.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  if not (csLoading in ComponentState) then begin
    MinHeight := GetMinHeight;
    { text edit bug: if size to less than MinHeight, then edit ctrl does
      not display the text }
    if Height < MinHeight then begin
      Height := MinHeight;
      Exit;
    end;
  end;
  UpdateBtnBounds;
end;

function TVCustomEditwButton.GetTextHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  Result := Min(SysMetrics.tmHeight, Metrics.tmHeight);
end;

function TVCustomEditwButton.GetMinHeight: Integer;
var
  I: Integer;
begin
  I := GetTextHeight;
  Result := I + GetSystemMetrics(SM_CYBORDER) * 4 + 1 ;
end;

procedure TVCustomEditwButton.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if HandleAllocated then RecreateWnd;
end;

procedure TVCustomEditwButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  FButton.Enabled := Enabled;
end;

procedure TVCustomEditwButton.CNCtlColor(var Message: TMessage);
var
  TextColor: Longint;
begin
  inherited;
  if NewStyleControls then begin
    TextColor := ColorToRGB(Font.Color);
    if not Enabled and (ColorToRGB(Color) <> ColorToRGB(clGrayText)) then
      TextColor := ColorToRGB(clGrayText);
    SetTextColor(Message.WParam, TextColor);
  end;
end;

procedure TVCustomEditwButton.WMPaint(var Message: TWMPaint);
var
  S: string;
begin
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
  begin
    S := FDataLink.Field.DisplayText;
    case CharCase of
      ecUpperCase: S := AnsiUpperCase(S);
      ecLowerCase: S := AnsiLowerCase(S);
    end;
  end
  else S := EditText;
  if not PaintEditwButton(Self, S, Alignment, {False}True, FCanvas, Message) then
  begin
    StandardPaint:= True;
    inherited;
  end;
end;

procedure TVCustomEditwButton.WMKillFocus(var Message: TWMKillFocus);
begin
  FFocused := False;
  inherited;
  SelLength:= 0;
  DestroyCaret;
end;

procedure TVCustomEditwButton.WMSetFocus(var Message: TMessage);
begin
  FFocused := True;
  inherited;
  SetShowCaret;
end;

procedure TVCustomEditwButton.SetShowCaret;
const
  CaretWidth: array[Boolean] of Byte = (1, 2);
begin
  CreateCaret(Handle, 0, CaretWidth[fsBold in Font.Style], GetTextHeight);
  ShowCaret(Handle);
end;

procedure TVCustomEditwButton.EditButtonClick(Sender: TObject);
var
  FFieldDataLink:TFieldDataLink;
begin
  FFieldDataLink:= TFieldDataLink(Perform(CM_GETDATALINK,0,0));
  if FFieldDataLink.Active then FFieldDataLink.Edit;
end;

procedure TVCustomEditwButton.DoClick;
begin
  EditButtonClick(Self);
end;

function TVCustomEditwButton.BtnWidthStored: Boolean;
begin
  Result := ButtonWidth <> DefEditBtnWidth;
end;

function TVCustomEditwButton.GetDefaultBitmap(var DestroyNeeded: Boolean): TBitmap;
begin
  Result := nil;
end;

{* TVWatchEdit *}

constructor TStrFldList.Create;
begin
  inherited;
  FDList:= TList.Create;
end;

destructor TStrFldList.Destroy;
begin
  Clear;
  FDList.Free;
  inherited;
end;

procedure TStrFldList.AddPlus(NewString: string;ADWidth:Integer;NewObject: TObject);
var
  PDsplInfo: PTDisplayInfo;
  I: Integer;
begin
  inherited AddObject(NewString,NewObject);
  New(PDsplInfo);
  with PDsplInfo^ do
  begin
    DWidth:= ADWidth;
    DFormat:= '';
    for I:= 1 to ADWidth do
      DFormat:= Concat(DFormat,'0');
  end;
  FDList.Add(PDsplInfo);
end;

procedure TStrFldList.Clear;
var
  I:Integer;
begin
  for I:= Count-1 downto 0 do
    Dispose(PTDisplayInfo(FDList[I]));
  FDList.Clear;
  inherited Clear;
end;

function TStrFldList.GetDisplays(Index: Integer):TDisplayInfo;
begin
  Result:= PTDisplayInfo(FDList[Index])^;
end;

procedure TStrFldList.SetDisplays(Index: Integer;AValue:TDisplayInfo);
begin
  with PTDisplayInfo(FDList[Index])^ do
  begin
    DWidth:= AValue.DWidth;
    DFormat:= AValue.DFormat;
    DLabel:= AValue.DLabel;
  end;
end;

function GetFirstStr(const HugeString: String):String;
var
  TempList: TStringList;
begin
  TempList:= TStringList.Create;
  with TempList do
  begin
    Text:= HugeString;
    if Count>0 then
      Result:= Trim(TempList[0])
    else Result:= '';
  end;
  TempList.Free;
end;

procedure TVWatchEdit.SetOwnerTable;
begin
  FOwner:= UpperCase(Trim(Value));
end;

function TVWatchEdit.GetTaName;
begin
  if FTabName='' then One2Two;
  Result:= FTabName;
end;

procedure TVWatchEdit.SetTaName;
begin
  FTabName:= UpperCase(Trim(Value));
  FCapEyes:= '';
end;

procedure TVWatchEdit.SetHintName;
begin
  FHintName:= UpperCase(Trim(Value));
end;

function TVWatchEdit.GetCaption: string;
var
  TempQuery: TOracleQuery;
begin
  if Length(FCapEyes)=0 then
  begin
    TempQuery:= TOracleQuery.Create(Self);
    if  DataSource.DataSet is TOracleDataSet then
      TempQuery.Session:= (DataSource.DataSet as TOracleDataSet).Session;
    with TempQuery do
    begin
      SQL.Text:= 'SELECT COMMENTS FROM SYS.ALL_TAB_COMMENTS '+
                 'WHERE  OWNER=:P1 AND TABLE_NAME=:P2';
      DeclareVariable('P1',otString);
      SetVariable('P1',FOwner);
      DeclareVariable('P2',otString);
      SetVariable('P2',TableName);
      Execute;
      if not EOF then
         Result:= GetFirstStr(FieldAsString(FieldIndex('COMMENTS')))
      else Result:= '';
      if Result='' then Result:= Concat(FOwner,'.',TableName);
      Close;
      Free;
    end;
  end
  else Result:= FCapEyes;
end;

function TVWatchEdit.GetFieldLabel(const AFieldName: string): string;
var
  TempQuery: TOracleQuery;
begin
  TempQuery:= TOracleQuery.Create(Self);
  if  DataSource.DataSet is TOracleDataSet then
    TempQuery.Session:= (DataSource.DataSet as TOracleDataSet).Session;
  with TempQuery do
  begin
    SQL.Text:= 'SELECT COMMENTS FROM SYS.ALL_COL_COMMENTS '+
               'WHERE OWNER=:P1 AND TABLE_NAME=:P2 AND COLUMN_NAME=:P3';
    DeclareVariable('P1',otString);
    SetVariable('P1',FOwner);
    DeclareVariable('P2',otString);
    SetVariable('P2',TableName);
    DeclareVariable('P3',otString);
    SetVariable('P3',AFieldName);
    Execute;
    if not EOF then
    begin
      Result:= FieldAsString(FieldIndex('COMMENTS'));
      if Result='' then Result:= AFieldName;
    end
    else Result:= AFieldName;
    Close;
    Free;
  end;
end;

procedure TVWatchEdit.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if Message.NotifyCode=EN_UPDATE then Hint:= '';
end;

procedure TVWatchEdit.CMExit(var Message: TMessage);
begin
 { if Modified then
  begin
    Modified:= false;
    if Assigned(Field) then
       Field.AsString:= Text;
  end;}
  inherited;
end;

procedure TVWatchEdit.Settings;
begin
  if not Assigned(FSearch) then
    FSearch:= TfmSearch.Create(Self);
  FCapEyes:=GetCaption;
  FSearch.Caption:= FCapEyes;
  OpenQRY(FSearch);
  //ShowHint:= false;
  if Permission then
  with TfmSearch(FSearch).DBGrid do Options:= Options+[dgMultiSelect];
end;

function ListSortComp(Item1, Item2: Pointer): Integer;
begin
  Result:= Integer(Item1)-Integer(Item2);
end;

procedure TVWatchEdit.CloseEyes;
var
  I: Integer;
  Major,Minor: TField;
  ValueList: TList;
  DoInherited: boolean;
  idx: Integer;

procedure SaveInterval(begPoint,endPoint:Integer);
begin
  case  endPoint-begPoint of
    0: QueryValuesList.AddPoint
       ( FormatFloat(TNumericField(Major).DisplayFormat,begPoint)
         ,begPoint);
    1:
    begin
      QueryValuesList.AddPoint
      ( FormatFloat(TNumericField(Major).DisplayFormat,begPoint)
        ,begPoint);
      QueryValuesList.AddPoint
      ( FormatFloat(TNumericField(Major).DisplayFormat,endPoint)
        ,endPoint);
    end
    else QueryValuesList.AddInterval
         ('',begPoint,endPoint);
  end;
end;

procedure ListOptimizer;
var
  J: Integer;
  Start,Finish: Integer;
begin
  ValueList.Sort(ListSortComp);
  Start:= Integer(ValueList[0]);
  Finish:= Start;
  for J:= 1 to ValueList.Count-1 do
    if Pred(Integer(ValueList[J]))= Finish then
       Finish:= Integer(ValueList[J])
    else
    begin
      SaveInterval(Start,Finish);
      Start:= Integer(ValueList[J]);
      Finish:= Integer(ValueList[J]);
    end;
  SaveInterval(Start,Finish);
end;

begin
  with FSearch as TfmSearch do
  begin
    Major:= qrSearch.FieldByName(KeyField);
    Minor:= qrSearch.FieldByName(HintField);
    if Permission and ( (DBGrid.SelectedRows.Count>1) or
                        ((QueryState=piInto) and (DBGrid.SelectedRows.Count>0))
                        ) then
    begin
      qrSearch.DisableControls;
      ValueList:= TList.Create;
      for I:= 0 to DBGrid.SelectedRows.Count-1 do
      begin
        qrSearch.BookMark:= DBGrid.SelectedRows[I];
        ValueList.Add(Pointer(Major.AsInteger));
      end;
      ListOptimizer;
      ValueList.Free;
      QueryState:= piInto;
      qrSearch.EnableControls;
    end
    else
    begin
      if not (DataSource.DataSet.State in [dsInsert,dsEdit]) then
        DataSource.DataSet.Edit;
      DoInherited:= true;
      for I:= 0 to FNonDefMstr.Count-1 do
      begin
        //idx:= FList.IndexOf(FNonDefMstr[I]);
        //if idx>=0 then
          TVWatchEdit(FNonDefMstr.Objects[I]).Field.Value:=
            qrSearch.FieldByName(FNonDefMstr[I]).Value;
      end;
      if Assigned(FAcptValEvent) then
        FAcptValEvent(Self,DoInherited);
      if DoInherited then
      begin
        Self.Hint:= Minor.AsString;
        Self.Field.AsString:= Major.AsString;
      end;
      Self.Modified:= true;
      Self.QueryState:= DefaultState;
      if Self.Showing then Self.SetFocus;
    end;
  end;
end;

procedure TVWatchEdit.ClearHint(Sender: TObject);
begin
  Hint:= '';
end;

constructor TVWatchEdit.Create;
begin
  inherited;
  FCapEyes:= '';
  FKeyName:= '';
  FTabName:= '';
  FShowEyes:= true;
  FAutoLocate:= false;
  FNonDefMstr:= TStrFldList.Create;
  FList:= TStringList.Create;
  FDetailList:= TStringList.Create;
  FMasterList:= TStringList.Create;
  ButtonHint:= CEnterInvitation;
  OwnerTableByDefault;
  if not(csDesigning in ComponentState) then
  with FPopa do
  begin
    Items[Ord(piLike)].Visible:= false;
    Items[Ord(piNotLike)].Visible:= false;
  end;
end;

destructor TVWatchEdit.Destroy;
begin
  FNonDefMstr.Free;
  FList.Free;
  FDetailList.Free;
  FMasterList.Free;
  inherited;
end;

function TVWatchEdit.GetKeyName:string;
begin
  if Length(FKeyName)=0 then One2Two;
  Result:= FKeyName;
end;

procedure TVWatchEdit.SetKeyName;
begin
  FKeyName:= UpperCase(Trim(Value));
end;

procedure TVWatchEdit.One2Two;
var
  I: Integer;
begin
  I:= Length(DataField);
  FKeyName:= '';
  while(I>0) and (DataField[I]<>'_') do
  begin
    FKeyName:= DataField[I]+FKeyName;
    Dec(I)
  end;
  Dec(I);
  if FTabName= '' then
  while(I>0) and(DataField[I]<>'_') do
  begin
    FTabName:= DataField[I]+FTabName;
    Dec(I)
  end;
end;

procedure TVWatchEdit.OwnerTableByDefault;
var
  I: Integer;
  GoHome: boolean;
begin
  I:= Owner.ComponentCount-1;
  GoHome:= false;
  repeat
    Dec(I);
    if (I>=0) and (Owner.Components[I] is TVWatchEdit) then
    begin
       FOwner:= (Owner.Components[I] as TVWatchEdit).OwnerTable;
       GoHome:= true
    end;
  until (I<=0) or GoHome;
  if not GoHome then OwnerTable:= DefaultSchema;
end;

procedure TVWatchEdit.EditButtonClick(Sender: TObject);
var
  ByDefault: boolean;
begin
  try
  inherited;
  ByDefault:= not Assigned(FClickEvent);
  FSearch:= TfmSearch.Create(Self);
  if Assigned(FClickEvent) then FClickEvent(Self,ByDefault);
  if ByDefault then
  begin
    WorkProc;
  end;
  finally
    FSearch.Free;
    FSearch:= nil;
  end;
end;

procedure TVWatchEdit.WMLBUTTONDBLCLK(var Message: TWMMouse);
var
  ByDefault: boolean;
begin
  try
    ByDefault:= not Assigned(FClickEvent);
    FSearch:= TfmSearch.Create(Self);
    if Assigned(FClickEvent) then FClickEvent(Self,ByDefault);
    if ByDefault then
    begin
      inherited;
      if (FState<> piInto)
         and (Message.Keys and MK_CONTROL<>MK_CONTROL) then WorkProc;
    end;
  finally
    FSearch.Free;
    FSearch:= nil;
  end;
end;

procedure TVWatchEdit.WMKEYDOWN(var Message: TWMKey);
var
  ByDefault: boolean;
begin
  inherited;
  try
    if Message.CharCode= VK_SPACE then
    begin
      FSearch:= TfmSearch.Create(Self);
      ByDefault:= not Assigned(FClickEvent);
      if Assigned(FClickEvent) then FClickEvent(Self,ByDefault);
      if ByDefault then WorkProc;
    end;
  finally
    FSearch.Free;
    FSearch:= nil;
  end;
end;

procedure TVWatchEdit.WorkProc;
begin
  if ShowEyes  and not ReadOnly and not Field.ReadOnly then
    try
      Settings;
      if Assigned(FBeforeShowSearchForm) then
        FBeforeShowSearchForm(FSearch);
      if FSearch.ShowModal= mrOk then CloseEyes;
      //ShowHint:= true;
    finally
      FSearch.Free;
      FSearch:= nil;
    end
end;

procedure TVWatchEdit.GenerateList;
var
  ForeignKey: string;
  PrimaryKey: string;

procedure ExpandList;
var
  I: Integer;
begin
  for I:= 0 to FList.Count-1 do
    FList[I]:= Concat(FMaster.TableName,'_',FList[I]);
  for I:= 0 to FNonDefMstr.Count-1 do
    FNonDefMstr[I]:= Concat(FMaster.TableName,'_',FNonDefMstr[I]);
end;

procedure GenerateMasterDetailLists;
var
  Q: TOracleQuery;
begin
  Q:= TOracleQuery.Create(Self);
  FMasterList.Clear;
  FDetailList.Clear;
  with Q do
  // Determine related foreign key & primary/unique key
  try
    Session:= (DataSource.DataSet as TOracleDataSet).Session;
    Clear;
    ReadBuffer := 5;
    SQL.Add('select fk.constraint_name fkname, pk.constraint_name pkname');
    SQL.Add('  from sys.all_constraints fk, sys.all_constraints pk');
    SQL.Add(' where fk.constraint_type = ''R''');
    SQL.Add('   and fk.owner = :fk_owner and fk.table_name = :fk_table_name');
    SQL.Add('   and pk.constraint_name = fk.r_constraint_name');
    SQL.Add('   and pk.owner = :pk_owner and pk.table_name = :pk_table_name');
    DeclareVariable('fk_owner', otString);
    DeclareVariable('fk_table_name', otString);
    DeclareVariable('pk_owner', otString);
    DeclareVariable('pk_table_name', otString);
    SetVariable('fk_owner', OwnerTable);
    SetVariable('fk_table_name', TableName);
    SetVariable('pk_owner', FMaster.OwnerTable);
    SetVariable('pk_table_name', FMaster.TableName);
    Execute;
    // If no foreign key exists between the two tables, exit
    if EOF then
    begin
      ExpandList;
      Exit;
    end;
    ForeignKey := Field('fkname');
    PrimaryKey := Field('pkname');
    // Determine columns
    Clear;
    SQL.Add('select column_name from sys.all_cons_columns');
    SQL.Add(' where owner = :owner and constraint_name = :constraint_name');
    SQL.Add(' order by position');
    DeclareVariable('owner', otString);
    DeclareVariable('constraint_name', otString);
    SetVariable('owner', OwnerTable);
    SetVariable('constraint_name', ForeignKey);
    Execute;
    while not EOF do
    begin
      FDetailList.Add(Field('column_name'));
      Next;
    end;
    SetVariable('owner', FMaster.OwnerTable);
    SetVariable('constraint_name', PrimaryKey);
    Execute;
    while not EOF do
    begin
      FMasterList.Add(Field('column_name'));
      Next;
    end;
  finally
    Q.Free;
  end;
end;

procedure TransformList;
var
  I,idx: Integer;
begin
  if FMasterList.Count=0 then GenerateMasterDetailLists;
  for I:= 0 to FMasterList.Count-1 do
  begin
   idx:= FList.IndexOf(FMasterList[I]);
   if idx>=0 then
     FList[idx]:= FDetailList[I]
   else
   begin
     idx:= FNonDefMstr.IndexOf(FMasterList[I]);
     if idx>=0 then FNonDefMstr[idx]:= FDetailList[I];
   end;
  end;
end;

procedure AddsPlus;
var
  I: Integer;
begin
  for I:= 0 to FMaster.FNonDefMstr.Count-1 do
    FNonDefMstr.AddPlus( FMaster.FNonDefMstr[I],
                         FMaster.FNonDefMstr.Displays[I].DWidth,
                         FMaster.FNonDefMstr.Objects[I]);
end;

begin
  FList.Clear;
  FNonDefMstr.Clear;
  if Assigned(FMaster) then
  begin
    FMaster.GenerateList;
    FList.AddStrings(FMaster.FList);
    AddsPlus;//FNonDefMstr.AddStrings(FMaster.FNonDefMstr);
    //ExpandList;
    TransformList;
  end;
  if not Field.IsNull then FList.AddObject(KeyField,Field)
  else FNonDefMstr.AddPlus(Format('%s',[KeyField]),MaxLength,Self);
end;//GenerateList

function TVWatchEdit.AFTER_WHERE(const FullList:boolean):string;
var
  I,Limit: Integer;
  Appendix: string;
begin
  GenerateList;
  Result:= '';
  with FList do
  begin
    if FullList or Field.IsNull then Limit:= Count-1
    else Limit:= Count-2;
    for I:= 0 to Limit do
    begin
      Appendix:= Format('A.%s=:%s',[Strings[I],Strings[I]]);
      if Length(Result)>0 then
        Result:= Concat(Result,' AND ',Appendix)
      else Result:= Appendix;
    end;
  end;
end;//AFTER_WHERE

function TVWatchEdit.AFTER_SELECT:string;
var
  I: Integer;
begin
  Result:= '';
  for I:= 0 to FNonDefMstr.Count-2 do
    Result:= Concat(Result,'A.',FNonDefMstr[I],',');
end;//AFTER_SELECT

procedure TVWatchEdit.WMMOUSEMOVE(var Message: TWMMouse);
var
  HintQuery:TOracleQuery;
  FFieldDataLink:TFieldDataLink;

procedure FillVariables;
var
  OraType: Integer;
  I: Integer;
begin
  for I:= 0 to FList.Count-1 do
  begin
    case TField(FList.Objects[I]).DataType of
      ftString: OraType:= otString;
      ftDateTime: OraType:= otDate;
      ftFloat: OraType:= otFloat;
      else OraType:= otInteger
    end;
    HintQuery.DeclareVariable(FList[I],OraType);
    HintQuery.SetVariable(FList[I],TField(FList.Objects[I]).Value);
  end;
end;

begin
  if (QueryState<>piInto) and ShowHint then
  begin
    if Modified then
    begin
      Modified:= false;
      FFieldDataLink:= TFieldDataLink(Perform(CM_GETDATALINK,0,0));
      if FFieldDataLink.Active then FFieldDataLink.UpdateRecord;
    end;
    if (Hint='') then
    begin

      if not Assigned(Field) or Field.IsNull then Hint:= CNoDaMess
      else
      begin
        HintQuery:= TOracleQuery.Create(Self);
        with HintQuery do
        begin
          SQL.Text:= Format('SELECT A.%S FROM %S.%S A WHERE %S',
                            [FHintName,FOwner,TableName,AFTER_WHERE(True)]);
          FillVariables;
          if DataSource.DataSet is TOracleDataSet then
          Session:= (DataSource.DataSet as TOracleDataSet).Session;
          try
            Execute;
            if EOF then Hint:= CUnknownField
            else
              Hint:= Concat(Trim(FieldAsString(FieldIndex(HintField))),'|');
            Close
          except
            Free;
            Hint:= CUnknownField;
            raise;
          end;
          Free;
        end;
      end;
  end;
  end;
 inherited;
end;

function TVWatchEdit.GetEyesQuery: TVASUPQuery;
begin
  if FSearch is TfmSearch then
    Result:= (FSearch as TfmSearch).qrSearch
  else Result:= nil;
end;

procedure TVWatchEdit.OpenQRY(SearchForm: TForm);
var
  FrstWord: Integer;
  SQLTail: string;
  ZeroChain: string;
  I: Integer;
  DInfo: TDisplayInfo;
  idx: Integer;

procedure KeepFrstWord(AIndex:Integer);
var
  IdxFrst: Integer;
  xdinfo: TDisplayInfo;
begin
  xdinfo:= FNonDefMstr.Displays[AIndex];
  IdxFrst:= Pos(' ',xdinfo.DLabel);
  if IdxFrst>1 then
  begin
    xdinfo.DLabel:= Copy(xdinfo.DLabel,1,IdxFrst-1);
    FNonDefMstr.Displays[AIndex]:= xdinfo;
  end;
end;

procedure FillVariables;
var
  OraType: Integer;
  I: Integer;
begin
  for I:= 0 to FList.Count-1 do
  if TField(FList.Objects[I])<> Field then
  begin
    case TField(FList.Objects[I]).DataType of
      ftString: OraType:= otString;
      ftDateTime: OraType:= otDate;
      ftFloat: OraType:= otFloat;
      else OraType:= otInteger
    end;
    with (SearchForm as TfmSearch).qrSearch do
    begin
      if VariableIndex(FList[I])<0 then
        DeclareVariable(FList[I],OraType);
      SetVariable(FList[I],TField(FList.Objects[I]).Value);
    end;
  end;
end;

function SetDecodeFieldIndex(const AFieldName: string; AIndex: Integer):bool;
var
  LD: Integer;
  DFName: string;
  DF: TField;
begin
  LD:= LastDelimiter('_',AFieldName);
  if LD>0 then
    DFName:= Copy(AFieldName,1,LD)+'NAIM';
  DF:= (SearchForm as TfmSearch).qrSearch.FindField(DFName);
  Result:= Assigned(DF);
  if Result then
    DF.Index:= AIndex;
end;

begin
  with (SearchForm as TfmSearch).qrSearch do
  begin
    Session:= (Self.DataSource.DataSet as TOracleDataSet).Session;
    if Length(OwnerTable)>0 then
      UpdatingTable:= Concat(OwnerTable,'.',TableName)
    else UpdatingTable:= TableName;
    SetSQLFields([KeyField,FHintName]);
    SQLTail:= AFTER_WHERE(False);
    if Assigned(Self.FMaster) then
      {if Length(SQLTail)>0 then
      begin
        DefaultSQL:= Format( 'SELECT %s A.%s,A.%s FROM %s A WHERE %S',
                             [AFTER_SELECT,KeyField,FHintName,UpdatingTable,SQLTail]);
        FillVariables;
      end
      else DefaultSQL:= Format( 'SELECT %s A.%s,A.%s FROM %s A',
                                [AFTER_SELECT,KeyField,FHintName,UpdatingTable]);}
      if Length(SQLTail)>0 then
      begin
        DefaultSQL:= Format( 'SELECT A.* FROM %s A WHERE %S',
                             [UpdatingTable,SQLTail]);
        FillVariables;
      end
      else DefaultSQL:= Format( 'SELECT A.* FROM %s A',
                                [UpdatingTable])
    else DefaultSQL:= Format( 'SELECT A.* FROM %s A',
                                [UpdatingTable]);
    if Length(Order)=0 then
      for I:= FNonDefMstr.Count-1 downto 0 do
      begin
        if Length(Order)=0 then
          Order:= FNonDefMstr[I]+' ASC '
        else Order:= FNonDefMstr[I]+' ASC ,'+Order;
      end;
    Execute;
    if FAutoLocate then
      Locate(KeyField,Field.Value,[]);
    SetComments;
    idx:= 0;
    for I:= 0 to FNonDefMstr.Count-1 do
    begin
      FieldByName(FNonDefMstr[I]).Index:= idx;
      if SetDecodeFieldIndex(FNonDefMstr[I],idx+1) then Inc(idx,2)
      else Inc(idx);
    end;
    FrstWord:= Pos(' ',FieldByName(KeyField).DisplayLabel);
    if FrstWord>1 then FieldByName(KeyField).DisplayLabel:=
      Copy(FieldByName(KeyField).DisplayLabel,1,FrstWord-1);
  end;
  {for I:= 0 to FNonDefMstr.Count-1 do
  begin
    DInfo:= FNonDefMstr.Displays[I];
    DInfo.DLabel:= GetFieldLabel(FNonDefMstr[I]);
    FNonDefMstr.Displays[I]:= DInfo;
  end;
  if FNonDefMstr.Count>0 then
     KeepFrstWord(FNonDefMstr.Count-1);}
  with (SearchForm as TfmSearch) do
  begin
    {PrimaryField.DisplayLabel:= GetFieldLabel(FKeyName);
    PrimaryField.FieldName:= FKeyName;
    if Field is TNumericField then
      with Field as TNumericField do
      begin
        if MaxLength>0 then PrimaryField.DisplayWidth:= MaxLength
        else  PrimaryField.DisplayWidth:= DisplayWidth;
        if Field is TIntegerField then
        begin
          ZeroChain:= '';
          while Length(ZeroChain)<MaxLength do
            ZeroChain:= Concat(ZeroChain,'0');
          PrimaryField.DisplayFormat:= ZeroChain;
        end
        else PrimaryField.DisplayFormat:= DisplayFormat;
      end;
    FrstWord:= Pos(' ',PrimaryField.DisplayLabel);
    if FrstWord>1 then PrimaryField.DisplayLabel:=
      Copy(PrimaryField.DisplayLabel,1,FrstWord-1);
    HelpField.DisplayLabel:= GetFieldLabel(FHintName);
    HelpField.FieldName:= FHintName;}
    ShowMode:= smCustom;
    FreeMasters:= FNonDefMstr;
  end;
end;


{ * TVCommentQuery }

function TVCommentQuery.ExtractTable_;
var
  I: Integer;
begin
  I:= Pos('.',UpdatingTable);
  Result:= UpperCase(Copy(UpdatingTable,I+1,Length(UpdatingTable)-I))
end;

function TVCommentQuery.ExtractTable;
var
  I: Integer;
begin
  I:= Pos('.',UpdatingTable);
  if FTableName='' then
    Result:= ''''+UpperCase(Copy(UpdatingTable,I+1,Length(UpdatingTable)-I))+''''
  else Result:= ''''+FTableName+'''';
end;

function TVCommentQuery.ExtractOwner_;
var
  I: Integer;
begin
  I:= Pos('.',UpdatingTable);
  if I<2 then Result:= DefaultSchema
  else Result:= UpperCase(Copy(UpdatingTable,1,I-1));
end;

function TVCommentQuery.IsSynonym(var AOwner,ATableName:string):bool;
begin
  with TOracleQuery.Create(Self) do
  begin
    Session:= Self.Session;
    SQL.Text:=
    'SELECT t.table_owner,t.table_name '+
    'FROM sys.all_synonyms t '+
    'WHERE t.owner in (''PUBLIC'',:1) AND t.synonym_name=:2';
    DeclareVariable('1',otString);
    DeclareVariable('2',otString);
    SetVariable('1',DefaultSchema);
    SetVariable('2',UpperCase(UpdatingTable));
    Execute;
    Result:= not EOF;
    if Result then
    begin
      AOwner:= Field(0);
      ATableName:= Field(1);
    end
    else
    begin
      AOwner:= '';
      ATableName:= '';
    end;
    Close;
    Free;
  end;
end;

function TVCommentQuery.ExtractOwner;
var
  I: Integer;
begin
  I:= Pos('.',UpdatingTable);
  if I<2 then
  begin
    if FTableOwner='' then
      if not IsSynonym(FTableOwner,FTableName) then
        Result:= DefaultSchema
      else Result:= FTableOwner
    else Result:= FTableOwner;
  end
    else Result:= UpperCase(Copy(UpdatingTable,1,I-1));
  Result:= ''''+Result+'''';
end;

function TVCommentQuery.GetUpdatingTable: string;
begin
  Result:= inherited GetUpdatingTable;
  if (Pos('.',Result)=0 ) and FUseDefSchema then
    Result:= DefaultSchema + '.' + Result;
end;

// Determine the alias of the updating table
function TVCommentQuery.GetUpdatingAlias: string;
var s, so: string;
    i, FromPos, TablePos: Integer;
begin
  try
    FUseDefSchema:= False;
    if Trim(FROWIDAlias) <> '' then
      Result := FROWIDAlias
    else
      Result := inherited GetUpdatingAlias;
  finally
    FUseDefSchema:= True;
  end;
end;

function LPad(AString: String;Len:Integer;AChar: Char):string;
begin
  Result:= AString;
  while Length(Result)<Len do
    Result:= AChar+Result;
end;

function RPad(AString: String;Len:Integer;AChar: Char):string;
begin
  Result:= AString;
  while Length(Result)<Len do
    Result:= Result+AChar;
end;

function AddThousandSeparator(AString:string):string;
var
  I: Integer;
  Len: Integer;
begin
  Len:= Length(AString);
  Result:= '';
  for I:= Len downto 1 do
  begin
    Result:= AString[I]+Result;
    if ((Len-I+1) mod 3=0) and (I>1) then
      Result:= ','+Result;
  end;
end;

procedure TVCommentQuery.SetComments;
var
  QryField: TField;
  Temp: string;
  ConsSet: TOracleDataSet;

function IsKey(FieldName:string):bool;
begin
  if not assigned(ConsSet) then
  begin
    ConsSet:= TOracleDataSet.Create(Self);
    with ConsSet do
    begin
      Session:= Self.Session;
      SQL.Text:=
      'SELECT cc.COLUMN_NAME '+
      'FROM sys.all_constraints c, sys.all_cons_columns cc '+
      'WHERE cc.OWNER=:own AND cc.TABLE_NAME=:tab '+
      'AND cc.constraint_name=c.constraint_name '+
      'AND c.constraint_type in (''P'',''R'')';
      DeclareVariable('own',otString);
      DeclareVariable('tab',otString);
      SetVariable('own',ExtractOwner_);
      SetVariable('tab',ExtractTable_);
      Open;
    end;
  end;
  Result:= ConsSet.Locate('COLUMN_NAME',FieldName,[]);
end;

begin
  with TOracleQuery.Create(Self) do
  begin
    Session:= Self.Session;
    SQL.Text:=
      'SELECT COMMENTS,COLUMN_NAME from sys.all_col_comments WHERE OWNER=:own AND TABLE_NAME=:tab';
    DeclareVariable('own',otString);
    DeclareVariable('tab',otString);
    SetVariable('own',ExtractOwner_);
    SetVariable('tab',ExtractTable_);
    Execute;
    while not EOF do
    begin
      QryField:= Self.FindField(FieldAsString(1));
      if Assigned(QryField) then
        QryField.DisplayLabel:= FieldAsString(0);
      Next
    end;
    Close;
    SQL.Text:=
      'SELECT COMMENTS FROM SYS.ALL_TAB_COMMENTS WHERE OWNER=:own AND TABLE_NAME=:tab';
    Execute;
    if not EOF then
       Temp:= GetFirstStr(FieldAsString(0));
    if Temp='' then begin
     if FCaption='' then FCaption:= UpdatingTable
    end
    else FCaption:= Temp;
    Close;
    // определение масок полей числового типа
    SQL.Text:=
      'SELECT t.COLUMN_NAME,t.DATA_PRECISION,t.DATA_SCALE from '+
      'sys.all_tab_columns t '+
      'WHERE t.OWNER=:own AND t.TABLE_NAME=:tab AND t.DATA_TYPE=:dtype ';
    DeclareVariable('dtype',otString);
    SetVariable('dtype','NUMBER');
    Execute;
    while not EOF do
    begin
      QryField:= Self.FindField(FieldAsString('column_name'));
      if Assigned(QryField) then
      with QryField as TNumericField do
      begin
        if FieldAsInteger('data_scale')=0 then //целое число
          if FieldAsInteger('data_precision')<=6{IsKey(QryField.FieldName)} then //без разделителей тысяч
          begin
            DisplayWidth:= FieldAsInteger('data_precision');
            DisplayFormat:= LPad('',FieldAsInteger('data_precision'),'0');
            EditFormat:= DisplayFormat;
          end
          else
          begin
            EditFormat:= LPad('0',FieldAsInteger('data_precision'),'#');
            DisplayFormat:= AddThousandSeparator(EditFormat);
            DisplayWidth:= Length(DisplayFormat);
          end
        else // с дробной частью
        begin
          EditFormat:= LPad('0',FieldAsInteger('data_precision')-FieldAsInteger('data_scale'),'#')+
                        '.'+RPad('',FieldAsInteger('data_scale'),'#');
          DisplayFormat:= AddThousandSeparator(LPad('0',FieldAsInteger('data_precision')-
                           FieldAsInteger('data_scale'),'#'))+'.'+RPad('',FieldAsInteger('data_scale'),'#');
          DisplayWidth:= Length(DisplayFormat);
        end;
      end;
      Next
    end;
    Close;
    Free;
    ConsSet.Free;
  end;
end;

const
  SingleMsg= 'Запись с таким значением поля %s уже существует';
  PluralMsg= 'Запись с такими значениями полей %s уже существует';

function  TVCommentQuery.FindUnique;
var
  I: Integer;
  CurField: TField;
  PrimFields: TStrings;
begin
  with TOracleQuery.Create(Self) do
  begin
    Session:= Self.Session;
    SQL.Text:= 'SELECT COLUMN_NAME FROM SYS.ALL_CONS_COLUMNS WHERE OWNER=:own AND CONSTRAINT_NAME=:cnstr';
    DeclareVariable('own',otString);
    DeclareVariable('cnstr',otString);
    SetVariable('own',ExtractOwner_);
    SetVariable('cnstr',ConstraintName);
    Execute;
    if RowsProcessed=1 then
    begin
      CurField:= FieldByName(FieldAsString(0));
      Result:= Format( SingleMsg,
                       ['"'+CurField.DisplayLabel+'"']);
      CurField.FocusControl;
    end
    else
    begin
      PrimFields:= TStringList.Create;
      Result:= '';
      while not EOF do
      begin
        CurField:= FieldByName(FieldAsString(0));
        PrimFields.Add(CurField.DisplayLabel);
        if CurField.Visible then
        begin
          if Length(Result)=0 then CurField.FocusControl
          else Result:= Concat(Result,';');
          Result:= Format('%s"%s"',[Result,CurField.DisplayLabel]);
          Next;
        end
        else Next;
      end;
      if Length(Result)= 0 then
        for I:= 0 to PrimFields.Count-1 do
        begin
          Result:= Format('%s"%s"',[Result,PrimFields[I]]);
          if I<PrimFields.Count-1 then
             Result:= Concat(Result,';');
        end;
      PrimFields.Free;
      if Pos(';',Result)>0 then
         Result:= Format(PluralMsg,[Result])
      else Result:= Format(SingleMsg,[Result])
    end;
    Free;
  end;
end;

function  TVCommentQuery.FindBadValue;
var
  BadField: TField;
  fldCount: Integer;
begin
  with TOracleQuery.Create(Self) do
  begin
    Session:= Self.Session;
    SQL.Text:= 'SELECT COLUMN_NAME FROM SYS.ALL_CONS_COLUMNS WHERE OWNER=:own AND CONSTRAINT_NAME=:cnstr';
    DeclareVariable('own',otString);
    DeclareVariable('cnstr',otString);
    SetVariable('own',ExtractOwner_);
    SetVariable('cnstr',ConstraintName);
    Execute;
    if not EOF then
    begin
     fldCount:= 0;
     Result:= 'Неправильные данные %s ';
     while not EOF do
     begin
       BadField:= FindField(FieldAsString(0));
       if Assigned(BadField) then
       begin
         if fldCount>0 then
           Result:= Concat(Result,',')
         else BadField.FocusControl;
         Result:= Concat(Result,'"'+BadField.DisplayLabel+'"');
         Inc(fldCount);
       end;
       Next;
     end;
     if fldCount>0 then
     begin
       Result:= Concat(Result,' .');
       if fldCount=1 then Result:= Format(Result,['в поле'])
       else Result:= Format(Result,['среди полей'])
     end
     else Result:= '';
    end
    else Result:= '';
    Close;
    Free;
  end;
end;

procedure  TVCommentQuery.TriggerHandler;
var
  BadField: TField;
  Start,Finish: Integer;
  TextPos: Integer;
begin
  Start:= Pos('(',Msg);
  BadField:= nil;
  if Start>0 then
  begin
    Finish:= Pos(')',Msg);
    BadField:= FindField(Copy(Msg,Start+1,Finish-Start-1));
  end
  else Start:= Length(Msg)+1;
  TextPos:= Pos(' ',Msg);
  Inc(TextPos);
  Msg:= Copy(Msg,TextPos,Start-TextPos);
  if Assigned(BadField) then BadField.FocusControl;
end;

const
  CNullNotAllowed='Поле "%s" не может быть пустым';

procedure TVCommentQuery.FindNullField(var Msg:string);
var
  I: Integer;
  GoOut: bool;
begin
  GoOut:= false;
  I:= 0;
  while not GoOut and (I<FieldCount) do
    if Fields[I].Required and
       (Length(Fields[I].AsString)=0) then
      GoOut:= true
    else Inc(I);
  if GoOut then
  begin
    Fields[I].FocusControl;
    Msg:= Format(CNullNotAllowed,[Fields[I].DisplayLabel]);
  end;
end;

procedure TVCommentQuery.AdvancedMessage;

procedure TransToRussian(var Msg: string);
begin
  if CompareText(Msg,'Record has been deleted by another user')=0 then
    Msg:= CUserDeleteMsg
  else if CompareText(Msg,'Record has been changed by another user')=0 then
  begin
    Msg:= CUserUpdateMsg;
    RefreshRecord;
  end;
end;

begin
   case ErrorCode of
      0: if not OracleDictionary.UseMessageTable then
           TransToRussian(Msg);
      1: if not OracleDictionary.UseMessageTable then
           Msg:= FindUnique(ConstraintName);
      54: Msg:= CUserLockMsg;
      1402: Msg:= CNonCheckMess;
      1400,1407: if not OracleDictionary.UseMessageTable then
                   FindNullField(Msg);
      2290,2291: if not OracleDictionary.UseMessageTable then
                   Msg:= FindBadValue(ConstraintName);
      2292: Msg:= CKillForeignMess;
      20000..20999: TriggerHandler(Msg)
    end
end;

procedure TVCommentQuery.AfterOpenPRO;
begin
  if not FReActive then
  begin
    SetComments;
    FReActive:= true;
  end;
end;

constructor  TVCommentQuery.Create;
begin
  inherited Create(AOwner);
  FReActive:= false;
  FCaption:= '';
  RefreshOptions:= FullRefresh;
  FUseDefSchema:= True;
  AfterOpen:= AfterOpenPRO;
  OnTranslateMessage:= AdvancedMessage;
  FTableOwner:= '';
  FTableName:= '';
end;

function TTreeSQLDescription.FindNodeByQuery(AQuery: TVASUPQuery):TTreeSQLDescription;
var
  Masters: TStrings;
  NextQuery: TVASUPQuery;
  I,J: Integer;
begin
  Masters:= TStringList.Create;
  NextQuery:= AQuery;
  while Assigned(NextQuery) do
  begin
    Masters.Insert(0,NextQuery.Caption);
    NextQuery:= NextQuery.Master as TVASUPQuery;
  end;
  if (Masters.Count=0) then Result:= nil
  else if (Masters[0]<>Caption) and (Length(Caption)>0) then Result:= nil
    else Result:= Self;
  for I:= 1 to Masters.Count-1 do
  begin
    J:= 0;
    while (J<Result.Count)
          and (Masters[I]<>Result.Children[J].Caption) do Inc(J);
    if J=Result.Count then
    begin
      Result.Add(TTreeSQLDescription.Create);
      Result.Children[J].Caption:= Masters[I];
    end;
    Result:= Result.Children[J]
  end;
  Result.Clear;
end;

function TTreeSQLDescription.GetChild(Index: Integer):TTreeSQLDescription;
begin
  Result:= TTreeSQLDescription(Items[Index]);
end;

procedure TTreeSQLDescription.SetChild(Index: Integer;Value: TTreeSQLDescription);
begin
  if Items[Index]<>Value then
    TTreeSQLDescription(Items[Index]).Free;
  Items[Index]:= Value;
end;

procedure TTreeSQLDescription.Add;
begin
  inherited Add(Value);
end;

procedure TTreeSQLDescription.Clear;
var
  I: Integer;
begin
  for I:= Count-1 downto 0 do
    TTreeSQLDescription(Items[I]).Free;
  inherited Clear;
  FText:= '';
end;

destructor TTreeSQLDescription.Destroy;
begin
  Clear;
  inherited;
end;

{ * TLinkedQuery}

function TLinkedQuery.GetNode(Index: Integer):TLinkedQueryNode;
var
  PResult: PTLinkedQueryNode;
begin
  PResult:= Items[Index];
  Result:= PResult^;
end;

procedure TLinkedQuery.SetNode(Index: Integer;Value: TLinkedQueryNode);
var
  PNewNode: PTLinkedQueryNode;
begin
  Dispose(PTLinkedQueryNode(Items[Index]));
  New(PNewNode);
  PNewNode^:= Value;
  Items[Index]:= PNewNode;
end;

procedure TLinkedQuery.Clear;
var
  I: Integer;
begin
  for I:= Count-1 downto 0 do
    Dispose(PTLinkedQueryNode(Items[I]));
  inherited Clear;
end;

destructor TLinkedQuery.Destroy;
begin
  Clear;
  inherited;
end;

procedure TLinkedQuery.Add(Value: TLinkedQueryNode);
var
  PNewNode: PTLinkedQueryNode;
begin
  New(PNewNode);
  PNewNode^:= Value;
  inherited Add(PNewNode);
end;

function TLinkedQuery.IsEmpty:bool;
var
  I: Integer;
begin
  Result:= SelfIndex=-1;//пустой запрос в личной библиотеке
  I:= 0;
  while Result and (I<Count) do
  begin
    if Nodes[I].Index >= 0 then
      Result:= TLinkedQuery(Nodes[I].Obj.FLinkedQueries[Nodes[I].Index]).IsEmpty;
    Inc(I);
  end;
end;

function TLinkedQuery.Equal(AOther: TLinkedQuery):bool;
var
  I: Integer;
begin
  Result:= (AOther.SelfIndex= FSelfIndex) and
           (AOther.SelfObj= FSelfObj) and
           (AOther.Count= Count);
  I:= 0;
  while Result and (I<Count) do
  begin
    Result:= (Nodes[I].Obj= AOther.Nodes[I].Obj)
             and (Nodes[I].Index= AOther.Nodes[I].Index);
    Inc(I);
  end;
end;

{ TLinkedQueryList}

constructor TLinkedQueryList.Create(AOwner: TVASUPQuery);
begin
  inherited Create;
  FOwner:= AOwner;
  FIndex:= -1;
  FDefferedDelIndex:= -1;
end;

procedure TLinkedQueryList.ClearZone;
var
  I: Integer;
begin
  if FIndex in [0..Count-1] then
    for I:= 0 to Nodes[FIndex].Count-1 do
      Nodes[FIndex].Nodes[I].Obj.LinkedQueryList.ClearZone;
  FOwner.ClearScreen;
end;

procedure TLinkedQueryList.Seek(Index: Integer);
var
  I: Integer;
begin
  FOwner.ClearDependents;
  ClearZone;
  if Index>=0 then
    with Nodes[Index] do
    begin
      if not FOwner.Active then FOwner.Open;
      //{if FOwner.State<>dsInsert then }FOwner.Cancel;
      FOwner.OpenViSession;
      FOwner.OnScreen(SelfIndex);
      FOwner.WorkState:= wsQuery;
      for I:= 0 to Count-1 do
        Nodes[I].Obj.LinkedQueryList.Seek(Nodes[I].Index);
    end;
  FIndex:= Index;
end;

function TLinkedQueryList.GetNode(Index: Integer):TLinkedQuery;
begin
  Result:= TLinkedQuery(Items[Index]);
end;

procedure TLinkedQueryList.SetNode(Index: Integer;Value: TLinkedQuery);
begin
  TLinkedQuery(Items[Index]).Free;
  Items[Index]:= Value;
end;

procedure TLinkedQueryList.Delete(Index: Integer);
var
  LibIndex: Integer;
begin
  Nodes[Index].Free;
  inherited Delete(Index);
  if FIndex>=Index then Dec(FIndex);
  if FIndex<0 then FIndex:= Count-1;
  {if FIndex>=0 then
    with Nodes[FIndex] do LibIndex:= SelfIndex
  else LibIndex:= FIndex;
  with Nodes[FIndex].SelfObj do
    if LibIndex>=0 then
      FLib.ItemIndex:= LibIndex
    else FLib.ItemIndex:= FLib.Count-1;}
end;

procedure TLinkedQueryList.DefferedDelete;
begin
  if FDefferedDelIndex>=0 then
  begin
   { with Nodes[FDefferedDelIndex] do
      if Count=0 then SelfObj.FLib.Delete(SelfIndex);}
    Delete(FDefferedDelIndex);
    FDefferedDelIndex:= -1;
  end;
end;

procedure TLinkedQueryList.Add(Value: TLinkedQuery);
var
  I: Integer;
begin
  if FDefferedDelIndex>=0 then DefferedDelete;
  if not FOwner.LinkDetailSQL then
  begin
    I:= 0;
    while (I<Count) and not Value.Equal(Nodes[I]) do Inc(I);
    if I<Count then Delete(I);
  end;
  {if not Value.IsEmpty then
  // добавление если не цепочка с пустыми запросами ко всем узлам
  begin}

    inherited Add(Value);
    FIndex:= Count-1;
    if not FOwner.LinkDetailSQL then
    begin
      I:= 0;
      if Count>1 then
        if Nodes[Count-2].IsEmpty then
        begin
          ExChange(Count-2,Count-1);
          Dec(FIndex);
        end;
    end;
    FOwner.FEOQ:= FIndex= Count-1;
  //end;
end;

procedure TLinkedQueryList.Pack;
var
  I: Integer;
begin
  inherited Pack;
  I:= 0;
  while (I<Count-1) and not Nodes[Count-1].Equal(Nodes[I]) do Inc(I);
  if I<Count-1 then
  begin
    Delete(I);
    FIndex:= Count-1;
  end;
  if Count>1 then
    if Nodes[Count-2].IsEmpty then
    begin
      ExChange(Count-2,Count-1);
      Dec(FIndex);
    end;
  FOwner.FEOQ:= FIndex= Count-1;
end;

procedure TLinkedQueryList.Clear;
var
  I: Integer;
begin
  for I:= Count-1 downto 0 do TLinkedQuery(Items[I]).Free;
  inherited Clear;
  FIndex:= -1;
end;

destructor TLinkedQueryList.Destroy;
begin
  Clear;
  inherited;
end;

{ * TVAsupQuery }

function ReplaceSTR;
var
  Position: Integer;
begin
  Result:= '';
  repeat
    Position:= Pos(OldSub,Source);
    if Position>0 then
    begin
      Result:= Concat(Result,Copy(Source,1,Position-1),NewSub);
      Inc(Position,Length(OldSub));
      Source:= Copy(Source,Position,Length(Source)- Position+1)
    end
    else Result:= Concat(Result,Source);
  until Position=0;
end;

constructor TVisualQuery.Create(ADataSet: TDataSet);
begin
  inherited Create;
  FDataSet:= ADataSet;
end;

function TVisualQuery.l_GetSQLText: string;
var
  I: Integer;
  iField: TField;

function OraDate(DateStr: string):string;
begin
  Result:= Format('TO_DATE(%S,%S)',[ InBrack(DateStr),
                                     InBrack(LongDateFmtLine)]);
end;

begin
  Result:= '';
    for I:= 0 to Count-1 do
    with Blocks[I] do
    begin
      if (Length(Result)>0) and (Expr<>piVariable) then
         Result:= Concat(Result,' AND ');
      if ResType= rtFilter then Result:= Concat(Result, Value)
      else
      begin
        iField:= FDataSet.FieldByName(FieldName);
        if Length(Value)>0 then
        begin
          if iField is TDateTimeField then
          begin
            if Expr=piNone then Expr:= piEqual;
            case Expr of
              piInto: Result:= Concat(Result,Value);
              piLike: Result:= Concat( Result,Format('trunc(%s)',[OriginFieldName(iField)]),
                                    StatePUMenuToStr(piEqual),OraDate(Value));
              piNotLike: Result:= Concat( Result,Format('trunc(%s)',[OriginFieldName(iField)]),
                                    StatePUMenuToStr(piNotEqual),OraDate(Value));
              else Result:= Concat( Result,Format('%s',[OriginFieldName(iField)]),
                                    StatePUMenuToStr(Expr),OraDate(Value));
            end
          end
          else case Expr of
            piNone,piLike:
              Result:= Concat( Result,OriginFieldName(iField),
                               ' LIKE ',InBrack(Concat(Value,'%')));
            piNotLike:Result:= Concat(Result,OriginFieldName(iField),' NOT LIKE ',InBrack(Concat(Value,'%')) );
            piUserDefined,piTempVariable: Result:= Concat(Result,ResString );
            //piVariable: SetVariable(ResString,Value);
            piInto: Result:= Format('%s (%s)',[Result,Value])
            else if iField is TStringField then
              Result:= Concat( Result,OriginFieldName(iField),
                               StatePUMenuToStr(Expr),InBrack(Value))
              else Result:= Concat( Result,OriginFieldName(iField),
                                    StatePUMenuToStr(Expr),Value)
          end
        end
        else case Expr of
          piNotEqual: Result:= Concat(Result,OriginFieldName(iField),' IS NOT NULL ');
          piEqual: Result:= Concat(Result,OriginFieldName(iField),' IS NULL ');
        end;
      end;
    end;
end;

function TVisualQuery.GetSQLDescription:string;
var
  I: Integer;
  iField: TField;
  iFieldCaption: string;

function GetDisplayText(EnumList: TVEnumValueList;AField: TField): string;
var
  J: Integer;
  s_union: string;
begin
  Result:= '';
  if EnumList.Union=unOR then
    s_union:= AnsiLowerCase(OR_hint)
  else s_union:= AnsiLowerCase(AND_hint);
  for J:= 0 to EnumList.Count-1 do
  begin
    if Length(Result)>0 then
      Result:= Concat(Result,s_union);
    Result:= Concat(Result,EnumList.GetDisplayText(J,elHint,AField));
  end;
end;

function _tostr(Expr:TSQLExpression):string;
begin
  if Expr=piNotEqual then
    Result:= ' не равно '
  else Result:= ' '+StatePUMenuToStr(Expr)+' ';
end;

begin
  Result:= '';
    for I:= 0 to Count-1 do
    with Blocks[I] do
    begin
      if Length(Result)>0 then
         Result:= Concat(Result,' и ');
      if Length(Comment)>0 then
        Result:= Concat(Result,Comment)
      else
        if ResType= rtFilter then Result:= Concat(Result, Format('фильтр(%s)',[Value]))
        else
        begin
          iField:= FDataSet.FieldByName(FieldName);
          iFieldCaption:= InBrack2(iField.DisplayLabel);
          if Length(Value)>0 then
          begin
            if iField is TDateTimeField then
            begin
              if Expr=piNone then Expr:= piEqual;
              case Expr of
                piInto: Result:= Format('%s (%s %s)',
                  [Result,iFieldCaption,GetDisplayText(ResEnumList,iField)]);
                piLike: Result:= Concat( Result,iFieldCaption,
                                      _ToStr(piEqual),InBrack(Value));
                piNotLike,piNotEqual: Result:= Concat( Result,iField.DisplayLabel,
                                      ' не равно ',InBrack(Value));
                else Result:= Concat( Result,iFieldCaption,
                                      _ToStr(Expr),InBrack(Value));
              end
            end
            else case Expr of
              piNone,piLike:
                Result:= Concat( Result,iFieldCaption,
                                 ' как ',InBrack(Value));
              piNotLike: Result:= Concat(Result,iFieldCaption,' не как ',InBrack(Value) );
              //piUserDefined: Result:= Concat(Result,ResString );
              piVariable: Result:= Concat(Result,ResString,'=',Value);
              piInto: Result:= Format('%s (%s =  %s)',
                  [Result,iFieldCaption,GetDisplayText(ResEnumList,iField)]);
              else if iField is TStringField then
                Result:= Concat( Result,iFieldCaption,
                                 _tostr(Expr),InBrack(Value))
                else Result:= Concat( Result,iFieldCaption,
                                      _tostr(Expr),Value)
            end
          end
          else case Expr of
            piNotEqual: Result:= Concat(Result,iFieldCaption,' не пусто ');
            piEqual: Result:= Concat(Result,iFieldCaption,' пусто ');
          end;
        end;
    end;
end;


function TVisualQuery.GetBlock;
var
  PSQL: TPSQL;
begin
  PSQL:= Items[Index];
  Result:= PSQL^;
end;

procedure TVisualQuery.Add;
var
  PSQL: TPSQL;
begin
  New(PSQL);
  PSQL^:= ASQL;
  inherited Add(PSQL);
end;

procedure TVisualQuery.Delete;
var
  PSQL: TPSQL;
begin
  PSQL:= Items[Index];
  case PSQL^.ResType of
    rtString:StrDispose(PSQL^.ResString);
    rtEnumList: PSQL^.ResEnumList.Free;
  end;
  Dispose(PSQL);
  inherited Delete(Index);
end;

procedure TVisualQuery.Clear;
var
  PSQL: TPSQL;
  I: Integer;
begin
  for I:= 0 to Count-1 do begin
    PSQL:= Items[I];
    if Assigned(PSQL) then Dispose(PSQL);
  end;
  inherited Clear;
end;

function TVisualQuery.Equal;
var
  I: Integer;
  Black,White: TPSQL;
begin
  Result:= Count=AVQuery.Count;
  I:= 0;
  while Result and (I<Count) do
  begin
    Black:= Items[I];
    White:= AVQuery.Items[I];
    with Black^ do
    begin
      Result:= (FieldName=White^.FieldName) and (Expr=White^.Expr)
               and ((Expr= piInto) or (Value=White^.Value));
      if Result and (Expr= piInto) then
         Result:= ResEnumList.Equal(White^.ResEnumList);
    end;
    Inc(I);
  end;
end;

destructor TVisualQuery.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TVisualQuery.IndexOf;
var
  I: Integer;
begin
  Result:= -1;
  I:= 0;
  while (I<Count) and (Result<0) do
    if CompareText(Blocks[I].FieldName,DataField)=0 then
    begin
      Block:= Blocks[I];
      Result:= I
    end
    else Inc(I);
end;

function TVQLibrary.GetQuery;
begin
  Result:= Items[Index];
end;

procedure TVQLibrary.Add;
var
  I: Integer;
  VQItem: TVisualQuery;
begin
  Pack;
  I:= 0;
  while (I<Count) and not AVQuery.Equal(Queries[I]) do Inc(I);
  if I=Count then
    inherited Add(AVQuery);
  FItem:= I;
  inherited Add(nil);
end;

procedure TVQLibrary.Delete;
var
  VQuery: TVisualQuery;
begin
  VQuery:= Items[Index];
  if Assigned(VQuery) then
  begin
    VQuery.Destroy;
    inherited Delete(Index);
    if FItem>=Index then
      Dec(FItem);
    if FItem<0 then FItem:= Count-1;
  end;
end;

procedure TVQLibrary.Clear;
var
  I: Integer;
  VQuery: TVisualQuery;
begin
  for I:= 0 to Count-1 do
  begin
    VQuery:= Items[I];
    VQuery.Free;
  end;
  inherited Clear;
end;

procedure TVQLibrary.MoveBy(Index: Integer);
begin
  Inc(FItem,Index);
  if FItem < 0 then FItem:= 0
  else if FItem > Count-1 then FItem:= Count-1;
end;

procedure TVQLibrary.Prior;
begin
  MoveBy(-1);
end;

procedure TVQLibrary.Next;
begin
  MoveBy(1);
end;

procedure TVQLibrary.First;
begin
  MoveBy(-FItem);
end;

procedure TVQLibrary.Last;
begin
  MoveBy(Count-1-FItem);
end;

constructor TVQLibrary.Create;
begin
  inherited;
  FItem:= -1;
  inherited Add(nil);
end;

destructor TVQLibrary.Destroy;
begin
  Clear;
  inherited;
end;

procedure TVASUPQuery.SetEmbeddedSQL;
begin
  FEmbSQLSlice.Assign(Value);
end;

procedure TVASUPQuery.SetDisplayRowCount(AValue: Integer);
begin
  if AValue<>FDisplayRowCount then
    if AValue>=1 then
      FDisplayRowCount:= AValue
    else FDisplayRowCount:= 1;
end;

function TVASUPQuery.GetChainWeight: Integer;
var
  I: Integer;
begin
  Result:= FLib[FLib.ItemIndex].Count;
  for I:= 0 to FLinkedDetails.Count-1 do
    Inc(Result,TVASUPQuery(FLinkedDetails[I]).ChainWeight);
end;

procedure TVASUPQuery.OpenViSession;
var
  PreWStyle : TWStyle;
begin
  try
    FIsQuery:= true;
    PreWStyle := FWStyle;
    FWStyle:= wsQuery;
    if State<>dsInsert then Insert;
    ClearScreen;
    FBOQ:= IndexQuery<0;
  finally
    CheckWorkState;
    if PreWStyle <> FWStyle then
      AfterChangeWorkState;
  end;
end;

procedure TVASUPQuery.CloseViSession;
var
  PreWStyle : TWStyle;
begin
  try
    if FLib.Count>1 then
      FLib.ItemIndex:= FLib.Count-2;
    FIsQuery:= false;
    PreWStyle := FWStyle;
    if not Active then
      FWStyle:= wsNone
    else
      FWStyle:= wsView;
    CancelScreen;
    Cancel;//New !!!!Пока отменен // SuperNew Уже отменен
  finally
    CheckWorkState;
    if PreWStyle <> FWStyle then
      AfterChangeWorkState;
  end;
end;

procedure TVASUPQuery.ClearDependents;
var
  I: Integer;
  DetailSet: TVASUPQuery;
begin
  for I:= 0 to Owner.ComponentCount-1 do
    if  Owner.Components[I] is TVASUPQuery then
    begin
      DetailSet:= Owner.Components[I] as TVASUPQuery;
      if (DetailSet.Master= Self)
         and DetailSet.IsQuery then
      begin
        if DetailSet.LinkDetailSQL then
         DetailSet.ClearDependents;
        DetailSet.ClearScreen;
      end;
    end;
end;

function TVASUPQuery.GetIndexQRY;
begin
  Result:= FLinkedQueries.ItemIndex;
end;

procedure TVASUPQuery.SetDefaultSQL;
var
  TableName: string;
  p: Integer;
begin
  if Length(Value)>0 then
  begin
    FBrockenSQL.SetScriptForKey(UpperCase(Value));
    FBrockenSQL.DeleteAreaForKey(ORDER_BY);
  end
  else
  begin
    TableName:= UpdatingTable;
    p := pos('.', TableName);
    if p > 0 then
    TableName  := AnsiUpperCase(Copy(TableName, p + 1, Length(TableName) - p));
    FBrockenSQL.SetScriptForKey(Format('SELECT %0:s.*,%0:s.ROWID FROM %s %0:s /* END_REFRESH */',
                                [FUpdTabAlias,TableName]));
  end;

  DeleteMissions;
  if not (csDesigning in ComponentState) then
    SQL.Text:= DefaultSQL;
end;

function TVASUPQuery.GetDefaultSQL : String;
var
  SQLCode : TStrings;
begin
  SQLCode := TStringList.Create;
  FBrockenSQL.CompileForKey(SQLCode);
  Result := SQLCode.Text;
  SQLCode.Destroy;
end;

procedure TVASUPQuery.SetUserFiltered(AValue : boolean);
begin
  if (not ((csDesigning in ComponentState) or (csLoading in ComponentState)))
       and (FUserFiltered <> AValue) then
  begin
    if AValue then
    begin
      if (not FUserSQLQuery.IsEmpty) and  FUserCurrFiltered then
        AddMission(FUserSQLQuery, USER_QUERY);
    end
    else
      DeleteMission(USER_QUERY);
  end;

  FUserFiltered := AValue;
end;

procedure TVASUPQuery.SetUserCurrFiltered(AValue : boolean);
begin
  if (not ((csDesigning in ComponentState) or (csLoading in ComponentState)))
       and (FUserCurrFiltered <> AValue) then
  begin
    if AValue then
    begin
      if (not FUserSQLQuery.IsEmpty) and (FUserFiltered) then
        AddMission(FUserSQLQuery, USER_QUERY);
    end
    else
      DeleteMission(USER_QUERY);
  end;

  FUserCurrFiltered := AValue;
end;

function TVASUPQuery.GetEOQ:bool;
begin
  Result:= FEOQ and (IndexQuery>= FLinkedQueries.Count-1);
end;

function TVASUPQuery.GetBOQ:bool;
begin
  Result:= FBOQ and (IndexQuery<=0);
end;

function TVASUPQuery.SQLText(CondSpot: TCondSpot;Status: TQueryStatus): string;
begin
  Result:= '';
  if Assigned(FLib[FLib.ItemIndex]) then
    Result:= iSQLText(FLib[FLib.ItemIndex],CondSpot,Status);
end;

procedure TVASUPQuery.FillNewVariable(const VarName: string;AField: TField);
var
  OraType: Integer;
begin
  case AField.DataType of
    ftString: OraType:= otString;
    ftDateTime: OraType:= otDate;
    ftFloat: OraType:= otFloat;
    else OraType:= otInteger
  end;
  DeclareVariable(VarName,OraType);
  SetVariable(VarName,AField.Value);
end;

function TVASUPQuery.iSQLText( VisualQuery: TVisualQuery;
                              CondSpot: TCondSpot;
                              Status: TQueryStatus):string;
var
  I: Integer;
  iField: TField;
  TmpVar: string;

function OraDate(DateStr: string):string;
begin
  Result:= Format('TO_DATE(%S,%S)',[ InBrack(DateStr)
                                     ,InBrack(LongDateFmtLine)]);
end;

function RegisterNewVariable(const VarMask: string):string;
var
  OraType: Integer;
begin
  case iField.DataType of
    ftString: OraType:= otString;
    ftDateTime: OraType:= otDate;
    ftFloat: OraType:= otFloat;
    else OraType:= otInteger
  end;
  Result:= TempVarHeader+UpperCase(Self.Name)+VarMask;
  DeclareVariable(Result,OraType);
end;

const
  PointTmp= '%s%s)';

function GenerateMultiSQL: String;
var
  J,K: Integer;
  Template,NewVar: string;
  DetailSet: TVASUPQuery;
  Val1,Val2,Val0: Integer;
begin
  Result:= '';
  if EmbeddedSQLSlice.Count=0 then
    case LinkKind of
      lkExists:
        Template:= Format( 'EXISTS (SELECT 1 FROM %S WHERE %s AND %S=%S AND %S) ',
                           [ UpdatingTable,
                             SQLConcat( Self,DetailFields,
                                        MasterFields,
                                        (Master as TVASUPQuery)),
                             OriginFieldName(iField),'%S','%S']);
      lkIn:
        Template:= Format( '(%s) IN (SELECT %s FROM %S %S WHERE %S=%S AND %S) ',
                           [ SQLConcat2((Master as TVASUPQuery),MasterFields),
                             SQLConcat2(Self,DetailFields),
                             UpdatingTable,UpdTabAlias,
                             OriginFieldName(iField),'%S','%S'])
    end
    else
      case LinkKind of
        lkExists:
          Template:= Format( 'EXISTS (SELECT 1 %S AND %s AND %S=%S AND %S) ',
                           [ EmbeddedSQLSlice.Text,
                             SQLConcat( Self,DetailFields,
                                        MasterFields,
                                        (Master as TVASUPQuery)),
                             OriginFieldName(iField),'%S','%S']);
        lkIn: Template:= Format( '(%s) IN (SELECT %s %S AND %S=%S AND %S) ',
                           [ SQLConcat2((Master as TVASUPQuery),MasterFields),
                             SQLConcat2(Self,DetailFields),
                             EmbeddedSQLSlice.Text,
                             OriginFieldName(iField),'%S','%S'])
      end;
   with VisualQuery[I].ResEnumList do
     for J:= 0 to Count-1 do
       with TVDataContainer(Objects[J]) do
       case State of
        csPoint:
        begin
          NewVar:= RegisterNewVariable(Format('%d_%d',[I,J]));
          SetVariable(NewVar,Point);
          if Length(Result)=0 then Result:= Format(Template,[NewVar,'%S'])
          else Result:= Format(Result,[Format(Template,[NewVar,'%S'])]);
        end;
        csInterval:
        begin
          Val1:= StartInt;
          Val2:= FinishInt;
          if Val1>Val2 then
          begin
            Val0:= Val1;
            Val1:= Val2;
            Val2:= Val0;
          end;
          for K:= Val1 to Val2 do
          begin
            NewVar:= RegisterNewVariable(Format('%d_%d_%d',[I,J,K]));
            SetVariable(NewVar,K);
            if Length(Result)=0 then Result:= Format(Template,[NewVar,'%S'])
            else Result:= Format(Result,[Format(Template,[NewVar,'%S'])]);
          end;
        end;
       end;
   Result:= Format(Result,['0=0']);
end;

function GetIntoCodeWithVariables:string;
var
  J: Integer;
  NewVar,NewVar1: string;
  PntLine: string;
  ApUnion: string;
begin
  PntLine:= PointTmp;
  Result:= '';
  ApUnion:= '';
  with VisualQuery[I].ResEnumList do
    if (Union= unOR) or (Status=qsExecution) then
    begin
      for J:= 0 to Count-1 do
        with TVDataContainer(Objects[J]) do
        begin
          case State of
            csPoint:
            begin
              NewVar:= RegisterNewVariable(Format('%d_%d',[I,J]));
              SetVariable(NewVar,Point);
              Result:= Format('%s %s %s=%s',
                [Result,ApUnion,OriginFieldName(iField),NewVar]);
              ApUnion:= OR_SQL;
            end;
            csInterval:
            if VarType(FinishInt)=varNull then
            begin
              NewVar:= RegisterNewVariable(Format('%d_%d',[I,J]));
              SetVariable(NewVar,StartInt);
              Result:= Format('%s %s (%s %s %s)',
                [Result,ApUnion,OriginFieldName(iField),NOTLESS_sql,NewVar]);
              ApUnion:= OR_SQL;
            end
            else if VarType(StartInt)=varNull then
            begin
              NewVar:= RegisterNewVariable(Format('%d_%d',[I,J]));
              SetVariable(NewVar,FinishInt);
              Result:= Format('%s %s (%s %s %s)',
                [Result,ApUnion,OriginFieldName(iField),NOTMORE_sql,NewVar]);
              ApUnion:= OR_SQL;
            end
            else
            begin
              NewVar:= RegisterNewVariable(Format('%d_%d_S',[I,J]));
              SetVariable(NewVar,StartInt);
              NewVar1:= RegisterNewVariable(Format('%d_%d_F',[I,J]));
              SetVariable(NewVar1,FinishInt);
              Result:= Format('%s %s (%s %s %s %s %s)',
                [Result,ApUnion,OriginFieldName(iField),BETWEEN_sql,NewVar
                 ,AND_sql,NewVar1]);
              ApUnion:= OR_SQL;
            end;
          end;
        end;
        if Length(Result)>0 then
          Result:= Format('(%s)',[Result]);
      end
      else Result:= GenerateMultiSQL;
  if Length(Result)>0 then
    Result:= Concat(' ',Result);
end;

begin
  Result:= '';
    for I:= 0 to VisualQuery.Count-1 do
    with  VisualQuery[I] do
    begin
      if (Length(Result)>0) and (Expr<>piVariable) then
         Result:= Concat(Result,' AND ');
      if (ResType= rtFilter) and (CondSpot= csWhere) then
         Result:= Concat(Result, Value)
      else if (ResType<> rtFilter) then
      begin
        iField:= FieldByName(FieldName);
        if ( (CondSpot= csWhere) and
             (iField.Tag and GROUPFUNC_FIELDTAG <>GROUPFUNC_FIELDTAG)
             )
           or ( (CondSpot= csHaving) and
                (iField.Tag and GROUPFUNC_FIELDTAG=GROUPFUNC_FIELDTAG)
           ) then
          if Length(Value)>0 then
          begin
            if not (Expr in [piInto,piUserDefined,piVariable,piTempVariable]) then
            begin
              TmpVar:= RegisterNewVariable(IntToStr(I));
              if (Expr in [piLike,piNotLike])
                  and not (iField is TDateTimeField) then
              begin
                if iField is TNumericField then
                begin
                  DeleteVariable(TmpVar);
                  DeclareVariable(TmpVar,otString);
                end;
                SetVariable(TmpVar,Value+'%')
              end
              else SetVariable(TmpVar,Value)
            end;
            if Expr= piInto then
              Result:= Concat( Result,GetIntoCodeWithVariables)
            else
            begin
              if iField is TDateTimeField then
              begin
                if Expr=piNone then Expr:= piEqual;
                case Expr of
                  //piInto: Result:= Format('%s (%s)',[Result,Value]);
                  piLike: Result:= Concat( Result,Format('trunc(%s)',[OriginFieldName(iField)]),
                                        StatePUMenuToStr(piEqual),TmpVar);
                  piNotLike: Result:= Concat( Result,Format('trunc(%s)',[OriginFieldName(iField)]),
                                        StatePUMenuToStr(piNotEqual),TmpVar);
                  piUserDefined: Result:= Concat(Result,ResString );
                  piVariable: SetVariable(ResString,Value);
                  piTempVariable:
                  begin
                    TmpVar:= RegisterTempVariable(iField,0,Value);
                    Result:= Concat(Result,Format(ResString,[TmpVar]));
                  end
                  else Result:= Concat( Result,Format('%s',[OriginFieldName(iField)]),
                                        StatePUMenuToStr(Expr),TmpVar);
                end
              end
              else case Expr of
                piNone,piLike:
                  Result:= Concat( Result,OriginFieldName(iField),
                                   ' LIKE ',TmpVar);
                piNotLike:Result:= Concat(Result,OriginFieldName(iField),' NOT LIKE ',TmpVar );
                piUserDefined: Result:= Concat(Result,ResString);
                piVariable: SetVariable(ResString,Value);
                piTempVariable:
                begin
                  TmpVar:= RegisterTempVariable(iField,0,Value);
                  Result:= Concat(Result,Format(ResString,[TmpVar]));
                end
                else Result:= Concat( Result,OriginFieldName(iField),
                                        StatePUMenuToStr(Expr),TmpVar)
              end
            end;
          end
          else case Expr of
            piNotEqual: Result:= Concat(Result,OriginFieldName(iField),' IS NOT NULL ');
            piEqual: Result:= Concat(Result,OriginFieldName(iField),' IS NULL ');
          end;
            {if iField is TDateTimeField then
            begin
              if Expr=piNone then Expr:= piEqual;
              case Expr of
                piInto: Result:= Format('%s (%s)',[Result,Value]);
                piLike: Result:= Concat( Result,Format('trunc(%s)',[OriginFieldName(iField)]),
                                      StatePUMenuToStr(piEqual),OraDate(Value));
                piVariable: SetVariable(ResString,Value);
                piNotLike: Result:= Concat( Result,Format('trunc(%s)',[OriginFieldName(iField)]),
                                      StatePUMenuToStr(piNotEqual),OraDate(Value));
                else Result:= Concat( Result,Format('%s',[OriginFieldName(iField)]),
                                      StatePUMenuToStr(Expr),OraDate(Value));
              end
            end
            else case Expr of
              piNone,piLike:
                Result:= Concat( Result,OriginFieldName(iField),
                                 ' LIKE ',InBrack(Concat(Value,'%')));
              piNotLike:Result:= Concat(Result,OriginFieldName(iField),' NOT LIKE ',InBrack(Concat(Value,'%')) );
              piUserDefined: Result:= Concat(Result,ResString );
              piVariable: SetVariable(ResString,Value);
              piInto: Result:= Format('%s (%s)',[Result,Value])
              else if iField is TStringField then
                Result:= Concat( Result,OriginFieldName(iField),
                                 StatePUMenuToStr(Expr),InBrack(Value))
                else Result:= Concat( Result,OriginFieldName(iField),
                                      StatePUMenuToStr(Expr),Value)
            end
          end
          else case Expr of
            piNotEqual: Result:= Concat(Result,OriginFieldName(iField),' IS NOT NULL ');
            piEqual: Result:= Concat(Result,OriginFieldName(iField),' IS NULL ');
          end;
          }
      end;
    end
end;

procedure TVASUPQuery.getUserSQLQuery(  VisualQuery: TVisualQuery;
                        CondSpot: TCondSpot;Status:TQueryStatus;
                        AUserQuery : TPartSQLCode);
var
  I: Integer;
  iField: TField;
  TmpVar: string;
  TmpVarType : Integer;
  StrResult : String;

function OraDate(DateStr: string):string;
begin
  Result:= Format('TO_DATE(%S,%S)',[ InBrack(DateStr)
                                     ,InBrack(LongDateFmtLine)]);
end;

function RegisterNewVariable(const VarMask: string; var VarType : Integer):string;
begin
  case iField.DataType of
    ftString: VarType:= otString;
    ftDateTime: VarType:= otDate;
    ftFloat: VarType:= otFloat;
    else VarType:= otInteger
  end;
  Result:= TempVarHeader+UpperCase(Self.Name)+VarMask;
end;

const
  PointTmp= '%s%s)';

function GenerateMultiSQL(APSQL : TPartSQLCode) : String;
var
  J,K: Integer;
  Template,NewVar: string;
  Val1,Val2,Val0: Integer;
  VarType : Integer;
begin
  Result := '';
  if EmbeddedSQLSlice.Count=0 then
    case LinkKind of
      lkExists:
        Template:= Format( 'EXISTS (SELECT 1 FROM %S WHERE %s AND %S=%S AND %S) ',
                           [ UpdatingTable,
                             SQLConcat( Self,DetailFields,
                                        MasterFields,
                                        (Master as TVASUPQuery)),
                             OriginFieldName(iField),'%S','%S']);
      lkIn:
        Template:= Format( '(%s) IN (SELECT %s FROM %S %S WHERE %S=%S AND %S) ',
                           [ SQLConcat2((Master as TVASUPQuery),MasterFields),
                             SQLConcat2(Self,DetailFields),
                             UpdatingTable,UpdTabAlias,
                             OriginFieldName(iField),'%S','%S'])
    end
    else
      case LinkKind of
        lkExists:
          Template:= Format( 'EXISTS (SELECT 1 %S AND %s AND %S=%S AND %S) ',
                           [ EmbeddedSQLSlice.Text,
                             SQLConcat( Self,DetailFields,
                                        MasterFields,
                                        (Master as TVASUPQuery)),
                             OriginFieldName(iField),'%S','%S']);
        lkIn: Template:= Format( '(%s) IN (SELECT %s %S AND %S=%S AND %S) ',
                           [ SQLConcat2((Master as TVASUPQuery),MasterFields),
                             SQLConcat2(Self,DetailFields),
                             EmbeddedSQLSlice.Text,
                             OriginFieldName(iField),'%S','%S'])
      end;
   with VisualQuery[I].ResEnumList do
     for J:= 0 to Count-1 do
       with TVDataContainer(Objects[J]) do
       case State of
        csPoint:
        begin
          NewVar:= RegisterNewVariable(Format('%d_%d',[I,J]), VarType);
          APSQL.AddVariable(NewVar, Point, VarType);
          if Length(Result)=0 then Result:= Format(Template,[NewVar,'%S'])
          else Result:= Format(Result,[Format(Template,[NewVar,'%S'])]);
        end;
        csInterval:
        begin
          Val1:= StartInt;
          Val2:= FinishInt;
          if Val1>Val2 then
          begin
            Val0:= Val1;
            Val1:= Val2;
            Val2:= Val0;
          end;
          for K:= Val1 to Val2 do
          begin
            NewVar:= RegisterNewVariable(Format('%d_%d_%d',[I,J,K]), VarType);
            APSQL.AddVariable(NewVar, K, VarType);
            if Length(Result)=0 then Result:= Format(Template,[NewVar,'%S'])
            else Result:= Format(Result,[Format(Template,[NewVar,'%S'])]);
          end;
        end;
       end;
   Result := Format(Result,['0=0']);
end;

function GetIntoCodeWithVariables(APSQL : TPartSQLCode) : String;
var
  J: Integer;
  NewVar,NewVar1: string;
  PntLine: string;
  ApUnion: string;
  VarType_ : Integer;
  VarType1_ : Integer;
begin
  PntLine:= PointTmp;
  ApUnion:= '';
  Result := '';
  with VisualQuery[I].ResEnumList do
    if (Union= unOR) or (Status=qsExecution) then
    begin
      for J:= 0 to Count-1 do
        with TVDataContainer(Objects[J]) do
        begin
          case State of
            csPoint:
            begin
              NewVar:= RegisterNewVariable(Format('%d_%d',[I,J]), VarType_);
              APSQL.AddVariable(NewVar, Point, VarType_);
              Result:= Format('%s %s %s=%s',
                [Result,ApUnion,OriginFieldName(iField),NewVar]);
              ApUnion:= OR_SQL;
            end;
            csInterval:
            if VarType(FinishInt)=varNull then
            begin
              NewVar:= RegisterNewVariable(Format('%d_%d',[I,J]), VarType_);
              APSQL.AddVariable(NewVar, StartInt, VarType_);
              Result:= Format('%s %s (%s %s %s)',
                [Result,ApUnion,OriginFieldName(iField),NOTLESS_sql,NewVar]);
              ApUnion:= OR_SQL;
            end
            else if VarType(StartInt)=varNull then
            begin
              NewVar:= RegisterNewVariable(Format('%d_%d',[I,J]), VarType_);
              APSQL.AddVariable(NewVar, FinishInt, VarType_);
              Result:= Format('%s %s (%s %s %s)',
                [Result,ApUnion,OriginFieldName(iField),NOTMORE_sql,NewVar]);
              ApUnion:= OR_SQL;
            end
            else
            begin
              NewVar:= RegisterNewVariable(Format('%d_%d_S',[I,J]), VarType_);
              APSQL.AddVariable(NewVar, StartInt, VarType_);
              NewVar1:= RegisterNewVariable(Format('%d_%d_F',[I,J]), VarType1_);
              APSQL.AddVariable(NewVar1, FinishInt, VarType1_);
              Result:= Format('%s %s (%s %s %s %s %s)',
                [Result,ApUnion,OriginFieldName(iField),BETWEEN_sql,NewVar
                 ,AND_sql,NewVar1]);
              ApUnion:= OR_SQL;
            end;
          end;
        end;
      if Length(Result)>0 then
        Result := Format('(%s)',[Result]);
    end
    else Result := GenerateMultiSQL(APSQL);
  if Length(Result)>0 then
    Result:= Concat(' ',Result);
end;

begin
  StrResult := '';
    for I:= 0 to VisualQuery.Count-1 do
    with  VisualQuery[I] do
    begin
      if (Length(StrResult)>0) and (Expr<>piVariable) then
         StrResult := Concat(StrResult, ' AND ');
      if (ResType= rtFilter) and (CondSpot= csWhere) then
         StrResult:= Concat(StrResult, Value)
      else if (ResType<> rtFilter) then
      begin
        iField:= FieldByName(FieldName);
        if ( (CondSpot= csWhere) and
             (iField.Tag and GROUPFUNC_FIELDTAG <>GROUPFUNC_FIELDTAG)
             )
           or ( (CondSpot= csHaving) and
                (iField.Tag and GROUPFUNC_FIELDTAG=GROUPFUNC_FIELDTAG)
           ) then
          if Length(Value)>0 then
          begin
            if not (Expr in [piInto,piUserDefined,piVariable,piTempVariable]) then
            begin
              TmpVar:= RegisterNewVariable(IntToStr(I), TmpVarType);
              if (Expr in [piLike,piNotLike])
                  and not (iField is TDateTimeField) then
              begin
                if iField is TNumericField then
                  TmpVarType := otString;
                AUserQuery.AddVariable(TmpVar, Value+'%', TmpVarType);
              end
              else
                AUserQuery.AddVariable(TmpVar, Value, TmpVarType);
            end;
            if Expr= piInto then
              StrResult:= Concat(StrResult,GetIntoCodeWithVariables(AUserQuery))
            else
            begin
              if iField is TDateTimeField then
              begin
                if Expr=piNone then Expr:= piEqual;
                case Expr of
                  piLike: StrResult:= Concat(StrResult,Format('trunc(%s)',
                                        [OriginFieldName(iField)]),
                                        StatePUMenuToStr(piEqual),TmpVar);
                  piNotLike: StrResult:= Concat(StrResult,Format('trunc(%s)',
                                        [OriginFieldName(iField)]),
                                        StatePUMenuToStr(piNotEqual),TmpVar);
                  piUserDefined: StrResult:= Concat(StrResult,ResString );
                  piVariable: SetVariable(ResString,Value);
                  piTempVariable:
                  begin
                    TmpVar:= RegisterTempVariable(iField, TmpVarType);
                    FUserSQLQuery.AddVariable(TmpVar, Value, TmpVarType);

                    StrResult:= Concat(StrResult, Format(ResString,[TmpVar]));
                  end
                  else StrResult:= Concat(StrResult, Format('%s',[OriginFieldName(iField)]),
                                        StatePUMenuToStr(Expr),TmpVar);
                end
              end
              else case Expr of
                piNone,piLike:
                  StrResult:= Concat(StrResult,OriginFieldName(iField),
                                   ' LIKE ',TmpVar);
                piNotLike:StrResult:= Concat(StrResult,OriginFieldName(iField),' NOT LIKE ',TmpVar );
                piUserDefined: StrResult:= Concat(StrResult,ResString);
                piVariable: SetVariable(ResString,Value);
                piTempVariable:
                begin
                  TmpVar:= RegisterTempVariable(iField, TmpVarType);
                  FUserSQLQuery.AddVariable(TmpVar, Value, TmpVarType);

                  StrResult:= Concat(StrResult, Format(ResString,[TmpVar]));
                end
                else StrResult:= Concat(StrResult,OriginFieldName(iField),
                                        StatePUMenuToStr(Expr),TmpVar)
              end
            end;
          end
          else case Expr of
            piNotEqual: StrResult:= Concat(StrResult,OriginFieldName(iField),' IS NOT NULL ');
            piEqual: StrResult:= Concat(StrResult,OriginFieldName(iField),' IS NULL ');
          end;
      end;
    end;
  case CondSpot of
    csWhere  : AUserQuery.PartSQLCode[WHERE] := strResult;
    csHaving : AUserQuery.PartSQLCode[HAVING] := strResult;
  end;
end;

procedure TVASUPQuery.SaveUserSQLQuery(CondSpot: TCondSpot;Status:TQueryStatus);
var
  keyWord : TSQLKeyWord;
  Variables : TStrings;
  I : Integer;
begin
  keyWord := NONE;
  case CondSpot of
    csWhere  : keyWord := WHERE;
    csHaving : keyWord := HAVING;
  end;
  if FUserSQLQuery.PartSQLCode[keyWord] <> '' then
  begin
    Variables := TStringList.Create;
    FUserSQLQuery.GetVariablesInSQLCode(Variables, keyWord);
    FUserSQLQuery.PartSQLCode[keyWord] := '';
    for I := 0 to Variables.Count - 1 do
      if not FUserSQLQuery.ExistVariable(Variables[I]) then
        FUserSQLQuery.RemoveVariable(Variables[I]);
    Variables.Destroy;
  end;

  if Assigned(FLib[FLib.ItemIndex]) then
    getUserSQLQuery(FLib[FLib.ItemIndex],CondSpot,Status,FUserSQLQuery);

end;

procedure TVASUPQuery.SaveDetailUserSQLQuery;
var
  DetailList : TObjectList;
  I : Integer;
  LinkedNode: TLinkedQueryNode;
begin
  FIsLinked:= false;    // Зачем-то нужно
  FLinkedDetails.Clear; // Зачем-то нужно

  DetailList := TObjectList.Create(false);
  GetDetailDataSets(DetailList);
  for I := 0 to DetailList.Count - 1 do
    if (DetailList[I] is TVASUPQuery) and (TVASUPQuery(DetailList[I]).IsQuery) then
      with DetailList[I] as TVASUPQuery  do
      begin
        SaveViQuery;
        SaveUserSQLQuery(csWhere,qsIdle);
        LinkedNode.Obj := TVASUPQuery(DetailList[I]);

        if LinkDetailSQL then
        begin
          SaveDetailUserSQLQuery;
          with LinkedQueryList do
            LinkedNode.Index:= Nodes[Count-1].SelfIndex;
        end
        else LinkedNode.Index:= QueryLibrary.ItemIndex;

        Self.FIsLinked:= true;
        Self.FLinkedDetails.Add(DetailList[I]);
        CloseViSession;
        Close;

        if IsUserQuery then
          Self.LinkedQueryList.Nodes[Self.IndexQuery].Add(LinkedNode);
      end;


  LinkedQueryList.Pack;

  DetailList.Destroy;
end;

function TVASUPQuery.IsUserQuery : boolean;
begin
  Result := FUserSQLQuery.PartSQLCode[WHERE] <> '';
end;

procedure TVASUPQuery.GetFullUserSQLOfDetail(AUserQuery : TPartSQLCode);
var
  DetailList : TObjectList;
  I : Integer;
  DetailSQLCode : TPartSQLCode;

procedure CorrecNameVars(ASQLCode : TPartSQLCode);
var
  DetailVars : TStrings;
  nameVar : String;
  temp : String;
  n : Integer;
  I : Integer;
begin
  DetailVars := TStringList.Create;
  ASQLCode.GetVariables(DetailVars);

  for I := 0 to DetailVars.Count - 1 do
    if AUserQuery.ExistVariable(DetailVars[I]) then
    begin
      // У переменной DetailVars[I] меняем имя
      temp := DetailVars[I] + '_';
      n := 0;
      nameVar := temp + IntToStr(n);
      while ASQLCode.ExistVariable(nameVar) or
            AUserQuery.ExistVariable(nameVar) do
      begin
        Inc(n);
        nameVar := temp + IntToStr(n);
      end;
      ASQLCode.ChangeVariable(DetailVars[I], nameVar);
    end;

  DetailVars.Destroy;
end;

begin
  DetailList := TObjectList.Create(false);
  GetDetailDataSets(DetailList);
  DetailSQLCode := TPartSQLCode.Create;

  for I := 0 to DetailList.Count - 1 do
    if (DetailList[I] is TVASUPQuery) then
    begin
      DetailSQLCode.Clear;
      TVASUPQuery(DetailList[I]).GetFullUserSQLOfDetail(DetailSQLCode);
      if not DetailSQLCode.IsEmpty then
      begin
        // Проверяем, не было ли DetailSQLCode и AUserQuery
        // одинаковых SQL переменных, если будут,
        // то в DetailSQLCode изменим имена переменных так,
        // чтобы не было одинаковых переменных
        CorrecNameVars(DetailSQLCode);

        // Объежиняем AUserQuery и DetailSQLCode
        AUserQuery.Add(DetailSQLCode);
      end;
    end;
  DetailSQLCode.Destroy;
  DetailList.Destroy;

  GetUserSQLOfDetail(AUserQuery, true);
end;

procedure TVASUPQuery.GetUserSQLOfDetail(AUserQuery : TPartSQLCode; AFull : boolean);
var
  PartSQLCode : TPartSQLCode;
  I, J : Integer;
  LKey : String;
  k : TSQLKeyWord;
  SQLCode : String;
  Vars : TSQLVariables;
  f : boolean;
procedure CorrecNameVars(ASQLCode : TPartSQLCode);
var
  DetailVars : TStrings;
  nameVar : String;
  temp : String;
  n : Integer;
  I : Integer;
begin
  DetailVars := TStringList.Create;
  ASQLCode.GetVariables(DetailVars);

  for I := 0 to DetailVars.Count - 1 do
    if AUserQuery.ExistVariable(DetailVars[I]) then
    begin
      // У переменной DetailVars[I] меняем имя
      temp := DetailVars[I] + '_';
      n := 0;
      nameVar := temp + IntToStr(n);
      while ASQLCode.ExistVariable(nameVar) or
            AUserQuery.ExistVariable(nameVar) do
      begin
        Inc(n);
        nameVar := temp + IntToStr(n);
      end;
      ASQLCode.ChangeVariable(DetailVars[I], nameVar);
    end;

  DetailVars.Destroy;
end;

begin
  PartSQLCode := TPartSQLCode.Create;
  if (not FUserSQLQuery.IsEmpty) and (AFull or UserFiltered) then
  begin
    // клонируем запрос
    PartSQLCode.Assign(FUserSQLQuery);

    // Проверяем, не было ли PartSQLCode и AUserQuery
    // одинаковых SQL переменных
    CorrecNameVars(PartSQLCode);

    // Объединяем AUserQuery и PartSQLCode
    AUserQuery.Add(PartSQLCode);
  end;
  if not FUserSQLFilter.IsEmpty then
  begin
    PartSQLCode.Clear;
    // клонируем фильтр
    PartSQLCode.Assign(FUserSQLFilter);

    // Проверяем, не было ли PartSQLCode и AUserQuery
    // одинаковых SQL переменных
    CorrecNameVars(PartSQLCode);

    // Объединяем AUserQuery и PartSQLCode
    AUserQuery.Add(PartSQLCode);
  end;

  f := false;
  for I := 0 to FKeysOfFilters.Count - 1 do
  begin
    LKey := FKeysOfFilters[I];

    if EnabledFilterWithKey[LKey] then
    begin
      PartSQLCode.Clear;
      if f then
        PartSQLCode.PartSQLCode[WHERE] := ' AND ' + FBrockenSQL.getAreaForKey(WHERE, LKey)
      else
        PartSQLCode.PartSQLCode[WHERE] := FBrockenSQL.getAreaForKey(WHERE, LKey);

      f := true;

      vars := GetVariables(LKey);
      if Assigned(vars) then
        for J := 0 to vars.Count - 1 do
          PartSQLCode.AddVariable(Vars[J]);

      // Проверяем, не было ли PartSQLCode и AUserQuery
      // одинаковых SQL переменных
      CorrecNameVars(PartSQLCode);

      // Объединяем AUserQuery и PartSQLCode
      AUserQuery.Add(PartSQLCode);
    end;

  end;




  if AUserQuery.PartSQLCode[WHERE] <> '' then
    AUserQuery.PartSQLCode[WHERE] := getUserSQLQueryForMaster(AUserQuery.PartSQLCode[WHERE]);

  PartSQLCode.Destroy;
end;

procedure TVASUPQuery.BuildFullUserSQLQuery;
var
  DetailList : TObjectList;
  I : Integer;
  DetailSQLCode : TPartSQLCode;
begin
  DetailList := TObjectList.Create(false);
  GetDetailDataSets(DetailList);
  DetailSQLCode := TPartSQLCode.Create;

  for I := 0 to DetailList.Count - 1 do
    if (DetailList[I] is TVASUPQuery) then
    begin
      DetailSQLCode.Clear;
      TVASUPQuery(DetailList[I]).GetFullUserSQLOfDetail(DetailSQLCode);

      if not DetailSQLCode.IsEmpty then
      begin
        AddMission(DetailSQLCode, GetNameMissionDetailQuery(TDataSet(DetailList[I])));
      end;
    end;

  if not FUserSQLQuery.IsEmpty then
    begin
      AddMission(FUserSQLQuery, USER_QUERY);
    end;

  DetailSQLCode.Destroy;
  DetailList.Destroy;
end;

procedure TVASUPQuery.BuildUserSQLQuery(AUserQuery : TPartSQLCode = Nil);
var
  DetailList : TObjectList;
  I : Integer;
  PartSQLCode : TPartSQLCode;
  DetailSQLCode : TPartSQLCode;

procedure CorrecNameVars(ASQLCode : TPartSQLCode);
var
  DetailVars : TStrings;
  nameVar : String;
  temp : String;
  n : Integer;
  I : Integer;
begin
  DetailVars := TStringList.Create;
  ASQLCode.GetVariables(DetailVars);


  for I := 0 to DetailVars.Count - 1 do
    if PartSQLCode.ExistVariable(DetailVars[I]) then
    begin
      // У переменной DetailVars[I] меняем имя
      temp := DetailVars[I] + '_';
      n := 0;
      nameVar := temp + IntToStr(n);
      while ASQLCode.ExistVariable(nameVar) or
            PartSQLCode.ExistVariable(nameVar) do
      begin
        Inc(n);
        nameVar := temp + IntToStr(n);
      end;
      ASQLCode.ChangeVariable(DetailVars[I], nameVar);
    end;

  DetailVars.Destroy;
end;

begin
  DetailList := TObjectList.Create(false);
  GetDetailDataSets(DetailList);
  PartSQLCode := TPartSQLCode.Create;
  DetailSQLCode := TPartSQLCode.Create;

  if Assigned(AUserQuery) then
    PartSQLCode.Assign(AUserQuery);

  for I := 0 to DetailList.Count - 1 do
    if (DetailList[I] is TVASUPQuery) then
    begin
      DetailSQLCode.Clear;

      TVASUPQuery(DetailList[I]).BuildUserSQLQuery(DetailSQLCode);

      if not DetailSQLCode.IsEmpty then
      begin
        // Вставляем пользовательский запрос DetailSet в SQL код под соответствующим именем
        AddMission(DetailSQLCode, GetNameMissionDetailQuery(TDataSet(DetailList[I])));

        // Проверяем, не было ли DetailSQLCode и PartSQLCode
        // одинаковых SQL переменных
        CorrecNameVars(DetailSQLCode);

        PartSQLCode.Add(DetailSQLCode);
      end;
    end;


  if UserFiltered and (not FUserSQLQuery.IsEmpty) and UserCurrFiltered then
    // Вставляем пользовательский запрос в SQL код
    AddMission(FUserSQLQuery, USER_QUERY);

  GetUserSQLOfDetail(PartSQLCode, false);

  if Assigned(AUserQuery) then
    AUserQuery.Assign(PartSQLCode);

  DetailSQLCode.Destroy;
  PartSQLCode.Destroy;
  DetailList.Destroy;
end;

procedure TVASUPQuery.BuildUserSQLQueryOfDetails;
var
  DetailList : TObjectList;
  I: Integer;
begin
  DetailList := TObjectList.Create(false);
  GetDetailDataSets(DetailList);

  for I := 0 to DetailList.Count - 1 do
    if (DetailList[I] is TVASUPQuery) then
      TVASUPQuery(DetailList[I]).BuildUserSQLQuery;

  DetailList.Destroy;
end;

procedure TVASUPQuery.SetUserFilter(AFilter : string);
begin
  FUserSQLFilter.PartSQLCode[WHERE] := AFilter;
  FBrockenSQL.SetAreaForKey(WHERE, AFilter,  USER_SQL_FILTER);
  RefreshSQL;
end;

procedure TVASUPQuery.DeleteUserFilter;
begin
  FUserSQLFilter.Clear;
  DeleteMission(USER_SQL_FILTER);
  RefreshSQL;
end;

procedure TVASUPQuery.RefrDUserQueryInFinalMaster(Detail : TVASUPQuery);
var
  DetailSQLCode : TPartSQLCode;
begin
  DetailSQLCode := TPartSQLCode.Create;

  TVASUPQuery(Detail).GetFullUserSQLOfDetail(DetailSQLCode);

  if DetailSQLCode.IsEmpty then
    DeleteMission(GetNameMissionDetailQuery(Detail))
  else
    SetMission(DetailSQLCode, GetNameMissionDetailQuery(Detail));

  DetailSQLCode.Destroy;

  RefreshSQL;
end;

procedure TVASUPQuery.RefrDUserQueryInMaster(AUserQuery : TPartSQLCode;
                         Detail : TVASUPQuery; AFinalMaster : TVASUPQuery = nil);
var
  ASQLCode : TPartSQLCode;
begin
  if Assigned(Master) and (Self <> AFinalMaster) and (Master is TVASUPQuery) then
  begin
    if AUserQuery.IsEmpty then
      DeleteMission(GetNameMissionDetailQuery(Detail))
    else
      SetMission(AUserQuery, GetNameMissionDetailQuery(Detail));

    if Master <> AFinalMaster then
    begin
      ASQLCode := TPartSQLCode.Create;
      ASQLCode.Assign(AUserQuery);

      GetUserSQLOfDetail(ASQLCode, false);
      TVASUPQuery(Master).RefrDUserQueryInMaster(ASQLCode, Self, AFinalMaster);

      ASQLCode.Destroy;
    end
    else
      TVASUPQuery(Master).RefrDUserQueryInFinalMaster(Self);
  end
  else
    RefrDUserQueryInFinalMaster(Detail);
end;

procedure TVASUPQuery.RefrUserQuery(AFinalMaster : TVASUPQuery = nil);
var
  ASQLCode : TPartSQLCode;
begin
  if Assigned(Master) and (Self <> AFinalMaster) and (Master is TVASUPQuery) then
  begin
    if Master <> AFinalMaster then
    begin
      ASQLCode := TPartSQLCode.Create;

      GetUserSQLOfDetail(ASQLCode, false);
      TVASUPQuery(Master).RefrDUserQueryInMaster(ASQLCode, Self, AFinalMaster);

      ASQLCode.Destroy;
    end
    else
      TVASUPQuery(Master).RefrDUserQueryInFinalMaster(Self);
  end;
end;

procedure TVASUPQuery.SetOrder;
var
  I: Integer;
begin
  FOrder:= UpperCase(Trim(Value));
  DataEvent(dePropertyChange,0);
  for I:= 0 to FieldCount-1 do
    Fields[I].Tag:= (Fields[I].Tag and not SORT_ASC_FIELDTAG)
    and not SORT_DESC_FIELDTAG;
end;

procedure TVASUPQuery.SetSimpleQRY;
var
  I: Integer;
begin
  if not Assigned(FKeyWords) then
    FKeyWords:= TStringList.Create;
  FKeyWords.Assign(Value);
  for I:= FKeyWords.Count-1 downto 0 do
  begin
    FKeyWords[I]:= Trim(FKeyWords[I]);
    if Length(FKeyWords[I])= 0 then FKeyWords.Delete(I)
    else FKeyWords[I]:= AnsiUpperCase(FKeyWords[I])
  end;
end;

procedure TVASUPQuery.SlowOpen;
var
  WaitList: TStrings;
begin
  if FShieldSh then
  begin
    WaitList:= TStringList.Create;
    try
      with WaitList do
      begin
        Add('Пожалуйста, подождите!');
        if (not ReActive) and not (csDesigning in ComponentState) then
          Add('Идет загрузка атрибутов таблицы '+UpdatingTable+' ...')
        else Add('Идет выполнение запроса ... ');
      end;
      fmTalk:= TfmTalk.CreateWithText(Self,WaitList.Text);
      fmTalk.Show;
      if not Active then Open
      else
      begin
        if State<>dsBrowse then Cancel;
        Refresh;
      end;
      fmTalk.Close;
    finally
      WaitList.Free;
    end;
  end
  else
    if not Active then Open
    else
    begin
      if State<>dsBrowse then Cancel;
      Refresh;
    end;
end;

function TVASUPQuery.ReadValueFromASUPBookmark(APValue : PChar; var APNextValue : PChar; AType : Integer; ASize : Integer) : Variant;
var
  //p : PChar;
  size : Integer;
  I : Integer;
  Str : String;
  OleStr : WideString;
begin
  // Возвращаемое значение не определено
  Result := 1; //!!!
  Result := VarAsType(Result, varEmpty);
  APNextValue := NIL;

  if ASize > 0 then
  begin
    //p := APValue;
    Dec(ASize);
    APValue := APValue + 1;
    size := 0;
    // В первом байте содержтся флажок, равняется значение NULL или нет
    if (Integer(Char((APValue - 1)^)) and BOOKMARK_NULL) = 0 then
    begin
      // значение не равняется NULL

      // Проверяем явл. значение строкой или нет
      if (AType = varString) or (AType = varOleStr) then
      begin
        // значение не явл. строкой

        // Проверяем можем ли прочить длину строки в байтах из Bookmark-а
        if ASize >= SizeOf(Integer) then
        begin
          // Можем прочитать

          // Читаем длину строки в байтах
          size := PInteger(APValue)^;
          Inc(APValue, SizeOf(Integer));

          // Проверяем поместилось ли строка в Bookmark
          if ASize >= size then
          begin
            // строка поместилось в Bookmark

            if AType = varString then
            begin
              // Устанавливае нужную длину возвращаемой строки
              SetLength(str, size);

              // Записываем в возвращаемый аргумент значение строки из Bookmark-а
              for I := 0 to size - 1 do
              begin
                (PChar(str) + I)^ := APValue^;
                Inc(APValue);
              end;

              Result := str;
            end
            else
            begin
              // Устанавливае нужную длину возвращаемой строки
              SetLength(OleStr, size);

              // Записываем в возвращаемый аргумент значение строки из Bookmark-а
              for I := 0 to size - 1 do
              begin
                (PChar(OleStr) + I)^ := APValue^;
                Inc(APValue);
              end;

              Result := OleStr
            end;
          end;
        end;

        ASize := ASize - SizeOf(Integer);
      end
      else
      begin
        // значение не явл. строкой

        // определяем длину в байтах значения
        size := TypeSize(AType);

        if ASize >= size then
        begin
          // значение поместилось в Bookmark


          // Преобразовываем  возвращаемый аргумент в нужный тип данных
          Result := VarAsType(Result, AType);

          // Записываем в возвращаемый аргумент значение из Bookmark-а
          for I := 0 to size - 1 do
          begin
            (PChar(@Result) + I + (SizeOf(Variant) div 2))^ := APValue^;
            Inc(APValue);
          end;

        end;
      end;

    end
    else
      // значение равняется NULL
      // возвращаем значение NULL
      Result := NULL;

    // определяем, записано ли в bookmark-е после этого значения ещё другое значение
    if ASize > size then
      // Да, записано ещё другое значение
      // запоминаем указатель на другое значение в BookMark
      APNextValue := APValue;
  end;
end;


procedure TVASUPQuery.WriteValueFromASUPBookmark(APValue : PChar; AValue : Variant);
var
  PFirstByte : PChar; // Указатель на первый байт занчения в Bookmark
  FirstByte : char;   // Значение первого байта значения для флажков в Bookmark-е
  //P : PChar;
  VType : Integer;
  I : Integer;
  size : Integer;
  PVal : PChar;
begin
  PFirstByte := APValue;
  FirstByte := char(0);
  APValue := APValue;
  if AValue <> NULL then
  begin
    // записываемое значение не равняется NULL

    // Пропускаем первый байт с флажками
    Inc(APValue);

    // Определяем тип записываемого значения
    VType := VarType(AValue);

    // Определяем значение строка или нет
    if (VType = varString) or (VType = varOleStr) then
    begin
      // значение строка

      // определяем размер в байтах строки
      size := Length(AValue);

      // записываем длину строки в Bookmark
      PInteger(APValue)^ := size;
      // перемещаем текущий указатель в Bookmark на длину типа Integer
      Inc(APValue, SizeOf(Integer));

      // Запоминаем указатель на значения
      if VType = varString then
        PVal := PChar(String(AValue))
      else
        PVal := PChar(WideString(AValue));

      // Записываем строку в Bookmark
      for I := 0 to size - 1 do
      begin
        APValue^ :=  (PVal + I)^;
        inc(APValue);
      end;

    end
    else
    begin
      // значение не строка

      // определяем размер в байтах значения
      size := TypeSize(VType);

      // Запоминаем указатель на значения
      PVal := @AValue;

      // Записываем значение в Bookmark
      for I := 0 to size - 1 do
      begin
        APValue^ :=  (PVal + I + (SizeOf(Variant) div 2))^;
        inc(APValue);
      end;

    end;
  end
  else
    // записываемое значение равняется NULL
    // устанавливаем в первом байте флажок, что значение равняется NULL
    FirstByte := Char(Integer(FirstByte) or BOOKMARK_NULL);

  // Записываем байт со значениями флажоками в Bookmark
  PFirstByte^ := FirstByte;
end;


function TVASUPQuery.SizeOfASUPBookmarkValue(AValue : Variant) : Integer;
var
  VType : Integer;
begin
  // Значение переменной в Bookmark-е, как минимум будет занимать один байт.
  // Это байт флажков статусов значения.
  Result := 1;

  // Определяем тип значения
  VType := VarType(AValue);

  if (VType = varString) or (VType = varOleStr) then
    // Если тип значения строка, то в Bookmark будет записано длина строки в байтах.
    // т.к. тип длины строки является Integer
    // то размер значения для строк в Bookmark-е увеличевается на длину типа Integer
    Inc(Result, SizeOf(Integer));

  // К размеру значения в Bookmark-е добовляем, размер сомого значения в байтах
  Inc(Result, VarSize(AValue));
end;

function TVASUPQuery.SizeOfASUPBookmarkValues(AValues : array of Variant) : Integer;
var
  I : Integer;
begin
  Result := 0;
  // Вычисляем количество в байтов, которое будут занимать уникальные значения записи  в Bookmark-е
  for I := Low(AValues) to High(AValues) do
    Inc(Result, SizeOfASUPBookmarkValue(AValues[I]));
end;

function TVASUPQuery.SizeASUPBookmark(ABookmarkValsSize : Integer) : Integer;
begin
  // Размер Bookmark-а, как минимум будет занимать длину типа Integer
  // в нем будет записано текущий номер записи в DataSet-a
  Result := SizeOf(Integer);

  // К размеру bookmark добовляем размер уникльных значений, который они будут занимать в Bookmark-е
  Inc(Result, ABookmarkValsSize);
end;

function TVASUPQuery.SizeOfASUPBookmarkValues(ABookmark : TBookmarkStr) : Integer;
var
  len : Integer;
begin
  len := Length(ABookmark);
  // Bookmark рассчитан что в нем записан номер предполагаемой  записи(тип Integer)
  // и сами уникальные значения
  if len > SizeOf(Integer) then
    Result := len - SizeOf(Integer)
  else
    Result := 0;
end;

function TVASUPQuery.GetASUPBookmarkValues(ABookmark : TBookmarkStr) : TArrayOfVariant;
var
  p    : PChar;
  size : Integer;
  PNextValue   : PChar;
  NamesOfUnFlds : TStrings;
  UnField : TField;
  I : Integer;
  numUnFlds : Integer;
  VType : Integer;
  num : Integer;
  vt : Integer;
begin
  try
    if ABookmark = '' then
      raise EInvalidBookmark.Create('Bookmark is invalid');


    // Премещаем указатель, на уникальные значения в Bookmark-е
    p := PChar(ABookmark) + SizeOf(Integer);

    // Вычисляем размер уникальных значений в Bookmark-е в байтах
    size := SizeOfASUPBookmarkValues(ABookmark);

    if size < 0 then
      // Размер уникальных значений не может быть меньше нуля
      raise EInvalidBookmark.Create('Bookmark is invalid');

    // Читаем уникальные занчения
    case FoundedFields of
      kfRowid        : begin
                         // Уникальным значением является ROWID

                         // Читаем  Rowid из Bookmark
                         SetLength(Result, 1);
                         Result[0] := ReadValueFromASUPBookmark(p, PNextValue, varString, size);

                         // Проверяем правильно ли прочитали ROWID из  Bookmark-а
                         if (VarType(Result[0]) <> varString) or Assigned(PNextValue) then
                           // ошибка в Bookmark-е
                           raise EInvalidBookmark.Create('Bookmark is invalid');
                       end;
      kfUniqueFields : begin
                         // Уникальные значения являются значения полей UniqueFields

                         NamesOfUnFlds := TStringList.Create;
                         try
                           // Читаем название полей UniqueFields
                           StringToStringsWithSemicolon(UniqueFields, NamesOfUnFlds);

                           // Запоминаем кол. уникальных полей
                           numUnFlds := NamesOfUnFlds.Count;

                           SetLength(Result, numUnFlds);

                           // кол. байт уникальных значений, которое необходимо прочитать
                           num := size;

                           // Читаем занчения уникальных полей из Bookmark
                           for I := 0  to numUnFlds - 1 do
                           begin
                             // Находим уникальное поле в DataSet
                             UnField := FieldByName(NamesOfUnFlds[I]);

                             // Определяем тип значения ункального поля
                             VType := VarTypeField(UnField);

                             // Читаем занчение уникального поля из Bookmark
                             Result[I] := ReadValueFromASUPBookmark(p, PNextValue, VType, num);

                             // Проверяем корректность прочитанного значения
                             vt := VarType(Result[I]);
                             if (vt = varEmpty) or (vt = varError) or
                                ((I = (numUnFlds - 1)) and Assigned(PNextValue)) or
                                ((I < (numUnFlds - 1)) and (not Assigned(PNextValue))) then
                               // ошибка в Bookmark-е
                               raise EInvalidBookmark.Create('Bookmark is invalid');

                             // Вычисляем, сколько байт уникальных значений ещё необъодимо прочитать
                             if Assigned(PNextValue) then
                               Dec(num, (PNextValue - p));
                             p := PNextValue;
                           end;
                         finally
                           NamesOfUnFlds.Destroy;
                         end;
                       end;
      else
                       raise EInvalidBookmark.Create('Bookmark is invalid');
    end;
  except
    on Exception do raise EInvalidBookmark.Create('Bookmark is invalid');
  end;
end;

function TVASUPQuery.GetASUPBookmarkRecNo(ABookmark : TBookmarkStr) : Integer;
var
  p : PChar;
begin
  try
    if ABookmark = '' then
      raise EInvalidBookmark.Create('Bookmark is invalid');

    p := PChar(ABookmark);

    // Читаем предполагаемый номер записи, на который сcылается ABookmark
    Result := PInteger(p)^;
  except
    on Exception do raise EInvalidBookmark.Create('Bookmark is invalid');
  end;
end;

function TVASUPQuery.ASUPBookmarkValid(ABookmark : TBookmarkStr) : boolean;
begin
  if ABookmark = '' then
  begin
    Result := false;
    Exit;
  end;
  try
    // Если не произойдет вызов исключения EInvalidBookmark в функций GetBookmarkRecNo и GetBookmarkValues,
    // то ABookmark корректный, иначе не корректный
    Result := true;
    GetASUPBookmarkRecNo(ABookmark);
    GetASUPBookmarkValues(ABookmark);
  except
    on EInvalidBookmark do Result := false;
  end;
end;

function TVASUPQuery.MakeASUPBookmark : TBookmarkStr;
var
  p : PChar;
  Values : TArrayOfVariant;
  NamesOfUnFlds : TStrings;
  numUnFlds : Integer;
  I : Integer;
  UnValsSize : Integer;
  size : Integer;
begin
  Result := '';

  // Обновляем позицию курсора, это очень важно,
  // т.к. может быть установлен номер текущей записи один,
  // а текущая запись быть другая
  UpdateCursorPos; // !!!

  // Читаем уникальные значения из текущей записи
  case FoundedFields of
    kfRowid        : begin
                       // Уникальным значением является ROWID

                       SetLength(Values, 1);

                       // Читаем ROWID
                       Values[0] := Rowid;

                     end;
    kfUniqueFields : begin
                       // Уникальные значения являются значения полей UniqueFields

                       NamesOfUnFlds := TStringList.Create;
                       try
                         // Читаем название полей UniqueFields
                         StringToStringsWithSemicolon(UniqueFields, NamesOfUnFlds);

                         // Запоминаем кол. уникальных полей
                         numUnFlds := NamesOfUnFlds.Count;

                         SetLength(Values, numUnFlds);


                         // Читаем занчения уникальных полей
                         for I := 0  to numUnFlds - 1 do
                           // Читаем занчение уникального поля
                           Values[I] := FieldByName(NamesOfUnFlds[I]).Value;
                       finally
                         NamesOfUnFlds.Destroy;
                       end;
                     end;
      else
                     SetLength(Values, 0);
  end;

  // Вычисляем размер в байтах уникальных значений в Bookmark-е
  UnValsSize := SizeOfASUPBookmarkValues(Values);

  // Вычисляем размер Bookmark-а
  size := SizeASUPBookmark(UnValsSize);

  SetLength(Result, size);
  p := PChar(Result);

  try
    // Записываем текущий номер записи
    PInteger(p)^ := RecNo;
    Inc(p, SizeOf(Integer));

    // Записываем  уникальные значения
    for I := Low(Values) to High(Values) do
    begin
      WriteValueFromASUPBookmark(p, Values[I]);
      Inc(p, SizeOfASUPBookmarkValue(Values[I]));
    end;
  except
    on Exception do Result := '';
  end;
end;

function TVASUPQuery.CompareASUPBookmarks(Bookmark1, Bookmark2: TBookmarkStr): Integer;
var
  LenBM1, LenBM2  : Integer;
  bm1, bm2 : String;
const
  RetCodes: array[Boolean, Boolean] of ShortInt = ((2,-1),(1,0));
begin
  // Вычисляем размер Bookmoark-ов
  LenBM1 := Length(Bookmark1);
  LenBM2 := Length(Bookmark2);

  if (LenBM1 = SizeOf(Integer)) and (LenBM2 = SizeOf(Integer)) then
  begin
    // В Bookmark-ах записан только предполагаемый номер записи

    // Сравниваем по предполагаемому номеру записи
    if PInteger(Pointer(Bookmark1))^ < PInteger(Pointer(Bookmark1))^ then
      Result := -1
    else if PInteger(Pointer(Bookmark1))^ > PInteger(Pointer(Bookmark1))^ then
      Result := 1
    else
      Result := 0;
  end
  else if (LenBM1 >= SizeOf(Integer)) and (LenBM2 >= SizeOf(Integer)) then
  begin
    // Bookmark-и имеют нормальную длину

    // Выкидываем предполагаемы номер записи
    bm1 := copy(Bookmark1, 5, LenBM1 - SizeOf(Integer));
    bm2 := copy(Bookmark2, 5, LenBM2 - SizeOf(Integer));

    // сравниваем
    Result := CompareStr(bm1, bm2);
    if Result < 0 then
      Result := -1
    else if Result > 0 then
      Result := 1;
  end
  else
  begin
    // Если размер Bookmark-а, меньше размера типа Integer
    // (т.е. в него нельзя записать предполагаемый номер записи),
    // то это не правильный Bookmark
    if (LenBM2 >= SizeOf(Integer)) then
      Result := -1
    else if (LenBM1 >= SizeOf(Integer)) then
      Result := 1
    else
      Result := 0;
  end;
end;

procedure TVASUPQuery.GotoASUPBookmark(ABookmark : TBookmarkStr);
var
  cntrlsDis : boolean;

  currRecNo : Integer;
  conjectRecNo : Integer;
  UniqueValues : TArrayOfVariant;
  UniqueFlds   : String;
  RNo : Integer;
begin
  // Сброс удачного поиска
  FFoundedASUPBookmark := false;
  cntrlsDis := ControlsDisabled;

  if Assigned(BeforeScroll) then // Очень важно!!! Используется данная вожможность в прогах,
                                 // т.к. В многих прогах, когда ControlsDisabled = true, то обработчике
                                 // BeforeScroll ни чего не выполняется
    BeforeScroll(Self);

  if not cntrlsDis then
    DisableControls;
  try
    // Запоминаем текущую запись на случай, если не найдем запись,
    // на которую ссылается Bookmark
    currRecNo := RecNo;

    // Читаем предпологаемый номер записи, на которую ссылается Bookmark
    conjectRecNo := GetASUPBookmarkRecNo(ABookmark);
    // Читаем уникальные заначения, по которым будем искать запись
    UniqueValues := GetASUPBookmarkValues(ABookmark);

    // Проверяем поиск идет по Rowid, если да то не пустое ли значение у наш Rowid
    // Это единственный способ проверить, есть ли у DataSet-а Rowid
    // Это очень важно, так как если DataSet не имеет Rowid, то метод SearchRecord выдаст ошибку
    if (FoundedFields <> kfRowid) or (UniqueValues[0] <> '') then
    begin
      // Поиск ведется либо не по Rowid либо DataSet обладает Rowid

      // Определяем, список имен полей с уникальными значениями, по которым будем искать запись
      UniqueFlds := '';
      case FoundedFields of
        kfRowid        : UniqueFlds := 'Rowid';
        kfUniqueFields : UniqueFlds := UniqueFields;
      end;

      try
        // Опредеяяем номер записи,
        // который будет наиболее совпадаеть с предполагаемым номером
        if conjectRecNo > RecordCount then
          RNo := RecordCount
        else
          RNo := conjectRecNo;

        // Предполагаем, что поиск закончится удачно
        FFoundedASUPBookmark := true;

        // Ищем запись, на котрую ссылается Bookmark
        if RNo > 1 then
        begin
          // Предполагаемый номер записи не равен единицы

          // Для более эффективного и успешного поиска методом SearchRecord
          // необходимо установить курсор перед предполагаемой записью.
          // Т.к. когда происходит поиск с текущей позиции,
          // то текущая запись не проверяется на соответствия условия искомой записи,
          // и соответственно, если текущая запись есть та, которую ищем, то она не будет найдена
          RecNo := RNo - 1;

          // Обновляем позицию курсора, это очень важно,
          // т.к. может быть установлен номер текущей записи один,
          // а текущая запись быть другая
          UpdateCursorPos; // !!!

          if not SearchRecord(UniqueFlds, UniqueValues, [srFromCurrent, srForward]) then
          begin
            // Поиск с текущей записи  до последней записи был не удачный.
            // Ищем запись с текущей  до первой записи
            RecNo := RNo;


            // Обновляем позицию курсора, это очень важно,
            // т.к. может быть установлен номер текущей записи один,
            // а текущая запись быть другая
            UpdateCursorPos; // !!!


            if not SearchRecord(UniqueFlds, UniqueValues, [srFromCurrent, srBackward]) then
            begin
              // Запись не была найдена
              // Устанавливаем курсор на запись на ту, на которую он был установлен до поиска
              RecNo := currRecNo;

              // Поиск  неудачный
              FFoundedASUPBookmark := false;
            end;


          end;

          // Обновляем позицию курсора, это очень важно,
          // т.к. может быть установлен номер текущей записи один,
          // а текущая запись быть другая
          UpdateCursorPos; // !!!
        end
        else
        begin
          // Предполагаемый номер записи равен единицы
          // Ищем запись
          if not SearchRecord(UniqueFlds, UniqueValues, [srFromBeginning]) then
          begin
            // Запись не была найдена
            // Устанавливаем курсор на запись на ту, на которую он был установлен до поиска
            if currRecNo > 0 then
              RecNo := currRecNo;

            // Поиск  неудачный
            FFoundedASUPBookmark := false;
          end;

          // Обновляем позицию курсора, это очень важно,
          // т.к. может быть установлен номер текущей записи один,
          // а текущая запись быть другая
          UpdateCursorPos; // !!!
        end;


      except
        on Exception do
        begin
          if currRecNo > 0 then
          begin
            RecNo := currRecNo;

            // Обновляем позицию курсора, это очень важно,
            // т.к. может быть установлен номер текущей записи один,
            // а текущая запись быть другая
            UpdateCursorPos; // !!!
          end;
          // Поиск закончился не удачей
          FFoundedASUPBookmark := false;
        end;
      end;
    end
    else
    begin
      // Поиск ведется  по Rowid, но у DataSet нет Rowid,
      // поэтому поиск не ведем, а устанавливаем курсор на первую запись
      First;

      // Поиск  неудачный
      FFoundedASUPBookmark := false;
    end;

  finally
    if not cntrlsDis then
      EnableControls;

    // Обновляем позицию курсора, это очень важно,
    // т.к. может быть установлен номер текущей записи один,
    // а текущая запись быть другая
    UpdateCursorPos; // !!!
    if Assigned(AfterScroll) then  // Очень важно!!! Используется данная вожможность в прогах,
                                   // т.к. В многих прогах, когда ControlsDisabled = true, то обработчике
                                   // AfterScroll ни чего не выполняется
      AfterScroll(Self);
  end;
end;

procedure MoveVariablesToQuery(Source: TOracleDataSet;Dest: TOracleQuery);
var
  I: Integer;
begin
  for I:= 0 to Source.Variables.Count-1 do
  begin
   Dest.DeclareVariable( Source.Variables.Data(I).Name,
                         Source.Variables.Data(I).BufType);
   Dest.SetVariable( Source.Variables.Data(I).Name,
                     Source.GetVariable(Source.Variables.Data(I).Name));
  end;
end;

procedure MoveVariablesToSet(Source,Dest: TOracleDataSet);
var
  I: Integer;
begin
  for I:= 0 to Source.Variables.Count-1 do
  begin
   Dest.DeclareVariable( Source.Variables.Data(I).Name,
                         Source.Variables.Data(I).BufType);
   Dest.SetVariable( Source.Variables.Data(I).Name,
                     Source.GetVariable(Source.Variables.Data(I).Name));
  end;
end;

function TVASUPQuery.GetSQLRecordCount:Integer;
var
  quCount: TOracleQuery;
  ChangedCursor: bool;
  I : TSQLKeyWord;
  strs : TStrings;
begin
  if Active then
  begin
    ChangedCursor:= Screen.Cursor=crDefault;
    if ChangedCursor then
       Screen.Cursor:= crSQLWait;
    quCount:= TOracleQuery.Create(Self);
    quCount.Session:= Session;
    strs := TStringList.Create;
    for I:= FROM to Pred(ORDER_BY) do
    begin
      FBrockenSQL.getStringsArea(I, strs);
      if strs.Count>0 then
      begin
        quCount.SQL.Append(TBrockenSQL.InEnglish(I));
        quCount.SQL.AddStrings(strs);
      end;
    end;
    strs.Destroy;
    quCount.SQL.Insert(0,Format( 'SELECT COUNT(/*DISTINCT*/ %s.ROWID) ',
                                 [FUpdTabAlias])
                                 );
    MoveVariablesToQuery(Self,quCount);
    quCount.Execute;
    if quCount.EOF then Result:= 0
    else Result:= quCount.FieldAsInteger(0);
    quCount.Free;
    if ChangedCursor then
       Screen.Cursor:= crDefault;
  end
  else Result:= 0;
end;

procedure CopyTempVariables(Receiver,Sender: TOracleDataSet); // старый код
var
  I: Integer;
begin
  with Sender do
  for I:= 0 to VariableCount-1 do
    if Pos(TempVarHeader,':'+Variables.Data(I).Name)>0 then
    begin
      Receiver.DeclareVariable( Variables.Data(I).Name,
                                Variables.Data(I).BufType);
      Receiver.SetVariable( Variables.Data(I).Name,
                            GetVariable(Variables.Data(I).Name));
    end;
end;

function TVASUPQuery.getUserSQLQueryForMaster(ASQLQuery : String): String;
begin
  Result := '';
  if Length(ASQLQuery)>0 then
    if EmbeddedSQLSlice.Count=0 then
      case LinkKind of
        lkExists: Result:= Format( 'EXISTS (SELECT 1 FROM %S %S WHERE %s AND %S) ',
                     [ UpdatingTable,
                       UpdTabAlias,
                       SQLConcat(Self, DetailFields
                                  ,MasterFields
                                  ,TVASUPQuery(Master)),
                       ASQLQuery]);
        lkIn: Result:= Format( '(%s) IN (SELECT %s FROM %S %S WHERE %S) ',
                     [ SQLConcat2( TVASUPQuery(Master),
                                   MasterFields
                                  ),
                       SQLConcat2( Self,
                                   DetailFields
                                  ),
                       UpdatingTable,
                       UpdTabAlias,
                       ASQLQuery])
      end
    else
      case LinkKind of
        lkExists:  Result:= Format( 'EXISTS (SELECT 1 %S AND %s AND %S) ',
                     [ EmbeddedSQLSlice.Text,
                       SQLConcat( Self, DetailFields
                                 ,MasterFields
                                 ,TVASUPQuery(Master)),
                       ASQLQuery]);
        lkIn: Result:= Format( '(%s) IN (SELECT %s %S AND %S) ',
                     [ SQLConcat2( TVASUPQuery(Master),
                                   MasterFields
                                  ),
                       SQLConcat2( Self,
                                   DetailFields
                                  ),
                       EmbeddedSQLSlice.Text,
                       ASQLQuery])
      end;
end;

function TVASUPQuery.DoSQLCode:string;
var
  Appendix : string;

procedure PrepareNativeSQL;
var
  I,J:Integer;
  NewVar: String;

function OriginByName(const AName: string): string;
var
  xField: TField;
begin
  xField:= FindField(AName);
  if Assigned(xField) then
    Result:= OriginFieldName(xField)
  else Result:= AName;
end;

begin
  if Assigned(FKeyWords) then
    for J:= 0 to FKeyWords.Count-1 do
      DeclareNoDefaultSQLVariable(TempVarHeader+UpperCase(Self.Name)+Format('_%d',[J]),
                                  otString, SIMPLE_QUERY, FKeyWords[J]+'%');
  for I:= VarArrayLowBound(FSQLBit,1) to VarArrayHighBound(FSQLBit,1) do
  begin
    if Length(DefaultSQL)=0 then
      if Length(Result)>0 then Result:= Concat(Result,',',FSQLBit[I])
      else Result:= FSQLBit[I];
    if Assigned(FKeyWords) then
      for J:= 0 to FKeyWords.Count-1 do
      begin
        NewVar:= TempVarHeader+UpperCase(Self.Name)+Format('_%d',[J]);
        if Length(Appendix)=0 then
          Appendix:= Format('%s LIKE %s',
          [OriginByName(FSQLBit[I]),NewVar])
        else Appendix:= Format('%s OR %s LIKE %s',[Appendix,
           OriginByName(FSQLBit[I]),NewVar]);
      end;
    if (I<=VarArrayLowBound(FSQLBit,1)) and (Length(FOrder)=0) then
      FOrder:= Concat(OriginByName(FSQLBit[I]),' ASC');
  end;
  if Length(Appendix)>0 then
    Appendix:= Format('(%s)',[Appendix]);
end;

begin
  Appendix:= '';
  ClearAllUserSQLQuerys; // Новый код
  if (VarType(FSQLBit)<>varEmpty) then
    begin
      Result:= '';
      if Length(DefaultSQL)=0 then
      begin
        if SQL.Count>0 then SetDefaultSQL(SQL.Text)
        else SetDefaultSQL( Format('SELECT %s FROM %s %s',
                                   [Result,UpdatingTable,UpdTabAlias])
                           )
      end;
      PrepareNativeSQL;
      Result:= DefaultSQL;
      FBrockenSQL.SetScriptForKey(Result);
      FBrockenSQL.AddToArea(WHERE, Appendix, SIMPLE_QUERY);
    end;
  if (VarType(FSQLBit)=varEmpty) or not Assigned(FKeyWords)
     or (FKeyWords.Count=0) then
  begin
    SaveUserSQLQuery(csWhere,qsExecution);
    if FLinkDetSQL then
      SaveDetailUserSQLQuery;

    if (Length(DefaultSQL)=0) or (csDesigning in ComponentState) then
      SetDefaultSQL(SQL.Text);

    BuildFullUserSQLQuery;

    BuildUserSQLQueryOfDetails;
  end;

  SaveUserSQLQuery(csHaving,qsExecution);

  if SQLFiltered then
    FBrockenSQL.AddToArea(WHERE, SQLFilter, SQL_FILTER);
  if not (csDesigning in ComponentState)  then
    if Length(FOrder)>0 then
      FBrockenSQL.SetArea(ORDER_BY, FOrder, DEFAULT_ORDER_BY)
    else
      FBrockenSQL.DeleteAreaForKey(ORDER_BY, DEFAULT_ORDER_BY);

  RefreshSQL;
  Result:= SQL.Text;
end;

procedure TVASUPQuery.SetSQLFields;
var
  SizeData,I:LongInt;
begin
  SizeData:= High(ForeignData);
  FSQLBit:= VarArrayCreate([0,SizeData],varOleStr);
  for I:= 0 to SizeData do FSQLBit[I]:= UpperCase(ForeignData[I]);
end;

function TVASUPQuery.MasterLinkText;
var
  DetailText,DetailBit: string;
  PlusText: string;
begin
  Result:= '';
  DetailText:= DetailFields;
  Cut(';',DetailText,DetailBit);
  if (Length(DetailBit)>0) and
     not FieldByName(DetailBit).Required then PlusText:= '(+)'
  else PlusText:= '';
  if Length(DetailBit)>0 then
    Result:= Format( '%s%s=%s',
                     [ OriginFieldName(FieldByName(DetailBit)),
                       PlusText,
                       ':'+DetailBit]);
  Cut(';',DetailText,DetailBit);
  while Length(DetailBit)>0 do
  begin
    if not FieldByName(DetailBit).Required then
    PlusText:= '(+)'
  else PlusText:= '';
    Result:= Concat( Result,
             Format(' AND %s%s=%s',
                      [ OriginFieldName(FieldByName(DetailBit)),
                        PlusText,
                        ':'+DetailBit]));
    Cut(';',DetailText,DetailBit);
  end;
end;

procedure TVASUPQuery.Execute;
var
  LibItemIndex: Integer;
  ChangedCursor: bool;
  I: Integer;
  PreWStyle : TWStyle;
begin
  ChangedCursor:= Screen.Cursor=crDefault;
  try
    if ChangedCursor then
       Screen.Cursor:= crSQLWait;
    LibItemIndex:= FLib.ItemIndex;
    AfterExecute;
    if Assigned(FBeforeVisualQuery) then FBeforeVisualQuery(Self);
    if LibItemIndex>=0 then
    begin
       FLib.ItemIndex:= LibItemIndex;
       {FEOQ:= False;
       FBOQ:= False;}
    end;
    DisableControls;
    DoSQLCode;
    if FNoFullQuery
       and (FLib.ItemIndex= FLib.Count-1)
       and not FIsLinked then
       raise EEmptyQuery.Create(EmptyQueryMsg);
    SlowOpen;
    //First;
    //SetCurrRecBookmark;
    PreWStyle := FWStyle;
    FWStyle:= wsView;
    CheckWorkState;
    if PreWStyle <> FWStyle then
      AfterChangeWorkState;
  finally
    EnableControls;
    if ChangedCursor then
       Screen.Cursor:= crDefault;
    if FIsLinked then
      for I:= 0 to FLinkedDetails.Count-1 do
        TDataSet(FLinkedDetails[I]).EnableControls;
  end;
end;

procedure TVASUPQuery.Mixer;
var
  Dial: TfmSort;
begin
  Dial:= TfmSort.Create(Self);
  Dial.QRY:= Self;
  Dial.ShowModal;
end;

function TVASUPQuery.CheckUserDefinedSQL: boolean;
var
  J: Integer;
  SQLFrame: TSQLFrame;
begin
  Result:= false;
  if Assigned(FOnSQLPreparing) then
  begin
    J:= 0;
    while not Result and (J<FieldCount) do
    begin
      SQLFrame.ExprType:= piUserDefined;
      SQLFrame.Content:= '';
      FOnSQLPreparing(Self,Fields[J],SQLFrame,Result);
      Inc(J);
    end;
  end;
end;

function TVASUPQuery.IsEmptyScreen: boolean;
var
  I, J : Integer;
  PropInfo: PPropInfo;
  PropValue: Pointer;
  Comp: TComponent;

  Form : TForm;
begin
  Result:= true;

  for J := 0 to RegistFormCount - 1 do
  begin
    Form := RegistForms[J];
    if IsControlForm(Form) then
    begin

      I:= 0;

      if Assigned(Form) and (GetWorkStyleOfForm(Form) = wsQuery) and IsQuery then
      begin
        while Result and (I<Form.ComponentCount) do
        begin
          Comp:= Form.Components[I];
          PropInfo:= GetPropInfo(Comp.ClassInfo,'DataSource');
          if Assigned(PropInfo) then
            PropValue:= Pointer(GetOrdProp(Comp,PropInfo))
          else PropValue:= nil;
          if Assigned(PropValue)
             and (TDataSource(PropValue).DataSet=Self) then
          begin
            if Comp is TVQryEdit then
              Result:= (TVQryEdit(Comp).QueryState= piNone) and TVQryEdit(Comp).Field.IsNull
            else if (Comp is TDBCheckBox) then
              Result:= TDBCheckBox(Comp).State= cbGrayed
            else  if (Comp is TDBRadioGroup)  then
              with TDBRadioGroup(Comp) do
                Result:= (ItemIndex=-1) or (ItemIndex=Items.Count-1)
            else if (Comp is TDBMemo)  then
              Result:= TDBMemo(Comp).Field.IsNull
          end;
          Inc(I);
        end;
        if Result then
          Result:= not CheckUserDefinedSQL;
      end;
    end;
  end;
end;

procedure TVASUPQuery.FromScreen;
var
  I,J, Y : Integer;
  MoreQRY: TVisualQuery;
  Block: TSQL;
  PropInfo: PPropInfo;
  PropValue: Pointer;
  LinkedQuery: TLinkedQuery;
  AreaList: TList;
  WorkArea: TComponent;

  Form : TForm;

procedure AddUserDefinedSQL;
var
  J: Integer;
  Using: boolean;
  SQLFrame: TSQLFrame;
begin
  if Assigned(FOnSQLPreparing) then
    for J:= 0 to FieldCount-1 do
    begin
      Using:= false;
      SQLFrame.ExprType:= piUserDefined;
      SQLFrame.Content:= '';
      SQLFrame.Comment:= '';
      FOnSQLPreparing(Self,Fields[J],SQLFrame,Using);
      if Using then
        with Block do
        begin
          FieldName:= Fields[J].FieldName;
          Value:= Fields[J].AsString;
          Expr:= SQLFrame.ExprType;
          Comment:= SQLFrame.Comment;
          ResType:= rtString;
          ResString:= StrAlloc(Length(SQLFrame.Content)+1);
          StrPCopy(ResString,SQLFrame.Content);
          MoreQRY.Add(Block);
        end;
    end;
end;

procedure AddFilterText;
var
  tFiltered: boolean;
  tFilter: string;
  Comment: string;
begin
  if Assigned(FOnSetFilter) then
  begin
    Comment:= '';
    FOnSetFilter(Self,tFiltered,tFilter,Comment);
    if tFiltered then
    begin
      Block.FieldName:= SpecNameByte+'FILTER';
      Block.Value:= tFilter;
      Block.Comment:= Comment;
      Block.Expr:= piEqual;
      Block.ResType:= rtFilter;
      MoreQRY.Add(Block);
    end;
  end;
end;

function SQLString(Strings:TStrings;CharCase:TEditCharCase=ecNormal):string;
var
  J: Integer;
  S: String;
begin
  Result:= '';
  for J:= 0 to Strings.Count-1 do
  begin
    case CharCase of
      ecUpperCase: S:= AnsiUpperCase(Strings[J]);
      ecLowerCase: S:= AnsiLowerCase(Strings[J]);
      else S:= Strings[J];
    end;
    if Length(S)>0 then Result:= Concat(Result,'%',S);
  end;
end;

begin
  MoreQRY:= TVisualQuery.Create(Self);
  AreaList:= TList.Create;

  for Y := 0 to RegistFormCount - 1 do
  begin


    Form := RegistForms[Y];

    if IsControlForm(Form) and (GetWorkStyleOfForm(Form) = wsQuery) then
    begin

      AreaList.Clear;

      AreaList.Add(Form);
      for I:= 0 to Form.ComponentCount-1 do
        if Form.Components[I] is TFrame then
          AreaList.Add(Form.Components[I]);

      for J:= 0 to AreaList.Count-1 do
      begin
        WorkArea:= TComponent(AreaList[J]);
        for I:= 0 to WorkArea.ComponentCount-1 do
        begin
          Block.ResType:= rtNone;
          PropInfo:= GetPropInfo(WorkArea.Components[I].ClassInfo,'DataSource');
          if Assigned(PropInfo) then
            PropValue:= Pointer(GetOrdProp(WorkArea.Components[I],PropInfo))
          else PropValue:= nil;
          if Assigned(PropValue)
             and (TDataSource(PropValue).DataSet=Self) then
          begin
            PropInfo:= GetPropInfo(WorkArea.Components[I].ClassInfo,'Enabled');
            if Assigned(PropInfo) and
               Bool(GetOrdProp(WorkArea.Components[I],PropInfo)) then
            begin
              if WorkArea.Components[I] is TVQryEdit then
                with (WorkArea.Components[I] as TVQryEdit),Block do
                begin
                  if Permission then
                  begin
                    FieldName:= DataField;
                    Expr:=  QueryState;
                    if QueryState<>piInto then
                    begin
                      if (Field is TDateTimeField) and not Field.IsNull then
                      begin
                        Value:= FormatDateTime(LongDateFmtLine,Field.Value);
                        ResType:= rtDate;
                        ResDate:= Field.Value;
                      end
                      else if CharCase=ecNormal then
                        Value:= AnsiUpperCase(Trim(Field.AsString))
                      else Value:= Trim(Field.AsString);
                      {if Field is TNumericField then
                         Value:= ReplaceStr(Value,DecimalSeparator,'.');}
                      if (Length(Value)>0) or
                         ((Expr in [piEqual,piNotEqual]) {and (Expr<>DefaultState)}) then
                        MoreQRY.Add(Block);
                    end
                    else
                    begin
                      Value:= EnumValuesLine;
                      if Length(Value)>0 then
                      begin
                        ResType:= rtEnumList;
                        ResEnumList:= TVEnumValueList.Create(WorkArea.Components[I] as TVQryEdit);
                        ResEnumList.Replicate(QueryValuesList);
                        MoreQRY.Add(Block);
                      end;
                    end;
                  end
                end
              else if (WorkArea.Components[I] is TDBCheckBox) and
                      ((WorkArea.Components[I] as TDBCheckBox).State in [cbChecked,cbUnchecked]) then
                with (WorkArea.Components[I] as TDBCheckBox),Block do
                begin
                  FieldName:= DataField;
                  if Checked then Value:= ValueChecked
                  else Value:= ValueUnChecked;
                  Expr:= piEqual;
                  MoreQRY.Add(Block);
                end
              else  if (WorkArea.Components[I] is TDBRadioGroup)  then
                with (WorkArea.Components[I] as TDBRadioGroup) do
                begin
                  if ItemIndex in [0..Items.Count-2] then
                  begin
                    Block.FieldName:= DataField;
                    Block.Value:= (WorkArea.Components[I] as TDBRadioGroup).Value;
                    Block.Expr:= piNone;
                    MoreQRY.Add(Block);
                  end
                end
              else if (WorkArea.Components[I] is TDBMemo)  then
                with (WorkArea.Components[I] as TDBMemo),Block do
                  if not Field.IsNull then
                  begin
                    FieldName:= DataField;
                    Value:= SQLString(Lines);
                    if Length(Value)>0 then
                    begin
                      ResType:= rtString;
                      ResString:= StrAlloc(Length(Lines.Text)+1);
                      StrPCopy(ResString,Lines.Text);
                      Expr:= piLike;
                      MoreQRY.Add(Block);
                    end;
                  end;
            end;
          end;
        end;
      end;
    end;
  end;
  AreaList.Free;
  AddUserDefinedSQL;
  AddFilterText;
  if MoreQRY.Count=0 then
  begin
    MoreQRY.Free;
    FLib.ItemIndex:= FLib.Count-1;
    //20.10.05
    //FIsQuery:= false;
  end
  else FLib.Add(MoreQRY);
  {if (FLib.ItemIndex< FLib.Count-1) or
     LinkDetailSQL then}
  begin
    LinkedQuery:= TLinkedQuery.Create;
    if FLib.ItemIndex= FLib.Count-1 then
      LinkedQuery.SelfIndex:= -1
    else LinkedQuery.SelfIndex:= FLib.ItemIndex;
    LinkedQuery.SelfObj:= Self;
    FLinkedQueries.Add(LinkedQuery);
  end;
end;

function FindDataControl(Owner: TComponent;Field:TField):TComponent;
var
  J: Integer;
  PropInfo: PPropInfo;
  PropValue: Pointer;
begin
  J:= 0;
  Result:= nil;
  with Owner do
    while (J<ComponentCount) and not Assigned(Result) do
    begin
      PropInfo:= GetPropInfo(Components[J].ClassInfo,'DataSource');
      if Assigned(PropInfo) then
         PropValue:= Pointer(GetOrdProp(Components[J],PropInfo))
      else PropValue:= nil;
      if Assigned(PropValue) and
         (TDataSource(PropValue).DataSet=Field.DataSet ) then
      begin
        PropInfo:= GetPropInfo(Components[J].ClassInfo,'DataField');
        if Assigned(PropInfo) and
         (GetStrProp(Components[J],PropInfo)=Field.FieldName) then
          Result:= Components[J];
      end;
      Inc(J);
    end;
end;

procedure TVASUPQuery.ClearScreen;
var
  I,J, Y :Integer;
  PropInfo: PPropInfo;
  PropValue: Pointer;
  SyncDet: Boolean;
  DetailList: TList;
  AreaList: TList;
  WorkArea: TComponent;
  Form : TForm;
begin
  DetailList:= TList.Create;
  SyncDet:= ForceMasterSynchronization;
  ForceMasterSynchronization:= False;
  DisableControls;
  GetDetailList(DetailList);
  for I:= DetailList.Count-1 downto 0 do
    if TOracleDataSet(DetailList[I]).Active
       and (TOracleDataSet(DetailList[I]).Master=Self) then
         RemoveDetail(TOracleDataSet(DetailList[I]) )
    else DetailList.Delete(I);
  for I:= 0 to FieldCount-1 do
    if (Fields[I].FieldKind in [fkData,fkInternalCalc])
        and not Fields[I].IsNull then Fields[I].Clear;

  for Y := 0 to RegistFormCount - 1 do
  begin
    Form := RegistForms[Y];

    if IsControlForm(Form) then
    begin
      Form.Invalidate;
      AreaList:= TList.Create;
      AreaList.Add(Form);
      for I:= 0 to Form.ComponentCount-1 do
        if Form.Components[I] is TFrame then
          AreaList.Add(Form.Components[I]);
      for J:= 0 to AreaList.Count-1 do
      begin
        WorkArea:= TComponent(AreaList[J]);
        with WorkArea do
          for I:= 0 to ComponentCount-1 do
          begin
            PropInfo:= GetPropInfo(Components[I].ClassInfo,'DataSource');
            if Assigned(PropInfo) then
              PropValue:= Pointer(GetOrdProp(Components[I],PropInfo))
            else PropValue:= nil;
            if Assigned(PropValue)
            and (TDataSource(PropValue).DataSet=Self ) then
            begin
              if Components[I] is TVQryEdit then
                with Components[I] as TVQryEdit do
                begin
                  PopUpMenu.AutoPopUp:= true;
                  QueryState:= piNone;
                  {if CharCase=ecNormal then
                     CharCase:= ecUpperCase;}
                  Permission:= true;
                end
              else if Components[I] is TDBCheckBox then
                with Components[I] as TDBCheckBox do
                begin
                  ReadOnly:= false;
                  AllowGrayed:= true;
                  State:= cbGrayed;
                end
              else if Components[I] is TDBRadioGroup then
                with Components[I] as TDBRadioGroup do
                begin
                  ReadOnly:= false;
                  if Values.IndexOf(Ripstring)<0 then
                  begin
                    Items.Add(RIPCaption);
                    Values.Add(RIPstring);
                  end;
                  ItemIndex:= -1;
                end;
            end;
          end;
      end;
      AreaList.Free;
    end;
  end;
  if Assigned(FOnFilterChange) then
     FOnFilterChange( Self,False,'');
  EnableControls;
  ForceMasterSynchronization:= SyncDet;
  for I:= DetailList.Count-1 downto 0 do
    AddDetail(TOracleDataSet(DetailList[I]));
  DetailList.Free;
end;

procedure TVASUPQuery.CancelScreen;
var
  I,J, Y :Integer;
  PropInfo: PPropInfo;
  PropValue: Pointer;
  Flag: bool;
   AreaList: TList;
  WorkArea: TComponent;
  Form : TForm;
begin
  for Y := 0 to RegistFormCount - 1 do
  begin
    Form := RegistForms[Y];
    if IsControlForm(Form) then
    begin
      Form.Invalidate;
      AreaList:= TList.Create;
      AreaList.Add(Form);
      for I:= 0 to Form.ComponentCount-1 do
        if Form.Components[I] is TFrame then
          AreaList.Add(Form.Components[I]);
      for J:= 0 to AreaList.Count-1 do
      begin
        WorkArea:= TComponent(AreaList[J]);
        with WorkArea do
          for I:= 0 to ComponentCount-1 do
          begin
            PropInfo:=  GetPropInfo(Components[I].ClassInfo,'DataSource');
            if Assigned(PropInfo) then
              PropValue:= Pointer(GetOrdProp(Components[I],PropInfo))
            else PropValue:= nil;
            if Assigned(PropValue)
            and ( TDataSource(PropValue).DataSet=Self) then
            begin
              PropInfo:= GetPropInfo(Components[I].ClassInfo,'ReadOnly');
              if Assigned(PropInfo) then
                SetOrdProp(Components[I],PropInfo,0);
              if Components[I] is TVQryEdit then
                (Components[I] as TVQryEdit).Permission:= false
              else if Components[I] is TDBCheckBox then
                with Components[I] as TDBCheckBox do
                begin
                  AllowGrayed:= False;
                  //State:= cbUnchecked;
                end
              else if  Components[I] is TDBRadioGroup then
              with Components[I] as TDBRadioGroup do
              begin
                if Values.IndexOf(RIPstring)>=0 then
                begin
                 if ItemIndex= Items.Count-1 then
                    ItemIndex:= -1;
                   Values.Delete(Values.Count-1);
                 Items.Delete(Items.Count-1);
                end;
              end;
            end;
          end;
      end;
      AreaList.Destroy;
    end;
  end;
end;

procedure TVASUPQuery.OnScreen(LibIndex: Integer);
var
  I,J,iBlock:Integer;
  Block: TSQL;
  PropInfo: PPropInfo;
  PropValue: Pointer;
  UsedBlocks: TList;
  quField: TField;
  AreaList: TList;
  WorkArea: TComponent;
  Y : Integer;
  Form : TForm;
begin
  ClearScreen;
  if LibIndex>=0 then
  if Assigned(FLib[LibIndex]) then
  begin
    UsedBlocks:= TList.Create;
    for Y := 0 to RegistFormCount - 1 do
    begin
      Form := RegistForms[Y];
      if IsControlForm(Form) then
      begin
        AreaList:= TList.Create;
        AreaList.Add(Form);
        for I:= 0 to Form.ComponentCount-1 do
          if Form.Components[I] is TFrame then
            AreaList.Add(Form.Components[I]);
        for J:= 0 to AreaList.Count-1 do
        begin
          WorkArea:= TComponent(AreaList[J]);
          with WorkArea do
            for I:= 0 to ComponentCount-1 do
            begin
              PropInfo:= GetPropInfo(Components[I].ClassInfo,'DataSource');
              if Assigned(PropInfo) then
                PropValue:= Pointer(GetOrdProp(Components[I],PropInfo))
              else PropValue:= nil;
              if Assigned(PropValue)
                 and (TDataSource(PropValue).DataSet=Self ) then
              begin
                PropInfo:= GetPropInfo(Components[I].ClassInfo,'DataField');
                if Assigned(PropInfo) then
                begin
                  iBlock:= FLib[LibIndex].IndexOf(GetStrProp(Components[I],PropInfo),Block);
                  if iBlock>=0 then
                  begin
                    UsedBlocks.Add(Pointer(iBlock));
                    if Block.Expr= piInto then
                      with Components[I] as TVQryEdit do
                      begin
                        QueryValuesList.Replicate(Block.ResEnumList);
                        QueryState:= piInto;
                      end
                    else
                    begin
                      if (Block.ResType=rtString) and (Components[I] is TDBMemo) then
                        FieldByName(Block.FieldName).AsString:= Block.ResString
                      else
                      begin
                        quField:= FieldByName(Block.FieldName);
                        if quField is TNumericField then
                          quField.AsString:= ReplaceStr(Block.Value,SQLDecimalSeparator,DecimalSeparator)
                        else if Block.ResType= rtDate then
                          quField.Value:= Block.ResDate
                        else quField.AsString:= Block.Value;
                        if Components[I] is TVQryEdit then
                          (Components[I] as TVQryEdit).QueryState:= Block.Expr;
                      end;
                    end;
                  end;
                end;
              end;
            end;
        end;
        AreaList.Destroy;
      end;
    end;
   for I:= 0 to FLib[LibIndex].Count-1 do
     if UsedBlocks.IndexOf(Pointer(I))<0 then
     begin
       if FLib[LibIndex][I].ResType= rtFilter then
       begin
         if Assigned(FOnFilterChange) then
            FOnFilterChange( Self,(FLib[LibIndex][I].Expr= piEqual),
                             FLib[LibIndex][I].Value);
       end
       else FieldByName(FLib[LibIndex][I].FieldName).AsString:= FLib[LibIndex][I].Value;
     end;
   UsedBlocks.Free;
   FLib.ItemIndex:= LibIndex;
   end;
end;

procedure TVASUPQuery.DetailsOnScreen;
var
  I: Integer;
  LinkSet: TVASUPQuery;
begin
  (*if FLinkDetSQL then
    for I:= 0 to FLinkedDetails.Count-1 do
    begin
      LinkSet:= TVASUPQuery(FLinkedDetails[I]);
      if not LinkSet.Active then LinkSet.Open;
      if LinkSet.State<>dsInsert then
      begin
        LinkSet.Cancel;
        LinkSet.Insert;
      end;
      //LinkSet.PriorViQuery;
      {if LinkSet.IndexViQuery>0 then}
         LinkSet.OnScreen(LinkSet.IndexViQuery);
      LinkSet.WorkState:= wsQuery;
      if LinkSet.LinkDetailSQL then LinkSet.DetailsOnScreen;
    end;*)
end;


procedure TVASUPQuery.InternalRefresh;
begin
  if FRefreshing then
    Exit;
  FRefreshing:= true;
  try
    SaveCurrRecBookmark;

    inherited;

    if Active and (RecordCount > 0) then
      SetCurrRecBookmark;
  finally
    FRefreshing:= false;
  end;
end;

procedure TVASUPQuery.ClearUserSQLQuery;
var
  DetailList : TObjectList;
  I : INteger;
begin
  DeleteMission(USER_QUERY);
  DeleteMission(SQL_FILTER);
  DeleteMission(SIMPLE_QUERY);

  DetailList := TObjectList.Create(false);
  GetDetailDataSets(DetailList);
  for I := 0 to DetailList.Count - 1 do
    DeleteMission(GetNameMissionDetailQuery(TDataSet(DetailList[I])));

  DetailList.Destroy;


  FUserSQLQuery.Clear;
end;

procedure TVASUPQuery.ClearAllUserSQLQuerys;
var
  DetailList: TList;
  I : Integer;
begin
  DetailList:= TList.Create;
  GetDetailList(DetailList);
  DetailList.Insert(0,Self);

  for I:= DetailList.Count-1 downto 0 do
    if TObject(DetailList[I]) is TVASUPQuery then
      with TObject(DetailList[I]) as TVASUPQuery do
        ClearUserSQLQuery;

  DetailList.Destroy;
end;

procedure TVASUPQuery.BeforeQueryPro;
begin
{  if not FRefreshing then
  begin}
    if (Length(DefaultSQL)=0) or (csDesigning in ComponentState) then
      SetDefaultSQL(SQL.Text);
    if (SQL.Count=0) and (not (csDesigning in ComponentState)) then SQL.Text:= DefaultSQL;
    WorkWithMaster;
    if not (csDesigning in ComponentState) then
    begin
      if Length(FOrder)>0 then
        FBrockenSQL.SetAreaForKey(ORDER_BY, FOrder, DEFAULT_ORDER_BY)
      else
        FBrockenSQL.DeleteAreaForKey(ORDER_BY, DEFAULT_ORDER_BY);

      RefreshSQL;
    end;
    //with TBrockenSQL.Create(SQL) do
    //begin
    //  SetArea(ORDER_BY,FOrder);
    //  Compile(SQL);
    //  Free;
    //end;
//  end;
end;

procedure TVASUPQuery.ReOrder;
begin
  if Length(FOrder)>0 then
    FBrockenSQL.SetAreaForKey(ORDER_BY, FOrder, DEFAULT_ORDER_BY)
  else
    FBrockenSQL.DeleteAreaForKey(ORDER_BY, DEFAULT_ORDER_BY);

  RefreshSQL;

  {with TBrockenSQL.Create(SQL) do
  begin
    SetArea(ORDER_BY,FOrder);
    Compile(SQL);
    Free;
  end;}
  Refresh;
end;

procedure TVASUPQuery.AfterExecute;
begin
  if (Length(DefaultSQL)>0) and
  not (csDesigning in ComponentState) then
  begin
    DeleteMission(MASTER_DATASET);
    RefreshSQL;
    //DeleteMissions;
    //SQL.Text:= DefaultSQL;
  end;
  with FLib do ItemIndex:= Count-1;
  if Assigned(Master) and Master.Active
     and Assigned(FMaster) then
  begin
    //DropMasterVariables;
    FMaster:= nil;
  end;
end;

procedure TVASUPQuery.ClearAllNoDefaultSQLVaiables;
var
  MissOfVar : TStrings;
  I, J : Integer;

begin
  MissOfVar := TStringList.Create;

  FAllNoDefaultSQLVariables.GetAllKeys(MissOfVar);
  for I := 0 to MissOfVar.Count - 1 do
    with FAllNoDefaultSQLVariables[MissOfVar[I]] do
      for J := 0 to count - 1 do
        Items[J].Value := NULL;

  MissOfVar.Destroy;
end;

procedure TVASUPQuery.ClearNoDefaultSQLVaiables(AMission : String);
var
  Variables : TSQLVariables;
  I : Integer;
begin
  Variables := FAllNoDefaultSQLVariables.GetSQLVariables(AMission);

  if Assigned(Variables) then
    if FAllNoDefaultSQLVariables.EnabledVars[AMission] then
      for I := 0 to Variables.Count - 1 do
        with Variables[I] do
        begin
          Self.SetVariable(VariableName, NULL);
          Value := NULL;
        end
    else
      for I := 0 to Variables.Count - 1 do
        Variables[I].Value := NULL;
end;

procedure TVASUPQuery.DeclareNoDefaultSQLVariable(AName : String; AType : Integer; AMission : String);
begin
  DeclareNoDefaultSQLVariable(AName, AType, AMission, NULL);
end;

procedure TVASUPQuery.DeclareNoDefaultSQLVariable(AName : String; AType : Integer; AMission : String; AValue : Variant);
var
  Variable : TSQLVariable;
begin
  Variable := FAllNoDefaultSQLVariables.getVariable(AName);
  if Assigned(Variable) then
    raise ENoUniqueNameOfSQLVariables.CreateFmt('Variable with a name %s already exists', [AName]);

  if AMission <> '' then
    FAllNoDefaultSQLVariables[AMission].Add(AName, AValue, AType);

  if (AMission = '') or FAllNoDefaultSQLVariables.EnabledVars[AMission] then
  begin
    DeclareVariable(AName, AType);
    if AValue <> NULL then
      SetVariable(AName, AValue);
  end;
end;

procedure TVASUPQuery.DeleteNoDefaultSQLVariable(AName : String);
var
  Variable : TSQLVariable;
  Mission  : String;
begin
  Variable := FAllNoDefaultSQLVariables.getVariable(AName, Mission);

  if Assigned(Variable) then
  begin
    if FAllNoDefaultSQLVariables.EnabledVars[Mission] then
      DeleteVariable(AName);

    with FAllNoDefaultSQLVariables[Mission] do
      Delete(NameToIndex(AName));
  end;
end;

procedure TVASUPQuery.DeleteNoDefaultSQLVariables(AMission : String);
var
  Variables : TSQLVariables;
  I : Integer;
begin
  Variables := FAllNoDefaultSQLVariables.GetSQLVariables(AMission);

  if Assigned(Variables) then
  begin
    if FAllNoDefaultSQLVariables.EnabledVars[AMission] then
      for I := Variables.Count - 1 downto 0 do
        with Variables[I] do
          DeleteVariable(VariableName);

    FAllNoDefaultSQLVariables.Delete(AMission);
  end;
end;

procedure TVASUPQuery.DeleteAllNoDefaultSQLVariables;
var
  MissOfVar : TStrings;
  I, J : Integer;
begin
  MissOfVar := TStringList.Create;

  FAllNoDefaultSQLVariables.GetAllKeys(MissOfVar);
  for I := 0 to MissOfVar.Count - 1 do
    DeleteNoDefaultSQLVariables(MissOfVar[I]);

  MissOfVar.Destroy;
end;

function TVASUPQuery.GetNoDefaultSQLVariable(AName : String) : Variant;
var
  Variable : TSQLVariable;
begin
  Variable := FAllNoDefaultSQLVariables.getVariable(AName);
  Result := NULL;
  if Assigned(Variable) then
    Result := Variable.Value;
end;

procedure TVASUPQuery.SetNoDefaultSQLVariable(AName : String; AValue : Variant);
var
  Variable : TSQLVariable;
  Mission  : String;
begin
  Variable := FAllNoDefaultSQLVariables.getVariable(AName, Mission);
  if Assigned(Variable) then
  begin
    if FAllNoDefaultSQLVariables.EnabledVars[Mission] then
      SetVariable(AName, AValue);
    Variable.Value := AValue;
  end;
end;

function TVASUPQuery.GetTypeOfNoDefaultSQLVariable(AName : String) : Integer;
var
  Variable : TSQLVariable;
begin
  Variable := FAllNoDefaultSQLVariables.getVariable(AName);
  Result := TSQLVariable.DefaultVariableType;
  if Assigned(Variable) then
    Result := Variable.VariableType;
end;

procedure TVASUPQuery.GetMissions(AMissions : TStrings);
var
  missOfVar : TStrings;
  I : Integer;
  Ind : Integer;
begin
  FBrockenSQL.GetAllKeys(AMissions);

  Ind := AMissions.IndexOf('');
  if Ind >= 0 then
    AMissions.Delete(Ind);

  missOfVar := TStringList.Create;

  FAllNoDefaultSQLVariables.GetAllKeys(missOfVar);
  for I := 0 to missOfVar.Count - 1 do
    if AMissions.IndexOf(missOfVar[I]) < 0 then
      AMissions.Add(missOfVar[I]);

  missOfVar.Destroy;
end;

function TVASUPQuery.ExistMission(AMission : String) : boolean;
begin
  Result := (FBrockenSQL.ExistKey(AMission) or FAllNoDefaultSQLVariables.ExistKey(AMission));
end;

procedure TVASUPQuery.DeleteMission(AMission : String);
begin
  FBrockenSQL.DeleteScriptForKey(AMission);
  DeleteNoDefaultSQLVariables(AMission);
end;

procedure TVASUPQuery.DeleteMissions;
var
  mission : TStrings;
  I : Integer;
begin
  mission := TStringList.Create;

  GetMissions(mission);
  for I := 0 to mission.Count - 1 do
    DeleteMission(mission[I]);

  mission.Destroy;
end;

procedure TVASUPQuery.AddMission(ASQLCode : TPartSQLCode; AMission : String);
var
  I : TSQLKeyWord;
  J : Integer;
  SQLCodeOfMiss : TPartSQLCode;

procedure CorrecNameVars(SQLCode : TPartSQLCode);
var
  nameVar : String;
  n : Integer;
  I : Integer;
  oldVar : String;
begin

  for I := 0 to SQLCode.CountVariable - 1 do
  begin
    oldVar := SQLCode.Variables[I].VariableName;

    // Проверяем у SQL кода сохраненного под ключом AMission имеется переменная oldVar
    if not ExistVariable(oldVar, AMission) then
    begin
      // Переменная oldVar не сохраннена в SQL коде, который сохранен под ключом AMission

      // Проверяем имеется ли обще переменная oldVar в SQL запросе
      if ExistVariable(oldVar)  then
      begin
        // Переменная  oldVar имеется в SQL запросе

        // У переменной DetailVars[I] меняем имя
        n := 0;
        nameVar := UniqueNameOfVariable(oldVar, n, n);
        while SQLCode.ExistVariable(nameVar) do
        begin
          Inc(n);
          nameVar := UniqueNameOfVariable(oldVar, n, n);
        end;
        SQLCode.ChangeVariable(oldVar, nameVar);
      end;
    end;
  end;
end;

begin
  SQLCodeOfMiss := TPartSQLCode.Create;
  SQLCodeOfMiss.Assign(ASQLCode);

  for I:= Low(TSQLKeyWord) to High(TSQLKeyWord) do
    if SQLCodeOfMiss.PartSQLCode[I] <> '' then
      FBrockenSQL.AddToArea(I, SQLCodeOfMiss.PartSQLCode[I], AMission);

  CorrecNameVars(SQLCodeOfMiss);

  for J := 0 to SQLCodeOfMiss.CountVariable - 1 do
    with SQLCodeOfMiss.Variables[J] do
    begin
      DeclareNoDefaultSQLVariable(VariableName, VariableType, AMission, Value);
    end;

  SQLCodeOfMiss.Destroy;
end;

procedure TVASUPQuery.SetMission(ASQLCode : TPartSQLCode; AMission : String);
begin
  DeleteMission(AMission);
  AddMission(ASQLCode, AMission);
end;

procedure TVASUPQuery.RefreshSQL;
begin
  if not (csDesigning in ComponentState) then
    FBrockenSQL.Compile(SQL);
end;

procedure TVASUPQuery.WorkWithMaster;
begin
  if Assigned(Master) and Master.Active
     and not Assigned(FMaster) then
  begin
    RegisterMasterVariables; // открытие с активным мастером в первый раз
    //with TBrockenSQL.Create(SQL) do
    //begin
    FBrockenSQL.AddToArea(WHERE,MasterLinkText, MASTER_DATASET);
    RefreshSQL;
      //Free;
    //end;
    FMaster:= Master;
  end;
  if not Assigned(Master) and Assigned(FMaster) and FMaster.Active then
  begin
    Master:= FMaster;
    RegisterMasterVariables;
  end;
  if Assigned(Master) and not Master.Active and
     not (csDesigning in ComponentState) then
  begin
    FMaster:= Master;
    Master:= nil;
    DropMasterVariables;
  end;
end;

procedure TVASUPQuery.AfterClosePro(DataSet: TDataSet);
begin
  AfterExecute;
  if not Assigned(Master) then
     Master:= FMaster;
  //DeleteTempVariables;
  //if Assigned(FMaster) then
    //DropMasterVariables;
  FMaster:= nil;
   if FLinkedQueries.DefferedDelIndex>=0 then
       FLinkedQueries.DefferedDelete;
  FLinkedQueries.ItemIndex:= FLinkedQueries.Count-1;
  //FExecuted:= false;
end;

procedure TVASUPQuery.Assign(Source: TPersistent);
begin
  if Source is TOracleDataSet then
    with Source as TOracleDataSet do
    begin
      Self.SQL.Text:= SQL.Text;
      Self.MasterFields:= MasterFields;
      Self.DetailFields:= DetailFields;
      Self.UpdatingTable:= UpdatingTable;
      Self.Session:= Session;
      Self.QueryAllRecords:= QueryAllRecords;
      Self.RefreshOptions:= RefreshOptions;
      MoveVariablesToSet(TOracleDataSet(Source),Self);
      if Source is TVASUPQuery then
        with Source as TVASUPQuery do
        begin
          Self.FUserSQLQuery.Assign(FUserSQLQuery);
          //Self.FAllUserSQLVariant.Assign(FAllUserSQLVariant);
        end;
      if Source is TVASUPQuery then
        with Source as TVASUPQuery do
        begin
          Self.ReActive:= ReActive;
          Self.Caption:= Caption;
          Self.Order:= Order;
          Self.EditorClassName:= EditorClassName;
          Self.ReportClassName:= ReportClassName;
          Self.AccessLevel:= AccessLevel;
        end;
    end;
end;

function TVASUPQuery.GetCencelling : boolean;
begin
  Result := FCancelling > 0;
end;

constructor  TVASUPQuery.Create(AOwner: TComponent);
begin
  FAfterQuery := nil;
  FWStyle:= wsNone;
  FMasterBookmark := '';
  FCurrentBookmark := '';
  FComebackRecord := true;
  FFoundedASUPBookmark := false;

  FRegisterForms := TList.Create;

  FCancelling := 0;
  FPosting    := false;

  FPreWorkState := wsNone;

  FChangingModeCommand := cuNone;

  FDataChanged := false;

  FUserCurrFiltered := true;

  inherited AfterQuery := AfterQueryPro;

  inherited Create(AOwner);

  FKeysOfFilters := TStringList.Create;

  //FWorkForm:= nil;
  FOrder:= '';
  FLib:= TVQLibrary.Create;
  FShieldSh:= false;
  FAcLevel:= alHost;
  FEditorClassName:= '';
  FReportClassName:= '';
  BeforeQuery:= BeforeQueryPro;
  if not Assigned(AfterClose) then
     AfterClose:= AfterClosePro;
  LockingMode:= lmLockImmediate;
  FIsQuery:= false;
  FLinkDetSQL:= false;
  FIsLinked:= false;
  FLinkedDetails:= TList.Create;
  FEmbSQLSlice:= TStringList.Create;
  FNoFullQuery:= false;
  FMaster:= nil;
  FLinkedQueries:= TLinkedQueryList.Create(Self);
  FLinkedQueries.Add(TLinkedQuery.Create);
  FLinkedQueries.Nodes[0].SelfIndex:= -1;
  FLinkedQueries.Nodes[0].SelfObj:= Self;
  FBOQ:= true;
  FEOQ:= true;
  FUpdTabAlias:= 'A';
  FRefreshing:= false;
  FLinkKind:= lkExists;
  FTreeNodeIndex:= 0;
  FTreeNodeIndexSync:= true;
  TreeNodeIndex:= -1;
  FDisplayRowCount:= 1;
  FAutoMaster:= true;
  //FDefferedDelIndex:= -1;
  FUserSQLQuery  := TPartSQLCode.Create;
  FUserSQLFilter := TPartSQLCode.Create;
  //FAllUserSQLVariant := TSQLVariables.Create(TSQLVariable);
  FAllNoDefaultSQLVariables := THashOfSQLVariables.Create;
  FBrockenSQL := TBrockenSQL.Create(SQL);

  FFoundedFields  := kfRowid;
end;

destructor TVASUPQuery.Destroy;
begin
  inherited;
  FKeyWords.Free;
  FLib.Free;
  FLinkedDetails.Free;
  FEmbSQLSlice.Free;
  FLinkedQueries.Free;
  FUserSQLQuery.Destroy;
  FUserSQLFilter.Destroy;
  FAllNoDefaultSQLVariables.Destroy;
  FBrockenSQL.Destroy;
  
  finalForms;
  FRegisterForms.Destroy;

  FKeysOfFilters.Destroy;
end;

procedure TVASUPQuery.NextViQuery;
begin
  if IndexQuery<FLinkedQueries.Count-1 then
  begin
    FLinkedQueries.Seek(IndexQuery+1);
    FBOQ:= IndexQuery<=0;
  end
  else
  begin
    FLinkedQueries.ClearZone;
    FEOQ:= true;
    FBOQ:= IndexQuery<0;  //Замена !!!
  end;
end;

procedure TVASUPQuery.LastViQuery;
begin
  FLinkedQueries.ItemIndex:= FLinkedQueries.Count-1;
  FLinkedQueries.ClearZone;
  FEOQ:= true;
  FBOQ:= IndexQuery<0;  //Замена !!!
end;

procedure TVASUPQuery.PriorViQuery;
begin
  if FLinkedQueries.Count = 0 then
    Exit;
  if IndexQuery>0 then
  begin
    {if not FEOQ then}
       FLinkedQueries.Seek(IndexQuery-1);
       FEOQ:= false;
    {else
    begin
      FLinkedQueries.Seek(IndexQuery);
      FEOQ:= false
    end;}
    FBOQ:= IndexQuery<= 0;
  end
  else
  begin
    FLinkedQueries.Seek(0);
    FBOQ:= true;
  end;
end;

procedure TVASUPQuery.DeleteQuery;
begin
  if IndexQuery>=0 then
    if not Deffered then
    begin
      {with FLinkedQueries.Nodes[IndexQuery] do
        if Count=0 then FLib.Delete(SelfIndex);}
      FLinkedQueries.Delete(IndexQuery);
    end
    else FLinkedQueries.DefferedDelIndex:= IndexQuery;
end;

procedure TVASUPQuery.SaveViQuery;
begin
  //if Assigned(FWorkForm) then
    FromScreen;
end;

function TVASUPQuery.GetEditorClass:TFormClass;
begin
  if Length(FEditorClassName)>0 then
    Result:= TFormClass(GetClass(FEditorClassName))
  else Result:= nil;
end;

function TVASUPQuery.GetReportClass:TFormClass;
begin
  if Length(FReportClassName)>0 then
    Result:= TFormClass(GetClass(FReportClassName))
  else Result:= nil;
end;

procedure TVASUPQuery.RegisterMasterVariables;
var
  VarText,VarBit: string;
  OracleType: Integer;
begin
  VarText:= DetailFields;
  Cut(';',VarText,VarBit);
  while Length(VarBit)>0 do
  begin
    case FieldByName(VarBit).DataType of
      ftString: OracleType:= otString;
      ftDateTime: OracleType:= otDate
      else OracleType:= otInteger
    end;
    //DeclareVariable(VarBit,OracleType);
    DeclareNoDefaultSQLVariable(VarBit, OracleType, MASTER_DATASET);
    Cut(';',VarText,VarBit);
  end;
end;

procedure TVASUPQuery.DropMasterVariables;
{var
  ShortName: string;
  I: Integer;
  VarStorage: TOracleQuery;}

begin
  DeleteNoDefaultSQLVariables(MASTER_DATASET);
  {VarStorage:= TOracleQuery.Create(Self);
  for I:= 0 to Variables.Count-1 do
  begin
    VarStorage.DeclareVariable( Variables.Data(I).Name,
                                Variables.Data(I).BufType);
    VarStorage.SetVariable( Variables.Data(I).Name,
                            GetVariable(Variables.Data(I).Name));
  end;
  DeleteVariables;
  for I:= 0 to VarStorage.Variables.Count-1 do
  begin
    ShortName:=Copy( VarStorage.Variables.Data(I).Name,2,
                     Length(VarStorage.Variables.Data(I).Name));
    if (ShortName<> DetailFields)
       and (Pos(ShortName+';',DetailFields)=0)
       and (Pos(';'+ShortName,DetailFields)=0) then
    begin
      DeclareVariable( VarStorage.Variables.Data(I).Name,
                        VarStorage.Variables.Data(I).BufType);
      SetVariable( VarStorage.Variables.Data(I).Name,
                   VarStorage.GetVariable(VarStorage.Variables.Data(I).Name));
    end;
  end;
  VarStorage.Free;}
end;

function TreeComp(Item1, Item2: Pointer): Integer;
begin
  Result:= TVASUPQuery(Item1).TreeNodeIndex-TVASUPQuery(Item2).TreeNodeIndex;
end;

procedure TVASUPQuery.SetTreeNodeIndex(AValue: Integer);
var
  I: Integer;
  DetailList: TList;
  ChildList: TList;
begin
  if FTreeNodeIndex<>AValue then
  begin
    if FTreeNodeIndexSync and not (csLoading in ComponentState) then
    begin
      if Assigned(Master) and (Master is TVASUPQuery) then
      with Master as TVASUPQuery do
      begin
        DetailList:= TList.Create;
        ChildList:= TList.Create;
        GetDetailList(DetailList);
        for I:= 0 to DetailList.Count-1 do
          if (DetailList[I]<>Self) and
             (TOracleDataSet(DetailList[I]).Master=Self.Master) and
             (TObject(DetailList[I]) is TVASUPQuery) then
          ChildList.Add(DetailList[I]);
        ChildList.Sort(@TreeComp);
        if AValue<0 then ChildList.Add(Self)
        else ChildList.Insert(AValue,Self);
        for I:= 0 to ChildList.Count-1 do
           TVASUPQuery(ChildList[I]).FTreeNodeIndex:= I;
        ChildList.Free;
        DetailList.Free;
      end
    end
    else FTreeNodeIndex:= AValue;
      DataEvent(dePropertyChange,0);
  end;
end;

procedure TVASUPQuery.TakeQueryVariables(AQuery: TOracleQuery);
var v: Integer;
    F: TField;
    VarName: string;
    VarValue: Variant;
begin
  // Get all variables for which there is a corresponding field in the dataset
  for v := 0 to AQuery.VariableCount - 1 do
  begin
    VarName := AQuery.VariableName(v);
    if VarName[1] = ':' then System.Delete(VarName, 1, 1);
    // Find the field
    F := FindField(VarName);
    // If found and not a BLOB
    if (F <> nil) and not F.IsBlob then
    begin
      // Get the variable value
      VarValue := AQuery.GetVariable(VarName);
      // If different from the field value, set the field value
     { if not CompareFieldToVariant(F, VarValue) then
      begin
        OldState := SetTempState(dsNewValue);}
        //try
          if VarIsNull(VarValue) or VarIsEmpty(VarValue) then
            F.Clear
          else begin
            {if F.DataType = ftString then
              F.Value := TrimString(VarValue)
            else}
              F.Value := VarValue;
          end;
        {finally
          RestoreState(OldState);
        end;
      end;  }
    end;
  end;
end;

function TVMyTable.GetEditorClass:TFormClass;
begin
  if Length(FEditorClassName)>0 then
    Result:= TFormClass(GetClass(FEditorClassName))
  else Result:= nil;
end;

function TVMyTable.GetReportClass:TFormClass;
begin
  if Length(FReportClassName)>0 then
    Result:= TFormClass(GetClass(FReportClassName))
  else Result:= nil;
end;

function TVASUPQuery.IRefreshRecord(AQuery: TOracleQuery):boolean;
begin
  Result:= InternalRefreshRecord(AQuery,nil);
end;

procedure TVASUPQuery.GetSQLDescription(Index: Integer; SQLDescription:TTreeSQLDescription);
var
  I: Integer;
begin
  with FLinkedQueries do
  begin
    if (Index>=0) and (Index<Count) then
    with Nodes[Index] as TLinkedQuery do
    begin
      SQLDescription.Caption:= SelfObj.Caption;
      if (SelfIndex>=0) then
        SQLDescription.Text:= SelfObj.FLib[SelfIndex].SQLDescription
      else SQLDescription.Text:= '';
      for I:= 0 to Count-1 do
      begin
        SQLDescription.Add(TTreeSQLDescription.Create);
        Nodes[I].Obj.GetSQLDescription(Nodes[I].Index,
          SQLDescription[SQLDescription.Count-1]);
      end;
    end
    else
    begin
      SQLDescription.Caption:= Caption;
      SQLDescription.Text:= '';
    end;
  end;
end;

function TVASUPQuery.GetNameMissionDetailQuery(Detail : TDataSet) : String;
begin
  Result := DETAIL_USER_QUERY + IntToStr(Integer(Detail));
end;

{ * TOrderProperty}
{
procedure TOrderProperty.Edit;
var
  Dial: TfmSort;
  Query: TVASUPQuery;
begin
  if GetComponent(0) is TVASUPQuery then begin
    Query:= GetComponent(0) as TVASUPQuery;
    Screen.Cursor:= crSQLWait;
    try
      if not Query.Active then Query.Open;
      Dial:= TfmSort.Create(nil);
      Query.Order:= GetValue;
      Dial.QRY:= Query;
      Dial.ShowModal;
    finally
      Screen.Cursor:= crDefault;
      Query.Close;
    end;
  end;
end;
}{
function TOrderProperty.GetAttributes;
begin
  Result:= [paDialog];
end;

function TOrderProperty.GetValue;
begin
  with GetComponent(0) as TVASUPQuery do Result:= Order;
end;

procedure TOrderProperty.SetValue;
begin
  with GetComponent(0) as TVASUPQuery do Order:= Value;
end;
}
{ * TVBuilder }

procedure TVBuilder.SetAct;
begin
  if Value and not FAction
  and (csDesigning in ComponentState) then Building ;
  FAction:= Value;
end;

procedure TVBuilder.Building;
var
  I: Integer;
begin
  for I:= 0 to Owner.ComponentCount-1 do
    if Owner.Components[I] is TVASUPQuery then
    with Owner.Components[I] as TVASUPQuery do
      if Length(UpdatingTable)>0 then
      begin
        ReActive:= false;
        Active:= true;
        Active:= false;
        ReActive:= true;
      end;
end;

{ * TVDBERus }

function TVDBERus.InLaw;
begin
  if not FRusWall then Result:= true
  else case Key of
    'a'..'z','A'..'Z':Result:= false
    else Result:= true;
  end;
end;

procedure TVDBERus.SafePress;
begin
  with KP do begin
    if (Chr(CharCode) in [^X,^V,^C]) or InLaw(Chr(CharCode)) then inherited
    else MessageBeep(0);
  end
end;

procedure ReplaceKeyboardLayOut(var LastKL: HKL; NewLName:PChar);
var
  new: HKL;
  LayoutName : Array [0..KL_NAMELENGTH] of Char;
begin
   GetKeyboardLayoutName(@LayoutName);
   LastKL:= LoadKeyboardLayout(@LayoutName, KLF_ACTIVATE);
   new:=LoadKeyboardLayout(NewLName, KLF_ACTIVATE);
   ActivateKeyboardLayout(new,0);
end;

procedure TVDBERus.CMEnter(var Message: TCMEnter);
begin
  if Enabled and FAutoSwitch then
    if FRusWall then
      ReplaceKeyboardLayOut(FLayOut,CyrLayout)
    else ReplaceKeyboardLayOut(FLayOut,USLayout);
  inherited;
end;

procedure TVDBERus.CMExit(var Message: TCMExit);
begin
  if Enabled and FAutoSwitch then
    ActivateKeyboardLayout(FLayOut,0);
  inherited;
end;

constructor TVDBERus.Create;
begin
  inherited Create(AOwner);
  FRusWall:= true;
  FAutoSwitch:= true;
  if not (csDesigning in ComponentState) then
  begin
    with FPopa do
    begin
      {Items[Ord(piLess)].Visible:= false;
      Items[Ord(piNotLess)].Visible:= false;
      Items[Ord(piMore)].Visible:= false;
      Items[Ord(piNotMore)].Visible:= false;}
      Items[Ord(piInto)].Visible:= false;
    end;
    DefaultState:= piLike;
  end;
end;

{ TVDBEDate }

constructor TVDBEDate.Create;
begin
  inherited;
  FInitDate:= Date;
  if not (csDesigning in ComponentState) then
  with FPopa do
  begin
    Items[Ord(piLike)].Visible:= true;
    Items[Ord(piNotLike)].Visible:= true;
  end;
end;

procedure TVDBEDate.EditButtonClick(Sender: TObject);
var
  ByDefault: boolean;
begin
  inherited;
  ByDefault:= not Assigned(FClickEvent);
  if Assigned(FClickEvent) then FClickEvent(Self,ByDefault);
  if ByDefault then
  begin
    ShowCalendarBody;
  end;
end;

procedure TVDBEDate.ShowCalendarBody;
var
  StartDate: TDateTime;
begin
  if not Field.IsNull then StartDate:= Field.AsDateTime
  else StartDate:= FInitDate;
  if not ReadOnly and not Field.ReadOnly
     and PopupDate(StartDate,Self) then
  begin
    if (DataSource.State in [dsInsert,dsEdit]) then DataSource.Edit;
    Field.AsDateTime:= StartDate;
    Modified:= true;
    //Change;
    SetFocus;
  end;
end;

procedure TVDBEDate.WMLBUTTONDBLCLK(var Message: TWMMouse);
begin
  inherited;
  if (FState<> piInto)
     and not (Message.Keys and MK_CONTROL=MK_CONTROL) then ShowCalendarBody;
end;

procedure TVDBEDate.WMKEYDOWN(var Message: TWMKey);
begin
  inherited;
  if Message.CharCode= VK_SPACE then
     ShowCalendarBody;
end;

procedure TVDBEDate.SetInitDate(Value: TDateTime);
begin
  FInitDate:= Value;
end;

function TManuals.Add;
begin
  Result:= AddEx(AName,CDEFAULTKEY,CDEFAULTCONTEXT);
end;

function TManuals.AddEx;
var
  PManual: TPManual;
begin
  New(PManual);
  with PManual^ do begin
    Name:= AName;
    Key:= AKey;
    Context:= AContext;
  end;
  Result:= inherited Add(PManual);
end;

procedure TManuals.Delete;
var
  PManual: TPManual;
begin
  PManual:= Items[Index];
  Dispose(PManual);
  inherited Delete(Index);
end;

procedure TManuals.Clear;
var
  I: Integer;
begin
  for I:= Count-1 downto 0 do Delete(I);
end;

function TManuals.GetSlice;
begin
  Result:= TPManual(Items[Index])^;
end;

destructor TManuals.Destroy;
begin
  Clear;
  inherited;
end;

{* TDataSets *}

constructor TDataSets.Create;
begin
  FOwner:= AOwner;
  inherited Create(TCollectionDataSet);
end;

function  TDataSets.IndexOf(ADataSet: TDataSet):Integer;
var
  I: Integer;
begin
  Result:= -1;
  I:= 0;
  while (I<Count) and (Result<0) do
    if (Items[I] as TCollectionDataSet).DataSet=ADataSet then Result:= I
    else Inc(I);
end;

function TDataSets.GetItem;
begin
  Result:= inherited Items[Index] as TCollectionDataSet;
end;

procedure TDataSets.Assign(Source: TPersistent);
var
  I: Integer;
  NewItem: TCollectionDataSet;
begin
  if Source is TStrings then
  begin
    Clear;
    for I:= 0 to TStrings(Source).Count-1 do
    begin
      NewItem:= TCollectionDataSet(Add);
      NewItem.DataSetName:= TStrings(Source)[I];
      if TStrings(Source).Objects[I] is TDataSet then
        NewItem.DataSet:= TDataSet(TStrings(Source).Objects[I])
      else NewItem.DataSet:= nil
    end
  end
  else if Source is TDataSets then
  begin
    Clear;
    for I:= 0 to TDataSets(Source).Count-1 do
    begin
      NewItem:= TCollectionDataSet(Add);
      NewItem.DataSetName:= TDataSets(Source).Items[I].DataSetName;
      NewItem.DataSet:= TDataSets(Source).Items[I].DataSet;
    end;
  end
  else inherited;
end;

{* TVMetaDataSource *}

procedure HideNonVisibleFields(ADataSet:TDataSet);
var
  I: Integer;
begin
  with ADataSet do
    for I:= 0 to FieldCount-1 do
      if not (Fields[I].Tag and VISIBLE_FIELDTAG=VISIBLE_FIELDTAG)
         and Fields[I].Visible then Fields[I].Visible:= false;
end;

procedure ShowNonVisibleFields(ADataSet:TDataSet);
var
  I: Integer;
begin
  with ADataSet do
  begin
    for I:=0 to FieldCount-1 do
    if not (Fields[I].Tag and FOREVER_HIDING_FIELDTAG = FOREVER_HIDING_FIELDTAG) then
    begin
      if Fields[I].Visible and
         not (Fields[I].Tag and VISIBLE_FIELDTAG=VISIBLE_FIELDTAG) then
         Fields[I].Tag:= Fields[I].Tag+VISIBLE_FIELDTAG;
      Fields[I].Visible:= true;
    end;
    if not (Tag and DIRECT_ACCESS_FLAG=DIRECT_ACCESS_FLAG) then
      Tag:= Tag + DIRECT_ACCESS_FLAG;
  end;
end;

procedure TVMetaDataSource.Notification( AComponent: TComponent;
                                        Operation: TOperation);
var
  DelIndex: Integer;
  I: Integer;
  ItemList: TStringList;
begin
  if csDesigning in ComponentState then
    if (Operation= opRemove) and (AComponent is TDataSet) then
    with FSets do
    begin
      DelIndex:= IndexOf(TDataSet(AComponent));
      if DelIndex>=0 then
      begin
        ItemList:= TStringList.Create;
        for I:= 0 to Count-1 do
          if I<> DelIndex then ItemList.AddObject(Items[I].DataSetName,Items[I].DataSet);
        BeginUpdate;
        Clear;
        for I:= 0 to ItemList.Count-1 do
          with TCollectionDataSet(Add) do
          begin
            DataSetName:= ItemList[I];
            DataSet:= TDataSet(ItemList.Objects[I]);
          end;
        EndUpdate;
        ItemList.Free;
      end;
    end;
end;

procedure TVMetaDataSource.Close;
var
  I: Integer;
begin
  for I:= SelectedIndex downto 0 do
  begin
    if (Items[I].Tag and DIRECT_ACCESS_FLAG)= DIRECT_ACCESS_FLAG then
    begin
      HideNonVisibleFields(Items[I]);
      Items[I].Tag:= Items[I].Tag - DIRECT_ACCESS_FLAG;
    end;
    Items[I].Close;
  end;
end;

procedure TVMetaDataSource.SetDataSetList;
begin
  FSets.Assign(Value);
end;

procedure TVMetaDataSource.SetIndex;
begin
  if Value in [0..FSets.Count-1] then
  begin
    if Assigned(DataSet) then  DataSet.Close;
    DataSet:= Items[Value];
    FIndex:= Value;
    if Assigned(FOnMetaChanging) then FOnMetaChanging(Items[Value],Value);
    DataSet.DisableControls;
    if DataSet.Active then DataSet.Close;
    if DataSet is TVASUPQuery then
      (DataSet as TVASUPQuery).Execute
    else DataSet.Open;
    DataSet.EnableControls;
    if Assigned(FOnMetaChange) then FOnMetaChange(DataSet,FIndex);
  end
  else FIndex:= -1;
end;

function TVMetaDataSource.GetItem(Index: Integer): TDataSet;
begin
  Result:= (FSets.Items[Index] as TCollectionDataSet).DataSet;
end;

function TVMetaDataSource.GetCount:Integer;
begin
  Result:= FSets.Count;
end;

procedure TVMetaDataSource.Next;
begin
  if FIndex<FSets.Count-1 then
  begin
    Inc(FIndex);
    DataSet:= Items[FIndex];
    DataSet.DisableControls;
    if DataSet.Active then DataSet.Close;
    DataSet.Open;
    DataSet.EnableControls;
    if Assigned(FOnMetaChange) then FOnMetaChange(DataSet,FIndex);
  end;
end;

procedure TVMetaDataSource.Prior;
begin
  if FIndex>0 then
  begin
    if Assigned(DataSet) then DataSet.Close;
    Dec(FIndex);
    DataSet:= Items[FIndex];
    if Assigned(FOnMetaChange) then FOnMetaChange(DataSet,FIndex);
  end;
end;

procedure TVMetaDataSource.Start;
begin
  SelectedIndex:= 0;
end;

procedure TVMetaDataSource.AddToList;
var
  NewItem: TCollectionDataSet;
begin
  if Assigned(ADataSet) then
  begin
    NewItem:= FSets.Add as TCollectionDataSet;
    NewItem.DataSetName:= ADataSet.Name;
    NewItem.DataSet:= ADataSet;
  end;
end;

function TVMetaDataSource.BOL:boolean;
begin
  Result:= (FIndex<1) or not Items[FIndex-1].Active;
end;

function TVMetaDataSource.EOL:boolean;
begin
  Result:= FIndex=FSets.Count-1;
end;

function TVMetaDataSource.PathToDataSet(const DisplayFieldName: string):string;
var
  I: Integer;
begin
  Result:= '';
  I:= SelectedIndex-1;
  while (I>=0) and Items[I].Active do
  begin
    Result:= Concat(Items[I].FieldByName(DisplayFieldName).AsString,
                    PATH_SEPARATOR,
                    Result);
    Dec(I);
  end;
  if not Items[0].Active then
   Result:= Concat(ROOT_SYMBOL,PATH_SEPARATOR,Result);
end;

procedure TVMetaDataSource.DirectMove(Index: Integer);
var
  I: Integer;
begin
  if Index<0 then Index:= 0
  else if Index>=FSets.Count then Index:= FSets.Count-1;
  if Index in [0..FSets.Count-1] then
  begin
    for I:= SelectedIndex downto 0 do
    begin
      if (Items[I].Tag and DIRECT_ACCESS_FLAG)= DIRECT_ACCESS_FLAG then
      begin
        HideNonVisibleFields(Items[I]);
        Items[I].Tag:= Items[I].Tag - DIRECT_ACCESS_FLAG;
      end;
      Items[I].Close;
    end;
    {if Index>0 then} ShowNonVisibleFields(Items[Index]);
    SelectedIndex:= Index;
  end;
end;

constructor TVMetaDataSource.Create;
begin
  inherited Create(AOwner);
  FSets:= TDataSets.Create(Self);
  FIndex:= -1;
end;

destructor TVMetaDataSource.Destroy;
begin
  FSets.Free;
  inherited;
end;

constructor TVEditFormID.Create;
var
 I: Integer;
 GoOut: bool;
begin
  I:= 0;
  GoOut:= false;
  with AOwner do
    while (I<ComponentCount) and  not GoOut do begin
      GoOut:= Components[I] is TVEditFormID;
      Inc(I);
    end;
  if GoOut then raise Exception.Create(CManyIDs)
  else begin
    inherited;
    Name:= CDefaulIDName;
    if Owner is TForm then
    begin
      FFormClass:= TFormClass(Owner.ClassType);
      FFormClassName:= Owner.Name
    end
    else
    begin
      FFormClass:= nil;
      FFormClassName:= '';
    end;
    I:= 0;
    while (I<Owner.ComponentCount) and
          ((FDataSource=nil) or (FPanel=nil)) do
    begin
      if Owner.Components[I] is TDataSource then
        FDataSource:= Owner.Components[I] as TDataSource
      else if Owner.Components[I] is TPanel then
        if (Owner.Components[I] as TPanel).Visible then
          FPanel:= Owner.Components[I] as TPanel;
      Inc(I);
    end;
  end;
end;

procedure TVEditFormID.Assign(Source : TPersistent);
begin
  if Source is TVEditFormID then
  begin
    FFormClass:= (Source as TVEditFormID).FormClass;
    if Assigned((Source as TVEditFormID).Owner) then
      FFormClassName:= (Source as TVEditFormID).Owner.Name
    else  FFormClassName:= '';
  end
  else
  begin
    FFormClass:= nil;
    FFormClassName:= '';
  end;
end;

procedure TVASUPQuery.SetAccessLevel(AAcLevel : TAccessLevel);
begin
  FAcLevel := AAcLevel;
end;

function TVASUPQuery.UniqueNameOfVariable(AName : String) : String;
var
  J : Integer;
begin
  Result:= UniqueNameOfVariable(AName, 0, J);
end;

function TVASUPQuery.UniqueNameOfVariable(AName : String; suffix : Integer; var newsuffix : Integer) : String;
var
  I : Integer;
  pref : String;
  VarName : String;
begin
  pref := TempVarHeader+UpperCase(AName)+'_';

  I := suffix;
  VarName := pref + IntToStr(I);
  while ExistVariable(VarName) do
  begin
    Inc(I);
    VarName := pref + IntToStr(I);
  end;

  Result:= VarName;
  newsuffix := I
end;

function TVASUPQuery.ExistVariable(AVar : String) : boolean;
begin
  Result := (VariableIndex(AVar) >= 0) or
         Assigned(FAllNoDefaultSQLVariables.getVariable(AVar));
end;

function TVASUPQuery.ExistVariable(AVar : String; AMission : String) : boolean;
var
  vars : TSQLVariables;
begin
  vars := FAllNoDefaultSQLVariables.GetSQLVariables(AMission);

  Result := Assigned(vars);
  if Result then
    Result := (vars.NameToIndex(AVar) >= 0);
end;

function TVASUPQuery.GetVariables(AKey : String) : TSQLVariables;
begin
  Result := FAllNoDefaultSQLVariables.GetSQLVariables(AKey);
end;

procedure TVASUPQuery.GetAttrVarOfField(AField : TField; var AVarType : Integer; var AVarName : String);
begin
  AVarName := UniqueNameOfVariable(UpperCase(AField.DataSet.Name)+'_'+IntToStr(AField.Index));
  case AField.DataType of
    ftString: AVarType:= otString;
    ftDateTime: AVarType:= otDate;
    ftFloat: AVarType:= otFloat;
    else AVarType:= otInteger
  end;
end;

function TVASUPQuery.CanRefresh : boolean;
var
  DetailList : TList;
  I : Integer;
begin
  DetailList := TList.Create;
  GetDetailList(DetailList);
  DetailList.Insert(0,Self);

  result := true;
  for I := 0 to DetailList.Count - 1 do
    if TDataSet(DetailList[I]).State in [dsEdit, dsInsert] then
    begin
      Result := false;
      break;
    end;

  DetailList.Destroy;
end;

procedure TVASUPQuery.Cancel;
var
  DetailList: TList;
  I : Integer;
  PreWStyle : TWStyle;
begin
  inc(FCancelling);
  DetailList:= TList.Create;


  try
    GetDetailList(DetailList);

    for I:= DetailList.Count-1 downto 0 do
      with TObject(DetailList[I]) as TDataSet do
      begin
        if (TObject(DetailList[I]) is TOracleDataSet) and
           TOracleDataSet(DetailList[I]).CachedUpdates then
          TOracleDataSet(DetailList[I]).CancelUpdates
        else if State in [dsInsert,dsEdit] then
          Cancel;
      end;

    inherited Cancel;

    PreWStyle := FWStyle;
    if not Active then
      FWStyle := wsNone
    else
      FWStyle := wsView;

  finally
    DetailList.Destroy;
    CheckWorkState;
    if PreWStyle <> FWStyle then
      AfterChangeWorkState;
    dec(FCancelling);
  end;
end;

procedure TVASUPQuery.SetWorkState(AWorkState : TWStyle);
var
  PredQuery : boolean; // Предыдущий режим был режимом запроса
  PreWStyle : TWStyle;
begin
  //if AWorkState <> FWStyle then
  //begin
    if IsQuery then
      // Предыдущий режим был режимом запроса
      PredQuery := true
    else
      // Предыдущий режим не был режимом запроса
      PredQuery := false;

    if IsQuery and (AWorkState <> wsQuery) and (not ReadOnly) then
    begin
      CloseViSession;
      OracleDictionary.EnforceConstraints:= true;
    end;

    case AWorkState of
      wsQuery : if (FWStyle <> wsQuery) and (not ReadOnly) then
                begin
                  Cancel;
                  ClearCurrRecBookmarks;
                  if not Active then Open;
                  OracleDictionary.EnforceConstraints:= false;
                  OpenViSession;
                end;
      wsView  : begin
                  Cancel;
                  if not Active then Open;

                  // Если предыдущий режим был режимом запроса,
                  // то устанавливаем курсор на первую запись
                  if PredQuery then
                    First;
                end;
      wsAdd   : if State <> dsInsert then
                begin
                  Cancel;
                  Insert;
                end;
      wsEdit  : if State <> dsEdit then
                begin
                  Cancel;
                  Edit;
                end;
      wsNone  : Close;
      wsDelete: Cancel;
    end;
  //end;
  PreWStyle := FWStyle;
  FWStyle := AWorkState;
  CheckWorkState;
  if PreWStyle <> FWStyle then
    AfterChangeWorkState;
end;

procedure TVASUPQuery.Post;
var
  PreWStyle : TWStyle;
begin
  FPosting := true;
  try
    inherited;
  finally
    if not DataModified then
    begin
      PreWStyle := FWStyle;
      FWStyle := wsView;
      CheckWorkState;
      if PreWStyle <> FWStyle then
        AfterChangeWorkState;
    end;
    FPosting := false;
  end;
end;

procedure TVASUPQuery.SetActive(Value: Boolean);
var
  Actived : boolean;
  PreWStyle : TWStyle;
begin
  if Active and (not Value) then
    SaveCurrRecBookmark;
  Actived := Active;

  inherited SetActive(Value);
  PreWStyle := FWStyle;
  if Active then
    FWStyle := wsView
  else
    FWStyle := wsNone;
  CheckWorkState;
  if PreWStyle <> FWStyle then
    AfterChangeWorkState;

  if (not Actived) and Active then
    SetCurrRecBookmark;
end;

procedure TVASUPQuery.SetFoundedFields(AFields : TKindFields);
begin
  FFoundedFields := AFields;
end;

procedure TVASUPQuery.SetComebackRecord(AComeback : boolean);
begin
  FComebackRecord := AComeback;
end;

procedure TVASUPQuery.ClearCurrRecBookmark;
begin
  FMasterBookmark  := '';
  FCurrentBookmark := '';
end;

procedure TVASUPQuery.ClearCurrRecBookmarks;
var
  DetailList : TObjectList;
  I : Integer;
begin
  ClearCurrRecBookmark;

  DetailList := TObjectList.Create(false);
  GetDetailDataSets(DetailList);
  for I := 0 to DetailList.Count - 1 do
    if DetailList[I] is TVASUPQuery then
      TVASUPQuery(DetailList[I]).ClearCurrRecBookmark;
  DetailList.Destroy;
end;

procedure TVASUPQuery.SaveCurrRecBookmark;
begin
  if Assigned(Master) and (Master.Active) then
  begin
    if Master is TVASUPQuery then
      FMasterBookmark := TVASUPQuery(Master).ASUPBookmark
    else
      FMasterBookmark := Master.Bookmark;
  end
  else
    FMasterBookmark := '';

  FCurrentBookmark := ASUPBookmark;
end;

procedure TVASUPQuery.SetCurrRecBookmark;
begin
  if ComebackRecord and (FCurrentBookmark <> '') and
     ((not Assigned(Master)) or
      ((Master is TVASUPQuery) and
       (TVASUPQuery(Master).CompareASUPBookmarks(TVASUPQuery(Master).ASUPBookmark, FMasterBookmark) = 0)
      ) or
      ((not (Master is TVASUPQuery))  and
       (Master.CompareBookmarks(Pointer(Master.Bookmark), Pointer(FMasterBookmark)) = 0)
      )
     ) then
    ASUPBookmark := FCurrentBookmark
  else
    // Установка курсора на прежние место закончилась неудачей
    FFoundedASUPBookmark := false;
end;

function TVASUPQuery.GetRegistForm(Ind : Integer) : TForm;
begin
  if (Ind >= 0) and (Ind < FRegisterForms.Count) then
    Result := TfmASUPForm(FRegisterForms[Ind])
  else
    Result := nil;
end;

function TVASUPQuery.GetRegistFormCount : Integer;
begin
  Result := FRegisterForms.Count;
end;

procedure TVASUPQuery.RegisterForm(AForm : TForm);
begin
  if Assigned(AForm) and (AForm is TfmASUPForm) and (FRegisterForms.IndexOf(AForm) < 0) then
    FRegisterForms.Add(AForm);
end;

procedure TVASUPQuery.AnulRegisterForm(AForm : TForm);
begin
  FRegisterForms.Remove(AForm);
end;

procedure TVASUPQuery.finalForms;
var
  I : Integer;
begin
  for I := 0 to FRegisterForms.Count - 1 do
    TfmASUPForm(FRegisterForms[I]).AnulRegisterASUPQuery(Self);
end;

function TVASUPQuery.IsControlForm(AForm : TForm) : boolean;
begin
  result := IsFormWithWorkStyle(AForm);
end;

procedure TVASUPQuery.DataEvent(Event: TDataEvent; Info: Longint);
var
  I : Integer;
begin
  if (Event = deCheckBrowseMode) // Идет ли проверка необходимости постить или отменять изменения данных
    // and (not CachedUpdates)
  then
  begin
    for I := 0 to RegistFormCount - 1 do
      TfmASUPForm(RegistForms[I]).CheckBrowseMode(Self);

    if DataModified // Были ли данные измены
       and (not IsQuery)           // Сейчас ли любой режим, кроме режима редактирования
       and (not ((FCancelling > 0) or FPosting)) // Не работает ли сейчас процессы ни Post ни Cancel
       and (State in dsEditModes)
       then
    begin
      case ChangingModeCommand of
        cuPost   : begin
                     for I := 0 to RegistFormCount - 1 do
                     begin
                       // предлагаем формам сохранить самостоятельно изменения
                       TfmASUPForm(RegistForms[I]).SaveChangeWorkState(Self);
                       if DataModified then
                         // Изменения данных были сохранены
                         break;
                     end;
                     if DataModified  then
                       // Изменения данных не были сохранены
                       // СОхраняем методом Post
                       Post;
                   end;
        cuCancel : begin
                     for I := 0 to RegistFormCount - 1 do
                     begin
                       // предлагаем формам отменить самостоятельно изменения данных
                       TfmASUPForm(RegistForms[I]).CancelChangeWorkState(Self);
                       if not DataModified  then
                         // Изменения данных были сохранены
                         break;
                     end;
                     if DataModified  then
                       // Изменения данных не были отменены
                       // Отменяем методом Cancel
                       Cancel;
                   end;
        else
        begin
          for I := 0 to RegistFormCount - 1 do
          begin
            // предлагаем формам либо сохранить либо отменить изменения
            TfmASUPForm(RegistForms[I]).ApplyDataSaves(Self);
            if not DataModified then
              // Изменения данных были либо сохранены либо отменены
              break;
          end;
          if DataModified then
            // Изменения данных не были ни сохранены ни отменены
          raise ECursorCanNotMoveAboutRecord.Create('Невозможно перейти на другую запись');
        end;
      end;
    end;
  end;

  inherited DataEvent(Event, Info);
end;

procedure TVASUPQuery.AfterChangeWorkState;
var
  I : Integer;
begin
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).ChangeASUPQueryWorkState(Self);
  if Assigned(FOnChangeWorkState) then
    FOnChangeWorkState(Self);
end;

procedure TVASUPQuery.DoAfterScroll;
var
  I : Integer;
begin
  inherited;
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoAfterScroll(Self);
end;

procedure TVASUPQuery.DoBeforeScroll;
var
  I : Integer;
begin
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoBeforeScroll(Self);
  inherited;
end;

procedure TVASUPQuery.DoAfterPost;
var
  I : Integer;
begin
  inherited;
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoAfterPost(Self);
end;

procedure TVASUPQuery.DoBeforePost;
var
  I : Integer;
begin
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoBeforePost(Self);
  inherited;
end;

procedure TVASUPQuery.DoAfterCancel;
var
  I : Integer;
begin
  inherited;
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoAfterCancel(Self);
end;

procedure TVASUPQuery.DoBeforeCancel;
var
  I : Integer;
begin
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoBeforeCancel(Self);
  inherited;
end;

procedure TVASUPQuery.DoAfterClose;
var
  I : Integer;
begin
  inherited;
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoAfterClose(Self);
end;

procedure TVASUPQuery.DoBeforeClose;
var
  I : Integer;
begin
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoBeforeClose(Self);
  inherited;
end;

procedure TVASUPQuery.DoBeforeEdit;
var
  I : Integer;
begin
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoBeforeEdit(Self);
  inherited;
end;

procedure TVASUPQuery.DoBeforeDelete;
var
  I : Integer;
begin
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoBeforeDelete(Self);
  inherited;
end;

procedure TVASUPQuery.DoBeforeInsert;
var
  I : Integer;
begin
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoBeforeInsert(Self);
  inherited;
end;

procedure TVASUPQuery.DoAfterOpen;
var
  I : Integer;
begin
  inherited;
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoAfterOpen(Self);
end;

procedure TVASUPQuery.DoBeforeOpen;
var
  I : Integer;
begin
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoBeforeOpen(Self);
  inherited;
end;

procedure TVASUPQuery.DoAfterRefresh;
var
  I : Integer;
begin
  inherited;
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoAfterRefresh(Self);
end;

procedure TVASUPQuery.DoBeforeRefresh;
var
  I : Integer;
begin
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoBeforeRefresh(Self);
  inherited;
end;

function TVASUPQuery.MyDataModified : boolean;
var
  I : Integer;
begin
  Result := false;
  if IsQuery  then
    Exit;

  if CachedUpdates then
    // В случае, когда изменения записываются в кэш, а не в БД,
    // то проверить были ли изменения данных не сохранных в БД можно только
    // по флажку изменения данных
    Result := FDataChanged;

  if not Result then
  begin
    case State of
      dsEdit   : begin
                   I := 0;
                   while not Result and (I<FieldCount) do
                   begin
                     if Fields[I].FieldKind= fkData then
                       Result:= Fields[I].OldValue<>Fields[I].Value;
                     Inc(I);
                   end;
                 end;
      dsInsert : Result := not NoDataInserting(Self);

    end;
  end;

end;

function TVASUPQuery.DetailDataModified : boolean;
var
  DetailList : TList;
  Detail : TDataSet;
  I, J : Integer;
begin
  DetailList := TList.Create;
  try
    GetDetailList(DetailList);

    I := 0;
    Result := false;
    while (not Result) and (I<DetailList.Count) do
    begin
      Detail := TObject(DetailList[I]) as TDataSet;
      if Detail is TVASUPQuery then
        Result := TVASUPQuery(Detail).DataModified
      else
        with Detail do
          case State of
            dsEdit  : begin
                       J := 0;
                        while not Result and (J<FieldCount) do
                        begin
                          if Fields[J].FieldKind= fkData then
                            Result:= Fields[J].OldValue<>Fields[J].Value;
                          Inc(J);
                        end;
                      end;
            dsInsert : Result := not NoDataInserting(Detail);
          end;
      Inc(I);
    end;
  finally
    DetailList.Destroy;
  end;
end;

function TVASUPQuery.DataModified : boolean;
var
  I : Integer;
begin
  Result := MyDataModified or DetailDataModified;
  for I := 0 to RegistFormCount - 1 do
      TfmASUPForm(RegistForms[I]).DataModified(Result);
  if Assigned(FModifiedASUPQuery) then
    FModifiedASUPQuery(Self, Result);
end;

function TVASUPQuery.NoDataInserting(DataSet:TDataSet):bool;
var
  Strs : TStrings;
  DtlFields : Array of TField;
  I : Integer;
begin
  Strs := TStringList.Create;
  try
    if DataSet is TOracleDataSet then
      StringToStringsWithSemicolon(TOracleDataSet(DataSet).DetailFields, Strs);
    if Strs.Count > 0 then
    begin
      SetLength(DtlFields, Strs.Count);
      for I := 0 to Strs.Count - 1 do
        DtlFields[I] := DataSet.FindField(Strs[I]);
      Result:= IsEmptyRecord(DataSet,DtlFields);
    end
    else
      Result:= IsEmptyRecord(DataSet,[nil]);
  finally
    Strs.Destroy;
  end;
end;

procedure TVASUPQuery.AfterQueryPro(Sender : TOracleDataSet);
begin
  // Изменения данных были либо сохранены на сервере, либо отменены
  ResetCacheDataChanged;


  if Assigned(FAfterQuery) then
    FAfterQuery(Sender);
end;

procedure TVASUPQuery.InternalPost;
begin
  // Данные были изменены
  FDataChanged := FDataChanged or DataModified or (State = dsInsert);

  inherited;
end;

procedure TVASUPQuery.InternalDelete;
begin
  // Данные были изменены
  FDataChanged := true;

  inherited;
end;

procedure TVASUPQuery.SetAfterQuery(AEvent : TOracleDataSetEvent);
var
  ParentEvent : TOracleDataSetEvent;
  Ev : TOracleDataSetEvent;
begin
  FAfterQuery := AEvent;

  ParentEvent := inherited AfterQuery;

  // Проверяем, не произошел ли сброс родительского события AfterQuery
  // Это могло произойти, если новое событие AfterQuery присвоили следующим образом
  // TOracleDataSet(объект класса TVASUPQuery).AfterQuery := новое событие
  Ev := AfterQueryPro;
  if ((Pointer(@ParentEvent)) <> (Pointer(@Ev))) or
     (Pointer(PPointer(PChar(@@ParentEvent) + 4)^) <> Pointer(PPointer(PChar(@@Ev) + 4)^)) then
    ParentEvent := AfterQueryPro;
end;

procedure TVASUPQuery.ResetCacheDataChanged;
begin
  FDataChanged := false;
end;

procedure TVASUPQuery.ResetDetailCacheDataChanged;
var
  DetailList: TList;
  I : Integer;
begin
  DetailList:= TList.Create;
  GetDetailList(DetailList);

  for I := 0 to DetailList.Count - 1 do
  begin
    if TObject(DetailList[I]) is TVASUPQuery then
      TVASUPQuery(DetailList[I]).ResetCacheDataChanged;
  end;

  DetailList.Destroy;
end;

procedure TVASUPQuery.CheckWorkState;
begin
  if Active then
  begin
    if not IsQuery then
    begin
      case State of
        dsInsert : FWStyle := wsAdd;
        dsEdit   : FWStyle := wsEdit;
        dsBrowse : if FWStyle <> wsDelete then
                     FWStyle := wsView;
        else FWStyle := wsNone;
      end;
    end
    else
      FWStyle := wsQuery;
  end
  else
    FWStyle := wsNone;
end;

procedure TVASUPQuery.DoAfterEdit;
var
  PreWStyle : TWStyle;
  I : Integer;
begin
  inherited;
  PreWStyle := FWStyle;
  FWStyle := wsEdit;
  CheckWorkState;
  if PreWStyle <> FWStyle then
    AfterChangeWorkState;
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoAfterEdit(Self);
end;

procedure TVASUPQuery.DoAfterDelete;
var
  I : Integer;
begin
  inherited;
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoAfterDelete(Self);
end;

procedure TVASUPQuery.DoAfterInsert;
var
  PreWStyle : TWStyle;
  I : Integer;
begin
  inherited;
  PreWStyle := FWStyle;
  FWStyle := wsAdd;
  CheckWorkState;
  if PreWStyle <> FWStyle then
    AfterChangeWorkState;
  for I := 0 to RegistFormCount - 1 do
    TfmASUPForm(RegistForms[I]).DoAfterInsert(Self);
end;

procedure TVASUPQuery.AddFilterWithKey(AKey : String;
                                      ASQLCode : TPartSQLCode);
begin
  AddMission(ASQLCode, AKey);
  if FKeysOfFilters.IndexOf(AKey) < 0 then
    FKeysOfFilters.Add(AKey);
  RefreshSQL;
end;

procedure TVASUPQuery.SetFilterWithKey(AKey : String;
                                      ANewSQLCode : TPartSQLCode);
var
  EnabledFilter : Boolean;
begin
  if FKeysOfFilters.IndexOf(AKey) >= 0 then
  begin
    EnabledFilter := EnabledFilterWithKey['AKey'];
    SetMission(ANewSQLCode, AKey);
    EnabledFilterWithKey['AKey'] := EnabledFilter;
    RefreshSQL;
  end
  else
    AddFilterWithKey(AKey, ANewSQLCode);
end;

procedure TVASUPQuery.DeleteFilterWithKey(AKey : String);
var
  Ind : Integer;
begin
  Ind := FKeysOfFilters.IndexOf(AKey);
  if Ind >= 0 then
  begin
    DeleteMission(AKey);
    FKeysOfFilters.Delete(Ind);
    RefreshSQL;
  end;
end;

function TVASUPQuery.GetEnabledFilterWithKey(AKey : String) : boolean;
var
  ind : Integer;
begin
  Result := false;
  ind := FKeysOfFilters.IndexOf(Akey);
  if ind >= 0 then
    Result := (FBrockenSQL.VisibleScript[AKey] or FAllNoDefaultSQLVariables.EnabledVars[AKey]);
end;

procedure TVASUPQuery.setEnabledFilterWithKey(AKey : String; AEnabled : boolean);
var
 I : Integer;
 vars : TSQLVariables;
begin
  if (not ExistMission(AKey)) or (getEnabledFilterWithKey(AKey) = AEnabled) then
    exit;

  FBrockenSQL.VisibleScript[AKey] := AEnabled;
  if FAllNoDefaultSQLVariables.EnabledVars[AKey] and (not AEnabled) then
  begin
    vars := FAllNoDefaultSQLVariables[AKey];
    for I := 0 to vars.Count - 1 do
      DeleteVariable(vars[i].VariableName);
  end
  else if (not FAllNoDefaultSQLVariables.EnabledVars[AKey]) and AEnabled then
  begin
    vars := FAllNoDefaultSQLVariables[AKey];
    for I := 0 to vars.Count - 1 do
    begin
      DeclareVariable(vars[i].VariableName, vars[i].VariableType);
      SetVariable(vars[i].VariableName, vars[i].Value);
    end;
  end;
  FAllNoDefaultSQLVariables.EnabledVars[AKey] := AEnabled;
  RefreshSQL;
end;

// Determine the status of the current record
function TVASUPQuery.UpdateStatus: TUpdateStatus;
var bm: TBookmark;
    //Log: TChangeLogItem;
begin
  Result := usUnmodified;
  if IsEmpty then Exit;
  if State = dsInsert then
  begin
    Result := usInserted;
    Exit;
  end;
  //Log := nil;
  if {(Log = nil) and} (State = dsEdit) then Result := usModified;
end;

end.

