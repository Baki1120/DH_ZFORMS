@EndUserText.label: 'Customer Invoice Number'
define abstract entity za_ci_number
{
  key InvoiceNumber           : abap.char(10);
      UUID                    : abap.char( 40 );
      _CustomerInvoiceRequest : association to parent ZA_CI_REQ on $projection.UUID = _CustomerInvoiceRequest.UUID;

}
