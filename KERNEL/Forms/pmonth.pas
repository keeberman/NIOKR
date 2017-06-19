unit pmonth;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, ExtCtrls;

type
  TfmPickMonth = class(TForm)
    bbCancel: TBitBtn;
    bbOk: TBitBtn;
    Panel1: TPanel;
    se_Year: TSpinEdit;
    cbMonth: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPickMonth: TfmPickMonth;

implementation

{$R *.DFM}


procedure TfmPickMonth.FormCreate(Sender: TObject);
begin
  if StrToInt(FormatDateTime('m',Date)) - 1 = 0 then
  // Предыдуций месяц был ДЕКАБРЬ
  begin
   //ДЕКАБРЬ
   cbMonth.ItemIndex := 11;
   // Предыдущий год от текуцего
   se_Year.Value := StrToInt(FormatDateTime('yyyy',Date))-1;
  end
  else
  // Для остальных месяцев
  begin
   cbMonth.ItemIndex := StrToInt(FormatDateTime('m',Date))-2;
   se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
  end;
end;

end.
