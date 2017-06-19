unit v_nsirep2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_NsiRep, vDbASUP, Db, Qrctrls, quickrpt, ExtCtrls;

type
  TfrNSIRep2 = class(TfrNSIReport)
  {Форма-контейнер отчета по
  стандартным справочникам: KOD,SNAIM,PNAIM.
  Отчет формируется в две колонки. Используется для справочников
  с короткими полными наименованиями}
  
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frNSIRep2: TfrNSIRep2;

implementation

{$R *.DFM}

initialization
  RegisterClass(TfrNSIRep2);

finalization
  UnregisterClass(TfrNSIRep2);
end.
