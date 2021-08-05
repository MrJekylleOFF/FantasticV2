CREATE TABLE IF NOT EXISTS `owned_shops`  (
  `identifier` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ShopNumber` int(11) NULL DEFAULT NULL,
  `money` int(11) NULL DEFAULT 0,
  `ShopValue` int(11) NULL DEFAULT NULL,
  `LastRobbery` int(11) NULL DEFAULT 0,
  `ShopName` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ShopLogo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `identifier`(`identifier`) USING BTREE,
  INDEX `ShopNumber`(`ShopNumber`) USING BTREE,
  INDEX `ShopName`(`ShopName`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

INSERT INTO `owned_shops` (`identifier`, `ShopNumber`, `money`, `ShopValue`, `LastRobbery`, `ShopName`, `ShopLogo`) VALUES
  ('0', 1, 0, 280000, 1549643682, '0', 'img/247.png'),
  ('0', 2, 0, 220000, 1549643682, '0', 'img/247.png'),
  ('0', 3, 0, 235000, 1549643682, '0', 'img/247.png'),
  ('0', 4, 0, 285000, 1549643682, '0', 'img/247.png'),
  ('0', 5, 0, 135000, 1549643682, '0', 'img/247.png'),
  ('0', 6, 0, 235000, 1549643682, '0', 'img/247.png'),
  ('0', 7, 0, 160000, 1549643682, '0', 'img/247.png'),
  ('0', 8, 0, 275000, 1549643682, '0', 'img/247.png'),
  ('0', 9, 0, 265000, 1549643682, '0', 'img/247.png'),
  ('0', 10, 0, 300000, 1549643682, '0', 'img/247.png'),
  ('0', 12, 0, 145000, 1549643682, '0', 'img/247.png'),
  ('0', 13, 0, 145000, 1549643682, '0', 'img/247.png'),
  ('0', 14, 0, 280000, 1549643682, '0', 'img/247.png'),
  ('0', 16, 0, 435000, 1549643682, '0', 'img/247.png'),
  ('0', 18, 0, 235000, 1549643682, '0', 'img/247.png'),
  ('0', 11, 0, 225000, 1549643682, '0', 'img/247.png'),
  ('0', 19, 0, 150000, 1549643682, '0', 'img/247.png'),
  ('0', 20, 0, 165000, 1549643682, '0', 'img/247.png'),
  ('0', 17, 0, 150000, 1549643682, '0', 'img/247.png');
  
CREATE TABLE IF NOT EXISTS `shipments`  (
  `id` int(11) NULL DEFAULT NULL,
  `identifier` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `label` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `item` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `price` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `count` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `time` int(20) NULL DEFAULT NULL,
  INDEX `identifier`(`identifier`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;


CREATE TABLE IF NOT EXISTS `shops_players`  (
  `ShopNumber` int(11) NOT NULL DEFAULT 0,
  `src` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `count` int(11) NOT NULL,
  `item` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `categorie` enum('boisson','nourriture','consommables','divers') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  INDEX `shopnumber`(`ShopNumber`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;