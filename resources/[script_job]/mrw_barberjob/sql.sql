INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_barbier','Barbier',1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_barbier','Barbier',1)
;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_barbier','Barbier',1)
;

INSERT INTO `jobs`(`name`, `label`, `whitelisted`) VALUES
	('barbier', 'barbier', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('barbier',0,'barbier','Barbier Employé', 10, '{}', '{}'),
	('barbier',1,'boss','Barbier', 10, '{}', '{}')
;

