unit v_gridform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_EDITFORM, Grids, DBGrids, Buttons, DBCtrls, StdCtrls, ExtCtrls, vDbASUP,
  RXDBCtrl;

type
  TfmGridForm = class(TfmEditForm)
    DBGrid: TRxDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmGridForm: TfmGridForm;

implementation

{$R *.DFM}

end.
