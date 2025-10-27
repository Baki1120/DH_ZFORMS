@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Invoice Log'
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'UuidLog', 'BillingDocument' ]
@Search.searchable: true
define view entity zi_ci_log
  as select from ztb_ci_log as CustomerInvoiceLog
  association        to parent ZI_CI_H as _CustomerInvoiceHeader on  $projection.BillingDocument = _CustomerInvoiceHeader.BillingDocument
  association [0..1] to ZFORM_STA_VH   as _FormStatus            on  $projection.Status   = _FormStatus.Status
                                                                 and _FormStatus.language = $session.system_language
{
         @Search.defaultSearchElement: true
  key    CustomerInvoiceLog.uuid_l                as UuidLog,
         @Search.defaultSearchElement: true
         CustomerInvoiceLog.inv_no                as BillingDocument,
         @ObjectModel.text.element: [ 'FormStatus' ]
         CustomerInvoiceLog.status                as Status,
         url                                      as Url,
         case CustomerInvoiceLog.status
           when ' ' then 2
           when 'S' then 3
           when 'U' then 3
           when 'A' then 3
           when 'R' then 1
           when 'F' then 1
           else 0 end                             as Criticality,
         CustomerInvoiceLog.message               as Message,
         @Semantics.largeObject: { mimeType: 'Mimetype',
                                   fileName: 'FileName',
                                   contentDispositionPreference: #INLINE }
         CustomerInvoiceLog.attachment            as Attachment,
         @Semantics.mimeType: true
         @UI.hidden: true
         CustomerInvoiceLog.mimetype              as Mimetype,
         @Semantics.text: true
         CustomerInvoiceLog.filename              as FileName,
         CustomerInvoiceLog.refid                 as ReferenceUUID,
         CustomerInvoiceLog.bgid                  as BackgroundUUID,
         @Semantics.text: true
         @UI.hidden: true
         _FormStatus.FormStatus                   as FormStatus,
         @Semantics.user.createdBy: true
         CustomerInvoiceLog.created_by            as CreatedBy,
         @Semantics.systemDateTime.createdAt: true
         CustomerInvoiceLog.created_at            as CreatedAt,
         @Semantics.user.localInstanceLastChangedBy: true
         CustomerInvoiceLog.local_last_changed_by as LocalLastChangedBy,
         @Semantics.systemDateTime.localInstanceLastChangedAt: true
         CustomerInvoiceLog.local_last_changed_at as LocalLastChangedAt,
         @Semantics.systemDateTime.lastChangedAt: true
         CustomerInvoiceLog.last_changed_at       as LastChangedAt,
         _CustomerInvoiceHeader,
         _FormStatus
}
