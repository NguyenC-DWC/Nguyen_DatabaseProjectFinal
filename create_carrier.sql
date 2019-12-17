USE finalproject;
DROP TABLE IF EXISTS Carrier;

CREATE TABLE Carrier
(
    CarrierID int(10) NOT NULL AUTO_INCREMENT,
    Carrier char(6) NOT NULL,
    PRIMARY KEY(CarrierID)
) AS
    SELECT DISTINCT Carrier
    FROM invoiceforms
    ORDER BY Carrier;

#ALTER TABLE invoiceforms DROP COLUMN CarrierID;

ALTER TABLE invoiceforms
    ADD COLUMN CarrierID INT(10),
    ADD FOREIGN KEY (CarrierID) REFERENCES Carrier(CarrierID);

UPDATE invoiceforms
    INNER JOIN Carrier
    ON invoiceforms.Carrier = Carrier.Carrier
    SET invoiceforms.CarrierID = Carrier.CarrierID;

ALTER TABLE invoiceforms DROP COLUMN Carrier;
