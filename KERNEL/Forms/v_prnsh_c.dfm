inherited fmPrintShld: TfmPrintShld
  Left = 325
  Top = 165
  PixelsPerInch = 96
  TextHeight = 13
  inherited paMiddle: TPanel
    object laCriteria: TLabel
      Left = 7
      Top = 21
      Width = 70
      Height = 13
      Caption = '&Комментарий'
      FocusControl = edCriteria
    end
    object edCriteria: TEdit
      Left = 13
      Top = 41
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
end
