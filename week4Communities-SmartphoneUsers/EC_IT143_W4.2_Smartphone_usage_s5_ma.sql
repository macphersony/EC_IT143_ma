 -- Question:
-- How many records are in my community table?

--Answer -Step 1: Count rows
-- Step 2: Return total number

SELECT COUNT(*) AS total_records
FROM dbo.Smartphone_Usage_And_Addiction_Analysis_7500_Rows;

CREATE VIEW v_table1_count
AS
SELECT COUNT(*) AS total_records
FROM dbo.Smartphone_Usage_And_Addiction_Analysis_7500_Rows

SELECT *
INTO t_table1_count
FROM v_table1_count;
