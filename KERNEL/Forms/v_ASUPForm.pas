unit v_ASUPForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyform, ExtCtrls, vdbASUP, Db;

type
  TArrayOfDataSet   = array of TDataSet;
  TArrayOfASUPQuery = array of TVASUPQuery;

  TfmASUPForm = class(TfmAnyForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    FRegistASUPQueries : TList;
    // ������ �������� ������ TVASUPQuery,
    // � ������� ���������� �����

    function GetASUPQuery(Ind : Integer) : TVASUPQuery;
    { ���������� ASUPQuery, ������� ���������� �����
      Ind - ������ ����� � ������
    }

    function GetASUPQueryCount : Integer;
    { ���������� ���������� ASUPQuery-�, ������� ���������� ����� }
  protected

    procedure RegisterASUPQuery(ASUPQuery : TVASUPQuery);
    // ������� ASUPQuery � ������ ASUPQuery-�� ������� ���������� �����

    function GetDataSetsOfForm : TArrayOfDataSet; virtual;
              // ���������� DataSet-� ����

    function GetMainDataSetOfForm : TDataSet; virtual;
              // ���������� ������� DataSet ����

    procedure ResetCurrBookmarkOfDataSet; virtual;
              // ����� ������� Bookmark-��  DataSet-��

    procedure ResetOldModeOfForm; virtual;
              // ����� ���������� �������� ����

    procedure ResetUserQuery; virtual;
              // ������� SQL ������ �� �������� ������������� �����������

    procedure InitASUPQuery(ASUPQuery: TVASUPQuery);
              // �������������� ASUPQuery ��� ������ �����

    procedure InitASUPQueries;
              // �������������� ASUPQueries-� ��� ������ �����, �������� ���������������
              // ��������� ����� (�.�. ���������, ����������� � ������� � ��� ������, ����� SQL �������)

    function GetInitASUPQueries : TArrayOfASUPQuery; virtual;
              // ���������� ASUPQueries-�, ������� ���������� ����������������
              // ����� ���������� ������ � InitASUPQueries

    procedure finalASUPQuery(ASUPQuery: TVASUPQuery);
              // �������� ������������� ASUPQuery ��� ������ �����

    procedure finalASUPQueries;
              // �������� ������������� ASUPQuery-�� ��� ������ �����

  public
    { Public declarations }

    procedure AnulRegisterASUPQuery(ASUPQuery : TVASUPQuery);
    // ������� ASUPQuery �� ������ ASUPQuery-�� ������� ���������� �����
    // ������ ����� ����� �������� ������ ��� ������ � ASUPQuery

    property RegistASUPQueries[index : Integer] : TVASUPQuery read GetASUPQuery;
    // ������ ASUPQuery-�, ������� ���������� �����
    property RegistASUPQueryCount : Integer read GetASUPQueryCount;
    { ����� ASUPQuery-�, ������� ����������  ����� }

    procedure ApplyDataSaves(Sender : TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� ���� ���� ��������� ���� ��������
              // ��������� ������ � ������ ������� Sender.

    procedure SaveChangeWorkState(Sender : TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� ���� ��������� ��������� ������ � ������
              // ������� Sender.

    procedure CancelChangeWorkState(Sender : TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� ����  �������� ��������� ������ � ������
              // ������� Sender.

    procedure CheckBrowseMode(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� ��� ��� ASUPQuery �������� ��������� �� �� � ������ dsBrowse(���������)
              // � ���� ���, �� ������������ � ���� �����

    procedure DoAfterScroll(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� ������ � ASUPQuery ������������ �� ������ ������

    procedure DoBeforeScroll(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� ������ � ASUPQuery �������� ������������ �� ������ ������

    procedure DoAfterPost(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // �����  � ASUPQuery ��������� Post

    procedure DoBeforePost(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� � ASUPQuery ������ ��������� Post

    procedure DoAfterCancel(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // �����  � ASUPQuery ��������� Cancel

    procedure DoBeforeCancel(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� � ASUPQuery ������ ��������� Cancel

    procedure DoAfterClose(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� �������� ASUPQuery

    procedure DoBeforeClose(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� ��������� ASUPQuery

    procedure DoAfterInsert(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // �����  � ASUPQuery ��������� Insert

    procedure DoBeforeInsert(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� � ASUPQuery ������ ��������� Insert

    procedure DoAfterOpen(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� �������� ASUPQuery

    procedure DoBeforeOpen(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� ��������� ASUPQuery

    procedure DoAfterRefresh(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // �����  � ASUPQuery ��������� Refresh

    procedure DoBeforeRefresh(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� � ASUPQuery ������ ��������� Refresh

    procedure DoAfterEdit(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // �����  � ASUPQuery ��������� Edit

    procedure DoBeforeEdit(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� � ASUPQuery ������ ��������� Edit

    procedure DoAfterDelete(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // �����  � ASUPQuery ��������� Delete

    procedure DoBeforeDelete(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� � ASUPQuery ������ ��������� Delete

    procedure ChangeASUPQueryWorkState(ASUPQuery: TVASUPQuery); virtual;
              // ����� ���������� �������� ������ TVASUPQuery,
              // ����� � ASUPQuery ���������� �������� �������� WorkState

    procedure DataModified(var AModified : boolean); virtual;
  end;

var
  fmASUPForm: TfmASUPForm;

implementation

{$R *.DFM}

function TfmASUPForm.GetASUPQuery(Ind : Integer) : TVASUPQuery;
begin
  if (Ind >= 0) and (Ind < FRegistASUPQueries.Count) then
    Result := TVASUPQuery(FRegistASUPQueries[Ind])
  else
    Result := nil;
end;

function TfmASUPForm.GetASUPQueryCount : Integer;
begin
  Result := FRegistASUPQueries.Count;
end;

procedure TfmASUPForm.RegisterASUPQuery(ASUPQuery : TVASUPQuery);
begin
  if Assigned(ASUPQuery) and (FRegistASUPQueries.IndexOf(ASUPQuery) < 0) then
    FRegistASUPQueries.Add(ASUPQuery);
end;

procedure TfmASUPForm.AnulRegisterASUPQuery(ASUPQuery : TVASUPQuery);
begin
  FRegistASUPQueries.Remove(ASUPQuery);
end;

procedure TfmASUPForm.ResetCurrBookmarkOfDataSet;
var
  DataSet : TDataSet;
begin
  DataSet := GetMainDataSetOfForm;
  if Assigned(DataSet) and (DataSet is TVASUPQuery) then
    // ������� �� ������ Bookmark-��
    TVASUPQuery(DataSet).ClearCurrRecBookmarks;
end;

procedure TfmASUPForm.ResetUserQuery;
var
  DataSet : TDataSet;
begin
  DataSet := GetMainDataSetOfForm;
  if Assigned(DataSet) and (DataSet is TVASUPQuery) then
    // ������� ���������������� ������
    TVASUPQuery(DataSet).ClearAllUserSQLQuerys;
end;

procedure TfmASUPForm.ResetOldModeOfForm;
begin
  ResetCurrBookmarkOfDataSet;
  // ������� ���������������� ������
  ResetUserQuery;
end;

function TfmASUPForm.GetDataSetsOfForm : TArrayOfDataSet;
var
  I : Integer;
begin
  SetLength(Result, FRegistASUPQueries.Count);
  for I := 0 to FRegistASUPQueries.Count - 1 do
    Result[I] := TDataSet(FRegistASUPQueries[I]);
end;

function TfmASUPForm.GetMainDataSetOfForm : TDataSet;
begin
  Result := nil;
end;

procedure TfmASUPForm.InitASUPQuery(ASUPQuery: TVASUPQuery);
begin
  if Assigned(ASUPQuery) then
  begin
    ASUPQuery.RegisterForm(Self);
    RegisterASUPQuery(ASUPQuery);
  end;
end;

procedure TfmASUPForm.InitASUPQueries;
var
  I : Integer;
  ASUPQueries : TArrayOfASUPQuery;
begin
  finalASUPQueries; // �������� ���������� �������������

  // ������ ASUPQueries-�, ������� ���������� ����������������
  ASUPQueries := GetInitASUPQueries;

  for I := Low(ASUPQueries) to High(ASUPQueries) do
    InitASUPQuery(ASUPQueries[I]);
end;

function TfmASUPForm.GetInitASUPQueries : TArrayOfASUPQuery;
begin
  SetLength(Result, 0);
end;

procedure TfmASUPForm.finalASUPQuery(ASUPQuery: TVASUPQuery);
begin
  if Assigned(ASUPQuery) then
  begin
    ASUPQuery.AnulRegisterForm(Self);
    AnulRegisterASUPQuery(ASUPQuery);
  end;
end;

procedure TfmASUPForm.finalASUPQueries;
var
  DataSets : TArrayOfDataSet;
  I : Integer;
begin
  DataSets := GetDataSetsOfForm;
  for I := Low(DataSets) to High(DataSets) do
    if DataSets[I] is TVASUPQuery then
      finalASUPQuery(TVASUPQuery(DataSets[I]));
end;

procedure TfmASUPForm.ApplyDataSaves(Sender : TVASUPQuery);
begin
end;

procedure TfmASUPForm.SaveChangeWorkState(Sender : TVASUPQuery);
begin
end;

procedure TfmASUPForm.CancelChangeWorkState(Sender : TVASUPQuery);
begin
end;

procedure TfmASUPForm.FormCreate(Sender: TObject);
begin
  FRegistASUPQueries := TList.Create;
  inherited;
  // ���������� ���������� ��������� ����
  ResetOldModeOfForm;

  // �������������� ASUPQueries-� ��� ������ �����
  InitASUPQueries;
end;

procedure TfmASUPForm.FormDestroy(Sender: TObject);
begin
  inherited;
  finalASUPQueries;
  FRegistASUPQueries.Destroy;
end;

procedure TfmASUPForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  ResetOldModeOfForm;
end;

procedure TfmASUPForm.DoAfterScroll(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.CheckBrowseMode(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoBeforeScroll(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.ChangeASUPQueryWorkState(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoAfterPost(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoBeforePost(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoAfterCancel(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoBeforeCancel(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoBeforeClose(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoAfterClose(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoBeforeInsert(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoAfterInsert(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoBeforeOpen(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoAfterOpen(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoBeforeRefresh(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoAfterRefresh(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoBeforeEdit(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoAfterEdit(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoBeforeDelete(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DoAfterDelete(ASUPQuery: TVASUPQuery);
begin
end;

procedure TfmASUPForm.DataModified(var AModified : boolean);
begin
end;

end.
