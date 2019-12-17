USE finalproject;
DROP TABLE IF EXISTS PostalCode;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS State;
DROP TABLE IF EXISTS Country;

CREATE TABLE PostalCode
(
    PostalCodeID int(10) NOT NULL AUTO_INCREMENT,
    PostalCode char(10) NOT NULL,
    PRIMARY KEY(PostalCodeID)
) AS
    SELECT DISTINCT PostalCode
    FROM contacts;

CREATE TABLE City
(
    CityID int(10) NOT NULL AUTO_INCREMENT,
    City varchar(20) NOT NULL,
    PRIMARY KEY(CityID)
) AS
    SELECT DISTINCT City, TaxRate
    FROM invoices
    ORDER BY City;

CREATE TABLE State
(
    StateID int(10) NOT NULL AUTO_INCREMENT,
    State char(2) NOT NULL,
    PRIMARY KEY(StateID)
) AS
    SELECT DISTINCT State
    FROM contacts
    ORDER BY State;

CREATE TABLE Country
(
    CountryID int(10) NOT NULL AUTO_INCREMENT,
    Country char(2) NOT NULL,
    PRIMARY KEY(CountryID)
);

INSERT INTO Country (Country) VALUE ('US');

#ALTER TABLE contacts DROP COLUMN PostalCodeID;
#ALTER TABLE contacts DROP COLUMN CityID;
#ALTER TABLE contacts DROP COLUMN StateID;
#ALTER TABLE contacts DROP COLUMN CountryID;

ALTER TABLE contacts
    ADD COLUMN PostalCodeID INT(10),
    ADD COLUMN CityID INT(10),
    ADD COLUMN StateID INT(10),
    ADD COLUMN CountryID INT(10) DEFAULT 1,
    ADD FOREIGN KEY (PostalCodeID) REFERENCES PostalCode(PostalCodeID),
    ADD FOREIGN KEY (CityID) REFERENCES City(CityID),
    ADD FOREIGN KEY (StateID) REFERENCES State(StateID),
    ADD FOREIGN KEY (CountryID) REFERENCES Country(CountryID);

UPDATE contacts
    INNER JOIN PostalCode
    ON contacts.PostalCode = PostalCode.PostalCode
    SET Contacts.PostalCodeID = PostalCode.PostalCodeID;

UPDATE contacts
    INNER JOIN City
    ON contacts.City = City.City
    SET Contacts.CityID = City.CityID;

UPDATE contacts
    INNER JOIN State
    ON contacts.State = State.State
    SET Contacts.StateID = State.StateID;

ALTER TABLE contacts DROP COLUMN PostalCode;
ALTER TABLE contacts DROP COLUMN City;
ALTER TABLE contacts DROP COLUMN State;