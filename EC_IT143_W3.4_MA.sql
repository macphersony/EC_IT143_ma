----Q1: What are the five most expensive products based on list price? ME
SELECT TOP 5 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;
----Question 2: Business User question—Marginal complexity:
----Which employees have the highest vacation hours in the company? By ORJI UGWU
SELECT TOP 5 BusinessEntityID, VacationHours 
FROM HumanResources.Employee 
ORDER BY VacationHours DESC;

----Q.3 Which sales territories had the highest total sales in 2013, 
----and how do they compare to one another? By Sifiso Mokhele
SELECT st.Name AS Territory, 
SUM(soh.TotalDue) AS TotalSales 
FROM Sales.SalesOrderHeader soh JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID 
WHERE YEAR(soh.OrderDate) = 2013 GROUP BY st.Name ORDER BY TotalSales DESC;

-----Q.4 Moderate complexity: The bike shop has several branches in different countries. 
----I live in Orlando and I'd like to know if there's a branch in the city.By Julio Ramos Salas
SELECT s.Name AS StoreName, a.City,sp.Name AS StateProvince, 
cr.Name AS Country FROM Sales.Store s 
JOIN Sales.Customer c ON s.BusinessEntityID = c.StoreID JOIN Person.BusinessEntityAddress bea 
ON s.BusinessEntityID = bea.BusinessEntityID JOIN Person.Address a 
ON bea.AddressID = a.AddressID JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID 
JOIN Person.CountryRegion cr 
ON sp.CountryRegionCode = cr.CountryRegionCode WHERE a.City LIKE '%Orlando%';

----Q.5 As a business analyst, I want to evaluate employee contribution to sales. 
--Can you create a report showing total sales per salesperson, including order count, total revenue,
--and average order value, grouped by employee and sorted by highest revenue? By Koiyan Gemah
SELECT p.FirstName + ' ' + p.LastName AS SalesPerson, COUNT(soh.SalesOrderID) AS OrderCount, 
SUM(soh.TotalDue) AS TotalRevenue, AVG(soh.TotalDue) AS AvgOrderValue
FROM Sales.SalesOrderHeader soh JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID 
JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID GROUP BY p.FirstName, p.LastName ORDER BY TotalRevenue DESC;

----Q.6 : A manager is analyzing customer demographics.
--Determine which geographic region has the highest number of repeat customers 
--who placed more than three orders.By Taiwo Kehinde
WITH CustomerOrders AS ( SELECT c.CustomerID, st.Name AS Territory, COUNT(soh.SalesOrderID) AS OrderCount 
FROM Sales.Customer c JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID JOIN Sales.SalesTerritory st 
ON soh.TerritoryID = st.TerritoryID GROUP BY c.CustomerID, st.Name ) SELECT Territory, COUNT(CustomerID) AS RepeatCustomers
FROM CustomerOrders WHERE OrderCount > 3 GROUP BY Territory ORDER BY RepeatCustomers DESC;

--Q7 Metadata question—Can you find all tables that contain a column named ProductID in the AdventureWorks database? By William George Nartey Apana
SELECT TABLE_SCHEMA, 
TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE COLUMN_NAME = 'ProductID' 
ORDER BY TABLE_SCHEMA, TABLE_NAME;

----Q8. Which table in the AdventureWorks database has the most columns defined?
--Please provide only the table name and the total count of columns associated with it.By lloyd moono

SELECT TOP 1 TABLE_SCHEMA, TABLE_NAME,
COUNT(*) AS ColumnCount
FROM INFORMATION_SCHEMA.COLUMNS 
GROUP BY TABLE_SCHEMA, TABLE_NAME 
ORDER BY ColumnCount DESC;