USE finalproject;
DROP TABLE IF EXISTS ShipStatus;

CREATE TABLE ShipStatus
(
    ShipStatusID int(10) NOT NULL AUTO_INCREMENT,
    ShipStatus char(10) NOT NULL,
    PRIMARY KEY(ShipStatusID)
) AS
    SELECT DISTINCT ShipStatus
    FROM invoiceforms
    ORDER BY ShipStatus;

#ALTER TABLE invoiceforms DROP COLUMN ShipStatusID;

ALTER TABLE invoiceforms
    ADD COLUMN ShipStatusID INT(10),
    ADD FOREIGN KEY (ShipStatusID) REFERENCES ShipStatus(ShipStatusID);

UPDATE invoiceforms
    INNER JOIN ShipStatus
    ON invoiceforms.ShipStatus = ShipStatus.ShipStatus
    SET invoiceforms.ShipStatusID = ShipStatus.ShipStatusID;

ALTER TABLE invoiceforms DROP COLUMN ShipStatus;
