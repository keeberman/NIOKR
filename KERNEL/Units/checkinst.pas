unit checkinst;

interface

uses
  Windows,
  Messages,
  Sysutils;

function SetUniqueUID(ahwnd: HWND; uid: DWord): HWND;
procedure ActivatePrevInstance(ahwnd: HWND);

implementation

function SetUniqueUID(ahwnd: HWND; uid: DWord): HWND;
var
  ClassName: array [0..255] of Char;
begin
  GetClassName(ahwnd, ClassName, SizeOf(classname));
  Result := FindWindowEx(0, 0, ClassName, nil);
  while (Result <> 0) do
    if GetProp(Result, 'UID') = uid then
      Exit
    else
      Result := FindWindowEx(0, Result, ClassName, nil);
  SetProp(ahwnd, 'UID', uid);
  Result := ahwnd;
end;

procedure ActivatePrevInstance(ahwnd: HWND);
var
  h : HWND;
begin
  h := GetWindowLong(ahwnd, GWL_HWNDPARENT);
  if IsIconic(h) then
     ShowWindow(h, SW_RESTORE);
  SetForegroundWindow(ahwnd);
end;

end.
 