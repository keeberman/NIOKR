unit v_longrunq;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vWorkForm, vDbASUP, Menus, Db, StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls,
  OracleData,execrep,v_anyform, ToolEdit, RXDBCtrl, Oracle;

const
  CJobForming= 'Выполняется задание';
  CJobBreak= 'Выполнение прервано';
  CJobComplete= 'Задание выполнено';
  CBeepLength= 5;
  SParamError= 'Ошибка при указании параметров.';
  SBreakJob= 'Вы уверены, что собираетесь прервать выполнение задания ?';
  SRunJob= 'Вы уверены, что собираетесь начать выполнение задания ?';
type

  TfmLongRunQuery = class(TfmWorkForm)
    laForming: TLabel;
    osLongQuery: TOracleSession;
    quJob: TOracleQuery;
    odDummy: TOracleDataSet;
    procedure FormCreate(Sender: TObject);// Обработчик ОnCreate формы
    procedure ButtonClick(Sender: TObject);
              { Обработчик нажатия кнопок панели paRightBottom.
                Выполняет запрос SQL }

    procedure FormDestroy(Sender: TObject);
              { Обработчик OnDestroy формы.
                Прекращает работу Report Builder RunTime}

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
              { Обработчик OnCloseQuery формы.
                Если форимрование отчета еще не завершено,
                требует подтвержедения}

    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure quJobThreadFinished(Sender: TOracleQuery);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure osLongQueryAfterLogOn(Sender: TOracleSession);
  private
    //Инфа о последнем запущенном процессе Report Builder RunTime
    FCancelClick: bool;
  protected
    procedure UMOTHERS(var Message:TMessage);message UM_OTHERS;
    procedure ChangeCtrlState(do_enabled: boolean);virtual;
    function SetVariables:bool;virtual;
  public
    function StyleToText(Message:TMessage) : string;override;
         //По режиму работы определяет заголовок формы
    procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;
  end;

var
  fmLongRunQuery: TfmLongRunQuery;

implementation
uses registry, globals, v_utils;

{$R *.DFM}

procedure TfmLongRunQuery.FormCreate(Sender: TObject);
begin
  inherited;
  AccessRights:= [];
  with dmGlobal.seOracle do
  begin
    osLongQuery.LogonUsername:= LogonUsername;
    osLongQuery.LogonPassword:= LogonPassword;
    osLongQuery.LogonDataBase:= LogonDataBase;
  end;
end;

procedure TfmLongRunQuery.ButtonClick(Sender: TObject);
var
  UserID: TUserID;
  UserParams: string;
begin
  if Sender= bbOk then
  begin
    if MessageDlg(SRunJob,mtConfirmation,[mbYes,mbNo],0)<>mrYes then
      Exit;
    bbOk.SetFocus; // Для срабатывания события OnExit у dePodr
    FCancelClick:= false;
    if not SetVariables then
    begin
      MessageDlg(SParamError,mtError,[mbOk],0);
      Exit;
    end;
    if not osLongQuery.Connected then
      osLongQuery.Connected:= true;
    quJob.Execute;
    ChangeCtrlState(False);
    laForming.Caption:= CJobForming;
    laForming.Visible:= true;
  end
  else
  begin
    if quJob.ThreadIsRunning then
    begin
      if MessageDlg(SBreakJob,mtConfirmation,[mbYes,mbNo],0)=mrYes then
      begin
        FCancelClick:= true;
        quJob.BreakThread;
      end;
    end
    else inherited;
  end;
end;

procedure TfmLongRunQuery.FormDestroy(Sender: TObject);
begin
  if quJob.ThreadIsRunning then quJob.BreakThread;
  inherited;
end;

procedure TfmLongRunQuery.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if quJob.ThreadIsRunning then
    if MessageDlg(SBreakJob,mtConfirmation,[mbYes,mbNo],0)=mrYes then
    begin
      FCancelClick:= true;
      quJob.BreakThread;
      CanClose:= not quJob.ThreadIsRunning;
      if not CanClose then
      begin
        laForming.Caption:= CJobForming;
        laForming.Visible:= true;
      end;
    end
    else CanClose:= false;
end;

procedure TfmLongRunQuery.FormActivate(Sender: TObject);
begin
  inherited;
  Perform(UM_OTHERS,IN_ACTIVATE,0);
end;

procedure TfmLongRunQuery.UMOTHERS(var Message:TMessage);
begin
  if Message.wParam= IN_QUIT then Close
  else inherited;
end;

procedure TfmLongRunQuery.UMChangeMode(var Message:TMessage);
var
  FormTitle: string;
begin
  FormTitle:= Caption;
  if not odDummy.ReadOnly then
    inherited;
  bbPrior.Visible:= false;
  bbNext.Visible:= false;
  Caption:= FormTitle;
end;

procedure TfmLongRunQuery.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (Key in [VK_UP,VK_DOWN]) then inherited;
end;

procedure TfmLongRunQuery.ChangeCtrlState(do_enabled: boolean);
begin
  bbOk.Enabled:= do_enabled;
  paMiddle.Enabled:= do_enabled;
  
  if not do_enabled then
  begin
    paMiddle.Cursor:= crSQLWait;
    paBottom.Cursor:= crSQLWait;
    Cursor:= crSQLWait;
    bbOk.Cursor:= crSQLWait;
  end
  else
  begin
    paMiddle.Cursor:= crDefault;
    paBottom.Cursor:= crDefault;
    Cursor:= crDefault;
    bbOk.Cursor:= crDefault;
  end;
end;

function TfmLongRunQuery.SetVariables: bool;
begin
  Result:= true;
end;

function TfmLongRunQuery.StyleToText(Message:TMessage) : string;
begin
  Result:= Caption;
end;

procedure TfmLongRunQuery.quJobThreadFinished(Sender: TOracleQuery);
var
  I: Integer;
begin
  if FCancelClick then
    laForming.Caption:= CJobBreak
  else
  begin
    laForming.Caption:= CJobComplete;
    for I:= 0 to CBeepLength do Beep;
  end;
  ChangeCtrlState(True);
end;

procedure TfmLongRunQuery.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  osLongQuery.Connected:= False;
end;

procedure TfmLongRunQuery.osLongQueryAfterLogOn(Sender: TOracleSession);
begin
  NonDefaultRolesActivate(Sender,SubSystemCode)
end;

end.
