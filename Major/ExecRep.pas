unit ExecRep;

interface
uses classes,windows;

const
// There is where reports are:
{ Better put reports files into clients $ORACLE_HOME\BIN directory
  and call them by simple names e.g.
  REP_ITR     = 'itr.rep';
  REP_RAB     = 'rab.rep';
  REP_ITR_IZM = 'itr_izm.rep';
  REP_RAB_IZM = 'rab_izm.rep';
}
// Replace these lines with correct values!!!
//------------------------------------------------
  REP_ITR      = 'itr.rep';
  REP_RAB      = 'rab.rep';
  REP_ITR_IZM  = 'itr_izm.rep';
  REP_RAB_IZM  = 'rab_izm.rep';
  REP_SREDRAZR = 'sredrazr.rep';
  REP_SREDRAZR2 = 'srrazuch.rep';
  REP_DOSHK    = 'doshk.rep';
  REP_RABPROF  = 'rabprof.rep';
  REP_RABCHIS  = 'rabchis.rep';
  REP_CEHPROF  = 'cehprof.rep';
  REP_CEHDOL   = 'cehdol.rep';
  REP_ITRDOL   = 'itrdol.rep';
  REP_ITRFOT   = 'itrfot.rep';
  REP_RABRAZR  = 'kolrazr.rep';
  REP_KOEFIND  = 'koefind.rep';
  REP_RN07 = 'rn-07.rep';
//------------------------------------------------

  OR_LANDSCAPE='LANDSCAPE';
  OR_PORTRAIT= 'PORTRAIT';
  PS_A4LANDSCAPE='29.7x21';
  PS_A4PORTRAIT='21x29.7';

type
  TUserID = record
     Name     : String; //User name :-)
     Password : String; //User password :-)
     DBName   : String; //Database Name - where user will try to connect :-)
  end;

const
  RepHasBeenStarted= 'Дождитесь завершения формирования отчета';
  BreakRepConfirm='Прервать формирование отчета?';

type
  TSearchThread= class(TThread)
    constructor Create( const ReportName: string;
                        const LastProcess:TProcessInformation);
    destructor Destroy;override;
  private
    FSrchStr: PChar;
  public
    PrcInfo: TProcessInformation;
    Param: Pointer;
    procedure Execute;override;
    property Terminated;
  end;

function GetReportTitle(const AReport : String) : String;
function RunReport( const AUserID : TUserID; const AReport,Orientation,ParamStr: String;
                    var ProcessInfo: TProcessInformation) : Boolean;
function ErMsgRep(const ErCode: Integer): string;
function EnumThreadWndProc(Handle: HWND;AppPARAM: Integer):bool;stdcall;

var
  ReportPath: string;//Path to report file

implementation

uses Messages, SysUtils,v_Utils;

type
  TInterPack= record
                LastWinText: PChar;
                Complete: bool;
              end;
  PInterPack= ^TInterPack;

function EnumThreadWndProc(Handle: HWND;AppParam: Integer):bool;stdcall;
var
  WinCap: PChar;
  InterPack:PInterPack;
begin
  WinCap:= StrAlloc(GetWindowTextLength(Handle)+1);
  GetWindowText(Handle,WinCap,StrBufSize(WinCap));
  InterPack:= Pointer(AppPARAM);
  Result:= (StrIComp(WinCap,InterPack^.LastWinText)<>0)
           or not IsWindowVisible(Handle);
  InterPack^.Complete:= not Result;
  StrDispose(WinCap);
end;

constructor TSearchThread.Create( const ReportName: string;
                                  const LastProcess:TProcessInformation);
var
  WinTitle: String;
begin
  inherited Create(True);
  WinTitle:= GetReportTitle(ReportName);
  FreeOnTerminate:= true;
  Priority:= tpIdle;
  FSrchStr:= StrAlloc(Length(WinTitle)+1);
  StrPCopy(FSrchStr,WinTitle);
  TerminateProcess(LastProcess.hProcess,0);
  PrcInfo.hProcess:= 0;
  PrcInfo.hThread:= 0;
end;

destructor TSearchThread.Destroy;
begin
  StrDispose(FSrchStr);
  inherited;
end;

procedure TSearchThread.Execute;
var
  InterPack: PInterPack;
begin
  New(InterPack);
  with InterPack^ do
  begin
    LastWinText:= FSrchStr;
    Complete:= false;
  end;
  repeat
  until Terminated or (GetPriorityClass(PrcInfo.hProcess)=0)
        or not EnumThreadWindows(PrcInfo.dwThreadId,@EnumThreadWndProc,Integer(InterPack))
        or InterPack^.Complete;
  Dispose(InterPack);
end;

function GetReportTitle(const AReport : String) : String;
begin
 Result := '';
 if AReport = REP_ITR then Result := 'Штатное расписание служащих'
 else if AReport = REP_RAB then Result := 'Штатное расписание рабочих'
 else if AReport = REP_ITR_IZM then Result := 'Изменения в штатном расписании служащих'
 else if AReport = REP_RAB_IZM then Result := 'Изменения в штатном расписании рабочих'
 else if AReport= REP_SREDRAZR then Result:= 'Средний разряд по рабочим'
 else if AReport= REP_DOSHK then Result:= 'Свод по дошкольным учреждениям'
 else if AReport= REP_RABPROF then Result:= 'Численность рабочих по профессиям'
 else if AReport= REP_RABCHIS then Result:= 'Численность рабочих по штатному расписанию'
 else if AReport= REP_CEHPROF then Result:= 'Перечень цехов по профессиям'
 else if AReport= REP_CEHDOL then Result:= 'Перечень цехов по должностям'
 else if AReport= REP_ITRDOL then Result:= 'Численность служащих по должностям'
 else if AReport= REP_ITRFOT then Result:= 'Численность служащих и ФОТ'
 else if AReport= REP_KOEFIND then Result:= 'Коэффиценты индексации заработной платы'
 else if AReport= REP_RN07 then Result:= 'Тест'
end;

function RunReport( const AUserID : TUserID; const AReport,Orientation,ParamStr: String;
                    var ProcessInfo: TProcessInformation) : Boolean;
{---------------------Return Value----------------------------------------------

If the function succeeds, the return value is greater than 31.
If the function fails, the return value is one of the following error values:

Value	                Meaning
--------------------------------------------------------------------------------
-1                      One instance of report is already running
 0	                The system is out of memory or resources.
ERROR_BAD_FORMAT	The .EXE file is invalid (non-Win32 .EXE or error in .EXE image).
ERROR_FILE_NOT_FOUND	The specified file was not found.
ERROR_PATH_NOT_FOUND	The specified path was not found.
--------------------------------------------------------------------------------}
var CmdLine : String;
    S : String;
    StartUpInfo: TStartUpInfo;
    PageSize: string;
begin
 S := GetReportTitle(AReport);
 if Orientation=OR_LANDSCAPE then PageSize:=PS_A4LANDSCAPE
 else PageSize:= PS_A4PORTRAIT;
 CmdLine := 'rwrun60.exe ' +
            'MODULE="' + ReportPath+ AReport + '" ' +
            'USERID=' + AUserID.Name + '/'
                      + AuserID.Password + '@'
                      + AUserID.DBName + ' ' +
            'PARAMFORM=NO ' +
            RoleArgument +
           // 'DESTYPE=PREVIEW ' +
           // 'DESNAME=printer ' +
            'COPIES=1 ' +
            'READONLY=YES ' +
            Format('ORIENTATION=%s ',[Orientation]) +
            Format('PAGESIZE=%s ',[PageSize]) +
            'PRINTJOB=YES ' +
            'BLANKPAGES=YES ' +
            'MAXIMIZE=YES ' +
            'DISABLEPRINT=NO ' +
            'DISABLEMAIL=YES ' +
            'DISABLEFILE=YES ' +
            'DISABLENEW=YES ' +ParamStr;
  with StartUpInfo do
  begin
    cb:= SizeOf(TStartUpInfo);
    lpReserved:= nil;
    lpDeskTop:= nil;
    lpTitle:= nil;
    dwFlags:= 0;
    cbReserved2:= 0;
    lpReserved2:= nil;
  end;
  Result:= CreateProcess( nil,PChar(CmdLine),nil,nil,false,0,nil,nil,
                        StartUpInfo,ProcessInfo);
end;

function ErMsgRep(const ErCode: Integer): string;
begin
  Result:= '';
  case ErCode of
    -1: Result:= 'Отчет уже запущен.';
    ERROR_FILE_NOT_FOUND: Result:= 'Не найдена программа просмотра отчетов.';
    ERROR_PATH_NOT_FOUND: Result:= 'Неверно указан путь к программе просмотра отчетов.';
    else if ErCode<=31 then Result:= 'Ошибка при формировании отчета.';
  end;
end;

initialization
  RoleArgument:= '';
end.

