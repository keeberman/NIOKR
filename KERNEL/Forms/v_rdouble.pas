unit v_rdouble;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyreprt, Qrctrls, quickrpt, vDbASUP, Db, ExtCtrls;

type
  TfrDoubleLink = class(TfrAnyReport)
    grfSub1: TQRBand;
    qtCode: TQRDBText;
    qtShort: TQRDBText;
    qtFull: TQRDBText;
    QRLabel8: TQRLabel;
    qlSub1Count: TQRLabel;
    qlCountCap: TQRLabel;
    qlCount: TQRLabel;
    qlShort2: TQRLabel;
    SubDet1: TQRSubDetail;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    GroupHeaderBand1: TQRBand;
    QRLabel4: TQRLabel;
    procedure grfSub1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SummaryBandBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure DetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrMainBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FMaster: TVASUPQuery;
    FDetail: TVASUPQuery;
    FMasterCount: Integer;
    procedure ReplaceDataSets;
  public
    { Public declarations }
  end;

var
  frDoubleLink: TfrDoubleLink;

implementation

{$R *.DFM}
procedure TfrDoubleLink.grfSub1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qlSub1Count.Caption:= IntToStr(SubDet1.DataSet.RecordCount);
end;

procedure TfrDoubleLink.SummaryBandBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qlCount.Caption:= IntToStr(FMasterCount);
end;

procedure TfrDoubleLink.DetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PrintBand:= not SubDet1.DataSet.IsEmpty;
  if PrintBand then Inc(FMasterCount);
end;

procedure TfrDoubleLink.ReplaceDataSets;
var
  I: Integer;
begin
  FMaster.Assign(qrMain.DataSet);
  FDetail.Assign(SubDet1.DataSet);
  CreateFieldTemplates(qrMain.DataSet,FMaster);
  CreateFieldTemplates(SubDet1.DataSet,FDetail);
  FMaster.Open;
  FDetail.Open;
  qrMain.DataSet:= FMaster;
  SubDet1.DataSet:= FDetail;
  for I:= 0 to ComponentCount-1 do
    if (Components[I] is TQRDBText) and not Assigned(TQRDBText(Components[I]).DataSet)  then
       if TQRDBText(Components[I]).Parent=Detail then
          TQRDBText(Components[I]).DataSet:= qrMain.DataSet
       else if TQRDBText(Components[I]).Parent=SubDet1 then
          TQRDBText(Components[I]).DataSet:= SubDet1.DataSet;
end;

procedure TfrDoubleLink.qrMainBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  FMasterCount:= 0;
end;

procedure TfrDoubleLink.FormCreate(Sender: TObject);
begin
  inherited;
  FMaster:= TVASUPQuery.Create(Self);
  FDetail:= TVASUPQuery.Create(Self);
  FDetail.Master:= FMaster;
  ReplaceDataSets;
end;

procedure TfrDoubleLink.FormDestroy(Sender: TObject);
begin
  FDetail.Free;
  FMaster.Free;
  inherited;
end;

end.
