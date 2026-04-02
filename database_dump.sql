-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: pharmacovigilance
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `order_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `alert_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'email',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `sent_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alerts_customer_id_foreign` (`customer_id`),
  KEY `alerts_order_id_foreign` (`order_id`),
  KEY `alerts_user_id_foreign` (`user_id`),
  CONSTRAINT `alerts_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `alerts_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `alerts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'John Smith','john.smith@email.com','555-0101','2026-04-02 20:31:57','2026-04-02 20:31:57'),(2,'Maria Garcia','maria.garcia@email.com','555-0102','2026-04-02 20:31:57','2026-04-02 20:31:57'),(3,'Robert Johnson','robert.johnson@email.com','555-0103','2026-04-02 20:31:57','2026-04-02 20:31:57'),(4,'Emily Davis','emily.davis@email.com','555-0104','2026-04-02 20:31:57','2026-04-02 20:31:57'),(5,'Michael Wilson','michael.wilson@email.com','555-0105','2026-04-02 20:31:57','2026-04-02 20:31:57'),(6,'Sarah Brown','sarah.brown@email.com','555-0106','2026-04-02 20:31:57','2026-04-02 20:31:57'),(7,'David Martinez','david.martinez@email.com','555-0107','2026-04-02 20:31:57','2026-04-02 20:31:57'),(8,'Jennifer Taylor','jennifer.taylor@email.com','555-0108','2026-04-02 20:31:57','2026-04-02 20:31:57'),(9,'James Anderson','james.anderson@email.com','555-0109','2026-04-02 20:31:57','2026-04-02 20:31:57'),(10,'Lisa Thomas','lisa.thomas@email.com','555-0110','2026-04-02 20:31:57','2026-04-02 20:31:57');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medications`
--

DROP TABLE IF EXISTS `medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lot_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medications_lot_number_index` (`lot_number`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medications`
--

LOCK TABLES `medications` WRITE;
/*!40000 ALTER TABLE `medications` DISABLE KEYS */;
INSERT INTO `medications` VALUES (1,'Acetaminophen 500mg','951357','Pain reliever and fever reducer','2026-04-02 20:31:57','2026-04-02 20:31:57'),(2,'Ibuprofen 200mg','951358','Anti-inflammatory pain reliever','2026-04-02 20:31:57','2026-04-02 20:31:57'),(3,'Amoxicillin 250mg','951359','Antibiotic for bacterial infections','2026-04-02 20:31:57','2026-04-02 20:31:57'),(4,'Lisinopril 10mg','951360','Blood pressure medication','2026-04-02 20:31:57','2026-04-02 20:31:57'),(5,'Metformin 500mg','951361','Diabetes medication','2026-04-02 20:31:57','2026-04-02 20:31:57'),(6,'Atorvastatin 20mg','951362','Cholesterol-lowering medication','2026-04-02 20:31:57','2026-04-02 20:31:57'),(7,'Omeprazole 20mg','951357','Proton pump inhibitor for acid reflux','2026-04-02 20:31:57','2026-04-02 20:31:57'),(8,'Levothyroxine 50mcg','951363','Thyroid hormone replacement','2026-04-02 20:31:57','2026-04-02 20:31:57');
/*!40000 ALTER TABLE `medications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_04_02_184551_create_personal_access_tokens_table',1),(5,'2026_04_02_184555_create_customers_table',1),(6,'2026_04_02_184555_create_medications_table',1),(7,'2026_04_02_184556_create_orders_table',1),(8,'2026_04_02_184557_create_order_items_table',1),(9,'2026_04_02_184558_create_alerts_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `medication_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_medication_id_foreign` (`medication_id`),
  CONSTRAINT `order_items_medication_id_foreign` FOREIGN KEY (`medication_id`) REFERENCES `medications` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,3,1,16.00,16.00,'2026-04-02 20:31:57','2026-04-02 20:31:57'),(2,1,5,1,27.00,27.00,'2026-04-02 20:31:57','2026-04-02 20:31:57'),(3,1,4,2,81.00,162.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(4,2,1,2,25.00,50.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(5,3,1,1,28.00,28.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(6,3,7,1,63.00,63.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(7,4,5,1,83.00,83.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(8,5,4,3,17.00,51.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(9,5,2,1,55.00,55.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(10,6,5,2,68.00,136.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(11,6,4,3,90.00,270.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(12,7,4,3,12.00,36.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(13,8,4,2,19.00,38.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(14,9,1,3,58.00,174.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(15,9,3,3,61.00,183.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(16,9,6,3,87.00,261.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(17,10,3,1,69.00,69.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(18,10,5,1,50.00,50.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(19,10,8,1,65.00,65.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(20,11,6,3,57.00,171.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(21,11,4,2,62.00,124.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(22,12,1,2,73.00,146.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(23,12,8,1,46.00,46.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(24,12,8,1,17.00,17.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(25,13,2,2,20.00,40.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(26,13,3,2,73.00,146.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(27,13,5,1,62.00,62.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(28,14,2,3,56.00,168.00,'2026-04-02 20:31:58','2026-04-02 20:31:58'),(29,15,8,3,72.00,216.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(30,15,2,3,48.00,144.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(31,15,1,1,43.00,43.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(32,16,6,3,98.00,294.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(33,16,6,2,34.00,68.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(34,17,7,3,67.00,201.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(35,18,4,3,55.00,165.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(36,18,8,1,40.00,40.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(37,19,5,3,95.00,285.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(38,19,7,1,23.00,23.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(39,19,8,1,99.00,99.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(40,20,3,3,77.00,231.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(41,20,4,2,48.00,96.00,'2026-04-02 20:31:59','2026-04-02 20:31:59'),(42,20,2,1,32.00,32.00,'2026-04-02 20:31:59','2026-04-02 20:31:59');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `purchase_date` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'completed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_customer_id_foreign` (`customer_id`),
  CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2026-02-17',205.00,'completed','2026-04-02 20:31:57','2026-04-02 20:31:58'),(2,7,'2026-03-01',50.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(3,2,'2026-03-15',91.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(4,2,'2026-03-18',83.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(5,3,'2026-02-24',106.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(6,3,'2026-02-27',406.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(7,4,'2026-03-28',36.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(8,5,'2026-03-03',38.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(9,7,'2026-03-22',618.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(10,4,'2026-03-07',184.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(11,6,'2026-02-17',295.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(12,6,'2026-03-27',209.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(13,4,'2026-02-26',248.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(14,2,'2026-02-26',168.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:58'),(15,6,'2026-03-29',403.00,'completed','2026-04-02 20:31:58','2026-04-02 20:31:59'),(16,4,'2026-02-20',362.00,'completed','2026-04-02 20:31:59','2026-04-02 20:31:59'),(17,4,'2026-02-22',201.00,'completed','2026-04-02 20:31:59','2026-04-02 20:31:59'),(18,7,'2026-03-05',205.00,'completed','2026-04-02 20:31:59','2026-04-02 20:31:59'),(19,2,'2026-03-26',407.00,'completed','2026-04-02 20:31:59','2026-04-02 20:31:59'),(20,5,'2026-03-27',359.00,'completed','2026-04-02 20:31:59','2026-04-02 20:31:59');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',1,'pharmacovigilance-token','b6a56bd70af8ae9a6e8cf35abb40ea1340c7f5370cea7c34c80201dcdbebfcbe','[\"*\"]','2026-04-02 20:35:10',NULL,'2026-04-02 20:35:07','2026-04-02 20:35:10');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Pharmacovigilance Admin','admin@pharmacovigilance.com',NULL,'$2y$12$Dvy4yfPqp0WYT8HoBU6pLem1tsnLXX1TjvDo90HtTeiTmvm8xglXa',NULL,'2026-04-02 20:31:57','2026-04-02 20:31:57'),(2,'Pharmacy Manager','manager@pharmacovigilance.com',NULL,'$2y$12$rPifOXXI22Um0ansipzKSeFylBqnmxCkFmbjrf/sQez6Id2MXkY1S',NULL,'2026-04-02 20:31:57','2026-04-02 20:31:57');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-02 20:35:13
