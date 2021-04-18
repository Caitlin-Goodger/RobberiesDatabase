--StepWise

CREATE VIEW robberiesSecurity as (
    SELECT b.bankname, b.city, b.security, r.amount
    FROM banks b
    JOIN robberies r on b.bankname = r.bankname and b.city = r.city
    ORDER BY b.security
);

CREATE VIEW robberiesByLevel as (
    SELECT security as SecurityLevel, COUNT(security) as TotalRobberies, AVG(amount) as averageAmountStolen
    FROM robberiesSecurity
    GROUP BY security
    ORDER BY TotalRobberies DESC
);

SELECT * FROM robberiesByLevel;

--Single Nested Query

SELECT security as SecurityLevel, COUNT(security) as TotalRobberies, AVG(amount) as averageAmountStolen
FROM (SELECT b.bankname, b.city, b.security, r.amount FROM Banks b JOIN robberies r on b.bankname = r.bankname and b.city = r.city ORDER BY b.security) as RobbberiesBySecurity
GROUP BY security
ORDER BY TotalRobberies DESC;