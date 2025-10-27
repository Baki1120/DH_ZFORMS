@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Invoice Header'
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.semanticKey: [ 'BillingDocument' ]
@Search.searchable: true
define root view entity ZI_CI_H
  as select from ZI_DATA_BILL as CustomerInvoiceHeader
  composition [0..*] of zi_ci_log                  as _CustomerInvoiceLog
  association [0..1] to I_OverallBillingStatusText as _BillingStatusText on  $projection.OverallBillingStatus = _BillingStatusText.OverallBillingStatus
                                                                         and _BillingStatusText.Language      = $session.system_language
{
      @Search.defaultSearchElement: true
  key CustomerInvoiceHeader.BillingDocument,
      CustomerInvoiceHeader.BillingDocumentDate,
      CustomerInvoiceHeader.AccountingDocument,
      CustomerInvoiceHeader.CompanyCode,
      CustomerInvoiceHeader.FiscalYear,
      @ObjectModel.text.element: [ 'CustomerName' ]
      @EndUserText.label: 'Customer Code'
      CustomerInvoiceHeader.SoldToParty               as CustomerCode,
      @Semantics.text:true
      @UI.hidden: true
      CustomerInvoiceHeader.CustomerName,
      @ObjectModel.text.element: [ 'StatusText' ]
      CustomerInvoiceHeader.OverallBillingStatus,
      @Semantics.text: true
      @UI.hidden: true
      _BillingStatusText.OverallBillingStatusDesc     as StatusText,
      _CustomerInvoiceLog,
      _BillingStatusText
}
