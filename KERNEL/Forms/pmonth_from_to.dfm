object fmPickMonth_From_TO: TfmPickMonth_From_TO
  Left = 555
  Top = 370
  BorderStyle = bsDialog
  Caption = '����� ������'
  ClientHeight = 154
  ClientWidth = 292
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object bbCancel: TBitBtn
    Left = 203
    Top = 123
    Width = 85
    Height = 25
    Caption = '&��������'
    TabOrder = 1
    Kind = bkCancel
  end
  object bbOk: TBitBtn
    Left = 99
    Top = 123
    Width = 85
    Height = 25
    Caption = '&�������'
    Default = True
    ModalResult = 1
    TabOrder = 0
    Glyph.Data = {
      BE060000424DBE06000000000000360400002800000024000000120000000100
      0800000000008802000000000000000000000001000000010000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
      0303030303030303030303030303030303030303030303030303030303030303
      03030303030303030303030303030303030303030303FF030303030303030303
      03030303030303040403030303030303030303030303030303F8F8FF03030303
      03030303030303030303040202040303030303030303030303030303F80303F8
      FF030303030303030303030303040202020204030303030303030303030303F8
      03030303F8FF0303030303030303030304020202020202040303030303030303
      0303F8030303030303F8FF030303030303030304020202FA0202020204030303
      0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
      040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
      03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
      FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
      0303030303030303030303FA0202020403030303030303030303030303F8FF03
      03F8FF03030303030303030303030303FA020202040303030303030303030303
      0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
      03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
      030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
      0202040303030303030303030303030303F8FF03F8FF03030303030303030303
      03030303FA0202030303030303030303030303030303F8FFF803030303030303
      030303030303030303FA0303030303030303030303030303030303F803030303
      0303030303030303030303030303030303030303030303030303030303030303
      0303}
    NumGlyphs = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 1
    Width = 292
    Height = 117
    BevelInner = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 40
      Top = 6
      Width = 41
      Height = 16
      Caption = '�����'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 208
      Top = 6
      Width = 23
      Height = 16
      Caption = '���'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 40
      Top = 57
      Width = 41
      Height = 16
      Caption = '�����'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 208
      Top = 57
      Width = 23
      Height = 16
      Caption = '���'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 28
      Top = 33
      Width = 7
      Height = 13
      Caption = 'C'
    end
    object Label6: TLabel
      Left = 22
      Top = 85
      Width = 14
      Height = 13
      Caption = '��'
    end
    object se_FromYear: TSpinEdit
      Left = 207
      Top = 24
      Width = 51
      Height = 24
      EditorEnabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      MaxValue = 4000
      MinValue = 1900
      ParentFont = False
      TabOrder = 1
      Value = 2007
    end
    object cbFromMonth: TComboBox
      Left = 39
      Top = 24
      Width = 145
      Height = 24
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      Items.Strings = (
        '������'
        '�������'
        '����'
        '������'
        '���'
        '����'
        '����'
        '������'
        '��������'
        '�������'
        '������'
        '�������')
    end
    object se_ToYear: TSpinEdit
      Left = 207
      Top = 75
      Width = 51
      Height = 24
      EditorEnabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      MaxValue = 4000
      MinValue = 1900
      ParentFont = False
      TabOrder = 2
      Value = 2007
    end
    object cbToMonth: TComboBox
      Left = 39
      Top = 75
      Width = 145
      Height = 24
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 3
      Items.Strings = (
        '������'
        '�������'
        '����'
        '������'
        '���'
        '����'
        '����'
        '������'
        '��������'
        '�������'
        '������'
        '�������')
    end
  end
end
