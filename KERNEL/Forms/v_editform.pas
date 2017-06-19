unit v_editform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_DBFORM, StdCtrls, Buttons, DBCtrls, ExtCtrls;

const
 KeyReturn= #13;

type
  TfmEditForm = class(TfmDatabaseForm)
    paBottomMiddle: TPanel;
    paRightMiddle: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEditForm: TfmEditForm;

implementation

{$R *.DFM}

end.
