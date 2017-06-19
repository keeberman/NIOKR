unit v_longp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TfmLongProc = class(TForm)
    stMain: TStaticText;
    procedure SetText(const Value: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLongProc: TfmLongProc;

implementation

{$R *.DFM}

procedure TfmLongProc.SetText( const Value: string);
begin
  stMain.Caption:= Value;
  stMain.Repaint;
end;

end.
