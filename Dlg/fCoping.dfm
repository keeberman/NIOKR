object frmCoping: TfrmCoping
  Left = 326
  Top = 243
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Идет процесс формирования отчета...'
  ClientHeight = 93
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  PixelsPerInch = 96
  TextHeight = 13
  object lblCopingTable: TLabel
    Left = 0
    Top = 8
    Width = 545
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Имя копируемой таблицы'
  end
  object gCopingProcent: TGauge
    Left = 0
    Top = 32
    Width = 545
    Height = 33
    ForeColor = clNavy
    Progress = 0
  end
  object lblTitleOfCalcTime: TLabel
    Left = 0
    Top = 72
    Width = 137
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Расчетное время:'
  end
  object lblTitleOfRemainderTime: TLabel
    Left = 326
    Top = 72
    Width = 86
    Height = 13
    Alignment = taRightJustify
    Caption = 'Время осталось:'
  end
  object lblCalcTime: TLabel
    Left = 138
    Top = 72
    Width = 137
    Height = 13
    AutoSize = False
  end
  object lblRemainderTime: TLabel
    Left = 412
    Top = 72
    Width = 136
    Height = 13
    AutoSize = False
  end
  object Timer: TTimer
    Enabled = False
    Interval = 250
    OnTimer = TimerTimer
    Left = 56
    Top = 40
  end
end
