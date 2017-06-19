unit v_sort;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, RXCtrls, ExtCtrls,Dialogs,DB,vdbASUP, CheckLst;

const
   CHelpCap='&Помощь';
   CHideCap='Сп&рятать';
type
  TfmSort = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    SrcLabel: TLabel;
    DstLabel: TLabel;
    IncludeBtn: TSpeedButton;
    IncAllBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    ExAllBtn: TSpeedButton;
    SrcList: TTextListBox;
    paHelp: TPanel;
    chHelp: TCheckBox;
    UpBtn: TSpeedButton;
    DownBtn: TSpeedButton;
    DstList: TRxCheckListBox;
    procedure IncludeBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure IncAllBtnClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
    procedure MoveSelected(List: TWinControl; v_Items: TStrings);
    procedure SelectItem(List: TWinControl; Index: Integer);
    function GetFirstSelItem(List: TWinControl): Integer;
    procedure SetButtons;
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpDownClick(Sender:TObject);
    procedure DstListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DstListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure SrcListDblClick(Sender: TObject);
    procedure DstListDblClick(Sender: TObject);
  private
    FTempOrder: string;
    FLeaderPart: string;
    procedure CutName(var AName: string;var ACheck:bool);
    function MakeOrder:string;
    { Private declarations }
  public
    QRY: TVASUPQuery;
    { Public declarations }
  end;

var
  fmSort: TfmSort;
implementation

{$R *.DFM}

function ThinOriginFieldName(Field: TField):string;
begin
  Result:= Field.Origin;
  if (Length(Result)=0) or (Pos(' ',Result)>0)
     or (Pos(',',Result)>0) then Result:= Field.FieldName;
end;

procedure TfmSort.IncludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelItem(SrcList);
  MoveSelected(SrcList, DstList.Items);
  SelectItem(SrcList, Index);
end;

procedure TfmSort.ExcludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelItem(DstList);
  MoveSelected(DstList, SrcList.Items);
  SelectItem(DstList, Index);
end;

procedure TfmSort.IncAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to SrcList.Items.Count - 1 do
    DstList.Items.AddObject(SrcList.Items[I],SrcList.Items.Objects[I]);
  SrcList.Items.Clear;
  SelectItem(SrcList, 0);
end;

procedure TfmSort.ExcAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  with DstList do begin
    for I := 0 to Items.Count - 1 do
      SrcList.Items.AddObject(Items[I],Items.Objects[I]);
    for I:=Items.Count - 1 downto 0 do begin
      if Checked[I] then Checked[I]:= false;
      Items.Delete(I);
    end;
  end;
  SelectItem(DstList, 0);
end;

procedure TfmSort.MoveSelected(List: TWinControl; v_Items: TStrings);
var
  I: Integer;
begin
  if List is TCustomListBox then
  with List as TCustomListBox do
  begin
    for I := Items.Count - 1 downto 0 do
      if Selected[I] then
      begin
        v_Items.AddObject(Items[I],Items.Objects[I]);
        Items.Delete(I);
      end;
  end
  else if List is TRxCheckListBox then
  with List as TRxCheckListBox do
  begin
    for I := Items.Count - 1 downto 0 do
      if Selected[I] then
      begin
        v_Items.AddObject(Items[I],Items.Objects[I]);
        Items.Delete(I);
      end;
  end
end;

procedure TfmSort.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty := SrcList.Items.Count = 0;
  DstEmpty := DstList.Items.Count = 0;
  IncludeBtn.Enabled := not SrcEmpty;
  IncAllBtn.Enabled := not SrcEmpty;
  ExcludeBtn.Enabled := not DstEmpty;
  ExAllBtn.Enabled := not DstEmpty;
  UpBtn.Enabled:= DstList.Items.Count>1;
  DownBtn.Enabled:= DstList.Items.Count>1;
end;

function TfmSort.GetFirstSelItem;
begin
  if List is TCustomListBox then
  begin
  with List as TCustomListBox do
    for Result := 0 to Items.Count - 1 do
      if Selected[Result] then Exit;
  end
  else if List is TRxCheckListBox then
  begin
  with List as TRxCheckListBox do
    for Result := 0 to Items.Count - 1 do
      if Selected[Result] then Exit;
  end;
  Result := LB_ERR;
end;

procedure TfmSort.SelectItem(List: TWinControl; Index: Integer);
var
  MaxIndex: Integer;
  I: Integer;
begin
  if List is TCustomListBox then
  begin
    with List as TCustomListBox do
    begin
      SetFocus;
      MaxIndex := Items.Count - 1;
      if Index = LB_ERR then Index := 0
      else if Index > MaxIndex then Index := MaxIndex;
      if Index>=0 then Selected[Index]:= True;
    end;
  end
  else if List is TRxCheckListBox then
  begin
    with List as TRxCheckListBox do
    begin
      SetFocus;
      MaxIndex := Items.Count - 1;
      if Index = LB_ERR then Index := 0
      else if Index > MaxIndex then Index := MaxIndex;
      if Index>=0 then Selected[Index]:= True;
    end;
  end;
  SetButtons;
end;

procedure TfmSort.OKBtnClick(Sender: TObject);
begin
  if DstList.Items.Count=0 then
  begin
    if MessageDlg('Отменить порядок ?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    begin
      QRY.Order:= FLeaderPart;
      ModalResult:= mrOk;
    end;
  end
  else
  begin
    QRY.Order:= MakeOrder;
    if not (csDesigning in QRY.ComponentState)
       and (QRY.State= dsBrowse) then QRY.ReOrder;
    ModalResult:= mrOk;
  end;
end;

procedure TfmSort.HelpBtnClick(Sender: TObject);
begin
  if paHelp.Visible then begin
    Height:= Height-paHelp.Height;
    paHelp.Visible:= false;
    HelpBtn.Caption:= CHelpCap;
  end
  else begin
    Height:= Height+paHelp.Height;
    paHelp.Visible:= true;
    HelpBtn.Caption:= CHideCap;
  end;
end;

function FieldByOriginName(DataSet:TDataSet;FieldName: string):TField;
var
  I: Integer;
begin
  Result:= nil;
  I:= 0;
  while not Assigned(Result) and (I<DataSet.FieldCount) do
    if CompareText(DataSet.Fields[I].Origin,FieldName)=0 then
      Result:= DataSet.Fields[I]
    else Inc(I);
  if not Assigned(Result) then
    Result:= DataSet.FieldByName(FieldName);
end;

procedure TfmSort.CutName(var AName: string;var ACheck:bool);
var
  I,J:Integer;
  Temp: string;
begin
  I:= Pos(',',FTempOrder);
  if I>0 then
  begin
    Temp:= Copy(FTempOrder,1,I-1);
    FTempOrder:= Copy(FTempOrder,I+1,Length(FTempOrder)-I);
  end
  else begin
    Temp:= FTempOrder;
    FTempOrder:= '';
  end;
  J:= Pos(' ',Temp);
  AName:= Trim(Copy(Temp,1,J-1));
  {I:= Pos('.',AName);
  if I>0 then AName:= Copy(AName,I+1,Length(AName));}
  if UpperCase(Trim(Copy(Temp,J+1,Length(Temp)-J)))='DESC' then
    ACheck:= true
  else ACheck:= false;
end;

function AddComma(const AString: string):string;
begin
  Result:= AString;
  if Length(Result)>0 then Result:= Concat(Result,',');
end;

procedure TfmSort.FormShow(Sender: TObject);
var
  NameField: string;
  CheckActive: bool;
  I:Integer;
  Field: TField;

function Bool2Str(const Ascending: bool):string;
begin
  if Ascending then Result:= ' ASC'
  else Result:= ' DESC'
end;

begin
  FLeaderPart:= '';
  Height:= Height-paHelp.Height;
  paHelp.Visible:= false;
  if Assigned(QRY) and QRY.Active then begin
    FTempOrder:= QRY.Order;
    while FTempOrder<>'' do
    begin
      CutName(NameField,CheckActive);
      Field:= FieldByOriginName(QRY,NameField);
      if Assigned(Field) then
        if Field.Visible or (csDesigning in QRY.ComponentState)
           or ( Field.Tag and USEINSORT_FIELDTAG= USEINSORT_FIELDTAG) then
        begin
          DstList.Items.AddObject(Field.DisplayLabel,Field);
          DstList.Checked[DstList.Items.Count-1]:= CheckActive;
        end
        else FLeaderPart:= Concat(AddComma(FLeaderPart),OriginFieldName(Field),Bool2Str(not CheckActive));
    end;
    for I:= 0 to QRY.FieldCount-1 do
      if ( QRY.Fields[I].Visible
           or ( csDesigning in QRY.ComponentState )
           or ( QRY.Fields[I].Tag and USEINSORT_FIELDTAG= USEINSORT_FIELDTAG)
           )
         and (QRY.Fields[I].FieldKind in [fkData,fkInternalCalc]) and
       (DstList.Items.IndexOfObject(QRY.Fields[I])<0) then
       SrcList.Items.AddObject(QRY.Fields[I].DisplayLabel,QRY.Fields[I]);
    SetButtons;
  end;
end;

function TfmSort.MakeOrder:string;
var
  I: Integer;
begin
  Result:= '';
  for I:= 0 to DstList.Items.Count-1 do
    if DstList.Checked[I] then
      Result:= Concat(AddComma(Result),ThinOriginFieldName(DstList.Items.Objects[I] as TField),
                      ' DESC')
    else Result:= Concat(AddComma(Result),ThinOriginFieldName(DstList.Items.Objects[I] as TField),
                      ' ASC');
  if Length(FLeaderPart)>0 then
    if Length(Result)>0 then Result:= Concat(FLeaderPart,',',Result)
    else Result:= FLeaderPart;
end;

procedure TfmSort.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfmSort.UpDownClick(Sender:TObject);
var
  CurIndex,NewIndex:Integer;
begin
  CurIndex:= GetFirstSelItem(DstList);
  with DstList,DstList.Items do begin
    if CurIndex=LB_ERR then  begin
      if Sender=UpBtn then Selected[Count-1]:= true
      else Selected[0]:= true;
      Exit;
    end;
    if Sender=UpBtn then NewIndex:= CurIndex-1
    else NewIndex:= CurIndex+1;
    if NewIndex in [0..Count-1] then begin
      Move(CurIndex,NewIndex);
      Selected[NewIndex]:= true;
      Selected[CurIndex]:= false;
    end;
  end;
end;

procedure TfmSort.DstListDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Source=DstList then Accept:= true;
end;

procedure TfmSort.DstListDragDrop(Sender, Source: TObject; X, Y: Integer);

function Min(I,J:Integer):Integer;
begin
  if I<J then Result:= I
  else Result:= J
end;

begin
  with Source as TRxCheckListBox do
    Items.Move(ItemIndex,Min(Y div ItemHeight,Items.Count-1));
end;

procedure TfmSort.SrcListDblClick(Sender: TObject);
begin
  if IncludeBtn.Enabled then IncludeBtn.Click;
end;

procedure TfmSort.DstListDblClick(Sender: TObject);
begin
  if ExcludeBtn.Enabled then ExcludeBtn.Click;
end;

end.
