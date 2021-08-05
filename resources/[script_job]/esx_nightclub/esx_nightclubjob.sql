INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_nightclub', 'Nightclub', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_nightclub', 'Nightclub', 1),
  ('society_nightclub_fridge', 'Nightclub (fridge)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_nightclub', 'Nightclub', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  ('nightclub', 'Nightclub', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('Nightclub', 0, 'barman', 'Barkeeper', 1, '{}', '{}'),
  ('Nightclub', 1, 'dancer', 'dancer', 0, '{}', '{}'),
  ('Nightclub', 2, 'viceboss', 'Co-Manager', 0, '{}', '{}'),
  ('Nightclub', 3, 'boss', 'Manager', 0, '{}', '{}')
;
