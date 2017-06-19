unit v_ENOfTabShDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXCtrls, Buttons;

type
  TENOfTabShDlg = class(TForm)
    lbTabSheets: TTextListBox;
    Label1: TLabel;
    btSel: TButton;
    btAllSel: TButton;
    btUnSel: TButton;
    btAllUnSel: TButton;
    lbSelTabSheets: TTextListBox;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure btSelClick(Sender: TObject);
    procedure btAllSelClick(Sender: TObject);
    procedure btUnSelClick(Sender: TObject);
    procedure btAllUnSelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

procedure TENOfTabShDlg.btSelClick(Sender: TObject);
var
  I : Integer;
begin
  for I := lbTabSheets.Items.Count - 1 downto 0 do
    if lbTabSheets.Selected[I] then
    begin
      lbSelTabSheets.Items.Add(lbTabSheets.Items[I]);
      lbTabSheets.Items.Delete(I);
    end;
end;

procedure TENOfTabShDlg.btAllSelClick(Sender: TObject);
var
  I : Integer;
begin
  for I := lbTabSheets.Items.Count - 1 downto 0 do
  begin
    lbSelTabSheets.Items.Add(lbTabSheets.Items[I]);
    lbTabSheets.Items.Delete(I);
  end;
end;

procedure TENOfTabShDlg.btUnSelClick(Sender: TObject);
var
  I : Integer;
begin
  for I := lbSelTabSheets.Items.Count - 1 downto 0 do
    if lbSelTabSheets.Selected[I] then
    begin
      lbTabSheets.Items.Add(lbSelTabSheets.Items[I]);
      lbSelTabSheets.Items.Delete(I);
    end;
end;

procedure TENOfTabShDlg.btAllUnSelClick(Sender: TObject);
var
  I : Integer;
begin
  for I := lbSelTabSheets.Items.Count - 1 downto 0 do
  begin
    lbTabSheets.Items.Add(lbSelTabSheets.Items[I]);
    lbSelTabSheets.Items.Delete(I);
  end;
end;

end.
