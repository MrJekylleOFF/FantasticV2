SET @job_name = 'pizza';
SET @society_name = 'society_pizza';
SET @job_Name_Caps = 'pizza';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_pizza_fridge', 'pizza (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label) VALUES
  (@job_name, @job_Name_Caps)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'recruit', 'Recrue', 300, '{}', '{}'),
  (@job_name, 1, 'employer', 'Employé(e)', 300, '{}', '{}'),
  (@job_name, 2, 'viceboss', 'Co-gérant', 500, '{}', '{}'),
  (@job_name, 3, 'boss', 'Gérant', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES  
    ('pate', 'Pate a pizza', 10),
    ('ing', 'ingredient a pizza', 10),
    ('reine', 'Pizza reine', 5),
    ('5fromages', 'Pizza au 5 fromage', 5),
    ('barbecue', 'pizza au barbecue', 5),
    ('saumons', 'Pizza au saumon', 5),
    ('orientale', 'Pizza orientale', 5),
    ('calzone', 'Pizza calzone', 5)
    ;