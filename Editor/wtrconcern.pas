unit wtrconcern;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vwtree, ExtCtrls, ImgList, vDbASUP, Menus, Db, StdCtrls, Buttons, TB97,
  TB97Tlbr, ComCtrls, Grids, DBGrids, RXDBCtrl, Mask, v_anyform, DBCtrls;

type
  TfmTRConcern = class(TfmTreeTopology)
    odsMitrConcern: TDataSource;
    tsDogConcern: TTabSheet;
    pTopDog: TPanel;
    tsAgrConcern: TTabSheet;
    odsMitrconc_agr: TDataSource;
    deNumDog: TVDBEMath;
    Label1: TLabel;
    deDateSign: TVDBEDate;
    deDateFrom: TVDBEDate;
    deDateTo: TVDBEDate;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pTopAgr: TPanel;
    deNumAgr: TVDBEMath;
    Label5: TLabel;
    deDateSignAgr: TVDBEDate;
    Label6: TLabel;
    deDateFromAgr: TVDBEDate;
    deDateToAgr: TVDBEDate;
    Label7: TLabel;
    Label8: TLabel;
    lblDogName: TLabel;
    deDogName: TVDBERus;
    lblAgrName: TLabel;
    deAgrName: TVDBERus;
    cbBegInterval: TDBCheckBox;
    deWork_DateFrom: TVDBEDate;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;
  end;

var
  fmTRConcern: TfmTRConcern;

implementation

uses globals;

{$R *.DFM}

procedure TfmTRConcern.FormCreate(Sender: TObject);
begin
  inherited;
  Vertex:= dmGlobal.quMitrconcern;
end;

procedure TfmTRConcern.UMChangeMode(var Message:TMessage);
begin
  inherited;
  if WorkStyle = wsAdd then
  begin
    if (dsCurrent.DataSet = odsMitrConcern.DataSet) or
       (dsCurrent.DataSet = odsMitrconc_agr.DataSet) then
  end;
end;

initialization
  RegisterClass(TfmTRConcern);

finalization
  UnregisterClass(TfmTRConcern);

end.
