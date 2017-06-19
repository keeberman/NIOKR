unit v_anyfrep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyform, Db, ExtCtrls,
  frxExportText, frxExportXLS, frxClass, frxExportPDF, frxDBSet;

type
  TfmAnyFRep = class(TfmAnyForm)
    dsReport: TDataSource;
    frxReport: TfrxReport;
    frxDBDataset: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxXLSExport1: TfrxXLSExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    procedure frReportBeginDoc;
    procedure frReportEndDoc;
  private
    { Private declarations }
    FBookMark: TBookMarkStr;
  public
    { Public declarations }
  end;

var
  fmAnyFRep: TfmAnyFRep;

implementation
uses vdbASUP, oracledata;
{$R *.DFM}

procedure TfmAnyFRep.frReportBeginDoc;
begin
 FBookMark:= dsReport.DataSet.BookMark;
 if dsReport.DataSet is TOracleDataSet then
   TOracleDataSet(dsReport.DataSet).ForceMasterSynchronization:= true;
 dsReport.DataSet.DisableControls;
end;

procedure TfmAnyFRep.frReportEndDoc;
begin
  dsReport.DataSet.BookMark:= FBookMark;
  if dsReport.DataSet is TOracleDataSet then
   TOracleDataSet(dsReport.DataSet).ForceMasterSynchronization:= false;
  dsReport.DataSet.EnableControls;
end;

end.
