-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Client: localhost
<<<<<<< HEAD
-- Généré le: Sam 14 Juin 2014 à 10:14
-- Version du serveur: 5.5.25
-- Version de PHP: 5.4.4
=======
-- Généré le: Mar 17 Juin 2014 à 10:07
-- Version du serveur: 5.6.12-log
-- Version de PHP: 5.4.12
>>>>>>> FETCH_HEAD

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `ieee-cas`
--
CREATE DATABASE IF NOT EXISTS `ieee-cas` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ieee-cas`;

-- --------------------------------------------------------

--
-- Structure de la table `conference`
--

CREATE TABLE IF NOT EXISTS `conference` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Contenu de la table `conference`
--

INSERT INTO `conference` (`id`, `user_id`, `model_id`, `id_iee`, `title`, `acronym`, `adress`, `description`, `start`, `end`, `progression`, `photo`, `created_at`, `updated_at`) VALUES
<<<<<<< HEAD
(15, 1, 1, 12345678, 'TexMex Cap', 'TXM Conf', 'Îles Sandwich du Sud, Géorgie du Sud et les Îles Sandwich du Sud', 'lorem ipsum', '2015-06-26 08:00:00', '2015-06-28 20:00:00', 12, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11');
=======
(15, 1, 1, 12345678, 'TexMex Cap', 'TXM Conf', 'Îles Sandwich du Sud, Géorgie du Sud et les Îles Sandwich du Sud', 'lorem ipsum', '2015-06-26 08:00:00', '2015-06-28 20:00:00', 9, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11');
>>>>>>> FETCH_HEAD

-- --------------------------------------------------------

--
-- Structure de la table `conference_tc_sponsor`
--

CREATE TABLE IF NOT EXISTS `conference_tc_sponsor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tc_sponsor_id` int(11) NOT NULL,
  `conference_id` int(11) NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`tc_sponsor_id`,`conference_id`),
  KEY `fk_conference_tc_sponsor_tc_sponsor1_idx` (`tc_sponsor_id`),
  KEY `fk_conference_tc_sponsor_conference1_idx` (`conference_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `conference_tc_sponsor`
--

INSERT INTO `conference_tc_sponsor` (`id`, `tc_sponsor_id`, `conference_id`, `active`, `created_at`, `updated_at`) VALUES
(1, 5, 15, 1, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(2, 6, 15, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(3, 8, 15, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(4, 11, 15, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11');

-- --------------------------------------------------------

--
-- Structure de la table `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conference_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `conference_id` (`conference_id`),
  KEY `task_id` (`task_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Contenu de la table `files`
--

INSERT INTO `files` (`id`, `conference_id`, `task_id`, `name`, `path`) VALUES
(14, 15, 20, 'NOTRE PROJET.pdf', 'NOTRE PROJET.pdf'),
(15, 15, 20, '1-INFORMATIONS TECHNIQUES PALISEP.pdf', '1-INFORMATIONS TECHNIQUES PALISEP.pdf'),
(16, 15, 20, '1-INFORMATIONS TECHNIQUES PALISEP.pdf', '1-INFORMATIONS TECHNIQUES PALISEP.pdf');

-- --------------------------------------------------------

--
-- Structure de la table `model`
--

CREATE TABLE IF NOT EXISTS `model` (
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

CREATE TABLE IF NOT EXISTS `node` (
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

CREATE TABLE IF NOT EXISTS `node_conference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `conference_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `progression` int(11) NOT NULL,
  PRIMARY KEY (`id`,`node_id`,`conference_id`),
  KEY `fk_node_conference_node1_idx` (`node_id`),
  KEY `fk_node_conference_conference1_idx` (`conference_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=145 ;

--
-- Contenu de la table `node_conference`
--

INSERT INTO `node_conference` (`id`, `node_id`, `conference_id`, `start_date`, `end_date`, `progression`) VALUES
(129, 1, 15, '0000-00-00', '2014-09-08', 60),
(130, 2, 15, '0000-00-00', '2014-10-26', 40),
(131, 3, 15, '0000-00-00', '2014-12-15', 20),
(132, 4, 15, '0000-00-00', '2015-02-01', 0),
(133, 5, 15, '0000-00-00', '2015-03-22', 0),
(134, 6, 15, '0000-00-00', '2015-04-27', 0),
(135, 7, 15, '0000-00-00', '2015-05-09', 0),
(136, 8, 15, '0000-00-00', '2015-05-26', 0),
(137, 9, 15, '0000-00-00', '2015-06-20', 0),
(138, 10, 15, '0000-00-00', '2015-06-23', 0),
(139, 11, 15, '0000-00-00', '2015-06-27', 0),
(140, 12, 15, '0000-00-00', '2015-07-07', 0),
(141, 13, 15, '0000-00-00', '2015-07-23', 0),
(142, 14, 15, '0000-00-00', '2015-09-10', 0),
(143, 15, 15, '0000-00-00', '2015-09-25', 0),
(144, 16, 15, '0000-00-00', '2015-10-03', 0);

-- --------------------------------------------------------

--
-- Structure de la table `tasks_list`
--

CREATE TABLE IF NOT EXISTS `tasks_list` (
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

CREATE TABLE IF NOT EXISTS `task_validation` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=595 ;

--
-- Contenu de la table `task_validation`
--

INSERT INTO `task_validation` (`id`, `conference_id`, `tasks_list_id`, `validation`, `file_uploaded`, `limit_date`, `created_at`, `updated_at`) VALUES
(529, 15, 1, 1, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(530, 15, 2, 1, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(531, 15, 9, 1, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(532, 15, 11, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(533, 15, 12, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(534, 15, 13, 1, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(535, 15, 14, 1, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(536, 15, 15, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(537, 15, 16, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(538, 15, 17, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(539, 15, 24, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(540, 15, 25, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(541, 15, 26, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(542, 15, 27, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(543, 15, 28, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(544, 15, 29, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(545, 15, 30, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(546, 15, 31, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(547, 15, 32, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(548, 15, 18, 1, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
<<<<<<< HEAD
(549, 15, 19, 1, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(550, 15, 20, 1, 1, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
=======
(549, 15, 19, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(550, 15, 20, 0, 1, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
>>>>>>> FETCH_HEAD
(551, 15, 21, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(552, 15, 22, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(553, 15, 23, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(554, 15, 33, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(555, 15, 34, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(556, 15, 35, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(557, 15, 37, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(558, 15, 38, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(559, 15, 41, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(560, 15, 39, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(561, 15, 40, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(562, 15, 42, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(563, 15, 43, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(564, 15, 44, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(565, 15, 45, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(566, 15, 46, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(567, 15, 47, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(568, 15, 48, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(569, 15, 49, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(570, 15, 50, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(571, 15, 51, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(572, 15, 52, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(573, 15, 53, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(574, 15, 54, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(575, 15, 55, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(576, 15, 56, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(577, 15, 57, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(578, 15, 58, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(579, 15, 59, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(580, 15, 60, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(581, 15, 61, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(582, 15, 62, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(583, 15, 63, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(584, 15, 64, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(585, 15, 65, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(586, 15, 66, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(587, 15, 67, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(588, 15, 68, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(589, 15, 69, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(590, 15, 70, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(591, 15, 71, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(592, 15, 72, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(593, 15, 73, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11'),
(594, 15, 74, 0, 0, NULL, '2014-06-02 16:59:11', '2014-06-02 16:59:11');

-- --------------------------------------------------------

--
-- Structure de la table `tuto`
--

CREATE TABLE IF NOT EXISTS `tuto` (
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
(2, 1, 'tuto 2', 'http://www.test.com', 'tuto'),
(3, 3, 'netbeans', 'https://fr.netbeans.org/', 'tuto'),
(4, 1, 'Tool 1', 'test', 'tool'),
(5, 2, 'Eclipse', 'http://www.eclipse.org/', 'tool'),
(6, 3, 'ePaper', '', 'tool'),
(7, 3, 'EDAS', 'http://www.edas.info/', 'tool');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

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
(18, 'tc15@ieee.com', '5c4fefda27cfe84c3999be13e6b8608a', NULL, NULL, 'VLSI Systems & Applications', NULL, 'tc', NULL, NULL, NULL);

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
