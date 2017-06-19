unit fCoping;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Gauges, StdCtrls;

type
  TfrmCoping = class(TForm)
    lblCopingTable: TLabel;
    gCopingProcent: TGauge;
    lblTitleOfCalcTime: TLabel;
    lblTitleOfRemainderTime: TLabel;
    lblCalcTime: TLabel;
    lblRemainderTime: TLabel;
    Timer: TTimer;
    procedure FormDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
    // ���� ����� ����������� ������
    flFinishOfCoping : Boolean;

    // ����� ������ ����������� ������
    tStartTime : TDateTime;
  public
    { Public declarations }

    // ������������ ������������ �������� ProgressBar
    procedure SetMax(value : Integer);

    // ������������ ����������� �������� ProgressBar
    //procedure SetMin(value : Integer);

    // ��������������� ����������� �������� � ProgressBar
    procedure reset;

    // ����� ����������� ������
    procedure Start;

    // ����� ����������� ������
    procedure Finish;

    // ����������� ������� �������� ProgressBar �� �������
    procedure Next(AInc : Integer = 1);


    procedure NewValue(ANewMaxValue, ANewValue : Integer);

    // ������������� ���� ����� ����������� ������
    procedure SetEndCopy;

    // ������������� ���������, ��� ����������
    procedure SetCaption(str : String);

    procedure visibleProgressBar(value : Boolean);
  end;

var
  frmCoping: TfrmCoping;

implementation

{$R *.DFM}

procedure TfrmCoping.FormDblClick(Sender: TObject);
begin
  flFinishOfCoping := true;
end;

procedure TfrmCoping.FormCreate(Sender: TObject);
begin
  flFinishOfCoping := false;
end;

procedure TfrmCoping.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // ���� �� ���������� ����, ��� ������ �����������
  // ���� ���������� �������.
  if not flFinishOfCoping then
    Action := caNone
  else
  // ���� ����������� � ������������� ����������� ������
    Action := caFree;
end;

procedure TfrmCoping.SetMax(value : Integer);
begin
  if value > gCopingProcent.MinValue then
    gCopingProcent.MaxValue := value
  else
    gCopingProcent.MaxValue := 100;
end;


//procedure TfrmCoping.SetMin(value : Integer);
//begin
//  gCopingProcent.MinValue := value;
//end;

procedure TfrmCoping.reset;
begin
  // ������������� ����������� �������� ProgressBar
  gCopingProcent.Progress := gCopingProcent.MinValue;

  // ������������� ��������� ����� � ����� �� ����� �����������
  lblCalcTime.Caption      := FormatDateTime('hh:nn:ss', 0);//TimeToStr(0);
  lblRemainderTime.Caption := FormatDateTime('hh:nn:ss', 0);//TimeToStr(0);
end;

procedure TfrmCoping.Next(AInc : Integer = 1);
begin
  if (gCopingProcent.Progress + AInc) <= gCopingProcent.MaxValue then
    gCopingProcent.Progress := gCopingProcent.Progress + AInc;
end;

procedure TfrmCoping.NewValue(ANewMaxValue, ANewValue : Integer);
begin
  gCopingProcent.MaxValue := ANewMaxValue;
  gCopingProcent.Progress := ANewValue;
end;

procedure TfrmCoping.SetEndCopy;
begin
  flFinishOfCoping := true;
end;

procedure TfrmCoping.SetCaption(str : String);
begin
  lblCopingTable.Caption := str;
end;

procedure TfrmCoping.visibleProgressBar(value : Boolean);
begin
  gCopingProcent.Visible := value;
  lblTitleOfCalcTime.Visible := value;
  lblCalcTime.Visible := value;
  lblTitleOfRemainderTime.Visible := value;
  lblRemainderTime.Visible := value;
end;

procedure TfrmCoping.Start;
begin
  // ������������� ��������� �������� ��� ProgressBar
  reset;
  // �������� �����
  tStartTime := now;

  // ��������� ������
  Timer.Enabled := true;
end;

procedure TfrmCoping.Finish;
begin
  // ������������� ������
  Timer.Enabled := false;
end;

procedure TfrmCoping.TimerTimer(Sender: TObject);
var
  // ���. ������ ���������� ��������
  Progress : Integer;

  // ���. ���� ������ ������� ��������� ���������
  countOfPort : Integer;

  // ��������� �����
  CalcTimer  : TDateTime;

  // ����� ������ � ������ �����������
  deltaTimer : TDateTime;
begin
  if (gCopingProcent.Progress > 0) and (gCopingProcent.MaxValue > 0) then
  begin
    Progress    := gCopingProcent.Progress;
    countOfPort := gCopingProcent.MaxValue;

    // ���������� ������� ������ ������� � ������ �����������
    deltaTimer := now - tStartTime;

    // ����������� �����, ������� ��������� ��� ���������� ��������
    CalcTimer := (deltaTimer/Progress)*countOfPort;

    // ����� ��������� ����� � ������� ������ �� ����� �����������
    lblCalcTime.Caption      := FormatDateTime('hh:nn:ss', CalcTimer);//TimeToStr(CalcTimer);
    lblRemainderTime.Caption := FormatDateTime('hh:nn:ss', CalcTimer - deltaTimer);//TimeToStr(CalcTimer - deltaTimer);
  end;
end;

end.
