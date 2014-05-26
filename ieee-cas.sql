-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Lun 26 Mai 2014 à 22:54
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `conference`
--

INSERT INTO `conference` (`id`, `user_id`, `model_id`, `id_iee`, `title`, `acronym`, `adress`, `description`, `start`, `end`, `progression`, `photo`, `created_at`, `updated_at`) VALUES
(6, 1, 1, 87645342, 'International Conference on ReConFigurable', 'ReConFig', 'Cancún, Quintana Roo, Mexique', 'ReConFig promotes the use of reconfigurable computing and FPGA technology for research, education, and applications, covering from hardware architectures and devices to custom computers and high performance systems.', '2016-12-10 08:00:00', '2016-12-12 20:00:00', 10, NULL, '2014-05-26 21:58:59', '2014-05-26 21:58:59');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Contenu de la table `node`
--

INSERT INTO `node` (`id`, `model_id`, `name`, `node_nbr`, `period`, `created_at`, `updated_at`) VALUES
(1, 1, 'Node 1', 1, NULL, '2014-05-05 13:53:28', '2014-05-05 13:53:28'),
(2, 1, 'Node 2', 2, NULL, '2014-05-05 13:53:49', '2014-05-05 13:53:49'),
(3, 1, 'Node 3', 3, NULL, '2014-05-05 13:54:22', '2014-05-05 13:54:22'),
(4, 1, 'Node 4', 4, NULL, '2014-05-26 15:14:51', '2014-05-26 15:14:51'),
(5, 1, 'Node 5', 5, NULL, '2014-05-26 15:18:54', '2014-05-26 15:18:54'),
(6, 1, 'Node 6', 6, NULL, '2014-05-26 15:20:09', '2014-05-26 15:20:09'),
(7, 1, 'Node 7', 7, NULL, '2014-05-26 15:21:14', '2014-05-26 15:21:14'),
(8, 1, 'Node 8', 8, NULL, '2014-05-26 15:22:38', '2014-05-26 15:22:38'),
(9, 1, 'Node 9', 9, NULL, '2014-05-26 15:22:50', '2014-05-26 15:22:50'),
(10, 1, 'Node 10', 10, NULL, '2014-05-26 15:23:01', '2014-05-26 15:23:01'),
(11, 1, 'Node 11', 11, NULL, '2014-05-26 15:25:17', '2014-05-26 15:25:17'),
(12, 1, 'Node 12', 12, NULL, '2014-05-26 15:26:25', '2014-05-26 15:26:25'),
(13, 1, 'Node 13', 13, NULL, '2014-05-26 15:27:07', '2014-05-26 15:27:07'),
(14, 1, 'Node 14', 14, NULL, '2014-05-26 15:27:51', '2014-05-26 15:27:51'),
(15, 1, 'Node 15', 15, NULL, '2014-05-26 15:29:18', '2014-05-26 15:29:18'),
(16, 1, 'Node 16', 16, NULL, '2014-05-26 15:29:58', '2014-05-26 15:29:58');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=49 ;

--
-- Contenu de la table `node_conference`
--

INSERT INTO `node_conference` (`id`, `node_id`, `conference_id`, `start_date`, `end_date`, `progression`) VALUES
(33, 1, 6, '0000-00-00', '2014-05-26', 100),
(34, 2, 6, '0000-00-00', '2014-05-26', 40),
(35, 3, 6, '0000-00-00', '2014-05-26', 0),
(36, 4, 6, '0000-00-00', '2014-05-26', 0),
(37, 5, 6, '0000-00-00', '2014-05-26', 0),
(38, 6, 6, '0000-00-00', '2014-05-26', 0),
(39, 7, 6, '0000-00-00', '2014-05-26', 0),
(40, 8, 6, '0000-00-00', '2014-05-26', 0),
(41, 9, 6, '0000-00-00', '2014-05-26', 0),
(42, 10, 6, '0000-00-00', '2014-05-26', 0),
(43, 11, 6, '0000-00-00', '2014-05-26', 0),
(44, 12, 6, '0000-00-00', '2014-05-26', 0),
(45, 13, 6, '0000-00-00', '2014-05-26', 0),
(46, 14, 6, '0000-00-00', '2014-05-26', 0),
(47, 15, 6, '0000-00-00', '2014-05-26', 0),
(48, 16, 6, '0000-00-00', '2014-05-26', 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=75 ;

--
-- Contenu de la table `tasks_list`
--

INSERT INTO `tasks_list` (`id`, `node_id`, `name`, `description`, `link`, `link_name`, `date`) VALUES
(1, 1, 'submit Memorandum of Understanding(MOU), if applicable', NULL, NULL, NULL, NULL),
(2, 1, 'contract conference management company, if applicable', NULL, NULL, NULL, NULL),
(9, 1, 'Site selection and contract review, if applicable', NULL, NULL, NULL, NULL),
(11, 1, 'Review IEEE Insurance coverage and determine if additional coverage is required', NULL, NULL, NULL, NULL),
(12, 1, 'Review tax information to ensure IRS and international compliance VAT and GST', NULL, NULL, NULL, NULL),
(13, 2, 'Develop communications plan, marketing materials and conference website', NULL, NULL, NULL, NULL),
(14, 2, 'Send request for proposal (RFP) to exhibit decorators and develop exhibitor prospectus, if applicable', NULL, NULL, NULL, NULL),
(15, 2, 'Begin outreach to educational institutions, corporations, government and industry for support and patronage', NULL, NULL, NULL, NULL),
(16, 2, 'Apply for grants for conference support', NULL, NULL, NULL, NULL),
(17, 2, 'Secure W-8 and/ or W-9 forms for tax compliance', NULL, NULL, NULL, NULL),
(18, 3, 'Develop process/ identity system for paper management', NULL, NULL, NULL, NULL),
(19, 3, 'Develop technical program, establish paper submission process and deadlines', NULL, NULL, NULL, NULL),
(20, 3, 'Establish a call for paper (CFP)', NULL, NULL, NULL, NULL),
(21, 3, 'Establish a visa process for international attendees and post on conference website', NULL, NULL, NULL, NULL),
(22, 3, 'Submit conference budget with written IEEE OU approval(s) for headquarter review', NULL, NULL, NULL, NULL),
(23, 3, 'Submit Principles of Business Conduct Compliance Certificate and Conflict of Interests Disclosure Statement (POBC/COI) forms', NULL, NULL, NULL, NULL),
(24, 3, 'Submit updated committee lists', NULL, NULL, NULL, NULL),
(25, 3, 'Establish conference bank account(s)', NULL, NULL, NULL, NULL),
(26, 3, 'Request and obtain loan from OU, if needed', NULL, NULL, NULL, NULL),
(27, 3, 'Pre-and Post conference forecasts [submit Pre-and Post conference forecasts by November 30th of each calendar year for accrual purposes] ', NULL, NULL, NULL, NULL),
(28, 3, '1099 & 1042 Schedule of Payments [no later than January 10th of each year for all payments made in the previous calendar year]', NULL, NULL, NULL, NULL),
(29, 3, 'Submit annual report on foreign bank accounts To IEEE tax Dept [no later than January 10th of each year for all payments made in the previous calendar year]', NULL, NULL, NULL, NULL),
(30, 3, 'Promote CFP and exhibit prospectus at current year’s conference, if applicable', NULL, NULL, NULL, NULL),
(31, 3, 'Review and reconfirm hotel, meeting space and room block', NULL, NULL, NULL, NULL),
(32, 3, 'Meeting with previous year’s committee to discuss best practices', NULL, NULL, NULL, NULL),
(33, 4, 'Submit Conference Publication Form to obtain Letter Of Acquisition(LOA)', NULL, NULL, NULL, NULL),
(34, 4, 'Register for PDF eXpress (optional)', NULL, NULL, NULL, NULL),
(35, 4, 'Register for Electronic IEEE Copyright Form (eCF) if proceedings are acquired by IEEE', NULL, NULL, NULL, NULL),
(37, 4, 'Create website for paper submissions, work with paper management company, if applicable', NULL, NULL, NULL, NULL),
(38, 4, 'Secure permission from related IEEE OUs to market to their members using e-Notice', NULL, NULL, NULL, NULL),
(39, 5, 'Create registration formand ensure registration service is Payment Card Industry (PCI) compliant', NULL, NULL, NULL, NULL),
(40, 5, 'Plan social activities and tour program if applicable', NULL, NULL, NULL, NULL),
(41, 5, 'Send out RFPs for ground transportation and finalize contract, if applicable', NULL, NULL, NULL, NULL),
(42, 6, 'Launch registration site', NULL, NULL, NULL, NULL),
(43, 6, 'Complete paper review process. Finalize technical program. Notify speakers', NULL, NULL, NULL, NULL),
(44, 6, 'Create and publish advanced program', NULL, NULL, NULL, NULL),
(45, 7, 'Solicit bids from printers and/or CD manufacturers based on accepted papers', NULL, NULL, NULL, NULL),
(46, 7, 'Organize and prepare for production of conference publications per Letter of Acquisition (LOA)', NULL, NULL, NULL, NULL),
(47, 7, 'Order attendee giveaways, speaker gifts, and/or conference shirts', NULL, NULL, NULL, NULL),
(48, 7, 'Determine preliminary exhibitor space assignments, if applicable', NULL, NULL, NULL, NULL),
(49, 7, 'Request weekly reports from hotel(s) regarding rooms', NULL, NULL, NULL, NULL),
(50, 8, 'Review room block with hotel(s) against attendance and contract(s)', NULL, NULL, NULL, NULL),
(51, 8, 'Complete & print final program, advertising/publicity and registration reminders', NULL, NULL, NULL, NULL),
(52, 8, 'Develop & finalize volunteer job functions/onsite needs', NULL, NULL, NULL, NULL),
(53, 9, 'Deadline for early registration (predetermined date)', NULL, NULL, NULL, NULL),
(54, 9, 'Send prelim specifications [set up, catering, audio visual (AV) ] to conference site. Order signage and recognition products (plaques, certificates and awards).', NULL, NULL, NULL, NULL),
(55, 9, 'Ship final program to conference site', NULL, NULL, NULL, NULL),
(56, 9, 'Submit Pre-Conference forecast', NULL, NULL, NULL, NULL),
(57, 10, 'Confirm onsite logistics with venue (registration, exhibits, meeting rooms, food & beverage)', NULL, NULL, NULL, NULL),
(58, 10, 'Set-up registration area, exhibit space, information booth, office area', NULL, NULL, NULL, NULL),
(59, 11, 'Onsite registration', NULL, NULL, NULL, NULL),
(60, 11, 'Monitor budget', NULL, NULL, NULL, NULL),
(61, 11, 'Monitor daily activities and adjust onsite logistics as needed', NULL, NULL, NULL, NULL),
(62, 11, 'Hold Post-Conference Wrap Up Meeting', NULL, NULL, NULL, NULL),
(63, 12, 'Submit Conference Proceedings/Content (Xplore CD and other media types) per Letter of Acquisition (LOA)', NULL, NULL, NULL, NULL),
(64, 12, 'Committee members submit final statistics and lessons learned to sponsoring IEEE OU', NULL, NULL, NULL, NULL),
(65, 13, 'Submit Conference Proceedings/Content (Xplore CD and other media types) per Letter of Acquisition (LOA) » (même tâche de 12ème nœud)', NULL, NULL, NULL, NULL),
(66, 13, 'Registration clean up (process refunds, receipts and balances due)', NULL, NULL, NULL, NULL),
(67, 14, 'Submit Conference Proceedings/Content (Xplore CD and other media types) per Letter of Acquisition (LOA) » (même tâche que 12ème noeud)', NULL, NULL, NULL, NULL),
(68, 14, 'Process outstanding bills', NULL, NULL, NULL, NULL),
(69, 14, 'Repay all loans', NULL, NULL, NULL, NULL),
(70, 14, 'Submit post-conference forecast', NULL, NULL, NULL, NULL),
(71, 15, 'Distribute surplus» Cette tâche est à valider par GC * « Close conference bank account & submit proof of account closure', NULL, NULL, NULL, NULL),
(72, 15, 'Submit final financial report with Certification of Accuracy', NULL, NULL, NULL, NULL),
(73, 16, 'Prepare and submit all audit material to independent auditor audit report for >$100K and/or IEEE OU total is 51% + co-sponsor', NULL, NULL, NULL, NULL),
(74, 16, 'Submit final financial report with Certification of Accuracy', NULL, NULL, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=199 ;

--
-- Contenu de la table `task_validation`
--

INSERT INTO `task_validation` (`id`, `conference_id`, `tasks_list_id`, `validation`, `limit_date`, `created_at`, `updated_at`) VALUES
(133, 6, 1, 1, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(134, 6, 2, 1, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(135, 6, 9, 1, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(136, 6, 11, 1, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(137, 6, 12, 1, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(138, 6, 13, 1, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(139, 6, 14, 1, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(140, 6, 15, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(141, 6, 16, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(142, 6, 17, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(143, 6, 24, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(144, 6, 25, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(145, 6, 26, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(146, 6, 27, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(147, 6, 28, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(148, 6, 29, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(149, 6, 30, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(150, 6, 31, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(151, 6, 32, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(152, 6, 18, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(153, 6, 19, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(154, 6, 20, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(155, 6, 21, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(156, 6, 22, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(157, 6, 23, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(158, 6, 33, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(159, 6, 34, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(160, 6, 35, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(161, 6, 37, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(162, 6, 38, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(163, 6, 41, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(164, 6, 39, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(165, 6, 40, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(166, 6, 42, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(167, 6, 43, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(168, 6, 44, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(169, 6, 45, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(170, 6, 46, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(171, 6, 47, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(172, 6, 48, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(173, 6, 49, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(174, 6, 50, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(175, 6, 51, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(176, 6, 52, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(177, 6, 53, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(178, 6, 54, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(179, 6, 55, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(180, 6, 56, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(181, 6, 57, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(182, 6, 58, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(183, 6, 59, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(184, 6, 60, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(185, 6, 61, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(186, 6, 62, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(187, 6, 63, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(188, 6, 64, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(189, 6, 65, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(190, 6, 66, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(191, 6, 67, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(192, 6, 68, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(193, 6, 69, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(194, 6, 70, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(195, 6, 71, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(196, 6, 72, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(197, 6, 73, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00'),
(198, 6, 74, 0, NULL, '2014-05-26 21:59:00', '2014-05-26 21:59:00');

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
