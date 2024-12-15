-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 15 déc. 2024 à 20:27
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
-- Base de données : `robot`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateActions` (IN `num_actions` INT)   BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= num_actions DO
        INSERT INTO Action (Nom_Action, Date_Debut, Date_Fin)
        VALUES (
            CONCAT('Action_', i),
            NOW() - INTERVAL FLOOR(1 + RAND() * 100) DAY,
            NOW() - INTERVAL FLOOR(1 + RAND() * 50) DAY
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateHumans` (IN `num_humans` INT)   BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= num_humans DO
        INSERT INTO Humain (Nom, Poste, Anciennete)
        VALUES (
            CONCAT('Humain_', i),
            ELT(FLOOR(1 + RAND() * 3), 'Scientifique', 'Ingénieur', 'Technicien'),
            FLOOR(1 + RAND() * 15)
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateRobotActions` (IN `num_relations` INT)   BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= num_relations DO
        INSERT INTO Robot_Action (ID_Robot, ID_Action)
        VALUES (
            FLOOR(1 + RAND() * 100),
            FLOOR(1 + RAND() * 200)
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateRobots` (IN `num_robots` INT)   BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= num_robots DO
        INSERT INTO Robot (Nom, Modele, Etat)
        VALUES (
            CONCAT('Robot', i),
            CONCAT('Modele_', FLOOR(1 + RAND() * 10)),
            ELT(FLOOR(1 + RAND() * 4), 'Actif', 'En Réparation', 'Décommissionné', 'Disparu')
        );
        SET i = i + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateUniqueRobotActions` (IN `num_relations` INT)   BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE robot_id INT;
    DECLARE action_id INT;

    WHILE i <= num_relations DO
        SET robot_id = FLOOR(1 + RAND() * 100); -- Générer un ID_Robot aléatoire
        SET action_id = FLOOR(1 + RAND() * 200); -- Générer un ID_Action aléatoire

        -- Vérifier si la combinaison existe déjà
        IF NOT EXISTS (
            SELECT 1 FROM Robot_Action WHERE ID_Robot = robot_id AND ID_Action = action_id
        ) THEN
            -- Insérer seulement si la combinaison est unique
            INSERT INTO Robot_Action (ID_Robot, ID_Action)
            VALUES (robot_id, action_id);
            SET i = i + 1;
        END IF;
    END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `action`
--

CREATE TABLE `action` (
  `ID_Action` int(11) NOT NULL,
  `Nom_Action` varchar(255) NOT NULL,
  `Date_Debut` datetime NOT NULL,
  `Date_Fin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `action`
--

INSERT INTO `action` (`ID_Action`, `Nom_Action`, `Date_Debut`, `Date_Fin`) VALUES
(1, 'Exploration site de forage', '2024-12-01 10:00:00', '2024-12-01 15:00:00'),
(2, 'Réparation générateur', '2024-12-02 08:00:00', '2024-12-02 12:00:00'),
(3, 'Action_1', '2024-09-01 11:25:16', '2024-11-15 11:25:16'),
(4, 'Action_2', '2024-10-31 11:25:16', '2024-11-11 11:25:16'),
(5, 'Action_3', '2024-10-14 11:25:16', '2024-11-30 11:25:16'),
(6, 'Action_4', '2024-11-26 11:25:16', '2024-12-02 11:25:16'),
(7, 'Action_5', '2024-11-08 11:25:16', '2024-12-02 11:25:16'),
(8, 'Action_6', '2024-09-26 11:25:16', '2024-11-25 11:25:16'),
(9, 'Action_7', '2024-11-28 11:25:16', '2024-10-31 11:25:16'),
(10, 'Action_8', '2024-10-19 11:25:16', '2024-11-27 11:25:16'),
(11, 'Action_9', '2024-10-03 11:25:16', '2024-11-07 11:25:16'),
(12, 'Action_10', '2024-11-27 11:25:16', '2024-11-04 11:25:16'),
(13, 'Action_11', '2024-11-26 11:25:16', '2024-11-12 11:25:16'),
(14, 'Action_12', '2024-11-11 11:25:16', '2024-10-30 11:25:16'),
(15, 'Action_13', '2024-11-22 11:25:16', '2024-11-17 11:25:16'),
(16, 'Action_14', '2024-09-30 11:25:16', '2024-11-30 11:25:16'),
(17, 'Action_15', '2024-09-28 11:25:16', '2024-12-04 11:25:16'),
(18, 'Action_16', '2024-11-09 11:25:16', '2024-11-28 11:25:16'),
(19, 'Action_17', '2024-11-21 11:25:16', '2024-11-26 11:25:16'),
(20, 'Action_18', '2024-09-28 11:25:16', '2024-10-27 11:25:16'),
(21, 'Action_19', '2024-12-02 11:25:16', '2024-10-30 11:25:16'),
(22, 'Action_20', '2024-09-27 11:25:16', '2024-11-25 11:25:16'),
(23, 'Action_21', '2024-11-17 11:25:16', '2024-11-26 11:25:16'),
(24, 'Action_22', '2024-10-10 11:25:16', '2024-11-28 11:25:16'),
(25, 'Action_23', '2024-11-08 11:25:16', '2024-10-25 11:25:16'),
(26, 'Action_24', '2024-10-15 11:25:16', '2024-12-06 11:25:16'),
(27, 'Action_25', '2024-10-07 11:25:16', '2024-10-22 11:25:16'),
(28, 'Action_26', '2024-09-14 11:25:16', '2024-11-16 11:25:16'),
(29, 'Action_27', '2024-10-04 11:25:16', '2024-10-23 11:25:16'),
(30, 'Action_28', '2024-10-01 11:25:16', '2024-11-07 11:25:16'),
(31, 'Action_29', '2024-11-27 11:25:16', '2024-11-05 11:25:16'),
(32, 'Action_30', '2024-12-08 11:25:16', '2024-12-08 11:25:16'),
(33, 'Action_31', '2024-12-05 11:25:16', '2024-12-02 11:25:16'),
(34, 'Action_32', '2024-10-11 11:25:16', '2024-11-14 11:25:16'),
(35, 'Action_33', '2024-09-26 11:25:16', '2024-11-28 11:25:16'),
(36, 'Action_34', '2024-09-19 11:25:16', '2024-11-18 11:25:16'),
(37, 'Action_35', '2024-10-02 11:25:16', '2024-12-02 11:25:16'),
(38, 'Action_36', '2024-10-08 11:25:16', '2024-11-05 11:25:16'),
(39, 'Action_37', '2024-10-16 11:25:16', '2024-11-07 11:25:16'),
(40, 'Action_38', '2024-10-11 11:25:16', '2024-12-07 11:25:16'),
(41, 'Action_39', '2024-10-29 11:25:16', '2024-10-24 11:25:16'),
(42, 'Action_40', '2024-11-03 11:25:16', '2024-12-07 11:25:16'),
(43, 'Action_41', '2024-11-29 11:25:16', '2024-11-20 11:25:16'),
(44, 'Action_42', '2024-10-08 11:25:16', '2024-10-23 11:25:16'),
(45, 'Action_43', '2024-09-18 11:25:16', '2024-11-25 11:25:16'),
(46, 'Action_44', '2024-09-09 11:25:16', '2024-11-02 11:25:16'),
(47, 'Action_45', '2024-09-03 11:25:16', '2024-11-07 11:25:16'),
(48, 'Action_46', '2024-11-14 11:25:16', '2024-11-22 11:25:16'),
(49, 'Action_47', '2024-09-10 11:25:16', '2024-11-13 11:25:16'),
(50, 'Action_48', '2024-09-10 11:25:16', '2024-10-23 11:25:16'),
(51, 'Action_49', '2024-08-31 11:25:16', '2024-12-01 11:25:16'),
(52, 'Action_50', '2024-09-21 11:25:16', '2024-11-14 11:25:16'),
(53, 'Action_51', '2024-12-04 11:25:16', '2024-10-30 11:25:16'),
(54, 'Action_52', '2024-09-16 11:25:16', '2024-10-30 11:25:16'),
(55, 'Action_53', '2024-10-29 11:25:17', '2024-11-05 11:25:17'),
(56, 'Action_54', '2024-11-27 11:25:17', '2024-11-08 11:25:17'),
(57, 'Action_55', '2024-10-05 11:25:17', '2024-11-17 11:25:17'),
(58, 'Action_56', '2024-11-14 11:25:17', '2024-10-24 11:25:17'),
(59, 'Action_57', '2024-09-16 11:25:17', '2024-11-17 11:25:17'),
(60, 'Action_58', '2024-10-06 11:25:17', '2024-10-24 11:25:17'),
(61, 'Action_59', '2024-10-10 11:25:17', '2024-11-25 11:25:17'),
(62, 'Action_60', '2024-10-09 11:25:17', '2024-11-29 11:25:17'),
(63, 'Action_61', '2024-11-22 11:25:17', '2024-11-27 11:25:17'),
(64, 'Action_62', '2024-10-03 11:25:17', '2024-11-06 11:25:17'),
(65, 'Action_63', '2024-11-18 11:25:17', '2024-12-04 11:25:17'),
(66, 'Action_64', '2024-09-15 11:25:17', '2024-10-23 11:25:17'),
(67, 'Action_65', '2024-11-25 11:25:17', '2024-10-25 11:25:17'),
(68, 'Action_66', '2024-12-04 11:25:17', '2024-11-11 11:25:17'),
(69, 'Action_67', '2024-10-10 11:25:17', '2024-11-21 11:25:17'),
(70, 'Action_68', '2024-09-01 11:25:17', '2024-10-26 11:25:17'),
(71, 'Action_69', '2024-10-28 11:25:17', '2024-11-17 11:25:17'),
(72, 'Action_70', '2024-09-10 11:25:17', '2024-11-29 11:25:17'),
(73, 'Action_71', '2024-11-15 11:25:17', '2024-11-06 11:25:17'),
(74, 'Action_72', '2024-10-18 11:25:17', '2024-11-06 11:25:17'),
(75, 'Action_73', '2024-09-30 11:25:17', '2024-11-11 11:25:17'),
(76, 'Action_74', '2024-10-08 11:25:17', '2024-11-16 11:25:17'),
(77, 'Action_75', '2024-10-28 11:25:17', '2024-11-03 11:25:17'),
(78, 'Action_76', '2024-11-04 11:25:17', '2024-11-10 11:25:17'),
(79, 'Action_77', '2024-09-22 11:25:17', '2024-11-28 11:25:17'),
(80, 'Action_78', '2024-09-29 11:25:17', '2024-10-24 11:25:17'),
(81, 'Action_79', '2024-10-30 11:25:17', '2024-11-24 11:25:17'),
(82, 'Action_80', '2024-11-17 11:25:17', '2024-11-26 11:25:17'),
(83, 'Action_81', '2024-10-10 11:25:17', '2024-11-28 11:25:17'),
(84, 'Action_82', '2024-11-11 11:25:17', '2024-11-01 11:25:17'),
(85, 'Action_83', '2024-09-04 11:25:17', '2024-11-13 11:25:17'),
(86, 'Action_84', '2024-10-05 11:25:17', '2024-11-03 11:25:17'),
(87, 'Action_85', '2024-10-09 11:25:17', '2024-10-24 11:25:17'),
(88, 'Action_86', '2024-09-24 11:25:17', '2024-12-06 11:25:17'),
(89, 'Action_87', '2024-09-04 11:25:17', '2024-11-07 11:25:17'),
(90, 'Action_88', '2024-11-10 11:25:17', '2024-11-12 11:25:17'),
(91, 'Action_89', '2024-09-21 11:25:17', '2024-11-22 11:25:17'),
(92, 'Action_90', '2024-11-09 11:25:17', '2024-11-13 11:25:17'),
(93, 'Action_91', '2024-10-05 11:25:17', '2024-11-04 11:25:17'),
(94, 'Action_92', '2024-10-19 11:25:17', '2024-11-15 11:25:17'),
(95, 'Action_93', '2024-09-12 11:25:17', '2024-10-23 11:25:17'),
(96, 'Action_94', '2024-08-31 11:25:17', '2024-11-28 11:25:17'),
(97, 'Action_95', '2024-11-29 11:25:17', '2024-10-29 11:25:17'),
(98, 'Action_96', '2024-09-21 11:25:17', '2024-11-14 11:25:17'),
(99, 'Action_97', '2024-12-03 11:25:17', '2024-10-28 11:25:17'),
(100, 'Action_98', '2024-09-02 11:25:17', '2024-11-19 11:25:17'),
(101, 'Action_99', '2024-12-08 11:25:17', '2024-10-25 11:25:17'),
(102, 'Action_100', '2024-10-29 11:25:17', '2024-11-21 11:25:17'),
(103, 'Action_101', '2024-10-12 11:25:17', '2024-10-29 11:25:17'),
(104, 'Action_102', '2024-11-03 11:25:17', '2024-11-23 11:25:17'),
(105, 'Action_103', '2024-10-20 11:25:17', '2024-11-12 11:25:17'),
(106, 'Action_104', '2024-11-18 11:25:17', '2024-11-17 11:25:17'),
(107, 'Action_105', '2024-10-18 11:25:17', '2024-11-23 11:25:17'),
(108, 'Action_106', '2024-08-31 11:25:17', '2024-12-06 11:25:17'),
(109, 'Action_107', '2024-11-10 11:25:17', '2024-11-26 11:25:17'),
(110, 'Action_108', '2024-11-02 11:25:17', '2024-12-03 11:25:17'),
(111, 'Action_109', '2024-10-21 11:25:17', '2024-12-05 11:25:17'),
(112, 'Action_110', '2024-09-06 11:25:17', '2024-11-17 11:25:17'),
(113, 'Action_111', '2024-11-07 11:25:17', '2024-11-22 11:25:17'),
(114, 'Action_112', '2024-10-03 11:25:17', '2024-11-21 11:25:17'),
(115, 'Action_113', '2024-09-23 11:25:17', '2024-10-30 11:25:17'),
(116, 'Action_114', '2024-10-06 11:25:17', '2024-10-29 11:25:17'),
(117, 'Action_115', '2024-11-22 11:25:17', '2024-11-20 11:25:17'),
(118, 'Action_116', '2024-11-05 11:25:17', '2024-11-09 11:25:17'),
(119, 'Action_117', '2024-09-03 11:25:17', '2024-12-07 11:25:17'),
(120, 'Action_118', '2024-11-14 11:25:17', '2024-12-01 11:25:17'),
(121, 'Action_119', '2024-09-03 11:25:17', '2024-11-17 11:25:17'),
(122, 'Action_120', '2024-11-15 11:25:17', '2024-10-26 11:25:17'),
(123, 'Action_121', '2024-10-03 11:25:17', '2024-11-04 11:25:17'),
(124, 'Action_122', '2024-10-21 11:25:17', '2024-11-22 11:25:17'),
(125, 'Action_123', '2024-11-20 11:25:17', '2024-10-22 11:25:17'),
(126, 'Action_124', '2024-11-20 11:25:17', '2024-12-05 11:25:17'),
(127, 'Action_125', '2024-09-18 11:25:17', '2024-10-27 11:25:17'),
(128, 'Action_126', '2024-09-21 11:25:17', '2024-11-19 11:25:17'),
(129, 'Action_127', '2024-10-13 11:25:17', '2024-11-05 11:25:17'),
(130, 'Action_128', '2024-10-01 11:25:17', '2024-11-19 11:25:17'),
(131, 'Action_129', '2024-09-10 11:25:17', '2024-11-22 11:25:17'),
(132, 'Action_130', '2024-09-05 11:25:17', '2024-11-01 11:25:17'),
(133, 'Action_131', '2024-09-11 11:25:17', '2024-11-29 11:25:17'),
(134, 'Action_132', '2024-11-08 11:25:17', '2024-10-21 11:25:17'),
(135, 'Action_133', '2024-09-11 11:25:17', '2024-11-11 11:25:17'),
(136, 'Action_134', '2024-12-02 11:25:17', '2024-11-03 11:25:17'),
(137, 'Action_135', '2024-11-06 11:25:17', '2024-11-12 11:25:17'),
(138, 'Action_136', '2024-10-06 11:25:17', '2024-11-08 11:25:17'),
(139, 'Action_137', '2024-11-29 11:25:17', '2024-11-04 11:25:17'),
(140, 'Action_138', '2024-11-23 11:25:17', '2024-11-03 11:25:17'),
(141, 'Action_139', '2024-11-26 11:25:17', '2024-11-16 11:25:17'),
(142, 'Action_140', '2024-09-09 11:25:17', '2024-12-01 11:25:17'),
(143, 'Action_141', '2024-12-05 11:25:17', '2024-11-01 11:25:17'),
(144, 'Action_142', '2024-10-06 11:25:17', '2024-10-24 11:25:17'),
(145, 'Action_143', '2024-10-03 11:25:17', '2024-11-10 11:25:17'),
(146, 'Action_144', '2024-09-09 11:25:17', '2024-10-29 11:25:17'),
(147, 'Action_145', '2024-11-07 11:25:17', '2024-12-02 11:25:17'),
(148, 'Action_146', '2024-09-28 11:25:17', '2024-11-29 11:25:17'),
(149, 'Action_147', '2024-09-21 11:25:17', '2024-11-19 11:25:17'),
(150, 'Action_148', '2024-10-15 11:25:17', '2024-11-09 11:25:17'),
(151, 'Action_149', '2024-11-07 11:25:17', '2024-10-30 11:25:17'),
(152, 'Action_150', '2024-12-07 11:25:17', '2024-11-04 11:25:17'),
(153, 'Action_151', '2024-10-30 11:25:17', '2024-10-23 11:25:17'),
(154, 'Action_152', '2024-10-26 11:25:17', '2024-11-18 11:25:17'),
(155, 'Action_153', '2024-09-24 11:25:17', '2024-11-12 11:25:17'),
(156, 'Action_154', '2024-10-31 11:25:17', '2024-11-22 11:25:17'),
(157, 'Action_155', '2024-10-21 11:25:17', '2024-11-17 11:25:17'),
(158, 'Action_156', '2024-09-30 11:25:17', '2024-11-29 11:25:17'),
(159, 'Action_157', '2024-09-10 11:25:17', '2024-10-25 11:25:17'),
(160, 'Action_158', '2024-09-21 11:25:17', '2024-11-27 11:25:17'),
(161, 'Action_159', '2024-09-22 11:25:17', '2024-11-28 11:25:17'),
(162, 'Action_160', '2024-09-25 11:25:17', '2024-12-06 11:25:17'),
(163, 'Action_161', '2024-12-02 11:25:17', '2024-12-01 11:25:17'),
(164, 'Action_162', '2024-10-10 11:25:17', '2024-11-13 11:25:17'),
(165, 'Action_163', '2024-09-22 11:25:17', '2024-11-23 11:25:17'),
(166, 'Action_164', '2024-11-11 11:25:17', '2024-11-18 11:25:17'),
(167, 'Action_165', '2024-11-17 11:25:17', '2024-10-26 11:25:17'),
(168, 'Action_166', '2024-10-01 11:25:17', '2024-10-29 11:25:17'),
(169, 'Action_167', '2024-12-05 11:25:17', '2024-11-03 11:25:17'),
(170, 'Action_168', '2024-10-24 11:25:17', '2024-12-02 11:25:17'),
(171, 'Action_169', '2024-11-08 11:25:17', '2024-12-02 11:25:17'),
(172, 'Action_170', '2024-09-25 11:25:17', '2024-11-23 11:25:17'),
(173, 'Action_171', '2024-11-05 11:25:17', '2024-11-02 11:25:17'),
(174, 'Action_172', '2024-10-05 11:25:17', '2024-12-06 11:25:17'),
(175, 'Action_173', '2024-11-11 11:25:17', '2024-11-27 11:25:17'),
(176, 'Action_174', '2024-11-02 11:25:17', '2024-12-03 11:25:17'),
(177, 'Action_175', '2024-10-20 11:25:17', '2024-12-03 11:25:17'),
(178, 'Action_176', '2024-12-03 11:25:17', '2024-10-22 11:25:17'),
(179, 'Action_177', '2024-10-15 11:25:17', '2024-10-23 11:25:17'),
(180, 'Action_178', '2024-09-02 11:25:17', '2024-12-04 11:25:17'),
(181, 'Action_179', '2024-10-12 11:25:17', '2024-11-10 11:25:17'),
(182, 'Action_180', '2024-11-23 11:25:17', '2024-12-07 11:25:17'),
(183, 'Action_181', '2024-09-26 11:25:17', '2024-11-12 11:25:17'),
(184, 'Action_182', '2024-10-19 11:25:17', '2024-10-25 11:25:17'),
(185, 'Action_183', '2024-09-06 11:25:17', '2024-12-08 11:25:17'),
(186, 'Action_184', '2024-11-14 11:25:17', '2024-11-29 11:25:17'),
(187, 'Action_185', '2024-11-13 11:25:17', '2024-11-05 11:25:17'),
(188, 'Action_186', '2024-10-11 11:25:17', '2024-10-23 11:25:17'),
(189, 'Action_187', '2024-09-11 11:25:17', '2024-11-06 11:25:17'),
(190, 'Action_188', '2024-10-11 11:25:17', '2024-10-22 11:25:17'),
(191, 'Action_189', '2024-12-04 11:25:17', '2024-11-20 11:25:17'),
(192, 'Action_190', '2024-09-29 11:25:17', '2024-11-18 11:25:17'),
(193, 'Action_191', '2024-09-05 11:25:17', '2024-11-15 11:25:17'),
(194, 'Action_192', '2024-10-14 11:25:17', '2024-11-21 11:25:17'),
(195, 'Action_193', '2024-11-29 11:25:17', '2024-11-17 11:25:17'),
(196, 'Action_194', '2024-09-17 11:25:17', '2024-10-27 11:25:17'),
(197, 'Action_195', '2024-09-18 11:25:17', '2024-11-14 11:25:17'),
(198, 'Action_196', '2024-09-01 11:25:17', '2024-11-14 11:25:17'),
(199, 'Action_197', '2024-10-22 11:25:17', '2024-10-23 11:25:17'),
(200, 'Action_198', '2024-11-19 11:25:17', '2024-11-29 11:25:17'),
(201, 'Action_199', '2024-10-30 11:25:17', '2024-11-19 11:25:17'),
(202, 'Action_200', '2024-09-23 11:25:17', '2024-11-06 11:25:17');

-- --------------------------------------------------------

--
-- Structure de la table `humain`
--

CREATE TABLE `humain` (
  `ID_Humain` int(11) NOT NULL,
  `Nom` varchar(100) NOT NULL,
  `Poste` varchar(100) NOT NULL,
  `Anciennete` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `humain`
--

INSERT INTO `humain` (`ID_Humain`, `Nom`, `Poste`, `Anciennete`) VALUES
(1, 'John Doe', 'Scientifique', 5),
(2, 'Jane Smith', 'Ingénieure', 3),
(3, 'Humain_1', 'Ingénieur', 1),
(4, 'Humain_2', 'Ingénieur', 6),
(5, 'Humain_3', 'Ingénieur', 11),
(6, 'Humain_4', 'Ingénieur', 11),
(7, 'Humain_5', 'Ingénieur', 11),
(8, 'Humain_6', 'Technicien', 15),
(9, 'Humain_7', 'Ingénieur', 5),
(10, 'Humain_8', 'Scientifique', 9),
(11, 'Humain_9', 'Ingénieur', 6),
(12, 'Humain_10', 'Scientifique', 5),
(13, 'Humain_11', 'Scientifique', 11),
(14, 'Humain_12', 'Scientifique', 1),
(15, 'Humain_13', 'Ingénieur', 15),
(16, 'Humain_14', 'Ingénieur', 10),
(17, 'Humain_15', 'Ingénieur', 3),
(18, 'Humain_16', 'Scientifique', 3),
(19, 'Humain_17', 'Ingénieur', 10),
(20, 'Humain_18', 'Technicien', 4),
(21, 'Humain_19', 'Ingénieur', 9),
(22, 'Humain_20', 'Technicien', 1),
(23, 'Humain_21', 'Ingénieur', 13),
(24, 'Humain_22', 'Scientifique', 12),
(25, 'Humain_23', 'Technicien', 3),
(26, 'Humain_24', 'Technicien', 1),
(27, 'Humain_25', 'Technicien', 15),
(28, 'Humain_26', 'Technicien', 10),
(29, 'Humain_27', 'Scientifique', 8),
(30, 'Humain_28', 'Scientifique', 14),
(31, 'Humain_29', 'Ingénieur', 4),
(32, 'Humain_30', 'Ingénieur', 8),
(33, 'Humain_31', 'Scientifique', 6),
(34, 'Humain_32', 'Ingénieur', 14),
(35, 'Humain_33', 'Scientifique', 5),
(36, 'Humain_34', 'Scientifique', 3),
(37, 'Humain_35', 'Technicien', 11),
(38, 'Humain_36', 'Technicien', 11),
(39, 'Humain_37', 'Ingénieur', 14),
(40, 'Humain_38', 'Technicien', 3),
(41, 'Humain_39', 'Ingénieur', 3),
(42, 'Humain_40', 'Scientifique', 9),
(43, 'Humain_41', 'Scientifique', 11),
(44, 'Humain_42', 'Technicien', 7),
(45, 'Humain_43', 'Scientifique', 4),
(46, 'Humain_44', 'Technicien', 10),
(47, 'Humain_45', 'Ingénieur', 9),
(48, 'Humain_46', 'Scientifique', 15),
(49, 'Humain_47', 'Technicien', 6),
(50, 'Humain_48', 'Scientifique', 3),
(51, 'Humain_49', 'Technicien', 7),
(52, 'Humain_50', 'Scientifique', 8);

-- --------------------------------------------------------

--
-- Structure de la table `humain_action`
--

CREATE TABLE `humain_action` (
  `ID_Humain` int(11) NOT NULL,
  `ID_Action` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `humain_action`
--

INSERT INTO `humain_action` (`ID_Humain`, `ID_Action`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `rapport_incidence`
--

CREATE TABLE `rapport_incidence` (
  `ID_Rapport` int(11) NOT NULL,
  `Type_Loi` enum('1','2','3') NOT NULL,
  `Description` text NOT NULL,
  `ID_Action` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `rapport_incidence`
--

INSERT INTO `rapport_incidence` (`ID_Rapport`, `Type_Loi`, `Description`, `ID_Action`) VALUES
(1, '1', 'Un robot a laissé un humain blessé sans assistance.', 1),
(2, '2', 'Un robot n’a pas suivi les ordres prioritaires.', 2);

-- --------------------------------------------------------

--
-- Structure de la table `robot`
--

CREATE TABLE `robot` (
  `ID_Robot` int(11) NOT NULL,
  `Nom` varchar(100) NOT NULL,
  `Modele` varchar(100) NOT NULL,
  `Etat` enum('Actif','En Réparation','Décommissionné','Disparu') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `robot`
--

INSERT INTO `robot` (`ID_Robot`, `Nom`, `Modele`, `Etat`) VALUES
(1, 'Robot1', 'Explorateur X200', 'Actif'),
(2, 'Robot2', 'Maintenance A100', 'En Réparation'),
(3, 'Robot1', 'Modele_1', 'Décommissionné'),
(4, 'Robot2', 'Modele_6', 'Actif'),
(5, 'Robot3', 'Modele_1', 'Décommissionné'),
(6, 'Robot4', 'Modele_6', 'En Réparation'),
(7, 'Robot5', 'Modele_6', 'Décommissionné'),
(8, 'Robot6', 'Modele_6', 'Décommissionné'),
(9, 'Robot7', 'Modele_9', 'Actif'),
(10, 'Robot8', 'Modele_4', 'Actif'),
(11, 'Robot9', 'Modele_9', 'Décommissionné'),
(12, 'Robot10', 'Modele_10', 'Décommissionné'),
(13, 'Robot11', 'Modele_8', 'Décommissionné'),
(14, 'Robot12', 'Modele_4', 'Actif'),
(15, 'Robot13', 'Modele_2', 'Décommissionné'),
(16, 'Robot14', 'Modele_7', 'En Réparation'),
(17, 'Robot15', 'Modele_6', 'Décommissionné'),
(18, 'Robot16', 'Modele_3', 'Disparu'),
(19, 'Robot17', 'Modele_3', 'Disparu'),
(20, 'Robot18', 'Modele_9', 'Décommissionné'),
(21, 'Robot19', 'Modele_5', 'En Réparation'),
(22, 'Robot20', 'Modele_5', 'En Réparation'),
(23, 'Robot21', 'Modele_3', 'Actif'),
(24, 'Robot22', 'Modele_5', 'En Réparation'),
(25, 'Robot23', 'Modele_10', 'Disparu'),
(26, 'Robot24', 'Modele_10', 'Disparu'),
(27, 'Robot25', 'Modele_6', 'Actif'),
(28, 'Robot26', 'Modele_5', 'Actif'),
(29, 'Robot27', 'Modele_5', 'Disparu'),
(30, 'Robot28', 'Modele_2', 'Actif'),
(31, 'Robot29', 'Modele_8', 'Décommissionné'),
(32, 'Robot30', 'Modele_9', 'En Réparation'),
(33, 'Robot31', 'Modele_6', 'En Réparation'),
(34, 'Robot32', 'Modele_3', 'En Réparation'),
(35, 'Robot33', 'Modele_7', 'Actif'),
(36, 'Robot34', 'Modele_9', 'Disparu'),
(37, 'Robot35', 'Modele_2', 'Actif'),
(38, 'Robot36', 'Modele_6', 'Décommissionné'),
(39, 'Robot37', 'Modele_9', 'Actif'),
(40, 'Robot38', 'Modele_8', 'En Réparation'),
(41, 'Robot39', 'Modele_3', 'Décommissionné'),
(42, 'Robot40', 'Modele_7', 'En Réparation'),
(43, 'Robot41', 'Modele_1', 'Actif'),
(44, 'Robot42', 'Modele_5', 'Décommissionné'),
(45, 'Robot43', 'Modele_1', 'Actif'),
(46, 'Robot44', 'Modele_8', 'En Réparation'),
(47, 'Robot45', 'Modele_8', 'Décommissionné'),
(48, 'Robot46', 'Modele_9', 'En Réparation'),
(49, 'Robot47', 'Modele_4', 'Disparu'),
(50, 'Robot48', 'Modele_7', 'Disparu'),
(51, 'Robot49', 'Modele_10', 'Disparu'),
(52, 'Robot50', 'Modele_2', 'En Réparation'),
(53, 'Robot51', 'Modele_4', 'Disparu'),
(54, 'Robot52', 'Modele_1', 'Décommissionné'),
(55, 'Robot53', 'Modele_8', 'Actif'),
(56, 'Robot54', 'Modele_7', 'Décommissionné'),
(57, 'Robot55', 'Modele_8', 'Actif'),
(58, 'Robot56', 'Modele_8', 'Disparu'),
(59, 'Robot57', 'Modele_7', 'En Réparation'),
(60, 'Robot58', 'Modele_7', 'Actif'),
(61, 'Robot59', 'Modele_2', 'Actif'),
(62, 'Robot60', 'Modele_1', 'Actif'),
(63, 'Robot61', 'Modele_3', 'Actif'),
(64, 'Robot62', 'Modele_8', 'En Réparation'),
(65, 'Robot63', 'Modele_5', 'En Réparation'),
(66, 'Robot64', 'Modele_1', 'En Réparation'),
(67, 'Robot65', 'Modele_6', 'Disparu'),
(68, 'Robot66', 'Modele_7', 'Décommissionné'),
(69, 'Robot67', 'Modele_10', 'Actif'),
(70, 'Robot68', 'Modele_10', 'Actif'),
(71, 'Robot69', 'Modele_4', 'Décommissionné'),
(72, 'Robot70', 'Modele_7', 'Décommissionné'),
(73, 'Robot71', 'Modele_10', 'Actif'),
(74, 'Robot72', 'Modele_10', 'Actif'),
(75, 'Robot73', 'Modele_10', 'Actif'),
(76, 'Robot74', 'Modele_4', 'Disparu'),
(77, 'Robot75', 'Modele_10', 'Disparu'),
(78, 'Robot76', 'Modele_10', 'Décommissionné'),
(79, 'Robot77', 'Modele_10', 'Actif'),
(80, 'Robot78', 'Modele_1', 'Décommissionné'),
(81, 'Robot79', 'Modele_6', 'En Réparation'),
(82, 'Robot80', 'Modele_10', 'Disparu'),
(83, 'Robot81', 'Modele_4', 'En Réparation'),
(84, 'Robot82', 'Modele_6', 'Décommissionné'),
(85, 'Robot83', 'Modele_3', 'Décommissionné'),
(86, 'Robot84', 'Modele_2', 'Disparu'),
(87, 'Robot85', 'Modele_7', 'Actif'),
(88, 'Robot86', 'Modele_10', 'Disparu'),
(89, 'Robot87', 'Modele_4', 'En Réparation'),
(90, 'Robot88', 'Modele_6', 'Disparu'),
(91, 'Robot89', 'Modele_7', 'En Réparation'),
(92, 'Robot90', 'Modele_3', 'Actif'),
(93, 'Robot91', 'Modele_1', 'Décommissionné'),
(94, 'Robot92', 'Modele_9', 'Décommissionné'),
(95, 'Robot93', 'Modele_5', 'En Réparation'),
(96, 'Robot94', 'Modele_8', 'En Réparation'),
(97, 'Robot95', 'Modele_4', 'Disparu'),
(98, 'Robot96', 'Modele_8', 'Décommissionné'),
(99, 'Robot97', 'Modele_2', 'En Réparation'),
(100, 'Robot98', 'Modele_9', 'Actif'),
(101, 'Robot99', 'Modele_10', 'Décommissionné'),
(102, 'Robot100', 'Modele_10', 'Disparu');

-- --------------------------------------------------------

--
-- Structure de la table `robot_action`
--

CREATE TABLE `robot_action` (
  `ID_Robot` int(11) NOT NULL,
  `ID_Action` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `robot_action`
--

INSERT INTO `robot_action` (`ID_Robot`, `ID_Action`) VALUES
(1, 1),
(1, 48),
(1, 61),
(1, 88),
(1, 139),
(1, 146),
(1, 156),
(1, 188),
(1, 197),
(2, 2),
(2, 7),
(2, 45),
(2, 74),
(3, 33),
(3, 76),
(3, 138),
(3, 159),
(3, 162),
(3, 187),
(4, 23),
(4, 40),
(4, 93),
(4, 147),
(4, 170),
(4, 178),
(4, 185),
(5, 165),
(5, 184),
(5, 186),
(6, 20),
(6, 55),
(6, 59),
(6, 67),
(6, 96),
(6, 103),
(6, 122),
(6, 126),
(6, 173),
(6, 179),
(6, 185),
(7, 76),
(7, 97),
(7, 103),
(7, 148),
(7, 168),
(7, 194),
(8, 1),
(8, 47),
(8, 125),
(8, 137),
(8, 158),
(8, 190),
(9, 9),
(9, 31),
(9, 52),
(9, 110),
(9, 133),
(10, 2),
(10, 35),
(10, 107),
(10, 121),
(10, 125),
(10, 180),
(10, 181),
(11, 70),
(11, 89),
(11, 152),
(11, 154),
(11, 173),
(11, 191),
(12, 1),
(12, 58),
(12, 127),
(12, 160),
(12, 174),
(13, 36),
(13, 64),
(13, 85),
(13, 104),
(13, 133),
(13, 136),
(14, 4),
(14, 21),
(14, 41),
(14, 61),
(14, 186),
(15, 22),
(15, 46),
(15, 96),
(15, 98),
(15, 153),
(16, 21),
(16, 29),
(16, 64),
(16, 152),
(17, 31),
(17, 34),
(17, 44),
(17, 104),
(17, 120),
(18, 24),
(18, 45),
(18, 71),
(18, 105),
(18, 119),
(18, 161),
(19, 36),
(19, 46),
(19, 86),
(19, 166),
(20, 32),
(20, 52),
(20, 84),
(20, 94),
(20, 182),
(21, 100),
(21, 103),
(21, 107),
(21, 111),
(21, 151),
(22, 2),
(22, 53),
(22, 76),
(22, 131),
(22, 140),
(22, 186),
(23, 29),
(23, 38),
(23, 145),
(23, 160),
(23, 161),
(23, 165),
(23, 181),
(24, 14),
(24, 21),
(24, 66),
(24, 68),
(24, 80),
(24, 88),
(24, 94),
(24, 97),
(24, 153),
(24, 192),
(25, 20),
(25, 31),
(25, 52),
(25, 86),
(25, 93),
(25, 101),
(25, 117),
(26, 10),
(26, 54),
(26, 141),
(26, 162),
(26, 168),
(27, 113),
(27, 128),
(28, 123),
(28, 193),
(29, 15),
(29, 21),
(29, 27),
(29, 44),
(29, 99),
(29, 178),
(30, 20),
(30, 50),
(30, 57),
(30, 118),
(30, 129),
(30, 157),
(31, 160),
(31, 182),
(32, 45),
(32, 58),
(32, 59),
(32, 87),
(32, 189),
(33, 23),
(33, 46),
(33, 88),
(33, 140),
(33, 155),
(33, 157),
(34, 67),
(34, 77),
(34, 166),
(35, 65),
(35, 197),
(36, 3),
(36, 57),
(36, 89),
(36, 146),
(37, 14),
(37, 68),
(37, 156),
(38, 40),
(38, 70),
(38, 115),
(38, 151),
(39, 55),
(39, 66),
(39, 72),
(39, 82),
(39, 101),
(40, 15),
(40, 184),
(40, 193),
(41, 52),
(41, 154),
(42, 90),
(42, 115),
(42, 128),
(43, 12),
(43, 73),
(43, 88),
(43, 108),
(43, 115),
(43, 139),
(44, 47),
(44, 79),
(44, 131),
(45, 18),
(45, 25),
(45, 36),
(45, 51),
(45, 63),
(45, 99),
(45, 101),
(45, 161),
(45, 184),
(46, 83),
(46, 128),
(46, 160),
(46, 177),
(47, 89),
(47, 111),
(47, 118),
(47, 138),
(48, 17),
(48, 80),
(48, 94),
(49, 20),
(49, 42),
(49, 62),
(50, 3),
(50, 10),
(50, 66),
(50, 82),
(50, 98),
(50, 138),
(50, 141),
(50, 144),
(50, 152),
(51, 26),
(51, 126),
(51, 131),
(51, 181),
(52, 58),
(52, 69),
(52, 71),
(52, 108),
(52, 142),
(52, 145),
(52, 147),
(52, 154),
(52, 164),
(52, 179),
(53, 44),
(53, 103),
(53, 126),
(53, 140),
(53, 157),
(54, 27),
(54, 33),
(54, 50),
(54, 185),
(55, 51),
(55, 91),
(55, 116),
(55, 128),
(55, 161),
(56, 111),
(56, 118),
(56, 171),
(57, 7),
(57, 33),
(57, 36),
(57, 62),
(57, 127),
(57, 132),
(57, 150),
(57, 173),
(57, 198),
(58, 14),
(58, 31),
(58, 42),
(58, 47),
(58, 101),
(58, 119),
(59, 5),
(59, 64),
(59, 116),
(59, 129),
(59, 132),
(59, 140),
(59, 180),
(59, 192),
(60, 51),
(60, 97),
(60, 147),
(60, 186),
(60, 188),
(61, 17),
(61, 56),
(61, 66),
(61, 76),
(61, 94),
(61, 139),
(61, 171),
(62, 29),
(62, 39),
(62, 51),
(62, 88),
(62, 92),
(62, 118),
(62, 131),
(62, 152),
(62, 155),
(63, 46),
(63, 48),
(63, 50),
(63, 80),
(63, 109),
(63, 159),
(63, 183),
(63, 198),
(64, 18),
(64, 20),
(64, 83),
(64, 147),
(64, 159),
(64, 172),
(64, 179),
(64, 198),
(65, 90),
(65, 96),
(65, 130),
(65, 142),
(65, 153),
(65, 166),
(66, 98),
(66, 122),
(67, 45),
(67, 59),
(67, 61),
(67, 62),
(67, 186),
(68, 13),
(68, 38),
(68, 51),
(68, 72),
(68, 113),
(69, 76),
(69, 113),
(69, 139),
(70, 4),
(71, 58),
(71, 143),
(72, 159),
(73, 108),
(73, 163),
(73, 187),
(74, 34),
(74, 52),
(74, 58),
(74, 81),
(74, 131),
(74, 172),
(74, 199),
(75, 3),
(75, 73),
(75, 92),
(75, 108),
(75, 153),
(76, 96),
(76, 128),
(76, 132),
(76, 144),
(76, 192),
(77, 30),
(77, 83),
(77, 121),
(77, 165),
(78, 71),
(78, 114),
(79, 53),
(79, 85),
(79, 128),
(81, 5),
(81, 13),
(81, 42),
(81, 124),
(81, 149),
(81, 180),
(82, 20),
(82, 28),
(82, 35),
(82, 175),
(82, 191),
(83, 16),
(83, 46),
(83, 83),
(83, 104),
(83, 132),
(83, 148),
(83, 160),
(83, 198),
(84, 56),
(84, 59),
(84, 95),
(84, 179),
(85, 22),
(85, 61),
(85, 92),
(85, 108),
(86, 110),
(86, 154),
(87, 73),
(87, 94),
(87, 182),
(88, 5),
(88, 23),
(88, 31),
(88, 34),
(88, 37),
(88, 157),
(88, 188),
(89, 20),
(89, 52),
(89, 114),
(89, 116),
(90, 10),
(90, 20),
(90, 35),
(90, 118),
(90, 135),
(91, 78),
(91, 116),
(91, 182),
(91, 183),
(92, 32),
(92, 45),
(92, 48),
(92, 122),
(92, 149),
(92, 200),
(93, 81),
(94, 98),
(94, 114),
(94, 117),
(94, 138),
(94, 147),
(94, 153),
(94, 192),
(94, 197),
(94, 198),
(95, 55),
(95, 96),
(95, 118),
(95, 131),
(95, 190),
(96, 10),
(96, 20),
(96, 59),
(96, 74),
(96, 136),
(97, 51),
(97, 61),
(97, 74),
(97, 117),
(97, 173),
(97, 188),
(98, 22),
(98, 85),
(99, 1),
(99, 6),
(99, 9),
(99, 12),
(99, 88),
(99, 162),
(99, 181),
(100, 5),
(100, 87),
(100, 106),
(100, 189);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `action`
--
ALTER TABLE `action`
  ADD PRIMARY KEY (`ID_Action`);

--
-- Index pour la table `humain`
--
ALTER TABLE `humain`
  ADD PRIMARY KEY (`ID_Humain`);

--
-- Index pour la table `humain_action`
--
ALTER TABLE `humain_action`
  ADD PRIMARY KEY (`ID_Humain`,`ID_Action`),
  ADD KEY `ID_Action` (`ID_Action`);

--
-- Index pour la table `rapport_incidence`
--
ALTER TABLE `rapport_incidence`
  ADD PRIMARY KEY (`ID_Rapport`),
  ADD KEY `ID_Action` (`ID_Action`);

--
-- Index pour la table `robot`
--
ALTER TABLE `robot`
  ADD PRIMARY KEY (`ID_Robot`);

--
-- Index pour la table `robot_action`
--
ALTER TABLE `robot_action`
  ADD PRIMARY KEY (`ID_Robot`,`ID_Action`),
  ADD KEY `ID_Action` (`ID_Action`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `action`
--
ALTER TABLE `action`
  MODIFY `ID_Action` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=203;

--
-- AUTO_INCREMENT pour la table `humain`
--
ALTER TABLE `humain`
  MODIFY `ID_Humain` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pour la table `rapport_incidence`
--
ALTER TABLE `rapport_incidence`
  MODIFY `ID_Rapport` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `robot`
--
ALTER TABLE `robot`
  MODIFY `ID_Robot` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `humain_action`
--
ALTER TABLE `humain_action`
  ADD CONSTRAINT `humain_action_ibfk_1` FOREIGN KEY (`ID_Humain`) REFERENCES `humain` (`ID_Humain`) ON DELETE CASCADE,
  ADD CONSTRAINT `humain_action_ibfk_2` FOREIGN KEY (`ID_Action`) REFERENCES `action` (`ID_Action`) ON DELETE CASCADE;

--
-- Contraintes pour la table `rapport_incidence`
--
ALTER TABLE `rapport_incidence`
  ADD CONSTRAINT `rapport_incidence_ibfk_1` FOREIGN KEY (`ID_Action`) REFERENCES `action` (`ID_Action`) ON DELETE CASCADE;

--
-- Contraintes pour la table `robot_action`
--
ALTER TABLE `robot_action`
  ADD CONSTRAINT `robot_action_ibfk_1` FOREIGN KEY (`ID_Robot`) REFERENCES `robot` (`ID_Robot`) ON DELETE CASCADE,
  ADD CONSTRAINT `robot_action_ibfk_2` FOREIGN KEY (`ID_Action`) REFERENCES `action` (`ID_Action`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
