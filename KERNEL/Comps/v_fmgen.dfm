object fmFormGenerator: TfmFormGenerator
  Left = 390
  Top = 167
  Width = 444
  Height = 641
  BorderIcons = [biSystemMenu]
  Caption = 'FormGenerator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object paTop: TPanel
    Left = 0
    Top = 0
    Width = 428
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object laDataSet: TLabel
      Left = 16
      Top = 14
      Width = 39
      Height = 13
      Caption = 'DataSet'
    end
    object laPanel: TLabel
      Left = 256
      Top = 14
      Width = 18
      Height = 13
      Caption = 'Box'
    end
    object cbDataSet: TComboBox
      Left = 64
      Top = 8
      Width = 169
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbDataSetChange
    end
    object cbPanel: TComboBox
      Left = 288
      Top = 8
      Width = 137
      Height = 21
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object DBGrid: TRxDBGrid
    Left = 0
    Top = 35
    Width = 428
    Height = 534
    Align = alClient
    DataSource = dsMap
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Field'
        Visible = True
      end
      item
        DropDownRows = 11
        Expanded = False
        FieldName = 'Control'
        PickList.Strings = (
          'TDBText'
          'TVDBEMath'
          'TVDBEditChar'
          'TVDBERus'
          'TVDBEDate'
          'TVWatchEdit'
          'TrxDBLookUpCombo'
          'TDBRadioGroup'
          'TDBCheckBox'
          'TDBMemo'
          'TDBEdit'
          'TDBListBox'
          'TDBLookUpListBox'
          'TDBLookUpComboBox')
        Width = 116
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Panel'
        Width = 108
        Visible = True
      end>
  end
  object paBottom: TPanel
    Left = 0
    Top = 569
    Width = 428
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object bRun: TButton
      Left = 260
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Run'
      TabOrder = 0
      OnClick = bRunClick
    end
    object bClose: TButton
      Left = 345
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 1
    end
    object nvMap: TDBNavigator
      Left = 8
      Top = 5
      Width = 240
      Height = 25
      DataSource = dsMap
      TabOrder = 2
    end
  end
  object taMap: TRxMemoryData
    AutoCalcFields = False
    FieldDefs = <>
    Left = 360
    Top = 48
    object taMapField: TStringField
      DisplayWidth = 25
      FieldName = 'Field'
      Size = 255
    end
    object taMapcontrol: TStringField
      DisplayWidth = 18
      FieldName = 'Control'
      Size = 255
    end
    object taMapBox: TStringField
      DisplayWidth = 16
      FieldName = 'Box'
      Size = 255
    end
  end
  object dsMap: TDataSource
    DataSet = taMap
    Left = 320
    Top = 48
  end
end
