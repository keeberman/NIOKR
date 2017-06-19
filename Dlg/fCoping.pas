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
    // Флаг конца копирования данных
    flFinishOfCoping : Boolean;

    // Время начала копирования данных
    tStartTime : TDateTime;
  public
    { Public declarations }

    // Устанвливает максимальное занчение ProgressBar
    procedure SetMax(value : Integer);

    // Устанвливает минимальное занчение ProgressBar
    //procedure SetMin(value : Integer);

    // Устанавливается минимальное значение у ProgressBar
    procedure reset;

    // Старт копирования данных
    procedure Start;

    // Финиш копирования данных
    procedure Finish;

    // Увеличивает текущее значение ProgressBar на единичу
    procedure Next(AInc : Integer = 1);


    procedure NewValue(ANewMaxValue, ANewValue : Integer);

    // устанавливает флаг конца копирования данных
    procedure SetEndCopy;

    // Устанавливает заголовок, для копрования
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
  // Пока не установлен флаг, что данные скопированы
  // окно невожможно закрыть.
  if not flFinishOfCoping then
    Action := caNone
  else
  // окно закрывается и автоматически освобождает память
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
  // Устанавливаем минимальное значение ProgressBar
  gCopingProcent.Progress := gCopingProcent.MinValue;

  // Устанавлеваем расчетное время и время до конца копирования
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
  // Устанавливаем начальные значения для ProgressBar
  reset;
  // Засекаем время
  tStartTime := now;

  // Запускаем таймер
  Timer.Enabled := true;
end;

procedure TfrmCoping.Finish;
begin
  // Останавливаем таймер
  Timer.Enabled := false;
end;

procedure TfrmCoping.TimerTimer(Sender: TObject);
var
  // Кол. единиц выполненой операции
  Progress : Integer;

  // кол. всех единиц которое небходимо выполнить
  countOfPort : Integer;

  // Расчетное время
  CalcTimer  : TDateTime;

  // Время прошло с начала копирования
  deltaTimer : TDateTime;
begin
  if (gCopingProcent.Progress > 0) and (gCopingProcent.MaxValue > 0) then
  begin
    Progress    := gCopingProcent.Progress;
    countOfPort := gCopingProcent.MaxValue;

    // Оперделяем сколько прошло времени с начала копирования
    deltaTimer := now - tStartTime;

    // Расчитываем время, которое небходимо для выполнения операции
    CalcTimer := (deltaTimer/Progress)*countOfPort;

    // Вывод расчетное время и остаток времни до конца копирования
    lblCalcTime.Caption      := FormatDateTime('hh:nn:ss', CalcTimer);//TimeToStr(CalcTimer);
    lblRemainderTime.Caption := FormatDateTime('hh:nn:ss', CalcTimer - deltaTimer);//TimeToStr(CalcTimer - deltaTimer);
  end;
end;

end.
