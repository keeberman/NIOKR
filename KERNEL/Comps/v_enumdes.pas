unit v_enumdes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Menus, db, vdbASUP, Variants;

type
  TEnumDesigner = class(TForm)
    lbText: TListBox;
    pmOper: TPopupMenu;
    vpAdd: TMenuItem;
    vpDelete: TMenuItem;
    vpEdit: TMenuItem;
    vpDelAll: TMenuItem;
    rgUnion: TRadioGroup;
    procedure pmOperPopup(Sender: TObject);
    procedure MenuItemsClick(Sender:TObject);
    procedure EditItemClick(Sender:TObject);
    procedure AddItemClick(Sender:TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rgUnionClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbTextDblClick(Sender: TObject);
  private
    { Private declarations }
    FQueryValList: TVEnumValueList;
    FDataField: TField;
    FCaptnPart: string;
    procedure SetMenuItems;
  public
    { Public declarations }
    property QueryValList:TVEnumValueList read FQueryValList write FQueryValList;
    property QueryField: TField read FDataField write FDataField;
    procedure RefreshList;
  end;

var
  EnumDesigner: TEnumDesigner;

implementation

uses v_edcnd;

{$R *.DFM}

function VariantToStr(Const Value: Variant):string;
begin
  if VarType(Value) in [varNull,varEmpty] then Result:= ''
  else Result:= Value;
end;

procedure TEnumDesigner.SetMenuItems;
begin
  vpDelete.Enabled:= (lbText.ItemIndex>=0);
  vpEdit.Enabled:= (lbText.ItemIndex>=0);
  vpDelAll.Enabled:= (lbText.Items.Count>0);
end;

procedure TEnumDesigner.pmOperPopup(Sender: TObject);
begin
  SetMenuItems;
end;

procedure TEnumDesigner.MenuItemsClick(Sender:TObject);
begin
  if Sender=vpDelete then
  begin
    QueryValList.Delete(lbText.ItemIndex);
    lbText.Items.Delete(lbText.ItemIndex)
  end
  else if Sender= vpDelAll then
  begin
    QueryValList.Clear;
    lbText.Items.Clear
  end;
  SetMenuItems;
end;

procedure TEnumDesigner.RefreshList;
begin
  lbText.Items.Clear;
  lbText.Items.AddStrings(QueryValList);
end;

procedure TEnumDesigner.FormShow(Sender: TObject);
begin
  RefreshList;
  Caption:= Concat(FCaptnPart,' - ',FDataField.DisplayLabel);
  if FDataField.DataSet is TVASUPQuery then
     if Assigned(TVASUPQuery(FDataField.DataSet).Master) then
        Caption:= Format( '%s (%s)',
                  [Caption,TVASUPQuery(FDataField.DataSet).Caption]);
  rgUnion.Visible:= (Self.Owner is TVWatchEdit) and
    (TVWatchEdit(Self.Owner).DataSource.Dataset is TVASUPQuery)
    and Assigned(TVASUPQuery(TVWatchEdit(Self.Owner).DataSource.DataSet).Master);
  if rgUnion.Visible then
     rgUnion.ItemIndex:= Ord(FQueryValList.Union);
end;

procedure TEnumDesigner.FormCreate(Sender: TObject);
begin
  FCaptnPart:= Caption;
end;

procedure TEnumDesigner.EditItemClick(Sender:TObject);
var
  TmpVal: Variant;
begin
  fmCndEdit:= TfmCndEdit.Create(Self);
  with fmCndEdit do
  begin
    Field:= FDataField;
    mePoint.EditText:= VariantToStr(TVDataContainer(QueryValList.Objects[lbText.ItemIndex]).Point);
    meStart.EditText:= VariantToStr(TVDataContainer(QueryValList.Objects[lbText.ItemIndex]).StartInt);
    meFinish.EditText:= VariantToStr(TVDataContainer(QueryValList.Objects[lbText.ItemIndex]).FinishInt);
    if Self.Owner is TVWatchEdit then
    begin
      QueryControl:= TVWatchEdit(Self.Owner);
      DataKind:= dkHandBook;
    end;
    if ShowModal=mrOk then
    begin
      //FDataField.DataSet.DisableControls;
      try
        if Length(mePoint.EditText)>0 then
        begin
          FDataField.AsString:= mePoint.Text;
          TVDataContainer(QueryValList.Objects[lbText.ItemIndex]).SetPoint(FDataField.Value);
        end
        else
        begin
          FDataField.AsString:= meStart.Text;
          TmpVal:= FDataField.Value;
          FDataField.AsString:= meFinish.Text;
          TVDataContainer(QueryValList.Objects[lbText.ItemIndex]).SetInterval(TmpVal,FDataField.Value);
        end;
        with QueryValList do
        begin
          Strings[lbText.ItemIndex]:= GetDisplayText(lbText.ItemIndex,elHint,FDataField);
          lbText.Items[lbText.ItemIndex]:= Strings[lbText.ItemIndex];
        end;
      finally
        FDataField.Clear;
        //FDataField.DataSet.EnableControls;
      end;
    end;
    Free;
  end;
end;

procedure TEnumDesigner.AddItemClick(Sender:TObject);
var
  Tmpval: Variant;
begin
  fmCndEdit:= TfmCndEdit.Create(Self);
  with fmCndEdit do
  begin
    Field:= FDataField;
    if Self.Owner is TVWatchEdit then
    begin
      QueryControl:= TVWatchEdit(Self.Owner);
      DataKind:= dkHandBook;
    end;
    if ShowModal=mrOk then
    begin
      //FDataField.DataSet.DisableControls;
      try
        if Length(mePoint.EditText)>0 then
        begin
          FDataField.AsString:= mePoint.Text;
          QueryValList.AddPoint(FDataField.DisplayText,FDataField.Value)
        end
        else
        begin
          FDataField.AsString:= meStart.Text;
          TmpVal:= FDataField.Value;
          FDataField.AsString:= meFinish.Text;
          QueryValList.AddInterval('',TmpVal,FDataField.Value);
        end;
        with QueryValList do
        begin
          Strings[Count-1]:= GetDisplayText(Count-1,elHint,FDataField);
          lbText.Items.Add(Strings[Count-1]);
        end;
      finally
        FDataField.Clear;
        //FDataField.DataSet.EnableControls;
      end;
    end;
    Free;
  end;
end;

procedure TEnumDesigner.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  //if QueryValList.Count=0 then (Owner as TVQryEdit).QueryState:= piNone;
end;

procedure TEnumDesigner.rgUnionClick(Sender: TObject);
begin
  if rgUnion.ItemIndex= 0 then
     FQueryValList.Union:= unOR
  else FQueryValList.Union:= unAND;
end;

procedure TEnumDesigner.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TEnumDesigner.lbTextDblClick(Sender: TObject);
begin
  if lbText.ItemIndex>=0 then
    EditItemClick(Sender);
end;

end.
