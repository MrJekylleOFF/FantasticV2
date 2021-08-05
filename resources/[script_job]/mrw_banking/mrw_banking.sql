
INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_brinks','Brinks',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_brinks','Brinks',1)
;

INSERT INTO `jobs` (name, label) VALUES
	('brinks','Brinks')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('brinks',0,'recrue','Recrue',20,'{}','{}'),
	('brinks',1,'boss','Patron',30,'{}','{}')
;
