INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_fueler','Raffineur',1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_fueler','Raffineur', 1)
;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_fueler', 'Raffineur', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('fueler',0,'recrue','Chauffeur', 50, '{}', '{}'),
	('fueler',1,'novice','Chef dequipe', 100, '{}', '{}'),
	('fueler',2,'adjoint','Adjoint', 150, '{}', '{}'),
	('fueler',3,'boss','Patron', 200,'{}', '{}')
;


INSERT INTO `jobs`(`name`, `label`, `whitelisted`) VALUES
	('fueler', 'Raffineur', 1)
;

