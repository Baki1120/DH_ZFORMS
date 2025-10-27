@AbapCatalog.sqlViewName: 'ZIMONTH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'First day and Last day of a month'
define view ZI_GET_MONTH_DAY
  with parameters
    p_year  : abap.char( 4 ),
    p_month : abap.char( 2 )
  as select from I_CalendarMonth as Month

{
  key Month.CalendarMonth,
      cast( concat( concat( $parameters.p_year, Month.CalendarMonth ), '01' ) as abap.dats ) as first_day,
      dats_add_days(
      dats_add_months(
      cast( concat( concat( $parameters.p_year, Month.CalendarMonth ), '01' ) as abap.dats ),
      1, 'FAIL'),
     -1, 'FAIL') as last_day
}
where
  Month.CalendarMonth = $parameters.p_month;
