CLASS zcl_abapd_run_07 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abapd_run_07 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*-------------------------------------------- 1. 정상 생성 (Status는 비워 둠 -> determination이 'O'를 채움 )4
    MODIFY ENTITIES OF zr_abapd_travel
      ENTITY travel
      CREATE FIELDS ( TravelId AgencyId Description TotalPrice CurrencyCode  )
      WITH VALUE #( ( %cid = 'C1' TravelId = '00000005' AgencyId = '070001'
                      Description = 'Seoul Trip' TotalPrice = '150.00' CurrencyCode = 'EUR' ) )
    FAILED DATA(ls_failed)
    REPORTED DATA(ls_reported).


    COMMIT ENTITIES
      RESPONSE OF zr_abapd_travel
      FAILED DATA(ls_commit_failed)
      REPORTED DATA(ls_commit_reported).


    IF ls_commit_failed IS INITIAL.
        SELECT SINGLE FROM zr_abapd_travel
          FIELDS TravelId, Description, Status
          WHERE TravelId = '00000005'
          INTO @Data(ls_new).
        out->write( ls_new ).

    ELSE.
        LOOP AT ls_commit_reported-travel INTO DATA(ls_msg).
            out->write( ls_msg-%msg->if_message~get_text(  ) ).
        ENDLOOP.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
