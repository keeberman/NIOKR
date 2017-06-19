
unit v_Nsiform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vworkform, vDbASUP, StdCtrls, Mask, DBCtrls, Menus, Db, Buttons, ExtCtrls,Oracle,
  v_AnyForm;

type
  TfmNSI = class(TfmWorkForm)
         // Рабочая форма для стандартных справочников
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    deCode: TVDBEditChar;
    deShort: TVDBERus;
    deFull: TVDBERus;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;
              { При добавлении записи автоматически заполняется
                deCode первым свободным кодом из справочника}
  public
    { Public declarations }
  end;

var
  fmNSI: TfmNSI;

implementation

uses dbtables{,v_NsiRep},v_stdfrep;
{$R *.DFM}

procedure TfmNSI.UMChangeMode(var Message:TMessage);
begin
  if (Message.wParam= IN_EDIT) and
     not Assigned(ActiveControl) then ActiveControl:= deShort;
  inherited;
  if (Message.wParam=IN_INSERT)
      and NeedFreeCode then
  begin
    deCode.Field.AsString:= GetFreeCode(deCode.DataField);
    if not deCode.Field.IsNull then ActiveControl:= deShort;
  end;
end;

procedure TfmNSI.FormCreate(Sender: TObject);
begin
  inherited;
  ReportType:= TfmStdFRep;
end;

initialization
  RegisterClass(TfmNSI);

finalization
  UnregisterClass(TfmNSI);
end.
