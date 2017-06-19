inherited fmStandardRep2: TfmStandardRep2
  Caption = 'fmStandardRep2'
  PixelsPerInch = 96
  TextHeight = 13
  inherited ppReport: TppReport
    Columns = 2
    mmColumnWidth = 98650
    DataPipelineName = 'ppDBPipeline'
    inherited ppTitleBand1: TppTitleBand
      inherited ppReportTitle: TppLabel
        Font.Style = [fsBold]
        mmHeight = 4233
        mmLeft = 89689
        mmWidth = 12446
      end
      inherited pplaCriteria: TppLabel
        Font.Style = [fsBold]
        mmHeight = 3979
        mmLeft = 71163
        mmWidth = 50292
      end
      inherited ppLabel1: TppLabel
        mmHeight = 4022
        mmLeft = 7514
        mmWidth = 27305
      end
      inherited ppSystemVariable1: TppSystemVariable
        mmHeight = 4022
        mmLeft = 4307
        mmWidth = 32131
      end
      inherited pplaID: TppLabel
        mmHeight = 4022
        mmLeft = 175133
        mmWidth = 11684
      end
    end
    inherited ppHeaderBand: TppHeaderBand
      PrintHeight = phDynamic
    end
    object ppColumnHeaderBand1: TppColumnHeaderBand [2]
      mmBottomOffset = 0
      mmHeight = 9525
      mmPrintPosition = 0
      object pplaCode: TppLabel
        UserName = 'laCode'
        Caption = 'Код'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 1323
        mmTop = 265
        mmWidth = 6085
        BandType = 2
      end
      object pplaName1: TppLabel
        UserName = 'laName1'
        Caption = 'Сокращенное'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 11113
        mmTop = 265
        mmWidth = 21167
        BandType = 2
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        Caption = 'наименование'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 10848
        mmTop = 4763
        mmWidth = 21696
        BandType = 2
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'Полное'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 35190
        mmTop = 265
        mmWidth = 12700
        BandType = 2
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        Caption = 'наименование'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 34925
        mmTop = 4763
        mmWidth = 21696
        BandType = 2
      end
    end
    inherited ppDetailBand: TppDetailBand
      PrintHeight = phDynamic
      mmHeight = 5821
      object ppteCode: TppDBText
        UserName = 'teCode'
        DataField = 'KOD'
        DataPipeline = ppDBPipeline
        DisplayFormat = '00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3344
        mmLeft = 1323
        mmTop = 794
        mmWidth = 6085
        BandType = 4
      end
      object ppteName1: TppDBText
        UserName = 'teCode1'
        DataField = 'SNAIM'
        DataPipeline = ppDBPipeline
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3440
        mmLeft = 10583
        mmTop = 794
        mmWidth = 22225
        BandType = 4
      end
      object ppmeName2: TppDBMemo
        UserName = 'meName2'
        CharWrap = True
        DataField = 'PNAIM'
        DataPipeline = ppDBPipeline
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        Stretch = True
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3440
        mmLeft = 35190
        mmTop = 794
        mmWidth = 62706
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
    end
    object ppColumnFooterBand1: TppColumnFooterBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppSummaryBand1: TppSummaryBand
      mmBottomOffset = 0
      mmHeight = 8202
      mmPrintPosition = 0
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
        OnCalc = ppvarCountCalc
        Transparent = True
        mmHeight = 4233
        mmLeft = 24606
        mmTop = 2381
        mmWidth = 15875
        BandType = 7
      end
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
    end
    object raCodeModule1: TraCodeModule
      ProgramStream = {00}
    end
  end
end
