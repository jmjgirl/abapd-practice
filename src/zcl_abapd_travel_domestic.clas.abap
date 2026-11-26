CLASS zcl_abapd_travel_domestic DEFINITION
  PUBLIC

  INHERITING FROM zcl_abapd_travel_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_total_price REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abapd_travel_domestic IMPLEMENTATION.
  METHOD get_total_price.
    rv_price = ms_travel-total_price.
  ENDMETHOD.

ENDCLASS.
