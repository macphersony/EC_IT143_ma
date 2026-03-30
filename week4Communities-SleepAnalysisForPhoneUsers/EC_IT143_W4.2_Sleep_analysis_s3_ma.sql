-- Question:
-- What is the average sleep time by gender?


-- Step 1: Group data by Gender
-- Step 2: Calculate average sleep_time


SELECT 
    Gender,
    AVG(sleep_time) AS avg_sleep_time
FROM [EC_IT143_DA].[dbo].[Sleep_Analysis]
GROUP BY Gender;