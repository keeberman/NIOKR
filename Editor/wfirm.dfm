inherited fmFirm: TfmFirm
  Left = 325
  Top = 114
  Width = 889
  Height = 528
  Caption = 'Организации'
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 881
  end
  inherited paMiddle: TPanel
    Width = 881
    Height = 460
    inherited Splitter: TSplitter
      Height = 458
    end
    inherited paControl: TPanel
      Width = 753
      Height = 458
      inherited pcMain: TPageControl
        Width = 753
        Height = 458
        ActivePage = tsAccount
        inherited tsList: TTabSheet
          inherited DBGrid: TRxDBGrid
            Width = 745
            Height = 430
          end
        end
        object tsFirm: TTabSheet
          Caption = 'tsFirm'
          ImageIndex = 1
          object Label1: TLabel
            Left = 16
            Top = 0
            Width = 67
            Height = 13
            Caption = 'Организация'
          end
          object Label2: TLabel
            Left = 16
            Top = 43
            Width = 115
            Height = 13
            Caption = 'Полное наименование'
          end
          object Label3: TLabel
            Left = 171
            Top = 0
            Width = 57
            Height = 13
            Caption = 'Сокр.наим.'
          end
          object deName: TVDBERus
            Left = 16
            Top = 59
            Width = 625
            Height = 24
            DataField = 'NAME'
            DataSource = dsFirm
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            TabOrder = 1
            RusCase = True
          end
          object GroupBox1: TGroupBox
            Left = 8
            Top = 88
            Width = 729
            Height = 145
            Caption = 'Адрес'
            Color = clBtnFace
            ParentColor = False
            TabOrder = 2
            object dtCountry: TDBText
              Left = 94
              Top = 36
              Width = 205
              Height = 17
              DataField = 'COUNTRY_NAIM'
              DataSource = dsFirm
            end
            object dtDistrict: TDBText
              Left = 94
              Top = 116
              Width = 205
              Height = 17
              DataField = 'DISTRICT_NAIM'
              DataSource = dsFirm
            end
            object dtRegion: TDBText
              Left = 94
              Top = 76
              Width = 205
              Height = 17
              DataField = 'REGION_NAIM'
              DataSource = dsFirm
            end
            object Label19: TLabel
              Left = 304
              Top = 16
              Width = 30
              Height = 13
              Caption = 'Город'
            end
            object Label18: TLabel
              Left = 16
              Top = 56
              Width = 83
              Height = 13
              Caption = 'Регион(область)'
            end
            object Label17: TLabel
              Left = 16
              Top = 16
              Width = 36
              Height = 13
              Caption = 'Страна'
            end
            object Label20: TLabel
              Left = 16
              Top = 96
              Width = 31
              Height = 13
              Caption = 'Район'
            end
            object Label4: TLabel
              Left = 304
              Top = 56
              Width = 89
              Height = 13
              Caption = 'Почтовый индекс'
            end
            object Label5: TLabel
              Left = 448
              Top = 56
              Width = 80
              Height = 13
              Caption = 'Почтовый ящик'
            end
            object Label6: TLabel
              Left = 304
              Top = 96
              Width = 109
              Height = 13
              Caption = 'Адрес (улица №дома)'
            end
            object weCountry: TVWatchEdit
              Left = 16
              Top = 32
              Width = 72
              Height = 21
              AutoSize = False
              DataField = 'COUNTRY_NO'
              DataSource = dsFirm
              MaxLength = 5
              ParentShowHint = False
              TabOrder = 0
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                040000000000200000000000000000000000100000001000000000000000FFFF
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000111111111100
                0000001100110000000000110011000000001111111111000000}
              NumGlyphs = 1
              KeyField = 'COUNTRY_NO'
              HintField = 'NAME'
              OwnerTable = 'S'
              TableName = 'COUNTRY'
            end
            object weDistrict: TVWatchEdit
              Left = 16
              Top = 112
              Width = 72
              Height = 21
              AutoSize = False
              DataField = 'DISTRICT_NO'
              DataSource = dsFirm
              MaxLength = 5
              ParentShowHint = False
              TabOrder = 2
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                040000000000200000000000000000000000100000001000000000000000FFFF
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000111111111100
                0000001100110000000000110011000000001111111111000000}
              NumGlyphs = 1
              Master = weRegion
              KeyField = 'DISTRICT'
              HintField = 'NAME'
              OwnerTable = 'S'
              TableName = 'DISTRICT'
              OnAcceptValue = weDistrictAcceptValue
            end
            object weRegion: TVWatchEdit
              Left = 16
              Top = 72
              Width = 72
              Height = 21
              AutoSize = False
              DataField = 'REGION_NO'
              DataSource = dsFirm
              MaxLength = 5
              ParentShowHint = False
              TabOrder = 1
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                040000000000200000000000000000000000100000001000000000000000FFFF
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000111111111100
                0000001100110000000000110011000000001111111111000000}
              NumGlyphs = 1
              Master = weCountry
              KeyField = 'REGION_NO'
              HintField = 'NAME'
              OwnerTable = 'S'
              TableName = 'REGION'
              OnAcceptValue = weRegionAcceptValue
            end
            object deZip_code: TVDBEditChar
              Left = 304
              Top = 72
              Width = 121
              Height = 21
              DataField = 'ZIP_CODE'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 3
            end
            object dePost_box: TVDBEditChar
              Left = 448
              Top = 72
              Width = 121
              Height = 21
              DataField = 'POST_BOX'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 4
            end
            object deCity_name: TVDBERus
              Left = 304
              Top = 32
              Width = 265
              Height = 21
              DataField = 'CITY_NAME'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 5
            end
            object deAddress: TVDBERus
              Left = 304
              Top = 112
              Width = 369
              Height = 21
              DataField = 'ADDRESS'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 6
            end
          end
          object GroupBox2: TGroupBox
            Left = 8
            Top = 248
            Width = 473
            Height = 169
            Caption = 'Контакты и коммуникация'
            TabOrder = 3
            object Label7: TLabel
              Left = 16
              Top = 16
              Width = 54
              Height = 13
              Caption = 'Телефон 1'
            end
            object Label8: TLabel
              Left = 16
              Top = 56
              Width = 54
              Height = 13
              Caption = 'Телефон 2'
            end
            object Label9: TLabel
              Left = 16
              Top = 96
              Width = 54
              Height = 13
              Caption = 'Телефон 3'
            end
            object Label10: TLabel
              Left = 168
              Top = 56
              Width = 54
              Height = 13
              Caption = 'Телефон 5'
            end
            object Label11: TLabel
              Left = 168
              Top = 16
              Width = 54
              Height = 13
              Caption = 'Телефон 4'
            end
            object Label12: TLabel
              Left = 320
              Top = 16
              Width = 92
              Height = 13
              Caption = 'Номер телефакса'
            end
            object Label13: TLabel
              Left = 320
              Top = 56
              Width = 133
              Height = 13
              Caption = 'Номер телекса (телетайп)'
            end
            object Label14: TLabel
              Left = 320
              Top = 96
              Width = 97
              Height = 13
              Caption = 'Электронная почта'
            end
            object dePhone1: TVDBEditChar
              Left = 16
              Top = 32
              Width = 121
              Height = 21
              DataField = 'PHONE1'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 0
            end
            object dePhone2: TVDBEditChar
              Left = 16
              Top = 72
              Width = 121
              Height = 21
              DataField = 'PHONE2'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 1
            end
            object dePhone5: TVDBEditChar
              Left = 168
              Top = 72
              Width = 121
              Height = 21
              DataField = 'PHONE5'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 4
            end
            object dePhone4: TVDBEditChar
              Left = 168
              Top = 32
              Width = 121
              Height = 21
              DataField = 'PHONE4'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 3
            end
            object dePhone3: TVDBEditChar
              Left = 16
              Top = 112
              Width = 121
              Height = 21
              DataField = 'PHONE3'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 2
            end
            object deFax_no: TVDBEditChar
              Left = 320
              Top = 32
              Width = 145
              Height = 21
              DataField = 'FAX_NO'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 5
            end
            object deTelex_no: TVDBEditChar
              Left = 320
              Top = 72
              Width = 145
              Height = 21
              DataField = 'TELEX_NO'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 6
            end
            object deE_mail: TVDBEditChar
              Left = 320
              Top = 112
              Width = 145
              Height = 21
              DataField = 'E_MAIL'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 7
            end
          end
          object paFirm: TPanel
            Left = 0
            Top = 0
            Width = 745
            Height = 37
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label15: TLabel
              Left = 16
              Top = 0
              Width = 67
              Height = 13
              Caption = 'Организация'
            end
            object Label16: TLabel
              Left = 171
              Top = 0
              Width = 57
              Height = 13
              Caption = 'Сокр.наим.'
            end
            object deFirm_no: TVDBEMath
              Left = 16
              Top = 16
              Width = 121
              Height = 21
              DataField = 'FIRM_NO'
              DataSource = dsFirm
              MaxLength = 10
              ParentShowHint = False
              TabOrder = 0
            end
            object deShort_name: TVDBERus
              Left = 171
              Top = 16
              Width = 169
              Height = 21
              DataField = 'SHORT_NAME'
              DataSource = dsFirm
              ParentShowHint = False
              TabOrder = 1
              RusCase = True
            end
          end
        end
        object tsAccount: TTabSheet
          Caption = 'tsAccount'
          ImageIndex = 2
          object GroupBox3: TGroupBox
            Left = 8
            Top = 8
            Width = 521
            Height = 153
            Caption = 'Данные счета'
            TabOrder = 0
            object Label21: TLabel
              Left = 16
              Top = 16
              Width = 65
              Height = 13
              Caption = 'Номер счета'
            end
            object dtCurrency: TDBText
              Left = 270
              Top = 34
              Width = 205
              Height = 17
              DataField = 'CURRENCY_NAIM'
              DataSource = dsAccount
            end
            object Label22: TLabel
              Left = 192
              Top = 16
              Width = 38
              Height = 13
              Caption = 'Валюта'
            end
            object dtBankcountry_name: TDBText
              Left = 142
              Top = 80
              Width = 205
              Height = 17
              DataField = 'COUNTRY_NAIM'
              DataSource = dsAccount
            end
            object Label26: TLabel
              Left = 16
              Top = 60
              Width = 69
              Height = 13
              Caption = 'Страна банка'
            end
            object dtBank_name: TDBText
              Left = 142
              Top = 124
              Width = 347
              Height = 17
              DataField = 'BANK_NAIM'
              DataSource = dsAccount
            end
            object Label23: TLabel
              Left = 16
              Top = 104
              Width = 59
              Height = 13
              Caption = 'Ключ банка'
            end
            object deBank_account: TVDBEditChar
              Left = 16
              Top = 32
              Width = 153
              Height = 21
              DataField = 'BANK_ACCOUNT'
              DataSource = dsAccount
              ParentShowHint = False
              TabOrder = 0
            end
            object weCurrency: TVWatchEdit
              Left = 192
              Top = 32
              Width = 72
              Height = 21
              AutoSize = False
              DataField = 'CURRENCY_NO'
              DataSource = dsAccount
              MaxLength = 5
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
            object weBank_country: TVWatchEdit
              Left = 16
              Top = 76
              Width = 120
              Height = 21
              AutoSize = False
              DataField = 'COUNTRY_NO'
              DataSource = dsAccount
              MaxLength = 5
              ParentShowHint = False
              TabOrder = 1
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                040000000000200000000000000000000000100000001000000000000000FFFF
                FF00000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000111111111100
                0000001100110000000000110011000000001111111111000000}
              NumGlyphs = 1
              KeyField = 'COUNTRY_NO'
              HintField = 'NAME'
              OwnerTable = 'S'
              TableName = 'COUNTRY'
            end
            object weBank_id: TVWatchEdit
              Left = 16
              Top = 120
              Width = 120
              Height = 21
              AutoSize = False
              DataField = 'BANK_ID'
              DataSource = dsAccount
              ParentShowHint = False
              TabOrder = 2
              Glyph.Data = {
                96000000424D960000000000000076000000280000000A000000040000000100
                0400000000002000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
                000000FF00FF0000000000FF00FF00000000FFFFFFFFFF000000}
              NumGlyphs = 1
              Master = weBank_country
              KeyField = 'BANK_ID'
              HintField = 'NAME'
              OwnerTable = 'S'
              TableName = 'BANK'
              OnAcceptValue = weBank_idAcceptValue
            end
          end
          object GroupBox4: TGroupBox
            Left = 8
            Top = 160
            Width = 521
            Height = 113
            Caption = 'Банк'
            TabOrder = 1
            object Label24: TLabel
              Left = 16
              Top = 20
              Width = 52
              Height = 13
              Caption = 'Код банка'
            end
            object Label25: TLabel
              Left = 184
              Top = 20
              Width = 109
              Height = 13
              Caption = 'Наименование банка'
            end
            object Label27: TLabel
              Left = 16
              Top = 60
              Width = 64
              Height = 13
              Caption = 'Адрес банка'
            end
            object deBank_naim: TVDBEditChar
              Tag = 1
              Left = 184
              Top = 36
              Width = 321
              Height = 24
              DataField = 'BANK_NAIM'
              DataSource = dsAccount
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 1
            end
            object deBank_code: TVDBEditChar
              Tag = 1
              Left = 16
              Top = 36
              Width = 153
              Height = 24
              DataField = 'BANK_CODE'
              DataSource = dsAccount
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 0
            end
            object deBank_address: TVDBEditChar
              Tag = 1
              Left = 16
              Top = 76
              Width = 488
              Height = 24
              DataField = 'BANK_ADDRESS'
              DataSource = dsAccount
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              TabOrder = 2
            end
          end
        end
      end
    end
    inherited paExplorer: TPanel
      Height = 458
      inherited spExplorer: TSplitter
        Top = 375
      end
      inherited TreeView: TTreeView
        Height = 375
      end
      inherited paProc: TPanel
        Top = 378
      end
    end
  end
  inherited paSecretBottom: TPanel
    Top = 460
    Width = 881
    inherited paBottom: TPanel
      Width = 881
      inherited paRightBottom: TPanel
        Left = 634
      end
    end
  end
  inherited dsCurrent: TDataSource
    Top = 472
  end
  inherited PopSwitch: TPopupMenu
    Top = 473
  end
  inherited ID: TVEditFormID
    Top = 473
  end
  inherited imlState: TImageList
    Top = 471
  end
  inherited pmTree: TPopupMenu
    Top = 472
  end
  object dsFirm: TDataSource
    DataSet = dmGlobal.quFirm
    Left = 272
    Top = 471
  end
  object dsAccount: TDataSource
    DataSet = dmGlobal.quAccount
    Left = 304
    Top = 471
  end
end
