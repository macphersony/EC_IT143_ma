
SELECT CustomerID, ContactName, City, last_modified_date, last_modified_by 
FROM dbo.t_w3_schools_customers WHERE CustomerID = 1;


UPDATE dbo.t_w3_schools_customers 
SET City = 'Berlin-West' 
WHERE CustomerID = 1;

SELECT CustomerID, ContactName, City, last_modified_date, last_modified_by 
FROM dbo.t_w3_schools_customers WHERE CustomerID = 1;