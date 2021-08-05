DROP TABLE IF EXISTS `position_drugs`;
CREATE TABLE IF NOT EXISTS `position_drugs` (
  `identifier` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `x` double(8,2) NOT NULL,
  `y` double(8,2) NOT NULL,
  `z` double(8,2) NOT NULL,
  `percent` double(8,2) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


INSERT INTO `items` (name, label) VALUES
	('graine', 'Graine de Weed'),
;
