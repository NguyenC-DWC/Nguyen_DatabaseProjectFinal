USE finalproject;
DROP TABLE IF EXISTS Title;

CREATE TABLE Title
(
    TitleID int(10) NOT NULL AUTO_INCREMENT,
    Title varchar(8),
    PRIMARY KEY(TitleID)
) AS
    SELECT DISTINCT Title
    FROM contacts
    WHERE Title != '';

#ALTER TABLE contacts DROP COLUMN TitleID;

ALTER TABLE contacts
    ADD COLUMN TitleID INT(10),
    ADD FOREIGN KEY (TitleID) REFERENCES Title(TitleID);

UPDATE contacts
    INNER JOIN Title
    ON contacts.Title = Title.Title
    SET Contacts.TitleID = Title.TitleID;

ALTER TABLE contacts DROP COLUMN Title;

