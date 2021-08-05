INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_fib', 'Fib', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_fib', 'Fib', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_fib', 'Fib', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('fib','FIB')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('fib',1,'special','Agent spécial',100,'{}','{}'),
	('fib',2,'executif','Agent spécial exécutif',200,'{}','{}'),
	('fib',3,'responsable','Agent spécial responsable',300,'{}','{}'),
	('fib',4,'boss','Directeur',400,'{}','{}')
;
