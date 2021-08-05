USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_depanneur', 'Mécano', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_depanneur', 'Mécano', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('depanneur', 'Mécano')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
('depanneur', 0, 'recrue', 'Recrue', 1, '{"tshirt_1":15,"tshirt_2":0,"ears_1":-1,"glasses_1":0,"torso_2":1,"torso_1":65"ears_2":0,"glasses_2":0,"shoes_2":0,""shoes_1":82,"pants_1":90,"shoes_1":12,"bags_1":0,"helmet_1":2,"pants_1":38,"pants_2":1,"torso_1":89,"tshirt_1":15,"arms":42,"bags_1":45,"helmet_2":0}\r\n\r\n\r\n\r\n', '{}'),
('depanneur', 1, 'novice', 'Novice', 1, '{"tshirt_1":15,"tshirt_2":0,"ears_1":-1,"glasses_1":0,"torso_2":1,"torso_1":65"ears_2":0,"glasses_2":0,"shoes_2":0,""shoes_1":82,"pants_1":90,"shoes_1":12,"bags_1":0,"helmet_1":2,"pants_1":38,"pants_2":1,"torso_1":89,"tshirt_1":15,"arms":42,"bags_1":45,"helmet_2":0}\r\n', '{}'),
('depanneur', 2, 'experimente', 'Experimente', 1, '{"tshirt_1":15,"tshirt_2":0,"ears_1":-1,"glasses_1":0,"torso_2":1,"torso_1":65"ears_2":0,"glasses_2":0,"shoes_2":0,""shoes_1":82,"pants_1":90,"shoes_1":12,"bags_1":0,"helmet_1":2,"pants_1":38,"pants_2":1,"torso_1":89,"tshirt_1":15,"arms":42,"bags_1":45,"helmet_2":0}\r\n', '{}'),
('depanneur', 3, 'chief', 'Chef d\'équipe', 500, '{"tshirt_1":15,"tshirt_2":0,"ears_1":-1,"glasses_1":0,"torso_2":1,"torso_1":65"ears_2":0,"glasses_2":0,"shoes_2":0,""shoes_1":82,"pants_1":90,"shoes_1":12,"bags_1":0,"helmet_1":2,"pants_1":38,"pants_2":1,"torso_1":89,"tshirt_1":15,"arms":42,"bags_1":45,"helmet_2":0}', '{}'),
('depanneur', 4, 'boss', 'Patron', 1, '{"tshirt_1":15,"tshirt_2":0,"ears_1":-1,"glasses_1":0,"torso_2":1,"torso_1":65"ears_2":0,"glasses_2":0,"shoes_2":0,""shoes_1":82,"pants_1":90,"shoes_1":12,"bags_1":0,"helmet_1":2,"pants_1":38,"pants_2":1,"torso_1":89,"tshirt_1":15,"arms":42,"bags_1":45,"helmet_2":0}', '{}'),
;

INSERT INTO `items` (name, label, `weight`) VALUES
	('gazbottle', 'bouteille de gaz (11g)', 11),
	('fixtool', 'outils réparation (6g)', 6),
	('carotool', 'outils carosserie (4g)', 4),
	('blowpipe', 'Chalumeaux (10g)', 10),
	('fixkit', 'Kit réparation (5g)', 5),
	('carokit', 'Kit carosserie (3g)', 3)
;
