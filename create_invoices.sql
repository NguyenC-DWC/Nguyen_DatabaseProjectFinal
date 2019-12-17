USE finalproject;
DROP TABLE IF EXISTS InvoiceForms;

CREATE TABLE InvoiceForms
(
    InvoiceID int(10) NOT NULL AUTO_INCREMENT,
    InvoiceNumber varchar(8) NOT NULL,
    DateCreated date,
    Employee varchar(3),
    Carrier char(6),
    ShipDate date,
    ShipStatus char(10),
    TaxRateAtTime int(10),
    DiscountRateAtTime int(10),
    Notes varchar(255),
    ShippingContactsID int(10),
    ShippingAddress1 varchar(30),
    ShippingAddress2 varchar(30),
    ShippingPostalID int(10),
    ShippingCityID int(10),
    ShippingStateID int(10),
    ShippingCountryID int(10),
    BillingContactsID int(10),
    BillingAddress1 varchar(30),
    BillingAddress2 varchar(30),
    BillingPostalID int(10),
    BillingCityID int(10),
    BillingStateID int(10),
    BillingCountryID int(10),
    PRIMARY KEY(InvoiceID),
    FOREIGN KEY(ShippingContactsID) REFERENCES contacts(ContactID),
    FOREIGN KEY(BillingContactsID) REFERENCES contacts(ContactID),
    FOREIGN KEY(ShippingPostalID) REFERENCES PostalCode(PostalCodeID),
    FOREIGN KEY(ShippingCityID) REFERENCES City(CityID),
    FOREIGN KEY(ShippingStateID) REFERENCES State(StateID),
    FOREIGN KEY(ShippingCountryID) REFERENCES Country(CountryID),
    FOREIGN KEY(BillingPostalID) REFERENCES PostalCode(PostalCodeID),
    FOREIGN KEY(BillingCityID) REFERENCES City(CityID),
    FOREIGN KEY(BillingStateID) REFERENCES State(StateID),
    FOREIGN KEY(BillingCountryID) REFERENCES Country(CountryID)
) AS
    SELECT InvoiceID AS InvoiceNumber, CreatedBy AS Employee, ShipVia AS Carrier, ShipDate, ShipmentStatus AS ShipStatus, TaxRate AS TaxRateAtTime, DiscountRate AS DiscountRateAtTime
    FROM invoices;

DROP TABLE IF EXISTS ContactInvoiceTemp;

CREATE TABLE ContactInvoiceTemp
(
    ContactID int(10),
    FirstName varchar(30),
    LastName varchar(30),
    InvoiceNumber varchar(8)
) AS
    SELECT FirstName,LastName, InvoiceID AS InvoiceNumber
    FROM invoices;

UPDATE ContactInvoiceTemp
    INNER JOIN contacts
    ON ContactInvoiceTemp.FirstName = Contacts.FirstName AND ContactInvoiceTemp.LastName = Contacts.LastName
    SET ContactInvoiceTemp.ContactID = Contacts.ContactID;

UPDATE InvoiceForms
    INNER JOIN ContactInvoiceTemp
    ON InvoiceForms.InvoiceNumber = ContactInvoiceTemp.InvoiceNumber
    SET InvoiceForms.BillingContactsID = ContactInvoiceTemp.ContactID,
        InvoiceForms.ShippingContactsID = ContactInvoiceTemp.ContactID;

DROP TABLE IF EXISTS ContactInvoiceTemp;

UPDATE InvoiceForms
    INNER JOIN contacts
    ON InvoiceForms.BillingContactsID = Contacts.ContactID
    SET InvoiceForms.BillingAddress1 = Contacts.Address1,
        InvoiceForms.BillingAddress2 = Contacts.Address2,
        InvoiceForms.BillingPostalID = Contacts.PostalCodeID,
        InvoiceForms.BillingCityID = Contacts.CityID,
        InvoiceForms.BillingStateID = Contacts.StateID,
        InvoiceForms.BillingCountryID = Contacts.CountryID;

UPDATE InvoiceForms
    INNER JOIN contacts
    ON InvoiceForms.ShippingContactsID = Contacts.ContactID
    SET InvoiceForms.ShippingAddress1 = Contacts.Address1,
        InvoiceForms.ShippingAddress2 = Contacts.Address2,
        InvoiceForms.ShippingPostalID = Contacts.PostalCodeID,
        InvoiceForms.ShippingCityID = Contacts.CityID,
        InvoiceForms.ShippingStateID = Contacts.StateID,
        InvoiceForms.ShippingCountryID = Contacts.CountryID;


