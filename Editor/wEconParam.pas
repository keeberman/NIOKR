unit wEconParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vworkform, vDbASUP, StdCtrls, Mask, Menus, Db, Buttons, ExtCtrls;

type
  TfmEconomicParameter = class(TfmWorkForm)
    deCode: TVDBEditChar;
    Label1: TLabel;
    deName: TVDBERus;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEconomicParameter: TfmEconomicParameter;

implementation

{$R *.DFM}

initialization
  RegisterClass(TfmEconomicParameter);

finalization
  UnregisterClass(TfmEconomicParameter);

end.
