@EndUserText.label: 'Request from API Customer Invoice'
define root abstract entity ZA_CI_REQ
{
  key UUID                 : abap.char( 40 );
      mergepdf             : abap_boolean;
      _CustomerInvoiceList : composition [0..*] of za_ci_number;

}
