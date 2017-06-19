unit about;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_aboutb, StdCtrls, ExtCtrls;

type
  TfmAboutBox = class(TfmAboutBoxBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAboutBox: TfmAboutBox;

implementation

{$R *.DFM}

end.
