@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Customer Invoice Header'
define root view entity ZR_TB_CI_H
  as select from     ztb_ci_h          as CustomerInvoiceHeader
    right outer join I_BillingDocument as BillingDocument on BillingDocument.BillingDocumentType = 'F2'

{
  key CustomerInvoiceHeader.uuid_h                 as UuidH,
      BillingDocument.BillingDocument              as InvNo,
      CustomerInvoiceHeader.award_title            as AwardTitle,
      CustomerInvoiceHeader.award_period           as AwardPeriod,
      CustomerInvoiceHeader.principal_investigator as PrincipalInvestigator,
      CustomerInvoiceHeader.award_number           as AwardNumber,
      CustomerInvoiceHeader.inv_date               as InvDate,
      CustomerInvoiceHeader.inv_per                as InvPer,
      CustomerInvoiceHeader.project_number         as ProjectNumber,
      CustomerInvoiceHeader.status                 as Status,
      CustomerInvoiceHeader.url                    as Url,
      @Semantics.user.createdBy: true
      CustomerInvoiceHeader.created_by             as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      CustomerInvoiceHeader.created_at             as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      CustomerInvoiceHeader.local_last_changed_by  as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      CustomerInvoiceHeader.local_last_changed_at  as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      CustomerInvoiceHeader.last_changed_at        as LastChangedAt

}
