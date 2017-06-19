unit vExpandedNode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,
  comctrls, contnrs, designintf, DesignEditors;
type
  TLinkNodeOfStrings = function : TStrings    of object;
  TGetObjectList     = function : TObjectList of object;


////////////////////////////////////////////////////////////////////////////////

  TConnectType = (ctOneToMany, ctManyToOne);

  TFieldNames = class
  protected

    function  GetFields(Index : Integer) : String; virtual; abstract;
    procedure SetFields(Index : Integer; Value : String); virtual; abstract;

    function  GetFieldsName(Index : Integer) : String; virtual; abstract;
    procedure SetFieldsName(Index : Integer; Value : String); virtual; abstract;

    function  GetFieldsOrigin(Index : Integer) : String; virtual; abstract;
    procedure SetFieldsOrigin(Index : Integer; Value : String); virtual; abstract;

    function GetCount : Integer; virtual; abstract;

    // —троку разбивает на подстроки, разделител€ем считаем точку зап€той
    function StringToStrings(Value : String) : TStrings; virtual;
    // —троки соедин€ет в строку, в соединной строке между бывших подстрок точка зап€той
    function StringsToString(Value : TStrings) : String; virtual;
  public
    procedure Delete(Index : Integer); virtual; abstract;
    procedure Clear; virtual; abstract;
    procedure Insert(Index : Integer; Value : String); virtual; abstract;
    procedure InsertOrigin(Index : Integer; Value : String); virtual; abstract;
    procedure InsertName(Index : Integer; Value : String); virtual; abstract;
    procedure Add(Value : String); virtual; abstract;
    procedure AddOrigin(Value : String); virtual; abstract;
    procedure AddName(Value : String); virtual; abstract;
    function  IndexOf(Value : String) : Integer; virtual; abstract;

    // массив имен полей
    property Fields[Index: Integer] : String read GetFields write SetFields;

    property FieldsOrgin[Index: Integer] : String read GetFieldsOrigin write SetFieldsOrigin;
    property FieldsName[Index: Integer] : String read GetFieldsName write SetFieldsName;

    property Count : Integer read GetCount;
  end;

////////////////////////////////////////////////////////////////////////////////

  TKeyFieldNamesOfLinkNode = class(TFieldNames)
  private
    FGetStringsOrigin : TLinkNodeOfStrings;
    FGetStringsName   : TLinkNodeOfStrings;
  protected

    function  GetFields(Index : Integer) : String; override;
    procedure SetFields(Index : Integer; Value : String); override;

    function  GetFieldsName(Index : Integer) : String; override;
    procedure SetFieldsName(Index : Integer; Value : String); override;

    function  GetFieldsOrigin(Index : Integer) : String; override;
    procedure SetFieldsOrigin(Index : Integer; Value : String); override;

    function GetCount : Integer; override;
  public
    procedure Delete(Index : Integer); override;
    procedure Clear; override;
    procedure Insert(Index : Integer; Value : String); override;
    procedure InsertOrigin(Index : Integer; Value : String); override;
    procedure InsertName(Index : Integer; Value : String); override;
    procedure Add(Value : String); override;
    procedure AddOrigin(Value : String); override;
    procedure AddName(Value : String); override;
    function  IndexOf(Value : String) : Integer; override;

    property GetStringsOrigin : TLinkNodeOfStrings read FGetStringsOrigin write FGetStringsOrigin;
    property GetStringsName : TLinkNodeOfStrings read FGetStringsName write FGetStringsName;
  end;

////////////////////////////////////////////////////////////////////////////////

  // —в€зь с развернутым узлом с простым узлом
  TLinkNode = class
  private
    FDataSource : TDataSource; // DataSource простого узла
    FDetailFieldsOriginOfNode : TStrings;    // ѕол€ узла дерева, которые €вл. ключом дл€ соединени€ с развернутым узлом
    FDetailFieldsNameOfNode : TStrings;
    FMasterFieldsOriginOfNode : TStrings;    // ѕол€ развернутого узла, которые €вл. кл€чом дл€ соединиен€ с узлом дерева
    FMasterFieldsNameOfNode : TStrings;

    FDetailFields : TFieldNames;
    FMasterFields : TFieldNames;

    // ¬озвращает  ол. по которым соедин€етс€ простой узел с развернутым
    function GetCountKeyFields : Integer;

    function GetDetailFieldsOrigin : TStrings;
    function GetDetailFieldsName : TStrings;
    function GetMasterFieldsOrigin : TStrings;
    function GetMasterFieldsName : TStrings;
  public
    constructor Create;  virtual;
    destructor  Destroy; override;


    property DataSource : TDataSource read FDataSource write FDataSource;

    //  ол. по которым соедин€етс€ простой узел с развернутым
    property CountKeyFields : Integer read GetCountKeyFields;

    // ћассив полей простого узла, которое служит дл€ соединени€ с развернутым узлом
    property DetailFields : TFieldNames read FDetailFields;

    // ћассив полей развернутого узла, которое служит дл€ соединени€ с простым узлом
    property MasterFields : TFieldNames read FMasterFields;
  end;

////////////////////////////////////////////////////////////////////////////////

  TLinkNodeList = class
  public
  protected
    function  GetLinkNode(Index : Integer) : TLinkNode; virtual; abstract;

    function GetCount : Integer; virtual; abstract;

  public
    procedure Delete(Index : Integer); virtual; abstract;
    procedure Clear; virtual; abstract;
    procedure Insert(Index : Integer); virtual; abstract;
    procedure Add; virtual; abstract;
    function IndexOf(Value : TLinkNode) : Integer; virtual; abstract;

    property Items[Index: Integer] : TLinkNode read GetLinkNode; default;

    property Count : Integer read GetCount;
  end;

////////////////////////////////////////////////////////////////////////////////

  TLinkNodeListForWindow = class(TLinkNodeList)
  private
    FLinkNodeList: TObjectList;
  protected

    function  GetLinkNode(Index : Integer) : TLinkNode;     override;

    function GetCount : Integer; override;
  public
    constructor Create; virtual;
    destructor  Destroy; override;
    procedure Delete(Index : Integer); override;
    procedure Clear; override;
    procedure Insert(Index : Integer); override;
    procedure Add; override;
    function IndexOf(Value : TLinkNode) : Integer; override;
  end;

////////////////////////////////////////////////////////////////////////////////

  TTabSheetList = class
  public
  protected
    function  GetTabSheets(Index : Integer) : TTabSheet; virtual; abstract;
    procedure SetTabSheets(Index : Integer; Value : TTabSheet); virtual; abstract;

    function GetCount : Integer; virtual; abstract;

  public
    procedure Delete(Index : Integer); virtual; abstract;
    procedure Clear; virtual; abstract;
    procedure Insert(Index : Integer; Value : TTabSheet); virtual; abstract;
    procedure Add(Value : TTabSheet); virtual; abstract;
    function IndexOf(Value : TTabSheet) : Integer; virtual; abstract;

    property TabSheets[Index: Integer] : TTabSheet read GetTabSheets write SetTabSheets; default;

    property Count : Integer read GetCount;
  end;

////////////////////////////////////////////////////////////////////////////////

  TTabSheetListForWindow = class(TTabSheetList)
  private
    FTabSheetList: TObjectList;
  protected

    function  GetTabSheets(Index : Integer) : TTabSheet;     override;
    procedure SetTabSheets(Index : Integer; Value : TTabSheet); override;

    function GetCount : Integer; override;
  public
    constructor Create; virtual;
    destructor  Destroy; override;
    procedure Delete(Index : Integer); override;
    procedure Clear; override;
    procedure Insert(Index : Integer; Value : TTabSheet); override;
    procedure Add(Value : TTabSheet); override;
    function IndexOf(Value : TTabSheet) : Integer; override;
  end;

////////////////////////////////////////////////////////////////////////////////

  TVExpandedNode = class(TComponent)
  private
    { Private declarations }
    FDSOfExpNode : TDataSource;
    // TdataSource развернутого узла дерева
    //FTabSheetList: TObjectList; // «акладки-анкеты дл€ развернутого узла дерева

    FTabSheets : TTabSheetList;

    // «акладка, на которой только отображаютс€ все данные дл€ расширенного узла
    FTableTabSheet : TTabSheet;

    FSQL : String; // SQL  од дл€ расширенного узла

    FLinks     : TLinkNodeList;

    // Hint дл€ подзапроса, который фильтрует данные
    FHintOfSubSQL : String;

    // Hint дл€ св€зки с подзапроса, который фильтрует данные
    FHintOfLink : String;

    FFilter : String;

    // “ип соединени€ расширенного узла с простым узлом
    FConnType : TConnectType;

    function GetTabSheet(Index : Integer) : TTabSheet;

    //procedure SetDSOfExpNode
  protected
    { Protected declarations }
    procedure LoadTabSheetsOfExpNode(Reader: TReader); virtual;
    procedure StoreTabSheetsOfExpNode(Writer: TWriter); virtual;

    procedure DefineProperties(Filer: TFiler); override;

    procedure Loaded; override;

    property  TabSheetList[Index: Integer]  : TTabSheet read GetTabSheet; // —писок закладок-таблиц дл€ развернутых узлов
  public
    { Public declarations }
    property SQL : String read FSQL write FSQL;

    property Filter : String read FFilter write FFilter;
  published
    { Published declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    property DSOfExpNode: TDataSource   read FDSOfExpNode write FDSOfExpNode;
    property TabSheets  : TTabSheetList read FTabSheets;
    property Links       : TLinkNodeList     read FLinks;

    // «акладка, на которой только отображаютс€ все данные дл€ расширенного узла
    property TableTabSheet : TTabSheet read FTableTabSheet write FTableTabSheet;

    // “ип соединени€ расширенного узла с простым узлом
    property ConnectType : TConnectType read FConnType write FConnType default ctOneToMany;

    // Hint дл€ подзапроса, который фильтрует данные
    property HintOfSubSQL  : String read FHintOfSubSQL write FHintOfSubSQL;

    // Hint дл€ св€зки с подзапроса, который фильтрует данные
    property HintOfLink : String read FHintOfLink write FHintOfLink;


  end;

////////////////////////////////////////////////////////////////////////////////

TExpandedNodes = class
  protected

    function  GetExpandedNode(Index : Integer) : TVExpandedNode; virtual; abstract;
    procedure SetExpandedNode(Index : Integer; Value : TVExpandedNode); virtual; abstract;

    function GetCount : Integer; virtual; abstract;
  public
    procedure Delete(Index : Integer); virtual; abstract;
    procedure Clear; virtual; abstract;
    procedure Insert(Index : Integer; Value : TVExpandedNode); virtual; abstract;
    procedure Add(Value : TVExpandedNode); virtual; abstract;
    function  IndexOf(Value : TVExpandedNode) : Integer; virtual; abstract;

    property Items[Index: Integer] : TVExpandedNode read GetExpandedNode write SetExpandedNode; default;

    property Count : Integer read GetCount;
  end;

////////////////////////////////////////////////////////////////////////////////

TTabSheetsOfExpNodeEditor = class(TClassProperty)
public
  procedure Edit; override;
  function  GetAttributes: TPropertyAttributes; override;
  function  GetValue: string; override;
  procedure SetValue(const Value : string); override;
end;

////////////////////////////////////////////////////////////////////////////////

// —троки соедин€ет в строку, в соединной строке между бывших подстрок точка зап€той
function StringsToStringWithSemicolon(Value : TStrings) : String;

implementation

uses v_ENOfTabShDlg, Oracledata, vDBASUP;

//------------------------------------------------------------------------------

function StringsToStringWithSemicolon(Value : TStrings) : String;
var
  I : Integer;
  count : Integer;
begin
  Result := '';
  count := Value.count;
  for I := 0 to count - 1 do
  begin
    if I < (count - 1) then
      Result := Result + Value[I] + ';'
    else
      Result := Result + Value[I];
  end;
end;

//-------------------------------TFieldNames------------------------------------

function TFieldNames.StringToStrings(Value : String) : TStrings;
begin
  Result := TStringList.Create;
  StringToStringsWithSemicolon(Value, Result);
end;

function TFieldNames.StringsToString(Value : TStrings) : String;
begin
  Result := StringsToStringWithSemicolon(Value);
end;

//--------------------------TKeyFieldNamesOfLinkNode----------------------------

function  TKeyFieldNamesOfLinkNode.GetFields(Index : Integer) : String;
var
  LStrings : TStrings;
begin
  Result := '';
  if Assigned(FGetStringsOrigin) and Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      Result := LStrings[Index];

    if Result = '' then
    begin
      LStrings := FGetStringsName;
      if Assigned(LStrings) then
        Result := LStrings[Index];
    end;
  end;
end;

function  TKeyFieldNamesOfLinkNode.GetFieldsName(Index : Integer) : String;
var
  LStrings : TStrings;
begin
  Result := '';
  if Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsName;
    if Assigned(LStrings) then
      Result := LStrings[Index];
  end;
end;

function  TKeyFieldNamesOfLinkNode.GetFieldsOrigin(Index : Integer) : String;
var
  LStrings : TStrings;
begin
  Result := '';
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      Result := LStrings[Index];
  end;
end;

procedure TKeyFieldNamesOfLinkNode.SetFields(Index : Integer; Value : String);
var
  LStrings : TStrings;
begin
  if pos('.', Value) > 1 then
  begin
    if Assigned(FGetStringsOrigin) then
    begin

      LStrings := FGetStringsOrigin;
      if Assigned(LStrings) then
        LStrings[Index] := Value;
    end;

  end
  else
  begin
    if Assigned(FGetStringsName) then
    begin

      LStrings := FGetStringsName;
      if Assigned(LStrings) then
        LStrings[Index] := Value;
    end;
  end

end;

procedure TKeyFieldNamesOfLinkNode.SetFieldsName(Index : Integer; Value : String);
var
  LStrings : TStrings;
begin
  if Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsName;
    if Assigned(LStrings) then
      LStrings[Index] := Value;
  end;
end;

procedure TKeyFieldNamesOfLinkNode.SetFieldsOrigin(Index : Integer; Value : String);
var
  LStrings : TStrings;
begin
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      LStrings[Index] := Value;
  end;
end;

function TKeyFieldNamesOfLinkNode.GetCount : Integer;
var
  LStrings : TStrings;
begin
  Result := 0;
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      Result := LStrings.Count;
  end;
end;

procedure TKeyFieldNamesOfLinkNode.Delete(Index : Integer);
var
  LStrings : TStrings;
begin
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      LStrings.Delete(Index);
  end;

  if Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsName;
    if Assigned(LStrings) then
      LStrings.Delete(Index);
  end;
end;

procedure TKeyFieldNamesOfLinkNode.Clear;
var
  LStrings : TStrings;
begin
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      LStrings.Clear;
  end;

  if Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsName;
    if Assigned(LStrings) then
      LStrings.Clear;
  end;
end;

procedure TKeyFieldNamesOfLinkNode.Insert(Index : Integer; Value : String);
var
  LStrings : TStrings;
begin

  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      if pos('.', Value) > 1 then
        LStrings.Insert(Index, Value)
      else
        LStrings.Insert(Index, '');
  end;

  if Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsName;
    if Assigned(LStrings) then
      if pos('.', Value) < 1 then
        LStrings.Insert(Index, Value)
      else
        LStrings.Insert(Index, '');
  end;

end;

procedure TKeyFieldNamesOfLinkNode.InsertOrigin(Index : Integer; Value : String);
var
  LStrings : TStrings;
begin
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      LStrings.Insert(Index, Value);
  end;

  if Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsName;
    if Assigned(LStrings) then
      LStrings.Insert(Index, '');
  end;
end;

procedure TKeyFieldNamesOfLinkNode.InsertName(Index : Integer; Value : String);
var
  LStrings : TStrings;
begin
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      LStrings.Insert(Index, '');
  end;

  if Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsName;
    if Assigned(LStrings) then
      LStrings.Insert(Index, Value);
  end;
end;

procedure TKeyFieldNamesOfLinkNode.Add(Value : String);
var
  LStrings : TStrings;
begin
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      if pos('.', Value) > 1 then
        LStrings.Add(Value)
      else
        LStrings.Add('');
  end;

  if Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsName;
    if Assigned(LStrings) then
      if pos('.', Value) < 1 then
        LStrings.Add(Value)
      else
        LStrings.Add('');
  end;
end;

procedure TKeyFieldNamesOfLinkNode.AddOrigin(Value : String);
var
  LStrings : TStrings;
begin
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      LStrings.Add(Value);
  end;

  if Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsName;
    if Assigned(LStrings) then
      LStrings.Add('');

  end;
end;

procedure TKeyFieldNamesOfLinkNode.AddName(Value : String);
var
  LStrings : TStrings;
begin
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      LStrings.Add('');
  end;

  if Assigned(FGetStringsName) then
  begin
    LStrings := FGetStringsName;
    if Assigned(LStrings) then
      LStrings.Add(Value);

  end;
end;

function TKeyFieldNamesOfLinkNode.IndexOf(Value : String) : Integer;
var
  LStrings : TStrings;
begin
  Result := -1;
  if Assigned(FGetStringsOrigin) then
  begin
    LStrings := FGetStringsOrigin;
    if Assigned(LStrings) then
      Result := LStrings.IndexOf(Value);

    if Result < 0 then
    begin
      LStrings := FGetStringsNAme;
      if Assigned(LStrings) then
        Result := LStrings.IndexOf(Value);
    end;
  end;
end;
//---------------------------------TLinkNode------------------------------------

constructor TLinkNode.Create;
begin
  FDetailFieldsOriginOfNode := TStringList.Create;
  FDetailFieldsNameOfNode := TStringList.Create;
  FMasterFieldsOriginOfNode := TStringList.Create;
  FMasterFieldsNameOfNode := TStringList.Create;

  FDetailFields := TKeyFieldNamesOfLinkNode.Create;
  TKeyFieldNamesOfLinkNode(FDetailFields).GetStringsOrigin := GetDetailFieldsOrigin;
  TKeyFieldNamesOfLinkNode(FDetailFields).GetStringsName := GetDetailFieldsName;

  FMasterFields := TKeyFieldNamesOfLinkNode.Create;
  TKeyFieldNamesOfLinkNode(FMasterFields).GetStringsOrigin := GetMasterFieldsOrigin;
  TKeyFieldNamesOfLinkNode(FMasterFields).GetStringsName := GetMasterFieldsName;
end;

destructor TLinkNode.Destroy;
begin
  FDetailFieldsOriginOfNode.Destroy;
  FDetailFieldsNameOfNode.Destroy;
  FMasterFieldsOriginOfNode.Destroy;
  FMasterFieldsNameOfNode.Destroy;
  FDetailFields.Destroy;
  FMasterFields.Destroy;
end;

function TLinkNode.GetCountKeyFields : Integer;
begin
  Result := FDetailFieldsOriginOfNode.Count;
  if Result > FMasterFieldsOriginOfNode.Count then
    Result := FMasterFieldsOriginOfNode.Count;
end;

function TLinkNode.GetDetailFieldsOrigin : TStrings;
begin
  Result := FDetailFieldsOriginOfNode;
end;

function TLinkNode.GetDetailFieldsName : TStrings;
begin
  Result := FDetailFieldsNameOfNode;
end;

function TLinkNode.GetMasterFieldsOrigin : TStrings;
begin
  Result := FMasterFieldsOriginOfNode;
end;

function TLinkNode.GetMasterFieldsName : TStrings;
begin
  Result := FMasterFieldsNameOfNode;
end;

//------------------------------TLinkNodeListForWindow--------------------------

constructor TLinkNodeListForWindow.Create;
begin
  FLinkNodeList := TObjectList.Create;
end;

destructor TLinkNodeListForWindow.Destroy;
begin
  FLinkNodeList.Destroy;
end;

procedure TLinkNodeListForWindow.Delete(Index : Integer);
begin
  FLinkNodeList.Delete(Index);
end;

procedure TLinkNodeListForWindow.Clear;
begin
  FLinkNodeList.Clear;
end;

procedure TLinkNodeListForWindow.Insert(Index : Integer);
var
  linkNode : TLinkNode;
begin
  linkNode := TLinkNode.Create;
  FLinkNodeList.Insert(Index, linkNode);
end;

procedure TLinkNodeListForWindow.Add;
var
  linkNode : TLinkNode;
begin
  linkNode := TLinkNode.Create;
  FLinkNodeList.Add(linkNode);
end;

function TLinkNodeListForWindow.IndexOf(Value : TLinkNode) : Integer;
begin
  Result := FLinkNodeList.IndexOf(Value);
end;

function TLinkNodeListForWindow.GetLinkNode(Index : Integer) : TLinkNode;
var
  obj : TObject;
begin
  Result := nil;
  obj := FLinkNodeList[Index];
  if obj is TLinkNode then
    Result := TLinkNode(obj);
end;

function TLinkNodeListForWindow.GetCount : Integer;
begin
  Result := FLinkNodeList.Count;
end;

//------------------------------TTabSheetListForWindow--------------------------

constructor TTabSheetListForWindow.Create;
begin
  FTabSheetList := TObjectList.Create(false);
end;

destructor TTabSheetListForWindow.Destroy;
begin
  FTabSheetList.Destroy;
end;

procedure TTabSheetListForWindow.Delete(Index : Integer);
begin
  FTabSheetList.Delete(Index);
end;

procedure TTabSheetListForWindow.Clear;
begin
  FTabSheetList.Clear;
end;

procedure TTabSheetListForWindow.Insert(Index : Integer; Value : TTabSheet);
begin
  FTabSheetList.Insert(Index, Value);
end;

procedure TTabSheetListForWindow.Add(Value : TTabSheet);
begin
  FTabSheetList.Add(Value);
end;

function TTabSheetListForWindow.IndexOf(Value : TTabSheet) : Integer;
begin
  Result := FTabSheetList.IndexOf(Value);
end;

function TTabSheetListForWindow.GetTabSheets(Index : Integer) : TTabSheet;
var
  obj : TObject;
begin
  Result := nil;
  obj := FTabSheetList[Index];
  if obj is TTabSheet then
    Result := TTabSheet(obj);
end;

procedure TTabSheetListForWindow.SetTabSheets(Index : Integer; Value : TTabSheet);
begin
  FTabSheetList[Index] := Value;
end;

function TTabSheetListForWindow.GetCount : Integer;
begin
  Result := FTabSheetList.Count;
end;

//--------------------------------TVExpandedNode---------------------------------

constructor TVExpandedNode.Create(AOwner: TComponent);
begin
  FConnType := ctOneToMany;

  inherited;

  FTabSheets := TTabSheetListForWindow.Create;

  FLinks := TLinkNodeListForWindow.Create;

  FSQL := '';
end;

destructor  TVExpandedNode.Destroy;
begin
  inherited;

  FTabSheets.Destroy;

  FLinks.Destroy;
end;

procedure TVExpandedNode.LoadTabSheetsOfExpNode(Reader: TReader);
var
  NameOfTabSheet : String;
begin
  Reader.ReadListBegin;

  while not Reader.EndOfList do
  begin
    NameOfTabSheet := Reader.ReadIdent;

    TabSheets.Add(TTabSheet(Owner.FindComponent(NameOfTabSheet)));
  end;

  Reader.ReadListEnd;
end;

procedure TVExpandedNode.StoreTabSheetsOfExpNode(Writer: TWriter);
var
  I : Integer;
begin
  Writer.WriteListBegin;

  with TabSheets do
  begin
    for I := 0 to Count - 1 do
    begin
      Writer.WriteIdent(TabSheets[I].Name);
    end;
  end;

  Writer.WriteListEnd;
end;

procedure TVExpandedNode.Loaded;
begin
  inherited;

end;

procedure TVExpandedNode.DefineProperties(Filer: TFiler);
begin
  inherited; { allow base classes to define properties }
  Filer.DefineProperty('ExpandedNode', LoadTabSheetsOfExpNode,
                       StoreTabSheetsOfExpNode,
                       TabSheets.Count > 0);
end;

function TVExpandedNode.GetTabSheet(Index : Integer) : TTabSheet;
begin
  Result := FTabSheets.TabSheets[Index];
end;

//----------------------------TTabSheetsOfExpNodeEditor-------------------------

procedure TTabSheetsOfExpNodeEditor.Edit;
var
  ExpNode : TVExpandedNode;
  pcMain : TComponent;
  NamesOfTabSheets : TStrings;
  NamesOfSelTabSheets : TStrings;
  I : Integer;
  Dlg : TENOfTabShDlg;
  nameOfTabSheet : String;
  Ind : Integer;
begin
  ExpNode := TVExpandedNode(GetComponent(0));
  NamesOfTabSheets := TStringList.Create;
  NamesOfSelTabSheets := TStringList.Create;
  try
    pcMain := Designer.GetComponent('pcMain');
    if pcMain is TPageControl then
      with pcMain as TPageControl do
        for I := 0 to PageCount - 1 do
          if Pages[I].Name <> 'tsList' then
            NamesOfTabSheets.Add(Pages[I].Name);
  finally
  end;

  for I := 0 to ExpNode.TabSheets.Count - 1 do
  begin
    nameOfTabSheet := ExpNode.TabSheets.TabSheets[I].Name;
    Ind := NamesOfTabSheets.IndexOf(nameOfTabSheet);
    if Ind >= 0 then
    begin
      NamesOfSelTabSheets.Add(nameOfTabSheet);
      NamesOfTabSheets.Delete(Ind);
    end;
  end;

  Dlg := TENOfTabShDlg.Create(nil);

  Dlg.lbTabSheets.Items.AddStrings(NamesOfTabSheets);
  Dlg.lbSelTabSheets.Items.AddStrings(NamesOfSelTabSheets);

  if Dlg.ShowModal = mrOK then
  begin
    with ExpNode.TabSheets do
    begin
      Clear;
      for I := 0 to Dlg.lbSelTabSheets.Items.Count - 1 do
        Add(TTabSheet(Designer.GetComponent(Dlg.lbSelTabSheets.Items[I])));
    end;
    Modified;
  end;

  NamesOfTabSheets.Destroy;
  NamesOfSelTabSheets.Destroy;
  Dlg.Destroy;
end;

function TTabSheetsOfExpNodeEditor.GetAttributes: TPropertyAttributes;
begin
 GetAttributes := [paDialog];
end;// GetAttributes

function TTabSheetsOfExpNodeEditor.GetValue: string;
var
  ExpNode : TVExpandedNode;
  I : Integer;
  count : Integer;
begin
  ExpNode := TVExpandedNode(GetComponent(0));
  Result := '';
  Count := ExpNode.TabSheets.Count;
  for I := 0 to Count - 1 do
    if I < (Count - 1) then
      Result := Result + ExpNode.TabSheets.TabSheets[I].Name + ';'
    else
      Result := Result + ExpNode.TabSheets.TabSheets[I].Name;
end;// GetValue

procedure TTabSheetsOfExpNodeEditor.SetValue(const Value : string);
var
  ExpNode : TVExpandedNode;
  names : TStrings;
  I, Ind : Integer;
  comp : TComponent;
begin
  ExpNode := TVExpandedNode(GetComponent(0));
  names := TStringList.Create;
  StringToStringsWithSemicolon(Value, names);

  for I := 0 to ExpNode.TabSheets.Count - 1 do
  begin
    Ind := names.IndexOf(ExpNode.TabSheets.TabSheets[I].Name);
    if Ind < 0 then
    begin
      ExpNode.TabSheets.Delete(Ind);
      Modified;
    end;
  end;

  for I := 0 to names.Count - 1 do
  begin
    try
      comp := Designer.GetComponent(names[I]);
      if comp is TTabSheet then
      begin
        if ExpNode.TabSheets.IndexOf(TTabSheet(comp)) < 0 then
        begin
          ExpNode.TabSheets.Add(TTabSheet(comp));
          Modified;
        end;
      end;
    finally
    end;
  end;
  names.Destroy;
end;



end.
