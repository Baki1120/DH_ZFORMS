@AbapCatalog.sqlViewName: 'ZMEFILE'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Merge File'
@Search.searchable: true
@ObjectModel.resultSet.sizeCategory: #XS
define view ZC_MERGE_FILE
  as select from ZI_MERGE_FILES
{
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Option'
      @UI.textArrangement: #TEXT_FIRST
  key MergeFile,
      @Semantics.text: true
      @UI.hidden: true
      MergeFileText
}
where
  language = $session.system_language
