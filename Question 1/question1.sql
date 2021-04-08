CREATE TABLE Banks (
BankName Char (20) NOT NULL,
City Char (20) NOT NULL,
NoAccounts Integer,
Security TEXT CHECK(Security IN('excellent', 'very good', 'good', 'weak')),
PRIMARY KEY (BankName,City),
CONSTRAINT positiveAccountNo CHECK (NoAccounts > 0)
);

CREATE TABLE Robberies (
BankName Char(20) NOT NULL,
City Char (20) NOT NULL,
Date Char(20) NOT NULL ,
Amount Decimal,
PRIMARY KEY (BankName,City,Date),
FOREIGN KEY (BankName,City) REFERENCES Banks(BankName,City) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT positiveStolen CHECK (Amount > 0)
);

CREATE TABLE Plans (
BankName Char(20) NOT NULL,
City Char(20) NOT NULL,
PlannedDate Char (20) NOT NULL ,
NoRobbers Integer,
PRIMARY KEY (BankName,City,PlannedDate,NoRobbers),
FOREIGN KEY (BankName,City) REFERENCES Banks (BankName,City) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT positiveRobbers CHECK (NoRobbers > 0)
);

CREATE TABLE Robbers (
RobberId SERIAL,
NickName Char(20),
Age Integer CHECK (Age > 0),
NoYears Integer CHECK (NoYears >= 0),
PRIMARY KEY (RobberId),
CONSTRAINT prisonLessAge CHECK (NoYears < Age)
);

CREATE TABLE Skills (
SkillId SERIAL,
PRIMARY KEY (SkillId),
Description Char (20)
);

CREATE TABLE HasSkills (
RobberId Integer NOT NULL,
SkillId Integer NOT NULL,
Preference Integer,
Grade Char(20),
PRIMARY KEY (RobberId,SkillId),
FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId) ON DELETE CASCADE ON UPDATE RESTRICT,
FOREIGN KEY (SkillId) REFERENCES Skills(SkillId) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE HasAccounts (
RobberId Integer NOT NULL,
BankName Char(20) NOT NULL,
City Char(20) NOT NULL,
PRIMARY KEY (RobberId,BankName,City),
FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId) ON DELETE CASCADE ON UPDATE RESTRICT,
FOREIGN KEY (BankName,City) REFERENCES Banks(BankName,City) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE Accomplices (
RobberId Integer NOT NULL,
BankName Char(20) NOT NULL,
City Char(20) NOT NULL,
RobberyDate Char(20) NOT NULL ,
Share Integer,
PRIMARY KEY (RobberId,BankName,City,RobberyDate),
FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId) ON DELETE RESTRICT ON UPDATE RESTRICT,
FOREIGN KEY (BankName,City,RobberyDate) REFERENCES Robberies(BankName,City,Date) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT share_not_negative CHECK (Share > 0)
);