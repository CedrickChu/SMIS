-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: smis
-- ------------------------------------------------------
-- Server version	8.3.0

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
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add grade level',7,'add_gradelevel'),(26,'Can change grade level',7,'change_gradelevel'),(27,'Can delete grade level',7,'delete_gradelevel'),(28,'Can view grade level',7,'view_gradelevel'),(29,'Can add parent guardian',8,'add_parentguardian'),(30,'Can change parent guardian',8,'change_parentguardian'),(31,'Can delete parent guardian',8,'delete_parentguardian'),(32,'Can view parent guardian',8,'view_parentguardian'),(33,'Can add school',9,'add_school'),(34,'Can change school',9,'change_school'),(35,'Can delete school',9,'delete_school'),(36,'Can view school',9,'view_school'),(37,'Can add school year',10,'add_schoolyear'),(38,'Can change school year',10,'change_schoolyear'),(39,'Can delete school year',10,'delete_schoolyear'),(40,'Can view school year',10,'view_schoolyear'),(41,'Can add teacher',11,'add_teacher'),(42,'Can change teacher',11,'change_teacher'),(43,'Can delete teacher',11,'delete_teacher'),(44,'Can view teacher',11,'view_teacher'),(45,'Can add user profile',12,'add_userprofile'),(46,'Can change user profile',12,'change_userprofile'),(47,'Can delete user profile',12,'delete_userprofile'),(48,'Can view user profile',12,'view_userprofile'),(49,'Can add academic record',13,'add_academicrecord'),(50,'Can change academic record',13,'change_academicrecord'),(51,'Can delete academic record',13,'delete_academicrecord'),(52,'Can view academic record',13,'view_academicrecord'),(53,'Can add section',14,'add_section'),(54,'Can change section',14,'change_section'),(55,'Can delete section',14,'delete_section'),(56,'Can view section',14,'view_section'),(57,'Can add student',15,'add_student'),(58,'Can change student',15,'change_student'),(59,'Can delete student',15,'delete_student'),(60,'Can view student',15,'view_student'),(61,'Can add form137',16,'add_form137'),(62,'Can change form137',16,'change_form137'),(63,'Can delete form137',16,'delete_form137'),(64,'Can view form137',16,'view_form137'),(65,'Can add subject',17,'add_subject'),(66,'Can change subject',17,'change_subject'),(67,'Can delete subject',17,'delete_subject'),(68,'Can view subject',17,'view_subject'),(69,'Can add Student Year Information',18,'add_studentyearinfo'),(70,'Can change Student Year Information',18,'change_studentyearinfo'),(71,'Can delete Student Year Information',18,'delete_studentyearinfo'),(72,'Can view Student Year Information',18,'view_studentyearinfo'),(73,'Can add Total Grade Subject',19,'add_totalgradesubject'),(74,'Can change Total Grade Subject',19,'change_totalgradesubject'),(75,'Can delete Total Grade Subject',19,'delete_totalgradesubject'),(76,'Can view Total Grade Subject',19,'view_totalgradesubject'),(77,'Can add payment',20,'add_payment'),(78,'Can change payment',20,'change_payment'),(79,'Can delete payment',20,'delete_payment'),(80,'Can view payment',20,'view_payment'),(81,'Can add event category',21,'add_eventcategory'),(82,'Can change event category',21,'change_eventcategory'),(83,'Can delete event category',21,'delete_eventcategory'),(84,'Can view event category',21,'view_eventcategory'),(85,'Can add event',22,'add_event'),(86,'Can change event',22,'change_event'),(87,'Can delete event',22,'delete_event'),(88,'Can view event',22,'view_event'),(89,'Can add student info',23,'add_studentinfo'),(90,'Can change student info',23,'change_studentinfo'),(91,'Can delete student info',23,'delete_studentinfo'),(92,'Can view student info',23,'view_studentinfo');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
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
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_projectapp_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_projectapp_user_id` FOREIGN KEY (`user_id`) REFERENCES `projectapp_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-07-04 10:19:43.190763','1','SCHOOL EXAMPLE 1',1,'[{\"added\": {}}]',9,1),(2,'2024-07-04 10:19:59.170933','1','Nursery 1',1,'[{\"added\": {}}]',7,1),(3,'2024-07-04 10:20:03.092665','2','Nursery 2',1,'[{\"added\": {}}]',7,1),(4,'2024-07-04 10:20:07.249405','3','Grade 1',1,'[{\"added\": {}}]',7,1),(5,'2024-07-04 10:20:09.635099','4','Grade 2',1,'[{\"added\": {}}]',7,1),(6,'2024-07-04 10:20:11.815183','5','Grade 3',1,'[{\"added\": {}}]',7,1),(7,'2024-07-04 10:20:14.229985','6','Grade 4',1,'[{\"added\": {}}]',7,1),(8,'2024-07-04 10:20:16.528266','7','Grade 5',1,'[{\"added\": {}}]',7,1),(9,'2024-07-04 10:20:18.637655','8','Grade 6',1,'[{\"added\": {}}]',7,1),(10,'2024-07-04 10:20:54.550415','1','Teacher Example 1 Teacher Example 1',1,'[{\"added\": {}}]',11,1),(11,'2024-07-04 10:21:06.551735','2','Teacher Example 2 Teacher Example 2',1,'[{\"added\": {}}]',11,1),(12,'2024-07-04 10:21:22.554116','1','Section 1',1,'[{\"added\": {}}]',14,1),(13,'2024-07-04 10:21:33.857488','2','Section 2',1,'[{\"added\": {}}]',14,1),(14,'2024-07-04 10:22:20.862316','1','Parent 1 Parent 1',1,'[{\"added\": {}}]',8,1),(15,'2024-07-04 10:22:22.777416','1','Cedrick Chu',1,'[{\"added\": {}}]',15,1),(16,'2024-07-04 10:23:27.031980','1','Math',1,'[{\"added\": {}}]',17,1),(17,'2024-07-04 10:23:36.295692','2','Science',1,'[{\"added\": {}}]',17,1),(18,'2024-07-04 10:23:42.150119','3','English',1,'[{\"added\": {}}]',17,1),(19,'2024-07-04 10:24:27.457966','1','2020-2021',1,'[{\"added\": {}}]',10,1),(20,'2024-07-04 10:24:51.993225','2','2021-2022',1,'[{\"added\": {}}]',10,1),(21,'2024-07-05 15:59:42.680625','16','ced123 ced123',1,'[{\"added\": {}}]',8,1),(22,'2024-07-06 09:20:58.591576','19','12312321 123123',3,'',8,1),(23,'2024-07-06 09:20:58.602192','18','12321321 123123213',3,'',8,1),(24,'2024-07-06 09:20:58.611573','17','ced12321 ced12321',3,'',8,1),(25,'2024-07-06 09:20:58.619769','16','ced123 ced123',3,'',8,1),(26,'2024-07-06 09:20:58.630537','15','ced3 ced3',3,'',8,1),(27,'2024-07-06 09:20:58.642830','14','ced2 ced2',3,'',8,1),(28,'2024-07-06 09:20:58.648841','13','ced ced',3,'',8,1),(29,'2024-07-06 09:20:58.660849','12','asdsa dasdsa',3,'',8,1),(30,'2024-07-06 12:20:56.364289','39','Analisa Deximo',3,'',8,1),(31,'2024-07-06 12:20:56.371291','38','Analisa Deximo',3,'',8,1),(32,'2024-07-06 12:20:56.380292','37','Analisa Deximo',3,'',8,1),(33,'2024-07-06 12:20:56.391629','36','Analisa Deximo',3,'',8,1),(34,'2024-07-06 12:20:56.399115','35','Analisa Deximo',3,'',8,1),(35,'2024-07-06 12:20:56.409537','34','Analisa Deximo',3,'',8,1),(36,'2024-07-06 12:20:56.421562','33','Analisa Deximo',3,'',8,1),(37,'2024-07-06 12:20:56.431271','32','Analisa Deximo',3,'',8,1),(38,'2024-07-06 12:20:56.438716','31','Analisa Deximo',3,'',8,1),(39,'2024-07-06 12:20:56.447713','30','Analisa Deximo',3,'',8,1),(40,'2024-07-06 12:20:56.456277','29','Analisa Deximo',3,'',8,1),(41,'2024-07-07 13:21:36.294135','27','Aeron Francis Jose',2,'[]',15,1),(42,'2024-07-07 13:21:49.680891','44','Joseph Froilan Jose',2,'[]',8,1),(43,'2024-07-08 11:58:39.630360','3','Teacher 1',2,'[{\"changed\": {\"fields\": [\"First name\", \"Middle name\", \"Last name\", \"Address\", \"Contact information\"]}}]',11,1),(44,'2024-07-08 11:59:16.394264','1','Teacher 2',2,'[{\"changed\": {\"fields\": [\"First name\", \"Middle name\", \"Last name\", \"Address\", \"Contact information\"]}}]',11,1),(45,'2024-07-08 11:59:34.290601','2','Teacher 3',2,'[{\"changed\": {\"fields\": [\"First name\", \"Middle name\", \"Last name\", \"Address\", \"Contact information\"]}}]',11,1),(46,'2024-07-08 12:15:20.319360','3','Teacher 1',2,'[{\"changed\": {\"fields\": [\"Supervisor\"]}}]',11,1),(47,'2024-07-08 12:15:27.874974','3','Teacher 1',2,'[]',11,1),(48,'2024-07-08 12:15:42.909862','3','Teacher 1',2,'[]',11,1),(49,'2024-07-08 12:15:50.045966','1','Teacher 2',2,'[{\"changed\": {\"fields\": [\"Supervisor\"]}}]',11,1),(50,'2024-07-08 12:15:53.252189','2','Teacher 3',2,'[{\"changed\": {\"fields\": [\"Supervisor\"]}}]',11,1),(51,'2024-07-08 12:15:57.174104','3','Teacher 1',2,'[{\"changed\": {\"fields\": [\"Supervisor\"]}}]',11,1),(52,'2024-07-08 12:27:05.083870','3','Teacher 1',2,'[{\"changed\": {\"fields\": [\"Position\", \"Manager\"]}}]',11,1),(53,'2024-07-08 12:27:10.272830','1','Teacher 2',2,'[{\"changed\": {\"fields\": [\"Position\", \"Manager\"]}}]',11,1),(54,'2024-07-08 12:27:15.881136','2','Teacher 3',2,'[{\"changed\": {\"fields\": [\"Position\"]}}]',11,1),(55,'2024-07-10 11:48:55.710766','6','Grade 3',3,'',7,1),(56,'2024-07-10 11:51:08.408204','8','StudentInfo object (8)',2,'[{\"changed\": {\"fields\": [\"Grade level\"]}}]',23,1),(57,'2024-07-10 14:42:24.479046','157','123 123',3,'',8,1),(58,'2024-07-10 14:42:24.487338','156','1231 123',3,'',8,1),(59,'2024-07-10 14:42:24.493988','155','213 123',3,'',8,1),(60,'2024-07-10 14:42:24.501046','154','123 123',3,'',8,1),(61,'2024-07-10 14:42:24.512912','153','23 123',3,'',8,1),(62,'2024-07-10 14:42:24.522974','152','123 123',3,'',8,1),(63,'2024-07-10 14:42:24.529628','151','123 123',3,'',8,1),(64,'2024-07-10 14:42:24.537990','150','123 123',3,'',8,1),(65,'2024-07-10 14:42:24.546347','149','123 123',3,'',8,1),(66,'2024-07-10 14:42:24.555522','148','213 21',3,'',8,1),(67,'2024-07-10 14:42:24.565338','147','3213 213',3,'',8,1),(68,'2024-07-10 14:42:24.574305','146','123 123',3,'',8,1),(69,'2024-07-10 14:42:24.581918','145','3213 213',3,'',8,1),(70,'2024-07-10 14:42:24.590551','144','321 321',3,'',8,1),(71,'2024-07-10 14:42:24.598561','143','321 321',3,'',8,1),(72,'2024-07-10 14:42:24.608545','142','123 123',3,'',8,1),(73,'2024-07-10 14:42:24.617087','141','123 123',3,'',8,1),(74,'2024-07-10 14:42:24.624487','140','123 123',3,'',8,1),(75,'2024-07-10 14:42:24.634945','139','123 123',3,'',8,1),(76,'2024-07-10 14:42:24.641354','138','321 321',3,'',8,1),(77,'2024-07-10 14:42:24.648549','137','123 123',3,'',8,1),(78,'2024-07-10 14:42:24.658397','136','123 123',3,'',8,1),(79,'2024-07-10 14:42:24.665628','135','123 123',3,'',8,1),(80,'2024-07-10 14:42:24.672480','134','123 123',3,'',8,1),(81,'2024-07-10 14:42:24.682732','133','123 123',3,'',8,1),(82,'2024-07-10 14:42:24.719149','132','123 123',3,'',8,1),(83,'2024-07-10 14:42:24.750235','131','123 123',3,'',8,1),(84,'2024-07-10 14:42:24.764581','130','321 321',3,'',8,1),(85,'2024-07-10 14:42:24.776103','129','123 123',3,'',8,1),(86,'2024-07-10 14:42:24.782501','128','321 321',3,'',8,1),(87,'2024-07-10 14:42:24.789129','127','123 123',3,'',8,1),(88,'2024-07-10 14:42:24.799569','126','123 123',3,'',8,1),(89,'2024-07-10 14:42:24.805933','125','123 23',3,'',8,1),(90,'2024-07-10 14:42:24.814163','124','123 23',3,'',8,1),(91,'2024-07-10 14:42:24.820570','123','123 123',3,'',8,1),(92,'2024-07-10 14:42:24.826586','122','123 123',3,'',8,1),(93,'2024-07-10 14:42:24.836583','121','321 321',3,'',8,1),(94,'2024-07-10 14:42:24.845574','120','123 123',3,'',8,1),(95,'2024-07-10 14:42:24.856231','119','321 321',3,'',8,1),(96,'2024-07-10 14:42:24.864965','118','321 321',3,'',8,1),(97,'2024-07-10 14:42:24.874980','117','321 321',3,'',8,1),(98,'2024-07-10 14:42:24.881531','116','321 321',3,'',8,1),(99,'2024-07-10 14:42:24.889810','115','321 321',3,'',8,1),(100,'2024-07-10 14:42:24.896081','114','321 321',3,'',8,1),(101,'2024-07-10 14:42:24.908557','113','321 321',3,'',8,1),(102,'2024-07-10 14:42:24.916214','112','123 123',3,'',8,1),(103,'2024-07-10 14:42:24.925094','111','123 123',3,'',8,1),(104,'2024-07-10 14:42:24.934597','110','321 321',3,'',8,1),(105,'2024-07-10 14:42:24.941071','109','321 321',3,'',8,1),(106,'2024-07-10 14:42:24.950075','108','321 321',3,'',8,1),(107,'2024-07-10 14:42:24.958220','107','213 123',3,'',8,1),(108,'2024-07-10 14:42:24.966465','106','123 123',3,'',8,1),(109,'2024-07-10 14:42:24.973861','105','123 123',3,'',8,1),(110,'2024-07-10 14:42:24.979888','104','123 123',3,'',8,1),(111,'2024-07-10 14:42:24.986504','103','123 123',3,'',8,1),(112,'2024-07-10 14:42:24.995602','102','321 321',3,'',8,1),(113,'2024-07-10 14:42:25.003469','101','321 321',3,'',8,1),(114,'2024-07-10 14:42:25.012609','100','321 321',3,'',8,1),(115,'2024-07-10 14:42:25.020506','99','321 321',3,'',8,1),(116,'2024-07-10 14:42:25.032615','95','123 123',3,'',8,1),(117,'2024-07-10 14:42:25.041039','94','123 1231',3,'',8,1),(118,'2024-07-10 14:42:25.050009','91','asda sda',3,'',8,1),(119,'2024-07-10 14:42:25.059366','90','123 123',3,'',8,1),(120,'2024-07-10 14:42:25.065609','87','123 123',3,'',8,1),(121,'2024-07-10 14:42:25.072643','86','321 321',3,'',8,1),(122,'2024-07-10 14:42:25.082230','85','321 321',3,'',8,1),(123,'2024-07-12 03:53:53.025404','1','Cedrick Chu - Science - 2020-2021 (2020-2021)',1,'[{\"added\": {}}]',13,1),(124,'2024-07-12 03:53:57.613938','1','Cedrick Chu - Science - 2020-2021 (2020-2021)',2,'[]',13,1),(125,'2024-07-12 03:54:44.109173','1','Cedrick Chu - Grade Nursery - 2020-2021 (2020-2021)',1,'[{\"added\": {}}]',18,1),(126,'2024-07-12 03:54:56.110120','1','Cedrick Chu - Math - 2020-2021 (2020-2021)',1,'[{\"added\": {}}]',19,1),(127,'2024-07-12 08:53:03.599608','1','admin',1,'[{\"added\": {}}]',12,1),(128,'2024-07-12 09:34:17.017247','1','admin@gmail.com',2,'[{\"changed\": {\"fields\": [\"First name\", \"Middle name\", \"Last name\"]}}]',6,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(13,'projectapp','academicrecord'),(22,'projectapp','event'),(21,'projectapp','eventcategory'),(16,'projectapp','form137'),(7,'projectapp','gradelevel'),(8,'projectapp','parentguardian'),(20,'projectapp','payment'),(9,'projectapp','school'),(10,'projectapp','schoolyear'),(14,'projectapp','section'),(15,'projectapp','student'),(23,'projectapp','studentinfo'),(18,'projectapp','studentyearinfo'),(17,'projectapp','subject'),(11,'projectapp','teacher'),(19,'projectapp','totalgradesubject'),(6,'projectapp','user'),(12,'projectapp','userprofile'),(5,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-07-04 10:18:06.655992'),(2,'contenttypes','0002_remove_content_type_name','2024-07-04 10:18:06.877054'),(3,'auth','0001_initial','2024-07-04 10:18:07.790865'),(4,'auth','0002_alter_permission_name_max_length','2024-07-04 10:18:07.934052'),(5,'auth','0003_alter_user_email_max_length','2024-07-04 10:18:07.945905'),(6,'auth','0004_alter_user_username_opts','2024-07-04 10:18:07.956309'),(7,'auth','0005_alter_user_last_login_null','2024-07-04 10:18:07.967320'),(8,'auth','0006_require_contenttypes_0002','2024-07-04 10:18:07.975314'),(9,'auth','0007_alter_validators_add_error_messages','2024-07-04 10:18:07.988363'),(10,'auth','0008_alter_user_username_max_length','2024-07-04 10:18:08.001366'),(11,'auth','0009_alter_user_last_name_max_length','2024-07-04 10:18:08.014396'),(12,'auth','0010_alter_group_name_max_length','2024-07-04 10:18:08.043432'),(13,'auth','0011_update_proxy_permissions','2024-07-04 10:18:08.055465'),(14,'auth','0012_alter_user_first_name_max_length','2024-07-04 10:18:08.068511'),(15,'projectapp','0001_initial','2024-07-04 10:18:13.518574'),(16,'admin','0001_initial','2024-07-04 10:18:13.940781'),(17,'admin','0002_logentry_remove_auto_add','2024-07-04 10:18:13.952196'),(18,'admin','0003_logentry_add_action_flag_choices','2024-07-04 10:18:13.966200'),(19,'sessions','0001_initial','2024-07-04 10:18:14.059027'),(20,'projectapp','0002_payment','2024-07-05 02:57:14.432277'),(21,'projectapp','0003_eventcategory_event','2024-07-05 06:42:43.193485'),(22,'projectapp','0004_remove_student_grade_level_studentinfo','2024-07-05 09:47:13.367376'),(23,'projectapp','0005_schoolyear_status','2024-07-05 10:22:23.528437'),(24,'projectapp','0006_alter_parentguardian_middle_name','2024-07-06 10:36:17.243595'),(25,'projectapp','0007_alter_student_middle_name_alter_teacher_middle_name','2024-07-07 13:15:01.127475'),(26,'projectapp','0008_teacher_supervisor','2024-07-08 12:14:35.032099'),(27,'projectapp','0009_remove_teacher_supervisor_teacher_manager_and_more','2024-07-08 12:21:14.170273'),(28,'projectapp','0010_remove_teacher_manager_remove_teacher_position','2024-07-10 08:50:54.475046'),(29,'projectapp','0002_remove_user_about_remove_user_phone','2024-07-12 11:11:20.025321');
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
INSERT INTO `django_session` VALUES ('61it7l7luoeyq2yjtxwf73wjtwxmqlc0','.eJxVjDsOwjAQBe_iGll2_Kekzxms9e6CA8iR4qRC3B0ipYD2zcx7iQzbWvPWeckTibPQ4vS7FcAHtx3QHdptlji3dZmK3BV50C7Hmfh5Ody_gwq9fuuBi0OfuJir8dGQM86G5AwkBdqWqNlGNcRYAjITaVCeLHqjPIYUAcX7A9bKN6s:1sQ1k8:GFuGz00dfUx4NfzW2bg3k1cix17Y3b-SPVXxgK0333Q','2024-07-20 09:30:08.017873'),('nx0vyq9tyg8ie7q9703i30z4o69xn2bm','.eJxVjMsOwiAUBf-FtSFAL1x06d5vaA4PpWogKe3K-O_apAvdnpk5LzFiXcq49jyPUxInQeLwuwXER64bSHfUW5Ox1WWegtwUudMuLy3l53l3_w4KevnWyMHGYHIylqJzhr3TSuMayCji6NmTG9IRHjxoJEsMRFhWcOwtWfH-AOPeN24:1sSFjU:k8Ek8eYw_7Rs1LC39DCY4J2y8XQWS6F3rYB4axdHlck','2024-07-26 12:50:40.220206');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_academicrecord`
--

DROP TABLE IF EXISTS `projectapp_academicrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_academicrecord` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `grade` decimal(5,2) DEFAULT NULL,
  `school_year_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  `subject_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectapp_academicr_student_id_9938cc36_fk_projectap` (`student_id`),
  KEY `projectapp_academicr_subject_id_5abcc5dd_fk_projectap` (`subject_id`),
  KEY `projectapp_academicr_school_year_id_900c80c4_fk_projectap` (`school_year_id`),
  CONSTRAINT `projectapp_academicr_school_year_id_900c80c4_fk_projectap` FOREIGN KEY (`school_year_id`) REFERENCES `projectapp_schoolyear` (`id`),
  CONSTRAINT `projectapp_academicr_student_id_9938cc36_fk_projectap` FOREIGN KEY (`student_id`) REFERENCES `projectapp_student` (`id`),
  CONSTRAINT `projectapp_academicr_subject_id_5abcc5dd_fk_projectap` FOREIGN KEY (`subject_id`) REFERENCES `projectapp_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_academicrecord`
--

LOCK TABLES `projectapp_academicrecord` WRITE;
/*!40000 ALTER TABLE `projectapp_academicrecord` DISABLE KEYS */;
INSERT INTO `projectapp_academicrecord` VALUES (1,80.00,1,1,2);
/*!40000 ALTER TABLE `projectapp_academicrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_event`
--

DROP TABLE IF EXISTS `projectapp_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `note` varchar(500) NOT NULL,
  `color` varchar(20) NOT NULL,
  `start_date_time` datetime(6) NOT NULL,
  `end_date_time` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectapp_event_category_id_cdf8e49b_fk_projectap` (`category_id`),
  CONSTRAINT `projectapp_event_category_id_cdf8e49b_fk_projectap` FOREIGN KEY (`category_id`) REFERENCES `projectapp_eventcategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_event`
--

LOCK TABLES `projectapp_event` WRITE;
/*!40000 ALTER TABLE `projectapp_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `projectapp_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_eventcategory`
--

DROP TABLE IF EXISTS `projectapp_eventcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_eventcategory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_eventcategory`
--

LOCK TABLES `projectapp_eventcategory` WRITE;
/*!40000 ALTER TABLE `projectapp_eventcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `projectapp_eventcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_form137`
--

DROP TABLE IF EXISTS `projectapp_form137`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_form137` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_id` (`student_id`),
  KEY `projectapp_form137_school_id_127d8e9a_fk_projectapp_school_id` (`school_id`),
  CONSTRAINT `projectapp_form137_school_id_127d8e9a_fk_projectapp_school_id` FOREIGN KEY (`school_id`) REFERENCES `projectapp_school` (`id`),
  CONSTRAINT `projectapp_form137_student_id_3f75fc72_fk_projectapp_student_id` FOREIGN KEY (`student_id`) REFERENCES `projectapp_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_form137`
--

LOCK TABLES `projectapp_form137` WRITE;
/*!40000 ALTER TABLE `projectapp_form137` DISABLE KEYS */;
/*!40000 ALTER TABLE `projectapp_form137` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_form137_records`
--

DROP TABLE IF EXISTS `projectapp_form137_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_form137_records` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `form137_id` bigint NOT NULL,
  `academicrecord_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projectapp_form137_recor_form137_id_academicrecor_41940bd5_uniq` (`form137_id`,`academicrecord_id`),
  KEY `projectapp_form137_r_academicrecord_id_914152fb_fk_projectap` (`academicrecord_id`),
  CONSTRAINT `projectapp_form137_r_academicrecord_id_914152fb_fk_projectap` FOREIGN KEY (`academicrecord_id`) REFERENCES `projectapp_academicrecord` (`id`),
  CONSTRAINT `projectapp_form137_r_form137_id_bfcaaead_fk_projectap` FOREIGN KEY (`form137_id`) REFERENCES `projectapp_form137` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_form137_records`
--

LOCK TABLES `projectapp_form137_records` WRITE;
/*!40000 ALTER TABLE `projectapp_form137_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `projectapp_form137_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_gradelevel`
--

DROP TABLE IF EXISTS `projectapp_gradelevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_gradelevel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_gradelevel`
--

LOCK TABLES `projectapp_gradelevel` WRITE;
/*!40000 ALTER TABLE `projectapp_gradelevel` DISABLE KEYS */;
INSERT INTO `projectapp_gradelevel` VALUES (1,'Nursery'),(2,'Kinder-1'),(3,'Kinder-2'),(4,'Grade 1'),(5,'Grade 2'),(7,'Grade 3'),(8,'Grade 4'),(9,'Grade 5'),(10,'Grade 6');
/*!40000 ALTER TABLE `projectapp_gradelevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_parentguardian`
--

DROP TABLE IF EXISTS `projectapp_parentguardian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_parentguardian` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `address` longtext NOT NULL,
  `contact_information` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_parentguardian`
--

LOCK TABLES `projectapp_parentguardian` WRITE;
/*!40000 ALTER TABLE `projectapp_parentguardian` DISABLE KEYS */;
INSERT INTO `projectapp_parentguardian` VALUES (1,'Parent 2','Parent 2','Parent 2','Parent 2','12321321321'),(2,'Kathryn Sophia','Y','Abonal','Bgy. Tiniguiban PPC','0926-649-6394'),(3,'Aerom','Ahlen','Malate','Bgy. Tiniguiban','0906-499-4047'),(4,'Juliana Suzaine','Sumalde','Avila','Bgy. San Miguel PPC','0965498756981'),(20,'Juan','Juan','Juan','Juan','Juan'),(21,'ricardo','c','chu','Baltan st. Zone-3\r\nMgt. Building','09295239600'),(22,'John Paolo','R.','Bandong','Bgy. Tiniguiban','09321415649'),(23,'Jerson','B.','Caabas','Bgy. Santa Lourdes PPC','09321564978'),(24,'frederick','A.','contreras','Bgy. Tiniguiban PPC','097878748487'),(25,'ian rey','a','cuanan','Santa Monica PPC','Santa Monica PPC'),(26,'jesus bryan','d.','cuyo','Bgy. San Manuel PPC','09897984564'),(27,'jordan','g.','daroy','Santa Monica PPC','09875456128'),(28,'Analisa','S.','Deximo','Bgy. Sicsican PPC','09090807564'),(40,'Jefferson','S.','Echavez','Bgy. Mandaragat PPC','09564987564'),(41,'Encio','R','Dennis','Bgy. Tiniguiban','095649878754'),(42,'Ervin','E.','Estrada','Bgy. Irawan PPC','0987564987587'),(43,'Raymund','L.','Gabinete','Santa Monica PPC','09808754855'),(54,'Joseph Froilan','D','Jose','Santa Lourdes, PPC','095649878451'),(55,'Regent','B','Magbanua','Tiniguiban PPC','0945165231547'),(56,'Janno','M','Masculino','Tiniguiban PPC','09854875621'),(160,'123','123','123','123','123'),(161,'321','321','321','321','321'),(162,'123','123','123','123','123'),(163,'321','321','321','321','321'),(164,'321','321','321','321','321'),(165,'321','321','321','321','321'),(166,'321','321','321','321','321'),(167,'321','321','321','321','321'),(168,'321','321','321','321','321'),(169,'321','321','321','321','321'),(170,'321','321','321','321','321'),(171,'321','321','321','321','321'),(172,'ced','dsadsaasdsa','sadsadsa','asdsadsa','saddsa');
/*!40000 ALTER TABLE `projectapp_parentguardian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_payment`
--

DROP TABLE IF EXISTS `projectapp_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `date_paid` date NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL,
  `notes` longtext NOT NULL,
  `payment_user_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectapp_payment_payment_user_id_b4615d50_fk_projectap` (`payment_user_id`),
  KEY `projectapp_payment_student_id_9b07d92f_fk_projectapp_student_id` (`student_id`),
  CONSTRAINT `projectapp_payment_payment_user_id_b4615d50_fk_projectap` FOREIGN KEY (`payment_user_id`) REFERENCES `projectapp_user` (`id`),
  CONSTRAINT `projectapp_payment_student_id_9b07d92f_fk_projectapp_student_id` FOREIGN KEY (`student_id`) REFERENCES `projectapp_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_payment`
--

LOCK TABLES `projectapp_payment` WRITE;
/*!40000 ALTER TABLE `projectapp_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `projectapp_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_school`
--

DROP TABLE IF EXISTS `projectapp_school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_school` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_school`
--

LOCK TABLES `projectapp_school` WRITE;
/*!40000 ALTER TABLE `projectapp_school` DISABLE KEYS */;
INSERT INTO `projectapp_school` VALUES (1,'SCHOOL EXAMPLE 1','SCHOOL ADDRESS EXAMPLE 1');
/*!40000 ALTER TABLE `projectapp_school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_schoolyear`
--

DROP TABLE IF EXISTS `projectapp_schoolyear`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_schoolyear` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `year` varchar(9) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_schoolyear`
--

LOCK TABLES `projectapp_schoolyear` WRITE;
/*!40000 ALTER TABLE `projectapp_schoolyear` DISABLE KEYS */;
INSERT INTO `projectapp_schoolyear` VALUES (1,'2020-2021','2020-08-04','2021-06-04',0),(2,'2021-2022','2021-08-04','2022-06-04',0),(3,'2022-2023','2022-08-04','2023-06-04',0),(4,'2024','2024-07-12','2024-06-12',1);
/*!40000 ALTER TABLE `projectapp_schoolyear` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_section`
--

DROP TABLE IF EXISTS `projectapp_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_section` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `grade_level_id` bigint NOT NULL,
  `adviser_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `adviser_id` (`adviser_id`),
  KEY `projectapp_section_grade_level_id_f3b3f54f_fk_projectap` (`grade_level_id`),
  CONSTRAINT `projectapp_section_adviser_id_0383d9c5_fk_projectapp_teacher_id` FOREIGN KEY (`adviser_id`) REFERENCES `projectapp_teacher` (`id`),
  CONSTRAINT `projectapp_section_grade_level_id_f3b3f54f_fk_projectap` FOREIGN KEY (`grade_level_id`) REFERENCES `projectapp_gradelevel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_section`
--

LOCK TABLES `projectapp_section` WRITE;
/*!40000 ALTER TABLE `projectapp_section` DISABLE KEYS */;
INSERT INTO `projectapp_section` VALUES (1,'Section 1',1,1),(2,'Section 2',1,2);
/*!40000 ALTER TABLE `projectapp_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_student`
--

DROP TABLE IF EXISTS `projectapp_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_student` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `lrn` varchar(20) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date NOT NULL,
  `place_of_birth` longtext NOT NULL,
  `gender` varchar(10) NOT NULL,
  `address` longtext NOT NULL,
  `promoted` tinyint(1) NOT NULL,
  `parent_guardians_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lrn` (`lrn`),
  KEY `projectapp_student_parent_guardians_id_57f2ea35_fk_projectap` (`parent_guardians_id`),
  CONSTRAINT `projectapp_student_parent_guardians_id_57f2ea35_fk_projectap` FOREIGN KEY (`parent_guardians_id`) REFERENCES `projectapp_parentguardian` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_student`
--

LOCK TABLES `projectapp_student` WRITE;
/*!40000 ALTER TABLE `projectapp_student` DISABLE KEYS */;
INSERT INTO `projectapp_student` VALUES (1,'123456789','Cedrick','C','Chu','2012-07-11','Baltan st. Zone-3\r\nMgt. Building','M','Baltan st. Zone-3\r\nMgt. Building',0,1),(2,'11111111','Kathryn Sophia','Y','Abonal','2014-01-01','Bgy. Tiniguiban PPC','F','Bgy. Tiniguiban PPC',0,2),(3,'09809887654','Aerom','Ahlen','Malate','2017-02-05','Bgy. Tiniguiban','M','Bgy. Tiniguiban',0,3),(4,'3564987456','Juliana Suzaine','Sumalde','Avila','2017-03-05','Bgy. San Miguel PPC','F','Bgy. San Miguel PPC',0,4),(13,'12321321','Cedrick','asd','Chu','2024-07-17','asdsadsa','M','Baltan st. Zone-3\r\nMgt. Building',0,1),(14,'1010 010','Jzt','C.','Chu','2024-07-12','cc','M','ccc',0,21),(15,'0758736271','Liam Kyle','Villanueva','Bandong','2016-06-16','Bgy. Tiniguiban','M','Bgy. Tiniguiban',0,22),(16,'564956456123','Justin Lim','C','Caabas','2019-03-12','Bgy. Santa Lourdes PPC','M','Bgy. Santa Lourdes PPC',0,23),(17,'09095909','Angela yhelrene','Gregorio','Contreras','2015-02-06','Bgy. Irawan PPC','F','Bgy. Irawan PPC',0,24),(18,'56498745645231','Carmela Isabel','Halili','Cuanan','2014-06-06','Santa Monica PPC','M','Santa Monica PPC',0,25),(19,'56498789456212','Bryllie','Agum','Cuyo','2015-02-06','Bgy. San Manuel PPC','M','Bgy. San Manuel PPC',0,26),(20,'56487896542','Tom ashlan','Espina','Daroy','2013-02-06','Santa Monica PPC','M','Santa Monica PPC',0,27),(21,'12392183921038','Hera Athena','C','Deximo','2015-03-06','PPC','F','PPC',0,28),(22,'12345678974','Aldrei Jefferson','Gomez','Echavez','2013-02-06','Bgy. Mandaragat PPC','M','Bgy. Mandaragat PPC',0,40),(23,'212564978945','Sir Dominic','Ocampo','Encio','2012-07-06','Bgy. Tiniguiban','M','Bgy. Tiniguiban',0,41),(24,'45784898751','Ethan Sergio','E','Estrada','2013-02-16','Bgy. Irawan PPC','M','Bgy. Irawan PPC',0,42),(25,'2564987212354','Jan Xian','Lucero','Gabinete','2015-01-15','Santa Monica PPC','M','Santa Monica PPC',0,43),(26,'12345132131','Nathaniel','Lucero','Gabinete','2015-01-12','Santa Monica','M','Santa Monica',0,43),(27,'213213411','Aeron Francis','','Jose','2014-06-16','Santa Lourdes PPC','M','Santa Lourdes PPC',0,54),(29,'5649878545','Charent','Gapulao','Magbanua','2015-01-04','2015','F','Tiniguiban PPC',0,55),(30,'5498756123','Tiffany Leigh','Arguelles','Masculino','2014-12-18','Tiniguiban PPC','F','Tiniguiban PPC',0,56),(31,'asdasds','sadsad','sasadsa','sadsad','2024-07-02','sadsadsa','M','asdsadsa',0,1),(32,'56498781236142','sadsad','sasadsa','sadsad','2024-07-02','sadsadsa','M','asdsadsa',0,1),(33,'123123','abc','abc','abc','2024-07-07','abc','M','abc',0,1),(34,'abc','abc','abc','abc','2024-07-09','abc','M','abc',0,2),(35,'321','chy','chy','chy','2024-07-07','chy','M','chy',0,2),(36,'321321321','ced','ced','ced','2024-07-17','ced','M','ced',0,1),(37,'32132132132112','cheh','cheh','cheh','2024-07-09','cheh','M','cheh',0,1),(38,'32112321321321','321','321','321','2024-07-01','321','M','321',0,1),(39,'123','123','123','123','2024-07-16','123','M','123',0,2),(40,'32112312321321','321','321','32','2024-07-02','1','M','123213',0,1),(41,'3211232151232145654','321','321','123213','2024-07-01','564','M','123213',0,2),(42,'321321321321434566','321','321','321','2024-07-01','12321321','M','123123213',0,2),(43,'321321321321','321','321','321','2024-07-01','12321321','M','123123213',0,2),(44,'32132132132123123','321','321','321','2024-07-01','12321321','M','123123213',0,2),(45,'4632134456132','321','321','321','2024-07-01','12321321','M','123123213',0,2),(46,'sdsad2131213467','21321','1231212321','123','2024-07-08','12asd21321','M','12312321',0,3),(47,'34543adsad12321','dasdsaasdsad','sadsada','asdsad','2024-07-17','sadasdsa','M','asdsadsa',0,2),(48,'123213213546sadsa','dsadsad','asdas','sadsad','2024-07-02','sadsaa','M','sdsadsa',0,2),(49,'321321321adsadsa','asdsadsadsa','asdsadsad','sadsadsa','2024-07-02','dsadsad','M','sadsadsa',0,2),(50,'sdasdsadsa','dsadsadsaas','dsadas','dsadsasa','2024-07-01','dsadsadsad','M','sadsadsa',0,2),(51,'dsadsa1321sacadsasa','sadsadsas','adsadsad','sadsadsa','2024-07-09','sadsad','M','sadsadsadsa',0,3),(52,'dsadsadsa','sadsa','dsadsa','sadsa','2024-06-30','dsadsa','M','dsadsa',0,2),(53,'ceced','adsadsadsa','dsadsads','dsasadsadsa','2024-07-02','sdsad','M','asdsadsa',0,172);
/*!40000 ALTER TABLE `projectapp_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_studentinfo`
--

DROP TABLE IF EXISTS `projectapp_studentinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_studentinfo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `grade_level_id` bigint DEFAULT NULL,
  `school_year_id` bigint DEFAULT NULL,
  `section_id` bigint DEFAULT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectapp_studentin_grade_level_id_d37fa826_fk_projectap` (`grade_level_id`),
  KEY `projectapp_studentin_student_id_d6779a77_fk_projectap` (`student_id`),
  KEY `projectapp_studentin_school_year_id_5d5a45d5_fk_projectap` (`school_year_id`),
  KEY `projectapp_studentin_section_id_f9a54fd2_fk_projectap` (`section_id`),
  CONSTRAINT `projectapp_studentin_grade_level_id_d37fa826_fk_projectap` FOREIGN KEY (`grade_level_id`) REFERENCES `projectapp_gradelevel` (`id`),
  CONSTRAINT `projectapp_studentin_school_year_id_5d5a45d5_fk_projectap` FOREIGN KEY (`school_year_id`) REFERENCES `projectapp_schoolyear` (`id`),
  CONSTRAINT `projectapp_studentin_section_id_f9a54fd2_fk_projectap` FOREIGN KEY (`section_id`) REFERENCES `projectapp_section` (`id`),
  CONSTRAINT `projectapp_studentin_student_id_d6779a77_fk_projectap` FOREIGN KEY (`student_id`) REFERENCES `projectapp_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_studentinfo`
--

LOCK TABLES `projectapp_studentinfo` WRITE;
/*!40000 ALTER TABLE `projectapp_studentinfo` DISABLE KEYS */;
INSERT INTO `projectapp_studentinfo` VALUES (1,1,1,1,1),(2,2,1,1,2),(4,2,1,2,3),(5,2,1,2,4),(6,2,2,2,20),(7,4,1,2,17),(8,7,3,1,25),(10,1,1,1,26),(11,1,3,2,3),(12,5,3,2,25),(13,8,2,2,23),(14,5,2,2,22),(15,1,2,2,27),(16,7,2,1,1),(17,3,2,2,14),(18,1,1,1,36),(19,1,2,2,37),(20,1,1,1,13),(21,1,3,2,38),(22,1,1,2,39),(23,1,1,1,52),(24,1,3,1,1);
/*!40000 ALTER TABLE `projectapp_studentinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_studentyearinfo`
--

DROP TABLE IF EXISTS `projectapp_studentyearinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_studentyearinfo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `gen_ave` decimal(5,2) DEFAULT NULL,
  `tdays_of_classes` int DEFAULT NULL,
  `tdays_of_present` int DEFAULT NULL,
  `promoted` tinyint(1) NOT NULL,
  `grade_level_id` bigint NOT NULL,
  `school_id` bigint NOT NULL,
  `school_year_id` bigint NOT NULL,
  `section_id` bigint DEFAULT NULL,
  `student_id` bigint NOT NULL,
  `to_be_classified_id` bigint NOT NULL,
  `adviser_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectapp_studentye_grade_level_id_70ad1a57_fk_projectap` (`grade_level_id`),
  KEY `projectapp_studentye_school_id_8d2657bf_fk_projectap` (`school_id`),
  KEY `projectapp_studentye_school_year_id_88b615bf_fk_projectap` (`school_year_id`),
  KEY `projectapp_studentye_section_id_27ec2cba_fk_projectap` (`section_id`),
  KEY `projectapp_studentye_student_id_46dc453d_fk_projectap` (`student_id`),
  KEY `projectapp_studentye_to_be_classified_id_e30738a7_fk_projectap` (`to_be_classified_id`),
  KEY `projectapp_studentye_adviser_id_d140a12b_fk_projectap` (`adviser_id`),
  CONSTRAINT `projectapp_studentye_adviser_id_d140a12b_fk_projectap` FOREIGN KEY (`adviser_id`) REFERENCES `projectapp_teacher` (`id`),
  CONSTRAINT `projectapp_studentye_grade_level_id_70ad1a57_fk_projectap` FOREIGN KEY (`grade_level_id`) REFERENCES `projectapp_gradelevel` (`id`),
  CONSTRAINT `projectapp_studentye_school_id_8d2657bf_fk_projectap` FOREIGN KEY (`school_id`) REFERENCES `projectapp_school` (`id`),
  CONSTRAINT `projectapp_studentye_school_year_id_88b615bf_fk_projectap` FOREIGN KEY (`school_year_id`) REFERENCES `projectapp_schoolyear` (`id`),
  CONSTRAINT `projectapp_studentye_section_id_27ec2cba_fk_projectap` FOREIGN KEY (`section_id`) REFERENCES `projectapp_section` (`id`),
  CONSTRAINT `projectapp_studentye_student_id_46dc453d_fk_projectap` FOREIGN KEY (`student_id`) REFERENCES `projectapp_student` (`id`),
  CONSTRAINT `projectapp_studentye_to_be_classified_id_e30738a7_fk_projectap` FOREIGN KEY (`to_be_classified_id`) REFERENCES `projectapp_gradelevel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_studentyearinfo`
--

LOCK TABLES `projectapp_studentyearinfo` WRITE;
/*!40000 ALTER TABLE `projectapp_studentyearinfo` DISABLE KEYS */;
INSERT INTO `projectapp_studentyearinfo` VALUES (1,90.00,180,180,1,1,1,1,1,1,2,3);
/*!40000 ALTER TABLE `projectapp_studentyearinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_subject`
--

DROP TABLE IF EXISTS `projectapp_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_subject` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `grade_level_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projectapp_subject_grade_level_id_f9c4a9e9_fk_projectap` (`grade_level_id`),
  CONSTRAINT `projectapp_subject_grade_level_id_f9c4a9e9_fk_projectap` FOREIGN KEY (`grade_level_id`) REFERENCES `projectapp_gradelevel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_subject`
--

LOCK TABLES `projectapp_subject` WRITE;
/*!40000 ALTER TABLE `projectapp_subject` DISABLE KEYS */;
INSERT INTO `projectapp_subject` VALUES (1,'Math',1),(2,'Science',1),(3,'English',1);
/*!40000 ALTER TABLE `projectapp_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_teacher`
--

DROP TABLE IF EXISTS `projectapp_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_teacher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `address` longtext NOT NULL,
  `contact_information` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_teacher`
--

LOCK TABLES `projectapp_teacher` WRITE;
/*!40000 ALTER TABLE `projectapp_teacher` DISABLE KEYS */;
INSERT INTO `projectapp_teacher` VALUES (1,'Teacher 2','Example','2','Teacher 2 Address','Teacher 2 Contact Information'),(2,'Teacher','Example','3','Teacher Example 3 Addess','Teacher Example 3 Contact'),(3,'Teacher','Example','1','Teacher Address','Teacher Contact'),(4,'Teacher 4','Teacher 4','Teacher 4','Teacher 3','Teacher 3');
/*!40000 ALTER TABLE `projectapp_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_totalgradesubject`
--

DROP TABLE IF EXISTS `projectapp_totalgradesubject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_totalgradesubject` (
  `TGS_ID` int NOT NULL AUTO_INCREMENT,
  `first_grading` decimal(5,2) DEFAULT NULL,
  `second_grading` decimal(5,2) DEFAULT NULL,
  `third_grading` decimal(5,2) DEFAULT NULL,
  `fourth_grading` decimal(5,2) DEFAULT NULL,
  `FINAL_GRADES` decimal(5,2) DEFAULT NULL,
  `PASSED_FAILED` varchar(20) DEFAULT NULL,
  `STUDENT_ID_id` bigint NOT NULL,
  `SUBJECT_id` bigint NOT NULL,
  `SYI_ID_id` bigint NOT NULL,
  PRIMARY KEY (`TGS_ID`),
  KEY `projectapp_totalgrad_STUDENT_ID_id_77ddbc29_fk_projectap` (`STUDENT_ID_id`),
  KEY `projectapp_totalgrad_SUBJECT_id_3b0fbde2_fk_projectap` (`SUBJECT_id`),
  KEY `projectapp_totalgrad_SYI_ID_id_ca83b4db_fk_projectap` (`SYI_ID_id`),
  CONSTRAINT `projectapp_totalgrad_STUDENT_ID_id_77ddbc29_fk_projectap` FOREIGN KEY (`STUDENT_ID_id`) REFERENCES `projectapp_student` (`id`),
  CONSTRAINT `projectapp_totalgrad_SUBJECT_id_3b0fbde2_fk_projectap` FOREIGN KEY (`SUBJECT_id`) REFERENCES `projectapp_subject` (`id`),
  CONSTRAINT `projectapp_totalgrad_SYI_ID_id_ca83b4db_fk_projectap` FOREIGN KEY (`SYI_ID_id`) REFERENCES `projectapp_studentyearinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_totalgradesubject`
--

LOCK TABLES `projectapp_totalgradesubject` WRITE;
/*!40000 ALTER TABLE `projectapp_totalgradesubject` DISABLE KEYS */;
INSERT INTO `projectapp_totalgradesubject` VALUES (1,80.00,90.00,90.00,80.00,90.00,'PASSED',1,1,1);
/*!40000 ALTER TABLE `projectapp_totalgradesubject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_user`
--

DROP TABLE IF EXISTS `projectapp_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_user`
--

LOCK TABLES `projectapp_user` WRITE;
/*!40000 ALTER TABLE `projectapp_user` DISABLE KEYS */;
INSERT INTO `projectapp_user` VALUES (1,'pbkdf2_sha256$720000$ZHQMVbcYChzRoUNM9YDzSW$rijeOU23ozULQ0AXW5YllPtkxUouC5MTenKqWdwqDCs=','2024-07-12 12:18:37.310342',1,'admin','admin',0,0,'admin'),(2,'pbkdf2_sha256$720000$jdaqQHG0tYbzKEWXOSikSF$Qo7mQFoYRoGz6AQXtaftM/00U7xSh++YkD6SLcgbLys=','2024-07-05 07:20:12.542124',0,'cedrickchu123','cedrick',0,0,'chu'),(3,'pbkdf2_sha256$720000$BPalD9gwEhDgqTTv7niE8N$59Da7rJ3nAF4FOkqquFdTLWxM+/6WGZIJ1PJlo4NgRo=',NULL,1,'admin2','admin2',0,0,'admin2'),(4,'pbkdf2_sha256$720000$UawmiZJ4jszRt3XUL2DwpH$50lk0ghTbkFEE1rizF7e4/iBs0/j5vjl/e+WzPmBE+g=','2024-07-12 12:50:40.208202',1,'admin123','admin123',1,1,'admin123');
/*!40000 ALTER TABLE `projectapp_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_user_groups`
--

DROP TABLE IF EXISTS `projectapp_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projectapp_user_groups_user_id_group_id_a1fa295f_uniq` (`user_id`,`group_id`),
  KEY `projectapp_user_groups_group_id_dd9f50db_fk_auth_group_id` (`group_id`),
  CONSTRAINT `projectapp_user_groups_group_id_dd9f50db_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `projectapp_user_groups_user_id_c13b1193_fk_projectapp_user_id` FOREIGN KEY (`user_id`) REFERENCES `projectapp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_user_groups`
--

LOCK TABLES `projectapp_user_groups` WRITE;
/*!40000 ALTER TABLE `projectapp_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `projectapp_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectapp_user_user_permissions`
--

DROP TABLE IF EXISTS `projectapp_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectapp_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projectapp_user_user_per_user_id_permission_id_bb1d3a14_uniq` (`user_id`,`permission_id`),
  KEY `projectapp_user_user_permission_id_72f67b7d_fk_auth_perm` (`permission_id`),
  CONSTRAINT `projectapp_user_user_permission_id_72f67b7d_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `projectapp_user_user_user_id_b13cbaa2_fk_projectap` FOREIGN KEY (`user_id`) REFERENCES `projectapp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectapp_user_user_permissions`
--

LOCK TABLES `projectapp_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `projectapp_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `projectapp_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-12 20:53:59