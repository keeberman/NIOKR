inherited fmNSI: TfmNSI
  Left = 264
  Top = 203
  Caption = 'fmNSI'
  ClientHeight = 186
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Height = 0
    Visible = False
  end
  inherited paMiddle: TPanel
    Top = 0
    Height = 152
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
    object Label2: TLabel
      Left = 185
      Top = 14
      Width = 189
      Height = 16
      Caption = 'Сокращенное наименование'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 18
      Top = 87
      Width = 150
      Height = 16
      Caption = 'Полное наименование'
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
      Width = 26
      Height = 23
      HelpContext = 30
      DataField = 'KOD'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      ParentShowHint = False
      TabOrder = 0
    end
    object deShort: TVDBERus
      Left = 188
      Top = 34
      Width = 81
      Height = 23
      HelpContext = 30
      CharCase = ecUpperCase
      DataField = 'SNAIM'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      ParentShowHint = False
      TabOrder = 1
      OnKeyPress = WarningOnPress
      RusCase = True
    end
    object deFull: TVDBERus
      Left = 20
      Top = 107
      Width = 364
      Height = 23
      HelpContext = 30
      CharCase = ecUpperCase
      DataField = 'PNAIM'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      ParentShowHint = False
      TabOrder = 2
      RusCase = True
    end
  end
  inherited paSecretBottom: TPanel
    Top = 152
  end
  inherited dsCurrent: TDataSource
    Left = 64
    Top = 16
  end
  inherited PopSwitch: TPopupMenu
    Left = 432
  end
  inherited ID: TVEditFormID
    Left = 128
  end
end
