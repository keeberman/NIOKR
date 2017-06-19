unit vWorkForm;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls,mask, DB, Menus,
 vdbASUP, v_Child, v_AnyForm, v_ASUPForm, Variants;

const
 CFormChange= 'На форме имеются несохраненные изменения. Сохранить?';
 NotEditMsg= 'Редактирование записи запрещено.';
 EmptyDataSetMsg= 'Нет данных для удаления.';
 EmptyQueryDataMsg= 'Записи, удовлетворяющие данному запросу не обнаружены';
 ConfirmDelMsg= 'Удалить запись ?';
 EmptyDateShortText='  .  .  ';
 EmptyDateLongText='  .  .    ';
 EmptyNormDateText= '01.  .  ';

 CReadOnly   = $00000001;
 CStupidTag  = $00000002;
 SApplyUpdatesWarn= 'Сохранить текущие изменения перед обновлением данных ?';

type
 PNumFmt= ^TNumFmt;
 TNumFmt= record
  ID: Integer;
  EditFmt: string;
  DisplayFmt: string;
  DataSet: TDataSet;
 end;{ Структура для хранения форматов редактирования и
       отображения полей типа TIntegerField}

 TSelection = (sYES, sNO, sOTHER);

 TStyleEvent= procedure of object;

 TReportRef = class of TForm;

{ Классы }
 TFmtList= class(TList)//Список сохраненных форматов полей
  procedure Delete(Index: Integer);
  procedure Clear;
  function FindFmt(ADataSet: TDataSet;Index:Integer):PNumFmt;
  destructor Destroy;override;
 end;

 TfmWorkForm = class(TfmChild)
 private
   // Компонент редактор, у которого активировали контекстное меню
  FPopupEdit : TCustomEdit;
 published
             {Форма-предок для операций над
             реквизитами одной записи из dsCurrent.DataSet}
  paRightBottom: TPanel;
  bbCancel: TBitBtn;
  bbOK: TBitBtn;
  bbView: TBitBtn;
  dsCurrent: TDataSource;
  PopSwitch: TPopupMenu;
  itEdit: TMenuItem;
  itAdd: TMenuItem;
  itDelete: TMenuItem;
  itView: TMenuItem;
  itQuery: TMenuItem;
  ID: TVEditFormID;
  bbPrior: TSpeedButton;
  bbNext: TSpeedButton;

  // Компонент редактор, у которого активировали контекстное меню
  property PopupEdit : TCustomEdit read FPopupEdit;

  procedure SetWS(AWStyle: TWStyle);
            //Установка режима



  procedure FormCreate(Sender: TObject);
            //Обработчик OnCreate формы

  procedure dsCurrentDataChange(Sender: TObject; Field: TField);
            {Обработчик OnDataChange компонента dsCurrent.
            Настройка конпок навигации}

  procedure SwitchItemClick(Message: TMessage);
            {Настройка опций  меню PopSwitch в соответствии
            с режимом, определяемым по Message}

  procedure PopItemClick(Sender: TObject);
            //Обработчик OnClick опций меню PopSwitch

  procedure SetPopItems;
            //Настройка опций  меню PopSwitch

  procedure FormDestroy(Sender: TObject);
           {Обработчик OnDestroy формы.
           Посылает интсрукции завершения главной форме
           приложения}

  procedure FormClose(Sender: TObject; var Action: TCloseAction);
            //Обработчик OnClose формы

  procedure WarningOnPress(_Sender: TObject; var Key:Char);
            {Предупреждение при попытке ввода лишних символов
            в элемент типа TDBEdit(когда Text+NewSymbol>MaxLength)
            Для использования необходимо определить:
            Control.OnKeyPress:= WarningOnPress}

  procedure OnStupidPress(_Sender: TObject; var Key:Char);
            {Предупреждение при попытке редактирования
            столбцов(например, в режиме wsView).
            Для использования необходимо определить:
            Control.OnKeyPress:= OnStupidPress}

  procedure OnStupidClick(_Sender:TObject);
            {Предупреждение при попытке нажатия кнопки мыши
            над DBAware-компонентом (например, в режиме wsView).
            Для использования необходимо определить:
            Control.OnClick:= OnStupidClick}

  procedure FormShow(Sender: TObject);
            //Обработчик OnShow формы

  procedure ButtonClick(Sender: TObject);
            //Обработчик OnClick для кнопок на панели paRightBottom

  procedure SetActCtrl;
            {Определение первого DBAware-компонента,
            который должен получить фокус ввода}

  procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
           {Обработчик OnKeyDown формы. Эмулирует нажатие
            навигационных кнопок при нажатии
            клавиш клавиатуры стрелка вверх и стрелка вниз}

  procedure QuickJump(_Sender:TObject);
            {Переход от компонента(1), имеющего фокус ввода
            к следующему(2), в случае когда (1).Text=(1).MaxLength.
            Может использоваться для быстрого ввода данных}

  procedure StartLongClick(_Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
  //Эмулирует "непрерывное" нажатие навигационных кнопок}

  procedure FinishLongClick(_Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
  {Прекращение эмулирования "непрерывного" нажатия
  навигационных кнопок}

  procedure ModeSwitchPopup(Sender: TObject);
            {Обработчик OnPopUp меню режимов PopSwitch.
             Настройка опций меню режимов согласно
             правам на dsCurrent.DataSet}

  procedure DateEditChange(_Sender: TObject);
  procedure NormDateEditChange(_Sender: TObject);
  procedure FormActivate(Sender: TObject);
  procedure FormDeactivate(Sender: TObject);
  procedure bbNextClick(Sender: TObject);
            {Обработчик OnChange компонентов TDBEdit с
            полями типа TDateTimeField. Необходим для
            выхода из компонента без сообщения об ошибке,
            в случае, когда данные не вводились}
  procedure StandardWEButtonClick(Sender: TObject;
      var UseInherited: Boolean);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);

 private
 {Private declarations}
  FReport: TReportRef;//Указатель на класс формы-контейнера отчета
  FIncMaster: bool;// Входят ли мастер-поля в примарный ключ
  FCtrlArea: TWinControl; // Активная область формы
  FNeedFreeCode: boolean; {Требуется ли найти первый свободный номер
                          при добавлении новой записи}
  FHighLightReqField:boolean; //Вкючать подсветку dbedit'ов с обязательными полями
  FHighLightFieldColor: TColor;//Цвет подсветки

  FSaved : TSelection;

  FWorkStyleBeforeChCurrsor: TWStyle;
  // Режим окна, перед тем как был перемещен курсор на другую запись
  FWorkStateAQBeforeChCurrsor: TWStyle;
  // Режим текущего ASUPQuery, перед тем как был перемещен курсор на другую запись
  FDataSetOfChangedCurrsor: TDataSet;
  // DataSet, в котором перемещается курсор

  FScrolling : Boolean;
  // Курсор сейчас перемещаются
  FAfterScrolling : boolean;
  // Курсор перемещен, но установка нужных режимов не завершена
  FChangingModeCount : Integer;

  FCheckingWorkStyle : boolean;

  FPopuPMenu : TPopupMenu;

  procedure SetCtrlArea(CtrlArea:TWinControl);
            //Определение области-предка для поиска ActiveControl формы

 protected
 {Protected declarations}
  FmtList:TFmtList;//Список сохраненных форматов полей dsCurrent.DataSet
  FWStyle: TWStyle;//Текущий режим работы
  FCallBackWin: TWinControl; // Окно обратных вызовов

  procedure UMInitialize(var Message:TMessage);message UM_INITIALIZE;
            //Установка dsCurrent.DataSet

  procedure UMOthers(var Message:TMessage);message UM_OTHERS;
  function GetFreeCode(const AFieldName: string):string;virtual;
           {Получение первого свободного кода.
            Используется для справочников}

  function OraclePerformance:boolean;virtual;
           {Выполнение операции на Oracle согласно
           текущему режиму}

  function NoDataInserting(DataSet:TDataSet):bool;

  property NeedFreeCode: boolean read FNeedFreeCode write FNeedFreeCode;
           {Требуется ли найти первый свободный номер
            при добавлении новой записи}

  procedure RepaintNaviBtn(DataSet: TDataSet);//Настройка навигационных кнопок
  procedure RepaintAllBtn;virtual;//Настройка всех кнопок
  procedure ReverseFormats;virtual;//Возврат полям их сохранненых форматов из FmtList
  procedure CopyFormats;virtual;
            {Сохранение форматов полей типа
            TIntegerField в списке FmtList}
  function DoEnForcePost: bool;virtual;
  procedure SetHighLightReqField(AValue:boolean);
  procedure SetHighLighting;virtual;
  procedure ChangeWorkStyle(var Message:TMessage);virtual;
  procedure ShowSQLDescription(AQuery:TVASUPQuery = nil);override;
  function NeedToSave(DataSet:TDataSet):bool;virtual;
  function AskToSaveData: TSelection;
  function GetQuestionAtSaving : String; virtual;

  function GetMainDataSetOfForm : TDataSet; override;
            // Возвращает главный DataSet окна

  function GetInitASUPQueries : TArrayOfASUPQuery; override;
            // Возвращает ASUPQueries-ы, которые необходимо инициализировать
            // Метод вызывается только в InitASUPQueries


  procedure CheckWorkStyle(Message:TMessage); overload; virtual;
            // Проверяет, соответствует ли режим dsCurrent.DataSet(WorkState) режиму форму(WorkStyle)
            // Если нет, то переводит форму в тот режим работы(WorkStyle),
            // в котором находится dsCurrent.DataSet(WorkState)
  procedure CheckWorkStyle; overload; virtual;
            // Проверяет, соответствует ли режим dsCurrent.DataSet(WorkState) режиму форму(WorkStyle)
            // Если нет, то переводит форму в тот режим работы(WorkStyle),
            // в котором находится dsCurrent.DataSet(WorkState)

  function SaveData : boolean; virtual;
            {Метод сохраняет изменения данных формы в Oracle}
  procedure CancelData; virtual;
            {Метод отменяет изменения данных формы}

  procedure ResetCacheData;
  {Сбрасывает признак, что в кэше хранятся изменения данных,
   которые не сохранены на сервере}

  property Saved : TSelection read FSaved;

  function ContextPopup(Sender : TwinControl;APos: TPoint) : boolean; virtual;
  { Функция отображает контекстное меня
    Если функция не отображает то, она возвращает значение false, иначе возвратит true
  }

 public
 {Public declarations}

  procedure NavigatorClick(_Sender: TObject; ADataSet : TDataSet); overload; virtual; 
  procedure NavigatorClick(_Sender: TObject); overload; virtual;
            {Действие, вызванное "нажатием" навигационных
             кнопок(bbPrior,bbNext)}

  procedure GetData(ADataSet:TDataSet;STYLEPARAM: Integer);virtual;
            {Определяет все DBAware-компоненты, с DataSource
            нацеленным на ADataSet и устанавливает
            их ReadOnly}

  procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;

  function StyleToText(Message:TMessage) : string;virtual;
         //По режиму работы определяет заголовок формы

  procedure ApplyDataSaves(Sender : TVASUPQuery); override;
            // Метод вызывается объектом класса TVASUPQuery,
            // когда надо либо сохранить либо отменить
            // изменения данных в записи объекта Sender.

  procedure SaveChangeWorkState(Sender : TVASUPQuery); override;
            // Метод вызывается объектом класса TVASUPQuery,
            // когда надо сохранить изменения данных в записи
            // объекта Sender.

  procedure CancelChangeWorkState(Sender : TVASUPQuery); override;
            // Метод вызывается объектом класса TVASUPQuery,
            // когда надо  отменить изменения данных в записи
            // объекта Sender.

  procedure CheckBrowseMode(ASUPQuery: TVASUPQuery); override;
            // Метод вызывается объектом класса TVASUPQuery,
            // перед тем как ASUPQuery проверит находится ли он в режиме dsBrowse(просмотре)
            // и если нет, то переключится в этот режим

  procedure DoBeforeScroll(ASUPQuery: TVASUPQuery); override;
            // Метод вызывается объектом класса TVASUPQuery,
            // Когда курсор в ASUPQuery начинает перемещаться на другую запись

  procedure DoAfterScroll(ASUPQuery: TVASUPQuery); override;
            // Метод вызывается объектом класса TVASUPQuery,
            // Когда курсор в ASUPQuery переместился на другую запись

  property ControlArea:TWinControl read FCtrlArea write SetCtrlArea;
           //Область-предок для поиска ActiveControl'а формы

  property ReportType:TReportRef read FReport write FReport;
           //Указатель на класс формы-контейнера отчета

  property IncludeMaster: bool read FIncMaster write FIncMaster;
           {Входят ли мастер-поля в примарный ключ.
           Используется в функции GetFreeCode}

  property HighLightRequiredField:boolean
        read FHighLightReqField write SetHighLightReqField;
  property HightLightFieldColor: TColor read FHighLightFieldColor
        write FHighLightFieldColor;

  {
  property ShowSQLDescriptForm: bool read GetShowSQLDescriptForm
           write SetShowSQLDescriptForm;
  }
 published
  property WorkStyle: TWStyle read FWStyle write SetWS;
           //Текущий режим работы
 end;

{ Общие функции }
function Ws2Instruc(AWStyle:TWStyle) : Integer;
         {По режиму работы определяет инструкцию
         соообщения UM_CHANGEMODE}

function Ws2Msg(AWStyle:TWStyle) : TMessage;
         {По режиму работы формирует соообщение UM_CHANGEMODE}

function Msg2Ws(AMsg:Integer) : TWStyle;
         {По инструкции соообщения UM_CHANGEMODE
         определяет режим работы}

function WS2Text(AWStyle:TWStyle) : string;
         //Определяет название режима работы
var
 fmWorkForm: TfmWorkForm;
 SearchingTable: string;
 //Имя таблицы для поиска свободного кода из GetFreeCode
 StartTimer: bool;

implementation

uses Globals, v_utils,MENUGnrl,Oracle,TypInfo,
OracleData,RxLookUp;

{$R *.DFM}

{ Общие функции }
function Ws2Instruc(AWStyle:TWStyle) : Integer;
begin
  case AWStyle of
    wsQuery:Result:= IN_QUERY;
    wsAdd:Result:= IN_INSERT;
    wsEdit:Result:= IN_EDIT;
    wsDelete:Result:= IN_DELETE;
    wsView:Result:= IN_VIEW;
    else Result:= IN_NONE;
  end;//case
end;//Ws2Instruc

function Ws2Msg(AWStyle:TWStyle) : TMessage;
begin
  Result.Msg:= UM_CHANGEMODE;
  Result.lParam:= 0;
  Result.wParam:= Ws2Instruc(AWStyle);
end;

function Msg2Ws(AMsg:Integer) : TWStyle;
begin
  case AMsg of
    IN_QUERY:Result:=wsQuery;
    IN_INSERT:Result:= wsAdd;
    IN_EDIT:Result:= wsEdit;
    IN_DELETE:Result:= wsDelete;
    IN_VIEW:Result:= wsView;
    else Result := wsNone;
  end;//case
end;//Msg2Ws

function WS2Text(AWStyle:TWStyle) : string;
begin
  case AWStyle of
    wsAdd:Result:= 'Добавление';
    wsEdit:Result:= 'Редактирование';
    wsDelete:Result:= 'Удаление';
    wsView:Result:= 'Просмотр';
    wsQuery:Result:= 'Запрос'
    else Result:= '';
  end;//case
end;//WS2Text

{--------------------------------- TFmtList ----------------------------------}
procedure TFmtList.Delete(Index: Integer);
begin
  Dispose(PNumFmt(Items[Index]));
  inherited Delete(Index);
end;

procedure TFmtList.Clear;
var
 I: Integer;
begin
  for I:= Count-1 downto 0 do Delete(I);
end;

function TFmtList.FindFmt(ADataSet: TDataSet;Index:Integer):PNumFmt;
var
  I: Integer;
  DataSetFinded: bool;
begin
  Result:= nil;
  I:= 0;
  DataSetFinded:= false;
  while (I<Count) and (not DataSetFinded or ( PNumFmt(Items[I])^.DataSet=
                                              ADataSet) )
        and not Assigned(Result) do
  begin
    DataSetFinded:= PNumFmt(Items[I])^.DataSet= ADataSet;
    if (PNumFmt(Items[I])^.DataSet= ADataSet) and
       (PNumFmt(Items[I])^.ID= Index) then Result:= Items[I]
    else Inc(I);
  end;
end;

destructor TFmtList.Destroy;
begin
  Clear;
  inherited;
end;

{----------------------------- TfmWorkForm -----------------------------------
 Св-во Visible установлено в False                                             }

function TfmWorkForm.StyleToText(Message:TMessage) : string;
begin
  Result:= WS2Text(Msg2Ws(Message.wParam));
end;//StyleToText

procedure TfmWorkForm.SetCtrlArea(CtrlArea:TWinControl);
begin
  // if FCtrlArea<>CtrlArea then ActiveControl:= nil;
  FCtrlArea:= CtrlArea;
end;//SetCtrlArea

procedure TfmWorkForm.ReverseFormats;
var
  I: Integer;
  CurFmt: PNumFmt;
begin
  if Assigned(FmtList) then
  begin
    for I:= 0 to dsCurrent.DataSet.FieldCount-1 do
      if (dsCurrent.DataSet.Fields[I] is TIntegerField) then
      begin
        CurFmt:= FmtList.FindFmt(dsCurrent.DataSet,dsCurrent.DataSet.Fields[I].FieldNo);
        if Assigned(CurFmt) then
        with CurFmt^,(dsCurrent.DataSet.Fields[I] as TIntegerField) do
        begin
          EditFormat:= EditFmt;
          DisplayFormat:= DisplayFmt;
        end;
      end;
    FmtList.Clear;
  end;
end;//ReverseFormats

procedure TfmWorkForm.CopyFormats;
var
  I: Integer;
  CurFmt: PNumFmt;
begin
  if not Assigned(FmtList) then FmtList:= TFmtList.Create
  else FmtList.Clear;
  for I:= 0 to dsCurrent.DataSet.FieldCount-1 do
    if (dsCurrent.DataSet.Fields[I] is TIntegerField)
     and not Assigned( FmtList.FindFmt
                       ( dsCurrent.DataSet,
                         dsCurrent.DataSet.Fields[I].FieldNo)) then
    begin
      New(CurFmt);
      with CurFmt^,(dsCurrent.DataSet.Fields[I] as TIntegerField) do
      begin
        ID:= FieldNo;
        EditFmt:= EditFormat;
        DisplayFmt:= DisplayFormat;
        DataSet:= dsCurrent.DataSet;
      end;
      FmtList.Add(CurFmt)
    end;
end;//CopyFormats

procedure TfmWorkForm.SetActCtrl;
begin
  if WorkStyle<>wsDelete then
    if not Assigned(ActiveControl) or not ActiveControl.TabStop then
      if not Assigned(ControlArea) then
         ActiveControl:= FindActCtrl(Self)
      else ActiveControl:= FindActCtrl(FCtrlArea);
end;//SetActCtrl

function TfmWorkForm.OraclePerformance;
begin
  Result:= true;
  try
    if FWStyle<> wsDelete then Screen.Cursor:= crSQLWait;
    try
      case FWStyle of
        wsDelete:
          if (MessageDlg(ConfirmDelMsg,mtConfirmation,[mbYes,mbNo],0)=mrYes) then
            if not dsCurrent.DataSet.IsEmpty then
            begin
              Screen.Cursor:= crSQLWait;
              if DataCount=UNASSIGNED then DataCount:= GetDataCount;
              dsCurrent.DataSet.Delete;
              DataCount:= DataCount -1;
            end
            else MessageDlg(EmptyDataSetMsg,mtError,[mbOk],0)
          else Result:= false;
        wsAdd:
        begin
          if DataCount=UNASSIGNED then DataCount:= GetDataCount;
          if ((dsCurrent.DataSet is TVASUPQuery) and TVASUPQuery(dsCurrent.DataSet).DataModified)

             or ((not(dsCurrent.DataSet is TVASUPQuery)) and dsCurrent.DataSet.Modified) then
          begin
            if dsCurrent.DataSet.State in dsEditModes then
              dsCurrent.DataSet.Post;
            DataCount:= DataCount +1;

            // Сбрасываем признак, что в кэше хранятся изменения данных, которые не сохранены на сервере
            ResetCacheData; //!!! Данный код очень необходим для нормальной работы окна
            // Так как TVASUPQuery по техническим причинам не может самостоятельно сбрасывать этот признак,
            // то признак надо сбросить вручную
          end
          else Result:= false;
        end;
        wsEdit: if ((dsCurrent.DataSet is TVASUPQuery) and TVASUPQuery(dsCurrent.DataSet).DataModified)
                   or ((not(dsCurrent.DataSet is TVASUPQuery)) and dsCurrent.DataSet.Modified)
                   or DoEnForcePost then
                begin
                  //if dsCurrent.State<>dsEdit then dsCurrent.DataSet.Edit;
                  if dsCurrent.DataSet.State in dsEditModes then
                    dsCurrent.DataSet.Post;

                  // Сбрасываем признак, что в кэше хранятся изменения данных, которые не сохранены на сервере
                  ResetCacheData; //!!! Данный код очень необходим для нормальной работы окна
                  // Так как TVASUPQuery по техническим причинам не может самостоятельно сбрасывать этот признак,
                  // то признак надо сбросить вручную
                  if dsCurrent.DataSet is TVASUPQuery then
                    TVASUPQuery(dsCurrent.DataSet).WorkState := wsEdit
                  else
                    dsCurrent.DataSet.Edit;
                end;
        wsQuery: with dsCurrent.DataSet as TVASUPQuery do
        begin
          ClearDataCount;
          Screen.Cursor:= crSQLWait;
          SaveViQuery;
          try
            try
              Execute;
            finally
              Screen.Cursor:= crDefault;
            end;
          except
            on E:EEmptyQuery do
            begin
              Self.Repaint;
              MessageDlg(E.Message,mtError,[mbOk],0);
              ActiveControl:= nil;
              SetActCtrl;
              Result:= false;
              exit;
            end
            else raise;
          end;
          TVASUPQuery(dsCurrent.DataSet).WorkState := wsView;
          if IsEmpty then
          begin
            MessageBeep(0);
            MessageDlg(EmptyQueryDataMsg,mtWarning,[mbOk],0);
            TVASUPQuery(dsCurrent.DataSet).WorkState := wsQuery;
            Result:= false;
            {Insert;
            WorkState:= wsQuery;
            OnScreen(IndexViQuery);}
            if IndexQuery>=0 then
            begin
              LinkedQueryList.Seek(IndexQuery);
              if ShowSQLDescriptForm then ShowSQLDescription;
              DeleteQuery(True);
            end;
            ActiveControl:= nil;
            SetActCtrl;
          end
          else  //Внимание вставка !!!!
          begin
            ReverseFormats;
            //CloseViSession;

          end;
        end;
      end;//case
      if FWStyle in [wsQuery,wsAdd,wsDelete] then
        Perform(UM_OTHERS,IN_STATUS,0);
      if FWStyle in [wsAdd,wsDelete] then
        Application.MainForm.Perform(UM_OTHERS,IN_REFRESH,0);
    except
      on E:Exception do
      begin
        EndRepeatCycle;
        Beep;
        if not (E is EAbort) then
          MessageDlg(E.Message,mtError,[mbOk],0);
        Result:= false;
      end;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;//OraclePerformance

procedure TfmWorkForm.SetWS(AWStyle: TWStyle);
begin
  inc(FChangingModeCount);
  try
    Perform(UM_CHANGEMODE,Ws2Instruc(AWStyle),0);
  finally
    dec(FChangingModeCount);
  end;
end;//SetWS

procedure TfmWorkForm.SetPopItems;
begin
  if Assigned(PopUpMenu) then
    SwitchItemClick(Ws2Msg(FWStyle));
end;//SetPopItems

procedure TfmWorkForm.FormCreate(Sender: TObject);
begin
  FWorkStyleBeforeChCurrsor := wsNone;
  FWorkStateAQBeforeChCurrsor := wsNone;
  FDataSetOfChangedCurrsor := nil;
  FAfterScrolling := false;
  FScrolling := false;
  FChangingModeCount := 0;
  FCheckingWorkStyle := false;

  // Создаем меня для елементов TCustomEdit
  FPopuPMenu := TVParentPopMenuCD.Create(Self);

  inherited;
  FCtrlArea:= nil;
  FdsLocal:= dsCurrent;
  FdsNavi:= dsCurrent;
  FIncMaster:= true;
  FNeedFreeCode:= true;
  FWStyle:= wsNone;
  FHighLightFieldColor:= clInfoBk;
  FSaved := sOther;
end;//FormCreate

procedure TfmWorkForm.dsCurrentDataChange(Sender: TObject; Field: TField);
begin
  if not Assigned(Field) then
  begin
    if dsCurrent.State=dsInActive then FmtList.Free;
    if not Assigned(fdsNavi) then RepaintNaviBtn(dsCurrent.DataSet)
    else RepaintNaviBtn(FdsNavi.DataSet);
  end;
end;//dsCurrentDataChange

procedure TfmWorkForm.SwitchItemClick(Message: TMessage);
var
  I: Integer;
begin
  if Assigned(PopUpMenu) then
    for I:= 0 to PopUpMenu.Items.Count-1 do
      if I+1= Message.wParam then PopUpMenu.Items[I].Checked:= true
      else PopUpMenu.Items[I].Checked:= false;
end;//SwitchItemClick

procedure TfmWorkForm.PopItemClick(Sender: TObject);
var
  DontReplicate: bool;
begin
  DontReplicate:= false;
  if (TWStyle(TMenuItem(Sender).MenuIndex)= wsAdd) and
     (dsCurrent.DataSet.Tag and REPLICATE_INSERT_FLAG=REPLICATE_INSERT_FLAG) then
  begin
    dsCurrent.Dataset.Tag:= dsCurrent.DataSet.Tag xor REPLICATE_INSERT_FLAG;
    DontReplicate:= true;
  end;
  Perform(UM_CHANGEMODE,Ws2Instruc(TWStyle(TMenuItem(Sender).MenuIndex)),0);
  if DontReplicate then
    dsCurrent.Dataset.Tag:= dsCurrent.DataSet.Tag or REPLICATE_INSERT_FLAG;
end;//PopItemClick

procedure TfmWorkForm.FormDestroy(Sender: TObject);
begin
  inherited;
  ReverseFormats;
  FmtList.Free;
  //(dsCurrent.DataSet as TOracleDataSet).OracleDictionary.EnforceConstraints:= true;
  if Assigned(FCallBackWin) and
     not (csDestroying in FCallBackWin.ComponentState) then
    FCallBackWin.Perform(UM_OTHERS,IN_CLOSE,0);
  if FormStyle= fsMDIChild then
  begin
    Application.MainForm.Perform(UM_OTHERS,IN_CLOSE,0);
    Application.MainForm.Perform(UM_OTHERS,IN_NAVIGATOR,0);
    Application.MainForm.Perform(UM_OTHERS,IN_DIRECTLIST,0);
  end;
end;//FormDestroy

procedure TfmWorkForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
 {if (dsCurrent.DataSet is TVASUPQuery) and
    (dsCurrent.DataSet as TVASUPQuery).IsQuery then
      (dsCurrent.DataSet as TVASUPQuery).CloseViSession
 else dsCurrent.DataSet.Cancel;}
  if dsCurrent.DataSet is TVASUPQuery then
    TVASUPQuery(dsCurrent.DataSet).WorkState := wsView
  else
    dsCurrent.DataSet.Cancel;
  Action:= caFree;
end;//FormClose

procedure TfmWorkForm.GetData(ADataSet:TDataSet;STYLEPARAM: Integer);
var
  I,J:Integer;
  PropInfo: PPropInfo;
  PropValue: Pointer;
  Flag: bool;
  AreaList: TList;
  WorkArea: TComponent;
begin
  Flag:= STYLEPARAM in [IN_VIEW,IN_DELETE];
  AreaList:= TList.Create;
  AreaList.Add(Self);
  for I:= 0 to ComponentCount-1 do
    if Components[I] is TFrame then
      AreaList.Add(Components[I]);
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
           and ( TDataSource(PropValue).DataSet
                 =ADataSet) then
        begin
          PropInfo:= GetPropInfo(Components[I].ClassInfo,'ReadOnly');
          if Assigned(PropInfo) then
            SetOrdProp(Components[I],PropInfo,
                       Integer( ((Components[I].Tag and CReadOnly=CReadOnly) or Flag)
                                and (STYLEPARAM<>IN_QUERY)
                                ) );
          if Components[I] is TVQryEdit then
            (Components[I] as TVQryEdit).Permission:= false
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
   AreaList.Free;
end;//GetData

procedure TfmWorkForm.OnStupidPress(_Sender: TObject; var Key:Char);
begin
  if not(Ord(Key) in [vk_Return,vk_Escape]) then OnStupidClick(_Sender);
end;//OnStupidPress

procedure TfmWorkForm.OnStupidClick(_Sender:TObject);
begin
  if (WorkStyle<>wsQuery) and Assigned(_Sender) then
  begin
    Beep;
    MessageDlg(NotEditMsg,mtWarning,[mbOk],0)
  end;
end;//OnStupidClick

procedure TfmWorkForm.ButtonClick(Sender: TObject);
begin
  if Sender=bbOk then
  begin
    if WorkStyle in [wsAdd, wsEdit] then
    begin
      if {OraclePerformance}SaveData then
        Close;
    end
    else
    begin
      if OraclePerformance then
        Close;
    end;
  end
  else
  begin
    if Sender = bbCancel then
      CancelData;
    Close;
  end;
end;//ButtonClick

function TfmWorkForm.NoDataInserting(DataSet:TDataSet):bool;
begin
  Result:= IsEmptyRecord(DataSet,[nil]);
end;

function TfmWorkForm.NeedToSave(DataSet:TDataSet):bool;
var
  I: Integer;
begin
  if WorkStyle<> wsQuery then
  begin
    if DataSet is TVASUPQuery then
      Result := TVASUPQuery(DataSet).DataModified
    else
    begin
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
        dsInsert: Result:= not NoDataInserting(DataSet);
        else Result:= false;
      end;
    end;
  end
  else Result:= false;
end;

function TfmWorkForm.GetQuestionAtSaving : String;
begin
  Result := CFormChange;
end;

function TfmWorkForm.AskToSaveData: TSelection;
var
  select : Word;
begin
  Result := Saved;
  if Saved = sOther then
  begin
    select := MessageDlg( GetQuestionAtSaving,
                          mtConfirmation,[mbYes, {mbYesToAll,} mbNo, {mbNoToAll,} mbCancel],0);
    case select of
      mrYesToAll : begin
                     FSaved  := sYes;
                     Result := sYes;
                   end;
      mrNoToAll  : begin
                     FSaved  := sNo;
                     Result := sNo;
                   end;
      mrYes      : Result := sYes;
      mrNo       : Result := sNo;
    end;
  end;
end;

{var
  select : Word;
begin
  Result:= true;
  if NeedToSave(dsCurrent.DataSet) then
  begin
    Result:= false;

    if FSaved = sOther then
    begin
      select := MessageDlg( GetDataChangeText
                          ,mtConfirmation,[mbYes, mbYesToAll, mbNo, mbNoToAll, mbCancel],0);
      case select of
        mrYesToAll : FSaved := sYes;
        mrNoToAll  : FSaved := sNo;
      end;
    end
    else
      select := mrCancel;

    if (FSaved = sYes) or (select = mrYes) then
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
    else if (FSaved = sNo) or (select = mrNo) then
    begin
        dsCurrent.DataSet.Cancel;
        Result:= true;
    end;
  end;
end;}

procedure TfmWorkForm.RepaintNaviBtn(DataSet: TDataSet);
var
  WorkMode: TWStyle;
begin
  {if DataSet is TVASUPQuery then
     WorkMode:= (DataSet as TVASUPQuery).WorkState
  else }WorkMode:= WorkStyle;
  case WorkMode of
    wsQuery:
    begin
      bbNext.Visible:= true;
      bbPrior.Visible:= true;
      bbPrior.Hint:= 'предыдущий запрос|Перейти к предыдущему запросу';
      bbNext.Hint:= 'следующий запрос|Перейти к следующему запросу';
      if DataSet is TVASUPQuery then
      with (DataSet as TVASUPQuery) do
      begin
        bbPrior.Enabled:= not BOQ{ or (IndexQuery>=0)};
        bbNext.Enabled:= true;
      end;
    end;
    wsEdit,wsView,wsDelete:
    begin
      bbNext.Visible:= true;
      bbPrior.Visible:= true;
      bbNext.Hint:= 'следующая запись|Перейти к следующей записи';
      bbPrior.Hint:= 'предыдущая запись|Перейти к предыдущей записи';
      bbPrior.Enabled:= Assigned(DataSet) and not DataSet.BOF;
      bbNext.Enabled:= Assigned(DataSet) and not DataSet.EOF;
    end;
  end;
end;

procedure TfmWorkForm.RepaintAllBtn;
begin
  case WorkStyle of
    wsAdd:
    begin
      bbOk.Visible:= true;
      bbCancel.Visible:= true;
      bbView.Visible:= false;
      bbNext.Visible:= true;
      bbNext.Enabled:= true;
      bbNext.Hint:= 'следующая запись|Перейти к следующей записи';
      bbPrior.Visible:= false;
    end;
    wsEdit:
    begin
      bbOk.Visible:= true;
      bbCancel.Visible:= true;
      bbView.Visible:= false;
      bbNext.Visible:= true;
      bbNext.Hint:= 'следующая запись|Перейти к следующей записи';
      bbPrior.Visible:= true;
      bbPrior.Hint:= 'предыдущая запись|Перейти к предыдущей записи';
    end;
    wsDelete:
    begin
      bbOk.Visible:= true;
      bbCancel.Visible:= true;
      bbView.Visible:= false;
      bbNext.Visible:= true;
      bbPrior.Visible:= true;
    end;
    wsView:
    begin
      bbOk.Visible:= false;
      bbCancel.Visible:= false;
      bbView.Visible:= true;
      bbNext.Visible:= true;
      bbNext.Hint:= 'следующая запись|Перейти к следующей записи';
      bbPrior.Visible:= true;
      bbPrior.Hint:= 'предыдущая запись|Перейти к предыдущей записи';
    end;
    wsQuery:
    begin
      bbOk.Visible:= true;
      bbCancel.Visible:= true;
      bbView.Visible:= false;
    end;
  end;
  RepaintNaviBtn(FdsNavi.DataSet);
end;

procedure TfmWorkForm.FormShow(Sender: TObject);
begin
  inherited;
  RestoreRollPanels;
  SetPopItems;
  SetActCtrl;
  if ShowSQLDescriptForm then ShowSQLDescription;
end;//FormShow

procedure TfmWorkForm.UMChangeMode(var Message:TMessage);
var
  DuplVal: Variant;
  I: Integer;
begin
  inc(FChangingModeCount);
  try
    try
      //inherited;
      ReverseFormats;
      //(dsCurrent.DataSet as TOracleDataSet).OracleDictionary.EnforceConstraints:=
      //  Message.wParam<>IN_QUERY;
      if  (dsCurrent.State in [dsInsert, dsEdit])
           and (Message.wParam<>IN_QUERY) then dsCurrent.DataSet.Cancel;
      {if Message.wParam<>IN_QUERY then
      begin
        if (WorkStyle=wsQuery) and (dsCurrent.DataSet is TVASUPQuery) and
        (dsCurrent.DataSet as TVASUPQuery).IsQuery then
          (dsCurrent.DataSet as TVASUPQuery).CloseViSession;
        GetData(dsCurrent.DataSet,Message.wParam);
      end;}
      case Message.wParam of
        IN_INSERT:
        begin
          if dsCurrent.DataSet.Tag and DUPLICATE_INSERT_FLAG=DUPLICATE_INSERT_FLAG
          then
          begin
            if dsCurrent.DataSet is TVASUPQuery then
              TVASUPQuery(dsCurrent.DataSet).WorkState := wsView
            else
              dsCurrent.DataSet.Cancel;
            DuplVal:= VarArrayCreate([0,dsCurrent.DataSet.FieldCount-1],varVariant);
            for I:= 0 to dsCurrent.DataSet.FieldCount-1 do
              DuplVal[I]:= dsCurrent.DataSet.Fields[I].Value;
          end;
          //dsCurrent.DataSet.Insert;
          if dsCurrent.DataSet is TVASUPQuery then
            TVASUPQuery(dsCurrent.DataSet).WorkState := wsAdd
          else
            dsCurrent.DataSet.Insert;
          if dsCurrent.DataSet.Tag and DUPLICATE_INSERT_FLAG=DUPLICATE_INSERT_FLAG
          then
          begin
            for I:= 0 to dsCurrent.DataSet.FieldCount-1 do
              if not VarIsNull(DuplVal[I]) and not VarIsEmpty(DuplVal[I])
                 and (dsCurrent.DataSet.Fields[I].Tag and DUPLICATE_VALUE_TAG=
                      DUPLICATE_VALUE_TAG)
              then
                dsCurrent.DataSet.Fields[I].Value:= DuplVal[I];
          end;
          ActiveControl:= nil;
        end;
        IN_EDIT:
        try
          //dsCurrent.DataSet.Edit;
          if dsCurrent.DataSet is TVASUPQuery then
            TVASUPQuery(dsCurrent.DataSet).WorkState := wsEdit
          else
            dsCurrent.DataSet.Edit;
          if Assigned(ActiveControl)
             and not ActiveControl.Enabled then
             ActiveControl:= nil;
        except
          on E:Exception do
             MessageDlg(E.Message,mtError,[mbOk],0);
        end;
        IN_QUERY:
        begin
          if dsCurrent.DataSet is TVASUPQuery then
          begin
            with (dsCurrent.DataSet as TVASUPQuery) do
              if (aqQuerying in AccessLevel) and not IsQuery then
              begin
                //if dsCurrent.State in [dsInsert, dsEdit] then
                //  dsCurrent.DataSet.Cancel;
                //OracleDictionary.EnforceConstraints:= false;
                //WorkSpace:= Self;
                GetData(dsCurrent.DataSet,Message.wParam);
                //OpenViSession;
                WorkState := wsQuery;
              end;
            if FWStyle<>Msg2Ws(Message.wParam) then CopyFormats;
            ResetCurrBookmarkOfDataSet;
          end;
        end
        else
          if dsCurrent.DataSet is TVASUPQuery then
            TVASUPQuery(dsCurrent.DataSet).WorkState := Msg2Ws(Message.wParam);
      end;//case
      if Message.wParam<>IN_QUERY then
        GetData(dsCurrent.DataSet,Message.wParam);

      ChangeWorkStyle(Message);
    except
      on ECursorCanNotMoveAboutRecord do; // Пропускаем ошибку ECursorCanNotMoveAboutRecord
                                        // Эта ошибка возникает за того,
                                        // что запрещено перемещаться по записям
    end;
  finally
    dec(FChangingModeCount);
    CheckWorkStyle(Message);
  end;
end;//UMChangeMode

procedure TfmWorkForm.ChangeWorkStyle(var Message:TMessage);
begin
  FWStyle:= Msg2Ws(Message.wParam);
  SwitchItemClick(Message);
  Caption:= StyleToText(Message);
  if Visible then SetActCtrl;
  if Assigned(FCallBackWin) then
    FCallBackWin.Perform(UM_CHANGEMODE,Message.wParam,MS_CALLBACK);
  //if dsCurrent.DataSet is TVASUPQuery then
  //   (dsCurrent.DataSet as TVASUPQuery).WorkState:= FWStyle;
  RepaintAllBtn;
  if Message.WParam= IN_DELETE then ActiveControl:= bbOk;
  if (Application.MainForm.ActiveMDIChild=Self) or
     (Assigned(FCallBackWin) and (Application.MainForm.ActiveMDIChild=FCallBackWin)) then
    Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
end;//ChangeWorkStyle

procedure TfmWorkForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (ActiveControl is TRxDBLookUpCombo) and
     not (ActiveControl is TDBLookUpComboBox) then
  case Key of
    VK_UP: if bbPrior.Enabled then NavigatorClick(bbPrior);
    VK_DOWN: if bbNext.Enabled then NavigatorClick(bbNext);
    VK_RETURN:
    begin
      Key:= 0;
      if Assigned(ActiveControl) then
      begin
        ActiveControl.Perform(CM_EXIT,0,0);
        ActiveControl.Perform(CM_ENTER,0,0);
      end;
      if bbOk.Enabled then bbOk.Click;
    end;
    else inherited;
  end;//case
  if (Key=VK_F2) and (Shift=[]) and bbOk.Enabled and bbOk.Visible then bbOk.Click
  else if (Key=VK_F10) and (Shift=[ssAlt]) then bbCancel.Click;
end;//FormKeyDown

procedure TfmWorkForm.QuickJump(_Sender:TObject);
begin
  if _Sender is TVQryEdit then with _Sender as TVQryEdit do
    if Focused and Modified and (Length(Text)=MaxLength) then
      SendMessage(Handle,CN_KEYDOWN,VK_TAB,0);
end;//QuickJump

procedure TfmWorkForm.UMOthers(var Message:TMessage);
begin
  if (Message.wParam<>IN_ACTIVATE) then
  case Message.wParam of
    IN_GETDATASET:
    begin
      inherited;
      Message.lParam:= Integer(FdsNavi.DataSet);
    end;
    IN_STATUS:
    begin
      inherited;
      if Assigned(FCallBackWin) then
        FCallBackWin.Perform(UM_OTHERS,IN_SETRECORDCOUNT,DataCount);
    end;
    IN_QUIT:Close;
    IN_PAGEUP,IN_PRIOR,
    IN_NEXT,IN_PAGEDN: if Assigned(FCallBackWin) then
        FCallBackWin.Perform(UM_OTHERS,Message.wParam,Message.lParam);
    IN_EXECQUERY: if FWStyle= wsQuery then ButtonClick(bbOk);
    else inherited;
  end
  else if FormStyle=fsMDIChild then
  begin
    inherited;
    Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
  end;
end;//UMOthers

var
  NavigatorClicking: boolean;

procedure TfmWorkForm.NavigatorClick(_Sender: TObject; ADataSet : TDataSet);
var
  ds : TDataSet;
begin
  if (not NavigatorClicking)  then
  begin
    if Assigned(ActiveControl) then
    begin
      ActiveControl.Perform(CM_EXIT,0,0);
      ActiveControl.Perform(CM_ENTER,0,0);
    end;
      try
        StartTimer:= true;
        NavigatorClicking:= true;
        try
          with FdsNavi do
          begin
            if Assigned(ADataSet) then
              ds := ADataSet
            else
              ds := DataSet;
            if not (WorkStyle=wsQuery) then
            begin
              if Descander(_Sender,bbPrior) then ds.Prior
              else if Descander(_Sender,bbNext) then ds.Next;
            end
            else with (DataSet as TVASUPQuery) do
            begin
              if Descander(_Sender,bbPrior) then PriorViQuery
              else if Descander(_Sender,bbNext) then NextViQuery;
              if ShowSQLDescriptForm then ShowSQLDescription;
              if not Assigned(fdsNavi) then RepaintNaviBtn(dsCurrent.DataSet)
              else RepaintNaviBtn(FdsNavi.DataSet)
            end;
          end;
        except
          on ECursorCanNotMoveAboutRecord do; // Пропускаем ошибку ECursorCanNotMoveAboutRecord
                                              // Эта ошибка возникает за того,
                                              // что запрещено перемещаться по записям
        end;
      finally
        NavigatorClicking:= False;
      end;
  end;
end;//NavigatorClick

procedure TfmWorkForm.NavigatorClick(_Sender: TObject);
begin
  NavigatorClick(_Sender, nil);
end;//NavigatorClick

procedure TfmWorkForm.StartLongClick(_Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
begin
  StartTimer:= false;
  if WorkStyle<>wsAdd then
    BeginRepeatCycle(_Sender as TComponent,ClickDelay,NavigatorClick);
end;

procedure TfmWorkForm.FinishLongClick(_Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
begin
  if not StartTimer and (WorkStyle<>wsAdd) then NavigatorClick(_Sender);
  StartTimer:= false;
  EndRepeatCycle;
end;

procedure TfmWorkForm.ModeSwitchPopup(Sender: TObject);
begin
  with (Application.MainForm as TfmMainMenu),(Sender as TPopUpMenu) do
  begin
    Items[Ord(wsAdd)].Enabled:= sbAdd.Enabled;
    Items[Ord(wsEdit)].Enabled:= sbEdit.Enabled;
    Items[Ord(wsDelete)].Enabled:= sbDelete.Enabled;
    Items[Ord(wsView)].Enabled:= sbView.Enabled;
    Items[Ord(wsQuery)].Enabled:= sbQuery.Enabled;
  end;
  PopUpMenu:= Sender as TPopUpMenu;
end;

procedure TfmWorkForm.UMInitialize;
begin
  case Message.wParam of
    IN_SETDATASET:
    begin
      if dsCurrent.DataSet<> TDataSet(Message.lParam) then
        dsCurrent.DataSet:= TDataSet(Message.lParam);
      SearchingTable:= (dsCurrent.DataSet as TOracleDataSet).UpdatingTable;
    end;
    IN_SETCALLBACKWIN: FCallBackWin:= TWinControl(Message.lParam);
  end;//case
end;//UMInitialize

function TfmWorkForm.GetFreeCode(const AFieldName: string):string;
var
  OraQuery: TOracleQuery;
  MasterBit,MasterText :string;
  DetailText,DetailBit: string;

function PlusAND(const Value:string):string;
begin
  if not FIncMaster or (Length(Value)=0) then Result:= ''
  else Result:= Concat(' AND ',Value)
end;

begin
  with dsCurrent.DataSet as TVASUPQuery do
    if FNeedFreeCode and ( not FIncMaster or
    (Assigned(Master) or (Length(MasterFields)=0))
    ) then
    begin
      OraQuery:= TOracleQuery.Create(Self);
      OraQuery.Session:= Session;
      OraQuery.SQL.Text:= Format('SELECT NVL(MIN(Z.%s),0)+1 RES FROM %S Z WHERE EXISTS(SELECT A.%0:S FROM %S A WHERE A.%0:S=1 %2:S) AND NOT EXISTS(SELECT A.%0:S FROM %S A WHERE A.%0:S=Z.%0:S+1 %2:S )',
        [AFieldName,SearchingTable,PlusAND(MasterLinkText)]);
      if FIncMaster and Assigned(Master) and Master.Active then
      begin
        MasterText:= MasterFields;
        DetailText:= DetailFields;
        Cut(';',MasterText,MasterBit);
        Cut(';',DetailText,DetailBit);
        while MasterBit<>'' do
        begin
          OraQuery.DeclareVariable(DetailBit,otInteger);
          OraQuery.SetVariable(DetailBit,Master.FieldByName(MasterBit).Value);
          Cut(';',MasterText,MasterBit);
          Cut(';',DetailText,DetailBit);
        end;
      end;
      OraQuery.Execute;
      Result:= OraQuery.FieldAsString(0);
      OraQuery.Close;
      OraQuery.Free;
    end
    else Result:= '';
end;//GetFreeCode

procedure TfmWorkForm.DateEditChange(_Sender: TObject);
begin
  with _Sender as TVDBEDate do
  if ((Text=EmptyDateShortText) or (Text=EmptyDateLongText)) and Modified then
  begin
    Modified:= false;
    Field.Clear;
  end;
end;

procedure TfmWorkForm.NormDateEditChange(_Sender: TObject);
begin
  with _Sender as TVDBEDate do
  if (Text=EmptyNormDateText) and Modified then
  begin
    Modified:= false;
    Field.Clear;
  end;
end;

procedure TfmWorkForm.WarningOnPress(_Sender: TObject; var Key:Char);
begin
  if (_Sender is TVQryEdit) then
  with _Sender as TVQryEdit do
    if (SelLength=0) and (Length(Text)=MaxLength) and not(Ord(Key) in [ vk_Return,vk_Escape,vk_Next,
                       vk_Prior,vk_Up,vk_Down,vk_Back]) then
      MessageBeep(0);
end;

procedure TfmWorkForm.FormActivate(Sender: TObject);
begin
  inherited;
  Application.HintHidePause:= High(Integer);
  Application.HintPause:= WORKTIME_HINT_PAUSE;
end;

procedure TfmWorkForm.FormDeactivate(Sender: TObject);
begin
  Application.HintHidePause:= DEFAULT_HINT_HIDE_PAUSE;
  Application.HintPause:= DEFAULT_HINT_PAUSE;
end;

procedure TfmWorkForm.bbNextClick(Sender: TObject);
begin
  if WorkStyle=wsAdd then
    NavigatorClick(Sender);
end;

function TfmWorkForm.DoEnForcePost: bool;
begin
  Result:= False;
end;

procedure TfmWorkForm.StandardWEButtonClick(Sender: TObject;
  var UseInherited: Boolean);
begin
  UseInherited:= true;
  with Sender as TVWatchEdit do
  begin
    SetFocus;
    StandardWeakMasterSupport(Sender as TVWatchEdit);
  end;
end;

procedure TfmWorkForm.SetHighLightReqField(AValue:boolean);
begin
  if AValue and not FHighLightReqField then
    SetHighLighting;
  FHighLightReqField:= AValue;
end;

procedure TfmWorkForm.SetHighLighting;
var
  I: Integer;
  FieldName: string;
  edField: TField;
  PropInfo: PPropInfo;
begin
  for I:=0 to ComponentCount-1 do
    if Components[I] is TCustomEdit then
      with Components[I] as TCustomEdit do
      begin
        PropInfo:= GetPropInfo(ClassInfo,'DataField');
        if Assigned(PropInfo) then
        begin
          FieldName:= GetStrProp(Self.Components[I],PropInfo);
          PropInfo:= GetPropInfo(ClassInfo,'DataSource');
          if Assigned(PropInfo) and
            Assigned(TDataSource(GetOrdProp(Self.Components[I],PropInfo)).DataSet)
            then edField:=
            TDataSource(GetOrdProp(Self.Components[I],PropInfo)).DataSet.FindField(FieldName)
          else edField:= nil;
          if Assigned(edField) and edField.Required then
            Color:= FHighLightFieldColor;
        end;
      end;
end;
{
function TfmWorkForm.GetShowSQLDescriptForm:bool;
begin
  Result:= fmSQLDescript.Visible;
end;

procedure TfmWorkForm.SetShowSQLDescriptForm(const Value: bool);
begin
  fmSQLDescript.Visible:= Value;
  if Value then ShowSQLDescription;
end;
}

procedure TfmWorkForm.ShowSQLDescription;
begin
  inherited;
  if ShowSQLDescriptForm then SetFocus;
end;

function TfmWorkForm.GetMainDataSetOfForm : TDataSet;
begin
  Result := dsCurrent.DataSet;
end;

function TfmWorkForm.GetInitASUPQueries : TArrayOfASUPQuery;
begin
  if dsCurrent.DataSet is TVASUPQuery then
  begin
    SetLength(Result, 1);
    Result[0] := TVASUPQuery(dsCurrent.DataSet);
  end
  else
    SetLength(Result, 0);
end;

procedure TfmWorkForm.ApplyDataSaves(Sender : TVASUPQuery);
begin
  if Sender = dsCurrent.DataSet then // и если текущий DataSet равняется Sender
  begin
    if (WorkStyle in [wsAdd, wsEdit]) // Данные могут быть изменены только в режиме добавления и редактирования
       and NeedToSave(dsCurrent.DataSet) then // если данные необходимо изменить
    begin
      case AskToSaveData of // спрашиваем сохранять изменять данных или нет
        sYes : SaveData;
               // Выполняем команду сохранить изменения данных
        sNo  : CancelData;    // Отменяем изменения данных
      end;
    end
    else
      CancelData;
  end;
end;

procedure TfmWorkForm.SaveChangeWorkState(Sender : TVASUPQuery);
begin
  if dsCurrent.DataSet = Sender then
  begin
    if Sender.DataModified then
      SaveData
    else
      CancelData;
  end
  else
    inherited SaveChangeWorkState(Sender);
end;

procedure TfmWorkForm.CancelChangeWorkState(Sender : TVASUPQuery);
begin
  if dsCurrent.DataSet = Sender then
  begin
    //if WorkStyle in [wsAdd, wsEdit] then
      CancelData
  end
  else
    inherited CancelChangeWorkState(Sender);
end;

function TfmWorkForm.SaveData : boolean;
begin
  if WorkStyle in [wsAdd, wsEdit] then
    Result := OraclePerformance
  else
    Result := false;

  // Сбрасываем признак, что в кэше хранятся изменения данных, которые не сохранены на сервере
  ResetCacheData; //!!! Данный код очень необходим для нормальной работы окна
  // Так как TVASUPQuery по техническим причинам не может самостоятельно сбрасывать этот признак,
  // то признак надо сбросить вручную
end;

procedure TfmWorkForm.CancelData;
begin
  if (WorkStyle in [wsAdd, wsEdit]) and (dsCurrent.DataSet.State in [dsInsert, dsEdit]) then
    dsCurrent.DataSet.Cancel;
end;

procedure TfmWorkForm.CheckBrowseMode(ASUPQuery: TVASUPQuery);
begin
  if (dsCurrent.DataSet = ASUPQuery)  // Проверяем метод вызвал активный DataSet окна или другой DataSet
     and (not FScrolling) // Проверяем не перемещаем ли сейчас курсор к другой записи
     // Если сейчас перемещаем курсор, то режим окна может не соответствовать режиму,
     // который был до начала перемещения курсора, поэтом не надо сохранять режим окна
     // Если сейчас не перемещаем курсор, то возможно данный метод вызван перед перемещением курсора
     // поэтом необходимо запомнить режим окна
     and (not ASUPQuery.Cancelling) and (not ASUPQuery.Posting)
                                              then
  begin
    FWorkStyleBeforeChCurrsor   := WorkStyle;
    FWorkStateAQBeforeChCurrsor := ASUPQuery.WorkState;
    FDataSetOfChangedCurrsor := ASUPQuery;
  end;
end;

procedure TfmWorkForm.DoAfterScroll(ASUPQuery: TVASUPQuery);
begin
  //if FAfterScrolling then
  //  Exit;
  if (dsCurrent.DataSet = ASUPQuery) and (not ASUPQuery.IsQuery) and (FChangingModeCount = 0)
      and (not ASUPQuery.Cancelling) and (not ASUPQuery.Posting) {and FScrolling} then
    try
      //FAfterScrolling := true;
      if (FWorkStyleBeforeChCurrsor in [wsAdd, wsEdit, wsDelete]) and
         (FDataSetOfChangedCurrsor = ASUPQuery)
         then
      { В режиме редактирования данных, при перемещения курсора на другую запись,
        DataSet-ы(при этом окно, могло остатся в прежнем режиме)
        переключится на режим просмтра (при этом окно, может остатся в прежнем режиме).

        Переключаемся в прежний режим }
        try
          if not FAfterScrolling then
          try
            FAfterScrolling := true;
            if WorkStyle <> FWorkStyleBeforeChCurrsor then
              // Возвращаем окну режим, который был до перемещения курсора
              WorkStyle := FWorkStyleBeforeChCurrsor
            else
              // Возвращаем ASUPQuery режим, который был до перемещения курсора
              ASUPQuery.WorkState := FWorkStateAQBeforeChCurrsor;
          finally
            FAfterScrolling := false;
          end;
        finally
          CheckWorkStyle;
        end;
    finally
    //  FAfterScrolling := false;
      FScrolling := false;
    end;
end;

procedure TfmWorkForm.DoBeforeScroll(ASUPQuery: TVASUPQuery);
begin
  if (dsCurrent.DataSet = ASUPQuery) and (not ASUPQuery.Cancelling)
     and (not ASUPQuery.Posting)
     and (not ASUPQuery.IsQuery) and (FChangingModeCount = 0) then

    FScrolling := true; // Перемещаем курсор от одной записи к другой

end;

procedure TfmWorkForm.CheckWorkStyle(Message:TMessage);
//var
//  WParam : Integer;
begin
  if (dsCurrent.DataSet is TVASUPQuery) and (not FCheckingWorkStyle)  then
  begin
    FCheckingWorkStyle := true;
    try
      with dsCurrent.DataSet as TVASUPQuery do
        if Self.WorkStyle <> WorkState then
        begin
//          WParam := Message.WParam;
          Message.WParam := Ws2Instruc(WorkState);
          ChangeWorkStyle(Message);
//          Message.WParam := WParam;
        end;
    finally
      FCheckingWorkStyle := false;
    end;
  end;
end;

procedure TfmWorkForm.CheckWorkStyle;
begin
  if (dsCurrent.DataSet is TVASUPQuery) and (not FCheckingWorkStyle)  then
  begin
    FCheckingWorkStyle := true;
    try
      with dsCurrent.DataSet as TVASUPQuery do
        if Self.WorkStyle <> WorkState then
        begin
          Self.WorkStyle := WorkState;
        end;
    finally
      FCheckingWorkStyle := false;
    end;
  end;
end;

procedure TfmWorkForm.ResetCacheData;
begin
  if dsCurrent.DataSet is TVASUPQuery then
  begin
    // Сбрасываем признак, что в кэше dsCurrent.DataSet хранятся изменения данных,
    // которые не сохранены на сервере
    TVASUPQuery(dsCurrent.DataSet).ResetCacheDataChanged;
     //!!! Данный код очень нужен,
                                                         // для нормальной работы окна
    // Сбрасываем признак, что в кэше детейлов dsCurrent.DataSet хранятся изменения данных,
    // которые не сохранены на сервере
    TVASUPQuery(dsCurrent.DataSet).ResetDetailCacheDataChanged;
    //!!! Данный код очень нужен,
                                                         // для нормальной работы окна
    // Так как TVASUPQuery по техническим причинам не может самостоятельно сбрасывать флажок,
    // который отвечает за то что, есть ли в кэше не сохраненные изменения данных,
    // то его надо сбросить вручную
  end;
end;



function TfmWorkForm.ContextPopup(Sender : TwinControl; APos: TPoint) : boolean;
var
  comp : TComponent;
  pt : TPoint;
  p : Tpoint;
  pc : TComponent;
begin
  pt := Sender.ClientToScreen(Apos);
  comp := Sender.ControlAtPos(Apos, true, true);
  p := apos;
  pc := Sender;
  while Assigned(comp) and (comp is TWinControl) do
  begin
    p := TWinControl(pc).ClientToScreen(p);
    p := TWinControl(comp).ScreenToClient(p);
    pc := comp;
    comp := TWinControl(comp).ControlAtPos(p, true, true);
  end;
  comp := pc;
  if Assigned(comp) and (comp is TCustomEdit) then
  begin
    FPopupEdit := TCustomEdit(comp);
    FPopupMenu.PopupComponent := comp;//Sender;
    FPopupMenu.Popup(Pt.X, Pt.Y);
    Result := true;
  end
  else
    Result := false;
end;



procedure TfmWorkForm.FormContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  inherited;
  Handled := ContextPopup(TWinControl(Sender), MousePos);
end;

initialization
  NavigatorClicking:= false;
end.
