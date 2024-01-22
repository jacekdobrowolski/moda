SET SQLBLANKLINES ON
CREATE TABLE AMENITY_TYPES 
(
  AMENITY_TYPE_ID NUMBER(4) DEFAULT AMENITY_TYPE_ID_SEQ.NEXTVAL NOT NULL 
, AMENITY_NAME VARCHAR2(50) NOT NULL 
, CONSTRAINT AMENITY_TYPES_PK PRIMARY KEY 
  (
    AMENITY_TYPE_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX AMENITY_TYPES_PK_IDX ON AMENITY_TYPES (AMENITY_TYPE_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE HOTELS 
(
  HOTEL_ID NUMBER(7) DEFAULT HOTEL_ID_SEQ.NEXTVAL NOT NULL 
, NAME VARCHAR2(100 CHAR) NOT NULL 
, EMAIL VARCHAR2(50 CHAR) NOT NULL 
, RATING NUMBER(1) NOT NULL 
, PHONE_NUMBER VARCHAR2(16) NOT NULL 
, STREET VARCHAR2(100 CHAR) NOT NULL 
, POSTAL_CODE VARCHAR2(16 CHAR) NOT NULL 
, LOCALITY VARCHAR2(100 CHAR) NOT NULL 
, COUNTRY VARCHAR2(60 CHAR) NOT NULL 
, BUILDING_NUMBER VARCHAR2(6 CHAR) NOT NULL 
, APARTMENT_NUMBER VARCHAR2(6 CHAR) 
);

CREATE TABLE PROPERTIES 
(
  PROPERTY_ID NUMBER(5) DEFAULT PROPERTY_ID_SEQ.NEXTVAL NOT NULL 
, PROPERTY_NAME VARCHAR2(50) NOT NULL 
, DATA_TYPE VARCHAR2(20) NOT NULL 
, OPTIONAL VARCHAR2(1) NOT NULL 
, CONSTRAINT PROPERTIES_PK PRIMARY KEY 
  (
    PROPERTY_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX PROPERTIES_PK_IDX ON PROPERTIES (PROPERTY_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE ROOM_RESERVATIONS 
(
  RESERVATION_ID NUMBER(7) NOT NULL 
, ROOM_ID NUMBER(7) NOT NULL 
, START_DATE DATE NOT NULL 
, END_DATE DATE NOT NULL 
, NUMBER_OF_GUESTS NUMBER(2) NOT NULL 
, BREAKFAST_FOR_HOW_MANY NUMBER(2) NOT NULL 
, LUNCHES_FOR_HOW_MANY NUMBER(2) NOT NULL 
, DINNERS_FOR_HOW_MANY NUMBER(2) NOT NULL 
, CONSTRAINT ROOM_RESERVATIONS_PK PRIMARY KEY 
  (
    ROOM_ID 
  , RESERVATION_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX ROOM_RESERVATIONS_PK_IDX ON ROOM_RESERVATIONS (RESERVATION_ID ASC, ROOM_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE USERS 
(
  USER_ID NUMBER(7) DEFAULT USER_ID_SEQ.NEXTVAL NOT NULL 
, FIRST_NAME VARCHAR2(30) NOT NULL 
, LAST_NAME VARCHAR2(30) NOT NULL 
, EMAIL VARCHAR2(50) NOT NULL 
, PHONE_NUMBER VARCHAR2(16) NOT NULL 
, GENDER VARCHAR2(20) 
, STREET VARCHAR2(100) NOT NULL 
, POSTAL_CODE VARCHAR2(16) NOT NULL 
, LOCALITY VARCHAR2(100) NOT NULL 
, COUNTRY VARCHAR2(60) NOT NULL 
, BUILDING_NUMBER VARCHAR2(6) NOT NULL 
, APARTMENT_NUMBER VARCHAR2(6) 
, CONSTRAINT USERS_PK PRIMARY KEY 
  (
    USER_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX USERS_PK_IDX ON USERS (USER_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE AMENITIES 
(
  AMENITY_ID NUMBER(8) DEFAULT AMENITY_ID_SEQ.NEXTVAL NOT NULL 
, AMENITY_TYPE_ID NUMBER(4) NOT NULL 
, HOTEL_ID NUMBER(7) NOT NULL 
, CONSTRAINT AMENITIES_PK PRIMARY KEY 
  (
    AMENITY_ID 
  , AMENITY_TYPE_ID 
  , HOTEL_ID 
  )
  ENABLE 
);

CREATE TABLE ROOMS 
(
  ROOM_ID NUMBER(7) DEFAULT ROOM_ID_SEQ.NEXTVAL NOT NULL 
, ROOM_NUMBER VARCHAR2(10) NOT NULL 
, BED_QUANTITY NUMBER(2) NOT NULL 
, ROOM_STANDARD VARCHAR2(20) NOT NULL 
, PRICE_PER_NIGHT NUMBER(6, 2) NOT NULL 
, MAX_OCCUPANCY NUMBER(3) NOT NULL 
, HOTEL_ID NUMBER(10) NOT NULL 
, CONSTRAINT ROOMS_PK PRIMARY KEY 
  (
    ROOM_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX ROOMS_PK_IDX ON ROOMS (ROOM_ID, HOTEL_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE AMENITY_TYPE_PROPERTIES 
(
  PROPERTY_ID NUMBER(5) NOT NULL 
, AMENITY_TYPE_ID NUMBER(4) NOT NULL 
, CONSTRAINT AMENITY_TYPE_PROPERTIES_PK PRIMARY KEY 
  (
    PROPERTY_ID 
  , AMENITY_TYPE_ID 
  )
  ENABLE 
);

CREATE TABLE OPINIONS 
(
  OPINION_ID NUMBER(8) DEFAULT OPINION_ID_SEQ.NEXTVAL NOT NULL 
, RATING NUMBER(1) NOT NULL 
, "DATE" DATE NOT NULL 
, "COMMENT" VARCHAR2(1000) 
, USER_ID NUMBER(10) NOT NULL 
, HOTEL_ID NUMBER(10) NOT NULL 
, CONSTRAINT OPINIONS_PK PRIMARY KEY 
  (
    OPINION_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX OPINIONS_PK_IDX ON OPINIONS (OPINION_ID, HOTEL_ID, USER_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE RESERVATIONS 
(
  RESERVATION_ID NUMBER(7) DEFAULT RESERVATION_ID_SEQ.NEXTVAL NOT NULL 
, USER_ID NUMBER(7) NOT NULL 
, PAYMENT_STATUS VARCHAR2(20) NOT NULL 
, PAYMENT_METHOD VARCHAR2(20) NOT NULL 
, PAYMENT_AMOUNT NUMBER(9, 2) NOT NULL 
, PAYMENT_EXECUTION_TIME DATE NOT NULL 
, CONSTRAINT RESERVATIONS_PK PRIMARY KEY 
  (
    RESERVATION_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX RESERVATIONS_PK_IDX ON RESERVATIONS (RESERVATION_ID, USER_ID ASC) 
  )
  ENABLE 
);

CREATE TABLE PROPERTY_VALUES 
(
  AMENITY_ID NUMBER(8) NOT NULL 
, PROPERTY_ID NUMBER(5) NOT NULL 
, AMENITY_TYPE_ID NUMBER(10) NOT NULL 
, VALUE VARCHAR2(50) NOT NULL 
, CONSTRAINT PROPERTY_VALUES_PK PRIMARY KEY 
  (
    AMENITY_ID 
  , PROPERTY_ID 
  , AMENITY_TYPE_ID 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX PROPERTY_VALUES_PK_IDX ON PROPERTY_VALUES (AMENITY_ID ASC, PROPERTY_ID ASC, AMENITY_TYPE_ID ASC) 
  )
  ENABLE 
);

CREATE INDEX AMENITIES_AMENITY_TYPE_IDX ON AMENITIES (AMENITY_TYPE_ID);

CREATE INDEX AMENITIES_HOTEL_IDX ON AMENITIES (HOTEL_ID);

CREATE INDEX AMENITY_TYPE_PROPERTIES_AT_IDX ON AMENITY_TYPE_PROPERTIES (AMENITY_TYPE_ID);

CREATE INDEX AMENITY_TYPE_PROPERTIES_P_IDX ON AMENITY_TYPE_PROPERTIES (PROPERTY_ID);

CREATE INDEX HOTELS_PK_IDX ON HOTELS (HOTEL_ID);

CREATE INDEX OPINIONS_HOTEL_IDX ON OPINIONS (HOTEL_ID);

CREATE INDEX OPINIONS_USER_IDX ON OPINIONS (USER_ID);

CREATE INDEX PROPERTY_VALUES_AT_IDX ON PROPERTY_VALUES (AMENITY_TYPE_ID);

CREATE INDEX PROPERTY_VALUES_PROPERTY_IDX ON PROPERTY_VALUES (PROPERTY_ID);

CREATE INDEX RESERVATIONS_USER_IDX ON RESERVATIONS (USER_ID);

CREATE INDEX ROOMS_HOTEL_IDX ON ROOMS (HOTEL_ID);

CREATE INDEX ROOM_RESERVATIONS_ROOM_IDX ON ROOM_RESERVATIONS (ROOM_ID);

ALTER TABLE HOTELS
ADD CONSTRAINT HOTELS_PK_IDX PRIMARY KEY 
(
  HOTEL_ID 
)
USING INDEX HOTELS_PK_IDX
ENABLE;

ALTER TABLE HOTELS
ADD CONSTRAINT HOTELS_EMAIL_UQ UNIQUE 
(
  EMAIL 
)
USING INDEX 
(
    CREATE UNIQUE INDEX HOTELS_EMAIL_IDX ON HOTELS (EMAIL ASC) 
)
 ENABLE;

ALTER TABLE HOTELS
ADD CONSTRAINT HOTELS_PHONE_NUMBER_UQ UNIQUE 
(
  PHONE_NUMBER 
)
USING INDEX 
(
    CREATE UNIQUE INDEX HOTELS_PHONE_NUMBER_IDX ON HOTELS (PHONE_NUMBER ASC) 
)
 ENABLE;

ALTER TABLE AMENITIES
ADD CONSTRAINT ASSOCIATION12 FOREIGN KEY
(
  AMENITY_TYPE_ID 
)
REFERENCES AMENITY_TYPES
(
  AMENITY_TYPE_ID 
)
ENABLE;

ALTER TABLE AMENITIES
ADD CONSTRAINT ASSOCIATION9 FOREIGN KEY
(
  HOTEL_ID 
)
REFERENCES HOTELS
(
  HOTEL_ID 
)
ENABLE;

ALTER TABLE AMENITY_TYPE_PROPERTIES
ADD CONSTRAINT ASSOCIATION10 FOREIGN KEY
(
  PROPERTY_ID 
)
REFERENCES PROPERTIES
(
  PROPERTY_ID 
)
ENABLE;

ALTER TABLE AMENITY_TYPE_PROPERTIES
ADD CONSTRAINT ASSOCIATION11 FOREIGN KEY
(
  AMENITY_TYPE_ID 
)
REFERENCES AMENITY_TYPES
(
  AMENITY_TYPE_ID 
)
ENABLE;

ALTER TABLE OPINIONS
ADD CONSTRAINT ASSOCIATION2 FOREIGN KEY
(
  HOTEL_ID 
)
REFERENCES HOTELS
(
  HOTEL_ID 
)
ENABLE;

ALTER TABLE OPINIONS
ADD CONSTRAINT OPINIONS_FK1 FOREIGN KEY
(
  USER_ID 
)
REFERENCES USERS
(
  USER_ID 
)
ENABLE;

ALTER TABLE PROPERTY_VALUES
ADD CONSTRAINT PROPERTY_VALUES_FK1 FOREIGN KEY
(
  AMENITY_ID 
, AMENITY_TYPE_ID 
, PROPERTY_ID 
)
REFERENCES AMENITIES
(
  AMENITY_ID 
, AMENITY_TYPE_ID 
, HOTEL_ID 
)
ENABLE;

ALTER TABLE PROPERTY_VALUES
ADD CONSTRAINT PROPERTY_VALUES_FK2 FOREIGN KEY
(
  PROPERTY_ID 
, AMENITY_TYPE_ID 
)
REFERENCES AMENITY_TYPE_PROPERTIES
(
  PROPERTY_ID 
, AMENITY_TYPE_ID 
)
ENABLE;

ALTER TABLE RESERVATIONS
ADD CONSTRAINT RESERVATIONS_FK1 FOREIGN KEY
(
  USER_ID 
)
REFERENCES USERS
(
  USER_ID 
)
ENABLE;

ALTER TABLE ROOMS
ADD CONSTRAINT ASSOCIATION3 FOREIGN KEY
(
  HOTEL_ID 
)
REFERENCES HOTELS
(
  HOTEL_ID 
)
ENABLE;

ALTER TABLE HOTELS
ADD CONSTRAINT HOTELS_EMAIL_CHK CHECK 
(REGEXP_LIKE(Email, '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'))
ENABLE;

ALTER TABLE HOTELS
ADD CONSTRAINT HOTELS_RATING_CHK CHECK 
(RATING BETWEEN 0 AND 5)
ENABLE;

ALTER TABLE OPINIONS
ADD CONSTRAINT OPINIONS_CHK1 CHECK 
(RATING BETWEEN 0 AND 5)
ENABLE;

ALTER TABLE PROPERTIES
ADD CONSTRAINT PROPERTIES_CHK1 CHECK 
(DATA_TYPE IN ('VARCHAR2',  'NUMBER'))
ENABLE;

ALTER TABLE PROPERTIES
ADD CONSTRAINT PROPERTIES_CHK2 CHECK 
(OPTIONAL IN ('Y', 'N'))
ENABLE;

ALTER TABLE RESERVATIONS
ADD CONSTRAINT RESERVATIONS_CHK1 CHECK 
(PAYMENT_STATUS IN ('Paid', 'Unpaid', 'Processing'))
ENABLE;

ALTER TABLE RESERVATIONS
ADD CONSTRAINT RESERVATIONS_CHK2 CHECK 
( PAYMENT_METHOD IN ('OnSite', 'BankTransfer', 'CreditCard', 'BLIK'))
ENABLE;

ALTER TABLE ROOMS
ADD CONSTRAINT ROOMS_CHK1 CHECK 
(ROOM_STANDARD IN ('Standard', 'Premium', 'SuperPremium'))
ENABLE;

ALTER TABLE USERS
ADD CONSTRAINT USERS_CHK1 CHECK 
(Gender IN ('Female', 'Male'))
ENABLE;

ALTER TABLE USERS
ADD CONSTRAINT USERS_CHK2 CHECK 
(REGEXP_LIKE(Email, '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'))
ENABLE;

COMMENT ON TABLE AMENITIES IS 'UML to Offline Database Transform: Table AMENITIES created from UML class "Amenity"
UML to Offline Database Transform: Primary key constraint AMENITIES_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION12 created for UML association "Association12"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION9 created for UML association "Association9"';

COMMENT ON TABLE AMENITY_TYPES IS 'UML to Offline Database Transform: Table AMENITY_TYPES created from UML class "AmenityType"
UML to Offline Database Transform: Primary key constraint AMENITY_TYPES_PK created by default';

COMMENT ON TABLE AMENITY_TYPE_PROPERTIES IS 'UML to Offline Database Transform: Table AMENITY_TYPE_PROPERTIES created from UML class "AmenityTypeProperty"
UML to Offline Database Transform: Primary key constraint AMENITY_TYPE_PROPERTIES_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION10 created for UML association "Association10"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION11 created for UML association "Association11"';

COMMENT ON TABLE HOTELS IS 'UML to Offline Database Transform: Table HOTELS created from UML class "Hotel"
UML to Offline Database Transform: Primary key constraint HOTELS_PK created by default';

COMMENT ON TABLE OPINIONS IS 'UML to Offline Database Transform: Table OPINIONS created from UML class "Opinion"
UML to Offline Database Transform: Primary key constraint OPINIONS_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION1 created for UML association "Association1"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION2 created for UML association "Association2"';

COMMENT ON TABLE PROPERTIES IS 'UML to Offline Database Transform: Table PROPERTIES created from UML class "Property"
UML to Offline Database Transform: Primary key constraint PROPERTIES_PK created by default';

COMMENT ON TABLE PROPERTY_VALUES IS 'UML to Offline Database Transform: Table PROPERTY_VALUES created from UML class "PropertyValue"
UML to Offline Database Transform: Primary key constraint PROPERTY_VALUES_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION13 created for UML association "Association13"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION16 created for UML association "Association16"';

COMMENT ON TABLE RESERVATIONS IS 'UML to Offline Database Transform: Table RESERVATIONS created from UML class "Reservation"
UML to Offline Database Transform: Primary key constraint RESERVATIONS_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION6 created for UML association "Association6"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION7 created for UML association "Association7"
UML to Offline Database Transform: Unique key constraint RESERVATIONS_UK1 created to enforce 1:1 rule in UML association "Association7"';

COMMENT ON TABLE ROOMS IS 'UML to Offline Database Transform: Table ROOMS created from UML class "Room"
UML to Offline Database Transform: Primary key constraint ROOMS_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION3 created for UML association "Association3"';

COMMENT ON TABLE ROOM_RESERVATIONS IS 'UML to Offline Database Transform: Table ROOM_RESERVATIONS created from UML class "RoomReservation"
UML to Offline Database Transform: Primary key constraint ROOM_RESERVATIONS_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION4 created for UML association "Association4"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION5 created for UML association "Association5"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION8 created for UML association "Association8"
UML to Offline Database Transform: Unique key constraint ROOM_RESERVATIONS_UK1 created to enforce 1:1 rule in UML association "Association8"';

COMMENT ON TABLE USERS IS 'UML to Offline Database Transform: Table USERS created from UML class "User"
UML to Offline Database Transform: Primary key constraint USERS_PK created by default';

COMMENT ON COLUMN AMENITIES.AMENITY_ID IS 'UML to Offline Database Transform: Column AMENITY_ID created as default primary key column';

COMMENT ON COLUMN AMENITIES.AMENITY_TYPE_ID IS 'UML to Offline Database Transform: Column ASSOCIATION12 created as default foreign key column for foreign key "ASSOCIATION12"';

COMMENT ON COLUMN AMENITIES.HOTEL_ID IS 'UML to Offline Database Transform: Column ASSOCIATION9 created as default foreign key column for foreign key "ASSOCIATION9"';

COMMENT ON COLUMN AMENITY_TYPES.AMENITY_TYPE_ID IS 'UML to Offline Database Transform: Column AMENITY_TYPE_ID created as default primary key column';

COMMENT ON COLUMN AMENITY_TYPES.AMENITY_NAME IS 'UML to Offline Database Transform: Column AMENITY_NAME created from UML attribute "AmenityName" in UML class "AmenityType"';

COMMENT ON COLUMN AMENITY_TYPE_PROPERTIES.PROPERTY_ID IS 'UML to Offline Database Transform: Column ASSOCIATION10 created as default foreign key column for foreign key "ASSOCIATION10"';

COMMENT ON COLUMN AMENITY_TYPE_PROPERTIES.AMENITY_TYPE_ID IS 'UML to Offline Database Transform: Column ASSOCIATION11 created as default foreign key column for foreign key "ASSOCIATION11"';

COMMENT ON COLUMN HOTELS.HOTEL_ID IS 'UML to Offline Database Transform: Column HOTEL_ID created as default primary key column';

COMMENT ON COLUMN HOTELS.NAME IS 'UML to Offline Database Transform: Column NAME created from UML attribute "Name" in UML class "Hotel"';

COMMENT ON COLUMN HOTELS.EMAIL IS 'UML to Offline Database Transform: Column EMAIL created from UML attribute "Email" in UML class "Hotel"';

COMMENT ON COLUMN HOTELS.RATING IS 'UML to Offline Database Transform: Column RATING created from UML attribute "Rating" in UML class "Hotel"';

COMMENT ON COLUMN HOTELS.STREET IS 'UML to Offline Database Transform: Column STREET created from UML attribute "Street" in UML class "Hotel"';

COMMENT ON COLUMN HOTELS.POSTAL_CODE IS 'UML to Offline Database Transform: Column POSTAL_CODE created from UML attribute "PostalCode" in UML class "Hotel"';

COMMENT ON COLUMN HOTELS.LOCALITY IS 'UML to Offline Database Transform: Column LOCALITY created from UML attribute "Locality" in UML class "Hotel"';

COMMENT ON COLUMN HOTELS.COUNTRY IS 'UML to Offline Database Transform: Column COUNTRY created from UML attribute "Country" in UML class "Hotel"';

COMMENT ON COLUMN HOTELS.BUILDING_NUMBER IS 'UML to Offline Database Transform: Column BUILDING_NUMBER created from UML attribute "BuildingNumber" in UML class "Hotel"';

COMMENT ON COLUMN HOTELS.APARTMENT_NUMBER IS 'UML to Offline Database Transform: Column APARTMENT_NUMBER created from UML attribute "ApartmentNumber" in UML class "Hotel"';

COMMENT ON COLUMN OPINIONS.OPINION_ID IS 'UML to Offline Database Transform: Column OPINION_ID created as default primary key column';

COMMENT ON COLUMN OPINIONS.RATING IS 'UML to Offline Database Transform: Column RATING created from UML attribute "Rating" in UML class "Opinion"';

COMMENT ON COLUMN OPINIONS."DATE" IS 'UML to Offline Database Transform: Column DATE created from UML attribute "Date" in UML class "Opinion"';

COMMENT ON COLUMN OPINIONS."COMMENT" IS 'UML to Offline Database Transform: Column COMMENT created from UML attribute "Comment" in UML class "Opinion"';

COMMENT ON COLUMN OPINIONS.USER_ID IS 'UML to Offline Database Transform: Column ASSOCIATION1 created as default foreign key column for foreign key "ASSOCIATION1"';

COMMENT ON COLUMN OPINIONS.HOTEL_ID IS 'UML to Offline Database Transform: Column ASSOCIATION2 created as default foreign key column for foreign key "ASSOCIATION2"';

COMMENT ON COLUMN PROPERTIES.PROPERTY_ID IS 'UML to Offline Database Transform: Column PROPERTY_ID created as default primary key column';

COMMENT ON COLUMN PROPERTIES.PROPERTY_NAME IS 'UML to Offline Database Transform: Column PROPERTY_NAME created from UML attribute "PropertyName" in UML class "Property"';

COMMENT ON COLUMN PROPERTIES.DATA_TYPE IS 'UML to Offline Database Transform: Column DATA_TYPE created from UML attribute "DataType" in UML class "Property"';

COMMENT ON COLUMN PROPERTIES.OPTIONAL IS 'UML to Offline Database Transform: Column OPTIONAL created from UML attribute "Optional" in UML class "Property"';

COMMENT ON COLUMN PROPERTY_VALUES.AMENITY_ID IS 'UML to Offline Database Transform: Column ASSOCIATION13 created as default foreign key column for foreign key "ASSOCIATION13"';

COMMENT ON COLUMN PROPERTY_VALUES.PROPERTY_ID IS 'UML to Offline Database Transform: Column ASSOCIATION10 created as default foreign key column for foreign key "ASSOCIATION10"';

COMMENT ON COLUMN PROPERTY_VALUES.AMENITY_TYPE_ID IS 'UML to Offline Database Transform: Column ASSOCIATION11 created as default foreign key column for foreign key "ASSOCIATION11"';

COMMENT ON COLUMN PROPERTY_VALUES.VALUE IS 'UML to Offline Database Transform: Column VALUE created from UML attribute "Value" in UML class "PropertyValue"';

COMMENT ON COLUMN RESERVATIONS.RESERVATION_ID IS 'UML to Offline Database Transform: Column RESERVATION_ID created as default primary key column';

COMMENT ON COLUMN RESERVATIONS.USER_ID IS 'UML to Offline Database Transform: Column ASSOCIATION6 created as default foreign key column for foreign key "ASSOCIATION6"';

COMMENT ON COLUMN RESERVATIONS.PAYMENT_STATUS IS 'UML to Offline Database Transform: Column STATUS created from UML attribute "Status" in UML class "Payment"';

COMMENT ON COLUMN RESERVATIONS.PAYMENT_METHOD IS 'UML to Offline Database Transform: Column PAYMENT_METHOD created from UML attribute "PaymentMethod" in UML class "Payment"';

COMMENT ON COLUMN RESERVATIONS.PAYMENT_AMOUNT IS 'UML to Offline Database Transform: Column AMOUNT created from UML attribute "Amount" in UML class "Payment"';

COMMENT ON COLUMN RESERVATIONS.PAYMENT_EXECUTION_TIME IS 'UML to Offline Database Transform: Column EXECUTION_TIME created from UML attribute "ExecutionTime" in UML class "Payment"';

COMMENT ON COLUMN ROOMS.ROOM_ID IS 'UML to Offline Database Transform: Column ROOM_ID created as default primary key column';

COMMENT ON COLUMN ROOMS.ROOM_NUMBER IS 'UML to Offline Database Transform: Column ROOM_NUMBER created from UML attribute "RoomNumber" in UML class "Room"';

COMMENT ON COLUMN ROOMS.BED_QUANTITY IS 'UML to Offline Database Transform: Column BED_QUANTITY created from UML attribute "BedQuantity" in UML class "Room"';

COMMENT ON COLUMN ROOMS.ROOM_STANDARD IS 'UML to Offline Database Transform: Column ROOM_TYPE created from UML attribute "RoomType" in UML class "Room"';

COMMENT ON COLUMN ROOMS.PRICE_PER_NIGHT IS 'UML to Offline Database Transform: Column PRICE_PER_NIGHT created from UML attribute "PricePerNight" in UML class "Room"';

COMMENT ON COLUMN ROOMS.MAX_OCCUPANCY IS 'UML to Offline Database Transform: Column MAX_OCCUPANCY created from UML attribute "MaxOccupancy" in UML class "Room"';

COMMENT ON COLUMN ROOMS.HOTEL_ID IS 'UML to Offline Database Transform: Column ASSOCIATION3 created as default foreign key column for foreign key "ASSOCIATION3"';

COMMENT ON COLUMN ROOM_RESERVATIONS.RESERVATION_ID IS 'UML to Offline Database Transform: Column ASSOCIATION5 created as default foreign key column for foreign key "ASSOCIATION5"';

COMMENT ON COLUMN ROOM_RESERVATIONS.ROOM_ID IS 'UML to Offline Database Transform: Column ASSOCIATION4 created as default foreign key column for foreign key "ASSOCIATION4"';

COMMENT ON COLUMN ROOM_RESERVATIONS.START_DATE IS 'UML to Offline Database Transform: Column START_DATE created from UML attribute "StartDate" in UML class "RoomReservation"';

COMMENT ON COLUMN ROOM_RESERVATIONS.END_DATE IS 'UML to Offline Database Transform: Column END_DATE created from UML attribute "EndDate" in UML class "RoomReservation"';

COMMENT ON COLUMN ROOM_RESERVATIONS.NUMBER_OF_GUESTS IS 'UML to Offline Database Transform: Column NUMBER_OF_GUESTS created from UML attribute "NumberOfGuests" in UML class "RoomReservation"';

COMMENT ON COLUMN ROOM_RESERVATIONS.BREAKFAST_FOR_HOW_MANY IS 'UML to Offline Database Transform: Column BREAKFAST_FOR_HOW_MANY created from UML attribute "BreakfastForHowMany" in UML class "DiningPackage"';

COMMENT ON COLUMN ROOM_RESERVATIONS.LUNCHES_FOR_HOW_MANY IS 'UML to Offline Database Transform: Column LUNCHES_FOR_HOW_MANY created from UML attribute "LunchesForHowMany" in UML class "DiningPackage"';

COMMENT ON COLUMN ROOM_RESERVATIONS.DINNERS_FOR_HOW_MANY IS 'UML to Offline Database Transform: Column DINNERS_FOR_HOW_MANY created from UML attribute "DinnersForHowMany" in UML class "DiningPackage"';

COMMENT ON COLUMN USERS.USER_ID IS 'UML to Offline Database Transform: Column USER_ID created as default primary key column';

COMMENT ON COLUMN USERS.FIRST_NAME IS 'UML to Offline Database Transform: Column FIRST_NAME created from UML attribute "FirstName" in UML class "User"';

COMMENT ON COLUMN USERS.LAST_NAME IS 'UML to Offline Database Transform: Column LAST_NAME created from UML attribute "LastName" in UML class "User"';

COMMENT ON COLUMN USERS.EMAIL IS 'UML to Offline Database Transform: Column EMAIL created from UML attribute "Email" in UML class "User"';

COMMENT ON COLUMN USERS.PHONE_NUMBER IS 'UML to Offline Database Transform: Column PHONE_NUMBER created from UML attribute "PhoneNumber" in UML class "User"';

COMMENT ON COLUMN USERS.GENDER IS 'UML to Offline Database Transform: Column GENDER created from UML attribute "Gender" in UML class "User"';

CREATE SEQUENCE AMENITY_ID_SEQ INCREMENT BY 1 START WITH 1 NOCACHE;

CREATE SEQUENCE AMENITY_TYPE_ID_SEQ INCREMENT BY 1 START WITH 1 NOCACHE;

CREATE SEQUENCE HOTEL_ID_SEQ INCREMENT BY 1 START WITH 1 NOCACHE;

CREATE SEQUENCE OPINION_ID_SEQ INCREMENT BY 1 START WITH 1 NOCACHE;

CREATE SEQUENCE PROPERTY_ID_SEQ INCREMENT BY 1 START WITH 1 NOCACHE;

CREATE SEQUENCE RESERVATION_ID_SEQ INCREMENT BY 1 START WITH 1 NOCACHE;

CREATE SEQUENCE ROOM_ID_SEQ INCREMENT BY 1 START WITH 1 NOCACHE;

CREATE SEQUENCE USER_ID_SEQ INCREMENT BY 1 START WITH 1 NOCACHE;
