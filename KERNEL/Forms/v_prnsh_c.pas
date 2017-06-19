unit v_prnsh_c;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_prnshld, StdCtrls, Buttons, ExtCtrls;

type
  TfmPrintShld = class(TfmPrintShield)
  {Форма для печати отчетов с комментарием.
   Используется для печати справочников}
    laCriteria: TLabel;
    edCriteria: TEdit;
    procedure bbOkClick(Sender: TObject);
              {Обработчик нажатия кнопки bbOk.
              Запускает печать отчета}

    procedure bbPreviewClick(Sender: TObject);
              {Обработчик нажатия кнопки bbPreview.
              Запускает предварительный просмотр отчета}

    procedure edCriteriaEnter(Sender: TObject);
              {Обработчик события OnEnter компонента
              edCriteria. Переключает раскладку клавиатуры на русскую,
              предварительно сохранив текущую раскладку}

    procedure edCriteriaExit(Sender: TObject);
              {Обработчик события OnExit компонента
              edCriteria. Восстанавливает раскладку клавиатуры на
              сохраненную процедурой edCriteriaEnter}
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
