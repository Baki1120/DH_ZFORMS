@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Invoices PDF Files'
@Search.searchable: true
define view entity ZI_CI_FILES
  as select from ztb_ci_files as CustomerInvoiceFiles
{
      @Search.defaultSearchElement: true
  key CustomerInvoiceFiles.billingdocument       as Billingdocument,
      CustomerInvoiceFiles.attachment            as Attachment,
      CustomerInvoiceFiles.mimetype              as Mimetype,
      CustomerInvoiceFiles.filename              as Filename,
      @Semantics.user.createdBy: true
      CustomerInvoiceFiles.created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      CustomerInvoiceFiles.created_at            as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      CustomerInvoiceFiles.local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      CustomerInvoiceFiles.local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      CustomerInvoiceFiles.last_changed_at       as LastChangedAt
}
