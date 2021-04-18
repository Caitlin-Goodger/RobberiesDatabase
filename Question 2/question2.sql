
copy Banks (BankName,City,NoAccounts,Security) FROM 'D:\2021\SWEN439\Project1\banks_21.data';
copy Plans(BankName,City,PlannedDate,NoRobbers) FROM 'D:\2021\SWEN439\Project1\plans_21.data';
copy Robberies(BankName,City,Date,Amount) FROM 'D:\2021\SWEN439\Project1\robberies_21.data';

CREATE TABLE tempRobbers (
    Nickname char(20),
    Age INT NOT NULL,
    NoYears INT NOT NULL
);

copy tempRobbers(Nickname,Age,NoYears) FROM 'D:\2021\SWEN439\Project1\robbers_21.data';

INSERT INTO Robbers (SELECT nextval('robbers_robberid_seq'), * FROM tempRobbers);

DROP TABLE tempRobbers;

CREATE TABLE TempHasSkills (
    Nickname Char (20),
    Description Char (20),
    Preference Integer,
    Grade Char(3),
    PRIMARY KEY (Nickname,Description)
);

copy tempHasSkills(Nickname,Description,Preference,Grade) FROM 'D:\2021\SWEN439\Project1\hasskills_21.data';

CREATE VIEW disSkill AS  SELECT DISTINCT Description from tempHasSkills;
INSERT INTO Skills (SELECT nextval('skills_skillid_seq'), Description from disSkill);

DROP VIEW disSkill;

INSERT INTO hasSkills (SELECT r.RobberId, s.SkillId, t.Preference, t.Grade FROM Robbers r, Skills s, TempHasSkills t WHERE t.Nickname = r.Nickname AND t.Description = s.description);

DROP TABLE TempHasSkills;

CREATE TABLE tempHasAccounts (
    Nickname char(20),
    BankName char(20) NOT NULL,
    City char(20) NOT NULL
);

copy tempHasAccounts(Nickname,BankName,City) FROM 'D:\2021\SWEN439\Project1\hasaccounts_21.data';

INSERT INTO hasAccounts (SELECT r.RobberId, t.BankName, t.City FROM Robbers r, tempHasAccounts t WHERE t.Nickname = r.Nickname);

DROP TABLE tempHasAccounts;


CREATE TABLE tempAccomplices(
    Nickname char(20),
    BankName char(20) NOT NULL,
    City char(20) NOT NULL,
    RobberyDate Date NOT NULL,
    Share DECIMAL(15,2)
);

copy tempAccomplices(Nickname,BankName,City,RobberyDate,Share) FROM 'D:\2021\SWEN439\Project1\accomplices_21.data';

INSERT INTO Accomplices (SELECT r.RobberId, t.BankName,t.City,t.RobberyDate, t.Share FROM Robbers r, tempAccomplices t WHERE t.Nickname = r.Nickname);

DROP TABLE tempAccomplices;

