inherited fmAnyRep: TfmAnyRep
  Left = 245
  Top = 189
  Caption = 'fmAnyRep'
  PixelsPerInch = 96
  TextHeight = 13
  object ppReport: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    Units = utMillimeters
    AllowPrintToFile = True
    BeforePrint = ppReportBeforePrint
    DeviceType = 'Screen'
    Language = lgCustom
    SavePrinterSetup = True
    Left = 48
    Top = 65
    Version = '6.03'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline'
    object ppTitleBand1: TppTitleBand
      mmBottomOffset = 0
      mmHeight = 10319
      mmPrintPosition = 0
      object ppReportTitle: TppLabel
        UserName = 'ReportTitle'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3979
        mmLeft = 91027
        mmTop = 529
        mmWidth = 10033
        BandType = 1
      end
      object pplaCriteria: TppLabel
        UserName = 'ReportTitle1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3969
        mmLeft = 71173
        mmTop = 5292
        mmWidth = 50271
        BandType = 1
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = '���� �������������'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3969
        mmLeft = 2381
        mmTop = 529
        mmWidth = 36248
        BandType = 1
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3969
        mmLeft = 2646
        mmTop = 5292
        mmWidth = 35454
        BandType = 1
      end
      object pplaID: TppLabel
        UserName = 'laID'
        Caption = 'PS-005'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3969
        mmLeft = 174625
        mmTop = 529
        mmWidth = 11642
        BandType = 1
      end
    end
    object ppHeaderBand: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 5556
      mmPrintPosition = 0
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtPageNo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 183092
        mmTop = 529
        mmWidth = 7673
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = '����:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 174096
        mmTop = 529
        mmWidth = 8202
        BandType = 0
      end
    end
    object ppDetailBand: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
    end
  end
  object ppDBPipeline: TppDBPipeline
    DataSource = dsReport
    UserName = 'DBPipeline'
    Left = 16
    Top = 65
  end
  object dsReport: TDataSource
    Left = 16
    Top = 97
  end
  object ID: TVEditFormID
    Left = 80
    Top = 65
  end
end
