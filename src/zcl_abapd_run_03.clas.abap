CLASS zcl_abapd_run_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abapd_run_03 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_trips TYPE STANDARD TABLE OF REF TO zcl_abapd_travel_base WITH EMPTY KEY.

*    NEW -> Constructor 역할
    lt_trips = VALUE #(
        ( NEW zcl_abapd_travel_domestic( is_travel = VALUE #( travel_id = '00000001' description = 'Busan Trip'
                                                              total_price = '300.00' currency_code = 'KRW' ) ) )

        ( NEW zcl_abapd_travel_overseas( is_travel = VALUE #( travel_id = '00000002' description = 'Tokyo Trip'
                                                              total_price = '500.00' currency_code = 'KRW' ) ) )

     ).


     LOOP AT lt_trips INTO DATA(lo_trip).
        out->write( |{ lo_trip->get_description(  ) }: { lo_trip->get_total_price(  ) }| ).
     ENDLOOP.

  ENDMETHOD.

ENDCLASS.
