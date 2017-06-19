object ENOfTabShDlg: TENOfTabShDlg
  Left = 312
  Top = 219
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Выбор закладок для развернутого узла'
  ClientHeight = 330
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 88
    Height = 13
    Caption = 'Список закладок'
  end
  object Label2: TLabel
    Left = 267
    Top = 8
    Width = 148
    Height = 13
    Caption = 'Список выбранных закладок'
  end
  object lbTabSheets: TTextListBox
    Left = 8
    Top = 24
    Width = 200
    Height = 250
    ItemHeight = 13
    MultiSelect = True
    Sorted = True
    TabOrder = 0
  end
  object btSel: TButton
    Left = 220
    Top = 38
    Width = 35
    Height = 35
    Caption = '>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btSelClick
  end
  object btAllSel: TButton
    Left = 220
    Top = 100
    Width = 35
    Height = 35
    Caption = '>>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btAllSelClick
  end
  object btUnSel: TButton
    Left = 220
    Top = 162
    Width = 35
    Height = 35
    Caption = '<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btUnSelClick
  end
  object btAllUnSel: TButton
    Left = 220
    Top = 224
    Width = 35
    Height = 35
    Caption = '<<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btAllUnSelClick
  end
  object lbSelTabSheets: TTextListBox
    Left = 267
    Top = 24
    Width = 200
    Height = 250
    ItemHeight = 13
    MultiSelect = True
    Sorted = True
    TabOrder = 5
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 282
    Width = 230
    Height = 40
    TabOrder = 6
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 238
    Top = 282
    Width = 229
    Height = 40
    TabOrder = 7
    Kind = bkCancel
  end
end
