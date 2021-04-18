SELECT a.robberid, r.nickname, SUM(a.Share) AS Earnings FROM accomplices a, robbers r WHERE r.robberid = a.robberid GROUP BY a.robberid, r.nickname HAVING SUM(a.share) > 30000 ORDER BY SUM(a.Share) DESC;

