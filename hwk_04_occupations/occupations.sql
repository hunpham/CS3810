-- occupations database
-- created at: Feb 23 2021
-- author: Hung Pham

CREATE DATABASE occupations;

USE occupations;

DROP TABLE IF EXISTS Occupations;

-- TODO: create table Occupations

CREATE TABLE Occupations (
    code        VARCHAR(10) PRIMARY KEY,
    occupations VARCHAR(110),
    jobFamily   VARCHAR(50)
);

-- TODO: populate table Occupations

LOAD DATA INFILE '/var/lib/mysql-files/occupations.csv' 
INTO TABLE Occupations FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

-- TODO: a) the total number of occupations (expect 1016).
SELECT COUNT(*) FROM Occupations;

-- TODO: b) a list of all job families in alphabetical order (expect 23).
SELECT DISTINCT jobFamily FROM Occupations ORDER BY 1;

-- TODO: c) the total number of job families (expect 23)
SELECT COUNT(DISTINCT jobFamily) FROM Occupations;

-- TODO: d) the total number of occupations per job family in alphabetical order of job family.
SELECT jobFamily, COUNT(*) FROM Occupations GROUP BY jobFamily ORDER BY 1;

-- TODO: e) the number of occupations in the "Computer and Mathematical" job family (expect 38)
SELECT COUNT(*) FROM Occupations WHERE occupations = "Computer and Mathematical";

-- TODO: f) an alphabetical list of occupations in the "Computer and Mathematical" job family.
SELECT DISTINCT occupations FROM Occupations WHERE jobFamily = "Computer and Mathematical" ORDER BY 1;

-- TODO: g) an alphabetical list of occupations in the "Computer and Mathematical" job family that begins with the word "Database"
SELECT DISTINCT occupations FROM Occupations WHERE jobFamily = "Computer and Mathematical" AND occupations LIKE 'Database%';