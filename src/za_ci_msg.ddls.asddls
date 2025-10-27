@EndUserText.label: 'Customer Invoice Detailed Message'
define abstract entity ZA_CI_MSG
{
  key InvoiceNumber            : abap.char( 10 );
      Status                   : abap.char( 1 );
      Message                  : abap.char( 200 );
      UUID                     : abap.char( 40 );
      _CustomerInvoiceResponse : association to parent ZA_CI_RES on $projection.UUID = _CustomerInvoiceResponse.UUID;

}
