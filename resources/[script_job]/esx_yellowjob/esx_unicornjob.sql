SET @job_name = 'unicorn';
SET @society_name = 'society_unicorn';
SET @job_Name_Caps = 'Unicorn';



INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1),
  ('society_unicorn_fridge', 'Unicorn (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  (@job_name, @job_Name_Caps, 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'barman', 'Barman', 300, '{}', '{}'),
  (@job_name, 1, 'dancer', 'Danseur', 300, '{}', '{}'),
  (@job_name, 2, 'viceboss', 'Co-gérant', 500, '{}', '{}'),
  (@job_name, 3, 'boss', 'Gérant', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES  
    ('jager', 'Jägermeister (5g)', 5),
    ('vodka', 'Vodka (5g)', 5),
    ('rhum', 'Rhum (5g)', 5),
    ('whisky', 'Whisky (5g)', 5),
    ('tequila', 'Tequila (5g)', 5),
    ('martini', 'Martini blanc (5g)', 5),
    ('soda', 'Soda (5g)', 5),
    ('jusfruit', 'Jus de fruits (5g)', 5),
    ('icetea', 'Ice Tea (5g)', 5),
    ('energy', 'Energy Drink (5g)', 5),
    ('drpepper', 'Dr. Pepper (5g)', 5),
    ('limonade', 'Limonade (5g)', 5),
    ('bolcacahuetes', 'Bol de cacahuètes (5g)', 5),
    ('bolnoixcajou', 'Bol de noix de cajou (5g)', 5),
    ('bolpistache', 'Bol de pistaches (5g)', 5),
    ('bolchips', 'Bol de chips (5g)', 5),
    ('saucisson', 'Saucisson (5g)', 5),
    ('grapperaisin', 'Grappe de raisin (5g)', 5),
    ('jagerbomb', 'Jägerbomb (5g)', 5),
    ('golem', 'Golem (5g)', 5),
    ('whiskycoca', 'Whisky-coca (5g)', 5),
    ('vodkaenergy', 'Vodka-energy (5g)', 5),
    ('vodkafruit', 'Vodka-jus de fruits (5g)', 5),
    ('rhumfruit', 'Rhum-jus de fruits (5g)', 5),
    ('teqpaf', "Teq'paf (5g)", 5),
    ('rhumcoca', 'Rhum-coca (5g)', 5),
    ('mojito', 'Mojito (5g)', 5),
    ('ice', 'Glaçon (5g)', 5),
    ('mixapero', 'Mix Apéritif (3g)', 3),
    ('metreshooter', 'Mètre de shooter (3g)', 3),
    ('jagercerbere', 'Jäger Cerbère (3g)', 3),
    ('menthe', 'Feuille de menthe (1g)', 1)
;
