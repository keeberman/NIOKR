unit v_rmasdet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_stdr20, vDbASUP, Db, FR_DSet, FR_DBSet, FR_Class, ExtCtrls, FR_E_TXT;

type
  TfmMasterDetailRep = class(TfmStdFRep20)
    frDBDataSet1: TfrDBDataSet;
    dsReport1: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMasterDetailRep: TfmMasterDetailRep;

implementation

{$R *.DFM}

end.
