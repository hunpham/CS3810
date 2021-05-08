-- flowers database
-- created at: Feb 25 2021
-- author(s): Hung Pham

-- database creation and use

CREATE DATABASE flowers;

USE flowers;

DROP TABLE IF EXISTS FlowersInfo;
DROP TABLE IF EXISTS Zones;
DROP TABLE IF EXISTS Deliveries;

-- tables creation satisfying all of the requirements

CREATE TABLE Zones (
  id   			INT(2) AUTO_INCREMENT PRIMARY KEY,
  lowerTemp 	INT NOT NULL,
  higherTemp  	INT NOT NULL
);

CREATE TABLE Deliveries (
	id			INT(1) AUTO_INCREMENT PRIMARY KEY,
	categ 		VARCHAR(5),
	delSize 	DECIMAL(5,3)
);

CREATE TABLE FlowersInfo (
	id			INT AUTO_INCREMENT PRIMARY KEY,
	comName 	VARCHAR(30),
	latName		VARCHAR(35),
	cZone		INT NOT NULL,
	hZone		INT NOT NULL,
	deliver 	INT(1),
	sunNeeds	VARCHAR(5),
	FOREIGN KEY (cZone) REFERENCES Zones (id),
	FOREIGN KEY (hZone) REFERENCES Zones (id),
	FOREIGN KEY (deliver) REFERENCES Deliveries (id)
);

-- tables population
INSERT INTO Zones (id, lowerTemp, higherTemp) VALUES
	(2, -50, -40);

INSERT INTO Zones (lowerTemp, higherTemp) VALUES
	(-40, -30),
	(-30, -20),
	(-20, -10),
	(-10, 0),
	(0, 10),
	(10, 20),
	(20, 30),
	(30, 40);

INSERT INTO Deliveries (categ, delSize) VALUES
	('pot', 1.500),
	('pot', 2.250),
	('pot', 2.625),
	('pot', 4.250),
	('plant', NULL),
	('bulb', NULL),
	('hedge', 18.000),
	('shrub', 24.000),
	('tree', 36.000);

INSERT INTO FlowersInfo (id, comName, latName, cZone, hZone, deliver, sunNeeds) VALUES
	(101, 'Lady Fern', 'Atbyrium filix-femina', 2, 9, 5, 'SH');

INSERT INTO FlowersInfo (comName, latName, cZone, hZone, deliver, sunNeeds) VALUES
	('Pink Caladiums', 'C.x bortulanum', 10, 10, 6, 'PtoSH'),
	('Lily-of-the-Valley', 'Convallaria majalis', 2, 8, 5, 'PtoSH');

INSERT INTO FlowersInfo (id, comName, latName, cZone, hZone, deliver, sunNeeds) VALUES
	(105, 'Purple Liatris', 'Liatris spicata', 3, 9, 6, 'StoP');

INSERT INTO FlowersInfo (comName, latName, cZone, hZone, deliver, sunNeeds) VALUES
	('Black Eyed Susan', 'Rudbeckia fulgida var. specios', 4, 10, 2, 'StoP'),
	('Nikko Blue Hydrangea', 'Hydrangea macrophylla', 5, 9, 4, 'StoSH'),
	('Variegated Weigela', 'W. florida Variegata', 4, 9, 8, 'StoP');

INSERT INTO FlowersInfo (id, comName, latName, cZone, hZone, deliver, sunNeeds) VALUES
	(110, 'Lombardy Poplar', 'Populus nigra Italica', 3, 9, 9, 'S');

INSERT INTO FlowersInfo (comName, latName, cZone, hZone, deliver, sunNeeds) VALUES
	('Purple Leaf Plum Hedge', 'Prunus x cistena', 2, 8, 7, 'S');

INSERT INTO FlowersInfo (id, comName, latName, cZone, hZone, deliver, sunNeeds) VALUES
	(114, 'Thorndale Ivy', 'Hedera belix Thorndale', 3, 9, 1, 'StoSH');

-- a) the total number of zones.

SELECT COUNT(*) AS 'Total Zones' FROM Zones;

-- b) the number of flowers per cool zone.

SELECT cZone, COUNT(comName) AS 'Flowers' FROM FlowersInfo GROUP BY cZone;

-- c) common names of the plants that have delivery sizes less than 5.

SELECT comName AS 'Common Names of plants w/ delSize < 5' FROM FlowersInfo, Deliveries WHERE FlowersInfo.deliver = Deliveries.id AND Deliveries.delSize < 5;

-- d) common names of the plants that require full sun (i.e., sun needs contains ‘S’).

SELECT comName AS 'Flowers (Full Sun)' FROM FlowersInfo WHERE sunNeeds = "S";

-- e) all delivery category names order alphabetically (without repetition).

SELECT DISTINCT categ AS 'Delivery Categories' FROM Deliveries ORDER BY 1;

-- f) the exact output (see instructions)

SELECT comName AS 'Name', lowerTemp AS 'Cool Zone (low)', higherTemp AS 'Cool Zone (high)', categ 
AS 'Delivery Category' FROM FlowersInfo, Zones, Deliveries WHERE FlowersInfo.cZone = Zones.id AND FlowersInfo.deliver = Deliveries.id ORDER BY 1;

-- g) plant names that have the same hot zone as “Pink Caladiums” (your solution MUST get the hot zone of “Pink Caladiums” in a variable).

SET @pinkCal = (SELECT hZone FROM FlowersInfo WHERE FlowersInfo.comName = 'Pink Caladiums');
SELECT comName, latName FROM FlowersInfo WHERE FlowersInfo.hZone = @pinkCal;

-- h) the total number of plants, the minimum delivery size, the maximum delivery size, and the average size based on the plants that have delivery sizes (note that the average value should be rounded using two decimals).

SELECT COUNT(delSize) AS 'Total', MIN(delSize) AS 'Min', MAX(delSize) AS 'Max', ROUND(AVG(delSize), 2) AS 'Average' FROM FlowersInfo, Deliveries 
WHERE FlowersInfo.deliver = Deliveries.id AND delSize IS NOT NULL;

-- i) the Latin name of the plant that has the word ‘Eyed’ in its name (you must use LIKE in this query to get full credit).  

SELECT latName AS "Flowers with 'Eyed' (latName)" FROM FlowersInfo WHERE comName LIKE '%Eyed%';

-- j) the exact output (see instructions)

SELECT categ AS 'Category', comName AS 'Name' FROM FlowersInfo, Deliveries WHERE FlowersInfo.deliver = Deliveries.id ORDER BY 1;

