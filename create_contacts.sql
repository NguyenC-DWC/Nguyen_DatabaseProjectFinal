USE finalproject;
DROP TABLE IF EXISTS Contacts;

CREATE TABLE Contacts
(
    ContactID int(10) NOT NULL AUTO_INCREMENT,
    Title varchar(8) NOT NULL,
    FirstName varchar(30) NOT NULL,
    LastName varchar(30) NOT NULL,
    Email varchar(40),
    Phone char(12),
    Fax char(12),
    Company varchar(30) NOT NULL,
    Address1 varchar(30),
    Address2 varchar(30),
    PostalCode char(10) NOT NULL,
    City varchar(20) NOT NULL,
    State char(2) NOT NULL,
    PRIMARY KEY(ContactID)
) AS
    SELECT Title, FirstName, LastName, Email, Phone, Fax, Company, Street As Address1, PostalCode, City, State
    FROM invoices;