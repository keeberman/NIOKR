object dmSaveRptQuery: TdmSaveRptQuery
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Left = 108
  Top = 206
  Height = 479
  Width = 741
  object osRptQuery: TOracleDataSet
    SQL.Strings = (
      'SELECT RPT.*, RPT.ROWID FROM'
      'DRAFT_REP RPT'
      'WHERE '
      '(USERNAME= USER OR USERNAME= '#39'PUBLIC'#39
      ' OR EXISTS ( SELECT 1 FROM MIPOLZ'
      '             WHERE MIROL_KOD=:ADMIN AND ORANAIM= USER'
      '                   AND MIPODSIS_KOD=:APPSYS)'
      '      OR EXISTS'
      '      ( SELECT 1 FROM REP_GRANTEE'
      '        WHERE MIPOLZ_ORANAIM= RPT.USERNAME'
      '        AND MIPOLZ_MIPODSIS_KOD=:APPSYS'
      '        AND GRANTEE= USER'
      '       )'
      ')'
      'AND MIPODSIS_KOD=:APPSYS'
      'ORDER BY NAME ASC'
      ' '
      ' '
      ' '
      ' '
      ' ')
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Variables.Data = {
      0300000002000000060000003A41444D494E0300000004000000000000000000
      0000070000003A41505053595303000000040000000100000000000000}
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
      03000000070000000200000049440100000000040000004E414D450100000000
      08000000555345524E414D45010000000008000000434F4D4D454E5453010000
      0000070000005245504441544501000000000C0000004D49504F445349535F4B
      4F4401000000000800000057494E434C4153530100000000}
    Cursor = crSQLWait
    ReadOnly = False
    LockingMode = lmNone
    QueryAllRecords = True
    CountAllRecords = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    UpdatingTable = 'DRAFT_REP'
    CommitOnPost = False
    CachedUpdates = False
    QBEMode = False
    Session = dmGlobal.seOracle
    DesignActivation = False
    Active = False
    BeforePost = osRptQueryBeforePost
    Left = 18
    Top = 56
    object osRptQueryNAME: TStringField
      DisplayLabel = 'Наименование'
      DisplayWidth = 70
      FieldName = 'NAME'
      Required = True
      Size = 100
    end
    object osRptQueryREPDATE: TDateTimeField
      DefaultExpression = 'sysdate'
      DisplayLabel = 'Дата'
      FieldName = 'REPDATE'
      ReadOnly = True
      DisplayFormat = 'dd.mm.yyyy'
    end
    object osRptQueryCOMMENTS: TStringField
      DisplayLabel = 'Комментарий'
      FieldName = 'COMMENTS'
      Visible = False
      Size = 100
    end
    object osRptQueryUSERNAME: TStringField
      DefaultExpression = 'USER'
      DisplayLabel = 'Пользов.'
      FieldName = 'USERNAME'
      Visible = False
      Size = 30
    end
    object osRptQueryID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object osRptQueryMIPODSIS_KOD: TIntegerField
      Tag = 2
      DisplayLabel = 'Подсистема'
      DisplayWidth = 2
      FieldName = 'MIPODSIS_KOD'
      Visible = False
    end
    object osRptQueryWINCLASS: TStringField
      Tag = 2
      DisplayWidth = 20
      FieldName = 'WINCLASS'
      Visible = False
      Size = 100
    end
  end
  object quNewMajors: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MAJOR_SQL_REP'
      '( DRAFT_REP_ID,TABLE_NAME,FIELD_NAME'
      '  ,CONDITION,VALUE,RESTYPE,RESERVED)'
      
        'VALUES(:RptId,:TabName,:FldName,:Cond,:Value,:ResType,empty_blob' +
        '())'
      'returning RESERVED into :Res')
    Session = dmGlobal.seOracle
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Variables.Data = {
      0300000007000000060000003A52505449440300000000000000000000000800
      00003A5441424E414D45050000000000000000000000080000003A464C444E41
      4D45050000000000000000000000050000003A434F4E44030000000000000000
      000000060000003A56414C5545050000000000000000000000080000003A5245
      5354595045030000000000000000000000040000003A52455371000000000000
      0000000000}
    Cursor = crSQLWait
    StringFieldsOnly = False
    Threaded = False
    ThreadSynchronized = True
    Left = 90
    Top = 8
  end
  object quNewMinors: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO MINOR_SQL_REP(DRAFT_REP_ID,ORDER_TEXT,FILTER_TEXT,MA' +
        'IN_TABLE)'
      'VALUES(:RptId,:OrderText,:FilterText,:MainTable)'
      ' ')
    Session = dmGlobal.seOracle
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Variables.Data = {
      0300000004000000060000003A52505449440300000000000000000000000A00
      00003A4F52444552544558540500000000000000000000000B0000003A46494C
      544552544558540500000000000000000000000A0000003A4D41494E5441424C
      45050000000000000000000000}
    Cursor = crSQLWait
    StringFieldsOnly = False
    Threaded = False
    ThreadSynchronized = True
    Left = 18
    Top = 8
  end
  object quCurRpt: TOracleQuery
    SQL.Strings = (
      'SELECT NAME FROM DRAFT_REP'
      'WHERE ID= :RptId')
    Session = dmGlobal.seOracle
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Variables.Data = {0300000001000000060000003A5250544944030000000000000000000000}
    Cursor = crDefault
    StringFieldsOnly = False
    Threaded = False
    ThreadSynchronized = True
    Left = 88
    Top = 56
  end
  object quClear1: TOracleQuery
    SQL.Strings = (
      'DELETE FROM MINOR_SQL_REP WHERE DRAFT_REP_ID= :RptId')
    Session = dmGlobal.seOracle
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Variables.Data = {0300000001000000060000003A5250544944030000000000000000000000}
    Cursor = crSQLWait
    StringFieldsOnly = False
    Threaded = False
    ThreadSynchronized = True
    Left = 160
    Top = 8
  end
  object quClear2: TOracleQuery
    SQL.Strings = (
      'DELETE FROM MAJOR_SQL_REP WHERE DRAFT_REP_ID= :RptId'
      ' ')
    Session = dmGlobal.seOracle
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Variables.Data = {0300000001000000060000003A5250544944030000000000000000000000}
    Cursor = crSQLWait
    StringFieldsOnly = False
    Threaded = False
    ThreadSynchronized = True
    Left = 160
    Top = 56
  end
end
