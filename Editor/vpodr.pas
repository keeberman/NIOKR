unit vpodr;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_explorer, Placemnt, Db, vDbASUP, Grids, DBGrids, ExtCtrls, StdCtrls,
  Buttons,v_anyform, RXDBCtrl;

const
  CNoDeptSel= 'Подразделение не выбрано';

type
  TfmExpPodr = class(TfmExplorer)
    bbGood: TBitBtn;
    bbCancel: TBitBtn;
    btnLeft: TBitBtn;
    btnRight: TBitBtn;

    procedure DBGridKeyPress(Sender: TObject; var Key: Char);
              {Обработчик события OnKeyPress сетки DBGrid.
              Вызывает ButtonClick.}

    procedure ButtonClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
              {Заполнение IdField идентификатором текущего
              подразделения, PathField -путем к нему}
  private
    procedure StepByStepMoving(const DeptID: Integer);
              {Раскрывает последовательно все справочники(начиная от
              подр. верхнего уровня и до DeptID, давая возможность
              движения в обратном направлении от DeptID к высшим подр.}

    { Private declarations }
  protected
    sqlstrnum : Integer;
    procedure UMOthers(var Message:TMessage);message UM_OTHERS;
              {Дополнительная обработка инструкции STEP_BY_STEP
              Вызов процедуры StepByStepMoving}
  public
    { Public declarations }
    IdField: TField;//Поле, содержащее идентификатор подр
    PathField: TField;//Поле, содержащее путь к  подразделению
  end;

var
  fmExpPodr: TfmExpPodr;

implementation
uses oracle, globals{,prndept};
{$R *.DFM}

procedure TfmExpPodr.DBGridKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Ord(Key)=vk_Return then ButtonClick(DBGrid);
end;

procedure TfmExpPodr.ButtonClick(Sender: TObject);
begin
  if (Sender= bbGood) or (Sender=DBGrid) then
  begin
    if dsWork.DataSet.IsEmpty then
    begin
      Beep;
      MessageDlg(CNoDeptSel,mtError,[mbOk],0);
    end
    else
    begin
      IdField.Value:= dsWork.DataSet.FieldByName('ID').Value;
      if Assigned(PathField) then
        PathField.AsString:= dsWork.PathToDataSet('SNAIM');
      Close;  
    end;
  end
  else Close;
end;

procedure TfmExpPodr.StepByStepMoving(const DeptID: Integer);
var
  HigherDept: TList;
  Tech: TOracleQuery;
  I: Integer;
begin
  Screen.Cursor:= crSQLWait;
  Enabled:= false;
  dsWork.Enabled:= false;
  HigherDept:= TList.Create;
  Tech:= TOracleQuery.Create(Self);
  with Tech do
  begin
    Session:= dmGlobal.seOracle;
    SQL.Append('SELECT ID FROM P.MIPODR');
    SQL.Append('WHERE MIUROVEN_KOD>1');
    SQL.Append('START WITH ID= :dept');
    SQL.Append('CONNECT BY PRIOR MIPODR_ID= ID');
    DeclareVariable('DEPT',otInteger);
    SetVariable('DEPT',DeptID);
    Execute;
    while not EOF do
    begin
      HigherDept.Insert(0,Pointer(FieldAsInteger(0)));
      Next;
    end;
    Free;
  end;
  dsWork.DirectMove(1);
  I:= 0;
  while (I<HigherDept.Count) and dsWork.DataSet.Locate('ID',Integer(HigherDept[I]),[]) do
  begin
    Inc(I);
    if I<HigherDept.Count then dsWork.Next;
  end;
  HigherDept.Free;
  dsWork.Enabled:= true;
  Screen.Cursor:= crDefault;
  Enabled:= true;
end;

procedure TfmExpPodr.UMOthers(var Message:TMessage);
begin
  case Message.wParam of
    IN_STEP_BY_STEP: StepByStepMoving(Message.lParam);
    else inherited;
  end;
end;

procedure TfmExpPodr.btnRightClick(Sender: TObject);
var curlevel : Integer;
    MIPODR_ID : String;
begin
  inherited;
  if LeftStr(dsWork.DataSet.Name,8) = 'quMipodr' then
  begin
    curlevel := TVASUPQuery(dsWork.DataSet).GetVariable('DEPT_LEVEL');
    MIPODR_ID := TVASUPQuery(dsWork.DataSet).FieldValues['ID'];
    dsWork.DataSet.Close;
    TVASUPQuery(dsWork.DataSet).SetVariable('DEPT_LEVEL', curlevel+1 );
    sqlstrnum := TVASUPQuery(dsWork.DataSet).SQL.Add('AND MIPODR_ID = ' + MIPODR_ID);
    dsWork.DataSet.Open;
    btnLeft.Enabled := True;
  end;
end;

procedure TfmExpPodr.btnLeftClick(Sender: TObject);
var curlevel : Integer;
//    MIPODR_ID : String;
begin
  inherited;
  if LeftStr(dsWork.DataSet.Name,8) = 'quMipodr' then
  begin
    curlevel := TVASUPQuery(dsWork.DataSet).GetVariable('DEPT_LEVEL');
    TVASUPQuery(dsWork.DataSet).SQL.Text := dmGlobal.quMipodr.SQL.Text;
    dsWork.DataSet.Close;
    TVASUPQuery(dsWork.DataSet).SetVariable('DEPT_LEVEL', curlevel-1 );
    if sqlstrnum > 0 then
      TVASUPQuery(dsWork.DataSet).SQL.Delete(sqlstrnum);
    sqlstrnum := 0;
    dsWork.DataSet.Open;
    if (curlevel - 1) = 1 then btnLeft.Enabled := False;
  end;
end;

end.
