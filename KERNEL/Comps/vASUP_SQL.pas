{*******************************************************}
{                                                       }
{       Delphi Visual Component Library Support         }
{                                                       }
{ Copyright (c) 1997, 2005 ASUP, BelarusKali, SOLIGORSK }
{                                                       }
{*******************************************************}

unit vASUP_SQL;

interface

uses classes, sysutils, typinfo, variants;

const
 // TBrockenSQL
 PREF_BROCKENSQL = '__TBSQL';
 SPEC_TERMINAL = PREF_BROCKENSQL + '_SPEC_TERMINAL';

 // THashOfSQLVariables
 PREF_SQLVARIABLES = '__TSQLV';
 NAME_VAR_OF_USER_QUERY   = PREF_SQLVARIABLES + '_VAR_OF_USER_QUERY';
 NAME_VAR_OF_SIMPLE_QUERY = PREF_SQLVARIABLES + '_VAR_OF_SIMPLE_QUERY';
type

 TSQLKeyWord=(SELECT,FROM,WHERE,GROUP_BY,HAVING,ORDER_BY,NONE);

 TSiteOfTerminal = (sotInBegin, sotInEnd);

 TArrayOfString = array of String;

 TSQLVariables = class;

 TBrockenSQL= class;

 TSQLVariable = class(TCollectionItem)
 private
   FVariableName : string;
   FValue        : Variant;
   FVariableType : Integer;
   procedure SetCollection(ACollection : TSQLVariables);
   function GetCollection : TSQLVariables;
 public
   property VariableName : String read FVariableName;
   property Value : Variant read FValue write FValue;
   property VariableType : Integer read FVariableType;
   property Collection : TSQLVariables read GetCollection write SetCollection;

   class function DefaultVariableName : String;
   class function DefaultValue : Variant;
   class function DefaultVariableType : Integer;
   class function CorrectVariableName(AVariableName : String) : String;

   constructor Create(Collection: TCollection); overload; override;
   constructor Create(Collection: TSQLVariables; AVariableName : String; AValue : Variant; AVariableType : Integer); overload; virtual;
   procedure Assign(Source: TPersistent); override;
 protected
   procedure SetVariable(AVariableName : String; AValue : Variant; AVariableType : Integer);
 end;

 ESQLVariables = class(Exception)
 end;

 // Выполнение оперции приведет к нарушение уникальности имен SQL переменных
 ENoUniqueNameOfSQLVariables = class(ESQLVariables)
 end;

 // SQL Переменная имеет другой тип
 EDifferTypeOfVariable = class(ESQLVariables)
 end;

 // SQL переменной, нет в Collection
 EThereIsNoSQLVariablesInCollection = class(ESQLVariables)
 end;

 TSQLVariableClass = class of TSQLVariable;

 TSQLVariables = class(TCollection)
 private
   function Get_(index : Integer) : TSQLVariable;
   procedure Set_(index : Integer; AValue : TSQLVariable);
   function  GetItemClass : TSQLVariableClass;

 public
   property Items[index : Integer] : TSQLVariable read Get_ write Set_; default;
   property ItemClass : TSQLVariableClass read GetItemClass;
   constructor Create(ItemClass: TSQLVariableClass); virtual;
   function Add: TSQLVariable; overload;
   function Add(AVariableName : String): TSQLVariable; overload;
   function Add(AVariableName : String; AValue : Variant; AVariableType : Integer): TSQLVariable; overload;

   function Insert(Index: Integer) : TSQLVariable; overload;
   function Insert(Index: Integer; AVariableName : String) : TSQLVariable; overload;
   function Insert(Index: Integer; AVariableName : String;
                   AValue : Variant; AVariableType : Integer) : TSQLVariable; overload;

   function NameToVariable(AVariableName : String) : TSQLVariable;
   function NameToIndex(AVariableName : String) : Integer;

   procedure CanChangeName(ANewName : String; AVariable : TSQLVariable);
   procedure CanAdd(AVariableName : String); overload;
   procedure CanAdd(AVariable : TSQLVariable); overload;

   procedure Assign(Source: TPersistent); override;
 end;

 // Класса используется в THashOfSQLVariables
 TSQLVariablesForHash = class(TSQLVariables)
 private
   FEnabled : boolean;
 public
   constructor Create(ItemClass: TSQLVariableClass); override;

   procedure Assign(Source: TPersistent); override;

   property Enabled : boolean read FEnabled write FEnabled;
 end;

 TPartSQLCode = class
 private
   FVariables   : TSQLVariables;
   FPartSQLCode : TBrockenSQL;
   function GetVariable_(Index : Integer) : TSQLVariable;
   procedure SetVariable_(Index : Integer; Value : TSQLVariable);
   function GetCountVariable : Integer;
   function GetPartSQLCode(KeyWord : TSQLKeyWord) : String;
   procedure SetPartSQLCode(KeyWord : TSQLKeyWord; AValue : String);
 public
   constructor Create;
   destructor Destroy; override;
   property PartSQLCode[KeyWord : TSQLKeyWord] : String read GetPartSQLCode write SetPartSQLCode;
   property Variables[index : Integer] : TSQLVariable read GetVariable_ write SetVariable_;
   property CountVariable : Integer read GetCountVariable;
   function RemoveVariable(AVariableName : String) : Integer; overload;
   function RemoveVariable(AVariable : TSQLVariable) : Integer; overload;
   procedure DeleteVariable(Index : Integer);
   function GetVariable(AVariableName : String) : TSQLVariable;
   function AddVariable(AVariableName : String) : Integer; overload;
   function AddVariable(AVariableName : String; AValue : Variant; AVariableType : Integer) : Integer; overload;
   function AddVariable(AVariable : TSQLVariable) : Integer; overload;
   procedure InsertVariable(Index: Integer; AVariableName : String); overload;
   procedure InsertVariable(Index: Integer; AVariableName : String;
                            AValue : Variant; AVariableType : Integer); overload;
   procedure InsertVariable(Index: Integer; AVariable : TSQLVariable); overload;
   procedure DeleteAllVariables;
   procedure Clear;
   procedure Assign(Source: TPartSQLCode); virtual;

   // копирует SQL переменные в AVariables;
   procedure copyVariables(AVariables : TSQLVariables);
   function NameToVariable(AVariableName : String) : TSQLVariable;
   function NameToIndex(AVariableName : String) : Integer;

   procedure GetVariablesInSQLCode(AVariables : TStrings); overload;
   procedure GetVariablesInSQLCode(AVariables : TStrings; AKeyWord : TSQLKeyWord); overload;
   procedure GetVariables(AVariables : TStrings);

   function ExistVariableInSQLCode(AVar : String) : boolean; overload;
   function ExistVariableInSQLCode(AVar : String; AKeyWord : TSQLKeyWord) : boolean; overload;
   function ExistVariable(AVar : String) : boolean;

   procedure ChangeVariable(AOldVar, ANewVar  : String);

   function IsEmpty : boolean;

   procedure Add(addend : TPartSQLCode);
 end;

 TWordPos= record
   Row: Integer;
   Column: Integer;
 end;

 TBrockenSQL= class

    constructor Create(Script: TStrings); overload;
    constructor Create(); overload;
    procedure SetScript(Script: TStrings); overload;
    procedure SetScript(Script: String); overload;
    procedure SetScriptForKey(Script: TStrings; AKey : String = ''); overload;
    procedure SetScriptForKey(Script: String; AKey : String = ''); overload;
    destructor Destroy;override;
    procedure Compile(Script: TStrings);
    procedure CompileForKey(Script: TStrings; AKey : String = '');
    procedure AddToArea(const SQLKeyWord: TSQLKeyWord;const Appendix: string; AKey : String = ''); overload;
    procedure AddToArea(const SQLKeyWord: TSQLKeyWord;const Appendix: TStrings; AKey : String = ''); overload;
      // AddToArea служит для добавления дополнительных условий в область
      // Значение ключа не должено начинатся с следющей подстроки "__TBSQL"
    procedure DeleteAreaForKey(const SQLKeyWord: TSQLKeyWord; AKey : String = '');
      // DeleteToArea удаляет условия из области по ключу
    procedure DeleteArea(const SQLKeyWord: TSQLKeyWord);
    procedure SetArea(const SQLKeyWord: TSQLKeyWord;const Value: string; AKey : String = '');
      // SetArea служит для установки нового значения области
    procedure SetAreaForKey(const SQLKeyWord: TSQLKeyWord;const Value: string; AKey : String = '');
      // SetArea служит для установки нового значения области по ключу

    function  getArea(const SQLKeyWord: TSQLKeyWord) : String;
    procedure getStringsArea(const SQLKeyWord: TSQLKeyWord; AArea : TStrings);

    function  getAreaForKey(const SQLKeyWord: TSQLKeyWord; AKey : String = '') : String;
    procedure getStringsAreaForKey(const SQLKeyWord: TSQLKeyWord; AArea : TStrings; AKey : String = '');

    procedure DeleteScript;
    procedure DeleteScriptForKey(AKey : String = '');
    procedure Pack;

    procedure GetVariables(AVariables : TStrings); overload;
    // В списке AVariables, возвращает все имена переменных, которые содержатся в SQL запросе
    procedure GetVariables(AVariables : TStrings; AKey : String); overload;
    // В списке AVariables, возвращает все имена переменных содержащихся
    // в частях SQL запроса идентифицирующихся по ключу AKey
    procedure GetVariables(AVariables : TStrings; AKeyWord : TSQLKeyWord); overload;
    // В списке AVariables, возвращает все имена переменных содержащихся
    // в области SQL запроса AKeyWord
    procedure GetVariables(AVariables : TStrings; AKeyWord : TSQLKeyWord; AKey : String); overload;
    // В списке AVariables, возвращает все имена переменных содержащихся
    // в области SQL запроса AKeyWord в части  идентифицирующийся по ключу AKey

    procedure ChangeVariable(AOldVar, ANewVar  : String); overload;
    // В SQL запросе меняет переменную AOldVar на ANewVar
    procedure ChangeVariable(AOldVar, ANewVar  : String; AKey : String); overload;
    // В частях SQL запроса идентифицирующихся по ключу AKey
    // меняет переменную AOldVar на ANewVar
    procedure ChangeVariable(AOldVar, ANewVar  : String; AKeyWord : TSQLKeyWord); overload;
    // В области SQL запроса AKeyWord
    // меняет переменную AOldVar на ANewVar
    procedure ChangeVariable(AOldVar, ANewVar  : String; AKeyWord : TSQLKeyWord; AKey : String); overload;
    // В области SQL запроса AKeyWord
    // в части SQL запроса идентифицирующихся по ключу AKey
    // меняет переменную AOldVar на ANewVar

    function ExistVariable(AVar : String) : boolean; overload;
    // Возвращает true, если в SQL запросе есть переменная Avar;
    // Иначе возвратит false
    function ExistVariable(AVar : String; AKey : String) : boolean; overload;
    // Возвращает true, если в частях SQL запроса
    // идентифицирующихся по ключу AKey есть переменная Avar;
    // Иначе возвратит false
    function ExistVariable(AVar : String; AKeyWord : TSQLKeyWord) : boolean; overload;
    // Возвращает true, если в области SQL запроса AKeyWord
    // есть переменная Avar;
    // Иначе возвратит false
    function ExistVariable(AVar : String; AKeyWord : TSQLKeyWord; AKey : String) : boolean; overload;
    // Возвращает true, если в области SQL запроса AKeyWord
    // в части SQL запроса идентифицирующихся по ключу AKey
    // есть переменная Avar;
    // Иначе возвратит false

    // Возвращает список ключей SQL кодов, у который свойство Visible имеет значение true
    procedure GetKeys(AKeys : TStrings);

    // Возвращает список всех ключей SQL кодов
    procedure GetAllKeys(AKeys : TStrings);

    function ExistKey(AKey : String) : Boolean;
    {Возвращает TRUE, если в SQL запросе есть часть,
     которая идентифицируется по ключу AKey,
     иначе возвращает FALSE}

    class function InEnglish(const SQLKeyWord: TSQLKeyWord): string;


  protected
    function GetSpecTermsForSQLKeyWord(const SQLKeyWord: TSQLKeyWord) : TArrayOfString;
    function GetDefaultSTForSQLKeyWord(const SQLKeyWord: TSQLKeyWord) : String;
    function GetCanSolidSTForSQLKeyWord(const SQLKeyWord: TSQLKeyWord) : Boolean;

    // Возвращает признак видимости скрипта, хранящейся  под ключом  AKey
    // Если нет скрипта хранящейся под ключом, то возвратится false
    function getVisibleScript(AKey : String) : boolean;

    // Устанавливает признак видимости у скрипта, хранящейся под ключом  AKey
    // Если нет скрипта хранящейся под ключом, то ни чего не происходит
    procedure setVisibleScript(AKey : String; AVisible : boolean);

    // Устанавливает флаг изменения данных
    procedure SetChangeData;

  private

    FSQLAreas: TCollection;

    FAreas: TCollection;

    // Признаки видимоста скриптов
    FHiddenScript     : TStrings;

    // Флаг изменения данных
    FChangeData : boolean;

    procedure Init;

    procedure Add_(const SQLKeyWord: TSQLKeyWord;const Appendix: string; AKey : String = ''); overload;
    procedure Add_(const SQLKeyWord: TSQLKeyWord;const Appendix: TStrings; AKey : String = ''); overload;

    procedure Delete_(const SQLKeyWord: TSQLKeyWord; AKey : String = '');
    procedure DeleteForKey_(AKey : String = '');
    procedure Clear_;

    procedure Pack_;

    procedure RebuildScript_;

    procedure SetArea_(const SQLKeyWord: TSQLKeyWord;const Value: string; AKey : String = '');
      // SetArea служит для установки нового значения области
    procedure SetAreaForKey_(const SQLKeyWord: TSQLKeyWord;const Value: string; AKey : String = '');

    function IsSpecChar(ch : char) : Boolean;
    procedure SaveScript_(Script : TStrings);
    function IsSpecTerminal(const ABeg, AEnd : Integer; AStrings : TStrings;
                            const ASpecTerminals : array of String;
                            const ASite : TSiteOfTerminal = sotInEnd;
                            const ACanSolid : boolean = false) : boolean;
    procedure AddSpecTerminal(const AScript : TCollectionItem;
                              const AInd : Integer;
                              const ASpecTerminals : array of String;
                              const ASpecTerminal : String;
                              const ASite : TSiteOfTerminal = sotInEnd;
                              const ACanSolid : boolean = false);
    procedure DeleteSpecTerminal(const AScript : TCollectionItem;
                                 const AInd : Integer;
                                 const ASpecTerminals : array of String;
                                 const ASite : TSiteOfTerminal = sotInEnd;
                                 const ACanSolid : boolean = false);

    procedure GetNotWorkCode(AStr : String; var ABegin : Integer;
                             var AEnd : Integer; ind : Integer=1;
                             AMode : Integer = 0); overload;
    { Определяет позицию начала и конца в строке ASTR кометарий или текста в кавычках.
      В аргументе ABegin возвр. позицию начала в строке ASTR кометарий или текста в кавычках.
      В аргументе AEnd возвр. позицию конца в строке ASTR кометарий или текста в кавычках.
      Если AMode = 0, то определяет начальную и конечную позицию для кометарий и текста в кавычках.
      Если AMode = 2, то определяет начальную и конечную позицию для кометарий.
      Если AMode = 1, то определяет начальную и конечную позицию для текста в кавычках.}

    procedure GetNotWorkCode(AStrings : TStrings;
                             var ARowBeg : Integer; var AColBeg : Integer;
                             var ARowEnd : Integer; var AColEnd : Integer;
                             ARow : Integer = 0;
                             ACol : Integer=1;
                             AMode : Integer = 0); overload;
    { Определяет позицию начала и конца в строк AStrings кометарий или текста в кавычках.
      В аргументе ARowBeg и APosBeg возвр. номер строки и позицию в строке начала кометарий или текста в кавычках.
      В аргументе ARowEnd и APosEnd возвр. номер строки и позицию в строке конча  кометарий или текста в кавычках.
      Если AMode = 0, то определяет начальную и конечную позицию для кометарий и текста в кавычках.
      Если AMode = 2, то определяет начальную и конечную позицию для кометарий.
      Если AMode = 1, то определяет начальную и конечную позицию для текста в кавычках.}

    function getPositionSQLElement(AStr : String; ASQLElement : String;
                                   Parentheses : boolean;
                                   ind : Integer=1) : Integer; overload;

    function getPositionSQLElement(AStrings : TStrings; ASQLElement : String;
                                   Parentheses : boolean;
                                   ARow : Integer = 0;
                                   ACol : Integer=1) : TWordPos; overload;
    {Находит местоположение в SQL коде ключевое слово ASQLElement и возвращает позицию
     местоположение. Поиск ведется согласно SQL синтаксису. Поиск начинаетеся со строки с индексом
     ARow, с позиции строке ACol.
     Если Parentheses равен TRUE,  то в поиск ведется с учетом круглых скобок.
     Если Parentheses равен FALSE, то в поиск ведется без учета круглых скобок.
    }

    function GetVarAndPosVar(AStrings : TStrings; var APos : TWordPos;
                             ARow : Integer = 0; ACol : Integer=1) : String;
    { Возвращает первую попавшуюся переменную и её позицию }

    procedure GetParentheses(AStr : String; var ABegin : Integer; var AEnd : Integer; ind : Integer=1); overload;

    procedure GetParentheses(AStrings : TStrings;
                             var ARowBeg : Integer; var AColBeg : Integer;
                             var ARowEnd : Integer; var AColEnd : Integer;
                             ARow : Integer = 0;
                             ACol : Integer=1); overload;
    { Находит местоположения SQL код в скобках. SQL код указывается в аргументе AStrings.
      В аргументе ARowBeg и APosBeg возвр. номер строки и позицию в строке, откуда начинается код в скобках
      В аргументе ARowEnd и APosEnd возвр. номер строки и позицию в строке, где заканчивается код в скобках
      Если не найден код в скобках то в аргументе ARowBeg и ARowEnd возвратится значение -1,
      а в аргументе AColBeg и AColEnd возвратится значение 0.
      Поиск начинаетеся со строки с индексом ARow, с позиции строке ACol.}

    function DeleteComm(AStr : String) : String;

    function GetStrWithST(const AStrings : TStrings;
                          const AStartRow, AStartPos : Integer;
                          const AFinishRow, AFinishPos : Integer;
                          const ANumRow : Integer;
                          var ABegPos, AEndPos : Integer
                          ) : String;
    // возвращает подстроку строку, в которой предположительно
    // находится разделяющие слово. Если не возможно найти, такую подстроку то
    // функция возвращает -1
    // входные параметры
    // AStrings - Список строк, в котором ищется подстрока
    // AStartRow - номер строки, откуда начался поиск
    // AStartPos - номер позиции, откуда начался поиск
    // AFinishRow - номер строки, где закончится поиск
    // AFinishPos - номер позиции, где закончится поиск
    // ANumRow - Индекс строки, в которой ищем подстроку
    // выходные параметры
    // ABegPos и AEndPos - Номера позиций в строке начало и конча подстроки
    // если строка не найдена то ABegPos = -1 и AEndPos = -1

    procedure CopyText(ASource : TStrings; ADest : TStrings; AFrom : TWordPos; ATo : TWordPos);

  public
    // Признаки видимости скриптов хранящихся под ключом Key
    // при чтении признака видимости у не сохраненного скрипта под ключем Key возвращается значение false
    // при записи признака видимости у не сохраненного скрипта под ключем Key ни чего не происходит
    property VisibleScript[Key : String] : boolean read getVisibleScript write setVisibleScript;

    // Флаг изменения данных
    property ChangeData : boolean read FChangeData;
  end;

  THashOfSQLVariables = class
  private
    FKeys : TStrings;
    FVariables : TList;
  protected
    function getVariables(Key : String) : TSQLVariables; virtual;

    // Возвращает признак доступа переменных, хранящихся под ключом  AKey
    // Если нет переменных хранящихся под ключом, то возвратится false
    function getEnabledVars(AKey : String) : boolean;

    // Устанавливает признак доступа у переменных, хранящихся под ключом  AKey
    // Если нет переменных хранящихся под ключом, то ни чего не происходит
    procedure setEnabledVars(AKey : String; AEnabled : boolean);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Delete(AKey : String); virtual;
    procedure Clear;  virtual;

    // Возвращает список ключей переменных, у который свойство Enabled имеет значение true
    procedure GetKeys(AKeys : TStrings); virtual;

    // Возвращает список всех ключей переменных
    procedure GetAllKeys(AKeys : TStrings); virtual;

    function ExistKey(AKey : String) : boolean; virtual;
    // Возвращает TRUE, если существует список переменных с ключем AKEY,
    // иначе возвращет FALSE

    // Возвращает первую попавшуюся переменную с именем AName,
    // Если нет такой переменной, то функция возратить nil
    function  getVariable(AName : String) : TSQLVariable;  overload; virtual;
    // Возвращает первую попавшуюся переменную с именем AName,
    // также функция возвратить в аргументе AKey ключ, под которым сохранена возвращаемая переменная
    // Если нет такой переменной, то функция возратить nil, а в аргументе AKey пустую строку
    function  getVariable(AName : String; var AKey : String) : TSQLVariable;  overload; virtual;

    // Возвращает первую попавшуюся переменную с именем AName и с значение свойства Enabled равняющаяся true
    // Если нет такой переменной, то функция возратить nil
    function  getEnabledVariable(AName : String) : TSQLVariable;  overload; virtual;
    // Возвращает первую попавшуюся переменную с именем AName и с значение свойства Enabled равняющаяся true,
    // также функция возвратить в аргументе AKey ключ, под которым сохранена возвращаемая переменная
    // Если нет такой переменной, то функция возратить nil, а в аргументе AKey пустую строку
    function  getEnabledVariable(AName : String; var AKey : String) : TSQLVariable;  overload; virtual;

    procedure SetVariable(AName : String; AValue : Variant); virtual;
    // Устанавливает значение AValue всем переменным с именем AName.

    function GetSQLVariables(AKey : String): TSQLVariables; virtual;
    // Возвращает по AKey соответствующий SQLVariables.
    // Если не существует SQLVariables, который соответствовал бы AKey,
    // то в отличие от Items[Key : String] не создает SQLVariables, а возвращает Nil

    property Items[Key : String] : TSQLVariables read getVariables; default;

    // Признак доступа переменных хранящихся под ключом Key
    // при чтении признака доступа у не сохраненных переменных под ключем Key возвращается значение false
    // при записи признака доступа у не сохраненных переменных под ключем Key ни чего не происходит
    property EnabledVars[Key : String] : boolean read getEnabledVars write setEnabledVars;
  end;

implementation

// Технический класс TBrockenSQL для грамматического разбора SQL скриптов
type
 TScriptArea= class;

 TScriptStrings = class(TStrings)
 private
   FStrings : TStrings;
   FOwner : TScriptArea;
   FKeys : TStrings;
 public
   constructor Create(AStrings : TStrings; AKeys : TStrings; AOwner : TScriptArea);
 protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetCapacity: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure SetCapacity(NewCapacity: Integer); override;
  public
    function Add(const S: string): Integer; override;

    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    function GetText: PChar; override;
    function IndexOf(const S: string): Integer; override;
    procedure Insert(Index: Integer; const S: string); override;
 end;

  TSriptPartArea = (paString, paStringsForKey, paAllStringsForKey, paAll);
  // Указывает тип выбора подстрок объекта класса TScriptArea
  // paString - строка
  // paStringsForKey - строки идущие подряд по ключу
  // paAllStringsForKey - все строки по ключу
  // paAll - все строки

  TScriptArea= class(TCollectionItem)
    constructor Create(Collection: TCollection);override;
    destructor Destroy;override;
  private
    FStrings: TStrings;
    FScriptStrings : TStrings;
    FKeys : TStrings;
  public
    function CountKeys : Integer;
    {Функция возвращает количество ключей}
    procedure GetKeys(AKeys : TStrings);
    {возвращает в AKeys список ключей}
    function GetKey(APos : Integer) : String;
    {возвращает ключ строки с индексом APos}
    function ExistKey(AKey : String) : Boolean;
    {возвращает True, если существует строки по ключ AKey, иначе возвращает FALSE}
    function GetStringsForKey(AValue : TStrings; AKey : String = ''; ANum : Integer = 0) : Integer;
    { Функция ищет строки идущие подряд по ключу AKey
      и возвращает, те строки в списке AValue, который были найдены в (ANum + 1) попытки,
     если строки не были найдены,
     то возвращает -1}
    function GetAllStringsForKey(AValue : TStrings; AKey : String = '') : Integer;
    {возвращает все строки по ключу в списке AValue,
     Функция возвращет индекс первой найденой строки, если строки не были найдены,
     то возвращает -1}
    function FindStringsForKey(var ABeg, AEnd : Integer; AKey : String= ''; ANum : Integer = 0) : boolean;
    { Функция ищет вхождение строк идущих подряд по ключу AKey,
      те строки в списке AValue, который были найдены в (ANum + 1) попытки,
     Если строки  найдены, то функция возвращает true, а переменным ABeg и AEnd
     присвоит индекс первой найденной строки и индекс последней найденной строки.
     Если строки не найдены, то функция возвращает false, а переменным ABeg и AEnd
     присвоит значение -1.}
    function GetStringForKey(var AValue : String; AKey : String = ''; APos : Integer = 0) : Integer;
    {Возвращает строку по ключю AKey в переменной AValue,
     у которой наименьший индекс, но при этом он больше или равен APos.}
    procedure GetStrKey(Var AString, AKey : String; APos : Integer);
    function CountPartStringsForKey(AKey : String) : Integer;
    {Возвращает количество кусков строк идущих подряд по ключу AKey}
    function Add(AValue : String; AKey : String = '') : Integer;
    procedure AddStrings(AValue : TStrings; AKey : String = '');
    procedure Insert(AValue : String; APos : Integer = -1; AKey : String = ''); overload;
    procedure Insert(AValue : TStrings; AKey : String = ''; APos : Integer = -1); overload;
    procedure SetString(AValue : String; AKey : String; APos : Integer = -1);
    procedure Delete(AKey : String = ''; ANum : Integer = -1); overload;
    procedure Delete(AInd : Integer; ATypePartArea : TSriptPartArea = paString); overload;
    procedure DeleteAllForKey(AKey : String);
    procedure SetStrings(AValue : TStrings; AKey : String = ''; ANum : Integer = 0);
    procedure SetAllStrings(AValue : TStrings; AKey : String = '');
    procedure Clear;
    function GetPartStrings(AValue : TStrings; var AKey : String; APos : Integer) : Integer;
    procedure Pack;
    property Strings: TStrings read FScriptStrings;
  end;

// Реализация грамматического разбора

constructor TScriptArea.Create(Collection: TCollection);
begin
  inherited;
  FStrings:= TStringList.Create;
  FKeys := TStringList.Create;
  FScriptStrings := TScriptStrings.Create(FStrings, FKeys, Self);
end;

destructor TScriptArea.Destroy;
begin
  FStrings.Free;
  FKeys.Destroy;
  FScriptStrings.Destroy;
  inherited;
end;

procedure TScriptArea.GetKeys(AKeys : TStrings);
var
  I : Integer;
begin
  AKeys.Clear;
  for I := 0 to FKeys.Count - 1 do
    if AKeys.IndexOf(FKeys[I]) < 0 then
      AKeys.Add(FKeys[I]);
end;

function TScriptArea.GetKey(APos : Integer) : String;
begin
  Result := FKeys[APos];
end;

function TScriptArea.CountKeys : Integer;
var
  list : TStrings;
begin
  list := TStringList.Create;
  GetKeys(list);
  Result := list.Count;
  list.Destroy;
end;

function TScriptArea.ExistKey(AKey : String) : Boolean;
begin
  Result := (FKeys.IndexOf(AKey) >= 0);
end;

function TScriptArea.GetStringsForKey(AValue : TStrings; AKey : String = ''; ANum : Integer = 0) : Integer;
var
  LCount : Integer;
  ind : Integer;
  len : Integer;
  I : Integer;
begin
  AValue.Clear;
  Result := -1;
  LCount := 0;
  ind := FKeys.IndexOf(AKey);
  len := FStrings.Count;

  if ind < 0 then
    Exit;

  repeat
    if FKeys[Ind] = AKey then
    begin
      Inc(LCount);
      if ANum < 0 then
        Result := ind
      else if LCount = ANum then
      begin
        Result := ind;
        break;
      end;

      Inc(Ind);
      for I := ind to len - 1 do
      begin
        if FKeys[I] <> AKey then
          break;
        Inc(Ind);
      end;
    end;

    Inc(Ind);
  until ((LCount - 1) = ANum) or (ind >= len);

  if Result >= 0 then
    for I := Result to len - 1 do
      if FKeys[I] = AKey then
        AValue.Add(FStrings[I])
      else
        break;
end;

function TScriptArea.GetStringForKey(var AValue : String; AKey : String = ''; APos : Integer = 0) : Integer;
var
  I : Integer;
begin
  Result := - 1;
  for I := Apos to FStrings.Count - 1 do
    if FKeys[I] = AKey then
    begin
      AValue := FStrings[I];
      Result := I;
      break;
    end;
end;

procedure TScriptArea.GetStrKey(Var AString, AKey : String; APos : Integer);
begin
  AString := FStrings[APos];
  AKey    := FKeys[APos];
end;


function TScriptArea.GetAllStringsForKey(AValue : TStrings; AKey : String = '') : Integer;
var
  ind : Integer;
  I : Integer;
begin
  AValue.Clear;
  Result := -1;
  ind := FKeys.IndexOf(AKey);

  if ind < 0 then
    Exit
  else
    Result := ind;

  for I := ind to FStrings.Count - 1 do
  begin
    if FKeys[I] = AKey then
      AValue.Add(FStrings[I]);
  end;
end;

function TScriptArea.FindStringsForKey(var ABeg, AEnd : Integer; AKey : String= ''; ANum : Integer = 0) : boolean;
var
  list : TStrings;
begin
  list := TStringList.Create;
  ABeg := GetStringsForKey(list, AKey, ANum);
  if ABeg >= 0 then
  begin
    Result := true;
    AEnd := ABeg + list.Count - 1;
  end
  else
  begin
    Result := false;
    AEnd := - 1;
  end;
  list.Destroy;
end;

function TScriptArea.CountPartStringsForKey(AKey : String) : Integer;
var
  I : Integer;
  ind : Integer;
  IsRightKey : boolean;
begin
  Result := 0;

  ind := FKeys.IndexOf(AKey);

  if ind < 0 then
    Exit;

  Inc(Result);
  IsRightKey := true;
  inc(ind);

  for I := ind to FStrings.Count - 1 do
  begin
    if FKeys[I] = AKey then
      if not IsRightKey then
      begin
        Inc(Result);
        IsRightKey := true;
      end
    else
      IsRightKey := false;
  end;
end;

function TScriptArea.Add(AValue : String; AKey : String = '') : Integer;
begin
  Result := FStrings.Add(AValue);
  FKeys.Add(AKey);
end;

procedure TScriptArea.AddStrings(AValue : TStrings; AKey : String = '');
var
  len, I : Integer;
begin
  len := AValue.Count;
  FStrings.AddStrings(AValue);
  for I := 1 to len do
    FKeys.Add(AKey);
end;

procedure TScriptArea.SetString(AValue : String; AKey : String; APos : Integer = -1);
begin
  if (APos < 0) or (FStrings.Count <=  APos) then
    Add(AValue, AKey)
  else
  begin
    FStrings[APos] := AValue;
    FKeys[APos]    := AKey;
  end;
end;

procedure TScriptArea.SetStrings(AValue : TStrings; AKey : String = ''; ANum : Integer = 0);
var
  lBeg, lEnd : Integer;
  I : Integer;
  len : Integer;
begin
  if (ANum < 0) or (not FindStringsForKey(LBeg, LEnd, AKey, ANum)) then
    AddStrings(AValue, AKey)
  else
  begin
    len := AValue.Count;
    if (LEnd - LBeg + 1) < len then
    begin
      for I := 0 to (LEnd - LBeg) do
        FStrings[LBeg + I] := AValue[I];
      for I := LEnd - LBeg + 1 to len - 1 do
      begin
        FStrings.Insert(LBeg + I, AValue[I]);
        FKeys.Insert(LBeg + I, AKey);
      end;
    end
    else
    begin
      for I := 0 to len - 1 do
        FStrings[LBeg + I] := AValue[I];
      for I := len to (LEnd - LBeg) do
      begin
        FStrings.Delete(LBeg + len);
        FKeys.Delete(LBeg + len);
      end;
    end;
  end;
end;

procedure TScriptArea.Insert(AValue : String; APos : Integer = -1; AKey : String = '');
begin
  if (APos < 0) or (FStrings.Count <=  APos) then
    Add(AValue, AKey)
  else
  begin
    FStrings.Insert(APos, AValue);
    FKeys.Insert(APos, AKey);
  end;
end;

procedure TScriptArea.Insert(AValue : TStrings; AKey : String = ''; APos : Integer = -1);
var
  I : Integer;
begin
  if (APos < 0) or (FStrings.Count <=  APos) then
    AddStrings(AValue, AKey)
  else
    for I := 0 to AValue.Count - 1 do
    begin
      FStrings.Insert(APos + I, AValue[I]);
      FKeys.Insert(APos + I, AKey);
    end;
end;

procedure TScriptArea.SetAllStrings(AValue : TStrings; AKey : String = '');

begin
  Clear;
  AddStrings(AValue, AKey);
end;

procedure TScriptArea.Delete(AKey : String = ''; ANum : Integer = -1);
var
  LBeg, LEnd : Integer;
  I : Integer;
begin
  if FindStringsForKey(LBeg, LEnd, AKey, ANum) then
    for I := LEnd downto LBeg do
    begin
      FStrings.Delete(I);
      FKeys.Delete(I);
    end;
end;


procedure TScriptArea.Delete(AInd : Integer; ATypePartArea : TSriptPartArea = paString);
var
  LKey : String;
  p, I : Integer;
begin
  case ATypePartArea of
    paString:
      begin
        FStrings.Delete(AInd);
        FKeys.Delete(AInd);
      end;
    paStringsForKey:
      begin
        LKey := FKeys[AInd];
        p := AInd;
        for I := p to FStrings.Count - 1 do
          if LKey = FKeys[I] then
            p := I
          else
            break;
        for I := p downto 0 do
          if LKey = FKeys[I] then
            Delete(I)
          else
            break;
      end;
    paAllStringsForKey: DeleteAllForKey(FKeys[AInd]);
    paAll : Clear;
  end;
end;


procedure TScriptArea.DeleteAllForKey(AKey : String);
var
  I : Integer;
begin
  for I := FKeys.Count - 1 downto 0 do
    if FKeys[I] = AKey then
    begin
      FStrings.Delete(I);
      FKeys.Delete(I);
    end;
end;

procedure TScriptArea.Clear;
begin
  FStrings.Clear;
  FKeys.Clear;
end;

procedure TScriptArea.Pack;
var
  I : Integer;
begin
  for I := FStrings.Count - 1 downto 0 do
    if Trim(FStrings[I]) = '' then
    begin
      FStrings.Delete(I);
      FKeys.Delete(I);
    end;
end;

function TScriptArea.GetPartStrings(AValue : TStrings; var AKey : String; APos : Integer) : Integer;
var
  I : Integer;
begin
  Result := -1;
  AKey := FKeys[APos];
  for I := APos downto 0 do
    if AKey <> FKeys[I] then
    begin
      Result := I + 1;
      break;
    end
    else if I = 0 then
      Result := 0;

  AValue.Clear;
  for I := Result to FKeys.Count - 1 do
    if AKey = FKeys[I] then
      AValue.Add(FStrings[I])
    else
      break;

end;

constructor TScriptStrings.Create(AStrings : TStrings; AKeys : TStrings; AOwner : TScriptArea);
begin
  FStrings := AStrings;
  FOwner := AOwner;
  FKeys := AKeys;
end;

function TScriptStrings.Get(Index: Integer): string;
begin
  Result := FStrings[Index];
end;

function TScriptStrings.GetCount: Integer;
begin
  Result := FStrings.Count;
end;

function TScriptStrings.GetCapacity: Integer;
begin
  Result := FStrings.Capacity;
end;

function TScriptStrings.GetObject(Index: Integer): TObject;
begin
  Result := FStrings.Objects[Index];
end;

procedure TScriptStrings.Insert(Index: Integer; const S: string);
begin
  FOwner.Insert(S, Index);
end;

procedure TScriptStrings.Clear;
begin
  FOwner.Clear;
end;

procedure TScriptStrings.Delete(Index: Integer);
begin
  FOwner.Delete(Index);
end;

function TScriptStrings.GetText: PChar;
begin
  Result := FStrings.GetText;
end;

procedure TScriptStrings.Exchange(Index1, Index2: Integer);
begin
  FStrings.Exchange(Index1, Index2);
  FKeys.Exchange(Index1, Index2);
end;

function TScriptStrings.IndexOf(const S: string): Integer;
begin
  Result := FStrings.IndexOf(S);
end;

procedure TScriptStrings.Put(Index: Integer; const S: string);
begin
  FOwner.SetString(S, '', Index);
end;

procedure TScriptStrings.SetCapacity(NewCapacity: Integer);
begin
  FStrings.Capacity := NewCapacity;
  FKeys.Capacity := NewCapacity;
end;

function TScriptStrings.Add(const S: string): Integer;
begin
  Result := FOwner.Add(s);
end;

function TBrockenSQL.GetSpecTermsForSQLKeyWord(const SQLKeyWord: TSQLKeyWord) : TArrayOfString;
begin
  if SQLKeyWord in [WHERE, HAVING] then
  begin
    SetLength(Result, 2);
    Result[0] := 'AND';
    Result[1] := 'OR';
  end
  else
  begin
    SetLength(Result, 1);
    Result[0] := ',';
  end;
end;

function TBrockenSQL.GetDefaultSTForSQLKeyWord(const SQLKeyWord: TSQLKeyWord) : String;
begin
  if SQLKeyWord in [WHERE, HAVING] then
    Result := 'AND'
  else
    Result := ',';
end;

function TBrockenSQL.GetCanSolidSTForSQLKeyWord(const SQLKeyWord: TSQLKeyWord) : boolean;
begin
  if SQLKeyWord in [WHERE, HAVING] then
    Result := false
  else
    Result := true;
end;

class function TBrockenSQL.InEnglish(const SQLKeyWord: TSQLKeyWord): string;
begin
  case SQLKeyWord of
    SELECT: Result:= 'SELECT';
    FROM: Result:= 'FROM';
    WHERE: Result:= 'WHERE';
    GROUP_BY: Result:= 'GROUP BY';
    HAVING: Result:= 'HAVING';
    ORDER_BY: Result:= 'ORDER BY';
    else Result:= '';
  end;
end;

function TBrockenSQL.IsSpecTerminal(const ABeg, AEnd : Integer; AStrings : TStrings;
                                    const ASpecTerminals : array of String;
                                    const ASite : TSiteOfTerminal = sotInEnd;
                                    const ACanSolid : boolean = false) : boolean;
var
  Str : String;
  I : Integer;
  len : Integer;
  lenTerm : Integer;
begin
  Result := false;

  // Составляем строку, в которой будем искать окончание ASpecTerminals
  Str := '';
  for I := ABeg to AEnd do
    Str := Str + AStrings[I] + #13#10;

  // Удаляем комметарии из строки
  Str := Trim(Str);
  Str := DeleteComm(Str);

  Str := Trim(Str);
  len := Length(Str);
  for I := Low(ASpecTerminals) to High(ASpecTerminals) do
  begin
    lenTerm := Length(ASpecTerminals[I]);
    if len >= lenTerm then
    case ASite of
      sotInEnd :
        if CompareText(copy(Str, len - lenTerm + 1, lenTerm), ASpecTerminals[i]) = 0 then
          if ACanSolid or (len = lenTerm) or ((not ACanSolid) and (IsSpecChar(Str[len - lenTerm]))) then
            Result := true;
      sotInBegin :
        if CompareText(copy(Str, 1, lenTerm), ASpecTerminals[i]) = 0 then
          if ACanSolid or (len = lenTerm) or ((not ACanSolid) and (IsSpecChar(Str[lenTerm + 1]))) then
            Result := true;
    end;
  end;
end;

procedure TBrockenSQL.AddSpecTerminal(const AScript : TCollectionItem;
                                      const AInd : Integer;
                                      const ASpecTerminals : array of String;
                                      const ASpecTerminal : String;
                                      const ASite : TSiteOfTerminal = sotInEnd;
                                      const ACanSolid : boolean = false);
var
  currPos : Integer;
  Key : String;
  StringList : TStrings;
  str : String;
begin
  if AScript is TScriptArea then
    with AScript as TScriptArea do
    begin
      StringList := TStringList.Create;

      currPos := -1;

      case ASite of
       sotInEnd:   currPos := AInd + 1;
       sotInBegin: currPos := AInd;
      end;

      repeat
        case ASite of
          sotInEnd:   currPos := GetPartStrings(StringList, Key, currPos - 1);
          sotInBegin: currPos := GetPartStrings(StringList, Key, currPos + StringList.Count);
        end;

        if Key = SPEC_TERMINAL then
        begin
          StringList.Destroy;
          Exit;
        end;
        str := StringList.Text;
        // Удаляем кометарии
        Str := Trim(str);
        str := DeleteComm(str);
        Str := Trim(str);
      until    ((currPos = 0) and (ASite = sotInEnd))
            or (((currPos + StringList.Count) >= Strings.Count) and (ASite = sotInBegin))
            or (str <> '');

      if (str <> '') and (not IsSpecTerminal(0, StringList.Count - 1, StringList, ASpecTerminals, ASite, ACanSolid)) then
        case ASite of
          sotInEnd: Insert(ASpecTerminal, currPos + StringList.Count, SPEC_TERMINAL);
          sotInBegin: Insert(ASpecTerminal, currPos, SPEC_TERMINAL);
        end;

      StringList.Destroy;
    end;
end;

procedure TBrockenSQL.DeleteSpecTerminal(const AScript : TCollectionItem;
                                         const AInd : Integer;
                                         const ASpecTerminals : array of String;
                                         const ASite : TSiteOfTerminal = sotInEnd;
                                         const ACanSolid : boolean = false);
var
  currPos : Integer;
  Key : String;
  StringList : TStrings;
  str : String;
  RowCommBeg, RowCommEnd : Integer;
  PosCommBeg, PosCommEnd : Integer;
  I : Integer;
  numStr : Integer;
  LBeg : Integer;
  LEnd : Integer;
  currRow : Integer;
  currPosInRow : Integer;
  currStr : String;
  len : Integer;
  lenTerm : Integer;
  newStr : String;
  suffStr : String;
begin
  if AScript is TScriptArea then
    with AScript as TScriptArea do
    begin
      StringList := TStringList.Create;
      currPos := -1;
      case ASite of
       sotInEnd:   currPos := AInd + 1;
       sotInBegin: currPos := AInd;
      end;

      repeat
        case ASite of
          sotInEnd:   currPos := GetPartStrings(StringList, Key, currPos - 1);
          sotInBegin: currPos := GetPartStrings(StringList, Key, currPos + StringList.Count);
        end;

        if Key = SPEC_TERMINAL then
        begin
          Delete(currPos, paStringsForKey);
          StringList.Destroy;
          Exit;
        end;
        str := StringList.Text;
        // Удаляем кометарии
        Str := Trim(str);
        str := DeleteComm(str);
        Str := Trim(str);
      until    ((currPos = 0) and (ASite = sotInEnd))
            or (((currPos + StringList.Count) >= Strings.Count) and (ASite = sotInBegin))
            or (str <> '');

      if str <> '' then
      begin
        numStr := -1;
        LEnd := 0;
        currRow := 0;
        currPosInRow := 1;
        currStr := '';
        while currRow >= 0 do
        begin
          GetNotWorkCode(StringList, RowCommBeg, PosCommBeg, RowCommEnd, PosCommEnd, CurrRow, currPosInRow, 2);
          if RowCommBeg < 0 then
          begin
            RowCommBeg := StringList.Count - 1;
            PosCommBeg := Length(StringList[StringList.Count - 1]) + 1;
            RowCommEnd := RowCommBeg;
            PosCommEnd := PosCommBeg;
          end;

          case ASite of
            sotInEnd:
              for I := RowCommBeg downto CurrRow do
              begin
                Str := GetStrWithST(StringList, CurrRow, currPosInRow,
                                    RowCommBeg, PosCommBeg, I, LBeg, LEnd);
                if LEnd >= 0 then
                begin
                  currStr := Str;
                  numStr := I;
                  break;
                end;
              end;
            sotInBegin:
            begin
              for I :=  CurrRow to RowCommBeg do
              begin
                Str := GetStrWithST(StringList, CurrRow, currPosInRow,
                                    RowCommBeg, PosCommBeg, I, LBeg, LEnd);
                if LBeg >= 0 then
                begin
                  currStr := Str;
                  numStr := I;
                  break;
                end;
              end;
              if numStr >= 0 then
                break;
            end;
          end;

          if PosCommEnd >= Length(StringList[RowCommEnd]) then
          begin
            if StringList.Count > (RowCommEnd + 1) then
            begin
              currRow := RowCommEnd + 1;
              currPosInRow := 1;
            end
            else
            begin
              currRow := -1;
              currPosInRow := -1;
            end;
          end
          else
          begin
            currRow := RowCommEnd;
            currPosInRow := PosCommEnd + 1;
          end;
        end;

        if currStr <> '' then
        begin
          case ASite of
            sotInEnd:   LEnd := LEnd - (Length(currStr) - Length(TrimRight(currStr)));
            sotInBegin: LBeg := LBeg - (Length(currStr) - Length(TrimLeft(currStr)));
          end;
          currStr := Trim(currStr);
          len := Length(currStr);
          for I := Low(ASpecTerminals) to High(ASpecTerminals) do
          begin
            lenTerm := Length(ASpecTerminals[I]);
            if len >= lenTerm then
              case ASite of
                sotInEnd:
                  if CompareText(copy(currStr, len - lenTerm + 1, lenTerm), ASpecTerminals[i]) = 0 then
                    if ACanSolid or (len = lenTerm) or ((not ACanSolid) and (IsSpecChar(currStr[len - lenTerm]))) then
                    begin
                      str := StringList[numStr];
                      newStr := copy(str, 1, LEnd - lenTerm);
                      suffStr :=copy(str, LEnd + 1, Length(str) - LEnd);

                      if (newStr <> '') and (suffStr <> '') and (suffStr[1] > ' ') and (newStr[Length(newStr)] > ' ') then
                        newStr := newStr + ' ' + suffStr
                      else
                        newStr := newStr + suffStr;

                      SetString(newStr, GetKey(currPos + numStr), currPos + numStr);
                    end;
                sotInBegin:
                  if CompareText(copy(currStr, 1, lenTerm), ASpecTerminals[i]) = 0 then
                    if ACanSolid or (len = lenTerm) or ((not ACanSolid) and (IsSpecChar(currStr[lenTerm + 1]))) then
                    begin
                      str := StringList[numStr];
                      newStr := copy(str, 1, LBeg - 1);
                      suffStr :=copy(str, LBeg + lenTerm, Length(str) - LBeg - lenTerm + 1);

                      if (newStr <> '') and (suffStr <> '') and (suffStr[1] > ' ') and (newStr[Length(newStr)] > ' ') then
                        newStr := newStr + ' ' + suffStr
                      else
                        newStr := newStr + suffStr;

                      SetString(newStr, GetKey(currPos + numStr), currPos + numStr);
                    end;
              end;
          end;
        end;
      end;

      StringList.Destroy;
    end;
end;

function TBrockenSQL.GetStrWithST(const AStrings : TStrings;
                                  const AStartRow, AStartPos : Integer;
                                  const AFinishRow, AFinishPos : Integer;
                                  const ANumRow : Integer;
                                  var ABegPos, AEndPos : Integer
                                 ) : String;
begin
  ABegPos := -1;
  AEndPos := -1;

  if (ANumRow = AStartRow) and (ANumRow = AFinishRow) then
  begin
    Result := copy(AStrings[ANumRow], AStartPos, AFinishPos - AStartPos);
    if Trim(Result) <> '' then
    begin
      ABegPos := AStartPos;
      AEndPos := AFinishPos - 1;
    end
    else
      Result := '';
  end
  else if (ANumRow = AFinishRow) then
  begin
    Result := copy(AStrings[ANumRow], 1, AFinishPos - 1);
    if Trim(Result) <> '' then
    begin
      ABegPos := 1;
      AEndPos := AFinishPos - 1;
    end
    else
      Result := '';
  end
  else if ANumRow = AStartRow then
  begin
    Result := copy(AStrings[ANumRow], AStartPos, Length(AStrings[ANumRow]) - AStartPos + 1);
    if Trim(Result) <> '' then
    begin
      ABegPos := AStartPos;
      AEndPos := Length(AStrings[ANumRow]);
    end
    else
      Result := '';
  end
  else if Trim(AStrings[ANumRow]) <> '' then
  begin
    ABegPos := 1;
    AEndPos := Length(AStrings[ANumRow]);
  end
  else
      Result := '';
end;

procedure TBrockenSQL.Compile(Script: TStrings);
var
  I: TSQLKeyWord;
begin
  Script.Clear;

  if ChangeData then
    // Данные были измененны
    // Перестраиваем SQL запрос
    RebuildScript_;

  for I:= Low(TSQLKeyWord) to Pred(High(TSQLKeyWord)) do
  begin
    if TScriptArea(FAreas.Items[Ord(I)]).Strings.Count>0 then
    begin
      Script.Append(InEnglish(I));
      Script.AddStrings(TScriptArea(FAreas.Items[Ord(I)]).Strings);
    end;
  end;
end;

// Перестраивает SQL запрос
procedure TBrockenSQL.RebuildScript_;
var
  I: TSQLKeyWord;
  Key : String;
  CurrKey : String;
  Str : String;
  PartOfScript : TStrings;
  Script : TScriptArea;

  J : Integer;
begin
  if not Assigned(FAreas) then
  begin
    // Объект описывающий SQL код не создан
    // Создаем его
    FAreas:= TCollection.Create(TScriptArea);
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      FAreas.Add;
  end
  else
    // Очищаем старый SQL код
    Clear_;

  PartOfScript := TStringList.Create;

  for I:= Low(TSQLKeyWord) to Pred(High(TSQLKeyWord)) do
  begin
    Script := TScriptArea(FSQLAreas.Items[Ord(I)]);
    Script.Pack;

    if Script.Strings.Count > 0 then
    begin
      // Существует в SQL коде скрипт в разделе I

      // Очищаем список строк скрипта, которые идут подряд с одним и тем же ключом
      PartOfScript.Clear;

      // Читаем первую строку и ключ скрипта
      Script.GetStrKey(Str, Key, 0);
      if VisibleScript[Key] then
        // Добовляем строку в список
        PartOfScript.Add(Str);

      for J := 1 to Script.Strings.Count - 1 do
      begin
        // Читаем строку и ключ скрипта
        Script.GetStrKey(Str, CurrKey, j);

        if VisibleScript[CurrKey] then
        begin
          // Праверяем изменился ли ключ
          if key <> CurrKey then
          begin
            // ключ изменился

            // Добовляем часть кода в скрипт под ключом Key
            Add_(I, PartOfScript, Key);

            PartOfScript.Clear;
            Key := CurrKey;
          end;
          PartOfScript.Add(Str);
        end
        else
          Key := CurrKey;
      end;
      // Добовляем часть кода в скрипт под ключом Key
      Add_(I, PartOfScript, Key);
    end;
  end;
  Pack_;

  FChangeData := false;

  PartOfScript.Destroy;

end;

procedure TBrockenSQL.CompileForKey(Script: TStrings; AKey : String = '');
var
  I: TSQLKeyWord;
  area : TScriptArea;
  Strings : TStrings;
begin
  Script.Clear;

  if ChangeData then
    // Данные были измененны
    // Перестраиваем SQL запрос
    RebuildScript_;

  Strings := TStringList.Create;
  for I:= Low(TSQLKeyWord) to Pred(High(TSQLKeyWord)) do
  begin
    area := TScriptArea(FAreas.Items[Ord(I)]);
    area.Pack;
    Strings.Clear;
    area.GetAllStringsForKey(Strings, AKey);
    if Strings.Count>0 then
    begin
      Script.Append(InEnglish(I));
      Script.AddStrings(Strings);
    end;
  end;
  Strings.Destroy;
end;

procedure TBrockenSQL.Add_(const SQLKeyWord: TSQLKeyWord;const Appendix: string; AKey : String = '');
var
  Strings : TStrings;
begin

  Strings := TStringList.Create;
  Strings.Add(Appendix);
  Add_(SQLKeyWord, Strings, AKey);

  Strings.Destroy;
end;

procedure TBrockenSQL.Add_(const SQLKeyWord: TSQLKeyWord;const Appendix: TStrings; AKey : String = '');
var
  CurItem: TScriptArea;

  str : String;
begin
  if Length(Trim(Appendix.Text))>0 then
  begin
    CurItem:= FAreas.Items[Ord(SQLKeyWord)] as TScriptArea;

    Str := Appendix.Text;
    Str := Trim(Str);
    Str := DeleteComm(Str);
    Str := Trim(Str);
    if Str <> '' then
      if CurItem.Strings.Count > 0 then
        if not IsSpecTerminal(0, Appendix.Count - 1, Appendix,
                              GetSpecTermsForSQLKeyWord(SQLKeyWord), sotInBegin,
                              GetCanSolidSTForSQLKeyWord(SQLKeyWord)) then
          AddSpecTerminal(CurItem, CurItem.Strings.Count - 1,
                          GetSpecTermsForSQLKeyWord(SQLKeyWord),
                          GetDefaultSTForSQLKeyWord(SQLKeyWord), sotInEnd,
                          GetCanSolidSTForSQLKeyWord(SQLKeyWord));

    CurItem.AddStrings(Appendix, AKey);
    CurItem.Pack;
  end;
end;

procedure TBrockenSQL.AddToArea(const SQLKeyWord: TSQLKeyWord;const Appendix: string; AKey : String = '');
var
  Strings : TStrings;
begin

  Strings := TStringList.Create;
  Strings.Add(Appendix);
  AddToArea(SQLKeyWord, Strings, AKey);

  Strings.Destroy;
end;

procedure TBrockenSQL.AddToArea(const SQLKeyWord: TSQLKeyWord;const Appendix: TStrings; AKey : String = '');
var
  CurItem: TScriptArea;

  str : String;
begin
  if Length(Trim(Appendix.Text))>0 then
  begin
    CurItem:= FSQLAreas.Items[Ord(SQLKeyWord)] as TScriptArea;

    Str := Appendix.Text;
    Str := Trim(Str);
    Str := DeleteComm(Str);
    Str := Trim(Str);

    CurItem.AddStrings(Appendix, AKey);
    CurItem.Pack;
    // Изменились данные
    SetChangeData;
  end;
end;

procedure TBrockenSQL.DeleteArea(const SQLKeyWord: TSQLKeyWord);
var
  CurItem: TScriptArea;
begin
  CurItem:= FSQLAreas.Items[Ord(SQLKeyWord)] as TScriptArea;
  CurItem.Clear;
  SetChangeData;
end;

procedure TBrockenSQL.SetArea_(const SQLKeyWord: TSQLKeyWord;const Value: string; AKey : String = '');
begin
  if Length(Value)>0 then
  begin
    Delete_(SQLKeyWord);
    Add_(SQLKeyWord, Value, AKey);
  end
  else
    Delete_(SQLKeyWord);
end;

procedure TBrockenSQL.SetAreaForKey_(const SQLKeyWord: TSQLKeyWord;const Value: string; AKey : String = '');
begin
  if Length(Value)>0 then
  begin
    Delete_(SQLKeyWord, AKey);
    Add_(SQLKeyWord, Value, AKey);
  end
  else
    Delete_(SQLKeyWord, AKey);
end;

procedure TBrockenSQL.SetArea(const SQLKeyWord: TSQLKeyWord;const Value: string; AKey : String = '');
begin
  if Length(Value)>0 then
  begin
    DeleteArea(SQLKeyWord);
    AddToArea(SQLKeyWord, Value, AKey);
  end
  else
    DeleteArea(SQLKeyWord);
end;

procedure TBrockenSQL.SetAreaForKey(const SQLKeyWord: TSQLKeyWord;const Value: string; AKey : String = '');
begin
  if Length(Value)>0 then
  begin
    DeleteAreaForKey(SQLKeyWord, AKey);
    AddToArea(SQLKeyWord, Value, AKey);
  end
  else
    DeleteAreaForKey(SQLKeyWord, AKey);
end;

procedure TBrockenSQL.Delete_(const SQLKeyWord: TSQLKeyWord; AKey : String = '');
var
  CurItem: TScriptArea;
  LBeg, LEnd : Integer;
  Strings : TStrings;
  I : Integer;
  Str : String;
begin
  Strings := TStringList.Create;
  CurItem:= FAreas.Items[Ord(SQLKeyWord)] as TScriptArea;
  while CurItem.FindStringsForKey(LBeg, LEnd, AKey, -1) do
  begin
    Strings.Clear;
    for I := LEnd + 1 to CurItem.Strings.Count - 1 do
      Strings.Add(CurItem.Strings[I]);

    Str := Trim(Strings.Text);
    Str := DeleteComm(Str);
    Str := Trim(Str);

    if Str <> '' then
    begin
      if IsSpecTerminal(0, Strings.Count - 1, Strings,
                            GetSpecTermsForSQLKeyWord(SQLKeyWord), sotInBegin,
                            GetCanSolidSTForSQLKeyWord(SQLKeyWord)) then
      begin
        if IsSpecTerminal(0, LBeg - 1, CurItem.Strings,
                          GetSpecTermsForSQLKeyWord(SQLKeyWord), sotInEnd,
                          GetCanSolidSTForSQLKeyWord(SQLKeyWord)) then
          DeleteSpecTerminal(CurItem, LEnd + 1,
                             GetSpecTermsForSQLKeyWord(SQLKeyWord),
                             sotInBegin,
                             GetCanSolidSTForSQLKeyWord(SQLKeyWord))
        else
        begin
          Strings.Clear;
          for I := 0 to LBeg - 1 do
            Strings.Add(CurItem.Strings[I]);

          Str := Trim(Strings.Text);
          Str := DeleteComm(Str);
          Str := Trim(Str);

          if Str = '' then
            DeleteSpecTerminal(CurItem, LEnd + 1,
                               GetSpecTermsForSQLKeyWord(SQLKeyWord),
                               sotInBegin,
                               GetCanSolidSTForSQLKeyWord(SQLKeyWord));
        end;
      end
      else
        if not IsSpecTerminal(0, LBeg - 1, CurItem.Strings,
                          GetSpecTermsForSQLKeyWord(SQLKeyWord), sotInEnd,
                          GetCanSolidSTForSQLKeyWord(SQLKeyWord)) then
        begin
          Strings.Clear;
          for I := 0 to LBeg - 1 do
            Strings.Add(CurItem.Strings[I]);

          Str := Trim(Strings.Text);
          Str := DeleteComm(Str);
          Str := Trim(Str);

          if Str <> '' then
            AddSpecTerminal(CurItem, LEnd + 1,
                            GetSpecTermsForSQLKeyWord(SQLKeyWord),
                            GetDefaultSTForSQLKeyWord(SQLKeyWord), sotInBegin,
                            GetCanSolidSTForSQLKeyWord(SQLKeyWord));
        end;
    end
    else if LBeg > 0 then
      DeleteSpecTerminal(CurItem, LBeg - 1,
                         GetSpecTermsForSQLKeyWord(SQLKeyWord),
                         sotInEnd,
                         GetCanSolidSTForSQLKeyWord(SQLKeyWord));
    CurItem.Delete(AKey);
  end;
  Strings.Destroy;
end;

procedure TBrockenSQL.Clear_;
var
  I: TSQLKeyWord;
begin
  if Assigned(FAreas) then
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      TScriptArea(FAreas.Items[Ord(I)]).Clear;
end;

procedure TBrockenSQL.DeleteForKey_(AKey : String = '');
var
  I: TSQLKeyWord;
begin
  if Assigned(FAreas) then
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      Delete_(I, AKey);
end;

procedure TBrockenSQL.Pack_;
var
  I: TSQLKeyWord;
begin
  if Assigned(FAreas) then
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      TScriptArea(FAreas.Items[Ord(I)]).Pack;
end;

procedure TBrockenSQL.DeleteAreaForKey(const SQLKeyWord: TSQLKeyWord; AKey : String = '');
begin
  TScriptArea(FSQLAreas.Items[Ord(SQLKeyWord)]).DeleteAllForKey(AKey);
  SetChangeData;
end;

procedure TBrockenSQL.DeleteScript;
var
  I: TSQLKeyWord;
begin
  if Assigned(FSQLAreas) then
  begin
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      TScriptArea(FSQLAreas.Items[Ord(I)]).Clear;
    SetChangeData;
  end;
end;

procedure TBrockenSQL.DeleteScriptForKey(AKey : String = '');
var
  I: TSQLKeyWord;
begin
  if Assigned(FSQLAreas) then
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      DeleteAreaForKey(I, AKey);
end;

procedure TBrockenSQL.Pack;
var
  I: TSQLKeyWord;
begin
  if Assigned(FSQLAreas) then
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      TScriptArea(FSQLAreas.Items[Ord(I)]).Pack;
end;

constructor TBrockenSQL.Create(Script: TStrings);
begin
  Init;
  SetScript(Script);
end;

constructor TBrockenSQL.Create;
var
  Script : TStrings;
begin
  Init;
  Script := TStringList.Create;
  SetScript(Script);
  Script.Destroy;
end;

procedure TBrockenSQL.Init;
begin
  FHiddenScript := TStringList.Create;
  FChangeData := false;
end;

destructor TBrockenSQL.Destroy;
begin
  inherited;
  if Assigned(FAreas) then
    FAreas.Free;
  if Assigned(FSQLAreas) then
    FSQLAreas.Free;
  FHiddenScript.Destroy;
end;

procedure TBrockenSQL.SetScript(Script: TStrings);
var
  I: TSQLKeyWord;
begin
  if not Assigned(FSQLAreas) then
  begin
    FSQLAreas:= TCollection.Create(TScriptArea);
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      FSQLAreas.Add;
  end
  else
    DeleteScript;

  SaveScript_(Script);
  SetChangeData;
end;

procedure TBrockenSQL.SetScript(Script: String);
var
  LScript : TStrings;
begin
  LScript := TStringList.Create;
  LScript.Add(Script);
  SetScript(LScript);
  LScript.Destroy
end;

procedure TBrockenSQL.SetScriptForKey(Script : TStrings; AKey : String = '');
var
  I: TSQLKeyWord;
begin
  if not Assigned(FSQLAreas) then
  begin
    FSQLAreas:= TCollection.Create(TScriptArea);
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      FSQLAreas.Add;
  end
  else
    DeleteScriptForKey(AKey);

  SaveScript_(Script);
end;

procedure TBrockenSQL.SetScriptForKey(Script: String; AKey : String = '');
var
  LScript : TStrings;
begin
  LScript := TStringList.Create;
  LScript.Add(Script);
  SetScriptForKey(LScript, AKey);
  LScript.Destroy
end;

procedure TBrockenSQL.SaveScript_(Script : TStrings);
var
  I,NextI: TSQLKeyWord;
  Item: TScriptArea;
  pos_KeyWord : TWordPos;
  prev_pos_KeyWord : TWordPos;

  p1, p2, p : TWordPos;

  RowOfLParenth : Integer;
  ColOfLParenth : Integer;
  RowOfRParenth : Integer;
  ColOfRParenth : Integer;

  LScript : TStrings;
  LScript1 : TStrings;
begin
  if Script.Count = 0 then
    Exit;

  I:= Low(TSQLKeyWord);

  pos_KeyWord := getPositionSQLElement(Script, InEnglish(I), false);
  if pos_KeyWord.Row < 0 then
    Exit;

  LScript := TStringList.Create;
  LScript1 := TStringList.Create;
  LScript.AddStrings(Script);

  // Проверяем сдодержится ли SQL запрос в скобках,
  // Если да, то удаляем скобки
  pos_KeyWord := getPositionSQLElement(LScript, InEnglish(I), true);
  GetParentheses(LScript, RowOfLParenth, ColOfLParenth, RowOfRParenth, ColOfRParenth);
  while (RowOfLParenth >= 0) and (pos_KeyWord.Row < 0) do
  begin
    if ColOfLParenth = Length(LScript[RowOfLParenth]) then
    begin
      p1.Row := RowOfLParenth + 1;
      p1.Column := 1;
    end
    else
    begin
      p1.Row := RowOfLParenth;
      p1.Column := ColOfLParenth + 1;
    end;

    if ColOfRParenth = 1 then
    begin
      p2.Row := RowOfRParenth - 1;
      p2.Column := Length(LScript[p2.Row]);
    end
    else
    begin
      p2.Row := RowOfRParenth;
      p2.Column := ColOfRParenth - 1;
    end;

    CopyText(LScript, LScript1, p1, p2);
    LScript.Clear;
    LScript.AddStrings(LScript1);
    LScript1.Clear;

    GetParentheses(LScript, RowOfLParenth, ColOfLParenth, RowOfRParenth, ColOfRParenth);
    pos_KeyWord := getPositionSQLElement(LScript, InEnglish(I), true);
  end;

  prev_pos_KeyWord := pos_KeyWord;
  inc(prev_pos_KeyWord.Column, Length(InEnglish(I)));
  while (I<High(TSQLKeyWord)) and (prev_pos_KeyWord.Row >= 0) do
  begin

    Item:= TScriptArea(FSQLAreas.Items[Ord(I)]);
    NextI:= Succ(I);

    pos_KeyWord := getPositionSQLElement(LScript, InEnglish(NextI), true,
                                         prev_pos_KeyWord.Row, prev_pos_KeyWord.Column);
    while (pos_KeyWord.Row < 0)
          and (NextI<Pred(High(TSQLKeyWord))) do
    begin
      Inc(NextI);
      pos_KeyWord := getPositionSQLElement(LScript, InEnglish(NextI), true,
                                         prev_pos_KeyWord.Row, prev_pos_KeyWord.Column);
    end;

    p := pos_KeyWord;
    if pos_KeyWord.Column > 1 then
      dec(pos_KeyWord.Column)
    else if pos_KeyWord.Column = 1 then
    begin
      dec(pos_KeyWord.Row);
      pos_KeyWord.Column := Length(LScript[pos_KeyWord.Row]);
    end;

    CopyText(LScript, Item.Strings, prev_pos_KeyWord, pos_KeyWord);

    I:= NextI;

    prev_pos_KeyWord := p;
    if prev_pos_KeyWord.Row >= 0 then
      inc(prev_pos_KeyWord.Column, Length(InEnglish(I)));
  end;

  LScript.Destroy;
  LScript1.Destroy;

  SetChangeData;
end;

function TBrockenSQL.getArea(const SQLKeyWord: TSQLKeyWord) : String;
var
  Strs : TStrings;
begin
  if ChangeData then
    // Данные были измененны
    // Перестраиваем SQL запрос
    RebuildScript_;

  Strs := TScriptArea(FAreas.Items[Ord(SQLKeyWord)]).Strings;
  if Strs.Count = 1 then
    Result := Strs[0]
  else
    Result := Strs.Text;
end;

procedure TBrockenSQL.getStringsArea(const SQLKeyWord: TSQLKeyWord; AArea : TStrings);
begin
  if ChangeData then
    // Данные были измененны
    // Перестраиваем SQL запрос
    RebuildScript_;

  AArea.Clear;
  AArea.AddStrings(TScriptArea(FAreas.Items[Ord(SQLKeyWord)]).Strings);
end;

function TBrockenSQL.getAreaForKey(const SQLKeyWord: TSQLKeyWord; AKey : String = '') : String;
var
  Strs : TStrings;
begin
  Strs := TStringList.Create;

  TScriptArea(FSQLAreas.Items[Ord(SQLKeyWord)]).GetAllStringsForKey(Strs, AKey);
  if Strs.Count = 1 then
    Result := Strs[0]
  else
    Result := Strs.Text;

  Strs.Destroy;
end;

procedure TBrockenSQL.getStringsAreaForKey(const SQLKeyWord: TSQLKeyWord; AArea : TStrings; AKey : String = '');
begin
  AArea.Clear;
  TScriptArea(FSQLAreas.Items[Ord(SQLKeyWord)]).GetAllStringsForKey(AArea, AKey);
end;

function TBrockenSQL.IsSpecChar(ch : char) : Boolean;
begin
  if (ord(ch) < 32) or (ch in [' ', '.', ';', '!', '''', '#', '(', '+', '|', '&', '^', '*', ')', ';', '\', '/', '"', '-', '%', '>', '<', ':', '=', ',']) then
    Result := true
  else
    Result := false;
end;

procedure TBrockenSQL.GetNotWorkCode(AStr : String; var ABegin : Integer; var AEnd : Integer; ind : Integer=1; AMode : Integer = 0);
var
  LRowBeg : Integer;
  LColBeg : Integer;
  LRowEnd : Integer;
  LColEnd : Integer;

  LStrings : TStrings;
begin
  LStrings := TStringList.Create;
  LStrings.Add(AStr);

  GetNotWorkCode(LStrings, LRowBeg, LColBeg, LRowEnd, LColEnd, 0, ind, AMode);
  ABegin := LColBeg;
  AEnd   := LColEnd;

  LStrings.Destroy;
end;


procedure TBrockenSQL.GetNotWorkCode(AStrings : TStrings;
                                     var ARowBeg : Integer; var AColBeg : Integer;
                                     var ARowEnd : Integer; var AColEnd : Integer;
                                     ARow : Integer = 0;
                                     ACol : Integer=1;
                                     AMode : Integer = 0);
var
  str : String;

  col_comm1 : Integer; // позиция начала коментарий --
  col_comm2 : Integer; // позиция начала коментарий /*
  col_comm3 : Integer; // позиция конча коментарий */
  col_kav1  : Integer; // позиция кавычек '
  col_kav2  : Integer; // позиция кавычек "
  col_kav3  : Integer; // позиция кавычек ''

  p : Integer;

  offs, o : Integer;

  I, J : Integer;
  ERow : Integer;
begin
  ARowBeg := -1;
  AColBeg := 0;
  ARowEnd := -1;
  AColEnd := 0;

  offs := 0;

  if ACol > 1 then
  begin
    str := copy(AStrings[ARow], ACol, length(AStrings[ARow]) - ACol + 1);
    offs := ACol - 1;
  end;


  I := ARow;

  repeat

    if offs > 0 then
    begin
      col_comm1 := pos('--', str);
      col_comm2 := pos('/*', str);

      col_kav1  := pos('''', str);
      col_kav2  := pos('"', str);

      if col_comm1 > 0 then inc(col_comm1, offs);
      if col_comm2 > 0 then inc(col_comm2, offs);
      if col_kav1 > 0 then inc(col_kav1, offs);
      if col_kav2 > 0 then inc(col_kav2, offs);
      offs := 0;
    end
    else
    begin
      col_comm1 := pos('--', AStrings[I]);
      col_comm2 := pos('/*', AStrings[I]);

      col_kav1  := pos('''', AStrings[I]);
      col_kav2  := pos('"',  AStrings[I]);
    end;

    if (col_comm1 > 0) and ((col_comm1 < col_comm2) or (col_comm2 = 0)) and
       ((col_comm1 < col_kav1) or (col_kav1 = 0)) and ((col_comm1 < col_kav2) or (col_kav2 = 0)) then
    begin
      str := copy(AStrings[I], col_comm1 + 2, length(AStrings[I]) - col_comm1 - 2 + 1);
      p := pos('' + #13, str);
      if AMode in [0, 2] then
      begin
        ARowBeg := I;
        AColBeg := col_comm1;
        ARowEnd := I;

        if p > 0 then
          AColEnd := col_comm1 + 2 - 1 + p - 1
        else
          AColEnd := length(AStrings[I]);
      end
      else
        if p > 0 then
          GetNotWorkCode(AStrings, ARowBeg, AColBeg, ARowEnd, AColEnd, I, col_comm1 + 2 - 1 + p, AMode)
        else if I < (AStrings.Count - 1) then
          GetNotWorkCode(AStrings, ARowBeg, AColBeg, ARowEnd, AColEnd, I + 1, 1, AMode);

      Exit;
    end
    else if (col_comm2 > 0) and ((col_comm2 < col_kav1) or (col_kav1 = 0)) and
            ((col_comm2 < col_kav2) or (col_kav2 = 0)) then
    begin
      str := copy(AStrings[I], col_comm2 + 2, length(AStrings[I]) - col_comm2 - 2 + 1);
      ERow := I;
      col_comm3 := pos('*/', str);
      if col_comm3 = 0 then
        for J := I + 1 to AStrings.Count - 1 do
        begin
          col_comm3 := pos('*/', AStrings[J]);
          if col_comm3 > 0 then
          begin
            ERow := J;
            break;
          end;
        end
      else
        Inc(col_comm3, col_comm2 + 2 - 1);

      if AMode in [0, 2] then
      begin
        ARowBeg := I;
        AColBeg := col_comm2;
        if col_comm3 > 0 then
        begin
          ARowEnd := ERow;
          AColEnd := col_comm3 + 2 - 1;
        end
        else
        begin
          ARowEnd := AStrings.Count - 1;
          AColEnd := Length(AStrings[AStrings.Count - 1]);
        end;
      end
      else
        if col_comm3 > 0 then
          GetNotWorkCode(AStrings, ARowBeg, AColBeg, ARowEnd, AColEnd, ERow, col_comm3 + 2, AMode);

      Exit;
    end
    else if (col_kav1 > 0) and ((col_kav1 < col_kav2) or (col_kav2 = 0)) then
    begin
      ERow := I;
      p := 0;
      for J := I to AStrings.Count - 1 do
      begin
        if J = I then
        begin
          o := col_kav1;
          str := copy(AStrings[J], col_kav1 + 1, length(AStrings[J]) - col_kav1 - 1 + 1);
        end
        else
        begin
          o := 0;
          str := AStrings[J];
        end;

        p := pos('''', str);
        col_kav3 := pos('''''', str);

        while (p > 0) and (p = col_kav3) do
        begin
          inc(o, col_kav3 + 2 - 1);
          str := copy(str, col_kav3 + 2, length(str) - col_kav3 - 2 + 1);
          p := pos('''', str);
          col_kav3 := pos('''''', str);
        end;

        if p > 0 then
        begin
          ERow := J;
          inc(p, o);
          break;
        end;
      end;


      if AMode in [0, 1] then
      begin
        ARowBeg := I;
        AColBeg := col_kav1;

        if p > 0 then
        begin
          ARowEnd := ERow;
          AColEnd := p + 1 - 1;
        end
        else
        begin
          ARowEnd := AStrings.Count - 1;
          AColEnd := Length(AStrings[AStrings.Count - 1]);
        end;
      end
      else
        if p > 0 then
          GetNotWorkCode(AStrings, ARowBeg, AColBeg, ARowEnd, AColEnd, ERow, p + 1, AMode);

      Exit;
    end
    else if (col_kav2 > 0) then
    begin
      //ABegin := offs + pos_kav2;
      str := copy(AStrings[I], col_kav2 + 1, length(AStrings[I]) - col_kav2 - 1 + 1);
      ERow := I;
      p := pos('"', str);
      if p = 0 then
        for J := I + 1 to AStrings.Count - 1 do
        begin
          p := pos('"', AStrings[J]);
          if p > 0 then
          begin
            ERow := J;
            break;
          end;
        end
      else
        Inc(p, col_kav2 - 1 + 1);

      if AMode in [0, 1] then
      begin
        ARowBeg := I;
        AColBeg := col_kav2;

        if p > 0 then
        begin
          ARowEnd := ERow;
          AColEnd := p + 1 - 1;
        end
        else
        begin
          ARowEnd := AStrings.Count - 1;
          AColEnd := Length(AStrings[AStrings.Count - 1]);
        end;
      end
      else
        if p > 0 then
          GetNotWorkCode(AStrings, ARowBeg, AColBeg, ARowEnd, AColEnd, ERow, p + 1, AMode);

      Exit;
    end;

    Inc(I);
  until I >= AStrings.Count ;
end;

procedure TBrockenSQL.GetParentheses(AStr : String; var ABegin : Integer;
                                     var AEnd : Integer; ind : Integer=1);
var
  LRowBeg : Integer;
  LColBeg : Integer;
  LRowEnd : Integer;
  LColEnd : Integer;

  LStrings : TStrings;
begin
  LStrings := TStringList.Create;
  LStrings.Add(AStr);

  GetParentheses(LStrings, LRowBeg, LColBeg, LRowEnd, LColEnd, 0, ind);
  ABegin := LColBeg;
  AEnd   := LColEnd;

  LStrings.Destroy;
end;

procedure TBrockenSQL.GetParentheses(AStrings : TStrings;
                                     var ARowBeg : Integer; var AColBeg : Integer;
                                     var ARowEnd : Integer; var AColEnd : Integer;
                                     ARow : Integer = 0;
                                     ACol : Integer=1);
var
  posOfLeftParenth  : Integer; // позиция открытой скобки
  posOfRightParenth : Integer; // позиция открытой закрытой

  offs : Integer; // кол. символов отбросанных в начале строке
  necess_offs : Integer; // Необходимое число символов отбросить в начале строке

  str : String;

  BegRowOfNotWorkCode : Integer; // Индекс строки, с которой начинается не рабочий код
  BegColOfNotWorkCode : Integer; // Номер позиции в строке, с которой начинается не рабочий код
  EndRowOfNotWorkCode : Integer; // Индекс строки, в которой заканчивается не рабочий код
  EndColOfNotWorkCode : Integer; // Номер позиции в строке, в которой заканчивается не рабочий код

  countParenth : Integer; // Число не закрытых скобок

  I : Integer;
begin
  ARowBeg := -1;
  AColBeg := 0;
  ARowEnd := -1;
  AColEnd := 0;

  if ACol > 1 then
    necess_offs := ACol - 1
  else
    necess_offs := 0;

  countParenth := 0;

  GetNotWorkCode(AStrings, BegRowOfNotWorkCode, BegColOfNotWorkCode,
                 EndRowOfNotWorkCode, EndColOfNotWorkCode, ARow, ACol);

  I := ARow;

  repeat

    if (BegRowOfNotWorkCode >= 0) and
       (   (I > EndRowOfNotWorkCode)
        or ((I = EndRowOfNotWorkCode) and (necess_offs >= EndColOfNotWorkCode))) then
      GetNotWorkCode(AStrings, BegRowOfNotWorkCode, BegColOfNotWorkCode,
                     EndRowOfNotWorkCode, EndColOfNotWorkCode, I, necess_offs + 1);

    if necess_offs > 0 then
    begin
      offs := necess_offs;
      // Отбрасываем  necess_offs символов в начале строке
      str := copy(AStrings[I], necess_offs + 1, length(AStrings[I]) - necess_offs);
    end
    else
    begin
      offs := 0;
      str := AStrings[I];
    end;

    necess_offs := 0;

    // ищем позицию открытой скобки
    posOfLeftParenth := pos('(', str);
    // ищем позицию закрытой скобки
    posOfRightParenth := pos(')', str);

    if (posOfLeftParenth > 0) and
       ((posOfLeftParenth < posOfRightParenth) or (posOfRightParenth = 0)) and
       ((BegRowOfNotWorkCode <> I) or
        ((BegRowOfNotWorkCode = I) and
         ((posOfLeftParenth + offs) < BegColOfNotWorkCode))) then
    begin
      // Открытая скобка

      if countParenth = 0 then // Проверяем, является ли эта скобка первой открывающей
      begin      // Да является
        ARowBeg := I;
        AColBeg := offs + posOfLeftParenth;
      end;

      inc(countParenth); // добавляем единицу к значению счетчику открытых скобок
      necess_offs := offs + posOfLeftParenth;
      continue;
    end
    else if (posOfRightParenth > 0) and
            ((BegRowOfNotWorkCode <> I) or
             ((BegRowOfNotWorkCode = I) and
              ((posOfRightParenth + offs) < BegColOfNotWorkCode))) then
    begin
      // Закрытая скобка

      dec(countParenth); // отнимаем единицу у значения счетчика открытых скобок
      if countParenth = 0 then // Проверяем, остались ли открытые скобки
      begin       // Не осталось ни одной открытой скобки
        ARowEnd := I;
        AColEnd := offs + posOfRightParenth;
        Exit;
      end;
      necess_offs := offs + posOfRightParenth;
      continue;
    end
    else if BegRowOfNotWorkCode = I then
    begin
      // кометарии или текст в кавычках
      I := EndRowOfNotWorkCode;
      necess_offs := EndColOfNotWorkCode;
      continue;
    end;

    Inc(I);
  until I >= AStrings.Count;

  if (ARowBeg >= 0) and (ARowEnd < 0) then
  begin
    ARowEnd := AStrings.Count - 1;
    AColEnd := Length(AStrings[AStrings.Count - 1]);
  end;

end;

function TBrockenSQL.getPositionSQLElement(AStr : String; ASQLElement : String;
                                           Parentheses : boolean;
                                           ind : Integer=1) : Integer;
var
  LStrings : TStrings;
begin
  LStrings := TStringList.Create;
  LStrings.Add(AStr);

  Result := getPositionSQLElement(LStrings, ASQLElement, Parentheses, 0, ind).Column;

  LStrings.Destroy;
end;

function TBrockenSQL.getPositionSQLElement(AStrings : TStrings; ASQLElement : String;
                                           Parentheses : boolean;
                                           ARow : Integer = 0;
                                           ACol : Integer=1) : TWordPos;
var
  str : String;
  SQLElement : String;
  pos_El : Integer;
  len_EL : Integer;

  BegRowOfNotWorkCode : Integer; // Индекс строки, с которой начинается не рабочий код
  BegColOfNotWorkCode : Integer; // Номер позиции в строке, с которой начинается не рабочий код
  EndRowOfNotWorkCode : Integer; // Индекс строки, в которой заканчивается не рабочий код
  EndColOfNotWorkCode : Integer; // Номер позиции в строке, в которой заканчивается не рабочий код

  RowOfLeftParenthes : Integer; // Индекс строки с открывающей скобкой
  ColOfLeftParenthes : Integer; // Номер позиции в строке открывающей скобкой
  RowOfRightParenthes : Integer; // Индекс строки с закрывающей скобкой
  ColOfRightParenthes : Integer; // Номер позиции в строке закрывающей скобкой

  offs : Integer; // кол. символов отбросанных в начале строке
  necess_offs : Integer; // Необходимое число символов отбросить в начале строке

  founded : boolean;

  I : Integer;
begin
  Result.Row := -1;
  Result.Column := 0;

  if ACol > 1 then
    necess_offs := ACol - 1
  else
    necess_offs := 0;

  GetNotWorkCode(AStrings, BegRowOfNotWorkCode, BegColOfNotWorkCode,
                 EndRowOfNotWorkCode, EndColOfNotWorkCode, ARow, ACol);

  if Parentheses then
    GetParentheses(AStrings, RowOfLeftParenthes, ColOfLeftParenthes, RowOfRightParenthes,
                   ColOfRightParenthes, ARow, ACol)
  else
    RowOfLeftParenthes := -1;

  SQLElement := UPPERCASE(ASQLElement);
  len_El := length(SQLElement);

  I := ARow;

  repeat

    if (BegRowOfNotWorkCode >= 0) and
       (   (I > EndRowOfNotWorkCode)
        or ((I = EndRowOfNotWorkCode) and (necess_offs >= EndColOfNotWorkCode))) then
      GetNotWorkCode(AStrings, BegRowOfNotWorkCode, BegColOfNotWorkCode,
                     EndRowOfNotWorkCode, EndColOfNotWorkCode, I, necess_offs + 1);

    if (RowOfLeftParenthes >= 0) and
       (   (I > RowOfRightParenthes)
        or ((I = RowOfRightParenthes) and (necess_offs >= ColOfRightParenthes))) then
      GetParentheses(AStrings, RowOfLeftParenthes, ColOfLeftParenthes,
                     RowOfRightParenthes, ColOfRightParenthes,
                     I, necess_offs + 1);

    if necess_offs > 0 then
    begin
      offs := necess_offs;
      // Отбрасываем  necess_offs символов в начале строке
      str := UPPERCASE(copy(AStrings[I], necess_offs + 1, length(AStrings[I]) - necess_offs));
    end
    else
    begin
      offs := 0;
      str := UPPERCASE(AStrings[I]);
    end;

    necess_offs := 0;

    pos_El := pos(SQLElement, str);

    if (pos_El > 0) and
       ((BegRowOfNotWorkCode <> I) or
        ((BegRowOfNotWorkCode = I) and
         ((pos_El + offs) < BegColOfNotWorkCode))) and
       ((RowOfLeftParenthes <> I) or
        ((RowOfLeftParenthes = I) and
         ((pos_El + offs) < ColOfLeftParenthes)))then
    begin
      founded := true;

      if pos_El = 1 then
      begin
        if offs > 0 then
          if not IsSpecChar(AStrings[I][offs]) then
            founded := false;
      end
      else
        if not IsSpecChar(str[pos_el - 1]) then
          founded := false;

      if Length(str) >= (pos_el + len_el) then
        if not IsSpecChar(str[pos_el + len_el]) then
          founded := false;

      if founded then
      begin
        Result.Row := I;
        Result.Column := offs + pos_el;

        Exit;
      end
      else
      begin
        necess_offs := offs + pos_el + len_El - 1;
        continue;
      end;
    end
    else if (BegRowOfNotWorkCode = I) and
            ((RowOfLeftParenthes <> I) or
             ((RowOfLeftParenthes = I) and
              (BegColOfNotWorkCode < ColOfLeftParenthes)))then
    begin
      I := EndRowOfNotWorkCode;
      necess_offs := EndColOfNotWorkCode;
      continue;
    end
    else if RowOfLeftParenthes = I then
    begin
      I := RowOfRightParenthes;
      necess_offs := ColOfRightParenthes;
      continue;
    end;

    Inc(I);
  until I >= AStrings.Count;
end;

function TBrockenSQL.GetVarAndPosVar(AStrings : TStrings; var APos : TWordPos;
                             ARow : Integer = 0; ACol : Integer=1) : String;
var
  BegRowOfNotWorkCode : Integer; // Индекс строки, с которой начинается не рабочий код
  BegColOfNotWorkCode : Integer; // Номер позиции в строке, с которой начинается не рабочий код
  EndRowOfNotWorkCode : Integer; // Индекс строки, в которой заканчивается не рабочий код
  EndColOfNotWorkCode : Integer; // Номер позиции в строке, в которой заканчивается не рабочий код

  I : Integer;

  offs : Integer; // кол. символов отбросанных в начале строке
  necess_offs : Integer; // Необходимое число символов отбросить в начале строке

  pos_var : Integer;

  len : Integer;

  len_var : Integer;

  J : Integer;

  str : String;
begin
  APos.Row := -1;
  Apos.Column := 0;
  Result := '';

  if ACol > 1 then
    necess_offs := ACol - 1
  else
    necess_offs := 0;

  GetNotWorkCode(AStrings, BegRowOfNotWorkCode, BegColOfNotWorkCode,
                 EndRowOfNotWorkCode, EndColOfNotWorkCode, ARow, ACol);

  I := ARow;

  repeat

    if (BegRowOfNotWorkCode >= 0) and
       (   (I > EndRowOfNotWorkCode)
        or ((I = EndRowOfNotWorkCode) and (necess_offs >= EndColOfNotWorkCode))) then
      GetNotWorkCode(AStrings, BegRowOfNotWorkCode, BegColOfNotWorkCode,
                     EndRowOfNotWorkCode, EndColOfNotWorkCode, I, necess_offs + 1);

    if necess_offs > 0 then
    begin
      offs := necess_offs;
      // Отбрасываем  necess_offs символов в начале строке
      str := copy(AStrings[I], necess_offs + 1, length(AStrings[I]) - necess_offs);
    end
    else
    begin
      offs := 0;
      str := AStrings[I];
    end;

    necess_offs := 0;

    pos_var := pos(':', str);

    if (I = BegRowOfNotWorkCode) and ((pos_var = 0) or ((offs + pos_var) > BegColOfNotWorkCode)) then
    begin
      I := EndRowOfNotWorkCode;
      necess_offs := EndColOfNotWorkCode;
      continue;
    end
    else if pos_var > 0 then
    begin
      len := Length(str);
      if (len > pos_var) and (not IsSpecChar(str[pos_var+1])) then
      begin
        len_var := 0;
        for J := pos_var+2 to len do
          if IsSpecChar(str[J]) then
          begin
            len_var := J - pos_var - 1;
            break;
          end;
        if len_var = 0 then
          len_var := len - pos_var;

        Result := UPPERCASE(copy(str, pos_var + 1, len_var));
        APos.Row := I;
        Apos.Column := offs + pos_var;
        Exit;
      end
      else
      begin
        necess_offs := offs + pos_var + 1;
        continue;
      end;
    end;

    Inc(I);
  until I >= AStrings.Count;
end;

procedure TBrockenSQL.CopyText(ASource : TStrings; ADest : TStrings; AFrom : TWordPos; ATo : TWordPos);
var
  Finish_row : Integer;
  Finish_col : Integer;

  I : Integer;
begin
  if ATo.Row < AFrom.Row then
  begin
    Finish_row := ASource.Count - 1;
    Finish_col := Length(ASource[ASource.Count - 1]);
  end
  else
  begin
    Finish_row := ATo.Row;
    Finish_col := ATo.Column;
  end;

  if AFrom.Row <> Finish_row then
  begin
    ADest.Add(copy(ASource[AFrom.Row], AFrom.Column, Length(ASource[AFrom.Row]) - AFrom.Column + 1));
    for I := AFrom.Row + 1 to Finish_row - 1 do
      ADest.Add(ASource[I]);
    ADest.Add(copy(ASource[Finish_row], 1, Finish_col));
  end
  else
    ADest.Add(copy(ASource[AFrom.Row], AFrom.Column, Finish_col - AFrom.Column + 1));
end;

function TBrockenSQL.DeleteComm(AStr : String) : String;
var
  currPos : Integer;
  len : Integer;
  BegComm, EndComm : Integer;
begin
  // Удаляем комметарии из строки
  currPos := 1;
  Result := '';
  len := Length(AStr);
  if AStr <> '' then
  begin
    GetNotWorkCode(AStr, BegComm, EndComm, currPos, 2);
    while BegComm > 0 do
    begin
      if currPos < BegComm then
        Result := Result + ' ' + copy(AStr, currPos, BegComm - currPos);
      currPos := EndComm + 1;
      GetNotWorkCode(AStr, BegComm, EndComm, currPos, 2);
    end;
    if currPos <= len then
      Result := Result + ' ' + copy(AStr, currPos, len - currPos + 1);
  end;
end;

procedure TBrockenSQL.GetVariables(AVariables : TStrings; AKeyWord : TSQLKeyWord);
var
  LPos : TWordPos;
  Variable : String;
begin
  AVariables.Clear;
  with FSQLAreas.Items[Ord(AKeyWord)] as TScriptArea do
  begin
    if Strings.Count = 0 then
      Exit;
    Variable := GetVarAndPosVar(Strings, LPos);
    while LPos.Row >= 0 do
    begin
      inc(LPos.Column, Length(Variable) + 1);
      if AVariables.IndexOf(Variable) < 0 then
        AVariables.Add(Variable);
      Variable := GetVarAndPosVar(Strings, LPos, LPos.Row, LPos.Column);
    end;
  end;
end;

procedure TBrockenSQL.GetVariables(AVariables : TStrings);
var
  I: TSQLKeyWord;
  strs : TStrings;
  J : Integer;
begin
  strs := TStringList.Create;
  for I:= Low(TSQLKeyWord) to Pred(High(TSQLKeyWord)) do
  begin
    GetVariables(strs, I);
    for J := 0 to strs.Count - 1 do
      if AVariables.IndexOf(strs[J]) < 0 then
        AVariables.Add(strs[J]);
  end;
  strs.Destroy;
end;

procedure TBrockenSQL.GetVariables(AVariables : TStrings; AKeyWord : TSQLKeyWord; AKey : String);
var
  LPos : TWordPos;
  Variable : String;
  Keys : TStrings;
begin
  AVariables.Clear;

  with FSQLAreas.Items[Ord(AKeyWord)] as TScriptArea do
  begin
    Keys := TStringList.Create;
    GetKeys(Keys);
    if Keys.IndexOf(AKey) < 0 then
    begin
      Keys.Destroy;
      Exit;
    end;
    Keys.Destroy;

    if Strings.Count = 0 then
      Exit;
    Variable := GetVarAndPosVar(Strings, LPos);
    while LPos.Row >= 0 do
    begin
      inc(LPos.Column, Length(Variable) + 1);
      if (CompareText(AKey, GetKey(LPos.Row)) = 0) and
         (AVariables.IndexOf(Variable) < 0) then
        AVariables.Add(Variable);
      Variable := GetVarAndPosVar(Strings, LPos, LPos.Row, LPos.Column);
    end;
  end;
end;

procedure TBrockenSQL.GetVariables(AVariables : TStrings; AKey : String);
var
  I: TSQLKeyWord;
  strs : TStrings;
  J : Integer;
begin
  strs := TStringList.Create;
  for I:= Low(TSQLKeyWord) to Pred(High(TSQLKeyWord)) do
  begin
    GetVariables(strs, I, AKey);
    for J := 0 to strs.Count - 1 do
      if AVariables.IndexOf(strs[J]) < 0 then
        AVariables.Add(strs[J]);
  end;
  strs.Destroy;
end;

function TBrockenSQL.ExistVariable(AVar : String; AKeyWord : TSQLKeyWord) : boolean;
var
  Variable : String;
begin
  Result := false;
  if (Length(AVar) = 0) or ((AVar[1] = ':') and (Length(AVar) = 1)) then
    Exit;
  if AVar[1] <> ':' then
    Variable := ':' + AVar
  else
    Variable := AVar;

  with FSQLAreas.Items[Ord(AKeyWord)] as TScriptArea do
  begin
    if Strings.Count = 0 then
      Exit;

    if getPositionSQLElement(Strings, Variable, false).Row >= 0 then
      Result := true;
  end;
end;

function TBrockenSQL.ExistVariable(AVar : String) : boolean;
var
  I: TSQLKeyWord;
begin
  Result := false;
  for I:= Low(TSQLKeyWord) to Pred(High(TSQLKeyWord)) do
  begin
    if ExistVariable(AVar, I) then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

function TBrockenSQL.ExistVariable(AVar : String; AKeyWord : TSQLKeyWord; AKey : String) : boolean;
var
  Variable : String;
  Ind_row : Integer;
  Keys : TStrings;
begin
  Result := false;
  if (Length(AVar) = 0) or ((AVar[1] = ':') and (Length(AVar) = 1)) then
    Exit;
  if AVar[1] <> ':' then
    Variable := ':' + AVar
  else
    Variable := AVar;

  with FSQLAreas.Items[Ord(AKeyWord)] as TScriptArea do
  begin
    if Strings.Count = 0 then
      Exit;

    Keys := TStringList.Create;
    GetKeys(Keys);
    if Keys.IndexOf(AKey) < 0 then
    begin
      Keys.Destroy;
      Exit;
    end;
    Keys.Destroy;

    Ind_row := getPositionSQLElement(Strings, Variable, false).Row;
    if (Ind_row >= 0) and ((CompareText(AKey, GetKey(Ind_row)) = 0)) then
      Result := true;
  end;
end;

function TBrockenSQL.ExistVariable(AVar : String; AKey : String) : boolean;
var
  I: TSQLKeyWord;
begin
  Result := false;
  for I:= Low(TSQLKeyWord) to Pred(High(TSQLKeyWord)) do
  begin
    if ExistVariable(AVar, I, AKey) then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

procedure TBrockenSQL.ChangeVariable(AOldVar, ANewVar  : String; AKeyWord : TSQLKeyWord);
var
  OldVariable, NewVariable : String;
  //len_OldVar : Integer;
  LPos : TWordPos;
  str : String;
begin
  if (Length(AOldVar) = 0) or ((AOldVar[1] = ':') and (Length(AOldVar) = 1)) and
     (Length(ANewVar) = 0) or ((ANewVar[1] = ':') and (Length(ANewVar) = 1)) then
    Exit;
  if AOldVar[1] <> ':' then
    OldVariable := ':' + AOldVar
  else
    OldVariable := AOldVar;

  if ANewVar[1] <> ':' then
    NewVariable := ':' + ANewVar
  else
    NewVariable := ANewVar;

  //len_OldVar := Length(OldVariable);

  with FSQLAreas.Items[Ord(AKeyWord)] as TScriptArea do
  begin
    if Strings.Count = 0 then
      Exit;

    LPos := getPositionSQLElement(Strings, OldVariable, false);
    while LPos.Row >= 0 do
    begin
      str := Copy(Strings[LPos.Row], 1, LPos.Column - 1) +
             NewVariable +
             Copy(Strings[LPos.Row], LPos.Column + Length(OldVariable),
                  Length(Strings[LPos.Row]) - LPos.Column - Length(OldVariable) - 1);

      SetString(str, getKey(LPos.Row), LPos.Row);

      if not Self.ChangeData then
        Self.SetChangeData;

      LPos := getPositionSQLElement(Strings, OldVariable, false, LPos.Row, LPos.Column);
    end;
  end;
end;

procedure TBrockenSQL.ChangeVariable(AOldVar, ANewVar  : String);
var
  I: TSQLKeyWord;
begin
  for I:= Low(TSQLKeyWord) to Pred(High(TSQLKeyWord)) do
    ChangeVariable(AOldVar, ANewVar, I);
end;

procedure TBrockenSQL.ChangeVariable(AOldVar, ANewVar  : String; AKeyWord : TSQLKeyWord; AKey : String);
var
  OldVariable, NewVariable : String;
  //len_OldVar : Integer;
  LPos : TWordPos;
  str : String;
begin
  if (Length(AOldVar) = 0) or ((AOldVar[1] = ':') and (Length(AOldVar) = 1)) and
     (Length(ANewVar) = 0) or ((ANewVar[1] = ':') and (Length(ANewVar) = 1)) then
    Exit;
  if AOldVar[1] <> ':' then
    OldVariable := ':' + AOldVar
  else
    OldVariable := AOldVar;

  if ANewVar[1] <> ':' then
    NewVariable := ':' + ANewVar
  else
    NewVariable := ANewVar;

  //len_OldVar := Length(OldVariable);

  with FSQLAreas.Items[Ord(AKeyWord)] as TScriptArea do
  begin
    if Strings.Count = 0 then
      Exit;

    LPos := getPositionSQLElement(Strings, OldVariable, false);
    while LPos.Row >= 0 do
    begin
      if CompareText(AKey, GetKey(LPos.Row)) = 0 then
      begin
        str := Copy(Strings[LPos.Row], 1, LPos.Column - 1) +
               NewVariable +
               Copy(Strings[LPos.Row], LPos.Column + Length(OldVariable),
                    Length(Strings[LPos.Row]) - LPos.Column - Length(OldVariable) - 1);

        SetString(str, getKey(LPos.Row), LPos.Row);

        if not Self.ChangeData then
          Self.SetChangeData
      end;

      LPos := getPositionSQLElement(Strings, OldVariable, false, LPos.Row, LPos.Column);
    end;
  end;
end;

procedure TBrockenSQL.ChangeVariable(AOldVar, ANewVar  : String; AKey : String);
var
  I: TSQLKeyWord;
begin
  for I:= Low(TSQLKeyWord) to Pred(High(TSQLKeyWord)) do
    ChangeVariable(AOldVar, ANewVar, I, AKey);
end;

procedure TBrockenSQL.GetAllKeys(AKeys : TStrings);
var
  keys : TStrings;
  I: TSQLKeyWord;
  J : Integer;
begin
  keys := TStringList.Create;
  AKeys.Clear;

  if not Assigned(FAreas) then
  begin
    // Объект описывающий SQL код не создан
    // Создаем его
    FAreas:= TCollection.Create(TScriptArea);
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      FAreas.Add;
  end;

  for I:= Low(TSQLKeyWord) to High(TSQLKeyWord) do
  begin
    with FAreas.Items[Ord(I)] as TScriptArea do
      GetKeys(keys);
    for J := 0 to keys.Count - 1 do
      if AKeys.IndexOf(keys[J]) < 0 then
        AKeys.Add(keys[J]);
  end;

  keys.Destroy;
end;

procedure TBrockenSQL.GetKeys(AKeys : TStrings);
var
  keys : TStrings;
  I: TSQLKeyWord;
  J : Integer;
begin
  keys := TStringList.Create;
  AKeys.Clear;

  if not Assigned(FAreas) then
  begin
    // Объект описывающий SQL код не создан
    // Создаем его
    FAreas:= TCollection.Create(TScriptArea);
    for I := Low(TSQLKeyWord) to High(TSQLKeyWord) do
      FAreas.Add;
  end;

  for I:= Low(TSQLKeyWord) to High(TSQLKeyWord) do
  begin
    with FAreas.Items[Ord(I)] as TScriptArea do
      GetKeys(keys);
    for J := 0 to keys.Count - 1 do
      if (AKeys.IndexOf(keys[J]) < 0) and (FHiddenScript.IndexOf(keys[J]) < 0) then
        AKeys.Add(keys[J]);
  end;

  keys.Destroy;
end;

function TBrockenSQL.ExistKey(AKey : String) : boolean;
var
  I: TSQLKeyWord;
begin
  Result := false;

  for I:= Low(TSQLKeyWord) to High(TSQLKeyWord) do
    if TScriptArea(FSQLAreas.Items[Ord(I)]).ExistKey(AKey) then
    begin
      Result := true;
      break;
    end;
end;

function TBrockenSQL.getVisibleScript(AKey : String) : boolean;
begin
  // по умолчанию возвращаем значение false
  Result := false;

  // Определяем, существует ли скрипт с ключом AKey
  if ExistKey(AKey) then
    // Скрипт с ключом AKey существует
    // Определяем атрибут его видимости
    Result := (FHiddenScript.IndexOf(AKey) < 0);
end;

procedure TBrockenSQL.setVisibleScript(AKey : String; AVisible : boolean);
var
  Ind : Integer;
begin
  // Определяем, существует ли скрипт с ключом AKey
  if ExistKey(AKey) then
  begin
    // Определяем, ключ скрипта есть ли в списке ключей не видимых скриптов,
    // если есть, то под каким индексом он сохранен
    Ind := FHiddenScript.IndexOf(AKey);

    if Ind < 0 then
    begin
      // нету ключа скрипта  в списке ключей не видимых скриптов

      if not AVisible then
      begin
        // Добавляем ключ в списак ключей не видимых скриптов
        FHiddenScript.Add(AKey);

        if not ChangeData then
          SetChangeData;
      end;
    end
    else
    begin
      // есть ключ скрипта  в списке ключей не видимых скриптов

      if AVisible then
      begin
        // Удаляем ключ из списка ключей не видимых скриптов
        FHiddenScript.Delete(Ind);

        if not Self.ChangeData then
          Self.SetChangeData;
      end;
    end
  end;
end;

procedure TBrockenSQL.SetChangeData;
begin
  FChangeData := true;
end;

class function TSQLVariable.DefaultVariableName : String;
begin
  Result := '';
end;

class function TSQLVariable.DefaultValue : Variant;
begin
  Result := NULL;
end;

class function TSQLVariable.DefaultVariableType : Integer;
begin
  Result := 0;
end;

constructor TSQLVariable.Create(Collection: TCollection);
begin
  if not (Collection is TSQLVariables) then
    raise EPropertyConvertError.Create('The type of the collection is not TSQLVariables');
  // проверяем можно ли переменную добавить в Collection
  // Если нельзя, то вызываем исключения
  TSQLVariables(Collection).CanAdd(DefaultVariableName);
  inherited Create(Collection);
  SetVariable(DefaultVariableName, DefaultValue, DefaultVariableType);
end;

constructor TSQLVariable.Create(Collection: TSQLVariables; AVariableName : String; AValue : Variant; AVariableType : Integer);
begin
  // проверяем можно ли переменную добавить в Collection
  // Если нельзя, то вызываем исключения
  Collection.CanAdd(AVariableName);
  inherited Create(Collection);
  SetVariable(AVariableName, AValue, AVariableType);
end;

procedure TSQLVariable.SetVariable(AVariableName : String; AValue : Variant; AVariableType : Integer);
var
  NewVariableName : String;
begin
  NewVariableName := CorrectVariableName(AVariableName);
  // проверяем можно ли изменеть имя переменной на имя AVariableName
  // Если нельзя, то вызываем исключения
  Collection.CanChangeName(NewVariableName, Self);
  FVariableName := NewVariableName;
  FValue := AValue;
  FVariableType := AVariableType;
end;

procedure TSQLVariable.Assign(Source: TPersistent);
begin
  if Source is TSQLVariable then
    with Source as TSQLVariable do
      Self.SetVariable(VariableName, Value, VariableType)
  else
    raise EPropertyConvertError.Create('The type of the Source is not TSQLVariable');
end;

procedure TSQLVariable.SetCollection(ACollection : TSQLVariables);
begin
  if ACollection <> Collection then
  begin
    // проверяем можно ли переменную добавить в ACollection
    // Если нельзя, то вызываем исключения
    ACollection.CanAdd(Self);
    // Изменяем Collection  у переменной
    inherited Collection := ACollection;
  end;
end;

function TSQLVariable.GetCollection : TSQLVariables;
begin
  Result := TSQLVariables(inherited Collection);
end;

constructor TSQLVariables.Create(ItemClass: TSQLVariableClass);
begin
  inherited Create(ItemClass);
end;

function TSQLVariables.NameToVariable(AVariableName : String) : TSQLVariable;
var
  Ind : Integer;
begin
  ind := NameToIndex(AVariableName);
  if ind >= 0 then
    Result := Items[Ind]
  else
    Result := nil;
end;

function TSQLVariables.NameToIndex(AVariableName : String) : Integer;
var
  I : Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if CompareText(Items[I].VariableName, ItemClass.CorrectVariableName(AVariableName)) = 0 then
    begin
      Result := I;
      break;
    end;
end;

class function TSQLVariable.CorrectVariableName(AVariableName : String) : String;
begin
  if (Length(AVariableName) > 0) and (AVariableName[1] = ':') then
    Result := copy(AVariableName, 2, Length(AVariableName) - 1)
  else
    Result := AVariableName;
end;

function TSQLVariables.Get_(index : Integer) : TSQLVariable;
begin
  Result := TSQLVariable(inherited Items[index]);
end;

procedure TSQLVariables.Set_(index : Integer; AValue : TSQLVariable);
begin
  inherited Items[index] := AValue;
end;

function TSQLVariables.GetItemClass : TSQLVariableClass;
begin
  Result := TSQLVariableClass(inherited ItemClass);
end;

function TSQLVariables.Add(AVariableName : String; AValue : Variant; AVariableType : Integer): TSQLVariable;
begin
  Result := ItemClass.Create(Self, AVariableName, AValue,AVariableType);
end;

function TSQLVariables.Add(AVariableName : String): TSQLVariable;
begin
  Result := Add(AVariableName, ItemClass.DefaultValue,
                ItemClass.DefaultVariableType);
end;

function TSQLVariables.Add: TSQLVariable;
begin
  Result := Add(ItemClass.DefaultVariableName);
end;

procedure TSQLVariables.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TSQLVariables then
  begin
    BeginUpdate;
    try
      Clear;
      with Source as TSQLVariables do
        for I := 0 to Count - 1 do
          Self.Add(Items[I].VariableName).Assign(Items[I]);
    finally
      EndUpdate;
    end;
    Exit;
  end;
end;

function TSQLVariables.Insert(Index: Integer) : TSQLVariable;
begin
  Result := Add;
  Result.Index := Index;
end;

function TSQLVariables.Insert(Index: Integer; AVariableName : String) : TSQLVariable;
begin
  Result := Add(AVariableName);
  Result.Index := Index;
end;

function TSQLVariables.Insert(Index: Integer; AVariableName : String;
                AValue : Variant; AVariableType : Integer) : TSQLVariable;
begin
  Result := Add(AVariableName, AValue, AVariableType);
  Result.Index := Index;
end;

procedure TSQLVariables.CanChangeName(ANewName : String; AVariable : TSQLVariable);
var
  NewName : String;
begin
  NewName := ItemClass.CorrectVariableName(ANewName);
  if AVariable.Collection = Self then
  begin
    // В контенере, каждая SQL переменная должна иметь уникальное имя
    // Если при изменении имени переменной произойдет нарушение уникальности имен то это ошибка
    if (CompareText(NewName, AVariable.FVariableName) <> 0) and
       (NameToIndex(NewName) >= 0) then
      raise ENoUniqueNameOfSQLVariables.CreateFmt('Variable with a name %s already exists', [NewName]);
  end
  else
    raise EThereIsNoSQLVariablesInCollection.CreateFmt('There is no SQL Variable in the Collection', [NewName]);
end;

procedure TSQLVariables.CanAdd(AVariableName : String);
begin
  // В контенере, каждая SQL переменная должна иметь уникальное имя
  // Если при добавлении переменной произойдет нарушение уникальности имен то это ошибка
  if NameToIndex(AVariableName) > 0 then
    raise ENoUniqueNameOfSQLVariables.CreateFmt('Variable with a name %s already exists', [AVariableName]);
end;

procedure TSQLVariables.CanAdd(AVariable : TSQLVariable);
begin
  CanAdd(AVariable.VariableName);
end;

constructor TSQLVariablesForHash.Create(ItemClass: TSQLVariableClass);
begin
  inherited;
  FEnabled := true;
end;

procedure TSQLVariablesForHash.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TSQLVariablesForHash then
    with Source as TSQLVariablesForHash do
      Self.Enabled := Enabled
  else
    Enabled := true;
end;

constructor TPartSQLCode.Create;
begin
  FVariables := TSQLVariables.Create(TSQLVariable);
  FPartSQLCode := TBrockenSQL.Create;
end;

destructor TPartSQLCode.Destroy;
begin
  FVariables.Destroy;
  FPartSQLCode.Destroy;
end;

function TPartSQLCode.AddVariable(AVariableName : String; AValue : Variant;
                                  AVariableType : Integer) : Integer;
begin
  Result := FVariables.Add(AVariableName, AValue, AVariableType).Index;
end;

function TPartSQLCode.AddVariable(AVariableName : String) : Integer;
begin
  Result := FVariables.Add(AVariableName).Index;
end;

function TPartSQLCode.AddVariable(AVariable : TSQLVariable) : Integer;
begin
  Result := FVariables.Add(AVariable.VariableName, AVariable.Value,
                           AVariable.VariableType).Index;
end;

procedure TPartSQLCode.Assign(Source: TPartSQLCode);
var
  I: TSQLKeyWord;
begin
  FVariables.Assign(Source.FVariables);
  for I:= Low(TSQLKeyWord) to High(TSQLKeyWord) do
    FPartSQLCode.SetArea(I, Source.FPartSQLCode.getArea(I));
end;

function TPartSQLCode.RemoveVariable(AVariableName : String) : Integer;
begin
  Result := FVariables.NameToIndex(AVariableName);
  if Result >= 0 then
    FVariables.Delete(Result);
end;

function TPartSQLCode.RemoveVariable(AVariable : TSQLVariable) : Integer;
begin
  if AVariable.Collection = FVariables then
    Result := RemoveVariable(AVariable.VariableName)
  else
    Result := -1;
end;

procedure TPartSQLCode.DeleteVariable(Index : Integer);
begin
  FVariables.Delete(Index);
end;

function TPartSQLCode.GetVariable(AVariableName : String) : TSQLVariable;
begin
  Result := FVariables.NameToVariable(AVariableName);
end;

procedure TPartSQLCode.InsertVariable(Index: Integer; AVariableName : String;
                                  AValue : Variant; AVariableType : Integer);
begin
  FVariables.Insert(Index, AVariableName, AValue, AVariableType);
end;

procedure TPartSQLCode.InsertVariable(Index: Integer; AVariableName : String);
begin
  FVariables.Insert(Index, AVariableName);
end;

procedure TPartSQLCode.InsertVariable(Index: Integer; AVariable : TSQLVariable);
begin
  FVariables.Insert(Index, AVariable.VariableName, AVariable.Value,
                    AVariable.VariableType);
end;

function TPartSQLCode.NameToVariable(AVariableName : String) : TSQLVariable;
begin
  Result := FVariables.NameToVariable(AVariableName);
end;

function TPartSQLCode.NameToIndex(AVariableName : String) : Integer;
begin
  Result := FVariables.NameToIndex(AVariableName);
end;

procedure TPartSQLCode.DeleteAllVariables;
begin
  FVariables.Clear;
end;

procedure TPartSQLCode.Clear;
begin
  DeleteAllVariables;
  FPartSQLCode.DeleteScript;
end;

function TPartSQLCode.GetPartSQLCode(KeyWord : TSQLKeyWord) : String;
begin
  Result := FPartSQLCode.getArea(KeyWord);
end;

procedure TPartSQLCode.SetPartSQLCode(KeyWord : TSQLKeyWord; AValue : String);
begin
  FPartSQLCode.SetArea(KeyWord, AValue);
end;

function TPartSQLCode.GetVariable_(Index : Integer) : TSQLVariable;
begin
  Result := FVariables.Items[Index];
end;

procedure TPartSQLCode.SetVariable_(Index : Integer; Value : TSQLVariable);
begin
  FVariables.Items[Index] := Value;
end;

function TPartSQLCode.GetCountVariable : Integer;
begin
  Result := FVariables.Count;
end;

procedure TPartSQLCode.copyVariables(AVariables : TSQLVariables);
begin
  AVariables.Assign(FVariables);
end;

procedure TPartSQLCode.GetVariablesInSQLCode(AVariables : TStrings);
begin
  FPartSQLCode.GetVariables(AVariables);
end;

procedure TPartSQLCode.GetVariablesInSQLCode(AVariables : TStrings; AKeyWord : TSQLKeyWord);
begin
  FPartSQLCode.GetVariables(AVariables, AKeyWord);
end;

procedure TPartSQLCode.GetVariables(AVariables : TStrings);
var
 I : Integer;
begin
  GetVariablesInSQLCode(AVariables);
  for I := 0 to FVariables.Count - 1 do
    if AVariables.IndexOf(FVariables[I].VariableName) < 0 then
      AVariables.Add(FVariables[I].VariableName);
end;

function TPartSQLCode.ExistVariableInSQLCode(AVar : String) : boolean;
begin
  Result := FPartSQLCode.ExistVariable(AVar);
end;

function TPartSQLCode.ExistVariableInSQLCode(AVar : String; AKeyWord : TSQLKeyWord) : boolean;
begin
  Result := FPartSQLCode.ExistVariable(AVar, AKeyWord);
end;

function TPartSQLCode.ExistVariable(AVar : String) : boolean;
begin
  if FVariables.NameToIndex(AVar) < 0 then
    Result := ExistVariableInSQLCode(AVar)
  else
    Result := true;
end;

procedure TPartSQLCode.ChangeVariable(AOldVar, ANewVar  : String);
var
  Ind : Integer;
  TypeV : Integer;
  Value : Variant;
begin
  Ind := FVariables.NameToIndex(AOldVar);
  if (AOldVar <> ANewVar) and (Ind >= 0) then
  begin
    FVariables.Delete(Ind);
    TypeV := FVariables[Ind].VariableType;
    Value := FVariables[Ind].Value;
    FVariables.Delete(Ind);
    FVariables.Insert(Ind, ANewVar, Value, TypeV);
  end;
  FPartSQLCode.ChangeVariable(AOldVar, ANewVar);
end;

function TPartSQLCode.IsEmpty : boolean;
var
  I : TSQLKeyWord;
begin
  Result := (FVariables.Count = 0);
  if Result then
  begin
    for I:= Low(TSQLKeyWord) to High(TSQLKeyWord) do
      if FPartSQLCode.getArea(I) <> '' then
      begin
        Result := false;
        break;
      end;
  end;
end;

procedure TPartSQLCode.Add(addend : TPartSQLCode);
var
  I : TSQLKeyWord;
  J : Integer;
  str : String;
begin
  for I:= Low(TSQLKeyWord) to High(TSQLKeyWord) do
  begin
    str := addend.PartSQLCode[I];
    if str <> '' then
      FPartSQLCode.AddToArea(I, str);
  end;

  for J := 0 to addend.CountVariable - 1 do
    if not Assigned(GetVariable(addend.Variables[J].VariableName)) then
      AddVariable(addend.Variables[J]);
end;

constructor THashOfSQLVariables.Create;
begin
  FKeys := TStringList.Create;
  FVariables := TList.Create;
end;

destructor THashOfSQLVariables.Destroy;
begin
  Clear;

  FVariables.Destroy;
  FKeys.Destroy;
end;

function THashOfSQLVariables.getVariables(Key : String) : TSQLVariables;
begin
  Result := GetSQLVariables(Key);

  if not Assigned(Result) then
  begin
    Result := TSQLVariablesForHash.Create(TSQLVariable);
    FVariables.Add(Result);
    FKeys.Add(Key);
  end;
end;

function THashOfSQLVariables.getEnabledVars(AKey : String) : boolean;
var
  Ind  : Integer;
  vars : TSQLVariablesForHash;
begin
  // по умолчанию возвращаем значение false
  Result := false;

  // Ищем индекс под которым сохранены переменные с ключом AKey
  Ind := FKeys.IndexOf(AKey);

  if Ind >= 0 then
  begin
    // переменные с ключом AKey имеются

    // Читем переменные
    vars := TSQLVariablesForHash(FVariables[Ind]);

    // Читаем и возвращаем атрибут доступа переменных
    Result := vars.Enabled;
  end;
end;

procedure THashOfSQLVariables.setEnabledVars(AKey : String; AEnabled : boolean);
var
  Ind  : Integer;
begin
  // Ищем индекс под которым сохранены переменные с ключом AKey
  Ind := FKeys.IndexOf(AKey);

  if Ind >= 0 then
  begin
    // переменные с ключом AKey имеются

    // Устанавливаем атрибут доступности для переменных сохраненных под ключом AKey
    TSQLVariablesForHash(FVariables[Ind]).Enabled := AEnabled;
  end;
end;

procedure THashOfSQLVariables.GetAllKeys(AKeys : TStrings);
begin
  AKeys.Clear;
  AKeys.AddStrings(FKeys);
end;

procedure THashOfSQLVariables.GetKeys(AKeys : TStrings);
var
  I : integer;
begin
  AKeys.Clear;

  for I := 0 to FKeys.Count - 1 do
    // Проверяем атрибут доступа у переменных
    if TSQLVariablesForHash(FVariables[I]).Enabled then
      // Переменные достпные
      // Добовляем в возвращаемый список ключ переменных
      AKeys.Add(FKeys[I]);
end;

function THashOfSQLVariables.ExistKey(AKey : String) : boolean;
begin
  Result := (FKeys.IndexOf(AKey) >= 0);
end;

function THashOfSQLVariables.getVariable(AName : String) : TSQLVariable;
var
  I : Integer;
begin
  Result := nil;

  for I := 0 to FVariables.Count - 1 do
  begin
    Result := TSQLVariables(FVariables[I]).NameToVariable(AName);
    if Assigned(Result) then
      Exit;
  end;
end;

function  THashOfSQLVariables.getVariable(AName : String; var AKey : String) : TSQLVariable;
var
  I : Integer;
begin
  Result := nil;
  AKey := '';

  for I := 0 to FVariables.Count - 1 do
  begin
    Result := TSQLVariables(FVariables[I]).NameToVariable(AName);
    if Assigned(Result) then
    begin
      AKey := FKeys[I];
      Exit;
    end;
  end;
end;

procedure THashOfSQLVariables.SetVariable(AName : String; AValue : Variant);
var
  I : Integer;
  variable : TSQLVariable;
begin
  for I := 0 to FVariables.Count - 1 do
  begin
    variable := TSQLVariables(FVariables[I]).NameToVariable(AName);
    if Assigned(variable) then
      variable.Value := AValue;
  end;
end;

function THashOfSQLVariables.getEnabledVariable(AName : String) : TSQLVariable;
var
  I : Integer;
begin
  Result := nil;

  for I := 0 to FVariables.Count - 1 do
  begin
    with  TSQLVariablesForHash(FVariables[I])  do
    begin
      if Enabled then
      begin
        // переменные доступны

        // Ищем переменныю с именем AName
        Result := NameToVariable(AName);

        if Assigned(Result) then
        // Переменная найдена, выходим из функции
          Exit;
      end;
    end;

  end;
end;

function  THashOfSQLVariables.getEnabledVariable(AName : String; var AKey : String) : TSQLVariable;
var
  I : Integer;
begin
  Result := nil;
  AKey := '';

  for I := 0 to FVariables.Count - 1 do
  begin
    with  TSQLVariablesForHash(FVariables[I])  do
    begin
      if Enabled then
      begin
        // переменные доступны

        // Ищем переменныю с именем AName
        Result := NameToVariable(AName);

        // Читем ключ
        AKey := FKeys[I];

        if Assigned(Result) then
        // Переменная найдена, выходим из функции
          Exit;
      end;
    end;

  end;
end;

procedure THashOfSQLVariables.Delete(AKey : String);
var
  Ind : Integer;
begin
  Ind := FKeys.IndexOf(AKey);

  if Ind >= 0 then
  begin
    FKeys.Delete(Ind);
    TSQLVariables(FVariables[Ind]).Destroy;
    FVariables.Delete(Ind);
  end;
end;

procedure THashOfSQLVariables.Clear;
var
  I : Integer;
begin
  for I := 0 to FVariables.Count - 1 do
    TSQLVariables(FVariables[I]).Destroy;

  FKeys.Clear;
  FVariables.Clear;
end;

function THashOfSQLVariables.GetSQLVariables(AKey : String): TSQLVariables;
var
  Ind : Integer;
begin
  Result := nil;
  Ind := FKeys.IndexOf(AKey);

  if Ind >= 0 then
    Result := TSQLVariables(FVariables[Ind]);
end;

end.
