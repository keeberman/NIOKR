object fmRepDetails: TfmRepDetails
  Left = 500
  Top = 91
  Width = 212
  Height = 365
  BorderStyle = bsSizeToolWin
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lbObjects: TListBox
    Left = 0
    Top = 0
    Width = 204
    Height = 338
    Align = alClient
    ItemHeight = 13
    MultiSelect = True
    Sorted = True
    TabOrder = 0
    OnDblClick = lbObjectsDblClick
    OnKeyPress = lbObjectsKeyPress
  end
end
