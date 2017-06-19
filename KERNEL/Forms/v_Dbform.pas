unit v_Dbform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ExtCtrls,v_Child, v_anyform;

type
  TfmDatabaseForm = class(TfmChild)
  private
    { Private declarations }
  protected
  public
    { Public declarations }
  end;

var
  fmDatabaseForm: TfmDatabaseForm;

implementation

{$R *.DFM}

end.
