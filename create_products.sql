USE finalproject;
DROP TABLE IF EXISTS InvoiceItems;
DROP TABLE IF EXISTS Products;

CREATE TABLE Products
(
    ProductID int(10) NOT NULL AUTO_INCREMENT,
    PartNumber char(15) NOT NULL,
    ProductName varchar(100) NOT NULL,
    ProductWeight int(10) NOT NULL,
    UnitDimensions char(10) NOT NULL,
    PricePerUnit float(10) NOT NULL,
    Taxable char(1) NOT NULL,
    PRIMARY KEY(ProductID)
) AS
SELECT DISTINCT PartNumber, ProductName, ProductWeight, UnitDimensions, Price AS PricePerUnit, Taxable
FROM invoices;

CREATE TABLE InvoiceItems
(
    InvoiceID int(10),
    InvoiceNumber varchar(8),
    ProductsID int(10),
    PartNumber char(15),
    PriceAtTime float(10),
    Quantity int(10),
    TaxableAtTime char(1),
    FOREIGN KEY (InvoiceID) REFERENCES invoiceforms(InvoiceID),
    FOREIGN KEY (ProductsID) REFERENCES Products(ProductID)
) AS
SELECT InvoiceID AS InvoiceNumber, PartNumber, Price AS PriceAtTime, Quantity
FROM invoices;

UPDATE InvoiceItems
INNER JOIN invoiceforms
ON InvoiceItems.InvoiceNumber = invoiceforms.InvoiceNumber
SET InvoiceItems.InvoiceID = invoiceforms.InvoiceID;

UPDATE InvoiceItems
INNER JOIN Products
ON InvoiceItems.PartNumber = Products.PartNumber
SET InvoiceItems.ProductsID = Products.ProductID;

ALTER TABLE InvoiceItems
DROP COLUMN InvoiceNumber,
DROP COLUMN PartNumber;

UPDATE InvoiceItems
INNER JOIN Products
ON InvoiceItems.ProductsID = Products.ProductID
SET InvoiceItems.TaxableAtTime = Products.Taxable;

DROP TABLE invoices;