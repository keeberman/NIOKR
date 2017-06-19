object fmCurratorList: TfmCurratorList
  Left = 468
  Top = 133
  Width = 443
  Height = 510
  Caption = #1057#1087#1080#1089#1086#1082' '#1086#1090#1074#1077#1089#1090#1074#1077#1085#1085#1099#1093' '#1080#1089#1087#1086#1083#1100#1085#1080#1090#1077#1083#1077#1081' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084'...'
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 435
      Height = 13
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = #1057#1087#1080#1089#1086#1082' '#1086#1090#1074#1077#1089#1090#1074#1077#1085#1085#1099#1093' '#1080#1089#1087#1086#1083#1100#1085#1080#1090#1077#1083#1077#1081' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1072#1084
    end
    object Label2: TLabel
      Left = 0
      Top = 14
      Width = 435
      Height = 13
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = ' 2003  --   2005 '#1075#1086#1076#1086#1074
    end
  end
  object pBottom: TPanel
    Left = 0
    Top = 451
    Width = 435
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object pRightBottom: TPanel
      Left = 265
      Top = 0
      Width = 170
      Height = 25
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object bbCancel: TBitBtn
        Left = 85
        Top = 0
        Width = 85
        Height = 25
        Caption = '&'#1047#1072#1082#1088#1099#1090#1100
        ModalResult = 2
        TabOrder = 0
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
          F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
          000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
          338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
          45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
          3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
          F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
          000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
          338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
          4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
          8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
          333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
          0000}
        NumGlyphs = 2
      end
      object bbOk: TBitBtn
        Left = 0
        Top = 0
        Width = 85
        Height = 25
        Caption = #1054#1058#1063#1045#1058
        Default = True
        Enabled = False
        TabOrder = 1
        OnClick = bbOkClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
    end
  end
  object dbgCurators: TRxDBGrid
    Left = 0
    Top = 27
    Width = 435
    Height = 424
    Align = alClient
    DataSource = dsCurators
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'SUNAME'
        Title.Alignment = taCenter
        Title.Caption = #1060#1072#1084#1080#1083#1080#1103
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIRSTNAME'
        Title.Alignment = taCenter
        Title.Caption = #1048#1084#1103
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OTCHESTVO'
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1095#1077#1089#1090#1074#1086
        Width = 130
        Visible = True
      end>
  end
  object odsCurators: TOracleDataSet
    SQL.Strings = (
      
        'SELECT /*+ ORDERED*/ DISTINCT rab.tabn tabn, rab.FNAIM suname, r' +
        'ab.INAIM firstname, rab.ONAIM otchestvo, P.PKPADEJ.GenitiveCase(' +
        'rab.FNAIM, rab.INAIM, rab.ONAIM) GenitiveCase'
      '  FROM rn.mntrcurator curator, rn.mntreaty treaty, p.mirab rab'
      ' WHERE treaty.ID = curator.treaty_ID'
      '   AND curator.mirab_tabn = rab.tabn'
      
        '   AND (   (:FromDate < TRUNC(treaty.DATEFROM, '#39'YEAR'#39')  AND :ToD' +
        'ate >= TRUNC(treaty.DATEFROM, '#39'YEAR'#39'))'
      
        '        OR (:FromDate >= TRUNC(treaty.DATEFROM, '#39'YEAR'#39') AND (:Fr' +
        'omDate <= TRUNC(treaty.DATETO, '#39'YEAR'#39')  OR treaty.status IN ('#39'P'#39 +
        ', '#39'O'#39'))))'
      'ORDER BY rab.FNAIM, rab.INAIM, rab.ONAIM'
      ' '
      ' ')
    Optimize = False
    Variables.Data = {
      0300000002000000090000003A46524F4D444154450C00000000000000000000
      00070000003A544F444154450C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      04000000030000000600000053554E414D450100000000000900000046495253
      544E414D45010000000000090000004F544348455354564F010000000000}
    Cursor = crSQLWait
    Session = dmGlobal.seOracle
    AfterOpen = odsCuratorsAfterOpen
    AfterClose = odsCuratorsAfterClose
    Left = 376
    Top = 324
  end
  object dsCurators: TDataSource
    DataSet = odsCurators
    Left = 344
    Top = 326
  end
  object quTreaty: TOracleQuery
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
        'aty_id) count_per_treaty,'
      
        '       decode(vitreaty.treaty_status, '#39'P'#39', TO_CHAR(vitreaty.date' +
        'from, '#39'YYYY'#39'), TO_CHAR(NVL(st.dateact, st.dateto), '#39'YYYY'#39')) stag' +
        'e_year_to,'
      '       currency.iso_name currency_name,'
      
        '       decode(vitreaty.treaty_status, '#39'P'#39', vitreaty.treaty_id, d' +
        'ecode(vitreaty.istfin_kod, 2, vitreaty.theme_plan_num, vitreaty.' +
        'treaty_id)) num,'
      
        '       decode(vitreaty.treaty_status, '#39'P'#39', -1, vitreaty.istfin_k' +
        'od) istfin_kod,'
      
        '       decode(vitreaty.treaty_status, '#39'P'#39', NULL, decode(vitreaty' +
        '.istfin_kod, 2, RN.MITRCONCERN_PKG.getconcdogforinnavdog(TO_DATE' +
        '('#39'01.12.'#39'|| TO_CHAR(:FromDate, '#39'yyyy'#39'), '#39'dd.mm.yyyy'#39'), vitreaty.' +
        'datefrom, vitreaty.dateto), NULL)) ConcDogID,'
      
        '       --COUNT(vitreaty.treaty_id) OVER (PARTITION BY vitreaty.t' +
        'reaty_id) count_per_treaty,'
      
        '       COUNT(distinct vitreaty.treaty_id) OVER (PARTITION BY 1) ' +
        'count_dog'
      '  FROM rn.mntrcurator curator,'
      '       rn.vitreaty,'
      '       rn.currency,'
      '       --rn.exchange_rates,'
      '       rn.mnagreem agr,'
      '       rn.mnstage st'
      ' WHERE :tabn = curator.mirab_tabn'
      '   AND curator.treaty_id = vitreaty.treaty_id(+)'
      
        '   AND (   (:FromDate < TRUNC(vitreaty.DATEFROM, '#39'YEAR'#39')  AND :T' +
        'oDate >= TRUNC(vitreaty.DATEFROM, '#39'YEAR'#39'))'
      
        '        OR (:FromDate >= TRUNC(vitreaty.DATEFROM, '#39'YEAR'#39') AND (:' +
        'FromDate <= TRUNC(vitreaty.DATETO, '#39'YEAR'#39')  OR vitreaty.treaty_s' +
        'tatus IN ('#39'P'#39', '#39'O'#39'))))'
      '   AND agr.treaty_id(+) = vitreaty.treaty_id'
      '   AND currency.currency_no(+) = vitreaty.currency_no'
      '   /*AND exchange_rates.intro_date = (SELECT MAX(er.intro_date)'
      '                                      FROM S.exchange_rates er'
      
        '                                     WHERE er.intro_date <= (SEL' +
        'ECT MAX(NVL(dateact, SYSDATE))'
      
        '                                                                ' +
        '       FROM RN.mnstage st1,'
      
        '                                                                ' +
        '            RN.mnagreem agr1'
      
        '                                                                ' +
        '      WHERE agr1.treaty_id = vitreaty.treaty_id'
      
        '                                                                ' +
        '        AND st1.agreem_id = agr1.id'
      
        '                                                                ' +
        '        AND (   st1.dateact IS NOT NULL AND agr1.num < vitreaty.' +
        'agreem_num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      
        '                                                                ' +
        '             OR agr1.num = vitreaty.agreem_num)'
      
        '                                                                ' +
        '     )'
      ''
      
        '                                       AND er.currency_no = vitr' +
        'eaty.currency_no) -- '#1050#1091#1088#1089' '#1085#1072' '#1076#1072#1090#1091' '#1072#1082#1090#1072' '#1080#1083#1080' '#1085#1072' '#1073#1086#1083#1077#1077' '#1088#1072#1085#1085#1102#1102
      '   AND exchange_rates.currency_no = vitreaty.currency_no'
      '   */AND st.agreem_id(+) = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      
        '        OR agr.num = vitreaty.agreem_num or (vitreaty.treaty_sta' +
        'tus = '#39'P'#39'))'
      
        ' ORDER BY decode(vitreaty.treaty_status, '#39'P'#39', 1, 0), vitreaty.is' +
        'tfin_kod desc, decode(vitreaty.istfin_kod, 2, RN.MITRCONCERN_PKG' +
        '.getconcdogforinnavdog(TO_DATE('#39'01.12.'#39'|| TO_CHAR(:FromDate, '#39'yy' +
        'yy'#39'), '#39'dd.mm.yyyy'#39'), vitreaty.datefrom, vitreaty.dateto), NULL),' +
        ' decode(vitreaty.treaty_status, '#39'P'#39', vitreaty.treaty_id, decode(' +
        'vitreaty.istfin_kod, 2, vitreaty.theme_plan_num, vitreaty.treaty' +
        '_id)), vitreaty.treaty_id'
      ' '
      '')
    Session = dmGlobal.seOracle
    Optimize = False
    Variables.Data = {
      0300000003000000050000003A5441424E030000000000000000000000090000
      003A46524F4D444154450C0000000000000000000000070000003A544F444154
      450C0000000000000000000000}
    Left = 376
    Top = 290
  end
  object quDogYears: TOracleQuery
    SQL.Strings = (
      
        'SELECT  DISTINCT DECODE(vitreaty.treaty_status, '#39'P'#39', TO_CHAR(vit' +
        'reaty.datefrom, '#39'yyyy'#39'), TO_CHAR(NVL(st.DATEACT, st.DATETO), '#39'yy' +
        'yy'#39')) year,'
      
        '        COUNT(DISTINCT DECODE(vitreaty.treaty_status, '#39'P'#39', TO_CH' +
        'AR(vitreaty.datefrom, '#39'yyyy'#39'), TO_CHAR(NVL(st.DATEACT, st.DATETO' +
        '), '#39'yyyy'#39'))) OVER (PARTITION BY curator.mirab_tabn) count_years'
      '  FROM rn.mntrcurator curator,'
      '       rn.mnagreem agr,'
      '       rn.vitreaty,'
      '       rn.mnstage st'
      ' WHERE :tabn = curator.mirab_tabn'
      '   AND curator.treaty_id = vitreaty.treaty_id'
      
        '   AND (   (:FromDate < TRUNC(vitreaty.DATEFROM, '#39'YEAR'#39')  AND :T' +
        'oDate >= TRUNC(vitreaty.DATEFROM, '#39'YEAR'#39'))'
      
        '        OR (:FromDate >= TRUNC(vitreaty.DATEFROM, '#39'YEAR'#39') AND (:' +
        'FromDate <= TRUNC(vitreaty.DATETO, '#39'YEAR'#39')  OR vitreaty.treaty_s' +
        'tatus IN ('#39'P'#39', '#39'O'#39'))))'
      '   AND agr.treaty_id(+) = vitreaty.treaty_id'
      '   AND st.agreem_id(+) = agr.id'
      '   AND ((st.summpay > 0) OR (vitreaty.treaty_status = '#39'P'#39'))'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      
        '        OR agr.num = vitreaty.agreem_num or (vitreaty.treaty_sta' +
        'tus = '#39'P'#39'))'
      
        ' ORDER BY DECODE(vitreaty.treaty_status, '#39'P'#39', TO_CHAR(vitreaty.d' +
        'atefrom, '#39'yyyy'#39'), TO_CHAR(NVL(st.DATEACT, st.DATETO), '#39'yyyy'#39'))')
    Session = dmGlobal.seOracle
    Optimize = False
    Variables.Data = {
      0300000003000000050000003A5441424E030000000000000000000000090000
      003A46524F4D444154450C0000000000000000000000070000003A544F444154
      450C0000000000000000000000}
    Left = 376
    Top = 256
  end
  object quPlan: TOracleQuery
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
      '       TO_CHAR(st.dateto, '#39'mm.yyyy'#39')  str_st_dateto'
      '  FROM rn.mntrcurator curator,'
      '       rn.vitreaty,'
      '       rn.currency,'
      '       --rn.exchange_rates,'
      '       rn.mnagreem agr,'
      '       rn.mnstage st,'
      '       (SELECT tr1.treaty_id tr_id, COUNT(*) count_st'
      '          FROM rn.vitreaty tr1,'
      '               rn.mntrcurator curator1,'
      '               rn.mnagreem agr1,'
      '               rn.mnstage st1'
      '         WHERE :tabn= curator1.mirab_tabn'
      '           AND curator1.treaty_id = tr1.treaty_id'
      
        '           AND  (TRUNC(TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') >= TRUNC(' +
        'tr1.DATEFROM, '#39'YEAR'#39') AND ((tr1.treaty_status <> '#39'P'#39') OR (TRUNC(' +
        'TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') <= tr1.DATEFROM)) AND (TRUNC(TO_' +
        'DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') <= TRUNC(tr1.DATETO, '#39'YEAR'#39')  OR tr' +
        '1.treaty_status = '#39'O'#39'))'
      '           AND agr1.treaty_id = tr1.treaty_id'
      '           AND st1.agreem_id = agr1.id'
      '           AND agr1.num = tr1.agreem_num'
      
        '           AND st1.dateto < TRUNC(TO_DATE(TO_CHAR(:MONTH, '#39'00'#39')|' +
        '|'#39'.'#39'||:YEAR, '#39'mm.yyyy'#39'), '#39'MONTH'#39')'
      '           AND st1.dateact IS NULL'
      '         GROUP BY tr1.treaty_id) un_st,'
      '       (SELECT tr1.treaty_id tr_id, COUNT(*) count_st'
      '          FROM rn.vitreaty tr1,'
      '               rn.mntrcurator curator1,'
      '               rn.mnagreem agr1,'
      '               rn.mnstage st1'
      '         WHERE :tabn= curator1.mirab_tabn'
      '           AND curator1.treaty_id = tr1.treaty_id'
      
        '           AND  (TRUNC(TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') >= TRUNC(' +
        'tr1.DATEFROM, '#39'YEAR'#39') AND ((tr1.treaty_status <> '#39'P'#39') OR (TRUNC(' +
        'TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') <= tr1.DATEFROM)) AND (TRUNC(TO_' +
        'DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') <= TRUNC(tr1.DATETO, '#39'YEAR'#39')  OR tr' +
        '1.treaty_status = '#39'O'#39'))'
      '           AND agr1.treaty_id = tr1.treaty_id'
      '           AND st1.agreem_id = agr1.id'
      
        '           AND (   (st1.dateact IS NOT NULL AND agr1.num < tr1.a' +
        'greem_num) -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      '                OR agr1.num = tr1.agreem_num)'
      
        '           AND NVL(st1.dateact, st1.dateto) >= TRUNC(TO_DATE(TO_' +
        'CHAR(:MONTH, '#39'00'#39')||'#39'.'#39'||:YEAR, '#39'mm.yyyy'#39'), '#39'MONTH'#39')'
      
        '           AND NVL(st1.dateact, st1.dateto) < TRUNC(TO_DATE(:YEA' +
        'R + 1, '#39'yyyy'#39'), '#39'YEAR'#39')'
      '         GROUP BY tr1.treaty_id) pl_st'
      ' WHERE :tabn = curator.mirab_tabn'
      '   AND curator.treaty_id = vitreaty.treaty_id(+)'
      
        '   AND  (TRUNC(TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'yyyy'#39') >= TRUNC(vitreaty' +
        '.DATEFROM, '#39'YEAR'#39') AND ((vitreaty.treaty_status <> '#39'P'#39') OR (TRUN' +
        'C(TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'YEAR'#39') <= vitreaty.DATEFROM)) AND (TR' +
        'UNC(TO_DATE(:YEAR, '#39'yyyy'#39'), '#39'yyyy'#39') <= TRUNC(vitreaty.DATETO, '#39'Y' +
        'EAR'#39')  OR vitreaty.treaty_status = '#39'O'#39'))'
      '   AND agr.treaty_id(+) = vitreaty.treaty_id'
      '   AND currency.currency_no(+) = vitreaty.currency_no'
      '   /*AND exchange_rates.intro_date = (SELECT MAX(er.intro_date)'
      '                                      FROM S.exchange_rates er'
      
        '                                     WHERE er.intro_date <= (SEL' +
        'ECT MAX(NVL(dateact, SYSDATE))'
      
        '                                                                ' +
        '       FROM RN.mnstage st1,'
      
        '                                                                ' +
        '            RN.mnagreem agr1'
      
        '                                                                ' +
        '      WHERE agr1.treaty_id = vitreaty.treaty_id'
      
        '                                                                ' +
        '        AND st1.agreem_id = agr1.id'
      
        '                                                                ' +
        '        AND (   st1.dateact IS NOT NULL AND agr1.num < vitreaty.' +
        'agreem_num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      
        '                                                                ' +
        '             OR agr1.num = vitreaty.agreem_num)'
      
        '                                                                ' +
        '     )'
      ''
      
        '                                       AND er.currency_no = vitr' +
        'eaty.currency_no) -- '#1050#1091#1088#1089' '#1085#1072' '#1076#1072#1090#1091' '#1072#1082#1090#1072' '#1080#1083#1080' '#1085#1072' '#1073#1086#1083#1077#1077' '#1088#1072#1085#1085#1102#1102
      '   AND exchange_rates.currency_no = vitreaty.currency_no'
      '   */AND st.agreem_id(+) = agr.id'
      
        '   AND (   st.dateact IS NOT NULL AND agr.num < vitreaty.agreem_' +
        'num -- '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1099#1093' '#1101#1090#1072#1087#1086#1074' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1076#1086#1087'.'#1089#1086#1075#1083'.'
      
        '        OR agr.num = vitreaty.agreem_num or (vitreaty.treaty_sta' +
        'tus = '#39'P'#39'))'
      '   AND un_st.tr_id(+) = vitreaty.treaty_id'
      '   AND pl_st.tr_id(+) = vitreaty.treaty_id'
      
        ' ORDER BY decode(vitreaty.treaty_status, '#39'P'#39', 1, 0), vitreaty.is' +
        'tfin_kod desc, decode(vitreaty.istfin_kod, 2, RN.MITRCONCERN_PKG' +
        '.getconcdogforinnavdog(TO_DATE('#39'01.12.'#39' || :YEAR, '#39'dd.mm.yyyy'#39'),' +
        ' vitreaty.datefrom, vitreaty.dateto), NULL), decode(vitreaty.tre' +
        'aty_status, '#39'P'#39', vitreaty.treaty_id, decode(vitreaty.istfin_kod,' +
        ' 2, vitreaty.theme_plan_num, vitreaty.treaty_id)), vitreaty.trea' +
        'ty_id, st.num'
      ' ')
    Session = dmGlobal.seOracle
    Optimize = False
    Variables.Data = {
      0300000003000000050000003A5441424E030000000000000000000000050000
      003A59454152030000000000000000000000060000003A4D4F4E544803000000
      0000000000000000}
    Left = 336
    Top = 290
  end
end
