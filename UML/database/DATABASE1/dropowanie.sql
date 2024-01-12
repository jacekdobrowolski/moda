DECLARE
   sequence_exists EXCEPTION;
   PRAGMA EXCEPTION_INIT(sequence_exists, -2289); -- ORA-02289: sequence does not exist

   CURSOR all_sequences_cursor IS
      SELECT sequence_name
      FROM user_sequences;

BEGIN
   FOR sequence_rec IN all_sequences_cursor LOOP
      BEGIN
         -- Attempt to drop the sequence
         EXECUTE IMMEDIATE 'DROP SEQUENCE ' || sequence_rec.sequence_name;
      EXCEPTION
         WHEN sequence_exists THEN
            -- Handle the case where the sequence does not exist
            DBMS_OUTPUT.PUT_LINE('Sequence ' || sequence_rec.sequence_name || ' does not exist.');
      END;
   END LOOP;
END;
/

drop table opinions;
drop table property_values;
drop table room_reservations;
drop table reservations;
drop table users;
drop table rooms;
drop table room_standards;
drop table payment_status;
drop table payment_methods;
drop table amenities;
drop table amenity_type_properties;
drop table amenity_types;
drop table properties;
drop table hotels;
