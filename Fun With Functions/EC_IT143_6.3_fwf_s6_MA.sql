--  Testing my new function against the raw logic
SELECT ContactName, 
       LEFT(ContactName, CHARINDEX(' ', ContactName + ' ') - 1) AS ad_hoc_logic,
       dbo.fn_get_first_name(ContactName) AS function_result
FROM [dbo].[t_w3_schools_customers];