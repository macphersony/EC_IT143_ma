-- If the function is perfect, this should return 0 rows.
SELECT * FROM [dbo].[t_w3_schools_customers]
WHERE LTRIM(SUBSTRING(ContactName, CHARINDEX(' ', ContactName + ' '), LEN(ContactName))) <> dbo.fn_get_last_name(ContactName);