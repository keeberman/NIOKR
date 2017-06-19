unit v_anyrep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyform, ExtCtrls, ppVar, ppPrnabl, ppClass, ppCtrls, ppBands, ppCache,
  ppComm, ppRelatv, ppProd, ppReport, Db, ppDB, ppDBPipe, vdbASUP;

type
  TfmAnyRep = class(TfmAnyForm)
    ppReport: TppReport;
    ppHeaderBand: TppHeaderBand;
    ppDetailBand: TppDetailBand;
    ppSystemVariable2: TppSystemVariable;
    ppLabel2: TppLabel;
    ppDBPipeline: TppDBPipeline;
    dsReport: TDataSource;
    ID: TVEditFormID;
    ppTitleBand1: TppTitleBand;
    ppReportTitle: TppLabel;
    pplaCriteria: TppLabel;
    ppLabel1: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    pplaID: TppLabel;
    procedure ppReportBeforePrint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  
  TReportRef=class of TfmAnyRep;

var
  fmAnyRep: TfmAnyRep;

implementation

{$R *.DFM}

procedure TfmAnyRep.ppReportBeforePrint(Sender: TObject);
begin
  if (ppDBPipeline.DataSource.DataSet is TVASUPQuery)
     and (Length(ppReportTitle.Caption)>0) then
  begin
    ppReportTitle.Caption:=
      TVASUPQuery(ppDBPipeline.DataSource.DataSet).Caption;
    ppReport.PrinterSetup.DocumentName:=
      TVASUPQuery(ppDBPipeline.DataSource.DataSet).Caption;
  end;
end;

end.
