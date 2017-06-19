inherited fmFastRpt: TfmFastRpt
  Caption = 'fmFastRpt'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dsReport: TDataSource
    Left = 8
  end
  inherited frxReport: TfrxReport
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000
      Width = 1000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210
      PaperHeight = 297
      PaperSize = 9
    end
  end
  object frReport: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    Left = 96
    Top = 137
    ReportForm = {18000000}
  end
  object frDBDataSet: TfrDBDataSet
    DataSource = dsReport
    Left = 96
    Top = 169
  end
  object frTextExport1: TfrTextExport
    ScaleX = 1
    ScaleY = 1
    Left = 128
    Top = 137
  end
end
