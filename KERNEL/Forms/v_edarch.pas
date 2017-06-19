unit v_edarch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_explorer, Placemnt, Db, vDbASUP, Grids, DBGrids, RXDBCtrl, ExtCtrls;

type
  TfmExpArchive = class(TfmExplorer)
    procedure DBGridGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmExpArchive: TfmExpArchive;

implementation

{$R *.DFM}

procedure TfmExpArchive.DBGridGetCellParams(Sender: TObject; Field: TField;
  AFont: TFont; var Background: TColor; Highlight: Boolean);
begin
  if not Highlight and
     not dsWork.DataSet.FieldByName('DATAVIVOD').IsNull then
      AFont.Color := clRed;
end;

end.
