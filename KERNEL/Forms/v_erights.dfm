inherited fmExpRights: TfmExpRights
  PixelsPerInch = 96
  TextHeight = 17
  inherited paMiddle: TPanel
    object tcRights: TTabControl
      Left = 1
      Top = 1
      Width = 623
      Height = 397
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Tabs.Strings = (
        '&Обычный'
        '&Полный')
      TabIndex = 0
      OnChange = tcRightsChange
      OnChanging = tcRightsChanging
    end
  end
end
