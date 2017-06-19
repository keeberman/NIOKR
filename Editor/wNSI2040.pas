unit wNSI2040;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_Nsiform, vDbASUP, Menus, Db, StdCtrls, Buttons, Mask, ExtCtrls;

type
  TfmNSI2040 = class(TfmNSI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmNSI2040: TfmNSI2040;

implementation

{$R *.DFM}

initialization
  RegisterClass(TfmNSI2040);

finalization
  UnregisterClass(TfmNSI2040);
end.
