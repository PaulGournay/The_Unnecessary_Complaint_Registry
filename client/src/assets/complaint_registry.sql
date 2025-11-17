-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 17 nov. 2025 à 05:02
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
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Acoustic Annoyances'),
(3, 'Existential Dread of Laundry'),
(2, 'Pocket Problems');

-- --------------------------------------------------------

--
-- Structure de la table `complaints`
--

CREATE TABLE `complaints` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `detail` text NOT NULL,
  `specificity_score` int(11) DEFAULT 0,
  `category_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `complaints`
--

INSERT INTO `complaints` (`id`, `title`, `detail`, `specificity_score`, `category_id`, `user_id`, `created_at`) VALUES
(1, 'The Refrigerator Rumble-Stutter', 'The loud, low-frequency hum of the refrigerator\'s compressor that starts up, runs for exactly 7 seconds, and then cuts out suddenly, only to start up again 3 seconds later at an even louder volume, having failed to commit to running or being silent the first time.', 3, 1, 1, '2025-11-17 02:24:37'),
(2, 'The Thumbprint Traitor', 'Description: After cleaning your phone screen to crystal clarity, you immediately manage to touch the glass with the one finger that is slightly greasy, leaving a perfect, unmistakable spiral-shaped fingerprint that catches the light right over the clock widget.', 0, 3, 1, '2025-11-17 02:28:38');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('complainer','archivist') NOT NULL DEFAULT 'complainer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, 'Paul', '$2b$10$T/TneC6m8wTGAdOWgzxwQeHSXLtOXHc6ee93hbY4tpKpTeWarGbTW', 'complainer'),
(2, 'admin', '$2b$10$yx71JtWeMZt.eshZiJPmkOmP5U4fhmKq/E33KJt5OaH9QjTaeYFIS', 'archivist'),
(3, 'Sam', '$2b$10$Ux9g761MpXMXR2RuHqwYg.qqoMkB/uPyGxZviFxSXlypIOk7Dom2u', 'complainer');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
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
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
