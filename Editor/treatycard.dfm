inherited fmTreatyCard: TfmTreatyCard
  Left = 380
  Top = 145
  Width = 1416
  Height = 733
  BorderIcons = []
  Caption = #1042#1077#1076#1077#1085#1080#1077' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
  Position = poMainFormCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 1408
  end
  inherited paMiddle: TPanel
    Width = 1408
    Height = 665
    inherited Splitter: TSplitter
      Height = 663
    end
    inherited paControl: TPanel
      Width = 1280
      Height = 663
      inherited pcMain: TPageControl
        Width = 1280
        Height = 663
        ActivePage = tsAgreemStage
        inherited tsList: TTabSheet
          inherited DBGrid: TRxDBGrid
            Width = 1272
            Height = 637
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgMultiSelect]
            MultiSelect = True
            OnGetCellParams = DBGridGetCellParams
          end
        end
        object tsTreaty: TTabSheet
          Caption = 'tsTreaty'
          ImageIndex = 1
          object lblTrSubject: TLabel
            Left = 10
            Top = 73
            Width = 27
            Height = 13
            Caption = #1058#1077#1084#1072
          end
          object lblTrNDS: TLabel
            Left = 10
            Top = 36
            Width = 35
            Height = 13
            Caption = #1053#1044#1057' %'
          end
          object lblTrNDSSummpay: TLabel
            Left = 69
            Top = 36
            Width = 61
            Height = 13
            Caption = #1057#1091#1084#1084#1072' '#1053#1044#1057
          end
          object lblCreateSW: TLabel
            Left = 286
            Top = 36
            Width = 82
            Height = 13
            Caption = #1050#1086#1083' '#1089#1083' '#1042#1042#1045#1044#1045#1053
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object lblReworkSW: TLabel
            Left = 387
            Top = 36
            Width = 104
            Height = 13
            Caption = #1050#1086#1083' '#1089#1083' '#1044#1054#1056#1040#1041#1054#1058#1050#1040
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object lblCreateAllSW: TLabel
            Left = 508
            Top = 39
            Width = 70
            Height = 13
            Caption = 'lblCreateAllSW'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblReworkAllSW: TLabel
            Left = 508
            Top = 54
            Width = 76
            Height = 13
            Caption = 'lblReworkAllSW'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object paRDTreaty: TPanel
            Left = 0
            Top = 0
            Width = 1272
            Height = 35
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lblTrID: TLabel
              Left = 10
              Top = 0
              Width = 11
              Height = 13
              Caption = 'ID'
            end
            object deId: TVDBEMath
              Tag = 1
              Left = 10
              Top = 12
              Width = 45
              Height = 21
              TabStop = False
              DataField = 'ID'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              ParentShowHint = False
              TabOrder = 0
            end
            object ntbkTreatyAndSubject: TNotebook
              Left = 55
              Top = 0
              Width = 652
              Height = 35
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGreen
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object TPage
                Left = 0
                Top = 0
                Caption = #1044#1086#1075#1086#1074#1086#1088
                object lblTrNum: TLabel
                  Left = 14
                  Top = 0
                  Width = 34
                  Height = 13
                  Caption = #1053#1086#1084#1077#1088
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblThemaPlan: TLabel
                  Left = 148
                  Top = 0
                  Width = 59
                  Height = 13
                  Caption = #8470' '#1058#1077#1084#1087#1083#1072#1085
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblDateSign: TLabel
                  Left = 230
                  Top = 0
                  Width = 89
                  Height = 13
                  Caption = #1044#1072#1090#1072' '#1087#1086#1076#1087#1080#1089#1072#1085#1080#1103
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrDateFrom: TLabel
                  Left = 344
                  Top = 0
                  Width = 69
                  Height = 13
                  Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrDateTo: TLabel
                  Left = 442
                  Top = 0
                  Width = 87
                  Height = 13
                  Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrSummPay: TLabel
                  Left = 540
                  Top = 0
                  Width = 87
                  Height = 13
                  Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object deNum: TVDBEditChar
                  Left = 14
                  Top = 12
                  Width = 120
                  Height = 21
                  DataField = 'NUM'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 0
                end
                object deThemaPlan: TVDBEMath
                  Left = 148
                  Top = 12
                  Width = 68
                  Height = 21
                  DataField = 'THEME_PLAN_NUM'
                  DataSource = dsTreaty
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 1
                end
                object deDateSign: TVDBEDate
                  Left = 230
                  Top = 12
                  Width = 100
                  Height = 23
                  AutoSize = False
                  DataField = 'DATESIGN'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 2
                  Glyph.Data = {
                    36010000424D360100000000000076000000280000001C0000000C0000000100
                    040000000000C000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                    77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                    47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                    47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                    47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                    47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                    47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                  ButtonWidth = 21
                  NumGlyphs = 2
                end
                object deDateFrom: TVDBEDate
                  Left = 344
                  Top = 12
                  Width = 84
                  Height = 23
                  HelpContext = 120
                  AutoSize = False
                  DataField = 'DATEFROM'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 3
                  Glyph.Data = {
                    36010000424D360100000000000076000000280000001C0000000C0000000100
                    040000000000C000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                    77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                    47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                    47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                    47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                    47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                    47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                  ButtonWidth = 21
                  NumGlyphs = 2
                end
                object deDateTo: TVDBEDate
                  Left = 442
                  Top = 12
                  Width = 84
                  Height = 23
                  HelpContext = 120
                  AutoSize = False
                  DataField = 'DATETO'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 4
                  Glyph.Data = {
                    36010000424D360100000000000076000000280000001C0000000C0000000100
                    040000000000C000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                    77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                    47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                    47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                    47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                    47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                    47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                  ButtonWidth = 21
                  NumGlyphs = 2
                end
                object deSummPay: TVDBEMath
                  Left = 540
                  Top = 12
                  Width = 84
                  Height = 21
                  DataField = 'SUMMPAY'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  MaxLength = 24
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 5
                end
              end
              object TPage
                Left = 0
                Top = 0
                Caption = #1058#1077#1084#1072
                object lblThPlanNum: TLabel
                  Left = 14
                  Top = 0
                  Width = 59
                  Height = 13
                  Caption = #8470' '#1058#1077#1084#1087#1083#1072#1085
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblThPlanDateFrom: TLabel
                  Left = 96
                  Top = 0
                  Width = 69
                  Height = 13
                  Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblThPlanDateTo: TLabel
                  Left = 194
                  Top = 0
                  Width = 87
                  Height = 13
                  Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblThPlanSummPay: TLabel
                  Left = 292
                  Top = 0
                  Width = 87
                  Height = 13
                  Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblThPlanFirstYearSummPay: TLabel
                  Left = 393
                  Top = 0
                  Width = 94
                  Height = 13
                  Caption = #1057#1090#1086#1080#1084'. '#1074' '#1087#1077#1088#1074'. '#1075#1086#1076
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object deSubThemaPlan: TVDBEMath
                  Left = 14
                  Top = 12
                  Width = 68
                  Height = 21
                  DataField = 'THEME_PLAN_NUM'
                  DataSource = dsTreaty
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clGreen
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 0
                end
                object deSubDateFrom: TVDBEDate
                  Left = 96
                  Top = 12
                  Width = 84
                  Height = 23
                  HelpContext = 120
                  AutoSize = False
                  DataField = 'DATEFROM'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clGreen
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 1
                  Glyph.Data = {
                    36010000424D360100000000000076000000280000001C0000000C0000000100
                    040000000000C000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                    77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                    47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                    47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                    47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                    47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                    47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                  ButtonWidth = 21
                  NumGlyphs = 2
                end
                object deSubDateTo: TVDBEDate
                  Left = 194
                  Top = 12
                  Width = 84
                  Height = 23
                  HelpContext = 120
                  AutoSize = False
                  DataField = 'DATETO'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clGreen
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 2
                  Glyph.Data = {
                    36010000424D360100000000000076000000280000001C0000000C0000000100
                    040000000000C000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                    77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                    47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                    47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                    47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                    47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                    47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                  ButtonWidth = 21
                  NumGlyphs = 2
                end
                object deSubSummPay: TVDBEMath
                  Left = 292
                  Top = 12
                  Width = 84
                  Height = 21
                  DataField = 'SUMMPAY'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clGreen
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  MaxLength = 24
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 3
                end
                object deSubFirstYearSummPay: TVDBEMath
                  Left = 393
                  Top = 12
                  Width = 84
                  Height = 21
                  DataField = 'FIRST_YEAR_SUMMPAY'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clGreen
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  MaxLength = 24
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 4
                end
              end
            end
          end
          object gbAddons: TGroupBox
            Left = 10
            Top = 117
            Width = 519
            Height = 163
            Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object teChapter_snaim: TDBText
              Left = 57
              Top = 26
              Width = 200
              Height = 17
              DataField = 'CHAPTER_SNAIM'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object teAnnul_snaim: TDBText
              Left = 57
              Top = 60
              Width = 200
              Height = 17
              DataField = 'ANNUL_SNAIM'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblTrChapter: TLabel
              Left = 14
              Top = 11
              Width = 37
              Height = 13
              Caption = #1056#1072#1079#1076#1077#1083
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblAnnul_naim: TLabel
              Left = 14
              Top = 46
              Width = 99
              Height = 13
              Caption = #1042#1080#1076' '#1072#1085#1085#1091#1083#1080#1088#1086#1074#1072#1085#1080#1103
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblTrIstFin: TLabel
              Left = 262
              Top = 11
              Width = 137
              Height = 13
              Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object teIstFin_snaim: TDBText
              Left = 305
              Top = 24
              Width = 200
              Height = 17
              DataField = 'ISTFIN_SNAIM'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object tePayment_snaim: TDBText
              Left = 305
              Top = 60
              Width = 200
              Height = 17
              DataField = 'PAYMENT_SNAIM'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblTrPayment_snaim: TLabel
              Left = 262
              Top = 46
              Width = 59
              Height = 13
              Caption = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label1: TLabel
              Left = 14
              Top = 82
              Width = 166
              Height = 13
              Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1086#1087#1083#1072#1090#1099' '#1076#1086#1075#1086#1074#1086#1088#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object tePlatDocType: TDBText
              Left = 72
              Top = 100
              Width = 305
              Height = 17
              DataField = 'PD_NAME'
              DataSource = dsTreaty
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lbl1: TLabel
              Left = 12
              Top = 121
              Width = 80
              Height = 13
              Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
            object dbtxtMIPODR_SNAIM: TDBText
              Left = 94
              Top = 137
              Width = 419
              Height = 18
              DataField = 'MIPODR_SNAIM'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
            object weCHAPTER_KOD: TVWatchEdit
              Left = 14
              Top = 24
              Width = 40
              Height = 23
              AutoSize = False
              DataField = 'CHAPTER_KOD'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 2
              ParentFont = False
              ParentShowHint = False
              TabOrder = 0
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                0400000000002000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
              NumGlyphs = 1
              KeyField = 'KOD'
              HintField = 'SNAIM'
              OwnerTable = 'RN'
              TableName = 'MICHAPTER'
            end
            object weAnnul_kod: TVWatchEdit
              Tag = 1
              Left = 14
              Top = 58
              Width = 40
              Height = 23
              TabStop = False
              AutoSize = False
              DataField = 'ANNUL_KOD'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 2
              ParentFont = False
              ParentShowHint = False
              TabOrder = 3
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                0400000000002000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
              NumGlyphs = 1
              KeyField = 'KOD'
              HintField = 'SNAIM'
              OwnerTable = 'RN'
              TableName = 'MIANNUL'
            end
            object weIstFin_kod: TVWatchEdit
              Left = 262
              Top = 23
              Width = 40
              Height = 23
              AutoSize = False
              DataField = 'ISTFIN_KOD'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 2
              ParentFont = False
              ParentShowHint = False
              TabOrder = 1
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                0400000000002000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
              NumGlyphs = 1
              KeyField = 'KOD'
              HintField = 'SNAIM'
              OwnerTable = 'S'
              TableName = 'MIISTFIN'
            end
            object wePayment_kod: TVWatchEdit
              Left = 262
              Top = 58
              Width = 40
              Height = 23
              AutoSize = False
              DataField = 'PAYMENT_KOD'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 2
              ParentFont = False
              ParentShowHint = False
              TabOrder = 2
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                0400000000002000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
              NumGlyphs = 1
              KeyField = 'KOD'
              HintField = 'SNAIM'
              OwnerTable = 'RN'
              TableName = 'MIPAYMENT'
            end
            object wePlatDocType: TVWatchEdit
              Left = 14
              Top = 96
              Width = 51
              Height = 23
              TabStop = False
              AutoSize = False
              DataField = 'PLAT_DOC_TYPE'
              DataSource = dsTreaty
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 4
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                0400000000002000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
              NumGlyphs = 1
              KeyField = 'DOC_TYPE_NO'
              HintField = 'SNAME'
              OwnerTable = 'RN'
              TableName = 'MIPLATDOC'
            end
            object edtMIPODR_ID: TRxDBComboEdit
              Left = 12
              Top = 135
              Width = 80
              Height = 22
              ButtonHint = #1054#1090#1082#1088#1099#1090#1100' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082'|'#1053#1072#1078#1084#1080#1090#1077' '#1082#1085#1086#1087#1082#1091' '#1076#1083#1103' '#1074#1093#1086#1076#1072' '#1074' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082
              DataField = 'MIPODR_KOD'
              DataSource = dsTreaty
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              GlyphKind = gkEllipsis
              ButtonWidth = 16
              NumGlyphs = 1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 5
              OnButtonClick = ShowHandBook
              OnExit = deDeptExit
              OnKeyPress = deDeptKeyPress
              OnMouseMove = deDeptMouseMove
            end
          end
          object deSubject: TVDBEditChar
            Left = 10
            Top = 85
            Width = 631
            Height = 32
            DataField = 'SUBJECT'
            DataSource = dsTreaty
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            TabOrder = 1
            OnMouseMove = ShowHint
          end
          object ntbkTrearyStatus: TNotebook
            Left = 534
            Top = 124
            Width = 107
            Height = 126
            PageIndex = 1
            TabOrder = 3
            object TPage
              Left = 0
              Top = 0
              Caption = #1060#1080#1083#1100#1090#1088
              object rgFilter: TRadioGroup
                Tag = 1
                Left = 0
                Top = 0
                Width = 107
                Height = 86
                BiDiMode = bdLeftToRight
                Caption = #1057#1090#1072#1090#1091#1089
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemIndex = 2
                Items.Strings = (
                  #1074#1089#1077
                  #1090#1077#1084'. '#1087#1083#1072#1085
                  #1076#1077#1081#1089#1090#1074#1091#1102#1097#1080#1077
                  #1079#1072#1082#1088#1099#1090#1099#1077)
                ParentBiDiMode = False
                ParentFont = False
                TabOrder = 0
                OnClick = rgFilterClick
              end
            end
            object TPage
              Left = 0
              Top = 0
              Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
              object dbrgTreatyStatus: TDBRadioGroup
                Left = 0
                Top = 0
                Width = 107
                Height = 126
                Caption = #1057#1090#1072#1090#1091#1089
                DataField = 'STATUS'
                DataSource = dsTreaty
                Items.Strings = (
                  #1058#1077#1084#1072
                  #1044#1086#1075#1086#1074#1086#1088)
                TabOrder = 0
                Values.Strings = (
                  'P'
                  'O')
                OnChange = dbrgTreatyStatusChange
              end
            end
          end
          object ntbkTreaty: TNotebook
            Left = 0
            Top = 285
            Width = 641
            Height = 343
            Align = alCustom
            Anchors = [akLeft, akTop, akBottom]
            TabOrder = 4
            object TPage
              Left = 0
              Top = 0
              Caption = 'NORMAL'
              DesignSize = (
                641
                343)
              object lblTrSummary: TLabel
                Left = 14
                Top = 261
                Width = 54
                Height = 13
                Caption = #1040#1085#1085#1086#1090#1072#1094#1080#1103
              end
              object gbExec: TGroupBox
                Left = 0
                Top = 4
                Width = 631
                Height = 163
                Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                object lblTrExecBankAccount: TLabel
                  Left = 14
                  Top = 12
                  Width = 65
                  Height = 13
                  Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrExecCurrency: TLabel
                  Left = 14
                  Top = 48
                  Width = 38
                  Height = 13
                  Caption = #1042#1072#1083#1102#1090#1072
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object teExec_Currency_Name: TDBText
                  Left = 77
                  Top = 63
                  Width = 23
                  Height = 17
                  DataField = 'EXEC_CURRENCY_NAME'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object teExec_Bank_Name: TDBText
                  Left = 253
                  Top = 62
                  Width = 350
                  Height = 17
                  DataField = 'EXEC_BANK_NAME'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrExexFirm: TLabel
                  Left = 262
                  Top = 12
                  Width = 67
                  Height = 13
                  Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object teExec_Short_Name: TDBText
                  Left = 361
                  Top = 26
                  Width = 256
                  Height = 17
                  DataField = 'EXEC_SHORT_NAME'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrExecBank: TLabel
                  Left = 120
                  Top = 48
                  Width = 25
                  Height = 13
                  Caption = #1041#1072#1085#1082
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrBeneficiary: TLabel
                  Left = 14
                  Top = 84
                  Width = 213
                  Height = 13
                  Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103' ('#1073#1077#1085#1077#1092#1080#1094#1080#1072#1088#1072')'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrBank: TLabel
                  Left = 14
                  Top = 120
                  Width = 176
                  Height = 13
                  Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1073#1072#1085#1082#1072' '#1085#1072' '#1087#1083#1072#1090#1077#1078#1082#1077
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object LblTrNIOKR_Account: TLabel
                  Left = 262
                  Top = 120
                  Width = 63
                  Height = 13
                  Caption = #1053#1048#1054#1050#1056' '#1089#1095#1077#1090
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object weExec_Currency_No: TVWatchEdit
                  Left = 14
                  Top = 60
                  Width = 60
                  Height = 23
                  AutoSize = False
                  DataField = 'EXEC_CURRENCY_NO'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  MaxLength = 5
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 3
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    040000000000200000000000000000000000100000001000000000000000FFFF
                    FF00000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000111111111100
                    0000001100110000000000110011000000001111111111000000}
                  NumGlyphs = 1
                  KeyField = 'CURRENCY_NO'
                  HintField = 'NAME'
                  OwnerTable = 'S'
                  TableName = 'CURRENCY'
                end
                object weExec_Bank_Id: TVWatchEdit
                  Left = 120
                  Top = 60
                  Width = 130
                  Height = 23
                  AutoSize = False
                  DataField = 'EXEC_BANK_ID'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 2
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    0400000000002000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                    000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                  NumGlyphs = 1
                  KeyField = 'BANK_ID'
                  HintField = 'NAME'
                  OwnerTable = 'S'
                  TableName = 'BANK'
                  OnAcceptValue = weExec_Bank_IdAcceptValue
                end
                object weExec_Firm_No: TVWatchEdit
                  Left = 262
                  Top = 24
                  Width = 96
                  Height = 23
                  AutoSize = False
                  DataField = 'EXEC_FIRM_NO'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  MaxLength = 10
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 1
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    0400000000002000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                    000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                  NumGlyphs = 1
                  KeyField = 'FIRM_NO'
                  HintField = 'SHORT_NAME'
                  OwnerTable = 'S'
                  TableName = 'FIRM'
                end
                object weExec_Bank_Account: TVWatchEdit
                  Left = 14
                  Top = 24
                  Width = 234
                  Height = 23
                  AutoSize = False
                  DataField = 'EXEC_BANK_ACCOUNT'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 0
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    0400000000002000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                    000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                  NumGlyphs = 1
                  Master = weExec_Firm_No
                  KeyField = 'BANK_ACCOUNT'
                  HintField = 'BANK_ACCOUNT'
                  OwnerTable = 'S'
                  TableName = 'FIRM_ACCOUNT'
                end
                object weFirmPrBeneficiary: TDBEdit
                  Left = 14
                  Top = 96
                  Width = 603
                  Height = 23
                  DataField = 'NAME_BENEFICIARY'
                  DataSource = dsExecFirmProperty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 4
                end
                object weFirmPrBank: TVDBEditChar
                  Left = 14
                  Top = 132
                  Width = 234
                  Height = 23
                  DataField = 'BANK'
                  DataSource = dsExecFirmProperty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 5
                  OnMouseMove = ShowHint
                end
                object weFirmPrNIOKR_ACCOUNT: TVDBEditChar
                  Left = 262
                  Top = 132
                  Width = 355
                  Height = 23
                  DataField = 'NIOKR_ACCOUNT'
                  DataSource = dsExecFirmProperty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 6
                  OnMouseMove = ShowHint
                end
                object weTrBeneficiary: TDBEdit
                  Left = 14
                  Top = 97
                  Width = 603
                  Height = 21
                  DataField = 'NAME_BENEFICIARY'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 7
                end
                object weTrBank: TVDBEditChar
                  Left = 14
                  Top = 133
                  Width = 234
                  Height = 21
                  DataField = 'BANK'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 8
                  OnMouseMove = ShowHint
                end
                object weTrNIOKR_ACCOUNT: TVDBEditChar
                  Left = 262
                  Top = 133
                  Width = 355
                  Height = 21
                  DataField = 'NIOKR_ACCOUNT'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 9
                  OnMouseMove = ShowHint
                end
              end
              object gbCust: TGroupBox
                Left = 0
                Top = 171
                Width = 631
                Height = 88
                Caption = #1047#1072#1082#1072#1079#1095#1080#1082
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                object lblTrCustBankAccount: TLabel
                  Left = 14
                  Top = 12
                  Width = 65
                  Height = 13
                  Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrCustCurrency: TLabel
                  Left = 14
                  Top = 48
                  Width = 38
                  Height = 13
                  Caption = #1042#1072#1083#1102#1090#1072
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object teCust_Currency_Name: TDBText
                  Left = 77
                  Top = 62
                  Width = 23
                  Height = 17
                  DataField = 'CUST_CURRENCY_NAME'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object teCust_Bank_Name: TDBText
                  Left = 253
                  Top = 62
                  Width = 350
                  Height = 17
                  DataField = 'CUST_BANK_NAME'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrCustFirm: TLabel
                  Left = 262
                  Top = 12
                  Width = 67
                  Height = 13
                  Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object teCust_Short_Name: TDBText
                  Left = 361
                  Top = 26
                  Width = 256
                  Height = 17
                  DataField = 'CUST_SHORT_NAME'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object lblTrCustBank: TLabel
                  Left = 120
                  Top = 48
                  Width = 25
                  Height = 13
                  Caption = #1041#1072#1085#1082
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object weCust_Currency_No: TVWatchEdit
                  Left = 14
                  Top = 60
                  Width = 60
                  Height = 23
                  AutoSize = False
                  DataField = 'CUST_CURRENCY_NO'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  MaxLength = 5
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 3
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    040000000000200000000000000000000000100000001000000000000000FFFF
                    FF00000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000111111111100
                    0000001100110000000000110011000000001111111111000000}
                  NumGlyphs = 1
                  KeyField = 'CURRENCY_NO'
                  HintField = 'NAME'
                  OwnerTable = 'S'
                  TableName = 'CURRENCY'
                end
                object weCust_Bank_Id: TVWatchEdit
                  Left = 120
                  Top = 60
                  Width = 130
                  Height = 23
                  AutoSize = False
                  DataField = 'CUST_BANK_ID'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 2
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    0400000000002000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                    000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                  NumGlyphs = 1
                  KeyField = 'BANK_ID'
                  HintField = 'NAME'
                  OwnerTable = 'S'
                  TableName = 'BANK'
                  OnAcceptValue = weCust_Bank_IdAcceptValue
                end
                object weCust_Firm_No: TVWatchEdit
                  Left = 262
                  Top = 24
                  Width = 96
                  Height = 23
                  AutoSize = False
                  DataField = 'CUST_FIRM_NO'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  MaxLength = 10
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 1
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    0400000000002000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                    000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                  NumGlyphs = 1
                  KeyField = 'FIRM_NO'
                  HintField = 'SHORT_NAME'
                  OwnerTable = 'S'
                  TableName = 'FIRM'
                end
                object weCust_Bank_Account: TVWatchEdit
                  Left = 14
                  Top = 24
                  Width = 234
                  Height = 23
                  AutoSize = False
                  DataField = 'CUST_BANK_ACCOUNT'
                  DataSource = dsTreaty
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 0
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    0400000000002000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                    000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                  NumGlyphs = 1
                  Master = weCust_Firm_No
                  KeyField = 'BANK_ACCOUNT'
                  HintField = 'BANK_ACCOUNT'
                  OwnerTable = 'S'
                  TableName = 'FIRM_ACCOUNT'
                end
              end
              object dmTrSummary: TDBMemo
                Left = 14
                Top = 276
                Width = 610
                Height = 55
                Anchors = [akLeft, akTop, akBottom]
                DataField = 'SUMMARY'
                DataSource = dsTreaty
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -19
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ScrollBars = ssVertical
                TabOrder = 2
              end
            end
            object TPage
              Left = 0
              Top = 0
              Caption = 'SUMMARY'
              object lblPlSammary: TLabel
                Left = 0
                Top = 6
                Width = 54
                Height = 13
                Caption = #1040#1085#1085#1086#1090#1072#1094#1080#1103
              end
              object dmSummary: TDBMemo
                Left = 0
                Top = 19
                Width = 631
                Height = 211
                DataField = 'SUMMARY'
                DataSource = dsTreaty
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -19
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
            end
          end
          object deTrNDS: TVDBEMath
            Left = 10
            Top = 49
            Width = 45
            Height = 21
            DataField = 'NDS'
            DataSource = dsTreaty
            ParentShowHint = False
            TabOrder = 5
          end
          object deTrNDSSummPay: TVDBEMath
            Left = 69
            Top = 49
            Width = 85
            Height = 21
            DataField = 'NDS_SUMMPAY'
            DataSource = dsTreaty
            ParentShowHint = False
            TabOrder = 6
          end
          object edCreateSW: TEdit
            Left = 286
            Top = 49
            Width = 85
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
          end
          object edReworkSW: TEdit
            Left = 387
            Top = 49
            Width = 85
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object btnCorrTrNDS: TButton
            Left = 169
            Top = 48
            Width = 75
            Height = 25
            Caption = #1050#1086#1088#1088#1077#1090'. '#1053#1044#1057
            TabOrder = 9
            OnClick = btnCorrTrNDSClick
          end
        end
        object tsAgreemStage: TTabSheet
          Caption = 'tsAgreemStage'
          ImageIndex = 4
          object lblAgrStReporting: TLabel
            Left = 842
            Top = 582
            Width = 181
            Height = 13
            Caption = #1054#1090#1095#1077#1090#1085#1086#1089#1090#1100' '#1087#1086' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084' '#1088#1072#1073#1086#1090#1099
          end
          object lblAgrStName: TLabel
            Left = 837
            Top = 540
            Width = 76
            Height = 13
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Visible = False
          end
          object pnl3: TPanel
            Left = 0
            Top = 0
            Width = 1272
            Height = 265
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lblAgrStNDS: TLabel
              Left = 10
              Top = 37
              Width = 35
              Height = 13
              Caption = #1053#1044#1057' %'
            end
            object lblAgrStNDSSummpay: TLabel
              Left = 69
              Top = 37
              Width = 61
              Height = 13
              Caption = #1057#1091#1084#1084#1072' '#1053#1044#1057
            end
            object lblAgrSt_SW: TLabel
              Left = 170
              Top = 37
              Width = 60
              Height = 13
              Caption = 'lblAgrSt_SW'
              Visible = False
            end
            object lblAgrStDateFrom: TLabel
              Left = 120
              Top = 0
              Width = 69
              Height = 13
              Caption = #1053#1072#1095#1072#1083#1086' '#1101#1090#1072#1087#1072
            end
            object lblAgrStDateTo: TLabel
              Left = 232
              Top = 0
              Width = 87
              Height = 13
              Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1101#1090#1072#1087#1072
            end
            object lblAgrStNum: TLabel
              Left = 10
              Top = 0
              Width = 34
              Height = 13
              Caption = #1053#1086#1084#1077#1088
            end
            object lblAgrStSummPay: TLabel
              Left = 342
              Top = 0
              Width = 87
              Height = 13
              Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090
            end
            object deAgrStNDSSummPay: TVDBEMath
              Left = 69
              Top = 50
              Width = 85
              Height = 21
              DataField = 'NDS_SUMMPAY'
              DataSource = dsAgreemStage
              ParentShowHint = False
              TabOrder = 0
            end
            object deAgrStNDS: TVDBEMath
              Left = 10
              Top = 50
              Width = 45
              Height = 21
              DataField = 'NDS'
              DataSource = dsAgreemStage
              ParentShowHint = False
              TabOrder = 1
            end
            object deAgrStageSummPay: TVDBEMath
              Left = 342
              Top = 12
              Width = 181
              Height = 23
              DataField = 'SUMMPAY'
              DataSource = dsAgreemStage
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              MaxLength = 24
              ParentFont = False
              ParentShowHint = False
              TabOrder = 2
            end
            object deAgrStageNum: TVDBEditChar
              Left = 10
              Top = 12
              Width = 100
              Height = 23
              DataField = 'NUM'
              DataSource = dsAgreemStage
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 3
            end
            object deAgrStageDateTo: TVDBEDate
              Left = 232
              Top = 12
              Width = 100
              Height = 23
              HelpContext = 120
              AutoSize = False
              DataField = 'DATETO'
              DataSource = dsAgreemStage
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 4
              Glyph.Data = {
                36010000424D360100000000000076000000280000001C0000000C0000000100
                040000000000C000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
              ButtonWidth = 21
              NumGlyphs = 2
            end
            object deAgrStageDateFrom: TVDBEDate
              Left = 120
              Top = 12
              Width = 100
              Height = 23
              HelpContext = 120
              AutoSize = False
              DataField = 'DATEFROM'
              DataSource = dsAgreemStage
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 5
              Glyph.Data = {
                36010000424D360100000000000076000000280000001C0000000C0000000100
                040000000000C000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
              ButtonWidth = 21
              NumGlyphs = 2
            end
            object btnAgrSt_SW: TButton
              Left = 170
              Top = 50
              Width = 433
              Height = 21
              Caption = #1055#1045#1056#1045#1044#1040#1058#1068' '#1055#1051#1040#1058#1025#1046#1053#1067#1049' '#1044#1054#1050#1059#1052#1045#1053#1058' '#1042' '#1060#1048#1053#1040#1053#1057#1054#1042#1067#1049' '#1054#1058#1044#1045#1051' '#1053#1040' '#1055#1056#1054#1042#1045#1056#1050#1059
              TabOrder = 6
              Visible = False
              OnClick = btnSt_SWClick
            end
            object gbStageAddons: TGroupBox
              Left = 3
              Top = 72
              Width = 604
              Height = 190
              Caption = #1057#1076#1072#1095#1072' '#1101#1090#1072#1087#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 7
              object lblAgrStDatePay: TLabel
                Left = 187
                Top = 150
                Width = 72
                Height = 13
                Caption = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblAgrStDateAct: TLabel
                Left = 20
                Top = 12
                Width = 102
                Height = 13
                Caption = #1044#1072#1090#1072' '#1072#1082#1090#1072' '#1074#1099#1087'. '#1088#1072#1073'.'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblAgrStNumPay: TLabel
                Left = 14
                Top = 150
                Width = 132
                Height = 13
                Caption = #1053#1086#1084#1077#1088' '#1087#1083#1072#1090#1077#1078#1085#1086#1075#1086' '#1076#1086#1082'-'#1090#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object teAgrStagePmethod_name: TDBText
                Left = 364
                Top = 164
                Width = 210
                Height = 17
                DataField = 'PMETHOD_NAME'
                DataSource = dsAgreemStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object lblAgrStPMethod: TLabel
                Left = 314
                Top = 150
                Width = 80
                Height = 13
                Caption = #1060#1086#1088#1084#1072' '#1088#1072#1089#1095#1077#1090#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblAgrStNumAct: TLabel
                Left = 138
                Top = 12
                Width = 60
                Height = 13
                Caption = #1053#1086#1084#1077#1088' '#1072#1082#1090#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object deAgrStageDateAct: TVDBEDate
                Left = 21
                Top = 24
                Width = 100
                Height = 23
                HelpContext = 120
                AutoSize = False
                DataField = 'DATEACT'
                DataSource = dsAgreemStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                TabOrder = 0
                OnChange = DateEditChange
                OnExit = DateActExit
                Glyph.Data = {
                  36010000424D360100000000000076000000280000001C0000000C0000000100
                  040000000000C000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                  77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                  47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                  47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                  47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                  47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                  47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                ButtonWidth = 21
                NumGlyphs = 2
              end
              object deAgrStageDatePay: TVDBEDate
                Left = 187
                Top = 162
                Width = 100
                Height = 23
                HelpContext = 120
                AutoSize = False
                DataField = 'DATEPAY'
                DataSource = dsAgreemStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                TabOrder = 5
                OnChange = DateEditChange
                Glyph.Data = {
                  36010000424D360100000000000076000000280000001C0000000C0000000100
                  040000000000C000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                  77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                  47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                  47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                  47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                  47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                  47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                ButtonWidth = 21
                NumGlyphs = 2
              end
              object deArgStageNumPay: TVDBEditChar
                Left = 14
                Top = 162
                Width = 149
                Height = 23
                DataField = 'NUMPAY'
                DataSource = dsAgreemStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                TabOrder = 4
              end
              object weAgrStagePm_pmethod_no: TVWatchEdit
                Left = 314
                Top = 162
                Width = 45
                Height = 23
                AutoSize = False
                DataField = 'PM_PMETHOD_NO'
                DataSource = dsAgreemStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                MaxLength = 3
                ParentFont = False
                ParentShowHint = False
                TabOrder = 6
                Glyph.Data = {
                  96000000424D960000000000000076000000280000000A000000040000000100
                  0400000000002000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                  000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                NumGlyphs = 1
                KeyField = 'PMETHOD_NO'
                HintField = 'PMETHOD_NAME'
                OwnerTable = 'RN'
                TableName = 'PAYMENT_METHODS'
              end
              object gbAgrStageExec: TGroupBox
                Left = 7
                Top = 47
                Width = 590
                Height = 52
                Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
                object lblAgrStExecAccount: TLabel
                  Left = 14
                  Top = 12
                  Width = 65
                  Height = 13
                  Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object teAgrStageExec_Name: TDBText
                  Left = 221
                  Top = 26
                  Width = 350
                  Height = 17
                  DataField = 'EXEC_NAME'
                  DataSource = dsAgreemStage
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                end
                object weAgrStageExec_Bank_Account: TVWatchEdit
                  Left = 14
                  Top = 24
                  Width = 200
                  Height = 23
                  AutoSize = False
                  DataField = 'EXEC_BANK_ACCOUNT'
                  DataSource = dsAgreemStage
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 0
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    0400000000002000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                    000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                  NumGlyphs = 1
                  Master = weExec_Firm_No
                  KeyField = 'BANK_ACCOUNT'
                  HintField = 'BANK_ACCOUNT'
                  OwnerTable = 'S'
                  TableName = 'FIRM_ACCOUNT'
                end
              end
              object gbAgrStageCust: TGroupBox
                Left = 7
                Top = 99
                Width = 590
                Height = 52
                Caption = #1047#1072#1082#1072#1079#1095#1080#1082
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 3
                object lblAgrStCustBank: TLabel
                  Left = 14
                  Top = 12
                  Width = 65
                  Height = 13
                  Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object teAgrStageCust_Name: TDBText
                  Left = 221
                  Top = 26
                  Width = 350
                  Height = 17
                  DataField = 'CUST_NAME'
                  DataSource = dsAgreemStage
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                end
                object weAgrStageCust_Bank_Account: TVWatchEdit
                  Left = 14
                  Top = 24
                  Width = 200
                  Height = 23
                  AutoSize = False
                  DataField = 'CUST_BANK_ACCOUNT'
                  DataSource = dsAgreemStage
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 0
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    0400000000002000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                    000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                  NumGlyphs = 1
                  Master = weCust_Firm_No
                  KeyField = 'BANK_ACCOUNT'
                  HintField = 'BANK_ACCOUNT'
                  OwnerTable = 'S'
                  TableName = 'FIRM_ACCOUNT'
                end
              end
              object deAgrStageNumAct: TVDBEMath
                Left = 139
                Top = 24
                Width = 45
                Height = 23
                DataField = 'NUMACT'
                DataSource = dsAgreemStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                MaxLength = 3
                ParentFont = False
                ParentShowHint = False
                TabOrder = 1
              end
            end
          end
          object deAgrStageName: TVDBEditChar
            Left = 840
            Top = 554
            Width = 121
            Height = 23
            DataField = 'NAME'
            DataSource = dsAgreemStage
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            TabOrder = 1
            Visible = False
          end
          object pnl4: TPanel
            Left = 0
            Top = 265
            Width = 1272
            Height = 372
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 2
            object grpAgStReporting: TGroupBox
              Left = 0
              Top = 0
              Width = 608
              Height = 372
              Align = alLeft
              Caption = #1054#1090#1095#1105#1090#1085#1086#1089#1090#1100' '#1087#1086' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084' '#1088#1072#1073#1086#1090#1099
              TabOrder = 0
              object dmAgrStageReporting: TDBMemo
                Left = 2
                Top = 15
                Width = 604
                Height = 355
                Align = alClient
                Constraints.MinHeight = 50
                DataField = 'REPORTING'
                DataSource = dsAgreemStage
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -19
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ScrollBars = ssVertical
                TabOrder = 0
              end
            end
          end
        end
        object tsAgreem: TTabSheet
          Caption = 'tsAgreem'
          ImageIndex = 3
          object lblAgrSubject: TLabel
            Left = 10
            Top = 112
            Width = 27
            Height = 13
            Caption = #1058#1077#1084#1072
          end
          object lblAgrPayment: TLabel
            Left = 281
            Top = 74
            Width = 59
            Height = 13
            Caption = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object teAddPayment_snaim: TDBText
            Left = 323
            Top = 87
            Width = 214
            Height = 17
            DataField = 'PAYMENT_SNAIM'
            DataSource = dsAgreem
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
          end
          object teAddIstFin_snaim: TDBText
            Left = 53
            Top = 88
            Width = 220
            Height = 17
            DataField = 'ISTFIN_SNAIM'
            DataSource = dsAgreem
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
          end
          object lblAgrIstFin: TLabel
            Left = 10
            Top = 74
            Width = 137
            Height = 13
            Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblAgrNDS: TLabel
            Left = 10
            Top = 37
            Width = 35
            Height = 13
            Caption = #1053#1044#1057' %'
          end
          object lblAgrNDSSummpay: TLabel
            Left = 64
            Top = 37
            Width = 61
            Height = 13
            Caption = #1057#1091#1084#1084#1072' '#1053#1044#1057
          end
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 1272
            Height = 35
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lblAgrNum: TLabel
              Left = 10
              Top = 0
              Width = 34
              Height = 13
              Caption = #1053#1086#1084#1077#1088
            end
            object lblAgrDateSign: TLabel
              Left = 64
              Top = 0
              Width = 89
              Height = 13
              Caption = #1044#1072#1090#1072' '#1087#1086#1076#1087#1080#1089#1072#1085#1080#1103
            end
            object lblAgrDateTo: TLabel
              Left = 176
              Top = 0
              Width = 87
              Height = 13
              Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090
            end
            object lblAgrSummPay: TLabel
              Left = 287
              Top = 0
              Width = 87
              Height = 13
              Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090
            end
            object deAddNum: TVDBEMath
              Left = 10
              Top = 12
              Width = 41
              Height = 21
              DataField = 'NUM'
              DataSource = dsAgreem
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              MaxLength = 2
              ParentFont = False
              ParentShowHint = False
              TabOrder = 0
            end
            object deAddDateSign: TVDBEDate
              Left = 64
              Top = 12
              Width = 100
              Height = 23
              AutoSize = False
              DataField = 'DATESIGN'
              DataSource = dsAgreem
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 1
              Glyph.Data = {
                36010000424D360100000000000076000000280000001C0000000C0000000100
                040000000000C000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
              ButtonWidth = 21
              NumGlyphs = 2
            end
            object deAddDateTo: TVDBEDate
              Left = 176
              Top = 12
              Width = 100
              Height = 23
              HelpContext = 120
              AutoSize = False
              DataField = 'DATETO'
              DataSource = dsAgreem
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 2
              OnChange = DateEditChange
              Glyph.Data = {
                36010000424D360100000000000076000000280000001C0000000C0000000100
                040000000000C000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
              ButtonWidth = 21
              NumGlyphs = 2
            end
            object deAddSummPay: TVDBEMath
              Left = 287
              Top = 12
              Width = 181
              Height = 23
              DataField = 'SUMMPAY'
              DataSource = dsAgreem
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              MaxLength = 24
              ParentFont = False
              ParentShowHint = False
              TabOrder = 3
            end
          end
          object deAddSubject: TVDBEditChar
            Left = 10
            Top = 124
            Width = 590
            Height = 23
            DataField = 'SUBJECT'
            DataSource = dsAgreem
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            TabOrder = 3
            OnMouseMove = ShowHint
          end
          object weAddPayment_kod: TVWatchEdit
            Left = 280
            Top = 86
            Width = 40
            Height = 23
            AutoSize = False
            DataField = 'PAYMENT_KOD'
            DataSource = dsAgreem
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            ParentShowHint = False
            TabOrder = 2
            Glyph.Data = {
              96000000424D960000000000000076000000280000000A000000040000000100
              0400000000002000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
              000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
            NumGlyphs = 1
            KeyField = 'KOD'
            HintField = 'SNAIM'
            OwnerTable = 'RN'
            TableName = 'MIPAYMENT'
          end
          object weAddIstFin_kod: TVWatchEdit
            Left = 10
            Top = 86
            Width = 40
            Height = 23
            AutoSize = False
            DataField = 'ISTFIN_KOD'
            DataSource = dsAgreem
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            ParentShowHint = False
            TabOrder = 1
            Glyph.Data = {
              96000000424D960000000000000076000000280000000A000000040000000100
              0400000000002000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
              000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
            NumGlyphs = 1
            KeyField = 'KOD'
            HintField = 'SNAIM'
            OwnerTable = 'RN'
            TableName = 'MIISTFIN'
          end
          object deAgrNDSSummPay: TVDBEMath
            Left = 64
            Top = 50
            Width = 100
            Height = 21
            DataField = 'NDS_SUMMPAY'
            DataSource = dsAgreem
            ParentShowHint = False
            TabOrder = 4
          end
          object deAgrNDS: TVDBEMath
            Left = 10
            Top = 50
            Width = 41
            Height = 21
            DataField = 'NDS'
            DataSource = dsAgreem
            ParentShowHint = False
            TabOrder = 5
          end
          object btnCorrAgrNDS: TButton
            Left = 178
            Top = 48
            Width = 75
            Height = 25
            Caption = #1050#1086#1088#1088#1077#1090'. '#1053#1044#1057
            TabOrder = 6
            OnClick = btnCorrAgrNDSClick
          end
        end
        object tsTreatyStage: TTabSheet
          Caption = 'tsTreatyStage'
          ImageIndex = 4
          object lblTrStName: TLabel
            Left = 674
            Top = 470
            Width = 76
            Height = 13
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Visible = False
          end
          object lblTrStReporting: TLabel
            Left = 786
            Top = 480
            Width = 181
            Height = 13
            Caption = #1054#1090#1095#1077#1090#1085#1086#1089#1090#1100' '#1087#1086' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084' '#1088#1072#1073#1086#1090#1099
          end
          object deTrStageName: TVDBEditChar
            Left = 672
            Top = 446
            Width = 196
            Height = 23
            DataField = 'NAME'
            DataSource = dsTreatyStage
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            TabOrder = 0
            Visible = False
          end
          object pnl1: TPanel
            Left = 0
            Top = 267
            Width = 1272
            Height = 370
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object grpReporting: TGroupBox
              Left = 0
              Top = 0
              Width = 608
              Height = 370
              Align = alLeft
              Caption = #1054#1090#1095#1105#1090#1085#1086#1089#1090#1100' '#1087#1086' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084' '#1088#1072#1073#1086#1090#1099
              TabOrder = 0
              object dmTrStageReporting: TDBMemo
                Left = 2
                Top = 15
                Width = 604
                Height = 353
                Align = alClient
                Constraints.MinHeight = 50
                DataField = 'REPORTING'
                DataSource = dsTreatyStage
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -19
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                ScrollBars = ssVertical
                TabOrder = 0
              end
            end
          end
          object pnl2: TPanel
            Left = 0
            Top = 0
            Width = 1272
            Height = 267
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            object lblTrStNum: TLabel
              Left = 10
              Top = 0
              Width = 34
              Height = 13
              Caption = #1053#1086#1084#1077#1088
            end
            object lblTrStDateFrom: TLabel
              Left = 120
              Top = 0
              Width = 69
              Height = 13
              Caption = #1053#1072#1095#1072#1083#1086' '#1101#1090#1072#1087#1072
            end
            object lblTrStDateTo: TLabel
              Left = 232
              Top = 0
              Width = 87
              Height = 13
              Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1101#1090#1072#1087#1072
            end
            object lblTrStSummPay: TLabel
              Left = 342
              Top = 0
              Width = 87
              Height = 13
              Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090
            end
            object lblTrStNDSSummpay: TLabel
              Left = 69
              Top = 37
              Width = 61
              Height = 13
              Caption = #1057#1091#1084#1084#1072' '#1053#1044#1057
            end
            object lblTrStNDS: TLabel
              Left = 10
              Top = 37
              Width = 35
              Height = 13
              Caption = #1053#1044#1057' %'
            end
            object lblTrSt_SW: TLabel
              Left = 170
              Top = 37
              Width = 54
              Height = 13
              Caption = 'lblTrSt_SW'
              Visible = False
            end
            object deTrStageNum: TVDBEditChar
              Left = 10
              Top = 12
              Width = 100
              Height = 23
              DataField = 'NUM'
              DataSource = dsTreatyStage
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 0
            end
            object deTrStageDateTo: TVDBEDate
              Left = 232
              Top = 12
              Width = 100
              Height = 23
              HelpContext = 120
              AutoSize = False
              DataField = 'DATETO'
              DataSource = dsTreatyStage
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 1
              Glyph.Data = {
                36010000424D360100000000000076000000280000001C0000000C0000000100
                040000000000C000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
              ButtonWidth = 21
              NumGlyphs = 2
            end
            object deTrStageDateFrom: TVDBEDate
              Left = 120
              Top = 12
              Width = 100
              Height = 23
              HelpContext = 120
              AutoSize = False
              DataField = 'DATEFROM'
              DataSource = dsTreatyStage
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 2
              Glyph.Data = {
                36010000424D360100000000000076000000280000001C0000000C0000000100
                040000000000C000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
              ButtonWidth = 21
              NumGlyphs = 2
            end
            object deTrStageSummPay: TVDBEMath
              Left = 342
              Top = 12
              Width = 181
              Height = 23
              DataField = 'SUMMPAY'
              DataSource = dsTreatyStage
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              MaxLength = 24
              ParentFont = False
              ParentShowHint = False
              TabOrder = 3
            end
            object deTrStNDS: TVDBEMath
              Left = 10
              Top = 50
              Width = 45
              Height = 21
              DataField = 'NDS'
              DataSource = dsTreatyStage
              ParentShowHint = False
              TabOrder = 4
            end
            object deTrStNDSSummPay: TVDBEMath
              Left = 69
              Top = 50
              Width = 85
              Height = 21
              DataField = 'NDS_SUMMPAY'
              DataSource = dsTreatyStage
              ParentShowHint = False
              TabOrder = 5
            end
            object btnTrSt_SW: TButton
              Left = 170
              Top = 50
              Width = 433
              Height = 21
              Caption = #1055#1045#1056#1045#1044#1040#1058#1068' '#1055#1051#1040#1058#1025#1046#1053#1067#1049' '#1044#1054#1050#1059#1052#1045#1053#1058' '#1042' '#1060#1048#1053#1040#1053#1057#1054#1042#1067#1049' '#1054#1058#1044#1045#1051' '#1053#1040' '#1055#1056#1054#1042#1045#1056#1050#1059
              TabOrder = 6
              Visible = False
              OnClick = btnSt_SWClick
            end
            object GroupBox1: TGroupBox
              Left = 3
              Top = 71
              Width = 604
              Height = 194
              Caption = #1057#1076#1072#1095#1072' '#1101#1090#1072#1087#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 7
              object lblTrStDatePay: TLabel
                Left = 187
                Top = 150
                Width = 72
                Height = 13
                Caption = #1044#1072#1090#1072' '#1087#1083#1072#1090#1077#1078#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblTrStDateAct: TLabel
                Left = 21
                Top = 12
                Width = 102
                Height = 13
                Caption = #1044#1072#1090#1072' '#1072#1082#1090#1072' '#1074#1099#1087'. '#1088#1072#1073'.'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblTrStNumPay: TLabel
                Left = 14
                Top = 150
                Width = 132
                Height = 13
                Caption = #1053#1086#1084#1077#1088' '#1087#1083#1072#1090#1077#1078#1085#1086#1075#1086' '#1076#1086#1082'-'#1090#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object teTrStagePmethod_Name: TDBText
                Left = 364
                Top = 164
                Width = 207
                Height = 17
                DataField = 'PMETHOD_NAME'
                DataSource = dsTreatyStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object lblTrStPMethod: TLabel
                Left = 314
                Top = 150
                Width = 80
                Height = 13
                Caption = #1060#1086#1088#1084#1072' '#1088#1072#1089#1095#1077#1090#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblTrStNumAct: TLabel
                Left = 137
                Top = 12
                Width = 60
                Height = 13
                Caption = #1053#1086#1084#1077#1088' '#1072#1082#1090#1072
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object deTrStageDateAct: TVDBEDate
                Left = 21
                Top = 24
                Width = 100
                Height = 23
                HelpContext = 120
                AutoSize = False
                DataField = 'DATEACT'
                DataSource = dsTreatyStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                TabOrder = 0
                OnChange = DateEditChange
                OnExit = DateActExit
                Glyph.Data = {
                  36010000424D360100000000000076000000280000001C0000000C0000000100
                  040000000000C000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                  77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                  47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                  47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                  47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                  47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                  47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                ButtonWidth = 21
                NumGlyphs = 2
              end
              object deTrStageDatePay: TVDBEDate
                Left = 187
                Top = 162
                Width = 100
                Height = 23
                HelpContext = 120
                AutoSize = False
                DataField = 'DATEPAY'
                DataSource = dsTreatyStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                TabOrder = 5
                OnChange = DateEditChange
                Glyph.Data = {
                  36010000424D360100000000000076000000280000001C0000000C0000000100
                  040000000000C000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                  77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                  47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                  47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                  47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                  47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                  47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                ButtonWidth = 21
                NumGlyphs = 2
              end
              object deTrStageNumPay: TVDBEditChar
                Left = 14
                Top = 162
                Width = 149
                Height = 23
                DataField = 'NUMPAY'
                DataSource = dsTreatyStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                TabOrder = 4
              end
              object weTrStagePm_pmethod_no: TVWatchEdit
                Left = 314
                Top = 162
                Width = 45
                Height = 23
                AutoSize = False
                DataField = 'PM_PMETHOD_NO'
                DataSource = dsTreatyStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                MaxLength = 3
                ParentFont = False
                ParentShowHint = False
                TabOrder = 6
                Glyph.Data = {
                  96000000424D960000000000000076000000280000000A000000040000000100
                  0400000000002000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                  000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                NumGlyphs = 1
                KeyField = 'PMETHOD_NO'
                HintField = 'PMETHOD_NAME'
                OwnerTable = 'RN'
                TableName = 'PAYMENT_METHODS'
              end
              object GroupBox2: TGroupBox
                Left = 7
                Top = 47
                Width = 590
                Height = 52
                Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
                object lblTrStExecBankAccount: TLabel
                  Left = 14
                  Top = 12
                  Width = 65
                  Height = 13
                  Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object teTrStageExec_Name: TDBText
                  Left = 221
                  Top = 26
                  Width = 350
                  Height = 17
                  DataField = 'EXEC_NAME'
                  DataSource = dsTreatyStage
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                end
                object weTrStageExec_Bank_Account: TVWatchEdit
                  Left = 14
                  Top = 24
                  Width = 200
                  Height = 23
                  AutoSize = False
                  DataField = 'EXEC_BANK_ACCOUNT'
                  DataSource = dsTreatyStage
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 0
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    0400000000002000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                    000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                  NumGlyphs = 1
                  Master = weExec_Firm_No
                  KeyField = 'BANK_ACCOUNT'
                  HintField = 'BANK_ACCOUNT'
                  OwnerTable = 'S'
                  TableName = 'FIRM_ACCOUNT'
                end
              end
              object GroupBox3: TGroupBox
                Left = 7
                Top = 99
                Width = 590
                Height = 52
                Caption = #1047#1072#1082#1072#1079#1095#1080#1082
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 3
                object lblTrStCustBankAccount: TLabel
                  Left = 14
                  Top = 12
                  Width = 65
                  Height = 13
                  Caption = #1053#1086#1084#1077#1088' '#1089#1095#1077#1090#1072
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                end
                object teTrStageCust_Name: TDBText
                  Left = 221
                  Top = 26
                  Width = 350
                  Height = 17
                  DataField = 'CUST_NAME'
                  DataSource = dsTreatyStage
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                end
                object weTrStageCust_Bank_Account: TVWatchEdit
                  Left = 14
                  Top = 24
                  Width = 200
                  Height = 23
                  AutoSize = False
                  DataField = 'CUST_BANK_ACCOUNT'
                  DataSource = dsTreatyStage
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Courier New'
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  TabOrder = 0
                  Glyph.Data = {
                    96000000424D960000000000000076000000280000000A000000040000000100
                    0400000000002000000000000000000000001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                    000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
                  NumGlyphs = 1
                  Master = weCust_Firm_No
                  KeyField = 'BANK_ACCOUNT'
                  HintField = 'BANK_ACCOUNT'
                  OwnerTable = 'S'
                  TableName = 'FIRM_ACCOUNT'
                end
              end
              object deTrStageNumAct: TVDBEMath
                Left = 139
                Top = 24
                Width = 45
                Height = 23
                DataField = 'NUMACT'
                DataSource = dsTreatyStage
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Courier New'
                Font.Style = []
                MaxLength = 3
                ParentFont = False
                ParentShowHint = False
                TabOrder = 1
              end
            end
          end
        end
        object tsTrCurator: TTabSheet
          Caption = 'tsTrCurator'
          ImageIndex = 5
          object laTabNom: TLabel
            Left = 10
            Top = 0
            Width = 33
            Height = 13
            Hint = #1051#1080#1095#1085#1099#1081' '#1085#1086#1084#1077#1088'|'
            Caption = #1051#1080#1095'.'#8470
          end
          object lblCuratorBigDept: TLabel
            Left = 10
            Top = 73
            Width = 32
            Height = 13
            Caption = #1059#1055#1044#1056
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object teBigDept: TDBText
            Left = 54
            Top = 88
            Width = 147
            Height = 17
            DataField = 'MIUPDR_SNAIM'
            DataSource = dsTrCurator
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object tePodr: TDBText
            Left = 295
            Top = 88
            Width = 434
            Height = 17
            DataField = 'MIPODR_SNAIM'
            DataSource = dsTrCurator
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object teProf: TDBText
            Left = 66
            Top = 127
            Width = 307
            Height = 18
            DataField = 'MIPROF_SNAIM'
            DataSource = dsTrCurator
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
          end
          object laProf: TLabel
            Left = 10
            Top = 112
            Width = 31
            Height = 13
            Caption = #1055#1088#1086#1092'.'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object teFIO: TDBText
            Left = 88
            Top = 14
            Width = 307
            Height = 17
            DataField = 'FIO'
            DataSource = dsTrCurator
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object lblCuratorDept: TLabel
            Left = 212
            Top = 73
            Width = 26
            Height = 13
            Caption = #1055#1086#1076#1088
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object lblCuratorDefnaim: TLabel
            Left = 9
            Top = 37
            Width = 49
            Height = 13
            Caption = #1060#1072#1084#1080#1083#1080#1103
          end
          object lblCuratorDeiname: TLabel
            Left = 220
            Top = 37
            Width = 22
            Height = 13
            Caption = #1048#1084#1103
          end
          object lblCuratorDeonaim: TLabel
            Left = 430
            Top = 37
            Width = 47
            Height = 13
            Caption = #1054#1090#1095#1077#1089#1090#1074#1086
          end
          object weBigDept: TVWatchEdit
            Left = 10
            Top = 86
            Width = 41
            Height = 23
            AutoSize = False
            DataField = 'MIUPDR_KOD'
            DataSource = dsTrCurator
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            ParentShowHint = False
            TabOrder = 4
            Glyph.Data = {
              96000000424D960000000000000076000000280000000A000000040000000100
              040000000000200000000000000000000000100000001000000000000000FFFF
              FF00000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000111111111100
              0000001100110000000000110011000000001111111111000000}
            NumGlyphs = 1
            KeyField = 'KOD'
            HintField = 'PNAIM'
            OwnerTable = 'RN'
            TableName = 'VUPDR'
          end
          object deDept: TRxDBComboEdit
            Left = 212
            Top = 86
            Width = 80
            Height = 22
            ButtonHint = #1054#1090#1082#1088#1099#1090#1100' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082'|'#1053#1072#1078#1084#1080#1090#1077' '#1082#1085#1086#1087#1082#1091' '#1076#1083#1103' '#1074#1093#1086#1076#1072' '#1074' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082
            DataField = 'MIPODR_KOD'
            DataSource = dsTrCurator
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            GlyphKind = gkEllipsis
            ButtonWidth = 16
            NumGlyphs = 1
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnButtonClick = ShowHandBook
            OnExit = deDeptExit
            OnKeyPress = deDeptKeyPress
            OnMouseMove = deDeptMouseMove
          end
          object weJob: TVWatchEdit
            Left = 10
            Top = 125
            Width = 53
            Height = 23
            AutoSize = False
            DataField = 'MIPROF_KOD'
            DataSource = dsTrCurator
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            ParentShowHint = False
            TabOrder = 6
            Glyph.Data = {
              96000000424D960000000000000076000000280000000A000000040000000100
              040000000000200000000000000000000000100000001000000000000000FFFF
              FF00000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000111111111100
              0000001100110000000000110011000000001111111111000000}
            NumGlyphs = 1
            KeyField = 'KOD'
            HintField = 'PNAIM'
            OwnerTable = 'RN'
            TableName = 'VKPROF'
          end
          object weMirab_TabN: TVWatchEdit
            Left = 10
            Top = 12
            Width = 75
            Height = 23
            AutoSize = False
            DataField = 'MIRAB_TABN'
            DataSource = dsTrCurator
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Courier New'
            Font.Style = []
            MaxLength = 6
            ParentFont = False
            ParentShowHint = False
            TabOrder = 0
            Glyph.Data = {
              96000000424D960000000000000076000000280000000A000000040000000100
              040000000000200000000000000000000000100000001000000000000000FFFF
              FF00000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000111111111100
              0000001100110000000000110011000000001111111111000000}
            NumGlyphs = 1
            KeyField = 'MIRAB_TABN'
            HintField = 'FIO'
            OwnerTable = 'RN'
            TableName = 'VIRAB'
            OnButtonClick = weMirab_TabNButtonClick
          end
          object deFNaim: TVDBERus
            Left = 10
            Top = 49
            Width = 190
            Height = 21
            CharCase = ecUpperCase
            DataField = 'FNAIM'
            DataSource = dsTrCurator
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            TabOrder = 1
          end
          object deINaim: TVDBERus
            Left = 220
            Top = 49
            Width = 190
            Height = 21
            CharCase = ecUpperCase
            DataField = 'INAIM'
            DataSource = dsTrCurator
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            TabOrder = 2
          end
          object deONaim: TVDBERus
            Left = 430
            Top = 49
            Width = 190
            Height = 21
            CharCase = ecUpperCase
            DataField = 'ONAIM'
            DataSource = dsTrCurator
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            TabOrder = 3
          end
        end
        object tsCurrState: TTabSheet
          Caption = 'tsCurrState'
          ImageIndex = 6
          object gb_CurrState: TGroupBox
            Left = 0
            Top = 0
            Width = 1272
            Height = 161
            Align = alTop
            Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object lblCurrStateDateTo: TLabel
              Left = 14
              Top = 11
              Width = 87
              Height = 13
              Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblCurrStateSummPay: TLabel
              Left = 139
              Top = 11
              Width = 87
              Height = 13
              Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblCurrStateIstFin: TLabel
              Left = 14
              Top = 47
              Width = 137
              Height = 13
              Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object teCurrIstFin_snaim: TDBText
              Left = 57
              Top = 61
              Width = 220
              Height = 17
              DataField = 'ISTFIN_SNAIM'
              DataSource = dsCurrState
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
            end
            object teCurrPayment_snaim: TDBText
              Left = 57
              Top = 96
              Width = 214
              Height = 17
              DataField = 'PAYMENT_SNAIM'
              DataSource = dsCurrState
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
            end
            object lblCurrStatePayment: TLabel
              Left = 13
              Top = 82
              Width = 59
              Height = 13
              Caption = #1058#1080#1087' '#1086#1087#1083#1072#1090#1099
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblCurrStateSubject: TLabel
              Left = 14
              Top = 118
              Width = 27
              Height = 13
              Caption = #1058#1077#1084#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblCurrStateYearSummPay: TLabel
              Left = 339
              Top = 11
              Width = 87
              Height = 13
              Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object deCurrDateTo: TVDBEDate
              Left = 14
              Top = 23
              Width = 100
              Height = 23
              HelpContext = 120
              AutoSize = False
              DataField = 'DATETO'
              DataSource = dsCurrState
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 0
              OnChange = DateEditChange
              Glyph.Data = {
                36010000424D360100000000000076000000280000001C0000000C0000000100
                040000000000C000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
              ButtonWidth = 21
              NumGlyphs = 2
            end
            object deCurrSummPay: TVDBEMath
              Left = 139
              Top = 23
              Width = 181
              Height = 23
              DataField = 'SUMMPAY'
              DataSource = dsCurrState
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              MaxLength = 24
              ParentFont = False
              ParentShowHint = False
              TabOrder = 1
            end
            object weCurrIstFin_kod: TVWatchEdit
              Left = 14
              Top = 59
              Width = 40
              Height = 23
              AutoSize = False
              DataField = 'ISTFIN_KOD'
              DataSource = dsCurrState
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              MaxLength = 2
              ParentFont = False
              ParentShowHint = False
              TabOrder = 2
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                0400000000002000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
              NumGlyphs = 1
              KeyField = 'KOD'
              HintField = 'SNAIM'
              OwnerTable = 'RN'
              TableName = 'MIISTFIN'
            end
            object weCurrPayment_kod: TVWatchEdit
              Left = 14
              Top = 94
              Width = 40
              Height = 23
              AutoSize = False
              DataField = 'PAYMENT_KOD'
              DataSource = dsCurrState
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              MaxLength = 2
              ParentFont = False
              ParentShowHint = False
              TabOrder = 3
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                0400000000002000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
              NumGlyphs = 1
              KeyField = 'KOD'
              HintField = 'SNAIM'
              OwnerTable = 'RN'
              TableName = 'MIPAYMENT'
            end
            object deCurrSubject: TVDBEditChar
              Left = 14
              Top = 130
              Width = 307
              Height = 23
              DataField = 'SUBJECT'
              DataSource = dsCurrState
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 4
              OnMouseMove = ShowHint
            end
            object dbgSummpayYear: TRxDBGrid
              Left = 337
              Top = 23
              Width = 281
              Height = 131
              DataSource = dsSummpayYear
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Courier New'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
              ParentFont = False
              TabOrder = 5
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = [fsBold]
            end
          end
          object gbCurrStage: TGroupBox
            Left = 0
            Top = 199
            Width = 1272
            Height = 438
            Align = alClient
            Caption = #1069#1090#1072#1087#1099
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object dbgCurrStage: TRxDBGrid
              Left = 2
              Top = 15
              Width = 1091
              Height = 421
              Align = alClient
              DataSource = dsCurrStage
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Courier New'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
              ParentFont = False
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = [fsBold]
              OnDblClick = dbgCurrStageDblClick
              OnGetCellParams = dbgCurrStageGetCellParams
            end
          end
          object pCurrStNDS: TPanel
            Left = 0
            Top = 161
            Width = 1272
            Height = 38
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            object lblCurrStNDS: TLabel
              Left = 10
              Top = 1
              Width = 35
              Height = 13
              Caption = #1053#1044#1057' %'
            end
            object lblCurrStNDSSummPay: TLabel
              Left = 69
              Top = 1
              Width = 61
              Height = 13
              Caption = #1057#1091#1084#1084#1072' '#1053#1044#1057
            end
            object deCurrStNDS: TVDBEMath
              Left = 10
              Top = 15
              Width = 45
              Height = 21
              DataField = 'NDS'
              DataSource = dsCurrState
              ParentShowHint = False
              TabOrder = 0
            end
            object deCurrStNDSSummPay: TVDBEMath
              Left = 69
              Top = 15
              Width = 85
              Height = 21
              DataField = 'NDS_SUMMPAY'
              DataSource = dsCurrState
              ParentShowHint = False
              TabOrder = 1
            end
          end
        end
        object tsExpectedIncome: TTabSheet
          Caption = 'tsExpectedIncome'
          ImageIndex = 7
          object paExpIncome: TPanel
            Left = 0
            Top = 0
            Width = 1272
            Height = 55
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lblExpIncSummPay: TLabel
              Left = 324
              Top = 14
              Width = 104
              Height = 13
              Caption = #1054#1078#1080#1076#1072#1077#1084#1099#1081' '#1101#1092#1092#1077#1082#1090
            end
            object gbIntroductionDate: TGroupBox
              Left = 10
              Top = 0
              Width = 300
              Height = 55
              Caption = #1057#1088#1086#1082' '#1074#1085#1077#1076#1088#1077#1085#1080#1103' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080
              TabOrder = 0
              object lblExpIncPlaneDate: TLabel
                Left = 10
                Top = 14
                Width = 46
                Height = 13
                Caption = #1055#1086' '#1087#1083#1072#1085#1091
              end
              object lblExpIncFactDate: TLabel
                Left = 108
                Top = 14
                Width = 85
                Height = 13
                Caption = #1053#1072#1095#1072#1083#1072' '#1087#1086' '#1092#1072#1082#1090#1091
              end
              object lblExpIncDateTo: TLabel
                Left = 206
                Top = 15
                Width = 82
                Height = 13
                Caption = #1054#1082#1086#1085#1095'. '#1087#1086' '#1092#1072#1082#1090#1091
              end
              object dePlanDate: TVDBEDate
                Left = 10
                Top = 27
                Width = 84
                Height = 21
                AutoSize = False
                DataField = 'PLAN_DATE'
                DataSource = dsExpectedIncome
                ParentShowHint = False
                TabOrder = 0
                Glyph.Data = {
                  36010000424D360100000000000076000000280000001C0000000C0000000100
                  040000000000C000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                  77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                  47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                  47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                  47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                  47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                  47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                NumGlyphs = 2
              end
              object deFactDateFrom: TVDBEDate
                Left = 108
                Top = 27
                Width = 84
                Height = 21
                AutoSize = False
                DataField = 'FACT_DATE_FROM'
                DataSource = dsExpectedIncome
                ParentShowHint = False
                TabOrder = 1
                Glyph.Data = {
                  36010000424D360100000000000076000000280000001C0000000C0000000100
                  040000000000C000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                  77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                  47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                  47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                  47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                  47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                  47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                NumGlyphs = 2
              end
              object deFactDateTo: TVDBEDate
                Left = 206
                Top = 27
                Width = 84
                Height = 21
                AutoSize = False
                DataField = 'FACT_DATE_TO'
                DataSource = dsExpectedIncome
                ParentShowHint = False
                TabOrder = 2
                Glyph.Data = {
                  36010000424D360100000000000076000000280000001C0000000C0000000100
                  040000000000C000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
                  77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
                  47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
                  47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
                  47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
                  47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
                  47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
                NumGlyphs = 2
              end
            end
            object deExpectedIncome: TVDBEMath
              Left = 324
              Top = 27
              Width = 100
              Height = 21
              DataField = 'PARAMETER'
              DataSource = dsExpectedIncome
              ParentShowHint = False
              TabOrder = 1
            end
          end
          object deExpIncome: TDBMemo
            Left = 10
            Top = 64
            Width = 414
            Height = 201
            DataField = 'DESCRIPTION'
            DataSource = dsExpectedIncome
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object tsExpIncomePeriod: TTabSheet
          Caption = 'tsExpIncomePeriod'
          ImageIndex = 8
          object lblExpIncPeriodDate: TLabel
            Left = 10
            Top = 0
            Width = 38
            Height = 13
            Caption = #1055#1077#1088#1080#1086#1076
          end
          object lblExpIncPeriodSummPay: TLabel
            Left = 108
            Top = 0
            Width = 104
            Height = 13
            Caption = #1054#1078#1080#1076#1072#1077#1084#1099#1081' '#1101#1092#1092#1077#1082#1090
          end
          object dePeriod: TVDBEDate
            Left = 10
            Top = 14
            Width = 84
            Height = 21
            AutoSize = False
            DataField = 'PERIOD'
            DataSource = dsExpIncomePeriod
            ParentShowHint = False
            TabOrder = 0
            Glyph.Data = {
              36010000424D360100000000000076000000280000001C0000000C0000000100
              040000000000C000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDD777777777
              77DDFFFFFFFFFFFF0000DD004044040047D777777777777F0000DDFFFFFFFFFF
              47D7FDFFFDFFFD7F0000DDF000F0008F47D7F777D777DF7F0000DDFF0FF8F80F
              47D7FD7FDDDD7F7F0000DDFF0FFFFF0F47D7FD7FDDFF7D7F0000DDFF0FF0008F
              47D7FD7FD777DD7F0000DDF00FF0FFFF47D7F77FD7FFFF7F0000DDFF0FF0000F
              47D7FD7DD7777D7F0000DDFFFFFFFFFF47D7FDDDDDDDDD7F0000DDF88888888F
              47D7FFFFFFFFFF7F0000DD0000000000DDD777777777777D0000}
            NumGlyphs = 2
          end
          object deExpIncomeInPeriod: TVDBEMath
            Left = 108
            Top = 14
            Width = 100
            Height = 21
            DataField = 'DATA'
            DataSource = dsExpIncomePeriod
            ParentShowHint = False
            TabOrder = 1
          end
          object deExpIncInPeriod: TDBMemo
            Left = 8
            Top = 40
            Width = 414
            Height = 201
            DataField = 'DESCRIPTION'
            DataSource = dsExpIncomePeriod
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
        end
      end
    end
    inherited paExplorer: TPanel
      Height = 663
      inherited spExplorer: TSplitter
        Top = 580
      end
      inherited TreeView: TTreeView
        Height = 580
      end
      inherited paProc: TPanel
        Top = 583
      end
    end
  end
  inherited paSecretBottom: TPanel
    Top = 665
    Width = 1408
    inherited paBottom: TPanel
      Width = 1408
      inherited paRightBottom: TPanel
        Left = 1161
      end
    end
  end
  inherited dsCurrent: TDataSource
    Left = 74
    Top = 335
  end
  inherited PopSwitch: TPopupMenu
    Left = 88
    Top = 430
  end
  inherited ID: TVEditFormID
    Left = 136
    Top = 432
  end
  inherited imlState: TImageList
    Left = 220
    Top = 433
    Bitmap = {
      494C01010200040004000E000E00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000380000000E0000000100200000000000400C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      00000084000000840000FFFFFF00FFFFFF000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008400000084
      000000840000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000008400000084
      00000084000000840000FFFFFF00FFFFFF000084000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000008400000084
      00000084000000840000FFFFFF00FFFFFF000084000000840000008400000084
      0000008400000084000000000000000000000000000000000000000000000000
      FF000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000008400000084
      00000084000000840000FFFFFF00FFFFFF00FFFFFF0000840000008400000084
      0000008400000084000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000008400000084
      0000008400000084000000840000FFFFFF00FFFFFF0000840000008400000084
      0000008400000084000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000008400000084
      0000008400000084000000840000FFFFFF00FFFFFF00FFFFFF00008400000084
      000000840000008400000000FF0000000000000000000000FF00000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000008400000084
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008400000084
      000000840000000000000000FF0000000000000000000000FF00000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000008400000084
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008400000084
      000000840000000000000000FF0000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008400000084
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008400000084
      000000000000000000000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      00000084000000840000FFFFFF00FFFFFF000084000000840000008400000000
      000000000000000000000000FF0000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000000000000000000000
      000000000000000000000000FF0000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000380000000E0000000100010000000000700000000000000000000000
      000000000000000000000000FFFFFF00F03FFFB000000000E01FFFB000000000
      C00FFFB0000000008007FFB0000000000003E3B0000000000003EE0000000000
      0003EFF0000000000003E3F0000000000001AFF0000000000001A3F000000000
      8005BFF000000000C00C3FF000000000E01DBFF000000000F03DBFF000000000
      00000000000000000000000000000000000000000000}
  end
  inherited pmTree: TPopupMenu
    Left = 64
    Top = 392
  end
  inherited dsActive: TDataSource
    Left = 184
    Top = 430
  end
  inherited tmTreeView: TTimer
    Left = 96
    Top = 479
  end
  object dsTreaty: TDataSource
    DataSet = dmGlobal.quTreaty
    OnDataChange = DataSourceChange
    Left = 264
    Top = 433
  end
  object dsAgreemStage: TDataSource
    DataSet = dmGlobal.quAgreemStage
    OnDataChange = DataSourceChange
    Left = 344
    Top = 433
  end
  object dsTreatyStage: TDataSource
    DataSet = dmGlobal.quTreatyStage
    OnDataChange = DataSourceChange
    Left = 384
    Top = 431
  end
  object dsAgreem: TDataSource
    DataSet = dmGlobal.quAgreem
    OnDataChange = dsAgreemDataChange
    Left = 304
    Top = 431
  end
  object dsTrCurator: TDataSource
    DataSet = dmGlobal.quTrCurator
    OnDataChange = DataSourceChange
    Left = 423
    Top = 431
  end
  object dsCurrState: TDataSource
    DataSet = dmGlobal.quCurrState
    OnDataChange = DataSourceChange
    Left = 463
    Top = 431
  end
  object dsCurrStage: TDataSource
    DataSet = dmGlobal.odsCurrStage
    Left = 523
    Top = 431
  end
  object dsSummpayYear: TDataSource
    DataSet = dmGlobal.odsSummpayYear
    Left = 587
    Top = 436
  end
  object dsExecFirmProperty: TDataSource
    DataSet = dmGlobal.odsTrExecFirmProperty
    Left = 631
    Top = 438
  end
  object dsExpectedIncome: TDataSource
    DataSet = dmGlobal.quExpectedIncome
    OnDataChange = dsExpectedIncomeDataChange
    Left = 679
    Top = 441
  end
  object dsExpIncomePeriod: TDataSource
    DataSet = dmGlobal.quExpIncomePeriod
    Left = 727
    Top = 433
  end
end
