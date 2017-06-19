inherited fmWorkDept: TfmWorkDept
  Left = 169
  Top = 61
  Caption = 'fmWorkDept'
  PixelsPerInch = 96
  TextHeight = 13
  inherited paMiddle: TPanel
    object laVerhPodr: TLabel
      Left = 14
      Top = 8
      Width = 64
      Height = 13
      Caption = 'Укруп. подр.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object teVerhPodr: TDBText
      Left = 58
      Top = 26
      Width = 112
      Height = 17
      DataField = 'MIUPDR_NAIM'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object laPodr: TLabel
      Left = 14
      Top = 55
      Width = 80
      Height = 13
      Caption = 'Подразделение'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object tePodr: TDBText
      Left = 93
      Top = 74
      Width = 113
      Height = 17
      DataField = 'MIPODR_SNAIM'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object weUpdr: TVWatchEdit
      Left = 16
      Top = 24
      Width = 40
      Height = 22
      HelpContext = 110
      AutoSize = False
      DataField = 'MIUPDR_KOD'
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
      Glyph.Data = {
        96000000424D960000000000000076000000280000000A000000040000000100
        040000000000200000000000000000000000100000001000000000000000FFFF
        FF00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000111111111100
        0000001100110000000000110011000000001111111111000000}
      NumGlyphs = 1
      KeyField = 'KOD'
      HintField = 'PNAIM'
      OwnerTable = 'P'
      TableName = 'VUPDR'
    end
    object dePodr: TRxDBComboEdit
      Left = 15
      Top = 72
      Width = 76
      Height = 22
      ButtonHint = 'Открыть справочник|Нажмите кнопку для входа в справочник'
      DataField = 'MIPODR_KOD'
      DataSource = dsCurrent
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      MaxLength = 8
      NumGlyphs = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnButtonClick = ShowHandBook
      OnDblClick = ShowHandBook
      OnExit = dePodrExit
      OnKeyPress = dePodrKeyPress
      OnMouseMove = dePodrMouseMove
    end
  end
  inherited PopSwitch: TPopupMenu
    Left = 272
  end
end
