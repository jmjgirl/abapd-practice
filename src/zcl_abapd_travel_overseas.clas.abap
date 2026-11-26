CLASS zcl_abapd_travel_overseas DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapd_travel_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_total_price REDEFINITION.
    METHODS get_description REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abapd_travel_overseas IMPLEMENTATION.
  METHOD get_total_price.
    rv_price = ms_travel-total_price * '1.1'.
  ENDMETHOD.

  METHOD get_description.
    rv_text = super->get_description(  ) && ' (Overseas)'.
  ENDMETHOD.

ENDCLASS.
