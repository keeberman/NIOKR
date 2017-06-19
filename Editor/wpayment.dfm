inherited fmPayment: TfmPayment
  Left = 340
  Top = 459
  Caption = 'fmPayment'
  ClientWidth = 314
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 314
  end
  inherited paMiddle: TPanel
    Width = 314
    inherited Label2: TLabel
      Left = 97
    end
    inherited deShort: TVDBERus
      Left = 100
      Width = 181
      MaxLength = 20
    end
    inherited deFull: TVDBERus
      Width = 269
      MaxLength = 40
    end
  end
  inherited paSecretBottom: TPanel
    Width = 314
    inherited paBottom: TPanel
      Width = 314
      inherited paRightBottom: TPanel
        Left = 67
      end
    end
  end
end
