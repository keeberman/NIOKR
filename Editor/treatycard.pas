unit treatycard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vwtree, ImgList, vDbASUP, Menus, Db, StdCtrls, Buttons, TB97, TB97Tlbr,
  ComCtrls, Grids, DBGrids, RXDBCtrl, ExtCtrls, Mask, DBCtrls,Oracle,
  ToolEdit, vpodr, MENUGnrl, v_anyform, Excel97, OleServer, RXCtrls, Variants;

type
  TfmTreatyCard = class(TfmTreeTopology)
    tsTreaty: TTabSheet;
    paRDTreaty: TPanel;
    lblTrID: TLabel;
    deId: TVDBEMath;
    gbAddons: TGroupBox;
    weCHAPTER_KOD: TVWatchEdit;
    weAnnul_kod: TVWatchEdit;
    teChapter_snaim: TDBText;
    teAnnul_snaim: TDBText;
    dsTreaty: TDataSource;
    lblTrChapter: TLabel;
    lblAnnul_naim: TLabel;
    gbExec: TGroupBox;
    lblTrExecBankAccount: TLabel;
    lblTrExecCurrency: TLabel;
    weExec_Currency_No: TVWatchEdit;
    teExec_Currency_Name: TDBText;
    weExec_Bank_Id: TVWatchEdit;
    teExec_Bank_Name: TDBText;
    lblTrExexFirm: TLabel;
    weExec_Firm_No: TVWatchEdit;
    teExec_Short_Name: TDBText;
    weExec_Bank_Account: TVWatchEdit;
    lblTrExecBank: TLabel;
    gbCust: TGroupBox;
    lblTrCustBankAccount: TLabel;
    lblTrCustCurrency: TLabel;
    teCust_Currency_Name: TDBText;
    teCust_Bank_Name: TDBText;
    lblTrCustFirm: TLabel;
    teCust_Short_Name: TDBText;
    lblTrCustBank: TLabel;
    weCust_Currency_No: TVWatchEdit;
    weCust_Bank_Id: TVWatchEdit;
    weCust_Firm_No: TVWatchEdit;
    weCust_Bank_Account: TVWatchEdit;
    tsAgreem: TTabSheet;
    Panel1: TPanel;
    lblAgrNum: TLabel;
    lblAgrDateSign: TLabel;
    deAddNum: TVDBEMath;
    deAddDateSign: TVDBEDate;
    lblAgrSubject: TLabel;
    lblAgrDateTo: TLabel;
    deAddDateTo: TVDBEDate;
    deAddSummPay: TVDBEMath;
    lblAgrSummPay: TLabel;
    tsAgreemStage: TTabSheet;
    dsAgreemStage: TDataSource;
    deAgrStageDateFrom: TVDBEDate;
    deAgrStageDateTo: TVDBEDate;
    lblAgrStDateTo: TLabel;
    lblAgrStDateFrom: TLabel;
    lblAgrStName: TLabel;
    deAgrStageNum: TVDBEditChar;
    lblAgrStNum: TLabel;
    lblAgrStReporting: TLabel;
    deAgrStageSummPay: TVDBEMath;
    lblAgrStSummPay: TLabel;
    gbStageAddons: TGroupBox;
    deAgrStageDateAct: TVDBEDate;
    deAgrStageDatePay: TVDBEDate;
    lblAgrStDatePay: TLabel;
    lblAgrStDateAct: TLabel;
    deArgStageNumPay: TVDBEditChar;
    lblAgrStNumPay: TLabel;
    weAgrStagePm_pmethod_no: TVWatchEdit;
    teAgrStagePmethod_name: TDBText;
    lblAgrStPMethod: TLabel;
    gbAgrStageExec: TGroupBox;
    lblAgrStExecAccount: TLabel;
    teAgrStageExec_Name: TDBText;
    weAgrStageExec_Bank_Account: TVWatchEdit;
    gbAgrStageCust: TGroupBox;
    lblAgrStCustBank: TLabel;
    teAgrStageCust_Name: TDBText;
    weAgrStageCust_Bank_Account: TVWatchEdit;
    lblTrIstFin: TLabel;
    weIstFin_kod: TVWatchEdit;
    teIstFin_snaim: TDBText;
    wePayment_kod: TVWatchEdit;
    tePayment_snaim: TDBText;
    lblTrPayment_snaim: TLabel;
    tsTreatyStage: TTabSheet;
    deTrStageNum: TVDBEditChar;
    lblTrStNum: TLabel;
    lblTrStDateFrom: TLabel;
    deTrStageDateFrom: TVDBEDate;
    deTrStageDateTo: TVDBEDate;
    lblTrStDateTo: TLabel;
    lblTrStSummPay: TLabel;
    deTrStageSummPay: TVDBEMath;
    lblTrStName: TLabel;
    GroupBox1: TGroupBox;
    lblTrStDatePay: TLabel;
    lblTrStDateAct: TLabel;
    lblTrStNumPay: TLabel;
    teTrStagePmethod_Name: TDBText;
    lblTrStPMethod: TLabel;
    deTrStageDateAct: TVDBEDate;
    deTrStageDatePay: TVDBEDate;
    deTrStageNumPay: TVDBEditChar;
    weTrStagePm_pmethod_no: TVWatchEdit;
    GroupBox2: TGroupBox;
    lblTrStExecBankAccount: TLabel;
    teTrStageExec_Name: TDBText;
    weTrStageExec_Bank_Account: TVWatchEdit;
    GroupBox3: TGroupBox;
    lblTrStCustBankAccount: TLabel;
    teTrStageCust_Name: TDBText;
    weTrStageCust_Bank_Account: TVWatchEdit;
    dsTreatyStage: TDataSource;
    dsAgreem: TDataSource;
    tsTrCurator: TTabSheet;
    dsTrCurator: TDataSource;
    laTabNom: TLabel;
    lblCuratorBigDept: TLabel;
    weBigDept: TVWatchEdit;
    teBigDept: TDBText;
    deDept: TRxDBComboEdit;
    tePodr: TDBText;
    weJob: TVWatchEdit;
    teProf: TDBText;
    laProf: TLabel;
    weMirab_TabN: TVWatchEdit;
    teFIO: TDBText;
    lblTrSubject: TLabel;
    lblCuratorDept: TLabel;
    deFNaim: TVDBERus;
    deINaim: TVDBERus;
    deONaim: TVDBERus;
    lblCuratorDefnaim: TLabel;
    lblCuratorDeiname: TLabel;
    lblCuratorDeonaim: TLabel;
    deAddSubject: TVDBEditChar;
    deAgrStageNumAct: TVDBEMath;
    lblAgrStNumAct: TLabel;
    deTrStageNumAct: TVDBEMath;
    lblTrStNumAct: TLabel;
    lblAgrPayment: TLabel;
    weAddPayment_kod: TVWatchEdit;
    teAddPayment_snaim: TDBText;
    teAddIstFin_snaim: TDBText;
    lblAgrIstFin: TLabel;
    weAddIstFin_kod: TVWatchEdit;
    deAgrStageName: TVDBEditChar;
    deTrStageName: TVDBEditChar;
    tsCurrState: TTabSheet;
    dsCurrState: TDataSource;
    dsCurrStage: TDataSource;
    dsSummpayYear: TDataSource;
    gb_CurrState: TGroupBox;
    lblCurrStateDateTo: TLabel;
    lblCurrStateSummPay: TLabel;
    lblCurrStateIstFin: TLabel;
    teCurrIstFin_snaim: TDBText;
    teCurrPayment_snaim: TDBText;
    lblCurrStatePayment: TLabel;
    lblCurrStateSubject: TLabel;
    deCurrDateTo: TVDBEDate;
    deCurrSummPay: TVDBEMath;
    weCurrIstFin_kod: TVWatchEdit;
    weCurrPayment_kod: TVWatchEdit;
    deCurrSubject: TVDBEditChar;
    gbCurrStage: TGroupBox;
    dbgCurrStage: TRxDBGrid;
    dbgSummpayYear: TRxDBGrid;
    lblCurrStateYearSummPay: TLabel;
    lblTrBeneficiary: TLabel;
    weFirmPrBeneficiary: TDBEdit;
    weFirmPrBank: TVDBEditChar;
    lblTrBank: TLabel;
    weFirmPrNIOKR_ACCOUNT: TVDBEditChar;
    LblTrNIOKR_Account: TLabel;
    dsExecFirmProperty: TDataSource;
    weTrBeneficiary: TDBEdit;
    weTrBank: TVDBEditChar;
    weTrNIOKR_ACCOUNT: TVDBEditChar;
    dsExpectedIncome: TDataSource;
    tsExpectedIncome: TTabSheet;
    paExpIncome: TPanel;
    gbIntroductionDate: TGroupBox;
    lblExpIncPlaneDate: TLabel;
    dePlanDate: TVDBEDate;
    deFactDateFrom: TVDBEDate;
    lblExpIncFactDate: TLabel;
    deFactDateTo: TVDBEDate;
    lblExpIncDateTo: TLabel;
    deExpectedIncome: TVDBEMath;
    lblExpIncSummPay: TLabel;
    deExpIncome: TDBMemo;
    dsExpIncomePeriod: TDataSource;
    tsExpIncomePeriod: TTabSheet;
    lblExpIncPeriodDate: TLabel;
    dePeriod: TVDBEDate;
    lblExpIncPeriodSummPay: TLabel;
    deExpIncomeInPeriod: TVDBEMath;
    deExpIncInPeriod: TDBMemo;
    ntbkTrearyStatus: TNotebook;
    rgFilter: TRadioGroup;
    dbrgTreatyStatus: TDBRadioGroup;
    ntbkTreatyAndSubject: TNotebook;
    deNum: TVDBEditChar;
    lblTrNum: TLabel;
    deThemaPlan: TVDBEMath;
    lblThemaPlan: TLabel;
    deDateSign: TVDBEDate;
    lblDateSign: TLabel;
    deDateFrom: TVDBEDate;
    lblTrDateFrom: TLabel;
    deDateTo: TVDBEDate;
    lblTrDateTo: TLabel;
    deSummPay: TVDBEMath;
    lblTrSummPay: TLabel;
    deSubThemaPlan: TVDBEMath;
    lblThPlanNum: TLabel;
    deSubDateFrom: TVDBEDate;
    lblThPlanDateFrom: TLabel;
    deSubDateTo: TVDBEDate;
    lblThPlanDateTo: TLabel;
    deSubSummPay: TVDBEMath;
    lblThPlanSummPay: TLabel;
    deSubFirstYearSummPay: TVDBEMath;
    lblThPlanFirstYearSummPay: TLabel;
    ntbkTreaty: TNotebook;
    lblPlSammary: TLabel;
    dmSummary: TDBMemo;
    lblTrSummary: TLabel;
    dmAgrStageReporting: TDBMemo;
    lblTrStReporting: TLabel;
    dmTrStageReporting: TDBMemo;
    dmTrSummary: TDBMemo;
    lblTrNDS: TLabel;
    deTrNDS: TVDBEMath;
    lblTrNDSSummpay: TLabel;
    deTrNDSSummPay: TVDBEMath;
    lblAgrNDS: TLabel;
    deAgrNDSSummPay: TVDBEMath;
    lblAgrNDSSummpay: TLabel;
    deAgrNDS: TVDBEMath;
    deAgrStNDS: TVDBEMath;
    lblAgrStNDS: TLabel;
    deAgrStNDSSummPay: TVDBEMath;
    lblAgrStNDSSummpay: TLabel;
    deTrStNDS: TVDBEMath;
    lblTrStNDS: TLabel;
    deTrStNDSSummPay: TVDBEMath;
    lblTrStNDSSummpay: TLabel;
    pCurrStNDS: TPanel;
    lblCurrStNDS: TLabel;
    deCurrStNDS: TVDBEMath;
    deCurrStNDSSummPay: TVDBEMath;
    lblCurrStNDSSummPay: TLabel;
    lblCreateSW: TLabel;
    edCreateSW: TEdit;
    lblReworkSW: TLabel;
    edReworkSW: TEdit;
    lblCreateAllSW: TLabel;
    lblReworkAllSW: TLabel;
    lblTrSt_SW: TLabel;
    lblAgrSt_SW: TLabel;
    btnAgrSt_SW: TButton;
    btnTrSt_SW: TButton;
    btnCorrTrNDS: TButton;
    btnCorrAgrNDS: TButton;
    wePlatDocType: TVWatchEdit;
    Label1: TLabel;
    tePlatDocType: TDBText;
    deSubject: TVDBEditChar;
    lbl1: TLabel;
    edtMIPODR_ID: TRxDBComboEdit;
    dbtxtMIPODR_SNAIM: TDBText;
    pnl1: TPanel;
    pnl2: TPanel;
    grpReporting: TGroupBox;
    pnl3: TPanel;
    pnl4: TPanel;
    grpAgStReporting: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure ShowHandBook(_Sender: TObject);
             {Отображает дочернюю форму со справочником MIPODR.
              Форма с MIPODR, открытая ранее, закрывается}
    procedure ExpPodrDestroy(Sender: TObject);
    procedure weExec_Bank_IdAcceptValue(Sender: TObject;
      var UseInherited: Boolean);
    procedure weCust_Bank_IdAcceptValue(Sender: TObject;
      var UseInherited: Boolean);

    procedure DataSourceChange(Sender: TObject; Field: TField);
    procedure DBGridGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure deDeptExit(Sender: TObject);
    procedure deDeptKeyPress(Sender: TObject; var Key: Char);
    procedure deDeptMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure weMirab_TabNButtonClick(Sender: TObject;
      var UseInherited: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure dsCurrentDataChange(Sender: TObject; Field: TField);
    procedure ShowHint(Sender: TObject;
             Shift: TShiftState; X, Y: Integer);
    procedure DateActExit(Sender: TObject);
    procedure dbgCurrStageGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure dbgCurrStageDblClick(Sender: TObject);
    procedure dsExpectedIncomeDataChange(Sender: TObject;
      Field: TField);
    procedure rgFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbrgTreatyStatusChange(Sender: TObject);
    procedure dsAgreemDataChange(Sender: TObject; Field: TField);
    procedure btnSt_SWClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure btnCorrTrNDSClick(Sender: TObject);
    procedure btnCorrAgrNDSClick(Sender: TObject);
  private
    { Private declarations }
    FExplorer: TfmExpPodr;//Форма со справочником MIPODR
    FOnExpDstr: TNotifyEvent;//Обработчик OnDestroy формы FExplorer

    FCheckingLetter : boolean; // ПРовверка служебного письма

    FAKT_NO : String;
    FSPECIAL_WRITTEN : String;

    function EmptyCurator : boolean;
    procedure refrTreeNodeOfCurator;

    procedure SetFilter; // Устанавливает фильтр

    procedure ChangedStatus;

    procedure LockTreaty;
    procedure LockAgreem;
    procedure LockAgreemStage;
    procedure LockTreatyStage;

    // Определяет признак активности пункта меню удалить письмо
    //function EnabledDelLetter : boolean;

    // Определяет, какая должна надпись в пункте меню удалить письмо
    //function getNameOfDelLetter : string;

    // Возвращает True Если сумма последеного доп. соглашения верная
    function CorrectSummpay : boolean;
    // Возвращает True Если сумма договора верна
    function CorrectSummpayTreaty : boolean;
    // Возвращает True Если сумма доп. соглашения верна
    function CorrectSummpayAgreem : boolean;
    // Возвращает True Если сумма НДС последеного доп. соглашения верная
    function CorrectNDS : boolean;
    // Возвращает True Если сумма НДС договора верна
    function CorrectNDSTreaty : boolean;
    // Возвращает True Если сумма НДС доп. соглашения верна
    function CorrectNDSAgreem : boolean;

    // вставка этапа в схеме M
    procedure InsertBeforeStage(ASUPQuery : TVASUPQuery);
    // редкатирование этапах в схеме M
    procedure EditBeforeStage(ASUPQuery : TVASUPQuery);

    // вставка этапа в схеме M
    procedure InsertAfterStage(ASUPQuery : TVASUPQuery);
    // редкатирование этапах в схеме M
    procedure EditAfterStage(ASUPQuery : TVASUPQuery);

    procedure refrTreatySW;

    procedure refrAllSW;
    procedure refrTrStSW;
    procedure refrAgrStSW;
  public
    { Public declarations }
    procedure UMChangeMode(var Message:TMessage);message UM_CHANGEMODE;

    procedure DoAfterInsert(ASUPQuery: TVASUPQuery); override;

    procedure DoBeforePost(ASUPQuery: TVASUPQuery); override;
    procedure DoAfterPost(ASUPQuery: TVASUPQuery); override;

    procedure DoBeforeDelete(ASUPQuery: TVASUPQuery); override;
    procedure DoAfterDelete(ASUPQuery: TVASUPQuery); override;

    procedure DoAfterOpen(ASUPQuery: TVASUPQuery); override;

    procedure DoAfterRefresh(ASUPQuery: TVASUPQuery); override;
  protected
    procedure DenyAccess; override;

    function SaveData : boolean; override;

    function OraclePerformance:boolean;override;
           {Выполнение операции на Oracle согласно
           текущему режиму}
  end;

var
  fmTreatyCard: TfmTreatyCard;

implementation
uses globals, OracleData;
{$R *.DFM}

type
  TAct = record
    No   : Integer;
    date : TDateTime;
  end;


procedure TfmTreatyCard.FormCreate(Sender: TObject);
begin
  FCheckingLetter := false;
  FAKT_NO := '';
  FSPECIAL_WRITTEN := '';
  inherited;
  Vertex:= dmGlobal.quTreaty;
  dmGlobal.odsTrExecFirmProperty.Open;
end;


procedure TfmTreatyCard.weExec_Bank_IdAcceptValue(Sender: TObject;
  var UseInherited: Boolean);
begin
  inherited;
  dmGlobal.quTreatyEXEC_COUNTRY_NO.Value :=
    weExec_Bank_Id.EyesQuery.fieldbyName('COUNTRY_NO').value;
end;

procedure TfmTreatyCard.weCust_Bank_IdAcceptValue(Sender: TObject;
  var UseInherited: Boolean);
begin
  inherited;
  dmGlobal.quTreatyCUST_COUNTRY_NO.Value :=
    weCust_Bank_Id.EyesQuery.fieldbyName('COUNTRY_NO').value;
end;

procedure TfmTreatyCard.ChangedStatus;
begin
  if dmGlobal.quTreatySTATUS.Value = 'A' then
  begin
    deNum.Font.Color:=clRed; deSubject.Font.Color:=clRed; deDateSign.Font.Color:=clRed;
    deDateFrom.Font.Color:=clRed; deDateTo.Font.Color:=clRed; deSummPay.Font.Color:=clRed;
    deThemaPlan.Font.Color:=clRed;
  end
  else if dmGlobal.quTreatySTATUS.Value = 'F' then
  begin
    deNum.Font.Color:= clBlue; deSubject.Font.Color:=clBlue; deDateSign.Font.Color:=clBlue;
    deDateFrom.Font.Color:=clBlue; deDateTo.Font.Color:=clBlue; deSummPay.Font.Color:=clBlue;
    deThemaPlan.Font.Color:=clBlue;
  end
  else
  begin
    deNum.Font.Color:= clBlack; deSubject.Font.Color:=clBlack; deDateSign.Font.Color:=clBlack;
    deDateFrom.Font.Color:=clBlack; deDateTo.Font.Color:=clBlack; deSummPay.Font.Color:=clBlack;
    deThemaPlan.Font.Color:=clBlack;
  end;

  if dmGlobal.quTreatySTATUS.Value = 'P' then
  begin
    ntbkTreatyAndSubject.ActivePage := 'Тема';
    lblAnnul_naim.Visible := false;
    weAnnul_kod.Visible := false;
    teAnnul_snaim.Visible := false;
    ntbkTreaty.ActivePage := 'SUMMARY';
  end
  else
  begin
    ntbkTreatyAndSubject.ActivePage := 'Договор';
    lblAnnul_naim.Visible := true;
    weAnnul_kod.Visible := true;
    teAnnul_snaim.Visible := true;
    ntbkTreaty.ActivePage := 'NORMAL';
  end;
end;

procedure TfmTreatyCard.DataSourceChange(Sender: TObject; Field: TField);
begin
  inherited;
  // quTreaty , dsTreaty
  if    (Sender=dsTreaty) and ((Field=nil) or (Field = dsTreaty.DataSet.FieldByName('STATUS'))) and
        (dsTreaty.State in [dsBrowse,dsEdit,dsInsert]) and
        (WorkStyle <> wsQuery) then
    ChangedStatus;

  //Updated by IVCHIN [03.12.2008]
  //Устанавливаем переменную типа плат.документа для quTreatyStage и quAgreemStage в зависимости от типа документа оплаты
  //чтобы правильно выбирались данные об оплате этапа.
  if ((Sender = dsTreaty) and (Field = nil) and (dsTreaty.State in [dsBrowse])) then
    if (dsTreaty.DataSet.FieldByName('PLAT_DOC_TYPE').AsInteger = 3025) then
    begin
      PLAT_DOC_TYPE := 3025;
      dmGlobal.quTreatyStage.SetVariable('TYP',3025);
      dmGlobal.quAgreemStage.SetVariable('TYP',3025);
      dmGlobal.odsCurrStage.SetVariable('TYP',3025);
      dmGlobal.quRN01_Concern.SetVariable('TYP',3025);
//      dmGlobal.quPayment_1.SetVariable('TYP',3025);
    end
    else
    begin
      PLAT_DOC_TYPE := 510;
      dmGlobal.quTreatyStage.SetVariable('TYP',510);
      dmGlobal.quAgreemStage.SetVariable('TYP',510);
      dmGlobal.odsCurrStage.SetVariable('TYP',510);
      dmGlobal.quRN01_Concern.SetVariable('TYP',510);
//      dmGlobal.quPayment_1.SetVariable('TYP',510);      
    end;

  // quTreatyStage , dsTreatyStage
  if    (Sender=dsTreatyStage) and (Field=nil) and (dsTreatyStage.State in [dsBrowse,dsEdit,dsInsert]) then
  begin
   if not dmGlobal.quTreatyStageDATEACT.IsNull then
    if not dmGlobal.quTreatyStageDATEPAY.IsNull then
    begin
     deTrStageNum.Font.Color := clBlue; deTrStageDateFrom.Font.Color := clBlue;
     deTrStageDateTo.Font.Color := clBlue; deTrStageSummPay.Font.Color := clBlue;
     deTrStageDateAct.Font.Color := clBlue; deTrStageNumAct.Font.Color := clBlue;
     deTrStageNumPay.Font.Color := clBlue; deTrStageDatePay.Font.Color := clBlue;
    end
    else
    begin
     deTrStageNum.Font.Color := clGreen; deTrStageDateFrom.Font.Color := clGreen;
     deTrStageDateTo.Font.Color := clGreen; deTrStageSummPay.Font.Color := clGreen;
     deTrStageDateAct.Font.Color := clGreen; deTrStageNumAct.Font.Color := clGreen;
     deTrStageNumPay.Font.Color := clBlack; deTrStageDatePay.Font.Color := clBlack;
    end
   else
   begin
     deTrStageNum.Font.Color := clBlack; deTrStageDateFrom.Font.Color := clBlack;
     deTrStageDateTo.Font.Color := clBlack; deTrStageSummPay.Font.Color := clBlack;
     deTrStageDateAct.Font.Color := clBlack; deTrStageNumAct.Font.Color := clBlack;
     deTrStageNumPay.Font.Color := clBlack; deTrStageDatePay.Font.Color := clBlack;
   end;
  end;
  // quAgreemStage , dsAgreemStage
  if    (Sender=dsAgreemStage) and (Field=nil) and (dsAgreemStage.State in [dsBrowse,dsEdit,dsInsert]) then
  begin
   if not dmGlobal.quAgreemStageDATEACT.IsNull then
    if not dmGlobal.quAgreemStageDATEPAY.IsNull then
    begin
     deAgrStageNum.Font.Color := clBlue; deAgrStageDateFrom.Font.Color := clBlue;
     deAgrStageDateTo.Font.Color := clBlue; deAgrStageSummPay.Font.Color := clBlue;
     deAgrStageDateAct.Font.Color := clBlue; deAgrStageNumAct.Font.Color := clBlue;
     deArgStageNumPay.Font.Color := clBlue; deAgrStageDatePay.Font.Color := clBlue;
    end
    else
    begin
     deAgrStageNum.Font.Color := clGreen; deAgrStageDateFrom.Font.Color := clGreen;
     deAgrStageDateTo.Font.Color := clGreen; deAgrStageSummPay.Font.Color := clGreen;
     deAgrStageDateAct.Font.Color := clGreen; deAgrStageNumAct.Font.Color := clGreen;
     deArgStageNumPay.Font.Color := clBlack; deAgrStageDatePay.Font.Color := clBlack;
    end
   else
   begin
     deAgrStageNum.Font.Color := clBlack; deAgrStageDateFrom.Font.Color := clBlack;
     deAgrStageDateTo.Font.Color := clBlack; deAgrStageSummPay.Font.Color := clBlack;
     deAgrStageDateAct.Font.Color := clBlack; deAgrStageNumAct.Font.Color := clBlack;
     deArgStageNumPay.Font.Color := clBlack; deAgrStageDatePay.Font.Color := clBlack;
   end;
  end;
  // quTrCurator , dsTrCurator
  if    (Sender=dsTrCurator) and (Field=nil) and (dsTrCurator.State in [dsBrowse,dsEdit,dsInsert]) then
  begin
    if not dmGlobal.quTrCuratorDATAUVOL.IsNull then
    begin
     weMirab_TabN.Font.Color:=clRed; deFNaim.Font.Color:=clRed;
     deINaim.Font.Color:=clRed; deONaim.Font.Color:=clRed;
    end
    else
    begin
     weMirab_TabN.Font.Color:=clBlack; deFNaim.Font.Color:=clBlack;
     deINaim.Font.Color:=clBlack; deONaim.Font.Color:=clBlack;
    end;
  end;

  if not CorrectSummpay then
  begin
    deNum.Color := RGB(255, 128, 255);
    deNum.Font.Color:= RGB(128, 0, 128);
  end
  else if EmptyCurator then
  begin
    deNum.Color := clYellow;
    deNum.Font.Color:= RGB(128, 0, 128);

    deSubThemaPlan.Color := clYellow;
    deSubThemaPlan.Font.Color:= RGB(128, 0, 128);
  end
  else
  begin
    deNum.Color := clWhite;
    deNum.Font.Color:= clBlack;

    deSubThemaPlan.Color := clWhite;
    deSubThemaPlan.Font.Color:= clBlack;
  end;
  if not CorrectSummpayTreaty then
  begin
    deSummPay.Color := RGB(255, 128, 255);
    deSummPay.Font.Color:= RGB(128, 0, 128);
  end
  else
  begin
    deSummPay.Color := clWhite;
    deSummPay.Font.Color:= clBlack;
  end;

  if not CorrectNDS then
  begin
    deTrNDS.Color := RGB(255, 128, 255);
    deTrNDS.Font.Color:= RGB(128, 0, 128);
  end
  else
  begin
    deTrNDS.Color := clWhite;
    deTrNDS.Font.Color:= clBlack;
  end;

  if not CorrectNDSTreaty then
  begin
    deTrNDSSummPay.Color := RGB(255, 128, 255);
    deTrNDSSummPay.Font.Color:= RGB(128, 0, 128);
  end
  else
  begin
    deTrNDSSummPay.Color := clWhite;
    deTrNDSSummPay.Font.Color:= clBlack;
  end;

  if  (Sender=dsCurrState) then
  begin
    if not CorrectSummpay then
    begin
      deCurrSummPay.Color := RGB(255, 128, 255);
      deCurrSummPay.Font.Color:= RGB(128, 0, 128);
    end
    else
    begin
      deCurrSummPay.Color := clWhite;
      deCurrSummPay.Font.Color:= clBlack;
    end;

    if not CorrectNDS then
    begin
      deCurrStNDS.Color := RGB(255, 128, 255);
      deCurrStNDS.Font.Color:= RGB(128, 0, 128);
    end
    else
    begin
      deCurrStNDS.Color := clWhite;
      deCurrStNDS.Font.Color:= clBlack;
    end;
  end;

  if not Assigned(Field) then
  begin
    if Sender=dsTreaty then
      refrTreatySW;

    if Sender=dsTreatyStage then
      refrTrStSW;

    if Sender=dsAgreemStage then
      refrAgrStSW;
  end;

  refrTreeNodeOfCurator;

  btnCorrTrNDS.Visible := (dsCurrent.DataSet = dsTreaty.DataSet) AND(WorkStyle = wsView) AND (dsTreaty.DataSet.RecordCount > 0) AND (not CorrectNDSTreaty);
end;

procedure TfmTreatyCard.DBGridGetCellParams(Sender: TObject; Field: TField;
  AFont: TFont; var Background: TColor; Highlight: Boolean);
var
  flSW_STAGE : TField;
begin
  inherited;
  with dmGlobal do
    if not Highlight then
    begin
      if (dsCurrent.DataSet= quTreaty) then
      begin
        if quTreatySTATUS.Value = 'A' then AFont.Color:= clRed;
        if quTreatySTATUS.Value = 'F' then AFont.Color:= clBlue;
        if quTreatySTATUS.Value = 'P' then AFont.Color:= clGreen;

        if (Field.FieldName = 'NUM') and (not CorrectSummpay) then
        begin
          Background := RGB(255, 128, 255);
          AFont.Color:= RGB(128, 0, 128);
        end
        else if (Field.FieldName = 'NUM') and EmptyCurator then
        begin
          Background := clYellow;
          AFont.Color:= RGB(128, 0, 128);
        end;

        if (Field.FieldName = 'SUMMPAY') and (not CorrectSummpayTreaty)  then
        begin
          Background := RGB(255, 128, 255);
          AFont.Color:= RGB(128, 0, 128);
        end;

        if (Field.FieldName = 'NDS') and (not CorrectNDS) then
        begin
          Background := RGB(255, 128, 255);
          AFont.Color:= RGB(128, 0, 128);
        end;

        if (Field.FieldName = 'NDS_SUMMPAY') and (not CorrectNDSTreaty)  then
        begin
          Background := RGB(231, 255, 255);
          AFont.Color:= RGB(4, 83, 0);
        end;

        if (Field.FieldName = 'CREATE_SW') and (not Field.IsNull) and (Field.AsInteger > 0) then
        begin
          Background := clGreen;
          AFont.Color:= clWhite;
        end;

        if (Field.FieldName = 'REWORK_SW') and (not Field.IsNull) and (Field.AsInteger > 0) then
        begin
          Background := clDkGray;
          AFont.Color:= clWhite;
        end;
      end;
      if (dsCurrent.DataSet= dsAgreem.DataSet) then
      begin
        if (Field.FieldName = 'SUMMPAY') and (not CorrectSummpayAgreem) then
        begin
          Background := RGB(255, 128, 255);
          AFont.Color:= RGB(128, 0, 128);
        end;

        if (Field.FieldName = 'NDS_SUMMPAY') and (not CorrectNDSAgreem) then
        begin
          Background := RGB(255, 128, 255);
          AFont.Color:= RGB(128, 0, 128);
        end;
      end;
      if (dsCurrent.DataSet= quAgreemStage) then
      begin
        if not quAgreemStageDATEACT.IsNull
        then  if not quAgreemStageDATEPAY.IsNull then AFont.Color:= clBlue
                                                 else AFont.Color:= clGreen;

        flSW_STAGE := dsCurrent.DataSet.FieldByName('SW_STAGE');
        if (not dsCurrent.DataSet.IsEmpty) and (not flSW_STAGE.IsNull) then
        begin
          if PLAT_DOC_TYPE <> 3025 then
          begin
            if flSW_STAGE.AsInteger = 1 then
            begin
              Background := clGreen;
              AFont.Color:= clWhite;
            end
            else if flSW_STAGE.AsInteger = 2 then
            begin
              Background := clDkGray;
              AFont.Color:= clWhite;
            end;
          end;
        end;
      end;
      if (dsCurrent.DataSet = quTreatyStage) then
      begin
        if not quTreatyStageDATEACT.IsNull
        then  if not quTreatyStageDATEPAY.IsNull then AFont.Color:= clBlue
                                                 else AFont.Color:= clGreen;

        flSW_STAGE := dsCurrent.DataSet.FieldByName('SW_STAGE');
        if (not dsCurrent.DataSet.IsEmpty) and (not flSW_STAGE.IsNull) then
        begin
          if PLAT_DOC_TYPE <> 3025 then
	  begin
	    if flSW_STAGE.AsInteger = 1 then
            begin
              Background := clGreen;
              AFont.Color:= clWhite;
            end
            else if flSW_STAGE.AsInteger = 2 then
            begin
              Background := clDkGray;
              AFont.Color:= clWhite;
            end;
	  end;
        end;
      end;
      if (dsCurrent.DataSet= quTrCurator) then
      begin
        if not quTrCuratorDATAUVOL.IsNull then AFont.Color:= clRed
        else AFont.Color:= clBlack
      end;
    end;
end;

procedure TfmTreatyCard.ShowHandBook(_Sender: TObject);
var tmp : string;
begin
  with _Sender as TRxDBComboEdit do
    if (Field.FieldName = 'MIPODR_KOD') or
       (Field.FieldName = 'MIPODR_ID') then
    begin
//      tmp := Field.DataSet.FieldByName('MIPODR_ID').AsString;
//      Application.MessageBox(PChar(TMP),'INFO');
      if not ReadOnly then
      begin
        if Modified and (Length(Text)>0)
           and (Field.AsString<>Text)  then
          Field.AsString:= Text;
        if Assigned(FExplorer) then FExplorer.Show
        else
        begin
          RemoveConflictWin;
          Screen.Cursor:= crSQLWait;
          FExplorer:= TfmExpPodr.Create(Self);
          with FExplorer do
          begin
            FOnExpDstr:= FExplorer.OnDestroy;
            OnDestroy:= ExpPodrDestroy;
            SenderControl:= Self;
            IdField := Field.DataSet.FieldByName('MIPODR_ID');

            Perform( UM_INITIALIZE,IN_SETDATASETLIST,
                     Integer(dmGlobal.mdStruc.DataSetList) );
          end;
          Screen.Cursor:= crDefault;
        end;
        FExplorer.SetFocus;
        if Length(Field.AsString)=0 then
        begin
          if FExplorer.IdField.AsInteger>0 then
          begin
            FExplorer.dsWork.Start;
            FExplorer.dsWork.DataSet.Locate('MIPODR_ID',FExplorer.IdField.AsInteger,[]);
            FExplorer.dsWork.Next;
          end
          else FExplorer.Perform( UM_OTHERS,IN_DIRECTMOVE,1);
        end
        else if FExplorer.IdField.AsInteger<=0 then FExplorer.Perform( UM_OTHERS,IN_DIRECTMOVE,1)
          else FExplorer.Perform( UM_OTHERS,IN_STEP_BY_STEP,FExplorer.IdField.AsInteger)
      end;
    end
end;

procedure TfmTreatyCard.deDeptExit(Sender: TObject);
begin
  with Sender as TRxDBComboEdit do
    if (Length(Text)>0)
       and (Field.DataSet.FieldByName('MIPODR_ID').AsInteger= No_Departments_ID) then
       Field.AsString:= Text
end;


procedure TfmTreatyCard.deDeptKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=vk_Space then ShowHandBook(Sender);
  if not (Key in ['0'..'9',Char(VK_BACK)]) then Key:= #00;
end;



procedure TfmTreatyCard.deDeptMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  with Sender as TRxDBComboEdit do
  begin
    if Length(Text)>0 then
      if Modified or (DataSource.DataSet.FieldByName('MIPODR_ID').AsInteger
         <> No_Departments_ID) then
      begin
        if Length(Text) mod 2=0 then
        begin
           if Modified and not ReadOnly
              and (Field.AsString<>Text) then
           begin
             Modified:= false;
             Field.AsString:= Text;
           end;
           Hint:= Field.DataSet.FieldByName('MIPODR_PNAIM').AsString+'|';
        end
        else Hint:= ''
      end
      else Hint:= InvalidDeptMsg
    else Hint:= CNoDaMess;
  end;
end;

procedure TfmTreatyCard.ExpPodrDestroy(Sender: TObject);
begin
  if Assigned(FOnExpDstr) then
    FOnExpDstr(Sender);
  FExplorer:= nil;
  SetActiveWindow(Handle);
end;

procedure TfmTreatyCard.weMirab_TabNButtonClick(Sender: TObject;
  var UseInherited: Boolean);
begin
  inherited;
  UseInherited:= true;
  weMirab_TabN.SetFocus;
  with TVASUPQuery(weMirab_TabN.EyesQuery) do
  begin
    SQLFilter:= '';
    if   not dmGlobal.quTrCuratorMIPODR_ID.IsNull
      or not dmGlobal.quTrCuratorMIPROF_KOD.IsNull
      or not dmGlobal.quTrCuratorFNAIM.IsNull
      or not dmGlobal.quTrCuratorINAIM.IsNull
      or not dmGlobal.quTrCuratorONAIM.IsNull then
    begin
      if not dmGlobal.quTrCuratorMIPODR_ID.IsNull then
      begin
        SQLFilter:= ' MIPODR_ID IN (SELECT ID FROM MIPODR CENTRAL WHERE DATAVIVOD IS NULL START WITH ID= :P1 CONNECT BY PRIOR ID=MIPODR_ID) ';
        DeclareVariable('P1',otInteger);
        SetVariable('P1',dmGlobal.quTrCuratorMIPODR_ID.AsInteger);
      end;
      if not dmGlobal.quTrCuratorMIPROF_KOD.IsNull then
      begin
        if SQLFilter <> ''  then  SQLFilter:= SQLFilter + ' AND MIPROF_KOD = :P2 '
        else SQLFilter:= ' MIPROF_KOD = :P2 ';
        DeclareVariable('P2',otInteger);
        SetVariable('P2',dmGlobal.quTrCuratorMIPROF_KOD.AsInteger);
      end;
      if not dmGlobal.quTrCuratorFNAIM.IsNull then
      begin
        if SQLFilter <> ''  then  SQLFilter:= SQLFilter + ' AND FNAIM LIKE :P3 '
        else SQLFilter:= ' FNAIM LIKE :P3 ';
        DeclareVariable('P3',otString);
        SetVariable('P3', trim(dmGlobal.quTrCuratorFNAIM.AsString) + '%');
      end;
      if not dmGlobal.quTrCuratorINAIM.IsNull then
      begin
        if SQLFilter <> ''  then  SQLFilter:= SQLFilter + ' AND INAIM LIKE :P4 '
        else SQLFilter:= ' INAIM LIKE :P4 ';
        DeclareVariable('P4',otString);
        SetVariable('P4',trim(dmGlobal.quTrCuratorINAIM.AsString) + '%');
      end;
      if not dmGlobal.quTrCuratorONAIM.IsNull then
      begin
        if SQLFilter <> ''  then  SQLFilter:= SQLFilter + ' AND ONAIM LIKE :P5 '
        else SQLFilter:= ' ONAIM LIKE :P5 ';
        DeclareVariable('P5',otString);
        SetVariable('P5', trim(dmGlobal.quTrCuratorONAIM.AsString) + '%');
      end;
      SQLFiltered:= true;
    end
    else SQLFiltered:= false;
  end;
end;

procedure TfmTreatyCard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  fmMainMenu.hpOperations.Visible := False;

  dmGlobal.odsTrExecFirmProperty.Close;
end;

procedure TfmTreatyCard.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //inherited;
  if not (ActiveControl is TRxDBGrid)
     and not (ActiveControl is TDBGrid)
     and not (ActiveControl is TDBMemo) then inherited;
end;

procedure TfmTreatyCard.FormActivate(Sender: TObject);
begin
  inherited;
  fmMainMenu.hpOperations.Visible := True;
end;

procedure TfmTreatyCard.FormDeactivate(Sender: TObject);
begin
  inherited;
  fmMainMenu.hpOperations.Visible := False;
end;

procedure TfmTreatyCard.dsCurrentDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  // Делаем сначала пункты меню 'Операции' недоступными
  fmMainMenu.vpNoAnnulment.Enabled := False; fmMainMenu.vpNoClose.Enabled := False;
  fmMainMenu.vpClose.Enabled := False;       fmMainMenu.vpAnnulment.Enabled := False;
  fmMainMenu.vpPrintLetter.Enabled := False;
  fmMainMenu.vpSubjectToTreaty.Enabled := False; fmMainMenu.vpTreatyToSubject.Enabled := False;
  // Затем делаем видимыми только возможные
  if (dsCurrent.DataSet = dmglobal.quTreaty) and not(dsTreaty.State in [dsInactive,dsEdit,dsInsert])
      and (aqEditing in dmglobal.quTreaty.AccessLevel) then
  begin
   if dmglobal.quTreatySTATUS.Value = 'O' then begin fmMainMenu.vpClose.Enabled := True;
                                                     fmMainMenu.vpAnnulment.Enabled := True; end
   else if dmglobal.quTreatySTATUS.Value = 'F' then fmMainMenu.vpNoClose.Enabled := True
   else if dmglobal.quTreatySTATUS.Value = 'A' then fmMainMenu.vpNoAnnulment.Enabled := True;
  end;
  if  ((dsCurrent.DataSet = dmglobal.quAgreemStage) and not(dsAgreemStage.State in [dsInactive,dsEdit,dsInsert])
        and (aqEditing in dmglobal.quAgreemStage.AccessLevel))
   or ((dsCurrent.DataSet = dmglobal.quTreatyStage) and not(dsTreatyStage.State in [dsInactive,dsEdit,dsInsert])
        and (aqEditing in dmglobal.quTreatyStage.AccessLevel))
  then begin fmMainMenu.vpPrintLetter.Enabled := True; end;

  if (dsCurrent.DataSet = dmglobal.quTreaty) and (WorkStyle in [wsView, wsEdit])  then
  begin
    if dmglobal.quTreaty.FieldByName('Status').Value = 'O' then
      fmMainMenu.vpTreatyToSubject.Enabled := true
    else if dmglobal.quTreaty.FieldByName('Status').Value = 'P' then
      fmMainMenu.vpSubjectToTreaty.Enabled := True;
  end;
end;

procedure TfmTreatyCard.ShowHint(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  with Sender as TVDBEditChar do
  begin
   Hint := Text;
  end;
end;

procedure TfmTreatyCard.DateActExit(Sender: TObject);
begin
  inherited;
  if WorkStyle in [wsAdd,wsEdit]
  then
  begin
   if  (dsTreatyStage.State in [dsEdit,dsInsert])
       and (Sender= deTrStageDateAct)
   then
    if dmglobal.quTreatyStageDATEACT.IsNull then
    begin
     dmglobal.quTreatyStageCUST_BANK_ACCOUNT.Clear;
     dmglobal.quTreatyStageEXEC_BANK_ACCOUNT.Clear;
    end
    else if dmglobal.quTreatyStageCUST_BANK_ACCOUNT.IsNull
            and dmglobal.quTreatyStageEXEC_BANK_ACCOUNT.IsNull then
     with dmglobal.quAccountDefault do
     begin
      SetVariable('TREATY_ID',dmglobal.quTreatyID.Value);
      Execute;
      if VarIsNull(GetVariable('V_CUST_ACCNT')) then
       dmglobal.quTreatyStageCUST_BANK_ACCOUNT.Value := dmglobal.quTreatyCUST_BANK_ACCOUNT.Value
      else dmglobal.quTreatyStageCUST_BANK_ACCOUNT.Value := GetVariable('V_CUST_ACCNT');
      if VarIsNull(GetVariable('V_EXEC_ACCNT')) then
       dmglobal.quTreatyStageEXEC_BANK_ACCOUNT.Value := dmglobal.quTreatyEXEC_BANK_ACCOUNT.Value
      else dmglobal.quTreatyStageEXEC_BANK_ACCOUNT.Value := GetVariable('V_EXEC_ACCNT');
      Close;
   end;

   if  (dsAgreemStage.State in [dsEdit,dsInsert])
       and (Sender= deAgrStageDateAct)
   then
    if dmglobal.quAgreemStageDATEACT.IsNull then
    begin
     dmglobal.quAgreemStageCUST_BANK_ACCOUNT.Clear;
     dmglobal.quAgreemStageEXEC_BANK_ACCOUNT.Clear;
    end
    else if dmglobal.quAgreemStageCUST_BANK_ACCOUNT.IsNull
            and dmglobal.quAgreemStageEXEC_BANK_ACCOUNT.IsNull then
     with dmglobal.quAccountDefault do
     begin
      SetVariable('TREATY_ID',dmglobal.quTreatyID.Value);
      Execute;
      if VarIsNull(GetVariable('V_CUST_ACCNT')) then
       dmglobal.quAgreemStageCUST_BANK_ACCOUNT.Value := dmglobal.quTreatyCUST_BANK_ACCOUNT.Value
      else dmglobal.quAgreemStageCUST_BANK_ACCOUNT.Value := GetVariable('V_CUST_ACCNT');
      if VarIsNull(GetVariable('V_EXEC_ACCNT')) then
       dmglobal.quAgreemStageEXEC_BANK_ACCOUNT.Value := dmglobal.quTreatyEXEC_BANK_ACCOUNT.Value
      else dmglobal.quAgreemStageEXEC_BANK_ACCOUNT.Value := GetVariable('V_EXEC_ACCNT');
      Close;
   end;

  end;
end;

procedure TfmTreatyCard.UMChangeMode(var Message:TMessage);
begin
  inherited;
  if dsCurrent.DataSet = dmGlobal.quCurrState then
  begin
    if WorkStyle = wsView then
    begin
      dmGlobal.odsCurrStage.Active:=True;
      dmGlobal.odsSummpayYear.Active:=True;
    end
    else
    begin
      dmGlobal.odsCurrStage.Active:=False;
      dmGlobal.odsSummpayYear.Active:=False;
    end;
  end;

  btnCorrTrNDS.Visible := (dsCurrent.DataSet = dsTreaty.DataSet) AND(WorkStyle = wsView) AND (dsTreaty.DataSet.RecordCount > 0) AND (not CorrectNDSTreaty);
  btnCorrAgrNDS.Visible := (dsCurrent.DataSet = dsAgreem.DataSet) AND(WorkStyle = wsView) AND (dsAgreem.DataSet.RecordCount > 0) AND (not CorrectNDSAgreem);

  if  WorkStyle in [wsView, wsDelete] then
  begin
    weFirmPrBeneficiary.Visible := True;
    weFirmPrBeneficiary.ReadOnly := true;
    weFirmPrBank.Visible := True;
    weFirmPrBank.ReadOnly := true;
    weFirmPrNIOKR_ACCOUNT.Visible := True;
    weFirmPrNIOKR_ACCOUNT.ReadOnly := true;

    weTrBeneficiary.Visible := False;
    weTrBank.Visible := False;
    weTrNIOKR_ACCOUNT.Visible := False;
  end
  else
  begin
    weFirmPrBeneficiary.Visible := False;
    weFirmPrBank.Visible := False;
    weFirmPrNIOKR_ACCOUNT.Visible := False;

    weTrBeneficiary.Visible := True;
    weTrBank.Visible := True;
    weTrNIOKR_ACCOUNT.Visible := True;

    if WorkStyle in [wsEdit, wsAdd] then
    begin
      weTrBeneficiary.Color := clWindow;
      weTrBank.Color := clWindow;
      weTrNIOKR_ACCOUNT.Color := clWindow;
    end
    else
    begin
      weTrBeneficiary.Color := clBtnFace;
      weTrBank.Color := clBtnFace;
      weTrNIOKR_ACCOUNT.Color := clBtnFace;

      weTrBeneficiary.ReadOnly := true;
      weTrBank.ReadOnly := true;
      weTrNIOKR_ACCOUNT.ReadOnly := true;
    end;
  end;

  if WorkStyle = wsAdd then
  begin
    ntbkTrearyStatus.ActivePage := 'Редактирование';
    if dsCurrent.DataSet = dsTreaty.DataSet then
      dbrgTreatyStatus.Value := 'O';
  end
  else
    ntbkTrearyStatus.ActivePage := 'Фильтр';

  if WorkStyle = wsQuery then
  begin
    deExpIncome.Enabled := false;
    deExpIncInPeriod.Enabled := false;
    dmSummary.Visible := false;
  end
  else
  begin
    deExpIncome.Enabled := true;
    deExpIncInPeriod.Enabled := true;
    dmSummary.Visible := true;
  end;

  if WorkStyle = wsEdit then
  begin
    if dsCurrent.DataSet = dsTreaty.DataSet then
    begin
      // Блокируем запись договора
      LockTreaty;
    end
    else if dsCurrent.DataSet = dsAgreem.DataSet then
    begin

      LockAgreem;
    end
    else if dsCurrent.DataSet = dsAgreemStage.DataSet then
    begin

      LockAgreemStage;
    end
    else if dsCurrent.DataSet = dsTreatyStage.DataSet then
    begin

      LockTreatyStage;
    end;
  end;

  ChangedStatus;
end;

function TfmTreatyCard.OraclePerformance:boolean;
var
  currDataSet : TDataSet;

  prevWorkStyle : TWStyle;
  currWorkStyle : TWStyle;

  summary : String;

  LAutoCommit : boolean;
begin
  summary := '';



  if (dsCurrent.DataSet = dsTreaty.DataSet) and (WorkStyle in [wsEdit, wsAdd, wsDelete]) then
  begin
    // Сохранение данных на закладке договора
    // путем выполнения нескольких транзакций.
    // Если происходит ошибка при выполнении транзакции,
    // а до нее было выполнено хотя бы одна транзакция,
    // то в БД будет сохранено не корректные сведенья.
    // Чтобы этого не произошло, свойству autoCommit присваиваем значение false,
    // а после выполнения удачно всех транзакций выполняем команду Commit,
    // в случае если в ходе выполнений транзакций произошла ошибка, то выполняем команду Rollback.
    with dsTreaty.DataSet as TVASUPQuery do
    begin
      LAutoCommit := Session.AutoCommit;
      try
        try
          Session.AutoCommit := false;

          if (dsCurrent.DataSet = dsTreaty.DataSet) and (WorkStyle in [wsAdd, wsEdit]) then
          begin
            currDataSet := dsCurrent.DataSet;
            with TOracleQuery.Create(nil) do
            begin
              Session:= dmGlobal.seOracle;
              DeclareVariable('FIRM_NO', otFloat);
              DeclareVariable('COUNTRY_NO', otFloat);
              DeclareVariable('BANK_ID', otString);
              DeclareVariable('NAME_BENEFICIARY', otString);
              DeclareVariable('BANK', otString);
              DeclareVariable('NIOKR_ACCOUNT', otString);
              SetVariable('FIRM_NO', currDataSet.FieldValues['EXEC_FIRM_NO']);
              SetVariable('COUNTRY_NO', currDataSet.FieldValues['EXEC_COUNTRY_NO']);
              SetVariable('BANK_ID', currDataSet.FieldValues['EXEC_BANK_ID']);
              SetVariable('NAME_BENEFICIARY', currDataSet.FieldValues['NAME_BENEFICIARY']);
              SetVariable('BANK', currDataSet.FieldValues['BANK']);
              SetVariable('NIOKR_ACCOUNT', currDataSet.FieldValues['NIOKR_ACCOUNT']);
              SQL.Add('BEGIN');
              SQL.Add('RN.MIFIRM_BANK_PKG.UPDATERecord(:FIRM_NO, :COUNTRY_NO, :BANK_ID, :NAME_BENEFICIARY, :BANK, :NIOKR_ACCOUNT);');
              SQL.Add('END;');

              Execute;

              Destroy;
            end;

            dmGlobal.odsTrExecFirmProperty.Refresh;
          end;

          if (dsCurrent.DataSet = dsTreaty.DataSet) and
             ((WorkStyle in [wsDelete]) or ((WorkStyle in [wsEdit]) and (dsTreaty.DataSet.FieldByName('SUMMARY').IsNull)))
          then
          begin
            with TOracleQuery.Create(nil) do
            begin
              Session:= dmGlobal.seOracle;
              DeclareVariable('TREATY_ID', otInteger);
              SetVariable('TREATY_ID', dsTreaty.DataSet.FieldValues['ID']);
              SQL.Add('DELETE mnsummary where TREATY_ID = :TREATY_ID');
              Execute;
              Destroy;
            end;
          end;

          if (dsCurrent.DataSet = dsTreaty.DataSet) and
             (WorkStyle in [wsEdit]) and (not dsTreaty.DataSet.FieldByName('SUMMARY').IsNull)
          then
          begin
            with TOracleQuery.Create(nil) do
            begin
              Session:= dmGlobal.seOracle;
              DeclareVariable('TREATY_ID', otInteger);
              DeclareVariable('SUMMARY', otString);
              DeclareVariable('R', otString);
              SetVariable('TREATY_ID', dsTreaty.DataSet.FieldValues['ID']);
              SetVariable('SUMMARY', dsTreaty.DataSet.FieldValues['SUMMARY']);
              SetVariable('R', TOracleDataSet(dsTreaty.DataSet).RowId);
             SQL.Add('DECLARE');
              SQL.Add('  c NUMBER;');
              SQL.Add('BEGIN');
              SQL.Add('  SELECT count(*) INTO c FROm MnSUMMARY WHERE TREATY_ID = :TREATY_ID;');
              SQL.Add('  IF c > 0 THEN');
              SQL.Add('    UPDATE MnSUMMARY SET SUMMARY = :SUMMARY WHERE TREATY_ID = :TREATY_ID;');
              SQL.Add('  ELSE');
              SQL.Add('    INSERT INTO mnsummary (TREATY_ID, SUMMARY) VALUES ((SELECT ID FROM RN.MNTREATY WHERE ROWID = :R), :SUMMARY);');
              SQL.Add('  END IF;');
              SQL.Add('END;');
              Execute;
              Destroy;
            end;
          end;

          if (dsCurrent.DataSet = dsTreaty.DataSet) and (WorkStyle in [wsAdd]) and (not dmSummary.Field.IsNull) then
          begin
            summary := dmSummary.Field.AsString;
          end;

          prevWorkStyle := WorkStyle;
          Result := inherited OraclePerformance;

          if (dsCurrent.DataSet = dsTreaty.DataSet) and (prevWorkStyle in [wsAdd, wsEdit]) and result then
          begin
            if summary <> '' then
            begin
              with TOracleQuery.Create(nil) do
              begin
                Session:= dmGlobal.seOracle;
                DeclareVariable('TREATY_ID', otInteger);
                DeclareVariable('SUMMARY', otSTRING);
                SetVariable('TREATY_ID', dsTreaty.DataSet.FieldValues['ID']);
                SetVariable('SUMMARY', summary);
                DeclareVariable('R', otString);
                SetVariable('R', TOracleDataSet(dsTreaty.DataSet).RowId);
                //SQL.Add('DECLARE n NUMBER;');
                SQL.Add('BEGIN');
                //SQL.Add('SELECT ID INTO n FROM RN.MNTREATY WHERE ROWID = :R;');
                //SQL.Add('IF :TREATY_ID IS NULL THEN RN.mntreaty_pkg.copy_agrnum0(n); END IF;');
                SQL.Add('INSERT INTO mnsummary (TREATY_ID, SUMMARY) VALUES (nvl(:TREATY_ID, (SELECT ID FROM RN.MNTREATY WHERE ROWID = :R)), :SUMMARY);');
                SQL.Add('END;');
                Execute;

                Destroy;
              end;
            end;

            currWorkStyle := WorkStyle;
            dsCurrent.DataSet.Refresh;
            if currWorkStyle <> WorkStyle then
              WorkStyle := currWorkStyle;
          end;

          if Result then
            Session.Commit
          else
          begin
            Session.Rollback;
          end;
        except
          //on Exception do
          //begin
            Result := false;
            Session.Rollback;
            raise;
          //end;
        end;
      finally
        Session.AutoCommit := LAutoCommit;
      end;
    end;
  end
  else if (dsCurrent.DataSet = dsAgreem.DataSet) and (WorkStyle in [wsEdit, wsAdd, wsDelete]) then
  begin
    // Сохранение данных на закладке доп. соглашения
    // путем выполнения нескольких транзакций.
    // Если происходит ошибка при выполнении транзакции,
    // а до нее было выполнено хотя бы одна транзакция,
    // то в БД будет сохранено не корректные сведенья.
    // Чтобы этого не произошло, свойству autoCommit присваиваем значение false,
    // а после выполнения удачно всех транзакций выполняем команду Commit,
    // в случае если в ходе выполнений транзакций произошла ошибка, то выполняем команду Rollback.
    with dsAgreem.DataSet as TVASUPQuery do
    begin
      LAutoCommit := Session.AutoCommit;
      try
        try
          Session.AutoCommit := false;

          Result := inherited OraclePerformance;

          if Result then
            Session.Commit
          else
          begin
            Session.Rollback;
          end;
        except
          //on Exception do
          //begin
            Result := false;
            Session.Rollback;
            raise;
          //end;
        end;
      finally
        Session.AutoCommit := LAutoCommit;
      end;
    end;
  end
  else if ((dsCurrent.DataSet = dsAgreemStage.DataSet) or (dsCurrent.DataSet = dsTreatyStage.DataSet)) and (WorkStyle in [wsEdit, wsAdd, wsDelete]) then
  begin
    // Сохранение данных на закладке доп. соглашения
    // путем выполнения нескольких транзакций.
    // Если происходит ошибка при выполнении транзакции,
    // а до нее было выполнено хотя бы одна транзакция,
    // то в БД будет сохранено не корректные сведенья.
    // Чтобы этого не произошло, свойству autoCommit присваиваем значение false,
    // а после выполнения удачно всех транзакций выполняем команду Commit,
    // в случае если в ходе выполнений транзакций произошла ошибка, то выполняем команду Rollback.
    with dsCurrent.DataSet as TVASUPQuery do
    begin
      LAutoCommit := Session.AutoCommit;
      try
        try
          Session.AutoCommit := false;

          Result := inherited OraclePerformance;

          if Result then
            Session.Commit
          else
          begin
            Session.Rollback;
          end;
        except
          //on Exception do
          //begin
            Result := false;
            Session.Rollback;
            raise;
          //end;
        end;
      finally
        Session.AutoCommit := LAutoCommit;
      end;
    end;

    TOracleDataSet(dsTreaty.DataSet).RefreshRecord;
    if dsCurrent.DataSet = dsAgreemStage.DataSet then
      TOracleDataSet(dsAgreem.DataSet).RefreshRecord;
  end
  else
  begin
    Result := inherited OraclePerformance;

    if (dsTrCurator.DataSet = dsCurrent.DataSet) and (WorkStyle <> wsQuery) then
      TOracleDataSet(dsTreaty.DataSet).RefreshRecord;
  end;
end;

procedure TfmTreatyCard.dbgCurrStageGetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
var
  flSW_STAGE : TField;

begin
  inherited;
 with dmGlobal do
 begin
  if (dsCurrStage.DataSet= odsCurrStage) then
  begin
   if not odsCurrStageDATEACT.IsNull
   then  if not odsCurrStageDATEPAY.IsNull then AFont.Color:= clBlue
                                            else AFont.Color:= clGreen

  end;

  if not Highlight then
  begin
    if Field.FieldName = 'NUM' then
    begin
      flSW_STAGE := dsCurrStage.DataSet.FieldByName('SW_STAGE');
      if (not dsCurrStage.DataSet.IsEmpty) and (not flSW_STAGE.IsNull) then
      begin
        if PLAT_DOC_TYPE <> 3025 then
        begin
          if flSW_STAGE.AsInteger = 1 then
          begin
            Background := clGreen;
            AFont.Color:= clWhite;
          end
          else if flSW_STAGE.AsInteger = 2 then
          begin
            Background := clDkGray;
            AFont.Color:= clWhite;
          end;
        end;
      end;
    end;
    if Field.FieldName = 'SUMMPAY' Then
    begin
      if dsCurrStage.DataSet.FieldByName('CURRENCY_NO').AsInteger = 933 then
        (Field as TFloatField).DisplayFormat := '#,###,###,###,###,##0.00'
      else
        (Field as TFloatField).DisplayFormat := '#,###,###,###,###,##0.##';
    end;
  end;

 end;
end;


procedure TfmTreatyCard.dbgCurrStageDblClick(Sender: TObject);
var
 stage_id : Extended;
 agreem_id : Extended;
begin
  inherited;
  with dmGlobal do
  begin
   if not odsCurrStageID.IsNull then
   begin
    stage_id := odsCurrStageID.Value; agreem_id := odsCurrStageAGREEM_ID.Value;
    if odsCurrStageAGREEM_NUM.Value <> 0 then
    begin
     SelectNode(dmGlobal.quAgreem);
     while not(quAgreemID.Value = agreem_id) and not quAgreem.eof do
     begin
      quAgreem.Next;
     end;
     SelectNode(quAgreemStage);
     quAgreemStage.First;
     while not(quAgreemStageID.Value = stage_id) and not quAgreemStage.eof do
     begin
      quAgreemStage.Next;
     end;
    end
    else
    begin
     SelectNode(quTreatyStage);
     quTreatyStage.First;
     while not(quTreatyStageID.Value = stage_id) and not quTreatyStage.eof do
     begin
      quTreatyStage.Next;
     end;
    end;
   end;
  end;
end;

procedure TfmTreatyCard.DenyAccess;
begin
  inherited;
  if (dsCurrent.DataSet = dsExpectedIncome.DataSet) AND (WorkStyle <> wsQuery)
      AND (dsExpectedIncome.DataSet.RecordCount >= 1) then
  begin
    AccessRights := AccessRights - [aqInserting];
    SpecifyToolBtnState;
    SetPopItems;
    if Application.MainForm.ActiveMDIChild=Self then
      Application.MainForm.Perform(UM_OTHERS,IN_ACTIVATE,0);
    Perform(UM_OTHERS,IN_STATUS,0);
  end;
end;

procedure TfmTreatyCard.dsExpectedIncomeDataChange(Sender: TObject;
  Field: TField);
begin
  if (Field=nil) and (dsCurrent.DataSet = dsExpectedIncome.DataSet) then
    DenyAccess;

end;

procedure TfmTreatyCard.SetFilter;
var
  NameOfStatusField : String;

  Filter : String;
begin
  // Определяем  наименования поля STATUS
  if dmGlobal.quTreaty.FieldByName('STATUS').Origin <> '' then
    NameOfStatusField := dmGlobal.quTreaty.FieldByName('STATUS').Origin
  else
    NameOfStatusField := 'STATUS';


  Filter := '';
  // Формируем фильтр
  case rgFilter.ItemIndex of
    1 : Filter := NameOfStatusField + '= ''P''';
    2 : Filter := NameOfStatusField + '= ''O''';
    3 : Filter := NameOfStatusField + '= ''F''';
  end;

  if Filter <> '' then
    // Устанвливаем фильтр
    dmGlobal.quTreaty.SetUserFilter(Filter)
  else
    dmGlobal.quTreaty.DeleteUserFilter;

  // Обновляем SQL запрос у Vertex и у других мастров dmAgreem.quOtgr связи с изменением фильтра
  dmGlobal.quTreaty.RefrUserQuery(Vertex);

  if WorkStyle <> wsQuery then
    Perform(UM_OTHERS,IN_REFRESH,MS_NORMAL);
end;

procedure TfmTreatyCard.rgFilterClick(Sender: TObject);
begin
  inherited;
  SetFilter;
end;

procedure TfmTreatyCard.FormShow(Sender: TObject);
begin
  inherited;
  SetFilter;
  refrAllSW;
end;

procedure TfmTreatyCard.dbrgTreatyStatusChange(Sender: TObject);
begin
  inherited;
  if Assigned(dbrgTreatyStatus.Field) and (WorkStyle = wsAdd)  then
    dbrgTreatyStatus.Field.Value := dbrgTreatyStatus.Value;
end;

procedure TfmTreatyCard.LockTreaty;
var
  Query : TOracleQuery;
begin
  Query := TOracleQuery.Create(nil);

  try
    Query.Session := TOracleDataSet(dsTreaty.DataSet).Session;
    Query.SQL.Add('SELECT *');
    Query.SQL.Add('  FROM MNTREATY T,');
    Query.SQL.Add('       MNAGREEM AGR,');
    Query.SQL.Add('       MNSUMMARY SUMMARY');
    Query.SQL.Add(' WHERE AGR.TREATY_ID = T.ID');
    Query.SQL.Add('   AND AGR.NUM = 0');
    Query.SQL.Add('   AND SUMMARY.TREATY_ID(+) = T.ID');
    Query.SQL.Add('   AND T.ID = :ID');
    Query.SQL.Add('FOR UPDATE NOWAIT');
    Query.DeclareVariable('ID', otFloat);
    Query.SetVariable('ID', dsTreaty.DataSet.FieldByName('ID').Value);
    Query.Execute;
  finally
    Query.Destroy;
  end;
end;

procedure TfmTreatyCard.LockAgreem;
var
  Query : TOracleQuery;
begin
  Query := TOracleQuery.Create(nil);

  try
    Query.Session := TOracleDataSet(dsTreaty.DataSet).Session;
    Query.SQL.Add('SELECT *');
    Query.SQL.Add('  FROM MNAGREEM A');
    Query.SQL.Add(' WHERE A.TREATY_ID = :TREATY_ID');
    Query.SQL.Add('   AND A.NUM = :NUM');
    Query.SQL.Add('FOR UPDATE NOWAIT');
    Query.DeclareVariable('TREATY_ID', otFloat);
    Query.DeclareVariable('NUM', otFloat);
    Query.SetVariable('TREATY_ID', dsAgreem.DataSet.FieldByName('TREATY_ID').Value);
    Query.SetVariable('NUM', dsAgreem.DataSet.FieldByName('NUM').Value);
    Query.Execute;
  finally
    Query.Destroy;
  end;
end;

procedure TfmTreatyCard.LockAgreemStage;
var
  Query : TOracleQuery;
begin
  Query := TOracleQuery.Create(nil);

  try
    Query.Session := TOracleDataSet(dsTreaty.DataSet).Session;
    Query.SQL.Add('SELECT *');
    Query.SQL.Add('  FROM MNSTAGE S');
    Query.SQL.Add(' WHERE S.ID = :ID');
    Query.SQL.Add('FOR UPDATE NOWAIT');
    Query.DeclareVariable('ID', otFloat);
    Query.SetVariable('ID', dsAgreemStage.DataSet.FieldByName('ID').Value);
    Query.Execute;
  finally
    Query.Destroy;
  end;
end;

procedure TfmTreatyCard.LockTreatyStage;
var
  Query : TOracleQuery;
begin
  Query := TOracleQuery.Create(nil);

  try
    Query.Session := TOracleDataSet(dsTreaty.DataSet).Session;
    Query.SQL.Add('SELECT *');
    Query.SQL.Add('  FROM MNSTAGE S');
    Query.SQL.Add(' WHERE S.ID = :ID');
    Query.SQL.Add('FOR UPDATE NOWAIT');
    Query.DeclareVariable('ID', otFloat);
    Query.SetVariable('ID', dsTreatyStage.DataSet.FieldByName('ID').Value);
    Query.Execute;
  finally
    Query.Destroy;
  end;
end;

{function TfmTreatyCard.EnabledDelLetter : boolean;
var
  CurrentBookMark : TBookMark;
  fldSpecial_WRITTEN : TField;
  i : Integer;
begin
  if (WorkStyle in [wsView]) and
     ((dsCurrent.DataSet = dsTreatyStage.DataSet) or (dsCurrent.DataSet = dsAgreemStage.DataSet)) then
  begin
    Result := false;
    if FCheckingLetter then
      Exit;

    FCheckingLetter := true;

    try
      fldSpecial_WRITTEN := DBGrid.DataSource.DataSet.FieldByName('SPECIAL_WRITTEN');
      if DBGrid.SelectedRows.Count>0 then
      begin
        Result := false;

        // Были выбраны этапы
        // Ищем среди выбраных этапов есть ли этапы со служебными письмами
        with DBGrid.DataSource.DataSet do
        begin
          CurrentBookMark := GetBookmark;
          DisableControls;
          i := 0;
          while (not Result) and (i < DBGrid.SelectedRows.Count) do
          begin
            GotoBookmark(pointer(DBGrid.SelectedRows.Items[i]));
            if not fldSpecial_WRITTEN.IsNull then
              Result := true;

            inc(i);
          end;
          GotoBookmark(CurrentBookMark);
          EnableControls;
        end;
      end
      else
        Result := not fldSpecial_WRITTEN.IsNull;
    finally
      FCheckingLetter := false;
    end;

  end
  else
    Result := false;
end;

function TfmTreatyCard.getNameOfDelLetter : string;
var
  CurrentBookMark : TBookMark;
  fldSpecial_WRITTEN : TField;
  i, j : Integer;
  CountLetter : Integer;
  vars : Array Of Variant;
  b : boolean;
begin
  Result := 'Удалить служебное письмо в БД МТО';

  SetLength(vars, 0);
  CountLetter := 0;

  if (WorkStyle in [wsView, wsEdit]) and
     ((dsCurrent.DataSet = dsTreatyStage.DataSet) or (dsCurrent.DataSet = dsAgreemStage.DataSet)) then
  begin
    if FCheckingLetter then
      Exit;

    FCheckingLetter := true;

    try
      fldSpecial_WRITTEN := DBGrid.DataSource.DataSet.FieldByName('SPECIAL_WRITTEN');
      if DBGrid.SelectedRows.Count>0 then
      begin

        // Были выбраны этапы
        // Ищем среди выбраных этапов есть ли этапы со служебными письмами
        with DBGrid.DataSource.DataSet do
        begin
          CurrentBookMark := GetBookmark;
          DisableControls;

          for i := 0 to DBGrid.SelectedRows.Count - 1 do
          begin
            GotoBookmark(pointer(DBGrid.SelectedRows.Items[i]));
            if not fldSpecial_WRITTEN.IsNull then
            begin
              if CountLetter > 0 then
              begin
                // Проверяем есть ли  сл. письмо тек. записи в vars
                b := false;
                for j := 0 to CountLetter - 1 do
                  if vars[j] = fldSpecial_WRITTEN.Value then
                  begin
                    b := true;
                    break;
                  end;

                if not b then
                begin
                  // Нету в vars сл. письмо тек. записи
                  // Добовляем его
                  inc(CountLetter);
                  SetLength(vars, CountLetter);
                  vars[CountLetter - 1] := fldSpecial_WRITTEN.Value;
                end;
              end
              else
              begin
                CountLetter := 1;
                SetLength(vars, CountLetter);
                vars[0] := fldSpecial_WRITTEN.Value;
              end
            end;
          end;
          GotoBookmark(CurrentBookMark);
          EnableControls;
        end;

        if CountLetter > 1 then
        begin
          Result := 'Удалить служебные письма в БД МТО (' + IntToStr(CountLetter)+ ' ';
          if CountLetter < 4 then
            Result := Result + 'письма)'
          else
            Result := Result + 'писем)';
        end;
      end;

    finally
      FCheckingLetter := false;
    end;
  end;
end;}

function TfmTreatyCard.CorrectSummpay : boolean;
var
  d : TdateTime;
begin
  d := EncodeDate(2004, 1, 1);
  Result := not((WorkStyle <> wsQuery) and
            (dsTreaty.DataSet.RecordCount > 0) and
            (((dsTreaty.DataSet.FieldByName('DATEFROM').AsDateTime < d) and (dsTreaty.DataSet.FieldByName('AGR_SUMMPAY').Value < dsTreaty.DataSet.FieldByName('ST_SUMMPAY').Value))
             or ((dsTreaty.DataSet.FieldByName('DATEFROM').AsDateTime >= d) and(dsTreaty.DataSet.FieldByName('AGR_SUMMPAY').Value <> dsTreaty.DataSet.FieldByName('ST_SUMMPAY').Value)))
             and
            (dsTreaty.DataSet.FieldByName('STATUS').Value <> NULL) and
            (dsTreaty.DataSet.FieldByName('STATUS').AsString <> 'A') AND
            (dsTreaty.DataSet.FieldByName('STATUS').AsString <> 'P'));
end;

function TfmTreatyCard.CorrectSummpayTreaty : boolean;
var
  d : TdateTime;
begin
  d := EncodeDate(2004, 1, 1);
  Result := not ((WorkStyle <> wsQuery) and
            (dsTreaty.DataSet.RecordCount > 0) and
            (((dsTreaty.DataSet.FieldByName('DATEFROM').AsDateTime < d) and (dsTreaty.DataSet.FieldByName('TR_SUMMPAY').Value > dsTreaty.DataSet.FieldByName('SUMMPAY').Value))
             or ((dsTreaty.DataSet.FieldByName('DATEFROM').AsDateTime >= d) and (dsTreaty.DataSet.FieldByName('TR_SUMMPAY').Value <> dsTreaty.DataSet.FieldByName('SUMMPAY').Value)))
             and

            (dsTreaty.DataSet.FieldByName('STATUS').Value <> NULL) and
            (dsTreaty.DataSet.FieldByName('STATUS').AsString <> 'A') AND
            (dsTreaty.DataSet.FieldByName('STATUS').AsString <> 'P'));
end;

function TfmTreatyCard.CorrectSummpayAgreem : boolean;
var
  d : TdateTime;
begin
  d := EncodeDate(2004, 1, 1);
  Result := not((WorkStyle <> wsQuery) and
            (dsAgreem.DataSet.RecordCount > 0) and
            (((dsTreaty.DataSet.FieldByName('DATEFROM').AsDateTime < d) and (dsAgreem.DataSet.FieldByName('ST_SUMMPAY').Value > dsAgreem.DataSet.FieldByName('SUMMPAY').Value))
             or ((dsTreaty.DataSet.FieldByName('DATEFROM').AsDateTime >= d) and (dsAgreem.DataSet.FieldByName('ST_SUMMPAY').Value <> dsAgreem.DataSet.FieldByName('SUMMPAY').Value))));
end;

function TfmTreatyCard.CorrectNDS : boolean;
begin
  Result := not((WorkStyle <> wsQuery) and
            (dsTreaty.DataSet.RecordCount > 0) and
            (dsTreaty.DataSet.FieldByName('AGR_NDS').Value <> dsTreaty.DataSet.FieldByName('ST_NDS').Value) and
            (dsTreaty.DataSet.FieldByName('STATUS').Value <> NULL) and
            (dsTreaty.DataSet.FieldByName('STATUS').AsString <> 'A') AND
            (dsTreaty.DataSet.FieldByName('STATUS').AsString <> 'P'));
end;

function TfmTreatyCard.CorrectNDSTreaty : boolean;
begin
  Result := not ((WorkStyle <> wsQuery) and
            (dsTreaty.DataSet.RecordCount > 0) and
            (dsTreaty.DataSet.FieldByName('TR_NDS').Value <> dsTreaty.DataSet.FieldByName('NDS_SUMMPAY').Value) and
            (dsTreaty.DataSet.FieldByName('STATUS').Value <> NULL) and
            (dsTreaty.DataSet.FieldByName('STATUS').AsString <> 'A') AND
            (dsTreaty.DataSet.FieldByName('STATUS').AsString <> 'P'));
end;

function TfmTreatyCard.CorrectNDSAgreem : boolean;
begin
  Result := not((WorkStyle <> wsQuery) and
            (dsAgreem.DataSet.RecordCount > 0) and
            (dsAgreem.DataSet.FieldByName('ST_NDS').Value <> dsAgreem.DataSet.FieldByName('NDS_SUMMPAY').Value));
end;

procedure TfmTreatyCard.dsAgreemDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if not CorrectSummpayAgreem then
  begin
    deAddSummPay.Color := RGB(255, 128, 255);
    deAddSummPay.Font.Color:= RGB(128, 0, 128);
  end
  else
  begin
    deAddSummPay.Color := clWhite;
    deAddSummPay.Font.Color:= clBlack;
  end;

  if not CorrectNDSAgreem then
  begin
    deAgrNDSSummPay.Color := RGB(255, 128, 255);
    deAgrNDSSummPay.Font.Color:= RGB(128, 0, 128);
  end
  else
  begin
    deAgrNDSSummPay.Color := clWhite;
    deAgrNDSSummPay.Font.Color:= clBlack;
  end;

  btnCorrAgrNDS.Visible := (dsCurrent.DataSet = dsAgreem.DataSet) AND(WorkStyle = wsView) AND (dsAgreem.DataSet.RecordCount > 0) AND (not CorrectNDSAgreem);
end;

procedure TfmTreatyCard.DoBeforePost(ASUPQuery: TVASUPQuery);
var
  fieldNUMACT  : TField;
  fieldDATEACT : TField;
  fieldCREATE_DATE : TField;
begin
  inherited;

  if (dsCurrent.DataSet = dsAgreemStage.DataSet) or (dsCurrent.DataSet = dsTreatyStage.DataSet) then
  begin
    fieldNUMACT  := ASUPQuery.FieldByName('NUMACT');
    fieldDATEACT := ASUPQuery.FieldByName('DATEACT');
    fieldCREATE_DATE := ASUPQuery.FieldByName('CREATE_AKT');
    if (not fieldNUMACT.IsNull) and (not fieldDATEACT.IsNull) then
    begin
      if fieldCREATE_DATE.IsNull then
        fieldCREATE_DATE.Value := Now
      else
      begin
        if (fieldNUMACT.OldValue <> fieldNUMACT.NewValue) or (fieldDATEACT.OldValue <> fieldDATEACT.NewValue) then
          fieldCREATE_DATE.Value := Now;
      end;
    end
    else
    begin
      if not fieldCREATE_DATE.IsNull then
        fieldCREATE_DATE.Value := Null;
    end;

    case WorkStyle of
      wsAdd:  InsertBeforeStage(ASUPQuery);
      wsEdit: EditBeforeStage(ASUPQuery);
    end;
  end;
end;

procedure TfmTreatyCard.DoAfterPost(ASUPQuery: TVASUPQuery);
begin
  inherited;

  if (dsCurrent.DataSet = dsAgreemStage.DataSet) or (dsCurrent.DataSet = dsTreatyStage.DataSet) then
  begin
    case WorkStyle of
      wsAdd:  InsertAfterStage(ASUPQuery);
      wsEdit: EditAfterStage(ASUPQuery);
    end;

    refrAllSW;
  end;

  if (dsCurrent.DataSet = dsTreaty.DataSet) and (WorkStyle = wsEdit) then
  begin
     dmGlobal.opNIOKR_Tax.CallProcedure('calcTreatyNDS', [dsTreaty.DataSet.FieldByName('ID').AsInteger, dsTreaty.DataSet.FieldByName('NDS').Value]);
  end;

  if (dsCurrent.DataSet = dsAgreem.DataSet) and (WorkStyle = wsEdit) then
  begin
     dmGlobal.opNIOKR_Tax.CallProcedure('calcAgreemNDS', [dsAgreem.DataSet.FieldByName('ID').AsInteger, dsAgreem.DataSet.FieldByName('NDS').Value]);
  end;
end;

procedure TfmTreatyCard.DoAfterInsert(ASUPQuery: TVASUPQuery);
var
  query : TOracleQuery;
  summpay : double;
begin
  if (ASUPQuery = dsTreaty.DataSet) and (ASUPQuery.WorkState <> wsQuery) then
    ASUPQuery.FieldByName('NDS').Value := 20
  else if (ASUPQuery = dsAgreem.DataSet) and (ASUPQuery.WorkState <> wsQuery) then
  begin
    query := TOracleQuery.Create(nil);
    try
      query.Session := dmGlobal.seOracle;
      query.SQL.Text := 'SELECT * FROM RN.vitreaty where treaty_id = :ID';
      query.DeclareVariable('ID', otInteger);
      query.SetVariable('ID', dsTreaty.DataSet.FieldByName('ID').Value);
      query.Execute;

      ASUPQuery.FieldByName('NDS').Value := query.Field('NDS');
      ASUPQuery.FieldByName('NDS_SUMMPAY').Value := query.Field('NDS_SUMMPAY');

      ASUPQuery.FieldByName('SUBJECT').Value := query.Field('SUBJECT');
      ASUPQuery.FieldByName('ISTFIN_KOD').Value := query.Field('ISTFIN_KOD');
      ASUPQuery.FieldByName('PAYMENT_KOD').Value := query.Field('PAYMENT_KOD');
      ASUPQuery.FieldByName('SUMMPAY').Value := query.Field('SUMMPAY');
    finally
      query.Destroy;
    end;
  end
  else if (ASUPQuery = dsTreatyStage.DataSet) and (ASUPQuery.WorkState <> wsQuery) then
  begin
    ASUPQuery.FieldByName('NDS').Value := dsTreaty.DataSet.FieldByName('NDS').Value;
  end
  else if (ASUPQuery = dsAgreemStage.DataSet) and (ASUPQuery.WorkState <> wsQuery) then
  begin
    ASUPQuery.FieldByName('NDS').Value := dsAgreem.DataSet.FieldByName('NDS').Value;
  end;
end;

procedure TfmTreatyCard.DoBeforeDelete(ASUPQuery: TVASUPQuery);
var
  fieldAKT_NO  : TField;
  fieldSPECIAL_WRITTEN  : TField;
begin
  if (dsCurrent.DataSet = dsAgreemStage.DataSet) or (dsCurrent.DataSet = dsTreatyStage.DataSet) then
  begin
    fieldAKT_NO  := ASUPQuery.FieldByName('AKT_NO');
    fieldSPECIAL_WRITTEN  := ASUPQuery.FieldByName('SPECIAL_WRITTEN');
    FAKT_NO := fieldAKT_NO.AsString;
    FSPECIAL_WRITTEN := fieldSPECIAL_WRITTEN.AsString;
  end;
end;

procedure TfmTreatyCard.DoAfterDelete(ASUPQuery: TVASUPQuery);
begin
  if (dsCurrent.DataSet = dsAgreemStage.DataSet) or (dsCurrent.DataSet = dsTreatyStage.DataSet) then
  begin
    dmGlobal.opNII_EVM_SERVIS.CallProcedure('DelActExecut', [NULL, FAKT_NO]);

    if FSPECIAL_WRITTEN <> '' then
      dmGlobal.opNII_EVM_SERVIS.CallProcedure('DelSpecialWritten', [FSPECIAL_WRITTEN]);

    refrAllSW;
  end;
end;

procedure TfmTreatyCard.DoAfterOpen(ASUPQuery: TVASUPQuery);
begin
  if dsCurrent.DataSet = dsTreaty.DataSet then
    refrAllSW;
end;

procedure TfmTreatyCard.DoAfterRefresh(ASUPQuery: TVASUPQuery);
begin
  if (dsCurrent.DataSet = dsTreaty.DataSet) or (dsCurrent.DataSet = dsAgreemStage.DataSet) or (dsCurrent.DataSet = dsTreatyStage.DataSet) then
    refrAllSW;
end;

procedure TfmTreatyCard.InsertBeforeStage(ASUPQuery : TVASUPQuery);
var
  fieldNUMACT  : TField;
  fieldDATEACT : TField;
  fieldAKT_NO  : TField;
  fieldSPECIAL_WRITTEN : TField;
  fieldTREATY_NO : TField;
  fieldAGREEM_NO : TField;
  fieldCREATE_DATE : TField;
  fieldAgreem_ID : TField;
  fieldSummpay : TField;
begin
  fieldNUMACT  := ASUPQuery.FieldByName('NUMACT');
  fieldDATEACT := ASUPQuery.FieldByName('DATEACT');
  fieldAKT_NO  := ASUPQuery.FieldByName('AKT_NO');
  fieldTREATY_NO := dsTreaty.DataSet.FieldByName('DOC_NO');
  fieldCREATE_DATE := ASUPQuery.FieldByName('CREATE_AKT');
  fieldSPECIAL_WRITTEN := ASUPQuery.FieldByName('SPECIAL_WRITTEN');
  fieldAgreem_ID  := ASUPQuery.FieldByName('AGREEM_ID');
  fieldSummpay := ASUPQuery.FieldByName('SUMMPAY');
  if (not fieldNUMACT.IsNull) and (not fieldDATEACT.IsNull) and (not fieldSummpay.IsNull) and (fieldSummpay.AsFloat <> 0.0) then
  begin
    fieldAKT_NO.Value := dmGlobal.opNII_EVM_SERVIS.CallStringFunction('AddActExecut', [fieldNUMACT.Value, fieldDATEACT.Value, fieldAgreem_ID.value]);

    if dsAgreemStage.DataSet = ASUPQuery then
    begin
      fieldAGREEM_NO := dsAgreem.DataSet.FieldByName('DOC_NO');
      fieldSPECIAL_WRITTEN.Value := dmGlobal.opNII_EVM_SERVIS.CallStringFunction('AddSpecialWritten', [fieldAKT_NO.Value, fieldCREATE_DATE.Value, fieldTREATY_NO.Value, fieldAGREEM_NO.Value]);
    end
    else
      fieldSPECIAL_WRITTEN.Value := dmGlobal.opNII_EVM_SERVIS.CallStringFunction('AddSpecialWritten', [fieldAKT_NO.Value, fieldCREATE_DATE.Value, fieldTREATY_NO.Value, NULL]);
  end;
end;

procedure TfmTreatyCard.InsertAfterStage(ASUPQuery : TVASUPQuery);
var
  //fieldCUST   : TField;
  //fieldEXEC   : TField;
  //fieldID     : TField;
  fieldAKT_NO : TField;
  fieldSPECIAL_WRITTEN : TField;
begin
  //fieldID     := ASUPQuery.FieldByName('ID');
  fieldAKT_NO := ASUPQuery.FieldByName('AKT_NO');
  fieldSPECIAL_WRITTEN := ASUPQuery.FieldByName('SPECIAL_WRITTEN');
  if not fieldAKT_NO.IsNull then
  begin
    dmGlobal.opNII_EVM_SERVIS.CallProcedure('ModifyActExecut', [fieldAKT_NO.Value]);
    dmGlobal.opNII_EVM_SERVIS.CallProcedure('ModifySpecialWritten', [fieldSPECIAL_WRITTEN.Value]);
  end;
end;

procedure TfmTreatyCard.EditBeforeStage(ASUPQuery : TVASUPQuery);
var
  fieldNUMACT  : TField;
  fieldDATEACT : TField;
  fieldID     : TField;
  fieldAKT_NO  : TField;
  fieldSPECIAL_WRITTEN : TField;
  fieldTREATY_NO : TField;
  fieldAGREEM_NO : TField;
  fieldCREATE_DATE : TField;
  fieldAgreem_ID : TField;
  fieldSummpay : TField;
begin
  fieldNUMACT  := ASUPQuery.FieldByName('NUMACT');
  fieldDATEACT := ASUPQuery.FieldByName('DATEACT');
  fieldID     := ASUPQuery.FieldByName('ID');
  fieldAKT_NO  := ASUPQuery.FieldByName('AKT_NO');
  fieldSPECIAL_WRITTEN := ASUPQuery.FieldByName('SPECIAL_WRITTEN');
  fieldCREATE_DATE := ASUPQuery.FieldByName('CREATE_AKT');
  fieldTREATY_NO := dsTreaty.DataSet.FieldByName('DOC_NO');
  FAKT_NO := fieldAKT_NO.AsString;
  FSPECIAL_WRITTEN := fieldSPECIAL_WRITTEN.AsString;
  fieldAgreem_ID  := ASUPQuery.FieldByName('AGREEM_ID');
  fieldSummpay := ASUPQuery.FieldByName('SUMMPAY');
  if (not fieldNUMACT.IsNull) and (not fieldDATEACT.IsNull) and (not fieldSummpay.IsNull) and (fieldSummpay.AsFloat <> 0.0) then
  begin
    if fieldAKT_NO.IsNull then
      fieldAKT_NO.Value := dmGlobal.opNII_EVM_SERVIS.CallStringFunction('AddActExecut', [fieldNUMACT.Value, fieldDATEACT.Value, fieldAgreem_ID.value])
    else
      fieldAKT_NO.Value := dmGlobal.opNII_EVM_SERVIS.CallStringFunction('UpdActExecut', [fieldID.Value, fieldNUMACT.Value, fieldDATEACT.Value, fieldAgreem_ID.value]);

    if dsAgreemStage.DataSet = ASUPQuery then
    begin
      fieldAGREEM_NO := dsAgreem.DataSet.FieldByName('DOC_NO');
      fieldSPECIAL_WRITTEN.Value := dmGlobal.opNII_EVM_SERVIS.CallStringFunction('AddSpecialWritten', [fieldAKT_NO.Value, fieldCREATE_DATE.Value, fieldTREATY_NO.Value, fieldAGREEM_NO.Value]);
    end
    else
      fieldSPECIAL_WRITTEN.Value := dmGlobal.opNII_EVM_SERVIS.CallStringFunction('AddSpecialWritten', [fieldAKT_NO.Value, fieldCREATE_DATE.Value, fieldTREATY_NO.Value, NULL]);
  end
  else
  begin
    fieldAKT_NO.Value := NULL;
    fieldSPECIAL_WRITTEN.Value := '';
  end;
end;

procedure TfmTreatyCard.EditAfterStage(ASUPQuery : TVASUPQuery);
var
  //fieldCUST   : TField;
  //fieldEXEC   : TField;
  fieldID     : TField;
  fieldAKT_NO : TField;
  fieldSPECIAL_WRITTEN : TField;
begin
  //fieldCUST   := ASUPQuery.FieldByName('CUST_ACCOUNT_ID');
  //fieldEXEC   := ASUPQuery.FieldByName('EXEC_ACCOUNT_ID');
  fieldID     := ASUPQuery.FieldByName('ID');
  fieldAKT_NO := ASUPQuery.FieldByName('AKT_NO');
  fieldSPECIAL_WRITTEN := ASUPQuery.FieldByName('SPECIAL_WRITTEN');

  if (fieldAKT_NO.AsString <> FAKT_NO) AND (FAKT_NO <> '') then
    dmGlobal.opNII_EVM_SERVIS.CallProcedure('DelActExecut', [fieldID.Value, FAKT_NO]);

  if (fieldSPECIAL_WRITTEN.AsString <> FSPECIAL_WRITTEN) AND (FSPECIAL_WRITTEN <> '') then
    dmGlobal.opNII_EVM_SERVIS.CallProcedure('DelSpecialWritten', [FSPECIAL_WRITTEN]);

  if not fieldAKT_NO.IsNull then
  begin
    dmGlobal.opNII_EVM_SERVIS.CallProcedure('ModifyActExecut', [fieldAKT_NO.Value]);
  end;

  if not fieldSPECIAL_WRITTEN.IsNull then
  begin
    dmGlobal.opNII_EVM_SERVIS.CallProcedure('ModifySpecialWritten', [fieldSPECIAL_WRITTEN.Value]);
  end;
end;

procedure TfmTreatyCard.refrTreatySW;
var
  flCreateSW : TField;
  flReworkSW : TField;
begin
  if WorkStyle <> wsQuery then
  begin
    with dsTreaty.DataSet do
    begin
      flCreateSW := FieldByName('CREATE_SW');
      flReworkSW := FieldByName('REWORK_SW');
      if (not IsEmpty) and (not flCreateSW.IsNull) and (flCreateSW.AsInteger > 0) then
      begin
        lblCreateSW.Visible := true;

        edCreateSW.Text := flCreateSW.AsString;
        edCreateSW.Visible := true;
      end
      else
      begin
        lblCreateSW.Visible := false;
        edCreateSW.Visible := false;
      end;

      if (not IsEmpty) and (not flReworkSW.IsNull) and (flReworkSW.AsInteger > 0) then
      begin
        lblReworkSW.Visible := true;

        edReworkSW.Text := flReworkSW.AsString;
        edReworkSW.Visible := true;
      end
      else
      begin
        lblReworkSW.Visible := false;
        edReworkSW.Visible := false;
      end;
    end;
  end
  else
  begin
    lblCreateSW.Visible := false;
    edCreateSW.Visible := false;

    lblReworkSW.Visible := false;
    edReworkSW.Visible := false;
  end;
end;

procedure TfmTreatyCard.refrAllSW;
var
  query : TOracleQuery;
begin
  query := TOracleQuery.Create(nil);
  query.Session := TOracleDataSet(dsTreaty.DataSet).Session;

  try
    query.SQL.Text := 'SELECT count(DISTINCT d.DOC_NO) FROM RN.mntreaty tr, RN.mnagreem agr, RN.mnstage st, M.DOCUMENTS d where st.agreem_id = agr.id AND agr.treaty_id = tr.id AND st.SPECIAL_WRITTEN = d.DOC_NO AND tr.plat_doc_type <> 3025 and d.doc_stage = ' + Chr(39) + '1' + Chr(39);
    query.Execute;

    if query.FieldAsInteger(0) > 0 then
    begin
      lblCreateAllSW.Caption := 'Кол. всех платёжных документов в статусе ВВЕДЕНО:' +  query.FieldAsString(0);
      lblCreateAllSW.Visible := true;
    end
    else
      lblCreateAllSW.Visible := false;

    query.SQL.Text := 'SELECT count(DISTINCT d.DOC_NO) FROM RN.mntreaty tr, RN.mnagreem agr, RN.mnstage st, M.DOCUMENTS d where st.agreem_id = agr.id AND agr.treaty_id = tr.id AND st.SPECIAL_WRITTEN = d.DOC_NO AND tr.plat_doc_type <> 3025 and d.doc_stage = ' + Chr(39) + '2' + Chr(39);
    query.Execute;

    if query.FieldAsInteger(0) > 0 then
    begin
      lblReworkAllSW.Caption := 'Кол. всех платёжных документов в статусе ДОРАБОТКА:' +  query.FieldAsString(0);
      lblReworkAllSW.Visible := true;
    end
    else
      lblReworkAllSW.Visible := false;
  finally
    query.Destroy;
  end;
end;

procedure TfmTreatyCard.refrTrStSW;
var
  flSW_STAGE : TField;
begin
  if WorkStyle <> wsQuery then
  begin
    flSW_STAGE := dsTreatyStage.DataSet.FieldByName('SW_STAGE');
    if dsTreatyStage.DataSet.Active and (not dsTreatyStage.DataSet.IsEmpty) and (not flSW_STAGE.IsNull) then
    begin
      if PLAT_DOC_TYPE <> 3025 then
      begin
        if flSW_STAGE.AsInteger = 1 then
        begin
          lblTrSt_SW.Font.Color := clGreen;
          lblTrSt_SW.Caption := 'Платёжный документ в статусе ВВЕДЕН';
          lblTrSt_SW.Visible := true;
          deTrStageNum.Color := clGreen;
          deTrStageNum.Font.Color := clWhite;
          btnTrSt_SW.Font.Color := clGreen;
          btnTrSt_SW.Visible := true;
        end
        else if flSW_STAGE.AsInteger = 2 then
        begin
          lblTrSt_SW.Font.Color := clMaroon;
          lblTrSt_SW.Caption := 'Платёжный документ в статусе ДОРАБОТКА';
          lblTrSt_SW.Visible := true;
          deTrStageNum.Color := clDkGray;
          deTrStageNum.Font.Color := clWhite;
          btnTrSt_SW.Font.Color := clMaroon;
          btnTrSt_SW.Visible := true;
        end
        else
        begin
          lblTrSt_SW.Visible := false;
          deTrStageNum.Color := clWindow;
          btnTrSt_SW.Visible := false;
        end;
      end;
    end
    else
    begin
      lblTrSt_SW.Visible := false;
      deTrStageNum.Color := clWindow;
      btnTrSt_SW.Visible := false;
    end;
  end
  else
  begin
    lblTrSt_SW.Visible := false;
    deTrStageNum.Color := clWindow;
    btnTrSt_SW.Visible := false;
  end;
end;

procedure TfmTreatyCard.refrAgrStSW;
var
  flSW_STAGE : TField;
begin
  if WorkStyle <> wsQuery then
  begin
    flSW_STAGE := dsAgreemStage.DataSet.FieldByName('SW_STAGE');
    if dsAgreemStage.DataSet.Active and (not dsAgreemStage.DataSet.IsEmpty) and (not flSW_STAGE.IsNull) then
    begin
      if PLAT_DOC_TYPE <> 3025 then
      begin
        if flSW_STAGE.AsInteger = 1 then
        begin
          lblAgrSt_SW.Font.Color := clGreen;
          lblAgrSt_SW.Caption := 'Платёжный документ в статусе ВВЕДЕН';
          lblAgrSt_SW.Visible := true;
          deAgrStageNum.Color := clGreen;
          deAgrStageNum.Font.Color := clWhite;
          btnAgrSt_SW.Font.Color := clGreen;
          btnAgrSt_SW.Visible := true;
        end
        else if flSW_STAGE.AsInteger = 2 then
        begin
          lblAgrSt_SW.Font.Color := clMaroon;
          lblAgrSt_SW.Caption := 'Платёжный документ в статусе ДОРАБОТКА';
          lblAgrSt_SW.Visible := true;
          deAgrStageNum.Color := clDkGray;
          deAgrStageNum.Font.Color := clWhite;
          btnAgrSt_SW.Font.Color := clMaroon;
          btnAgrSt_SW.Visible := true;
        end
        else
        begin
          lblAgrSt_SW.Visible := false;
          deAgrStageNum.Color := clWindow;
          btnAgrSt_SW.Visible := false;
        end;
      end;
    end
    else
    begin
      lblAgrSt_SW.Visible := false;
      deAgrStageNum.Color := clWindow;
      btnAgrSt_SW.Visible := false;
    end;
  end
  else
  begin
    lblAgrSt_SW.Visible := false;
    deAgrStageNum.Color := clWindow;
    btnAgrSt_SW.Visible := false;
  end;
end;

procedure TfmTreatyCard.btnSt_SWClick(Sender: TObject);
var
  PreWorkState : TWStyle;
  query : TOracleQuery;
begin
  PreWorkState := WorkStyle;
  if WorkStyle in [wsEdit, wsAdd] then
  begin
    WorkStyle := wsView;
    if WorkStyle <> wsView then
      Exit;
  end;

  query := TOracleQuery.Create(nil);
  query.Session := TOracleDataSet(dsCurrent.DataSet).Session;

  try
    query.SQL.Text := 'begin M.VNS_PACK.SETSWPT(:SW); end;';
    query.DeclareVariable('SW', otString);
    query.SetVariable('SW', dsCurrent.DataSet.FieldByName('SPECIAL_WRITTEN').AsString);
    query.Execute;

    If PLAT_DOC_TYPE <> 3025 Then
    begin
    query.SQL.Text := 'UPDATE M.DOCUMENTS SET DOC_STAGE = :NEW_STAGE, DOC_STATE = DECODE(DOC_STATE, 0, 1, DOC_STATE)  WHERE DOC_NO = :SW';
    query.DeclareVariable('NEW_STAGE', otInteger);
    if dsCurrent.DataSet.FieldByName('SW_STAGE').AsInteger = 1 then
      query.SetVariable('NEW_STAGE', 3)
    else
      query.SetVariable('NEW_STAGE', 7);

    {query.SQL.Add('BEGIN');
    query.SQL.Add('DELETE M.DOCS_TO_DOCS WHERE INHERITED_DOC_NO = :SW;');
    query.SQL.Add('DELETE M.SPECIAL_WRITTEN WHERE SPECIAL_NO = :SW;');
    query.SQL.Add('UPDATE RN.MNSTAGE SET SPECIAL_WRITTEN = NULL WHERE SPECIAL_WRITTEN = :SW;');
    query.SQL.Add('DELETE M.DOCUMENTS WHERE DOC_NO = :SW;');
    query.SQL.Add('END;'); }
    query.Execute;
    end;
    TOracleDataSet(dsTreaty.DataSet).RefreshRecord;
  finally
    query.Destroy;
  end;

  Perform(UM_OTHERS,IN_REFRESH,MS_NORMAL);

end;

function TfmTreatyCard.EmptyCurator : boolean;
var
  fieldCurator : TField;
begin
  fieldCurator := dsTreaty.DataSet.FieldByName('CURATOR');

  if (not fieldCurator.IsNull) and (fieldCurator.AsInteger = 0) then
    Result := true
  else
    Result := false;
end;

procedure TfmTreatyCard.refrTreeNodeOfCurator;
var
  node : TTreeNode;
  I : Integer;
begin
  i := 0;
  while (i < TreeView.Items.Count) and (dsTrCurator.DataSet <> TreeView.Items[i].Data)  do
    inc(i);

  if i <  TreeView.Items.Count then
  begin
    node := TreeView.Items[i];
    if EmptyCurator then
    begin
      if node.ImageIndex < 0 then
      begin
        node.ImageIndex := 1;
        TreeView.Repaint;
      end;
    end
    else
    begin
      if node.ImageIndex = 1 then
      begin
        node.ImageIndex := -1;
        TreeView.Repaint;
      end;
    end;
  end;
end;

procedure TfmTreatyCard.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  refrTreeNodeOfCurator;
end;

function TfmTreatyCard.SaveData : boolean;
var
  query : TOracleQuery;
  fieldNds : Tfield;
  text : String;
begin
  if (WorkStyle = wsAdd) and (dsCurrent.DataSet = dsAgreem.DataSet) then
  begin
    fieldNds := dsAgreem.DataSet.FieldByName('NDS');
    if (fieldNds.IsNull) or (fieldNds.Value = 0) then
    begin
      query := TOracleQuery.Create(nil);
      try
        query.Session := dmGlobal.seOracle;
        query.SQL.Add('SELECT LAST_VALUE(AGR.NDS) OVER (ORDER BY NUM ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING),');
        query.SQL.Add('       LAST_VALUE(AGR.NUM) OVER (ORDER BY NUM ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING)');
        query.SQL.Add('  FROM RN.MNAGREEM AGR');
        query.SQL.Add(' WHERE AGR.TREATY_ID = :TREATY');
        query.SQL.Add('   AND ((AGR.NUM < :NUM) OR (:NUM IS NULL))');
        query.DeclareVariable('TREATY', otInteger);
        query.SetVariable('TREATY', dsTreaty.DataSet.FieldByName('ID').AsInteger);
        query.DeclareVariable('NUM', otInteger);
        query.SetVariable('NUM', dsAgreem.DataSet.FieldByName('NUM').Value);
        query.Execute;

        if (not query.FieldIsNull(0)) and (query.Field(0) > 0 ) then
        begin
          if query.FieldAsInteger(1) = 0 then
            Text := 'В новом доп. соглашении был снят НДС, хотя в договоре он указан.'+ #13#10+'Пересчитать этапы в новом доп. соглашении учитывая снятый НДС?'
          else
            Text := 'В новом доп. соглашении был снят НДС, хотя в последнем доп. соглашении он указан.'+ #13#10+'Пересчитать этапы в новом доп. соглашении учитывая снятый НДС?';

          if MessageDlg(Text, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
            result := inherited SaveData
          else
            Result := false;
        end
        else
          result := inherited SaveData;
      finally
        query.Destroy;
      end;
    end
    else
      result := inherited SaveData;
  end
  else
    result := inherited SaveData;
end;

procedure TfmTreatyCard.btnCorrTrNDSClick(Sender: TObject);
begin
  inherited;
  dmGlobal.opNIOKR_Tax.CallProcedure('correctTreatyNDS', [dsTreaty.DataSet.FieldByName('ID').AsInteger]);
  TVASUPQuery(dsTreaty.DataSet).RefreshRecord;
end;

procedure TfmTreatyCard.btnCorrAgrNDSClick(Sender: TObject);
begin
  inherited;
  dmGlobal.opNIOKR_Tax.CallProcedure('correctAgreemNDS', [dsAgreem.DataSet.FieldByName('ID').AsInteger]);
  TVASUPQuery(dsAgreem.DataSet).RefreshRecord;
  TVASUPQuery(dsTreaty.DataSet).RefreshRecord;
end;

initialization
  RegisterClass(TfmTreatyCard);

finalization
  UnregisterClass(TfmTreatyCard);
end.
