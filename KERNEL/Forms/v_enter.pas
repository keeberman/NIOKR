unit v_enter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyform, StdCtrls, Buttons, Mask, ExtCtrls,DB,DBTables,vdbASUP,
  Oracle,registry, ToolEdit;

const
  MaxErrors=3;
  CExpireText= 'Достигнут предел ошибок при соединении с базой данных.'+#13+#10+'Приложение вынуждено прекратить работу.';
  BadPassword= 'Неверен пароль/имя пользователя.';
  BaseKey= 'DataBaseLogOn';
  NoPassword= 'Задан пустой пароль, вход в систему запрещен.';
  CSaveInList= 'Сохранить имя пользователя в выпадающем списке ?';
type
  TfmEnter = class(TfmAnyForm)
  {Диалог подключения к базе данных. Количество попыток
  подключений ограничено MaxErrors.При успешном подключении
  имя пользователя сохраняется в системном реестре}
    Label1: TLabel;
    Label2: TLabel;
    edPassword: TMaskEdit;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    laDataBase: TLabel;
    laBaseName: TLabel;
    edUser: TComboBox;
    procedure bbOkClick(Sender: TObject);
              {Обработчик события OnClick кнопки bbOk.
              Производит соединение с базой данных указанной в OraSession}

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
              {Обработчик события OnClose формы.
              Удаляет форму после ее закрытия}

    procedure FormCreate(Sender: TObject);
              //Обработчик события OnCreate формы

    procedure FormShow(Sender: TObject);
    procedure laBaseNameClick(Sender: TObject);
              {Обработчик события OnShow формы. Присваивает
              имени пользователя значение предыдущего успешного соединения,
              сохраненное в системном реестре}
  private
     ErCount: Integer;
     procedure SaveLogonResults;
    { Private declarations }
  public
    OraSession: TOracleSession;
    { Public declarations }
  end;

  procedure InitPath;
var
  fmEnter: TfmEnter;
  RegFile: TRegIniFile;
  Reg_User,Reg_Base: string;

implementation

uses MENUGnrl,globals,ExecRep,ExecWord;
{$R *.DFM}

procedure InitPath;
begin
  with TRegIniFile.Create(SubSection) do
  begin
    ReportPath:= ReadString('Reports','Data',ExtractFilePath(Application.ExeName));
    TemplatesPath:= ReadString('Reports','WordTemplatesPath',ExtractFilePath(Application.ExeName));
    Free;
  end;
end;

procedure TfmEnter.SaveLogonResults;
var
  I: Integer;
begin
  RegFile:= TRegIniFile.Create(SubSection);
  with RegFile do
  begin
    WriteString(BaseKey,'USER_NAME',edUser.Text);
    WriteString(BaseKey,'SERVER_NAME',laBaseName.Caption);
    if (edUser.Items.IndexOf(AnsiUpperCase(edUser.Text))<0)
      and ( (edUser.Items.Count=0) or
            (MessageDlg(CSaveInList,mtConfirmation,[mbYes,mbNo],0)=mrYes)) then
       WriteString(BaseKey,Format('USER_ITEM%d',[edUser.Items.Count]),
         AnsiUpperCase(edUser.Text));
    Free;
  end;
end;

procedure TfmEnter.bbOkClick(Sender: TObject);

procedure SayGoodBuy;
begin
  MessageDlg(CExpireText,mtInformation,[mbOk],0);
  ModalResult:= mrCancel;
end;

begin
  with OraSession do
  begin
    LogonDataBase:= laBaseName.Caption;
    LogonUserName:=UpperCase(edUser.Text);
    LogonPassword:= UpperCase(edPassWord.Text);
    if Length(LogonPassword)=0 then
    begin
      MessageDlg(NoPassword,mtError,[mbOk],0);
      edPassword.SetFocus;
      Exit;
    end;
    try
      Screen.Cursor:= crHourGlass;
      Connected:= true;
      if Connected then
      begin
         ModalResult:= mrOk;
         Screen.Cursor:= crDefault;
         UserName:= LogonUserName;
         SaveLogonResults;
      end else
         ModalResult:= mrNo;
    except
      on E:EOracleError do
      case E.ErrorCode of
        1017:
        begin
          Screen.Cursor:= crDefault;
          MessageBeep(0);
          edPassword.SelectAll;
          edPassword.SetFocus;
          Inc(ErCount);
          if ErCount=MaxErrors then SayGoodBuy
          else MessageDlg(BadPassword,mtError,[mbOk],0);
        end;
        else
        begin
          Screen.Cursor:= crDefault;
          raise;
        end;
      end;
    end;
  end;
end;

procedure TfmEnter.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  InitPath;
  Action:= caFree;
end;

procedure TfmEnter.FormCreate(Sender: TObject);
begin
  inherited;
  ErCount:= 0;
end;

procedure TfmEnter.FormShow(Sender: TObject);
var
  I: Integer;
  UserItem: string;
begin
  RegFile:= TRegIniFile.Create(SubSection);
  with RegFile do
  begin
    laBaseName.Caption:= ReadString(BaseKey,'SERVER_NAME',DefaultDataBase);
    edUser.Text:= ReadString(BaseKey,'USER_NAME',DefaultUserName);
    I:= 0;
    repeat
      UserItem:= ReadString(BaseKey,Format('USER_ITEM%d',[I]),'');
      if Length(UserItem)>0 then edUser.Items.Add(UserItem);
      Inc(I);
    until Length(UserItem)=0;
    Free;
  end;
  edPassword.SetFocus;
end;



procedure TfmEnter.laBaseNameClick(Sender: TObject);
var s: string;
begin
    s := laBaseName.Caption;
    if InputQuery('База данных', '', s) then
      laBaseName.Caption := s;

end;

end.
