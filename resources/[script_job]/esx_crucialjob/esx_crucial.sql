SET @job_name = 'crucial';
SET @society_name = 'society_crucial';
SET @job_Name_Caps = 'crucial';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_crucial_fridge', 'crucial (frigo)', 1)
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
    ('nachos', 'Nachos (5g)', 5),
    ('crucial', 'crucial (8g)', 8),
    ('buritto', 'Buritto (4g)', 4),
    ('quesadilla', 'Quesadilla (10g)', 10),
    ('salade', 'Mexican salade (3g)', 3),
    ('donut', 'Donuts (2g)', 2)
    ;