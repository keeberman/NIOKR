unit chapter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_Nsiform, vDbASUP, Menus, Db, StdCtrls, Buttons, Mask, ExtCtrls;

type
  TfmChapter = class(TfmNSI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmChapter: TfmChapter;

implementation
{$R *.DFM}

initialization
  RegisterClass(TfmChapter);

finalization
  UnregisterClass(TfmChapter);
end.
