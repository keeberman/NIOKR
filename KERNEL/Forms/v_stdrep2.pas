unit v_stdrep2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyrep, vDbASUP, Db, ppDB, ppDBPipe, ppBands, ppVar, ppPrnabl, ppClass,
  ppCtrls, ppCache, ppComm, ppRelatv, ppProd, ppReport, ExtCtrls, ppModule,
  raCodMod, ppStrtch, ppMemo;

type
  TfmStandardRep2 = class(TfmAnyRep)
    ppteCode: TppDBText;
    ppteName1: TppDBText;
    pplaCode: TppLabel;
    pplaName1: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    raCodeModule1: TraCodeModule;
    ppSummaryBand1: TppSummaryBand;
    ppLabel6: TppLabel;
    ppVarCount: TppVariable;
    ppCountLine: TppLine;
    ppmeName2: TppDBMemo;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppColumnFooterBand1: TppColumnFooterBand;
    procedure ppvarCountCalc(Sender: TObject; var Value: Variant);
    procedure ppReportBeforePrint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmStandardRep2: TfmStandardRep2;

implementation
uses globals;
{$R *.DFM}

procedure TfmStandardRep2.ppvarCountCalc(Sender: TObject;
  var Value: Variant);
begin
  Value:= Value + 1;
end;

procedure TfmStandardRep2.ppReportBeforePrint(Sender: TObject);
begin
  inherited;
  ppvarCount.Value:= 0;
  ppteCode.DisplayFormat:=
    TNumericField(dsReport.DataSet.FieldByName(ppteCode.DataField)).DisplayFormat
end;

initialization
  RegisterClass(TfmStandardRep2);

finalization
  UnregisterClass(TfmStandardRep2);
end.
