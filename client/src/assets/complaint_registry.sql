-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 03 déc. 2025 à 09:38
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
(2, 'The Thumbprint Traitor', 'Description: After cleaning your phone screen to crystal clarity, you immediately manage to touch the glass with the one finger that is slightly greasy, leaving a perfect, unmistakable spiral-shaped fingerprint that catches the light right over the clock widget.', 3, 1, '2025-11-17 02:28:38', 'Existential Dread of Laundry'),
(6, 'The Microscopic \"X\"', 'Mobile game ads where the \"Close\" button is not only the size of a singular pixel but is also a fake button that opens the App Store instead.', 0, 1, '2025-11-30 08:50:47', 'Digital Deception'),
(7, 'The Phantom Flush', 'Automatic toilets that flush aggressively while I am still sitting on them, simply because I leaned forward two inches to check my phone.', 1, 3, '2025-11-30 08:50:47', 'Bathroom Betrayals'),
(8, 'The Escalator Blockade', 'People who reach the top of an escalator and immediately stop to look around, causing a pile-up of human bodies behind them like a slow-motion train wreck.', 3, 5, '2025-11-30 08:50:47', 'Social Protocol'),
(9, 'Recipe Life Stories', 'Food blogs that require me to scroll past 4,000 words about the author’s grandmother’s summer in Tuscany before telling me how many eggs to put in the cake.', -1, 4, '2025-11-30 08:50:47', 'Internet Clutter'),
(10, 'The Wet Sock Step', 'Stepping into a small, invisible puddle of water in the kitchen while wearing fresh socks. The day is ruined. I might as well go back to bed.', -2, 1, '2025-11-30 08:50:47', 'Sensory Nightmares'),
(11, 'Bagging Area Gaslighting', 'The self-checkout machine yelling \"UNEXPECTED ITEM IN BAGGING AREA\" when the only thing I placed there was the item I just scanned. I am not a thief, I am just trying to buy pasta.', -2, 3, '2025-11-30 08:50:47', 'Tech Hostility'),
(12, 'The Streaming Volume War', 'Action movies where the dialogue is whispered so quietly I need subtitles, but the explosions are loud enough to shatter my windows.', 1, 5, '2025-11-30 08:50:47', 'Audio Crimes'),
(13, 'The Fitted Sheet Paradox', 'The inability to fold a fitted sheet. It becomes a ball of elastic shame that I shove into the back of the linen closet hoping guests never see it.', -4, 4, '2025-11-30 08:50:47', 'Domestic Defeats'),
(14, 'The \"K\" Response', 'Sending a detailed, three-paragraph text message pouring my heart out, only to receive the letter \"k\" in response.', 0, 1, '2025-11-30 08:50:47', 'Communication Breakdown'),
(15, 'The Never-Ending Wipe', 'The Marker syndrome. I wipe and I wipe and I wipe, but the marker keeps marking. It is like there is a crayon down there.', -1, 3, '2025-11-30 08:50:47', 'Biological Betrayals');

-- --------------------------------------------------------

--
-- Structure de la table `complaint_votes`
--

CREATE TABLE `complaint_votes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `complaint_id` int(11) NOT NULL,
  `vote_type` enum('up','down') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `complaint_votes`
--

INSERT INTO `complaint_votes` (`id`, `user_id`, `complaint_id`, `vote_type`) VALUES
(1, 1, 12, 'up'),
(2, 1, 6, 'up'),
(3, 1, 8, 'up'),
(4, 1, 15, 'up'),
(5, 1, 10, 'down'),
(6, 1, 7, 'up'),
(7, 1, 14, 'up'),
(8, 1, 9, 'down'),
(9, 1, 11, 'down'),
(10, 1, 13, 'down'),
(11, 1, 2, 'up'),
(12, 3, 2, 'up'),
(13, 3, 6, 'up'),
(14, 3, 8, 'up'),
(15, 3, 10, 'down'),
(16, 3, 12, 'up'),
(17, 3, 14, 'up'),
(18, 4, 6, 'down'),
(19, 4, 7, 'up'),
(20, 4, 9, 'up'),
(21, 4, 15, 'down'),
(22, 5, 2, 'up'),
(23, 5, 8, 'up'),
(24, 5, 10, 'up'),
(25, 5, 13, 'down'),
(38, 4, 13, 'down'),
(39, 4, 8, 'up'),
(40, 4, 2, 'up'),
(41, 4, 14, 'down');

-- --------------------------------------------------------

--
-- Structure de la table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `subject`, `message`, `created_at`) VALUES
(2, 'Grandma Margaret', 'margaret1954@aol.com', 'Where is the Google?', 'I am trying to find the recipe for chicken pot pie. This website is not helping. Please delete this internet page and bring back the Google.', '2025-12-02 04:28:23'),
(3, 'Karen B.', 'speaktoyour@manager.com', 'The Blue is too Loud', 'The specific shade of blue used on the \"Submit\" button is extremely aggressive. It feels like it is yelling at me to click it. I prefer a more passive-aggressive beige.', '2025-12-02 04:28:23'),
(4, 'Alex Dev', 'alex@frontend.com', 'Feature Request: Dark Mode', 'Love the concept! But my eyes are burning at 3 AM while reading about \"Wet Socks.\" Please add a Dark Mode toggle in the header. Thanks!', '2025-12-02 04:28:23'),
(5, 'Sarah Jenkins', 's.jenkins@gmail.com', 'Bug with Profile Picture', 'Hi Admin, just letting you know that when I try to switch from pfp1 to pfp3, it sometimes lags and doesn\'t update the header immediately. Might be a local storage issue?', '2025-12-02 04:28:23'),
(6, 'Pizza Lover', 'hungry@dude.com', 'Order #4421', 'Where is my large pepperoni pizza? It has been 45 minutes. If this is not Domino\'s, why does your website look so delicious?', '2025-12-02 04:28:23'),
(7, 'Niche Finder', 'fan@mail.com', 'Finally, I feel seen', 'I just wanted to say thank you. I thought I was the only person in the world who hated the sound of people chewing bananas. This site is therapy.', '2025-12-02 04:28:23'),
(8, 'Grammar Police', 'correct@typo.com', 'Typo in the Footer', 'You missed a comma in the Terms of Service on line 42. As an Archivist of grammar, I demand you fix this immediately or I will file a formal complaint.', '2025-12-02 04:28:23');

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
-- Index pour la table `complaint_votes`
--
ALTER TABLE `complaint_votes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_vote` (`user_id`,`complaint_id`),
  ADD KEY `complaint_id` (`complaint_id`);

--
-- Index pour la table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT pour la table `complaint_votes`
--
ALTER TABLE `complaint_votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pour la table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `complaint_votes`
--
ALTER TABLE `complaint_votes`
  ADD CONSTRAINT `complaint_votes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaint_votes_ibfk_2` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
