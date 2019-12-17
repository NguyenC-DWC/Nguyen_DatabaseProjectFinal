USE finalproject;
DROP TABLE IF EXISTS Phone;
DROP TABLE IF EXISTS PhoneType;

CREATE TABLE PhoneType
(
    PhoneTypeID int(10) NOT NULL AUTO_INCREMENT,
    PhoneType varchar(15) NOT NULL,
    PRIMARY KEY (PhoneTypeID)
);

INSERT INTO PhoneType(PhoneType) VALUE ('Work');
INSERT INTO PhoneType(PhoneType) VALUE ('Fax');

CREATE TABLE Phone
(
    ContactID int(10) NOT NULL,
    Phone varchar(40) NOT NULL,
    PhoneTypeID int(10) DEFAULT 1,
    FOREIGN KEY (ContactID) REFERENCES contacts(ContactID),
    FOREIGN KEY (PhoneTypeID) REFERENCES PhoneType(PhoneTypeID)
) AS
    SELECT DISTINCT ContactID,Phone
    from contacts;

INSERT INTO Phone(ContactID, Phone, PhoneTypeID)
SELECT ContactID,Fax,2 AS PhoneTypeID FROM contacts;

ALTER TABLE contacts DROP COLUMN Phone;
ALTER TABLE contacts DROP COLUMN Fax;