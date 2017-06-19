unit v_DSLProp;// TDatasetListProperty
// Modified 12.05.98 16:39:34

{$L-,S-}

interface

uses SysUtils, Windows, Messages, Classes, Graphics,
     Controls, Forms, Dialogs, StdCtrls, RXCtrls, DesignEditors,
     ExtCtrls, Buttons, DesignIntf, vdbASUP, Variants;

type
 TDSLPropDlg = class(TForm)
   SrcList: TTextListBox;
   DstList: TTextListBox;
   SrcLabel: TLabel;
   DstLabel: TLabel;
   IncBtn: TButton;
   IncAllBtn: TButton;
   ExclBtn: TButton;
   ExclAllBtn: TButton;
   OkBtn: TButton;
   CancelBtn: TButton;
   Bevel1: TBevel;
   procedure IncBtnClick(Sender: TObject);
   procedure IncAllBtnClick(Sender: TObject);
   procedure ExclBtnClick(Sender: TObject);
   procedure ExclAllBtnClick(Sender: TObject);
   procedure SrcListDragOver(Sender, Source: TObject; X, Y: Integer;
                             State: TDragState; var Accept: Boolean);
   procedure DstListDragOver(Sender, Source: TObject; X, Y: Integer;
                             State: TDragState; var Accept: Boolean);
   procedure SrcListDragDrop(Sender, Source: TObject; X, Y: Integer);
   procedure DstListDragDrop(Sender, Source: TObject; X, Y: Integer);
   procedure SrcListKeyDown(Sender: TObject; var Key: Word;
                            Shift: TShiftState);
   procedure DstListKeyDown(Sender: TObject; var Key: Word;
                            Shift: TShiftState);
   procedure FormCreate(Sender: TObject);
   procedure ListClick(Sender: TObject);
  private
  { Private declarations }
  protected
   procedure CreateParams(var Params: TCreateParams); override;
  public
   { Public declarations }
   procedure SetButtons;
 end;

 TDatasetListProperty = class(TClassProperty)
  private
   procedure CheckComponent(const Value: string);
  public
   procedure Edit; override;
   function GetAttributes: TPropertyAttributes; override;
   function GetValue: string; override;
 end;

implementation

uses Consts, VCLUtils, BoxProcs,
     DB, TypInfo;

var SetDSLDlg : TDSLPropDlg;

{-------------------------- TDatasetListProperty ------------------------------}
procedure TDatasetListProperty.CheckComponent(const Value: string);
var
 Dataset: TDataset;
begin
 Dataset := TDataset(Designer.GetComponent(Value));
 if TVMetaDataSource(GetComponent(0)).DatasetList.IndexOf(DataSet) < 0
  then SetDSLDlg.SrcList.Items.AddObject(Value, Dataset)
end;

procedure TDatasetListProperty.Edit;
var
 TypeData : PTypeData;
 MetaSource : TVMetaDataSource;

procedure DataSets2Strings;
var
  I : Integer;
begin
  SetDSLDlg.DstList.Items.Clear;
  for I:= 0 to MetaSource.DatasetList.Count-1 do
    SetDSLDlg.DstList.Items.AddObject(
      MetaSource.DatasetList.Items[I].DataSetName,
      MetaSource.DatasetList.Items[I].DataSet);
end;

// Called when the '...' button isressed or the property is double-clicked.
begin
// To call the inherited implementation, use "inherited Edit;" }
// : Place your overriding code here.
 SetDSLDlg := TDSLPropDlg.Create(nil);
 with SetDSLDlg do
 begin
  try
   TypeData := GetTypeData(TDataset.ClassInfo);
   Self.Designer.GetComponentNames(TypeData, CheckComponent);
   MetaSource := TVMetaDataSource(GetComponent(0));
   DataSets2Strings;
   if ShowModal = mrOK then
    with MetaSource.DatasetList do begin
     Assign(SetDSLDlg.DstList.Items);
     Self.Designer.Modified;
    end;
  finally
   Free;// Free dialog.
  end;
 end;
end; // Edit

function TDatasetListProperty.GetAttributes: TPropertyAttributes;
// Returns information used by the Object Inspector
// to show the approprate adornments (e.g., "..." button, drop-down button).
begin
 GetAttributes := [paDialog, paReadOnly];
end;// GetAttributes

function TDatasetListProperty.GetValue: string;
// Returns a string representation for the property's current value,
// so that the Object Inspector can display it. The default is "unknown".
begin
 Result := '(TDatasetList)';
end;// GetValue

{$R *.DFM}

{------------------------------ TDSLPropDlg -----------------------------------}
procedure TDSLPropDlg.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
end;

procedure TDSLPropDlg.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty := (SrcList.Items.Count = 0);
  DstEmpty := (DstList.Items.Count = 0);
  IncBtn.Enabled := not SrcEmpty and (SrcList.SelCount > 0);
  IncAllBtn.Enabled := not SrcEmpty;
  ExclBtn.Enabled := not DstEmpty and (DstList.SelCount > 0);
  ExclAllBtn.Enabled := not DstEmpty;
end;

procedure TDSLPropDlg.IncBtnClick(Sender: TObject);
begin
  BoxMoveSelectedItems(SrcList, DstList);
  SetButtons;
end;

procedure TDSLPropDlg.IncAllBtnClick(Sender: TObject);
begin
  BoxMoveAllItems(SrcList, DstList);
  SetButtons;
end;

procedure TDSLPropDlg.ExclBtnClick(Sender: TObject);
begin
  BoxMoveSelectedItems(DstList, SrcList);
  SetButtons;
end;

procedure TDSLPropDlg.ExclAllBtnClick(Sender: TObject);
begin
  BoxMoveAllItems(DstList, SrcList);
  SetButtons;
end;

procedure TDSLPropDlg.SrcListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  BoxDragOver(SrcList, Source, X, Y, State, Accept, SrcList.Sorted);
  if State = dsDragLeave then
    (Source as TTextListBox).DragCursor := crDrag;
  if (State = dsDragEnter) and ((Source as TTextListBox).SelCount > 1) then
    (Source as TTextListBox).DragCursor := crMultiDrag;
end;

procedure TDSLPropDlg.DstListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  BoxDragOver(DstList, Source, X, Y, State, Accept, DstList.Sorted);
  if State = dsDragLeave then
    (Source as TTextListBox).DragCursor := crDrag;
  if (State = dsDragEnter) and ((Source as TTextListBox).SelCount > 1) then
    (Source as TTextListBox).DragCursor := crMultiDrag;
end;

procedure TDSLPropDlg.SrcListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source = DstList then ExclBtnClick(SrcList)
  else if Source = SrcList then begin
    BoxMoveFocusedItem(SrcList, SrcList.ItemAtPos(Point(X, Y), True));
  end;
end;

procedure TDSLPropDlg.DstListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source = SrcList then IncBtnClick(DstList)
  else if Source = DstList then begin
    BoxMoveFocusedItem(DstList, DstList.ItemAtPos(Point(X, Y), True));
  end;
end;

procedure TDSLPropDlg.SrcListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Incr: Integer;
begin
  if not SrcList.Sorted then begin
    if (ssCtrl in Shift) and ((Key = VK_DOWN) or (Key = VK_UP)) then begin
      if Key = VK_DOWN then Incr := 1
      else Incr := -1;
      BoxMoveFocusedItem(SrcList, SrcList.ItemIndex + Incr);
      Key := 0;
    end;
  end;
end;

procedure TDSLPropDlg.DstListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Incr: Integer;
begin
  if not DstList.Sorted then begin
    if (ssCtrl in Shift) and ((Key = VK_DOWN) or (Key = VK_UP)) then begin
      if Key = VK_DOWN then Incr := 1
      else Incr := -1;
      BoxMoveFocusedItem(DstList, DstList.ItemIndex + Incr);
      Key := 0;
    end;
  end;
end;

procedure TDSLPropDlg.FormCreate(Sender: TObject);
begin
  OkBtn.Caption := ResStr(SOKButton);
  CancelBtn.Caption := ResStr(SCancelButton);
  if NewStyleControls then Font.Style := [];
end;

procedure TDSLPropDlg.ListClick(Sender: TObject);
begin
  SetButtons;
end;

end.
