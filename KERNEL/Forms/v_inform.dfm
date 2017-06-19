object dmInform: TdmInform
  OldCreateOrder = False
  Left = 193
  Top = 226
  Height = 480
  Width = 696
  object odInform: TOracleDataSet
    SQL.Strings = (
      'select'
      'i.id, i.subj, i.d_create, i.text'
      'from'
      'mirol r,'
      'mipolz u,'
      'inform_who iw,'
      'inform i'
      'where'
      'i.subsystem=:subsys'
      'and trunc(sysdate) between i.d_begin and i.d_end'
      'and i.id=iw.inform_id and u.mipodsis_kod=:subsys'
      'and u.oranaim=user and u.mirol_kod=r.kod'
      'and iw.addressee in ('#39'PUBLIC'#39',u.oranaim,r.oranaim)'
      'order by id')
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
      03000000040000000200000049440100000000040000005355424A0100000000
      08000000445F435245415445010000000004000000544558540100000000}
    Cursor = crDefault
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
    Left = 40
    Top = 16
    object odInformID: TFloatField
      DisplayLabel = 'Номер'
      FieldName = 'ID'
      Required = True
    end
    object odInformSUBJ: TStringField
      DisplayLabel = 'Тема'
      DisplayWidth = 30
      FieldName = 'SUBJ'
      Required = True
      Size = 100
    end
    object odInformD_CREATE: TDateTimeField
      DisplayLabel = 'Дата создания'
      DisplayWidth = 16
      FieldName = 'D_CREATE'
      Required = True
      DisplayFormat = 'dd.mm.yyyy hh:nn'
    end
    object odInformTEXT: TStringField
      DisplayLabel = 'Текст'
      FieldName = 'TEXT'
      Required = True
      Visible = False
      Size = 4000
    end
  end
end
