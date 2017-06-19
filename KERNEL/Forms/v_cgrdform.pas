unit v_cgrdform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_EDITFORM, DBCGrids, Buttons, DBCtrls, StdCtrls, ExtCtrls;

type
  TfmControlGridForm = class(TfmEditForm)
                     {Форма-предок с многострочной сеткой типа
                     TDBCtrlGrid. Используется для отображения
                     нескольких записей с полным составом их
                     реквизитов}
                     
    DBCtrlGrid: TDBCtrlGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmControlGridForm: TfmControlGridForm;

implementation

{$R *.DFM}

end.
