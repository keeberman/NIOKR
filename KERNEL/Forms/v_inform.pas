unit v_inform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData;

type
  TdmInform = class(TDataModule)
    odInform: TOracleDataSet;
    odInformID: TFloatField;
    odInformSUBJ: TStringField;
    odInformD_CREATE: TDateTimeField;
    odInformTEXT: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmInform: TdmInform;

implementation

{$R *.DFM}
uses globals;
end.
