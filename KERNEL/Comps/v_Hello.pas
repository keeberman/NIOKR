unit v_Hello;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfmTalk = class(TForm)
    stMsg: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    constructor CreateWithText(AOwner: TComponent;UserMsg: string);
    { Public declarations }
  end;

var
  fmTalk: TfmTalk;

implementation

{$R *.DFM}

constructor TfmTalk.CreateWithText;
begin
  Create(AOwner);
  stMsg.Caption:= UserMsg;
end;

procedure TfmTalk.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:= caFree;
end;

end.
