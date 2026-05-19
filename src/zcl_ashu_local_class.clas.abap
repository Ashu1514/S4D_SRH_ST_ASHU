CLASS zcl_ashu_local_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ashu_local_class IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA connection TYPE REF TO zcl_connection_asl.
    DATA connections TYPE TABLE OF REF TO zcl_connection_asl.


*    connection = NEW #().
*    connection->carrier_id = 'LH'.
*    connection->connection_id = '4133'.

    TRY.
        connection = NEW #( i_carrier_id = 'LH'
            i_connection_id = '4133'
        ).

        APPEND connection to connections.

      CATCH cx_abap_invalid_value.
        out->write( 'Connection not found' ).
    ENDTRY.

    TRY.
        connection = NEW #( i_carrier_id = 'AI'
            i_connection_id = '3243'
        ).

        APPEND connection to connections.

        CATCH cx_abap_invalid_value.
            out->write( 'Connection not found' ).
    ENDTRY.



    LOOP AT connections into connection.
        out->write( connection->get_output( ) ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
