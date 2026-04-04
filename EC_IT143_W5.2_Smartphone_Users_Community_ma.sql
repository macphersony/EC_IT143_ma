/*****************************************************************************************************************
NAME:    Smartphone usage and Addiction
PURPOSE: The purpose of this dataset is to show how smartphone usage leads to addiction and affects productivity and sleep health

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     04/4/2026   MAGHAH      1. Built this script for EC IT440


RUNTIME: 
X0 X0.4s

NOTES: 
This script was built to answer questions pertaining my dataset on Smartphone usage . Questions from my colleagues and myself.
 
******************************************************************************************************************/

-- Q1:  If we want to evaluate the study-life balance, knowing that addiction can reduce productive time, 
--what is the average time spent on social media (social_media_hours) compared to work/study hours (work_study_hours), 
--by giving this ratio for each addiction label (addicted_label)?  By Davidson charles

-- A1: For addicted users,they are spending more time scrolling than learning.For every 1 hour of studying, they spend 1 hour and 8 minutes on social media. 

SELECT 
    [addicted_label],
    ROUND(AVG(CAST([social_media_hours] AS FLOAT)), 2) AS Avg_Social_Media_Hours,
    ROUND(AVG(CAST([work_study_hours] AS FLOAT)), 2) AS Avg_Work_Study_Hours,
    
    ROUND(AVG(CAST([social_media_hours] AS FLOAT)) / 
          NULLIF(AVG(CAST([work_study_hours] AS FLOAT)), 0), 2) AS Social_to_Work_Ratio
FROM [EC_IT143_DA].[dbo].[Smartphone_Usage_And_Addiction_Analysis_7500_Rows]
GROUP BY [addicted_label]
ORDER BY Social_to_Work_Ratio DESC;

--Q2:  I want to understand the impact of gaming on sleep, knowing that i'm a focusing on heavy gamers (more than 3 hours of gaming_hours), 
--what is the average sleep duration (sleep_hours),
--by giving a breakdown by gender to see if there is a difference between male and female users? By Davidson Charles

--A:Regardless of gender, heavy gamers in my dataset are averaging between 6.6 and 6.9 hours of sleep.
--This is slightly below the recommended 7–8 hours of sleep but isn't gender related
SELECT 
    [gender], 
    ROUND(AVG(CAST([sleep_hours] AS FLOAT)), 2) AS Avg_Sleep_Hours,
    COUNT(*) AS Total_Heavy_Gamers
FROM [EC_IT143_DA].[dbo].[Smartphone_Usage_And_Addiction_Analysis_7500_Rows]
WHERE CAST([gaming_hours] AS FLOAT) > 3
GROUP BY [gender]
ORDER BY Avg_Sleep_Hours DESC;

--Q3:Does a high number of daily notifications actually lead to higher stress, or are we just used to them by now? By ME
--A: No significant impact on stress-level by the number of notifications, maybe the source of the ping matters more than the sheer volume.
SELECT 
    [stress_level], 
    COUNT(*) AS Total_Users,
    ROUND(AVG(CAST([notifications_per_day] AS FLOAT)), 0) AS Avg_Daily_Notifications
FROM [EC_IT143_DA].[dbo].[Smartphone_Usage_And_Addiction_Analysis_7500_Rows]
GROUP BY [stress_level]
ORDER BY Avg_Daily_Notifications DESC;

--Q4: "Is it true that the younger you are, the more you use your phone? What is the average daily screen time for each age group?" By ME
--A: I have discovered that in this dataset, age doesn't actually matter as everyone is equally glued to their screens these days.

SELECT TOP 10
    [age], 
    COUNT(*) AS Total_Users,
    ROUND(AVG(CAST([daily_screen_time_hours] AS FLOAT)), 2) AS Avg_Screen_Time
FROM [EC_IT143_DA].[dbo].[Smartphone_Usage_And_Addiction_Analysis_7500_Rows]
GROUP BY [age]
ORDER BY [age] ASC;

SELECT GETDATE() AS my_date;