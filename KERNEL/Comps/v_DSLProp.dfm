object DSLPropDlg: TDSLPropDlg
  Left = 372
  Top = 228
  ActiveControl = SrcList
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'DatasetList Property Editor'
  ClientHeight = 226
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = ListClick
  OnCreate = FormCreate
  OnShow = ListClick
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 7
    Width = 384
    Height = 170
    ParentShowHint = False
    ShowHint = True
  end
  object SrcLabel: TLabel
    Left = 12
    Top = 12
    Width = 88
    Height = 13
    Caption = 'Available Datasets'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DstLabel: TLabel
    Left = 216
    Top = 12
    Width = 53
    Height = 13
    Caption = 'DatasetList'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object SrcList: TTextListBox
    Left = 12
    Top = 30
    Width = 164
    Height = 131
    DragMode = dmAutomatic
    ItemHeight = 13
    MultiSelect = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = ListClick
    OnDblClick = IncBtnClick
    OnDragDrop = SrcListDragDrop
    OnDragOver = SrcListDragOver
    OnKeyDown = SrcListKeyDown
  end
  object DstList: TTextListBox
    Left = 216
    Top = 30
    Width = 164
    Height = 131
    DragMode = dmAutomatic
    ItemHeight = 13
    MultiSelect = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = ListClick
    OnDblClick = ExclBtnClick
    OnDragDrop = DstListDragDrop
    OnDragOver = DstListDragOver
    OnKeyDown = DstListKeyDown
  end
  object IncBtn: TButton
    Left = 183
    Top = 32
    Width = 26
    Height = 26
    Caption = '>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = IncBtnClick
  end
  object IncAllBtn: TButton
    Left = 183
    Top = 64
    Width = 26
    Height = 26
    Caption = '>>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = IncAllBtnClick
  end
  object ExclBtn: TButton
    Left = 183
    Top = 97
    Width = 26
    Height = 26
    Caption = '<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = ExclBtnClick
  end
  object ExclAllBtn: TButton
    Left = 183
    Top = 129
    Width = 26
    Height = 26
    Caption = '<<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = ExclAllBtnClick
  end
  object OkBtn: TButton
    Left = 106
    Top = 191
    Width = 77
    Height = 25
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 6
  end
  object CancelBtn: TButton
    Left = 213
    Top = 191
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 7
  end
end
