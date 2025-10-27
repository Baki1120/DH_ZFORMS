FUNCTION zfm_exe_print.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(EV_INV) TYPE  I_BILLINGDOCUMENT-BILLINGDOCUMENT
*"     VALUE(EV_MSG) TYPE  STRING
*"     VALUE(EV_STATUS) TYPE  ZSTATUS
*"----------------------------------------------------------------------
  zcl_get_billing=>get_instance( )->additional_save(
    EXPORTING
      is_api    = 'X'
    IMPORTING
      ev_inv    = ev_inv
      ev_msg    = ev_msg
      ev_status = ev_status ).


ENDFUNCTION.
