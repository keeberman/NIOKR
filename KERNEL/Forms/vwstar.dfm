inherited fmStarTopology: TfmStarTopology
  Left = 185
  Top = 574
  Width = 481
  Height = 414
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'fmStarTopology'
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 473
    OnEnter = paTopEnter
  end
  inherited paMiddle: TPanel
    Width = 473
    Height = 312
    BevelOuter = bvNone
    object pcMain: TPageControl
      Left = 0
      Top = 0
      Width = 473
      Height = 312
      ActivePage = tsCentre
      Align = alClient
      TabOrder = 0
      OnChange = pcMainChange
      OnChanging = pcMainChanging
      OnDrawTab = pcMainDrawTab
      OnEnter = pcMainEnter
      object tsCentre: TTabSheet
        Caption = 'tsCentre'
        object DBGridMain: TRxDBGrid
          Left = 0
          Top = 0
          Width = 465
          Height = 284
          Align = alClient
          DataSource = dsCentre
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnMouseMove = GridMouseMove
          OnTitleClick = GridTitleClick
        end
      end
    end
  end
  inherited paSecretBottom: TPanel
    Top = 353
    Width = 473
    inherited paBottom: TPanel
      Width = 473
      inherited paRightBottom: TPanel
        Left = 130
        Width = 342
        inherited bbCancel: TBitBtn
          Left = 22
        end
        inherited bbOK: TBitBtn
          Left = 130
        end
        inherited bbView: TBitBtn
          Left = 235
          ModalResult = 0
          Visible = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
            33333337777FF377FF3333993370739993333377FF373F377FF3399993000339
            993337777F777F3377F3393999707333993337F77737333337FF993399933333
            399377F3777FF333377F993339903333399377F33737FF33377F993333707333
            399377F333377FF3377F993333101933399377F333777FFF377F993333000993
            399377FF3377737FF7733993330009993933373FF3777377F7F3399933000399
            99333773FF777F777733339993707339933333773FF7FFF77333333999999999
            3333333777333777333333333999993333333333377777333333}
        end
      end
    end
  end
  inherited PopSwitch: TPopupMenu
    Left = 152
    Top = 9
  end
  object dsCentre: TDataSource
    OnDataChange = dsCentreDataChange
    Left = 112
    Top = 8
  end
end
