CLASS zcl_abapd_run_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abapd_run_06 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*---------------------------------------------  1. 일단 SELECT : 경비원 통과
    SELECT FROM zi_abapd_travel
     FIELDS TravelId, Description, Status
     INTO Table @Data(lt_visible).


    out->write( |With access control: { lines( lt_visible ) } rows| ).
    out->write( lt_visible ).


*---------------------------------------------- 2. 경비원 건너뛰기
    SELECT FROM zi_abapd_travel WITH PRIVILEGED ACCESS
      FIELDS TravelId, Description, Status
      INTO TABLE @DATA(lt_all).

    out->write( |Privileged access: { lines( lt_all ) } rows| ).

  ENDMETHOD.
ENDCLASS.
