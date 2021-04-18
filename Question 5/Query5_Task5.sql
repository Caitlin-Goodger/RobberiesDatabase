--Step wise

CREATE VIEW earnings as (
select robberid, COUNT(RobberId) as totalrobberies, Sum(Share) as totalearnings
from accomplices
GROUP BY robberid
                        );

CREATE VIEW activeRobbers as (
    SELECT * from earnings
    WHERE totalrobberies > (select AVG(totalrobberies) as total_robberies from earnings)
                             );

CREATE VIEW nicknames as (
    SELECT r.RobberId, r.Nickname
    from activeRobbers a
    JOIN robbers r on a.robberid = r.robberid
    WHERE r.noyears = 0
    ORDER BY totalearnings DESC
                         );
SELECT nickname from nicknames;

-- Single Nested Query

SELECT nickname
FROM
(SELECT *
FROM (SELECT robberid,
COUNT(robberid) as totalrobberies,
SUM(share) as totalearnings
FROM accomplices
GROUP BY robberid) as earnings
WHERE totalrobberies > (SELECT AVG (totalrobberies)
FROM (select robberid,
COUNT(robberid) as totalrobberies,
SUM(share) as totalearnings
from accomplices
GROUP BY robberid) as earnings)) as activeRobbers
JOIN robbers r
ON r.robberid = activeRobbers.robberid
WHERE r.noyears = 0
ORDER BY totalearnings DESC;