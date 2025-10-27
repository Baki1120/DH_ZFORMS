@EndUserText.label: 'Response of API Customer Invoice'
define root abstract entity ZA_CI_RES
{
  key UUID                    : abap.char( 40 );
      mergepdf                : abap_boolean;
      InvoiceNumber           : abap.char( 10 );
      Status                  : abap.char( 1 );
      Message                 : abap.char( 200 );
      _CustomerInvoiceMessage : composition [0..*] of ZA_CI_MSG;

}
