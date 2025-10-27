CLASS lhc_customerinvoiceheader DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS print FOR MODIFY
      IMPORTING keys FOR ACTION CustomerInvoiceHeader~print RESULT result.

ENDCLASS.

CLASS lhc_customerinvoiceheader IMPLEMENTATION.

  METHOD print.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
