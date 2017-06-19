unit wExchange;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vworkform, vDbASUP, Menus, Db, StdCtrls, Buttons, ExtCtrls, Mask, Spin, v_anyform,
  DBCtrls, Variants;

type
  TfmExchange = class(TfmWorkForm)
    lblYear: TLabel;
    seYEAR: TSpinEdit;
    deYear: TVDBEMath;
    lblCurrency: TLabel;
    dblcbCurrency: TDBLookupComboBox;
    deCurrency: TVDBEMath;
    lblRate: TLabel;
    deRate: TVDBEMath;
    procedure seYEARChange(Sender: TObject);
    procedure deYearChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FChangingYEAR : boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;
    procedure DoAfterInsert(ASUPQuery: TVASUPQuery); override;
  end;

var
  fmExchange: TfmExchange;

implementation

uses globals;

{$R *.DFM}

procedure TfmExchange.seYEARChange(Sender: TObject);
begin
  inherited;
  if not FChangingYEAR then
    try
      FChangingYEAR := true;
      if  seYEAR.Value = 0 then
        deYear.Field.Value := NULL
      else
        deYear.Field.Value := seYEAR.Value;
    finally
      FChangingYEAR := false;
    end;
end;

procedure TfmExchange.deYearChange(Sender: TObject);
begin
  inherited;
  if not FChangingYEAR then
    try
      FChangingYEAR := true;
      if dsCurrent.DataSet.IsEmpty or (deYear.Field.Value = NULL) then
        seYEAR.Value := 0
      else
        seYEAR.Value := deYear.Field.Value;
    finally
      FChangingYEAR := false;
    end;
end;

procedure TfmExchange.FormCreate(Sender: TObject);
begin
  FChangingYEAR := false;
  inherited;
end;

procedure TfmExchange.UMChangeMode(var Message:TMessage);
begin
  inherited;

  if WorkStyle in [wsView, wsDelete] then
    seYEAR.ReadOnly := true
  else
    seYEAR.ReadOnly := false;
end;

procedure TfmExchange.DoAfterInsert(ASUPQuery: TVASUPQuery);
var
  d, m, y : Word;
begin
  if ASUPQuery = dsCurrent.DataSet then
  begin
    DecodeDate(Date, y, m, d);
    dsCurrent.DataSet.FieldByName('YEAR').Value := y;
  end;
end;

initialization
  RegisterClass(TfmExchange);

finalization
  UnregisterClass(TfmExchange);

end.
