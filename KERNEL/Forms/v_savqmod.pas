unit v_savqmod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData;

type
  TdmSaveRptQuery = class(TDataModule)
    osRptQuery: TOracleDataSet;
    osRptQueryNAME: TStringField;
    osRptQueryREPDATE: TDateTimeField;
    osRptQueryCOMMENTS: TStringField;
    osRptQueryUSERNAME: TStringField;
    osRptQueryID: TFloatField;
    quNewMajors: TOracleQuery;
    quNewMinors: TOracleQuery;
    quCurRpt: TOracleQuery;
    quClear1: TOracleQuery;
    osRptQueryMIPODSIS_KOD: TIntegerField;
    quClear2: TOracleQuery;
    osRptQueryWINCLASS: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure osRptQueryBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmSaveRptQuery: TdmSaveRptQuery;

implementation
uses globals;
{$R *.DFM}

procedure TdmSaveRptQuery.DataModuleCreate(Sender: TObject);
begin
  with osRptQuery do
  begin
    SetVariable('ADMIN',AdminRoleCode);
    SetVariable('APPSYS',SubSystemCode);
  end;
end;

procedure TdmSaveRptQuery.osRptQueryBeforePost(DataSet: TDataSet);
begin
  if osRptQueryMIPODSIS_KOD.IsNull then
     osRptQueryMIPODSIS_KOD.Value:= osRptQuery.GetVariable('APPSYS');
end;

end.
