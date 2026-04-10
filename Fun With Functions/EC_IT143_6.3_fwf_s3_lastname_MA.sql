-- Testing the raw logic before making the tool
SELECT ContactName, 
       LTRIM(SUBSTRING(ContactName, CHARINDEX(' ', ContactName + ' '), LEN(ContactName))) AS last_name
FROM [dbo].[t_w3_schools_customers];