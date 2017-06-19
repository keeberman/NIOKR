object dmRptQuery: TdmRptQuery
  OldCreateOrder = True
  Left = 157
  Top = 163
  Height = 479
  Width = 741
  object quAllTables: TOracleQuery
    SQL.Strings = (
      'SELECT table_name FROM MAJOR_SQL_REP'
      'WHERE DRAFT_REP_ID= :Repid'
      'group by table_name')
    Session = dmGlobal.seOracle
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Variables.Data = {
      0300000001000000060000003A52455049440300000004000000FFFFFFFF0000
      0000}
    Cursor = crSQLWait
    StringFieldsOnly = False
    Threaded = False
    ThreadSynchronized = True
    Left = 18
    Top = 8
  end
  object quMajors: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM MAJOR_SQL_REP'
      'WHERE DRAFT_REP_ID= :Repid AND TABLE_NAME= :TabName')
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Variables.Data = {
      0300000002000000060000003A52455049440300000004000000FFFFFFFF0000
      0000080000003A5441424E414D45050000000000000000000000}
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
    Cursor = crSQLWait
    ReadOnly = False
    LockingMode = lmNone
    QueryAllRecords = True
    CountAllRecords = False
    RefreshOptions = []
    CommitOnPost = True
    CachedUpdates = False
    QBEMode = False
    Session = dmGlobal.seOracle
    DesignActivation = False
    Active = False
    Left = 90
    Top = 8
    object quMajorsDRAFT_REP_ID: TFloatField
      FieldName = 'DRAFT_REP_ID'
      Required = True
    end
    object quMajorsTABLE_NAME: TStringField
      FieldName = 'TABLE_NAME'
      Required = True
      Size = 30
    end
    object quMajorsFIELD_NAME: TStringField
      FieldName = 'FIELD_NAME'
      Required = True
      Size = 100
    end
    object quMajorsCONDITION: TIntegerField
      FieldName = 'CONDITION'
      Required = True
    end
    object quMajorsVALUE: TStringField
      FieldName = 'VALUE'
      Size = 2000
    end
    object quMajorsRESTYPE: TIntegerField
      FieldName = 'RESTYPE'
    end
    object quMajorsRESERVED: TBlobField
      FieldName = 'RESERVED'
      BlobType = ftBlob
    end
  end
  object quMinors: TOracleQuery
    SQL.Strings = (
      'SELECT ORDER_TEXT,FILTER_TEXT,MAIN_TABLE'
      'FROM MINOR_SQL_REP'
      'WHERE DRAFT_REP_ID= :Repid')
    Session = dmGlobal.seOracle
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Variables.Data = {
      0300000001000000060000003A52455049440300000004000000FFFFFFFF0000
      0000}
    Cursor = crSQLWait
    StringFieldsOnly = False
    Threaded = False
    ThreadSynchronized = True
    Left = 18
    Top = 64
  end
end
