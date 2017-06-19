unit v_sqldesc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vdbasup, ExtCtrls;

const
  SNoSQLText= ' условие не задано';

type
  TfmSQLDescript = class(TForm)
    paMain: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FCaller: TForm;
    FClosing: bool;
    procedure SetCaller(ACaller: TForm);
    procedure OutputSQL(AParent:TWinControl;SQLDesc: TTreeSQLDescription);
  public
    { Public declarations }
    procedure ShowSQL(SQLDesc: TTreeSQLDescription);
    property Caller:TForm read FCaller write SetCaller;
    property Closing:bool read FClosing;
  end;

var
  fmSQLDescript: TfmSQLDescript;

implementation
uses stdctrls;
{$R *.DFM}

function FindControl(AControl: TWinControl;ClassRef: TClass): TControl;
var
  I: Integer;
begin
  I:= AControl.ControlCount-1;
  Result:= nil;
  with AControl do
    while (I>=0) and (Result=nil) do
    begin
      if Controls[I] is ClassRef then
        Result:= Controls[I];
      Dec(I);
    end;

end;


procedure TfmSQLDescript.OutPutSQL(AParent:TWinControl;SQLDesc: TTreeSQLDescription);
var
  I: Integer;
  NewParent: TGroupBox;
begin
  NewParent:= TGroupBox.Create(AParent);
  with NewParent do
  begin
    Parent:= AParent;
    Caption:= Concat(Lpad('',2*Parent.Tag,' '),SQLDesc.Caption);
    Font.Style:= Font.Style+[fsBold];
    Align:= alTop;
    Tag:= Parent.Tag + 1
  end;

  with TMemo.Create(NewParent) do
  begin
    ParentFont:= false;
    Parent:= NewParent;
    Align:= alTop;
    Color:= clBtnFace;
    BorderStyle:= bsNone;
    ReadOnly:= True;
    Lines.Add(SQLDesc.Text);
    if Length(Lines[0])=0 then
      Lines[0]:= SNoSQLText;
    if CaretPos.Y=0 then
      Height:= abs(Font.Height)+2
    else Height:= CaretPos.Y*(abs(Font.Height)+2);
    NewParent.ClientHeight:= Top+Height+5;
    Align:= alNone;
  end;

  for I:= SQLDesc.Count-1 downto 0 do
  begin
    OutPutSQL(NewParent,SQLDesc[I]);
    NewParent.ClientHeight:= NewParent.ClientHeight+
      FindControl(NewParent,TGroupBox).Height;
  end;
  FindControl(NewParent,TMemo).Align:= alTop;
end;

procedure TfmSQLDescript.ShowSQL(SQLDesc: TTreeSQLDescription);
var
  I: Integer;
  gb: TControl;
begin
  if Visible then
  begin
    {IsEnabled:= Enabled;
    Enabled:= false;}
     with paMain do
      for I:= ComponentCount-1 downto 0 do Components[I].Free;
 //   paMain.Enabled:= True;
    OutPutSQL(paMain,SQLDesc);
 //   paMain.Enabled:= False;
    gb:= FindControl(paMain,TGroupBox);
    if Assigned(gb) then
      if ClientHeight<>gb.Height then
      begin
        Top:= Top+(ClientHeight-gb.Height);
        ClientHeight:= gb.Height;
      end;
    if paMain.ComponentCount=0 then
      with TLabel.Create(Self) do
      begin
        Parent:= paMain;
        Align:= alTop;
        Text:= SNoSQLText;
      end;
    //Enabled:= IsEnabled;
  end;
end;

procedure TfmSQLDescript.SetCaller(ACaller: TForm);
begin
  if (FCaller=nil) or (ACaller=nil) or not Visible then FCaller:= ACaller;
end;

procedure TfmSQLDescript.FormShow(Sender: TObject);
begin
  Left:= Application.MainForm.ClientWidth - Width - 10;
  Top:= Application.MainForm.ClientHeight - Height - 10;
  FClosing:= false;
  {if Assigned(FCaller) then
    FCaller.SetFocusedControl(FCaller.ActiveControl);}
end;

procedure TfmSQLDescript.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FClosing:= true;
  FCaller:= nil;
end;

initialization
  fmSQLDescript:= TfmSQLDescript.Create(nil);
finalization
  fmSQLDescript.Free;
end.
