-- CS3810 - Principles of Database Systems - Spring 2021
-- Instructor: Thyago Mota
-- Description: job_skills database script
-- Student(s) Name(s): Hung Pham

-- database creation and use

CREATE DATABASE skills;

USE skills;

-- DROP TABLE IF EXISTS Positions;
-- DROP TABLE IF EXISTS Skills;
-- DROP TABLE IF EXISTS PosSkills;
-- DROP TABLE IF EXISTS TestTable;

-- tables creation
CREATE TABLE PosSkills (
    posId       INT NOT NULL,
    skillId     INT NOT NULL,
    PRIMARY KEY (posId, skillId)
);

CREATE TABLE Positions (
    posId       INT NOT NULL,
    position    VARCHAR(110),
    PRIMARY KEY (posId)
);

CREATE TABLE SkillsDesc (
    skillId     INT AUTO_INCREMENT NOT NULL,
    skill       VARCHAR(110),
    PRIMARY KEY (skillId)
);

-- data access
CREATE USER 'job_skills' IDENTIFIED BY 'HungPh000?';
CREATE USER 'job_skills_admin' IDENTIFIED BY 'HungPh111?';
GRANT SELECT ON TABLE skills.* TO 'job_skills';
GRANT ALL ON TABLE skills.* TO 'job_skills_admin';

-- queries

-- a) what is the total number of job positions?
SELECT COUNT(*) AS "Total Positions" FROM Positions;
-- b) what is the total number of skills?
SELECT COUNT(skill) AS "Total Skills" FROM SkillsDesc;
-- c) which job position titles have the word "database"?
SELECT Positions.position FROM Positions WHERE Positions.position LIKE '%database%';
-- d) provide an alphabetical list of all job position titles that require "sql" or "mysql" as a skill.
SELECT Positions.position FROM PosSkills JOIN SkillsDesc ON SkillsDesc.skillId = PosSkills.skillId JOIN Positions ON Positions.posId = PosSkills.posId WHERE Positions.posId = PosSkills.posId AND SkillsDesc.skill = "sql" OR SkillsDesc.skill = "mysql" ORDER BY 1;
-- e) which skills "database analyst" like positions have that "database admin" like positions don't?
SELECT SkillsDesc.skill FROM PosSkills JOIN SkillsDesc ON SkillsDesc.skillId = PosSkills.skillId JOIN Positions ON Positions.posId = PosSkills.posId WHERE position LIKE "%database analyst%" and position NOT LIKE "%database admin%";
-- f) list the top 20 skills required by job positions having the word "database" in their titles.
SELECT skillId, COUNT(skillId) FROM PosSkills JOIN Positions ON Positions.posId = PosSkills.posId WHERE position LIKE "%database%" GROUP BY skillId ORDER BY 2 DESC LIMIT 20;

-- Reflection: The skills I've developed in CS3810 so far is definitely 177:mysql and 1106:database design. I didn't even touch anything related to database before the class,

