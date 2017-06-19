unit v_pquarter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, ExtCtrls;

type
  TfmPickQuarter = class(TForm)
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
  fmPickQuarter: TfmPickQuarter;

implementation

{$R *.DFM}

procedure TfmPickQuarter.FormCreate(Sender: TObject);
begin
  if StrToInt(FormatDateTime('m',Date)) div 3 = 0 then
  // ���������� ������� ��� 4-�
  begin
   //�������
   cbMonth.ItemIndex := 3;
   // ���������� ��� �� ��������
   se_Year.Value := StrToInt(FormatDateTime('yyyy',Date))-1;
  end
  else
  // ��� ��������� �������
  begin
   cbMonth.ItemIndex := (StrToInt(FormatDateTime('m',Date)) div 3) - 1;
   se_Year.Value := StrToInt(FormatDateTime('yyyy',Date));
  end;
end;

end.
