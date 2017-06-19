unit MENUGnrl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_ANYFORM, Menus, ExtCtrls ,vdbASUP,vWorkform, Buttons, DB,StdCtrls,v_Child,
  ComCtrls, ToolWin,v_utils, TB97Ctls, ImgList, ComObj, Mask, Math, fCoping,
  syncobjs, v_fastmod, frxClass, frxDesgn, Variants, VCLFixes;

const
  AppCaption= 'НИОКР';
  ConfirmExitMsg= 'Вы уверены, что хотите покинуть программу';

  AutoPageBreak : LongInt = -4105; // Признак Автоматического разрыва странице в документе Excel

type
  FArrayOfVariant = array of Variant;

  TfmMainMenu = class(TfmAnyForm)
    mmGeneral: TMainMenu;
    hpWindows: TMenuItem;
    vpCascade: TMenuItem;
    vpTileHor: TMenuItem;
    vpPrior: TMenuItem;
    vpNext: TMenuItem;
    vpCloser: TMenuItem;
    vpAll: TMenuItem;
    vpOne: TMenuItem;
    vpIcon: TMenuItem;
    vpTileVer: TMenuItem;
    dsGlobal: TDataSource;
    hpFile: TMenuItem;
    vpQuery: TMenuItem;
    vpAdd: TMenuItem;
    vpEdit: TMenuItem;
    vpDelete: TMenuItem;
    vpView: TMenuItem;
    vpSort: TMenuItem;
    vpPrint: TMenuItem;
    vpExit: TMenuItem;
    vpPriorLevel: TMenuItem;
    vpNextLevel: TMenuItem;
    sbMain: TStatusBar;
    vpBlank: TMenuItem;
    vpEnd: TMenuItem;
    DirectPopupMenu: TPopupMenu;
    CoolBar: TCoolBar;
    tbMain: TToolBar;
    ilMainBarHot: TImageList;
    ilMainBar: TImageList;
    ilNavBar: TImageList;
    ilNavBarHot: TImageList;
    sbQuery: TToolButton;
    sbView: TToolButton;
    sbAdd: TToolButton;
    sbEdit: TToolButton;
    sbDelete: TToolButton;
    sbPageDown: TToolButton;
    sbNext: TToolButton;
    sbPrior: TToolButton;
    sbPageUp: TToolButton;
    sbExit: TToolButton;
    sbSort: TToolButton;
    sbRefresh: TToolButton;
    sbPrint: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    sbHelp: TToolButton;
    hpSprav: TMenuItem;
    vpRefresh: TMenuItem;
    ilMainBarDiz: TImageList;
    ilNavBarDiz: TImageList;
    MainProgressBar: TProgressBar;
    vpSeparator: TMenuItem;
    vpSaveState: TMenuItem;
    hpReport: TMenuItem;
    hpHelp: TMenuItem;
    vpContent: TMenuItem;
    vpHelpSep: TMenuItem;
    vpAbout: TMenuItem;
    vpChapter: TMenuItem;
    vpCurrency: TMenuItem;
    vpChemaS: TMenuItem;
    vpFirm: TMenuItem;
    vpPayMethods: TMenuItem;
    vpIstFin: TMenuItem;
    vpAnnul: TMenuItem;
    vpPayment: TMenuItem;
    hpDocuments: TMenuItem;
    vpTreaty: TMenuItem;
    hpOperations: TMenuItem;
    vpClose: TMenuItem;
    vpNoClose: TMenuItem;
    vpOperationsSep1: TMenuItem;
    vpAnnulment: TMenuItem;
    vpNoAnnulment: TMenuItem;
    vpPrintLetter: TMenuItem;
    vpOperationsSep2: TMenuItem;
    sbPriorLevel: TToolButton;
    ToolButton2: TToolButton;
    sbNextLevel: TToolButton;
    ToolButton6: TToolButton;
    sbDirectList: TToolbarButton97;
    vpRepTrMonth: TMenuItem;
    vpTrConcern: TMenuItem;
    vpRN01: TMenuItem;
    vpRN02: TMenuItem;
    vpRepTrList: TMenuItem;
    vpRN03: TMenuItem;
    vpRN04: TMenuItem;
    vpRepTrPay: TMenuItem;
    vpRN06: TMenuItem;
    vpRN05: TMenuItem;
    vpCurators: TMenuItem;
    vpFullCurators: TMenuItem;
    vpCurator: TMenuItem;
    vpRepTYear: TMenuItem;
    vpRN07: TMenuItem;
    vpRN08: TMenuItem;
    vpFin: TMenuItem;
    vpMonthFin: TMenuItem;
    vpYearFin: TMenuItem;
    vpRN09: TMenuItem;
    vpRN10: TMenuItem;
    vpRN11: TMenuItem;
    vpRN12: TMenuItem;
    vpUnexecuted: TMenuItem;
    vpExecuted: TMenuItem;
    vpSubjectTreaty: TMenuItem;
    vpRN15: TMenuItem;
    vpRN16: TMenuItem;
    vpEconomicParameter: TMenuItem;
    vpExpectedIncome: TMenuItem;
    vpRN17: TMenuItem;
    vpRN18: TMenuItem;
    vpClosedTreaty: TMenuItem;
    vpRN19: TMenuItem;
    vpRN20: TMenuItem;
    vpOperationsSep3: TMenuItem;
    vpSubjectToTreaty: TMenuItem;
    vpTreatyToSubject: TMenuItem;
    vpArticle: TMenuItem;
    vpRN21: TMenuItem;
    vpRN22: TMenuItem;
    vpRepConc: TMenuItem;
    vpCuratorPlan: TMenuItem;
    vpExchange: TMenuItem;
    vpRN01_Concrn: TMenuItem;
    vpPayment_1: TMenuItem;
    vpRepPay: TMenuItem;
    vpPayment_2: TMenuItem;
    vpPayment_3: TMenuItem;
    vpPrintFrxLetter: TMenuItem;
    procedure vpCascadeClick(Sender: TObject);
    {Обработчик события OnClick опции меню Окно\Каскад.
    Располагает дочерние окна каскадом}

    procedure vpTileHorClick(Sender: TObject);
    {Обработчик события OnClick опции
     меню Окно\Мозаика горизонтальная.
     Располагает дочерние окна горизонтальной мозаикой}

    procedure vpPriorClick(Sender: TObject);
    {Обработчик события OnClick опции меню Окно\Следущее окно.
    Передает фокус ввода следущему окну}

    procedure vpNextClick(Sender: TObject);
    {Обработчик события OnClick опции меню Окно\Предыдущее окно.
    Передает фокус ввода предыдущему окну}

    procedure vpAllClick(Sender: TObject);
    {Обработчик события OnClick опции меню Окно\Закрыть\Все окна.
    Закрывает все дочерние окна}

    procedure vpOneClick(Sender: TObject);
    {Обработчик события OnClick опции меню Окно\Закрыть\Текущее окно.
    Закрывает текущее окно}

    procedure hpWindowsClick(Sender: TObject);
    {Обработчик события OnClick опции меню Окно.
    Настраивает все подчиненные опции}

    procedure vpIconClick(Sender: TObject);
    {Обработчик события OnClick опции меню Окно\Упорядочить ярлычки.
    Упорядочивает ярлычки минимизированных дочерних окон}

    procedure vpTileVerClick(Sender: TObject);
    {Обработчик события OnClick опции меню Окно\Мозаика вертикальная.
    Располагает дочерние окна вертикальной мозаикой}

    procedure dsGlobalDataChange(Sender: TObject; Field: TField);
    {Обработчик события OnDataChange
     компонента dsGlobal, нацеленного на DataSet
     текущего дочернего окна.
     DataSet определяется при помощи сообщения
     UM_OTHERS с lParam= IN_GETDATASET,
     посылаемого окну ActiveMDIChild.
     По свойству dsGlobal.DataSet настраивает
     кнопки панели инструментов}

    procedure FormCreate(Sender: TObject);
    {Обработчик события OnCreate. "Гасит" все кнопки
    на панели инструментов, а также настраивает свойства
    объекта Application}

    procedure ShowHint(Sender: TObject);
    {Обработчик события OnHint объекта Application.
    Отображает Application.Hint в статусбаре sbMain}

    procedure ToolBarClick(Sender: TObject);
    {Обработчик события OnClick следующих кнопок
    на панели инструментов(а также их дублеров-опций в меню):
    sbAdd,sbEdit,sbDelete,sbQuery,sbView,sbSort,sbPrint,
    sbExit,sbPriorLevel,sbNextLevel,sbRefresh}

    procedure vpEndClick(Sender: TObject);
    {Обработчик события OnClick опции Режим\Выход.
     Закрывает приложение}

    procedure PopUpItemClick(Sender: TObject);
    {Обработчик события OnClick опций всплывающего меню
     DirectPopupMenu, на которое нацелено
     свойство DropDownMenu кнопки sbDirectList.
     Посылает сообщение UM_OTHERS
     с lParam=IN_DIRECTMOVE и wParam=MenuIndex текущей опции
     дочернему окну ActiveMDIChild. Используется для открытий
     таблиц в линейном списке связанных таблиц,игнорируя связи.
     Чаще всего в свойствах Caption опций всплывающего меню DirectPopupMenu
     хранятся названия таблиц}

    procedure SleepToolBarClick(Sender: TObject);
    {Обработчик псевдособытия OnClick кнопок глобального
    навигатора: sbPageDown,sbNext,sbPrior,sbPageUp.
    Псевдособытие OnClick эмулируется процедурой StartLongClick,
    создавая эффект непрерывности}

    procedure StartLongClick(Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
    {Обработчик события OnMouseDown кнопок глобального
    навигатора: sbPageDown,sbNext,sbPrior,sbPageUp.
    Создает эффект непрерывности события OnClick,
    вызывая процедуру SleepToolBarClick}

    procedure FinishLongClick(Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
    {Обработчик события OnMouseUp кнопок глобального
    навигатора: sbPageDown,sbNext,sbPrior,sbPageUp.
    Завершает  непрерывный вызов события OnClick}

    procedure UserClick(Sender: TObject);
    {Обработчик события OnClick опций меню, связанных
    с пользователем: открытия таблиц,
    запуски процедур, отчетов и т.п.}

    procedure SubMenuClick(Sender: TObject);
    {Обработчик события OnClick опций меню, связанных
    с таблицами из линейного списка таблиц.
    Открывает таблицу, определяемую по свойству Caption опции}

    procedure FormDestroy(Sender: TObject);
    {Обработчик события OnDestroy.Выполняет подготовительные
    работы перед закрытием главной формы: закрывает все дочерние
    окна, все запущенные отчеты.}

    procedure FormShow(Sender: TObject);
    {Обработчик события OnShow. Настраивает опции меню,
    согласно правам, выданным пользователю}

    procedure vpSaveStateClick(Sender: TObject);
    {Обработчик события OnClick опции меню
    Штаты\Восстановление окладов и тарифов.
    Восстанавливает оклады и тарифы массива штатных расписаний до
    последнего повышения}

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    {Обработчик события OnCloseQuery. Вызывает диалог
    подтверждения закрытия приложения}

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    {Обработчик события OnClick опций меню:
    Отчеты\Штатное расписание служащих,
    Отчеты\Изменения в штатном расписании служащих,
    Отчеты\Штатное расписание рабочих,
    Отчеты\Изменения в штатном расписании рабочих.
    Вызывает форму для задания параметров отчета и
    его дальнейшего запуска}

    procedure vpContentClick(Sender: TObject);
    {Обработчик события OnClick подпунктов следующих
    опций меню:
    Отчеты\Статистика по штатным расписаниям служащих,
    Отчеты\Статистика по штатным расписаниям рабочих.
    Запускает отчет}

    procedure vpAboutClick(Sender: TObject);
    {Обработчик события OnClick опции меню ?\О программе.
    Вызывает диалоговое окно
    с дополнительной информацией о программе}

    procedure sbHelpClick(Sender: TObject);
    {Обработчик события OnTerminate для объектов типа TThread,
    следящих за окончанием формирования отчетов.
    При завершении формирования отчета снимает флажок с
    соответствующей опции меню(Checked:= false)}

    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    {Обрабочтик события OnMessage объекта Application.
     При необходимости убирает окно типа THintWindow,
     используемое для подсказок к ячейкам в сетке DBGrid
     дочернего окна}
    procedure vpFirmClick(Sender: TObject);
    procedure ChangeTreaty(Sender: TObject);
    procedure vpPrintLetterFRX(Sender: TObject);
    procedure vpPrintLetterClick(Sender: TObject);
    procedure vpPrintFrxLetterClick(Sender: TObject);
    procedure vpRN01RN02Click(Sender: TObject);
    procedure vpRN03RN04Click(Sender: TObject);
    procedure vpRN05RN06Click(Sender: TObject);
    procedure vpCuratorsClick(Sender: TObject);
    procedure vpCuratorClick(Sender: TObject);
    procedure vpRN0708Click(Sender: TObject);
    procedure vpRN09RN10(Sender: TObject);
    procedure vpRN11RN12(Sender: TObject);
    procedure vpUnexecutedClick(Sender: TObject);
    procedure vpExecutedClick(Sender: TObject);
    procedure vpSubjectTreatyClick(Sender: TObject);
    procedure vpRN17RN18Click(Sender: TObject);
    procedure vpRN19_20Click(Sender: TObject);
    procedure vpRN21RN22Click(Sender: TObject);
    procedure vpRepConcClick(Sender: TObject);
    procedure vpRN01_ConcrnClick(Sender: TObject);
    procedure vpPaymentClick(Sender: TObject);
    procedure PayClick(Sender: TObject);
  private

    // Форма для отбражение процесса формирования отчетов
    buildingReport : TFrmCoping;

    FSemaphore : THandle;

    procedure AddToStructure(MetaSrc: TVMetaDataSource;const Index: Integer;const DataSetName: string);
    {Создает объект типа TASUPQuery, нацеленый на справочник подразделений
    и добавляет его в список компонента dmGlobal.mdStruc,
    учитывая необходимые связи}

    procedure RebuildToolBar;
    {Перенастраивает кнопки на панели инструментов,
    в соответствии с правами доступа к таблице текущего окна, а
    также с положением текущей записи таблицы}

    procedure ToolDown;
    //"Гасит" все копки на панели инструментов

    procedure RebuildModeButtons;
    {Перенастраивает кнопки на панели инструментов,
    связанные с операциями над таблицей:
    sbQuery,sbView,sbAdd,sbEdit,sbDelete,
    в соответствии с правами доступа к таблице }

    procedure StateDataSetToStateModeButtons;
    {Изменяет состояние кнопок
    sbQuery,sbView,sbAdd,sbEdit,sbDelete
    в зависимости от состояния dsGlobal.DataSet}

    procedure UpModeButtons;
    {Присваеваем свойству Down у кнопок
    sbQuery,sbView,sbAdd,sbEdit,sbDelete
    значение false
    }

    procedure OnException (Sender: TObject; E: Exception);
    { Обработчик события обработки ошибки
    }

    function GetConcern_Treaty(ADate : TDateTime) : Integer;
    // Возвращает идентификатор рамочного договора
    // ADate - Дата отчета


    function GetTitle_PerecenDogovorov(AConcernID : Variant; ADate : TDateTime) : String;
    // Возвращает заголовок отчета перечня договоров
    // AConcernID - идентификатор рамочного договора,
    //              если нет договора, то параметру
    //              необходимо указать значение NULL
    // ADate      - дата отчета

    function GetNumDogInPerecenDogovorov(AConcernID : Variant; ADate : TDateTime;
                      AConcernFrom : TDateTime = 0; AConcernTo : TDateTime = 0) : TStrings;
    // Возвращает список номер договоров согласно ПЕРЕЧНЯ ДОГОВОРОВ
    // AConcernID - идентификатор рамочного договора,
    //              если нет договора, то параметру
    //              необходимо указать значение NULL
    // ADate      - дата отчета

    { Private declarations }

    procedure ShowDialogBox;
  protected
    { Protected declarations }
    procedure UMOthers(var Message : TMessage);message UM_OTHERS;
              {Перехват сообщения UM_OTHERS. Используется дочерними окнами
              приложения для передачи данных по настройке панели инструментов}

    procedure UMProgressUpdate(var Message : TMessage);message UM_PROGRESSUPDATE;
              {Перехват сообщения UM_PROGRESSUPDATE. Используется для отображения
              в MainProgressBar динамики формирования отчетов QuickReport}
  public
    { Public declarations }
    procedure ShowRecordCount;

    procedure SetBusy;
    procedure ResetBusy;
  end;

 TfmChildRef= class of TfmChild;

function GetChildWindow(MainWindow: TForm;WinSender: TObject):TForm;
{Возвращает первое дочернее окно у MDIParent-окна MainWindow,
 чей Sender совпадает с WinSender. Sender дочернего окна
 определяется посылкой сообщения UM_OTHERS с lParam=IN_GETSENDER}

function GetWinByType(MainWindow: TForm;WinType:TfmChildRef):TForm;
{Возвращает первое дочернее окно у MDIParent-окна MainWindow,
 имеющее тип WinType}

procedure GetWinListByType(MainWindow: TForm;WinList: TList;WinType:TfmChildRef);
{Возвращает список WinList всех дочерних окон
MDIParent-окна MainWindow, имеющих тип WinType}

procedure RemoveConflictWin;
{Удаляет дочернее окно у Application.MainForm, отображающее
справочник подразделений. Выполняется перед созданием
нового дочернего окна справочника подразделений}

procedure SetMDIFocus(MDIParent,MDIChild: TForm);
{Устанавливает фокус ввода на дочернем окне MDIChild
родительского окна MDIParent}

function FormChildWindow(ChildRef: TfmChildRef;ASender: TObject;DataSet: TVASUPQuery):TfmChild;
{Создает дочернее окно типа ChildRef,
нацеленное на Dataset и Sender равен ASender}

function Forming(ASender: TObject;DataSet: TVASUPQuery):TfmChild;
{Создает дочернее окно типа TfmExplorer,
нацеленное на Dataset, чей Sender равен ASender}

function FormingList(ASender: TObject;DataSetList: TDataSets):TfmChild;
{Создает дочернее окно типа TfmExplorer,
нацеленное на DatasetList и Sender равен ASender}

function FormingTypeList(ChildRef: TfmChildRef;ASender: TObject;DataSetList: TDataSets):TfmChild;
{Создает дочернее окно типа ChildRef,
нацеленное на DatasetList и Sender равен ASender}

function GetPrepositionalMonth(AMonth : Integer) : String;
{Возвращает название месяца в предложном падеже}

function SplitStr(SrcStr : String; var Margin : Integer; var NextPart : String) : String;
{Разбивает SrcStr на части, разбивает по первому пробелу в конце строки}

var
  fmMainMenu: TfmMainMenu;//Главная форма приложения
  UserName: string;
  //Имя пользователя, вытянутое Win API функцией GetUserName

  MDIChildAccessRights: TAccessLevel;
  //Права доступа к таблице текущего дочернего окна

  MultiHintWin: THintWindow;
  //Окно подсказки к ячейкам сетки DBGrid дочернего окна

implementation

uses Oracle,OracleData,Globals,v_krconsts,
v_dbform,v_explorer,
v_enter,vpodr,
registry,
about, v_edarch,
wfirm, treatycard, v_eyes,
pmonth, v_pyear, v_pyears, v_pquarter, repCurrotList, wtrconcern, PickConcernDog,
pmonthwithaddCol, THread, pmonth_from_to;


{$R *.DFM}

function GetPrepositionalMonth(AMonth : Integer) : String;
begin
  case AMonth of
  1  : Result := 'ЯНВАРЕ';
  2  : Result := 'ФЕВРАЛЕ';
  3  : Result := 'МАРТЕ';
  4  : Result := 'АПРЕЛЕ';
  5  : Result := 'МАЕ';
  6  : Result := 'ИЮНЕ';
  7  : Result := 'ИЮЛЕ';
  8  : Result := 'АВГУСТЕ';
  9  : Result := 'СЕНТЕБРЕ';
  10 : Result := 'ОКТЯБРЕ';
  11 : Result := 'НОЯБРЕ';
  12 : Result := 'ДЕКАБРЕ';
  else
    Result := '';
  end;
end;

function SplitStr(SrcStr : String; var Margin : Integer; var NextPart : String) : String;
begin
  While Copy(SrcStr,Margin,1) <> ' ' Do
        Margin := Margin - 1;
  Result := Copy(SrcStr,1,Margin-1);
  NextPart := Copy(SrcStr,Margin,Length(SrcStr));
end;

function FormChildWindow(ChildRef: TfmChildRef;ASender: TObject;DataSet: TVASUPQuery):TfmChild;
begin
  Screen.Cursor:= crSQLWait;
  Result:= ChildRef.Create(nil);
  with Result do
  begin
    SenderControl:= ASender;
    Perform(UM_INITIALIZE,IN_SETDATASET,Integer(DataSet));
    Perform(UM_OTHERS,IN_DIRECTMOVE,0);
  end;
  Screen.Cursor:= crDefault;
end;//FormChildWindow

procedure TfmMainMenu.vpCascadeClick(Sender: TObject);
begin
  inherited;
  Cascade;
end;

procedure TfmMainMenu.vpTileHorClick(Sender: TObject);
begin
  inherited;
  TileMode:= tbHorizontal;
  Tile;
end;

procedure TfmMainMenu.vpPriorClick(Sender: TObject);
begin
  inherited;
  Previous;
end;

procedure TfmMainMenu.vpNextClick(Sender: TObject);
begin
  inherited;
  Next;
end;

procedure TfmMainMenu.vpAllClick(Sender: TObject);
var
  I: Integer;
begin
  for I := MDIChildCount-1 downto 0 do
      MDIChildren[I].Close;
end;

procedure TfmMainMenu.vpOneClick(Sender: TObject);
begin
  inherited;
  ActiveMDIChild.Free;
end;

function GetChildWindow(MainWindow: TForm;WinSender: TObject):TForm;
var
  I: Integer;
begin
  Result:= nil;
  with MainWindow do
  begin
    I:= 0;
    while (I<MDIChildCount) and
     (MDIChildren[I].Perform(UM_OTHERS,IN_GETSENDER,0)<>Integer(WinSender)) do
      Inc(I);
    if I<MDIChildCount then Result:= MDIChildren[I];
  end;
end;

function GetWinByType(MainWindow: TForm;WinType:TfmChildRef):TForm;
var
  I: Integer;
begin
  Result:= nil;
  with MainWindow do
  begin
    I:= 0;
    while (I<MDIChildCount) and not (MDIChildren[I] is WinType ) do
      Inc(I);
    if I<MDIChildCount then Result:= MDIChildren[I];
  end;
end;

procedure GetWinListByType(MainWindow: TForm;WinList: TList;WinType:TfmChildRef);
var
  I: Integer;
begin
  WinList.Clear;
  with MainWindow do
    for I:= 0 to MDIChildCount-1 do
      if MDIChildren[I] is WinType then WinList.Add(MDIChildren[I]);
end;

procedure TfmMainMenu.hpWindowsClick(Sender: TObject);
begin
  inherited;
  if MDIChildCount=0 then begin
    vpCascade.Enabled:= false;
    vpTileHor.Enabled:= false;
    vpTileVer.Enabled:= false;
    vpPrior.Enabled:= false;
    vpNext.Enabled:= false;
    vpIcon.Enabled:= false;
    vpCloser.Enabled:= false;
  end
  else begin
    vpCascade.Enabled:= true;
    vpTileHor.Enabled:= true;
    vpTileVer.Enabled:= true;
    vpPrior.Enabled:= true;
    vpNext.Enabled:= true;
    vpIcon.Enabled:= true;
    vpCloser.Enabled:= true;
  end;
end;

procedure TfmMainMenu.vpIconClick(Sender: TObject);
begin
  inherited;
  ArrangeIcons;
end;

function Forming;
begin
  Screen.Cursor:= crSQLWait;
  with Result do
  begin
    Result:= TfmExplorer.Create(nil);
    SenderControl:= ASender;
    Perform(UM_INITIALIZE,IN_SETDATASET,Integer(DataSet));
    Perform(UM_OTHERS,IN_DIRECTMOVE,0);
  end;
  Screen.Cursor:= crDefault;
end;

function FormingTypeList;
begin
  Screen.Cursor:= crSQLWait;
  with Result do begin
    Result:= ChildRef.Create(nil);
    SenderControl:= ASender;
    Perform(UM_INITIALIZE,IN_SETDATASETLIST,Integer(DataSetList));
  end;
  Screen.Cursor:= crDefault;
end;

function FormingList;
begin
  Result:= FormingTypeList(TfmExplorer,ASender,DataSetList);
end;

function GetMonth(ind : Integer) : String;
begin
  case ind of
  0  : Result := 'январь';
  1  : Result := 'февраль';
  2  : Result := 'март';
  3  : Result := 'апрель';
  4  : Result := 'май';
  5  : Result := 'июнь';
  6  : Result := 'июль';
  7  : Result := 'август';
  8  : Result := 'сентябрь';
  9  : Result := 'октябрь';
  10 : Result := 'ноябрь';
  11 : Result := 'декабрь';
  else
    Result := '';
  end;
end;

procedure TfmMainMenu.vpTileVerClick(Sender: TObject);
begin
  inherited;
  TileMode:= tbVertical;
  Tile;
end;

procedure TfmMainMenu.RebuildToolBar;
begin
  if MDIChildCount=0 then ToolDown
  else
  begin
    if not vpSaveState.Enabled then
      vpSaveState.Enabled:= true;
    if not sbExit.Enabled then
    begin
      sbExit.Enabled:= true;
      vpExit.Enabled:= true;
    end;
    if dsGlobal.DataSet.IsEmpty then
    begin
      if sbEdit.Enabled then
      begin
        sbEdit.Enabled:= false;
        vpEdit.Enabled:= false;
      end;
      if sbDelete.Enabled then
      begin
        sbDelete.Enabled:= false;
        vpDelete.Enabled:= false
      end;
      if sbView.Enabled then
      begin
        sbView.Enabled:= false;
        vpView.Enabled:= false;
      end;
      if sbSort.Enabled then
      begin
        sbSort.Enabled:= false;
        vpSort.Enabled:= false;
      end;
      if sbView.Enabled then
      begin
        sbView.Enabled:= false;
        vpView.Enabled:= false;
      end;
      if aqInserting in MDIChildAccessRights then
      begin
        if not sbAdd.Enabled then
        begin
          sbAdd.Enabled:= true;
          vpAdd.Enabled:= true;
        end
      end
      else if sbAdd.Enabled then
      begin
        sbAdd.Enabled:= false;
        vpAdd.Enabled:= false;
      end ;
      if aqQuerying in MDIChildAccessRights then
      begin
        if not sbQuery.Enabled then
        begin
          sbQuery.Enabled:= true;
          vpQuery.Enabled:= true;
        end
      end
      else if sbQuery.Enabled then
      begin
        sbQuery.Enabled:= false;
        vpQuery.Enabled:= false;
      end
    end
    else
    begin
      sbPrint.Enabled:= (aqPrinting in MDIChildAccessRights);
      vpPrint.Enabled:= sbPrint.Enabled;
      sbEdit.Enabled:= (aqEditing in MDIChildAccessRights);
      vpEdit.Enabled:= sbEdit.Enabled;
      sbDelete.Enabled:= (aqDeleting in MDIChildAccessRights);
      vpDelete.Enabled:= sbDelete.Enabled;
      sbAdd.Enabled:= (aqInserting in MDIChildAccessRights);
      vpAdd.Enabled:= sbAdd.Enabled;
      sbQuery.Enabled:= (aqQuerying in MDIChildAccessRights);
      vpQuery.Enabled:= sbQuery.Enabled;
      sbView.Enabled:= (aqQuerying in MDIChildAccessRights);
      vpView.Enabled:= sbView.Enabled;
      sbSort.Enabled:= (aqQuerying in MDIChildAccessRights);
      vpSort.Enabled:= sbSort.Enabled;
      sbRefresh.Enabled:= (aqQuerying in MDIChildAccessRights);
      vpRefresh.Enabled:= sbRefresh.Enabled;
     if ActiveMDIChild.WindowState=wsMinimized then ActiveMDIChild.WindowState:= wsNormal;
    end;
    StateDataSetToStateModeButtons;
  end;
end;

procedure TfmMainMenu.ToolDown;
var
  I: Integer;
begin
  for I:= 0 to tbMain.ButtonCount-1 do
    if tbMain.Buttons[I]<>sbHelp then
      tbMain.Buttons[I].Enabled:= false;
  UpModeButtons;
  for I:= 0 to hpFile.Count-1 do
    if hpFile[I]<> vpEnd then
       hpFile[I].Enabled:= false;
  vpSaveState.Enabled:= false;
end;

var
  StartTimer: bool;

procedure TfmMainMenu.SleepToolBarClick(Sender: TObject);
var
  Direction: Integer;
begin
  StartTimer:= true;
  if Descander(Sender,sbPageUp) then Direction:= IN_PAGEUP
  else if Descander(Sender,sbPrior) then Direction:= IN_PRIOR
    else if Descander(Sender,sbNext) then Direction:= IN_NEXT
      else if Descander(Sender,sbPageDown)  then Direction:= IN_PAGEDN
        else Direction:= IN_NONE;
    ActiveMDIChild.Perform(UM_OTHERS,Direction,0);
end;

procedure TfmMainMenu.ToolBarClick(Sender: TObject);
var
  wParam: Integer;
  Msg: Integer;
begin
  StateDataSetToStateModeButtons;
  Msg:= UM_CHANGEMODE;
  if (Sender=sbAdd) or (Sender=vpAdd) then
  begin
    if not (aqInserting in MDIChildAccessRights) then
      Exit;
    wParam:= IN_INSERT;
  end
  else if (Sender=sbEdit) or (Sender=vpEdit) then
  begin
    if not (aqEditing in MDIChildAccessRights) then
      Exit;
    wParam:= IN_EDIT;
  end
  else if (Sender=sbDelete) or (Sender=vpDelete) then
  begin
    if not (aqDeleting in MDIChildAccessRights) then
      Exit;
    wParam:= IN_DELETE;
  end
  else if (Sender=sbQuery) or (Sender=vpQuery) then
  begin
    if not (aqQuerying in MDIChildAccessRights) then
      Exit;
    wParam:= IN_QUERY;
  end
  else if (Sender=sbView) or (Sender=vpView) then
  begin
    if not (aqQuerying in MDIChildAccessRights) then
      Exit;
    wParam:= IN_VIEW
  end
  else begin
    Msg:= UM_OTHERS;
    if (Sender=sbSort) or (Sender=vpSort) then wParam:= IN_SORT
    else if (Sender=sbPrint) or (Sender=vpPrint) then wParam:= IN_PRINT
    else if (Sender=sbExit) or (Sender=vpExit) then wParam:= IN_QUIT
    else if (Sender=sbPriorLevel) or (Sender=vpPriorLevel) then wParam:= IN_PRIORLEVEL
    else if (Sender=sbNextLevel) or (Sender=vpNextLevel) then wParam:= IN_NEXTLEVEL
    else if (Sender=sbRefresh) or (Sender=vpRefresh) then wParam:= IN_REFRESH
    else wParam:= IN_NONE;
  end;
  ActiveMDIChild.Perform(Msg,wParam,MS_NORMAL);
  if Msg=UM_CHANGEMODE then RebuildModeButtons;
end;

procedure TfmMainMenu.ShowRecordCount;
var
  RecCount: Integer;
begin
  RecCount:= ActiveMDIChild.Perform( UM_OTHERS,IN_GETRECORDCOUNT,0);
  if RecCount<= 1 then
    sbMain.Panels[1].Text:= Format(RowCountTxt1,[RecCount])
  else sbMain.Panels[1].Text:=
    Format(RowCountTxt2,[dsGlobal.DataSet.RecNo,RecCount]);
end;

procedure TfmMainMenu.dsGlobalDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if Field=nil then
  begin
    if dsGlobal.DataSet.IsEmpty then
      RebuildModeButtons
    else with dsGlobal.DataSet do
    begin
      sbPrint.Enabled:= aqPrinting in MDIChildAccessRights;
      vpPrint.Enabled:= sbPrint.Enabled;
    end;
    ShowRecordCount;
  end;
  if dsGlobal.DataSet.IsEmpty then
  begin
    sbPrior.Enabled:= false;
    sbPageUp.Enabled:= false;
    sbNext.Enabled:= false;
    sbPageDown.Enabled:= false;
    RebuildModeButtons;
  end
  else with dsGlobal.DataSet do
  begin
    sbPrint.Enabled:= aqPrinting in MDIChildAccessRights;
    vpPrint.Enabled:= sbPrint.Enabled;
    if BOF then
    begin
      sbPrior.Enabled:= false;
      sbPageUp.Enabled:= false;
      sbNext.Enabled:= true;
      sbPageDown.Enabled:= true
    end
    else if EOF then
    begin
      sbPrior.Enabled:= true;
      sbPageUp.Enabled:= true;
      sbNext.Enabled:= false;
      sbPageDown.Enabled:= false
    end
    else
    begin
      sbPrior.Enabled:= true;
      sbPageUp.Enabled:= true;
      sbNext.Enabled:= true;
      sbPageDown.Enabled:= true;
    end
  end;
  if Field=nil then
    ShowRecordCount;
end;

procedure TfmMainMenu.ShowHint(Sender: TObject);
begin
  sbMain.Panels[0].Text:= Application.Hint;
end;

procedure TfmMainMenu.FormCreate(Sender: TObject);
begin
  inherited;

  // Переопределяем обработчик ошибок
  Application.OnException := OnException;

  ToolDown;
  Application.OnHint:= ShowHint;
  Application.HelpFile := ExtractFilePath(Application.Exename)+'Staff.hlp';
  Caption:= AppCaption;
  MultiHintWin:= THintWindow.Create(nil);
  MultiHintWin.Color:= Application.HintColor;
  Application.OnMessage:= AppMessage;
  // Помещаем MainProgressBar в sbMain
 with MainProgressBar do
  begin
   Parent := sbMain;
   Width := sbMain.Panels[0].Width - 4;
   Top := 4;
   Left := 2;
  end;
end;

procedure TfmMainMenu.UMOthers;
var
  PNavigatorData: PTNavigatorData;

procedure RefreshPopUpMenu(intCaptions: LongInt);
var
  I: Integer;
  NewItem: TMenuItem;
  Captions: TStrings;
begin
  for I:= DirectPopUpMenu.Items.Count-1 downto 0 do
    DirectPopUpMenu.Items.Delete(I);
  Captions:= TStrings(intCaptions);
  sbDirectList.Enabled:= Assigned(Captions);
  if Assigned(Captions) then
   for I:= 0 to Captions.Count-1 do
   begin
     NewItem:= TMenuItem.Create(DirectPopUpMenu);
     with NewItem do
     begin
       Caption:= Captions[I];
       OnClick:= PopUpItemClick;
     end;
     DirectPopUpMenu.Items.Add(NewItem);
   end
end;

begin
  case Message.wParam of
    IN_ACTIVATE:
    begin
      dsGlobal.DataSet:= Pointer(ActiveMDIChild.Perform(UM_OTHERS,IN_GETDATASET,0));
      Move(Pointer(ActiveMDIChild.Perform(UM_OTHERS,IN_GETACCESS,0))^,
           MDIChildAccessRights,SizeOf(MDIChildAccessRights));
      RebuildToolBar;
    end;
    IN_CLOSE:
    begin
      if MDIChildCount<=1 then
      begin
        ToolDown;
        sbMain.Panels[1].Text:='';
        sbMain.Panels[2].Text:='';
      end;
    end;
    IN_NAVIGATOR:
    begin
      PNavigatorData:= Pointer(Message.lParam);
      if Assigned(PNavigatorData) then
      with PNavigatorData^ do
      begin
        sbPriorLevel.Enabled:= ebPrior in ExploreState;
        sbNextLevel.Enabled:= ebNext in ExploreState;
        vpPriorLevel.Enabled:= sbPriorLevel.Enabled;
        vpNextLevel.Enabled:= sbNextLevel.Enabled;
        sbMain.Panels[2].Text:= Path
      end
      else
      begin
        sbPriorLevel.Enabled:= false;
        sbNextLevel.Enabled:= false;
        vpPriorLevel.Enabled:= false;
        vpNextLevel.Enabled:= false;
        sbMain.Panels[2].Text:= '';
      end;
    end;
    IN_DIRECTLIST:RefreshPopUpMenu(Message.lParam);
    IN_MASTER:
    begin
      sbPriorLevel.Enabled:= not Bool(Message.lParam);
      vpPriorLevel.Enabled:= not Bool(Message.lParam);
      sbNextLevel.Enabled:=  Bool(Message.lParam);
      vpNextLevel.Enabled:= Bool(Message.lParam);
    end;
    IN_REFRESH: RebuildModeButtons;
  end;
end;

procedure TfmMainMenu.vpEndClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMainMenu.PopUpItemClick(Sender: TObject);
begin
  if Sender is TMenuItem then
    with Sender as TMenuItem do
      ActiveMDIChild.Perform(UM_OTHERS,IN_DIRECTMOVE,MenuIndex);
end;

procedure TfmMainMenu.StartLongClick(Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
begin
  StartTimer:= false;
  BeginRepeatCycle(Sender as TComponent,ClickDelay,SleepToolBarClick);
end;

procedure TfmMainMenu.FinishLongClick(Sender: TObject; Button: TMouseButton;
                    Shift: TShiftState; X, Y: Integer);
begin
  if not StartTimer then SleepToolBarClick(Sender);
  EndRepeatCycle;
  StartTimer:= false;
end;

procedure TfmMainMenu.UserClick(Sender: TObject);
var
  ChildWin: TForm;
begin
  ChildWin:= GetChildWindow(Self,Sender);
  if not Assigned(ChildWin) then
  begin
      if Sender= vpChapter then Forming(Sender,dmGlobal.quMiChapter)
      else if Sender= vpCurrency then Forming(Sender,dmGlobal.quCurrency)
      else if Sender= vpPayMethods then Forming(Sender,dmGlobal.quPayMethods)
      else if Sender= vpIstFin then Forming(Sender,dmGlobal.quMiIstFin)
      else if Sender= vpPayment then Forming(Sender,dmGlobal.quMiPayment)
      else if Sender= vpAnnul then Forming(Sender,dmGlobal.quMiAnnul)
      else if Sender= vpTrConcern then FormChildWindow(TfmTRConcern,vpTrConcern,dmGlobal.quMiTrConcern)
      else if Sender= vpTreaty then FormChildWindow(TfmTreatyCard,vpTreaty,dmGlobal.quTreaty)
      else if Sender= vpEconomicParameter then Forming(Sender,dmGlobal.quEconParam)
      else if Sender= vpExchange then Forming(Sender,dmGlobal.quMiExchange)
  end
  else SetMDIFocus(Self,ChildWin);
end;

procedure TfmMainMenu.SubMenuClick(Sender: TObject);
var
  ChildWin: TForm;
begin
  if Sender is TMenuItem then
    with Sender as TMenuItem do
    begin
      ChildWin:= GetChildWindow(Self,Parent);
      if not Assigned(ChildWin) then
      begin
        PopUpItemClick(Sender);
      end
      else
      begin
        SetMDIFocus(Self,ChildWin);
        PopUpItemClick(Sender);
      end;
    end;
end;

procedure TfmMainMenu.ChangeTreaty(Sender: TObject);
var
 v_dummy : integer;
begin
 if Sender = vpSubjectToTreaty then
 begin
   if dmGlobal.quTreaty.WorkState <> wsEdit then
     sbEdit.Click;
   dmGlobal.quTreaty.FieldByName('STATUS').Value := 'O';
   dmGlobal.quTreaty.FieldByName('NUM').Value := '';
   Exit;
 end;
 if Sender = vpTreatyToSubject then
 begin
   if dmGlobal.quTreaty.WorkState <> wsEdit then
     sbEdit.Click;
   dmGlobal.quTreaty.FieldByName('STATUS').Value := 'P';
   Exit;
 end;

 v_dummy := 0;
 dmglobal.quChangeStatus.SetVariable('ID',dmglobal.quTreatyID.Value);
 dmglobal.quChangeStatus.SetVariable('ANNUL_KOD',null);
 if Sender= vpClose then
  dmglobal.quChangeStatus.SetVariable('STATUS','F')
 else if (Sender= vpNoClose) or (Sender= vpNoAnnulment) then
  dmglobal.quChangeStatus.SetVariable('STATUS','O') // 'O' OPERATIVE Действующий договор
 else if Sender= vpAnnulment then
 begin
  fmSearch := TfmSearch.Create(self);
  fmSearch.Caption := 'Выбор вида аннулирования';
  fmSearch.qrSearch.Session := dmglobal.seOracle;
  fmSearch.qrSearch.SQL.Clear;
  fmSearch.qrSearch.SQL.Append(' select kod Код, snaim Наименование from rn.miannul ');
  fmSearch.qrSearch.Order := ' kod asc ';
  fmSearch.qrSearch.Execute;
  fmSearch.ShowModal;
  if fmSearch.ModalResult = mrOk then
  begin
   dmglobal.quChangeStatus.SetVariable('STATUS','A');
   v_dummy := fmSearch.qrSearch.FieldValues['Код'];
   dmglobal.quChangeStatus.SetVariable('ANNUL_KOD',v_dummy);
   fmSearch.Free;
   fmSearch := nil;
  end
  else begin fmSearch.Free;  fmSearch := nil; exit; end;
 end;
 //
 dmglobal.quChangeStatus.Execute;
 dmglobal.quChangeStatus.Close;
 dmglobal.seOracle.Commit;
 dmglobal.quTreatyStatus.Value := dmglobal.quChangeStatus.GetVariable('STATUS');
 dmglobal.quTreatyAnnul_Kod.Value := v_dummy;
 dmglobal.quTreaty.CommitUpdates;
end;

procedure TfmMainMenu.RebuildModeButtons;
begin
  sbSort.Enabled:= (aqQuerying in MDIChildAccessRights) and
                   not dsGlobal.DataSet.IsEmpty;
  vpSort.Enabled:= sbSort.Enabled;
  sbView.Enabled:= (aqQuerying in MDIChildAccessRights) and
                   not dsGlobal.DataSet.IsEmpty;
  vpView.Enabled:= sbView.Enabled;
  sbDelete.Enabled:= (aqDeleting in MDIChildAccessRights) and
                      not dsGlobal.DataSet.IsEmpty;
  vpDelete.Enabled:= sbDelete.Enabled;
  sbEdit.Enabled:= (aqEditing in MDIChildAccessRights) and
                    not dsGlobal.DataSet.IsEmpty;
  vpEdit.Enabled:= sbEdit.Enabled;

  StateDataSetToStateModeButtons;
end;

procedure TfmMainMenu.FormDestroy(Sender: TObject);
begin
  vpAllClick(Sender);
  dmGlobal.Free;
  dmGlobal:= nil;
  MultiHintWin.Free;
  inherited;
end;

procedure TfmMainMenu.UMProgressUpdate(var Message : TMessage);
begin
 with MainProgressBar do
  begin
   Position := Message.wParam;
   Visible := (Position > 0) and (Position < 100);
  end;
end;

procedure TfmMainMenu.AddToStructure(MetaSrc: TVMetaDataSource;const Index: Integer;const DataSetName:string);
var
  quStructure: TVASUPQuery;
begin
  quStructure:= TVASUPQuery.Create(dmGlobal);
  with quStructure do
  begin
    Name:= Format('%s%d',[MetaSrc[0].Name,Index]);
    quStructure.Assign(MetaSrc[0]);
    quStructure.Caption:= DataSetName;
    CreateFieldTemplates(MetaSrc[0],quStructure);
    MetaSrc.AddToList(quStructure);
    quStructure.BeforePost:= dmGlobal.CheckLevelBeforePost;
    quStructure.MasterFields:= 'ID';
    quStructure.DetailFields:= 'MIPODR_ID';
    quStructure.SetVariable('DEPT_LEVEL',MetaSrc.Count);
    if MetaSrc.Count>1 then
      Master:= TOracleDataSet(MetaSrc[MetaSrc.Count-2]);
    if dmGlobal.mdStruc.Count in [1..2] then
    with quStructure do
    begin
      Order:= 'A.KOD ASC';
      FieldByName('VERH_PODR').Visible:= false;
      FieldByName('VERH_NAIM').Visible:= false;
      FieldByName('VERH_PODR').Tag:= 2;
      FieldByName('VERH_NAIM').Tag:= 2;
    end;
  end;
end;

procedure TfmMainMenu.FormShow(Sender: TObject);
begin
  inherited;
  with dmGlobal do
  begin
    AddToStructure(mdStruc, 1, 'Укрепленные Подразделения');
    vpChapter.Visible:= quMiChapter.AccessLevel<>[];
    vpAnnul.Visible:= quMiAnnul.AccessLevel<>[];
    vpPayment.Visible:= quMiPayment.AccessLevel<>[];
    vpFirm.Visible:= quFirm.AccessLevel<>[];
    vpIstFin.Visible:= quMiIstFin.AccessLevel<>[];
    vpPayMethods.Visible:= quPayMethods.AccessLevel<>[];
    vpCurrency.Visible:= quCurrency.AccessLevel<>[];
    vpTreaty.Visible:= quTreaty.AccessLevel<>[];
  end;
end;

const
  StateSavingPrompt='Сохранить текущее состояние окна как состояние по умолчанию ?';

procedure TfmMainMenu.vpSaveStateClick(Sender: TObject);
begin
  inherited;
  if MessageDlg(StateSavingPrompt,mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    Screen.Cursor:= crHourGlass;
    ActiveMDIChild.Repaint;
    ActiveMDIChild.Perform(UM_OTHERS,IN_STORE,0);
    Screen.Cursor:= crDefault;
  end;
end;

procedure SetMDIFocus(MDIParent,MDIChild: TForm);
var
  I,Max: Integer;
begin
  MDIParent.Enabled:= false;
  Max:= MDIParent.MDIChildCount;
  I:= 0;
  while (I<Max) and (MDIParent.ActiveMDIChild<>MDIChild) do
  begin
    MDIParent.Next;
    Inc(I);
  end;
  MDIParent.Enabled:= true;
end;

procedure RemoveConflictWin;
var
  WinConflict: TForm;
begin
  WinConflict:= GetWinByType(Application.MainForm,TfmExpPodr);
  WinConflict.Free;
end;

procedure BroadCastRefresh;
var
  StaffWinList: TList;
  I: Integer;
begin
   StaffWinList:= TList.Create;
   try
     //GetWinListByType(Application.MainForm,StaffWinList,TfmExpStaff);
     for I:= 0 to StaffWinList.Count-1 do
       TForm(StaffWinList[I]).Perform(UM_OTHERS,IN_REFRESH,0);
   finally
     StaffWinList.Free;
   end;
end;

const
  SuccessMsg= 'Процесс восстановления окладов и тарифов успешно завершен.'+#13#10+
              'Обработано строк: %d.';
  TableLockedMsg= 'Массив штатных расписаний уже заблокирован другим пользователем.'+#13#10+
                  'Необходима разблокировка.';
  ConfirmMsg= 'Вы уверены, что собираетесь провести восстановление окладов и тарифов ?';

procedure TfmMainMenu.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= MessageDlg( ConfirmExitMsg,mtConfirmation,
                         [mbYes,mbNo],0)= mrYes;
end;

procedure TfmMainMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmMainMenu.vpContentClick(Sender: TObject);
begin
  Application.HelpContext(0);
end;

procedure TfmMainMenu.vpAboutClick(Sender: TObject);
begin
  with TfmAboutBox.Create(Self) do ShowModal;
end;

procedure TfmMainMenu.sbHelpClick(Sender: TObject);
begin
  Application.HelpContext(0);
end;

procedure TfmMainMenu.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if MultiHintWin.HandleAllocated
     and MultiHintWin.IsHintMsg(Msg) then MultiHintWin.ReleaseHandle;
end;

procedure TfmMainMenu.vpFirmClick(Sender: TObject);
var
  ChildWin: TForm;
begin
  ChildWin:= GetChildWindow(Self,vpFirm);
  if not Assigned(ChildWin) then
     FormChildWindow(TfmFirm,vpFirm,dmGlobal.quFirm)
  else SetMDIFocus(Self,ChildWin);
end;

procedure TfmMainMenu.vpPrintLetterFRX(Sender: TObject);
var
  I:      Integer;
  SPECIAL_WRITTEN : String;// Идентификатор служебного письма на оплату
  C_ErrorMsg : string; // Сообщение об ошибке
  v_curr_decode : string; // Расшифровка валюты
  v_exec_name : String; // Название организации испольнителя
  v_beneficiary : String;
  currPos, offs1, offs2 : Integer;
  lenBenefic : Integer;
  str1, str2 : String;
  frxMemo : TFrxMemoView;

  CUST_ACCOUNT_ID : Variant;
  SELL_ACCOUNT_ID : Variant;

  NDS_SUMMPAY : String;
  n : Integer;
begin
  with fmMainMenu.ActiveMDIChild as TfmTreatyCard do
  if not DBGrid.DataSource.DataSet.IsEmpty and (not DBGrid.DataSource.DataSet.FieldByName('SPECIAL_WRITTEN').IsNull) then
    with DBGrid.DataSource.DataSet do
    begin
      SPECIAL_WRITTEN := FieldByName('SPECIAL_WRITTEN').AsString;
      CUST_ACCOUNT_ID := FieldByName('CUST_ACCOUNT_ID').value;
      SELL_ACCOUNT_ID := FieldByName('EXEC_ACCOUNT_ID').Value;
    end;
  // Запускаем процедуру для поиска всех необходимых данных и ошибок
  dmglobal.quPrintLetter.SetVariable('SPECIAL_WRITTEN',SPECIAL_WRITTEN);
  dmglobal.quPrintLetter.Execute;
  dmglobal.quPrintLetter.Close;
  if not VarIsNull(dmglobal.quPrintLetter.GetVariable('C_ERRORMSG'))
  then
  begin
    C_ErrorMsg := dmglobal.quPrintLetter.GetVariable('C_ERRORMSG');
    Screen.Cursor:=crDefault;
    MessageBox(Handle, Pchar(C_ErrorMsg),'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;



  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу

    try
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_SUMMPAY')) then
      dmFastReport.frxLetter.Variables['v_summpay'] := dmglobal.quPrintLetter.GetVariable('V_SUMMPAY');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NDS')) then
      dmFastReport.frxLetter.Variables['v_NDS'] := String(dmglobal.quPrintLetter.GetVariable('V_NDS'));
      if (dmglobal.quPrintLetter.GetVariable('V_NDS_SUMMPAY') <> NULL) and
         (dmglobal.quPrintLetter.GetVariable('V_NDS_SUMMPAY') <> 0) then
      begin
         frxMemo := dmFastReport.frxLetter.findObject('Memo27') as TfrxMemoView;
         frxMemo.Text := 'В т.ч. НДС';
         frxMemo := dmFastReport.frxLetter.findObject('Memo93') as TfrxMemoView;
         frxMemo.Visible := True;
         frxMemo := dmFastReport.frxLetter.findObject('Memo94') as TfrxMemoView;
         frxMemo.Visible := True;
         frxMemo := dmFastReport.frxLetter.findObject('Memo95') as TfrxMemoView;
         frxMemo.Visible := True;
         frxMemo := dmFastReport.frxLetter.findObject('Memo96') as TfrxMemoView;
         frxMemo.Visible := True;
      end
      else
      begin
         frxMemo := dmFastReport.frxLetter.findObject('Memo27') as TfrxMemoView;
         frxMemo.Text := 'Без НДС';
         frxMemo := dmFastReport.frxLetter.findObject('Memo93') as TfrxMemoView;
         frxMemo.Visible := False;
         frxMemo := dmFastReport.frxLetter.findObject('Memo94') as TfrxMemoView;
         frxMemo.Visible := False;
         frxMemo := dmFastReport.frxLetter.findObject('Memo95') as TfrxMemoView;
         frxMemo.Visible := False;
         frxMemo := dmFastReport.frxLetter.findObject('Memo96') as TfrxMemoView;
         frxMemo.Visible := False;
      end;
      dmFastReport.frxLetter.Variables['v_NDS_SUMMPAY'] := '';
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_TR_NUM')) then
      dmFastReport.frxLetter.Variables['V_TR_NUM'] := String(dmglobal.quPrintLetter.GetVariable('V_TR_NUM'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_TR_DATESIGN')) then
      dmFastReport.frxLetter.Variables['V_TR_DATESIGN'] := dmglobal.quPrintLetter.GetVariable('V_TR_DATESIGN');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_AGR_NUM')) then
      dmFastReport.frxLetter.Variables['V_AGR_NUM'] := dmglobal.quPrintLetter.GetVariable('V_AGR_NUM');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_AGR_DATESIGN')) then
      dmFastReport.frxLetter.Variables['V_AGR_DATESIGN'] := dmglobal.quPrintLetter.GetVariable('V_AGR_DATESIGN');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_NAME')) then
      begin
        dmFastReport.frxLetter.Variables['V_EXEC_NAME'] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_NAME'));
      end;
    { if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE_ACTS')) then
       Excel.WorkSheets[2].Cells[12, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE_ACTS'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE_NUMS')) then
       Excel.WorkSheets[2].Cells[13, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE_NUMS'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_OBOSNOVAN')) then
       Excel.WorkSheets[2].Cells[14, 2] := String(dmglobal.quPrintLetter.GetVariable('V_OBOSNOVAN'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_BANK')) then
        Excel.WorkSheets[2].Cells[17, 2] := String(dmglobal.quPrintLetter.GetVariable('V_BANK'))
      else if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_NAME')) then
        Excel.WorkSheets[2].Cells[17, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_NAME'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CITY')) then
       Excel.WorkSheets[2].Cells[18, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CITY'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_ACCOUNT')) then
       Excel.WorkSheets[2].Cells[19, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_ACCOUNT'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_UNN')) then
       Excel.WorkSheets[2].Cells[20, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_UNN'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_PRIMECHANIE')) then
       Excel.WorkSheets[2].Cells[21, 2] := String(dmglobal.quPrintLetter.GetVariable('V_PRIMECHANIE'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CODE')) then
       Excel.WorkSheets[2].Cells[22, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CODE'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_CURATOR')) then
       Excel.WorkSheets[2].Cells[27, 2] := String(dmglobal.quPrintLetter.GetVariable('V_CURATOR'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_SWIFT')) then
       Excel.WorkSheets[2].Cells[30, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_SWIFT'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_LORO_ACC')) then
       Excel.WorkSheets[2].Cells[31, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_LORO_ACC'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_ID')) then
       Excel.WorkSheets[2].Cells[35, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_ID'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_CITY')) then
       Excel.WorkSheets[2].Cells[36, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_CITY'));
      Excel.WorkSheets[2].Cells[37, 2] := v_curr_decode;
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE1')) then
       Excel.WorkSheets[2].Cells[38, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE1'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NUMACT1')) then
       Excel.WorkSheets[2].Cells[39, 2] := String(dmglobal.quPrintLetter.GetVariable('V_NUMACT1'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_DATEACT1')) then
       Excel.WorkSheets[2].Cells[40, 2] := String(dmglobal.quPrintLetter.GetVariable('V_DATEACT1'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE2')) then
       Excel.WorkSheets[2].Cells[41, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE2'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NUMACT2')) then
       Excel.WorkSheets[2].Cells[42, 2] := String(dmglobal.quPrintLetter.GetVariable('V_NUMACT2'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_DATEACT2')) then
       Excel.WorkSheets[2].Cells[43, 2] := String(dmglobal.quPrintLetter.GetVariable('V_DATEACT2'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('v_ISTFIN_KOD')) then
      begin
        if dmglobal.quPrintLetter.GetVariable('v_ISTFIN_KOD') = 2 then
          Excel.WorkSheets[2].Cells[46, 2] := 'инновационный фонд'
        else if dmglobal.quPrintLetter.GetVariable('v_ISTFIN_KOD') = 1 then
          Excel.WorkSheets[2].Cells[46, 2] := 'из средств предприятия';
      end;
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('v_exec_bank_country')) then
       Excel.WorkSheets[2].Cells[47, 2] := String(dmglobal.quPrintLetter.GetVariable('v_exec_bank_country'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('v_exec_country')) then
       Excel.WorkSheets[2].Cells[48, 2] := String(dmglobal.quPrintLetter.GetVariable('v_exec_country'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_CONT_PAY_DATE')) then
       Excel.WorkSheets[2].Cells[49, 2] := String(dmglobal.quPrintLetter.GetVariable('V_CONT_PAY_DATE'));
   }
    except
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;
  finally
    Screen.Cursor:=crDefault;
 //   Excel.Visible:=True;
  end;



end;




procedure TfmMainMenu.vpPrintLetterClick(Sender: TObject);
var
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  I:      Integer;
  //CurrentBookMark : TBookMark;
  //IdStages : string; // Id этапов через запятую
  SPECIAL_WRITTEN : String;// Идентификатор служебного письма на оплату
  C_ErrorMsg : string; // Сообщение об ошибке
  v_curr_decode : string; // Расшифровка валюты
  v_exec_name : String; // Название организации испольнителя
  v_beneficiary : String;
  currPos, offs1, offs2 : Integer;
  lenBenefic : Integer;
  str1, str2 : String;

  CUST_ACCOUNT_ID : Variant;
  SELL_ACCOUNT_ID : Variant;

  NDS_SUMMPAY : String;
  n : Double;
begin
  inherited;
  //IdStages := '';
  SPECIAL_WRITTEN := '';
  v_curr_decode := '';
  with fmMainMenu.ActiveMDIChild as TfmTreatyCard do
  if not DBGrid.DataSource.DataSet.IsEmpty and (not DBGrid.DataSource.DataSet.FieldByName('SPECIAL_WRITTEN').IsNull) then //DBGrid.SelectedRows.Count>0 then
    with DBGrid.DataSource.DataSet do
    begin
      {CurrentBookMark := GetBookmark;
      DisableControls;
      for i:=0 to DBGrid.SelectedRows.Count-1 do
      begin
        GotoBookmark(pointer(DBGrid.SelectedRows.Items[i]));
        if IdStages <> '' then IdStages := IdStages + ',';
        IdStages:= IdStages + FieldByName('ID').AsString;
      end;
      GotoBookmark(CurrentBookMark);
      EnableControls;}

      SPECIAL_WRITTEN := FieldByName('SPECIAL_WRITTEN').AsString;
      CUST_ACCOUNT_ID := FieldByName('CUST_ACCOUNT_ID').value;
      SELL_ACCOUNT_ID := FieldByName('EXEC_ACCOUNT_ID').Value;
    end;
  // Запускаем процедуру для поиска всех необходимых данных и ошибок
  //dmglobal.quPrintLetter.SetVariable('STAGE_IDS',IdStages);
  dmglobal.quPrintLetter.SetVariable('SPECIAL_WRITTEN',SPECIAL_WRITTEN);
  dmglobal.quPrintLetter.Execute;
  dmglobal.quPrintLetter.Close;
  if not VarIsNull(dmglobal.quPrintLetter.GetVariable('C_ERRORMSG'))
  then
  begin
    C_ErrorMsg := dmglobal.quPrintLetter.GetVariable('C_ERRORMSG');
    Screen.Cursor:=crDefault;
    MessageBox(Handle, Pchar(C_ErrorMsg),'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;



  // Выбираем записи в Excel
  if VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO'))
    or dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = BYR then
  begin
    St:=ExtractFilePath(Application.ExeName) + 'report\letter.xlt';
    v_curr_decode := 'руб';
  end
  else
  begin
    St:=ExtractFilePath(Application.ExeName) + 'report\letter_f.xlt';
    if dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = 643 then
      v_curr_decode := 'руб. РФ'; // российский рубль
    if dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = 980 then
      v_curr_decode := 'укр. гривен'; // украинская гривна
    if dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = 840 then
      v_curr_decode := 'долл. США'; // доллар США


  end;

  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application



  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;

  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
     Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    try
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_SUMMPAY')) then
       Excel.WorkSheets[2].Cells[3, 2] := dmglobal.quPrintLetter.GetVariable('V_SUMMPAY');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NDS')) then
       Excel.WorkSheets[2].Cells[4, 2] := String(dmglobal.quPrintLetter.GetVariable('V_NDS'));
      if (dmglobal.quPrintLetter.GetVariable('V_NDS_SUMMPAY') <> NULL) and
         (dmglobal.quPrintLetter.GetVariable('V_NDS_SUMMPAY') <> 0) then
      begin
        {
        //Непонятна суть этих финтов чтобы тупо преобразовать число в строку.
        //Закоментарено
        n := RoundTo(dmglobal.quPrintLetter.GetVariable('V_NDS_SUMMPAY'),-2);
        i := 0;
        NDS_SUMMPAY := '';
        while(n <> 0) do
        begin
          if (i <> 0) and ((i mod 3)=0) then
            NDS_SUMMPAY := ' ' + NDS_SUMMPAY;
          NDS_SUMMPAY := IntToStr(n mod 10) + NDS_SUMMPAY;
          inc(i);
          n := trunc(n / 10);
        end;
        NDS_SUMMPAY := NDS_SUMMPAY + ' '+v_curr_decode;}
        NDS_SUMMPAY := FloatToStr(RoundTo(dmglobal.quPrintLetter.GetVariable('V_NDS_SUMMPAY'),-2)) + ' ' + v_curr_decode;
      end
      else
        NDS_SUMMPAY := '';
      Excel.WorkSheets[2].Cells[5, 2] := NDS_SUMMPAY;
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_TR_NUM')) then
       Excel.WorkSheets[2].Cells[6, 2] := String(dmglobal.quPrintLetter.GetVariable('V_TR_NUM'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_TR_DATESIGN')) then
       Excel.WorkSheets[2].Cells[7, 2] := dmglobal.quPrintLetter.GetVariable('V_TR_DATESIGN');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_AGR_NUM')) then
       Excel.WorkSheets[2].Cells[8, 2] := dmglobal.quPrintLetter.GetVariable('V_AGR_NUM');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_AGR_DATESIGN')) then
       Excel.WorkSheets[2].Cells[9, 2] := dmglobal.quPrintLetter.GetVariable('V_AGR_DATESIGN');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_NAME')) then
      begin
       v_exec_name := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_NAME'));
       Excel.WorkSheets[2].Cells[10, 2] := v_exec_name;
       if (not (   VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO'))
                or dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = BYR))
          and
              (not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_BENEFICIARY'))) then
         v_beneficiary := String(dmglobal.quPrintLetter.GetVariable('V_BENEFICIARY'))
       else
         v_beneficiary := v_exec_name;

       lenBenefic := Length(v_beneficiary);

       if (lenBenefic > 60) and not (VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO'))
         or dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = BYR) then
       begin
         // Наименование бенефициана раскидываем на две строчки

         // Ищем позицию в Наименование бенефициана, где оно будет разделено на две строки
         if lenBenefic > 150 then
           currPos := round(Length(v_beneficiary) * 0.4)
         else
           currPos := 60;


         if (v_beneficiary[currPos] > ' ') and (v_beneficiary[currPos] <> '-') then
         begin
           offs1 := 1;
           offs2 := 1;

           while (offs1 < currPos) and (v_beneficiary[currPos - offs1] > ' ')
                  and (v_beneficiary[currPos - offs1] <> '-') do
             Inc(offs1);

           while (offs2 < (lenBenefic - currPos)) and (v_beneficiary[currPos + offs2] > ' ')
                  and (v_beneficiary[currPos + offs2] <> '-') do
             Inc(offs2);


           if ((lenBenefic > 150) and (offs1 < offs2)) or ((lenBenefic <= 150) and ((offs1 - (150 - lenBenefic)) < offs2)) then
             Dec(currPos, offs1)
           else
             Inc(currPos, offs2);
         end;

         str1 := Copy(v_beneficiary, 1, currPos);
         TrimRight(str1);
         str2 := Copy(v_beneficiary, currPos + 1, lenBenefic - currPos);
         TrimLeft(str2);

         Excel.WorkSheets[2].Cells[15, 2] := str1;
         Excel.WorkSheets[2].Cells[16, 2] := str2;

       end
       else
         Excel.WorkSheets[2].Cells[15, 2] := v_beneficiary;

       {if length(v_exec_name) > 40 then
       begin
         Excel.WorkSheets[1].Cells[19, 8].Font.Size := 10;
         Excel.WorkSheets[1].Cells[34, 8].Font.Size := 10;
       end
       else
       begin
         Excel.WorkSheets[1].Cells[19, 8].Font.Size := 14;
         Excel.WorkSheets[1].Cells[34, 8].Font.Size := 14;
       end;}
      end;
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE_ACTS')) then
       Excel.WorkSheets[2].Cells[12, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE_ACTS'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE_NUMS')) then
       Excel.WorkSheets[2].Cells[13, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE_NUMS'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_OBOSNOVAN')) then
       Excel.WorkSheets[2].Cells[14, 2] := String(dmglobal.quPrintLetter.GetVariable('V_OBOSNOVAN'));
      //if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_NAME')) then
       //Excel.WorkSheets[2].Cells[15, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_NAME'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_BANK')) then
        Excel.WorkSheets[2].Cells[17, 2] := String(dmglobal.quPrintLetter.GetVariable('V_BANK'))
      else if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_NAME')) then
        Excel.WorkSheets[2].Cells[17, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_NAME'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NIOKR_ACCOUNT')) then
        if Trim(String(dmglobal.quPrintLetter.GetVariable('V_NIOKR_ACCOUNT'))) <> '' then
          Excel.WorkSheets[2].Cells[45, 2] := '  ' + String(dmglobal.quPrintLetter.GetVariable('V_NIOKR_ACCOUNT'))
        else
          Excel.WorkSheets[2].Cells[45, 2] := '';
        if dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = 643 then
          Excel.WorkSheets[2].Cells[45, 2] := 'код валютных операций VO 20050';
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CITY')) then
       Excel.WorkSheets[2].Cells[18, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CITY'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_ACCOUNT')) then
       Excel.WorkSheets[2].Cells[19, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_ACCOUNT'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_UNN')) then
       Excel.WorkSheets[2].Cells[20, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_UNN'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_PRIMECHANIE')) then
       Excel.WorkSheets[2].Cells[21, 2] := String(dmglobal.quPrintLetter.GetVariable('V_PRIMECHANIE'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CODE')) then
       Excel.WorkSheets[2].Cells[22, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CODE'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_CURATOR')) then
       Excel.WorkSheets[2].Cells[27, 2] := String(dmglobal.quPrintLetter.GetVariable('V_CURATOR'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_SWIFT')) then
       Excel.WorkSheets[2].Cells[30, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_SWIFT'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_LORO_ACC')) then
       Excel.WorkSheets[2].Cells[31, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_LORO_ACC'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_ID')) then
       Excel.WorkSheets[2].Cells[35, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_ID'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_CITY')) then
       Excel.WorkSheets[2].Cells[36, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_CITY'));
      Excel.WorkSheets[2].Cells[37, 2] := v_curr_decode;
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE1')) then
       Excel.WorkSheets[2].Cells[38, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE1'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NUMACT1')) then
       Excel.WorkSheets[2].Cells[39, 2] := String(dmglobal.quPrintLetter.GetVariable('V_NUMACT1'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_DATEACT1')) then
       Excel.WorkSheets[2].Cells[40, 2] := String(dmglobal.quPrintLetter.GetVariable('V_DATEACT1'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE2')) then
       Excel.WorkSheets[2].Cells[41, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE2'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NUMACT2')) then
       Excel.WorkSheets[2].Cells[42, 2] := String(dmglobal.quPrintLetter.GetVariable('V_NUMACT2'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_DATEACT2')) then
       Excel.WorkSheets[2].Cells[43, 2] := String(dmglobal.quPrintLetter.GetVariable('V_DATEACT2'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('v_ISTFIN_KOD')) then
      begin
        if dmglobal.quPrintLetter.GetVariable('v_ISTFIN_KOD') = 2 then
          Excel.WorkSheets[2].Cells[46, 2] := 'инновационный фонд'
        else if dmglobal.quPrintLetter.GetVariable('v_ISTFIN_KOD') = 1 then
          Excel.WorkSheets[2].Cells[46, 2] := 'из средств предприятия';
      end;
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('v_exec_bank_country')) then
       Excel.WorkSheets[2].Cells[47, 2] := String(dmglobal.quPrintLetter.GetVariable('v_exec_bank_country'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('v_exec_country')) then
       Excel.WorkSheets[2].Cells[48, 2] := String(dmglobal.quPrintLetter.GetVariable('v_exec_country'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_CONT_PAY_DATE')) then
       Excel.WorkSheets[2].Cells[49, 2] := String(dmglobal.quPrintLetter.GetVariable('V_CONT_PAY_DATE'));

    except
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;
  end;
end;


procedure TfmMainMenu.vpPrintFrxLetterClick(Sender: TObject);
var
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  i:      Integer;
  CurrentBookMark : TBookMark;
  IdStages : string; // Id этапов через запятую
  SPECIAL_WRITTEN : String;// Идентификатор служебного письма на оплату
  C_ErrorMsg : string; // Сообщение об ошибке
  v_curr_decode : string; // Расшифровка валюты
  v_exec_name : String; // Название организации испольнителя
  v_beneficiary : String;
  currPos, offs1, offs2 : Integer;
  lenBenefic : Integer;
  str1, str2 : String;

  CUST_ACCOUNT_ID : Variant;
  SELL_ACCOUNT_ID : Variant;

  NDS_SUMMPAY : String;
  n : Integer;
begin
  inherited;
  IdStages := '';
  SPECIAL_WRITTEN := '';
  v_curr_decode := '';
  with fmMainMenu.ActiveMDIChild as TfmTreatyCard do
  if not DBGrid.DataSource.DataSet.IsEmpty and (not DBGrid.DataSource.DataSet.FieldByName('SPECIAL_WRITTEN').IsNull) then //DBGrid.SelectedRows.Count>0 then
    with DBGrid.DataSource.DataSet do
    begin
      SPECIAL_WRITTEN := FieldByName('SPECIAL_WRITTEN').AsString;
      CUST_ACCOUNT_ID := FieldByName('CUST_ACCOUNT_ID').value;
      SELL_ACCOUNT_ID := FieldByName('EXEC_ACCOUNT_ID').Value;
    end;
  // Запускаем процедуру для поиска всех необходимых данных и ошибок
  dmglobal.quPrintLetter.SetVariable('SPECIAL_WRITTEN',SPECIAL_WRITTEN);
  dmglobal.quPrintLetter.Execute;
  dmglobal.quPrintLetter.Close;
  if not VarIsNull(dmglobal.quPrintLetter.GetVariable('C_ERRORMSG'))
  then
  begin
    C_ErrorMsg := dmglobal.quPrintLetter.GetVariable('C_ERRORMSG');
    Screen.Cursor:=crDefault;
    MessageBox(Handle, Pchar(C_ErrorMsg),'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;

  // Выбираем записи в Excel
  if VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO'))
    or dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = BYR then
  begin



    v_curr_decode := 'руб';
  end;
{  else
  begin
    St:=ExtractFilePath(Application.ExeName) + 'report\letter_f.xlt';
    if dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = 643 then
      v_curr_decode := 'руб. РФ'; // российский рубль
    if dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = 980 then
      v_curr_decode := 'укр. гривен'; // украинская гривна
    if dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = 840 then
      v_curr_decode := 'долл. США'; // доллар США
  end;
}
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application

  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_SUMMPAY')) then
       Excel.WorkSheets[2].Cells[3, 2] := dmglobal.quPrintLetter.GetVariable('V_SUMMPAY');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NDS')) then
       Excel.WorkSheets[2].Cells[4, 2] := String(dmglobal.quPrintLetter.GetVariable('V_NDS'));
      if (dmglobal.quPrintLetter.GetVariable('V_NDS_SUMMPAY') <> NULL) and
         (dmglobal.quPrintLetter.GetVariable('V_NDS_SUMMPAY') <> 0) then
      begin
        {//Непонятные извращения с преобразованием числа в строку
         //Закомментарено 3-08-2016, IvchinAS
        n := RoundTo(dmglobal.quPrintLetter.GetVariable('V_NDS_SUMMPAY'), -2);
        i := 0;
        NDS_SUMMPAY := '';
        while(n <> 0) do
        begin
          if (i <> 0) and ((i mod 3)=0) then
            NDS_SUMMPAY := ' ' + NDS_SUMMPAY;
          NDS_SUMMPAY := IntToStr(n mod 10) + NDS_SUMMPAY;
          inc(i);
          n := trunc(n / 10);
        end;
        NDS_SUMMPAY := NDS_SUMMPAY + ' '+v_curr_decode;}
        NDS_SUMMPAY := FloatToStr(RoundTo(dmglobal.quPrintLetter.GetVariable('V_NDS_SUMMPAY'), -2)) + ' ' + v_curr_decode;
      end
      else
        NDS_SUMMPAY := '';
      Excel.WorkSheets[2].Cells[5, 2] := NDS_SUMMPAY;
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_TR_NUM')) then
       Excel.WorkSheets[2].Cells[6, 2] := String(dmglobal.quPrintLetter.GetVariable('V_TR_NUM'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_TR_DATESIGN')) then
       Excel.WorkSheets[2].Cells[7, 2] := dmglobal.quPrintLetter.GetVariable('V_TR_DATESIGN');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_AGR_NUM')) then
       Excel.WorkSheets[2].Cells[8, 2] := dmglobal.quPrintLetter.GetVariable('V_AGR_NUM');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_AGR_DATESIGN')) then
       Excel.WorkSheets[2].Cells[9, 2] := dmglobal.quPrintLetter.GetVariable('V_AGR_DATESIGN');
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_NAME')) then
      begin
       v_exec_name := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_NAME'));
       Excel.WorkSheets[2].Cells[10, 2] := v_exec_name;
       if (not (   VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO'))
                or dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = BYR))
          and
              (not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_BENEFICIARY'))) then
         v_beneficiary := String(dmglobal.quPrintLetter.GetVariable('V_BENEFICIARY'))
       else
         v_beneficiary := v_exec_name;

       lenBenefic := Length(v_beneficiary);

       if (lenBenefic > 60) and not (VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO'))
         or dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = BYR) then
       begin
         // Наименование бенефициана раскидываем на две строчки

         // Ищем позицию в Наименование бенефициана, где оно будет разделено на две строки
         if lenBenefic > 150 then
           currPos := round(Length(v_beneficiary) * 0.4)
         else
           currPos := 60;


         if (v_beneficiary[currPos] > ' ') and (v_beneficiary[currPos] <> '-') then
         begin
           offs1 := 1;
           offs2 := 1;

           while (offs1 < currPos) and (v_beneficiary[currPos - offs1] > ' ')
                  and (v_beneficiary[currPos - offs1] <> '-') do
             Inc(offs1);

           while (offs2 < (lenBenefic - currPos)) and (v_beneficiary[currPos + offs2] > ' ')
                  and (v_beneficiary[currPos + offs2] <> '-') do
             Inc(offs2);


           if ((lenBenefic > 150) and (offs1 < offs2)) or ((lenBenefic <= 150) and ((offs1 - (150 - lenBenefic)) < offs2)) then
             Dec(currPos, offs1)
           else
             Inc(currPos, offs2);
         end;

         str1 := Copy(v_beneficiary, 1, currPos);
         TrimRight(str1);
         str2 := Copy(v_beneficiary, currPos + 1, lenBenefic - currPos);
         TrimLeft(str2);

         Excel.WorkSheets[2].Cells[15, 2] := str1;
         Excel.WorkSheets[2].Cells[16, 2] := str2;

       end
       else
         Excel.WorkSheets[2].Cells[15, 2] := v_beneficiary;

       {if length(v_exec_name) > 40 then
       begin
         Excel.WorkSheets[1].Cells[19, 8].Font.Size := 10;
         Excel.WorkSheets[1].Cells[34, 8].Font.Size := 10;
       end
       else
       begin
         Excel.WorkSheets[1].Cells[19, 8].Font.Size := 14;
         Excel.WorkSheets[1].Cells[34, 8].Font.Size := 14;
       end;}
      end;
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE_ACTS')) then
       Excel.WorkSheets[2].Cells[12, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE_ACTS'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE_NUMS')) then
       Excel.WorkSheets[2].Cells[13, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE_NUMS'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_OBOSNOVAN')) then
       Excel.WorkSheets[2].Cells[14, 2] := String(dmglobal.quPrintLetter.GetVariable('V_OBOSNOVAN'));
      //if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_NAME')) then
       //Excel.WorkSheets[2].Cells[15, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_NAME'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_BANK')) then
        Excel.WorkSheets[2].Cells[17, 2] := String(dmglobal.quPrintLetter.GetVariable('V_BANK'))
      else if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_NAME')) then
        Excel.WorkSheets[2].Cells[17, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_NAME'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NIOKR_ACCOUNT')) then
        if Trim(String(dmglobal.quPrintLetter.GetVariable('V_NIOKR_ACCOUNT'))) <> '' then
          Excel.WorkSheets[2].Cells[45, 2] := '  ' + String(dmglobal.quPrintLetter.GetVariable('V_NIOKR_ACCOUNT'))
        else
          Excel.WorkSheets[2].Cells[45, 2] := '';
        if dmglobal.quPrintLetter.GetVariable('V_EXEC_CURRENCY_NO') = 643 then
          Excel.WorkSheets[2].Cells[45, 2] := 'код валютных операций VO 20050';
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CITY')) then
       Excel.WorkSheets[2].Cells[18, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CITY'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_ACCOUNT')) then
       Excel.WorkSheets[2].Cells[19, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_ACCOUNT'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_UNN')) then
       Excel.WorkSheets[2].Cells[20, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_UNN'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_PRIMECHANIE')) then
       Excel.WorkSheets[2].Cells[21, 2] := String(dmglobal.quPrintLetter.GetVariable('V_PRIMECHANIE'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CODE')) then
       Excel.WorkSheets[2].Cells[22, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_CODE'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_CURATOR')) then
       Excel.WorkSheets[2].Cells[27, 2] := String(dmglobal.quPrintLetter.GetVariable('V_CURATOR'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_SWIFT')) then
       Excel.WorkSheets[2].Cells[30, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_SWIFT'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_LORO_ACC')) then
       Excel.WorkSheets[2].Cells[31, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_LORO_ACC'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_ID')) then
       Excel.WorkSheets[2].Cells[35, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_BANK_ID'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_EXEC_CITY')) then
       Excel.WorkSheets[2].Cells[36, 2] := String(dmglobal.quPrintLetter.GetVariable('V_EXEC_CITY'));
      Excel.WorkSheets[2].Cells[37, 2] := v_curr_decode;
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE1')) then
       Excel.WorkSheets[2].Cells[38, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE1'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NUMACT1')) then
       Excel.WorkSheets[2].Cells[39, 2] := String(dmglobal.quPrintLetter.GetVariable('V_NUMACT1'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_DATEACT1')) then
       Excel.WorkSheets[2].Cells[40, 2] := String(dmglobal.quPrintLetter.GetVariable('V_DATEACT1'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_STAGE2')) then
       Excel.WorkSheets[2].Cells[41, 2] := String(dmglobal.quPrintLetter.GetVariable('V_STAGE2'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_NUMACT2')) then
       Excel.WorkSheets[2].Cells[42, 2] := String(dmglobal.quPrintLetter.GetVariable('V_NUMACT2'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_DATEACT2')) then
       Excel.WorkSheets[2].Cells[43, 2] := String(dmglobal.quPrintLetter.GetVariable('V_DATEACT2'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('v_ISTFIN_KOD')) then
      begin
        if dmglobal.quPrintLetter.GetVariable('v_ISTFIN_KOD') = 2 then
          Excel.WorkSheets[2].Cells[46, 2] := 'инновационный фонд'
        else if dmglobal.quPrintLetter.GetVariable('v_ISTFIN_KOD') = 1 then
          Excel.WorkSheets[2].Cells[46, 2] := 'из средств предприятия';
      end;
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('v_exec_bank_country')) then
       Excel.WorkSheets[2].Cells[47, 2] := String(dmglobal.quPrintLetter.GetVariable('v_exec_bank_country'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('v_exec_country')) then
       Excel.WorkSheets[2].Cells[48, 2] := String(dmglobal.quPrintLetter.GetVariable('v_exec_country'));
      if not VarIsNull(dmglobal.quPrintLetter.GetVariable('V_CONT_PAY_DATE')) then
       Excel.WorkSheets[2].Cells[49, 2] := String(dmglobal.quPrintLetter.GetVariable('V_CONT_PAY_DATE'));

    except
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;
  end;
end;



procedure TfmMainMenu.vpRN01RN02Click(Sender: TObject);
const
  beg_new_table : integer = 14; // Начало самой таблицы
  offs_table : integer = 3; // Начало шаблона таблицы
  cols : integer = 7;
  max_columns : integer = 21; // Максимальное число столбцов для копирования
  //row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы
  CountTailRows_RN01 : integer = 4;  // Кол. строк в конце док., которые должны напечататся на одной странице
  CountTailRows_RN02 : integer = 3;  // Кол. строк в конце док., которые должны напечататся на одной странице

  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

  Max_count_stages : Integer = 10;

  count_delete_row : integer = 5; // Количество строк шаблона, которое необходимо удалить
var
  thread : TLRQThread;

  //vbeg_table : integer; // Начало шаблона таблицы
  vbeg_new_table : integer; // Начало самой таблицы
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  v_date: TDate; // Дата отчета
  v_date_str : string; // Дата отчета в текстовом формате
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  rep_month : string; // Название месяца
  rep_year : string; // Год
  count_stages : integer;
  trconcern : string;

  AConcern_DOG : Integer;

  //ConcDateFrom, ConcDateTo : TDateTime;
  PickMonth : TfmPickMonth;
  rep_date : TDateTime;

  withAddCol : boolean;

  nums : TStrings; // Список ID договоров в порядке, как в перечне договоров
  strDogID : String; // Идентификатор договора
  //num : Integer;

  strAddCol : String;

  //vcols : Integer;

  //vCountTailRows : Integer;

  I : Integer;
  //J : Integer;

  count_treatys : Integer; // Число договоров
  //reporting : string;

  tr_idx : Integer;

  //breakPage_rows : Array of Integer; // Номера строк, где может быть линия разрыва страницы
  //count_no_breakPage_rows : Array of Integer; // КОличество строк подряд, которые не могут содержать линию разрыва страницы
  //progress : Integer;

  //d1, d2 : TDateTime;

begin
 //vbeg_table := beg_table; // Начало шаблона таблицы
 vbeg_new_table := beg_new_table; // Начало самой таблицы

 SetLength(strDogID, SizeOf(Integer));

 v_date := 0;
 rep_date := 0;

 strAddCol := '';

 {if Sender = vpRN01 then
    vCountTailRows := CountTailRows_RN01
  else
    vCountTailRows := CountTailRows_RN02;}

 if Sender = vpRN01 then
   PickMonth := TfmPickMonthWithAddColumn.Create(Self)
 else
   PickMonth := TfmPickMonth.Create(Self);

 withAddCol := false;
 repeat
   if PickMonth.ShowModal=mrOk then
   begin
     v_date_str := '01.' + IntToStr(PickMonth.cbMonth.ItemIndex+1) + '.'+ IntToStr(PickMonth.se_Year.Value);
     rep_date := EncodeDate(PickMonth.se_Year.Value, PickMonth.cbMonth.ItemIndex+1, 1);
     v_date := StrToDate(v_date_str);
     rep_month := PickMonth.cbMonth.Items[PickMonth.cbMonth.ItemIndex];
     rep_year := IntToStr(PickMonth.se_Year.Value);
   end
   else begin  PickMonth.Free; Exit; end;

   AConcern_DOG := -1;

   if Sender = vpRN01 then
   begin
     AConcern_DOG := GetConcern_Treaty(v_date);
     withAddCol := TfmPickMonthWithAddColumn(PickMonth).withAddCol;
   end;

 until (Sender<>vpRN01) or (AConcern_DOG >= 0);
 PickMonth.Free;

// vcols := cols;
  if Sender = vpRN02 then withAddCol := True;

 // ФОРМА RN-01
 if Sender=vpRN01 then
   if withAddCol then
   begin
     St:=ExtractFilePath(Application.ExeName) + 'report\RN-01_2.xlt';
 //    inc(vcols);
   end
   else
     St:=ExtractFilePath(Application.ExeName) + 'report\RN-01.xlt';
 // ФОРМА RN-02
 if Sender=vpRN02 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-02-2.xlt';

 // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

 // Выбираем записи в Excel
 Screen.Cursor:=crHourGlass;
 // Создадим объект Excel.Application
 try
   Excel:=CreateOLEObject('Excel.Application');
 except
   Screen.Cursor:=crDefault;
   MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
              'Ошибка', mb_OK or mb_IconHand);
   Exit;
 end;
  // Вычисляем номера договоров в Перечне договоров
  if AConcern_DOG >= 0 then
    nums := GetNumDogInPerecenDogovorov(AConcern_DOG, v_date)
  else
    nums := GetNumDogInPerecenDogovorov(NULL, v_date);

  try
   InvalidateRect(Handle, nil, True);
   UpdateWindow(Handle);
   // Добавим новую книгу
   try
    Excel.Workbooks.Add(St);
   except
     // Восстановим нормальный курсор
     Screen.Cursor:=crDefault;
     MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                'Ошибка', mb_OK or mb_IconHand);
     Exit;
   end;

   count_treatys := 0;

   // Шапка отчета
   // ФОРМА RN-01
   if Sender=vpRN01 then
   begin
    with TOracleQuery.Create(Self) do
    begin
      Session:= dmGlobal.seOracle;
      {SQL.Append('SELECT  '' ОТ '' ||TO_CHAR(D1.DATESIGN,''DD.MM.YYYY'') || ''г. '' || ''№'' || D1.NUM  DOC1,');
      SQL.Append(''' ОТ '' ||TO_CHAR(D2.DATESIGN,''DD.MM.YYYY'') || ''г. '' || ''№'' || D2.NUM  DOC2,');
      SQL.Append('D2.ID DOG');
      SQL.Append('FROM RN.MITRCONCERN D1, RN.MITRCONCERN D2');
      SQL.Append(FORMAT('WHERE D1.DOG_ID = D2.ID(+) AND TO_DATE(''%s'',''DD.MM.YYYY'') BETWEEN D1.DATEFROM AND D1.DATETO'
                        ,[v_date_str]));}

      //SQL.Append('SELECT  ''№'' || NUM || '' ОТ '' || TO_CHAR(DATESIGN,''DD.MM.YYYY'') || ''г.'' DOG_DOC,');
      SQL.Append('SELECT  '' от '' || DECODE(DATESIGN, NULL, ''             '', TO_CHAR(DATESIGN, ''DD.MM.YYYY'') || ''г.'')  || '' № '' || NUM DOG_DOC,');
      //SQL.Append('        (SELECT ''№'' || AGR.NUM || '' ОТ '' || TO_CHAR(AGR.DATESIGN,''DD.MM.YYYY'') || ''г.''');
      SQL.Append('        (SELECT '' от '' || DECODE(AGR.DATESIGN, NULL, ''             '', TO_CHAR(AGR.DATESIGN, ''DD.MM.YYYY'') || ''г.'')  || '' № '' || AGR.NUM');
      SQL.Append('           FROM RN.MITRCONCERN AGR');
      SQL.Append('          WHERE AGR.DOG_ID = :DOG_ID AND AGR.DATEFROM <= :REP_DATE AND (AGR.DATETO >= :REP_DATE OR AGR.DATETO = (SELECT MAX(AGR1.DATETO) FROM RN.MITRCONCERN AGR1 WHERE AGR1.DOG_ID = :DOG_ID)))  AGR_DOC,');
      SQL.Append('        (SELECT AGR.ID');
      SQL.Append('           FROM RN.MITRCONCERN AGR');
      SQL.Append('          WHERE AGR.DOG_ID = :DOG_ID AND AGR.DATEFROM <= :REP_DATE AND (AGR.DATETO >= :REP_DATE OR AGR.DATETO = (SELECT MAX(AGR1.DATETO) FROM RN.MITRCONCERN AGR1 WHERE AGR1.DOG_ID = :DOG_ID))) AGR');
      SQL.Append('  FROM RN.MITRCONCERN');
      SQL.Append(' WHERE  ID = :DOG_ID');

      DeclareVariable('DOG_ID', otInteger);
      SetVariable('DOG_ID', AConcern_DOG);
      DeclareVariable('REP_DATE', otDate);
      SetVariable('REP_DATE', rep_date);

      Execute;
      if not EOF then
      begin
        if not FieldIsNULL(2) then
        begin
          //Inc(vbeg_table);
          Inc(vbeg_new_table);
          Excel.WorkSheets[1].Rows[9].Insert;
          Excel.WorkSheets[1].Rows[8].Copy(Excel.Worksheets[1].Rows[9]);
          Excel.WorkSheets[1].Cells[9, 1] := 'ДОПОЛНИТЕЛЬНОЕ СОГЛАШЕНИЕ  ' + FieldAsString(1);

          Excel.WorkSheets[1].Cells[8, 1] := 'ОТЧЕТ О ВЫПОЛНЕНИИ РАБОТ ПО ДОГОВОРУ ' + FieldAsString(0);
      end
        else
          Excel.WorkSheets[1].Cells[8, 1] := 'ОТЧЕТ О ВЫПОЛНЕНИИ РАБОТ ПО ДОГОВОРУ ' + FieldAsString(0);
      end
      else
        trconcern:='';
      Close;
      Free;
    end;
   end;
   // ФОРМА RN-02
   if Sender=vpRN02 then Excel.WorkSheets[1].Cells[8, 1] := 'ОТЧЕТ О ВЫПОЛНЕНИИ РАБОТ ПО ДОГОВОРАМ ФИНАНСИРУЕМЫМ ИЗ ПРИБЫЛИ ПРЕДПРИЯТИЯ';

   Excel.WorkSheets[1].Cells[vbeg_new_table - 5, 1] := 'ЗА ' + rep_month + ' ' + rep_year + ' ГОДА'; // Отчетный месяц
   // Выполняем отчет
   with dmglobal.quRN01_RN02_Rep do
   begin
    SetVariable('V_DATETO',v_date);
    SetVariable('V_DATEFROM',v_date);
    //ФОРМА RN-01
    if Sender=vpRN01 then SetVariable('V_ISTFIN_KOD',2); // Инновационный фонд
    //ФОРМА RN-02
    if Sender=vpRN02 then SetVariable('V_ISTFIN_KOD',1); // Из прибыли

    if Sender=vpRN01 then
    begin
      {if ConcDateFrom <> 0 then
        SetVariable('CONC_DATEFROM',ConcDateFrom)
      else
        SetVariable('CONC_DATEFROM',NULL);

      if ConcDateTo <> 0 then
        SetVariable('CONC_DATETO',ConcDateTo)
      else
        SetVariable('CONC_DATETO',NULL); }
      SetVariable('CONC', AConcern_DOG);
    end
    else
    begin
      {SetVariable('CONC_DATEFROM',NULL);
      SetVariable('CONC_DATETO',NULL);}
      SetVariable('CONC', NULL);
    end;

    Execute;
    idx:= vbeg_new_table; prev_id := -1; count := 1;
    count_stages := 0;

    //SetLength(breakPage_rows, 0);
    //SetLength(count_no_breakPage_rows, 0);
    //progress := 1;

    if not EOF then
    begin
      buildingReport.Caption := 'Формируется отчет';
      buildingReport.SetCaption('Идет процесс формирования отчета...');

      // Устанавливаем начальные значения в окне buildingReport
      buildingReport.reset;

      // Делаем в окне buildingReport видимым ProgressBar
      buildingReport.visibleProgressBar(true);

      // Сообщаем  окну buildingReport  о начала копирования данных
      buildingReport.Start;

      count_treatys := FieldAsInteger('count_treaty');

      // Устанавливаем максиальное значение ProgressBar в окне
      buildingReport.SetMax((count_treatys + FieldAsInteger('count_stage')) {* 2});

      //SetLength(breakPage_rows, count_treatys - 1);
      //SetLength(count_no_breakPage_rows, count_treatys - 1);

    end;

    tr_idx := 0;
    while not EOF do
    begin
     try
      // Проверяем тот же самый ли id [Field(0)]
      if Integer(Field(0)) <> prev_id then
      begin // Следующий договор
        strAddCol := '';
       count_stages := Integer(Field(8)); // Количество этапов на договор
       Excel.Worksheets[1].Rows[idx + 1].Insert;

       {if count > 1 then
       begin
         breakPage_rows[count - 2] := idx;
         if count_stages < Max_count_stages then
           count_no_breakPage_rows[count - 2] := count_stages
         else
           count_no_breakPage_rows[count - 2] := Max_count_stages;

         inc(progress, count_no_breakPage_rows[count - 2]);

       end;}

       Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);
       Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку
       inc(count);
       Excel.WorkSheets[1].Cells[idx, 2] := String(Field(1)) + #10 + FieldAsString('exec_name'); // номер договора и исполнитель
       Excel.WorkSheets[1].Cells[idx, 3] := String(Field(2)); // тема договора
       tr_idx := idx;
       inc(idx);
       prev_id := Integer(Field(0));

       buildingReport.Next;
      end;
      Excel.Worksheets[1].Rows[idx + 1].Insert;

      if withAddCol then
        if not FieldIsNull('REPORTING') then
        begin
          if strAddCol <> '' then
            strAddCol := strAddCol + #10 + FieldAsString('REPORTING')
          else
            strAddCol := FieldAsString('REPORTING');
        end;

      // Копируем шаблонную строку в зависимости какой по счету этап
      if count_stages > 1  then
        Excel.WorkSheets[1].Rows[idx + offs_table+1].Copy(Excel.Worksheets[1].Rows[idx])
      else
      begin
        Excel.WorkSheets[1].Rows[idx + offs_table+2].Copy(Excel.Worksheets[1].Rows[idx]);

        // Читаем номер договора в Перечне договоров
        PInteger(strDogID)^ := prev_id;
        //num := nums.IndexOf(strDogID);

        //if num >= 0 then
        //  Excel.WorkSheets[1].Cells[idx, 1] := IntToStr(num + 1) // Номер договора в Перечне договоров
        //else
        //  Excel.WorkSheets[1].Cells[idx, 1] := '';

        if withAddCol and (strAddCol <> '') then
          Excel.WorkSheets[1].Cells[tr_idx, 8] := StringReplace(strAddCol, #13#10,#10, [rfReplaceAll]);

        Excel.WorkSheets[1].Cells[idx, 1] := FieldAsString('num'); //String(Field(0));
      end;

      // Если произошел автоматический разрыв страницы, то необходимо нарисовать нижнюю рамку
      //if Excel.Worksheets[1].Rows[row_no_page_break].PageBreak <> Excel.Worksheets[1].Rows[idx].PageBreak then
        // Произошел автоматический разрыв страницы.
        // Рисуем нижнюю рамку
        //Excel.WorkSheets[1].Range['A' + IntToStr(idx - 1) +':' + chr(ord('A') + vcols - 1) + IntToStr(idx - 1)].Borders[4].LineStyle := 1;

      dec(count_stages);
      Excel.WorkSheets[1].Cells[idx, 3] := String(Field(3));
      // Проверяем код валюты, если не BYR(руб. РБ) то выводим и курс и в другой столбец
      if Integer(Field(4)) <> BYR then
      begin
       Excel.WorkSheets[1].Cells[idx, 4] := Field(5); // Суммма в валюте(не РБ)
       Excel.WorkSheets[1].Cells[idx, 5] := String(Field(6)); // Дата акта вып. работ
       Excel.WorkSheets[1].Cells[idx, 6] := String(Field(7)); // Курс
       //Excel.WorkSheets[1].Cells[idx, 7] := IntToStr(Integer(Field(5))*Integer(Field(7))); // Общая сумма = Курс*Сумму в валюте
      end
      else Excel.WorkSheets[1].Cells[idx, 7] := Field(5); // Сумма для договоров в РБ
      inc(idx);
      buildingReport.Next;
     except
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
     end;
     Next;
    end;

    {if vCountTailRows > 1 then
      inc(progress, vCountTailRows - 1);}

    {if count_treatys > 0 then
      buildingReport.NewValue(progress * 2, progress);}


    {for I := 0 to count_treatys - 2 do
    begin
      for J := 0 to count_no_breakPage_rows[I] - 1 do
      begin
        if Excel.Worksheets[1].Rows[breakPage_rows[I] + j + 1].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
        begin
          Excel.Worksheets[1].Rows[breakPage_rows[I]].PageBreak := 1;
          buildingReport.Next(count_no_breakPage_rows[I] - J);
          break;
        end;
        buildingReport.Next;
      end;
    end;}

    // удаляем записи шаблонной таблицы
    Excel.Worksheets[1].Range['$'+IntToStr(idx) + ':$'+IntToStr(idx+count_delete_row)].Delete;

    if count_treatys > 0 then
      // Увеличеваем значение ProgressBar на еденицу в окне copingForm
      buildingReport.Next;

    Close;
   end;

   {for I := idx + 2 to idx + vCountTailRows  do
   begin
     if Excel.Worksheets[1].Rows[I].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
     begin
       Excel.Worksheets[1].Rows[idx].PageBreak := 1;
       if count_treatys > 0 then
         buildingReport.Next(idx + vCountTailRows - I + 1);
       break;
     end;
     if count_treatys > 0 then
       buildingReport.Next;
   end;}

   if count_treatys > 0 then
     buildingReport.Finish;
   Excel.Run('STRH');
 finally
   Screen.Cursor:=crDefault;
   Excel.Visible:=True;
   nums.Destroy;

   // Окну buildingReport сообщаем, что формирования отчета закончилось
   // и оно должно снять блокировку данных
   buildingReport.SetEndCopy;
   // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
   buildingReport.Close;

   // Делаем доступным приложение, для пользователя
   resetBusy;
 end;
end;

procedure TfmMainMenu.vpRN03RN04Click(Sender: TObject);
const
  //beg_table : integer = 9; // Начало шаблона таблицы
  beg_new_table : integer = 9; // Начало самой таблицы
  offs_table : integer = 3; // Начало шаблона таблицы
  count_cols : integer = 6;  // Количество колонок
  add_size : integer = 11; // Количество елементов, которое за раз добавляется в массив
  count_characters_of_title_row : integer = 100; // Число символов в заголовке отчета
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';
  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы

  CountTailRows_RN03 : integer = 8;  // Кол. строк в конце док., которые должны напечататся на одной странице
  CountTailRows_RN04 : integer = 0;  // Кол. строк в конце док., которые должны напечататся на одной странице
var
  //vbeg_table : integer; // Начало шаблона таблицы
  vbeg_new_table : integer; // Начало самой таблицы

  thread : TLRQThread;
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application

  v_date_str : string; // Дата отчета в текстовом формате
  rep_date : TDateTime;
  v_date: TDate; // Дата отчета
  rep_month : string; // Название месяца
  rep_year : string; // Год
  AConcern_DOG : Integer;

  PickMonth : TfmPickMonth;

  //ConcDateFrom, ConcDateTo : TDateTime;

  St:     OLEVariant;  // Файл темплейта
  //v_date: TDate; // Дата отчета
  //v_date_str : string; // Дата отчета в текстовом формате
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  //rep_month : string; // Название месяца
  //rep_year : string; // Год
  count_stages : integer;
  summpay_per_treaty : Extended;
  summpay_per_year : Extended;
  summpay_stages_closed  : Extended;
  erate_date : tdate;
  erate : Extended;
  quReport : TOracleQuery;

  //Excel_values : array of array of Variant; // Массив c значениями для
  //len_ExcelArray : Integer; // Длина Excel массива
  //count_Excel_Rows : Integer; // Кол Excel. строк
  //Statu_Treaty : char;
  //count_staus_tr : Integer;
  //len_staus_tr : Integer;
  //I, J : Integer;
  I : Integer;

  //Report_Title : String;
  //row_len : Integer;
  //len : Integer;
  //part_title : String;
  //num_title_row : Integer;
  //ch_pos : integer;

  count_dog : Integer; // Количество договоров

  curr_agr : Integer;
  //vCountTailRows : Integer;

  d, m, y : Word;
begin
  {ConcDateFrom := 0;
  ConcDateTo := 0;}

  v_date := 0;
  rep_date := 0;

  vbeg_new_table := beg_new_table;

  {if Sender = vpRN03 then
    vCountTailRows := CountTailRows_RN03
  else
    vCountTailRows := CountTailRows_RN04;}

  PickMonth := TfmPickMonth.Create(Self);
  repeat
    if PickMonth.ShowModal=mrOk then
    begin
      v_date_str := '01.' + IntToStr(PickMonth.cbMonth.ItemIndex+1) + '.'+ IntToStr(PickMonth.se_Year.Value);
      rep_date := EncodeDate(PickMonth.se_Year.Value, PickMonth.cbMonth.ItemIndex+1, 1);
      v_date := StrToDate(v_date_str);
      rep_month := PickMonth.cbMonth.Items[PickMonth.cbMonth.ItemIndex];
      rep_year := IntToStr(PickMonth.se_Year.Value);
    end
    else begin  PickMonth.Free; Exit; end;

    AConcern_DOG := -1;

    if Sender = vpRN03 then
      AConcern_DOG := GetConcern_Treaty(v_date);

  until (Sender<>vpRN03) or (AConcern_DOG >= 0);
  PickMonth.Free;

  // Определяем, отобржать сведенья в отчете последнего доп. соглашения или
  // на дата v_date
  DecodeDate(Now, y, m, d);
  if IncMonth(EncodeDate(y, m, 1), -1) <= v_date then
    // Брать Последение доп. соглашение
    curr_agr := 0
  else
    // Брать доп соглашение на дату, котораю указана в отчете
    curr_agr := 1;

  // ФОРМА RN-03
  if Sender=vpRN03 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-03.xlt';
  // ФОРМА RN-04
  if Sender=vpRN04 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-04.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;
    // Шапка отчета
    //ФОРМА RN-03

    // Количество строк в заголовке
    //num_title_row := 0;

    {if AConcern_DOG > 0 then
      Report_Title := GetTitle_PerecenDogovorov(AConcern_DOG, v_date)
    else
      Report_Title := GetTitle_PerecenDogovorov(NULL, v_date);

    part_title := Trim(Report_Title);
    len := length(part_title);
    while len > 0 do
    begin
      // Вставляем строку заголовка
      inc(num_title_row);
      Excel.WorkSheets[1].Rows[2 + num_title_row].Insert;
      Excel.WorkSheets[1].Rows[2].Copy(Excel.Worksheets[1].Rows[2 + num_title_row]);

      // Определяем, заголовок поместится в одну строку или нет
      if len > count_characters_of_tittle_row then
      begin
        // Заголовок не помещается в одну строку

        // Вычисляем часть заголовка, которую поместим в строку (2 + num_title_row)
        ch_pos := 0;
        for i := count_characters_of_tittle_row + 1 downto 1 do
          if part_title[i] <= ' ' then
          begin
            ch_pos := i - 1;
            break;
          end;
        if ch_pos = 0 then
          for i := count_characters_of_tittle_row + 2 to len do
            if part_title[i] <= ' ' then
            begin
              ch_pos := i - 1;
              break;
            end;
        if ch_pos = 0 then
          ch_pos := len;

        // Помещаем часть заголовка в строку (2 + num_title_row)
        Excel.WorkSheets[1].Cells[2 + num_title_row, 1] := copy(part_title, 1, ch_pos);

        // Удаляем часть заголовка которую поместили в строку
        part_title := trim(copy(part_title, ch_pos + 1, len - ch_pos));
        len := length(part_title);
      end
      else
      begin
        // Помещаем заголовок в строку (2 + num_title_row)
        Excel.WorkSheets[1].Cells[2 + num_title_row, 1] := part_title;

        part_title := '';
        len := 0;
      end;
    end;
    Inc(vbeg_table, num_title_row);
    Inc(vbeg_new_table, num_title_row);}

    if Sender=vpRN03 then
    begin
      with TOracleQuery.Create(Self) do
      begin
        Session:= dmGlobal.seOracle;

        //SQL.Append('SELECT  ''№'' || NUM || '' от '' || TO_CHAR(DATESIGN,''DD.MM.YYYY'') || ''г.'' DOG_DOC,');
        SQL.Append('SELECT  '' от '' || DECODE(DATESIGN, NULL, ''             '', TO_CHAR(DATESIGN, ''DD.MM.YYYY'') || ''г.'')  || '' № '' || NUM DOG_DOC,');
        //SQL.Append('        (SELECT ''№'' || AGR.NUM || '' от '' || TO_CHAR(AGR.DATESIGN,''DD.MM.YYYY'') || ''г.''');
        SQL.Append('        (SELECT '' от '' || DECODE(AGR.DATESIGN, NULL, ''             '', TO_CHAR(AGR.DATESIGN, ''DD.MM.YYYY'') || ''г.'')  || '' № '' || AGR.NUM');
        SQL.Append('           FROM RN.MITRCONCERN AGR');
        SQL.Append('          WHERE AGR.DOG_ID = :DOG_ID AND AGR.DATEFROM <= :REP_DATE AND (AGR.DATETO >= :REP_DATE OR AGR.DATETO = (SELECT MAX(AGR1.DATETO) FROM RN.MITRCONCERN AGR1 WHERE AGR1.DOG_ID = :DOG_ID)))  AGR_DOC,');
        SQL.Append('        (SELECT AGR.ID');
        SQL.Append('           FROM RN.MITRCONCERN AGR');
        SQL.Append('          WHERE AGR.DOG_ID = :DOG_ID AND AGR.DATEFROM <= :REP_DATE AND (AGR.DATETO >= :REP_DATE OR AGR.DATETO = (SELECT MAX(AGR1.DATETO) FROM RN.MITRCONCERN AGR1 WHERE AGR1.DOG_ID = :DOG_ID))) AGR');
        SQL.Append('  FROM RN.MITRCONCERN');
        SQL.Append(' WHERE  ID = :DOG_ID');

        DeclareVariable('DOG_ID', otInteger);
        SetVariable('DOG_ID', AConcern_DOG);
        DeclareVariable('REP_DATE', otDate);
        SetVariable('REP_DATE', rep_date);

        Execute;
        if not EOF then
        begin
          if not FieldIsNULL(2) then
          begin
            //Inc(vbeg_table);
            Inc(vbeg_new_table);
            Excel.WorkSheets[1].Rows[3].Insert;
            Excel.WorkSheets[1].Rows[2].Copy(Excel.Worksheets[1].Rows[3]);
            Excel.WorkSheets[1].Cells[3, 4] := 'доп. соглашение  ' + FieldAsString(1);
          end;

          Excel.WorkSheets[1].Cells[2, 4] := 'к договору  ' + FieldAsString(0);
        end
        else
          Excel.WorkSheets[1].Cells[2, 4] := '';
        Close;
        Free;
      end;
    end;

    Excel.WorkSheets[1].Cells[vbeg_new_table - 2, 6] := 'В т.ч. ' + rep_year + 'г.';

    quReport := nil;
    // ФОРМА RN-03
    if Sender=vpRN03 then quReport := dmglobal.quRN03_Rep;
    // ФОРМА RN-04
    if Sender=vpRN04 then quReport := dmglobal.quRN04_Rep;

    // Выполняем отчет
    with quReport do
    begin
      SetVariable('V_DATE', v_date);

      SetVariable('CURR_AGR', curr_agr);

      if Sender=vpRN03 then
      begin
        SetVariable('CONC', AConcern_DOG);

      end;

      Execute;

      count_dog := 0;
      // Устанавливаем пораметры для отображение процесса формирования отчета
      if not EOF then
      begin
        count_dog := FieldAsInteger('count_treaty');

        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');

        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;

        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);

        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;

        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(count_dog {* 2});
      end;

      idx:= vbeg_new_table; prev_id := -1; count := 1;
      count_stages := 0;
      summpay_per_year := 0;
      erate_date := 0;
      erate := 0;
      summpay_per_treaty := 0;
      summpay_stages_closed := 0;
      while not EOF do
      begin
        try

          // Проверяем тот же самый ли id [Field(0)]
          if Integer(Field(0)) <> prev_id then
          begin // Следующий договор
            if prev_id >= 0 then
              // Увеличеваем значение ProgressBar на еденицу в окне copingForm
              buildingReport.Next;

            {if (count_Excel_Rows + 2) > len_ExcelArray then
            begin
              SetLength(Excel_values, len_ExcelArray + add_size);
              for J := len_ExcelArray to len_ExcelArray + add_size - 1 do
                SetLength(Excel_values[J], count_cols);
              Inc(len_ExcelArray, add_size);
            end;}

            {if (count_staus_tr + 1) > len_staus_tr then
            begin
              SetLength(Status_Treaty, len_staus_tr + add_size);
              Inc(len_staus_tr, add_size);
            end;}

            Excel.Worksheets[1].Rows[idx + 1].Insert;
            Excel.Worksheets[1].Rows[idx + 2].Insert;
            //Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);

            summpay_stages_closed := 0;
            count_stages := Integer(Field(11)); // Количество этапов на договор
            summpay_per_year := 0;
            summpay_per_treaty := Extended(Field(5)); // сумма по договору
            erate_date := Field(10);
            erate := Extended(Field(9));


            if Field(7) = 'O' then // OPERATIVE Действующий договор
            begin
              //Statu_Treaty := 'C';
              Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 2].Copy(Excel.Worksheets[1].Rows[idx + 1]);
            end
            else if Field(7) = 'F' then
            begin
              //Statu_Treaty := 'F';
              Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx + 1]);
              Excel.WorkSheets[1].Cells[idx + 1, 2] := 'ЗАКРЫТ';
              //Excel_values[count_Excel_Rows+1][1] := 'ЗАКРЫТ';
            end
            else if Field(7) = 'A' then
            begin
              //Statu_Treaty := 'A';
              Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx + 1]);
              Excel.WorkSheets[1].Cells[idx + 1, 2] := 'АННУЛИРОВАН';
              //Excel_values[count_Excel_Rows+1][1] := 'АННУЛИРОВАН';
            end;

            Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку
            //Excel_values[count_Excel_Rows][0] := count; // номер по порядку
            inc(count);
            Excel.WorkSheets[1].Cells[idx + 1, 1] := FieldAsString('num'); //String(Field(0)); // id
            //Excel_values[count_Excel_Rows + 1][0] := FieldAsString('num'); //String(Field(0)); // id
            Excel.WorkSheets[1].Cells[idx, 2] := String(Field(1)) + #10 + FieldAsString('exec_name');//String(Field(1)); // номер договора и исполнитель
            //Excel_values[count_Excel_Rows][1] := String(Field(1)) + #10 + FieldAsString('exec_name');//String(Field(1)); // номер договора и исполнитель
            Excel.WorkSheets[1].Cells[idx, 3] := String(Field(2)); // тема договора
            //Excel_values[count_Excel_Rows][2] := String(Field(2)); // тема договора
            Excel.WorkSheets[1].Cells[idx, 4] := String(Field(3)); // дата начала
            //Excel_values[count_Excel_Rows][3] := String(Field(3)); // дата начала
            Excel.WorkSheets[1].Cells[idx + 1, 4] := String(Field(4)); // дата окончания
            //Excel_values[count_Excel_Rows + 1][3] := String(Field(4)); // дата окончания
            inc(idx,2);
            {inc(count_Excel_Rows, 2);
            inc(count_staus_tr);}
            prev_id := Integer(Field(0));
          end;

          // Если произошел автоматический разрыв страницы
          //if Excel.Worksheets[1].Rows[row_no_page_break].PageBreak <> Excel.Worksheets[1].Rows[idx - 1].PageBreak then
          //  Excel.Worksheets[1].Rows[idx - 2].PageBreak := 1;

          dec(count_stages);
          if Integer(Field(6)) <> BYR then // Код валюты РБ.
          begin // Считаем для не РБ
            if (erate_date = null) or (erate_date < Field(10)) then // Курс
            begin
              erate_date := Field(10);
              erate := Extended(Field(9));
            end;
            if Field(12) <> null then
            begin
              summpay_stages_closed := summpay_stages_closed + Extended(Field(8))*Extended(Field(9)); // сумма в РБ для сданных этапов
              summpay_per_treaty := summpay_per_treaty - Extended(Field(8)); // Сумма без сданных этапов
            end;
            if // Проверяем по дате действия, если не акта сдачи
                (     (Field(14) <= StrToDate('31.12.' + rep_year))
                  and (Field(14) >= StrToDate('01.01.' + rep_year))
                  and (Field(12) = null))
                // или, если есть дата акта, то по нему
               or
                (     (Field(12) <= StrToDate('31.12.' + rep_year))
                  and (Field(12) >= StrToDate('01.01.' + rep_year)))
            then
              summpay_per_year := summpay_per_year+Extended(Field(8))*Extended(Field(9));
          end
          else // Считаем для РБ
          begin
            if // Проверяем по дате действия, если не такта сдачи
                (     (Field(14) <= StrToDate('31.12.' + rep_year))
                  and (Field(14) >= StrToDate('01.01.' + rep_year))
                  and (Field(12) = null))
                // или, если есть дата акта, то по нему
               or
                (     (Field(12) <= StrToDate('31.12.' + rep_year))
                  and (Field(12) >= StrToDate('01.01.' + rep_year)))
            then
              summpay_per_year := summpay_per_year+Extended(Field(8));
          end;
          if count_stages < 1 then
          begin
            if summpay_per_year > 0 then
              Excel.WorkSheets[1].Cells[idx - 2,6] := FloatToStr(RoundTo(summpay_per_year, -2))
              //Excel_values[count_Excel_Rows - 2][5] := IntToStr(Round(summpay_per_year))
            else
              Excel.WorkSheets[1].Cells[idx - 2,6] := '';
              //Excel_values[count_Excel_Rows - 2][5] := '';
            if Integer(Field(6)) <> BYR then
            begin
              Excel.WorkSheets[1].Cells[idx - 1,3] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field(15))
                                                      + '  на ' + DateToStr(erate_date);
              //Excel_values[count_Excel_Rows - 1][2] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field(15))
              //                                        + '  на ' + DateToStr(erate_date);
              Excel.WorkSheets[1].Cells[idx - 2,5] := FloatToStr(RoundTo(summpay_per_treaty*erate+summpay_stages_closed, -2));
              //Excel_values[count_Excel_Rows - 2][4] := IntToStr(Round(summpay_per_treaty*erate+summpay_stages_closed));
            end
            else
              Excel.WorkSheets[1].Cells[idx - 2,5]  := FloatToStr(RoundTo(summpay_per_treaty, -2));
              //Excel_values[count_Excel_Rows - 2][4] := IntToStr(Round(summpay_per_treaty));
          end;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;
        Next;
      end;

      {
      if count_Excel_Rows > 0  then
      begin
        Excel.WorkSheets[1].Range['$' + IntToStr(idx - count_Excel_Rows) + ':' +'$' + IntToStr(idx - 1)].Insert;

        for I := 0 to  count_staus_tr - 1 do
        begin
          if Status_Treaty[I] = 'C' then
            Excel.WorkSheets[1].Range['$' + IntToStr(vbeg_table)+':$' + IntToStr(vbeg_table + 1)].Copy(
                                       Excel.WorkSheets[1].Range['$' + IntToStr(idx - count_Excel_Rows + 2*I)
                                       +':$' + IntToStr(idx - count_Excel_Rows + 2*I + 1)])
          else
            Excel.WorkSheets[1].Range['$' + IntToStr(vbeg_table + 2)+':$' + IntToStr(vbeg_table + 3)].Copy(
                                       Excel.WorkSheets[1].Range['$' + IntToStr(idx - count_Excel_Rows + 2*I)
                                       +':$' + IntToStr(idx - count_Excel_Rows + 2*I + 1)]);

          Excel.WorkSheets[1].Range['A' + IntToStr(idx - count_Excel_Rows),
                                    Chr(Ord('A') + count_cols - 1) + IntToStr(idx - 1)].Value
                                    := Variant(Excel_values);
        end;

      end;}


      Excel.Worksheets[1].Rows[idx].Delete;
      Excel.Worksheets[1].Rows[idx].Delete;
      Excel.Worksheets[1].Rows[idx].Delete;
      Excel.Worksheets[1].Rows[idx].Delete;
      Excel.Worksheets[1].Rows[idx].Delete;
      Excel.Worksheets[1].Rows[idx].Delete;  // удаляем записи шаблонной таблицы
      //Excel.Worksheets[1].Rows[2].Delete;

      //ФОРМА RN-03
      if Sender=vpRN03 then Excel.WorkSheets[1].Cells[idx+4,2] := 'на ' + rep_year + ' год';

      {for I := 0 to count_dog - 1 do
      begin
        if Excel.Worksheets[1].Rows[vbeg_new_table + 1 + I*2].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
          Excel.Worksheets[1].Rows[vbeg_new_table + I*2].PageBreak := 1;
        buildingReport.Next;
      end;}

      if count_dog > 0 then
      begin
        // Увеличеваем значение ProgressBar на еденицу в окне copingForm
        buildingReport.Next;

        // Сообщаем  окну buildingReport  о финише формирования отчета
        buildingReport.Finish;
      end;

      Close;
    end;

    {for I := idx + 2 to idx + vCountTailRows  do
     if Excel.Worksheets[1].Rows[I].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
     begin
       Excel.Worksheets[1].Rows[idx].PageBreak := 1;
       break;
     end;}
    Excel.Run('STRH');
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;

    Screen.Cursor:= crDefault;

    // Делаем доступным приложение, для пользователя
    resetBusy;

  end;
end;  // End of vpRN03RN04 Click

procedure TfmMainMenu.vpRN05RN06Click(Sender: TObject);
const
  beg_table : integer = 6; // Начало шаблона таблицы
  beg_new_table : integer = 7; // Начало самой таблицы
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';
var
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  v_date: TDate; // Дата отчета
  v_date_str : string; // Дата отчета в текстовом формате
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  month : integer;
  rep_year : string; // Год

  PickYear : TfmPickYear;
  AConcern_DOG : Integer;
  //ConcDateFrom, ConcDateTo : TDateTime;

  thread : TLRQThread;
  I : Integer;
  count_dog : Integer; // Количество договоров
begin
 {with TfmPickYear.Create(Self) do
 begin
  se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
  if ShowModal=mrOk then
  begin
   v_date_str := '01.01.'+ IntToStr(se_Year.Value);
   v_date := StrToDate(v_date_str);
   rep_year := IntToStr(se_Year.Value);
   Free;
  end
  else begin  Free; Exit; end;
 end;}

  v_date := 0;
  PickYear := TfmPickYear.Create(Self);
  PickYear.se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
  repeat
    if PickYear.ShowModal=mrOk then
    begin
      //year := PickYear.se_Year.Value;
      v_date_str := '01.01.' + IntToStr(PickYear.se_Year.Value);
      v_date := StrToDate(v_date_str);
      rep_year := IntToStr(PickYear.se_Year.Value);
    end
    else begin  PickYear.Free; Exit; end;

    AConcern_DOG := -1;

    if Sender = vpRN05 then
      AConcern_DOG := GetConcern_Treaty(IncMonth(v_date,11));

  until (Sender<>vpRN05) or (AConcern_DOG >= 0);
  PickYear.Free;

  // ФОРМА RN-05
  if Sender=vpRN05 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-05.xlt';
  // ФОРМА RN-06
  if Sender=vpRN06 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-06.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

 // Выбираем записи в Excel
 Screen.Cursor:=crHourGlass;
 // Создадим объект Excel.Application
 try
   Excel:=CreateOLEObject('Excel.Application');
   //Excel.Visible := True;//////////////////-----------------+++++++++++++++
 except
   Screen.Cursor:=crDefault;
   MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
              'Ошибка', mb_OK or mb_IconHand);
   Exit;
 end;
  try
   InvalidateRect(Handle, nil, True);
   UpdateWindow(Handle);
   // Добавим новую книгу
   try
    Excel.Workbooks.Add(St);
   except
     // Восстановим нормальный курсор
     Screen.Cursor:=crDefault;
     MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                'Ошибка', mb_OK or mb_IconHand);
     Exit;
   end;
   // Шапка отчета
   // ФОРМА RN-05
   if Sender=vpRN05 then
   begin
     Excel.WorkSheets[1].Cells[2, 1] := 'ДОГОВОРЫ ФИНАНСИРУЕМЫЕ ИЗ СРЕДСТВ ИННОВАЦИОННОГО ФОНДА НА '
                                        + rep_year + ' ГОД';

     with TOracleQuery.Create(Self) do
     begin
       Session:= dmGlobal.seOracle;

       SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
       SQL.Append('  FROM RN.MITRCONCERN');
       SQL.Append(' WHERE  ID = :DOG_ID');

       DeclareVariable('DOG_ID', otInteger);
       SetVariable('DOG_ID', AConcern_DOG);

       Execute;

       Excel.WorkSheets[1].Cells[3, 1] := FieldAsString(0);

       Destroy;
     end;
   end;

   // ФОРМА RN-06
   if Sender=vpRN06 then
    Excel.WorkSheets[1].Cells[2, 1] := 'ДОГОВОРЫ ФИНАНСИРУЕМЫЕ ИЗ СОБСТВЕННЫХ СРЕДСТВ ОАО ''''БЕЛАРУСЬКАЛИЙ'''' '
                                       + rep_year + ' ГОД';
   // Выполняем отчет
   with dmglobal.quRN05_RN06_Rep do
   begin
    SetVariable('V_DATEFROM',v_date);
    SetVariable('V_DATETO',IncMonth(v_date,11));
    //ФОРМА RN-05
    if Sender=vpRN05 then
    begin
      SetVariable('V_ISTFIN_KOD',2); // Инновационный фонд

      SetVariable('CONC', AConcern_DOG);

      {if ConcDateFrom <> 0 then
        SetVariable('CONC_DATEFROM',ConcDateFrom)
      else
        SetVariable('CONC_DATEFROM',NULL);

      if ConcDateTo <> 0 then
        SetVariable('CONC_DATETO',ConcDateTo)
      else
        SetVariable('CONC_DATETO',NULL); }
    end;

    //ФОРМА RN-06
    if Sender=vpRN06 then
    begin
      SetVariable('V_ISTFIN_KOD',1); // Из прибыли
      {SetVariable('CONC_DATEFROM',NULL);
      SetVariable('CONC_DATETO',NULL);}
    end;

    Execute;

    count_dog := 0;
    // Устанавливаем пораметры для отображение процесса формирования отчета
    if not EOF then
    begin
      count_dog := FieldAsInteger('count_treaty');

      buildingReport.Caption := 'Формируется отчет';
      buildingReport.SetCaption('Идет процесс формирования отчета...');

      // Устанавливаем начальные значения в окне buildingReport
      buildingReport.reset;

      // Делаем в окне buildingReport видимым ProgressBar
      buildingReport.visibleProgressBar(true);

      // Сообщаем  окну buildingReport  о начала копирования данных
      buildingReport.Start;

      // Устанавливаем максиальное значение ProgressBar в окне
      buildingReport.SetMax(count_dog);
    end;

    idx:= beg_new_table; prev_id := -1;
    while not EOF do
    begin
     try
      // Проверяем тот же самый ли id [Field(0)]
      if Integer(Field(0)) <> prev_id then
      begin // Следующий договор
       Excel.Worksheets[1].Rows[idx].Insert;
       Excel.WorkSheets[1].Rows[beg_table].Copy(Excel.Worksheets[1].Rows[idx]);
       Excel.WorkSheets[1].Cells[idx, 1] := String(Field(1)); // номер договора
       Excel.WorkSheets[1].Cells[idx, 15] := String(Field(1)); // номер договора
       inc(idx);
      end;
      if Field(2) <> null then
      begin
       month := Field(2);
       Excel.WorkSheets[1].Cells[idx - 1, month + 1 ] := StrToFloat(Field(3)); // сумма
      end;
      prev_id := Integer(Field(0));
     except
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
     end;
     Next;

     buildingReport.next;
    end;
    Excel.Worksheets[1].Rows[idx].Delete;
    Excel.Worksheets[1].Rows[beg_table].Delete;  // удаляем записи шаблонной таблицы
    Close;

    if count_dog > 0 then
    begin
      // Увеличеваем значение ProgressBar на еденицу в окне copingForm
      buildingReport.Next;

      // Сообщаем  окну buildingReport  о финише формирования отчета
      buildingReport.Finish;
    end;
   end;
 finally
   Screen.Cursor:=crDefault;
   Excel.Visible:=True;

   // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;

    Screen.Cursor:= crDefault;

    // Делаем доступным приложение, для пользователя
    resetBusy;
 end;
end;

procedure TfmMainMenu.vpCuratorsClick(Sender: TObject);
{const
  beg_new_table : integer = 8; // Начало самой таблицы
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

  offs_table : Integer = 3;

  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы
var
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  v_date: TDate; // Дата отчета
  v_date_str : string; // Дата отчета в текстовом формате
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  rep_year : string; // Год
  count_stages : integer;
  summpay_per_treaty : Extended;
  summpay_per_year : Extended;
  summpay_stages_closed  : Extended;
  erate_date : tdate;
  erate : Extended;
  thread : TLRQThread;
  I : Integer;

  Istfin_kod : Integer;
  ConcDogID  : Integer;

  MainFormula1 : String;
  MainFormula2 : String;
  Formula1 : String;
  Formula2 : String;

  rec_count : Integer;
  num_stage : integer; // номер этапа }
const
  beg_new_table : integer = 7; // Начало самой таблицы
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

  offs_table : Integer = 3;

  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы

  COL_BEG_YEARS = 6;
  COL_BEG_PLAN  = 12;

  ROWS_TEMPLATE = 14;
var
  thread : TLRQThread;

  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  count_stages : integer;
  count_plan_st : integer;
  count_un_st : integer;
  summpay_per_treaty  : Extended;
  n_summpay_per_treaty  : Extended;
  summpay_fact_year : Extended;
  summpay_plan_year : Extended;
  summpay_stages_year : array of Extended;
  erate_date : tdate;
  stage_year_to : Integer; // Год окончания этапа
  erate : Extended;
  DogYears : array of Integer;
  I, J : Integer;
  countYears : Integer;
  ExecFormula : String;
  curator : String;

  rec_count : Integer;

  Istfin_kod : Integer;
  ConcDogID  : Integer;

  //changedIstFin : boolean;

  CuratorFormula : String;
  MainFormula : String;
  MinusMainFormula : String;
  Formula : String;
  CuratorYearFormulas : array of String;
  MainYearFormulas : array of String;
  MinusMainYearFormulas : array of String;
  YearFormulas : array of String;
  CuratorPlanFormulas : array of String;
  MainPlanFormulas : array of String;
  MinusPlanFormulas : array of String;
  PlanFormulas : array of String;
  unfufilled_Formula : String;
  curator_unfufilled_Formula : String;
  main_unfufilled_Formula : String;
  minus_main_unfufilled_Formula : String;
  plan_Formula : String;
  curator_plan_Formula : String;
  main_plan_Formula : String;
  minus_main_plan_Formula : String;
  fact_Formula : String;
  curator_fact_Formula : String;
  main_fact_Formula : String;
  minus_main_fact_Formula : String;
  ostatok_formul :String;
  curator_ostaok_formula : String;
  main_ostaok_formula : String;
  minus_ostaok_formula : String;
  //J : Integer;

  planMonths : Integer;

  num_stage : integer; // номер этапа

  tr_status : String;

  colBegYears : Integer;
  colBegPlan  : Integer;

  countColPlan : Integer;

  period : String;
  fromPeriud, toPeriud : TDateTime;
  m : string;
  rows : Integer;

  curr_un_st, curr_pl_st : Integer;

  RowHeight : Extended;

  dateTo : TDAteTime;
  r : Integer;

  newYear : TDateTime;

  ostatok :  Extended;

  AYEAR : Integer;
  AMONTH : Integer;

  tabn : Integer;

  num_curator : Integer;
  year, month, day : word;

function getNameCol(ANumCol : Integer) : String;
begin
  if ANumCol > 26 then
    Result := chr(Ord('A') - 1 + (ANumCol div 26)) + chr(Ord('A') - 1 + (ANumCol mod 26))
  else if ANumCol < 26 then
    Result := chr(Ord('A') - 1 + (ANumCol mod 26))
  else
    Result := 'Z';
end;


begin
  with TfmPickMonth.Create(Self) do
  begin
    cbMonth.ItemIndex := StrToInt(FormatDateTime('m',Date)) - 1;
    if ShowModal=mrOk then
    begin
      AMONTH := cbMonth.ItemIndex + 1;
      AYEAR := se_Year.Value;
      Free;
    end
    else
    begin
      Free;
      Exit;
    end;
  end;


  St:=ExtractFilePath(Application.ExeName) + 'report\PlanCurators.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);


  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
              'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;

  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;


    // Определяем, в какие годы должны или были выполнены этапы договоров
    with dmGlobal.quDogYears do
    begin
      SetVariable('YEAR', AYEAR);

      Execute;

      countYears :=  Integer(Field('count_years'));
      SetLength(DogYears, countYears);
      SetLength(summpay_stages_year, countYears);
      I := 0;
      while not Eof do
      begin
        DogYears[I] := StrToInt(String(Field('year')));
        Inc(I);
        next;
      end;
    end;

    // Вычислям число месяцев по лану финансирование, которое будет в отчете
    planMonths := 12 - (AMonth-1);
    // Кол. колонок отображающих график фонансирование
    countColPlan :=  planMonths + 1;

    // Номер первой колонки, в которой отображажются финасирование договора по годам
    colBegYears := COL_BEG_YEARS;
    // Номер первой колонки, в которой отображажются график финансирования
    colBegPlan  := COL_BEG_PLAN + (countYears - 1);

    // Формирум колоники с отображением  финасирование договора по годам
    if countYears > 1 then
    begin
      for I := 0 to countYears - 2 do
      begin
        ExecFormula := Excel.Worksheets[1].Cells[beg_new_table + offs_table + ROWS_TEMPLATE - 3, colBegYears].Formula;
        Excel.Worksheets[1].Columns[colBegYears].Insert;
        Excel.Worksheets[1].Cells[beg_new_table + offs_table + ROWS_TEMPLATE - 3, colBegYears].Formula := ExecFormula;
      end;
    end
    else if countYears = 0 then
      Excel.Worksheets[1].Columns[colBegYears].Delete;
    for I := 0 to countYears - 1 do
    begin
      Excel.Worksheets[1].Cells[beg_new_table - 2, colBegYears + I].Value := IntToStr(DogYears[I]) + 'г.';
      Excel.Worksheets[1].Cells[beg_new_table - 1, colBegYears + I].Value := IntToStr(colBegYears + I);
    end;

    // Формируем массивы в которых будут содержатся формули вычислющие итоговые значения  финасирование договоров по годам
    SetLength(MainYearFormulas, countYears);
    SetLength(CuratorYearFormulas, countYears);
    SetLength(YearFormulas, countYears);
    SetLength(MinusMainYearFormulas, countYears);
    for I := 0 to countYears - 1 do
    begin
      MainYearFormulas[I] := '';
      CuratorYearFormulas[I] := '';
      YearFormulas[I] := '';
    end;

    // Формирум колоники с отображением  графика финансирования
    for I := 1 to 12 - planMonths do
      Excel.Worksheets[1].Columns[colBegPlan + 1].Delete;
    for I := 0 to countColPlan - 1 do
      Excel.Worksheets[1].Cells[beg_new_table - 1, colBegPlan + I].Value := IntToStr(colBegPlan + I);
    // Формируем массивы в которых будут содержатся формули вычислющие итоговые значения  графика фининсирования
    SetLength(MainPlanFormulas, planMonths);
    SetLength(CuratorPlanFormulas, planMonths);
    SetLength(PlanFormulas, planMonths);
    SetLength(MinusPlanFormulas, planMonths);

    Excel.Worksheets[1].Cells[beg_new_table - 3, colBegPlan + planMonths + 1].Value := String(Excel.Worksheets[1].Cells[beg_new_table - 3, colBegPlan + planMonths + 1])+ ' ' + IntToStr(AYEAR) + 'г.';
    Excel.Worksheets[1].Cells[beg_new_table - 1, colBegPlan + planMonths + 1].Value := IntToStr(colBegPlan + planMonths + 1);

    // Определяем переуд, за который будем считать ФАКТ и ПЛАН
    if planMonths = 12 then
    begin
      period := IntToStr(AYear - 1) + 'г.';
      fromPeriud := EncodeDate(AYear - 1, 1, 1);
      toPeriud := EncodeDate(AYear, 1, 1);
    end
    else if planMonths = 11 then
    begin
      period := ' (январь)';
      fromPeriud := EncodeDate(AYear, 1, 1);
      toPeriud := EncodeDate(AYear, 2, 1);
    end
    else
    begin
      case (planMonths) of
        10: m := 'февраль';
         9: m := 'март';
         8: m := 'апрель';
         7: m := 'май';
         6: m := 'июнь';
         5: m := 'июль';
         4: m := 'август';
         3: m := 'сентябрь';
         2: m := 'октябрь';
         1: m := 'ноябрь';
      end;

      if planMonths = 11 then
        period := 'январь'
      else
        period := IntToStr(12 - planMonths) + 'месяцев';
      period := period + ' в ' + IntToStr(AYear) + 'г.'; //' (январь - ' + m + ')';
      fromPeriud := EncodeDate(AYear, 1, 1);
      toPeriud := EncodeDate(AYear, 12 - planMonths + 1, 1);
    end;
    Excel.WorkSheets[1].Cells[beg_new_table - 3, 10  + countYears - 1] := period;

    Excel.WorkSheets[1].Cells[2, 1] := String(Excel.WorkSheets[1].Cells[2, 1]) + IntToStr(AYEAR) + ' ГОД';

    Excel.Worksheets[1].Cells[beg_new_table - 1,  7  + countYears - 1].Value := IntToStr( 7  + countYears - 1);
    Excel.Worksheets[1].Cells[beg_new_table - 1,  8  + countYears - 1].Value := IntToStr( 8  + countYears - 1);
    Excel.Worksheets[1].Cells[beg_new_table - 1,  9  + countYears - 1].Value := IntToStr( 9  + countYears - 1);
    Excel.Worksheets[1].Cells[beg_new_table - 1, 10  + countYears - 1].Value := IntToStr(10  + countYears - 1);
    Excel.Worksheets[1].Cells[beg_new_table - 1, 11  + countYears - 1].Value := IntToStr(11  + countYears - 1);

    tr_status := '';

    num_stage := 0;
    count_plan_st := 0;
    count_un_st := 0;
    ostatok := 0;
    summpay_fact_year := 0;
    summpay_plan_year := 0;

    // Выполняем отчет
    with dmGlobal.quPlanCurator do
    begin
      SetVariable(':MONTH', AMONTH);
      SetVariable(':YEAR', AYEAR);

      Execute;

      idx:= beg_new_table;
      prev_id := -1;
      count := 1;
      count_stages := 0;
      erate_date := 0;
      erate := 0;
      summpay_per_treaty := 0;
      n_summpay_per_treaty  := 0;
      Istfin_kod := -1;
      ConcDogID := -1;
      MainFormula := '';
      CuratorFormula := '';
      Formula := '';
      unfufilled_Formula := '';
      curator_unfufilled_Formula := '';
      main_unfufilled_Formula := '';
      plan_Formula := '';
      curator_plan_Formula := '';
      main_plan_Formula := '';
      fact_Formula := '';
      curator_fact_Formula := '';
      main_fact_Formula := '';
      ostatok_formul := '';
      curator_ostaok_formula := '';
      main_ostaok_formula := '';
      rows := 0;
      curr_un_st := 0;
      curr_pl_st := 0;
      dateTo := EncodeDate(AYEAR, AMONTH, 1);
      newYear := EncodeDate(AYear + 1, 1, 1);
      tabn := -1;
      num_curator := 0;

      MinusMainFormula := '';
      minus_main_unfufilled_Formula := '';
      minus_main_plan_Formula := '';
      minus_main_fact_Formula := '';
      minus_ostaok_formula := '';
      for I := 0 to countYears - 1 do
        MinusMainYearFormulas[I] := '';
      for I := 0 to planMonths - 1 do
        MinusPlanFormulas[I] := '';


      if FieldIsNull('count_dog') then
        rec_count := 0
      else
        rec_count := FieldAsInteger('count_dog');
      if rec_count > 0 then
      begin

        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');

        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;

        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);

        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;

        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(rec_count);
      end;

      while not EOF do
      begin
        try
          // Проверяем тот же самый ли id [Field(0)]
          if (Integer(Field('ID')) <> prev_id) or
             ((tabn = -1) or (FieldIsNull('tabn') and (tabn <> 0)) or ((not FieldIsNull('tabn')) and (FieldAsInteger('tabn') <> tabn)))then
          begin
            inc(idx, rows);

            if (Istfin_kod <> Integer(Field('Istfin_kod'))) or
               (FieldIsNull('ConcDogID') and (ConcDogID <> -1) and (FieldAsString('treaty_status')<> 'P')) or
               ((not FieldIsNull('ConcDogID')) and (ConcDogID <> Integer(Field('ConcDogID'))) and (FieldAsString('treaty_status')<> 'P')) or
               ((FieldAsString('treaty_status') = 'P') and (tr_status <> 'P')) or
               ((tabn = -1) or (FieldIsNull('tabn') and (tabn <> 0)) or ((not FieldIsNull('tabn')) and (FieldAsInteger('tabn') <> tabn)))
            then
            begin
              if ((tabn = -1) or (FieldIsNull('tabn') and (tabn <> 0)) or ((not FieldIsNull('tabn')) and (FieldAsInteger('tabn') <> tabn))) then
                tr_status := '';
              Istfin_kod := Integer(Field('Istfin_kod'));

              if (FieldIsNull('ConcDogID')) or (FieldAsString('treaty_status') = 'P') then
                ConcDogID := -1
              else
                ConcDogID := Integer(Field('ConcDogID'));

              if Formula <> '' then
              begin
                // Формируем Excel формулы итогов для различных типов договор и источников финансирования
                unfufilled_Formula := unfufilled_Formula + getNameCol(9 +  countYears - 1) + IntToStr(idx - 1) + ')';
                plan_Formula := plan_Formula + getNameCol(10 +  countYears - 1) + IntToStr(idx - 1) + ')';
                fact_Formula := fact_Formula + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx - 1) + ')';
                Formula := Formula + 'E' + IntToStr(idx - 1) + ')';
                for I := 0 to countYears - 1 do
                  YearFormulas[I] := YearFormulas[I] + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx - 1) + ')';
                for I := 0 to planMonths - 1 do
                  PlanFormulas[I] := PlanFormulas[I] + getNameCol(COL_BEG_PLAN   + I  + countYears) + IntToStr(idx - 1) + ')';
                ostatok_formul := ostatok_formul + getNameCol(COL_BEG_PLAN   + planMonths  + countYears) + IntToStr(idx - 1) + ')';

                Excel.Worksheets[1].Rows[idx + 1].Insert;
                Excel.WorkSheets[1].Rows[idx + offs_table + ROWS_TEMPLATE - 3].Copy(Excel.Worksheets[1].Rows[idx]);

                Excel.WorkSheets[1].Cells[idx, 9 + countYears - 1].Formula := unfufilled_Formula;
                Excel.WorkSheets[1].Cells[idx, 10 + countYears - 1].Formula := plan_Formula;
                Excel.WorkSheets[1].Cells[idx, 11 + countYears - 1].Formula := fact_Formula;
                Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula;
                for I := 0 to countYears - 1 do
                  Excel.WorkSheets[1].Cells[idx, colBegYears + I].Formula := YearFormulas[I];
                for I := 0 to planMonths - 1 do
                  Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + I].Formula := PlanFormulas[I];

                Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + planMonths].Formula := ostatok_formul;

                // Формируем Excel формулы итогов по кураторам
                if curator_unfufilled_Formula = '' then
                  curator_unfufilled_Formula := '=Sum(' + getNameCol(9 +  countYears - 1) + IntToStr(idx)
                else
                  curator_unfufilled_Formula := curator_unfufilled_Formula + ', ' + getNameCol(9 +  countYears - 1) + IntToStr(idx);
                if curator_plan_Formula = '' then
                  curator_plan_Formula := '=Sum(' + getNameCol(10 +  countYears - 1) + IntToStr(idx)
                else
                  curator_plan_Formula := curator_plan_Formula + ', ' + getNameCol(10 +  countYears - 1) + IntToStr(idx);
                if curator_fact_Formula = '' then
                  curator_fact_Formula := '=Sum(' + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx)
                else
                  curator_fact_Formula := curator_fact_Formula + ', ' + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx);
                if curatorFormula = '' then
                  curatorFormula := '=Sum(E' + IntToStr(idx)
                else
                  curatorFormula := curatorFormula + ', E' + IntToStr(idx);

                for I := 0 to countYears - 1 do
                  if curatorYearFormulas[I] = '' then
                    curatorYearFormulas[I] := '=Sum(' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx)
                  else
                    curatorYearFormulas[I] := curatorYearFormulas[I] + ', ' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx);

                for I := 0 to planMonths - 1 do
                  if curatorPlanFormulas[I] = '' then
                    curatorPlanFormulas[I] := '=Sum(' + getNameCol(COL_BEG_PLAN  + I  + countYears) + IntToStr(idx)
                  else
                    curatorPlanFormulas[I] := curatorPlanFormulas[I] + ', ' + getNameCol(COL_BEG_PLAN  + I  + countYears) + IntToStr(idx);

                if curator_ostaok_formula = '' then
                  curator_ostaok_formula := '=Sum(' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx)
                else
                  curator_ostaok_formula := curator_ostaok_formula + ', ' + getNameCol(COL_BEG_PLAN  + planMonths + countYears) + IntToStr(idx);

                inc(idx);

                if ((tabn = -1) or (FieldIsNull('tabn') and (tabn <> 0)) or ((not FieldIsNull('tabn')) and (FieldAsInteger('tabn') <> tabn))) then
                begin
                  // Изменился куратор

                  // Вставляем строчку в отчет с итоговыми формулами по куратору
                  Excel.Worksheets[1].Rows[idx + 1].Insert;
                  Excel.WorkSheets[1].Rows[idx + offs_table + ROWS_TEMPLATE - 2].Copy(Excel.Worksheets[1].Rows[idx]);
                  Excel.WorkSheets[1].Cells[idx, 9 + countYears - 1].Formula := curator_unfufilled_Formula;
                  Excel.WorkSheets[1].Cells[idx, 10 + countYears - 1].Formula := curator_plan_Formula;
                  Excel.WorkSheets[1].Cells[idx, 11 + countYears - 1].Formula := curator_fact_Formula;
                  Excel.WorkSheets[1].Cells[idx, 5].Formula := curatorFormula;
                  for I := 0 to countYears - 1 do
                    Excel.WorkSheets[1].Cells[idx, colBegYears + I].Formula := curatorYearFormulas[I];
                  for I := 0 to planMonths - 1 do
                    Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + I].Formula := curatorPlanFormulas[I];
                  Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + planMonths].Formula := curator_ostaok_formula;

                  // Переменные, которые содержали формулы присваеваем пустые строки
                  // чтобы старые формулы не повлили на формирование новых формул
                  curator_unfufilled_Formula := '';
                  curator_plan_Formula := '';
                  curator_fact_Formula := '';
                  curatorFormula := '';
                  for I := 0 to countYears - 1 do
                    curatorYearFormulas[I]  := '';
                  for I := 0 to planMonths - 1 do
                    curatorPlanFormulas[I]  := '';
                  curator_ostaok_formula := '';

                  if main_unfufilled_Formula = '' then
                    main_unfufilled_Formula := '=Sum(' + getNameCol(9 +  countYears - 1) + IntToStr(idx)
                  else
                    main_unfufilled_Formula := main_unfufilled_Formula + ', ' + getNameCol(9 +  countYears - 1) + IntToStr(idx);
                  if main_plan_Formula = '' then
                    main_plan_Formula := '=Sum(' + getNameCol(10 +  countYears - 1) + IntToStr(idx)
                  else
                    main_plan_Formula := main_plan_Formula + ', ' + getNameCol(10 +  countYears - 1) + IntToStr(idx);
                  if main_fact_Formula = '' then
                    main_fact_Formula := '=Sum(' + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx)
                  else
                    main_fact_Formula := main_fact_Formula + ', ' + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx);
                  if MainFormula = '' then
                    MainFormula := '=Sum(E' + IntToStr(idx)
                  else
                    MainFormula := MainFormula + ', E' + IntToStr(idx);

                  for I := 0 to countYears - 1 do
                    if MainYearFormulas[I] = '' then
                      MainYearFormulas[I] := '=Sum(' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx)
                    else
                      MainYearFormulas[I] := MainYearFormulas[I] + ', ' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx);

                  for I := 0 to planMonths - 1 do
                    if MainPlanFormulas[I] = '' then
                      MainPlanFormulas[I] := '=Sum(' + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx)
                    else
                      MainPlanFormulas[I] := MainPlanFormulas[I] + ', ' + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx);

                  if main_ostaok_formula = '' then
                    main_ostaok_formula := '=Sum(' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx)
                  else
                    main_ostaok_formula := main_ostaok_formula + ', ' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx);

                  inc(idx);
                end;

              end;

              unfufilled_Formula := '=Sum(' + getNameCol(9 +  countYears - 1) + IntToStr(idx) + ':';
              plan_Formula := '=Sum(' + getNameCol(10 +  countYears - 1) + IntToStr(idx) + ':';
              fact_Formula := '=Sum('+ getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx) + ':';
              Formula := '=Sum(E' + IntToStr(idx) + ':';
              for I := 0 to countYears - 1 do
                YearFormulas[I] := '=Sum(' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx) + ':';
              for I := 0 to planMonths - 1 do
                PlanFormulas[I] := '=Sum(' + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx) + ':';

              ostatok_formul := '=Sum(' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx) + ':';

              if ((tabn = -1) or (FieldIsNull('tabn') and (tabn <> 0)) or ((not FieldIsNull('tabn')) and (FieldAsInteger('tabn') <> tabn))) then
              begin
                // Начились договора другого куратора

                // В отчет вставляем строчку с фамилей куратора
                Excel.Worksheets[1].Rows[idx + 1].Insert;
                Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx]);

                if FieldIsNull('tabn') then
                  Excel.WorkSheets[1].Cells[idx, 1] := 'БЕЗ КУРАТОРА'
                else
                  Excel.WorkSheets[1].Cells[idx, 1] := FieldAsString('CURATOR');

                inc(idx);
              end;

              Excel.Worksheets[1].Rows[idx + 1].Insert;
              if FieldAsString('treaty_status') = 'P' then
              begin
                // Темы из темплана
                case ISTFIN_KOD of
                  // Источник финансирования собственные средства
                  1 : Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
                  2 : Excel.WorkSheets[1].Rows[idx + offs_table + 2].Copy(Excel.Worksheets[1].Rows[idx]);
                      end;
                tr_status := 'P';
              end
              else
                case ISTFIN_KOD of
                  // Источник финансирования собственные средства
                  1 : Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
                  2 : begin
                        Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);
                        if ConcDogID >= 0 then
                        begin
                          with TOracleQuery.Create(Self) do
                          begin
                            Session:= dmGlobal.seOracle;

                            SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
                            SQL.Append('  FROM RN.MITRCONCERN');
                            SQL.Append(' WHERE  ID = :DOG_ID');

                            DeclareVariable('DOG_ID', otInteger);
                            SetVariable('DOG_ID', ConcDogID);
                            Execute;

                            Excel.WorkSheets[1].Cells[idx, 1] := Excel.WorkSheets[1].Cells[idx, 1].Text + String(FieldAsString(0));

                            Destroy;
                          end;
                        end;
                      end;
                end;

              inc(idx);

              if FieldIsNull('tabn') then
                tabn := 0
              else
                tabn := FieldAsInteger('tabn');
            end;

            num_curator := FieldAsInteger('NUM_CURATOR');

            for I := 0 to countYears - 1 do
              summpay_stages_year[I] := 0;
            summpay_fact_year := 0;
            summpay_plan_year := 0;
            ostatok := 0;

            curr_un_st := 0;
            curr_pl_st := 0;

            // Следующий договор
            count_plan_st := Integer(Field('count_pl_st')); // Количество этапов в плане
            count_un_st := Integer(Field('count_un_st')); // Количество невыполненых этапов

            // Вычисляем количество строк
            if (count_plan_st = 0) and (count_un_st > 0) then
              rows := count_un_st
            else if (count_plan_st > 0) and (count_un_st = 0) then
              rows := count_plan_st
            else
              rows := getNOK(count_plan_st, count_un_st);
            if rows < 2 then
              rows := 2;

            for I := 0 to rows - 1 do
              Excel.Worksheets[1].Rows[idx].Insert;

            //count_stages := Integer(Field('count_per_treaty')); // Количество этапов на договор
            summpay_per_treaty := Extended(Field('tr_summpay')); // сумма по договору
            n_summpay_per_treaty  := 0;
            erate_date := Field('intro_date');
            erate := Extended(Field('e_rate'));

            if (Field(7) = 'O') or (Field(7) = 'P')  then // OPERATIVE Действующий договор
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 4].Copy(Excel.Worksheets[1].Rows[idx]);
              for I := 2 to rows - 1 do
                Excel.WorkSheets[1].Rows[idx + offs_table + rows + 5].Copy(Excel.Worksheets[1].Rows[idx + I - 1]);
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 6].Copy(Excel.Worksheets[1].Rows[idx + rows - 1]);
            end
            else if Field(7) = 'F' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 7].Copy(Excel.Worksheets[1].Rows[idx]);
              for I := 2 to rows - 1 do
                Excel.WorkSheets[1].Rows[idx + offs_table + rows + 8].Copy(Excel.Worksheets[1].Rows[idx + I - 1]);
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 9].Copy(Excel.Worksheets[1].Rows[idx + rows - 1]);
              Excel.WorkSheets[1].Cells[idx + rows - 1, 2] := 'ЗАКРЫТ';
            end
            else if Field(7) = 'A' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 7].Copy(Excel.Worksheets[1].Rows[idx]);
              for I := 2 to rows - 1 do
                Excel.WorkSheets[1].Rows[idx + offs_table + rows + 8].Copy(Excel.Worksheets[1].Rows[idx + I - 1]);
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 9].Copy(Excel.Worksheets[1].Rows[idx + rows - 1]);
              Excel.WorkSheets[1].Cells[idx + rows - 1, 2] := 'АННУЛИРОВАН';
            end;

            Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку

            count_stages := FieldAsInteger('count_per_treaty');
            num_stage := 0;
            inc(count);

            Excel.WorkSheets[1].Cells[idx + rows - 1, 1] := FieldAsString('num'); // id
            Excel.WorkSheets[1].Cells[idx, 2] := String(Field('name')); // номер договора и исполнитель
            Excel.WorkSheets[1].Cells[idx, 3] := String(Field('subject')); // тема договора
            if rows > 2 then
            begin
              RowHeight := Excel.WorkSheets[1].Rows[idx].Height;

              Excel.WorkSheets[1].Range['A'+IntToStr(idx), 'A'+IntToStr(idx + rows - 2)].MergeCells := true;
              Excel.WorkSheets[1].Range['B'+IntToStr(idx), 'B'+IntToStr(idx + rows - 2)].MergeCells := true;
              Excel.WorkSheets[1].Range['C'+IntToStr(idx), 'C'+IntToStr(idx + rows - 2)].MergeCells := true;

              if Excel.WorkSheets[1].Rows[IntToStr(idx)+ ':'+ IntToStr(idx + rows - 2)].Height < RowHeight then
                Excel.WorkSheets[1].Rows[IntToStr(idx)+ ':'+ IntToStr(idx + rows - 1)].RowHeight := RowHeight/(rows - 1);
            end;
            Excel.WorkSheets[1].Range['E'+IntToStr(idx), 'E'+IntToStr(idx + rows - 1)].MergeCells := true;
            for I := 0 to countYears - 1 do
              Excel.WorkSheets[1].Range[getNameCol(COL_BEG_YEARS + I)+IntToStr(idx), getNameCol(COL_BEG_YEARS + I)+IntToStr(idx + rows - 1)].MergeCells := true;
            Excel.WorkSheets[1].Range[getNameCol(10 + countYears - 1)+IntToStr(idx), getNameCol(10 + countYears - 1)+IntToStr(idx + rows - 1)].MergeCells := true;
            Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN  - 1 + countYears - 1)+IntToStr(idx), getNameCol(COL_BEG_PLAN  - 1 + countYears - 1)+IntToStr(idx + rows - 1)].MergeCells := true;

            Excel.WorkSheets[1].Cells[idx + rows - 2, 4] := String(Field('tr_datefrom')); // дата начала
            Excel.WorkSheets[1].Cells[idx + rows - 1, 4] := String(Field('tr_dateto')); // дата окончания

            if count_un_st = 0 then
            begin
              Excel.WorkSheets[1].Range[getNameCol(7 +  countYears - 1)+IntToStr(idx), getNameCol(7 +  countYears - 1)+IntToStr(idx + rows - 1)].MergeCells := true;
              Excel.WorkSheets[1].Range[getNameCol(8 +  countYears - 1)+IntToStr(idx), getNameCol(8 +  countYears - 1)+IntToStr(idx + rows - 1)].MergeCells := true;
              Excel.WorkSheets[1].Range[getNameCol(9 +  countYears - 1)+IntToStr(idx), getNameCol(9 +  countYears - 1)+IntToStr(idx + rows - 1)].MergeCells := true;
            end;

            if count_plan_st = 0 then
            begin
              for I := 0 to planMonths do
                Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN  - 1 + I +  countYears)+IntToStr(idx), getNameCol(COL_BEG_PLAN  - 1 + I +  countYears)+IntToStr(idx + rows - 1)].MergeCells := true;
            end;

            Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN + planMonths + countYears)+IntToStr(idx), getNameCol(COL_BEG_PLAN  + planMonths + countYears)+IntToStr(idx + rows - 1)].MergeCells := true;

            if num_curator > 1 then
            begin
              MinusMainFormula := MinusMainFormula + ' -E'+IntToStr(idx);
              minus_main_unfufilled_Formula := minus_main_unfufilled_Formula + ' -SUM(' +  getNameCol(9 +  countYears - 1) + IntToStr(idx) + ':' + getNameCol(9 +  countYears - 1) + IntToStr(idx + rows - 1) + ')';
              minus_main_plan_Formula := minus_main_plan_Formula + ' -SUM(' +  getNameCol(10 +  countYears - 1) + IntToStr(idx) + ':' + getNameCol(10 +  countYears - 1) + IntToStr(idx + rows - 1) + ')';
              minus_main_fact_Formula := minus_main_fact_Formula + ' -SUM(' +  getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx) + ':' + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx + rows - 1) + ')';
              minus_ostaok_formula := minus_ostaok_formula + ' -' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx);
              for I := 0 to countYears - 1 do
                MinusMainYearFormulas[I] := MinusMainYearFormulas[I] + ' -' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx);
              for I := 0 to planMonths - 1 do
                MinusPlanFormulas[I] := MinusPlanFormulas[I] + ' -SUM(' + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx) + ':' + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx + rows - 1) + ')';
            end;

          end;

          if not FieldIsNull('st_dateto') then
          begin
            if (FieldAsDate('st_dateto') < dateTo) and FieldIsNull('st_dateact') then
            begin
              // Не выполненный этап

              // Определяем число ячеек, где будут размещен не выполненый этап
              r := rows div count_un_st;
              if r > 1 then
              begin
                Excel.WorkSheets[1].Range[getNameCol(7 +  countYears - 1)+IntToStr(idx + curr_un_st*r), getNameCol(7 +  countYears - 1)+IntToStr(idx + (curr_un_st+1)*r - 1)].MergeCells := true;
                Excel.WorkSheets[1].Range[getNameCol(8 +  countYears - 1)+IntToStr(idx + curr_un_st*r), getNameCol(8 +  countYears - 1)+IntToStr(idx + (curr_un_st+1)*r - 1)].MergeCells := true;
                Excel.WorkSheets[1].Range[getNameCol(9 +  countYears - 1)+IntToStr(idx + curr_un_st*r), getNameCol(9 +  countYears - 1)+IntToStr(idx + (curr_un_st+1)*r - 1)].MergeCells := true;
              end;

              Excel.WorkSheets[1].Cells[idx + curr_un_st*r, 7 + countYears - 1] := FieldAsString('st_num');
              Excel.WorkSheets[1].Cells[idx + curr_un_st*r, 8 + countYears - 1] := FieldAsString('str_st_dateto');
              Excel.WorkSheets[1].Cells[idx + curr_un_st*r, 9 + countYears - 1] := (FieldAsFloat('e_rate')*Extended(Field('stage_summpay')));
              inc(curr_un_st);
            end;

            if (FieldAsDate('st_dateto') >= dateTo) and (FieldAsDate('st_dateto') < newYear) {and FieldIsNull('st_dateact')} then
            begin
              // График финансирования

              // Определяем число ячеек, где будут размещен не выполненый этап
              r := rows div count_plan_st;

              if not FieldIsNull('st_dateact') then
              begin
                // Этап сдан
                // Выделяем сданные этапы
                for I := 0 to r - 1 do
                begin
                  if (I = 0) and (curr_pl_st = 0) then
                    Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN  - 1 + countYears) + IntToStr(idx + offs_table + rows + 7),
                                              getNameCol(COL_BEG_PLAN  - 1 + countYears + countColPlan - 1) + IntToStr(idx + offs_table + rows + 7)].Copy(
                                  Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN  - 1 + countYears) + IntToStr(idx + r*curr_pl_st + I),
                                                            getNameCol(COL_BEG_PLAN  - 1 + countYears + countColPlan - 1) + IntToStr(idx + r*curr_pl_st + I)])
                  else if (I = (r - 1)) and (curr_pl_st = (count_plan_st - 1)) then
                    Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN  - 1 + countYears) + IntToStr(idx + offs_table + rows + 9),
                                              getNameCol(COL_BEG_PLAN  - 1 + countYears + countColPlan - 1) + IntToStr(idx + offs_table + rows + 9)].Copy(
                                  Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN  - 1 + countYears) + IntToStr(idx + r*curr_pl_st + I),
                                                            getNameCol(COL_BEG_PLAN  - 1 + countYears + countColPlan - 1) + IntToStr(idx + r*curr_pl_st + I)])
                  else
                    Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN  - 1 + countYears) + IntToStr(idx + offs_table + rows + 8),
                                              getNameCol(COL_BEG_PLAN  - 1 + countYears + countColPlan - 1) + IntToStr(idx + offs_table + rows + 8)].Copy(
                                  Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN  - 1 + countYears) + IntToStr(idx + r*curr_pl_st + I),
                                                            getNameCol(COL_BEG_PLAN  - 1 + countYears + countColPlan - 1) + IntToStr(idx + r*curr_pl_st + I)]);

                end;
              end;

              if r > 1 then
                for I := 0 to countColPlan - 1 do
                  Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN  - 1 + countYears + I) +IntToStr(idx + curr_pl_st*r), getNameCol(COL_BEG_PLAN  - 1 + countYears + I)+IntToStr(idx + (curr_pl_st+1)*r - 1)].MergeCells := true;

              Excel.WorkSheets[1].Cells[idx + curr_pl_st*r, colBegPlan] := FieldAsString('st_num');
              // вычисляем столбец, куда будет занесено сумма этапа
              DecodeDate(FieldAsDate('st_dateto'), year, month, day);
              J := colBegPlan + month - (12 - planMonths);
              Excel.WorkSheets[1].Cells[idx + curr_pl_st*r, J] := (FieldAsFloat('e_rate')*Extended(Field('stage_summpay')));

              inc(curr_pl_st);
            end;

          end;

          //dec(count_stages);
          inc(num_stage);
          if not FieldIsNull('stage_year_to') then
          begin
            stage_year_to := StrToInt(String(Field('stage_year_to')));
            for I := 0 to countYears - 1 do
              if stage_year_to = DogYears[I] then
              begin
                summpay_stages_year[I] := summpay_stages_year[I] + (Extended(Field('stage_summpay'))*FieldAsFloat('e_rate'));
                break;
              end;
          end;

          n_summpay_per_treaty  := n_summpay_per_treaty + (Extended(Field('stage_summpay'))*FieldAsFloat('e_rate'));
          summpay_per_treaty := summpay_per_treaty - Extended(Field('stage_summpay'));

          if (FieldAsDate('st_dateto') >= fromPeriud) and (FieldAsDate('st_dateto') < toPeriud) then
          begin
            summpay_plan_year := summpay_plan_year + (FieldAsFloat('e_rate')*Extended(Field('stage_summpay')));
          end;

          if (FieldIsNull('st_dateact')) and (FieldAsDate('st_dateto') >= EncodeDate(AYear, 1, 1)) and (FieldAsDate('st_dateto') < EncodeDate(AYear + 1, 1, 1)) then
            ostatok := ostatok + (FieldAsFloat('e_rate')*Extended(Field('stage_summpay')));

          if (FieldAsDate('st_dateto') >= fromPeriud) and (FieldAsDate('st_dateto') < toPeriud) and (not FieldIsNULL('st_dateact')) then
          begin
            summpay_fact_year := summpay_fact_year + (FieldAsFloat('e_rate')*Extended(Field('stage_summpay')));
          end;

          if num_stage = count_stages then
          begin
            if Integer(Field(6)) <> BYR then
            begin
              Excel.WorkSheets[1].Cells[idx + rows - 1 , 3] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field('currency_name'))
                                                    + '  на ' + DateToStr(erate_date);
              Excel.WorkSheets[1].Cells[idx, 5] :=  FloatToStr(RoundTo(n_summpay_per_treaty + summpay_per_treaty*erate, -2));

              for I := 0 to countYears - 1 do
                if summpay_stages_year[I] > 0 then
                  Excel.WorkSheets[1].Cells[idx, colBegYears + I] := FloatToStr(RoundTo(summpay_stages_year[I], -2));

            end
            else
            begin
              Excel.WorkSheets[1].Cells[idx, 5] := FloatToStr(RoundTo(n_summpay_per_treaty + summpay_per_treaty, -2));

              for I := 0 to countYears - 1 do
                if summpay_stages_year[I] > 0 then
                  Excel.WorkSheets[1].Cells[idx, colBegYears + I] := FloatToStr(RoundTo(summpay_stages_year[I], -2));

            end;

            if tr_status <> 'P' then
            begin
              Excel.WorkSheets[1].Cells[idx, 10 + countYears - 1] := FloatToStr(RoundTo(summpay_plan_year, -2));
              Excel.WorkSheets[1].Cells[idx, 11 + countYears - 1] := FloatToStr(RoundTo(summpay_fact_year, -2));
              if ostatok <> 0 then
                Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + planMonths] := FloatToStr(RoundTo(ostatok,-2));

            end;
          end;
          prev_id := Integer(Field('ID'));


          if num_stage = count_stages then
            buildingReport.Next;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;
        Next;
      end;
      inc(idx, rows);

      if Formula <> '' then
      begin
        unfufilled_Formula := unfufilled_Formula + getNameCol(9 +  countYears - 1) + IntToStr(idx - 1) + ')';
        plan_Formula := plan_Formula + getNameCol(10 +  countYears - 1) + IntToStr(idx - 1) + ')';
        fact_Formula := fact_Formula + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx - 1) + ')';
        Formula := Formula + 'E' + IntToStr(idx - 1) + ')';
        for I := 0 to countYears - 1 do
          YearFormulas[I] := YearFormulas[I] + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx - 1) + ')';
        for I := 0 to planMonths - 1 do
          PlanFormulas[I] := PlanFormulas[I] + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx - 1) + ')';

        ostatok_formul := ostatok_formul + getNameCol(COL_BEG_PLAN  + planMonths + countYears) + IntToStr(idx - 1) + ')';

        Excel.Worksheets[1].Rows[idx + 1].Insert;
        Excel.WorkSheets[1].Rows[idx + offs_table + ROWS_TEMPLATE - 3].Copy(Excel.Worksheets[1].Rows[idx]);

        Excel.WorkSheets[1].Cells[idx, 9 + countYears - 1].Formula := unfufilled_Formula;
        Excel.WorkSheets[1].Cells[idx, 10 + countYears - 1].Formula := plan_Formula;
        Excel.WorkSheets[1].Cells[idx, 11 + countYears - 1].Formula := fact_Formula;
        Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula;
        for I := 0 to countYears - 1 do
          Excel.WorkSheets[1].Cells[idx, colBegYears + I].Formula := YearFormulas[I];
        for I := 0 to planMonths - 1 do
          Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + I].Formula := PlanFormulas[I];

        Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + planMonths].Formula := ostatok_formul;

        // Формируем Excel формулы итогов по кураторам
        if curator_unfufilled_Formula = '' then
          curator_unfufilled_Formula := '=Sum(' + getNameCol(9 +  countYears - 1) + IntToStr(idx)
        else
          curator_unfufilled_Formula := curator_unfufilled_Formula + ', ' + getNameCol(9 +  countYears - 1) + IntToStr(idx);
        if curator_plan_Formula = '' then
          curator_plan_Formula := '=Sum(' + getNameCol(10 +  countYears - 1) + IntToStr(idx)
        else
          curator_plan_Formula := curator_plan_Formula + ', ' + getNameCol(10 +  countYears - 1) + IntToStr(idx);
        if curator_fact_Formula = '' then
          curator_fact_Formula := '=Sum(' + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx)
        else
          curator_fact_Formula := curator_fact_Formula + ', ' + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx);
        if curatorFormula = '' then
          curatorFormula := '=Sum(E' + IntToStr(idx)
        else
          curatorFormula := curatorFormula + ', E' + IntToStr(idx);

        for I := 0 to countYears - 1 do
          if curatorYearFormulas[I] = '' then
            curatorYearFormulas[I] := '=Sum(' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx)
          else
            curatorYearFormulas[I] := curatorYearFormulas[I] + ', ' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx);

        for I := 0 to planMonths - 1 do
          if curatorPlanFormulas[I] = '' then
            curatorPlanFormulas[I] := '=Sum(' + getNameCol(COL_BEG_PLAN + I  + countYears) + IntToStr(idx)
          else
            curatorPlanFormulas[I] := curatorPlanFormulas[I] + ', ' + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx);

        if curator_ostaok_formula = '' then
          curator_ostaok_formula := '=Sum(' + getNameCol(COL_BEG_PLAN  + planMonths + countYears) + IntToStr(idx)
        else
          curator_ostaok_formula := curator_ostaok_formula + ', ' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx);

        inc(idx);

        Excel.Worksheets[1].Rows[idx + 1].Insert;
        Excel.WorkSheets[1].Rows[idx + offs_table + ROWS_TEMPLATE - 2].Copy(Excel.Worksheets[1].Rows[idx]);
        Excel.WorkSheets[1].Cells[idx, 9 + countYears - 1].Formula := curator_unfufilled_Formula;
        Excel.WorkSheets[1].Cells[idx, 10 + countYears - 1].Formula := curator_plan_Formula;
        Excel.WorkSheets[1].Cells[idx, 11 + countYears - 1].Formula := curator_fact_Formula;
        Excel.WorkSheets[1].Cells[idx, 5].Formula := curatorFormula;
        for I := 0 to countYears - 1 do
          Excel.WorkSheets[1].Cells[idx, colBegYears + I].Formula := curatorYearFormulas[I];
        for I := 0 to planMonths - 1 do
          Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + I].Formula := curatorPlanFormulas[I];
        Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + planMonths].Formula := curator_ostaok_formula;

        if MainFormula = '' then
        begin
          main_unfufilled_Formula := '=SUM(' + getNameCol(9 +  countYears - 1) + IntToStr(idx) + ')';
          main_plan_Formula := '=SUM(' + getNameCol(10 +  countYears - 1) + IntToStr(idx) + ')';
          main_fact_Formula := '=SUM(' + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1) + IntToStr(idx) + ')';
          MainFormula := '=SUM(E' + IntToStr(idx) + ')';
        end
        else
        begin
          main_unfufilled_Formula := main_unfufilled_Formula +  ', ' + getNameCol(9 +  countYears - 1) + IntToStr(idx) + ')';
          main_plan_Formula := main_plan_Formula +  ', ' + getNameCol(10 +  countYears - 1) + IntToStr(idx) + ')';
          main_fact_Formula := main_fact_Formula +  ', ' + getNameCol(COL_BEG_PLAN  - 1 +  countYears - 1)+ IntToStr(idx) + ')';
          MainFormula := MainFormula +  ', E' + IntToStr(idx) + ')';
        end;
        for I := 0 to countYears - 1 do
          if MainYearFormulas[I] = '' then
            MainYearFormulas[I] := '=Sum(' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx) + ')'
          else
            MainYearFormulas[I] := MainYearFormulas[I] + ', ' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx)+ ')';

        for I := 0 to planMonths - 1 do
          if MainPlanFormulas[I] = '' then
            MainPlanFormulas[I] := '=Sum(' + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx)+ ')'
          else
            MainPlanFormulas[I] := MainPlanFormulas[I] + ', ' + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx)+ ')';

        if main_ostaok_formula = '' then
          main_ostaok_formula := '=Sum(' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx)+ ')'
        else
          main_ostaok_formula := main_ostaok_formula + ', ' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx)+ ')';

        if MinusMainFormula <> '' then
        begin
          MainFormula := MainFormula + MinusMainFormula;
          main_unfufilled_Formula := main_unfufilled_Formula + minus_main_unfufilled_Formula;
          main_plan_Formula := main_plan_Formula + minus_main_plan_Formula;
          main_fact_Formula := main_fact_Formula + minus_main_fact_Formula;
          main_ostaok_formula := main_ostaok_formula + minus_ostaok_formula;
          for I := 0 to countYears - 1 do
            MainYearFormulas[I] := MainYearFormulas[I] + MinusMainYearFormulas[I];
          for I := 0 to planMonths - 1 do
            MainPlanFormulas[I] := MainPlanFormulas[I] + MinusPlanFormulas[I];
        end;

        inc(idx);

        Excel.Worksheets[1].Rows[idx + 1].Insert;
        Excel.WorkSheets[1].Rows[idx + offs_table + ROWS_TEMPLATE - 1].Copy(Excel.Worksheets[1].Rows[idx]);

        Excel.WorkSheets[1].Cells[idx, 9 + countYears - 1].Formula := main_unfufilled_Formula;
        Excel.WorkSheets[1].Cells[idx, 10 + countYears - 1].Formula := main_plan_Formula;
        Excel.WorkSheets[1].Cells[idx, 11 + countYears - 1].Formula := main_fact_Formula;
        Excel.WorkSheets[1].Cells[idx, 5].Formula := MainFormula;
        for I := 0 to countYears - 1 do
          Excel.WorkSheets[1].Cells[idx, colBegYears + I].Formula := MainYearFormulas[I];
        for I := 0 to planMonths - 1 do
          Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + I].Formula := MainPlanFormulas[I];

        Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + planMonths].Formula := main_ostaok_formula;

        inc(idx);
      end;


      for I := 0 to ROWS_TEMPLATE + offs_table - 1 do
        Excel.Worksheets[1].Rows[idx].Delete;  // удаляем записи шаблонной таблицы
      Close;

    end;

   if rec_count > 0 then
   begin
     //buildingReport.Next;
     buildingReport.Finish;
   end;

  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;


  {with TfmPickYear.Create(Self) do
  begin
    se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
    if ShowModal=mrOk then
    begin
      v_date_str := '01.01.'+ IntToStr(se_Year.Value);
      v_date := StrToDate(v_date_str);
      rep_year := IntToStr(se_Year.Value);
      Free;
    end
    else begin  Free; Exit; end;
  end;

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  St:=ExtractFilePath(Application.ExeName) + 'report\Curators.xlt';


  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    Excel.WorkSheets[1].Cells[3, 1] := 'НА ' + rep_year + ' ГОД'; // Отчетный месяц
    Excel.WorkSheets[1].Cells[6, 6] := 'В т.ч. ' + rep_year + 'г.';

    //count_row := 0;

    // Выполняем отчет
    with dmglobal.quCurators do
    begin
      SetVariable('V_DATE',v_date);
      Execute;

      idx:= beg_new_table; prev_id := -1; count := 1;
      count_stages := 0;
      summpay_per_year := 0;
      erate_date := 0;
      erate := 0;
      summpay_per_treaty := 0;
      summpay_stages_closed := 0;
      Istfin_kod := -1;
      ConcDogID := -1;
      MainFormula1 := '';
      MainFormula2 := '';
      Formula1 := '';
      Formula2 := '';
      //changedIstFin := false;

      if FieldIsNull('count_treatys') then
        rec_count := 0
      else
        rec_count := FieldAsInteger('count_treatys');
      if rec_count > 0 then
      begin

        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');

        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;

        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);

        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;

        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(rec_count);
      end;

      num_stage := 0;

      while not EOF do
      begin
        try
          // Проверяем тот же самый ли id [Field(0)]
          if Integer(Field(0)) <> prev_id then
          begin // Следующий договор

            if (Istfin_kod <> Integer(Field('Istfin_kod'))) or
               (FieldIsNull('ConcDogID') and (ConcDogID <> -1)) or
               ((not FieldIsNull('ConcDogID')) and (ConcDogID <> Integer(Field('ConcDogID'))))
            then
            begin

              Istfin_kod := Integer(Field('Istfin_kod'));
              if FieldIsNull('ConcDogID') then
                ConcDogID := -1
              else
                ConcDogID := Integer(Field('ConcDogID'));


              if Formula1 <> '' then
              begin
                // Формируем формулы ИТОГО
                Formula1 := Formula1 + 'E' + IntToStr(idx - 1) + ')';
                Formula2 := Formula2 + 'F' + IntToStr(idx - 1) + ')';

                // Вставляем строки ИТОГО
                Excel.Worksheets[1].Rows[idx + 1].Insert;
                Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx]);

                Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula1;
                Excel.WorkSheets[1].Cells[idx, 6].Formula := Formula2;

                // Формируем формулы ВСЕГО
                if MainFormula1 = '' then
                begin
                  MainFormula1 := '=Sum(E' + IntToStr(idx);
                  MainFormula2 := '=Sum(F' + IntToStr(idx);
                end
                else
                begin
                  MainFormula1 := MainFormula1 + ', E' + IntToStr(idx);
                  MainFormula2 := MainFormula2 + ', F' + IntToStr(idx);
                end;

                inc(idx);
              end;

              // Формируем формулы ИТОГО
              Formula1 := '=Sum(E' + IntToStr(idx) + ':';
              Formula2 := '=Sum(F' + IntToStr(idx) + ':';

              Excel.Worksheets[1].Rows[idx + 1].Insert;

              case ISTFIN_KOD of
                // Источник финансирования собственные средства
                1 : Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
                // Источник финансирования инновационный фонд
                2 : begin
                      Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);
                      if ConcDogID >= 0 then
                      begin
                        // Составляем строку с номером рамочного договора
                        with TOracleQuery.Create(Self) do
                        begin
                          Session:= dmGlobal.seOracle;

                          SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
                          SQL.Append('  FROM RN.MITRCONCERN');
                          SQL.Append(' WHERE  ID = :DOG_ID');

                          DeclareVariable('DOG_ID', otInteger);
                          SetVariable('DOG_ID', ConcDogID);
                          Execute;

                          Excel.WorkSheets[1].Cells[idx, 1] := Excel.WorkSheets[1].Cells[idx, 1].Text + String(FieldAsString(0));

                          Destroy;
                        end;
                      end;
                    end;
              end;

              // Устанавливаем флажок, что была вставлина строка с источником финансирования
              //changedIstFin := true;

              inc(idx);
            end;

            // Следующий договор
            summpay_stages_closed := 0;
            //count_stages := Integer(Field(11)); // Количество этапов на договор
            summpay_per_year := 0;
            summpay_per_treaty := Extended(Field(5)); // сумма по договору
            erate_date := Field(10);
            erate := Extended(Field(9));
            Excel.Worksheets[1].Rows[idx].Insert;
            Excel.Worksheets[1].Rows[idx].Insert;

            if Field(7) = 'O' then // OPERATIVE Действующий договор
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 2 + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 3 + 1].Copy(Excel.Worksheets[1].Rows[idx + 1]);
            end
            else if Field(7) = 'F' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 4 + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 5 + 1].Copy(Excel.Worksheets[1].Rows[idx+1]);
              Excel.WorkSheets[1].Cells[idx+1, 2] := 'ЗАКРЫТ';
            end
            else if Field(7) = 'A' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 4 + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 5 + 1].Copy(Excel.Worksheets[1].Rows[idx+1]);
              Excel.WorkSheets[1].Cells[idx+1, 2] := 'АННУЛИРОВАН';
            end;
            Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку

            count_stages := FieldAsInteger('count_per_treaty');
            num_stage := 0;
            inc(count);

            Excel.WorkSheets[1].Cells[idx+1, 1] := FieldAsString('num'); //String(Field(0)); // id
            Excel.WorkSheets[1].Cells[idx, 2] := String(Field(1)); // номер договора и исполнитель
            Excel.WorkSheets[1].Cells[idx, 3] := String(Field(2)); // тема договора
            Excel.WorkSheets[1].Cells[idx, 4] := String(Field(3)); // дата начала
            Excel.WorkSheets[1].Cells[idx+1, 4] := String(Field(4)); // дата окончания
            Excel.WorkSheets[1].Cells[idx, 7] := String(Field('CURATOR')); // Куратор
            inc(idx,2);
          end;

          //dec(count_stages);
          inc(num_stage);

          if Integer(Field(6)) <> BYR then // Код валюты РБ.
          begin // Считаем для не РБ
            if (erate_date = null) or (erate_date < Field(10)) then // Курс
            begin
              erate_date := Field(10);
              erate := Extended(Field(9));
            end;

            if Field(12) <> null then
            begin
              summpay_stages_closed := summpay_stages_closed + Extended(Field(8))*Extended(Field(9)); // сумма в РБ для сданных этапов
              summpay_per_treaty := summpay_per_treaty - Extended(Field(8)); // Сумма без сданных этапов
            end;
            if // Проверяем по дате действия, если нет акта сдачи
                (     (Field(14) <= StrToDate('31.12.' + rep_year))
                  and (Field(14) >= StrToDate('01.01.' + rep_year))
                  and (Field(12) = null))
                // или, если есть дата акта, то по нему
               or
                (     (Field(12) <= StrToDate('31.12.' + rep_year))
                  and (Field(12) >= StrToDate('01.01.' + rep_year)))
            then
              summpay_per_year := summpay_per_year+Extended(Field(8))*Extended(Field(9));
          end
          else // Считаем для РБ
          begin
            if // Проверяем по дате действия, если нет акта сдачи
               (     (Field(14) <= StrToDate('31.12.' + rep_year))
                 and (Field(14) >= StrToDate('01.01.' + rep_year))
                 and (Field(12) = null))
               // или, если есть дата акта, то по нему
              or
               (     (Field(12) <= StrToDate('31.12.' + rep_year))
                 and (Field(12) >= StrToDate('01.01.' + rep_year)))
            then
              summpay_per_year := summpay_per_year+Extended(Field(8));
          end;

          if num_stage = count_stages then
          begin
            Excel.WorkSheets[1].Cells[idx-2, 6] := IntToStr(Round(summpay_per_year));
            if Integer(Field(6)) <> BYR then
            begin
              Excel.WorkSheets[1].Cells[idx-1, 3] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field(15))
                                                     + '  на ' + DateToStr(erate_date);
              Excel.WorkSheets[1].Cells[idx-2, 5] := IntToStr(Round(summpay_per_treaty*erate+summpay_stages_closed));
            end
            else
              Excel.WorkSheets[1].Cells[idx-2, 5] := IntToStr(Round(summpay_per_treaty));
          end;
          prev_id := Integer(Field(0));

          if num_stage = count_stages then
          begin
            buildingReport.Next;
          end;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;
        Next;
      end;

      Close;

      if Formula1 <> '' then
      begin
        Formula1 := Formula1 + 'E' + IntToStr(idx - 1) + ')';
        Formula2 := Formula2 + 'F' + IntToStr(idx - 1) + ')';

        Excel.Worksheets[1].Rows[idx + 1].Insert;
        Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx]);

        Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula1;
        Excel.WorkSheets[1].Cells[idx, 6].Formula := Formula2;

        if MainFormula1 = '' then
        begin
          MainFormula1 := '=SUM(E' + IntToStr(idx) + ')';
          MainFormula2 := '=SUM(F' + IntToStr(idx) + ')';
        end
        else
        begin
          MainFormula1 := MainFormula1 +  ', E' + IntToStr(idx) + ')';
          MainFormula2 := MainFormula2 +  ', F' + IntToStr(idx) + ')';
        end;

        inc(idx);

        Excel.Worksheets[1].Rows[idx + 1].Insert;
        Excel.WorkSheets[1].Rows[idx + offs_table + 7].Copy(Excel.Worksheets[1].Rows[idx]);
        Excel.WorkSheets[1].Cells[idx, 5].Formula := MainFormula1;
        Excel.WorkSheets[1].Cells[idx, 6].Formula := MainFormula2;


        inc(idx);
      end;
    end;

    Excel.WorkSheets[1].Range['$' + IntToStr(idx) + ':$' + IntToStr(idx + 10)].Delete;

    if rec_count > 0 then
    begin
      //buildingReport.Next;
      buildingReport.Finish;
    end;
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;

    Screen.Cursor:= crDefault;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;}
end;  // End of vpInnovEigenInvestCurators Click

procedure TfmMainMenu.vpCuratorClick(Sender: TObject);
var
  //v_from_date_str : String; // Дата начала временого интрвала отчета в текстовом формате
  //v_to_date_str   : String; // Дата конча временого интрвала отчета в текстовом формате
  //v_from_date : TDate;      // Дата начала временого интрвала отчета
  //v_to_date   : TDate;      // Дата конча временого интрвала отчета
  //rep_from_year : Integer; // c года
  //rep_to_year   : Integer; // по год

  AMONTH : Integer;
  AYear : Integer;
  AYearTo : Integer;
begin
  AMONTH := 0;
  //AYear := 0;
  if Sender = vpCurator then
  begin
    with TfmPickFromYearToYear.Create(Self) do
    begin
      se_FromYear.Value := StrToInt(FormatDateTime('yyyy',Date));
      se_ToYear.Value   := StrToInt(FormatDateTime('yyyy',Date));
      if ShowModal=mrOk then
      begin
        AYear := se_FromYear.Value;
        //v_from_date := StrToDate(v_from_date_str);
        AYearTo   := se_ToYear.Value;
        //v_to_date := StrToDate(v_to_date_str);
        //rep_from_year := se_FromYear.Value;
        //rep_to_year   := se_ToYear.Value;
        Free;
      end
      else begin  Free; Exit; end;
    end;
  end
  else
  begin
    with TfmPickMonth.Create(Self) do
   begin
      cbMonth.ItemIndex := StrToInt(FormatDateTime('m',Date)) - 1;
      if ShowModal=mrOk then
      begin
        AMONTH := cbMonth.ItemIndex + 1;
        AYEAR := se_Year.Value;
        AYearTo := AYEAR;
        Free;
      end
      else
      begin
        Free;
        Exit;
      end;
    end;
  end;

  with TfmCurratorList.Create(Self, AYEAR, AYEARTO, Sender) do
  begin
    if Sender <> vpCurator then
    begin
      Month := AMONTH;
      YEAR := AYEAR;
    end;

    ShowModal;
    Free;
  end;
end;

procedure TfmMainMenu.vpRN0708Click(Sender: TObject);
const
  //beg_table : integer = 11; // Начало шаблона таблицы
  beg_new_table : integer = 11; // Начало самой таблицы
  //beg_new_table : integer = 17; // Начало самой таблицы
  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы
  CountTailRows_RN07 : integer = 10;  // Кол. строк в конце док., которые должны напечататся на одной странице
  CountTailRows_RN08 : integer = 3;  // Кол. строк в конце док., которые должны напечататся на одной странице
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';
  offs_table : integer = 3; // Начало шаблона таблицы
  count_cols : integer = 7;  // Количество колонок
var
  thread : TLRQThread;

  //vbeg_new_table : integer; // Начало самой таблицы
  //vcount_cols : integer;  // Количество колонок

  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  v_date: TDate; // Дата отчета
  v_date_str : string; // Дата отчета в текстовом формате
  rep_year : string; // Год
  year : Integer;
  //num_dog : Integer; // Кол. инновацион. договоров
  I, J : Integer;
  //shift_beg_tabl : Integer;
  str_dog : String;
  //str : String;
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  count_stages : integer; // количество этапов в договоре
  summpay_per_treaty : Extended; // стоимость работ по договору
  summpay_per_treaty_this_next_years : Extended; // стоимость работ по договору в этом и следущиих годах
  summpay_per_treaty_prev_years : Extended; // стоимость работ по договору в предыдущие годы
  //summpay_per_dog_year : array of Extended; // стоимость работ по договору выполненных в текущем году в рамках рамочных договоров
  summpay_per_year : Extended; // стоимость работ по договору выполненных в текущем году
  summpay_stages_closed  : Extended; // Стоимость закрытых этапов
  //conc_dog_id : array of Integer; // список идентификаторов рамочных договоров которые действуют в текущем году
  erate_date : tdate;
  erate : Extended;
  quReport : TOracleQuery;
  //ExcelFormula : String;
  NextYearDogCount : Integer;
  text : String;
  //vCountTailRows : Integer;

  PickYear : TfmPickYear;
  //ConcDateFrom, ConcDateTo : TDateTime;
  AConcern_DOG : Integer;
  //nr : Integer;

  count_dog : Integer; // Количество договоров
begin
  inherited;

  {ConcDateFrom := 0;
  ConcDateTo := 0;}

  v_date := 0;
  rep_year := '';
  year := 0;

  //vcount_cols := count_cols;

  {if Sender = vpRN07 then
    vCountTailRows := CountTailRows_RN07
  else
    vCountTailRows := CountTailRows_RN08;}

  PickYear := TfmPickYear.Create(Self);
  PickYear.se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
  repeat
    if PickYear.ShowModal=mrOk then
    begin
      year := PickYear.se_Year.Value;
      v_date_str := '01.01.' + IntToStr(PickYear.se_Year.Value);
      v_date := StrToDate(v_date_str);
      rep_year := IntToStr(PickYear.se_Year.Value);
    end
    else begin  PickYear.Free; Exit; end;

    AConcern_DOG := -1;

    if Sender = vpRN07 then
      AConcern_DOG := GetConcern_Treaty(IncMonth(v_date, 11));

  until (Sender<>vpRN07) or (AConcern_DOG >= 0);
  PickYear.Free;

  // ФОРМА RN-07
  if Sender=vpRN07 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-07.xlt';
  // ФОРМА RN-08
  if Sender=vpRN08 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-08.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    //num_dog := 0;
    //shift_beg_tabl := 0;

    Excel.WorkSheets[1].Cells[beg_new_table  - 6 , 1] := Excel.WorkSheets[1].Cells[beg_new_table - 6 , 1].Text + ' ' + rep_year + ' ГОД ';

    // Шапка отчета
    // ФОРМА RN-07
    if Sender=vpRN07 then
    begin
      with TOracleDataSet.Create(Self) do
      begin

        Session:= dmGlobal.seOracle;

        SQL.Append('SELECT  DATESIGN, NUM ');
        SQL.Append('  FROM RN.MITRCONCERN');
        SQL.Append(' WHERE  ID = :DOG_ID');

        DeclareVariable('DOG_ID', otInteger);
        SetVariable('DOG_ID', AConcern_DOG);

        try
          Open;

          str_dog := 'ПО ДОГОВОРУ ОТ ';
          if FieldValues['DATESIGN'] <> NULL then
            str_dog := str_dog + FormatDateTime('dd.mm.yyyy', FieldValues['DATESIGN']) + 'г. № '
          else
            str_dog := str_dog + '               № ';

          if FieldValues['NUM'] <> NULL then
            str_dog := str_dog + FieldValues['NUM'];

          Excel.WorkSheets[1].Cells[beg_new_table - 5, 1] := str_dog;

          Excel.WorkSheets[1].Cells[beg_new_table  - 2, 7] := 'Выполнено в ' + rep_year;

          with dmGlobal.odsYearConcReport do
          begin
            SetVariable('YEAR', year);
            SetVariable('CONC', AConcern_DOG);
            {if ConcDateFrom <> 0 then
              SetVariable('CONC_DATEFROM', ConcDateFrom)
            else
              SetVariable('CONC_DATEFROM', NULL);
            if ConcDateTo <> 0 then
              SetVariable('CONC_DATETO', ConcDateTo)
            else
              SetVariable('CONC_DATETO', NULL);}
            Open;
            NextYearDogCount := RecordCount;

            if NextYearDogCount > 0 then
            begin
              text := 'Примечание: По договорам № ';
              I := 0;
              J := 0;
              while not EOF do
              begin
                Inc(I);
                Inc(J);
                if I <  (NextYearDogCount - 1) then
                  text := text + FindField('treaty_num').AsString + ', '
                else if I =  (NextYearDogCount - 1) then
                  text := text + FindField('treaty_num').AsString + ' и '
                else
                  text := text + FindField('treaty_num').AsString + ' - будут продолжаться работы в ' + IntToStr(year + 1) + ' году.';
                Next;

                if (j = 10) or (I = NextYearDogCount) then
                begin

                  if I > J then
                  begin
                    Excel.WorkSheets[1].Rows[beg_new_table + 11  + Ceil(I / 10)].Insert;
                    Excel.WorkSheets[1].Rows[beg_new_table + 11  + Ceil(I / 10)].Copy(Excel.Worksheets[1].Rows[beg_new_table + 11  + Ceil(I / 10) - 1]);
                  end;
                  Excel.WorkSheets[1].Cells[beg_new_table + 11 + Ceil(I / 10) - 1, 1] := text;
                  text := '';
                  J := 0;
                end;
              end;
              {if Ceil(I / 10) > 1 then
                Inc(vCountTailRows, Ceil(I / 10));}
              //Excel.WorkSheets[1].Cells[beg_table + shift_beg_tabl + 9, 1] := text;
            end;

            Close;
          end;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
        end;

        close;

        Destroy;
      end;


    end;

    // Шапка отчета
    // ФОРМА RN-08
    if Sender=vpRN08 then
      Excel.WorkSheets[1].Cells[beg_new_table - 2, 7] := 'Выполнено в ' + rep_year;

    quReport := nil;
    // ФОРМА RN-07
    if Sender=vpRN07 then quReport := dmglobal.quRN07_Rep;
    // ФОРМА RN-08
    if Sender=vpRN08 then quReport := dmglobal.quRN08_Rep;

    // Выполняем отчет
    with quReport do
    begin
      if Sender=vpRN07 then
      begin
        SetVariable('CONC', AConcern_DOG);
        {if ConcDateFrom <> 0 then
          SetVariable('CONC_DATEFROM',ConcDateFrom)
        else
          SetVariable('CONC_DATEFROM',NULL);

        if ConcDateTo <> 0 then
          SetVariable('CONC_DATETO',ConcDateTo)
        else
          SetVariable('CONC_DATETO',NULL);}
      end;

      SetVariable('YEAR', year);

      Execute;

      count_dog := 0;
      // Устанавливаем пораметры для отображение процесса формирования отчета
      if not EOF then
      begin
        count_dog := FieldAsInteger('count_treaty');

        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');

        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;

        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);

        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;

        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(count_dog {* 2 + vCountTailRows});
      end;

      idx:= beg_new_table; prev_id := -1; count := 1;
      count_stages := 0;

      summpay_per_year := 0;

      summpay_per_treaty := 0;
      summpay_per_treaty_this_next_years := 0;
      summpay_per_treaty_prev_years := 0;
      summpay_stages_closed := 0;

      erate_date := 0;
      erate := 0;

      while not EOF do
      begin
        try
          // Проверяем тот же самый ли TREATY_ID [Field(0)]
          if Integer(Field('TREATY_ID')) <> prev_id then
          begin // Следующий договор
            if prev_id >= 0 then
              // Увеличеваем значение ProgressBar на еденицу в окне copingForm
              buildingReport.Next;

            summpay_stages_closed := 0;
            count_stages := Integer(Field('COUNT_PER_TREATY')); // Количество этапов на договор

            summpay_per_year := 0;

            summpay_per_treaty := Extended(Field('TREATY_SUMMPAY')); // сумма по договору
            summpay_per_treaty_this_next_years := 0; // сумма в этом и следующих годах
            summpay_per_treaty_prev_years := 0;

            erate_date := Field('INTO_DATE');
            erate := Extended(Field('E_RATE'));

            Excel.Worksheets[1].Rows[idx + 1].Insert;
            Excel.Worksheets[1].Rows[idx + 2].Insert;
            if Field('STATUS') = 'O' then // OPERATIVE Действующий договор
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 2].Copy(Excel.Worksheets[1].Rows[idx+1]);
            end
            else if Field('STATUS') = 'F' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx+1]);
              Excel.WorkSheets[1].Cells[idx+1, 2] := 'ЗАКРЫТ';
            end
            else if Field('STATUS') = 'A' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx+1]);
              Excel.WorkSheets[1].Cells[idx+1, 2] := 'АННУЛИРОВАН';
            end;

            Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку
            inc(count);
            Excel.WorkSheets[1].Cells[idx+1, 1] := FieldAsString('rep_num');//String(Field('TREATY_ID')); // id
            Excel.WorkSheets[1].Cells[idx, 2] := Trim(String(Field('NUM'))); // номер договора и исполнитель
            Excel.WorkSheets[1].Cells[idx, 3] := Trim(String(Field('SUBJECT'))); // тема договора
            Excel.WorkSheets[1].Cells[idx, 4] := Trim(String(Field('DATEFROM'))); // дата начала
            Excel.WorkSheets[1].Cells[idx+1, 4] := Trim(String(Field('DATETO'))); // дата окончания
            inc(idx,2);
            prev_id := Integer(Field('TREATY_ID'));
          end;

          dec(count_stages);
          if Integer(Field('CURRENCY_NO')) <> BYR then // Код валюты РБ.
          begin // Считаем для не РБ
            if (erate_date = null) or (erate_date < Field('INTO_DATE')) then // Курс
              begin erate_date := Field('INTO_DATE'); erate := Extended(Field('E_RATE')); end;
            if Field('DATEACT') <> null then
            begin
              summpay_stages_closed := summpay_stages_closed + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE')); // сумма в РБ для сданных этапов
              summpay_per_treaty := summpay_per_treaty - Extended(Field('STAGE_SUMMPAY')); // Сумма без сданных этапов
            end;
            if (Field('DATEACT') <> null) and (Field('DATEACT') <= StrToDate('31.12.' + rep_year))
                  and (Field('DATEACT') >= StrToDate('01.01.' + rep_year))
            then
              summpay_per_year := summpay_per_year+Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));


            if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_this_next_years := summpay_per_treaty_this_next_years + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));
            end
            else
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_prev_years := summpay_per_treaty_prev_years + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));
            end

          end
          else // Считаем для РБ
          begin
            if (Field('DATEACT') <> null) and (Field('DATEACT') <= StrToDate('31.12.' + rep_year))
                  and (Field('DATEACT') >= StrToDate('01.01.' + rep_year))
            then
              summpay_per_year := summpay_per_year+Extended(Field('STAGE_SUMMPAY'));



            if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_this_next_years := summpay_per_treaty_this_next_years + Extended(Field('STAGE_SUMMPAY'));
            end
            else
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_prev_years := summpay_per_treaty_prev_years + Extended(Field('STAGE_SUMMPAY'));
            end
          end;

          if count_stages < 1 then
          begin
            if summpay_per_year > 0 then
              Excel.WorkSheets[1].Cells[idx-2, 7] := FloatToStr(RoundTo(summpay_per_year, -2))
            else
              Excel.WorkSheets[1].Cells[idx-2, 7] := '';

            if Integer(Field('CURRENCY_NO')) <> BYR then
            begin
              Excel.WorkSheets[1].Cells[idx-1, 3] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field('CURRENCY_NAME'))
                                                     + '  на ' + DateToStr(erate_date);
              Excel.WorkSheets[1].Cells[idx-2, 5] := FloatToStr(RoundTo(summpay_per_treaty*erate+summpay_stages_closed, -2));
              if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
                summpay_per_treaty_prev_years := RoundTo(summpay_per_treaty*erate+summpay_stages_closed -  summpay_per_treaty_this_next_years, -2);
            end
            else
            begin
              Excel.WorkSheets[1].Cells[idx-2, 5] := FloatToStr(RoundTo(summpay_per_treaty, -2));
              if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
                summpay_per_treaty_prev_years := RoundTo(summpay_per_treaty*erate+summpay_stages_closed -  summpay_per_treaty_this_next_years, -2);
            end;

            if summpay_per_treaty_prev_years > 0 then
              Excel.WorkSheets[1].Cells[idx-2, 6] := FloatToStr(RoundTo(summpay_per_treaty_prev_years, -2))
            else
              Excel.WorkSheets[1].Cells[idx-2, 6] := '';
          end;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;
        Next;
      end;

      Excel.Worksheets[1].Range['$'+IntToStr(idx) + ':$'+IntToStr(idx + 9)].Delete;
      if count_dog > 0 then
        buildingReport.Next;
      Close;

    end;

    {for I := 1 to count_dog - 1 do
    begin
      // Если произошел автоматический разрыв страницы, то необходимо нарисовать нижнюю рамку
      if Excel.Worksheets[1].Rows[row_no_page_break].PageBreak <> Excel.Worksheets[1].Rows[beg_new_table + I * 2 + 1].PageBreak then
        Excel.Worksheets[1].Rows[beg_new_table + I * 2].PageBreak := 1;
      buildingReport.Next;
    end;

    for I := idx + 1 to idx + vCountTailRows - 1 do
    begin
      if Excel.Worksheets[1].Rows[I].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
      begin
        Excel.Worksheets[1].Rows[idx].PageBreak := 1;
        if count_dog > 0 then
          buildingReport.Next(idx + vCountTailRows - I);
        break;
      end;
      if count_dog > 0 then
        buildingReport.Next;
    end;}

    if count_dog > 0 then
      // Сообщаем  окну buildingReport  о финише формирования отчета
      buildingReport.Finish;
    Excel.Run('STRH');
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

procedure TfmMainMenu.vpRN09RN10(Sender: TObject);
const
  beg_table : integer = 7; // Начало шаблона таблицы
  beg_new_table : integer = 10; // Начало самой таблицы
  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы
  CountTailRows : integer = 3;  // Кол. строк в конце док., которые должны напечататся на одной странице
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

  Max_count_stages : Integer = 10;
var
  thread : TLRQThread;
  //NextMonth : TDateTime;
  month, year : Integer;
  v_date_str : string; // Дата отчета в текстовом формате
  rep_month : string; // Название месяца
  rep_year : string; // Год
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  count_stages : integer;
  summpay_stage : Extended;
  idx : integer; // счетчик по строкам
  count : Integer;
  quReport : TOracleQuery;
  prev_id : integer;// id пердыдущего договора
  RowHeight : Extended;
  I : Integer;
  //J : Integer;
  PickMonth : TfmPickMonth;

  //rep_date : TDateTime;
  v_date : TDateTime;
  AConcern_DOG : Integer;
  //ConcDateFrom, ConcDateTo : TDateTime;

  rec_count : Integer;
  count_treatys : Integer;
  num : String;

  //breakPage_rows : Array of Integer; // Номера строк, где может быть линия разрыва страницы
  //count_no_breakPage_rows : Array of Integer; // КОличество строк подряд, которые не могут содержать линию разрыва страницы
  //progress : Integer;

  num_stage : Integer;
  rows : Integer;
  //d1, d2 : TDateTime;
begin
  {with TfmPickMonth.Create(Self) do
  begin
    NextMonth := IncMonth(Date, 1);
    cbMonth.ItemIndex := StrToInt(FormatDateTime('m',NextMonth))-1;
    se_Year.Value  := StrToInt(FormatDateTime('yyyy',NextMonth));
    if ShowModal=mrOk then
    begin
      v_date_str := '01.' + IntToStr(cbMonth.ItemIndex+1) + '.'+ IntToStr(se_Year.Value);
      month := cbMonth.ItemIndex+1;
      year := se_Year.Value;
      rep_month := cbMonth.Items[cbMonth.ItemIndex];
      rep_year := IntToStr(se_Year.Value);
      Free;
    end
    else begin  Free; Exit; end;
  end;}

  //AConcern_DOG := 0;
  //rep_date := 0;
  //ConcDateFrom := 0;
  //ConcDateTo := 0;
  v_date := 0;
  month := 0;
  year := 0;
  rec_count := 0;
  {count_treatys := 0;
  SetLength(breakPage_rows, 0);
  SetLength(count_no_breakPage_rows, 0);
  progress := 0;}

  PickMonth := TfmPickMonth.Create(Self);
  PickMonth.cbMonth.ItemIndex := StrToInt(FormatDateTime('m',Date))-1;
  PickMonth.se_Year.Value  := StrToInt(FormatDateTime('yyyy', Date));
  repeat
   if PickMonth.ShowModal=mrOk then
   begin
     v_date_str := '01.' + IntToStr(PickMonth.cbMonth.ItemIndex+1) + '.'+ IntToStr(PickMonth.se_Year.Value);
     //rep_date := EncodeDate(PickMonth.se_Year.Value, PickMonth.cbMonth.ItemIndex+1, 1);
     month := PickMonth.cbMonth.ItemIndex+1;
     year := PickMonth.se_Year.Value;
     v_date := StrToDate(v_date_str);
     rep_month := PickMonth.cbMonth.Items[PickMonth.cbMonth.ItemIndex];
     rep_year := IntToStr(PickMonth.se_Year.Value);
   end
   else begin  PickMonth.Free; Exit; end;

   AConcern_DOG := -1;

   if Sender = vpRN09 then
     AConcern_DOG := GetConcern_Treaty(v_date);


  until (Sender<>vpRN09) or (AConcern_DOG >= 0);
  PickMonth.Free;

  // ФОРМА RN-09
  if Sender=vpRN09 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-09.xlt'
  else
    // ФОРМА RN-10
    if Sender=vpRN10 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-10.xlt'
  else Exit;

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;
    Excel.WorkSheets[1].Cells[2, 1] := Excel.WorkSheets[1].Cells[2, 1].Text + ' ' + rep_month + ' ' + rep_year + 'г.';

    if Sender=vpRN09 then
    begin
      with TOracleQuery.Create(Self) do
      begin
        Session:= dmGlobal.seOracle;

        SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
        SQL.Append('  FROM RN.MITRCONCERN');
        SQL.Append(' WHERE  ID = :DOG_ID');

        DeclareVariable('DOG_ID', otInteger);
        SetVariable('DOG_ID', AConcern_DOG);
        Execute;

        Excel.WorkSheets[1].Cells[3, 1] := FieldAsString(0);

        Destroy;
      end;
    end;

    quReport := nil;
    // ФОРМА RN-09
    if Sender=vpRN09 then quReport := dmglobal.quRN09RN11_Rep;
    if Sender=vpRN10 then quReport := dmglobal.quRN10RN12_Rep;

    if Assigned(quReport) then
      // Выполняем отчет
      with quReport do
      begin
        //if month = 1 then
        //  SetVariable('DATEFROM', EncodeDate(year - 1, 12, 1))
        //else
        //  SetVariable('DATEFROM', EncodeDate(year, month - 1, 1));
        SetVariable('DATEFROM', EncodeDate(year, month, 1));
        //SetVariable('DATETO', EncodeDate(year, month, 1));
        if month = 12 then
          SetVariable('DATETO', EncodeDate(year + 1, 1, 1))
        else
          SetVariable('DATETO', EncodeDate(year, month + 1, 1));

        if Sender=vpRN09 then
        begin
          SetVariable('CONC', AConcern_DOG);
          {if ConcDateFrom <> 0 then
            SetVariable('CONC_DATEFROM', ConcDateFrom)
          else
            SetVariable('CONC_DATEFROM', NULL);

          if ConcDateTo <> 0 then
            SetVariable('CONC_DATETO', ConcDateTo)
          else
            SetVariable('CONC_DATETO', NULL);}
        end;

        Execute;

        idx:= beg_new_table; prev_id := -1; //count := 1;
        count_stages := 0;
        count := 0;
        num_stage := 1;

        if FieldIsNull('rec_count') then
          rec_count := 0
        else
          rec_count := FieldAsInteger('rec_count');
        if rec_count > 0 then
        begin

          count_treatys := FieldAsInteger('count_treatys');

          buildingReport.Caption := 'Формируется отчет';
          buildingReport.SetCaption('Идет процесс формирования отчета...');

          // Устанавливаем начальные значения в окне buildingReport
          buildingReport.reset;

          // Делаем в окне buildingReport видимым ProgressBar
          buildingReport.visibleProgressBar(true);

          // Сообщаем  окну buildingReport  о начала копирования данных
          buildingReport.Start;

          // Устанавливаем максиальное значение ProgressBar в окне
          buildingReport.SetMax((rec_count + count_treatys) {* 2});

          {SetLength(breakPage_rows, count_treatys - 1);
          SetLength(count_no_breakPage_rows, count_treatys - 1);}
        end;

        while not EOF do
        begin
          try

            if (Integer(Field('ID')) <> prev_id) then
            begin // Следующий договор

              count_stages := FieldAsInteger('count_per_treaty');
              {if count > 0 then
              begin
                breakPage_rows[count - 1] := idx - (beg_new_table - beg_table);
                if count_stages > 1 then
                begin
                  if count_stages <= Max_count_stages then
                  begin
                    count_no_breakPage_rows[count - 1] := count_stages - 1;
                    inc(progress, count_stages - 1);
                  end
                  else
                  begin
                    count_no_breakPage_rows[count - 1] := Max_count_stages;
                    inc(progress, Max_count_stages);
                  end;
                end
                else
                begin
                  count_no_breakPage_rows[count - 1] := 1;
                  inc(progress);
                end;
              end;}

              inc(count);
              num := FieldAsString('num');

              Excel.Worksheets[1].Rows[idx].Insert;
              Excel.WorkSheets[1].Rows[beg_table].Copy(Excel.Worksheets[1].Rows[idx]);

              Excel.WorkSheets[1].Cells[idx, 3] := FieldAsString('subject');
              Excel.WorkSheets[1].Cells[idx, 2] := FieldAsString('Name');
              Excel.WorkSheets[1].Cells[idx, 1] := IntToStr(count);

              num_stage := 1;

            end
            else
            begin
              inc(num_stage);
              Excel.Worksheets[1].Rows[idx].Insert;
              if num_stage < count_stages then
                Excel.WorkSheets[1].Rows[beg_table + 1].Copy(Excel.Worksheets[1].Rows[idx])
              else
                Excel.WorkSheets[1].Rows[beg_table + 2].Copy(Excel.Worksheets[1].Rows[idx]);
            end;

            if not FieldIsNULL('ST_NUM') then
            begin
              Excel.WorkSheets[1].Cells[idx, 4] := FieldAsString('ST_NUM');
            end;

            if Integer(Field('currency_no')) <> BYR then // не беларуские рубли
              summpay_stage := Extended(Field('e_rate'))*Extended(Field('stage_summpay'))
            else
              summpay_stage := Extended(Field('stage_summpay'));

            Excel.WorkSheets[1].Cells[idx, 5] := FloatToStr(RoundTo(summpay_stage, -2));

            prev_id := Integer(Field('ID'));

            next;

            // Увеличеваем значение ProgressBar на еденицу в окне copingForm
            buildingReport.Next;

            inc(idx);

            if num_stage = count_stages then
            begin
              if count_stages = 1 then
              begin
                Excel.Worksheets[1].Rows[idx].Insert;
                Excel.WorkSheets[1].Rows[beg_table + 2].Copy(Excel.Worksheets[1].Rows[idx]);
                Excel.WorkSheets[1].Range['D'+IntToStr(idx - 1), 'D'+IntToStr(idx)].MergeCells := true;
                Excel.WorkSheets[1].Range['E'+IntToStr(idx - 1), 'E'+IntToStr(idx)].MergeCells := true;
                inc(idx);
                rows := 2;
              end
              else
              begin
                rows := count_stages;
                if rows > 2 then
                  Excel.WorkSheets[1].Range['A'+IntToStr(idx - count_stages), 'A'+IntToStr(idx - 2)].MergeCells := true;
              end;

              Excel.WorkSheets[1].Rows[idx - rows].AutoFit;
              RowHeight := Excel.WorkSheets[1].Rows[idx - rows].Height;
              Excel.WorkSheets[1].Cells[idx - 1, 1] := num;//prev_id;
              Excel.WorkSheets[1].Range['B'+IntToStr(idx - rows), 'B'+IntToStr(idx - 1)].MergeCells := true;
              Excel.WorkSheets[1].Range['C'+IntToStr(idx - rows), 'C'+IntToStr(idx - 1)].MergeCells := true;
              Excel.WorkSheets[1].Range['F'+IntToStr(idx - rows), 'F'+IntToStr(idx - 1)].MergeCells := true;
              Excel.WorkSheets[1].Cells[idx - rows, 6].Formula := '=Sum(E'+ IntToStr(idx - rows) + ':E'+IntToStr(idx - 1)+')';
              if Excel.WorkSheets[1].Rows[IntToStr(idx - rows)+ ':'+ IntToStr(idx - 1)].Height < RowHeight then
               Excel.WorkSheets[1].Rows[IntToStr(idx - rows)+ ':'+ IntToStr(idx - 1)].RowHeight := RowHeight/rows;

              buildingReport.Next;
            end;

          except
            Screen.Cursor:=crDefault;
            MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                       'Ошибка', mb_OK or mb_IconHand);
            Exit;
          end;
        end;
      end;
      {inc(progress);
      inc(progress, CountTailRows - 1);

      if rec_count > 0 then
      begin
        buildingReport.NewValue(progress * 2, progress);
      end;}

      // удаляем записи шаблонной таблицы
      Excel.Worksheets[1].Rows[idx].Delete;
      Excel.Worksheets[1].Range['$'+IntToStr(beg_table) + ':$'+IntToStr(beg_new_table - 1)].Delete;
      //if rec_count > 0 then
      //  buildingReport.Next;

      {for I := 0 to count_treatys - 2 do
      begin
        for J := 1 to count_no_breakPage_rows[I] do
        begin
          if Excel.Worksheets[1].Rows[breakPage_rows[I] + j].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
          begin
            Excel.Worksheets[1].Rows[breakPage_rows[I]].PageBreak := 1;
            buildingReport.Next(count_no_breakPage_rows[I] - J + 1);
            break;
          end;
          buildingReport.Next;
        end;
      end;}



    if rec_count > 0 then
    begin
      {for I := idx + 1 to idx + CountTailRows do
      begin
        if Excel.Worksheets[1].Rows[I].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
        begin
          Excel.Worksheets[1].Rows[idx].PageBreak := 1;
          buildingReport.Next(idx + CountTailRows - I + 1);
          break;
        end;

        buildingReport.Next;
      end;}

      // Сообщаем  окну buildingReport  о финише формирования отчета
      buildingReport.Finish;
    end;
    Excel.Run('STRH');
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;

    Screen.Cursor:= crDefault;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

procedure TfmMainMenu.vpRN11RN12(Sender: TObject);
const
  beg_table : integer = 7; // Начало шаблона таблицы
  beg_new_table : integer = 10; // Начало самой таблицы
  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы
  CountTailRows : integer = 3;  // Кол. строк в конце док., которые должны напечататся на одной странице
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

  Max_count_stages : Integer = 20;
var
  thread : TLRQThread;

  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  v_date_str : string; // Дата отчета в текстовом формате
  rep_year : string; // Год
  year : Integer;
  quReport : TOracleQuery;
  prev_id : integer;// id пердыдущего договора
  idx : integer; // счетчик по строкам
  count_stages : integer;
  count : Integer;
  I : Integer;
  //j : Integer;
  ch : Char;
  summpay_stage : Extended;
  stages_dateto : TDateTime;
  st_month : Integer;

  PickYear : TfmPickYear;
  v_date: TDate; // Дата отчета
  AConcern_DOG : Integer;
  //ConcDateFrom, ConcDateTo : TDateTime;

  rec_count : Integer;

  num : String;

  count_treatys : Integer;

  {breakPage_rows : Array of Integer; // Номера строк, где может быть линия разрыва страницы
  count_no_breakPage_rows : Array of Integer; // КОличество строк подряд, которые не могут содержать линию разрыва страницы
  progress : Integer;}

  num_stage : Integer;
  rows : Integer;
  //d1, d2 : TDateTime;
begin
  {with TfmPickYear.Create(Self) do
  begin
    se_Year.Value := StrToInt(FormatDateTime('yyyy',IncMonth(Date, 2)));
    if ShowModal=mrOk then
    begin
      year := se_Year.Value;
      v_date_str := '01.01.'+ IntToStr(se_Year.Value);
      rep_year := IntToStr(se_Year.Value);
      Free;
    end
    else begin  Free; Exit; end;
  end;
}
  v_date := 0;
  year := 0;
  rec_count := 0;
  {count_treatys := 0;
  SetLength(breakPage_rows, 0);
  SetLength(count_no_breakPage_rows, 0);
  progress := 0;}

  PickYear := TfmPickYear.Create(Self);
  PickYear.se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
  repeat
    if PickYear.ShowModal=mrOk then
    begin
      year := PickYear.se_Year.Value;
      v_date_str := '01.01.' + IntToStr(PickYear.se_Year.Value);
      v_date := StrToDate(v_date_str);
      rep_year := IntToStr(PickYear.se_Year.Value);
    end
    else begin  PickYear.Free; Exit; end;

    AConcern_DOG := -1;

    if Sender = vpRN11 then
      AConcern_DOG := GetConcern_Treaty(incMonth(v_date, 11));

  until (Sender<>vpRN11) or (AConcern_DOG >= 0);
  PickYear.Free;

  // ФОРМА RN-11
  if Sender=vpRN11 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-11.xlt'
  else
    // ФОРМА RN-12
    if Sender=vpRN12 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-12.xlt'
  else Exit;

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    Excel.WorkSheets[1].Cells[2, 1] := Excel.WorkSheets[1].Cells[2, 1].Text + ' ' + rep_year + ' ГОД';
    if Sender=vpRN11 then
    begin
      with TOracleQuery.Create(Self) do
      begin
        Session:= dmGlobal.seOracle;

        SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
        SQL.Append('  FROM RN.MITRCONCERN');
        SQL.Append(' WHERE  ID = :DOG_ID');

        DeclareVariable('DOG_ID', otInteger);
        SetVariable('DOG_ID', AConcern_DOG);
        Execute;

        Excel.WorkSheets[1].Cells[3, 1] := FieldAsString(0);

        Destroy;
      end;
    end;
    //Excel.WorkSheets[1].Cells[beg_table - 1, 15] := Excel.WorkSheets[1].Cells[beg_table - 1, 15].Text + IntToStr(year + 1) + 'г.';

    quReport := nil;

    if Sender=vpRN11 then quReport := dmglobal.quRN09RN11_Rep;
    if Sender=vpRN12 then quReport := dmglobal.quRN10RN12_Rep;

    if Assigned(quReport) then
      // Выполняем отчет
      with quReport do
      begin
        SetVariable('DATEFROM', EncodeDate(year, 1, 1));
        SetVariable('DATETO', EncodeDate(year + 1, 1, 1));

        if Sender=vpRN11 then
        begin
          SetVariable('CONC', AConcern_DOG);

          {if ConcDateFrom <> 0 then
            SetVariable('CONC_DATEFROM', ConcDateFrom)
          else
            SetVariable('CONC_DATEFROM', NULL);

          if ConcDateTo <> 0 then
            SetVariable('CONC_DATETO', ConcDateTo)
          else
            SetVariable('CONC_DATETO', NULL);}
        end;

        Execute;

        idx:= beg_new_table;
        prev_id := -1;
        count_stages := 0;
        count := 0;
        num_stage := 1;

        if FieldIsNull('rec_count') then
          rec_count := 0
        else
          rec_count := FieldAsInteger('rec_count');
        if rec_count > 0 then
        begin

          count_treatys := FieldAsInteger('count_treatys');

          buildingReport.Caption := 'Формируется отчет';
          buildingReport.SetCaption('Идет процесс формирования отчета...');

          // Устанавливаем начальные значения в окне buildingReport
          buildingReport.reset;

          // Делаем в окне buildingReport видимым ProgressBar
          buildingReport.visibleProgressBar(true);

          // Сообщаем  окну buildingReport  о начала копирования данных
          buildingReport.Start;

          // Устанавливаем максиальное значение ProgressBar в окне
          buildingReport.SetMax((rec_count + count_treatys){ * 2});

          {SetLength(breakPage_rows, count_treatys - 1);
          SetLength(count_no_breakPage_rows, count_treatys - 1);}
        end;

        while not EOF do
        begin
          try

            if (Integer(Field('ID')) <> prev_id) then
            begin // Следующий договор

              count_stages := FieldAsInteger('count_per_treaty');
              {if count > 0 then
              begin
                breakPage_rows[count - 1] := idx - (beg_new_table - beg_table);
                if count_stages > 1 then
                begin
                  if count_stages <= Max_count_stages then
                  begin
                    count_no_breakPage_rows[count - 1] := count_stages - 1;
                    inc(progress, count_stages - 1);
                  end
                  else
                  begin
                    count_no_breakPage_rows[count - 1] := Max_count_stages;
                    inc(progress, Max_count_stages);
                  end;
                end
                else
                begin
                  count_no_breakPage_rows[count - 1] := 1;
                  inc(progress);
                end;
              end;}

              inc(count);
              num := FieldAsString('num');

              Excel.Worksheets[1].Rows[idx].Insert;
              Excel.WorkSheets[1].Rows[beg_table].Copy(Excel.Worksheets[1].Rows[idx]);

              Excel.WorkSheets[1].Cells[idx, 1] := IntToStr(count);
              Excel.WorkSheets[1].Cells[idx, 2] := FieldAsString('treaty_num');

              num_stage := 1;
            end
            else
            begin
              inc(num_stage);
              Excel.Worksheets[1].Rows[idx].Insert;
              if num_stage < count_stages then
                Excel.WorkSheets[1].Rows[beg_table + 1].Copy(Excel.Worksheets[1].Rows[idx])
              else
                Excel.WorkSheets[1].Rows[beg_table + 2].Copy(Excel.Worksheets[1].Rows[idx]);
            end;

            if not FieldIsNULL('ST_NUM') then
            begin
              Excel.WorkSheets[1].Cells[idx, 3] := FieldAsString('ST_NUM');
            end;

            if Integer(Field('currency_no')) <> BYR then // не беларуские рубли
              summpay_stage := Extended(Field('e_rate'))*Extended(Field('stage_summpay'))
            else
              summpay_stage := Extended(Field('stage_summpay'));

            // определяем, когда должен быть сдан этап
            stages_dateto := Field('st_dateto');
            // опеределяем номер следующего месяца сдачи этапа
            st_month := StrToInt(FormatDateTime('mm', stages_dateto));
            // Заносим стоимость этапа в график финансирование, в графу месяца,
            // который следуют после месяца сдачи этапа
            Excel.WorkSheets[1].Cells[idx, 3 + st_month] := StringReplace(FloatToStr(RoundTo(summpay_stage, -2)), ',', '.', [rfReplaceAll]);

            prev_id := Integer(Field('ID'));
            inc(idx);

            next;

            // Увеличеваем значение ProgressBar на еденицу в окне copingForm
            buildingReport.Next;

            if num_stage = count_stages then
            begin
              if count_stages = 1 then
              begin
                Excel.Worksheets[1].Rows[idx].Insert;
                Excel.WorkSheets[1].Rows[beg_table + 2].Copy(Excel.Worksheets[1].Rows[idx]);

                // Делаем по одной ячейки с этапимми и планированым фин-ем по месяцам по договору у которого однин этап
                ch := 'C';
                for I := 0 to 12 do
                begin
                  Excel.WorkSheets[1].Range[ch+IntToStr(idx - 1), ch+IntToStr(idx)].MergeCells := true;
                  ch := chr(ord(ch) + 1);
                end;

                inc(idx);
                rows := 2;
              end
              else
              begin
                rows := count_stages;
                if rows > 2 then
                  Excel.WorkSheets[1].Range['A'+IntToStr(idx - count_stages), 'A'+IntToStr(idx - 2)].MergeCells := true;
              end;

              Excel.WorkSheets[1].Cells[idx - 1, 1] := num;//FieldAsString('num');//prev_id;
              Excel.WorkSheets[1].Range['A'+IntToStr(idx - rows), 'A'+IntToStr(idx - 2)].MergeCells := true;
              Excel.WorkSheets[1].Range['B'+IntToStr(idx - rows), 'B'+IntToStr(idx - 1)].MergeCells := true;
              Excel.WorkSheets[1].Range['P'+IntToStr(idx - rows), 'P'+IntToStr(idx - 1)].MergeCells := true;
              Excel.WorkSheets[1].Cells[idx - rows, 16].Formula := '=Sum(D'+ IntToStr(idx - rows) + ':O'+IntToStr(idx - 1)+')';

              buildingReport.Next;
            end;
          except
            Screen.Cursor:=crDefault;
            MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                       'Ошибка', mb_OK or mb_IconHand);
            Exit;
          end;
        end;

      end;

    {inc(progress);
    inc(progress, CountTailRows - 1);

    if rec_count > 0 then
    begin
      buildingReport.NewValue(progress * 2, progress);
    end;}

    // удаляем записи шаблонной таблицы
    Excel.Worksheets[1].Rows[idx].Delete;
    Excel.Worksheets[1].Range['$'+IntToStr(beg_table) + ':$'+IntToStr(beg_new_table - 1)].Delete;
    {if rec_count > 0 then
      buildingReport.Next;}

    {for I := 0 to count_treatys - 2 do
    begin
      for J := 1 to count_no_breakPage_rows[I] do
      begin
        if Excel.Worksheets[1].Rows[breakPage_rows[I] + j].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
        begin
          Excel.Worksheets[1].Rows[breakPage_rows[I]].PageBreak := 1;
          buildingReport.Next(count_no_breakPage_rows[I] - J + 1);
          break;
        end;
        buildingReport.Next;
      end;
    end;  }



    if rec_count > 0 then
    begin
{      for I := idx + 1 to idx + CountTailRows do
      begin
        if Excel.Worksheets[1].Rows[I].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
        begin
          Excel.Worksheets[1].Rows[idx].PageBreak := 1;
          buildingReport.Next(idx + CountTailRows - I + 1);
          break;
        end;

        buildingReport.Next;
      end;}

      // Сообщаем  окну buildingReport  о финише формирования отчета
      buildingReport.Finish;
    end;
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;

    Screen.Cursor:= crDefault;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

procedure TfmMainMenu.vpUnexecutedClick(Sender: TObject);
const
  //beg_table : integer = 7; // Начало шаблона таблицы
  beg_new_table : integer = 6; // Начало самой таблицы
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

  Max_count_stages : Integer = 10;

  cols : Integer = 7;

  offs_table : Integer = 3;

  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы

var
  thread : TLRQThread;
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  quReport : TOracleQuery;
  prev_id : integer;// id пердыдущего договора
  idx : integer; // счетчик по строкам
  count_stages : integer; // Число этапов
  num_stage : integer; // номер этапа
  count : Integer;
  I : Integer;
  RowHeight : Extended;
  summpay_stage : Extended;
  //v_Date : TDateTime;
  Istfin_kod : Integer;
  ConcDogID  : Integer;
  rec_count : Integer;
  //num : String;
  //changedIstFin : boolean;

  MainFormula : String;
  Formula : String;

  rows : Integer;
  {count_row_BreakPage : Integer;
  curr_row : Integer;
  row_BreakPage : Integer;
  J : Integer;
  LineNumsOfBreakPages : Array Of Integer;
  countLines : Array Of Integer;
  ind : Integer;
  count_row : Integer;}
begin
  //count_row := 0;

  St:=ExtractFilePath(Application.ExeName) + 'report\RN-13.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;
  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;
    quReport := dmglobal.quRN13_Rep;
    // Выполняем отчет
    with quReport do
    begin
      Execute;
      idx:= beg_new_table;
      prev_id := -1;
      count_stages := 0;
      num_stage := 0;
      count := 0;
      Istfin_kod := -1;
      ConcDogID := -1;
      MainFormula := '';
      Formula := '';
      //changedIstFin := false;

      if FieldIsNull('rec_count') then
        rec_count := 0
      else
        rec_count := FieldAsInteger('rec_count');
      if rec_count > 0 then
      begin
        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');
        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;
        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);
        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;
        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(rec_count {* 2});
      end;
      //SetLength(LineNumsOfBreakPages, rec_count);
      //SetLength(countLines, rec_count);
      //Ind := 0;
      while not EOF do
      begin
        try
          if (Integer(Field('ID')) <> prev_id) then
          begin // Следующий договор
            if (Istfin_kod <> Integer(Field('Istfin_kod'))) or
               (FieldIsNull('ConcDogID') and (ConcDogID <> -1)) or
               ((not FieldIsNull('ConcDogID')) and (ConcDogID <> Integer(Field('ConcDogID'))))
            then
            begin
              {if Ind > 0 then // Строка ИТОГО
                inc(countLines[Ind-1]);}
              Istfin_kod := Integer(Field('Istfin_kod'));
              if FieldIsNull('ConcDogID') then
                ConcDogID := -1
              else
                ConcDogID := Integer(Field('ConcDogID'));
              if Formula <> '' then
              begin
                // Формируем формулу ИТОГО
                Formula := Formula + 'F' + IntToStr(idx - 1) + ')';
                // Вставляем строку ИТОГО
                Excel.Worksheets[1].Rows[idx + 1].Insert;
                Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx]);
                Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula;
                // Формируем формулу ВСЕГО
                if MainFormula = '' then
                  MainFormula := '=Sum(E' + IntToStr(idx)
                else
                  MainFormula := MainFormula + ', E' + IntToStr(idx);
                inc(idx);
              end;
              // Формируем формулу ИТОГО
              Formula := '=Sum(F' + IntToStr(idx) + ':';
              // Вставляем строку с источником финансирования
              Excel.Worksheets[1].Rows[idx + 1].Insert;
              case ISTFIN_KOD of
                // Источник финансирования собственные средства
                1 : Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
                // Источник финансирования инновационный фонд
                2 : begin
                      Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);
                      if ConcDogID >= 0 then
                      begin
                        // Составляем строку с номером рамочного договора
                        with TOracleQuery.Create(Self) do
                        begin
                          Session:= dmGlobal.seOracle;
                          SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
                          SQL.Append('  FROM RN.MITRCONCERN');
                          SQL.Append(' WHERE  ID = :DOG_ID');
                          DeclareVariable('DOG_ID', otInteger);
                          SetVariable('DOG_ID', ConcDogID);
                          Execute;
                          Excel.WorkSheets[1].Cells[idx, 1] := Excel.WorkSheets[1].Cells[idx, 1].Text + String(FieldAsString(0));
                          Destroy;
                        end;
                      end;
                    end;
              end;
              // Устанавливаем флажок, что была вставлина строка с источником финансирования
              //changedIstFin := true;
              inc(idx);
            end;

            count_stages := FieldAsInteger('count_per_treaty');
            num_stage := 0;
            inc(count);

            Excel.Worksheets[1].Rows[idx].Insert;
            Excel.WorkSheets[1].Rows[idx + offs_table + 2].Copy(Excel.Worksheets[1].Rows[idx]);
            Excel.WorkSheets[1].Cells[idx, 3] := FieldAsString('subject');
            Excel.WorkSheets[1].Cells[idx, 2] := FieldAsString('Name');
            Excel.WorkSheets[1].Cells[idx, 1] := IntToStr(count);

            prev_id := Integer(Field('ID'));
          end
          else
          begin
            Excel.Worksheets[1].Rows[idx].Insert;
            if (num_stage + 1) < count_stages then
              Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx])
            else
              Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx]);
          end;

          if not FieldIsNULL('ST_NUM') then
          begin
            Excel.WorkSheets[1].Cells[idx, 4] := FieldAsString('ST_NUM');
          end;

          if not FieldIsNULL('ST_DATETO') then
          begin
            Excel.WorkSheets[1].Cells[idx, 5] := FieldAsString('ST_DATETO');
          end;

          if Integer(Field('currency_no')) <> BYR then // не беларуские рубли
            summpay_stage := Extended(Field('e_rate'))*Extended(Field('stage_summpay'))
          else
            summpay_stage := Extended(Field('stage_summpay'));

          Excel.WorkSheets[1].Cells[idx, 6] := StringReplace(FloatToStr(RoundTo(summpay_stage, -2)), ',', '.', [rfReplaceAll]);

          Inc(idx);
          inc(num_stage);

          if num_stage = count_stages then
          begin
            // Все данные о невыполненых этапов договора занесены Excel ljrevtyn
            // Формирыем документ так, что он выгледил красиво
            if count_stages = 1 then
            begin
              rows := 2;
              Excel.Worksheets[1].Rows[idx].Insert;
              Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx]);
              inc(idx)
            end
            else
              rows := count_stages;
            Excel.WorkSheets[1].Cells[idx - 1, 1] := FieldAsString('num');
            Excel.WorkSheets[1].Rows[idx - rows].AutoFit;
            RowHeight := Excel.WorkSheets[1].Rows[idx - rows].Height;
            if count_stages > 1 then
              Excel.WorkSheets[1].Range['A'+IntToStr(idx - rows), 'A'+IntToStr(idx - 2)].MergeCells := true
            else
            begin
              Excel.WorkSheets[1].Range['D'+IntToStr(idx - rows), 'D'+IntToStr(idx - 1)].MergeCells := true;
              Excel.WorkSheets[1].Range['E'+IntToStr(idx - rows), 'E'+IntToStr(idx - 1)].MergeCells := true;
              Excel.WorkSheets[1].Range['F'+IntToStr(idx - rows), 'F'+IntToStr(idx - 1)].MergeCells := true;
            end;

            Excel.WorkSheets[1].Range['B'+IntToStr(idx - rows), 'B'+IntToStr(idx - 1)].MergeCells := true;
            Excel.WorkSheets[1].Range['C'+IntToStr(idx - rows), 'C'+IntToStr(idx - 1)].MergeCells := true;
            Excel.WorkSheets[1].Range['G'+IntToStr(idx - rows), 'G'+IntToStr(idx - 1)].MergeCells := true;
            Excel.WorkSheets[1].Cells[idx - rows, 7].Formula := '=Sum(F'+ IntToStr(idx - rows) + ':F'+IntToStr(idx - 1)+')';
            if Excel.WorkSheets[1].Rows[IntToStr(idx - rows)+ ':'+ IntToStr(idx - 1)].Height < RowHeight then
              Excel.WorkSheets[1].Rows[IntToStr(idx - rows)+ ':'+ IntToStr(idx - 1)].RowHeight := RowHeight/rows;

            // Определяем сколько подряд строчек должно распологатся на странице,
            // и на какая строка должна содержать разрыв странице, если данное условия не выполняется
            {if count_stages > max_count_stages then
              count_row_BreakPage := max_count_stages
            else
            begin
              if count_stages = 1 then
                count_row_BreakPage := 1
              else
                count_row_BreakPage := count_stages - 1;
            end;
            if changedIstFin then
            begin
              inc(count_row_BreakPage);
              curr_row := idx - rows;
              // Снимаем флажок, о добавленой строке источника финансирования
              changedIstFin := false;
            end
            else
              curr_row := idx - rows + 1;
            row_BreakPage := curr_row - 1;
            countLines[Ind] := count_row_BreakPage;
            LineNumsOfBreakPages[Ind] := row_BreakPage;
            inc(Ind);
            inc(count_row, count_row_BreakPage);}
             // Увеличеваем значение ProgressBar на еденицу в окне copingForm
            buildingReport.Next;
          end;
          next;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;
      end;
    end;

    if Formula <> '' then
    begin
      // Формируем формулу ИТОГО
      Formula := Formula + 'F' + IntToStr(idx - 1) + ')';
      // Вставляем строку ИТОГО
      Excel.Worksheets[1].Rows[idx + 1].Insert;
      Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx]);
      Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula;

      // Формируем формулу ВСЕГО
      if MainFormula = '' then
        MainFormula := '=SUM(E' + IntToStr(idx) + ')'
      else
        MainFormula := MainFormula +  ', E' + IntToStr(idx) + ')';
      inc(idx);
      // Вставляем строку ВСЕГО
      Excel.Worksheets[1].Rows[idx + 1].Insert;
      Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx]);
      Excel.WorkSheets[1].Cells[idx, 5].Formula := MainFormula;
      inc(idx);
    end;
    //buildingReport.NewValue((count_row + 1) * 2, count_row + 1);
    // Для красоты, в строчках LineNumsOfBreakPages, если необходимо, устанавливаем разрыв страницы
    {for I := 1 to rec_count - 1 do
    begin
      // если установленое кол. строк подряд countLines[I] не распологаются на одной странице,
      // то на строке LineNumsOfBreakPages[I] устанавливаем разрыв страници
      for J := 0 to countLines[I] - 1 do
      begin
        if Excel.Worksheets[1].Rows[LineNumsOfBreakPages[I] + 1 + J].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
        begin
          Excel.Worksheets[1].Rows[LineNumsOfBreakPages[I]].PageBreak := 1;
          buildingReport.Next(countLines[I] - J);
          break;
        end
        else
          buildingReport.Next;
      end;
    end;}
    // удаляем записи шаблонной таблицы
    Excel.Worksheets[1].Range['$'+IntToStr(idx) + ':$'+IntToStr(idx+8)].Delete;

    if rec_count > 0 then
    begin
      // Увеличеваем значение ProgressBar на еденицу в окне copingForm
      //buildingReport.Next;
      // Сообщаем  окну buildingReport  о финише формирования отчета
      buildingReport.Finish;
    end;
    Excel.Run('STRH');
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;
    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

procedure TfmMainMenu.vpExecutedClick(Sender: TObject);
const
  //beg_table : integer = 5; // Начало шаблона таблицы
  beg_new_table : integer = 6; // Начало самой таблицы
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';
  Max_count_stages : Integer = 10;
  cols : Integer = 9;
  offs_table : Integer = 3;
  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы
var
  thread : TLRQThread;
  prevMonth : TDateTime;
  rep_Date  : TDateTime;
  month, year : Integer;
  v_date_str : string; // Дата отчета в текстовом формате
  rep_month : string; // Название месяца
  rep_year : string; // Год
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  quReport : TOracleQuery;
  prev_id : integer;// id пердыдущего договора
  idx : integer; // счетчик по строкам
  count_stages : integer; // Число этапов
  num_stage : integer; // номер этапа
  count : Integer;
  I : Integer;
  RowHeight : Extended;
  summpay_stage : Extended;
  rec_count : Integer;
  Istfin_kod : Integer;
  ConcDogID  : Integer;
  //changedIstFin : boolean;
  MainFormula : String;
  Formula : String;
  rows : Integer;

  {count_row_BreakPage : Integer;
  curr_row : Integer;
  row_BreakPage : Integer;
  J : Integer;
  LineNumsOfBreakPages : Array Of Integer;
  countLines : Array Of Integer;
  ind : Integer;
  count_row : Integer;}

begin
  //count_row := 0;

  with TfmPickMonth.Create(Self) do
  begin
    prevMonth := IncMonth(Date, -1);
    cbMonth.ItemIndex := StrToInt(FormatDateTime('m',prevMonth))-1;
    se_Year.Value  := StrToInt(FormatDateTime('yyyy',Date));
    if ShowModal=mrOk then
    begin
      v_date_str := '01.' + IntToStr(cbMonth.ItemIndex+1) + '.'+ IntToStr(se_Year.Value);
      month := cbMonth.ItemIndex+1;
      year := se_Year.Value;
      rep_month := cbMonth.Items[cbMonth.ItemIndex];
      rep_year := IntToStr(se_Year.Value);
      Free;
    end
    else begin  Free; Exit; end;
  end;
  rep_Date := EncodeDate(year, month, 1);
  St:=ExtractFilePath(Application.ExeName) + 'report\RN-14.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;
   // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);
  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

  quReport := dmglobal.quRN14_Rep;
   Excel.WorkSheets[1].Cells[2, 1] := Excel.WorkSheets[1].Cells[2, 1].Text  + GetPrepositionalMonth(month) + '  ' + rep_year + ' ГОДА';
   // Выполняем отчет
  with quReport do
  begin
    SetVariable('DATEFROM', rep_Date);
    SetVariable('DATETO', IncMonth(rep_Date, 1));

    Execute;

    idx:= beg_new_table;
    prev_id := -1;
    count_stages := 0;
    num_stage := 0;
    count := 0;
    Istfin_kod := -1;
    ConcDogID := -1;
    MainFormula := '';
    Formula := '';
    //changedIstFin := false;

    if FieldIsNull('rec_count') then
      rec_count := 0
    else
      rec_count := FieldAsInteger('rec_count');
    if rec_count > 0 then
    begin
      buildingReport.Caption := 'Формируется отчет';
      buildingReport.SetCaption('Идет процесс формирования отчета...');
       // Устанавливаем начальные значения в окне buildingReport
      buildingReport.reset;
       // Делаем в окне buildingReport видимым ProgressBar
      buildingReport.visibleProgressBar(true);
      // Сообщаем  окну buildingReport  о начала копирования данных
      buildingReport.Start;
      // Устанавливаем максиальное значение ProgressBar в окне
      buildingReport.SetMax(rec_count {* 2});
    end;

    while not EOF do
    begin
      try
        if (Integer(Field('ID')) <> prev_id) then
        begin // Следующий договор
          if (Istfin_kod <> Integer(Field('Istfin_kod'))) or
             (FieldIsNull('ConcDogID') and (ConcDogID <> -1)) or
             ((not FieldIsNull('ConcDogID')) and (ConcDogID <> Integer(Field('ConcDogID'))))
          then
          begin
            {if Ind > 0 then // Строка ИТОГО
              inc(countLines[Ind-1]); }
            Istfin_kod := Integer(Field('Istfin_kod'));
            if FieldIsNull('ConcDogID') then
              ConcDogID := -1
            else
              ConcDogID := Integer(Field('ConcDogID'));

            if Formula <> '' then
            begin
              // Вставляем строку ИТОГО
              Formula := Formula + 'F' + IntToStr(idx - 1) + ')';
              Excel.Worksheets[1].Rows[idx + 1].Insert;
              Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx]);

              Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula;

              if MainFormula = '' then
                MainFormula := '=Sum(E' + IntToStr(idx)
              else
                MainFormula := MainFormula + ', E' + IntToStr(idx);

              inc(idx);
            end;
            Formula := '=Sum(F' + IntToStr(idx) + ':';
            // Вставляем строку с источником финансирования
            Excel.Worksheets[1].Rows[idx + 1].Insert;

            case ISTFIN_KOD of
              // Источник финансирования собственные средства
              1 : Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              2 : begin
                    Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);
                    if ConcDogID >= 0 then
                    begin
                      with TOracleQuery.Create(Self) do
                      begin
                        Session:= dmGlobal.seOracle;

                        SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
                        SQL.Append('  FROM RN.MITRCONCERN');
                        SQL.Append(' WHERE  ID = :DOG_ID');
                        DeclareVariable('DOG_ID', otInteger);
                        SetVariable('DOG_ID', ConcDogID);
                        Execute;
                        Excel.WorkSheets[1].Cells[idx, 1] := Excel.WorkSheets[1].Cells[idx, 1].Text + String(FieldAsString(0));
                        Destroy;
                      end;
                    end;
                  end;
            end;
            inc(idx);
          end;

          count_stages := FieldAsInteger('count_per_treaty');
          num_stage := 0;
          inc(count);

          Excel.Worksheets[1].Rows[idx].Insert;
          Excel.WorkSheets[1].Rows[idx + offs_table + 2].Copy(Excel.Worksheets[1].Rows[idx]);

          Excel.WorkSheets[1].Cells[idx, 3] := FieldAsString('subject');
          Excel.WorkSheets[1].Cells[idx, 2] := FieldAsString('Name');
          Excel.WorkSheets[1].Cells[idx, 1] := IntToStr(count);

          prev_id := Integer(Field('ID'));
        end
        else
        begin
          Excel.Worksheets[1].Rows[idx].Insert;
          if (num_stage + 1) < count_stages then
            Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx])
          else
            Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx]);
        end;

        if not FieldIsNULL('ST_NUM') then
        begin
          Excel.WorkSheets[1].Cells[idx, 4] := FieldAsString('ST_NUM');
        end;

        if not FieldIsNULL('ST_DATETO') then
        begin
          Excel.WorkSheets[1].Cells[idx, 5] := FieldAsString('ST_DATETO');
        end;

        if not FieldIsNULL('NUMPAY') then
        begin
          Excel.WorkSheets[1].Cells[idx, 7] := FieldAsString('NUMPAY');
        end;

        if not FieldIsNULL('DATEPAY') then
        begin
          Excel.WorkSheets[1].Cells[idx, 8] := FieldAsString('DATEPAY');
        end;

        if Integer(Field('currency_no')) <> BYR then // не беларуские рубли
          summpay_stage := Extended(Field('e_rate'))*Extended(Field('stage_summpay'))
        else
          summpay_stage := Extended(Field('stage_summpay'));

        Excel.WorkSheets[1].Cells[idx, 6] := StringReplace(FloatToStr(RoundTo(summpay_stage, -2)), ',', '.', [rfReplaceAll]);

        Inc(idx);
        inc(num_stage);

        if num_stage = count_stages then
        begin
          if count_stages = 1 then
          begin
            rows := 2;
            Excel.Worksheets[1].Rows[idx].Insert;
            Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx]);
            inc(idx)
          end
          else
            rows := count_stages;

          Excel.WorkSheets[1].Cells[idx - 1, 1] := FieldAsString('num');

          Excel.WorkSheets[1].Rows[idx - rows].AutoFit;
          RowHeight := Excel.WorkSheets[1].Rows[idx - rows].Height;
          if count_stages > 1 then
            Excel.WorkSheets[1].Range['A'+IntToStr(idx - rows), 'A'+IntToStr(idx - 2)].MergeCells := true
          else
          begin
            Excel.WorkSheets[1].Range['D'+IntToStr(idx - rows), 'D'+IntToStr(idx - 1)].MergeCells := true;
            Excel.WorkSheets[1].Range['E'+IntToStr(idx - rows), 'E'+IntToStr(idx - 1)].MergeCells := true;
            Excel.WorkSheets[1].Range['F'+IntToStr(idx - rows), 'F'+IntToStr(idx - 1)].MergeCells := true;
            Excel.WorkSheets[1].Range['G'+IntToStr(idx - rows), 'G'+IntToStr(idx - 1)].MergeCells := true;
            Excel.WorkSheets[1].Range['H'+IntToStr(idx - rows), 'H'+IntToStr(idx - 1)].MergeCells := true;
          end;

          Excel.WorkSheets[1].Range['B'+IntToStr(idx - rows), 'B'+IntToStr(idx - 1)].MergeCells := true;
          Excel.WorkSheets[1].Range['C'+IntToStr(idx - rows), 'C'+IntToStr(idx - 1)].MergeCells := true;
          Excel.WorkSheets[1].Range['I'+IntToStr(idx - rows), 'I'+IntToStr(idx - 1)].MergeCells := true;
          Excel.WorkSheets[1].Cells[idx - rows, 9].Formula := '=Sum(F'+ IntToStr(idx - rows) + ':F'+IntToStr(idx - 1)+')';
          if Excel.WorkSheets[1].Rows[IntToStr(idx - rows)+ ':'+ IntToStr(idx - 1)].Height < RowHeight then
            Excel.WorkSheets[1].Rows[IntToStr(idx - rows)+ ':'+ IntToStr(idx - 1)].RowHeight := RowHeight/rows;

          {if count_stages > max_count_stages then
            count_row_BreakPage := max_count_stages
          else
          begin
            if count_stages = 1 then
              count_row_BreakPage := 1
            else
              count_row_BreakPage := count_stages - 1;
          end;

          if changedIstFin then
          begin
            inc(count_row_BreakPage);
            curr_row := idx - rows;
            changedIstFin := false;
          end
          else
            curr_row := idx - rows + 1;

          row_BreakPage := curr_row - 1;

          countLines[Ind] := count_row_BreakPage;
          LineNumsOfBreakPages[Ind] := row_BreakPage;
          inc(Ind);
          inc(count_row, count_row_BreakPage);}

          buildingReport.Next;
        end;
        next;

      except
        Screen.Cursor:=crDefault;
        MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                   'Ошибка', mb_OK or mb_IconHand);
        Exit;
      end;
    end;

    if Formula <> '' then
    begin
      Formula := Formula + 'F' + IntToStr(idx - 1) + ')';
      Excel.Worksheets[1].Rows[idx + 1].Insert;
      Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx]);

      Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula;

      if MainFormula = '' then
        MainFormula := '=SUM(E' + IntToStr(idx) + ')'
      else
        MainFormula := MainFormula +  ', E' + IntToStr(idx) + ')';

      inc(idx);

      Excel.Worksheets[1].Rows[idx + 1].Insert;
      Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx]);
      Excel.WorkSheets[1].Cells[idx, 5].Formula := MainFormula;

      inc(idx);
    end;
  end;

  {buildingReport.NewValue((count_row + 1) * 2, count_row + 1);

  for I := 0 to rec_count - 1 do
  begin
    for J := 0 to countLines[I] - 1 do
    begin
      if Excel.Worksheets[1].Rows[LineNumsOfBreakPages[I] + 1 + J].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
      begin
        Excel.Worksheets[1].Rows[LineNumsOfBreakPages[I]].PageBreak := 1;
        buildingReport.Next(countLines[I] - J);
        break;
      end
      else
        buildingReport.Next;
    end;
  end;}


    // удаляем записи шаблонной таблицы
    Excel.Worksheets[1].Range['$'+IntToStr(idx) + ':$'+IntToStr(idx+8)].Delete;

    if rec_count > 0 then
    begin
      // Увеличеваем значение ProgressBar на еденицу в окне copingForm
      //buildingReport.Next;

      // Сообщаем  окну buildingReport  о финише формирования отчета
      buildingReport.Finish;
    end;
    Excel.Run('STRH');
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;

end;

procedure TfmMainMenu.vpSubjectTreatyClick(Sender: TObject);
const
  //beg_table : integer = 14; // Начало шаблона таблицы
  beg_new_table : integer = 15; // Начало самой таблицы
  count_cols : integer = 10;  // Количество колонок
  offs_table : integer = 3; // Начало шаблона таблицы
  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы

  count_delete_row : integer = 13; // Количество строк шаблона, которое необходимо удалить

  SEMAPHORE : string = 'NIOKR_SEMAPHORE';
var
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  //v_date: TDate; // Дата отчета
  v_date_str : string; // Дата отчета в текстовом формате
  rep_year : string; // Год
  year : Integer;
  I : Integer;
  //J : Integer;
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  prev_subject_id  : integer;// id пердыдущей темы
  count : integer;
  count_stages : integer;
  quReport : TOracleQuery;
  erate_date : tdate;
  erate : Extended;

  summpay_per_treaty : Extended; // стоимость работ по договору
  summpay_per_treaty_year : Extended; // стоимость работ по договору в  отчетном году

  //Excel_values : array of array of Variant; // Массив c значениями для
  //len_ExcelArray : Integer; // Длина Excel массива
  //count_Excel_Rows : Integer; // Кол Excel. строк

  odsMIChapter : TOracleDataSet;
  flMIChapter_KOD   : TField;
  flMIChapter_PNAIM : TField;

  thread : TLRQThread;

  progress : Integer;
  {count_foreign_treaty : Integer;

  no_breakPage_Rows : Array of Integer;
  count_breakPage_Rows : Array of Integer;
  ind_noBrPage : Integer;}

  count_part : Integer;

  subject : String;

  //  Иностранный договор
  fr_tr : boolean;
  // Тема
  sub : boolean;

  Formula1 : String;
  Formula2 : String;
  MainFormula1 : String;
  MainFormula2 : String;
  PodrNaim : string;

  summpay_stages_closed : Extended;
  summpay_per_year : Extended;

  tr_closed : boolean;

  Margin : Integer;  //Граница для разбивки строк на части
  NextPart : String;        //Вторая часть слова

  {count_subject : Integer;

  new_subject : boolean;}
begin
  Margin := 1024;
  tr_closed := false;
  fr_tr := true;
  sub := true;
  summpay_stages_closed := 0.0;
  summpay_per_year := 0.0;
  with TfmPickYear.Create(Self) do
  begin
    se_Year.Value := StrToInt(FormatDateTime('yyyy', Date)) + 1;
    if ShowModal=mrOk then
    begin
      year := se_Year.Value;
      v_date_str := '01.01.'+ IntToStr(se_Year.Value);
      rep_year := IntToStr(se_Year.Value);
      Free;
    end
    else begin  Free; Exit; end;
  end;

  if Sender = vpRN15 then
    St:=ExtractFilePath(Application.ExeName) + 'report\RN-15.xlt'
  else if Sender = vpRN16 then
    St:=ExtractFilePath(Application.ExeName) + 'report\RN-16.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
//      Excel.Visible := True;
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    //Excel.WorkSheets[1].Cells[beg_new_table - 2, 8] := rep_year + 'г.';
    Excel.WorkSheets[1].Cells[9, 1] := Excel.WorkSheets[1].Cells[9, 1].Value + rep_year + ' год';
    idx:= beg_new_table;

    count := 0;

    erate_date := 0;
    erate := 0;

    count_stages := 0;

    odsMIChapter := TOracleDataSet.Create(nil);
    odsMIChapter.CountAllRecords := true;
    odsMIChapter.SQL.Add('SELECT * FROM RN.MICHAPTER ORDER BY KOD');
    odsMIChapter.Session := dmGlobal.seOracle;
    odsMIChapter.Open;

    flMIChapter_KOD   := odsMIChapter.FieldByName('KOD');
    flMIChapter_PNAIM := odsMIChapter.FieldByName('PNAIM');

    progress := 0;
    //count_foreign_treaty := 0;
    //count_subject := 0;
    for I := 0 to 2 do
    begin
      if I = 0 then
        quReport := dmglobal.quRN15RN16_1_Rep
      else if I = 1 then
        quReport := dmglobal.quRN15RN16_2_Rep
      else
        quReport := dmglobal.quRN15RN16_3_Rep;

      with quReport do
      begin
        if Sender = vpRN15 then
          SetVariable('ISTFIN_KOD', 2)
        else if Sender = vpRN16 then
          SetVariable('ISTFIN_KOD', 1);

        SetVariable('REP_YEAR', EncodeDate(year, 1, 1));

        Execute;

        if not EOF then
        begin
          inc(progress, FieldAsInteger('count_treaty'));
          {if I = 0 then
            inc(progress, FieldAsInteger('count_foreign_treaty'))
          else
            inc(progress, FieldAsInteger('count_treaty'));
          inc(progress, odsMIChapter.RecordCount);
          inc(progress, FieldAsInteger('count_subject'));}
        end;
      end;
    end;
    {SetLength(no_breakPage_rows, 10);
    SetLength(count_breakPage_rows, 10);
    ind_noBrPage := 0;
    new_subject := true;}

    buildingReport.Caption := 'Формируется отчет';
    buildingReport.SetCaption('Идет процесс формирования отчета...');

    // Устанавливаем начальные значения в окне buildingReport
    buildingReport.reset;

    // Делаем в окне buildingReport видимым ProgressBar
    buildingReport.visibleProgressBar(true);

    // Сообщаем  окну buildingReport  о начала копирования данных
    buildingReport.Start;
    if progress > 0 then
      // Устанавливаем максиальное значение ProgressBar в окне
      buildingReport.SetMax(progress + 1)
    else
      buildingReport.SetMax(1);


    count_part := 0;

    Formula1 := '';
    Formula2 := '';
    MainFormula1 := '';
    MainFormula2 := '';

    // Выполняем отчет
    for I := 0 to 2 do
    begin

      if I = 0 then
        quReport := dmglobal.quRN15RN16_1_Rep
      else if I = 1 then
        quReport := dmglobal.quRN15RN16_2_Rep
      else
        quReport := dmglobal.quRN15RN16_3_Rep;

      {if I > 0 then
        Excel.WorkSheets[1].Rows[idx].PageBreak := 1;}
      with quReport do
      begin
        if not Eof then
        begin
          try
            odsMIChapter.First;

            {if count_part > 0 then
              Excel.WorkSheets[1].Rows[idx].PageBreak := 1;}

            Excel.Worksheets[1].Rows[idx + 1].Insert;
            case I of
              0 : Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);
              1 : Excel.WorkSheets[1].Rows[idx + offs_table+1].Copy(Excel.Worksheets[1].Rows[idx]);
              2 : Excel.WorkSheets[1].Rows[idx + offs_table+2].Copy(Excel.Worksheets[1].Rows[idx]);
            end;
            Inc(idx);

            prev_id := -1;
            prev_subject_id := -1;

            summpay_per_treaty := 0;
            summpay_per_treaty_year := 0;

            while not EOF do
            begin

              // Проверяем та же самая ли тема Field('SUBJECT_KOD')
              if (Integer(Field('SUBJECT_KOD')) <> prev_subject_id) then
              begin // Следующая тема
                //new_subject := true;


                Excel.Worksheets[1].Rows[idx + 1].Insert;
                Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
                subject := flMIChapter_KOD.AsString + '. ' + flMIChapter_PNAIM.AsString;
                Excel.Worksheets[1].Cells[idx, 1] := subject;
                if Length(subject) > 90 then
                  Excel.WorkSheets[1].Rows[idx].RowHeight := Excel.WorkSheets[1].Rows[idx].RowHeight * ((Length(subject) div 90) + 1) + (Length(subject) div 90) * 0.5 * Excel.WorkSheets[1].Rows[idx].RowHeight;

                if prev_subject_id < 0 then
                begin
                  Formula1 := '=Sum(G'+ IntToStr(idx) + ':G';
                  Formula2 := '=Sum(H'+ IntToStr(idx) + ':H';
                end;


                inc(idx);
                buildingReport.Next;

                prev_subject_id := Integer(Field('SUBJECT_KOD'));

                while  flMIChapter_KOD.AsInteger <> prev_subject_id do
                begin
                  odsMIChapter.Next;

                  Excel.Worksheets[1].Rows[idx + 1].Insert;
                  Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
                  subject := flMIChapter_KOD.AsString + '. ' + flMIChapter_PNAIM.AsString;
                  Excel.Worksheets[1].Cells[idx, 1] := subject;
                  if Length(subject) > 90 then
                    Excel.WorkSheets[1].Rows[idx].RowHeight := Excel.WorkSheets[1].Rows[idx].RowHeight * ((Length(subject) div 90) + 1) + (Length(subject) div 90) * 0.5 * Excel.WorkSheets[1].Rows[idx].RowHeight;

                  inc(idx);
                  buildingReport.Next;
                end;
                odsMIChapter.Next;

              end;


              // Проверяем тот же самый ли id Field('ID')
              if Integer(Field('ID')) <> prev_id then
              begin // Следующий договор
                prev_id := Integer(Field('ID'));
                count_stages := Integer(Field('count_per_treaty')); // Количество этапов на договор

                inc(count);

                tr_closed := false;
                fr_tr := false;
                sub := false;

                summpay_stages_closed := 0.0;
                summpay_per_year := 0.0;

                if (Integer(Field('currency_no')) <> BYR) or (FieldAsString('status') = 'F') then
                begin
                  if Integer(Field('currency_no')) <> BYR then
                    // иностранный договор
                    fr_tr := true;

                  if (FieldAsString('status') <> 'F') then
                  begin



                    Excel.Worksheets[1].Rows[idx + 1].Insert;
                    Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx]);
                  end
                  else
                  begin
                    tr_closed := true;

                    Excel.Worksheets[1].Rows[idx + 1].Insert;
                    Excel.Worksheets[1].Rows[idx + 2].Insert;
                    Excel.WorkSheets[1].Rows[idx + offs_table + 8].Copy(Excel.Worksheets[1].Rows[idx]);
                    Excel.WorkSheets[1].Rows[idx + offs_table + 9].Copy(Excel.Worksheets[1].Rows[idx + 1]);
                    Excel.WorkSheets[1].Cells[idx + 1, 2] := 'ЗАКРЫТ';
                  end;

                end
                else if (I = 1) or (I = 2) then
                begin
                  sub := true;

                  Excel.Worksheets[1].Rows[idx + 1].Insert;
                  Excel.Worksheets[1].Rows[idx + 2].Insert;
                  Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx]);
                  Excel.WorkSheets[1].Rows[idx + offs_table + 7].Copy(Excel.Worksheets[1].Rows[idx+1]);

                end
                else
                begin
                  // беларуский договор
                  Excel.Worksheets[1].Rows[idx + 1].Insert;
                  If Length(FieldAsString('SUMMARY')) > 1024 Then
                    Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx])
                  Else
                    Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx]);

                  {if new_subject then
                  begin
                    if Length(no_breakPage_rows) = ind_noBrPage then
                    begin
                      SetLength(no_breakPage_rows, Length(no_breakPage_rows) + 10);
                      SetLength(count_breakPage_rows, Length(no_breakPage_rows) + 10);
                    end;

                    no_breakPage_Rows[ind_noBrPage] := idx - 1;
                    count_breakPage_rows[ind_noBrPage] := 1;
                    inc(ind_noBrPage);
                  end;}
                end;

                //new_subject := false;
                If VarIsNull(Field('podr_snaim')) then
                  PodrNaim := ''
                else
                  PodrNaim := VarAsType(Field('podr_snaim'),varString);

                Excel.WorkSheets[1].Cells[idx, 1] := IntToStr(count); // номер по порядку
                Excel.WorkSheets[1].Cells[idx, 2] := FieldAsString('treaty_num'); // номер договора
                Excel.WorkSheets[1].Cells[idx, 3] := String(Field('treaty_name')); // название договора
                Excel.WorkSheets[1].Cells[idx, 4] := String(Field('exec_name')); //+ PodrNaim; // исполнитель
                Excel.WorkSheets[1].Cells[idx, 5] := FormatDateTime('mm.yyyy', TDateTime(Field('date_from'))); // начало работ
                Excel.WorkSheets[1].Cells[idx, 6] := FormatDateTime('mm.yyyy', TDateTime(Field('date_to')));   // оканчание работ
                Excel.WorkSheets[1].Cells[idx, 10] := PodrNaim;  //Подразделение-куратор

                erate_date := Field('INTO_DATE');
                erate := Extended(Field('E_RATE'));

                summpay_per_treaty := Extended(Field('treaty_summpay'));
                summpay_per_treaty_year := 0;

                if sub or tr_closed then
                  inc(idx, 2)
                else
                  inc(idx);
              end;
              dec(count_stages);
              if Integer(Field('CURRENCY_NO')) <> BYR then // Код валюты РБ.
              begin // Считаем для не РБ
                if (erate_date = null) or (erate_date < Field('INTO_DATE')) then // Курс
                begin
                  erate_date := Field('INTO_DATE');
                  erate := Extended(Field('E_RATE'));
                end;

                if (Field('dateact') <> null) then
                begin
                  summpay_stages_closed := summpay_stages_closed + Extended(Field('stage_summpay'))*Extended(Field('e_rate')); // сумма в РБ для сданных этапов
                  summpay_per_treaty := summpay_per_treaty - Extended(Field('stage_summpay')); // Сумма без сданных этапов
                end;

                if // Проверяем по дате действия, если не акта сдачи
                    (     (Field('stage_dateto') <= StrToDate('31.12.' + rep_year))
                      and (Field('stage_dateto') >= StrToDate('01.01.' + rep_year))
                      and (Field('dateact') = null))
                    // или, если есть дата акта, то по нему
                   or
                    (     (Field('dateact') <= StrToDate('31.12.' + rep_year))
                      and (Field('dateact') >= StrToDate('01.01.' + rep_year)))
                then
                  summpay_per_year := summpay_per_year+Extended(Field('stage_summpay'))*Extended(Field('e_rate'));
              end;

              if (not FieldIsNull('stage_dateto')) and (FormatDateTime('yyyy', TDateTime(Field('stage_dateto'))) = rep_year) then
                summpay_per_treaty_year := summpay_per_treaty_year + (Extended(Field('stage_summpay'))) * Extended(Field('e_rate'));

              if count_stages = 0 then
              begin
                if Integer(Field('CURRENCY_NO')) <> BYR then // Код валюты РБ.
                begin
                  summpay_per_treaty := summpay_per_treaty * erate;
                  //summpay_per_treaty_year := summpay_per_treaty_year * erate;
                  //Excel.WorkSheets[1].Cells[idx - 1, 3] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field('currency_name'))
                  //                                         + '  на ' + DateToStr(erate_date);
                end;
                if fr_tr then
                begin
                  if not tr_closed then
                    Excel.WorkSheets[1].Cells[idx - 1, 7] := FloatToStr(RoundTo(summpay_per_treaty + summpay_stages_closed, -2))
                                                           //Round((summpay_per_treaty + summpay_stages_closed)/100000)/10;
                  else
                    Excel.WorkSheets[1].Cells[idx - 2, 7] := FloatToStr(RoundTo(summpay_per_treaty + summpay_stages_closed, -2));
                  if Round(summpay_per_treaty_year) > 0 then
                     //Round(summpay_per_treaty_year/100000)/10 > 0 then
                    if not tr_closed then
                      Excel.WorkSheets[1].Cells[idx - 1, 8] := FloatToStr(RoundTo(summpay_per_treaty_year, -2))
                                                             //Round(summpay_per_treaty_year/100000)/10;
                    else
                      Excel.WorkSheets[1].Cells[idx - 2, 8] := FloatToStr(RoundTo(summpay_per_treaty_year, -2));

                  if not FieldIsNull('SUMMARY') then
                    if not tr_closed then
                      If Length(FieldAsString('SUMMARY')) > 1024 Then
                        begin
                        Excel.Worksheets[1].Rows[idx].Insert;
                        inc(idx);
                        Excel.WorkSheets[1].Cells[idx - 2, 9] := StringReplace(SplitStr(FieldAsString('SUMMARY'),Margin,NextPart), #13#10,#10, [rfReplaceAll]);
                        Excel.WorkSheets[1].Rows[idx - 2].RowHeight := Excel.WorkSheets[1].Rows[idx - 2].RowHeight - 10;
                        Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx-1]);
                        Excel.WorkSheets[1].Cells[idx - 1, 9] := StringReplace(NextPart, #13#10,#10, [rfReplaceAll]);
                        Margin := 1024;
                        NextPart := '';
                        end
                      Else
                      Excel.WorkSheets[1].Cells[idx - 1, 9] := StringReplace(FieldAsString('SUMMARY'), #13#10,#10, [rfReplaceAll])
                    else
                      If Length(FieldAsString('SUMMARY')) > 1024 Then
                        begin
                        Excel.Worksheets[1].Rows[idx - 1].Insert;
                        inc(idx);
                        Excel.WorkSheets[1].Cells[idx - 3, 9] := StringReplace(SplitStr(FieldAsString('SUMMARY'),Margin,NextPart), #13#10,#10, [rfReplaceAll]);
                        Excel.WorkSheets[1].Rows[idx - 3].RowHeight := Excel.WorkSheets[1].Rows[idx - 3].RowHeight - 10;
                        Excel.WorkSheets[1].Cells[idx - 2, 9] := StringReplace(NextPart, #13#10,#10, [rfReplaceAll]);
                        Margin := 1024;
                        NextPart := '';
                        end
                      Else
                      Excel.WorkSheets[1].Cells[idx - 2, 9] := StringReplace(FieldAsString('SUMMARY'), #13#10,#10, [rfReplaceAll]);
                end
                else if  sub then
                begin
                  Excel.WorkSheets[1].Cells[idx - 2, 7] := FloatToStr(RoundTo(summpay_per_treaty, -2));
                                                           //Round(summpay_per_treaty/100000)/10;
                  if Round(summpay_per_treaty_year) > 0 then
                     //Round(summpay_per_treaty_year/100000)/10 > 0 then
                    if I <> 2 then
                      Excel.WorkSheets[1].Cells[idx - 2, 8] := FloatToStr(RoundTo(summpay_per_treaty_year, -2))
                                                               //Round(summpay_per_treaty_year/100000)/10
                    else
                      Excel.WorkSheets[1].Cells[idx - 2, 8] := FloatToStr(RoundTo(summpay_per_treaty, 2) - RoundTo(summpay_per_treaty_year, -2));
                                                               //Round(summpay_per_treaty/100000)/10 - Round(summpay_per_treaty_year/100000)/10;

                  // Новая тема, печатаем машиный код
                  Excel.WorkSheets[1].Cells[idx - 1, 1] := IntToStr(prev_id);

                  if not FieldIsNull('SUMMARY') then
                    If Length(FieldAsString('SUMMARY')) > 1024 Then
                        begin
                        Excel.Worksheets[1].Rows[idx - 1].Insert;
                        inc(idx);
                        Excel.WorkSheets[1].Cells[idx - 3, 9] := StringReplace(SplitStr(FieldAsString('SUMMARY'),Margin,NextPart), #13#10,#10, [rfReplaceAll]);
                        Excel.WorkSheets[1].Rows[idx - 3].RowHeight := Excel.WorkSheets[1].Rows[idx - 3].RowHeight - 10;
                        Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx-1]);
                        Excel.WorkSheets[1].Cells[idx - 2, 9] := StringReplace(NextPart, #13#10,#10, [rfReplaceAll]);
                        Margin := 1024;
                        NextPart := '';
                        end
                    Else
                    Excel.WorkSheets[1].Cells[idx - 2, 9] := StringReplace(FieldAsString('SUMMARY'), #13#10,#10, [rfReplaceAll]);
                end
                else
                begin
                  if not tr_closed then
                    Excel.WorkSheets[1].Cells[idx - 1, 7] := FloatToStr(RoundTo(summpay_per_treaty, -2))
                                                             //Round(summpay_per_treaty/100000)/10
                  else
                    Excel.WorkSheets[1].Cells[idx - 2, 7] := FloatToStr(RoundTo(summpay_per_treaty, -2));
                                                             //Round(summpay_per_treaty/100000)/10;
                  if Round(summpay_per_treaty_year) > 0 then
                     //Round(summpay_per_treaty_year/100000)/10 > 0 then
                    if not tr_closed then
                      Excel.WorkSheets[1].Cells[idx - 1, 8] := FloatToStr(RoundTo(summpay_per_treaty_year, -2))
                                                               // Round(summpay_per_treaty_year/100000)/10
                    else
                      Excel.WorkSheets[1].Cells[idx - 2, 8] := FloatToStr(RoundTo(summpay_per_treaty_year, -2));
                                                               //Round(summpay_per_treaty_year/100000)/10;

                  if not FieldIsNull('SUMMARY') then
                    if not tr_closed then
                      If Length(FieldAsString('SUMMARY')) > 1024 Then
                        begin
                        Excel.Worksheets[1].Rows[idx].Insert;
                        inc(idx);
                        Excel.WorkSheets[1].Cells[idx - 2, 9] := StringReplace(SplitStr(FieldAsString('SUMMARY'),Margin,NextPart), #13#10,#10, [rfReplaceAll]);
                        Excel.WorkSheets[1].Rows[idx - 2].RowHeight := Excel.WorkSheets[1].Rows[idx - 2].RowHeight - 10;
                        Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx-1]);
                        Excel.WorkSheets[1].Cells[idx - 1, 9] := StringReplace(NextPart, #13#10,#10, [rfReplaceAll]);
                        Margin := 1024;
                        NextPart := '';
                        end
                      Else
                      Excel.WorkSheets[1].Cells[idx - 1, 9] := StringReplace(FieldAsString('SUMMARY'), #13#10,#10, [rfReplaceAll])
                    else
                      If Length(FieldAsString('SUMMARY')) > 1024 Then
                        begin
                        Excel.Worksheets[1].Rows[idx - 1].Insert;
                        inc(idx);
                        Excel.WorkSheets[1].Cells[idx - 3, 9] := StringReplace(SplitStr(FieldAsString('SUMMARY'),Margin,NextPart), #13#10,#10, [rfReplaceAll]);
                        Excel.WorkSheets[1].Rows[idx - 3].RowHeight := Excel.WorkSheets[1].Rows[idx - 3].RowHeight - 10;
                        Excel.WorkSheets[1].Cells[idx - 2, 9] := StringReplace(NextPart, #13#10,#10, [rfReplaceAll]);
                        Margin := 1024;
                        NextPart := '';
                        end
                      Else
                      Excel.WorkSheets[1].Cells[idx - 2, 9] := StringReplace(FieldAsString('SUMMARY'), #13#10,#10, [rfReplaceAll])
                end;

                buildingReport.Next;
              end;


              next;
            end;

            while not odsMIChapter.Eof do
            begin
              Excel.Worksheets[1].Rows[idx + 1].Insert;
              Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
              subject := flMIChapter_KOD.AsString + '. ' + flMIChapter_PNAIM.AsString;
              Excel.Worksheets[1].Cells[idx, 1] := subject;
              if Length(subject) > 90 then
                Excel.WorkSheets[1].Rows[idx].RowHeight := Excel.WorkSheets[1].Rows[idx].RowHeight * ((Length(subject) div 90) + 1) + (Length(subject) div 90) * 0.5 * Excel.WorkSheets[1].Rows[idx].RowHeight;

              //Excel.WorkSheets[1].Rows[idx].PageBreak := 1;
              inc(idx);

              odsMIChapter.Next;
              buildingReport.Next;
            end;

            Formula1 := Formula1 + IntToStr(idx-1) + ')';
            Formula2 := Formula2 + IntToStr(idx-1) + ')';
            Excel.Worksheets[1].Rows[idx + 1].Insert;
            Excel.WorkSheets[1].Rows[idx + offs_table + 9].Copy(Excel.Worksheets[1].Rows[idx]);
            Excel.WorkSheets[1].Cells[idx, 6].Formula := Formula1;
            Excel.WorkSheets[1].Cells[idx, 8].Formula := Formula2;

            if MainFormula1 = '' then
            begin
              MainFormula1 := '=Sum(F' + IntToStr(idx);
              MainFormula2 := '=Sum(H' + IntToStr(idx);
            end
            else
            begin
              MainFormula1 := MainFormula1 + ', F' + IntToStr(idx);
              MainFormula2 := MainFormula2 + ', H' + IntToStr(idx);
            end;
            inc(idx);
          except
            Screen.Cursor:=crDefault;
            MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                       'Ошибка', mb_OK or mb_IconHand);
            Exit;
          end;
          inc(count_part);
        end;

        close;
      end;

    end;

    odsMIChapter.Close;
    odsMIChapter.Destroy;

    if count_part > 1 then
    begin
      MainFormula1 := MainFormula1 + ')';
      MainFormula2 := MainFormula2 + ')';
      Excel.Worksheets[1].Rows[idx + 1].Insert;
      Excel.WorkSheets[1].Rows[idx + offs_table + 10].Copy(Excel.Worksheets[1].Rows[idx]);
      Excel.WorkSheets[1].Cells[idx, 6].Formula := MainFormula1;
      Excel.WorkSheets[1].Cells[idx, 8].Formula := MainFormula2;
      inc(idx);
    end;

    {for I := 0 to ind_noBrPage - 1 do
    begin
      for J := 0 to count_breakPage_rows[I] - 1 do
      begin
        if Excel.Worksheets[1].Rows[no_breakPage_Rows[I] + 1 + J].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
        begin
          Excel.Worksheets[1].Rows[no_breakPage_Rows[I]].PageBreak := 1;
          buildingReport.Next(count_breakPage_rows[I] - J);
        end;

        buildingReport.Next;
      end;
    end;}

    Excel.Worksheets[1].Range['$'+IntToStr(idx) + ':$'+IntToStr(idx+count_delete_row)].Delete;

    // Увеличеваем значение ProgressBar на еденицу в окне copingForm
    buildingReport.Next;

    // Сообщаем  окну buildingReport  о финише формирования отчета
    buildingReport.Finish;
    Excel.Run('STRH');
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;

    Screen.Cursor:= crDefault;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

procedure TfmMainMenu.vpRN17RN18Click(Sender: TObject);
const
  beg_table : integer = 12; // Начало шаблона таблицы
  beg_new_table : integer = 13; // Начало самой таблицы
  count_cols : integer = 8;  // Количество колонок
  add_size : integer = 10; // Количество елементов, которое за раз добавляется в массив

  SEMAPHORE : string = 'NIOKR_SEMAPHORE';
var
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта

  v_from_date_str : String; // Дата начала временого интрвала отчета в текстовом формате
  v_to_date_str   : String; // Дата конча временого интрвала отчета в текстовом формате

  rep_from_year : Integer; // c года
  rep_to_year   : Integer; // по год

  //Excel_values : array of array of Variant; // Массив c значениями для
  //len_ExcelArray : Integer; // Длина Excel массива
  //count_Excel_Rows : Integer; // Кол Excel. строк

  I : Integer;
  count : Integer;
  idx : Integer;

  fact_year_from : Integer;
  fact_year_to   : Integer;
  fact_years : String;

  count_rec : Integer;

  thread : TLRQThread;
begin
  with TfmPickFromYearToYear.Create(Self) do
  begin
    se_FromYear.Value := StrToInt(FormatDateTime('yyyy',Date));
    se_ToYear.Value   := StrToInt(FormatDateTime('yyyy',Date));
    if ShowModal=mrOk then
    begin
      v_from_date_str := IntToStr(se_FromYear.Value);
      //v_from_date := StrToDate(v_from_date_str);
      v_to_date_str   := IntToStr(se_ToYear.Value);
      //v_to_date := StrToDate(v_to_date_str);
      rep_from_year := se_FromYear.Value;
      rep_to_year   := se_ToYear.Value;
      Free;
    end
    else begin  Free; Exit; end;
  end;

  if Sender = vpRN17 then
    St:=ExtractFilePath(Application.ExeName) + 'report\RN-17.xlt'
  else if Sender = vpRN18 then
    St:=ExtractFilePath(Application.ExeName) + 'report\RN-18.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);


  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    if rep_from_year = rep_to_year then
      Excel.WorkSheets[1].Cells[7, 1] := Excel.WorkSheets[1].Cells[7, 1].Text +   v_to_date_str + 'г.'
    else
      Excel.WorkSheets[1].Cells[7, 1] := Excel.WorkSheets[1].Cells[7, 1].Text +  v_from_date_str +'-'+  v_to_date_str + 'гг.';

    Excel.WorkSheets[1].Cells[10, 8] := Excel.WorkSheets[1].Cells[10, 8].Text +  v_to_date_str + 'г.';

    with dmglobal.quRN17RN18_Rep do
    begin
      SetVariable('DATEFROM', EncodeDate(rep_from_year, 1, 1));
      SetVariable('DATETO', EncodeDate(rep_to_year + 1, 1, 1));

      if Sender = vpRN17 then
        SetVariable('ISTFIN', 2)
      else if Sender = vpRN18 then
        SetVariable('ISTFIN', 1);

      Execute;

      idx:= beg_new_table;
      count := 0;

      if FieldIsNull('count_rec') then
        count_rec := 0
      else
        count_rec := FieldAsInteger('count_rec');
      if count_rec > 0 then
      begin

        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');

        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;

        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);

        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;

        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(count_rec + (beg_new_table - beg_table));
      end;

      while not EOF do
      begin
        try
          inc(count);

          Excel.Worksheets[1].Rows[idx].Insert;
          Excel.WorkSheets[1].Rows[beg_table].Copy(Excel.Worksheets[1].Rows[idx]);

          Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку
          Excel.WorkSheets[1].Cells[idx, 2] := FieldAsString('name'); // номер договора и организация испольнитель
          Excel.WorkSheets[1].Cells[idx, 3] := FieldAsString('dog_name'); // название договора
          Excel.WorkSheets[1].Cells[idx, 4] := FieldAsString('DATETO'); // Срок завершения
          Excel.WorkSheets[1].Cells[idx, 5] := FieldAsString('plan_date'); // Срок внедрения по плану

          // Срок внедрения разработки по факту
          if Field('FACT_DATE_FROM') <> NULL then
          begin
            fact_year_from := StrToInt(FieldAsString('FACT_DATE_FROM'));
            if Field('FACT_DATE_TO') <> NULL then
              fact_year_to := StrToInt(FieldAsString('FACT_DATE_TO'))
            else
              fact_year_to := rep_to_year;

            fact_years := IntToStr(fact_year_from);
            for I := fact_year_from + 1 to fact_year_to do
              fact_years := fact_years + #10 + IntToStr(I);

            Excel.WorkSheets[1].Cells[idx, 6] := fact_years;
          end
          else
            Excel.WorkSheets[1].Cells[idx, 6] := NULL;

          // Ожидаемый экономический годовой эффект
          if Field('exp_income') <> NULL then
            Excel.WorkSheets[1].Cells[idx, 7] := StringReplace(FieldAsString('exp_income'), #13#10,#10, [rfReplaceAll])
          else
            Excel.WorkSheets[1].Cells[idx, 7] := NULL;

          // Ожидаемый фактический экономический эффект
          if Field('fact_exp_inc') <> NULL then
            Excel.WorkSheets[1].Cells[idx, 8] := StringReplace(FieldAsString('fact_exp_inc'), #13#10,#10, [rfReplaceAll])
          else
            Excel.WorkSheets[1].Cells[idx, 8] := NULL;

          inc(idx);
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;

        next;
        buildingReport.Next;
      end;
    end;
    for I := beg_new_table - beg_table - 1 downto 0 do
    begin
      Excel.Worksheets[1].Rows[beg_table+I].Delete;
      if count_rec > 0 then
        buildingReport.Next;
    end;
    if count_rec > 0 then
        buildingReport.Finish;
    Excel.Run('STRH');
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;

    Screen.Cursor:= crDefault;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

procedure TfmMainMenu.vpRN19_20Click(Sender: TObject);
const
  beg_table : integer = 11; // Начало шаблона таблицы
  beg_new_table : integer = 13; // Начало самой таблицы
  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы
  CountTailRows : integer = 3;  // Кол. строк в конце док., которые должны напечататся на одной странице
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

var
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  v_date: TDate; // Дата отчета
  v_date_str : string; // Дата отчета в текстовом формате
  rep_year : string; // Год
  year : Integer;
  I : Integer;
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  count_stages : integer; // количество этапов в договоре
  summpay_per_treaty : Extended; // стоимость работ по договору
  summpay_per_treaty_this_next_years : Extended; // стоимость работ по договору в этом и следущиих годах
  summpay_per_treaty_prev_years : Extended; // стоимость работ по договору в предыдущие годы
  summpay_per_year : Extended; // стоимость работ по договору выполненных в текущем году
  summpay_stages_closed  : Extended; // Стоимость закрытых этапов
  erate_date : tdate;
  erate : Extended;
  quReport : TOracleQuery;

  thread : TLRQThread;

  PickYear : TfmPickYear;
  //ConcDateFrom, ConcDateTo : TDateTime;
  AConcern_DOG : Integer;

  count_treaty : Integer;
begin
  inherited;
  year := 0;
  v_date := 0;
  PickYear := TfmPickYear.Create(Self);
  PickYear.se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
  repeat
    if PickYear.ShowModal=mrOk then
    begin
      year := PickYear.se_Year.Value;
      v_date_str := '01.01.' + IntToStr(PickYear.se_Year.Value);
      v_date := StrToDate(v_date_str);
      rep_year := IntToStr(PickYear.se_Year.Value);
    end
    else begin  PickYear.Free; Exit; end;
    AConcern_DOG := -1;
    if Sender = vpRN19 then
      AConcern_DOG := GetConcern_Treaty(incMonth(v_date, 11));

  until (Sender<>vpRN19) or (AConcern_DOG >= 0);
  PickYear.Free;

  // ФОРМА RN-19
  if Sender=vpRN19 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-19.xlt';
  // ФОРМА RN-20
  if Sender=vpRN20 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-20.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;
  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;
  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;
  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);
  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');
  // Уничтожаем семафор
  CloseHandle(FSemaphore);
  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    Excel.WorkSheets[1].Cells[6, 1] := Excel.WorkSheets[1].Cells[6, 1].Text + ' ' + rep_year + ' ГОД';
    Excel.WorkSheets[1].Cells[beg_table  - 2, 7] := Excel.WorkSheets[1].Cells[beg_table - 2 , 7].Text + ' ' + rep_year + ' году';

    if Sender=vpRN19 then
    begin
      with TOracleQuery.Create(Self) do
      begin
        Session:= dmGlobal.seOracle;

        SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
        SQL.Append('  FROM RN.MITRCONCERN');
        SQL.Append(' WHERE  ID = :DOG_ID');

        DeclareVariable('DOG_ID', otInteger);
        SetVariable('DOG_ID', AConcern_DOG);
        Execute;

        Excel.WorkSheets[1].Cells[6, 1] := FieldAsString(0);

        Destroy;
      end;
    end;

    quReport := nil;
    // ФОРМА RN-19
    if Sender=vpRN19 then
    begin
      quReport := dmglobal.quRN19_Rep;
      quReport.SetVariable('CONC', AConcern_DOG);
      {if ConcDateFrom <> 0 then
        quReport.SetVariable('CONC_DATEFROM', ConcDateFrom)
      else
        quReport.SetVariable('CONC_DATEFROM', NULL);

      if ConcDateTo <> 0 then
        quReport.SetVariable('CONC_DATETO', ConcDateTo)
      else
        quReport.SetVariable('CONC_DATETO', NULL);}
    end;
    // ФОРМА RN-20
    if Sender=vpRN20 then quReport := dmglobal.quRN20_Rep;

    // Выполняем отчет
    with quReport do
    begin
      SetVariable('YEAR', year);

      Execute;
      idx:= beg_new_table; prev_id := -1; count := 1;
      count_stages := 0;

      summpay_per_year := 0;

      summpay_per_treaty := 0;
      summpay_per_treaty_this_next_years := 0;
      summpay_per_treaty_prev_years := 0;
      summpay_stages_closed := 0;

      erate_date := 0;
      erate := 0;

      if EOF then //FieldIsNull('count_treaty') then
        count_treaty := 0
      else
        count_treaty := FieldAsInteger('count_treaty');
      if count_treaty > 0 then
      begin
        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');
        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;
        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);
        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;
        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(count_treaty {* 2 + CountTailRows - 1});
      end;

      while not EOF do
      begin
        try
          // Проверяем тот же самый ли TREATY_ID [Field(0)]
          if Integer(Field('TREATY_ID')) <> prev_id then
          begin // Следующий договор
            summpay_stages_closed := 0;
            count_stages := Integer(Field('COUNT_PER_TREATY')); // Количество этапов на договор
            summpay_per_year := 0;
            if Sender=vpRN20 then
              summpay_per_year := 0;

            summpay_per_treaty := Extended(Field('TREATY_SUMMPAY')); // сумма по договору
            summpay_per_treaty_this_next_years := 0; // сумма в этом и следующих годах
            summpay_per_treaty_prev_years := 0;

            erate_date := Field('INTO_DATE');
            erate := Extended(Field('E_RATE'));

            Excel.Worksheets[1].Rows[idx].Insert;
            Excel.Worksheets[1].Rows[idx].Insert;
            Excel.WorkSheets[1].Rows[beg_table].Copy(Excel.Worksheets[1].Rows[idx]);
            Excel.WorkSheets[1].Rows[beg_table + 1].Copy(Excel.Worksheets[1].Rows[idx+1]);

            Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку
            inc(count);
            Excel.WorkSheets[1].Cells[idx+1, 1] := FieldAsString('temp_num'); // id
            Excel.WorkSheets[1].Cells[idx, 2] := String(Field('NUM')); // номер договора и исполнитель
            Excel.WorkSheets[1].Cells[idx, 3] := String(Field('SUBJECT')); // тема договора
            Excel.WorkSheets[1].Cells[idx, 4] := String(Field('DATEFROM')); // дата начала
            Excel.WorkSheets[1].Cells[idx+1, 4] := String(Field('DATETO')); // дата окончания
            inc(idx,2);
          end;
          dec(count_stages);
          if Integer(Field('CURRENCY_NO')) <> BYR then // Код валюты РБ.
          begin // Считаем для не РБ
            if (erate_date = null) or (erate_date < Field('INTO_DATE')) then // Курс
              begin erate_date := Field('INTO_DATE'); erate := Extended(Field('E_RATE')); end;
            if Field('DATEACT') <> null then
            begin
              summpay_stages_closed := summpay_stages_closed + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE')); // сумма в РБ для сданных этапов
              summpay_per_treaty := summpay_per_treaty - Extended(Field('STAGE_SUMMPAY')); // Сумма без сданных этапов
            end;
            if (Field('DATEACT') <> null) and (Field('DATEACT') <= StrToDate('31.12.' + rep_year))
                  and (Field('DATEACT') >= StrToDate('01.01.' + rep_year))
            then
            begin

              summpay_per_year := summpay_per_year+Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));
            end;

            if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_this_next_years := summpay_per_treaty_this_next_years + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));
              end
            else
            begin
              if // Проверяем по дате действия, если нет акта сдачи
                  (     (Field('STAGE_DATETO') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_prev_years := summpay_per_treaty_prev_years + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));
            end

          end
          else // Считаем для РБ
          begin
            if (Field('DATEACT') <> null) and (Field('DATEACT') <= StrToDate('31.12.' + rep_year))
                  and (Field('DATEACT') >= StrToDate('01.01.' + rep_year))
            then
            begin

              summpay_per_year := summpay_per_year+Extended(Field('STAGE_SUMMPAY'));
            end;


            if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_this_next_years := summpay_per_treaty_this_next_years + Extended(Field('STAGE_SUMMPAY'));
            end
            else
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_prev_years := summpay_per_treaty_prev_years + Extended(Field('STAGE_SUMMPAY'));
            end
          end;

          if count_stages < 1 then
          begin

            Excel.WorkSheets[1].Cells[idx-2, 7].Value := RoundTo(summpay_per_year,-2);

            if Integer(Field('CURRENCY_NO')) <> BYR then
            begin
              Excel.WorkSheets[1].Cells[idx-1, 3] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field('CURRENCY_NAME'))
                                                     + '  на ' + DateToStr(erate_date);
              Excel.WorkSheets[1].Cells[idx-2, 5] := RoundTo(summpay_per_treaty*erate+summpay_stages_closed, -2);
              if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
                summpay_per_treaty_prev_years := RoundTo(summpay_per_treaty*erate+summpay_stages_closed -  summpay_per_treaty_this_next_years, -2);
            end
            else
            begin
              Excel.WorkSheets[1].Cells[idx-2, 5] := FormatFloat('#0.00',RoundTo(summpay_per_treaty, -2));
              if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
                summpay_per_treaty_prev_years := RoundTo(summpay_per_treaty*erate+summpay_stages_closed -  summpay_per_treaty_this_next_years, -2);
            end;

            if summpay_per_treaty_prev_years > 0 then
              Excel.WorkSheets[1].Cells[idx-2, 6].Value := RoundTo(summpay_per_treaty_prev_years, -2);

            buildingReport.Next;
          end;
          prev_id := Integer(Field('TREATY_ID'));
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;
        Next;
      end;

      Excel.Worksheets[1].rows[idx].Delete;
      Excel.Worksheets[1].Range['$'+IntToStr(beg_table) + ':$'+IntToStr(beg_new_table - 1)].Delete;

      if count_treaty > 0 then
        // Увеличеваем значение ProgressBar на еденицу в окне copingForm
        buildingReport.Next;

      {for I := 1 to count_treaty - 1 do
      begin
        if Excel.Worksheets[1].Rows[beg_table + I * 2 + 1 + beg_new_table - beg_table].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
          Excel.Worksheets[1].Rows[beg_table + I * 2 + beg_new_table - beg_table].PageBreak := 1;

        buildingReport.Next;
      end;}
    end;

    if count_treaty > 0 then
    begin
      {for I := idx + 1 to idx + CountTailRows - 1 do
      begin
        if Excel.Worksheets[1].Rows[I].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
        begin
          Excel.Worksheets[1].Rows[idx].PageBreak := 1;
          buildingReport.Next(idx + CountTailRows - I);
          break;
        end;

        buildingReport.Next;
      end;}

      // Сообщаем  окну buildingReport  о финише формирования отчета
      buildingReport.Finish;
    end;
    Excel.Run('STRH');
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;
    Screen.Cursor:= crDefault;
    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;         
end;

procedure TfmMainMenu.StateDataSetToStateModeButtons;
begin
  if Assigned(dsGlobal.DataSet) and (dsGlobal.DataSet is TVASUPQuery) then
       with dsGlobal.DataSet as TVASUPQuery do
         case WorkState of
           wsAdd    : begin
                        sbAdd.Enabled := true;
                        sbAdd.Down := true;
                      end;
           wsEdit   : begin
                        sbEdit.Enabled := true;
                        sbEdit.Down := true;
                      end;
           wsDelete : begin
                        sbDelete.Enabled := true;
                        sbDelete.Down := true;
                      end;
           wsView   : begin
                        sbView.Enabled := true;
                        sbView.Down := true;
                      end;
           wsQuery  : begin
                        sbQuery.Enabled := true;
                        sbQuery.Down  := true;
                      end;
           else UpModeButtons;
         end
  else
    UpModeButtons;
end;

procedure TfmMainMenu.UpModeButtons;
begin
  sbAdd.Down    := false;
  sbEdit.Down   := false;
  sbDelete.Down := false;
  sbView.Down   := false;
  sbQuery.Down  := false;
end;

function TfmMainMenu.GetConcern_Treaty(ADate : TDateTime) : Integer;
var
  LQuery : TOracleQuery;
  dogs :  Array of Integer;
  dog_names :  Array of String;
  dogs_datefrom :  Array of TDateTime;
  //dogs_dateto :  Array of TDateTime;
  dogs_limit  :  Array of char;
  //dogs_beginDate : Array of TDateTime;
  //dog_endDate : TDateTime;
  len : Integer;
  I : Integer;
  Ind : Integer;

  d : TDateTime;

  existentLimit : boolean; // Существуют ограничения рамочнных договоров
  //LimitFrom : TDateTime;   // Ограничение начала временого интрвала
  //LimitTo   : TDateTime;   // Ограничение конча временого интрвала

  lYear, lMonth, lDay : Word;
  Year : Integer;
  //dateto, datefrom : TDateTime;
begin
  Result := -1;
  //dog_endDate := 0;
  LQuery := TOracleQuery.Create(nil);
  try
    LQuery.Session := dmGlobal.seOracle;

    DecodeDate(ADate, lYear, lMonth, lDay);
    Year := lYear;

    // Читаем действующие рамочные договора за AYear год
    with LQuery.SQL do
    begin
      add('SELECT id, ''№'' || num || '' от '' || TO_CHAR(datesign, ''dd.mm.yyyy'') name, fact_datefrom datefrom, fact_dateto dateto, datefrom begin_date, dateto end_date, DOG_LIMIT');
      add('  FROM RN.viconcern_treaty');
      add(' WHERE TRUNC(TO_DATE(TO_CHAR(:YEAR), ''yyyy''), ''YEAR'') BETWEEN TRUNC(datefrom, ''YEAR'') AND fact_dateto');
      add('   AND :REP_DATE >= datefrom');
      add(' ORDER BY datefrom');
    end;
    LQuery.DeclareVariable('YEAR', otInteger);
    LQuery.SetVariable('YEAR', Year);
    LQuery.DeclareVariable('REP_DATE', otDate);
    LQuery.SetVariable('REP_DATE', ADate);
    LQuery.Execute;

    //LimitFrom := 0;
    //LimitTo := 0;
    //Ind := 0;

    if not LQuery.Eof then
    begin
      // имеются действующие рамочные договора за AYear год

      len := 0;
      SetLength(dogs, 1);
      SetLength(dog_names, 1);
      SetLength(dogs_datefrom, 1);
      //SetLength(dogs_dateto, 1);
      SetLength(dogs_limit, 1);
      //SetLength(dogs_beginDate, 1);

      // Запоминаем действующие рамочные договора
      while not LQuery.Eof do
      begin
        inc(len);
        SetLength(dogs, len);
        SetLength(dog_names, len);
        SetLength(dogs_datefrom, len);
        //SetLength(dogs_dateto, len);
        SetLength(dogs_limit, len);
        //SetLength(dogs_beginDate, len);
        dogs[len - 1] := LQuery.FieldAsInteger('ID');
        dog_names[len - 1] := LQuery.FieldAsString('NAME');
        dogs_datefrom[len - 1] := LQuery.FieldAsDate('DATEFROM');
        //dogs_dateto[len - 1] := LQuery.FieldAsDate('DATETO');
        dogs_limit[len - 1] := LQuery.FieldAsString('DOG_LIMIT')[1];
        //dogs_beginDate[len - 1] := LQuery.FieldAsDate('BEGIN_DATE');

        LQuery.next;
      end;

      if len > 1 then
      begin
        // Больше одного действующего договора

        // Ищем ограничения рамочных договоров
        existentLimit := false;
        for I := 0 to len - 1 do
          if dogs_limit[I] <> 'N' then
          begin
            existentLimit := true;
            break;
          end;

        if existentLimit then
        begin
          // Существуют ограничения. Необходимо выбрать рамочный договор,
          // чтобы определится с ограничениями

          // Предоставляем возможность, выбрать договор пользователю
          with TFmPickConcernDog.Create(Self) do
          begin
            for I := 0 to len - 1 do
              AddDog(dog_names[I]);
            if ShowModal=mrOk then
              Ind := GetSelDog
            else
              Ind := -1;
            Free;
          end;

          if Ind >= 0 then
          begin
            Result := dogs[Ind];

          {  // Вычисляем интервал в годах действия рамочного договора (ограничения договора)

            // Вычислем начала временого интервала
            if not (dogs_limit[Ind] in ['B', 'F']) then
            begin
              // Рамочный договор не имеет ограничения начла временого интервала

              // Возможно у предыдущих рамочных договоров были ограничения
              // Ищем их
              for I := Ind - 1 downto 0 do
                // Предыдущий договор
                // Проверяем имеет ли он ограничения
                if dogs_limit[I] <> 'N' then
                begin
                  // Имеет ограничения
                  if dogs_limit[I] in ['E', 'F'] then
                  begin
                    LimitFrom := dogs_dateto[I] + 1;
                    break;
                  end
                  else if dogs_limit[I] = 'B' then
                  begin
                    LimitFrom := dogs_datefrom[I];
                    break;
                  end;
                end;
            end
            else
              LimitFrom := dogs_datefrom[Ind];

            // Вычислем конец временого интервала
            if not (dogs_limit[Ind] in ['E', 'F']) then
            begin
              // Рамочный договор не имеет ограничения начла временого интервала

              // Возможно у предыдущих рамочных договоров были ограничения
              // Ищем их
              for I := Ind + 1 to len - 1 do
                // Предыдущий договор
                // Проверяем имеет ли он ограничения
                if dogs_limit[I] <> 'N' then
                begin
                  // Имеет ограничения
                  if dogs_limit[I] in ['B', 'F'] then
                  begin
                    LimitTo := dogs_dateFrom[I] - 1;
                    if dogs_beginDate[I] <> 0 then
                      dog_endDate := dogs_beginDate[I] - 1
                    else
                      dog_endDate := dogs_dateFrom[I] - 1;
                    break;
                  end
                  else if dogs_limit[I] = 'E' then
                  begin
                    LimitTo := dogs_dateTo[I];
                    dog_endDate := dogs_dateTo[I];
                    break;
                  end;
                end;
            end
            else
              LimitFrom := dogs_dateTo[Ind];}
          end;
        end
        else
        begin
          // Не существуют ограничения.
          // Выбираем рамочный договор, который дейтвует на дату рамочного договора
          d := 0;
          for I := 0 to len - 1 do
            if (ADate >= dogs_dateFrom[I]) and ((d = 0) or ((d <> 0) and (d < dogs_dateFrom[I]))) then
              Result := dogs[I];
        end;


      end
      else if len = 1 then
      begin
        Result := dogs[0];

        {if dogs_limit[0] in ['B', 'F'] then
          LimitFrom := dogs_datefrom[0];

        if dogs_limit[0] in ['E', 'F'] then
        begin
          LimitTo := dogs_dateto[0];
          dog_endDate := dogs_dateto[0];
        end;}
      end;

      {if LimitFrom <> 0 then
      begin
        if dogs_beginDate[Ind] <> 0 then
          DecodeDate(dogs_beginDate[Ind], lYear, lMonth, lDay)
        else
          DecodeDate(LimitFrom, lYear, lMonth, lDay);
        //if lYear = Year then
          ADateFrom := LimitFrom;
      end;

      if LimitTo <> 0 then
      begin
        if dog_endDate <> 0 then
          DecodeDate(dog_endDate, lYear, lMonth, lDay)
        else
          DecodeDate(LimitTo, lYear, lMonth, lDay);
        //if lYear = Year then
          ADateTo := LimitTo;
      end;}
    end
    else
    begin
      SetLength(dogs, 0);
      SetLength(dog_names, 0);
      SetLength(dogs_datefrom, 0);
      //SetLength(dogs_dateto, 0);
      SetLength(dogs_limit, 0);
      //SetLength(dogs_beginDate, 0);
    end;

  finally
    LQuery.Destroy;
  end;
end;

function TfmMainMenu.GetTitle_PerecenDogovorov(AConcernID : Variant; ADate : TDateTime) : String;
var
  LQuery : TOracleQuery;
begin
  Result := '';

  LQuery := TOracleQuery.Create(nil);
  try
    LQuery.Session := dmGlobal.seOracle;

    // Читаем наименование рамочного договора или доп. соглашения
    with LQuery.SQL do
    begin
      add('      SELECT NVL(concern.name, DOG.name)');
      add('        FROM rn.mitrconcern dog,');
      add('             rn.mitrconcern concern');
      add('       WHERE DOG.ID = :CONCERN');
      add('         AND :REP_DATE BETWEEN concern.DATEFROM');
      add('         AND concern.DATETO');
      add('         AND DOG.ID = concern.DOG_ID');
      add('UNION');
      add('      SELECT DOG.name');
      add('        FROM rn.mitrconcern dog');
      add('       WHERE DOG.ID = :CONCERN');
      add('         AND DOG.DOG_ID IS NULL');
      add('         AND NOT EXISTS(SELECT *');
      add('                          FROM rn.mitrconcern dog,');
      add('                               rn.mitrconcern concern');
      add('                         WHERE DOG.ID = :CONCERN');
      add('                           AND :REP_DATE BETWEEN concern.DATEFROM');
      add('                           AND concern.DATETO');
      add('                           AND DOG.ID = concern.DOG_ID)');
      add('UNION');
      add('      SELECT NVL(concern.name, DOG.name)');
      add('        FROM rn.mitrconcern concern,');
      add('             rn.mitrconcern dog');
      add('       WHERE :CONCERN IS NULL');
      add('         AND :REP_DATE BETWEEN concern.DATEFROM');
      add('         AND concern.DATETO');
      add('         AND DOG.ID(+) = concern.DOG_ID');
    end;
    LQuery.DeclareVariable('CONCERN', otInteger);
    LQuery.SetVariable('CONCERN', AConcernID);
    LQuery.DeclareVariable('REP_DATE', otDate);
    LQuery.SetVariable('REP_DATE', ADate);
    LQuery.Execute;

    if not LQuery.Eof then
      Result := LQuery.FieldAsString(0);

  finally
    LQuery.Destroy;
  end;

end;

function TfmMainMenu.GetNumDogInPerecenDogovorov(AConcernID : Variant; ADate : TDateTime;
                      AConcernFrom : TDateTime = 0; AConcernTo : TDateTime = 0) : TStrings;
var
  quPerDog : TOracleQuery;
  lID : Integer;
  currId : Integer;
  //lNum : Integer;
  str : String;
begin
  if AConcernID <> NULL then
  begin
    quPerDog := dmGlobal.quRN03_Rep;

    quPerDog.SetVariable('CONC', AConcernID)
  end
  else
    quPerDog := dmGlobal.quRN04_Rep;

  Result := TStringList.Create;

  with quPerDog do
  begin
    SetVariable('V_DATE', ADate);

    Execute;

    lID  := -1;
    SetLength(str, SizeOf(Integer));
    //lNum := 0;
    while not Eof do
    begin
      currId := FieldAsInteger('treaty_id');

      if lID <> currId then
      begin
        lID := currId;
        UniqueString(str);
        PInteger(str)^ := lID;
        Result.Add(str);
      end;

      next;
    end;

  end;

end;

procedure TfmMainMenu.OnException(Sender: TObject; E: Exception);
begin
  if not (E is ECursorCanNotMoveAboutRecord) then
    // Если ошибка не ECursorCanNotMoveAboutRecord,
    //то пускай её обрабатывает стандартный обработчик
    Application.ShowException(E);
end;

procedure TfmMainMenu.SetBusy;
begin
  Self.Enabled := false;
end;

procedure TfmMainMenu.ResetBusy;
begin
  Self.Enabled := true;
end;

procedure TfmMainMenu.ShowDialogBox;
begin
  // Создаем окно, в котором будет отображатся инф. о состоянии копирования данных


  buildingReport := TFrmCoping.Create(nil);

  ReleaseSemaphore(FSemaphore, 1, nil);

  buildingReport.ShowModal;

  // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
  buildingReport.Destroy;

end;

procedure TfmMainMenu.vpRN21RN22Click(Sender: TObject);
const
  //beg_table : integer = 9; // Начало шаблона таблицы
  beg_new_table : integer = 9; // Начало самой таблицы
  offs_table : integer = 3; // Начало шаблона таблицы
  count_cols : integer = 6;  // Количество колонок
  add_size : integer = 11; // Количество елементов, которое за раз добавляется в массив
  count_characters_of_title_row : integer = 100; // Число символов в заголовке отчета
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';
  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы

  CountTailRows_RN03 : integer = 13;  // Кол. строк в конце док., которые должны напечататся на одной странице
  CountTailRows_RN04 : integer = 0;  // Кол. строк в конце док., которые должны напечататся на одной странице

  count_delete_row : integer = 11; // Количество строк шаблона, которое необходимо удалить
var
  //vbeg_table : integer; // Начало шаблона таблицы
  vbeg_new_table : integer; // Начало самой таблицы

  thread : TLRQThread;
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application

  v_date_str : string; // Дата отчета в текстовом формате
  rep_date : TDateTime;
  v_date: TDate; // Дата отчета
  rep_month : string; // Название месяца
  rep_year : string; // Год
  AConcern_DOG : Integer;

  PickMonth : TfmPickMonth;

  ConcDateFrom, ConcDateTo : TDateTime;

  St:     OLEVariant;  // Файл темплейта

  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  count_art_treaty : Integer;
  count_stages : integer;
  summpay_per_treaty : Extended;
  summpay_per_year : Extended;
  summpay_stages_closed  : Extended;
  erate_date : tdate;
  erate : Extended;
  quReport : TOracleQuery;

  I : Integer;

  count_dog : Integer; // Количество договоров
  vCountTailRows : Integer;

  prev_article_id  : integer;// id пердыдущего раздела
  ConcDogID  : Integer;

  count_conc_treaty : Integer;
  count_innov_treaty : Integer;

  progress : Integer;

  odsMIChapter : TOracleDataSet;
  flMIChapter_KOD   : TField;
  flMIChapter_PNAIM : TField;

  {no_breakPage_Rows : Array of Integer;
  ind_noBrPage : Integer;}

  count_article : Integer;

  Formula1 : String;
  Formula2 : String;
  Concern_Formula1 : String;
  Concern_Formula2 : String;
  Main_Formula1 : String;
  Main_Formula2 : String;

  article : String;

  PickYear : TfmPickYear;
  year : Integer;
begin
  vbeg_new_table := beg_new_table;

  PickYear := TfmPickYear.Create(nil);
  PickYear.se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
  if PickYear.ShowModal=mrOk then
  begin
    year := PickYear.se_Year.Value;
    v_date_str := '01.01.' + IntToStr(PickYear.se_Year.Value);
    v_date := StrToDate(v_date_str);
    rep_year := IntToStr(PickYear.se_Year.Value);
  end
  else begin  PickYear.Free; Exit; end;

  PickYear.Free;

  // ФОРМА RN-21
  if Sender=vpRN21 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-21.xlt';
  // ФОРМА RN-22
  if Sender=vpRN22 then St:=ExtractFilePath(Application.ExeName) + 'report\RN-22.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    //rep_year := FormatDateTime('yyyy', now);
    Excel.WorkSheets[1].Cells[vbeg_new_table - 2, 6] := 'В т.ч. ' + rep_year + 'г.';

    quReport := dmglobal.quRN21RN22_Rep;

    odsMIChapter := TOracleDataSet.Create(nil);
    odsMIChapter.CountAllRecords := true;
    odsMIChapter.SQL.Add('SELECT * FROM RN.MICHAPTER ORDER BY KOD');
    odsMIChapter.Session := dmGlobal.seOracle;
    odsMIChapter.Open;

    flMIChapter_KOD   := odsMIChapter.FieldByName('KOD');
    flMIChapter_PNAIM := odsMIChapter.FieldByName('PNAIM');

    {SetLength(no_breakPage_Rows, 0);
    ind_noBrPage := 0;}

    Formula1 := '';
    Formula2 := '';
    Concern_Formula1 := '';
    Concern_Formula2 := '';
    Main_Formula1 := '';
    Main_Formula2 := '';

    // Выполняем отчет
    with quReport do
    begin
      // ФОРМА RN-21
      if Sender=vpRN21 then
        SetVariable('ISTFIN_KOD', 2);
      // ФОРМА RN-22
      if Sender=vpRN22 then
        SetVariable('ISTFIN_KOD', 1);

      SetVariable('YEAR', v_date);

      Execute;

      count_dog := 0;
      count_conc_treaty := 0;
      count_innov_treaty := 0;
      // Устанавливаем пораметры для отображение процесса формирования отчета
      if not EOF then
      begin
        count_dog := FieldAsInteger('count_treaty');

        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');

        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;

        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);

        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;

        progress := count_dog;
        count_conc_treaty := FieldAsInteger('count_conc_treaty');
        if count_conc_treaty > 1 then
          inc(progress, count_conc_treaty {* 2});

        if Sender = vpRN21 then
          inc(progress, count_conc_treaty {* 2} * odsMIChapter.RecordCount);
        if Sender = vpRN22 then
          inc(progress, {2 *} odsMIChapter.RecordCount);

        count_article := FieldAsInteger('count_article');
        {SetLength(no_breakPage_Rows, count_dog - count_article);
        inc(progress, count_dog - count_article);}

        // Операция добовления строки всего
        inc(progress);
        // Операция удалиния строк шаблона
        inc(progress);

        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(progress);
      end;

      idx:= vbeg_new_table; prev_id := -1; count := 1;
      count_stages := 0;
      summpay_per_year := 0;
      erate_date := 0;
      erate := 0;
      summpay_per_treaty := 0;
      summpay_stages_closed := 0;
      prev_article_id := -1;
      ConcDogID  := -1;
      count_art_treaty := 0;

      odsMIChapter.First;

      while not EOF do
      begin
        try

          // Проверяем тот же самый ли id [Field(0)]
          if Integer(Field('ID')) <> prev_id then
          begin // Следующий договор

            if (Integer(Field('CHAPTER_KOD')) <> prev_article_id ) or
               (FieldIsNull('CONC_TREATY') and (ConcDogID <> -1)) or
               ((not FieldIsNull('CONC_TREATY')) and (ConcDogID <> Integer(Field('CONC_TREATY'))))
            then
            begin


              if (Sender = vpRN21) and
                 (count_conc_treaty > 0) and
                 (   (FieldIsNull('CONC_TREATY') and (ConcDogID <> -1))
                   or
                     ((not FieldIsNull('CONC_TREATY')) and (ConcDogID <> Integer(Field('CONC_TREATY')))))
              then
              begin

                count_innov_treaty := FieldAsInteger('count_innov_treaty');
                Excel.Worksheets[1].Rows[idx + 1].Insert;
                Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);
                ConcDogID := Integer(Field('CONC_TREATY'));

                if ConcDogID >= 0 then
                begin
                  with TOracleQuery.Create(Self) do
                  begin
                    Session:= dmGlobal.seOracle;

                    SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
                    SQL.Append('  FROM RN.MITRCONCERN');
                    SQL.Append(' WHERE  ID = :DOG_ID');

                    DeclareVariable('DOG_ID', otInteger);
                    SetVariable('DOG_ID', ConcDogID);
                    Execute;

                    Excel.WorkSheets[1].Cells[idx, 1] := Excel.WorkSheets[1].Cells[idx, 1].Text + String(FieldAsString(0));

                    Destroy;
                  end;
                end;

                odsMIChapter.First;

                inc(idx);
                buildingReport.Next;
              end;

              if count_art_treaty = 0 then
              begin
                count_art_treaty := FieldAsInteger('count_art_treaty');

                prev_article_id := Integer(Field('CHAPTER_KOD'));

                while  (flMIChapter_KOD.AsInteger <> prev_article_id) and (not odsMIChapter.Eof) do
                begin
                  Excel.Worksheets[1].Rows[idx + 1].Insert;
                  Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
                  article := flMIChapter_KOD.AsString + '. ' + flMIChapter_PNAIM.AsString;
                  Excel.Worksheets[1].Cells[idx, 1] := article;
                  if Length(article) > 90 then
                    Excel.WorkSheets[1].Rows[idx].RowHeight := Excel.WorkSheets[1].Rows[idx].RowHeight * ((Length(article) div 90) + 1) + (Length(article) div 90) * 0.5 * Excel.WorkSheets[1].Rows[idx].RowHeight;
                  inc(idx);
                  buildingReport.Next;

                  Excel.Worksheets[1].Rows[idx + 1].Insert;
                  Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx]);

                  Excel.Worksheets[1].Cells[idx, 5].Formula := '=SUM(E' + IntToStr(idx - 1) + ':E' + IntToStr(idx - 1) + ')';
                  Excel.Worksheets[1].Cells[idx, 6].Formula := '=SUM(F' + IntToStr(idx - 1) + ':F' + IntToStr(idx - 1) + ')';

                  //Excel.WorkSheets[1].Rows[idx + 1].PageBreak := 1;

                  if (Sender = vpRN21) and (count_conc_treaty > 1) then
                  begin
                    if Concern_Formula1 = '' then
                    begin
                      Concern_Formula1 := '=Sum(E' + IntToStr(idx);
                      Concern_Formula2 := '=Sum(F' + IntToStr(idx);
                    end
                    else
                    begin
                      Concern_Formula1 := Concern_Formula1 + ', E' + IntToStr(idx);
                      Concern_Formula2 := Concern_Formula2 + ', F' + IntToStr(idx);
                    end;
                  end
                  else
                  begin
                    if Main_Formula1 = '' then
                    begin
                      Main_Formula1 := '=Sum(E' + IntToStr(idx);
                      Main_Formula2 := '=Sum(F' + IntToStr(idx);
                    end
                    else
                    begin
                      Main_Formula1 := Main_Formula1 + ', E' + IntToStr(idx);
                      Main_Formula2 := Main_Formula2 + ', F' + IntToStr(idx);
                    end;
                  end;

                  inc(idx);


                  odsMIChapter.Next;
                  buildingReport.Next;
                end;

                Excel.Worksheets[1].Rows[idx + 1].Insert;
                Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
                article := flMIChapter_KOD.AsString + '. ' + flMIChapter_PNAIM.AsString;
                Excel.Worksheets[1].Cells[idx, 1] := article;
                if Length(article) > 90 then
                  Excel.WorkSheets[1].Rows[idx].RowHeight := Excel.WorkSheets[1].Rows[idx].RowHeight * ((Length(article) div 90) + 1) + (Length(article) div 90) * 0.5 * Excel.WorkSheets[1].Rows[idx].RowHeight;
                inc(idx);

                Formula1 := '=SUM(E' + IntToStr(idx);
                Formula2 := '=SUM(F' + IntToStr(idx);

                buildingReport.Next;
                odsMIChapter.Next;
              end;
            end;
            {else
            begin
              no_breakPage_Rows[ind_noBrPage] := idx + 1;
              inc(ind_noBrPage);
            end;}

           { if prev_id >= 0 then
              // Увеличеваем значение ProgressBar на еденицу в окне copingForm
              buildingReport.Next;}

            Excel.Worksheets[1].Rows[idx + 1].Insert;
            Excel.Worksheets[1].Rows[idx + 2].Insert;

            summpay_stages_closed := 0;
            count_stages := Integer(Field('count_per_treaty')); // Количество этапов на договор
            summpay_per_year := 0;
            summpay_per_treaty := Extended(Field('summpay')); // сумма по договору
            erate_date := Field('into_date');
            erate := Extended(Field('e_rate'));


            if Field('treaty_status') = 'O' then // OPERATIVE Действующий договор
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx + 1]);
            end
            else if Field('treaty_status') = 'F' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx + 1]);
              Excel.WorkSheets[1].Cells[idx + 1, 2] := 'ЗАКРЫТ';
            end
            else if Field('treaty_status') = 'A' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx + 1]);
              Excel.WorkSheets[1].Cells[idx + 1, 2] := 'АННУЛИРОВАН';
            end;

            Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку
            inc(count);
            Excel.WorkSheets[1].Cells[idx + 1, 1] := FieldAsString('num');  // id
            Excel.WorkSheets[1].Cells[idx, 2] := String(Field(1)) + #10 + FieldAsString('exec_name'); // номер договора и исполнитель
            Excel.WorkSheets[1].Cells[idx, 3] := String(Field(2)); // тема договора
            Excel.WorkSheets[1].Cells[idx, 4] := String(Field(3)); // дата начала
            Excel.WorkSheets[1].Cells[idx + 1, 4] := String(Field(4)); // дата окончания
            inc(idx,2);
            prev_id := Integer(Field('ID'));
          end;


          dec(count_stages);
          if Integer(Field('currency_no')) <> BYR then // Код валюты РБ.
          begin // Считаем для не РБ
            if (erate_date = null) or (erate_date < Field('into_date')) then // Курс
            begin
              erate_date := Field('into_date');
              erate := Extended(Field('e_rate'));
            end;
            if Field('dateact') <> null then
            begin
              summpay_stages_closed := summpay_stages_closed + Extended(Field('stage_summpay'))*Extended(Field('e_rate')); // сумма в РБ для сданных этапов
              summpay_per_treaty := summpay_per_treaty - Extended(Field('stage_summpay')); // Сумма без сданных этапов
            end;
            if (not FieldIsNull('dateact')) and
               (Field('dateact') <= StrToDate('31.12.' + rep_year)) and
               (Field('dateact') >= StrToDate('01.01.' + rep_year))
            then
              summpay_per_year := summpay_per_year+Extended(Field('stage_summpay'))*Extended(Field('e_rate'));
          end
          else // Считаем для РБ
          begin
            if (not FieldIsNull('dateact')) and
               (Field('dateact') <= StrToDate('31.12.' + rep_year)) and
               (Field('dateact') >= StrToDate('01.01.' + rep_year))
            then
              summpay_per_year := summpay_per_year+Extended(Field('stage_summpay'));
          end;
          if count_stages < 1 then
          begin
            if summpay_per_year > 0 then
              Excel.WorkSheets[1].Cells[idx - 2,6] := FloatToStr(RoundTo(summpay_per_year, -2))
            else
              Excel.WorkSheets[1].Cells[idx - 2,6] := '';
            if Integer(Field('currency_no')) <> BYR then
            begin
              Excel.WorkSheets[1].Cells[idx - 1,3] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field('currency_name'))
                                                      + '  на ' + DateToStr(erate_date);

              Excel.WorkSheets[1].Cells[idx - 2,5] := FloatToStr(RoundTo(summpay_per_treaty*erate+summpay_stages_closed, -2));
            end
            else
              Excel.WorkSheets[1].Cells[idx - 2,5]  := FloatToStr(RoundTo(summpay_per_treaty, -2));

            buildingReport.Next;

            dec(count_art_treaty);
            if (Sender = vpRN21) and (count_conc_treaty > 1) then
              dec(count_innov_treaty);


            if count_art_treaty < 1 then
            begin
              Formula1 := Formula1 + ':E' + IntToStr(idx - 1) + ')';
              Formula2 := Formula2 + ':F' + IntToStr(idx - 1) + ')';

              Excel.Worksheets[1].Rows[idx + 1].Insert;
              Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx]);

              Excel.Worksheets[1].Cells[idx, 5].Formula := Formula1;
              Excel.Worksheets[1].Cells[idx, 6].Formula := Formula2;

              Formula1 := '';
              Formula2 := '';

              if (Sender = vpRN21) and (count_conc_treaty > 1) then
              begin
                if Concern_Formula1 = '' then
                begin
                  Concern_Formula1 := '=Sum(E' + IntToStr(idx);
                  Concern_Formula2 := '=Sum(F' + IntToStr(idx);
                end
                else
                begin
                  Concern_Formula1 := Concern_Formula1 + ', E' + IntToStr(idx);
                  Concern_Formula2 := Concern_Formula2 + ', F' + IntToStr(idx);
                end;
              end
              else
              begin
                if Main_Formula1 = '' then
                begin
                  Main_Formula1 := '=Sum(E' + IntToStr(idx);
                  Main_Formula2 := '=Sum(F' + IntToStr(idx);
                end
                else
                begin
                  Main_Formula1 := Main_Formula1 + ', E' + IntToStr(idx);
                  Main_Formula2 := Main_Formula2 + ', F' + IntToStr(idx);
                end;
              end;

              inc(idx);
              buildingReport.Next;

              if    ((Sender = vpRN21) and (count_conc_treaty > 1) and (count_innov_treaty < 1))
                 or
                    ((count - 1) = count_dog)
              then
              begin
                while not odsMIChapter.Eof do
                begin
                  //Excel.WorkSheets[1].Rows[idx].PageBreak := 1;
                  Excel.Worksheets[1].Rows[idx + 1].Insert;
                  Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
                  article := flMIChapter_KOD.AsString + '. ' + flMIChapter_PNAIM.AsString;
                  Excel.Worksheets[1].Cells[idx, 1] := article;
                  if Length(article) > 90 then
                    Excel.WorkSheets[1].Rows[idx].RowHeight := Excel.WorkSheets[1].Rows[idx].RowHeight * ((Length(article) div 90) + 1) + (Length(article) div 90) * 0.5 * Excel.WorkSheets[1].Rows[idx].RowHeight;
                  inc(idx);
                  buildingReport.Next;

                  Excel.Worksheets[1].Rows[idx + 1].Insert;
                  Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx]);

                  Excel.Worksheets[1].Cells[idx, 5].Formula := '=SUM(E' + IntToStr(idx - 1) + ':E' + IntToStr(idx - 1) + ')';
                  Excel.Worksheets[1].Cells[idx, 6].Formula := '=SUM(F' + IntToStr(idx - 1) + ':F' + IntToStr(idx - 1) + ')';


                  if (Sender = vpRN21) and (count_conc_treaty > 1) then
                  begin
                    if Concern_Formula1 = '' then
                    begin
                      Concern_Formula1 := '=Sum(E' + IntToStr(idx);
                      Concern_Formula2 := '=Sum(F' + IntToStr(idx);
                    end
                    else
                    begin
                      Concern_Formula1 := Concern_Formula1 + ', E' + IntToStr(idx);
                      Concern_Formula2 := Concern_Formula2 + ', F' + IntToStr(idx);
                    end;
                  end
                  else
                  begin
                    if Main_Formula1 = '' then
                    begin
                      Main_Formula1 := '=Sum(E' + IntToStr(idx);
                      Main_Formula2 := '=Sum(F' + IntToStr(idx);
                    end
                    else
                    begin
                      Main_Formula1 := Main_Formula1 + ', E' + IntToStr(idx);
                      Main_Formula2 := Main_Formula2 + ', F' + IntToStr(idx);
                    end;
                  end;

                  inc(idx);

                  odsMIChapter.Next;
                  buildingReport.Next;
                end;
              end;

              if (Sender = vpRN21) and (count_conc_treaty > 1) and (count_innov_treaty < 1) then
              begin
                Concern_Formula1 := Concern_Formula1 + ')';
                Concern_Formula2 := Concern_Formula2 + ')';

                if Main_Formula1 = '' then
                begin
                  Main_Formula1 := '=Sum(E' + IntToStr(idx);
                  Main_Formula2 := '=Sum(F' + IntToStr(idx);
                end
                else
                begin
                  Main_Formula1 := Main_Formula1 + ', E' + IntToStr(idx);
                  Main_Formula2 := Main_Formula2 + ', F' + IntToStr(idx);
                end;

                Excel.Worksheets[1].Rows[idx + 1].Insert;
                Excel.WorkSheets[1].Rows[idx + offs_table + 7].Copy(Excel.Worksheets[1].Rows[idx]);

                Excel.Worksheets[1].Cells[idx, 5].Formula := Concern_Formula1;
                Excel.Worksheets[1].Cells[idx, 6].Formula := Concern_Formula2;

                Concern_Formula1 := '';
                Concern_Formula2 := '';

                inc(idx);
                buildingReport.Next;
              end;

              if (count - 1) = count_dog then
              begin
                Main_Formula1 := Main_Formula1 + ')';
                Main_Formula2 := Main_Formula2 + ')';

                Excel.Worksheets[1].Rows[idx + 1].Insert;
                if (Sender = vpRN21) and (count_conc_treaty > 1) then
                  Excel.WorkSheets[1].Rows[idx + offs_table + 8].Copy(Excel.Worksheets[1].Rows[idx])
                else
                  Excel.WorkSheets[1].Rows[idx + offs_table + 7].Copy(Excel.Worksheets[1].Rows[idx]);

                Excel.Worksheets[1].Cells[idx, 5].Formula := Main_Formula1;
                Excel.Worksheets[1].Cells[idx, 6].Formula := Main_Formula2;

                inc(idx);
                buildingReport.Next;
              end
              {else
                Excel.WorkSheets[1].Rows[idx].PageBreak := 1;}
            end;

          end;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;
        Next;
      end;

      {for I := 0 to Length(no_breakPage_Rows) - 1 do
      begin
        if Excel.Worksheets[1].Rows[no_breakPage_Rows[I]].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
          Excel.Worksheets[1].Rows[no_breakPage_Rows[I] - 1].PageBreak := 1;
        buildingReport.Next;
      end};

      Excel.Worksheets[1].Range['$'+IntToStr(idx) + ':$'+IntToStr(idx+count_delete_row)].Delete;

      Close;
    end;

    odsMIChapter.Close;
    odsMIChapter.Destroy;
    Excel.Run('STRH');
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;

    Screen.Cursor:= crDefault;

    // Делаем доступным приложение, для пользователя
    resetBusy;

  end;
end;  // End of vpRN21RN22 Click



procedure TfmMainMenu.vpRepConcClick(Sender: TObject);
const
  //beg_table : integer = 11; // Начало шаблона таблицы
  beg_new_table : integer = 12; // Начало самой таблицы
  //beg_new_table : integer = 17; // Начало самой таблицы
  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы
  CountTailRows_RN07 : integer = 10;  // Кол. строк в конце док., которые должны напечататся на одной странице
  CountTailRows_RN08 : integer = 3;  // Кол. строк в конце док., которые должны напечататся на одной странице
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';
  offs_table : integer = 3; // Начало шаблона таблицы
  count_cols : integer = 10;  // Количество колонок
var
  thread : TLRQThread;

  //vbeg_new_table : integer; // Начало самой таблицы
  //vcount_cols : integer;  // Количество колонок

  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  v_from_date: TDate; // Дата отчета
  v_from_date_str : string; // Дата отчета в текстовом формате
  v_to_date : TDate; // Дата отчета
  v_to_date_str : string; // Дата отчета в текстовом формате
  rep_from_month : string; // Название месяца
  rep_from_year : string; // Год
  rep_to_month : string; // Название месяца
  rep_to_year : string; // Год
  year : Integer;
  //num_dog : Integer; // Кол. инновацион. договоров
  I : Integer;
  //shift_beg_tabl : Integer;
  str_dog : String;
  //str : String;
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  count_stages : integer; // количество этапов в договоре

  plan_summpay_per : Extended; // плановая стоимость работ по договору за отчетный период
  fact_summpay_per : Extended; // фактическая стоимость работ по договору за отчетный период


  summpay_per_treaty : Extended; // стоимость работ по договору
  summpay_per_treaty_this_next_years : Extended; // стоимость работ по договору в этом и следущиих годах
  summpay_per_treaty_prev_years : Extended; // стоимость работ по договору в предыдущие годы
  //summpay_per_dog_year : array of Extended; // стоимость работ по договору выполненных в текущем году в рамках рамочных договоров
  summpay_per_year : Extended; // стоимость работ по договору выполненных в текущем году
  summpay_stages_closed  : Extended; // Стоимость закрытых этапов
  //conc_dog_id : array of Integer; // список идентификаторов рамочных договоров которые действуют в текущем году
  erate_date : tdate;
  erate : Extended;
  quReport : TOracleQuery;
  //ExcelFormula : String;
  //NextYearDogCount : Integer;
  //text : String;
  //vCountTailRows : Integer;

  PickMonths : TfmPickMonth_From_To;
  //ConcDateFrom, ConcDateTo : TDateTime;
  AConcern_DOG : Integer;
  //nr : Integer;

  count_dog : Integer; // Количество договоров

begin
  inherited;

  //ConcDateFrom := 0;
  //ConcDateTo := 0;

  v_from_date := 0;
  v_to_date := 0;
  rep_from_year := '';
  rep_from_month := '';
  rep_to_year := '';
  rep_to_month := '';
  year := 0;

  PickMonths := TfmPickMonth_From_To.Create(Self);
  repeat
    if PickMonths.ShowModal=mrOk then
    begin
      year := PickMonths.se_FromYear.Value;
      v_from_date_str := '01.' + IntToStr(PickMonths.cbFromMonth.ItemIndex + 1) + '.' + IntToStr(PickMonths.se_FromYear.Value);
      v_from_date := StrToDate(v_from_date_str);
      v_to_date_str := '01.' + IntToStr(PickMonths.cbToMonth.ItemIndex + 1) + '.' + IntToStr(PickMonths.se_ToYear.Value);
      v_to_date := StrToDate(v_to_date_str);
      rep_from_year := IntToStr(PickMonths.se_FromYear.Value);
      rep_from_month  := GetMonth(PickMonths.cbFromMonth.ItemIndex);
      rep_to_year := IntToStr(PickMonths.se_ToYear.Value);
      rep_to_month  := GetMonth(PickMonths.cbToMonth.ItemIndex);
    end
    else begin  PickMonths.Free; Exit; end;

    AConcern_DOG := GetConcern_Treaty(v_to_date);

  until (AConcern_DOG >= 0);
  PickMonths.Free;


  St:=ExtractFilePath(Application.ExeName) + 'report\repConc.xlt';


  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    Excel.WorkSheets[1].Cells[beg_new_table  - 6 , 1] := Excel.WorkSheets[1].Cells[beg_new_table - 6 , 1].Text + ' ' + rep_from_month + ' '+ rep_from_year + ' года  -- по ' + rep_to_month + ' '+ rep_to_year + ' года';

    with TOracleDataSet.Create(Self) do
    begin

      Session:= dmGlobal.seOracle;

      SQL.Append('SELECT  DATESIGN, NUM ');
      SQL.Append('  FROM RN.MITRCONCERN');
      SQL.Append(' WHERE  ID = :DOG_ID');

      DeclareVariable('DOG_ID', otInteger);
      SetVariable('DOG_ID', AConcern_DOG);

      try
        Open;

        str_dog := 'ПО ДОГОВОРУ ОТ ';
        if FieldValues['DATESIGN'] <> NULL then
          str_dog := str_dog + FormatDateTime('dd.mm.yyyy', FieldValues['DATESIGN']) + 'г. № '
        else
          str_dog := str_dog + '               № ';

        if FieldValues['NUM'] <> NULL then
          str_dog := str_dog + FieldValues['NUM'];

        Excel.WorkSheets[1].Cells[beg_new_table - 5, 1] := str_dog;

        Excel.WorkSheets[1].Cells[beg_new_table  - 2, 7] := 'Выполнено в ' + rep_from_year;

      except
        Screen.Cursor:=crDefault;
        MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                   'Ошибка', mb_OK or mb_IconHand);
      end;

      close;

      Destroy;
    end;

    quReport := dmglobal.quRepConc;

    // Выполняем отчет
    with quReport do
    begin
      SetVariable('CONC', AConcern_DOG);
      {if ConcDateFrom <> 0 then
        SetVariable('CONC_DATEFROM',ConcDateFrom)
      else
        SetVariable('CONC_DATEFROM',NULL);

      if ConcDateTo <> 0 then
        SetVariable('CONC_DATETO',ConcDateTo)
      else
        SetVariable('CONC_DATETO',NULL);}


      SetVariable('DATE_FROM', v_from_date);
      SetVariable('DATE_TO', v_to_date);

      Execute;

      count_dog := 0;
      // Устанавливаем пораметры для отображение процесса формирования отчета
      if not EOF then
      begin
        count_dog := FieldAsInteger('count_treaty');

        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');

        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;

        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);

        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;

        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(count_dog {* 2 + vCountTailRows});
      end;

      idx:= beg_new_table; prev_id := -1; count := 1;
      count_stages := 0;

      summpay_per_year := 0;

      summpay_per_treaty := 0;
      summpay_per_treaty_this_next_years := 0;
      summpay_per_treaty_prev_years := 0;
      summpay_stages_closed := 0;

      plan_summpay_per := 0;
      fact_summpay_per := 0;

      erate_date := 0;
      erate := 0;

      while not EOF do
      begin
        try
           
          // Проверяем тот же самый ли TREATY_ID [Field(0)]
          if Integer(Field('TREATY_ID')) <> prev_id then
          begin // Следующий договор
            if prev_id >= 0 then
              // Увеличеваем значение ProgressBar на еденицу в окне copingForm
              buildingReport.Next;

            summpay_stages_closed := 0;
            count_stages := Integer(Field('COUNT_PER_TREATY')); // Количество этапов на договор

            plan_summpay_per := 0;
            fact_summpay_per := 0;

            summpay_per_year := 0;

            summpay_per_treaty := Extended(Field('TREATY_SUMMPAY')); // сумма по договору
            summpay_per_treaty_this_next_years := 0; // сумма в этом и следующих годах
            summpay_per_treaty_prev_years := 0;

            erate_date := Field('INTO_DATE');
            erate := Extended(Field('E_RATE'));

            Excel.Worksheets[1].Rows[idx + 1].Insert;
            Excel.Worksheets[1].Rows[idx + 2].Insert;
            if Field('STATUS') = 'O' then // OPERATIVE Действующий договор
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 2].Copy(Excel.Worksheets[1].Rows[idx+1]);
            end
            else if Field('STATUS') = 'F' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx+1]);
              Excel.WorkSheets[1].Cells[idx+1, 2] := 'ЗАКРЫТ';
            end
            else if Field('STATUS') = 'A' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx+1]);
              Excel.WorkSheets[1].Cells[idx+1, 2] := 'АННУЛИРОВАН';
            end;

            Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку
            inc(count);
            Excel.WorkSheets[1].Cells[idx+1, 1] := FieldAsString('rep_num');//String(Field('TREATY_ID')); // id
            Excel.WorkSheets[1].Cells[idx, 2] := Trim(String(Field('NUM'))); // номер договора и исполнитель
            Excel.WorkSheets[1].Cells[idx, 3] := Trim(String(Field('SUBJECT'))); // тема договора
            Excel.WorkSheets[1].Cells[idx, 4] := Trim(String(Field('DATEFROM'))); // дата начала
            Excel.WorkSheets[1].Cells[idx+1, 4] := Trim(String(Field('DATETO'))); // дата окончания
            if not FieldIsNull('summary') then
              Excel.WorkSheets[1].Cells[idx, 10] := Trim(String(Field('summary')))
            else
              Excel.WorkSheets[1].Cells[idx, 10] := '';
            inc(idx,2);
            prev_id := Integer(Field('TREATY_ID'));

            if count = 11 then
            count := 11;
          end;

          dec(count_stages);
          if Integer(Field('CURRENCY_NO')) <> BYR then // Код валюты РБ.
          begin // Считаем для не РБ
            //if (erate_date = null) or (erate_date < Field('INTO_DATE')) then // Курс
              begin erate_date := Field('INTO_DATE'); erate := Extended(Field('E_RATE')); end;
            if Field('DATEACT') <> null then
            begin
              summpay_stages_closed := summpay_stages_closed + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE')); // сумма в РБ для сданных этапов
              summpay_per_treaty := summpay_per_treaty - Extended(Field('STAGE_SUMMPAY')); // Сумма без сданных этапов

              if (FieldAsDate('DATEACT') >= v_from_date) and (FieldAsDate('DATEACT') < IncMonth(v_to_date, 1)) then
              begin
                plan_summpay_per := plan_summpay_per + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));
                if FieldAsDate('DATEACT') < IncMonth(v_to_date, 1) then
                  fact_summpay_per := fact_summpay_per + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));
              end;
            end
            else
              if (FieldAsDate('STAGE_DATETO') >= v_from_date) and (FieldAsDate('STAGE_DATETO') < IncMonth(v_to_date, 1)) then
                plan_summpay_per := plan_summpay_per + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));

            if (Field('DATEACT') <> null) and (Field('DATEACT') <= StrToDate('31.12.' + rep_from_year))
                  and (Field('DATEACT') >= StrToDate('01.01.' + rep_from_year))
            then
              summpay_per_year := summpay_per_year+Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));


            if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_this_next_years := summpay_per_treaty_this_next_years + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));
            end
            else
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_prev_years := summpay_per_treaty_prev_years + Extended(Field('STAGE_SUMMPAY'))*Extended(Field('E_RATE'));
            end

          end
          else // Считаем для РБ
          begin
            if Field('DATEACT') <> null then
            begin

              if (FieldAsDate('DATEACT') >= v_from_date) and (FieldAsDate('DATEACT') < IncMonth(v_to_date, 1)) then
              begin
                plan_summpay_per := plan_summpay_per + Extended(Field('STAGE_SUMMPAY'));
                if FieldAsDate('DATEACT') < IncMonth(v_to_date, 1) then
                  fact_summpay_per := fact_summpay_per + Extended(Field('STAGE_SUMMPAY'));
              end;
            end
            else
              if (FieldAsDate('STAGE_DATETO') >= v_from_date) and (FieldAsDate('STAGE_DATETO') < IncMonth(v_to_date, 1)) then
                plan_summpay_per := plan_summpay_per + Extended(Field('STAGE_SUMMPAY'));

            if (Field('DATEACT') <> null) and (Field('DATEACT') <= StrToDate('31.12.' + rep_from_year))
                  and (Field('DATEACT') >= StrToDate('01.01.' + rep_from_year))
            then
              summpay_per_year := summpay_per_year+Extended(Field('STAGE_SUMMPAY'));



            if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') >= EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_this_next_years := summpay_per_treaty_this_next_years + Extended(Field('STAGE_SUMMPAY'));
            end
            else
            begin
              if // Проверяем по дате действия, если не такта сдачи
                  (     (Field('STAGE_DATETO') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') = null))
                  // или, если есть дата акта, то по нему
                 or
                  (     (Field('DATEACT') < EncodeDate(year, 1, 1))
                    and (Field('DATEACT') <> null))
              then
                summpay_per_treaty_prev_years := summpay_per_treaty_prev_years + Extended(Field('STAGE_SUMMPAY'));
            end
          end;

          if count_stages < 1 then
          begin
            if summpay_per_year > 0 then
              Excel.WorkSheets[1].Cells[idx-2, 7] := FloatToStr(RoundTo(summpay_per_year, -2))
            else
              Excel.WorkSheets[1].Cells[idx-2, 7] := '';

            if plan_summpay_per > 0 then
              Excel.WorkSheets[1].Cells[idx-2, 8] := FloatToStr(RoundTo(plan_summpay_per, -2))
            else
              Excel.WorkSheets[1].Cells[idx-2, 8] := '';


            if fact_summpay_per > 0 then
              Excel.WorkSheets[1].Cells[idx-2, 9] := FloatToStr(RoundTo(fact_summpay_per, -2))
            else
              Excel.WorkSheets[1].Cells[idx-2, 9] := '';

            if Integer(Field('CURRENCY_NO')) <> BYR then
            begin
              Excel.WorkSheets[1].Cells[idx-1, 3] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field('CURRENCY_NAME'))
                                                     + '  на ' + DateToStr(erate_date);
              Excel.WorkSheets[1].Cells[idx-2, 5] := FloatToStr(RoundTo(summpay_per_treaty*erate+summpay_stages_closed, -2));
              if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
                summpay_per_treaty_prev_years := RoundTo(summpay_per_treaty*erate+summpay_stages_closed -  summpay_per_treaty_this_next_years, -2);
            end
            else
            begin
              Excel.WorkSheets[1].Cells[idx-2, 5] := FloatToStr(RoundTo(summpay_per_treaty, -2));
              if Field('DATEFROM_YEAR') < '2004' then // Т.к. в БД нет всех данных до 2004 года,
                                                      // то значения графы в отчете ВЫП. В ПРЕДЫДУЩИЕ ГОДЫ
                                                      // для договоров заключенных раннее 2004 года считаем по особому
                summpay_per_treaty_prev_years := RoundTo(summpay_per_treaty*erate+summpay_stages_closed -  summpay_per_treaty_this_next_years, -2);
            end;

            if summpay_per_treaty_prev_years > 0 then
              Excel.WorkSheets[1].Cells[idx-2, 6] := FloatToStr(RoundTo(summpay_per_treaty_prev_years, -2))
            else
              Excel.WorkSheets[1].Cells[idx-2, 6] := '';
          end;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;
        Next;
      end;

      Excel.Worksheets[1].Range['$'+IntToStr(idx) + ':$'+IntToStr(idx + 9)].Delete;
      if count_dog > 0 then
        buildingReport.Next;
      Close;

    end;

    if count_dog > 0 then
      // Сообщаем  окну buildingReport  о финише формирования отчета
      buildingReport.Finish;
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

procedure TfmMainMenu.vpRN01_ConcrnClick(Sender: TObject);
const
  beg_new_table : integer = 14; // Начало самой таблицы
  offs_table : integer = 3; // Начало шаблона таблицы
  cols : integer = 7;
  max_columns : integer = 21; // Максимальное число столбцов для копирования
  CountTailRows_RN01 : integer = 4;  // Кол. строк в конце док., которые должны напечататся на одной странице
  CountTailRows_RN02 : integer = 3;  // Кол. строк в конце док., которые должны напечататся на одной странице

  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

  Max_count_stages : Integer = 10;

  count_delete_row : integer = 5; // Количество строк шаблона, которое необходимо удалить
var
  thread : TLRQThread;

  vbeg_new_table : integer; // Начало самой таблицы
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  v_date: TDate; // Дата отчета
  v_date_str : string; // Дата отчета в текстовом формате
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  rep_month : string; // Название месяца
  rep_year : string; // Год
  count_stages : integer;
  trconcern : string;

  AConcern_DOG : Integer;

  PickMonth : TfmPickMonth;
  rep_date : TDateTime;

  withAddCol : boolean;

  nums : TStrings; // Список ID договоров в порядке, как в перечне договоров
  strDogID : String; // Идентификатор договора

  strAddCol : String;

  I : Integer;

  count_treatys : Integer; // Число договоров

  tr_idx : Integer;
begin
  vbeg_new_table := beg_new_table; // Начало самой таблицы

  SetLength(strDogID, SizeOf(Integer));

  v_date := 0;
  rep_date := 0;

  strAddCol := '';


  PickMonth := TfmPickMonthWithAddColumn.Create(Self);


  withAddCol := false;
  repeat
    if PickMonth.ShowModal=mrOk then
    begin
      v_date_str := '01.' + IntToStr(PickMonth.cbMonth.ItemIndex+1) + '.'+ IntToStr(PickMonth.se_Year.Value);
      rep_date := EncodeDate(PickMonth.se_Year.Value, PickMonth.cbMonth.ItemIndex+1, 1);
      v_date := StrToDate(v_date_str);
      rep_month := PickMonth.cbMonth.Items[PickMonth.cbMonth.ItemIndex];
      rep_year := IntToStr(PickMonth.se_Year.Value);
    end
    else begin  PickMonth.Free; Exit; end;

    AConcern_DOG := -1;

    AConcern_DOG := GetConcern_Treaty(v_date);
    withAddCol := TfmPickMonthWithAddColumn(PickMonth).withAddCol;

  until AConcern_DOG >= 0;
  PickMonth.Free;

  if withAddCol then
    St:=ExtractFilePath(Application.ExeName) + 'report\RN-01_2_Concern.xlt'
  else
    St:=ExtractFilePath(Application.ExeName) + 'report\RN-01_Concern.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  // Вычисляем номера договоров в Перечне договоров
  if AConcern_DOG >= 0 then
    nums := GetNumDogInPerecenDogovorov(AConcern_DOG, v_date)
  else
    nums := GetNumDogInPerecenDogovorov(NULL, v_date);

  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
     Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    count_treatys := 0;

    with TOracleQuery.Create(Self) do
    begin
      Session:= dmGlobal.seOracle;

      SQL.Append('SELECT  '' от '' || DECODE(DATESIGN, NULL, ''             '', TO_CHAR(DATESIGN, ''DD.MM.YYYY'') || ''г.'')  || '' № '' || NUM DOG_DOC,');
      SQL.Append('        (SELECT '' от '' || DECODE(AGR.DATESIGN, NULL, ''             '', TO_CHAR(AGR.DATESIGN, ''DD.MM.YYYY'') || ''г.'')  || '' № '' || AGR.NUM');
      SQL.Append('           FROM RN.MITRCONCERN AGR');
      SQL.Append('          WHERE AGR.DOG_ID = :DOG_ID AND AGR.DATEFROM <= :REP_DATE AND (AGR.DATETO >= :REP_DATE OR AGR.DATETO = (SELECT MAX(AGR1.DATETO) FROM RN.MITRCONCERN AGR1 WHERE AGR1.DOG_ID = :DOG_ID)))  AGR_DOC,');
      SQL.Append('        (SELECT AGR.ID');
      SQL.Append('           FROM RN.MITRCONCERN AGR');
      SQL.Append('          WHERE AGR.DOG_ID = :DOG_ID AND AGR.DATEFROM <= :REP_DATE AND (AGR.DATETO >= :REP_DATE OR AGR.DATETO = (SELECT MAX(AGR1.DATETO) FROM RN.MITRCONCERN AGR1 WHERE AGR1.DOG_ID = :DOG_ID))) AGR');
      SQL.Append('  FROM RN.MITRCONCERN');
      SQL.Append(' WHERE  ID = :DOG_ID');

      DeclareVariable('DOG_ID', otInteger);
      SetVariable('DOG_ID', AConcern_DOG);
      DeclareVariable('REP_DATE', otDate);
      SetVariable('REP_DATE', rep_date);

      Execute;
      if not EOF then
      begin
        if not FieldIsNULL(2) then
        begin
          Inc(vbeg_new_table);
          Excel.WorkSheets[1].Rows[9].Insert;
          Excel.WorkSheets[1].Rows[8].Copy(Excel.Worksheets[1].Rows[9]);
          Excel.WorkSheets[1].Cells[9, 1] := 'ДОПОЛНИТЕЛЬНОЕ СОГЛАШЕНИЕ  ' + FieldAsString(1);

          Excel.WorkSheets[1].Cells[8, 1] := 'ОТЧЕТ О ВЫПОЛНЕНИИ И ФИНАНСИРОВАНИИ РАБОТ ЗА ' + rep_month + ' ' + rep_year + ' ГОДА'; { ПО ДОГОВОРУ ' + FieldAsString(0);}
        end
        else
          Excel.WorkSheets[1].Cells[8, 1] := 'ОТЧЕТ О ВЫПОЛНЕНИИ И ФИНАНСИРОВАНИИ РАБОТ ЗА ' + rep_month + ' ' + rep_year + ' ГОДА'; { ПО ДОГОВОРУ ' + FieldAsString(0);}
      end
      else
        trconcern:='';
      Close;
      Free;
    end;

{    Excel.WorkSheets[1].Cells[vbeg_new_table - 5, 1] := 'ЗА ' + rep_month + ' ' + rep_year + ' ГОДА'; // Отчетный месяц}
    // Выполняем отчет
    with dmglobal.quRN01_Concern do
    begin
      SetVariable('V_DATETO',v_date);
      SetVariable('V_DATEFROM',v_date);

      SetVariable('CONC', AConcern_DOG);

      Execute;
      idx:= vbeg_new_table; prev_id := -1; count := 1;
      count_stages := 0;

      if not EOF then
      begin
        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');

        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;

        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);

        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;

        count_treatys := FieldAsInteger('count_treaty');
      end;

      tr_idx := 0;
      while not EOF do
      begin
        try
          // Проверяем тот же самый ли id [Field(0)]
          if Integer(Field(0)) <> prev_id then
          begin // Следующий договор
            strAddCol := '';
            count_stages := Integer(Field(8)); // Количество этапов на договор
            Excel.Worksheets[1].Rows[idx + 1].Insert;

            Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);
            Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку
            inc(count);
            Excel.WorkSheets[1].Cells[idx, 2] := String(Field(1)) + #10 + FieldAsString('exec_name'); // номер договора и исполнитель
            Excel.WorkSheets[1].Cells[idx, 3] := String(Field(2)); // тема договора
            tr_idx := idx;
            inc(idx);
            prev_id := Integer(Field(0));

            buildingReport.Next;
          end;
          Excel.Worksheets[1].Rows[idx + 1].Insert;

          if withAddCol then
            if not FieldIsNull('REPORTING') then
            begin
              if strAddCol <> '' then
                strAddCol := strAddCol + #10 + FieldAsString('REPORTING')
              else
                strAddCol := FieldAsString('REPORTING');
            end;

          // Копируем шаблонную строку в зависимости какой по счету этап
          if count_stages > 1  then
            Excel.WorkSheets[1].Rows[idx + offs_table+1].Copy(Excel.Worksheets[1].Rows[idx])
          else
          begin
            Excel.WorkSheets[1].Rows[idx + offs_table+2].Copy(Excel.Worksheets[1].Rows[idx]);

            // Читаем номер договора в Перечне договоров
            PInteger(strDogID)^ := prev_id;

            if withAddCol and (strAddCol <> '') then
              Excel.WorkSheets[1].Cells[tr_idx, 6] := StringReplace(strAddCol, #13#10,#10, [rfReplaceAll]);

            Excel.WorkSheets[1].Cells[idx, 1] := FieldAsString('num'); //String(Field(0));
          end;

          dec(count_stages);
          Excel.WorkSheets[1].Cells[idx, 3] := String(Field(3));

          if (not FieldIsNull('stage_dateact')) and (FieldAsDate('stage_dateact') >= rep_date) and (FieldAsDate('stage_dateact') < IncMonth(rep_date, 1)) then
            if (not FieldIsNull(5)) {and (FieldAsFloat(5) > 0)} then
              Excel.WorkSheets[1].Cells[idx, 4] := Round(FieldAsFloat(5)*FieldAsFloat(7))/1000;

          if (not FieldIsNull('datepay')) and (FieldAsDate('datepay') >= rep_date) and (FieldAsDate('datepay') < IncMonth(rep_date, 1)) then
            if (not FieldIsNull(5)) {and (FieldAsFloat(5) > 0)} then
              Excel.WorkSheets[1].Cells[idx, 5] := Round(FieldAsFloat(5)*FieldAsFloat(7))/1000;

          inc(idx);
          buildingReport.Next;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;

        Next;
      end;

      // удаляем записи шаблонной таблицы
      Excel.Worksheets[1].Range['$'+IntToStr(idx) + ':$'+IntToStr(idx+count_delete_row)].Delete;

      if count_treatys > 0 then
        // Увеличеваем значение ProgressBar на еденицу в окне copingForm
        buildingReport.Next;

      Close;
    end;

    if count_treatys > 0 then
      buildingReport.Finish;
    Excel.Run('STRH');  
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;
    nums.Destroy;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

procedure TfmMainMenu.vpPaymentClick(Sender: TObject);
const
  beg_new_table : integer = 7; // Начало самой таблицы
  offs_table : integer = 3; // Начало шаблона таблицы

  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

  count_delete_row : integer = 10; // Количество строк шаблона, которое необходимо удалить
var
  thread : TLRQThread;

  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта

  PickYear : TfmPickYear;
  rep_year : string; // Год
  year : Integer;

  month : Integer;
  rep_month : String;

  I : Integer;
  str : String;

  y, m, d : Word;

  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора

  progress : Integer;

  count : integer;
  count_stages : integer;

  quReport : TOracleQuery;

  RowHeight : Extended;
  h : Extended;
  s : String;
  l : Integer;
begin
  rep_year := '';

  PickYear := TfmPickYear.Create(Self);
  PickYear.se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));

  if PickYear.ShowModal=mrOk then
  begin
    year := PickYear.se_Year.Value;
    //v_date_str := '01.01.' + IntToStr(PickYear.se_Year.Value);
    //v_date := StrToDate(v_date_str);
    rep_year := IntToStr(PickYear.se_Year.Value);
  end
  else
  begin
    PickYear.Free;
    Exit;
  end;

  PickYear.Free;

  DecodeDate(Date, y, m, d);
  if y = year then
    month := m
  else if y < year then
    month := 12
  else
    month := 1;

  rep_month := AnsiUpperCase(GetMonth(month - 1));
  St:=ExtractFilePath(Application.ExeName) + 'report\payment_1.xlt';
  // Делаем недоступным приложение, для пользователя
  SetBusy;
  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;
  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));
  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;
  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);
  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');
  // Уничтожаем семафор
  CloseHandle(FSemaphore);
  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
               'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;
  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;
    str := Excel.WorkSheets[1].Cells[1, 1];
    str := str + ' ' + rep_year + ' г.';
    Excel.WorkSheets[1].Cells[1, 1] := str;
    str := Excel.WorkSheets[1].Cells[beg_new_table - 3, 10];
    str := str + rep_month;
    Excel.WorkSheets[1].Cells[beg_new_table - 3, 10] := str;
    str := Excel.WorkSheets[1].Cells[beg_new_table - 3, 11];
    str := str + rep_year + ' г.';
    Excel.WorkSheets[1].Cells[beg_new_table - 3, 11] := str;

    idx:= beg_new_table;

    count := 0;

    buildingReport.Caption := 'Формируется отчет';
    buildingReport.SetCaption('Идет процесс формирования отчета...');
    // Устанавливаем начальные значения в окне buildingReport
    buildingReport.reset;
    // Делаем в окне buildingReport видимым ProgressBar
    buildingReport.visibleProgressBar(true);
    // Сообщаем  окну buildingReport  о начала копирования данных
    buildingReport.Start;
    quReport := dmglobal.quPayment_1;
    quReport.SetVariable('REP_DATE', EncodeDate(year, month, 1));
    quReport.Execute;
    prev_id := -1;
    count_stages := 0;

    with quReport do
    begin
      if not Eof then
      begin
        progress := FieldAsInteger('COUNT_STAGE');
        buildingReport.SetMax(progress);

        while not Eof do
        begin
          if (prev_id = -1) or (prev_id<>FieldAsInteger('TR_ID')) then
          begin
            prev_id := FieldAsInteger('TR_ID');
            count_stages := 0;
            inc(count);

            Excel.Worksheets[1].Rows[idx + 1].Insert;
            if FieldAsInteger('COUNT_TREATY_STAGE') > 1 then
            begin
              if FieldAsString('TR_STATUS') = 'O' then
                Excel.WorkSheets[1].Rows[idx + offs_table + 2].Copy(Excel.Worksheets[1].Rows[idx])
              else
                Excel.WorkSheets[1].Rows[idx + offs_table + 5].Copy(Excel.Worksheets[1].Rows[idx]);
            end
            else
            begin
              if FieldAsString('TR_STATUS') = 'O' then
                Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx])
              else
                Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
            end;

            Excel.WorkSheets[1].Cells[idx, 1] := IntToStr(count);
            Excel.WorkSheets[1].Cells[idx, 2] := StringReplace(FieldAsString('TR_NUM'), #13#10,#10, [rfReplaceAll]);
            Excel.WorkSheets[1].Cells[idx, 3] := StringReplace(FieldAsString('TR_SUBJECT'), #13#10,#10, [rfReplaceAll]);

            Excel.WorkSheets[1].Cells[idx, 10] := FloatToStr(RoundTo(FieldAsFloat('MONTH_TREATY_SUMMPAY'), -2));
            Excel.WorkSheets[1].Cells[idx, 11] := FloatToStr(RoundTo(FieldAsFloat('YEAR_TREATY_SUMMPAY'), -2));

            Excel.WorkSheets[1].Cells[idx, 9] := StringReplace(FieldAsString('REPORTING'), #13#10,#10, [rfReplaceAll]);
          end
          else
          begin
            Excel.Worksheets[1].Rows[idx + 1].Insert;
            if (count_stages + 1) < FieldAsInteger('COUNT_TREATY_STAGE') then
            begin
              if FieldAsString('TR_STATUS') = 'O' then
                Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx])
              else
                Excel.WorkSheets[1].Rows[idx + offs_table + 6].Copy(Excel.Worksheets[1].Rows[idx]);
            end
            else
            begin
              if FieldAsString('TR_STATUS') = 'O' then
                Excel.WorkSheets[1].Rows[idx + offs_table + 4].Copy(Excel.Worksheets[1].Rows[idx])
              else
                Excel.WorkSheets[1].Rows[idx + offs_table + 7].Copy(Excel.Worksheets[1].Rows[idx]);
            end;
          end;

          if FieldAsInteger('CURRENCY_NO') <> BYR then
          begin
            str := 'Курс ' + FloatToStr(FieldAsFloat('E_RATE')) + #10
                   + '(на дату '+ FieldAsString('INTRO_DATE') + ')' + #10
                   + '*'+FieldAsString('ST_SUMMPAY')+FieldAsString('CURRENCY') + #10
                   + '='+FloatToStr(RoundTo(FieldAsFloat('E_RATE') * FieldAsInteger('ST_SUMMPAY'), -2));
            Excel.WorkSheets[1].Cells[idx, 5] := str;
          end
          else
          begin
            s :=  FieldAsString('ST_SUMMPAY');
            str := '';
            l := length(s);
            for i := 0 to l - 1 do
            begin
              if (i <> 0) and ((i mod 3) = 0) then
                str := ' ' + str;
              str := s[l - i] + str;
            end;

            Excel.WorkSheets[1].Cells[idx, 5] := str;
          end;

          Excel.WorkSheets[1].Cells[idx, 4] := FieldAsString('ST_NUM');
          Excel.WorkSheets[1].Cells[idx, 6] := FieldAsString('DATEACT');
          Excel.WorkSheets[1].Cells[idx, 7] := FieldAsString('DATEPAY');
          Excel.WorkSheets[1].Cells[idx, 8] := FieldAsString('NUMPAY');

          if ((count_stages + 1) = FieldAsInteger('COUNT_TREATY_STAGE')) and
             (count_stages <> 0) then
          begin
            RowHeight := Excel.WorkSheets[1].Rows[idx - FieldAsInteger('COUNT_TREATY_STAGE') + 1].Height;

            Excel.WorkSheets[1].Range['A'+IntToStr(idx - FieldAsInteger('COUNT_TREATY_STAGE') + 1), 'A'+IntToStr(idx)].MergeCells := true;
            Excel.WorkSheets[1].Range['B'+IntToStr(idx - FieldAsInteger('COUNT_TREATY_STAGE') + 1), 'B'+IntToStr(idx)].MergeCells := true;
            Excel.WorkSheets[1].Range['C'+IntToStr(idx - FieldAsInteger('COUNT_TREATY_STAGE') + 1), 'C'+IntToStr(idx)].MergeCells := true;
            Excel.WorkSheets[1].Range['I'+IntToStr(idx - FieldAsInteger('COUNT_TREATY_STAGE') + 1), 'I'+IntToStr(idx)].MergeCells := true;
            Excel.WorkSheets[1].Range['J'+IntToStr(idx - FieldAsInteger('COUNT_TREATY_STAGE') + 1), 'J'+IntToStr(idx)].MergeCells := true;

            h := Excel.WorkSheets[1].Rows[idx - FieldAsInteger('COUNT_TREATY_STAGE') + 1].Height;
            if RowHeight >  h then
              for i:= 0 to  FieldAsInteger('COUNT_TREATY_STAGE') - 1 do
                Excel.WorkSheets[1].Rows[idx - i].RowHeight := RowHeight / FieldAsInteger('COUNT_TREATY_STAGE');
          end;

          next;
          inc(count_stages);
          inc(idx);
          buildingReport.Next;
        end;
      end;

      // Удалить не нужные строки
      Excel.Worksheets[1].Range['$'+IntToStr(idx) + ':$'+IntToStr(idx+count_delete_row)].Delete;
    end;

    // Сообщаем  окну buildingReport  о финише формирования отчета
    buildingReport.Finish;
  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;

    Screen.Cursor:= crDefault;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

procedure TfmMainMenu.PayClick(Sender: TObject);
const
  beg_table : integer = 6; // Начало шаблона таблицы
  beg_new_table : integer = 7; // Начало самой таблицы
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';
var
  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  v_date: TDate; // Дата отчета
  v_date_str : string; // Дата отчета в текстовом формате
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  month : integer;
  rep_year : string; // Год

  PickYear : TfmPickYear;
  AConcern_DOG : Integer;
  //ConcDateFrom, ConcDateTo : TDateTime;

  thread : TLRQThread;
  I : Integer;
  count_dog : Integer; // Количество договоров
begin
 {with TfmPickYear.Create(Self) do
 begin
  se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
  if ShowModal=mrOk then
  begin
   v_date_str := '01.01.'+ IntToStr(se_Year.Value);
   v_date := StrToDate(v_date_str);
   rep_year := IntToStr(se_Year.Value);
   Free;
  end
  else begin  Free; Exit; end;
 end;}

  v_date := 0;
  PickYear := TfmPickYear.Create(Self);
  PickYear.se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
  repeat
    if PickYear.ShowModal=mrOk then
    begin
      //year := PickYear.se_Year.Value;
      v_date_str := '01.01.' + IntToStr(PickYear.se_Year.Value);
      v_date := StrToDate(v_date_str);
      rep_year := IntToStr(PickYear.se_Year.Value);
    end
    else begin  PickYear.Free; Exit; end;

    AConcern_DOG := -1;

    if Sender = vpPayment_2 then
      AConcern_DOG := GetConcern_Treaty(IncMonth(v_date,11));

  until (Sender<>vpRN05) or (AConcern_DOG >= 0);
  PickYear.Free;

  // ФОРМА RN-05
  St:=ExtractFilePath(Application.ExeName) + 'report\payment_2.xlt';


  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);

 // Выбираем записи в Excel
 Screen.Cursor:=crHourGlass;
 // Создадим объект Excel.Application
 try
   Excel:=CreateOLEObject('Excel.Application');
 except
   Screen.Cursor:=crDefault;
   MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
              'Ошибка', mb_OK or mb_IconHand);
   Exit;
 end;
  try
   InvalidateRect(Handle, nil, True);
   UpdateWindow(Handle);
   // Добавим новую книгу
   try
    Excel.Workbooks.Add(St);
   except
     // Восстановим нормальный курсор
     Screen.Cursor:=crDefault;
     MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                'Ошибка', mb_OK or mb_IconHand);
     Exit;
   end;
   // Шапка отчета
   if Sender=vpPayment_2 then
   begin
     Excel.WorkSheets[1].Cells[2, 1] := 'ДОГОВОРЫ ФИНАНСИРУЕМЫЕ ИЗ СРЕДСТВ ИННОВАЦИОННОГО ФОНДА НА '
                                        + rep_year + ' ГОД';

     with TOracleQuery.Create(Self) do
     begin
       Session:= dmGlobal.seOracle;

       SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
       SQL.Append('  FROM RN.MITRCONCERN');
       SQL.Append(' WHERE  ID = :DOG_ID');

       DeclareVariable('DOG_ID', otInteger);
       SetVariable('DOG_ID', AConcern_DOG);

       Execute;

       Excel.WorkSheets[1].Cells[3, 1] := FieldAsString(0);

       Destroy;
     end;
   end;

   if Sender=vpRN06 then
    Excel.WorkSheets[1].Cells[2, 1] := 'ДОГОВОРЫ ФИНАНСИРУЕМЫЕ ИЗ ПРИБЫЛИ НА '
                                       + rep_year + ' ГОД';
   // Выполняем отчет
   with dmglobal.quPayment_2 do
   begin
    SetVariable('V_DATEFROM',v_date);
    SetVariable('V_DATETO',IncMonth(v_date,11));
    //ФОРМА RN-05
    if Sender=vpPayment_2 then
    begin
      SetVariable('V_ISTFIN_KOD',2); // Инновационный фонд

      SetVariable('CONC', AConcern_DOG);

      {if ConcDateFrom <> 0 then
        SetVariable('CONC_DATEFROM',ConcDateFrom)
      else
        SetVariable('CONC_DATEFROM',NULL);

      if ConcDateTo <> 0 then
        SetVariable('CONC_DATETO',ConcDateTo)
      else
        SetVariable('CONC_DATETO',NULL); }
    end;

    //ФОРМА RN-06
    if Sender=vpPayment_3 then
    begin
      SetVariable('V_ISTFIN_KOD',1); // Из прибыли
      {SetVariable('CONC_DATEFROM',NULL);
      SetVariable('CONC_DATETO',NULL);}
    end;

    Execute;

    count_dog := 0;
    // Устанавливаем пораметры для отображение процесса формирования отчета
    if not EOF then
    begin
      count_dog := FieldAsInteger('count_treaty');

      buildingReport.Caption := 'Формируется отчет';
      buildingReport.SetCaption('Идет процесс формирования отчета...');

      // Устанавливаем начальные значения в окне buildingReport
      buildingReport.reset;

      // Делаем в окне buildingReport видимым ProgressBar
      buildingReport.visibleProgressBar(true);

      // Сообщаем  окну buildingReport  о начала копирования данных
      buildingReport.Start;

      // Устанавливаем максиальное значение ProgressBar в окне
      buildingReport.SetMax(count_dog);
    end;

    idx:= beg_new_table; prev_id := -1;
    while not EOF do
    begin
     try
      // Проверяем тот же самый ли id [Field(0)]
      if Integer(Field(0)) <> prev_id then
      begin // Следующий договор
       Excel.Worksheets[1].Rows[idx].Insert;
       Excel.WorkSheets[1].Rows[beg_table].Copy(Excel.Worksheets[1].Rows[idx]);
       Excel.WorkSheets[1].Cells[idx, 1] := String(Field(1)); // номер договора
       Excel.WorkSheets[1].Cells[idx, 15] := String(Field(1)); // номер договора
       inc(idx);
      end;
      if Field(2) <> null then
      begin
       month := Field(2);
       Excel.WorkSheets[1].Cells[idx - 1, month + 1 ] := Double(Field(3)); // сумма
      end;
      prev_id := Integer(Field(0));
     except
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                 'Ошибка', mb_OK or mb_IconHand);
      Exit;
     end;
     Next;

     buildingReport.next;
    end;
    Excel.Worksheets[1].Rows[idx].Delete;
    Excel.Worksheets[1].Rows[beg_table].Delete;  // удаляем записи шаблонной таблицы
    Close;

    if count_dog > 0 then
    begin
      // Увеличеваем значение ProgressBar на еденицу в окне copingForm
      buildingReport.Next;

      // Сообщаем  окну buildingReport  о финише формирования отчета
      buildingReport.Finish;
    end;
   end;
 finally
   Screen.Cursor:=crDefault;
   Excel.Visible:=True;

   // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;
    //buildingReport.Destroy;

    Screen.Cursor:= crDefault;

    // Делаем доступным приложение, для пользователя
    resetBusy;
 end;
end;

end.
