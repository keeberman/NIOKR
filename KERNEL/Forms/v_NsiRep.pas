unit v_NsiRep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyreprt, Qrctrls, quickrpt, ExtCtrls, Db,vDbASUP;

type
  TfrNSIReport = class(TfrAnyReport)
               {Форма-контейнер отчета по стандартным справочникам:
               KOD,SNAIM,PNAIM}
    qlKod: TQRLabel;
    qlShort1: TQRLabel;
    qlShort2: TQRLabel;
    qlFull1: TQRLabel;
    qlFull2: TQRLabel;
    qtCode: TQRDBText;
    qtShort: TQRDBText;
    qtFull: TQRDBText;
    qlCountCap: TQRLabel;
    qlCount: TQRLabel;
    procedure qrMainBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
      //Обработчик события BeforePrint компонента qrMain

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frNSIReport: TfrNSIReport;

implementation
uses OracleData;
{$R *.DFM}

procedure TfrNSIReport.qrMainBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  I:Integer;
begin
  inherited;
  for I:= 0 to ComponentCount-1 do
    if Components[I] is TQRDBText and (TQRDBText(Components[I]).Parent=Detail) and 
    not Assigned(TQRDBText(Components[I]).DataSet) then
      TQRDBText(Components[I]).DataSet:= qrMain.DataSet;
  if (qrMain.DataSet as TOracleDataSet).QueryAllRecords then
    qlCount.Caption:= InttoStr(qrMain.DataSet.RecordCount)
  else qlCount.Caption:= InttoStr((qrMain.DataSet as TVASUPQuery).SQLRecordCount);
  if qrMain.DataSet is TVASUPQuery then
    qlReportTitle.Caption:= (qrMain.DataSet as TVASUPQuery).Caption;
end;

initialization
  RegisterClass(TfrNSIReport);

finalization
  UnregisterClass(TfrNSIReport);
end.
