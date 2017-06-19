unit v_edcnd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask,DB;
const
  EmptyCnd= 'Нет данных.';
  EmptyDateText='__.__.__';
  EmptyDateText2='  .  .  ';

type
  TDataKind= (dkNone,dkDate,dkHandBook);

  TfmCndEdit = class(TForm)
    bOk: TButton;
    bvEdits: TBevel;
    mePoint: TMaskEdit;
    laPoint: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    meStart: TMaskEdit;
    Label2: TLabel;
    meFinish: TMaskEdit;
    bNew: TButton;
    bClose: TButton;
    procedure EditKeyPress(Sender: TObject;var Key: Char);
    procedure ChoiceProcess(Sender: TObject);
    procedure MaskEditEnter(Sender: TObject);
    procedure MaskEditExit(Sender: TObject);
    procedure bNewClick(Sender: TObject);
    procedure bOkClick(Sender: TObject);
    procedure bCloseClick(Sender: TObject);
    procedure MaskEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FLastEdit: TObject;
    FDataKind: TDataKind;
    FEditMask: string;
    FQueryCtrl: TControl;
    procedure ShowHandBook(MaskEdit: TMaskEdit);
    { Private declarations }
  public
    Field: TField;
    property DataKind: TDataKind read FDataKind write FDataKind;
    property QueryControl: TControl read FQueryCtrl write FQueryCtrl;
    { Public declarations }
  end;

var
  fmCndEdit: TfmCndEdit;
  DateFormatBoundary: Integer;

implementation
{$R *.DFM}

uses pickdate,vdbASUP,v_Eyes;

procedure TfmCndEdit.MaskEditEnter(Sender: TObject);
var
  OldText: string;
begin
  FLastEdit:= Sender;
  with Sender as TMaskEdit do
  begin
    OldText:= Text;
    EditMask:= FEditMask;
    Text:= OldText;
  end;
end;

procedure TfmCndEdit.bNewClick(Sender: TObject);
begin
  mePoint.EditText:= '';
  meStart.EditText:= '';
  meFinish.EditText:= '';
  if FLastEdit=mePoint then mePoint.SetFocus
  else meStart.SetFocus;
end;

procedure TfmCndEdit.bOkClick(Sender: TObject);
begin
  if (Length(mePoint.EditText)>0)
     or (Length(meStart.EditText)>0)
     or (Length(meFinish.EditText)>0) then ModalResult:= mrOk
  else
  begin
    MessageDlg(EmptyCnd,mtError,[mbOk],0);
    mePoint.SetFocus;
  end;
end;

procedure TfmCndEdit.bCloseClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfmCndEdit.MaskEditChange(Sender: TObject);
begin
  if (Length((Sender as TMaskEdit).Text)>0)
     and ((Sender as TMaskEdit).EditText<>EmptyDateText) then
    if Sender= mePoint then
    begin
      meStart.Text:= '';
      meStart.EditMask:= '';
      meFinish.Text:= '';
      meFinish.EditMask:= '';
    end
    else
    begin
      mePoint.Text:= '';
      mePoint.EditMask:= '';
    end;
  with Sender as TMaskEdit do
    if (EditText=EmptyDateText) and Modified then
    begin
      Text:= '';
      Modified:= false;
    end;
end;

procedure TfmCndEdit.FormShow(Sender: TObject);

procedure SetLengths(const InputLen: Integer);
begin
  mePoint.MaxLength:= InputLen;
  meStart.MaxLength:= InputLen;
  mefinish.MaxLength:= InputLen;
end;

begin
  if Field is TNumericField then  SetLengths(Owner.Tag)
  else FEditMask:= Field.EditMask;
  if (Length(mePoint.EditText)=0)
     and ((Length(meStart.EditText)>0)
     or (Length(meFinish.EditText)>0)) then
     meStart.SetFocus
  else mePoint.SetFocus;
  if (FDataKind= dkNone)
      and (Field is TDateTimeField) then FDataKind:= dkDate;
end;

procedure TfmCndEdit.EditKeyPress(Sender: TObject;var Key: Char);
begin
  if  (Ord(Key)= vk_Space) then ChoiceProcess(Sender)
  else
    if (Key in [#32..#255]) and
      not Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
end;

procedure TfmCndEdit.MaskEditExit(Sender: TObject);
begin
  with (Sender as TMaskEdit) do
    if Text= EmptyDateText2 then EditMask:= '';
end;

procedure TfmCndEdit.ChoiceProcess(Sender: TObject);
var
  StartDate: TDateTime;

const
  PriorCentury= 19;
  NextCentury= 20;

function RR_DateFormat(const Value: TDateTime):TDateTime;
var
  Year,Month,Day: Word;
  FirstDigits: Integer;
begin
  DecodeDate(Value, Year, Month, Day);
  if Year mod 100<=DateFormatBoundary then
     FirstDigits:= NextCentury
  else FirstDigits:= PriorCentury;
  Year:= FirstDigits*100 + Year mod 100;
  Result:= EncodeDate(Year, Month, Day)
end;

begin
  case FDataKind of
    dkDate:
    with Sender as TMaskEdit do
    begin
      Perform(CM_EXIT,0,0);
      if Length(EditMask)>0 then
        StartDate:= RR_DateFormat(StrToDateTime(Text))
      else StartDate:= Now;
      if PopupDate(StartDate,Sender as TMaskEdit) then
        Text:= FormatDateTime(ShortDateFmtLine,StartDate);
      SetFocus;
    end;
    dkHandBook: ShowHandBook(Sender as TMaskEdit);
  end;
end;

procedure TfmCndEdit.ShowHandBook(MaskEdit: TMaskEdit);
var
  SearchForm: TfmSearch;
begin
  with FQueryCtrl as TVWatchEdit do
  begin
    SearchForm:= TfmSearch.Create(Self);
    SearchForm.Caption:= TableCaption;
    OpenQRY(SearchForm);
    if SearchForm.ShowModal= mrOk then
      MaskEdit.Text:= SearchForm.qrSearch.FieldByName(KeyField).AsString;
    SearchForm.Free;
  end;
end;

initialization
  DateFormatBoundary:= 29;
end.

