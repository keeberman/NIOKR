object fmUserPassword: TfmUserPassword
  Left = 239
  Top = 179
  ActiveControl = meOrigin
  BorderStyle = bsDialog
  Caption = 'Ввод пароля'
  ClientHeight = 96
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 209
    Height = 81
    Shape = bsFrame
  end
  object laPassword: TLabel
    Left = 16
    Top = 24
    Width = 41
    Height = 13
    Caption = '&Пароль:'
    FocusControl = meOrigin
  end
  object laConfirm: TLabel
    Left = 16
    Top = 56
    Width = 84
    Height = 13
    Caption = 'П&одтверждение:'
    FocusControl = meConfirm
  end
  object OKBtn: TButton
    Left = 228
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 228
    Top = 38
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Отменить'
    ModalResult = 2
    TabOrder = 1
  end
  object meOrigin: TMaskEdit
    Left = 112
    Top = 21
    Width = 91
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    OnKeyPress = MaskKeyPress
  end
  object meConfirm: TMaskEdit
    Left = 112
    Top = 53
    Width = 91
    Height = 21
    MaxLength = 10
    PasswordChar = '*'
    TabOrder = 3
    OnKeyPress = MaskKeyPress
  end
end
