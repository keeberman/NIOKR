inherited fmExpArchive: TfmExpArchive
  Caption = '�����: '
  PixelsPerInch = 96
  TextHeight = 17
  inherited paMiddle: TPanel
    inherited DBGrid: TRxDBGrid
      OnGetCellParams = DBGridGetCellParams
    end
  end
end
