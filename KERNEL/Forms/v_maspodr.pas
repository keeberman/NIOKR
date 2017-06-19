unit v_maspodr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vworkform, DBCtrls, StdCtrls, vDbASUP, Menus, Db, Buttons, ExtCtrls,vpodr,
  Mask,v_anyform, Oracle, ToolEdit, RXDBCtrl;

type
  TfmWorkDept = class(TfmWorkForm)
    { Форма-предок для dsCurrent.DataSet, связанных со
     справочником подразделений MIPODR}
    laVerhPodr: TLabel;
    teVerhPodr: TDBText;
    laPodr: TLabel;
    tePodr: TDBText;
    weUpdr: TVWatchEdit;
    dePodr: TRxDBComboEdit;
    procedure ShowHandBook(Sender: TObject);
              {Отображает дочернюю форму со справочником MIPODR.
              Форма с MIPODR, открытая ранее, закрывается}

    procedure dePodrMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);{ Обработчик OnMouseMove.
                    Отображает подсказку к коду подразделения}

    procedure dePodrKeyPress(Sender: TObject; var Key: Char);
              // Обработчик OnKeyPress

    procedure ForSQLPreparing(Sender: TVASUPQuery; Field: TField;
      var SQLFrame: TSQLFrame; var Action: Boolean);virtual;
             { Обработчик OnSQLPreparing компонента dsCurrent.DataSet .
             Устанавливает переменную запроса MAIN_DEPT равной
             значению MIPODR_ID}

    procedure ChangeVarAfterClose(DataSet:TDataSet);virtual;
              {Обработчик AfterClose компонента dsCurrent.DataSet .
               Устанавливает значение по умолчанию переменной запроса
               MAIN_DEPT= 1}

    procedure dePodrExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
              { Обработчик OnExit компонента dePodr}
  private
    FExplorer: TfmExpPodr;//Форма со справочником MIPODR
    FOnExpDstr: TNotifyEvent;//Обработчик OnDestroy формы FExplorer
    FOnExpShow:  TNotifyEvent;//Обработчик OnDestroy формы FExplorer
  protected
    procedure UMInitialize(var Message:TMessage);message UM_INITIALIZE;
              //Установка обработчиков событий dsCurrent.DataSet
    function GetRealFieldName(const AbstractName:string;Sender: TObject):string;virtual;
  public
    { Public declarations }
    procedure ExpDeptDestroy(Sender: TObject);
              //Новый обработчик OnDestroy формы FExplorer
  end;

var
  fmWorkDept: TfmWorkDept;

implementation

uses globals,MENUGnrl,v_eyes,
oracledata;

{$R *.DFM}

procedure TfmWorkDept.ShowHandBook(Sender: TObject);
begin
  with Sender as TRxDBComboEdit do
  if not ReadOnly then
  begin
    if Modified and (Length(Text)mod 2= 0) then
    begin
      Modified:= false;
      Field.AsString:= Text;
    end;
    if Assigned(FExplorer) then FExplorer.Show
    else
    begin
      RemoveConflictWin;
      Screen.Cursor:= crSQLWait;
      FExplorer:= TfmExpPodr.Create(Self);
      with FExplorer do
      begin
        FOnExpDstr:= FExplorer.OnDestroy;
        FOnExpShow:= FExplorer.OnActivate;
        OnDestroy:= ExpDeptDestroy;
        SenderControl:= Self;
        IdField:= dsCurrent.DataSet.FindField(GetRealFieldName('MIPODR_ID',Sender));
        Perform( UM_INITIALIZE,IN_SETDATASETLIST,
                 Integer(dmGlobal.mdStruc.DataSetList) );
      end;
      Screen.Cursor:= crDefault;
    end;
    FExplorer.SetFocus;
    if Length(Field.AsString)=0 then
    begin
      if FExplorer.IdField.AsInteger>0 then
      begin
        FExplorer.dsWork.Start;
        if FExplorer.dsWork.DataSet.Locate('ID',FExplorer.IdField.AsInteger,[]) then
          FExplorer.dsWork.Next
        else FExplorer.Perform( UM_OTHERS,IN_DIRECTMOVE,1);
      end
      else FExplorer.Perform( UM_OTHERS,IN_DIRECTMOVE,1);
    end
    else if FExplorer.IdField.AsInteger<=0 then FExplorer.Perform( UM_OTHERS,IN_DIRECTMOVE,1)
      else FExplorer.Perform( UM_OTHERS,IN_STEP_BY_STEP,FExplorer.IdField.AsInteger)
  end;
end;

procedure TfmWorkDept.ExpDeptDestroy(Sender: TObject);
begin
  if Assigned(FOnExpDstr) then
    FOnExpDstr(Sender);
  FExplorer:= nil;
  SetActiveWindow(Handle);
end;


procedure TfmWorkDept.dePodrMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 with Sender as TRxDBComboEdit do
 if (Length(Text)>0) and (Length(Text) mod 2=0) then
 begin
   if Modified then
   begin
     Modified:= false;
     Field.AsString:= Text;
   end;
   if DataSource.DataSet.FieldByName(GetRealFieldName('MIPODR_ID',Sender)).AsInteger
      <> No_Departments_ID then
        Hint:= DataSource.DataSet.FieldByName(GetRealFieldName('MIPODR_PNAIM',Sender)).AsString+'|'
   else Hint:= InvalidDeptMsg
 end
 else Hint:= '';
end;

procedure TfmWorkDept.dePodrKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=vk_Space then ShowHandBook(Sender);
  if not (Key in ['0'..'9',Char(VK_BACK)]) then Key:= #00;
end;

procedure TfmWorkDept.ForSQLPreparing(Sender: TVASUPQuery; Field: TField;
      var SQLFrame: TSQLFrame; var Action: Boolean);
begin
  if CompareText(Field.FieldName,'MIPODR_ID')=0 then
  begin
    Action:= not Field.IsNull {and
             not Sender.FieldByName('MIPODR_KOD').IsNull};
    if Action then
    begin
      SQLFrame.ExprType:= piVariable;
      SQLFrame.Content:= 'MAIN_DEPT';
      with Sender.FieldByName('MIPODR_KOD') do
        SQLFrame.Comment:= Format('[ %s ]=%s',[DisplayLabel,Value]);
    end
    else
      TOracleDataSet(dsCurrent.DataSet).SetVariable('MAIN_DEPT',All_Departments_ID);
  end;
end;

procedure TfmWorkDept.UMInitialize(var Message:TMessage);
begin
  inherited;
  if Message.wParam= IN_SETDATASET then
    with (dsCurrent.DataSet as TVASUPQuery) do
    begin
      OnSQLPreparing:= ForSQLPreparing;
      AfterClose:= ChangeVarAfterClose;
      //BeforeVisualQuery:= ChangeVarAfterClose;
    end;
end;

procedure TfmWorkDept.ChangeVarAfterClose(DataSet:TDataSet);
begin
  with DataSet as TVASUPQuery do
  begin
    if not Active then AfterClosePro(DataSet);
    SetVariable('MAIN_DEPT',All_Departments_ID);
  end;
end;

procedure TfmWorkDept.dePodrExit(Sender: TObject);
begin
  with dePodr do
    if (Length(Text)>0)
       and (dsCurrent.DataSet.FieldByName(GetRealFieldName('MIPODR_ID',Sender)).AsInteger= No_Departments_ID) then
       Field.AsString:= Text
end;

procedure TfmWorkDept.FormDestroy(Sender: TObject);
begin
  FExplorer.Free;
  inherited;
end;

function TfmWorkDept.GetRealFieldName(const AbstractName:string;Sender: TObject):string;
begin
  {if Sender= dePodr then }Result:= AbstractName;
end;

end.
