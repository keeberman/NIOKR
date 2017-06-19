unit v_repList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, RXDBCtrl, ExtCtrls, Db, OracleData,
  Oracle;

type
  TfmRepList = class(TForm)
    pTop: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbgReport: TRxDBGrid;
    pBottom: TPanel;
    pRightBottom: TPanel;
    bbCancel: TBitBtn;
    bbOk: TBitBtn;
    quReport: TOracleQuery;
    odsReports: TOracleDataSet;
    dsReports: TDataSource;
    procedure odsReportsAfterOpen(DataSet: TDataSet);
    procedure odsReportsAfterClose(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFromYear     : INteger; // √од начала временого интервала
    FToYear       : Integer; // √од конча временого интервала
  public
    { Public declarations }
    property FromYear : INteger read FFromYear;
    property ToYear : INteger read FToYear;

    constructor Create(AOwner: TComponent; AFromYear : Integer; AToYear : Integer); overload;
  end;

var
  fmRepList: TfmRepList;

implementation

{$R *.DFM}

constructor TfmRepList.Create(AOwner: TComponent; AFromYear : Integer; AToYear : Integer);
begin
  FFromYear := AFromYear;
  FToYear   := AToYear;
  inherited Create(AOwner);
end;

procedure TfmRepList.odsReportsAfterOpen(DataSet: TDataSet);
begin
  if odsReports.RecNo < 0 then
    bbOk.Enabled := false
  else
    bbOk.Enabled := true;
end;

procedure TfmRepList.odsReportsAfterClose(DataSet: TDataSet);
begin
  bbOk.Enabled := false;
end;

procedure TfmRepList.FormCreate(Sender: TObject);
begin
  if FFromYear = 0 then
    if FToYear <> 0 then
      FFromYear := FToYear
    else
      FFromYear := StrToInt(FormatDateTime('yyyy',Date));

  if FToYear = 0 then
    FToYear := FFromYear;

  if FFromYear = FToYear then
    Label2.Caption := 'за ' + IntToStr(FToYear) + ' год'
  else
    Label2.Caption := IntToStr(FFromYear) + ' -- ' + IntToStr(FToYear) + ' годов';

  odsReports.SetVariable('FROMDATE', EncodeDate(FFromYear, 1, 1));
  odsReports.SetVariable('TODATE',   EncodeDate(FToYear,   1, 1));
  odsReports.Open;
end;

end.
