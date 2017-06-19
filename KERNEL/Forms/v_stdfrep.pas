unit v_stdfrep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyfrep, vDbASUP, Db, ExtCtrls, frxExportText, frxExportXLS, frxClass,
  frxExportPDF, frxDBSet;

type
  TfmStdFRep = class(TfmAnyFRep)
    ID: TVEditFormID;
    procedure frReportBeginDoc;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmStdFRep: TfmStdFRep;

implementation

{$R *.DFM}

procedure TfmStdFRep.frReportBeginDoc;
var
  CodeField: TField;
begin
  inherited;
  CodeField:= dsReport.DataSet.FindField('KOD');
  if Assigned(CodeField) then
//    TFrMemoView(frReport.Pages[0].FindObject('Memo8')).FormatStr:=
//      TNumericField(CodeField).DisplayFormat;
end;

initialization
  RegisterClass(TfmStdFRep);

finalization
  UnregisterClass(TfmStdFRep);
end.
