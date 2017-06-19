program niokr;

uses
  Forms,
  Controls,
  Windows,
  SysUtils,
  v_anyform in 'kernel\forms\v_anyform.pas' {fmAnyForm},
  v_Dbform in 'kernel\forms\v_Dbform.pas' {fmDatabaseForm},
  v_editform in 'kernel\forms\v_editform.pas' {fmEditForm},
  v_cgrdform in 'kernel\forms\v_cgrdform.pas' {fmControlGridForm},
  vworkform in 'kernel\forms\vworkform.pas' {fmWorkForm},
  v_gridform in 'kernel\forms\v_Gridform.pas' {fmGridForm},
  v_explorer in 'kernel\forms\v_explorer.pas' {fmExplorer},
  v_enter in 'kernel\forms\v_enter.pas' {fmEnter},
  v_child in 'kernel\forms\v_child.pas' {fmChild},
  v_Nsiform in 'kernel\forms\v_Nsiform.pas' {fmNSI},
  MENUGnrl in 'Major\MENUGnrl.pas' {fmMainMenu},
  vpodr in 'Editor\vpodr.pas' {fmExpPodr},
  globals in 'Major\globals.pas' {dmGlobal: TDataModule},
  v_eyes in 'kernel\comps\v_Eyes.pas' {fmSearch},
  v_srch in 'kernel\forms\v_srch.pas' {fmSearchList},
  about in 'Major\about.pas' {fmAboutBox},
  v_Duserpw in 'kernel\forms\v_Duserpw.pas' {fmUserPassword},
  v_edarch in 'kernel\forms\v_edarch.pas' {fmExpArchive},
  v_qumod in 'kernel\forms\v_qumod.pas' {dmRptQuery: TDataModule},
  v_fastrep in 'kernel\forms\v_fastrep.pas' {fmFastRep},
  v_repdet in 'kernel\forms\v_repdet.pas' {fmRepDetails},
  v_rptopen in 'kernel\forms\v_rptopen.pas' {fmRepOpenDialog},
  v_savqmod in 'kernel\forms\v_savqmod.pas' {dmSaveRptQuery: TDataModule},
  v_fastmod in 'kernel\forms\v_fastmod.pas' {dmFastReport: TDataModule},
  v_aboutb in 'kernel\forms\v_aboutb.pas' {fmAboutBoxBase},
  v_anyfrep in 'kernel\forms\v_anyfrep.pas' {fmAnyFRep},
  v_stdfrep in 'kernel\forms\v_stdfrep.pas' {fmStdFRep},
  v_stdr20 in 'kernel\forms\v_stdr20.pas' {fmStdFRep20},
  v_stdr2c in 'kernel\forms\v_stdr2c.pas' {fmStdFRep2c},
  v_prndlgc in 'kernel\forms\v_prndlgc.pas' {fmPrnDlgCom},
  v_fast in 'kernel\forms\v_fast.pas' {fmFastRpt},
  v_exprpt0 in 'kernel\forms\v_exprpt0.pas' {fmExpRpt0},
  chapter in 'Editor\chapter.pas' {fmChapter},
  wcurrency in 'Editor\wcurrency.pas' {fmCurrency},
  vwtree in 'kernel\forms\vwtree.pas' {fmTreeTopology},
  wfirm in 'Editor\wfirm.pas' {fmFirm},
  wpaymeth in 'Editor\wpaymeth.pas' {fmPayMethods},
  wistfin in 'Editor\wistfin.pas' {fmMiIstFin},
  wNSI2040 in 'Editor\wNSI2040.pas' {fmNSI2040},
  treatycard in 'Editor\treatycard.pas' {fmTreatyCard},
  ExecWord in 'KERNEL\Units\EXECWORD.PAS',
  pmonth in 'KERNEL\Forms\pmonth.pas' {fmPickMonth},
  v_pyear in 'KERNEL\Forms\v_pyear.pas' {fmPickYear},
  v_pquarter in 'KERNEL\Forms\v_pquarter.pas' {fmPickQuarter},
  v_pyears in 'KERNEL\Forms\v_pyears.pas' {fmPickFromYearToYear},
  repCurrotList in 'Editor\repCurrotList.pas' {fmCurratorList},
  v_repList in 'KERNEL\Forms\v_repList.pas' {fmRepList},
  wtrconcern in 'Editor\wtrconcern.pas' {fmTRConcern},
  wEconParam in 'Editor\wEconParam.pas' {fmEconomicParameter},
  v_ASUPForm in 'kernel\forms\v_ASUPForm.pas' {fmASUPForm},
  PickConcernDog in 'kernel\forms\PickConcernDog.pas' {fmPickConcernDog},
  pmonthwithaddCol in 'kernel\forms\pmonthwithaddCol.pas' {fmPickMonthWithAddColumn},
  Thread in 'Thread\Thread.pas',
  fCoping in 'Dlg\fCoping.pas' {frmCoping},
  pmonth_from_to in 'KERNEL\Forms\pmonth_from_to.pas' {fmPickMonth_From_TO},
  v_utils in 'KERNEL\Comps\v_utils.pas',
  ExecRep in 'Major\ExecRep.pas',
  wExchange in 'Editor\wExchange.pas' {fmExchange},
  v_frxLetter in 'KERNEL\Forms\v_frxLetter.pas' {frmPrintFrxLetter};

{$R *.RES}

const
  SemaphoreName= 'SOFTWARE_BELARUSKALI_NIOKR';

begin
  CreateSemaphore(nil,0,1,SemaphoreName);
  if GetLastError = ERROR_ALREADY_EXISTS then Halt(1);
  Application.Initialize;
  dmGlobal:= TdmGlobal.Create(nil);
  fmEnter:= TfmEnter.Create(nil);
  fmEnter.OraSession:= dmGlobal.seOracle;
  if fmEnter.ShowModal=mrOK then
  begin
    Application.Title := 'АРМ "Ведение договоров по НИОКР"';
  Application.CreateForm(TfmMainMenu, fmMainMenu);
    Application.Run;
  end
  else Application.Terminate;
end.
