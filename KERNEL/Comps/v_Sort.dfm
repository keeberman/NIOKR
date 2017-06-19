object fmSort: TfmSort
  Left = 214
  Top = 141
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Упорядочить записи'
  ClientHeight = 347
  ClientWidth = 424
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SrcLabel: TLabel
    Left = 8
    Top = 8
    Width = 145
    Height = 16
    AutoSize = False
    Caption = '&Все поля:'
    FocusControl = SrcList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object DstLabel: TLabel
    Left = 231
    Top = 8
    Width = 69
    Height = 16
    AutoSize = False
    Caption = '&Сортировка'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object IncludeBtn: TSpeedButton
    Left = 199
    Top = 32
    Width = 24
    Height = 24
    Caption = '>'
    Enabled = False
    OnClick = IncludeBtnClick
  end
  object IncAllBtn: TSpeedButton
    Left = 199
    Top = 64
    Width = 24
    Height = 24
    Caption = '>>'
    Enabled = False
    OnClick = IncAllBtnClick
  end
  object ExcludeBtn: TSpeedButton
    Left = 199
    Top = 96
    Width = 24
    Height = 24
    Caption = '<'
    Enabled = False
    OnClick = ExcludeBtnClick
  end
  object ExAllBtn: TSpeedButton
    Left = 199
    Top = 128
    Width = 24
    Height = 24
    Caption = '<<'
    Enabled = False
    OnClick = ExcAllBtnClick
  end
  object UpBtn: TSpeedButton
    Left = 351
    Top = 2
    Width = 20
    Height = 20
    Hint = 'Переместить строку вверх|'
    Enabled = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
      3333333333777F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
      3333333777737777F333333099999990333333373F3333373333333309999903
      333333337F33337F33333333099999033333333373F333733333333330999033
      3333333337F337F3333333333099903333333333373F37333333333333090333
      33333333337F7F33333333333309033333333333337373333333333333303333
      333333333337F333333333333330333333333333333733333333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = UpDownClick
  end
  object DownBtn: TSpeedButton
    Left = 371
    Top = 2
    Width = 20
    Height = 20
    Hint = 'Переместить строку вниз|'
    Enabled = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
      333333333337F33333333333333033333333333333373F333333333333090333
      33333333337F7F33333333333309033333333333337373F33333333330999033
      3333333337F337F33333333330999033333333333733373F3333333309999903
      333333337F33337F33333333099999033333333373333373F333333099999990
      33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333309033333333333337F7F333333333333090333
      33333333337F7F33333333333300033333333333337773333333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = UpDownClick
  end
  object OKBtn: TButton
    Left = 179
    Top = 272
    Width = 75
    Height = 25
    Caption = '&Готово'
    Default = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 259
    Top = 272
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Отменить'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
  end
  object HelpBtn: TButton
    Left = 339
    Top = 272
    Width = 75
    Height = 25
    Caption = '&Помощь'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = HelpBtnClick
  end
  object SrcList: TTextListBox
    Left = 8
    Top = 24
    Width = 181
    Height = 237
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    MultiSelect = True
    ParentFont = False
    Sorted = True
    TabOrder = 3
    OnDblClick = SrcListDblClick
  end
  object paHelp: TPanel
    Left = 0
    Top = 305
    Width = 424
    Height = 42
    Align = alBottom
    BevelOuter = bvLowered
    Enabled = False
    TabOrder = 4
    Visible = False
    object chHelp: TCheckBox
      Left = 20
      Top = 13
      Width = 345
      Height = 14
      Caption = '- порядок по убыванию'
      Checked = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
    end
  end
  object DstList: TRxCheckListBox
    Left = 232
    Top = 24
    Width = 181
    Height = 237
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 5
    OnDblClick = DstListDblClick
    OnDragDrop = DstListDragDrop
    OnDragOver = DstListDragOver
    InternalVersion = 202
  end
end
