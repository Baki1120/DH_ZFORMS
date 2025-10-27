@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: 'Get data of billing'
define view entity ZI_DATA_BILL
  as select from I_BillingDocument
{
  key BillingDocument,
      BillingDocumentDate,
      AccountingDocument,
      CompanyCode,
      FiscalYear,
      SoldToParty,
      _SoldToParty.CustomerName,
      OverallBillingStatus
}
where
      BillingDocumentIsCancelled is initial
  and CancelledBillingDocument   is initial

union

select from  zi_ci_log         as CustomerInvoiceLog
  inner join I_BillingDocument as BillingDocument on CustomerInvoiceLog.BillingDocument = BillingDocument.BillingDocument

{
  key CustomerInvoiceLog.BillingDocument,
      BillingDocument.BillingDocumentDate,
      BillingDocument.AccountingDocument,
      BillingDocument.CompanyCode,
      BillingDocument.FiscalYear,
      BillingDocument.SoldToParty,
      BillingDocument._SoldToParty.CustomerName,
      BillingDocument.OverallBillingStatus

}
