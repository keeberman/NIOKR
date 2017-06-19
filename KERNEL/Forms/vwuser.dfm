inherited fmMiPolz: TfmMiPolz
  Left = 285
  Top = 144
  Caption = 'fmMiPolz'
  ClientHeight = 206
  ClientWidth = 357
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 357
    Height = 0
    Visible = False
  end
  inherited paMiddle: TPanel
    Top = 0
    Width = 357
    Height = 172
    object laUserName: TLabel
      Left = 15
      Top = 7
      Width = 95
      Height = 16
      Caption = 'Пользователь'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object laOracle: TLabel
      Left = 15
      Top = 63
      Width = 84
      Height = 16
      Caption = 'ORACLE-Имя'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object laPrivilege: TLabel
      Left = 15
      Top = 117
      Width = 82
      Height = 16
      Caption = 'Полномочия'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object tePrivilege: TDBText
      Left = 59
      Top = 138
      Width = 286
      Height = 17
      DataField = 'MIROL_NAIM'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object deUser: TVDBERus
      Left = 17
      Top = 25
      Width = 328
      Height = 23
      DataField = 'PNAIM'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      TabOrder = 0
      RusCase = True
    end
    object deOracle: TVDBERus
      Left = 17
      Top = 81
      Width = 170
      Height = 23
      CharCase = ecUpperCase
      DataField = 'ORANAIM'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      TabOrder = 1
      OnKeyPress = deOracleKeyPress
      RusCase = False
    end
    object wePrivilege: TVWatchEdit
      Left = 16
      Top = 135
      Width = 41
      Height = 23
      AutoSize = False
      DataField = 'MIROL_KOD'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      ParentShowHint = False
      TabOrder = 2
      Glyph.Data = {
        96000000424D960000000000000076000000280000000A000000040000000100
        0400000000002000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
      NumGlyphs = 1
      KeyField = 'KOD'
      HintField = 'PNAIM'
      OwnerTable = 'P'
      TableName = 'MIROL'
    end
  end
  inherited paSecretBottom: TPanel
    Top = 172
    Width = 357
    inherited paBottom: TPanel
      Width = 357
      inherited paRightBottom: TPanel
        Left = 110
      end
    end
  end
  inherited dsCurrent: TDataSource
    Left = 280
    Top = 65528
  end
  inherited PopSwitch: TPopupMenu
    Left = 248
    Top = 65529
  end
  inherited ID: TVEditFormID
    Left = 216
    Top = 65529
  end
  object oqDDL: TOracleQuery
    Session = dmGlobal.seOracle
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Cursor = crSQLWait
    StringFieldsOnly = False
    Threaded = False
    ThreadSynchronized = True
    Left = 216
    Top = 56
  end
end
