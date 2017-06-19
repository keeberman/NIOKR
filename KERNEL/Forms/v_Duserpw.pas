unit v_duserpw;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Mask;

type
  TfmUserPassword = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    laPassword: TLabel;
    laConfirm: TLabel;
    meOrigin: TMaskEdit;
    meConfirm: TMaskEdit;
    procedure MaskKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmUserPassword: TfmUserPassword;

implementation
uses Dialogs;
{$R *.DFM}

procedure TfmUserPassword.MaskKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not ( (Key in ['A'..'Z','a'..'z','0'..'9'])
   or (ord(Key) in [vk_Back,vk_Tab,vk_Prior,vk_Next]) ) then
  begin
    Key:= #00;
    Beep;
  end;
end;

procedure TfmUserPassword.OKBtnClick(Sender: TObject);
begin
  if meOrigin.Text<>meConfirm.Text then
  begin
    MessageDlg( 'Введенные оригинал и подтверждение пароля не совпадают. Повторите ввод'
                ,mtError,[mbOk],0);
    meOrigin.Text:= '';
    meConfirm.Text:= '';
    meOrigin.SetFocus;
  end
  else if Length(Trim(meOrigin.Text))=0 then
  begin
    MessageDlg( 'Пароль не определен. Повторите ввод'
               ,mtError,[mbOk],0);
    meOrigin.SetFocus;
  end
  else ModalResult:= mrOk;
end;

end.
