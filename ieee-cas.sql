-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Lun 26 Mai 2014 à 13:54
-- Version du serveur: 5.5.25
-- Version de PHP: 5.4.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données: `ieee-cas`
--

-- --------------------------------------------------------

--
-- Structure de la table `conference`
--

CREATE TABLE `conference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `id_iee` int(11) NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `adress` varchar(255) DEFAULT NULL,
  `description` text,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `progression` int(11) NOT NULL,
  `photo` mediumtext,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`user_id`,`model_id`),
  KEY `fk_conference_user1_idx` (`user_id`),
  KEY `fk_conference_model1_idx` (`model_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `conference`
--

INSERT INTO `conference` (`id`, `user_id`, `model_id`, `id_iee`, `title`, `adress`, `description`, `start`, `end`, `progression`, `photo`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 84787483, 'Conference test number 1', '46 rue de tolbiac, Paris', 'Test description conference 1', '2014-06-04 00:00:00', '2014-06-12 00:00:00', 85, NULL, '2014-05-08 01:58:57', '2014-05-08 01:58:57');

-- --------------------------------------------------------

--
-- Structure de la table `conference_tc_sponsor`
--

CREATE TABLE `conference_tc_sponsor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tc_sponsor_id` int(11) NOT NULL,
  `conference_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`tc_sponsor_id`,`conference_id`),
  KEY `fk_conference_tc_sponsor_tc_sponsor1_idx` (`tc_sponsor_id`),
  KEY `fk_conference_tc_sponsor_conference1_idx` (`conference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `model`
--

CREATE TABLE `model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `model`
--

INSERT INTO `model` (`id`, `name`) VALUES
(1, 'Model 1'),
(2, 'Model 2');

-- --------------------------------------------------------

--
-- Structure de la table `node`
--

CREATE TABLE `node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `node_nbr` int(11) DEFAULT NULL,
  `period` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`model_id`),
  KEY `fk_node_model1_idx` (`model_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `node`
--

INSERT INTO `node` (`id`, `model_id`, `name`, `node_nbr`, `period`, `created_at`, `updated_at`) VALUES
(1, 1, 'Node 1', 1, 0, '2014-05-05 13:53:28', '2014-05-05 13:53:28'),
(2, 1, 'Node 2', 2, 0, '2014-05-05 13:53:49', '2014-05-05 13:53:49'),
(3, 1, 'Node 3', 3, 0, '2014-05-05 13:54:22', '2014-05-05 13:54:22');

-- --------------------------------------------------------

--
-- Structure de la table `node_conference`
--

CREATE TABLE `node_conference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `conference_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `progression` int(11) NOT NULL,
  PRIMARY KEY (`id`,`node_id`,`conference_id`),
  KEY `fk_node_conference_node1_idx` (`node_id`),
  KEY `fk_node_conference_conference1_idx` (`conference_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `node_conference`
--

INSERT INTO `node_conference` (`id`, `node_id`, `conference_id`, `start_date`, `end_date`, `progression`) VALUES
(1, 1, 1, '2014-05-22', '2014-05-28', 100),
(2, 2, 1, '2014-05-23', '2014-05-25', 66),
(3, 3, 1, '2014-05-24', '2014-06-09', 100);

-- --------------------------------------------------------

--
-- Structure de la table `sponsor`
--

CREATE TABLE `sponsor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `photo` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `tasks_list`
--

CREATE TABLE `tasks_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `link` mediumtext,
  `link_name` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`node_id`),
  KEY `fk_tasks_list_node1_idx` (`node_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `tasks_list`
--

INSERT INTO `tasks_list` (`id`, `node_id`, `name`, `description`, `link`, `link_name`, `date`) VALUES
(1, 1, 'submit Memorandum of Understanding(MOU), if applicable', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at mauris nec arcu sagittis gravida nec non ipsum. Nam rutrum nisi magna, et gravida diam pharetra vitae. Vivamus dictum ultricies tellus, sit amet auctor turpis malesuada eget. Nam cursus nulla quis euismod rhoncus. Donec ultrices tellus nulla, sed molestie dolor sodales quis. In in dui quis dui eleifend interdum quis in eros. Nullam cursus tempor suscipit. In at dolor eu arcu varius bibendum eget eget lorem.\n\nQuisque at leo lacinia, vestibulum nisl et, auctor dolor. Proin commodo sed ante quis bibendum. Integer vulputate vitae mauris et congue. Cras eleifend magna lorem. Phasellus lobortis commodo purus vitae sagittis. Nulla facilisi. Etiam diam diam, tristique et auctor eu, tristique non enim. Etiam massa mi, condimentum pellentesque dui at, volutpat ultrices justo. Maecenas faucibus nunc vitae quam rhoncus luctus. In cursus, dolor in vestibulum volutpat, ante dolor malesuada velit, eget pharetra sapien tellus at dolor. Nunc sit amet interdum quam.', 'http://ieee-cas.org/', 'Link to IEEE-CAS', NULL),
(2, 1, 'contract conference management company, if applicable', 'description 2', 'azaz', 'Link to subscription', NULL),
(3, 2, 'Task test', 'Put Your Best Face Forward: Getting to the Basics.This may sound cliché but the face truly is a passport to the world. Whether you''re at an interview, holding a meeting, or courting someone at your local bar, your face acts as an ambassador for your personality – giving those you interact with ...', NULL, NULL, NULL),
(4, 3, 'Fill the form on IEEE', 'Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l''imprimerie depuis les années 1500, quand un peintre anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n''a pas fait que survivre cinq siècles, mais s''est aussi adapté à la bureautique informatique, sans que son contenu n''en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente de feuilles Letraset contenant des passages du Lorem Ipsum, et, plus récemment, par son inclusion dans des applications de mise en page de texte, comme Aldus PageMaker.', 'http://fr.lipsum.com/', 'Site de Lorem Ipsum', NULL),
(5, 2, 'Send papers', 'Pellentesque blandit est eu eleifend faucibus. Vivamus in posuere felis. Cras ipsum nisl, elementum sit amet mauris vitae, bibendum posuere purus. Vestibulum sed nibh posuere leo semper tincidunt vitae eu metus. Integer vitae sapien placerat dolor sollicitudin lobortis et ut nibh. Mauris euismod tortor eleifend odio adipiscing dapibus. Sed ullamcorper risus non tortor venenatis, ut scelerisque quam interdum. Etiam ullamcorper nisi ipsum, bibendum vestibulum tortor convallis bibendum. Donec sit amet posuere nibh, sit amet cursus nulla. Nulla a malesuada massa. Quisque sed posuere enim. Sed pretium arcu quam, non tincidunt nisi accumsan nec. Nullam tempus vehicula metus, id convallis diam feugiat ac. Nam at molestie libero. In egestas convallis arcu, sit amet dapibus leo porta sed. Aenean convallis hendrerit turpis id vulputate.', NULL, NULL, NULL),
(6, 2, 'Sign papers', 'Aenean venenatis lacus eu accumsan posuere. Vestibulum lorem diam, varius eget varius id, tempor quis libero. Proin gravida sagittis turpis nec luctus. Cras volutpat ultricies tortor, at hendrerit orci tincidunt vitae. Nullam sit amet pellentesque metus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed dignissim sapien a purus bibendum dictum. Vivamus ut vehicula ipsum. Morbi rutrum nunc tincidunt lobortis consequat. Ut malesuada orci at consectetur dapibus. Vivamus tempus eu odio vitae ultricies. Curabitur luctus euismod eros nec suscipit. Pellentesque sit amet magna id mauris accumsan mollis. Ut volutpat neque varius risus pulvinar, sed commodo metus sagittis.', 'http://fr.lipsum.com/feed/html', 'Lorem Ipsum Site', NULL),
(7, 3, 'Task force', 'nnd nkndsk sjd kjsdksjdksj ldskd', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `task_validation`
--

CREATE TABLE `task_validation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conference_id` int(11) NOT NULL,
  `tasks_list_id` int(11) NOT NULL,
  `validation` tinyint(1) NOT NULL DEFAULT '0',
  `limit_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`conference_id`,`tasks_list_id`),
  KEY `fk_task_validation_conference1_idx` (`conference_id`),
  KEY `fk_task_validation_tasks_list1_idx` (`tasks_list_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=87 ;

--
-- Contenu de la table `task_validation`
--

INSERT INTO `task_validation` (`id`, `conference_id`, `tasks_list_id`, `validation`, `limit_date`, `created_at`, `updated_at`) VALUES
(80, 1, 1, 1, NULL, NULL, NULL),
(81, 1, 2, 1, NULL, NULL, NULL),
(82, 1, 3, 1, NULL, NULL, NULL),
(83, 1, 5, 1, NULL, NULL, NULL),
(84, 1, 6, 0, NULL, NULL, NULL),
(85, 1, 4, 1, NULL, NULL, NULL),
(86, 1, 7, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `tc_sponsor`
--

CREATE TABLE `tc_sponsor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `type` enum('tc','sponsor') DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `tuto`
--

CREATE TABLE `tuto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `type` enum('tuto','tool') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `tuto`
--

INSERT INTO `tuto` (`id`, `node_id`, `name`, `link`, `type`) VALUES
(1, 1, 'Test tuto', 'http://www.google.com', 'tuto'),
(2, 1, 'tuto 2', 'http://www.test.com', 'tuto'),
(3, 3, 'netbeans', 'http://www.google.com', 'tuto'),
(4, 1, 'Tool 1', 'test', 'tool'),
(5, 2, 'Eclipse', 'hey.com', 'tool');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `affiliation` varchar(90) DEFAULT NULL,
  `type` enum('vpConference','organizer','admin') DEFAULT NULL,
  `photo` mediumtext,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `first_name`, `last_name`, `birthday`, `affiliation`, `type`, `photo`, `created_at`, `updated_at`) VALUES
(1, 'tferrand@isep.fr', 'ab4f63f9ac65152575886860dde480a1', 'Thomas', 'Fe', '2012-12-04', 'Test', 'organizer', NULL, '2014-05-08 01:57:17', '2014-05-08 01:57:17'),
(2, 'vp@isep.fr', 'vp', 'VP', 'VP', NULL, NULL, 'vpConference', NULL, '2014-05-18 15:16:26', '2014-05-18 15:16:26');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `conference`
--
ALTER TABLE `conference`
  ADD CONSTRAINT `fk_conference_model1` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_conference_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `conference_tc_sponsor`
--
ALTER TABLE `conference_tc_sponsor`
  ADD CONSTRAINT `fk_conference_tc_sponsor_conference1` FOREIGN KEY (`conference_id`) REFERENCES `conference` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_conference_tc_sponsor_tc_sponsor1` FOREIGN KEY (`tc_sponsor_id`) REFERENCES `tc_sponsor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `node`
--
ALTER TABLE `node`
  ADD CONSTRAINT `fk_node_model1` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `node_conference`
--
ALTER TABLE `node_conference`
  ADD CONSTRAINT `fk_node_conference_conference1` FOREIGN KEY (`conference_id`) REFERENCES `conference` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_node_conference_node1` FOREIGN KEY (`node_id`) REFERENCES `node` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `tasks_list`
--
ALTER TABLE `tasks_list`
  ADD CONSTRAINT `fk_tasks_list_node1` FOREIGN KEY (`node_id`) REFERENCES `node` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `task_validation`
--
ALTER TABLE `task_validation`
  ADD CONSTRAINT `fk_task_validation_conference1` FOREIGN KEY (`conference_id`) REFERENCES `conference` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_task_validation_tasks_list1` FOREIGN KEY (`tasks_list_id`) REFERENCES `tasks_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
