inherited fmTRConcern: TfmTRConcern
  Left = 226
  Top = 226
  Width = 697
  Caption = 'Рамочные договора'
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 689
  end
  inherited paMiddle: TPanel
    Width = 689
    inherited paControl: TPanel
      Width = 561
      inherited pcMain: TPageControl
        Width = 561
        inherited tsList: TTabSheet
          inherited DBGrid: TRxDBGrid
            Width = 553
          end
        end
        object tsDogConcern: TTabSheet
          Caption = 'tsDogConcern'
          ImageIndex = 1
          object lblDogName: TLabel
            Left = 14
            Top = 40
            Width = 126
            Height = 13
            Caption = 'Наименование договора'
          end
          object Label9: TLabel
            Left = 14
            Top = 99
            Width = 347
            Height = 13
            Caption = 'Дата начала работ, попадающих  под действия рамочного договора'
          end
          object pTopDog: TPanel
            Left = 0
            Top = 0
            Width = 553
            Height = 36
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label1: TLabel
              Left = 14
              Top = 1
              Width = 84
              Height = 13
              Caption = 'Номер договора'
            end
            object Label2: TLabel
              Left = 148
              Top = 1
              Width = 89
              Height = 13
              Caption = 'Дата подписания'
            end
            object Label3: TLabel
              Left = 282
              Top = 1
              Width = 114
              Height = 13
              Caption = 'Дата начала действия'
            end
            object Label4: TLabel
              Left = 416
              Top = 1
              Width = 132
              Height = 13
              Caption = 'Дата окончания действия'
            end
            object deNumDog: TVDBEMath
              Left = 14
              Top = 15
              Width = 120
              Height = 21
              DataField = 'NUM'
              DataSource = odsMitrConcern
              ParentShowHint = False
              TabOrder = 0
            end
            object deDateSign: TVDBEDate
              Left = 148
              Top = 15
              Width = 120
              Height = 21
              AutoSize = False
              DataField = 'DATESIGN'
              DataSource = odsMitrConcern
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
            object deDateFrom: TVDBEDate
              Left = 282
              Top = 15
              Width = 120
              Height = 21
              AutoSize = False
              DataField = 'DATEFROM'
              DataSource = odsMitrConcern
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
            object deDateTo: TVDBEDate
              Left = 416
              Top = 15
              Width = 120
              Height = 21
              AutoSize = False
              DataField = 'DATETO'
              DataSource = odsMitrConcern
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
              NumGlyphs = 2
            end
          end
          object deDogName: TVDBERus
            Left = 14
            Top = 53
            Width = 522
            Height = 21
            DataField = 'NAME'
            DataSource = odsMitrConcern
            ParentShowHint = False
            TabOrder = 1
          end
          object cbBegInterval: TDBCheckBox
            Left = 14
            Top = 79
            Width = 515
            Height = 17
            Caption = 'Не распространяется на старые инновационные договора'
            DataField = 'EXISTENT_BEG_INTERVAL'
            DataSource = odsMitrConcern
            TabOrder = 2
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
          object deWork_DateFrom: TVDBEDate
            Left = 14
            Top = 113
            Width = 120
            Height = 21
            AutoSize = False
            DataField = 'WORK_DATEFROM'
            DataSource = odsMitrConcern
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
            NumGlyphs = 2
          end
        end
        object tsAgrConcern: TTabSheet
          Caption = 'tsAgrConcern'
          ImageIndex = 2
          object lblAgrName: TLabel
            Left = 14
            Top = 40
            Width = 126
            Height = 13
            Caption = 'Наименование договора'
          end
          object pTopAgr: TPanel
            Left = 0
            Top = 0
            Width = 553
            Height = 36
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label5: TLabel
              Left = 14
              Top = 1
              Width = 122
              Height = 13
              Caption = 'Номер доп. соглашения'
            end
            object Label6: TLabel
              Left = 148
              Top = 1
              Width = 118
              Height = 13
              Caption = 'Дата подписания согл.'
            end
            object Label7: TLabel
              Left = 416
              Top = 1
              Width = 120
              Height = 13
              Caption = 'Дата оконч. д-вия согл.'
            end
            object Label8: TLabel
              Left = 282
              Top = 1
              Width = 108
              Height = 13
              Caption = 'Дата нач. д-вия согл.'
            end
            object deNumAgr: TVDBEMath
              Left = 14
              Top = 15
              Width = 120
              Height = 21
              DataField = 'NUM'
              DataSource = odsMitrconc_agr
              ParentShowHint = False
              TabOrder = 0
            end
            object deDateSignAgr: TVDBEDate
              Left = 148
              Top = 15
              Width = 120
              Height = 21
              AutoSize = False
              DataField = 'DATESIGN'
              DataSource = odsMitrconc_agr
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
            object deDateFromAgr: TVDBEDate
              Left = 282
              Top = 15
              Width = 120
              Height = 21
              AutoSize = False
              DataField = 'DATEFROM'
              DataSource = odsMitrconc_agr
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
            object deDateToAgr: TVDBEDate
              Left = 416
              Top = 15
              Width = 120
              Height = 21
              AutoSize = False
              DataField = 'DATETO'
              DataSource = odsMitrconc_agr
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
              NumGlyphs = 2
            end
          end
          object deAgrName: TVDBERus
            Left = 14
            Top = 53
            Width = 522
            Height = 21
            DataField = 'NAME'
            DataSource = odsMitrconc_agr
            ParentShowHint = False
            TabOrder = 1
          end
        end
      end
    end
  end
  inherited paSecretBottom: TPanel
    Width = 689
    inherited paBottom: TPanel
      Width = 689
      inherited paRightBottom: TPanel
        Left = 442
      end
    end
  end
  object odsMitrConcern: TDataSource
    DataSet = dmGlobal.quMitrconcern
    Left = 312
    Top = 455
  end
  object odsMitrconc_agr: TDataSource
    DataSet = dmGlobal.quMitrconc_agr
    Left = 344
    Top = 455
  end
end
