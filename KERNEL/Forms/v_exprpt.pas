unit v_exprpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_explorer, Placemnt, Db, vDbASUP, Grids, DBGrids, RXDBCtrl, ExtCtrls,
  StdCtrls, Buttons,v_anyform;

const
  RptQueryMsg= 'Выполнить запрос "%s" ?';

type
  TfmExpRpt = class(TfmExplorer)
    paButton: TPanel;
    bLoad: TBitBtn;
    procedure dsWorkDataChange(Sender: TObject; Field: TField);
    procedure DBGridGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);

    procedure bLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
  private
    { Private declarations }
    FCard: TForm;
    FCardClass: TFormClass;
    FCreatedCard: boolean;
    function GetCard: TForm;
    procedure SetCardClass(CardClassName: string);
    procedure LoadFastReport(ReportId: Integer);
  public
    { Public declarations }
    property Card: TForm read GetCard;
    procedure ClearCard;
  end;

var
  fmExpRpt: TfmExpRpt;

implementation
uses v_qumod,MENUGnrl, globals, expg,
     etender, cor, day, ucard;
{$R *.DFM}

function TfmExpRpt.GetCard: TForm;
begin
  if Assigned(FCard) then
  begin
    Result:= FCard;
    FCreatedCard:= false;
  end
  else
  begin
   // Result:= TfmStarLine(GetChildWindow(fmMainMenu,fmMainMenu.vpLine));
    if FCardClass=TfmExpGroup then
    begin
      Result:= GetChildWindow(fmMainMenu,fmMainMenu.vpGroup);
      Result.Perform(UM_OTHERS,IN_DIRECTMOVE,1);
    end
    else if FCardClass=TfmExpTender then
    begin
      Result:= GetChildWindow(fmMainMenu,fmMainMenu.vpTender);
      Result.Perform(UM_OTHERS,IN_DIRECTMOVE,1);
    end
    else if FCardClass=TfmMkZaoch then
      Result:= GetChildWindow(fmMainMenu,fmMainMenu.vpCorBasic)
    else if FCardClass=TfmMkOch then
      Result:= GetChildWindow(fmMainMenu,fmMainMenu.vpDayBasic)
    else if FCardClass=TfmEmpCard then
      Result:= GetChildWindow(fmMainMenu,fmMainMenu.vpCard);
    if not Assigned(Result) then
    begin
      if FCardClass=TfmExpGroup then
      begin
        Result:=
          FormingTypeList(TfmExpGroup,fmMainMenu.vpGroup,dmGlobal.mdGroup.DataSetList);
        Result.Perform(UM_OTHERS,IN_DIRECTMOVE,2);
      end
      else if FCardClass=TfmExpTender then
      begin
        Result:=
          FormingTypeList(TfmExpTender,fmMainMenu.vpTender,dmGlobal.mdTender.DataSetList);
        Result.Perform(UM_OTHERS,IN_DIRECTMOVE,1);
      end
      else if FCardClass=TfmMkOch then
        Result:= FormChildWindow(TfmMkOch,fmMainMenu.vpDayBasic,dmGlobal.quMkOch)
      else if FCardClass=TfmMkZaoch then
        Result:= FormChildWindow(TfmMkOch,fmMainMenu.vpCorBasic,dmGlobal.quMkZaOch)
      else if FCardClass=TfmEmpCard then
        Result:= FormChildWindow(TfmEmpCard,fmMainMenu.vpCard,dmGlobal.quMirab);
      FCreatedCard:= true;
    end
    else FCreatedCard:= false;
    FCard:= Result;
  end;
end;

procedure TfmExpRpt.dsWorkDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  bLoad.Enabled:= not dsWork.DataSet.IsEmpty;
end;

procedure TfmExpRpt.DBGridGetCellParams(Sender: TObject; Field: TField;
  AFont: TFont; var Background: TColor; Highlight: Boolean);
begin
  with Sender as TRxDBGrid do
    if not Highlight and
       (DataSource.DataSet.FieldByName('USERNAME').AsString= 'PUBLIC') then
        AFont.Color := clBlue
end;

procedure TfmExpRpt.LoadFastReport(ReportId: Integer);
var
  HostObj: TVASUPQuery;

function LoadVisualQuery:boolean;
var
  SavedQuery: TVisualQuery;
  Block: TSQL;
  MemArea: TMemoryStream;
  VarTmp: Variant;
begin
  with dmRptQuery do
  begin
    quMajors.SetVariable('TabName',quAllTables.FieldAsString(0));
    if quMajors.Active then quMajors.Refresh
    else quMajors.Open;
    Result:= not quMajors.EOF;
    if Result then
    begin
      SavedQuery:= TVisualQuery.Create(HostObj);
      while not quMajors.EOF do
      begin
        Block.ResType:= TReservedType(quMajorsRESTYPE.AsInteger);
        Block.FieldName:= quMajorsFIELD_NAME.AsString;
        Block.Expr:= TSQLExpression(quMajorsCONDITION.AsInteger);
        Block.Value:= quMajorsVALUE.AsString;
        case Block.ResType of
          rtString:
          begin
            Block.ResString:= StrAlloc(Length(quMajorsRESERVED.Value)+1);
            StrPCopy(Block.ResString,quMajorsRESERVED.Value);
          end;
          rtEnumList:
          begin
            Block.ResEnumList:= TVEnumValueList.Create(nil);
            MemArea:= TMemoryStream.Create;
            quMajorsRESERVED.SaveToStream(MemArea);
            MemArea.Position:= 0;
            Block.ResEnumList.LoadFromStream(MemArea);
            MemArea.Free;
          end;
          rtDate:
          begin
            VarCast(VarTmp, quMajorsRESERVED.Value, varDate);
            Block.ResDate:= VarTmp;
          end;
        end;
        SavedQuery.Add(Block);
        quMajors.Next;
      end;
      HostObj.QueryLibrary.Add(SavedQuery);
    end;
  end;
end;

begin
  try
    Screen.Cursor:= crHourGlass;
    with Card do
    begin
      Perform(UM_CHANGEMODE,IN_QUERY,MS_NORMAL);
    end;
  with dmRptQuery do
  begin
    quAllTables.SetVariable('RepId',ReportId);
    quMajors.SetVariable('RepId',ReportId);
    quMinors.SetVariable('RepId',ReportId);
    quAllTables.Execute;
    while not quAllTables.EOF do
    begin
      HostObj:= dmGlobal.GetObjectByTableName(quAllTables.FieldAsString(0));
      with HostObj do
      begin
        if not Active then Open;
        if WorkState<> wsQuery then
        begin
          //EnforceConstraints:= false;
          WorkSpace:= Card;
          //OpenViSession;
          //Card.GetData(HostObj,IN_QUERY);
        end;
        LoadVisualQuery;
        WorkState:= wsQuery;
        OnScreen(QueryLibrary.ItemIndex);
      end;
      quAllTables.Next;
    end;
    quMinors.Execute;
    {with dmGlobal.quLine do
    begin
      Order:= quMinors.Field('ORDER_TEXT');
      if not VarIsNull(quMinors.Field('FILTER_TEXT')) then
      begin
         SQLFilter:= quMinors.Field('FILTER_TEXT');
         if SQLFilter= '(A.PRZAS=0 AND A.MIISKLUCH_KOD IS NULL)' then
           Card.rgFilter.ItemIndex:= OnlyFreeEmp
         else if SQLFilter= '(A.PRZAS=1 AND A.MIISKLUCH_KOD IS NULL)' then
           Card.rgFilter.ItemIndex:= OnlyColonEmp
         else if SQLFilter= '(A.MIISKLUCH_KOD IS NOT NULL)' then
           Card.rgFilter.ItemIndex:= OnlyExEmp
      end
      else
      begin
        Card.rgFilter.ItemIndex:= AllEmp;
        SQLFiltered:= false;
      end;
    end;
    }
    quAllTables.Close;
    quMajors.Close;
    quMinors.Close;
    Card.Perform(UM_FASTREPORT,IN_SET_FASTREPORT_ID,ReportId);
    {Card.Caption:= Concat( Card.Caption
                           ,Format( '(%s)',
                           [dsWork.DataSet.FieldByName('NAME').AsString])
                           );}
    //Card.Show;
    if MessageDlg(
        Format(RptQueryMsg,[dsWork.DataSet.FieldByName('NAME').AsString])
        ,mtConfirmation,[mbYes,mbNo],0
        )= mrYes then
    begin
      //Card.Repaint;
      Card.Perform(UM_OTHERS,IN_FORMQUERY_REPAINT,0);
      Card.Perform(UM_OTHERS,IN_EXECQUERY,0);
      //Card.bbOk.Click;
      SetMDIFocus(Application.MainForm,Card);
    end;
  end;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfmExpRpt.bLoadClick(Sender: TObject);
begin
  SetCardClass(dsWork.DataSet.FieldByName('WINCLASS').AsString);
  LoadFastReport(dsWork.DataSet.FieldByName('ID').AsInteger);
end;

procedure TfmExpRpt.FormCreate(Sender: TObject);
begin
  inherited;
  dmRptQuery:= TdmRptQuery.Create(Self);
end;

procedure TfmExpRpt.FormDestroy(Sender: TObject);
begin
  inherited;
  dmRptQuery.Free;
end;

procedure TfmExpRpt.DBGridDblClick(Sender: TObject);
begin
  if bLoad.Enabled then bLoadClick(bLoad);
end;

procedure TfmExpRpt.ClearCard;
begin
  FCard:= nil;
end;

procedure TfmExpRpt.SetCardClass(CardClassName: string);
begin
  ClearCard;
  FCardClass:= TFormClass(GetClass(CardClassName));
end;

end.
