inherited fmNSI20: TfmNSI20
  Caption = 'fmNSI20'
  ClientHeight = 156
  PixelsPerInch = 96
  TextHeight = 13
  inherited paMiddle: TPanel
    Height = 122
    inherited Label1: TLabel
      Top = 5
    end
    inherited Label2: TLabel
      Top = 6
    end
    inherited Label3: TLabel
      Top = 63
    end
    inherited deCode: TVDBEditChar
      Top = 25
    end
    inherited deShort: TVDBERus
      Top = 26
      Width = 162
      MaxLength = 20
    end
    inherited deFull: TVDBERus
      Top = 83
    end
  end
  inherited paSecretBottom: TPanel
    Top = 122
  end
end
