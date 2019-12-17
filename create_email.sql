USE finalproject;
DROP TABLE IF EXISTS Email;
DROP TABLE IF EXISTS EmailType;

CREATE TABLE EmailType
(
    EmailTypeID int(10) NOT NULL AUTO_INCREMENT,
    EmailType varchar(15) NOT NULL,
    PRIMARY KEY (EmailTypeID)
);

INSERT INTO EmailType(EmailType) VALUE ('Work');

CREATE TABLE Email
(
    ContactID int(10) NOT NULL,
    Email varchar(40) NOT NULL,
    EmailTypeID int(10) DEFAULT 1,
    FOREIGN KEY (ContactID) REFERENCES contacts(ContactID),
    FOREIGN KEY (EmailTypeID) REFERENCES EmailType(EmailTypeID)
) AS
    SELECT DISTINCT ContactID,Email
    from contacts;

ALTER TABLE contacts DROP COLUMN Email;


