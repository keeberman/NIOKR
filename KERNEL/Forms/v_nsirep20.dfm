inherited frNSI20: TfrNSI20
  Left = 390
  Top = 88
  Caption = 'frNSI20'
  PixelsPerInch = 96
  TextHeight = 13
  inherited paMiddle: TPanel
    inherited qrMain: TQuickRep
      Left = -7
      Top = 13
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
        Size.Values = (
          100.541666666667
          1899.70833333333)
        inherited qlKod: TQRLabel
          Size.Values = (
            42.3333333333333
            0
            50.2708333333333
            58.2083333333333)
          FontSize = 10
        end
        inherited qlShort1: TQRLabel
          Size.Values = (
            42.3333333333333
            100.541666666667
            0
            206.375)
          FontSize = 10
        end
        inherited qlShort2: TQRLabel
          Size.Values = (
            42.3333333333333
            100.541666666667
            50.2708333333333
            216.958333333333)
          FontSize = 10
        end
        inherited qlFull1: TQRLabel
          Left = 211
          Size.Values = (
            42.3333333333333
            558.270833333333
            0
            113.770833333333)
          FontSize = 10
        end
        inherited qlFull2: TQRLabel
          Left = 211
          Size.Values = (
            42.3333333333333
            558.270833333333
            50.2708333333333
            216.958333333333)
          FontSize = 10
        end
      end
      inherited Detail: TQRBand
        Size.Values = (
          50.2708333333333
          1899.70833333333)
        inherited qtCode: TQRDBText
          Size.Values = (
            44.9791666666667
            0
            5.29166666666667
            66.1458333333333)
          FontSize = 10
        end
        inherited qtShort: TQRDBText
          Width = 166
          Size.Values = (
            44.9791666666667
            100.541666666667
            5.29166666666667
            439.208333333333)
          FontSize = 10
        end
        inherited qtFull: TQRDBText
          Left = 212
          Width = 504
          Size.Values = (
            44.9791666666667
            560.916666666667
            5.29166666666667
            1333.5)
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
        Size.Values = (
          68.7916666666667
          1899.70833333333)
        inherited qlCountCap: TQRLabel
          Size.Values = (
            44.9791666666667
            0
            15.875
            248.708333333333)
          FontSize = 10
        end
        inherited qlCount: TQRLabel
          Size.Values = (
            44.9791666666667
            288.395833333333
            15.875
            119.0625)
          FontSize = 10
        end
      end
    end
  end
end
