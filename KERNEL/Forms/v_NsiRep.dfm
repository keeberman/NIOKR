inherited frNSIReport: TfrNSIReport
  Left = 121
  Top = 75
  Width = 658
  Caption = 'frNSIReport'
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 650
  end
  inherited paMiddle: TPanel
    Width = 650
    inherited qrMain: TQuickRep
      Top = 5
      Functions.DATA = (
        '0'
        '0'
        #39#39)
      Page.Values = (
        100
        2970
        100
        2100
        100
        100
        0)
      inherited ColumnHeaderBand: TQRBand
        Height = 38
        Size.Values = (
          100.541666666667
          1899.70833333333)
        object qlKod: TQRLabel
          Left = 0
          Top = 19
          Width = 22
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.3333333333333
            0
            50.2708333333333
            58.2083333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Код'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsUnderline]
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qlShort1: TQRLabel
          Left = 38
          Top = 0
          Width = 78
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.3333333333333
            100.541666666667
            0
            206.375)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Сокращенное'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qlShort2: TQRLabel
          Left = 38
          Top = 19
          Width = 82
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.3333333333333
            100.541666666667
            50.2708333333333
            216.958333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'наименование'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsUnderline]
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qlFull1: TQRLabel
          Left = 134
          Top = 0
          Width = 43
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.3333333333333
            354.541666666667
            0
            113.770833333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Полное'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qlFull2: TQRLabel
          Left = 134
          Top = 19
          Width = 82
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.3333333333333
            354.541666666667
            50.2708333333333
            216.958333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'наименование'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = [fsUnderline]
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
      inherited Detail: TQRBand
        Top = 135
        Height = 19
        Size.Values = (
          50.2708333333333
          1899.70833333333)
        object qtCode: TQRDBText
          Left = 0
          Top = 2
          Width = 25
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            0
            5.29166666666667
            66.1458333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Color = clWhite
          DataField = 'KOD'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qtShort: TQRDBText
          Left = 38
          Top = 2
          Width = 83
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            100.541666666667
            5.29166666666667
            219.604166666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = True
          Color = clWhite
          DataField = 'SNAIM'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qtFull: TQRDBText
          Left = 135
          Top = 2
          Width = 581
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            357.1875
            5.29166666666667
            1537.22916666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = True
          Color = clWhite
          DataField = 'PNAIM'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
      inherited PageHeaderBand: TQRBand
        Size.Values = (
          156.104166666667
          1899.70833333333)
        inherited QRLabel3: TQRLabel
          Size.Values = (
            42.3333333333333
            15.875
            15.875
            351.895833333333)
          FontSize = 9
        end
        inherited QRSysData1: TQRSysData
          Size.Values = (
            44.9791666666667
            15.875
            84.6666666666667
            95.25)
          FontSize = 10
        end
        inherited qsPageNumber: TQRSysData
          Size.Values = (
            44.9791666666667
            1727.72916666667
            79.375
            179.916666666667)
          FontSize = 10
        end
        inherited qsPrintTime: TQRSysData
          Left = 110
          Size.Values = (
            44.9791666666667
            291.041666666667
            84.6666666666667
            97.8958333333333)
          FontSize = 10
        end
        inherited qlReportTitle: TQRLabel
          Size.Values = (
            42.3333333333333
            854.604166666667
            15.875
            187.854166666667)
          FontSize = 9
        end
        inherited QRLabel2: TQRLabel
          Size.Values = (
            42.3333333333333
            1730.375
            15.875
            111.125)
          FontSize = 9
        end
        inherited qlCriteria: TQRLabel
          Size.Values = (
            44.9791666666667
            941.916666666667
            71.4375
            13.2291666666667)
          FontSize = 10
        end
      end
      inherited SummaryBand: TQRBand
        Top = 154
        Height = 26
        Size.Values = (
          68.7916666666667
          1899.70833333333)
        object qlCountCap: TQRLabel
          Left = 0
          Top = 6
          Width = 94
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            0
            15.875
            248.708333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Число записей:'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
        object qlCount: TQRLabel
          Left = 109
          Top = 6
          Width = 45
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            288.395833333333
            15.875
            119.0625)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'qlCount'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
    end
  end
  inherited paSecretBottom: TPanel
    Width = 650
    inherited paBottom: TPanel
      Width = 650
    end
  end
end
