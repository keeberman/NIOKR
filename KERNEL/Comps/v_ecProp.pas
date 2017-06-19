 unit v_ecProp;

interface

uses DesignIntf, {*DesignEditors,*} Classes;

type
 TEditFormProperty = class(TComponentProperty)
  private
   FCheckProc: TGetStrProc;
   procedure CheckComponent(const Value: string);
  public
   procedure GetValues(Proc: TGetStrProc); override;
   procedure SetValue(const Value : String);override;
   function GetValue:string;override;
  end;

implementation

uses TypInfo, Forms, vDBAsup, Dialogs,SysUtils;

{ TEditFormProperty }

procedure TEditFormProperty.CheckComponent(const Value: string);
var
 J : Integer;
 Form : TForm;
 ID : TVEditFormID;
begin
 ID := TVEditFormID(Designer.GetComponent(Value));
 for J := 0 to PropCount - 1 do
 begin
  if GetStrProp(GetComponent(J),GetPropInfo) = ID.Owner.ClassName
  then Exit;// Don't list if already linked.
 end;
 FCheckProc(Value);// Add this form.
end;// CheckComponent

procedure TEditFormProperty.GetValues(Proc: TGetStrProc);
var TypeData : PTypeData;
begin
 FCheckProc := Proc; // Save real "add value" proc.
 // Let inherited property editor enumerate classes.
 // We'll filter with CheckComponent.
 TypeData := GetTypeData(TVEditFormID.ClassInfo);
 Designer.GetComponentNames(TypeData, CheckComponent);
end;// GetValues

procedure TEditFormProperty.SetValue(const Value : String);
var
  J : Integer;
  Component: TComponent;
begin
 for J := 0 to PropCount - 1 do
 begin
   Component:= Designer.GetComponent(Value);
   if Assigned(Component) then
     SetStrProp(GetComponent(J),GetPropInfo,Component.Owner.ClassName)
   else  SetStrProp(GetComponent(J),GetPropInfo,'')
 end;
 Designer.Modified;
end;// SetValue

function TEditFormProperty.GetValue;
begin
   Result:= GetStrProp(GetComponent(0),GetPropInfo);
end;

end.
