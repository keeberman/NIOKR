object fmAnyForm: TfmAnyForm
  Left = 2
  Top = 1
  Width = 142
  Height = 34
  Caption = 'fmAnyForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object paTop: TPanel
    Left = 0
    Top = 0
    Width = 134
    Height = 41
    Align = alTop
    TabOrder = 0
  end
  object paMiddle: TPanel
    Left = 0
    Top = 41
    Width = 134
    Height = 0
    Align = alClient
    TabOrder = 1
  end
  object paSecretBottom: TPanel
    Left = 0
    Top = 41
    Width = 134
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object paBottom: TPanel
      Left = 0
      Top = 1
      Width = 134
      Height = 33
      Align = alBottom
      TabOrder = 0
    end
  end
end
