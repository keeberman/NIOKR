unit v_repdet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,ComCtrls;

type
  TfmRepDetails = class(TForm)
    lbObjects: TListBox;
    procedure lbObjectsKeyPress(Sender: TObject; var Key: Char);
    procedure lbObjectsDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure AddToTree;
  public
    { Public declarations }
    SelectedNode: TTreeNode;
    TreeNodes: TTreeNodes;
  end;

var
  fmRepDetails: TfmRepDetails;

implementation
uses v_fastrep,db;
{$R *.DFM}

procedure TfmRepDetails.AddToTree;
var
  I: Integer;
  NewNode: TTreeNode;
  Len: Integer;

function Max(Val1,Val2:Integer): Integer;
begin
  if Val1<Val2 then Result:= Val2
  else Result:= Val1;
end;

begin
  for I:= lbObjects.Items.Count-1 downto 0 do
    if lbObjects.Selected[I] then
    begin
      if Assigned(SelectedNode) then
        NewNode:= TreeNodes.AddChildObject(
          SelectedNode,lbObjects.Items[I],lbObjects.Items.Objects[I])
      else NewNode:= TreeNodes.AddObject(nil,lbObjects.Items[I]
             ,lbObjects.Items.Objects[I]);
      with NewNode do
      begin
        ImageIndex:= Level;
        SelectedIndex:= Level;
        StateIndex:= -1;
        if Level= 1 then
        begin
          {Len:= Max( Length(TField(lbObjects.Items.Objects[I]).DisplayLabel),
                     TField(lbObjects.Items.Objects[I]).DisplayWidth);}
          Len:= TField(lbObjects.Items.Objects[I]).DisplayWidth;
          with TreeNodes.AddChildObject(NewNode
            ,IntToStr(Len),Pointer(Len)) do
          begin
            ImageIndex:= Level;
            SelectedIndex:= Level;
            StateIndex:= -1;
          end;
        end;
      end;
      lbObjects.Items.Delete(I);
    end;
  if Assigned(SelectedNode) then SelectedNode.Expand(false)
  else NewNode.Expand(false);
end;

procedure TfmRepDetails.lbObjectsKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key)= VK_RETURN then AddToTree;
end;

procedure TfmRepDetails.lbObjectsDblClick(Sender: TObject);
begin
  AddToTree;
end;

end.
