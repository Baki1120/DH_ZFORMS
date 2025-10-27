CLASS zbgpfcl_exe_print DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_serializable_object .
    INTERFACES if_bgmc_operation .
    INTERFACES if_bgmc_op_single_tx_uncontr.
    INTERFACES if_bgmc_op_single .

    CLASS-METHODS run_via_bgpf
      IMPORTING i_rap_bo_entity_key             TYPE zcl_get_billing=>tt_temp_data
                i_merge                         TYPE za_mer_pdf-MergeFile OPTIONAL
      RETURNING VALUE(r_process_monitor_string) TYPE string
      RAISING   cx_bgmc.

    CLASS-METHODS run_via_bgpf_tx_uncontrolled
      IMPORTING i_rap_bo_entity_key             TYPE zcl_get_billing=>tt_temp_data
                i_merge                         TYPE za_mer_pdf-MergeFile OPTIONAL
      RETURNING VALUE(r_process_monitor_string) TYPE string
      RAISING   cx_bgmc.

    METHODS constructor
      IMPORTING i_rap_bo_entity_key TYPE zcl_get_billing=>tt_temp_data
                i_merge             TYPE za_mer_pdf-MergeFile OPTIONAL.

    CONSTANTS :
      BEGIN OF bgpf_state,
        unknown         TYPE int1 VALUE IS INITIAL,
        erroneous       TYPE int1 VALUE 1,
        new             TYPE int1 VALUE 2,
        running         TYPE int1 VALUE 3,
        successful      TYPE int1 VALUE 4,
        started_from_bo TYPE int1 VALUE 99,
      END OF bgpf_state.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA transaction_data TYPE zcl_get_billing=>tt_temp_data .
    DATA merge TYPE za_mer_pdf-MergeFile.
    CONSTANTS wait_time_in_seconds TYPE i VALUE 5.

ENDCLASS.



CLASS ZBGPFCL_EXE_PRINT IMPLEMENTATION.


  METHOD constructor.
    transaction_data = i_rap_bo_entity_key.
    merge = i_merge.
  ENDMETHOD.


  METHOD if_bgmc_op_single_tx_uncontr~execute.
    "implement if uncontrolled behavior is needed, e.g. commit work statements
    WAIT UP TO  wait_time_in_seconds SECONDS.
    DATA(lv_uuid) = xco_cp=>uuid( )->value.

    IF lines( transaction_data ) = 1.

      zcl_get_billing=>get_instance( )->additional_save(
        EXPORTING
          is_api     = ''
          bg_uid     = lv_uuid
          tt_billing = transaction_data ).

    ELSE.

      CASE me->merge.
        WHEN 'M'.

          zcl_get_billing=>get_instance( )->merge_pdf(
            EXPORTING
              is_api     = ''
              bg_uid     = lv_uuid
              is_merge   = 'M'
              tt_billing = transaction_data ).

        WHEN 'L'.

          zcl_get_billing=>get_instance( )->additional_save(
            EXPORTING
              is_api     = ''
              bg_uid     = lv_uuid
              tt_billing = transaction_data ).

      ENDCASE.
    ENDIF.
  ENDMETHOD.


  METHOD if_bgmc_op_single~execute.

  ENDMETHOD.


  METHOD run_via_bgpf.
    TRY.
        DATA(process_monitor) = cl_bgmc_process_factory=>get_default( )->create(
                                              )->set_name( |Customer Invoice Background Printing|
                                              )->set_operation(  NEW zbgpfcl_exe_print( i_rap_bo_entity_key = i_rap_bo_entity_key i_merge = i_merge )
                                              )->save_for_execution( ).

        r_process_monitor_string = process_monitor->to_string( ).

      CATCH cx_bgmc INTO DATA(lx_bgmc).
    ENDTRY.
  ENDMETHOD.


  METHOD run_via_bgpf_tx_uncontrolled.
    TRY.
        DATA(process_monitor) = cl_bgmc_process_factory=>get_default( )->create(
                                              )->set_name( |Customer Invoice Background Printing|
                                              )->set_operation_tx_uncontrolled(  NEW zbgpfcl_exe_print( i_rap_bo_entity_key = i_rap_bo_entity_key i_merge = i_merge )
                                              )->save_for_execution( ).

        r_process_monitor_string = process_monitor->to_string( ).

      CATCH cx_bgmc INTO DATA(lx_bgmc).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
