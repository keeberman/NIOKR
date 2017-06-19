unit vregasup;

interface
procedure Register;

implementation
uses
  Classes,VdbASUP,DesignIntf,{v_DSLProp,} ExptIntf, vExpandedNode, v_fmgen;
procedure Register;
begin
  RegisterComponents('VASUP',
  [TVDBEditChar,TVDBEMath,TVWatchEdit,TVDBERus,TVDBEDate]);
  RegisterComponents('VASUP', [TVCommentQuery,TVASUPQuery,TVBuilder
                             ,TVMetaDataSource,TVEditFormID,TVMyTable, TVExpandedNode]);
//  RegisterPropertyEditor(TypeInfo(string),TVASUPQuery,'Order',TOrderProperty);
//  RegisterPropertyEditor(TypeInfo(TDataSets),TVMetaDataSource,'DataSetList',TDatasetListProperty);
//  RegisterPropertyEditor(TypeInfo(string),TVASUPQuery,'EditorClassName',TEditFormProperty);
//  RegisterPropertyEditor(TypeInfo(string),TVASUPQuery,'ReportClassName',TEditFormProperty);
//  RegisterPropertyEditor(TypeInfo(string),TVMyTable,'EditorClassName',TEditFormProperty);
//  RegisterPropertyEditor(TypeInfo(string),TVMyTable,'ReportClassName',TEditFormProperty);*}
//  RegisterPropertyEditor(TypeInfo(TTabSheetList), TVExpandedNode,'TabSheets',TTabSheetsOfExpNodeEditor);
  RegisterComponentEditor(TVEditFormID,TEditFormIDEditor);
end;

end.
