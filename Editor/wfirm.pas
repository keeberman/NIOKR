unit wfirm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vwtree, ImgList, vDbASUP, Menus, Db, StdCtrls, Buttons, TB97, TB97Tlbr,
  ComCtrls, Grids, DBGrids, RXDBCtrl, ExtCtrls, Mask, DBCtrls;

type
  TfmFirm = class(TfmTreeTopology)
    tsFirm: TTabSheet;
    dsFirm: TDataSource;
    Label1: TLabel;
    deName: TVDBERus;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    weCountry: TVWatchEdit;
    weDistrict: TVWatchEdit;
    dtCountry: TDBText;
    dtDistrict: TDBText;
    weRegion: TVWatchEdit;
    dtRegion: TDBText;
    Label19: TLabel;
    Label18: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    deZip_code: TVDBEditChar;
    dePost_box: TVDBEditChar;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    dePhone1: TVDBEditChar;
    dePhone2: TVDBEditChar;
    dePhone5: TVDBEditChar;
    dePhone4: TVDBEditChar;
    dePhone3: TVDBEditChar;
    deFax_no: TVDBEditChar;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    deTelex_no: TVDBEditChar;
    Label14: TLabel;
    deE_mail: TVDBEditChar;
    tsAccount: TTabSheet;
    dsAccount: TDataSource;
    paFirm: TPanel;
    Label15: TLabel;
    deFirm_no: TVDBEMath;
    Label16: TLabel;
    deShort_name: TVDBERus;
    GroupBox3: TGroupBox;
    deBank_account: TVDBEditChar;
    Label21: TLabel;
    weCurrency: TVWatchEdit;
    dtCurrency: TDBText;
    Label22: TLabel;
    weBank_country: TVWatchEdit;
    dtBankcountry_name: TDBText;
    Label26: TLabel;
    dtBank_name: TDBText;
    GroupBox4: TGroupBox;
    weBank_id: TVWatchEdit;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    deBank_naim: TVDBEditChar;
    deBank_code: TVDBEditChar;
    deBank_address: TVDBEditChar;
    Label27: TLabel;
    deCity_name: TVDBERus;
    deAddress: TVDBERus;
    procedure FormCreate(Sender: TObject);
    procedure weBank_idAcceptValue(Sender: TObject;
      var UseInherited: Boolean);
    procedure weDistrictAcceptValue(Sender: TObject;
      var UseInherited: Boolean);
    procedure weRegionAcceptValue(Sender: TObject;
      var UseInherited: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmFirm: TfmFirm;

implementation
uses globals;
{$R *.DFM}


procedure TfmFirm.FormCreate(Sender: TObject);
begin
  inherited;
  Vertex:= dmGlobal.quFirm;
end;

procedure TfmFirm.weBank_idAcceptValue(Sender: TObject;
  var UseInherited: Boolean);
begin
  inherited;
  UseInherited:= true;
  dmglobal.quAccountCOUNTRY_NO.Value :=
    weBank_id.EyesQuery.fieldbyName('COUNTRY_NO').value;
end;

procedure TfmFirm.weDistrictAcceptValue(Sender: TObject;
  var UseInherited: Boolean);
begin
  inherited;
  UseInherited:= true;
  dmglobal.quFirmCOUNTRY_NO.Value :=
    weDistrict.EyesQuery.fieldbyName('COUNTRY_NO').value;
  dmglobal.quFirmREGION_NO.Value :=
    weDistrict.EyesQuery.fieldbyName('REGION_NO').value;
end;

procedure TfmFirm.weRegionAcceptValue(Sender: TObject;
  var UseInherited: Boolean);
begin
  inherited;
  UseInherited:= true;
  dmglobal.quFirmCOUNTRY_NO.Value :=
    weRegion.EyesQuery.fieldbyName('COUNTRY_NO').value;
end;

initialization
  RegisterClass(TfmFirm);

finalization
  UnregisterClass(TfmFirm);
end.
