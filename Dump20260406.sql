-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: bladder
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add Token',7,'add_token'),(26,'Can change Token',7,'change_token'),(27,'Can delete Token',7,'delete_token'),(28,'Can view Token',7,'view_token'),(29,'Can add Token',8,'add_tokenproxy'),(30,'Can change Token',8,'change_tokenproxy'),(31,'Can delete Token',8,'delete_tokenproxy'),(32,'Can view Token',8,'view_tokenproxy'),(33,'Can add doctor profile',10,'add_doctorprofile'),(34,'Can change doctor profile',10,'change_doctorprofile'),(35,'Can delete doctor profile',10,'delete_doctorprofile'),(36,'Can view doctor profile',10,'view_doctorprofile'),(37,'Can add patient',11,'add_patient'),(38,'Can change patient',11,'change_patient'),(39,'Can delete patient',11,'delete_patient'),(40,'Can view patient',11,'view_patient'),(41,'Can add appointment',9,'add_appointment'),(42,'Can change appointment',9,'change_appointment'),(43,'Can delete appointment',9,'delete_appointment'),(44,'Can view appointment',9,'view_appointment'),(45,'Can add scan report',12,'add_scanreport'),(46,'Can change scan report',12,'change_scanreport'),(47,'Can delete scan report',12,'delete_scanreport'),(48,'Can view scan report',12,'view_scanreport'),(49,'Can add feature',14,'add_feature'),(50,'Can change feature',14,'change_feature'),(51,'Can delete feature',14,'delete_feature'),(52,'Can view feature',14,'view_feature'),(53,'Can add app info',13,'add_appinfo'),(54,'Can change app info',13,'change_appinfo'),(55,'Can delete app info',13,'delete_appinfo'),(56,'Can view app info',13,'view_appinfo'),(57,'Can add analytics data',15,'add_analyticsdata'),(58,'Can change analytics data',15,'change_analyticsdata'),(59,'Can delete analytics data',15,'delete_analyticsdata'),(60,'Can view analytics data',15,'view_analyticsdata'),(61,'Can add scan validation',16,'add_scanvalidation'),(62,'Can change scan validation',16,'change_scanvalidation'),(63,'Can delete scan validation',16,'delete_scanvalidation'),(64,'Can view scan validation',16,'view_scanvalidation'),(65,'Can add backup settings',18,'add_backupsettings'),(66,'Can change backup settings',18,'change_backupsettings'),(67,'Can delete backup settings',18,'delete_backupsettings'),(68,'Can view backup settings',18,'view_backupsettings'),(69,'Can add backup',17,'add_backup'),(70,'Can change backup',17,'change_backup'),(71,'Can delete backup',17,'delete_backup'),(72,'Can view backup',17,'view_backup'),(73,'Can add support message',19,'add_supportmessage'),(74,'Can change support message',19,'change_supportmessage'),(75,'Can delete support message',19,'delete_supportmessage'),(76,'Can view support message',19,'view_supportmessage'),(77,'Can add accessibility settings',20,'add_accessibilitysettings'),(78,'Can change accessibility settings',20,'change_accessibilitysettings'),(79,'Can delete accessibility settings',20,'delete_accessibilitysettings'),(80,'Can view accessibility settings',20,'view_accessibilitysettings'),(81,'Can add display settings',21,'add_displaysettings'),(82,'Can change display settings',21,'change_displaysettings'),(83,'Can delete display settings',21,'delete_displaysettings'),(84,'Can view display settings',21,'view_displaysettings'),(85,'Can add equipment',22,'add_equipment'),(86,'Can change equipment',22,'change_equipment'),(87,'Can delete equipment',22,'delete_equipment'),(88,'Can view equipment',22,'view_equipment'),(89,'Can add estimation result',23,'add_estimationresult'),(90,'Can change estimation result',23,'change_estimationresult'),(91,'Can delete estimation result',23,'delete_estimationresult'),(92,'Can view estimation result',23,'view_estimationresult'),(93,'Can add data export',24,'add_dataexport'),(94,'Can change data export',24,'change_dataexport'),(95,'Can delete data export',24,'delete_dataexport'),(96,'Can view data export',24,'view_dataexport'),(97,'Can add feedback',25,'add_feedback'),(98,'Can change feedback',25,'change_feedback'),(99,'Can delete feedback',25,'delete_feedback'),(100,'Can view feedback',25,'view_feedback'),(101,'Can add password reset token',26,'add_passwordresettoken'),(102,'Can change password reset token',26,'change_passwordresettoken'),(103,'Can delete password reset token',26,'delete_passwordresettoken'),(104,'Can view password reset token',26,'view_passwordresettoken'),(105,'Can add help article',27,'add_helparticle'),(106,'Can change help article',27,'change_helparticle'),(107,'Can delete help article',27,'delete_helparticle'),(108,'Can view help article',27,'view_helparticle'),(109,'Can add notification',28,'add_notification'),(110,'Can change notification',28,'change_notification'),(111,'Can delete notification',28,'delete_notification'),(112,'Can view notification',28,'view_notification'),(113,'Can add privacy policy',29,'add_privacypolicy'),(114,'Can change privacy policy',29,'change_privacypolicy'),(115,'Can delete privacy policy',29,'delete_privacypolicy'),(116,'Can view privacy policy',29,'view_privacypolicy'),(117,'Can add recommendation',30,'add_recommendation'),(118,'Can change recommendation',30,'change_recommendation'),(119,'Can delete recommendation',30,'delete_recommendation'),(120,'Can view recommendation',30,'view_recommendation'),(121,'Can add training module',33,'add_trainingmodule'),(122,'Can change training module',33,'change_trainingmodule'),(123,'Can delete training module',33,'delete_trainingmodule'),(124,'Can view training module',33,'view_trainingmodule'),(125,'Can add team invitation',31,'add_teaminvitation'),(126,'Can change team invitation',31,'change_teaminvitation'),(127,'Can delete team invitation',31,'delete_teaminvitation'),(128,'Can view team invitation',31,'view_teaminvitation'),(129,'Can add team member',32,'add_teammember'),(130,'Can change team member',32,'change_teammember'),(131,'Can delete team member',32,'delete_teammember'),(132,'Can view team member',32,'view_teammember'),(133,'Can add user session',35,'add_usersession'),(134,'Can change user session',35,'change_usersession'),(135,'Can delete user session',35,'delete_usersession'),(136,'Can view user session',35,'view_usersession'),(137,'Can add training progress',34,'add_trainingprogress'),(138,'Can change training progress',34,'change_trainingprogress'),(139,'Can delete training progress',34,'delete_trainingprogress'),(140,'Can view training progress',34,'view_trainingprogress');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1200000$eZ9QjKdCIb6Uktrspu95DN$+I6SGmgK80w2xOmedWnuxKc6oroiRV28u0fEuAkpYUQ=',NULL,0,'doctor@example.com','','','doctor@example.com',0,1,'2026-03-03 08:05:27.432727'),(2,'pbkdf2_sha256$1200000$6e2VQl4lmH3qva67j9rbr8$ovWHW+vtOQXaIwb4AVfobPgfHBb8l6ZGh4EVlZaH53Q=',NULL,0,'aadithya030604@gmail.com','','','aadithya030604@gmail.com',0,1,'2026-03-13 03:49:40.969839'),(3,'pbkdf2_sha256$1200000$utiEAXX6fNMrVGOUlIAGSL$tzZekwe9jKcBY68LhWXHjSQVc40cCa5cHe9f6tGcxpQ=',NULL,0,'ranjithkumar8032@gmail.com','','','ranjithkumar8032@gmail.com',0,1,'2026-03-13 04:26:25.127782'),(4,'pbkdf2_sha256$1200000$BXpxXRckTRDWHevBZarqjB$dVyZ/k+sFRA9sQJASIOXGfb4gMDGeTr4WQc8ki/txF0=',NULL,0,'aadithyan4281.sse@saveetha.com','','','aadithyan4281.sse@saveetha.com',0,1,'2026-03-13 04:33:50.045406'),(5,'pbkdf2_sha256$1200000$1zl9CByz95vRI9TPnnkAAu$rpQw+24zwP5HbJOfGAuhbG5cNfYJ+l48tpuYPC7kXxA=',NULL,0,'sakthiv1415@gmail.com','','','sakthiv1415@gmail.com',0,1,'2026-03-16 05:05:48.574792'),(6,'pbkdf2_sha256$1200000$eqoM1Ixr5nXRlujh9lQjAz$WzSkV8Z3+64dSn4sXBiKUUhR+p4OKKDtpnTFtk6jgFs=',NULL,0,'dksp@gmail.com','','','dksp@gmail.com',0,1,'2026-03-17 04:43:22.533907'),(7,'pbkdf2_sha256$1200000$P0scnCwYlh2ibUAoJvKKZ6$g1ZjJjlcIWgZWqDA7iskTWE83nhagnHJZLdUspD3MUs=',NULL,0,'doctor@gmail.com','','','doctor@gmail.com',0,1,'2026-03-17 16:31:30.239756'),(8,'pbkdf2_sha256$1200000$1cmpQpo7KDS04qywVSZbp1$ArK0v0PO0Hpmz9l6ecnq4gzp6CGoWVfILB9pwwlnmqQ=',NULL,0,'doc@gmail.com','','','doc@gmail.com',0,1,'2026-03-18 18:37:22.523412'),(9,'pbkdf2_sha256$1200000$8DL9gwtag9Xnl7o5qBfd9R$QtEd2YhC5tyK8U8tnXu8OGvrhtQscVK3tfzuiuOsuLo=',NULL,0,'hospital@gmail.com','','','hospital@gmail.com',0,1,'2026-03-18 18:49:15.350578'),(10,'pbkdf2_sha256$1200000$YxMw1QqblMz8Pc6FMuvZPm$ocq3RsXFYWnyyK7/cLMRPkJoAzUD/9nDnzPhylRtjXI=',NULL,0,'anbu@gmail.com','','','anbu@gmail.com',0,1,'2026-03-22 08:30:35.243294'),(11,'bcrypt_sha256$$2b$12$es/Z8v51/MyGMRaT4RvoKuKC4Tsi0wdAA.qVLjPf5Pi6M5IeYH3j6',NULL,0,'dhanush@gmail.com','','','dhanush@gmail.com',0,1,'2026-03-27 07:20:08.734454'),(12,'bcrypt_sha256$$2b$12$7ufAwJSlWqzIVgq78fgI3eI6nlrPkW65pQ8.CIZWeidUsdo3sta8S',NULL,0,'arun@gmail.com','','','arun@gmail.com',0,1,'2026-03-30 19:25:03.025948'),(13,'bcrypt_sha256$$2b$12$Ye2ZJ8muCFNO2JFmvA0Aue9uSR7pSeiAuS8jbz3KD5JQO2b0x0SYe',NULL,0,'shivi@gmail.com','','','shivi@gmail.com',0,1,'2026-03-31 09:29:51.566302'),(14,'bcrypt_sha256$$2b$12$PP.UxWBBRjZKyyguyxhu5eqP3Mcu7dxWTNxaew9dV/LPfVk8iWTbu',NULL,0,'siva@gmail.com','','','siva@gmail.com',0,1,'2026-04-01 09:25:52.487505'),(15,'bcrypt_sha256$$2b$12$D/4y7xSlDsjlADtnhMVl4u0u/bvVM/J8GNejsef82UCJA8y03BUma',NULL,0,'kavi@gmail.com','','','kavi@gmail.com',0,1,'2026-04-02 18:41:39.509379'),(16,'bcrypt_sha256$$2b$12$ou5xX084aR/ul9zYt9vd4utRh5Mt9N2FceBr7QhGzvLrpKaSXlJJW',NULL,0,'sam@gmail.com','','','sam@gmail.com',0,1,'2026-04-03 05:23:17.783059');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(7,'authtoken','token'),(8,'authtoken','tokenproxy'),(5,'contenttypes','contenttype'),(20,'doctor','accessibilitysettings'),(15,'doctor','analyticsdata'),(13,'doctor','appinfo'),(9,'doctor','appointment'),(17,'doctor','backup'),(18,'doctor','backupsettings'),(24,'doctor','dataexport'),(21,'doctor','displaysettings'),(10,'doctor','doctorprofile'),(22,'doctor','equipment'),(23,'doctor','estimationresult'),(14,'doctor','feature'),(25,'doctor','feedback'),(27,'doctor','helparticle'),(28,'doctor','notification'),(26,'doctor','passwordresettoken'),(11,'doctor','patient'),(29,'doctor','privacypolicy'),(30,'doctor','recommendation'),(12,'doctor','scanreport'),(16,'doctor','scanvalidation'),(19,'doctor','supportmessage'),(31,'doctor','teaminvitation'),(32,'doctor','teammember'),(33,'doctor','trainingmodule'),(34,'doctor','trainingprogress'),(35,'doctor','usersession'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-02-24 10:18:57.078393'),(2,'auth','0001_initial','2026-02-24 10:18:59.409701'),(3,'admin','0001_initial','2026-02-24 10:18:59.612675'),(4,'admin','0002_logentry_remove_auto_add','2026-02-24 10:18:59.624630'),(5,'admin','0003_logentry_add_action_flag_choices','2026-02-24 10:18:59.637598'),(6,'contenttypes','0002_remove_content_type_name','2026-02-24 10:18:59.896781'),(7,'auth','0002_alter_permission_name_max_length','2026-02-24 10:19:00.022233'),(8,'auth','0003_alter_user_email_max_length','2026-02-24 10:19:00.062066'),(9,'auth','0004_alter_user_username_opts','2026-02-24 10:19:00.073966'),(10,'auth','0005_alter_user_last_login_null','2026-02-24 10:19:00.231591'),(11,'auth','0006_require_contenttypes_0002','2026-02-24 10:19:00.235580'),(12,'auth','0007_alter_validators_add_error_messages','2026-02-24 10:19:00.252535'),(13,'auth','0008_alter_user_username_max_length','2026-02-24 10:19:00.349152'),(14,'auth','0009_alter_user_last_name_max_length','2026-02-24 10:19:00.463836'),(15,'auth','0010_alter_group_name_max_length','2026-02-24 10:19:00.493755'),(16,'auth','0011_update_proxy_permissions','2026-02-24 10:19:00.508009'),(17,'auth','0012_alter_user_first_name_max_length','2026-02-24 10:19:00.643061'),(18,'authtoken','0001_initial','2026-02-24 10:19:00.846427'),(19,'authtoken','0002_auto_20160226_1747','2026-02-24 10:19:00.890421'),(20,'authtoken','0003_tokenproxy','2026-02-24 10:19:00.894411'),(21,'authtoken','0004_alter_tokenproxy_options','2026-02-24 10:19:00.901393'),(22,'doctor','0001_initial','2026-02-24 10:19:01.735502'),(23,'sessions','0001_initial','2026-02-24 10:19:01.826991'),(24,'doctor','0002_appointment_reason_doctorprofile_phone_and_more','2026-03-03 07:36:52.152374'),(25,'doctor','0003_appinfo_feature','2026-03-03 07:59:03.494106'),(26,'doctor','0004_analyticsdata','2026-03-03 08:04:56.264372'),(27,'doctor','0005_scanvalidation','2026-03-03 08:08:30.444090'),(28,'doctor','0006_appointment_appointment_type','2026-03-03 08:10:12.232381'),(29,'doctor','0007_appointment_duration_minutes_appointment_location','2026-03-03 08:12:07.469334'),(30,'doctor','0008_backup_backupsettings','2026-03-03 08:15:47.196819'),(31,'doctor','0009_scanvalidation_view_type','2026-03-03 08:30:00.290738'),(32,'doctor','0010_supportmessage','2026-03-03 08:33:24.907379'),(33,'doctor','0011_accessibilitysettings','2026-03-03 08:35:53.596608'),(34,'doctor','0012_displaysettings','2026-03-03 08:38:12.745341'),(35,'doctor','0013_equipment','2026-03-03 08:49:08.897370'),(36,'doctor','0014_estimationresult','2026-03-03 08:52:51.376517'),(37,'doctor','0015_dataexport','2026-03-03 08:55:31.574564'),(38,'doctor','0016_feedback','2026-03-03 09:00:47.007508'),(39,'doctor','0017_passwordresettoken','2026-03-03 09:04:31.669439'),(40,'doctor','0018_helparticle','2026-03-03 09:19:14.826561'),(41,'doctor','0019_notification','2026-03-04 02:59:15.507646'),(42,'doctor','0020_privacypolicy','2026-03-04 03:21:06.841523'),(43,'doctor','0021_recommendation','2026-03-04 03:26:57.316711'),(44,'doctor','0022_trainingmodule_doctorprofile_biometric_enabled_and_more','2026-03-09 04:49:12.009063'),(45,'doctor','0023_patient_is_archived','2026-03-23 05:12:39.858070'),(46,'doctor','0024_patient_condition','2026-03-23 08:32:25.373897');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_accessibilitysettings`
--

DROP TABLE IF EXISTS `doctor_accessibilitysettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_accessibilitysettings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `voice_guidance` tinyint(1) NOT NULL,
  `screen_reader_optimized` tinyint(1) NOT NULL,
  `high_contrast` tinyint(1) NOT NULL,
  `button_size` varchar(20) NOT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `doctor_accessibility_doctor_id_2cc87ca1_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_accessibilitysettings`
--

LOCK TABLES `doctor_accessibilitysettings` WRITE;
/*!40000 ALTER TABLE `doctor_accessibilitysettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_accessibilitysettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_analyticsdata`
--

DROP TABLE IF EXISTS `doctor_analyticsdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_analyticsdata` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `total_scans` int NOT NULL,
  `scans_increase_pct` double NOT NULL,
  `avg_volume` varchar(50) NOT NULL,
  `volume_decrease_pct` double NOT NULL,
  `active_patients` int NOT NULL,
  `patients_increase` int NOT NULL,
  `retention_rate` double NOT NULL,
  `retention_increase_pct` double NOT NULL,
  `trend_monday` double NOT NULL,
  `trend_tuesday` double NOT NULL,
  `trend_wednesday` double NOT NULL,
  `trend_thursday` double NOT NULL,
  `trend_friday` double NOT NULL,
  `trend_saturday` double NOT NULL,
  `trend_sunday` double NOT NULL,
  `scan_duration_seconds` double NOT NULL,
  `image_quality_pct` double NOT NULL,
  `report_gen_seconds` double NOT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `doctor_analyticsdata_doctor_id_9e299b08_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_analyticsdata`
--

LOCK TABLES `doctor_analyticsdata` WRITE;
/*!40000 ALTER TABLE `doctor_analyticsdata` DISABLE KEYS */;
INSERT INTO `doctor_analyticsdata` VALUES (1,142,12,'320ml',5,89,3,18,2,310,340,320,350,300,280,260,45,98,1.2,1);
/*!40000 ALTER TABLE `doctor_analyticsdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_appinfo`
--

DROP TABLE IF EXISTS `doctor_appinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_appinfo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_name` varchar(100) NOT NULL,
  `version` varchar(50) NOT NULL,
  `build_number` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `footer_text` varchar(255) NOT NULL,
  `copyright_text` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_appinfo`
--

LOCK TABLES `doctor_appinfo` WRITE;
/*!40000 ALTER TABLE `doctor_appinfo` DISABLE KEYS */;
INSERT INTO `doctor_appinfo` VALUES (1,'BladSense AI','2.1.0','402','BladSense AI is a revolutionary medical imaging platform that uses artificial intelligence to analyze bladder ultrasound scans and provide accurate volume measurements in seconds.','Made with ❤ by BladSense Team','© 2024 BladSense Inc. All rights reserved.');
/*!40000 ALTER TABLE `doctor_appinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_appointment`
--

DROP TABLE IF EXISTS `doctor_appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_appointment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `time` time(6) NOT NULL,
  `status` varchar(50) NOT NULL,
  `doctor_id` bigint NOT NULL,
  `patient_id` bigint DEFAULT NULL,
  `reason` longtext,
  `appointment_type` varchar(100) NOT NULL,
  `duration_minutes` int NOT NULL,
  `location` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_appointment_doctor_id_8c182dc1_fk_doctor_doctorprofile_id` (`doctor_id`),
  KEY `doctor_appointment_patient_id_bff365b8_fk_doctor_patient_id` (`patient_id`),
  CONSTRAINT `doctor_appointment_doctor_id_8c182dc1_fk_doctor_doctorprofile_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`),
  CONSTRAINT `doctor_appointment_patient_id_bff365b8_fk_doctor_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `doctor_patient` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_appointment`
--

LOCK TABLES `doctor_appointment` WRITE;
/*!40000 ALTER TABLE `doctor_appointment` DISABLE KEYS */;
INSERT INTO `doctor_appointment` VALUES (1,'2024-10-23','09:00:00.000000','Scheduled',1,1,NULL,'Follow-up Scan',30,'Room 302'),(2,'2024-10-23','10:30:00.000000','Scheduled',1,2,NULL,'Initial Assessment',45,'Room 302'),(3,'2024-10-23','14:00:00.000000','Scheduled',1,3,NULL,'Routine Check',15,'Room 302'),(4,'2026-03-18','10:00:00.000000','Scheduled',7,7,NULL,'Initial',20,'609'),(5,'2026-03-18','10:00:00.000000','Scheduled',7,7,NULL,'Initial',20,'609'),(6,'2026-03-17','10:00:00.000000','Scheduled',7,7,NULL,'Initial',30,'809');
/*!40000 ALTER TABLE `doctor_appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_backup`
--

DROP TABLE IF EXISTS `doctor_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_backup` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `file_size` varchar(50) NOT NULL,
  `item_count` int NOT NULL,
  `backup_file` varchar(100) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_backup_doctor_id_40aea13c_fk_doctor_doctorprofile_id` (`doctor_id`),
  CONSTRAINT `doctor_backup_doctor_id_40aea13c_fk_doctor_doctorprofile_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_backup`
--

LOCK TABLES `doctor_backup` WRITE;
/*!40000 ALTER TABLE `doctor_backup` DISABLE KEYS */;
INSERT INTO `doctor_backup` VALUES (1,'2026-03-03 08:16:26.528684','1.2 GB',248,'','Success',1),(2,'2026-03-03 08:16:26.531572','1.2 GB',240,'','Success',1),(3,'2026-03-03 08:16:26.535562','1.1 GB',235,'','Success',1);
/*!40000 ALTER TABLE `doctor_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_backupsettings`
--

DROP TABLE IF EXISTS `doctor_backupsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_backupsettings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `auto_backup` tinyint(1) NOT NULL,
  `include_images` tinyint(1) NOT NULL,
  `wifi_only` tinyint(1) NOT NULL,
  `last_backup_at` datetime(6) DEFAULT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `doctor_backupsetting_doctor_id_8a49e369_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_backupsettings`
--

LOCK TABLES `doctor_backupsettings` WRITE;
/*!40000 ALTER TABLE `doctor_backupsettings` DISABLE KEYS */;
INSERT INTO `doctor_backupsettings` VALUES (1,1,1,1,'2026-03-03 08:16:26.520531',1),(2,1,1,1,NULL,5);
/*!40000 ALTER TABLE `doctor_backupsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_dataexport`
--

DROP TABLE IF EXISTS `doctor_dataexport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_dataexport` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(20) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` varchar(50) DEFAULT NULL,
  `categories_included` int NOT NULL,
  `download_url` varchar(200) DEFAULT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_dataexport_doctor_id_fef501ba_fk_doctor_doctorprofile_id` (`doctor_id`),
  CONSTRAINT `doctor_dataexport_doctor_id_fef501ba_fk_doctor_doctorprofile_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_dataexport`
--

LOCK TABLES `doctor_dataexport` WRITE;
/*!40000 ALTER TABLE `doctor_dataexport` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_dataexport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_displaysettings`
--

DROP TABLE IF EXISTS `doctor_displaysettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_displaysettings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `theme` varchar(20) NOT NULL,
  `volume_units` varchar(50) NOT NULL,
  `language` varchar(50) NOT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `doctor_displaysettin_doctor_id_6f2c6247_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_displaysettings`
--

LOCK TABLES `doctor_displaysettings` WRITE;
/*!40000 ALTER TABLE `doctor_displaysettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_displaysettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_doctorprofile`
--

DROP TABLE IF EXISTS `doctor_doctorprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_doctorprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fullName` varchar(255) NOT NULL,
  `licenseNumber` varchar(100) NOT NULL,
  `specialty` varchar(100) NOT NULL,
  `user_id` int NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `profile_picture` varchar(100) DEFAULT NULL,
  `biometric_enabled` tinyint(1) NOT NULL,
  `last_password_change` datetime(6) NOT NULL,
  `location` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `technician_level` varchar(50) NOT NULL,
  `two_factor_enabled` tinyint(1) NOT NULL,
  `years_of_experience` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `licenseNumber` (`licenseNumber`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `doctor_doctorprofile_user_id_42aa5af1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_doctorprofile`
--

LOCK TABLES `doctor_doctorprofile` WRITE;
/*!40000 ALTER TABLE `doctor_doctorprofile` DISABLE KEYS */;
INSERT INTO `doctor_doctorprofile` VALUES (1,'Dr. John Doe','LIC-12345','Urology',1,NULL,'',0,'2026-03-09 04:49:09.151355','Building A, Floor 3','Active','Level 1',1,0),(2,'Dr. Aadithya','MD-12345','Urology',2,'','',0,'2026-03-13 03:49:43.376092','Building A, Floor 3','Active','Level 1',1,0),(3,'Dr. Aadithya','MD-12346','Urology',3,'','',0,'2026-03-13 04:26:27.449697','Building A, Floor 3','Active','Level 1',1,0),(4,'Dr. Aadithya','MD-12348','Urology',4,'','',0,'2026-03-13 04:33:52.279889','Building A, Floor 3','Active','Level 1',1,0),(5,'Dr. Sakthi','MD-33567','General Surgery',5,'','',0,'2026-03-16 05:05:49.832356','Building A, Floor 3','Active','Level 1',1,0),(6,'Dr. Aadithya','MD-12392','Urology',6,'','',0,'2026-03-17 04:43:23.735090','Building A, Floor 3','Active','Level 1',1,0),(7,'Dr. Aadithya','MD-5678','Urology',7,'','',0,'2026-03-17 16:31:31.571625','Building A, Floor 3','Active','Level 1',1,0),(8,'Dr. Karthick','MD-12342','Urology',8,'','',0,'2026-03-18 18:37:24.049296','Building A, Floor 3','Active','Level 1',1,0),(9,'Dr. Arun','MD-12347','Urology',9,'','',0,'2026-03-18 18:49:17.067557','Building A, Floor 3','Active','Level 1',1,0),(10,'Dr. Anbu','MD-1238','Urology',10,'','profile_pics/upload_image_Xeww3tK.jpg',0,'2026-03-22 08:30:36.814456','Building A, Floor 3','Active','Level 1',1,0),(11,'Dhanush','DIM45678','Urology',11,NULL,'',0,'2026-03-27 07:20:09.339863','Building A, Floor 3','Active','Level 1',1,0),(12,'Arun','MD132456','Urology',12,NULL,'',0,'2026-03-30 19:25:03.439329','Building A, Floor 3','Active','Level 1',1,0),(13,'Shivi','MDL1467','Urology',13,NULL,'',0,'2026-03-31 09:29:52.136195','Building A, Floor 3','Active','Level 1',1,0),(14,'Shiva','MDLK124578','Urology',14,NULL,'',0,'2026-04-01 09:25:53.063109','Building A, Floor 3','Active','Level 1',1,0),(15,'Aadithya','MHJ24567','Cardiology',15,NULL,'',0,'2026-04-02 18:41:39.798387','Building A, Floor 3','Active','Level 1',1,0),(16,'Sam','MGJ4678','General Surgery',16,NULL,'',0,'2026-04-03 05:23:18.672728','Building A, Floor 3','Active','Level 1',1,0);
/*!40000 ALTER TABLE `doctor_doctorprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_equipment`
--

DROP TABLE IF EXISTS `doctor_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_equipment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `serial_number` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL,
  `battery_level` int NOT NULL,
  `temperature` int NOT NULL,
  `signal_strength` varchar(20) NOT NULL,
  `last_calibration` datetime(6) DEFAULT NULL,
  `next_service_due` datetime(6) DEFAULT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial_number` (`serial_number`),
  KEY `doctor_equipment_doctor_id_b5ffd138_fk_doctor_doctorprofile_id` (`doctor_id`),
  CONSTRAINT `doctor_equipment_doctor_id_b5ffd138_fk_doctor_doctorprofile_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_equipment`
--

LOCK TABLES `doctor_equipment` WRITE;
/*!40000 ALTER TABLE `doctor_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_estimationresult`
--

DROP TABLE IF EXISTS `doctor_estimationresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_estimationresult` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `length` double NOT NULL,
  `width` double NOT NULL,
  `height` double NOT NULL,
  `volume` double NOT NULL,
  `recommendation` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `doctor_id` bigint NOT NULL,
  `patient_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_estimationres_doctor_id_2edb7a5c_fk_doctor_do` (`doctor_id`),
  KEY `doctor_estimationresult_patient_id_e9c87063_fk_doctor_patient_id` (`patient_id`),
  CONSTRAINT `doctor_estimationres_doctor_id_2edb7a5c_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`),
  CONSTRAINT `doctor_estimationresult_patient_id_e9c87063_fk_doctor_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `doctor_patient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_estimationresult`
--

LOCK TABLES `doctor_estimationresult` WRITE;
/*!40000 ALTER TABLE `doctor_estimationresult` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_estimationresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_feature`
--

DROP TABLE IF EXISTS `doctor_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_feature` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `icon_type` varchar(50) NOT NULL,
  `app_info_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_feature_app_info_id_21a69620_fk_doctor_appinfo_id` (`app_info_id`),
  CONSTRAINT `doctor_feature_app_info_id_21a69620_fk_doctor_appinfo_id` FOREIGN KEY (`app_info_id`) REFERENCES `doctor_appinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_feature`
--

LOCK TABLES `doctor_feature` WRITE;
/*!40000 ALTER TABLE `doctor_feature` DISABLE KEYS */;
INSERT INTO `doctor_feature` VALUES (1,'HIPAA Compliant','Enterprise-grade security','hipaa',1),(2,'FDA Cleared','Clinically validated technology','fda',1),(3,'Team Collaboration','Multi-user support','team',1);
/*!40000 ALTER TABLE `doctor_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_feedback`
--

DROP TABLE IF EXISTS `doctor_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `feedback_type` varchar(50) NOT NULL,
  `message` longtext NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_feedback_doctor_id_06c4640d_fk_doctor_doctorprofile_id` (`doctor_id`),
  CONSTRAINT `doctor_feedback_doctor_id_06c4640d_fk_doctor_doctorprofile_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_feedback`
--

LOCK TABLES `doctor_feedback` WRITE;
/*!40000 ALTER TABLE `doctor_feedback` DISABLE KEYS */;
INSERT INTO `doctor_feedback` VALUES (1,'Bug Report','wiso',NULL,'2026-03-22 08:30:49.133841',10),(2,'App Performance','The app\'s performance was good',NULL,'2026-03-22 08:31:22.246006',10),(3,'Bug Report','There was small bug in the app',NULL,'2026-03-22 14:22:47.210953',10);
/*!40000 ALTER TABLE `doctor_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_helparticle`
--

DROP TABLE IF EXISTS `doctor_helparticle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_helparticle` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `category` varchar(100) NOT NULL,
  `is_popular` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_helparticle`
--

LOCK TABLES `doctor_helparticle` WRITE;
/*!40000 ALTER TABLE `doctor_helparticle` DISABLE KEYS */;
INSERT INTO `doctor_helparticle` VALUES (1,'Getting Started with BladSense','To get started with BladSense, first ensure your device is charged and connected via Bluetooth. Open the app and follow the on-screen instructions to create your account.','Basics',1,'2026-03-03 09:19:19.819698'),(2,'How to Perform a Scan','Applying ultrasound gel to the probe. Place the probe on the lower abdomen. Follow the real-time AI guidance for optimal bladder alignment.','Scanning',1,'2026-03-03 09:19:19.890300'),(3,'Understanding Volume Measurements','The AI calculates volume based on longitudinal and transverse planes. High volume triggers alert based on medical guidelines.','Results',1,'2026-03-03 09:19:19.895288'),(4,'Interpreting AI Results','AI results provide estimates and quality scores. Always consult with clinical judgment before taking action.','Results',1,'2026-03-03 09:19:19.898280'),(5,'Patient Data Management','All patient data is encrypted and HIPAA compliant. You can export data for offline review at any time.','Data',1,'2026-03-03 09:19:19.902269'),(6,'Troubleshooting Connectivity','If the probe fails to connect, restart the Bluetooth on your phone and ensure no other device is paired with the probe.','Troubleshooting',0,'2026-03-03 09:19:19.939552');
/*!40000 ALTER TABLE `doctor_helparticle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_notification`
--

DROP TABLE IF EXISTS `doctor_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_notification_doctor_id_96a98c0e_fk_doctor_do` (`doctor_id`),
  CONSTRAINT `doctor_notification_doctor_id_96a98c0e_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_notification`
--

LOCK TABLES `doctor_notification` WRITE;
/*!40000 ALTER TABLE `doctor_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_passwordresettoken`
--

DROP TABLE IF EXISTS `doctor_passwordresettoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_passwordresettoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_used` tinyint(1) NOT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_passwordreset_doctor_id_f0c92cd6_fk_doctor_do` (`doctor_id`),
  CONSTRAINT `doctor_passwordreset_doctor_id_f0c92cd6_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_passwordresettoken`
--

LOCK TABLES `doctor_passwordresettoken` WRITE;
/*!40000 ALTER TABLE `doctor_passwordresettoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_passwordresettoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_patient`
--

DROP TABLE IF EXISTS `doctor_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_patient` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `patient_id` varchar(50) NOT NULL,
  `age` int NOT NULL,
  `gender` varchar(20) NOT NULL,
  `doctor_id` bigint NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `is_archived` tinyint(1) NOT NULL,
  `condition` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `patient_id` (`patient_id`),
  KEY `doctor_patient_doctor_id_f8a092a6_fk_doctor_doctorprofile_id` (`doctor_id`),
  CONSTRAINT `doctor_patient_doctor_id_f8a092a6_fk_doctor_doctorprofile_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_patient`
--

LOCK TABLES `doctor_patient` WRITE;
/*!40000 ALTER TABLE `doctor_patient` DISABLE KEYS */;
INSERT INTO `doctor_patient` VALUES (1,'James Wilson','P-001',45,'Male',1,NULL,0,NULL),(2,'Sarah Connor','P-002',32,'Female',1,NULL,0,NULL),(3,'Robert Smith','P-003',58,'Male',1,NULL,0,NULL),(4,'Default Patient','P-277B',30,'Unknown',4,NULL,0,NULL),(5,'Ranjith','P-A13E',30,'Male',5,NULL,0,NULL),(6,'Ranjith','P-A8C9',30,'Male',6,NULL,0,NULL),(7,'Ranjith','P-5775',30,'Male',7,NULL,0,NULL),(8,'Ranjith','P-CF4F',30,'Male',10,NULL,0,NULL),(9,'Ranjith','P-1F6C',30,'Male',13,NULL,0,''),(10,'New Patient','P-DD27',30,'Unknown',14,NULL,0,NULL),(11,'Ranjith','P-1695',35,'Male',15,NULL,0,'Catheter needed .'),(12,'Niti','P-3M5MSV',23,'Male',15,'9884681853',0,'Catheter needed'),(13,'Sam','P-K7J4EH',34,'Male',15,'9884681853',0,'Catheter needed'),(14,'Nitish','P-C434CB',30,'Male',16,NULL,0,''),(15,'Aadi','P-BF84880',30,'Male',16,NULL,0,''),(16,'Vimal','P-9A785FF',30,'Male',16,NULL,0,'');
/*!40000 ALTER TABLE `doctor_patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_privacypolicy`
--

DROP TABLE IF EXISTS `doctor_privacypolicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_privacypolicy` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `last_updated` date NOT NULL,
  `version` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_privacypolicy`
--

LOCK TABLES `doctor_privacypolicy` WRITE;
/*!40000 ALTER TABLE `doctor_privacypolicy` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_privacypolicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_recommendation`
--

DROP TABLE IF EXISTS `doctor_recommendation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_recommendation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `category` varchar(100) NOT NULL,
  `icon_name` varchar(50) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_recommendation`
--

LOCK TABLES `doctor_recommendation` WRITE;
/*!40000 ALTER TABLE `doctor_recommendation` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_recommendation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_scanreport`
--

DROP TABLE IF EXISTS `doctor_scanreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_scanreport` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `report_id` varchar(50) NOT NULL,
  `scan_date` date NOT NULL,
  `volume` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `patient_id` bigint NOT NULL,
  `drawing_image` varchar(100) DEFAULT NULL,
  `notes` longtext,
  `scan_image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `report_id` (`report_id`),
  KEY `doctor_scanreport_patient_id_dbdac732_fk_doctor_patient_id` (`patient_id`),
  CONSTRAINT `doctor_scanreport_patient_id_dbdac732_fk_doctor_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `doctor_patient` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_scanreport`
--

LOCK TABLES `doctor_scanreport` WRITE;
/*!40000 ALTER TABLE `doctor_scanreport` DISABLE KEYS */;
INSERT INTO `doctor_scanreport` VALUES (1,'R-8904BC','2026-03-13','480 ml','Distended',4,'','AI Level: High. AI Analysis Scan','scans/scan_1875973082265806504.jpg'),(2,'R-AEB4CD','2026-03-16','519 ml','Distended',5,'','AI Level: High. AI Analysis Scan','scans/scan_2372719331260692167.jpg'),(3,'R-7391DD','2026-03-16','519 ml','Distended',5,'','AI Level: High. AI Analysis Scan','scans/scan_7073360797360582613.jpg'),(4,'R-375B9F','2026-03-16','519 ml','Distended',5,'','AI Level: High. AI Analysis Scan','scans/scan_7521153127776096156.jpg'),(5,'R-6B1F72','2026-03-17','553 ml','Distended',6,'','AI Level: High. AI Analysis Scan','scans/scan_1505741168570248539.jpg'),(6,'R-B2623E','2026-03-17','519 ml','Distended',5,'','AI Level: High. AI Analysis Scan','scans/scan_8569214904319463005.jpg'),(7,'R-34A03A','2026-03-17','519 ml','Distended',7,'','AI Level: High. AI Analysis Scan','scans/scan_5917602644264901887.jpg'),(8,'R-CE9E2F','2026-03-22','519 ml','Distended',8,'','AI Level: High. AI Analysis Scan','scans/scan_7157924625055018764.jpg'),(9,'R-3E86A2','2026-03-23','597 ml','Distended',8,'','AI Level: High. AI Analysis Scan','scans/scan_8674209117179370137.jpg'),(10,'R-542189','2026-04-01','597 ml','Distended',9,'','AI Level: High. AI Analysis Scan','scans/scan_1606496255144269599.jpg'),(11,'R-9E57B9','2026-04-01','598 ml','Distended',9,'','AI Level: High. AI Analysis Scan','scans/scan_217541510452947333.jpg'),(12,'R-73311B','2026-04-01','519 ml','Distended',9,'','AI Level: High. AI Analysis Scan','scans/scan_1010574031180373325.jpg'),(13,'R-D5B975','2026-04-01','580 ml','Distended',9,'','AI Level: High. AI Analysis Scan','scans/scan_1292197177443173042.jpg'),(14,'R-E2701C','2026-04-01','598 ml','Distended',10,'','AI Level: High. AI Analysis Scan','scans/scan_2372394638021435310.jpg'),(15,'R-B6D72C','2026-04-01','84 ml','Normal',10,'','AI Level: Low. AI Analysis Scan','scans/scan_7072082205548792841.jpg'),(16,'R-343277','2026-04-03','545 ml','Distended',11,'','AI Level: High. AI Analysis Scan','scans/scan_6554752849134462678.jpg'),(17,'R-1EE3F5','2026-04-03','599 ml','Distended',11,'','AI Level: High. AI Analysis Scan','scans/scan_43510156927454275.jpg'),(18,'R-5B6006','2026-04-03','598 ml','Distended',11,'','AI Level: High. AI Analysis Scan','scans/scan_6872010633238511835.jpg'),(19,'R-103C98','2026-04-03','597 ml','Distended',11,'','AI Level: High. AI Analysis Scan','scans/scan_312352726059720586.jpg'),(20,'R-B9EA13','2026-04-03','84 ml','Normal',11,'','AI Level: Low. AI Analysis Scan','scans/scan_5955510427982150526.jpg'),(21,'R-B4B265','2026-04-03','598 ml','Distended',11,'','AI Level: High. AI Analysis Scan','scans/scan_7369307398303781591.jpg'),(22,'R-ECF460','2026-04-03','597 ml','Distended',11,'','AI Level: High. AI Analysis Scan','scans/scan_7759094779935672212.jpg'),(23,'R-F46BB5','2026-04-03','96 ml','Normal',11,'','AI Level: Low. AI Analysis Scan','scans/scan_6697479361872428488.jpg'),(24,'R-900418','2026-04-03','96 ml','Normal',11,'','AI Level: Low. AI Analysis Scan','scans/scan_5468378854348098582.jpg'),(25,'R-C32553','2026-04-03','96 ml','Normal',11,'','AI Level: Low. AI Analysis Scan','scans/scan_4959467957856912321.jpg'),(26,'R-55695E','2026-04-03','96 ml','Normal',11,'','AI Level: Low. AI Analysis Scan','scans/scan_3160198924515605360.jpg'),(27,'R-E07DF1','2026-04-03','597 ml','Distended',11,'','AI Level: High. AI Analysis Scan','scans/scan_3311794007246339437.jpg'),(28,'R-E1BC0A','2026-04-03','597 ml','Distended',14,'','AI Level: High. AI Analysis Scan','scans/scan_3198832206925859418.jpg'),(29,'R-08652A','2026-04-03','598 ml','Distended',15,'','AI Level: High. AI Analysis Scan','scans/scan_8894458106618817496.jpg'),(30,'R-9668FA','2026-04-03','598 ml','Distended',16,'','AI Level: High. AI Analysis Scan','scans/scan_1833532433660608950.jpg');
/*!40000 ALTER TABLE `doctor_scanreport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_scanvalidation`
--

DROP TABLE IF EXISTS `doctor_scanvalidation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_scanvalidation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `quality_score` double NOT NULL,
  `quality_label` varchar(50) NOT NULL,
  `feedback_message` longtext NOT NULL,
  `is_processed` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `doctor_id` bigint NOT NULL,
  `view_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_scanvalidatio_doctor_id_3b421548_fk_doctor_do` (`doctor_id`),
  CONSTRAINT `doctor_scanvalidatio_doctor_id_3b421548_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_scanvalidation`
--

LOCK TABLES `doctor_scanvalidation` WRITE;
/*!40000 ALTER TABLE `doctor_scanvalidation` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_scanvalidation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_supportmessage`
--

DROP TABLE IF EXISTS `doctor_supportmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_supportmessage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_resolved` tinyint(1) NOT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_supportmessag_doctor_id_ec4446a0_fk_doctor_do` (`doctor_id`),
  CONSTRAINT `doctor_supportmessag_doctor_id_ec4446a0_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_supportmessage`
--

LOCK TABLES `doctor_supportmessage` WRITE;
/*!40000 ALTER TABLE `doctor_supportmessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_supportmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_teaminvitation`
--

DROP TABLE IF EXISTS `doctor_teaminvitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_teaminvitation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `role` varchar(100) NOT NULL,
  `licenseNumber` varchar(100) NOT NULL,
  `specialty` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `inviter_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_teaminvitatio_inviter_id_200c6d29_fk_doctor_do` (`inviter_id`),
  CONSTRAINT `doctor_teaminvitatio_inviter_id_200c6d29_fk_doctor_do` FOREIGN KEY (`inviter_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_teaminvitation`
--

LOCK TABLES `doctor_teaminvitation` WRITE;
/*!40000 ALTER TABLE `doctor_teaminvitation` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_teaminvitation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_teammember`
--

DROP TABLE IF EXISTS `doctor_teammember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_teammember` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fullName` varchar(255) NOT NULL,
  `staff_id` varchar(50) NOT NULL,
  `role` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `years_of_experience` int NOT NULL,
  `total_scans` int NOT NULL,
  `accuracy_pct` int NOT NULL,
  `total_patients` int NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `location` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `staff_id` (`staff_id`),
  KEY `doctor_teammember_doctor_id_df91e024_fk_doctor_doctorprofile_id` (`doctor_id`),
  CONSTRAINT `doctor_teammember_doctor_id_df91e024_fk_doctor_doctorprofile_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_teammember`
--

LOCK TABLES `doctor_teammember` WRITE;
/*!40000 ALTER TABLE `doctor_teammember` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_teammember` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_trainingmodule`
--

DROP TABLE IF EXISTS `doctor_trainingmodule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_trainingmodule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `description` longtext NOT NULL,
  `video_url` varchar(200) DEFAULT NULL,
  `takeaways` json NOT NULL,
  `duration_minutes` int NOT NULL,
  `order` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_trainingmodule`
--

LOCK TABLES `doctor_trainingmodule` WRITE;
/*!40000 ALTER TABLE `doctor_trainingmodule` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_trainingmodule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_trainingprogress`
--

DROP TABLE IF EXISTS `doctor_trainingprogress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_trainingprogress` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_completed` tinyint(1) NOT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `doctor_id` bigint NOT NULL,
  `module_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doctor_trainingprogress_doctor_id_module_id_6c78b9ba_uniq` (`doctor_id`,`module_id`),
  KEY `doctor_trainingprogr_module_id_6297ca46_fk_doctor_tr` (`module_id`),
  CONSTRAINT `doctor_trainingprogr_doctor_id_c8b44fd8_fk_doctor_do` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`),
  CONSTRAINT `doctor_trainingprogr_module_id_6297ca46_fk_doctor_tr` FOREIGN KEY (`module_id`) REFERENCES `doctor_trainingmodule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_trainingprogress`
--

LOCK TABLES `doctor_trainingprogress` WRITE;
/*!40000 ALTER TABLE `doctor_trainingprogress` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_trainingprogress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_usersession`
--

DROP TABLE IF EXISTS `doctor_usersession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_usersession` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `device_name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `last_active` datetime(6) NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  `doctor_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_usersession_doctor_id_62bd093b_fk_doctor_doctorprofile_id` (`doctor_id`),
  CONSTRAINT `doctor_usersession_doctor_id_62bd093b_fk_doctor_doctorprofile_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor_doctorprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_usersession`
--

LOCK TABLES `doctor_usersession` WRITE;
/*!40000 ALTER TABLE `doctor_usersession` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_usersession` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-06 11:59:58
