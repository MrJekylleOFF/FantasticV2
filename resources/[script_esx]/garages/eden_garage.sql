ALTER TABLE `owned_vehicles` ADD `state` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Etat de la voiture' AFTER `owner`;
ALTER TABLE `owned_vehicles` ADD `fourrieremecano` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Voiture chez mecano' AFTER `state`;


CREATE TABLE IF NOT EXISTS `stolen_vehicles` (
  `owner` varchar(22) NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT 1,
  `plate` varchar(12) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `vehicle` longtext DEFAULT NULL,
  `garage_id` varchar(50) NOT NULL DEFAULT 'cubes',
  `health` float NOT NULL DEFAULT 1000,
  PRIMARY KEY (`plate`),
  KEY `owner` (`owner`),
  KEY `name` (`name`),
  KEY `garage_id` (`garage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(22) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'etat du véhicule',
  `garageperso` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Garage Personnel',
  `volee` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'vehicule volé',
  `plate` varchar(12) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) NOT NULL DEFAULT '',
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `garage_id` varchar(50) NOT NULL DEFAULT 'cubes',
  `health` float NOT NULL DEFAULT 1000,
  `kms` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`plate`),
  KEY `owner` (`owner`),
  KEY `name` (`name`),
  KEY `vehicle` (`vehicle`(3072)),
  KEY `type` (`type`),
  KEY `job` (`job`),
  KEY `garage_id` (`garage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;