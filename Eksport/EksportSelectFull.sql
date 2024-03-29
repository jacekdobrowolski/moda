SELECT XMLSERIALIZE(DOCUMENT
             XMLELEMENT("Reservations",
               XMLAGG(
                 XMLELEMENT("Reservation",
                   XMLELEMENT("User",
                     XMLFOREST(
                     u.FIRST_NAME as "FirstName",
                     u.LAST_NAME as "LastName",
                     u.USER_ID as "UserId",
                     u.EMAIL as "Email",
                     u.PHONE_NUMBER as "PhoneNumber"
                     )
                   ),
                   XMLFOREST(
                   LTRIM(TO_CHAR(r.PAYMENT_AMOUNT, '99999D99', 'NLS_NUMERIC_CHARACTERS = ''.,''')) as "PaymentAmount",  
                   CASE 
                     WHEN r.PAYMENT_EXECUTION_TIME IS NOT NULL 
                     THEN TO_CHAR(r.PAYMENT_EXECUTION_TIME, 'YYYY-MM-DD') || 'T' || TO_CHAR(r.PAYMENT_EXECUTION_TIME, 'HH24:MI:SS')
                     ELSE NULL
                   END as "PaymentExecutionTime",
                   r.PAYMENT_METHOD as "PaymentMethod", 
                   r.PAYMENT_STATUS as "PaymentStatus", 
                   r.RESERVATION_ID as "ReservationId"),
                   (SELECT XMLELEMENT("RoomReservations",
                     XMLAGG(
                       XMLELEMENT("RoomReservation",
                         XMLFOREST(
                         TO_CHAR(rr.START_DATE, 'YYYY-MM-DD') || 'T' || TO_CHAR(rr.START_DATE, 'HH24:MI:SS') as "StartDate",
                         TO_CHAR(rr.END_DATE, 'YYYY-MM-DD') || 'T' || TO_CHAR(rr.END_DATE, 'HH24:MI:SS') as "EndDate",
                         rr.NUMBER_OF_GUESTS as "NumberOfGuests",
                         rr.BREAKFAST_COUNT as "BreakfastCount",
                         rr.DINNER_COUNT as "DinnerCount",
                         rr.LUNCH_COUNT as "LunchCount"
                         ),
                         (SELECT XMlELEMENT("Room",
                           XMLAGG(
                             XMLFOREST(
                             o.ROOM_ID as "RoomId",
                             o.BED_QUANTITY as "BedQuantity",
                             o.MAX_OCCUPANCY as "MaxOccupancy",
                             LTRIM(TO_CHAR(o.PRICE_PER_NIGHT, '9999D99', 'NLS_NUMERIC_CHARACTERS = ''.,''')) as "PricePerNight",
                             o.ROOM_NUMBER as "RoomNumber",
                             o.ROOM_STANDARD as "RoomStandard"
                             )
                           )
                         ) FROM ROOMS o WHERE o.ROOM_ID = rr.ROOM_ID)
                       ) 
                     )
                   ) FROM ROOM_RESERVATIONS rr WHERE rr.RESERVATION_ID = r.RESERVATION_ID)
                 )
               )
             )
           AS CLOB) AS xml_output
FROM RESERVATIONS r JOIN USERS u ON r.USER_ID = u.USER_ID