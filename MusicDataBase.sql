-- Group 14

-- 1. Create view for employee information
DROP VIEW IF EXISTS employee_info;
CREATE VIEW employee_info AS
SELECT 
    firstName, 
    lastName, 
    employeeNumber
FROM 
    employees
WHERE 
    firstName IS NOT NULL;

SELECT * FROM employee_info;

-- 2. Create view for employees in France
DROP VIEW IF EXISTS france_employee_info;
CREATE VIEW france_employee_info AS
SELECT 
    e.firstName, 
    e.lastName, 
    e.employeeNumber, 
    o.country
FROM 
    employees e
JOIN 
    offices o ON e.officeCode = o.officeCode
WHERE 
    o.country = 'France';

SELECT * FROM france_employee_info;

-- 3. Create view for employees in the USA
DROP VIEW IF EXISTS USA_employee_info;
CREATE VIEW USA_employee_info AS
SELECT 
    e.firstName, 
    e.lastName, 
    e.employeeNumber, 
    o.country
FROM 
    employees e
JOIN 
    offices o ON e.officeCode = o.officeCode
WHERE 
    o.country = 'USA';

SELECT * FROM USA_employee_info;

-- 4. Create view for employees in Boston
DROP VIEW IF EXISTS boston_employee_info;
CREATE VIEW boston_employee_info AS
SELECT 
    e.firstName, 
    e.lastName, 
    e.employeeNumber, 
    o.city
FROM 
    employees e
JOIN 
    offices o ON e.officeCode = o.officeCode
WHERE 
    o.city = 'Boston';

SELECT * FROM boston_employee_info;

-- 5. Create view for customers whose names start with 'D'
DROP VIEW IF EXISTS D_customer_info;
CREATE VIEW D_customer_info AS
SELECT 
    customerName
FROM 
    customers
WHERE 
    customerName LIKE 'D%';

SELECT * FROM D_customer_info;

-- 6. Create view for customers outside the USA
DROP VIEW IF EXISTS usa_customer_info;
CREATE VIEW usa_customer_info AS
SELECT 
    customerName, 
    country
FROM 
    customers
WHERE 
    country != 'USA';

SELECT * FROM usa_customer_info;

-- 7. Create view for products with buy price between 20 and 100
DROP VIEW IF EXISTS product_info;
CREATE VIEW product_info AS
SELECT 
    buyPrice
FROM 
    products
WHERE 
    buyPrice BETWEEN 20 AND 100;

SELECT * FROM product_info;
