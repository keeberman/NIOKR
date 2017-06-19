inherited fmExpArchive: TfmExpArchive
  Caption = 'Архив: '
  PixelsPerInch = 96
  TextHeight = 17
  inherited paMiddle: TPanel
    inherited DBGrid: TRxDBGrid
      OnGetCellParams = DBGridGetCellParams
    end
  end
end
