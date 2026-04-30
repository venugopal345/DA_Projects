create database hr_project;
use hr_project;
SELECT * FROM hr_1 LIMIT 5;
select * from hr_2 limit 5;

-- KPI 1. Average attrition rate for all departments
SELECT 
    Department,
    concat(round(AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100, 2) ,"%") AS Attrition_Rate_Percentage
FROM hr_1
GROUP BY Department;


-- KPI 2. Average Hourly Rate of Male Research Scientist
SELECT 
    ROUND(AVG(HourlyRate), 2) AS Avg_Hourly_Rate
FROM hr_1
WHERE Gender = 'Male'
AND JobRole = 'Research Scientist';


-- KPI 3: Attrition Rate vs Monthly Income Status
SELECT
    CASE
        WHEN h2.MonthlyIncome < 10000 THEN 'Low Income'
        WHEN h2.MonthlyIncome BETWEEN 10000 AND 25000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS Income_Status,
   concat(ROUND(AVG(CASE WHEN h1.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100, 2) ,"%") AS Attrition_Rate_Percentage
FROM hr_1 h1
JOIN hr_2 h2
ON h1.`Employee ID`= h2.`Employee_ID`
GROUP BY Income_Status;


-- KPI 4. Average working year for each Department
SELECT
    h1.Department,
    ROUND(AVG(h2.TotalWorkingYears), 2) AS Avg_Working_Years
FROM hr_1 h1
JOIN hr_2 h2
ON h1.`Employee ID`= h2.`Employee_ID`
GROUP BY h1.Department;


-- KPI 5. JOb Role VS Work Life Balance
SELECT
    h1.JobRole,
    ROUND(AVG(h2.WorkLifeBalance), 2) AS Avg_WorkLife_Balance
FROM hr_1 h1
JOIN hr_2 h2
ON h1.`Employee ID`= h2.`Employee_ID`
GROUP BY h1.JobRole
order by Avg_WorkLife_Balance;


-- KPI 6. Attrition rate Vs Year since last promotion relation
SELECT
    h2.YearsSinceLastPromotion,
    ROUND(AVG(CASE WHEN h1.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100, 2) AS Attrition_Rate_Percentage
FROM hr_1 h1
JOIN hr_2 h2
ON h1.`Employee ID`= h2.`Employee_ID`
GROUP BY h2.YearsSinceLastPromotion
ORDER BY h2.YearsSinceLastPromotion;












