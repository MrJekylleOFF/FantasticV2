USE `servdev`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_aircraft','Aircraft Dealer',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_aircraft','Concesionnaire',1)
;

INSERT INTO `jobs` (name, label) VALUES
	('aircraft','Aircraft Dealer')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('aircraft',0,'recruit','Recrue',10,'{}','{}'),
	('aircraft',1,'novice','Novice',25,'{}','{}'),
	('aircraft',2,'experienced','Experimente',40,'{}','{}'),
	('aircraft',3,'boss','Patron',0,'{}','{}')
;

CREATE TABLE `aircraft_vehicles` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`vehicle` varchar(255) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE `owned_avions` (
	`owner` varchar(22) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`vehicle` longtext,
	`type` VARCHAR(20) NOT NULL DEFAULT 'car',
	`job` VARCHAR(20) NULL DEFAULT NULL,
	`stored` TINYINT(1) NOT NULL DEFAULT '0',

	PRIMARY KEY (`plate`)
);

CREATE TABLE `avion_sold` (
	`client` VARCHAR(50) NOT NULL,
	`model` VARCHAR(50) NOT NULL,
	`plate` VARCHAR(50) NOT NULL,
	`soldby` VARCHAR(50) NOT NULL,
	`date` VARCHAR(50) NOT NULL,

	PRIMARY KEY (`plate`)
);

CREATE TABLE `avion_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `avion_categories` (name, label) VALUES
	('avion','Avion')
;

CREATE TABLE `avion` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `avion` (name, model, price, category) VALUES
	('Luxor','luxor',900000,'avion'),
	('Shamal','shamal',890000,'avion'),
	('Jet (21m)','jet',970000000,'avion'),
	('Mammatus','mammatus',470000,'avion'),
	('Duster','duster',140000,'avion'),
	('Mallard','mallard',380000,'avion'),
	('Dodo','dodo',700000,'avion'),
	('Vestra','vestra',390000,'avion'),
	('Miljet','miljet',987000,'avion'),
	('Molotok','molotok',1870000,'avion'),
	('Nokota','nokota',999999,'avion'),
	('Starling','starling',1787770,'avion'),
	('Pyro','pyro',797840,'avion'),
	('Nimbus','nimbus',800000,'avion'),
	('Velum','velum',468000,'avion'),
	('Besra','besra',780000,'avion'),
	('Drone','rcmavic',378000,'avion')
;

INSERT INTO `avion` (name, model, price, category) VALUES
	('Maverick','maverick',230000,'helico'),
	('Skylift','skylift',500000,'helico'),
	('Frogger','frogger',300000,'helico'),
	('Swift','swift',890000,'helico'),
	('SuperVolito','superVolito',400000,'helico'),
	('Volatus','volatus',990000,'helico'),
	('Sparrow','sparrow',680000,'helico')
	;
