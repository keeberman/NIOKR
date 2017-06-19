unit PickConcernDog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfmPickConcernDog = class(TForm)
    cbDog: TComboBox;
    lblConcDog: TLabel;
    bbOK: TBitBtn;
  private
    { Private declarations }
  public
    // ��������� ������� � ������ �������� ���������
    // AName - ������������ ��������
    // ADOG_ID - ������������� ��������
    procedure AddDog(AName : String);

    // ���������� ������������� ��������� ��������
    // ���� ������� �� ������, �� ���������� �������� -1
    function GetSelDog : Integer;
    { Public declarations }
  end;

var
  fmPickConcernDog: TfmPickConcernDog;

implementation

{$R *.DFM}

procedure TfmPickConcernDog.AddDog(AName : String);
begin
  cbDog.Items.Add(AName);
  cbDog.ItemIndex := 0;
end;

function TfmPickConcernDog.GetSelDog : Integer;
begin
  Result := cbDog.ItemIndex;
end;

end.
