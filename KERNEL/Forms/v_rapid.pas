unit v_rapid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyrep, vDbASUP, Db, ppDB, ppDBPipe, ppBands, ppVar, ppPrnabl, ppClass,
  ppCtrls, ppCache, ppComm, ppRelatv, ppProd, ppReport, ExtCtrls,
  comctrls;

type
  TfmRapidRep = class(TfmAnyRep)
    ppSummaryBand1: TppSummaryBand;
    ppCountLine: TppLine;
    ppLabel6: TppLabel;
    ppVarCount: TppVariable;
  private
    { Private declarations }
    procedure AddMasterField(ANode: TTreeNode; Bold: boolean);
  public
    { Public declarations }
  end;

var
  fmRapidRep: TfmRapidRep;

implementation

{$R *.DFM}

function Dup(Val:Char;Count:Integer):String;
var
  I: Integer;
begin
  Result:= '';
  for I:= 1 to Count do
    Result:= Concat(Result,Val);
end;

function Max(Val1,Val2:Integer): Integer;
begin
  if Val1<Val2 then Result:= Val2
  else Result:= Val1;
end;

procedure TfmRapidRep.AddMasterField(ANode: TTreeNode; Bold: boolean);
var
  aLabel: TppLabel;
  PixelWidth: Integer;
  aText: TppDBText;
  aField: TField;
begin
  aField:= TField(ANode.Data);
  aLabel:= TppLabel.Create(Self);
  aLabel.Band
  ppHeaderBand. AddPrintable(TQRLabel));
  aLabel.AutoSize:= true;
  aLabel.Font:= Detail.Font;
  aLabel.Caption:= Dup('X',Integer(ANode.GetFirstChild.Data));
  PixelWidth:= aLabel.Width;
  aLabel.AutoSize:= false;
  aLabel.ParentFont:= true;
  aLabel.Caption:= ANode.Text;
  aLabel.Alignment:= taCenter;
  aLabel.Frame.DrawBottom:= true;
  aText:= TQRDBText(qrMain.Bands.DetailBand.AddPrintable(TQRDBText));
  aText.AutoSize:= false;
  if (aField is TStringField) or (aField is TMemoField) then
    aText.AutoStretch:= true;
  aText.WordWrap:= true;
  aText.DataSet:= aField.DataSet;
  aText.DataField:= aField.FieldName;
  aText.Left:= aLabel.Left;
  aText.Width:= PixelWidth;
  aText.Alignment:= aField.Alignment;
  if Bold then aText.Font.Style:= [fsBold];
  if (aText.Left + aText.Width > qrMain.Bands.DetailBand.Width) and
     (qrMain.page.Orientation = poPortrait) then
     qrMain.page.Orientation := poLandscape;
  if aText.Left + aText.Width > qrMain.Bands.DetailBand.Width then
  begin
    aLabel.Free;
    aText.Free;
  end;
end;

end.
