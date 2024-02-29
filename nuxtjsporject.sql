-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 14, 2024 at 03:42 PM
-- Server version: 8.0.36-0ubuntu0.20.04.1
-- PHP Version: 8.1.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `product`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int NOT NULL,
  `customerId` int DEFAULT NULL,
  `cartId` int DEFAULT NULL,
  `fullName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `customerId`, `cartId`, `fullName`, `postcode`, `city`, `state`, `country`, `email`, `phone`, `created_at`) VALUES
(1, 2, NULL, 'parth', '123321', 'ujjain', 'mp', 'india', 'hinge@gmail.com', '12312', '2024-02-14 08:57:57'),
(2, 3, NULL, 'demo address', '43212', 'ky pata', 'landon', 'uk', 'demo@gmail.com', '6534522', '2024-02-14 09:47:11');

-- --------------------------------------------------------

--
-- Table structure for table `attributefamilies`
--

CREATE TABLE `attributefamilies` (
  `id` int NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `isUserDefined` tinyint NOT NULL DEFAULT '1',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `attributefamilies`
--

INSERT INTO `attributefamilies` (`id`, `code`, `name`, `status`, `isUserDefined`, `createdAt`) VALUES
(1, 'default', 'Default', 1, 1, '2023-02-21 05:30:26'),
(2, 'virtual', 'Virtual', 1, 1, '2023-02-21 05:30:26');

-- --------------------------------------------------------

--
-- Table structure for table `attributegroups`
--

CREATE TABLE `attributegroups` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `position` int NOT NULL,
  `isUserDefined` tinyint NOT NULL DEFAULT '1',
  `attributeFamilyId` int NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `attributegroups`
--

INSERT INTO `attributegroups` (`id`, `name`, `position`, `isUserDefined`, `attributeFamilyId`, `createdAt`) VALUES
(1, 'General', 1, 1, 1, '2023-02-21 09:56:58'),
(2, 'Content', 2, 1, 1, '2023-02-21 09:56:58'),
(7, 'Shipping', 3, 1, 1, '2023-03-02 14:55:29'),
(8, 'General', 1, 1, 3, '2023-02-21 09:56:58'),
(9, 'Content', 2, 1, 3, '2023-02-21 09:56:58'),
(10, 'Shipping', 3, 1, 3, '2023-03-02 14:55:29');

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` int NOT NULL,
  `attributeFamilyId` int DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `adminName` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `position` int DEFAULT NULL,
  `isRequired` tinyint NOT NULL DEFAULT '0',
  `isUnique` tinyint NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attributetranslations`
--

CREATE TABLE `attributetranslations` (
  `id` int NOT NULL,
  `attributeId` int NOT NULL,
  `name` text,
  `local` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cartpayments`
--

CREATE TABLE `cartpayments` (
  `id` int NOT NULL,
  `method` varchar(255) NOT NULL,
  `methodTitle` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cartpayments`
--

INSERT INTO `cartpayments` (`id`, `method`, `methodTitle`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Cod', 'Cod', 'pending', '2024-02-14 10:07:37', '2024-02-14 10:07:37'),
(2, 'Stripe', 'Stripe', 'succeeded', '2024-02-14 10:09:23', '2024-02-14 10:09:23'),
(3, 'Cod', 'Cod', 'pending', '2024-02-14 10:10:08', '2024-02-14 10:10:08'),
(4, 'Stripe', 'Stripe', 'succeeded', '2024-02-14 10:10:22', '2024-02-14 10:10:22');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int NOT NULL,
  `customerEmail` varchar(255) DEFAULT NULL,
  `customerName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `itemsCount` int DEFAULT NULL,
  `itemsQty` float DEFAULT NULL,
  `grandTotal` float DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `customerEmail`, `customerName`, `itemsCount`, `itemsQty`, `grandTotal`, `customerId`, `created_at`, `updated_at`) VALUES
(1, 'noddy@gmail.com', 'parth', 4, 4, 786, 2, '2024-02-14 10:07:37', '2024-02-14 10:07:37'),
(2, 'noddy@gmail.com', 'parth', 4, 4, 786, 2, '2024-02-14 10:09:24', '2024-02-14 10:09:24'),
(3, 'demo@gmail.com', 'demo', 3, 3, 687, 3, '2024-02-14 10:10:08', '2024-02-14 10:10:08'),
(4, 'demo@gmail.com', 'demo', 3, 3, 687, 3, '2024-02-14 10:10:23', '2024-02-14 10:10:23');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `slug` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `position` int NOT NULL,
  `status` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `slug`, `name`, `description`, `position`, `status`, `created_at`) VALUES
(1, 'EC123', 'Electronic', 'Electronic device means an item that operates by controlling the flow of electrons or other electrically charged particles in circuits parth', 1, 1, '2024-01-24 07:40:03'),
(2, 'TS123', 'Toys', 'A toy or plaything is an object that is used primarily to provide entertainment. Simple examples include toy blocks, board games, and dolls.', 2, 1, '2024-01-24 07:40:45'),
(3, 'HM123', 'HomeDecor', 'Household items are supplies, furnishings and equipment that are potentially shared between members of a household.', 3, 1, '2024-01-24 07:41:13'),
(4, 'SP123', 'Sports', 'Sports equipment, sporting equipment, also called sporting goods, are the tools, materials, apparel, and gear used to compete in a sport', 4, 1, '2024-01-24 07:41:37');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_12_22_052437_create_products_table', 1),
(6, '2023_12_22_082455_create_products_table', 2),
(7, '2023_12_22_091757_add_image_and_price_to_products_table', 3),
(8, '2024_01_11_125433_create_products_categories_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `id` int NOT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `productId` int DEFAULT NULL,
  `orderId` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`id`, `sku`, `name`, `price`, `total`, `productId`, `orderId`, `created_at`) VALUES
(1, 'PT23', 'Tshirt', 232, 786, 3, 1, '2024-02-14 10:07:37'),
(2, 'SP123', 'JBL', 99, 786, 5, 1, '2024-02-14 10:07:37'),
(3, 'SM123', 'Auss rog', 421, 786, 6, 1, '2024-02-14 10:07:37'),
(4, 'WA123', 'Watch', 34, 786, 9, 1, '2024-02-14 10:07:37'),
(5, 'PT23', 'Tshirt', 232, 786, 3, 2, '2024-02-14 10:09:24'),
(6, 'SP123', 'JBL', 99, 786, 5, 2, '2024-02-14 10:09:24'),
(7, 'SM123', 'Auss rog', 421, 786, 6, 2, '2024-02-14 10:09:24'),
(8, 'WA123', 'Watch', 34, 786, 9, 2, '2024-02-14 10:09:24'),
(9, 'PT23', 'Tshirt', 232, 687, 3, 3, '2024-02-14 10:10:08'),
(10, 'SM123', 'Auss rog', 421, 687, 6, 3, '2024-02-14 10:10:08'),
(11, 'WA123', 'Watch', 34, 687, 9, 3, '2024-02-14 10:10:08'),
(12, 'PT23', 'Tshirt', 232, 687, 3, 4, '2024-02-14 10:10:22'),
(13, 'SM123', 'Auss rog', 421, 687, 6, 4, '2024-02-14 10:10:23'),
(14, 'WA123', 'Watch', 34, 687, 9, 4, '2024-02-14 10:10:23');

-- --------------------------------------------------------

--
-- Table structure for table `orderpayments`
--

CREATE TABLE `orderpayments` (
  `id` int NOT NULL,
  `method` varchar(255) DEFAULT NULL,
  `methodTitle` varchar(255) DEFAULT NULL,
  `orderId` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orderpayments`
--

INSERT INTO `orderpayments` (`id`, `method`, `methodTitle`, `orderId`, `created_at`) VALUES
(1, 'Cod', 'Cod', 1, '2024-02-14 10:07:37'),
(2, 'Stripe', 'Stripe', 2, '2024-02-14 10:09:24'),
(3, 'Cod', 'Cod', 3, '2024-02-14 10:10:08'),
(4, 'Stripe', 'Stripe', 4, '2024-02-14 10:10:22');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `customerEmail` varchar(255) DEFAULT NULL,
  `customerName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `shippingMethod` varchar(255) DEFAULT NULL,
  `totalItemCount` int DEFAULT NULL,
  `totalQtyOrdered` int DEFAULT NULL,
  `grandTotal` float DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `cartId` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `status`, `customerEmail`, `customerName`, `shippingMethod`, `totalItemCount`, `totalQtyOrdered`, `grandTotal`, `customerId`, `cartId`, `created_at`, `updated_at`) VALUES
(1, 'pending', 'noddy@gmail.com', 'parth', 'Cod', 4, 4, 786, 2, NULL, '2024-02-14 10:07:37', '2024-02-14 10:07:37'),
(2, 'succeeded', 'noddy@gmail.com', 'parth', 'Stripe', 4, 4, 786, 2, NULL, '2024-02-14 10:09:24', '2024-02-14 10:09:24'),
(3, 'pending', 'demo@gmail.com', 'demo', 'Cod', 3, 3, 687, 3, NULL, '2024-02-14 10:10:08', '2024-02-14 10:10:08'),
(4, 'succeeded', 'demo@gmail.com', 'demo', 'Stripe', 3, 3, 687, 3, NULL, '2024-02-14 10:10:22', '2024-02-14 10:10:22');

-- --------------------------------------------------------

--
-- Table structure for table `ordertransactions`
--

CREATE TABLE `ordertransactions` (
  `id` int NOT NULL,
  `transactionId` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `paymentMethod` varchar(255) DEFAULT NULL,
  `orderId` int DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_adds`
--

CREATE TABLE `order_adds` (
  `id` int NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `postcode` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `country` varchar(225) NOT NULL,
  `email` varchar(225) NOT NULL,
  `phone` varchar(225) NOT NULL,
  `order_Id` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_adds`
--

INSERT INTO `order_adds` (`id`, `fullName`, `postcode`, `state`, `city`, `country`, `email`, `phone`, `order_Id`, `created_at`) VALUES
(1, 'parth', '123321', 'mp', 'ujjain', 'india', 'hinge@gmail.com', '12312', 1, '2024-02-14 10:07:37'),
(2, 'parth', '123321', 'mp', 'ujjain', 'india', 'hinge@gmail.com', '12312', 2, '2024-02-14 10:09:24'),
(3, 'demo address', '43212', 'landon', 'ky pata', 'uk', 'demo@gmail.com', '6534522', 3, '2024-02-14 10:10:08'),
(4, 'demo address', '43212', 'landon', 'ky pata', 'uk', 'demo@gmail.com', '6534522', 4, '2024-02-14 10:10:22');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'MyApp', 'e669405cadd73d798c1016844fd26ca5aa65818ffdb27be5f03e6c73c8aec8e9', '[\"*\"]', NULL, NULL, '2023-12-27 03:41:19', '2023-12-27 03:41:19'),
(2, 'App\\Models\\User', 1, 'MyApp', '93fc21715ff63f80fb745de47cb0c25d6115a1b8c3d55aee646234124bb209fc', '[\"*\"]', NULL, NULL, '2023-12-27 03:53:23', '2023-12-27 03:53:23'),
(3, 'App\\Models\\User', 1, 'MyApp', 'b053b83e69759c54b0ed6431bac29fc6761eeb0b56627a5dfd10fc9ad80db316', '[\"*\"]', NULL, NULL, '2023-12-27 03:53:31', '2023-12-27 03:53:31'),
(4, 'App\\Models\\User', 1, 'MyApp', '3c920ef5dc745762ff9ea8c0be1768519df701e41e990c9dbaf2d8cb1dbe930c', '[\"*\"]', NULL, NULL, '2023-12-27 03:54:01', '2023-12-27 03:54:01'),
(5, 'App\\Models\\User', 2, 'MyApp', 'f2bca38fd4becd87415751b7bf45e1b640031b6f43fa72b73fcdd8e3b51dad8c', '[\"*\"]', NULL, NULL, '2023-12-27 04:02:59', '2023-12-27 04:02:59'),
(6, 'App\\Models\\User', 3, 'MyApp', '9f9d0682b45d180057b00f786feedccdc0ab113889f0b6d0915572af55a0b065', '[\"*\"]', NULL, NULL, '2023-12-27 04:07:18', '2023-12-27 04:07:18'),
(7, 'App\\Models\\User', 4, 'MyApp', '36a01c426c4b3f3f35e2e0c80710464ee42416c711e4ff2e67fbd38ac7a930bc', '[\"*\"]', NULL, NULL, '2023-12-27 04:08:25', '2023-12-27 04:08:25'),
(8, 'App\\Models\\User', 1, 'MyApp', '3e3afeb21b45c58e3608551c1db234e1f9f242cdac3e674a9e91d5a01a6046fa', '[\"*\"]', NULL, NULL, '2023-12-27 04:21:35', '2023-12-27 04:21:35'),
(9, 'App\\Models\\User', 1, 'MyApp', 'ca07f71513379bab3f1c2af50d8de7b0b4b8f0bd7b2ecc8be893402db310b785', '[\"*\"]', NULL, NULL, '2023-12-27 04:26:31', '2023-12-27 04:26:31'),
(10, 'App\\Models\\User', 5, 'MyApp', '4ed9e0d8bb679434ca44b767f422494597e1ec9c5ab96a1650ea3ceb9036ec29', '[\"*\"]', NULL, NULL, '2023-12-27 05:08:30', '2023-12-27 05:08:30'),
(11, 'App\\Models\\User', 2, 'auth_token', 'af64cd6a62b827bc51cb76263adea9d6ba8069619973cd3389feb82cb7f874d5', '[\"*\"]', NULL, NULL, '2023-12-27 05:25:45', '2023-12-27 05:25:45'),
(12, 'App\\Models\\User', 3, 'auth_token', '3aa369e1cff124df3a3249de7130c1ede5ca8a967247408fdaf7b229e2b26c80', '[\"*\"]', NULL, NULL, '2023-12-27 07:19:57', '2023-12-27 07:19:57'),
(13, 'App\\Models\\User', 4, 'auth_token', 'f2058f4e5f162dcba1d3d1da7e6070149e86ff836664cb951384a8552e4b3852', '[\"*\"]', NULL, NULL, '2023-12-27 07:21:15', '2023-12-27 07:21:15'),
(14, 'App\\Models\\User', 5, 'auth_token', '3e540d1b6735a88c0735121a01337ae49b4fc1fd09e26ac0d076daab57698025', '[\"*\"]', NULL, NULL, '2023-12-27 07:23:58', '2023-12-27 07:23:58'),
(15, 'App\\Models\\User', 6, 'auth_token', '691b93320f1b353291a948d2dc31d66536171c79a78cfdb22ecc99c46ce234fb', '[\"*\"]', NULL, NULL, '2023-12-27 07:24:47', '2023-12-27 07:24:47'),
(16, 'App\\Models\\User', 6, 'auth_token', '22ac1a5cb16f33f51ac8ab58a60f44da874dbe1d96ab279bd1eef2a3ececdf83', '[\"*\"]', NULL, NULL, '2023-12-27 07:25:01', '2023-12-27 07:25:01'),
(17, 'App\\Models\\User', 7, 'auth_token', '3e2edfa79cfc689ef3e72f2122513b93c9e6618525d370e413b5bf8368538894', '[\"*\"]', NULL, NULL, '2023-12-27 07:29:27', '2023-12-27 07:29:27'),
(18, 'App\\Models\\User', 9, 'auth_token', 'ef1e3ca317aee13e57a56badbe446ec7cd851917e614c58e79ab3f3c73d6cf8f', '[\"*\"]', NULL, NULL, '2023-12-27 07:36:32', '2023-12-27 07:36:32'),
(19, 'App\\Models\\User', 6, 'auth_token', 'f8015942180fd08eb5b99076680d4f17b7b1f3d73dac73b33b8d35c6673fb38a', '[\"*\"]', NULL, NULL, '2023-12-27 07:45:00', '2023-12-27 07:45:00'),
(20, 'App\\Models\\User', 2, 'auth_token', '285383d1c323940ad217ffdc3bab3a3625e436750ea2ce0244e5483c3d9e793d', '[\"*\"]', NULL, NULL, '2023-12-27 07:45:45', '2023-12-27 07:45:45'),
(21, 'App\\Models\\User', 2, 'auth_token', 'c7259c3ffaea037ad319bf7183ad9c9d006763d100717dbcdc48865ecfe4d728', '[\"*\"]', NULL, NULL, '2023-12-27 07:45:57', '2023-12-27 07:45:57'),
(22, 'App\\Models\\User', 2, 'auth_token', 'd47cf8b51184d526ef50fcd23d98a4b2635fa12aba40bcc714a5d00c50bafb31', '[\"*\"]', NULL, NULL, '2023-12-27 07:47:35', '2023-12-27 07:47:35'),
(23, 'App\\Models\\User', 2, 'auth_token', 'beedf2f866775fd46052c371c4ef19a0556f55852c77583f23429d745ef6ad41', '[\"*\"]', NULL, NULL, '2023-12-27 07:47:45', '2023-12-27 07:47:45'),
(24, 'App\\Models\\User', 2, 'auth_token', 'efa32574a5f2be1eec07b1339133171e4a885199330730d95521da2cac8dda9d', '[\"*\"]', NULL, NULL, '2023-12-27 07:48:44', '2023-12-27 07:48:44'),
(25, 'App\\Models\\User', 2, 'auth_token', 'd4d851b603c90474b03615c0b07465dc9bea03a5ae68bf855c0ccb057efb47c3', '[\"*\"]', NULL, NULL, '2023-12-27 07:56:45', '2023-12-27 07:56:45'),
(26, 'App\\Models\\User', 2, 'auth_token', 'aced2a568b8519a253eacf6af736ef1c4f9c037cb49b8af239b395704321226c', '[\"*\"]', NULL, NULL, '2023-12-27 07:59:51', '2023-12-27 07:59:51'),
(27, 'App\\Models\\User', 2, 'auth_token', '32481216fcb181215557056a255e6d2db227d79bf5b81f77656ebf6d9bbc55d8', '[\"*\"]', NULL, NULL, '2023-12-27 07:59:54', '2023-12-27 07:59:54'),
(28, 'App\\Models\\User', 2, 'auth_token', '259ffb4aec8efc1f1ba9d0e0d3144206c4b6d73fd173046ac594d76e2e5399de', '[\"*\"]', NULL, NULL, '2023-12-27 07:59:59', '2023-12-27 07:59:59'),
(29, 'App\\Models\\User', 2, 'auth_token', 'a2e7c8d3ab19b8068b78aa5fcb95c5611b27e49f9b59ab8e30c6569b3d407064', '[\"*\"]', NULL, NULL, '2023-12-27 08:01:54', '2023-12-27 08:01:54'),
(30, 'App\\Models\\User', 2, 'auth_token', 'c60d215689584ce78cfd01dd40a5131c34683782f046d37f58a268a0738e9f74', '[\"*\"]', NULL, NULL, '2023-12-27 08:01:59', '2023-12-27 08:01:59'),
(31, 'App\\Models\\User', 2, 'auth_token', 'ab4ddb2d8c6d941d71bb4bfa044e510133c30ef6e91482304ca7e2c8a577758f', '[\"*\"]', NULL, NULL, '2023-12-27 08:05:25', '2023-12-27 08:05:25'),
(32, 'App\\Models\\User', 2, 'auth_token', '82f54fd504dd7455cafa61e307f4e0c86253f0518de70590c70f02df16962121', '[\"*\"]', NULL, NULL, '2023-12-27 08:06:06', '2023-12-27 08:06:06'),
(33, 'App\\Models\\User', 2, 'auth_token', 'f86133e18a7ad8794b62aa5a3399ec9685971224e4a65b66ce2a68a4addaf6e4', '[\"*\"]', NULL, NULL, '2023-12-27 08:06:24', '2023-12-27 08:06:24'),
(34, 'App\\Models\\User', 2, 'auth_token', 'a015812cb6d40933b4f9f59bdb0a22f6e919725d1462b9960e4d2f90e5901e71', '[\"*\"]', NULL, NULL, '2023-12-27 08:06:29', '2023-12-27 08:06:29'),
(35, 'App\\Models\\User', 2, 'auth_token', 'b4388e162ea1d9297e8b197e4f5f8074fc1fabcad95f8027949c9c09c7853347', '[\"*\"]', NULL, NULL, '2023-12-27 08:08:38', '2023-12-27 08:08:38'),
(36, 'App\\Models\\User', 2, 'auth_token', '16237994eaf9f38c89436f59ab46068d89b464aa51febed6e6d3db348c9bc31f', '[\"*\"]', NULL, NULL, '2023-12-27 08:09:09', '2023-12-27 08:09:09'),
(37, 'App\\Models\\User', 2, 'auth_token', 'b6d66b6482449011a700bc6f760623a8065c24798959e35951da0a3bef3441e9', '[\"*\"]', NULL, NULL, '2023-12-27 08:09:47', '2023-12-27 08:09:47'),
(38, 'App\\Models\\User', 2, 'auth_token', 'd8992fe09634e77b8cd769d945608c5a1591dfa37cfc7341445aea91c345b687', '[\"*\"]', NULL, NULL, '2023-12-27 08:10:07', '2023-12-27 08:10:07'),
(39, 'App\\Models\\User', 3, 'auth_token', '8a18ba43983dab92aeaf560b23637fe42146926556bf14e51274482b8c3fb752', '[\"*\"]', NULL, NULL, '2023-12-27 08:16:09', '2023-12-27 08:16:09'),
(40, 'App\\Models\\User', 2, 'auth_token', '976f29c51fc04432726abfa185cde47da490beef172bb7b3f86e1508743a7186', '[\"*\"]', NULL, NULL, '2023-12-27 08:20:51', '2023-12-27 08:20:51'),
(41, 'App\\Models\\User', 2, 'auth_token', '52861708f4963be182eddabc48f2f7335a9c2d456955ab1d4590485bce26d58a', '[\"*\"]', NULL, NULL, '2023-12-27 08:20:57', '2023-12-27 08:20:57'),
(42, 'App\\Models\\User', 2, 'auth_token', '4bdb5ec4a6b705c1f4e3c4b55379fdfff330620ccffe220e4734ef816a8a0b5b', '[\"*\"]', NULL, NULL, '2023-12-27 08:21:02', '2023-12-27 08:21:02'),
(43, 'App\\Models\\User', 2, 'auth_token', 'ddd20877a251b5d44aba1a46668bdc53f687907075bc920a74eeee3befee392f', '[\"*\"]', NULL, NULL, '2023-12-27 08:22:01', '2023-12-27 08:22:01'),
(44, 'App\\Models\\User', 2, 'auth_token', '3b18d38c137aec9ec4e2e0b886b0aad837854ea51b9e16cc41af01ab9a049318', '[\"*\"]', NULL, NULL, '2023-12-27 08:23:08', '2023-12-27 08:23:08'),
(45, 'App\\Models\\User', 2, 'auth_token', '752b96f398fff1e42becdafab0b7daa656cb6e406370d14c59e2e7f315becdc3', '[\"*\"]', NULL, NULL, '2023-12-27 08:23:11', '2023-12-27 08:23:11'),
(46, 'App\\Models\\User', 2, 'auth_token', '646e8b32995860b507ff224f0f2fbba3243dd2bd8177072ebce83460daf17c0c', '[\"*\"]', NULL, NULL, '2023-12-27 08:23:24', '2023-12-27 08:23:24'),
(47, 'App\\Models\\User', 4, 'auth_token', 'ba1a099ca2159b900cdce394f1861122372924c829f2c6e92f4b7e6231bafc18', '[\"*\"]', NULL, NULL, '2023-12-27 08:28:33', '2023-12-27 08:28:33'),
(48, 'App\\Models\\User', 2, 'auth_token', 'dc78494fef074a8dc5c765c2450fd8bdf211fb5e1a5fb0e30653a42c5cdc5f61', '[\"*\"]', NULL, NULL, '2023-12-27 08:28:45', '2023-12-27 08:28:45'),
(49, 'App\\Models\\User', 2, 'auth_token', '7c104063ddf1b9bc24c2489936b7fb70b0e7a09ab2941a589f6e02dd0d2f79a8', '[\"*\"]', NULL, NULL, '2023-12-27 08:29:45', '2023-12-27 08:29:45'),
(50, 'App\\Models\\User', 2, 'auth_token', '6fa40d7d418e3ebf43f722098f5047e68bc6f2e699e98ece4145017ee2721c9b', '[\"*\"]', NULL, NULL, '2023-12-27 08:30:21', '2023-12-27 08:30:21'),
(51, 'App\\Models\\User', 2, 'auth_token', 'd7558b5ccc144ae552d2e0c0c3132d0a3296e3d88b7f69b2ce2d7a1270da381b', '[\"*\"]', NULL, NULL, '2023-12-27 22:40:20', '2023-12-27 22:40:20'),
(52, 'App\\Models\\User', 2, 'auth_token', '52534735461fba18014f9a4ee011b2e4a0d2d0bfcd1f3abedc35622aa1e6beab', '[\"*\"]', NULL, NULL, '2023-12-27 22:50:02', '2023-12-27 22:50:02'),
(53, 'App\\Models\\User', 2, 'auth_token', 'd2c4dc2636cf487e74db54186f4146aae7d32b7de883c37e014f0c3d8bcce89d', '[\"*\"]', NULL, NULL, '2023-12-27 23:08:44', '2023-12-27 23:08:44'),
(54, 'App\\Models\\User', 2, 'auth_token', 'eda6c0bb728096f463e44eabebcceda1823fcfd9d4f074e9eb12bd81c75f2544', '[\"*\"]', NULL, NULL, '2023-12-27 23:14:07', '2023-12-27 23:14:07'),
(55, 'App\\Models\\User', 2, 'auth_token', '8764784ffc337335cf98b50238137edc7a8772f0ea06bd8fca5e79d1ba2cce80', '[\"*\"]', NULL, NULL, '2023-12-27 23:14:08', '2023-12-27 23:14:08'),
(56, 'App\\Models\\User', 2, 'auth_token', '369459214931e19083503fd6417518ba1eee0722d19c5f3be3b0fa2ac7a3c26b', '[\"*\"]', NULL, NULL, '2023-12-27 23:14:43', '2023-12-27 23:14:43'),
(57, 'App\\Models\\User', 1, 'auth_token', 'fa538290002aec3a741473ce50d8b32404381c8f23462aadda934f83ede08616', '[\"*\"]', NULL, NULL, '2023-12-27 23:15:04', '2023-12-27 23:15:04'),
(58, 'App\\Models\\User', 1, 'auth_token', 'f1ee6bf61c7c0e79cb9e15ddb4a290f9ba4bf708140cf55e4a74146349985b84', '[\"*\"]', NULL, NULL, '2023-12-27 23:15:15', '2023-12-27 23:15:15'),
(59, 'App\\Models\\User', 2, 'auth_token', '942a19c6387ec1426a773500e164ebd1c51d2dd8ca3fdc0a59e30cf01be2e0cc', '[\"*\"]', NULL, NULL, '2023-12-27 23:18:17', '2023-12-27 23:18:17'),
(60, 'App\\Models\\User', 2, 'auth_token', '2cc860ac715f4ec1cf66abfb7a653f6013a2c84644c4d3e7a8249726b89f2df7', '[\"*\"]', NULL, NULL, '2023-12-27 23:19:37', '2023-12-27 23:19:37'),
(61, 'App\\Models\\User', 2, 'auth_token', 'a7501bf0368182b72c385f0fcd5122833737e6822c8d6c179182424c4efdf143', '[\"*\"]', NULL, NULL, '2023-12-27 23:19:46', '2023-12-27 23:19:46'),
(62, 'App\\Models\\User', 2, 'auth_token', '7dfc77f944781799db4ef65699c1844d223b84d542af2929367189494fd6d5ac', '[\"*\"]', NULL, NULL, '2023-12-27 23:20:22', '2023-12-27 23:20:22'),
(63, 'App\\Models\\User', 5, 'auth_token', 'e187e95f8346e963f234407f80eaa983d21443734ec313b54d3f3bad7870053e', '[\"*\"]', NULL, NULL, '2023-12-27 23:30:23', '2023-12-27 23:30:23'),
(64, 'App\\Models\\User', 5, 'auth_token', '79a5bb89ee57c5546af8b3410b27de4177bea2a99fcb5729c314815c823f8b16', '[\"*\"]', NULL, NULL, '2023-12-27 23:30:32', '2023-12-27 23:30:32'),
(65, 'App\\Models\\User', 2, 'auth_token', 'c83a16250b3c510ad520d0bd54fa0e4c05b03ed1b89af2a3a9e01c9483082ad2', '[\"*\"]', NULL, NULL, '2023-12-27 23:30:52', '2023-12-27 23:30:52'),
(66, 'App\\Models\\User', 5, 'auth_token', '1c22cd72e2e7ac999321df898b52f58a9eb5bc60de6c41c2fa0e9d2442e09e63', '[\"*\"]', NULL, NULL, '2023-12-27 23:31:00', '2023-12-27 23:31:00'),
(67, 'App\\Models\\User', 5, 'auth_token', '968a864df42692962a4d8a9f55186d475dd9707e8db3821099a18b3a3f7e2257', '[\"*\"]', NULL, NULL, '2023-12-27 23:31:05', '2023-12-27 23:31:05'),
(68, 'App\\Models\\User', 5, 'auth_token', '6f78ff9d0764174499ec025ae182d8f6da62015c33b82e5c69d3999ced6ec1ce', '[\"*\"]', NULL, NULL, '2023-12-27 23:31:59', '2023-12-27 23:31:59'),
(69, 'App\\Models\\User', 5, 'auth_token', 'c09b0cc7c6960b110577d0c381cdec7ee826deb5a23d339ff2400c48abc572b5', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:03', '2023-12-27 23:33:03'),
(70, 'App\\Models\\User', 5, 'auth_token', '97953f2cd801ebb2562c751aab2e0e27accba581b5a4b8de94d272219d1cd53e', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:03', '2023-12-27 23:33:03'),
(71, 'App\\Models\\User', 5, 'auth_token', '9d4556326deadf9d28aca0e580ccbb17e4519eae8fb2c5032de26f33921c4a6e', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:04', '2023-12-27 23:33:04'),
(72, 'App\\Models\\User', 5, 'auth_token', '70fad3045a1b945fa9210abf1eb2462d4787e0c50ee6122cc76c3280e423f1c6', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:04', '2023-12-27 23:33:04'),
(73, 'App\\Models\\User', 5, 'auth_token', '230ef52a326fd4fa6b72efe6a1fd9b98343280bac96f88dd30e1e07ddcb676b8', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:08', '2023-12-27 23:33:08'),
(74, 'App\\Models\\User', 6, 'auth_token', '92f27760857f989d294b549ac9147cbb78b7593515f90b10f2c13437cc21ebb2', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:29', '2023-12-27 23:33:29'),
(75, 'App\\Models\\User', 6, 'auth_token', 'c8012b97dc12d714e4e907dcd5c11c2c75b2846fea17488f7340414c6b308278', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:37', '2023-12-27 23:33:37'),
(76, 'App\\Models\\User', 6, 'auth_token', '21b5bd587786e672cba7102e5e478a934245b328331ea38235feb36d9c3e5d0a', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:52', '2023-12-27 23:33:52'),
(77, 'App\\Models\\User', 6, 'auth_token', '1f03f1d727cf1147383703c764e20f5d8ce3eba284481523db6956cd6acda6cb', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:52', '2023-12-27 23:33:52'),
(78, 'App\\Models\\User', 6, 'auth_token', '3e67866073e8df3cf099880a5d2b5e16c44d772d50f4b16f3f1c4c7ee0da80d0', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:52', '2023-12-27 23:33:52'),
(79, 'App\\Models\\User', 6, 'auth_token', 'ce5c29990acb68d7c20d55cc00451a48986288c960a13dece05acf4fa23f2cfe', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:52', '2023-12-27 23:33:52'),
(80, 'App\\Models\\User', 6, 'auth_token', '854a0bce0519cc9a7e5c08b55573847523d60cd1067614096b4eebf0b7332fdb', '[\"*\"]', NULL, NULL, '2023-12-27 23:33:53', '2023-12-27 23:33:53'),
(81, 'App\\Models\\User', 6, 'auth_token', '6e1e64ea155e38cc789c953c788d0ab6ab18f571c7f9e4ff391c9874427c785b', '[\"*\"]', NULL, NULL, '2023-12-27 23:34:00', '2023-12-27 23:34:00'),
(82, 'App\\Models\\User', 7, 'auth_token', 'eadcf4fa0f072dc634da7ac362796393c76f1c674ed02a2b544d8b6707c3f3df', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:03', '2023-12-27 23:35:03'),
(83, 'App\\Models\\User', 6, 'auth_token', 'e29b23d2a948ebcfe7b48ea2135152c24723fca4fcaa74e1f936a8650e94563d', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:19', '2023-12-27 23:35:19'),
(84, 'App\\Models\\User', 1, 'auth_token', '0cb8a3c2def584db8091e16aeade77361f9e31571ad8a096f9ef44eec4eaf2fd', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:31', '2023-12-27 23:35:31'),
(85, 'App\\Models\\User', 1, 'auth_token', '647b48a069f39758517bc09db3c88f482e86019853225e733647fd8e43666ce7', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:33', '2023-12-27 23:35:33'),
(86, 'App\\Models\\User', 1, 'auth_token', 'e29a29ccb356257c28013b138493c0dd51154d97fb26f1d89147de4be997ff9f', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:33', '2023-12-27 23:35:33'),
(87, 'App\\Models\\User', 1, 'auth_token', 'c08c173faeea2e9f509697d18910b7356acd15ecac151f7ce4ea4df1273f58bd', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:33', '2023-12-27 23:35:33'),
(88, 'App\\Models\\User', 1, 'auth_token', '632d50ca75d0be698b9886188fdfa234ac6b22279a2f3b40e92d7f8295a25829', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:34', '2023-12-27 23:35:34'),
(89, 'App\\Models\\User', 1, 'auth_token', '877dc67e7a0e65cafff848ae21241fa54ea994132240b33432f80f4998683592', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:34', '2023-12-27 23:35:34'),
(90, 'App\\Models\\User', 1, 'auth_token', '793a89d95755c21dd739fae633e9a86b1a68c35bc8d093eca721ad2d7132ee96', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:35', '2023-12-27 23:35:35'),
(91, 'App\\Models\\User', 1, 'auth_token', '412297f9ef7c9d972fac411cb485b1a843dc1da3f8ae1bb0764212d49ae7c01c', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:35', '2023-12-27 23:35:35'),
(92, 'App\\Models\\User', 6, 'auth_token', 'f438def231b0e9a8da23dfdfd43c617e563c5f2e28cde14481119e120f5f16f1', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:41', '2023-12-27 23:35:41'),
(93, 'App\\Models\\User', 6, 'auth_token', '57df4d751060b8a4b02752016ec6296c38e72cd43d32e8be7ef4ca01dfa0cdf7', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:41', '2023-12-27 23:35:41'),
(94, 'App\\Models\\User', 6, 'auth_token', 'e2d08d38d491e5947de7d5664bf200e2b3c9f2178875c7df1b6ad5a1c8680739', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:42', '2023-12-27 23:35:42'),
(95, 'App\\Models\\User', 6, 'auth_token', '2801c6c5c7418ec04ab226763689209181c1044ce6655d4be7f1134c18a111b7', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:42', '2023-12-27 23:35:42'),
(96, 'App\\Models\\User', 6, 'auth_token', 'b4e2e938cfaab7ffb2fa0b7f39d0d3580d95adcb99d81bae1c4ff6add2492aeb', '[\"*\"]', NULL, NULL, '2023-12-27 23:35:42', '2023-12-27 23:35:42'),
(97, 'App\\Models\\User', 6, 'auth_token', '56f9a642e9c5bf494255113c848f46800ad03e82e6e3778810c15974f7674235', '[\"*\"]', NULL, NULL, '2023-12-27 23:36:02', '2023-12-27 23:36:02'),
(98, 'App\\Models\\User', 6, 'auth_token', '35ac77fae61e755c1983f1cbbe790d614439a3287a4221fa3f0b32028a34164c', '[\"*\"]', NULL, NULL, '2023-12-27 23:36:06', '2023-12-27 23:36:06'),
(99, 'App\\Models\\User', 6, 'auth_token', '87759462e1318e5345409097706f20e958a55ab20bd45d993ee9df5a5ace78ba', '[\"*\"]', NULL, NULL, '2023-12-27 23:36:10', '2023-12-27 23:36:10'),
(100, 'App\\Models\\User', 6, 'auth_token', '313848e3d1f6010b09dc2589f40e3e32c35a25345ba0868b4ed301b476fe123c', '[\"*\"]', NULL, NULL, '2023-12-27 23:37:02', '2023-12-27 23:37:02'),
(101, 'App\\Models\\User', 8, 'auth_token', '969846037eb093b2c961986c6bf32d7e8c05cb71f3ecb942c6faa5de64ae8256', '[\"*\"]', NULL, NULL, '2023-12-27 23:37:58', '2023-12-27 23:37:58'),
(102, 'App\\Models\\User', 2, 'auth_token', '3e6e0f46c6a54f5276ca84a5a9636aaf31c36c63ad1c78841cc9ea5f63eebf61', '[\"*\"]', NULL, NULL, '2023-12-27 23:38:24', '2023-12-27 23:38:24'),
(103, 'App\\Models\\User', 6, 'auth_token', 'e85d7a2766fb2c2d4960e9e883ce812678b72c7ecbb548a92fd181afc7f3ba7a', '[\"*\"]', NULL, NULL, '2023-12-27 23:39:28', '2023-12-27 23:39:28'),
(104, 'App\\Models\\User', 10, 'auth_token', '294cad321a2ff6751701fd18788294ab8c26e000c3c8f85024c9cc9c8cdaf369', '[\"*\"]', NULL, NULL, '2023-12-27 23:52:47', '2023-12-27 23:52:47'),
(105, 'App\\Models\\User', 2, 'auth_token', '8667129bda50c47350296bd2940ca2a189407f4c20e11a9d457772db2f1de95e', '[\"*\"]', NULL, NULL, '2023-12-27 23:53:42', '2023-12-27 23:53:42'),
(106, 'App\\Models\\User', 11, 'auth_token', 'ccc6ea2c06c66d877c7588b9a417bf6ecc0dcfcb6ebb03f31c0cdef3f17a6ab6', '[\"*\"]', NULL, NULL, '2023-12-27 23:54:13', '2023-12-27 23:54:13'),
(107, 'App\\Models\\User', 2, 'auth_token', 'bdd66fc3a0d1d0636346e96a5d4ec06bce6f88a0c66d49efb04390cc7e99bb66', '[\"*\"]', NULL, NULL, '2023-12-27 23:56:13', '2023-12-27 23:56:13'),
(108, 'App\\Models\\User', 12, 'auth_token', '568c627a8b149b3c84f2b15d2a15992466687a26c584e6cc7d2fae228e3b69f4', '[\"*\"]', NULL, NULL, '2023-12-27 23:56:31', '2023-12-27 23:56:31'),
(109, 'App\\Models\\User', 13, 'auth_token', '5d48a447bceb2a77c008356c39b86faa99e5dda8e797e6cac8af4e7fa3751ffc', '[\"*\"]', NULL, NULL, '2023-12-28 00:04:55', '2023-12-28 00:04:55'),
(110, 'App\\Models\\User', 14, 'auth_token', '575659fdbcbc69ad4701ee48c00a174aa6ff561db48fcabddf9e8eed4b166ed7', '[\"*\"]', NULL, NULL, '2023-12-28 00:09:25', '2023-12-28 00:09:25'),
(111, 'App\\Models\\User', 6, 'auth_token', 'a7ef08deb4e2bc8744a30e772185811920b9bb465bb618fb7c13fba9898c9394', '[\"*\"]', NULL, NULL, '2023-12-28 00:09:41', '2023-12-28 00:09:41'),
(112, 'App\\Models\\User', 15, 'auth_token', '1f684f60cdc95dc1b9875f7fcbf2eda402e291d75490da9a601f04f6a52194a9', '[\"*\"]', NULL, NULL, '2023-12-28 00:10:39', '2023-12-28 00:10:39'),
(113, 'App\\Models\\User', 6, 'auth_token', 'ef463ded2882f8089c81cbbeadf14df2dd83b197e70316fd69bc276d9de217fb', '[\"*\"]', NULL, NULL, '2023-12-28 00:11:20', '2023-12-28 00:11:20'),
(114, 'App\\Models\\User', 6, 'auth_token', '634fefbc092a3a3a8b994a95ee23024c24117d2b0fceafe91f788e242a6457de', '[\"*\"]', NULL, NULL, '2023-12-28 00:11:25', '2023-12-28 00:11:25'),
(115, 'App\\Models\\User', 6, 'auth_token', 'd4cec32fde6ba5311200996e7bc659f4632f501d3357120339eae830494b5f47', '[\"*\"]', NULL, NULL, '2023-12-28 00:11:34', '2023-12-28 00:11:34'),
(116, 'App\\Models\\User', 6, 'auth_token', '4e1df2299c5ea1a088a42a8cfa85ccd5736f5ba5db0e540c03727cb0aa9304f2', '[\"*\"]', NULL, NULL, '2023-12-28 00:11:35', '2023-12-28 00:11:35'),
(117, 'App\\Models\\User', 6, 'auth_token', '5b4552fb23b41b7e54945444e1eff961e9cdee103ff8eb8e80ab9489c7b4f30d', '[\"*\"]', NULL, NULL, '2023-12-28 00:11:35', '2023-12-28 00:11:35'),
(118, 'App\\Models\\User', 6, 'auth_token', 'beedf9ad2d9a8c7df724d92e238d6b23b7f943d618f69d27c00d64981097adcc', '[\"*\"]', NULL, NULL, '2023-12-28 00:11:35', '2023-12-28 00:11:35'),
(119, 'App\\Models\\User', 6, 'auth_token', 'e7dcfd5efe4c836d25323899c59a28436ce95e714234e993156b6b0f44932e5d', '[\"*\"]', NULL, NULL, '2023-12-28 00:11:35', '2023-12-28 00:11:35'),
(120, 'App\\Models\\User', 6, 'auth_token', '0ac80d7383c0c518f38289b0deb32973acc469a6cb7d195d423c5f9f5739076f', '[\"*\"]', NULL, NULL, '2023-12-28 00:11:36', '2023-12-28 00:11:36'),
(121, 'App\\Models\\User', 16, 'auth_token', '98e37b9d5b00d1be15674a4930bff50220ff98e330c85d945b95321706a9e242', '[\"*\"]', NULL, NULL, '2023-12-28 00:16:04', '2023-12-28 00:16:04'),
(122, 'App\\Models\\User', 2, 'auth_token', '0040842c69a75a53c545ebc3c20c5f279e261ceb5b155f2cbeff63f777f9d7b5', '[\"*\"]', NULL, NULL, '2023-12-28 00:18:28', '2023-12-28 00:18:28'),
(123, 'App\\Models\\User', 2, 'auth_token', 'ef55ba1b008f9519bb941cdeca9cf674e81770ee0e1c56a814c1a2f1fb6949d0', '[\"*\"]', NULL, NULL, '2023-12-28 00:22:54', '2023-12-28 00:22:54'),
(124, 'App\\Models\\User', 2, 'auth_token', '6a300edba4049801c3f17185f0b0b3fc27e61aa8a3fa7ebbe810ef237f0d033f', '[\"*\"]', NULL, NULL, '2023-12-28 00:23:13', '2023-12-28 00:23:13'),
(125, 'App\\Models\\User', 2, 'auth_token', 'd996d902ea820a5b21fda6050e214626c3bf6b7a4033587935d5b4a4ea5a2b85', '[\"*\"]', NULL, NULL, '2023-12-28 00:23:41', '2023-12-28 00:23:41'),
(126, 'App\\Models\\User', 17, 'auth_token', 'bd390e0acc08b2320126bfaf98fdd77d4c9e2ba033be8cb19f73040a7226e72a', '[\"*\"]', NULL, NULL, '2023-12-28 00:24:05', '2023-12-28 00:24:05'),
(127, 'App\\Models\\User', 17, 'auth_token', '0b25c57d2952ab4149327bc55be1a85cd7bfbcaa38a7f56ddaf4789943bfad40', '[\"*\"]', NULL, NULL, '2023-12-28 00:24:13', '2023-12-28 00:24:13'),
(128, 'App\\Models\\User', 18, 'auth_token', 'd0609fea080b19acda8069ed2a5c0966185f1d4d276ee58dc5a1bb31ce84696b', '[\"*\"]', NULL, NULL, '2023-12-28 00:26:15', '2023-12-28 00:26:15'),
(129, 'App\\Models\\User', 19, 'auth_token', 'f755d5ab3fd26e7b6ac431c8d5f854356a6934d5cca6bd1ad91be4a0c0b2eddc', '[\"*\"]', NULL, NULL, '2023-12-28 00:29:56', '2023-12-28 00:29:56'),
(130, 'App\\Models\\User', 20, 'auth_token', '78063058a32f9d0b6c3bdcd87bd09c400ace24ed1723b37fa4da7689fa2efa5c', '[\"*\"]', NULL, NULL, '2023-12-28 00:30:47', '2023-12-28 00:30:47'),
(131, 'App\\Models\\User', 21, 'auth_token', 'cdcc8e0c5847ec332543a969e66885e0f3df1167df29c7402f2595c53d918bb5', '[\"*\"]', NULL, NULL, '2023-12-28 00:34:32', '2023-12-28 00:34:32'),
(132, 'App\\Models\\User', 2, 'auth_token', '743d715c3f3ba56ea43a2a9a7b25afeff19185675c9f16078df9a843c5245391', '[\"*\"]', NULL, NULL, '2023-12-28 00:34:47', '2023-12-28 00:34:47'),
(133, 'App\\Models\\User', 22, 'auth_token', '58a0248af7d3e90da10147ccbe219d24a12303f191155086aa2ab110f8b8e478', '[\"*\"]', NULL, NULL, '2023-12-28 00:35:33', '2023-12-28 00:35:33'),
(134, 'App\\Models\\User', 2, 'auth_token', 'a13c8e36e9505ad85e19842b858de08eb8afb5f908462844833427ff0dea3140', '[\"*\"]', NULL, NULL, '2023-12-28 00:35:57', '2023-12-28 00:35:57'),
(135, 'App\\Models\\User', 23, 'auth_token', '11a78bd4541b08494fa0f00b4e1e3e43d434107fdd03a869341ee85937649d1b', '[\"*\"]', NULL, NULL, '2023-12-28 00:38:02', '2023-12-28 00:38:02'),
(136, 'App\\Models\\User', 2, 'auth_token', '098607822c223a3a4eceec44b2b3907957a59e2221faf109936f2c66484e5df0', '[\"*\"]', NULL, NULL, '2023-12-28 00:38:10', '2023-12-28 00:38:10'),
(137, 'App\\Models\\User', 24, 'auth_token', 'bbb17a9430ce1ce63b3dd6f0b7fe32cf1d964556d7d0e70db7325f60f34cba68', '[\"*\"]', NULL, NULL, '2023-12-28 00:52:07', '2023-12-28 00:52:07'),
(138, 'App\\Models\\User', 2, 'auth_token', '43b868a9884c0726b0a9712bf1730a3874b4291ee58cac3723b4237c2b87622c', '[\"*\"]', NULL, NULL, '2023-12-28 00:52:16', '2023-12-28 00:52:16'),
(139, 'App\\Models\\User', 25, 'auth_token', 'c51c2f4d90efb08c2f237e9cfd901ac8bd5f936c9788323fe0d0718975ee67e1', '[\"*\"]', NULL, NULL, '2023-12-28 00:53:40', '2023-12-28 00:53:40'),
(140, 'App\\Models\\User', 2, 'auth_token', '161cd4e817470088ca074301ed49e84cebc5d1db2c9ab937fb32854842378797', '[\"*\"]', NULL, NULL, '2023-12-28 00:53:47', '2023-12-28 00:53:47'),
(141, 'App\\Models\\User', 26, 'auth_token', '4cdaa49414f2d1c11872da951361b753f48dea142b8be4540ef9dd2e5f648b3e', '[\"*\"]', NULL, NULL, '2023-12-28 00:54:16', '2023-12-28 00:54:16'),
(142, 'App\\Models\\User', 27, 'auth_token', '775180c990daa960ebf9f102d52ee0f15d2a73cb6a2bec8f422dcaaec3defbaf', '[\"*\"]', NULL, NULL, '2023-12-28 01:07:30', '2023-12-28 01:07:30'),
(143, 'App\\Models\\User', 2, 'auth_token', 'aa34b12970e5dc5500efe67662edfc2b3fc6bc69074cbbfe05a4035435bd0571', '[\"*\"]', NULL, NULL, '2023-12-28 01:07:38', '2023-12-28 01:07:38'),
(144, 'App\\Models\\User', 2, 'auth_token', '7ecc1b44242a41d972ce17aec09f5b3a9b1efa2b463d7b86ae41445698b66af2', '[\"*\"]', NULL, NULL, '2023-12-28 02:05:47', '2023-12-28 02:05:47'),
(145, 'App\\Models\\User', 2, 'auth_token', '2ef915b29816f0e3285f56addf1f33893f1874ee1fb60db507a6132048eff3f7', '[\"*\"]', NULL, NULL, '2023-12-28 02:16:58', '2023-12-28 02:16:58'),
(146, 'App\\Models\\User', 2, 'auth_token', 'e5e51d5278142d69f1beebaf2c6780947333a427560d6c424f78fcd0945f5401', '[\"*\"]', NULL, NULL, '2023-12-28 02:17:14', '2023-12-28 02:17:14'),
(147, 'App\\Models\\User', 2, 'auth_token', '84ab280883eb006b9c2caf9e8bd708309d3790a417e1314eab7c1d60305c0d6c', '[\"*\"]', NULL, NULL, '2023-12-28 02:49:53', '2023-12-28 02:49:53'),
(148, 'App\\Models\\User', 28, 'auth_token', '87f86d869d886619e168f2cc5a1325fd6db2bba1c743d6fa7306259c3aa7f156', '[\"*\"]', NULL, NULL, '2023-12-28 02:51:14', '2023-12-28 02:51:14'),
(149, 'App\\Models\\User', 2, 'auth_token', '56787bbe126c5f42728a588d568c604d2e5a737f85999d17050751eb58fa1b32', '[\"*\"]', NULL, NULL, '2023-12-28 02:51:21', '2023-12-28 02:51:21'),
(150, 'App\\Models\\User', 2, 'auth_token', '443bfa6e1a2f832df3a8fc075d9c1be1b3131653b6a47cbcf66c527be1bb4e07', '[\"*\"]', NULL, NULL, '2023-12-28 02:55:02', '2023-12-28 02:55:02'),
(151, 'App\\Models\\User', 2, 'auth_token', '46799683f487a85e41a3a34f12f5ddd98f8747615a7ef014cccd8601b6232cc9', '[\"*\"]', NULL, NULL, '2023-12-28 03:14:22', '2023-12-28 03:14:22'),
(152, 'App\\Models\\User', 2, 'auth_token', 'a7835fa85ea635710c7e54cf04430e98af39ce2766877c82ad946e86cc5c1d27', '[\"*\"]', NULL, NULL, '2023-12-28 03:15:59', '2023-12-28 03:15:59'),
(153, 'App\\Models\\User', 2, 'auth_token', '5e6f317a8658bb070cfdf30d11b4c97cb2c132a320a1d413529cfcf3b2510a66', '[\"*\"]', NULL, NULL, '2023-12-28 03:19:27', '2023-12-28 03:19:27'),
(154, 'App\\Models\\User', 2, 'auth_token', 'b9066f3be6437ed5f6deeb958811bab99d37c7ed277a604d18fc549f012d138a', '[\"*\"]', NULL, NULL, '2023-12-28 03:44:11', '2023-12-28 03:44:11'),
(155, 'App\\Models\\User', 2, 'auth_token', 'fde265805e00939941e5cf1154e98d89052807ce7d25efba53428ece0d75788a', '[\"*\"]', NULL, NULL, '2023-12-28 03:52:17', '2023-12-28 03:52:17'),
(156, 'App\\Models\\User', 2, 'auth_token', '35d97128911d80783a32c2eea7884b1470016d5a12bf4bd23a2e544978708691', '[\"*\"]', NULL, NULL, '2023-12-28 03:54:33', '2023-12-28 03:54:33'),
(157, 'App\\Models\\User', 2, 'auth_token', 'cb215a0cd76c04d7def8d4173300757551c7e3d5118cba8eec782f58fdf05325', '[\"*\"]', NULL, NULL, '2023-12-28 03:57:45', '2023-12-28 03:57:45'),
(158, 'App\\Models\\User', 2, 'auth_token', 'e76ff04672c3a3540fb74bc06063ff401a5973577efc3306fef464cb58400407', '[\"*\"]', NULL, NULL, '2023-12-28 03:59:33', '2023-12-28 03:59:33'),
(159, 'App\\Models\\User', 2, 'auth_token', '4bcc9f74125f1438f8d95d46dc52663b2d8e585586c4ad241ab054ce500d58df', '[\"*\"]', NULL, NULL, '2023-12-28 04:00:48', '2023-12-28 04:00:48'),
(160, 'App\\Models\\User', 2, 'auth_token', '4a0836d8b012877156a0f6d3c391d1e991bcce4e48d38c7c832106c56744aefa', '[\"*\"]', NULL, NULL, '2023-12-28 04:28:12', '2023-12-28 04:28:12'),
(161, 'App\\Models\\User', 2, 'auth_token', 'ebeb2a19ca5ac4f7b1d6ad14aeda66904182f38dff7da767c1f9c157c46fdea2', '[\"*\"]', NULL, NULL, '2023-12-28 04:34:44', '2023-12-28 04:34:44'),
(162, 'App\\Models\\User', 2, 'auth_token', '16e6d9e4c455a0ccaf42623bc727ab95116c662506b36b8180960e64a66f9f72', '[\"*\"]', NULL, NULL, '2023-12-28 04:35:28', '2023-12-28 04:35:28'),
(163, 'App\\Models\\User', 29, 'auth_token', '7d2276c2788336cfde0a3794f8fd64f7964db46840c6acc2e2bb13993382d506', '[\"*\"]', NULL, NULL, '2023-12-28 05:11:50', '2023-12-28 05:11:50'),
(164, 'App\\Models\\User', 2, 'auth_token', 'f6c1d512a7780161e95dc5c6d0edc18fa2dba710cf7d448c264952d0e7ba03ca', '[\"*\"]', NULL, NULL, '2023-12-28 05:12:10', '2023-12-28 05:12:10'),
(165, 'App\\Models\\User', 2, 'auth_token', '8eb24806761241cd339ab32d7dad78d13d58a38935cd06a8f0d85dcb483e7412', '[\"*\"]', NULL, NULL, '2023-12-28 05:15:36', '2023-12-28 05:15:36'),
(166, 'App\\Models\\User', 2, 'auth_token', '5fcfc39e75a97d9c4102bda80f695cbed867193565499732f803023448b8e671', '[\"*\"]', NULL, NULL, '2023-12-28 05:16:50', '2023-12-28 05:16:50'),
(167, 'App\\Models\\User', 2, 'auth_token', '43e821642c7923f3f63253212def030d4d8ae69b776ac7bb434bfb034a2a4f1e', '[\"*\"]', NULL, NULL, '2023-12-28 05:18:31', '2023-12-28 05:18:31'),
(168, 'App\\Models\\User', 2, 'auth_token', '99bcc30b2907270fbd55e3fdee8a58f9eaaffbfb924f4918bd111a54ec91cb1e', '[\"*\"]', NULL, NULL, '2023-12-28 05:24:24', '2023-12-28 05:24:24'),
(169, 'App\\Models\\User', 2, 'auth_token', '97c1c9849bcb9c6a6ebe3e57b5e653a229b1329931bdaee5025b2ae8b70c04e7', '[\"*\"]', NULL, NULL, '2023-12-28 05:26:46', '2023-12-28 05:26:46'),
(170, 'App\\Models\\User', 2, 'auth_token', '94b1ba2f0165d322daf5fdc2029e1d80a34b3b2a8998bda9778286f633e5b70e', '[\"*\"]', NULL, NULL, '2023-12-28 05:27:31', '2023-12-28 05:27:31'),
(171, 'App\\Models\\User', 17, 'auth_token', '82779d7db05acbc9f2ad4089fe11f4d8f91d6bf9956694424a7f646e7c897ed0', '[\"*\"]', NULL, NULL, '2023-12-28 05:27:56', '2023-12-28 05:27:56'),
(172, 'App\\Models\\User', 2, 'auth_token', '7b6e5c74769ba516e7c13cf8d0f8165c398f64e54e55cd99f419e2d0cc3a7eae', '[\"*\"]', NULL, NULL, '2023-12-28 05:29:56', '2023-12-28 05:29:56'),
(173, 'App\\Models\\User', 2, 'auth_token', '01e4a901b550e795745a5a4959162bfbbc549d142cbca77f54480f4baa34d0ce', '[\"*\"]', NULL, NULL, '2023-12-28 05:31:58', '2023-12-28 05:31:58'),
(174, 'App\\Models\\User', 2, 'auth_token', '0865e50d574b40e5bf5e046b7e14659ddd17f436838e417ee7bb190f5d9f9235', '[\"*\"]', NULL, NULL, '2023-12-28 05:34:34', '2023-12-28 05:34:34'),
(175, 'App\\Models\\User', 2, 'auth_token', '189e7f14833c8ea9ec374c178e3ee3aaa65586888a9b006b4632b54263a15b0c', '[\"*\"]', NULL, NULL, '2023-12-28 05:52:22', '2023-12-28 05:52:22'),
(176, 'App\\Models\\User', 2, 'auth_token', 'ff091453c0defad2c07aa74e9d0ef0b2bb152a99ff54644eedf1c22dac2f463a', '[\"*\"]', NULL, NULL, '2023-12-28 07:19:37', '2023-12-28 07:19:37'),
(177, 'App\\Models\\User', 2, 'auth_token', '9795616c71b660c17699b0bd669f61bf60d8b2e37b39203a332b6a028a691090', '[\"*\"]', NULL, NULL, '2023-12-28 08:27:30', '2023-12-28 08:27:30'),
(178, 'App\\Models\\User', 2, 'auth_token', 'd6353d24c3e9940155d978ce615f1dfb0ff6e3ed5c2fce74300d743cf2bf80aa', '[\"*\"]', NULL, NULL, '2023-12-28 08:27:37', '2023-12-28 08:27:37'),
(179, 'App\\Models\\User', 2, 'auth_token', '1414bd876e632e897808f27b0e2852158d02dbeca133438927a3fc51f9a3a919', '[\"*\"]', NULL, NULL, '2023-12-28 08:38:26', '2023-12-28 08:38:26'),
(180, 'App\\Models\\User', 2, 'auth_token', 'b6349dcd9636efbaa20d0968bcc083daa42e3c6f495d9a02f511870f4b7ff519', '[\"*\"]', NULL, NULL, '2023-12-28 08:38:35', '2023-12-28 08:38:35'),
(181, 'App\\Models\\User', 3, 'auth_token', '6e44475d893a8e77bbed184f6445b5659a9427b6e4f57216f4f23b62f866568f', '[\"*\"]', NULL, NULL, '2023-12-28 08:38:53', '2023-12-28 08:38:53'),
(182, 'App\\Models\\User', 4, 'auth_token', '54aa4d909ab64e7ec32f7cf2da11a390d375f820055a852e61bde31d3a0a749d', '[\"*\"]', NULL, NULL, '2023-12-28 08:39:55', '2023-12-28 08:39:55'),
(183, 'App\\Models\\User', 5, 'auth_token', '2166df9deeecb1a8c2b53eb0d08b1dfa96be4edc119b960910b31d3c5e1978bd', '[\"*\"]', NULL, NULL, '2023-12-28 08:40:42', '2023-12-28 08:40:42'),
(184, 'App\\Models\\User', 3, 'auth_token', '23f1fec4ac902fbb7cae6ad687f7b729654c7349850c90450d7789d9f5a525d9', '[\"*\"]', NULL, NULL, '2023-12-28 08:40:51', '2023-12-28 08:40:51'),
(185, 'App\\Models\\User', 3, 'auth_token', '872da3c91b89ad34de183023e986020e4bec3acd345190142e6c6b9693dd1a2f', '[\"*\"]', NULL, NULL, '2023-12-28 08:42:22', '2023-12-28 08:42:22'),
(186, 'App\\Models\\User', 3, 'auth_token', 'e4ab16fe5b8f24788ebc07141ee1640829ed98b717c4d233647fc037f6d40248', '[\"*\"]', NULL, NULL, '2023-12-28 08:44:17', '2023-12-28 08:44:17'),
(187, 'App\\Models\\User', 3, 'auth_token', 'c2db210ecafa5788a7e49ed4ba18406e0e79a09c8b498f58f42b992c9aa39f40', '[\"*\"]', NULL, NULL, '2023-12-28 08:44:32', '2023-12-28 08:44:32'),
(188, 'App\\Models\\User', 3, 'auth_token', '085454c5ff8c62a0dfc697551daa403a1768dff03a1db862eb89e6a5143a4448', '[\"*\"]', NULL, NULL, '2023-12-28 08:44:56', '2023-12-28 08:44:56'),
(189, 'App\\Models\\User', 3, 'auth_token', '8c98c2dae9c4f052ef0ccb64edd956ef58aea9b68ac28813aaef401ba02d4afa', '[\"*\"]', NULL, NULL, '2023-12-28 08:47:02', '2023-12-28 08:47:02'),
(190, 'App\\Models\\User', 6, 'auth_token', 'ed35bacdbf49df01e8712f1b6bc971c5680d2785369e42339be9c392959fa9a4', '[\"*\"]', NULL, NULL, '2023-12-28 08:47:20', '2023-12-28 08:47:20'),
(191, 'App\\Models\\User', 7, 'auth_token', '7766e5ff54f7d03c0aa75b5dc54c7286460f737c4458de9042988e983dba053e', '[\"*\"]', NULL, NULL, '2023-12-28 08:48:52', '2023-12-28 08:48:52'),
(192, 'App\\Models\\User', 3, 'auth_token', 'd626441eed494f5efb3d10806947216c81a99ee0bc38bcd3b21917332f199689', '[\"*\"]', NULL, NULL, '2023-12-28 08:48:59', '2023-12-28 08:48:59'),
(193, 'App\\Models\\User', 8, 'auth_token', '69dad24b03bd729baaa5706d968b39496f6bc2c93c56443fe8513ec2cc9e0e6a', '[\"*\"]', NULL, NULL, '2023-12-28 08:50:07', '2023-12-28 08:50:07'),
(194, 'App\\Models\\User', 8, 'auth_token', 'aec56ce7a3c60ec39b190911bb7ac6ec2d3ed177b6995461b92c1a87a535f0f9', '[\"*\"]', NULL, NULL, '2023-12-28 08:50:13', '2023-12-28 08:50:13'),
(195, 'App\\Models\\User', 8, 'auth_token', 'a91e46a6670fa73fc451b13c035b3d26790eb8f82b244052a7ff93bc7c40d9dc', '[\"*\"]', NULL, NULL, '2023-12-28 22:32:32', '2023-12-28 22:32:32'),
(196, 'App\\Models\\User', 8, 'auth_token', '2e9c552f22de9407dacb82683d8ab36eb103e93b3e068a06521f43e501b24bcb', '[\"*\"]', NULL, NULL, '2023-12-28 22:44:14', '2023-12-28 22:44:14'),
(197, 'App\\Models\\User', 8, 'auth_token', '7c9f4f1ed28233213e8af13ffceb6dac873454432f5faaa672fd1c7b5b321faf', '[\"*\"]', NULL, NULL, '2023-12-28 22:45:31', '2023-12-28 22:45:31'),
(198, 'App\\Models\\User', 8, 'auth_token', '960014e5ffa0d25a84ab56dd63b589cb135e45eac69a586350d904e896a37476', '[\"*\"]', NULL, NULL, '2023-12-28 23:33:07', '2023-12-28 23:33:07'),
(199, 'App\\Models\\User', 8, 'auth_token', 'b00142c85d2a5c81d23212c36b0396513cdd3b6eb18e381d944dcefce9f5ca0d', '[\"*\"]', NULL, NULL, '2023-12-28 23:42:22', '2023-12-28 23:42:22'),
(200, 'App\\Models\\User', 8, 'auth_token', '03f0c6510cc2c7ce006d9e5e41a4a7dadc9b28b1a09f4e3726fc78dba576ea04', '[\"*\"]', NULL, NULL, '2023-12-28 23:56:04', '2023-12-28 23:56:04'),
(201, 'App\\Models\\User', 8, 'auth_token', 'f44b9ee148c761a956d1caa82d1409789c115378e46b97b3913d12ed501998ef', '[\"*\"]', NULL, NULL, '2023-12-28 23:56:34', '2023-12-28 23:56:34'),
(202, 'App\\Models\\User', 8, 'auth_token', '7d7d92657ea6dbf403721f20da7f93a87221b425efee4ffdf5884247ac948209', '[\"*\"]', NULL, NULL, '2023-12-29 00:00:39', '2023-12-29 00:00:39'),
(203, 'App\\Models\\User', 8, 'auth_token', 'cab4acbecfd7cf1a2e8f8a8816cc12d6b2af7aab3080a2f0871f6ad72ed29430', '[\"*\"]', NULL, NULL, '2023-12-29 00:28:27', '2023-12-29 00:28:27'),
(204, 'App\\Models\\User', 8, 'auth_token', 'b4210637073e3f5f6289eecbed6c011819712f0a494d5de0d5061386a0780692', '[\"*\"]', NULL, NULL, '2023-12-29 00:50:25', '2023-12-29 00:50:25'),
(205, 'App\\Models\\User', 8, 'auth_token', 'a205d29806dc649a9e4c420158c039b9f0f36030648ce759f9dd9dff2330bea1', '[\"*\"]', NULL, NULL, '2023-12-29 01:08:25', '2023-12-29 01:08:25'),
(206, 'App\\Models\\User', 8, 'auth_token', '1abd6570fa658e8a493702c052d507cc1e9bc8b8a6ea6723345390e061137f2b', '[\"*\"]', NULL, NULL, '2023-12-29 01:12:17', '2023-12-29 01:12:17'),
(207, 'App\\Models\\User', 8, 'auth_token', '5bb111b21de0b5d6ac2da0d825d8c365f4672a1801b55126150133cb45a35d6e', '[\"*\"]', NULL, NULL, '2023-12-29 01:26:05', '2023-12-29 01:26:05'),
(208, 'App\\Models\\User', 8, 'auth_token', 'ab510f15903c83c48aa230a8198994379d46b1052d1de6f8539a17866b6a3f67', '[\"*\"]', NULL, NULL, '2023-12-29 02:05:05', '2023-12-29 02:05:05'),
(209, 'App\\Models\\User', 8, 'auth_token', 'c864a39ac106674fc096b3e4fe9deeb2a1fe2ebbcd1ae156f8cfbf23f74a9a4c', '[\"*\"]', NULL, NULL, '2023-12-29 02:49:50', '2023-12-29 02:49:50'),
(210, 'App\\Models\\User', 8, 'auth_token', 'e44e166660a6f8f63c9dbc13b833faf4cc10b727844a808c214e6bb4a0a45642', '[\"*\"]', NULL, NULL, '2023-12-29 02:50:41', '2023-12-29 02:50:41'),
(211, 'App\\Models\\User', 8, 'auth_token', 'bb31f227ad5b3b8d6cbde7406a57a93ea17c4b3321f15040db304dbd68db6e53', '[\"*\"]', NULL, NULL, '2023-12-29 03:48:07', '2023-12-29 03:48:07'),
(212, 'App\\Models\\User', 8, 'auth_token', '033de06721565cf9322fe9e88e29048a75fea4f010ddffde941ef726370c0ad5', '[\"*\"]', NULL, NULL, '2023-12-29 03:50:52', '2023-12-29 03:50:52'),
(213, 'App\\Models\\User', 8, 'auth_token', 'e48921d3b0c5423196bf04a045dd42a040f22e0e3202132c0ecc7b1bf71b2af5', '[\"*\"]', NULL, NULL, '2023-12-29 04:40:57', '2023-12-29 04:40:57'),
(214, 'App\\Models\\User', 8, 'auth_token', '97f2314b194aa4e28e436e0f9c88ff645f004306b4d3bf55935488e1fca9da90', '[\"*\"]', NULL, NULL, '2023-12-29 04:51:27', '2023-12-29 04:51:27'),
(215, 'App\\Models\\User', 9, 'auth_token', 'a2e1bb12fb5348d6dec4b96de596425a45c8323922cb96a478545f51bc02e2c4', '[\"*\"]', NULL, NULL, '2023-12-29 05:11:42', '2023-12-29 05:11:42'),
(216, 'App\\Models\\User', 9, 'auth_token', '12326f19f75f1e519ee2e0df5c30c59d88b6fb71265d84560341b8bf4f82141d', '[\"*\"]', NULL, NULL, '2023-12-29 05:11:54', '2023-12-29 05:11:54'),
(217, 'App\\Models\\User', 9, 'auth_token', 'f6cc286ae49d65d5792d5496819c2816592f87a2d7226c30ae5b40c6174927af', '[\"*\"]', NULL, NULL, '2023-12-29 05:19:22', '2023-12-29 05:19:22'),
(218, 'App\\Models\\User', 9, 'auth_token', '1df170c854307bdeb94bf283d00b49ba5fbc0b903e23df37b5a95920a96af05e', '[\"*\"]', NULL, NULL, '2023-12-29 05:42:01', '2023-12-29 05:42:01'),
(219, 'App\\Models\\User', 9, 'auth_token', 'b3cabba2413ec10cf738c9b975e741f8c7d2c807722691791dfb8d0d0eff77fa', '[\"*\"]', NULL, NULL, '2023-12-29 05:59:05', '2023-12-29 05:59:05'),
(220, 'App\\Models\\User', 4, 'auth_token', '0d697bd7fa570c2a628f2ad35a8e5fc78a690e511c776423178edfacf7906c2f', '[\"*\"]', NULL, NULL, '2023-12-29 07:12:24', '2023-12-29 07:12:24'),
(221, 'App\\Models\\User', 4, 'auth_token', '40a646997ec881594d4cdf05b7e222a1b636c11063f2210ae9c1af08b7954f7a', '[\"*\"]', NULL, NULL, '2024-01-01 22:54:39', '2024-01-01 22:54:39'),
(222, 'App\\Models\\User', 4, 'auth_token', 'cd1a26554721baf8a92bcbc4d80282c903ddc428a60f88dd4f7ad6e56136a4cd', '[\"*\"]', NULL, NULL, '2024-01-01 22:58:53', '2024-01-01 22:58:53'),
(223, 'App\\Models\\User', 4, 'auth_token', 'e29ba790b79adb0f6d02109de16a74f7fd0bd7e186f316865fa36003b992c765', '[\"*\"]', NULL, NULL, '2024-01-08 04:50:21', '2024-01-08 04:50:21'),
(224, 'App\\Models\\User', 4, 'auth_token', 'a3227019512a6e485d44bc6c71b5733bfd03a32894f623069a92746493eff5c9', '[\"*\"]', NULL, NULL, '2024-01-08 05:20:10', '2024-01-08 05:20:10'),
(225, 'App\\Models\\User', 4, 'auth_token', '69ad0d89eb5eaa2269755b4ba65a3344e585e8e0469c5f9c5762fff4b188ff3d', '[\"*\"]', NULL, NULL, '2024-01-08 08:14:50', '2024-01-08 08:14:50'),
(226, 'App\\Models\\User', 4, 'auth_token', 'bc0961a6a725c1bedf9a0cf4ee71cc2fca522a34e41ccc6dcf6a389841e9b9a5', '[\"*\"]', NULL, NULL, '2024-01-09 02:31:59', '2024-01-09 02:31:59'),
(227, 'App\\Models\\User', 4, 'auth_token', '3d0c22749fb2164ddc5e3a4ca80b077432fcb7d477ba0e18bd4a5360852ede5a', '[\"*\"]', NULL, NULL, '2024-01-09 02:32:00', '2024-01-09 02:32:00'),
(228, 'App\\Models\\User', 4, 'auth_token', '03211ef22a6dfea2620f848acdd3c95db5fa90a822300224a4c92bd05a240dd1', '[\"*\"]', NULL, NULL, '2024-01-09 02:32:06', '2024-01-09 02:32:06'),
(229, 'App\\Models\\User', 4, 'auth_token', 'a9d33b2a8df3ec462b6a727d482310d2ff4cc699d82b16d11bd8c819c06ff2db', '[\"*\"]', NULL, NULL, '2024-01-09 02:55:18', '2024-01-09 02:55:18'),
(230, 'App\\Models\\User', 4, 'auth_token', '0390c63217afdc76c44d39fbfeefec3032825c1075343a2c3ad4d9a2b06b2873', '[\"*\"]', NULL, NULL, '2024-01-09 03:26:13', '2024-01-09 03:26:13'),
(231, 'App\\Models\\User', 4, 'auth_token', 'd1937258e2540bfe3b86f970a0915bd776aa234975ea85869b2e6063c9748ab7', '[\"*\"]', NULL, NULL, '2024-01-09 03:28:12', '2024-01-09 03:28:12'),
(232, 'App\\Models\\User', 4, 'auth_token', 'e2dc9c7ee24df12d018dba3f0f2d21cc789798e132c45e50b6986dbb05190ae8', '[\"*\"]', NULL, NULL, '2024-01-09 03:43:18', '2024-01-09 03:43:18'),
(233, 'App\\Models\\User', 4, 'auth_token', '11cc90ecdddf06b95e9bf6866dc2654f492ddcee16ca0d5e705b1303f943af7d', '[\"*\"]', NULL, NULL, '2024-01-09 03:43:56', '2024-01-09 03:43:56'),
(234, 'App\\Models\\User', 4, 'auth_token', 'f10f8eaa959473e84a8b5edfc81785d3868d8f6d88985411577ae1ffe1620306', '[\"*\"]', NULL, NULL, '2024-01-09 03:45:32', '2024-01-09 03:45:32'),
(235, 'App\\Models\\User', 4, 'auth_token', 'a925a92f67153a2f1497f781a6994fe5c68ff4b6ba1b3236c68141bdadd5e4cb', '[\"*\"]', NULL, NULL, '2024-01-09 03:46:19', '2024-01-09 03:46:19'),
(236, 'App\\Models\\User', 4, 'auth_token', '55c0bb21436256b22a4bfc2222f6fb5be7c36fc019926b190a875fbf3052c200', '[\"*\"]', NULL, NULL, '2024-01-09 03:46:36', '2024-01-09 03:46:36'),
(237, 'App\\Models\\User', 4, 'auth_token', '0aec439e1210f1b5c8fb64b1ea37dde249febb32270969e4b9b059bca290c643', '[\"*\"]', NULL, NULL, '2024-01-09 03:46:54', '2024-01-09 03:46:54'),
(238, 'App\\Models\\User', 4, 'auth_token', '9382b6d80597ecfa2079c089899af0c8fd91bb271c7e7f9fefc905ad88c768bb', '[\"*\"]', NULL, NULL, '2024-01-09 03:47:23', '2024-01-09 03:47:23'),
(239, 'App\\Models\\User', 4, 'auth_token', '1d7e2a696d74b97720de350a3f20bb43c038ef78acc299fcff2c5249630e94f8', '[\"*\"]', NULL, NULL, '2024-01-09 03:47:51', '2024-01-09 03:47:51'),
(240, 'App\\Models\\User', 4, 'auth_token', '81b86039b0d58ab395711056aac0cfa10f5fca456cb2afad1bf2a8a6e8c4b2b7', '[\"*\"]', NULL, NULL, '2024-01-09 03:48:58', '2024-01-09 03:48:58'),
(241, 'App\\Models\\User', 4, 'auth_token', '99b5e4d36204031a841142f21728bab33f55f6d9bfd931b04b81ee21d444f3b5', '[\"*\"]', NULL, NULL, '2024-01-09 03:49:01', '2024-01-09 03:49:01'),
(242, 'App\\Models\\User', 4, 'auth_token', 'bf5887ef3167e091c9407022e37732651c5683ec1db53fbba6da897304a81a8a', '[\"*\"]', NULL, NULL, '2024-01-09 03:49:01', '2024-01-09 03:49:01'),
(243, 'App\\Models\\User', 4, 'auth_token', '08374b42c437240f7e95472e0f01f74215663b2484d9e27d79de0f840bcb8af9', '[\"*\"]', NULL, NULL, '2024-01-09 03:49:14', '2024-01-09 03:49:14'),
(244, 'App\\Models\\User', 4, 'auth_token', 'e48fc032baff659cdd790e772727a1be107ab2f8ca5928a9bd9902e3817d0865', '[\"*\"]', NULL, NULL, '2024-01-09 03:49:16', '2024-01-09 03:49:16'),
(245, 'App\\Models\\User', 4, 'auth_token', '7f6a90fc985d11d171ae538117c0a35583c864855fc3c37471608698f039cce9', '[\"*\"]', NULL, NULL, '2024-01-09 03:51:11', '2024-01-09 03:51:11'),
(246, 'App\\Models\\User', 4, 'auth_token', 'e00b61a6beca8d75bb1029e1517e3436d241b0354267472f498b1eec9a606779', '[\"*\"]', NULL, NULL, '2024-01-09 03:52:04', '2024-01-09 03:52:04'),
(247, 'App\\Models\\User', 4, 'auth_token', '4806fd66fbd577581483706d0b73bc97c3945efbb5d032015878dd29c2ecce3b', '[\"*\"]', NULL, NULL, '2024-01-09 03:54:23', '2024-01-09 03:54:23'),
(248, 'App\\Models\\User', 4, 'auth_token', '42ba4dad2fccdb78a06e1a8c3c37ea8d9b605526086d2796fdaf1b1232e017b6', '[\"*\"]', NULL, NULL, '2024-01-09 03:55:25', '2024-01-09 03:55:25'),
(249, 'App\\Models\\User', 4, 'auth_token', '1f82beb140491895cb6f220864ae39ee804f2154bcc20f93c5d057f34da9f40f', '[\"*\"]', NULL, NULL, '2024-01-09 04:03:38', '2024-01-09 04:03:38'),
(250, 'App\\Models\\User', 4, 'auth_token', 'cf0cd95ef012f46695a42d9a92cd4eb03a557f085aadf447b76dfd5df0e3bdb3', '[\"*\"]', NULL, NULL, '2024-01-09 04:05:52', '2024-01-09 04:05:52'),
(251, 'App\\Models\\User', 4, 'auth_token', '2f58236ff3895025c48c2915a378aa463ed3a36a0a9e75d1d23d43d86323d228', '[\"*\"]', NULL, NULL, '2024-01-09 04:07:30', '2024-01-09 04:07:30'),
(252, 'App\\Models\\User', 4, 'auth_token', '3baa86fde5363c1f521bdea2dd2b16770b5deee2446757ee778c8236470da534', '[\"*\"]', NULL, NULL, '2024-01-09 04:32:30', '2024-01-09 04:32:30'),
(253, 'App\\Models\\User', 4, 'auth_token', '898f4aa3b7e2d2b79624dfabd23793d55c038a1100090cf937bdc0312dd50c27', '[\"*\"]', NULL, NULL, '2024-01-09 04:32:40', '2024-01-09 04:32:40'),
(254, 'App\\Models\\User', 4, 'auth_token', 'df6dba26b16442d2a0bc7c7b47fc9da308f2025e2224f2b843ae0ec4a8a3bf9d', '[\"*\"]', NULL, NULL, '2024-01-09 04:33:21', '2024-01-09 04:33:21'),
(255, 'App\\Models\\User', 4, 'auth_token', 'fa75ac837c77403cf04c7af844258db01306d693eeb4a34b6b3b719bea88719b', '[\"*\"]', NULL, NULL, '2024-01-09 04:36:08', '2024-01-09 04:36:08'),
(256, 'App\\Models\\User', 4, 'auth_token', 'df293c7b708c085c33e278b643075244616a16e1d52f43347db89d30d7680eda', '[\"*\"]', NULL, NULL, '2024-01-09 04:36:50', '2024-01-09 04:36:50'),
(257, 'App\\Models\\User', 4, 'auth_token', 'ca278535c79b805ba4c98857ea33db54df11a55c6678f5cdbdba32c816a7f174', '[\"*\"]', NULL, NULL, '2024-01-09 04:38:24', '2024-01-09 04:38:24'),
(258, 'App\\Models\\User', 4, 'auth_token', '3a5bcfa8c93f7e6d2709b7926cd1e96d398e34b014dc73f7d3e5144abce72c88', '[\"*\"]', NULL, NULL, '2024-01-09 04:38:56', '2024-01-09 04:38:56'),
(259, 'App\\Models\\User', 5, 'auth_token', 'f5f46d00ceb87c8161b90062caaf78bdfc3b3de4ba50be0fe89c9a7f6cf64ee3', '[\"*\"]', NULL, NULL, '2024-01-09 05:03:16', '2024-01-09 05:03:16'),
(260, 'App\\Models\\User', 6, 'auth_token', 'd1e2e6efb15cc3b346a667f39ed112f0b4c8b634bbce186cfe479fbcb8deb43c', '[\"*\"]', NULL, NULL, '2024-01-09 05:06:58', '2024-01-09 05:06:58'),
(261, 'App\\Models\\User', 4, 'auth_token', '1344e752773b00b5f3645a78e0d7ff277c4c0c3083ad956497dce5c6f0987a58', '[\"*\"]', NULL, NULL, '2024-01-09 05:09:29', '2024-01-09 05:09:29'),
(262, 'App\\Models\\User', 4, 'auth_token', '8e5507c952f644f347c803d2ad477c2a3d2708644c0572b61a148dc789aee87c', '[\"*\"]', NULL, NULL, '2024-01-09 05:09:49', '2024-01-09 05:09:49'),
(263, 'App\\Models\\User', 4, 'auth_token', 'a832283887b6f0867ecd19cafc8e746db6afe2440e856c65f31d862b0ecc70c3', '[\"*\"]', NULL, NULL, '2024-01-09 05:47:22', '2024-01-09 05:47:22'),
(264, 'App\\Models\\User', 4, 'auth_token', '9a6d8b4860385f79b51c2de23ec3112bd3f8d37c376567e9007af1d731c8e7f8', '[\"*\"]', NULL, NULL, '2024-01-09 05:48:08', '2024-01-09 05:48:08'),
(265, 'App\\Models\\User', 4, 'auth_token', 'be8c33644e19dedc34635c7fc13f4a5fe3b3f1ab002e18696334dae31339c6f5', '[\"*\"]', NULL, NULL, '2024-01-09 05:48:26', '2024-01-09 05:48:26'),
(266, 'App\\Models\\User', 4, 'auth_token', '8d8926f6eef6c6ff4b30aac4a95295b72355180a040c06a8ef0945844830bbcc', '[\"*\"]', NULL, NULL, '2024-01-09 05:51:05', '2024-01-09 05:51:05'),
(267, 'App\\Models\\User', 4, 'auth_token', 'bbb1721f50432f44db62ddc9c861d0744c937c3545ab9f4020c90571e3f8a698', '[\"*\"]', NULL, NULL, '2024-01-09 05:51:45', '2024-01-09 05:51:45'),
(268, 'App\\Models\\User', 4, 'auth_token', 'fc074a2e526e4c4689d3015f30264a0b90955d54d841599b65e1b3925759cfb5', '[\"*\"]', NULL, NULL, '2024-01-09 06:29:17', '2024-01-09 06:29:17'),
(269, 'App\\Models\\User', 4, 'auth_token', '96796ee00199fec287189db13e691e26f1c5ebb1bcc8916b09e1d4f05f39ae83', '[\"*\"]', NULL, NULL, '2024-01-09 06:31:45', '2024-01-09 06:31:45'),
(270, 'App\\Models\\User', 4, 'auth_token', '52e63c837f5d0e26cd9848d56674b5aff35887fa0d6096642f60ae43d5b2ea1a', '[\"*\"]', NULL, NULL, '2024-01-09 06:32:15', '2024-01-09 06:32:15'),
(271, 'App\\Models\\User', 4, 'auth_token', '1ac1675387c43c54795bc249a44e79b75a46cd2d67da6fb1fb78d9f617d5927e', '[\"*\"]', NULL, NULL, '2024-01-09 06:34:44', '2024-01-09 06:34:44'),
(272, 'App\\Models\\User', 4, 'auth_token', '9a38939e6ca600eec9fc251e6258d5abff53a02710715a81845b33ee95280cff', '[\"*\"]', NULL, NULL, '2024-01-09 06:40:43', '2024-01-09 06:40:43'),
(273, 'App\\Models\\User', 4, 'auth_token', '717dbdc18079aa52247c590d4717451138acdb1cce229685c214dbf89fc4724f', '[\"*\"]', NULL, NULL, '2024-01-09 06:57:02', '2024-01-09 06:57:02'),
(274, 'App\\Models\\User', 4, 'auth_token', '5f0b37a1eb2381ca5f19341790c375c5b4c49cf095e11050e779042e3e8a23e6', '[\"*\"]', NULL, NULL, '2024-01-09 07:05:48', '2024-01-09 07:05:48'),
(275, 'App\\Models\\User', 4, 'auth_token', 'fb82d492f66d7d392dff7a38f301473564de9296bd21db6271a711d69f2d5916', '[\"*\"]', NULL, NULL, '2024-01-09 07:18:19', '2024-01-09 07:18:19'),
(276, 'App\\Models\\User', 4, 'auth_token', '6e163510f41ee7608081adc57e23fe4538ed9e3f19a095079fe41423debe8607', '[\"*\"]', NULL, NULL, '2024-01-09 07:26:12', '2024-01-09 07:26:12'),
(277, 'App\\Models\\User', 4, 'auth_token', '699b01b00d8d1351f63953e2705ab3faaccd8e42fc6a00b44fd64a62346bcfaa', '[\"*\"]', NULL, NULL, '2024-01-09 07:28:47', '2024-01-09 07:28:47');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(278, 'App\\Models\\User', 4, 'auth_token', '05bc1b116992348f4099a1a722a5d2af382246f5ad1fa4db9448796e68abc60a', '[\"*\"]', NULL, NULL, '2024-01-09 07:29:10', '2024-01-09 07:29:10'),
(279, 'App\\Models\\User', 4, 'auth_token', '8d14ba5aff17f32e439b419763034b67cf63b072156580a4f9d84e91dfe740ad', '[\"*\"]', NULL, NULL, '2024-01-09 07:30:40', '2024-01-09 07:30:40'),
(280, 'App\\Models\\User', 4, 'auth_token', '7817c987a245416fe40cb0573f324560228a76a1bf51ac9caf22d7d2761f6597', '[\"*\"]', NULL, NULL, '2024-01-09 07:34:28', '2024-01-09 07:34:28'),
(281, 'App\\Models\\User', 4, 'auth_token', 'd407b92050e3e6a99da7dd7a95e0f2e4fbf202159f19ef2595a9e6bf4c8ed3c5', '[\"*\"]', NULL, NULL, '2024-01-09 07:36:46', '2024-01-09 07:36:46'),
(282, 'App\\Models\\User', 4, 'auth_token', 'c268185d786aafcd742daa9b5bbea1c876ecaa1506f3be4fce5dd9ac6d5631da', '[\"*\"]', NULL, NULL, '2024-01-09 07:38:00', '2024-01-09 07:38:00'),
(283, 'App\\Models\\User', 4, 'auth_token', '4e6ffee2faff30aae9a2f21757e4cc469c18cebb37342e55c9c6375f2794bceb', '[\"*\"]', NULL, NULL, '2024-01-09 07:53:01', '2024-01-09 07:53:01'),
(284, 'App\\Models\\User', 4, 'auth_token', '4b40cfe74ef26abd6f1414df6b9f79f3552f80339b472829c173bedf8b723e32', '[\"*\"]', NULL, NULL, '2024-01-09 07:53:41', '2024-01-09 07:53:41'),
(285, 'App\\Models\\User', 4, 'auth_token', '8b83277e054b1e53ff10b9caedcdef8a6959f95ccca99f54bf75f9f1f19ebe7a', '[\"*\"]', NULL, NULL, '2024-01-09 22:43:42', '2024-01-09 22:43:42'),
(286, 'App\\Models\\User', 4, 'auth_token', '96adfc29e51dcffb0268536e4270b7a2f035440f068956c4024ba5f260c40d6e', '[\"*\"]', NULL, NULL, '2024-01-09 22:43:49', '2024-01-09 22:43:49'),
(287, 'App\\Models\\User', 4, 'auth_token', '0030fb9f5fea3210643fa32c50eebfbbc375b425cdb4b64719692a24145c9224', '[\"*\"]', NULL, NULL, '2024-01-09 23:20:29', '2024-01-09 23:20:29'),
(288, 'App\\Models\\User', 4, 'auth_token', '7754f03dcc9d49f7a3cc67cb24d13eaffe97d2a17c136efaab64f7a11d5b2cc4', '[\"*\"]', NULL, NULL, '2024-01-09 23:21:54', '2024-01-09 23:21:54'),
(289, 'App\\Models\\User', 4, 'auth_token', '0018c6a7d44f143e209b9c86cad3633d1de2cbf3a2164b7d776380f05f9df720', '[\"*\"]', NULL, NULL, '2024-01-09 23:22:19', '2024-01-09 23:22:19'),
(290, 'App\\Models\\User', 4, 'auth_token', '0563c637f255df39cbd495df94edafd3bd6884dfe26efd10c37bcc28d09859d2', '[\"*\"]', NULL, NULL, '2024-01-10 00:20:13', '2024-01-10 00:20:13'),
(291, 'App\\Models\\User', 4, 'auth_token', 'ef68651bbc8a0f47237c135d621d0d8f41217b3cbe5116de8675a36b523c1431', '[\"*\"]', NULL, NULL, '2024-01-10 00:22:29', '2024-01-10 00:22:29'),
(292, 'App\\Models\\User', 4, 'auth_token', 'b4613e9d62d4fe15186e4089522bb13dde2546d5b8eef1207ca100fc71795307', '[\"*\"]', NULL, NULL, '2024-01-10 00:23:16', '2024-01-10 00:23:16'),
(293, 'App\\Models\\User', 4, 'auth_token', 'b5fa60aa42300edcbdb0434579a3f05638a9cac349b16aa12183de52928606fa', '[\"*\"]', NULL, NULL, '2024-01-10 00:24:41', '2024-01-10 00:24:41'),
(294, 'App\\Models\\User', 4, 'auth_token', 'bd4b0b715a3962c748ae749f8059a720d9dccf6938ecef552abfdeaccff0e5ce', '[\"*\"]', NULL, NULL, '2024-01-10 00:38:18', '2024-01-10 00:38:18'),
(295, 'App\\Models\\User', 4, 'auth_token', '4df38396cf26db7541ee8413ef6f3f157209caf1e27cd366cb20b2ccb2c07c2b', '[\"*\"]', NULL, NULL, '2024-01-10 00:41:49', '2024-01-10 00:41:49'),
(296, 'App\\Models\\User', 4, 'auth_token', 'caa923165fd3c7d8c8d4e35237609fb243de228c3a65751bd2635de886e8acb0', '[\"*\"]', NULL, NULL, '2024-01-10 00:44:35', '2024-01-10 00:44:35'),
(297, 'App\\Models\\User', 4, 'auth_token', '01af5a49900efc23cbffd53049f7cb60dc3d4fa5520efa3a9ef0edd4d012cb64', '[\"*\"]', NULL, NULL, '2024-01-10 00:56:10', '2024-01-10 00:56:10'),
(298, 'App\\Models\\User', 4, 'auth_token', '5232067e0e93be979bf622166b2f52ee2d020a76cc9442125d71d3d7b927ae6c', '[\"*\"]', NULL, NULL, '2024-01-10 01:18:51', '2024-01-10 01:18:51'),
(299, 'App\\Models\\User', 4, 'auth_token', 'ebba32706ac0d3e46de8dbc57617fc0ad15b30200b5c4ce7ea1809fe00e016fa', '[\"*\"]', NULL, NULL, '2024-01-10 02:14:18', '2024-01-10 02:14:18'),
(300, 'App\\Models\\User', 4, 'auth_token', '3985da494f033d6917a1726a363b87c586aed55331ec4fd3b4ce704d0b79780c', '[\"*\"]', NULL, NULL, '2024-01-10 02:15:50', '2024-01-10 02:15:50'),
(301, 'App\\Models\\User', 4, 'auth_token', '9b918027d3cf3a356bda4208488c75ae3a62cb491f44ea1574cd967c5459442f', '[\"*\"]', NULL, NULL, '2024-01-10 02:16:51', '2024-01-10 02:16:51'),
(302, 'App\\Models\\User', 4, 'auth_token', 'c78f6279c292d1f0db1af9fcb6da6b2261b5c18e0443b83b497b4059c6ff0bba', '[\"*\"]', NULL, NULL, '2024-01-10 02:44:01', '2024-01-10 02:44:01'),
(303, 'App\\Models\\User', 4, 'auth_token', '6db56ac6fdea70de432ec7a763e65e9fdbae102b27d039353a2621e599b3410c', '[\"*\"]', NULL, NULL, '2024-01-10 02:47:21', '2024-01-10 02:47:21'),
(304, 'App\\Models\\User', 7, 'auth_token', 'ed32fec39892ea5d0f6bff5a92da6512afac918650f3b9030f734efc78207342', '[\"*\"]', NULL, NULL, '2024-01-10 02:51:11', '2024-01-10 02:51:11'),
(305, 'App\\Models\\User', 4, 'auth_token', 'eb407d6d480cb1fcf67fa777dcbfc04070fb2ded2ef102a255b47d5015b48404', '[\"*\"]', NULL, NULL, '2024-01-10 02:51:18', '2024-01-10 02:51:18'),
(306, 'App\\Models\\User', 4, 'auth_token', '385f50e85a682ce882a6697c0ac0f89e1e4663589c502a2e9e8cec2587d16f6b', '[\"*\"]', NULL, NULL, '2024-01-10 03:18:06', '2024-01-10 03:18:06'),
(307, 'App\\Models\\User', 4, 'auth_token', '184c3248d967af102cdbfb24a0c654b614e26c2e4dd73c43379217721112aa54', '[\"*\"]', NULL, NULL, '2024-01-10 03:19:11', '2024-01-10 03:19:11'),
(308, 'App\\Models\\User', 4, 'auth_token', '382e21fe207827bfd9872467618886c14d3f3abf40fa49e7381d32bf719f9a87', '[\"*\"]', NULL, NULL, '2024-01-10 03:25:44', '2024-01-10 03:25:44'),
(309, 'App\\Models\\User', 4, 'auth_token', '56c92550b78d174fcdbb7038452ba9dfd2928b0382a6eaa552127c47a986c95d', '[\"*\"]', NULL, NULL, '2024-01-10 03:26:12', '2024-01-10 03:26:12'),
(310, 'App\\Models\\User', 4, 'auth_token', 'ec18da85458289d63267c32b723b2a96d1d6b3fcd79c155bfa18ae1eb9d90925', '[\"*\"]', NULL, NULL, '2024-01-10 03:26:55', '2024-01-10 03:26:55'),
(311, 'App\\Models\\User', 4, 'auth_token', 'b613f8ae1a0d137d41db794982c0e3a6e7636e9d52f7088872919435eee9868d', '[\"*\"]', NULL, NULL, '2024-01-10 03:27:49', '2024-01-10 03:27:49'),
(312, 'App\\Models\\User', 4, 'auth_token', '2034bb15313a5784b9ae666f5127795ad43cd02ee54ca0053aaa22bdc1576e96', '[\"*\"]', NULL, NULL, '2024-01-10 03:29:02', '2024-01-10 03:29:02'),
(313, 'App\\Models\\User', 4, 'auth_token', '1051c4195277936d6124f0bb7e4c46bf9649848f2d32426b33d37f309358b0c0', '[\"*\"]', NULL, NULL, '2024-01-10 03:31:26', '2024-01-10 03:31:26'),
(314, 'App\\Models\\User', 4, 'auth_token', '07fb865bbfeab0310542f6f61663fd55cf257e5e9bcfaf9184c3abca20cadcd4', '[\"*\"]', NULL, NULL, '2024-01-10 03:37:23', '2024-01-10 03:37:23'),
(315, 'App\\Models\\User', 4, 'auth_token', 'cad1d547937a3569f051637651f896768690b5e725d95652bff9fed86cf2cff4', '[\"*\"]', NULL, NULL, '2024-01-10 04:05:36', '2024-01-10 04:05:36'),
(316, 'App\\Models\\User', 4, 'auth_token', '0ee54fc73c87ec42c6a0ce77d8dbf46e26a7e798ef310843c4226897ea73700a', '[\"*\"]', NULL, NULL, '2024-01-10 04:12:04', '2024-01-10 04:12:04'),
(317, 'App\\Models\\User', 4, 'auth_token', '783d6d153492b7cb416f33ed3bed7247b32a781ba8c2ebc07e13e45a6cbe693b', '[\"*\"]', NULL, NULL, '2024-01-10 04:45:25', '2024-01-10 04:45:25'),
(318, 'App\\Models\\User', 4, 'auth_token', 'c464580bb6cce22dcbabd28c6c6ee29aea5220fe79e256e77cb207f8e2690ca8', '[\"*\"]', NULL, NULL, '2024-01-10 05:23:21', '2024-01-10 05:23:21'),
(319, 'App\\Models\\User', 4, 'auth_token', '42b1a69a1442c1b10fc68284f15644d5f739aeea977c81ec2c484dcf8851e121', '[\"*\"]', NULL, NULL, '2024-01-10 05:34:29', '2024-01-10 05:34:29'),
(320, 'App\\Models\\User', 4, 'auth_token', '8379c002815d2884f7e35f146972e237f0cb7a6918ebeea5dcaa3a02f0c81f40', '[\"*\"]', NULL, NULL, '2024-01-10 06:17:44', '2024-01-10 06:17:44'),
(321, 'App\\Models\\User', 4, 'auth_token', 'c1d989cf29e8332f3470160edf2c4f36558e72a8f3b531b7ef2abfb3670aaa56', '[\"*\"]', NULL, NULL, '2024-01-10 06:49:00', '2024-01-10 06:49:00'),
(322, 'App\\Models\\User', 4, 'auth_token', 'ef2b8f72670e016fa0a40ad6f878fb9b92f1eccbde7fb3e7dacb1324e6648107', '[\"*\"]', NULL, NULL, '2024-01-10 07:38:49', '2024-01-10 07:38:49'),
(323, 'App\\Models\\User', 4, 'auth_token', '4ec11325353fe5b245559ca7f1855039a6fb2a80720de32233be0dbbbf954294', '[\"*\"]', NULL, NULL, '2024-01-10 07:38:57', '2024-01-10 07:38:57'),
(324, 'App\\Models\\User', 4, 'auth_token', 'cbe83000ac3d56ea926f4f76b235c7bc9fa4a428a18b1eed72a18ed764f98db4', '[\"*\"]', NULL, NULL, '2024-01-10 08:28:58', '2024-01-10 08:28:58'),
(325, 'App\\Models\\User', 4, 'auth_token', '217b5bf8046324e5e1407b309ad7647545924582f4916c52cb4074864d644add', '[\"*\"]', NULL, NULL, '2024-01-10 22:37:48', '2024-01-10 22:37:48'),
(326, 'App\\Models\\User', 1, 'auth_token', '62d52dcc8e44871a18ad51432f3f45d126314e30ea36987c0b00a196de9e9b60', '[\"*\"]', NULL, NULL, '2024-01-11 04:24:43', '2024-01-11 04:24:43'),
(327, 'App\\Models\\User', 1, 'auth_token', 'd92da4cd46ee1a938a5855e669c435d894a58339a9a65a0eec6be3356963b50b', '[\"*\"]', NULL, NULL, '2024-01-11 04:37:42', '2024-01-11 04:37:42'),
(328, 'App\\Models\\User', 1, 'auth_token', 'cf4e72f1fbee017c5ed64e9d7be2577d9a7f0cbe3237f492d41b6539a131f331', '[\"*\"]', NULL, NULL, '2024-01-11 04:38:06', '2024-01-11 04:38:06'),
(329, 'App\\Models\\User', 1, 'auth_token', '8c1e0584073d0b245e738a1457967614408450084a8b02337cf4a15f24b34d8d', '[\"*\"]', NULL, NULL, '2024-01-12 00:51:51', '2024-01-12 00:51:51'),
(330, 'App\\Models\\User', 1, 'auth_token', '2870ffd42b3fc5ca424cf73eea890e52208ed4678fed1c56facd076a396d629b', '[\"*\"]', NULL, NULL, '2024-01-16 08:05:06', '2024-01-16 08:05:06'),
(331, 'App\\Models\\User', 1, 'auth_token', '2362dbd170618b0398f6ab45f88b79cba106cde4612d055f37c44c25db688226', '[\"*\"]', NULL, NULL, '2024-01-16 08:07:30', '2024-01-16 08:07:30'),
(332, 'App\\Models\\User', 1, 'auth_token', '9a27c4adca45f4e988f828990e5e7c6808b283448a7b6052b43da25df8dca87b', '[\"*\"]', NULL, NULL, '2024-01-16 08:13:41', '2024-01-16 08:13:41'),
(333, 'App\\Models\\User', 1, 'auth_token', 'cf3ac70cb7875207370147febf6e52305bf68513d97b037231d58e8de5ce4bc1', '[\"*\"]', NULL, NULL, '2024-01-16 08:14:27', '2024-01-16 08:14:27'),
(334, 'App\\Models\\User', 1, 'auth_token', '5ec91d440ba45a9b0245c6c4bb10f0fde21a70bff567b9dcc4fdc460680563dd', '[\"*\"]', NULL, NULL, '2024-01-16 22:52:14', '2024-01-16 22:52:14'),
(335, 'App\\Models\\User', 2, 'auth_token', '1aee2a673035b67ac6a6bee59db37f4515ca82a61cc47880cee509658d930c77', '[\"*\"]', NULL, NULL, '2024-01-17 00:43:23', '2024-01-17 00:43:23'),
(336, 'App\\Models\\User', 1, 'auth_token', '66cbe1fac6efd9b2edf9ffbec7d44f3949aa077e46a688307f49ec6629e7322a', '[\"*\"]', NULL, NULL, '2024-01-17 01:03:47', '2024-01-17 01:03:47'),
(337, 'App\\Models\\User', 1, 'auth_token', 'caed9d4b16646993d938ecc9a16e534f7fb7bc47c30358428c318085b7afc9ca', '[\"*\"]', NULL, NULL, '2024-01-17 01:06:22', '2024-01-17 01:06:22'),
(338, 'App\\Models\\User', 1, 'auth_token', 'da9dbe6192bdf3ef603dc8c1a6c4ca9080c08b0a8240454a2c1f6f4ca785c50d', '[\"*\"]', NULL, NULL, '2024-01-17 01:17:46', '2024-01-17 01:17:46'),
(339, 'App\\Models\\User', 1, 'auth_token', '910e27142b9b12e921ff0929bc6d3e9651ffb21c68b901b60c51da71a847fb4b', '[\"*\"]', NULL, NULL, '2024-01-17 01:19:44', '2024-01-17 01:19:44'),
(340, 'App\\Models\\User', 1, 'auth_token', '68d2a5d18096032f0f65bd77de652e6ac8805e0a5fa9d44aeae2fb9f6dd7ccf0', '[\"*\"]', NULL, NULL, '2024-01-17 02:05:15', '2024-01-17 02:05:15'),
(341, 'App\\Models\\User', 1, 'auth_token', '974853ec810392a6d779c38767e3ad07117152ea6729402ec8a15f766187a5a7', '[\"*\"]', NULL, NULL, '2024-01-17 02:59:31', '2024-01-17 02:59:31'),
(342, 'App\\Models\\User', 1, 'auth_token', 'a1ac4c2b0ca0e7348bca97c7195e8f4fc862d6d8e6fe1688707f5de0acb656b0', '[\"*\"]', NULL, NULL, '2024-01-18 23:32:05', '2024-01-18 23:32:05'),
(343, 'App\\Models\\User', 1, 'auth_token', 'b0e2b73cbdb7993b5636349e534f013564c9335aa86a884b51c10348832860c4', '[\"*\"]', NULL, NULL, '2024-01-21 23:16:04', '2024-01-21 23:16:04'),
(344, 'App\\Models\\User', 3, 'auth_token', 'cae933a8bd955cc34a97622bfd5acfdea9916f4ec0b5bc022215186abe487084', '[\"*\"]', NULL, NULL, '2024-01-22 03:23:58', '2024-01-22 03:23:58'),
(345, 'App\\Models\\User', 1, 'auth_token', '921d5f89c03e0fb4cd8b2aeef184694d7778766ebb67c21dba4430193a53128f', '[\"*\"]', NULL, NULL, '2024-01-22 03:24:16', '2024-01-22 03:24:16'),
(346, 'App\\Models\\User', 1, 'auth_token', 'd572189d15d87879cb999cad43db3387f8084fc5ed3771bd7602bf0089df99ea', '[\"*\"]', NULL, NULL, '2024-01-22 22:28:01', '2024-01-22 22:28:01'),
(347, 'App\\Models\\User', 1, 'auth_token', '01e47c0e55d5da16fa8b02ea7bde44a6d164fb35edc520883f5bcafe7cbe598e', '[\"*\"]', NULL, NULL, '2024-01-23 02:48:47', '2024-01-23 02:48:47'),
(348, 'App\\Models\\User', 1, 'auth_token', '2ab2faa4ded7ac37bf1f55d2128af45bc794083902443f5ad8fc84e02080d1ae', '[\"*\"]', NULL, NULL, '2024-01-23 22:30:24', '2024-01-23 22:30:24'),
(349, 'App\\Models\\User', 1, 'auth_token', 'e38ccd615d849e9bef6ae5cff583b9397f8a191d20a52c47f3dd2d42c29215e6', '[\"*\"]', NULL, NULL, '2024-01-25 02:05:17', '2024-01-25 02:05:17'),
(350, 'App\\Models\\User', 1, 'auth_token', 'f47b44c4bed5045641bdb38f50b5412eb970e329326621ca42f4eb22cb5fb802', '[\"*\"]', NULL, NULL, '2024-01-25 07:44:33', '2024-01-25 07:44:33'),
(351, 'App\\Models\\User', 1, 'auth_token', 'f0480de361109c22ce5ee45be6655a69738b958ee917f58b9aee1f1ab6f5fb0a', '[\"*\"]', NULL, NULL, '2024-01-25 07:51:41', '2024-01-25 07:51:41'),
(352, 'App\\Models\\User', 1, 'auth_token', 'e6db6e79eacb0e889e29f5228276ae9bacc2150f2c6d99feec208fbf783bf612', '[\"*\"]', NULL, NULL, '2024-01-28 23:01:23', '2024-01-28 23:01:23'),
(353, 'App\\Models\\User', 1, 'auth_token', 'c3adfe86aae77c2f203592fcb7b824ca085f3f7d28bf81d8dfdb236286a49c53', '[\"*\"]', NULL, NULL, '2024-01-28 23:36:00', '2024-01-28 23:36:00'),
(354, 'App\\Models\\User', 13, 'auth_token', '5043d300d5ef96d9f6c6e94cb14c7264d61bb83591327f12aa8595d058eb3cce', '[\"*\"]', NULL, NULL, '2024-01-28 23:37:46', '2024-01-28 23:37:46'),
(355, 'App\\Models\\User', 1, 'auth_token', 'd37219309e1fc0efc7c116bd7b041a1b2d0d2ae9e233e3b1bfe9dfdf47aa1959', '[\"*\"]', NULL, NULL, '2024-01-28 23:42:30', '2024-01-28 23:42:30'),
(356, 'App\\Models\\User', 5, 'auth_token', '2138bc0e96a8b5906d0208d5cb40bcb1db50eaca362f6c7fd300c76abe3837b3', '[\"*\"]', NULL, NULL, '2024-01-29 00:25:47', '2024-01-29 00:25:47'),
(357, 'App\\Models\\User', 1, 'auth_token', '0a84e47dd2e54bb21006928a79144d47b8a76133754282f781970daf6ccd85dd', '[\"*\"]', NULL, NULL, '2024-01-29 00:30:01', '2024-01-29 00:30:01'),
(358, 'App\\Models\\User', 1, 'auth_token', 'baf5e6cb9cc2d9f41994ecc662b08ff140ceba07bd35cdb1e36ff8a258f63434', '[\"*\"]', NULL, NULL, '2024-01-29 00:31:56', '2024-01-29 00:31:56'),
(359, 'App\\Models\\User', 1, 'auth_token', 'b9266a14f6a9ebfd624e15d4ea1d8e33771fa378e43221bcb01970959da1bd73', '[\"*\"]', NULL, NULL, '2024-01-29 00:34:24', '2024-01-29 00:34:24'),
(360, 'App\\Models\\User', 1, 'auth_token', 'b36931fb588de26930bc2ce5fec2ed65c8a67bbe8f65ce822acef0dac9291897', '[\"*\"]', NULL, NULL, '2024-01-29 00:39:36', '2024-01-29 00:39:36'),
(361, 'App\\Models\\User', 1, 'auth_token', '9c34bf7b6475654b4f0aebe8b7ed7c41a148eb2564c8455ef6eda172e870dc58', '[\"*\"]', NULL, NULL, '2024-01-29 00:54:53', '2024-01-29 00:54:53'),
(362, 'App\\Models\\User', 1, 'auth_token', '109ccf0a11f8a530e126d26cda9cc18ab9e4a14cb5c863acf85a8c8c855b47c1', '[\"*\"]', NULL, NULL, '2024-01-29 03:53:45', '2024-01-29 03:53:45'),
(363, 'App\\Models\\User', 1, 'auth_token', 'b5833440451c7bdb02bae414719633c27a0bd9d55f485909697fc58137068515', '[\"*\"]', NULL, NULL, '2024-01-29 03:54:21', '2024-01-29 03:54:21'),
(364, 'App\\Models\\User', 1, 'auth_token', '3895f138c1c5036a4ab6fb79b4c850436fcea2c1253b74d903ccb22b26607f94', '[\"*\"]', NULL, NULL, '2024-01-29 04:09:15', '2024-01-29 04:09:15'),
(365, 'App\\Models\\User', 1, 'auth_token', 'c5a2ad0bd18b0b62f773f7d218df3ce4c646d4cfec5324367439faf1a022de18', '[\"*\"]', NULL, NULL, '2024-01-29 04:12:15', '2024-01-29 04:12:15'),
(366, 'App\\Models\\User', 1, 'auth_token', '61fa6630a0155310019bf6b0c15499c5541b182d6b2322675a13f58017e7e0b8', '[\"*\"]', NULL, NULL, '2024-01-29 04:23:37', '2024-01-29 04:23:37'),
(367, 'App\\Models\\User', 1, 'auth_token', '97d9feb44e6ba54b98c53a799c3464f983ee8b1c3a238f35ffb45f7d2e8a0970', '[\"*\"]', NULL, NULL, '2024-01-29 22:35:54', '2024-01-29 22:35:54'),
(368, 'App\\Models\\User', 1, 'auth_token', '553fb7d6de8edf3be04ea5194605ae92da42a1ebcd9c7a3a876711f9c98d6950', '[\"*\"]', NULL, NULL, '2024-01-29 23:00:57', '2024-01-29 23:00:57'),
(369, 'App\\Models\\User', 1, 'auth_token', '70fcc1216d2992ca0b34787b8dc877a23f66d20a796848095d023946a7ccbc57', '[\"*\"]', NULL, NULL, '2024-01-31 02:34:01', '2024-01-31 02:34:01'),
(370, 'App\\Models\\User', 1, 'auth_token', '695070dc565aef1a8e312e2e0580eb1081933f7e0e079cbfef5d30f972603390', '[\"*\"]', NULL, NULL, '2024-02-01 02:30:27', '2024-02-01 02:30:27'),
(371, 'App\\Models\\User', 1, 'auth_token', 'fdfc86c9e1452dfb48f5e76c392383b4440050572694f6f15c2c158043637f0e', '[\"*\"]', NULL, NULL, '2024-02-01 02:52:47', '2024-02-01 02:52:47'),
(372, 'App\\Models\\User', 1, 'auth_token', '7f96c27f76a710086ab08c071c785f08d97d08ad88a89a0b9af8b3d753a6966f', '[\"*\"]', NULL, NULL, '2024-02-02 02:08:47', '2024-02-02 02:08:47'),
(373, 'App\\Models\\User', 1, 'auth_token', '47df1e6c07e6459c47b3db0d792b142da6a94e79c24f170116277b95735c88ee', '[\"*\"]', NULL, NULL, '2024-02-02 03:49:43', '2024-02-02 03:49:43'),
(374, 'App\\Models\\User', 1, 'auth_token', '56a77fcdeb7c1ec3049ccc8725e579a8787b62dc9f9281a648b9c8ba44cb6e9a', '[\"*\"]', NULL, NULL, '2024-02-02 03:51:31', '2024-02-02 03:51:31'),
(375, 'App\\Models\\User', 1, 'auth_token', '4051897822cbe1b517e1e9a4046cd76b2f036a2c0de53534b0e5299a0e6ad980', '[\"*\"]', NULL, NULL, '2024-02-02 04:45:18', '2024-02-02 04:45:18'),
(376, 'App\\Models\\User', 1, 'auth_token', '129023b3ce188f19a280586abdb57faa905ca0676e0b089ec08c27df92692f2d', '[\"*\"]', NULL, NULL, '2024-02-02 06:52:41', '2024-02-02 06:52:41'),
(377, 'App\\Models\\User', 1, 'auth_token', '78691fe270f790069e451081eb6246ba19d87c9366653fd96116ee312a6766b8', '[\"*\"]', NULL, NULL, '2024-02-02 06:54:54', '2024-02-02 06:54:54'),
(378, 'App\\Models\\User', 1, 'auth_token', 'dc1bbb91385b75ffe6080e1031eb26521907c1f2675e735c5f9b91723ddddc80', '[\"*\"]', NULL, NULL, '2024-02-02 07:52:59', '2024-02-02 07:52:59'),
(379, 'App\\Models\\User', 1, 'auth_token', '0482447e62ea4b5761d5da26c126f14278955eb59e27180dfda1b5f892b2ab67', '[\"*\"]', NULL, NULL, '2024-02-04 22:49:19', '2024-02-04 22:49:19'),
(380, 'App\\Models\\User', 1, 'auth_token', 'b21e51fb133bbff9e3ca0c4fc3e7041230db89bb5589e7347633c32df4f73d55', '[\"*\"]', NULL, NULL, '2024-02-05 00:16:31', '2024-02-05 00:16:31'),
(381, 'App\\Models\\User', 1, 'auth_token', '45a0d9776be857a2ebca821b53775d43be5cdc6d6fefbd4eb4b640db2f4d6e26', '[\"*\"]', NULL, NULL, '2024-02-05 00:26:45', '2024-02-05 00:26:45'),
(382, 'App\\Models\\User', 1, 'auth_token', '849ba7044e003ad4ad7c885c1f31c97af8667ab982fe566ad1e4164236ed5860', '[\"*\"]', NULL, NULL, '2024-02-05 00:50:32', '2024-02-05 00:50:32'),
(383, 'App\\Models\\User', 1, 'auth_token', 'f7b1dcab67926de3d20e7b2db76b7df5400bead7a30785630c8342f2ae919b67', '[\"*\"]', NULL, NULL, '2024-02-05 02:14:56', '2024-02-05 02:14:56'),
(384, 'App\\Models\\User', 1, 'auth_token', 'ff2e152b0893b139e3383d9cb8463ea687ed470124832e580a167ba42c5cb962', '[\"*\"]', NULL, NULL, '2024-02-05 03:19:06', '2024-02-05 03:19:06'),
(385, 'App\\Models\\User', 1, 'auth_token', '97f9b9b4f2e1ba32b8cca2ef12c6a65bc63acc06f2dde5eed395ab208ae77cb1', '[\"*\"]', NULL, NULL, '2024-02-05 05:19:00', '2024-02-05 05:19:00'),
(386, 'App\\Models\\User', 1, 'auth_token', 'e7fbccaa80a0ecaff80ad8630be99f761899083c820572e0c5332d84034a15fb', '[\"*\"]', NULL, NULL, '2024-02-05 22:46:22', '2024-02-05 22:46:22'),
(387, 'App\\Models\\User', 1, 'auth_token', '3aeda2306c48784c9c36b4b68783e591f02f68a751928874943df6d9a6a9f7d6', '[\"*\"]', NULL, NULL, '2024-02-06 00:24:13', '2024-02-06 00:24:13'),
(388, 'App\\Models\\User', 1, 'auth_token', '86bf8c2572a1fe846e7389e8759cae860ab95217853365000bb72cfbafa9ed5a', '[\"*\"]', NULL, NULL, '2024-02-06 00:36:09', '2024-02-06 00:36:09'),
(389, 'App\\Models\\User', 1, 'auth_token', 'de8c14f0d5209613f30887e3babd43e8054e25ceebe2eb3b4acfa49229ab2e8d', '[\"*\"]', NULL, NULL, '2024-02-06 01:00:42', '2024-02-06 01:00:42'),
(390, 'App\\Models\\User', 1, 'auth_token', '5498f60d2e4e2303c1b3a6070e16f13cc405bf1f6ccf0f5f4fd7f2811f892d7c', '[\"*\"]', NULL, NULL, '2024-02-06 01:06:45', '2024-02-06 01:06:45'),
(391, 'App\\Models\\User', 1, 'auth_token', 'e5a7fb2ae8e6639677e470356f8b343d45f33dd5e4d0fa953338b89628f808f6', '[\"*\"]', NULL, NULL, '2024-02-06 01:07:47', '2024-02-06 01:07:47'),
(392, 'App\\Models\\User', 1, 'auth_token', 'a16d75ef8d326fcac20b3239e21ce385386290a3e4376252f8a566156a6ad825', '[\"*\"]', NULL, NULL, '2024-02-06 03:45:18', '2024-02-06 03:45:18'),
(393, 'App\\Models\\User', 1, 'auth_token', '4323fb0dd6d1e45e8b558f747ebc10f7dfa4f251924c3237da5d0b890cbe8160', '[\"*\"]', NULL, NULL, '2024-02-06 06:52:06', '2024-02-06 06:52:06'),
(394, 'App\\Models\\User', 1, 'auth_token', '284a9dddda746150d9ec3d73ff88f9bf94b326b215bd369c3cb5b0c573c2eb0c', '[\"*\"]', NULL, NULL, '2024-02-06 07:15:00', '2024-02-06 07:15:00'),
(395, 'App\\Models\\User', 1, 'auth_token', '1d07a61479191a5ee63d8c631b2a45318c5026b84b9382aead05f97ecdb30752', '[\"*\"]', NULL, NULL, '2024-02-07 00:08:08', '2024-02-07 00:08:08'),
(396, 'App\\Models\\User', 1, 'auth_token', 'b4d30ccb0bb76050e5cb79170de2e650b594ac1d4cfba558a5ef5a0bf96f4b12', '[\"*\"]', NULL, NULL, '2024-02-07 00:09:52', '2024-02-07 00:09:52'),
(397, 'App\\Models\\User', 1, 'auth_token', '3eed4d246b2d736b3c5c0ccd4ccff3608ebd010bdd9bd1c718ea828ff6f5cf45', '[\"*\"]', NULL, NULL, '2024-02-07 04:48:19', '2024-02-07 04:48:19'),
(398, 'App\\Models\\User', 1, 'auth_token', '5c7df1a0efd3dbe2f774ba79ced067c211df5cd8cc4f47f7e24c77f07da13b07', '[\"*\"]', NULL, NULL, '2024-02-07 06:46:36', '2024-02-07 06:46:36'),
(399, 'App\\Models\\User', 1, 'auth_token', '0e495a5034f663ee9f4a4d9d0af35f0be36e1fd7520c5ebe01296b7d217b18c4', '[\"*\"]', NULL, NULL, '2024-02-07 06:47:51', '2024-02-07 06:47:51'),
(400, 'App\\Models\\User', 1, 'auth_token', '3c2548e923ea7e4b89831822ac91ec9c07dfd4b9869c0876d8eeb25340a06955', '[\"*\"]', NULL, NULL, '2024-02-07 06:53:46', '2024-02-07 06:53:46'),
(401, 'App\\Models\\User', 1, 'auth_token', '3bc95de7205bea57f4784bec6270ef0f41627f9a04b30c8bc932e890a6fc2500', '[\"*\"]', NULL, NULL, '2024-02-07 06:54:15', '2024-02-07 06:54:15'),
(402, 'App\\Models\\User', 1, 'auth_token', 'e82b1cd788545fb8c1a4729d525eed35fd08a9261db7aa464a7fdecb03f6e45b', '[\"*\"]', NULL, NULL, '2024-02-07 07:14:40', '2024-02-07 07:14:40'),
(403, 'App\\Models\\User', 1, 'auth_token', '7f14c66548addba09751188f2820a6bbd8064117202d149c46b6dca083962044', '[\"*\"]', NULL, NULL, '2024-02-07 22:41:29', '2024-02-07 22:41:29'),
(404, 'App\\Models\\User', 1, 'auth_token', '2276a159ccfe9561e4fc89af614b0855115de6e6377880fcae3b7a27689a6991', '[\"*\"]', NULL, NULL, '2024-02-08 04:21:13', '2024-02-08 04:21:13'),
(405, 'App\\Models\\User', 1, 'auth_token', '1374179dc2aa0f97a91212a34af2da7b7c0733935e5a073aef8218aed114c002', '[\"*\"]', NULL, NULL, '2024-02-08 07:11:38', '2024-02-08 07:11:38'),
(406, 'App\\Models\\User', 1, 'auth_token', '31d0e8c517ece8537df78f4955cd9f03495b028789c20fc23fd811cf7a4c73f7', '[\"*\"]', NULL, NULL, '2024-02-09 02:17:52', '2024-02-09 02:17:52'),
(407, 'App\\Models\\User', 1, 'auth_token', '3f3921029d53fd0495442bfffd11a0d092d6f173d8a4e846d92d8b393566e9fa', '[\"*\"]', NULL, NULL, '2024-02-09 03:02:44', '2024-02-09 03:02:44'),
(408, 'App\\Models\\User', 1, 'auth_token', 'f1907af1fec37158df3dca943797fcb13d1cd5885bee36e953d1c00c3ab43590', '[\"*\"]', NULL, NULL, '2024-02-09 03:02:58', '2024-02-09 03:02:58'),
(409, 'App\\Models\\User', 1, 'auth_token', '8ecdeefe481ee333fe1d63a2a6b95a823ee1f12d90e112dd47cd8d97948696cb', '[\"*\"]', NULL, NULL, '2024-02-09 03:03:45', '2024-02-09 03:03:45'),
(410, 'App\\Models\\User', 1, 'auth_token', 'e6ce2f715c53c2dd9a6776e2ad3d8bb6b62219a47bb9e3890921d592f2b9e397', '[\"*\"]', NULL, NULL, '2024-02-09 03:04:02', '2024-02-09 03:04:02'),
(411, 'App\\Models\\User', 1, 'auth_token', '72d98c6ad98e91415c098a043285c47446f5813fb45f19e2d47b52b0ccc6b7bc', '[\"*\"]', NULL, NULL, '2024-02-09 03:04:59', '2024-02-09 03:04:59'),
(412, 'App\\Models\\User', 1, 'auth_token', 'b1d781e61485bf73f546b578593ed03ae2f2551c0fe9cca0094a58bccdd4dfc0', '[\"*\"]', NULL, NULL, '2024-02-09 03:06:01', '2024-02-09 03:06:01'),
(413, 'App\\Models\\User', 1, 'auth_token', 'e1bff86ace404ebfc5a06468fb9e9ea3098269c9c7ba6cac08af8d8a59f21eea', '[\"*\"]', NULL, NULL, '2024-02-09 03:06:46', '2024-02-09 03:06:46'),
(414, 'App\\Models\\User', 1, 'auth_token', 'e8e7f3ca3d1894e15ac01fad9db4161841601b2e1aca7513fb48c6314c33604f', '[\"*\"]', NULL, NULL, '2024-02-09 03:14:01', '2024-02-09 03:14:01'),
(415, 'App\\Models\\User', 1, 'auth_token', '8d2a5a35f4883cdb1a05313052485cc98a50eebd8837f0843fb5745cd8ddb658', '[\"*\"]', NULL, NULL, '2024-02-09 04:06:24', '2024-02-09 04:06:24'),
(416, 'App\\Models\\User', 7, 'auth_token', 'c06bf9986108feb326640d803670a47de0f9d006e39195d36a459c5ea693cdaf', '[\"*\"]', NULL, NULL, '2024-02-09 04:12:21', '2024-02-09 04:12:21'),
(417, 'App\\Models\\User', 7, 'auth_token', 'a04f014fdda2ace84df0da82a74162e0386e2d9f77ba186595c9036dc4ce99ef', '[\"*\"]', NULL, NULL, '2024-02-09 04:43:32', '2024-02-09 04:43:32'),
(418, 'App\\Models\\User', 1, 'auth_token', 'adb52049e5f1b3c47158dd5d7568d227f78c4ca1f2b2862b7251e86df26ec4bd', '[\"*\"]', NULL, NULL, '2024-02-09 04:45:27', '2024-02-09 04:45:27'),
(419, 'App\\Models\\User', 7, 'auth_token', '4ae7b60d78760fea36e0a314fbaca8ec683f5fc003f7e3c71c66dbf9bd2e2f72', '[\"*\"]', NULL, NULL, '2024-02-09 04:49:12', '2024-02-09 04:49:12'),
(420, 'App\\Models\\User', 7, 'auth_token', 'eca730781031a485c223e8e4581177b62fa09b260f2477bc45f0906b1aea3d77', '[\"*\"]', NULL, NULL, '2024-02-09 07:17:05', '2024-02-09 07:17:05'),
(421, 'App\\Models\\User', 1, 'auth_token', '56ccc4048bc4e2808511334eb5e25d8be13fdffbd5aa3be8369838f1c63fe472', '[\"*\"]', NULL, NULL, '2024-02-11 23:31:00', '2024-02-11 23:31:00'),
(422, 'App\\Models\\User', 7, 'auth_token', 'f9bbcedf11112ce19f3a8824c0b49c04f4cb659ecc80813a7d4839f11124f1b0', '[\"*\"]', NULL, NULL, '2024-02-11 23:31:19', '2024-02-11 23:31:19'),
(423, 'App\\Models\\User', 7, 'auth_token', '65bfff936e17bb8f24ce5748f73b880c158407f79c4155afe577df1b47c690f3', '[\"*\"]', NULL, NULL, '2024-02-11 23:33:11', '2024-02-11 23:33:11'),
(424, 'App\\Models\\User', 1, 'auth_token', '8a474c73b58e15ad76a0e007752034e7d1cec29c001464e62eca9bdeabaad0e6', '[\"*\"]', NULL, NULL, '2024-02-11 23:39:22', '2024-02-11 23:39:22'),
(425, 'App\\Models\\User', 7, 'auth_token', 'ebe67e65f80b29a56d5a7259f078ad7fa9cff6510ae4cca724b8a6d64842cb2c', '[\"*\"]', NULL, NULL, '2024-02-11 23:46:34', '2024-02-11 23:46:34'),
(426, 'App\\Models\\User', 8, 'auth_token', '67ea0bba50797c8a669d620bae257dd75911a4262969e01ada97f9482d0d7739', '[\"*\"]', NULL, NULL, '2024-02-12 00:39:10', '2024-02-12 00:39:10'),
(427, 'App\\Models\\User', 1, 'auth_token', '430f2c35a5ba1a8e7270e78697d684910a724c001e0da26dace50f692a15b10e', '[\"*\"]', NULL, NULL, '2024-02-12 00:39:29', '2024-02-12 00:39:29'),
(428, 'App\\Models\\User', 1, 'auth_token', 'ac7ec188511a0b5cfc06158d8de2cc5d78836ea234aaebd7b16dfe994fd55b64', '[\"*\"]', NULL, NULL, '2024-02-12 01:01:52', '2024-02-12 01:01:52'),
(429, 'App\\Models\\User', 2, 'auth_token', 'a4b6a1b6d79805e820c5e8bb3313ee2d1204ce99eca5c3487b7300f0049559cb', '[\"*\"]', NULL, NULL, '2024-02-12 02:16:59', '2024-02-12 02:16:59'),
(430, 'App\\Models\\User', 2, 'auth_token', 'ccb627f246174a3b984eda20872b21fcaa12279c67d5583e49489e813ca98832', '[\"*\"]', NULL, NULL, '2024-02-12 03:10:18', '2024-02-12 03:10:18'),
(431, 'App\\Models\\User', 2, 'auth_token', '8e4991fdd7a00e376b2a8bdb5644091ba3b70b676b5a53fb359ba5f979247d25', '[\"*\"]', NULL, NULL, '2024-02-12 03:10:36', '2024-02-12 03:10:36'),
(432, 'App\\Models\\User', 2, 'auth_token', 'd77aeaee1d03562ad818c8fba80257aaf63d75b8b3ee1a4bfa52057104e7b36d', '[\"*\"]', NULL, NULL, '2024-02-12 03:34:09', '2024-02-12 03:34:09'),
(433, 'App\\Models\\User', 3, 'auth_token', '61fa9104e82171f6f3987572b4ddae3634ea33a87fbef3387f67ba9378cd802f', '[\"*\"]', NULL, NULL, '2024-02-12 03:41:13', '2024-02-12 03:41:13'),
(434, 'App\\Models\\User', 1, 'auth_token', '473d08ffec35e9771940a58e7cc1ef357d0babd31c6e43ae83dd90c493084d07', '[\"*\"]', NULL, NULL, '2024-02-12 05:32:30', '2024-02-12 05:32:30'),
(435, 'App\\Models\\User', 3, 'auth_token', '6c7cd5c7d9e95461f93767d6bfb9e3265eb0ffe0d8ee35a86944bb000f008b85', '[\"*\"]', NULL, NULL, '2024-02-12 05:55:05', '2024-02-12 05:55:05'),
(436, 'App\\Models\\User', 1, 'auth_token', '44613e253a503492abccf24db3cc39a7135ef0a8bc7e20a09ea965157ad8b5e9', '[\"*\"]', NULL, NULL, '2024-02-12 05:58:03', '2024-02-12 05:58:03'),
(437, 'App\\Models\\User', 2, 'auth_token', 'becbb4feeef3e8b75adf88ef58110070681c26a41068425c600ada7996b558db', '[\"*\"]', NULL, NULL, '2024-02-12 06:18:54', '2024-02-12 06:18:54'),
(438, 'App\\Models\\User', 2, 'auth_token', '36b6d30064b6bd29b4a587f66920990a0797bc1a2265dbc0ae5b121505c00d64', '[\"*\"]', NULL, NULL, '2024-02-12 06:31:37', '2024-02-12 06:31:37'),
(439, 'App\\Models\\User', 1, 'auth_token', '466a6050fcdeb3e9a2c471e92a9f3fcf7a12c73c364d53b0623cc11a0d9024f5', '[\"*\"]', NULL, NULL, '2024-02-12 06:43:48', '2024-02-12 06:43:48'),
(440, 'App\\Models\\User', 2, 'auth_token', '0b8cce1047692e34724738bb5f71b88018e3bcd91d26ccfeb723b354cff35ce1', '[\"*\"]', NULL, NULL, '2024-02-12 06:52:43', '2024-02-12 06:52:43'),
(441, 'App\\Models\\User', 2, 'auth_token', '6678b8757aa10f54439f931185dcfe69ecede233eb21b20d3892c28f443f971c', '[\"*\"]', NULL, NULL, '2024-02-12 06:56:26', '2024-02-12 06:56:26'),
(442, 'App\\Models\\User', 2, 'auth_token', 'd4ad78f7b7a1e6006cb9960f376aef98c5aec01d8f8ddbfda0a0e46e9af106d8', '[\"*\"]', NULL, NULL, '2024-02-12 06:59:18', '2024-02-12 06:59:18'),
(443, 'App\\Models\\User', 2, 'auth_token', 'd9351496a08b6f2df6faa1de8f9cf5a372b917d8c7824f8db70561450f040703', '[\"*\"]', NULL, NULL, '2024-02-12 07:02:17', '2024-02-12 07:02:17'),
(444, 'App\\Models\\User', 2, 'auth_token', 'bb7b5d9cf1e1de7f88ea2f37fd6dc7b91571295922a0941817cb499a91b8d879', '[\"*\"]', NULL, NULL, '2024-02-12 07:04:43', '2024-02-12 07:04:43'),
(445, 'App\\Models\\User', 3, 'auth_token', '60d136e0e1d793d97afd8fbc8ff167d8db0e2176108bdc0514c845f88007c5bc', '[\"*\"]', NULL, NULL, '2024-02-12 07:05:57', '2024-02-12 07:05:57'),
(446, 'App\\Models\\User', 2, 'auth_token', '3781fbe00bec70bbcc8e5fbeaea95f6710bb00f19e9c6fad9f0a2861327f5252', '[\"*\"]', NULL, NULL, '2024-02-12 07:08:38', '2024-02-12 07:08:38'),
(447, 'App\\Models\\User', 3, 'auth_token', '7383281d9d05a627c1f436af87ae14dced76c3882d113b8385b357be54df818a', '[\"*\"]', NULL, NULL, '2024-02-12 07:11:13', '2024-02-12 07:11:13'),
(448, 'App\\Models\\User', 2, 'auth_token', '4c4b11cb65b6d8beec849842ad46c2bf79e5edd2bdd08243f61783f94b9ef4e7', '[\"*\"]', NULL, NULL, '2024-02-12 22:38:31', '2024-02-12 22:38:31'),
(449, 'App\\Models\\User', 3, 'auth_token', 'ba128323044eb712badeecf2e16ebc80cdfa1e0c41ffa3a570f1d3eca19376af', '[\"*\"]', NULL, NULL, '2024-02-13 00:59:57', '2024-02-13 00:59:57'),
(450, 'App\\Models\\User', 3, 'auth_token', '771a65e5fb4850123c6cd31c6e81bdcd6e7ca453a5c8c98fca25a89d05f55847', '[\"*\"]', NULL, NULL, '2024-02-13 04:24:14', '2024-02-13 04:24:14'),
(451, 'App\\Models\\User', 2, 'auth_token', 'a5ba7e8d738f8c7ebfa72db7dfd3e6fb789e96cc6e98bb0d4c250a0d163bb291', '[\"*\"]', NULL, NULL, '2024-02-13 04:29:46', '2024-02-13 04:29:46'),
(452, 'App\\Models\\User', 2, 'auth_token', 'b5a2be13d8c3c1e9665f3afcfa5419b2fdf2e1ff8917c1509a8ef08452377651', '[\"*\"]', NULL, NULL, '2024-02-14 00:46:58', '2024-02-14 00:46:58'),
(453, 'App\\Models\\User', 2, 'auth_token', '79e9a06f69b5c46cd43683988f528feca6178654ece3edd596e8bb32d6a1e3f8', '[\"*\"]', NULL, NULL, '2024-02-14 00:51:43', '2024-02-14 00:51:43'),
(454, 'App\\Models\\User', 3, 'auth_token', '09b6b3867e28b216be369fe67ddedcb9be46e24c08b02934c06a6ee1b4fbc77f', '[\"*\"]', NULL, NULL, '2024-02-14 00:58:04', '2024-02-14 00:58:04'),
(455, 'App\\Models\\User', 2, 'auth_token', 'a6a202b6e2725d483a660cd123099cee4cf13ffd7f91872bef45d084f274573a', '[\"*\"]', NULL, NULL, '2024-02-14 01:13:49', '2024-02-14 01:13:49'),
(456, 'App\\Models\\User', 2, 'auth_token', '3d84b8bed284c3d10aea180ade41adb6a524fdaef9b606fe8216680be1681238', '[\"*\"]', NULL, NULL, '2024-02-14 02:03:47', '2024-02-14 02:03:47'),
(457, 'App\\Models\\User', 3, 'auth_token', '568a15c3e27583a264269e43767d4ec1ffe481b35b24a6e23573fdb1ea1f7799', '[\"*\"]', NULL, NULL, '2024-02-14 02:04:42', '2024-02-14 02:04:42'),
(458, 'App\\Models\\User', 2, 'auth_token', 'ec957783a535ea8b9aea010f73b6e9eba1f7170e0c131000cbcdd83147619950', '[\"*\"]', NULL, NULL, '2024-02-14 03:27:03', '2024-02-14 03:27:03'),
(459, 'App\\Models\\User', 2, 'auth_token', '0a88dc7a9825693d5c2b8bcd30292fcaf28953089464671782405c52cdd33f2f', '[\"*\"]', NULL, NULL, '2024-02-14 04:12:43', '2024-02-14 04:12:43'),
(460, 'App\\Models\\User', 3, 'auth_token', 'adf55f34d985441d6c998f82c356d05a3b7b1bafc510e9ca0262f6be3bdbb3b6', '[\"*\"]', NULL, NULL, '2024-02-14 04:16:23', '2024-02-14 04:16:23'),
(461, 'App\\Models\\User', 2, 'auth_token', 'fb888a3daf27919f3d417b5f698367478a01b509825752c419891d33270527ff', '[\"*\"]', NULL, NULL, '2024-02-14 04:19:50', '2024-02-14 04:19:50'),
(462, 'App\\Models\\User', 1, 'auth_token', '7b238ed334644edfc41695b0d58658220e302c2cd478f3cd36734f2b34151f0e', '[\"*\"]', NULL, NULL, '2024-02-14 04:22:23', '2024-02-14 04:22:23'),
(463, 'App\\Models\\User', 2, 'auth_token', 'f8688b425cf2a61c073b204362a3b0e9d52602671572dadd78e11a7510012dd5', '[\"*\"]', NULL, NULL, '2024-02-14 04:25:43', '2024-02-14 04:25:43'),
(464, 'App\\Models\\User', 2, 'auth_token', '2f5991f5e058a375b61bf7a7b9f7461209f262e57924ca0f593b6be869d16353', '[\"*\"]', NULL, NULL, '2024-02-14 04:26:59', '2024-02-14 04:26:59'),
(465, 'App\\Models\\User', 3, 'auth_token', 'ba7a9dcbae71a0f4ebec7b010edf06b0b115d137232f6d5f4b7e94e8fe1bd75c', '[\"*\"]', NULL, NULL, '2024-02-14 04:40:00', '2024-02-14 04:40:00');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` varchar(255) NOT NULL,
  `featured` int NOT NULL DEFAULT '1',
  `url_key` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `detail`, `image`, `price`, `featured`, `url_key`, `created_at`) VALUES
(1, 'JJ toy', 'anime toy', '/storage/images/1706082136_jj.jpeg', '44', 1, 'JJ', '2024-01-24 02:12:16'),
(2, 'Gym', 'Gym items', '/storage/images/1706082383_gymitem.png', '534', 1, 'GM123', '2024-01-24 02:16:23'),
(3, 'Tshirt', 'Printed tshirt', '/storage/images/1706082569_tshirt.png', '232', 1, 'PT23', '2024-01-24 02:19:29'),
(4, 'Bat', 'Cricket Bat', '/storage/images/1706082634_bat.png', '23', 1, 'BT123', '2024-01-24 02:20:34'),
(5, 'JBL', 'Speaker', '/storage/images/1706082656_speaker.png', '99', 1, 'SP123', '2024-01-24 02:20:56'),
(6, 'Auss rog', 'smart phone', '/storage/images/1706082689_rog.png', '421', 1, 'SM123', '2024-01-24 02:21:29'),
(7, 'Tedddy', 'Toys for kid', '/storage/images/1706082712_p5.png', '44', 1, 'TO123', '2024-01-24 02:21:52'),
(8, 'home deco', 'Wall item', '/storage/images/1706082754_homedec.png', '62', 1, 'HM123', '2024-01-24 02:22:34'),
(9, 'Watch', 'Watch for gym', '/storage/images/1706082799_p7.png', '34', 1, 'WA123', '2024-01-24 02:23:19'),
(14, 'Rhea Brennan', 'Sit iste dolore impe', '/storage/images/1707214481_1.jpeg', '826', 1, 'FF44', '2024-02-06 04:44:42'),
(15, 'danger', 'Voluptatem et aut r', '/storage/images/1707215007_HD-wallpaper-one-piece-logo-anime-one-piece-thumbnail.jpg', '447', 1, 'VCaa', '2024-02-06 04:53:27'),
(16, 'parth', 'Aute ullam eveniet', '/storage/images/1707296484_food.png', '684', 1, 'ASD', '2024-02-07 03:31:24');

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `category_id` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `product_id`, `category_id`, `created_at`) VALUES
(1, 1, 2, '2024-01-24 07:42:16'),
(2, 2, 4, '2024-01-24 07:46:23'),
(3, 3, 3, '2024-01-24 07:49:29'),
(4, 4, 4, '2024-01-24 07:50:34'),
(5, 5, 1, '2024-01-24 07:50:56'),
(6, 6, 1, '2024-01-24 07:51:29'),
(7, 7, 2, '2024-01-24 07:51:52'),
(8, 8, 3, '2024-01-24 07:52:34'),
(9, 9, 4, '2024-01-24 07:53:19'),
(10, 10, 2, '2024-01-24 07:55:40'),
(11, 11, 1, '2024-01-24 07:57:30'),
(12, 15, 4, '2024-02-06 10:23:27'),
(13, 15, 3, '2024-02-06 10:23:27'),
(14, 15, 2, '2024-02-06 10:23:27'),
(15, 15, 1, '2024-02-06 10:23:27'),
(16, 16, 3, '2024-02-07 09:01:24'),
(17, 16, 2, '2024-02-07 09:01:24');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL DEFAULT '2',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `number`, `gender`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'parth', 'parthhinge@gmail.com', '111111111', 'male', NULL, '$2y$12$vIgvJRLZi1o/ray7C9XAz.1HsJqizGIntTqe9coZ6sdeu80y6.j7K', 1, NULL, '2023-12-29 05:11:42', '2024-02-12 02:21:28'),
(2, 'parth', 'noddy@gmail.com', '123123123', 'male', NULL, '$2y$12$9yKuT5h9yYB5Oyr5MEKVauOUCqATiTpCFsgWC.uhikoEG4G2nYvoi', 2, NULL, '2024-02-09 04:08:11', '2024-02-12 03:37:21'),
(3, 'demo', 'demo@gmail.com', '123321123', 'other', NULL, '$2y$12$1/.Eb/fErdJHLKfYjUBT1eTSTIrEx7xCzxYC8hreef5Q5LJpSpJNm', 2, NULL, '2024-02-12 03:41:04', '2024-02-12 03:41:20');

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` int NOT NULL,
  `productId` int DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `itemOptions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `movedToCart` datetime DEFAULT NULL,
  `shared` int DEFAULT NULL,
  `timeOfMoving` datetime DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customerId` (`customerId`),
  ADD KEY `cartId` (`cartId`);

--
-- Indexes for table `attributefamilies`
--
ALTER TABLE `attributefamilies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attributegroups`
--
ALTER TABLE `attributegroups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attributeFamilyId` (`attributeFamilyId`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attributeFamilyId` (`attributeFamilyId`);

--
-- Indexes for table `attributetranslations`
--
ALTER TABLE `attributetranslations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attributeId` (`attributeId`);

--
-- Indexes for table `cartpayments`
--
ALTER TABLE `cartpayments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customerId` (`customerId`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `orderpayments`
--
ALTER TABLE `orderpayments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderId` (`orderId`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cartId_2` (`cartId`),
  ADD KEY `customerId` (`customerId`),
  ADD KEY `cartId` (`cartId`);

--
-- Indexes for table `ordertransactions`
--
ALTER TABLE `ordertransactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_adds`
--
ALTER TABLE `order_adds`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `url_key` (`url_key`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `attributefamilies`
--
ALTER TABLE `attributefamilies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `attributegroups`
--
ALTER TABLE `attributegroups`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `attributetranslations`
--
ALTER TABLE `attributetranslations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cartpayments`
--
ALTER TABLE `cartpayments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `orderpayments`
--
ALTER TABLE `orderpayments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ordertransactions`
--
ALTER TABLE `ordertransactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_adds`
--
ALTER TABLE `order_adds`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=466;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderpayments`
--
ALTER TABLE `orderpayments`
  ADD CONSTRAINT `orderPayments_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`cartId`) REFERENCES `carts` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
