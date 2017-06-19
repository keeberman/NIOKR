inherited fmLongRunQuery: TfmLongRunQuery
  Left = 222
  Top = 344
  HelpContext = 310
  Caption = ''
  ClientHeight = 92
  ClientWidth = 395
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    00000000BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0880000000000000000880000000000000000000000000000000000000000000
    00000000000000000000000000000F7777777777777777777777777778000F77
    77777777777777777777777778000F7777777777777722221113333778000F77
    777777777777AAAA999BBBB778000F7777777777777777777777777778000F77
    77777777777777777777777778000F7777777777777777777777777778000F77
    77777777777777777777777778000FFFFFFFFFFFFFFFFFFFFFFFFFF888000000
    000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFF00000000000
    0FFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFF00000000000
    0FFFF000000000000FFFF000000000000FFFFFFFFFFFFFFFFFFFF00000000000
    0FFFFFFFFFFFFFFFFFFFF000000000000FFFF000000000000FFFF00000000000
    0FFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFF00000000000
    0FFFFFFFFFFFFFFFFFFFF000000000000FFFF000FFFFFFFFFFFFF00000000000
    0FFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000F00000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FFF83FC0FFF83F8000000F800000038000
    000380000003800000038000000380000003800000038000000380000003F000
    003FF000003FF000003FF000003FF000003FF000003FF000003FF000003FF000
    003FF000003FF000003FF000003FF00000FFF00000FFFFFFFFFFFFFFFFFF}
  Position = poDefaultPosOnly
  Visible = True
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  inherited paTop: TPanel
    Width = 395
    Height = 0
    PopupMenu = nil
    Visible = False
  end
  inherited paMiddle: TPanel
    Top = 0
    Width = 395
    Height = 58
    ParentColor = True
    PopupMenu = nil
  end
  inherited paSecretBottom: TPanel
    Top = 58
    Width = 395
    ParentColor = True
    inherited paBottom: TPanel
      Width = 395
      ParentColor = True
      PopupMenu = nil
      object laForming: TLabel [2]
        Left = 3
        Top = 10
        Width = 165
        Height = 13
        Caption = 'Идет формирование отчета'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      inherited paRightBottom: TPanel
        Left = 174
        Width = 220
        ParentColor = True
        inherited bbCancel: TBitBtn
          Left = 111
        end
        inherited bbOK: TBitBtn
          Left = 2
        end
        inherited bbView: TBitBtn
          Left = 111
        end
      end
    end
  end
  inherited dsCurrent: TDataSource
    DataSet = quReport
    Left = 74
    Top = 10
  end
  inherited PopSwitch: TPopupMenu
    Left = 32
    Top = 217
  end
  inherited ID: TVEditFormID
    Top = 65
  end
  object quReport: TOracleDataSet
    SQL.Strings = (
      'select d.*,d.rowid from sys.dual d')
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
    Cursor = crDefault
    ReadOnly = False
    LockingMode = lmNone
    QueryAllRecords = False
    CountAllRecords = False
    RefreshOptions = []
    UpdatingTable = 'SYS.DUAL'
    CommitOnPost = True
    CachedUpdates = False
    QBEMode = False
    Session = dmGlobal.seOracle
    DesignActivation = False
    Active = False
    Left = 10
    Top = 10
  end
  object osLongQuery: TOracleSession
    Cursor = crHourGlass
    DesignConnection = False
    ConnectAs = caNormal
    ThreadSafe = False
    Preferences.FloatPrecision = 0
    Preferences.IntegerPrecision = 0
    Preferences.SmallIntPrecision = -1
    Preferences.UseOCI7 = False
    Preferences.ConvertCRLF = True
    Preferences.TrimStringFields = True
    Preferences.MaxStringFieldSize = 0
    Preferences.ZeroDateIsNull = True
    Preferences.NullLOBIsEmpty = False
    Pooling = spNone
    MTSOptions = [moImplicit, moUniqueServer]
    Connected = False
    RollbackOnDisconnect = False
    NullValue = nvUnAssigned
    SQLTrace = stUnchanged
    OptimizerGoal = ogUnchanged
    IsolationLevel = ilUnchanged
    BytesPerCharacter = bc1Byte
    Left = 360
    Top = 8
  end
end
