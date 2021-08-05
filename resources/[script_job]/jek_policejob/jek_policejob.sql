INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police','LSPD')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'cadet','Cadet',20,'{}','{}'),
	('police',1,'officier','Officier',40,'{}','{}'),
	('police',2,'sergent','Sergent',60,'{}','{}'),
	('police',3,'sergentc','Sergent Chef',60,'{}','{}'),
	('police',4,'lieutenant','Lieutenant',85,'{}','{}'),
	('police',5,'boss','Commandant',100,'{}','{}')
;
