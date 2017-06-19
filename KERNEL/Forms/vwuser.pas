unit vwuser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vworkform, vDbASUP, Menus, Db, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls,
  Oracle, v_anyform;

type
  TfmMiPolz = class(TfmWorkForm)
    laUserName: TLabel;
    deUser: TVDBERus;
    deOracle: TVDBERus;
    laOracle: TLabel;
    laPrivilege: TLabel;
    wePrivilege: TVWatchEdit;
    tePrivilege: TDBText;
    oqDDL: TOracleQuery;
    procedure deOracleKeyPress(Sender: TObject; var Key: Char);
  private
    FPrivs: string;
    { Private declarations }
  protected
    procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;
    function OraclePerformance:boolean;override;
  public
    { Public declarations }
  end;

var
  fmMiPolz: TfmMiPolz;

implementation

uses
  globals,v_duserpw;
{$R *.DFM}

procedure TfmMiPolz.deOracleKeyPress(Sender: TObject; var Key: Char);
begin
  if not ( (Key in ['A'..'Z','a'..'z','0'..'9','_'])
   or (ord(Key) in [vk_Back,vk_Tab,vk_Prior,vk_Next]) ) then
  begin
    Key:= #00;
    Beep;
  end;
end;

procedure TfmMiPolz.UMChangeMode(var Message:TMessage);
begin
  inherited;
  deOracle.ReadOnly:= Message.wParam=IN_EDIT;
end;

function TfmMiPolz.OraclePerformance;
var
  OracleUserName: string;
  FOtherAppRoles: string;

function GetPassword: string;
begin
  with TfmUserPassword.Create(Self) do
  begin
    if ShowModal=mrOk then
      Result:= meOrigin.Text
    else Result:= '';
    Free;
  end;
end;

function GetOtherAppRoles:string;
begin
  with oqDDL do
  begin
    SQL.Clear;
    SQL.Append('SELECT ORANAIM FROM MIROL MAIN');
    SQL.Append('WHERE EXISTS (SELECT 1 FROM MIPOLZ WHERE'+
               ' MIROL_KOD=MAIN.KOD AND ORANAIM=:USR'+
               ' AND MIPODSIS_KOD<>:SSYS)');
    DeclareVariable('USR',otString);
    SetVariable('USR',OracleUserName);
    DeclareVariable('SSYS',otString);
    SetVariable('SSYS',SubSystemCode);
    Execute;
    Result:= '';
    while not EOF do
    begin
      Result:= Concat(Result,FieldAsString(0));
      Next;
      if not EOF then Result:= Concat(Result,',');
    end;
    Close;
    DeleteVariables;
  end;
end;

begin
  OracleUserName:= deOracle.Field.AsString;
  if varType(dmGlobal.quMiPolzMIROL_ORANAIM.OldValue)=varNull then FPrivs:= ''
  else FPrivs:= dmGlobal.quMiPolzMIROL_ORANAIM.OldValue;
  Result:= inherited OraclePerformance;
  if Result then
  with oqDDL do
  begin
    FOtherAppRoles:= GetOtherAppRoles;
    case WorkStyle of
      wsAdd:
      begin
        SQL.Text:= Format('GRANT %s TO %s'
                           ,[dmGlobal.quMiPolzMIROL_ORANAIM.AsString,deOracle.Field.AsString]);
        Execute;
        {SQL.Text:= Format('ALTER USER %S DEFAULT ROLE ALL EXCEPT %s'
                           ,[ deOracle.Field.AsString,FAllAppRoles]);
        Execute;}
      end;
      wsEdit:
      if dmGlobal.quMiPolzMIROL_ORANAIM.AsString<>FPrivs then
      begin
        SQL.Text:= Format('GRANT %s TO %s'
                           ,[dmGlobal.quMiPolzMIROL_ORANAIM.AsString,deOracle.Field.AsString]);
        Execute;
        {SQL.Text:= Format('ALTER USER %S DEFAULT ROLE ALL EXCEPT %s'
                         ,[ deOracle.Field.AsString,FAllAppRoles]);
        Execute;}
        if Pos(FPrivs,FOtherAppRoles)=0 then
        begin
          SQL.Text:= Format('REVOKE %s FROM %s',[FPrivs,deOracle.Field.AsString]);
          Execute;
        end;
      end;
      wsDelete:
        if Pos(FPrivs,FOtherAppRoles)=0 then
        begin
          SQL.Text:= Format('REVOKE %s FROM %s',[FPrivs,OracleUserName]);
          Execute;
        end;
    end;
  end;
end;

initialization
  RegisterClass(TfmMiPolz);

finalization
  UnregisterClass(TfmMiPolz);
end.
