unit v_date;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Spin, Buttons, Grids, Calendar, ExtCtrls;

const
  Max_width=1024;

type
  TfmDate = class(TForm)
    paTop: TPanel;
    paBottom: TPanel;
    bOk: TBitBtn;
    bCancel: TBitBtn;
    paCenter: TPanel;
    Calendar: TCalendar;
    cbMonth: TComboBox;
    laMonth: TLabel;
    seYear: TSpinEdit;
    laYear: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure seYearExit(Sender: TObject);
    procedure cbMonthChange(Sender: TObject);
    procedure cbMonthKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDate: TfmDate;
  ResultDate: TDateTime;

implementation

{$R *.DFM}

uses DateUtil;

procedure TfmDate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfmDate.bOkClick(Sender: TObject);
begin
  with Calendar do
    ResultDate:= StrtoDateFmt('dd.mm.yyyy',Format('%d.%d.%d',[Day,Month,Year]));
end;

procedure TfmDate.FormShow(Sender: TObject);
var
  Year,Month,Day: Word;
begin
  DecodeDate(ResultDate,Year,Month,Day);
  Calendar.Year:=Year;
  Calendar.Month:= Month;
  Calendar.Day:= Day;
  seYear.Value:= Year;
  cbMonth.ItemIndex:= Month-1;
end;

procedure TfmDate.seYearExit(Sender: TObject);
begin
  Calendar.Day:= 1;
  Calendar.Year:= seYear.Value
end;

procedure TfmDate.cbMonthChange(Sender: TObject);
begin
  Calendar.Day:= 1;
  Calendar.Month:= cbMonth.ItemIndex+1;
end;

procedure TfmDate.cbMonthKeyPress(Sender: TObject; var Key: Char);
begin
  Key:= #00;
end;

end.
