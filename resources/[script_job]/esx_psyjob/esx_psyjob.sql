INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_psy','Psychologue',1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_psy','Psychologue', 1)
;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_psy', 'Psychologue', 1)
;

INSERT INTO `jobs`(`name`, `label`) VALUES
	('psy', 'Psychologue')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('psy',0,'recrue','Intérimaire', 0, '{"tshirt_1":32,"tshirt_2":0,"torso_1":32, "torso_2":0,"shoes_1":10,"shoes_2":0,"pants_1":10, "pants_2":0, "arms":1}','{"tshirt_1":0,"tshirt_2":0,"torso_1":56,"torso_2":0,"shoes_1":27,"shoes_2":0,"pants_1":36, "pants_2":0, "arms":63, "helmet_1":11, "helmet_2":0,"bags_1":0,"bags_2":0,"ears_1":0,"glasses_1":0,"ears_2":0,"glasses_2":0}'),
	('psy',1,'novice','Confirmer', 0, '{"tshirt_1":32,"tshirt_2":0,"torso_1":32, "torso_2":0,"shoes_1":10,"shoes_2":0,"pants_1":10, "pants_2":0, "arms":1}','{"tshirt_1":0,"tshirt_2":0,"torso_1":56,"torso_2":0,"shoes_1":27,"shoes_2":0,"pants_1":36, "pants_2":0, "arms":63, "helmet_1":11, "helmet_2":0,"bags_1":0,"bags_2":0,"ears_1":0,"glasses_1":0,"ears_2":0,"glasses_2":0}'),
	('psy',2,'cdisenior','Adjoint', 0, '{"tshirt_1":32,"tshirt_2":0,"torso_1":32, "torso_2":0,"shoes_1":10,"shoes_2":0,"pants_1":10, "pants_2":0, "arms":1}','{"tshirt_1":0,"tshirt_2":0,"torso_1":56,"torso_2":0,"shoes_1":27,"shoes_2":0,"pants_1":36, "pants_2":0, "arms":63, "helmet_1":11, "helmet_2":0,"bags_1":0,"bags_2":0,"ears_1":0,"glasses_1":0,"ears_2":0,"glasses_2":0}'),
	('psy',3,'boss','Patron', 0,'{"tshirt_1":32,"tshirt_2":0,"torso_1":32, "torso_2":0,"shoes_1":10,"shoes_2":0,"pants_1":10, "pants_2":0, "arms":1}','{"tshirt_1":15,"tshirt_2":0,"torso_1":14,"torso_2":15,"shoes_1":12,"shoes_2":0,"pants_1":9, "pants_2":5, "arms":1, "helmet_1":11, "helmet_2":0,"bags_1":0,"bags_2":0,"ears_1":0,"glasses_1":0,"ears_2":0,"glasses_2":0}')
;