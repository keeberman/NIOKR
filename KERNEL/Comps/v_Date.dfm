object fmDate: TfmDate
  Left = 200
  Top = 121
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Выбор даты'
  ClientHeight = 289
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object paTop: TPanel
    Left = 0
    Top = 0
    Width = 250
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object laMonth: TLabel
      Left = 2
      Top = 2
      Width = 33
      Height = 13
      Caption = 'Месяц'
    end
    object laYear: TLabel
      Left = 138
      Top = 2
      Width = 18
      Height = 13
      Caption = 'Год'
    end
    object cbMonth: TComboBox
      Left = 12
      Top = 17
      Width = 76
      Height = 21
      DropDownCount = 12
      ItemHeight = 13
      TabOrder = 0
      Text = 'Январь'
      OnChange = cbMonthChange
      OnKeyPress = cbMonthKeyPress
      Items.Strings = (
        'Январь'
        'Февраль'
        'Март'
        'Апрель'
        'Май'
        'Июнь'
        'Июль'
        'Август'
        'Сентябрь'
        'Октябрь'
        'Ноябрь'
        'Декабрь')
    end
    object seYear: TSpinEdit
      Left = 147
      Top = 17
      Width = 53
      Height = 22
      MaxLength = 4
      MaxValue = 2100
      MinValue = 1900
      TabOrder = 1
      Value = 1900
      OnExit = seYearExit
    end
  end
  object paBottom: TPanel
    Left = 0
    Top = 256
    Width = 250
    Height = 33
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 2
    object bOk: TBitBtn
      Left = 26
      Top = 4
      Width = 85
      Height = 25
      Caption = '&Применить'
      TabOrder = 0
      OnClick = bOkClick
      Kind = bkOK
    end
    object bCancel: TBitBtn
      Left = 142
      Top = 4
      Width = 85
      Height = 25
      Caption = '&Отменить'
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object paCenter: TPanel
    Left = 0
    Top = 43
    Width = 250
    Height = 213
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 1
    object Calendar: TCalendar
      Left = 2
      Top = 2
      Width = 246
      Height = 209
      Align = alClient
      BorderStyle = bsNone
      StartOfWeek = 1
      TabOrder = 0
      UseCurrentDate = False
    end
  end
end
