object fmAboutBoxBase: TfmAboutBoxBase
  Left = 200
  Top = 108
  BorderStyle = bsDialog
  Caption = '� ���������'
  ClientHeight = 232
  ClientWidth = 234
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 5
    Width = 217
    Height = 188
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object ProgramIcon: TImage
      Left = 8
      Top = 8
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        055449636F6E0000010002002020100000000000E80200002600000010101000
        00000000280100000E0300002800000020000000400000000100040000000000
        0002000000000000000000000000000000000000000000000000800000800000
        00808000800000008000800080800000C0C0C000808080000000FF0000FF0000
        00FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000030870000000000000000000000000008370087000000
        000000000000000000803777008700000000000000000000080F377777008700
        000000000000000080FF37777777008700000000000000080FFF377777777700
        8700000000000080FFFF377777777777007000000000080FFFFF377777FF7777
        77087000000080FFFFFF37777700FF777708000000080FFFFFFF3FF777770077
        770000000000FFFFFFFF333FF7777777770000000000FFFFFFF8B7B33FF77777
        770000000000FFFFFF877B7B733FF777770000000000FFFFF88FB7B7B7B33FF7
        770000000000FFFF8B8F7B7B7B7B733FF70000000000FFF8B78FB7B7B7B7B7B3
        3F0000000000FF877B8F7B7B7B7B7B7B030000000000F88FB78FFFB7B7B7B7B7
        0000000000008F8F7B8F77FF7B7B7B7B000000000000008FB78FFB77FFB7B7B7
        000000000000000FFF788FB788FF7B7B000000000000000F77FFB888B788FFB7
        000000000000000FFB77FF7B7B7B00FF00000000000000000FB700FFB7B70000
        000000000000000000000000FF7B000000000000000000000000000000FF0000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF
        FFF0FFFFFFE03FFFFFC00FFFFF8003FFFF0000FFFE00003FFC00001FF8000007
        F000000FE000001FE000001FE000001FE000001FE000001FE000001FE000001F
        E000001FE000007FE000007FF000007FFC00007FFC00007FFC00007FFE0004FF
        FF8C07FFFFFF07FFFFFFCFFFFFFFFFFFFFFFFFFF280000001000000020000000
        0100040000000000800000000000000000000000000000000000000000000000
        000080000080000000808000800000008000800080800000C0C0C00080808000
        0000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000
        0000000000000030000000000000003770000000000000377770000000000F37
        77FF70000000FF377700FF70000FFF3FF777007000FFFF333FF7777000FFF87B
        733FF77000FF88F7B7B33FF000F878FB7B7B733000F0F8FF787FB7000000FB88
        8B88FF000000FF707FB780000000000000FF00000000000000000000FFFF0000
        FC7F0000FC1F0000F8070000F0010000E0000000C00000008000000080000000
        80000000800000008001000080010000E0030000F1070000FF8F0000}
      Stretch = True
      IsControl = True
    end
    object ProductName: TLabel
      Left = 48
      Top = 8
      Width = 68
      Height = 13
      Caption = '��� "�����"'
      IsControl = True
    end
    object laVersion: TLabel
      Left = 48
      Top = 26
      Width = 40
      Height = 13
      Caption = '������ '
      IsControl = True
    end
    object Copyright: TLabel
      Left = 8
      Top = 69
      Width = 186
      Height = 26
      Caption = '��������� ���������� � ��������� ����� ���� �� "�������������"'
      WordWrap = True
      IsControl = True
    end
    object Comments: TLabel
      Left = 8
      Top = 132
      Width = 184
      Height = 13
      Caption = '���������� ������� (01710)-98-0-45'
      WordWrap = True
      IsControl = True
    end
    object City: TLabel
      Left = 8
      Top = 108
      Width = 151
      Height = 13
      Caption = '�. ���������, ��. �����-5,114'
      IsControl = True
    end
    object email: TLabel
      Left = 8
      Top = 156
      Width = 154
      Height = 13
      Caption = 'email: gvv@kali.belpak.minsk.by'
      WordWrap = True
      IsControl = True
    end
    object laDate: TLabel
      Left = 7
      Top = 46
      Width = 29
      Height = 13
      Caption = '���� '
      IsControl = True
    end
  end
  object OKButton: TButton
    Left = 77
    Top = 200
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
