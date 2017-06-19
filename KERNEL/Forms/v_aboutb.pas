unit v_aboutb;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TfmAboutBoxBase = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    laVersion: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    City: TLabel;
    email: TLabel;
    laDate: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAboutBoxBase: TfmAboutBoxBase;

implementation
{$R *.DFM}

uses rxverinf;

procedure TfmAboutBoxBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfmAboutBoxBase.FormCreate(Sender: TObject);
begin
  with TVersionInfo.Create(Application.ExeName) do
  begin
    laVersion.Caption:= Concat(laVersion.Caption,FileVersion);
    laDate.Caption:= Concat( laDate.Caption,
                     FormatDateTime('dd.mm.yyyy hh:nn',VerFileDate));
    Free;
  end;
end;

end.

