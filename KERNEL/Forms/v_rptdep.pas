unit v_rptdep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_NsiRep, quickrpt, Db, Qrctrls, ExtCtrls, vDbASUP;

type
  TfrMipodr = class(TfrNSIReport)
  {Форма-контейнер отчета по справочнику подразделений.
   Главная запись- цех; Подчиненная запись-участки,бригады и т.д.}

    SubDetail: TQRSubDetail;
    gfbSub: TQRBand;
    ghbSub: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    qtSubCode: TQRDBText;
    qtSubShort: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel10: TQRLabel;
    qlSubCount: TQRLabel;
    dsSubDetail: TDataSource;
    procedure qrMainBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
      //Обработчик события BeforePrint компонента qrMain

    procedure SubDetailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
      //Обработчик события BeforePrint полосы SubDetail

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frMipodr: TfrMipodr;

implementation

{$R *.DFM}

procedure TfrMipodr.qrMainBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  I: Integer;
begin
  inherited;
  for I:= 0 to ComponentCount-1 do
    if Components[I] is TQRDBText and (TQRDBText(Components[I]).Parent=SubDetail) and
    not Assigned(TQRDBText(Components[I]).DataSet) then
      TQRDBText(Components[I]).DataSet:= dsSubDetail.DataSet;
  SubDetail.DataSet:= dsSubDetail.DataSet;
end;

procedure TfrMipodr.SubDetailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PrintBand:= not SubDetail.DataSet.IsEmpty;
  if PrintBand then
    qlSubCount.Caption:= IntToStr(SubDetail.DataSet.RecordCount);
end;

initialization
  RegisterClass(TfrMipodr);

finalization
  UnregisterClass(TfrMipodr);

end.
