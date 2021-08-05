SET @job_name = 'bowling';
SET @society_name = 'society_bowling';
SET @job_Name_Caps = 'bowling';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_bowling_fridge', 'bowling (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label) VALUES
  (@job_name, @job_Name_Caps)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'recruit', 'Recrue', 3, '{}', '{}'),
  (@job_name, 1, 'employer', 'Employé(e)', 3, '{}', '{}'),
  (@job_name, 2, 'viceboss', 'Co-gérant', 5, '{}', '{}'),
  (@job_name, 3, 'boss', 'Gérant', 0, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES  
('coca', 'Coca (10g)', 10),
('frite', 'Frite (5g)', 5),
('icetea', 'Icetea (5g)', 5),
('bolchips', 'Packet de chips (15g)', 15),
('jusfruit', 'Jus de fruit (10g)', 10),
('bread', 'Pain (50g)', 50),
('bigmac', 'Big-Mac (50g)', 50)
;