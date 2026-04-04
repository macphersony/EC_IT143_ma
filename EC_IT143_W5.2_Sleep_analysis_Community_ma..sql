/*****************************************************************************************************************
NAME:    Sleep Analysis
PURPOSE: This dataset analyzes the correlation between lifestyle habits, environment, and sleep duration.

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     04/4/2026   M Aghah       1. Built this script for EC IT440


RUNTIME: 
0m 1s

NOTES: 
I built this script to answer questions about my dataset.Questions by myself and colleagues
 
******************************************************************************************************************/

-- Q1: Do people with 'Severe' addiction labels actually sleep fewer hours?  by Davidson Charles
-- A1: from the query, people that take substances have fewer sleep hours than those without any beverages.

SELECT 
    [beverage], 
    ROUND(AVG([sleep_time]), 2) AS Average_Sleep_Hours
FROM [EC_IT143_DA].[dbo].[Sleep_Analysis]
GROUP BY [beverage]
ORDER BY Average_Sleep_Hours ASC;


--Q2: In order to isolate the effect of the bedroom environment, 
--knowing that the blue light filter is turned off, 
--what is the impact of bed orientation (Sleep_Direction) on total rest hours, 
--by giving the count of participants for each direction? By Davidson Charles
--A:Participants that sleep north and south directions have higher sleep hours than east-west bound.
SELECT 
    [sleep_direction], 
    COUNT(*) AS Participant_Count,
    ROUND(AVG([sleep_time]), 2) AS Average_Sleep_Hours
FROM [EC_IT143_DA].[dbo].[Sleep_Analysis]
WHERE [bluelight_filter] = 0
GROUP BY [sleep_direction]
ORDER BY Average_Sleep_Hours DESC;

--Q3:Is there a link between smoking/drinking habits and daily screen time? By Davidson Charles
--A:There is no strong link because the data shows that smoking/drinking habits have almost zero impact on screen time. 
--Both groups are averaging roughly 7.4 hours a day.I had to join my two tables to answer this one.
SELECT 
    S.smoke_drink, 
    ROUND(AVG(CAST(U.daily_screen_time_hours AS FLOAT)), 2) AS Avg_Screen_Time,
    COUNT(U.user_id) AS Total_Users_In_Group
FROM [EC_IT143_DA].[dbo].[Sleep_Analysis] S
JOIN [EC_IT143_DA].[dbo].[Smartphone_Usage_And_Addiction_Analysis_7500_Rows] U 
    ON S.[Age] = U.[age]
GROUP BY S.smoke_drink
ORDER BY Avg_Screen_Time DESC;

--Q4: Who actually gets more Sleep_Time on average between people who use a Blue Light Filter and those who don't? By ME
--A: No signficant difference, infact those without the filter sleep more from the dataset,
--Maybe people with the filter feel safe using their phones even longer, which ends up cutting into their sleep time.
SELECT 
    [bluelight_filter], 
    COUNT(*) AS Total_Users,
    ROUND(AVG(CAST([sleep_time] AS FLOAT)), 2) AS Avg_Sleep_Hours
FROM [EC_IT143_DA].[dbo].[Sleep_Analysis]
GROUP BY [bluelight_filter];

SELECT GETDATE() AS my_date;