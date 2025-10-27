@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Merge File'
define view entity ZI_MERGE_FILES
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZD_MERGE_FILE' )
{
      @UI.lineItem: [{ position: 10, importance: #HIGH }]
      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
      @UI.lineItem: [{ position: 20, importance: #MEDIUM }]
  key value_position,
      @UI.lineItem: [{ position: 30, importance: #MEDIUM }]
      @Semantics.language: true
      @EndUserText.label: 'Language'
  key language,
      @UI.lineItem: [{ position: 40, importance: #HIGH, label: 'Option' }]
      @UI.identification: [{ label: 'Option' }]
      @ObjectModel.text.element: [ 'MergeFileText' ]
      value_low as MergeFile,
      @UI.lineItem: [{ position: 50, importance: #MEDIUM, label: 'Description' }]
      @Semantics.text: true
      @EndUserText.label: 'Short Description'
      text      as MergeFileText
}
