@EndUserText.label: 'Merge PDF'
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
define root abstract entity ZA_MER_PDF
{

  @EndUserText.label: 'Option'
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_MERGE_FILE', element: 'MergeFile' },
                                       useForValidation: true,
                                       additionalBinding: [{ usage: #RESULT, localElement: 'MergeFileText', element: 'MergeFileText' }] }]
  @Search.defaultSearchElement: true
  MergeFile     : abap.char( 1 );

  @Semantics.text:true
  @EndUserText.label: 'Description'
  @UI.hidden: true
  MergeFileText : abap.char( 30 );

}
