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
    // Список объектов класса TVASUPQuery,
    // в которые использует форма

    function GetASUPQuery(Ind : Integer) : TVASUPQuery;
    { Возвращает ASUPQuery, который использует форма
      Ind - индеск формы в списке
    }

    function GetASUPQueryCount : Integer;
    { Возвращает количество ASUPQuery-и, которых используют форма }
  protected

    procedure RegisterASUPQuery(ASUPQuery : TVASUPQuery);
    // Заносит ASUPQuery в список ASUPQuery-ов которых использует форма

    function GetDataSetsOfForm : TArrayOfDataSet; virtual;
              // Возвращает DataSet-ы окна

    function GetMainDataSetOfForm : TDataSet; virtual;
              // Возвращает главный DataSet окна

    procedure ResetCurrBookmarkOfDataSet; virtual;
              // Сброс текущих Bookmark-ов  DataSet-ов

    procedure ResetOldModeOfForm; virtual;
              // Сброс устаревших настроек окна

    procedure ResetUserQuery; virtual;
              // Очищает SQL запрос от заданных пользователем ограничений

    procedure InitASUPQuery(ASUPQuery: TVASUPQuery);
              // Инициализирует ASUPQuery для данной формы

    procedure InitASUPQueries;
              // Инициализирует ASUPQueries-ы для данной формы, которыми непосредственно
              // управляет форма (т.е. вставляет, редактирует и удаляет в них записи, задаёт SQL запросы)

    function GetInitASUPQueries : TArrayOfASUPQuery; virtual;
              // Возвращает ASUPQueries-ы, которые необходимо инициализировать
              // Метод вызывается только в InitASUPQueries

    procedure finalASUPQuery(ASUPQuery: TVASUPQuery);
              // Отменяет инициализацию ASUPQuery для данной формы

    procedure finalASUPQueries;
              // Отменяет инициализацию ASUPQuery-ий для данной формы

  public
    { Public declarations }

    procedure AnulRegisterASUPQuery(ASUPQuery : TVASUPQuery);
    // Удаляет ASUPQuery из списка ASUPQuery-ов которых использует форма
    // Данный метод могут вызывать только сам объект и ASUPQuery

    property RegistASUPQueries[index : Integer] : TVASUPQuery read GetASUPQuery;
    // Список ASUPQuery-и, которых использует форма
    property RegistASUPQueryCount : Integer read GetASUPQueryCount;
    { Число ASUPQuery-и, которых использует  форма }

    procedure ApplyDataSaves(Sender : TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // когда надо либо сохранить либо отменить
              // изменения данных в записи объекта Sender.

    procedure SaveChangeWorkState(Sender : TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // когда надо сохранить изменения данных в записи
              // объекта Sender.

    procedure CancelChangeWorkState(Sender : TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // когда надо  отменить изменения данных в записи
              // объекта Sender.

    procedure CheckBrowseMode(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // перед тем как ASUPQuery проверит находится ли он в режиме dsBrowse(просмотре)
              // и если нет, то переключится в этот режим

    procedure DoAfterScroll(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда курсор в ASUPQuery переместился на другую запись

    procedure DoBeforeScroll(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда курсор в ASUPQuery начинает перемещаться на другую запись

    procedure DoAfterPost(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда  в ASUPQuery произошел Post

    procedure DoBeforePost(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда в ASUPQuery должен произойти Post

    procedure DoAfterCancel(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда  в ASUPQuery произошел Cancel

    procedure DoBeforeCancel(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда в ASUPQuery должен произойти Cancel

    procedure DoAfterClose(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // после закрытия ASUPQuery

    procedure DoBeforeClose(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // перед закрытием ASUPQuery

    procedure DoAfterInsert(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда  в ASUPQuery произошел Insert

    procedure DoBeforeInsert(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда в ASUPQuery должен произойти Insert

    procedure DoAfterOpen(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // после открытия ASUPQuery

    procedure DoBeforeOpen(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // перед открытием ASUPQuery

    procedure DoAfterRefresh(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда  в ASUPQuery произошел Refresh

    procedure DoBeforeRefresh(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда в ASUPQuery должен произойти Refresh

    procedure DoAfterEdit(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда  в ASUPQuery произошел Edit

    procedure DoBeforeEdit(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда в ASUPQuery должен произойти Edit

    procedure DoAfterDelete(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда  в ASUPQuery произошел Delete

    procedure DoBeforeDelete(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда в ASUPQuery должен произойти Delete

    procedure ChangeASUPQueryWorkState(ASUPQuery: TVASUPQuery); virtual;
              // Метод вызывается объектом класса TVASUPQuery,
              // Когда в ASUPQuery изменилось значения свойства WorkState

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
    // Очищаем от старых Bookmark-ов
    TVASUPQuery(DataSet).ClearCurrRecBookmarks;
end;

procedure TfmASUPForm.ResetUserQuery;
var
  DataSet : TDataSet;
begin
  DataSet := GetMainDataSetOfForm;
  if Assigned(DataSet) and (DataSet is TVASUPQuery) then
    // Очищаем пользовательский запрос
    TVASUPQuery(DataSet).ClearAllUserSQLQuerys;
end;

procedure TfmASUPForm.ResetOldModeOfForm;
begin
  ResetCurrBookmarkOfDataSet;
  // Очищаем пользовательский запрос
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
  finalASUPQueries; // Отменяет предыдущую инициализацию

  // Читаем ASUPQueries-ы, которые необходимо инициализировать
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
  // Сбрасываем устаревшие настройки окна
  ResetOldModeOfForm;

  // Инициализируем ASUPQueries-ы для данной формы
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
