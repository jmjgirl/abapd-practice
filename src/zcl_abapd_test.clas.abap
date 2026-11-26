CLASS zcl_abapd_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

* 누구나 접근
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abapd_test IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA : lt_travel TYPE ZABAPD_TT_TRAVEL.

    lt_travel = VALUE #(
        ( travel_id = '00000001' description = 'Busan Trip' total_price = '300.00' currency_code = 'KRW'  )
        ( travel_id = '00000002' description = 'Jeju Trip'  total_price = '500.00' currency_code = 'KRW' ) ).

    out->write( lt_travel ).

  ENDMETHOD.

ENDCLASS.
