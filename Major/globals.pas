unit globals;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, DB, StdCtrls,DBCtrls,vDBASUP,vWorkForm, Registry, Menus, Oracle, OracleData,
  Placemnt, v_krconsts, Variants, frxClass, frxDBSet, frxExportXLSX,
  frxExportODF, frxExportPDF, frxCross, ShellAPI;

resourcestring
  DefaultSchema= 'RN';

const
  BYR = 933;

  DefaultUserName= 'rn';
  DefaultDataBase= 'oracle';
  SubSystemCode= 1;//Код в справочнике подсистем P.MIPODSIS
  AdminRoleCode= 0; //Роль администратора задачи
  SubSection='Software\BelarusKali\NIOKR\';
  StorageSection= SubSection+'Storage\';
  REGISTRY_ROOT = SubSection;
  REGISTRY_OPTIONS = REGISTRY_ROOT + '\Options';

  No_Departments_ID= -1;
  All_Departments_ID= 1;
  OP_NONEXECUTABLE= $0000;
  OP_EXECUTABLE= $0001;
  RR_DateFormatBoundary= 49;
  CUnRegisteredUser= 'Пользователь не зарегистрирован в данном приложении.';
  InvalidDeptMsg= 'Неверный код подразделения';

  CTreatyAnnul='Договор аннулирован. Изменения невозможны.';
  CTreatyClose='Договор закрыт. Изменения невозможны.';

type
  TdmGlobal = class(TDataModule)
    Builder: TVBuilder;
    seOracle: TOracleSession;
    fsFields: TFormStorage;
    quMichapter: TVASUPQuery;
    quMichapterKOD: TIntegerField;
    quMichapterSNAIM: TStringField;
    quMichapterPNAIM: TStringField;
    quCurrency: TVASUPQuery;
    quCurrencyCURRENCY_NO: TIntegerField;
    quCurrencyISO_NAME: TStringField;
    quCurrencyNAME: TStringField;
    quCurrencyPRIORITY_USE: TIntegerField;
    quCurrencyINHERITED_ID: TStringField;
    quFirm: TVASUPQuery;
    quFirmFIRM_NO: TFloatField;
    quFirmCOUNTRY_NO: TIntegerField;
    quFirmREGION_NO: TFloatField;
    quFirmDISTRICT_NO: TIntegerField;
    quFirmCITY_NAME: TStringField;
    quFirmADDRESS: TStringField;
    quFirmSHORT_NAME: TStringField;
    quFirmNAME: TStringField;
    quFirmZIP_CODE: TStringField;
    quFirmPOST_BOX: TStringField;
    quFirmPHONE1: TStringField;
    quFirmPHONE2: TStringField;
    quFirmPHONE3: TStringField;
    quFirmPHONE4: TStringField;
    quFirmPHONE5: TStringField;
    quFirmFAX_NO: TStringField;
    quFirmTELEX_NO: TStringField;
    quFirmVAT_NO: TStringField;
    quFirmPROPRIETOR: TIntegerField;
    quFirmALT_PAY_FIRM: TFloatField;
    quFirmINHERITED_ID: TStringField;
    quFirmE_MAIL: TStringField;
    quFirmOKPO_NO: TFloatField;
    quFirmRAIL_FIRM_NO: TFloatField;
    quFirmUNITING_FIRM_NO: TFloatField;
    quFirmDEBTOR_INDCTR: TIntegerField;
    quFirmCREDITOR_INDCTR: TIntegerField;
    quFirmONETIME_CLNT_IND: TIntegerField;
    quFirmETALON_REC_IND: TIntegerField;
    quFirmINSERT_DATE: TDateTimeField;
    quFirmUPDATE_DATE: TDateTimeField;
    quFirmINSERT_USER: TStringField;
    quFirmUPDATE_USER: TStringField;
    quFirmF_ABBR_NAME: TStringField;
    quFirmOKPO_ID: TStringField;
    quFirmINHERTD_SELLER_ID: TStringField;
    quFirmMAIN_FIRM: TFloatField;
    quAccount: TVASUPQuery;
    quAccountFIRM_NO: TFloatField;
    quAccountCOUNTRY_NO: TIntegerField;
    quAccountBANK_ID: TStringField;
    quAccountBANK_ACCOUNT: TStringField;
    quAccountCURRENCY_NO: TIntegerField;
    quAccountBANK_CODE: TStringField;
    quAccountBANK_ADDRESS: TStringField;
    quFirmCOUNTRY_NAIM: TStringField;
    quFirmREGION_NAIM: TStringField;
    quFirmDISTRICT_NAIM: TStringField;
    quAccountCOUNTRY_NAIM: TStringField;
    quAccountCURRENCY_NAIM: TStringField;
    quAccountBANK_NAIM: TStringField;
    quPayMethods: TVASUPQuery;
    quPayMethodsPMETHOD_NO: TIntegerField;
    quPayMethodsPMETHOD_NAME: TStringField;
    quMiIstFin: TVASUPQuery;
    quMiIstFinKOD: TIntegerField;
    quMiIstFinSNAIM: TStringField;
    quMiIstFinPNAIM: TStringField;
    quMiAnnul: TVASUPQuery;
    quMiPayment: TVASUPQuery;
    quMiAnnulKOD: TIntegerField;
    quMiAnnulSNAIM: TStringField;
    quMiAnnulPNAIM: TStringField;
    quMiPaymentKOD: TIntegerField;
    quMiPaymentSNAIM: TStringField;
    quMiPaymentPNAIM: TStringField;
    quTreaty: TVASUPQuery;
    quAgreem: TVASUPQuery;
    quAgreemID: TFloatField;
    quAgreemTREATY_ID: TFloatField;
    quAgreemNUM: TIntegerField;
    quAgreemDATESIGN: TDateTimeField;
    quAgreemSUBJECT: TStringField;
    quAgreemDATETO: TDateTimeField;
    quAgreemSUMMPAY: TFloatField;
    quAgreemPAYMENT_KOD: TIntegerField;
    quAgreemISTFIN_KOD: TIntegerField;
    quAgreemISTFIN_SNAIM: TStringField;
    quAgreemPAYMENT_SNAIM: TStringField;
    quAgreemStage: TVASUPQuery;
    quAgreemStageID: TFloatField;
    quAgreemStageAGREEM_ID: TFloatField;
    quAgreemStageDATEFROM: TDateTimeField;
    quAgreemStageDATETO: TDateTimeField;
    quAgreemStageNUM: TStringField;
    quAgreemStageNAME: TStringField;
    quAgreemStageREPORTING: TStringField;
    quAgreemStageSUMMPAY: TFloatField;
    quAgreemStageDATEACT: TDateTimeField;
    quAgreemStageCUST_ACCOUNT_ID: TFloatField;
    quAgreemStageEXEC_ACCOUNT_ID: TFloatField;
    quAgreemStageCUST_BANK_ACCOUNT: TStringField;
    quAgreemStageCUST_NAME: TStringField;
    quAgreemStageEXEC_BANK_ACCOUNT: TStringField;
    quAgreemStageEXEC_NAME: TStringField;
    quTreatyID: TFloatField;
    quTreatyNUM: TStringField;
    quTreatyDATESIGN: TDateTimeField;
    quTreatySUBJECT: TStringField;
    quTreatyCUST_ACCOUNT_ID: TFloatField;
    quTreatyEXEC_ACCOUNT_ID: TFloatField;
    quTreatyDATEFROM: TDateTimeField;
    quTreatyDATETO: TDateTimeField;
    quTreatySUMMPAY: TFloatField;
    quTreatyPAYMENT_KOD: TIntegerField;
    quTreatyISTFIN_KOD: TIntegerField;
    quTreatyCHAPTER_KOD: TIntegerField;
    quTreatyANNUL_KOD: TIntegerField;
    quTreatySTATUS: TStringField;
    quTreatyANNUL_SNAIM: TStringField;
    quTreatyCHAPTER_SNAIM: TStringField;
    quTreatyISTFIN_SNAIM: TStringField;
    quTreatyPAYMENT_SNAIM: TStringField;
    quTreatyCUST_BANK_ACCOUNT: TStringField;
    quTreatyCUST_CURRENCY_NO: TIntegerField;
    quTreatyCUST_CURRENCY_NAME: TStringField;
    quTreatyCUST_FIRM_NO: TFloatField;
    quTreatyCUST_SHORT_NAME: TStringField;
    quTreatyCUST_NAME: TStringField;
    quTreatyCUST_BANK_ID: TStringField;
    quTreatyCUST_BANK_NAME: TStringField;
    quTreatyCUST_COUNTRY_NO: TIntegerField;
    quTreatyCUST_COUNTRY_NAME: TStringField;
    quTreatyEXEC_BANK_ACCOUNT: TStringField;
    quTreatyEXEC_CURRENCY_NO: TIntegerField;
    quTreatyEXEC_CURRENCY_NAME: TStringField;
    quTreatyEXEC_FIRM_NO: TFloatField;
    quTreatyEXEC_SHORT_NAME: TStringField;
    quTreatyEXEC_BANK_ID: TStringField;
    quTreatyEXEC_BANK_NAME: TStringField;
    quTreatyEXEC_COUNTRY_NO: TIntegerField;
    quTreatyEXEC_COUNTRY_NAME: TStringField;
    quTreatyStage: TVASUPQuery;
    quTreatyStageID: TFloatField;
    quTreatyStageAGREEM_ID: TFloatField;
    quTreatyStageNUM: TStringField;
    quTreatyStageDATEFROM: TDateTimeField;
    quTreatyStageDATETO: TDateTimeField;
    quTreatyStageSUMMPAY: TFloatField;
    quTreatyStageNAME: TStringField;
    quTreatyStageREPORTING: TStringField;
    quTreatyStageDATEACT: TDateTimeField;
    quTreatyStageCUST_ACCOUNT_ID: TFloatField;
    quTreatyStageCUST_BANK_ACCOUNT: TStringField;
    quTreatyStageCUST_NAME: TStringField;
    quTreatyStageEXEC_ACCOUNT_ID: TFloatField;
    quTreatyStageEXEC_BANK_ACCOUNT: TStringField;
    quTreatyStageEXEC_NAME: TStringField;
    quTrCurator: TVASUPQuery;
    quTrCuratorMIRAB_TABN: TIntegerField;
    quTrCuratorTREATY_ID: TFloatField;
    quTrCuratorFIO: TStringField;
    quTrCuratorONAIM: TStringField;
    quTrCuratorFNAIM: TStringField;
    quTrCuratorDATAUVOL: TDateTimeField;
    quTrCuratorMIPROF_KOD: TIntegerField;
    quTrCuratorMIPROF_SNAIM: TStringField;
    quTrCuratorMIUPDR_KOD: TIntegerField;
    quTrCuratorMIPODR_KOD: TStringField;
    quTrCuratorMIPODR_SNAIM: TStringField;
    quTrCuratorINAIM: TStringField;
    quTrCuratorMIUPDR_SNAIM: TStringField;
    quTrCuratorMIUROVEN_KOD: TIntegerField;
    quTreatyEXEC_NAME: TStringField;
    quTrCuratorMIPODR_ID: TFloatField;
    quTrCuratorUPDR_ID: TFloatField;
    quTrCuratorPODR_ID: TFloatField;
    quChangeStatus: TOracleQuery;
    quPrintLetter: TOracleQuery;
    quTreatyStageNUMACT: TIntegerField;
    quAgreemStageNUMACT: TIntegerField;
    quTrCuratorMIPODR_PNAIM: TStringField;
    quTreatyCUST_VAT_NO: TStringField;
    quTreatyCUST_CITY_NAME: TStringField;
    quTreatyEXEC_VAT_NO: TStringField;
    quTreatyEXEC_CITY_NAME: TStringField;
    quRN01_RN02_Rep: TOracleQuery;
    quMitrconcern: TVASUPQuery;
    quMitrconcernNUM: TStringField;
    quMitrconcernDATESIGN: TDateTimeField;
    quMitrconcernDATEFROM: TDateTimeField;
    quMitrconcernDATETO: TDateTimeField;
    quRN03_Rep: TOracleQuery;
    quTreatyAGREEM_ID: TFloatField;
    quAccountDefault: TOracleQuery;
    quCurrState: TVASUPQuery;
    quCurrStateTREATY_ID: TFloatField;
    quCurrStateTREATY_NUM: TStringField;
    quCurrStateTREATY_STATUS: TStringField;
    quCurrStateAGREEM_ID: TFloatField;
    quCurrStateAGREEM_NUM: TIntegerField;
    quCurrStateDATEFROM: TDateTimeField;
    quCurrStateDATETO: TDateTimeField;
    quCurrStateISTFIN_KOD: TIntegerField;
    quCurrStateSUBJECT: TStringField;
    quCurrStateSUMMPAY: TFloatField;
    quCurrStatePAYMENT_KOD: TIntegerField;
    quCurrStateCHAPTER_KOD: TIntegerField;
    quCurrStateANNUL_KOD: TIntegerField;
    quCurrStateEXEC_SHORTNAME: TStringField;
    quCurrStateFIRM_NO: TFloatField;
    quCurrStateCURRENCY_NO: TIntegerField;
    odsCurrStage: TOracleDataSet;
    odsCurrStageID: TFloatField;
    odsCurrStageAGREEM_ID: TFloatField;
    odsCurrStageDATEFROM: TDateTimeField;
    odsCurrStageDATETO: TDateTimeField;
    odsCurrStageNUM: TStringField;
    odsCurrStageNAME: TStringField;
    odsCurrStageREPORTING: TStringField;
    odsCurrStageSUMMPAY: TFloatField;
    odsCurrStageDATEACT: TDateTimeField;
    odsCurrStageCUST_ACCOUNT_ID: TFloatField;
    odsCurrStageEXEC_ACCOUNT_ID: TFloatField;
    odsCurrStageNUMACT: TIntegerField;
    odsCurrStageTREATY_ID: TFloatField;
    odsCurrStageEXEC_BANK_ACCOUNT: TStringField;
    odsCurrStageEXEC_NAME: TStringField;
    odsCurrStageINTRO_DATE: TDateTimeField;
    odsCurrStageCURRENCY_NAME: TStringField;
    odsCurrStageSUMMPAY_RB: TFloatField;
    odsCurrStageE_RATE: TStringField;
    odsCurrStageAGREEM_NAME: TStringField;
    odsCurrStageAGREEM_NUM: TIntegerField;
    quCurrStatePAYMENT_SNAIM: TStringField;
    quCurrStateISTFIN_SNAIM: TStringField;
    odsSummpayYear: TOracleDataSet;
    odsSummpayYearREP_YEAR: TDateTimeField;
    odsSummpayYearSUMMPAY: TFloatField;
    odsSummpayYearSUMMPAY_RB: TFloatField;
    quRN05_RN06_Rep: TOracleQuery;
    quCurators: TOracleQuery;
    quRN04_Rep: TOracleQuery;
    quRN07_Rep: TOracleQuery;
    quMitrconcernID: TFloatField;
    quMitrconc_agr: TVASUPQuery;
    quMitrconc_agrNUM: TStringField;
    quMitrconc_agrDATESIGN: TDateTimeField;
    quMitrconc_agrDATEFROM: TDateTimeField;
    quMitrconc_agrDATETO: TDateTimeField;
    quMitrconc_agrDOG_ID: TFloatField;
    odsYearConcReport: TOracleDataSet;
    quRN08_Rep: TOracleQuery;
    quRN09RN11_rep: TOracleQuery;
    quRN10RN12_Rep: TOracleQuery;
    quRN13_Rep: TOracleQuery;
    quTreatyNAME_BENEFICIARY: TStringField;
    quTreatyBANK: TStringField;
    quTreatyNIOKR_ACCOUNT: TStringField;
    odsTrExecFirmProperty: TOracleDataSet;
    quRN14_Rep: TOracleQuery;
    quRN15RN16_2_Rep: TOracleQuery;
    quRN15RN16_1_Rep: TOracleQuery;
    quEconParam: TVASUPQuery;
    quEconParamKOD: TIntegerField;
    quEconParamNAME: TStringField;
    quExpectedIncome: TVASUPQuery;
    quExpectedIncomeTREATY_ID: TFloatField;
    quExpectedIncomeTYPE_PARAMETERS: TIntegerField;
    quExpectedIncomePLAN_DATE: TDateTimeField;
    quExpectedIncomeFACT_DATE_FROM: TDateTimeField;
    quExpectedIncomeFACT_DATE_TO: TDateTimeField;
    quExpectedIncomePARAMETER: TFloatField;
    quExpectedIncomeDESCRIPTION: TStringField;
    quExpIncomePeriod: TVASUPQuery;
    quExpIncomePeriodTREATY_ID: TFloatField;
    quExpIncomePeriodTYPE: TIntegerField;
    quExpIncomePeriodPERIOD: TDateTimeField;
    quExpIncomePeriodDATA: TFloatField;
    quExpIncomePeriodDESCRIPTION: TStringField;
    quRN17RN18_Rep: TOracleQuery;
    quRN19_Rep: TOracleQuery;
    quRN20_Rep: TOracleQuery;
    quMitrconcernNAME: TStringField;
    quMitrconc_agrNAME: TStringField;
    quMitrconcernEXISTENT_BEG_INTERVAL: TFloatField;
    quMitrconcernDOG_LIMIT: TStringField;
    quTreatyTHEME_PLAN_NUM: TIntegerField;
    quTreatyFIRST_YEAR_SUMMPAY: TFloatField;
    quRN21RN22_Rep: TOracleQuery;
    quTreatySUMMARY: TStringField;
    quMitrconcernWORK_DATEFROM: TDateTimeField;
    opNII_EVM_SERVIS: TOraclePackage;
    quTreatyDOC_NO: TStringField;
    quAgreemDOC_NO: TStringField;
    quTreatyStageSPECIAL_WRITTEN: TStringField;
    quAgreemStageSPECIAL_WRITTEN: TStringField;
    quRepConc: TOracleQuery;
    quDogYears: TOracleQuery;
    quPlanCurator: TOracleQuery;
    mdStruc: TVMetaDataSource;
    mdArch: TVMetaDataSource;
    quMipodr: TVASUPQuery;
    quMipodrVERH_PODR: TStringField;
    quMipodrKOD: TIntegerField;
    quMipodrSNAIM: TStringField;
    quMipodrPNAIM: TStringField;
    quMipodrID: TFloatField;
    quMipodrMIPODR_ID: TFloatField;
    quMipodrMIPODR_KOD: TIntegerField;
    quMipodrVERH_NAIM: TStringField;
    quMipodrMIUROVEN_KOD: TIntegerField;
    quTreatyST_SUMMPAY: TFloatField;
    quTreatyAGR_SUMMPAY: TFloatField;
    quTreatyTR_SUMMPAY: TFloatField;
    quAgreemST_SUMMPAY: TFloatField;
    quTreatyNDS: TFloatField;
    quTreatyNDS_SUMMPAY: TFloatField;
    quAgreemNDS: TFloatField;
    quAgreemNDS_SUMMPAY: TFloatField;
    quAgreemStageNDS: TFloatField;
    quAgreemStageNDS_SUMMPAY: TFloatField;
    quTreatyStageNDS: TFloatField;
    quTreatyStageNDS_SUMMPAY: TFloatField;
    quTreatyST_NDS: TFloatField;
    quTreatyAGR_NDS: TFloatField;
    quTreatyTR_NDS: TFloatField;
    quCurrStateNDS: TFloatField;
    quCurrStateNDS_SUMMPAY: TFloatField;
    quAgreemST_NDS: TFloatField;
    quRN15RN16_3_Rep: TOracleQuery;
    quMiExchange: TVASUPQuery;
    quMiExchangeYEAR: TIntegerField;
    quMiExchangeCURRENCY_NO: TIntegerField;
    quMiExchangeISO_NAME: TStringField;
    quMiExchangeCURRENCY: TStringField;
    quMiExchangeRATE: TFloatField;
    odsCurrency: TOracleDataSet;
    odsCurrencyCURRENCY_NO: TIntegerField;
    odsCurrencyNAME: TStringField;
    quMiExchangeLkCURRENCY: TStringField;
    quTreatyStageAKT_NO: TStringField;
    quAgreemStageAKT_NO: TStringField;
    quTreatyStageCREATE_AKT: TDateTimeField;
    quAgreemStageCREATE_AKT: TDateTimeField;
    quTreatyCREATE_SW: TFloatField;
    quTreatyREWORK_SW: TFloatField;
    odsCurrStageSW_STAGE: TStringField;
    quTreatyStageSW_STAGE: TStringField;
    quAgreemStageSW_STAGE: TStringField;
    quTreatyStagePMETHOD_NAME: TStringField;
    quAgreemStagePMETHOD_NAME: TStringField;
    quTreatyStageDATEPAY: TDateTimeField;
    quAgreemStageDATEPAY: TDateTimeField;
    quTreatyStageNUMPAY: TStringField;
    quTreatyStagePM_PMETHOD_NO: TFloatField;
    quAgreemStageNUMPAY: TStringField;
    quAgreemStagePM_PMETHOD_NO: TFloatField;
    odsCurrStagePMETHOD_NAME: TStringField;
    odsCurrStageDATEPAY: TDateTimeField;
    odsCurrStageNUMPAY: TStringField;
    odsCurrStagePM_PMETHOD_NO: TFloatField;
    quRN01_Concern: TOracleQuery;
    quPayment_1: TOracleQuery;
    quPayment_2: TOracleQuery;
    quTreatyCURATOR: TFloatField;
    opNIOKR_Tax: TOraclePackage;
    quTreatyPLAT_DOC_TYPE: TIntegerField;
    quTreatyPD_NAME: TStringField;
    pkgFirmAccess: TOraclePackage;
    odsRN01_02: TOracleDataSet;
    fltfldRN01_02TREATY_ID: TFloatField;
    odsRN01_02TREATY_NUM: TStringField;
    odsRN01_02SUBJECT: TStringField;
    odsRN01_02STAGE_NUM: TStringField;
    intfldRN01_02CURRENCY_NO: TIntegerField;
    dtfldRN01_02STAGE_DATEACT: TDateTimeField;
    odsRN01_02E_RATE: TStringField;
    fltfldRN01_02COUNT_PER_TREATY: TFloatField;
    fltfldRN01_02NUM: TFloatField;
    odsRN01_02EXEC_NAME: TStringField;
    fltfldRN01_02COUNT_STAGE: TFloatField;
    fltfldRN01_02COUNT_TREATY: TFloatField;
    odsRN01_02REPORTING: TStringField;
    frdsRN01_02: TfrxDBDataset;
    frRN01_02: TfrxReport;
    fltfldRN01_02STAGE_SUMMPAY_RUB: TFloatField;
    fltfldRN01_02STAGE_SUMMPAY_CUR: TFloatField;
    odsTOPMAN: TOracleDataSet;
    fltfldTOPMANID: TFloatField;
    odsTOPMANSNAIM: TStringField;
    odsTOPMANPNAIM: TStringField;
    odsTOPMANDOLZHN: TStringField;
    odsTOPMANKOD: TStringField;
    frexpPDF: TfrxPDFExport;
    frexpODT: TfrxODTExport;
    frexpXLSX: TfrxXLSXExport;
    odsPayment_1: TOracleDataSet;
    frdsPayment_1: TfrxDBDataset;
    frPayment_1: TfrxReport;
    odsPayment_1_2: TOracleDataSet;
    fltfldPayment_1_2TR_ID: TFloatField;
    intfldPayment_1_2PDT: TIntegerField;
    odsPayment_1_2TR_NUM: TStringField;
    odsPayment_1_2TR_STATUS: TStringField;
    odsPayment_1_2TR_SUBJECT: TStringField;
    odsPayment_1_2ST_NUM: TStringField;
    fltfldPayment_1_2ST_SUMMPAY: TFloatField;
    odsPayment_1_2REPORTING: TStringField;
    odsPayment_1_2NUMPAY: TStringField;
    dtfldPayment_1_2DATEPAY: TDateTimeField;
    fltfldPayment_1_2E_RATE: TFloatField;
    odsPayment_1_2INTRO_DATE: TStringField;
    intfldPayment_1_2CURRENCY_NO: TIntegerField;
    odsPayment_1_2CURRENCY: TStringField;
    frdsPayment_1_2: TfrxDBDataset;
    fltfldPayment_1TR_ID: TFloatField;
    intfldPayment_1PDT: TIntegerField;
    odsPayment_1TR_NUM: TStringField;
    odsPayment_1TR_STATUS: TStringField;
    odsPayment_1TR_SUBJECT: TStringField;
    fltfldPayment_1MONTH_TREATY_SUMMPAY: TFloatField;
    fltfldPayment_1YEAR_TREATY_SUMMPAY: TFloatField;
    dtfldPayment_1_2ST_DATEACT: TDateTimeField;
    odsRN04: TOracleDataSet;
    frdsRN04: TfrxDBDataset;
    frRN04: TfrxReport;
    fltfldRN04ID: TFloatField;
    odsRN04NAME: TStringField;
    odsRN04EXEC_NAME: TStringField;
    odsRN04SUBJECT: TStringField;
    odsRN04DATEFROM: TStringField;
    odsRN04DATETO: TStringField;
    fltfldRN04NUM: TFloatField;
    odsRN04STATUS: TStringField;
    odsRN04STATUSSTR: TStringField;
    fltfldRN04SUMMPAY: TFloatField;
    fltfldRN04STAGE_SUMMPAY: TFloatField;
    odsRN04RATE_STR: TStringField;
    odsPayment_2: TOracleDataSet;
    frdbPayment_2: TfrxDBDataset;
    frPayment_2: TfrxReport;
    fltfldPayment_2TREATY_ID: TFloatField;
    odsPayment_2TREATY_NUM: TStringField;
    fltfldPayment_2STAGE_SUMMPAY_RB: TFloatField;
    fltfldPayment_2COUNT_TREATY: TFloatField;
    odsPayment_2MON_TH: TStringField;
    fltfldPayment_2DD: TFloatField;
    frxcrsbjct1: TfrxCrossObject;
    odsRN06: TOracleDataSet;
    frdbRN06: TfrxDBDataset;
    frRN06: TfrxReport;
    fltfldRN06TREATY_ID: TFloatField;
    odsRN06TREATY_NUM: TStringField;
    fltfldRN06MM: TFloatField;
    fltfldRN06STAGE_SUMMPAY_RB: TFloatField;
    odsRN06MON_TH: TStringField;
    frRN16: TfrxReport;
    frdsRN16_1: TfrxDBDataset;
    odsRN016_1: TOracleDataSet;
    odsRN018: TOracleDataSet;
    frdsRN018: TfrxDBDataset;
    frRN018: TfrxReport;
    odsRN08: TOracleDataSet;
    frdsRN08: TfrxDBDataset;
    frRN08: TfrxReport;
    odsRN010: TOracleDataSet;
    frdsRN010: TfrxDBDataset;
    frRN010: TfrxReport;
    odsRN012: TOracleDataSet;
    frdsRN012: TfrxDBDataset;
    frRN012: TfrxReport;
    odsRN013: TOracleDataSet;
    frdsRN013: TfrxDBDataset;
    frRN013: TfrxReport;
    odsRN022: TOracleDataSet;
    frdsRN022: TfrxDBDataset;
    frRN022: TfrxReport;
    fltfldRN08ID: TFloatField;
    odsRN08NUM: TStringField;
    odsRN08SUBJ: TStringField;
    odsRN08DATEFROM: TStringField;
    odsRN08DATETO: TStringField;
    fltfldRN08TREATY_SUMMPAY: TFloatField;
    fltfldRN08SBF: TFloatField;
    fltfldRN08SCUR: TFloatField;
    odsRN08STATUS: TStringField;
    odsRN08KURS_STR: TStringField;
    fltfldRN010ID: TFloatField;
    odsRN010TREATY_NUM: TStringField;
    odsRN010NAME: TStringField;
    odsRN010SUBJECT: TStringField;
    fltfldRN010STAGE_SUMMPAY: TFloatField;
    intfldRN010CURRENCY_NO: TIntegerField;
    odsRN010ST_NUM: TStringField;
    dtfldRN010ST_DATETO: TDateTimeField;
    fltfldRN010E_RATE: TFloatField;
    dtfldRN010INTO_DATE: TDateTimeField;
    fltfldRN010NUM: TFloatField;
    fltfldRN012ID: TFloatField;
    odsRN012TREATY_NUM: TStringField;
    odsRN012NAME: TStringField;
    odsRN012SUBJECT: TStringField;
    fltfldRN012STAGE_SUMMPAY: TFloatField;
    intfldRN012CURRENCY_NO: TIntegerField;
    odsRN012ST_NUM: TStringField;
    dtfldRN012ST_DATETO: TDateTimeField;
    fltfldRN012E_RATE: TFloatField;
    dtfldRN012INTO_DATE: TDateTimeField;
    fltfldRN012NUM: TFloatField;
    fltfldRN013ID: TFloatField;
    odsRN013TREATY_NUM: TStringField;
    odsRN013NAME: TStringField;
    odsRN013SUBJECT: TStringField;
    fltfldRN013STAGE_SUMMPAY: TFloatField;
    intfldRN013CURRENCY_NO: TIntegerField;
    odsRN013ST_NUM: TStringField;
    odsRN013ST_DATETO: TStringField;
    fltfldRN013E_RATE: TFloatField;
    dtfldRN013INTO_DATE: TDateTimeField;
    fltfldRN013NUM: TFloatField;
    intfldRN013ISTFIN_KOD: TIntegerField;
    fltfldRN013CONCDOGID: TFloatField;
    fltfldRN013COUNT_PER_TREATY: TFloatField;
    fltfldRN013REC_COUNT: TFloatField;
    odsRN014: TOracleDataSet;
    fltfld1: TFloatField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    fltfld2: TFloatField;
    intfld1: TIntegerField;
    StringField4: TStringField;
    StringField5: TStringField;
    fltfld3: TFloatField;
    dtfld1: TDateTimeField;
    fltfld4: TFloatField;
    intfld2: TIntegerField;
    fltfld5: TFloatField;
    fltfld6: TFloatField;
    fltfld7: TFloatField;
    frdsRN014: TfrxDBDataset;
    frRN014: TfrxReport;
    frRN020: TfrxReport;
    frdsRN020: TfrxDBDataset;
    odsRN020: TOracleDataSet;
    fltfldRN020TREATY_ID: TFloatField;
    odsRN020NUM: TStringField;
    odsRN020SUBJECT: TStringField;
    odsRN020DATEFROM: TStringField;
    odsRN020DATETO: TStringField;
    fltfldRN020TREATY_SUMMPAY: TFloatField;
    odsRN020KURS_STR: TStringField;
    fltfldRN020SBF: TFloatField;
    fltfldRN020SCUR: TFloatField;
    fltfldRN022ID: TFloatField;
    odsRN022NAME: TStringField;
    odsRN022EXEC_NAME: TStringField;
    odsRN022CHAPTERNAME: TStringField;
    odsRN022SUBJECT: TStringField;
    odsRN022DATEFROM: TStringField;
    odsRN022DATETO: TStringField;
    fltfldRN022SUMMPAY: TFloatField;
    intfldRN022CURRENCY_NO: TIntegerField;
    fltfldRN022STSUM_CURR: TFloatField;
    odsRN022TREATY_STATUS: TStringField;
    odsRN016_2: TOracleDataSet;
    odsRN016_3: TOracleDataSet;
    frdsRN16_2: TfrxDBDataset;
    frdsRN16_3: TfrxDBDataset;
    odsCurrStageSPECIAL_WRITTEN: TStringField;
    odsCurrStageNDS: TFloatField;
    odsCurrStageNDS_SUMMPAY: TFloatField;
    odsCurrStageAKT_NO: TStringField;
    odsCurrStageCREATE_AKT: TDateTimeField;
    odsCurrStageCURRENCY_NO: TIntegerField;
    fltfldTreatyMIPODR_ID: TFloatField;
    intgrfldTreatyMIPODR_KOD: TIntegerField;
    strngfldTreatyMIPODR_SNAIM: TStringField;
    strngfldTreatyMIPODR_PNAIM: TStringField;
    intgrfldTreatyMIUROVEN_KOD: TIntegerField;
    qryFileInfo: TOracleDataSet;
    dtmfldorcldtst1FILE_DATE: TDateTimeField;
    fltfldorcldtst1FILE_VERSION: TFloatField;
    fltfldorcldtst1FILE_SIZE: TFloatField;
    qryFileBody: TOracleDataSet;
    blbfldFileBodyFILE_BODY: TBlobField;
    function Arabica(WANTED: string):boolean;
    procedure DetailsBeforeOpen(DataSet: TDataSet);
    procedure RR_DateFormat(Sender: TField);
    procedure MonthBeginFormat(Sender: TField);
    procedure RefreshCalcFields(Sender: TField);
    procedure seOracleAfterLogOn(Sender: TOracleSession);
    procedure CheckLevelBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure quFirmAfterClose(DataSet: TDataSet);
    procedure quFirmBeforeVisualQuery(DataSet: TDataSet);
    procedure quTreatyBeforeVisualQuery(DataSet: TDataSet);
    procedure quTreatyAfterClose(DataSet: TDataSet);
    procedure BeforeEditTreaty(DataSet: TDataSet);
    procedure quTrCuratorBeforeVisualQuery(DataSet: TDataSet);
    procedure quTreatyAfterOpen(DataSet: TDataSet);
    procedure quTreatyAfterInsert(DataSet: TDataSet);
    procedure quTreatyApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: String);
    procedure quTreatyBeforeClose(DataSet: TDataSet);
    procedure odsTrExecFirmPropertyApplyRecord(Sender: TOracleDataSet;
      Action: Char; var Applied: Boolean; var NewRowId: String);
    procedure quExpectedIncomeAfterInsert(DataSet: TDataSet);
    procedure YYYY_DateFormat(Sender: TField);
    procedure quMitrconcernEXISTENT_BEG_INTERVALChange(Sender: TField);
    procedure quAgreemApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: String);
    procedure quMipodrBeforeOpen(DataSet: TDataSet);
    procedure quMipodrMIPODR_IDChange(Sender: TField);
    procedure TrChangeNDS(Sender: TField);
    procedure AgrChangeNDS(Sender: TField);
    procedure StChangeNDS(Sender: TField);
    procedure mm_yyyy_from(Sender: TField);
    procedure mm_yyyy_to(Sender: TField);
    procedure quMiExchangeCURRENCY_NOChange(Sender: TField);
  private
    FIni : TRegistry;
    procedure SetAllPrivileges(OwnerList,ObjectList: TStrings);
    // Вычисляет стоимость НДС договора
    procedure SetNDSSummPay(ATreaty : TVASUPQuery);
    //Компонента для доступа к реестру ОС
  public
    procedure CheckUpdates;
  end;

function PutOnClothes(WANTED: string):string;
function NVL(Field:TField;const Value: Integer):Integer;
function IsEmptyRecord( ADataSet: TDataSet;
                        const UnImportants:Array of TField):bool;
procedure AddRegString();                        

procedure AskSingleManualForResFields( AQuery: TOracleQuery;const AName,AKey : string;
                                       AContext: array of string;
                                       KeyField : TField;
                                       ResFields: array of TField); overload;
{ Служит для выборки дополнительной информации из справочных таблиц.
  AQuery - Компонент для выполения SQL-скрипта. Создается заранее;
  AName - имя справочной таблицы;
  AKey  - имя ключевого поля таблицы AName;
  AContext - имена полей с требуемой информацией;
  KeyField - поле со значением для ключа AKey;
  ResFields - поле, где сохраняется результат из поля AContext}

procedure AskSingleManualForResFields( AQuery: TOracleQuery;const AName : String;AKey : array of string;
                                       AContext: array of string;
                                       KeyField : array of TField;
                                       ResFields: array of TField); overload;


var
  dmGlobal: TdmGlobal;
  PLAT_DOC_TYPE : integer;

implementation

uses MENUGnrl, v_anyform,
v_Nsiform,
ExecRep,
v_Utils,v_stdr20,
v_edcnd,
v_stdfrep,
chapter, wcurrency, wfirm,
wpaymeth, wistfin, wNSI2040, treatycard, wEconParam;

{$R *.DFM}

procedure AskSingleManualForResFields( AQuery: TOracleQuery;const AName : String;AKey : array of string;
                                       AContext: array of string;
                                       KeyField : array of TField;
                                       ResFields: array of TField);
var
  I, J: Integer;
  NamesOfFields : string;

  sql_where : String;

  cl : boolean;
begin
  if (High(AContext)<>High(ResFields)) or (Length(AContext)=0) then
    raise Exception.Create(CIncorrectParams);
  NamesOfFields:= '';
  I:= 0;
  while (I<=High(AContext)) do
  begin
    if I>0 then NamesOfFields:= NamesOfFields + ', ';
    NamesOfFields:= NamesOfFields + AContext[I];
    Inc(I);
  end;

  cl := false;
  for J := low(KeyField) to high(KeyField) do
    if KeyField[J].IsNull then
      cl := true;

  if cl or (Length(KeyField) = 0)
  then
    for I := 0 to high(ResFields) do
      ResFields[I].Clear
  else
    with AQuery do
    begin
      DeleteVariables;
      for J := low(Akey) to high(akey) do
      begin
        if KeyField[j] is TDateTimeField then
        begin
          DeclareVariable(Format('F%s', [AKey[j]]), otDate);
          SetVariable(Format('F%s', [AKey[j]]), KeyField[j].AsDateTime);
        end
        else if KeyField[j] is TStringField then
        begin
          DeclareVariable(Format('F%s', [AKey[j]]), otString);
          SetVariable(Format('F%s', [AKey[j]]), KeyField[j].AsString);
        end
        else
        begin
          DeclareVariable(Format('F%s', [AKey[j]]), otInteger);
          SetVariable(Format('F%s', [AKey[j]]),KeyField[j].AsInteger);
        end;
      end;

      for J := low(KeyField) to high(KeyField) do
      begin
        if J > low(KeyField) then
          sql_where := sql_where + ' AND ';
        sql_where := sql_where + Format('%s=:F%s', [AKey[j], AKey[j]]);
      end;

      SQL.Text:= Format('select %s from %s where %s',
                        [NamesOfFields, AName, sql_where]);
      Execute;
      if not EOF then
        for I := 0 to high(ResFields) do
          ResFields[I].Value:= Field(I)
      else
        for I := 0 to high(ResFields) do
          ResFields[I].Clear;
      Close;
    end;
end;

procedure AskSingleManualForResFields( AQuery: TOracleQuery;const AName,AKey : string;
                                       AContext: array of string;
                                       KeyField : TField;
                                       ResFields: array of TField);
var
  I: Integer;
  NamesOfFields : string;
begin
  if (High(AContext)<>High(ResFields)) or (Length(AContext)=0) then
    raise Exception.Create(CIncorrectParams);
  NamesOfFields:= '';
  I:= 0;
  while (I<=High(AContext)) do
  begin
    if I>0 then NamesOfFields:= NamesOfFields + ', ';
    NamesOfFields:= NamesOfFields + AContext[I];
    Inc(I);
  end;
  if KeyField.IsNull
  then
    for I := 0 to high(ResFields) do
      ResFields[I].Clear
  else
    with AQuery do
    begin
      DeleteVariables;
      DeclareVariable(Format('F%s', [AKey]), otInteger);
      SetVariable(Format('F%s', [AKey]),KeyField.AsInteger);

      SQL.Text:= Format('select %s from %s where %s=:F%s',
                        [NamesOfFields, AName, AKey, AKey]);
      Execute;
      if not EOF then
        for I := 0 to high(ResFields) do
          ResFields[I].Value:= Field(I)
      else
        for I := 0 to high(ResFields) do
          ResFields[I].Clear;
      Close;
    end;
end;//AskSingleManualForResFields

procedure AskMyList( AQuery: TOracleQuery;
                   const Manual: string;
                   const ResultFieldNames: string;
                   const Keys: Array of TField;
                   const KeysType: Array of Integer;
                   const OriginName: Array of String;
                   const NullFields: Array of Boolean; // True - очищать, False - нет
                   const Results:  Array of TField);

var
  I: Integer;
  where: string;
  flag: Boolean;
begin
  where:= '';
  flag := False;
  for i:=0 to High(Keys) do
  begin
    if not Keys[I].IsNull then
    begin
      if (I>0) and (where <> '') then where:= where + ' AND ';
      where:= ' ' + where+ OriginName[I]+'=:'+Keys[I].FieldName + ' ';
      flag := True;
    end;
  end;
  if flag= False then begin for i:=0 to High(Results) do if NullFields[i] = True then Results[i].Clear; end
  else
    with AQuery do
    begin
      DeleteVariables;
      for i:= 0 to High(Keys) do
      begin
        if not Keys[I].IsNull then
        begin
          DeclareVariable(Keys[I].FieldName,KeysType[I]);
          SetVariable(Keys[I].FieldName,Keys[I].Value);
        end;
      end;
      // проверяем одна ли сторока выдается
      SQL.Text:= Format('select count(*) from %s where %s',
                        [Manual,where]);
      Execute;
      if Field(0) <= 1 then
      begin
        Close;
        SQL.Text:= Format('select %s from %s where %s',
                           [ResultFieldNames,Manual,where]);
        Execute;
        if not EOF
        then
        begin
          for i:=0 to High(Results) do if Results[i].Value <> Field(i) then Results[i].Value:= Field(i);
        end
        else for i:=0 to High(Results) do if NullFields[i] = True then Results[i].Clear;
        Close;
      end
      else begin Close; for i:=0 to High(Results) do if NullFields[i] = True then Results[i].Clear; end;
   end;
end;//AskList


procedure AskMyListWithNull( AQuery: TOracleQuery;
                   const Manual: string;
                   const ResultFieldNames: string;
                   const Keys: Array of TField;
                   const KeysType: Array of Integer;
                   const OriginName: Array of String;
                   const NullFields: Array of Boolean; // True - очищать, False - нет
                   const Results:  Array of TField);

var
  I: Integer;
  where: string;
begin
  where:= '';
  for i:=0 to High(Keys) do
  begin
    if (I>0) and (where <> '') then where:= where + ' AND ';
    if not Keys[I].IsNull then
      where:= ' ' + where+ OriginName[I]+'=:'+Keys[I].FieldName + ' '
    else
      where:= ' ' + where+ OriginName[I]+' IS NULL';
  end;
  with AQuery do
  begin
    DeleteVariables;
    for i:= 0 to High(Keys) do
    begin
      if not Keys[I].IsNull then
      begin
        DeclareVariable(Keys[I].FieldName,KeysType[I]);
        SetVariable(Keys[I].FieldName,Keys[I].Value);
      end;
    end;
    // проверяем одна ли сторока выдается
    SQL.Text:= Format('select count(*) from %s where %s',
                      [Manual,where]);
    Execute;
    if Field(0) <= 1 then
    begin
      Close;
      SQL.Text:= Format('select %s from %s where %s',
                           [ResultFieldNames,Manual,where]);
      Execute;
      if not EOF
      then
      begin
        for i:=0 to High(Results) do if Results[i].Value <> Field(i) then Results[i].Value:= Field(i);
      end
      else for i:=0 to High(Results) do if NullFields[i] = True then Results[i].Clear;
        Close;
    end
      else begin Close; for i:=0 to High(Results) do if NullFields[i] = True then Results[i].Clear; end;
   end;
end;//AskList

function PutOnClothes(WANTED: string):string;
begin
  Result:= ''''+WANTED+''''
end;

function TdmGlobal.Arabica;
var
  i: byte;
  GetOut: boolean;
begin
  i:= 0;
  GetOut:= false;
  if WANTED='' then
  begin
    Result:= true;
    Exit
  end;
  repeat
    Inc(i);
    if (ord(WANTED[i])<48) or (ord(WANTED[i])>57) then GetOut:= true
  until (i=Length(WANTED)) or GetOut;
  Result:= not GetOut;
end;

procedure TdmGlobal.DetailsBeforeOpen(DataSet: TDataSet);
begin
  with DataSet as TVASUPQuery do
    QueryAllRecords:= Assigned(Master) and Master.Active;
end;

const
  PriorCentury= 19;
  NextCentury= 20;

procedure TdmGlobal.RR_DateFormat(Sender: TField);
var
  Year,Month,Day: Word;
  FirstDigits: Integer;
begin
  if Sender is TDateTimeField then
    with Sender as TDateTimeField do
      if not IsNull then
        if not (Tag and RECHANGED_FIELDTAG=RECHANGED_FIELDTAG) then
        begin
          Tag:= Tag+RECHANGED_FIELDTAG;
          DecodeDate(Value, Year, Month, Day);
          case Year mod 100 of
            0..RR_DateFormatBoundary: FirstDigits:= NextCentury
            else FirstDigits:= PriorCentury
          end;
          Year:= FirstDigits*100 + Year mod 100;
          Value:= EncodeDate(Year, Month, Day)
        end
        else Tag:= Tag - RECHANGED_FIELDTAG;
end;

procedure TdmGlobal.MonthBeginFormat(Sender: TField);
var
  Year,Month,Day: Word;
begin
  if not Sender.IsNull then
  begin
    DecodeDate(Sender.Value,Year,Month,Day);
    if Day>1 then
      Sender.Value:= EncodeDate(Year,Month,1);
    RR_DateFormat(Sender);
  end;
end;

var v_ChangeDept : Boolean = False ;
procedure TdmGlobal.RefreshCalcFields(Sender: TField);
var
  Query: TOracleQuery;
  PosSeparat: Integer;
  TempField : TField;
  v_mipodr_kod, v_mipodr_id : variant;
begin
  Query:= TOracleQuery.Create(Sender);
  try
    if Sender.DataSet is TOracleDataSet then
    begin
      Query.Session:= (Sender.DataSet as TOracleDataSet).Session;
      if Sender= quFirmCOUNTRY_NO then
      begin
        AskSingleManual( Query,'S.COUNTRY','COUNTRY_NO','NAME',
                         Sender,Sender.DataSet.FieldByName('COUNTRY_NAIM'));
        quFirmREGION_NO.Clear;
      end
      else if Sender= quFirmREGION_NO then
      begin
        AskMyList(Query,'S.REGION','NAME',
                [quFirmCOUNTRY_NO,quFirmREGION_NO],
                [otInteger,otInteger],
                ['COUNTRY_NO','REGION_NO'],
                [True],[quFirmREGION_NAIM]);
        quFirmDISTRICT_NO.Clear;
      end
      else if Sender= quFirmDISTRICT_NO then
        AskMyList(Query,'S.DISTRICT','NAME',
                [quFirmCOUNTRY_NO,quFirmREGION_NO,quFirmDISTRICT_NO],
                [otInteger,otInteger,otInteger],
                ['COUNTRY_NO','REGION_NO','DISTRICT'],
                [True],[quFirmDISTRICT_NAIM])
      else if Sender= quAccountCURRENCY_NO then
        AskSingleManual( Query,'S.CURRENCY','CURRENCY_NO','NAME',
                         quAccountCURRENCY_NO,quAccountCURRENCY_NAIM)
      else if Sender= quAccountCOUNTRY_NO then
      begin
        AskSingleManual( Query,'S.COUNTRY','COUNTRY_NO','NAME',
                         quAccountCOUNTRY_NO,quAccountCOUNTRY_NAIM);
        quAccountBANK_ID.Clear;
      end
      else if Sender= quAccountBANK_ID then
        AskSingleManual( Query,'S.BANK','BANK_ID','NAME',
                         quAccountBANK_ID,quAccountBANK_NAIM)
      // quTreaty
      else if Sender= quTreatyCHAPTER_KOD then
        AskSingleManual( Query,'RN.MICHAPTER','KOD','SNAIM',
                         quTreatyCHAPTER_KOD,quTreatyCHAPTER_SNAIM)
      else if Sender= quTreatyANNUL_KOD then
        AskSingleManual( Query,'RN.MIANNUL','KOD','SNAIM',
                         quTreatyANNUL_KOD,quTreatyANNUL_SNAIM)
      else if Sender= quTreatyPAYMENT_KOD then
        AskSingleManual( Query,'RN.MIPAYMENT','KOD','SNAIM',
                         quTreatyPAYMENT_KOD,quTreatyPAYMENT_SNAIM)
      else if Sender= quTreatyISTFIN_KOD then
        AskSingleManual( Query,'S.MIISTFIN','KOD','SNAIM',
                         quTreatyISTFIN_KOD,quTreatyISTFIN_SNAIM)
      else if Sender= quTreatyPLAT_DOC_TYPE then
        AskSingleManual( Query,'RN.MIPLATDOC','DOC_TYPE_NO','NAME',
                         quTreatyPLAT_DOC_TYPE,quTreatyPD_NAME)

         // Исполнитель
      else if Sender= quTreatyEXEC_FIRM_NO then
      begin
        quTreatyEXEC_CURRENCY_NO.Clear;
        quTreatyEXEC_BANK_ID.Clear;
        quTreatyEXEC_BANK_ACCOUNT.Clear;
        AskMyList(Query,'S.FIRM_ACCOUNT',
                'BANK_ACCNT_ID,COUNTRY_NO,BANK_ID,CURRENCY_NO,BANK_ACCOUNT',
                [quTreatyEXEC_FIRM_NO],
                [otFloat],
                ['FIRM_NO','COUNTRY_NO','BANK_ID','BANK_ACCOUNT','CURRENCY_NO'],
                [True,True,True,True,True],
                [quTreatyEXEC_ACCOUNT_ID,quTreatyEXEC_COUNTRY_NO,
                 quTreatyEXEC_BANK_ID,quTreatyEXEC_CURRENCY_NO,quTreatyEXEC_BANK_ACCOUNT]);
        AskSingleManual( Query,'S.FIRM','FIRM_NO','NAME',
                         quTreatyEXEC_FIRM_NO,quTreatyEXEC_NAME);
        AskSingleManual( Query,'S.FIRM','FIRM_NO','SHORT_NAME',
                         quTreatyEXEC_FIRM_NO,quTreatyEXEC_SHORT_NAME);

        AskMyListWithNull(Query,'RN.MIFIRM_BANK',
                          'NAME_BENEFICIARY, BANK, NIOKR_ACCOUNT',
                          [quTreatyEXEC_FIRM_NO, quTreatyEXEC_COUNTRY_NO, quTreatyEXEC_BANK_ID],
                          [otFloat, otFloat, otString],
                          ['FIRM_NO','COUNTRY_NO','BANK_ID'],
                          [True,True,True],
                          [quTreatyNAME_BENEFICIARY,quTreatyBANK,
                           quTreatyNIOKR_ACCOUNT]);
      end
      else if Sender= quTreatyEXEC_CURRENCY_NO then
      begin
        AskSingleManual( Query,'S.CURRENCY','CURRENCY_NO','ISO_NAME',
                         quTreatyEXEC_CURRENCY_NO,quTreatyEXEC_CURRENCY_NAME);
      end
      else if Sender= quTreatyEXEC_BANK_ID then
      begin
        AskSingleManual( Query,'S.BANK','BANK_ID','NAME',
                         quTreatyEXEC_BANK_ID,quTreatyEXEC_BANK_NAME);

        AskMyListWithNull(Query,'RN.MIFIRM_BANK',
                          'NAME_BENEFICIARY, BANK, NIOKR_ACCOUNT',
                          [quTreatyEXEC_FIRM_NO, quTreatyEXEC_COUNTRY_NO, quTreatyEXEC_BANK_ID],
                          [otFloat, otFloat, otString],
                          ['FIRM_NO','COUNTRY_NO','BANK_ID'],
                          [True,True,True],
                          [quTreatyNAME_BENEFICIARY,quTreatyBANK,
                           quTreatyNIOKR_ACCOUNT]);
      end

      else if Sender= quTreatyEXEC_BANK_ACCOUNT then
      begin
       if not quTreatyEXEC_BANK_ACCOUNT.IsNull then
        AskMyList(Query,'S.FIRM_ACCOUNT',
                'BANK_ACCNT_ID,COUNTRY_NO,BANK_ID,CURRENCY_NO,BANK_ACCOUNT,FIRM_NO',
                [quTreatyEXEC_FIRM_NO,quTreatyEXEC_BANK_ACCOUNT],
                [otFloat,otString],
                ['FIRM_NO','BANK_ACCOUNT'],
                [True,True,True,True,False,False],
                [quTreatyEXEC_ACCOUNT_ID,quTreatyEXEC_COUNTRY_NO,
                 quTreatyEXEC_BANK_ID,quTreatyEXEC_CURRENCY_NO,quTreatyEXEC_BANK_ACCOUNT,
                 quTreatyEXEC_FIRM_NO])
       else
       begin
        quTreatyEXEC_ACCOUNT_ID.Clear;
        quTreatyEXEC_CURRENCY_NO.Clear;
        quTreatyEXEC_BANK_ID.Clear;
       end;
      end
      // Заказчик
      else if Sender= quTreatyCUST_FIRM_NO then
      begin
        quTreatyCUST_CURRENCY_NO.Clear;
        quTreatyCUST_BANK_ID.Clear;
        quTreatyCUST_BANK_ACCOUNT.Clear;
        AskMyList(Query,'S.FIRM_ACCOUNT',
                'BANK_ACCNT_ID,COUNTRY_NO,BANK_ID,CURRENCY_NO,BANK_ACCOUNT',
                [quTreatyCUST_FIRM_NO],
                [otFloat],
                ['FIRM_NO','COUNTRY_NO','BANK_ID','BANK_ACCOUNT','CURRENCY_NO'],
                [True,True,True,True,True],
                [quTreatyCUST_ACCOUNT_ID,quTreatyCUST_COUNTRY_NO,
                 quTreatyCUST_BANK_ID,quTreatyCUST_CURRENCY_NO,quTreatyCUST_BANK_ACCOUNT]);
        AskSingleManual( Query,'S.FIRM','FIRM_NO','NAME',
                         quTreatyCUST_FIRM_NO,quTreatyCUST_NAME);
        AskSingleManual( Query,'S.FIRM','FIRM_NO','SHORT_NAME',
                         quTreatyCUST_FIRM_NO,quTreatyCUST_SHORT_NAME);
      end
      else if Sender= quTreatyCUST_CURRENCY_NO then
      begin
        AskSingleManual( Query,'S.CURRENCY','CURRENCY_NO','ISO_NAME',
                         quTreatyCUST_CURRENCY_NO,quTreatyCUST_CURRENCY_NAME);
      end
      else if Sender= quTreatyCUST_BANK_ID then
      begin
        AskSingleManual( Query,'S.BANK','BANK_ID','NAME',
                         quTreatyCUST_BANK_ID,quTreatyCUST_BANK_NAME);
      end

      else if Sender= quTreatyCUST_BANK_ACCOUNT then
      begin
       if not quTreatyCUST_BANK_ACCOUNT.IsNull then
        AskMyList(Query,'S.FIRM_ACCOUNT',
                'BANK_ACCNT_ID,COUNTRY_NO,BANK_ID,CURRENCY_NO,BANK_ACCOUNT,FIRM_NO',
                [quTreatyCUST_FIRM_NO,quTreatyCUST_BANK_ACCOUNT],
                [otFloat,otString],
                ['FIRM_NO','BANK_ACCOUNT'],
                [True,True,True,True,False,False],
                [quTreatyCUST_ACCOUNT_ID,quTreatyCUST_COUNTRY_NO,
                 quTreatyCUST_BANK_ID,quTreatyCUST_CURRENCY_NO,quTreatyCUST_BANK_ACCOUNT,
                 quTreatyCUST_FIRM_NO])
       else
       begin
        quTreatyCUST_ACCOUNT_ID.Clear;
        quTreatyCUST_CURRENCY_NO.Clear;
        quTreatyCUST_BANK_ID.Clear;
       end;
      end

      // quTreatyStage
      else if Sender= quTreatyStagePM_PMETHOD_NO then
        AskSingleManual( Query,'RN.PAYMENT_METHODS','PMETHOD_NO','PMETHOD_NAME',
                         quTreatyStagePM_PMETHOD_NO,quTreatyStagePMETHOD_NAME)
         // Исполнитель
      else if Sender= quTreatyStageEXEC_BANK_ACCOUNT then
      begin
       if not quTreatyStageEXEC_BANK_ACCOUNT.IsNull then
        AskMyList(Query,'S.FIRM_ACCOUNT', 'BANK_ACCNT_ID',
                  [quTreatyEXEC_FIRM_NO, quTreatyStageEXEC_BANK_ACCOUNT],
                  [otFloat,otString],['FIRM_NO','BANK_ACCOUNT'],
                  [True],[quTreatyStageEXEC_ACCOUNT_ID])
       else quTreatyStageEXEC_ACCOUNT_ID.Clear;
       if not quTreatyStageEXEC_ACCOUNT_ID.IsNull then
        AskSingleManual( Query,'S.FIRM','FIRM_NO','NAME',quTreatyEXEC_FIRM_NO,quTreatyStageEXEC_NAME)
       else quTreatyStageEXEC_NAME.Clear;
      end
         // Заказчик
      else if Sender= quTreatyStageCUST_BANK_ACCOUNT then
      begin
       if not quTreatyStageCUST_BANK_ACCOUNT.IsNull then
        AskMyList(Query,'S.FIRM_ACCOUNT', 'BANK_ACCNT_ID',
                [quTreatyCUST_FIRM_NO, quTreatyStageCUST_BANK_ACCOUNT],
                [otFloat,otString],['FIRM_NO','BANK_ACCOUNT'],
                [True],[quTreatyStageCUST_ACCOUNT_ID])
       else quTreatyStageCUST_ACCOUNT_ID.Clear;
       if not quTreatyStageCUST_ACCOUNT_ID.IsNull then
        AskSingleManual( Query,'S.FIRM','FIRM_NO','NAME',quTreatyCUST_FIRM_NO,quTreatyStageCUST_NAME)
       else quTreatyStageCUST_NAME.Clear;
      end

      // quAgreem
      else if Sender= quAgreemISTFIN_KOD then
        AskSingleManual( Query,'S.MIISTFIN','KOD','SNAIM',
                         quAgreemISTFIN_KOD,quAgreemISTFIN_SNAIM)
      else
      if Sender= quAgreemPAYMENT_KOD then
        AskSingleManual( Query,'RN.MIPAYMENT','KOD','SNAIM',
                         quAgreemPAYMENT_KOD,quAgreemPAYMENT_SNAIM)


      // quAgreemStage
      else if Sender= quAgreemStagePM_PMETHOD_NO then
        AskSingleManual( Query,'RN.PAYMENT_METHODS','PMETHOD_NO','PMETHOD_NAME',
                         quAgreemStagePM_PMETHOD_NO,quAgreemStagePMETHOD_NAME)
         // Исполнитель
      else if Sender= quAgreemStageEXEC_BANK_ACCOUNT then
      begin
       if not quAgreemStageEXEC_BANK_ACCOUNT.IsNull then
        AskMyList(Query,'S.FIRM_ACCOUNT', 'BANK_ACCNT_ID',
                [quTreatyEXEC_FIRM_NO, quAgreemStageEXEC_BANK_ACCOUNT],
                [otFloat,otString],['FIRM_NO','BANK_ACCOUNT'],
                [True],[quAgreemStageEXEC_ACCOUNT_ID])
        else quAgreemStageEXEC_ACCOUNT_ID.Clear;
        if not quAgreemStageEXEC_ACCOUNT_ID.IsNull then
         AskSingleManual( Query,'S.FIRM','FIRM_NO','NAME',quTreatyEXEC_FIRM_NO,quAgreemStageEXEC_NAME)
        else quAgreemStageEXEC_NAME.Clear;
      end
        // Заказчик
      else if Sender= quAgreemStageCUST_BANK_ACCOUNT then
      begin
       if not quAgreemStageCUST_BANK_ACCOUNT.IsNull then
        AskMyList(Query,'S.FIRM_ACCOUNT', 'BANK_ACCNT_ID',
                [quTreatyCUST_FIRM_NO, quAgreemStageCUST_BANK_ACCOUNT],
                [otFloat,otString],['FIRM_NO','BANK_ACCOUNT'],
                [True],[quAgreemStageCUST_ACCOUNT_ID])
        else quAgreemStageCUST_ACCOUNT_ID.Clear;
        if not quAgreemStageCUST_ACCOUNT_ID.IsNull then
         AskSingleManual( Query,'S.FIRM','FIRM_NO','NAME',quTreatyCUST_FIRM_NO,quAgreemStageCUST_NAME)
        else quAgreemStageCUST_NAME.Clear;
      end

      // quTrCurator
      else if  Sender= quTrCuratorMIRAB_TABN then
      begin
        v_ChangeDept := True;
        if not quTrCuratorMIRAB_TABN.IsNull then
         AskMyList(Query,'RN.VIRAB',
                'MIRAB_TABN,MIPROF_KOD,MIPODR_ID,MIUPDR_KOD,MIPODR_KOD,FIO,FNAIM,INAIM,ONAIM',
                [quTrCuratorMIRAB_TABN,quTrCuratorMIPROF_KOD,quTrCuratorMIPODR_ID],
                [otInteger,otInteger,otFloat],
                ['MIRAB_TABN','MIPROF_KOD','MIPODR_ID'],
                [True,False,False,False,False,True,True,True],
                [quTrCuratorMIRAB_TABN,quTrCuratorMIPROF_KOD,quTrCuratorMIPODR_ID,
                 quTrCuratorMIUPDR_KOD,quTrCuratorMIPODR_KOD,quTrCuratorFIO,
                 quTrCuratorFNAIM,quTrCuratorINAIM,quTrCuratorONAIM])
        else
        begin
         quTrCuratorFIO.Clear; quTrCuratorFNAIM.Clear;
         quTrCuratorINAIM.Clear; quTrCuratorONAIM.Clear;
        end;
        v_ChangeDept := False;
      end
      else if Sender= quTrCuratorMIPROF_KOD then
      begin
        AskSingleManual( Query,'P.MIPROF','KOD','SNAIM',
                         quTrCuratorMIPROF_KOD,quTrCuratorMIPROF_SNAIM);
      end
      else if Sender= quTrCuratorMIUPDR_KOD then
      begin
        AskSingleManual( Query,'P.VUPDR','KOD','SNAIM',
                         quTrCuratorMIUPDR_KOD,quTrCuratorMIUPDR_SNAIM);
        if v_ChangeDept=False then
        begin
          v_ChangeDept := True;
          if (not quTrCuratorMIUPDR_KOD.IsNull) or (quTrCuratorMIUPDR_KOD.Value <> 0) then
          begin
           AskSingleManual( Query,'P.VUPDR','KOD','ID',
                            quTrCuratorMIUPDR_KOD,quTrCuratorUPDR_ID);
           if quTrCuratorUPDR_ID.Value <> quTrCuratorMIPODR_ID.Value
              then quTrCuratorMIPODR_ID.Value := quTrCuratorUPDR_ID.Value
          end
          else quTrCuratorMIPODR_ID.Clear;
          quTrCuratorMIPODR_KOD.Clear;
          quTrCuratorMIRAB_TABN.Clear;
          v_ChangeDept := False;
        end
      end
      else if Sender=quTrCuratorMIPODR_KOD then
      begin
        AskSingleManual( Query,'RN.VPODR','MIPODR_KOD','MIPODR_SNAIM',
                         quTrCuratorMIPODR_KOD,quTrCuratorMIPODR_SNAIM);
        if v_ChangeDept=False then
        begin
         v_ChangeDept := True;
         if (not quTrCuratorMIPODR_KOD.IsNull) then
         begin
          AskSingleManual( Query,'RN.VPODR','MIPODR_KOD','MIUPDR_KOD',
                           quTrCuratorMIPODR_KOD,quTrCuratorMIUPDR_KOD);
          AskSingleManual( Query,'RN.VPODR','MIPODR_KOD','MIPODR_ID',
                           quTrCuratorMIPODR_KOD,quTrCuratorMIPODR_ID);
         end
         else if not quTrCuratorMIUPDR_KOD.IsNull
              then AskSingleManual( Query,'P.VUPDR','KOD','ID',
                                    quTrCuratorMIUPDR_KOD,quTrCuratorMIPODR_ID)
              else quTrCuratorMIPODR_ID.Clear;
         quTrCuratorMIRAB_TABN.Clear;
         v_ChangeDept := False;
        end
      end
      else if Sender= quTrCuratorMIPODR_ID then
      begin
       if ((not quTrCuratorMIPODR_ID.IsNull) or (quTrCuratorMIPODR_ID.Value <> 0))
          and (v_ChangeDept=False) then
       begin
        v_ChangeDept := True;
        AskSingleManual( Query,'RN.VPODR','MIPODR_ID','MIUPDR_KOD',
                         quTrCuratorMIPODR_ID,quTrCuratorMIUPDR_KOD);
        AskSingleManual( Query,'RN.VPODR','MIPODR_ID','MIPODR_KOD',
                         quTrCuratorMIPODR_ID,quTrCuratorMIPODR_KOD);
        quTrCuratorMIRAB_TABN.Clear;
        v_ChangeDept := False;
       end;
      end
      else if Sender= fltfldTreatyMIPODR_ID then
      begin
       if ((not fltfldTreatyMIPODR_ID.IsNull) or (fltfldTreatyMIPODR_ID.Value <> 0))
          and (v_ChangeDept=False) then
       begin
        v_ChangeDept := True;
        AskSingleManual( Query,'RN.VPODR','MIPODR_ID','MIPODR_KOD',
                         fltfldTreatyMIPODR_ID,intgrfldTreatyMIPODR_KOD);
        v_ChangeDept := False;
       end;
      end
      else if Sender=intgrfldTreatyMIPODR_KOD then
      begin
        AskSingleManual( Query,'RN.VPODR','MIPODR_KOD','MIPODR_SNAIM',
                         intgrfldTreatyMIPODR_KOD, strngfldTreatyMIPODR_SNAIM);
        if v_ChangeDept=False then
        begin
         v_ChangeDept := True;
         if (not intgrfldTreatyMIPODR_KOD.IsNull) then
         begin
          AskSingleManual( Query,'RN.VPODR','MIPODR_KOD','MIPODR_ID',
                           intgrfldTreatyMIPODR_KOD,fltfldTreatyMIPODR_ID);
         end;
         v_ChangeDept := False;
        end
      end;

      //Этот блок должен идти в самом конце (обработка по умолчанию)
{      else if Pos('_',Sender.FieldName) <> 0 then
      begin
        PosSeparat:= Pos('_',Sender.FieldName);
        AskHim( Query,Copy(Sender.FieldName,1,PosSeparat-1),Sender
                ,Sender.DataSet.FieldByName
                (Copy(Sender.FieldName,1,PosSeparat)+'NAIM')
                )
      end
      }
    end;
  finally
    Query.Free;
  end;
end;

procedure TdmGlobal.SetAllPrivileges(OwnerList,ObjectList: TStrings);
var
  privQuery: TOracleQuery;
  NumPriv: Integer;
  I: Integer;
  PriorObj,NextObj: string;
  CompList: TList;
  TempAcLevel: TAccessLevel;

function GenerateObjectSet: string;
var
  I: Integer;
begin
  Result:= '';
  for I:= 0 to OwnerList.Count-1 do
  begin
    Result:= Concat(Result,Format('(%s,%s)',[OwnerList[I],ObjectList[I]]));
    if I<OwnerList.Count-1 then
       Result:= Concat(Result,',');
  end;
end;

procedure GetListOfOracleComp(ResList: TList;const OwnerName,ObjectName: string);
var
  iObj: Integer;
begin
  ResList.Clear;
  iObj:= OwnerList.Count-1;
  while iObj>=0 do
  begin
    if (ObjectList[iObj]=InBrack(ObjectName))
              and (OwnerList[iObj]=InBrack(OwnerName)) then
    begin
      ResList.Add(ObjectList.Objects[iObj]);
      ObjectList.Delete(iObj);
      OwnerList.Delete(iObj);
    end;
    Dec(iObj);
  end;
end;

function PrivFormat(const Privilege: string):Integer;
const
  CUnUsePrivilege= -1;

begin
  if Privilege='SELECT' then Result:= Ord(aqQuerying)
  else if Privilege='UPDATE' then Result:= Ord(aqEditing)
    else if Privilege='DELETE' then Result:= Ord(aqDeleting)
      else if Privilege='INSERT' then Result:= Ord(aqInserting)
        else Result:= CUnUsePrivilege;
end;
begin
  if OwnerList.Count>0 then
  begin
    privQuery:= TOracleQuery.Create(Self);
    with privQuery do
    try
      Session:= seOracle;
      SQL.Append('SELECT A.PRIVILEGE,A.TABLE_SCHEMA,A.TABLE_NAME FROM ALL_TAB_PRIVS A,USER_ROLE_PRIVS U');
      SQL.Append(Format('WHERE (A.TABLE_SCHEMA,A.TABLE_NAME) IN (%s)  AND A.GRANTEE=U.GRANTED_ROLE',
               [GenerateObjectSet]));
      SQL.Append('ORDER BY A.TABLE_SCHEMA,A.TABLE_NAME');
      Execute;
      PriorObj:= '';
      CompList:= TList.Create;
      while not EOF do
      begin
        NextObj:= Concat(FieldAsString(1),FieldAsString(2));
        if PriorObj<>NextObj then
        begin
          PriorObj:= NextObj;
          for I:= 0 to CompList.Count-1 do
            if TObject(CompList[I]) is TVASUPQuery then
               TVASUPQuery(CompList[I]).AccessLevel:= TempAcLevel*TVASUPQuery(CompList[I]).AccessLevel;
          GetListOfOracleComp(CompList,FieldAsString(1),FieldAsString(2));
          TempAcLevel:= [];
        end;
        for I:= 0 to CompList.Count-1 do
          if TObject(CompList[I]) is TVASUPQuery then
          with TVASUPQuery(CompList[I]) do
          begin
            NumPriv:= PrivFormat(FieldAsString(0));
            if NumPriv in [Ord(Low(TAccessItems))..Ord(High(TAccessItems))] then
            begin
              TempAcLevel:= TempAcLevel+[TAccessItems(NumPriv)];
              if TAccessItems(NumPriv)= aqQuerying then
                TempAcLevel:= TempAcLevel+[aqPrinting]
            end;
          end
          else if TObject(CompList[I]) is TOraclePackage then
          with TOraclePackage(CompList[I]) do
            if FieldAsString(0)='EXECUTE' then
              Tag:= OP_EXECUTABLE;
        Next;
      end;
      for I:= 0 to CompList.Count-1 do
        if TObject(CompList[I]) is TVASUPQuery then
           TVASUPQuery(CompList[I]).AccessLevel:= TempAcLevel*TVASUPQuery(CompList[I]).AccessLevel;
      CompList.Free;
    finally
      Free;
    end;
    for I:= 0 to ObjectList.Count-1 do
      if ObjectList.Objects[I] is TVASUPQuery then
         TVASUPQuery(ObjectList.Objects[I]).AccessLevel:= [];
  end;
end;

const
  Code_Line='QWER2TY3UIOP146ASDFG5_70HJKL8ZXCV9BNM';
  Standard_Line= '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_';

procedure TdmGlobal.seOracleAfterLogOn(Sender: TOracleSession);
var
  I,PosPoint:Integer;
  OracleObjList,OwnerList: TStrings;
  OwnerName: string;
begin
  if seOracle.Connected then
  begin
  //  Принадлежность к системе
{   if not NonDefaultRolesActivate(seOracle,SubSystemCode) then
    begin
      MessageDlg(CUnRegisteredUser,mtError,[mbOk],0);
      seOracle.Connected:= false;
      Application.Terminate;
      Exit;
    end;
}   FIni := TRegistry.Create();
    if not FIni.OpenKey(REGISTRY_OPTIONS, FALSE) then
    begin
      AddRegString();
      FIni.OpenKey(REGISTRY_OPTIONS, FALSE);
    end;
    CheckUpdates;
    OracleObjList:= TStringList.Create;
    OwnerList:= TStringList.Create;
    for I:= 0 to ComponentCount-1 do
    begin
      if Components[I] is TVASUPQuery then
      with Components[I] as TVASUPQuery do
      begin
        OwnerList.Append(ExtractOwner);
        OracleObjList.AddObject(ExtractTable,Self.Components[I]);
      end
      else if Components[I] is TOraclePackage then
      with Components[I] as TOraclePackage do
      begin
        PosPoint:= Pos('.',PackageName);
        if PosPoint=0 then
          OwnerName:= DefaultSchema
        else OwnerName:= Copy(PackageName,1,PosPoint-1);
        if OwnerName= seOracle.LogonUserName then
          Tag:= OP_EXECUTABLE
        else
        begin
          OwnerList.Append(InBrack(OwnerName));
          OracleObjList.AddObject( InBrack(Copy(PackageName,PosPoint+1,Length(PackageName)-PosPoint)),
                                   Self.Components[I]);
        end;
      end;
    end;
    SetAllPrivileges(OwnerList,OracleObjList);
{
    Вызов следующей процедуры заносит в SYSCONTEXT
    sys_context ('FIRM_ACCESS', 'NATURAL_PERSON_ACCESS')
    значение '+'. Это нужно для правильной работы закладки
    "Текущее состояние", т.к. если не занести +, то будет вылазить
    ошибка запроса: невозможно вытянуть ROWID.
    Причина: на таблице S.FIRM висит FGAC - контроль доступа к записям
    Контроль осуществляется по значению из SYSCONTEXT-a.
}
    pkgFirmAccess.CallProcedure('set_natural_person_access',['+']);

    OracleObjList.Free;
    OwnerList.Free;

{    try
      oqRoundDigits.Execute;
      RoundDigitCount:= oqRoundDigits.FieldAsInteger(0);
    finally
      oqRoundDigits.Close;
    end;}
  end;
end;

const
  ENullRefMsg='Нет данных о подразделении верхнего уровня';

procedure TdmGlobal.CheckLevelBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('MIPODR_ID').IsNull then
    raise Exception.Create(ENullRefMsg);
end;

function NVL(Field:TField;const Value: Integer):Integer;
begin
  if not Field.IsNull then
    Result:= Field.AsInteger
  else Result:= Value;
end;

//var
  //Changing: boolean;

const
  ProfTypeBound= 5000;

procedure TdmGlobal.DataModuleCreate(Sender: TObject);
begin
  seOracle.AutoCommit:= true;
end;

function IsEmptyRecord( ADataSet: TDataSet;
                        const UnImportants:Array of TField):bool;
var
  I: Integer;

function InArray(Field:TField):bool;
var
  J: Integer;
begin
  J:= Low(UnImportants);
  Result:= false;
  while (J<= High(UnImportants)) and not Result do
  begin
    Result:= Field= UnImportants[J];
    Inc(J);
  end;
end;

begin
  I:= 0;
  while (I<ADataSet.FieldCount)
        and ( (ADataSet.Fields[I].FieldKind<> fkData) or
              ADataSet.Fields[I].IsNull or InArray(ADataSet.Fields[I])
              ) do Inc(I);
  Result:= I=ADataSet.FieldCount;
end;

procedure TdmGlobal.quFirmBeforeVisualQuery(DataSet: TDataSet);
begin
  with DataSet as TVASUPQuery do
  begin
    if not Active then AfterClosePro(DataSet);
    SetVariable('EMPTY_OPEN',0);
  end;
end;

procedure TdmGlobal.quFirmAfterClose(DataSet: TDataSet);
begin
  with DataSet as TVASUPQuery do
  begin
    AfterClosePro(DataSet);
    SetVariable('EMPTY_OPEN',1);
  end;
end;

procedure TdmGlobal.quTreatyBeforeVisualQuery(DataSet: TDataSet);
begin
  with DataSet as TVASUPQuery do
  begin
    if not Active then AfterClosePro(DataSet);
    SetVariable('EMPTY_OPEN',0);
  end;
end;

procedure TdmGlobal.quTreatyAfterClose(DataSet: TDataSet);
begin
  with DataSet as TVASUPQuery do
  begin
    AfterClosePro(DataSet);
    SetVariable('EMPTY_OPEN',1);
  end;
end;

procedure TdmGlobal.BeforeEditTreaty(DataSet: TDataSet);
begin
 // Нельзя редактировать закрытый или аннулированный договор
 if quTreatySTATUS.Value = 'A' then raise Exception.Create(CTreatyAnnul);
 if quTreatySTATUS.Value = 'F' then raise Exception.Create(CTreatyClose);
end;

procedure TdmGlobal.quTrCuratorBeforeVisualQuery(DataSet: TDataSet);
begin
 inherited;
 if not quTrCuratorMIPODR_ID.IsNull
 then  quTrCurator.SetVariable('MAIN_DEPT',quTrCuratorMIPODR_ID.Value)
 else  quTrCurator.SetVariable('MAIN_DEPT',All_Departments_ID);

end;

procedure TdmGlobal.quTreatyAfterOpen(DataSet: TDataSet);
begin
  quTreaty.AfterOpenPro(DataSet);
  with DataSet as TVASUPQuery do
  begin
    SetVariable('EMPTY_OPEN',0);
  end;
  odsTrExecFirmProperty.Open;
end;

procedure TdmGlobal.quTreatyAfterInsert(DataSet: TDataSet);
begin
  if not quTreaty.IsQuery then
  begin
   quTreatyCUST_FIRM_NO.Value := 51;
   quTreatyCUST_BANK_ACCOUNT.Value := '3012001590010';
   quTreatyISTFIN_KOD.Value := 2;
   quTreatyPAYMENT_KOD.Value := 1;
  end;
end;

procedure TdmGlobal.quTreatyApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: String);
begin
  if (Action='U') or (Action='D') then
  begin
    if (Sender.FieldByName('DOC_NO').Value <> NULL) and
       ((Sender.FieldByName('STATUS').AsString = 'P') or (Action='D')) then
       Applied := not opNII_EVM_SERVIS.CallBooleanFunction('DelTreatyInM', [Sender.FieldByName('DOC_NO').Value]);
  end;
{  if Action='I' then
  begin
    seOracle.Commit;
    with TOracleQuery.Create(Self) do
    begin
     Session:= dmGlobal.seOracle;
     SQL.Append('SELECT TREATY_SEQ.CURRVAL FROM DUAL');
     Execute;
     if not EOF then
     begin
      quTreatyID.Value := Field(0);
      Close; Free;
      with TOracleQuery.Create(Self) do
      begin
       Session:= dmGlobal.seOracle;
       Execute;
       SQL.Append(FORMAT('SELECT ROWID FROM MNTREATY WHERE ID = %n ',[quTreatyID.Value]));
       if not EOF then NewRowId := Field(0);
       Close; Free;
      end;
     end
     else begin Close; Free; end;
    end;
  end;}



end;

procedure TdmGlobal.quTreatyBeforeClose(DataSet: TDataSet);
begin
  odsTrExecFirmProperty.Close;
end;

procedure TdmGlobal.odsTrExecFirmPropertyApplyRecord(
  Sender: TOracleDataSet; Action: Char; var Applied: Boolean;
  var NewRowId: String);
begin
  Applied := true;
end;

procedure TdmGlobal.quExpectedIncomeAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldValues['TYPE_PARAMETERS'] := 1;
end;

procedure TdmGlobal.YYYY_DateFormat(Sender: TField);
var
  Value : Variant;
begin
  Value := Sender.Value;
  if (Value <> NULL) and (Value <> EncodeDate(StrToInt(FormatDateTime('yyyy', Value)), 1, 1)) then
    Sender.Value := EncodeDate(StrToInt(FormatDateTime('yyyy', Value)), 1, 1);
end;

procedure TdmGlobal.quMitrconcernEXISTENT_BEG_INTERVALChange(
  Sender: TField);
var
  flDogLimit : TField;
begin
  flDogLimit := Sender.DataSet.FieldByName('DOG_LIMIT');

  if Sender.AsInteger = 0 then
  begin
    if not flDogLimit.IsNull then
      case flDogLimit.AsString[1] of
        'B' : flDogLimit.Value := 'N';
        'F' : flDogLimit.Value := 'E';
      end
    else
      flDogLimit.Value := 'N';
  end
  else
  begin
    if not flDogLimit.IsNull then
      case flDogLimit.AsString[1] of
        'E' : flDogLimit.Value := 'F';
        'N' : flDogLimit.Value := 'B';
      end
    else
      flDogLimit.Value := 'B';
  end;
end;

procedure TdmGlobal.quAgreemApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: String);
begin
  if (Action='U') or (Action='D') then
  begin
    if (Sender.FieldByName('DOC_NO').Value <> NULL) and
       ((Sender.FieldByName('NUM').AsString = '0') or (Action='D')) then
      opNII_EVM_SERVIS.CallBooleanFunction('DelAgreemInM', [Sender.FieldByName('DOC_NO').Value]);
  end;
end;

procedure TdmGlobal.quMipodrBeforeOpen(DataSet: TDataSet);
begin
  with DataSet as TVASUPQuery do
    SetVariable('DEPT_LEVEL', mdStruc.DataSetList.IndexOf(DataSet)+1);
end;

procedure TdmGlobal.quMipodrMIPODR_IDChange(Sender: TField);
var
  Query: TOracleQuery;
begin
  if not Sender.IsNull  then
  begin
    Query:= TOracleQuery.Create(Sender);
    Query.Session:= (Sender.DataSet as TOracleDataSet).Session;
    Query.SQL.Add('SELECT DISTINCT TO_CHAR(KOD,'+''''+'09'+''''+')||'+''''+' '+''''+'||SNAIM,KOD,PNAIM');
    Query.SQL.Add('FROM P.MIPODR WHERE ID=:P1');
    Query.DeclareVariable('P1',otInteger);
    Query.SetVariable('P1',Sender.AsInteger);
    Query.Execute;
    Sender.DataSet.FieldByName('VERH_PODR').AsString := Query.FieldAsString(0);
    Sender.DataSet.FieldByName('MIPODR_KOD').AsString := Query.FieldAsString(1);
    Sender.DataSet.FieldByName('VERH_NAIM').AsString := Query.FieldAsString(2);
    Query.Close;
    Query.Free;
  end
  else
  begin
    Sender.DataSet.FieldByName('VERH_PODR').Value:= Null;
    Sender.DataSet.FieldByName('MIPODR_KOD').Value:= Null;
    Sender.DataSet.FieldByName('VERH_NAIM').Value:= Null;
  end;
end;

procedure TdmGlobal.SetNDSSummPay(ATreaty : TVASUPQuery);
var
  NDS_Field :TField;
  SummPay_Fieled : TField;
  NDSSummPay_Fieled : TField;
  v : Extended;
begin
  NDS_Field := ATreaty.FieldByName('NDS');
  SummPay_Fieled := ATreaty.FieldByName('SUMMPAY');
  NDSSummPay_Fieled := ATreaty.FieldByName('NDS_SUMMPAY');

  if NDS_Field.IsNull or SummPay_Fieled.IsNull then
    NDSSummPay_Fieled.Value := NULL
  else
  begin
    v := Round((NDS_Field.Value*SummPay_Fieled.Value)/(100+NDS_Field.Value));
    NDSSummPay_Fieled.Value := v;
  end;
end;

procedure TdmGlobal.TrChangeNDS(Sender: TField);
var
  NDSSummPay_Fieled : TField;
  summpay : double;
begin
  if TVASUPQuery(Sender.DataSet).WorkState in [wsEdit, wsAdd] then
    SetNDSSummPay(TVASUPQuery(Sender.DataSet));
end;

procedure TdmGlobal.AgrChangeNDS(Sender: TField);
var
  NDSSummPay_Fieled : TField;
  summpay : double;
begin
  if TVASUPQuery(Sender.DataSet).WorkState in [wsEdit, wsAdd] then
    SetNDSSummPay(TVASUPQuery(Sender.DataSet));
end;

procedure TdmGlobal.StChangeNDS(Sender: TField);
begin
  if TVASUPQuery(Sender.DataSet).WorkState in [wsEdit, wsAdd] then
    SetNDSSummPay(TVASUPQuery(Sender.DataSet));
end;

procedure TdmGlobal.mm_yyyy_from(Sender: TField);
var
  Value, newValue : Variant;
  d, m, y : word;
begin
  Value := Sender.Value;
  if Value <> NULL then
  begin
    DecodeDate(Value, y, m, d);
    newValue := EncodeDate(y, m, 1);
    if Value <> newValue then
      Sender.Value := newValue;
  end;
end;

procedure TdmGlobal.mm_yyyy_to(Sender: TField);
var
  Value, newValue : Variant;
  d, m, y : word;
begin
  Value := Sender.Value;
  if Value <> NULL then
  begin
    DecodeDate(Value, y, m, d);

    case m of
      1 : newValue := EncodeDate(y, m, 31);
      2 : begin
            if (y mod 4) = 0 then
              newValue := EncodeDate(y, m, 29)
            else
              newValue := EncodeDate(y, m, 28)
          end;
      3 : newValue := EncodeDate(y, m, 31);
      4 : newValue := EncodeDate(y, m, 30);
      5 : newValue := EncodeDate(y, m, 31);
      6 : newValue := EncodeDate(y, m, 30);
      7 : newValue := EncodeDate(y, m, 31);
      8 : newValue := EncodeDate(y, m, 31);
      9 : newValue := EncodeDate(y, m, 30);
      10: newValue := EncodeDate(y, m, 31);
      11: newValue := EncodeDate(y, m, 30);
      12: newValue := EncodeDate(y, m, 31);
    end;

    if Value <> newValue then
      Sender.Value := newValue;
  end;
end;

procedure TdmGlobal.quMiExchangeCURRENCY_NOChange(Sender: TField);
var
  Query : TOracleQuery;
begin
  Query := TOracleQuery.Create(nil);
  Query.Session := seOracle;
  try
    AskSingleManualForResFields(Query, 'S.CURRENCY', 'CURRENCY_NO', ['ISO_NAME', 'NAME'],
                                Sender, [Sender.DataSet.FieldByName('ISO_NAME'),
                                         Sender.DataSet.FieldByName('CURRENCY')]);
  finally
    Query.Destroy;
  end;
end;

procedure TdmGlobal.CheckUpdates;
var Fs : TFileStream;
    Bs : TStream;
    localexedate, dbexedate : TDateTime;
    localexeversion, dbexeversion : Integer;
    appexename, appexemoved : string;
begin
  FIni.OpenKey(REGISTRY_OPTIONS, FALSE);
  if FIni.ReadString('Exe_date') = '' then
    FIni.WriteString('Exe_date','01.01.1990 12:00:00');

  if FIni.ReadString('Exe_version') = '' then
    FIni.WriteString('Exe_version', '1');

  localexedate := StrToDateTime(FIni.ReadString('Exe_date'));
  localexeversion := StrToInt(FIni.ReadString('Exe_version'));
  qryFileInfo.Open;
  dbexedate := dtmfldorcldtst1FILE_DATE.AsDateTime;
  dbexeversion := fltfldorcldtst1FILE_VERSION.AsInteger;

  if (dbexeversion > localexeversion) or
     (dbexedate > localexedate) then
  begin
    appexename := Application.ExeName;
    appexemoved := appexename + '.old';
    if Application.MessageBox(PChar('Обнаружена новая версия программы. Обновить?'), 'Новая версия программы', MB_YESNO + MB_ICONQUESTION) = idNo then
      Exit
    else
    begin
      //Переименовываем самого себя
      DeleteFile(appexemoved);
      MoveFile(PChar(appexename),PChar(appexemoved));
      try
        qryFileBody.Open;

//       Фишка с ТБлобСтреам-ом почему-то не работает в Делфи7, поэтому пришлось заменить на обычный ТСтреам
//        Bs := TBlobStream.Create(blbfldFileBodyFILE_BODY as TBlobField, bmRead) as TBlobStream;
        Bs := qryFileBody.CreateBlobStream(blbfldFileBodyFILE_BODY, bmRead);

        if Bs.Size <> fltfldorcldtst1FILE_SIZE.AsInteger then
        begin
          MoveFile(PChar(appexemoved),PChar(appexename));
          Exit;
        end;

        Fs := TFileStream.Create(appexename, fmCreate);
        Fs.Position := 0;
        blbfldFileBodyFILE_BODY.SaveToStream(Fs);
        Fs.Free;
        qryFileBody.Close;
      except
        on E:Exception do
          Application.MessageBox(Pchar('Какая-то ошибка при обновлении...'),'Ошибка', MB_ICONERROR);
      end;

      if not FileExists(appexename) then
      begin
        Application.MessageBox(PChar('Обновление завершилось неудачно. Будет запущена предыдущая версия'), 'Ошибка обновления', MB_ICONERROR);
        //Возвращаем экзешник обратно
        MoveFile(PChar(appexemoved),PChar(appexename));
        Exit;
      end;

      FIni.WriteString('Exe_version', fltfldorcldtst1FILE_VERSION.AsString);
      FIni.WriteString('Exe_date', dtmfldorcldtst1FILE_DATE.AsString);
      ShellExecute(0, nil, pChar(appexename), nil, nil, SW_SHOWMAXIMIZED);
      Application.Terminate;
    end;
  end;
  FIni.CloseKey;
end;

procedure AddRegString();
var MyReg : TRegistry;
begin
  MyReg := TRegistry.Create();
  MyReg.RootKey := HKEY_CURRENT_USER;
  MyReg.CreateKey(REGISTRY_ROOT);
  MyReg.CreateKey(REGISTRY_OPTIONS);
  MyReg.OpenKey(REGISTRY_OPTIONS, FALSE);
  MyReg.WriteString('Schema','RN');
  MyReg.WriteString('Exe_version', '1');
  MyReg.WriteString('Exe_date', '01.01.1990 12:00:00');
  MyReg.WriteString('Exe_path', 'C:\ASUP\NIOKR\');
  MyReg.CloseKey;
end;

initialization
  //Changing:= false;
  DateFormatBoundary:= RR_DateFormatBoundary;
end.
