unit v_prndlgc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_prndlg, StdCtrls, Buttons, ExtCtrls;

type
  TfmPrnDlgCom = class(TfmPrintDialog)
    laCriteria: TLabel;
    edCriteria: TEdit;
    procedure edCriteriaEnter(Sender: TObject);
    procedure edCriteriaExit(Sender: TObject);
    procedure bbPreviewClick(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
  private
    { Private declarations }
    FCurKL: HKL;
  public
    { Public declarations }
  end;

var
  fmPrnDlgCom: TfmPrnDlgCom;

implementation
uses vdbASUP;
{$R *.DFM}

procedure TfmPrnDlgCom.edCriteriaEnter(Sender: TObject);
begin
  ReplaceKeyboardLayOut(FCurKL,CyrLayout);
end;

procedure TfmPrnDlgCom.edCriteriaExit(Sender: TObject);
begin
  ActivateKeyboardLayout(FCurKL,0);
end;

procedure TfmPrnDlgCom.bbPreviewClick(Sender: TObject);
begin
//  RptForm.frReport.Pages[0].FindObject('meCriteria').Memo.Text:= edCriteria.Text;
  inherited;
end;

procedure TfmPrnDlgCom.bbOkClick(Sender: TObject);
begin
//  RptForm.frReport.Pages[0].FindObject('meCriteria').Memo.Text:= edCriteria.Text;
  inherited;
end;

end.
