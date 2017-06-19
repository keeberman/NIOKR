inherited fmRapidRep: TfmRapidRep
  Caption = 'fmRapidRep'
  PixelsPerInch = 96
  TextHeight = 13
  inherited ppReport: TppReport
    DataPipelineName = 'ppDBPipeline'
    inherited ppTitleBand1: TppTitleBand
      inherited pplaID: TppLabel
        Caption = ''
        mmHeight = 3979
      end
    end
    inherited ppDetailBand: TppDetailBand
      mmHeight = 5027
    end
    object ppSummaryBand1: TppSummaryBand
      mmBottomOffset = 0
      mmHeight = 8731
      mmPrintPosition = 0
      object ppCountLine: TppLine
        UserName = 'CountLine'
        StretchWithParent = True
        Weight = 0.75
        mmHeight = 265
        mmLeft = 529
        mmTop = 529
        mmWidth = 59002
        BandType = 7
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = 'Всего строк:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 794
        mmTop = 2381
        mmWidth = 22225
        BandType = 7
      end
      object ppVarCount: TppVariable
        UserName = 'VarCount'
        CalcOrder = 0
        DataType = dtInteger
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 24606
        mmTop = 2381
        mmWidth = 15875
        BandType = 7
      end
    end
  end
end
