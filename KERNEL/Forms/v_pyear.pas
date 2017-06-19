unit v_pyear;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin, ExtCtrls;

type
  TfmPickYear = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    se_Year: TSpinEdit;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPickYear: TfmPickYear;

implementation

{$R *.DFM}

procedure TfmPickYear.FormCreate(Sender: TObject);
begin
 se_Year.Value := StrToInt(FormatDateTime('yyyy',Date))-1;
end;

end.
