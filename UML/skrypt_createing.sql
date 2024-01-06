SET SQLBLANKLINES ON
CREATE TABLE UML.AMENITY_TYPES 
(
  AMENITY_TYPE_ID NUMBER NOT NULL 
, AMENITY_NAME VARCHAR2(20) NOT NULL 
, CONSTRAINT AMENITY_TYPES_PK PRIMARY KEY 
  (
    AMENITY_TYPE_ID 
  )
  ENABLE 
);

CREATE TABLE UML.DINING_PACKAGES 
(
  DINING_PACKAGE_ID NUMBER NOT NULL 
, BREAKFAST_FOR_HOW_MANY NUMBER NOT NULL 
, LUNCHES_FOR_HOW_MANY NUMBER NOT NULL 
, DINNERS_FOR_HOW_MANY NUMBER NOT NULL 
, CONSTRAINT DINING_PACKAGES_PK PRIMARY KEY 
  (
    DINING_PACKAGE_ID 
  )
  ENABLE 
);

CREATE TABLE UML.HOTELS 
(
  HOTEL_ID NUMBER NOT NULL 
, NAME VARCHAR2(20) NOT NULL 
, EMAIL VARCHAR2(20) NOT NULL 
, RATING NUMBER NOT NULL 
, STREET VARCHAR2(20) NOT NULL 
, POSTAL_CODE VARCHAR2(20) NOT NULL 
, LOCALITY VARCHAR2(20) NOT NULL 
, COUNTRY VARCHAR2(20) NOT NULL 
, BUILDING_NUMBER VARCHAR2(20) NOT NULL 
, APARTMENT_NUMBER VARCHAR2(20) NOT NULL 
, CONSTRAINT HOTELS_PK PRIMARY KEY 
  (
    HOTEL_ID 
  )
  ENABLE 
);

CREATE TABLE UML.PAYMENTS 
(
  PAYMENT_ID NUMBER NOT NULL 
, STATUS VARCHAR2(20) NOT NULL 
, PAYMENT_METHOD VARCHAR2(20) NOT NULL 
, AMOUNT NUMBER NOT NULL 
, EXECUTION_TIME DATE NOT NULL 
, CONSTRAINT PAYMENTS_PK PRIMARY KEY 
  (
    PAYMENT_ID 
  )
  ENABLE 
);

CREATE TABLE UML.PROPERTIES 
(
  PROPERTY_ID NUMBER NOT NULL 
, PROPERTY_NAME VARCHAR2(20) NOT NULL 
, DATA_TYPE VARCHAR2(20) NOT NULL 
, OPTIONAL VARCHAR2(1) NOT NULL 
, CONSTRAINT PROPERTIES_PK PRIMARY KEY 
  (
    PROPERTY_ID 
  )
  ENABLE 
);

CREATE TABLE UML.USERS 
(
  USER_ID NUMBER NOT NULL 
, FIRST_NAME VARCHAR2(20) NOT NULL 
, LAST_NAME VARCHAR2(20) NOT NULL 
, EMAIL VARCHAR2(20) NOT NULL 
, PHONE_NUMBER VARCHAR2(20) NOT NULL 
, GENDER VARCHAR2(20) NOT NULL 
, CONSTRAINT USERS_PK PRIMARY KEY 
  (
    USER_ID 
  )
  ENABLE 
);

CREATE TABLE UML.AMENITIES 
(
  AMENITY_ID NUMBER NOT NULL 
, END_AMENITY_TYPE NUMBER NOT NULL 
, END_HOTEL NUMBER NOT NULL 
, CONSTRAINT AMENITIES_PK PRIMARY KEY 
  (
    AMENITY_ID 
  )
  ENABLE 
);

CREATE TABLE UML.ROOMS 
(
  ROOM_ID NUMBER NOT NULL 
, ROOM_NUMBER VARCHAR2(20) NOT NULL 
, BED_QUANTITY VARCHAR2(20) NOT NULL 
, ROOM_TYPE VARCHAR2(20) NOT NULL 
, PRICE_PER_NIGHT NUMBER NOT NULL 
, MAX_OCCUPANCY NUMBER NOT NULL 
, END_HOTEL NUMBER NOT NULL 
, CONSTRAINT ROOMS_PK PRIMARY KEY 
  (
    ROOM_ID 
  )
  ENABLE 
);

CREATE TABLE UML.AMENITY_TYPE_PROPERTIES 
(
  AMENITY_TYPE_PROPERTY_ID NUMBER NOT NULL 
, PROPERTY_ID NUMBER NOT NULL 
, AMENITY_TYPE_ID NUMBER NOT NULL 
, CONSTRAINT AMENITY_TYPE_PROPERTIES_PK PRIMARY KEY 
  (
    AMENITY_TYPE_PROPERTY_ID 
  )
  ENABLE 
);

CREATE TABLE UML.OPINIONS 
(
  OPINION_ID NUMBER NOT NULL 
, RATING NUMBER NOT NULL 
, "DATE" DATE NOT NULL 
, "COMMENT" VARCHAR2(20) NOT NULL 
, END_USER NUMBER NOT NULL 
, END_HOTEL NUMBER NOT NULL 
, CONSTRAINT OPINIONS_PK PRIMARY KEY 
  (
    OPINION_ID 
  )
  ENABLE 
);

CREATE TABLE UML.RESERVATIONS 
(
  RESERVATION_ID NUMBER NOT NULL 
, END_USER NUMBER NOT NULL 
, END_PAYMENT NUMBER NOT NULL 
, CONSTRAINT RESERVATIONS_PK PRIMARY KEY 
  (
    RESERVATION_ID 
  )
  ENABLE 
);

CREATE TABLE UML.PROPERTY_VALUES 
(
  PROPERTY_VALUE_ID NUMBER NOT NULL 
, VALUE VARCHAR2(20) NOT NULL 
, AMENITY_ID NUMBER NOT NULL 
, AMENITY_TYPE_PROPERTY_ID NUMBER NOT NULL 
, CONSTRAINT PROPERTY_VALUES_PK PRIMARY KEY 
  (
    PROPERTY_VALUE_ID 
  )
  ENABLE 
);

CREATE TABLE UML.ROOM_RESERVATIONS 
(
  ROOM_RESERVATION_ID NUMBER NOT NULL 
, START_DATE DATE NOT NULL 
, END_DATE DATE NOT NULL 
, NUMBER_OF_GUESTS NUMBER NOT NULL 
, END_ROOM NUMBER NOT NULL 
, END_RESERVATION NUMBER NOT NULL 
, END_DINING_PACKAGE NUMBER NOT NULL 
, CONSTRAINT ROOM_RESERVATIONS_PK PRIMARY KEY 
  (
    ROOM_RESERVATION_ID 
  )
  ENABLE 
);

ALTER TABLE UML.RESERVATIONS
ADD CONSTRAINT RESERVATIONS_UK1 UNIQUE 
(
  END_PAYMENT 
)
ENABLE;

ALTER TABLE UML.ROOM_RESERVATIONS
ADD CONSTRAINT ROOM_RESERVATIONS_UK1 UNIQUE 
(
  END_DINING_PACKAGE 
)
ENABLE;

ALTER TABLE UML.AMENITIES
ADD CONSTRAINT ASSOCIATION12 FOREIGN KEY
(
  END_AMENITY_TYPE 
)
REFERENCES UML.AMENITY_TYPES
(
  AMENITY_TYPE_ID 
)
ENABLE;

ALTER TABLE UML.AMENITIES
ADD CONSTRAINT ASSOCIATION9 FOREIGN KEY
(
  END_HOTEL 
)
REFERENCES UML.HOTELS
(
  HOTEL_ID 
)
ENABLE;

ALTER TABLE UML.AMENITY_TYPE_PROPERTIES
ADD CONSTRAINT ASSOCIATION10 FOREIGN KEY
(
  PROPERTY_ID 
)
REFERENCES UML.PROPERTIES
(
  PROPERTY_ID 
)
ENABLE;

ALTER TABLE UML.AMENITY_TYPE_PROPERTIES
ADD CONSTRAINT ASSOCIATION11 FOREIGN KEY
(
  AMENITY_TYPE_ID 
)
REFERENCES UML.AMENITY_TYPES
(
  AMENITY_TYPE_ID 
)
ENABLE;

ALTER TABLE UML.OPINIONS
ADD CONSTRAINT ASSOCIATION1 FOREIGN KEY
(
  END_USER 
)
REFERENCES UML.USERS
(
  USER_ID 
)
ENABLE;

ALTER TABLE UML.OPINIONS
ADD CONSTRAINT ASSOCIATION2 FOREIGN KEY
(
  END_HOTEL 
)
REFERENCES UML.HOTELS
(
  HOTEL_ID 
)
ENABLE;

ALTER TABLE UML.PROPERTY_VALUES
ADD CONSTRAINT ASSOCIATION13 FOREIGN KEY
(
  AMENITY_ID 
)
REFERENCES UML.AMENITIES
(
  AMENITY_ID 
)
ENABLE;

ALTER TABLE UML.PROPERTY_VALUES
ADD CONSTRAINT ASSOCIATION16 FOREIGN KEY
(
  AMENITY_TYPE_PROPERTY_ID 
)
REFERENCES UML.AMENITY_TYPE_PROPERTIES
(
  AMENITY_TYPE_PROPERTY_ID 
)
ENABLE;

ALTER TABLE UML.RESERVATIONS
ADD CONSTRAINT ASSOCIATION6 FOREIGN KEY
(
  END_USER 
)
REFERENCES UML.USERS
(
  USER_ID 
)
ENABLE;

ALTER TABLE UML.RESERVATIONS
ADD CONSTRAINT ASSOCIATION7 FOREIGN KEY
(
  END_PAYMENT 
)
REFERENCES UML.PAYMENTS
(
  PAYMENT_ID 
)
ENABLE;

ALTER TABLE UML.ROOMS
ADD CONSTRAINT ASSOCIATION3 FOREIGN KEY
(
  END_HOTEL 
)
REFERENCES UML.HOTELS
(
  HOTEL_ID 
)
ENABLE;

ALTER TABLE UML.ROOM_RESERVATIONS
ADD CONSTRAINT ASSOCIATION4 FOREIGN KEY
(
  END_ROOM 
)
REFERENCES UML.ROOMS
(
  ROOM_ID 
)
ENABLE;

ALTER TABLE UML.ROOM_RESERVATIONS
ADD CONSTRAINT ASSOCIATION5 FOREIGN KEY
(
  END_RESERVATION 
)
REFERENCES UML.RESERVATIONS
(
  RESERVATION_ID 
)
ENABLE;

ALTER TABLE UML.ROOM_RESERVATIONS
ADD CONSTRAINT ASSOCIATION8 FOREIGN KEY
(
  END_DINING_PACKAGE 
)
REFERENCES UML.DINING_PACKAGES
(
  DINING_PACKAGE_ID 
)
ENABLE;

COMMENT ON TABLE UML.AMENITIES IS 'UML to Offline Database Transform: Table AMENITIES created from UML class "Amenity"
UML to Offline Database Transform: Primary key constraint AMENITIES_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION12 created for UML association "Association12"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION9 created for UML association "Association9"';

COMMENT ON TABLE UML.AMENITY_TYPES IS 'UML to Offline Database Transform: Table AMENITY_TYPES created from UML class "AmenityType"
UML to Offline Database Transform: Primary key constraint AMENITY_TYPES_PK created by default';

COMMENT ON TABLE UML.AMENITY_TYPE_PROPERTIES IS 'UML to Offline Database Transform: Table AMENITY_TYPE_PROPERTIES created from UML class "AmenityTypeProperty"
UML to Offline Database Transform: Primary key constraint AMENITY_TYPE_PROPERTIES_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION10 created for UML association "Association10"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION11 created for UML association "Association11"';

COMMENT ON TABLE UML.DINING_PACKAGES IS 'UML to Offline Database Transform: Table DINING_PACKAGES created from UML class "DiningPackage"
UML to Offline Database Transform: Primary key constraint DINING_PACKAGES_PK created by default';

COMMENT ON TABLE UML.HOTELS IS 'UML to Offline Database Transform: Table HOTELS created from UML class "Hotel"
UML to Offline Database Transform: Primary key constraint HOTELS_PK created by default';

COMMENT ON TABLE UML.OPINIONS IS 'UML to Offline Database Transform: Table OPINIONS created from UML class "Opinion"
UML to Offline Database Transform: Primary key constraint OPINIONS_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION1 created for UML association "Association1"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION2 created for UML association "Association2"';

COMMENT ON TABLE UML.PAYMENTS IS 'UML to Offline Database Transform: Table PAYMENTS created from UML class "Payment"
UML to Offline Database Transform: Primary key constraint PAYMENTS_PK created by default';

COMMENT ON TABLE UML.PROPERTIES IS 'UML to Offline Database Transform: Table PROPERTIES created from UML class "Property"
UML to Offline Database Transform: Primary key constraint PROPERTIES_PK created by default';

COMMENT ON TABLE UML.PROPERTY_VALUES IS 'UML to Offline Database Transform: Table PROPERTY_VALUES created from UML class "PropertyValue"
UML to Offline Database Transform: Primary key constraint PROPERTY_VALUES_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION13 created for UML association "Association13"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION16 created for UML association "Association16"';

COMMENT ON TABLE UML.RESERVATIONS IS 'UML to Offline Database Transform: Table RESERVATIONS created from UML class "Reservation"
UML to Offline Database Transform: Primary key constraint RESERVATIONS_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION6 created for UML association "Association6"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION7 created for UML association "Association7"
UML to Offline Database Transform: Unique key constraint RESERVATIONS_UK1 created to enforce 1:1 rule in UML association "Association7"';

COMMENT ON TABLE UML.ROOMS IS 'UML to Offline Database Transform: Table ROOMS created from UML class "Room"
UML to Offline Database Transform: Primary key constraint ROOMS_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION3 created for UML association "Association3"';

COMMENT ON TABLE UML.ROOM_RESERVATIONS IS 'UML to Offline Database Transform: Table ROOM_RESERVATIONS created from UML class "RoomReservation"
UML to Offline Database Transform: Primary key constraint ROOM_RESERVATIONS_PK created by default
UML to Offline Database Transform: Foreign key constraint ASSOCIATION4 created for UML association "Association4"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION5 created for UML association "Association5"
UML to Offline Database Transform: Foreign key constraint ASSOCIATION8 created for UML association "Association8"
UML to Offline Database Transform: Unique key constraint ROOM_RESERVATIONS_UK1 created to enforce 1:1 rule in UML association "Association8"';

COMMENT ON TABLE UML.USERS IS 'UML to Offline Database Transform: Table USERS created from UML class "User"
UML to Offline Database Transform: Primary key constraint USERS_PK created by default';

COMMENT ON COLUMN UML.AMENITIES.AMENITY_ID IS 'UML to Offline Database Transform: Column AMENITY_ID created as default primary key column';

COMMENT ON COLUMN UML.AMENITIES.END_AMENITY_TYPE IS 'UML to Offline Database Transform: Column ASSOCIATION12 created as default foreign key column for foreign key "ASSOCIATION12"';

COMMENT ON COLUMN UML.AMENITIES.END_HOTEL IS 'UML to Offline Database Transform: Column ASSOCIATION9 created as default foreign key column for foreign key "ASSOCIATION9"';

COMMENT ON COLUMN UML.AMENITY_TYPES.AMENITY_TYPE_ID IS 'UML to Offline Database Transform: Column AMENITY_TYPE_ID created as default primary key column';

COMMENT ON COLUMN UML.AMENITY_TYPES.AMENITY_NAME IS 'UML to Offline Database Transform: Column AMENITY_NAME created from UML attribute "AmenityName" in UML class "AmenityType"';

COMMENT ON COLUMN UML.AMENITY_TYPE_PROPERTIES.AMENITY_TYPE_PROPERTY_ID IS 'UML to Offline Database Transform: Column AMENITY_TYPE_PROPERTY_ID created as default primary key column';

COMMENT ON COLUMN UML.AMENITY_TYPE_PROPERTIES.PROPERTY_ID IS 'UML to Offline Database Transform: Column ASSOCIATION10 created as default foreign key column for foreign key "ASSOCIATION10"';

COMMENT ON COLUMN UML.AMENITY_TYPE_PROPERTIES.AMENITY_TYPE_ID IS 'UML to Offline Database Transform: Column ASSOCIATION11 created as default foreign key column for foreign key "ASSOCIATION11"';

COMMENT ON COLUMN UML.DINING_PACKAGES.DINING_PACKAGE_ID IS 'UML to Offline Database Transform: Column DINING_PACKAGE_ID created as default primary key column';

COMMENT ON COLUMN UML.DINING_PACKAGES.BREAKFAST_FOR_HOW_MANY IS 'UML to Offline Database Transform: Column BREAKFAST_FOR_HOW_MANY created from UML attribute "BreakfastForHowMany" in UML class "DiningPackage"';

COMMENT ON COLUMN UML.DINING_PACKAGES.LUNCHES_FOR_HOW_MANY IS 'UML to Offline Database Transform: Column LUNCHES_FOR_HOW_MANY created from UML attribute "LunchesForHowMany" in UML class "DiningPackage"';

COMMENT ON COLUMN UML.DINING_PACKAGES.DINNERS_FOR_HOW_MANY IS 'UML to Offline Database Transform: Column DINNERS_FOR_HOW_MANY created from UML attribute "DinnersForHowMany" in UML class "DiningPackage"';

COMMENT ON COLUMN UML.HOTELS.HOTEL_ID IS 'UML to Offline Database Transform: Column HOTEL_ID created as default primary key column';

COMMENT ON COLUMN UML.HOTELS.NAME IS 'UML to Offline Database Transform: Column NAME created from UML attribute "Name" in UML class "Hotel"';

COMMENT ON COLUMN UML.HOTELS.EMAIL IS 'UML to Offline Database Transform: Column EMAIL created from UML attribute "Email" in UML class "Hotel"';

COMMENT ON COLUMN UML.HOTELS.RATING IS 'UML to Offline Database Transform: Column RATING created from UML attribute "Rating" in UML class "Hotel"';

COMMENT ON COLUMN UML.HOTELS.STREET IS 'UML to Offline Database Transform: Column STREET created from UML attribute "Street" in UML class "Hotel"';

COMMENT ON COLUMN UML.HOTELS.POSTAL_CODE IS 'UML to Offline Database Transform: Column POSTAL_CODE created from UML attribute "PostalCode" in UML class "Hotel"';

COMMENT ON COLUMN UML.HOTELS.LOCALITY IS 'UML to Offline Database Transform: Column LOCALITY created from UML attribute "Locality" in UML class "Hotel"';

COMMENT ON COLUMN UML.HOTELS.COUNTRY IS 'UML to Offline Database Transform: Column COUNTRY created from UML attribute "Country" in UML class "Hotel"';

COMMENT ON COLUMN UML.HOTELS.BUILDING_NUMBER IS 'UML to Offline Database Transform: Column BUILDING_NUMBER created from UML attribute "BuildingNumber" in UML class "Hotel"';

COMMENT ON COLUMN UML.HOTELS.APARTMENT_NUMBER IS 'UML to Offline Database Transform: Column APARTMENT_NUMBER created from UML attribute "ApartmentNumber" in UML class "Hotel"';

COMMENT ON COLUMN UML.OPINIONS.OPINION_ID IS 'UML to Offline Database Transform: Column OPINION_ID created as default primary key column';

COMMENT ON COLUMN UML.OPINIONS.RATING IS 'UML to Offline Database Transform: Column RATING created from UML attribute "Rating" in UML class "Opinion"';

COMMENT ON COLUMN UML.OPINIONS."DATE" IS 'UML to Offline Database Transform: Column DATE created from UML attribute "Date" in UML class "Opinion"';

COMMENT ON COLUMN UML.OPINIONS."COMMENT" IS 'UML to Offline Database Transform: Column COMMENT created from UML attribute "Comment" in UML class "Opinion"';

COMMENT ON COLUMN UML.OPINIONS.END_USER IS 'UML to Offline Database Transform: Column ASSOCIATION1 created as default foreign key column for foreign key "ASSOCIATION1"';

COMMENT ON COLUMN UML.OPINIONS.END_HOTEL IS 'UML to Offline Database Transform: Column ASSOCIATION2 created as default foreign key column for foreign key "ASSOCIATION2"';

COMMENT ON COLUMN UML.PAYMENTS.PAYMENT_ID IS 'UML to Offline Database Transform: Column PAYMENT_ID created as default primary key column';

COMMENT ON COLUMN UML.PAYMENTS.STATUS IS 'UML to Offline Database Transform: Column STATUS created from UML attribute "Status" in UML class "Payment"';

COMMENT ON COLUMN UML.PAYMENTS.PAYMENT_METHOD IS 'UML to Offline Database Transform: Column PAYMENT_METHOD created from UML attribute "PaymentMethod" in UML class "Payment"';

COMMENT ON COLUMN UML.PAYMENTS.AMOUNT IS 'UML to Offline Database Transform: Column AMOUNT created from UML attribute "Amount" in UML class "Payment"';

COMMENT ON COLUMN UML.PAYMENTS.EXECUTION_TIME IS 'UML to Offline Database Transform: Column EXECUTION_TIME created from UML attribute "ExecutionTime" in UML class "Payment"';

COMMENT ON COLUMN UML.PROPERTIES.PROPERTY_ID IS 'UML to Offline Database Transform: Column PROPERTY_ID created as default primary key column';

COMMENT ON COLUMN UML.PROPERTIES.PROPERTY_NAME IS 'UML to Offline Database Transform: Column PROPERTY_NAME created from UML attribute "PropertyName" in UML class "Property"';

COMMENT ON COLUMN UML.PROPERTIES.DATA_TYPE IS 'UML to Offline Database Transform: Column DATA_TYPE created from UML attribute "DataType" in UML class "Property"';

COMMENT ON COLUMN UML.PROPERTIES.OPTIONAL IS 'UML to Offline Database Transform: Column OPTIONAL created from UML attribute "Optional" in UML class "Property"';

COMMENT ON COLUMN UML.PROPERTY_VALUES.PROPERTY_VALUE_ID IS 'UML to Offline Database Transform: Column PROPERTY_VALUE_ID created as default primary key column';

COMMENT ON COLUMN UML.PROPERTY_VALUES.VALUE IS 'UML to Offline Database Transform: Column VALUE created from UML attribute "Value" in UML class "PropertyValue"';

COMMENT ON COLUMN UML.PROPERTY_VALUES.AMENITY_ID IS 'UML to Offline Database Transform: Column ASSOCIATION13 created as default foreign key column for foreign key "ASSOCIATION13"';

COMMENT ON COLUMN UML.PROPERTY_VALUES.AMENITY_TYPE_PROPERTY_ID IS 'UML to Offline Database Transform: Column ASSOCIATION16 created as default foreign key column for foreign key "ASSOCIATION16"';

COMMENT ON COLUMN UML.RESERVATIONS.RESERVATION_ID IS 'UML to Offline Database Transform: Column RESERVATION_ID created as default primary key column';

COMMENT ON COLUMN UML.RESERVATIONS.END_USER IS 'UML to Offline Database Transform: Column ASSOCIATION6 created as default foreign key column for foreign key "ASSOCIATION6"';

COMMENT ON COLUMN UML.RESERVATIONS.END_PAYMENT IS 'UML to Offline Database Transform: Column ASSOCIATION7 created as default foreign key column for foreign key "ASSOCIATION7"';

COMMENT ON COLUMN UML.ROOMS.ROOM_ID IS 'UML to Offline Database Transform: Column ROOM_ID created as default primary key column';

COMMENT ON COLUMN UML.ROOMS.ROOM_NUMBER IS 'UML to Offline Database Transform: Column ROOM_NUMBER created from UML attribute "RoomNumber" in UML class "Room"';

COMMENT ON COLUMN UML.ROOMS.BED_QUANTITY IS 'UML to Offline Database Transform: Column BED_QUANTITY created from UML attribute "BedQuantity" in UML class "Room"';

COMMENT ON COLUMN UML.ROOMS.ROOM_TYPE IS 'UML to Offline Database Transform: Column ROOM_TYPE created from UML attribute "RoomType" in UML class "Room"';

COMMENT ON COLUMN UML.ROOMS.PRICE_PER_NIGHT IS 'UML to Offline Database Transform: Column PRICE_PER_NIGHT created from UML attribute "PricePerNight" in UML class "Room"';

COMMENT ON COLUMN UML.ROOMS.MAX_OCCUPANCY IS 'UML to Offline Database Transform: Column MAX_OCCUPANCY created from UML attribute "MaxOccupancy" in UML class "Room"';

COMMENT ON COLUMN UML.ROOMS.END_HOTEL IS 'UML to Offline Database Transform: Column ASSOCIATION3 created as default foreign key column for foreign key "ASSOCIATION3"';

COMMENT ON COLUMN UML.ROOM_RESERVATIONS.ROOM_RESERVATION_ID IS 'UML to Offline Database Transform: Column ROOM_RESERVATION_ID created as default primary key column';

COMMENT ON COLUMN UML.ROOM_RESERVATIONS.START_DATE IS 'UML to Offline Database Transform: Column START_DATE created from UML attribute "StartDate" in UML class "RoomReservation"';

COMMENT ON COLUMN UML.ROOM_RESERVATIONS.END_DATE IS 'UML to Offline Database Transform: Column END_DATE created from UML attribute "EndDate" in UML class "RoomReservation"';

COMMENT ON COLUMN UML.ROOM_RESERVATIONS.NUMBER_OF_GUESTS IS 'UML to Offline Database Transform: Column NUMBER_OF_GUESTS created from UML attribute "NumberOfGuests" in UML class "RoomReservation"';

COMMENT ON COLUMN UML.ROOM_RESERVATIONS.END_ROOM IS 'UML to Offline Database Transform: Column ASSOCIATION4 created as default foreign key column for foreign key "ASSOCIATION4"';

COMMENT ON COLUMN UML.ROOM_RESERVATIONS.END_RESERVATION IS 'UML to Offline Database Transform: Column ASSOCIATION5 created as default foreign key column for foreign key "ASSOCIATION5"';

COMMENT ON COLUMN UML.ROOM_RESERVATIONS.END_DINING_PACKAGE IS 'UML to Offline Database Transform: Column ASSOCIATION8 created as default foreign key column for foreign key "ASSOCIATION8"';

COMMENT ON COLUMN UML.USERS.USER_ID IS 'UML to Offline Database Transform: Column USER_ID created as default primary key column';

COMMENT ON COLUMN UML.USERS.FIRST_NAME IS 'UML to Offline Database Transform: Column FIRST_NAME created from UML attribute "FirstName" in UML class "User"';

COMMENT ON COLUMN UML.USERS.LAST_NAME IS 'UML to Offline Database Transform: Column LAST_NAME created from UML attribute "LastName" in UML class "User"';

COMMENT ON COLUMN UML.USERS.EMAIL IS 'UML to Offline Database Transform: Column EMAIL created from UML attribute "Email" in UML class "User"';

COMMENT ON COLUMN UML.USERS.PHONE_NUMBER IS 'UML to Offline Database Transform: Column PHONE_NUMBER created from UML attribute "PhoneNumber" in UML class "User"';

COMMENT ON COLUMN UML.USERS.GENDER IS 'UML to Offline Database Transform: Column GENDER created from UML attribute "Gender" in UML class "User"';
