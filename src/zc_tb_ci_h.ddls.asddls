@Metadata.allowExtensions: true
@EndUserText.label: 'Customer Invoice Header'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_TB_CI_H
  provider contract transactional_query
  as projection on ZR_TB_CI_H
{
  key UuidH,
      InvNo,
      AwardTitle,
      AwardPeriod,
      PrincipalInvestigator,
      AwardNumber,
      InvDate,
      InvPer,
      ProjectNumber,
      Status,
      Url,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt

}
