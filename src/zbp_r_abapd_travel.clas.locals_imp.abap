CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS setStatus FOR DETERMINE ON MODIFY
       keys FOR Travel~setStatus.

    METHODS validatePrice FOR VALIDATE ON SAVE
       keys FOR Travel~validatePrice.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

    METHODS acceptTravel FOR MODIFY
      keys FOR ACTION Travel~acceptTravel RESULT result.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
    " 비워 두면 모두 허용
  ENDMETHOD.

  METHOD setStatus.
    READ ENTITIES OF zr_abapd_travel IN LOCAL MODE
    ENTITY Travel
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travel).

    DELETE lt_travel WHERE Status IS NOT INITIAL.
    CHECK lt_travel IS NOT INITIAL.

    MODIFY ENTITIES OF zr_abapd_travel IN LOCAL MODE
    ENTITY Travel
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR ls IN lt_travel ( %tky   = ls-%tky
                                            Status = 'O' ) ).

  ENDMETHOD.



  METHOD validatePrice.
    READ ENTITIES OF zr_abapd_travel IN LOCAL MODE
    ENTITY Travel
        FIELDS ( TotalPrice ) WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travel).

    LOOP AT lt_travel INTO DATA(ls_travel) WHERE TotalPrice <= 0.
        APPEND VALUE #( %tky = ls_travel-%tky ) To failed-travel.
        APPEND VALUE #( %tky = ls_travel-%tky
                        %msg = new_message( id       = 'ZABAPD_MSG'
                                            number   = '001'
                                            severity = if_abap_behv_message=>severity-error
                                            v1       = ls_travel-TravelId )
                        %element-TotalPrice = if_abap_behv=>mk-on ) TO reported-travel.
    ENDLOOP.
  ENDMETHOD.


  METHOD acceptTravel.

*------------------------------- 1. Status를 A로 바꿈
    MODIFY ENTITIES OF zr_abapd_travel IN LOCAL MODE
      ENTITY Travel
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN keys ( %tky   = key-%tky
                                        Status = 'A' ) ).

*------------------------------- 2. 바뀐 데이터를 다시 읽어서 result로 돌려줌
    READ ENTITIES OF zr_abapd_travel IN LOCAL MODE
      ENTITY Travel
        ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travel).

    result = VALUE #( FOR ls IN lt_travel ( %tky   = ls-%tky
                                            %param = ls      ) ).
  ENDMETHOD.


  METHOD get_instance_features.
    READ ENTITIES OF zr_abapd_travel IN LOCAL MODE
      ENTITY Travel
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travel).

*   Status 가 O이면 Accpet 버튼 켜짐  / A이면 꺼짐
    result = VALUE #( FOR ls IN lt_travel ( %tky                 = ls-%tky
                                            %action-acceptTravel = COND #( WHEN ls-Status = 'A'
                                                                           THEN if_abap_behv=>fc-o-disabled
                                                                           ELSE if_abap_behv=>fc-o-enabled    ) ) ).
  ENDMETHOD.
ENDCLASS.
