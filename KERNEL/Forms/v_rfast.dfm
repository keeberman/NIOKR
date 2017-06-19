inherited frFast: TfrFast
  Caption = 'frFast'
  PixelsPerInch = 96
  TextHeight = 13
  inherited paMiddle: TPanel
    inherited qrMain: TQuickRep
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
        Height = 26
        Font.Height = -13
        ParentFont = False
        Size.Values = (
          68.7916666666667
          1899.70833333333)
      end
      inherited Detail: TQRBand
        Top = 123
        Height = 18
        Font.Height = -13
        Font.Name = 'Courier New'
        ParentFont = False
        Size.Values = (
          47.625
          1899.70833333333)
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
          Left = -63
          Width = 78
          Size.Values = (
            44.9791666666667
            1693.33333333333
            79.375
            206.375)
          Alignment = taRightJustify
          AlignToBand = True
          Font.Charset = RUSSIAN_CHARSET
          FontSize = 10
        end
        inherited qsPrintTime: TQRSysData
          Size.Values = (
            44.9791666666667
            227.541666666667
            84.6666666666667
            97.8958333333333)
          FontSize = 10
        end
        inherited qlReportTitle: TQRLabel
          Left = -14
          Width = 43
          Size.Values = (
            42.3333333333333
            891.645833333333
            15.875
            113.770833333333)
          AutoSize = False
          Caption = 'Список'
          FontSize = 9
        end
        inherited QRLabel2: TQRLabel
          Left = 667
          Width = 51
          Size.Values = (
            42.3333333333333
            1764.77083333333
            15.875
            134.9375)
          Alignment = taRightJustify
          AutoSize = False
          Caption = ''
          FontSize = 9
        end
        inherited qlCriteria: TQRLabel
          Left = 354
          Width = 9
          Height = 18
          Size.Values = (
            47.625
            936.625
            71.4375
            23.8125)
          Caption = '  '
          Font.Height = -15
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          FontSize = 11
        end
      end
      inherited SummaryBand: TQRBand
        Top = 141
        Height = 23
        Size.Values = (
          60.8541666666667
          1899.70833333333)
        object qlCountCap: TQRLabel
          Left = 0
          Top = 4
          Width = 76
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            0
            10.5833333333333
            201.083333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Всего строк:'
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
          Left = 81
          Top = 4
          Width = 45
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            214.3125
            10.5833333333333
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
end
