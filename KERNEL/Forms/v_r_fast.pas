unit r_fast;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyreprt, vDbASUP, Db, Qrctrls, quickrpt, ExtCtrls,comctrls,printers;

type

  TfrFast = class(TfrAnyReport)
    qlCountCap: TQRLabel;
    qlCount: TQRLabel;
    procedure qrMainBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    FLastQRBand: TQRCustomBand;
    procedure AddMasterField(ANode: TTreeNode; Bold: boolean);
    procedure AddSubField(SubBand: TQRSubDetail;ANode: TTreeNode);
  public
    { Public declarations }
    procedure BuildMasterList( MasterNode: TTreeNode;
                               BoldFields: Array of TField);
    procedure BuildSubList(TableNode: TTreeNode);
    procedure SubDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
  end;

function Max(Val1,Val2:Integer): Integer;

var
  frFast: TfrFast;

implementation

{$R *.DFM}
uses QRPrntr;

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

procedure TfrFast.AddMasterField(ANode: TTreeNode; Bold: boolean);
var
  aLabel: TQRLabel;
  PixelWidth: Integer;
  aText: TQRDBText;
  aField: TField;
begin
  aField:= TField(ANode.Data);
  aLabel:= TQRLabel(qrMain.Bands.ColumnHeaderBand.AddPrintable(TQRLabel));
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

procedure TfrFast.AddSubField(SubBand: TQRSubDetail;ANode: TTreeNode);
var
  aLabel: TQRLabel;
  PixelWidth: Integer;
  aText: TQRDBText;
  aField: TField;
begin
  aField:= TField(ANode.Data);
  aLabel:= TQRLabel(SubBand.HeaderBand.AddPrintable(TQRLabel));
  aLabel.AutoSize:= true;
  aLabel.Font:= SubBand.Font;
  aLabel.Caption:= Dup('X',Integer(ANode.GetFirstChild.Data));
  PixelWidth:= aLabel.Width;
  aLabel.AutoSize:= false;
  aLabel.ParentFont:= true;
  aLabel.Font.Style:= [fsItalic];
  aLabel.Caption:= ANode.Text;
  aLabel.Alignment:= taCenter;
  aText:= TQRDBText(SubBand.AddPrintable(TQRDBText));
  aText.AutoSize:= false;
  if (aField is TStringField) or (aField is TMemoField) then
    aText.AutoStretch:= true;
  aText.WordWrap:= true;
  aText.DataSet:= aField.DataSet;
  aText.DataField:= aField.FieldName;
  aText.Left:= aLabel.Left;
  aText.Width:= PixelWidth;
  aText.Alignment:= aField.Alignment;
  aText.Frame.DrawTop:= true;
  aText.Frame.Style:= psInsideFrame;
  if (aText.Left + aText.Width >SubBand.Width) and
     (qrMain.page.Orientation = poPortrait) then
     qrMain.page.Orientation := poLandscape;
  if aText.Left + aText.Width > SubBand.Width then
  begin
    aLabel.Free;
    aText.Free;
  end;
end;

function InArray(Area: Array of TField; Piece: TField):boolean;
var
  I: Integer;
begin
  Result:= false;
  I:= Low(Area);
  while (I<=High(Area)) and not Result do
  begin
    Result:= Area[I]= Piece;
    Inc(I);
  end;
end;

procedure TfrFast.BuildMasterList( MasterNode: TTreeNode;
                                   BoldFields: Array of TField);
var
  Child: TTreeNode;
begin
  Child:= MasterNode.GetFirstChild;
  while Assigned(Child) do
  begin
    AddMasterField(Child,Inarray(BoldFields,TField(Child.Data)));
    Child:= MasterNode.GetNextChild(Child);
  end;
  FLastQRBand:= Detail;
end;

procedure TfrFast.qrMainBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  qlCount.Caption:= InttoStr(qrMain.DataSet.RecordCount);
end;

procedure TfrFast.SubDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Sender is TQRSubDetail then
    PrintBand:= not (Sender as TQRSubDetail).DataSet.IsEmpty
  else PrintBand:=
    not TQRSubDetail((Sender as TQRCustomBand).Owner).DataSet.IsEmpty;
end;

procedure TfrFast.BuildSubList(TableNode: TTreeNode);
var
  Child: TTreeNode;
  SubDetail: TQRSubDetail;
begin
  SubDetail:= TQRSubDetail.Create(qrMain);
  with SubDetail do
  begin
    DataSet:= TVASUPQuery(TableNode.Data);
    SubDetail.BeforePrint:= SubDetailBeforePrint;
    SubDetail.Parent:= qrMain;
    SubDetail.Font:= qrMain.Bands.DetailBand.Font;
    if TableNode.StateIndex>0 then
      TVASUPQuery(DataSet).Execute
    else if not DataSet.Active then DataSet.Open;
    Master:= qrMain.Bands.DetailBand;
    Left:= qrMain.Bands.DetailBand.Left;
    Height:= qrMain.Bands.DetailBand.Height;
    Width:= qrMain.Bands.DetailBand.Width;
    {Frame.DrawBottom:= true;
    Frame.Style:= psInsideFrame;}
    HeaderBand:= TQRBand.Create(SubDetail);
    HeaderBand.BeforePrint:= SubDetailBeforePrint;
    HeaderBand.Parent:= qrMain;
    HeaderBand.BandType:= rbGroupHeader;
    HeaderBand.Font:= qrMain.Bands.ColumnHeaderBand.Font;
    HeaderBand.Height:= Height;
    HeaderBand.Width:= Width;
    FooterBand:= TQRBand.Create(SubDetail);
    FooterBand.BeforePrint:= SubDetailBeforePrint;
    FooterBand.Parent:= qrMain;
    FooterBand.BandType:= rbGroupFooter;
    FooterBand.Height:=Height div 2;
    FooterBand.Width:= Width;
    with TQRLabel(HeaderBand.AddPrintable(TQRLabel)) do
    begin
      AutoSize:= true;
      Caption:= Concat(TableNode.Text,':');
    end;
    {with  do
    begin
      AutoSize:= true;
      Caption:= 'Всего строк: ';
    end;
    with TQRLabel(FooterBand.AddPrintable(TQRLabel)) do
    begin
      AutoSize:= true;
      Caption:= '';
    end;}
  end;
  FLastQRBand:= SubDetail;
  Child:= TableNode.GetFirstChild;
  while Assigned(Child) do
  begin
    AddSubField(SubDetail,Child);
    Child:= TableNode.GetNextChild(Child);
  end;

end;

end.
