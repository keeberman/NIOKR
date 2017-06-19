object fmCndEdit: TfmCndEdit
  Left = 243
  Top = 177
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Редактор условия'
  ClientHeight = 245
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object bvEdits: TBevel
    Left = 0
    Top = 10
    Width = 281
    Height = 191
    Shape = bsFrame
  end
  object laPoint: TLabel
    Left = 8
    Top = 16
    Width = 76
    Height = 13
    Caption = 'Одно значение'
  end
  object Bevel1: TBevel
    Left = 2
    Top = 56
    Width = 278
    Height = 9
    Shape = bsBottomLine
  end
  object Label1: TLabel
    Left = 8
    Top = 72
    Width = 93
    Height = 13
    Caption = 'Начало интервала'
  end
  object Label2: TLabel
    Left = 8
    Top = 120
    Width = 87
    Height = 13
    Caption = 'Конец интервала'
  end
  object bOk: TButton
    Left = 113
    Top = 165
    Width = 75
    Height = 25
    Caption = '&Применить'
    Default = True
    TabOrder = 0
    OnClick = bOkClick
  end
  object mePoint: TMaskEdit
    Left = 8
    Top = 32
    Width = 265
    Height = 21
    TabOrder = 1
    OnChange = MaskEditChange
    OnDblClick = ChoiceProcess
    OnEnter = MaskEditEnter
    OnExit = MaskEditExit
    OnKeyPress = EditKeyPress
  end
  object meStart: TMaskEdit
    Left = 8
    Top = 88
    Width = 265
    Height = 21
    TabOrder = 2
    OnChange = MaskEditChange
    OnDblClick = ChoiceProcess
    OnEnter = MaskEditEnter
    OnExit = MaskEditExit
    OnKeyPress = EditKeyPress
  end
  object meFinish: TMaskEdit
    Left = 8
    Top = 136
    Width = 265
    Height = 21
    TabOrder = 3
    OnChange = MaskEditChange
    OnDblClick = ChoiceProcess
    OnEnter = MaskEditEnter
    OnExit = MaskEditExit
    OnKeyPress = EditKeyPress
  end
  object bNew: TButton
    Left = 197
    Top = 165
    Width = 75
    Height = 25
    Caption = '&Очистить'
    TabOrder = 4
    OnClick = bNewClick
  end
  object bClose: TButton
    Left = 197
    Top = 213
    Width = 75
    Height = 25
    Caption = '&Закрыть'
    TabOrder = 5
    OnClick = bCloseClick
  end
end
