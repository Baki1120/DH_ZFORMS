CLASS lsc_zi_ci_h DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.
    METHODS save_modified    REDEFINITION.
    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.


CLASS lsc_zi_ci_h IMPLEMENTATION.
  METHOD save_modified.
    DATA(chk_prt) = zcl_get_billing=>get_instance( )->check_print( ).
    DATA(chk_bg) = zcl_get_billing=>get_instance( )->check_bg( ).
    DATA(chk_merge) = zcl_get_billing=>get_instance( )->check_merge( ).

    IF chk_prt IS INITIAL.
      IF chk_bg = 'X'.
        TRY.
            DATA(lt_data) = zcl_get_billing=>get_instance( )->convert_temp_to_data( ).
            IF lt_data IS NOT INITIAL.

              " TODO: variable is assigned but never used (ABAP cleaner)
              DATA(bgpf_process_name) = zbgpfcl_exe_print=>run_via_bgpf_tx_uncontrolled(
                                            i_rap_bo_entity_key = lt_data
                                            i_merge             = chk_merge ).
            ENDIF.
            cleanup_finalize( ).
          CATCH cx_bgmc INTO DATA(bgpf_exception). " TODO: variable is assigned but never used (ABAP cleaner)
            " handle exception
        ENDTRY.
      ELSE.
        CASE chk_merge.
          WHEN 'M'.
            zcl_get_billing=>get_instance( )->merge_pdf( is_api   = ''
                                                         is_merge = 'M' ).
          WHEN 'L'.
            zcl_get_billing=>get_instance( )->additional_save( is_api = '' ).
        ENDCASE.
        cleanup_finalize( ).
      ENDIF.
    ELSE.
      cleanup_finalize( ).
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
    zcl_get_billing=>get_instance( )->clean_up( ).
  ENDMETHOD.
ENDCLASS.


CLASS lhc_CustomerInvoice DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    TYPES lty_billing TYPE TABLE FOR READ RESULT zi_ci_h\\customerinvoice.

    METHODS exeprint
      IMPORTING lt_billing  TYPE lty_billing
                ref_uuid    TYPE zi_ci_log-ReferenceUUID OPTIONAL
                !background TYPE abap_boolean            OPTIONAL
      EXPORTING ev_status   TYPE c
                ev_msg      TYPE string.

  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR CustomerInvoice RESULT result.
    METHODS print FOR MODIFY
      IMPORTING keys FOR ACTION customerinvoice~print RESULT result.
    METHODS apiprint FOR MODIFY
      IMPORTING keys FOR ACTION customerinvoice~apiprint RESULT result.
    METHODS background FOR MODIFY
      IMPORTING keys FOR ACTION customerinvoice~background.

ENDCLASS.


CLASS lhc_CustomerInvoice IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD print.
    READ ENTITIES OF zi_ci_h IN LOCAL MODE
         ENTITY CustomerInvoice
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_billing).

    IF lt_billing IS INITIAL.
      RETURN.
    ENDIF.

    exeprint( lt_billing = lt_billing ).
    zcl_get_billing=>get_instance( )->set_return_merge( is_merge = keys[ 1 ]-%param-MergeFile ).

    result = VALUE #( FOR ls_billing IN lt_billing
                      ( %tky   = ls_billing-%tky
                        %param = ls_billing ) ).
  ENDMETHOD.

  METHOD apiPrint.
    DATA lt_billing TYPE lty_billing.
    DATA ls_param   TYPE za_ci_res.
    DATA lv_msg     TYPE string.
    DATA lv_merge   TYPE abap_boolean.
    DATA lv_fail    TYPE abap_boolean VALUE abap_false.

    " You should read the link below for more information
    " https://community.sap.com/t5/technology-q-a/rap-factory-action-response-with-deep-result-possible/qaq-p/13930949

    LOOP AT keys INTO DATA(ls_key).

      LOOP AT ls_key-%param-_customerinvoicelist
           ASSIGNING FIELD-SYMBOL(<f_listinvoice>).

        DATA(lv_invoice) = |{ <f_listinvoice>-InvoiceNumber ALIGN = LEFT WIDTH = 10 PAD = '0' }|.
        lv_merge = ls_key-%param-mergepdf.

        SELECT *
          FROM zi_ci_h
          WITH
          PRIVILEGED ACCESS
          WHERE BillingDocument = @lv_invoice
          APPENDING CORRESPONDING FIELDS OF TABLE @lt_billing.

        IF sy-subrc <> 0.
          CLEAR ls_param.
          ls_param-uuid          = ls_key-%param-uuid.
          ls_param-mergepdf      = lv_merge.
          ls_param-InvoiceNumber = <f_listinvoice>-InvoiceNumber.
          ls_param-Status        = 'E'.
          ls_param-Message       = |No Found Invoice { <f_listinvoice>-InvoiceNumber }|.

          APPEND VALUE #( %cid   = ls_key-%cid
                          %param = ls_param ) TO result.

          lv_fail = abap_true.
          EXIT.
        ENDIF.
      ENDLOOP.

    ENDLOOP.

    IF lv_fail = abap_true.
      RETURN.
    ENDIF.

    SORT lt_billing BY BillingDocument ASCENDING.
    DELETE ADJACENT DUPLICATES FROM lt_billing COMPARING BillingDocument.
    exeprint( lt_billing = lt_billing
              ref_uuid   = keys[ 1 ]-%param-uuid ).

*    READ ENTITIES OF zi_ci_h IN LOCAL MODE
*        ENTITY CustomerInvoice
*        ALL FIELDS WITH VALUE #( FOR ls_bill IN lt_billing ( %key-BillingDocument = ls_bill-BillingDocument ) )
*        RESULT DATA(lt_invoices).

*    READ ENTITIES OF zi_ci_h IN LOCAL MODE
*         ENTITY CustomerInvoice BY \_CustomerInvoiceLog
*         ALL FIELDS
*         WITH CORRESPONDING #( lt_invoices )
*         RESULT DATA(lt_log).

    CASE lv_merge.
      WHEN abap_true.

        zcl_get_billing=>get_instance( )->set_return_merge( is_merge = 'M' ).
        zcl_get_billing=>get_instance( )->merge_pdf( EXPORTING is_api    = 'X'
                                                               is_merge  = 'M'
                                                     IMPORTING ev_inv    = ls_param-InvoiceNumber
                                                               ev_msg    = lv_msg
                                                               ev_status = ls_param-Status ).

      WHEN OTHERS.

        zcl_get_billing=>get_instance( )->additional_save( EXPORTING is_api    = 'X'
                                                           IMPORTING ev_inv    = ls_param-InvoiceNumber
                                                                     ev_msg    = lv_msg
                                                                     ev_status = ls_param-Status ).

    ENDCASE.

    IF ls_param-InvoiceNumber IS INITIAL.
      ls_param-InvoiceNumber = '*'.
    ENDIF.

    " Set check_print
    zcl_get_billing=>get_instance( )->set_return_check(
        is_check = COND #( WHEN ls_param-Status = 'E' THEN 'X' ELSE '' ) ).

    " Return response
    result = VALUE #( FOR key IN keys
                      ( %cid                 = key-%cid
                        %param-uuid          = key-%param-uuid
                        %param-mergepdf      = lv_merge
                        %param-InvoiceNumber = ls_param-InvoiceNumber
                        %param-Message       = lv_msg
                        %param-Status        = ls_param-Status  ) ).
  ENDMETHOD.

  METHOD exeprint.
    " TODO: parameter EV_STATUS is never cleared or assigned (ABAP cleaner)

    DATA ls_temp_data TYPE zcl_get_billing=>ty_temp_data.
    DATA lt_grant     TYPE zst_read_grant.
    DATA lt_SponsCls  TYPE zst_data_grantsponsoredclasses.
    DATA ls_item      TYPE zst_bill_item.
    DATA lv_msg       TYPE string.
    DATA lv_filter    TYPE string.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_fail      TYPE abap_boolean.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_code      TYPE i.

    CONSTANTS lc_or TYPE c LENGTH 2 VALUE 'or'.

    SELECT I_JournalEntryItem~CompanyCode,
           I_JournalEntryItem~AccountingDocument,
           I_JournalEntryItem~FiscalYear,
           I_JournalEntryItem~GrantID,
           I_JournalEntryItem~SponsoredClass,
           I_JournalEntryItem~TransactionCurrency,
           SUM( I_JournalEntryItem~DebitAmountInTransCrcy )  AS debitamountintranscrcy,
           SUM( I_JournalEntryItem~CreditAmountInTransCrcy ) AS creditamountintranscrcy

      FROM I_JournalEntryItem
      WITH
      PRIVILEGED ACCESS

      INNER JOIN @lt_billing AS b
      ON  I_JournalEntryItem~CompanyCode        = b~CompanyCode
      AND I_JournalEntryItem~AccountingDocument = b~AccountingDocument
      AND I_JournalEntryItem~FiscalYear         = b~FiscalYear
      WHERE I_JournalEntryItem~SourceLedger = '0L'
        AND I_JournalEntryItem~Ledger       = '0L'

      GROUP BY I_JournalEntryItem~CompanyCode,
               I_JournalEntryItem~AccountingDocument,
               I_JournalEntryItem~FiscalYear,
               I_JournalEntryItem~GrantID,
               I_JournalEntryItem~SponsoredClass,
               I_JournalEntryItem~TransactionCurrency
      INTO TABLE @DATA(lt_je_items).

    SORT lt_je_items BY CompanyCode
                        AccountingDocument
                        FiscalYear.

    LOOP AT lt_je_items INTO DATA(ls_je_item)
         WHERE GrantID IS NOT INITIAL
         GROUP BY ( GrantID = ls_je_item-GrantID )
         ASCENDING ASSIGNING FIELD-SYMBOL(<f_je_item>).

      DATA(lv_grant) = <f_je_item>-GrantID.
      SHIFT lv_grant LEFT DELETING LEADING '0'.
      lv_filter = |GrantID eq '{ lv_grant }' { lc_or } { lv_filter }|.

    ENDLOOP.

    IF sy-subrc = 0.
      SHIFT lv_filter RIGHT DELETING TRAILING |{ lc_or } |.
      lv_filter = condense( lv_filter ).
      lv_filter = |({ lv_filter })|.

      DATA(lo_post_je) = NEW zcl_enh_post_je( ).

      CLEAR: lt_grant,
             lt_SponsCls.
      " -------------------------------------------------------------------------------------------------------------------------------------------
      lo_post_je->read_grant( EXPORTING is_filter = lv_filter
                              IMPORTING it_data   = lt_grant
                                        iv_fail   = lv_fail
                                        iv_code   = lv_code
                                        iv_msg    = lv_msg ).

      LOOP AT lt_grant-grantcore_type ASSIGNING FIELD-SYMBOL(<f_grant>)
           WHERE YY1_PrincipalInvestig_GRT IS NOT INITIAL.

        SELECT SINGLE concat_with_space( pi_last_name, pi_first_name, 1 )
               AS PrincipalInvestigatorName
          FROM ztb_pi_cc
          WITH
          PRIVILEGED ACCESS
          WHERE pi_code = @<f_grant>-yy1_principalinvestig_grt
          INTO @<f_grant>-yy1_principalinvestig_grtt.

        REPLACE ALL OCCURRENCES OF '&' IN <f_grant>-yy1_principalinvestig_grtt WITH '&amp;'.
        REPLACE ALL OCCURRENCES OF '<' IN <f_grant>-yy1_principalinvestig_grtt WITH '&lt;'.
        REPLACE ALL OCCURRENCES OF '>' IN <f_grant>-yy1_principalinvestig_grtt WITH '&gt;'.
        REPLACE ALL OCCURRENCES OF '"' IN <f_grant>-yy1_principalinvestig_grtt WITH '&quot;'.

        REPLACE ALL OCCURRENCES OF '&' IN <f_grant>-grantdescription WITH '&amp;'.
        REPLACE ALL OCCURRENCES OF '<' IN <f_grant>-grantdescription WITH '&lt;'.
        REPLACE ALL OCCURRENCES OF '>' IN <f_grant>-grantdescription WITH '&gt;'.
        REPLACE ALL OCCURRENCES OF '"' IN <f_grant>-grantdescription WITH '&quot;'.

      ENDLOOP.

      " -------------------------------------------------------------------------------------------------------------------------------------------
      lo_post_je->read_sponscls( EXPORTING is_filter = lv_filter
                                 IMPORTING it_data   = lt_SponsCls
                                           iv_fail   = lv_fail
                                           iv_code   = lv_code
                                           iv_msg    = lv_msg ).

      LOOP AT lt_SponsCls-grantsponsoredclasseslink_type ASSIGNING FIELD-SYMBOL(<f_SponsCls>)
           WHERE SponsoredClass IS NOT INITIAL.

        SELECT SINGLE SponsoredClassDescription
          FROM I_SponsoredClassCoreText
          WITH
          PRIVILEGED ACCESS
          WHERE SponsoredClass = @<f_SponsCls>-sponsoredclass
            AND Language       = @sy-langu
          INTO @<f_SponsCls>-sponsoreddescription.

        REPLACE ALL OCCURRENCES OF '&' IN <f_SponsCls>-sponsoreddescription WITH '&amp;'.
        REPLACE ALL OCCURRENCES OF '<' IN <f_SponsCls>-sponsoreddescription WITH '&lt;'.
        REPLACE ALL OCCURRENCES OF '>' IN <f_SponsCls>-sponsoreddescription WITH '&gt;'.
        REPLACE ALL OCCURRENCES OF '"' IN <f_SponsCls>-sponsoreddescription WITH '&quot;'.

        IF <f_SponsCls>-sponsoredclass CO ' 0123456789'.
          <f_SponsCls>-sort = 'B'.
        ELSE.
          <f_SponsCls>-sort = 'A'.
        ENDIF.

      ENDLOOP.

      ev_msg = lv_msg.

      " -------------------------------------------------------------------------------------------------------------------------------------------
    ENDIF.

    IF sy-subrc = 0.
      SORT lt_SponsCls-grantsponsoredclasseslink_type
           BY GrantID
              Sort DESCENDING
              SponsoredClass DESCENDING.
    ENDIF.

    " Get bill items.
    SELECT BillingDocument,
           BillingDocumentItem,
           Product,
           BillingQuantity,
           BillingQuantityUnit,
           GrossAmount,
           NetAmount,
           TransactionCurrency,
           SalesDocument,
           BillingDocumentItemText
      FROM I_BillingDocumentItem
      WITH
      PRIVILEGED ACCESS
      FOR ALL ENTRIES IN @lt_billing
      WHERE BillingDocument           = @lt_billing-BillingDocument
        AND CancelledBillingDocument IS INITIAL
      INTO TABLE @DATA(lt_billing_item).

    SORT lt_billing_item BY BillingDocument
                            BillingDocumentItem DESCENDING.
    SORT lt_grant-grantcore_type BY grantid.

    LOOP AT lt_billing ASSIGNING FIELD-SYMBOL(<f_billing>).
      CLEAR ls_temp_data.
      ls_temp_data-billingdocument    = <f_billing>-BillingDocument.
      ls_temp_data-accountingdocument = <f_billing>-AccountingDocument.
      ls_temp_data-fiscalyear         = <f_billing>-FiscalYear.
      ls_temp_data-companycode        = <f_billing>-CompanyCode.
      ls_temp_data-customername       = <f_billing>-CustomerName.
      ls_temp_data-billingstatus      = 'P'.
      ls_temp_data-billingdate        = <f_billing>-BillingDocumentDate.

      LOOP AT lt_je_items INTO ls_je_item
           WHERE     CompanyCode        = <f_billing>-CompanyCode
                 AND AccountingDocument = <f_billing>-AccountingDocument
                 AND FiscalYear         = <f_billing>-FiscalYear.

        SHIFT ls_je_item-GrantID LEFT DELETING LEADING '0'.
        SHIFT ls_je_item-SponsoredClass LEFT DELETING LEADING '0'.

        READ TABLE lt_grant-grantcore_type
             ASSIGNING <f_grant> WITH KEY grantid = ls_je_item-GrantID
             BINARY SEARCH.

        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.

        ls_temp_data-grantdata = CORRESPONDING #( <f_grant> ).

        LOOP AT lt_SponsCls-grantsponsoredclasseslink_type
             ASSIGNING <f_sponscls>
             WHERE grantid = <f_grant>-grantid.

          SELECT SINGLE SponsoredClassIsBillable
            FROM I_SponsoredClassCore
            WHERE SponsoredClass = @<f_sponscls>-sponsoredclass
            INTO @<f_sponscls>-sponsoredclassisbillable.

          <f_sponscls>-transactioncurrency = ls_je_item-TransactionCurrency.
          APPEND <f_sponscls> TO ls_temp_data-grantdata-SponsoredClass.
        ENDLOOP.

      ENDLOOP.

      LOOP AT lt_billing_item ASSIGNING FIELD-SYMBOL(<f_item>)
           WHERE BillingDocument = <f_billing>-BillingDocument.

        ls_item-inv_no   = <f_item>-BillingDocument.
        ls_item-line     = <f_item>-BillingDocumentItem.
        ls_item-product  = <f_item>-Product.
        ls_item-quantity = <f_item>-BillingQuantity.
        ls_item-meins    = |{ <f_item>-BillingQuantityUnit ALPHA = OUT }|.
        ls_item-gross    = <f_item>-GrossAmount.
        ls_item-net      = <f_item>-NetAmount.
        ls_item-currency = <f_item>-TransactionCurrency.
        ls_item-text_2   = <f_item>-BillingDocumentItemText.

        IF <f_item>-SalesDocument IS NOT INITIAL.
          ls_temp_data-salesdocument = <f_item>-SalesDocument.
        ENDIF.

        APPEND ls_item TO ls_temp_data-billingitems.
        CLEAR ls_item.

      ENDLOOP.

      ls_temp_data-referenceuuid = ref_uuid.
      zcl_get_billing=>get_instance( )->set_return_data( is_data = ls_temp_data ).
    ENDLOOP.

    IF background = 'X'.
      zcl_get_billing=>get_instance( )->set_return_chk_bg( is_bg = 'X' ).
    ENDIF.
  ENDMETHOD.

  METHOD background.
    READ ENTITIES OF zi_ci_h IN LOCAL MODE
         ENTITY CustomerInvoice
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_billing).

    IF lt_billing IS INITIAL.
      LOOP AT keys ASSIGNING FIELD-SYMBOL(<f_key_valid>).

        APPEND VALUE #( %tky = <f_key_valid>-%tky ) TO failed-CustomerInvoice.

        APPEND VALUE #( %tky                   = <f_key_valid>-%tky
                        %msg                   = new_message( id       = 'ZFORMS_MSG'
                                                              number   = 002
                                                              severity = if_abap_behv_message=>severity-error )
                        %op-%action-background = if_abap_behv=>mk-on )
               TO reported-CustomerInvoice.

      ENDLOOP.
    ELSE.
      exeprint( lt_billing = lt_billing
                background = 'X' ).

      LOOP AT keys ASSIGNING <f_key_valid>.
        zcl_get_billing=>get_instance( )->set_return_merge( is_merge = <f_key_valid>-%param-MergeFile ).

        APPEND VALUE #( %tky                   = <f_key_valid>-%tky
                        %msg                   = new_message( id       = 'ZFORMS_MSG'
                                                              number   = 001
                                                              v1       = <f_key_valid>-BillingDocument
                                                              severity = if_abap_behv_message=>severity-success )
                        %op-%action-background = if_abap_behv=>mk-on )
               TO reported-CustomerInvoice.

      ENDLOOP.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
