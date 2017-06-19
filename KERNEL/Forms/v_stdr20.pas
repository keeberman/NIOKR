unit v_stdr20;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_stdfrep, vDbASUP, Db, FR_DSet, FR_DBSet, FR_Class, ExtCtrls, FR_E_TXT;

type
  TfmStdFRep20 = class(TfmStdFRep)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmStdFRep20: TfmStdFRep20;

implementation

{$R *.DFM}
initialization
  RegisterClass(TfmStdFRep20);

finalization
  UnregisterClass(TfmStdFRep20);
end.
