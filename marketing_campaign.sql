SELECT *
FROM marketing_campaign1;

-- ID was spelt incorrectly, so it must be changed
ALTER TABLE marketing_campaign1
RENAME COLUMN ï»¿ID TO ID

SELECT * 
FROM marketing_campaign1

-- Overall campaign response rate
SELECT 
    COUNT(*) AS total_customers,
    SUM(Response) AS total_responses,
    ROUND(AVG(Response), 2) AS response_rate
FROM marketing_campaign1

-- Campaign response by education level
SELECT 
    Education,
    COUNT(*) AS total_customers,
    SUM(Response) AS total_responses,
    ROUND(AVG(Response), 2) AS response_rate
FROM marketing_campaign1
GROUP BY Education
ORDER BY response_rate DESC

-- Income and campaign response
SELECT 
    CASE 
        WHEN Income < 30000 THEN 'Low Income'
        WHEN Income BETWEEN 30000 AND 60000 THEN 'Middle Income'
        ELSE 'High Income'
    END AS income_group,
    COUNT(*) AS total_customers,
    SUM(Response) AS total_responses,
    ROUND(AVG(Response), 2) AS response_rate
FROM marketing_campaign1
WHERE Income IS NOT NULL
GROUP BY income_group
ORDER BY response_rate DESC

-- Product spending and campaign response
SELECT 
    Response,
    AVG(MntWines + MntFruits + MntMeatProducts + 
        MntFishProducts + MntSweetProducts + MntGoldProds) 
        AS avg_total_spending
FROM marketing_campaign1
GROUP BY Response

-- Household structure and response
SELECT 
    Kidhome,
    Teenhome,
    COUNT(*) AS total_customers,
    SUM(Response) AS total_responses,
    ROUND(AVG(Response), 2) AS response_rate
FROM marketing_campaign1
GROUP BY Kidhome, Teenhome
ORDER BY response_rate DESC

-- Customer engagement and response
SELECT 
    Response,
    AVG(NumWebVisitsMonth) AS avg_web_visits,
    AVG(NumStorePurchases) AS avg_store_purchases,
    AVG(NumWebPurchases) AS avg_web_purchases
FROM marketing_campaign1
GROUP BY Response

CREATE VIEW vw_marketing_campaign1_full AS
SELECT
    ID,
    Education,
    Marital_Status,
    Income,
    Kidhome,
    Teenhome,
    Response,

    -- Income group
    CASE
        WHEN Income < 30000 THEN 'Low Income'
        WHEN Income BETWEEN 30000 AND 60000 THEN 'Middle Income'
        ELSE 'High Income'
    END AS income_group,

    -- Total spending per customer
    (MntWines + MntFruits + MntMeatProducts +
     MntFishProducts + MntSweetProducts + MntGoldProds)
     AS total_spending,
     
      COUNT(*) AS total_customers,
    SUM(Response) AS total_responses,
    ROUND(AVG(Response * 1.0), 2) AS response_rate,
    ROUND(AVG(Income), 2) AS avg_income

    -- Engagement metrics
    NumWebVisitsMonth,
    NumStorePurchases,
    NumWebPurchases

FROM marketing_campaign1
WHERE Income IS NOT NULL;

SELECT *
FROM vw_marketing_campaign1_full;





