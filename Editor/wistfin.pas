unit wistfin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_Nsiform, vDbASUP, Menus, Db, StdCtrls, Buttons, Mask, ExtCtrls;

type
  TfmMiIstFin = class(TfmNSI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMiIstFin: TfmMiIstFin;

implementation

{$R *.DFM}

initialization
  RegisterClass(TfmMiIstFin);

finalization
  UnregisterClass(TfmMiIstFin);

end.
