-- phpMyAdmin SQL Dump
-- version OVH
-- https://www.phpmyadmin.net/
--
-- Hôte : wildgoatqwsql.mysql.db
-- Généré le :  mar. 10 déc. 2019 à 17:34
-- Version du serveur :  5.6.43-log
-- Version de PHP :  7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `wildgoatqwsql`
--

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

CREATE TABLE `personne` (
  `no_pers` int(11) NOT NULL,
  `prenom_pers` varchar(32) NOT NULL,
  `nom_pers` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `personne`
--

INSERT INTO `personne` (`no_pers`, `prenom_pers`, `nom_pers`) VALUES
(1, 'ric', 'hochet'),
(2, 'emmanuel', 'macron'),
(3, 'henry', 'cover'),
(4, 'annie', 'hastur'),
(5, 'edmundo', 'doctor'),
(6, 'garen', 'crownguard'),
(7, 'graves', 'malcolm'),
(8, 'heimerdinger', 'cecil b'),
(9, 'irelia', 'lito'),
(10, 'janna', 'windforce');

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE `question` (
  `no_question` int(11) NOT NULL,
  `libelle` varchar(256) NOT NULL,
  `no_theme` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `question`
--

INSERT INTO `question` (`no_question`, `libelle`, `no_theme`) VALUES
(1, 'Quelle équipe a gagné le World 2015 ?', 1),
(2, 'Combien de rangs existe-t-il en saison 9 ?', 1),
(3, 'Combien d\'armes possède Aphelios?', 1),
(4, 'Combien de champions sont dans League of Legends en comptant Aphelios ?', 1),
(5, 'En quelle année League of Legends est-elle devenue opérationnelle?', 1),
(6, 'Quelle bière vient du Cambodge?', 2),
(7, 'Parmi ces options, quel pays exporte le plus de bière?', 2),
(8, 'Quelle est la bière préférée de monsieur Heulluy?', 2),
(9, 'Parmi ces options, laquelle n\'est pas une bière?', 2),
(10, 'Quel est le taux d\'alcool moyen dans la bière?', 2),
(11, 'Combien de sports sont représentés aux Jeux olympiques de 2020?', 3),
(12, 'Combien de fois la France a-t-elle accueilli les Jeux olympiques?', 3),
(13, 'Qui est l\'hôte des Jeux olympiques de 2024?', 3),
(14, 'Combien de médailles la France a-t-elle aux Jeux olympiques, Jeux olympiques d\'été et Jeux olympiques d\'hiver confondus?', 3),
(15, 'Quels ont été les premiers jeux olympiques internationaux?', 3),
(16, 'Parmi ce cocktail qui contient du Tobasco (sauce pimentée et acide) ?', 4),
(17, 'Comment appelez-t-on un cocktail non alcoolisé?', 4),
(18, 'Quel est le pourcentage moyen d\'alcool dans un cocktail?', 4),
(19, 'Que signifie commander un verre \"On the rocks\"?', 4),
(20, 'Y a-t-il une différence entre une liqueur et un liquor?', 4),
(21, 'Combien de pays y a-t-il dans l\'Union Européenne?', 5),
(22, 'Quel est le nom de l\'accord en Asie du Sud-Est?', 5),
(23, 'Combien de langues parlées y a-t-il dans le monde?', 5),
(24, 'Quel est le nom complet de l\'UNESCO?', 5),
(25, 'Qu\'est-ce qu\'un archipel?', 5);

-- --------------------------------------------------------

--
-- Structure de la table `questionnaire`
--

CREATE TABLE `questionnaire` (
  `no_quest` int(11) NOT NULL,
  `titres_quest` varchar(64) NOT NULL,
  `max` int(11) NOT NULL,
  `no_theme` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `questionnaire`
--

INSERT INTO `questionnaire` (`no_quest`, `titres_quest`, `max`, `no_theme`) VALUES
(1, 'League of Legends', 4, 1),
(2, 'Bière', 4, 2),
(3, 'Sport', 4, 3),
(4, 'Cocktail', 4, 4),
(5, 'Le Monde', 4, 5);

-- --------------------------------------------------------

--
-- Structure de la table `quest_session`
--

CREATE TABLE `quest_session` (
  `no_session` int(11) NOT NULL,
  `date_session` date NOT NULL,
  `no_quest` int(11) NOT NULL,
  `no_pers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `quest_session`
--

INSERT INTO `quest_session` (`no_session`, `date_session`, `no_quest`, `no_pers`) VALUES
(1, '2019-11-15', 1, 1),
(2, '2019-11-16', 1, 1),
(3, '2019-11-15', 2, 1),
(4, '2019-11-13', 2, 2),
(5, '2019-11-04', 1, 2),
(6, '2019-09-17', 2, 6),
(7, '2019-09-07', 3, 4),
(8, '2019-09-27', 3, 8),
(9, '2019-09-30', 2, 7),
(10, '2019-09-15', 4, 9),
(11, '2018-05-12', 3, 10),
(12, '2018-04-27', 1, 1),
(13, '2018-02-26', 3, 9),
(14, '2018-07-12', 4, 4),
(15, '2018-09-07', 5, 3),
(16, '2019-12-19', 3, 3),
(17, '2019-11-18', 4, 5),
(18, '2019-11-12', 4, 5),
(19, '2019-12-03', 1, 7);

-- --------------------------------------------------------

--
-- Structure de la table `rep_donnee`
--

CREATE TABLE `rep_donnee` (
  `no_session` int(11) NOT NULL,
  `no_question` int(11) NOT NULL,
  `no_ordre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `rep_donnee`
--

INSERT INTO `rep_donnee` (`no_session`, `no_question`, `no_ordre`) VALUES
(1, 4, 0),
(2, 4, 2),
(3, 7, 1),
(4, 9, 2),
(5, 2, 1),
(6, 10, 1),
(7, 11, 3),
(8, 16, 0),
(9, 6, 3),
(10, 20, 2),
(11, 16, 2),
(12, 4, 0),
(13, 14, 1),
(14, 17, 2),
(15, 22, 1),
(15, 23, 1),
(16, 12, 3),
(17, 16, 2),
(18, 16, 2),
(18, 17, 0);

-- --------------------------------------------------------

--
-- Structure de la table `rep_proposee`
--

CREATE TABLE `rep_proposee` (
  `no_question` int(11) NOT NULL,
  `no_ordre` int(11) NOT NULL,
  `lib_reponse` varchar(128) NOT NULL,
  `etat_rep` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `rep_proposee`
--

INSERT INTO `rep_proposee` (`no_question`, `no_ordre`, `lib_reponse`, `etat_rep`) VALUES
(1, 0, 'Fnatic', 0),
(1, 1, 'KOO Tigers', 0),
(1, 2, 'SK Telecom T1', 1),
(1, 3, 'Origen', 0),
(2, 0, '9', 1),
(2, 1, '8', 0),
(2, 2, '7', 0),
(2, 3, '6', 0),
(3, 0, '7', 0),
(3, 1, '6', 0),
(3, 2, '5', 1),
(3, 3, '4', 0),
(4, 0, '144', 0),
(4, 1, '145', 0),
(4, 2, '146', 1),
(4, 3, '147', 0),
(5, 0, '2008', 0),
(5, 1, '2009', 1),
(5, 2, '2010', 0),
(5, 3, '2011', 0),
(6, 0, 'Angkor Beer', 1),
(6, 1, 'Singha beer', 0),
(6, 2, 'Sapporo beer', 0),
(6, 3, 'Hite beer', 0),
(7, 0, 'France', 0),
(7, 1, 'Ireland', 0),
(7, 2, 'Mexique', 1),
(7, 3, 'les États-Unis d\'Amérique', 0),
(8, 0, 'Grimbergen', 0),
(8, 1, 'Guiness', 0),
(8, 2, 'Bon Poison', 1),
(8, 3, 'Ethanol', 0),
(9, 0, 'Heineken', 0),
(9, 1, 'Desperado', 0),
(9, 2, 'Corona', 0),
(9, 3, 'Niqita', 1),
(10, 0, '5.6%', 0),
(10, 1, '4.2%', 0),
(10, 2, '4.5%', 1),
(10, 3, '5.2%', 0),
(11, 0, '27', 0),
(11, 1, '28', 1),
(11, 2, '29', 0),
(11, 3, '30', 0),
(12, 0, '4', 0),
(12, 1, '5', 1),
(12, 2, '6', 0),
(12, 3, '7', 0),
(13, 0, 'France', 1),
(13, 1, 'Japon', 0),
(13, 2, 'Angleterre', 0),
(13, 3, 'les États-Unis d\'Amérique', 0),
(14, 0, '839', 0),
(14, 1, '840', 1),
(14, 2, '841', 0),
(14, 3, '842', 0),
(15, 0, '1888', 0),
(15, 1, '1892', 0),
(15, 2, '1896', 1),
(15, 3, '1900', 0),
(16, 0, 'Mojito', 0),
(16, 1, 'Bloody Mary', 1),
(16, 2, 'Corkscrew', 0),
(16, 3, 'Gin and Tonic', 0),
(17, 0, 'Cocktail sans alcohol', 0),
(17, 1, 'N\'existe pas', 0),
(17, 2, 'Mocktail', 1),
(17, 3, 'Virgin Cocktail', 0),
(18, 0, '12%', 0),
(18, 1, '12.5%', 1),
(18, 2, '13%', 0),
(18, 3, '13.5%', 0),
(19, 0, 'Il y aura du jus d\'olive et des olives dans le cocktail.', 0),
(19, 1, 'Le cocktail aura moins de vermouth.', 0),
(19, 2, 'Le cocktail est servi avec de la glace.', 1),
(19, 3, 'Le cocktail est mélangé avec du citron ou du citron vert et du sucre.', 0),
(20, 0, 'Oui', 1),
(20, 1, 'Non', 0),
(20, 2, 'Peut être', 0),
(20, 3, 'Je ne sais pas.', 0),
(21, 0, '25', 0),
(21, 1, '26', 0),
(21, 2, '27', 0),
(21, 3, '28', 1),
(22, 0, 'The Association of South Eastern Asian Nations', 0),
(22, 1, 'The Association of South East Asian Nations', 1),
(22, 2, 'The Association of South East Asian Nationalities', 0),
(22, 3, 'The Associates of South East Asian Nations', 0),
(23, 0, '6500', 1),
(23, 1, '6400', 0),
(23, 2, '6300', 0),
(23, 3, '6200', 0),
(24, 0, 'The United Nationalities Educational, Scientific and Cultural Organization ', 0),
(24, 1, 'The United Nations Educational, Scientific and Cultural Organization ', 1),
(24, 2, 'The United Nations Educational, Scientific and Cultured Organization ', 0),
(24, 3, 'The United Nations Educational, Scientific and Cultural Organizational ', 0),
(25, 0, 'Je ne sais pas.', 0),
(25, 1, 'Un pays.', 0),
(25, 2, 'Un vaste groupe d\'îles.', 1),
(25, 3, 'Une nation.', 0);

-- --------------------------------------------------------

--
-- Structure de la table `se_compose`
--

CREATE TABLE `se_compose` (
  `no_quest` int(11) NOT NULL,
  `no_question` int(11) NOT NULL,
  `no_ordre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `se_compose`
--

INSERT INTO `se_compose` (`no_quest`, `no_question`, `no_ordre`) VALUES
(1, 1, 0),
(1, 2, 1),
(1, 3, 2),
(1, 4, 3),
(1, 5, 4),
(2, 6, 0),
(2, 7, 1),
(2, 8, 2),
(2, 9, 3),
(2, 10, 4),
(3, 11, 0),
(3, 12, 1),
(3, 13, 2),
(3, 14, 3),
(3, 15, 4),
(4, 16, 0),
(4, 17, 1),
(4, 18, 2),
(4, 19, 3),
(4, 20, 4),
(5, 21, 0),
(5, 22, 1),
(5, 23, 2),
(5, 24, 3),
(5, 25, 4);

-- --------------------------------------------------------

--
-- Structure de la table `theme`
--

CREATE TABLE `theme` (
  `no_theme` int(11) NOT NULL,
  `libelle_theme` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `theme`
--

INSERT INTO `theme` (`no_theme`, `libelle_theme`) VALUES
(1, 'League Of Legends'),
(2, 'Bière'),
(3, 'Sport'),
(4, 'Cocktail'),
(5, 'Le Monde');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `personne`
--
ALTER TABLE `personne`
  ADD PRIMARY KEY (`no_pers`);

--
-- Index pour la table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`no_question`),
  ADD KEY `no-theme` (`no_theme`);

--
-- Index pour la table `questionnaire`
--
ALTER TABLE `questionnaire`
  ADD PRIMARY KEY (`no_quest`),
  ADD KEY `no-theme` (`no_theme`);

--
-- Index pour la table `quest_session`
--
ALTER TABLE `quest_session`
  ADD PRIMARY KEY (`no_session`),
  ADD KEY `no-quest` (`no_quest`),
  ADD KEY `session_ibfk_2` (`no_pers`);

--
-- Index pour la table `rep_donnee`
--
ALTER TABLE `rep_donnee`
  ADD PRIMARY KEY (`no_session`,`no_question`),
  ADD KEY `no-question` (`no_question`);

--
-- Index pour la table `rep_proposee`
--
ALTER TABLE `rep_proposee`
  ADD PRIMARY KEY (`no_question`,`no_ordre`);

--
-- Index pour la table `se_compose`
--
ALTER TABLE `se_compose`
  ADD PRIMARY KEY (`no_quest`,`no_question`),
  ADD KEY `no-question` (`no_question`);

--
-- Index pour la table `theme`
--
ALTER TABLE `theme`
  ADD PRIMARY KEY (`no_theme`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `personne`
--
ALTER TABLE `personne`
  MODIFY `no_pers` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `question`
--
ALTER TABLE `question`
  MODIFY `no_question` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `questionnaire`
--
ALTER TABLE `questionnaire`
  MODIFY `no_quest` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `quest_session`
--
ALTER TABLE `quest_session`
  MODIFY `no_session` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `theme`
--
ALTER TABLE `theme`
  MODIFY `no_theme` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`no_theme`) REFERENCES `theme` (`no_theme`);

--
-- Contraintes pour la table `questionnaire`
--
ALTER TABLE `questionnaire`
  ADD CONSTRAINT `questionnaire_ibfk_1` FOREIGN KEY (`no_theme`) REFERENCES `theme` (`no_theme`);

--
-- Contraintes pour la table `quest_session`
--
ALTER TABLE `quest_session`
  ADD CONSTRAINT `quest_session_ibfk_1` FOREIGN KEY (`no_quest`) REFERENCES `questionnaire` (`no_quest`),
  ADD CONSTRAINT `quest_session_ibfk_2` FOREIGN KEY (`no_pers`) REFERENCES `personne` (`no_pers`);

--
-- Contraintes pour la table `rep_donnee`
--
ALTER TABLE `rep_donnee`
  ADD CONSTRAINT `rep_donnee_ibfk_1` FOREIGN KEY (`no_question`) REFERENCES `question` (`no_question`),
  ADD CONSTRAINT `rep_donnee_ibfk_2` FOREIGN KEY (`no_session`) REFERENCES `quest_session` (`no_session`);

--
-- Contraintes pour la table `rep_proposee`
--
ALTER TABLE `rep_proposee`
  ADD CONSTRAINT `rep_proposee_ibfk_1` FOREIGN KEY (`no_question`) REFERENCES `question` (`no_question`);

--
-- Contraintes pour la table `se_compose`
--
ALTER TABLE `se_compose`
  ADD CONSTRAINT `se_compose_ibfk_1` FOREIGN KEY (`no_question`) REFERENCES `question` (`no_question`),
  ADD CONSTRAINT `se_compose_ibfk_2` FOREIGN KEY (`no_quest`) REFERENCES `questionnaire` (`no_quest`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
