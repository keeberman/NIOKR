inherited fmMiIstFin: TfmMiIstFin
  Left = 560
  Top = 238
  Caption = 'fmMiIstFin'
  PixelsPerInch = 96
  TextHeight = 13
  inherited paMiddle: TPanel
    inherited Label1: TLabel
      Left = 9
    end
    inherited Label2: TLabel
      Left = 152
      Top = 13
    end
    inherited Label3: TLabel
      Left = 9
    end
    inherited deCode: TVDBEditChar
      Left = 10
      Width = 39
      MaxLength = 3
    end
    inherited deShort: TVDBERus
      Left = 155
      Top = 33
      Width = 220
      MaxLength = 20
    end
    inherited deFull: TVDBERus
      Left = 10
      Width = 365
      MaxLength = 40
    end
  end
  inherited dsCurrent: TDataSource
    Left = 88
    Top = 152
  end
  inherited ID: TVEditFormID
    Left = 120
    Top = 153
  end
end
