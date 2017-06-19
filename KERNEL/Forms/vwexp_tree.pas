unit vwexp_tree;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vwtree, ExtCtrls, ImgList, vDbASUP, Menus, Db, StdCtrls, Buttons, TB97,
  TB97Tlbr, ComCtrls, Grids, DBGrids, RXDBCtrl, vExpandedNode, contnrs, typinfo, v_anyform,
  oracleData, vworkform, oracle, v_krconsts, CommCtrl;

const
  PrefixOfVarOfSubDataSet = '$_E';

type
  TRecordCollate = class;
  TfmExpandedTreeTopology = class;

////////////////////////////////////////////////////////////////////////////////

  TOnAddDelExpNodeList       = procedure(ANode : TVExpandedNode; Index : Integer) of object;
  TOnChangeExpNodeList       = procedure(ANewNode, AOldNode : TVExpandedNode; Index : Integer) of object;
  TArrayOfDataSet            = array of TDataSet;
  TArrayOfOracleDataSet      = array of TOracleDataSet;
  TArrayOfVariant            = array of Variant;
  TTwoDimensArrayOfVariant   = array of TArrayOfVariant;
  TArrayOfString             = array of String;
  TArrayOfInteger            = array of Integer;
  TThreeDimensArrayOfVariant = array of TTwoDimensArrayOfVariant;
  TArrayOfTreeNode           = array of TTreeNode;
  TArrayOfArrayOfInteger     = array of TArrayOfInteger;
  TArrayOfRecordCollate      = Array of TRecordCollate;

////////////////////////////////////////////////////////////////////////////////

  TExpandedNodesForWindow = class(TExpandedNodes)
  private

    FOnAdd    : TOnAddDelExpNodeList;
    FOnChange : TOnChangeExpNodeList;
    FOnDelete : TOnAddDelExpNodeList;

  protected

    FExpandedNodes : TObjectList; // ������ ����������� ����� ������

    function  GetExpandedNode(Index : Integer) : TVExpandedNode; override;
    procedure SetExpandedNode(Index : Integer; Value : TVExpandedNode); override;

    function GetCount : Integer; override;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Delete(Index : Integer); override;
    procedure Clear; override;
    procedure Insert(Index : Integer; Value : TVExpandedNode); override;
    procedure Add(Value : TVExpandedNode); override;
    function  IndexOf(Value : TVExpandedNode) : Integer; override;

    property OnAdd    : TOnAddDelExpNodeList read FOnAdd    write FOnAdd;
    property OnChange : TOnChangeExpNodeList read FOnChange write FOnChange;
    property OnDelete : TOnAddDelExpNodeList read FOnDelete write FOnDelete;

  end;

////////////////////////////////////////////////////////////////////////////////

   // ��������� ������������ ��� ������������� ��������
   // ��� �������� DataSet, ������ ��� Detail-�� (� ������ ������ ���� TDataSetWithDetailsForSynch)
   // � ������� �������, ������� ��������� ����������������
   // � ��������� ��������� ������ DataSet-��
   TDataSetWithDetailsForSynch = record
     DataSet  : TDataSet; //
     position : Integer;  // ������� �������, ������� ��������� � ��������� ��������� ������ DataSet-��
     Details  : TList;
   end;

   PDataSetWithDetailsForSynch = ^TDataSetWithDetailsForSynch;

////////////////////////////////////////////////////////////////////////////////

   // ����� ���� ���������
   TCollatedField = class
   private
     // ����
     FField : TField;
     // �������� ��� ��������� � ����� (FField)
     FCollatedValue : Variant;

     // ������� ���������� ��� ����
     function getNameOfField : String;
   public

     constructor Create(AField : TField; ACollatedValue : Variant);

     // ���������� ������� �������� ���� � ��������� Value
     function equals : boolean;

     // ��� ����
     property Name : String read getNameOfField;
     // �������� ����
     property CollatedValue : Variant read FCollatedValue;
   end;

////////////////////////////////////////////////////////////////////////////////

   // ����� ����� ���������
   TCollatedFields = class
   private
     // ������ ����� ���������
     FCollatedFields : TList;

     // ��������� ����� ����� ���������
     function getFieldCount : Integer;
     // ���������� ���� ��������� � �������� Ind
     function getField(Ind : Integer) : TCollatedField;
   protected
     // ��������� ����� ����� ���������
     property Count : Integer read getFieldCount;
     // ������ ����� ���������
     property Items[Index : Integer] : TCollatedField read getField;
   public
     // �����������
     // AExNode      - ����������� ����
     // Ind          - ������ ����� ������������ ���� � ������� � AExNode
     // ACollFieldExNode - ���� true, �� �������� ��� ��������� ����� ������ �� ����� ����������� ����,
     //                    ����� �� DataSet
     constructor Create(AExNode : TVExpandedNode; Ind : Integer; ACollFieldExNode : boolean); virtual;

     destructor Destroy; override;

     // ���������� ������� �������� ����� � ���������� ��� ���������
     function equals : boolean;

     // ���������� ����� �����, �� ������� ���� �����
     // ������� ���������� �������� ����� � �������, ������� ���������
     // ��� ������ TOracleDataSet.SearchRecord
     function getFieldNames : string;

     // ���������� ��������, �� ������� ���� ����������� ������
     // ������� ���������� �������� � �������, ������� ���������
     // ��� ������ TOracleDataSet.SearchRecord
     function getFieldValues : TArrayOfVariant;
   end;

////////////////////////////////////////////////////////////////////////////////

   // ����� ��������� ������ � ������� ������
   TRecordCollate = class
   private
     // ������ �������� ��������� ������ � ������� ��� Detail DataSet-��
     FDetail     : TList;
     // ������ ��������� �������� ����� � ���������� ������� ������
     FCollFields : TCollatedFields;

     FDataSet : TOracleDataSet;

     // ���������� ����� ������� ������� ������ � ������� ��� Detail-�� DataSet-��
     function GetDetailCount : Integer;

     // ���������� ������ ������� ������ � ������� ��� Detail-�� DataSet-��
     function GetDetails(Ind : Integer) : TRecordCollate;

     // ���������� ������ ��������� ������ � ������� ��� Detail-�� � ������� ���������� Level
     // � �������� Ind
     function GetRecordCollate(Level : Integer; Ind : Integer) : TRecordCollate;

   public
     // �����������
     // ACollExNode - ���� true, �� �������� ��� ��������� ����� ������ �� ����������� ����,
     //                ����� �� DataSet
     // AFirstInd   - ��������� ������ ������ ������ � ������� ���������� ������ ����� ADataSet
     // ACreatedDetail - ���� true, �� ��������� RecordCollate � ��� Detail-�� ADataSet
     //                  ����� �� ���������
     constructor Create(ADataSet : TOracleDataSet; AExNode : TVExpandedNode; ACollExNode : boolean; AFirstInd : Integer = 0; ACreatedDetail : boolean = true);

     destructor Destroy; override;

     // ����� ������� ������� ������ � ������� ��� Detail-�� DataSet-��
     property DetailCount : Integer read GetDetailCount;

     // ������ ������� ������ � ������� ��� Detail-�� DataSet-��
     property Details[Ind : Integer] : TRecordCollate read GetDetails;

     property RecordsCollates [Level : Integer; Ind : Integer] : TRecordCollate read GetRecordCollate; default;

     // DataSet, � ������� �������������� ������� ������
     property SynchrDataSet : TOracleDataSet read FDataSet;

     // ���������� ����� �����, �� ������� ���� �����
     // ������� ���������� �������� ����� � �������, ������� ���������
     // ��� ������ TOracleDataSet.SearchRecord
     function getFieldNames : string;

     // ���������� ��������, �� ������� ���� ����������� ������
     // ������� ���������� �������� � �������, ������� ���������
     // ��� ������ TOracleDataSet.SearchRecord
     function getFieldValues : TArrayOfVariant;

     // ���������� ������, ��� � ������ ������� �������� ��������-�������, ��� ������� ������
     // DataSet �������� ������� (1 - �������� �������; 0 - �� �������� �������);
     // � ������ �������� �������� ���������� Detail-�� � DataSet-�, � ������� ������� ������
     // �������� ������� ������
     // � ������ �������� �������� ���������� Detail-�� � Detail-�� DataSet, � ������� ������� ������
     // �������� ������� ������
     // ���
     // ������ ������� ���������� ����� ������� ���������� Detail-�� � DataSet + ���� (������� ���. ���.
     // �������)
     function findedRecords : TArrayOfInteger;

     // ���������� ������� �� ������ ��� ������ ������ ����  ���� �� ������� �� Details-�,
     // ���� �� ���� ���, �� ���������� �������� False, ����� True
     function HasSearchData : boolean;

     // ���������� ������� �� ������ ��� ������ ������
     function HasSearchSelfData : boolean;

     procedure Pack;

     // ���������� ������, ��� � ������ �������� �������� 1;
     // � ������ �������� �������� ���������� Detail-�� � DataSet-�;
     // � ������ �������� �������� ���������� Detail-�� � Detail-�� DataSet;
     // ���
     // ������ ������� ��������� ����� ������� ���������� Detail-�� � DataSet + ���� (DataSet)
     function NumberOfDataSetAndDetail : TArrayOfInteger;

     // ���������� �������� �� ADataSet SynchrDataSet-�� ��� � Detail-�� SynchrDataSet-��
     function HasSynchrDataSet(ADataSet : TOracleDataSet) : boolean;

     // ���������� ��� �������
     class function CompareArrs(Arr1 : TArrayOfInteger; Arr2 : TArrayOfInteger) : Integer;

     // ���������� ��� �������
     class function sumArrayOfInt(Arr1 : TArrayOfInteger; Arr2 : TArrayOfInteger) : TArrayOfInteger;

     // ����������, ����� �� ��� ADataSet ������� ������ ��������� ������ � ������� ������
     class function CanBuild(ADataSet : TOracleDataSet; AExNode : TVExpandedNode) : boolean;
   end;

////////////////////////////////////////////////////////////////////////////////

   // ����� ������������� �������
   TSynchrRecords = class
   private
     // ������ ��������� ������ � ������� ������ DataSet-�� � APrototype
     FMainRecordCollate   : TArrayOfRecordCollate;
     // ������� ��������� ������� � �������� �������� � ��������� ���������� DataSet-��
     FOtherRecordCollate : TArrayOfRecordCollate;
     // DataSet, �� �������� ���� �������������
     FDataSet             : TOracleDataSet;


     // �������� ������ ��� ������� fullFindRecord � currFindRecord
     FFindedMainRecords  : TArrayOfInteger;
     FFindedOtherRecords : TArrayOfInteger;
     // �������� ������ ��� ������� fullFindRecord � currFindRecord
     // ������ DataSet �� ������� ��� ���� ����� � RecordCollate �� �������� ������ ��� ������
     FEmptySearchDataSet : TList; //[i]TStrings;
     // �������� ������ ��� ������� fullFindRecord � currFindRecord
     // ������ DataSet �� ������� ��� ���� ����� � RecordCollate �������� ������ ��� ������
     FSearchDataSet : TList;//[i]TList;
     // �������� ������ ��� ������� fullFindRecord � currFindRecord
     // ������ �� ������� � �� DataSet-��, � �� ������� ��� ������ ������ RecordCollate
     FFindRecordCollate : TList;
     // �������� ������ ��� ������� fullFindRecord � currFindRecord
     // ������ �� �������, � ������� ����������� DataSet � �� �������� RecordCollate
     // ������� ����� ������
     FFindDataSetNow   : array  of TArrayOfInteger;
     FCanFindDataSet   : Array of Array of boolean;

     // ������� ������ ��������� ������ � ������� ������
     // �������� ��� ������ ����� ����� � ������� ������ APrototype
     // � ASynchr ����� ����� ������, � ������� ��������� � ���������
     // ���������� ������� ������ � APrototype
     function buildRecordCollate( APrototype : TOracleDataSet; ASynchr : TVExpandedNode;  AFirstInd : Integer = 0) : TRecordCollate; overload;
     function buildRecordCollate(APrototype : TVExpandedNode;  ASynchr : TOracleDataSet; AFirstInd : Integer = 0) : TRecordCollate; overload;

     // ���o������ ������� ��������� �������� � DataSet-��
     procedure savePosition(ASynchrData : PDataSetWithDetailsForSynch);
     // ������������� ������� �������� � DataSet-��, �� �������, ������� ���� ��������� ���������� savePosition
     procedure SetPosition(ASynchrData : TDataSetWithDetailsForSynch);

     // ��������� ������ ��������, ������� ������ �������� ��� ���������� ������� ���������,
     // ���� � ���� DataSet-�� ������� ������ ������� ���������� � ������� �������
     function indiciumSearch(AReordsCollate : TArrayOfRecordCollate) : TArrayOfInteger;

     // ��������� ������ ���������� ��������� �������
     function findedRecords(AReordsCollate : TArrayOfRecordCollate) : TArrayOfInteger;

     // ���������� ������ ��������� ������ � ������� ��� Detail-�� � ������� ���������� Level
     // � �������� Ind
     function GetMainRecordCollate(Level : Integer; Ind : Integer) : TRecordCollate;

     // ���������� ������ ��������� ������ � ������� ��� Detail-�� � ������� ���������� Level
     // � �������� Ind
     function GetOtherRecordCollate(Level : Integer; Ind : Integer) : TRecordCollate;

     procedure Pack_;

     // ������ ����� ������
     // ALevel - �������  ����������, Detail-�� � ������� ����� ����� ������
     // FEmptySearchDataSet - ������ DataSet-��, � ������� �� ����� ������� ������� �� ���� ������ �� ������ ������
     //                       � �������� Objects ����� ��������� ������ ���� Boolean,
     //                       ���� ����� �������� true, �� ���������� ������,
     //                       ��� ����� ����������� ����� ������ DataSet �� ����� ������� ������,
     //                       ������� �� ��������� ������, ���� false �� ������ �� ������
     // FSearchDataSet      - ������ DataSet-��, � ������� �� ����� ������� ������ ���� ������ �� ������
     // AMainSearch         - ������ ���������� Detail-�� �� ������ ������ ���������� ��������� ������
     // FFindedMainRecords  - ������� � �������� ��������, � ������� ����������� � ������������
     //                       ���������� ���������� Detail-�� �� ������ ������ ����������,
     //                       ��� ���� ������� ������ ��������� ������
     // AOtherSearch        - ������ ���������� Detail-�� �� ������ ������ ���������� ����������� ������
     // FFindedOtherRecords - ������� � �������� ��������, � ������� ����������� � ������������
     //                       ���������� ���������� Detail-�� �� ������ ������ ����������,
     //                       ��� ���� ������� ������ ����������� ������
     // ASynchrData         - ������ �������� ������� �������� � Dataset-�� �������� ����������
     // ���������� true, ���� ������� ������ ���� �������, ����� false
     function fullFindRecord(ALevel : Integer;
                             AMainSearch : TArrayOfInteger; AOtherSearch : TArrayOfInteger;
                             ASynchrData : PDataSetWithDetailsForSynch) : boolean;
     // ����� �� ������� ������
     function currFindRecord(ALevel : Integer;
                             AMainSearch : TArrayOfInteger; AOtherSearch : TArrayOfInteger;
                             ASynchrData : PDataSetWithDetailsForSynch) : boolean;

     // ����� c ������� ������ DataSet-��, � ������� ���� �������� ������
     function find_(ALevel : Integer; ASynchrData : PDataSetWithDetailsForSynch) : boolean;
     // ���������� �� ��������� ������ ������ DataSet, � ������� ��� ������ � ��������� ������� ������
     function findEmpty_(ALevel : Integer; ASynchrData : PDataSetWithDetailsForSynch) : boolean;

     // ���������� �������� �� ADataSet SynchrDataSet-�� ��� � Detail-�� SynchrDataSet-��
     function HasSynchrDataSet(ADataSet : TOracleDataSet) : boolean;

     procedure InitLevel(ALevel : Integer;
                         AMainSearch : TArrayOfInteger; AOtherSearch : TArrayOfInteger);
   public
     // �����������
     // APrototype - �������, �� �������� ����� ���������������� ������
     // ASynchr    - ��������, ������� ����� ����������������
     // AExNodeList - ������ ����������� �����
     constructor Create(AOwner : TfmExpandedTreeTopology; APrototype : TVExpandedNode; ASynchr : TVExpandedNode; AExNodeList : TExpandedNodes); overload;
     constructor Create(AOwner : TfmExpandedTreeTopology; APrototype : TOracleDataSet; ASynchr : TVExpandedNode; AExNodeList : TExpandedNodes); overload;
     constructor Create(AOwner : TfmExpandedTreeTopology; APrototype : TVExpandedNode; ASynchr : TOracleDataSet; AExNodeList : TExpandedNodes); overload;

     destructor Destroy; override;

     procedure synchr;
   end;

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

  TfmExpandedTreeTopology = class(TfmTreeTopology)
    procedure pcMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pcMainChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    FExpandedNodes : TExpandedNodes;

    FTableTabSheetListOfExNodes : TTabSheetList;

    // ������ DataSet-�� ������� ����� ������( �� ����������� �����), � ������� ��������� ��������� ������
    FModifyDataSetOfSimpleNode : TList;
    // ������ ������ �������, � ������� ���������� ������ �����  ��������� ��������� � DataSet-�� ������� ����� ������
    FListModifyTabSheetBeforeModifyDataSet : TList;

    //
    FChangingPageContrMain : boolean;

    // ������ ���������� �������� �������� � pcMain
    FOldIndTab_pcMain : Integer;

    // ����������� ���������� ��������� � pcMain
    FWndProc_pcMain : TWndMethod;


    procedure TreeTopologyAddExpNode(ANode : TVExpandedNode; Index : Integer);
    procedure TreeTopologyDeleteExpNode(ANode : TVExpandedNode; Index : Integer);
    procedure TreeTopologyChangeExpNode(ANewNode, AOldNode : TVExpandedNode; Index : Integer);
    function  GetExpandedNode(Index : Integer) : TTabSheet;

    procedure GetDataSetsOfSN(ANode : TTreeNode; AList : TList);
    function  FindSimpleNode(ADataSet : TDataSet) : TTreeNode;

    procedure FindCursorENFields(ExpandedNode : TVExpandedNode; FieldList : TList; var ValueList : TThreeDimensArrayOfVariant);
    { ������� ���� ������������ ����, �� ������� ��������������� ������ ������������ ����
      �������� ��������� ������� ������� ����� � ���������� ������ ������������ ����� �
      ������ �������� ����� ����������� ����, ������� ������ ����� � ������,
      �� ������� ����� ���������� ������
    }

    procedure SetModifiable(ADataSet : TDataSet);
    { �������������, ��� ������ ADataSet ���������
    }

    function IsMaster(MasterDataSet : TOracleDataSet; DetailDataSet : TOracleDataSet) : boolean;
    { ���������� true, ���� MasterDataSet �������� ������� ��� DetailDataSet
      ����� ��������� false
    }

    function IsVariableOfSubDataSet(AName : String) : boolean;
    { �� ������������ ���������� ����������, ��� �������� ���������� ������ �� ������ DataSet-��
      ��� ��� ����������� ���������� DataSet-� ������������ ����.
      ���� ��� �������� ���������� ������ �� ������ DataSet-��, �� ������� �����. true
      ����� false
    }

    function GetNameOfVarOfSubDataSet(AVariable : String; ANumber : Integer) : String;
    { ���������� ��� ���������� ����������� ����,
      ������� ���. ���������� ������ �� DataSet �������� ���� ������,
      AVariable - ��� ���������� �������� ����
      ANumber   - ���������� ����� � ������� DataSet �������� ���� ������
    }

    function GetNameField(AName : String; ADataSet : TDataSet) : String;
    { ��������� Name �������� ������� ������������� ����� ��� ������������ ������������� ����� � DataSet
      � ���������� ������� ������������ ����
    }

    function GetField(AName : String; ADataSet : TDataSet) : TField;
    { ��������� Name �������� ������� ������������� ����� ��� ������������ ������������� ����� � DataSet
      � ���������� ����
    }

    function IsExNodeCursor(ValuesOfFields : TThreeDimensArrayOfVariant; Fields : TList) : boolean; overload;
    function IsExNodeCursor(ValuesOfFields : TTwoDimensArrayOfVariant; Fields : TList)   : boolean; overload;
    function IsExNodeCursor(ValuesOfFields : TArrayOfVariant; Fields : TList)            : boolean; overload;

    function GetFirstSimpleNode(ASimpleNodes : TArrayOfTreeNode; AExpNode : TVExpandedNode) : TTreeNode;
    { ���������� �� ������ ASimpleNodes (��� ASimpleNodes - ������ �������� ������� �����)
      ���� ������, ������� �����  ���������� ����� ������ ����� ����� � ������� �
      ����������� ����������� ���� AExpNode
    }

    function GetFinalSimpleNode(ASimpleNodes : TArrayOfTreeNode; AExpNode : TVExpandedNode) : TTreeNode;
    { ���������� �� ������ ASimpleNodes (��� ASimpleNodes - ������ �������� ������� �����)
      ���� ������, ������� �����  ���������� ����� ������ ����� ����� � ������� �
      ����������� ����������� ���� AExpNode
    }

    function IsDataSetInExNode(ADataSet : TDataSet; AExpNode : TVExpandedNode) : Boolean;
    { ���������� true, ���� DataSet ������ � ������ ������������ ����,
      ����� ��������� false
    }

    function GetDataSetWithNewParametr(ADataSet : TOracleDataSet; AFields : TList; AValues : TTwoDimensArrayOfVariant) : TOracleDataSet; overload;
    function GetDataSetWithNewParametr(ADataSet : TOracleDataSet; AFields : TList; AValues : TArrayOfVariant) : TOracleDataSet; overload;
    { ���������� DataSet, �������������� �� ADataSet (������ � ������� �� ���������� � ����� DataSet)
      ����� DataSet �������� ����� �� ������, � ������� ���� AFields �������� �������� AVariant
    }

    function SetMasterDataSetCursorsWithOracle(ADataSet : TOracleDataSet; AFields : TList; AValues : TArrayOfVariant;
                                         AMasterDataSet : TOracleDataSet
                                         ) : boolean;
    {
       ������������� ������� � DataSet-�� ������� ����� ������ ��� ������ SQL �������� � Oracle
    }

    function SetDetailDataSetCursors(AActiveDetails : TArrayOfOracleDataSet;
                                     AExpNode : TVExpandedNode) : boolean;

    function GetSNMasterSupportExNodeSynch(ADataSet : TOracleDataSet) : TOracleDataSet;
    { ���������� ������� �������� �������� ������ ADataSet,
      ������� ������ � ������ ������ ��� ������������� ������������ ����;
      ���� ��� ������ �������,
      � ADataSet ������ � ������ ������ ��� ������������� ������������ ����,
      �� ������� ���������� ADataSet;
      ���� � AdataSet �� ������ � ������, �� ������� ���������� �������� nil
    }

    //function SetSuperMasterDataSetCursors
  protected
    procedure HideTabSheetOfNoSignNodes;
    {������ �������� ����������� �� � �������� ���� ������, ����������}

    // ����� ������������� ��� ��������� � ������������ �� � pcMain
    procedure WndProc_pcMain(var Message: TMessage); virtual;

    procedure AddTableTabSheeOfExNode(var ASheet : TTabSheet; AExpNode : TVExpandedNode); virtual; // ��������� ��������-������� ��� ������������ ����
    procedure DeleteTableTabSheeOfExNode(ASheet : TTabSheet; AExpNode : TVExpandedNode ); virtual; // ������� ��������-������� ��� ������������ ����
    procedure ChangeTableTabSheeOfExNode(var ANewSheet : TTabSheet; ANewExpNode : TVExpandedNode;
                                             AOldSheet : TTabSheet; AOldExpNode : TVExpandedNode); virtual; // �������� ��������-������� ��� ������������ ����
    procedure scanTSList(var ASheet : TTabSheet; ADataSource : TDataSource); virtual; // � ASheet ������������ ����� �� ��������� ��� � tsList
    property  TableTabSheetListOfExNodes[Index: Integer]  : TTabSheet read GetExpandedNode; // ������ ��������-������ ��� ����������� �����

    // ���������� DataSet, ��������� ���� ������ (�������� ���� �� ������������)
    function GetDataSetOfActiveNode : TVASUPQuery; virtual;

    // ���������� DataSet-�, ��������� ���� ������ � ��� ������������ �����
    // ������ DataSet � ������� ��������� ����, ������ DataSet ������ ������� DataSet
    // ������ DataSet ������ ������� DataSet ���
    // (������� ����� �� �����������)
    function GetDataSetsOfActiveNodes : TArrayOfORacleDataSet; virtual;

    // ���������� �������� ���� ������ � ��� ������������ �����
    // ������ ���� ��������, ������ ���� �������� ������� ����,
    // ������ ���� �������� ������� ���� ���
    // (������� ����� �� �����������)
    function GetActiveNodes : TArrayOfTreeNode;

    // ���������� �������� ���� ������
    function GetActiveTreeNode : TTreeNode;

    // ���������� DataSet-�, ��������� ���� ������ � ��� �������� �����
    //(������� ����� �� �����������)
    function GetDataSetsOfSimpleNode(ADataSet : TDataSet) : TArrayOfORacleDataSet; virtual;

    procedure ExNodeToSimpleNodeList(ExpandedNode : TVExpandedNode; SimpleNodeList : TList);
    { ���������� ������ ������� �����, ������� ��������� ����������� ���� ������
    }

    procedure ChangeActivePages; override;

    procedure ChangeVisibleTabSheet; virtual; // ����������� ���� ������� ��������� ��� ���

    function FindAreaDataSet(Area: TWinControl):TDataSet; override;

    function FindExpNTDBGrid(AExpandedNode: TVExpandedNode):TDBGrid; virtual;

    function IsRenewedTabSheet(ASheet : TTabSheet; ADataSet : TDataSet) : boolean; virtual;
    { ���������� ���� �� ��������� �������� ASheet ����� ���������� ADataSet,
      ���� �� �� ��������� true, ���� ��� �� ��������� false
    }


    // ���������� True, ���� �������� ��������� � ������������ ���� ������
    // ����� ���������� False
    function IsTabSheetOfExtendedNode(ASheet : TTabSheet) : boolean; virtual;

    procedure InitASUPQueryInTabSheet(ASheet : TTabSheet); virtual;

    //function ApplyPageUpdates:boolean; override;

    function IsTabSheetOfTabSheetExtdNode(ASheet : TTabSheet) : boolean;
    function IsTabSheetOfTablExtNode(ASheet : TTabSheet) : boolean;
    procedure DenyAccess; override;

    procedure ApplyAccessTabSheet(ASheet : TTabSheet); virtual;
    { ������� ����������, ����� �������� �������� ������ �� ��������  ASheet.
      ������� ����������� �������� AccessRights.
      ������� �� ������ ��������� �������, ��� ���� ��� ���� ���������
    }

    procedure ChangeCurrentSet(NewDataSet: TDataSet); override;

    function IsDataSetOfSimpleNode(ADataSet : TDataSet) : boolean; virtual;
    { ���������� true, ���� DataSet ����������� � �������� ���� ������,
      ����� ��������� ����}

    function IsDataSetOfExpandedNode(ADataSet : TDataSet) : boolean; virtual;
    { ���������� true, ���� DataSet ����������� � ������������ ���� ������,
      ����� ��������� ����}

    function GetVertexSNDataSetsForDataSetOfExNode(ExpandedNode : TVExpandedNode) : TArrayOfDataSet;
    { ���������� ������ DataSet-�� ������� �����, ������� �������� ��������� ����� ������� �����
      ������� ������������ SQL ������ ��� ������������ ���� ExpandedNode}

    //function GetVertexSNDataSetsForDataSetOfExNode(ExpandedNode : TVExpandedNode) : TArrayOfDataSet; virtual;
    { ���������� ������ DataSet-�� ������� �����, ������� �������� ��������� ����� ������� �����
      ������� ������������ SQL ������ ��� ������������ ���� ExpandedNode}

    procedure BuildQueryForExNode(ExpandedNode : TVExpandedNode); virtual;
    { ���������� ������ ��� ������������ ���� ������,
      ��������� ��� ������� ������� � DataSet-�� �� ������� ArrayOfDataSets
    }

    procedure RefreshDataOfExNode(ExpandedNode : TVExpandedNode; AllowReadDataSet : boolean = true; ASheet : TTabSheet=nil); virtual;
    { ��������� ������ ��� ������������ ����,
      ��������� ����� ��� �������� ASheet ������������ ����

      ���� AllowReadDataSet = true, �� ������ DataSet ����������� ���� ����� ����������,
      ����� �� �����
    }

    function NeedToSaveDataOfSheetOfExNode(ExpandedNode : TVExpandedNode; ASheer : TTabSheet=nil) : boolean; virtual;
    {  ���������� ��� �������� ������������ ���� ���������� �������� ������ ��� ���
    }

    function ExtNodeToSheet(ExpandedNode : TVExpandedNode) : TTabSheet; virtual;
    { ���������� �������-�������� ��� ����������� ����� ExpandedNode � ���������� �
    }

    function SheetToExtNode(ASheet : TTabSheet) : TVExpandedNode; virtual;
    { ���������� ����������� ���� ������ ��� �������-�������� ASheet � ���������� �,
      ���� ��� ������� ����, �� ���������� nil
    }

    procedure OpenExNodeSession(ExpandedNode : TVExpandedNode; AllowReadDataSet : boolean = true); virtual;
    { ��������� ������ ��� ����������� ����

      ���� AllowReadDataSet = true, �� ������ DataSet ����������� ���� ����� ����������,
      ����� �� �����
    }

    procedure CloseExNodeSession(ExpandedNode : TVExpandedNode); virtual;
    { ��������� ������ ��� ����������� ����
    }

    procedure CloseAllExNodeSession;virtual;
    { ��������� ��� ������ ��� ����������� ����� ������
    }

    function DataSetToExNode(ADataSet : TDataSet) : TVExpandedNode;

    procedure synchrPosition(ExpandedNode : TVExpandedNode; BySimpleNode : boolean = true);{(ADataSet : TDataSet; SynchDataSet : TDataSet);} virtual;
    { �������������� ������� ��������.
      ADataSet - ����������� ����.
      DataSet, � �������� �������������� ������� �������, � ������ �������
      � �������� ������� SynchDataSet,
      � ����� � � ���������� DataSet-��
    }

    procedure ActivateExNodeDataSet(ExpandedNode : TVExpandedNode);

    procedure UMOthers(var Message:TMessage);message UM_OTHERS;

    procedure SaveGridCols(ADBGrid: TDBGrid=nil); override;

    function GetCurrGrid : TDBGrid; virtual;

    procedure OnModifiable(ADataSet : TDataSet); virtual;
    { ����� ����������, ����� ��������� ������ � ADataSet
      �������������� ����� ��������� ��������
      ����� ������ �������������� �����
    }

    procedure SetRenewed(ASheet : TTabSheet; ADataSet : TDataSet);
    { �������������, ��� �������� ASheet ��������� ������, ������� ����������
      �   ADataSet
    }

    function IsActivePageOfSimpleNode : boolean; virtual;
    {  ���������� true, ���� �������� �������� ��������, ��������� �������� ����,
       ����� ��������� false
    }

    //function NeedToSave(DataSet:TDataSet):bool; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;

    procedure DoBeforePost(ASUPQuery: TVASUPQuery); override;
    procedure DoBeforeOpen(ASUPQuery: TVASUPQuery); override;
    procedure DoBeforeRefresh(ASUPQuery: TVASUPQuery); override;
    procedure DoAfterRefresh(ASUPQuery: TVASUPQuery); override;
  published
    property ExpandedNodes : TExpandedNodes read FExpandedNodes;
  end;

procedure copyDBGrid(Desc : TDBGrid; Source : TDBGrid);
procedure copyFont(Desc : TFont; Source : TFont);
function  GetDataSetOfWinControl(AWinControl : TWinControl; AList : TList) : TList;
function getPosSQLEl(AStr : String; ANameOfEl : String; ind : Integer=1) : Integer;
function getPosSQLElWithoutParenthesis(AStr : String; ANameOfEl : String; ind : Integer=1) : Integer;
procedure GetNotWorkCode(AStr : String; var ABegin : Integer; var AEnd : Integer; ind : Integer=1);
procedure GetParenthesis(AStr : String; var ABegin : Integer; var AEnd : Integer; ind : Integer=1);
{������� ����������, � ��� �� ����� ������� �� ����� ����������: ���������,  ���������� ���}
function IsSpecChar(ch : char) : Boolean;
function InsetrSubQuery(ASQL : String; ASubSQL : String; AMasterField : TFieldNames; ADetailField : TFieldNames) : String;
{�������� � ������� SQL �������� ��� ������}
procedure GetSQLTable(ASubSQL : String; var ANamesOfTables : TArrayOfString; var AAliasOfTables : TArrayOfString);
function GetPosTableandAlias(ASubSQL : String; APos : Integer; var APosBegTabl : Integer; var APosEndTabl : Integer;
                             var APosBegAlias : Integer; var APosEndAlias : Integer) : Integer;
function getPosSQLWithoutParenthesis(AStr : String; ANameOfEl : String; ind : Integer=1) : Integer;
function GetIndTable(ANamesOfTables : TArrayOfString; AAliasOfTables : TArrayOfString; NameOfField : String; ASession : TOracleSession) : Integer;

function DeleteVariableFromSQL(ANameVariable : String; ASQL : String) : String;
function InsertVariableFromSQL(ANameVariable : String; ASQL : String; AField : String) : String;
function GetVariableFromSQL(ANameVariable : String; AField : String) : String;
function InsertIfInSQL(ASQL : String; AIf : String) : String;

function CreateDataSetRecordForSynch(DataSet : TDataSet) : TDataSetWithDetailsForSynch;
{ ������� ������ ��� ��������� ������������� ������� ������� DataSet
}

// ������, ��� ��������� ������ DataSet-�� �� ������������ �� ������ ��������
procedure DisableControls(ASynchrData : TDataSetWithDetailsForSynch);

procedure destroyDataSetWithDetailsForSynch(rec : PDataSetWithDetailsForSynch);

// ������� ���������� �� �� ����������� ��������� ������ DataSet-�� �� ������ ��������
procedure EnableControls(ASynchrData : TDataSetWithDetailsForSynch);

procedure refrSynchDetailDataSet(rec : PDataSetWithDetailsForSynch);

implementation
uses dagreem;

{$R *.DFM}

function ObjToStr(AObject : TObject) : String;
var
  I : Integer;
  pch : PChar;
  p : pointer;
begin
  SetLength(Result, 4);
  p := AObject;
  pch := @p;
  for I := 1 to 4 do
    Result[I] := (pch + I - 1)^;
end;

function StrToObj(AStr : String) : TObject;
var
  I : Integer;
begin
  for I := 1 to 4 do
    (PChar(@Result) + I - 1)^ := AStr[I];
end;

function CreateDataSetRecordForSynch(DataSet : TDataSet) : TDataSetWithDetailsForSynch;
var
  DetailList : TList;
  rec : PDataSetWithDetailsForSynch;
  I : Integer;
begin
  result.DataSet  := DataSet;
  result.position := -1;
  result.Details  := TList.Create;

  DetailList := TList.Create;
  DataSet.GetDetailDataSets(DetailList);

  for I := 0 to DetailList.Count - 1 do
  begin
    New(rec);
    rec^ := CreateDataSetRecordForSynch(TDataSet(DetailList[I]));
    result.Details.Add(rec);
  end;

  DetailList.Destroy;
end;

procedure destroyDataSetWithDetailsForSynch(rec : PDataSetWithDetailsForSynch);
var
  I : Integer;
begin
  if Assigned(rec) then
    with rec^ do
      if Assigned(Details) then
      begin
        for I := 0 to Details.Count - 1 do
        begin
          destroyDataSetWithDetailsForSynch(PDataSetWithDetailsForSynch(Details[I]));
          Dispose(Details[I]);
        end;
        Details.Destroy;
        Details := nil;
      end;
end;

// ������, ��� ��������� ������ DataSet-�� �� ������������ �� ������ ��������
procedure DisableControls(ASynchrData : TDataSetWithDetailsForSynch);
var
  I : Integer;
begin
  ASynchrData.DataSet.DisableControls;
  for I := 0 to ASynchrData.Details.Count - 1 do
    DisableControls(TDataSetWithDetailsForSynch(ASynchrData.Details[I]^));
end;

// ������� ���������� �� �� ����������� ��������� ������ DataSet-�� �� ������ ��������
procedure EnableControls(ASynchrData : TDataSetWithDetailsForSynch);
var
  I : Integer;
begin
  ASynchrData.DataSet.EnableControls;
  for I := 0 to ASynchrData.Details.Count - 1 do
    EnableControls(TDataSetWithDetailsForSynch(ASynchrData.Details[I]^));
end;

function getSynchData(rec : PDataSetWithDetailsForSynch; ADataSet : TOracleDataSet) : PDataSetWithDetailsForSynch;
var
  I, n : Integer;
begin
  Result := nil;
  if Assigned(rec) then
  begin
    if rec^.DataSet = ADataSet then
      Result := rec
    else
    begin
      with  rec^ do
        if Assigned(Details) then
        begin
          i := 0;
          n := Details.Count;
          while (i < n) and (not Assigned(Result)) do
          begin
            Result := getSynchData(PDataSetWithDetailsForSynch(Details[I]), ADataSet);
            inc(i);
          end;
        end;
    end;
  end;
end;

procedure refrSynchDataSet(rec : PDataSetWithDetailsForSynch);
var
  I : Integer;
begin
  if Assigned(rec) then
    with  rec^ do
    begin
      if DataSet.Active then
        DataSet.Refresh;

      if Assigned(Details) then
        for I := 0 to Details.Count - 1 do
          refrSynchDataSet(PDataSetWithDetailsForSynch(Details[I]));
    end;
end;

procedure refrSynchDetailDataSet(rec : PDataSetWithDetailsForSynch);
var
  I : Integer;
begin
  if Assigned(rec) then
    with  rec^ do
    begin
      if Assigned(Details) then
        for I := 0 to Details.Count - 1 do
          refrSynchDataSet(PDataSetWithDetailsForSynch(Details[I]));
    end;
end;

procedure copyDBGrid(Desc : TDBGrid; Source : TDBGrid);
begin
  Desc.DefaultDrawing := Source.DefaultDrawing;
  Desc.Options := Source.Options;
  Desc.ReadOnly := Source.ReadOnly;
  copyFont(Desc.TitleFont, Source.TitleFont);
  Desc.BorderStyle := Source.BorderStyle;
  Desc.FixedColor := Source.FixedColor;
  Desc.Enabled := Source.Enabled;
  Desc.TabOrder := Source.TabOrder;
  Desc.TabStop := Source.TabStop;
  Desc.Align := Source.Align;
  Desc.Anchors := Source.Anchors;
  Desc.Color := Source.Color;
  Desc.Cursor := Source.Cursor;
  Desc.DragMode := Source.DragMode;
  copyFont(Desc.Font, Source.Font);
  Desc.Height := Source.Height;
  Desc.HelpContext := Source.HelpContext;
  Desc.Hint := Source.Hint;
  Desc.Left := Source.Left;
  Desc.ParentColor := Source.ParentColor;
  Desc.ParentFont:= Source.ParentFont;
  Desc.ParentShowHint := Source.ParentShowHint;
  Desc.PopupMenu := Source.PopupMenu;
  Desc.ShowHint := Source.ShowHint;
  Desc.Top := Source.Top;
  Desc.Visible := Source.Visible;
  Desc.Width := Source.Width;
  Desc.Tag := Source.Tag;

  Desc.OnCellClick       := Source.OnCellClick;
  Desc.OnColEnter        := Source.OnColEnter;
  Desc.OnColExit         := Source.OnColExit;
  Desc.OnColumnMoved     := Source.OnColumnMoved;
  Desc.OnDrawColumnCell  := Source.OnDrawColumnCell;
  Desc.OnDrawDataCell    := Source.OnDrawDataCell;
  Desc.OnEditButtonClick := Source.OnEditButtonClick;
  if (Desc is TRxDBGrid) and (Source is TRxDBGrid) then
  begin
    (TRxDBGrid(Desc)).OnTitleBtnClick := (TRxDBGrid(Source)).OnTitleBtnClick;
    (TRxDBGrid(Desc)).OnGetBtnParams  := (TRxDBGrid(Source)).OnGetBtnParams;
    (TRxDBGrid(Desc)).OnGetCellParams := (TRxDBGrid(Source)).OnGetCellParams;
    (TRxDBGrid(Desc)).TitleButtons    := (TRxDBGrid(Source)).TitleButtons;
    (TRxDBGrid(Desc)).ShowGlyphs      := (TRxDBGrid(Source)).ShowGlyphs;
    (TRxDBGrid(Desc)).DefaultDrawing  := (TRxDBGrid(Source)).DefaultDrawing;
  end;
  Desc.OnTitleClick      := Source.OnTitleClick;

  Desc.OnEnter    := Source.OnEnter;
  Desc.OnExit     := Source.OnExit;
  Desc.OnKeyDown  := Source.OnKeyDown;
  Desc.OnKeyPress := Source.OnKeyPress;
  Desc.OnKeyUp    := Source.OnKeyUp;

  //Desc.OnDblClick  := Source.OnDblClick;
  Desc.OnDragDrop  := Source.OnDragDrop;
  Desc.OnDragOver  := Source.OnDragOver;
  Desc.OnEndDock   := Source.OnEndDock;
  Desc.OnEndDrag   := Source.OnEndDrag;
  Desc.OnMouseDown := Source.OnMouseDown;
  Desc.OnMouseMove := Source.OnMouseMove;
  Desc.OnMouseUp   := Source.OnMouseUp;
  Desc.OnStartDock := Source.OnStartDock;
  Desc.OnStartDrag := Source.OnStartDrag;
end;

procedure copyFont(Desc : TFont; Source : TFont);
begin
  Desc.Charset := Source.Charset;
  Desc.Color := Source.Color;
  Desc.Height := Source.Height;
  Desc.Name := Source.Name;
  Desc.Pitch := Source.Pitch;
  Desc.Size := Source.Size;
  Desc.Style := Source.Style;
end;

function  GetDataSetOfWinControl(AWinControl : TWinControl; AList : TList) : TList;
var
  I : INteger;
  PropInfo: PPropInfo;
  dataSet : TDataSet;
begin
  Result := AList;
  if not Assigned(Result) then
    Result := TList.Create;
  with AWinControl do
  begin
    for I := 0 to ControlCount - 1 do
    begin
      PropInfo:= GetPropInfo(Controls[I].ClassInfo,'DataSource');
      if Assigned(PropInfo) then
      begin
        dataSet := TDataSource(GetOrdProp(Controls[I],PropInfo)).DataSet;
        if Assigned(dataSet) then
          if Result.IndexOf(dataSet) < 0 then
            Result.Add(dataSet);
      end;
      if Controls[I] is TWinControl then
        GetDataSetOfWinControl(TWinControl(Controls[I]), Result);
    end;
  end;
end;

procedure GetNotWorkCode(AStr : String; var ABegin : Integer; var AEnd : Integer; ind : Integer=1);
var
  str : String;

  pos_comm1 : Integer; // ������� ������ ���������� --
  pos_comm2 : Integer; // ������� ������ ���������� /*
  pos_comm3 : Integer; // ������� ����� ���������� */
  pos_kav1  : Integer; // ������� ������� '
  pos_kav2  : Integer; // ������� ������� "
  pos_kav3  : Integer; // ������� ������� ''

  p : Integer;

  offs : Integer;
begin
  offs := 0;

  if ind > 1 then
  begin
    str := copy(AStr, ind, length(Astr) - ind + 1);
    offs := ind - 1;
  end
  else
    str := AStr;

  pos_comm1 := pos('--', str);
  pos_comm2 := pos('/*', str);

  pos_kav1  := pos('''', str);
  pos_kav2  := pos('"', str);

  ABegin := 0;
  AEnd := 0;

  if (pos_comm1 > 0) and ((pos_comm1 < pos_comm2) or (pos_comm2 = 0)) and
     ((pos_comm1 < pos_kav1) or (pos_kav1 = 0)) and ((pos_comm1 < pos_kav2) or (pos_kav2 = 0)) then
  begin
    ABegin := offs + pos_comm1;
    str := copy(str, pos_comm1 + 2, length(str) - pos_comm1 - 2 + 1);
    p := pos('' + #13, str);
    if p > 0 then
      AEnd := offs + pos_comm1 + 2 - 1 + p - 1
    else
      AEnd := length(Astr);
  end
  else if (pos_comm2 > 0) and ((pos_comm2 < pos_kav1) or (pos_kav1 = 0)) and
          ((pos_comm2 < pos_kav2) or (pos_kav2 = 0)) then
  begin
    ABegin := offs + pos_comm2;
    str := copy(str, pos_comm2 + 2, length(str) - pos_comm2 - 2 + 1);
    pos_comm3 := pos('*/', str);
    if pos_comm3 > 0 then
      AEnd := offs + pos_comm2 + 2 - 1 + pos_comm3 + 2 - 1
    else
      AEnd := length(Astr);
  end
  else if (pos_kav1 > 0) and ((pos_kav1 < pos_kav2) or (pos_kav2 = 0)) then
  begin
    ABegin := offs + pos_kav1;
    str := copy(str, pos_kav1 + 1, length(str) - pos_kav1 + 1 - 1);
    offs := offs +  pos_kav1;
    p := pos('''', str);
    pos_kav3 := pos('''''', str);
    while p > 0 do
    begin
      if (pos_kav3 = 0) or (p < pos_kav3) then
        break;
      offs := offs +  pos_kav3 + 2 - 1;
      str := copy(str, pos_kav3 + 2, length(str) - pos_kav3 - 2 + 1);
      p := pos('''', str);
      pos_kav3 := pos('''''', str);
    end;
    if p > 0 then
      AEnd := offs + p + 1 - 1
    else
      AEnd := length(Astr);
  end
  else if (pos_kav2 > 0) then
  begin
    ABegin := offs + pos_kav2;
    str := copy(str, pos_kav2 + 1, length(str) - pos_kav2 - 1 + 1);
    p := pos('"', str);
    if p > 0 then
      AEnd := offs + pos_kav2 + 1 - 1 + p + 1 - 1
    else
      AEnd := length(Astr);
  end

end;

procedure GetParenthesis(AStr : String; var ABegin : Integer; var AEnd : Integer; ind : Integer=1);
var
  posOfLeftParenth  : Integer; // ������� �������� ������
  posOfRightParenth : Integer; // ������� �������� ��������

  offs : Integer; // ���. �������� ����������� � ������ ������

  p : Integer;
  str : String;

  begNotWorkCode : Integer; // ������� ������ �� SQL ����
  endNotWorkCode : Integer; // ������� ����� �� SQL ����

  countParenth : Integer; // ����� �� �������� ������
begin
  ABegin := 0;
  AEnd   := 0;

  offs := 0;

  if ind > 1 then
  begin
    // �����������  (ind - 1) �������� � ������ ������
    str := copy(AStr, ind, length(Astr) - ind + 1);
    offs := ind - 1;
  end
  else
    str := AStr;

  // ������� ������� �������� ������
  posOfLeftParenth := pos('(', str);
  // ������� ������� �������� ������
  posOfRightParenth := pos(')', str);
  // ������ ��� ������������� �� SQL ���
  GetNotWorkCode(str, begNotWorkCode, endNotWorkCode);

  if   (posOfLeftParenth = 0)
    or
       (     (posOfRightParenth <> 0)
         and (posOfRightParenth < posOfLeftParenth)
         and ((begNotWorkCode = 0) or (begNotWorkCode > posOfRightParenth))) then
    Exit;

  if (begNotWorkCode <> 0) and (begNotWorkCode < posOfLeftParenth) then
  begin
    if endNotWorkCode < Length(str) then
    begin
      GetParenthesis(str, ABegin, AEnd, endNotWorkCode + 1);
      if ABegin > 0 then
      begin
        ABegin :=  ABegin + offs;
        AEnd   :=  AEnd   + offs;
      end;
    end
  end
  else
  begin
    // ����� ���� �� �������� ������
    countParenth := 1;

    // ������������ ������� �������
    p := posOfLeftParenth;

    ABegin := p + offs;
    AEnd   := Length(AStr);
    while (countParenth > 0) and (p > 0) do
    begin
      str := copy(Str, p + 1, length(str) - p);
      offs := p + offs;

      posOfLeftParenth := pos('(', str);
      posOfRightParenth := pos(')', str);
      GetNotWorkCode(str, begNotWorkCode, endNotWorkCode);

      if posOfRightParenth > 0 then
      begin
        if (begNotWorkCode > 0) and ((posOfLeftParenth = 0) or (begNotWorkCode < posOfLeftParenth))
           and (begNotWorkCode < posOfRightParenth) then
        begin
          if  endNotWorkCode < Length(str) then
            p := endNotWorkCode
          else
            p := 0;
        end
        else if (posOfLeftParenth > 0) and (posOfLeftParenth < posOfRightParenth) then
        begin
          inc(countParenth);
          p := posOfLeftParenth;
        end
        else
        begin
          dec(countParenth);
          if countParenth = 0 then
            AEnd := posOfRightParenth + offs
          else
            p := posOfRightParenth;
        end;
      end
      else
        p := 0;
    end;
  end;
end;

function IsSpecChar(ch : char) : Boolean;
begin
  if (ord(ch) < 32) or (ch in [' ', '.', ';', '!', '''', '#', '(', '+', '|', '&', '^', '*', ')', ';', '\', '/', '"', '-', '%', '>', '<', ':', '=', ',']) then
    Result := true
  else
    Result := false;
end;

function getPosSQLElWithoutParenthesis(AStr : String; ANameOfEl : String; ind : Integer=1) : Integer;
var
  str : String;
  NameOfEl : String;
  b, e : Integer;
  b1, e1 : Integer;
  b2, e2 : Integer;
  offs : Integer;
  IsBegEl, IsEndEl : Boolean;
  len : Integer;
  pos_El : Integer;
  len_EL : Integer;
begin
  Result := 0;
  offs := 0;

  len :=  length(Astr);

  if ind > 1 then
  begin
    offs := ind - 1;
    str := UPPERCASE(copy(AStr, ind, len - ind + 1))
  end
  else
    str := UPPERCASE(AStr);

  len_El := length(ANameOfEl);

  NameOfEL := UPPERCASE(ANameOfEl);

  pos_El := pos(NameOfEl, str);

  while pos_El > 0 do
  begin
    GetNotWorkCode(str, b1, e1);
    GetParenthesis(str, b2, e2);

    if (b1 > 0) and ((b2 = 0) or (b1 < b2)) then
    begin
      b := b1;
      e := e1;
    end
    else
    begin
      b := b2;
      e := e2;
    end;

    //while (b <> 0) and (b < pos_var)


    if (b = 0) or (b > pos_el) then
    begin
      if (offs > 0) or (pos_el > 1) then
        IsBegEl := IsSpecChar(astr[offs + pos_El - 1])
      else
        IsBegEl := true;

      if (len >= (offs + pos_El + len_EL)) then
        IsEndEl := IsSpecChar(astr[offs + pos_El + len_El])
      else
        IsEndEl := true;

      if IsBegEl and IsEndEl then
      begin
        Result := offs + pos_El;
        Exit;
      end
      else
      begin
        offs := offs + pos_El + len_El - 1;
        str  := copy(str, pos_El + len_El, len - offs);
        pos_El := pos(NameOfEL, str);
      end;
    end
    else
    begin
      offs := offs + e;
      str  := copy(str, e + 1, len - offs);
      if e > pos_El then
        pos_El := pos(NameOfEl, str)
      else
        pos_El := pos_El - e;
    end
  end;
end;

function getPosSQLWithoutParenthesis(AStr : String; ANameOfEl : String; ind : Integer=1) : Integer;
var
  str : String;
  NameOfEl : String;
  b, e : Integer;
  b1, e1 : Integer;
  b2, e2 : Integer;
  offs : Integer;
  len : Integer;
  pos_El : Integer;
begin
  Result := 0;
  offs := 0;

  len :=  length(Astr);

  if ind > 1 then
  begin
    offs := ind - 1;
    str := UPPERCASE(copy(AStr, ind, len - ind + 1))
  end
  else
    str := UPPERCASE(AStr);

  NameOfEL := UPPERCASE(ANameOfEl);

  pos_El := pos(NameOfEl, str);

  while pos_El > 0 do
  begin
    GetNotWorkCode(str, b1, e1);
    GetParenthesis(str, b2, e2);

    if (b1 > 0) and ((b2 = 0) or (b1 < b2)) then
    begin
      b := b1;
      e := e1;
    end
    else
    begin
      b := b2;
      e := e2;
    end;

    if (b = 0) or (b > pos_el) then
    begin
      Result := offs + pos_El;
      Exit;
    end
    else
    begin
      offs := offs + e;
      str  := copy(str, e + 1, len - offs);
      if e > pos_El then
        pos_El := pos(NameOfEl, str)
      else
        pos_El := pos_El - e;
    end
  end;
end;

function getPosSQLEl(AStr : String; ANameOfEl : String; ind : Integer=1) : Integer;
var
  str : String;
  NameOfEl : String;
  b, e : Integer;
  offs : Integer;
  IsBegEl, IsEndEl : Boolean;
  len : Integer;
  pos_El : Integer;
  len_EL : Integer;
begin
  Result := 0;
  offs := 0;

  len :=  length(Astr);

  if ind > 1 then
  begin
    offs := ind - 1;
    str := UPPERCASE(copy(AStr, ind, len - ind + 1))
  end
  else
    str := UPPERCASE(AStr);

  len_El := length(ANameOfEl);

  NameOfEL := UPPERCASE(ANameOfEl);

  pos_El := pos(NameOfEl, str);

  while pos_El > 0 do
  begin
    GetNotWorkCode(str, b, e);

    //while (b <> 0) and (b < pos_var)


    if (b = 0) or (b > pos_el) then
    begin
      if (offs > 0) or (pos_el > 1) then
        IsBegEl := IsSpecChar(astr[offs + pos_El - 1])
      else
        IsBegEl := true;

      if (len >= (offs + pos_El + len_EL)) then
        IsEndEl := IsSpecChar(astr[offs + pos_El + len_El])
      else
        IsEndEl := true;

      if IsBegEl and IsEndEl then
      begin
        Result := offs + pos_El;
        Exit;
      end
      else
      begin
        offs := offs + pos_El + len_El - 1;
        str  := copy(str, pos_El + len_El, len - offs);
        pos_El := pos(NameOfEL, str);
      end;
    end
    else
    begin
      offs := offs + e;
      str  := copy(str, e + 1, len - offs);
      if e > pos_El then
        pos_El := pos(NameOfEl, str)
      else
        pos_El := pos_El - e;
    end
  end;
end;

function InsetrSubQuery(ASQL : String; ASubSQL : String; AMasterField : TFieldNames; ADetailField : TFieldNames) : String;
var
  pos_Where  : Integer;
  pos_Having : Integer;
  pos_Order  : Integer;
  pos_Group  : Integer;

  I : Integer;

  p : Integer;
begin
  Result := ' (';
  for I := 0 to AMasterField.Count - 1 do
    if I = 0 then
      Result := Result + AMasterField.Fields[I]
    else
      Result := Result + ', ' + AMasterField.Fields[I];


  Result := Result + ') IN (SELECT ';
  for I := 0 to ADetailField.Count - 1 do
    if I = 0 then
      Result := Result + ADetailField.Fields[I]
    else
      Result := Result + ', ' + ADetailField.Fields[I];

  Result := Result + ' FROM (' +  ASubSQL + ')' + #13#10 + ') ';

  pos_Where  := getPosSQLEl(ASQL, 'where');
  pos_Having := getPosSQLEl(ASQL, 'having');
  pos_Order  := getPosSQLEl(ASQL, 'order');
  pos_Group  := getPosSQLEl(ASQL, 'group');

  if pos_Where > 0 then
  begin
    Result :=   #13#10+ Result + #13#10 + 'AND' + #13#10;
    p := pos_Where + Length('WHERE');
  end
  else
  begin
    Result := #13#10 + 'WHERE' + #13#10+ Result + #13#10;

    p := pos_Having;
    if (p = 0) or ((pos_Order <> 0) and (pos_Order < p)) then
      p := pos_Order;

    if (p = 0) or ((pos_Group <> 0) and (pos_Group < p)) then
      p := pos_Group;
  end;


  if p <> 0 then
    Result :=  copy(ASQL, 1, p - 1) + Result + copy(ASQL, p, Length(ASQL) - p + 1)
  else
    Result :=  ASQL + Result;

end;

function GetPosTableAndAlias(ASubSQL : String; APos : Integer; var APosBegTabl : Integer; var APosEndTabl : Integer;
                             var APosBegAlias : Integer; var APosEndAlias : Integer) : Integer;
var
  SubSQL : String;
  offs   : Integer;
  currPos : Integer; // ������� �������
  posFirstSymbol : Integer;
  chFirstSymbol  : Char;
  begNotWorkCode : Integer;
  endNotWorkCode : Integer;
  p : Integer;
  b, e : Integer;
  len : Integer;
begin
  offs := 0;
  APosBegTabl  := 0;
  APosEndTabl  := 0;
  APosBegAlias := 0;
  APosEndAlias := 0;
  Result       := 0;
  chFirstSymbol := chr(0);

  len :=  length(ASubSQL);

  if (len < APos) or (APos <= 0) then
    Exit;

  if APos > 1 then
  begin
    offs := APos - 1;
    SubSQL := copy(ASubSQL, Apos, len - APos + 1);
    len := len - APos + 1;
  end
  else
    SubSQL := ASubSQL;

  posFirstSymbol := 0;
  currPos := 1;
  while currPos <= len do
  begin
    if ord(SubSQL[currPos]) > 32 then
    begin
      posFirstSymbol := currPos;
      chFirstSymbol := SubSQL[currPos];
      break;
    end;

    inc(currPos);
  end;

  if posFirstSymbol > 0 then
    GetNotWorkCode(SubSQl, begNotWorkCode, endNotWorkCode, posFirstSymbol);

  while posFirstSymbol > 0 do
  begin
    if (chFirstSymbol <> '(') and (chFirstSymbol <> ',') and (APosBegAlias = 0) then
    begin
      if (posFirstSymbol < begNotWorkCode) or (begNotWorkCode = 0) then
      begin
        if APosBegTabl = 0 then
          APosBegTabl  := posFirstSymbol + offs
        else
          APosBegAlias := posFirstSymbol + offs;

        Inc(currPos);
        p := 0;
        while (currPos <= len) and ((currPos < begNotWorkCode) or (begNotWorkCode = 0)) do
        begin
          if IsSpecChar(SubSQL[currPos]) and (not (SubSQL[currPos] in ['.', '@'])) then
          begin
            p := currPos;
            break;
          end;
          Inc(currPos);
        end;

        if p > 0 then
        begin
          if APosEndTabl = 0 then
            APosEndTabl  := p - 1 + offs
          else
            APosEndAlias := p - 1 + offs;
        end
        else
        begin
          if APosEndTabl = 0 then
            APosEndTabl  := len + offs
          else
            APosEndAlias := len + offs;
        end
      end
      else
      begin
        currPos := endNotWorkCode;
        if currPos < len then
          GetNotWorkCode(SubSQl, begNotWorkCode, endNotWorkCode, currPos + 1)
      end
    end
    else if (chFirstSymbol = ',') then
    begin
      Result := posFirstSymbol + offs;
      Exit;
    end
    else if APosBegAlias <> 0 then
    begin
      if chFirstSymbol = '(' then
      begin
        GetParenthesis(SubSQL, b, e, posFirstSymbol);
        currPos := e;
        if (begNotWorkCode <> 0) and (currPos > begNotWorkCode) then
          GetNotWorkCode(SubSQl, begNotWorkCode, endNotWorkCode, currPos + 1);
      end
      else if (posFirstSymbol < begNotWorkCode) or (begNotWorkCode = 0) then
        while (currPos <= len) and ((currPos < begNotWorkCode) or (begNotWorkCode = 0)) do
        begin
          if IsSpecChar(SubSQL[currPos]) and (not (SubSQL[currPos] in ['.', '@'])) then
            break;
          Inc(currPos);
        end
      else
      begin
        currPos := endNotWorkCode;
        if currPos < len then
          GetNotWorkCode(SubSQl, begNotWorkCode, endNotWorkCode, currPos + 1);
      end
    end
    else if chFirstSymbol = '(' then
    begin
      if APosBegTabl = 0 then
      begin
        GetParenthesis(SubSQL, APosBegTabl, APosEndTabl, posFirstSymbol);
        currPos := APosEndTabl;
      end
      else
      begin
        GetParenthesis(SubSQL, APosBegAlias, APosEndAlias, posFirstSymbol);
        currPos := APosEndAlias;
      end;
      if (begNotWorkCode <> 0) and (currPos > begNotWorkCode) then
        GetNotWorkCode(SubSQl, begNotWorkCode, endNotWorkCode, currPos + 1);
    end;

    posFirstSymbol := 0;
    if currPos < len then
    begin
      while (currPos < len) and ((currPos < begNotWorkCode) or (begNotWorkCode = 0)) and (SubSQL[currPos] <> ',') do
      begin
        inc(currPos);

        if ord(SubSQL[currPos]) > 32 then
        begin
          posFirstSymbol := currPos;
          chFirstSymbol := SubSQL[currPos];
          break;
        end;
      end;

      if posFirstSymbol = 0 then
      begin
        if currPos < len then
        begin
          posFirstSymbol := currPos;
          chFirstSymbol := SubSQL[currPos];
        end
        else
          Result := len + offs;
      end;
    end
    else
      Result := len + offs;
  end;
end;

procedure GetSQLTable(ASubSQL : String; var ANamesOfTables : TArrayOfString; var AAliasOfTables : TArrayOfString);
var
  I : Integer;
  begTable, endTable : Integer;
  begAlias, endAlias : Integer;
  currPos : Integer;

begin
  SetLength(ANamesOfTables, 0);
  SetLength(AAliasOfTables, 0);

  currPos := GetPosTableAndAlias(ASubSQL, 1, begTable, endTable, begAlias, endAlias);
  I := 0;
  while currPos > 0 do
  begin
    SetLength(ANamesOfTables, I + 1);
    SetLength(AAliasOfTables, I + 1);

    if begTable > 0 then
      ANamesOfTables[I] := copy(ASubSQL, begTable, endTable - begTable + 1)
    else
      ANamesOfTables[I] := '';

    if begAlias > 0 then
      AAliasOfTables[I] := copy(ASubSQL, begAlias, endAlias - begAlias + 1)
    else
      AAliasOfTables[I] := '';

    Inc(I);
    currPos := GetPosTableAndAlias(ASubSQL, currPos + 1, begTable, endTable, begAlias, endAlias);
  end;
end;

function GetIndTable(ANamesOfTables : TArrayOfString; AAliasOfTables : TArrayOfString; NameOfField : String; ASession : TOracleSession) : Integer;
var
  count : Integer; // ���. ������
  alias : String;
  name  : String;
  shema : String;
  table : String;
  p : Integer;
  I : Integer;
  SQL : String;
  query : TOracleQuery;
begin
  Result := -1;

  count := Length(ANamesOfTables); // ����������� ����� ������
  //if count > 1 then
  //begin
    // ��������� ����� � ������������ �������
    p := pos('.', NameOfField);
    if p > 0 then
    begin
      alias := copy(NameOfField, 1, p - 1);
      name  := copy(NameOfField, p + 1, Length(NameOfField) - p);
    end
    else
    begin
      alias := '';
      name  := NameOfField;
    end;

    if alias <> '' then
    begin
      for I := 0 to count - 1 do
        if UPPERCASE(AAliasOfTables[I]) = UPPERCASE(Alias) then
        begin
          Result := I;
          Exit;
        end;
    end
    else
    begin
      query := TOracleQuery.Create(nil);
      query.Session := ASession;
      for I := 0 to count - 1 do
      begin
        p := pos('.', ANamesOfTables[I]);
        if p > 0 then
        begin
          shema := copy(ANamesOfTables[I], 1, p - 1);
          table := copy(ANamesOfTables[I], p + 1, Length(ANamesOfTables[I]) - p);
        end
        else
        begin
          if DefaultSchema <> '' then
            shema := DefaultSchema
          else
            shema := '';
          table := ANamesOfTables[I];
        end;

        if shema <> '' then
          SQL := 'SELECT count(*) FROM sys.all_tab_columns WHERE OWNER = ''' +
                 UPPERCASE(shema) + ''' AND TABLE_NAME = ''' + UPPERCASE(shema) +
                 ''' AND COLUMN_NAME = ''' + name + ''''
        else
          SQL := 'SELECT count(*) FROM sys.user_tab_columns WHERE TABLE_NAME = '''
                 + UPPERCASE(shema) + ''' AND COLUMN_NAME = ''' + name + '''';

        query.SQL.Text := SQL;
        query.Execute;

        if query.Field(0) > 0 then
        begin
          Result := I;
          break;
        end;
      end;
      query.Destroy;
    end;
  //end
  //else if count = 1 then
  //  Result := 0;
end;

function DeleteVariableFromSQL(ANameVariable : String; ASQL : String) : String;
var
  posWHERE    : Integer;
  PosEndWHERE : Integer;
  p : Integer;
  posVariable : Integer;
  NameVariable : String;

  lenSQL : Integer;
  operWHERE   : String;
  posAND, posOR : Integer;
  posAndOr1, posAndOr2 : Integer;
  o, offs1, offs2 : Integer;
begin
  // ���� ��� ��������� ������� WHERE
  posWHERE := getPosSQLElWithoutParenthesis(ASQL, 'WHERE');

  if posWHERE = 0 then
  begin
    Result := ASQL;
    EXit;
  end;

  if ANameVariable[1] <> ':' then
    NameVariable := ':' + ANameVariable
  else
    NameVariable := ANameVariable;

  lenSQL := Length(ASQL);

  // ���� ������� � SQL ������� ��� ������������ �������� ��������� WHERE
  PosEndWHERE := lenSQL;
  p := getPosSQLElWithoutParenthesis(ASQL, 'ORDER');
  if p <> 0 then
    PosEndWHERE := p - 1;
  p := getPosSQLElWithoutParenthesis(ASQL, 'HAVING');
  if (p > 0) and (p < PosEndWHERE) then
    PosEndWHERE := p - 1;
  p := getPosSQLElWithoutParenthesis(ASQL, 'GROUP');
  if (p > 0) and (p < PosEndWHERE) then
    PosEndWHERE := p - 1;

  // �������� �������� WHERE
  operWHERE := copy(ASQL, posWHERE, posEndWHERE - posWHERE + 1);

  // ���� ���������  � ������� � �� ��������� WHERE
  posVariable := getPosSQLEl(operWHERE, NameVariable);
  while posVariable > 0 do
  begin
    // ������� �������� ����������

    // ���������� ����� ����� ������ ���� �������

    posAndOr1 := 0;
    posAndOr2 := 0;
    offs2 := 0;
    posAND := getPosSQLElWithoutParenthesis(operWHERE, 'AND');
    posOR  := getPosSQLElWithoutParenthesis(operWHERE, 'OR');
    // ���� �������� AND ��� OR ������� ��������� ����� ���������
    if (posAND > 0) and ((posOR = 0) or  (posAND < posOR)) then
    begin
      p := posAND;
      o := 3;
    end
    else
    begin
      p := posOr;
      o := 2;
    end;
    while (p > 0) and (p < posVariable) do
    begin
      posAndOr1 := p;
      offs1 := o;


      posAND := getPosSQLElWithoutParenthesis(operWHERE, 'AND', posAndOr1 + offs1);
      posOR  := getPosSQLElWithoutParenthesis(operWHERE, 'OR',  posAndOr1 + offs1);

      if (posAND > 0) and ((posOR = 0) or  (posAND < posOR)) then
      begin
        p := posAND;
        o := 3;
      end
      else
      begin
        p := posOr;
        o := 2;
      end;
    end;
    // ���� �������� AND ��� OR ������� ��������� ����� ���������
    if p > 0 then
    begin
      posAndOr2 := p;
      offs2 := o;
    end;
    // �������
    if (posAndOr1 > 0) and (posAndOr2 > 0) then
      operWHERE := copy(operWHERE, 1, posAndOr1 - 1) + copy(operWHERE, posAndOr2, Length(operWHERE) - posAndOr2 + 1)
    else if (posAndOr1 > 0) then
      operWHERE := copy(operWHERE, 1, posAndOr1 - 1)
    else if (posAndOr2 > 0) then
      operWHERE := 'WHERE' + copy(operWHERE, posAndOr2 + offs2, Length(operWHERE) - posAndOr2 - offs2 + 1 )
    else
      operWHERE := '';

    // ���� ���� �� ��� ���������
    posVariable := getPosSQLEl(operWHERE, NameVariable);
  end;

  if lenSQL = PosEndWHERE then
    Result := copy(ASQL, 1, posWHERE - 1) +  operWHERE
  else
    Result := copy(ASQL, 1, posWHERE - 1) +  operWHERE + ' ' + copy(ASQL, PosEndWHERE + 1, lenSQL - PosEndWHERE);
end;

function InsertVariableFromSQL(ANameVariable : String; ASQL : String; AField : String) : String;
begin
  Result := InsertIfInSQL(ASQL, GetVariableFromSQL(ANameVariable, AField));
end;

function GetVariableFromSQL(ANameVariable : String; AField : String) : String;
var
  NameVariable : String;
  NameField : String;
begin
  if ANameVariable[1] <> ':' then
    NameVariable := ':' + ANameVariable
  else
    NameVariable := ANameVariable;

  if Trim(AField) = '' then
  begin
    if ANameVariable[1] <> ':' then
      NameField := ANameVariable
    else
      NameField    := copy(ANameVariable, 1, Length(ANameVariable) - 1);
  end
  else
    NameField := AField;

  Result := NameField + ' = ' + NameVariable;
end;

function InsertIfInSQL(ASQL : String; AIf : String) : String;
var
  posWHERE    : Integer;
  posOrdHavGr : Integer;
  p : Integer;
  str : String;
begin
  // ���� ��� ��������� ������� WHERE
  posWHERE := getPosSQLElWithoutParenthesis(ASQL, 'WHERE');

  p := getPosSQLElWithoutParenthesis(ASQL, 'ORDER');
  posOrdHavGr := 0;
  if p <> 0 then
    posOrdHavGr := p;
  p := getPosSQLElWithoutParenthesis(ASQL, 'HAVING');
  if (p > 0) and ((posOrdHavGr = 0) or (p < posOrdHavGr)) then
    posOrdHavGr := p;
  p := getPosSQLElWithoutParenthesis(ASQL, 'GROUP');
  if (p > 0) and ((posOrdHavGr = 0) or (p < posOrdHavGr)) then
    posOrdHavGr := p;

  if posWHERE > 0 then
    str := ' AND (' + AIf + ') '
  else
    str := ' WHERE (' + AIf + ') ';

  if posOrdHavGr > 0 then
    Result := copy(ASQL, 1, posOrdHavGr - 1) + str + copy(ASQL, posOrdHavGr, length(ASQL) - posOrdHavGr + 1)
  else
    Result := ASQL + str;
end;

//--------------------------TfmExpandedTreeTopology-----------------------------

constructor TfmExpandedTreeTopology.Create(AOwner: TComponent);
begin
  FModifyDataSetOfSimpleNode := TList.Create;
  FListModifyTabSheetBeforeModifyDataSet := TList.Create;

  FExpandedNodes := TExpandedNodesForWindow.Create;
  with FExpandedNodes as TExpandedNodesForWindow do
  begin
    OnAdd    := TreeTopologyAddExpNode;
    OnDelete := TreeTopologyDeleteExpNode;
    OnChange := TreeTopologyChangeExpNode;
  end;
  FTableTabSheetListOfExNodes := TTabSheetListForWindow.Create;
  inherited Create(AOwner);
end;

destructor  TfmExpandedTreeTopology.Destroy;
var
  I : Integer;
begin
  FExpandedNodes.Destroy;
  FTableTabSheetListOfExNodes.Destroy;

  FModifyDataSetOfSimpleNode.Destroy;
  for I := 0 to FListModifyTabSheetBeforeModifyDataSet.Count - 1 do
    TList(FListModifyTabSheetBeforeModifyDataSet[I]).Destroy;
  FListModifyTabSheetBeforeModifyDataSet.Destroy;

  inherited;
end;

procedure TfmExpandedTreeTopology.UMChangeMode(var Message:TMessage);
var
  DataSetList : TList;
  I : Integer;

begin
  case Message.wParam of
      IN_QUERY: begin
                  for I := 0 to FListModifyTabSheetBeforeModifyDataSet.Count - 1 do
                    TList(FListModifyTabSheetBeforeModifyDataSet[i]).Clear;
                  CloseAllExNodeSession;
                end;
    end;

  if IsTabSheetOfExtendedNode(pcMain.ActivePage) then
  begin
    DataSetList := TList.Create;
    GetDataSetOfWinControl(pcMain.ActivePage, DataSetList);

    case Message.wParam of
      IN_QUERY: begin
                  with TreeView.Selected do
                  begin
                    ChangeCurrentSet(TDataSet(Data));
                  end;
                  inherited;
                  ChangeVisibleTabSheet;
                  Exit;
                end;    // � ������ ����������
      IN_INSERT: begin end;   // � ������ ����������
      IN_EDIT: begin end;     // � ������ ����������
    end;

    DataSetList.Destroy;

    ChangeWorkStyle(Message);
  end
  else
  begin
    inherited;
  end;
  ChangeVisibleTabSheet;
end;

procedure TfmExpandedTreeTopology.scanTSList(var ASheet : TTabSheet; ADataSource : TDataSource);
var
  grid : TRxDBGrid;
begin
  if not Assigned(ASheet) then
    ASheet := TTabSheet.Create(nil);

  ASheet.PageControl := tsList.PageControl;

  // �������� �������
  if (POINTER(@ASheet.OnContextPopup) <> POINTER(@tsList.OnContextPopup)) and (@tsList.OnDragDrop <> nil) then
    ASheet.OnContextPopup := tsList.OnContextPopup;
  if (POINTER(@ASheet.OnDragDrop) <> POINTER(@tsList.OnDragDrop)) and (@tsList.OnDragDrop <> nil) then
    ASheet.OnDragDrop := tsList.OnDragDrop;
  if (POINTER(@ASheet.OnDragOver) <> POINTER(@tsList.OnDragOver)) and (@tsList.OnDragOver <> nil) then
    ASheet.OnDragOver := tsList.OnDragOver;
  if (POINTER(@ASheet.OnEndDrag) <> POINTER(@tsList.OnEndDrag)) and (@tsList.OnEndDrag <> nil) then
    ASheet.OnEndDrag := tsList.OnEndDrag;
  if (POINTER(@ASheet.OnEnter) <> POINTER(@tsList.OnEnter)) and (@tsList.OnEnter <> nil) then
    ASheet.OnEnter := tsList.OnEnter;
  if (POINTER(@ASheet.OnExit) <> POINTER(@tsList.OnExit)) and (@tsList.OnExit <> nil) then
    ASheet.OnExit := tsList.OnExit;
  if (POINTER(@ASheet.OnHide) <> POINTER(@tsList.OnHide)) and (@tsList.OnHide <> nil) then
    ASheet.OnHide := tsList.OnHide;
  if (POINTER(@ASheet.OnMouseDown) <> POINTER(@tsList.OnMouseDown)) and (@tsList.OnMouseDown <> nil) then
    ASheet.OnMouseDown := tsList.OnMouseDown;
  if (POINTER(@ASheet.OnMouseMove) <> POINTER(@tsList.OnMouseMove)) and (@tsList.OnMouseMove <> nil) then
    ASheet.OnMouseMove := tsList.OnMouseMove;
  if (POINTER(@ASheet.OnMouseUp) <> POINTER(@tsList.OnMouseUp)) and (@tsList.OnMouseUp <> nil) then
    ASheet.OnMouseUp := tsList.OnMouseUp;
  if (POINTER(@ASheet.OnResize) <> POINTER(@tsList.OnResize)) and (@tsList.OnResize <> nil) then
    ASheet.OnResize := tsList.OnResize;
  if (POINTER(@ASheet.OnShow) <> POINTER(@tsList.OnShow)) and (@tsList.OnShow <> nil) then
    ASheet.OnShow := tsList.OnShow;
  if (POINTER(@ASheet.OnStartDrag) <> POINTER(@tsList.OnStartDrag)) and (@tsList.OnStartDrag <> nil) then
    ASheet.OnStartDrag := tsList.OnStartDrag;

  grid := TRxDBGrid.Create(nil);
  ASheet.InsertControl(grid);
  copyDBGrid(grid, DBGrid);
  grid.DataSource := ADataSource;

end;

procedure TfmExpandedTreeTopology.AddTableTabSheeOfExNode(var ASheet : TTabSheet; AExpNode : TVExpandedNode);
begin
  if Assigned(AExpNode) then
  begin
    if not Assigned(AExpNode.TableTabSheet) then
    begin
      scanTSList(ASheet, AExpNode.DSOfExpNode);
      if Assigned(AExpNode.DSOfExpNode) and (AExpNode.DSOfExpNode.DataSet is TVASUPQuery) then
        ASheet.Caption :=  TVASUPQuery(AExpNode.DSOfExpNode.DataSet).Caption;
    end
    else
      ASheet := AExpNode.TableTabSheet;
    InitASUPQueryInTabSheet(ASheet);
  end;
end;

procedure TfmExpandedTreeTopology.ChangeTableTabSheeOfExNode(var ANewSheet : TTabSheet; ANewExpNode : TVExpandedNode;
                                                                 AOldSheet : TTabSheet; AOldExpNode : TVExpandedNode);
begin
  DeleteTableTabSheeOfExNode(AOldSheet, AOldExpNode);
  AddTableTabSheeOfExNode(ANewSheet, ANewExpNode);
end;

procedure TfmExpandedTreeTopology.DeleteTableTabSheeOfExNode(ASheet : TTabSheet; AExpNode : TVExpandedNode );
var
  I : Integer;
begin
  if ASheet <> AExpNode.TableTabSheet then
  begin
    if Assigned(ASheet) then
    begin
      for I := ASheet.ControlCount - 1 downto 0 do
        ASheet.Controls[I].Destroy;
      ASheet.Destroy;
    end;
  end;
end;

procedure TfmExpandedTreeTopology.TreeTopologyAddExpNode(ANode : TVExpandedNode; Index : Integer);
var
  sheet : TTabSheet;
  I : Integer;
begin
  sheet := nil;
  for I := 0 to ANode.TabSheets.Count - 1 do
    InitASUPQueryInTabSheet(ANode.TabSheets[I]);
  AddTableTabSheeOfExNode(sheet, ANode);
  FTableTabSheetListOfExNodes.Insert(Index, sheet);
end;

procedure TfmExpandedTreeTopology.TreeTopologyChangeExpNode(ANewNode, AOldNode : TVExpandedNode; Index : Integer);
var
  sheet : TTabSheet;
  I : Integer;
begin
  sheet := nil;
  for I := 0 to ANewNode.TabSheets.Count - 1 do
    InitASUPQueryInTabSheet(ANewNode.TabSheets[I]);
  ChangeTableTabSheeOfExNode(sheet, ANewNode, FTableTabSheetListOfExNodes[Index], AOldNode);
  FTableTabSheetListOfExNodes[Index] := sheet;
end;

procedure TfmExpandedTreeTopology.TreeTopologyDeleteExpNode(ANode : TVExpandedNode; Index : Integer);
var
  sheet : TTabSheet;
begin
  sheet := FTableTabSheetListOfExNodes[Index];
  DeleteTableTabSheeOfExNode(sheet, ANode);
  FTableTabSheetListOfExNodes.Delete(Index);
end;

function  TfmExpandedTreeTopology.GetExpandedNode(Index : Integer) : TTabSheet;
begin
  Result := FTableTabSheetListOfExNodes[Index];
end;

function TfmExpandedTreeTopology.GetDataSetOfActiveNode : TVASUPQuery;
var
  ActiveNode : TTreeNode;
begin
  Result := nil;
  ActiveNode := TreeView.Selected;
  if Assigned(ActiveNode) then
    Result := TVASUPQuery(ActiveNode.Data);
end;

procedure TfmExpandedTreeTopology.GetDataSetsOfSN(ANode : TTreeNode; AList : TList);
var
  I : Integer;
begin
  if Assigned(ANode) then
  begin
    AList.Add(ANode.Data);
    for I := 0 to ANode.Count - 1 do
      GetDataSetsOfSN(ANode.Item[I], AList);
  end;
end;

function TfmExpandedTreeTopology.FindSimpleNode(ADataSet : TDataSet) : TTreeNode;
var
  I        : Integer;
begin
  Result := nil;
  for I := 0 to TreeView.Items.Count - 1 do
    if TreeView.Items[I].Data = ADataSet then
    begin
      Result := TreeView.Items[I];
      Exit;
    end;
end;

function TfmExpandedTreeTopology.IsRenewedTabSheet(ASheet : TTabSheet; ADataSet : TDataSet) : boolean;
var
  ind : Integer;
begin
  ind := FModifyDataSetOfSimpleNode.IndexOf(ADataSet);
  if ind >= 0 then
    Result := TList(FListModifyTabSheetBeforeModifyDataSet[ind]).IndexOf(ASheet) >= 0
  else
    Result := true;
end;

procedure TfmExpandedTreeTopology.SetRenewed(ASheet : TTabSheet; ADataSet : TDataSet);
var
  ind  : Integer;
  List : TList;
begin
  ind := FModifyDataSetOfSimpleNode.IndexOf(ADataSet);
  if ind >= 0 then
  begin
    List := TList(FListModifyTabSheetBeforeModifyDataSet[ind]);
    if List.IndexOf(ASheet) < 0 then
      // ���� ������� ASheet �� ��������, ��� ���������� ��� ADataSet
      // �� �������
      List.Add(ASheet)
  end;

end;

procedure TfmExpandedTreeTopology.SetModifiable(ADataSet : TDataSet);
var
  ind  : Integer;
begin
  ind := FModifyDataSetOfSimpleNode.IndexOf(ADataSet);
  if ind < 0 then
  begin
    FModifyDataSetOfSimpleNode.Add(ADataSet);
    FListModifyTabSheetBeforeModifyDataSet.Add(TList.Create);
  end
  else
    TList(FListModifyTabSheetBeforeModifyDataSet[ind]).Clear;
  OnModifiable(ADataSet);
end;

function TfmExpandedTreeTopology.GetDataSetsOfSimpleNode(ADataSet : TDataSet) : TArrayOfOracleDataSet;
var
  I : Integer;
  List : TList;
  node : TTreeNode;
begin
  List := TList.Create;

  node := FindSimpleNode(ADataSet);
  GetDataSetsOfSN(FindSimpleNode(ADataSet), List);
  while Assigned(node.Parent) do
  begin
    node := node.Parent;
    List.Add(node.Data);
  end;

  SetLength(Result, List.Count);
  for I := 0 to List.Count - 1 do
    Result[I] := List[I];

  List.Destroy;
end;

function TfmExpandedTreeTopology.GetDataSetsOfActiveNodes : TArrayOfOracleDataSet;
var
  len : Integer;
  ActiveNodes : TArrayOfTreeNode;
  I : Integer;
begin
  ActiveNodes := GetActiveNodes;
  len := Length(ActiveNodes);
  SetLength(Result, len);

  for I := 0 to len - 1 do
    Result[I] := TOracleDataSet(ActiveNodes[I].Data);
end;

function TfmExpandedTreeTopology.GetActiveNodes : TArrayOfTreeNode;
var
  c : Integer;
  ActiveNode : TTreeNode;
  Parent : TTreeNode;
begin
  c := 0;
  ActiveNode := TreeView.Selected;
  if Assigned(ActiveNode) then
  begin
    SetLength(Result, ActiveNode.Level + 1);
    Result[c] := ActiveNode;
    Parent := ActiveNode.Parent;
    Inc(c);
    while Assigned(Parent) do
    begin
      Result[c] := Parent;
      Parent := Parent.Parent;
      Inc(c);
    end;
  end
  else
    SetLength(Result, 0);
end;

function TfmExpandedTreeTopology.GetActiveTreeNode : TTreeNode;
begin
  Result := TreeView.Selected;
end;

procedure TfmExpandedTreeTopology.ChangeVisibleTabSheet;
var
  dataSetList : TList;
  I, J, Q, Y, Z : Integer;
  DataSetOfActiveNode : TDataSet;
  fl : boolean;
begin
  dataSetList := TList.Create;

  // ������ DataSet ��������� ���� ������
  DataSetOfActiveNode := TDataSet(TreeView.Selected.Data);

  // ������������� ��� ����������� ���� ������
  for I := 0 to ExpandedNodes.Count - 1 do
  begin
    with ExpandedNodes[I] do
    begin

      if Assigned(DSOfExpNode) and

         (DSOfExpNode.DataSet is TVASUPQuery) and
         (TVASUPQuery(DSOfExpNode.DataSet).AccessLevel <> []) then
      begin
        // ���� � ������������ ���� DataSet ���� TVASUPQuery,
        // �� ����� ���������� ������ �� ������������ ������ ������ DataSet
        // � ����� ���������� ������ ���� �������� �������� ����������� ����

        // ������������ ����� ������ � ������ DataSet
        // �.�. �������� ����������� ���� ����� ���� ��������

        fl := false;
        // ���������� ������� �� ���� ������, ������� ��������� ���������� ����
        for Q := 0 to Links.Count - 1 do
          if  Assigned(Links[Q].DataSource) and
             (Links[Q].DataSource.DataSet = DataSetOfActiveNode) then
          begin
            // ���� ������, ������� ��������� ����������� ����, �������

            // ������ ������� ��������-������� ����������� ����
            if WorkStyle <> wsQuery then
              TableTabSheetListOfExNodes[I].TabVisible := true;

            // ���������� ������� �� ������������ ������ ������ DataSet,
            // ������ ������� ����������� �� ��������� ������� ����������� ����
            for Y := 0 to TabSheets.Count - 1 do
            begin
              dataSetList.Clear;
              GetDataSetOfWinControl(TabSheets[Y], dataSetList);
              for Z := 0 to dataSetList.Count - 1 do
              begin
                if TDataSet(dataSetList[Z]) is TVASUPQuery then
                begin
                  if TVASUPQuery(dataSetList[Z]).AccessLevel = [] then
                  begin
                    TabSheets[Y].TabVisible := false;
                    break;
                  end;

                end;

                if Z = (dataSetList.Count - 1) then
                  // ������ �������, ������ �������� �������� ������
                  TabSheets[Y].TabVisible := true;
              end;
            end;

            fl := true;
            break;
          end;


        if not fl then
        begin
          TableTabSheetListOfExNodes[I].TabVisible := false;
          for j := 0 to TabSheets.Count - 1 do
            TabSheets[J].TabVisible := false;
        end
        else
        begin
          if WorkStyle <> wsQuery then
            TableTabSheetListOfExNodes[I].TabVisible := true
          else
            TableTabSheetListOfExNodes[I].TabVisible := false;

          if WorkStyle = wsQuery then
            for j := 0 to TabSheets.Count - 1 do
              TabSheets[J].TabVisible := true
          else
            for j := 0 to TabSheets.Count - 1 do
              TabSheets[J].TabVisible := false;
        end;

      end
      else
      begin
        TableTabSheetListOfExNodes[I].TabVisible := false;
        for j := 0 to TabSheets.Count - 1 do
          TabSheets[J].TabVisible := false;
      end;


    end;
  end;
  dataSetList.Destroy;
end;

procedure TfmExpandedTreeTopology.ChangeActivePages;
begin
  if IsDataSetOfSimpleNode(dsCurrent.DataSet) then
    HideTabSheetOfNoSignNodes;
  if not FChangingPageContrMain then
    inherited;

  ChangeVisibleTabSheet;
end;

procedure TfmExpandedTreeTopology.HideTabSheetOfNoSignNodes;
var
  I : Integer;
begin
  for I := 0 to pcMain.PageCount - 1 do
    if pcMain.Pages[I] <> tsList then
      with pcMain.Pages[I] do
        if TabVisible and ((Tag = 0) or (not IsDataSetOfSimpleNode(TDataSet(Tag)))) then
          TabVisible := false;
end;

function TfmExpandedTreeTopology.FindAreaDataSet(Area: TWinControl):TDataSet;
var
  I : Integer;
  ind : Integer;
begin
  if Area is TTabSheet then
  begin
    // ���������� ������  Area � ������ FTableTabSheetListOfExNodes
    ind := FTableTabSheetListOfExNodes.IndexOf(Area as TTabSheet);

    if ind >= 0 then
      Result :=  ExpandedNodes[Ind].DSOfExpNode.DataSet
    else
    begin
      // Area ��� � ������ FTableTabSheetListOfExNodes

      ind := -1;
      for I := 0 to ExpandedNodes.Count - 1 do
        with ExpandedNodes[I] do
        begin
          ind := TabSheets.IndexOf(Area as TTabSheet);
          if ind >= 0 then
            break;
        end;

      if ind >= 0 then
        Result := ExpandedNodes[I].DSOfExpNode.DataSet
      else
        Result := inherited FindAreaDataSet(Area);
    end;
  end
  else
    Result := inherited FindAreaDataSet(Area);
end;

function TfmExpandedTreeTopology.IsTabSheetOfTablExtNode(ASheet : TTabSheet) : boolean;
begin
  if FTableTabSheetListOfExNodes.IndexOf(ASheet) >= 0 then
    Result := true
  else
    Result := false;
end;

function TfmExpandedTreeTopology.IsTabSheetOfTabSheetExtdNode(ASheet : TTabSheet) : boolean;
var
  I : Integer;
begin
  Result := false;
  for I := 0 to ExpandedNodes.Count - 1 do
    with ExpandedNodes[I] do
      if TabSheets.IndexOf(ASheet) >= 0 then
      begin
        Result := true;
        exit;
      end;
end;

function TfmExpandedTreeTopology.IsTabSheetOfExtendedNode(ASheet : TTabSheet) : boolean;
begin
  Result := IsTabSheetOfTablExtNode(ASheet);
  if not Result then
    Result := IsTabSheetOfTabSheetExtdNode(ASheet);
end;

procedure TfmExpandedTreeTopology.InitASUPQueryInTabSheet(ASheet : TTabSheet);
//var
//  I : Integer;
//  list : TList;
begin
  //if Assigned(ASheet) then
  //begin
  //  list := GetDataSetOfWinControl(ASheet, nil);
    //for I := 0 to list.Count - 1 do
    //  if TDataSet(list[I]) is TVASUPQuery then
    //    initASUPQuery(TVASUPQuery(list[I]));
    //list.Destroy;
  //end;
end;

{function TfmExpandedTreeTopology.ApplyPageUpdates:boolean;
begin
  if IsTabSheetOfTablExtNode(pcMain.ActivePage) then
    Result := true                               // � ������ ����������
  else if IsTabSheetOfTablExtNode(pcMain.ActivePage) then
    Result := true                               // � ������ ����������
  else
    Result := inherited ApplyPageUpdates;
end;}

procedure TfmExpandedTreeTopology.ApplyAccessTabSheet(ASheet : TTabSheet);
begin
  AccessRights:= [aqQuerying];
end;

procedure TfmExpandedTreeTopology.DenyAccess;
begin
  if IsDataSetOfExpandedNode(dsCurrent.DataSet) then
  begin
    ApplyAccessTabSheet(pcMain.ActivePage);
    SpecifyToolBtnState;
    SetPopItems;
    if Application.MainForm.ActiveMDIChild=Self then
      Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
    Perform(UM_OTHERS,IN_STATUS,0);
  end
  else
    inherited;
end;

function TfmExpandedTreeTopology.IsDataSetOfSimpleNode(ADataSet : TDataSet) : boolean;
var
  I : Integer;
begin
  Result := false;
  with TreeView.Items do
    for I := 0 to Count - 1 do
      if item[I].Data = ADataSet then
      begin
        Result := true;
        exit;
      end;
end;

function TfmExpandedTreeTopology.IsDataSetOfExpandedNode(ADataSet : TDataSet) : boolean;
var
  I : Integer;
begin
  Result := false;
  for I := 0 to ExpandedNodes.Count - 1 do
    with ExpandedNodes[I] do
      if DSOfExpNode.DataSet = ADataSet then
      begin
        Result := true;
        exit;
      end;
end;

procedure TfmExpandedTreeTopology.ChangeCurrentSet(NewDataSet: TDataSet);
var
  OldDataSet: TDataSet;
  ExNode : TVExpandedNode;

  synchr : TSynchrRecords;

function GetMaster(ADataSet : TOracleDataSet) : TOracleDataSet;
begin
  if Assigned(ADataSet.Master) then
    Result := GetMaster(ADataSet.Master)
  else
    Result := ADataSet;
end;

begin
  OldDataSet:= dsCurrent.DataSet;
  if dsCurrent.DataSet <> NewDataSet then
  begin
    if IsDataSetOfExpandedNode(NewDataSet) then
    begin
      ClearDataCount;
      dsCurrent.DataSet:= NewDataSet;
      if not dsCurrent.DataSet.Active then
      begin
        RestoreORDERBY(TVASUPQuery(dsCurrent.DataSet));
        RestoreSavings;
      end;

      if WorkStyle<>wsQuery then
      begin
        ExNode := DataSetToExNode(NewDataSet);
        RefreshDataOfExNode(ExNode);

        // ���������� ������ �� ������� �������� � ������� ����� ������
        //synchrPosition(ExNode{, OldDataSet});

        if IsDataSetOfExpandedNode(OldDataSet) then
          if GetMaster(TOracleDataSet(NewDataSet)) = NewDataSet then
            synchr := TSynchrRecords.Create(Self, DataSetToExNode(OldDataSet), ExNode, ExpandedNodes)
          else
            synchr := TSynchrRecords.Create(Self, DataSetToExNode(OldDataSet), TOracleDataSet(NewDataSet), ExpandedNodes)
        else
          if ((GetMaster(TOracleDataSet(NewDataSet)) = NewDataSet)) or
             (not IsDataSetOfExpandedNode(GetSNMasterSupportExNodeSynch(TOracleDataSet(NewDataSet)))) then
            synchr := TSynchrRecords.Create(Self, GetSNMasterSupportExNodeSynch(TOracleDataSet(OldDataSet)), ExNode, ExpandedNodes)
          else
            synchr := TSynchrRecords.Create(Self, GetSNMasterSupportExNodeSynch(TOracleDataSet(OldDataSet)), DataSetToExNode(GetMaster(TOracleDataSet(NewDataSet))), ExpandedNodes);

        synchr.synchr;

        synchr.Destroy;
      end;

      //if IsDataSetOfExpandedNode(OldDataSet) then
      //  CloseExNodeSession(DataSetToExNode(OldDataSet));

      DenyAccess;
    end
    else if IsDataSetOfSimpleNode(NewDataSet) then
    begin
      if IsDataSetOfExpandedNode(dsCurrent.DataSet) then
      begin
        dsCurrent.DataSet := NewDataSet;

        inherited ChangeCurrentSet(NewDataSet);

        if IsDataSetOfExpandedNode(OldDataSet) then
        begin
          synchr := TSynchrRecords.Create(Self, DataSetToExNode(OldDataSet), GetSNMasterSupportExNodeSynch(TOracleDataSet(NewDataSet)), ExpandedNodes);

          synchr.synchr;

          synchr.Destroy;
        end;

        //synchrPosition(DataSetToExNode(OldDataSet){, NewDataSet,} false);
      end
      else
        inherited ChangeCurrentSet(NewDataSet);
    end;
  end
  else
    inherited ChangeCurrentSet(NewDataSet);
end;

function TfmExpandedTreeTopology.DataSetToExNode(ADataSet : TDataSet) : TVExpandedNode;
var
  I : Integer;
begin
  Result := nil;
  for I := 0 to ExpandedNodes.Count - 1 do
    with ExpandedNodes[I] do
      if DSOfExpNode.DataSet = ADataSet then
      begin
        Result := ExpandedNodes[I];
        exit;
      end;
end;

function TfmExpandedTreeTopology.GetVertexSNDataSetsForDataSetOfExNode(ExpandedNode : TVExpandedNode) : TArrayOfDataSet;
var
  I, J : Integer;
  currDataSet : TDataSet;
  list : TList;
  SubDataSet : boolean;
begin
  SetLength(Result, 0);

  if not Assigned(ExpandedNode) then
    Exit;

  list := TList.Create;
  //ExpandedNode.Links;
  with ExpandedNode.Links do
    for I := 0 to Count - 1 do
    begin
      // ������ DataSet-�, ������� ������ � ������ DataSet ������������ ���� ������
      currDataSet := Items[I].DataSource.DataSet;

      // ��������� currDataSet �������� DataSet �������� ���� ������
      if IsDataSetOfSimpleNode(currDataSet) then
      begin
        // currDataSet �������� DataSet �������� ���� ������

        if currDataSet is TOracleDataSet then
        begin
          // ��������� ������ list. ������ ������ ����� �������� � Result

          // ����������, ���� �� � ������ List DataSet,
          // ������� �������� ������� ��� currDataSet
          SubDataSet := false;
          for J := 0 to list.Count - 1 do
            if IsMaster(TOracleDataSet(List[J]), TOracleDataSet(currDataSet)) or
               (currDataSet = List[J]) then
            begin
              SubDataSet := true;
              break;
            end;

          if not SubDataSet then
          begin
            // ���� � ������ DataSet-�, ��� ������� currDataSet �������� ��������
            // ���� ����� DataSet-� �������, �� �� ������� �� ������
            for J := list.Count - 1 downto 0 do
              if IsMaster(TOracleDataSet(currDataSet), TOracleDataSet(List[J])) then
                list.Delete(J);

            // ������� � ������ currDataSet
            list.Add(currDataSet);
          end;
        end;
      end;
    end;
  SetLength(Result, list.Count);
  for I := 0 to list.Count - 1 do
    Result[I] := List[I];
  list.Destroy;
end;

function TfmExpandedTreeTopology.IsMaster(MasterDataSet : TOracleDataSet;
                                          DetailDataSet : TOracleDataSet) : boolean;
var
  currDataSet : TOracleDataSet;
begin
  Result := false;
  if Assigned(DetailDataSet) and Assigned(MasterDataSet) then
  begin
    currDataSet := DetailDataSet;
    while Assigned(currDataSet.Master) do
    begin
      if currDataSet.Master = MasterDataSet then
      begin
        Result := true;
        Exit;
      end;
      currDataSet := currDataSet.Master;
    end;
  end;
end;

procedure TfmExpandedTreeTopology.BuildQueryForExNode(ExpandedNode : TVExpandedNode);
const
  c_newAlias = 'A';
var
  ArrayOfDataSets : TArrayOfDataSet;
  query : TVASUPQuery;
  I, J, Y, Q : Integer;
  nameOfSubDS : String;
  name : String;
  SubSQL : String;
  pos : Integer;
  len_name, len_nameOfSubDS : Integer;
  len_SubSQL : Integer;
  posFROM : Integer;
  posSELECT : Integer;
  posORDER : Integer;
  posWHERE : Integer;
  posGROUP : Integer;
  posHaving : Integer;

  posSubOrder : Integer;

  posSubBegSelect : Integer;
  posSubEndSelect : Integer;

  posEndFROM : Integer;

  MainSQL : String;
  Tables   : TArrayOfString; // �����  ����. ������������ � SQL ������� DataSet ������������ ����
  Aliases  : TArrayOfString; // ������ ����. ������������ � SQL ������� DataSet ������������ ����
  strFROM :  String;

  countSubSQLs : Integer;
  SubSQLs      : TArrayOfString;

  Alias : String;
  SubAlias : String;
  indAlias : Integer;

  indsTables : array of TArrayOfInteger;
  ind : Integer;
  c : Integer;
  fl : Boolean;
  n : Integer;

  MFields : TList;
  DFields : TList;

  countF : Integer;
  str : String;

  nameField : String;
  exists : boolean;

  field : TField;
begin
  indAlias := 0;
  SetLength(ArrayOfDataSets, 0);
  SetLength(SubSQLs, 0);
  countSubSQLs := 0;
  SetLength(indsTables, 0);

  if (ExpandedNode.DSOfExpNode.DataSet is TVASUPQuery) and
     (TVASUPQuery(ExpandedNode.DSOfExpNode.DataSet).AccessLevel <> []) then
  begin
    // ���� DataSet-� �� ������� ����� ����� ��������� ��� ����������� �������
    ArrayOfDataSets := GetVertexSNDataSetsForDataSetOfExNode(ExpandedNode);

    // ����������� �� ������ ArrayOfDataSets �� �������� DataSet-�
    for I := High(ArrayOfDataSets) downto Low(ArrayOfDataSets) do
    begin
      if not ArrayOfDataSets[I].Active then
      begin
        for J := I + 1 to High(ArrayOfDataSets) do
          ArrayOfDataSets[J - 1] := ArrayOfDataSets[J];
        SetLength(ArrayOfDataSets, Length(ArrayOfDataSets) - 1);
      end;
    end;

    query := TVASUPQuery(ExpandedNode.DSOfExpNode.DataSet);

    // ���� �������� DefaultSQL ������,
    // �� ������� �� ������� �������� �������� SQL
    if Length(query.DefaultSQL) = 0 then
      query.DefaultSQL := query.SQL.Text;

    // ������� ��������� � ��������� ExpNode_  ����� , ������� ��������
    // ����� ���������� ����������� ������� � Oracle
    for I := query.VariableCount - 1 downto 0 do
    begin
      name := query.VariableName(I);
      if IsVariableOfSubDataSet(name) then
        query.DeleteVariable(name);
    end;

    MainSQL := query.DefaultSQL;

    posSELECT := 0;

    repeat
      if posSELECT = 0 then
        // ���� ��� ���������� ������� SELECT
        posSELECT := getPosSQLEl(MainSQL, 'SELECT')
      else
        posSELECT := getPosSQLEl(MainSQL, 'SELECT', posSELECT + 6);

      exists := false;

      if posSELECT > 0 then
      begin
        // ���� ��� ��������� ������� FROM
        posFROM   := getPosSQLElWithoutParenthesis(MainSQL, 'FROM', posSelect);

        posWHERE :=  getPosSQLElWithoutParenthesis(MainSQL, 'WHERE', posFROM);

        // ���� ��� ������������ �������� ��������� FROM
        if posWHERE = 0 then
        begin
          posHaving := getPosSQLElWithoutParenthesis(MainSQL, 'HAVING', posFROM);
          posOrder  := getPosSQLElWithoutParenthesis(MainSQL, 'ORDER',  posFROM);
          posGroup  := getPosSQLElWithoutParenthesis(MainSQL, 'GROUP',  posFROM);

          if (posHaving > 0) and ((posOrder = 0) or (posHaving < posOrder)) and ((posGroup = 0) or (posHaving < posGroup)) then
            posEndFrom := posHaving - 1
          else if (posOrder > 0) and ((posGroup = 0) or (posOrder < posGroup)) then
            posEndFrom := posOrder - 1
          else if posGroup > 0 then
            posEndFrom := posGroup - 1
          else
            posEndFrom := Length(MainSQL);
        end
        else
          posEndFrom := posWHERE - 1;

        strFROM := copy(MainSQL, posFROM + 4, posEndFrom - posFROM + 1 - 4);

        // ������ ����� � ������ ������ ������������ � SQL �������
        GetSQLTable(strFROM, Tables, Aliases);

        for I := Low(ArrayOfDataSets) to High(ArrayOfDataSets) do
          for J := 0 to ExpandedNode.Links.Count - 1 do
          begin
            with ExpandedNode.Links[J] do
            begin
              if DataSource.DataSet = ArrayOfDataSets[I] then
              begin
                for Y := 0  to MasterFields.Count - 1 do
                begin
                  if GetIndTable(tables, Aliases, MasterFields.Fields[Y], TOracleDataSet(ExpandedNode.DSOfExpNode.DataSet).Session) >= 0 then
                  begin
                    exists := true;
                    break;
                  end;
                end;
              end;
            end;
            if exists then
              break;
          end;
      end;
    until (posSELECT <= 0) or exists;


    if posSELECT > 0 then
    begin
      MFields := TList.Create;
      DFields := TList.Create;

      // ���������� SQL ������ � ����������� ����������
      for I := Low(ArrayOfDataSets) to High(ArrayOfDataSets) do
      begin
        for Y := 0 to ExpandedNode.Links.Count - 1 do
        begin
          with ExpandedNode.Links[Y] do
          begin
            if ArrayOfDataSets[I].Active then
              if DataSource.DataSet = ArrayOfDataSets[I] then
              begin
                SubSQL := TOracleDataSet(ArrayOfDataSets[I]).SQL.Text;

                // ������� ������ ������ �� SQL ����������, ������,
                // ��� � SQL ��������� ���������� ������� Delphi �������� �� ���������

                // �������� ������ ������� SELECT
                posSubBegSelect := getPosSQLEl(SubSQL, 'SELECT') + Length('SELECT');
                // �������� ����� ������� SELECT
                posSubEndSelect := getPosSQLElWithoutParenthesis(SubSQL, 'FROM', posSubBegSelect) - 1;

                SubSQL := copy(TOracleDataSet(ArrayOfDataSets[I]).SQL.Text, 1, posSubBegSelect - 1);
                for j := 0 to DetailFields.Count - 1 do
                begin
                  if j > 0 then
                    SubSQL := SubSQL + ', '
                  else
                  begin
                    if trim(ExpandedNode.HintOfSubSQL) <> '' then
                      SubSQL := SubSQL + ' /*+ ' + ExpandedNode.HintOfSubSQL + '*/ '
                    else
                      SubSQL := SubSQL + ' ';
                  end;

                  field := ArrayOfDataSets[I].FieldByName(DetailFields.Fields[j]);
                  if field.Origin <> '' then
                    SubSQL := SubSQL + field.Origin + ' ' + DetailFields.Fields[j]
                  else
                    SubSQL := SubSQL + DetailFields.Fields[j]
                end;

                SubSQL := SubSQL + ' ' + copy(TOracleDataSet(ArrayOfDataSets[I]).SQL.Text, posSubEndSelect, Length(TOracleDataSet(ArrayOfDataSets[I]).SQL.Text) - posSubEndSelect + 1);

                // ���� ���������� ���� �������� ORDER BY �� ������� ��� �� ����������
                posSubOrder  := getPosSQLElWithoutParenthesis(SubSQL, 'ORDER');
                if posSubOrder > 0 then
                  SubSQL := copy(SubSQL, 1, posSubOrder - 1);

                len_SubSQL := length(SubSQL);

                // ����������� � SQL ������� ������ ����������
                // � ����������� ����������
                for J := 0 to TOracleDataSet(ArrayOfDataSets[I]).VariableCount - 1 do
                begin
                  nameOfSubDS := TOracleDataSet(ArrayOfDataSets[I]).VariableName(J);
                  nameOfSubDS := copy(nameOfSubDS, 2, Length(nameOfSubDS) - 1);
                  name := GetNameOfVarOfSubDataSet(nameOfSubDS, countSubSQLs);

                  len_nameOfSubDS := Length(nameOfSubDS) + 1;
                  len_name := Length(name) + 1;

                  // ����������� � SQL ������� ������ ����������
                  pos := getPosSQLEl(SubSQL, ':' + nameOfSubDS);
                  if pos > 0 then
                  begin
                    // ����������� ����������
                    query.DeclareVariable(name, TOracleDataSet(ArrayOfDataSets[I]).VariableType(j));
                    query.SetVariable(name, TOracleDataSet(ArrayOfDataSets[I]).GetVariable(j));
                  end;

                  while pos > 0 do
                  begin
                    SubSQL :=  (copy(SubSQL, 1, pos - 1) + ':' + name + copy(SubSQL, pos + len_nameOfSubDS, len_SubSQL - ((pos - 1) + len_nameOfSubDS)));
                    len_SubSQL := Length(SubSQL);//len_SubSQL + len_name - len_nameOfSubDS;
                    pos := pos + len_nameOfSubDS;
                    pos := getPosSQLEl(SubSQL, ':' + nameOfSubDS, pos);
                  end;

                end;

                //query.SQL.Text := InsetrSubQuery(query.SQL.Text, SubSQL, MasterFields, DetailFields);
                Inc(countSubSQLs);
                // ���������� ���������
                SetLength(subSQLs, countSubSQLs);
                subSQLs[countSubSQLs - 1] := subSQL;

                MFields.Add(TList.Create);
                DFields.Add(TList.Create);

                SetLength(indsTables, countSubSQLs);
                c := 0; // ������� ���. ����. � DataSet-� ArrayOfDataSets[I], ������� ����� ����� ���� � ����������� �����
                SetLength(indsTables[countSubSQLs - 1], 0);

                // ���������� ������� ������, ��� ������� �������� ����� ���������
                for J := 0  to MasterFields.Count - 1 do
                begin
                  // ������� ������ ������� � ������ tables, ������� ����� ����� ���� MasterFields.Fields[J] � ����������� �����
                  ind := GetIndTable(tables, Aliases, MasterFields.Fields[J], TOracleDataSet(ExpandedNode.DSOfExpNode.DataSet).Session);
                  if ind >= 0 then
                  begin
                    fl := true; // ����. ���� ����., � ������� ����������� ���� MasterFields.Fields[J],
                                // ��� � ������� ������ � ������ ������ ������������ ����,
                                // �� fl �������� �������� true, ���� ����, �� �������� �������� false
                    n := 0; // ������ ����. � �������, � ������� ����������� ���� MasterFields.Fields[J]
                    for Q := 0 to c - 1 do
                      if indsTables[countSubSQLs - 1][Q] = ind then
                      begin
                        fl := false; // ���������, ��� ����.,
                                     // � ������� ����������� ���� MasterFields.Fields[J], ����� � �������
                        n := q; // ��������� ������ ����. � �������
                        break;  // ������� �� �����
                      end;
                    if fl then
                    begin
                      // ���� ����., � ������� ����������� ���� MasterFields.Fields[J], �� ����� � �������

                      // ��������� ������ ����. � ������
                      Inc(c); // ����������� �������� ��������
                      SetLength(indsTables[countSubSQLs - 1], c); // �������� ������
                      indsTables[countSubSQLs - 1][c - 1] := ind; // ���������� ������ � �������
                      n := c - 1; // ��������� ������ ����. � �������

                      TList(MFields[countSubSQLs - 1]).Add(TStringList.Create);
                      TList(DFields[countSubSQLs - 1]).Add(TStringList.Create);
                    end;

                    // ���������� ���� Master � Detail
                    TStrings(TList(MFields[countSubSQLs - 1])[n]).Add(MasterFields.Fields[J]);
                    TStrings(TList(DFields[countSubSQLs - 1])[n]).Add(DetailFields.Fields[J]);
                  end;
                end;

              end;
          end;
        end;
      end;

      // ��������� SQL ������
      query.SQL.Text := copy(MainSQL, 1, posFROM + 3);
      // ��������� ������ ����. ��� ��������� FROM
      for I := Low(tables) to High(tables) do
      begin
        if  (Length(ArrayOfDataSets) <> 1) or (ExpandedNode.ConnectType = ctManyToOne) then
        begin
          c := 0; // ���������� ������ ������� tables[I] ������������ ���� � �������� ������
          for J := 0 to countSubSQLs - 1 do
          begin
            for Y := Low(indsTables[J]) to High(indsTables[J]) do

              if indsTables[J][Y] = I then
              begin
                if c = 0 then
                begin // ������� ������ �����
                  if Aliases[I] <> '' then
                  begin
                    if Trim(ExpandedNode.HintOfLink) <> '' then
                      query.SQL.Add('(SELECT /*+ ' + ExpandedNode.HintOfLink + '*/ * FROM ' + tables[I] + ' ' + Aliases[I])
                    else
                      query.SQL.Add('(SELECT * FROM ' + tables[I] + ' ' + Aliases[I]);
                  end
                  else
                  begin
                    if Trim(ExpandedNode.HintOfLink) <> '' then
                      query.SQL.Add('(SELECT /*+ ' + ExpandedNode.HintOfLink + '*/ * FROM ' + tables[I])
                    else
                      query.SQL.Add('(SELECT * FROM ' + tables[I]);
                  end;


                  query.SQL.Add('WHERE');
                end
                else // ������� ��� � ����� ������
                  query.SQL.Add('OR');

                str := '(';

                with TStrings(TList(MFields[J])[Y]) do
                begin
                  countF := count;
                  for Q := 0 to countF - 1 do
                  begin
                    if q < (countF - 1) then
                      Str := str + Strings[Q] + ', '
                    else
                      Str := str + Strings[Q];
                  end;
                end;
                Str := str + ') IN';
                query.SQL.Add(str);

                str := '';

                with TStrings(TList(DFields[J])[Y]) do
                begin
                  for Q := 0 to countF - 1 do
                  begin
                    if q < (countF - 1) then
                      Str := str + Strings[Q] + ', '
                    else
                      Str := str + Strings[Q];
                  end;
                end;

                query.SQL.Add('(SELECT ' + str + ' FROM');
                query.SQL.Add('(' + subSQLs[J] + ')');
                query.SQL.Add(')');

                if Trim(ExpandedNode.Filter) <> '' then
                  query.SQL.Add(' AND ' + ExpandedNode.Filter);

                Inc(c)
              end;
          end;
        end
        else
        begin
          c := 0; // ���������� ������ ������� tables[I] ������������ ���� � �������� ������

          Q := -1;
          for J := 0 to countSubSQLs - 1 do
          begin
            for Y := Low(indsTables[J]) to High(indsTables[J]) do
              if indsTables[J][Y] = I then
              begin
                Q := J;
                break;
              end;
            if Q >= 0 then
              break;
          end;

          if Q >= 0 then
          begin
            if Aliases[I] <> '' then
              Alias := Aliases[I]
            else
              Alias := c_newAlias;

            SubAlias := 'E' + Alias;

            if Trim(ExpandedNode.HintOfLink) <> '' then
              query.SQL.Add('(SELECT /*+ ' + ExpandedNode.HintOfLink + '*/ ' + Alias + '.* FROM ' + tables[I] + ' ' + Alias + ',')
            else
              query.SQL.Add('(SELECT ' + Alias + '.* FROM ' + tables[I] + ' ' + Alias + ',');

            query.SQL.Add('(' + subSQLs[Q] + ') ' + SubAlias);

            query.SQL.Add('WHERE');
            for J := 0 to countSubSQLs - 1 do
            begin
              for Y := Low(indsTables[J]) to High(indsTables[J]) do
                if indsTables[J][Y] = I then
                begin
                  if c > 0 then // ������� ��� � ����� ������
                    query.SQL.Add('OR');

                  str := '(';

                  with TStrings(TList(MFields[J])[Y]) do
                  begin
                    for Q := 0 to count - 1 do
                    begin
                      if Q > 0 then
                        str := str + ' AND ';

                      if System.pos('.', Strings[Q]) > 0 then
                        str := str + Strings[Q]
                      else
                        str := str + Alias + '.' + Strings[Q];

                      str := str + '=' + SubAlias + '.' + TStrings(TList(DFields[J])[Y])[Q];
                    end;
                  end;
                  Str := str + ')';
                  query.SQL.Add(str);

                  str := '';

                  if Trim(ExpandedNode.Filter) <> '' then
                    query.SQL.Add(' AND ' + ExpandedNode.Filter);

                  Inc(c);
                end;
            end;
          end;
        end;
        if c = 0 then
          if Aliases[I] <> '' then
            query.SQL.Add(tables[I] + ' ' + Aliases[I])
          else
            query.SQL.Add(tables[I])
        else
          if Aliases[I] <> '' then
            query.SQL.Add(') ' + Aliases[I])
          else
            query.SQL.Add(')');

        c := query.SQL.Count;
        if High(tables) > I then
          query.SQL[c - 1] := query.SQL[c - 1] + ','
      end;
      query.SQL.Text := query.SQL.Text + #13#10 + copy(MainSQL, posEndFrom + 1, Length(MainSQL) - posEndFrom);

      // ������� ������  MasterFields � DetailFields
      for I := 0 to MFields.Count - 1 do
        with TList(MFields[I]) do
        begin
          for J := 0 to count - 1 do
          begin
            TStrings(Items[J]).Destroy;
            TStrings(TList(DFields[I])[J]).Destroy;
          end;
          Destroy;
          TList(DFields[I]).Destroy;
        end;
      MFields.Destroy;
      DFields.Destroy;
    end;
  end;
end;

function TfmExpandedTreeTopology.IsVariableOfSubDataSet(AName : String) : boolean;
var
  lenOfPref  : Integer;
  str_number : String;
  name : String;
  len_Name : Integer;
begin
  Result := false;
  if AName <> '' then
  begin
    if AName[1] = ':' then
      name := copy(AName, 2, Length(AName) - 1)
    else
      name := AName;

    lenOfPref := Length(PrefixOfVarOfSubDataSet);
    len_Name := Length(Name);
    if len_Name > (lenOfPref + 1) then
      if (UpperCase(Copy(name, len_Name - lenOfPref + 1, lenOfPref)) = UpperCase(PrefixOfVarOfSubDataSet)) then
      begin
        str_number := (Copy(name, len_Name - lenOfPref, 1));
        if (str_number[1] >= '0') and (str_number[1] <= '9') then
          Result := true;
    end;
  end;
end;


function TfmExpandedTreeTopology.GetNameOfVarOfSubDataSet(AVariable : String; ANumber : Integer) : String;
begin
  //Result := PrefixOfVarOfSubDataSet;
  //if ANumber < 10 then
  //  Result := Result + '0';
  Result := copy(AVariable, 2, Length(AVariable) - 1)  + IntToStr(ANumber) + PrefixOfVarOfSubDataSet;
end;

procedure TfmExpandedTreeTopology.RefreshDataOfExNode(ExpandedNode : TVExpandedNode; AllowReadDataSet : boolean = true; ASheet : TTabSheet=nil);
begin
  // ��������� ������ ������������ ����
  OpenExNodeSession(ExpandedNode, AllowReadDataSet);

  // ��������� ������ ��� �������� ������������ ���� ASheet. � ������ ����������
end;

function TfmExpandedTreeTopology.NeedToSaveDataOfSheetOfExNode(ExpandedNode : TVExpandedNode; ASheer : TTabSheet=nil) : boolean;
var
  ArrayOfDataSet : TArrayOfDataSet;
  I : Integer;
  currSheet : TTabSheet;
begin
  Result := false;

  if Assigned(ASheer) then
    currSheet := ASheer
  else
    currSheet := ExtNodeToSheet(ExpandedNode);

  // ���� DataSet-�, � ������� ��� ��������� ������,
  // ���������� �������� ������ ������������ ����
  ArrayOfDataSet := GetVertexSNDataSetsForDataSetOfExNode(ExpandedNode);

  // ���������, ���������� �� ��������� ������
  for I := Low(ArrayOfDataSet) to High(ArrayOfDataSet) do
    if not IsRenewedTabSheet(currSheet, ArrayOfDataSet[I]) then
    begin
      Result := true;
      Exit;
    end;
end;

function TfmExpandedTreeTopology.ExtNodeToSheet(ExpandedNode : TVExpandedNode) : TTabSheet;
var
  ind : Integer;
begin
  ind := ExpandedNodes.IndexOf(ExpandedNode);
  if ind >= 0 then
    Result := FTableTabSheetListOfExNodes[ind]
  else
    Result := nil;
end;

function TfmExpandedTreeTopology.SheetToExtNode(ASheet : TTabSheet) : TVExpandedNode;
var
  ind : Integer;
begin
  ind := FTableTabSheetListOfExNodes.IndexOf(ASheet);
  if ind >= 0 then
    Result := ExpandedNodes[ind]
  else
    Result := nil;
end;

procedure TfmExpandedTreeTopology.pcMainChanging(Sender: TObject;
  var AllowChange: Boolean);
var
  n : Integer;
begin
  try
  inherited;
  n := pcMain.Perform(TCM_GETCURFOCUS, 0, 0);
  if ((n = 0) or (n <> 0)) and IsTabSheetOfExtendedNode(pcMain.ActivePage) then
    //if TVASUPQuery(dsCurrent.DataSet).WorkState <> wsNone then
      dsCurrent.DataSet.CheckBrowseMode;
    //if WorkStyle<>wsQuery then
      //AllowChange:= ApplyPageUpdates;
  except
    on ECursorCanNotMoveAboutRecord do;
  end;
end;

procedure TfmExpandedTreeTopology.OpenExNodeSession(ExpandedNode : TVExpandedNode; AllowReadDataSet : boolean = true);
var
  Disabled : boolean;
  ExNodeSheet : TTabSheet;
  ArrayOfDataSet : TArrayOfDataSet;
  I : Integer;
begin
  with ExpandedNode.DSOfExpNode.DataSet as TVASUPQuery do
  begin
    Disabled := ControlsDisabled;
    try
      Screen.Cursor:= crSQLWait;
      Self.Enabled:= false;

      if not Disabled then
        DisableControls;

      if (not Active) or NeedToSaveDataOfSheetOfExNode(ExpandedNode) then
      begin
        CloseExNodeSession(ExpandedNode);

        if Trim(ExpandedNode.SQL) <> ''  then
        begin
          SQL.Text   := ExpandedNode.SQL;
          DefaultSQL := ExpandedNode.SQL;
        end
        else
          ExpandedNode.SQL := SQL.Text;

        BuildQueryForExNode(ExpandedNode);

        // ������ ���� ����� ����� ��� TVASUPQuery!!!
        DefaultSQL := SQL.Text;

        if AllowReadDataSet then
          // ��������� ������
          Open;
      end;

      //OracleDictionary.EnforceConstraints:= false;
      //WorkSpace:= Self;

      // ������������� ������ DataSet ����������� ����, � ���, ������� ��������� �����
      // ��� ����� ����� !!!
      WorkState:= WorkStyle;

      // ���� DataSet-�, � ������� ��� ��������� ������,
      // ���������� �������� ������ ������������ ����
      ArrayOfDataSet := GetVertexSNDataSetsForDataSetOfExNode(ExpandedNode);

      ExNodeSheet := ExtNodeToSheet(ExpandedNode);

      if Assigned(ExNodeSheet) then
        for I := Low(ArrayOfDataSet) to High(ArrayOfDataSet) do
          // ������������� ������, ��� ���������� ������ ���������
          SetRenewed(ExNodeSheet, ArrayOfDataSet[I]);

    finally
      if not Disabled then
        EnableControls;
      Self.Enabled:= true;
      Screen.Cursor:= crDefault;
    end;
  end;
end;

procedure TfmExpandedTreeTopology.CloseExNodeSession(ExpandedNode : TVExpandedNode);
begin
  with ExpandedNode.DSOfExpNode.DataSet as TVASUPQuery do
  begin
    WorkState := wsNone; 
    //CloseViSession;
    //OracleDictionary.EnforceConstraints:= True;
    //GetData(ExpandedNode.DSOfExpNode.DataSet,IN_NONE);
    //Close;
  end;

  // �������� ��������� TVASUPQuery. � ������ ����������
end;

procedure TfmExpandedTreeTopology.CloseAllExNodeSession;
var
  I : Integer;
begin
  for I := 0 to  ExpandedNodes.Count - 1 do
    CloseExNodeSession(ExpandedNodes[I]);
end;

procedure TfmExpandedTreeTopology.synchrPosition(ExpandedNode : TVExpandedNode; BySimpleNode : boolean = true);{(ADataSet : TDataSet; SynchDataSet : TDataSet);}
var
  Disabled : boolean;

  ForeignKeyFields : TList;                 // �������� ����� ������������ ����
  ValueList  : TThreeDimensArrayOfVariant; // �������� �������� ����� ������������ ����
  I, J : Integer;

  ActiveNodes : TArrayOfTreeNode;
  FirstNode, FinalNode : TTreeNode;
  countNode : Integer;
  Disableds : array of boolean;
  currNode : TTreeNode;
  syncherDatSet : TArrayOfOracleDataSet;
begin
  if BySimpleNode then
  begin
    ForeignKeyFields := TList.Create;
    //ExNodeToSimpleNodeList(ExpandedNode, SimpleNodeList);

    with ExpandedNode.DSOfExpNode.DataSet as TVASUPQuery do
    begin
      Disabled := ControlsDisabled;
      try
        Screen.Cursor:= crSQLWait;
        Self.Enabled:= false;

        if not Disabled then
          DisableControls;

        FindCursorENFields(ExpandedNode, ForeignKeyFields, ValueList);

        First;

        while (not EOF) and (not IsExNodeCursor(ValueList, ForeignKeyFields)) do
          Next;

        //if Eof then
        //  RecNo := -1;
      finally
        if not Disabled then
          EnableControls;
        Self.Enabled:= true;
        Screen.Cursor:= crDefault;
      end;
    end;

    for I := 0 to ForeignKeyFields.Count - 1 do
      with TList(ForeignKeyFields[I]) do
      begin
        for j := 0 to Count - 1 do
          with TList(Items[J]) do
            Destroy;
        Destroy;
      end;
    ForeignKeyFields.Destroy;

  end
  else
  begin

    if not ExpandedNode.DSOfExpNode.DataSet.Eof then
    begin
      SetLength(ActiveNodes, 0);
      // ���������� �������� ������� ���� ������
      ActiveNodes := GetActiveNodes;
      // �������� ����� �������� ������� ����� ������, ���� ������� ��������� � ������������ ����
      // ����� ����������� � ������������ �������� Level
      FirstNode := GetFirstSimpleNode(ActiveNodes, ExpandedNode);
      FinalNode := GetFinalSimpleNode(ActiveNodes, ExpandedNode);

      if Assigned(FirstNode) then
      begin
        // ���� ����� �������� ����� ������, ���� ����, ������� ��������� ����������� ����

        // ���������� ����� �������� ������� ����� ������, ������� ����, ���-�� ��������� ����������� ���� ������
        countNode := FinalNode.Level - FirstNode.Level + 1;

        SetLength(syncherDatSet, countNode);

        // ������, ��� ����� ��������� � �������� DateSet-�� �� ���� ������ �� ������
        // � ������ ��� �������
        SetLength(Disableds, countNode);
        Screen.Cursor:= crSQLWait;
        Self.Enabled:= false;

        I := 0;
        currNode := FinalNode;
        syncherDatSet[I] := TOracleDataSet(FinalNode.Data);
        Inc(I);
        while currNode <> FirstNode do
        begin
          currNode := currNode.Parent;
          syncherDatSet[I] := TOracleDataSet(currNode.Data);
          Inc(I);
        end;
        for I := 0 to Length(syncherDatSet) - 1 do
        begin
          Disableds[I] := syncherDatSet[I].ControlsDisabled;
          if not Disableds[I] then
            syncherDatSet[I].DisableControls;
        end;

        try

          for I := 0 to Length(ActiveNodes) - 1 do
            if FirstNode.Level  < ActiveNodes[I].Level then
              TDataSet(ActiveNodes[I].Data).Close;

          SetDetailDataSetCursors(syncherDatSet,ExpandedNode);
          for I := Length(ActiveNodes) - 1 downto 0 do
            if not TDataSet(ActiveNodes[I].Data).Active then
            begin
              Disabled := TDataSet(ActiveNodes[I].Data).ControlsDisabled;
              if Disabled then
                TDataSet(ActiveNodes[I].Data).EnableControls;
              TDataSet(ActiveNodes[I].Data).Open;
              if Disabled then
                TDataSet(ActiveNodes[I].Data).DisableControls;
            end;
        finally
          // ������, ��� ����� ��������� � �������� DateSet-�� ���� ������ �� ������
          // � ���������� ���������� ��� �������
          for I := 0 to Length(syncherDatSet) - 1 do
          begin
            if not Disableds[I] then
            begin
              TDataSet(syncherDatSet[I]).EnableControls;
            end;
          end;

          Self.Enabled:= true;
          Screen.Cursor:= crDefault;
        end;


      end;
    end;

  end;
end;

procedure TfmExpandedTreeTopology.FindCursorENFields(ExpandedNode : TVExpandedNode; FieldList : TList; var ValueList : TThreeDimensArrayOfVariant);
var
  I, J, c : Integer;
  currDataSet : TDataSet;
  Field : TField;
  DataSets : TList;
  ind : Integer;
  indItemCurrDS : Integer;
  Itemlist : TList;
  DataSetItemList : TList;
begin
  DataSets := TList.Create;
  FieldList.Clear;
  SetLength(ValueList, 0);
  with ExpandedNode.Links do
    for I := 0 to Count - 1 do
    begin
      with  Items[I] do
      begin
        // ������ DataSet-�, ������� ������ � ������ DataSet ������������ ���� ������
        currDataSet := DataSource.DataSet;

        // ��������� currDataSet �������� DataSet �������� ���� ������
        // � ������ �� ��
        if IsDataSetOfSimpleNode(currDataSet) and currDataSet.Active then
        begin
          //  ��������� ������� �� currDataSet � ������ DataSets
          ind := DataSets.IndexOf(currDataSet);
          if ind < 0 then
          begin
            ind := DataSets.Add(currDataSet);
            Itemlist := TList.Create;
            FieldList.Add(Itemlist);

            SetLength(ValueList, ind + 1);
            SetLength(ValueList[ind], 1);
            indItemCurrDS := 0;
          end
          else
          begin
            Itemlist := TList(FieldList[ind]);
            indItemCurrDS := Length(ValueList[ind]);
            SetLength(ValueList[ind], indItemCurrDS + 1);
          end;
          DataSetItemList := TList.Create;
          Itemlist.Add(DataSetItemList);
          SetLength(ValueList[ind][indItemCurrDS], 0);

          c := 0;
          for J := 0 to MasterFields.Count - 1 do
          begin
            Field := currDataSet.FindField(DetailFields.Fields[J]);
            if Assigned(Field) then
            begin

              SetLength(ValueList[ind][indItemCurrDS], c + 1);
              ValueList[ind][indItemCurrDS][c] := Field.AsVariant;
              if MasterFields.FieldsName[J] = '' then
                DataSetItemList.Add(ExpandedNode.DSOfExpNode.DataSet.FieldByName(GetNameField(MasterFields.Fields[J], ExpandedNode.DSOfExpNode.DataSet)))
              else
                DataSetItemList.Add(ExpandedNode.DSOfExpNode.DataSet.FieldByName(MasterFields.FieldsName[J]));
              Inc(c);
            end;
          end;
        end;
      end;
    end;
  DataSets.Destroy;
end;

procedure TfmExpandedTreeTopology.ExNodeToSimpleNodeList(ExpandedNode : TVExpandedNode; SimpleNodeList : TList);
var
  I : Integer;
  currDataSet : TDataSet;
begin
  with ExpandedNode.Links do
    for I := 0 to Count - 1 do
    begin
      // ������ DataSet-�, ������� ������ � ������ DataSet ������������ ���� ������
      currDataSet := Items[I].DataSource.DataSet;

      // ��������� currDataSet �������� DataSet �������� ���� ������
      if IsDataSetOfSimpleNode(currDataSet) then
        SimpleNodeList.Add(currDataSet);
    end;
end;

function TfmExpandedTreeTopology.GetNameField(AName : String; ADataSet : TDataSet) : String;
var
  NameF : String;
  I : Integer;
begin
  Result := '';
  NameF := UpperCase(Trim(AName));
  if NameF = '' then
    exit;
  for I := 0 to ADataSet.FieldCount - 1 do
  begin
    with ADataSet.Fields[I] do
    begin
      if (NameF = UpperCase(Origin)) or (NameF = UpperCase(FieldName)) then
      begin
        Result := FieldName;
        Exit;
      end;
    end;
  end;
end;

function TfmExpandedTreeTopology.GetField(AName : String; ADataSet : TDataSet) : TField;
var
  NameF : String;
  I : Integer;
begin
  Result := nil;
  NameF := UpperCase(Trim(AName));
  if NameF = '' then
    exit;
  for I := 0 to ADataSet.FieldCount - 1 do
  begin
    with ADataSet.Fields[I] do
    begin
      if (NameF = UpperCase(Origin)) or (NameF = UpperCase(FieldName)) then
      begin
        Result := ADataSet.Fields[I];
        Exit;
      end;
    end;
  end;
end;

function TfmExpandedTreeTopology.IsExNodeCursor(ValuesOfFields : TThreeDimensArrayOfVariant; Fields : TList) : boolean;
var
  I : Integer;
begin
  Result := true;

  for I := 0 to Fields.Count - 1 do
    if not IsExNodeCursor(ValuesOfFields[I], TList(Fields[I])) then
    begin
      Result := false;
      Exit;
    end;
end;

function TfmExpandedTreeTopology.IsExNodeCursor(ValuesOfFields : TTwoDimensArrayOfVariant; Fields : TList) : boolean;
var
  I : Integer;
begin
  Result := false;

  // ���� � DataSet-� ������, ������� �� ��������������� ���� �� ������ �����
  // � ���� ������� ��� ���������. ���� ���� ���� �� ���� ������� ����������, �� �-��� ������ ���������� true
  for I := 0 to Fields.Count - 1 do
    if IsExNodeCursor(ValuesOfFields[I], TList(Fields[I])) then
    begin
      Result := true;
      Exit;
    end;
end;

function TfmExpandedTreeTopology.IsExNodeCursor(ValuesOfFields : TArrayOfVariant; Fields : TList) : boolean;
var
  I : Integer;
  field : TField;
begin
  Result := true;

  for I := 0 to Fields.Count - 1 do
  begin
    field := Fields[I];
    if not (Assigned(field) and (Field.AsVariant = ValuesOfFields[I])) then
    begin
      Result := false;
      Exit;
    end;
  end;
end;

procedure TfmExpandedTreeTopology.pcMainChange(Sender: TObject);
var
  I, ind : Integer;
begin
  inherited;
  if IsTabSheetOfTabSheetExtdNode(pcMain.ActivePage) then
  begin
    for I := 0 to ExpandedNodes.Count - 1 do
      with ExpandedNodes[I] do
      begin
        ind := TabSheets.IndexOf(pcMain.ActivePage);
        if ind >= 0 then
        begin
          ActivateExNodeDataSet(ExpandedNodes[I]);

          // � ������ ����������

          break;
        end
      end;
  end
  else if IsTabSheetOfTablExtNode(pcMain.ActivePage) then
    ActivateExNodeDataSet(ExpandedNodes[FTableTabSheetListOfExNodes.IndexOf(pcMain.ActivePage)])
  else if IsDataSetOfExpandedNode(dsCurrent.DataSet) and
          IsActivePageOfSimpleNode then
  begin
    try
      FChangingPageContrMain := true;
      ActivateDataSet(TDataSet(TreeView.Selected.Data));
    finally
      FChangingPageContrMain := false;
    end;
  end;
end;

function TfmExpandedTreeTopology.IsActivePageOfSimpleNode : boolean;
begin
  result := (pcMain.ActivePage = tsList) or (Integer(TreeView.Selected.Data) = pcMain.ActivePage.Tag);
end;

procedure TfmExpandedTreeTopology.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  I, J : Integer;
  nameOfVar : String;
begin
  inherited;
  CloseAllExNodeSession;

  for I := 0 to ExpandedNodes.Count - 1 do
  begin
    with ExpandedNodes[I] do
    begin
      if Assigned(DSOfExpNode) and Assigned(DSOfExpNode.DataSet) and (DSOfExpNode.DataSet is TVASUPQuery) then
      begin
        with DSOfExpNode.DataSet as TVASUPQuery do
        begin
          // ������� ��������� � ��������� ExpNode_  ����� , ������� ��������
          // ����� ���������� ����������� ������� � Oracle
          for J := VariableCount - 1 downto 0 do
          begin
            nameOfVar := VariableName(J);
            if IsVariableOfSubDataSet(nameOfVar) then
              DeleteVariable(nameOfVar);
          end;
          if ExpandedNodes[I].SQL <> '' then
          begin
            DefaultSQL := ExpandedNodes[I].SQL;
            SQL.Text   := ExpandedNodes[I].SQL;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfmExpandedTreeTopology.ActivateExNodeDataSet(ExpandedNode : TVExpandedNode);
var
  arrayOfDataSet : TArrayOfDataSet;
  _DBGrid : TDBGRid;
begin
  ChangeCurrentSet(ExpandedNode.DSOfExpNode.DataSet);
  ChangeVisibleTabSheet;
  _DBGrid := GetCurrGrid;
  if Assigned(_DBGrid) then
    RestoreGridSavings(_DBGrid, true);
  arrayOfDataSet := GetVertexSNDataSetsForDataSetOfExNode(ExpandedNode);
  if Length(arrayOfDataSet) > 0 then
    ChangeMasterPanels(false, FindSimpleNode(arrayOfDataSet[0]).Level);
  ActiveControl:= nil;
  ControlArea:= pcMain.ActivePage;
  Caption:= StyleToText(Ws2Msg(WorkStyle));
  RepaintTreeQueryState;
  RefreshNavigator;
end;

function TfmExpandedTreeTopology.FindExpNTDBGrid(AExpandedNode: TVExpandedNode):TDBGrid;
var
  I : INteger;
begin
  Result := nil;
  if not Assigned(AExpandedNode.TableTabSheet) then
    with ExtNodeToSheet(AExpandedNode) do
      for I := 0 to ControlCount - 1 do
        if Controls[I] is TDBGrid then
        begin
          Result := TDBGrid(Controls[I]);
          Exit;
        end;
end;

function TfmExpandedTreeTopology.IsDataSetInExNode(ADataSet : TDataSet; AExpNode : TVExpandedNode) : boolean;
var
  I : Integer;
begin
  Result := false;
  for I := 0 to AExpNode.Links.Count - 1 do
    if ADataSet = AExpNode.Links[I].DataSource.DataSet then
      Result := true;
end;

function TfmExpandedTreeTopology.GetFirstSimpleNode(ASimpleNodes : TArrayOfTreeNode; AExpNode : TVExpandedNode) : TTreeNode;
var
  I : Integer;
  currNode : TTreeNode;
begin
  Result := nil;
  for I := Low(ASimpleNodes) to High(ASimpleNodes) do
  begin
    currNode := ASimpleNodes[I];
    if (not Assigned(Result)) or (Result.Level > currNode.Level) then
      if IsDataSetInExNode(TDataSet(currNode.Data), AExpNode) then
        Result := currNode;
  end;
end;

function TfmExpandedTreeTopology.GetFinalSimpleNode(ASimpleNodes : TArrayOfTreeNode; AExpNode : TVExpandedNode) : TTreeNode;
var
  I : Integer;
  currNode : TTreeNode;
begin
  Result := nil;
  for I := Low(ASimpleNodes) to High(ASimpleNodes) do
  begin
    currNode := ASimpleNodes[I];
    if (not Assigned(Result)) or (Result.Level < currNode.Level) then
      if IsDataSetInExNode(TDataSet(currNode.Data), AExpNode) then
        Result := currNode;
  end;
end;

function TfmExpandedTreeTopology.GetDataSetWithNewParametr(ADataSet : TOracleDataSet; AFields : TList; AValues : TArrayOfVariant) : TOracleDataSet;
var
  I, J : Integer;
  Existent : boolean;
  DetailFields : TStrings;
  posOrder : Integer;
  VariableName : String;
  field : TField;
begin
  Result := TOracleDataSet.Create(nil);
  Result.SQL.Text := ADataSet.SQL.Text;

  // ���� ���������� ���� �������� ORDER BY �� ������� ��� �� ����������
  posOrder  := getPosSQLElWithoutParenthesis(Result.SQL.Text, 'ORDER');
  if posOrder > 0 then
    Result.SQL.Text := copy(Result.SQL.Text, 1, posOrder - 1);

  DetailFields := TStringList.Create;
  StringToStringsWithSemicolon(ADataSet.DetailFields, DetailFields);
  for I := 0 to ADataSet.VariableCount - 1 do
  begin
    VariableName := ADataSet.VariableName(I);
    VariableName := copy(VariableName, 2, Length(VariableName) - 1);
    Existent := true;
    if DetailFields.IndexOf(VariableName) >=0 then
    begin
      Existent := false;
      for J := 0 to AFields.Count - 1 do
      if UPPERCASE(TField(AFields[J]).FieldName) = UPPERCASE(VariableName) then
      begin
        Existent := true;
        break;
      end;
    end;

    if Existent then
    begin
      Result.DeclareVariable(VariableName, ADataSet.VariableType(I));
      Result.SetVariable(I, ADataSet.GetVariable(I));
    end
    else
      Result.SQL.Text := DeleteVariableFromSQL(VariableName, Result.SQL.Text);
  end;


  for I := 0 to AFields.Count - 1 do
  begin
    field := TField(AFields[I]);
    //if DetailFields.IndexOf(field.FieldName) >= 0 then
    if ADataSet.VariableIndex(field.FieldName) >= 0 then
      Existent := true
    else
      Existent := false;

    if not Existent then
    begin
      if field is TIntegerField then
        Result.DeclareVariable(field.FieldName, otInteger)
      else if field is TNumericField then
        Result.DeclareVariable(field.FieldName, otFloat)
      else if field is TDateTimeField then
        Result.DeclareVariable(field.FieldName, otDate)
      else
        Result.DeclareVariable(field.FieldName, otString);

      if field.Origin <> '' then
        Result.SQL.Text := InsertVariableFromSQL(field.FieldName, Result.SQL.Text, field.Origin)
      else
        Result.SQL.Text := InsertVariableFromSQL(field.FieldName, Result.SQL.Text, field.FieldName);
      end;

      Result.SetVariable(field.FieldName, AValues[I]);
    end;

  Result.Session := ADataSet.Session;

  DetailFields.Destroy;
end;


function TfmExpandedTreeTopology.GetDataSetWithNewParametr(ADataSet : TOracleDataSet; AFields : TList; AValues : TTwoDimensArrayOfVariant) : TOracleDataSet;
var
  I, J : Integer;
  DetailFields : TStrings;
  field : TField;
  posOrder : Integer;
  SubIf : String;
  LIf : String;
  VariableNAme : String;
  FieldName : String;
begin
  if AFields.Count <> 1 then
  begin
    Result := TOracleDataSet.Create(nil);
    Result.SQL.Text := ADataSet.SQL.Text;

    // ���� ���������� ���� �������� ORDER BY �� ������� ��� �� ����������
    posOrder  := getPosSQLElWithoutParenthesis(Result.SQL.Text, 'ORDER');
    if posOrder > 0 then
      Result.SQL.Text := copy(Result.SQL.Text, 1, posOrder - 1);

    DetailFields := TStringList.Create;
    StringToStringsWithSemicolon(ADataSet.DetailFields, DetailFields);
    for I := 0 to ADataSet.VariableCount - 1 do
    begin
      VariableName := ADataSet.VariableName(I);
      VariableName := copy(VariableName, 2, Length(VariableName) - 1);

      if DetailFields.IndexOf(VariableName) < 0 then
      begin
        Result.DeclareVariable(VariableName, ADataSet.VariableType(I));
        Result.SetVariable(I, ADataSet.GetVariable(I));
      end
      else
        Result.SQL.Text := DeleteVariableFromSQL(DetailFields[I], Result.SQL.Text);
    end;

    LIf := '';
    for I := 0 to AFields.Count - 1 do
      with TList(AFields[I]) do
      begin
        SubIf := '';

        for J := 0 to Count - 1 do
        begin
          field := TField(Items[J]);
          VariableName := GetNameOfVarOfSubDataSet(field.FieldName, I);

          if field is TIntegerField then
            Result.DeclareVariable(VariableName, otInteger)
          else if field is TNumericField then
            Result.DeclareVariable(VariableName, otFloat)
          else if field is TDateTimeField then
            Result.DeclareVariable(VariableName, otDate)
          else
            Result.DeclareVariable(VariableName, otString);

          if field.Origin <> '' then
            FieldName := field.Origin
          else
            FieldName := field.FieldName;

          Result.SetVariable(VariableName, AValues[I][J]);

          if SubIf <> '' then
            SubIf := SubIf + ' AND ' + GetVariableFromSQL(VariableName, FieldName)
          else
            SubIf := GetVariableFromSQL(VariableName, FieldName);
        end;

        if LIf <> '' then
          LIf := LIf + ' OR (' + SubIf + ')'
        else
          LIf := '((' + SubIf + ')';
      end;

      IF LIf <> '' then
        Result.SQL.Text := InsertIfInSQL(Result.SQL.Text, LIf + ')');

    Result.Session := ADataSet.Session;

    DetailFields.Destroy;
  end
  else
    Result := GetDataSetWithNewParametr(ADataSet, TList(AFields[0]), AValues[0]);
end;

function TfmExpandedTreeTopology.SetMasterDataSetCursorsWithOracle(
                                         ADataSet : TOracleDataSet; AFields : TList; AValues : TArrayOfVariant;
                                         AMasterDataSet : TOracleDataSet
                                         ) : boolean;
var
  I : Integer;
  adjuvantDS : TOracleDataSet;
  MasterFields : TList;
  DetailFields : TList;
  MasterValues : TArrayOfVariant;
  Master : TOracleDataSet;
  strDetailFields : TStrings;
  strMasterFields : TStrings;
  currDataSet : TOracleDataSet;
  Disabled : boolean;
begin
  Result := false;

  if ADataSet <> AMasterDataSet then
  begin
    if ADataSet.Active then
      ADataSet.Close;
    adjuvantDS := GetDataSetWithNewParametr(ADataSet, AFields, AValues);
    strMasterFields := TStringList.Create;
    StringToStringsWithSemicolon(ADataSet.MasterFields, strMasterFields);
    strDetailFields := TStringList.Create;
    StringToStringsWithSemicolon(ADataSet.DetailFields, strDetailFields);
    MasterFields := TList.Create;
    DetailFields := TList.Create;
    Master := ADataSet.Master;
    adjuvantDS.Open;

    for I := 0 to strMasterFields.Count - 1 do
      MasterFields.Add(Master.FieldByName(strMasterFields[I]));

    for I := 0 to strDetailFields.Count - 1 do
      DetailFields.Add(adjuvantDS.FieldByName(strDetailFields[I]));

    SetLength(MasterValues, MasterFields.Count);

    while not adjuvantDS.Eof do
    begin

      for I := 0 to DetailFields.Count - 1 do
      begin
        MasterValues[I] := TField(DetailFields[I]).AsVariant;
      end;

      if SetMasterDataSetCursorsWithOracle(Master, MasterFields, MasterValues, AMasterDataSet) then
      begin
        Result := true;
        break;
      end;

      adjuvantDS.next;
    end;

    strMasterFields.Destroy;
    strDetailFields.Destroy;
    MasterFields.Destroy;
    DetailFields.Destroy;
    adjuvantDS.Close;
    adjuvantDS.Destroy;

    if not Result then
      Exit;
  end;

  with ADataSet do
  begin
    if not Active then
    begin
      Disabled := ControlsDisabled;
      if Disabled then
        EnableControls;
      Open;
      if Disabled then
        DisableControls;
    end
    else
      First;


    while (not EOF) and (not IsExNodeCursor(AValues, AFields)) do
      Next;

    if not EOF then
      Result := true
    else
    begin
      Result := false;
      currDataSet := ADataSet;
      Close;
      while (currDataSet <> AMasterDataSet) and (currDataSet.Master <> nil) do
      begin
        currDataSet := currDataSet.Master;
        currDataSet.Close;
      end;
    end;
  end

end;

function TfmExpandedTreeTopology.SetDetailDataSetCursors(AActiveDetails : TArrayOfOracleDataSet;
                                     AExpNode : TVExpandedNode) : boolean;
var
  currDataSet : TOracleDataSet;
  EnsuantSubExpandNode : boolean;
  I, J : Integer;
  Links : array of TLinkNode;
  MainMaster : TOracleDataSet;
  c : Integer;
  Values : TTwoDimensArrayOfVariant;
  Fields : TList;
  f : TList;
  Field : TField;
  ActiveDetails : TArrayOfOracleDataSet;
  adjuvantDS : TOracleDataSet;
  strDetailFields : TStrings;
  strMasterFields : TStrings;
  MasterFields : TList;
  DetailFields : TList;
  MasterValues : TArrayOfVariant;
  Master : TOracleDataSet;
  offs : Integer;
  Disabled : boolean;
begin
  if Length(AActiveDetails) > 0 then
  begin
    // � ������� AActiveDetails ������ DataSet ����� �������, ������� �������� ������ DataSet-�� � �������;
    // ������ DataSet-�� � ������� ����� �������, ������� �������� ������� DataSet-�� � ������� ���
    currDataSet := AActiveDetails[High(AActiveDetails)];

    // ��������� �������� �� currDataSet ������ ������������ ����
    EnsuantSubExpandNode := false;
    c := 0;
    SetLength(Links, c);
    with AExpNode.Links do
    begin
      for I := 0 to Count - 1 do
        if Items[I].DataSource.DataSet = currDataSet then
        begin
          EnsuantSubExpandNode := true;
          SetLength(Links, c + 1);
          Links[c] := Items[I];
          Inc(c);
        end;

      MainMaster := nil;

      offs := 0;

      if not EnsuantSubExpandNode then
      begin
        MainMaster := currDataSet;
        currDataSet := nil;
        Inc(offs);
        for I := High(AActiveDetails) - 1 downto Low(AActiveDetails) do
        begin
          Inc(offs);
          for J := 0 to Count - 1 do
            if Items[J].DataSource.DataSet = AActiveDetails[I] then
            begin
              currDataSet := AActiveDetails[I];
              SetLength(Links, c + 1);
              Links[c] := Items[J];
              Inc(c);
            end;
          if Assigned(currDataSet) then
            break;
        end;
        if not Assigned(currDataSet) then
        begin
          Result := true;
          Exit;
        end;
      end;
    end;

    // ����������, ����� ������ ���� ��������-������� � currDataSet
    // � ���������, ����� ������� ������ ���� � �������� �������� � currDataSet
    Fields := TList.Create;
    SetLength(Values, Length(Links));
    for I := Low(Links) to High(Links) do
    begin
      f := TList.Create;
      Fields.Add(f);
      SetLength(Values[I], Links[I].CountKeyFields);
      for J := 0 to Links[I].CountKeyFields - 1 do
      begin

        if Links[I].MasterFields.FieldsName[J] = '' then
          Field := GetField(Links[I].MasterFields.Fields[J], AExpNode.DSOfExpNode.DataSet)
        else
          Field := GetField(Links[I].MasterFields.FieldsName[J], AExpNode.DSOfExpNode.DataSet);

        //Field := GetField(Links[I].MasterFields.Fields[J], AExpNode.DSOfExpNode.DataSet);
        Values[I][J] := Field.AsVariant;
        if Links[I].DetailFields.FieldsName[J] = '' then
          Field := GetField(Links[I].DetailFields.Fields[J], currDataSet)
        else
          Field := GetField(Links[I].DetailFields.FieldsName[J], currDataSet);
        //Field := GetField(Links[I].DetailFields.Fields[J], currDataSet);
        f.Add(Field);
      end;
    end;

    if EnsuantSubExpandNode then
    begin
      if not currDataSet.Active then
      begin
        Disabled := currDataSet.ControlsDisabled;
        if Disabled then
          currDataSet.EnableControls;
        currDataSet.Open;
        if Disabled then
          currDataSet.DisableControls;
      end
      else
        currDataSet.First;

      Result := false;

      SetLength(ActiveDetails, Length(AActiveDetails) - 1);
      for I := Low(AActiveDetails) to High(AActiveDetails) - 1 do
        ActiveDetails[I] := AActiveDetails[I];


      while (not currDataSet.EOF) and (not Result) do
        if IsExNodeCursor(Values, Fields) then
        begin
          Result := SetDetailDataSetCursors(ActiveDetails, AExpNode);
          if not Result then
            currDataSet.Next
          else
            break;
        end
        else
          currDataSet.Next;

      if not Result then
        currDataSet.close;
    end
    else
    begin
      adjuvantDS := GetDataSetWithNewParametr(currDataSet, Fields, Values);
      if currDataSet.Active then
        currDataSet.Close;
      adjuvantDS.Open;

      MasterFields := TList.Create;
      DetailFields := TList.Create;

      strMasterFields := TStringList.Create;
      StringToStringsWithSemicolon(currDataSet.MasterFields, strMasterFields);
      strDetailFields := TStringList.Create;
      StringToStringsWithSemicolon(currDataSet.DetailFields, strDetailFields);

      Master := currDataSet.Master;

      for I := 0 to strMasterFields.Count - 1 do
        MasterFields.Add(Master.FieldByName(strMasterFields[I]));

      for I := 0 to strDetailFields.Count - 1 do
        DetailFields.Add(adjuvantDS.FieldByName(strDetailFields[I]));

      SetLength(MasterValues, MasterFields.Count);

      Result := false;

      SetLength(ActiveDetails, Length(AActiveDetails) - offs);
      for I := Low(AActiveDetails) to High(AActiveDetails) - offs do
        ActiveDetails[I] := AActiveDetails[I];

      while (not adjuvantDS.EOF) and (not Result) do
      begin

        for I := 0 to DetailFields.Count - 1 do
        begin
          MasterValues[I] := TField(DetailFields[I]).AsVariant;
        end;

        if SetMasterDataSetCursorsWithOracle(Master, MasterFields, MasterValues, MainMaster) then
        begin

          Disabled := currDataSet.ControlsDisabled;
          if Disabled then
            currDataSet.EnableControls;
          currDataSet.Open;
          if Disabled then
            currDataSet.DisableControls;


          while (not currDataSet.EOF) and (not Result) do
            if IsExNodeCursor(Values, Fields) then
            begin
              Result := SetDetailDataSetCursors(ActiveDetails, AExpNode);
              if not Result then
                currDataSet.Next
              else
                break;
            end
            else
              currDataSet.Next;

          if not Result then
            currDataSet.close
          else
            break;

        end;

        adjuvantDS.Next;
      end;

      strDetailFields.Destroy;
      strMasterFields.Destroy;
      MasterFields.Destroy;
      DetailFields.Destroy;
      adjuvantDS.Close;
      adjuvantDS.Destroy;
    end;


    for I := 0 to Fields.Count - 1 do
      TList(Fields[I]).Destroy;
    Fields.Destroy;
  end
  else
    Result := true;
end;

procedure TfmExpandedTreeTopology.FormCreate(Sender: TObject);
begin
  inherited;
  FChangingPageContrMain := false;

  FOldIndTab_pcMain := -1;

  // ���������� ����������� ���������� ��������� � pcMain
  FWndProc_pcMain := pcMain.WindowProc;
  // ������ ����������� ���������� ��������� �� WndProc_pcMain ���������� � pcMain
  pcMain.WindowProc := WndProc_pcMain;

end;

procedure TfmExpandedTreeTopology.WndProc_pcMain(var Message: TMessage);
var
  oldTab : TTabSheet;
  currTab : TTabSheet;
  curTabInd : Integer;
  I, J : Integer;
  ind, prevInd : Integer;
  pageInd : Integer;
  permitted : boolean; // ��������� �������� ���������
begin
  // ������ ����� ���������� ���������� �� �������� �������� �������� � pcMain,
  // ���� ���������, �� �� �� ��� ����������� �������� ������� �������� ��������.
  // ������ ����� �����, ��� ������� OnChanihg � OnChange ���, ��� �� ����� �������  ��������


  if Message.Msg = CN_NOTIFY  then
  begin
    // ������������� ��������� CN_NOTIFY

    if TWMNotify(Message).NMHdr^.code = TCN_SELCHANGING then
      // ��������� CN_NOTIFY � ����� TCN_SELCHANGING ���������� ����� ���,
      // ��� ������ ��������� �������� ��������

      // ���������� ������ �������� ��������
      FOldIndTab_pcMain := pcMain.Perform(TCM_GETCURSEL, 0, 0)
    else if TWMNotify(Message).NMHdr^.code = TCN_SELCHANGE then
    begin
      // ��������� CN_NOTIFY � ����� TCN_SELCHANGE ���������� ����� ����� ����,
      // ��� ��������� ������ �������� ��������


      // ���������� �� ��������� ������ �������� ������� �������� ���������� ��������
      // oldTab -  �������� ���������� ��������
      oldTab := nil;
      prevInd := -1;
      Ind := -1;
      for I := 0 to FOldIndTab_pcMain do
      begin
        Ind := -1;
        for J := 0 to pcMain.PageCount - 1 do
        begin
          pageInd := pcMain.Pages[J].PageIndex;
          if ((Ind < 0) or (Ind > pageInd)) and
             ((prevInd < 0) or (prevInd < pageInd)) and
             pcMain.Pages[J].TabVisible then
            Ind := pageInd;
        end;
        if Ind < 0 then
          break;
        prevInd := Ind;
      end;
      if Ind >= 0 then
        oldTab := pcMain.Pages[Ind];

      if not IsTabSheetOfExtendedNode(oldTab) then
      begin
        // �������� ���������� �������� �� �������� ��������� ������������ ����

        // ���������� �� ��������� ������ �������� ������� ��������  ��������
        // currTab - �������� ��������
        currTab := nil;
        prevInd := -1;
        Ind := -1;
        curTabInd := pcMain.Perform(TCM_GETCURSEL, 0, 0);
        for I := 0 to curTabInd do
        begin
          Ind := -1;
          for J := 0 to pcMain.PageCount - 1 do
          begin
            pageInd := pcMain.Pages[J].PageIndex;
            if ((Ind < 0) or (Ind > pageInd)) and
               ((prevInd < 0) or (prevInd < pageInd)) and
               pcMain.Pages[J].TabVisible then
              Ind := pageInd;
          end;
          if Ind < 0 then
            break;
          prevInd := Ind;
        end;
        if Ind >= 0 then
          currTab := pcMain.Pages[Ind];

        if IsTabSheetOfExtendedNode(currTab) then
        begin
          // �������� �������� ��������  ��������� ������������ ����

          // ����������, �������� �� ������� �� ���������� ����
          permitted := true;
          // ������ ���������� �������� ��������
          pcMain.Perform(TCM_SETCURSEL, FOldIndTab_pcMain, 0);
          TreeView.OnChanging(TreeView, TreeView.Selected, permitted);

          if not permitted then
          begin
            // ������� ��������

            FOldIndTab_pcMain := -1;
            // ���������� ��������� ���������
            Exit;
          end
          else
          begin
            pcMain.Perform(TCM_SETCURSEL, curTabInd, 0);
            if WorkStyle <> wsQuery then
              WorkStyle := wsView;
          end;
        end;
      end;

      FOldIndTab_pcMain := -1;
    end;

  end;


  FWndProc_pcMain(Message);
end;

procedure TfmExpandedTreeTopology.DoBeforePost(ASUPQuery: TVASUPQuery);
begin
  inherited DoBeforePost(ASUPQuery);

  // �������� ���� ���������, ��� ������ � ASUPQuery ����������
  SetModifiable(ASUPQuery);
end;

procedure TfmExpandedTreeTopology.DoBeforeOpen(ASUPQuery: TVASUPQuery);
begin
  inherited DoBeforeOpen(ASUPQuery);

  // �������� ���� ���������, ��� ������ � ASUPQuery ����������
  SetModifiable(ASUPQuery);
end;

procedure TfmExpandedTreeTopology.DoBeforeRefresh(ASUPQuery: TVASUPQuery);
begin
  inherited DoBeforeRefresh(ASUPQuery);

  // �������� ���� ���������, ��� ������ � ASUPQuery ����������
  SetModifiable(ASUPQuery);
end;

procedure TfmExpandedTreeTopology.DoAfterRefresh(ASUPQuery: TVASUPQuery);
var
  ExNode : TVExpandedNode;
begin
  inherited DoBeforeRefresh(ASUPQuery);

  if IsDataSetOfExpandedNode(dsCurrent.DataSet) then
  begin
    ExNode := DataSetToExNode(dsCurrent.DataSet);
    RefreshDataOfExNode(ExNode);
  end;
end;

function TfmExpandedTreeTopology.GetSNMasterSupportExNodeSynch(ADataSet : TOracleDataSet) : TOracleDataSet;
var
  DataSets : TList;
  Master : TOracleDataSet;
  I, J, Y, Q, Z : Integer;
  MasterDataSets : TArrayOfDataSet;
  Ind : Integer;
  founded : boolean; // ������������ �������� �������

  foundedSynch : boolean;

  LDataSet : TDataSet;
  NameField : String;
begin
  Result := ADataSet;
  founded := false;
  SetLength(MasterDataSets, 0);
  DataSets := TList.Create;

  // ��������� ������ �������� ADataSet ������� � ADataSet
  // ��������� ������ ���, ��� ��������� ������� ������ ��� �������� ������ �������� ������,
  // ������������� ������� ��������, � �������� ������� ��� ���� ������ ���������� ��������, �� ���� ���� ���������� ���������
  // ���
  // � ������ ��������� ��� �� ADataSet
  Master := ADataSet;
  repeat
    DataSets.Add(Master);
    Master := Master.Master;
  until Master = nil;

  for I := 0 to ExpandedNodes.Count - 1 do
  begin
    if not NeedToSaveDataOfSheetOfExNode(ExpandedNodes[I]) then
    begin
      // ��������� ������ �������� DataSet-�� ������ �������� ������,
      // ������� ������ � ������ ������ ������������ ����
      MasterDataSets := GetVertexSNDataSetsForDataSetOfExNode(ExpandedNodes[I]);

      for J := low(MasterDataSets) to high(MasterDataSets) do
      begin
        // ����������, ���� �� � ������ DataSets MasterDataSets[J] � ������ �������� � ������
        Ind := DataSets.IndexOf(MasterDataSets[J]);
        if Ind >= 0 then
        begin
          // MasterDataSets[J] ���� � ������ DataSets

          // ������ ��������� ������ �������������
          foundedSynch := false;

          while (Ind >= 0) and (not foundedSynch) do
          begin
            // ����������, ���� �� ����� ��� ������������� ������� � ���������� �����
            LDataSet := TDataSet(DataSets[Ind]);
            for Y := 0 to ExpandedNodes[I].Links.Count - 1 do
            begin
              if ExpandedNodes[I].Links[Y].DataSource.DataSet = LDataSet then
              begin
                for Q := 0 to ExpandedNodes[I].Links[Y].CountKeyFields - 1 do
                begin
                  NameField := ExpandedNodes[I].Links[Y].DetailFields.Fields[Q];
                  for Z := 0 to LDataSet.Fields.Count - 1 do
                  begin
                    if LDataSet.Fields[Z].Origin = NameField then
                    begin
                      foundedSynch := true;
                      break;
                    end;
                  end;
                  if (not foundedSynch) and Assigned(LDataSet.FindField(NameField)) then
                    foundedSynch := true;
                end;
              end;
            end;

            if not foundedSynch then
              dec(Ind);
          end;

          if foundedSynch then
          begin
            // ������ DataSet c ������� ��� ������������� ������� � ���������� �����
            // ������

            founded := true;
            // ������� �� ������ DataSet-�, ������� ����� �� ����� ��������� �������� �������� ������
            // �������� � ������ ������ ��� ������������� � ������������ ������
            for Y := DataSets.Count - 1 downto  Ind + 1 do
              DataSets.Delete(Y);
          end;
        end;
      end;
    end;
  end;

  if founded then
    Result := TOracleDataSet(DataSets[DataSets.Count - 1]);

  DataSets.Destroy;
end;

procedure TfmExpandedTreeTopology.UMOthers(var Message:TMessage);
var
  MasterDataSets : TArrayOfDataSet;
  I : Integer;
begin
  SetLength(MasterDataSets, 0);
  if Message.wParam = IN_REFRESH then
  begin
    if IsDataSetOfExpandedNode(dsCurrent.DataSet) then
    begin
      Screen.Cursor:= crSQLWait;
      // ��������� ������ �������� DataSet-�� ������ �������� ������,
      // ������� ������ � ������ ������ ������������ ����
      MasterDataSets := GetVertexSNDataSetsForDataSetOfExNode(DataSetToExNode(dsCurrent.DataSet));
      for I := low(MasterDataSets) to high(MasterDataSets) do
        if MasterDataSets[I].Active then
          MasterDataSets[I].Refresh;

      RefreshDataOfExNode(DataSetToExNode(dsCurrent.DataSet), false);
      Screen.Cursor:= crDefault;
    end;
    inherited;
  end
  else
    inherited;
end;

function TfmExpandedTreeTopology.GetCurrGrid : TDBGrid;
var
  currExNode : TVExpandedNode;
begin
  if IsDataSetOfExpandedNode(dsCurrent.DataSet) then
  begin
    // �������� ��������� ����

    // ���������� �������� ������� ����
    currExNode := DataSetToExNode(dsCurrent.DataSet);

    // ���������� ������� ������� ����
    Result := FindExpNTDBGrid(currExNode);
  end
  else
    Result := DBGrid;
end;

procedure TfmExpandedTreeTopology.SaveGridCols(ADBGrid: TDBGrid=nil);
var
  _DBGrid : TDBGrid;
begin
  if not Assigned(ADBGrid) then
  begin
    if IsDataSetOfExpandedNode(dsCurrent.DataSet) then
    begin
      _DBGrid := GetCurrGrid;
      if Assigned(_DBGrid) then
        inherited SaveGridCols(_DBGrid);
    end
    else
      inherited;
  end
  else
    inherited SaveGridCols(ADBGrid);
end;

procedure TfmExpandedTreeTopology.OnModifiable(ADataSet : TDataSet);
begin
end;


//function TfmExpandedTreeTopology.NeedToSave(DataSet:TDataSet):bool;
//begin
//end;

//--------------------------TExpandedNodesForWindow-----------------------------

constructor  TExpandedNodesForWindow.Create;
begin
  FExpandedNodes := TObjectList.Create(false);
end;

destructor  TExpandedNodesForWindow.Destroy;
var
  I : Integer;
begin
  if Assigned(FOnDelete) then
    for I := Count - 1 downto 0 do
      if Assigned(FOnDelete) then
        Delete(I)
      else
        break;
  FExpandedNodes.Destroy;
end;

function  TExpandedNodesForWindow.GetExpandedNode(Index : Integer) : TVExpandedNode;
var
  obj : TObject;
begin
  Result := nil;
  obj := FExpandedNodes[Index];
  if obj is TVExpandedNode then
    Result := TVExpandedNode(obj);
end;

procedure TExpandedNodesForWindow.SetExpandedNode(Index : Integer; Value : TVExpandedNode);
var
  oldNode : TVExpandedNode;
begin
  oldNode := Items[Index];
  FExpandedNodes[Index] := Value;
  if Assigned(FOnChange) then
    FOnChange(Value, oldNode, Index);
end;

function TExpandedNodesForWindow.GetCount : Integer;
begin
  Result := FExpandedNodes.Count;
end;

procedure TExpandedNodesForWindow.Delete(Index : Integer);
begin
  if Assigned(FOnDelete) then
    FOnDelete(Items[Index], Index);

  FExpandedNodes.Delete(Index);
end;

procedure TExpandedNodesForWindow.Clear;
begin
  FExpandedNodes.Clear;
end;

procedure TExpandedNodesForWindow.Insert(Index : Integer; Value : TVExpandedNode);
begin
  FExpandedNodes.Insert(Index, Value);
  if Assigned(FOnAdd)  then
    FOnAdd(Value, Index);
end;

procedure TExpandedNodesForWindow.Add(Value : TVExpandedNode);
begin
  FExpandedNodes.Add(Value);
  if Assigned(FOnAdd) then
    FOnAdd(Value, Count - 1);
end;

function  TExpandedNodesForWindow.IndexOf(Value : TVExpandedNode) : Integer;
begin
  Result := FExpandedNodes.IndexOf(Value);
end;

//-------------------------------TCollatedField---------------------------------

constructor TCollatedField.Create(AField : TField; ACollatedValue : Variant);
begin
  FField := AField;
  FCollatedValue := ACollatedValue;
end;

// ������� ���������� ��� ����
function TCollatedField.getNameOfField : String;
begin
  if Assigned(FField) then
    Result := FField.FieldName
  else
    Result := '';
end;

// ���������� ������� �������� ���� � ��������� Value
function TCollatedField.equals : boolean;
begin
  if Assigned(FField) then
  begin
    if not FField.DataSet.IsEmpty then
      Result := (FField.Value = FCollatedValue)
    else
      Result := (varEmpty = FCollatedValue);
  end
  else
    Result := false;
end;

//------------------------------TCollatedFields---------------------------------

// ��������� ����� ����� ���������
function TCollatedFields.getFieldCount : Integer;
begin
  Result := FCollatedFields.Count;
end;

// ���������� ���� ��������� � �������� Ind
function TCollatedFields.getField(Ind : Integer) : TCollatedField;
begin
  if (ind >= 0) and (FCollatedFields.count > Ind) then
    Result := TCollatedField(FCollatedFields[Ind])
  else
    Result := nil;
end;

// �����������
// AExNode      - ����������� ����
// Ind          - ������ ����� ������������ ���� � ������� � AExNode
// ACollFieldExNode - ���� true, �� �������� ��� ��������� ����� ������ �� ����� ����������� ����,
//                    ����� �� DataSet
constructor TCollatedFields.Create(AExNode : TVExpandedNode; Ind : Integer; ACollFieldExNode : boolean);
var
  Link : TLinkNode;

  DataSetOfExNode : TDataSet;
  DataSet : TDataSet;

  I : Integer;
begin
  // ������� ������ ����� ���������
  FCollatedFields := TList.Create;

  // ������ �� ������� ����� ����������� ���� � DataSet
  Link := AExNode.Links[Ind];

  // ������ DataSet ����������� ����
  DataSetOfExNode := AExNode.DSOfExpNode.DataSet;
  // ������ DataSet �����
  DataSet := Link.DataSource.DataSet;

  // ��������� ������ ����� ���������
  if ACollFieldExNode then
    // ��������� ������ ����� ���������
    // ��� ���� DataSet ����� �������� ������ �� ������� ����� ����� ������
    // � ���� DataSet ����������� ���� �������� �������� �� ������� ����� ���� �����
    for I := 0 to Link.CountKeyFields - 1 do
      if not DataSetOfExNode.IsEmpty then
        FCollatedFields.Add(TCollatedField.Create(DataSet.FieldByName(Link.DetailFields.FieldsName[I]),
                                                  DataSetOfExNode.FieldByName(Link.MasterFields.FieldsName[I]).Value))
      else
        FCollatedFields.Add(TCollatedField.Create(DataSet.FieldByName(Link.DetailFields.FieldsName[I]),
                                                  varEmpty))
  else
    // ��������� ������ ����� ���������
    // ��� ���� DataSet ����������� ���� �������� ������ �� ������� ����� ����� ������
    // � ���� DataSet ����� �������� �������� �� ������� ����� ���� �����
    for I := 0 to Link.CountKeyFields - 1 do
      if not DataSet.IsEmpty then
        FCollatedFields.Add(TCollatedField.Create(DataSetOfExNode.FieldByName(Link.MasterFields.FieldsName[I]),
                                                  DataSet.FieldByName(Link.DetailFields.FieldsName[I]).Value))
      else
        FCollatedFields.Add(TCollatedField.Create(DataSetOfExNode.FieldByName(Link.MasterFields.FieldsName[I]),
                                                  varEmpty));
end;

destructor TCollatedFields.Destroy;
var
  I : Integer;
begin
  inherited;

  // ������� ������
  for I := FCollatedFields.Count - 1 downto 0 do
    TCollatedField(FCollatedFields[I]).Destroy;

  // ���������� ������
  FCollatedFields.Destroy;
end;

// ���������� ������� �������� ����� � ���������� ��� ���������
function TCollatedFields.equals : boolean;
var
  I, n : Integer;
begin
  n := FCollatedFields.Count;

  result := true;
  I := 0;
  while (I < n) and Result do
  begin
    Result := TCollatedField(FCollatedFields[I]).equals;
    inc(I);
  end;
end;

// ���������� ����� �����, �� ������� ���� �����
// ������� ���������� �������� ����� � �������, ������� ���������
// ��� ������ TOracleDataSet.SearchRecord
function TCollatedFields.getFieldNames : string;
var
  I, n : Integer;
begin
  if (FCollatedFields.Count > 0) and (TCollatedField(FCollatedFields[0]).CollatedValue <> varEmpty) then
  begin
    n := FCollatedFields.Count;
    Result := '';
    for I := 0 to n - 2 do
      Result := Result + TCollatedField(FCollatedFields[I]).Name + ';';
    Result := Result + TCollatedField(FCollatedFields[n - 1]).Name;
  end
  else
    Result := '';
end;

// ���������� ��������, �� ������� ���� ����������� ������
// ������� ���������� �������� � �������, ������� ���������
// ��� ������ TOracleDataSet.SearchRecord
function TCollatedFields.getFieldValues : TArrayOfVariant;
var
  n : Integer;
function CreateArr : TArrayOfVariant;
var
  I : Integer;
begin
  SetLength(Result, n);
  for I := 0 to n - 1 do
    Result[I] := TCollatedField(FCollatedFields[I]).CollatedValue;
end;

begin
  if (FCollatedFields.Count > 0) and (TCollatedField(FCollatedFields[0]).CollatedValue <> varEmpty) then
  begin
    n := FCollatedFields.Count;

    if n > 1 then
    begin
      //Result := VarArrayCreate([0, n - 1], varVariant);
      //for I := 0 to n - 1 do
      //  Result[I] := TCollatedField(FCollatedFields[I]).CollatedValue;
      Result := CreateArr;
    end
    else if n = 1 then
    begin
      SetLength(Result, 1);
      Result[0] := TCollatedField(FCollatedFields[0]).CollatedValue
    end
    else
      SetLength(Result, 0);
     // Result := NULL;
  end
  else
    //Result := varEmpty;
    SetLength(Result, 0);
end;

//-------------------------------TRecordCollate---------------------------------

// ����������, ����� �� ��� ADataSet ������� ������ ��������� ������ � ������� ������
class function TRecordCollate.CanBuild(ADataSet : TOracleDataSet; AExNode : TVExpandedNode) : boolean;
var
  Details : TList;
  I, n : Integer;
begin
  Result := false;
  if ADataSet.Active then
  begin
    // ���� � ����������� ���� ������ �� ADataSet
    with AExNode.Links do
    begin
      I := 0;
      n := Count;
      while (I < n) and (not Result) do
      begin
        if (Items[I].DataSource.DataSet = ADataSet) and
           (Items[I].CountKeyFields > 0) then
          // ����� ����, ������m ����� �������� ������
          Result := true;

        Inc(I);
      end;
    end;

    if not Result then
    begin
      // ������� � ��������� ������ Detail-�� ��� ADataSet
      Details := TList.Create;
      ADataSet.GetDetailDataSets(Details);

      I := 0;
      n := Details.Count;
      while (I < n) and (not Result) do
      begin
        if CanBuild(TOracleDataSet(Details[I]), AExNode) then
          // ��� Detail-� ����� ������� ������ ���������,
          // �� ����� ��� ������� � ��� ADataSet
          Result := true;

        Inc(I);
      end;

      Details.Destroy;
    end;
  end
end;

// �����������
// ACollExNode - ���� true, �� �������� ��� ��������� ����� ������ �� ����������� ����,
//                ����� �� DataSet
// AFirstInd   - ��������� ������ ������ ������ � ������� ���������� ������ ����� ADataSet
// ACreatedDetail - ���� true, �� ��������� RecordCollate � ��� Detail-�� ADataSet
//                  ����� �� ���������
constructor TRecordCollate.Create(ADataSet : TOracleDataSet; AExNode : TVExpandedNode; ACollExNode : boolean; AFirstInd : Integer = 0; ACreatedDetail : boolean = true);
var
  Ind : Integer;
  I, J : Integer;
  Details : TList;
  created : boolean;
begin
  FCollFields := nil;
  if ACollExNode then
    FDataSet := ADataSet
  else
    FDataSet := TOracleDataSet(AExNode.DSOfExpNode.DataSet);
  FDetail := nil;

  // ���� ������ ����� ADataSet � ����������� ����
  Ind := -1;
  with AExNode.Links do
    for I := AFirstInd to Count - 1 do
      if Items[I].DataSource.DataSet = ADataSet then
      begin
        Ind := I;
        break;
      end;

  if Ind >= 0 then
    FCollFields := TCollatedFields.Create(AExNode, Ind, ACollExNode);

  if  ACreatedDetail then
  begin
    // ������� RecordCollate ��� Detail-�� ADataSet

    // ������� � ��������� ������ Detail-�� ��� ADataSet
    Details := TList.Create;
    ADataSet.GetDetailDataSets(Details);

    for I := 0 to Details.Count - 1 do
    begin
      if CanBuild(TOracleDataSet(Details[I]), AExNode) then
      begin
        // ��� Details[I] ����� ������� RecordCollate

        if not Assigned(FDetail) then
          FDetail := TList.Create;

        created := false;
        for J := 0 to AExNode.Links.Count - 1 do
        begin
          if AExNode.Links[J].DataSource.DataSet = Details[I] then
          begin
            FDetail.Add(TRecordCollate.Create(TOracleDataSet(Details[I]), AExNode, ACollExNode, J, not created));
            created := true;
          end;
        end;
        if not created then
          FDetail.Add(TRecordCollate.Create(TOracleDataSet(Details[I]), AExNode, ACollExNode));

      end;
    end;

    Details.Destroy;
  end;
end;

destructor TRecordCollate.Destroy;
var
  I : Integer;
begin
  inherited;

  if Assigned(FCollFields) then
    FCollFields.Destroy;

  if Assigned(FDetail) then
  begin
    for I := 0 to FDetail.Count - 1 do
      TRecordCollate(FDetail[I]).Destroy;

    FDetail.Destroy;
  end;
end;

// ���������� ����� ������� ������� ������ � ������� ��� Detail-�� DataSet-��
function TRecordCollate.GetDetailCount : Integer;
begin
  if Assigned(FDetail) then
    Result := FDetail.Count
  else
    Result := 0;
end;

// ���������� ����� ������� ������ � ������� ��� Detail-�� DataSet-��
function TRecordCollate.GetDetails(Ind : Integer) : TRecordCollate;
begin
  if Assigned(FDetail) and (Ind >= 0) and (Ind < FDetail.Count) then
    Result := TRecordCollate(FDetail[Ind])
  else
    Result := nil;
end;

// ���������� ������ ��������� ������ � ������� ��� Detail-�� � ������� ���������� Level
// � �������� Ind
function TRecordCollate.GetRecordCollate(Level : Integer; Ind : Integer) : TRecordCollate;
var
  I : Integer;
  DetailsNum : TArrayOfInteger;
  Arr : TArrayOfInteger;
begin
  Result := nil;
  SetLength(DetailsNum, 0);
  SetLength(Arr, 0);
  if Level > 1 then
  begin
    // ���������� � ���������� Details TRecordCollate � ������� ������� ���������� ������ ����

    if Ind >= 0 then
    begin
      // ��������� � ����� �� Details �������� ������ RecordCollate
      // � � ���� ������ �������  RecordCollate
      for I := 0 to DetailCount - 1 do
      begin
        Arr := Details[I].NumberOfDataSetAndDetail;
        DetailsNum := sumArrayOfInt(DetailsNum, Arr);
        if (Length(DetailsNum) >= Level) and (DetailsNum[Level - 1] > Ind) then
        begin
          Result := Details[I].RecordsCollates[Level - 1, Ind - (DetailsNum[Level - 1] - Arr[Level - 1])];
          break;
        end;
      end;
    end;
  end
  else if Level = 1 then
  begin
    if (Ind >= 0) and (DetailCount > Ind) then
      Result := Details[Ind];
  end
  else if (Level = 0) and (Ind = 0) then
    Result := Self;
end;

// ���������� ����� �����, �� ������� ���� �����
// ������� ���������� �������� ����� � �������, ������� ���������
// ��� ������ TOracleDataSet.SearchRecord
function TRecordCollate.getFieldNames : string;
begin
  if Assigned(FCollFields) then
    Result := FCollFields.getFieldNames
  else
    Result := '';
end;

// ���������� ��������, �� ������� ���� ����������� ������
// ������� ���������� �������� � �������, ������� ���������
// ��� ������ TOracleDataSet.SearchRecord
function TRecordCollate.getFieldValues : TArrayOfVariant;
begin
  if Assigned(FCollFields) then
    Result := FCollFields.getFieldValues
  else
    SetLength(Result, 0);
    //Result := varEmpty;
end;

// ���������� ��� �������
class function TRecordCollate.sumArrayOfInt(Arr1 : TArrayOfInteger; Arr2 : TArrayOfInteger) : TArrayOfInteger;
var
  l1, l2 : Integer;
  min, max : Integer;
  I : Integer;
begin
  l1 := Length(Arr1);
  l2 := Length(Arr2);

  // ���������� ����� ������������� �������
  if l1 > l2 then
  begin
    max := l1;
    min := l2;
  end
  else
  begin
    max := l2;
    min := l1;
  end;
  SetLength(Result, max);

  // ���������� ��� �������
  for I := 0 to min - 1 do
    Result[I] := Arr1[I] + Arr2[I];
  if l1 > l2 then
    for I := min to max - 1 do
      Result[I] := Arr1[I]
  else
    for I := min to max - 1 do
      Result[I] := Arr2[I];
end;

// ���������� ������, ��� � ������ ������� �������� ��������-�������, ��� ������� ������
// DataSet �������� ������� (1 - �������� �������; 0 - �� �������� �������);
// � ������ �������� �������� ���������� Detail-�� � DataSet-�, � ������� ������� ������
// �������� ������� ������
// � ������ �������� �������� ���������� Detail-�� � Detail-�� DataSet, � ������� ������� ������
// �������� ������� ������
// ���
// ������ ������� ���������� ����� ������� ���������� Detail-�� � DataSet + ���� (������� ���. ���.
// �������)
function TRecordCollate.findedRecords : TArrayOfInteger;
var
  I : Integer;
  Arr1, Arr2 : TArrayOfInteger;
begin
  SetLength(Arr1, 0);
  SetLength(Arr2, 0);

  // ��������� ���������� Detail-�� � ������� ������� ������ ��������� � ������� �������
  for I := 0 to DetailCount - 1 do
  begin
    Arr2 := Details[I].findedRecords;

    Arr1 := sumArrayOfInt(Arr1, Arr2);
  end;

  // ��������� ������������ ������

  // ��������� ������ ������� ������������� �������
  // ������ ������� ������� ��������� ������� ������
  SetLength(Result, Length(Arr1) + 1);
  if Assigned(FCollFields) then
  begin
    if FCollFields.equals then
      Result[0] := 1
    else
      Result[0] := 0;
  end
  else
    Result[0] := 1;

  // ��������� ���������� �������� �������
  for I := 1 to Length(Result) - 1 do
    Result[I] := Arr1[I -1];
end;

// ���������� ������, ��� � ������ �������� �������� 1;
// � ������ �������� �������� ���������� Detail-�� � DataSet-�;
// � ������ �������� �������� ���������� Detail-�� � Detail-�� DataSet;
// ���
// ������ ������� ��������� ����� ������� ���������� Detail-�� � DataSet + ���� (DataSet)
function TRecordCollate.NumberOfDataSetAndDetail : TArrayOfInteger;
var
  I : Integer;
  Arr1, Arr2 : TArrayOfInteger;
begin
  SetLength(Arr1, 0);
  SetLength(Arr2, 0);

  // ��������� ���������� Detail-��
  for I := 0 to DetailCount - 1 do
  begin
    Arr2 := Details[I].NumberOfDataSetAndDetail;

    Arr1 := sumArrayOfInt(Arr1, Arr2);
  end;

  // ��������� ������������ ������

  // ��������� ������ ������� ������������� �������
  SetLength(Result, Length(Arr1) + 1);
  Result[0] := 1;

  // ��������� ���������� �������� �������
  for I := 1 to Length(Result) - 1 do
    Result[I] := Arr1[I -1];
end;

// ���������� ��� �������
class function TRecordCollate.CompareArrs(Arr1 : TArrayOfInteger; Arr2 : TArrayOfInteger) : Integer;
var
  l1, l2, len : Integer;
  I : Integer;
begin
  l1 := Length(Arr1);
  l2 := Length(Arr2);

  if l1 > l2 then
    len := l1
  else
    len := l2;

  for I := 0 to len - 1 do
    if Arr1[I] <> Arr2[I] then
    begin
      if Arr1[I] > Arr2[I] then
        Result := 1
      else
        Result := -1;
      exit;
    end;

  if l1 <> l2 then
  begin
    if l1 > l2 then
      Result := 1
    else
      Result := -1;
  end
  else
    Result := 0;
end;

// ���������� ������� �� ������ ��� ������ ������ ����  ���� �� ������� �� Details-�,
// ���� �� ���� ���, �� ���������� �������� False, ����� True
function TRecordCollate.HasSearchData : boolean;
begin
  if HasSearchSelfData or (DetailCount > 0) then
    Result := true
  else
    Result := false;
end;

// ���������� ������� �� ������ ��� ������ ������
function TRecordCollate.HasSearchSelfData : boolean;
begin
  Result := Assigned(FCollFields);
end;

procedure TRecordCollate.Pack;
var
  I : Integer;
begin
  for I := DetailCount - 1 downto 0 do
  begin
    Details[I].Pack;
    if not Details[I].HasSearchData then
    begin
      TRecordCollate(FDetail[I]).Destroy;
      FDetail.Delete(I);
    end;
  end;
end;

// ���������� �������� �� ADataSet SynchrDataSet-�� ��� � Detail-�� SynchrDataSet-��
function TRecordCollate.HasSynchrDataSet(ADataSet : TOracleDataSet) : boolean;
var
  I : Integer;
  n : Integer;
begin
  Result := (SynchrDataSet = ADataSet);
  I := 0;
  n := DetailCount;
  while (I < n) and (not Result) do
  begin
    Result := Details[I].HasSynchrDataSet(ADataSet);
    Inc(I);
  end;
end;

//-------------------------------TSynchrRecords---------------------------------

function TSynchrRecords.buildRecordCollate(APrototype : TOracleDataSet; ASynchr : TVExpandedNode; AFirstInd : Integer = 0) : TRecordCollate;
begin
  Result := TRecordCollate.Create(APrototype, ASynchr, false, AFirstInd);
end;

function TSynchrRecords.buildRecordCollate(APrototype : TVExpandedNode;  ASynchr : TOracleDataSet; AFirstInd : Integer = 0) : TRecordCollate;
begin
  Result := TRecordCollate.Create(ASynchr, APrototype, true, AFirstInd);
end;

constructor TSynchrRecords.Create(AOwner : TfmExpandedTreeTopology; APrototype : TVExpandedNode; ASynchr : TVExpandedNode; AExNodeList : TExpandedNodes);
var
  List : TExpandedNodes;
  I, J : Integer;
  len : Integer;
  old_len : Integer;
  finded : boolean;
begin
  // ������� ������ ����������� �����
  List := TExpandedNodesForWindow.Create;
  // ��������� ������
  // � ������ ���������� ��� ����������� ���� ����� APrototype � ASynchr
  for I := 0 to AExNodeList.Count - 1 do
    if (AExNodeList[I] <> APrototype) and (AExNodeList[I] <> ASynchr) and
       (not AOwner.NeedToSaveDataOfSheetOfExNode(AExNodeList[I])) then
      List.Add(AExNodeList[I]);

  FDataSet := TOracleDataSet(ASynchr.DSOfExpNode.DataSet);

  // ��������� ������ �������� ��������� ������ � ������� ������ DataSet-�� � APrototype (FMainRecordCollate)
  len := 0;
  SetLength(FMainRecordCollate, len);
  for I := 0 to APrototype.Links.Count - 1 do
  begin
    // ���� �����
    if APrototype.Links[I].DataSource.DataSet = ASynchr.DSOfExpNode.DataSet then
    begin
      inc(len);
      SetLength(FMainRecordCollate, len);
      // ������� ������ ���������
      FMainRecordCollate[len - 1] := buildRecordCollate(APrototype, TOracleDataSet(ASynchr.DSOfExpNode.DataSet), I);
    end;
  end;
  if (len = 0) and TRecordCollate.CanBuild(TOracleDataSet(ASynchr.DSOfExpNode.DataSet), APrototype) then
  begin
    inc(len);
    SetLength(FMainRecordCollate, len);
    // ������� ������ ���������
    FMainRecordCollate[len - 1] := buildRecordCollate(APrototype, TOracleDataSet(ASynchr.DSOfExpNode.DataSet));
  end;
  old_len := len;
  for I := 0 to ASynchr.Links.Count - 1 do
  begin
    // ���� �����
    if ASynchr.Links[I].DataSource.DataSet = APrototype.DSOfExpNode.DataSet then
    begin
      inc(len);
      SetLength(FMainRecordCollate, len);
      // ������� ������ ���������
      FMainRecordCollate[len - 1] := buildRecordCollate(TOracleDataSet(APrototype.DSOfExpNode.DataSet), ASynchr,  I);
    end;
  end;
  if (len = old_len) then
  begin             // ������ ���� ���� �� ���� ������� � ������� FMainRecordCollate!!!
                    // ����� ��������� ����� �� ��������� ��������
    inc(len);
    SetLength(FMainRecordCollate, len);
    // ������� ������ ���������
    FMainRecordCollate[len - 1] := buildRecordCollate(TOracleDataSet(APrototype.DSOfExpNode.DataSet), ASynchr);
  end;

  // ��������� ������ FOtherRecordCollate
  len := 0;
  SetLength(FOtherRecordCollate, len);
  for J := 0 to List.Count - 1 do
  begin
    finded := false;
    for I := 0 to List[J].Links.Count - 1 do
    begin
      // ���� �����
      if List[J].Links[I].DataSource.DataSet = ASynchr.DSOfExpNode.DataSet then
      begin
        inc(len);
        SetLength(FOtherRecordCollate, len);
        // ������� ������ ���������
        FOtherRecordCollate[len - 1] := buildRecordCollate(List[J], TOracleDataSet(ASynchr.DSOfExpNode.DataSet), I);
        finded := true;
      end;
    end;
    if (not finded) and (TRecordCollate.CanBuild(TOracleDataSet(ASynchr.DSOfExpNode.DataSet), List[J])) then
    begin
      inc(len);
      SetLength(FOtherRecordCollate, len);
      // ������� ������ ���������
      FOtherRecordCollate[len - 1] := buildRecordCollate(List[J], TOracleDataSet(ASynchr.DSOfExpNode.DataSet));
    end;

    finded := false;
    for I := 0 to ASynchr.Links.Count - 1 do
    begin
      // ���� �����
      if ASynchr.Links[I].DataSource.DataSet = List[J].DSOfExpNode.DataSet then
      begin
        inc(len);
        SetLength(FOtherRecordCollate, len);
        // ������� ������ ���������
        FOtherRecordCollate[len - 1] := buildRecordCollate(TOracleDataSet(List[J].DSOfExpNode.DataSet), ASynchr,  I);
        finded := true;
      end;
    end;
    if (not finded) and (TRecordCollate.CanBuild(TOracleDataSet(List[J].DSOfExpNode.DataSet), ASynchr)) then
    begin
      inc(len);
      SetLength(FOtherRecordCollate, len);
      // ������� ������ ���������
      FOtherRecordCollate[len - 1] := buildRecordCollate(TOracleDataSet(List[J].DSOfExpNode.DataSet), ASynchr);
    end;
  end;

  List.Destroy;

  Pack_;
end;

constructor TSynchrRecords.Create(AOwner : TfmExpandedTreeTopology; APrototype : TOracleDataSet; ASynchr : TVExpandedNode; AExNodeList : TExpandedNodes);
var
  List : TExpandedNodes;
  I, J : Integer;
  len : Integer;
  finded : boolean;
begin
  // ������� ������ ����������� �����
  List := TExpandedNodesForWindow.Create;
  // ��������� ������
  // � ������ ���������� ��� ����������� ���� ����� APrototype � ASynchr
  for I := 0 to AExNodeList.Count - 1 do
    if (AExNodeList[I] <> ASynchr) and
       (not AOwner.NeedToSaveDataOfSheetOfExNode(AExNodeList[I])) then
      List.Add(AExNodeList[I]);

  FDataSet := TOracleDataSet(ASynchr.DSOfExpNode.DataSet);

  // ��������� ������ �������� ��������� ������ � ������� ������ DataSet-�� � APrototype (FMainRecordCollate)
  len := 0;
  SetLength(FMainRecordCollate, len);
  for I := 0 to ASynchr.Links.Count - 1 do
  begin
    // ���� �����
    if ASynchr.Links[I].DataSource.DataSet = APrototype then
    begin
      inc(len);
      SetLength(FMainRecordCollate, len);
      // ������� ������ ���������
      FMainRecordCollate[len - 1] := buildRecordCollate(APrototype, ASynchr,  I);
    end;
  end;
  if len = 0 then
  begin
    SetLength(FMainRecordCollate, 1);
    // ������� ������ ���������
    FMainRecordCollate[0] := buildRecordCollate(APrototype, ASynchr);
  end;

  // ��������� ������ FOtherRecordCollate
  len := 0;
  SetLength(FOtherRecordCollate, len);
  for J := 0 to List.Count - 1 do
  begin
    finded := false;
    for I := 0 to List[J].Links.Count - 1 do
    begin
      // ���� �����
      if List[J].Links[I].DataSource.DataSet = ASynchr.DSOfExpNode.DataSet then
      begin
        inc(len);
        SetLength(FOtherRecordCollate, len);
        // ������� ������ ���������
        FOtherRecordCollate[len - 1] := buildRecordCollate(List[J], TOracleDataSet(ASynchr.DSOfExpNode.DataSet), I);
        finded := true;
      end;
    end;
    if (not finded) and (TRecordCollate.CanBuild(TOracleDataSet(ASynchr.DSOfExpNode.DataSet), List[J])) then
    begin
      inc(len);
      SetLength(FOtherRecordCollate, len);
      // ������� ������ ���������
      FOtherRecordCollate[len - 1] := buildRecordCollate(List[J], TOracleDataSet(ASynchr.DSOfExpNode.DataSet));
    end;

    finded := false;
    for I := 0 to ASynchr.Links.Count - 1 do
    begin
      // ���� �����
      if ASynchr.Links[I].DataSource.DataSet = List[J].DSOfExpNode.DataSet then
      begin
        inc(len);
        SetLength(FOtherRecordCollate, len);
        // ������� ������ ���������
        FOtherRecordCollate[len - 1] := buildRecordCollate(TOracleDataSet(List[J].DSOfExpNode.DataSet), ASynchr,  I);
        finded := true;
      end;
    end;
    if (not finded) and (TRecordCollate.CanBuild(TOracleDataSet(List[J].DSOfExpNode.DataSet), ASynchr)) then
    begin
      inc(len);
      SetLength(FOtherRecordCollate, len);
      // ������� ������ ���������
      FOtherRecordCollate[len - 1] := buildRecordCollate(TOracleDataSet(List[J].DSOfExpNode.DataSet), ASynchr);
    end;
  end;

  List.Destroy;

  Pack_;
end;

constructor TSynchrRecords.Create(AOwner : TfmExpandedTreeTopology; APrototype : TVExpandedNode; ASynchr : TOracleDataSet; AExNodeList : TExpandedNodes);
var
  List : TExpandedNodes;
  I, J : Integer;
  len : Integer;
  finded : boolean;
begin
  // ������� ������ ����������� �����
  List := TExpandedNodesForWindow.Create;
  // ��������� ������
  // � ������ ���������� ��� ����������� ���� ����� APrototype � ASynchr
  for I := 0 to AExNodeList.Count - 1 do
    if (AExNodeList[I] <> APrototype) and
       (not AOwner.NeedToSaveDataOfSheetOfExNode(AExNodeList[I])) then
      List.Add(AExNodeList[I]);

  FDataSet := ASynchr;

  // ��������� ������ �������� ��������� ������ � ������� ������ DataSet-�� � APrototype (FMainRecordCollate)
  len := 0;
  SetLength(FMainRecordCollate, len);
  for I := 0 to APrototype.Links.Count - 1 do
  begin
    // ���� �����
    if APrototype.Links[I].DataSource.DataSet = ASynchr then
    begin
      inc(len);
      SetLength(FMainRecordCollate, len);
      // ������� ������ ���������
      FMainRecordCollate[len - 1] := buildRecordCollate(APrototype, ASynchr, I);
    end;
  end;
  if len = 0 then
  begin
    SetLength(FMainRecordCollate, 1);
    // ������� ������ ���������
    FMainRecordCollate[0] := buildRecordCollate(APrototype, ASynchr);
  end;

  // ��������� ������ FOtherRecordCollate
  len := 0;
  SetLength(FOtherRecordCollate, len);
  for J := 0 to List.Count - 1 do
  begin
    finded := false;
    for I := 0 to List[J].Links.Count - 1 do
    begin
      // ���� �����
      if List[J].Links[I].DataSource.DataSet = ASynchr then
      begin
        inc(len);
        SetLength(FOtherRecordCollate, len);
        // ������� ������ ���������
        FOtherRecordCollate[len - 1] := buildRecordCollate(List[J], ASynchr, I);
        finded := true;
      end;
    end;
    if (not finded) and (TRecordCollate.CanBuild(ASynchr, List[J])) then
    begin
      inc(len);
      SetLength(FOtherRecordCollate, len);
      // ������� ������ ���������
      FOtherRecordCollate[len - 1] := buildRecordCollate(List[J], ASynchr);
    end;
  end;
  List.Destroy;


  SetLength(FFindedMainRecords, 0);
  SetLength(FFindedOtherRecords, 0);
  FEmptySearchDataSet := nil;
  FSearchDataSet := nil;
  FFindRecordCollate := nil;
  SetLength(FFindDataSetNow, 0);
  SetLength(FCanFindDataSet, 0);

  Pack_;
end;

destructor TSynchrRecords.Destroy;
var
  I : Integer;
begin
  for I := 0 to Length(FMainRecordCollate) - 1 do
    FMainRecordCollate[I].Destroy;

  for I := 0 to Length(FOtherRecordCollate) - 1 do
    FOtherRecordCollate[I].Destroy;
end;



// ���o������ ������� ��������� �������� � DataSet-��
procedure TSynchrRecords.savePosition(ASynchrData : PDataSetWithDetailsForSynch);
var
  I : Integer;
begin
  if ASynchrData^.DataSet.IsEmpty then
     ASynchrData^.position := -1
  else
  begin
    ASynchrData^.position := ASynchrData^.DataSet.RecNo;

    for I := 0 to ASynchrData^.Details.Count - 1 do
      savePosition(PDataSetWithDetailsForSynch(ASynchrData^.Details[I]));
  end;
end;

// ������������� ������� �������� � DataSet-��, �� �������, ������� ���� ��������� ���������� savePosition
procedure TSynchrRecords.SetPosition(ASynchrData : TDataSetWithDetailsForSynch);
var
  I : Integer;
begin
  if ASynchrData.position >= 0 then
  begin
    ASynchrData.DataSet.RecNo := ASynchrData.position;
    ASynchrData.DataSet.UpdateCursorPos;
    for I := 0 to ASynchrData.Details.Count - 1 do
      SetPosition(TDataSetWithDetailsForSynch(ASynchrData.Details[I]^));
  end;
end;

// ��������� ������ ��������, ������� ������ �������� ��� ���������� ������� ���������,
// ���� � ���� DataSet-�� ������� ������ ������� ���������� � ������� �������
function TSynchrRecords.indiciumSearch(AReordsCollate : TArrayOfRecordCollate) : TArrayOfInteger;
var
  I : Integer;
  Arr : TArrayOfInteger;
begin
  SetLength(Result, 0);
  SetLength(Arr, 0);
  for I := 0 to Length(AReordsCollate) - 1 do
  begin
    if I > 0 then
    begin
      Arr := AReordsCollate[I].NumberOfDataSetAndDetail;
      Result := TRecordCollate.sumArrayOfInt(Result, Arr);
    end
    else
      Result := AReordsCollate[I].NumberOfDataSetAndDetail;
  end;
end;

// ��������� ������ ���������� ��������� �������
function TSynchrRecords.findedRecords(AReordsCollate : TArrayOfRecordCollate) : TArrayOfInteger;
var
  I : Integer;
  Arr : TArrayOfInteger;
begin
  SetLength(Result, 0);
  SetLength(Arr, 0);
  for I := 0 to Length(AReordsCollate) - 1 do
  begin
    if I > 0 then
    begin
      Arr := AReordsCollate[I].findedRecords;
      Result := TRecordCollate.sumArrayOfInt(Result, Arr);
    end
    else
      Result := AReordsCollate[I].findedRecords;
  end;
end;

procedure TSynchrRecords.synchr;
var
  SynchrData : TDataSetWithDetailsForSynch;
  MainSearch : TArrayOfInteger;
  OtherSearch : TArrayOfInteger;

  I : Integer;
  l, l1, l2 : Integer;
  //FindedMainRecords : TArrayOfInteger;
  //FindedOtherRecords : TArrayOfInteger;
begin
  // ��������� ������ ��� �������������
  if Length(FMainRecordCollate) = 0 then
  begin
    if Length(FOtherRecordCollate) > 0 then
      SynchrData := CreateDataSetRecordForSynch(FOtherRecordCollate[0].SynchrDataSet)
    else
      Exit;
  end
  else
    SynchrData := CreateDataSetRecordForSynch(FMainRecordCollate[0].SynchrDataSet);


  try
    // ���������� ������� ������� ��������
    savePosition(@SynchrData);

    // ������, ��� �� �� ���� ������� � DataSet �� ������������ �� ��������
    DisableControls(SynchrData);

    // ��������� ������ ��������, ������� ������ �������� ��� ���������� ������� ���������,
    // ���� � ���� DataSet-�� ������� ������ ������� ���������� � ������� �������
    MainSearch := indiciumSearch(FMainRecordCollate);
    OtherSearch := indiciumSearch(FOtherRecordCollate);

    // ��������� ���������� DataSet, � ������� ���� �������� ������� ������
    FFindedMainRecords := findedRecords(FMainRecordCollate);
    FFindedOtherRecords:= findedRecords(FOtherRecordCollate);

    if (TRecordCollate.CompareArrs(FFindedMainRecords,  MainSearch) < 0) or
       (TRecordCollate.CompareArrs(FFindedOtherRecords, OtherSearch) < 0) then
    begin
      // �������������� ������
      // �������� ������ ��� ������� fullFindRecord � currFindRecord
      FEmptySearchDataSet := TList.Create; //[i]TStrings;
      // ������ DataSet �� ������� ��� ���� ����� � RecordCollate �������� ������ ��� ������
      FSearchDataSet := TList.Create;//[i]TList;
      // ������ �� ������� � �� DataSet-��, � �� ������� ��� ������ ������ RecordCollate
      FFindRecordCollate := TList.Create;//[i]TList;


      l1 := Length(FFindedMainRecords);
      l2 := Length(FFindedOtherRecords);
      if l1 < l2 then
        l := l2
      else
        l := l1;

      SetLength(FFindDataSetNow, l);
      SetLength(FCanFindDataSet, l);

      if not currFindRecord(0, MainSearch, OtherSearch, @SynchrData) then
        // ������������� ������� ������� �� �������� ���������� ������� �������
        SetPosition(SynchrData);


      for I := 0 to FEmptySearchDataSet.Count -  1 do
        TStrings(FEmptySearchDataSet[I]).Destroy;
      FEmptySearchDataSet.Destroy;
      for I := 0 to FSearchDataSet.Count -  1 do
        TList(FSearchDataSet[I]).Destroy;
      FSearchDataSet.Destroy;
      for I := 0 to FFindRecordCollate.Count -  1 do
        TList(FFindRecordCollate[I]).Destroy;
      FFindRecordCollate.Destroy;
    end;

    // ������, ��� ��������� ������ � DataSet ������������ �� ��������
    EnableControls(SynchrData);
  finally
    // ���������� ������ ����������
    destroyDataSetWithDetailsForSynch(@SynchrData);
  end;
end;

// ���������� ������ ��������� ������ � ������� ��� Detail-�� � ������� ���������� Level
// � �������� Ind
function TSynchrRecords.GetMainRecordCollate(Level : Integer; Ind : Integer) : TRecordCollate;
var
  I : Integer;
  DetailsNum : TArrayOfInteger;
  Arr : TArrayOfInteger;
begin
  Result := nil;
  SetLength(DetailsNum, 0);
  SetLength(Arr, 0);
  if Level > 0 then
  begin
    // ���������� � ���������� TRecordCollate � ������� ������� ���������� ������ ����

    if Ind >= 0 then
    begin
      // ��������� � ����� �� �������� FMainRecordCollate �������� ������ RecordCollate
      // � � ���� ������ �������  RecordCollate
      for I := 0 to Length(FMainRecordCollate) - 1 do
      begin
        Arr := FMainRecordCollate[I].NumberOfDataSetAndDetail;
        DetailsNum := TRecordCollate.sumArrayOfInt(DetailsNum, Arr);
        if (Length(DetailsNum) > Level) and (DetailsNum[Level] > Ind) then
        begin
          Result := FMainRecordCollate[I].RecordsCollates[Level, Ind - (DetailsNum[Level] - Arr[Level])];
          break;
        end;
      end;
    end;
  end
  else if Level = 0 then
  begin
    if (Ind >= 0) and (Length(FMainRecordCollate) > Ind) then
      Result := FMainRecordCollate[Ind];
  end;
end;

// ���������� ������ ��������� ������ � ������� ��� Detail-�� � ������� ���������� Level
// � �������� Ind
function TSynchrRecords.GetOtherRecordCollate(Level : Integer; Ind : Integer) : TRecordCollate;
var
  I : Integer;
  DetailsNum : TArrayOfInteger;
  Arr : TArrayOfInteger;
begin
  Result := nil;
  SetLength(DetailsNum, 0);
  SetLength(Arr, 0);
  if Level > 0 then
  begin
    // ���������� � ���������� TRecordCollate � ������� ������� ���������� ������ ����

    if Ind >= 0 then
    begin
      // ��������� � ����� �� �������� FOtherRecordCollate �������� ������ RecordCollate
      // � � ���� ������ �������  RecordCollate
      for I := 0 to Length(FOtherRecordCollate) - 1 do
      begin
        Arr := FOtherRecordCollate[I].NumberOfDataSetAndDetail;
        DetailsNum := TRecordCollate.sumArrayOfInt(DetailsNum, Arr);
        if (Length(DetailsNum) > Level) and (DetailsNum[Level] > Ind) then
        begin
          Result := FOtherRecordCollate[I].RecordsCollates[Level, Ind - (DetailsNum[Level] - Arr[Level])];
          break;
        end;
      end;
    end;
  end
  else if Level = 0 then
  begin
    if (Ind >= 0) and (Length(FOtherRecordCollate) > Ind) then
      Result := FOtherRecordCollate[Ind];
  end;
end;

procedure TSynchrRecords.Pack_;
var
  I, J : Integer;
begin
  for I := Length(FMainRecordCollate) - 1 downto 0 do
  begin
    FMainRecordCollate[I].Pack;
    //if Length(FMainRecordCollate) > 1 then // ������ ���� ���� �� � ������� FMainRecordCollate ���� ������� !!!
                                           // ��� ����� �����!!!
      if not FMainRecordCollate[I].HasSearchData then
      begin
        FMainRecordCollate[I].Destroy;
        for J := I to Length(FMainRecordCollate) - 2 do
          FMainRecordCollate[J] := FMainRecordCollate[J + 1];
        SetLength(FMainRecordCollate, Length(FMainRecordCollate) - 1);
      end;
  end;

  for I := Length(FOtherRecordCollate) - 1 downto 0 do
  begin
    FOtherRecordCollate[I].Pack;
    if not FOtherRecordCollate[I].HasSearchData then
    begin
      FOtherRecordCollate[I].Destroy;
      for J := I to Length(FOtherRecordCollate) - 2 do
        FOtherRecordCollate[J] := FOtherRecordCollate[J + 1];
      SetLength(FOtherRecordCollate, Length(FOtherRecordCollate) - 1);
    end;
  end;
end;

// ������ ����� ������
// ALevel - �������  ����������, Detail-�� � ������� ����� ����� ������
// FEmptySearchDataSet - ������ DataSet-��, � ������� �� ����� ������� ������� �� ���� ������ �� ������ ������
//                       � �������� Objects ����� ��������� ������ ���� Boolean,
//                       ���� ����� �������� true, �� ���������� ������,
//                       ��� ����� ����������� ����� ������ DataSet �� ����� ������� ������,
//                       ������� �� ��������� ������, ���� false �� ������ �� ������
// FSearchDataSet      - ������ DataSet-��, � ������� �� ����� ������� ������ ���� ������ �� ������
// AMainSearch         - ������ ���������� Detail-�� �� ������ ������ ���������� ��������� ������
// FFindedMainRecords  - ������� � �������� ��������, � ������� ����������� � ������������
//                       ���������� ���������� Detail-�� �� ������ ������ ����������,
//                       ��� ���� ������� ������ ��������� ������
// AOtherSearch        - ������ ���������� Detail-�� �� ������ ������ ���������� ����������� ������
// FFindedOtherRecords - ������� � �������� ��������, � ������� ����������� � ������������
//                       ���������� ���������� Detail-�� �� ������ ������ ����������,
//                       ��� ���� ������� ������ ����������� ������
// ASynchrData         - ������ �������� ������� �������� � Dataset-�� �������� ����������
// ���������� true, ���� ������� ������ ���� �������, ����� false
function TSynchrRecords.fullFindRecord(ALevel : Integer;
                                       AMainSearch : TArrayOfInteger; AOtherSearch : TArrayOfInteger;
                                       ASynchrData : PDataSetWithDetailsForSynch) : boolean;
function equals_ : boolean;
var
  FMainFinded  : TArrayOfInteger;
  FOtherFinded : TArrayOfInteger;

  cmp : Integer;
begin
  Result := false;
  // ����������, ���������� DataSet-�� �� ������� �����������, � ������� ���� ������� ������� ������
  FMainFinded  := findedRecords(FMainRecordCollate);
  FOtherFinded := findedRecords(FOtherRecordCollate);

  cmp := TRecordCollate.CompareArrs(FMainFinded, FFindedMainRecords);
  if cmp >= 0 then
  begin
    // ������� �� ������ ALevel ������� ������� �� ������, ��� � ������ ��������


    if (cmp > 0) or ((cmp = 0) and (TRecordCollate.CompareArrs(FOtherFinded, FFindedOtherRecords) > 0))  then
    begin
      // ������� �� ������ ALevel ������� ������� ������, ��� � ������ �������

      // ��������� ���������� �������� �������
      FFindedMainRecords  := FMainFinded;
      FFindedOtherRecords := FOtherFinded;

      // ��������� ������� ��������
      savePosition(ASynchrData);

      if (TRecordCollate.CompareArrs(FFindedMainRecords,  AMainSearch) = 0) and
         (TRecordCollate.CompareArrs(FFindedOtherRecords, AOtherSearch) = 0) then
        // ������� ������ �����
        Result := true;
    end;

    if not Result then
      Result := fullFindRecord(ALevel + 1, AMainSearch, AOtherSearch, ASynchrData);
  end

end;

begin
  if Length(FFindDataSetNow) > ALevel then
  begin

    if FEmptySearchDataSet.Count = ALevel then
    begin
      // ������ ������ ����������� ALevel �� ��������������

      // �������������� ������ ������ ����������� ALevel
      InitLevel(ALevel, AMainSearch, AOtherSearch);
    end;

    Result := false;

    while (not Result) and (find_(ALevel, ASynchrData)) do
    begin
      // ����� ��� �������

      //if Length(FFindedMainRecords) > ALevel then
      //begin
        Result := equals_;

        while (not Result) and (findEmpty_(ALevel, ASynchrData)) do
        begin
          // ����� ��� �������

          Result := equals_;
        end;
      //end;
    end;

    while (not Result) and (findEmpty_(ALevel, ASynchrData)) do
    begin
      // ����� ��� �������

      Result := equals_;
    end;

    // ���������� ��������, ����� �� ���� ���������� ��� ������ ����� �������
    // fullFindRecord � currFindRecord
    // ��� ����� ����� ��� ������ find_
    SetLength(FFindDataSetNow[ALevel], 0); //!!!
    SetLength(FCanFindDataSet[ALevel], 0); //!!!
  end
  else
    Result := false;
end;

// ����� �� ������� ������
function TSynchrRecords.currFindRecord(ALevel : Integer;
                                       AMainSearch : TArrayOfInteger; AOtherSearch : TArrayOfInteger;
                                       ASynchrData : PDataSetWithDetailsForSynch) : boolean;
begin
  if Length(AMainSearch) > ALevel then
  begin

    Result := false;

    if FEmptySearchDataSet.Count = ALevel then
    begin
      // ������ ������ ����������� ALevel �� ��������������

      // �������������� ������ ������ ����������� ALevel
      InitLevel(ALevel, AMainSearch, AOtherSearch);
    end;

    if FFindedMainRecords[ALevel] = AMainSearch[ALevel] then
      // �� ������ ALevel �������� ������������ ���������� ������� DataSet-�� ��������� ������
      // ���� ������
      Result := currFindRecord(ALevel + 1, AMainSearch, AOtherSearch, ASynchrData);

    if not Result then
      Result := fullFindRecord(ALevel, AMainSearch, AOtherSearch, ASynchrData);
  end
  else
    Result := fullFindRecord(ALevel, AMainSearch, AOtherSearch, ASynchrData);
end;

procedure TSynchrRecords.InitLevel(ALevel : Integer;
                                   AMainSearch : TArrayOfInteger; AOtherSearch : TArrayOfInteger);
var
  EmptyDataSet : TStrings;
  SearchDataSet : TList;
  FindRecordCollate : TList;

  RecordCollates : TStrings;
  I, J : Integer;
  rc : TRecordCollate;
  container : TList;
  Ind : Integer;
  busy : boolean;
begin
  // ��������� ������ RecordCollate �� DataSet-��
  RecordCollates := TStringList.Create;
  if  Length(AMainSearch) > ALevel then
  begin

    for I := 0 to AMainSearch[ALevel] - 1 do
    begin
      rc := GetMainRecordCollate(ALevel, I);
      busy := false;
      j := 0;
      while (j < ALevel) and (not busy) do
      begin
        if TList(FSearchDataSet[j]).IndexOf(rc.SynchrDataSet) >= 0 then
          busy := true;
        inc(j);
      end;
      if not busy then
      begin
        Ind := RecordCollates.IndexOf(ObjToStr(rc.SynchrDataSet));
        if Ind < 0 then
        begin
          container := TList.Create;
          RecordCollates.AddObject(ObjToStr(rc.SynchrDataSet), container);
        end
        else
          container := TList(RecordCollates.Objects[Ind]);
        // RecordCollate ��� ���������� ������ � ������ �� ��������
        if rc.HasSearchSelfData then
          container.Add(rc);
      end;
    end;
  end;

  if  Length(AOtherSearch) > ALevel then
  begin
    for I := 0 to AOtherSearch[ALevel] - 1 do
    begin
      rc := GetOtherRecordCollate(ALevel, I);
      if not HasSynchrDataSet(rc.SynchrDataSet) then
      begin
        Ind := RecordCollates.IndexOf(ObjToStr(rc.SynchrDataSet));
        if Ind < 0 then
        begin
          container := TList.Create;
          RecordCollates.AddObject(ObjToStr(rc.SynchrDataSet), container);
        end
        else
          container := TList(RecordCollates.Objects[Ind]);
        // RecordCollate ��� ���������� ������ � ������ �� ��������
        if rc.HasSearchSelfData then
          container.Add(rc);
      end;
    end;
  end;

  // �� ��������� ������ RecordCollates ��������� �������: EmptyDataSet, SearchDataSet � FindRecordCollate
  EmptyDataSet := TStringList.Create;
  SearchDataSet := TList.Create;
  FindRecordCollate := TList.Create;
  for I := 0 to RecordCollates.Count - 1 do
  begin
    container := TList(RecordCollates.Objects[I]);
    if container.Count > 0 then
    begin
      SearchDataSet.Add(TOracleDataSet(StrToObj(RecordCollates[I])));
      FindRecordCollate.Add(container);
    end
    else
      EmptyDataSet.AddObject(RecordCollates[I], TObject(true));
  end;

  // ��� ����� ������� ������� ���������� �������� DataSet-��, ������� �� �������� �������� ��� ������,
  // �� ����� �������� ������ �� ������ ALevel, ��� �� ������� �� ������� ���������� �� ������ ������
  for I := 0 to ALevel - 1 do
    for J := 0 to SearchDataSet.Count - 1 do
    begin
      // ���� DataSet-� ������� �� �������� �������� ��� ������ �� ����� ������� ������� ����������,
      // �� ����� �������� ������ �� ������ ALevel
      Ind := TStrings(FEmptySearchDataSet[I]).IndexOf(ObjToStr(SearchDataSet[J]));
      if Ind >= 0 then
        // �����
        // ������������� �������, ��� ������ ���������� ������ �� ������ ������ � DataSet
        TStrings(FEmptySearchDataSet[I]).Objects[Ind] := TObject(false);
    end;

  // ��������� ������ EmptyDataSet, SearchDataSet � FindRecordCollate ��� ������� ALevel
  FEmptySearchDataSet.Add(EmptyDataSet);
  FSearchDataSet.Add(SearchDataSet);
  FFindRecordCollate.Add(FindRecordCollate);



  for I := RecordCollates.Count - 1 downto 0 do
  begin
    if TList(RecordCollates.Objects[I]).Count = 0 then
    begin
      // �� ������ RecordCollates.Objects[I] ������������ � ������ FFindRecordCollate
      // ������� �� ���������� ������
      TList(RecordCollates.Objects[I]).Destroy;
    end;
    //RecordCollates.Objects[I] := nil;
    //RecordCollates[I] := '';
    //RecordCollates.Delete(I);
  end;
  RecordCollates.Destroy;
end;

function TSynchrRecords.HasSynchrDataSet(ADataSet : TOracleDataSet) : boolean;
var
  I : Integer;
  n : Integer;
begin
  Result := false;
  I := 0;
  n := Length(FMainRecordCollate);
  while (I < n) and (not Result) do
  begin
    Result := FMainRecordCollate[I].HasSynchrDataSet(ADataSet);
    Inc(I);
  end;
end;

// ����� c ������� ������ DataSet-��, � ������� ���� �������� ������
function TSynchrRecords.find_(ALevel : Integer; ASynchrData : PDataSetWithDetailsForSynch) : boolean;
var
  LFinder : TList;
  //LDataSets : TList;
  DataSetCount : Integer;
  I, J, n : Integer;
  Finded : boolean;
  RecordCollates : TList;
  rc : TRecordCollate;

function findRecOfDataSet_(Ind : Integer) : boolean;
var
  RCollates : TList;
  rc_ : TRecordCollate;
  Finded : boolean;
  j : Integer;
begin
  if Length(FCanFindDataSet[Alevel]) > ind then
  begin
    if FCanFindDataSet[Alevel][ind] then
    begin
      // ������ ������ RecordCollate-��
      RCollates := TList(LFinder[Ind]);

      // ���� ��������� ���������� ������
      rc_ := TRecordCollate(RCollates[FFindDataSetNow[Alevel][Ind]]);
      if ((Length(rc_.getFieldValues) > 0) and (not(rc_.SynchrDataSet.SearchRecord(rc_.getFieldNames, rc_.getFieldValues, [srFromCurrent, srForward]))))
         or ((Length(rc_.getFieldValues) = 0) and (not rc_.SynchrDataSet.IsEmpty)) then
      begin
        Finded := false;
        Result := false;

        for j := FFindDataSetNow[Alevel][Ind] + 1 to RCollates.Count - 1 do
        begin
          rc_ := TRecordCollate(RCollates[j]);

          if ((Length(rc_.getFieldValues) > 0) and (rc_.SynchrDataSet.SearchRecord(rc_.getFieldNames, rc_.getFieldValues, [srFromBeginning, srForward])))
             or ((Length(rc_.getFieldValues) = 0) and rc_.SynchrDataSet.IsEmpty) then
          begin
            // ������ �����
            Finded := true;
            rc_.SynchrDataSet.UpdateCursorPos;
            refrSynchDetailDataSet(getSynchData(ASynchrData, rc_.SynchrDataSet));
            FFindDataSetNow[Alevel][Ind] := j;
            Result := true;
            break;
          end;
        end;

        if not Finded then
        begin
          Result := findRecOfDataSet_(Ind + 1);
          if Result then
          begin
            for j := 0 to RCollates.Count - 1 do
              if ((Length(rc_.getFieldValues) > 0) and (rc_.SynchrDataSet.SearchRecord(rc_.getFieldNames, rc_.getFieldValues, [srFromBeginning, srForward])))
                 or ((Length(rc_.getFieldValues) = 0) and rc_.SynchrDataSet.IsEmpty) then
              begin
                rc_.SynchrDataSet.UpdateCursorPos;
                refrSynchDetailDataSet(getSynchData(ASynchrData, rc_.SynchrDataSet));
                FFindDataSetNow[Alevel][Ind] := j;
                break;
              end;
          end;
        end;
      end
      else
      begin
        Result := true;
        rc_.SynchrDataSet.UpdateCursorPos;
        refrSynchDetailDataSet(getSynchData(ASynchrData, rc_.SynchrDataSet));
      end;
    end
    else
    begin
      if (ind+1) < DataSetCount then
        Result := findRecOfDataSet_(Ind + 1)
      else
        Result := false;
    end;
  end
  else
    Result := false;
end;

begin
  // ������ ������ �� DataSet-��, � ������� ���������� RecordCollate
  LFinder := TList(FFindRecordCollate[ALevel]);
  // ������ ������  DataSet-��
  //LDataSets := TList(FSearchDataSet[ALevel]);

  // ���������� DataSet, � ������� ���� ������
  DataSetCount := LFinder.Count;

  if Length(FFindDataSetNow[Alevel]) = 0 then
  begin
    // ��� �� ���� ������ � DataSet-��

    if DataSetCount > 0 then
    begin
      SetLength(FCanFindDataSet[Alevel], DataSetCount);
      SetLength(FFindDataSetNow[Alevel], DataSetCount);

      Result := false;
      // ���� ������� ������
      for I := 0 to DataSetCount - 1 do
      begin
        // �������, ���� ������ ������� �������
        Finded := false;
        // ������ ������ RecordCollate-��
        RecordCollates := TList(LFinder[I]);
        n := RecordCollates.Count;
        j := 0;
        while (j < n) and (not Finded) do
        begin
          rc := TRecordCollate(RecordCollates[j]);
          //rc.SynchrDataSet.EnableControls;
          if ((Length(rc.getFieldValues) > 0) and (rc.SynchrDataSet.SearchRecord(rc.getFieldNames, rc.getFieldValues, [srFromBeginning, srForward])))
             or ((Length(rc.getFieldValues) = 0) and rc.SynchrDataSet.IsEmpty) then
          begin
            // ������ �����
            Finded := true;
            rc.SynchrDataSet.UpdateCursorPos;
            refrSynchDetailDataSet(getSynchData(ASynchrData, rc.SynchrDataSet));
          end
          else
            // ������ �� �����
            inc(j);
        end;

        if Finded then
        begin

          FFindDataSetNow[Alevel][I] := J;

          // ������� ������ ����
          FCanFindDataSet[Alevel][I] := true;

          // ������ ���� ����, ���� �������
          Result := true;
        end
        else
          // ������� ������ ���
          FCanFindDataSet[Alevel][I] := false;
      end;
    end
    else
      Result := false;
  end
  else
    // ����� ��� ���, ����� �����
    Result := findRecOfDataSet_(0);

end;

// ���������� �� ��������� ������ ������ DataSet, � ������� ��� ������ � ��������� ������� ������
function TSynchrRecords.findEmpty_(ALevel : Integer; ASynchrData : PDataSetWithDetailsForSynch) : boolean;
var
  EmptyDataSet : TStrings;

function findRecOfDataSet_(Ind : Integer) : boolean;
var
  DataSet : TOracleDataSet;
begin
  if EmptyDataSet.Count < Ind then // ���������, ���� �� DataSet, � �������� ����� ����������� ������ �� ��������� ������
  begin
    // ����

    // ������ ���� DataSet
    DataSet := TOracleDataSet(StrToObj(EmptyDataSet[Ind]));

    if boolean(EmptyDataSet.Objects[Ind]) then
    begin
      // �����

      // ���������� ������
      DataSet.Next;

      if DataSet.Eof then
      begin
        // ��������� �����

        // ������������� ������ �� ������ ������
        DataSet.First;
        // ���������� ������ � ���������� DataSet
        Result := findRecOfDataSet_(Ind + 1);
      end
      else
        // ������� ����������� ������ ���� �������
        Result := true;

      refrSynchDetailDataSet(getSynchData(ASynchrData, DataSet));
    end
    else
      // ���������� ������ � ���������� DataSet
      Result := findRecOfDataSet_(Ind + 1);
  end
  else
    // ������� ���� �� �������
    Result := false;
end;

begin
  EmptyDataSet := TStrings(FEmptySearchDataSet[ALevel]);

  // ���������� ������ �� ��������� �������
  if EmptyDataSet.Count > 0 then
    Result := findRecOfDataSet_(0)
  else
    Result := false;
end;

end.
