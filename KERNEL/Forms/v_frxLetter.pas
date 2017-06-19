unit v_frxLetter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxClass, frxDBSet, Db, StdCtrls, frxExportImage, frxExportText,
  frxExportXLS, frxExportPDF;

type
  TfrmPrintFrxLetter = class(TForm)
    dsFrxLetter: TDataSource;
    frxLetter1: TfrxReport;
    frxDBDataset: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxXLSExport1: TfrxXLSExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxJPEGExport1: TfrxJPEGExport;
    gbKurators: TGroupBox;
    cbEx2: TCheckBox;
    lbEx2: TLabel;
    ebEx2: TEdit;
    cbEx3: TCheckBox;
    lbEx3: TLabel;
    ebEx3: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure cbEx2Click(Sender: TObject);
    procedure cbEx3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrintFrxLetter: TfrmPrintFrxLetter;

implementation

{$R *.DFM}

procedure TfrmPrintFrxLetter.cbEx2Click(Sender: TObject);
begin
  If cbEx2.Checked = True Then
  begin
    lbEx2.Enabled := True;
    ebEx2.Enabled := True;
  end
  Else
  begin
    lbEx2.Enabled := False;
    ebEx2.Enabled := False;
  end;
end;

procedure TfrmPrintFrxLetter.cbEx3Click(Sender: TObject);
begin
  If cbEx3.Checked = True Then
  begin
    lbEx3.Enabled := True;
    ebEx3.Enabled := True;
  end
  Else
  begin
    lbEx3.Enabled := False;
    ebEx3.Enabled := False;
  end;
end;

end.
