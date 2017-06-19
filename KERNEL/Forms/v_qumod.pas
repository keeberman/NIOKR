unit v_qumod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData;

type
  TdmRptQuery = class(TDataModule)
    quAllTables: TOracleQuery;
    quMajors: TOracleDataSet;
    quMajorsDRAFT_REP_ID: TFloatField;
    quMajorsTABLE_NAME: TStringField;
    quMajorsFIELD_NAME: TStringField;
    quMajorsCONDITION: TIntegerField;
    quMajorsVALUE: TStringField;
    quMajorsRESTYPE: TIntegerField;
    quMajorsRESERVED: TBlobField;
    quMinors: TOracleQuery;
    quMajorsDESCRIPTION: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmRptQuery: TdmRptQuery;

implementation
uses globals;
{$R *.DFM}

end.
