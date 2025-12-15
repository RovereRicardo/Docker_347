-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 14, 2025 at 07:29 AM
-- Server version: 5.7.24
-- PHP Version: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


--
-- Database: `rovere_ricardo_deva1a_basketstats_164_2025`
--


-- --------------------------------------------------------

--
-- Table structure for table `t_coach`
--

DROP TABLE IF EXISTS `t_coach`;
CREATE TABLE `t_coach` (
  `id_coach` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_coach`
--

INSERT INTO `t_coach` (`id_coach`, `id_user`) VALUES
(3, 18);

-- --------------------------------------------------------

--
-- Table structure for table `t_match`
--

DROP TABLE IF EXISTS `t_match`;
CREATE TABLE `t_match` (
  `id_match` int(11) NOT NULL,
  `id_home_team` int(11) NOT NULL,
  `id_away_team` int(11) NOT NULL,
  `date_match` date DEFAULT NULL,
  `home_score` int(11) DEFAULT NULL,
  `away_score` int(11) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `is_played` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_match`
--


-- --------------------------------------------------------

--
-- Table structure for table `t_player`
--

DROP TABLE IF EXISTS `t_player`;
CREATE TABLE `t_player` (
  `id_player` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `family_name` varchar(50) DEFAULT NULL,
  `picture` mediumblob,
  `number` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `position_name` varchar(5) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_player`
--


-- --------------------------------------------------------

--
-- Table structure for table `t_players_match`
--

DROP TABLE IF EXISTS `t_players_match`;
CREATE TABLE `t_players_match` (
  `id_match` int(11) NOT NULL,
  `id_player` int(11) NOT NULL,
  `subbed` tinyint(1) NOT NULL,
  `played` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_players_match`
--


-- --------------------------------------------------------

--
-- Table structure for table `t_stats`
--

DROP TABLE IF EXISTS `t_stats`;
CREATE TABLE `t_stats` (
  `id_stat_type` int(11) NOT NULL,
  `id_player` int(11) NOT NULL,
  `id_match` int(11) NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_stats`
--


-- --------------------------------------------------------

--
-- Table structure for table `t_stats_type`
--

DROP TABLE IF EXISTS `t_stats_type`;
CREATE TABLE `t_stats_type` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_stats_type`
--


-- --------------------------------------------------------

--
-- Table structure for table `t_team`
--

DROP TABLE IF EXISTS `t_team`;
CREATE TABLE `t_team` (
  `id_team` int(11) NOT NULL,
  `team_name` varchar(50) NOT NULL,
  `team_logo` mediumblob,
  `address` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `wins` int(11) DEFAULT NULL,
  `loses` int(11) DEFAULT NULL,
  `matches_played` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `id_coach_creator` int(11) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_team`
--


-- --------------------------------------------------------

--
-- Table structure for table `t_team_player`
--

DROP TABLE IF EXISTS `t_team_player`;
CREATE TABLE `t_team_player` (
  `id_team_player` int(11) NOT NULL,
  `id_player_team` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_team_player`
--


-- --------------------------------------------------------

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'coach'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_user`
--

INSERT INTO `t_user` (`id_user`, `username`, `name`, `email`, `password`, `role`) VALUES
(18, 'admin', 'admin', 'admin@admin.com', 'scrypt:32768:8:1$hRxZEHYIzCeL0Xt1$d12db159bc7208bfd053a945d8a53cfe41c354015d3edc27dc71a5f743c219594df853f94aac4042929cc2fe2057942df9bbaeb28fe10b3a85c86089a645a0c2', 'Admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `t_coach`
--
ALTER TABLE `t_coach`
  ADD PRIMARY KEY (`id_coach`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `t_match`
--
ALTER TABLE `t_match`
  ADD PRIMARY KEY (`id_match`),
  ADD KEY `id_home_team` (`id_home_team`),
  ADD KEY `id_away_team` (`id_away_team`);

--
-- Indexes for table `t_player`
--
ALTER TABLE `t_player`
  ADD PRIMARY KEY (`id_player`);

--
-- Indexes for table `t_players_match`
--
ALTER TABLE `t_players_match`
  ADD PRIMARY KEY (`id_match`,`id_player`),
  ADD KEY `t_players_match_ibfk_2` (`id_player`);

--
-- Indexes for table `t_stats`
--
ALTER TABLE `t_stats`
  ADD KEY `t_stats_ibfk_2` (`id_match`),
  ADD KEY `id_player` (`id_player`) USING BTREE,
  ADD KEY `id_stat_type` (`id_stat_type`) USING BTREE;

--
-- Indexes for table `t_stats_type`
--
ALTER TABLE `t_stats_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_team`
--
ALTER TABLE `t_team`
  ADD PRIMARY KEY (`id_team`),
  ADD UNIQUE KEY `team_name` (`team_name`),
  ADD KEY `id_user_creator` (`id_coach_creator`);

--
-- Indexes for table `t_team_player`
--
ALTER TABLE `t_team_player`
  ADD UNIQUE KEY `id_teams` (`id_team_player`,`id_player_team`),
  ADD KEY `t_teams_players_ibfk_1` (`id_player_team`);

--
-- Indexes for table `t_user`
--
ALTER TABLE `t_user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `t_coach`
--
ALTER TABLE `t_coach`
  MODIFY `id_coach` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `t_match`
--
ALTER TABLE `t_match`
  MODIFY `id_match` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `t_player`
--
ALTER TABLE `t_player`
  MODIFY `id_player` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;

--
-- AUTO_INCREMENT for table `t_stats_type`
--
ALTER TABLE `t_stats_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `t_team`
--
ALTER TABLE `t_team`
  MODIFY `id_team` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `t_user`
--
ALTER TABLE `t_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_coach`
--
ALTER TABLE `t_coach`
  ADD CONSTRAINT `t_coach_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `t_user` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `t_match`
--
ALTER TABLE `t_match`
  ADD CONSTRAINT `t_match_ibfk_1` FOREIGN KEY (`id_home_team`) REFERENCES `t_team` (`id_team`),
  ADD CONSTRAINT `t_match_ibfk_2` FOREIGN KEY (`id_away_team`) REFERENCES `t_team` (`id_team`);

--
-- Constraints for table `t_players_match`
--
ALTER TABLE `t_players_match`
  ADD CONSTRAINT `t_players_match_ibfk_1` FOREIGN KEY (`id_match`) REFERENCES `t_match` (`id_match`) ON DELETE CASCADE,
  ADD CONSTRAINT `t_players_match_ibfk_2` FOREIGN KEY (`id_player`) REFERENCES `t_player` (`id_player`) ON DELETE CASCADE;

--
-- Constraints for table `t_stats`
--
ALTER TABLE `t_stats`
  ADD CONSTRAINT `t_stats_ibfk_1` FOREIGN KEY (`id_player`) REFERENCES `t_player` (`id_player`) ON DELETE CASCADE,
  ADD CONSTRAINT `t_stats_ibfk_2` FOREIGN KEY (`id_match`) REFERENCES `t_match` (`id_match`) ON DELETE CASCADE,
  ADD CONSTRAINT `t_stats_ibfk_3` FOREIGN KEY (`id_stat_type`) REFERENCES `t_stats_type` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `t_team`
--
ALTER TABLE `t_team`
  ADD CONSTRAINT `t_team_ibfk_1` FOREIGN KEY (`id_coach_creator`) REFERENCES `t_user` (`id_user`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `t_team_player`
--
ALTER TABLE `t_team_player`
  ADD CONSTRAINT `t_team_player_ibfk_1` FOREIGN KEY (`id_player_team`) REFERENCES `t_player` (`id_player`) ON DELETE CASCADE,
  ADD CONSTRAINT `t_team_player_ibfk_2` FOREIGN KEY (`id_team_player`) REFERENCES `t_team` (`id_team`) ON DELETE CASCADE;
COMMIT;
