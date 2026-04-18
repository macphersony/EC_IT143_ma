--1.Before Creating NonClustered Index
SELECT pa.*
FROM Person.Address AS pa
WHERE pa.city = 'Bothell'

--2.Creating my Non-Clustered Index on person.Addrees Table
USE AdventureWorks2025
GO

CREATE NONCLUSTERED INDEX [IX_my_Index]
ON [Person].[Address] ([City]) 

GO

--3.Running the select query again  with the index created

SELECT pa.*
FROM Person.Address AS pa
WHERE pa.city = 'Bothell'
