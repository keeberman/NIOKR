unit v_Child;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_anyform, ExtCtrls,DBGrids, vdbASUP, DB, v_ASUPForm, registry, v_sqldesc;

const
  UNASSIGNED= -1;
type
  TPreIdx= record
             Field: TField;
             PreIndex: Integer;
           end;

  PTPreIdx= ^TPreIdx;


  TfmChild = class(TfmASUPForm)
           {Форма-предок для дочерних окон приложения,
            работающих с панелью инструментов главной формы}

    procedure FormActivate(Sender: TObject);
              {Обработчик события OnActivate формы.
              Посылает себе сообщение UM_OTHERS с lParam= IN_ACTIVATE}

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
              //Обработчик события OnCreate формы

  private
    FAccess: TAccessLevel;
    FDataCount: Integer;

    procedure SetRecCount(const Value: Integer);
    procedure SetShowSQLDescriptForm(const Value: bool);
    function GetShowSQLDescriptForm:bool;
  protected
    FdsLocal: TDataSource;
    FdsNavi: TDataSource;
    FSender: TObject;
    FTreeSQLDescription: TTreeSQLDescription;
    procedure UMOthers(var Message:TMessage);message UM_OTHERS;
              {Перехват сообщения UM_OTHERS. Служит для передачи
              инструкций от панели инструментов главной формы
              дочерним окнам}

    procedure FillPropertyList(ADataSet: TDataSet);virtual;
              {Заполнение StoredProps компонента fsFields из dmGlobal.
              свойствами, сохраняемыми в системном реестре}

    procedure SaveFieldIndexes(ADataSet: TDataSet);

    procedure RestoreFieldIndexes(ADataSet: TDataSet);

    procedure RestoreORDERBY(ADataSet: TVASUPQuery);
              //Восстановление предложения Order By, из системного реестра

    procedure RestoreSavings;virtual;
              //Восстановление свойств, сохраненных в системном реестре

    procedure ShowSQLDescription(AQuery:TVASUPQuery = nil);virtual;

    procedure RestoreRollPanel(ARegIniFile : TRegIniFile; APanel : TCustomPanel);
    procedure SaveRollPanel(ARegIniFile : TRegIniFile; APanel : TCustomPanel);

    procedure SaveRollPanels; virtual;
    procedure RestoreRollPanels; virtual;
  public
    { Public declarations }

     property SenderControl:TObject read FSender write FSender;
     property dsLocal: TDataSource read FdsLocal;
              //Определяет DataSource, нацеленный на DataSet дочернего окна

     property AccessRights:TAccessLevel read FAccess write FAccess;
              //Права доступа к dsLocal.DataSet

     property DataCount:Integer read FDataCount write SetRecCount;
              //Количество строк dsLocal.DataSet

     function GetDataCount:Integer;virtual;
              {Возвращает количество строк dsLocal.DataSet
              через select count(*) from ...}

     procedure ClearDataCount;
               {Устанавливает FDataCount равным UNASSIGNED,
               что при обращении к DataCount вызывает GetDataCount}

     procedure EraseRegSavings;
     procedure EraseRegRollPanels; virtual;

     property ShowSQLDescriptForm: bool read GetShowSQLDescriptForm
           write SetShowSQLDescriptForm;

  end;

function IsRollPanel(APanel : TCustomPanel) : boolean;

var
  fmChild: TfmChild;

implementation

uses {MENUGnrl, globals,}OracleData, MENUGnrl, globals, TypInfo;

{$R *.DFM}

function IsRollPanel(APanel : TCustomPanel) : boolean;
var
  LClass : TClass;
begin
  Result := false;
  LClass := APanel.ClassType;
  while (not LClass.ClassNameIs('TCustomPanel')) and (not Result) do
    if LClass.ClassNameIs('TRollPanel') then
      Result := true
    else
      LClass := LClass.ClassParent;
end;

procedure TfmChild.EraseRegSavings;
var
  SectList: TStrings;
  I: Integer;
begin
  SectList:= TStringList.Create;
  with TRegIniFile.Create(StorageSection+FDsLocal.DataSet.Name) do
  begin
    ReadSections(SectList);
    for I:= 0 to SectList.Count-1 do
      EraseSection(SectList[I]);
    SectList.Free;
    Free;
  end;
  with TRegIniFile.Create(StorageSection) do
  begin
    EraseSection(FDsLocal.DataSet.Name);
    Free;
  end;
end;

procedure TfmChild.UMOthers(var Message:TMessage);
begin
  case Message.wParam of
    IN_ACTIVATE:
    begin
      Application.MainForm.Perform(UM_OTHERS,IN_NAVIGATOR,0);
      Application.MainForm.Perform(UM_OTHERS,IN_DIRECTLIST,0);
    end;
    IN_GETSENDER:Message.Result:= Integer(SenderControl);
    IN_GETACCESS:Message.Result:= Integer(@FAccess);
    IN_SETACCESS:Move(Pointer(Message.lParam)^,FAccess,SizeOf(FAccess));
    IN_GETDATASET:Message.Result:= Integer(FdsLocal.DataSet);
    IN_GETRECORDCOUNT:
    begin
      if FDataCount=UNASSIGNED then FDataCount:= GetDataCount;
      Message.Result:= FDataCount;
    end;
    IN_REFRESH: begin
      Screen.Cursor:= crSQLWait;
      FdsLocal.DataSet.Refresh;
      ClearDataCount;
      Perform(UM_OTHERS,IN_STATUS,0);
      Application.MainForm.Perform(UM_OTHERS,IN_REFRESH,0);
      Screen.Cursor:= crDefault;
    end;
    IN_STATUS:
    begin
      fmMainMenu.ShowRecordCount;
      fmMainMenu.sbMain.Panels[2].Text:= '';
    end;
    IN_STORE:
    begin
      FillPropertyList(FDsLocal.DataSet);
      dmGlobal.fsFields.SaveFormPlacement;
      SaveFieldIndexes(FDsLocal.DataSet);
      SaveRollPanels;
    end;
    IN_UNSTORE:
    begin
      EraseRegSavings;
      EraseRegSavings;
    end;
  end;
end;// WMOTHERS

procedure TfmChild.FormActivate(Sender: TObject);
begin
  inherited;
  Perform(UM_OTHERS,IN_ACTIVATE,0);
  if not fmSQLDescript.Closing then
  fmSQLDescript.Visible:= ((fmSQLDescript.Caller= Self)
    or (fmSQLDescript.Caller= Self.Owner)) and Assigned(fmSQLDescript.Caller);
end;// FormActivate

function TfmChild.GetDataCount:Integer;
begin
  if not Assigned(FdsLocal.DataSet) then Result:= 0
  else
    if not FdsLocal.DataSet.Active then
      Result:= 0
    else
      if FdsLocal.DataSet is TVASUPQuery then
        with FdsLocal.DataSet as TVASUPQuery do
          if IsQuery then Result:= 0
          else if QueryAllRecords then Result:= RecordCount
               else Result:= SQLRecordCount
      else Result:= FdsLocal.DataSet.RecordCount;
  FDataCount:= Result;
end;// GetDataCount

procedure TfmChild.SetRecCount(const Value: Integer);
begin
  if not (FDataCount=UNASSIGNED) then
    FDataCount:= Value
end;// SetRecCount

procedure TfmChild.FormCreate(Sender: TObject);
begin
  inherited;
  FDataCount:= UNASSIGNED;
  FTreeSQLDescription:= TTreeSQLDescription.Create;
end;// FormCreate

procedure TfmChild.ClearDataCount;
begin
  FDataCount:= UNASSIGNED;
end;

procedure TfmChild.RestoreORDERBY(ADataSet: TVASUPQuery);
begin
  with dmGlobal.fsFields do
  begin
    IniFileName:= StorageSection+ADataSet.Name;
    StoredProps.Clear;
    StoredProps.AddObject(Concat(ADataSet.Name,'.','Order'),ADataSet);
    RestoreFormPlacement;
    StoredProps.Clear;
  end;
end;

procedure TfmChild.FillPropertyList(ADataSet: TDataSet);
var
  I: Integer;
begin
  with dmGlobal.fsFields do
  begin
    IniFileName:= StorageSection+ADataSet.Name;
    StoredProps.Clear;
    if ADataSet is TVASUPQuery then
       StoredProps.AddObject(Concat(ADataSet.Name,'.','Order'),ADataSet);

  Exit;
{ LAP: Проблема с прорпорциональными шрифтами, когда TColumn производит пересчет
         размера всех полей по среднему (из за одного), и нефиг такую хрень сохранять
}
    for I:= 0 to ADataset.FieldCount-1 do
    begin
      StoredProps.AddObject( Concat(ADataSet.Fields[I].Name,'.','DisplayWidth')
                             ,ADataSet.Fields[I]);
      {StoredProps.AddObject( Concat(ADataSet.Fields[I].Name,'.','Index')
                             ,ADataSet.Fields[I]);}
      StoredProps.AddObject( Concat(ADataSet.Fields[I].Name,'.','Alignment')
                             ,ADataSet.Fields[I]);
    end;
  end;
end;

procedure TfmChild.RestoreSavings;
begin
  FillPropertyList(FdsLocal.DataSet);
  dmGlobal.fsFields.RestoreFormPlacement;
  RestoreFieldIndexes(FdsLocal.DataSet);
end;

procedure TfmChild.SaveFieldIndexes(ADataSet: TDataSet);
var
  I: Integer;
begin
  with TRegIniFile.Create(StorageSection+ADataSet.Name) do
  begin
    for I:= 0 to ADataSet.FieldCount-1 do
      WriteInteger( dmGlobal.Name{ADataSet.Name},
                    Format('%s_Index',
                    [ADataSet.Fields[I].Name])
                    ,ADataSet.Fields[I].Index);
    Free;
  end;
end;

function PreIdxCompare(Item1, Item2: Pointer): Integer;
begin
  Result:= PTPreIdx(Item1)^.PreIndex-PTPreIdx(Item2)^.PreIndex
end;

procedure TfmChild.RestoreFieldIndexes(ADataSet: TDataSet);
var
  I: Integer;
  FieldList: TList;
  PreIdx: PTPreIdx;
begin
  with TRegIniFile.Create(StorageSection+ADataSet.Name) do
  begin
    FieldList:= TList.Create;
    for I:= 0 to ADataSet.FieldCount-1 do
    begin
      New(PreIdx);
      PreIdx^.Field:= ADataSet.Fields[I];
      FieldList.Add(PreIdx);
    end;
    for I:= 0 to FieldList.Count-1 do
      PTPreIdx(FieldList[I])^.PreIndex:= ReadInteger( dmGlobal.Name{ADataSet.Name},
                   Format('%s_Index',[PTPreIdx(FieldList[I])^.Field.Name])
                   ,PTPreIdx(FieldList[I])^.Field.Index);
    FieldList.Sort(PreIdxCompare);
    for I:= 0 to FieldList.Count-1 do
    begin
      PTPreIdx(FieldList[I])^.Field.Index:= PTPreIdx(FieldList[I])^.PreIndex;
      Dispose(PTPreIdx(FieldList[I]));
    end;
    FieldList.Free;
    Free;
  end;
end;

procedure TfmChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if fmSQLDescript.Caller=Self then
  begin
    fmSQLDescript.Close;
    fmSQLDescript.Caller:= nil;
  end;
  Action:= caFree;
end;

function TfmChild.GetShowSQLDescriptForm:bool;
begin
  Result:= fmSQLDescript.Visible;
end;

procedure TfmChild.SetShowSQLDescriptForm(const Value: bool);
begin
  fmSQLDescript.Caller:= Self;
  fmSQLDescript.Visible:= Value;
  if not Value and (fmSQLDescript.Caller= Self) then
    fmSQLDescript.Caller:= nil;
  if Value then ShowSQLDescription;
end;

procedure TfmChild.ShowSQLDescription;
{var
  CurActiveControl: TWinControl;}
begin
  if FdsLocal.DataSet is TVASUPQuery then
  begin
    with FdsLocal.DataSet as TVASUPQuery do
        GetSQLDescription(IndexQuery,FTreeSQLDescription);
    //CurActiveControl:= ActiveControl;
    fmSQLDescript.ShowSQL(FTreeSQLDescription);
    fmMainMenu.SetFocus;
    //Activate;
    //SetMDIFocus(fmMainMenu,Self);
    //Show;
    //SetFocusedControl(CurActiveControl);
    FTreeSQLDescription.Clear;
  end;
end;

procedure TfmChild.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   if (Key = VK_F7) and (Shift=[ssShift]) then
     ShowSQLDescriptForm:= not ShowSQLDescriptForm;
end;

procedure TfmChild.FormDestroy(Sender: TObject);
begin
  inherited;
  FTreeSQLDescription.Free;
end;

procedure TfmChild.SaveRollPanel(ARegIniFile : TRegIniFile; APanel : TCustomPanel);
var
  PropInfo: PPropInfo;
begin
  PropInfo:= GetPropInfo(APanel.ClassInfo,'RolledUp');
  ARegIniFile.WriteBool(APanel.Name,
                        'RolledUp',
                        Bool(GetOrdProp(APanel,PropInfo)));
end;

procedure TfmChild.RestoreRollPanel(ARegIniFile : TRegIniFile; APanel : TCustomPanel);
var
  PropInfo: PPropInfo;
begin
  PropInfo:= GetPropInfo(APanel.ClassInfo,'RolledUp');
  SetOrdProp(APanel,
             PropInfo,
             LongInt(ARegIniFile.ReadBool(APanel.Name,
                                          'RolledUp',
                                          Bool(GetOrdProp(APanel,PropInfo)))));
end;

procedure TfmChild.SaveRollPanels;
var
  I, J : Integer;
  AreaList: TList;
  WorkArea: TComponent;
  RegIniFile : TRegIniFile;
begin
  AreaList:= TList.Create;
  RegIniFile := TRegIniFile.Create(StorageSection + ClassName+'\RollPanell');
  AreaList.Add(Self);
  for I:= 0 to ComponentCount-1 do
    if Components[I] is TFrame then
      AreaList.Add(Components[I]);
  with RegIniFile do
  begin
    for I:= 0 to AreaList.Count-1 do
    begin
      WorkArea:= TComponent(AreaList[I]);
      with WorkArea do
        for J:= 0 to ComponentCount-1 do
        begin
          if (Components[J] is TCustomPanel) and IsRollPanel(TCustomPanel(Components[J])) then
            SaveRollPanel(RegIniFile, TCustomPanel(Components[J]));
        end;
    end;

    AreaList.Free;
    Destroy;
  end;
end;

procedure TfmChild.RestoreRollPanels;
var
  I : Integer;
  RegIniFile : TRegIniFile;
  strs : TStrings;
  panel : TObject;
  Field : Pointer;
begin
  RegIniFile := TRegIniFile.Create(StorageSection + ClassName+'\RollPanell');
  strs := TStringList.Create;
  RegIniFile.GetKeyNames(strs);
  for I:= 0 to strs.Count - 1 do
  begin
    Field := Self.FieldAddress(strs[I]);
    if Assigned(Field) then
    begin
      try
        panel := TObject(Field^);
        if (panel is TCustomPanel) and IsRollPanel(TCustomPanel(panel)) then
          RestoreRollPanel(RegIniFile, TCustomPanel(panel));
      except
      end;
    end;
  end;
  strs.Destroy;
end;

procedure TfmChild.EraseRegRollPanels;
var
  SectList: TStrings;
  I: Integer;
begin
  SectList:= TStringList.Create;
  with TRegIniFile.Create(StorageSection + ClassName+'\RollPanell') do
  begin
    ReadSections(SectList);
    for I:= 0 to SectList.Count-1 do
      EraseSection(SectList[I]);
    SectList.Free;
    Free;
  end;
  with TRegIniFile.Create(StorageSection + ClassName) do
  begin
    EraseSection(FDsLocal.DataSet.Name);
    Free;
  end;
end;

end.
