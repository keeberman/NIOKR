object dmFastReport: TdmFastReport
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Left = 1113
  Top = 303
  Height = 319
  Width = 448
  object quFields: TOracleQuery
    SQL.Strings = (
      'SELECT field_name,width,label FROM FIELDS_REP'
      'WHERE DRAFT_REP_ID= :RptId AND TABLE_NAME= :TabName'
      'order by orderno')
    Session = dmGlobal.seOracle
    Optimize = False
    Variables.Data = {
      0300000002000000060000003A52505449440300000004000000FFFFFFFF0000
      0000080000003A5441424E414D45050000000000000000000000}
    Cursor = crSQLWait
    Left = 92
    Top = 8
  end
  object quTables: TOracleQuery
    SQL.Strings = (
      'SELECT table_name,label,limit FROM TABLES_REP'
      'WHERE DRAFT_REP_ID= :RptId'
      'order by orderno')
    Session = dmGlobal.seOracle
    Optimize = False
    Variables.Data = {
      0300000001000000060000003A52505449440300000004000000FFFFFFFF0000
      0000}
    Cursor = crSQLWait
    Left = 21
    Top = 8
  end
  object quNewTables: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO TABLES_REP(DRAFT_REP_ID,TABLE_NAME,LABEL,ORDERNO,LIM' +
        'IT)'
      'VALUES(:RptId,:TabName,:Label,:OrdNo,:LIMIT)')
    Session = dmGlobal.seOracle
    Optimize = False
    Variables.Data = {
      0300000005000000060000003A52505449440300000000000000000000000800
      00003A5441424E414D45050000000000000000000000060000003A4F52444E4F
      030000000000000000000000060000003A4C4142454C05000000000000000000
      0000060000003A4C494D4954050000000000000000000000}
    Cursor = crSQLWait
    Left = 21
    Top = 56
  end
  object quNewFields: TOracleQuery
    SQL.Strings = (
      'INSERT INTO'
      
        'FIELDS_REP(DRAFT_REP_ID,TABLE_NAME,FIELD_NAME,WIDTH,LABEL,ORDERN' +
        'O)'
      'VALUES(:RptId,:TabName,:FldName,:FldWidth,:LabName,:OrdNo)')
    Session = dmGlobal.seOracle
    Optimize = False
    Variables.Data = {
      0300000006000000060000003A52505449440300000000000000000000000800
      00003A5441424E414D45050000000000000000000000060000003A4F52444E4F
      030000000000000000000000080000003A464C444E414D450500000000000000
      00000000090000003A464C445749445448030000000000000000000000080000
      003A4C41424E414D45050000000000000000000000}
    Cursor = crSQLWait
    Left = 93
    Top = 56
  end
  object quRpt: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM DRAFT_REP'
      'WHERE (USERNAME= USER OR USERNAME= '#39'PUBLIC'#39
      '       OR EXISTS ( SELECT 1 FROM MIPOLZ'
      '                   WHERE MIROL_KOD=:ADMIN AND ORANAIM= USER'
      '                        AND MIPODSIS_KOD=:APPSYS)'
      '      OR EXISTS'
      '      ( SELECT 1 FROM REP_GRANTEE'
      '        WHERE MIPOLZ_ORANAIM= USERNAME'
      '        AND MIPOLZ_MIPODSIS_KOD=:APPSYS'
      '        AND GRANTEE= USER'
      '       )'
      '      )'
      '      AND MIPODSIS_KOD=:APPSYS'
      ''
      'ORDER BY NAME ASC'
      ' '
      ' '
      ' '
      ' ')
    Optimize = False
    Variables.Data = {
      0300000002000000060000003A41444D494E0300000004000000070000000000
      0000070000003A41505053595303000000040000000200000000000000}
    ReadOnly = True
    LockingMode = lmNone
    QueryAllRecords = False
    Session = dmGlobal.seOracle
    Left = 144
    Top = 8
    object quRptNAME: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DisplayWidth = 70
      FieldName = 'NAME'
      Required = True
      Size = 100
    end
    object quRptREPDATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      FieldName = 'REPDATE'
      Required = True
      DisplayFormat = 'dd.mm.yyyy'
    end
    object quRptUSERNAME: TStringField
      Tag = 2
      FieldName = 'USERNAME'
      Required = True
      Visible = False
      Size = 30
    end
    object quRptID: TFloatField
      Tag = 2
      FieldName = 'ID'
      Required = True
      Visible = False
    end
  end
  object quClear1: TOracleQuery
    SQL.Strings = (
      'DELETE FROM FIELDS_REP WHERE DRAFT_REP_ID= :RptId')
    Session = dmGlobal.seOracle
    Optimize = False
    Variables.Data = {0300000001000000060000003A5250544944030000000000000000000000}
    Cursor = crSQLWait
    Left = 24
    Top = 104
  end
  object quClear2: TOracleQuery
    SQL.Strings = (
      'DELETE FROM TABLES_REP WHERE DRAFT_REP_ID= :RptId')
    Session = dmGlobal.seOracle
    Optimize = False
    Variables.Data = {0300000001000000060000003A5250544944030000000000000000000000}
    Cursor = crSQLWait
    Left = 96
    Top = 104
  end
  object frxLetter: TfrxReport
    Version = '5.2.3'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40490.542272129600000000
    ReportOptions.LastChange = 40616.557500532400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      
        'procedure Memo105OnPreviewDblClick(Sender: TfrxView; Button: TMo' +
        'useButton; Shift: Integer; var Modified: Boolean);'
      'begin'
      '   if frmKuradd.ShowModal = mrOk then'
      '     if Ex2lab.Visible = False then'
      '       begin'
      '       Ex2lab.Visible := True;'
      '       Ex2sig.Visible := True;'
      '       Ex2fio.Visible := True;'
      
        '       Ex2fio.Memo.Text := ebKuratorName.Text;                  ' +
        '                                                                ' +
        '         '
      '       end               '
      '     else'
      '     if Ex3lab.Visible = False then'
      '       begin                 '
      '       Ex2lab.Visible := True;'
      '       Ex2sig.Visible := True;'
      '       Ex2fio.Visible := True;'
      '       Ex2fio.Memo.Text := ebKuratorName.Text;'
      '       end               '
      '     else ShowMessage ('#39#1052#1072#1082#1089#1080#1084#1091#1084' '#1090#1088#1080' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103#39')'
      '   else frmKuradd.Visible := False;'
      'end;        '
      'begin'
      ''
      'end.')
    Left = 24
    Top = 160
    Datasets = <>
    Variables = <
      item
        Name = ' MainData'
        Value = Null
      end
      item
        Name = 'v_summpay'
        Value = #39'35 000 000'#39
      end
      item
        Name = 'v_tr_num'
        Value = Null
      end
      item
        Name = 'v_tr_datesign'
        Value = Null
      end
      item
        Name = 'v_agr_num'
        Value = Null
      end
      item
        Name = 'v_agr_datesign'
        Value = Null
      end
      item
        Name = 'v_exec_name'
        Value = Null
      end
      item
        Name = 'v_stage_acts'
        Value = Null
      end
      item
        Name = 'v_stage_nums'
        Value = Null
      end
      item
        Name = 'v_obosnovan'
        Value = Null
      end
      item
        Name = 'v_exec_bank_name'
        Value = Null
      end
      item
        Name = 'v_exec_bank_city'
        Value = Null
      end
      item
        Name = 'v_exec_account'
        Value = Null
      end
      item
        Name = 'v_exec_unn'
        Value = Null
      end
      item
        Name = 'v_primechanie'
        Value = Null
      end
      item
        Name = 'v_exec_bank_code'
        Value = Null
      end
      item
        Name = 'v_exec_bank_id'
        Value = Null
      end
      item
        Name = 'v_exec_city'
        Value = Null
      end
      item
        Name = 'v_beneficiary'
        Value = Null
      end
      item
        Name = 'v_bank'
        Value = Null
      end
      item
        Name = 'v_ISTFIN_KOD'
        Value = Null
      end
      item
        Name = 'v_TREATY_DOC_NO'
        Value = Null
      end
      item
        Name = 'v_AGREEM_DOC_NO'
        Value = Null
      end
      item
        Name = 'v_cont_pay_dt'
        Value = '12'
      end
      item
        Name = 'v_NDS'
        Value = #39'18%'#39
      end
      item
        Name = 'v_NDS_summpay'
        Value = #39'5 338 983'#39
      end
      item
        Name = 'v_cont_pay_mon'
        Value = '12'
      end
      item
        Name = 'v_cont_pay_yr'
        Value = '2010'
      end
      item
        Name = 'v_curator'
        Value = #39'fdsfas'#39
      end>
    Style = <
      item
        Name = #1054#1073#1099#1095#1085#1099#1081
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
      end
      item
        Name = #1054#1073#1099#1095#1085#1099#1081' '#1078
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
      end
      item
        Name = #1084#1072#1083' '#1082
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Verdana'
        Font.Style = [fsItalic]
      end>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 14.000000000000000000
      RightMargin = 14.000000000000000000
      TopMargin = 12.000000000000000000
      BottomMargin = 6.000000000000000000
      OnAfterPrint = 'Page1OnAfterPrint'
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 230.551330000000000000
        Top = 18.897650000000000000
        Width = 687.874460000000000000
        Child = frxLetter.Child1
        PrintChildIfInvisible = True
        Stretched = True
        object Memo1: TfrxMemoView
          Width = 434.645669290000000000
          Height = 68.031496060000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            '"'#1056#1113' '#1056#1115#1056#1119#1056#8250#1056#1106#1056#1118#1056#8226' '#1056#1032#1056#1118#1056#8217#1056#8226#1056#160#1056#8211#1056#8221#1056#1106#1056#174'"'
            
              #1056#8220#1056#181#1056#1029#1056#181#1057#1026#1056#176#1056#187#1057#1034#1056#1029#1057#8249#1056#8470' '#1056#1169#1056#1105#1057#1026#1056#181#1056#1108#1057#8218#1056#1109#1057#1026' '#1056#1115#1056#1106#1056#1115' "'#1056#8216#1056#181#1056#187#1056#176#1057#1026#1057#1107#1057#1027#1057#1034 +
              #1056#1108#1056#176#1056#187#1056#1105#1056#8470'"'
            
              '('#1056#8212#1056#176#1056#1112'. '#1056#1110#1056#181#1056#1029#1056#181#1057#1026#1056#176#1056#187#1057#1034#1056#1029#1056#1109#1056#1110#1056#1109' '#1056#1169#1056#1105#1057#1026#1056#181#1056#1108#1057#8218#1056#1109#1057#1026#1056#176' '#1056#1111#1056#1109' '#1057#1036#1056#1108#1056#1109 +
              #1056#1029#1056#1109#1056#1112#1056#1105#1056#1108#1056#181', '#1057#8222#1056#1105#1056#1029#1056#176#1056#1029#1057#1027#1056#176#1056#1112
            
              #1056#1105' '#1057#1107#1056#1111#1057#1026#1056#176#1056#1030#1056#187#1056#181#1056#1029#1056#1105#1057#1035' - '#1056#1029#1056#176#1057#8225#1056#176#1056#187#1057#1034#1056#1029#1056#1105#1056#1108' '#1057#1036#1056#1108#1056#1109#1056#1029#1056#1109#1056#1112#1056#1105#1057#8225#1056#181#1057 +
              #1027#1056#1108#1056#1109#1056#1110#1056#1109' '#1057#1107#1056#1111#1057#1026#1056#176#1056#1030#1056#187#1056#181#1056#1029#1056#1105#1057#1039
            
              #1056#1105#1056#187#1056#1105' '#1056#183#1056#176#1056#1112'. '#1056#1029#1056#176#1057#8225#1056#176#1056#187#1057#1034#1056#1029#1056#1105#1056#1108#1056#176' '#1057#1036#1056#1108#1056#1109#1056#1029#1056#1109#1056#1112#1056#1105#1057#8225#1056#181#1057#1027#1056#1108#1056#1109#1056#1110#1056#1109 +
              ' '#1057#1107#1056#1111#1057#1026#1056#176#1056#1030#1056#187#1056#181#1056#1029#1056#1105#1057#1039')')
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
        end
        object Memo4: TfrxMemoView
          Left = 434.645950000000000000
          Width = 253.228356220000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            #1056#8221#1056#187#1057#1039' '#1056#1109#1056#1111#1056#187#1056#176#1057#8218#1057#8249' '#1056#1030' '#1056#177#1056#181#1056#187#1056#1109#1057#1026#1057#1107#1057#1027#1057#1027#1056#1108#1056#1105#1057#8230' '#1057#1026#1057#1107#1056#177#1056#187#1057#1039#1057#8230)
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 434.645950000000000000
          Top = 18.897650000000000000
          Width = 253.228510000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#164#1056#1105#1056#1029#1056#176#1056#1029#1057#1027#1056#1109#1056#1030#1057#8249#1056#8470' '#1056#1109#1057#8218#1056#1169#1056#181#1056#187)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 434.645950000000000000
          Top = 37.795300000000000000
          Width = 253.228510000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1115#1056#1106#1056#1115' "'#1056#8216#1056#8226#1056#8250#1056#1106#1056#160#1056#1032#1056#1038#1056#172#1056#1113#1056#1106#1056#8250#1056#152#1056#8482'"')
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081' '#1078
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Top = 68.031540000000010000
          Width = 109.606299210000000000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 109.606370000000000000
          Top = 68.031540000000010000
          Width = 15.118110236220500000
          Height = 45.354330708661400000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 124.724490000000000000
          Top = 68.031540000000010000
          Width = 154.960629921260000000
          Height = 34.015748031496100000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 102.047310000000000000
          Width = 109.606370000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1111#1056#1109#1056#1169#1056#1111#1056#1105#1057#1027#1057#1034)
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 124.724490000000000000
          Top = 102.047310000000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            #1057#8222'.'#1056#1105'.'#1056#1109)
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 279.685220000000000000
          Top = 68.031540000000010000
          Width = 408.189240000000000000
          Height = 45.354360000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Top = 113.385900000000000000
          Width = 283.464566930000000000
          Height = 22.677165350000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8221#1056#176#1057#8218#1056#176'      "_____"________________201__'#1056#1110'.')
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Top = 136.063080000000000000
          Width = 687.874460000000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1038#1056#8250#1056#1032#1056#8211#1056#8226#1056#8216#1056#1116#1056#1115#1056#8226' '#1056#1119#1056#152#1056#1038#1056#172#1056#1114#1056#1115)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Top = 162.519790000000000000
          Width = 86.929133860000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1119#1057#1026#1056#1109#1056#1105#1056#183#1056#1030#1056#181#1056#1169#1056#1105#1057#8218#1056#181)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 86.929190000000000000
          Top = 162.519790000000000000
          Width = 264.566929130000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#1109#1056#1111#1056#187#1056#176#1057#8218#1057#1107)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Top = 181.417440000000000000
          Width = 86.929190000000000000
          Height = 22.677165350000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 86.929190000000000000
          Top = 181.417440000000000000
          Width = 264.567100000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            
              '('#1056#1109#1056#1111#1056#187#1056#176#1057#8218#1057#1107' '#1056#1111#1056#1109' '#1057#8222#1056#176#1056#1108#1057#8218#1057#1107', '#1056#1111#1057#1026#1056#181#1056#1169#1056#1109#1056#1111#1056#187#1056#176#1057#8218#1057#1107', '#1056#176#1056#1030#1056#176#1056#1029#1057#1027#1056 +
              #1109#1056#1030#1057#8249#1056#8470' '#1056#1111#1056#187#1056#176#1057#8218#1057#8216#1056#182','
            #1056#1109#1057#8218#1056#1108#1057#1026#1057#8249#1057#8218#1056#1105#1056#181' '#1056#176#1056#1108#1056#1108#1057#1026#1056#181#1056#1169#1056#1105#1057#8218#1056#1105#1056#1030#1056#176')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 351.496290000000000000
          Top = 162.519790000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1030' '#1057#1027#1057#1107#1056#1112#1056#1112#1056#181)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 419.527830000000000000
          Top = 162.519790000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_summpay]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 351.496290000000000000
          Top = 181.417440000000000000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8216#1056#181#1056#183' '#1056#1116#1056#8221#1056#1038)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
        end
        object Memo22: TfrxMemoView
          Top = 204.094620000000000000
          Width = 260.787401574803000000
          Height = 26.456692913385800000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1057#1027#1056#1109#1056#1110#1056#187#1056#176#1057#1027#1056#1029#1056#1109' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#176)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
        end
        object Memo23: TfrxMemoView
          Left = 260.787570000000000000
          Top = 204.094620000000000000
          Width = 132.283464570000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_tr_datesign]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 260.787570000000000000
          Top = 219.212740000000000000
          Width = 132.283550000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1169#1056#176#1057#8218#1056#176')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 393.071120000000000000
          Top = 204.094620000000000000
          Width = 26.456692910000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 419.527830000000000000
          Top = 204.094620000000000000
          Width = 268.346630000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_tr_num]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 419.527830000000000000
          Top = 219.212740000000000000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1029#1056#1109#1056#1112#1056#181#1057#1026')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo92: TfrxMemoView
          Left = 419.527830000000000000
          Top = 181.417440000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_NDS]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo93: TfrxMemoView
          Left = 510.236550000000000000
          Top = 181.417440000000000000
          Width = 177.637910000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_NDS_summpay]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo94: TfrxMemoView
          Left = 419.527830000000000000
          Top = 196.535560000000000000
          Width = 68.031540000000000000
          Height = 7.559060000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1057#1027#1057#8218#1056#176#1056#1030#1056#1108#1056#176')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo95: TfrxMemoView
          Left = 510.236550000000000000
          Top = 196.535560000000000000
          Width = 177.637910000000000000
          Height = 7.559060000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1057#1027#1057#1107#1056#1112#1056#1112#1056#176')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo96: TfrxMemoView
          Left = 487.559370000000000000
          Top = 181.417440000000000000
          Width = 22.677180000000000000
          Height = 22.677180000000000000
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 272.126160000000000000
        Width = 687.874460000000000000
        Child = frxLetter.Child2
        KeepChild = True
        PrintChildIfInvisible = True
        Stretched = True
        object Memo3: TfrxMemoView
          Left = 18.897650000000000000
          Width = 181.417305750000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1169#1056#1109#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034#1056#1029#1056#1109#1056#1112#1057#1107' '#1057#1027#1056#1109#1056#1110#1056#187#1056#176#1057#8364#1056#181#1056#1029#1056#1105#1057#1035)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 226.771800000000000000
          Width = 461.102660000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            #1074#8222#8211' [v_agr_num] '#1056#1109#1057#8218' [v_agr_datesign]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 725.669760000000000000
        Top = 317.480520000000000000
        Width = 687.874460000000000000
        KeepChild = True
        PrintChildIfInvisible = True
        Stretched = True
        object Memo2: TfrxMemoView
          Width = 188.976353540000000000
          Height = 34.015745590000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1057#1027' '#1056#1111#1057#1026#1056#181#1056#1169#1056#1111#1057#1026#1056#1105#1057#1039#1057#8218#1056#1105#1056#181#1056#1112' ('#1056#1109#1057#1026#1056#1110#1056#176#1056#1029#1056#1105#1056#183#1056#176#1057#8224#1056#1105#1056#181#1056#8470')')
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
        end
        object Memo29: TfrxMemoView
          Left = 188.976500000000000000
          Width = 498.897960000000000000
          Height = 34.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic, fsUnderline]
          Memo.UTF8 = (
            '[v_exec_name]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Top = 34.015769999999970000
          Width = 26.456692910000000000
          Height = 26.456695350000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#183#1056#176)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
        end
        object Memo31: TfrxMemoView
          Left = 26.456710000000000000
          Top = 34.015769999999970000
          Width = 661.417750000000000000
          Height = 15.118112680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            '[v_obosnovan]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 26.456710000000000000
          Top = 49.133890000000010000
          Width = 245.669450000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            '('#1056#1108#1057#1026#1056#176#1057#8218#1056#1108#1056#1109#1056#181' '#1056#1029#1056#176#1056#183#1056#1029#1056#176#1057#8225#1056#181#1056#1029#1056#1105#1056#181' '#1056#1111#1056#187#1056#176#1057#8218#1056#181#1056#182#1056#176')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
        end
        object Memo33: TfrxMemoView
          Top = 60.472480000000010000
          Width = 687.874460000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #1056#1116#1056#1106' '#1056#1115#1056#1038#1056#1116#1056#1115#1056#8217#1056#1106#1056#1116#1056#152#1056#152' '#1056#1038#1056#8250#1056#8226#1056#8221#1056#1032#1056#174#1056#169#1056#152#1056#1168' '#1056#8221#1056#1115#1056#1113#1056#1032#1056#1114#1056#8226#1056#1116#1056#1118#1056#1115#1056#8217':')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 26.456710000000000000
          Top = 79.370130000000010000
          Width = 661.417750000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            
              #1056#1106#1056#1108#1057#8218' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1029#1057#8249#1057#8230' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218' '#1074#8222#8211' [<v_stage_acts>] '#1056#1109 +
              #1057#8218' [<v_stage_nums>]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 26.456710000000000000
          Top = 94.488250000000000000
          Width = 661.417750000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            
              '('#1057#1027#1057#8225#1057#8216#1057#8218'-'#1057#8222#1056#176#1056#1108#1057#8218#1057#1107#1057#1026#1056#176', '#1056#1029#1056#176#1056#1108#1056#187#1056#176#1056#1169#1056#1029#1056#176#1057#1039', '#1056#176#1056#1108#1057#8218' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056 +
              #1029#1056#181#1056#1029#1056#1029#1057#8249#1057#8230' '#1057#1026#1056#176#1056#177#1056#1109#1057#8218'('#1057#1107#1057#1027#1056#187#1057#1107#1056#1110'), '#1056#1111#1057#1026#1056#1105#1057#8230#1056#1109#1056#1169#1056#1029#1057#8249#1056#8470' '#1056#1109#1057#1026#1056#1169#1056#181#1057 +
              #1026', '#1056#1111#1057#1026#1056#1105#1056#1108#1056#176#1056#183', '#1056#1111#1056#1105#1057#1027#1057#1034#1056#1112#1056#1109' '#1056#1105' '#1057#8218'.'#1056#1111'.)')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
        end
        object Memo36: TfrxMemoView
          Top = 113.385900000000000000
          Width = 321.259842520000000000
          Height = 22.677165350000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              #1057#8222#1056#176#1056#1108#1057#8218#1056#1105#1057#8225#1056#181#1057#1027#1056#1108#1056#1105' '#1056#1030#1057#8249#1056#1111#1056#1109#1056#187#1056#1029#1056#181#1056#1029#1056#1109', '#1056#1111#1056#1109#1057#1027#1057#8218#1056#176#1056#1030#1056#187#1056#181#1056#1029#1056#1109' '#1056#1030 +
              ' '#1057#1027#1057#1107#1056#1112#1056#1112#1056#181)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 321.260050000000000000
          Top = 113.385900000000000000
          Width = 120.944881890000000000
          Height = 22.677165350000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 442.205010000000000000
          Top = 113.385900000000000000
          Width = 124.724409450000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1030' '#1057#8218'.'#1057#8225'. '#1057#1027#1057#1107#1056#1112#1056#1112#1056#176' '#1056#1116#1056#8221#1056#1038)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 566.929500000000000000
          Top = 113.385900000000000000
          Width = 120.944960000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Top = 139.842610000000000000
          Width = 321.259842520000000000
          Height = 22.677165350000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#183#1056#176#1057#8225#1057#8218#1057#8216#1056#1029' '#1056#176#1056#1030#1056#176#1056#1029#1057#1027#1056#1109#1056#1030#1057#8249#1056#8470' '#1056#1111#1056#187#1056#176#1057#8218#1057#8216#1056#182' '#1056#1030' '#1057#1027#1057#1107#1056#1112#1056#1112#1056#181)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 321.260050000000000000
          Top = 139.842610000000000000
          Width = 120.944881890000000000
          Height = 22.677165350000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 442.205010000000000000
          Top = 139.842610000000000000
          Width = 124.724409450000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1030' '#1057#8218'.'#1057#8225'. '#1057#1027#1057#1107#1056#1112#1056#1112#1056#176' '#1056#1116#1056#8221#1056#1038)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 566.929500000000000000
          Top = 139.842610000000000000
          Width = 120.944960000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Top = 162.519790000000000000
          Width = 132.283464570000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1115#1056#177#1056#1109#1057#1027#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1057#8224#1056#181#1056#1029#1057#8249':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 132.283550000000000000
          Top = 162.519790000000000000
          Width = 555.590910000000000000
          Height = 15.118120000000000000
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 132.283550000000000000
          Top = 177.637910000000000000
          Width = 555.590910000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            
              '('#1056#1111#1057#1026#1056#181#1056#8470#1057#1027#1056#1108#1057#1107#1057#1026#1056#176#1056#1029#1057#8218' '#1057#8224#1056#181#1056#1029', '#1057#8224#1056#181#1056#1029#1056#176' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026#1056#1029#1056#176#1057#1039', '#1056 +
              #1169#1056#181#1056#1108#1056#187#1056#176#1057#1026#1056#1105#1057#1026#1056#1109#1056#1030#1056#176#1056#1029#1056#1029#1056#176#1057#1039', '#1057#1027#1056#1112#1056#181#1057#8218#1056#1029#1056#176#1057#1039', '#1057#1026#1056#1109#1056#183#1056#1029#1056#1105#1057#8225#1056#1029#1056#176#1057 +
              #1039' '#1056#1105' '#1057#8218'.'#1056#1111'.)')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Top = 188.976500000000000000
          Width = 687.874460000000000000
          Height = 37.795275590000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1056#8216#1056#1106#1056#1116#1056#1113#1056#1115#1056#8217#1056#1038#1056#1113#1056#152#1056#8226' '#1056#160#1056#8226#1056#1113#1056#8217#1056#152#1056#8212#1056#152#1056#1118#1056#171' '#1056#8216#1056#8226#1056#1116#1056#8226#1056#164#1056#152#1056#166#1056#152#1056#1106#1056#160#1056#1106' (' +
              #1056#1119#1056#1115#1056#8250#1056#1032#1056#167#1056#1106#1056#1118#1056#8226#1056#8250#1056#1031' '#1056#1119#1056#8250#1056#1106#1056#1118#1056#8226#1056#8211#1056#1106'):')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Top = 226.771800000000000000
          Width = 83.149606300000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8216#1056#181#1056#1029#1056#181#1057#8222#1056#1105#1057#8224#1056#1105#1056#176#1057#1026)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
        end
        object Memo49: TfrxMemoView
          Left = 83.149660000000000000
          Top = 226.771800000000000000
          Width = 604.724800000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            '[v_exec_name]')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 83.149660000000000000
          Top = 241.889920000000000000
          Width = 604.724800000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            
              '('#1056#1029#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181' '#1056#1030' '#1057#1027#1056#1109#1056#1109#1057#8218#1056#1030#1056#181#1057#8218#1057#1027#1057#8218#1056#1030#1056#1105#1056#1105' '#1057#1027' '#1056#1169#1056#1109#1056#1110#1056 +
              #1109#1056#1030#1056#1109#1057#1026#1056#1109#1056#1112', '#1057#1027#1057#8218#1057#1026#1056#176#1056#1029#1056#176' '#1056#177#1056#181#1056#1029#1056#181#1057#8222#1056#1105#1057#8224#1056#1105#1056#176#1057#1026#1056#176')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Top = 253.228510000000000000
          Width = 158.740135510000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1116#1056#1109#1056#1112#1056#181#1057#1026' '#1057#1027#1057#8225#1057#8216#1057#8218#1056#176' '#1056#177#1056#181#1056#1029#1056#181#1057#8222#1056#1105#1057#8224#1056#1105#1056#176#1057#1026#1056#176)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaBottom
        end
        object Memo52: TfrxMemoView
          Left = 158.740260000000000000
          Top = 253.228510000000000000
          Width = 385.511811020000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            '[v_exec_account]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo53: TfrxMemoView
          Top = 279.685220000000000000
          Width = 113.385775510000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1032#1056#1116#1056#1119' '#1056#177#1056#181#1056#1029#1056#181#1057#8222#1056#1105#1057#8224#1056#1105#1056#176#1057#1026#1056#176)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaBottom
        end
        object Memo54: TfrxMemoView
          Left = 113.385900000000000000
          Top = 279.685220000000000000
          Width = 430.866171020000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            '[v_exec_unn]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo55: TfrxMemoView
          Top = 306.141929999999900000
          Width = 113.385775510000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8216#1056#176#1056#1029#1056#1108'-'#1056#1111#1056#1109#1056#187#1057#1107#1057#8225#1056#176#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaBottom
        end
        object Memo56: TfrxMemoView
          Left = 113.385900000000000000
          Top = 306.141929999999900000
          Width = 430.866171020000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            '[v_exec_bank_name]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo57: TfrxMemoView
          Left = 544.252320000000000000
          Top = 306.141929999999900000
          Width = 60.472355510000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1113#1056#1109#1056#1169' '#1056#177#1056#176#1056#1029#1056#1108#1056#176)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaBottom
        end
        object Memo58: TfrxMemoView
          Left = 604.724800000000000000
          Top = 306.141929999999900000
          Width = 83.149411020000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_exec_bank_code]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo59: TfrxMemoView
          Top = 332.598640000000000000
          Width = 211.653555510000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1114#1056#181#1057#1027#1057#8218#1056#1109#1056#1029#1056#176#1057#8230#1056#1109#1056#182#1056#1169#1056#181#1056#1029#1056#1105#1056#181' '#1056#177#1056#176#1056#1029#1056#1108#1056#176'-'#1056#1111#1056#1109#1056#187#1057#1107#1057#8225#1056#176#1057#8218#1056#181#1056#187#1057#1039)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaBottom
        end
        object Memo60: TfrxMemoView
          Left = 211.653680000000000000
          Top = 332.598640000000000000
          Width = 476.220531020000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8 = (
            '[v_exec_bank_city]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo61: TfrxMemoView
          Left = 211.653680000000000000
          Top = 359.055350000000100000
          Width = 476.220518820000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            '('#1056#1110#1056#1109#1057#1026#1056#1109#1056#1169', '#1057#1027#1057#8218#1057#1026#1056#176#1056#1029#1056#176')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo62: TfrxMemoView
          Top = 359.055350000000100000
          Width = 75.590475510000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1113#1056#1109#1056#1169' '#1056#1111#1056#187#1056#176#1057#8218#1056#181#1056#182#1056#176)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaBottom
        end
        object Memo63: TfrxMemoView
          Left = 75.590600000000000000
          Top = 370.393940000000000000
          Width = 238.110141020000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo64: TfrxMemoView
          Top = 385.512059999999900000
          Width = 313.700990000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            
              '('#1057#1107#1056#1108#1056#176#1056#183#1057#8249#1056#1030#1056#176#1056#181#1057#8218#1057#1027#1057#1039' '#1056#1111#1057#1026#1056#1105' '#1057#1026#1056#176#1057#1027#1057#8225#1057#8216#1057#8218#1056#176#1057#8230' '#1057#1027' '#1056#177#1057#1035#1056#1169#1056#182#1056#181#1057#8218#1056 +
              #1109#1056#1112' '#1056#1111#1056#1109' '#1056#177#1057#1035#1056#1169#1056#182#1056#181#1057#8218#1056#1029#1056#1109#1056#8470' '#1056#1108#1056#187#1056#176#1057#1027#1057#1027#1056#1105#1057#8222#1056#1105#1056#1108#1056#176#1057#8224#1056#1105#1056#1105')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Top = 396.850650000000000000
          Width = 109.606245510000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1032#1056#1116#1056#1119' '#1057#8218#1057#1026#1056#181#1057#8218#1057#1034#1056#181#1056#1110#1056#1109' '#1056#187#1056#1105#1057#8224#1056#176)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaBottom
        end
        object Memo66: TfrxMemoView
          Left = 109.606370000000000000
          Top = 396.850650000000000000
          Width = 204.094371020000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo67: TfrxMemoView
          Top = 415.748300000000000000
          Width = 313.700990000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            
              '('#1056#1030' '#1057#1027#1056#187#1057#1107#1057#8225#1056#176#1057#1039#1057#8230', '#1056#1111#1057#1026#1056#181#1056#1169#1057#1107#1057#1027#1056#1112#1056#1109#1057#8218#1057#1026#1056#181#1056#1029#1056#1029#1057#8249#1057#8230' '#1056#183#1056#176#1056#1108#1056#1109#1056#1029#1056#1109#1056 +
              #1169#1056#176#1057#8218#1056#181#1056#187#1057#1034#1057#1027#1057#8218#1056#1030#1056#1109#1056#1112' '#1056#160#1056#181#1057#1027#1056#1111#1057#1107#1056#177#1056#187#1056#1105#1056#1108#1056#1105' '#1056#8216#1056#181#1056#187#1056#176#1057#1026#1057#1107#1057#1027#1057#1034')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo68: TfrxMemoView
          Top = 427.086890000000000000
          Width = 79.370005510000000000
          Height = 22.677165350000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1119#1057#1026#1056#1105#1056#1112#1056#181#1057#8225#1056#176#1056#1029#1056#1105#1056#181':')
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaBottom
        end
        object Memo69: TfrxMemoView
          Left = 79.370130000000000000
          Top = 427.086890000000000000
          Width = 608.504330000000000000
          Height = 22.677170240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic, fsUnderline]
          Memo.UTF8 = (
            '[v_primechanie]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo70: TfrxMemoView
          Top = 449.764070000000000000
          Width = 687.874460000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Top = 461.102659999999900000
          Width = 102.047244090000000000
          Height = 30.236220470000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#1025#1056#1105#1057#8222#1057#1026' '#1056#1111#1056#187#1056#176#1057#8218#1056#181#1056#182#1056#176)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Left = 102.047310000000000000
          Top = 461.102659999999900000
          Width = 64.251968503937000000
          Height = 30.236240000000000000
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo73: TfrxMemoView
          Left = 166.299320000000000000
          Top = 461.102659999999900000
          Width = 136.062992130000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 302.362400000000000000
          Top = 461.102659999999900000
          Width = 18.897637800000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 321.260050000000000000
          Top = 461.102659999999900000
          Width = 188.976377950000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              #1056#1113#1056#1109#1056#1029#1057#8218#1057#1026#1056#1109#1056#187#1057#1034#1056#1029#1057#8249#1056#8470' '#1057#1027#1057#1026#1056#1109#1056#1108' '#1056#1109#1056#1111#1056#187#1056#176#1057#8218#1057#8249' '#1056#1111#1056#1109' '#1056#1169#1056#1109#1056#1110#1056#1109#1056#1030#1056#1109#1057#1026 +
              #1057#1107)
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo76: TfrxMemoView
          Left = 510.236550000000000000
          Top = 461.102659999999900000
          Width = 49.133858270000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_cont_pay_dt]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo77: TfrxMemoView
          Left = 559.370440000000000000
          Top = 461.102659999999900000
          Width = 64.251968500000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_cont_pay_mon]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo78: TfrxMemoView
          Left = 623.622450000000000000
          Top = 461.102659999999900000
          Width = 52.913385830000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_cont_pay_yr]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo79: TfrxMemoView
          Top = 615.338900000000000000
          Width = 219.212740000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              #1056#1118#1056#181#1056#187#1056#181#1057#8222#1056#1109#1056#1029' '#1056#1109#1057#8218#1056#1030#1056#181#1057#8218#1057#1027#1057#8218#1056#1030#1056#181#1056#1029#1056#1029#1056#1109#1056#1110#1056#1109' '#1056#1105#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187 +
              #1057#1039)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo80: TfrxMemoView
          Left = 219.212740000000000000
          Top = 615.338900000000000000
          Width = 241.889920000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            '    298416')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo81: TfrxMemoView
          Top = 631.457020000000000000
          Width = 49.133858270000000000
          Height = 18.897628030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            #1056#8221#1056#176#1057#8218#1056#176' :')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo82: TfrxMemoView
          Left = 49.133890000000000000
          Top = 631.457020000000000000
          Width = 638.740570000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Style = fsDouble
          Frame.Typ = [ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo83: TfrxMemoView
          Top = 651.472790000000000000
          Width = 37.795275590000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Left = 11.338590000000000000
          Top = 655.252320000000000000
          Width = 15.118110240000000000
          Height = 15.118110240000000000
        end
        object Memo84: TfrxMemoView
          Left = 37.795300000000000000
          Top = 651.472790000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              #1056#1116#1056#176#1056#1111#1057#1026#1056#176#1056#1030#1056#187#1056#181#1056#1029#1056#1109' '#1056#1029#1056#176' '#1056#1169#1056#1109#1057#1026#1056#176#1056#177#1056#1109#1057#8218#1056#1108#1057#1107' ('#1056#1111#1057#1026#1056#1105#1057#8225#1056#1105#1056#1029#1057#8249' '#1057#1027#1056 +
              #1112'. '#1056#1029#1056#176' '#1056#1109#1056#177#1056#1109#1057#1026#1056#1109#1057#8218#1056#181')')
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaBottom
        end
        object Memo85: TfrxMemoView
          Left = 340.157700000000000000
          Top = 651.472790000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 340.157700000000000000
          Top = 670.370439999999900000
          Width = 347.716760000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1169#1056#176#1057#8218#1056#176', '#1056#1111#1056#1109#1056#1169#1056#1111#1056#1105#1057#1027#1057#1034')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo87: TfrxMemoView
          Top = 681.709030000000000000
          Width = 37.795275590000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Shape2: TfrxShapeView
          Left = 11.338590000000000000
          Top = 685.488560000000000000
          Width = 15.118110240000000000
          Height = 15.118110240000000000
        end
        object Memo88: TfrxMemoView
          Left = 37.795300000000000000
          Top = 681.709030000000000000
          Width = 359.055350000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              #1056#1119#1057#1026#1056#1109#1056#1030#1056#181#1057#1026#1056#181#1056#1029#1056#1109' '#1056#1105' '#1056#1111#1056#1109#1056#1169#1056#187#1056#181#1056#182#1056#1105#1057#8218' '#1056#1111#1056#181#1057#1026#1056#181#1057#8225#1056#1105#1057#1027#1056#187#1056#181#1056#1029#1056#1105#1057#1035' ' +
              '('#1056#183#1056#176#1056#1112#1056#181#1057#8225#1056#176#1056#1029#1056#1105#1057#1039' '#1057#1107#1057#1027#1057#8218#1057#1026#1056#176#1056#1029#1056#181#1056#1029#1057#8249')')
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaBottom
        end
        object Memo89: TfrxMemoView
          Left = 396.850650000000000000
          Top = 681.709030000000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 396.850650000000000000
          Top = 700.606680000000100000
          Width = 291.023810000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '('#1056#1111#1056#1109#1056#1169#1056#1111#1056#1105#1057#1027#1057#1034')')
          ParentFont = False
          Style = #1084#1072#1083' '#1082
          VAlign = vaCenter
        end
        object Memo91: TfrxMemoView
          Top = 701.945270000000000000
          Width = 283.464566930000000000
          Height = 22.677165350000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            #1056#8221#1056#176#1057#8218#1056#176'      "_____"________________201__'#1056#1110'.')
          ParentFont = False
          Style = #1054#1073#1099#1095#1085#1099#1081
          VAlign = vaCenter
        end
        object Memo97: TfrxMemoView
          Top = 506.677490000000000000
          Width = 336.378170000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              #1056#8212#1056#176#1056#1112'. '#1056#1110#1056#181#1056#1029#1056#181#1057#1026#1056#176#1056#187#1057#1034#1056#1029#1056#1109#1056#1110#1056#1109' '#1056#1169#1056#1105#1057#1026#1056#181#1056#1108#1057#8218#1056#1109#1057#1026#1056#176' ('#1056#1111#1056#1109' '#1057#1027#1057#8218#1057#1026 +
              #1057#1107#1056#1108#1057#8218#1057#1107#1057#1026#1056#181' '#1057#1107#1056#1111#1057#1026#1056#176#1056#1030#1056#187#1056#181#1056#1029#1056#1105#1057#1039')')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo98: TfrxMemoView
          Left = 336.378170000000000000
          Top = 506.677490000000000000
          Width = 151.181200000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 487.559370000000000000
          Top = 506.457020000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8 = (
            '  '#1056#8217'. '#1056#1116'. '#1056#1025#1056#1111#1056#176#1056#1108#1056#1109#1056#1030#1057#1027#1056#1108#1056#1105#1056#8470)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo100: TfrxMemoView
          Top = 521.795609999999900000
          Width = 336.378170000000000000
          Height = 22.677170240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#160#1057#1107#1056#1108#1056#1109#1056#1030#1056#1109#1056#1169#1056#1105#1057#8218#1056#181#1056#187#1057#1034' '#1056#1109#1057#8218#1056#1169#1056#181#1056#187#1056#176' ('#1057#8224#1056#181#1057#8230#1056#176')   ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo101: TfrxMemoView
          Left = 336.378170000000000000
          Top = 521.795609999999900000
          Width = 151.181200000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 487.559370000000000000
          Top = 521.575139999999900000
          Width = 192.756030000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8 = (
            '  '#1056#1106'. '#1056#1106'. '#1056#1114#1056#176#1057#1026#1056#1105#1056#1029#1056#1105#1057#8225)
          ParentFont = False
          VAlign = vaBottom
        end
        object Ex1lab: TfrxMemoView
          Top = 544.472790000000000000
          Width = 336.378170000000000000
          Height = 22.677170240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#152#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034'   ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Ex1sig: TfrxMemoView
          Left = 336.378170000000000000
          Top = 544.472790000000000000
          Width = 151.181200000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Ex1fio: TfrxMemoView
          Left = 487.559370000000000000
          Top = 544.252320000000100000
          Width = 192.756030000000000000
          Height = 22.677180000000000000
          OnPreviewDblClick = 'Memo105OnPreviewDblClick'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8 = (
            '[v_curator]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Ex2lab: TfrxMemoView
          Top = 567.149969999999900000
          Width = 336.378170000000000000
          Height = 22.677170240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#152#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034'   ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Ex2sig: TfrxMemoView
          Left = 336.378170000000000000
          Top = 567.149969999999900000
          Width = 151.181200000000000000
          Height = 22.677180000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Ex2fio: TfrxMemoView
          Left = 487.559370000000000000
          Top = 566.929499999999900000
          Width = 192.756030000000000000
          Height = 22.677180000000000000
          Visible = False
          OnPreviewDblClick = 'Memo105OnPreviewDblClick'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8 = (
            ' ispolnitel')
          ParentFont = False
          VAlign = vaBottom
        end
        object Ex3lab: TfrxMemoView
          Top = 589.827150000000100000
          Width = 336.378170000000000000
          Height = 22.677170240000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            #1056#152#1057#1027#1056#1111#1056#1109#1056#187#1056#1029#1056#1105#1057#8218#1056#181#1056#187#1057#1034'   ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Ex3sig: TfrxMemoView
          Left = 336.378170000000000000
          Top = 589.827150000000100000
          Width = 151.181200000000000000
          Height = 22.677180000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Ex3fio: TfrxMemoView
          Left = 487.559370000000000000
          Top = 589.606680000000100000
          Width = 192.756030000000000000
          Height = 22.677180000000000000
          Visible = False
          OnPreviewDblClick = 'Memo105OnPreviewDblClick'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8 = (
            ' ispolnitel')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object Date: TfrxMemoView
        Top = 1044.591220000000000000
        Width = 117.165430000000000000
        Height = 11.338590000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Verdana'
        Font.Style = [fsItalic]
        HAlign = haCenter
        Memo.UTF8 = (
          '[Date] [Time]')
        ParentFont = False
        VAlign = vaCenter
      end
    end
    object frmKuradd: TfrxDialogPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Visible = False
      BorderStyle = bsSingle
      Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1082#1091#1088#1072#1090#1086#1088#1072
      Height = 139.000000000000000000
      ClientHeight = 105.000000000000000000
      Left = 375.000000000000000000
      Top = 310.000000000000000000
      Width = 312.000000000000000000
      ClientWidth = 304.000000000000000000
      object GroupBox1: TfrxGroupBoxControl
        Left = 8.000000000000000000
        Top = 8.000000000000000000
        Width = 288.000000000000000000
        Height = 52.000000000000000000
        ShowHint = True
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1077#1097#1105' '#1086#1076#1085#1086#1075#1086' '#1082#1091#1088#1072#1090#1086#1088#1072'?'
        Color = clBtnFace
        object Label1: TfrxLabelControl
          Left = 8.000000000000000000
          Top = 23.000000000000000000
          Width = 88.000000000000000000
          Height = 13.000000000000000000
          ShowHint = True
          Caption = #1048'. '#1054'. '#1060#1072#1084#1080#1083#1080#1103' ->'
          Color = clBtnFace
        end
        object ebKuratorName: TfrxEditControl
          Left = 104.210526320000000000
          Top = 19.000000000000000000
          Width = 172.789473680000000000
          Height = 21.000000000000000000
          ShowHint = True
          Color = clWindow
          MaxLength = 0
          PasswordChar = #0
        end
      end
      object btnAdd: TfrxButtonControl
        Left = 8.000000000000000000
        Top = 64.000000000000000000
        Width = 111.000000000000000000
        Height = 33.000000000000000000
        ShowHint = True
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        ModalResult = 1
        OnClick = 'btnAddOnClick'
      end
      object btnDontAdd: TfrxButtonControl
        Left = 184.000000000000000000
        Top = 64.000000000000000000
        Width = 111.000000000000000000
        Height = 33.000000000000000000
        ShowHint = True
        Caption = #1053#1077' '#1076#1086#1073#1072#1074#1083#1103#1090#1100
        ModalResult = 7
      end
    end
  end
  object frxLetterRTF: TfrxRTFExport
    FileName = 'C:\LetterRTF.rtf'
    UseFileCache = True
    DefaultPath = 'C:\'
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 80
    Top = 160
  end
  object frxLetterPDF: TfrxPDFExport
    FileName = 'C:\LetterPDF.pdf'
    UseFileCache = True
    DefaultPath = 'C:\'
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Title = #1057#1083#1091#1078#1077#1073#1085#1086#1077' '#1087#1080#1089#1100#1084#1086' '#1085#1072' '#1086#1087#1083#1072#1090#1091
    Author = 'ARM NIOKR'
    Subject = 'FastReport PDF export'
    Creator = 'ARM NIOKR'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 144
    Top = 160
  end
end
