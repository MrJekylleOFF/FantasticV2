INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_cuisinier','cuisinier', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_cuisinier', 'cuisinier', 1),
  ('society_pizza_fridge', 'cuisine (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_cuisinier', 'cuisinier', 1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('cuisinier', 'cuisinier')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('cuisinier', 0, 'recruit', 'Recrue', 300, '{}', '{}'),
  ('cuisinier', 1, 'employer', 'Employé(e)', 300, '{}', '{}'),
  ('cuisinier', 2, 'viceboss', 'Co-gérant', 500, '{}', '{}'),
  ('cuisinier', 3, 'boss', 'Gérant', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES  
    ('pate', 'Pate', 10),
    ('compote', 'Compote a la pomme', 10),
    ('puree', 'Purée', 5),
    ('soupe', 'Soupe', 5),
    ('lentilles', 'Lentilles', 5)
    ;