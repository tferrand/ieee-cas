-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Lun 26 Mai 2014 à 15:31
-- Version du serveur: 5.5.25
-- Version de PHP: 5.4.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données: `ieee-cas`
--

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
  KEY `fk_tasks_list_node1_idx` (`node_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=75 ;

--
-- Contenu de la table `tasks_list`
--

INSERT INTO `tasks_list` (`id`, `node_id`, `name`, `description`, `link`, `link_name`, `date`) VALUES
(1, 1, 'submit Memorandum of Understanding(MOU), if applicable', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at mauris nec arcu sagittis gravida nec non ipsum. Nam rutrum nisi magna, et gravida diam pharetra vitae. Vivamus dictum ultricies tellus, sit amet auctor turpis malesuada eget. Nam cursus nulla quis euismod rhoncus. Donec ultrices tellus nulla, sed molestie dolor sodales quis. In in dui quis dui eleifend interdum quis in eros. Nullam cursus tempor suscipit. In at dolor eu arcu varius bibendum eget eget lorem.\n\nQuisque at leo lacinia, vestibulum nisl et, auctor dolor. Proin commodo sed ante quis bibendum. Integer vulputate vitae mauris et congue. Cras eleifend magna lorem. Phasellus lobortis commodo purus vitae sagittis. Nulla facilisi. Etiam diam diam, tristique et auctor eu, tristique non enim. Etiam massa mi, condimentum pellentesque dui at, volutpat ultrices justo. Maecenas faucibus nunc vitae quam rhoncus luctus. In cursus, dolor in vestibulum volutpat, ante dolor malesuada velit, eget pharetra sapien tellus at dolor. Nunc sit amet interdum quam.', 'http://ieee-cas.org/', 'Link to IEEE-CAS', NULL),
(2, 1, 'contract conference management company, if applicable', 'description 2', 'azaz', 'Link to subscription', NULL),
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

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `tasks_list`
--
ALTER TABLE `tasks_list`
  ADD CONSTRAINT `fk_tasks_list_node1` FOREIGN KEY (`node_id`) REFERENCES `node` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;