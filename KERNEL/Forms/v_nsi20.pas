unit v_nsi20;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_Nsiform, vDbASUP, Menus, Db, StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls;

type
  TfmNSI20 = class(TfmNSI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmNSI20: TfmNSI20;

implementation

{$R *.DFM}

initialization
  RegisterClass(TfmNSI20);

finalization
  UnregisterClass(TfmNSI20);
end.
