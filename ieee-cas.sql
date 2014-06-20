-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Ven 20 Juin 2014 à 20:39
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
  `title` varchar(255) DEFAULT NULL,
  `acronym` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Contenu de la table `conference`
--

INSERT INTO `conference` (`id`, `user_id`, `model_id`, `id_iee`, `title`, `acronym`, `adress`, `description`, `start`, `end`, `progression`, `photo`, `created_at`, `updated_at`) VALUES
(21, 1, 1, 1287654, 'TexMex Conference', 'TxMC', 'Îles Australes, Polynésie française', 'This is a description... and this is something', '2015-11-27 10:00:00', '2015-11-29 20:00:00', 12, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20');

-- --------------------------------------------------------

--
-- Structure de la table `conference_tc_sponsor`
--

CREATE TABLE `conference_tc_sponsor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tc_sponsor_id` int(11) NOT NULL,
  `conference_id` int(11) NOT NULL,
  `active` tinyint(1) DEFAULT '3',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`tc_sponsor_id`,`conference_id`),
  KEY `fk_conference_tc_sponsor_tc_sponsor1_idx` (`tc_sponsor_id`),
  KEY `fk_conference_tc_sponsor_conference1_idx` (`conference_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Contenu de la table `conference_tc_sponsor`
--

INSERT INTO `conference_tc_sponsor` (`id`, `tc_sponsor_id`, `conference_id`, `active`, `created_at`, `updated_at`) VALUES
(22, 3, 21, 3, '2014-06-20 10:08:20', '2014-06-20 20:24:48'),
(23, 5, 21, 3, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(24, 6, 21, 3, '2014-06-20 10:08:20', '2014-06-20 10:08:20');

-- --------------------------------------------------------

--
-- Structure de la table `files`
--

CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conference_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_id` (`conference_id`),
  KEY `task_id` (`task_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

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
  `percentage` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`model_id`),
  KEY `fk_node_model1_idx` (`model_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Contenu de la table `node`
--

INSERT INTO `node` (`id`, `model_id`, `name`, `node_nbr`, `percentage`, `created_at`, `updated_at`) VALUES
(1, 1, 'Node 1', 1, 25, '2014-05-05 13:53:28', '2014-05-05 13:53:28'),
(2, 1, 'Node 2', 2, 37.5, '2014-05-05 13:53:49', '2014-05-05 13:53:49'),
(3, 1, 'Node 3', 3, 50.3, '2014-05-05 13:54:22', '2014-05-05 13:54:22'),
(4, 1, 'Node 4', 4, 62.5, '2014-05-26 15:14:51', '2014-05-26 15:14:51'),
(5, 1, 'Node 5', 5, 75, '2014-05-26 15:18:54', '2014-05-26 15:18:54'),
(6, 1, 'Node 6', 6, 84.4, '2014-05-26 15:20:09', '2014-05-26 15:20:09'),
(7, 1, 'Node 7', 7, 87.5, '2014-05-26 15:21:14', '2014-05-26 15:21:14'),
(8, 1, 'Node 8', 8, 91.7, '2014-05-26 15:22:38', '2014-05-26 15:22:38'),
(9, 1, 'Node 9', 9, 98.1, '2014-05-26 15:22:50', '2014-05-26 15:22:50'),
(10, 1, 'Node 10', 10, 99, '2014-05-26 15:23:01', '2014-05-26 15:23:01'),
(11, 1, 'Node 11', 11, 100, '2014-05-26 15:25:17', '2014-05-26 15:25:17'),
(12, 1, 'Node 12', 12, 102.56, '2014-05-26 15:26:25', '2014-05-26 15:26:25'),
(13, 1, 'Node 13', 13, 106.73, '2014-05-26 15:27:07', '2014-05-26 15:27:07'),
(14, 1, 'Node 14', 14, 119.23, '2014-05-26 15:27:51', '2014-05-26 15:27:51'),
(15, 1, 'Node 15', 15, 123.2, '2014-05-26 15:29:18', '2014-05-26 15:29:18'),
(16, 1, 'Node 16', 16, 125, '2014-05-26 15:29:58', '2014-05-26 15:29:58');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=241 ;

--
-- Contenu de la table `node_conference`
--

INSERT INTO `node_conference` (`id`, `node_id`, `conference_id`, `start_date`, `end_date`, `progression`) VALUES
(209, 1, 21, '0000-00-00', '2014-10-30', 100),
(210, 2, 21, '0000-00-00', '2015-01-03', 60),
(211, 3, 21, '0000-00-00', '2015-03-12', 6),
(212, 4, 21, '0000-00-00', '2015-05-15', 0),
(213, 5, 21, '0000-00-00', '2015-07-20', 0),
(214, 6, 21, '0000-00-00', '2015-09-07', 0),
(215, 7, 21, '0000-00-00', '2015-09-23', 0),
(216, 8, 21, '0000-00-00', '2015-10-15', 0),
(217, 9, 21, '0000-00-00', '2015-11-18', 0),
(218, 10, 21, '0000-00-00', '2015-11-23', 0),
(219, 11, 21, '0000-00-00', '2015-11-28', 0),
(220, 12, 21, '0000-00-00', '2015-12-11', 0),
(221, 13, 21, '0000-00-00', '2016-01-02', 0),
(222, 14, 21, '0000-00-00', '2016-03-08', 0),
(223, 15, 21, '0000-00-00', '2016-03-29', 0),
(224, 16, 21, '0000-00-00', '2016-04-08', 0);

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
  `upload` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`,`node_id`),
  KEY `fk_tasks_list_node1_idx` (`node_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=75 ;

--
-- Contenu de la table `tasks_list`
--

INSERT INTO `tasks_list` (`id`, `node_id`, `name`, `description`, `link`, `link_name`, `date`, `upload`) VALUES
(1, 1, 'submit Memorandum of Understanding(MOU), if applicable', NULL, NULL, NULL, NULL, 0),
(2, 1, 'contract conference management company, if applicable', NULL, NULL, NULL, NULL, 0),
(9, 1, 'Site selection and contract review, if applicable', NULL, NULL, NULL, NULL, 0),
(11, 1, 'Review IEEE Insurance coverage and determine if additional coverage is required', NULL, NULL, NULL, NULL, 0),
(12, 1, 'Review tax information to ensure IRS and international compliance VAT and GST', NULL, NULL, NULL, NULL, 0),
(13, 2, 'Develop communications plan, marketing materials and conference website', NULL, NULL, NULL, NULL, 0),
(14, 2, 'Send request for proposal (RFP) to exhibit decorators and develop exhibitor prospectus, if applicable', NULL, NULL, NULL, NULL, 0),
(15, 2, 'Begin outreach to educational institutions, corporations, government and industry for support and patronage', NULL, NULL, NULL, NULL, 0),
(16, 2, 'Apply for grants for conference support', NULL, NULL, NULL, NULL, 0),
(17, 2, 'Secure W-8 and/ or W-9 forms for tax compliance', NULL, NULL, NULL, NULL, 0),
(18, 3, 'Develop process/ identity system for paper management', NULL, NULL, NULL, NULL, 0),
(19, 3, 'Develop technical program, establish paper submission process and deadlines', NULL, NULL, NULL, NULL, 0),
(20, 3, 'Establish a call for paper (CFP)', NULL, NULL, NULL, NULL, 1),
(21, 3, 'Establish a visa process for international attendees and post on conference website', NULL, NULL, NULL, NULL, 0),
(22, 3, 'Submit conference budget with written IEEE OU approval(s) for headquarter review', NULL, NULL, NULL, NULL, 0),
(23, 3, 'Submit Principles of Business Conduct Compliance Certificate and Conflict of Interests Disclosure Statement (POBC/COI) forms', NULL, NULL, NULL, NULL, 0),
(24, 3, 'Submit updated committee lists', NULL, NULL, NULL, NULL, 0),
(25, 3, 'Establish conference bank account(s)', NULL, NULL, NULL, NULL, 0),
(26, 3, 'Request and obtain loan from OU, if needed', NULL, NULL, NULL, NULL, 0),
(27, 3, 'Pre-and Post conference forecasts [submit Pre-and Post conference forecasts by November 30th of each calendar year for accrual purposes] ', NULL, NULL, NULL, NULL, 0),
(28, 3, '1099 & 1042 Schedule of Payments [no later than January 10th of each year for all payments made in the previous calendar year]', NULL, NULL, NULL, NULL, 0),
(29, 3, 'Submit annual report on foreign bank accounts To IEEE tax Dept [no later than January 10th of each year for all payments made in the previous calendar year]', NULL, NULL, NULL, NULL, 0),
(30, 3, 'Promote CFP and exhibit prospectus at current year’s conference, if applicable', NULL, NULL, NULL, NULL, 0),
(31, 3, 'Review and reconfirm hotel, meeting space and room block', NULL, NULL, NULL, NULL, 0),
(32, 3, 'Meeting with previous year’s committee to discuss best practices', NULL, NULL, NULL, NULL, 0),
(33, 4, 'Submit Conference Publication Form to obtain Letter Of Acquisition(LOA)', NULL, NULL, NULL, NULL, 0),
(34, 4, 'Register for PDF eXpress (optional)', NULL, NULL, NULL, NULL, 0),
(35, 4, 'Register for Electronic IEEE Copyright Form (eCF) if proceedings are acquired by IEEE', NULL, NULL, NULL, NULL, 0),
(37, 4, 'Create website for paper submissions, work with paper management company, if applicable', NULL, NULL, NULL, NULL, 0),
(38, 4, 'Secure permission from related IEEE OUs to market to their members using e-Notice', NULL, NULL, NULL, NULL, 0),
(39, 5, 'Create registration formand ensure registration service is Payment Card Industry (PCI) compliant', NULL, NULL, NULL, NULL, 0),
(40, 5, 'Plan social activities and tour program if applicable', NULL, NULL, NULL, NULL, 0),
(41, 5, 'Send out RFPs for ground transportation and finalize contract, if applicable', NULL, NULL, NULL, NULL, 0),
(42, 6, 'Launch registration site', NULL, NULL, NULL, NULL, 0),
(43, 6, 'Complete paper review process. Finalize technical program. Notify speakers', NULL, NULL, NULL, NULL, 0),
(44, 6, 'Create and publish advanced program', NULL, NULL, NULL, NULL, 0),
(45, 7, 'Solicit bids from printers and/or CD manufacturers based on accepted papers', NULL, NULL, NULL, NULL, 0),
(46, 7, 'Organize and prepare for production of conference publications per Letter of Acquisition (LOA)', NULL, NULL, NULL, NULL, 0),
(47, 7, 'Order attendee giveaways, speaker gifts, and/or conference shirts', NULL, NULL, NULL, NULL, 0),
(48, 7, 'Determine preliminary exhibitor space assignments, if applicable', NULL, NULL, NULL, NULL, 0),
(49, 7, 'Request weekly reports from hotel(s) regarding rooms', NULL, NULL, NULL, NULL, 0),
(50, 8, 'Review room block with hotel(s) against attendance and contract(s)', NULL, NULL, NULL, NULL, 0),
(51, 8, 'Complete & print final program, advertising/publicity and registration reminders', NULL, NULL, NULL, NULL, 0),
(52, 8, 'Develop & finalize volunteer job functions/onsite needs', NULL, NULL, NULL, NULL, 0),
(53, 9, 'Deadline for early registration (predetermined date)', NULL, NULL, NULL, NULL, 0),
(54, 9, 'Send prelim specifications [set up, catering, audio visual (AV) ] to conference site. Order signage and recognition products (plaques, certificates and awards).', NULL, NULL, NULL, NULL, 0),
(55, 9, 'Ship final program to conference site', NULL, NULL, NULL, NULL, 0),
(56, 9, 'Submit Pre-Conference forecast', NULL, NULL, NULL, NULL, 0),
(57, 10, 'Confirm onsite logistics with venue (registration, exhibits, meeting rooms, food & beverage)', NULL, NULL, NULL, NULL, 0),
(58, 10, 'Set-up registration area, exhibit space, information booth, office area', NULL, NULL, NULL, NULL, 0),
(59, 11, 'Onsite registration', NULL, NULL, NULL, NULL, 0),
(60, 11, 'Monitor budget', NULL, NULL, NULL, NULL, 0),
(61, 11, 'Monitor daily activities and adjust onsite logistics as needed', NULL, NULL, NULL, NULL, 0),
(62, 11, 'Hold Post-Conference Wrap Up Meeting', NULL, NULL, NULL, NULL, 0),
(63, 12, 'Submit Conference Proceedings/Content (Xplore CD and other media types) per Letter of Acquisition (LOA)', NULL, NULL, NULL, NULL, 0),
(64, 12, 'Committee members submit final statistics and lessons learned to sponsoring IEEE OU', NULL, NULL, NULL, NULL, 0),
(65, 13, 'Submit Conference Proceedings/Content (Xplore CD and other media types) per Letter of Acquisition (LOA) » (même tâche de 12ème nœud)', NULL, NULL, NULL, NULL, 0),
(66, 13, 'Registration clean up (process refunds, receipts and balances due)', NULL, NULL, NULL, NULL, 0),
(67, 14, 'Submit Conference Proceedings/Content (Xplore CD and other media types) per Letter of Acquisition (LOA) » (même tâche que 12ème noeud)', NULL, NULL, NULL, NULL, 0),
(68, 14, 'Process outstanding bills', NULL, NULL, NULL, NULL, 0),
(69, 14, 'Repay all loans', NULL, NULL, NULL, NULL, 0),
(70, 14, 'Submit post-conference forecast', NULL, NULL, NULL, NULL, 0),
(71, 15, 'Distribute surplus» Cette tâche est à valider par GC * « Close conference bank account & submit proof of account closure', NULL, NULL, NULL, NULL, 0),
(72, 15, 'Submit final financial report with Certification of Accuracy', NULL, NULL, NULL, NULL, 0),
(73, 16, 'Prepare and submit all audit material to independent auditor audit report for >$100K and/or IEEE OU total is 51% + co-sponsor', NULL, NULL, NULL, NULL, 0),
(74, 16, 'Submit final financial report with Certification of Accuracy', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `task_validation`
--

CREATE TABLE `task_validation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conference_id` int(11) NOT NULL,
  `tasks_list_id` int(11) NOT NULL,
  `validation` tinyint(1) NOT NULL DEFAULT '0',
  `file_uploaded` tinyint(4) NOT NULL DEFAULT '0',
  `limit_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`conference_id`,`tasks_list_id`),
  KEY `fk_task_validation_conference1_idx` (`conference_id`),
  KEY `fk_task_validation_tasks_list1_idx` (`tasks_list_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=991 ;

--
-- Contenu de la table `task_validation`
--

INSERT INTO `task_validation` (`id`, `conference_id`, `tasks_list_id`, `validation`, `file_uploaded`, `limit_date`, `created_at`, `updated_at`) VALUES
(859, 21, 1, 1, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(860, 21, 2, 1, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(861, 21, 9, 1, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(862, 21, 11, 1, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(863, 21, 12, 1, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(864, 21, 13, 1, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(865, 21, 14, 1, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(866, 21, 15, 1, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(867, 21, 16, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(868, 21, 17, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(869, 21, 24, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(870, 21, 25, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(871, 21, 26, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(872, 21, 27, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(873, 21, 28, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(874, 21, 29, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(875, 21, 30, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(876, 21, 31, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(877, 21, 32, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(878, 21, 18, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(879, 21, 19, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(880, 21, 20, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(881, 21, 21, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(882, 21, 22, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(883, 21, 23, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(884, 21, 33, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(885, 21, 34, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(886, 21, 35, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(887, 21, 37, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(888, 21, 38, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(889, 21, 41, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(890, 21, 39, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(891, 21, 40, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(892, 21, 42, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(893, 21, 43, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(894, 21, 44, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(895, 21, 45, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(896, 21, 46, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(897, 21, 47, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(898, 21, 48, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(899, 21, 49, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(900, 21, 50, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(901, 21, 51, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(902, 21, 52, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(903, 21, 53, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(904, 21, 54, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(905, 21, 55, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(906, 21, 56, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(907, 21, 57, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(908, 21, 58, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(909, 21, 59, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(910, 21, 60, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(911, 21, 61, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(912, 21, 62, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(913, 21, 63, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(914, 21, 64, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(915, 21, 65, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(916, 21, 66, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(917, 21, 67, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(918, 21, 68, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(919, 21, 69, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(920, 21, 70, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(921, 21, 71, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(922, 21, 72, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(923, 21, 73, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20'),
(924, 21, 74, 0, 0, NULL, '2014-06-20 10:08:20', '2014-06-20 10:08:20');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `tuto`
--

INSERT INTO `tuto` (`id`, `node_id`, `name`, `link`, `type`) VALUES
(1, 1, 'Test tuto', 'http://www.google.com', 'tuto'),
(2, 1, 'IEEE Standards', 'http://standards.ieee.org/', 'tuto'),
(3, 3, 'netbeans', 'https://fr.netbeans.org/', 'tuto'),
(4, 1, 'Xplore', 'http://ieeexplore.ieee.org/Xplore/home.jsp', 'tool'),
(5, 2, 'Eclipse', 'http://www.eclipse.org/', 'tool'),
(6, 3, 'ePaper', 'http://ieee-cas.org/', 'tool'),
(7, 3, 'EDAS', 'http://www.edas.info/', 'tool');

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
  `name` varchar(255) DEFAULT NULL,
  `affiliation` varchar(90) DEFAULT NULL,
  `type` enum('vpConference','organizer','admin','tc','sponsor') DEFAULT NULL,
  `photo` mediumtext,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Contenu de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `first_name`, `last_name`, `name`, `affiliation`, `type`, `photo`, `created_at`, `updated_at`) VALUES
(1, 'tferrand@isep.fr', 'ab4f63f9ac65152575886860dde480a1', 'Thomas', 'Fe', NULL, 'Test', 'organizer', NULL, '2014-05-08 01:57:17', '2014-05-08 01:57:17'),
(2, 'vp@isep.fr', '08f41e2b56730d87f1232d525303ba14', 'VP', 'VP', NULL, NULL, 'vpConference', NULL, '2014-05-18 15:16:26', '2014-05-18 15:16:26'),
(3, 'tc1@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Analog Signal Processing', NULL, 'tc', NULL, NULL, NULL),
(5, 'tc2@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Biomedical and Life Science Circuits and Systems', NULL, 'tc', NULL, NULL, NULL),
(6, 'tc3@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Cellular Nanoscale Networks and Array Computing', NULL, 'tc', NULL, NULL, NULL),
(7, 'tc4@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Circuits & Systems for Communications', NULL, 'tc', NULL, NULL, NULL),
(8, 'tc5@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Circuits and Systems Education and Outreach', NULL, 'tc', NULL, NULL, NULL),
(9, 'tc6@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Computer-Aided Network Design', NULL, 'tc', NULL, NULL, NULL),
(10, 'tc7@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Digital Signal Processing', NULL, 'tc', NULL, NULL, NULL),
(11, 'tc8@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Multimedia Systems & Applications', NULL, 'tc', NULL, NULL, NULL),
(12, 'tc9@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Nanoelectronics and Gigascale Systems', NULL, 'tc', NULL, NULL, NULL),
(13, 'tc10@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Neural Systems & Applications', NULL, 'tc', NULL, NULL, NULL),
(14, 'tc11@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Nonlinear Circuits & Systems', NULL, 'tc', NULL, NULL, NULL),
(15, 'tc12@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Power and Energy Circuits and Systems', NULL, 'tc', NULL, NULL, NULL),
(16, 'tc13@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Sensory Systems', NULL, 'tc', NULL, NULL, NULL),
(17, 'tc14@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'Visual Signal Processing & Communications', NULL, 'tc', NULL, NULL, NULL),
(18, 'tc15@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'VLSI Systems & Applications', NULL, 'tc', NULL, NULL, NULL),
(19, 'tferrand2@isep.fr', 'ab4f63f9ac65152575886860dde480a1', 'Tom', 'Fe', NULL, NULL, 'organizer', NULL, '2014-06-20 17:57:53', '2014-06-20 17:57:53');

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
  ADD CONSTRAINT `fk_conference_tc_sponsor_tc_sponsor1` FOREIGN KEY (`tc_sponsor_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`conference_id`) REFERENCES `conference` (`id`),
  ADD CONSTRAINT `files_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `tasks_list` (`id`);

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
