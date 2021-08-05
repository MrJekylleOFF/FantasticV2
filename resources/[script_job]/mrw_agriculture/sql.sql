CREATE TABLE `owned_parcelle` (
  `owner` varchar(250) NOT NULL,
  `id` int(11) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Libre|nonLibre'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `owned_parcelle`
--

INSERT INTO `owned_parcelle` (`owner`, `id`, `state`) VALUES
('steam:11000011b52d192', 1, 1),
('steam:11000011421be65', 2, 1),
('0', 3, 0);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `owned_parcelle`
--
ALTER TABLE `owned_parcelle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`);
COMMIT;



CREATE TABLE `position_plante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `x` double(8,2) NOT NULL,
  `y` double(8,2) NOT NULL,
  `z` double(8,2) NOT NULL,
  `percent` double(8,2) DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


--
-- Index pour les tables déchargées
--

--
-- Index pour la table `position_plante`
--
ALTER TABLE `position_plante`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identifier` (`identifier`),
  ADD KEY `name` (`name`);


INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('parcelle','Parcelle',0)
;


INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES 

('graineble', 'Graine de blé', '10', '-1', '1'),
('truelle', 'truelle', '5', '-1', '1')


;
