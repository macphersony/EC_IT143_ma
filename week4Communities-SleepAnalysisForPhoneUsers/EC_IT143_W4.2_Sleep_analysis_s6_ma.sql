-- Question:
-- What is the average sleep time by gender?


-- Step 1: Group data by Gender
-- Step 2: Calculate average sleep_time


SELECT 
    Gender,
    AVG(sleep_time) AS avg_sleep_time
FROM [EC_IT143_DA].[dbo].[Sleep_Analysis]
GROUP BY Gender;


CREATE VIEW v_sleep_avg_by_gender
AS
SELECT 
    Gender,
    AVG(sleep_time) AS avg_sleep_time
FROM [EC_IT143_DA].[dbo].[Sleep_Analysis]
GROUP BY Gender;



SELECT *
INTO t_sleep_avg_by_gender
FROM v_sleep_avg_by_gender;



DROP TABLE IF EXISTS t_sleep_avg_by_gender;

CREATE TABLE t_sleep_avg_by_gender (
    Gender VARCHAR(20) NOT NULL,
    avg_sleep_time FLOAT NOT NULL,
    PRIMARY KEY (Gender)
);



TRUNCATE TABLE t_sleep_avg_by_gender;

INSERT INTO t_sleep_avg_by_gender (Gender, avg_sleep_time)
SELECT Gender, avg_sleep_time
FROM v_sleep_avg_by_gender;