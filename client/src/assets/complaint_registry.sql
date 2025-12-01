-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 30 nov. 2025 à 09:52
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
-- Base de données : `complaint_registry`
--

-- --------------------------------------------------------

--
-- Structure de la table `complaints`
--

CREATE TABLE `complaints` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `detail` text NOT NULL,
  `specificity_score` int(11) DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `category` varchar(100) NOT NULL DEFAULT 'General'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `complaints`
--

INSERT INTO `complaints` (`id`, `title`, `detail`, `specificity_score`, `user_id`, `created_at`, `category`) VALUES
(2, 'The Thumbprint Traitor', 'Description: After cleaning your phone screen to crystal clarity, you immediately manage to touch the glass with the one finger that is slightly greasy, leaving a perfect, unmistakable spiral-shaped fingerprint that catches the light right over the clock widget.', 1, 1, '2025-11-17 02:28:38', 'Existential Dread of Laundry'),
(6, 'The Microscopic \"X\"', 'Mobile game ads where the \"Close\" button is not only the size of a singular pixel but is also a fake button that opens the App Store instead.', 95, 1, '2025-11-30 08:50:47', 'Digital Deception'),
(7, 'The Phantom Flush', 'Automatic toilets that flush aggressively while I am still sitting on them, simply because I leaned forward two inches to check my phone.', 78, 3, '2025-11-30 08:50:47', 'Bathroom Betrayals'),
(8, 'The Escalator Blockade', 'People who reach the top of an escalator and immediately stop to look around, causing a pile-up of human bodies behind them like a slow-motion train wreck.', 112, 5, '2025-11-30 08:50:47', 'Social Protocol'),
(9, 'Recipe Life Stories', 'Food blogs that require me to scroll past 4,000 words about the author’s grandmother’s summer in Tuscany before telling me how many eggs to put in the cake.', 60, 4, '2025-11-30 08:50:47', 'Internet Clutter'),
(10, 'The Wet Sock Step', 'Stepping into a small, invisible puddle of water in the kitchen while wearing fresh socks. The day is ruined. I might as well go back to bed.', 88, 1, '2025-11-30 08:50:47', 'Sensory Nightmares'),
(11, 'Bagging Area Gaslighting', 'The self-checkout machine yelling \"UNEXPECTED ITEM IN BAGGING AREA\" when the only thing I placed there was the item I just scanned. I am not a thief, I am just trying to buy pasta.', 45, 3, '2025-11-30 08:50:47', 'Tech Hostility'),
(12, 'The Streaming Volume War', 'Action movies where the dialogue is whispered so quietly I need subtitles, but the explosions are loud enough to shatter my windows.', 130, 5, '2025-11-30 08:50:47', 'Audio Crimes'),
(13, 'The Fitted Sheet Paradox', 'The inability to fold a fitted sheet. It becomes a ball of elastic shame that I shove into the back of the linen closet hoping guests never see it.', 33, 4, '2025-11-30 08:50:47', 'Domestic Defeats'),
(14, 'The \"K\" Response', 'Sending a detailed, three-paragraph text message pouring my heart out, only to receive the letter \"k\" in response.', 72, 1, '2025-11-30 08:50:47', 'Communication Breakdown'),
(15, 'The Never-Ending Wipe', 'The Marker syndrome. I wipe and I wipe and I wipe, but the marker keeps marking. It is like there is a crayon down there.', 99, 3, '2025-11-30 08:50:47', 'Biological Betrayals');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('complainer','archivist') NOT NULL DEFAULT 'complainer',
  `pfp` varchar(50) DEFAULT 'pfp1.jpeg',
  `email` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `pfp`, `email`) VALUES
(1, 'Paul', '$2b$10$T/TneC6m8wTGAdOWgzxwQeHSXLtOXHc6ee93hbY4tpKpTeWarGbTW', 'complainer', 'pfp1.jpeg', 'paul1@gmail.com'),
(2, 'admin', '$2b$10$yx71JtWeMZt.eshZiJPmkOmP5U4fhmKq/E33KJt5OaH9QjTaeYFIS', 'archivist', 'pfp1.jpeg', 'admin@complaint_registry.com'),
(3, 'Sam', '$2b$10$Ux9g761MpXMXR2RuHqwYg.qqoMkB/uPyGxZviFxSXlypIOk7Dom2u', 'complainer', 'pfp2.jpeg', 'sam@gmail.com'),
(4, 'Clayton', '$2b$10$0YEYVh.lBVCvs84aBh.hkO/qQImjqJ8pUvqJrceViNOwbtrmWoFCa', 'complainer', 'pfp4.jpeg', 'clayton@gmail.com'),
(5, 'pierre', '$2b$10$G.GaLJq8K8fhksKePwf03.wl8BhieCO9gAeZIRFxWXwOtpgkkB7vS', 'complainer', 'pfp3.jpeg', 'pierre@gmail.com');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
