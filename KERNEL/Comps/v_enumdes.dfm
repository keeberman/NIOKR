object EnumDesigner: TEnumDesigner
  Left = 204
  Top = 132
  Width = 245
  Height = 219
  BorderStyle = bsSizeToolWin
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1087#1080#1089#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDefaultPosOnly
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbText: TListBox
    Left = 0
    Top = 0
    Width = 237
    Height = 152
    Align = alClient
    ItemHeight = 13
    PopupMenu = pmOper
    TabOrder = 0
    OnDblClick = lbTextDblClick
  end
  object rgUnion: TRadioGroup
    Left = 0
    Top = 152
    Width = 237
    Height = 33
    Align = alBottom
    Caption = #1057#1086#1102#1079
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1080#1083#1080
      #1080)
    TabOrder = 1
    OnClick = rgUnionClick
  end
  object pmOper: TPopupMenu
    OnPopup = pmOperPopup
    Left = 112
    Top = 40
    object vpDelete: TMenuItem
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      ShortCut = 46
      OnClick = MenuItemsClick
    end
    object vpEdit: TMenuItem
      Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 115
      OnClick = EditItemClick
    end
    object vpAdd: TMenuItem
      Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnClick = AddItemClick
    end
    object vpDelAll: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' &'#1074#1089#1077
      ShortCut = 16430
      OnClick = MenuItemsClick
    end
  end
end
