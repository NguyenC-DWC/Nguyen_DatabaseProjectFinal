USE finalproject;
DROP TABLE IF EXISTS Company;

CREATE TABLE Company
(
    CompanyID int(10) NOT NULL AUTO_INCREMENT,
    Company varchar(30) NOT NULL,
    PRIMARY KEY(CompanyID)
) AS
    SELECT DISTINCT Company
    FROM contacts
    ORDER BY Company;

#ALTER TABLE contacts DROP COLUMN CompanyID;

ALTER TABLE contacts
    ADD COLUMN CompanyID INT(10),
    ADD FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID);

UPDATE contacts
    INNER JOIN Company
    ON contacts.Company = Company.Company
    SET Contacts.CompanyID = Company.CompanyID;

ALTER TABLE contacts DROP COLUMN Company;

