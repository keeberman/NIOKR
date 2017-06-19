unit pmonth_from_to;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, ExtCtrls;

type
  TfmPickMonth_From_To = class(TForm)
    bbCancel: TBitBtn;
    bbOk: TBitBtn;
    Panel1: TPanel;
    se_FromYear: TSpinEdit;
    cbFromMonth: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    se_ToYear: TSpinEdit;
    cbToMonth: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPickMonth_From_To: TfmPickMonth_From_To;

implementation

{$R *.DFM}


procedure TfmPickMonth_From_To.FormCreate(Sender: TObject);
begin
  case StrToInt(FormatDateTime('m',Date)) of
    0, 1, 2: begin
               cbFromMonth.ItemIndex := 9;
               se_FromYear.Value := StrToInt(FormatDateTime('yyyy',Date))-1;

               cbToMonth.ItemIndex := 11;
               se_ToYear.Value := StrToInt(FormatDateTime('yyyy',Date))-1;
             end;
    3, 4, 5: begin
               cbFromMonth.ItemIndex := 0;
               se_FromYear.Value := StrToInt(FormatDateTime('yyyy',Date));

               cbToMonth.ItemIndex := 2;
               se_ToYear.Value := StrToInt(FormatDateTime('yyyy',Date));
             end;
    6, 7, 8: begin
               cbFromMonth.ItemIndex := 3;
               se_FromYear.Value := StrToInt(FormatDateTime('yyyy',Date));

               cbToMonth.ItemIndex := 5;
               se_ToYear.Value := StrToInt(FormatDateTime('yyyy',Date));
             end;
    9, 10, 11: begin
               cbFromMonth.ItemIndex := 6;
               se_FromYear.Value := StrToInt(FormatDateTime('yyyy',Date));

               cbToMonth.ItemIndex := 8;
               se_ToYear.Value := StrToInt(FormatDateTime('yyyy',Date));
             end;
  end;

  //if

  {if StrToInt(FormatDateTime('m',Date)) - 1 = 0 then
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
  end;}
end;

end.
