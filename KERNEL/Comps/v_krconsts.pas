{*******************************************************}
{                                                       }
{       Delphi Visual Component Library Support         }
{                                                       }
{	   ORV.ASUP.BelarusKali, 1997-2003		}
{                                                       }
{*******************************************************}

unit v_KrConsts;

interface

resourcestring
  DefaultSchema= 'RN';
  SubSection='Software\BelarusKali\NIOKR\';
  CUserLockMsg= 'Запись заблокирована другим пользователем';
  CUserDeleteMsg= 'Запись была удалена другим пользователем';
  CUserUpdateMsg= 'Запись была изменена другим пользователем';
  CUnknownMess= 'Ошибка сервера базы данных';
  CNonCheckMess= 'Нарушение ограничения доступа к данным. Операция невозможна';
  CKillForeignMess= 'На данную запись имеются ссылки. Операция невозможна';
  RowCountTxt1='Найдено строк: %d.';
  RowCountTxt2= 'Строка %d/%d.';
implementation

end.
