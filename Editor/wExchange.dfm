inherited fmExchange: TfmExchange
  Left = 591
  Top = 287
  Caption = #1050#1091#1088#1089#1099' '#1074#1072#1083#1102#1090' '#1076#1083#1103' '#1090#1077#1084#1087#1083#1072#1085#1072
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Height = 1
  end
  inherited paMiddle: TPanel
    Top = 1
    Height = 282
    object lblYear: TLabel
      Left = 16
      Top = 8
      Width = 18
      Height = 13
      Caption = #1043#1086#1076
    end
    object lblCurrency: TLabel
      Left = 80
      Top = 8
      Width = 38
      Height = 13
      Caption = #1042#1072#1083#1102#1090#1072
    end
    object lblRate: TLabel
      Left = 16
      Top = 50
      Width = 24
      Height = 13
      Caption = #1050#1091#1088#1089
    end
    object seYEAR: TSpinEdit
      Left = 16
      Top = 22
      Width = 50
      Height = 22
      MaxLength = 4
      MaxValue = 9999
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = seYEARChange
    end
    object deYear: TVDBEMath
      Left = 46
      Top = 22
      Width = 20
      Height = 21
      DataField = 'YEAR'
      DataSource = dsCurrent
      ParentShowHint = False
      TabOrder = 1
      Visible = False
      OnChange = deYearChange
    end
    object dblcbCurrency: TDBLookupComboBox
      Left = 80
      Top = 22
      Width = 150
      Height = 21
      DataField = 'LkCURRENCY'
      DataSource = dsCurrent
      TabOrder = 2
    end
    object deCurrency: TVDBEMath
      Left = 210
      Top = 22
      Width = 20
      Height = 21
      DataField = 'CURRENCY_NO'
      DataSource = dsCurrent
      ParentShowHint = False
      TabOrder = 3
      Visible = False
    end
    object deRate: TVDBEMath
      Left = 16
      Top = 64
      Width = 50
      Height = 21
      DataField = 'RATE'
      DataSource = dsCurrent
      ParentShowHint = False
      TabOrder = 4
    end
  end
  inherited dsCurrent: TDataSource
    DataSet = dmGlobal.quMiExchange
    Top = 120
  end
  inherited PopSwitch: TPopupMenu
    Left = 112
    Top = 121
  end
  inherited ID: TVEditFormID
    Left = 64
    Top = 121
  end
end
