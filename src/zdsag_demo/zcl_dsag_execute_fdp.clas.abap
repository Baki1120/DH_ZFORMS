CLASS zcl_dsag_execute_fdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DSAG_EXECUTE_FDP IMPLEMENTATION.


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
          iv_use_destination_service = abap_false
          iv_service_instance_name   = 'ZADSTEMPLSTORE'
          iv_service_id              = 'ZADSTEMPLSTORE_REST'
          iv_comm_system_id          = 'TEST_ADOBE'  ).



        out->write( 'Template Store Client initialized' ).
        "Initialize class with service definition
*        DATA(lo_fdp_util) = cl_fp_fdp_services=>get_instance( 'ZDSAG_BILLING_SRV_DEF' ).
*        out->write( 'Dataservice initialized' ).

        TRY.

            DATA(ls_schema) = lo_store->get_schema_by_name(
                                EXPORTING iv_form_name = 'CI_DEMO'
                                IMPORTING ev_msg       = ev_trace_string ).


            out->write( 'Schema found in form' ).
          CATCH zcx_fp_tmpl_store_error INTO DATA(lo_tmpl_error).
*            out->write( 'No schema in form found' ).
*            IF lo_tmpl_error->mv_http_status_code = 404.
*              "Upload service definition
*              lo_store->set_schema(
*                iv_form_name = 'DSAG_DEMO'
*                is_data = VALUE #( note = '' schema_name = 'schema' xsd_schema = lo_fdp_util->get_xsd(  )  )
*              ).
*            ELSE.
*              out->write( lo_tmpl_error->get_longtext(  ) ).
*            ENDIF.
        ENDTRY.
        "Get initial select keys for service
*        DATA(lt_keys)     = lo_fdp_util->get_keys( ).
*        lt_keys[ name = 'ID' ]-value = '1'.
*
*        DATA(lv_xml) = lo_fdp_util->read_to_xml( lt_keys ).

****************************************************************************************
        DATA lv_xml_string TYPE string.
        DATA lv_xml_01 TYPE xstring.

        lv_xml_string = |<?xml version="1.0"?>| &&
                        |<FORM>| &&
                        |<ZI_CUSTOMER_INVOICE>| &&
                        |<ZI_CI_HEADER>| &&
                        |<LOGO></LOGO>| &&
                        |<TEXT_2></TEXT_2>| &&
                        |<TEXT_3></TEXT_3>| &&
                        |<TEXT_4_A></TEXT_4_A>| &&
                        |<TEXT_4_B></TEXT_4_B>| &&
                        |<TEXT_4_C></TEXT_4_C>| &&
                        |<TEXT_5></TEXT_5>| &&
                        |<TEXT_6></TEXT_6>| &&
                        |<AWARD_TITLE>BIOTICS</AWARD_TITLE>| &&
                        |<AWARD_PERIOD>20241201</AWARD_PERIOD>| &&
                        |<PRINCIPAL_INVESTIGATOR>DUNG MY Dung</PRINCIPAL_INVESTIGATOR>| &&
                        |<AWARD_NUMBER>7008</AWARD_NUMBER>| &&
                        |<INV_DATE></INV_DATE>| &&
                        |<INV_PER></INV_PER>| &&
                        |<PROJECT_NUMBER>7008</PROJECT_NUMBER>| &&
                        |</ZI_CI_HEADER>| &&
                        |<_ITEMS>| &&
                        |<ZI_CI_ITEM>| &&
                        |<LINE>1</LINE>| &&
                        |<PRODUCT></PRODUCT>| &&
                        |<DESCRIPTION>Grantee Management Billing</DESCRIPTION>| &&
                        |<QUANTITY>1.00</QUANTITY>| &&
                        |<GROSS>0.00</GROSS>| &&
                        |<NET>29.00</NET>| &&
                        |<CURRENCY>USD</CURRENCY>| &&
                        |<MEINS>LE</MEINS>| &&
                        |<TEXT_1></TEXT_1>| &&
                        |<TEXT_2></TEXT_2>| &&
                        |<TEXT_3></TEXT_3>| &&
                        |</ZI_CI_ITEM>| &&
                        |<ZI_CI_ITEM>| &&
                        |<LINE>2</LINE>| &&
                        |<PRODUCT></PRODUCT>| &&
                        |<DESCRIPTION>Grantee Management Billing</DESCRIPTION>| &&
                        |<QUANTITY>1.00</QUANTITY>| &&
                        |<GROSS>0.00</GROSS>| &&
                        |<NET>1000.00</NET>| &&
                        |<CURRENCY>USD</CURRENCY>| &&
                        |<MEINS>LE</MEINS>| &&
                        |<TEXT_1></TEXT_1>| &&
                        |<TEXT_2></TEXT_2>| &&
                        |<TEXT_3></TEXT_3>| &&
                        |</ZI_CI_ITEM>| &&
                        |</_ITEMS>| &&
                        |<ZI_CI_FOOTER>| &&
                        |<TEXT_1></TEXT_1>| &&
                        |<INV_NO>0090000010</INV_NO>| &&
                        |<PROJECT_NUMBER>7008</PROJECT_NUMBER>| &&
                        |<BUDGET_CAT></BUDGET_CAT>| &&
                        |<TEXT_3></TEXT_3>| &&
                        |<TEXT_4></TEXT_4>| &&
                        |<TEXT_5></TEXT_5>| &&
                        |<TEXT_6></TEXT_6>| &&
                        |</ZI_CI_FOOTER>| &&
                        |</ZI_CUSTOMER_INVOICE>| &&
                        |</FORM>| .

*        lv_xml_string = |<?xml version="1.0"?>| &&
*                        |<Form>| &&
*                        |<ZI_DSAG_BILL_ORDER>| &&
*                        |<ID>1</ID>| &&
*                        |<RECEIVER_ID>1</RECEIVER_ID>| &&
*                        |<CREATED_AT>2022-05-23T16:47:22</CREATED_AT>| &&
*                        |<PAYMENT_METHOD>Cash</PAYMENT_METHOD>| &&
*                        |<SUM_EXCL_VAT>50100.00</SUM_EXCL_VAT>| &&
*                        |<SUM_VAT>53619.00</SUM_VAT>| &&
*                        |<SUM_ALL>53619.00</SUM_ALL>| &&
*                        |<CURRENCY></CURRENCY>| &&
*                        |<_ITEMS>| &&
*                        |<ZI_DSAG_BILL_ITEM>| &&
*                        |<ID>1</ID>| &&
*                        |<AMOUNT>10000</AMOUNT>| &&
*                        |<BILL_ID>1</BILL_ID>| &&
*                        |<PRODUCT_ID>1</PRODUCT_ID>| &&
*                        |<PRICE_SUM>5.00</PRICE_SUM>| &&
*                        |<_PRODUCT>| &&
*                        |<ID>1</ID>| &&
*                        |<NAME>Cookie</NAME>| &&
*                        |<PRICE>5.00</PRICE>| &&
*                        |<CURRENCY>EUR</CURRENCY>| &&
*                        |<VAT>7.00</VAT>| &&
*                        |<EAN>2914911266</EAN>| &&
*                        |<PRICE_WITH_VAT>5</PRICE_WITH_VAT>| &&
*                        |</_PRODUCT>| &&
*                        |</ZI_DSAG_BILL_ITEM>| &&
**                        |<ZI_DSAG_BILL_ITEM>| &&
**                        |<ID>2</ID>| &&
**                        |<AMOUNT>1</AMOUNT>| &&
**                        |<BILL_ID>1</BILL_ID>| &&
**                        |<PRODUCT_ID>2</PRODUCT_ID>| &&
**                        |<PRICE_SUM>1</PRICE_SUM>| &&
**                        |<_PRODUCT>| &&
**                        |<ID>2</ID>| &&
**                        |<NAME>Versandkosten</NAME>| &&
**                        |<PRICE>100.00</PRICE>| &&
**                        |<CURRENCY>EUR</CURRENCY>| &&
**                        |<VAT>19.00</VAT>| &&
**                        |<EAN>8247831214</EAN>| &&
**                        |<PRICE_WITH_VAT>1.00</PRICE_WITH_VAT>| &&
**                        |</_PRODUCT>| &&
**                        |</ZI_DSAG_BILL_ITEM>| &&
*                        |</_ITEMS>| &&
*                        |<_RECEIVER>| &&
*                        |<ID>1</ID>| &&
*                        |<NAME>Cookie Monster</NAME>| &&
*                        |<STREET>123 Sesame Street</STREET>| &&
*                        |<ZIP>New York, NY 10023</ZIP>| &&
*                        |<COUNTRY>USA</COUNTRY>| &&
*                        |</_RECEIVER>| &&
*                        |</ZI_DSAG_BILL_ORDER>| &&
*                        |</Form>| .
****** Convert string xml to xstring
        lv_xml_01 = xco_cp=>string( iv_value = lv_xml_string )->as_xstring(
                                                              io_conversion = xco_cp_character=>code_page->utf_8 )->value.

****** Convert xstring xml to base64
*        DATA(lv_pdf_02) = xco_cp=>xstring( lv_xml )->as_string(
*                                                   io_conversion = xco_cp_binary=>text_encoding->base64 )->value.

****************************************************************************************

        out->write( 'Service data retrieved' ).

        DATA(ls_template) = lo_store->get_template_by_name(
          iv_get_binary     = abap_true
          iv_form_name      = 'CI_DEMO'
          iv_template_name  = 'CI_TEMPLATE'
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
            RETURN.
        ENDTRY.

        " Create an instance of the PDF merger class
        DATA(l_merger) = cl_rspo_pdf_merger=>create_instance( ).

        " Add the data of the first PDF document to the list of files which shall be merged
        l_merger->add_document( ev_pdf ).
        " Add the data of the second PDF document
        l_merger->add_document( ev_pdf ).

        TRY.
            " Merge both documents and receive the result
            DATA(l_merged_PDF) = l_merger->merge_documents( ).
          CATCH cx_rspo_pdf_merger INTO DATA(l_exception).
            " Add a useful error handling here
            out->write( l_exception->get_longtext( ) ).
            RETURN.
        ENDTRY.

****** Convert xstring to base64
        DATA(lv_pdf_01) = xco_cp=>xstring( l_merged_PDF )->as_string(
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
