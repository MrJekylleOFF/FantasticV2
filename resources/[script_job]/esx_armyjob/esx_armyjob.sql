INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_army','Army',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_army','Army',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_army', 'Army', 1)
;

INSERT INTO `jobs` (name, label) VALUES 
	('army','Army')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('army',0,'recruit','Soldat',0,'{}','{}'),
  ('army',1,'firstclass','1er Classe',0,'{}','{}'),
  ('army',2,'capo','Caporal',0,'{}','{}'),
  ('army',3,'chiefcapo','Caporal-Chef',0,'{}','{}'),
  ('army',4,'sergeant','Sergent',0,'{}','{}'),
  ('army',5,'chiefsergeant','Sergent-Chef',0,'{}','{}'),
  ('army',6,'adjudant','Adjudant',0,'{}','{}'),
  ('army',7,'chiefadjudant','Adjudant-Chef',0,'{}','{}')
 ;
 INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('army',8,'major','Major',0,'{}','{}'),
  ('army',9,'aspirant','Aspirant',0,'{}','{}'),
  ('army',10,'souslieutenant','Sous-lieutenant',0,'{}','{}'),
  ('army',11,'lieutenant','Lieutenant',0,'{}','{}'),
  ('army',12,'captain','Capitaine',0,'{}','{}'),
  ('army',13,'commandant','Commandant',0,'{}','{}'),
  ('army',14,'lieutenantcolonel','Lieutenant-colonel',0,'{}','{}'),
  ('army',15,'colonel','Colonel',0,'{}','{}'),
  ('army',16,'brigadiergeneral','Général de brigade',0,'{}','{}')
 ;
 INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('army',17,'divisiongeneral','Général de division',0,'{}','{}'),
  ('army',18,'generalofthearmycorps','Général de corps d\'armée',0,'{}','{}'),
  ('army',19,'generalarmy','Général d\'armée',0,'{}','{}'),
  ('army',20,'boss','Maréchal',0,'{}','{}')
;
