USE finalproject;
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee
(
    EmployeeID int(10) NOT NULL AUTO_INCREMENT,
    Employee varchar(3) NOT NULL,
    PRIMARY KEY(EmployeeID)
) AS
    SELECT DISTINCT Employee
    FROM invoiceforms
    ORDER BY Employee;

#ALTER TABLE invoiceforms DROP COLUMN EmployeeID;

ALTER TABLE invoiceforms
    ADD COLUMN EmployeeID INT(10),
    ADD FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);

UPDATE invoiceforms
    INNER JOIN Employee
    ON invoiceforms.Employee = Employee.Employee
    SET invoiceforms.EmployeeID = Employee.EmployeeID;

ALTER TABLE invoiceforms DROP COLUMN Employee;
