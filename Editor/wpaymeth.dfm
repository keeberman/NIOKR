inherited fmPayMethods: TfmPayMethods
  Left = 352
  Top = 218
  Caption = 'fmPayMethods'
  ClientHeight = 118
  ClientWidth = 525
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 525
    Height = 0
  end
  inherited paMiddle: TPanel
    Top = 0
    Width = 525
    Height = 84
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
      DataField = 'PMETHOD_NO'
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
    object deFull: TVDBERus
      Left = 70
      Top = 33
      Width = 435
      Height = 23
      HelpContext = 30
      CharCase = ecUpperCase
      DataField = 'PMETHOD_NAME'
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
    Top = 84
    Width = 525
    inherited paBottom: TPanel
      Width = 525
      inherited paRightBottom: TPanel
        Left = 278
      end
    end
  end
  inherited dsCurrent: TDataSource
    Left = 168
    Top = 128
  end
  inherited PopSwitch: TPopupMenu
    Left = 128
    Top = 129
  end
  inherited ID: TVEditFormID
    Left = 80
    Top = 129
  end
end
