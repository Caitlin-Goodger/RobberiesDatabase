With AvgShare AS (
    SELECT City, Avg(share) as AvShare, Rank() Over(ORDER BY Avg(share) DESC) as ShareRank from accomplices a GROUP By a.city
)
SELECT r.bankname, r.city,r.date from robberies r WHERE r.city = (SELECT City from AvgShare WHERE ShareRank = 1)