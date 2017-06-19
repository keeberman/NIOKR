object frmPrintFrxLetter: TfrmPrintFrxLetter
  Left = 677
  Top = 446
  BorderStyle = bsSingle
  Caption = '������ ���������� ������ �� ������'
  ClientHeight = 128
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object gbKurators: TGroupBox
    Left = 8
    Top = 8
    Width = 337
    Height = 73
    Caption = '�������������� ��������'
    TabOrder = 0
    object lbEx2: TLabel
      Left = 24
      Top = 25
      Width = 77
      Height = 13
      Caption = '�. �. �������'
      Enabled = False
    end
    object lbEx3: TLabel
      Left = 24
      Top = 49
      Width = 77
      Height = 13
      Caption = '�. �. �������'
      Enabled = False
    end
    object cbEx2: TCheckBox
      Left = 8
      Top = 24
      Width = 17
      Height = 17
      TabOrder = 0
      OnClick = cbEx2Click
    end
    object ebEx2: TEdit
      Left = 104
      Top = 21
      Width = 225
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object cbEx3: TCheckBox
      Left = 8
      Top = 48
      Width = 17
      Height = 17
      TabOrder = 2
      OnClick = cbEx3Click
    end
    object ebEx3: TEdit
      Left = 104
      Top = 45
      Width = 225
      Height = 21
      Enabled = False
      TabOrder = 3
    end
  end
  object Button1: TButton
    Left = 8
    Top = 88
    Width = 113
    Height = 33
    Caption = '������������'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 232
    Top = 88
    Width = 113
    Height = 33
    Caption = '������'
    TabOrder = 2
  end
  object dsFrxLetter: TDataSource
    Left = 16
    Top = 320
  end
  object frxLetter1: TfrxReport
    Version = '4.5'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1
    PrintOptions.Printer = '�� ���������'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40490.5422721296
    ReportOptions.LastChange = 40616.606668831
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      ''
      
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
      '     else ShowMessage ('#39'�������� ��� �����������'#39')'
      '   else frmKuradd.Visible := False;'
      'end;        '
      'begin'
      ''
      'end.')
    Left = 80
    Top = 320
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
        Value = Null
      end>
    Style = <
      item
        Name = '�������'
        Color = clNone
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
      end
      item
        Name = '������� �'
        Color = clNone
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
      end
      item
        Name = '��� �'
        Color = clNone
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Verdana'
        Font.Style = [fsItalic]
      end>
    object Data: TfrxDataPage
      Height = 1000
      Width = 1000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210
      PaperHeight = 297
      PaperSize = 9
      LeftMargin = 14
      RightMargin = 14
      TopMargin = 12
      BottomMargin = 6
      OnAfterPrint = 'Page1OnAfterPrint'
      object PageHeader1: TfrxPageHeader
        Height = 230.55133
        Top = 18.89765
        Width = 687.87446
        Child = frxLetter1.Child1
        PrintChildIfInvisible = True
        Stretched = True
        object Memo1: TfrxMemoView
          Width = 434.64566929
          Height = 68.03149606
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            '"К ОПЛАТЕ УТВЕРЖДАЮ"'
            
              'Генеральный директор ОАО "Беларусь' +
              'калий"'
            
              '(Зам. генерального директора по эко' +
              'номике, финансам'
            
              'и управлению - начальник экономиче�' +
              '�кого управления'
            
              'или зам. начальника экономического' +
              ' управления)')
          ParentFont = False
          Style = '�������'
        end
        object Memo4: TfrxMemoView
          Left = 434.64595
          Width = 253.22835622
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            'Для оплаты в белорусских рублях')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 434.64595
          Top = 18.89765
          Width = 253.22851
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Финансовый отдел')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 434.64595
          Top = 37.7953
          Width = 253.22851
          Height = 30.23624
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'ОАО "БЕЛАРУСЬКАЛИЙ"')
          ParentFont = False
          Style = '������� �'
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Top = 68.03154
          Width = 109.60629921
          Height = 34.01574803
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 109.60637
          Top = 68.03154
          Width = 15.1181102362205
          Height = 45.3543307086614
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 124.72449
          Top = 68.03154
          Width = 154.96062992126
          Height = 34.0157480314961
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 102.04731
          Width = 109.60637
          Height = 11.33859
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            'подпись')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 124.72449
          Top = 102.04731
          Width = 154.96073
          Height = 11.33859
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            'ф.и.о')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 279.68522
          Top = 68.03154
          Width = 408.18924
          Height = 45.35436
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
          Top = 113.3859
          Width = 283.46456693
          Height = 22.67716535
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Дата      "_____"________________201__г.')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Top = 136.06308
          Width = 687.87446
          Height = 26.45669291
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            'СЛУЖЕБНОЕ ПИСЬМО')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Top = 162.51979
          Width = 86.92913386
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Произведите')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 86.92919
          Top = 162.51979
          Width = 264.56692913
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'оплату')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Top = 181.41744
          Width = 86.92919
          Height = 22.67716535
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
          Left = 86.92919
          Top = 181.41744
          Width = 264.5671
          Height = 22.67718
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            
              '(оплату по факту, предоплату, аванс�' +
              '�вый платёж,'
            'открытие аккредитива)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 351.49629
          Top = 162.51979
          Width = 68.03149606
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'в сумме')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 419.52783
          Top = 162.51979
          Width = 268.34663
          Height = 18.89765
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
          Left = 351.49629
          Top = 181.41744
          Width = 68.03154
          Height = 22.67718
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Без НДС')
          ParentFont = False
          Style = '�������'
        end
        object Memo22: TfrxMemoView
          Top = 204.09462
          Width = 260.787401574803
          Height = 26.4566929133858
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'согласно договора')
          ParentFont = False
          Style = '�������'
        end
        object Memo23: TfrxMemoView
          Left = 260.78757
          Top = 204.09462
          Width = 132.28346457
          Height = 15.11811024
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_tr_datesign]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 260.78757
          Top = 219.21274
          Width = 132.28355
          Height = 11.33859
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '(дата)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 393.07112
          Top = 204.09462
          Width = 26.45669291
          Height = 26.45669291
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
          Left = 419.52783
          Top = 204.09462
          Width = 268.34663
          Height = 15.11812
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_tr_num]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 419.52783
          Top = 219.21274
          Width = 268.34663
          Height = 11.33859
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '(номер)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo92: TfrxMemoView
          Left = 419.52783
          Top = 181.41744
          Width = 68.03154
          Height = 15.11812
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_NDS]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo93: TfrxMemoView
          Left = 510.23655
          Top = 181.41744
          Width = 177.63791
          Height = 15.11812
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_NDS_summpay]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo94: TfrxMemoView
          Left = 419.52783
          Top = 196.53556
          Width = 68.03154
          Height = 7.55906
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '(ставка)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo95: TfrxMemoView
          Left = 510.23655
          Top = 196.53556
          Width = 177.63791
          Height = 7.55906
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '(сумма)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo96: TfrxMemoView
          Left = 487.55937
          Top = 181.41744
          Width = 22.67718
          Height = 22.67718
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Width = 0.5
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object Child1: TfrxChild
        Height = 22.67718
        Top = 272.12616
        Width = 687.87446
        Child = frxLetter1.Child2
        KeepChild = True
        PrintChildIfInvisible = True
        Stretched = True
        object Memo3: TfrxMemoView
          Left = 18.89765
          Width = 181.41730575
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'дополнительному соглашению')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 226.7718
          Width = 461.10266
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          Memo.UTF8 = (
            '№ [v_agr_num] от [v_agr_datesign]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Child2: TfrxChild
        Height = 725.66976
        Top = 317.48052
        Width = 687.87446
        KeepChild = True
        PrintChildIfInvisible = True
        Stretched = True
        object Memo2: TfrxMemoView
          Width = 188.97635354
          Height = 34.01574559
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'с предприятием (организацией)')
          ParentFont = False
          Style = '�������'
        end
        object Memo29: TfrxMemoView
          Left = 188.9765
          Width = 498.89796
          Height = 34.01577
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
          Top = 34.01577
          Width = 26.45669291
          Height = 26.45669535
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'за')
          ParentFont = False
          Style = '�������'
        end
        object Memo31: TfrxMemoView
          Left = 26.45671
          Top = 34.01577
          Width = 661.41775
          Height = 15.11811268
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
          Left = 26.45671
          Top = 49.13389
          Width = 245.66945
          Height = 11.33859
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            '(краткое назначение платежа)')
          ParentFont = False
          Style = '��� �'
        end
        object Memo33: TfrxMemoView
          Top = 60.47248
          Width = 687.87446
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'НА ОСНОВАНИИ СЛЕДУЮЩИХ ДОКУМЕНТОВ:')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 26.45671
          Top = 79.37013
          Width = 661.41775
          Height = 15.11811024
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            
              'Акт выполненных работ № [<v_stage_acts>] о' +
              'т [<v_stage_nums>]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 26.45671
          Top = 94.48825
          Width = 661.41775
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            
              '(счёт-фактура, накладная, акт выпол�' +
              '�енных работ(услуг), приходный орде�' +
              '�, приказ, письмо и т.п.)')
          ParentFont = False
          Style = '��� �'
        end
        object Memo36: TfrxMemoView
          Top = 113.3859
          Width = 321.25984252
          Height = 22.67716535
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              'фактически выполнено, поставлено в' +
              ' сумме')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 321.26005
          Top = 113.3859
          Width = 120.94488189
          Height = 22.67716535
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.5
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 442.20501
          Top = 113.3859
          Width = 124.72440945
          Height = 22.67718
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'в т.ч. сумма НДС')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 566.9295
          Top = 113.3859
          Width = 120.94496
          Height = 22.67718
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.5
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Top = 139.84261
          Width = 321.25984252
          Height = 22.67716535
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'зачтён авансовый платёж в сумме')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 321.26005
          Top = 139.84261
          Width = 120.94488189
          Height = 22.67716535
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.5
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 442.20501
          Top = 139.84261
          Width = 124.72440945
          Height = 22.67718
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'в т.ч. сумма НДС')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 566.9295
          Top = 139.84261
          Width = 120.94496
          Height = 22.67718
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.5
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Top = 162.51979
          Width = 132.28346457
          Height = 15.11811024
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Обоснование цены:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 132.28355
          Top = 162.51979
          Width = 555.59091
          Height = 15.11812
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 132.28355
          Top = 177.63791
          Width = 555.59091
          Height = 11.33858268
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            
              '(прейскурант цен, цена договорная, �' +
              '�екларированная, сметная, рознична�' +
              '� и т.п.)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Top = 188.9765
          Width = 687.87446
          Height = 37.79527559
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            
              'БАНКОВСКИЕ РЕКВИЗИТЫ БЕНЕФИЦИАРА (' +
              'ПОЛУЧАТЕЛЯ ПЛАТЕЖА):')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Top = 226.7718
          Width = 83.1496063
          Height = 26.45669291
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Бенефициар')
          ParentFont = False
          Style = '�������'
        end
        object Memo49: TfrxMemoView
          Left = 83.14966
          Top = 226.7718
          Width = 604.7248
          Height = 15.11811024
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
          Left = 83.14966
          Top = 241.88992
          Width = 604.7248
          Height = 11.33859
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            
              '(наименование в соответствии с дог�' +
              '�вором, страна бенефициара)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Top = 253.22851
          Width = 158.74013551
          Height = 26.45669291
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Номер счёта бенефициара')
          ParentFont = False
          Style = '�������'
          VAlign = vaBottom
        end
        object Memo52: TfrxMemoView
          Left = 158.74026
          Top = 253.22851
          Width = 385.51181102
          Height = 26.45671
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          Memo.UTF8 = (
            '[v_exec_account]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo53: TfrxMemoView
          Top = 279.68522
          Width = 113.38577551
          Height = 26.45669291
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'УНП бенефициара')
          ParentFont = False
          Style = '�������'
          VAlign = vaBottom
        end
        object Memo54: TfrxMemoView
          Left = 113.3859
          Top = 279.68522
          Width = 430.86617102
          Height = 26.45671
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          Memo.UTF8 = (
            '[v_exec_unn]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo55: TfrxMemoView
          Top = 306.14193
          Width = 113.38577551
          Height = 26.45669291
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Банк-получатель')
          ParentFont = False
          Style = '�������'
          VAlign = vaBottom
        end
        object Memo56: TfrxMemoView
          Left = 113.3859
          Top = 306.14193
          Width = 430.86617102
          Height = 26.45671
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          Memo.UTF8 = (
            '[v_exec_bank_name]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo57: TfrxMemoView
          Left = 544.25232
          Top = 306.14193
          Width = 60.47235551
          Height = 26.45669291
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Код банка')
          ParentFont = False
          Style = '�������'
          VAlign = vaBottom
        end
        object Memo58: TfrxMemoView
          Left = 604.7248
          Top = 306.14193
          Width = 83.14941102
          Height = 26.45671
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          HAlign = haCenter
          Memo.UTF8 = (
            '[v_exec_bank_code]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo59: TfrxMemoView
          Top = 332.59864
          Width = 211.65355551
          Height = 26.45669291
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Местонахождение банка-получателя')
          ParentFont = False
          Style = '�������'
          VAlign = vaBottom
        end
        object Memo60: TfrxMemoView
          Left = 211.65368
          Top = 332.59864
          Width = 476.22053102
          Height = 26.45671
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          Memo.UTF8 = (
            '[v_exec_bank_city]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo61: TfrxMemoView
          Left = 211.65368
          Top = 359.05535
          Width = 476.22051882
          Height = 11.33858268
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            '(город, страна)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo62: TfrxMemoView
          Top = 359.05535
          Width = 75.59047551
          Height = 26.45669291
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Код платежа')
          ParentFont = False
          Style = '�������'
          VAlign = vaBottom
        end
        object Memo63: TfrxMemoView
          Left = 75.5906
          Top = 370.39394
          Width = 238.11014102
          Height = 15.11812
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo64: TfrxMemoView
          Top = 385.51206
          Width = 313.70099
          Height = 11.33859
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            
              '(указывается при расчётах с бюджет�' +
              '�м по бюджетной классификации)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Top = 396.85065
          Width = 109.60624551
          Height = 18.8976378
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'УНП третьего лица')
          ParentFont = False
          Style = '�������'
          VAlign = vaBottom
        end
        object Memo66: TfrxMemoView
          Left = 109.60637
          Top = 396.85065
          Width = 204.09437102
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          HAlign = haCenter
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo67: TfrxMemoView
          Top = 415.7483
          Width = 313.70099
          Height = 11.33859
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          Memo.UTF8 = (
            
              '(в случаях, предусмотренных законо�' +
              '�ательством Республики Беларусь)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo68: TfrxMemoView
          Top = 427.08689
          Width = 79.37000551
          Height = 22.67716535
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Примечание:')
          ParentFont = False
          Style = '�������'
          VAlign = vaBottom
        end
        object Memo69: TfrxMemoView
          Left = 79.37013
          Top = 427.08689
          Width = 608.50433
          Height = 22.67717024
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
          Top = 449.76407
          Width = 687.87446
          Height = 11.33858268
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Top = 461.10266
          Width = 102.04724409
          Height = 30.23622047
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Шифр платежа')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Left = 102.04731
          Top = 461.10266
          Width = 64.251968503937
          Height = 30.23624
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
          Left = 166.29932
          Top = 461.10266
          Width = 136.06299213
          Height = 30.23624
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 302.3624
          Top = 461.10266
          Width = 18.8976378
          Height = 30.23624
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 321.26005
          Top = 461.10266
          Width = 188.97637795
          Height = 30.23624
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              'Контрольный срок оплаты по договор' +
              'у')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo76: TfrxMemoView
          Left = 510.23655
          Top = 461.10266
          Width = 49.13385827
          Height = 30.23624
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
          Left = 559.37044
          Top = 461.10266
          Width = 64.2519685
          Height = 30.23624
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
          Left = 623.62245
          Top = 461.10266
          Width = 52.91338583
          Height = 30.23624
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
          Top = 615.3389
          Width = 219.21274
          Height = 15.11811024
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              'Телефон ответственного исполнител' +
              'я')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo80: TfrxMemoView
          Left = 219.21274
          Top = 615.3389
          Width = 241.88992
          Height = 15.11812
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
          Top = 631.45702
          Width = 49.13385827
          Height = 18.89762803
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Style = fsDouble
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            'Дата :')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo82: TfrxMemoView
          Left = 49.13389
          Top = 631.45702
          Width = 638.74057
          Height = 18.89765
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
          Top = 651.47279
          Width = 37.79527559
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Left = 11.33859
          Top = 655.25232
          Width = 15.11811024
          Height = 15.11811024
        end
        object Memo84: TfrxMemoView
          Left = 37.7953
          Top = 651.47279
          Width = 302.3624
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              'Направлено на доработку (причины с�' +
              '�. на обороте)')
          ParentFont = False
          Style = '�������'
          VAlign = vaBottom
        end
        object Memo85: TfrxMemoView
          Left = 340.1577
          Top = 651.47279
          Width = 347.71676
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 340.1577
          Top = 670.37044
          Width = 347.71676
          Height = 11.33859
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '(дата, подпись)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo87: TfrxMemoView
          Top = 681.70903
          Width = 37.79527559
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Shape2: TfrxShapeView
          Left = 11.33859
          Top = 685.48856
          Width = 15.11811024
          Height = 15.11811024
        end
        object Memo88: TfrxMemoView
          Left = 37.7953
          Top = 681.70903
          Width = 359.05535
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              'Проверено и подлежит перечислению ' +
              '(замечания устранены)')
          ParentFont = False
          Style = '�������'
          VAlign = vaBottom
        end
        object Memo89: TfrxMemoView
          Left = 396.85065
          Top = 681.70903
          Width = 291.02381
          Height = 18.89765
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 0.5
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 396.85065
          Top = 700.60668
          Width = 291.02381
          Height = 11.33859
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haCenter
          Memo.UTF8 = (
            '(подпись)')
          ParentFont = False
          Style = '��� �'
          VAlign = vaCenter
        end
        object Memo91: TfrxMemoView
          Top = 701.94527
          Width = 283.46456693
          Height = 22.67716535
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            'Дата      "_____"________________201__г.')
          ParentFont = False
          Style = '�������'
          VAlign = vaCenter
        end
        object Memo97: TfrxMemoView
          Top = 506.67749
          Width = 336.37817
          Height = 15.11811024
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8 = (
            
              'Зам. генерального директора (по стр' +
              'уктуре управления)')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo98: TfrxMemoView
          Left = 336.37817
          Top = 506.67749
          Width = 151.1812
          Height = 15.11812
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 487.55937
          Top = 506.45702
          Width = 192.75603
          Height = 15.11812
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8 = (
            '  В. Н. Шпаковский')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo100: TfrxMemoView
          Top = 521.79561
          Width = 336.37817
          Height = 22.67717024
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            'Руководитель отдела (цеха)   ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo101: TfrxMemoView
          Left = 336.37817
          Top = 521.79561
          Width = 151.1812
          Height = 22.67718
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 487.55937
          Top = 521.57514
          Width = 192.75603
          Height = 22.67718
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8 = (
            '  А. А. Маринич')
          ParentFont = False
          VAlign = vaBottom
        end
        object Ex1lab: TfrxMemoView
          Top = 544.47279
          Width = 336.37817
          Height = 22.67717024
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            'Исполнитель   ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Ex1sig: TfrxMemoView
          Left = 336.37817
          Top = 544.47279
          Width = 151.1812
          Height = 22.67718
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Ex1fio: TfrxMemoView
          Left = 487.55937
          Top = 544.25232
          Width = 192.75603
          Height = 22.67718
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
          Top = 567.14997
          Width = 336.37817
          Height = 22.67717024
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            'Исполнитель   ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Ex2sig: TfrxMemoView
          Left = 336.37817
          Top = 567.14997
          Width = 151.1812
          Height = 22.67718
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
          Left = 487.55937
          Top = 566.9295
          Width = 192.75603
          Height = 22.67718
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
          Top = 589.82715
          Width = 336.37817
          Height = 22.67717024
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            'Исполнитель   ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Ex3sig: TfrxMemoView
          Left = 336.37817
          Top = 589.82715
          Width = 151.1812
          Height = 22.67718
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
          Left = 487.55937
          Top = 589.60668
          Width = 192.75603
          Height = 22.67718
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
        Top = 1044.59122
        Width = 117.16543
        Height = 11.33859
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
      Caption = '���������� ��������'
      Height = 139
      Left = 375
      Top = 310
      Width = 312
      object GroupBox1: TfrxGroupBoxControl
        Left = 8
        Top = 8
        Width = 288
        Height = 52
        Caption = '�������� ��� ������ ��������?'
        Color = clBtnFace
        object Label1: TfrxLabelControl
          Left = 8
          Top = 23
          Width = 88
          Height = 13
          Caption = '�. �. ������� ->'
          Color = clBtnFace
        end
        object ebKuratorName: TfrxEditControl
          Left = 104.21052632
          Top = 19
          Width = 172.78947368
          Height = 21
          Color = clWindow
          MaxLength = 0
          PasswordChar = #0
        end
      end
      object btnAdd: TfrxButtonControl
        Left = 8
        Top = 64
        Width = 111
        Height = 33
        Caption = '��������'
        ModalResult = 1
        OnClick = 'btnAddOnClick'
      end
      object btnDontAdd: TfrxButtonControl
        Left = 184
        Top = 64
        Width = 111
        Height = 33
        Caption = '�� ���������'
        ModalResult = 7
      end
    end
  end
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    DataSource = dsFrxLetter
    Left = 48
    Top = 320
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 112
    Top = 320
  end
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 144
    Top = 320
  end
  object frxSimpleTextExport1: TfrxSimpleTextExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    Frames = False
    EmptyLines = False
    OEMCodepage = False
    Left = 176
    Top = 320
  end
  object frxJPEGExport1: TfrxJPEGExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    Left = 208
    Top = 320
  end
end
