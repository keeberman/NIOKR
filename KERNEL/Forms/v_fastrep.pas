unit v_fastrep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, TB97Ctls,v_repdet, StdCtrls, Mask, DBCtrls, vDbASUP,
  ExtCtrls, Db, ToolWin, ImgList, Variants;

const
  RptQueryMsg= 'Выполнить запрос для отчета ?';
  RptReplaceMsg= 'Заменить существующий отчет?';
  CNewRpt= 'Новый';
  //CLenNodeText= 'Длина %d';
  CUseLimit= 'Учесть ограничения';
  CNoUseLimit= 'Не учитывать ограничения';

type
  TfmFastRep = class(TForm)
    imTree: TImageList;
    pmOptions: TPopupMenu;
    miAddTable: TMenuItem;
    miDelTable: TMenuItem;
    miSep1: TMenuItem;
    miAddField: TMenuItem;
    miDelField: TMenuItem;
    miSep2: TMenuItem;
    miAllExpand: TMenuItem;
    miAllCollapse: TMenuItem;
    tvFastRep: TTreeView;
    ToolBar: TToolBar;
    tlbnew: TToolButton;
    tlbsave: TToolButton;
    ToolButton3: TToolButton;
    tlbPreview: TToolButton;
    tlbPrint: TToolButton;
    ToolButton6: TToolButton;
    tlbClose: TToolButton;
    imlTools: TImageList;
    dsRpt: TDataSource;
    paTop: TPanel;
    laComment: TLabel;
    deComment: TVDBERus;
    tlbOpen: TToolButton;
    ImState: TImageList;
    miLimit: TMenuItem;
    procedure tlbNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tlbCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmOptionsPopup(Sender: TObject);
    procedure OptionClick(Sender: TObject);
    procedure tlbSaveClick(Sender: TObject);
    procedure tvFastRepDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvFastRepDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure tvFastRepEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure tlbPreviewClick(Sender: TObject);
    procedure tvFastRepEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure tlbPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tlbOpenClick(Sender: TObject);
    procedure miLimitClick(Sender: TObject);
  private
    { Private declarations }
    FCurKL: HKL;
    FRepDetails: TfmRepDetails;
    FUsedTables: TList;
    FCurRptId: Integer;
    FHeader: string;
    function GetCard: TForm;
    procedure SaveRptTables;
    procedure SaveRptFields;
    procedure GenerateRpt;
    procedure CloseDataSets;
    procedure LoadTree;
    procedure AddMinimals;
  public
    { Public declarations }
    property RptQueryId: Integer read FCurRptId write FCurRptId;
    property UsedTables: TList read FUsedTables;
    property Card: TForm read GetCard;
  end;

var
  fmFastRep: TfmFastRep;

implementation

uses globals,v_anyform,v_fastmod
     ,v_fast,v_savqmod,{vwstar,} v_rptopen, FR_CLASS, v_utils;

{$R *.DFM}

procedure TfmFastRep.AddMinimals;
var MainNode: TTreeNode;
    MainDataSet: TVASUPQuery;
    iSet: Integer;
    List: TList;
    iList: Integer;
    I: Integer;

procedure AddMainField(AField: TField);
var
  Len: Integer;
  NewNode: TTreeNode;
begin
  NewNode:= tvFastRep.Items.AddChildObject(MainNode
    ,AField.DisplayLabel,AField);
  with NewNode do
  begin
    ImageIndex:= Level;
    SelectedIndex:= Level;
    StateIndex:= -1;
  end;
  //Len:= Max( Length(AField.DisplayLabel),AField.DisplayWidth);
  Len:= AField.DisplayWidth;
  with tvFastRep.Items.AddChildObject(NewNode
    ,IntToStr(Len),Pointer(Len)) do
  begin
    ImageIndex:= Level;
    SelectedIndex:= Level;
    StateIndex:= -1;
  end;
end;

begin
  iSet:= Card.Perform(UM_FASTREPORT,IN_DEFAULT_DATASET,0);
  MainDataSet:= TVASUPQuery(iSet);
  MainNode:= tvFastRep.Items.Add(nil,MainDataSet.Caption);
  MainNode.Data:= Pointer(MainDataSet);
  List:= TList.Create;
  iList:= Integer(List);
  Card.Perform(UM_FASTREPORT,IN_DEFAULT_FIELDS,iList);
  for I:= 0 to List.Count-1 do AddMainField(TField(List[I]));
  List.Free;
  FUsedTables.Add(MainDataSet);
end;

procedure TfmFastRep.tlbNewClick(Sender: TObject);
begin
  tvFastRep.Items.Clear;
  FUsedTables.Clear;
  AddMinimals;
  Caption:= Format(FHeader,[CNewRpt]);
end;

procedure TfmFastRep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfmFastRep.tlbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmFastRep.FormCreate(Sender: TObject);
begin
  FRepDetails:= nil;
  FUsedTables:= TList.Create;
  dmFastReport:= TdmFastReport.Create(Self);
  dmSaveRptQuery:= TdmSaveRptQuery.Create(Self);
  FHeader:= Caption;
  Caption:= Format(Caption,['?']);
end;

procedure TfmFastRep.FormDestroy(Sender: TObject);
begin
  FUsedTables.Free;
  dmFastReport.Free;
  dmSaveRptQuery.Free;
  fmFastRep:= nil;
  fmFastRpt:= nil;
  Card.Perform(UM_FASTREPORT,IN_CLOSE_FAST_FORM,0);
end;

procedure TfmFastRep.pmOptionsPopup(Sender: TObject);
var
  CurNode: TTreeNode;
begin
  CurNode:= tvFastRep.Selected;
  if Assigned(CurNode) then
  begin
    miAddField.Enabled:= CurNode.Level<2;
    miDelField.Enabled:= (CurNode.Level=1);
    miDelTable.Enabled:= (CurNode.Level=0);
    miLimit.Visible:= (CurNode.Level=0);
    if miLimit.Visible then
       if CurNode.StateIndex<0 then
          miLimit.Caption:= CUseLimit
       else miLimit.Caption:= CNoUseLimit;
  end
  else
  begin
    miAddField.Enabled:= false;
    miDelField.Enabled:= false;
    miDelTable.Enabled:= false;
    miLimit.Visible:= false;
  end;
end;

procedure TfmFastRep.OptionClick(Sender: TObject);
var
  I: Integer;
  CurNode: TTreeNode;
  UsedFields: TList;
  List: TList;
  iList: Integer;

procedure FormUsedFields;
var
  Child: TTreeNode;
begin
  UsedFields.Clear;
  Child:= CurNode.GetFirstChild;
  while Assigned(Child) do
  begin
    UsedFields.Add(Child.Data);
    Child:= CurNode.GetNextChild(Child);
  end;
end;

procedure AddingDataSet(AsQuery: TVASUPQuery);
begin
    if (FUsedTables.IndexOf(AsQuery)<0) then
     FRepDetails.lbObjects.Items.AddObject(
       TVASUPQuery(AsQuery).Caption,AsQuery);
end;

begin
  if Sender= miAddTable then
  begin
    if not Assigned(FRepDetails) then
      FRepDetails:= TfmRepDetails.Create(Self);
    FRepDetails.Caption:= 'Таблицы';
    FRepDetails.SelectedNode:= nil;
    FRepDetails.TreeNodes:= tvFastRep.Items;
    FRepDetails.lbObjects.Items.Clear;
    List:= TList.Create;
    iList:= Integer(List);
    Card.Perform(UM_FASTREPORT,IN_ENABLE_DATASETS,iList);
    for I:= 0 to List.Count-1 do
      if (TDataSet(List[I]) is TVASUPQuery) then
      begin
        if TDataSet(List[I]).Tag and OPENED_FLAG= OPENED_FLAG then
           TDataSet(List[I]).Tag:= TDataSet(List[I]).Tag - OPENED_FLAG;
        if TDataSet(List[I]).Active then
          TDataSet(List[I]).Tag:= TDataSet(List[I]).Tag + OPENED_FLAG;
        AddingDataSet(TVASUPQuery(TDataSet(List[I])));
      end;
    List.Free;
    FRepDetails.Show;
  end
  else if Sender= miAddField then
  begin
    if not Assigned(FRepDetails) then
      FRepDetails:= TfmRepDetails.Create(Self);
    CurNode:= tvFastRep.Selected;
    if CurNode.Level=1 then CurNode:= CurNode.Parent;
    FRepDetails.SelectedNode:= CurNode;
    FRepDetails.TreeNodes:= tvFastRep.Items;
    FRepDetails.Caption:= TVASUPQuery(CurNode.Data).Caption;
    with FRepDetails.lbObjects do
    begin
      Items.Clear;
      UsedFields:= TList.Create;
      FormUsedFields;
      for I:= 0 to TVASUPQuery(CurNode.Data).FieldCount-1 do
        if not( TVASUPQuery(CurNode.Data).Fields[I].Tag and FOREVER_HIDING_FIELDTAG
                = FOREVER_HIDING_FIELDTAG)
           and (UsedFields.IndexOf(TVASUPQuery(CurNode.Data).Fields[I])<0) then
           Items.AddObject( TVASUPQuery(CurNode.Data).Fields[I].DisplayLabel
                            ,TVASUPQuery(CurNode.Data).Fields[I]);
      UsedFields.Free;
    end;
    FRepDetails.Show;
  end
  else if (Sender= miDelField) or (Sender= miDelTable) then
    tvFastRep.Items.Delete(tvFastRep.Selected)
  else if Sender= miAllCollapse then tvFastRep.FullCollapse
  else if Sender= miAllExpand then tvFastRep.FullExpand;
end;

function TfmFastRep.GetCard: TForm;
begin
  Result:= Owner as TForm;
end;

function GetSiblingCount(Node: TTreeNode): Integer;
begin
  Result:= 0;
  while Assigned(Node) do
  begin
    Inc(Result);
    Node:= Node.GetNextSibling;
  end;
end;

procedure TfmFastRep.SaveRptTables;
var
  RptId,TabName,OrdNo,LabName,Limit: Variant;
  I,Total: Integer;
  CurNode: TTreeNode;
begin
  CurNode:= tvFastRep.Items.GetFirstNode;
  Total:= GetSiblingCount(CurNode);
  RptId:= VarArrayCreate([0,Total-1], varInteger);
  TabName:= VarArrayCreate([0,Total-1], varVariant);
  OrdNo:= VarArrayCreate([0,Total-1], varInteger);
  LabName:= VarArrayCreate([0,Total-1], varVariant);
  Limit:= VarArrayCreate([0,Total-1], varVariant);
  I:= 0;
  while Assigned(CurNode) do
  begin
    RptId[I]:= FCurRptId;
    TabName[I]:= TVASUPQuery(CurNode.Data).UpdatingTable;
    LabName[I]:= CurNode.Text;
    OrdNo[I]:= I;
    if CurNode.StateIndex<0 then Limit[I]:= 'N'
    else Limit[I]:= 'Y';
    CurNode:= CurNode.GetNextSibling;
    Inc(I);
  end;
  with dmFastReport.quNewTables do
  begin
    SetVariable('RptId', RptId);
    SetVariable('TabName', TabName);
    SetVariable('Label', LabName);
    SetVariable('OrdNo', OrdNo);
    SetVariable('Limit', Limit);
    Execute;
  end;
end;

procedure TfmFastRep.SaveRptFields;
var
  RptId,TabName,FldName,FldWidth
  ,LabName,OrdNo: Variant;
  I,Total: Integer;
  CurNode,ChildNode: TTreeNode;
begin
  Total:= 0;
  CurNode:= tvFastRep.Items.GetFirstNode;
  while Assigned(CurNode) do
  begin
    Inc(Total,GetSiblingCount(CurNode.GetFirstChild));
    CurNode:= CurNode.GetNextSibling;
  end;
  RptId:= VarArrayCreate([0,Total-1], varInteger);
  TabName:= VarArrayCreate([0,Total-1], varVariant);
  FldName:= VarArrayCreate([0,Total-1], varVariant);
  FldWidth:= VarArrayCreate([0,Total-1], varInteger);
  LabName:= VarArrayCreate([0,Total-1], varVariant);
  OrdNo:= VarArrayCreate([0,Total-1], varInteger);
  Total:= 0;
  CurNode:= tvFastRep.Items.GetFirstNode;
  while Assigned(CurNode) do
  begin
    ChildNode:= CurNode.GetFirstChild;
    I:=0;
    while Assigned(ChildNode) do
    begin
      with TField(ChildNode.Data) do
      begin
        RptId[Total]:= FCurRptId;
        TabName[Total]:= TVASUPQuery(CurNode.Data).UpdatingTable;
        FldName[Total]:= FieldName;
        FldWidth[Total]:= Integer(ChildNode.GetFirstChild.Data);
        LabName[Total]:= ChildNode.Text;
        OrdNo[Total]:= I;
        Inc(Total);
      end;
      ChildNode:= ChildNode.GetNextSibling;
      Inc(I);
    end;
    CurNode:= CurNode.GetNextSibling;
  end;
  with dmFastReport.quNewFields do
  begin
    SetVariable('RptId', RptId);
    SetVariable('TabName', TabName);
    SetVariable('FldName', FldName);
    SetVariable('FldWidth', FldWidth);
    SetVariable('LabName', LabName);
    SetVariable('OrdNo', OrdNo);
    Execute;
  end;
end;


procedure TfmFastRep.tlbSaveClick(Sender: TObject);
begin
  if deComment.Focused then
     deComment.Perform(CM_EXIT,0,0);
  Screen.Cursor:= crHourGlass;
  try
    if FCurRptId<>0 then
    begin
      if dmSaveRptQuery.osRptQuery.Modified then
         dmSaveRptQuery.osRptQuery.Post;
      with dmFastReport do
      begin
        quClear1.SetVariable('RptId',FCurRptId);
        quClear2.SetVariable('RptId',FCurRptId);
        quClear1.Execute;
        quClear2.Execute;
      end;
      SaveRptTables;
      SaveRptFields;
    end
    else if Card.Perform(UM_FASTREPORT,IN_SAVE_QUERY,0)<>0 then
    begin
      FCurRptId:= dmSaveRptQuery.osRptQueryID.AsInteger;
      SaveRptTables;
      SaveRptFields;
    end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfmFastRep.tvFastRepDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  DropSite: TTreeNode;
begin
  DropSite:= tvFastRep.GetNodeAt(X, Y);
  if (Sender= Source) and Assigned(DropSite)
     and (DropSite<>tvFastRep.Items.GetFirstNode)
     and (tvFastRep.Selected<>tvFastRep.Items.GetFirstNode) then
    Accept:= tvFastRep.Selected.Parent= DropSite.Parent
  else Accept:= false;
  if Accept then tvFastRep.DragCursor:= crHandPoint
  else tvFastRep.DragCursor:= crNoDrop;
end;

procedure TfmFastRep.tvFastRepDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  tvFastRep.Items.BeginUpdate;
  tvFastRep.Selected.MoveTo(tvFastRep.GetNodeAt(X, Y),naInsert);
  tvFastRep.Items.EndUpdate;
end;

procedure TfmFastRep.FormActivate(Sender: TObject);
begin
  {if Assigned(fmFastRpt)
     and Assigned(fmFastRpt.PreviewForm)
     and frFast.PreviewForm.Visible then
     frFast.PreviewForm.Show;}
end;


procedure TfmFastRep.tvFastRepEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit:= True;
  if AllowEdit then
    ReplaceKeyboardLayOut(FCurKL,CyrLayout);
end;

procedure TfmFastRep.GenerateRpt;
var
  CurNode: TTreeNode;
  v: TfrView;
begin
  Screen.Cursor:= crHourGlass;
  if Assigned(fmFastRpt) then
  begin
    fmFastRpt.Free;
    fmFastRpt:= nil;
  end;
  fmFastRpt:= TfmFastRpt.Create(Self);
  with fmFastRpt do
  begin
    dsReport.DataSet:= TDataSet(Card.Perform(UM_FASTREPORT,IN_DEFAULT_DATASET,0));
    v:= frReport.Pages[0].FindObject('meCriteria');
    v.Memo.Text:= dmSaveRptQuery.osRptQueryCOMMENTS.AsString;
    BuildMasterList(tvFastRep.Items.GetFirstNode,[]);
  end;
  CurNode:= tvFastRep.Items.GetFirstNode.GetNextSibling;
  while Assigned(CurNode) do
  begin
    fmFastRpt.BuildSubList(CurNode);
    CurNode:= CurNode.GetNextSibling;
  end;
  Screen.Cursor:= crDefault;
end;

procedure TfmFastRep.CloseDataSets;
var
  CurNode: TTreeNode;
  iSet: Integer;
begin
  CurNode:= tvFastRep.Items.GetFirstNode.getNextSibling;
  while Assigned(CurNode) do
  begin
    iSet:= Card.Perform(UM_FASTREPORT,IN_DEFAULT_DATASET,0);
    if CurNode.Data<>Pointer(iSet) then
    begin
      if TVASUPQuery(CurNode.Data).Tag and OPENED_FLAG<> OPENED_FLAG then
       TVASUPQuery(CurNode.Data).Close
      else
       TVASUPQuery(CurNode.Data).Tag:= TVASUPQuery(CurNode.Data).Tag-OPENED_FLAG;
      if TVASUPQuery(CurNode.Data).ControlsDisabled then
         TVASUPQuery(CurNode.Data).EnableControls;
    end;
    CurNode:= CurNode.GetNextSibling;
  end;
end;

procedure TfmFastRep.tlbPreviewClick(Sender: TObject);
begin
  if deComment.Focused then
     deComment.Perform(CM_EXIT,0,0);
  GenerateRpt;
  fmFastRpt.frReport.ShowReport;
  CloseDataSets;
end;

procedure TfmFastRep.tvFastRepEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
var
  NewLen: Integer;
  Code: Integer;
begin
  ActivateKeyboardLayout(FCurKL,0);
  if Node.Level= 2 then
  begin
    Val(S,NewLen,Code);
    if Code=0 then
    begin
      Node.Data:= Pointer(NewLen);
      S:= IntToStr(NewLen);
    end
    else S:= IntToStr(Integer(Node.Data));
  end;
end;

procedure TfmFastRep.tlbPrintClick(Sender: TObject);
begin
  if deComment.Focused then
     deComment.Perform(CM_EXIT,0,0);
  GenerateRpt;
  fmFastRpt.frReport.PrepareReport;
  fmFastRpt.frReport.PrintPreparedReportDlg;
  CloseDataSets;
end;

procedure TfmFastRep.FormShow(Sender: TObject);
begin
  if FCurRptId=0 then
  begin
    dmSaveRptQuery.osRptQuery.Open;
    dmSaveRptQuery.osRptQuery.Insert;
    tlbNew.Click;
  end
  else
  begin
    dmSaveRptQuery.osRptQuery.Open;
    dmSaveRptQuery.osRptQuery.Locate('ID',FCurRptId,[]);
    if Assigned(Sender) then
      Caption:= Format(FHeader,[dmSaveRptQuery.osRptQueryNAME.AsString]);
    LoadTree;
  end;
end;

procedure TfmFastRep.LoadTree;
var
  HostObj: TVASUPQuery;
  TabNode: TTreeNode;
  FldNode: TTreeNode;

procedure StdFill( ANode: TTreeNode);
begin
  with ANode do
  begin
    ImageIndex:= Level;
    SelectedIndex:= Level;
    StateIndex:= -1;
  end;
end;

function SafeLabel(const AVar: Variant):string;
begin
  if not varIsNull(AVar) then
     Result:= AVar
  else Result:= HostObj.Caption;
end;

begin
  tvFastRep.Items.Clear;
  FUsedTables.Clear;
  with dmFastReport do
  begin
    quTables.SetVariable('RptId',FCurRptId);
    quFields.SetVariable('RptId',FCurRptId);
    quTables.Execute;
    if quTables.EOF then AddMinimals
    else
      while not quTables.EOF do
      begin
        HostObj:= GetObjectByTableName(dmGlobal,quTables.Field('TABLE_NAME')) as TVASUPQuery;
        TabNode:=
          tvFastRep.Items.AddChildObject( nil
                                          ,SafeLabel(quTables.Field('LABEL'))
                                          ,HostObj);
        StdFill(TabNode);
        if quTables.FieldAsString(quTables.FieldIndex('LIMIT'))='Y' then
           TabNode.StateIndex:= 1;
        FUsedTables.Add(HostObj);
        quFields.SetVariable('TabName',quTables.Field('TABLE_NAME'));
        quFields.Execute;
        while not quFields.EOF do
        begin
          FldNode:= tvFastRep.Items.AddChildObject(
                      TabNode,quFields.Field('LABEL')
                      ,HostObj.FieldByName(quFields.Field('FIELD_NAME')));
          StdFill(FldNode);
          StdFill( tvFastRep.Items.AddChildObject(
                      FldNode,quFields.Field('WIDTH')
                      ,Pointer(quFields.FieldAsInteger(quFields.FieldIndex('WIDTH'))))
                      );
          quFields.Next;
        end;
        quTables.Next;
      end;
  end;
end;

procedure TfmFastRep.tlbOpenClick(Sender: TObject);
var
  PriorRptId: Integer;
begin
  fmRepOpenDialog:= TfmRepOpenDialog.Create(Self);
  if fmRepOpenDialog.ShowModal= mrOk then
  begin
    PriorRptId:= FCurRptId;
    FCurRptId:= dmFastReport.quRptID.AsInteger;
    FormShow(nil);
    FCurRptId:= PriorRptId;
  end;
  fmRepOpenDialog.Free;
end;

procedure TfmFastRep.miLimitClick(Sender: TObject);
begin
  if tvFastRep.Selected.StateIndex<0 then
     tvFastRep.Selected.StateIndex:= 1
  else tvFastRep.Selected.StateIndex:= -1;
end;

end.
