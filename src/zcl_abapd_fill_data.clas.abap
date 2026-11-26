CLASS zcl_abapd_fill_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abapd_fill_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lt_travel TYPE STANDARD TABLE OF zabapd_travel WITH EMPTY KEY.

    lt_travel = VALUE #(
        ( travel_id = '00000001' agency_id = '070001' description = 'Busan Trip'
          total_price = '300.00' currency_code = 'EUR' status = 'O' )   " Open(진행 중)

        ( travel_id = '00000002' agency_id = '070002' description = 'Tokyo Trip'
          total_price = '500.00' currency_code = 'EUR' status = 'A' )   " Accepted(확정)

        ( travel_id = '00000003' agency_id = '070001' description = 'Jeju Trip'
          total_price = '200.00' currency_code = 'EUR' status = 'O' )

        ( travel_id = '00000004' agency_id = '070002' description = 'Osaka Trip'
          total_price = '450.00' currency_code = 'EUR' status = 'O' )  ).


    DELETE FROM zabapd_travel.
    INSERT zabapd_travel FROM TABLE @lt_travel.

    out->write( |{ sy-dbcnt } rows inserted| ).

  ENDMETHOD.
ENDCLASS.
