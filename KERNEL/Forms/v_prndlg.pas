unit v_prndlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_AnyForm, StdCtrls, Buttons, ComCtrls, ToolWin, ExtCtrls, v_AnyFRep, Spin;

type
  TfmPrintDialog = class(TfmAnyForm)//Предок форм для печати отчетов
    bbPreview: TBitBtn;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
              {Обработчик события OnClose формы.
              Служит для удаления формы после ее закрытия}

    procedure bbOkClick(Sender: TObject);
              {Обработчик нажатия кнопки bbOk.
              Отображает диалог настройки принтера,
              затем запускает печать отчета}

    procedure bbPreviewClick(Sender: TObject);
              {Обработчик нажатия кнопки bbPreview.
              Запускает предварительный просмотр отчета }
  private
    { Private declarations }
  protected
    { Protected declarations }
    function GetRptForm: TfmAnyFRep;virtual;
  public
    { Public declarations }
    property RptForm: TfmAnyFRep read GetRptForm;
  end;

var
  fmPrintDialog: TfmPrintDialog;

implementation
{$R *.DFM}

uses DB;

function TfmPrintDialog.GetRptForm: TfmAnyFRep;
begin
  Result:= Owner as TfmAnyFRep;
end;

procedure TfmPrintDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmPrintDialog.bbOkClick(Sender: TObject);
var
  SavePlace: TBookMarkStr;
begin
  inherited;
  Screen.Cursor:= crHourGlass;
  SavePlace:= RptForm.dsReport.DataSet.BookMark;
  try
    Screen.Cursor:= crHourGlass;
    Self.Repaint;
    if RptForm.frxReport.PrepareReport then
       RptForm.frxReport.ShowPreparedReport;
    Screen.Cursor:= crDefault;
  finally
    RptForm.dsReport.DataSet.BookMark:= SavePlace;
  end;
  Close;
end;

procedure TfmPrintDialog.bbPreviewClick(Sender: TObject);
begin
  RptForm.frxReport.ShowReport;
  Close;
end;

end.
