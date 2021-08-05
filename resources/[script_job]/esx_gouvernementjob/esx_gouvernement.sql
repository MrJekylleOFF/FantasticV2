INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_gouv', 'Gouvernement', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_gouv', 'Gouvernement', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_gouv', 'Gouvernement', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('gouv','Gouv')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('gouv',0,'stagiaire','Stagiaire',20,'{}','{}'),
	('gouv',1,'gardedc','Garde du Corps',40,'{}','{}'),
	('gouv',2,'secretaire','Secrétaire',60,'{}','{}'),
	('gouv',3,'coboss','Vice-président',85,'{}','{}'),
	('gouv',4,'boss','Président',100,'{}','{}')
;

CREATE TABLE `fine_types_gouv` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`label` varchar(255) DEFAULT NULL,
	`amount` int(11) DEFAULT NULL,
	`category` int(11) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `fine_types_gouv` (label, amount, category) VALUES
	('Escroquerie à l\'entreprise',2000,2)
;
