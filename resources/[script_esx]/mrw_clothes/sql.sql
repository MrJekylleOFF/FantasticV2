-- --------------------------------------------------------
-- Hôte :                        127.0.0.1
-- Version du serveur:           10.4.8-MariaDB - mariadb.org binary distribution
-- SE du serveur:                Win64
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Listage de la structure de la table fxserver. player_clothe
CREATE TABLE IF NOT EXISTS `player_clothe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `clothe` text NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `clothe` (`clothe`(768)),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table fxserver.player_clothe : ~2 rows (environ)
/*!40000 ALTER TABLE `player_clothe` DISABLE KEYS */;
INSERT INTO `player_clothe` (`id`, `identifier`, `name`, `clothe`) VALUES
	(2, 'license:29c199382e2b69defa2fd94922c09387e0aa2d0d', 'test2', '[{"torso_1":0,"tshirt_1":15,"torso_2":0,"tshirt_2":0,"pants_1":0,"shoes_1":0,"pants_2":0,"shoes_2":0}]'),
	(3, 'license:29c199382e2b69defa2fd94922c09387e0aa2d0d', 'test', '[{"torso_1":0,"tshirt_1":15,"torso_2":0,"tshirt_2":0,"pants_1":0,"shoes_1":0,"pants_2":0,"shoes_2":0}]');
/*!40000 ALTER TABLE `player_clothe` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
