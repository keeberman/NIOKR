inherited fmExpRpt: TfmExpRpt
  Left = 85
  Top = 90
  Width = 552
  Height = 428
  PixelsPerInch = 96
  TextHeight = 17
  inherited paTop: TPanel
    Width = 544
    Height = 30
    object paButton: TPanel
      Left = 431
      Top = 1
      Width = 112
      Height = 28
      Align = alRight
      BevelOuter = bvNone
      Caption = 'paButton'
      TabOrder = 0
      object bLoad: TBitBtn
        Left = 8
        Top = 2
        Width = 102
        Height = 25
        Caption = '&Загрузить'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = bLoadClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
          333333333333337FF3333333333333903333333333333377FF33333333333399
          03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
          99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
          99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
          03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
          33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
          33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
          3333777777333333333333333333333333333333333333333333}
        NumGlyphs = 2
      end
    end
  end
  inherited paMiddle: TPanel
    Top = 30
    Width = 544
    Height = 371
    inherited paBottomMiddle: TPanel
      Top = 370
      Width = 542
      inherited paRightMiddle: TPanel
        Left = 269
      end
    end
    inherited DBGrid: TRxDBGrid
      Width = 542
      Height = 369
      OnGetCellParams = DBGridGetCellParams
    end
  end
  inherited paSecretBottom: TPanel
    Top = 401
    Width = 544
    Visible = False
    inherited paBottom: TPanel
      Width = 544
      Align = alClient
      Visible = False
    end
  end
end
