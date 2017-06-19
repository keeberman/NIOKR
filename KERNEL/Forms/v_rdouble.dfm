inherited frDoubleLink: TfrDoubleLink
  Left = 55
  Top = 47
  Width = 782
  Caption = 'frDoubleLink'
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 774
  end
  inherited paMiddle: TPanel
    Width = 774
    inherited qrMain: TQuickRep
      Left = 9
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
        Height = 0
        Size.Values = (
          0
          1899.70833333333)
      end
      inherited Detail: TQRBand
        Top = 97
        Height = 45
        BeforePrint = DetailBeforePrint
        Size.Values = (
          119.0625
          1899.70833333333)
        object qtCode: TQRDBText
          Left = 0
          Top = 26
          Width = 25
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Frame.Style = psDashDotDot
          Size.Values = (
            44.9791666666667
            0
            68.7916666666667
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
          Left = 30
          Top = 26
          Width = 179
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            79.375
            68.7916666666667
            473.604166666667)
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
          Left = 221
          Top = 26
          Width = 495
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            584.729166666667
            68.7916666666667
            1309.6875)
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
        object qlShort2: TQRLabel
          Left = 310
          Top = 3
          Width = 87
          Height = 18
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            47.625
            820.208333333333
            7.9375
            230.1875)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'М А С Т Е Р'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 11
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
          Left = 685
          Width = 31
          Size.Values = (
            44.9791666666667
            1812.39583333333
            79.375
            82.0208333333333)
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
          Left = 275
          Width = 167
          Height = 20
          Size.Values = (
            52.9166666666667
            727.604166666667
            15.875
            441.854166666667)
          Caption = 'Название справочника'
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          FontSize = 12
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
        Top = 204
        Height = 23
        BeforePrint = SummaryBandBeforePrint
        Size.Values = (
          60.8541666666667
          1899.70833333333)
        object qlCountCap: TQRLabel
          Left = 0
          Top = 4
          Width = 79
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
            209.020833333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Число групп:'
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
          Left = 86
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
            227.541666666667
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
      object grfSub1: TQRBand
        Left = 38
        Top = 183
        Width = 718
        Height = 21
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        AlignToBottom = False
        BeforePrint = grfSub1BeforePrint
        Color = clWhite
        ForceNewColumn = False
        ForceNewPage = False
        Size.Values = (
          55.5625
          1899.70833333333)
        BandType = rbGroupFooter
        object QRLabel8: TQRLabel
          Left = 13
          Top = 2
          Width = 122
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            34.3958333333333
            5.29166666666667
            322.791666666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'Число образований:'
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
        object qlSub1Count: TQRLabel
          Left = 140
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
            370.416666666667
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
      object SubDet1: TQRSubDetail
        Left = 38
        Top = 164
        Width = 718
        Height = 19
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
          50.2708333333333
          1899.70833333333)
        Master = qrMain
        FooterBand = grfSub1
        HeaderBand = GroupHeaderBand1
        PrintBefore = False
        PrintIfEmpty = False
        object QRDBText1: TQRDBText
          Left = 13
          Top = 1
          Width = 25
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            34.3958333333333
            2.64583333333333
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
        object QRDBText2: TQRDBText
          Left = 44
          Top = 1
          Width = 166
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            116.416666666667
            2.64583333333333
            439.208333333333)
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
          Left = 219
          Top = 1
          Width = 497
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            579.4375
            2.64583333333333
            1314.97916666667)
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
      object GroupHeaderBand1: TQRBand
        Left = 38
        Top = 142
        Width = 718
        Height = 22
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
          58.2083333333333
          1899.70833333333)
        BandType = rbGroupHeader
        object QRLabel4: TQRLabel
          Left = 277
          Top = 3
          Width = 159
          Height = 18
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            47.625
            732.895833333333
            7.9375
            420.6875)
          Alignment = taCenter
          AlignToBand = False
          AutoSize = True
          AutoStretch = True
          Caption = 'Д Е Т А Л И З А Ц И Я'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 11
        end
      end
    end
  end
  inherited paSecretBottom: TPanel
    Width = 774
    inherited paBottom: TPanel
      Width = 774
    end
  end
end
