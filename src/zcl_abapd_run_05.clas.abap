CLASS zcl_abapd_run_05 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abapd_run_05 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*---------------------------------------------  1) 2장에서 만든 테이블 타입 담기
    DATA lt_travel TYPE zabapd_tt_travel.

    SELECT FROM zi_abapd_travel
      FIELDS TravelId     as travel_id,
             AgencyId     as agency_id,
             Description  as description,
             TotalPrice   as total_price,
             CurrencyCode as currency_code

     WHERE Status = 'O'
     ORDER BY TravelId
      INTO CORRESPONDING FIELDS OF TABLE @lt_travel.

    out->write( lt_travel ).


*--------------------------------------------- 2) 한 줄만 읽기
    SELECT SINGLE FROM zi_abapd_travel
      FIELDS Description, StatusText
     WHERE TravelId = '00000002'
      INTO @DATA(ls_one).


    IF sy-subrc = 0.
        out->write( |{ ls_one-Description }: { ls_one-StatusText }| ).
    ENDIF.


*--------------------------------------------- 3) 상태별 합계
    SELECT FROM zi_abapd_travel
      FIELDS Status, COUNT( * ) as trip_count, SUM( TotalPrice ) as total
     GROUP BY Status
      INTO TABLE @DATA(lt_summary).

    out->write( lt_summary ).

  ENDMETHOD.
ENDCLASS.
