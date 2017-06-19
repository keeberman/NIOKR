unit v_prnshld;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_AnyForm, StdCtrls, Buttons, ComCtrls, ToolWin, ExtCtrls, v_AnyReprt, Spin,
  QRPrntr, QuickRpt;

type
  TfmPrintShield = class(TfmAnyForm)//Предок форм для печати отчетов
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
    procedure FormActivate(Sender: TObject);
              {Обработчик нажатия кнопки bbPreview.
              Запускает предварительный просмотр отчета }
  private
    { Private declarations }
  protected
    { Protected declarations }
    function GetRptForm: TfrAnyReport;virtual;
  public
    { Public declarations }
    property RptForm: TfrAnyReport read GetRptForm;
  end;

  function PrinterSetup(AQuickRep:TQuickRep) : Boolean;
  // Запускает диалог настройки принтера

var
  fmPrintShield: TfmPrintShield;

implementation
{$R *.DFM}

uses Printers, DB, vDBAsup;

const
  LastPageCount: Word = 1;


{ Global function }
function PrinterSetup(AQuickRep:TQuickRep) : Boolean;

  function PrepareQRPrinter : Boolean;
  var
   aReceiver : TWinControl;
  begin
   with AQuickRep do
    begin
     Result := Available;
     if Result then
      begin
       if assigned(QRPrinter) then AReceiver := QRPrinter.Master
       else AReceiver := nil;
       QRPrinter := TQRPrinter.Create;
       QRPrinter.Master := AReceiver;
       QRPrinter.AfterPreview := AfterPreview;
       QRPrinter.AfterPrint := AfterPrint;
      end;
    end;
  end;

begin
 Result:= false;
 with TPrintDialog.Create(nil) do
  try
   if assigned(AQuickRep.QRPrinter) then
    if LastPageCount < AQuickRep.QRPrinter.PageCount
     then LastPageCount := AQuickRep.QRPrinter.PageCount;
    if PrepareQRPrinter
     then AQuickRep.QRPrinter.PageCount := LastPageCount
     else Exit;
    if AQuickRep.QRPrinter.PrinterOK then
     begin
      if (AQuickRep.QRPrinter.Status = mpReady) then
       begin
        MinPage := 1;
        MaxPage := AQuickRep.QRPrinter.PageCount;
        FromPage := 1;
        ToPage := MaxPage;
       end;
      Copies :=  AQuickRep.PrinterSettings.Copies;
      Options := [poPageNums, poSelection, poWarning];
      Printer.Orientation:= AQuickRep.Page.Orientation;
      Result:= Execute;
      if Result then
       begin
        AQuickRep.PrinterSettings.PrinterIndex:= Printer.PrinterIndex;
        AQuickRep.PrinterSettings.Copies := Copies;
        AQuickRep.Page.Orientation := Printer.Orientation;
        case PrintRange of
         prAllPages,
         prSelection : begin
                        AQuickRep.PrinterSettings.FirstPage := 0;
                        AQuickRep.PrinterSettings.LastPage := 0;
                       end;
         prPageNums  : begin
                        AQuickRep.PrinterSettings.FirstPage := FromPage;
                        AQuickRep.PrinterSettings.LastPage := ToPage;
                       end;
        end;//case
       end;
     end;
  finally
   free;
 end
end;

function TfmPrintShield.GetRptForm: TfrAnyReport;
begin
  Result:= Owner as TfrAnyReport;
end;

procedure TfmPrintShield.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

procedure TfmPrintShield.bbOkClick(Sender: TObject);
var
  SavePlace: TBookMarkStr;
begin
  inherited;
  Screen.Cursor:= crHourGlass;
  SavePlace:= RptForm.dsReport.DataSet.BookMark;
  try
    with RptForm.qrMain do
     begin
      //Устанавливаем Master для перехвата CM_QRProgressUpdate
      if not Assigned(QRPrinter) then
         QRPrinter := TQRPrinter.Create;
      QRPrinter.{MessageReceiver}Master := RptForm;
      Prepare;
      {QRPrinter.Free;
      QRPrinter:= nil;}
     end;
    Screen.Cursor:= crDefault;
    if {RptForm.qrMain.fn}PrinterSetup(RptForm.qrMain) then
    begin
      Screen.Cursor:= crHourGlass;
      Self.Repaint;
      RptForm.qrMain.Print;
      Screen.Cursor:= crDefault;
    end;
  finally
    RptForm.dsReport.DataSet.BookMark:= SavePlace;
  end;
end;

procedure TfmPrintShield.bbPreviewClick(Sender: TObject);
begin
  RptForm.qrMain.Preview;
end;

procedure TfmPrintShield.FormActivate(Sender: TObject);
begin
  if Assigned(RptForm.PreviewForm)
     and RptForm.PreviewForm.Visible then
     RptForm.PreviewForm.Show;
end;

end.
