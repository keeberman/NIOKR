unit v_fastmod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, frxClass, frxDBSet, frxExportPDF, frxExportRTF;

type
  TdmFastReport = class(TDataModule)
    quFields: TOracleQuery;
    quTables: TOracleQuery;
    quNewTables: TOracleQuery;
    quNewFields: TOracleQuery;
    quRpt: TOracleDataSet;
    quRptID: TFloatField;
    quRptNAME: TStringField;
    quRptUSERNAME: TStringField;
    quRptREPDATE: TDateTimeField;
    quClear1: TOracleQuery;
    quClear2: TOracleQuery;
    frxLetterRTF: TfrxRTFExport;
    frxLetterPDF: TfrxPDFExport;
    frxLetter: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    procedure frxLetterPreview(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmFastReport: TdmFastReport;

implementation
uses globals;
{$R *.DFM}

procedure TdmFastReport.DataModuleCreate(Sender: TObject);
begin
  with quRpt do
  begin
    SetVariable('ADMIN',AdminRoleCode);
    SetVariable('APPSYS',SubSystemCode);
  end;
end;

procedure TdmFastReport.frxLetterPreview(Sender: TObject);
begin
  frxLetter.Variables['vsummpay'] := 17500;
end;

end.
