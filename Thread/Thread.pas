unit Thread;

interface

uses classes, Dialogs, sysutils;

type
  TThreadMethodRN03RN04 = procedure (Sender: TObject; Excel:  OLEVariant; date_str : String; rep_date : TDateTime; ADate : TDateTime; rep_month : string; rep_year : string; Concern_Dog : Integer; ConcDateFrom : TDateTime; ConcDateTo : TDateTime) of object;

  TExThread= class(TThread)
  private
    FERMsg: string;
    FResult: Word;
    FButtons:TMsgDlgButtons;
    procedure ShowMsg;
  public
    function ShowError(ErMsg:string;AButtons:TMsgDlgButtons): Word;
  end;

  TLRQThread= class(TExThread) // Long Running Query Thread
  private
    FOnDo: TThreadMethod;
    function GetBroken : boolean;
  public
    property Broken: boolean read GetBroken;
    property OnDo: TThreadMethod read FOnDo write FOnDo;
    procedure Execute;override;
  end;

  TLRQThreadRN0304 = class(TExThread) // Long Running Query Thread
  private
    FOnDo : TThreadMethodRN03RN04;
    FSender : TObject;
    FExcel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application

    Fdate_str : String;
    Frep_date : TDateTime;
    FDate : TDateTime;
    Frep_month : string;
    Frep_year : string;
    FConcern_Dog : Integer;
    FConcDateFrom : TDateTime;
    FConcDateTo : TDateTime;

    function GetBroken : boolean;
  public
    property Broken: boolean read GetBroken;
    property Sender : TObject read FSender write FSender;
    property Excel:  OLEVariant read FExcel write FExcel;  // Вариантная переменная для объекта Excel.Application

    property date_str : String read Fdate_str write Fdate_str;
    property rep_date : TDateTime read Frep_date write Frep_date;
    property LDate : TDateTime read FDate write FDate;
    property rep_month : string read Frep_month write Frep_month;
    property rep_year : string read Frep_year write Frep_year;
    property Concern_Dog : Integer read FConcern_Dog write FConcern_Dog;
    property ConcDateFrom : TDateTime read FConcDateFrom write FConcDateFrom;
    property ConcDateTo : TDateTime read FConcDateTo write FConcDateTo;

    property OnDo: TThreadMethodRN03RN04 read FOnDo write FOnDo;
    procedure Execute;override;
  end;

implementation


//-----------------------------TExThread------------------------------

procedure TExThread.ShowMsg;
begin
  FResult:= MessageDlg(FErMsg,mtError,FButtons,0);
end;

function TExThread.ShowError (ErMsg:string;AButtons:TMsgDlgButtons): Word;
begin
  FErMsg:= ErMsg;
  FButtons:= AButtons;
  Synchronize(ShowMsg);
  Result:= FResult;
end;

//-----------------------------TLRQThread-----------------------------

function TLRQThread.GetBroken : boolean;
begin
  Result:= Terminated;
end;

procedure TLRQThread.Execute;
begin
  try
    if Assigned(FOnDo) then FOnDo;
  except
    on E:Exception do ShowError(E.Message,[mbOk]);
  end;
end;

//-----------------------------TLRQSThread-----------------------------

function TLRQThreadRN0304.GetBroken : boolean;
begin
  Result:= Terminated;
end;

procedure TLRQThreadRN0304.Execute;
begin
  try
    if Assigned(FOnDo) then FOnDo(Sender, Excel, date_str, rep_date, LDate, rep_month, rep_year, Concern_Dog, ConcDateFrom, ConcDateTo);
  except
    on E:Exception do ShowError(E.Message,[mbOk]);
  end;
end;

end.
