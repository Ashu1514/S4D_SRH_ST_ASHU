CLASS zcl_reading_from_database DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_reading_from_database IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA airport_from_id TYPE /dmo/airport_from_id.
    DATA airport_to_id TYPE /dmo/airport_to_id.

    DATA airports TYPE TABLE OF /dmo/airport_from_id.

    SELECT SINGLE
        FROM /dmo/connection
        FIELDS airport_from_id
        WHERE carrier_id = 'LH' AND connection_id = '0400'
        INTO @airport_from_id.

    out->write( `----EXAMPLE 1-----` ).
    out->write( |Flight LH 400 departs from {  airport_from_id }.| ).
    out->write( `---------` ).

    SELECT SINGLE
        FROM /dmo/connection
        FIELDS airport_from_id, airport_to_id
        WHERE carrier_id = 'LH' AND connection_id = '0400'
        INTO ( @airport_from_id, @airport_to_id ).

    out->write( `----EXAMPLE 2-----` ).
    out->write( |Flight LH 400 departs from {  airport_from_id } and arrives at {  airport_to_id }.| ).
    out->write( `---------` ).

    SELECT SINGLE
        FROM /dmo/connection
        FIELDS airport_from_id
        WHERE carrier_id = 'XX' AND connection_id = '1234'
        INTO ( @airport_from_id ).

    IF sy-subrc = 0.
         out->write( `----EXAMPLE 3-----` ).
         out->write( |Flight XX 1234 departs from {  airport_from_id }.| ).
         out->write( `---------` ).
    ELSE.
         out->write( `----EXAMPLE 3-----` ).
         out->write( |There is no Flight XX 1234 found.| ).
         out->write( `---------` ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
