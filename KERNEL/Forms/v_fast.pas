unit v_fast;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyfrep, Db, FR_DSet, FR_DBSet, FR_Class, ExtCtrls, comctrls, FR_E_TXT,
  frxExportText, frxExportXLS, frxClass, frxExportPDF, frxDBSet;

const
  OffSetX= 2;
  OffSetY= 2;

type
  TfmFastRpt = class(TfmAnyFRep)
    frReport: TfrReport;
    frDBDataSet: TfrDBDataSet;
    frTextExport1: TfrTextExport;
    procedure FormCreate(Sender: TObject);
    procedure ComplexOpen(Sender: TObject);
  private
    { Private declarations }
    FMasterLeft: Integer;
    FDetailLeft: Integer;
    FDetailTop: Integer;
    FLastDetail: TfrBandView;
    FLastDetailHeader: TfrBandView;
    FLastDataSource: TDataSource;
  public
    { Public declarations }
    procedure AddMasterField(ANode: TTreeNode; Bold: boolean);
    procedure AddSubField(ANode: TTreeNode);
    procedure BuildMasterList( MasterNode: TTreeNode;
                                BoldFields: Array of TField);
    procedure BuildSubList(TableNode: TTreeNode);
  end;

var
  fmFastRpt: TfmFastRpt;

function Max(Val1,Val2:Integer): Integer;

implementation

uses printers, oracledata, vdbASUP;

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

procedure TfmFastRpt.AddMasterField(ANode: TTreeNode; Bold: boolean);
var
  vl,vt: TfrMemoView;
  b: TfrBandView;
  Page: TfrPage;
  aField: TField;
  TypeLB: Integer;
  str_s: string;
begin
  aField:= TField(ANode.Data);

  Page := frReport.Pages[0];

  b:= Page.FindObject('MasterHeader') as TfrBandView ;

  vl := TfrMemoView.Create;             // create memo-label
  vl.Font.Style:= [fsUnderline];
  vl.Font.Name:= 'Courier New';
  vl.Font.Size:= 10;
  vl.dx:= vl.Font.Size*Integer(ANode.GetFirstChild.Data);
  vl.Prop['Stretched']:= True;
  vl.Alignment:= Ord(aField.Alignment);
  vl.dy:= b.dy;
  vl.Memo.Add(ANode.Text);
  Inc(FMasterLeft,OffSetX);
  vl.SetBounds(FMasterLeft, b.y, vl.dx, vl.dy);
  Inc(FMasterLeft,vl.dx);
  Page.Objects.Add(vl);

  b:= Page.FindObject('MasterData') as TfrBandView;

  vt := TfrMemoView.Create;             // create memo-db
  //vt.dx:= v.dx;
  vt.Prop['Stretched']:= True;
  //vt.Font.Name:= 'Courier New';
  vt.Alignment:= Ord(aField.Alignment);
  if Bold then vt.Font.Style:= [fsBold];
  vt.Font.Name:= 'Courier New';
  vt.Font.Size:= 10;
  vt.SetBounds(vl.x, b.y, vl.dx, vl.dy);
  str_s:= Format('[%s.%s.%s]',[
                dsReport.DataSet.Owner.Name,
                dsReport.DataSet.Name,
                aField.FieldName]
                );

  if aField is TDateTimeField then
  begin
    TypeLB:= 4;
    vt.Format:= 2 * $01000000 + TypeLB * $00010000 +
      2 * $00000100 + Ord(',');
    vt.FormatStr:= TDateTimeField(aField).DisplayFormat;
    vt.Script.Add('begin');
    vt.Script.Add(Format('if %s = 0 then memo:=%s else memo:=%0:s',[str_s,'''''']));
    vt.Script.Add('end');
  end
  else vt.Memo.Add(str_s);
  if aField is TNumericField then
  begin
    TypeLB:= 4;
    vt.Format:= 1 * $01000000 + TypeLB * $00010000 +
      2 * $00000100 + Ord(',');
    vt.FormatStr:= TNumericField(aField).DisplayFormat;
  end;

  with Page do
  begin
    Objects.Add(vt);
    if (vt.x + vt.dx > b.dx) and
       (pgOr = poPortrait) then
       ChangePaper(pgSize,pgWidth,pgHeight,pgBin,poLandscape);
    {if vt.x + vt.dx > pgWidth then
    begin
      Objects.Delete(Objects.Count-1);
      Objects.Delete(Objects.Count-1);
      vl.Free;
      vt.Free;
    end;}
  end;
end;

procedure TfmFastRpt.AddSubField(ANode: TTreeNode);
var
  vl,vt: TfrMemoView;
  b: TfrBandView;
  Page: TfrPage;
  aField: TField;
  TypeLB: Integer;
  str_s: string;
begin
  aField:= TField(ANode.Data);

  Page := frReport.Pages[0];

  b:= FLastDetailHeader;

  vl := TfrMemoView.Create;             // create memo-label
  vl.Font.Style:= [fsUnderline];
  vl.Font.Name:= 'Courier New';
  vl.Font.Size:= 10;
  vl.dx:= vl.Font.Size*Integer(ANode.GetFirstChild.Data);
  vl.Prop['Stretched']:= True;
  vl.Alignment:= Ord(aField.Alignment);
  vl.dy:= b.dy div 2;
  vl.Memo.Add(ANode.Text);
  Inc(FDetailLeft,OffSetX);
  vl.SetBounds(FDetailLeft, b.y + b.dy div 2, vl.dx, vl.dy);
  Inc(FDetailLeft,vl.dx);
  Page.Objects.Add(vl);

  b:= FLastDetail;

  vt := TfrMemoView.Create;             // create memo-db
  //vt.dx:= v.dx;
  vt.Prop['Stretched']:= True;
  //vt.Font.Name:= 'Courier New';
  vt.Alignment:= Ord(aField.Alignment);
  //if Bold then vt.Font.Style:= [fsBold];
  vt.Font.Name:= 'Courier New';
  vt.Font.Size:= 10;
  vt.SetBounds(vl.x, b.y, vl.dx, vl.dy);
  str_s:= Format('[%s.%s.%s]',[
                FLastDataSource.DataSet.Owner.Name,
                FLastDataSource.DataSet.Name,
                aField.FieldName]
                );

  if aField is TDateTimeField then
  begin
    TypeLB:= 4;
    vt.Format:= 2 * $01000000 + TypeLB * $00010000 +
      2 * $00000100 + Ord(',');
    vt.FormatStr:= TDateTimeField(aField).DisplayFormat;
    vt.Script.Add('begin');
    vt.Script.Add(Format('if %s = 0 then memo:=%s else memo:=%0:s',[str_s,'''''']));
    vt.Script.Add('end');
  end
  else vt.Memo.Add(str_s);
  if aField is TNumericField then
  begin
    TypeLB:= 4;
    vt.Format:= 1 * $01000000 + TypeLB * $00010000 +
      2 * $00000100 + Ord(',');
    vt.FormatStr:= TNumericField(aField).DisplayFormat;
  end;

  with Page do
  begin
    Objects.Add(vt);
    if (vt.x + vt.dx > b.dx) and
       (pgOr = poPortrait) then
       ChangePaper(pgSize,pgWidth,pgHeight,pgBin,poLandscape);
    if vt.x + vt.dx > pgWidth then
    begin
      Objects.Delete(Objects.Count-1);
      Objects.Delete(Objects.Count-1);
      vl.Free;
      vt.Free;
    end;
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

procedure TfmFastRpt.BuildMasterList( MasterNode: TTreeNode;
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
end;

procedure TfmFastRpt.FormCreate(Sender: TObject);
var
  mb: TfrView;
begin
  inherited;
  FMasterLeft:= frReport.Pages[0].pgMargins.Left;
  //FSubDetailLeft:= FMasterLeft;
  mb:= frReport.Pages[0].FindObject('MasterData');
  FDetailTop:= mb.y + mb.dy;
end;

procedure TfmFastRpt.BuildSubList(TableNode: TTreeNode);
var
  Child: TTreeNode;
  Page: TfrPage;
  bh,bd: TfrBandView;
  mh,md: TfrBandView;
  v: TfrMemoView;
  ds: TDataSource;
  rds: TfrDBDataSet;
  IsSubDetail: bool;
begin
  FDetailLeft:= frReport.Pages[0].pgMargins.Left;

  IsSubDetail:= (TDataSet(TableNode.Data) is TOracleDataSet) and
     (TOracleDataSet(TableNode.Data).Master<> dsReport.DataSet);

  bh:= TfrBandView.Create; // detail header

  Page := frReport.Pages[0];
  mh:= Page.FindObject('MasterHeader') as TfrBandView;
  with bh do
  begin
    Name:= 'Header_'+TDataSet(TableNode.Data).Name;
    if IsSubDetail then
      BandType:= btSubDetailHeader
    else BandType:= btDetailHeader;
    x:= mh.x;
    dx:= mh.dx;
    y:= FDetailTop+OffSetY;
    dy:= 2*mh.dy;
    FDetailTop:= y+dy;
    //Prop['RepeatHeader']:= True;
    Prop['Stretched']:= True;
  end;
  Page.Objects.Add(bh);

  // detail caption
  v := TfrMemoView.Create;
  v.Font.Style:= [fsItalic];
  v.Prop['AutoWidth']:= True;
  v.y:= bh.y;
  v.dy:= bh.dy div 2;
  v.SetBounds(FDetailLeft, bh.y, v.dx, bh.dy div 2);
  v.Memo.Add(TableNode.Text);
//  v.BandAlign:= baLeft;
  Page.Objects.Add(v);

  ds:= TDataSource.Create(Self);
  ds.DataSet:= TDataSet(TableNode.Data);
  rds:= TfrDBDataSet.Create(Self);
  rds.Name:= 'r_'+ds.DataSet.Name;
  rds.DataSource:= ds;
  rds.OnOpen:= ComplexOpen;
  rds.OpenDataSource:= TableNode.StateIndex<=0;
  FLastDataSource:= ds;
  if ds.DataSet is TOracleDataSet then
   TOracleDataSet(ds.DataSet).ForceMasterSynchronization:= true;
  ds.DataSet.DisableControls;

  md:= Page.FindObject('MasterData') as TfrBandView;
  bd:= TfrBandView.Create; // detail data
  with bd do
  begin
    Name:= 'Data_'+TDataSet(TableNode.Data).Name;
    if IsSubDetail then
      BandType:= btSubDetailData
    else BandType:= btDetailData;
    x:= md.x;
    dx:= md.dx;
    y:= FDetailTop+OffSetY;
    dy:= md.dy;
    FDetailTop:= y+dy;
    DataSet:= rds.Name;
    Prop['Stretched']:= True;
  end;
  Page.Objects.Add(bd);

  FLastDetailHeader:= bh;
  FLastDetail:= bd;

  Child:= TableNode.GetFirstChild;
  while Assigned(Child) do
  begin
    AddSubField(Child);
    Child:= TableNode.GetNextChild(Child);
  end;
end;

procedure TfmFastRpt.ComplexOpen(Sender: TObject);
begin
  with Sender as TfrDBDataSet do
    if not OpenDataSource then
    with (DataSource.DataSet as TVASUPQuery) do
    begin
      QueryLibrary.Last;
      QueryLibrary.Prior;
      Execute;
    end;
end;

end.
