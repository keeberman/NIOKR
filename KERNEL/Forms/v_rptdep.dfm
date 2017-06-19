inherited frMipodr: TfrMipodr
  Left = 12
  Top = 23
  Caption = 'frMipodr'
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
        Height = 39
        Size.Values = (
          103.1875
          1899.70833333333)
        inherited qlKod: TQRLabel
          Top = 20
          Size.Values = (
            42.3333333333333
            0
            52.9166666666667
            58.2083333333333)
          FontSize = 10
        end
        inherited qlShort1: TQRLabel
          Top = 1
          Size.Values = (
            42.3333333333333
            100.541666666667
            2.64583333333333
            206.375)
          FontSize = 10
        end
        inherited qlShort2: TQRLabel
          Top = 20
          Size.Values = (
            42.3333333333333
            100.541666666667
            52.9166666666667
            216.958333333333)
          FontSize = 10
        end
        inherited qlFull1: TQRLabel
          Left = 133
          Top = 1
          Size.Values = (
            42.3333333333333
            351.895833333333
            2.64583333333333
            113.770833333333)
          FontSize = 10
        end
        inherited qlFull2: TQRLabel
          Left = 133
          Top = 20
          Size.Values = (
            42.3333333333333
            351.895833333333
            52.9166666666667
            216.958333333333)
          FontSize = 10
        end
      end
      inherited Detail: TQRBand
        Top = 136
        Size.Values = (
          50.2708333333333
          1899.70833333333)
        inherited qtCode: TQRDBText
          Size.Values = (
            44.9791666666667
            0
            5.29166666666667
            66.1458333333333)
          Font.Style = [fsBold]
          FontSize = 10
        end
        inherited qtShort: TQRDBText
          Size.Values = (
            44.9791666666667
            100.541666666667
            5.29166666666667
            219.604166666667)
          Font.Style = [fsBold]
          FontSize = 10
        end
        inherited qtFull: TQRDBText
          Left = 133
          Width = 580
          Size.Values = (
            44.9791666666667
            351.895833333333
            5.29166666666667
            1534.58333333333)
          Font.Style = [fsBold]
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
          Size.Values = (
            44.9791666666667
            291.041666666667
            84.6666666666667
            97.8958333333333)
          FontSize = 10
        end
        inherited qlReportTitle: TQRLabel
          Left = 277
          Width = 163
          Size.Values = (
            42.3333333333333
            732.895833333333
            15.875
            431.270833333333)
          Caption = 'Справочник подразделений'
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
          Top = 33
          Size.Values = (
            44.9791666666667
            941.916666666667
            87.3125
            13.2291666666667)
          FontSize = 10
        end
      end
      inherited SummaryBand: TQRBand
        Top = 232
        Height = 24
        Size.Values = (
          63.5
          1899.70833333333)
        inherited qlCountCap: TQRLabel
          Top = 4
          Size.Values = (
            44.9791666666667
            0
            10.5833333333333
            248.708333333333)
          FontSize = 10
        end
        inherited qlCount: TQRLabel
          Left = 102
          Top = 4
          Size.Values = (
            44.9791666666667
            269.875
            10.5833333333333
            119.0625)
          FontSize = 10
        end
      end
      object SubDetail: TQRSubDetail
        Left = 38
        Top = 193
        Width = 718
        Height = 19
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        BeforePrint = SubDetailBeforePrint
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          50.2708333333333
          1899.70833333333)
        Master = qrMain
        FooterBand = gfbSub
        HeaderBand = ghbSub
        PrintBefore = False
        PrintIfEmpty = False
        object qtSubCode: TQRDBText
          Left = 30
          Top = 2
          Width = 67
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            79.375
            5.29166666666667
            177.270833333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          AutoStretch = False
          Color = clWhite
          DataField = 'Long_Code'
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
        object qtSubShort: TQRDBText
          Left = 110
          Top = 2
          Width = 82
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            291.041666666667
            5.29166666666667
            216.958333333333)
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
        object QRDBText3: TQRDBText
          Left = 203
          Top = 2
          Width = 510
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            537.104166666667
            5.29166666666667
            1349.375)
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
          Mask = 'qtSubFull'
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 10
        end
      end
      object gfbSub: TQRBand
        Left = 38
        Top = 212
        Width = 718
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          52.9166666666667
          1899.70833333333)
        BandType = rbGroupFooter
        object QRLabel10: TQRLabel
          Left = 38
          Top = 2
          Width = 94
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
        object qlSubCount: TQRLabel
          Left = 141
          Top = 2
          Width = 45
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            373.0625
            5.29166666666667
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
      object ghbSub: TQRBand
        Left = 38
        Top = 155
        Width = 718
        Height = 38
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          100.541666666667
          1899.70833333333)
        BandType = rbGroupHeader
        object QRLabel5: TQRLabel
          Left = 30
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
            79.375
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
        object QRLabel6: TQRLabel
          Left = 109
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
            288.395833333333
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
        object QRLabel7: TQRLabel
          Left = 109
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
            288.395833333333
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
        object QRLabel8: TQRLabel
          Left = 203
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
            537.104166666667
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
        object QRLabel9: TQRLabel
          Left = 203
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
            537.104166666667
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
    end
  end
  object dsSubDetail: TDataSource
    Left = 80
    Top = 16
  end
end
