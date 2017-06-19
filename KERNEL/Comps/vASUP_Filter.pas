unit vASUP_Filter;

interface

uses
  controls, VDbASUP, classes, DsgnIntf, TypInfo, Sysutils, forms, db, stdctrls,
  graphics, Messages, Windows;

const
  MinSwitchFilterHeight = 13;

type

  TASUPFiltrChangingEvent = procedure(Sender : TObject; var AllowChange: Boolean) of object;

  TSQLFilterExpr = (feEqual,feNotEqual,feMore,feLess,
    feNotMore,feNotLess,feLike,feNotLike);

  TSQLFilterDataType = (ftSimpleType, ftList);

  TASUPFileterComp = class(TWinControl)
  {Компонент фильтр для SQL запросов.
  Используется наследниками формы TfmSQLFilter для
  создания и редактирования фильтров для SQL запросов}
  private
    FCanvas: TControlCanvas;

    FExprType  : TSQLFilterExpr;
    FDataType  : TSQLFilterDataType;
    FDataSet   : TVASUPQuery;
    FField     : String;
    FFilterName: String;
    FTurnedOn  : Boolean;
    FChangingTurnedOn : TASUPFiltrChangingEvent;
    FChangeTurnedOn : TNotifyEvent;
  protected
    procedure SetExprType(AExprType : TSQLFilterExpr); virtual;
    function  GetExprType : TSQLFilterExpr; virtual;
    procedure SetDataType(ADataType : TSQLFilterDataType); virtual;
    function  GetDataType : TSQLFilterDataType; virtual;
    procedure SetDataSet(ADataSet : TVASUPQuery); virtual;
    function  GetDataSet : TVASUPQuery; virtual;
    procedure SetField(AField : String); virtual;
    function  GetField : String; virtual;
    procedure SetFilterName(Name : String); virtual;
    function  GetFilterName : String; virtual;
    procedure SetName(const Value: TComponentName); override;
    procedure SetTurnedOn(value : boolean); virtual;
    function  GetTurnedOn : boolean; virtual;
    function  GetClientRectForPaint : TRect; virtual;
    procedure Paint(ACanvas: TControlCanvas); virtual; abstract;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ExprType : TSQLFilterExpr read GetExprType write SetExprType default feEqual;
    property DataType : TSQLFilterDataType read GetDataType write SetDataType default ftSimpleType;
    property TurnedOn : boolean read GetTurnedOn write SetTurnedOn default true;
    property DataSet  : TVASUPQuery read GetDataSet write SetDataSet;
    property Field    : String read GetField write SetField;
    property FilterName: String read GetFilterName write SetFilterName;
    property Enabled;
    property ChangingTurnedOn : TASUPFiltrChangingEvent read FChangingTurnedOn write FChangingTurnedOn;
    property ChangeTurnedOn : TNotifyEvent read FChangeTurnedOn write FChangeTurnedOn;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TASUPFileterWithSwitch = class(TASUPFileterComp)
  private
    FSwitch : TCheckBox;
    FS : TCheckBox;
    procedure Switch1Click(Sender: TObject);
    function  GetSwitchHeight : Integer;
  protected
    function  GetSwitchFont : TFont; virtual;
    procedure SetSwitchFont(Value : TFont); virtual;
    function GetMinHeight : Integer; virtual;
    function GetMinWidth :  Integer; virtual;
    function  GetClientRectForPaint : TRect; override;
    procedure Paint(ACanvas: TControlCanvas); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property SwitchFont : TFont read GetSwitchFont write SetSwitchFont;
  end;

  TFieldNameOfDataSetProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: String; override;
    procedure SetValue(const Value: string); override;
  end;

implementation

constructor TASUPFileterComp.Create(AOwner: TComponent);
begin
  FDataSet := nil;
  FField := '';
  FTurnedOn := true;
  FChangingTurnedOn := nil;
  FChangeTurnedOn := nil;
  inherited Create(AOwner);
end;

procedure TASUPFileterComp.SetExprType(AExprType : TSQLFilterExpr);
begin
  FExprType := AExprType;
end;

function  TASUPFileterComp.GetExprType : TSQLFilterExpr;
begin
  Result := FExprType;
end;

procedure TASUPFileterComp.SetDataType(ADataType : TSQLFilterDataType);
begin
  FDataType := ADataType;
end;

function  TASUPFileterComp.GetDataType : TSQLFilterDataType;
begin
  Result := FDataType;
end;

procedure TASUPFileterComp.SetDataSet(ADataSet : TVASUPQuery);
begin
  FDataSet := ADataSet;
end;

function  TASUPFileterComp.GetDataSet : TVASUPQuery;
begin
  Result := FDataSet;
end;

procedure TASUPFileterComp.SetField(AField : String);
begin
  FField := AField
end;

function  TASUPFileterComp.GetField : String;
begin
  Result := FField;
end;

procedure TASUPFileterComp.SetFilterName(Name : String);
begin
  FFilterName := Name;
end;

function  TASUPFileterComp.GetFilterName : String;
begin
  Result := FFilterName;
end;

procedure TASUPFileterComp.SetName(const Value: TComponentName);
var
  ChangeText: Boolean;
begin
  ChangeText := not (csLoading in ComponentState) and (Name = FilterName);
  inherited SetName(Value);
  if ChangeText then FilterName := Name;
end;

procedure TASUPFileterComp.SetTurnedOn(value : boolean);
var
  AllowChange : boolean;
begin
  if FTurnedOn <> value then
  begin
    if Assigned(ChangingTurnedOn) then
    begin
      AllowChange := true;
      ChangingTurnedOn(Self, AllowChange);
      if not AllowChange then
        Exit;
    end;
    FTurnedOn := value;
    if Assigned(ChangeTurnedOn) then
      ChangeTurnedOn(Self);
  end;
end;

function  TASUPFileterComp.GetTurnedOn : boolean;
begin
  Result := FTurnedOn;
end;

function  TASUPFileterComp.GetClientRectForPaint : TRect;
begin
  Result := ClientRect;
end;

procedure TASUPFileterComp.WMPaint(var Message: TWMPaint);
var
  DC: HDC;
  PS: TPaintStruct;
begin
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;

    Paint(FCanvas);
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

constructor TASUPFileterWithSwitch.Create(AOwner : TComponent);
begin
  FSwitch := TCheckBox.Create(nil);
  FS := TCheckBox.Create(nil);
  Width := 100;
  inherited Create(AOwner);
  InsertControl(FSwitch);
  FSwitch.Caption := '11111';
  InsertControl(FS);
  FS.Caption := '22222';
  FSwitch.OnClick := Switch1Click;
end;


destructor TASUPFileterWithSwitch.Destroy;
begin
  RemoveControl(FSwitch);
  RemoveControl(FS);
  inherited;
  FSwitch.Destroy;
  FS.Destroy;
end;

function  TASUPFileterWithSwitch.GetSwitchFont : TFont;
begin
  Result := FSwitch.Font;
end;

procedure TASUPFileterWithSwitch.SetSwitchFont(Value : TFont);
begin
  FSwitch.Font := Value;
  Height := Height;
end;

function TASUPFileterWithSwitch.GetMinHeight : Integer;
begin
  Result := GetSwitchHeight;
end;

function TASUPFileterWithSwitch.GetMinWidth :  Integer;
begin
  Result := 30;
end;

procedure TASUPFileterWithSwitch.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  MinHeight : Integer;
  MinWidth : Integer;
  SwitchHeight : Integer;
  LCanvas: TControlCanvas;
begin
  MinHeight := GetMinHeight;
  if AHeight < MinHeight then
    AHeight := MinHeight;

  MinWidth := GetMinWidth;
  if AWidth < MinWidth then
    AWidth := MinWidth;


  FS.Left := 0;
  FS.Top := 0;

  FSwitch.Left := 0;

  SwitchHeight := GetSwitchHeight;
  FSwitch.Height := SwitchHeight;
  LCanvas := TControlCanvas.Create;
  LCanvas.Handle := GetDC(0);
  LCanvas.Font := FSwitch.Font;
  FSwitch.Width := abs(LCanvas.TextWidth(FSwitch.Caption));
  LCanvas.Handle := 0;
  FSwitch.Top := AHeight - SwitchHeight;

  //FSwitch.Width := FSwitch.Font. //AWidth;
  LCanvas.Destroy;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

function TASUPFileterWithSwitch.GetClientRectForPaint : TRect;
var
  SwitchHeight : Integer;
begin
  Result := inherited GetClientRectForPaint;
  SwitchHeight :=  GetSwitchHeight;
  if (Result.Bottom - Result.Top) < SwitchHeight then
    Result.Bottom := Result.Top
  else
    Result.Bottom := Result.Bottom - SwitchHeight;
end;

procedure TASUPFileterWithSwitch.Switch1Click(Sender: TObject);
begin
  FSwitch.Left := FSwitch.Left + 5;
end;

procedure TASUPFileterWithSwitch.Paint(ACanvas: TControlCanvas);
var
  rect : TRect;
begin
  rect := GetClientRectForPaint;
  ACanvas.MoveTo(rect.Left, rect.Top);
  ACanvas.Pen.Color := clRed;
  ACanvas.LineTo(rect.Right, rect.Bottom);
end;

function  TASUPFileterWithSwitch.GetSwitchHeight : Integer;
begin
  Result := abs(FSwitch.Font.Height);
  if Result < MinSwitchFilterHeight then
    Result := MinSwitchFilterHeight;
end;

procedure TASUPFileterWithSwitch.Loaded;
begin

  inherited;
end;

function TFieldNameOfDataSetProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TFieldNameOfDataSetProperty.GetValues(Proc: TGetStrProc);
var
  DataSet : TDataSet;
  Comp : TPersistent;
  PropInfo: PPropInfo;
  PropValue: Pointer;
  I : Integer;
begin
  Comp := GetComponent(0);

  if Assigned(comp) then
  begin
    PropInfo:= TypInfo.GetPropInfo(Comp.ClassInfo, 'DataSet');
    if (Assigned(PropInfo)) and (PropType(Comp, 'DataSet') = tkClass) then
    begin
      PropValue:= Pointer(GetOrdProp(Comp,PropInfo));
      if (Assigned(PropValue)) and (TObject(PropValue) is TDataSet) then
      begin
        DataSet := TDataSet(PropValue);
        for I := 0 to DataSet.Fields.Count - 1 do
          Proc(DataSet.Fields[I].FieldName);
      end;
    end;
  end;
end;

function TFieldNameOfDataSetProperty.GetValue: String;
begin
  Result := GetStrValue;
end;

procedure TFieldNameOfDataSetProperty.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

end.
