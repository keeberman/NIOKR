unit v_splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Animate, GIFCtrl;

type
  TfmSplash = class(TForm)
    RxGIFAnimator: TRxGIFAnimator;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSplash: TfmSplash;

implementation

{$R *.DFM}

procedure TfmSplash.FormShow(Sender: TObject);
begin
  RxGIFAnimator.Animate:= True;
end;

procedure TfmSplash.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

end.
