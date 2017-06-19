unit pmonthwithaddCol;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  pmonth, StdCtrls, Spin, ExtCtrls, Buttons;

type
  TfmPickMonthWithAddColumn = class(TfmPickMonth)
    cbAddColum: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }

    function withAddCol : boolean;
  end;

var
  fmPickMonthWithAddColumn: TfmPickMonthWithAddColumn;

implementation

{$R *.DFM}

function TfmPickMonthWithAddColumn.withAddCol : boolean;
begin
  Result := cbAddColum.Checked;
end;

end.
