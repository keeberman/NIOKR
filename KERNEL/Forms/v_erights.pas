unit v_erights;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  v_explorer, ComCtrls, Placemnt, Db, vDbASUP, Grids, DBGrids, RXDBCtrl,
  ExtCtrls;

type
  TfmExpRights = class(TfmExplorer)
    tcRights: TTabControl;
    procedure FormCreate(Sender: TObject);
              //���������� OnCreate �����

    procedure tcRightsChanging(Sender: TObject; var AllowChange: Boolean);
              {���������� OnChanging ���������� tcRights.
              ��������� ������������ �������� ��� ����������
              ������� ����}

    procedure tcRightsChange(Sender: TObject);
              {���������� OnChange ���������� tcRights.
              ��������� dsWork.DataSet �� ���������������
              �������� �������� DataSet}

    procedure FormDestroy(Sender: TObject);
              {���������� OnDestroy �����. ��������� ���
              ����������� DataSet'�}

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmExpRights: TfmExpRights;

implementation
uses globals,v_anyform;
{$R *.DFM}

procedure TfmExpRights.FormCreate(Sender: TObject);
begin
  inherited;
  DBGrid.Parent:= tcRights;
end;

procedure TfmExpRights.tcRightsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:= FCurMode= IN_NONE;
end;

procedure TfmExpRights.tcRightsChange(Sender: TObject);
begin
  Screen.Cursor:= crSQLWait;
  dsWork.DataSetList.Clear;
  case tcRights.TabIndex of
    0: dsWork.AddToList(dmGlobal.quMiprava);
    1: dsWork.AddToList(dmGlobal.quMiprava_All);
  end;
  dsWork.Start;
  Screen.Cursor:= crDefault;
end;

procedure TfmExpRights.FormDestroy(Sender: TObject);
begin
  dmGlobal.quMiprava.Close;
  dmGlobal.quMiprava_All.Close;
  inherited;
end;

end.
