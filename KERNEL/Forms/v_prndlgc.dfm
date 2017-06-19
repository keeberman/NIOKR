inherited fmPrnDlgCom: TfmPrnDlgCom
  Left = 295
  Top = 286
  ClientHeight = 84
  PixelsPerInch = 96
  TextHeight = 13
  inherited paMiddle: TPanel
    Height = 50
    object laCriteria: TLabel
      Left = 14
      Top = 6
      Width = 70
      Height = 13
      Caption = '&Комментарий'
      FocusControl = edCriteria
    end
    object edCriteria: TEdit
      Left = 13
      Top = 21
      Width = 300
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = edCriteriaEnter
      OnExit = edCriteriaExit
    end
  end
  inherited paSecretBottom: TPanel
    Top = 50
  end
end
