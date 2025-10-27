CLASS zcl_get_billing DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-DATA go_instance TYPE REF TO zcl_get_billing.

    CLASS-METHODS get_instance RETURNING VALUE(result) TYPE REF TO zcl_get_billing.

    TYPES: BEGIN OF ty_temp_key,
             cid      TYPE abp_behv_cid,
             pid      TYPE abp_behv_pid,
             uuid_h   TYPE uuid,
             uuid_upl TYPE uuid,
             EndUser  TYPE syuname,
             Cnt      TYPE int4,
           END OF ty_temp_key,
           tt_temp_key TYPE STANDARD TABLE OF ty_temp_key WITH DEFAULT KEY.
    TYPES: BEGIN OF ty_final_key,
             uuid_h   TYPE uuid,
             uuid_upl TYPE uuid,
             EndUser  TYPE syuname,
             Cnt      TYPE int4,
             cid      TYPE abp_behv_cid,
             bukrs    TYPE bukrs,
             belnr    TYPE belnr_d,
             gjahr    TYPE gjahr,
           END OF ty_final_key.
    TYPES: BEGIN OF ty_temp_data,
             BillingDocument    TYPE zi_ci_h-BillingDocument,
             AccountingDocument TYPE zi_ci_h-AccountingDocument,
             CompanyCode        TYPE zi_ci_h-CompanyCode,
             FiscalYear         TYPE zi_ci_h-FiscalYear,
             BillingStatus      TYPE zi_ci_h-OverallBillingStatus,
             BillingDate        TYPE zi_ci_h-BillingDocumentDate,
             CustomerName       TYPE zi_ci_h-CustomerName,
             SalesDocument      TYPE I_BillingDocumentItem-SalesDocument,
             ReferenceUUID      TYPE zi_ci_log-ReferenceUUID,
             GrantData          TYPE zst_data_grant,
             BillingItems       TYPE ztt_bill_item,
           END OF ty_temp_data.
    TYPES tt_final_key TYPE STANDARD TABLE OF ty_final_key WITH DEFAULT KEY.
    TYPES tt_header    TYPE STANDARD TABLE OF ztb_je_h WITH DEFAULT KEY.
    TYPES tt_temp_data TYPE STANDARD TABLE OF ty_temp_data WITH DEFAULT KEY.

    DATA temp_key  TYPE tt_temp_key.
    DATA temp_data TYPE ty_temp_data.
    DATA real_data TYPE STANDARD TABLE OF ty_temp_data.
    DATA Chk_Print TYPE abap_boolean.
    DATA Chk_bg    TYPE abap_boolean.
    DATA Chk_merge TYPE za_mer_pdf-MergeFile.

    TYPES lt_header TYPE TABLE FOR READ RESULT zr_upl_je\\journalentryheader.

    METHODS set_temp_key          IMPORTING it_temp_key    TYPE tt_temp_key.
    METHODS set_return_data       IMPORTING is_data        TYPE ty_temp_data.
    METHODS set_return_check      IMPORTING is_check       TYPE abap_boolean.
    METHODS set_return_chk_bg     IMPORTING is_bg          TYPE abap_boolean.
    METHODS set_return_merge      IMPORTING is_merge       TYPE za_mer_pdf-MergeFile.

    METHODS convert_temp_to_final RETURNING VALUE(result)  TYPE tt_final_key.
    METHODS convert_temp_to_data  RETURNING VALUE(result)  TYPE tt_temp_data.
    METHODS check_print           RETURNING VALUE(r_check) TYPE abap_boolean.
    METHODS check_bg              RETURNING VALUE(r_check) TYPE abap_boolean.
    METHODS check_merge           RETURNING VALUE(r_check) TYPE za_mer_pdf-MergeFile.

    METHODS additional_save
      IMPORTING is_api     TYPE abap_boolean                  OPTIONAL
                bg_uid     TYPE uuid                          OPTIONAL
                tt_billing TYPE zcl_get_billing=>tt_temp_data OPTIONAL
      EXPORTING ev_inv     TYPE I_BillingDocument-BillingDocument
                ev_msg     TYPE string
                ev_status  TYPE c.

    METHODS merge_pdf
      IMPORTING is_api     TYPE abap_boolean                  OPTIONAL
                bg_uid     TYPE uuid                          OPTIONAL
                is_merge   TYPE za_mer_pdf-MergeFile          OPTIONAL
                tt_billing TYPE zcl_get_billing=>tt_temp_data OPTIONAL
      EXPORTING ev_inv     TYPE I_BillingDocument-BillingDocument
                ev_msg     TYPE string
                ev_status  TYPE c.

    METHODS clean_up.

  PRIVATE SECTION.
*    CONSTANTS lc_service_id    TYPE string                     VALUE 'ZADSTEMPLSTORE_REST'.
*    CONSTANTS lc_comm_system   TYPE string                     VALUE 'TEST_ADOBE'.
*    CONSTANTS lc_comm_scenario TYPE string                     VALUE 'ZADSTEMPLSTORE'.
*    CONSTANTS lc_form_name     TYPE string                     VALUE 'CI_01'.
*    CONSTANTS lc_template_name TYPE string                     VALUE 'CI_01'.
*    CONSTANTS lc_queue_name    TYPE cl_fp_ads_util=>ty_pq_name VALUE 'TEST_ADOBE'.

    CONSTANTS lc_service_id    TYPE string                     VALUE 'ZBTP_ADOBE_REST'.
    CONSTANTS lc_comm_system   TYPE string                     VALUE 'BTP_ADOBE'.
    CONSTANTS lc_comm_scenario TYPE string                     VALUE 'ZBTP_ADOBE'.
    CONSTANTS lc_form_name     TYPE string                     VALUE 'CI_01'.
    CONSTANTS lc_template_name TYPE string                     VALUE 'CI_01'.
    CONSTANTS lc_queue_name    TYPE cl_fp_ads_util=>ty_pq_name VALUE 'TEST_ADOBE'.

    TYPES lr_sponsor TYPE RANGE OF I_SponsoredClassCore-SponsoredClass.

    METHODS exc_sponsor RETURNING VALUE(return) TYPE lr_sponsor.

ENDCLASS.



CLASS ZCL_GET_BILLING IMPLEMENTATION.


  METHOD additional_save.
    DATA lv_msg         TYPE string.
    DATA lv_xml_xstring TYPE xstring.
    DATA lv_xml_string  TYPE string.
    DATA lv_xml_header  TYPE string.
    DATA lv_xml_items   TYPE string.
    DATA lv_xml_footer  TYPE string.
    DATA lv_filename    TYPE ztb_ci_log-filename.
    DATA lv_total1      TYPE zst_bill_item-net.
    DATA lv_total2      TYPE zst_bill_item-net.
    DATA lv_total3      TYPE zst_bill_item-net.
    DATA lv_total4      TYPE zst_bill_item-net.
    DATA lv_total5      TYPE zst_bill_item-net.
    DATA lv_total6      TYPE zst_bill_item-net.
    DATA lt_log         TYPE TABLE OF ztb_ci_log.

    DATA(lt_billing) = COND #( WHEN tt_billing IS INITIAL
                               THEN convert_temp_to_data( )
                               ELSE tt_billing ).

    IF lt_billing IS INITIAL.
      RETURN.
    ELSE.
      CLEAR: lv_msg,
             lt_log.

      SELECT *
        FROM ztb_ci_log
        WITH
        PRIVILEGED ACCESS
        FOR ALL ENTRIES IN @lt_billing
        WHERE inv_no = @lt_billing-BillingDocument
        INTO TABLE @DATA(lt_del_log).
    ENDIF.

    TRY.
        GET TIME STAMP FIELD DATA(ts).

        DATA(lo_store) = NEW zcl_fp_tmpl_store_client( iv_service_instance_name   = lc_comm_scenario " Scenario ID: ZADSTEMPLSTORE
                                                       iv_use_destination_service = abap_false
                                                       iv_service_id              = lc_service_id
                                                       iv_comm_system_id          = lc_comm_system ).

        TRY.

            lo_store->get_schema_by_name( EXPORTING iv_form_name = lc_form_name
                                          IMPORTING ev_msg       = lv_msg  ).

            IF     lo_store IS NOT INITIAL
               AND lv_msg   IS INITIAL.
              DATA(ls_template) = lo_store->get_template_by_name( iv_get_binary    = abap_true
                                                                  iv_form_name     = lc_form_name
                                                                  iv_template_name = lc_template_name ).
              "'CI_TEMPLATE' ).
            ENDIF.

          CATCH zcx_fp_tmpl_store_error.
            lv_msg = 'No schema in form found'.
        ENDTRY.

        IF lv_msg IS NOT INITIAL.
          IF is_api = 'X'.
            ev_msg = lv_msg.
            ev_status = 'E'.
            RETURN.
          ELSE.
            LOOP AT lt_billing ASSIGNING FIELD-SYMBOL(<f_billing>).
              APPEND VALUE #(
                  uuid_l                = xco_cp=>uuid( )->value
                  inv_no                = <f_billing>-billingdocument
                  refid                 = COND #( WHEN bg_uid IS INITIAL
                                                  THEN <f_billing>-referenceuuid
                                                  ELSE '' )
                  status                = 'F'
                  message               = lv_msg
                  bgid                  = bg_uid
                  url                   = |/ui#BillingDocument-manage&/object/display/{ <f_billing>-billingdocument }|
                  created_by            = xco_cp=>sy->user( )->name
                  created_at            = ts
                  local_last_changed_by = xco_cp=>sy->user( )->name
                  local_last_changed_at = ts
                  last_changed_at       = ts  ) TO lt_log.
            ENDLOOP.
          ENDIF.
        ELSE.
          " ---------------------------------------------------------------------------------------
          DATA lv_grant               TYPE gm_grant_nbr.
          DATA lv_grantvalidityperiod TYPE c LENGTH 50.

          LOOP AT lt_billing ASSIGNING <f_billing>.

            GET TIME STAMP FIELD ts.
            lv_grant = |{ <f_billing>-grantdata-grantid ALIGN = RIGHT WIDTH = 20 PAD = '0' }|.

            SELECT SINGLE first_day, last_day
              FROM zi_get_month_day( p_year  = @<f_billing>-billingdate+0(4),
                                     p_month = @<f_billing>-billingdate+4(2) )
              INTO @DATA(ls_month).

            TRY.
                lv_grantvalidityperiod =
                      |{ <f_billing>-grantdata-grantvalidityperiod+4(2) }/{ <f_billing>-grantdata-grantvalidityperiod+6(2) }/{ <f_billing>-grantdata-grantvalidityperiod+0(4) }| &&
                      | to { <f_billing>-grantdata-grantvalidityperiod+13(2) }/{ <f_billing>-grantdata-grantvalidityperiod+15(2) }/{ <f_billing>-grantdata-grantvalidityperiod+9(4) }|.
              CATCH cx_sy_range_out_of_bounds.
                lv_grantvalidityperiod = ''.
            ENDTRY.

            lv_xml_header = |<?xml version="1.0"?>| &&
                            |<FORM>| &&
                            |<ZI_CUSTOMER_INVOICE>| &&
                            |<ZI_CI_HEADER>| &&
                            |<LOGO></LOGO>| &&
                            |<TEXT_2>{ <f_billing>-salesdocument }</TEXT_2>| &&
                            |<TEXT_3>{ <f_billing>-companycode }</TEXT_3>| &&
                            |<TEXT_4_A>{ <f_billing>-customername }</TEXT_4_A>| &&
                            |<TEXT_4_B>{ <f_billing>-grantdata-yy1_fiscaladministrat_grt }</TEXT_4_B>| &&
                            |<TEXT_4_C></TEXT_4_C>| &&
                            |<TEXT_5></TEXT_5>| &&
                            |<TEXT_6></TEXT_6>| &&
                            |<AWARD_TITLE>{ <f_billing>-grantdata-grantdescription }</AWARD_TITLE>| &&
                            |<AWARD_PERIOD>{ lv_grantvalidityperiod }</AWARD_PERIOD>| &&
                            |<PRINCIPAL_INVESTIGATOR>{ <f_billing>-grantdata-yy1_principalinvestig_grtt }</PRINCIPAL_INVESTIGATOR>| &&
                            |<AWARD_NUMBER>{ <f_billing>-grantdata-yy1_agreementnumber_grt }</AWARD_NUMBER>| &&
                            |<INV_DATE>{ <f_billing>-billingdate }</INV_DATE>| &&
                            |<INV_PER>{ ls_month-first_day+4(2) }/{ ls_month-first_day+6(2) }/{ ls_month-first_day+0(4) } to { ls_month-last_day+4(2) }/{ ls_month-last_day+6(2) }/{ ls_month-last_day+0(4) }</INV_PER>| &&
                            |<PROJECT_NUMBER>{ <f_billing>-grantdata-grantexternalreference }</PROJECT_NUMBER>| &&
                            |</ZI_CI_HEADER>| &&
                            |<_ITEMS>|.

            " Current Expenditure
            SELECT a~GrantID,
                   a~SponsoredClass,
                   SUM( a~AmountInTransactionCurrency ) AS CurrentExpenditure

              FROM I_ActualPlanJournalEntryItem WITH
              PRIVILEGED ACCESS AS a

               INNER JOIN @<f_billing>-grantdata-SponsoredClass AS b
               ON  lpad( b~GrantID, 20, '0' ) = lpad( a~GrantID, 20 , '0' )
               AND b~SponsoredClass           = a~SponsoredClass

              WHERE a~PostingDate  >= @ls_month-first_day
                AND a~PostingDate  <= @ls_month-last_day
                AND a~SourceLedger  = '0L'
                AND a~Ledger        = '0L'
                AND a~GrantID       = @lv_grant
              GROUP BY a~GrantID,
                       a~SponsoredClass
              INTO TABLE @DATA(CurrentExpenditure).

            SELECT a~GrantID,
                   a~SponsoredClass,
                   a~AmountInTransactionCurrency

              FROM I_ActualPlanJournalEntryItem WITH
              PRIVILEGED ACCESS AS a

               INNER JOIN @<f_billing>-grantdata-SponsoredClass AS b
               ON  lpad( b~GrantID, 20, '0' ) = lpad( a~GrantID, 20 , '0' )
               AND b~SponsoredClass           = a~SponsoredClass

              WHERE a~PostingDate     < @ls_month-first_day
                AND a~SourceLedger    = '0L'
                AND a~Ledger          = '0L'
                AND a~GrantID         = @lv_grant
                AND a~SponsoredClass IS NOT INITIAL
              ORDER BY a~PostingDate DESCENDING
              INTO TABLE @DATA(CurrentExpenditureRemain).

            LOOP AT CurrentExpenditureRemain ASSIGNING FIELD-SYMBOL(<f_remain>).
              IF <f_remain>-SponsoredClass = 'SBILL'.
                EXIT.
              ENDIF.
              LOOP AT CurrentExpenditure ASSIGNING FIELD-SYMBOL(<CurrentExpenditure>)
                   WHERE GrantID = <f_remain>-GrantID AND SponsoredClass = <f_remain>-SponsoredClass.
                <CurrentExpenditure>-currentexpenditure += <f_remain>-AmountInTransactionCurrency.
              ENDLOOP.
              IF sy-subrc <> 0.
                APPEND VALUE #( GrantID            = <f_remain>-GrantID
                                SponsoredClass     = <f_remain>-SponsoredClass
                                CurrentExpenditure = <f_remain>-AmountInTransactionCurrency  ) TO CurrentExpenditure.
              ENDIF.
            ENDLOOP.

            SORT CurrentExpenditure BY GrantID
                                       SponsoredClass.

            " Cumulative Expenditure
            SELECT a~GrantID,
                   a~SponsoredClass,
                   SUM( a~AmountInTransactionCurrency ) AS CumulativeExpenditure

              FROM I_ActualPlanJournalEntryItem WITH
              PRIVILEGED ACCESS AS a

               INNER JOIN @<f_billing>-grantdata-SponsoredClass AS b
               ON  lpad( b~GrantID, 20, '0' ) = lpad( a~GrantID, 20 , '0' )
               AND b~SponsoredClass           = a~SponsoredClass

              WHERE a~PostingDate  <= @<f_billing>-billingdate
                AND a~SourceLedger  = '0L'
                AND a~Ledger        = '0L'
                AND a~GrantID       = @lv_grant
              GROUP BY a~GrantID,
                       a~SponsoredClass
              INTO TABLE @DATA(CumulativeExpenditure).

            IF sy-subrc = 0.
              SORT CumulativeExpenditure BY GrantID
                                            SponsoredClass.
            ENDIF.

            DATA(lr_sponsor) = exc_sponsor( ).

            LOOP AT <f_billing>-grantdata-sponsoredclass ASSIGNING FIELD-SYMBOL(<f_sponsoredclass>)
                 WHERE SponsoredClass NOT IN lr_sponsor.

              IF <f_sponsoredclass>-sponsoredclassisbillable = 'X'.
                READ TABLE CurrentExpenditure
                     ASSIGNING FIELD-SYMBOL(<f_CurrentExpenditure>)
                     WITH KEY GrantID        = lv_grant
                              SponsoredClass = <f_sponsoredclass>-sponsoredclass
                     BINARY SEARCH.

                IF sy-subrc = 0.
                  <f_sponsoredclass>-creditamountintranscrcy = <f_CurrentExpenditure>-currentexpenditure.
                ENDIF.

                READ TABLE CumulativeExpenditure
                     ASSIGNING FIELD-SYMBOL(<f_CumulativeExpenditure>)
                     WITH KEY GrantID        = lv_grant
                              SponsoredClass = <f_sponsoredclass>-sponsoredclass
                     BINARY SEARCH.

                IF sy-subrc = 0.
                  <f_sponsoredclass>-debitamountintranscrcy = <f_CumulativeExpenditure>-cumulativeexpenditure.
                ENDIF.
              ENDIF.

              IF     <f_sponsoredclass>-creditamountintranscrcy = 0
                 AND <f_sponsoredclass>-debitamountintranscrcy  = 0.
                CONTINUE.
              ENDIF.

              lv_xml_items = |<ZI_CI_ITEM>| &&
                             |<BUDGETCATEGORY>{ <f_sponsoredclass>-sponsoreddescription }</BUDGETCATEGORY>| &&
                             |<CURRENTEXP>{ <f_sponsoredclass>-creditamountintranscrcy }</CURRENTEXP>| &&
                             |<CUMULATIVEEXP>{ <f_sponsoredclass>-debitamountintranscrcy }</CUMULATIVEEXP>| &&
                             |<LINE></LINE>| &&
                             |<PRODUCT></PRODUCT>| &&
                             |<DESCRIPTION></DESCRIPTION>| &&
                             |<QUANTITY></QUANTITY>| &&
                             |<GROSS></GROSS>| &&
                             |<NET></NET>| &&
                             |<CURRENCY>{ <f_sponsoredclass>-transactioncurrency }</CURRENCY>| &&
                             |<MEINS></MEINS>| &&
                             |<TEXT_1></TEXT_1>| &&
                             |<TEXT_2></TEXT_2>| &&
                             |<TEXT_3></TEXT_3>| &&
                             |</ZI_CI_ITEM>{ lv_xml_items }|.

              lv_total1 += <f_sponsoredclass>-creditamountintranscrcy.
              lv_total2 += <f_sponsoredclass>-debitamountintranscrcy.

            ENDLOOP.

            IF line_exists( CurrentExpenditure[ SponsoredClass = 'J' ] ).
              lv_total3 = CurrentExpenditure[ SponsoredClass = 'J' ]-currentexpenditure.
            ENDIF.

            IF line_exists( CumulativeExpenditure[ SponsoredClass = 'J' ] ).
              lv_total4 = CumulativeExpenditure[ SponsoredClass = 'J' ]-cumulativeexpenditure.
            ENDIF.

            lv_total5 = lv_total1 + lv_total3.
            lv_total6 = lv_total2 + lv_total4.
            " lv_total4 = lv_total4 + lv_total3.

            lv_xml_footer = |</_ITEMS>| &&
                            |<ZI_CI_FOOTER>| &&
                            |<TEXT_1></TEXT_1>| &&
                            |<INV_NO>{ <f_billing>-billingdocument }</INV_NO>| &&
                            |<PROJECT_NUMBER>{ <f_billing>-grantdata-grantexternalreference }</PROJECT_NUMBER>| &&
                            |<BUDGET_CAT>"AA"</BUDGET_CAT>| &&
                            |<TEXT_3>{ <f_billing>-grantdata-gteemindirectcostrateinpercent }</TEXT_3>| &&
                            |<TEXT_4></TEXT_4>| &&
                            |<TEXT_5></TEXT_5>| &&
                            |<TEXT_6></TEXT_6>| &&
                            |<TOTAL_1>{ lv_total1 }</TOTAL_1>| &&
                            |<TOTAL_2>{ lv_total2 }</TOTAL_2>| &&
                            |<TOTAL_3>{ lv_total3 }</TOTAL_3>| &&
                            |<TOTAL_4>{ lv_total4 }</TOTAL_4>| &&
                            |<TOTAL_5>{ lv_total5 }</TOTAL_5>| &&
                            |<TOTAL_6>{ lv_total6 }</TOTAL_6>| &&
                            |</ZI_CI_FOOTER>| &&
                            |</ZI_CUSTOMER_INVOICE>| &&
                            |</FORM>|.

            lv_xml_string = lv_xml_header &&
                            lv_xml_items  &&
                            lv_xml_footer.

            lv_xml_xstring = xco_cp=>string( iv_value = lv_xml_string )->as_xstring(
                io_conversion = xco_cp_character=>code_page->utf_8 )->value.

            TRY.
                cl_fp_ads_util=>render_4_pq( EXPORTING iv_locale       = 'en_US'
                                                       iv_pq_name      = lc_queue_name
                                                       iv_xml_data     = lv_xml_xstring
                                                       iv_xdp_layout   = ls_template-xdp_template
                                                       is_options      = VALUE #( trace_level = 4  )
                                             IMPORTING
                                             " TODO: variable is assigned but never used (ABAP cleaner)
                                                       ev_trace_string = DATA(lv_trace)
                                                       ev_pdl          = DATA(lv_pdf)
                                                       ev_pages        = DATA(lv_page) ).

                IF is_api IS INITIAL.
                  " Get File name
                  lv_filename = |{ <f_billing>-billingdocument }_{ cl_abap_context_info=>get_system_date( ) }| &&
                                |{ cl_abap_context_info=>get_system_time( ) }|.
                  CONDENSE lv_filename NO-GAPS.

                  cl_print_queue_utils=>create_queue_item_by_data(
                    EXPORTING iv_qname            = lc_queue_name
                              iv_print_data       = lv_pdf
                              iv_name_of_main_doc = lv_filename
                              iv_itemid           = cl_print_queue_utils=>create_queue_itemid( )
                              iv_pages            = lv_page
                    IMPORTING ev_err_msg          = lv_msg ).
                ENDIF.

              CATCH cx_fp_ads_util INTO DATA(lo_util).
                lv_msg = lo_util->get_longtext( ).
            ENDTRY.

            IF lv_msg IS NOT INITIAL.
              ev_msg = lv_msg.
              ev_status = 'E'.
              APPEND VALUE #(
                  uuid_l                = xco_cp=>uuid( )->value
                  inv_no                = <f_billing>-billingdocument
                  refid                 = COND #( WHEN bg_uid IS INITIAL
                                                  THEN <f_billing>-referenceuuid
                                                  ELSE '' )
                  status                = 'F'
                  message               = lv_msg
                  bgid                  = bg_uid
                  url                   = |/ui#BillingDocument-manage&/object/display/{ <f_billing>-billingdocument }|
                  created_by            = xco_cp=>sy->user( )->name
                  created_at            = ts
                  local_last_changed_by = xco_cp=>sy->user( )->name
                  local_last_changed_at = ts
                  last_changed_at       = ts  ) TO lt_log.
            ELSE.
              ev_msg = 'Printed successfully'.
              ev_status = 'S'.
              APPEND VALUE #(
                  uuid_l                = xco_cp=>uuid( )->value
                  inv_no                = <f_billing>-billingdocument
                  refid                 = COND #( WHEN bg_uid IS INITIAL
                                                  THEN <f_billing>-referenceuuid
                                                  ELSE '' )
                  status                = 'S'
                  message               = 'Printed successfully'
                  bgid                  = bg_uid
                  url                   = |/ui#BillingDocument-manage&/object/display/{ <f_billing>-billingdocument }|
                  filename              = |{ lv_filename }.pdf|
                  attachment            = lv_pdf
                  mimetype              = 'application/pdf'
                  created_by            = xco_cp=>sy->user( )->name
                  created_at            = ts
                  local_last_changed_by = xco_cp=>sy->user( )->name
                  local_last_changed_at = ts
                  last_changed_at       = ts  ) TO lt_log.
            ENDIF.

            IF is_api = 'X' AND ev_status = 'E'.
              ev_inv = <f_billing>-billingdocument.
              EXIT.
            ENDIF.

            CLEAR: lv_xml_header,
                   lv_xml_items,
                   lv_xml_footer,
                   lv_xml_string,
                   lv_xml_xstring,
                   currentexpenditure,
                   cumulativeexpenditure,
                   lv_filename,
                   lv_total1,
                   lv_total2,
                   lv_total3,
                   lv_total4,
                   lv_total5,
                   lv_total6,
                   lv_pdf,
                   lv_msg,
                   lv_trace,
                   lv_page.

          ENDLOOP.
        ENDIF.

      CATCH zcx_fp_tmpl_store_error INTO DATA(lo_error).
        lv_msg = lo_error->get_text( ).
        ev_msg = lv_msg.
        ev_status = 'E'.
        LOOP AT lt_billing ASSIGNING <f_billing>.
          APPEND VALUE #(
              uuid_l                = xco_cp=>uuid( )->value
              inv_no                = <f_billing>-billingdocument
              refid                 = COND #( WHEN bg_uid IS INITIAL
                                              THEN <f_billing>-referenceuuid
                                              ELSE '' )
              status                = 'F'
              message               = lv_msg
              bgid                  = bg_uid
              url                   = |/ui#BillingDocument-manage&/object/display/{ <f_billing>-billingdocument }|
              created_by            = xco_cp=>sy->user( )->name
              created_at            = ts
              local_last_changed_by = xco_cp=>sy->user( )->name
              local_last_changed_at = ts
              last_changed_at       = ts  ) TO lt_log.
        ENDLOOP.
    ENDTRY.

    DELETE ztb_ci_log FROM TABLE @lt_del_log.
    INSERT ztb_ci_log FROM TABLE @lt_log.
  ENDMETHOD.


  METHOD check_bg.
    r_check = chk_bg.
  ENDMETHOD.


  METHOD check_merge.
    r_check = chk_merge.
  ENDMETHOD.


  METHOD check_print.
    r_check = chk_print.
  ENDMETHOD.


  METHOD clean_up.
    CLEAR: temp_key,
           temp_data,
           chk_print,
           chk_merge,
           chk_bg,
           real_data.
  ENDMETHOD.


  METHOD convert_temp_to_data.
    IF real_data IS INITIAL.
      RETURN.
    ELSE.
      MOVE-CORRESPONDING real_data TO result KEEPING TARGET LINES.
    ENDIF.
  ENDMETHOD.


  METHOD convert_temp_to_final.
  ENDMETHOD.


  METHOD get_instance.
    IF go_instance IS NOT BOUND.
      go_instance = NEW #( ).
    ENDIF.
    result = go_instance.
  ENDMETHOD.


  METHOD merge_pdf.
    DATA lv_msg         TYPE string.
    DATA lv_xml_xstring TYPE xstring.
    DATA lv_xml_string  TYPE string.
    DATA lv_xml_header  TYPE string.
    DATA lv_xml_items   TYPE string.
    DATA lv_xml_footer  TYPE string.
    DATA lv_page        TYPE int4.
    DATA lv_filename    TYPE ztb_ci_log-filename.
    DATA lv_total1      TYPE zst_bill_item-net.
    DATA lv_total2      TYPE zst_bill_item-net.
    DATA lv_total3      TYPE zst_bill_item-net.
    DATA lv_total4      TYPE zst_bill_item-net.
    DATA lv_total5      TYPE zst_bill_item-net.
    DATA lv_total6      TYPE zst_bill_item-net.
    DATA lt_log         TYPE TABLE OF ztb_ci_log.
    DATA lt_Success     TYPE TABLE OF ztb_ci_log.

    DATA(lt_billing) = COND #( WHEN tt_billing IS INITIAL
                               THEN convert_temp_to_data( )
                               ELSE tt_billing ).

    IF lt_billing IS INITIAL.
      RETURN.
    ELSE.
      CLEAR: lv_msg,
             lt_log.

      SELECT *
        FROM ztb_ci_log
        WITH
        PRIVILEGED ACCESS
        FOR ALL ENTRIES IN @lt_billing
        WHERE inv_no = @lt_billing-BillingDocument
        INTO TABLE @DATA(lt_del_log).
    ENDIF.

    TRY.
        GET TIME STAMP FIELD DATA(ts).
        DATA(lo_store) = NEW zcl_fp_tmpl_store_client( iv_service_instance_name   = lc_comm_scenario " Scenario ID: ZADSTEMPLSTORE
                                                       iv_use_destination_service = abap_false
                                                       iv_service_id              = lc_service_id
                                                       iv_comm_system_id          = lc_comm_system ).
        TRY.

            lo_store->get_schema_by_name( EXPORTING iv_form_name = lc_form_name
                                          IMPORTING ev_msg       = lv_msg  ).

            IF     lo_store IS NOT INITIAL
               AND lv_msg   IS INITIAL.
              DATA(ls_template) = lo_store->get_template_by_name( iv_get_binary    = abap_true
                                                                  iv_form_name     = lc_form_name
                                                                  iv_template_name = lc_template_name ).
              "'CI_TEMPLATE' ).
            ENDIF.

          CATCH zcx_fp_tmpl_store_error.
            lv_msg = 'No schema in form found'.
        ENDTRY.

        IF lv_msg IS NOT INITIAL.
          IF is_api = 'X'.
            ev_msg = lv_msg.
            ev_status = 'E'.
            RETURN.
          ELSE.
            LOOP AT lt_billing ASSIGNING FIELD-SYMBOL(<f_billing>).
              APPEND VALUE #(
                  uuid_l                = xco_cp=>uuid( )->value
                  inv_no                = <f_billing>-billingdocument
                  refid                 = COND #( WHEN bg_uid IS INITIAL
                                                  THEN <f_billing>-referenceuuid
                                                  ELSE '' )
                  status                = 'F'
                  message               = lv_msg
                  bgid                  = bg_uid
                  url                   = |/ui#BillingDocument-manage&/object/display/{ <f_billing>-billingdocument }|
                  created_by            = xco_cp=>sy->user( )->name
                  created_at            = ts
                  local_last_changed_by = xco_cp=>sy->user( )->name
                  local_last_changed_at = ts
                  last_changed_at       = ts  ) TO lt_log.
            ENDLOOP.
          ENDIF.
        ELSE.
          " ---------------------------------------------------------------------------------------
          DATA lv_grant               TYPE gm_grant_nbr.
          DATA lv_grantvalidityperiod TYPE c LENGTH 50.
          DATA lr_sponsor             TYPE RANGE OF I_SponsoredClassCore-SponsoredClass.

          " Create an instance of the PDF merger class
          IF is_merge = 'M'.
            DATA(l_merger) = cl_rspo_pdf_merger=>create_instance( ).
          ENDIF.

          LOOP AT lt_billing ASSIGNING <f_billing>.

            GET TIME STAMP FIELD ts.
            lv_grant = |{ <f_billing>-grantdata-grantid ALIGN = RIGHT WIDTH = 20 PAD = '0' }|.

            SELECT SINGLE first_day, last_day
              FROM zi_get_month_day( p_year  = @<f_billing>-billingdate+0(4),
                                     p_month = @<f_billing>-billingdate+4(2) )
              INTO @DATA(ls_month).

            TRY.
                lv_grantvalidityperiod =
                      |{ <f_billing>-grantdata-grantvalidityperiod+4(2) }/{ <f_billing>-grantdata-grantvalidityperiod+6(2) }/{ <f_billing>-grantdata-grantvalidityperiod+0(4) }| &&
                      | to { <f_billing>-grantdata-grantvalidityperiod+13(2) }/{ <f_billing>-grantdata-grantvalidityperiod+15(2) }/{ <f_billing>-grantdata-grantvalidityperiod+9(4) }|.
              CATCH cx_sy_range_out_of_bounds.
                lv_grantvalidityperiod = ''.
            ENDTRY.

            lv_xml_header = |<?xml version="1.0"?>| &&
                            |<FORM>| &&
                            |<ZI_CUSTOMER_INVOICE>| &&
                            |<ZI_CI_HEADER>| &&
                            |<LOGO></LOGO>| &&
                            |<TEXT_2>{ <f_billing>-salesdocument }</TEXT_2>| &&
                            |<TEXT_3>{ <f_billing>-companycode }</TEXT_3>| &&
                            |<TEXT_4_A>{ <f_billing>-customername }</TEXT_4_A>| &&
                            |<TEXT_4_B>{ <f_billing>-grantdata-yy1_fiscaladministrat_grt }</TEXT_4_B>| &&
                            |<TEXT_4_C></TEXT_4_C>| &&
                            |<TEXT_5></TEXT_5>| &&
                            |<TEXT_6></TEXT_6>| &&
                            |<AWARD_TITLE>{ <f_billing>-grantdata-grantdescription }</AWARD_TITLE>| &&
                            |<AWARD_PERIOD>{ lv_grantvalidityperiod }</AWARD_PERIOD>| &&
                            |<PRINCIPAL_INVESTIGATOR>{ <f_billing>-grantdata-yy1_principalinvestig_grtt }</PRINCIPAL_INVESTIGATOR>| &&
                            |<AWARD_NUMBER>{ <f_billing>-grantdata-yy1_agreementnumber_grt }</AWARD_NUMBER>| &&
                            |<INV_DATE>{ <f_billing>-billingdate }</INV_DATE>| &&
                            |<INV_PER>{ ls_month-first_day+4(2) }/{ ls_month-first_day+6(2) }/{ ls_month-first_day+0(4) } to { ls_month-last_day+4(2) }/{ ls_month-last_day+6(2) }/{ ls_month-last_day+0(4) }</INV_PER>| &&
                            |<PROJECT_NUMBER>{ <f_billing>-grantdata-grantexternalreference }</PROJECT_NUMBER>| &&
                            |</ZI_CI_HEADER>| &&
                            |<_ITEMS>|.

            " Current Expenditure
            SELECT a~GrantID,
                   a~SponsoredClass,
                   SUM( a~AmountInTransactionCurrency ) AS CurrentExpenditure

              FROM I_ActualPlanJournalEntryItem WITH
              PRIVILEGED ACCESS AS a

               INNER JOIN @<f_billing>-grantdata-SponsoredClass AS b
               ON  lpad( b~GrantID, 20, '0' ) = lpad( a~GrantID, 20 , '0' )
               AND b~SponsoredClass           = a~SponsoredClass

              WHERE a~PostingDate  >= @ls_month-first_day
                AND a~PostingDate  <= @ls_month-last_day
                AND a~SourceLedger  = '0L'
                AND a~Ledger        = '0L'
                AND a~GrantID       = @lv_grant
              GROUP BY a~GrantID,
                       a~SponsoredClass
              INTO TABLE @DATA(CurrentExpenditure).

            SELECT a~GrantID,
                   a~SponsoredClass,
                   a~AmountInTransactionCurrency

              FROM I_ActualPlanJournalEntryItem WITH
              PRIVILEGED ACCESS AS a

               INNER JOIN @<f_billing>-grantdata-SponsoredClass AS b
               ON  lpad( b~GrantID, 20, '0' ) = lpad( a~GrantID, 20 , '0' )
               AND b~SponsoredClass           = a~SponsoredClass

              WHERE a~PostingDate     < @ls_month-first_day
                AND a~SourceLedger    = '0L'
                AND a~Ledger          = '0L'
                AND a~GrantID         = @lv_grant
                AND a~SponsoredClass IS NOT INITIAL
              ORDER BY a~PostingDate DESCENDING
              INTO TABLE @DATA(CurrentExpenditureRemain).

            LOOP AT CurrentExpenditureRemain ASSIGNING FIELD-SYMBOL(<f_remain>).
              IF <f_remain>-SponsoredClass = 'SBILL'.
                EXIT.
              ENDIF.
              LOOP AT CurrentExpenditure ASSIGNING FIELD-SYMBOL(<CurrentExpenditure>)
                   WHERE GrantID = <f_remain>-GrantID AND SponsoredClass = <f_remain>-SponsoredClass.
                <CurrentExpenditure>-currentexpenditure += <f_remain>-AmountInTransactionCurrency.
              ENDLOOP.
              IF sy-subrc <> 0.
                APPEND VALUE #( GrantID            = <f_remain>-GrantID
                                SponsoredClass     = <f_remain>-SponsoredClass
                                CurrentExpenditure = <f_remain>-AmountInTransactionCurrency  ) TO CurrentExpenditure.
              ENDIF.
            ENDLOOP.

            SORT CurrentExpenditure BY GrantID
                                       SponsoredClass.

            " Cumulative Expenditure
            SELECT a~GrantID,
                   a~SponsoredClass,
                   SUM( a~AmountInTransactionCurrency ) AS CumulativeExpenditure

              FROM I_ActualPlanJournalEntryItem WITH
              PRIVILEGED ACCESS AS a

               INNER JOIN @<f_billing>-grantdata-SponsoredClass AS b
               ON  lpad( b~GrantID, 20, '0' ) = lpad( a~GrantID, 20 , '0' )
               AND b~SponsoredClass           = a~SponsoredClass

              WHERE a~PostingDate  <= @<f_billing>-billingdate
                AND a~SourceLedger  = '0L'
                AND a~Ledger        = '0L'
                AND a~GrantID       = @lv_grant
              GROUP BY a~GrantID,
                       a~SponsoredClass
              INTO TABLE @DATA(CumulativeExpenditure).

            IF sy-subrc = 0.
              SORT CumulativeExpenditure BY GrantID
                                            SponsoredClass.
            ENDIF.

            lr_sponsor = exc_sponsor( ).

            LOOP AT <f_billing>-grantdata-sponsoredclass ASSIGNING FIELD-SYMBOL(<f_sponsoredclass>)
                 WHERE SponsoredClass NOT IN lr_sponsor.

              IF <f_sponsoredclass>-sponsoredclassisbillable = 'X'.
                READ TABLE CurrentExpenditure
                     ASSIGNING FIELD-SYMBOL(<f_CurrentExpenditure>)
                     WITH KEY GrantID        = lv_grant
                              SponsoredClass = <f_sponsoredclass>-sponsoredclass
                     BINARY SEARCH.

                IF sy-subrc = 0.
                  <f_sponsoredclass>-creditamountintranscrcy = <f_CurrentExpenditure>-currentexpenditure.
                ENDIF.

                READ TABLE CumulativeExpenditure
                     ASSIGNING FIELD-SYMBOL(<f_CumulativeExpenditure>)
                     WITH KEY GrantID        = lv_grant
                              SponsoredClass = <f_sponsoredclass>-sponsoredclass
                     BINARY SEARCH.

                IF sy-subrc = 0.
                  <f_sponsoredclass>-debitamountintranscrcy = <f_CumulativeExpenditure>-cumulativeexpenditure.
                ENDIF.
              ENDIF.

              IF     <f_sponsoredclass>-creditamountintranscrcy = 0
                 AND <f_sponsoredclass>-debitamountintranscrcy  = 0.
                CONTINUE.
              ENDIF.

              lv_xml_items = |<ZI_CI_ITEM>| &&
                             |<BUDGETCATEGORY>{ <f_sponsoredclass>-sponsoreddescription }</BUDGETCATEGORY>| &&
                             |<CURRENTEXP>{ <f_sponsoredclass>-creditamountintranscrcy }</CURRENTEXP>| &&
                             |<CUMULATIVEEXP>{ <f_sponsoredclass>-debitamountintranscrcy }</CUMULATIVEEXP>| &&
                             |<LINE></LINE>| &&
                             |<PRODUCT></PRODUCT>| &&
                             |<DESCRIPTION></DESCRIPTION>| &&
                             |<QUANTITY></QUANTITY>| &&
                             |<GROSS></GROSS>| &&
                             |<NET></NET>| &&
                             |<CURRENCY>{ <f_sponsoredclass>-transactioncurrency }</CURRENCY>| &&
                             |<MEINS></MEINS>| &&
                             |<TEXT_1></TEXT_1>| &&
                             |<TEXT_2></TEXT_2>| &&
                             |<TEXT_3></TEXT_3>| &&
                             |</ZI_CI_ITEM>{ lv_xml_items }|.

              lv_total1 += <f_sponsoredclass>-creditamountintranscrcy.
              lv_total2 += <f_sponsoredclass>-debitamountintranscrcy.

            ENDLOOP.

            IF line_exists( CurrentExpenditure[ SponsoredClass = 'J' ] ).
              lv_total3 = CurrentExpenditure[ SponsoredClass = 'J' ]-currentexpenditure.
            ENDIF.

            IF line_exists( CumulativeExpenditure[ SponsoredClass = 'J' ] ).
              lv_total4 = CumulativeExpenditure[ SponsoredClass = 'J' ]-cumulativeexpenditure.
            ENDIF.

            lv_total5 = lv_total1 + lv_total3.
            lv_total6 = lv_total2 + lv_total4.
            lv_total4 += lv_total3.

            lv_xml_footer = |</_ITEMS>| &&
                            |<ZI_CI_FOOTER>| &&
                            |<TEXT_1></TEXT_1>| &&
                            |<INV_NO>{ <f_billing>-billingdocument }</INV_NO>| &&
                            |<PROJECT_NUMBER>{ <f_billing>-grantdata-grantexternalreference }</PROJECT_NUMBER>| &&
                            |<BUDGET_CAT>"AA"</BUDGET_CAT>| &&
                            |<TEXT_3>{ <f_billing>-grantdata-gteemindirectcostrateinpercent }</TEXT_3>| &&
                            |<TEXT_4></TEXT_4>| &&
                            |<TEXT_5></TEXT_5>| &&
                            |<TEXT_6></TEXT_6>| &&
                            |<TOTAL_1>{ lv_total1 }</TOTAL_1>| &&
                            |<TOTAL_2>{ lv_total2 }</TOTAL_2>| &&
                            |<TOTAL_3>{ lv_total3 }</TOTAL_3>| &&
                            |<TOTAL_4>{ lv_total4 }</TOTAL_4>| &&
                            |<TOTAL_5>{ lv_total5 }</TOTAL_5>| &&
                            |<TOTAL_6>{ lv_total6 }</TOTAL_6>| &&
                            |</ZI_CI_FOOTER>| &&
                            |</ZI_CUSTOMER_INVOICE>| &&
                            |</FORM>|.

            lv_xml_string = lv_xml_header &&
                            lv_xml_items  &&
                            lv_xml_footer.

            lv_xml_xstring = xco_cp=>string( iv_value = lv_xml_string )->as_xstring(
                io_conversion = xco_cp_character=>code_page->utf_8 )->value.

            " Get File name
            CONCATENATE lv_filename <f_billing>-billingdocument
                        INTO lv_filename SEPARATED BY '_'.

            TRY.
                " Render PDF
                cl_fp_ads_util=>render_pdf( EXPORTING iv_xml_data     = lv_xml_xstring
                                                      iv_xdp_layout   = ls_template-xdp_template
                                                      iv_locale       = 'en_US'
                                            IMPORTING ev_pdf          = DATA(ev_pdf)
                                                      ev_pages        = DATA(ev_pages)
                                            " TODO: variable is assigned but never used (ABAP cleaner)
                                                      ev_trace_string = DATA(ev_trace_string) ).

                IF is_merge = 'M'.
                  l_merger->add_document( ev_pdf ).
                  lv_page += ev_pages.
                ENDIF.

              CATCH cx_fp_ads_util INTO DATA(lx_fp_ads_util).
                lv_msg = lx_fp_ads_util->get_text( ).
            ENDTRY.

            " Get error message
            IF lv_msg IS NOT INITIAL.
              ev_msg = lv_msg.
              ev_status = 'E'.
              APPEND VALUE #(
                  uuid_l                = xco_cp=>uuid( )->value
                  inv_no                = <f_billing>-billingdocument
                  refid                 = COND #( WHEN bg_uid IS INITIAL
                                                  THEN <f_billing>-referenceuuid
                                                  ELSE '' )
                  status                = 'F'
                  message               = lv_msg
                  bgid                  = bg_uid
                  url                   = |/ui#BillingDocument-manage&/object/display/{ <f_billing>-billingdocument }|
                  created_by            = xco_cp=>sy->user( )->name
                  created_at            = ts
                  local_last_changed_by = xco_cp=>sy->user( )->name
                  local_last_changed_at = ts
                  last_changed_at       = ts  ) TO lt_log.
            ELSE.
              APPEND VALUE #(
                  uuid_l                = xco_cp=>uuid( )->value
                  inv_no                = <f_billing>-billingdocument
                  refid                 = COND #( WHEN bg_uid IS INITIAL
                                                  THEN <f_billing>-referenceuuid
                                                  ELSE '' )
                  status                = 'S'
                  message               = 'Printed successfully'
                  bgid                  = bg_uid
                  url                   = |/ui#BillingDocument-manage&/object/display/{ <f_billing>-billingdocument }|
                  created_by            = xco_cp=>sy->user( )->name
                  created_at            = ts
                  local_last_changed_by = xco_cp=>sy->user( )->name
                  local_last_changed_at = ts
                  last_changed_at       = ts  ) TO lt_Success.
            ENDIF.

            IF is_api = 'X' AND ev_status = 'E'.
              ev_inv = <f_billing>-billingdocument.
              EXIT.
            ENDIF.

            CLEAR: lv_xml_header,
                   lv_xml_items,
                   lv_xml_footer,
                   lv_xml_string,
                   lv_xml_xstring,
                   currentexpenditure,
                   cumulativeexpenditure,
                   lv_total1,
                   lv_total2,
                   lv_total3,
                   lv_total4,
                   lv_total5,
                   lv_total6,
                   ev_pdf,
                   lv_msg,
                   ev_pages,
                   ev_trace_string.

          ENDLOOP.

          " -------------------------------------------------------------------------------------------------------------------------------------------
          IF is_api IS INITIAL AND is_merge = 'M' AND ev_status <> 'E'.

            CLEAR lv_msg.
            CONDENSE lv_filename NO-GAPS.
            SHIFT lv_filename LEFT DELETING LEADING `_`.

            TRY.
                " Merge both documents and receive the result
                DATA(l_merged_PDF) = l_merger->merge_documents( ).

                cl_print_queue_utils=>create_queue_item_by_data(
                  EXPORTING iv_qname            = lc_queue_name
                            iv_print_data       = l_merged_PDF
                            iv_name_of_main_doc = lv_filename
                            iv_itemid           = cl_print_queue_utils=>create_queue_itemid( )
                            iv_pages            = lv_page
                  IMPORTING ev_err_msg          = lv_msg ).

              CATCH cx_fp_ads_util INTO DATA(lo_util).
                ev_msg = lo_util->get_longtext( ).
                lv_msg = ev_msg.
              CATCH cx_rspo_pdf_merger INTO DATA(l_exception).
                ev_msg = l_exception->get_longtext( ).
                lv_msg = ev_msg.
            ENDTRY.

          ENDIF.
          " -------------------------------------------------------------------------------------------------------------------------------------------

          " Get error message
          IF lv_msg IS NOT INITIAL.
            ev_msg = lv_msg.
            ev_status = 'E'.
            APPEND VALUE #(
                uuid_l                = xco_cp=>uuid( )->value
                inv_no                = <f_billing>-billingdocument
                refid                 = COND #( WHEN bg_uid IS INITIAL
                                                THEN <f_billing>-referenceuuid
                                                ELSE '' )
                status                = 'F'
                message               = lv_msg
                bgid                  = bg_uid
                url                   = |/ui#BillingDocument-manage&/object/display/{ <f_billing>-billingdocument }|
                created_by            = xco_cp=>sy->user( )->name
                created_at            = ts
                local_last_changed_by = xco_cp=>sy->user( )->name
                local_last_changed_at = ts
                last_changed_at       = ts  ) TO lt_log.
          ELSE.
            ev_msg = 'Printed successfully'.
            ev_status = 'S'.
            MOVE-CORRESPONDING lt_Success TO lt_log.
            LOOP AT lt_log ASSIGNING FIELD-SYMBOL(<f_log>).
              <f_log>-filename   = |{ lv_filename }.pdf|.
              <f_log>-attachment = l_merged_PDF.
              <f_log>-mimetype   = 'application/pdf'.
            ENDLOOP.
          ENDIF.

        ENDIF.

      CATCH zcx_fp_tmpl_store_error INTO DATA(lo_error).
        lv_msg = lo_error->get_text( ).
        ev_msg = lv_msg.
        ev_status = 'E'.
        LOOP AT lt_billing ASSIGNING <f_billing>.
          APPEND VALUE #(
              uuid_l                = xco_cp=>uuid( )->value
              inv_no                = <f_billing>-billingdocument
              refid                 = COND #( WHEN bg_uid IS INITIAL
                                              THEN <f_billing>-referenceuuid
                                              ELSE '' )
              status                = 'F'
              message               = lv_msg
              bgid                  = bg_uid
              url                   = |/ui#BillingDocument-manage&/object/display/{ <f_billing>-billingdocument }|
              created_by            = xco_cp=>sy->user( )->name
              created_at            = ts
              local_last_changed_by = xco_cp=>sy->user( )->name
              local_last_changed_at = ts
              last_changed_at       = ts  ) TO lt_log.
        ENDLOOP.
    ENDTRY.

    DELETE ztb_ci_log FROM TABLE @lt_del_log.
    INSERT ztb_ci_log FROM TABLE @lt_log.
  ENDMETHOD.


  METHOD set_return_check.
    chk_print = is_check.
  ENDMETHOD.


  METHOD set_return_chk_bg.
    chk_bg = is_bg.
  ENDMETHOD.


  METHOD set_return_data.
    temp_data = is_data.
    APPEND temp_data TO real_data.
    CLEAR temp_data.
  ENDMETHOD.


  METHOD set_return_merge.
    Chk_merge = is_merge.
  ENDMETHOD.


  METHOD set_temp_key.
    temp_key = it_temp_key.
  ENDMETHOD.


  METHOD exc_sponsor.
    return = VALUE #( sign   = 'I'
                      option = 'EQ'
                      ( low = 'J' )
                      ( low = '0' )
                      ( low = 'SBILL' )
                      ( low = 'IDC REVENUE R1' ) ).
  ENDMETHOD.
ENDCLASS.
