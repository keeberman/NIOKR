unit wpaymeth;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vworkform, vDbASUP, Menus, Db, StdCtrls, Buttons, ExtCtrls, Mask;

type
  TfmPayMethods = class(TfmWorkForm)
    Label1: TLabel;
    deCode: TVDBEditChar;
    deFull: TVDBERus;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPayMethods: TfmPayMethods;

implementation

{$R *.DFM}

initialization
  RegisterClass(TfmPayMethods);

finalization
  UnregisterClass(TfmPayMethods);

end.
