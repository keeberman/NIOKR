inherited fmGridForm: TfmGridForm
  Left = 190
  Top = 127
  Caption = 'fmGridForm.Не изменять !!!'
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Height = 1
  end
  inherited paMiddle: TPanel
    Top = 1
    Height = 378
    inherited paBottomMiddle: TPanel
      Top = 336
    end
    object DBGrid: TRxDBGrid
      Left = 1
      Top = 1
      Width = 486
      Height = 335
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
end
