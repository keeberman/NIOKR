unit v_prnprv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_Anyform, ExtCtrls, qrprntr, StdCtrls, Buttons, ComCtrls,v_anyreprt;

type
  TfmPreview = class(TfmAnyForm)
    qrPreview: TQRPreview;
    spZoomToFit: TSpeedButton;
    spZoomToWidth: TSpeedButton;
    spFirst: TSpeedButton;
    spPrior: TSpeedButton;
    spNext: TSpeedButton;
    spLast: TSpeedButton;
    spPrint: TSpeedButton;
    bbClose: TBitBtn;
    ProgressBar: TProgressBar;
    procedure FormShow(Sender: TObject);
              //���������� ������� OnShow �����

    procedure qrPreviewPageAvailable(Sender: TObject; PageNum: Integer);
              {���������� ������� OnPageAvailable ���������� qrPreview.
              ��������� ��� ���������� ������������ �������� ������.
              ��������� ������ ���������}

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
              {���������� ������� OnDestroy �����.
              ������� ����� ����� �� ��������}

    procedure ToolClick(Sender:TObject);
              {���������� ������ �� ������ ������������:
              ����/���� ��������, ������.}

    procedure bbCloseClick(Sender: TObject);
              {���������� ������� OnClick ������ bbClose.
              ��������� �����}

    procedure NavigatorClick(Sender:TObject);
              {���������� ������� OnClick ������ ��������� ��
              ������ ������������}

    procedure qrPreviewProgressUpdate(Sender: TObject; Progress: Integer);
    procedure FormDestroy(Sender: TObject);
              {���������� ������� OnProgressUpdate ����������
              qrPreview. ��������� ������ ���������}

  private
    { Private declarations }
    procedure UpdateStatusBar;
    function GetRptForm: TfrAnyReport;
  public
    { Public declarations }
    property RptForm: TfrAnyReport read GetRptForm;
  end;

var
  fmPreview: TfmPreview;

implementation

{$R *.DFM}
uses vdbAsup{,v_prnshld};

const RealrecCount : LongInt = -1;

procedure TfmPreview.FormShow(Sender: TObject);
begin
  inherited;
  qrPreview.Show;
end;

procedure TfmPreview.qrPreviewPageAvailable(Sender: TObject;
  PageNum: Integer);
begin
  inherited;
  UpdateStatusBar;
end;

procedure TfmPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

const
  CPRNnotReady='����� ��� �� �����';
  
procedure TfmPreview.ToolClick(Sender:TObject);
begin
  with qrPreview do
    if Sender= spZoomToFit then ZoomToFit
    else if Sender= spZoomToWidth then ZoomToWidth
      else if Sender= spPrint then
        if not Assigned(RptForm.qrMain.QRPrinter) or
           (RptForm.qrMain.QRPrinter.Status <>mpBusy) then
        begin
         { if PrinterSetup(RptForm.qrMain) then
          begin
            RptForm.Repaint;
            Screen.Cursor:= crHourGlass;
            RptForm.qrMain.Print;
            Screen.Cursor:= crDefault;
          end}
        end
        else MessageDlg(CPRNnotReady,mtWarning,[mbOk],0)
end;

procedure TfmPreview.NavigatorClick(Sender:TObject);
begin
  with qrPreview do
    if Sender= spFirst then PageNumber:= 1
    else if Sender= spPrior then PageNumber:= PageNumber-1
    else if Sender= spNext then PageNumber:= PageNumber+1
    else if Sender= spLast then PageNumber:= qrPreview.QRPrinter.PageCount;
  UpdateStatusBar;
end;

procedure TfmPreview.bbCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmPreview.UpdateStatusBar;
begin
  paBottom.Caption:=
    Format('�������� %d �� %d ',[qrPreview.PageNumber,qrPreview.QRPrinter.PageCount]);
end;

procedure TfmPreview.qrPreviewProgressUpdate(Sender: TObject;
  Progress: Integer);
var Value : Integer;
begin
 inherited;
 Value := Progress;
 if RealRecCount = -1 then
   if (RptForm.qrMain.DataSet is TVASUPQuery)
      and not TVASUPQuery(RptForm.qrMain.DataSet).QueryAllRecords then
      RealRecCount := TVASUPQuery(RptForm.qrMain.DataSet).SQLRecordCount
   else RealRecCount:= RptForm.qrMain.DataSet.RecordCount;
 if RealRecCount <> 0
  then Value := (Longint(RptForm.qrMain.DataSet.RecNo) * 100) div RealRecCount;
 with ProgressBar do
  begin
   Position := Value;
   Visible := (Position > 0) and (Position < 100);
  end;
 if Value >= 100 then RealRecCount := -1;
end;

procedure TfmPreview.FormDestroy(Sender: TObject);
begin
  RptForm.PreviewForm:= nil;
end;

function TfmPreview.GetRptForm: TfrAnyReport;
begin
  Result:= Owner as TfrAnyReport;
end;

end.
