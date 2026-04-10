-- I am running a Zero results expected test
-- This query looks for discrepancies. 0 rows = Success.
SELECT * FROM [dbo].[t_w3_schools_customers]
WHERE LEFT(ContactName, CHARINDEX(' ', ContactName + ' ') - 1) <> dbo.fn_get_first_name(ContactName);