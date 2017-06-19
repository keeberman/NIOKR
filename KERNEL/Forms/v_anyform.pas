unit v_anyform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;
const
// Общие инструкции
   IN_NONE=$0000;

// Сообщения
   UM_CHANGEMODE = WM_USER+400;
   UM_INITIALIZE = WM_USER+401;
   UM_OTHERS = WM_USER+402;
   UM_PROGRESSUPDATE = WM_USER + 403;
   UM_FASTREPORT = WM_USER + 404;

// Инструкции  для UM_CHANGEMODE
   IN_QUERY=$0001;
   IN_INSERT=$0002;
   IN_EDIT=$0003;
   IN_DELETE=$0004;
   IN_VIEW=$0005;

// Стили для UM_CHANGEMODE
   MS_NORMAL=$0000;
   MS_CALLBACK=$0001;

// Инструкции  для UM_INITIALIZE
   IN_SETDATASET= $0001;
   IN_SETDATASETLIST= $0002;
   IN_SETCALLBACKWIN= $0003;

// Инструкции  для UM_OTHERS
   IN_SORT=$0001;
   IN_PRINT=$0002;
   IN_QUIT=$0003;
   IN_PAGEDN=$0004;
   IN_PAGEUP=$0005;
   IN_PRIOR=$0006;
   IN_NEXT=$0007;
   IN_PRIORLEVEL=$0008;
   IN_NEXTLEVEL=$0009;
   IN_ACTIVATE=$000A;
   IN_CLOSE=$000B;
   IN_NAVIGATOR=$0000C;
   IN_STATUS=$000D;
   IN_GETACCESS=$000E;
   IN_SETACCESS=$000F;
   IN_GETDATASET=$0010;
   IN_DIRECTLIST= $0011;
   IN_DIRECTMOVE= $0012;
   IN_MASTER= $0013;
   IN_REFRESH= $0014;
   IN_STORE= $0015;
   IN_GETSENDER= $0016;
   IN_SETRECORDCOUNT= $0017;
   IN_STEP_BY_STEP= $0018;
   IN_COMPUTE= $0019;
   IN_SECRETQUERY= $001A;
   IN_UNSTORE= $001B;
   IN_SAVEQUERY= $001C;
   IN_SAVEQUERYAS= $001D;
   IN_REFRESH_SAVEDQUERYWIN= $001E;
   IN_REFRESH_SAVEDQUERYITEMS= $001F;
   IN_EXECQUERY= $0020;
   IN_FORMQUERY_REPAINT= $0021;
   IN_DATANAVIGATOR = $0022;
   IN_TREEMENU = $0023;
   IN_ACTIVATETREENODE= $0024;
   IN_GETRECORDCOUNT= $0025;
   IN_SEND_EMAIL = $0026;
   IN_GET_USE_MAPI = $0027;
   IN_EMAIL_VISIBLE = $0028;

// Инструкции  для UM_FASTREPORT
   IN_DEFAULT_DATASET=$0001;
   IN_DEFAULT_FIELDS=$0002;
   IN_ENABLE_DATASETS=$0003;
   IN_SAVE_QUERY= $0004;
   IN_CLOSE_FAST_FORM= $0005;
   IN_SET_FASTREPORT_ID= $0006;

// Остальное
   Design_FullScreen_width = 800;
   //Ширина экрана,установленная при разработке приложения

   Design_FullScreen_height = 600;
   //Высота экрана,установленная при разработке приложения

   DEFAULT_HINT_PAUSE=800;
   //Задержка перед отображением подсказки (в миллисекундах) по умолчанию

   DEFAULT_HINT_HIDE_PAUSE=2500;
   //Время отображения подсказки (в миллисекундах)

   WORKTIME_HINT_PAUSE= DEFAULT_HINT_PAUSE div 2;
   {Задержка перед отображением подсказки (в режиме корректировки справочн.
   информации) }

type
  TExploreButtons= (ebPrior,ebNext);

  TExploreState= set of TExploreButtons;

  TNavigatorData= record
    ExploreState: TExploreState;
    Path: string;
  end;

  PTNavigatorData= ^TNavigatorData;

  TfmAnyForm = class(TForm) //Предок для форм приложения
    paTop: TPanel;
    paMiddle: TPanel;
    paSecretBottom: TPanel;
    paBottom: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    {Обработчик события OnShow.В случае более низкого разрешения
    монитора проводится масштабирование}

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAnyForm: TfmAnyForm;

implementation

{$R *.DFM}

procedure TfmAnyForm.FormShow(Sender: TObject);
begin
 if GetSystemMetrics(SM_CXFULLSCREEN)<Design_FullScreen_width then
    ScaleBy(GetSystemMetrics(SM_CXFULLSCREEN),Design_FullScreen_width)
end;

procedure TfmAnyForm.FormCreate(Sender: TObject);
begin
  //FRegistASUPQueries := TList.Create;
end;

procedure TfmAnyForm.FormDestroy(Sender: TObject);
begin
  //FRegistASUPQueries.Destroy;
end;

end.
