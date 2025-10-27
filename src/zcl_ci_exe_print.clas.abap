CLASS zcl_ci_exe_print DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.


    METHODS exe_print IMPORTING iv_xml_data   TYPE xstring
                                iv_xdp_layout TYPE xstring
                      EXPORTING iv_trace      TYPE string
                                iv_page       TYPE int4
                                iv_msg        TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CI_EXE_PRINT IMPLEMENTATION.


  METHOD exe_print.
    DATA lv_pdf TYPE xstring.
    CLEAR lv_pdf.

    TRY.
        cl_fp_ads_util=>render_4_pq(
          EXPORTING
            iv_xml_data     = iv_xml_data
            iv_xdp_layout   = iv_xdp_layout
            iv_locale       = 'en_US'
            iv_pq_name      = 'TEST_ADOBE'
            is_options      = VALUE #( trace_level = 4 ) "Use 0 in production environment
          IMPORTING
            ev_pages        = iv_page
            ev_trace_string = iv_trace
            ev_pdl          = lv_pdf ).

      CATCH cx_fp_ads_util INTO DATA(lo_ads_util).
        iv_msg = lo_ads_util->get_text( ).
    ENDTRY.

    IF NOT lv_pdf IS INITIAL.
      cl_print_queue_utils=>create_queue_item_by_data(
        iv_qname = 'TEST_ADOBE'
        iv_print_data = lv_pdf
        iv_name_of_main_doc = |INV_{ cl_abap_context_info=>get_system_date( ) }{ cl_abap_context_info=>get_system_time( ) }|
      ).
    ENDIF.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    DATA ev_pdf TYPE xstring.
    DATA ev_pages TYPE int4.
    DATA ev_trace_string TYPE string.

    TRY.
        "Initialize Template Store Client
*      data(lo_store) = new ZCL_FP_TMPL_STORE_CLIENT(
*        iv_name = 'restapi'
*        iv_service_instance_name = 'SAP_COM_0276'
*      ).


        "Initialize Template Store Client (using custom comm scenario)
        DATA(lo_store) = NEW zcl_fp_tmpl_store_client(
          iv_service_instance_name = 'ZADSTEMPLSTORE'
          iv_use_destination_service = abap_false
        ).



        out->write( 'Template Store Client initialized' ).
        "Initialize class with service definition
        DATA(lo_fdp_util) = cl_fp_fdp_services=>get_instance( 'ZDSAG_BILLING_SRV_DEF' ).
        out->write( 'Dataservice initialized' ).

        TRY.
            lo_store->get_schema_by_name( iv_form_name = 'DSAG_DEMO' ).
            out->write( 'Schema found in form' ).
          CATCH zcx_fp_tmpl_store_error INTO DATA(lo_tmpl_error).
            out->write( 'No schema in form found' ).
            IF lo_tmpl_error->mv_http_status_code = 404.
              "Upload service definition
              lo_store->set_schema(
                iv_form_name = 'DSAG_DEMO'
                is_data = VALUE #( note = '' schema_name = 'schema' xsd_schema = lo_fdp_util->get_xsd(  )  )
              ).
            ELSE.
              out->write( lo_tmpl_error->get_longtext(  ) ).
            ENDIF.
        ENDTRY.
        "Get initial select keys for service
        DATA(lt_keys)     = lo_fdp_util->get_keys( ).
        lt_keys[ name = 'ID' ]-value = '1'.

        DATA(lv_xml) = lo_fdp_util->read_to_xml( lt_keys ).

****************************************************************************************
        DATA lv_xml_string TYPE string.
        DATA lv_xml_01 TYPE xstring.

        lv_xml_string = |<?xml version="1.0"?>| &&
                        |<Form>| &&
                        |<ZI_DSAG_BILL_ORDER>| &&
                        |<ID>1</ID>| &&
                        |<RECEIVER_ID>1</RECEIVER_ID>| &&
                        |<CREATED_AT>2022-05-23T16:47:22</CREATED_AT>| &&
                        |<PAYMENT_METHOD>Cash</PAYMENT_METHOD>| &&
                        |<SUM_EXCL_VAT>50100.00</SUM_EXCL_VAT>| &&
                        |<SUM_VAT>53619.00</SUM_VAT>| &&
                        |<SUM_ALL>53619.00</SUM_ALL>| &&
                        |<CURRENCY></CURRENCY>| &&
                        |<_ITEMS>| &&
                        |<ZI_DSAG_BILL_ITEM>| &&
                        |<ID>1</ID>| &&
                        |<AMOUNT>10000</AMOUNT>| &&
                        |<BILL_ID>1</BILL_ID>| &&
                        |<PRODUCT_ID>1</PRODUCT_ID>| &&
                        |<PRICE_SUM>5.00</PRICE_SUM>| &&
                        |<_PRODUCT>| &&
                        |<ID>1</ID>| &&
                        |<NAME>Cookie</NAME>| &&
                        |<PRICE>5.00</PRICE>| &&
                        |<CURRENCY>EUR</CURRENCY>| &&
                        |<VAT>7.00</VAT>| &&
                        |<EAN>2914911266</EAN>| &&
                        |<PRICE_WITH_VAT>5</PRICE_WITH_VAT>| &&
                        |</_PRODUCT>| &&
                        |</ZI_DSAG_BILL_ITEM>| &&
*                        |<ZI_DSAG_BILL_ITEM>| &&
*                        |<ID>2</ID>| &&
*                        |<AMOUNT>1</AMOUNT>| &&
*                        |<BILL_ID>1</BILL_ID>| &&
*                        |<PRODUCT_ID>2</PRODUCT_ID>| &&
*                        |<PRICE_SUM>1</PRICE_SUM>| &&
*                        |<_PRODUCT>| &&
*                        |<ID>2</ID>| &&
*                        |<NAME>Versandkosten</NAME>| &&
*                        |<PRICE>100.00</PRICE>| &&
*                        |<CURRENCY>EUR</CURRENCY>| &&
*                        |<VAT>19.00</VAT>| &&
*                        |<EAN>8247831214</EAN>| &&
*                        |<PRICE_WITH_VAT>1.00</PRICE_WITH_VAT>| &&
*                        |</_PRODUCT>| &&
*                        |</ZI_DSAG_BILL_ITEM>| &&
                        |</_ITEMS>| &&
                        |<_RECEIVER>| &&
                        |<ID>1</ID>| &&
                        |<NAME>Cookie Monster</NAME>| &&
                        |<STREET>123 Sesame Street</STREET>| &&
                        |<ZIP>New York, NY 10023</ZIP>| &&
                        |<COUNTRY>USA</COUNTRY>| &&
                        |</_RECEIVER>| &&
                        |</ZI_DSAG_BILL_ORDER>| &&
                        |</Form>| .
****** Convert string xml to xstring
        lv_xml_01 = xco_cp=>string( iv_value = lv_xml_string )->as_xstring(
                                                              io_conversion = xco_cp_character=>code_page->utf_8 )->value.

****** Convert xstring xml to base64
        DATA(lv_pdf_02) = xco_cp=>xstring( lv_xml )->as_string(
                                                   io_conversion = xco_cp_binary=>text_encoding->base64 )->value.
****************************************************************************************

        out->write( 'Service data retrieved' ).

        DATA(ls_template) = lo_store->get_template_by_name(
          iv_get_binary     = abap_true
          iv_form_name      = 'DSAG_DEMO'
          iv_template_name  = 'TEMPLATE'
        ).
        out->write( 'Form Template retrieved' ).

        TRY.
*Render PDF
            cl_fp_ads_util=>render_pdf( EXPORTING iv_xml_data      = lv_xml_01 "lv_xml
                                                  iv_xdp_layout    = ls_template-xdp_template
                                                  iv_locale        = 'en_US'
                                        IMPORTING ev_pdf           = ev_pdf
                                                  ev_pages         = ev_pages
                                                  ev_trace_string  = ev_trace_string
                                                  ).
            out->write( 'Output was generated' ).
          CATCH cx_fp_ads_util INTO DATA(lx_fp_ads_util).
            out->write( lx_fp_ads_util->get_text( ) ).
        ENDTRY.

****** Convert xstring to base64
        DATA(lv_pdf_01) = xco_cp=>xstring( ev_pdf )->as_string(
                                                  io_conversion = xco_cp_binary=>text_encoding->base64 )->value.

        cl_fp_ads_util=>render_4_pq(
          EXPORTING
            iv_locale       = 'en_US'
            iv_pq_name      = 'TEST_ADOBE'
            iv_xml_data     = lv_xml_01 "lv_xml
            iv_xdp_layout   = ls_template-xdp_template
            is_options      = VALUE #(
              trace_level = 4 "Use 0 in production environment
            )
          IMPORTING
            ev_trace_string = DATA(lv_trace)
            ev_pdl          = DATA(lv_pdf)
        ).
        out->write( 'Output was generated' ).

        cl_print_queue_utils=>create_queue_item_by_data(
          iv_qname = 'TEST_ADOBE'
          iv_print_data = lv_pdf
          iv_name_of_main_doc = |DSAG_DEMO_{ cl_abap_context_info=>get_system_date( ) }{ cl_abap_context_info=>get_system_time( ) }|
        ).
        out->write( 'Output was sent to print queue' ).

      CATCH cx_fp_fdp_error zcx_fp_tmpl_store_error cx_fp_ads_util INTO DATA(lo_err).
        out->write( 'Exception occurred.' ).
    ENDTRY.
    out->write( 'Finished processing.' ).
  ENDMETHOD.
ENDCLASS.
