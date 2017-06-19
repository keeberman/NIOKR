unit v_prnsh_c;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_prnshld, StdCtrls, Buttons, ExtCtrls;

type
  TfmPrintShld = class(TfmPrintShield)
  {����� ��� ������ ������� � ������������.
   ������������ ��� ������ ������������}
    laCriteria: TLabel;
    edCriteria: TEdit;
    procedure bbOkClick(Sender: TObject);
              {���������� ������� ������ bbOk.
              ��������� ������ ������}

    procedure bbPreviewClick(Sender: TObject);
              {���������� ������� ������ bbPreview.
              ��������� ��������������� �������� ������}

    procedure edCriteriaEnter(Sender: TObject);
              {���������� ������� OnEnter ����������
              edCriteria. ����������� ��������� ���������� �� �������,
              �������������� �������� ������� ���������}

    procedure edCriteriaExit(Sender: TObject);
              {���������� ������� OnExit ����������
              edCriteria. ��������������� ��������� ���������� ��
              ����������� ���������� edCriteriaEnter}
  private
    FCurKL: HKL;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPrintShld: TfmPrintShld;

implementation
uses vdbASUP;
{$R *.DFM}

procedure TfmPrintShld.bbOkClick(Sender: TObject);
begin
  RptForm.qlCriteria.Caption:= edCriteria.Text;
  inherited;
end;

procedure TfmPrintShld.bbPreviewClick(Sender: TObject);
begin
  RptForm.qlCriteria.Caption:= edCriteria.Text;
  inherited;
end;

procedure TfmPrintShld.edCriteriaEnter(Sender: TObject);
begin
  ReplaceKeyboardLayOut(FCurKL,CyrLayOut);
end;

procedure TfmPrintShld.edCriteriaExit(Sender: TObject);
begin
  ActivateKeyboardLayout(FCurKL,0);
end;

end.
