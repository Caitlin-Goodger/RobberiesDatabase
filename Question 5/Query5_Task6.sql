--StepWise Query
CREATE VIEW BanksAndSecurity as
(
    SELECT b.bankname, b.city, r.date, b.security
    FROM banks b
    JOIN Robberies r on b.bankname = R.bankname and b.city = R.city
);

CREATE VIEW AddAccomplices as (
    SELECT r.bankname, r.city, r.date, a.robberid, r.security
    FROM  accomplices a
    JOIN BanksAndSecurity r on r.bankname = a.bankname and r.city = a.city and r.date = a.robberydate
);

CREATE VIEW AddSkills as (
    SELECT DISTINCT r.bankname, r.city, r.date, r.security, h.skillID
    FROM hasskills h
    JOIN AddAccomplices r on h.robberid = r.robberid
);

CREATE VIEW commonSkills as (
    SELECT DISTINCT r.security, r.skillid
    FROM AddSkills r
    WHERE (SELECT COUNT(skillid) from AddSkills a  WHERE a.skillid = r.skillid AND a.security=r.security) = (SELECT COUNT(security) from BanksAndSecurity b WHERE b.security = r.security)
);

CREATE VIEW robbersWithSkills as (
    SELECT r.security, r.skillID, h.robberId
    FROM hasskills h
    JOIN commonSkills r on h.skillid = r.skillid
);

CREATE VIEW nickname as (
    SELECT r.security, r.skillID, rob.nickname
    FROM robbers rob
    JOIN robberswithskills r on rob.robberid = r.robberid
);

CREATE VIEW AddDescription as (
    SELECT r.security, r.nickname, s.description
    FROM skills s
    JOIN nickname r on s.skillid = r.skillid
);

SELECT * FROM AddDescription;


-- Single Nested Query
SELECT j.security, j.nickname, s.description FROM skills s JOIN (
SELECT i.security, i.skillId, r.nickname FROM robbers r JOIN (
SELECT q.security, q.skillID, h.robberID FROM hasskills h JOIN (
SELECT DISTINCT n.security, n.skillId FROM (
SELECT DISTINCT m.bankname, m.city, m.date, m.security, h.skillID FROM hasskills h
    JOIN (
SELECT l.bankname, l.city, l.date, a.robberId, l.security FROM accomplices a
    JOIN ( SELECT b.bankname, b.city, r.date, b.security FROM banks b JOIN robberies r on b.bankname = r.bankname and b.city = r.city) l on a.bankname = l.bankname AND a.city = l.city AND a.robberydate = l.date) m
on m.robberid = h.robberid) n WHERE (SELECT COUNT(skillid) from (SELECT DISTINCT m.bankname, m.city, m.date, m.security, h.skillID FROM hasskills h
    JOIN (
SELECT l.bankname, l.city, l.date, a.robberId, l.security FROM accomplices a
    JOIN ( SELECT b.bankname, b.city, r.date, b.security FROM banks b JOIN robberies r on b.bankname = r.bankname and b.city = r.city) l on a.bankname = l.bankname AND a.city = l.city AND a.robberydate = l.date) m
on m.robberid = h.robberid)o WHERE n.skillid = o.skillid AND n.security = o.security) = (SELECT COUNT(security) FROM (SELECT b.bankname, b.city, r.date, b.security FROM banks b JOIN robberies r on b.bankname = r.bankname and b.city = r.city)p WHERE p.security=n.security))
q on h.skillid = q.skillid) i on r.robberid = i.robberid)j on s.skillid = j.skillid;

