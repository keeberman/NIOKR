object dmGlobal: TdmGlobal
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Left = 974
  Top = 114
  Height = 776
  Width = 825
  object Builder: TVBuilder
    Active = False
    Left = 32
  end
  object seOracle: TOracleSession
    AfterLogOn = seOracleAfterLogOn
    DesignConnection = True
    LogonUsername = 'RN'
    LogonPassword = '`'
    LogonDatabase = 'oracle'
    RollbackOnDisconnect = True
    NullValue = nvNull
    Connected = True
    Left = 80
  end
  object fsFields: TFormStorage
    Active = False
    Options = []
    UseRegistry = True
    StoredValues = <>
    Left = 8
    Top = 520
  end
  object quMichapter: TVASUPQuery
    SQL.Strings = (
      'SELECT A.*,A.ROWID FROM RN.MICHAPTER A /* END_REFRESH */')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0400000003000000030000004B4F4401000000000005000000534E41494D0100
      0000000005000000504E41494D010000000000}
    Cursor = crSQLWait
    UpdatingTable = 'RN.MICHAPTER'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1056#1072#1079#1076#1077#1083#1099'  '#1076#1086#1075#1086#1074#1086#1088#1086#1074
    Order = 'KOD ASC'
    EditorClassName = 'TfmChapter'
    LinkKind = lkIn
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 372
    Top = 2
    object quMichapterKOD: TIntegerField
      DisplayLabel = #1050#1086#1076
      DisplayWidth = 2
      FieldName = 'KOD'
      Required = True
    end
    object quMichapterSNAIM: TStringField
      DisplayLabel = #1057#1086#1082#1088'.'#1085#1072#1080#1084'.'
      FieldName = 'SNAIM'
      Required = True
      Size = 30
    end
    object quMichapterPNAIM: TStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'PNAIM'
      Required = True
      Size = 150
    end
  end
  object quCurrency: TVASUPQuery
    SQL.Strings = (
      'SELECT A.*,A.ROWID'
      'FROM S.CURRENCY A'
      '/* END_REFRESH */')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      04000000050000000B00000043555252454E43595F4E4F010000000000040000
      004E414D450100000000000800000049534F5F4E414D450100000000000C0000
      005052494F524954595F5553450100000000000C000000494E48455249544544
      5F4944010000000000}
    UpdatingTable = 'S.CURRENCY'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1082#1086#1076#1086#1074' '#1074#1072#1083#1102#1090
    Order = 'CURRENCY_NO ASC'
    EditorClassName = 'TfmCurrency'
    LinkKind = lkIn
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 424
    Top = 18
    object quCurrencyCURRENCY_NO: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = #1050#1086#1076' '#1074#1072#1083#1102#1090#1099
      FieldName = 'CURRENCY_NO'
      Required = True
    end
    object quCurrencyISO_NAME: TStringField
      DisplayLabel = #1050#1086#1076' (ISO)'
      FieldName = 'ISO_NAME'
      Required = True
      Size = 3
    end
    object quCurrencyNAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'NAME'
      Required = True
      Size = 50
    end
    object quCurrencyPRIORITY_USE: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = #1055#1088#1080#1086#1088#1080#1090#1077#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103
      FieldName = 'PRIORITY_USE'
    end
    object quCurrencyINHERITED_ID: TStringField
      DisplayLabel = #1059#1085#1072#1089#1083#1077#1076#1086#1074#1072#1085#1085#1099#1081' '#1082#1086#1076
      FieldName = 'INHERITED_ID'
      Size = 3
    end
  end
  object quFirm: TVASUPQuery
    SQL.Strings = (
      'SELECT A.*,'
      '       A.ROWID, '
      '       C.NAME COUNTRY_NAIM,'
      '       R.NAME REGION_NAIM,'
      '       D.NAME DISTRICT_NAIM'
      ' FROM S.FIRM A,'
      '      S.COUNTRY C,'
      '      S.REGION R,'
      '      S.DISTRICT D'
      'WHERE A.COUNTRY_NO = C.COUNTRY_NO(+)'
      '  AND ( A.COUNTRY_NO = R.COUNTRY_NO(+)'
      '  AND A.REGION_NO = R.REGION_NO(+) )'
      '  AND ( A.COUNTRY_NO = D.COUNTRY_NO(+)'
      '  AND A.REGION_NO = D.REGION_NO(+)'
      '  AND A.DISTRICT_NO = D.DISTRICT(+) )'
      '  AND :EMPTY_OPEN = 0'
      ' ')
    Optimize = False
    Variables.Data = {
      03000000010000000B0000003A454D5054595F4F50454E030000000400000001
      00000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000002C000000070000004649524D5F4E4F0100000000000A000000434F55
      4E5452595F4E4F01000000000009000000524547494F4E5F4E4F010000000000
      0B00000044495354524943545F4E4F01000000000009000000434954595F4E41
      4D4501000000000007000000414444524553530100000000000A00000053484F
      52545F4E414D45010000000000080000005A49505F434F444501000000000006
      00000050484F4E4531010000000000060000005641545F4E4F01000000000004
      0000004E414D4501000000000008000000504F53545F424F5801000000000006
      00000050484F4E45320100000000000600000050484F4E453301000000000006
      00000050484F4E45340100000000000600000050484F4E453501000000000006
      0000004641585F4E4F0100000000000800000054454C45585F4E4F0100000000
      000A00000050524F50524945544F520100000000000C000000414C545F504159
      5F4649524D0100000000000C000000494E484552495445445F49440100000000
      000D00000050524F50455254595F545950450100000000000D000000494E4455
      535452595F5459504501000000000006000000455F4D41494C01000000000007
      0000004F4B504F5F49440100000000000C0000005241494C5F4649524D5F4E4F
      0100000000000F000000554E4954494E475F4649524D5F4E4F0100000000000D
      000000444542544F525F494E444354520100000000000F000000435245444954
      4F525F494E44435452010000000000100000004F4E4554494D455F434C4E545F
      494E440100000000000E0000004554414C4F4E5F5245435F494E440100000000
      000B000000494E534552545F444154450100000000000B000000555044415445
      5F444154450100000000000B000000494E534552545F55534552010000000000
      0B0000005550444154455F555345520100000000000B000000465F414242525F
      4E414D4501000000000011000000494E48455254445F53454C4C45525F494401
      0000000000090000004D41494E5F4649524D010000000000070000004F4B504F
      5F4E4F0100000000000C000000434F554E5452595F4E41494D0100000000000B
      000000524547494F4E5F4E41494D0100000000000D0000004449535452494354
      5F4E41494D0100000000000D000000494E4455535452595F4E41494D01000000
      00000D00000050524F50455254595F4E41494D010000000000}
    Cursor = crSQLWait
    UpdatingTable = 'S.FIRM'
    CommitOnPost = False
    Session = seOracle
    AfterClose = quFirmAfterClose
    ReActive = True
    Caption = #1050#1083#1080#1077#1085#1090#1099
    Order = 'FIRM_NO ASC'
    EditorClassName = 'TfmFirm'
    BeforeVisualQuery = quFirmBeforeVisualQuery
    LinkDetailSQL = True
    LinkKind = lkIn
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 372
    Top = 50
    object quFirmFIRM_NO: TFloatField
      DisplayLabel = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      DisplayWidth = 13
      FieldName = 'FIRM_NO'
      Origin = 'A.FIRM_NO'
      Required = True
      DisplayFormat = '#,###,###,##0'
      EditFormat = '##########'
    end
    object quFirmSHORT_NAME: TStringField
      DisplayLabel = #1057#1086#1082#1088'.'#1085#1072#1080#1084'.'
      FieldName = 'SHORT_NAME'
      Required = True
    end
    object quFirmNAME: TStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'NAME'
      Origin = 'A.NAME'
      Required = True
      Size = 120
    end
    object quFirmCOUNTRY_NO: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1089#1090#1088#1072#1085#1099
      DisplayWidth = 5
      FieldName = 'COUNTRY_NO'
      Origin = 'A.COUNTRY_NO'
      Required = True
      Visible = False
      OnChange = RefreshCalcFields
      DisplayFormat = '00000'
      EditFormat = '00000'
    end
    object quFirmCOUNTRY_NAIM: TStringField
      DisplayLabel = #1057#1090#1088#1072#1085#1072
      FieldKind = fkInternalCalc
      FieldName = 'COUNTRY_NAIM'
      Size = 50
    end
    object quFirmREGION_NO: TFloatField
      DisplayLabel = #1050#1086#1076' '#1088#1077#1075#1080#1086#1085#1072
      DisplayWidth = 13
      FieldName = 'REGION_NO'
      Origin = 'A.REGION_NO'
      Visible = False
      OnChange = RefreshCalcFields
      DisplayFormat = '#,###,###,##0'
      EditFormat = '#########0'
    end
    object quFirmREGION_NAIM: TStringField
      DisplayLabel = #1056#1077#1075#1080#1086#1085
      FieldKind = fkInternalCalc
      FieldName = 'REGION_NAIM'
      Size = 50
    end
    object quFirmDISTRICT_NO: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1088#1072#1081#1086#1085#1072' ('#1086#1082#1088#1091#1075#1072')'
      DisplayWidth = 5
      FieldName = 'DISTRICT_NO'
      Origin = 'A.DISTRICT_NO'
      Visible = False
      OnChange = RefreshCalcFields
      DisplayFormat = '00000'
      EditFormat = '00000'
    end
    object quFirmDISTRICT_NAIM: TStringField
      DisplayLabel = #1056#1072#1081#1086#1085'('#1054#1082#1088#1091#1075')'
      FieldKind = fkInternalCalc
      FieldName = 'DISTRICT_NAIM'
      Size = 50
    end
    object quFirmCITY_NAME: TStringField
      DisplayLabel = #1043#1086#1088#1086#1076
      FieldName = 'CITY_NAME'
      Size = 35
    end
    object quFirmZIP_CODE: TStringField
      DisplayLabel = #1055#1086#1095#1090#1086#1074#1099#1081' '#1080#1085#1076#1077#1082#1089
      FieldName = 'ZIP_CODE'
      Size = 10
    end
    object quFirmPOST_BOX: TStringField
      DisplayLabel = #1055#1086#1095#1090#1086#1074#1099#1081' '#1103#1097#1080#1082
      FieldName = 'POST_BOX'
      Size = 10
    end
    object quFirmADDRESS: TStringField
      DisplayLabel = #1040#1076#1088#1077#1089' ('#1091#1083#1080#1094#1072' '#8470#1076#1086#1084#1072')'
      FieldName = 'ADDRESS'
      Size = 60
    end
    object quFirmPHONE2: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085' 2'
      FieldName = 'PHONE2'
    end
    object quFirmPHONE1: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085' 1'
      FieldName = 'PHONE1'
    end
    object quFirmPHONE3: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085' 3'
      FieldName = 'PHONE3'
    end
    object quFirmPHONE4: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085' 4'
      FieldName = 'PHONE4'
    end
    object quFirmPHONE5: TStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085' 5'
      FieldName = 'PHONE5'
    end
    object quFirmFAX_NO: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1072#1082#1089#1072
      FieldName = 'FAX_NO'
      Size = 32
    end
    object quFirmTELEX_NO: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1082#1089#1072' ('#1090#1077#1083#1077#1090#1072#1081#1087')'
      FieldName = 'TELEX_NO'
      Size = 32
    end
    object quFirmE_MAIL: TStringField
      DisplayLabel = #1069#1083#1077#1082#1090#1088#1086#1085#1085#1072#1103' '#1087#1086#1095#1090#1072
      FieldName = 'E_MAIL'
      Size = 35
    end
    object quFirmVAT_NO: TStringField
      DisplayLabel = #1059#1053#1053' ('#1048#1053#1053')'
      FieldName = 'VAT_NO'
      Size = 25
    end
    object quFirmPROPRIETOR: TIntegerField
      DisplayLabel = #1060#1080#1079#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086' ('#1080#1085#1076#1080#1082#1072#1090#1086#1088')'
      DisplayWidth = 1
      FieldName = 'PROPRIETOR'
      DisplayFormat = '0'
      EditFormat = '0'
    end
    object quFirmALT_PAY_FIRM: TFloatField
      DisplayLabel = #1040#1083#1100#1090' '#1087#1083#1072#1090#1077#1083#1100#1097#1080#1082' ('#1087#1086#1083#1091#1095#1072#1090#1077#1083#1100' '#1087#1083#1072#1090#1077#1078#1072')'
      DisplayWidth = 13
      FieldName = 'ALT_PAY_FIRM'
      DisplayFormat = '#,###,###,##0'
      EditFormat = '#########0'
    end
    object quFirmINHERITED_ID: TStringField
      DisplayLabel = #1059#1085#1072#1089#1083#1077#1076#1086#1074#1072#1085#1085#1099#1081' '#1085#1086#1084#1077#1088
      FieldName = 'INHERITED_ID'
    end
    object quFirmOKPO_NO: TFloatField
      DisplayLabel = #1050#1086#1076' '#1054#1050#1055#1054
      DisplayWidth = 13
      FieldName = 'OKPO_NO'
      DisplayFormat = '#,###,###,##0'
      EditFormat = '#########0'
    end
    object quFirmRAIL_FIRM_NO: TFloatField
      DisplayLabel = #1050#1086#1076' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' ('#1052#1055#1057')'
      DisplayWidth = 13
      FieldName = 'RAIL_FIRM_NO'
      DisplayFormat = '#,###,###,##0'
      EditFormat = '#########0'
    end
    object quFirmUNITING_FIRM_NO: TFloatField
      DisplayLabel = #1059#1085#1072#1089#1083#1077#1076#1086#1074#1072#1085#1085#1099#1081' '#1082#1086#1076' '#1087#1088#1086#1076#1072#1074#1094#1072
      DisplayWidth = 13
      FieldName = 'UNITING_FIRM_NO'
      DisplayFormat = '#,###,###,##0'
      EditFormat = '#########0'
    end
    object quFirmDEBTOR_INDCTR: TIntegerField
      DisplayLabel = #1055#1088#1080#1079#1085#1072#1082' '#1076#1077#1073#1080#1090#1086#1088#1072
      DisplayWidth = 1
      FieldName = 'DEBTOR_INDCTR'
      DisplayFormat = '0'
      EditFormat = '0'
    end
    object quFirmCREDITOR_INDCTR: TIntegerField
      DisplayLabel = #1055#1088#1080#1079#1085#1072#1082' '#1082#1088#1077#1076#1080#1090#1086#1088#1072
      DisplayWidth = 1
      FieldName = 'CREDITOR_INDCTR'
      DisplayFormat = '0'
      EditFormat = '0'
    end
    object quFirmONETIME_CLNT_IND: TIntegerField
      DisplayLabel = #1055#1088#1080#1079#1085#1072#1082' '#1056#1040#1047#1054#1042#1067#1049' '#1050#1051#1048#1045#1053#1058
      DisplayWidth = 1
      FieldName = 'ONETIME_CLNT_IND'
      DisplayFormat = '0'
      EditFormat = '0'
    end
    object quFirmETALON_REC_IND: TIntegerField
      DisplayLabel = #1055#1088#1080#1079#1085#1072#1082' '#1069#1058#1040#1051#1054#1053#1053#1054#1049' '#1079#1072#1087#1080#1089#1080
      DisplayWidth = 1
      FieldName = 'ETALON_REC_IND'
      DisplayFormat = '0'
      EditFormat = '0'
    end
    object quFirmINSERT_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1074#1074#1086#1076#1072
      FieldName = 'INSERT_DATE'
    end
    object quFirmUPDATE_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      FieldName = 'UPDATE_DATE'
    end
    object quFirmINSERT_USER: TStringField
      DisplayLabel = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1074#1074#1086#1076#1080#1074#1096#1080#1081' '#1079#1072#1087#1080#1089#1100
      FieldName = 'INSERT_USER'
      Size = 30
    end
    object quFirmUPDATE_USER: TStringField
      DisplayLabel = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1080#1079#1084#1077#1085#1080#1074#1096#1080#1081' '#1079#1072#1087#1080#1089#1100
      FieldName = 'UPDATE_USER'
      Size = 30
    end
    object quFirmF_ABBR_NAME: TStringField
      DisplayLabel = #1040#1073#1073#1088#1077#1074#1080#1072#1090#1091#1088#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'F_ABBR_NAME'
      Size = 12
    end
    object quFirmOKPO_ID: TStringField
      DisplayLabel = 'obselete '#1050#1086#1076' '#1054#1050#1055#1054
      FieldName = 'OKPO_ID'
    end
    object quFirmINHERTD_SELLER_ID: TStringField
      DisplayLabel = #1059#1085#1072#1089#1083#1077#1076#1086#1074#1072#1085#1085#1099#1081' '#1082#1086#1076' '#1087#1088#1086#1076#1072#1074#1094#1072
      FieldName = 'INHERTD_SELLER_ID'
    end
    object quFirmMAIN_FIRM: TFloatField
      DisplayLabel = #1043#1086#1083#1086#1074#1085#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      DisplayWidth = 13
      FieldName = 'MAIN_FIRM'
      DisplayFormat = '#,###,###,##0'
      EditFormat = '#########0'
    end
  end
  object quAccount: TVASUPQuery
    SQL.Strings = (
      'SELECT FA.ROWID,'
      '       FA.FIRM_NO,'
      '       FA.COUNTRY_NO,'
      '       C.NAME COUNTRY_NAIM,'
      '       FA.BANK_ID,'
      '       FA.BANK_ACCOUNT,'
      '       FA.CURRENCY_NO,'
      '       CUR.NAME CURRENCY_NAIM,'
      '       B.NAME BANK_NAIM,'
      '       B.BANK_CODE,'
      '       B.ADDRESS BANK_ADDRESS'
      '  FROM S.FIRM_ACCOUNT FA,'
      '       S.BANK B,'
      '       S.COUNTRY C,'
      '       S.CURRENCY CUR'
      ' WHERE FA.BANK_ID = B.BANK_ID'
      '   AND FA.COUNTRY_NO = B.COUNTRY_NO'
      '   AND C.COUNTRY_NO(+) = FA.COUNTRY_NO'
      '   AND CUR.CURRENCY_NO(+) = FA.CURRENCY_NO'
      ' AND FIRM_NO = :FIRM_NO')
    Optimize = False
    Variables.Data = {
      0300000001000000080000003A4649524D5F4E4F030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000A000000070000004649524D5F4E4F0100000000000A000000434F55
      4E5452595F4E4F0100000000000700000042414E4B5F49440100000000000C00
      000042414E4B5F4143434F554E540100000000000B00000043555252454E4359
      5F4E4F0100000000000900000042414E4B5F434F44450100000000000C000000
      42414E4B5F414444524553530100000000000C000000434F554E5452595F4E41
      494D0100000000000D00000043555252454E43595F4E41494D01000000000009
      00000042414E4B5F4E41494D010000000000}
    Master = quFirm
    MasterFields = 'FIRM_NO'
    DetailFields = 'FIRM_NO'
    UpdatingTable = 'S.FIRM_ACCOUNT'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1057#1095#1077#1090#1072
    Order = 'FA.CURRENCY_NO ASC'
    LinkKind = lkIn
    EmbeddedSQLSlice.Strings = (
      '  FROM S.FIRM_ACCOUNT FA,'
      '       S.BANK B,'
      '       S.COUNTRY C,'
      '       S.CURRENCY CUR'
      ' WHERE FA.BANK_ID = B.BANK_ID'
      '   AND FA.COUNTRY_NO = B.COUNTRY_NO'
      '   AND C.COUNTRY_NO(+) = FA.COUNTRY_NO'
      '   AND CUR.CURRENCY_NO(+) = FA.CURRENCY_NO'
      ' ')
    UpdTabAlias = 'FA'
    TreeNodeIndex = 0
    Left = 428
    Top = 122
    object quAccountFIRM_NO: TFloatField
      DisplayLabel = #1050#1086#1076' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      DisplayWidth = 13
      FieldName = 'FIRM_NO'
      Origin = 'FA.FIRM_NO'
      Required = True
      DisplayFormat = '#,###,###,##0'
      EditFormat = '#########0'
    end
    object quAccountBANK_ACCOUNT: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1088#1072#1089#1095#1077#1090#1085#1086#1075#1086' '#1089#1095#1077#1090#1072
      FieldName = 'BANK_ACCOUNT'
      Origin = 'FA.BANK_ACCOUNT'
      Required = True
      Size = 25
    end
    object quAccountCURRENCY_NO: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1074#1072#1083#1102#1090#1099
      DisplayWidth = 5
      FieldName = 'CURRENCY_NO'
      Origin = 'FA.CURRENCY_NO'
      OnChange = RefreshCalcFields
      DisplayFormat = '00000'
      EditFormat = '00000'
    end
    object quAccountCURRENCY_NAIM: TStringField
      DisplayLabel = #1042#1072#1083#1102#1090#1072
      FieldKind = fkInternalCalc
      FieldName = 'CURRENCY_NAIM'
      Size = 50
    end
    object quAccountBANK_CODE: TStringField
      Tag = 1
      DisplayLabel = #1050#1086#1076' '#1073#1072#1085#1082#1072
      FieldKind = fkInternalCalc
      FieldName = 'BANK_CODE'
      Size = 15
    end
    object quAccountBANK_ID: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1050#1083#1102#1095' '#1073#1072#1085#1082#1072
      FieldName = 'BANK_ID'
      Origin = 'FA.BANK_ID'
      Required = True
      OnChange = RefreshCalcFields
      Size = 15
    end
    object quAccountBANK_NAIM: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1073#1072#1085#1082#1072
      FieldKind = fkInternalCalc
      FieldName = 'BANK_NAIM'
      Required = True
      Size = 60
    end
    object quAccountCOUNTRY_NO: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1089#1090#1088#1072#1085#1099' '#1073#1072#1085#1082#1072
      DisplayWidth = 5
      FieldName = 'COUNTRY_NO'
      Origin = 'FA.COUNTRY_NO'
      Required = True
      OnChange = RefreshCalcFields
      DisplayFormat = '00000'
      EditFormat = '00000'
    end
    object quAccountCOUNTRY_NAIM: TStringField
      DisplayLabel = #1057#1090#1088#1072#1085#1072' '#1073#1072#1085#1082#1072
      FieldKind = fkInternalCalc
      FieldName = 'COUNTRY_NAIM'
      Size = 50
    end
    object quAccountBANK_ADDRESS: TStringField
      DisplayLabel = #1040#1076#1088#1077#1089' '#1073#1072#1085#1082#1072
      FieldKind = fkInternalCalc
      FieldName = 'BANK_ADDRESS'
      Size = 60
    end
  end
  object quPayMethods: TVASUPQuery
    SQL.Strings = (
      'SELECT A.*,A.ROWID FROM RN.PAYMENT_METHODS A /* END_REFRESH */')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      04000000020000000A000000504D4554484F445F4E4F0100000000000C000000
      504D4554484F445F4E414D45010000000000}
    UpdatingTable = 'RN.PAYMENT_METHODS'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1060#1086#1088#1084#1099' '#1088#1072#1089#1095#1077#1090#1086#1074
    Order = 'PMETHOD_NO ASC'
    EditorClassName = 'TfmPayMethods'
    LinkKind = lkIn
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 416
    Top = 66
    object quPayMethodsPMETHOD_NO: TIntegerField
      DisplayLabel = #1053#1086#1084#1077#1088
      DisplayWidth = 3
      FieldName = 'PMETHOD_NO'
      Required = True
      EditFormat = '000'
    end
    object quPayMethodsPMETHOD_NAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'PMETHOD_NAME'
      Required = True
      Size = 100
    end
  end
  object quMiIstFin: TVASUPQuery
    SQL.Strings = (
      'SELECT A.*,A.ROWID FROM S.MIISTFIN A /* END_REFRESH */')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0400000003000000030000004B4F4401000000000005000000534E41494D0100
      0000000005000000504E41494D010000000000}
    UpdatingTable = 'S.MIISTFIN'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1048#1089#1090#1086#1095#1085#1080#1082#1080' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
    Order = 'KOD ASC'
    EditorClassName = 'TfmMiIstFin'
    LinkKind = lkIn
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 424
    Top = 170
    object quMiIstFinKOD: TIntegerField
      DisplayLabel = #1050#1086#1076
      DisplayWidth = 3
      FieldName = 'KOD'
      Required = True
    end
    object quMiIstFinSNAIM: TStringField
      DisplayLabel = #1057#1086#1082#1088'.'#1085#1072#1080#1084'.'
      FieldName = 'SNAIM'
    end
    object quMiIstFinPNAIM: TStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'PNAIM'
      Size = 40
    end
  end
  object quMiAnnul: TVASUPQuery
    SQL.Strings = (
      'SELECT A.*,A.ROWID FROM RN.MIANNUL A /* END_REFRESH */')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0400000003000000030000004B4F4401000000000005000000534E41494D0100
      0000000005000000504E41494D010000000000}
    UpdatingTable = 'RN.MIANNUL'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1042#1080#1076#1099' '#1072#1085#1085#1091#1083#1080#1088#1086#1074#1072#1085#1080#1103
    Order = 'KOD ASC,SNAIM ASC,PNAIM ASC'
    EditorClassName = 'TfmNSI2040'
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 324
    Top = 176
    object quMiAnnulKOD: TIntegerField
      DisplayLabel = #1050#1086#1076
      DisplayWidth = 2
      FieldName = 'KOD'
      Required = True
      EditFormat = '00'
    end
    object quMiAnnulSNAIM: TStringField
      DisplayLabel = #1057#1086#1082#1088'.'#1085#1072#1080#1084'.'
      FieldName = 'SNAIM'
      Required = True
    end
    object quMiAnnulPNAIM: TStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'PNAIM'
      Required = True
      Size = 40
    end
  end
  object quMiPayment: TVASUPQuery
    SQL.Strings = (
      'SELECT A.*,A.ROWID FROM RN.MIPAYMENT A /* END_REFRESH */')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0400000003000000030000004B4F4401000000000005000000534E41494D0100
      0000000005000000504E41494D010000000000}
    UpdatingTable = 'RN.MIPAYMENT'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1058#1080#1087#1099' '#1086#1087#1083#1072#1090
    EditorClassName = 'TfmNSI2040'
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 376
    Top = 152
    object quMiPaymentKOD: TIntegerField
      DisplayLabel = #1050#1086#1076
      DisplayWidth = 2
      FieldName = 'KOD'
      Required = True
      EditFormat = '00'
    end
    object quMiPaymentSNAIM: TStringField
      DisplayLabel = #1057#1086#1082#1088'.'#1085#1072#1080#1084'.'
      FieldName = 'SNAIM'
      Required = True
    end
    object quMiPaymentPNAIM: TStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'PNAIM'
      Required = True
      Size = 40
    end
  end
  object quTreaty: TVASUPQuery
    SQL.Strings = (
      'SELECT T.id,'
      '       T.num,'
      '       T.datesign,'
      '       T.subject,'
      '       T.cust_account_id,'
      '       T.exec_account_id,'
      '       T.datefrom, '
      '       (SELECT DATETO FROM MNAGREEM AG0 WHERE AG0.NUM = '
      '          (SELECT MAX(AG1.NUM)'
      '             FROM MNAGREEM ag1'
      '            WHERE AG0.treaty_id = ag1.treaty_id)'
      '         AND AG0.treaty_id = T.ID) dateto,'
      
        '--     ( SELECT SUMMPAY FROM MNAGREEM AG0 WHERE AG0.NUM = (SELEC' +
        'T MAX (AG1.NUM) FROM MNAGREEM AG1  WHERE AG1.treaty_id = T.ID) A' +
        'ND AG0.treaty_id = T.ID) summpay,'
      ''
      '       T.summpay,'
      '       T.payment_kod,'
      '       T.istfin_kod,'
      '       T.chapter_kod,'
      '       T.annul_kod,'
      '       T.status,'
      '       T.MIPODR_ID MIPODR_ID,'
      '       UPDR.MIUROVEN_KOD MIUROVEN_KOD,'
      '       UPDR.KOD MIPODR_KOD,'
      '       UPDR.SNAIM MIPODR_SNAIM,'
      '       UPDR.PNAIM MIPODR_PNAIM,'
      '       T.theme_plan_num,'
      '       T.first_year_summpay,'
      '       T.doc_no,'
      '--OLD       T.nds,'
      '--OLD       T.nds_summpay,'
      
        '      ( SELECT NDS FROM MNAGREEM AG0 WHERE AG0.NUM = (SELECT MAX' +
        ' (AG1.NUM) FROM MNAGREEM AG1  WHERE AG1.treaty_id = T.ID) AND AG' +
        '0.treaty_id = T.ID) NDS,'
      
        '      ( SELECT NDS_SUMMPAY FROM MNAGREEM AG2 WHERE AG2.NUM = (SE' +
        'LECT MAX (AG3.NUM) FROM MNAGREEM AG3   WHERE AG3.treaty_id = T.I' +
        'D) AND AG2.treaty_id = T.ID) NDS_SUMMPAY,'
      '       T.plat_doc_type,'
      '       T.ROWID,'
      '       DT.NAME PD_NAME,'
      '       AGR.ID AGREEM_ID,'
      '       A.SNAIM ANNUL_SNAIM,'
      '       C.SNAIM CHAPTER_SNAIM,'
      '       I.SNAIM ISTFIN_SNAIM,'
      '       P.SNAIM PAYMENT_SNAIM,'
      '       /* '#1047#1072#1082#1072#1079#1095#1080#1082' */'
      '       FA_CUST.BANK_ACCOUNT CUST_BANK_ACCOUNT,'
      '       FA_CUST.CURRENCY_NO  CUST_CURRENCY_NO,'
      '       C_CUST.ISO_NAME CUST_CURRENCY_NAME,'
      '       FA_CUST.FIRM_NO CUST_FIRM_NO,'
      '       F_CUST.SHORT_NAME CUST_SHORT_NAME,'
      '       F_CUST.NAME CUST_NAME,'
      '       F_CUST.VAT_NO CUST_VAT_NO,'
      '       FA_CUST.BANK_ID CUST_BANK_ID,'
      '       B_CUST.NAME CUST_BANK_NAME,'
      '       B_CUST.CITY_NAME CUST_CITY_NAME,'
      '       FA_CUST.COUNTRY_NO CUST_COUNTRY_NO,'
      '       CUST_COUNT.NAME CUST_COUNTRY_NAME,'
      '       /* '#1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100' */'
      '       FA_EXEC.BANK_ACCOUNT EXEC_BANK_ACCOUNT,'
      '       FA_EXEC.CURRENCY_NO EXEC_CURRENCY_NO,'
      '       C_EXEC.ISO_NAME EXEC_CURRENCY_NAME,'
      '       FA_EXEC.FIRM_NO EXEC_FIRM_NO,'
      '       F_EXEC.SHORT_NAME EXEC_SHORT_NAME,'
      '       F_EXEC.NAME EXEC_NAME,'
      '       F_EXEC.VAT_NO EXEC_VAT_NO,'
      '       FA_EXEC.BANK_ID EXEC_BANK_ID,'
      '       B_EXEC.NAME EXEC_BANK_NAME,'
      '       B_EXEC.CITY_NAME EXEC_CITY_NAME,'
      '       FA_EXEC.COUNTRY_NO EXEC_COUNTRY_NO,'
      '       EXEC_COUNT.NAME EXEC_COUNTRY_NAME,'
      '       F_B.NAME_BENEFICIARY NAME_BENEFICIARY,'
      '       F_B.BANK BANK,'
      '       F_B.NIOKR_ACCOUNT NIOKR_ACCOUNT,'
      '       SUMMARY.SUMMARY SUMMARY,'
      '       (SELECT SUM(sub_st.SUMMPAY)'
      '          FROM RN.MNAGREEM sub_agr,'
      '               RN.MNSTAGE sub_st'
      '         WHERE sub_agr.treaty_id = t.id'
      '           and sub_st.agreem_id = sub_agr.id'
      '           and (   (    sub_st.dateact IS NOT NULL'
      '                    AND sub_agr.num < (SELECT MAX(agr1.num)'
      '                                         FROM RN.mnagreem agr1'
      
        '                                        WHERE agr1.treaty_id = t' +
        '.id)'
      '                   )'
      '                OR (sub_agr.num = (SELECT MAX(agr1.num)'
      '                                     FROM RN.mnagreem agr1'
      '                                    WHERE agr1.treaty_id = t.id)'
      '                   )'
      '               )'
      '       ) ST_SUMMPAY,'
      '       (SELECT SUB_AGR.SUMMPAY'
      '          FROM RN.MNAGREEM sub_agr'
      '         WHERE sub_agr.treaty_id = t.id'
      '           AND (sub_agr.num = (SELECT MAX(agr1.num)'
      '                                 FROM RN.mnagreem agr1'
      '                                WHERE agr1.treaty_id = t.id)'
      '               )'
      '       ) AGR_SUMMPAY,'
      '       (SELECT SUM(sub_st.SUMMPAY)'
      '          FROM RN.MNAGREEM sub_agr,'
      '               RN.MNSTAGE sub_st'
      '         WHERE sub_agr.treaty_id = t.id'
      '           and sub_agr.num = 0'
      '           and sub_st.agreem_id = sub_agr.id'
      '       ) TR_SUMMPAY,'
      '       (SELECT SUM(sub_st.NDS_SUMMPAY)'
      '          FROM RN.MNAGREEM sub_agr,'
      '               RN.MNSTAGE sub_st,'
      '               RN.MNAGREEM agr11'
      '         WHERE sub_agr.treaty_id = t.id'
      '           and sub_st.agreem_id = sub_agr.id'
      '           and (   (    sub_st.dateact IS NOT NULL'
      '                    AND sub_agr.num < (SELECT MAX(agr1.num)'
      '                                         FROM RN.mnagreem agr1'
      
        '                                        WHERE agr1.treaty_id = t' +
        '.id)'
      '                   )'
      '                OR (sub_agr.num = (SELECT MAX(agr1.num)'
      '                                     FROM RN.mnagreem agr1'
      '                                    WHERE agr1.treaty_id = t.id)'
      '                   )'
      '               )'
      '           and agr11.treaty_id = t.id'
      '           and (agr11.num = (SELECT MAX(agr1.num)'
      '                                     FROM RN.mnagreem agr1'
      
        '                                    WHERE agr1.treaty_id = t.id)' +
        ')'
      '           and nvl(agr11.NDS, 0) <> 0'
      '       ) ST_NDS,'
      '       (SELECT SUB_AGR.NDS_SUMMPAY'
      '          FROM RN.MNAGREEM sub_agr'
      '         WHERE sub_agr.treaty_id = t.id'
      '           AND (sub_agr.num = (SELECT MAX(agr1.num)'
      '                                 FROM RN.mnagreem agr1'
      '                                WHERE agr1.treaty_id = t.id)'
      '               )'
      '       ) AGR_NDS,'
      '       (SELECT SUM(sub_st.NDS_SUMMPAY)'
      '          FROM RN.MNAGREEM sub_agr,'
      '               RN.MNSTAGE sub_st'
      '         WHERE sub_agr.treaty_id = t.id'
      '           and sub_agr.num = 0'
      '           and sub_st.agreem_id = sub_agr.id'
      '       ) TR_NDS,'
      
        '       (SELECT /*+ INDEX(agr AGREEMTREATY_FK_I) INDEX(st STAGE_A' +
        'DDAGR_FK_I) INDEX(d PK_DOCUMENTS)*/'
      '               count(DISTINCT d.DOC_NO)'
      '          FROM RN.mnagreem agr,'
      '               RN.mnstage st,'
      '               M.DOCUMENTS d'
      '         WHERE agr.treaty_id = t.ID'
      '           AND agr.id = st.agreem_id(+)'
      '           AND st.SPECIAL_WRITTEN = d.DOC_NO(+)'
      '           AND d.doc_stage = '#39'1'#39
      '           AND t.PLAT_DOC_TYPE <> 3025) CREATE_SW,'
      
        '       (SELECT /*+ INDEX(agr AGREEMTREATY_FK_I) INDEX(st STAGE_A' +
        'DDAGR_FK_I) INDEX(d PK_DOCUMENTS)*/'
      '               count(DISTINCT d.DOC_NO)'
      '          FROM RN.mnagreem agr,'
      '               RN.mnstage st,'
      '               M.DOCUMENTS d'
      '         WHERE agr.treaty_id = t.ID'
      '           AND agr.id = st.agreem_id(+)'
      '           AND st.SPECIAL_WRITTEN = d.DOC_NO(+)'
      '           AND d.doc_stage = '#39'2'#39') REWORK_SW,'
      
        '       (SELECT count(*) FROM mntrcurator c WHERE c.treaty_id = t' +
        '.id) curator'
      '  FROM RN.MNTREATY T,'
      '       RN.MNAGREEM AGR,'
      '       S.MIISTFIN I,'
      '       RN.MIPAYMENT P,'
      '       RN.MIANNUL A,'
      '       RN.MICHAPTER C,'
      '       S.FIRM_ACCOUNT FA_CUST,'
      '       S.FIRM F_CUST,'
      '       S.BANK B_CUST,'
      '       S.FIRM_ACCOUNT FA_EXEC,'
      '       S.FIRM F_EXEC,'
      '       S.BANK B_EXEC,'
      '       S.CURRENCY C_CUST,'
      '       S.CURRENCY C_EXEC,'
      '       S.COUNTRY CUST_COUNT,'
      '       S.COUNTRY EXEC_COUNT,'
      #9'S.DOC_TYPE DT,'
      '       RN.MIFIRM_BANK F_B,'
      '       RN.MNSUMMARY SUMMARY,'
      '       P.MIPODR UPDR'
      ' WHERE AGR.TREATY_ID = T.ID'
      '   AND DT.DOC_TYPE_NO(+) = T.PLAT_DOC_TYPE'
      '   AND AGR.NUM = 0'
      '   AND A.KOD(+) = T.ANNUL_KOD'
      '   AND I.KOD = T.ISTFIN_KOD'
      '   AND P.KOD = T.PAYMENT_KOD'
      '   AND C.KOD = T.CHAPTER_KOD'
      '   AND FA_CUST.BANK_ACCNT_ID(+) = T.CUST_ACCOUNT_ID'
      '   AND C_CUST.CURRENCY_NO(+) = FA_CUST.CURRENCY_NO'
      '   AND B_CUST.BANK_ID(+) = FA_CUST.BANK_ID'
      '   AND B_CUST.COUNTRY_NO(+) = FA_CUST.COUNTRY_NO'
      '   AND CUST_COUNT.COUNTRY_NO(+) = FA_CUST.COUNTRY_NO'
      '   AND F_CUST.FIRM_NO(+) = FA_CUST.FIRM_NO'
      '   AND FA_EXEC.BANK_ACCNT_ID(+) = T.EXEC_ACCOUNT_ID'
      '   AND C_EXEC.CURRENCY_NO(+) = FA_EXEC.CURRENCY_NO'
      '   AND B_EXEC.BANK_ID(+) = FA_EXEC.BANK_ID'
      '   AND B_EXEC.COUNTRY_NO(+) = FA_EXEC.COUNTRY_NO'
      '   AND F_EXEC.FIRM_NO(+) = FA_EXEC.FIRM_NO'
      '   AND EXEC_COUNT.COUNTRY_NO(+) = FA_EXEC.COUNTRY_NO'
      '   AND FA_EXEC.FIRM_NO = F_B.FIRM_NO(+)'
      '   AND FA_EXEC.COUNTRY_NO = F_B.COUNTRY_NO(+)'
      '   AND FA_EXEC.BANK_ID = F_B.BANK_ID(+)'
      '   AND SUMMARY.TREATY_ID(+) = T.ID'
      '   AND UPDR.ID(+) = T.MIPODR_ID'
      '   AND :EMPTY_OPEN = 0')
    Optimize = False
    Variables.Data = {
      03000000010000000B0000003A454D5054595F4F50454E030000000400000001
      00000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000044000000020000004944010000000000030000004E554D0100000000
      0008000000444154455349474E010000000000070000005355424A4543540100
      000000000600000044415445544F010000000000080000004441544546524F4D
      0100000000000700000053554D4D5041590100000000000B0000004348415054
      45525F4B4F440100000000000B0000005041594D454E545F4B4F440100000000
      000A00000049535446494E5F4B4F440100000000000F000000435553545F4143
      434F554E545F49440100000000000F000000455845435F4143434F554E545F49
      440100000000000600000053544154555301000000000009000000414E4E554C
      5F4B4F440100000000000B000000414E4E554C5F534E41494D0100000000000D
      000000434841505445525F534E41494D0100000000000D0000005041594D454E
      545F534E41494D01000000000011000000435553545F42414E4B5F4143434F55
      4E5401000000000010000000435553545F43555252454E43595F4E4F01000000
      000012000000435553545F43555252454E43595F4E414D450100000000000C00
      0000435553545F4649524D5F4E4F0100000000000F000000435553545F53484F
      52545F4E414D450100000000000C000000435553545F42414E4B5F4944010000
      0000000E000000435553545F42414E4B5F4E414D450100000000001100000045
      5845435F42414E4B5F4143434F554E5401000000000010000000455845435F43
      555252454E43595F4E4F01000000000012000000455845435F43555252454E43
      595F4E414D450100000000000C000000455845435F4649524D5F4E4F01000000
      00000F000000455845435F53484F52545F4E414D450100000000000C00000045
      5845435F42414E4B5F49440100000000000E000000455845435F42414E4B5F4E
      414D450100000000000C00000049535446494E5F534E41494D01000000000011
      000000435553545F434F554E5452595F4E414D45010000000000110000004558
      45435F434F554E5452595F4E414D450100000000000F000000435553545F434F
      554E5452595F4E4F0100000000000F000000455845435F434F554E5452595F4E
      4F01000000000009000000435553545F4E414D45010000000000090000004558
      45435F4E414D450100000000000B000000435553545F5641545F4E4F01000000
      00000B000000455845435F5641545F4E4F0100000000000E000000435553545F
      434954595F4E414D450100000000000E000000455845435F434954595F4E414D
      450100000000000900000041475245454D5F4944010000000000100000004E41
      4D455F42454E45464943494152590100000000000400000042414E4B01000000
      00000D0000004E494F4B525F4143434F554E540100000000000E000000544845
      4D455F504C414E5F4E554D0100000000001200000046495253545F594541525F
      53554D4D5041590100000000000700000053554D4D4152590100000000000600
      0000444F435F4E4F0100000000000A00000053545F53554D4D50415901000000
      00000B0000004147525F53554D4D5041590100000000000A00000054525F5355
      4D4D504159010000000000030000004E44530100000000000B0000004E44535F
      53554D4D5041590100000000000600000053545F4E4453010000000000070000
      004147525F4E44530100000000000600000054525F4E44530100000000000900
      00004352454154455F5357010000000000090000005245574F524B5F53570100
      000000000700000043555241544F520100000000000D000000504C41545F444F
      435F545950450100000000000700000050445F4E414D45010000000000090000
      004D49504F44525F49440100000000000A0000004D49504F44525F4B4F440100
      000000000C0000004D49504F44525F534E41494D0100000000000C0000004D49
      504F44525F504E41494D0100000000000C0000004D4955524F56454E5F4B4F44
      010000000000}
    Cursor = crSQLWait
    LockingMode = lmNone
    OnApplyRecord = quTreatyApplyRecord
    UpdatingTable = 'RN.MNTREATY'
    CommitOnPost = False
    Session = seOracle
    AfterOpen = quTreatyAfterOpen
    BeforeClose = quTreatyBeforeClose
    AfterClose = quTreatyAfterClose
    AfterInsert = quTreatyAfterInsert
    BeforeEdit = BeforeEditTreaty
    BeforeDelete = BeforeEditTreaty
    ReActive = True
    Caption = #1044#1086#1075#1086#1074#1086#1088
    Order = 'T.NUM ASC'
    EditorClassName = 'TfmDogovor'
    BeforeVisualQuery = quTreatyBeforeVisualQuery
    LinkDetailSQL = True
    LinkKind = lkIn
    UpdTabAlias = 'T'
    TreeNodeIndex = 0
    Left = 320
    Top = 224
    object quTreatyID: TFloatField
      DisplayLabel = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
      DisplayWidth = 10
      FieldKind = fkInternalCalc
      FieldName = 'ID'
      Origin = 'T.ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quTreatyNUM: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      DisplayWidth = 11
      FieldName = 'NUM'
      Origin = 'T.NUM'
    end
    object quTreatyAGREEM_ID: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'AGREEM_ID'
      Origin = 'AGR.ID'
      Visible = False
    end
    object quTreatyDATESIGN: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1044#1072#1090#1072' '#1087#1086#1076#1087#1080#1089#1072#1085'.'
      DisplayWidth = 11
      FieldName = 'DATESIGN'
      Origin = 'T.DATESIGN'
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quTreatyDATEFROM: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090
      DisplayWidth = 11
      FieldName = 'DATEFROM'
      Origin = 'T.DATEFROM'
      Required = True
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quTreatyDATETO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090
      DisplayWidth = 11
      FieldName = 'DATETO'
      Origin = 'T.DATETO'
      Required = True
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quTreatySUMMPAY: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090
      DisplayWidth = 12
      FieldName = 'SUMMPAY'
      Origin = 'T.SUMMPAY'
      Required = True
      OnChange = TrChangeNDS
      DisplayFormat = '#,###,###,###,###,##0.00'
      EditFormat = '###############0.##'
    end
    object quTreatyNDS: TFloatField
      DisplayLabel = #1053#1044#1057' %'
      DisplayWidth = 2
      FieldName = 'NDS'
      Origin = 'T.NDS'
      OnChange = TrChangeNDS
    end
    object quTreatyNDS_SUMMPAY: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1053#1044#1057
      FieldName = 'NDS_SUMMPAY'
      Origin = 'T.NDS_SUMMPAY'
      DisplayFormat = '#,###,###,###,###,##0.00'
      EditFormat = '###############0.##'
    end
    object quTreatyISTFIN_KOD: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1080#1089#1090#1086#1095#1085#1080#1082#1072' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
      DisplayWidth = 2
      FieldName = 'ISTFIN_KOD'
      Origin = 'T.ISTFIN_KOD'
      Visible = False
      OnChange = RefreshCalcFields
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quTreatyISTFIN_SNAIM: TStringField
      DisplayLabel = #1048#1089#1090#1086#1095#1085#1080#1082' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
      DisplayWidth = 20
      FieldKind = fkInternalCalc
      FieldName = 'ISTFIN_SNAIM'
      Origin = 'I.SNAIM'
    end
    object quTreatyPAYMENT_KOD: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1090#1080#1087#1072' '#1086#1087#1083#1072#1090
      DisplayWidth = 2
      FieldName = 'PAYMENT_KOD'
      Origin = 'T.PAYMENT_KOD'
      Required = True
      Visible = False
      OnChange = RefreshCalcFields
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quTreatyPAYMENT_SNAIM: TStringField
      DisplayLabel = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099
      DisplayWidth = 8
      FieldKind = fkInternalCalc
      FieldName = 'PAYMENT_SNAIM'
      Origin = 'P.SNAIM'
    end
    object quTreatyCHAPTER_KOD: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1088#1072#1079#1076#1077#1083#1072
      DisplayWidth = 2
      FieldName = 'CHAPTER_KOD'
      Origin = 'T.CHAPTER_KOD'
      Required = True
      Visible = False
      OnChange = RefreshCalcFields
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quTreatyCHAPTER_SNAIM: TStringField
      DisplayLabel = #1056#1072#1079#1076#1077#1083
      DisplayWidth = 30
      FieldKind = fkInternalCalc
      FieldName = 'CHAPTER_SNAIM'
      Origin = 'C.SNAIM'
      Visible = False
      Size = 30
    end
    object quTreatyANNUL_KOD: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1074#1080#1076#1072' '#1072#1085#1085#1091#1083#1080#1088#1086#1074#1072#1085#1080#1103
      DisplayWidth = 2
      FieldName = 'ANNUL_KOD'
      Origin = 'T.ANNUL_KOD'
      Visible = False
      OnChange = RefreshCalcFields
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quTreatyANNUL_SNAIM: TStringField
      DisplayLabel = #1042#1080#1076' '#1072#1085#1085#1091#1083#1080#1088#1086#1074#1072#1085#1080#1103
      DisplayWidth = 20
      FieldKind = fkInternalCalc
      FieldName = 'ANNUL_SNAIM'
      Origin = 'A.SNAIM'
      Visible = False
    end
    object quTreatySTATUS: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089' '#1076#1086#1075#1086#1074#1086#1088#1072
      FieldName = 'STATUS'
      Origin = 'T.STATUS'
      Visible = False
      Size = 1
    end
    object quTreatyCREATE_SW: TFloatField
      Tag = 2
      DisplayLabel = #1089#1083'. ('#1042#1042#1045#1044#1045#1053')'
      DisplayWidth = 2
      FieldKind = fkInternalCalc
      FieldName = 'CREATE_SW'
      Origin = 
        '(SELECT /*+ INDEX(agr AGREEMTREATY_FK_I) INDEX(st STAGE_ADDAGR_F' +
        'K_I)*/ count(DISTINCT d.DOC_NO) FROM RN.mnagreem agr, RN.mnstage' +
        ' st, M.DOCUMENTS d WHERE agr.treaty_id = t.ID AND agr.id = st.ag' +
        'reem_id AND st.SPECIAL_WRITTEN = d.DOC_NO AND d.doc_stage = '#39'1'#39')'
    end
    object quTreatyREWORK_SW: TFloatField
      Tag = 2
      DisplayLabel = #1089#1083'. ('#1044#1086#1088#1072#1073#1086#1090#1082#1072')'
      DisplayWidth = 2
      FieldKind = fkInternalCalc
      FieldName = 'REWORK_SW'
      Origin = 
        '(SELECT /*+ INDEX(agr AGREEMTREATY_FK_I) INDEX(st STAGE_ADDAGR_F' +
        'K_I)*/ count(DISTINCT d.DOC_NO) FROM RN.mnagreem agr, RN.mnstage' +
        ' st, M.DOCUMENTS d WHERE agr.treaty_id = t.ID AND agr.id = st.ag' +
        'reem_id AND st.SPECIAL_WRITTEN = d.DOC_NO AND d.doc_stage = '#39'2'#39')'
    end
    object quTreatyCUST_ACCOUNT_ID: TFloatField
      DisplayLabel = 'ID '#1089#1095#1077#1090#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 10
      FieldName = 'CUST_ACCOUNT_ID'
      Origin = 'T.CUST_ACCOUNT_ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quTreatyCUST_BANK_ACCOUNT: TStringField
      DisplayLabel = #1057#1095#1077#1090' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 14
      FieldKind = fkInternalCalc
      FieldName = 'CUST_BANK_ACCOUNT'
      Origin = 'FA_CUST.BANK_ACCOUNT'
      Required = True
      Visible = False
      OnChange = RefreshCalcFields
      Size = 25
    end
    object quTreatyCUST_CURRENCY_NO: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1074#1072#1083#1102#1090#1099' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      FieldKind = fkInternalCalc
      FieldName = 'CUST_CURRENCY_NO'
      Origin = 'FA_CUST.CURRENCY_NO'
      Visible = False
      OnChange = RefreshCalcFields
    end
    object quTreatyCUST_CURRENCY_NAME: TStringField
      DisplayLabel = #1053#1072#1080#1084'. '#1074#1072#1083#1102#1090#1099' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 50
      FieldKind = fkInternalCalc
      FieldName = 'CUST_CURRENCY_NAME'
      Origin = 'C_CUST.ISO_NAME'
      Visible = False
      Size = 50
    end
    object quTreatyCUST_FIRM_NO: TFloatField
      DisplayLabel = #1047#1072#1082#1072#1079#1095#1080#1082
      FieldKind = fkInternalCalc
      FieldName = 'CUST_FIRM_NO'
      Origin = 'FA_CUST.FIRM_NO'
      Required = True
      Visible = False
      OnChange = RefreshCalcFields
    end
    object quTreatyCUST_SHORT_NAME: TStringField
      DisplayLabel = #1057#1086#1082#1088'.'#1085#1072#1080#1084'. '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      FieldKind = fkInternalCalc
      FieldName = 'CUST_SHORT_NAME'
      Origin = 'F_CUST.SHORT_NAME'
      Visible = False
    end
    object quTreatyCUST_NAME: TStringField
      DisplayLabel = #1055#1086#1083#1085'.'#1085#1072#1080#1084'. '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 120
      FieldKind = fkInternalCalc
      FieldName = 'CUST_NAME'
      Origin = 'F_CUST.NAME'
      Visible = False
      Size = 120
    end
    object quTreatyCUST_BANK_ID: TStringField
      DisplayLabel = #1050#1086#1076' '#1073#1072#1085#1082#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      FieldKind = fkInternalCalc
      FieldName = 'CUST_BANK_ID'
      Origin = 'FA_CUST.BANK_ID'
      Required = True
      Visible = False
      OnChange = RefreshCalcFields
      Size = 15
    end
    object quTreatyCUST_BANK_NAME: TStringField
      DisplayLabel = #1053#1072#1080#1084'. '#1073#1072#1085#1082#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 60
      FieldKind = fkInternalCalc
      FieldName = 'CUST_BANK_NAME'
      Origin = 'B_CUST.NAME'
      Visible = False
      Size = 60
    end
    object quTreatyCUST_COUNTRY_NO: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1089#1090#1088#1072#1085#1099' '#1073#1072#1085#1082#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      FieldKind = fkInternalCalc
      FieldName = 'CUST_COUNTRY_NO'
      Origin = 'FA_CUST.COUNTRY_NO'
      Required = True
      Visible = False
      OnChange = RefreshCalcFields
    end
    object quTreatyCUST_COUNTRY_NAME: TStringField
      DisplayLabel = #1057#1090#1088#1072#1085#1072' '#1073#1072#1085#1082#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 50
      FieldKind = fkInternalCalc
      FieldName = 'CUST_COUNTRY_NAME'
      Origin = 'CUST_COUNT.NAME'
      Visible = False
      Size = 50
    end
    object quTreatyCUST_VAT_NO: TStringField
      DisplayLabel = #1059#1053#1053' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 25
      FieldName = 'CUST_VAT_NO'
      Visible = False
      Size = 25
    end
    object quTreatyCUST_CITY_NAME: TStringField
      DisplayLabel = #1043#1086#1088#1086#1076' '#1073#1072#1085#1082#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 35
      FieldName = 'CUST_CITY_NAME'
      Visible = False
      Size = 35
    end
    object quTreatyEXEC_ACCOUNT_ID: TFloatField
      DisplayLabel = 'ID '#1089#1095#1077#1090#1072' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 10
      FieldName = 'EXEC_ACCOUNT_ID'
      Origin = 'T.EXEC_ACCOUNT_ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quTreatyEXEC_BANK_ACCOUNT: TStringField
      DisplayLabel = #1057#1095#1077#1090' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 15
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_BANK_ACCOUNT'
      Origin = 'FA_EXEC.BANK_ACCOUNT'
      Required = True
      OnChange = RefreshCalcFields
      Size = 25
    end
    object quTreatyEXEC_CURRENCY_NO: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1074#1072#1083#1102#1090#1099' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 16
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_CURRENCY_NO'
      Origin = 'FA_EXEC.CURRENCY_NO'
      Visible = False
      OnChange = RefreshCalcFields
    end
    object quTreatyEXEC_CURRENCY_NAME: TStringField
      DisplayLabel = #1042#1072#1083#1102#1090#1072' '#1080#1089#1087#1086#1083'.'
      DisplayWidth = 15
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_CURRENCY_NAME'
      Origin = 'C_EXEC.ISO_NAME'
      Visible = False
      Size = 50
    end
    object quTreatyEXEC_FIRM_NO: TFloatField
      DisplayLabel = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
      DisplayWidth = 10
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_FIRM_NO'
      Origin = 'FA_EXEC.FIRM_NO'
      Required = True
      Visible = False
      OnChange = RefreshCalcFields
    end
    object quTreatyEXEC_SHORT_NAME: TStringField
      DisplayLabel = #1057#1086#1082#1088'.'#1085#1072#1080#1084'. '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 20
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_SHORT_NAME'
      Origin = 'F_EXEC.SHORT_NAME'
    end
    object quTreatyEXEC_NAME: TStringField
      DisplayLabel = #1055#1086#1083#1085'.'#1085#1072#1080#1084'. '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 120
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_NAME'
      Origin = 'F_EXEC.NAME'
      Visible = False
      Size = 120
    end
    object quTreatyEXEC_BANK_ID: TStringField
      DisplayLabel = #1050#1086#1076' '#1073#1072#1085#1082#1072' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 15
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_BANK_ID'
      Origin = 'FA_EXEC.BANK_ID'
      Required = True
      Visible = False
      OnChange = RefreshCalcFields
      Size = 15
    end
    object quTreatyEXEC_BANK_NAME: TStringField
      DisplayLabel = #1053#1072#1080#1084'. '#1073#1072#1085#1082#1072' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 43
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_BANK_NAME'
      Origin = 'B_EXEC.NAME'
      Size = 60
    end
    object quTreatyEXEC_COUNTRY_NO: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1089#1090#1088#1072#1085#1099' '#1073#1072#1085#1082#1072' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 20
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_COUNTRY_NO'
      Origin = 'FA_EXEC.COUNTRY_NO'
      Required = True
      Visible = False
      OnChange = RefreshCalcFields
    end
    object quTreatyEXEC_COUNTRY_NAME: TStringField
      DisplayLabel = #1057#1090#1088#1072#1085#1072' '#1073#1072#1085#1082#1072' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 50
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_COUNTRY_NAME'
      Origin = 'EXEC_COUNT.NAME'
      Visible = False
      Size = 50
    end
    object quTreatyEXEC_VAT_NO: TStringField
      DisplayLabel = #1059#1053#1053' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 14
      FieldName = 'EXEC_VAT_NO'
      Size = 25
    end
    object quTreatyEXEC_CITY_NAME: TStringField
      DisplayLabel = #1043#1086#1088#1086#1076' '#1073#1072#1085#1082#1072' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 35
      FieldName = 'EXEC_CITY_NAME'
      Visible = False
      Size = 35
    end
    object quTreatySUBJECT: TStringField
      DisplayLabel = #1058#1077#1084#1072
      DisplayWidth = 100
      FieldName = 'SUBJECT'
      Origin = 'T.SUBJECT'
      Required = True
      Size = 1000
    end
    object quTreatyNAME_BENEFICIARY: TStringField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'NAME_BENEFICIARY'
      Origin = 'F_B.NAME_BENEFICIARY'
      Visible = False
      Size = 1500
    end
    object quTreatyBANK: TStringField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'BANK'
      Origin = 'F_B.BANK'
      Visible = False
      Size = 200
    end
    object quTreatyNIOKR_ACCOUNT: TStringField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'NIOKR_ACCOUNT'
      Origin = 'F_B.NIOKR_ACCOUNT'
      Visible = False
      Size = 300
    end
    object quTreatyTHEME_PLAN_NUM: TIntegerField
      DisplayLabel = #1058#1077#1084#1087#1083#1072#1085
      DisplayWidth = 4
      FieldName = 'THEME_PLAN_NUM'
    end
    object quTreatyFIRST_YEAR_SUMMPAY: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1076#1086#1075#1086#1074#1086#1088#1072' '#1074' '#1087#1077#1088#1074#1099#1081' '#1075#1086#1076
      FieldName = 'FIRST_YEAR_SUMMPAY'
      Visible = False
      DisplayFormat = '#,###,###,###,###,##0.##'
      EditFormat = '###############0.##'
    end
    object quTreatySUMMARY: TStringField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'SUMMARY'
      Visible = False
      Size = 2000
    end
    object quTreatyDOC_NO: TStringField
      Tag = 2
      FieldName = 'DOC_NO'
      Origin = 'T.DOC_NO'
      Visible = False
      Size = 30
    end
    object quTreatyST_SUMMPAY: TFloatField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'ST_SUMMPAY'
      Visible = False
    end
    object quTreatyAGR_SUMMPAY: TFloatField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'AGR_SUMMPAY'
      Visible = False
    end
    object quTreatyTR_SUMMPAY: TFloatField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'TR_SUMMPAY'
      Visible = False
    end
    object quTreatyST_NDS: TFloatField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'ST_NDS'
      Visible = False
    end
    object quTreatyAGR_NDS: TFloatField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'AGR_NDS'
      Visible = False
    end
    object quTreatyTR_NDS: TFloatField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'TR_NDS'
      Visible = False
    end
    object quTreatyCURATOR: TFloatField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'CURATOR'
      Visible = False
    end
    object quTreatyPLAT_DOC_TYPE: TIntegerField
      DisplayLabel = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1086#1087#1083#1072#1090#1099
      DisplayWidth = 5
      FieldName = 'PLAT_DOC_TYPE'
      Origin = 'T.PLAT_DOC_TYPE'
      Required = True
      OnChange = RefreshCalcFields
      DisplayFormat = '000'
    end
    object quTreatyPD_NAME: TStringField
      DisplayLabel = #1055#1083#1072#1090#1105#1078#1085#1099#1081' '#1076#1086#1082' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1091
      FieldKind = fkInternalCalc
      FieldName = 'PD_NAME'
      Origin = 'DT.NAME'
      Size = 100
    end
    object fltfldTreatyMIPODR_ID: TFloatField
      DisplayLabel = #1048#1076' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      FieldName = 'MIPODR_ID'
      Visible = False
    end
    object intgrfldTreatyMIPODR_KOD: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      FieldKind = fkInternalCalc
      FieldName = 'MIPODR_KOD'
    end
    object strngfldTreatyMIPODR_SNAIM: TStringField
      DisplayLabel = #1057#1086#1082#1088'.'#1053#1072#1080#1084'.'#1055#1086#1076#1088'.'
      FieldKind = fkInternalCalc
      FieldName = 'MIPODR_SNAIM'
      Size = 10
    end
    object strngfldTreatyMIPODR_PNAIM: TStringField
      DisplayLabel = #1055#1086#1083#1085'. '#1085#1072#1080#1084#1077#1085'. '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      FieldKind = fkInternalCalc
      FieldName = 'MIPODR_PNAIM'
      Size = 100
    end
    object intgrfldTreatyMIUROVEN_KOD: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'MIUROVEN_KOD'
      Visible = False
    end
  end
  object quAgreem: TVASUPQuery
    SQL.Strings = (
      'SELECT A.*,'
      '       A.ROWID,'
      '       I.SNAIM ISTFIN_SNAIM,'
      '       P.SNAIM PAYMENT_SNAIM,'
      '       (SELECT SUM(sub_st.SUMMPAY)'
      '          FROM RN.MNAGREEM sub_agr, '
      '               RN.MNSTAGE sub_st'
      '         WHERE sub_agr.treaty_id = a.treaty_id '
      '           and sub_st.agreem_id = sub_agr.id '
      '           and (   (    sub_st.dateact IS NOT NULL'
      '                    AND sub_agr.num < a.num'
      '                   )'
      '                OR (sub_agr.num = a.num'
      '                   )'
      '               )'
      '       ) ST_SUMMPAY,'
      '       (SELECT SUM(sub_st.NDS_SUMMPAY)'
      '          FROM RN.MNAGREEM sub_agr,'
      '               RN.MNSTAGE sub_st'
      '         WHERE sub_agr.treaty_id = a.treaty_id'
      '           and sub_st.agreem_id = sub_agr.id'
      '           and (   (    sub_st.dateact IS NOT NULL'
      '                    AND sub_agr.num < a.num'
      '                   )'
      '                OR (sub_agr.num = a.num'
      '                   )'
      '               )'
      '           and nvl(A.NDS, 0) <> 0'
      '       ) ST_NDS'
      '  FROM RN.MNAGREEM A,'
      '       S.MIISTFIN I,'
      '       RN.MIPAYMENT P'
      ' WHERE I.KOD(+) = A.ISTFIN_KOD'
      '   AND P.KOD(+) = A.PAYMENT_KOD'
      '   AND A.NUM>0'
      '  AND TREATY_ID = :TREATY_ID')
    Optimize = False
    Variables.Data = {
      03000000010000000A0000003A5452454154595F494403000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      0400000010000000020000004944010000000000030000004E554D0100000000
      0008000000444154455349474E0100000000000A00000049535446494E5F4B4F
      44010000000000090000005452454154595F4944010000000000070000005355
      424A4543540100000000000600000044415445544F0100000000000700000053
      554D4D5041590100000000000B0000005041594D454E545F4B4F440100000000
      000C00000049535446494E5F534E41494D0100000000000D0000005041594D45
      4E545F534E41494D01000000000006000000444F435F4E4F0100000000000A00
      000053545F53554D4D504159010000000000030000004E44530100000000000B
      0000004E44535F53554D4D5041590100000000000600000053545F4E44530100
      00000000}
    Cursor = crSQLWait
    Master = quTreaty
    MasterFields = 'ID'
    DetailFields = 'TREATY_ID'
    LockingMode = lmNone
    OnApplyRecord = quAgreemApplyRecord
    UpdatingTable = 'RN.MNAGREEM'
    CommitOnPost = False
    Session = seOracle
    BeforeInsert = BeforeEditTreaty
    BeforeEdit = BeforeEditTreaty
    BeforeDelete = BeforeEditTreaty
    ReActive = True
    Caption = #1044#1086#1087'.'#1089#1086#1075#1083'.'
    Order = 'A.NUM ASC'
    LinkDetailSQL = True
    LinkKind = lkIn
    EmbeddedSQLSlice.Strings = (
      '  FROM RN.MNAGREEM A,'
      '       S.MIISTFIN I,'
      '       RN.MIPAYMENT P'
      ' WHERE I.KOD(+) = A.ISTFIN_KOD'
      '   AND P.KOD(+) = A.PAYMENT_KOD'
      ' ')
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 424
    Top = 264
    object quAgreemID: TFloatField
      DisplayLabel = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'A.ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quAgreemTREATY_ID: TFloatField
      DisplayLabel = 'ID '#1076#1086#1075#1086#1074#1086#1088#1072
      DisplayWidth = 10
      FieldName = 'TREATY_ID'
      Origin = 'A.TREATY_ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quAgreemNUM: TIntegerField
      DisplayLabel = #1053#1086#1084#1077#1088
      DisplayWidth = 4
      FieldName = 'NUM'
      Origin = 'A.NUM'
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quAgreemDATESIGN: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1086#1076#1087#1080#1089#1072#1085'.'
      DisplayWidth = 11
      FieldName = 'DATESIGN'
      Origin = 'A.DATESIGN'
      Required = True
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quAgreemDATETO: TDateTimeField
      DisplayLabel = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090
      DisplayWidth = 11
      FieldName = 'DATETO'
      Origin = 'A.DATETO'
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quAgreemSUMMPAY: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090
      DisplayWidth = 14
      FieldName = 'SUMMPAY'
      Origin = 'A.SUMMPAY'
      OnChange = AgrChangeNDS
      DisplayFormat = '#,###,###,###,###,##0.00'
      EditFormat = '###############0.##'
    end
    object quAgreemNDS: TFloatField
      DisplayLabel = #1053#1044#1057' %'
      DisplayWidth = 2
      FieldName = 'NDS'
      Origin = 'A.NDS'
      OnChange = AgrChangeNDS
    end
    object quAgreemNDS_SUMMPAY: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1053#1044#1057
      FieldName = 'NDS_SUMMPAY'
      Origin = 'A.NDS_SUMMPAY'
      DisplayFormat = '#,###,###,###,###,##0.00'
      EditFormat = '###############0.##'
    end
    object quAgreemISTFIN_KOD: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1080#1089#1090#1086#1095#1085#1080#1082#1072' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
      DisplayWidth = 2
      FieldName = 'ISTFIN_KOD'
      Origin = 'A.ISTFIN_KOD'
      Visible = False
      OnChange = RefreshCalcFields
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quAgreemISTFIN_SNAIM: TStringField
      DisplayLabel = #1053#1072#1080#1084'. '#1080#1089#1090'. '#1092#1080#1085#1072#1085#1089#1080#1088'-'#1085#1080#1103
      DisplayWidth = 20
      FieldKind = fkInternalCalc
      FieldName = 'ISTFIN_SNAIM'
    end
    object quAgreemPAYMENT_KOD: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1090#1080#1087#1072' '#1086#1087#1083#1072#1090
      DisplayWidth = 2
      FieldName = 'PAYMENT_KOD'
      Origin = 'A.PAYMENT_KOD'
      Visible = False
      OnChange = RefreshCalcFields
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quAgreemPAYMENT_SNAIM: TStringField
      DisplayLabel = #1053#1072#1080#1084'. '#1090#1080#1087#1072' '#1086#1087#1083#1072#1090
      DisplayWidth = 12
      FieldKind = fkInternalCalc
      FieldName = 'PAYMENT_SNAIM'
    end
    object quAgreemSUBJECT: TStringField
      DisplayLabel = #1058#1077#1084#1072
      DisplayWidth = 100
      FieldName = 'SUBJECT'
      Origin = 'A.SUBJECT'
      Size = 1000
    end
    object quAgreemDOC_NO: TStringField
      Tag = 2
      FieldName = 'DOC_NO'
      Origin = 'A.DOC_NO'
      Visible = False
      Size = 30
    end
    object quAgreemST_SUMMPAY: TFloatField
      FieldName = 'ST_SUMMPAY'
    end
    object quAgreemST_NDS: TFloatField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'ST_NDS'
      Visible = False
    end
  end
  object quAgreemStage: TVASUPQuery
    SQL.Strings = (
      'SELECT S.ROWID,    '
      '       S.ID ID,'
      '       S.AGREEM_ID AGREEM_ID,'
      '       S.DATEFROM DATEFROM,'
      '       S.DATETO DATETO,'
      '       S.NUM NUM,'
      '       S.NAME NAME,'
      '       S.REPORTING REPORTING,'
      '       S.SUMMPAY ,'
      '       S.DATEACT DATEACT,'
      '       S.CUST_ACCOUNT_ID CUST_ACCOUNT_ID,'
      '       S.EXEC_ACCOUNT_ID EXEC_ACCOUNT_ID,'
      '       S.NUMACT NUMACT,'
      '       S.SPECIAL_WRITTEN SPECIAL_WRITTEN,'
      '       S.NDS NDS,'
      '       S.NDS_SUMMPAY NDS_SUMMPAY,'
      '       S.AKT_NO AKT_NO,'
      '       S.CREATE_AKT CREATE_AKT,'
      
        '       NVL(S.DATEPAY, DECODE(:typ, 3025, m.vns_pack.getpdmaxpdat' +
        'e(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id), d.doc_date' +
        '))) DATEPAY, -- '#1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1082#1080
      
        '--     NVL(S.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(decode(:typ,3' +
        '025,l2.doc_id,l.doc_id)), decode(:typ,3025,sw.doc_date,d.doc_dat' +
        'e))) DATEPAY, -- '#1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1082#1080
      
        '       NVL(S.NUMPAY, decode(:typ,3025,sw.doc_ext_no,d.doc_ext_no' +
        ')) NUMPAY,'
      
        '       NVL(S.PM_PMETHOD_NO, DECODE(decode(:typ,3025,sw.DOC_NO,d.' +
        'DOC_NO), NULL, NULL, DECODE(decode(:typ,3025,SW.DOC_TYPE,D.DOC_T' +
        'YPE), 3025, 1, 2))) PM_PMETHOD_NO,'
      
        '       (SELECT PM.PMETHOD_NAME FROM S.PAYMENT_METHODS PM where P' +
        'M.PMETHOD_NO = NVL(S.PM_PMETHOD_NO, DECODE(decode(:typ,3025,sw.D' +
        'OC_NO,d.DOC_NO), NULL, NULL, DECODE(decode(:typ,3025,SW.DOC_TYPE' +
        ',D.DOC_TYPE), 3025, 1, 2)))) PMETHOD_NAME,'
      '       '
      '       /* '#1047#1072#1082#1072#1079#1095#1080#1082' */'
      '       FA_CUST.BANK_ACCOUNT CUST_BANK_ACCOUNT,'
      '       F_CUST.NAME CUST_NAME,'
      '       /* '#1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100' */'
      '       FA_EXEC.BANK_ACCOUNT EXEC_BANK_ACCOUNT,'
      '       F_EXEC.NAME EXEC_NAME,'
      '       SW.DOC_STAGE SW_STAGE'
      '  FROM RN.MNSTAGE S,'
      '       S.FIRM_ACCOUNT FA_CUST,'
      '       S.FIRM F_CUST,'
      '       S.FIRM_ACCOUNT FA_EXEC,'
      '       S.FIRM F_EXEC,'
      '       M.DOCUMENTS SW,'
      '       M.vns_pd_div_lines l'
      '       ,M.vns_pd_div_lines l2'
      '       ,M.documents d'
      ' WHERE FA_CUST.BANK_ACCNT_ID(+) = S.CUST_ACCOUNT_ID'
      '   AND F_CUST.FIRM_NO(+) = FA_CUST.FIRM_NO'
      '   AND FA_EXEC.BANK_ACCNT_ID(+) = S.EXEC_ACCOUNT_ID'
      '   AND F_EXEC.FIRM_NO(+) = FA_EXEC.FIRM_NO'
      '   AND SW.DOC_NO(+) = S.SPECIAL_WRITTEN'
      '   '
      '   AND SW.DOC_NO = l.sw_id(+)'
      '   and l.doc_id = d.doc_no(+)'
      '   AND SW.DOC_NO = l2.doc_id(+)'
      '   AND SW.DOC_TYPE(+) not in (3005,3009)'
      '   AND d.doc_type(+) not in (3005, 3009)'
      '  AND AGREEM_ID = :AGREEM_ID')
    Optimize = False
    Variables.Data = {
      0300000002000000040000003A5459500300000004000000FE01000000000000
      0A0000003A41475245454D5F4944030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000001A0000000200000049440100000000000900000041475245454D5F49
      44010000000000080000004441544546524F4D01000000000006000000444154
      45544F010000000000030000004E554D010000000000040000004E414D450100
      00000000090000005245504F5254494E470100000000000700000053554D4D50
      41590100000000000700000044415445504159010000000000060000004E554D
      50415901000000000007000000444154454143540100000000000D000000504D
      5F504D4554484F445F4E4F0100000000000F000000435553545F4143434F554E
      545F49440100000000000F000000455845435F4143434F554E545F4944010000
      0000000C000000504D4554484F445F4E414D4501000000000011000000435553
      545F42414E4B5F4143434F554E5401000000000009000000435553545F4E414D
      4501000000000011000000455845435F42414E4B5F4143434F554E5401000000
      000009000000455845435F4E414D45010000000000060000004E554D41435401
      00000000000F0000005350454349414C5F5752495454454E0100000000000300
      00004E44530100000000000B0000004E44535F53554D4D504159010000000000
      06000000414B545F4E4F0100000000000A0000004352454154455F414B540100
      000000000800000053575F5354414745010000000000}
    Cursor = crSQLWait
    Master = quAgreem
    MasterFields = 'ID'
    DetailFields = 'AGREEM_ID'
    LockingMode = lmNone
    UpdatingTable = 'RN.MNSTAGE'
    CommitOnPost = False
    Session = seOracle
    BeforeInsert = BeforeEditTreaty
    BeforeEdit = BeforeEditTreaty
    BeforeDelete = BeforeEditTreaty
    ReActive = True
    Caption = #1069#1090#1072#1087
    Order = 'S.NUM ASC'
    LinkDetailSQL = True
    LinkKind = lkIn
    EmbeddedSQLSlice.Strings = (
      '  FROM RN.MNSTAGE S,'
      '       S.PAYMENT_METHODS PM,'
      '       S.FIRM_ACCOUNT FA_CUST,'
      '       S.FIRM F_CUST,'
      '       S.FIRM_ACCOUNT FA_EXEC,'
      '       S.FIRM F_EXEC,'
      '       M.DOCUMENTS SW,'
      '       M.vns_pd_div_lines l,'
      '       M.documents d'
      ' WHERE PM.PMETHOD_NO(+) = S.PM_PMETHOD_NO'
      '   AND FA_CUST.BANK_ACCNT_ID(+) = S.CUST_ACCOUNT_ID'
      '   AND F_CUST.FIRM_NO(+) = FA_CUST.FIRM_NO'
      '   AND FA_EXEC.BANK_ACCNT_ID(+) = S.EXEC_ACCOUNT_ID'
      '   AND F_EXEC.FIRM_NO(+) = FA_EXEC.FIRM_NO'
      '   AND SW.DOC_NO(+) = S.SPECIAL_WRITTEN'
      '   AND l.sw_id(+) = SW.DOC_NO'
      '   and l.doc_id = d.doc_no(+)'
      ''
      ' '
      ' ')
    UpdTabAlias = 'S'
    TreeNodeIndex = 0
    Left = 432
    Top = 320
    object quAgreemStageID: TFloatField
      DisplayLabel = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'S.ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quAgreemStageAGREEM_ID: TFloatField
      DisplayLabel = 'ID '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1103
      DisplayWidth = 10
      FieldName = 'AGREEM_ID'
      Origin = 'S.AGREEM_ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quAgreemStageNUM: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1101#1090#1072#1087#1072
      DisplayWidth = 13
      FieldName = 'NUM'
      Origin = 'S.NUM'
      Required = True
      Size = 13
    end
    object quAgreemStageDATEFROM: TDateTimeField
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      DisplayWidth = 7
      FieldName = 'DATEFROM'
      Origin = 'S.DATEFROM'
      Required = True
      OnChange = MonthBeginFormat
      DisplayFormat = 'mm.yyyy'
      EditMask = '!\0\1/99/00;1;_'
    end
    object quAgreemStageDATETO: TDateTimeField
      DisplayLabel = #1054#1082#1086#1085#1095#1072#1085#1080#1077
      DisplayWidth = 7
      FieldName = 'DATETO'
      Origin = 'S.DATETO'
      Required = True
      OnChange = MonthBeginFormat
      DisplayFormat = 'mm.yyyy'
      EditMask = '!\0\1/99/00;1;_'
    end
    object quAgreemStageSUMMPAY: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1101#1090#1072#1087#1072
      DisplayWidth = 13
      FieldName = 'SUMMPAY'
      Origin = 'S.SUMMPAY'
      OnChange = StChangeNDS
      DisplayFormat = '#,###,###,###,###,##0.00'
      EditFormat = '###############0.##'
    end
    object quAgreemStageNDS: TFloatField
      DisplayLabel = #1053#1044#1057' %'
      DisplayWidth = 2
      FieldName = 'NDS'
      Origin = 'S.NDS'
      OnChange = StChangeNDS
    end
    object quAgreemStageNDS_SUMMPAY: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1053#1044#1057
      FieldName = 'NDS_SUMMPAY'
      Origin = 'S.NDS_SUMMPAY'
      DisplayFormat = '#,###,###,###,###,##0.00'
      EditFormat = '###############0.##'
    end
    object quAgreemStageDATEACT: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1072#1082#1090#1072' '#1074#1099#1087'-'#1103
      DisplayWidth = 11
      FieldName = 'DATEACT'
      Origin = 'S.DATEACT'
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quAgreemStageNUMACT: TIntegerField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1072#1082#1090#1072' '#1089#1076#1072#1095#1080
      DisplayWidth = 3
      FieldName = 'NUMACT'
    end
    object quAgreemStageDATEPAY: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
      DisplayWidth = 10
      FieldName = 'DATEPAY'
      Origin = 'NVL(S.DATEPAY, m.vns_pack.getpdmaxpdate(l.doc_id))'
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object quAgreemStageNUMPAY: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1087#1083#1072#1090#1077#1078#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      DisplayWidth = 20
      FieldName = 'NUMPAY'
      Origin = 'NVL(S.NUMPAY, d.doc_ext_no)'
      Size = 100
    end
    object quAgreemStagePM_PMETHOD_NO: TFloatField
      DisplayLabel = #1050#1086#1076' '#1086#1087#1083#1072#1090#1099
      DisplayWidth = 3
      FieldName = 'PM_PMETHOD_NO'
      Origin = 'NVL(S.PM_PMETHOD_NO, DECODE(d.DOC_NO, NULL, NULL, 2))'
      Visible = False
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object quAgreemStagePMETHOD_NAME: TStringField
      DisplayLabel = #1052#1077#1090#1086#1076' '#1086#1087#1083#1072#1090#1099
      DisplayWidth = 19
      FieldKind = fkInternalCalc
      FieldName = 'PMETHOD_NAME'
      Origin = 
        '(SELECT PM.PMETHOD_NAME FROM S.PAYMENT_METHODS PM where PM.PMETH' +
        'OD_NO = NVL(S.PM_PMETHOD_NO, DECODE(d.DOC_NO, NULL, NULL, 2)))'
      Size = 100
    end
    object quAgreemStageCUST_ACCOUNT_ID: TFloatField
      DisplayLabel = 'ID '#1089#1095#1077#1090#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 10
      FieldName = 'CUST_ACCOUNT_ID'
      Origin = 'S.CUST_ACCOUNT_ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quAgreemStageCUST_BANK_ACCOUNT: TStringField
      DisplayLabel = #1057#1095#1077#1090' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 25
      FieldKind = fkInternalCalc
      FieldName = 'CUST_BANK_ACCOUNT'
      Origin = 'FA_CUST.BANK_ACCOUNT'
      Visible = False
      OnChange = RefreshCalcFields
      Size = 25
    end
    object quAgreemStageCUST_NAME: TStringField
      DisplayLabel = #1055#1086#1083#1085'.'#1085#1072#1080#1084'. '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 120
      FieldKind = fkInternalCalc
      FieldName = 'CUST_NAME'
      Origin = 'F_CUST.NAME'
      Visible = False
      Size = 120
    end
    object quAgreemStageEXEC_ACCOUNT_ID: TFloatField
      DisplayLabel = 'ID '#1089#1095#1077#1090#1072' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 10
      FieldName = 'EXEC_ACCOUNT_ID'
      Origin = 'S.EXEC_ACCOUNT_ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quAgreemStageEXEC_BANK_ACCOUNT: TStringField
      DisplayLabel = #1057#1095#1077#1090' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 16
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_BANK_ACCOUNT'
      Origin = 'FA_EXEC.BANK_ACCOUNT'
      OnChange = RefreshCalcFields
      Size = 25
    end
    object quAgreemStageEXEC_NAME: TStringField
      DisplayLabel = #1055#1086#1083#1085'.'#1085#1072#1080#1084'. '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 70
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_NAME'
      Origin = 'F_EXEC.NAME'
      Visible = False
      Size = 120
    end
    object quAgreemStageNAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1101#1090#1072#1087#1072
      DisplayWidth = 100
      FieldName = 'NAME'
      Origin = 'S.NAME'
      Size = 2000
    end
    object quAgreemStageREPORTING: TStringField
      DisplayLabel = #1054#1090#1095#1077#1090#1085#1086#1089#1090#1100' '#1087#1086' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084' '#1088#1072#1073#1086#1090#1099
      DisplayWidth = 100
      FieldName = 'REPORTING'
      Origin = 'S.REPORTING'
      Size = 1000
    end
    object quAgreemStageSPECIAL_WRITTEN: TStringField
      Tag = 2
      FieldName = 'SPECIAL_WRITTEN'
      Origin = 'S.SPECIAL_WRITTEN'
      Visible = False
      Size = 30
    end
    object quAgreemStageAKT_NO: TStringField
      Tag = 2
      FieldName = 'AKT_NO'
      Origin = 'S.AKT_NO'
      Visible = False
      Size = 30
    end
    object quAgreemStageCREATE_AKT: TDateTimeField
      Tag = 2
      FieldName = 'CREATE_AKT'
      Visible = False
    end
    object quAgreemStageSW_STAGE: TStringField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'SW_STAGE'
      Visible = False
      Size = 2
    end
  end
  object quTreatyStage: TVASUPQuery
    SQL.Strings = (
      'SELECT S.ROWID,       '
      '       S.ID ID,'
      '       S.AGREEM_ID AGREEM_ID,'
      '       S.DATEFROM DATEFROM,'
      '       S.DATETO DATETO,'
      '       S.NUM NUM,'
      '       S.NAME NAME,'
      '       S.REPORTING REPORTING,'
      '       S.SUMMPAY ,'
      '       S.DATEACT DATEACT,'
      '       S.CUST_ACCOUNT_ID CUST_ACCOUNT_ID,'
      '       S.EXEC_ACCOUNT_ID EXEC_ACCOUNT_ID,'
      '       S.NUMACT NUMACT,'
      '       S.SPECIAL_WRITTEN SPECIAL_WRITTEN,'
      '       S.NDS NDS,'
      '       S.NDS_SUMMPAY NDS_SUMMPAY,'
      '       S.AKT_NO AKT_NO,'
      '       S.CREATE_AKT CREATE_AKT,'
      
        '       NVL(S.DATEPAY, DECODE(:typ, 3025, m.vns_pack.getpdmaxpdat' +
        'e(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id), d.doc_date' +
        '))) DATEPAY, -- '#1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1082#1080
      
        '--       NVL(S.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(decode(:typ' +
        ',3025,l2.doc_id,l.doc_id)), decode(:typ,3025,sw.doc_date,d.doc_d' +
        'ate))) DATEPAY, -- '#1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1082#1080
      
        '       NVL(S.NUMPAY, decode(:typ,3025,sw.doc_ext_no,d.doc_ext_no' +
        ')) NUMPAY,'
      
        '       NVL(S.PM_PMETHOD_NO, DECODE(decode(:typ,3025,sw.DOC_NO,d.' +
        'DOC_NO), NULL, NULL, DECODE(decode(:typ,3025,SW.DOC_TYPE,D.DOC_T' +
        'YPE), 3025, 1, 2))) PM_PMETHOD_NO,'
      
        '       (SELECT PM.PMETHOD_NAME FROM S.PAYMENT_METHODS PM where P' +
        'M.PMETHOD_NO = NVL(S.PM_PMETHOD_NO, DECODE(decode(:typ,3025,sw.D' +
        'OC_NO,d.DOC_NO), NULL, NULL, DECODE(decode(:typ,3025,SW.DOC_TYPE' +
        ',D.DOC_TYPE), 3025, 1, 2)))) PMETHOD_NAME,'
      '       '
      '       /* '#1047#1072#1082#1072#1079#1095#1080#1082' */'
      '       FA_CUST.BANK_ACCOUNT CUST_BANK_ACCOUNT,'
      '       F_CUST.NAME CUST_NAME,'
      '       /* '#1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100' */'
      '       FA_EXEC.BANK_ACCOUNT EXEC_BANK_ACCOUNT,'
      '       F_EXEC.NAME EXEC_NAME,'
      '       SW.DOC_STAGE SW_STAGE'
      '  FROM RN.MNSTAGE S,'
      '       S.FIRM_ACCOUNT FA_CUST,'
      '       S.FIRM F_CUST,'
      '       S.FIRM_ACCOUNT FA_EXEC,'
      '       S.FIRM F_EXEC,'
      '       M.DOCUMENTS SW,'
      '       M.vns_pd_div_lines l'
      '       ,M.vns_pd_div_lines l2'
      '       ,M.documents d'
      ' WHERE FA_CUST.BANK_ACCNT_ID(+) = S.CUST_ACCOUNT_ID'
      '   AND F_CUST.FIRM_NO(+) = FA_CUST.FIRM_NO'
      '   AND FA_EXEC.BANK_ACCNT_ID(+) = S.EXEC_ACCOUNT_ID'
      '   AND F_EXEC.FIRM_NO(+) = FA_EXEC.FIRM_NO'
      '   AND SW.DOC_NO(+) = S.SPECIAL_WRITTEN'
      '   '
      '   AND SW.DOC_NO = l.sw_id(+)'
      '   and l.doc_id = d.doc_no(+)'
      '   AND SW.DOC_NO = l2.doc_id(+)'
      '   AND SW.DOC_TYPE(+) not in (3005,3009)'
      '   AND d.doc_type(+) not in (3005, 3009)'
      '  AND AGREEM_ID = :AGREEM_ID'
      '')
    Optimize = False
    Variables.Data = {
      0300000002000000040000003A5459500300000004000000FE01000000000000
      0A0000003A41475245454D5F4944030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000001A0000000200000049440100000000000900000041475245454D5F49
      44010000000000080000004441544546524F4D01000000000006000000444154
      45544F010000000000030000004E554D010000000000040000004E414D450100
      00000000090000005245504F5254494E470100000000000700000053554D4D50
      41590100000000000700000044415445504159010000000000060000004E554D
      50415901000000000007000000444154454143540100000000000F0000004355
      53545F4143434F554E545F49440100000000000F000000455845435F4143434F
      554E545F49440100000000000C000000504D4554484F445F4E414D4501000000
      000011000000435553545F42414E4B5F4143434F554E54010000000000090000
      00435553545F4E414D4501000000000011000000455845435F42414E4B5F4143
      434F554E5401000000000009000000455845435F4E414D450100000000000600
      00004E554D4143540100000000000F0000005350454349414C5F575249545445
      4E010000000000030000004E44530100000000000B0000004E44535F53554D4D
      50415901000000000006000000414B545F4E4F0100000000000A000000435245
      4154455F414B540100000000000800000053575F53544147450100000000000D
      000000504D5F504D4554484F445F4E4F010000000000}
    Cursor = crSQLWait
    Master = quTreaty
    MasterFields = 'AGREEM_ID'
    DetailFields = 'AGREEM_ID'
    LockingMode = lmNone
    UpdatingTable = 'RN.MNSTAGE'
    CommitOnPost = False
    Session = seOracle
    BeforeInsert = BeforeEditTreaty
    BeforeEdit = BeforeEditTreaty
    BeforeDelete = BeforeEditTreaty
    ReActive = True
    Caption = #1069#1090#1072#1087
    Order = 'S.NUM ASC'
    LinkDetailSQL = True
    LinkKind = lkIn
    EmbeddedSQLSlice.Strings = (
      '  FROM RN.MNSTAGE S,'
      '       S.PAYMENT_METHODS PM,'
      '       S.FIRM_ACCOUNT FA_CUST,'
      '       S.FIRM F_CUST,'
      '       S.FIRM_ACCOUNT FA_EXEC,'
      '       S.FIRM F_EXEC,'
      '       M.DOCUMENTS SW,'
      '       M.vns_pd_div_lines l,'
      '       M.documents d'
      ' WHERE FA_CUST.BANK_ACCNT_ID(+) = S.CUST_ACCOUNT_ID'
      '   AND F_CUST.FIRM_NO(+) = FA_CUST.FIRM_NO'
      '   AND FA_EXEC.BANK_ACCNT_ID(+) = S.EXEC_ACCOUNT_ID'
      '   AND F_EXEC.FIRM_NO(+) = FA_EXEC.FIRM_NO'
      '   AND SW.DOC_NO(+) = S.SPECIAL_WRITTEN'
      '   AND l.sw_id(+) = SW.DOC_NO'
      '   and l.doc_id = d.doc_no(+)'
      ' ')
    UpdTabAlias = 'S'
    TreeNodeIndex = 0
    Left = 380
    Top = 304
    object quTreatyStageID: TFloatField
      DisplayLabel = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'S.ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quTreatyStageAGREEM_ID: TFloatField
      DisplayLabel = 'ID '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1103
      DisplayWidth = 10
      FieldName = 'AGREEM_ID'
      Origin = 'S.AGREEM_ID'
      Required = True
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quTreatyStageNUM: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1101#1090#1072#1087#1072
      DisplayWidth = 13
      FieldName = 'NUM'
      Origin = 'S.NUM'
      Required = True
      Size = 13
    end
    object quTreatyStageDATEFROM: TDateTimeField
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      DisplayWidth = 7
      FieldName = 'DATEFROM'
      Origin = 'S.DATEFROM'
      Required = True
      OnChange = MonthBeginFormat
      DisplayFormat = 'mm.yyyy'
      EditMask = '!\0\1/99/00;1;_'
    end
    object quTreatyStageDATETO: TDateTimeField
      DisplayLabel = #1054#1082#1086#1085#1095#1072#1085#1080#1077
      DisplayWidth = 7
      FieldName = 'DATETO'
      Origin = 'S.DATETO'
      Required = True
      OnChange = MonthBeginFormat
      DisplayFormat = 'mm.yyyy'
      EditMask = '!\0\1/99/00;1;_'
    end
    object quTreatyStageSUMMPAY: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1101#1090#1072#1087#1072
      DisplayWidth = 13
      FieldName = 'SUMMPAY'
      Origin = 'S.SUMMPAY'
      OnChange = StChangeNDS
      DisplayFormat = '#,###,###,###,###,##0.00'
      EditFormat = '###############0.##'
    end
    object quTreatyStageNDS: TFloatField
      DisplayLabel = #1053#1044#1057' %'
      DisplayWidth = 2
      FieldName = 'NDS'
      Origin = 'S.NDS'
      OnChange = StChangeNDS
    end
    object quTreatyStageNDS_SUMMPAY: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1053#1044#1057
      FieldName = 'NDS_SUMMPAY'
      Origin = 'S.NDS_SUMMPAY'
      DisplayFormat = '#,###,###,###,###,##0.00'
      EditFormat = '###############0.##'
    end
    object quTreatyStageDATEACT: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1072#1082#1090#1072' '#1074#1099#1087'-'#1103
      DisplayWidth = 11
      FieldName = 'DATEACT'
      Origin = 'S.DATEACT'
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quTreatyStageNUMACT: TIntegerField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1072#1082#1090#1072' '#1089#1076#1072#1095#1080
      DisplayWidth = 12
      FieldName = 'NUMACT'
    end
    object quTreatyStageDATEPAY: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
      DisplayWidth = 10
      FieldName = 'DATEPAY'
      Origin = 'NVL(S.DATEPAY, m.vns_pack.getpdmaxpdate(l.doc_id))'
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object quTreatyStageNUMPAY: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1087#1083#1072#1090#1077#1078#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      DisplayWidth = 20
      FieldName = 'NUMPAY'
      Origin = 'NVL(S.NUMPAY, d.doc_ext_no)'
      Size = 100
    end
    object quTreatyStagePM_PMETHOD_NO: TFloatField
      DisplayLabel = #1050#1086#1076' '#1086#1087#1083#1072#1090#1099
      DisplayWidth = 3
      FieldName = 'PM_PMETHOD_NO'
      Origin = 'NVL(S.PM_PMETHOD_NO, DECODE(d.DOC_NO, NULL, NULL, 2))'
      Visible = False
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object quTreatyStagePMETHOD_NAME: TStringField
      DisplayLabel = #1052#1077#1090#1086#1076' '#1086#1087#1083#1072#1090#1099
      DisplayWidth = 19
      FieldKind = fkInternalCalc
      FieldName = 'PMETHOD_NAME'
      Origin = 
        '(SELECT PM.PMETHOD_NAME FROM S.PAYMENT_METHODS PM where PM.PMETH' +
        'OD_NO = NVL(S.PM_PMETHOD_NO, DECODE(d.DOC_NO, NULL, NULL, 2)))'
      Size = 100
    end
    object quTreatyStageCUST_ACCOUNT_ID: TFloatField
      DisplayLabel = 'ID '#1089#1095#1077#1090#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      DisplayWidth = 10
      FieldName = 'CUST_ACCOUNT_ID'
      Origin = 'S.CUST_ACCOUNT_ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quTreatyStageCUST_BANK_ACCOUNT: TStringField
      DisplayLabel = #1057#1095#1077#1090' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      FieldKind = fkInternalCalc
      FieldName = 'CUST_BANK_ACCOUNT'
      Origin = 'FA_CUST.BANK_ACCOUNT'
      Visible = False
      OnChange = RefreshCalcFields
      Size = 25
    end
    object quTreatyStageCUST_NAME: TStringField
      DisplayLabel = #1055#1086#1083#1085'.'#1085#1072#1080#1084'. '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      FieldKind = fkInternalCalc
      FieldName = 'CUST_NAME'
      Origin = 'F_CUST.NAME'
      Visible = False
      Size = 120
    end
    object quTreatyStageEXEC_ACCOUNT_ID: TFloatField
      DisplayLabel = 'ID '#1089#1095#1077#1090#1072' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 10
      FieldName = 'EXEC_ACCOUNT_ID'
      Origin = 'S.EXEC_ACCOUNT_ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object quTreatyStageEXEC_BANK_ACCOUNT: TStringField
      DisplayLabel = #1057#1095#1077#1090' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 16
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_BANK_ACCOUNT'
      Origin = 'FA_EXEC.BANK_ACCOUNT'
      OnChange = RefreshCalcFields
      Size = 25
    end
    object quTreatyStageEXEC_NAME: TStringField
      DisplayLabel = #1055#1086#1083#1085'.'#1085#1072#1080#1084'. '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 70
      FieldKind = fkInternalCalc
      FieldName = 'EXEC_NAME'
      Origin = 'F_EXEC.NAME'
      Size = 120
    end
    object quTreatyStageNAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1101#1090#1072#1087#1072
      DisplayWidth = 100
      FieldName = 'NAME'
      Origin = 'S.NAME'
      Size = 2000
    end
    object quTreatyStageREPORTING: TStringField
      DisplayLabel = #1054#1090#1095#1077#1090#1085#1086#1089#1090#1100' '#1087#1086' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084' '#1088#1072#1073#1086#1090#1099
      DisplayWidth = 100
      FieldName = 'REPORTING'
      Origin = 'S.REPORTING'
      Size = 1000
    end
    object quTreatyStageSPECIAL_WRITTEN: TStringField
      Tag = 2
      FieldName = 'SPECIAL_WRITTEN'
      Origin = 'S.SPECIAL_WRITTEN'
      Visible = False
      Size = 30
    end
    object quTreatyStageAKT_NO: TStringField
      Tag = 2
      FieldName = 'AKT_NO'
      Origin = 'S.AKT_NO'
      Visible = False
      Size = 30
    end
    object quTreatyStageCREATE_AKT: TDateTimeField
      Tag = 2
      FieldName = 'CREATE_AKT'
      Visible = False
    end
    object quTreatyStageSW_STAGE: TStringField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'SW_STAGE'
      Visible = False
      Size = 2
    end
  end
  object quTrCurator: TVASUPQuery
    SQL.Strings = (
      'SELECT A.*,'
      '       A.ROWID,'
      '       INITCAP(RAB.FNAIM||'#39' '#39'||RAB.INAIM||'#39' '#39'||RAB.ONAIM) FIO,'
      '       RAB.FNAIM,'
      '       RAB.INAIM,'
      '       RAB.ONAIM,'
      '       RAB.DATAUVOL,'
      '       RAB.MIPROF_KOD,'
      '       JOB.SNAIM MIPROF_SNAIM,'
      '       UPDR.KOD MIUPDR_KOD,'
      '       UPDR.SNAIM MIUPDR_SNAIM,'
      '       DEPT.MIUROVEN_KOD,'
      '       RAB.MIPODR_ID,'
      '       SUBSTR(DEPT.PKOD,5) MIPODR_KOD,'
      '       DEPT.SNAIM MIPODR_SNAIM,'
      
        '       SUBSTR(P.NODE_PATH(DEPT.ID,DEPT.MIUROVEN_KOD,2),1,255) MI' +
        'PODR_PNAIM'
      '  FROM RN.MNTRCURATOR A,'
      '       P.MIRAB RAB,'
      '       P.MIPROF JOB,'
      '       P.MIPODR UPDR,'
      '       P.MIPODR DEPT'
      ' WHERE RAB.TABN= A.MIRAB_TABN'
      '   AND DEPT.ID= RAB.MIPODR_ID'
      '   AND JOB.KOD= RAB.MIPROF_KOD'
      '   AND UPDR.ID= ( SELECT ID FROM P.MIPODR'
      '                   WHERE MIPODR_ID= 1'
      
        '                         START WITH ID= DEPT.MIPODR_ID CONNECT B' +
        'Y PRIOR MIPODR_ID=ID'
      '               )'
      'AND TREATY_ID = :TREATY_ID')
    Optimize = False
    Variables.Data = {
      03000000010000000A0000003A5452454154595F494403000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      04000000100000000A0000004D495241425F5441424E01000000000009000000
      5452454154595F49440100000000000300000046494F01000000000005000000
      4F4E41494D01000000000005000000464E41494D010000000000080000004441
      544155564F4C0100000000000A0000004D4950524F465F4B4F44010000000000
      0C0000004D4950524F465F534E41494D0100000000000A0000004D4955504452
      5F4B4F440100000000000C0000004D49555044525F534E41494D010000000000
      090000004D49504F44525F49440100000000000A0000004D49504F44525F4B4F
      440100000000000C0000004D49504F44525F534E41494D0100000000000C0000
      004D49504F44525F504E41494D01000000000005000000494E41494D01000000
      00000C0000004D4955524F56454E5F4B4F44010000000000}
    Cursor = crSQLWait
    Master = quTreaty
    MasterFields = 'ID'
    DetailFields = 'TREATY_ID'
    UpdatingTable = 'RN.MNTRCURATOR'
    CommitOnPost = False
    Session = seOracle
    BeforeInsert = BeforeEditTreaty
    BeforeEdit = BeforeEditTreaty
    BeforeDelete = BeforeEditTreaty
    ReActive = True
    Caption = #1050#1091#1088#1072#1090#1086#1088
    Order = 'FIO ASC'
    LinkDetailSQL = True
    LinkKind = lkIn
    EmbeddedSQLSlice.Strings = (
      '  FROM RN.MNTRCURATOR A,'
      '       P.MIRAB RAB,'
      '       P.MIPROF JOB,'
      '       P.MIPODR UPDR,'
      '       P.MIPODR DEPT'
      ' WHERE RAB.TABN= A.MIRAB_TABN'
      '   AND DEPT.ID= RAB.MIPODR_ID'
      '   AND JOB.KOD= RAB.MIPROF_KOD'
      '   AND UPDR.ID= ( SELECT ID FROM P.MIPODR'
      '                   WHERE MIPODR_ID= 1'
      
        '                         START WITH ID= DEPT.MIPODR_ID CONNECT B' +
        'Y PRIOR MIPODR_ID=ID'
      '               )'
      ' ')
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 416
    Top = 216
    object quTrCuratorMIRAB_TABN: TIntegerField
      DisplayLabel = #1058#1072#1073'.'#1085#1086#1084#1077#1088
      DisplayWidth = 7
      FieldName = 'MIRAB_TABN'
      KeyFields = 'MIRAB_TABN'
      Origin = 'A.MIRAB_TABN'
      Required = True
      OnChange = RefreshCalcFields
      DisplayFormat = '000000'
      EditFormat = '000000'
    end
    object quTrCuratorTREATY_ID: TFloatField
      DisplayLabel = 'ID '#1076#1086#1075#1086#1074#1086#1088#1072
      DisplayWidth = 13
      FieldName = 'TREATY_ID'
      Origin = 'A.TREATY_ID'
      Visible = False
      DisplayFormat = '#,###,###,##0'
      EditFormat = '#########0'
    end
    object quTrCuratorFIO: TStringField
      DisplayLabel = #1060'.'#1048'.'#1054'.'
      DisplayWidth = 27
      FieldKind = fkInternalCalc
      FieldName = 'FIO'
      Origin = 'INITCAP(RAB.FNAIM||'#39' '#39'||RAB.INAIM||'#39' '#39'||RAB.ONAIM)'
      Size = 92
    end
    object quTrCuratorFNAIM: TStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103
      FieldKind = fkInternalCalc
      FieldName = 'FNAIM'
      KeyFields = 'FNAIM'
      Origin = 'RAB.FNAIM'
      Visible = False
      Size = 30
    end
    object quTrCuratorINAIM: TStringField
      DisplayLabel = #1048#1084#1103
      FieldKind = fkInternalCalc
      FieldName = 'INAIM'
      KeyFields = 'INAIM'
      Origin = 'RAB.INAIM'
      Visible = False
      Size = 30
    end
    object quTrCuratorONAIM: TStringField
      DisplayLabel = #1054#1090#1095#1077#1089#1090#1074#1086
      FieldKind = fkInternalCalc
      FieldName = 'ONAIM'
      KeyFields = 'ONAIM'
      Origin = 'RAB.ONAIM'
      Visible = False
      Size = 30
    end
    object quTrCuratorDATAUVOL: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1091#1074#1086#1083#1100#1085#1077#1085#1080#1103
      DisplayWidth = 10
      FieldKind = fkInternalCalc
      FieldName = 'DATAUVOL'
      Origin = 'RAB.DATAUVOL'
      Visible = False
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quTrCuratorMIPROF_KOD: TIntegerField
      DisplayLabel = #1044#1086#1083#1078#1085'/'#1087#1088#1086#1092'.'
      FieldKind = fkInternalCalc
      FieldName = 'MIPROF_KOD'
      KeyFields = 'MIPROF_KOD'
      Origin = 'RAB.MIPROF_KOD'
      Visible = False
      OnChange = RefreshCalcFields
      DisplayFormat = '0000'
      EditFormat = '0000'
    end
    object quTrCuratorMIUPDR_KOD: TIntegerField
      DisplayLabel = #1059#1055#1044#1056
      DisplayWidth = 2
      FieldKind = fkInternalCalc
      FieldName = 'MIUPDR_KOD'
      Origin = 'UPDR.KOD'
      Visible = False
      OnChange = RefreshCalcFields
      EditFormat = '00'
    end
    object quTrCuratorMIPROF_SNAIM: TStringField
      DisplayLabel = #1044#1086#1083#1078#1085'/'#1087#1088#1086#1092'.'#1085#1072#1080#1084'.'
      DisplayWidth = 21
      FieldKind = fkInternalCalc
      FieldName = 'MIPROF_SNAIM'
      Origin = 'JOB.SNAIM'
    end
    object quTrCuratorMIUPDR_SNAIM: TStringField
      DisplayLabel = #1059#1055#1044#1056' '#1085#1072#1080#1084'.'
      DisplayWidth = 10
      FieldKind = fkInternalCalc
      FieldName = 'MIUPDR_SNAIM'
      Origin = 'UPDR.SNAIM'
      Visible = False
      Size = 10
    end
    object quTrCuratorMIUROVEN_KOD: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'MIUROVEN_KOD'
      Origin = 'DEPT.MIUROVEN_KOD'
      Visible = False
    end
    object quTrCuratorMIPODR_ID: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'MIPODR_ID'
      KeyFields = 'MIPODR_ID'
      Origin = 'DE6PT.ID'
      Visible = False
      OnChange = RefreshCalcFields
    end
    object quTrCuratorMIPODR_KOD: TStringField
      DisplayLabel = #1055#1086#1076#1088'.'
      FieldKind = fkInternalCalc
      FieldName = 'MIPODR_KOD'
      Origin = 'SUBSTR(DEPT.PKOD,5)'
      Visible = False
      OnChange = RefreshCalcFields
      Size = 16
    end
    object quTrCuratorMIPODR_SNAIM: TStringField
      DisplayLabel = #1055#1086#1076#1088'.'#1085#1072#1080#1084'.'
      DisplayWidth = 10
      FieldKind = fkInternalCalc
      FieldName = 'MIPODR_SNAIM'
      Origin = 'DEPT.SNAIM'
      Visible = False
      Size = 10
    end
    object quTrCuratorUPDR_ID: TFloatField
      FieldKind = fkCalculated
      FieldName = 'UPDR_ID'
      ProviderFlags = []
      Visible = False
      Calculated = True
    end
    object quTrCuratorPODR_ID: TFloatField
      FieldKind = fkCalculated
      FieldName = 'PODR_ID'
      ProviderFlags = []
      Visible = False
      Calculated = True
    end
    object quTrCuratorMIPODR_PNAIM: TStringField
      DisplayLabel = #1055#1086#1076#1088'.'#1085#1072#1080#1084'.('#1087')'
      DisplayWidth = 33
      FieldKind = fkInternalCalc
      FieldName = 'MIPODR_PNAIM'
      Origin = 'SUBSTR(P.NODE_PATH(DEPT.ID,DEPT.MIUROVEN_KOD,2),1,255)'
      Size = 255
    end
  end
  object quChangeStatus: TOracleQuery
    SQL.Strings = (
      'begin'
      '  update RN.mntreaty t'
      '        set t.status = :STATUS,'
      '              t.annul_kod =:ANNUL_KOD'
      '    where t.id = :ID;'
      'end;')
    Session = seOracle
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0300000003000000030000003A4944030000000000000000000000070000003A
      5354415455530500000000000000000000000A0000003A414E4E554C5F4B4F44
      030000000000000000000000}
    Cursor = crSQLWait
    Left = 24
    Top = 454
  end
  object quPrintLetter: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  TYPE RefCurType IS REF CURSOR;'
      ''
      '  --v_IDStages VARCHAR2(200);'
      '  v_SPECIAL_WRITTEN M.DOCUMENTS.DOC_NO%type;'
      '  c_ErrorMsg VARCHAR2(2000);'
      '  v_summpay  NUMBER(20,2);'
      '  v_treaty  mntreaty%ROWTYPE;'
      '  v_agreem  mnagreem%ROWTYPE;'
      '  v_exec_firm  firm%ROWTYPE;'
      '  v_stage_nums  VARCHAR2(209);'
      '  v_stage_acts  VARCHAR2(200);'
      '  v_obosnovan  VARCHAR2(200);'
      '  v_exec_bank  bank%ROWTYPE;'
      '  v_exec_account  firm_account%ROWTYPE;'
      '  v_primechanie  VARCHAR2(200);'
      '  v_tab_stages RN.utils_pkg.t_tab_stages;'
      '  v_curator VARCHAR2(90);'
      '  v_beneficiary VARCHAR2(1500);'
      '  v_bank VARCHAR2(200);'
      '  v_NIOKR_ACCOUNT VARCHAR2(300);'
      '  v_NDS VARCHAR2(30);'
      '  v_NDS_SUMMPAY NUMBER(20,2);'
      ''
      '  v_s  NUMBER(20,2);'
      '  I INTEGER;'
      ''
      '  v_sql_stmt VARCHAR2(200);'
      '  c_cur RefCurType;'
      '  v_cont_PAY_DATE DATE;'
      'BEGIN'
      '  -- Test statements here'
      '  --v_IDStages := :STAGE_IDS;'
      '  v_SPECIAL_WRITTEN := :SPECIAL_WRITTEN;'
      
        '  RN.utils_pkg.PrintLetter(v_SPECIAL_WRITTEN, c_ErrorMsg,v_summp' +
        'ay,v_treaty,v_agreem,v_exec_firm,'
      
        '                         v_stage_nums,v_stage_acts,v_obosnovan,v' +
        '_exec_bank,v_exec_account,v_primechanie,'
      
        '                         v_tab_stages, v_curator, v_beneficiary,' +
        ' v_bank, v_NIOKR_ACCOUNT, v_cont_PAY_DATE,'
      '                         v_NDS, v_NDS_SUMMPAY);'
      '  :c_ErrorMsg := c_ErrorMsg;'
      ''
      '  :v_summpay := v_summpay;  -- '#1055#1086#1083#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1086#1087#1083#1072#1090#1099
      '  :v_tr_num := v_treaty.num; -- '#1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
      
        '  :v_tr_datesign := v_treaty.datesign; -- '#1044#1072#1090#1072' '#1087#1086#1076#1087#1080#1089#1072#1085#1080#1103' '#1076#1086#1075#1086#1074#1086 +
        #1088#1072
      
        '  :v_agr_num := v_agreem.num; -- '#1053#1086#1084#1077#1088' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1086#1087'. '#1089#1086#1075#1083#1072#1096#1077#1085#1080 +
        #1103
      
        '  :v_agr_datesign := v_agreem.datesign; -- '#1044#1072#1090#1072' '#1087#1086#1076#1087#1080#1089#1072#1085#1080#1103' '#1087#1086#1089#1083#1077 +
        #1076#1085#1077#1075#1086' '#1076#1086#1087'. '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1103
      
        '  :v_exec_name := v_exec_firm.name; -- '#1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1079#1072#1082#1072#1079 +
        #1095#1080#1082#1072
      '  :v_stage_acts := v_stage_acts; -- '#1040#1082#1090#1099' '#1089#1076#1072#1095#1080
      '  :v_stage_nums := v_stage_nums; -- '#1053#1086#1084#1077#1088#1072' '#1072#1082#1090#1086#1074
      '  :v_obosnovan := v_obosnovan; -- '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077' '#1089#1076#1072#1095#1080
      
        '  :v_exec_bank_name := v_exec_bank.name; -- '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1073#1072#1085#1082#1072' '#1087 +
        #1086#1083#1091#1095#1072#1090#1077#1083#1103
      
        '  :v_exec_bank_city := v_exec_bank.city_name; -- '#1052#1077#1089#1090#1086#1087#1086#1083#1086#1078#1077#1085#1080#1077'(' +
        #1075#1086#1088#1086#1076') '#1073#1072#1085#1082#1072' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103
      
        '  :v_exec_account := v_exec_account.bank_account; -- '#1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072 +
        ' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103
      '  :v_exec_unn := v_exec_firm.vat_no; -- '#1059#1053#1053'('#1048#1053#1053') '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103
      '  :v_primechanie := v_primechanie; -- '#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      
        '  :v_exec_bank_code := v_exec_bank.bank_code; -- '#1050#1086#1076' '#1073#1072#1085#1082#1072' '#1087#1086#1083#1091#1095 +
        #1072#1090#1077#1083#1103
      
        '  :v_exec_currency_no := v_exec_account.currency_no; -- '#1050#1086#1076' '#1074#1072#1083#1102 +
        #1090#1099
      '  :v_exec_bank_swift := v_exec_bank.swift_id; -- SWIFT '#1073#1072#1085#1082#1072
      
        '  :v_exec_bank_loro_acc := v_exec_bank.loro_account; -- '#1050#1086#1088#1088#1077#1089#1087#1086 +
        #1085#1076#1077#1085#1090#1089#1082#1080#1081' '#1089#1095#1077#1090' '#1073#1072#1085#1082#1072
      
        '  :v_exec_bank_id := v_exec_bank.bank_id; -- '#1041#1048#1050' '#1073#1072#1085#1082#1072' '#1087#1086#1083#1091#1095#1072#1090#1077#1083 +
        #1103
      
        '  :v_exec_city := v_exec_firm.city_name; -- '#1052#1077#1089#1090#1086#1087#1086#1083#1086#1078#1077#1085#1080#1077'('#1075#1086#1088#1086#1076 +
        ') '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103
      '  :v_curator:= v_curator; -- '#1050#1091#1088#1072#1090#1086#1088' '#1076#1086#1075#1086#1074#1086#1088#1072' '#1089' '#1085#1072#1080#1084#1077#1085#1100#1096#1080#1084' rowid'
      
        '  :v_beneficiary := v_beneficiary; -- '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' '#1087 +
        #1086#1083#1091#1095#1072#1090#1077#1083#1103' '#1076#1077#1085#1077#1075
      '  :v_bank := v_bank; -- '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1073#1072#1085#1082#1072' '#1085#1072' '#1087#1083#1072#1090#1077#1078#1082#1080
      
        '  :v_NIOKR_ACCOUNT := v_NIOKR_ACCOUNT; -- '#1053#1048#1054#1050#1056' '#1089#1095#1077#1090' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080 +
        ' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103' '#1076#1077#1085#1077#1075
      '  :v_ISTFIN_KOD := v_treaty.ISTFIN_KOD;'
      
        '  :v_TREATY_DOC_NO := v_treaty.DOC_NO; -- '#1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072' '#1074' '#1089#1093#1077#1084#1077 +
        ' M'
      
        '  :v_AGREEM_DOC_NO := v_agreem.DOC_NO; -- '#1053#1086#1084#1077#1088' '#1076#1086#1087'. '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1077' ' +
        #1074' '#1089#1093#1077#1084#1077' M'
      '  :V_CONT_PAY_DATE := TO_CHAR(v_cont_PAY_DATE, '#39'dd.mm.yyyy'#39');'
      '  :v_NDS := v_NDS;'
      '  :v_NDS_SUMMPAY := v_NDS_SUMMPAY;'
      ''
      ''
      '  -- '#1055#1086#1083#1091#1095#1077#1085#1080#1077' '#1101#1090#1072#1087#1086#1074' '#1080#1079' '#1090#1072#1073#1083#1080#1094#1099
      '  IF (v_tab_stages.COUNT > 2) AND'
      
        '     (v_exec_account.currency_no IS NOT NULL) AND (v_exec_accoun' +
        't.currency_no <> 933)'
      '  THEN'
      
        '    :c_ErrorMsg := '#39#1055#1088#1080#1083#1086#1078#1077#1085#1080#1077' '#1085#1077' '#1087#1086#1079#1074#1086#1083#1103#1077#1090' '#1089#1086#1079#1076#1072#1074#1072#1090#1100' '#1087#1080#1089#1100#1084#1086', '#1074' ' +
        #1082#1086#1090#1086#1088#1086#1084' '#1073#1086#1083#1077#1077' 2-'#1093' '#1072#1082#1090#1086#1074' '#1089#1076#1072#1095#1080' '#1101#1090#1072#1087#1086#1074'.'#39';'
      '  END IF;'
      '  IF v_tab_stages.COUNT = 1 THEN'
      
        '    :v_stage1 := v_tab_stages(0).stages; :v_numact1 := v_tab_sta' +
        'ges(0).numact;'
      '    :v_dateact1 := v_tab_stages(0).dateact;'
      '    :v_stage2 := NULL; :v_numact2 := NULL; :v_dateact2 := NULL;'
      '  ELSIF v_tab_stages.COUNT = 2 THEN'
      
        '    :v_stage1 := v_tab_stages(0).stages; :v_numact1 := v_tab_sta' +
        'ges(0).numact;'
      '    :v_dateact1 := v_tab_stages(0).dateact;'
      
        '    :v_stage2 := v_tab_stages(1).stages; :v_numact2 := v_tab_sta' +
        'ges(1).numact;'
      '    :v_dateact2 := v_tab_stages(1).dateact;'
      '  END IF;'
      ''
      '  -- '#1055#1054#1083#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1074' '#1085#1072#1094#1080#1086#1085#1072#1083#1100#1085#1086#1081' '#1074#1072#1083#1102#1090#1077
      '  IF  v_exec_account.currency_no <> 933 THEN'
      '    :v_nation_sum := 0;'
      ''
      '    FOR I in 1..v_tab_stages.COUNT LOOP'
      '      SELECT ER.E_RATE  / ER.rate_scale'
      '        INTO v_s'
      '        FROM S.EXCHANGE_RATES er'
      
        '       WHERE er.intro_date = RN.MONEY_PKG.getdateofexchangeofsta' +
        'ge(v_exec_account.currency_no,'
      
        '                                                                ' +
        'v_tab_stages(i - 1).dateact,'
      
        '                                                                ' +
        'v_agreem.treaty_id,'
      
        '                                                                ' +
        'v_treaty.datefrom)'
      '         AND er.CURRENCY_NO = v_exec_account.currency_no;'
      ''
      
        '      :v_nation_sum := :v_nation_sum + (v_s * v_tab_stages(i - 1' +
        ').summpay);'
      '    END LOOP;'
      ''
      '    if v_treaty.ISTFIN_KOD = 1 THEN'
      '      :v_NOTE := v_primechanie || '#39', '#1080#1079' '#1089#1088#1077#1076#1089#1090#1074' '#1087#1088#1077#1076#1087#1088#1080#1103#1090#1080#1103#39';'
      '    ELSE'
      '      :v_NOTE := v_primechanie || '#39', '#1080#1085#1085#1086#1074#1072#1094#1080#1086#1085#1085#1099#1081' '#1092#1086#1085#1076#39';'
      '    END IF;'
      ''
      '    IF TRIM(v_NIOKR_ACCOUNT) IS NOT NULL THEN'
      '      :v_NOTE := :v_NOTE || '#39' '#39' || TRIM(v_NIOKR_ACCOUNT);'
      '    END IF;'
      '  ELSE'
      '    :v_nation_sum := :v_summpay;'
      ''
      '    :v_NOTE := v_primechanie;'
      ''
      '    IF TRIM(v_NIOKR_ACCOUNT) IS NOT NULL THEN'
      '      :v_NOTE := :v_NOTE || '#39' '#39' || TRIM(v_NIOKR_ACCOUNT);'
      '    END IF;'
      ''
      '    if v_treaty.ISTFIN_KOD = 1 THEN'
      '      :v_NOTE := :v_NOTE || '#39', '#1080#1079' '#1089#1088#1077#1076#1089#1090#1074' '#1087#1088#1077#1076#1087#1088#1080#1103#1090#1080#1103#39';'
      '    ELSE'
      '      :v_NOTE := :v_NOTE || '#39', '#1080#1085#1085#1086#1074#1072#1094#1080#1086#1085#1085#1099#1081' '#1092#1086#1085#1076#39';'
      '    END IF;'
      ''
      ''
      '  END IF;'
      ''
      '  /*IF v_IDStages IS NOT NULL THEN'
      
        '    v_sql_stmt := '#39'SELECT min(st.dateact) + 3 FROM RN.mnstage st' +
        ' WHERE st.id IN ('#39' || v_IDStages || '#39')'#39';'
      '    OPEN c_cur FOR v_sql_stmt;'
      '    FETCH c_cur INTO :v_cont_pay_day;'
      '    CLOSE c_cur;'
      '  END IF;     */'
      ''
      '  IF  v_exec_bank.COUNTRY_NO IS NOT NULL THEN'
      '    SELECT NAME'
      '      INTO :v_exec_bank_country'
      '      FROM S.COUNTRY'
      '     WHERE COUNTRY_NO = v_exec_bank.COUNTRY_NO;'
      '  ELSE'
      '    :v_exec_bank_country := NULL;'
      '  END IF;'
      ''
      '  IF  v_exec_firm.COUNTRY_NO IS NOT NULL THEN'
      '    SELECT NAME'
      '      INTO :v_exec_country'
      '      FROM S.COUNTRY'
      '     WHERE COUNTRY_NO = v_exec_firm.COUNTRY_NO;'
      '  ELSE'
      '    :v_exec_country := NULL;'
      '  END IF;'
      ''
      'END;'
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      030000002A000000100000003A5350454349414C5F5752495454454E05000000
      00000000000000000B0000003A435F4552524F524D5347050000000000000000
      0000000A0000003A565F53554D4D504159040000000000000000000000090000
      003A565F54525F4E554D0500000000000000000000000E0000003A565F54525F
      444154455349474E0C00000000000000000000000A0000003A565F4147525F4E
      554D0300000000000000000000000F0000003A565F4147525F44415445534947
      4E0C00000000000000000000000C0000003A565F455845435F4E414D45050000
      0000000000000000000D0000003A565F53544147455F41435453050000000000
      0000000000000D0000003A565F53544147455F4E554D53050000000000000000
      000000110000003A565F455845435F42414E4B5F4E414D450500000000000000
      00000000110000003A565F455845435F42414E4B5F4349545905000000000000
      00000000000F0000003A565F455845435F4143434F554E540500000000000000
      000000000B0000003A565F455845435F554E4E0500000000000000000000000E
      0000003A565F5052494D454348414E49450500000000000000000000000C0000
      003A565F4F424F534E4F56414E050000000000000000000000110000003A565F
      455845435F42414E4B5F434F4445050000000000000000000000130000003A56
      5F455845435F43555252454E43595F4E4F030000000000000000000000120000
      003A565F455845435F42414E4B5F535749465405000000000000000000000015
      0000003A565F455845435F42414E4B5F4C4F524F5F4143430500000000000000
      000000000F0000003A565F455845435F42414E4B5F4944050000000000000000
      0000000C0000003A565F455845435F4349545905000000000000000000000009
      0000003A565F5354414745310500000000000000000000000A0000003A565F4E
      554D414354310500000000000000000000000B0000003A565F44415445414354
      31050000000000000000000000090000003A565F535441474532050000000000
      0000000000000A0000003A565F4E554D41435432050000000000000000000000
      0B0000003A565F44415445414354320500000000000000000000000A0000003A
      565F43555241544F520500000000000000000000000E0000003A565F42454E45
      46494349415259050000000000000000000000070000003A565F42414E4B0500
      00000000000000000000100000003A565F4E494F4B525F4143434F554E540500
      000000000000000000000D0000003A565F49535446494E5F4B4F440300000000
      00000000000000100000003A565F5452454154595F444F435F4E4F0500000000
      00000000000000100000003A565F41475245454D5F444F435F4E4F0500000000
      000000000000000D0000003A565F4E4154494F4E5F53554D0400000000000000
      00000000070000003A565F4E4F5445050000000000000000000000140000003A
      565F455845435F42414E4B5F434F554E5452590500000000000000000000000F
      0000003A565F455845435F434F554E5452590500000000000000000000001000
      00003A565F434F4E545F5041595F444154450500000000000000000000000600
      00003A565F4E44530500000000000000000000000E0000003A565F4E44535F53
      554D4D504159040000000000000000000000}
    Cursor = crSQLWait
    Left = 16
    Top = 114
  end
  object quRN01_RN02_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id,'
      '       vitreaty.treaty_num  treaty_num,'
      '       vitreaty.subject,'
      '       '#39#1069#1090#1072#1087' '#39' || st.num stage_num,'
      '       firm_account.currency_no,'
      '       st.summpay stage_summpay,'
      '       st.dateact stage_dateact,'
      '       REPLACE(TO_CHAR(exchange_rates.e_rate),'#39','#39','#39'.'#39') e_rate,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      
        '       decode(agr.istfin_kod, 2, vitreaty.theme_plan_num, vitrea' +
        'ty.treaty_id) num ,'
      '       vitreaty.exec_name exec_name,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY 1) count_sta' +
        'ge,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty,'
      '       st.Reporting Reporting'
      '  FROM RN.vitreaty,'
      '       RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       S.firm_account,'
      '       S.firm,'
      '       S.exchange_rates'
      '  WHERE st.dateact BETWEEN :v_datefrom'
      '                       AND LAST_DAY(:v_dateto)'
      '   AND agr.id = st.agreem_id'
      '   AND agr.istfin_kod = :v_istfin_kod'
      
        '   AND ((:CONC IS NULL) OR (:CONC = RN.mitrconcern_pkg.GetConcDo' +
        'gForInnavDog(:V_DATEFROM, vitreaty.DATEFROM, vitreaty.DATETO)))'
      
        '   --AND ((:CONC_DATETO IS NULL) OR (TRUNC(vitreaty.datefrom, '#39'M' +
        'ONTH'#39') <= :CONC_DATETO))'
      
        '   --AND ((:CONC_DATEFROM IS NULL) OR (TRUNC(vitreaty.datefrom, ' +
        #39'MONTH'#39') >= :CONC_DATEFROM))'
      '   AND firm_account.bank_accnt_id = st.exec_account_id'
      '   AND firm.firm_no = firm_account.firm_no'
      '   AND exchange_rates.currency_no = firm_account.currency_no'
      '   AND exchange_rates.intro_date = (SELECT MAX(er.intro_date)'
      '                                      FROM S.exchange_rates er'
      
        '                                     WHERE er.intro_date <= st.d' +
        'ateact'
      
        '                                       AND er.currency_no = firm' +
        '_account.currency_no)'
      '   AND vitreaty.treaty_id = agr.treaty_id'
      
        ' ORDER BY decode(agr.istfin_kod, 2, vitreaty.theme_plan_num, vit' +
        'reaty.treaty_id), vitreaty.treaty_id,'
      '          st.num'
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      03000000040000000B0000003A565F4441544546524F4D0C0000000000000000
      000000090000003A565F44415445544F0C00000000000000000000000D000000
      3A565F49535446494E5F4B4F44030000000000000000000000050000003A434F
      4E43030000000000000000000000}
    Left = 171
    Top = 426
  end
  object quMitrconcern: TVASUPQuery
    SQL.Strings = (
      'SELECT'
      
        ' A.*,A.ROWID, DECODE(A.DOG_LIMIT, '#39'B'#39', 1, '#39'F'#39', 1, 0) EXISTENT_BE' +
        'G_INTERVAL'
      'FROM'
      ' RN.MITRCONCERN A'
      ''
      'WHERE'
      ' A.DOG_ID IS NULL -- '#1087#1088#1080#1079#1085#1072#1082' '#1090#1086#1075#1086', '#1095#1090#1086' '#1101#1090#1086' '#1076#1086#1075#1086#1074#1086#1088
      '/* END_REFRESH */'
      ''
      ' '
      ' '
      ' ')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      040000000A000000030000004E554D0100000000000800000044415445534947
      4E010000000000080000004441544546524F4D01000000000006000000444154
      45544F01000000000002000000494401000000000006000000444F475F494401
      000000000009000000444F475F4C494D4954010000000000040000004E414D45
      010000000000150000004558495354454E545F4245475F494E54455256414C01
      00000000000D000000574F524B5F4441544546524F4D010000000000}
    UpdatingTable = 'RN.MITRCONCERN'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1044#1086#1075#1086#1074#1086#1088#1072
    Order = 'DATESIGN ASC'
    AccessLevel = [aqQuerying, aqInserting, aqEditing, aqDeleting]
    LinkKind = lkIn
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 320
    Top = 18
    object quMitrconcernNUM: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      FieldName = 'NUM'
      Size = 15
    end
    object quMitrconcernDATESIGN: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1086#1076#1087#1080#1089#1072#1085#1080#1103
      FieldName = 'DATESIGN'
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object quMitrconcernDATEFROM: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1076#1077#1081#1089#1090#1074#1080#1103
      FieldName = 'DATEFROM'
      Required = True
      OnChange = mm_yyyy_from
      DisplayFormat = 'mm.yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object quMitrconcernDATETO: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1076#1077#1081#1089#1090#1074#1080#1103
      FieldName = 'DATETO'
      Required = True
      OnChange = mm_yyyy_to
      DisplayFormat = 'mm.yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object quMitrconcernID: TFloatField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'ID'
      Required = True
      Visible = False
    end
    object quMitrconcernNAME: TStringField
      Tag = 2
      FieldName = 'NAME'
      Visible = False
      Size = 600
    end
    object quMitrconcernEXISTENT_BEG_INTERVAL: TFloatField
      DisplayLabel = #1053#1077' '#1088#1072#1089#1087#1088#1086#1089#1090#1088#1072#1085#1103#1077#1090#1089#1103' '#1085#1072' '#1089#1090#1072#1088#1099#1077' '#1080#1085#1085#1086#1074#1072#1094#1080#1086#1085#1085#1099#1077' '#1076#1086#1075#1086#1074#1086#1088#1072
      DisplayWidth = 1
      FieldKind = fkInternalCalc
      FieldName = 'EXISTENT_BEG_INTERVAL'
      Origin = 'DECODE(A.DOG_LIMIT, '#39'B'#39', 1, '#39'F'#39', 1, 0)'
      Visible = False
      OnChange = quMitrconcernEXISTENT_BEG_INTERVALChange
    end
    object quMitrconcernDOG_LIMIT: TStringField
      Tag = 2
      FieldName = 'DOG_LIMIT'
      Required = True
      Visible = False
      Size = 1
    end
    object quMitrconcernWORK_DATEFROM: TDateTimeField
      FieldName = 'WORK_DATEFROM'
      Visible = False
    end
  end
  object quRN03_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT tr.id id,'
      '       tr.num  name,'
      '       tr.subject subject,'
      '       TO_CHAR(tr.datefrom,'#39'MM.YYYY'#39') datefrom,'
      '       TO_CHAR(agr_num.dateto,'#39'MM.YYYY'#39') dateto,'
      '       agr_num.summpay summpay,'
      '       fa.currency_no currency_no,'
      '       tr.status status,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       --exchange_rates.e_rate,'
      '       DECODE(fa.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(fa.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         tr.datefrom)'
      '                  AND er.CURRENCY_NO = fa.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      '       RN.MONEY_PKG.getdateofexchangeofstage(fa.currency_no,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          tr.datefrom'
      '                                         ) into_date,'
      '       COUNT(tr.id) OVER (PARTITION BY tr.id) count_per_treaty,'
      '       st.dateact,'
      '       st.datefrom stage_datefrom,'
      '       st.dateto stage_dateto,'
      '       currency.iso_name currency_name,'
      '       decode(agr.istfin_kod, 2, tr.theme_plan_num, tr.id) num,'
      '       firm.name exec_name,'
      '       COUNT(DISTINCT tr.id) OVER (PARTITION BY 1) count_treaty'
      '  FROM RN.mnagreem agr,'
      '       RN.mntreaty tr,'
      '       RN.mnstage st,'
      '       S.currency,'
      '       RN.MNAGREEM agr_num,'
      '       firm_account fa,'
      '       firm'
      ' WHERE EXISTS (SELECT *'
      '                 FROM RN.mitrconcern'
      
        '                WHERE :V_DATE BETWEEN mitrconcern.datefrom AND m' +
        'itrconcern.dateto'
      '                  AND tr.datefrom <= mitrconcern.dateto)'
      '   AND agr.istfin_kod = 2 -- '#1048#1085#1085#1086#1074#1072#1094#1080#1086#1085#1085#1099#1081' '#1092#1086#1085#1076
      '   AND tr.status NOT IN ('#39'A'#39', '#39'P'#39')'
      '   AND (   (tr.status = '#39'O'#39')'
      
        '        OR (tr.status <> '#39'O'#39' AND  TRUNC(agr_num.dateto, '#39'YEAR'#39') ' +
        '>= TRUNC(:V_DATE, '#39'YEAR'#39')))'
      
        '   --AND ((:CONC_DATETO IS NULL) OR (TRUNC(vitreaty.datefrom, '#39'M' +
        'ONTH'#39') <= :CONC_DATETO))'
      
        '   --AND ((:CONC_DATEFROM IS NULL) OR (TRUNC(vitreaty.datefrom, ' +
        #39'MONTH'#39') >= :CONC_DATEFROM))'
      
        '   AND :CONC = RN.mitrconcern_pkg.GetConcDogForInnavDog(:V_DATE,' +
        ' tr.DATEFROM, agr_num.DATETO)'
      '   AND TRUNC(tr.datefrom, '#39'YEAR'#39') <= TRUNC(:V_DATE, '#39'YEAR'#39')'
      '   AND TRUNC(:V_DATE, '#39'MONTH'#39') >= TRUNC(tr.datesign, '#39'MONTH'#39')'
      '   AND agr.treaty_id = tr.id'
      '   AND currency.currency_no = fa.currency_no'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   (st.dateact IS NOT NULL AND agr.num < agr_num.num) --' +
        ' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = agr_num.num)'
      '   AND agr_num.treaty_id = tr.id'
      '   AND agr_num.num = DECODE(:CURR_AGR, 0, (SELECT MAX(agr1.num)'
      '                                             FROM mnagreem agr1'
      
        '                                            WHERE agr1.treaty_id' +
        ' = agr_num.treaty_id),'
      '                                       1, (SELECT MAX(agr1.num)'
      '                                             FROM mnagreem agr1'
      
        '                                            WHERE agr1.treaty_id' +
        ' = agr_num.treaty_id'
      
        '                                              AND TRUNC(:V_DATE,' +
        ' '#39'MONTH'#39') >= TRUNC(agr1.DATESIGN, '#39'MONTH'#39') ))'
      '   AND fa.bank_accnt_id(+) = tr.exec_account_id'
      '   AND firm.firm_no(+) = fa.firm_no'
      
        ' ORDER BY decode(agr.istfin_kod, 2, tr.theme_plan_num, tr.id), t' +
        'r.id'
      ' '
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000003000000070000003A565F444154450C000000000000000000000005
      0000003A434F4E43030000000000000000000000090000003A435552525F4147
      52030000000000000000000000}
    Left = 181
    Top = 114
  end
  object quAccountDefault: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      ' CURSOR cur_v (v_treaty IN NUMBER) IS '
      '  SELECT mnstage.cust_account_id,'
      '         mnstage.exec_account_id'
      '    FROM RN.mnagreem,'
      '         RN.mnstage'
      '   WHERE mnstage.agreem_id = mnagreem.id'
      '     AND mnagreem.treaty_id = v_treaty'
      '     AND mnstage.dateact IS NOT NULL'
      '  ORDER BY mnstage.dateact DESC,'
      '           mnstage.num DESC;'
      ' v_account cur_v%ROWTYPE;'
      'BEGIN'
      ' :v_cust_accnt :=NULL; :v_exec_accnt := NULL;'
      ' OPEN cur_v(:treaty_id);'
      ' FETCH cur_v INTO v_account;'
      ' IF cur_v%FOUND THEN'
      '  SELECT fa.bank_account '
      '    INTO :v_cust_accnt'
      '    FROM S.firm_account fa '
      '   WHERE fa.bank_accnt_id = v_account.cust_account_id;'
      '  SELECT fa.bank_account '
      '    INTO :v_exec_accnt'
      '    FROM S.firm_account fa '
      '   WHERE fa.bank_accnt_id = v_account.exec_account_id;'
      ' END IF;'
      'END;'
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      03000000030000000A0000003A5452454154595F494403000000000000000000
      00000D0000003A565F435553545F4143434E540500000000000000000000000D
      0000003A565F455845435F4143434E54050000000000000000000000}
    Left = 264
    Top = 390
  end
  object quCurrState: TVASUPQuery
    SQL.Strings = (
      'SELECT '#9'A.*,'
      '              A.ROWID,'
      '              P.SNAIM PAYMENT_SNAIM,'
      '              I.SNAIM ISTFIN_SNAIM'
      '   FROM RN.VITREATY A,'
      '               RN.MIPAYMENT P,'
      '               S.MIISTFIN I'
      ' WHERE P.KOD = A.PAYMENT_KOD'
      '       AND I.KOD = A.ISTFIN_KOD'
      'AND TREATY_ID = :TREATY_ID')
    Optimize = False
    Variables.Data = {
      03000000010000000A0000003A5452454154595F494403000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      0400000017000000090000005452454154595F49440100000000000A00000054
      52454154595F4E554D0100000000000D0000005452454154595F535441545553
      0100000000000900000041475245454D5F49440100000000000A000000414752
      45454D5F4E554D010000000000080000004441544546524F4D01000000000006
      00000044415445544F0100000000000A00000049535446494E5F4B4F44010000
      000000070000005355424A4543540100000000000700000053554D4D50415901
      00000000000B0000005041594D454E545F4B4F440100000000000B0000004348
      41505445525F4B4F4401000000000009000000414E4E554C5F4B4F4401000000
      00000E000000455845435F53484F52544E414D45010000000000070000004649
      524D5F4E4F0100000000000B00000043555252454E43595F4E4F010000000000
      0D0000005041594D454E545F534E41494D0100000000000C0000004953544649
      4E5F534E41494D010000000000030000004E44530100000000000B0000004E44
      535F53554D4D50415901000000000009000000455845435F4E414D4501000000
      00001200000046495253545F594541525F53554D4D5041590100000000000E00
      00005448454D455F504C414E5F4E554D010000000000}
    Cursor = crSQLWait
    Master = quTreaty
    MasterFields = 'ID'
    DetailFields = 'TREATY_ID'
    ReadOnly = True
    UpdatingTable = 'RN.VITREATY'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1058#1077#1082'.'#1089#1086#1089#1090'.'
    LinkKind = lkIn
    EmbeddedSQLSlice.Strings = (
      '   FROM RN.VITREATY A,'
      '               RN.MIPAYMENT P,'
      '               S.MIISTFIN I'
      ' WHERE P.KOD = A.PAYMENT_KOD'
      '       AND I.KOD = A.ISTFIN_KOD'
      ''
      ' ')
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 372
    Top = 200
    object quCurrStateTREATY_ID: TFloatField
      FieldName = 'TREATY_ID'
      Origin = 'A.TREATY_ID'
      Required = True
      Visible = False
    end
    object quCurrStateTREATY_NUM: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      DisplayWidth = 11
      FieldName = 'TREATY_NUM'
      Required = True
      Size = 15
    end
    object quCurrStateTREATY_STATUS: TStringField
      FieldName = 'TREATY_STATUS'
      Required = True
      Visible = False
      Size = 1
    end
    object quCurrStateAGREEM_ID: TFloatField
      FieldName = 'AGREEM_ID'
      Required = True
      Visible = False
    end
    object quCurrStateAGREEM_NUM: TIntegerField
      FieldName = 'AGREEM_NUM'
      Required = True
      Visible = False
    end
    object quCurrStateDATEFROM: TDateTimeField
      FieldName = 'DATEFROM'
      Required = True
      Visible = False
    end
    object quCurrStateDATETO: TDateTimeField
      DisplayLabel = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090
      DisplayWidth = 11
      FieldName = 'DATETO'
      Required = True
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quCurrStateSUMMPAY: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090
      DisplayWidth = 12
      FieldName = 'SUMMPAY'
      Required = True
      DisplayFormat = '#,###,###,###,###,##0.##'
      EditFormat = '###############0.##'
    end
    object quCurrStateNDS: TFloatField
      DisplayLabel = #1053#1044#1057' %'
      DisplayWidth = 2
      FieldName = 'NDS'
      Origin = 'A.NDS'
    end
    object quCurrStateNDS_SUMMPAY: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1053#1044#1057
      FieldName = 'NDS_SUMMPAY'
      Origin = 'A.NDS_SUMMPAY'
      DisplayFormat = '#,###,###,###,###,##0.##'
      EditFormat = '###############0.##'
    end
    object quCurrStateISTFIN_KOD: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1080#1089#1090#1086#1095#1085#1080#1082#1072' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
      FieldName = 'ISTFIN_KOD'
      Origin = 'A.ISTFIN_KOD'
      Required = True
      Visible = False
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quCurrStateISTFIN_SNAIM: TStringField
      DisplayLabel = #1048#1089#1090#1086#1095#1085#1080#1082' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
      FieldName = 'ISTFIN_SNAIM'
    end
    object quCurrStatePAYMENT_KOD: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1090#1080#1087#1072' '#1086#1087#1083#1072#1090
      FieldName = 'PAYMENT_KOD'
      Required = True
      Visible = False
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quCurrStatePAYMENT_SNAIM: TStringField
      DisplayLabel = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099
      DisplayWidth = 8
      FieldName = 'PAYMENT_SNAIM'
      Required = True
    end
    object quCurrStateCHAPTER_KOD: TIntegerField
      FieldName = 'CHAPTER_KOD'
      Required = True
      Visible = False
    end
    object quCurrStateANNUL_KOD: TIntegerField
      FieldName = 'ANNUL_KOD'
      Visible = False
    end
    object quCurrStateEXEC_SHORTNAME: TStringField
      DisplayLabel = #1057#1086#1082#1088'.'#1085#1072#1080#1084'. '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      FieldName = 'EXEC_SHORTNAME'
      Required = True
    end
    object quCurrStateSUBJECT: TStringField
      DisplayLabel = #1058#1077#1084#1072
      DisplayWidth = 100
      FieldName = 'SUBJECT'
      Required = True
      Size = 1000
    end
    object quCurrStateFIRM_NO: TFloatField
      FieldName = 'FIRM_NO'
      Required = True
      Visible = False
    end
    object quCurrStateCURRENCY_NO: TIntegerField
      FieldName = 'CURRENCY_NO'
      Visible = False
    end
  end
  object odsCurrStage: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT/*+ ORDERED */'
      '       S.ID ID,'
      '       S.AGREEM_ID AGREEM_ID,'
      '       S.DATEFROM DATEFROM,'
      '       S.DATETO DATETO,'
      '       S.NUM NUM,'
      '       S.NAME NAME,'
      '       S.REPORTING REPORTING,'
      '       S.SUMMPAY ,'
      '       S.DATEACT DATEACT,'
      '       S.CUST_ACCOUNT_ID CUST_ACCOUNT_ID,'
      '       S.EXEC_ACCOUNT_ID EXEC_ACCOUNT_ID,'
      '       S.NUMACT NUMACT,'
      '       S.SPECIAL_WRITTEN SPECIAL_WRITTEN,'
      '       S.NDS NDS,'
      '       S.NDS_SUMMPAY NDS_SUMMPAY,'
      '       S.AKT_NO AKT_NO,'
      '       S.CREATE_AKT CREATE_AKT,'
      
        '       NVL(S.DATEPAY, DECODE(:typ, 3025, m.vns_pack.getpdmaxpdat' +
        'e(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id), d.doc_date' +
        '))) DATEPAY, -- '#1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1082#1080
      
        '--       NVL(S.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(decode(:typ' +
        ',3025,l2.doc_id,l.doc_id)), decode(:typ,3025,sw.doc_date,d.doc_d' +
        'ate))) DATEPAY, -- '#1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1082#1080
      
        '       NVL(S.NUMPAY, decode(:typ,3025,sw.doc_ext_no,d.doc_ext_no' +
        ')) NUMPAY,'
      
        '       NVL(S.PM_PMETHOD_NO, DECODE(decode(:typ,3025,sw.DOC_NO,d.' +
        'DOC_NO), NULL, NULL, DECODE(decode(:typ,3025,SW.DOC_TYPE,D.DOC_T' +
        'YPE), 3025, 1, 2))) PM_PMETHOD_NO,'
      
        '       (SELECT PM.PMETHOD_NAME FROM S.PAYMENT_METHODS PM where P' +
        'M.PMETHOD_NO = NVL(S.PM_PMETHOD_NO, DECODE(decode(:typ,3025,sw.D' +
        'OC_NO,d.DOC_NO), NULL, NULL, DECODE(decode(:typ,3025,SW.DOC_TYPE' +
        ',D.DOC_TYPE), 3025, 1, 2)))) PMETHOD_NAME,'
      
        '       DECODE(AGR.NUM,0,'#39#1044#1086#1075#1086#1074#1086#1088#39','#39#1044#1086#1087'.'#1089'. '#8470#39' || TO_CHAR(AGR.NUM)' +
        ') AGREEM_NAME,'
      '       AGR.NUM AGREEM_NUM,'
      '       VITREATY.TREATY_ID,'
      '       /* '#1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100' */'
      '       FA_EXEC.BANK_ACCOUNT EXEC_BANK_ACCOUNT,'
      '       F_EXEC.NAME EXEC_NAME,'
      '       /* '#1054#1089#1090#1072#1083#1100#1085#1086#1077' */'
      
        '--  DECODE(CURRENCY.CURRENCY_NO,933,NULL, DECODE(,)     EXCHANGE' +
        '_RATES.E_RATE ) E_RATE,'
      
        '--  TO_NUMBER(DECODE(CURRENCY.CURRENCY_NO,933,NULL,EXCHANGE_RATE' +
        'S.E_RATE*S.SUMMPAY)) SUMMPAY_RB,'
      
        'DECODE(CURRENCY.CURRENCY_NO, 933, NULL, DECODE(LEAST(EXCHANGE_RA' +
        'TES.INTRO_DATE,TO_DATE('#39'01.07.2016'#39','#39'dd.mm.yyyy'#39')),EXCHANGE_RATE' +
        'S.INTRO_DATE,'#39'0'#39'||EXCHANGE_RATES.E_RATE/10000,EXCHANGE_RATES.E_R' +
        'ATE)) E_RATE,'
      
        'TO_NUMBER(DECODE(CURRENCY.CURRENCY_NO, 933, NULL, DECODE(LEAST(E' +
        'XCHANGE_RATES.INTRO_DATE,TO_DATE('#39'01.07.2016'#39','#39'dd.mm.yyyy'#39')),EXC' +
        'HANGE_RATES.INTRO_DATE,EXCHANGE_RATES.E_RATE / 1000 * S.SUMMPAY,' +
        'EXCHANGE_RATES.E_RATE * S.SUMMPAY))) SUMMPAY_RB,'
      '       EXCHANGE_RATES.INTRO_DATE,'
      '       CURRENCY.CURRENCY_NO CURRENCY_NO,'
      '       CURRENCY.ISO_NAME CURRENCY_NAME,'
      '       SW.DOC_STAGE SW_STAGE'
      '  FROM RN.VITREATY,'
      '       RN.MNAGREEM AGR,'
      '       RN.MNSTAGE S,'
      '       S.FIRM_ACCOUNT FA_EXEC,'
      '       S.FIRM F_EXEC,'
      '       S.CURRENCY,'
      '       S.EXCHANGE_RATES,'
      '       M.DOCUMENTS SW,'
      '       M.vns_pd_div_lines l,'
      #9'M.vns_pd_div_lines l2,'
      '       M.documents d'
      ' WHERE AGR.TREATY_ID = VITREATY.TREATY_ID'
      '   AND CURRENCY.CURRENCY_NO = VITREATY.CURRENCY_NO'
      '   AND S.AGREEM_ID = AGR.ID'
      
        '   AND (   S.DATEACT IS NOT NULL AND AGR.NUM < VITREATY.AGREEM_N' +
        'UM -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR AGR.NUM = VITREATY.AGREEM_NUM)'
      '   AND FA_EXEC.BANK_ACCNT_ID(+) = S.EXEC_ACCOUNT_ID'
      '   AND F_EXEC.FIRM_NO(+) = FA_EXEC.FIRM_NO'
      '   AND CURRENCY.CURRENCY_NO(+) = VITREATY.CURRENCY_NO'
      '   AND EXCHANGE_RATES.CURRENCY_NO = VITREATY.CURRENCY_NO'
      
        '   AND EXCHANGE_RATES.INTRO_DATE = (SELECT NVL(MAX(ER.INTRO_DATE' +
        '),TO_DATE('#39'04.01.2000'#39','#39'DD.MM.YYYY'#39'))'
      '                                      FROM S.EXCHANGE_RATES ER'
      
        '                                     WHERE (S.DATEACT IS NOT NUL' +
        'L AND ER.INTRO_DATE <= S.DATEACT'
      '                                            OR S.DATEACT IS NULL'
      
        '                                               AND ER.INTRO_DATE' +
        ' <= (SELECT NVL(MAX(DATEACT),VITREATY.DATEFROM)'
      
        '                                                                ' +
        '       FROM RN.MNSTAGE ST1,'
      
        '                                                                ' +
        '            RN.MNAGREEM AGR1'
      
        '                                                                ' +
        '      WHERE AGR1.TREATY_ID = AGR.TREATY_ID'
      
        '                                                                ' +
        '        AND ST1.AGREEM_ID = AGR1.ID'
      
        '                                                                ' +
        '     )'
      '                                           )'
      
        '                                       AND ER.CURRENCY_NO = VITR' +
        'EATY.CURRENCY_NO) -- '#1050#1091#1088#1089' '#1085#1072' '#1076#1072#1090#1091' '#1072#1082#1090#1072' '#1080#1083#1080' '#1085#1072' '#1073#1086#1083#1077#1077' '#1088#1072#1085#1085#1102#1102
      '  AND VITREATY.TREATY_ID= :TREATY_ID'
      '  AND SW.DOC_NO(+) = s.SPECIAL_WRITTEN'
      '  AND l.sw_id(+) = SW.DOC_NO'
      '  and l.doc_id = d.doc_no(+)'
      '  and l2.doc_id(+) = SW.DOC_NO'
      ' AND SW.DOC_TYPE(+) not in (3005,3009)'
      ' AND d.doc_type(+) not in (3005, 3009)'
      ''
      'ORDER BY S.NUM ASC')
    Optimize = False
    Variables.Data = {
      03000000020000000A0000003A5452454154595F494404000000000000000000
      0000040000003A5459500300000004000000FE01000000000000}
    QBEDefinition.QBEFieldDefs = {
      04000000200000000200000049440100000000000900000041475245454D5F49
      44010000000000080000004441544546524F4D01000000000006000000444154
      45544F010000000000030000004E554D010000000000040000004E414D450100
      00000000090000005245504F5254494E470100000000000700000053554D4D50
      41590100000000000700000044415445504159010000000000060000004E554D
      50415901000000000007000000444154454143540100000000000D000000504D
      5F504D4554484F445F4E4F0100000000000F000000435553545F4143434F554E
      545F49440100000000000F000000455845435F4143434F554E545F4944010000
      000000060000004E554D414354010000000000090000005452454154595F4944
      0100000000000C000000504D4554484F445F4E414D4501000000000011000000
      455845435F42414E4B5F4143434F554E5401000000000009000000455845435F
      4E414D450100000000000A000000494E54524F5F444154450100000000000D00
      000043555252454E43595F4E414D450100000000000A00000053554D4D504159
      5F524201000000000006000000455F524154450100000000000B000000414752
      45454D5F4E414D450100000000000A00000041475245454D5F4E554D01000000
      00000F0000005350454349414C5F5752495454454E010000000000030000004E
      44530100000000000B0000004E44535F53554D4D504159010000000000060000
      00414B545F4E4F0100000000000A0000004352454154455F414B540100000000
      000800000053575F53544147450100000000000B00000043555252454E43595F
      4E4F010000000000}
    Master = quCurrState
    MasterFields = 'TREATY_ID'
    DetailFields = 'TREATY_ID'
    Session = seOracle
    Left = 96
    Top = 448
    object odsCurrStageID: TFloatField
      FieldName = 'ID'
      Required = True
      Visible = False
    end
    object odsCurrStageTREATY_ID: TFloatField
      FieldName = 'TREATY_ID'
      Required = True
      Visible = False
    end
    object odsCurrStageAGREEM_ID: TFloatField
      FieldName = 'AGREEM_ID'
      Required = True
      Visible = False
    end
    object odsCurrStageNUM: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1101#1090#1072#1087#1072
      DisplayWidth = 9
      FieldName = 'NUM'
      Size = 10
    end
    object odsCurrStageDATEFROM: TDateTimeField
      DisplayLabel = #1053#1072#1095#1072#1083#1086
      DisplayWidth = 7
      FieldName = 'DATEFROM'
      Required = True
      DisplayFormat = 'mm.yyyy'
      EditMask = '!\0\1/99/00;1;_'
    end
    object odsCurrStageDATETO: TDateTimeField
      DisplayLabel = #1054#1082#1086#1085#1095#1072#1085#1080#1077
      DisplayWidth = 7
      FieldName = 'DATETO'
      Required = True
      DisplayFormat = 'mm.yyyy'
      EditMask = '!\0\1/99/00;1;_'
    end
    object odsCurrStageAGREEM_NAME: TStringField
      DisplayLabel = #1057#1086#1075#1083#1072#1096#1077#1085#1080#1077
      DisplayWidth = 10
      FieldName = 'AGREEM_NAME'
      Size = 48
    end
    object odsCurrStageSUMMPAY: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1101#1090#1072#1087#1072
      DisplayWidth = 13
      FieldName = 'SUMMPAY'
      DisplayFormat = '#,###,###,###,###,##0.##'
      EditFormat = '###############0.##'
    end
    object odsCurrStageSUMMPAY_RB: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1074' '#1073#1077#1083'.'#1088#1091#1073
      DisplayWidth = 13
      FieldName = 'SUMMPAY_RB'
      DisplayFormat = '#,###,###,###,###,##0.00'
      EditFormat = '###############0.##'
    end
    object odsCurrStageE_RATE: TStringField
      DisplayLabel = #1050#1091#1088#1089
      DisplayWidth = 7
      FieldName = 'E_RATE'
      Size = 40
    end
    object odsCurrStageCURRENCY_NO: TIntegerField
      FieldName = 'CURRENCY_NO'
      Required = True
      Visible = False
    end
    object odsCurrStageCURRENCY_NAME: TStringField
      DisplayLabel = #1042#1072#1083#1102#1090#1072
      FieldName = 'CURRENCY_NAME'
      Size = 3
    end
    object odsCurrStageINTRO_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1082#1091#1088#1089#1072
      DisplayWidth = 11
      FieldName = 'INTRO_DATE'
      Required = True
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!\0\1/99/00;1;_'
    end
    object odsCurrStageDATEACT: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1072#1082#1090#1072' '#1074#1099#1087'-'#1103
      DisplayWidth = 11
      FieldName = 'DATEACT'
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!\0\1/99/00;1;_'
    end
    object odsCurrStageNUMACT: TIntegerField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1072#1082#1090#1072' '#1089#1076#1072#1095#1080
      DisplayWidth = 2
      FieldName = 'NUMACT'
    end
    object odsCurrStageDATEPAY: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
      DisplayWidth = 10
      FieldName = 'DATEPAY'
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object odsCurrStageNUMPAY: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1087#1083#1072#1090#1077#1078#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      DisplayWidth = 20
      FieldName = 'NUMPAY'
      Size = 100
    end
    object odsCurrStagePMETHOD_NAME: TStringField
      DisplayLabel = #1052#1077#1090#1086#1076' '#1086#1087#1083#1072#1090#1099
      DisplayWidth = 19
      FieldKind = fkInternalCalc
      FieldName = 'PMETHOD_NAME'
      Size = 100
    end
    object odsCurrStagePM_PMETHOD_NO: TFloatField
      DisplayLabel = #1050#1086#1076' '#1086#1087#1083#1072#1090#1099
      DisplayWidth = 3
      FieldName = 'PM_PMETHOD_NO'
      DisplayFormat = '000'
      EditFormat = '000'
    end
    object odsCurrStageCUST_ACCOUNT_ID: TFloatField
      DisplayLabel = 'ID '#1089#1095#1077#1090#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
      FieldName = 'CUST_ACCOUNT_ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object odsCurrStageEXEC_ACCOUNT_ID: TFloatField
      DisplayLabel = 'ID '#1089#1095#1077#1090#1072' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      FieldName = 'EXEC_ACCOUNT_ID'
      Visible = False
      DisplayFormat = '#########0'
      EditFormat = '#########0'
    end
    object odsCurrStageEXEC_BANK_ACCOUNT: TStringField
      DisplayLabel = #1057#1095#1077#1090' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
      DisplayWidth = 16
      FieldName = 'EXEC_BANK_ACCOUNT'
      Size = 35
    end
    object odsCurrStageEXEC_NAME: TStringField
      DisplayLabel = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
      DisplayWidth = 70
      FieldName = 'EXEC_NAME'
      Size = 120
    end
    object odsCurrStageNAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1101#1090#1072#1087#1072
      DisplayWidth = 100
      FieldName = 'NAME'
      Size = 2000
    end
    object odsCurrStageREPORTING: TStringField
      DisplayLabel = #1054#1090#1095#1077#1090#1085#1086#1089#1090#1100' '#1087#1086' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084' '#1088#1072#1073#1086#1090#1099
      DisplayWidth = 100
      FieldName = 'REPORTING'
      Size = 1000
    end
    object odsCurrStageAGREEM_NUM: TIntegerField
      FieldName = 'AGREEM_NUM'
      Required = True
      Visible = False
    end
    object odsCurrStageSW_STAGE: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'SW_STAGE'
      Visible = False
      Size = 2
    end
    object odsCurrStageSPECIAL_WRITTEN: TStringField
      FieldName = 'SPECIAL_WRITTEN'
      Visible = False
      Size = 30
    end
    object odsCurrStageNDS: TFloatField
      FieldName = 'NDS'
      Visible = False
    end
    object odsCurrStageNDS_SUMMPAY: TFloatField
      FieldName = 'NDS_SUMMPAY'
      Visible = False
    end
    object odsCurrStageAKT_NO: TStringField
      FieldName = 'AKT_NO'
      Visible = False
      Size = 30
    end
    object odsCurrStageCREATE_AKT: TDateTimeField
      FieldName = 'CREATE_AKT'
      Visible = False
    end
  end
  object odsSummpayYear: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT/*+ ORDERED */'
      '       VITREATY.TREATY_ID,'
      
        '       TRUNC(DECODE(S.DATEACT,NULL,S.DATETO,S.DATEACT),'#39'YYYY'#39') R' +
        'EP_YEAR,'
      '       SUM(S.SUMMPAY) SUMMPAY,'
      
        '       SUM(TO_NUMBER(DECODE(CURRENCY.CURRENCY_NO,933,NULL,EXCHAN' +
        'GE_RATES.E_RATE*S.SUMMPAY))) SUMMPAY_RB'
      '  FROM RN.VITREATY,'
      '       RN.MNAGREEM AGR,'
      '       RN.MNSTAGE S,'
      '       RN.PAYMENT_METHODS PM,'
      '       S.FIRM_ACCOUNT FA_EXEC,'
      '       S.FIRM F_EXEC,'
      '       S.CURRENCY,'
      '       S.EXCHANGE_RATES'
      ' WHERE AGR.TREATY_ID = VITREATY.TREATY_ID'
      '   AND CURRENCY.CURRENCY_NO = VITREATY.CURRENCY_NO'
      '   AND S.AGREEM_ID = AGR.ID'
      
        '   AND (   S.DATEACT IS NOT NULL AND AGR.NUM < VITREATY.AGREEM_N' +
        'UM -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR AGR.NUM = VITREATY.AGREEM_NUM)'
      '   AND PM.PMETHOD_NO(+) = S.PM_PMETHOD_NO'
      '   AND FA_EXEC.BANK_ACCNT_ID(+) = S.EXEC_ACCOUNT_ID'
      '   AND F_EXEC.FIRM_NO(+) = FA_EXEC.FIRM_NO'
      '   AND CURRENCY.CURRENCY_NO(+) = VITREATY.CURRENCY_NO'
      '   AND EXCHANGE_RATES.CURRENCY_NO = VITREATY.CURRENCY_NO'
      
        '   AND EXCHANGE_RATES.INTRO_DATE = (SELECT NVL(MAX(ER.INTRO_DATE' +
        '),TO_DATE('#39'04.01.2000'#39','#39'DD.MM.YYYY'#39'))'
      '                                      FROM S.EXCHANGE_RATES ER'
      
        '                                     WHERE (S.DATEACT IS NOT NUL' +
        'L AND ER.INTRO_DATE <= S.DATEACT'
      '                                            OR S.DATEACT IS NULL'
      
        '                                               AND ER.INTRO_DATE' +
        ' <= (SELECT NVL(MAX(DATEACT),VITREATY.DATEFROM)'
      
        '                                                                ' +
        '       FROM RN.MNSTAGE ST1,'
      
        '                                                                ' +
        '            RN.MNAGREEM AGR1'
      
        '                                                                ' +
        '      WHERE AGR1.TREATY_ID = AGR.TREATY_ID'
      
        '                                                                ' +
        '        AND ST1.AGREEM_ID = AGR1.ID'
      
        '                                                                ' +
        '     )'
      '                                           )'
      
        '                                       AND ER.CURRENCY_NO = VITR' +
        'EATY.CURRENCY_NO) -- '#1050#1091#1088#1089' '#1085#1072' '#1076#1072#1090#1091' '#1072#1082#1090#1072' '#1080#1083#1080' '#1085#1072' '#1073#1086#1083#1077#1077' '#1088#1072#1085#1085#1102#1102
      '  AND VITREATY.TREATY_ID= :TREATY_ID'
      ' GROUP BY VITREATY.TREATY_ID,'
      
        '          TRUNC(DECODE(S.DATEACT,NULL,S.DATETO,S.DATEACT),'#39'YYYY'#39 +
        ')'
      ' ORDER BY REP_YEAR'
      ' '
      ' ')
    Optimize = False
    Variables.Data = {
      03000000010000000A0000003A5452454154595F494404000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      0400000004000000090000005452454154595F49440100000000000800000052
      45505F594541520100000000000700000053554D4D5041590100000000000A00
      000053554D4D5041595F5242010000000000}
    Master = quCurrState
    MasterFields = 'TREATY_ID'
    DetailFields = 'TREATY_ID'
    Session = seOracle
    Left = 99
    Top = 398
    object odsSummpayYearREP_YEAR: TDateTimeField
      DisplayLabel = #1043#1086#1076
      DisplayWidth = 7
      FieldName = 'REP_YEAR'
      DisplayFormat = 'yyyy'
    end
    object odsSummpayYearSUMMPAY: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072
      DisplayWidth = 11
      FieldName = 'SUMMPAY'
      DisplayFormat = '#,###,###,###,###,##0.00'
    end
    object odsSummpayYearSUMMPAY_RB: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072' '#1074' '#1073#1077#1083'.'#1088'.'
      DisplayWidth = 11
      FieldName = 'SUMMPAY_RB'
      DisplayFormat = '#,###,###,###,###,##0.00'
    end
  end
  object quRN05_RN06_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id,'
      '       vitreaty.treaty_num,'
      '       TO_NUMBER(TO_CHAR(vi_all.months,'#39'MM'#39')),'
      '       vi_all.stage_summpay_RB,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty'
      '  FROM (SELECT mntreaty.id treaty_id,'
      '               TRUNC(st.dateact,'#39'MM'#39') months,'
      
        '               SUM(exchange_rates.e_rate*st.summpay) stage_summp' +
        'ay_RB'
      '          FROM RN.mntreaty,'
      '               RN.mnstage st,'
      '               RN.mnagreem agr,'
      '               S.firm_account,'
      '               S.firm,'
      '               S.exchange_rates'
      '          WHERE st.dateact BETWEEN :v_datefrom'
      '                               AND LAST_DAY(:v_dateto)'
      '           AND agr.id = st.agreem_id'
      '           AND agr.istfin_kod = :v_istfin_kod'
      '           AND firm_account.bank_accnt_id = st.exec_account_id'
      '           AND firm.firm_no = firm_account.firm_no'
      
        '           AND exchange_rates.currency_no = firm_account.currenc' +
        'y_no'
      
        '           AND exchange_rates.intro_date = (SELECT MAX(er.intro_' +
        'date)'
      
        '                                              FROM S.exchange_ra' +
        'tes er'
      
        '                                             WHERE er.intro_date' +
        ' <= st.dateact'
      
        '                                               AND er.currency_n' +
        'o = firm_account.currency_no)'
      '           AND mntreaty.id = agr.treaty_id'
      '         GROUP BY'
      '               mntreaty.id,'
      '               TRUNC(st.dateact,'#39'MM'#39')'
      '       ) vi_all,'
      '       RN.vitreaty'
      ' WHERE vitreaty.treaty_id = vi_all.treaty_id(+)'
      ''
      '   AND vitreaty.treaty_status NOT IN ('#39'A'#39', '#39'P'#39')'
      '   AND (   (vitreaty.treaty_status = '#39'O'#39')'
      
        '        OR (vitreaty.treaty_status <> '#39'O'#39' AND  TRUNC(vitreaty.DA' +
        'TETO, '#39'YEAR'#39') >= TRUNC(:V_DATEFROM, '#39'YEAR'#39')))'
      
        '   AND TRUNC(vitreaty.DATEFROM, '#39'MONTH'#39') <= TRUNC(:V_DATETO, '#39'MO' +
        'NTH'#39')'
      ''
      
        '   AND ((:CONC IS NULL) OR (:CONC = RN.mitrconcern_pkg.GetConcDo' +
        'gForInnavDog(:V_DATETO, vitreaty.DATEFROM, vitreaty.DATETO)))'
      
        '   --AND ((:CONC_DATETO IS NULL) OR (TRUNC(vitreaty.datefrom, '#39'M' +
        'ONTH'#39') <= :CONC_DATETO))'
      
        '   --AND ((:CONC_DATEFROM IS NULL) OR (TRUNC(vitreaty.datefrom, ' +
        #39'MONTH'#39') >= :CONC_DATEFROM))'
      '   AND vitreaty.treaty_id IN (SELECT a.treaty_id'
      '                                FROM RN.mnagreem a,'
      '                                     RN.mnstage s'
      
        '                               WHERE a.treaty_id = vitreaty.trea' +
        'ty_id'
      '                                 AND s.agreem_id = a.id'
      
        '                                 AND (   s.dateact BETWEEN :v_da' +
        'tefrom'
      
        '                                                       AND LAST_' +
        'DAY(:v_dateto)'
      
        '                                      OR vitreaty.agreem_num = a' +
        '.num'
      '                                     )'
      
        '                                 AND a.istfin_kod = :v_istfin_ko' +
        'd'
      '                             )'
      ' ORDER BY vitreaty.treaty_num,'
      '          vitreaty.treaty_id,'
      '          vi_all.months'
      ''
      ''
      ''
      ' '
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      03000000040000000B0000003A565F4441544546524F4D0C0000000000000000
      000000090000003A565F44415445544F0C00000000000000000000000D000000
      3A565F49535446494E5F4B4F44030000000000000000000000050000003A434F
      4E43030000000000000000000000}
    Left = 16
    Top = 171
  end
  object quCurators: TOracleQuery
    SQL.Strings = (
      'SELECT /*+ ORDERED*/'
      '       vitreaty.treaty_id,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name name,'
      '       vitreaty.subject,'
      '       TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39'),'
      '       TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39'),'
      '       vitreaty.summpay,'
      '       vitreaty.currency_no,'
      '       vitreaty.treaty_status,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       --exchange_rates.e_rate,'
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         vitreaty.datefrom)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      
        '       RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.currency_n' +
        'o,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         ) into_date,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      '       st.dateact,'
      '       st.datefrom stage_datefrom,'
      '       st.dateto stage_dateto,'
      '       currency.iso_name currency_name,'
      
        '       rab.FNAIM || '#39' '#39' || DECODE(rab.INAIM, NULL, NULL, SUBSTR(' +
        'rab.INAIM, 1, 1) || '#39'.'#39' || DECODE(rab.ONAIM, NULL, NULL, SUBSTR(' +
        'rab.ONAIM, 1, 1) || '#39'.'#39')) curator,'
      
        '       decode(vitreaty.istfin_kod, 2, vitreaty.theme_plan_num, v' +
        'itreaty.treaty_id) num,'
      '       vitreaty.istfin_kod istfin_kod,'
      
        '       decode(vitreaty.istfin_kod, 2, RN.MITRCONCERN_PKG.getconc' +
        'dogforinnavdog(TRUNC(:v_date, '#39'YEAR'#39'), vitreaty.datefrom, vitrea' +
        'ty.dateto), NULL) ConcDogID,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treatys'
      '  FROM RN.vitreaty,'
      '       RN.mnagreem agr,'
      '       RN.mnstage st,'
      '       S.currency,'
      '       RN.mntrcurator curator,'
      '       P.mirab rab/*,'
      '       E.exchange_rates*/'
      ' WHERE (   (vitreaty.treaty_status = '#39'O'#39')'
      
        '        OR (vitreaty.treaty_status <> '#39'O'#39' AND  TRUNC(vitreaty.da' +
        'teto, '#39'YEAR'#39') >= TRUNC(:v_date, '#39'YEAR'#39')))'
      '   AND vitreaty.TREATY_STATUS <> '#39'P'#39
      
        '   AND TRUNC(vitreaty.datefrom, '#39'YEAR'#39') <= TRUNC(:v_date, '#39'YEAR'#39 +
        ')'
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND currency.currency_no = vitreaty.currency_no'
      '   AND vitreaty.treaty_id = curator.TREATY_ID(+)'
      '   AND curator.MIRAB_TABN = rab.TABN(+)'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      '   /*AND exchange_rates.currency_no = vitreaty.currency_no'
      
        '   AND exchange_rates.intro_date = (SELECT NVL(MAX(er.intro_date' +
        '),TO_DATE('#39'04.01.2000'#39','#39'DD.MM.YYYY'#39'))'
      '                                      FROM S.exchange_rates er'
      
        '                                     WHERE (st.dateact IS NOT NU' +
        'LL AND er.intro_date <= st.dateact'
      
        '                                            OR st.dateact IS NUL' +
        'L'
      
        '                                               AND er.intro_date' +
        ' <= (SELECT NVL(MAX(dateact),vitreaty.datefrom)'
      
        '                                                                ' +
        '       FROM RN.mnstage st1,'
      
        '                                                                ' +
        '            RN.mnagreem agr1'
      
        '                                                                ' +
        '      WHERE agr1.treaty_id = agr.treaty_id'
      
        '                                                                ' +
        '        AND st1.agreem_id = agr1.id'
      
        '                                                                ' +
        '     )'
      '                                           )'
      
        '                                       AND er.currency_no = vitr' +
        'eaty.currency_no) -- '#1050#1091#1088#1089' '#1085#1072' '#1076#1072#1090#1091' '#1072#1082#1090#1072' '#1080#1083#1080' '#1085#1072' '#1073#1086#1083#1077#1077' '#1088#1072#1085#1085#1102#1102'*/'
      ' ORDER BY vitreaty.istfin_kod desc,'
      
        '          decode(vitreaty.istfin_kod, 2, RN.MITRCONCERN_PKG.getc' +
        'oncdogforinnavdog(TRUNC(:v_date, '#39'YEAR'#39'), vitreaty.datefrom, vit' +
        'reaty.dateto), NULL),'
      '          rab.FNAIM,'
      '          rab.INAIM,'
      '          rab.ONAIM,'
      
        '          decode(vitreaty.istfin_kod, 2, vitreaty.theme_plan_num' +
        ', vitreaty.treaty_id),'
      '          vitreaty.treaty_id')
    Session = seOracle
    Optimize = False
    Variables.Data = {0300000001000000070000003A565F444154450C0000000000000000000000}
    Left = 264
    Top = 228
  end
  object quRN04_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT tr.id id,'
      '       tr.num  name,'
      '       tr.subject subject,'
      '       TO_CHAR(tr.datefrom,'#39'MM.YYYY'#39') datefrom,'
      '       TO_CHAR(agr_num.dateto,'#39'MM.YYYY'#39') dateto,'
      '       agr_num.summpay summpay,'
      '       fa.currency_no currency_no,'
      '       tr.status status,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       --exchange_rates.e_rate,'
      '       DECODE(fa.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(fa.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         tr.datefrom)'
      '                  AND er.CURRENCY_NO = fa.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      '       RN.MONEY_PKG.getdateofexchangeofstage(fa.currency_no,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          tr.datefrom'
      '                                         ) into_date,'
      '       COUNT(tr.id) OVER (PARTITION BY tr.id) count_per_treaty,'
      '       st.dateact,'
      '       st.datefrom stage_datefrom,'
      '       st.dateto stage_dateto,'
      '       currency.iso_name currency_name,'
      '       decode(agr.istfin_kod, 2, tr.theme_plan_num, tr.id) num,'
      '       firm.name exec_name,'
      '       COUNT(DISTINCT tr.id) OVER (PARTITION BY 1) count_treaty'
      '  FROM RN.mnagreem agr,'
      '       RN.mntreaty tr,'
      '       RN.mnstage st,'
      '       S.currency,'
      '       RN.MNAGREEM agr_num,'
      '       firm_account fa,'
      '       firm'
      ' WHERE agr.istfin_kod = 1 -- '#1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072
      '   AND tr.status NOT IN ('#39'A'#39', '#39'P'#39')'
      '   AND (   (tr.status = '#39'O'#39')'
      
        '        OR (tr.status <> '#39'O'#39' AND  TRUNC(agr_num.dateto, '#39'YEAR'#39') ' +
        '>= TRUNC(:V_DATE, '#39'YEAR'#39')))'
      '   AND TRUNC(tr.datefrom, '#39'YEAR'#39') <= TRUNC(:V_DATE, '#39'YEAR'#39')'
      '   AND TRUNC(:V_DATE, '#39'MONTH'#39') >= TRUNC(tr.datesign, '#39'MONTH'#39')'
      '   AND agr.treaty_id = tr.id'
      '   AND currency.currency_no = fa.currency_no'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   (st.dateact IS NOT NULL AND agr.num < agr_num.num) --' +
        ' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = agr_num.num)'
      '   AND agr_num.treaty_id = tr.id'
      '   AND agr_num.num = DECODE(:CURR_AGR, 0, (SELECT MAX(agr1.num)'
      '                                             FROM mnagreem agr1'
      
        '                                            WHERE agr1.treaty_id' +
        ' = agr_num.treaty_id),'
      '                                       1, (SELECT MAX(agr1.num)'
      '                                             FROM mnagreem agr1'
      
        '                                            WHERE agr1.treaty_id' +
        ' = agr_num.treaty_id'
      
        '                                              AND TRUNC(:V_DATE,' +
        ' '#39'MONTH'#39') >= TRUNC(agr1.DATESIGN, '#39'MONTH'#39') ))'
      '   AND fa.bank_accnt_id(+) = tr.exec_account_id'
      '   AND firm.firm_no(+) = fa.firm_no'
      ' ORDER BY tr.id'
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000002000000070000003A565F444154450C000000000000000000000009
      0000003A435552525F414752030000000000000000000000}
    Left = 264
    Top = 114
  end
  object quRN07_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id treaty_id,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name num,'
      '       vitreaty.subject,'
      '       TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') DATEFROM,'
      '       TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') DATETO,'
      '       vitreaty.summpay TREATY_SUMMPAY,'
      '       vitreaty.currency_no CURRENCY_NO,'
      '       vitreaty.treaty_status STATUS,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       --exchange_rates.e_rate,'
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         vitreaty.datefrom)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      
        '       RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.currency_n' +
        'o,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         ) into_date,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      '       st.dateact dateact,'
      '       st.datefrom stage_datefrom,'
      '       st.dateto stage_dateto,'
      '       currency.iso_name currency_name,'
      '       /*(SELECT NVL(concern.DOG_ID, concern.ID)'
      '         FROM RN.mitrconcern concern'
      
        '        WHERE (  (st.dateact IS NOT NULL AND st.dateact BETWEEN ' +
        'concern.DATEFROM AND concern.DATETO)'
      '               OR'
      
        '                  (st.dateact IS NULL     AND st.dateto BETWEEN ' +
        'concern.DATEFROM AND concern.DATETO)'
      '               )'
      '       ) concern_dog, -- '#1076#1086#1075#1086#1074#1086#1088' '#1089' '#1082#1086#1085#1094#1077#1088#1085#1086#1084
      '       */'
      '       TO_CHAR(vitreaty.datefrom, '#39'YYYY'#39') DATEFROM_YEAR,'
      
        '       decode(agr.istfin_kod, 2, vitreaty.theme_plan_num, vitrea' +
        'ty.treaty_id) rep_num,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty'
      '  FROM RN.vitreaty,'
      '       RN.mnagreem agr,'
      '       RN.mnstage st,'
      '       S.currency--,'
      '       --S.exchange_rates'
      ' WHERE (   (vitreaty.treaty_status =  '#39'O'#39')'
      
        '        OR (vitreaty.treaty_status <> '#39'O'#39' AND  vitreaty.dateto >' +
        '= TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy'#39')))'
      ''
      
        '   AND vitreaty.datefrom < TO_DATE('#39'01.01.'#39' || (:YEAR + 1), '#39'dd.' +
        'mm.yyyy'#39')'
      '   AND vitreaty.istfin_kod = 2 -- '#1048#1085#1085#1086#1074#1072#1094#1080#1086#1085#1085#1099#1081' '#1092#1086#1085#1076
      '   AND vitreaty.TREATY_STATUS NOT IN ('#39'A'#39', '#39'P'#39')'
      
        '   --AND ((:CONC_DATETO IS NULL) OR (vitreaty.datefrom <= :CONC_' +
        'DATETO))'
      
        '   --AND ((:CONC_DATEFROM IS NULL) OR (vitreaty.datefrom >= :CON' +
        'C_DATEFROM))'
      
        '   AND :CONC = RN.mitrconcern_pkg.GetConcDogForInnavDog(TO_DATE(' +
        #39'01.12.'#39' || :YEAR, '#39'dd.mm.yyyy'#39'), vitreaty.DATEFROM, vitreaty.DA' +
        'TETO)'
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      ''
      '   AND currency.currency_no = vitreaty.currency_no'
      '   /*AND exchange_rates.currency_no = vitreaty.currency_no'
      
        '   AND exchange_rates.intro_date = (SELECT NVL(MAX(er.intro_date' +
        '),TO_DATE('#39'04.01.2000'#39','#39'DD.MM.YYYY'#39'))'
      '                                      FROM S.exchange_rates er'
      
        '                                     WHERE (st.dateact IS NOT NU' +
        'LL AND er.intro_date  <= st.dateact'
      
        '                                            OR st.dateact IS NUL' +
        'L'
      
        '                                               AND er.intro_date' +
        ' <= (SELECT  NVL(MAX(dateact),vitreaty.datefrom)'
      
        '                                                                ' +
        '       FROM RN.mnstage st1,'
      
        '                                                                ' +
        '            RN.mnagreem agr1'
      
        '                                                                ' +
        '      WHERE agr1.treaty_id = agr.treaty_id'
      
        '                                                                ' +
        '        AND st1.agreem_id = agr1.id'
      
        '                                                                ' +
        '     )'
      '                                           )'
      
        '                                       AND er.currency_no = vitr' +
        'eaty.currency_no) -- '#1050#1091#1088#1089' '#1085#1072' '#1076#1072#1090#1091' '#1072#1082#1090#1072' '#1080#1083#1080' '#1085#1072' '#1073#1086#1083#1077#1077' '#1088#1072#1085#1085#1102#1102'*/'
      
        ' ORDER BY decode(agr.istfin_kod, 2, vitreaty.theme_plan_num, vit' +
        'reaty.treaty_id), vitreaty.treaty_id'
      ' '
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000002000000050000003A59454152030000000000000000000000050000
      003A434F4E43030000000000000000000000}
    Left = 99
    Top = 171
  end
  object quMitrconc_agr: TVASUPQuery
    SQL.Strings = (
      'SELECT A.*,A.ROWID FROM RN.MITRCONCERN A'
      '/* END_REFRESH */'
      'WHERE DOG_ID = :DOG_ID')
    Optimize = False
    Variables.Data = {0300000001000000070000003A444F475F4944030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000008000000020000004944010000000000030000004E554D0100000000
      0008000000444154455349474E010000000000080000004441544546524F4D01
      00000000000600000044415445544F01000000000006000000444F475F494401
      000000000009000000444F475F4C494D4954010000000000040000004E414D45
      010000000000}
    Master = quMitrconcern
    MasterFields = 'ID'
    DetailFields = 'DOG_ID'
    UpdatingTable = 'RN.MITRCONCERN'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1044#1086#1087'. '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1103
    Order = 'DATESIGN ASC'
    AccessLevel = [aqQuerying, aqInserting, aqEditing, aqDeleting]
    LinkKind = lkIn
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 320
    Top = 66
    object quMitrconc_agrNUM: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088
      FieldName = 'NUM'
      Required = True
      Size = 15
    end
    object quMitrconc_agrDATESIGN: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1087#1086#1076#1087#1080#1089#1072#1085#1080#1103
      FieldName = 'DATESIGN'
      Required = True
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object quMitrconc_agrDATEFROM: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1076#1077#1081#1089#1090#1074#1080#1103
      FieldName = 'DATEFROM'
      Required = True
      OnChange = RR_DateFormat
      DisplayFormat = 'mm.yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object quMitrconc_agrDATETO: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1076#1077#1081#1089#1090#1074#1080#1103
      FieldName = 'DATETO'
      Required = True
      OnChange = RR_DateFormat
      DisplayFormat = 'dd.mm.yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object quMitrconc_agrDOG_ID: TFloatField
      Tag = 2
      FieldName = 'DOG_ID'
      Visible = False
    end
    object quMitrconc_agrNAME: TStringField
      Tag = 2
      FieldName = 'NAME'
      Visible = False
      Size = 600
    end
  end
  object odsYearConcReport: TOracleDataSet
    SQL.Strings = (
      'SELECT'
      '       vitreaty.treaty_num  treaty_num'
      ''
      '  FROM RN.vitreaty'
      
        ' WHERE vitreaty.dateto  >= TO_DATE('#39'01.01.'#39' || (:YEAR + 1), '#39'dd.' +
        'mm.yyyy'#39')'
      
        '   AND vitreaty.datefrom < TO_DATE('#39'01.01.'#39' || (:YEAR + 1), '#39'dd.' +
        'mm.yyyy'#39')'
      '   AND vitreaty.istfin_kod = 2 -- '#1048#1085#1085#1086#1074#1072#1094#1080#1086#1085#1085#1099#1081' '#1092#1086#1085#1076
      
        '   --AND ((:CONC_DATETO IS NULL) OR (vitreaty.datefrom <= :CONC_' +
        'DATETO))'
      
        '   --AND ((:CONC_DATEFROM IS NULL) OR (vitreaty.datefrom >= :CON' +
        'C_DATEFROM))'
      
        '   AND :CONC = RN.mitrconcern_pkg.GetConcDogForInnavDog(TO_DATE(' +
        #39'01.12.'#39' || :YEAR, '#39'dd.mm.yyyy'#39'), vitreaty.DATEFROM, vitreaty.DA' +
        'TETO)'
      '   /*AND EXISTS (SELECT *'
      '                 FROM RN.mitrconcern'
      
        '                WHERE mitrconcern.DATEFROM < TO_DATE('#39'01.01.'#39' ||' +
        ' (:YEAR + 1), '#39'dd.mm.yyyy'#39')'
      
        '                  AND mitrconcern.DATETO  >= TO_DATE('#39'01.01.'#39' ||' +
        ' :YEAR, '#39'dd.mm.yyyy'#39')'
      '                  AND (   (vitreaty.treaty_status =  '#39'C'#39')'
      
        '                       OR (vitreaty.treaty_status <> '#39'C'#39' AND  vi' +
        'treaty.dateto >= mitrconcern.datefrom)'
      '                      )'
      '                  AND vitreaty.datefrom <= mitrconcern.DATETO'
      
        '              )  -- '#1055#1056#1086#1074#1077#1088#1103#1077#1084' '#1087#1086' '#1087#1072#1076#1072#1102#1090' '#1083#1080' '#1076#1086#1075#1086#1074#1086#1088' '#1074' '#1089#1088#1086#1082' '#1076#1077#1081#1089#1090#1074 +
        #1080#1103' '#1089' '#1076#1086#1075#1086#1074#1086#1088#1072#1084#1080' '#1089' '#1082#1086#1085#1094#1077#1088#1085#1086#1084
      '     */'
      ' ORDER BY vitreaty.treaty_id'
      ' '
      ' '
      ' '
      ' '
      ' '
      ' ')
    Optimize = False
    Variables.Data = {
      0300000002000000050000003A59454152030000000000000000000000050000
      003A434F4E43030000000000000000000000}
    OracleDictionary.EnforceConstraints = True
    CountAllRecords = True
    Session = seOracle
    Left = 264
    Top = 342
  end
  object quRN08_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id treaty_id,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name num,'
      '       vitreaty.subject,'
      '       TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') DATEFROM,'
      '       TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') DATETO,'
      '       vitreaty.summpay TREATY_SUMMPAY,'
      '       vitreaty.currency_no CURRENCY_NO,'
      '       vitreaty.treaty_status STATUS,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       --exchange_rates.e_rate,'
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         vitreaty.datefrom)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      
        '       RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.currency_n' +
        'o,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         ) into_date,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      '       st.dateact dateact,'
      '       st.datefrom stage_datefrom,'
      '       st.dateto stage_dateto,'
      '       currency.iso_name currency_name,'
      '       TO_CHAR(vitreaty.datefrom, '#39'YYYY'#39') DATEFROM_YEAR,'
      '       vitreaty.treaty_id rep_num,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty'
      '  FROM RN.vitreaty,'
      '       RN.mnagreem agr,'
      '       RN.mnstage st,'
      '       S.currency'
      ' WHERE (   (vitreaty.treaty_status =  '#39'O'#39')'
      
        '        OR (vitreaty.treaty_status <> '#39'O'#39' AND  vitreaty.dateto >' +
        '= TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy'#39')))'
      ''
      
        '   AND vitreaty.datefrom < TO_DATE('#39'01.01.'#39' || (:YEAR + 1), '#39'dd.' +
        'mm.yyyy'#39')'
      '   AND vitreaty.istfin_kod = 1 -- '#1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072
      '   AND vitreaty.TREATY_STATUS NOT IN ('#39'A'#39', '#39'P'#39')'
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      ''
      '   AND currency.currency_no = vitreaty.currency_no'
      ' ORDER BY vitreaty.treaty_id'
      ' '
      ' '
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {0300000001000000050000003A59454152030000000000000000000000}
    Left = 181
    Top = 171
  end
  object quRN09RN11_rep: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id ID,'
      '       vitreaty.treaty_num treaty_num,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name name,'
      '       vitreaty.subject subject,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       vitreaty.currency_no currency_no,'
      '       st.num st_num,'
      '       NVL(st.dateact, st.dateto) st_dateto,'
      '       --exchange_rates.e_rate,'
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         vitreaty.datefrom)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      
        '       RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.currency_n' +
        'o,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         ) into_date,'
      
        '       decode(vitreaty.istfin_kod, 2, vitreaty.theme_plan_num, v' +
        'itreaty.treaty_id) num,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      '       COUNT(*) OVER (PARTITION BY 1) rec_count,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treatys'
      '  FROM RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       RN.vitreaty,'
      '       S.currency'
      
        ' WHERE (    ( (st.dateact between   :DATEFROM and :DATETO) and (' +
        'st.dateact <> :DATETO))'
      
        '         OR (  st.dateact IS NULL AND  (st.dateto between :DATEF' +
        'ROM and :DATETO) and (st.dateto <> :DATETO))'
      '       )'
      '   AND vitreaty.istfin_kod = 2 -- '#1048#1085#1085#1086#1074#1072#1094#1080#1086#1085#1085#1099#1081' '#1092#1086#1085#1076
      '   AND vitreaty.TREATY_STATUS <> '#39'A'#39
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      '   AND currency.currency_no = vitreaty.currency_no'
      
        '   --AND ((:CONC_DATETO IS NULL) OR (vitreaty.datefrom <= :CONC_' +
        'DATETO))'
      
        '   --AND ((:CONC_DATEFROM IS NULL) OR (vitreaty.datefrom >= :CON' +
        'C_DATEFROM))'
      
        '   AND :CONC = RN.mitrconcern_pkg.GetConcDogForInnavDog((:DATETO' +
        ' - 1), vitreaty.DATEFROM, vitreaty.DATETO)'
      
        ' ORDER BY decode(vitreaty.istfin_kod, 2, vitreaty.theme_plan_num' +
        ', vitreaty.treaty_id), vitreaty.treaty_id, st.num'
      ' '
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000003000000090000003A4441544546524F4D0C00000000000000000000
      00070000003A44415445544F0C0000000000000000000000050000003A434F4E
      43030000000000000000000000}
    Left = 264
    Top = 171
  end
  object quRN10RN12_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id ID,'
      '       vitreaty.treaty_num treaty_num,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name name,'
      '       vitreaty.subject subject,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       vitreaty.currency_no currency_no,'
      '       st.num st_num,'
      '       NVL(st.dateact, st.dateto) st_dateto,'
      '       --exchange_rates.e_rate,'
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         vitreaty.datefrom)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      
        '       RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.currency_n' +
        'o,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         ) into_date,'
      
        '       decode(vitreaty.istfin_kod, 2, vitreaty.theme_plan_num, v' +
        'itreaty.treaty_id) num,'
      '       vitreaty.treaty_id num,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      '       COUNT(*) OVER (PARTITION BY 1) rec_count,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treatys'
      '  FROM RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       RN.vitreaty,'
      '       S.currency'
      
        ' WHERE (    ( (st.dateact between   :DATEFROM and :DATETO) and (' +
        'st.dateact <> :DATETO))'
      
        '         OR (  st.dateact IS NULL AND  (st.dateto between :DATEF' +
        'ROM and :DATETO) and (st.dateto <> :DATETO))'
      '       )'
      '   AND vitreaty.istfin_kod = 1 -- '#1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072
      '   AND vitreaty.TREATY_STATUS NOT IN ('#39'A'#39', '#39'P'#39')'
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      '   AND currency.currency_no = vitreaty.currency_no'
      ' ORDER BY vitreaty.treaty_id, st.num'
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000002000000070000003A44415445544F0C000000000000000000000009
      0000003A4441544546524F4D0C0000000000000000000000}
    Left = 16
    Top = 228
  end
  object quRN13_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT tr.treaty_id ID,'
      '       tr.treaty_num treaty_num,'
      '       tr.treaty_num || '#39', '#39'|| tr.exec_name name,'
      '       tr.subject subject,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       tr.currency_no currency_no,'
      '       st.num st_num,'
      '       TO_CHAR(st.dateto, '#39'mm.yyyy'#39') st_dateto,'
      '       --exchange_rates.e_rate,'
      '       DECODE(tr.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(NVL(st.datepay, SYSDATE), tr.currency_no)'
      '                  AND er.CURRENCY_NO = tr.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      
        '       RN.MONEY_PKG.GetLEqMaxDateOfExchange(NVL(st.datepay, SYSD' +
        'ATE), tr.currency_no) into_date,'
      
        '       decode(tr.istfin_kod, 2, tr.theme_plan_num, tr.treaty_id)' +
        ' num,'
      '       tr.istfin_kod istfin_kod,'
      
        '       decode(tr.istfin_kod, 2, RN.MITRCONCERN_PKG.getconcdogfor' +
        'innavdog(TRUNC(ADD_MONTHS(SYSDATE, -1), '#39'MONTH'#39'), tr.datefrom, t' +
        'r.dateto), NULL) ConcDogID,'
      
        '       COUNT(tr.treaty_id) OVER (PARTITION BY tr.treaty_id) coun' +
        't_per_treaty,'
      
        '       COUNT(DISTINCT tr.treaty_id) OVER (PARTITION BY 1) rec_co' +
        'unt'
      '  FROM RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       RN.vitreaty tr,'
      '       S.currency'
      ' WHERE st.dateto <= TRUNC(SYSDATE, '#39'MONTH'#39')'
      '   AND st.dateact IS NULL'
      '   AND st.agreem_id = agr.id'
      '   AND agr.treaty_id = tr.treaty_id'
      '   AND agr.num = tr.agreem_num'
      '   AND tr.treaty_STATUS = '#39'O'#39
      '   AND currency.currency_no = tr.currency_no'
      ' ORDER BY tr.istfin_kod desc,'
      '          decode(tr.istfin_kod,'
      '                 2,'
      
        '                 RN.MITRCONCERN_PKG.getconcdogforinnavdog(TRUNC(' +
        'ADD_MONTHS(SYSDATE, -1), '#39'MONTH'#39'),'
      
        '                                                       tr.datefr' +
        'om,'
      
        '                                                       tr.dateto' +
        '),'
      '                 NULL),'
      '          (SELECT MIN(sub_st.DATETO)'
      '             FROM RN.mnstage SUB_st,'
      '                  RN.mnagreem sub_agr'
      '            where sub_agr.treaty_id = tr.treaty_id'
      '              AND sub_agr.num = tr.agreem_num'
      '              AND sub_st.agreem_id = sub_agr.id'
      '              AND SUB_st.dateact IS NULL),'
      '          decode(tr.istfin_kod,'
      '                 2,'
      '                 tr.theme_plan_num,'
      '                 tr.treaty_id),'
      '          tr.treaty_id,'
      '          st.DATETO,'
      '          st.num')
    Session = seOracle
    Optimize = False
    Left = 99
    Top = 228
  end
  object odsTrExecFirmProperty: TOracleDataSet
    SQL.Strings = (
      'SELECT F_B.FIRM_NO,'
      '       F_B.COUNTRY_NO,'
      '       F_B.BANK_ID,'
      '       F_B.NAME_BENEFICIARY,'
      '       F_B.BANK,'
      '       F_B.NIOKR_ACCOUNT'
      '  FROM RN.MIFIRM_BANK F_B'
      ' WHERE F_B.FIRM_NO = :FIRM_NO'
      '   AND F_B.COUNTRY_NO = :COUNTRY_NO'
      '   AND F_B.BANK_ID = :BANK_ID'
      ' ')
    Optimize = False
    Variables.Data = {
      0300000003000000080000003A4649524D5F4E4F040000000000000000000000
      0B0000003A434F554E5452595F4E4F040000000000000000000000080000003A
      42414E4B5F4944050000000000000000000000}
    Master = quTreaty
    MasterFields = 'EXEC_FIRM_NO; EXEC_COUNTRY_NO; EXEC_BANK_ID'
    DetailFields = 'FIRM_NO; COUNTRY_NO; BANK_ID'
    RefreshOptions = [roAllFields]
    OnApplyRecord = odsTrExecFirmPropertyApplyRecord
    Session = seOracle
    Left = 181
    Top = 326
  end
  object quRN14_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT tr.treaty_id ID,'
      '       tr.treaty_num treaty_num,'
      '       tr.treaty_num || '#39', '#39'|| tr.exec_name name,'
      '       tr.subject subject,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       tr.currency_no currency_no,'
      #9'tr.plat_doc_type pdt,'
      '       st.num st_num,'
      '       TO_CHAR(st.dateto, '#39'mm.yyyy'#39') st_dateto,'
      '       DECODE(tr.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(st.dateact, tr.currency_no)'
      '                  AND er.CURRENCY_NO = tr.currency_no'
      '              )'
      '             ) e_rate,'
      
        '       RN.MONEY_PKG.GetLEqMaxDateOfExchange(st.dateact, tr.curre' +
        'ncy_no) into_date,'
      
        '       NVL(ST.NUMPAY, decode(tr.plat_doc_type,3025,sw.doc_ext_no' +
        ',d.doc_ext_no)) NUMPAY,'
      
        '       NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pack' +
        '.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id' +
        '), d.doc_date))) DATEPAY,'
      '--       NVL(ST.NUMPAY, d.doc_ext_no)  NUMPAY,'
      
        '--       TO_CHAR(NVL(ST.DATEPAY, nvl(m.vns_pack.getpdmaxpdate(l.' +
        'doc_id), d.doc_date)), '#39'dd.mm.yyyy'#39') DATEPAY,'
      
        '       decode(tr.istfin_kod, 2, tr.theme_plan_num, tr.treaty_id)' +
        ' num,'
      '       tr.istfin_kod istfin_kod,'
      
        '       decode(tr.istfin_kod, 2, RN.MITRCONCERN_PKG.getconcdogfor' +
        'innavdog(:DATEFROM, tr.datefrom, tr.dateto), NULL) ConcDogID,'
      
        '       COUNT(tr.treaty_id) OVER (PARTITION BY tr.treaty_id) coun' +
        't_per_treaty,'
      
        '       COUNT(distinct tr.treaty_id) OVER (PARTITION BY 1) rec_co' +
        'unt'
      '  FROM RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       RN.vitreaty tr,'
      '       S.currency,'
      '       M.vns_pd_div_lines l,'
      '       M.vns_pd_div_lines l2,'
      '       M.documents d,'
      '       M.documents SW'
      ' WHERE st.dateact BETWEEN :DATEFROM and :DATETO'
      '   AND st.dateact <> :DATETO'
      '   AND st.agreem_id = agr.id'
      '   AND agr.treaty_id = tr.treaty_id'
      '--   AND tr.treaty_STATUS IN '#39'C'#39
      '   AND currency.currency_no = tr.currency_no'
      '   AND SW.DOC_NO(+) = st.SPECIAL_WRITTEN'
      '   AND l.sw_id(+) = SW.DOC_NO'
      '   AND d.DOC_NO(+) = l.DOC_ID'
      '   AND l2.doc_id(+) = SW.DOC_NO'
      '--   AND l.sw_id(+) = st.SPECIAL_WRITTEN'
      '--   and l.doc_id = d.doc_no(+)'
      
        ' ORDER BY tr.istfin_kod desc, decode(tr.istfin_kod, 2, RN.MITRCO' +
        'NCERN_PKG.getconcdogforinnavdog(:DATEFROM, tr.datefrom, tr.datet' +
        'o), NULL), decode(tr.istfin_kod, 2, tr.theme_plan_num, tr.treaty' +
        '_id), tr.treaty_id, st.num'
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A4441544546524F4D0C00000000000000000000
      00070000003A44415445544F0C0000000000000000000000}
    Left = 181
    Top = 228
  end
  object quRN15RN16_2_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id ID,'
      '       NULL treaty_num,'
      '       vitreaty.subject treaty_name,'
      '       '#39#1055#1054' '#1050#1054#1053#1050#1059#1056#1057#1059#39' exec_name,'
      '       vitreaty.datefrom date_from,'
      '       vitreaty.dateto date_to,'
      '       :REP_YEAR stage_dateto,'
      '       vitreaty.first_year_summpay stage_summpay,'
      '       vitreaty.summpay treaty_summpay,'
      '       vitreaty.CHAPTER_KOD subject_KOD,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty,'
      '       0 count_foreign_treaty,'
      '       933 currency_no,  -- '#1041#1077#1083#1072#1088#1091#1089#1082#1080#1081' '#1088#1091#1073#1072#1083#1100
      '       1 count_per_treaty,'
      '       SYSDATE INTO_DATE,'
      '       1 E_RATE,'
      
        '       COUNT(DISTINCT vitreaty.CHAPTER_KOD) OVER (PARTITION BY 1' +
        ') count_subject,'
      '       summary.summary summary,'
      '       vitreaty.treaty_status status,'
      '       vitreaty.podr_snaim,'
      '       vitreaty.podr_pnaim'
      '  FROM rn.vitreaty,'
      '       rn.mnsummary summary'
      
        ' WHERE vitreaty.datefrom BETWEEN :REP_YEAR AND TO_DATE('#39'31.12'#39' |' +
        '| TO_CHAR(:REP_YEAR, '#39'yyyy'#39'), '#39'dd.mm.yyyy'#39')'
      '   AND vitreaty.treaty_status = '#39'P'#39
      '   AND vitreaty.istfin_kod = :istfin_kod'
      '   AND summary.treaty_id(+) = vitreaty.treaty_id'
      ''
      ' ORDER BY vitreaty.CHAPTER_KOD, vitreaty.treaty_id'
      '/*SELECT ID,'
      '       treaty_num,'
      '       treaty_name,'
      '       exec_name,'
      '       date_from,'
      '       date_to,'
      '       currency_no,'
      '       stage_summpay,'
      '       treaty_summpay,'
      '       dateact,'
      '       stage_dateto,'
      '       e_rate,'
      '       into_date,'
      '       subject_KOD,'
      '       count_per_treaty,'
      '       currency_name,'
      '       COUNT(DISTINCT id) OVER (PARTITION BY 1) count_treaty,'
      
        '       COUNT(DISTINCT DECODE(CURRENCY_NO, 933, NULL, ID)) OVER (' +
        'PARTITION BY 1) count_foreign_treaty'
      '  FROM (SELECT vitreaty.treaty_id ID,'
      '               vitreaty.treaty_status STATUS,'
      '               vitreaty.treaty_num treaty_num,'
      '               vitreaty.subject treaty_name,'
      '               vitreaty.exec_name exec_name,'
      '               vitreaty.datefrom date_from,'
      '               vitreaty.dateto date_to,'
      '               vitreaty.currency_no currency_no,'
      '               0 stage_summpay,'
      '               vitreaty.summpay treaty_summpay,'
      '               TO_DATE(NULL) dateact,'
      '               TO_DATE(NULL) stage_dateto,'
      '               DECODE(vitreaty.currency_no,'
      '                      933,'
      '                      1,'
      '                      (SELECT ER.E_RATE'
      '                         FROM S.EXCHANGE_RATES er'
      
        '                        WHERE er.intro_date = RN.MONEY_PKG.GetLE' +
        'qMaxDateOfExchange(SYSDATE, vitreaty.currency_no)'
      
        '                          AND er.CURRENCY_NO = vitreaty.currency' +
        '_no'
      '                      )'
      '                     ) e_rate,'
      
        '               RN.MONEY_PKG.GetLEqMaxDateOfExchange(SYSDATE, vit' +
        'reaty.currency_no) into_date,'
      '               vitreaty.CHAPTER_KOD subject_KOD,'
      
        '               COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitr' +
        'eaty.treaty_id) count_per_treaty,'
      '               currency.iso_name currency_name'
      '          FROM rn.vitreaty,'
      '               s.currency'
      
        '         WHERE vitreaty.datefrom BETWEEN :REP_YEAR AND TO_DATE('#39 +
        '31.12'#39' || TO_CHAR(:REP_YEAR, '#39'yyyy'#39'), '#39'dd.mm.yyyy'#39')'
      '           AND vitreaty.treaty_status IN ('#39'P'#39', '#39'O'#39')'
      '           AND NOT EXISTS(SELECT *'
      '                            FROM RN.mnstage st,'
      '                                 RN.mnagreem agr'
      
        '                           WHERE vitreaty.treaty_id = agr.treaty' +
        '_id'
      '                             AND agr.id = st.agreem_id)'
      '           AND vitreaty.istfin_kod = :istfin_kod'
      '           AND currency.currency_no = vitreaty.currency_no'
      ''
      'UNION ALL'
      ''
      '        SELECT vitreaty.treaty_id ID,'
      '               vitreaty.treaty_status STATUS,'
      '               vitreaty.treaty_num treaty_num,'
      '               vitreaty.subject treaty_name,'
      '               vitreaty.exec_name exec_name,'
      
        '               MIN(st.datefrom) OVER (PARTITION BY vitreaty.trea' +
        'ty_id) date_from,'
      
        '               MAX(NVL(st.dateact, st.dateto)) OVER (PARTITION B' +
        'Y vitreaty.treaty_id) date_to,'
      '               vitreaty.currency_no currency_no,'
      '               NVL(st.summpay,0) stage_summpay,'
      '               vitreaty.summpay treaty_summpay,'
      '               st.dateact dateact,'
      '               NVL(st.dateact, st.dateto) stage_dateto,'
      '               DECODE(vitreaty.currency_no,'
      '                      933,'
      '                      1,'
      '                      (SELECT ER.E_RATE'
      '                         FROM S.EXCHANGE_RATES er'
      
        '                        WHERE er.intro_date = RN.MONEY_PKG.GetLE' +
        'qMaxDateOfExchange(NVL(st.dateact, SYSDATE), vitreaty.currency_n' +
        'o)'
      
        '                          AND er.CURRENCY_NO = vitreaty.currency' +
        '_no'
      '                      )'
      '                     ) e_rate,'
      
        '               RN.MONEY_PKG.GetLEqMaxDateOfExchange(NVL(st.datea' +
        'ct, SYSDATE), vitreaty.currency_no) into_date,'
      '               vitreaty.CHAPTER_KOD subject_KOD,'
      
        '               COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitr' +
        'eaty.treaty_id) count_per_treaty,'
      '               currency.iso_name currency_name'
      '          FROM rn.vitreaty,'
      '               rn.mnstage st,'
      '               rn.mnagreem agr,'
      '               s.currency'
      '         WHERE (SELECT MIN(st1.datefrom)'
      '                  FROM rn.mnagreem agr1,'
      '                       rn.mnstage st1'
      '                 WHERE vitreaty.treaty_id = agr1.treaty_id'
      '                   AND st1.agreem_id = agr1.id'
      
        '                   AND (   st1.dateact IS NOT NULL AND agr1.num ' +
        '< vitreaty.agreem_num'
      '                        OR agr1.num = vitreaty.agreem_num)'
      
        '               )BETWEEN :REP_YEAR AND TO_DATE('#39'31.12'#39' || TO_CHAR' +
        '(:REP_YEAR, '#39'yyyy'#39'), '#39'dd.mm.yyyy'#39')'
      '           AND vitreaty.treaty_status IN ('#39'P'#39', '#39'O'#39')'
      '           AND vitreaty.istfin_kod = :istfin_kod'
      '           AND currency.currency_no = vitreaty.currency_no'
      '           AND vitreaty.treaty_id = agr.treaty_id'
      '           AND st.agreem_id = agr.id'
      
        '           AND (   st.dateact IS NOT NULL AND agr.num < vitreaty' +
        '.agreem_num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '                OR agr.num = vitreaty.agreem_num))'
      ''
      ' ORDER BY subject_KOD, id */'
      ' '
      ' '
      ' '
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A5245505F594541520C00000000000000000000
      000B0000003A49535446494E5F4B4F44030000000000000000000000}
    Left = 264
    Top = 557
  end
  object quRN15RN16_1_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id ID,'
      '       vitreaty.treaty_num treaty_num,'
      '       vitreaty.subject treaty_name,'
      '       vitreaty.exec_name exec_name,'
      '       --vitreaty.datefrom date_from,'
      
        '       MIN(st.datefrom) OVER (PARTITION BY vitreaty.treaty_id) d' +
        'ate_from,'
      '       --vitreaty.dateto date_to,'
      
        '       MAX(NVL(st.dateact, st.dateto)) OVER (PARTITION BY vitrea' +
        'ty.treaty_id) date_to,'
      '       vitreaty.currency_no currency_no,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       vitreaty.summpay treaty_summpay,'
      '       st.dateact dateact,'
      '       NVL(st.dateact, st.dateto) stage_dateto,'
      ''
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              NVL((SELECT MIN(e.rate)'
      '                    FROM RN.MiEXCHANGE e'
      '                   WHERE e.currency_no = vitreaty.currency_no'
      
        '                     AND e.YEAR =  TO_NUMBER(TO_CHAR(:REP_YEAR, ' +
        #39'yyyy'#39'))'
      
        '                     AND NVL(st.dateact, st.dateto) >= TRUNC(:RE' +
        'P_YEAR, '#39'YEAR'#39')'
      '                  ),'
      '                  (SELECT ER.E_RATE'
      '                     FROM S.EXCHANGE_RATES er'
      
        '                    WHERE er.intro_date = RN.MONEY_PKG.getdateof' +
        'exchangeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '             st.dateact,'
      
        '                                                                ' +
        '             agr.treaty_id,'
      
        '                                                                ' +
        '             vitreaty.datefrom)'
      '                      AND er.CURRENCY_NO = vitreaty.currency_no'
      '                  )'
      ''
      '                 )'
      ''
      '             ) e_rate,'
      ''
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              TRUNC(SYSDATE),'
      '              NVL((SELECT MIN(:REP_YEAR)'
      '                    FROM RN.MiEXCHANGE e'
      '                   WHERE e.currency_no = vitreaty.currency_no'
      
        '                     AND e.YEAR =  TO_NUMBER(TO_CHAR(:REP_YEAR, ' +
        #39'yyyy'#39'))'
      
        '                     AND NVL(st.dateact, st.dateto) >= TRUNC(:RE' +
        'P_YEAR, '#39'YEAR'#39')'
      '                  ),'
      
        '                  RN.MONEY_PKG.getdateofexchangeofstage(vitreaty' +
        '.currency_no,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         )'
      '                 )'
      '             ) into_date,'
      ''
      '       vitreaty.CHAPTER_KOD subject_KOD,'
      ''
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      '       currency.iso_name currency_name,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty,'
      
        '       COUNT(DISTINCT DECODE(vitreaty.currency_no, 933, NULL, vi' +
        'treaty.treaty_id)) OVER (PARTITION BY 1) count_foreign_treaty,'
      
        '       COUNT(DISTINCT vitreaty.CHAPTER_KOD) OVER (PARTITION BY 1' +
        ') count_subject,'
      '       summary.summary summary,'
      '       vitreaty.treaty_status status,'
      '       vitreaty.podr_snaim,'
      '       vitreaty.podr_pnaim'
      '  FROM rn.vitreaty,'
      '       rn.mnstage st,'
      '       rn.mnagreem agr,'
      '       s.currency,'
      '       rn.mnsummary summary'
      '  WHERE'
      '  --vitreaty.datefrom'
      
        '  TRUNC((SELECT MIN(st1.datefrom) FROM rn.mnagreem agr1, rn.mnst' +
        'age st1 WHERE vitreaty.treaty_id = agr1.treaty_id'
      
        '                                                                ' +
        '    AND st1.agreem_id = agr1.id'
      
        '                                                                ' +
        '    AND (   st1.dateact IS NOT NULL AND agr1.num < vitreaty.agre' +
        'em_num'
      
        '                                                                ' +
        '         OR agr1.num = vitreaty.agreem_num)), '#39'YEAR'#39')'
      '     <= :REP_YEAR'
      
        '   AND (SELECT MAX(NVL(st1.dateact, st1.dateto)) FROM rn.mnagree' +
        'm agr1, rn.mnstage st1 WHERE vitreaty.treaty_id = agr1.treaty_id'
      
        '                                                                ' +
        '    AND st1.agreem_id = agr1.id'
      
        '                                                                ' +
        '    AND (   st1.dateact IS NOT NULL AND agr1.num < vitreaty.agre' +
        'em_num'
      
        '                                                                ' +
        '         OR agr1.num = vitreaty.agreem_num)) >= :REP_YEAR'
      '   AND (    vitreaty.treaty_status = '#39'O'#39
      
        '         OR ((vitreaty.treaty_status = '#39'F'#39') AND ((vitreaty.datet' +
        'o >=  :REP_YEAR) and (TRUNC(vitreaty.datefrom, '#39'YEAR'#39') <=  :REP_' +
        'YEAR))))'
      '   AND vitreaty.istfin_kod = :istfin_kod'
      '   AND currency.currency_no = vitreaty.currency_no'
      '   AND vitreaty.treaty_id = agr.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      '   AND summary.treaty_id(+) = vitreaty.treaty_id'
      ''
      ' ORDER BY vitreaty.CHAPTER_KOD, vitreaty.treaty_id, st.num'
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A5245505F594541520C00000000000000000000
      000B0000003A49535446494E5F4B4F44030000000000000000000000}
    Left = 261
    Top = 509
  end
  object quEconParam: TVASUPQuery
    SQL.Strings = (
      'SELECT A.ROWID, A.KOD, A.NAME FROM RN.MIECONOMIC_PARAMETER A')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0400000002000000030000004B4F44010000000000040000004E414D45010000
      000000}
    UpdatingTable = 'RN.MIECONOMIC_PARAMETER'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1042#1080#1076#1099' '#1101#1082#1086#1085#1086#1084#1080#1095#1077#1089#1082#1080#1093' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1077#1081
    Order = 'A.KOD ASC'
    AccessLevel = [aqQuerying, aqInserting, aqEditing, aqDeleting]
    EditorClassName = 'TfmEconomicParameter'
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 372
    Top = 248
    object quEconParamKOD: TIntegerField
      DisplayLabel = #1050#1086#1076
      DisplayWidth = 2
      FieldName = 'KOD'
      Origin = 'A.KOD'
      Required = True
    end
    object quEconParamNAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1101#1082#1086#1085#1086#1084#1080#1095#1077#1089#1082#1086#1075#1086' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1103
      FieldName = 'NAME'
      Origin = 'A.NAME'
      Required = True
      Size = 50
    end
  end
  object quExpectedIncome: TVASUPQuery
    SQL.Strings = (
      'SELECT A.ROWID,'
      '       A.TREATY_ID,'
      '       A.TYPE_PARAMETERS,'
      '       A.PLAN_DATE,'
      '       A.FACT_DATE_FROM,'
      '       A.FACT_DATE_TO,'
      '       A.PARAMETER,'
      '       A.DESCRIPTION'
      '  FROM RN.MNECONOMIC_PARAMETERS A'
      ' WHERE A.TYPE_PARAMETERS = 1 '
      '   AND TREATY_ID = :TREATY_ID')
    Optimize = False
    Variables.Data = {
      03000000010000000A0000003A5452454154595F494403000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      0400000007000000090000005452454154595F49440100000000000F00000054
      5950455F504152414D455445525301000000000009000000504C414E5F444154
      450100000000000E000000464143545F444154455F46524F4D0100000000000C
      000000464143545F444154455F544F01000000000009000000504152414D4554
      45520100000000000B0000004445534352495054494F4E010000000000}
    Master = quTreaty
    MasterFields = 'ID'
    DetailFields = 'TREATY_ID'
    UpdatingTable = 'RN.MNECONOMIC_PARAMETERS'
    CommitOnPost = False
    Session = seOracle
    AfterInsert = quExpectedIncomeAfterInsert
    ReActive = True
    Caption = #1054#1078#1080#1076#1072#1077#1084#1099#1081' '#1101#1092#1092#1077#1082#1090
    AccessLevel = [aqQuerying, aqInserting, aqEditing, aqDeleting]
    LinkDetailSQL = True
    EmbeddedSQLSlice.Strings = (
      '  FROM  RN.MNECONOMIC_PARAMETERS A'
      ' WHERE  A.TYPE_PARAMETERS = 1')
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 328
    Top = 328
    object quExpectedIncomeTREATY_ID: TFloatField
      Tag = 2
      DisplayLabel = 'ID '#1044#1086#1075#1086#1074#1086#1088#1072
      DisplayWidth = 13
      FieldName = 'TREATY_ID'
      Origin = 'A.TREATY_ID'
      Required = True
      Visible = False
      DisplayFormat = '#,###,###,##0'
      EditFormat = '#########0'
    end
    object quExpectedIncomeTYPE_PARAMETERS: TIntegerField
      Tag = 2
      DisplayLabel = #1058#1080#1087' '#1101#1082#1086#1085#1086#1084#1080#1095#1077#1089#1082#1086#1075#1086' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
      DisplayWidth = 2
      FieldName = 'TYPE_PARAMETERS'
      Origin = 'A.TYPE_PARAMETERS'
      Required = True
      Visible = False
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quExpectedIncomePLAN_DATE: TDateTimeField
      DisplayLabel = #1055#1086' '#1087#1083#1072#1085#1091
      DisplayWidth = 4
      FieldName = 'PLAN_DATE'
      Origin = 'A.PLAN_DATE'
      OnChange = YYYY_DateFormat
      DisplayFormat = 'yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quExpectedIncomeFACT_DATE_FROM: TDateTimeField
      DisplayLabel = #1053#1072#1095'. '#1087#1086' '#1092#1072#1082#1090#1091
      DisplayWidth = 4
      FieldName = 'FACT_DATE_FROM'
      Origin = 'A.FACT_DATE_FROM'
      OnChange = YYYY_DateFormat
      DisplayFormat = 'yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quExpectedIncomeFACT_DATE_TO: TDateTimeField
      DisplayLabel = #1054#1082#1086#1085#1095'. '#1087#1086' '#1092#1072#1082#1090#1091
      DisplayWidth = 4
      FieldName = 'FACT_DATE_TO'
      Origin = 'A.FACT_DATE_TO'
      OnChange = YYYY_DateFormat
      DisplayFormat = 'yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quExpectedIncomePARAMETER: TFloatField
      DisplayLabel = #1054#1078#1080#1076#1072#1077#1084#1099#1081' '#1101#1092#1092#1077#1082#1090
      DisplayWidth = 24
      FieldName = 'PARAMETER'
      Origin = 'A.PARAMETER'
      DisplayFormat = '#,###,###,###,###,##0.##'
      EditFormat = '###############0.##'
    end
    object quExpectedIncomeDESCRIPTION: TStringField
      Tag = 2
      DisplayLabel = #1054#1087#1080#1089#1072#1085#1080#1077' '#1101#1082#1086#1085#1086#1084#1080#1095#1077#1089#1082#1086#1075#1086' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
      FieldName = 'DESCRIPTION'
      Visible = False
      Size = 1000
    end
  end
  object quExpIncomePeriod: TVASUPQuery
    SQL.Strings = (
      'SELECT A.ROWID,'
      '       A.TREATY_ID,'
      '       A.TYPE,'
      '       A.PERIOD,'
      '       A.DATA,'
      '       A.DESCRIPTION'
      '  FROM RN.MNECONOMIC_PARAMETER_PERIOD A'
      'WHERE TREATY_ID = :TREATY_ID'
      '    AND TYPE = :TYPE')
    Optimize = False
    Variables.Data = {
      03000000020000000A0000003A5452454154595F494403000000000000000000
      0000050000003A54595045030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000005000000090000005452454154595F49440100000000000400000054
      59504501000000000006000000504552494F4401000000000004000000444154
      410100000000000B0000004445534352495054494F4E010000000000}
    Master = quExpectedIncome
    MasterFields = 'TREATY_ID;TYPE_PARAMETERS;'
    DetailFields = 'TREATY_ID;TYPE;'
    UpdatingTable = 'RN.MNECONOMIC_PARAMETER_PERIOD'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1054#1078'. '#1101#1092#1092'. '#1079#1072' '#1087#1077#1088#1080#1086#1076
    Order = 'A.PERIOD ASC'
    AccessLevel = [aqQuerying, aqInserting, aqEditing, aqDeleting]
    LinkKind = lkIn
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 320
    Top = 272
    object quExpIncomePeriodTREATY_ID: TFloatField
      Tag = 2
      FieldName = 'TREATY_ID'
      Origin = 'A.TREATY_ID'
      Required = True
      Visible = False
    end
    object quExpIncomePeriodTYPE: TIntegerField
      Tag = 2
      FieldName = 'TYPE'
      Origin = 'A.TYPE'
      Required = True
      Visible = False
    end
    object quExpIncomePeriodPERIOD: TDateTimeField
      DisplayLabel = #1055#1077#1088#1080#1086#1076
      DisplayWidth = 4
      FieldName = 'PERIOD'
      Origin = 'A.PERIOD'
      Required = True
      OnChange = YYYY_DateFormat
      DisplayFormat = 'yyyy'
      EditMask = '!99/99/00;1;_'
    end
    object quExpIncomePeriodDATA: TFloatField
      DisplayLabel = #1054#1078'. '#1101#1092#1092'. '#1079#1072' '#1087#1077#1088#1080#1086#1076
      FieldName = 'DATA'
      Origin = 'A.DATA'
    end
    object quExpIncomePeriodDESCRIPTION: TStringField
      Tag = 2
      FieldName = 'DESCRIPTION'
      Origin = 'A.DESCRIPTION'
      Visible = False
      Size = 1000
    end
  end
  object quRN17RN18_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT tr.treaty_num || '#39', '#39' || tr.exec_name name,'
      '       tr.subject dog_name,'
      '       TO_CHAR(tr.DATETO, '#39'yyyy'#39') DATETO,'
      '       TO_CHAR(exp_inc.plan_date, '#39'yyyy'#39') plan_date,'
      '       TO_CHAR(exp_inc.FACT_DATE_FROM, '#39'yyyy'#39') FACT_DATE_FROM,'
      '       TO_CHAR(exp_inc.FACT_DATE_TO, '#39'yyyy'#39') FACT_DATE_TO,'
      '       exp_inc.description exp_income,'
      '       exp_inc_period.description fact_exp_inc,'
      '       COUNT(tr.treaty_id) OVER (PARTITION BY 1) count_rec'
      '  FROM rn.VITREATY tr,'
      '       rn.MNECONOMIC_PARAMETERS exp_inc,'
      '       rn.MNECONOMIC_PARAMETER_PERIOD exp_inc_period'
      ' WHERE tr.DATETO BETWEEN :DATEFROM AND :DATETO'
      '   AND tr.DATETO <> :DATETO'
      '   AND tr.ISTFIN_KOD = :ISTFIN'
      '   AND tr.TREATY_STATUS = '#39'F'#39
      '   AND tr.treaty_id = exp_inc.treaty_id'
      '   AND exp_inc.TYPE_PARAMETERS = 1'
      '   AND exp_inc.treaty_id = exp_inc_period.treaty_id(+)'
      '   AND exp_inc.TYPE_PARAMETERS = exp_inc_period.TYPE(+)'
      '   AND TRUNC(:DATETO - 365, '#39'YEAR'#39') = exp_inc_period.PERIOD(+)'
      ' '
      ' '
      ' '
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000003000000090000003A4441544546524F4D0C00000000000000000000
      00070000003A44415445544F0C0000000000000000000000070000003A495354
      46494E030000000000000000000000}
    Left = 99
    Top = 285
  end
  object quRN19_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT /*+ ORDERED */'
      '       vitreaty.treaty_id treaty_id,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name num,'
      '       vitreaty.subject,'
      '       TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') DATEFROM,'
      '       TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') DATETO,'
      '       vitreaty.summpay TREATY_SUMMPAY,'
      '       vitreaty.currency_no CURRENCY_NO,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       DECODE(vitreaty.currency_no,'
      '              93,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         vitreaty.datefrom)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      
        '       RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.currency_n' +
        'o,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         ) into_date,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      '       st.dateact dateact,'
      '       st.datefrom stage_datefrom,'
      '       st.dateto stage_dateto,'
      '       currency.iso_name currency_name,'
      '       TO_CHAR(vitreaty.datefrom, '#39'YYYY'#39') DATEFROM_YEAR,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty,'
      '       vitreaty.theme_plan_num temp_num'
      '  FROM RN.vitreaty,'
      '       RN.mnagreem agr,'
      '       RN.mnstage st,'
      '       S.currency'
      ' WHERE vitreaty.treaty_status =  '#39'F'#39
      
        '   AND vitreaty.dateto >= TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy' +
        #39')'
      
        '   AND vitreaty.datefrom <= TO_DATE('#39'31.12.'#39' || :YEAR, '#39'dd.mm.yy' +
        'yy'#39')'
      
        '   --AND ((:CONC_DATETO IS NULL) OR (TRUNC(vitreaty.datefrom, '#39'M' +
        'ONTH'#39') <= :CONC_DATETO))'
      
        '   --AND ((:CONC_DATEFROM IS NULL) OR (TRUNC(vitreaty.datefrom, ' +
        #39'MONTH'#39') >= :CONC_DATEFROM))'
      
        '   AND :CONC = RN.mitrconcern_pkg.GetConcDogForInnavDog(TO_DATE(' +
        #39'01.12.'#39' || :YEAR, '#39'dd.mm.yyyy'#39'), vitreaty.DATEFROM, vitreaty.DA' +
        'TETO)'
      
        '   AND NVL((SELECT MAX(st1.dateact) from RN.mnagreem agr1, RN.mn' +
        'stage st1 WHERE agr1.treaty_id = vitreaty.treaty_id AND st1.agre' +
        'em_id = agr1.id), TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy'#39'))'
      
        '       BETWEEN TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy'#39') AND TO_D' +
        'ATE('#39'31.12.'#39' || :YEAR, '#39'dd.mm.yyyy'#39')'
      '   AND vitreaty.istfin_kod = 2 -- '#1048#1085#1085#1086#1074#1072#1094#1080#1086#1085#1085#1099#1081' '#1092#1086#1085#1076
      '   AND EXISTS (SELECT *'
      '                  FROM RN.mitrconcern'
      
        '                 WHERE mitrconcern.DATEFROM <= TO_DATE('#39'31.12.'#39' ' +
        '|| :YEAR, '#39'dd.mm.yyyy'#39')'
      
        '                   AND mitrconcern.DATETO  >= TO_DATE('#39'01.01.'#39' |' +
        '| :YEAR, '#39'dd.mm.yyyy'#39')'
      '                   AND vitreaty.dateto >= mitrconcern.datefrom'
      '                   AND vitreaty.datefrom <= mitrconcern.DATETO'
      
        '               )  -- '#1055#1056#1086#1074#1077#1088#1103#1077#1084' '#1087#1086' '#1087#1072#1076#1072#1102#1090' '#1083#1080' '#1076#1086#1075#1086#1074#1086#1088' '#1074' '#1089#1088#1086#1082' '#1076#1077#1081#1089#1090 +
        #1074#1080#1103' '#1089' '#1076#1086#1075#1086#1074#1086#1088#1072#1084#1080' '#1089' '#1082#1086#1085#1094#1077#1088#1085#1086#1084
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      ''
      '   AND currency.currency_no = vitreaty.currency_no'
      ' ORDER BY vitreaty.theme_plan_num, vitreaty.treaty_id'
      ' '
      ' '
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000002000000050000003A59454152030000000000000000000000050000
      003A434F4E43030000000000000000000000}
    Left = 99
    Top = 342
  end
  object quRN20_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT /*+ ORDERED */'
      '       vitreaty.treaty_id treaty_id,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name num,'
      '       vitreaty.subject,'
      '       TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') DATEFROM,'
      '       TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') DATETO,'
      '       vitreaty.summpay TREATY_SUMMPAY,'
      '       vitreaty.currency_no CURRENCY_NO,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         vitreaty.datefrom)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      
        '       RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.currency_n' +
        'o,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         ) into_date,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      '       st.dateact dateact,'
      '       st.datefrom stage_datefrom,'
      '       st.dateto stage_dateto,'
      '       currency.iso_name currency_name,'
      '       TO_CHAR(vitreaty.datefrom, '#39'YYYY'#39') DATEFROM_YEAR,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty,'
      '       vitreaty.treaty_id temp_num'
      '  FROM RN.vitreaty,'
      '       RN.mnagreem agr,'
      '       RN.mnstage st,'
      '       S.currency'
      ' WHERE vitreaty.treaty_status =  '#39'F'#39
      
        '   AND vitreaty.dateto >= TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy' +
        #39')'
      
        '   AND vitreaty.datefrom < TO_DATE('#39'01.01.'#39' || (:YEAR + 1), '#39'dd.' +
        'mm.yyyy'#39')'
      
        '    AND NVL((SELECT MAX(st1.dateact) from RN.mnagreem agr1, RN.m' +
        'nstage st1 WHERE agr1.treaty_id = vitreaty.treaty_id AND st1.agr' +
        'eem_id = agr1.id), TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy'#39'))'
      
        '       BETWEEN TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy'#39') AND TO_D' +
        'ATE('#39'31.12.'#39' || :YEAR, '#39'dd.mm.yyyy'#39')'
      '   AND vitreaty.istfin_kod = 1 -- '#1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      ''
      '   AND currency.currency_no = vitreaty.currency_no'
      ' ORDER BY vitreaty.treaty_id')
    Session = seOracle
    Optimize = False
    Variables.Data = {0300000001000000050000003A59454152030000000000000000000000}
    Left = 181
    Top = 278
  end
  object quRN21RN22_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT data.ID,'
      '       data.name,'
      '       data.subject,'
      '       data.datefrom,'
      '       data.dateto,'
      '       data.summpay,'
      '       data.currency_no,'
      '       data.treaty_status,'
      '       data.stage_summpay,'
      '       DECODE(data.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      '                WHERE er.intro_date = data.into_date'
      '                  AND er.CURRENCY_NO = data.currency_no'
      '              )'
      '             ) e_rate,'
      '       data.into_date,'
      
        '       COUNT(data.id) OVER (PARTITION BY data.id) count_per_trea' +
        'ty,'
      '       data.dateact,'
      '       data.stage_datefrom,'
      '       data.stage_dateto,'
      '       data.currency_name,'
      '       data.num,'
      '       data.exec_name,'
      
        '       COUNT(DISTINCT data.id) OVER (PARTITION BY 1) count_treat' +
        'y,'
      '       data.CONC_TREATY,'
      
        '       COUNT(DISTINCT NVL(data.CONC_TREATY, 0)) OVER (PARTITION ' +
        'BY 1) count_conc_treaty,'
      '       data.CHAPTER_KOD,'
      
        '       COUNT(DISTINCT (NVL(data.CONC_TREATY, 0) || '#39'_'#39' || data.C' +
        'HAPTER_KOD)) OVER (PARTITION BY 1) count_article,'
      
        '       COUNT(DISTINCT data.ID) OVER (PARTITION BY data.CONC_TREA' +
        'TY) count_innov_treaty,'
      
        '       COUNT(DISTINCT data.ID) OVER (PARTITION BY data.CONC_TREA' +
        'TY, data.CHAPTER_KOD) count_art_treaty'
      '  FROM (SELECT vitreaty.treaty_id ID,'
      '               vitreaty.treaty_num  name,'
      '               vitreaty.subject,'
      '               TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') datefrom,'
      '               TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') dateto,'
      '               vitreaty.summpay,'
      '               vitreaty.currency_no,'
      '               vitreaty.treaty_status,'
      '               NVL(st.summpay,0) stage_summpay,'
      
        '               RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.cu' +
        'rrency_no,'
      '                                                  st.dateact,'
      '                                                  agr.treaty_id,'
      
        '                                                  vitreaty.datef' +
        'rom'
      '                                                 ) into_date,'
      '               st.dateact,'
      '               st.datefrom stage_datefrom,'
      '               st.dateto stage_dateto,'
      '               currency.iso_name currency_name,'
      
        '               decode(vitreaty.istfin_kod, 2, vitreaty.theme_pla' +
        'n_num, vitreaty.treaty_id) num,'
      '               vitreaty.exec_name exec_name,'
      
        '               decode(vitreaty.istfin_kod, 2, RN.MITRCONCERN_PKG' +
        '.getconcdogforinnavdog(:YEAR, vitreaty.datefrom, vitreaty.dateto' +
        '), NULL) CONC_TREATY,'
      '               vitreaty.CHAPTER_KOD  CHAPTER_KOD,'
      '               st.ID st_id'
      '          FROM RN.vitreaty,'
      '               RN.mnagreem agr,'
      '               RN.mnstage st,'
      '               S.currency'
      '         WHERE vitreaty.istfin_kod = :ISTFIN_KOD'
      '           AND vitreaty.treaty_status NOT IN ('#39'A'#39', '#39'P'#39')'
      '           AND (   (vitreaty.treaty_status = '#39'O'#39')'
      
        '                OR (vitreaty.treaty_status <> '#39'O'#39' AND  TRUNC(vit' +
        'reaty.dateto, '#39'YEAR'#39') >= TRUNC(:YEAR, '#39'YEAR'#39')))'
      
        '           AND TRUNC(vitreaty.datefrom, '#39'YEAR'#39') <= TRUNC(:YEAR, ' +
        #39'YEAR'#39')'
      '           AND agr.treaty_id = vitreaty.treaty_id'
      '           AND currency.currency_no = vitreaty.currency_no'
      '           AND st.agreem_id = agr.id'
      
        '           AND (   st.dateact IS NOT NULL AND agr.num < vitreaty' +
        '.agreem_num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '                OR agr.num = vitreaty.agreem_num)'
      ''
      'UNION'
      '        SELECT vitreaty.treaty_id ID,'
      '               vitreaty.treaty_num  name,'
      '               vitreaty.subject,'
      '               TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') datefrom,'
      '               TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') dateto,'
      '               vitreaty.summpay,'
      '               vitreaty.currency_no,'
      '               vitreaty.treaty_status,'
      '               NVL(st.summpay,0) stage_summpay,'
      
        '               RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.cu' +
        'rrency_no,'
      '                                                  st.dateact,'
      '                                                  agr.treaty_id,'
      
        '                                                  vitreaty.datef' +
        'rom'
      '                                                 ) into_date,'
      '               st.dateact,'
      '               st.datefrom stage_datefrom,'
      '               st.dateto stage_dateto,'
      '               currency.iso_name currency_name,'
      
        '               decode(vitreaty.istfin_kod, 2, vitreaty.theme_pla' +
        'n_num, vitreaty.treaty_id) num,'
      '               vitreaty.exec_name exec_name,'
      
        '               decode(vitreaty.istfin_kod, 2, RN.MITRCONCERN_PKG' +
        '.getconcdogforinnavdog(:YEAR, vitreaty.datefrom, vitreaty.dateto' +
        '), NULL) CONC_TREATY,'
      '               vitreaty.CHAPTER_KOD  CHAPTER_KOD,'
      '               st.ID  st_id'
      '          FROM (SELECT DISTINCT tr.*'
      '                  FROM RN.mnstage st,'
      '                       RN.mnagreem agr,'
      '                       RN.vitreaty tr'
      
        '                 WHERE st.dateact BETWEEN TRUNC(:YEAR, '#39'YEAR'#39') A' +
        'ND TO_DATE('#39'31.12.'#39' || TO_CHAR(:YEAR, '#39'yyyy'#39'), '#39'dd.mm.yyyy'#39')'
      '                   AND st.agreem_id = agr.id'
      '                   AND agr.treaty_id = tr.treaty_id'
      '                   AND tr.istfin_kod = :ISTFIN_KOD'
      '                 ) vitreaty,'
      '               RN.mnagreem agr,'
      '               RN.mnstage st,'
      '               S.currency'
      '         WHERE agr.treaty_id = vitreaty.treaty_id'
      '           AND currency.currency_no = vitreaty.currency_no'
      '           AND st.agreem_id = agr.id'
      
        '           AND (   st.dateact IS NOT NULL AND agr.num < vitreaty' +
        '.agreem_num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '                OR agr.num = vitreaty.agreem_num)'
      '       ) data'
      ' ORDER BY CONC_TREATY,'
      '          CHAPTER_KOD,'
      '          num, id')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      03000000020000000B0000003A49535446494E5F4B4F44030000000000000000
      000000050000003A594541520C0000000000000000000000}
    Left = 248
    Top = 294
  end
  object opNII_EVM_SERVIS: TOraclePackage
    Session = seOracle
    PackageName = 'RN.NII_EVM_SERVIS_PKG'
    Left = 88
    Top = 96
  end
  object quRepConc: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id treaty_id,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name num,'
      '       vitreaty.subject,'
      '       TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') DATEFROM,'
      '       TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') DATETO,'
      '       vitreaty.summpay TREATY_SUMMPAY,'
      '       vitreaty.currency_no CURRENCY_NO,'
      '       vitreaty.treaty_status STATUS,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       --exchange_rates.e_rate,'
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(NVL(st.dateact, SYSDATE),'
      
        '                                                                ' +
        '         vitreaty.currency_no)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      
        '       RN.MONEY_PKG.GetLEqMaxDateOfExchange(NVL(st.dateact, SYSD' +
        'ATE), vitreaty.currency_no) into_date,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      '       st.dateact dateact,'
      '       st.datefrom stage_datefrom,'
      '       st.dateto stage_dateto,'
      '       currency.iso_name currency_name,'
      '       TO_CHAR(vitreaty.datefrom, '#39'YYYY'#39') DATEFROM_YEAR,'
      
        '       decode(agr.istfin_kod, 2, vitreaty.theme_plan_num, vitrea' +
        'ty.treaty_id) rep_num,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty,'
      '       summary.summary summary'
      '  FROM RN.vitreaty vitreaty,'
      '       RN.mnagreem agr,'
      '       RN.mnstage st,'
      '       S.currency,'
      '       --S.exchange_rates'
      '       rn.mnsummary summary'
      ' WHERE (   (vitreaty.treaty_status =  '#39'O'#39')'
      
        '        OR (vitreaty.treaty_status <> '#39'O'#39' AND  vitreaty.dateto >' +
        '= :DATE_FROM'
      '        ))'
      '        --TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy'#39')))'
      ''
      
        '   AND vitreaty.datesign < ADD_MONTHS(:DATE_TO, 1) --TO_DATE('#39'01' +
        '.01.'#39' || (:YEAR + 1), '#39'dd.mm.yyyy'#39')'
      '   AND vitreaty.istfin_kod = 2 -- '#1048#1085#1085#1086#1074#1072#1094#1080#1086#1085#1085#1099#1081' '#1092#1086#1085#1076
      '   AND vitreaty.TREATY_STATUS NOT IN ('#39'A'#39', '#39'P'#39')'
      
        '   --AND ((:CONC_DATETO IS NULL) OR (vitreaty.datefrom <= :CONC_' +
        'DATETO))'
      
        '   --AND ((:CONC_DATEFROM IS NULL) OR (vitreaty.datefrom >= :CON' +
        'C_DATEFROM))'
      
        '   AND :CONC = RN.mitrconcern_pkg.GetConcDogForInnavDog(:DATE_TO' +
        ', vitreaty.DATEFROM, vitreaty.DATETO)'
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      ''
      '   AND currency.currency_no = vitreaty.currency_no'
      '   /*AND EXISTS(SELECT *'
      '                FROM RN.vitreaty sub_tr,'
      '                     RN.mnagreem sub_agr,'
      '                     RN.mnstage sub_st'
      '               WHERE sub_agr.treaty_id = sub_tr.treaty_id'
      '                 AND sub_st.agreem_id = sub_agr.id'
      
        '                 AND (   sub_st.dateact IS NOT NULL AND sub_agr.' +
        'num < sub_tr.agreem_num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.' +
        #1089#1086#1075#1083'.'
      '                      OR sub_agr.num = sub_tr.agreem_num)'
      '                 AND (sub_tr.treaty_id = vitreaty.treaty_id)'
      
        '                 AND (    (sub_st.dateact BETWEEN :DATE_FROM AND' +
        ' ADD_MONTHS(:DATE_TO, 1) AND  sub_st.dateact <> ADD_MONTHS(:DATE' +
        '_TO, 1))'
      
        '                       OR (sub_st.dateto BETWEEN :DATE_FROM AND ' +
        'ADD_MONTHS(:DATE_TO, 1) AND  sub_st.dateto <> ADD_MONTHS(:DATE_T' +
        'O, 1))'
      '                     )'
      '              )  */'
      '   AND summary.treaty_id(+) = vitreaty.treaty_id'
      '   /*AND exchange_rates.currency_no = vitreaty.currency_no'
      
        '   AND exchange_rates.intro_date = (SELECT NVL(MAX(er.intro_date' +
        '),TO_DATE('#39'04.01.2000'#39','#39'DD.MM.YYYY'#39'))'
      '                                      FROM S.exchange_rates er'
      
        '                                     WHERE (st.dateact IS NOT NU' +
        'LL AND er.intro_date  <= st.dateact'
      
        '                                            OR st.dateact IS NUL' +
        'L'
      
        '                                               AND er.intro_date' +
        ' <= (SELECT  NVL(MAX(dateact),vitreaty.datefrom)'
      
        '                                                                ' +
        '       FROM RN.mnstage st1,'
      
        '                                                                ' +
        '            RN.mnagreem agr1'
      
        '                                                                ' +
        '      WHERE agr1.treaty_id = agr.treaty_id'
      
        '                                                                ' +
        '        AND st1.agreem_id = agr1.id'
      
        '                                                                ' +
        '     )'
      '                                           )'
      
        '                                       AND er.currency_no = vitr' +
        'eaty.currency_no) -- '#1050#1091#1088#1089' '#1085#1072' '#1076#1072#1090#1091' '#1072#1082#1090#1072' '#1080#1083#1080' '#1085#1072' '#1073#1086#1083#1077#1077' '#1088#1072#1085#1085#1102#1102'*/'
      
        ' ORDER BY decode(agr.istfin_kod, 2, vitreaty.theme_plan_num, vit' +
        'reaty.treaty_id), vitreaty.treaty_id')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      03000000030000000A0000003A444154455F46524F4D0C000000000000000000
      0000080000003A444154455F544F0C0000000000000000000000050000003A43
      4F4E43030000000000000000000000}
    Left = 16
    Top = 342
  end
  object quDogYears: TOracleQuery
    SQL.Strings = (
      
        'SELECT  DISTINCT DECODE(vitreaty.treaty_status, '#39'P'#39', TO_CHAR(vit' +
        'reaty.datefrom, '#39'yyyy'#39'), TO_CHAR(NVL(st.DATEACT, st.DATETO), '#39'yy' +
        'yy'#39')) year,'
      
        '        COUNT(DISTINCT DECODE(vitreaty.treaty_status, '#39'P'#39', TO_CH' +
        'AR(vitreaty.datefrom, '#39'yyyy'#39'), TO_CHAR(NVL(st.DATEACT, st.DATETO' +
        '), '#39'yyyy'#39'))) OVER (PARTITION BY 1) count_years'
      '  FROM rn.mnagreem agr,'
      '       rn.vitreaty,'
      '       rn.mnstage st'
      
        ' WHERE (   (TO_DATE('#39'01.01'#39'||:YEAR, '#39'dd.mm.yyyy'#39') < TRUNC(vitrea' +
        'ty.DATEFROM, '#39'YEAR'#39')  AND TO_DATE('#39'01.01'#39'||(:YEAR + 1), '#39'dd.mm.y' +
        'yyy'#39') >= TRUNC(vitreaty.DATEFROM, '#39'YEAR'#39'))'
      
        '        OR (TO_DATE('#39'01.01'#39'||:YEAR, '#39'dd.mm.yyyy'#39') >= TRUNC(vitre' +
        'aty.DATEFROM, '#39'YEAR'#39') AND (TO_DATE('#39'01.01'#39'||:YEAR, '#39'dd.mm.yyyy'#39')' +
        ' <= TRUNC(vitreaty.DATETO, '#39'YEAR'#39')  OR vitreaty.treaty_status IN' +
        ' ('#39'P'#39', '#39'O'#39'))))'
      '   AND agr.treaty_id(+) = vitreaty.treaty_id'
      '   AND st.agreem_id(+) = agr.id'
      '   AND ((st.summpay > 0) OR (vitreaty.treaty_status = '#39'P'#39'))'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      
        '        OR agr.num = vitreaty.agreem_num or (vitreaty.treaty_sta' +
        'tus = '#39'P'#39'))'
      
        ' ORDER BY DECODE(vitreaty.treaty_status, '#39'P'#39', TO_CHAR(vitreaty.d' +
        'atefrom, '#39'yyyy'#39'), TO_CHAR(NVL(st.DATEACT, st.DATETO), '#39'yyyy'#39'))'
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {0300000001000000050000003A59454152030000000000000000000000}
    Left = 16
    Top = 398
  end
  object quPlanCurator: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id ID,'
      
        '       DECODE(vitreaty.treaty_status, '#39'P'#39', '#39#1055#1054' '#1050#1054#1053#1050#1059#1056#1057#1059#39', vitrea' +
        'ty.treaty_num || '#39', '#39'|| vitreaty.exec_name) name,'
      '       vitreaty.subject subject,'
      '       TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') tr_datefrom,'
      '       TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') tr_dateto,'
      '       vitreaty.summpay tr_summpay,'
      
        '       decode(vitreaty.treaty_status, '#39'P'#39', 933, vitreaty.currenc' +
        'y_no) currency_no,'
      '       vitreaty.treaty_status,'
      
        '       decode(vitreaty.treaty_status, '#39'P'#39', vitreaty.FIRST_YEAR_S' +
        'UMMPAY, NVL(st.summpay,0)) stage_summpay,'
      
        '       DECODE(decode(vitreaty.treaty_status, '#39'P'#39', 933, vitreaty.' +
        'currency_no),'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(NVL(st.dateact, SYSDATE), vitreaty.currency_no)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      
        '       RN.MONEY_PKG.GetLEqMaxDateOfExchange(NVL(st.dateact, SYSD' +
        'ATE), decode(vitreaty.treaty_status, '#39'P'#39', 933, vitreaty.currency' +
        '_no)) intro_date,'
      ''
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id, curator.mirab_tabn) count_per_treaty,'
      
        '       decode(vitreaty.treaty_status, '#39'P'#39', TO_CHAR(vitreaty.date' +
        'from, '#39'YYYY'#39'), TO_CHAR(NVL(st.dateact, st.dateto), '#39'YYYY'#39')) stag' +
        'e_year_to,'
      '       NVL(st.dateact, st.dateto) st_dateto,'
      '       st.dateact st_dateact,'
      
        '       decode(vitreaty.treaty_status, '#39'P'#39', TO_CHAR(vitreaty.date' +
        'from, '#39'mm'#39'), TO_CHAR(NVL(st.dateact, st.dateto), '#39'mm'#39')) stage_mo' +
        'nth_to,'
      '       currency.iso_name currency_name,'
      
        '       decode(vitreaty.treaty_status, '#39'P'#39', vitreaty.treaty_id, d' +
        'ecode(vitreaty.istfin_kod, 2, vitreaty.theme_plan_num, vitreaty.' +
        'treaty_id)) num,'
      '       vitreaty.istfin_kod istfin_kod,'
      
        '       decode(vitreaty.treaty_status, '#39'P'#39', NULL, decode(vitreaty' +
        '.istfin_kod, 2, RN.MITRCONCERN_PKG.getconcdogforinnavdog(TO_DATE' +
        '('#39'01.12.'#39' || :YEAR, '#39'dd.mm.yyyy'#39'), vitreaty.datefrom, vitreaty.d' +
        'ateto), NULL)) ConcDogID,'
      
        '       --COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.t' +
        'reaty_id) count_per_treaty,'
      
        '       COUNT(distinct vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_dog,'
      '       nvl(un_st.count_st, 0)  count_un_st,'
      '       nvl(pl_st.count_st, 0)  count_pl_st,'
      '       st.num st_num,'
      '       TO_CHAR(st.dateto, '#39'mm.yyyy'#39')  str_st_dateto,'
      '       curator.mirab_tabn tabn,'
      
        '       rab.FNAIM || '#39' '#39' || rab.INAIM || '#39' '#39' || rab.ONAIM CURATOR' +
        ','
      
        '       count(st.id) OVER (PARTITION BY st.id ORDER BY curator.mi' +
        'rab_tabn ) NUM_CURATOR'
      '  FROM rn.mntrcurator curator,'
      '       rn.vitreaty,'
      '       rn.currency,'
      '       --rn.exchange_rates,'
      '       rn.mnagreem agr,'
      '       rn.mnstage st,'
      '       (SELECT tr1.treaty_id tr_id, COUNT(*) count_st'
      '          FROM rn.vitreaty tr1,'
      '               rn.mnagreem agr1,'
      '               rn.mnstage st1'
      
        '         WHERE (TRUNC(TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') >= TRUNC(t' +
        'r1.DATEFROM, '#39'YEAR'#39') AND ((tr1.treaty_status <> '#39'P'#39') OR (TRUNC(T' +
        'O_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') <= tr1.DATEFROM)) AND (TRUNC(TO_D' +
        'ATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') <= TRUNC(tr1.DATETO, '#39'YEAR'#39')  OR tr1' +
        '.treaty_status = '#39'O'#39'))'
      '           AND agr1.treaty_id = tr1.treaty_id'
      '           AND st1.agreem_id = agr1.id'
      '           AND agr1.num = tr1.agreem_num'
      
        '           AND st1.dateto <  TRUNC(TO_DATE(TO_CHAR(:MONTH, '#39'00'#39')' +
        '||'#39'.'#39'||:YEAR, '#39'mm.yyyy'#39'), '#39'MONTH'#39')'
      '           AND st1.dateact IS NULL'
      '         GROUP BY tr1.treaty_id) un_st,'
      '       (SELECT tr1.treaty_id tr_id, COUNT(*) count_st'
      '          FROM rn.vitreaty tr1,'
      '               rn.mnagreem agr1,'
      '               rn.mnstage st1'
      
        '         WHERE (TRUNC(TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') >= TRUNC(t' +
        'r1.DATEFROM, '#39'YEAR'#39') AND ((tr1.treaty_status <> '#39'P'#39') OR (TRUNC(T' +
        'O_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') <= tr1.DATEFROM)) AND (TRUNC(TO_D' +
        'ATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') <= TRUNC(tr1.DATETO, '#39'YEAR'#39')  OR tr1' +
        '.treaty_status = '#39'O'#39'))'
      '           AND agr1.treaty_id = tr1.treaty_id'
      '           AND st1.agreem_id = agr1.id'
      
        '           AND (   (st1.dateact IS NOT NULL AND agr1.num < tr1.a' +
        'greem_num) -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '                OR agr1.num = tr1.agreem_num)'
      
        '           AND NVL(st1.dateact, st1.dateto) >= TRUNC(TO_DATE(TO_' +
        'CHAR(:MONTH, '#39'00'#39')||'#39'.'#39'||:YEAR, '#39'mm.yyyy'#39'), '#39'MONTH'#39')'
      
        '           AND NVL(st1.dateact, st1.dateto) < TRUNC(TO_DATE(:YEA' +
        'R + 1, '#39'yyyy'#39'), '#39'YEAR'#39')'
      '         GROUP BY tr1.treaty_id) pl_st,'
      '       p.mirab rab'
      ' WHERE rab.tabn(+) = curator.mirab_tabn'
      '   AND curator.treaty_id(+) = vitreaty.treaty_id'
      
        '   AND  (TRUNC(TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') >= TRUNC(vitreaty' +
        '.DATEFROM, '#39'YEAR'#39') AND ((vitreaty.treaty_status <> '#39'P'#39') OR (TRUN' +
        'C(TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') <= vitreaty.DATEFROM))  AND (T' +
        'RUNC(TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'yyyy'#39') <= TRUNC(vitreaty.DATETO, '#39 +
        'YEAR'#39')  OR vitreaty.treaty_status = '#39'O'#39'))'
      '   AND agr.treaty_id(+) = vitreaty.treaty_id'
      '   AND currency.currency_no(+) = vitreaty.currency_no'
      '   AND st.agreem_id(+) = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      
        '        OR agr.num = vitreaty.agreem_num or (vitreaty.treaty_sta' +
        'tus = '#39'P'#39'))'
      '   AND un_st.tr_id(+) = vitreaty.treaty_id'
      '   AND pl_st.tr_id(+) = vitreaty.treaty_id'
      
        ' ORDER BY  rab.FNAIM || rab.INAIM || rab.ONAIM, curator.mirab_ta' +
        'bn, decode(vitreaty.treaty_status, '#39'P'#39', 1, 0), vitreaty.istfin_k' +
        'od desc, decode(vitreaty.istfin_kod, 2, RN.MITRCONCERN_PKG.getco' +
        'ncdogforinnavdog(TO_DATE('#39'01.12.'#39' || :YEAR, '#39'dd.mm.yyyy'#39'), vitre' +
        'aty.datefrom, vitreaty.dateto), NULL), decode(vitreaty.treaty_st' +
        'atus, '#39'P'#39', vitreaty.treaty_id, decode(vitreaty.istfin_kod, 2, vi' +
        'treaty.theme_plan_num, vitreaty.treaty_id)), vitreaty.treaty_id,' +
        ' st.num'
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000002000000050000003A59454152030000000000000000000000060000
      003A4D4F4E5448030000000000000000000000}
    Left = 16
    Top = 285
  end
  object mdStruc: TVMetaDataSource
    DataSetList = <
      item
        DataSet = quMipodr
        DataSetName = 'quMipodr'
      end>
    Left = 128
  end
  object mdArch: TVMetaDataSource
    DataSetList = <>
    Left = 176
  end
  object quMipodr: TVASUPQuery
    SQL.Strings = (
      'SELECT distinct A.*,A.ROWID, B.KOD MIPODR_KOD,'
      'SUBSTR(B.PKOD,5)||'#39' '#39'||B.SNAIM VERH_PODR, B.PNAIM VERH_NAIM'
      'FROM p.VPODR A, p.MIPODR B'
      'WHERE B.ID=A.MIPODR_ID'
      'AND A.MIUROVEN_KOD = :DEPT_LEVEL')
    Optimize = False
    Variables.Data = {
      03000000010000000B0000003A444550545F4C4556454C030000000400000001
      00000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000D000000020000004944010000000000030000004B4F440100000000
      0005000000534E41494D01000000000005000000504E41494D01000000000009
      0000004D49504F44525F49440100000000000C0000004D4955524F56454E5F4B
      4F4401000000000004000000504B4F4401000000000006000000444154415650
      010000000000050000004E44535F4E010000000000050000004E44535F460100
      000000000A0000004D49504F44525F4B4F440100000000000900000056455248
      5F504F445201000000000009000000564552485F4E41494D010000000000}
    Cursor = crSQLWait
    QueryAllRecords = False
    RefreshOptions = [roBeforeEdit, roAfterInsert, roAfterUpdate]
    UpdatingTable = 'P.VPODR'
    CommitOnPost = False
    Session = seOracle
    BeforeOpen = quMipodrBeforeOpen
    ReActive = True
    Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1081
    Order = 'VERH_PODR ASC,A.KOD ASC'
    EditorClassName = 'TfmMipodr'
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 320
    Top = 122
    object quMipodrVERH_PODR: TStringField
      DisplayLabel = #1042#1077#1088#1093'. '#1087#1086#1076#1088'.'
      DisplayWidth = 18
      FieldKind = fkInternalCalc
      FieldName = 'VERH_PODR'
      Visible = False
      Size = 27
    end
    object quMipodrKOD: TIntegerField
      DisplayLabel = #1050#1086#1076
      DisplayWidth = 2
      FieldName = 'KOD'
      Origin = 'A.KOD'
      Required = True
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quMipodrSNAIM: TStringField
      DisplayLabel = #1057#1086#1082#1088'. '#1085#1072#1080#1084'.'
      FieldName = 'SNAIM'
      Origin = 'A.SNAIM'
      Required = True
      Size = 10
    end
    object quMipodrPNAIM: TStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'PNAIM'
      Origin = 'A.PNAIM'
      Required = True
      Size = 100
    end
    object quMipodrID: TFloatField
      Tag = 2
      DisplayLabel = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      FieldName = 'ID'
      Origin = 'A.ID'
      Visible = False
    end
    object quMipodrMIPODR_ID: TFloatField
      Tag = 2
      DisplayLabel = #1042#1077#1088#1093'. '#1087#1086#1076#1088'.'
      FieldName = 'MIPODR_ID'
      Origin = 'A.MIPODR_ID'
      Visible = False
      OnChange = quMipodrMIPODR_IDChange
    end
    object quMipodrMIPODR_KOD: TIntegerField
      Tag = 2
      DisplayLabel = #1050#1086#1076' '#1074#1077#1088#1093'. '#1087#1086#1076#1088'.'
      DisplayWidth = 2
      FieldKind = fkInternalCalc
      FieldName = 'MIPODR_KOD'
      Visible = False
      DisplayFormat = '00'
      EditFormat = '00'
    end
    object quMipodrVERH_NAIM: TStringField
      Tag = 2
      FieldKind = fkInternalCalc
      FieldName = 'VERH_NAIM'
      Visible = False
      Size = 100
    end
    object quMipodrMIUROVEN_KOD: TIntegerField
      Tag = 2
      DisplayWidth = 2
      FieldName = 'MIUROVEN_KOD'
      Origin = 'A.MIUROVEN_KOD'
      Visible = False
      DisplayFormat = '00'
      EditFormat = '00'
    end
  end
  object quRN15RN16_3_Rep: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id ID,'
      '       NULL treaty_num,'
      '       vitreaty.subject treaty_name,'
      '       '#39#1055#1054' '#1050#1054#1053#1050#1059#1056#1057#1059#39' exec_name,'
      '       vitreaty.datefrom date_from,'
      '       vitreaty.dateto date_to,'
      '       :REP_YEAR stage_dateto,'
      '       vitreaty.first_year_summpay stage_summpay,'
      '       vitreaty.summpay treaty_summpay,'
      '       vitreaty.CHAPTER_KOD subject_KOD,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty,'
      '       0 count_foreign_treaty,'
      '       933 currency_no,  -- '#1041#1077#1083#1072#1088#1091#1089#1082#1080#1081' '#1088#1091#1073#1072#1083#1100
      '       1 count_per_treaty,'
      '       SYSDATE INTO_DATE,'
      '       1 E_RATE,'
      
        '       COUNT(DISTINCT vitreaty.CHAPTER_KOD) OVER (PARTITION BY 1' +
        ') count_subject,'
      '       summary.summary summary,'
      '       vitreaty.treaty_status status,'
      '       vitreaty.podr_snaim,'
      '       vitreaty.podr_pnaim'
      '  FROM rn.vitreaty,'
      '       rn.mnsummary summary'
      
        ' WHERE vitreaty.datefrom BETWEEN TO_DATE('#39'01.01.'#39' || ( TO_CHAR(:' +
        'REP_YEAR, '#39'yyyy'#39') - 1), '#39'dd.mm.yyyy'#39' ) AND TO_DATE('#39'31.12'#39' || (T' +
        'O_CHAR(:REP_YEAR, '#39'yyyy'#39') - 1), '#39'dd.mm.yyyy'#39')'
      '   AND vitreaty.treaty_status = '#39'P'#39
      '   AND vitreaty.istfin_kod = :istfin_kod'
      '   AND summary.treaty_id(+) = vitreaty.treaty_id'
      ''
      ' ORDER BY vitreaty.CHAPTER_KOD, vitreaty.treaty_id'
      '/*SELECT ID,'
      '       treaty_num,'
      '       treaty_name,'
      '       exec_name,'
      '       date_from,'
      '       date_to,'
      '       currency_no,'
      '       stage_summpay,'
      '       treaty_summpay,'
      '       dateact,'
      '       stage_dateto,'
      '       e_rate,'
      '       into_date,'
      '       subject_KOD,'
      '       count_per_treaty,'
      '       currency_name,'
      '       COUNT(DISTINCT id) OVER (PARTITION BY 1) count_treaty,'
      
        '       COUNT(DISTINCT DECODE(CURRENCY_NO, 933, NULL, ID)) OVER (' +
        'PARTITION BY 1) count_foreign_treaty'
      '  FROM (SELECT vitreaty.treaty_id ID,'
      '               vitreaty.treaty_status STATUS,'
      '               vitreaty.treaty_num treaty_num,'
      '               vitreaty.subject treaty_name,'
      '               vitreaty.exec_name exec_name,'
      '               vitreaty.datefrom date_from,'
      '               vitreaty.dateto date_to,'
      '               vitreaty.currency_no currency_no,'
      '               0 stage_summpay,'
      '               vitreaty.summpay treaty_summpay,'
      '               TO_DATE(NULL) dateact,'
      '               TO_DATE(NULL) stage_dateto,'
      '               DECODE(vitreaty.currency_no,'
      '                      933,'
      '                      1,'
      '                      (SELECT ER.E_RATE'
      '                         FROM S.EXCHANGE_RATES er'
      
        '                        WHERE er.intro_date = RN.MONEY_PKG.GetLE' +
        'qMaxDateOfExchange(SYSDATE, vitreaty.currency_no)'
      
        '                          AND er.CURRENCY_NO = vitreaty.currency' +
        '_no'
      '                      )'
      '                     ) e_rate,'
      
        '               RN.MONEY_PKG.GetLEqMaxDateOfExchange(SYSDATE, vit' +
        'reaty.currency_no) into_date,'
      '               vitreaty.CHAPTER_KOD subject_KOD,'
      
        '               COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitr' +
        'eaty.treaty_id) count_per_treaty,'
      '               currency.iso_name currency_name'
      '          FROM rn.vitreaty,'
      '               s.currency'
      
        '         WHERE vitreaty.datefrom BETWEEN :REP_YEAR AND TO_DATE('#39 +
        '31.12'#39' || TO_CHAR(:REP_YEAR, '#39'yyyy'#39'), '#39'dd.mm.yyyy'#39')'
      '           AND vitreaty.treaty_status IN ('#39'P'#39', '#39'O'#39')'
      '           AND NOT EXISTS(SELECT *'
      '                            FROM RN.mnstage st,'
      '                                 RN.mnagreem agr'
      
        '                           WHERE vitreaty.treaty_id = agr.treaty' +
        '_id'
      '                             AND agr.id = st.agreem_id)'
      '           AND vitreaty.istfin_kod = :istfin_kod'
      '           AND currency.currency_no = vitreaty.currency_no'
      ''
      'UNION ALL'
      ''
      '        SELECT vitreaty.treaty_id ID,'
      '               vitreaty.treaty_status STATUS,'
      '               vitreaty.treaty_num treaty_num,'
      '               vitreaty.subject treaty_name,'
      '               vitreaty.exec_name exec_name,'
      
        '               MIN(st.datefrom) OVER (PARTITION BY vitreaty.trea' +
        'ty_id) date_from,'
      
        '               MAX(NVL(st.dateact, st.dateto)) OVER (PARTITION B' +
        'Y vitreaty.treaty_id) date_to,'
      '               vitreaty.currency_no currency_no,'
      '               NVL(st.summpay,0) stage_summpay,'
      '               vitreaty.summpay treaty_summpay,'
      '               st.dateact dateact,'
      '               NVL(st.dateact, st.dateto) stage_dateto,'
      '               DECODE(vitreaty.currency_no,'
      '                      933,'
      '                      1,'
      '                      (SELECT ER.E_RATE'
      '                         FROM S.EXCHANGE_RATES er'
      
        '                        WHERE er.intro_date = RN.MONEY_PKG.GetLE' +
        'qMaxDateOfExchange(NVL(st.dateact, SYSDATE), vitreaty.currency_n' +
        'o)'
      
        '                          AND er.CURRENCY_NO = vitreaty.currency' +
        '_no'
      '                      )'
      '                     ) e_rate,'
      
        '               RN.MONEY_PKG.GetLEqMaxDateOfExchange(NVL(st.datea' +
        'ct, SYSDATE), vitreaty.currency_no) into_date,'
      '               vitreaty.CHAPTER_KOD subject_KOD,'
      
        '               COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitr' +
        'eaty.treaty_id) count_per_treaty,'
      '               currency.iso_name currency_name'
      '          FROM rn.vitreaty,'
      '               rn.mnstage st,'
      '               rn.mnagreem agr,'
      '               s.currency'
      '         WHERE (SELECT MIN(st1.datefrom)'
      '                  FROM rn.mnagreem agr1,'
      '                       rn.mnstage st1'
      '                 WHERE vitreaty.treaty_id = agr1.treaty_id'
      '                   AND st1.agreem_id = agr1.id'
      
        '                   AND (   st1.dateact IS NOT NULL AND agr1.num ' +
        '< vitreaty.agreem_num'
      '                        OR agr1.num = vitreaty.agreem_num)'
      
        '               )BETWEEN :REP_YEAR AND TO_DATE('#39'31.12'#39' || TO_CHAR' +
        '(:REP_YEAR, '#39'yyyy'#39'), '#39'dd.mm.yyyy'#39')'
      '           AND vitreaty.treaty_status IN ('#39'P'#39', '#39'O'#39')'
      '           AND vitreaty.istfin_kod = :istfin_kod'
      '           AND currency.currency_no = vitreaty.currency_no'
      '           AND vitreaty.treaty_id = agr.treaty_id'
      '           AND st.agreem_id = agr.id'
      
        '           AND (   st.dateact IS NOT NULL AND agr.num < vitreaty' +
        '.agreem_num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '                OR agr.num = vitreaty.agreem_num))'
      ''
      ' ORDER BY subject_KOD, id */'
      ' '
      ' '
      ' '
      ' '
      ' '
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A5245505F594541520C00000000000000000000
      000B0000003A49535446494E5F4B4F44030000000000000000000000}
    Left = 264
    Top = 605
  end
  object quMiExchange: TVASUPQuery
    SQL.Strings = (
      'SELECT /*+ ORDERED INDEX(CURR PK_CURRENCY)*/ '
      '       A.ROWID,'
      '       A.YEAR YEAR,'
      '       A.CURRENCY_NO CURRENCY_NO,'
      '       CURR.ISO_NAME ISO_NAME,'
      '       CURR.NAME CURRENCY,'
      '       A.RATE RATE'
      '  FROM RN.MIEXCHANGE A,'
      '       S.CURRENCY CURR'
      ' WHERE A.CURRENCY_NO = CURR.CURRENCY_NO(+)'
      ' /* END_REFRESH */')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      040000000500000004000000594541520100000000000B00000043555252454E
      43595F4E4F0100000000000800000049534F5F4E414D45010000000000080000
      0043555252454E43590100000000000400000052415445010000000000}
    Cursor = crSQLWait
    UpdatingTable = 'RN.MIEXCHANGE'
    CommitOnPost = False
    Session = seOracle
    ReActive = True
    Caption = #1050#1091#1088#1089#1099' '#1074#1072#1083#1102#1090' '#1076#1083#1103' '#1090#1077#1084#1087#1083#1072#1085#1072
    Order = 'A.YEAR DESC,CURR.ISO_NAME ASC'
    AccessLevel = [aqQuerying, aqInserting, aqEditing, aqDeleting]
    EditorClassName = 'TfmExchange'
    LinkKind = lkIn
    UpdTabAlias = 'A'
    TreeNodeIndex = 0
    Left = 372
    Top = 106
    object quMiExchangeYEAR: TIntegerField
      DisplayLabel = #1043#1086#1076
      DisplayWidth = 4
      FieldName = 'YEAR'
      Origin = 'A.YEAR'
      Required = True
    end
    object quMiExchangeCURRENCY_NO: TIntegerField
      Tag = 2
      DisplayWidth = 5
      FieldName = 'CURRENCY_NO'
      Origin = 'A.CURRENCY_NO'
      Required = True
      Visible = False
      OnChange = quMiExchangeCURRENCY_NOChange
    end
    object quMiExchangeISO_NAME: TStringField
      DisplayLabel = #1042#1072#1083#1102#1090#1072
      FieldKind = fkInternalCalc
      FieldName = 'ISO_NAME'
      Origin = 'CURR.ISO_NAME'
      Required = True
      Size = 3
    end
    object quMiExchangeCURRENCY: TStringField
      DisplayLabel = #1053#1072#1084#1080#1085#1086#1074#1072#1085#1080#1077' '#1074#1072#1083#1102#1090#1099
      DisplayWidth = 25
      FieldKind = fkInternalCalc
      FieldName = 'CURRENCY'
      Origin = 'CURR.NAME'
      Required = True
      Size = 50
    end
    object quMiExchangeRATE: TFloatField
      DisplayLabel = #1050#1091#1088#1089
      DisplayWidth = 6
      FieldName = 'RATE'
      Required = True
    end
    object quMiExchangeLkCURRENCY: TStringField
      Tag = 2
      FieldKind = fkLookup
      FieldName = 'LkCURRENCY'
      LookupDataSet = odsCurrency
      LookupKeyFields = 'CURRENCY_NO'
      LookupResultField = 'NAME'
      KeyFields = 'CURRENCY_NO'
      Visible = False
      Lookup = True
    end
  end
  object odsCurrency: TOracleDataSet
    SQL.Strings = (
      'SELECT CURRENCY_NO, NAME '
      '  FROM S.CURRENCY'
      ' WHERE CURRENCY_NO in (643, 840, 826, 978, 756, 980)'
      
        ' ORDER by DECODE(CURRENCY_NO, 643, 1, 840, 2, 978, 3, 980, 4, 75' +
        '6, 5, 826, 6, 999)')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      04000000020000000B00000043555252454E43595F4E4F010000000000040000
      004E414D45010000000000}
    Session = seOracle
    Left = 184
    Top = 384
    object odsCurrencyCURRENCY_NO: TIntegerField
      FieldName = 'CURRENCY_NO'
      Required = True
    end
    object odsCurrencyNAME: TStringField
      DisplayWidth = 20
      FieldName = 'NAME'
      Required = True
      Size = 50
    end
  end
  object quRN01_Concern: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id,'
      '       vitreaty.treaty_num  treaty_num,'
      '       vitreaty.subject,'
      '       '#39#1069#1090#1072#1087' '#39' || st.num stage_num,'
      '       firm_account.currency_no,'
      '       st.summpay stage_summpay,'
      '       st.dateact stage_dateact,'
      '       exchange_rates.e_rate e_rate,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      
        '       decode(agr.istfin_kod, 2, vitreaty.theme_plan_num, vitrea' +
        'ty.treaty_id) num,'
      '       vitreaty.exec_name exec_name,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY 1) count_sta' +
        'ge,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty,'
      '       st.Reporting Reporting,'
      
        '       NVL(ST.DATEPAY, DECODE(:typ, 3025, m.vns_pack.getpdmaxpda' +
        'te(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id), d.doc_dat' +
        'e))) DATEPAY -- '#1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1082#1080
      
        '--       NVL(ST.DATEPAY, nvl(m.vns_pack.getpdmaxpdate(l.doc_id),' +
        ' d.doc_date)) datepay'
      '  FROM RN.vitreaty,'
      '       RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       S.firm_account,'
      '       S.firm,'
      '       S.exchange_rates,'
      '       M.DOCUMENTS SW,'
      '       M.vns_pd_div_lines l,'
      '       M.vns_pd_div_lines l2,'
      '       M.DOCUMENTS d'
      '  WHERE (  (st.dateact BETWEEN :v_datefrom'
      '                           AND LAST_DAY(:v_dateto))'
      '         or'
      
        '           (NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(l.doc_i' +
        'd), d.doc_date)) BETWEEN :v_datefrom'
      
        '                                                                ' +
        '    AND LAST_DAY(:v_dateto)))'
      '   AND agr.id = st.agreem_id'
      '   AND agr.istfin_kod = 2'
      
        '   AND ((:CONC IS NULL) OR (:CONC = RN.mitrconcern_pkg.GetConcDo' +
        'gForInnavDog(:V_DATEFROM, vitreaty.DATEFROM, vitreaty.DATETO)))'
      '   AND firm_account.bank_accnt_id = st.exec_account_id'
      '   AND firm.firm_no = firm_account.firm_no'
      '   AND exchange_rates.currency_no = firm_account.currency_no'
      '   AND exchange_rates.intro_date = (SELECT MAX(er.intro_date)'
      '                                      FROM S.exchange_rates er'
      
        '                                     WHERE er.intro_date <= st.d' +
        'ateact'
      
        '                                       AND er.currency_no = firm' +
        '_account.currency_no)'
      '   AND vitreaty.treaty_id = agr.treaty_id'
      '   AND SW.DOC_NO(+) = st.special_written'
      '   AND l.SW_ID(+) = SW.DOC_NO'
      '   AND d.doc_no(+) = l.doc_id'
      '--   AND l.sw_id(+) = st.SPECIAL_WRITTEN '
      '   --AND st.summpay <> 0'
      '--   AND d.DOC_NO(+) = l.DOC_ID'
      '   AND l2.doc_id(+) = SW.DOC_NO'
      ''
      
        ' ORDER BY decode(agr.istfin_kod, 2, vitreaty.theme_plan_num, vit' +
        'reaty.treaty_id), vitreaty.treaty_id,'
      
        '          DECODE(NVL(ST.DATEPAY, m.vns_pack.getpdmaxpdate(l.doc_' +
        'id)), NULL, 2, 1), st.num'
      ''
      ''
      ' ')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      03000000040000000B0000003A565F4441544546524F4D0C0000000000000000
      000000090000003A565F44415445544F0C000000000000000000000005000000
      3A434F4E43030000000000000000000000040000003A54595003000000040000
      00FE01000000000000}
    Left = 155
    Top = 474
  end
  object quPayment_1: TOracleQuery
    SQL.Strings = (
      
        'SELECT /*+ INDEX(st AGR_DATEAKT_I) INDEX(l IDX_VPDDL_REF_DOCS_SW' +
        ') INDEX(d PK_DOCUMENTS) INDEX(agr AGREEM_PK) INDEX(tr TREATY_PK)' +
        ' INDEX(fa AK_BANK_ACCNT_ID_FIRM_ACC) INDEX(f PK_FIRM) INDEX(cr P' +
        'K_CURRENCY)*/'
      '       tr.id tr_id,'
      '       tr.plat_doc_type pdt,'
      '       tr.num || CHR(10) || f.name tr_num,'
      '       tr.STATUS tr_status,'
      '       agr.subject tr_subject,'
      '       st.num st_num,'
      '       st.dateact,'
      '       st.summpay st_summpay,'
      #9'st.Reporting,'
      
        '       NVL(ST.NUMPAY, decode(tr.plat_doc_type,3025,sw.doc_ext_no' +
        ',d.doc_ext_no)) NUMPAY,'
      
        '       NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pack' +
        '.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id' +
        '), d.doc_date))) DATEPAY,'
      '--       NVL(st.NUMPAY, d.doc_ext_no) NUMPAY,'
      
        '--       TO_CHAR(NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(l.' +
        'doc_id), d.doc_date)), '#39'dd.mm.yyyy'#39') datepay,'
      
        '       COUNT(ST.ID) OVER (PARTITION BY tr.id) count_treaty_stage' +
        ','
      '       COUNT(ST.ID) OVER (PARTITION BY 1) count_stage,'
      '       '
      '       DECODE(fa.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(st.dateact, fa.currency_no)'
      '                  AND er.CURRENCY_NO = fa.currency_no'
      '              )'
      '             ) e_rate,       '
      
        '       TO_CHAR(DECODE(fa.currency_no, 933, TRUNC(SYSDATE), RN.MO' +
        'NEY_PKG.GetLEqMaxDateOfExchange(st.dateact, fa.currency_no)),'
      '                '#39'dd.mm.yyyy'#39') intro_date,'
      '       fa.currency_no currency_no,'
      '       cr.ISO_NAME currency,'
      '       '
      '       SUM(DECODE(fa.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(st.dateact, fa.currency_no)'
      '                  AND er.CURRENCY_NO = fa.currency_no'
      '              )'
      
        '             )*DECODE(TRUNC(NVL(ST.DATEPAY, DECODE(tr.plat_doc_t' +
        'ype, 3025, m.vns_pack.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.g' +
        'etpdmaxpdate(l.doc_id), d.doc_date))), '#39'MONTH'#39'), TRUNC(:REP_DATE' +
        ', '#39'MONTH'#39'), st.summpay, 0)) over (PARTITION BY tr.id) MONTH_TREA' +
        'TY_SUMMPAY,'
      ''
      '       SUM(DECODE(fa.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(st.dateact, fa.currency_no)'
      '                  AND er.CURRENCY_NO = fa.currency_no'
      '              )'
      
        '             )*st.SUMMPAY) over (PARTITION BY tr.id) YEAR_TREATY' +
        '_SUMMPAY'
      '  FROM RN.mnstage st,'
      '       M.DOCUMENTS SW,'
      '       M.vns_pd_div_lines l,'
      '       M.vns_pd_div_lines l2,'
      '       M.DOCUMENTS d,'
      '       RN.MNAGREEM agr,'
      '       RN.MNTREATY tr,'
      '       firm_account fa,'
      '       firm f,'
      '       CURRENCY cr'
      ' WHERE st.DATEACT IS NOT NULL'
      '   AND SW.DOC_NO(+) = st.SPECIAL_WRITTEN'
      '   AND l.sw_id(+) = SW.DOC_NO'
      '   AND d.DOC_NO(+) = l.DOC_ID'
      '   AND l2.doc_id(+) = SW.DOC_NO'
      '--   AND l.sw_id(+) = st.SPECIAL_WRITTEN'
      
        '   AND NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pack' +
        '.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id' +
        '), d.doc_date))) BETWEEN TRUNC(:REP_DATE, '#39'YEAR'#39')'
      
        '                                                                ' +
        '    AND TRUNC(ADD_MONTHS(:REP_DATE, 12), '#39'YEAR'#39')'
      
        '   AND NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pack' +
        '.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id' +
        '), d.doc_date))) <> TRUNC(ADD_MONTHS(:REP_DATE, 12), '#39'YEAR'#39')'
      '   AND agr.ID = st.agreem_ID'
      '   AND tr.id = agr.treaty_id'
      '   AND agr.ISTFIN_KOD = 1'
      '   '
      '   AND fa.bank_accnt_id(+) = st.exec_account_id'
      '   AND f.firm_no = fa.firm_no'
      '   AND st.summpay > 0'
      '   AND cr.CURRENCY_NO = fa.CURRENCY_NO'
      ' ORDER BY tr.id,'
      
        '          NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_p' +
        'ack.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc' +
        '_id), d.doc_date))),'
      '          st.num'
      '')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      0300000001000000090000003A5245505F444154450C00000000000000000000
      00}
    Left = 184
    Top = 60
  end
  object quPayment_2: TOracleQuery
    SQL.Strings = (
      'SELECT vitreaty.treaty_id,'
      '       vitreaty.treaty_num,'
      '       vi_all.dd,'
      '       vi_all.stage_summpay_RB,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty'
      
        '  FROM (SELECT treaty_id, months, SUM(stage_summpay_rb) stage_su' +
        'mmpay_RB, dd'
      '         FROM'
      '        ('
      
        '         SELECT DISTINCT qry.treaty_id, MAX(qry.months) months, ' +
        'stage_summpay_RB, MAX(qry.dd) dd, qry.stage_id FROM '
      '        ((SELECT DISTINCT mntreaty.id treaty_id,'
      
        '               TRUNC(NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdat' +
        'e(l.doc_id), d.doc_date)),'#39'MM'#39') months,'
      
        '               (exchange_rates.e_rate*st.summpay) stage_summpay_' +
        'RB,'
      
        '               TO_NUMBER(TO_CHAR(NVL(ST.DATEPAY, NVL(m.vns_pack.' +
        'getpdmaxpdate(l.doc_id), d.doc_date)),'#39'MM'#39')) dd,'
      '               st.id stage_id'
      '          FROM RN.mntreaty,'
      '               RN.mnstage st,'
      '               RN.mnagreem agr,'
      '               M.vns_pd_div_lines l,'
      '               M.DOCUMENTS d,'
      '               S.firm_account,'
      '               S.firm,'
      '               S.exchange_rates'
      '          WHERE st.DATEACT IS NOT NULL'
      '            AND l.sw_id(+) = st.SPECIAL_WRITTEN'
      '            AND d.DOC_NO(+) = l.DOC_ID'
      
        '            AND NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(l.d' +
        'oc_id), d.doc_date)) BETWEEN :v_datefrom'
      '                               AND LAST_DAY(:v_dateto)'
      '           AND agr.id = st.agreem_id'
      '           AND agr.istfin_kod = :v_istfin_kod'
      '           AND firm_account.bank_accnt_id = st.exec_account_id'
      '           AND firm.firm_no = firm_account.firm_no'
      
        '           AND exchange_rates.currency_no = firm_account.currenc' +
        'y_no'
      
        '           AND exchange_rates.intro_date = (SELECT MAX(er.intro_' +
        'date)'
      
        '                                              FROM S.exchange_ra' +
        'tes er'
      
        '                                             WHERE er.intro_date' +
        ' <= st.dateact'
      
        '                                               AND er.currency_n' +
        'o = firm_account.currency_no)'
      '           AND mntreaty.id = agr.treaty_id)'
      '          UNION ALL'
      '          (SELECT DISTINCT mntreaty.id treaty_id,'
      
        '               TRUNC(NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdat' +
        'e(l.doc_id), d.doc_date)),'#39'MM'#39') months,'
      
        '               (exchange_rates.e_rate*st.summpay) stage_summpay_' +
        'RB,'
      
        '               TO_NUMBER(TO_CHAR(NVL(ST.DATEPAY, NVL(m.vns_pack.' +
        'getpdmaxpdate(l.doc_id), d.doc_date)),'#39'MM'#39')) dd,'
      #9#9' st.id stage_id'
      '          FROM RN.mntreaty,'
      '               RN.mnstage st,'
      '               RN.mnagreem agr,'
      '               M.vns_pd_div_lines l,'
      '               M.DOCUMENTS d,'
      '               S.firm_account,'
      '               S.firm,'
      '               S.exchange_rates'
      '          WHERE st.DATEACT IS NOT NULL'
      '            AND l.doc_id(+) = st.SPECIAL_WRITTEN'
      '            AND d.DOC_NO(+) = l.DOC_ID'
      
        '            AND NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(l.d' +
        'oc_id), d.doc_date)) BETWEEN :v_datefrom'
      '                               AND LAST_DAY(:v_dateto)'
      '           AND agr.id = st.agreem_id'
      '           AND agr.istfin_kod = :v_istfin_kod'
      '           AND firm_account.bank_accnt_id = st.exec_account_id'
      '           AND firm.firm_no = firm_account.firm_no'
      
        '           AND exchange_rates.currency_no = firm_account.currenc' +
        'y_no'
      
        '           AND exchange_rates.intro_date = (SELECT MAX(er.intro_' +
        'date)'
      
        '                                              FROM S.exchange_ra' +
        'tes er'
      
        '                                             WHERE er.intro_date' +
        ' <= st.dateact'
      
        '                                               AND er.currency_n' +
        'o = firm_account.currency_no)'
      '           AND mntreaty.id = agr.treaty_id)) qry '
      '         GROUP BY qry.treaty_id, stage_summpay_RB, qry.stage_id'
      '                 '
      '        )'
      '         GROUP BY treaty_id, months, dd'
      '       ) vi_all,'
      '       RN.vitreaty'
      ' WHERE vitreaty.treaty_id = vi_all.treaty_id'
      ''
      '   AND vitreaty.treaty_status NOT IN ('#39'A'#39', '#39'P'#39')'
      '   AND (:V_DATEFROM IS NULL or :V_DATEFROM IS NOT NULL)'
      '   AND (:V_DATETO IS NULL or :V_DATETO IS NOT NULL)'
      
        '   AND ((:CONC IS NULL) OR (:CONC = RN.mitrconcern_pkg.GetConcDo' +
        'gForInnavDog(:V_DATETO, vitreaty.DATEFROM, vitreaty.DATETO)))'
      ''
      ' ORDER BY vitreaty.treaty_num,'
      '          vitreaty.treaty_id,'
      '          vi_all.months'
      ''
      '')
    Session = seOracle
    Optimize = False
    Variables.Data = {
      03000000040000000B0000003A565F4441544546524F4D0C0000000000000000
      000000090000003A565F44415445544F0C00000000000000000000000D000000
      3A565F49535446494E5F4B4F44030000000000000000000000050000003A434F
      4E43030000000000000000000000}
    Left = 256
    Top = 59
  end
  object opNIOKR_Tax: TOraclePackage
    Session = seOracle
    PackageName = 'RN.NIOKR_TAX'
    Left = 88
    Top = 48
  end
  object pkgFirmAccess: TOraclePackage
    Session = seOracle
    PackageName = 's.firm_access_pack'
    Left = 8
    Top = 48
  end
  object odsRN01_02: TOracleDataSet
    SQL.Strings = (
      'SELECT vitreaty.treaty_id,'
      '       vitreaty.treaty_num  treaty_num,'
      '       vitreaty.subject,'
      '       '#39#1069#1090#1072#1087' '#39' || st.num stage_num,'
      '       firm_account.currency_no,'
      
        '       DECODE(firm_account.CURRENCY_NO, 933, st.summpay, 0) stag' +
        'e_summpay_rub, '
      
        '       DECODE(firm_account.CURRENCY_NO, 933, 0, st.summpay) stag' +
        'e_summpay_cur,'
      '       st.dateact stage_dateact,'
      
        '       REPLACE(DECODE(TO_CHAR(exchange_rates.e_rate),'#39'1'#39','#39#39',TO_C' +
        'HAR(exchange_rates.e_rate)),'#39','#39','#39'.'#39') e_rate,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.tre' +
        'aty_id) count_per_treaty,'
      
        '       decode(agr.istfin_kod, 2, vitreaty.theme_plan_num, vitrea' +
        'ty.treaty_id) num ,'
      '       vitreaty.exec_name exec_name,'
      
        '       COUNT(vitreaty.treaty_id) OVER (PARTITION BY 1) count_sta' +
        'ge,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty,'
      '       st.Reporting Reporting'
      '  FROM RN.vitreaty,'
      '       RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       S.firm_account,'
      '       S.firm,'
      '       S.exchange_rates'
      '  WHERE st.dateact BETWEEN :v_datefrom'
      '                       AND LAST_DAY(:v_dateto)'
      '   AND agr.id = st.agreem_id'
      '   AND agr.istfin_kod = :v_istfin_kod'
      
        '   AND ((:CONC IS NULL) OR (:CONC = RN.mitrconcern_pkg.GetConcDo' +
        'gForInnavDog(:V_DATEFROM, vitreaty.DATEFROM, vitreaty.DATETO)))'
      
        '   --AND ((:CONC_DATETO IS NULL) OR (TRUNC(vitreaty.datefrom, '#39'M' +
        'ONTH'#39') <= :CONC_DATETO))'
      
        '   --AND ((:CONC_DATEFROM IS NULL) OR (TRUNC(vitreaty.datefrom, ' +
        #39'MONTH'#39') >= :CONC_DATEFROM))'
      '   AND firm_account.bank_accnt_id = st.exec_account_id'
      '   AND firm.firm_no = firm_account.firm_no'
      '   AND exchange_rates.currency_no = firm_account.currency_no'
      '   AND exchange_rates.intro_date = (SELECT MAX(er.intro_date)'
      '                                      FROM S.exchange_rates er'
      
        '                                     WHERE er.intro_date <= st.d' +
        'ateact'
      
        '                                       AND er.currency_no = firm' +
        '_account.currency_no)'
      '   AND vitreaty.treaty_id = agr.treaty_id'
      
        ' ORDER BY decode(agr.istfin_kod, 2, vitreaty.theme_plan_num, vit' +
        'reaty.treaty_id), vitreaty.treaty_id,'
      '          st.num')
    Optimize = False
    Variables.Data = {
      03000000040000000B0000003A565F4441544546524F4D0C0000000700000078
      730C0101010100000000090000003A565F44415445544F0C0000000700000078
      740201010101000000000D0000003A565F49535446494E5F4B4F440300000004
      0000000100000000000000050000003A434F4E43030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000F000000090000005452454154595F49440100000000000A00000054
      52454154595F4E554D010000000000070000005355424A454354010000000000
      0900000053544147455F4E554D0100000000000B00000043555252454E43595F
      4E4F0100000000000D00000053544147455F4441544541435401000000000006
      000000455F5241544501000000000010000000434F554E545F5045525F545245
      415459010000000000030000004E554D01000000000009000000455845435F4E
      414D450100000000000B000000434F554E545F53544147450100000000000C00
      0000434F554E545F545245415459010000000000090000005245504F5254494E
      470100000000001100000053544147455F53554D4D5041595F52554201000000
      00001100000053544147455F53554D4D5041595F435552010000000000}
    Session = seOracle
    Left = 512
    Top = 8
    object fltfldRN01_02TREATY_ID: TFloatField
      FieldName = 'TREATY_ID'
      Required = True
    end
    object odsRN01_02TREATY_NUM: TStringField
      FieldName = 'TREATY_NUM'
      Required = True
    end
    object odsRN01_02SUBJECT: TStringField
      FieldName = 'SUBJECT'
      Required = True
      Size = 1000
    end
    object odsRN01_02STAGE_NUM: TStringField
      FieldName = 'STAGE_NUM'
      Size = 18
    end
    object intfldRN01_02CURRENCY_NO: TIntegerField
      FieldName = 'CURRENCY_NO'
    end
    object dtfldRN01_02STAGE_DATEACT: TDateTimeField
      FieldName = 'STAGE_DATEACT'
    end
    object odsRN01_02E_RATE: TStringField
      FieldName = 'E_RATE'
      Size = 40
    end
    object fltfldRN01_02COUNT_PER_TREATY: TFloatField
      FieldName = 'COUNT_PER_TREATY'
    end
    object fltfldRN01_02NUM: TFloatField
      FieldName = 'NUM'
    end
    object odsRN01_02EXEC_NAME: TStringField
      FieldName = 'EXEC_NAME'
      Size = 120
    end
    object fltfldRN01_02COUNT_STAGE: TFloatField
      FieldName = 'COUNT_STAGE'
    end
    object fltfldRN01_02COUNT_TREATY: TFloatField
      FieldName = 'COUNT_TREATY'
    end
    object odsRN01_02REPORTING: TStringField
      FieldName = 'REPORTING'
      Size = 1000
    end
    object fltfldRN01_02STAGE_SUMMPAY_RUB: TFloatField
      FieldName = 'STAGE_SUMMPAY_RUB'
    end
    object fltfldRN01_02STAGE_SUMMPAY_CUR: TFloatField
      FieldName = 'STAGE_SUMMPAY_CUR'
    end
  end
  object frdsRN01_02: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = True
    FieldAliases.Strings = (
      'TREATY_ID=TREATY_ID'
      'TREATY_NUM=TREATY_NUM'
      'SUBJECT=SUBJECT'
      'STAGE_NUM=STAGE_NUM'
      'CURRENCY_NO=CURRENCY_NO'
      'STAGE_DATEACT=STAGE_DATEACT'
      'E_RATE=E_RATE'
      'COUNT_PER_TREATY=COUNT_PER_TREATY'
      'NUM=NUM'
      'EXEC_NAME=EXEC_NAME'
      'COUNT_STAGE=COUNT_STAGE'
      'COUNT_TREATY=COUNT_TREATY'
      'REPORTING=REPORTING'
      'STAGE_SUMMPAY_RUB=STAGE_SUMMPAY_RUB'
      'STAGE_SUMMPAY_CUR=STAGE_SUMMPAY_CUR')
    DataSet = odsRN01_02
    BCDToCurrency = False
    Left = 512
    Top = 56
  end
  object frRN01_02: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Modal = False
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42434.394970810200000000
    ReportOptions.LastChange = 42440.408765856500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 512
    Top = 104
    Datasets = <
      item
        DataSet = frdsRN01_02
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' MyVars'
        Value = Null
      end
      item
        Name = 'GLING'
        Value = Null
      end
      item
        Name = 'DATE_YEAR'
        Value = Null
      end
      item
        Name = 'NACHOTD'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 185.196970000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#164#1056#1109#1057#1026#1056#1112#1056#176' RN-02')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 668.976810000000000000
          Width = 377.953000000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1032#1056#1118#1056#8217#1056#8226#1056#160#1056#8211#1056#8221#1056#1106#1056#174
            
              #1056#8220#1056#187#1056#176#1056#1030#1056#1029#1057#8249#1056#8470' '#1056#1105#1056#1029#1056#182#1056#181#1056#1029#1056#181#1057#1026' '#1056#1115#1056#1106#1056#1115' "'#1056#8216#1056#181#1056#187#1056#176#1057#1026#1057#1107#1057#1027#1057#1034#1056#1108#1056#176#1056#187#1056#1105#1056#8470 +
              '"')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 668.976810000000000000
          Top = 41.574830000000000000
          Width = 377.953000000000000000
          Height = 75.590600000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            ''
            '_______________[GLING]'
            ''
            '"_____"________________20___'#1056#1110'.')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 128.504020000000000000
          Width = 925.984850000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#1115#1056#1118#1056#167#1056#1027#1056#1118' '#1056#1115' '#1056#8217#1056#171#1056#1119#1056#1115#1056#8250#1056#1116#1056#8226#1056#1116#1056#152#1056#152' '#1056#160#1056#1106#1056#8216#1056#1115#1056#1118' '#1056#1119#1056#1115' '#1056#8221#1056#1115#1056#8220#1056#1115#1056#8217#1056#1115#1056 +
              #160#1056#1106#1056#1114', '#1056#164#1056#152#1056#1116#1056#1106#1056#1116#1056#1038#1056#152#1056#160#1056#1032#1056#8226#1056#1114#1056#171#1056#1114' '#1056#152#1056#8212' '#1056#1119#1056#160#1056#152#1056#8216#1056#171#1056#8250#1056#152' '#1056#1119#1056#160#1056#8226#1056#8221#1056#1119 +
              #1056#160#1056#152#1056#1031#1056#1118#1056#152#1056#1031
            #1056#8212#1056#1106' [DATE_YEAR] '#1056#1110'.')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 166.299320000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[<Date>][<Time>]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 75.590600000000000000
        Top = 302.362400000000000000
        Width = 1046.929810000000000000
        object Memo14: TfrxMemoView
          Top = 60.472480000000010000
          Width = 37.795300000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 37.795300000000000000
          Top = 60.472480000000010000
          Width = 170.078850000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 207.874150000000000000
          Top = 60.472480000000010000
          Width = 264.567100000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 472.441250000000000000
          Top = 60.472480000000010000
          Width = 94.488250000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 566.929500000000000000
          Top = 60.472480000000010000
          Width = 75.590600000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 642.520100000000000000
          Top = 60.472480000000010000
          Width = 56.692950000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 699.213050000000000000
          Top = 60.472480000000010000
          Width = 75.590600000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 774.803650000000000000
          Top = 60.472480000000010000
          Width = 272.126160000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Width = 37.795300000000000000
          Height = 60.472480000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111'/'#1056#1111', '#1057#8364#1056#1105#1057#8222#1057#1026)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 37.795300000000000000
          Width = 170.078850000000000000
          Height = 60.472480000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176', '#1056#1105#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 207.874150000000000000
          Width = 264.567100000000000000
          Height = 60.472480000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 472.441250000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 774.803650000000000000
          Width = 272.126160000000000000
          Height = 60.472480000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#1113#1057#1026#1056#176#1057#8218#1056#1108#1056#1109#1056#181' '#1057#1027#1056#1109#1056#1169#1056#181#1057#1026#1056#182#1056#176#1056#1029#1056#1105#1056#181' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1029#1057#8249#1057#8230' '#1057#1026#1056#176#1056 +
              #177#1056#1109#1057#8218)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 472.441250000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#1030' '#1056#1030#1056#176#1056#187#1057#1035#1057#8218#1056#181)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 566.929500000000000000
          Top = 18.897650000000000000
          Width = 75.590600000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8221#1056#176#1057#8218#1056#176' '#1056#1109#1056#1111#1056#187#1056#176#1057#8218#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 642.520100000000000000
          Top = 18.897650000000000000
          Width = 56.692950000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1113#1057#1107#1057#1026#1057#1027)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 699.213050000000000000
          Top = 18.897650000000000000
          Width = 75.590600000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1107#1056#1112#1056#1112#1056#176' '#1056#1030' '#1057#1026#1057#1107#1056#177#1056#187#1057#1039#1057#8230' '#1056#160#1056#8216)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 226.771800000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo6: TfrxMemoView
          Width = 37.795300000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 37.795300000000000000
          Width = 170.078850000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 207.874150000000000000
          Width = 264.567100000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 472.441250000000000000
          Width = 94.488250000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 566.929500000000000000
          Width = 75.590600000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 642.520100000000000000
          Width = 56.692950000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 699.213050000000000000
          Width = 75.590600000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 774.803650000000000000
          Width = 272.126160000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 445.984540000000000000
        Width = 1046.929810000000000000
        DataSet = frdsRN01_02
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo39: TfrxMemoView
          Width = 37.795300000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsItalic]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8 = (
            '[frxDBDataset1."NUM"]')
          ParentFont = False
          SuppressRepeated = True
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 37.795300000000000000
          Width = 170.078850000000000000
          Height = 18.897637795275600000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 207.874150000000000000
          Width = 264.567100000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_NUM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 472.441250000000000000
          Width = 94.488250000000000000
          Height = 18.897637800000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_SUMMPAY_CUR"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo43: TfrxMemoView
          Left = 566.929500000000000000
          Width = 75.590600000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_DATEACT"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo44: TfrxMemoView
          Left = 642.520100000000000000
          Width = 56.692950000000000000
          Height = 18.897637795275600000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDBDataset1."E_RATE"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo45: TfrxMemoView
          Left = 699.213050000000000000
          Width = 75.590600000000000000
          Height = 18.897637800000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_SUMMPAY_RUB"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo46: TfrxMemoView
          Left = 774.803650000000000000
          Width = 272.126160000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 400.630180000000000000
        Width = 1046.929810000000000000
        AllowSplit = True
        Condition = 'frxDBDataset1."TREATY_ID"'
        Stretched = True
        object Memo31: TfrxMemoView
          Width = 37.795300000000000000
          Height = 22.677165354330700000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8 = (
            '[Line#]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 37.795300000000000000
          Width = 170.078850000000000000
          Height = 22.677165354330700000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8 = (
            '[frxDBDataset1."TREATY_NUM"]'
            '[frxDBDataset1."EXEC_NAME"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 207.874150000000000000
          Width = 264.567100000000000000
          Height = 22.677165350000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          GapX = 4.000000000000000000
          GapY = 4.000000000000000000
          HAlign = haBlock
          Memo.UTF8 = (
            '[frxDBDataset1."SUBJECT"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 472.441250000000000000
          Width = 94.488250000000000000
          Height = 22.677165354330700000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haRight
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo35: TfrxMemoView
          Left = 566.929500000000000000
          Width = 75.590600000000000000
          Height = 22.677165354330700000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 642.520100000000000000
          Width = 56.692950000000000000
          Height = 22.677165354330700000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 699.213050000000000000
          Width = 75.590600000000000000
          Height = 22.677165354330700000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 774.803650000000000000
          Width = 272.126025750000000000
          Height = 22.677165350000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          GapX = 4.000000000000000000
          GapY = 4.000000000000000000
          HAlign = haBlock
          Memo.UTF8 = (
            '[frxDBDataset1."REPORTING"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 487.559370000000000000
        Width = 1046.929810000000000000
        object Memo47: TfrxMemoView
          Width = 37.795300000000000000
          Height = 3.779527559055120000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 37.795300000000000000
          Width = 170.078850000000000000
          Height = 3.779527559055120000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 207.874150000000000000
          Width = 264.567100000000000000
          Height = 3.779527559055120000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 472.441250000000000000
          Width = 94.488250000000000000
          Height = 3.779527559055120000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Left = 566.929500000000000000
          Width = 75.590600000000000000
          Height = 3.779527559055120000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Left = 642.520100000000000000
          Width = 56.692950000000000000
          Height = 3.779527559055120000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo53: TfrxMemoView
          Left = 699.213050000000000000
          Width = 75.590600000000000000
          Height = 3.779527559055120000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 774.803650000000000000
          Width = 272.126160000000000000
          Height = 3.779527560000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 514.016080000000000000
        Width = 1046.929810000000000000
        object Memo55: TfrxMemoView
          Left = 347.716760000000000000
          Top = 15.118119999999980000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1109' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218' '#1056#1029#1056#176' '#1057#1027#1057#1107#1056#1112#1056#1112#1057#1107': ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 631.181510000000000000
          Top = 15.118119999999980000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."STAGE_SUMMPAY_RUB">,MasterData1)] '#1057#1026'.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 612.283860000000000000
        Width = 1046.929810000000000000
        object Memo57: TfrxMemoView
          Left = 207.874150000000000000
          Top = 7.559060000000045000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1116#1056#176#1057#8225#1056#176#1056#187#1057#1034#1056#1029#1056#1105#1056#1108' '#1056#1109#1057#8218#1056#1169#1056#181#1056#187#1056#176'_________________')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 472.441250000000000000
          Top = 7.559060000000045000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[NACHOTD]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 714.331170000000000000
        Width = 1046.929810000000000000
        object Memo59: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[Page#]')
          ParentFont = False
        end
      end
    end
  end
  object odsTOPMAN: TOracleDataSet
    SQL.Strings = (
      'SELECT a.id, a.snaim, a.pnaim, a.dolzhn, a.kod'
      '  FROM mitopmanager a')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      040000000500000002000000494401000000000005000000534E41494D010000
      00000005000000504E41494D01000000000006000000444F4C5A484E01000000
      0000030000004B4F44010000000000}
    Session = seOracle
    Left = 440
    Top = 400
    object fltfldTOPMANID: TFloatField
      FieldName = 'ID'
    end
    object odsTOPMANKOD: TStringField
      FieldName = 'KOD'
      Required = True
      Size = 10
    end
    object odsTOPMANSNAIM: TStringField
      FieldName = 'SNAIM'
      Size = 50
    end
    object odsTOPMANPNAIM: TStringField
      FieldName = 'PNAIM'
      Size = 500
    end
    object odsTOPMANDOLZHN: TStringField
      FieldName = 'DOLZHN'
      Size = 150
    end
  end
  object frexpPDF: TfrxPDFExport
    FileName = 'C:\.pdf'
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 42449.978847407410000000
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 100
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 360
    Top = 648
  end
  object frexpODT: TfrxODTExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Background = True
    Creator = 'FastReport'
    SingleSheet = False
    Language = 'en'
    SuppressPageHeadersFooters = False
    Left = 424
    Top = 648
  end
  object frexpXLSX: TfrxXLSXExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ChunkSize = 0
    PictureType = gpPNG
    Left = 480
    Top = 648
  end
  object odsPayment_1: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT tr.id tr_id,'
      '       tr.plat_doc_type pdt,'
      '       tr.num || CHR(10) || f.name tr_num,'
      '       tr.STATUS tr_status,'
      '       agr.subject tr_subject,'
      '--       st.num st_num,'
      '--       st.summpay st_summpay,'
      '--       st.Reporting,'
      
        '--       NVL(ST.NUMPAY, decode(tr.plat_doc_type,3025,sw.doc_ext_' +
        'no,d.doc_ext_no)) NUMPAY,'
      
        '--       NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pa' +
        'ck.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_' +
        'id), d.doc_date))) DATEPAY,'
      '--       NVL(st.NUMPAY, d.doc_ext_no) NUMPAY,'
      
        '--       TO_CHAR(NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(l.' +
        'doc_id), d.doc_date)), '#39'dd.mm.yyyy'#39') datepay,'
      
        '--       COUNT(ST.ID) OVER (PARTITION BY tr.id) count_treaty_sta' +
        'ge,'
      '--       COUNT(ST.ID) OVER (PARTITION BY 1) count_stage,'
      '/*       '
      '       DECODE(fa.currency_no,'
      '              933, 1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(st.dateact, fa.currency_no)'
      '                  AND er.CURRENCY_NO = fa.currency_no'
      '              )'
      '             ) e_rate,       '
      
        '       TO_CHAR(DECODE(fa.currency_no, 933, TRUNC(SYSDATE), RN.MO' +
        'NEY_PKG.GetLEqMaxDateOfExchange(st.dateact, fa.currency_no)),'
      '                '#39'dd.mm.yyyy'#39') intro_date,'
      '       fa.currency_no currency_no,'
      '       cr.ISO_NAME currency,'
      '*/       '
      '       SUM(DECODE(fa.currency_no,'
      '              933, 1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(st.dateact, fa.currency_no)'
      '                  AND er.CURRENCY_NO = fa.currency_no'
      '              )'
      
        '             )*DECODE(TRUNC(NVL(ST.DATEPAY, DECODE(tr.plat_doc_t' +
        'ype, 3025, m.vns_pack.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.g' +
        'etpdmaxpdate(l.doc_id), d.doc_date))), '#39'MONTH'#39'), TRUNC(:REP_DATE' +
        ', '#39'MONTH'#39'), st.summpay, 0)) over (PARTITION BY tr.id) MONTH_TREA' +
        'TY_SUMMPAY,'
      ''
      '       SUM(DECODE(fa.currency_no,'
      '              933, 1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(st.dateact, fa.currency_no)'
      '                  AND er.CURRENCY_NO = fa.currency_no'
      '              )'
      
        '             )*st.SUMMPAY) over (PARTITION BY tr.id) YEAR_TREATY' +
        '_SUMMPAY'
      '  FROM RN.mnstage st,'
      '       M.DOCUMENTS SW,'
      '       M.vns_pd_div_lines l,'
      '       M.vns_pd_div_lines l2,'
      '       M.DOCUMENTS d,'
      '       RN.MNAGREEM agr,'
      '       RN.MNTREATY tr,'
      '       firm_account fa,'
      '       firm f,'
      '       CURRENCY cr'
      ' WHERE st.DATEACT IS NOT NULL'
      '   AND SW.DOC_NO(+) = st.SPECIAL_WRITTEN'
      '   AND l.sw_id(+) = SW.DOC_NO'
      '   AND d.DOC_NO(+) = l.DOC_ID'
      '   AND l2.doc_id(+) = SW.DOC_NO'
      '--   AND l.sw_id(+) = st.SPECIAL_WRITTEN'
      
        '   AND NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pack' +
        '.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id' +
        '), d.doc_date))) BETWEEN TRUNC(:REP_DATE, '#39'YEAR'#39')'
      
        '                                                                ' +
        '    AND TRUNC(ADD_MONTHS(:REP_DATE, 12), '#39'YEAR'#39')'
      
        '   AND NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pack' +
        '.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id' +
        '), d.doc_date))) <> TRUNC(ADD_MONTHS(:REP_DATE, 12), '#39'YEAR'#39')'
      '   AND agr.ID = st.agreem_ID'
      '   AND tr.id = agr.treaty_id'
      '   AND agr.ISTFIN_KOD = 1'
      '   '
      '   AND fa.bank_accnt_id(+) = st.exec_account_id'
      '   AND f.firm_no = fa.firm_no'
      '--   AND st.summpay > 0'
      '   AND cr.CURRENCY_NO = fa.CURRENCY_NO'
      ' ORDER BY tr.id'
      
        '--          NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns' +
        '_pack.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.d' +
        'oc_id), d.doc_date))),'
      '--          st.num')
    Optimize = False
    Variables.Data = {
      0300000001000000090000003A5245505F444154450C00000007000000787305
      0101010100000000}
    QBEDefinition.QBEFieldDefs = {
      04000000070000000500000054525F4944010000000000030000005044540100
      000000000600000054525F4E554D0100000000000900000054525F5354415455
      530100000000000A00000054525F5355424A454354010000000000140000004D
      4F4E54485F5452454154595F53554D4D50415901000000000013000000594541
      525F5452454154595F53554D4D504159010000000000}
    AutoCalcFields = False
    Session = seOracle
    Left = 584
    Top = 8
    object fltfldPayment_1TR_ID: TFloatField
      FieldName = 'TR_ID'
      Required = True
    end
    object intfldPayment_1PDT: TIntegerField
      FieldName = 'PDT'
    end
    object odsPayment_1TR_NUM: TStringField
      FieldName = 'TR_NUM'
      Size = 141
    end
    object odsPayment_1TR_STATUS: TStringField
      FieldName = 'TR_STATUS'
      Required = True
      Size = 1
    end
    object odsPayment_1TR_SUBJECT: TStringField
      FieldName = 'TR_SUBJECT'
      Required = True
      Size = 1000
    end
    object fltfldPayment_1MONTH_TREATY_SUMMPAY: TFloatField
      FieldName = 'MONTH_TREATY_SUMMPAY'
    end
    object fltfldPayment_1YEAR_TREATY_SUMMPAY: TFloatField
      FieldName = 'YEAR_TREATY_SUMMPAY'
    end
  end
  object frdsPayment_1: TfrxDBDataset
    UserName = 'MainDataSet'
    CloseDataSource = True
    FieldAliases.Strings = (
      'TR_ID=TR_ID'
      'PDT=PDT'
      'TR_NUM=TR_NUM'
      'TR_STATUS=TR_STATUS'
      'TR_SUBJECT=TR_SUBJECT'
      'ST_NUM=ST_NUM'
      'ST_SUMMPAY=ST_SUMMPAY'
      'REPORTING=REPORTING'
      'NUMPAY=NUMPAY'
      'DATEPAY=DATEPAY'
      'COUNT_TREATY_STAGE=COUNT_TREATY_STAGE'
      'COUNT_STAGE=COUNT_STAGE'
      'E_RATE=E_RATE'
      'INTRO_DATE=INTRO_DATE'
      'CURRENCY_NO=CURRENCY_NO'
      'CURRENCY=CURRENCY'
      'MONTH_TREATY_SUMMPAY=MONTH_TREATY_SUMMPAY'
      'YEAR_TREATY_SUMMPAY=YEAR_TREATY_SUMMPAY')
    DataSet = odsPayment_1
    BCDToCurrency = False
    Left = 584
    Top = 56
  end
  object frPayment_1: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42444.698747303200000000
    ReportOptions.LastChange = 42444.698747303200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Subreport1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If SubReport1.Height < Memo3.Height Then'
      '  begin            '
      '    SubReport1.Height := Memo3.Height;'
      
        '    MasterData2.Height := Memo3.Height;                         ' +
        '                                                                ' +
        '                   '
      '  end;              '
      '                              '
      'end;'
      ''
      ''
      'begin'
      ''
      'end.')
    Left = 584
    Top = 104
    Datasets = <
      item
        DataSet = frdsPayment_1_2
        DataSetName = 'SubDataSet'
      end
      item
        DataSet = frdsPayment_1
        DataSetName = 'MainDataSet'
      end>
    Variables = <
      item
        Name = ' MyCat'
        Value = Null
      end
      item
        Name = 'REP_YEAR'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo8: TfrxMemoView
          Width = 1046.929810000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#1115#1056#1111#1056#187#1056#176#1057#8218#1056#176' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218' '#1056#1111#1056#1109' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176#1056#1112', '#1057#8222#1056#1105#1056#1029#1056#176#1056#1029#1057#1027#1056#1105#1057 +
              #1026#1057#1107#1056#181#1056#1112#1057#8249#1056#1112' '#1056#1105#1056#183' '#1057#1027#1057#1026#1056#181#1056#1169#1057#1027#1057#8218#1056#1030' '#1056#1115#1056#1106#1056#1115' "'#1056#8216#1056#181#1056#187#1056#176#1057#1026#1057#1107#1057#1027#1057#1034#1056#1108#1056#176#1056#187#1056#1105 +
              #1056#8470'" '#1056#183#1056#176' [REP_YEAR] '#1056#1110'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Top = 34.015770000000010000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[<Date>] [<Time>]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 94.488250000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo13: TfrxMemoView
          Width = 37.795300000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 37.795300000000000000
          Width = 170.078850000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 207.874150000000000000
          Width = 207.874150000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 415.748300000000000000
          Width = 56.692950000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 472.441250000000000000
          Width = 94.488250000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 566.929500000000000000
          Width = 79.370130000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 646.299630000000000000
          Width = 79.370130000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 725.669760000000000000
          Width = 68.031540000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 793.701300000000000000
          Width = 158.740260000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '9')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '10')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 325.039580000000000000
        Width = 1046.929810000000000000
        DataSet = frdsPayment_1
        DataSetName = 'MainDataSet'
        KeepFooter = True
        RowCount = 0
        Stretched = True
        object Memo1: TfrxMemoView
          Width = 37.795300000000000000
          Height = 22.677180000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[Line#]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo2: TfrxMemoView
          Left = 37.795300000000000000
          Width = 170.078850000000000000
          Height = 22.677180000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[MainDataSet."TR_NUM"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo3: TfrxMemoView
          Left = 207.874150000000000000
          Width = 207.874150000000000000
          Height = 22.677180000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[MainDataSet."TR_SUBJECT"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Subreport1: TfrxSubreport
          ShiftMode = smDontShift
          Left = 415.748300000000000000
          Width = 279.685220000000000000
          Height = 22.677180000000000000
          OnAfterPrint = 'Subreport1OnAfterPrint'
          Page = frPayment_1.Page2
          PrintOnParent = True
        end
        object Memo10: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 22.677180000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[MainDataSet."YEAR_TREATY_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 128.504020000000000000
        Top = 173.858380000000000000
        Width = 1046.929810000000000000
        object Memo23: TfrxMemoView
          Top = 109.606370000000000000
          Width = 37.795300000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 37.795300000000000000
          Top = 109.606370000000000000
          Width = 170.078850000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 207.874150000000000000
          Top = 109.606370000000000000
          Width = 207.874150000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 415.748300000000000000
          Top = 109.606370000000000000
          Width = 56.692950000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 472.441250000000000000
          Top = 109.606370000000000000
          Width = 94.488250000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 566.929500000000000000
          Top = 109.606370000000000000
          Width = 79.370130000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 646.299630000000000000
          Top = 109.606370000000000000
          Width = 79.370130000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 725.669760000000000000
          Top = 109.606370000000000000
          Width = 68.031540000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 793.701300000000000000
          Top = 109.606370000000000000
          Width = 158.740260000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '9')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 952.441560000000000000
          Top = 109.606370000000000000
          Width = 94.488250000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '10')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Width = 37.795300000000000000
          Height = 109.606357800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111'.'#1056#1111'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 37.795300000000000000
          Width = 170.078850000000000000
          Height = 109.606357800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176', '#1056#1105#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 207.874150000000000000
          Width = 207.874150000000000000
          Height = 109.606357800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1057#8218#1056#181#1056#1112#1057#8249' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 415.748300000000000000
          Top = 18.897650000000000000
          Width = 56.692950000000000000
          Height = 90.708707800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 415.748300000000000000
          Width = 536.693260000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#173#1057#8218#1056#176#1056#1111)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 566.929499999999900000
          Top = 18.897650000000000000
          Width = 79.370130000000000000
          Height = 90.708707800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8221#1056#176#1057#8218#1056#176' '#1056#176#1056#1108#1057#8218#1056#176' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187'- '#1056#1029#1056#181#1056#1029#1056#1029#1057#8249#1057#8230' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 646.299630000000000000
          Top = 18.897650000000000000
          Width = 79.370130000000000000
          Height = 90.708707800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8221#1056#176#1057#8218#1056#176' '#1056#1109#1056#1111#1056#187#1056#176#1057#8218#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 725.669760000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000010000
          Height = 90.708707800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111#1056#187#1056#176#1057#8218#1057#8216#1056#182'- '#1056#1029#1056#1109#1056#1110#1056#1109' '#1056#1169#1056#1109#1056#1108#1057#1107#1056#1112#1056#181#1056#1029'- '#1057#8218#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 793.701300000000000000
          Top = 18.897650000000000000
          Width = 158.740260000000000000
          Height = 90.708707800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#1113#1057#1026#1056#176#1057#8218#1056#1108#1056#1109#1056#181' '#1057#1027#1056#1109#1056#1169#1056#181#1057#1026#1056#182#1056#176#1056#1029#1056#1105#1056#181' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1029#1057#8249#1057#8230' '#1057#1026#1056#176#1056 +
              #177#1056#1109#1057#8218)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 109.606357800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109' '#1056#1109#1056#1111#1056#187#1056#176#1057#8225#1056#181#1056#1029#1056#1109' '#1056#183#1056#176' '#1056#1109#1057#8218#1057#8225#1057#8216#1057#8218#1056#1029#1057#8249#1056#8470' '#1056#1110#1056#1109#1056#1169)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 472.441250000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 90.708707800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1115#1056#1111#1056#187#1056#176#1057#8225#1056#181#1056#1029#1056#1109', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 370.393940000000000000
        Width = 1046.929810000000000000
        object Memo44: TfrxMemoView
          Left = 468.661720000000000000
          Width = 249.448980000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1109' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218' '#1056#1029#1056#176' '#1057#1027#1057#1107#1056#1112#1056#1112#1057#1107':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 718.110700000000000000
          Width = 264.567100000000000000
          Height = 34.015770000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<MainDataSet."YEAR_TREATY_SUMMPAY">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
    object Page2: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        DataSet = frdsPayment_1_2
        DataSetName = 'SubDataSet'
        RowCount = 0
        Stretched = True
        object Memo4: TfrxMemoView
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SubDataSet."ST_NUM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 56.692950000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[SubDataSet."ST_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 230.551330000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SubDataSet."DATEPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 151.181200000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'ST_DATEACT'
          DataSet = frdsPayment_1_2
          DataSetName = 'SubDataSet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SubDataSet."ST_DATEACT"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 309.921460000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SubDataSet."NUMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 377.953000000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haBlock
          Memo.UTF8 = (
            '[SubDataSet."REPORTING"]')
          ParentFont = False
        end
      end
    end
  end
  object odsPayment_1_2: TOracleDataSet
    SQL.Strings = (
      'SELECT tr.id tr_id,'
      '       tr.plat_doc_type pdt,'
      '       tr.num || CHR(10) || f.name tr_num,'
      '       tr.STATUS tr_status,'
      '       agr.subject tr_subject,'
      '       st.num st_num,'
      '       st.summpay st_summpay,'
      '       st.dateact st_dateact,'
      '       st.Reporting,'
      
        '       NVL(ST.NUMPAY, decode(tr.plat_doc_type,3025,sw.doc_ext_no' +
        ',d.doc_ext_no)) NUMPAY,'
      
        '       NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pack' +
        '.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id' +
        '), d.doc_date))) DATEPAY,'
      '--       NVL(st.NUMPAY, d.doc_ext_no) NUMPAY,'
      
        '--       TO_CHAR(NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(l.' +
        'doc_id), d.doc_date)), '#39'dd.mm.yyyy'#39') datepay,'
      
        '--       COUNT(ST.ID) OVER (PARTITION BY tr.id) count_treaty_sta' +
        'ge,'
      '--       COUNT(ST.ID) OVER (PARTITION BY 1) count_stage,'
      '       '
      '       DECODE(fa.currency_no,'
      '              933, 1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(st.dateact, fa.currency_no)'
      '                  AND er.CURRENCY_NO = fa.currency_no'
      '              )'
      '             ) e_rate,       '
      
        '       TO_CHAR(DECODE(fa.currency_no, 933, TRUNC(SYSDATE), RN.MO' +
        'NEY_PKG.GetLEqMaxDateOfExchange(st.dateact, fa.currency_no)),'
      '                '#39'dd.mm.yyyy'#39') intro_date,'
      '       fa.currency_no currency_no,'
      '       cr.ISO_NAME currency'
      '  FROM RN.mnstage st,'
      '       M.DOCUMENTS SW,'
      '       M.vns_pd_div_lines l,'
      '       M.vns_pd_div_lines l2,'
      '       M.DOCUMENTS d,'
      '       RN.MNAGREEM agr,'
      '       RN.MNTREATY tr,'
      '       firm_account fa,'
      '       firm f,'
      '       CURRENCY cr'
      ' WHERE st.DATEACT IS NOT NULL'
      '   AND SW.DOC_NO(+) = st.SPECIAL_WRITTEN'
      '   AND l.sw_id(+) = SW.DOC_NO'
      '   AND d.DOC_NO(+) = l.DOC_ID'
      '   AND l2.doc_id(+) = SW.DOC_NO'
      '--   AND l.sw_id(+) = st.SPECIAL_WRITTEN'
      
        '   AND NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pack' +
        '.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id' +
        '), d.doc_date))) BETWEEN TRUNC(:REP_DATE, '#39'YEAR'#39')'
      
        '                                                                ' +
        '    AND TRUNC(ADD_MONTHS(:REP_DATE, 12), '#39'YEAR'#39')'
      
        '   AND NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pack' +
        '.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id' +
        '), d.doc_date))) <> TRUNC(ADD_MONTHS(:REP_DATE, 12), '#39'YEAR'#39')'
      '   AND agr.ID = st.agreem_ID'
      '   AND tr.id = agr.treaty_id'
      '   AND agr.ISTFIN_KOD = 1'
      '   '
      '   AND fa.bank_accnt_id(+) = st.exec_account_id'
      '   AND f.firm_no = fa.firm_no'
      '   AND st.summpay > 0'
      '   AND cr.CURRENCY_NO = fa.CURRENCY_NO'
      '   AND TR.ID = :TR_ID'
      ' ORDER BY tr.id,'
      
        '          NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_p' +
        'ack.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc' +
        '_id), d.doc_date))),'
      '          st.num')
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A5245505F444154450C00000007000000787305
      0101010100000000060000003A54525F494403000000040000004D0500000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      040000000F0000000500000054525F4944010000000000030000005044540100
      000000000600000054525F4E554D0100000000000900000054525F5354415455
      530100000000000A00000054525F5355424A4543540100000000000600000053
      545F4E554D0100000000000A00000053545F53554D4D50415901000000000009
      0000005245504F5254494E47010000000000060000004E554D50415901000000
      0000070000004441544550415901000000000006000000455F52415445010000
      0000000A000000494E54524F5F444154450100000000000B0000004355525245
      4E43595F4E4F0100000000000800000043555252454E43590100000000000A00
      000053545F44415445414354010000000000}
    AutoCalcFields = False
    Master = odsPayment_1
    MasterFields = 'TR_ID'
    Session = seOracle
    Left = 664
    Top = 8
    object fltfldPayment_1_2TR_ID: TFloatField
      FieldName = 'TR_ID'
      Required = True
    end
    object intfldPayment_1_2PDT: TIntegerField
      FieldName = 'PDT'
    end
    object odsPayment_1_2TR_NUM: TStringField
      FieldName = 'TR_NUM'
      Size = 141
    end
    object odsPayment_1_2TR_STATUS: TStringField
      FieldName = 'TR_STATUS'
      Required = True
      Size = 1
    end
    object odsPayment_1_2TR_SUBJECT: TStringField
      FieldName = 'TR_SUBJECT'
      Required = True
      Size = 1000
    end
    object odsPayment_1_2ST_NUM: TStringField
      FieldName = 'ST_NUM'
      Size = 13
    end
    object fltfldPayment_1_2ST_SUMMPAY: TFloatField
      FieldName = 'ST_SUMMPAY'
    end
    object odsPayment_1_2REPORTING: TStringField
      FieldName = 'REPORTING'
      Size = 1000
    end
    object odsPayment_1_2NUMPAY: TStringField
      FieldName = 'NUMPAY'
      Size = 100
    end
    object dtfldPayment_1_2DATEPAY: TDateTimeField
      FieldName = 'DATEPAY'
    end
    object fltfldPayment_1_2E_RATE: TFloatField
      FieldName = 'E_RATE'
    end
    object odsPayment_1_2INTRO_DATE: TStringField
      FieldName = 'INTRO_DATE'
      Size = 10
    end
    object intfldPayment_1_2CURRENCY_NO: TIntegerField
      FieldName = 'CURRENCY_NO'
    end
    object odsPayment_1_2CURRENCY: TStringField
      FieldName = 'CURRENCY'
      Required = True
      Size = 3
    end
    object dtfldPayment_1_2ST_DATEACT: TDateTimeField
      FieldName = 'ST_DATEACT'
    end
  end
  object frdsPayment_1_2: TfrxDBDataset
    UserName = 'SubDataSet'
    CloseDataSource = True
    FieldAliases.Strings = (
      'TR_ID=TR_ID'
      'PDT=PDT'
      'TR_NUM=TR_NUM'
      'TR_STATUS=TR_STATUS'
      'TR_SUBJECT=TR_SUBJECT'
      'ST_NUM=ST_NUM'
      'ST_SUMMPAY=ST_SUMMPAY'
      'REPORTING=REPORTING'
      'NUMPAY=NUMPAY'
      'DATEPAY=DATEPAY'
      'E_RATE=E_RATE'
      'INTRO_DATE=INTRO_DATE'
      'CURRENCY_NO=CURRENCY_NO'
      'CURRENCY=CURRENCY'
      'ST_DATEACT=ST_DATEACT')
    DataSet = odsPayment_1_2
    BCDToCurrency = False
    Left = 664
    Top = 56
  end
  object odsRN04: TOracleDataSet
    SQL.Strings = (
      
        'SELECT ID, NAME, EXEC_NAME, SUBJECT, DATEFROM, DATETO, NUM, STAT' +
        'US, STATUSSTR,'
      
        '       SUM(SUMMPAY) SUMMPAY, SUM(STAGE_SUMMPAY) STAGE_SUMMPAY, C' +
        'URRENCY_NAME RATE_STR'
      'FROM('
      
        'SELECT ID, NAME, EXEC_NAME, SUBJECT, DATEFROM, DATETO, NUM, STAT' +
        'US,'
      
        '       DECODE(STATUS, '#39'F'#39','#39'CAE?UO'#39','#39'A'#39','#39'AIIOEE?IAAI'#39','#39#39') STATUSS' +
        'TR,'
      '       DECODE(e_rate, 1, summpay, summpay * e_rate) summpay,'
      '       SUM(stage_summpay * e_rate) stage_summpay,'
      '       CURRENCY_NAME'
      
        '--       DECODE(e_rate, 1, '#39#39', '#39'Eo?n '#39' || TO_CHAR(e_rate) || '#39' '#39 +
        ' || currency_name || '#39' ia '#39' || to_char(into_date)) RATE_STR,'
      'FROM('
      'SELECT tr.id id,'
      '       tr.num  name,'
      '       tr.subject subject,'
      '       TO_CHAR(tr.datefrom,'#39'MM.YYYY'#39') datefrom,'
      '       TO_CHAR(agr_num.dateto,'#39'MM.YYYY'#39') dateto,'
      '       agr_num.summpay summpay,'
      '       fa.currency_no currency_no,'
      '       tr.status status,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       DECODE(fa.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(fa.currency_no, st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id, tr.datefrom)'
      '                  AND er.CURRENCY_NO = fa.currency_no'
      '              )'
      '             ) e_rate,'
      '       RN.MONEY_PKG.getdateofexchangeofstage(fa.currency_no,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          tr.datefrom'
      '                                         ) into_date,'
      
        '       COUNT(tr.id) OVER (PARTITION BY tr.id) count_per_treaty, ' +
        '                                 '
      '       st.dateact stage_dateact,'
      '       st.datefrom stage_datefrom,'
      '       st.dateto stage_dateto,'
      '       currency.iso_name currency_name,'
      '       decode(agr.istfin_kod, 2, tr.theme_plan_num, tr.id) num,'
      '       firm.name exec_name'
      '  FROM RN.mnagreem agr,'
      '       RN.mntreaty tr,'
      '       RN.mnstage st,'
      '       S.currency,'
      '       RN.MNAGREEM agr_num,'
      '       firm_account fa,'
      '       firm'
      ' WHERE agr.istfin_kod = 1 -- Nianoaaiiua n?aanoaa'
      '   AND tr.status NOT IN ('#39'A'#39', '#39'P'#39')'
      '   AND (   (tr.status = '#39'O'#39')'
      
        '        OR (tr.status <> '#39'O'#39' AND  TRUNC(agr_num.dateto, '#39'YEAR'#39') ' +
        '>= TRUNC(:V_DATE, '#39'YEAR'#39')))'
      '   AND TRUNC(tr.datefrom, '#39'YEAR'#39') <= TRUNC(:V_DATE, '#39'YEAR'#39')'
      '   AND TRUNC(:V_DATE, '#39'MONTH'#39') >= TRUNC(tr.datesign, '#39'MONTH'#39')'
      ''
      '   AND (   ( TRUNC(:V_DATE, '#39'YEAR'#39') <= TRUNC(st.dateto, '#39'YEAR'#39')'
      '             AND st.dateact IS NULL'
      '           )'
      '        OR (TRUNC(:V_DATE, '#39'YEAR'#39') = TRUNC(st.dateact, '#39'YEAR'#39'))'
      '       )   '
      ''
      '   AND agr.treaty_id = tr.id'
      '   AND currency.currency_no = fa.currency_no'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   (st.dateact IS NOT NULL AND agr.num < agr_num.num) --' +
        ' aey cae?uouo yoaiia a i?aauaoueo aii.niae.'
      '        OR agr.num = agr_num.num)'
      '   AND agr_num.treaty_id = tr.id'
      '   AND agr_num.num = DECODE(:CURR_AGR, 0, (SELECT MAX(agr1.num)'
      '                                             FROM mnagreem agr1'
      
        '                                            WHERE agr1.treaty_id' +
        ' = agr_num.treaty_id),'
      '                                       1, (SELECT MAX(agr1.num)'
      '                                             FROM mnagreem agr1'
      
        '                                            WHERE agr1.treaty_id' +
        ' = agr_num.treaty_id'
      
        '                                              AND TRUNC(:V_DATE,' +
        ' '#39'MONTH'#39') >= TRUNC(agr1.DATESIGN, '#39'MONTH'#39') ))'
      '   AND fa.bank_accnt_id(+) = tr.exec_account_id'
      '   AND firm.firm_no(+) = fa.firm_no'
      ')'
      
        ' WHERE (  ( ( TRUNC(:V_DATE, '#39'YEAR'#39') <= TRUNC(stage_dateto, '#39'YEA' +
        'R'#39')'
      '             AND stage_dateact IS NULL AND count_per_treaty = 1'
      '           ) OR'
      
        '            ( LAST_DAY(:V_DATE) + 1 > TRUNC(stage_dateto, '#39'YEAR'#39 +
        ')'
      '             AND stage_dateact IS NULL'
      '           )  '
      '          )   '
      
        '        OR (TRUNC(:V_DATE, '#39'YEAR'#39') = TRUNC(stage_dateact, '#39'YEAR'#39 +
        '))'
      '       )'
      
        ' GROUP BY ID, NAME, EXEC_NAME, SUBJECT, DATEFROM, DATETO, NUM, S' +
        'TATUS,'
      '       DECODE(STATUS, '#39'F'#39','#39'CAE?UO'#39','#39'A'#39','#39'AIIOEE?IAAI'#39','#39#39'),'
      '       DECODE(e_rate, 1, summpay, summpay * e_rate),'
      '       currency_name'
      
        '--       DECODE(e_rate, 1, '#39#39', '#39'Eo?n '#39' || TO_CHAR(e_rate) || '#39' '#39 +
        ' || currency_name || '#39' ia '#39' || to_char(into_date))'
      ')'
      
        'GROUP BY ID, NAME, EXEC_NAME, SUBJECT, DATEFROM, DATETO, NUM, ST' +
        'ATUS, STATUSSTR,'
      '        CURRENCY_NAME'
      ' ORDER BY id'
      ' ')
    Optimize = False
    Variables.Data = {
      0300000002000000070000003A565F444154450C000000070000007874010101
      010100000000090000003A435552525F41475203000000040000000100000000
      000000}
    QBEDefinition.QBEFieldDefs = {
      040000000C000000020000004944010000000000040000004E414D4501000000
      0000070000005355424A454354010000000000080000004441544546524F4D01
      00000000000600000044415445544F0100000000000600000053544154555301
      000000000009000000455845435F4E414D450100000000000800000052415445
      5F535452010000000000030000004E554D010000000000090000005354415455
      535354520100000000000700000053554D4D5041590100000000000D00000053
      544147455F53554D4D504159010000000000}
    Session = seOracle
    Left = 512
    Top = 160
    object fltfldRN04ID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object odsRN04NAME: TStringField
      FieldName = 'NAME'
      Required = True
    end
    object odsRN04EXEC_NAME: TStringField
      FieldName = 'EXEC_NAME'
      Size = 120
    end
    object odsRN04SUBJECT: TStringField
      FieldName = 'SUBJECT'
      Required = True
      Size = 1000
    end
    object odsRN04DATEFROM: TStringField
      FieldName = 'DATEFROM'
      Size = 7
    end
    object odsRN04DATETO: TStringField
      FieldName = 'DATETO'
      Size = 7
    end
    object fltfldRN04NUM: TFloatField
      FieldName = 'NUM'
    end
    object odsRN04STATUS: TStringField
      FieldName = 'STATUS'
      Required = True
      Size = 1
    end
    object odsRN04STATUSSTR: TStringField
      FieldName = 'STATUSSTR'
      Size = 11
    end
    object fltfldRN04SUMMPAY: TFloatField
      FieldName = 'SUMMPAY'
    end
    object fltfldRN04STAGE_SUMMPAY: TFloatField
      FieldName = 'STAGE_SUMMPAY'
    end
    object odsRN04RATE_STR: TStringField
      FieldName = 'RATE_STR'
      Size = 61
    end
  end
  object frdsRN04: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = True
    FieldAliases.Strings = (
      'ID=ID'
      'NAME=NAME'
      'EXEC_NAME=EXEC_NAME'
      'SUBJECT=SUBJECT'
      'DATEFROM=DATEFROM'
      'DATETO=DATETO'
      'NUM=NUM'
      'STATUS=STATUS'
      'STATUSSTR=STATUSSTR'
      'SUMMPAY=SUMMPAY'
      'STAGE_SUMMPAY=STAGE_SUMMPAY'
      'RATE_STR=RATE_STR')
    DataSet = odsRN04
    BCDToCurrency = False
    Left = 512
    Top = 208
  end
  object frRN04: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Author = #1048#1074#1095#1080#1085' '#1040'. '#1057'.'
    ReportOptions.CreateDate = 42446.691907442100000000
    ReportOptions.Name = 'RN-04 '#1055#1077#1088#1077#1095#1077#1085#1100' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
    ReportOptions.LastChange = 42460.655878541660000000
    ReportOptions.VersionBuild = '45'
    ReportOptions.VersionMajor = '1'
    ReportOptions.VersionMinor = '0'
    ReportOptions.VersionRelease = '1'
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 512
    Top = 256
    Datasets = <
      item
        DataSet = frdsRN04
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' MyCat'
        Value = Null
      end
      item
        Name = 'REP_YEAR'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#164#1056#1115#1056#160#1056#1114#1056#1106' RN-04')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 944.882500000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1119#1056#160#1056#152#1056#8250#1056#1115#1056#8211#1056#8226#1056#1116#1056#152#1056#8226' 1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Top = 30.236240000000000000
          Width = 1046.929810000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1119#1056#181#1057#1026#1056#181#1057#8225#1056#181#1056#1029#1057#1034' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Top = 64.252010000000000000
          Width = 188.976500000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 120.944960000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo5: TfrxMemoView
          Width = 45.354360000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 45.354360000000000000
          Width = 219.212740000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 264.567100000000000000
          Width = 423.307360000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 687.874460000000000000
          Width = 94.488250000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 782.362710000000000000
          Width = 132.283550000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 914.646260000000000000
          Width = 132.283550000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 476.220780000000000000
        Width = 1046.929810000000000000
        object Memo6: TfrxMemoView
          Left = 997.795920000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[Page#]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 332.598640000000000000
        Width = 1046.929810000000000000
        DataSet = frdsRN04
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo13: TfrxMemoView
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Highlight.ApplyFill = False
          Highlight.Font.Charset = RUSSIAN_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -16
          Highlight.Font.Name = 'Times New Roman'
          Highlight.Font.Style = [fsBold]
          Highlight.Condition = '<frxDBDataset1."STATUS"> = '#39'F'#39
          Highlight.FillType = ftBrush
          Memo.UTF8 = (
            '[frxDBDataset1."NUM"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          Left = 45.354360000000000000
          Width = 219.212740000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Highlight.ApplyFill = False
          Highlight.Font.Charset = RUSSIAN_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -16
          Highlight.Font.Name = 'Times New Roman'
          Highlight.Font.Style = [fsBold]
          Highlight.Condition = '<frxDBDataset1."STATUS"> = '#39'F'#39
          Highlight.FillType = ftBrush
          Memo.UTF8 = (
            '[frxDBDataset1."STATUSSTR"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 264.567100000000000000
          Width = 423.307360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Highlight.ApplyFill = False
          Highlight.Font.Charset = RUSSIAN_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -16
          Highlight.Font.Name = 'Times New Roman'
          Highlight.Font.Style = [fsBold]
          Highlight.Condition = '<frxDBDataset1."STATUS"> = '#39'F'#39
          Highlight.FillType = ftBrush
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo16: TfrxMemoView
          Left = 687.874460000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Highlight.ApplyFill = False
          Highlight.Font.Charset = RUSSIAN_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -16
          Highlight.Font.Name = 'Times New Roman'
          Highlight.Font.Style = [fsBold]
          Highlight.Condition = '<frxDBDataset1."STATUS"> = '#39'F'#39
          Highlight.FillType = ftBrush
          Memo.UTF8 = (
            '[frxDBDataset1."DATETO"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 782.362710000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 914.646260000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 291.023810000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBDataset1."ID"'
        Stretched = True
        object Memo7: TfrxMemoView
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Highlight.ApplyFill = False
          Highlight.Font.Charset = RUSSIAN_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -16
          Highlight.Font.Name = 'Times New Roman'
          Highlight.Font.Style = [fsBold]
          Highlight.Condition = '<frxDBDataset1."STATUS"> = '#39'F'#39
          Highlight.FillType = ftBrush
          Memo.UTF8 = (
            '[Line#]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 45.354360000000000000
          Width = 219.212740000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Highlight.ApplyFill = False
          Highlight.Font.Charset = RUSSIAN_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -16
          Highlight.Font.Name = 'Times New Roman'
          Highlight.Font.Style = [fsBold]
          Highlight.Condition = '<frxDBDataset1."STATUS"> = '#39'F'#39
          Highlight.FillType = ftBrush
          Memo.UTF8 = (
            '[frxDBDataset1."NAME"]'
            '[frxDBDataset1."EXEC_NAME"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo9: TfrxMemoView
          Left = 264.567100000000000000
          Width = 423.307360000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haBlock
          Highlight.ApplyFill = False
          Highlight.Font.Charset = RUSSIAN_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -16
          Highlight.Font.Name = 'Times New Roman'
          Highlight.Font.Style = [fsBold]
          Highlight.Condition = '<frxDBDataset1."STATUS"> = '#39'F'#39
          Highlight.FillType = ftBrush
          Memo.UTF8 = (
            '[frxDBDataset1."SUBJECT"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 687.874460000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Highlight.ApplyFill = False
          Highlight.Font.Charset = RUSSIAN_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -16
          Highlight.Font.Name = 'Times New Roman'
          Highlight.Font.Style = [fsBold]
          Highlight.Condition = '<frxDBDataset1."STATUS"> = '#39'F'#39
          Highlight.FillType = ftBrush
          Memo.UTF8 = (
            '[frxDBDataset1."DATEFROM"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo11: TfrxMemoView
          Left = 782.362710000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Highlight.ApplyFill = False
          Highlight.Font.Charset = RUSSIAN_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -16
          Highlight.Font.Name = 'Times New Roman'
          Highlight.Font.Style = [fsBold]
          Highlight.Condition = '<frxDBDataset1."STATUS"> = '#39'F'#39
          Highlight.FillType = ftBrush
          Memo.UTF8 = (
            '[frxDBDataset1."SUMMPAY"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 914.646260000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Highlight.ApplyFill = False
          Highlight.Font.Charset = RUSSIAN_CHARSET
          Highlight.Font.Color = clBlack
          Highlight.Font.Height = -16
          Highlight.Font.Name = 'Times New Roman'
          Highlight.Font.Style = [fsBold]
          Highlight.Condition = '<frxDBDataset1."STATUS"> = '#39'F'#39
          Highlight.FillType = ftBrush
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_SUMMPAY"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        object Memo24: TfrxMemoView
          Top = 56.692949999999990000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 45.354360000000000000
          Top = 56.692949999999990000
          Width = 219.212740000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 264.567100000000000000
          Top = 56.692949999999990000
          Width = 423.307360000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 687.874460000000000000
          Top = 56.692949999999990000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 782.362710000000000000
          Top = 56.692949999999990000
          Width = 132.283550000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 914.646260000000000000
          Top = 56.692949999999990000
          Width = 132.283550000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Width = 45.354360000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111'.'#1056#1111'., '#1057#8364#1056#1105#1057#8222#1057#1026)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 45.354360000000000000
          Width = 219.212740000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176', '#1056#1105#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 264.567100000000000000
          Width = 423.307360000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 687.874460000000000000
          Width = 359.055350000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 687.874460000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1026#1056#1109#1056#1108#1056#1105' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 782.362710000000000000
          Top = 18.897650000000000000
          Width = 132.283550000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109' '#1056#1111#1056#1109' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1057#1107)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 914.646260000000000000
          Top = 18.897650000000000000
          Width = 132.283550000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217' '#1057#8218#1056#1109#1056#1112' '#1057#8225#1056#1105#1057#1027#1056#187#1056#181' '#1056#183#1056#176' [REP_YEAR] '#1056#1110'.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 374.173470000000000000
        Width = 1046.929810000000000000
        object Memo37: TfrxMemoView
          Left = 782.362710000000000000
          Top = 22.677180000000020000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109':')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo38: TfrxMemoView
          Left = 914.646260000000000000
          Top = 22.677180000000020000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."STAGE_SUMMPAY">,MasterData1)]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
    end
  end
  object odsPayment_2: TOracleDataSet
    SQL.Strings = (
      'SELECT vitreaty.treaty_id,'
      '       vitreaty.treaty_num,'
      '        vi_all.dd,'
      
        '      decode(vi_all.dd, 1, '#39#1071#1085#1074#1072#1088#1100#39', 2, '#39#1060#1077#1074#1088#1072#1083#1100#39', 3, '#39#1052#1072#1088#1090#39', 4,' +
        ' '#39#1040#1087#1088#1077#1083#1100#39','
      
        '              5, '#39#1052#1072#1081#39', 6, '#39#1048#1102#1085#1100#39', 7, '#39#1048#1102#1083#1100#39', 8, '#39#1040#1074#1075#1091#1089#1090#39', 9, '#39#1057 +
        #1077#1085#1090#1103#1073#1088#1100#39','
      '              10, '#39#1054#1082#1090#1103#1073#1088#1100#39', 11, '#39#1053#1086#1103#1073#1088#1100#39', '#39#1044#1077#1082#1072#1073#1088#1100#39') MON_TH,'
      '       vi_all.stage_summpay_RB,'
      
        '       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_treaty'
      
        '  FROM (SELECT treaty_id, months, SUM(stage_summpay_rb) stage_su' +
        'mmpay_RB, dd'
      '         FROM'
      '        ('
      
        '         SELECT DISTINCT qry.treaty_id, MAX(qry.months) months, ' +
        'stage_summpay_RB, MAX(qry.dd) dd, qry.stage_id FROM '
      '        ((SELECT DISTINCT mntreaty.id treaty_id,'
      
        '               TRUNC(NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdat' +
        'e(l.doc_id), d.doc_date)),'#39'MM'#39') months,'
      
        '               (exchange_rates.e_rate*st.summpay) stage_summpay_' +
        'RB,'
      
        '               TO_NUMBER(TO_CHAR(NVL(ST.DATEPAY, NVL(m.vns_pack.' +
        'getpdmaxpdate(l.doc_id), d.doc_date)),'#39'MM'#39')) dd,'
      '               st.id stage_id'
      '          FROM RN.mntreaty,'
      '               RN.mnstage st,'
      '               RN.mnagreem agr,'
      '               M.vns_pd_div_lines l,'
      '               M.DOCUMENTS d,'
      '               S.firm_account,'
      '               S.firm,'
      '               S.exchange_rates'
      '          WHERE st.DATEACT IS NOT NULL'
      '            AND l.sw_id(+) = st.SPECIAL_WRITTEN'
      '            AND d.DOC_NO(+) = l.DOC_ID'
      
        '            AND NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(l.d' +
        'oc_id), d.doc_date)) BETWEEN :v_datefrom'
      '                               AND LAST_DAY(:v_dateto)'
      '           AND agr.id = st.agreem_id'
      '           AND agr.istfin_kod = 1'
      '           AND firm_account.bank_accnt_id = st.exec_account_id'
      '           AND firm.firm_no = firm_account.firm_no'
      
        '           AND exchange_rates.currency_no = firm_account.currenc' +
        'y_no'
      
        '           AND exchange_rates.intro_date = (SELECT MAX(er.intro_' +
        'date)'
      
        '                                              FROM S.exchange_ra' +
        'tes er'
      
        '                                             WHERE er.intro_date' +
        ' <= st.dateact'
      
        '                                               AND er.currency_n' +
        'o = firm_account.currency_no)'
      '           AND mntreaty.id = agr.treaty_id)'
      '          UNION ALL'
      '          (SELECT DISTINCT mntreaty.id treaty_id,'
      
        '               TRUNC(NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdat' +
        'e(l.doc_id), d.doc_date)),'#39'MM'#39') months,'
      
        '               (exchange_rates.e_rate*st.summpay) stage_summpay_' +
        'RB,'
      
        '               TO_NUMBER(TO_CHAR(NVL(ST.DATEPAY, NVL(m.vns_pack.' +
        'getpdmaxpdate(l.doc_id), d.doc_date)),'#39'MM'#39')) dd,'
      '         st.id stage_id'
      '          FROM RN.mntreaty,'
      '               RN.mnstage st,'
      '               RN.mnagreem agr,'
      '               M.vns_pd_div_lines l,'
      '               M.DOCUMENTS d,'
      '               S.firm_account,'
      '               S.firm,'
      '               S.exchange_rates'
      '          WHERE st.DATEACT IS NOT NULL'
      '            AND l.doc_id(+) = st.SPECIAL_WRITTEN'
      '            AND d.DOC_NO(+) = l.DOC_ID'
      
        '            AND NVL(ST.DATEPAY, NVL(m.vns_pack.getpdmaxpdate(l.d' +
        'oc_id), d.doc_date)) BETWEEN :v_datefrom'
      '                               AND LAST_DAY(:v_dateto)'
      '           AND agr.id = st.agreem_id'
      '           AND agr.istfin_kod = 1 --'#1080#1079' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1099#1093' '#1089#1088#1077#1076#1089#1090#1074
      '           AND firm_account.bank_accnt_id = st.exec_account_id'
      '           AND firm.firm_no = firm_account.firm_no'
      
        '           AND exchange_rates.currency_no = firm_account.currenc' +
        'y_no'
      
        '           AND exchange_rates.intro_date = (SELECT MAX(er.intro_' +
        'date)'
      
        '                                              FROM S.exchange_ra' +
        'tes er'
      
        '                                             WHERE er.intro_date' +
        ' <= st.dateact'
      
        '                                               AND er.currency_n' +
        'o = firm_account.currency_no)'
      '           AND mntreaty.id = agr.treaty_id)) qry '
      '         GROUP BY qry.treaty_id, stage_summpay_RB, qry.stage_id'
      '                 '
      '        )'
      '         GROUP BY treaty_id, months, dd'
      '       ) vi_all,'
      '       RN.vitreaty'
      ' WHERE vitreaty.treaty_id = vi_all.treaty_id'
      ''
      '   AND vitreaty.treaty_status NOT IN ('#39'A'#39', '#39'P'#39')'
      '--   AND (:V_DATEFROM IS NULL or :V_DATEFROM IS NOT NULL)'
      '--   AND (:V_DATETO IS NULL or :V_DATETO IS NOT NULL)'
      ''
      ' ORDER BY vitreaty.treaty_num,'
      '          vitreaty.treaty_id,'
      '          vi_all.dd')
    Optimize = False
    Variables.Data = {
      03000000020000000B0000003A565F4441544546524F4D0C0000000700000078
      73010101010100000000090000003A565F44415445544F0C0000000700000078
      730C0101010100000000}
    QBEDefinition.QBEFieldDefs = {
      0400000006000000090000005452454154595F49440100000000000A00000054
      52454154595F4E554D0100000000001000000053544147455F53554D4D504159
      5F52420100000000000C000000434F554E545F54524541545901000000000006
      0000004D4F4E5F5448010000000000020000004444010000000000}
    Session = seOracle
    Left = 576
    Top = 160
    object fltfldPayment_2TREATY_ID: TFloatField
      FieldName = 'TREATY_ID'
      Required = True
    end
    object odsPayment_2TREATY_NUM: TStringField
      FieldName = 'TREATY_NUM'
      Required = True
    end
    object fltfldPayment_2DD: TFloatField
      FieldName = 'DD'
    end
    object odsPayment_2MON_TH: TStringField
      FieldName = 'MON_TH'
      Size = 8
    end
    object fltfldPayment_2STAGE_SUMMPAY_RB: TFloatField
      FieldName = 'STAGE_SUMMPAY_RB'
    end
    object fltfldPayment_2COUNT_TREATY: TFloatField
      FieldName = 'COUNT_TREATY'
    end
  end
  object frdbPayment_2: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = True
    FieldAliases.Strings = (
      'TREATY_ID=TREATY_ID'
      'TREATY_NUM=TREATY_NUM'
      'DD=DD'
      'MON_TH=MON_TH'
      'STAGE_SUMMPAY_RB=STAGE_SUMMPAY_RB'
      'COUNT_TREATY=COUNT_TREATY')
    DataSet = odsPayment_2
    BCDToCurrency = False
    Left = 576
    Top = 208
  end
  object frPayment_2: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42449.956624652800000000
    ReportOptions.LastChange = 42449.956624652800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 576
    Top = 256
    Datasets = <
      item
        DataSet = frdbPayment_2
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      EndlessWidth = True
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        object Memo1: TfrxMemoView
          Width = 249.448980000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object DBCross1: TfrxDBCrossView
        Top = 41.574830000000000000
        Width = 235.000000000000000000
        Height = 117.000000000000000000
        ColumnLevels = 2
        DownThenAcross = False
        ShowCorner = False
        ShowTitle = False
        CellFields.Strings = (
          'STAGE_SUMMPAY_RB')
        ColumnFields.Strings = (
          'DD'
          'MON_TH')
        DataSet = frdbPayment_2
        DataSetName = 'frxDBDataset1'
        RowFields.Strings = (
          'TREATY_NUM')
        Memos = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574
          662D38223F3E3C63726F73733E3C63656C6C6D656D6F733E3C546672784D656D
          6F56696577204C6566743D223131352220546F703D223130302C353734383322
          2057696474683D22363122204865696768743D22313922205265737472696374
          696F6E733D2232342220416C6C6F7745787072657373696F6E733D2246616C73
          652220446973706C6179466F726D61742E466F726D61745374723D2225322E30
          6E2220446973706C6179466F726D61742E4B696E643D22666B4E756D65726963
          2220466F6E742E436861727365743D22312220466F6E742E436F6C6F723D2230
          2220466F6E742E4865696768743D222D31312220466F6E742E4E616D653D2254
          696D6573204E657720526F6D616E2220466F6E742E5374796C653D2230222046
          72616D652E5479703D2231352220476170583D22332220476170593D22332220
          48416C69676E3D22686152696768742220506172656E74466F6E743D2246616C
          7365222056416C69676E3D22766143656E7465722220546578743D222030222F
          3E3C546672784D656D6F56696577204C6566743D223131352220546F703D2231
          31392C3537343833222057696474683D22363122204865696768743D22313922
          205265737472696374696F6E733D2232342220416C6C6F774578707265737369
          6F6E733D2246616C73652220446973706C6179466F726D61742E466F726D6174
          5374723D2225322E306E2220446973706C6179466F726D61742E4B696E643D22
          666B4E756D657269632220466F6E742E436861727365743D22312220466F6E74
          2E436F6C6F723D22302220466F6E742E4865696768743D222D31312220466F6E
          742E4E616D653D2254696D6573204E657720526F6D616E2220466F6E742E5374
          796C653D223022204672616D652E5479703D2231352220476170583D22332220
          476170593D2233222048416C69676E3D22686152696768742220506172656E74
          466F6E743D2246616C7365222056416C69676E3D22766143656E746572222054
          6578743D222030222F3E3C546672784D656D6F56696577204C6566743D223136
          302220546F703D223230222057696474683D22333922204865696768743D2232
          3222205265737472696374696F6E733D2232342220416C6C6F77457870726573
          73696F6E733D2246616C736522204672616D652E5479703D2231352220476170
          583D22332220476170593D2233222048416C69676E3D22686152696768742220
          56416C69676E3D22766143656E7465722220546578743D222030222F3E3C5466
          72784D656D6F56696577204C6566743D223136302220546F703D223432222057
          696474683D22333922204865696768743D22323222205265737472696374696F
          6E733D2232342220416C6C6F7745787072657373696F6E733D2246616C736522
          204672616D652E5479703D2231352220476170583D22332220476170593D2233
          222048416C69676E3D2268615269676874222056416C69676E3D22766143656E
          7465722220546578743D222030222F3E3C546672784D656D6F56696577204C65
          66743D223137362220546F703D223130302C3537343833222057696474683D22
          333922204865696768743D22313922205265737472696374696F6E733D223234
          2220416C6C6F7745787072657373696F6E733D2246616C73652220446973706C
          6179466F726D61742E466F726D61745374723D2225322E306E2220446973706C
          6179466F726D61742E4B696E643D22666B4E756D657269632220466F6E742E43
          6861727365743D22312220466F6E742E436F6C6F723D22302220466F6E742E48
          65696768743D222D31312220466F6E742E4E616D653D2254696D6573204E6577
          20526F6D616E2220466F6E742E5374796C653D223022204672616D652E547970
          3D2231352220476170583D22332220476170593D2233222048416C69676E3D22
          686152696768742220506172656E74466F6E743D2246616C7365222056416C69
          676E3D22766143656E7465722220546578743D222030222F3E3C546672784D65
          6D6F56696577204C6566743D223137362220546F703D223131392C3537343833
          222057696474683D22333922204865696768743D223139222052657374726963
          74696F6E733D2232342220416C6C6F7745787072657373696F6E733D2246616C
          73652220446973706C6179466F726D61742E466F726D61745374723D2225322E
          306E2220446973706C6179466F726D61742E4B696E643D22666B4E756D657269
          632220466F6E742E436861727365743D22312220466F6E742E436F6C6F723D22
          302220466F6E742E4865696768743D222D31312220466F6E742E4E616D653D22
          54696D6573204E657720526F6D616E2220466F6E742E5374796C653D22302220
          4672616D652E5479703D2231352220476170583D22332220476170593D223322
          2048416C69676E3D22686152696768742220506172656E74466F6E743D224661
          6C7365222056416C69676E3D22766143656E7465722220546578743D22203022
          2F3E3C2F63656C6C6D656D6F733E3C63656C6C6865616465726D656D6F733E3C
          546672784D656D6F56696577204C6566743D22302220546F703D223022205769
          6474683D223022204865696768743D223022205265737472696374696F6E733D
          22382220416C6C6F7745787072657373696F6E733D2246616C73652220467261
          6D652E5479703D2231352220476170583D22332220476170593D223322205641
          6C69676E3D22766143656E7465722220546578743D2253544147455F53554D4D
          5041595F5242222F3E3C546672784D656D6F56696577204C6566743D22302220
          546F703D2230222057696474683D223022204865696768743D22302220526573
          7472696374696F6E733D22382220416C6C6F7745787072657373696F6E733D22
          46616C736522204672616D652E5479703D2231352220476170583D2233222047
          6170593D2233222056416C69676E3D22766143656E7465722220546578743D22
          53544147455F53554D4D5041595F5242222F3E3C546672784D656D6F56696577
          204C6566743D22302220546F703D2230222057696474683D2230222048656967
          68743D223022205265737472696374696F6E733D22382220416C6C6F77457870
          72657373696F6E733D2246616C736522204672616D652E5479703D2231352220
          476170583D22332220476170593D2233222056416C69676E3D22766143656E74
          65722220546578743D22222F3E3C2F63656C6C6865616465726D656D6F733E3C
          636F6C756D6E6D656D6F733E3C546672784D656D6F56696577204C6566743D22
          3131352220546F703D2236312C3537343833222057696474683D223631222048
          65696768743D22323022205265737472696374696F6E733D2232342220416C6C
          6F7745787072657373696F6E733D2246616C73652220466F6E742E4368617273
          65743D22312220466F6E742E436F6C6F723D22302220466F6E742E4865696768
          743D222D31322220466F6E742E4E616D653D2254696D6573204E657720526F6D
          616E2220466F6E742E5374796C653D223022204672616D652E5479703D223135
          2220476170583D22332220476170593D2233222048416C69676E3D2268614365
          6E7465722220506172656E74466F6E743D2246616C7365222056416C69676E3D
          22766143656E7465722220546578743D22222F3E3C546672784D656D6F566965
          77204C6566743D223131352220546F703D2238312C3537343833222057696474
          683D22363122204865696768743D22313922205265737472696374696F6E733D
          2232342220416C6C6F7745787072657373696F6E733D2246616C73652220466F
          6E742E436861727365743D22312220466F6E742E436F6C6F723D22302220466F
          6E742E4865696768743D222D31312220466F6E742E4E616D653D2254696D6573
          204E657720526F6D616E2220466F6E742E5374796C653D223122204672616D65
          2E5479703D2231352220476170583D22332220476170593D2233222048416C69
          676E3D22686143656E7465722220506172656E74466F6E743D2246616C736522
          2056416C69676E3D22766143656E7465722220546578743D22222F3E3C2F636F
          6C756D6E6D656D6F733E3C636F6C756D6E746F74616C6D656D6F733E3C546672
          784D656D6F56696577204C6566743D223137362220546F703D2236312C353734
          3833222057696474683D22333922204865696768743D22333922205265737472
          696374696F6E733D22382220416C6C6F7745787072657373696F6E733D224661
          6C73652220466F6E742E436861727365743D22312220466F6E742E436F6C6F72
          3D22302220466F6E742E4865696768743D222D31312220466F6E742E4E616D65
          3D2254696D6573204E657720526F6D616E2220466F6E742E5374796C653D2231
          22204672616D652E5479703D2231352220476170583D22332220476170593D22
          33222048416C69676E3D22686143656E7465722220506172656E74466F6E743D
          2246616C7365222056416C69676E3D22766143656E7465722220546578743D22
          D098D182D0BED0B3D0BE3A222F3E3C546672784D656D6F56696577204C656674
          3D223133372220546F703D223434222057696474683D22333822204865696768
          743D22323222205265737472696374696F6E733D2238222056697369626C653D
          2246616C73652220416C6C6F7745787072657373696F6E733D2246616C736522
          20466F6E742E436861727365743D22312220466F6E742E436F6C6F723D223022
          20466F6E742E4865696768743D222D31332220466F6E742E4E616D653D224172
          69616C2220466F6E742E5374796C653D223122204672616D652E5479703D2231
          352220476170583D22332220476170593D2233222048416C69676E3D22686143
          656E7465722220506172656E74466F6E743D2246616C7365222056416C69676E
          3D22766143656E7465722220546578743D22546F74616C222F3E3C2F636F6C75
          6D6E746F74616C6D656D6F733E3C636F726E65726D656D6F733E3C546672784D
          656D6F56696577204C6566743D22302220546F703D2230222057696474683D22
          31353122204865696768743D22323222205265737472696374696F6E733D2238
          222056697369626C653D2246616C73652220416C6C6F7745787072657373696F
          6E733D2246616C736522204672616D652E5479703D2231352220476170583D22
          332220476170593D2233222048416C69676E3D22686143656E74657222205641
          6C69676E3D22766143656E7465722220546578743D2253544147455F53554D4D
          5041595F5242222F3E3C546672784D656D6F56696577204C6566743D22313135
          2220546F703D2236312C3537343833222057696474683D223130302220486569
          6768743D223022205265737472696374696F6E733D2238222056697369626C65
          3D2246616C73652220416C6C6F7745787072657373696F6E733D2246616C7365
          2220466F6E742E436861727365743D22312220466F6E742E436F6C6F723D2230
          2220466F6E742E4865696768743D222D31312220466F6E742E4E616D653D2241
          7269616C2220466F6E742E5374796C653D223022204672616D652E5479703D22
          31352220476170583D22332220476170593D2233222048416C69676E3D226861
          43656E7465722220506172656E74466F6E743D2246616C7365222056416C6967
          6E3D22766143656E7465722220546578743D2244442C204D4F4E5F5448222F3E
          3C546672784D656D6F56696577204C6566743D22302220546F703D2230222057
          696474683D223022204865696768743D223022205265737472696374696F6E73
          3D2238222056697369626C653D2246616C73652220416C6C6F77457870726573
          73696F6E733D2246616C736522204672616D652E5479703D2231352220476170
          583D22332220476170593D2233222048416C69676E3D22686143656E74657222
          2056416C69676E3D22766143656E7465722220546578743D22222F3E3C546672
          784D656D6F56696577204C6566743D22302220546F703D223232222057696474
          683D2231353122204865696768743D22323222205265737472696374696F6E73
          3D22382220416C6C6F7745787072657373696F6E733D2246616C736522204672
          616D652E5479703D2231352220476170583D22332220476170593D2233222048
          416C69676E3D22686143656E746572222056416C69676E3D22766143656E7465
          722220546578743D225452454154595F4E554D222F3E3C2F636F726E65726D65
          6D6F733E3C726F776D656D6F733E3C546672784D656D6F56696577204C656674
          3D2232302220546F703D223130302C3537343833222057696474683D22393522
          204865696768743D22313922205265737472696374696F6E733D223234222041
          6C6C6F7745787072657373696F6E733D2246616C73652220466F6E742E436861
          727365743D22312220466F6E742E436F6C6F723D22302220466F6E742E486569
          6768743D222D31312220466F6E742E4E616D653D2254696D6573204E65772052
          6F6D616E2220466F6E742E5374796C653D223022204672616D652E5479703D22
          31352220476170583D22332220476170593D22332220506172656E74466F6E74
          3D2246616C7365222056416C69676E3D22766143656E7465722220546578743D
          22222F3E3C2F726F776D656D6F733E3C726F77746F74616C6D656D6F733E3C54
          6672784D656D6F56696577204C6566743D2232302220546F703D223131392C35
          37343833222057696474683D22393522204865696768743D2231392220526573
          7472696374696F6E733D22382220416C6C6F7745787072657373696F6E733D22
          46616C73652220466F6E742E436861727365743D22312220466F6E742E436F6C
          6F723D22302220466F6E742E4865696768743D222D31312220466F6E742E4E61
          6D653D2254696D6573204E657720526F6D616E2220466F6E742E5374796C653D
          223122204672616D652E5479703D2231352220476170583D2233222047617059
          3D2233222048416C69676E3D22686143656E7465722220506172656E74466F6E
          743D2246616C7365222056416C69676E3D22766143656E746572222054657874
          3D22D098D182D0BED0B3D0BE20D0BFD0BE20D0BCD0B5D181D18FD186D0B0D0BC
          222F3E3C2F726F77746F74616C6D656D6F733E3C63656C6C66756E6374696F6E
          733E3C6974656D20312F3E3C2F63656C6C66756E6374696F6E733E3C636F6C75
          6D6E736F72743E3C6974656D20302F3E3C6974656D20322F3E3C2F636F6C756D
          6E736F72743E3C726F77736F72743E3C6974656D20302F3E3C2F726F77736F72
          743E3C2F63726F73733E}
      end
    end
  end
  object frxcrsbjct1: TfrxCrossObject
    Left = 384
    Top = 400
  end
  object odsRN06: TOracleDataSet
    SQL.Strings = (
      'SELECT vitreaty.treaty_id,'
      '       vitreaty.treaty_num,'
      '       TO_NUMBER(TO_CHAR(vi_all.months,'#39'MM'#39')) MM,'
      
        '      decode(TO_NUMBER(TO_CHAR(vi_all.months,'#39'MM'#39')), 1, '#39#1071#1085#1074#1072#1088#1100#39 +
        ', 2, '#39#1060#1077#1074#1088#1072#1083#1100#39', 3, '#39#1052#1072#1088#1090#39', 4, '#39#1040#1087#1088#1077#1083#1100#39','
      
        '              5, '#39#1052#1072#1081#39', 6, '#39#1048#1102#1085#1100#39', 7, '#39#1048#1102#1083#1100#39', 8, '#39#1040#1074#1075#1091#1089#1090#39', 9, '#39#1057 +
        #1077#1085#1090#1103#1073#1088#1100#39','
      '              10, '#39#1054#1082#1090#1103#1073#1088#1100#39', 11, '#39#1053#1086#1103#1073#1088#1100#39', '#39#1044#1077#1082#1072#1073#1088#1100#39') MON_TH,'
      '       vi_all.stage_summpay_RB'
      '  FROM (SELECT mntreaty.id treaty_id,'
      '               TRUNC(st.dateact,'#39'MM'#39') months,'
      
        '               SUM(exchange_rates.e_rate*st.summpay) stage_summp' +
        'ay_RB'
      '          FROM RN.mntreaty,'
      '               RN.mnstage st,'
      '               RN.mnagreem agr,'
      '               S.firm_account,'
      '               S.firm,'
      '               S.exchange_rates'
      '          WHERE st.dateact BETWEEN :v_datefrom'
      '                               AND LAST_DAY(:v_dateto)'
      '           AND agr.id = st.agreem_id'
      '           AND agr.istfin_kod = 1'
      '           AND firm_account.bank_accnt_id = st.exec_account_id'
      '           AND firm.firm_no = firm_account.firm_no'
      
        '           AND exchange_rates.currency_no = firm_account.currenc' +
        'y_no'
      
        '           AND exchange_rates.intro_date = (SELECT MAX(er.intro_' +
        'date)'
      
        '                                              FROM S.exchange_ra' +
        'tes er'
      
        '                                             WHERE er.intro_date' +
        ' <= st.dateact'
      
        '                                               AND er.currency_n' +
        'o = firm_account.currency_no)'
      '           AND mntreaty.id = agr.treaty_id'
      '         GROUP BY'
      '               mntreaty.id,'
      '               TRUNC(st.dateact,'#39'MM'#39')'
      '       ) vi_all,'
      '       RN.vitreaty'
      ' WHERE vitreaty.treaty_id = vi_all.treaty_id(+)'
      ''
      '   AND vitreaty.treaty_status NOT IN ('#39'A'#39', '#39'P'#39')'
      '   AND (   (vitreaty.treaty_status = '#39'O'#39')'
      
        '        OR (vitreaty.treaty_status <> '#39'O'#39' AND  TRUNC(vitreaty.DA' +
        'TETO, '#39'YEAR'#39') >= TRUNC(:V_DATEFROM, '#39'YEAR'#39')))'
      
        '   AND TRUNC(vitreaty.DATEFROM, '#39'MONTH'#39') <= TRUNC(:V_DATETO, '#39'MO' +
        'NTH'#39')'
      ''
      '   AND vitreaty.treaty_id IN (SELECT a.treaty_id'
      '                                FROM RN.mnagreem a,'
      '                                     RN.mnstage s'
      
        '                               WHERE a.treaty_id = vitreaty.trea' +
        'ty_id'
      '                                 AND s.agreem_id = a.id'
      
        '                                 AND (   s.dateact BETWEEN :v_da' +
        'tefrom'
      
        '                                                       AND LAST_' +
        'DAY(:v_dateto)'
      
        '                                      OR vitreaty.agreem_num = a' +
        '.num'
      '                                     )'
      '                                 AND a.istfin_kod = 1'
      '                             )'
      ' AND vi_all.months IS NOT NULL'
      ' ORDER BY vitreaty.treaty_num,'
      '          vitreaty.treaty_id,'
      '          vi_all.months')
    Optimize = False
    Variables.Data = {
      03000000020000000B0000003A565F4441544546524F4D0C0000000700000078
      73010101010100000000090000003A565F44415445544F0C0000000700000078
      730C0101010100000000}
    QBEDefinition.QBEFieldDefs = {
      0400000005000000090000005452454154595F49440100000000000A00000054
      52454154595F4E554D010000000000020000004D4D0100000000001000000053
      544147455F53554D4D5041595F5242010000000000060000004D4F4E5F544801
      0000000000}
    Session = seOracle
    Left = 640
    Top = 160
    object fltfldRN06TREATY_ID: TFloatField
      FieldName = 'TREATY_ID'
      Required = True
    end
    object odsRN06TREATY_NUM: TStringField
      FieldName = 'TREATY_NUM'
      Required = True
    end
    object fltfldRN06MM: TFloatField
      FieldName = 'MM'
    end
    object fltfldRN06STAGE_SUMMPAY_RB: TFloatField
      FieldName = 'STAGE_SUMMPAY_RB'
    end
    object odsRN06MON_TH: TStringField
      FieldName = 'MON_TH'
      Size = 8
    end
  end
  object frdbRN06: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = True
    FieldAliases.Strings = (
      'TREATY_ID=TREATY_ID'
      'TREATY_NUM=TREATY_NUM'
      'MM=MM'
      'STAGE_SUMMPAY_RB=STAGE_SUMMPAY_RB'
      'MON_TH=MON_TH')
    DataSet = odsRN06
    BCDToCurrency = False
    Left = 640
    Top = 208
  end
  object frRN06: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42449.956624652800000000
    ReportOptions.LastChange = 42449.956624652800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 640
    Top = 256
    Datasets = <
      item
        DataSet = frdbRN06
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      EndlessWidth = True
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        object Memo1: TfrxMemoView
          Width = 249.448980000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object DBCross1: TfrxDBCrossView
        Top = 41.574830000000000000
        Width = 235.000000000000000000
        Height = 117.000000000000000000
        ColumnLevels = 2
        DownThenAcross = False
        ShowCorner = False
        ShowTitle = False
        CellFields.Strings = (
          'STAGE_SUMMPAY_RB')
        ColumnFields.Strings = (
          'MM'
          'MON_TH')
        DataSet = frdbRN06
        DataSetName = 'frxDBDataset1'
        RowFields.Strings = (
          'TREATY_NUM')
        Memos = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574
          662D38223F3E3C63726F73733E3C63656C6C6D656D6F733E3C546672784D656D
          6F56696577204C6566743D223131352220546F703D223130302C353734383322
          2057696474683D22363122204865696768743D22313922205265737472696374
          696F6E733D2232342220416C6C6F7745787072657373696F6E733D2246616C73
          652220446973706C6179466F726D61742E466F726D61745374723D2225322E30
          6E2220446973706C6179466F726D61742E4B696E643D22666B4E756D65726963
          2220466F6E742E436861727365743D22312220466F6E742E436F6C6F723D2230
          2220466F6E742E4865696768743D222D31312220466F6E742E4E616D653D2254
          696D6573204E657720526F6D616E2220466F6E742E5374796C653D2230222046
          72616D652E5479703D2231352220476170583D22332220476170593D22332220
          48416C69676E3D22686152696768742220506172656E74466F6E743D2246616C
          7365222056416C69676E3D22766143656E7465722220546578743D222030222F
          3E3C546672784D656D6F56696577204C6566743D223131352220546F703D2231
          31392C3537343833222057696474683D22363122204865696768743D22313922
          205265737472696374696F6E733D2232342220416C6C6F774578707265737369
          6F6E733D2246616C73652220446973706C6179466F726D61742E466F726D6174
          5374723D2225322E306E2220446973706C6179466F726D61742E4B696E643D22
          666B4E756D657269632220466F6E742E436861727365743D22312220466F6E74
          2E436F6C6F723D22302220466F6E742E4865696768743D222D31312220466F6E
          742E4E616D653D2254696D6573204E657720526F6D616E2220466F6E742E5374
          796C653D223022204672616D652E5479703D2231352220476170583D22332220
          476170593D2233222048416C69676E3D22686152696768742220506172656E74
          466F6E743D2246616C7365222056416C69676E3D22766143656E746572222054
          6578743D222030222F3E3C546672784D656D6F56696577204C6566743D223136
          302220546F703D223230222057696474683D22333922204865696768743D2232
          3222205265737472696374696F6E733D2232342220416C6C6F77457870726573
          73696F6E733D2246616C736522204672616D652E5479703D2231352220476170
          583D22332220476170593D2233222048416C69676E3D22686152696768742220
          56416C69676E3D22766143656E7465722220546578743D222030222F3E3C5466
          72784D656D6F56696577204C6566743D223136302220546F703D223432222057
          696474683D22333922204865696768743D22323222205265737472696374696F
          6E733D2232342220416C6C6F7745787072657373696F6E733D2246616C736522
          204672616D652E5479703D2231352220476170583D22332220476170593D2233
          222048416C69676E3D2268615269676874222056416C69676E3D22766143656E
          7465722220546578743D222030222F3E3C546672784D656D6F56696577204C65
          66743D223137362220546F703D223130302C3537343833222057696474683D22
          333922204865696768743D22313922205265737472696374696F6E733D223234
          2220416C6C6F7745787072657373696F6E733D2246616C73652220446973706C
          6179466F726D61742E466F726D61745374723D2225322E306E2220446973706C
          6179466F726D61742E4B696E643D22666B4E756D657269632220466F6E742E43
          6861727365743D22312220466F6E742E436F6C6F723D22302220466F6E742E48
          65696768743D222D31312220466F6E742E4E616D653D2254696D6573204E6577
          20526F6D616E2220466F6E742E5374796C653D223022204672616D652E547970
          3D2231352220476170583D22332220476170593D2233222048416C69676E3D22
          686152696768742220506172656E74466F6E743D2246616C7365222056416C69
          676E3D22766143656E7465722220546578743D222030222F3E3C546672784D65
          6D6F56696577204C6566743D223137362220546F703D223131392C3537343833
          222057696474683D22333922204865696768743D223139222052657374726963
          74696F6E733D2232342220416C6C6F7745787072657373696F6E733D2246616C
          73652220446973706C6179466F726D61742E466F726D61745374723D2225322E
          306E2220446973706C6179466F726D61742E4B696E643D22666B4E756D657269
          632220466F6E742E436861727365743D22312220466F6E742E436F6C6F723D22
          302220466F6E742E4865696768743D222D31312220466F6E742E4E616D653D22
          54696D6573204E657720526F6D616E2220466F6E742E5374796C653D22302220
          4672616D652E5479703D2231352220476170583D22332220476170593D223322
          2048416C69676E3D22686152696768742220506172656E74466F6E743D224661
          6C7365222056416C69676E3D22766143656E7465722220546578743D22203022
          2F3E3C2F63656C6C6D656D6F733E3C63656C6C6865616465726D656D6F733E3C
          546672784D656D6F56696577204C6566743D22302220546F703D223022205769
          6474683D223022204865696768743D223022205265737472696374696F6E733D
          22382220416C6C6F7745787072657373696F6E733D2246616C73652220467261
          6D652E5479703D2231352220476170583D22332220476170593D223322205641
          6C69676E3D22766143656E7465722220546578743D2253544147455F53554D4D
          5041595F5242222F3E3C546672784D656D6F56696577204C6566743D22302220
          546F703D2230222057696474683D223022204865696768743D22302220526573
          7472696374696F6E733D22382220416C6C6F7745787072657373696F6E733D22
          46616C736522204672616D652E5479703D2231352220476170583D2233222047
          6170593D2233222056416C69676E3D22766143656E7465722220546578743D22
          53544147455F53554D4D5041595F5242222F3E3C546672784D656D6F56696577
          204C6566743D22302220546F703D2230222057696474683D2230222048656967
          68743D223022205265737472696374696F6E733D22382220416C6C6F77457870
          72657373696F6E733D2246616C736522204672616D652E5479703D2231352220
          476170583D22332220476170593D2233222056416C69676E3D22766143656E74
          65722220546578743D22222F3E3C2F63656C6C6865616465726D656D6F733E3C
          636F6C756D6E6D656D6F733E3C546672784D656D6F56696577204C6566743D22
          3131352220546F703D2236312C3537343833222057696474683D223631222048
          65696768743D22323022205265737472696374696F6E733D2232342220416C6C
          6F7745787072657373696F6E733D2246616C73652220466F6E742E4368617273
          65743D22312220466F6E742E436F6C6F723D22302220466F6E742E4865696768
          743D222D31322220466F6E742E4E616D653D2254696D6573204E657720526F6D
          616E2220466F6E742E5374796C653D223022204672616D652E5479703D223135
          2220476170583D22332220476170593D2233222048416C69676E3D2268614365
          6E7465722220506172656E74466F6E743D2246616C7365222056416C69676E3D
          22766143656E7465722220546578743D22222F3E3C546672784D656D6F566965
          77204C6566743D223131352220546F703D2238312C3537343833222057696474
          683D22363122204865696768743D22313922205265737472696374696F6E733D
          2232342220416C6C6F7745787072657373696F6E733D2246616C73652220466F
          6E742E436861727365743D22312220466F6E742E436F6C6F723D22302220466F
          6E742E4865696768743D222D31312220466F6E742E4E616D653D2254696D6573
          204E657720526F6D616E2220466F6E742E5374796C653D223122204672616D65
          2E5479703D2231352220476170583D22332220476170593D2233222048416C69
          676E3D22686143656E7465722220506172656E74466F6E743D2246616C736522
          2056416C69676E3D22766143656E7465722220546578743D22222F3E3C2F636F
          6C756D6E6D656D6F733E3C636F6C756D6E746F74616C6D656D6F733E3C546672
          784D656D6F56696577204C6566743D223137362220546F703D2236312C353734
          3833222057696474683D22333922204865696768743D22333922205265737472
          696374696F6E733D22382220416C6C6F7745787072657373696F6E733D224661
          6C73652220466F6E742E436861727365743D22312220466F6E742E436F6C6F72
          3D22302220466F6E742E4865696768743D222D31312220466F6E742E4E616D65
          3D2254696D6573204E657720526F6D616E2220466F6E742E5374796C653D2231
          22204672616D652E5479703D2231352220476170583D22332220476170593D22
          33222048416C69676E3D22686143656E7465722220506172656E74466F6E743D
          2246616C7365222056416C69676E3D22766143656E7465722220546578743D22
          D098D182D0BED0B3D0BE3A222F3E3C546672784D656D6F56696577204C656674
          3D223133372220546F703D223434222057696474683D22333822204865696768
          743D22323222205265737472696374696F6E733D2238222056697369626C653D
          2246616C73652220416C6C6F7745787072657373696F6E733D2246616C736522
          20466F6E742E436861727365743D22312220466F6E742E436F6C6F723D223022
          20466F6E742E4865696768743D222D31332220466F6E742E4E616D653D224172
          69616C2220466F6E742E5374796C653D223122204672616D652E5479703D2231
          352220476170583D22332220476170593D2233222048416C69676E3D22686143
          656E7465722220506172656E74466F6E743D2246616C7365222056416C69676E
          3D22766143656E7465722220546578743D22546F74616C222F3E3C2F636F6C75
          6D6E746F74616C6D656D6F733E3C636F726E65726D656D6F733E3C546672784D
          656D6F56696577204C6566743D22302220546F703D2230222057696474683D22
          31353122204865696768743D22323222205265737472696374696F6E733D2238
          222056697369626C653D2246616C73652220416C6C6F7745787072657373696F
          6E733D2246616C736522204672616D652E5479703D2231352220476170583D22
          332220476170593D2233222048416C69676E3D22686143656E74657222205641
          6C69676E3D22766143656E7465722220546578743D2253544147455F53554D4D
          5041595F5242222F3E3C546672784D656D6F56696577204C6566743D22313135
          2220546F703D2236312C3537343833222057696474683D223130302220486569
          6768743D223022205265737472696374696F6E733D2238222056697369626C65
          3D2246616C73652220416C6C6F7745787072657373696F6E733D2246616C7365
          2220466F6E742E436861727365743D22312220466F6E742E436F6C6F723D2230
          2220466F6E742E4865696768743D222D31312220466F6E742E4E616D653D2241
          7269616C2220466F6E742E5374796C653D223022204672616D652E5479703D22
          31352220476170583D22332220476170593D2233222048416C69676E3D226861
          43656E7465722220506172656E74466F6E743D2246616C7365222056416C6967
          6E3D22766143656E7465722220546578743D224D4D2C204D4F4E5F5448222F3E
          3C546672784D656D6F56696577204C6566743D22302220546F703D2230222057
          696474683D223022204865696768743D223022205265737472696374696F6E73
          3D2238222056697369626C653D2246616C73652220416C6C6F77457870726573
          73696F6E733D2246616C736522204672616D652E5479703D2231352220476170
          583D22332220476170593D2233222048416C69676E3D22686143656E74657222
          2056416C69676E3D22766143656E7465722220546578743D22222F3E3C546672
          784D656D6F56696577204C6566743D22302220546F703D223232222057696474
          683D2231353122204865696768743D22323222205265737472696374696F6E73
          3D22382220416C6C6F7745787072657373696F6E733D2246616C736522204672
          616D652E5479703D2231352220476170583D22332220476170593D2233222048
          416C69676E3D22686143656E746572222056416C69676E3D22766143656E7465
          722220546578743D225452454154595F4E554D222F3E3C2F636F726E65726D65
          6D6F733E3C726F776D656D6F733E3C546672784D656D6F56696577204C656674
          3D2232302220546F703D223130302C3537343833222057696474683D22393522
          204865696768743D22313922205265737472696374696F6E733D223234222041
          6C6C6F7745787072657373696F6E733D2246616C73652220466F6E742E436861
          727365743D22312220466F6E742E436F6C6F723D22302220466F6E742E486569
          6768743D222D31312220466F6E742E4E616D653D2254696D6573204E65772052
          6F6D616E2220466F6E742E5374796C653D223022204672616D652E5479703D22
          31352220476170583D22332220476170593D22332220506172656E74466F6E74
          3D2246616C7365222056416C69676E3D22766143656E7465722220546578743D
          22222F3E3C2F726F776D656D6F733E3C726F77746F74616C6D656D6F733E3C54
          6672784D656D6F56696577204C6566743D2232302220546F703D223131392C35
          37343833222057696474683D22393522204865696768743D2231392220526573
          7472696374696F6E733D22382220416C6C6F7745787072657373696F6E733D22
          46616C73652220466F6E742E436861727365743D22312220466F6E742E436F6C
          6F723D22302220466F6E742E4865696768743D222D31312220466F6E742E4E61
          6D653D2254696D6573204E657720526F6D616E2220466F6E742E5374796C653D
          223122204672616D652E5479703D2231352220476170583D2233222047617059
          3D2233222048416C69676E3D22686143656E7465722220506172656E74466F6E
          743D2246616C7365222056416C69676E3D22766143656E746572222054657874
          3D22D098D182D0BED0B3D0BE20D0BFD0BE20D0BCD0B5D181D18FD186D0B0D0BC
          222F3E3C2F726F77746F74616C6D656D6F733E3C63656C6C66756E6374696F6E
          733E3C6974656D20312F3E3C2F63656C6C66756E6374696F6E733E3C636F6C75
          6D6E736F72743E3C6974656D20302F3E3C6974656D20322F3E3C2F636F6C756D
          6E736F72743E3C726F77736F72743E3C6974656D20302F3E3C2F726F77736F72
          743E3C2F63726F73733E}
      end
    end
  end
  object frRN16: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42450.047479143490000000
    ReportOptions.LastChange = 42450.047479143490000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 456
    Top = 595
    Datasets = <
      item
        DataSet = frdsRN16_1
        DataSetName = 'frdbRN16_1'
      end
      item
        DataSet = frdsRN16_3
        DataSetName = 'frdbRN16_3'
      end
      item
        DataSet = frdsRN16_2
        DataSetName = 'frdbRN16_2'
      end>
    Variables = <
      item
        Name = ' Category'
        Value = Null
      end
      item
        Name = 'GENDIR'
        Value = ''
      end
      item
        Name = 'REP_YEAR'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 279.400000000000000000
      PaperHeight = 215.900000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 226.771800000000000000
        Top = 18.897650000000000000
        Width = 980.410081999999900000
        object Memo2: TfrxMemoView
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#164#1056#1115#1056#160#1056#1114#1056#1106' RN-16')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Top = 102.047310000000000000
          Width = 476.220780000000000000
          Height = 22.677165350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1119#1057#1026#1056#181#1056#1169#1056#187#1056#1109#1056#182#1056#181#1056#1029#1056#1105#1057#1039' '#1056#1030' '#1056#1111#1056#187#1056#176#1056#1029)
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 124.724490000000000000
          Width = 600.945270000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            
              #1056#1111#1057#1026#1056#1109#1056#1030#1056#181#1056#1169#1056#181#1056#1029#1056#1105#1057#1039' '#1056#1029#1056#176#1057#1107#1057#8225#1056#1029#1056#1109'-'#1056#1105#1057#1027#1057#1027#1056#187#1056#181#1056#1169#1056#1109#1056#1030#1056#176#1057#8218#1056#181#1056#187#1057#1034#1057#1027#1056#1108 +
              #1056#1105#1057#8230','
            
              #1056#1109#1056#1111#1057#8249#1057#8218#1056#1029#1056#1109'-'#1056#1108#1056#1109#1056#1029#1057#1027#1057#8218#1057#1026#1057#1107#1056#1108#1057#8218#1056#1109#1057#1026#1057#1027#1056#1108#1056#1105#1057#8230', '#1056#1109#1056#1111#1057#8249#1057#8218#1056#1029#1056#1109'-'#1057#8218#1056#181#1057#8230 +
              #1056#1029#1056#1109#1056#187#1056#1109#1056#1110#1056#1105#1057#8225#1056#181#1057#1027#1056#1108#1056#1105#1057#8230' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218
            
              #1056#1105' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218' '#1056#1111#1056#1109' '#1056#1111#1056#1109#1056#1169#1056#1110#1056#1109#1057#8218#1056#1109#1056#1030#1056#1108#1056#181' '#1056#1105' '#1056#1109#1057#1027#1056#1030#1056#1109#1056#181#1056#1029#1056#1105#1057#1035' '#1056#1111#1057#1026 +
              #1056#1109#1056#1105#1056#183#1056#1030#1056#1109#1056#1169#1057#1027#1057#8218#1056#1030#1056#176' '#1056#1029#1056#1109#1056#1030#1057#8249#1057#8230' '#1056#1030#1056#1105#1056#1169#1056#1109#1056#1030' '#1056#1029#1056#176#1057#1107#1056#1108#1056#1109#1057#8216#1056#1112#1056#1108#1056#1109#1056#8470' ' +
              #1056#1111#1057#1026#1056#1109#1056#1169#1057#1107#1056#1108#1057#8224#1056#1105#1056#1105)
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 181.417440000000000000
          Width = 982.677800000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#1119#1056#8226#1056#160#1056#8226#1056#167#1056#8226#1056#1116#1056#172' '#1056#8221#1056#1115#1056#8220#1056#1115#1056#8217#1056#1115#1056#160#1056#1115#1056#8217' '#1056#1115#1056#1119#1056#8250#1056#1106#1056#167#1056#152#1056#8217#1056#1106#1056#8226#1056#1114#1056#171#1056#1168' '#1056#152#1056 +
              #8212' '#1056#1038#1056#1115#1056#8216#1056#1038#1056#1118#1056#8217#1056#8226#1056#1116#1056#1116#1056#171#1056#1168' '#1056#1038#1056#160#1056#8226#1056#8221#1056#1038#1056#1118#1056#8217' '#1056#1119#1056#1115' '#1056#1118#1056#8226#1056#1114#1056#1106#1056#1114)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Top = 207.874150000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 650.079160000000000000
          Width = 328.819110000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1032#1056#1118#1056#8217#1056#8226#1056#160#1056#8211#1056#8221#1056#1106#1056#174)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 650.079160000000000000
          Top = 26.456710000000000000
          Width = 328.819110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            
              #1056#8220#1056#181#1056#1029#1056#181#1057#1026#1056#176#1056#187#1057#1034#1056#1029#1057#8249#1056#8470' '#1056#1169#1056#1105#1057#1026#1056#181#1056#1108#1057#8218#1056#1109#1057#1026' '#1056#1115#1056#1106#1056#1115' "'#1056#8216#1056#181#1056#187#1056#176#1057#1026#1057#1107#1057#1027#1057#1034 +
              #1056#1108#1056#176#1056#187#1056#1105#1056#8470'"')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 650.079160000000000000
          Top = 45.354360000000000000
          Width = 332.598640000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '____________________[GENDIR]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 650.079160000000000000
          Top = 75.590600000000000000
          Width = 328.819110000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '"_____"__________________20    '#1056#1110)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 268.346630000000000000
        Width = 980.410081999999900000
        PrintOnFirstPage = False
        object Memo27: TfrxMemoView
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 37.795300000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 94.488250000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 302.362400000000000000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 476.220780000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 536.693260000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 597.165740000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 661.417750000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 718.110700000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '9')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 117.385900000000000000
        Top = 347.716760000000000000
        Width = 980.410081999999900000
        object Memo7: TfrxMemoView
          Width = 37.795300000000000000
          Height = 68.031540000000010000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111'.'#1056#1111'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 37.795300000000000000
          Width = 56.692950000000010000
          Height = 68.031540000000010000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 94.488250000000000000
          Width = 207.874150000000000000
          Height = 68.031540000000010000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 302.362400000000000000
          Width = 173.858380000000000000
          Height = 68.031540000000010000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1115#1057#1026#1056#1110#1056#176#1056#1029#1056#1105#1056#183#1056#176#1057#8224#1056#1105#1057#1039'-'#1056#1105#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 476.220780000000000000
          Width = 120.944960000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1026#1056#1109#1056#1108#1056#1105' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1105#1057#1039)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 476.220780000000000000
          Top = 30.236240000000010000
          Width = 60.472480000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1057#8225#1056#176#1056#187#1056#1109)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 536.693260000000000000
          Top = 30.236240000000010000
          Width = 60.472480000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1115#1056#1108#1056#1109#1056#1029#1057#8225#1056#176'-'
            #1056#1029#1056#1105#1056#181)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 597.165740000000000000
          Width = 120.944960000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1115#1057#1026#1056#1105#1056#181#1056#1029#1057#8218#1056#1105#1057#1026#1056#1109#1056#1030#1056#1109#1057#8225#1056#1029#1056#176#1057#1039' '#1057#1027#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034', '#1056#177#1056#181#1056#187'.'#1057#1026#1057#1107#1056#177)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 597.165740000000000000
          Top = 30.456709999999990000
          Width = 64.252010000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 661.417750000000000000
          Top = 30.236240000000010000
          Width = 56.692950000000010000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[REP_YEAR] '#1056#1110'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 718.110700000000000000
          Width = 264.567100000000000000
          Height = 68.031540000000010000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#1115#1057#1027#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#1169#1056#187#1057#1039' '#1056#1030#1056#1108#1056#187#1057#1035#1057#8225#1056#181#1056#1029#1056#1105#1057#1039' '#1056#1030' '#1056#1111#1056#187#1056#176#1056#1029', '#1056#1109#1056#182#1056#1105 +
              #1056#1169#1056#176#1056#181#1056#1112#1057#8249#1056#181' '#1057#1026#1056#181#1056#183#1057#1107#1056#187#1057#1034#1057#8218#1056#176#1057#8218#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Top = 68.031540000000010000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 37.795300000000000000
          Top = 68.031540000000010000
          Width = 56.692950000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 94.488250000000000000
          Top = 68.031540000000010000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 302.362400000000000000
          Top = 68.031540000000010000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 476.220780000000000000
          Top = 68.031540000000010000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 536.693260000000000000
          Top = 68.031540000000010000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 597.165740000000000000
          Top = 68.031540000000010000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 661.417750000000000000
          Top = 68.031540000000010000
          Width = 56.692950000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 718.110700000000000000
          Top = 68.031540000000010000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '9')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Top = 87.149659999999990000
          Width = 982.677800000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1119#1056#8226#1056#160#1056#8226#1056#1168#1056#1115#1056#8221#1056#1031#1056#169#1056#152#1056#8226' '#1056#8221#1056#1115#1056#8220#1056#1115#1056#8217#1056#1115#1056#160#1056#171)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 540.472790000000000000
        Width = 980.410081999999900000
        DataSet = frdsRN16_1
        DataSetName = 'frdbRN16_1'
        RowCount = 0
        Stretched = True
        object Memo38: TfrxMemoView
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[Line#]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 37.795300000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_1."TREATY_NUM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 94.488250000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haBlock
          Memo.UTF8 = (
            '[frdbRN16_1."TREATY_NAME"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 302.362400000000000000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frdbRN16_1."EXEC_NAME"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 476.220780000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_1."DATE_FROM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 536.693260000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_1."DATE_TO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 597.165740000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_1."TREATY_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 661.417750000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_1."SPC"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 718.110700000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haBlock
          Memo.UTF8 = (
            '[frdbRN16_1."SUMMARY"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 487.559370000000000000
        Width = 980.410081999999900000
        Condition = 'frdbRN16_1."SUBJECT_KOD"'
        Stretched = True
        object Memo36: TfrxMemoView
          Width = 982.677800000000000000
          Height = 30.236240000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_1."SUBJECT_KOD"]. [frdbRN16_1."CHAPTER_NAIM"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 582.047620000000000000
        Width = 980.410081999999900000
        object Memo50: TfrxMemoView
          Left = 385.512060000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Left = 529.134200000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frdbRN16_1."TREATY_SUMMPAY">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Left = 668.976810000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[SUM(<frdbRN16_1."SPC">,MasterData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 740.787880000000000000
        Width = 980.410081999999900000
        DataSet = frdsRN16_2
        DataSetName = 'frdbRN16_2'
        RowCount = 0
        Stretched = True
        object Memo53: TfrxMemoView
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[Line#]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 37.795300000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_2."TREATY_NUM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 94.488250000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haBlock
          Memo.UTF8 = (
            '[frdbRN16_2."TREATY_NAME"]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 302.362400000000000000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frdbRN16_2."EXEC_NAME"]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 476.220780000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_2."DATE_FROM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 536.693260000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_2."DATE_TO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Left = 597.165740000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_2."TREATY_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Left = 661.417750000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_2."SPC"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          Left = 718.110700000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haBlock
          Memo.UTF8 = (
            '[frdbRN16_2."SUMMARY"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 687.874460000000000000
        Width = 980.410081999999900000
        Condition = 'frdbRN16_2."SUBJECT_KOD"'
        Stretched = True
        object Memo62: TfrxMemoView
          Width = 982.677800000000000000
          Height = 30.236240000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_2."SUBJECT_KOD"]. [frdbRN16_2."CHAPTER_NAIM"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 782.362710000000000000
        Width = 980.410081999999900000
        object Memo63: TfrxMemoView
          Left = 385.512060000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo64: TfrxMemoView
          Left = 529.134200000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frdbRN16_2."TREATY_SUMMPAY">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 668.976810000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[SUM(<frdbRN16_2."SPC">,MasterData2)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 634.961040000000000000
        Width = 980.410081999999900000
        object Memo66: TfrxMemoView
          Width = 982.677800000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#1115#1056#8217#1056#171#1056#8226' '#1056#1118#1056#8226#1056#1114#1056#171)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 941.102970000000000000
        Width = 980.410081999999900000
        DataSet = frdsRN16_3
        DataSetName = 'frdbRN16_3'
        RowCount = 0
        Stretched = True
        object Memo67: TfrxMemoView
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[Line#]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo68: TfrxMemoView
          Left = 37.795300000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_3."TREATY_NUM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo69: TfrxMemoView
          Left = 94.488250000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haBlock
          Memo.UTF8 = (
            '[frdbRN16_3."TREATY_NAME"]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 302.362400000000000000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frdbRN16_3."EXEC_NAME"]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 476.220780000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_3."DATE_FROM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Left = 536.693260000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_3."DATE_TO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo73: TfrxMemoView
          Left = 597.165740000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_3."TREATY_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo74: TfrxMemoView
          Left = 661.417750000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_3."SPC"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo75: TfrxMemoView
          Left = 718.110700000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haBlock
          Memo.UTF8 = (
            '[frdbRN16_3."SUMMARY"]')
          ParentFont = False
        end
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 888.189550000000000000
        Width = 980.410081999999900000
        Condition = 'frdbRN16_2."SUBJECT_KOD"'
        Stretched = True
        object Memo76: TfrxMemoView
          Width = 982.677800000000000000
          Height = 30.236240000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frdbRN16_3."SUBJECT_KOD"]. [frdbRN16_3."CHAPTER_NAIM"]')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Footer3: TfrxFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 982.677800000000000000
        Width = 980.410081999999900000
        object Memo77: TfrxMemoView
          Left = 385.512060000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo78: TfrxMemoView
          Left = 529.134200000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frdbRN16_3."TREATY_SUMMPAY">,MasterData3)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo79: TfrxMemoView
          Left = 668.976810000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[SUM(<frdbRN16_3."SPC">,MasterData3)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header3: TfrxHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 835.276130000000000000
        Width = 980.410081999999900000
        object Memo80: TfrxMemoView
          Width = 982.677800000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1118#1056#8226#1056#1114#1056#171' '#1056#1119#1056#160#1056#1115#1056#1025#1056#8250#1056#1115#1056#8220#1056#1115' '#1056#8220#1056#1115#1056#8221#1056#1106)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 1073.386520000000000000
        Width = 980.410081999999900000
        object Memo81: TfrxMemoView
          Left = 385.512060000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo82: TfrxMemoView
          Left = 480.000310000000000000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            
              '[SUM(<frdbRN16_1."TREATY_SUMMPAY">,MasterData1)+SUM(<frdbRN16_2.' +
              '"TREATY_SUMMPAY">,MasterData2)+SUM(<frdbRN16_3."TREATY_SUMMPAY">' +
              ',MasterData3)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo83: TfrxMemoView
          Left = 668.976810000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            
              '[SUM(<frdbRN16_1."SPC">,MasterData1)+SUM(<frdbRN16_2."SPC">,Mast' +
              'erData2)+SUM(<frdbRN16_3."SPC">,MasterData3)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 1137.638530000000000000
        Width = 980.410081999999900000
        object Memo84: TfrxMemoView
          Left = 884.410020000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#8250#1056#1105#1057#1027#1057#8218' [Page#]')
          ParentFont = False
        end
      end
    end
  end
  object frdsRN16_1: TfrxDBDataset
    UserName = 'frdbRN16_1'
    CloseDataSource = False
    DataSet = odsRN016_1
    BCDToCurrency = False
    Left = 400
    Top = 533
  end
  object odsRN016_1: TOracleDataSet
    SQL.Strings = (
      
        'SELECT ID, TREATY_NUM, TREATY_NAME, EXEC_NAME, DATE_FROM, DATE_T' +
        'O,'
      
        '       TREATY_SUMMPAY, SUMMARY, subject_KOD, CHAPTER_NAIM, SUM(s' +
        'tage_summpay_current*E_RATE) SPC'
      'FROM        '
      '('
      'SELECT vitreaty.treaty_id ID,'
      '       vitreaty.treaty_num treaty_num,'
      '       vitreaty.subject treaty_name,'
      '       vitreaty.exec_name exec_name,'
      '       --vitreaty.datefrom date_from,'
      
        '       MIN(st.datefrom) OVER (PARTITION BY vitreaty.treaty_id) d' +
        'ate_from,'
      '       --vitreaty.dateto date_to,'
      
        '       MAX(NVL(st.dateact, st.dateto)) OVER (PARTITION BY vitrea' +
        'ty.treaty_id) date_to,'
      '       vitreaty.currency_no currency_no,'
      
        '       DECODE(TRUNC(st.dateto,'#39'yyyy'#39'), TRUNC(:REP_YEAR,'#39'yyyy'#39'), ' +
        'st.summpay, 0) stage_summpay_current,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       vitreaty.summpay treaty_summpay,'
      '       st.dateact dateact,'
      '       NVL(st.dateact, st.dateto) stage_dateto,'
      ''
      '       DECODE(vitreaty.currency_no,'
      '              933, 1,'
      '              NVL((SELECT MIN(e.rate)'
      '                    FROM RN.MiEXCHANGE e'
      '                   WHERE e.currency_no = vitreaty.currency_no'
      
        '                     AND e.YEAR =  TO_NUMBER(TO_CHAR(:REP_YEAR, ' +
        #39'yyyy'#39'))'
      
        '                     AND NVL(st.dateact, st.dateto) >= TRUNC(:RE' +
        'P_YEAR, '#39'YEAR'#39')'
      '                  ),'
      '                  (SELECT ER.E_RATE'
      '                     FROM S.EXCHANGE_RATES er'
      
        '                    WHERE er.intro_date = RN.MONEY_PKG.getdateof' +
        'exchangeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '             st.dateact, agr.treaty_id,'
      
        '                                                                ' +
        '             vitreaty.datefrom)'
      '                      AND er.CURRENCY_NO = vitreaty.currency_no'
      '                  ))'
      '             ) e_rate,'
      ''
      '       vitreaty.CHAPTER_KOD subject_KOD,'
      '       chap.PNAIM CHAPTER_NAIM,'
      '       summary.summary summary,'
      '       vitreaty.treaty_status status'
      '  FROM rn.vitreaty,'
      '       rn.mnstage st,'
      '       rn.mnagreem agr,'
      '       s.currency,'
      '       rn.mnsummary summary,'
      '       rn.michapter chap'
      '  WHERE'
      
        '  TRUNC((SELECT MIN(st1.datefrom) FROM rn.mnagreem agr1, rn.mnst' +
        'age st1 WHERE vitreaty.treaty_id = agr1.treaty_id'
      
        '                                                                ' +
        '    AND st1.agreem_id = agr1.id'
      
        '                                                                ' +
        '    AND (   st1.dateact IS NOT NULL AND agr1.num < vitreaty.agre' +
        'em_num'
      
        '                                                                ' +
        '         OR agr1.num = vitreaty.agreem_num)), '#39'YEAR'#39')'
      '     <= :REP_YEAR'
      
        '   AND (SELECT MAX(NVL(st1.dateact, st1.dateto)) FROM rn.mnagree' +
        'm agr1, rn.mnstage st1 WHERE vitreaty.treaty_id = agr1.treaty_id'
      
        '                                                                ' +
        '    AND st1.agreem_id = agr1.id'
      
        '                                                                ' +
        '    AND (   st1.dateact IS NOT NULL AND agr1.num < vitreaty.agre' +
        'em_num'
      
        '                                                                ' +
        '         OR agr1.num = vitreaty.agreem_num)) >= :REP_YEAR'
      '   AND (    vitreaty.treaty_status = '#39'O'#39
      
        '         OR ((vitreaty.treaty_status = '#39'F'#39') AND ((vitreaty.datet' +
        'o >=  :REP_YEAR) and (TRUNC(vitreaty.datefrom, '#39'YEAR'#39') <=  :REP_' +
        'YEAR))))'
      '   AND vitreaty.istfin_kod = :istfin_kod'
      '   AND currency.currency_no = vitreaty.currency_no'
      '   AND vitreaty.treaty_id = agr.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      '   AND summary.treaty_id(+) = vitreaty.treaty_id'
      '   AND chap.kod = vitreaty.chapter_kod'
      ')'
      
        'GROUP BY ID, TREATY_NUM, TREATY_NAME, EXEC_NAME, DATE_FROM, DATE' +
        '_TO,'
      '         TREATY_SUMMPAY, SUMMARY, subject_KOD, CHAPTER_NAIM'
      'ORDER BY SUBJECT_KOD, ID')
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A5245505F594541520C00000007000000787401
      01010101000000000B0000003A49535446494E5F4B4F44030000000400000001
      00000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000B0000000200000049440100000000000A0000005452454154595F4E
      554D0100000000000B0000005452454154595F4E414D45010000000000090000
      00455845435F4E414D4501000000000009000000444154455F46524F4D010000
      00000007000000444154455F544F0100000000000E0000005452454154595F53
      554D4D5041590100000000000700000053554D4D4152590100000000000B0000
      005355424A4543545F4B4F440100000000000C000000434841505445525F4E41
      494D01000000000003000000535043010000000000}
    Session = seOracle
    Left = 400
    Top = 488
  end
  object odsRN018: TOracleDataSet
    SQL.Strings = (
      'SELECT tr.treaty_num || '#39', '#39' || tr.exec_name name,'
      '       tr.subject dog_name,'
      '       TO_CHAR(tr.DATETO, '#39'yyyy'#39') DATETO,'
      '       TO_CHAR(exp_inc.plan_date, '#39'yyyy'#39') plan_date,'
      '       TO_CHAR(exp_inc.FACT_DATE_FROM, '#39'yyyy'#39') FACT_DATE_FROM,'
      '       TO_CHAR(exp_inc.FACT_DATE_TO, '#39'yyyy'#39') FACT_DATE_TO,'
      '       exp_inc.description exp_income,'
      '       exp_inc_period.description fact_exp_inc,'
      '       COUNT(tr.treaty_id) OVER (PARTITION BY 1) count_rec'
      '  FROM rn.VITREATY tr,'
      '       rn.MNECONOMIC_PARAMETERS exp_inc,'
      '       rn.MNECONOMIC_PARAMETER_PERIOD exp_inc_period'
      ' WHERE tr.DATETO BETWEEN :DATEFROM AND :DATETO'
      '   AND tr.DATETO <> :DATETO'
      '   AND tr.ISTFIN_KOD = :ISTFIN'
      '   AND tr.TREATY_STATUS = '#39'F'#39
      '   AND tr.treaty_id = exp_inc.treaty_id'
      '   AND exp_inc.TYPE_PARAMETERS = 1'
      '   AND exp_inc.treaty_id = exp_inc_period.treaty_id(+)'
      '   AND exp_inc.TYPE_PARAMETERS = exp_inc_period.TYPE(+)'
      '   AND TRUNC(:DATETO - 365, '#39'YEAR'#39') = exp_inc_period.PERIOD(+)')
    Optimize = False
    Variables.Data = {
      0300000003000000090000003A4441544546524F4D0C00000007000000787301
      0101010100000000070000003A44415445544F0C000000070000007874010101
      010100000000070000003A49535446494E030000000400000001000000000000
      00}
    QBEDefinition.QBEFieldDefs = {
      0400000009000000040000004E414D4501000000000008000000444F475F4E41
      4D450100000000000600000044415445544F01000000000009000000504C414E
      5F444154450100000000000E000000464143545F444154455F46524F4D010000
      0000000C000000464143545F444154455F544F0100000000000A000000455850
      5F494E434F4D450100000000000C000000464143545F4558505F494E43010000
      00000009000000434F554E545F524543010000000000}
    Session = seOracle
    Left = 640
    Top = 456
  end
  object frdsRN018: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NAME=NAME'
      'DOG_NAME=DOG_NAME'
      'DATETO=DATETO'
      'PLAN_DATE=PLAN_DATE'
      'FACT_DATE_FROM=FACT_DATE_FROM'
      'FACT_DATE_TO=FACT_DATE_TO'
      'EXP_INCOME=EXP_INCOME'
      'FACT_EXP_INC=FACT_EXP_INC'
      'COUNT_REC=COUNT_REC')
    DataSet = odsRN018
    BCDToCurrency = False
    Left = 640
    Top = 504
  end
  object frRN018: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42450.671276261600000000
    ReportOptions.LastChange = 42450.671276261600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 640
    Top = 552
    Datasets = <
      item
        DataSet = frdsRN018
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' Category'
        Value = Null
      end
      item
        Name = 'GLING'
        Value = ''
      end
      item
        Name = 'REPF'
        Value = ''
      end
      item
        Name = 'REPT'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 151.181200000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo2: TfrxMemoView
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#164#1056#1115#1056#160#1056#1114#1056#1106' RN-18')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 793.701300000000000000
          Width = 253.228510000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1032#1056#1118#1056#8217#1056#8226#1056#160#1056#8211#1056#8221#1056#1106#1056#174':'
            #1056#8220#1056#187#1056#176#1056#1030#1056#1029#1057#8249#1056#8470' '#1056#1105#1056#1029#1056#182#1056#181#1056#1029#1056#181#1057#1026
            #1056#1115#1056#1106#1056#1115' "'#1056#8216#1056#181#1056#187#1056#176#1057#1026#1057#1107#1057#1027#1057#1034#1056#1108#1056#176#1056#187#1056#1105#1056#8470'"')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 98.267780000000000000
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1115#1056#1118#1056#167#1056#1027#1056#1118
            
              #1056#1109#1056#177' '#1057#1036#1057#8222#1057#8222#1056#181#1056#1108#1057#8218#1056#1105#1056#1030#1056#1029#1056#1109#1057#1027#1057#8218#1056#1105' '#1056#1116#1056#152#1056#1115#1056#1113#1056#160', '#1056#183#1056#176#1056#1030#1056#181#1057#1026#1057#8364#1057#8216#1056#1029#1056#1029#1057#8249 +
              #1057#8230' '#1056#1030' [REPF] - [REPT] '#1056#1110#1056#1110'.')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 136.063080000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 793.701300000000000000
          Top = 45.354360000000000000
          Width = 253.228510000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '_____________________[GLING]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo41: TfrxMemoView
          Left = 793.701300000000000000
          Top = 71.811070000000000000
          Width = 253.228510000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '"___"________________20    '#1056#1110'.')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 502.677490000000000000
        Width = 1046.929810000000000000
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 192.756030000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo24: TfrxMemoView
          Width = 37.795300000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 37.795300000000000000
          Width = 151.181200000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 188.976500000000000000
          Width = 170.078850000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 359.055350000000000000
          Width = 56.692950000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 415.748300000000000000
          Width = 56.692950000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 472.441250000000000000
          Width = 56.692950000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 529.134200000000000000
          Width = 302.362400000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 831.496600000000000000
          Width = 215.433210000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 551.811380000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#8250#1056#1105#1057#1027#1057#8218' [Line#]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 83.149660000000000000
        Top = 268.346630000000000000
        Width = 1046.929810000000000000
        object Memo6: TfrxMemoView
          Width = 37.795300000000000000
          Height = 68.031540000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111'/'#1056#1111)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 37.795300000000000000
          Width = 151.181200000000000000
          Height = 68.031540000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176','
            #1056#1105#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 188.976500000000000000
          Width = 170.078850000000000000
          Height = 68.031540000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 359.055350000000000000
          Width = 56.692950000000000000
          Height = 68.031540000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1026#1056#1109#1056#1108' '#1056#183#1056#176#1056#1030#1056#181#1057#1026'-'
            #1057#8364#1056#181#1056#1029#1056#1105#1057#1039' '#1056#1116#1056#152#1056#1115#1056#1113#1056#160)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 415.748300000000000000
          Width = 113.385900000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1026#1056#1109#1056#1108' '#1056#1030#1056#1029#1056#181#1056#1169#1057#1026#1056#181#1056#1029#1056#1105#1057#1039' '#1057#1026#1056#176#1056#183#1057#1026#1056#176#1056#177#1056#1109#1057#8218#1056#1108#1056#1105)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 415.748300000000000000
          Top = 37.795300000000110000
          Width = 56.692950000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1119#1056#187#1056#176#1056#1029)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 472.441250000000000000
          Top = 37.795300000000110000
          Width = 56.692950000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#164#1056#176#1056#1108#1057#8218)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 529.134200000000000000
          Width = 517.795610000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#173#1057#8222#1057#8222#1056#181#1056#1108#1057#8218#1056#1105#1056#1030#1056#1029#1056#1109#1057#1027#1057#8218#1057#1034' '#1056#1030#1056#1029#1056#181#1056#1169#1057#1026#1056#181#1056#1029#1056#1105#1057#1039' '#1057#1026#1056#176#1056#183#1057#1026#1056#176#1056#177#1056#1109#1057#8218#1056#1108 +
              #1056#1105)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 529.134200000000000000
          Top = 37.795300000000110000
          Width = 302.362400000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1115#1056#182#1056#1105#1056#1169#1056#176#1056#181#1056#1112#1056#176#1057#1039' '#1056#1110#1056#1109#1056#1169#1056#1109#1056#1030#1056#176#1057#1039)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 831.496600000000000000
          Top = 37.795300000000110000
          Width = 215.433210000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#164#1056#176#1056#1108#1057#8218#1056#1105#1057#8225#1056#181#1057#1027#1056#1108#1056#176#1057#1039' '#1056#1030' 2016 '#1056#1110'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Top = 68.031540000000010000
          Width = 37.795300000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 37.795300000000000000
          Top = 68.031540000000010000
          Width = 151.181200000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 188.976500000000000000
          Top = 68.031540000000010000
          Width = 170.078850000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 359.055350000000000000
          Top = 68.031540000000010000
          Width = 56.692950000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 415.748300000000000000
          Top = 68.031540000000010000
          Width = 56.692950000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 472.441250000000000000
          Top = 68.031540000000010000
          Width = 56.692950000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 529.134200000000000000
          Top = 68.031540000000010000
          Width = 302.362400000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 831.496600000000000000
          Top = 68.031540000000010000
          Width = 215.433210000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 419.527830000000000000
        Width = 1046.929810000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 374.173470000000000000
        Width = 1046.929810000000000000
        DataSet = frdsRN018
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        Stretched = True
        object Memo32: TfrxMemoView
          Width = 37.795300000000000000
          Height = 22.677165354330700000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[Line#]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 37.795300000000000000
          Width = 151.181200000000000000
          Height = 22.677165350000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."NAME"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 188.976500000000000000
          Width = 170.078850000000000000
          Height = 22.677165350000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haBlock
          Memo.UTF8 = (
            '[frxDBDataset1."DOG_NAME"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 359.055350000000000000
          Width = 56.692950000000000000
          Height = 22.677165354330700000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."DATETO"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 415.748300000000000000
          Width = 56.692950000000000000
          Height = 22.677165354330700000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."PLAN_DATE"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 472.441250000000000000
          Width = 56.692950000000000000
          Height = 22.677165354330700000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."FACT_DATE_FROM"]'
            '[frxDBDataset1."FACT_DATE_TO"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 529.134200000000000000
          Width = 302.362400000000000000
          Height = 22.677165350000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haBlock
          Memo.UTF8 = (
            '[frxDBDataset1."EXP_INCOME"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 831.496600000000000000
          Width = 215.433210000000000000
          Height = 22.677165350000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haBlock
          Memo.UTF8 = (
            '[frxDBDataset1."FACT_EXP_INC"]')
          ParentFont = False
        end
      end
    end
  end
  object odsRN08: TOracleDataSet
    SQL.Strings = (
      'SELECT tr.treaty_id ID, '
      '       tr.treaty_num || '#39', '#39'||tr.exec_name NUM,'
      '       tr.subject SUBJ,'
      '       TO_CHAR(tr.datefrom,'#39'MM.YYYY'#39') DATEFROM,'
      '       TO_CHAR(tr.dateto,'#39'MM.YYYY'#39') DATETO,'
      '       tr.summpay TREATY_SUMMPAY,'
      '       trs.SBF,'
      '       trs.scur,'
      '       tr.treaty_status STATUS,'
      '       '#39#39' kurs_str  '
      'FROM RN.vitreaty tr,'
      ' (SELECT TREATY_ID, SUM(SUMBEFORE) SBF, SUM(SUMCURRENT) SCUR'
      '  FROM( '
      
        '      SELECT TREATY_ID, SUM(stsum * E_RATE) SUMBEFORE, 0 SUMCURR' +
        'ENT'
      '        FROM('
      '          SELECT tr.treaty_id,'
      '          DECODE(tr.currency_no, 933, 1,'
      '          (SELECT DISTINCT ER.E_RATE FROM S.EXCHANGE_RATES er'
      
        '            WHERE er.intro_date = RN.MONEY_PKG.getdateofexchange' +
        'ofstage(tr.currency_no, st.dateact,agr.treaty_id, tr.datefrom)'
      '              AND er.CURRENCY_NO = tr.currency_no'
      '          )) e_rate,'
      '          st.summpay stsum'
      '          FROM RN.vitreaty tr,'
      '               RN.mnagreem agr,'
      '               RN.mnstage st'
      '         WHERE agr.treaty_id = tr.treaty_id'
      '           AND st.agreem_id = agr.id'
      '           AND tr.istfin_kod = 1 --'#1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072
      
        '           AND tr.treaty_status NOT IN ('#39'A'#39', '#39'P'#39') --'#1053#1077' '#1072#1085#1091#1083#1083#1080#1088#1086#1074 +
        #1072#1085', '#1085#1077' '#1090#1077#1084#1087#1083#1072#1085
      
        '           AND tr.datefrom < TO_DATE('#39'01.01.'#39' || (:yr + 1), '#39'dd.' +
        'mm.yyyy'#39') --'#1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1076#1086#1075#1086#1074#1086#1088#1072
      
        '           AND (st.dateact IS NOT NULL AND agr.num < tr.agreem_n' +
        'um -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '                OR agr.num = tr.agreem_num)'
      '           AND ((tr.treaty_status =  '#39'O'#39')'
      
        '                OR (tr.treaty_status <> '#39'O'#39' AND  tr.dateto >= TO' +
        '_DATE('#39'01.01.'#39' || :yr, '#39'dd.mm.yyyy'#39')))'
      
        '           AND st.datefrom < TO_DATE('#39'01.01.'#39' || (:yr + 1), '#39'dd.' +
        'mm.yyyy'#39')'
      
        '           AND st.dateto < TO_DATE('#39'01.01.'#39' || (:yr), '#39'dd.mm.yyy' +
        'y'#39')'
      '        )GROUP BY TREATY_ID'
      '    UNION ALL        '
      
        '        SELECT TREATY_ID, 0 SUMBEFORE, SUM(stsum * E_RATE) SUMCU' +
        'RRENT'
      '        FROM('
      '          SELECT tr.treaty_id,'
      '          DECODE(tr.currency_no, 933, 1,'
      '          (SELECT DISTINCT ER.E_RATE FROM S.EXCHANGE_RATES er'
      
        '            WHERE er.intro_date = RN.MONEY_PKG.getdateofexchange' +
        'ofstage(tr.currency_no, st.dateact,agr.treaty_id, tr.datefrom)'
      '              AND er.CURRENCY_NO = tr.currency_no'
      '          )) e_rate,'
      '          st.summpay stsum'
      '          FROM RN.vitreaty tr,'
      '               RN.mnagreem agr,'
      '               RN.mnstage st'
      '         WHERE agr.treaty_id = tr.treaty_id'
      '           AND st.agreem_id = agr.id'
      '           AND tr.istfin_kod = 1 --'#1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072
      
        '           AND tr.treaty_status NOT IN ('#39'A'#39', '#39'P'#39') --'#1053#1077' '#1072#1085#1091#1083#1083#1080#1088#1086#1074 +
        #1072#1085', '#1085#1077' '#1090#1077#1084#1087#1083#1072#1085
      
        '           AND tr.datefrom < TO_DATE('#39'01.01.'#39' || (:yr + 1), '#39'dd.' +
        'mm.yyyy'#39') --'#1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1076#1086#1075#1086#1074#1086#1088#1072
      
        '           AND (st.dateact IS NOT NULL AND agr.num < tr.agreem_n' +
        'um -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '                OR agr.num = tr.agreem_num)'
      '           AND ((tr.treaty_status =  '#39'O'#39')'
      
        '                OR (tr.treaty_status <> '#39'O'#39' AND  tr.dateto >= TO' +
        '_DATE('#39'01.01.'#39' || :yr, '#39'dd.mm.yyyy'#39')))'
      
        '           AND st.datefrom < TO_DATE('#39'01.01.'#39' || (:yr + 1), '#39'dd.' +
        'mm.yyyy'#39')'
      
        '           AND TRUNC(st.dateto,'#39'yyyy'#39') = TO_DATE('#39'01.01.'#39' || (:y' +
        'r), '#39'dd.mm.yyyy'#39')'
      '        )GROUP BY TREATY_ID'
      ')GROUP BY TREATY_ID) trs'
      'WHERE trs.treaty_id = tr.treaty_id       '
      ''
      'ORDER BY ID'
      ' ')
    Optimize = False
    Variables.Data = {0300000001000000030000003A59520300000004000000DF07000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000A000000020000004944010000000000030000004E554D0100000000
      00040000005355424A010000000000080000004441544546524F4D0100000000
      000600000044415445544F0100000000000E0000005452454154595F53554D4D
      5041590100000000000300000053424601000000000004000000534355520100
      0000000006000000535441545553010000000000080000004B5552535F535452
      010000000000}
    Session = seOracle
    Left = 512
    Top = 304
    object fltfldRN08ID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object odsRN08NUM: TStringField
      FieldName = 'NUM'
      Size = 142
    end
    object odsRN08SUBJ: TStringField
      FieldName = 'SUBJ'
      Required = True
      Size = 1000
    end
    object odsRN08DATEFROM: TStringField
      FieldName = 'DATEFROM'
      Size = 7
    end
    object odsRN08DATETO: TStringField
      FieldName = 'DATETO'
      Size = 7
    end
    object fltfldRN08TREATY_SUMMPAY: TFloatField
      FieldName = 'TREATY_SUMMPAY'
      Required = True
    end
    object fltfldRN08SBF: TFloatField
      FieldName = 'SBF'
    end
    object fltfldRN08SCUR: TFloatField
      FieldName = 'SCUR'
    end
    object odsRN08STATUS: TStringField
      FieldName = 'STATUS'
      Required = True
      Size = 1
    end
    object odsRN08KURS_STR: TStringField
      FieldName = 'KURS_STR'
      Size = 1
    end
  end
  object frdsRN08: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = True
    DataSet = odsRN08
    BCDToCurrency = False
    Left = 512
    Top = 352
  end
  object frRN08: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42450.672068368010000000
    ReportOptions.LastChange = 42450.672068368010000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 512
    Top = 400
    Datasets = <
      item
        DataSet = frdsRN08
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' Category'
        Value = Null
      end
      item
        Name = 'GLING'
        Value = ''
      end
      item
        Name = 'REP_YEAR'
        Value = ''
      end
      item
        Name = 'NACHOTD'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 464.882190000000000000
        Width = 1046.929810000000000000
        DataSet = frdsRN08
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo36: TfrxMemoView
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."ID"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 275.905690000000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."KURS_STR"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 566.929500000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."DATETO"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo40: TfrxMemoView
          Left = 661.417750000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo41: TfrxMemoView
          Left = 793.701300000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo42: TfrxMemoView
          Left = 929.764380000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 170.078850000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Left = 757.685530000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1032#1056#1118#1056#8217#1056#8226#1056#160#1056#8211#1056#8221#1056#1106#1056#174':')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 755.906000000000000000
          Top = 18.897650000000000000
          Width = 291.023810000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            
              #1056#8220#1056#187#1056#176#1056#1030#1056#1029#1057#8249#1056#8470' '#1056#1105#1056#1029#1056#182#1056#181#1056#1029#1056#181#1057#1026' '#1056#1115#1056#1106#1056#1115' "'#1056#8216#1056#181#1056#187#1056#176#1057#1026#1057#1107#1057#1027#1057#1034#1056#1108#1056#176#1056#187#1056#1105#1056#8470 +
              '"')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 755.906000000000000000
          Top = 41.574830000000000000
          Width = 291.023810000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '_______________[GLING]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo4: TfrxMemoView
          Left = 755.906000000000000000
          Top = 68.031540000000010000
          Width = 291.023810000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '"_____"__________________20        '#1056#1110'.')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo5: TfrxMemoView
          Top = 113.385900000000000000
          Width = 1046.929810000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#8220#1056#1115#1056#8221#1056#1115#1056#8217#1056#1115#1056#8482' '#1056#1115#1056#1118#1056#167#1056#1027#1056#1118' '#1056#1115' '#1056#8217#1056#171#1056#1119#1056#1115#1056#8250#1056#1116#1056#8226#1056#1116#1056#152#1056#152' '#1056#160#1056#1106#1056#8216#1056#1115#1056#1118' '#1056#8212#1056 +
              #1106' [REP_YEAR] '#1056#8220#1056#1115#1056#8221
            
              #1056#164#1056#152#1056#1116#1056#1106#1056#1116#1056#1038#1056#152#1056#160#1056#1032#1056#8226#1056#1114#1056#171#1056#1168' '#1056#152#1056#8212' '#1056#1038#1056#1115#1056#8216#1056#1038#1056#1118#1056#8217#1056#8226#1056#1116#1056#1116#1056#171#1056#1168' '#1056#1038#1056#160#1056#8226#1056#8221#1056 +
              #1038#1056#1118#1056#8217' '#1056#1119#1056#160#1056#8226#1056#8221#1056#1119#1056#160#1056#152#1056#1031#1056#1118#1056#152#1056#1031)
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#164#1056#1115#1056#160#1056#1114#1056#1106' RN-08')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Top = 154.960730000000000000
          Width = 151.181200000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 211.653680000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo14: TfrxMemoView
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 275.905690000000000000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 566.929500000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 661.417750000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 793.701300000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 929.764380000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 287.244280000000000000
        Width = 1046.929810000000000000
        object Memo6: TfrxMemoView
          Width = 52.913420000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211
            #1056#1111'/'#1056#1111','
            #1057#8364#1056#1105#1057#8222#1057#1026)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211#1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176','
            #1056#152#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 275.905690000000000000
          Width = 291.023810000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1057#8218#1056#181#1056#1112#1057#8249' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 566.929500000000000000
          Width = 94.488250000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1026#1056#1109#1056#1108#1056#1105' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1105#1057#1039
            '('#1056#1029#1056#176#1057#8225#1056#176#1056#187#1056#1109'- '#1056#1109#1056#1108#1056#1109#1056#1029#1057#8225#1056#176#1056#1029#1056#1105#1056#181')')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 661.417750000000000000
          Width = 385.512060000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 661.417750000000000000
          Top = 18.897650000000000000
          Width = 132.283550000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109' '#1056#1111#1056#1109' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1057#1107)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 793.701300000000000000
          Top = 18.897650000000000000
          Width = 136.063080000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1109' '#1056#1030' '#1056#1111#1057#1026#1056#181#1056#1169#1057#8249#1056#1169#1057#1107#1057#8240#1056#1105#1056#181' '#1056#1110#1056#1109#1056#1169#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 929.764380000000000000
          Top = 18.897650000000000000
          Width = 117.165430000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1109' '#1056#1030' [REP_YEAR] '#1056#1110'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Top = 64.252009999999990000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 52.913420000000000000
          Top = 64.252009999999990000
          Width = 222.992270000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 275.905690000000000000
          Top = 64.252009999999990000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 566.929500000000000000
          Top = 64.252009999999990000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 661.417750000000000000
          Top = 64.252009999999990000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 793.701300000000000000
          Top = 64.252009999999990000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 929.764380000000000000
          Top = 64.252009999999990000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 506.457020000000000000
        Width = 1046.929810000000000000
        object Memo43: TfrxMemoView
          Left = 275.905690000000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#152#1056#1118#1056#1115#1056#8220#1056#1115':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 661.417750000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."TREATY_SUMMPAY">)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 793.701300000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."SBF">)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 929.764380000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."SCUR">)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 642.520100000000000000
        Width = 1046.929810000000000000
        object Memo28: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#8250#1056#1105#1057#1027#1057#8218' [Page#]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 389.291590000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBDataset1."ID"'
        Stretched = True
        object Memo29: TfrxMemoView
          Width = 52.913420000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[Line#]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8 = (
            '[frxDBDataset1."NUM"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 275.905690000000000000
          Width = 291.023810000000000000
          Height = 52.913420000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8 = (
            '[frxDBDataset1."SUBJ"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 566.929500000000000000
          Width = 94.488250000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."DATEFROM"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo33: TfrxMemoView
          Left = 661.417750000000000000
          Width = 132.283550000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."TREATY_SUMMPAY"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 793.701300000000000000
          Width = 136.063080000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8 = (
            '[frxDBDataset1."SBF"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 929.764380000000000000
          Width = 117.165430000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8 = (
            '[frxDBDataset1."SCUR"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 589.606680000000000000
        Width = 1046.929810000000000000
        object Memo47: TfrxMemoView
          Left = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#1106#1056#167#1056#1106#1056#8250#1056#172#1056#1116#1056#152#1056#1113' '#1056#1115#1056#1118#1056#8221#1056#8226#1056#8250#1056#1106)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 566.929499999999900000
          Width = 226.771800000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[NACHOTD]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object odsRN010: TOracleDataSet
    SQL.Strings = (
      'SELECT vitreaty.treaty_id ID,'
      '       vitreaty.treaty_num treaty_num,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name name,'
      '       vitreaty.subject subject,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       vitreaty.currency_no currency_no,'
      '       st.num st_num,'
      '       NVL(st.dateact, st.dateto) st_dateto,'
      '       --exchange_rates.e_rate,'
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         vitreaty.datefrom)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      
        '       RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.currency_n' +
        'o,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         ) into_date,'
      
        '       decode(vitreaty.istfin_kod, 2, vitreaty.theme_plan_num, v' +
        'itreaty.treaty_id) num'
      '  FROM RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       RN.vitreaty,'
      '       S.currency'
      
        ' WHERE (    ( (st.dateact between   :DATEFROM and :DATETO) and (' +
        'st.dateact <> :DATETO))'
      
        '         OR (  st.dateact IS NULL AND  (st.dateto between :DATEF' +
        'ROM and :DATETO) and (st.dateto <> :DATETO))'
      '       )'
      '   AND vitreaty.istfin_kod = 1 -- '#1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072
      '   AND vitreaty.TREATY_STATUS NOT IN ('#39'A'#39', '#39'P'#39')'
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      '   AND currency.currency_no = vitreaty.currency_no'
      ' ORDER BY vitreaty.treaty_id, st.num'
      ' ')
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A4441544546524F4D0C00000007000000787402
      0101010100000000070000003A44415445544F0C000000070000007874030101
      010100000000}
    QBEDefinition.QBEFieldDefs = {
      040000000B0000000200000049440100000000000A0000005452454154595F4E
      554D010000000000040000004E414D45010000000000070000005355424A4543
      540100000000000D00000053544147455F53554D4D5041590100000000000B00
      000043555252454E43595F4E4F0100000000000600000053545F4E554D010000
      0000000900000053545F44415445544F01000000000006000000455F52415445
      01000000000009000000494E544F5F44415445010000000000030000004E554D
      010000000000}
    Session = seOracle
    Left = 576
    Top = 304
    object fltfldRN010ID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object odsRN010TREATY_NUM: TStringField
      FieldName = 'TREATY_NUM'
      Required = True
    end
    object odsRN010NAME: TStringField
      FieldName = 'NAME'
      Size = 142
    end
    object odsRN010SUBJECT: TStringField
      FieldName = 'SUBJECT'
      Required = True
      Size = 1000
    end
    object fltfldRN010STAGE_SUMMPAY: TFloatField
      FieldName = 'STAGE_SUMMPAY'
    end
    object intfldRN010CURRENCY_NO: TIntegerField
      FieldName = 'CURRENCY_NO'
    end
    object odsRN010ST_NUM: TStringField
      FieldName = 'ST_NUM'
      Size = 13
    end
    object dtfldRN010ST_DATETO: TDateTimeField
      FieldName = 'ST_DATETO'
    end
    object fltfldRN010E_RATE: TFloatField
      FieldName = 'E_RATE'
    end
    object dtfldRN010INTO_DATE: TDateTimeField
      FieldName = 'INTO_DATE'
    end
    object fltfldRN010NUM: TFloatField
      FieldName = 'NUM'
    end
  end
  object frdsRN010: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'TREATY_NUM=TREATY_NUM'
      'NAME=NAME'
      'SUBJECT=SUBJECT'
      'STAGE_SUMMPAY=STAGE_SUMMPAY'
      'CURRENCY_NO=CURRENCY_NO'
      'ST_NUM=ST_NUM'
      'ST_DATETO=ST_DATETO'
      'E_RATE=E_RATE'
      'INTO_DATE=INTO_DATE'
      'NUM=NUM')
    DataSet = odsRN010
    BCDToCurrency = False
    Left = 576
    Top = 352
  end
  object frRN010: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42450.672889942100000000
    ReportOptions.LastChange = 42450.672889942100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 576
    Top = 400
    Datasets = <
      item
        DataSet = frdsRN010
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' Category'
        Value = Null
      end
      item
        Name = 'REP_DATE'
        Value = ''
      end
      item
        Name = 'NACHOTD'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#164#1056#1115#1056#160#1056#1114#1056#1106' RN-10')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Top = 18.897650000000000000
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#8220#1056#160#1056#1106#1056#164#1056#152#1056#1113' '#1056#164#1056#152#1056#1116#1056#1106#1056#1116#1056#1038#1056#152#1056#160#1056#1115#1056#8217#1056#1106#1056#1116#1056#152#1056#1031' '#1056#8221#1056#1115#1056#8220#1056#1115#1056#8217#1056#1115#1056#160#1056#1115#1056#8217', '#1056#1115 +
              #1056#1119#1056#8250#1056#1106#1056#167#1056#152#1056#8217#1056#1106#1056#8226#1056#1114#1056#171#1056#1168' '#1056#152#1056#8212' '#1056#1038#1056#1115#1056#8216#1056#1038#1056#1118#1056#8217#1056#8226#1056#1116#1056#1116#1056#171#1056#1168' '#1056#1038#1056#160#1056#8226#1056#8221#1056#1038#1056#1118#1056 +
              #8217' '#1056#8212#1056#1106' [REP_DATE] '#1056#1110'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Top = 56.692949999999990000
          Width = 158.740260000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 442.205010000000000000
        Width = 1046.929810000000000000
        object Memo30: TfrxMemoView
          Left = 37.795300000000000000
          Width = 264.567100000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1057#8225#1056#176#1056#187#1057#1034#1056#1029#1056#1105#1056#1108' '#1056#1109#1057#8218#1056#1169#1056#181#1056#187#1056#176':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 733.228820000000000000
          Width = 204.094620000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1106'. '#1056#1106'. '#1056#1114#1056#176#1057#1026#1056#1105#1056#1029#1056#1105#1057#8225)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 34.015770000000010000
        Top = 287.244280000000000000
        Width = 1046.929810000000000000
        DataSet = frdsRN010
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        Stretched = True
        object Memo24: TfrxMemoView
          Left = 41.574830000000000000
          Width = 260.787570000000000000
          Height = 34.015770000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."NAME"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo25: TfrxMemoView
          Left = 302.362400000000000000
          Width = 430.866420000000000000
          Height = 34.015770000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."SUBJECT"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo26: TfrxMemoView
          Left = 733.228820000000000000
          Width = 94.488250000000000000
          Height = 34.015770000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."ST_NUM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 827.717070000000000000
          Width = 109.606370000000000000
          Height = 34.015770000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 937.323440000000000000
          Width = 109.606370000000000000
          Height = 34.015770000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Width = 41.574830000000000000
          Height = 34.015770000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[Line]'
            '[frxDBDataset1."ID"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        object Memo4: TfrxMemoView
          Width = 41.574830000000000000
          Height = 52.913420000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111'.'#1056#1111'.,'
            #1057#8364#1056#1105#1057#8222#1057#1026)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 41.574830000000000000
          Width = 260.787570000000000000
          Height = 52.913420000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176', '#1056#1105#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 302.362400000000000000
          Width = 430.866420000000000000
          Height = 52.913420000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 733.228820000000000000
          Width = 94.488250000000000000
          Height = 52.913420000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#173#1057#8218#1056#176#1056#1111#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 827.717070000000000000
          Width = 109.606370000000000000
          Height = 52.913420000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 937.323440000000000000
          Width = 109.606370000000000000
          Height = 52.913420000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#164#1056#1105#1056#1029#1056#176#1056#1029#1057#1027#1056#1105#1057#1026#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181
            #1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Top = 52.913420000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 41.574830000000000000
          Top = 52.913420000000000000
          Width = 260.787570000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 302.362400000000000000
          Top = 52.913420000000000000
          Width = 430.866420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 733.228820000000000000
          Top = 52.913420000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 827.717070000000000000
          Top = 52.913420000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 937.323440000000000000
          Top = 52.913420000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 120.944960000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo16: TfrxMemoView
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 41.574830000000000000
          Width = 260.787570000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 302.362400000000000000
          Width = 430.866420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 733.228820000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 827.717070000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 937.323440000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 343.937230000000000000
        Width = 1046.929810000000000000
        object Memo22: TfrxMemoView
          Left = 302.362400000000000000
          Width = 430.866420000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            #1056#152#1056#1118#1056#1115#1056#8220#1056#1115':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 831.496600000000000000
          Width = 105.826840000000000000
          Height = 37.795300000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."STAGE_SUMMPAY">)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 498.897960000000000000
        Width = 1046.929810000000000000
        object Memo31: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#8250#1056#1105#1057#1027#1057#8218' [Page#]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
    end
  end
  object odsRN012: TOracleDataSet
    SQL.Strings = (
      'SELECT vitreaty.treaty_id ID,'
      '       vitreaty.treaty_num treaty_num,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name name,'
      '       vitreaty.subject subject,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       vitreaty.currency_no currency_no,'
      '       st.num st_num,'
      '       NVL(st.dateact, st.dateto) st_dateto,'
      '       --exchange_rates.e_rate,'
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         vitreaty.datefrom)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      
        '       RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.currency_n' +
        'o,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         ) into_date,'
      
        '       decode(vitreaty.istfin_kod, 2, vitreaty.theme_plan_num, v' +
        'itreaty.treaty_id) num'
      '  FROM RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       RN.vitreaty,'
      '       S.currency'
      
        ' WHERE (    ( (st.dateact between   :DATEFROM and :DATETO) and (' +
        'st.dateact <> :DATETO))'
      
        '         OR (  st.dateact IS NULL AND  (st.dateto between :DATEF' +
        'ROM and :DATETO) and (st.dateto <> :DATETO))'
      '       )'
      '   AND vitreaty.istfin_kod = 1 -- '#1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072
      '   AND vitreaty.TREATY_STATUS NOT IN ('#39'A'#39', '#39'P'#39')'
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      '   AND currency.currency_no = vitreaty.currency_no'
      ' ORDER BY vitreaty.treaty_id, st.num'
      ' ')
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A4441544546524F4D0C00000007000000787401
      0101010100000000070000003A44415445544F0C0000000700000078740C1F01
      010100000000}
    QBEDefinition.QBEFieldDefs = {
      040000000B0000000200000049440100000000000A0000005452454154595F4E
      554D010000000000040000004E414D45010000000000070000005355424A4543
      540100000000000D00000053544147455F53554D4D5041590100000000000B00
      000043555252454E43595F4E4F0100000000000600000053545F4E554D010000
      0000000900000053545F44415445544F01000000000006000000455F52415445
      01000000000009000000494E544F5F44415445010000000000030000004E554D
      010000000000}
    Session = seOracle
    Left = 640
    Top = 304
    object fltfldRN012ID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object odsRN012TREATY_NUM: TStringField
      FieldName = 'TREATY_NUM'
      Required = True
    end
    object odsRN012NAME: TStringField
      FieldName = 'NAME'
      Size = 142
    end
    object odsRN012SUBJECT: TStringField
      FieldName = 'SUBJECT'
      Required = True
      Size = 1000
    end
    object fltfldRN012STAGE_SUMMPAY: TFloatField
      FieldName = 'STAGE_SUMMPAY'
    end
    object intfldRN012CURRENCY_NO: TIntegerField
      FieldName = 'CURRENCY_NO'
    end
    object odsRN012ST_NUM: TStringField
      FieldName = 'ST_NUM'
      Size = 13
    end
    object dtfldRN012ST_DATETO: TDateTimeField
      FieldName = 'ST_DATETO'
    end
    object fltfldRN012E_RATE: TFloatField
      FieldName = 'E_RATE'
    end
    object dtfldRN012INTO_DATE: TDateTimeField
      FieldName = 'INTO_DATE'
    end
    object fltfldRN012NUM: TFloatField
      FieldName = 'NUM'
    end
  end
  object frdsRN012: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'TREATY_NUM=TREATY_NUM'
      'NAME=NAME'
      'SUBJECT=SUBJECT'
      'STAGE_SUMMPAY=STAGE_SUMMPAY'
      'CURRENCY_NO=CURRENCY_NO'
      'ST_NUM=ST_NUM'
      'ST_DATETO=ST_DATETO'
      'E_RATE=E_RATE'
      'INTO_DATE=INTO_DATE'
      'NUM=NUM')
    DataSet = odsRN012
    BCDToCurrency = False
    Left = 640
    Top = 352
  end
  object frRN012: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42450.673563414400000000
    ReportOptions.LastChange = 42450.673563414400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 640
    Top = 400
    Datasets = <
      item
        DataSet = frdsRN012
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' Category'
        Value = Null
      end
      item
        Name = 'rep_year'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 75.590600000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo2: TfrxMemoView
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#164#1056#1115#1056#160#1056#1114#1056#1106' RN-012')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Top = 18.897650000000000000
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#8220#1056#160#1056#1106#1056#164#1056#152#1056#1113' '#1056#164#1056#152#1056#1116#1056#1106#1056#1116#1056#1038#1056#152#1056#160#1056#1115#1056#8217#1056#1106#1056#1116#1056#152#1056#1031' '#1056#8221#1056#1115#1056#8220#1056#1115#1056#8217#1056#1115#1056#160#1056#1115#1056#8217' '#1056#1115#1056 +
              #1119#1056#8250#1056#1106#1056#167#1056#152#1056#8217#1056#1106#1056#8226#1056#1114#1056#171#1056#1168' '#1056#152#1056#8212' '#1056#1038#1056#1115#1056#8216#1056#1038#1056#1118#1056#8217#1056#8226#1056#1116#1056#1116#1056#171#1056#1168' '#1056#1038#1056#160#1056#8226#1056#8221#1056#1038#1056#1118#1056#8217 +
              ' '#1056#8212#1056#1106' [REP_YEAR] '#1056#1110'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Top = 56.692949999999990000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 400.630180000000000000
        Width = 1046.929810000000000000
        object Memo83: TfrxMemoView
          Width = 151.181200000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#1106#1056#167#1056#1106#1056#8250#1056#172#1056#1116#1056#152#1056#1113' '#1056#1115#1056#1118#1056#8221#1056#8226#1056#8250#1056#1106)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo84: TfrxMemoView
          Left = 291.023810000000000000
          Width = 136.063080000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1106'. '#1056#1106'. '#1056#1114#1056#176#1057#1026#1056#1105#1056#1029#1056#1105#1057#8225)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 117.165430000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo37: TfrxMemoView
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 41.574830000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 90.708720000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 151.181200000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 219.212740000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 291.023810000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 359.055350000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 427.086890000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 495.118430000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '9')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 563.149970000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '10')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 631.181510000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '11')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 699.213050000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '12')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 767.244590000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '13')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 835.276130000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '14')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Left = 903.307670000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '15')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Left = 971.339210000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '16')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 457.323130000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#8250#1056#1105#1057#1027#1057#8218' [Page#]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 279.685220000000000000
        Width = 1046.929810000000000000
        DataSet = frdsRN012
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        Stretched = True
        object Memo53: TfrxMemoView
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[Line#]'
            '[frxDBDataset1."ID"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 41.574830000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."TREATY_NUM"]')
          ParentFont = False
          SuppressRepeated = True
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 90.708720000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."ST_NUM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 151.181200000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 219.212740000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 291.023810000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Left = 359.055350000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Left = 427.086890000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          Left = 495.118430000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo62: TfrxMemoView
          Left = 563.149970000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Left = 631.181510000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo64: TfrxMemoView
          Left = 699.213050000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 767.244590000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo66: TfrxMemoView
          Left = 835.276130000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo67: TfrxMemoView
          Left = 903.307670000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo68: TfrxMemoView
          Left = 971.339210000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 64.252010000000000000
        Top = 192.756030000000000000
        Width = 1046.929810000000000000
        object Memo5: TfrxMemoView
          Width = 41.574830000000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111'.'#1056#1111'., '#1057#8364#1056#1105#1057#8222#1057#1026)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 41.574830000000000000
          Width = 49.133890000000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 90.708720000000000000
          Width = 60.472480000000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#173#1057#8218#1056#176#1056#1111#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 151.181200000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1031#1056#1029#1056#1030#1056#176#1057#1026#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 219.212740000000000000
          Width = 71.811026060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#164#1056#181#1056#1030#1057#1026#1056#176#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 291.023810000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1114#1056#176#1057#1026#1057#8218)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 359.055350000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1106#1056#1111#1057#1026#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 427.086890000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1114#1056#176#1056#8470)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 495.118430000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#152#1057#1035#1056#1029#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 563.149970000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#152#1057#1035#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 631.181510000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1106#1056#1030#1056#1110#1057#1107#1057#1027#1057#8218)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 699.213050000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1056#181#1056#1029#1057#8218#1057#1039#1056#177#1057#1026#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 767.244590000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1115#1056#1108#1057#8218#1057#1039#1056#177#1057#1026#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 835.276130000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#1109#1057#1039#1056#177#1057#1026#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 903.307670000000000000
          Width = 68.031496060000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8221#1056#181#1056#1108#1056#176#1056#177#1057#1026#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 971.339210000000000000
          Width = 75.590551180000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#152#1056#1118#1056#1115#1056#8220#1056#1115)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Top = 49.133890000000100000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 41.574830000000000000
          Top = 49.133890000000100000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 90.708720000000000000
          Top = 49.133890000000100000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 151.181200000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 219.212740000000000000
          Top = 49.133890000000100000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 291.023810000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 359.055350000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 427.086890000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '8')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 495.118430000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '9')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 563.149970000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '10')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 631.181510000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '11')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 699.213050000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '12')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 767.244590000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '13')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 835.276130000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '14')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 903.307670000000000000
          Top = 49.133890000000100000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '15')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 971.339210000000000000
          Top = 49.133890000000100000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '16')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 321.260050000000000000
        Width = 1046.929810000000000000
        object Memo69: TfrxMemoView
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            #1056#152#1056#1118#1056#1115#1056#8220#1056#1115':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Left = 151.181200000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo71: TfrxMemoView
          Left = 219.212740000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Left = 291.023810000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo73: TfrxMemoView
          Left = 359.055350000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo74: TfrxMemoView
          Left = 427.086890000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo75: TfrxMemoView
          Left = 495.118430000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo76: TfrxMemoView
          Left = 563.149970000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo77: TfrxMemoView
          Left = 631.181510000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo78: TfrxMemoView
          Left = 699.213050000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo79: TfrxMemoView
          Left = 767.244590000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo80: TfrxMemoView
          Left = 835.276130000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo81: TfrxMemoView
          Left = 903.307670000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo82: TfrxMemoView
          Left = 971.339210000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object odsRN013: TOracleDataSet
    SQL.Strings = (
      'SELECT tr.treaty_id ID,'
      '       tr.treaty_num treaty_num,'
      '       tr.treaty_num || '#39', '#39'|| tr.exec_name name,'
      '       tr.subject subject,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       tr.currency_no currency_no,'
      '       st.num st_num,'
      '       TO_CHAR(st.dateto, '#39'mm.yyyy'#39') st_dateto,'
      '       --exchange_rates.e_rate,'
      '       DECODE(tr.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(NVL(st.datepay, SYSDATE), tr.currency_no)'
      '                  AND er.CURRENCY_NO = tr.currency_no'
      '              )'
      '             ) e_rate,'
      '       --exchange_rates.intro_date,'
      
        '       RN.MONEY_PKG.GetLEqMaxDateOfExchange(NVL(st.datepay, SYSD' +
        'ATE), tr.currency_no) into_date,'
      
        '       decode(tr.istfin_kod, 2, tr.theme_plan_num, tr.treaty_id)' +
        ' num,'
      '       tr.istfin_kod istfin_kod,'
      
        '       decode(tr.istfin_kod, 2, RN.MITRCONCERN_PKG.getconcdogfor' +
        'innavdog(TRUNC(ADD_MONTHS(SYSDATE, -1), '#39'MONTH'#39'), tr.datefrom, t' +
        'r.dateto), NULL) ConcDogID,'
      
        '       COUNT(tr.treaty_id) OVER (PARTITION BY tr.treaty_id) coun' +
        't_per_treaty,'
      
        '       COUNT(DISTINCT tr.treaty_id) OVER (PARTITION BY 1) rec_co' +
        'unt'
      '  FROM RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       RN.vitreaty tr,'
      '       S.currency'
      ' WHERE st.dateto <= TRUNC(SYSDATE, '#39'MONTH'#39')'
      '   AND st.dateact IS NULL'
      '   AND st.agreem_id = agr.id'
      '   AND agr.treaty_id = tr.treaty_id'
      '   AND agr.num = tr.agreem_num'
      '   AND tr.treaty_STATUS = '#39'O'#39
      '   AND currency.currency_no = tr.currency_no'
      ' ORDER BY tr.istfin_kod desc,'
      '          decode(tr.istfin_kod,'
      '                 2,'
      
        '                 RN.MITRCONCERN_PKG.getconcdogforinnavdog(TRUNC(' +
        'ADD_MONTHS(SYSDATE, -1), '#39'MONTH'#39'),'
      
        '                                                       tr.datefr' +
        'om,'
      
        '                                                       tr.dateto' +
        '),'
      '                 NULL),'
      '          (SELECT MIN(sub_st.DATETO)'
      '             FROM RN.mnstage SUB_st,'
      '                  RN.mnagreem sub_agr'
      '            where sub_agr.treaty_id = tr.treaty_id'
      '              AND sub_agr.num = tr.agreem_num'
      '              AND sub_st.agreem_id = sub_agr.id'
      '              AND SUB_st.dateact IS NULL),'
      '          decode(tr.istfin_kod,'
      '                 2,'
      '                 tr.theme_plan_num,'
      '                 tr.treaty_id),'
      '          tr.treaty_id,'
      '          st.DATETO,'
      '          st.num')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      040000000F0000000200000049440100000000000A0000005452454154595F4E
      554D010000000000040000004E414D45010000000000070000005355424A4543
      540100000000000D00000053544147455F53554D4D5041590100000000000B00
      000043555252454E43595F4E4F0100000000000600000053545F4E554D010000
      0000000900000053545F44415445544F01000000000006000000455F52415445
      01000000000009000000494E544F5F44415445010000000000030000004E554D
      0100000000000A00000049535446494E5F4B4F4401000000000009000000434F
      4E43444F47494401000000000010000000434F554E545F5045525F5452454154
      59010000000000090000005245435F434F554E54010000000000}
    Session = seOracle
    Left = 696
    Top = 304
    object fltfldRN013ID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object odsRN013TREATY_NUM: TStringField
      FieldName = 'TREATY_NUM'
      Required = True
    end
    object odsRN013NAME: TStringField
      FieldName = 'NAME'
      Size = 142
    end
    object odsRN013SUBJECT: TStringField
      FieldName = 'SUBJECT'
      Required = True
      Size = 1000
    end
    object fltfldRN013STAGE_SUMMPAY: TFloatField
      FieldName = 'STAGE_SUMMPAY'
    end
    object intfldRN013CURRENCY_NO: TIntegerField
      FieldName = 'CURRENCY_NO'
    end
    object odsRN013ST_NUM: TStringField
      FieldName = 'ST_NUM'
      Size = 13
    end
    object odsRN013ST_DATETO: TStringField
      FieldName = 'ST_DATETO'
      Size = 7
    end
    object fltfldRN013E_RATE: TFloatField
      FieldName = 'E_RATE'
    end
    object dtfldRN013INTO_DATE: TDateTimeField
      FieldName = 'INTO_DATE'
    end
    object fltfldRN013NUM: TFloatField
      FieldName = 'NUM'
    end
    object intfldRN013ISTFIN_KOD: TIntegerField
      FieldName = 'ISTFIN_KOD'
      Required = True
    end
    object fltfldRN013CONCDOGID: TFloatField
      FieldName = 'CONCDOGID'
    end
    object fltfldRN013COUNT_PER_TREATY: TFloatField
      FieldName = 'COUNT_PER_TREATY'
    end
    object fltfldRN013REC_COUNT: TFloatField
      FieldName = 'REC_COUNT'
    end
  end
  object frdsRN013: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'TREATY_NUM=TREATY_NUM'
      'NAME=NAME'
      'SUBJECT=SUBJECT'
      'STAGE_SUMMPAY=STAGE_SUMMPAY'
      'CURRENCY_NO=CURRENCY_NO'
      'ST_NUM=ST_NUM'
      'ST_DATETO=ST_DATETO'
      'E_RATE=E_RATE'
      'INTO_DATE=INTO_DATE'
      'NUM=NUM'
      'ISTFIN_KOD=ISTFIN_KOD'
      'CONCDOGID=CONCDOGID'
      'COUNT_PER_TREATY=COUNT_PER_TREATY'
      'REC_COUNT=REC_COUNT')
    DataSet = odsRN013
    BCDToCurrency = False
    Left = 696
    Top = 352
  end
  object frRN013: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42450.675674976800000000
    ReportOptions.LastChange = 42450.675674976800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 696
    Top = 400
    Datasets = <
      item
        DataSet = frdsRN013
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 56.692950000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#164#1056#1115#1056#160#1056#1114#1056#1106' RN-13')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Top = 18.897650000000000000
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#1119#1056#8226#1056#160#1056#8226#1056#167#1056#8226#1056#1116#1056#172' '#1056#1116#1056#8226#1056#8217#1056#171#1056#1119#1056#1115#1056#8250#1056#1116#1056#8226#1056#1116#1056#1116#1056#171#1056#1168' '#1056#173#1056#1118#1056#1106#1056#1119#1056#1115#1056#8217' '#1056#8221#1056#1115#1056#8220#1056 +
              #1115#1056#8217#1056#1115#1056#160#1056#1115#1056#8217' '#1056#8217' '#1056#1038#1056#160#1056#1115#1056#1113)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Top = 37.795300000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 411.968770000000000000
        Width = 1046.929810000000000000
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 98.267780000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo18: TfrxMemoView
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 45.354360000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 283.464750000000000000
          Width = 423.307360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 706.772110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 782.362710000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 857.953310000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 457.323130000000000000
        Width = 1046.929810000000000000
        object Memo34: TfrxMemoView
          Left = 944.882500000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#8250#1056#1105#1057#1027#1057#8218' [Page#]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 64.252010000000000000
        Top = 177.637910000000000000
        Width = 1046.929810000000000000
        object Memo4: TfrxMemoView
          Width = 45.354360000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111'.'#1056#1111'.'
            #1057#8364#1056#1105#1057#8222#1057#1026)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 45.354360000000000000
          Width = 238.110390000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176', '#1056#1105#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 283.464750000000000000
          Width = 423.307360000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 706.772110000000000000
          Width = 75.590600000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#173#1057#8218#1056#176#1056#1111#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 782.362710000000000000
          Width = 75.590600000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1026#1056#1109#1056#1108' '#1057#1027#1056#1169#1056#176#1057#8225#1056#1105)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 857.953310000000000000
          Width = 94.488250000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Top = 45.354360000000010000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 45.354360000000000000
          Top = 45.354360000000010000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 283.464750000000000000
          Top = 45.354360000000010000
          Width = 423.307360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 706.772110000000000000
          Top = 45.354360000000010000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 782.362710000000000000
          Top = 45.354360000000010000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 857.953310000000000000
          Top = 45.354360000000010000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 952.441560000000000000
          Top = 45.354360000000010000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 325.039580000000000000
        Width = 1046.929810000000000000
        object Memo32: TfrxMemoView
          Left = 612.283860000000000000
          Width = 94.488250000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#152#1056#1118#1056#1115#1056#8220#1056#1115':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 857.953310000000000000
          Width = 94.488250000000000000
          Height = 26.456710000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."STAGE_SUMMPAY">)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 264.567100000000000000
        Width = 1046.929810000000000000
        DataSet = frdsRN013
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        Stretched = True
        object Memo25: TfrxMemoView
          Width = 45.354360000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[Line#]'
            '[frxDBDataset1."ID"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 45.354360000000000000
          Width = 238.110390000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."NAME"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 283.464750000000000000
          Width = 423.307360000000000000
          Height = 37.795300000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."SUBJECT"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 706.772110000000000000
          Width = 75.590600000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."ST_NUM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 782.362710000000000000
          Width = 75.590600000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."ST_DATETO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 857.953310000000000000
          Width = 94.488250000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object odsRN022: TOracleDataSet
    SQL.Strings = (
      'SELECT data.ID, data.name, DATA.exec_name,'
      '       TO_CHAR(MICH.kod) || '#39'. '#39' || MICH.pnaim CHAPTERNAME,'
      '       data.subject, data.datefrom,'
      '       data.dateto, data.summpay,'
      '       data.currency_no, '
      
        '       DECODE(data.treaty_status, '#39'F'#39', '#39#1047#1040#1050#1056#1067#1058#39','#39#39') treaty_statu' +
        's,'
      '       SUM(DATA.stsum_curr * e_rate) stsum_curr'
      '  FROM (SELECT vitreaty.treaty_id ID,'
      '               vitreaty.treaty_num  name,'
      '               vitreaty.subject,'
      '               TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') datefrom,'
      '               TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') dateto,'
      '               vitreaty.summpay,'
      '               vitreaty.currency_no,'
      '               vitreaty.treaty_status,'
      
        '               DECODE(GREATEST(st.dateto, TRUNC(:YEAR, '#39'YEAR'#39')),' +
        ' st.dateto,'
      
        '                                  st.summpay, 0) stsum_curr,    ' +
        '           '
      '               NVL(st.summpay,0) stage_summpay,'
      '               DECODE(vitreaty.currency_no, 933, 1,'
      '                    (SELECT ER.E_RATE FROM S.EXCHANGE_RATES er'
      
        '                      WHERE er.intro_date = RN.MONEY_PKG.getdate' +
        'ofexchangeofstage(vitreaty.currency_no, st.dateact, agr.treaty_i' +
        'd, vitreaty.datefrom)'
      
        '                        AND er.CURRENCY_NO = vitreaty.currency_n' +
        'o)'
      '                    ) e_rate,'
      
        '/*               RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.' +
        'currency_no,'
      '                                                  st.dateact,'
      '                                                  agr.treaty_id,'
      
        '                                                  vitreaty.datef' +
        'rom'
      '                                                 ) into_date,*/'
      '               st.dateact,'
      '               st.datefrom stage_datefrom,'
      '               st.dateto stage_dateto,'
      '--               currency.iso_name currency_name,'
      '               vitreaty.exec_name exec_name,'
      '               vitreaty.CHAPTER_KOD  CHAPTER_KOD,'
      '               st.ID st_id'
      '          FROM RN.vitreaty,'
      '               RN.mnagreem agr,'
      '               RN.mnstage st,'
      '               S.currency'
      '         WHERE vitreaty.istfin_kod = :ISTFIN_KOD'
      '           AND vitreaty.treaty_status NOT IN ('#39'A'#39', '#39'P'#39')'
      '           AND (   (vitreaty.treaty_status = '#39'O'#39')'
      
        '                OR (vitreaty.treaty_status <> '#39'O'#39' AND  TRUNC(vit' +
        'reaty.dateto, '#39'YEAR'#39') >= TRUNC(:YEAR, '#39'YEAR'#39')))'
      
        '           AND TRUNC(vitreaty.datefrom, '#39'YEAR'#39') <= TRUNC(:YEAR, ' +
        #39'YEAR'#39')'
      '           AND agr.treaty_id = vitreaty.treaty_id'
      '           AND currency.currency_no = vitreaty.currency_no'
      '           AND st.agreem_id = agr.id'
      
        '           AND (   st.dateact IS NOT NULL AND agr.num < vitreaty' +
        '.agreem_num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '                OR agr.num = vitreaty.agreem_num)'
      ''
      'UNION'
      '        SELECT vitreaty.treaty_id ID,'
      '               vitreaty.treaty_num  name,'
      '               vitreaty.subject,'
      '               TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') datefrom,'
      '               TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') dateto,'
      '               vitreaty.summpay,'
      '               vitreaty.currency_no,'
      '               vitreaty.treaty_status,'
      
        '               DECODE(GREATEST(st.dateto, TRUNC(:YEAR, '#39'YEAR'#39')),' +
        ' st.dateto,'
      '                                st.summpay, 0) stsum_curr,'
      '               NVL(st.summpay,0) stage_summpay,'
      '               DECODE(vitreaty.currency_no, 933, 1,'
      '                    (SELECT ER.E_RATE'
      '                       FROM S.EXCHANGE_RATES er'
      
        '                      WHERE er.intro_date = RN.MONEY_PKG.getdate' +
        'ofexchangeofstage(vitreaty.currency_no,'
      
        '                                                  st.dateact, ag' +
        'r.treaty_id, vitreaty.datefrom)'
      
        '                        AND er.CURRENCY_NO = vitreaty.currency_n' +
        'o)'
      '                    ) e_rate,'
      ''
      '               st.dateact,'
      '               st.datefrom stage_datefrom,'
      '               st.dateto stage_dateto,'
      '               vitreaty.exec_name exec_name,               '
      '               vitreaty.CHAPTER_KOD  CHAPTER_KOD,'
      '               st.ID  st_id'
      '          FROM (SELECT DISTINCT tr.*'
      '                  FROM RN.mnstage st,'
      '                       RN.mnagreem agr,'
      '                       RN.vitreaty tr'
      
        '                 WHERE st.dateact BETWEEN TRUNC(:YEAR, '#39'YEAR'#39') A' +
        'ND TO_DATE('#39'31.12.'#39' || TO_CHAR(:YEAR, '#39'yyyy'#39'), '#39'dd.mm.yyyy'#39')'
      '                   AND st.agreem_id = agr.id'
      '                   AND agr.treaty_id = tr.treaty_id'
      '                   AND tr.istfin_kod = :ISTFIN_KOD'
      '                 ) vitreaty,'
      '               RN.mnagreem agr,'
      '               RN.mnstage st,'
      '               S.currency'
      '         WHERE agr.treaty_id = vitreaty.treaty_id'
      '           AND currency.currency_no = vitreaty.currency_no'
      '           AND st.agreem_id = agr.id'
      
        '           AND (   st.dateact IS NOT NULL AND agr.num < vitreaty' +
        '.agreem_num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '                OR agr.num = vitreaty.agreem_num)'
      '       ) DATA,'
      '       RN.michapter mich'
      '   WHERE DATA.CHAPTER_KOD = mich.kod'
      
        ' GROUP BY data.ID, data.name, DATA.exec_name, TO_CHAR(MICH.kod) ' +
        '|| '#39'. '#39' || MICH.pnaim,'
      '       data.subject, data.datefrom, data.dateto, data.summpay,'
      
        '       data.currency_no, DECODE(data.treaty_status, '#39'F'#39', '#39#1047#1040#1050#1056#1067#1058 +
        #39','#39#39')    '
      ' ORDER BY CHAPTERNAME, id')
    Optimize = False
    Variables.Data = {
      0300000002000000050000003A594541520C0000000700000078740101010101
      000000000B0000003A49535446494E5F4B4F4403000000040000000100000000
      000000}
    QBEDefinition.QBEFieldDefs = {
      040000000B000000020000004944010000000000040000004E414D4501000000
      00000B000000434841505445524E414D45010000000000070000005355424A45
      4354010000000000080000004441544546524F4D010000000000060000004441
      5445544F0100000000000700000053554D4D5041590100000000000B00000043
      555252454E43595F4E4F0100000000000D0000005452454154595F5354415455
      530100000000000A000000535453554D5F435552520100000000000900000045
      5845435F4E414D45010000000000}
    Session = seOracle
    Left = 752
    Top = 456
    object fltfldRN022ID: TFloatField
      FieldName = 'ID'
    end
    object odsRN022NAME: TStringField
      FieldName = 'NAME'
    end
    object odsRN022EXEC_NAME: TStringField
      FieldName = 'EXEC_NAME'
      Size = 120
    end
    object odsRN022CHAPTERNAME: TStringField
      FieldName = 'CHAPTERNAME'
      Size = 192
    end
    object odsRN022SUBJECT: TStringField
      FieldName = 'SUBJECT'
      Size = 1000
    end
    object odsRN022DATEFROM: TStringField
      FieldName = 'DATEFROM'
      Size = 7
    end
    object odsRN022DATETO: TStringField
      FieldName = 'DATETO'
      Size = 7
    end
    object fltfldRN022SUMMPAY: TFloatField
      FieldName = 'SUMMPAY'
    end
    object intfldRN022CURRENCY_NO: TIntegerField
      FieldName = 'CURRENCY_NO'
    end
    object fltfldRN022STSUM_CURR: TFloatField
      FieldName = 'STSUM_CURR'
    end
    object odsRN022TREATY_STATUS: TStringField
      FieldName = 'TREATY_STATUS'
      Size = 6
    end
  end
  object frdsRN022: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'NAME=NAME'
      'EXEC_NAME=EXEC_NAME'
      'CHAPTERNAME=CHAPTERNAME'
      'SUBJECT=SUBJECT'
      'DATEFROM=DATEFROM'
      'DATETO=DATETO'
      'SUMMPAY=SUMMPAY'
      'CURRENCY_NO=CURRENCY_NO'
      'TREATY_STATUS=TREATY_STATUS'
      'STSUM_CURR=STSUM_CURR')
    DataSet = odsRN022
    BCDToCurrency = False
    Left = 752
    Top = 504
  end
  object frRN022: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Author = #1048#1074#1095#1080#1085' '#1040'. '#1057'.'
    ReportOptions.CreateDate = 42446.691907442100000000
    ReportOptions.Name = 'RN-04 '#1055#1077#1088#1077#1095#1077#1085#1100' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
    ReportOptions.LastChange = 42460.655878541700000000
    ReportOptions.VersionBuild = '45'
    ReportOptions.VersionMajor = '1'
    ReportOptions.VersionMinor = '0'
    ReportOptions.VersionRelease = '1'
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 752
    Top = 552
    Datasets = <
      item
        DataSet = frdsRN022
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' MyCat'
        Value = Null
      end
      item
        Name = 'REP_YEAR'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#164#1056#1115#1056#160#1056#1114#1056#1106' RN-22')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Top = 30.236240000000000000
          Width = 1046.929810000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#1119#1056#181#1057#1026#1056#181#1057#8225#1056#181#1056#1029#1057#1034' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218' '#1056#1111#1056#1109' '#1057#1026#1056#176#1056#183#1056#1169#1056#181#1056#187#1056#176#1056#1112' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026 +
              #1056#1109#1056#1030' '#1056#1109#1056#1111#1056#187#1056#176#1057#8225#1056#1105#1056#1030#1056#176#1056#181#1056#1112#1057#8249#1057#8230' '#1056#1105#1056#183' '#1057#1027#1056#1109#1056#177#1057#1027#1057#8218#1056#1030#1056#181#1056#1029#1056#1029#1057#8249#1057#8230' '#1057#1027#1057#1026#1056#181 +
              #1056#1169#1057#1027#1057#8218#1056#1030)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Top = 64.252010000000000000
          Width = 188.976500000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 120.944960000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo5: TfrxMemoView
          Width = 45.354360000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 45.354360000000000000
          Width = 219.212740000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 264.567100000000000000
          Width = 423.307360000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 687.874460000000000000
          Width = 94.488250000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 782.362710000000000000
          Width = 132.283550000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 914.646260000000000000
          Width = 132.283550000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 529.134199999999900000
        Width = 1046.929810000000000000
        object Memo6: TfrxMemoView
          Left = 963.780150000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#8250#1056#1105#1057#1027#1057#8218' [Page#]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 385.512060000000000000
        Width = 1046.929810000000000000
        DataSet = frdsRN022
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo13: TfrxMemoView
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."ID"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          Left = 45.354360000000000000
          Width = 219.212740000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."TREATY_STATUS"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 264.567100000000000000
          Width = 423.307360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo16: TfrxMemoView
          Left = 687.874460000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."DATETO"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 782.362710000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 914.646260000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 343.937230000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBDataset1."ID"'
        Stretched = True
        object Memo7: TfrxMemoView
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[Line#]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 45.354360000000000000
          Width = 219.212740000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8 = (
            '[frxDBDataset1."NAME"]'
            '[frxDBDataset1."EXEC_NAME"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo9: TfrxMemoView
          Left = 264.567100000000000000
          Width = 423.307360000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haBlock
          Memo.UTF8 = (
            '[frxDBDataset1."SUBJECT"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 687.874460000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."DATEFROM"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo11: TfrxMemoView
          Left = 782.362710000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."SUMMPAY"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 914.646260000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."STSUM_CURR"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        object Memo24: TfrxMemoView
          Top = 56.692949999999990000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 45.354360000000000000
          Top = 56.692949999999990000
          Width = 219.212740000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 264.567100000000000000
          Top = 56.692949999999990000
          Width = 423.307360000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 687.874460000000000000
          Top = 56.692949999999990000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 782.362710000000000000
          Top = 56.692949999999990000
          Width = 132.283550000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 914.646260000000000000
          Top = 56.692949999999990000
          Width = 132.283550000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Width = 45.354360000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111'.'#1056#1111'., '#1057#8364#1056#1105#1057#8222#1057#1026)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 45.354360000000000000
          Width = 219.212740000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176', '#1056#1105#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 264.567100000000000000
          Width = 423.307360000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 782.362710000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218', '#1057#1026#1057#1107#1056#177'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 687.874460000000000000
          Width = 94.488250000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1026#1056#1109#1056#1108#1056#1105' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 782.362710000000000000
          Top = 18.897650000000000000
          Width = 132.283550000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109' '#1056#1111#1056#1109' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1057#1107)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 914.646260000000000000
          Top = 18.897650000000000000
          Width = 132.283550000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217' '#1057#8218#1056#1109#1056#1112' '#1057#8225#1056#1105#1057#1027#1056#187#1056#181' '#1056#183#1056#176' [REP_YEAR] '#1056#1110'.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 427.086890000000000000
        Width = 1046.929810000000000000
        object Memo37: TfrxMemoView
          Left = 782.362710000000000000
          Top = 22.677180000000020000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109':')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo38: TfrxMemoView
          Left = 914.646260000000000000
          Top = 22.677180000000020000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."STSUM_CURR">,MasterData1)]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 291.023810000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBDataset1."CHAPTERNAME"'
        KeepTogether = True
        Stretched = True
        object Memo2: TfrxMemoView
          Width = 1046.929810000000000000
          Height = 30.236240000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."CHAPTERNAME"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object odsRN014: TOracleDataSet
    SQL.Strings = (
      'SELECT tr.treaty_id ID,'
      '       tr.treaty_num treaty_num,'
      '       tr.treaty_num || '#39', '#39'|| tr.exec_name name,'
      '       tr.subject subject,'
      '       NVL(st.summpay,0) stage_summpay,'
      '       tr.currency_no currency_no,'
      '    tr.plat_doc_type pdt,'
      '       st.num st_num,'
      '       TO_CHAR(st.dateto, '#39'mm.yyyy'#39') st_dateto,'
      '       DECODE(tr.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.GetLEqMaxDate' +
        'OfExchange(st.dateact, tr.currency_no)'
      '                  AND er.CURRENCY_NO = tr.currency_no'
      '              )'
      '             ) e_rate,'
      
        '       RN.MONEY_PKG.GetLEqMaxDateOfExchange(st.dateact, tr.curre' +
        'ncy_no) into_date,'
      
        '       NVL(ST.NUMPAY, decode(tr.plat_doc_type,3025,sw.doc_ext_no' +
        ',d.doc_ext_no)) NUMPAY,'
      
        '       NVL(ST.DATEPAY, DECODE(tr.plat_doc_type, 3025, m.vns_pack' +
        '.getpdmaxpdate(l2.doc_id), NVL(m.vns_pack.getpdmaxpdate(l.doc_id' +
        '), d.doc_date))) DATEPAY,'
      '--       NVL(ST.NUMPAY, d.doc_ext_no)  NUMPAY,'
      
        '--       TO_CHAR(NVL(ST.DATEPAY, nvl(m.vns_pack.getpdmaxpdate(l.' +
        'doc_id), d.doc_date)), '#39'dd.mm.yyyy'#39') DATEPAY,'
      
        '       decode(tr.istfin_kod, 2, tr.theme_plan_num, tr.treaty_id)' +
        ' num,'
      '       tr.istfin_kod istfin_kod,'
      
        '       decode(tr.istfin_kod, 2, RN.MITRCONCERN_PKG.getconcdogfor' +
        'innavdog(:DATEFROM, tr.datefrom, tr.dateto), NULL) ConcDogID,'
      
        '       COUNT(tr.treaty_id) OVER (PARTITION BY tr.treaty_id) coun' +
        't_per_treaty,'
      
        '       COUNT(distinct tr.treaty_id) OVER (PARTITION BY 1) rec_co' +
        'unt'
      '  FROM RN.mnstage st,'
      '       RN.mnagreem agr,'
      '       RN.vitreaty tr,'
      '       S.currency,'
      '       M.vns_pd_div_lines l,'
      '       M.vns_pd_div_lines l2,'
      '       M.documents d,'
      '       M.documents SW'
      ' WHERE st.dateact BETWEEN :DATEFROM and :DATETO'
      '   AND st.dateact <> :DATETO'
      '   AND st.agreem_id = agr.id'
      '   AND agr.treaty_id = tr.treaty_id'
      '--   AND tr.treaty_STATUS IN '#39'C'#39
      '   AND currency.currency_no = tr.currency_no'
      '   AND SW.DOC_NO(+) = st.SPECIAL_WRITTEN'
      '   AND l.sw_id(+) = SW.DOC_NO'
      '   AND d.DOC_NO(+) = l.DOC_ID'
      '   AND l2.doc_id(+) = SW.DOC_NO'
      '--   AND l.sw_id(+) = st.SPECIAL_WRITTEN'
      '--   and l.doc_id = d.doc_no(+)'
      
        ' ORDER BY tr.istfin_kod desc, decode(tr.istfin_kod, 2, RN.MITRCO' +
        'NCERN_PKG.getconcdogforinnavdog(:DATEFROM, tr.datefrom, tr.datet' +
        'o), NULL), decode(tr.istfin_kod, 2, tr.theme_plan_num, tr.treaty' +
        '_id), tr.treaty_id, st.num'
      ' ')
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A4441544546524F4D0500000000000000000000
      00070000003A44415445544F050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      04000000120000000200000049440100000000000A0000005452454154595F4E
      554D010000000000040000004E414D45010000000000070000005355424A4543
      540100000000000D00000053544147455F53554D4D5041590100000000000B00
      000043555252454E43595F4E4F0100000000000600000053545F4E554D010000
      0000000900000053545F44415445544F01000000000006000000455F52415445
      01000000000009000000494E544F5F44415445010000000000030000004E554D
      0100000000000A00000049535446494E5F4B4F4401000000000009000000434F
      4E43444F47494401000000000010000000434F554E545F5045525F5452454154
      59010000000000090000005245435F434F554E54010000000000030000005044
      54010000000000060000004E554D504159010000000000070000004441544550
      4159010000000000}
    Session = seOracle
    Left = 752
    Top = 304
    object fltfld1: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'TREATY_NUM'
      Required = True
    end
    object StringField2: TStringField
      FieldName = 'NAME'
      Size = 142
    end
    object StringField3: TStringField
      FieldName = 'SUBJECT'
      Required = True
      Size = 1000
    end
    object fltfld2: TFloatField
      FieldName = 'STAGE_SUMMPAY'
    end
    object intfld1: TIntegerField
      FieldName = 'CURRENCY_NO'
    end
    object StringField4: TStringField
      FieldName = 'ST_NUM'
      Size = 13
    end
    object StringField5: TStringField
      FieldName = 'ST_DATETO'
      Size = 7
    end
    object fltfld3: TFloatField
      FieldName = 'E_RATE'
    end
    object dtfld1: TDateTimeField
      FieldName = 'INTO_DATE'
    end
    object fltfld4: TFloatField
      FieldName = 'NUM'
    end
    object intfld2: TIntegerField
      FieldName = 'ISTFIN_KOD'
      Required = True
    end
    object fltfld5: TFloatField
      FieldName = 'CONCDOGID'
    end
    object fltfld6: TFloatField
      FieldName = 'COUNT_PER_TREATY'
    end
    object fltfld7: TFloatField
      FieldName = 'REC_COUNT'
    end
  end
  object frdsRN014: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'TREATY_NUM=TREATY_NUM'
      'NAME=NAME'
      'SUBJECT=SUBJECT'
      'STAGE_SUMMPAY=STAGE_SUMMPAY'
      'CURRENCY_NO=CURRENCY_NO'
      'ST_NUM=ST_NUM'
      'ST_DATETO=ST_DATETO'
      'E_RATE=E_RATE'
      'INTO_DATE=INTO_DATE'
      'NUM=NUM'
      'ISTFIN_KOD=ISTFIN_KOD'
      'CONCDOGID=CONCDOGID'
      'COUNT_PER_TREATY=COUNT_PER_TREATY'
      'REC_COUNT=REC_COUNT')
    DataSet = odsRN014
    BCDToCurrency = False
    Left = 752
    Top = 352
  end
  object frRN014: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42450.675674976800000000
    ReportOptions.LastChange = 42450.675674976800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 752
    Top = 400
    Datasets = <
      item
        DataSet = frdsRN014
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 56.692950000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            #1056#164#1056#1115#1056#160#1056#1114#1056#1106' RN-14')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Top = 18.897650000000000000
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#1119#1056#8226#1056#160#1056#8226#1056#167#1056#8226#1056#1116#1056#172' '#1056#8217#1056#171#1056#1119#1056#1115#1056#8250#1056#1116#1056#8226#1056#1116#1056#1116#1056#171#1056#1168' '#1056#173#1056#1118#1056#1106#1056#1119#1056#1115#1056#8217' '#1056#8221#1056#1115#1056#8220#1056#1115#1056#8217#1056 +
              #1115#1056#160#1056#1115#1056#8217)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Top = 37.795300000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 411.968770000000000000
        Width = 1046.929810000000000000
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 98.267780000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo18: TfrxMemoView
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 45.354360000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 283.464750000000000000
          Width = 423.307360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 706.772110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 782.362710000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 857.953310000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 457.323130000000000000
        Width = 1046.929810000000000000
        object Memo34: TfrxMemoView
          Left = 944.882500000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#8250#1056#1105#1057#1027#1057#8218' [Page#]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 64.252010000000000000
        Top = 177.637910000000000000
        Width = 1046.929810000000000000
        object Memo4: TfrxMemoView
          Width = 45.354360000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1111'.'#1056#1111'.'
            #1057#8364#1056#1105#1057#8222#1057#1026)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 45.354360000000000000
          Width = 238.110390000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176', '#1056#1105#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 283.464750000000000000
          Width = 423.307360000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 706.772110000000000000
          Width = 75.590600000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#173#1057#8218#1056#176#1056#1111#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 782.362710000000000000
          Width = 75.590600000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1026#1056#1109#1056#1108' '#1057#1027#1056#1169#1056#176#1057#8225#1056#1105)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 857.953310000000000000
          Width = 94.488250000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#152#1057#8218#1056#1109#1056#1110#1056#1109)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Top = 45.354360000000010000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 45.354360000000000000
          Top = 45.354360000000010000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 283.464750000000000000
          Top = 45.354360000000010000
          Width = 423.307360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 706.772110000000000000
          Top = 45.354360000000010000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 782.362710000000000000
          Top = 45.354360000000010000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 857.953310000000000000
          Top = 45.354360000000010000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 952.441560000000000000
          Top = 45.354360000000010000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 325.039580000000000000
        Width = 1046.929810000000000000
        object Memo32: TfrxMemoView
          Left = 612.283860000000000000
          Width = 94.488250000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#152#1056#1118#1056#1115#1056#8220#1056#1115':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 857.953310000000000000
          Width = 94.488250000000000000
          Height = 26.456710000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."STAGE_SUMMPAY">)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 264.567100000000000000
        Width = 1046.929810000000000000
        DataSet = frdsRN014
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        Stretched = True
        object Memo25: TfrxMemoView
          Width = 45.354360000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[Line#]'
            '[frxDBDataset1."ID"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 45.354360000000000000
          Width = 238.110390000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."NAME"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 283.464750000000000000
          Width = 423.307360000000000000
          Height = 37.795300000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."SUBJECT"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 706.772110000000000000
          Width = 75.590600000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."ST_NUM"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 782.362710000000000000
          Width = 75.590600000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."ST_DATETO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 857.953310000000000000
          Width = 94.488250000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."STAGE_SUMMPAY"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frRN020: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42450.672068368010000000
    ReportOptions.LastChange = 42450.672068368010000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 696
    Top = 552
    Datasets = <
      item
        DataSet = frdsRN020
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' Category'
        Value = Null
      end
      item
        Name = 'GLING'
        Value = ''
      end
      item
        Name = 'REP_YEAR'
        Value = ''
      end
      item
        Name = 'NACHOTD'
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 30.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 464.882190000000000000
        Width = 1046.929810000000000000
        DataSet = frdsRN020
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo36: TfrxMemoView
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."TREATY_ID"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 275.905690000000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8 = (
            '[frxDBDataset1."KURS_STR"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 566.929499999999900000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."DATETO"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo40: TfrxMemoView
          Left = 661.417750000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo41: TfrxMemoView
          Left = 793.701300000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo42: TfrxMemoView
          Left = 929.764380000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 170.078850000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Left = 757.685530000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1032#1056#1118#1056#8217#1056#8226#1056#160#1056#8211#1056#8221#1056#1106#1056#174':')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 755.906000000000000000
          Top = 18.897650000000000000
          Width = 291.023810000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            
              #1056#8220#1056#187#1056#176#1056#1030#1056#1029#1057#8249#1056#8470' '#1056#1105#1056#1029#1056#182#1056#181#1056#1029#1056#181#1057#1026' '#1056#1115#1056#1106#1056#1115' "'#1056#8216#1056#181#1056#187#1056#176#1057#1026#1057#1107#1057#1027#1057#1034#1056#1108#1056#176#1056#187#1056#1105#1056#8470 +
              '"')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 755.906000000000000000
          Top = 41.574830000000000000
          Width = 291.023810000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '_______________[GLING]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo4: TfrxMemoView
          Left = 755.906000000000000000
          Top = 68.031540000000010000
          Width = 291.023810000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '"_____"__________________20        '#1056#1110'.')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo5: TfrxMemoView
          Top = 113.385900000000000000
          Width = 1046.929810000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#1115#1056#1118#1056#167#1056#1027#1056#1118' '#1056#1115' '#1056#8212#1056#1106#1056#1113#1056#160#1056#171#1056#1118#1056#171#1056#1168' '#1056#8221#1056#1115#1056#8220#1056#1115#1056#8217#1056#1115#1056#160#1056#1106#1056#1168' '#1056#164#1056#152#1056#1116#1056#1106#1056#1116#1056#1038#1056#152 +
              #1056#160#1056#1032#1056#8226#1056#1114#1056#171#1056#1168' '#1056#152#1056#8212' '#1056#1119#1056#160#1056#152#1056#8216#1056#171#1056#8250#1056#152' '#1056#8212#1056#1106' [REP_YEAR] '#1056#1110'.')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#164#1056#1115#1056#160#1056#1114#1056#1106' RN-20')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Top = 154.960730000000000000
          Width = 151.181200000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Memo.UTF8 = (
            '[Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 211.653680000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object Memo14: TfrxMemoView
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 275.905690000000000000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 566.929500000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 661.417750000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 793.701300000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 929.764380000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 287.244280000000000000
        Width = 1046.929810000000000000
        object Memo6: TfrxMemoView
          Width = 52.913420000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211
            #1056#1111'/'#1056#1111','
            #1057#8364#1056#1105#1057#8222#1057#1026)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211#1074#8222#8211' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176','
            #1056#152#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 275.905690000000000000
          Width = 291.023810000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1057#8218#1056#181#1056#1112#1057#8249' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 566.929500000000000000
          Width = 94.488250000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#1026#1056#1109#1056#1108#1056#1105' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1105#1057#1039
            '('#1056#1029#1056#176#1057#8225#1056#176#1056#187#1056#1109'- '#1056#1109#1056#1108#1056#1109#1056#1029#1057#8225#1056#176#1056#1029#1056#1105#1056#181')')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 661.417750000000000000
          Width = 385.512060000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 661.417750000000000000
          Top = 18.897650000000000000
          Width = 132.283550000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#1027#1056#181#1056#1110#1056#1109' '#1056#1111#1056#1109' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1057#1107)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 793.701300000000000000
          Top = 18.897650000000000000
          Width = 136.063080000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1109' '#1056#1030' '#1056#1111#1057#1026#1056#181#1056#1169#1057#8249#1056#1169#1057#1107#1057#8240#1056#1105#1056#181' '#1056#1110#1056#1109#1056#1169#1057#8249)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 929.764380000000000000
          Top = 18.897650000000000000
          Width = 117.165430000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#8217#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1109' '#1056#1030' [REP_YEAR] '#1056#1110'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Top = 64.252009999999990000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 52.913420000000000000
          Top = 64.252009999999990000
          Width = 222.992270000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 275.905690000000000000
          Top = 64.252009999999990000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 566.929500000000000000
          Top = 64.252009999999990000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 661.417750000000000000
          Top = 64.252009999999990000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 793.701300000000000000
          Top = 64.252009999999990000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 929.764380000000000000
          Top = 64.252009999999990000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 506.457020000000000000
        Width = 1046.929810000000000000
        object Memo43: TfrxMemoView
          Left = 275.905690000000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#152#1056#1118#1056#1115#1056#8220#1056#1115':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 661.417750000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."TREATY_SUMMPAY">)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 793.701300000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."SBF">)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 929.764380000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[SUM(<frxDBDataset1."SCUR">)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 642.520100000000000000
        Width = 1046.929810000000000000
        object Memo28: TfrxMemoView
          Left = 952.441560000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#8250#1056#1105#1057#1027#1057#8218' [Page#]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 389.291590000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBDataset1."TREATY_ID"'
        Stretched = True
        object Memo29: TfrxMemoView
          Width = 52.913420000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[Line#]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8 = (
            '[frxDBDataset1."NUM"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 275.905690000000000000
          Width = 291.023810000000000000
          Height = 52.913420000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8 = (
            '[frxDBDataset1."SUBJECT"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 566.929499999999900000
          Width = 94.488250000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."DATEFROM"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo33: TfrxMemoView
          Left = 661.417750000000000000
          Width = 132.283550000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDBDataset1."TREATY_SUMMPAY"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 793.701300000000000000
          Width = 136.063080000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8 = (
            '[frxDBDataset1."SBF"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 929.764380000000000000
          Width = 117.165430000000000000
          Height = 52.913420000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8 = (
            '[frxDBDataset1."SCUR"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 589.606680000000000000
        Width = 1046.929810000000000000
        object Memo47: TfrxMemoView
          Left = 52.913420000000000000
          Width = 222.992270000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1116#1056#1106#1056#167#1056#1106#1056#8250#1056#172#1056#1116#1056#152#1056#1113' '#1056#1115#1056#1118#1056#8221#1056#8226#1056#8250#1056#1106)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 566.929499999999900000
          Width = 226.771800000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[NACHOTD]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frdsRN020: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = True
    FieldAliases.Strings = (
      'TREATY_ID=TREATY_ID'
      'NUM=NUM'
      'SUBJECT=SUBJECT'
      'DATEFROM=DATEFROM'
      'DATETO=DATETO'
      'TREATY_SUMMPAY=TREATY_SUMMPAY'
      'KURS_STR=KURS_STR'
      'SBF=SBF'
      'SCUR=SCUR')
    DataSet = odsRN020
    BCDToCurrency = False
    Left = 696
    Top = 504
  end
  object odsRN020: TOracleDataSet
    SQL.Strings = (
      
        'SELECT TREATY_ID, NUM, SUBJECT, DATEFROM, DATETO, TREATY_SUMMPAY' +
        ', '#39#39' KURS_STR,'
      '       SUM(STSUM_BEFORE*E_RATE) SBF, SUM(STSUM_CURR*E_RATE) SCUR'
      'FROM'
      '(SELECT /*+ ORDERED */'
      '       vitreaty.treaty_id treaty_id,'
      '       vitreaty.treaty_num || '#39', '#39'||vitreaty.exec_name num,'
      '       vitreaty.subject,'
      '       TO_CHAR(vitreaty.datefrom,'#39'MM.YYYY'#39') DATEFROM,'
      '       TO_CHAR(vitreaty.dateto,'#39'MM.YYYY'#39') DATETO,'
      '       vitreaty.summpay TREATY_SUMMPAY,'
      '       vitreaty.currency_no CURRENCY_NO,'
      
        '       DECODE(GREATEST(st.dateto, TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd' +
        '.mm.yyyy'#39')), st.dateto,'
      '                     0, st.summpay) stsum_before,       '
      
        '       DECODE(GREATEST(st.dateto, TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd' +
        '.mm.yyyy'#39')), st.dateto,'
      '                     st.summpay, 0) stsum_curr,'
      '       NVL(st.summpay,0) stage_summpay,'
      ''
      '       DECODE(vitreaty.currency_no,'
      '              933,'
      '              1,'
      '              (SELECT ER.E_RATE'
      '                 FROM S.EXCHANGE_RATES er'
      
        '                WHERE er.intro_date = RN.MONEY_PKG.getdateofexch' +
        'angeofstage(vitreaty.currency_no,'
      
        '                                                                ' +
        '         st.dateact,'
      
        '                                                                ' +
        '         agr.treaty_id,'
      
        '                                                                ' +
        '         vitreaty.datefrom)'
      '                  AND er.CURRENCY_NO = vitreaty.currency_no'
      '              )'
      '             ) e_rate'
      '/*'
      
        '       RN.MONEY_PKG.getdateofexchangeofstage(vitreaty.currency_n' +
        'o,'
      '                                          st.dateact,'
      '                                          agr.treaty_id,'
      '                                          vitreaty.datefrom'
      '                                         ) into_date,'
      '*/                                         '
      
        '--       COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.t' +
        'reaty_id) count_per_treaty,'
      '--       st.dateact dateact,'
      '--       st.datefrom stage_datefrom,'
      '--       st.dateto stage_dateto,'
      '--       currency.iso_name currency_name,'
      '--       TO_CHAR(vitreaty.datefrom, '#39'YYYY'#39') DATEFROM_YEAR,'
      
        '--       COUNT(DISTINCT vitreaty.treaty_id) OVER (PARTITION BY 1' +
        ') count_treaty,'
      '--       vitreaty.treaty_id temp_num'
      '  FROM RN.vitreaty,'
      '       RN.mnagreem agr,'
      '       RN.mnstage st,'
      '       S.currency'
      ' WHERE vitreaty.treaty_status =  '#39'F'#39
      
        '   AND vitreaty.dateto >= TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy' +
        #39')'
      
        '   AND vitreaty.datefrom < TO_DATE('#39'01.01.'#39' || (:YEAR + 1), '#39'dd.' +
        'mm.yyyy'#39')'
      
        '    AND NVL((SELECT MAX(st1.dateact) from RN.mnagreem agr1, RN.m' +
        'nstage st1 WHERE agr1.treaty_id = vitreaty.treaty_id AND st1.agr' +
        'eem_id = agr1.id), TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy'#39'))'
      
        '       BETWEEN TO_DATE('#39'01.01.'#39' || :YEAR, '#39'dd.mm.yyyy'#39') AND TO_D' +
        'ATE('#39'31.12.'#39' || :YEAR, '#39'dd.mm.yyyy'#39')'
      '   AND vitreaty.istfin_kod = 1 -- '#1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072
      '   AND agr.treaty_id = vitreaty.treaty_id'
      '   AND st.agreem_id = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '        OR agr.num = vitreaty.agreem_num)'
      ''
      '   AND currency.currency_no = vitreaty.currency_no'
      ' )'
      
        ' GROUP BY TREATY_ID, NUM, SUBJECT, DATEFROM, DATETO, TREATY_SUMM' +
        'PAY'
      ' ORDER BY treaty_id')
    Optimize = False
    Variables.Data = {
      0300000001000000050000003A594541520300000004000000DF070000000000
      00}
    QBEDefinition.QBEFieldDefs = {
      0400000009000000030000004E554D010000000000080000004441544546524F
      4D0100000000000600000044415445544F0100000000000E0000005452454154
      595F53554D4D5041590100000000000300000053424601000000000004000000
      53435552010000000000080000004B5552535F53545201000000000009000000
      5452454154595F4944010000000000070000005355424A454354010000000000}
    Session = seOracle
    Left = 696
    Top = 456
    object fltfldRN020TREATY_ID: TFloatField
      FieldName = 'TREATY_ID'
      Required = True
    end
    object odsRN020NUM: TStringField
      FieldName = 'NUM'
      Size = 142
    end
    object odsRN020SUBJECT: TStringField
      FieldName = 'SUBJECT'
      Required = True
      Size = 1000
    end
    object odsRN020DATEFROM: TStringField
      FieldName = 'DATEFROM'
      Size = 7
    end
    object odsRN020DATETO: TStringField
      FieldName = 'DATETO'
      Size = 7
    end
    object fltfldRN020TREATY_SUMMPAY: TFloatField
      FieldName = 'TREATY_SUMMPAY'
      Required = True
    end
    object odsRN020KURS_STR: TStringField
      FieldName = 'KURS_STR'
      Size = 1
    end
    object fltfldRN020SBF: TFloatField
      FieldName = 'SBF'
    end
    object fltfldRN020SCUR: TFloatField
      FieldName = 'SCUR'
    end
  end
  object odsRN016_2: TOracleDataSet
    SQL.Strings = (
      'SELECT vitreaty.treaty_id ID,'
      '       NULL treaty_num,'
      '       vitreaty.subject treaty_name,'
      '       '#39#1055#1054' '#1050#1054#1053#1050#1059#1056#1057#1059#39' exec_name,'
      '       vitreaty.datefrom date_from,'
      '       vitreaty.dateto date_to,'
      '       vitreaty.first_year_summpay SPC,'
      '       vitreaty.summpay treaty_summpay,'
      '       vitreaty.CHAPTER_KOD subject_KOD,'
      '       chap.pnaim chapter_naim,'
      '       summary.summary summary,'
      '       vitreaty.treaty_status status'
      '  FROM rn.vitreaty,'
      '       rn.mnsummary summary,'
      '       rn.michapter chap'
      
        ' WHERE vitreaty.datefrom BETWEEN :REP_YEAR AND TO_DATE('#39'31.12'#39' |' +
        '| TO_CHAR(:REP_YEAR, '#39'yyyy'#39'), '#39'dd.mm.yyyy'#39')'
      '   AND vitreaty.treaty_status = '#39'P'#39
      '   AND vitreaty.istfin_kod = :istfin_kod'
      '   AND summary.treaty_id(+) = vitreaty.treaty_id'
      '   AND vitreaty.chapter_kod = chap.kod'
      ' ORDER BY vitreaty.CHAPTER_KOD, vitreaty.treaty_id')
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A5245505F594541520C00000007000000787401
      01010101000000000B0000003A49535446494E5F4B4F44030000000400000001
      00000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000C0000000200000049440100000000000A0000005452454154595F4E
      554D0100000000000B0000005452454154595F4E414D45010000000000090000
      00455845435F4E414D4501000000000009000000444154455F46524F4D010000
      00000007000000444154455F544F0100000000000E0000005452454154595F53
      554D4D5041590100000000000B0000005355424A4543545F4B4F440100000000
      000C000000434841505445525F4E41494D0100000000000700000053554D4D41
      5259010000000000060000005354415455530100000000000300000053504301
      0000000000}
    Session = seOracle
    Left = 448
    Top = 504
  end
  object odsRN016_3: TOracleDataSet
    SQL.Strings = (
      'SELECT vitreaty.treaty_id ID,'
      '       NULL treaty_num,'
      '       vitreaty.subject treaty_name,'
      '       '#39#1055#1054' '#1050#1054#1053#1050#1059#1056#1057#1059#39' exec_name,'
      '       vitreaty.datefrom date_from,'
      '       vitreaty.dateto date_to,'
      '       vitreaty.first_year_summpay SPC,'
      '       vitreaty.summpay treaty_summpay,'
      '       vitreaty.CHAPTER_KOD subject_KOD,'
      '       chap.pnaim CHAPTER_NAIM,'
      '       summary.summary summary,'
      '       vitreaty.treaty_status status'
      '  FROM rn.vitreaty,'
      '       rn.mnsummary summary,'
      '       rn.michapter chap'
      
        ' WHERE vitreaty.datefrom BETWEEN TO_DATE('#39'01.01.'#39' || ( TO_CHAR(:' +
        'REP_YEAR, '#39'yyyy'#39') - 1), '#39'dd.mm.yyyy'#39' ) AND TO_DATE('#39'31.12'#39' || (T' +
        'O_CHAR(:REP_YEAR, '#39'yyyy'#39') - 1), '#39'dd.mm.yyyy'#39')'
      '   AND vitreaty.treaty_status = '#39'P'#39
      '   AND vitreaty.istfin_kod = :istfin_kod'
      '   AND summary.treaty_id(+) = vitreaty.treaty_id'
      '   AND chap.kod = vitreaty.chapter_kod'
      ' ORDER BY vitreaty.CHAPTER_KOD, vitreaty.treaty_id')
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A5245505F594541520C00000007000000787401
      01010101000000000B0000003A49535446494E5F4B4F44030000000400000001
      00000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000C0000000200000049440100000000000A0000005452454154595F4E
      554D0100000000000B0000005452454154595F4E414D45010000000000090000
      00455845435F4E414D4501000000000009000000444154455F46524F4D010000
      00000007000000444154455F544F0100000000000E0000005452454154595F53
      554D4D5041590100000000000B0000005355424A4543545F4B4F440100000000
      000700000053554D4D4152590100000000000600000053544154555301000000
      0000030000005350430100000000000C000000434841505445525F4E41494D01
      0000000000}
    Session = seOracle
    Left = 506
    Top = 486
  end
  object frdsRN16_2: TfrxDBDataset
    UserName = 'frdbRN16_2'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'TREATY_NUM=TREATY_NUM'
      'TREATY_NAME=TREATY_NAME'
      'EXEC_NAME=EXEC_NAME'
      'DATE_FROM=DATE_FROM'
      'DATE_TO=DATE_TO'
      'SPC=SPC'
      'TREATY_SUMMPAY=TREATY_SUMMPAY'
      'SUBJECT_KOD=SUBJECT_KOD'
      'CHAPTER_NAIM=CHAPTER_NAIM'
      'SUMMARY=SUMMARY'
      'STATUS=STATUS')
    DataSet = odsRN016_2
    BCDToCurrency = False
    Left = 448
    Top = 552
  end
  object frdsRN16_3: TfrxDBDataset
    UserName = 'frdbRN16_3'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'TREATY_NUM=TREATY_NUM'
      'TREATY_NAME=TREATY_NAME'
      'EXEC_NAME=EXEC_NAME'
      'DATE_FROM=DATE_FROM'
      'DATE_TO=DATE_TO'
      'SPC=SPC'
      'TREATY_SUMMPAY=TREATY_SUMMPAY'
      'SUBJECT_KOD=SUBJECT_KOD'
      'CHAPTER_NAIM=CHAPTER_NAIM'
      'SUMMARY=SUMMARY'
      'STATUS=STATUS')
    DataSet = odsRN016_3
    BCDToCurrency = False
    Left = 504
    Top = 536
  end
  object qryFileInfo: TOracleDataSet
    SQL.Strings = (
      'SELECT FILE_DATE, FILE_VERSION, FILE_SIZE'
      '  FROM RN.SYSTEMFILES'
      ' WHERE ID = 1')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      04000000030000000900000046494C455F444154450100000000000C00000046
      494C455F56455253494F4E0100000000000900000046494C455F53495A450100
      00000000}
    Session = seOracle
    Left = 120
    Top = 576
    object dtmfldorcldtst1FILE_DATE: TDateTimeField
      FieldName = 'FILE_DATE'
    end
    object fltfldorcldtst1FILE_VERSION: TFloatField
      FieldName = 'FILE_VERSION'
    end
    object fltfldorcldtst1FILE_SIZE: TFloatField
      FieldName = 'FILE_SIZE'
      Required = True
    end
  end
  object qryFileBody: TOracleDataSet
    SQL.Strings = (
      'SELECT FILE_BODY'
      '  FROM RN.SYSTEMFILES'
      ' WHERE ID = 1')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {04000000010000000900000046494C455F424F4459000000000000}
    Session = seOracle
    Left = 80
    Top = 648
    object blbfldFileBodyFILE_BODY: TBlobField
      FieldName = 'FILE_BODY'
      BlobType = ftOraBlob
    end
  end
end
