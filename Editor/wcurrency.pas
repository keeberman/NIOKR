unit wcurrency;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vworkform, vDbASUP, Menus, Db, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  TfmCurrency = class(TfmWorkForm)
    deCurrencyNo: TVDBEditChar;
    deName: TVDBERus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dePriority_use: TVDBEditChar;
    deIso_name: TVDBERus;
    deInherited_id: TVDBERus;
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCurrency: TfmCurrency;

implementation
uses globals;
{$R *.DFM}


initialization
  RegisterClass(TfmCurrency);

finalization
  UnregisterClass(TfmCurrency);

end.
