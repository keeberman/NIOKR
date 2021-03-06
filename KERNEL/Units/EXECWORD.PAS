unit ExecWord;

interface

uses Word97, Windows, OleServer;

{��������� ����� �������� � Word �� ������� Template �
�������� ��� ��������� ����� �� Params �� ������ �� Args}
procedure WordFormat(Template : String; Params: array of string;
                     Args: array of string);

{��������� ����� �������� � Word �� ������� Template � �������� ��� � Clipboard}
procedure InitWord(Template : String; var WordApp : TWordApplication;
                                      var WordDoc : TWordDocument);

{������� Clipboard, ������ ������� Word, � ���������� ���������� � ��� ���������}
procedure DoneWord(WordApp : TWordApplication; WordDoc : TWordDocument);

{�������� � ��������� ��� ��������� ����� �� Params �� ������ �� Args}
procedure FormatDocument(WordDoc : TWordDocument;
                       Params: array of string; Args: array of string );

{�������� ���������� Clipboarda � ����� ���������}
procedure PasteInEnd(WordApp : TWordApplication; WordDoc : TWordDocument);

{��������� � ����� ��������� ����������� ��������}
procedure NewPage(WordApp : TWordApplication; WordDoc : TWordDocument);

{��������� � ������� ����� ������}
procedure AddRowInTable(WordDoc : TWordDocument;
                        RowData: array of string);

var
  TemplatesPath : string; //���� � ��������
  PTrue, PFalse, BreakPage : OleVariant;

implementation

procedure WordFormat(Template : String;
                     Params: array of string;
                     Args: array of string);
var WordApp : TWordApplication;
    WordDoc : TWordDocument;
    Templ,ItemIndex : OleVariant;
    FText,RText, Wrap, ReplAll :OleVariant;
    i : integer;
begin
  WordApp := TWordApplication.Create(nil);
  WordApp.ConnectKind:= ckRunningOrNew;
  WordDoc := TWordDocument.Create(nil);
  try
    Templ := TemplatesPath+{'\'+}Template;
    ItemIndex := 1;
    WordApp.Connect;
    WordApp.Documents.Add(Templ, PFalse);
    WordDoc.ConnectTo(WordApp.Documents.Item(ItemIndex));
    WordApp.Options.CheckSpellingAsYouType := False;
    WordApp.Options.CheckGrammarAsYouType := False;
    Wrap := 1;
    ReplAll := 2;
    for i := 0 to Length(Params)-1 do begin
      FText := Params[i];
      RText := Args[i];
      WordDoc.Range.Find.Execute(FText,PFalse,PFalse,PFalse,PFalse,PFalse,
                                 PTrue,Wrap,PFalse,RText,ReplAll);
    end;
    WordApp.Visible := true;
    WordDoc.Disconnect;
    WordApp.Disconnect;
  finally
    WordDoc.Free;
    WordApp.Free;
  end;
end;

procedure InitWord(Template : String; var WordApp : TWordApplication; var WordDoc : TWordDocument);
var Templ,ItemIndex : OleVariant;
begin
    ItemIndex := 1;
    Templ := TemplatesPath+{'\'+}Template;

    WordApp := TWordApplication.Create(nil);
    WordDoc := TWordDocument.Create(nil);
    WordApp.Connect;
    WordApp.Documents.Add(Templ, PFalse);
    WordDoc.ConnectTo(WordApp.Documents.Item(ItemIndex));
    WordDoc.Range.Cut;
    WordApp.Options.CheckSpellingAsYouType := False;
    WordApp.Options.CheckGrammarAsYouType := False;
end;

procedure DoneWord(WordApp : TWordApplication; WordDoc : TWordDocument);
begin
  EmptyClipboard;
  WordApp.Visible := true;
  WordDoc.Disconnect;
  WordApp.Disconnect;
  WordDoc.Free;
  WordApp.Free;
end;

procedure FormatDocument(WordDoc : TWordDocument;
                       Params: array of string; Args: array of string );
var FText,RText, Wrap, ReplAll :OleVariant;
    i : integer;
begin
    Wrap := 1;
    ReplAll := 2;
    for i := 0 to Length(Params)-1 do begin
      FText := Params[i];
      RText := Args[i];
      WordDoc.Range.Find.Execute(FText,PFalse,PFalse,PFalse,PFalse,PFalse,
                                 PTrue,Wrap,PFalse,RText,ReplAll);
    end;
end;

procedure AddRowInTable(WordDoc : TWordDocument;
                        RowData: array of string);
var
  BRow: OleVariant;
  RowCount: Integer;
  I: Integer;
  Idx: Integer;
begin
  RowCount:= WordDoc.Range.Tables.Item(1).Rows.Count;
  BRow:= WordDoc.Range.Tables.Item(1).Rows.Item(RowCount);
  WordDoc.Range.Tables.Item(1).Rows.Add(BRow);
  Idx:= WordDoc.Range.Tables.Item(1).Rows.Count-1;
  for I:= 0 to Length(RowData)-1 do
    WordDoc.Range.Tables.Item(1).Rows.Item(Idx).Cells.Item(I+1).Range.Text:= RowData[I];
end;

procedure PasteInEnd(WordApp : TWordApplication; WordDoc : TWordDocument);
var Start, Stop : OleVariant;
    EndDoc : integer;
begin
  EndDoc := WordDoc.Range.Get_End_;
  Start := EndDoc - 1;
  Stop := EndDoc - 1;
  WordApp.ActiveDocument.Range(Start, Stop).Paste;
end;

procedure NewPage(WordApp : TWordApplication; WordDoc : TWordDocument);
var Start, Stop : OleVariant;
    EndDoc : integer;
begin
  EndDoc := WordDoc.Range.Get_End_;
  Start := EndDoc - 1;
  Stop := EndDoc - 1;
  if Start > 0
    then WordApp.ActiveDocument.Range(Start, Stop).InsertBreak(BreakPage);
end;

begin
  PTrue := true;
  PFalse := false;
  BreakPage := wdPageBreak;
end.
