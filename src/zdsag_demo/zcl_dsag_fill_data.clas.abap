CLASS zcl_dsag_fill_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DSAG_FILL_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA:
      lt_bill_doc  TYPE STANDARD TABLE OF zdsag_billdoc,
      lt_bill_item TYPE STANDARD TABLE OF zdsag_billitem,
      lt_receiver  TYPE STANDARD TABLE OF zdsag_receiver,
      lt_product   TYPE STANDARD TABLE OF zdsag_product.

    DELETE FROM zdsag_billdoc.
    DELETE FROM zdsag_billitem.
    DELETE FROM zdsag_product.
    DELETE FROM zdsag_receiver.
    DELETE FROM ztb_ci_log.

    APPEND VALUE zdsag_receiver(
      client          = 100
      id              = 1
      country         = 'USA'
      zip             = 'New York, NY 10023'
      street          = '123 Sesame Street'
      name            = 'Cookie Monster'
    ) TO lt_receiver.


    APPEND VALUE zdsag_billdoc(
      client          = 100
      created_at      = 20220523164722
      id              = 1
      payment_method  = 'Cash'
      receiver        = 1
    ) TO lt_bill_doc.

    APPEND VALUE zdsag_billitem(
      client          = 100
      billdoc         = 1
      id              = 1
      amount          = 10000
      product         = 1
    ) TO lt_bill_item.

    APPEND VALUE zdsag_billitem(
      client          = 100
      billdoc         = 1
      id              = 2
      amount          = 1
      product         = 2
    ) TO lt_bill_item.

    APPEND VALUE zdsag_product(
      client          = 100
      name            = 'Cookie'
      currency        = 'EUR'
      id              = 1
      price           = '5'
      vat             = 7
    ) TO lt_product.

    APPEND VALUE zdsag_product(
      client          = 100
      name            = 'Versandkosten'
      currency        = 'EUR'
      id              = 2
      price           = '100'
      vat             = 19
    ) TO lt_product.

    INSERT zdsag_billdoc  FROM TABLE @lt_bill_doc.
    INSERT zdsag_billitem FROM TABLE @lt_bill_item.
    INSERT zdsag_product  FROM TABLE @lt_product.
    INSERT zdsag_receiver FROM TABLE @lt_receiver.

  ENDMETHOD.
ENDCLASS.
