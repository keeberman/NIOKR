unit v_rptopen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBCtrls, StdCtrls, Buttons, Grids, DBGrids, OracleData, ExtCtrls,
  RXDBCtrl;

type
  TfmRepOpenDialog = class(TForm)
    paBottom: TPanel;
    dsMain: TDataSource;
    paRight: TPanel;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    DBShortNavi: TDBNavigator;
    DBGrid: TRxDBGrid;
    procedure FormShow(Sender: TObject);
    procedure DBGridTitleClick(Column: TColumn);
    procedure dsMainDataChange(Sender: TObject; Field: TField);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRepOpenDialog: TfmRepOpenDialog;

implementation
uses v_fastmod;
{$R *.DFM}

procedure TfmRepOpenDialog.FormShow(Sender: TObject);
begin
  if dmFastReport.quRpt.Active then
     dmFastReport.quRpt.Close;
  dmFastReport.quRpt.Open;
end;

procedure TfmRepOpenDialog.DBGridTitleClick(Column: TColumn);

function Direction(Tag: Integer): string;
begin
  if Tag=0 then Result:= 'ASC'
  else Result:= 'DESC';
end;

begin
  Column.Field.Tag:= (Column.Field.Tag+1) mod 2;
  with dmFastReport.quRpt.SQL do
    Strings[Count-1]:=
      Format( 'ORDER BY %s %s',
              [Column.FieldName,Direction(Column.Field.Tag)]);
  dmFastReport.quRpt.Refresh;
end;

procedure TfmRepOpenDialog.dsMainDataChange(Sender: TObject;
  Field: TField);
begin
  if not Assigned(Field) and dsMain.DataSet.IsEmpty then
    bbOk.Enabled:= false;
end;

procedure TfmRepOpenDialog.FormDestroy(Sender: TObject);
begin
  dmFastReport.quRpt.Close;
end;

procedure TfmRepOpenDialog.DBGridDblClick(Sender: TObject);
begin
  if bbOk.Enabled then bbOk.Click;
end;

end.
