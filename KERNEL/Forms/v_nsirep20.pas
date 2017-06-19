unit v_nsirep20;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_NsiRep, vDbASUP, Db, Qrctrls, quickrpt, ExtCtrls;

type
  TfrNSI20 = class(TfrNSIReport)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frNSI20: TfrNSI20;

implementation

{$R *.DFM}

initialization
  RegisterClass(TfrNSI20);

finalization
  UnregisterClass(TfrNSI20);
end.
