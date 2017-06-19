unit v_pyears;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Spin;

type
  TfmPickFromYearToYear = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    se_FromYear: TSpinEdit;
    Label1: TLabel;
    se_ToYear: TSpinEdit;
    Label3: TLabel;
    Shape1: TShape;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure se_FromYearChange(Sender: TObject);
    procedure se_ToYearChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPickFromYearToYear: TfmPickFromYearToYear;

implementation

{$R *.DFM}

procedure TfmPickFromYearToYear.FormCreate(Sender: TObject);
begin
  se_FromYear.Value := StrToInt(FormatDateTime('yyyy',Date))-1;
  se_ToYear.Value   := StrToInt(FormatDateTime('yyyy',Date));
end;

procedure TfmPickFromYearToYear.se_FromYearChange(Sender: TObject);
begin
  se_ToYear.MinValue := se_FromYear.Value;
end;

procedure TfmPickFromYearToYear.se_ToYearChange(Sender: TObject);
begin
    se_FromYear.MaxValue := se_ToYear.Value;
end;

end.
