object fmRepList: TfmRepList
  Left = 766
  Top = 171
  Width = 443
  Height = 450
  Caption = 'Список отчетов'
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 435
      Height = 13
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Список отчетов'
    end
    object Label2: TLabel
      Left = 0
      Top = 14
      Width = 435
      Height = 13
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'год'
    end
  end
  object dbgReport: TRxDBGrid
    Left = 0
    Top = 27
    Width = 435
    Height = 371
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object pBottom: TPanel
    Left = 0
    Top = 398
    Width = 435
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object pRightBottom: TPanel
      Left = 265
      Top = 0
      Width = 170
      Height = 25
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object bbCancel: TBitBtn
        Left = 85
        Top = 0
        Width = 85
        Height = 25
        Caption = '&Закрыть'
        ModalResult = 2
        TabOrder = 0
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
          F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
          000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
          338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
          45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
          3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
          F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
          000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
          338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
          4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
          8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
          333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
          0000}
        NumGlyphs = 2
      end
      object bbOk: TBitBtn
        Left = 0
        Top = 0
        Width = 85
        Height = 25
        Caption = 'Отчет'
        Default = True
        Enabled = False
        TabOrder = 1
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
    end
  end
  object quReport: TOracleQuery
    Session = dmGlobal.seOracle
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Cursor = crDefault
    StringFieldsOnly = False
    Threaded = False
    ThreadSynchronized = True
    Left = 376
    Top = 290
  end
  object odsReports: TOracleDataSet
    ReadBuffer = 25
    Optimize = True
    Debug = False
    StringFieldsOnly = False
    SequenceField.ApplyMoment = amOnPost
    OracleDictionary.EnforceConstraints = False
    OracleDictionary.UseMessageTable = False
    OracleDictionary.DefaultValues = False
    OracleDictionary.DynamicDefaults = False
    OracleDictionary.FieldKinds = False
    OracleDictionary.DisplayFormats = False
    OracleDictionary.RangeValues = False
    OracleDictionary.RequiredFields = True
    QBEDefinition.SaveQBEValues = True
    QBEDefinition.AllowFileWildCards = True
    QBEDefinition.QBEFontColor = clNone
    QBEDefinition.QBEBackgroundColor = clNone
    QBEDefinition.QBEFieldDefs = {
      03000000030000000600000053554E414D450100000000090000004649525354
      4E414D450100000000090000004F544348455354564F0100000000}
    Cursor = crSQLWait
    ReadOnly = False
    LockingMode = lmCheckImmediate
    QueryAllRecords = True
    CountAllRecords = False
    RefreshOptions = []
    CommitOnPost = True
    CachedUpdates = False
    QBEMode = False
    Session = dmGlobal.seOracle
    DesignActivation = False
    Active = False
    AfterOpen = odsReportsAfterOpen
    AfterClose = odsReportsAfterClose
    Left = 376
    Top = 324
  end
  object dsReports: TDataSource
    DataSet = odsReports
    Left = 344
    Top = 326
  end
end
