unit v_fmgen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, RXDBCtrl, Db, RxMemDS, StdCtrls, ExtCtrls, Designintf,
  DBCtrls, DesignEditors;

const
  cl_text = 'TDBText';
  cl_numedit = 'TVDBEMath';
  cl_charedit = 'TVDBEditChar';
  cl_langedit = 'TVDBERus';
  cl_dateedit = 'TVDBEDate';
  cl_btnedit  = 'TVWatchEdit';
  cl_lookup   = 'TrxDBLookUpCombo';
type

  TEditFormIDEditor= class(TDefaultEditor)
    procedure CheckDataSet(const Value: string);
    procedure CheckPanel(const Value: string);
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
 end;


  TfmFormGenerator = class(TForm)
    paTop: TPanel;
    laDataSet: TLabel;
    cbDataSet: TComboBox;
    taMap: TRxMemoryData;
    taMapField: TStringField;
    taMapcontrol: TStringField;
    taMapBox: TStringField;
    dsMap: TDataSource;
    DBGrid: TRxDBGrid;
    paBottom: TPanel;
    bRun: TButton;
    bClose: TButton;
    laPanel: TLabel;
    cbPanel: TComboBox;
    nvMap: TDBNavigator;
    procedure cbDataSetChange(Sender: TObject);
    procedure bRunClick(Sender: TObject);
  private
    { Private declarations }
    FDataSet: TDataSet;
    FWorkArea: TWinControl;

    function GetControlClassName(AField: TField): string;
  public
    { Public declarations }
    Designer: IDesigner; //IFormDesigner;
    property WorkArea: TWinControl read FWorkArea write FWorkArea;
    procedure Initialize;
  end;

var
  fmFormGenerator: TfmFormGenerator;

implementation
uses typinfo;
{$R *.DFM}

procedure TEditFormIDEditor.CheckDataSet(const Value: string);
begin
 with fmFormGenerator.cbDataSet.Items do
   if IndexOf(Value)<0 then
     Add(Value);
end;

procedure TEditFormIDEditor.CheckPanel(const Value: string);
begin
 with fmFormGenerator.cbPanel.Items do
   if IndexOf(Value)<0 then
     Add(Value);
end;

procedure TEditFormIDEditor.ExecuteVerb(Index: Integer);
var
  TypeData: PTypeData;
  PropInfo: PPropInfo;
  PropValue: Pointer;
begin
  if (Index = 0) and (Component.Owner is TWinControl) then
  begin
    fmFormGenerator:= TfmFormGenerator.Create(nil);
    TypeData := GetTypeData(TDataset.ClassInfo);
    Designer.GetComponentNames(TypeData, CheckDataSet);
    TypeData := GetTypeData(TPanel.ClassInfo);
    Designer.GetComponentNames(TypeData, CheckPanel);
    PropInfo:= GetPropInfo(Component.ClassInfo,'DataSource');
    if Assigned(PropInfo) then
      PropValue:= Pointer(GetOrdProp(Component,PropInfo))
    else PropValue:= nil;
    with fmFormGenerator do
    begin
      Designer:= Self.Designer;
      WorkArea:= Self.Component.Owner as TWinControl;
      if PropValue<>nil then
        cbDataSet.Text:=
          Self.Designer.GetComponentName(TDataSource(PropValue).DataSet);
    end;
    PropInfo:= GetPropInfo(Component.ClassInfo,'Panel');
    if Assigned(PropInfo) then
      PropValue:= Pointer(GetOrdProp(Component,PropInfo))
    else PropValue:= nil;
    with fmFormGenerator do
    begin
      if PropValue<>nil then
        cbPanel.Text:=
          Self.Designer.GetComponentName(TPanel(PropValue));
      DBGrid.Columns[2].PickList.Clear;
      DBGrid.Columns[2].PickList.AddStrings(cbPanel.Items);
      if ShowModal=mrOK then
         Designer.Modified;
      Free;
    end;
  end;
end;

function TEditFormIDEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'FormGenerator';
end;

function TEditFormIDEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TfmFormGenerator.Initialize;
begin
  taMap.Close;
  FDataSet:= nil;
end;

function TfmFormGenerator.GetControlClassName(AField: TField): string;
begin
  if AField.FieldKind= fkCalculated then
    Result:= cl_text
  else
  begin
    if AField is TDateTimeField then
      Result:= cl_dateedit
    else if AField is TStringField then
    begin
      if (Pos('_NAIM',AField.FieldName)>0) or
         (Pos('_NAME',AField.FieldName)>0) then
         Result:= cl_text
      else Result:= cl_langedit;
    end
    else if AField is TNumericField then
    begin
      if (Pos('_KOD',AField.FieldName)>0) or
         (Pos('_CODE',AField.FieldName)>0) then
         Result:= cl_btnedit
      else Result:= cl_numedit;
    end
    else Result:= '';
  end;
end;

procedure TfmFormGenerator.cbDataSetChange(Sender: TObject);
var
  NewValue: TComponent;
  I: Integer;
begin
  NewValue:= Designer.GetComponent(cbDataSet.Text);
  if (NewValue<>FDataSet) and (taMap.RecordCount>0) then
    if MessageDlg('Current data will be lost. Are you sure ?',
                  mtConfirmation,[mbYes,mbNo],0)<>mrYes then
    begin
      cbDataSet.Text:= Designer.GetComponentName(FDataSet);
      Exit;
    end;
  taMap.Close;
  if Assigned(NewValue) then
  begin
    FDataSet:= NewValue as TDataSet;
    taMap.Open;
    DBGrid.Columns[0].PickList.Clear;
    for I:= 0 to FDataSet.FieldCount-1 do
    begin
      if FDataSet.Fields[I].Visible then
        taMap.InsertRecord([UpperCase(FDataSet.Fields[I].FieldName),
                           GetControlClassName(FDataSet.Fields[I]),
                           '']
                           ) ;
      DBGrid.Columns[0].PickList.Add(taMapField.AsString);
    end;
  end
  else
    MessageDlg('Unable to find a dataset',mtError,[mbOk],0);
end;

procedure TfmFormGenerator.bRunClick(Sender: TObject);
var
  MapBookMark: TBookMarkStr;
  xLast,yLast: Integer;
  Box, Box0: TWinControl;
begin
  MapBookMark:= taMap.BookMark;
  taMap.DisableControls;
  taMap.First;
  xLast:= 0;
  yLast:= 2;
  Box0:= Designer.GetComponent(cbPanel.Text) as TWinControl;
  while not taMap.EOF do
  begin
    Inc(xLast,5);
    if not taMapBox.IsNull then
      Box:= Designer.GetComponent(taMapBox.AsString) as TWinControl
    else Box:= Box0;
    if Box<>nil then
      with GetClass(taMapControl.AsString).Create do
      begin
      
      end
    else MessageDlg('Unable to find a box',mtError,[mbOk],0);
    taMap.Next;
  end;
end;

end.
