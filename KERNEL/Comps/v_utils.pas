unit v_utils;

interface
uses classes,Oracle,OracleData,SysUtils,Windows;
const
  ClickDelay= 200;

procedure BeginRepeatCycle(TimerOwner: TComponent;ProcDelay: Integer;Proc:TNotifyEvent);
procedure EndRepeatCycle;
function NonDefaultRolesActivate(ASession: TOracleSession;SysCode:Integer):bool;
function GetObjectByTableName(AOwner: TComponent;const TabName: string): TOracleDataSet;

var
  RoleArgument: string;
implementation

uses
  extctrls,Dialogs;
var
  LongClickTimer: TTimer;
  
procedure BeginRepeatCycle(TimerOwner: TComponent;ProcDelay: Integer;Proc:TNotifyEvent);
begin
  if not Assigned(LongClickTimer) then
    begin
      LongClickTimer:= TTimer.Create(TimerOwner);
      with LongClickTimer do
      begin
        Enabled:= false;
        Interval:= ProcDelay;
        OnTimer:= Proc;
        Enabled:= true;
      end;
    end;
end;

procedure EndRepeatCycle;
begin
  if Assigned(LongClickTimer) then
    with LongClickTimer do
    begin
      Enabled:= false;
      Free;
      LongClickTimer:= nil
    end;
end;

const
  Code_Line='QWER2TY3UIOP146ASDFG5_70HJKL8ZXCV9BNM';
  Standard_Line= '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_';

function NonDefaultRolesActivate(ASession: TOracleSession;SysCode: Integer):bool;

procedure ActivateScript(const Role,Password:string);
var
  DecodePassword: string;
begin
  with TOracleQuery.Create(nil) do
  try
    Session:= ASession;
    SQL.Text:= 'SELECT TRANSLATE(:P1,:P2,:P3) Password FROM DUAL';
    DeclareVariable('P1',otString);
    SetVariable('P1',Password);
    DeclareVariable('P2',otString);
    SetVariable('P2',Code_Line);
    DeclareVariable('P3',otString);
    SetVariable('P3',Standard_Line);
    Execute;
    DecodePassword:= FieldAsString(0);
    Close;
    DeleteVariables;
    SQL.Text:= Format('SET ROLE %S IDENTIFIED BY %S',[Role,DecodePassword]);
    RoleArgument:= Format('ROLE=%s/%s ',[Role,DecodePassword]);
    Execute;
    Close;
  finally
    Free;
  end;
end;

begin
  with TOracleQuery.Create(nil) do
  try
    Session:= ASession;
    SQL.Text:= 'ALTER SESSION SET CURRENT_SCHEMA=P';
    Execute;
    SQL.Clear;
    SQL.Add('SELECT R.ORANAIM,R.SHIFR FROM USER_ROLE_PRIVS U, MIROL R, MIPOLZ U2 WHERE');
    SQL.Add('U2.ORANAIM= USER AND U2.MIPODSIS_KOD=:APPSYS');
    SQL.Add('AND R.KOD= U2.MIROL_KOD');
    SQL.Add('AND U.GRANTED_ROLE=R.ORANAIM AND U.DEFAULT_ROLE=:FLAG');
    DeclareVariable('APPSYS',otInteger);
    DeclareVariable('FLAG',otString);
    SetVariable('APPSYS',SysCode);
    SetVariable('FLAG','NO');
    Execute;
    Result:= not EOF;
    while not EOF do
    begin
      ActivateScript(FieldAsString(0),FieldAsString(1));
      Next;
    end;
    Close;
    DeleteVariables;
  finally
    Free;
  end;
end;

function GetObjectByTableName(AOwner: TComponent;const TabName: string): TOracleDataSet;
var
  I: Integer;
begin
  I:= 0;
  with AOwner do
  begin
    while (not (Components[I] is TOracleDataSet)
           or (TOracleDataSet(Components[I]).Updatingtable<> TabName) )
          and (I<ComponentCount) do Inc(I);
    if I< ComponentCount then
       Result:= TOracleDataSet(Components[I])
    else Result:= nil;
  end;
end;

initialization
  LongClickTimer:= nil;
end.
