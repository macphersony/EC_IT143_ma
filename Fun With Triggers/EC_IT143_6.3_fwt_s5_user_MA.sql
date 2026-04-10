-- Test to see if the User is captured
UPDATE dbo.t_w3_schools_customers 
SET ContactName = 'Maria A.' 
WHERE CustomerID = 1;

SELECT CustomerID, ContactName, last_modified_date, last_modified_by 
FROM dbo.t_w3_schools_customers WHERE CustomerID = 1;