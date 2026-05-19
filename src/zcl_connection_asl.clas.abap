CLASS zcl_connection_asl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.



    CLASS-DATA conn_counter TYPE i READ-ONLY.

*    METHODS set_attributes
*        IMPORTING
*        i_carrier_id TYPE /dmo/carrier_id OPTIONAL
*        i_connection_id TYPE /dmo/connection_id
*        RAISING
*          cx_abap_invalid_value.

    METHODS get_attributes
        EXPORTING
        e_carrier_id TYPE /dmo/carrier_id
        e_connection_id TYPE /dmo/connection_id.

    METHODS constructor
      IMPORTING
        i_carrier_id TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id

        RAISING cx_ABAP_INVALID_VALUE.

    METHODS get_output
        RETURNING VALUE(r_output) TYPE string_table.

*  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
    DATA carrier_name TYPE /dmo/carrier_name.

    DATA airport_from_id TYPE /dmo/airport_from_id.
    DATA airport_to_id TYPE /dmo/airport_to_id.

ENDCLASS.



CLASS zcl_connection_asl IMPLEMENTATION.

  METHOD constructor.

    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
       RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    SELECT SINGLE FROM /dmo/i_connection
    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
    WHERE AirlineID    = @i_carrier_id
      AND ConnectionID = @i_connection_id
    INTO ( @airport_from_id, @airport_to_id, @carrier_name ).

*    SELECT SINGLE FROM /dmo/connection
*    FIELDS airport_from_id, airport_to_id
*    WHERE carrier_id    = @i_carrier_id
*      AND connection_id = @i_connection_id
*    INTO ( @airport_from_id, @airport_to_id ).

    IF sy-subrc <> 0.
       RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->carrier_id = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter = conn_counter + 1.

  ENDMETHOD.


  METHOD get_attributes.
      e_carrier_id = carrier_id.
      e_connection_id = connection_id.
  ENDMETHOD.

  METHOD get_output.
    APPEND |-------------------------------------| TO r_output.
    APPEND |Airline Name:    { carrier_name } | TO r_output.
    APPEND |Carrier:         { carrier_id } | TO r_output.
    APPEND |Connection:      { connection_id } | TO r_output.
    APPEND |Departure:       { airport_from_id } | TO r_output.
    APPEND |Arrival:         { airport_to_id } | TO r_output.
  ENDMETHOD.

ENDCLASS.
