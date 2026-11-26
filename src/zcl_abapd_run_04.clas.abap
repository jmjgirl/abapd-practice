CLASS zcl_abapd_run_04 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abapd_run_04 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TRY.
*       정상적으로 실행
        DATA(lo_ok) = NEW zcl_abapd_travel_domestic( is_travel = VALUE #( travel_id = '00000001' description = 'Busan Trip'
                                                                          total_price = '300.00' currency_code = 'KRW' ) ).
        out->write( lo_ok->get_total_price(  ) ).


*       실행안되는 부분
        DATA(lo_bad) = NEW zcl_abapd_travel_overseas( is_travel = VALUE #( travel_id = '00000003' description = 'Free Trip'
                                                                           total_price = '0.00' currency_code = 'KRW' ) ).

        out->write( lo_bad->get_total_price(  ) ).

    CATCH zcx_abapd_travel INTO DATA(lx_error).
        out->write( lx_error->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
