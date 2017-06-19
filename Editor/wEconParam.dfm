inherited fmEconomicParameter: TfmEconomicParameter
  Left = 350
  Caption = 'Виды экономических показателей'
  ClientHeight = 106
  ClientWidth = 527
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 527
    Height = 0
  end
  inherited paMiddle: TPanel
    Top = 0
    Width = 527
    Height = 72
    object Label1: TLabel
      Left = 19
      Top = 13
      Width = 24
      Height = 16
      Caption = 'Код'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 69
      Top = 13
      Width = 99
      Height = 16
      Caption = 'Наименование'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object deCode: TVDBEditChar
      Left = 20
      Top = 33
      Width = 37
      Height = 23
      HelpContext = 30
      DataField = 'KOD'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      ParentShowHint = False
      TabOrder = 0
    end
    object deName: TVDBERus
      Left = 70
      Top = 33
      Width = 435
      Height = 23
      HelpContext = 30
      CharCase = ecUpperCase
      DataField = 'NAME'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      ParentShowHint = False
      TabOrder = 1
      RusCase = True
    end
  end
  inherited paSecretBottom: TPanel
    Top = 72
    Width = 527
    inherited paBottom: TPanel
      Width = 527
      inherited paRightBottom: TPanel
        Left = 280
      end
    end
  end
  inherited dsCurrent: TDataSource
    Left = 72
    Top = 288
  end
  inherited PopSwitch: TPopupMenu
    Left = 136
    Top = 289
  end
  inherited ID: TVEditFormID
    Left = 104
    Top = 289
  end
end
