DROP DATABASE IF EXISTS stamps;

CREATE DATABASE stamps;

use stamps;

CREATE TABLE Albums (
volume INT,
number INT,
pages INT,
PRIMARY KEY (volume, number)
);

INSERT INTO Albums VALUES (1, 1, 20);
INSERT INTO Albums VALUES (1, 2, 15);

CREATE TABLE Themes (
code CHAR(2) PRIMARY KEY,
description VARCHAR(35)
);

INSERT INTO Themes VALUES ('sp', 'Space');
INSERT INTO Themes VALUES ('pr', 'Presidents');

CREATE TABLE Stamps (
scott VARCHAR(15) PRIMARY KEY,
country CHAR(25),
description VARCHAR(35),
year INT,
volume INT,
number INT,
FOREIGN KEY (volume, number) REFERENCES Albums (volume, number)
);

INSERT INTO Stamps VALUES ('1234', 'USA', 'Lunar Landing', 1989, 1, 1);
INSERT INTO Stamps VALUES ('2345', 'USSR', 'First Man on Space', 1984, 1, 1);
INSERT INTO Stamps VALUES ('3456', 'US', 'Lincoln', 1920, 1, 2);

CREATE TABLE StampThemes (
scott VARCHAR(15),
code CHAR(2),
PRIMARY KEY (scott, code),
FOREIGN KEY (scott) REFERENCES Stamps (scott),
FOREIGN KEY (code) REFERENCES Themes (code)
);

INSERT INTO StampThemes VALUES ('1234', 'sp');
INSERT INTO StampThemes VALUES ('2345', 'sp');
INSERT INTO StampThemes VALUES ('3456', 'pr');