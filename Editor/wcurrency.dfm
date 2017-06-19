inherited fmCurrency: TfmCurrency
  Left = 271
  Top = 234
  Caption = 'fmCurrency'
  ClientHeight = 248
  ClientWidth = 425
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 425
  end
  inherited paMiddle: TPanel
    Width = 425
    Height = 173
    object Label1: TLabel
      Left = 29
      Top = 11
      Width = 77
      Height = 16
      Caption = 'Код валюты'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 29
      Top = 60
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
    object Label3: TLabel
      Left = 229
      Top = 11
      Width = 57
      Height = 16
      Caption = 'Код (ISO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 29
      Top = 107
      Width = 176
      Height = 16
      Caption = 'Приоритет использования'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 236
      Top = 107
      Width = 139
      Height = 16
      Caption = 'Унаследованный код'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object deCurrencyNo: TVDBEditChar
      Left = 29
      Top = 30
      Width = 113
      Height = 23
      DataField = 'CURRENCY_NO'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      TabOrder = 0
    end
    object deName: TVDBERus
      Left = 29
      Top = 78
      Width = 369
      Height = 23
      DataField = 'NAME'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      TabOrder = 1
      RusCase = True
    end
    object dePriority_use: TVDBEditChar
      Left = 29
      Top = 125
      Width = 121
      Height = 23
      DataField = 'PRIORITY_USE'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      TabOrder = 2
    end
    object deIso_name: TVDBERus
      Left = 229
      Top = 30
      Width = 121
      Height = 23
      DataField = 'ISO_NAME'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      TabOrder = 3
      RusCase = True
    end
    object deInherited_id: TVDBERus
      Left = 236
      Top = 125
      Width = 121
      Height = 23
      DataField = 'INHERITED_ID'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      TabOrder = 4
      RusCase = True
    end
  end
  inherited paSecretBottom: TPanel
    Top = 214
    Width = 425
    inherited paBottom: TPanel
      Width = 425
      inherited paRightBottom: TPanel
        Left = 178
      end
    end
  end
  inherited dsCurrent: TDataSource
    DataSet = dmGlobal.quCurrency
  end
  inherited PopSwitch: TPopupMenu
    Left = 112
    Top = 9
  end
end
