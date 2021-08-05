INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_comedy', 'Comedy', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_comedy', 'Comedy', 1),
  ('society_comedy_fridge', 'Comedy (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
  ('society_comedy', 'Comedy', 1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('comedy', 'Comedy')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('comedy', 0, 'barman', 'Barman', 300, '{}', '{}'),
  ('comedy', 1, 'dancer', 'Danseur', 300, '{}', '{}'),
  ('comedy', 2, 'viceboss', 'Co-gérant', 500, '{}', '{}'),
  ('comedy', 3, 'boss', 'Gérant', 600, '{}', '{}')
;