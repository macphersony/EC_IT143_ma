-- Checking the new function against the ad hoc test
SELECT ContactName, 
       LTRIM(SUBSTRING(ContactName, CHARINDEX(' ', ContactName + ' '), LEN(ContactName))) AS ad_hoc_result,
       dbo.fn_get_last_name(ContactName) AS udf_result
FROM [dbo].[t_w3_schools_customers];