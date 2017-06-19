inherited fmExpandedTreeTopology: TfmExpandedTreeTopology
  Top = 108
  Height = 514
  Caption = 'fmExpandedTreeTopology'
  PixelsPerInch = 96
  TextHeight = 13
  inherited paMiddle: TPanel
    Height = 453
    inherited Splitter: TSplitter
      Height = 451
    end
    inherited paControl: TPanel
      Height = 451
      inherited pcMain: TPageControl
        Height = 451
        OnChange = pcMainChange
        OnChanging = pcMainChanging
        inherited tsList: TTabSheet
          inherited DBGrid: TRxDBGrid
            Height = 423
          end
        end
      end
    end
    inherited paExplorer: TPanel
      Height = 451
      inherited spExplorer: TSplitter
        Top = 368
      end
      inherited TreeView: TTreeView
        Height = 368
      end
      inherited paProc: TPanel
        Top = 371
      end
    end
  end
  inherited paSecretBottom: TPanel
    Top = 453
  end
end
