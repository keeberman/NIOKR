inherited frAnyReport: TfrAnyReport
  Left = 256
  Top = 122
  Width = 606
  Height = 526
  Caption = 'frAnyReport'
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 598
  end
  inherited paMiddle: TPanel
    Width = 598
    Height = 424
    object qrMain: TQuickRep
      Left = 25
      Top = 8
      Width = 794
      Height = 1123
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AfterPrint = qrMainAfterAction
      AfterPreview = qrMainAfterAction
      BeforePrint = qrMainBeforePrint
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      Functions.Strings = (
        'PAGENUMBER'
        'COLUMNNUMBER'
        'REPORTTITLE')
      Functions.DATA = (
        '0'
        '0'
        #39#39)
      OnPreview = qrMainPreview
      Options = [FirstPageHeader, LastPageFooter]
      Page.Columns = 1
      Page.Orientation = poPortrait
      Page.PaperSize = A4
      Page.Values = (
        100
        2970
        100
        2100
        100
        100
        0)
      PrinterSettings.Copies = 1
      PrinterSettings.Duplex = False
      PrinterSettings.FirstPage = 0
      PrinterSettings.LastPage = 0
      PrinterSettings.OutputBin = First
      PrintIfEmpty = False
      ShowProgress = False
      SnapToGrid = True
      Units = MM
      Zoom = 100
      object ColumnHeaderBand: TQRBand
        Left = 38
        Top = 97
        Width = 718
        Height = 32
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
          84.6666666666667
          1899.70833333333)
        BandType = rbColumnHeader
      end
      object Detail: TQRBand
        Left = 38
        Top = 129
        Width = 718
        Height = 32
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
          84.6666666666667
          1899.70833333333)
        BandType = rbDetail
      end
      object PageHeaderBand: TQRBand
        Left = 38
        Top = 38
        Width = 718
        Height = 59
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
          156.104166666667
          1899.70833333333)
        BandType = rbPageHeader
        object QRLabel3: TQRLabel
          Left = 6
          Top = 6
          Width = 133
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.3333333333333
            15.875
            15.875
            351.895833333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'ИАСУ "Беларуськалий"'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object QRSysData1: TQRSysData
          Left = 6
          Top = 32
          Width = 36
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            15.875
            84.6666666666667
            95.25)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          Color = clWhite
          Data = qrsDate
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
          FontSize = 10
        end
        object qsPageNumber: TQRSysData
          Left = 653
          Top = 30
          Width = 68
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            1727.72916666667
            79.375
            179.916666666667)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = False
          Color = clWhite
          Data = qrsPageNumber
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = 'Лист:'
          Transparent = False
          FontSize = 10
        end
        object qsPrintTime: TQRSysData
          Left = 86
          Top = 32
          Width = 37
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            227.541666666667
            84.6666666666667
            97.8958333333333)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          Color = clWhite
          Data = qrsTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
          FontSize = 10
        end
        object qlReportTitle: TQRLabel
          Left = 323
          Top = 6
          Width = 71
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.3333333333333
            854.604166666667
            15.875
            187.854166666667)
          Alignment = taCenter
          AlignToBand = True
          AutoSize = True
          AutoStretch = False
          Caption = 'qlReportTitle'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object QRLabel2: TQRLabel
          Left = 654
          Top = 6
          Width = 42
          Height = 16
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            42.3333333333333
            1730.375
            15.875
            111.125)
          Alignment = taLeftJustify
          AlignToBand = False
          AutoSize = True
          AutoStretch = False
          Caption = 'PS-005'
          Color = clWhite
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = False
          WordWrap = True
          FontSize = 9
        end
        object qlCriteria: TQRLabel
          Left = 356
          Top = 27
          Width = 5
          Height = 17
          Frame.Color = clBlack
          Frame.DrawTop = False
          Frame.DrawBottom = False
          Frame.DrawLeft = False
          Frame.DrawRight = False
          Size.Values = (
            44.9791666666667
            941.916666666667
            71.4375
            13.2291666666667)
          Alignment = taCenter
          AlignToBand = True
          AutoSize = True
          AutoStretch = False
          Caption = ' '
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
      object SummaryBand: TQRBand
        Left = 38
        Top = 161
        Width = 718
        Height = 32
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
          84.6666666666667
          1899.70833333333)
        BandType = rbSummary
      end
    end
  end
  inherited paSecretBottom: TPanel
    Top = 465
    Width = 598
    inherited paBottom: TPanel
      Width = 598
    end
  end
  object dsReport: TDataSource
    Left = 32
    Top = 16
  end
  object ID: TVEditFormID
    DataSource = dsReport
    Panel = paBottom
    Left = 81
    Top = 9
  end
end
