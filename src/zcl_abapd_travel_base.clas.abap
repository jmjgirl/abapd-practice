CLASS zcl_abapd_travel_base DEFINITION
  PUBLIC
*  FINAL
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
        IMPORTING is_travel TYPE ZABAPD_S_TRAVEL
        RAISING   zcx_abapd_travel.

    METHODS get_total_price ABSTRACT
        RETURNING VALUE(rv_price) TYPE ZABAPD_S_TRAVEL-total_price.

    METHODS get_description
        RETURNING VALUE(rv_text) TYPE string.


  PROTECTED SECTION.
    DATA : ms_travel TYPE ZABAPD_S_TRAVEL.


  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abapd_travel_base IMPLEMENTATION.

  METHOD constructor.
    IF is_travel-total_price <= 0.
        RAISE EXCEPTION TYPE zcx_abapd_travel
            MESSAGE e001(zabapd_msg) WITH is_travel-travel_id.
    ENDIF.
    ms_travel = is_travel.
  ENDMETHOD.

  METHOD get_description.
    rv_text = |{ ms_travel-travel_id } { ms_travel-description }|.

  ENDMETHOD.

ENDCLASS.
