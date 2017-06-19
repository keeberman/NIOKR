unit repCurrotList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, Grids, DBGrids, RXDBCtrl, StdCtrls, Buttons, ComObj,
  ExtCtrls, fCoping;

type
  TfmCurratorList = class(TForm)
    odsCurators: TOracleDataSet;
    pTop: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    pBottom: TPanel;
    pRightBottom: TPanel;
    bbCancel: TBitBtn;
    bbOk: TBitBtn;
    dsCurators: TDataSource;
    dbgCurators: TRxDBGrid;
    quTreaty: TOracleQuery;
    quDogYears: TOracleQuery;
    quPlan: TOracleQuery;
    procedure FormCreate(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
    procedure odsCuratorsAfterOpen(DataSet: TDataSet);
    procedure odsCuratorsAfterClose(DataSet: TDataSet);
  private
    { Private declarations }
    FFromYear : INteger; // Год начала временого интервала
    FToYear   : Integer;   // Год конча временого интервала

    // Форма для отбражение процесса формирования отчетов
    buildingReport : TFrmCoping;

    FSemaphore : THandle;

    FSender : TObject;

    procedure ShowDialogBox;

    procedure CreatePlanReport;
  public
    { Public declarations }
    MONTH : Integer;
    YEAR  : Integer;

    constructor Create(AOwner: TComponent; AFromYear : Integer; AToYear : Integer; Sender : TObject); overload;

    procedure SetBusy;
    procedure ResetBusy;
  end;

var
  fmCurratorList: TfmCurratorList;

  function getNOK(a, b : Integer) : integer;

implementation

uses globals, Thread, MENUGnrl;

{$R *.DFM}

// Возращает наименьшие общие кратное
function getNOK(a, b : Integer) : integer;
var
  min, max : Integer;
begin
  if a < b then
  begin
    min := a;
    max := b;
  end
  else
  begin
    min := b;
    max := a;
  end;

  if min > 0 then
  begin
    Result := max;
    while ((Result mod max) <> 0) or ((Result mod min) <> 0) do
      inc(Result);
  end
  else
    Result := 0;
end;

constructor TfmCurratorList.Create(AOwner: TComponent; AFromYear : Integer; AToYear : Integer; Sender : TObject);
begin
  FFromYear := AFromYear;
  FToYear   := AToYear;
  FSender := Sender;
  inherited Create(AOwner);
end;

procedure TfmCurratorList.FormCreate(Sender: TObject);
begin

  if FFromYear = 0 then
    if FToYear <> 0 then
      FFromYear := FToYear
    else
      FFromYear := StrToInt(FormatDateTime('yyyy',Date));

  if FToYear = 0 then
    FToYear := FFromYear;

  if FFromYear = FToYear then
    Label2.Caption := 'за ' + IntToStr(FToYear) + ' год'
  else
    Label2.Caption := IntToStr(FFromYear) + ' -- ' + IntToStr(FToYear) + ' годов';

  odsCurators.SetVariable('FROMDATE', EncodeDate(FFromYear, 1, 1));
  odsCurators.SetVariable('TODATE',   EncodeDate(FToYear,   1, 1));
  odsCurators.Open;
end;

procedure TfmCurratorList.bbOkClick(Sender: TObject);
const
  //beg_table : integer = 6; // Начало шаблона таблицы
  beg_new_table : integer = 7; // Начало самой таблицы
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

  offs_table : Integer = 3;

  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы
var
  thread : TLRQThread;

  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  count_stages : integer;
  summpay_per_treaty  : Extended;
  summpay_stages_year : array of Extended;
  erate_date : tdate;
  stage_year_to : Integer; // Год окончания этапа
  erate : Extended;
  DogYears : array of Integer;
  I : Integer;
  countYears : Integer;
  ExecFormula : String;
  curator : String;

  rec_count : Integer;

  {LineNumsOfBreakPages : Array Of Integer;
  countLines : Array Of Integer;

  ind : Integer;
  count_row : Integer;}

  Istfin_kod : Integer;
  ConcDogID  : Integer;

  //changedIstFin : boolean;

  MainFormula : String;
  Formula : String;
  MainYearFormulas : array of String;
  YearFormulas : array of String;
  //J : Integer;

  num_stage : integer; // номер этапа

  tr_status : String;
begin
  //count_row := 0;
  if FSender = fmMainMenu.vpCuratorPlan then
  begin
    CreatePlanReport;
    Exit;
  end;

  St:=ExtractFilePath(Application.ExeName) + 'report\Curator.xlt';


  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);


  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
              'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;

  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    curator := odsCurators.FieldByName('suname').AsString + ' '
                                + odsCurators.FieldByName('firstname').AsString
                                + ' ' +
                                odsCurators.FieldByName('otchestvo').AsString;


    if Length(curator) > 30 then
      Excel.WorkSheets[1].Name := odsCurators.FieldByName('suname').AsString
    else
      Excel.WorkSheets[1].Name := curator;

    Excel.WorkSheets[1].Cells[2, 1] := String(Excel.WorkSheets[1].Cells[2, 1]) + odsCurators.FieldByName('GenitiveCase').AsString;

    // Определяем, в какие годы должны или были выполнены этапы договоров
    with quDogYears do
    begin
      SetVariable('FROMDATE', EncodeDate(FFromYear, 1, 1));
      SetVariable('TODATE',   EncodeDate(FToYear, 1, 1));
      SetVariable('TABN',     odsCurators.FieldByName('TABN').Value);

      Execute;

      countYears :=  Integer(Field('count_years'));
      SetLength(DogYears, countYears);
      SetLength(summpay_stages_year, countYears);
      I := 0;
      while not Eof do
      begin
        DogYears[I] := StrToInt(String(Field('year')));
        Inc(I);
        next;
      end;
    end;

    if countYears > 1 then
    begin
      for I := 0 to countYears - 2 do
      begin
        ExecFormula := Excel.Worksheets[1].Cells[beg_new_table + offs_table + 6, 6].Formula;
        Excel.Worksheets[1].Columns[6].Insert;
        Excel.Worksheets[1].Cells[beg_new_table + offs_table + 6, 6].Formula := ExecFormula;
      end;

      Excel.Worksheets[1].Columns[2].ColumnWidth := Excel.Worksheets[1].Columns[2].ColumnWidth - ((Excel.Worksheets[1].Columns[6].ColumnWidth + 1)/5)*2*(countYears - 1);
      Excel.Worksheets[1].Columns[3].ColumnWidth := Excel.Worksheets[1].Columns[3].ColumnWidth - ((Excel.Worksheets[1].Columns[6].ColumnWidth + 1)/5)*3*(countYears - 1);
    end
    else if countYears = 0 then
    begin
      Excel.Worksheets[1].Columns[2].ColumnWidth := Excel.Worksheets[1].Columns[2].ColumnWidth + ((Excel.Worksheets[1].Columns[6].ColumnWidth + 1)/5)*2;
      Excel.Worksheets[1].Columns[3].ColumnWidth := Excel.Worksheets[1].Columns[3].ColumnWidth + ((Excel.Worksheets[1].Columns[6].ColumnWidth + 1)/5)*3;
      Excel.Worksheets[1].Columns[6].Delete;
    end;

    for I := 0 to countYears - 1 do
      Excel.Worksheets[1].Cells[beg_new_table - 2, 6 + I].Value := IntToStr(DogYears[I]) + 'г.';

    SetLength(MainYearFormulas, countYears);
    SetLength(YearFormulas, countYears);

    for I := 0 to countYears - 1 do
    begin
      Excel.Worksheets[1].Cells[beg_new_table - 1, 6 + I].Value := IntToStr(6 + I);
      MainYearFormulas[I] := '';
      YearFormulas[I] := '';
    end;

    tr_status := '';

    // Выполняем отчет
    with quTreaty do
    begin
      SetVariable('FROMDATE', EncodeDate(FFromYear, 1, 1));
      SetVariable('TODATE',   EncodeDate(FToYear, 1, 1));
      SetVariable('TABN',     odsCurators.FieldByName('TABN').Value);
      Execute;

      idx:= beg_new_table; prev_id := -1; count := 1;
      count_stages := 0;
      erate_date := 0;
      erate := 0;
      summpay_per_treaty := 0;
      Istfin_kod := -1;
      ConcDogID := -1;
      MainFormula := '';
      Formula := '';
      //changedIstFin := false;

      if FieldIsNull('count_dog') then
        rec_count := 0
      else
        rec_count := FieldAsInteger('count_dog');
      if rec_count > 0 then
      begin

        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');

        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;

        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);

        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;

        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(rec_count {* 2});
      end;

      {SetLength(LineNumsOfBreakPages, rec_count);
      SetLength(countLines, rec_count);
      Ind := 0;}

      while not EOF do
      begin
        try
          // Проверяем тот же самый ли id [Field(0)]
          if Integer(Field('ID')) <> prev_id then
          begin

            if (Istfin_kod <> Integer(Field('Istfin_kod'))) or
               (FieldIsNull('ConcDogID') and (ConcDogID <> -1)) or
               ((not FieldIsNull('ConcDogID')) and (ConcDogID <> Integer(Field('ConcDogID')))) or
               ((FieldAsString('treaty_status') = 'P') and (tr_status <> 'P'))
            then
            begin
              {if Ind > 0 then
                inc(countLines[Ind-1]);}

              Istfin_kod := Integer(Field('Istfin_kod'));
              if FieldIsNull('ConcDogID') then
                ConcDogID := -1
              else
                ConcDogID := Integer(Field('ConcDogID'));


              if Formula <> '' then
              begin
                Formula := Formula + 'E' + IntToStr(idx - 1) + ')';
                for I := 0 to countYears - 1 do
                  YearFormulas[I] := YearFormulas[I] + Chr(Ord('F') + I) + IntToStr(idx - 1) + ')';

                Excel.Worksheets[1].Rows[idx + 1].Insert;
                Excel.WorkSheets[1].Rows[idx + offs_table + 7].Copy(Excel.Worksheets[1].Rows[idx]);

                Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula;
                for I := 0 to countYears - 1 do
                  Excel.WorkSheets[1].Cells[idx, 6 + I].Formula := YearFormulas[I];

                if MainFormula = '' then
                  MainFormula := '=Sum(E' + IntToStr(idx)
                else
                  MainFormula := MainFormula + ', E' + IntToStr(idx);

                for I := 0 to countYears - 1 do
                  if MainYearFormulas[I] = '' then
                    MainYearFormulas[I] := '=Sum(' + Chr(Ord('F') + I) + IntToStr(idx)
                  else
                    MainYearFormulas[I] := MainYearFormulas[I] + ', ' + Chr(Ord('F') + I) + IntToStr(idx);

                inc(idx);
              end;

              Formula := '=Sum(E' + IntToStr(idx) + ':';
              for I := 0 to countYears - 1 do
                YearFormulas[I] := '=Sum(' + Chr(Ord('F') + I) + IntToStr(idx) + ':';


              Excel.Worksheets[1].Rows[idx + 1].Insert;

              if FieldAsString('treaty_status') = 'P' then
              begin
                // Темы из темплана
                Excel.WorkSheets[1].Rows[idx + offs_table + 2].Copy(Excel.Worksheets[1].Rows[idx]);
                tr_status := 'P';
              end
              else
                case ISTFIN_KOD of
                  // Источник финансирования собственные средства
                  1 : Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
                  2 : begin
                        Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);
                        if ConcDogID >= 0 then
                        begin
                          with TOracleQuery.Create(Self) do
                          begin
                            Session:= dmGlobal.seOracle;

                            SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
                            SQL.Append('  FROM RN.MITRCONCERN');
                            SQL.Append(' WHERE  ID = :DOG_ID');

                            DeclareVariable('DOG_ID', otInteger);
                            SetVariable('DOG_ID', ConcDogID);
                            Execute;

                            Excel.WorkSheets[1].Cells[idx, 1] := Excel.WorkSheets[1].Cells[idx, 1].Text + String(FieldAsString(0));

                            Destroy;
                          end;
                        end;
                      end;
                end;

              //changedIstFin := true;

              inc(idx);
            end;

            for I := 0 to countYears - 1 do
              summpay_stages_year[I] := 0;

            // Следующий договор
            count_stages := Integer(Field('count_per_treaty')); // Количество этапов на договор
            summpay_per_treaty := Extended(Field('tr_summpay')); // сумма по договору
            erate_date := Field('intro_date');
            erate := Extended(Field('e_rate'));
            Excel.Worksheets[1].Rows[idx].Insert;
            Excel.Worksheets[1].Rows[idx].Insert;

            if Field(7) = 'O' then // OPERATIVE Действующий договор
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 3 + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 4 + 1].Copy(Excel.Worksheets[1].Rows[idx + 1]);
            end
            else if Field(7) = 'P' then // PREPARATION Договор в статусе подготовка
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 3 + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 4 + 1].Copy(Excel.Worksheets[1].Rows[idx + 1]);
            end
            else if Field(7) = 'F' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 5 + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 6 + 1].Copy(Excel.Worksheets[1].Rows[idx+1]);
              Excel.WorkSheets[1].Cells[idx+1, 2] := 'ЗАКРЫТ';
            end
            else if Field(7) = 'A' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + 5 + 1].Copy(Excel.Worksheets[1].Rows[idx]);
              Excel.WorkSheets[1].Rows[idx + offs_table + 6 + 1].Copy(Excel.Worksheets[1].Rows[idx+1]);
              Excel.WorkSheets[1].Cells[idx+1, 2] := 'АННУЛИРОВАН';
            end;
            Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку

            count_stages := FieldAsInteger('count_per_treaty');
            num_stage := 0;
            inc(count);

            Excel.WorkSheets[1].Cells[idx+1, 1] := FieldAsString('num'); // id
            Excel.WorkSheets[1].Cells[idx, 2] := String(Field('name')); // номер договора и исполнитель
            Excel.WorkSheets[1].Cells[idx, 3] := String(Field('subject')); // тема договора
            Excel.WorkSheets[1].Cells[idx, 4] := String(Field('tr_datefrom')); // дата начала
            Excel.WorkSheets[1].Cells[idx+1, 4] := String(Field('tr_dateto')); // дата окончания
            inc(idx,2);
          end;
          //dec(count_stages);
          inc(num_stage);
          if not FieldIsNull('stage_year_to') then
          begin
            stage_year_to := StrToInt(String(Field('stage_year_to')));
            for I := 0 to countYears - 1 do
              if stage_year_to = DogYears[I] then
              begin
                summpay_stages_year[I] := summpay_stages_year[I] + Extended(Field('stage_summpay'));
                break;
              end;
          end;

          if num_stage = count_stages then
          begin
            if Integer(Field(6)) <> BYR then
            begin
              Excel.WorkSheets[1].Cells[idx-1, 3] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field('currency_name'))
                                                    + '  на ' + DateToStr(erate_date);
              Excel.WorkSheets[1].Cells[idx-2, 5] := IntToStr(Round(summpay_per_treaty*erate));

              for I := 0 to countYears - 1 do
                if summpay_stages_year[I] > 0 then
                  Excel.WorkSheets[1].Cells[idx-2, 6 + I] := IntToStr(Round(summpay_stages_year[I]*erate));

            end
            else
            begin
              Excel.WorkSheets[1].Cells[idx-2, 5] := IntToStr(Round(summpay_per_treaty));

              for I := 0 to countYears - 1 do
                if summpay_stages_year[I] > 0 then
                  Excel.WorkSheets[1].Cells[idx-2, 6 + I] := IntToStr(Round(summpay_stages_year[I]));

            end;
          end;
          prev_id := Integer(Field('ID'));

          //inc(num_stage);

          if num_stage = count_stages then
          begin
            {if changedIstFin then
            begin
             countLines[Ind] := 2;
             LineNumsOfBreakPages[Ind] := idx - 3;
             changedIstFin := false;
            end
            else
            begin
              countLines[Ind] := 1;
              LineNumsOfBreakPages[Ind] := idx - 2;
            end;

            inc(count_row, countLines[Ind]);
            inc(Ind);}

            buildingReport.Next;
          end;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;
        Next;
      end;
      {Excel.Worksheets[1].Rows[beg_table+5].Delete;
      Excel.Worksheets[1].Rows[beg_table+4].Delete;
      Excel.Worksheets[1].Rows[beg_table+3].Delete;
      Excel.Worksheets[1].Rows[beg_table+2].Delete;
      Excel.Worksheets[1].Rows[beg_table+1].Delete;
      Excel.Worksheets[1].Rows[beg_table].Delete;  // удаляем записи шаблонной таблицы}
      Close;

      if Formula <> '' then
      begin
        Formula := Formula + 'E' + IntToStr(idx - 1) + ')';
        for I := 0 to countYears - 1 do
          YearFormulas[I] := YearFormulas[I] + Chr(Ord('F') + I) + IntToStr(idx - 1) + ')';
        Excel.Worksheets[1].Rows[idx + 1].Insert;
        Excel.WorkSheets[1].Rows[idx + offs_table + 7].Copy(Excel.Worksheets[1].Rows[idx]);

        Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula;
        for I := 0 to countYears - 1 do
          Excel.WorkSheets[1].Cells[idx, 6 + I].Formula := YearFormulas[I];

        if MainFormula = '' then
          MainFormula := '=SUM(E' + IntToStr(idx) + ')'
        else
          MainFormula := MainFormula +  ', E' + IntToStr(idx) + ')';

        for I := 0 to countYears - 1 do
          if MainYearFormulas[I] = '' then
           MainYearFormulas[I] := '=Sum(' + Chr(Ord('F') + I) + IntToStr(idx)
          else
            MainYearFormulas[I] := MainYearFormulas[I] + ', ' + Chr(Ord('F') + I) + IntToStr(idx);

        inc(idx);

        Excel.Worksheets[1].Rows[idx + 1].Insert;
        Excel.WorkSheets[1].Rows[idx + offs_table + 8].Copy(Excel.Worksheets[1].Rows[idx]);
        Excel.WorkSheets[1].Cells[idx, 5].Formula := MainFormula;
        for I := 0 to countYears - 1 do
          Excel.WorkSheets[1].Cells[idx, 6 + I].Formula := MainYearFormulas[I];

        inc(idx);
      end;
    end;

   {buildingReport.NewValue((count_row + 1) * 2, count_row + 1);

   for I := 0 to rec_count - 1 do
   begin
     for J := 0 to countLines[I] - 1 do
     begin
       if Excel.Worksheets[1].Rows[LineNumsOfBreakPages[I] + 1 + J].PageBreak <> Excel.Worksheets[1].Rows[row_no_page_break].PageBreak then
       begin
         Excel.Worksheets[1].Rows[LineNumsOfBreakPages[I]].PageBreak := 1;
         buildingReport.Next(countLines[I] - J);
         break;
       end
       else
         buildingReport.Next;
     end;

   end;}
   Excel.WorkSheets[1].Range['$' + IntToStr(idx) + ':$' + IntToStr(idx + 11)].Delete;
   if rec_count > 0 then
   begin
     //buildingReport.Next;
     buildingReport.Finish;
   end;

  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
        buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

procedure TfmCurratorList.odsCuratorsAfterOpen(DataSet: TDataSet);
begin
  if odsCurators.RecNo < 0 then
    bbOk.Enabled := false
  else
    bbOk.Enabled := true;
end;

procedure TfmCurratorList.odsCuratorsAfterClose(DataSet: TDataSet);
begin
  bbOk.Enabled := false;
end;

procedure TfmCurratorList.SetBusy;
begin
  Self.Enabled := false;
end;

procedure TfmCurratorList.ResetBusy;
begin
  Self.Enabled := true;
end;

procedure TfmCurratorList.ShowDialogBox;
begin
  // Создаем окно, в котором будет отображатся инф. о состоянии копирования данных


  buildingReport := TFrmCoping.Create(nil);

  ReleaseSemaphore(FSemaphore, 1, nil);

  buildingReport.ShowModal;

  // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
  buildingReport.Destroy;

end;

procedure TfmCurratorList.CreatePlanReport;
const
  beg_new_table : integer = 8; // Начало самой таблицы
  SEMAPHORE : string = 'NIOKR_SEMAPHORE';

  offs_table : Integer = 3;

  row_no_page_break : integer = 2; //Номер строки, где нет разрыва страницы

  COL_BEG_YEARS = 6;
  COL_BEG_PLAN  = 12;

  ROWS_TEMPLATE = 12;
var
  thread : TLRQThread;

  Excel:  OLEVariant;  // Вариантная переменная для объекта Excel.Application
  St:     OLEVariant;  // Файл темплейта
  idx : integer; // счетчик по строкам
  prev_id : integer;// id пердыдущего договора
  count : integer;
  count_stages : integer;
  count_plan_st : integer;
  count_un_st : integer;
  summpay_per_treaty  : Extended;
  n_summpay_per_treaty  : Extended;
  summpay_fact_year : Extended;
  summpay_plan_year : Extended;
  summpay_stages_year : array of Extended;
  erate_date : tdate;
  stage_year_to : Integer; // Год окончания этапа
  erate : Extended;
  DogYears : array of Integer;
  I, J : Integer;
  countYears : Integer;
  ExecFormula : String;
  curator : String;

  rec_count : Integer;

  Istfin_kod : Integer;
  ConcDogID  : Integer;

  //changedIstFin : boolean;

  MainFormula : String;
  Formula : String;
  MainYearFormulas : array of String;
  YearFormulas : array of String;
  MainPlanFormulas : array of String;
  PlanFormulas : array of String;
  unfufilled_Formula : String;
  main_unfufilled_Formula : String;
  plan_Formula : String;
  main_plan_Formula : String;
  fact_Formula : String;
  main_fact_Formula : String;
  ostatok_formul :String;
  main_ostaok_formula : String;
  //J : Integer;

  planMonths : Integer;

  num_stage : integer; // номер этапа

  tr_status : String;

  colBegYears : Integer;
  colBegPlan  : Integer;

  countColPlan : Integer;

  period : String;
  fromPeriud, toPeriud : TDateTime;
  m : string;
  rows : Integer;

  curr_un_st, curr_pl_st : Integer;

  RowHeight : Extended;

  dateTo : TDAteTime;
  ye, mo, da : Word;
  r : Integer;

  newYear : TDateTime;

  ostatok :  Extended;

function getNameCol(ANumCol : Integer) : String;
begin
  if ANumCol > 26 then
    Result := chr(Ord('A') - 1 + (ANumCol div 26)) + chr(Ord('A') - 1 + (ANumCol mod 26))
  else if ANumCol < 26 then
    Result := chr(Ord('A') - 1 + (ANumCol mod 26))
  else
    Result := 'Z';
end;

begin
  //count_row := 0;

  St:=ExtractFilePath(Application.ExeName) + 'report\PlanCurator.xlt';

  // Делаем недоступным приложение, для пользователя
  SetBusy;

  // СОздаем поток
  thread := TLRQThread.Create(true);
  // Указываем, что, когда поток закончит выполнение, он автоматически освободил память
  thread.FreeOnTerminate := true;
  // Указываем метод, который должен выполнить поток
  thread.OnDo := ShowDialogBox;

  // Создаем семафор, который будет синхронизировать работу потоков с переменной buildingReport
  I := -1;
  FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE));
  while FSemaphore <> 0 do
  begin
    Inc(I);
    FSemaphore := OpenSemaphore(MUTANT_ALL_ACCESS, true, PChar(SEMAPHORE + IntToStr(I)));
  end;
  if i >= 0 then
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE + IntToStr(I)))
  else
    FSemaphore := CreateSemaphore(nil, 0, 1, PChar(SEMAPHORE));

  // Запускаем поток, который создаст форму buildingReport и отобразит его на экране
  thread.Resume;

  // Ждем, пока поток thread создаст форму buildingReport
  WaitForSingleObject(FSemaphore, INFINITE);

  buildingReport.visibleProgressBar(false);
  buildingReport.Caption := 'Идет процесс подготовки формирования отчета';
  buildingReport.SetCaption('Идет процесс подготовки формирования отчета...');

  // Уничтожаем семафор
  CloseHandle(FSemaphore);


  // Выбираем записи в Excel
  Screen.Cursor:=crHourGlass;
  // Создадим объект Excel.Application
  try
    Excel:=CreateOLEObject('Excel.Application');
  except
    Screen.Cursor:=crDefault;
    MessageBox(Handle, 'Не установлено программное обеспечение MS Excel(r) версии не ниже 97',
              'Ошибка', mb_OK or mb_IconHand);
    Exit;
  end;

  try
    InvalidateRect(Handle, nil, True);
    UpdateWindow(Handle);
    // Добавим новую книгу
    try
      Excel.Workbooks.Add(St);
    except
      // Восстановим нормальный курсор
      Screen.Cursor:=crDefault;
      MessageBox(Handle, 'Ошибка - нет возможности добавить новую книгу !',
                'Ошибка', mb_OK or mb_IconHand);
      Exit;
    end;

    curator := odsCurators.FieldByName('suname').AsString + ' '
                                + odsCurators.FieldByName('firstname').AsString
                                + ' ' +
                                odsCurators.FieldByName('otchestvo').AsString;


    if Length(curator) > 30 then
      Excel.WorkSheets[1].Name := odsCurators.FieldByName('suname').AsString + ' ' + copy(odsCurators.FieldByName('firstname').AsString, 1, 1) + '. ' + copy(odsCurators.FieldByName('otchestvo').AsString, 1, 1) + '.'
    else
      Excel.WorkSheets[1].Name := curator;

    Excel.WorkSheets[1].Cells[2, 1] := String(Excel.WorkSheets[1].Cells[2, 1]) + IntToStr(FFromYear) + ' ГОД';
    Excel.WorkSheets[1].Cells[3, 1] := curator;

    // Определяем, в какие годы должны или были выполнены этапы договоров
    with quDogYears do
    begin
      SetVariable('FROMDATE', EncodeDate(FFromYear, 1, 1));
      SetVariable('TODATE',   EncodeDate(FToYear, 1, 1));
      SetVariable('TABN',     odsCurators.FieldByName('TABN').Value);

      Execute;

      countYears :=  Integer(Field('count_years'));
      SetLength(DogYears, countYears);
      SetLength(summpay_stages_year, countYears);
      I := 0;
      while not Eof do
      begin
        DogYears[I] := StrToInt(String(Field('year')));
        Inc(I);
        next;
      end;
    end;

    // Вычислям число месяцев по лану финансирование, которое будет в отчете
    planMonths := 12 - (Month-1);
    // Кол. колонок отображающих график фонансирование
    countColPlan :=  planMonths + 1;

    // Номер первой колонки, в которой отображажются финасирование договора по годам
    colBegYears := COL_BEG_YEARS;
    // Номер первой колонки, в которой отображажются график финансирования
    colBegPlan  := COL_BEG_PLAN + (countYears - 1);

    // Формирум колоники с отображением  финасирование договора по годам
    if countYears > 1 then
    begin
      for I := 0 to countYears - 2 do
      begin
        ExecFormula := Excel.Worksheets[1].Cells[beg_new_table + offs_table + ROWS_TEMPLATE - 3, colBegYears].Formula;
        Excel.Worksheets[1].Columns[colBegYears].Insert;
        Excel.Worksheets[1].Cells[beg_new_table + offs_table + ROWS_TEMPLATE - 3, colBegYears].Formula := ExecFormula;
      end;
    end
    else if countYears = 0 then
      Excel.Worksheets[1].Columns[colBegYears].Delete;
    for I := 0 to countYears - 1 do
    begin
      Excel.Worksheets[1].Cells[beg_new_table - 2, colBegYears + I].Value := IntToStr(DogYears[I]) + 'г.';
      Excel.Worksheets[1].Cells[beg_new_table - 1, colBegYears + I].Value := IntToStr(colBegYears + I);
    end;

    // Формируем массивы в которых будут содержатся формули вычислющие итоговые значения  финасирование договоров по годам
    SetLength(MainYearFormulas, countYears);
    SetLength(YearFormulas, countYears);
    for I := 0 to countYears - 1 do
    begin
      MainYearFormulas[I] := '';
      YearFormulas[I] := '';
    end;

    // Формирум колоники с отображением  графика финансирования
    for I := 1 to 12 - planMonths do
      Excel.Worksheets[1].Columns[colBegPlan + 1].Delete;
    for I := 0 to countColPlan - 1 do
      Excel.Worksheets[1].Cells[beg_new_table - 1, colBegPlan + I].Value := IntToStr(colBegPlan + I);
    // Формируем массивы в которых будут содержатся формули вычислющие итоговые значения  графика фининсирования
    SetLength(MainPlanFormulas, planMonths);
    SetLength(PlanFormulas, planMonths);

    Excel.Worksheets[1].Cells[beg_new_table - 3, colBegPlan + planMonths + 1].Value := String(Excel.Worksheets[1].Cells[beg_new_table - 3, colBegPlan + planMonths + 1])+ ' ' + IntToStr(FFromYear) + 'г.';
    Excel.Worksheets[1].Cells[beg_new_table - 1, colBegPlan + planMonths + 1].Value := IntToStr(colBegPlan + planMonths + 1);

    // Определяем переуд, за который будем считать ФАКТ и ПЛАН
    if planMonths = 12 then
    begin
      period := IntToStr(FFromYear - 1) + 'г.';
      fromPeriud := EncodeDate(YEAR - 1, 1, 1);
      toPeriud := EncodeDate(YEAR, 1, 1);
    end
    else if planMonths = 11 then
    begin
      period := ' (январь)';
      fromPeriud := EncodeDate(YEAR, 1, 1);
      toPeriud := EncodeDate(YEAR, 2, 1);
    end
    else
    begin
      case (planMonths) of
        10: m := 'февраль';
         9: m := 'март';
         8: m := 'апрель';
         7: m := 'май';
         6: m := 'июнь';
         5: m := 'июль';
         4: m := 'август';
         3: m := 'сентябрь';
         2: m := 'октябрь';
         1: m := 'ноябрь';
      end;

      if planMonths = 11 then
        period := 'январь'
      else
        period := IntToStr(12 - planMonths) + 'месяцев';
      period := period + ' в ' + IntToStr(YEAR) + 'г.'; //' (январь - ' + m + ')';
      fromPeriud := EncodeDate(YEAR, 1, 1);
      toPeriud := EncodeDate(YEAR, 12 - planMonths + 1, 1);
    end;
    Excel.WorkSheets[1].Cells[beg_new_table - 3, 10  + countYears - 1] := period;

    Excel.Worksheets[1].Cells[beg_new_table - 1,  7  + countYears - 1].Value := IntToStr( 7  + countYears - 1);
    Excel.Worksheets[1].Cells[beg_new_table - 1,  8  + countYears - 1].Value := IntToStr( 8  + countYears - 1);
    Excel.Worksheets[1].Cells[beg_new_table - 1,  9  + countYears - 1].Value := IntToStr( 9  + countYears - 1);
    Excel.Worksheets[1].Cells[beg_new_table - 1, 10  + countYears - 1].Value := IntToStr(10  + countYears - 1);
    Excel.Worksheets[1].Cells[beg_new_table - 1, 11  + countYears - 1].Value := IntToStr(11  + countYears - 1);

    tr_status := '';

    // Выполняем отчет
    with quPlan do
    begin
      SetVariable('YEAR', YEAR);
      SetVariable('MONTH', MONTH);
      SetVariable('TABN', odsCurators.FieldByName('TABN').Value);
      Execute;

      idx:= beg_new_table;
      prev_id := -1;
      count := 1;
      count_stages := 0;
      erate_date := 0;
      erate := 0;
      summpay_per_treaty := 0;
      n_summpay_per_treaty  := 0;
      Istfin_kod := -1;
      ConcDogID := -1;
      MainFormula := '';
      Formula := '';
      unfufilled_Formula := '';
      main_unfufilled_Formula := '';
      plan_Formula := '';
      main_plan_Formula := '';
      fact_Formula := '';
      main_fact_Formula := '';
      ostatok_formul := '';
      main_ostaok_formula := '';
      rows := 0;
      curr_un_st := 0;
      curr_pl_st := 0;
      dateTo := EncodeDate(year, month, 1);
      newYear := EncodeDate(YEAR + 1, 1, 1);
      //changedIstFin := false;

      if FieldIsNull('count_dog') then
        rec_count := 0
      else
        rec_count := FieldAsInteger('count_dog');
      if rec_count > 0 then
      begin

        buildingReport.Caption := 'Формируется отчет';
        buildingReport.SetCaption('Идет процесс формирования отчета...');

        // Устанавливаем начальные значения в окне buildingReport
        buildingReport.reset;

        // Делаем в окне buildingReport видимым ProgressBar
        buildingReport.visibleProgressBar(true);

        // Сообщаем  окну buildingReport  о начала копирования данных
        buildingReport.Start;

        // Устанавливаем максиальное значение ProgressBar в окне
        buildingReport.SetMax(rec_count {* 2});
      end;

      while not EOF do
      begin
        try
          // Проверяем тот же самый ли id [Field(0)]
          if Integer(Field('ID')) <> prev_id then
          begin
            inc(idx, rows);

            if (Istfin_kod <> Integer(Field('Istfin_kod'))) or
               (FieldIsNull('ConcDogID') and (ConcDogID <> -1) and (FieldAsString('treaty_status')<> 'P')) or
               ((not FieldIsNull('ConcDogID')) and (ConcDogID <> Integer(Field('ConcDogID'))) and (FieldAsString('treaty_status')<> 'P')) or
               ((FieldAsString('treaty_status') = 'P') and (tr_status <> 'P'))
            then
            begin

              Istfin_kod := Integer(Field('Istfin_kod'));
              if (FieldIsNull('ConcDogID')) or (FieldAsString('treaty_status') = 'P') then
                ConcDogID := -1
              else
                ConcDogID := Integer(Field('ConcDogID'));


              if Formula <> '' then
              begin
                unfufilled_Formula := unfufilled_Formula + getNameCol(9 +  countYears - 1) + IntToStr(idx - 1) + ')';
                plan_Formula := plan_Formula + getNameCol(10 +  countYears - 1) + IntToStr(idx - 1) + ')';
                fact_Formula := fact_Formula + getNameCol(11 +  countYears - 1) + IntToStr(idx - 1) + ')';
                Formula := Formula + 'E' + IntToStr(idx - 1) + ')';
                for I := 0 to countYears - 1 do
                  YearFormulas[I] := YearFormulas[I] + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx - 1) + ')';
                for I := 0 to planMonths - 1 do
                  PlanFormulas[I] := PlanFormulas[I] + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx - 1) + ')';
                ostatok_formul := ostatok_formul + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx - 1) + ')';

                Excel.Worksheets[1].Rows[idx + 1].Insert;
                Excel.WorkSheets[1].Rows[idx + offs_table + ROWS_TEMPLATE - 2].Copy(Excel.Worksheets[1].Rows[idx]);

                Excel.WorkSheets[1].Cells[idx, 9 + countYears - 1].Formula := unfufilled_Formula;
                Excel.WorkSheets[1].Cells[idx, 10 + countYears - 1].Formula := plan_Formula;
                Excel.WorkSheets[1].Cells[idx, 11 + countYears - 1].Formula := fact_Formula;
                Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula;
                for I := 0 to countYears - 1 do
                  Excel.WorkSheets[1].Cells[idx, colBegYears + I].Formula := YearFormulas[I];
                for I := 0 to planMonths - 1 do
                  Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + I].Formula := PlanFormulas[I];

                Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + planMonths].Formula := ostatok_formul;

                if main_unfufilled_Formula = '' then
                  main_unfufilled_Formula := '=Sum(' + getNameCol(9 +  countYears - 1) + IntToStr(idx)
                else
                  main_unfufilled_Formula := main_unfufilled_Formula + ', ' + getNameCol(9 +  countYears - 1) + IntToStr(idx);
                if main_plan_Formula = '' then
                  main_plan_Formula := '=Sum(' + getNameCol(10 +  countYears - 1) + IntToStr(idx)
                else
                  main_plan_Formula := main_plan_Formula + ', ' + getNameCol(10 +  countYears - 1) + IntToStr(idx);
                if main_fact_Formula = '' then
                  main_fact_Formula := '=Sum(' + getNameCol(11 +  countYears - 1) + IntToStr(idx)
                else
                  main_fact_Formula := main_fact_Formula + ', ' + getNameCol(11 +  countYears - 1) + IntToStr(idx);
                if MainFormula = '' then
                  MainFormula := '=Sum(E' + IntToStr(idx)
                else
                  MainFormula := MainFormula + ', E' + IntToStr(idx);

                for I := 0 to countYears - 1 do
                  if MainYearFormulas[I] = '' then
                    MainYearFormulas[I] := '=Sum(' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx)
                  else
                    MainYearFormulas[I] := MainYearFormulas[I] + ', ' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx);

                for I := 0 to planMonths - 1 do
                  if MainPlanFormulas[I] = '' then
                    MainPlanFormulas[I] := '=Sum(' + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx)
                  else
                    MainPlanFormulas[I] := MainPlanFormulas[I] + ', ' + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx);

                if main_ostaok_formula = '' then
                  main_ostaok_formula := '=Sum(' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx)
                else
                  main_ostaok_formula := main_ostaok_formula + ', ' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx);

                inc(idx);
              end;

              unfufilled_Formula := '=Sum(' + getNameCol(9 +  countYears - 1) + IntToStr(idx) + ':';
              plan_Formula := '=Sum(' + getNameCol(10 +  countYears - 1) + IntToStr(idx) + ':';
              fact_Formula := '=Sum('+ getNameCol(11 +  countYears - 1) + IntToStr(idx) + ':';
              Formula := '=Sum(E' + IntToStr(idx) + ':';
              for I := 0 to countYears - 1 do
                YearFormulas[I] := '=Sum(' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx) + ':';
              for I := 0 to planMonths - 1 do
                PlanFormulas[I] := '=Sum(' + getNameCol(COL_BEG_PLAN + I  + countYears) + IntToStr(idx) + ':';

              ostatok_formul := '=Sum(' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx) + ':';

              Excel.Worksheets[1].Rows[idx + 1].Insert;

              if FieldAsString('treaty_status') = 'P' then
              begin
                // Темы из темплана
                case ISTFIN_KOD of
                  // Источник финансирования собственные средства
                  1 : Excel.WorkSheets[1].Rows[idx + offs_table + 3].Copy(Excel.Worksheets[1].Rows[idx]);
                  2 : Excel.WorkSheets[1].Rows[idx + offs_table + 2].Copy(Excel.Worksheets[1].Rows[idx]);
                      end;
                tr_status := 'P';
              end
              else
                case ISTFIN_KOD of
                  // Источник финансирования собственные средства
                  1 : Excel.WorkSheets[1].Rows[idx + offs_table + 1].Copy(Excel.Worksheets[1].Rows[idx]);
                  2 : begin
                        Excel.WorkSheets[1].Rows[idx + offs_table].Copy(Excel.Worksheets[1].Rows[idx]);
                        if ConcDogID >= 0 then
                        begin
                          with TOracleQuery.Create(Self) do
                          begin
                            Session:= dmGlobal.seOracle;

                            SQL.Append('SELECT  ''ПО ДОГОВОРУ №'' || NUM ');
                            SQL.Append('  FROM RN.MITRCONCERN');
                            SQL.Append(' WHERE  ID = :DOG_ID');

                            DeclareVariable('DOG_ID', otInteger);
                            SetVariable('DOG_ID', ConcDogID);
                            Execute;

                            Excel.WorkSheets[1].Cells[idx, 1] := Excel.WorkSheets[1].Cells[idx, 1].Text + String(FieldAsString(0));

                            Destroy;
                          end;
                        end;
                      end;
                end;

              inc(idx);
            end;

            for I := 0 to countYears - 1 do
              summpay_stages_year[I] := 0;
            summpay_fact_year := 0;
            summpay_plan_year := 0;
            ostatok := 0;

            curr_un_st := 0;
            curr_pl_st := 0;

            // Следующий договор
            count_plan_st := Integer(Field('count_pl_st')); // Количество этапов в плане
            count_un_st := Integer(Field('count_un_st')); // Количество невыполненых этапов

            // Вычисляем количество строк
            if (count_plan_st = 0) and (count_un_st > 0) then
              rows := count_un_st
            else if (count_plan_st > 0) and (count_un_st = 0) then
              rows := count_plan_st
            else
              rows := getNOK(count_plan_st, count_un_st);
            if rows < 2 then
              rows := 2;

            for I := 0 to rows - 1 do
              Excel.Worksheets[1].Rows[idx].Insert;

            count_stages := Integer(Field('count_per_treaty')); // Количество этапов на договор
            summpay_per_treaty := Extended(Field('tr_summpay')); // сумма по договору
            n_summpay_per_treaty  := 0;
            erate_date := Field('intro_date');
            erate := Extended(Field('e_rate'));

            if (Field(7) = 'O') or (Field(7) = 'P')  then // OPERATIVE Действующий договор
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 3].Copy(Excel.Worksheets[1].Rows[idx]);
              for I := 2 to rows - 1 do
                Excel.WorkSheets[1].Rows[idx + offs_table + rows + 4].Copy(Excel.Worksheets[1].Rows[idx + I - 1]);
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 5].Copy(Excel.Worksheets[1].Rows[idx + rows - 1]);
            end
            else if Field(7) = 'F' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 6].Copy(Excel.Worksheets[1].Rows[idx]);
              for I := 2 to rows - 1 do
                Excel.WorkSheets[1].Rows[idx + offs_table + rows + 7].Copy(Excel.Worksheets[1].Rows[idx + I - 1]);
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 8].Copy(Excel.Worksheets[1].Rows[idx + rows - 1]);
              Excel.WorkSheets[1].Cells[idx + rows - 1, 2] := 'ЗАКРЫТ';
            end
            else if Field(7) = 'A' then
            begin
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 6].Copy(Excel.Worksheets[1].Rows[idx]);
              for I := 2 to rows - 1 do
                Excel.WorkSheets[1].Rows[idx + offs_table + rows + 7].Copy(Excel.Worksheets[1].Rows[idx + I - 1]);
              Excel.WorkSheets[1].Rows[idx + offs_table + rows + 8].Copy(Excel.Worksheets[1].Rows[idx + rows - 1]);
              Excel.WorkSheets[1].Cells[idx + rows - 1, 2] := 'АННУЛИРОВАН';
            end;

            Excel.WorkSheets[1].Cells[idx, 1] := count; // номер по порядку

            count_stages := FieldAsInteger('count_per_treaty');
            num_stage := 0;
            inc(count);

            Excel.WorkSheets[1].Cells[idx + rows - 1, 1] := FieldAsString('num'); // id
            Excel.WorkSheets[1].Cells[idx, 2] := String(Field('name')); // номер договора и исполнитель
            Excel.WorkSheets[1].Cells[idx, 3] := String(Field('subject')); // тема договора
            if rows > 2 then
            begin
              RowHeight := Excel.WorkSheets[1].Rows[idx].Height;

              Excel.WorkSheets[1].Range['A'+IntToStr(idx), 'A'+IntToStr(idx + rows - 2)].MergeCells := true;
              Excel.WorkSheets[1].Range['B'+IntToStr(idx), 'B'+IntToStr(idx + rows - 2)].MergeCells := true;
              Excel.WorkSheets[1].Range['C'+IntToStr(idx), 'C'+IntToStr(idx + rows - 2)].MergeCells := true;

              if Excel.WorkSheets[1].Rows[IntToStr(idx)+ ':'+ IntToStr(idx + rows - 2)].Height < RowHeight then
                Excel.WorkSheets[1].Rows[IntToStr(idx)+ ':'+ IntToStr(idx + rows - 1)].RowHeight := RowHeight/(rows - 1);
            end;
            Excel.WorkSheets[1].Range['E'+IntToStr(idx), 'E'+IntToStr(idx + rows - 1)].MergeCells := true;
            for I := 0 to countYears - 1 do
              Excel.WorkSheets[1].Range[getNameCol(COL_BEG_YEARS + I)+IntToStr(idx), getNameCol(COL_BEG_YEARS + I)+IntToStr(idx + rows - 1)].MergeCells := true;
            Excel.WorkSheets[1].Range[getNameCol(10 + countYears - 1)+IntToStr(idx), getNameCol(10 + countYears - 1)+IntToStr(idx + rows - 1)].MergeCells := true;
            Excel.WorkSheets[1].Range[getNameCol(11 + countYears - 1)+IntToStr(idx), getNameCol(11 + countYears - 1)+IntToStr(idx + rows - 1)].MergeCells := true;

            Excel.WorkSheets[1].Cells[idx + rows - 2, 4] := String(Field('tr_datefrom')); // дата начала
            Excel.WorkSheets[1].Cells[idx + rows - 1, 4] := String(Field('tr_dateto')); // дата окончания

            if count_un_st = 0 then
            begin
              Excel.WorkSheets[1].Range[getNameCol(7 +  countYears - 1)+IntToStr(idx), getNameCol(7 +  countYears - 1)+IntToStr(idx + rows - 1)].MergeCells := true;
              Excel.WorkSheets[1].Range[getNameCol(8 +  countYears - 1)+IntToStr(idx), getNameCol(8 +  countYears - 1)+IntToStr(idx + rows - 1)].MergeCells := true;
              Excel.WorkSheets[1].Range[getNameCol(9 +  countYears - 1)+IntToStr(idx), getNameCol(9 +  countYears - 1)+IntToStr(idx + rows - 1)].MergeCells := true;
            end;

            if count_plan_st = 0 then
            begin
              for I := 0 to planMonths do
                Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN - 1 + I +  countYears)+IntToStr(idx), getNameCol(COL_BEG_PLAN - 1 + I +  countYears)+IntToStr(idx + rows - 1)].MergeCells := true;
            end;

            Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN + planMonths + countYears)+IntToStr(idx), getNameCol(COL_BEG_PLAN + planMonths + countYears)+IntToStr(idx + rows - 1)].MergeCells := true;

          end;

          if not FieldIsNull('st_dateto') then
          begin
            if (FieldAsDate('st_dateto') < dateTo) and FieldIsNull('st_dateact') then
            begin
              // Не выполненный этап

              // Определяем число ячеек, где будут размещен не выполненый этап
              r := rows div count_un_st;
              if r > 1 then
              begin
                Excel.WorkSheets[1].Range[getNameCol(7 +  countYears - 1)+IntToStr(idx + curr_un_st*r), getNameCol(7 +  countYears - 1)+IntToStr(idx + (curr_un_st+1)*r - 1)].MergeCells := true;
                Excel.WorkSheets[1].Range[getNameCol(8 +  countYears - 1)+IntToStr(idx + curr_un_st*r), getNameCol(8 +  countYears - 1)+IntToStr(idx + (curr_un_st+1)*r - 1)].MergeCells := true;
                Excel.WorkSheets[1].Range[getNameCol(9 +  countYears - 1)+IntToStr(idx + curr_un_st*r), getNameCol(9 +  countYears - 1)+IntToStr(idx + (curr_un_st+1)*r - 1)].MergeCells := true;
              end;

              Excel.WorkSheets[1].Cells[idx + curr_un_st*r, 7 + countYears - 1] := FieldAsString('st_num');
              Excel.WorkSheets[1].Cells[idx + curr_un_st*r, 8 + countYears - 1] := FieldAsString('str_st_dateto');
              Excel.WorkSheets[1].Cells[idx + curr_un_st*r, 9 + countYears - 1] := (FieldAsFloat('e_rate')*Extended(Field('stage_summpay')));
              inc(curr_un_st);
            end;

            if (FieldAsDate('st_dateto') >= dateTo) and (FieldAsDate('st_dateto') < newYear) {and FieldIsNull('st_dateact')} then
            begin
              // График финансирования

              // Определяем число ячеек, где будут размещен не выполненый этап
              r := rows div count_plan_st;

              if not FieldIsNull('st_dateact') then
              begin
                // Этап сдан
                // Выделяем сданные этапы
                for I := 0 to r - 1 do
                begin
                  if (I = 0) and (curr_pl_st = 0) then
                    Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN - 1 + countYears) + IntToStr(idx + offs_table + rows + 6),
                                              getNameCol(COL_BEG_PLAN - 1 + countYears + countColPlan - 1) + IntToStr(idx + offs_table + rows + 6)].Copy(
                                  Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN - 1 + countYears) + IntToStr(idx + r*curr_pl_st + I),
                                                            getNameCol(COL_BEG_PLAN - 1 + countYears + countColPlan - 1) + IntToStr(idx + r*curr_pl_st + I)])
                  else if (I = (r - 1)) and (curr_pl_st = (count_plan_st - 1)) then
                    Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN - 1 + countYears) + IntToStr(idx + offs_table + rows + 8),
                                              getNameCol(COL_BEG_PLAN - 1 + countYears + countColPlan - 1) + IntToStr(idx + offs_table + rows + 8)].Copy(
                                  Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN - 1 + countYears) + IntToStr(idx + r*curr_pl_st + I),
                                                            getNameCol(COL_BEG_PLAN - 1 + countYears + countColPlan - 1) + IntToStr(idx + r*curr_pl_st + I)])
                  else
                    Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN - 1 + countYears) + IntToStr(idx + offs_table + rows + 7),
                                              getNameCol(COL_BEG_PLAN - 1 + countYears + countColPlan - 1) + IntToStr(idx + offs_table + rows + 7)].Copy(
                                  Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN - 1 + countYears) + IntToStr(idx + r*curr_pl_st + I),
                                                            getNameCol(COL_BEG_PLAN - 1 + countYears + countColPlan - 1) + IntToStr(idx + r*curr_pl_st + I)]);

                end;
              end;

              if r > 1 then
                for I := 0 to countColPlan - 1 do
                  Excel.WorkSheets[1].Range[getNameCol(COL_BEG_PLAN - 1 + countYears + I) +IntToStr(idx + curr_pl_st*r), getNameCol(COL_BEG_PLAN - 1 + countYears + I)+IntToStr(idx + (curr_pl_st+1)*r - 1)].MergeCells := true;

              Excel.WorkSheets[1].Cells[idx + curr_pl_st*r, colBegPlan] := FieldAsString('st_num');
              // вычисляем столбец, куда будет занесено сумма этапа
              DecodeDate(FieldAsDate('st_dateto'), ye, mo, da);
              J := colBegPlan + mo - (12 - planMonths);
              Excel.WorkSheets[1].Cells[idx + curr_pl_st*r, J] := (FieldAsFloat('e_rate')*Extended(Field('stage_summpay')));


              inc(curr_pl_st);
            end;

          end;


          //dec(count_stages);
          inc(num_stage);
          if not FieldIsNull('stage_year_to') then
          begin
            stage_year_to := StrToInt(String(Field('stage_year_to')));
            for I := 0 to countYears - 1 do
              if stage_year_to = DogYears[I] then
              begin
                summpay_stages_year[I] := summpay_stages_year[I] + (Extended(Field('stage_summpay'))*FieldAsFloat('e_rate'));
                break;
              end;
          end;

          n_summpay_per_treaty  := n_summpay_per_treaty + (Extended(Field('stage_summpay'))*FieldAsFloat('e_rate'));
          summpay_per_treaty := summpay_per_treaty - Extended(Field('stage_summpay'));

          if (FieldAsDate('st_dateto') >= fromPeriud) and (FieldAsDate('st_dateto') < toPeriud) then
          begin
            summpay_plan_year := summpay_plan_year + (FieldAsFloat('e_rate')*Extended(Field('stage_summpay')));
          end;

          if (FieldIsNull('st_dateact')) and (FieldAsDate('st_dateto') >= EncodeDate(YEAR, 1, 1)) and (FieldAsDate('st_dateto') < EncodeDate(YEAR + 1, 1, 1)) then
            ostatok := ostatok + (FieldAsFloat('e_rate')*Extended(Field('stage_summpay')));

          if (FieldAsDate('st_dateto') >= fromPeriud) and (FieldAsDate('st_dateto') < toPeriud) and (not FieldIsNULL('st_dateact')) then
          begin
            summpay_fact_year := summpay_fact_year + (FieldAsFloat('e_rate')*Extended(Field('stage_summpay')));
          end;

          if num_stage = count_stages then
          begin
            if Integer(Field(6)) <> BYR then
            begin
              Excel.WorkSheets[1].Cells[idx + rows - 1 , 3] := 'Курс ' + FloatToStr(erate) + ' ' + String(Field('currency_name'))
                                                    + '  на ' + DateToStr(erate_date);
              Excel.WorkSheets[1].Cells[idx, 5] := IntToStr(Round(n_summpay_per_treaty + summpay_per_treaty*erate));

              for I := 0 to countYears - 1 do
                if summpay_stages_year[I] > 0 then
                  Excel.WorkSheets[1].Cells[idx, colBegYears + I] := IntToStr(Round(summpay_stages_year[I]));

            end
            else
            begin
              Excel.WorkSheets[1].Cells[idx, 5] := IntToStr(Round(n_summpay_per_treaty + summpay_per_treaty));

              for I := 0 to countYears - 1 do
                if summpay_stages_year[I] > 0 then
                  Excel.WorkSheets[1].Cells[idx, colBegYears + I] := IntToStr(Round(summpay_stages_year[I]));

            end;

            if tr_status <> 'P' then
            begin
              Excel.WorkSheets[1].Cells[idx, 10 + countYears - 1] := IntToStr(Round(summpay_plan_year));
              Excel.WorkSheets[1].Cells[idx, 11 + countYears - 1] := IntToStr(Round(summpay_fact_year));
              if ostatok <> 0 then
                Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + planMonths] := IntToStr(Round(ostatok));

            end;
          end;
          prev_id := Integer(Field('ID'));


          if num_stage = count_stages then
            buildingReport.Next;
        except
          Screen.Cursor:=crDefault;
          MessageBox(Handle, 'Ошибка - нет возможности добавить данные в ячейки.',
                     'Ошибка', mb_OK or mb_IconHand);
          Exit;
        end;
        Next;
      end;
      inc(idx, rows);

      if Formula <> '' then
      begin
        unfufilled_Formula := unfufilled_Formula + getNameCol(9 +  countYears - 1) + IntToStr(idx - 1) + ')';
        plan_Formula := plan_Formula + getNameCol(10 +  countYears - 1) + IntToStr(idx - 1) + ')';
        fact_Formula := fact_Formula + getNameCol(11 +  countYears - 1) + IntToStr(idx - 1) + ')';
        Formula := Formula + 'E' + IntToStr(idx - 1) + ')';
        for I := 0 to countYears - 1 do
          YearFormulas[I] := YearFormulas[I] + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx - 1) + ')';
        for I := 0 to planMonths - 1 do
          PlanFormulas[I] := PlanFormulas[I] + getNameCol(COL_BEG_PLAN + I + countYears) + IntToStr(idx - 1) + ')';

        ostatok_formul := ostatok_formul + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx - 1) + ')';

        Excel.Worksheets[1].Rows[idx + 1].Insert;
        Excel.WorkSheets[1].Rows[idx + offs_table + ROWS_TEMPLATE - 2].Copy(Excel.Worksheets[1].Rows[idx]);

        Excel.WorkSheets[1].Cells[idx, 9 + countYears - 1].Formula := unfufilled_Formula;
        Excel.WorkSheets[1].Cells[idx, 10 + countYears - 1].Formula := plan_Formula;
        Excel.WorkSheets[1].Cells[idx, 11 + countYears - 1].Formula := fact_Formula;
        Excel.WorkSheets[1].Cells[idx, 5].Formula := Formula;
        for I := 0 to countYears - 1 do
          Excel.WorkSheets[1].Cells[idx, colBegYears + I].Formula := YearFormulas[I];
        for I := 0 to planMonths - 1 do
          Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + I].Formula := PlanFormulas[I];

        Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + planMonths].Formula := ostatok_formul;

        if MainFormula = '' then
        begin
          main_unfufilled_Formula := '=SUM(' + getNameCol(9 +  countYears - 1) + IntToStr(idx) + ')';
          main_plan_Formula := '=SUM(' + getNameCol(10 +  countYears - 1) + IntToStr(idx) + ')';
          main_fact_Formula := '=SUM(' + getNameCol(11 +  countYears - 1) + IntToStr(idx) + ')';
          MainFormula := '=SUM(E' + IntToStr(idx) + ')';
        end
        else
        begin
          main_unfufilled_Formula := main_unfufilled_Formula +  ', ' + getNameCol(9 +  countYears - 1) + IntToStr(idx) + ')';
          main_plan_Formula := main_plan_Formula +  ', ' + getNameCol(10 +  countYears - 1) + IntToStr(idx) + ')';
          main_fact_Formula := main_fact_Formula +  ', ' + getNameCol(11 +  countYears - 1)+ IntToStr(idx) + ')';
          MainFormula := MainFormula +  ', E' + IntToStr(idx) + ')';
        end;
        for I := 0 to countYears - 1 do
          if MainYearFormulas[I] = '' then
            MainYearFormulas[I] := '=Sum(' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx)
          else
            MainYearFormulas[I] := MainYearFormulas[I] + ', ' + getNameCol(COL_BEG_YEARS + I) + IntToStr(idx);

        for I := 0 to planMonths - 1 do
          if MainPlanFormulas[I] = '' then
            MainPlanFormulas[I] := '=Sum(' + getNameCol(COL_BEG_PLAN + I  + countYears) + IntToStr(idx)
          else
            MainPlanFormulas[I] := MainPlanFormulas[I] + ', ' + getNameCol(COL_BEG_PLAN + I  + countYears) + IntToStr(idx);

        if main_ostaok_formula = '' then
            main_ostaok_formula := '=Sum(' + getNameCol(COL_BEG_PLAN + planMonths +  countYears) + IntToStr(idx)
          else
            main_ostaok_formula := main_ostaok_formula + ', ' + getNameCol(COL_BEG_PLAN + planMonths + countYears) + IntToStr(idx);

        inc(idx);

        Excel.Worksheets[1].Rows[idx + 1].Insert;
        Excel.WorkSheets[1].Rows[idx + offs_table + ROWS_TEMPLATE - 1].Copy(Excel.Worksheets[1].Rows[idx]);

        Excel.WorkSheets[1].Cells[idx, 9 + countYears - 1].Formula := main_unfufilled_Formula;
        Excel.WorkSheets[1].Cells[idx, 10 + countYears - 1].Formula := main_plan_Formula;
        Excel.WorkSheets[1].Cells[idx, 11 + countYears - 1].Formula := main_fact_Formula;
        Excel.WorkSheets[1].Cells[idx, 5].Formula := MainFormula;
        for I := 0 to countYears - 1 do
          Excel.WorkSheets[1].Cells[idx, colBegYears + I].Formula := MainYearFormulas[I];
        for I := 0 to planMonths - 1 do
          Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + I].Formula := MainPlanFormulas[I];

        Excel.WorkSheets[1].Cells[idx, colBegPlan + 1 + planMonths].Formula := main_ostaok_formula;

        inc(idx);
      end;


      for I := 0 to ROWS_TEMPLATE + offs_table - 1 do
        Excel.Worksheets[1].Rows[idx].Delete;  // удаляем записи шаблонной таблицы
      Close;

    end;

   if rec_count > 0 then
   begin
     //buildingReport.Next;
     buildingReport.Finish;
   end;

  finally
    Screen.Cursor:=crDefault;
    Excel.Visible:=True;

    // Окну buildingReport сообщаем, что формирования отчета закончилось
    // и оно должно снять блокировку данных
    buildingReport.SetEndCopy;
    // Закрываем окно buildingReport и освобождаем память занимаемой данным окном
    buildingReport.Close;

    // Делаем доступным приложение, для пользователя
    resetBusy;
  end;
end;

end.
