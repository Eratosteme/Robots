-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 02 déc. 2024 à 10:02
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projet robot`
--

-- --------------------------------------------------------

--
-- Structure de la table `action`
--

CREATE TABLE `action` (
  `ID` int(11) NOT NULL,
  `Description` text DEFAULT NULL,
  `DateDebut` datetime DEFAULT NULL,
  `DateFin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `action`
--

INSERT INTO `action` (`ID`, `Description`, `DateDebut`, `DateFin`) VALUES
(1, 'Exploration site A', '2024-12-01 08:00:00', '2024-12-01 18:00:00'),
(2, 'Réparation générateur', '2024-12-01 10:00:00', '2024-12-01 15:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `humain`
--

CREATE TABLE `humain` (
  `ID` int(11) NOT NULL,
  `Nom` varchar(100) DEFAULT NULL,
  `Poste` varchar(100) DEFAULT NULL,
  `Anciennete` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `humain`
--

INSERT INTO `humain` (`ID`, `Nom`, `Poste`, `Anciennete`) VALUES
(1, 'Alice', 'Ingénieur', 5),
(2, 'Bob', 'Technicien', 2),
(3, 'Claire', 'Superviseur', 7);

-- --------------------------------------------------------

--
-- Structure de la table `participationhumain`
--

CREATE TABLE `participationhumain` (
  `HumainID` int(11) NOT NULL,
  `ActionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `participationhumain`
--

INSERT INTO `participationhumain` (`HumainID`, `ActionID`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `participationrobot`
--

CREATE TABLE `participationrobot` (
  `RobotID` int(11) NOT NULL,
  `ActionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `participationrobot`
--

INSERT INTO `participationrobot` (`RobotID`, `ActionID`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `rapportincidence`
--

CREATE TABLE `rapportincidence` (
  `ID` int(11) NOT NULL,
  `TypeViolation` varchar(50) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `LoiViolee` int(11) DEFAULT NULL CHECK (`LoiViolee` in (1,2,3)),
  `ActionID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `rapportincidence`
--

INSERT INTO `rapportincidence` (`ID`, `TypeViolation`, `Description`, `LoiViolee`, `ActionID`) VALUES
(1, 'Violation Loi 1', 'Robot n’a pas sauvé un humain en danger.', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `robot`
--

CREATE TABLE `robot` (
  `ID` int(11) NOT NULL,
  `Nom` varchar(100) DEFAULT NULL,
  `Modele` varchar(50) DEFAULT NULL,
  `Etat` enum('Actif','En Réparation','Décommissionné','Disparu') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `robot`
--

INSERT INTO `robot` (`ID`, `Nom`, `Modele`, `Etat`) VALUES
(1, 'Alpha1', 'Explorateur-X', 'Actif'),
(2, 'Beta2', 'Minage-Y', 'En Réparation'),
(3, 'Gamma3', 'Maintenance-Z', 'Disparu');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `action`
--
ALTER TABLE `action`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `humain`
--
ALTER TABLE `humain`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `participationhumain`
--
ALTER TABLE `participationhumain`
  ADD PRIMARY KEY (`HumainID`,`ActionID`),
  ADD KEY `ActionID` (`ActionID`);

--
-- Index pour la table `participationrobot`
--
ALTER TABLE `participationrobot`
  ADD PRIMARY KEY (`RobotID`,`ActionID`),
  ADD KEY `ActionID` (`ActionID`);

--
-- Index pour la table `rapportincidence`
--
ALTER TABLE `rapportincidence`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ActionID` (`ActionID`);

--
-- Index pour la table `robot`
--
ALTER TABLE `robot`
  ADD PRIMARY KEY (`ID`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `participationhumain`
--
ALTER TABLE `participationhumain`
  ADD CONSTRAINT `participationhumain_ibfk_1` FOREIGN KEY (`HumainID`) REFERENCES `humain` (`ID`),
  ADD CONSTRAINT `participationhumain_ibfk_2` FOREIGN KEY (`ActionID`) REFERENCES `action` (`ID`);

--
-- Contraintes pour la table `participationrobot`
--
ALTER TABLE `participationrobot`
  ADD CONSTRAINT `participationrobot_ibfk_1` FOREIGN KEY (`RobotID`) REFERENCES `robot` (`ID`),
  ADD CONSTRAINT `participationrobot_ibfk_2` FOREIGN KEY (`ActionID`) REFERENCES `action` (`ID`);

--
-- Contraintes pour la table `rapportincidence`
--
ALTER TABLE `rapportincidence`
  ADD CONSTRAINT `rapportincidence_ibfk_1` FOREIGN KEY (`ActionID`) REFERENCES `action` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
