-- MySQL dump 10.13  Distrib 8.0.43, for macos15 (arm64)
--
-- Host: localhost    Database: hotel_data
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `access_card`
--

DROP TABLE IF EXISTS `access_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_card` (
  `card_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `issued_date` datetime DEFAULT NULL,
  `expire_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`card_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `access_card_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `access_card_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_card`
--

LOCK TABLES `access_card` WRITE;
/*!40000 ALTER TABLE `access_card` DISABLE KEYS */;
INSERT INTO `access_card` VALUES (1,1,NULL,'2024-06-13 14:00:00','2024-06-20 12:00:00','Active'),(2,6,NULL,'2024-06-10 09:00:00','2024-06-24 12:00:00','Active'),(3,NULL,2,'2023-01-01 08:00:00',NULL,'Active'),(4,NULL,4,'2023-01-01 08:00:00',NULL,'Active');
/*!40000 ALTER TABLE `access_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_info`
--

DROP TABLE IF EXISTS `bed_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bed_info` (
  `bed_info_id` int NOT NULL,
  `bed_number` int DEFAULT '1',
  `is_king` bit(1) DEFAULT b'0',
  `is_queen` bit(1) DEFAULT b'0',
  `is_regular` bit(1) DEFAULT b'0',
  `is_extra_long` bit(1) DEFAULT b'0',
  PRIMARY KEY (`bed_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_info`
--

LOCK TABLES `bed_info` WRITE;
/*!40000 ALTER TABLE `bed_info` DISABLE KEYS */;
INSERT INTO `bed_info` VALUES (1,1,_binary '',_binary '\0',_binary '\0',_binary '\0'),(2,2,_binary '\0',_binary '',_binary '\0',_binary '\0'),(3,1,_binary '\0',_binary '\0',_binary '',_binary '\0'),(4,1,_binary '\0',_binary '',_binary '\0',_binary '\0');
/*!40000 ALTER TABLE `bed_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing_account`
--

DROP TABLE IF EXISTS `billing_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_account` (
  `billing_account_id` int NOT NULL,
  `party_id` int NOT NULL,
  `open_date` datetime DEFAULT NULL,
  `close_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `currency` varchar(10) DEFAULT 'USD',
  PRIMARY KEY (`billing_account_id`),
  KEY `party_id` (`party_id`),
  CONSTRAINT `billing_account_ibfk_1` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_account`
--

LOCK TABLES `billing_account` WRITE;
/*!40000 ALTER TABLE `billing_account` DISABLE KEYS */;
INSERT INTO `billing_account` VALUES (1,1,'2024-06-13 14:00:00',NULL,'Open','USD'),(2,2,'2024-06-14 10:00:00',NULL,'Open','USD'),(3,3,'2024-05-15 10:00:00',NULL,'Open','USD'),(4,4,'2024-06-10 15:00:00',NULL,'Open','USD'),(5,5,'2024-06-05 11:00:00',NULL,'Open','USD'),(6,6,'2024-03-01 09:00:00',NULL,'Open','USD'),(7,9,'2024-04-01 09:30:00','2024-06-30 12:00:00','Closed','USD');
/*!40000 ALTER TABLE `billing_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `building_id` int NOT NULL,
  `building_name` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES (1,'Ocean Summit Tower','101 Coastal Hwy, Beachside'),(2,'Garden Pavilion','102 Coastal Hwy, Beachside'),(3,'Seaside Villas','105 Coastal Hwy, Private Beach'),(4,'Harbor View Tower','200 Seaside Blvd, Beachside'),(5,'Palm Court Residence','220 Palm Ave, Beachside'),(6,'Coral Reef Retreat','300 Marine Dr, Beachside');
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_activity`
--

DROP TABLE IF EXISTS `card_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `card_activity` (
  `card_activity_id` int NOT NULL,
  `card_id` int NOT NULL,
  `room_id` int NOT NULL,
  `access_time` datetime DEFAULT NULL,
  PRIMARY KEY (`card_activity_id`),
  KEY `card_id` (`card_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `card_activity_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `access_card` (`card_id`),
  CONSTRAINT `card_activity_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_activity`
--

LOCK TABLES `card_activity` WRITE;
/*!40000 ALTER TABLE `card_activity` DISABLE KEYS */;
INSERT INTO `card_activity` VALUES (1,1,2,'2024-06-13 14:20:00'),(2,1,2,'2024-06-13 19:30:00'),(3,2,10,'2024-06-15 08:55:00'),(4,2,12,'2024-06-15 18:00:00'),(5,3,2,'2024-06-14 10:00:00'),(6,3,2,'2024-06-15 11:00:00');
/*!40000 ALTER TABLE `card_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge`
--

DROP TABLE IF EXISTS `charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charge` (
  `charge_id` int NOT NULL,
  `reservation_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `service_usage_id` int DEFAULT NULL,
  `facility_id` int DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `posted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`charge_id`),
  KEY `reservation_id` (`reservation_id`),
  KEY `customer_id` (`customer_id`),
  KEY `service_usage_id` (`service_usage_id`),
  KEY `facility_id` (`facility_id`),
  CONSTRAINT `charge_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation_request` (`reservation_id`),
  CONSTRAINT `charge_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `charge_ibfk_3` FOREIGN KEY (`service_usage_id`) REFERENCES `service_usage` (`service_usage_id`),
  CONSTRAINT `charge_ibfk_4` FOREIGN KEY (`facility_id`) REFERENCES `facility` (`facility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge`
--

LOCK TABLES `charge` WRITE;
/*!40000 ALTER TABLE `charge` DISABLE KEYS */;
INSERT INTO `charge` VALUES (1,3,4,NULL,NULL,720.00,NULL),(2,4,6,NULL,NULL,4000.00,NULL),(3,NULL,2,NULL,NULL,1000.00,NULL),(4,NULL,2,3,NULL,120.00,NULL);
/*!40000 ALTER TABLE `charge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charge_allocation`
--

DROP TABLE IF EXISTS `charge_allocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charge_allocation` (
  `allocation_id` int NOT NULL,
  `charge_id` int NOT NULL,
  `billing_account_id` int NOT NULL,
  `responsible_percent` decimal(5,2) DEFAULT '100.00',
  `amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`allocation_id`),
  KEY `charge_id` (`charge_id`),
  KEY `billing_account_id` (`billing_account_id`),
  CONSTRAINT `charge_allocation_ibfk_1` FOREIGN KEY (`charge_id`) REFERENCES `charge` (`charge_id`),
  CONSTRAINT `charge_allocation_ibfk_2` FOREIGN KEY (`billing_account_id`) REFERENCES `billing_account` (`billing_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charge_allocation`
--

LOCK TABLES `charge_allocation` WRITE;
/*!40000 ALTER TABLE `charge_allocation` DISABLE KEYS */;
INSERT INTO `charge_allocation` VALUES (1,1,3,100.00,720.00),(2,2,4,100.00,4000.00),(3,3,2,80.00,800.00),(4,3,6,20.00,200.00),(5,4,6,100.00,120.00);
/*!40000 ALTER TABLE `charge_allocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email_address` varchar(150) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'John','Doe','john.doe@email.com','555-0101'),(2,'Alice','Wonderland','alice@email.com','555-0102'),(3,'Bob','Builder','bob@construct.com','555-0103'),(4,'Mike','Smith','mike.smith@fam.com','555-0201'),(5,'Sarah','Smith','sarah.smith@fam.com','555-0202'),(6,'Robert','Consultant','rob@audit.com','555-0300'),(7,'Emily','Bride','emily@wedding.com','555-0400'),(8,'Daniel','Groom','dan@wedding.com','555-0401'),(9,'Liam','Taylor','liam.taylor9@example.com','555-1009'),(10,'Olivia','Johnson','olivia.johnson10@example.com','555-1010'),(11,'Noah','Brown','noah.brown11@example.com','555-1011'),(12,'Emma','Wilson','emma.wilson12@example.com','555-1012'),(13,'Oliver','Clark','oliver.clark13@example.com','555-1013'),(14,'Ava','Davis','ava.davis14@example.com','555-1014'),(15,'Elijah','Lewis','elijah.lewis15@example.com','555-1015'),(16,'Sophia','Walker','sophia.walker16@example.com','555-1016'),(17,'James','Hall','james.hall17@example.com','555-1017'),(18,'Isabella','Young','isabella.young18@example.com','555-1018'),(19,'William','Allen','william.allen19@example.com','555-1019'),(20,'Mia','King','mia.king20@example.com','555-1020'),(21,'Benjamin','Wright','benjamin.wright21@example.com','555-1021'),(22,'Charlotte','Scott','charlotte.scott22@example.com','555-1022'),(23,'Lucas','Green','lucas.green23@example.com','555-1023'),(24,'Amelia','Baker','amelia.baker24@example.com','555-1024'),(25,'Henry','Adams','henry.adams25@example.com','555-1025'),(26,'Harper','Nelson','harper.nelson26@example.com','555-1026'),(27,'Alexander','Hill','alexander.hill27@example.com','555-1027'),(28,'Evelyn','Ramirez','evelyn.ramirez28@example.com','555-1028'),(29,'Michael','Campbell','michael.campbell29@example.com','555-1029'),(30,'Abigail','Mitchell','abigail.mitchell30@example.com','555-1030'),(31,'Daniel','Roberts','daniel.roberts31@example.com','555-1031'),(32,'Emily','Carter','emily.carter32@example.com','555-1032'),(33,'Matthew','Phillips','matthew.phillips33@example.com','555-1033'),(34,'Ella','Evans','ella.evans34@example.com','555-1034'),(35,'Samuel','Turner','samuel.turner35@example.com','555-1035'),(36,'Elizabeth','Torres','elizabeth.torres36@example.com','555-1036'),(37,'Jack','Parker','jack.parker37@example.com','555-1037'),(38,'Sofia','Collins','sofia.collins38@example.com','555-1038'),(39,'Owen','Edwards','owen.edwards39@example.com','555-1039'),(40,'Avery','Stewart','avery.stewart40@example.com','555-1040'),(41,'Wyatt','Morris','wyatt.morris41@example.com','555-1041'),(42,'Scarlett','Rogers','scarlett.rogers42@example.com','555-1042'),(43,'Leo','Reed','leo.reed43@example.com','555-1043'),(44,'Grace','Cook','grace.cook44@example.com','555-1044'),(45,'Julian','Morgan','julian.morgan45@example.com','555-1045'),(46,'Chloe','Bell','chloe.bell46@example.com','555-1046'),(47,'Hudson','Murphy','hudson.murphy47@example.com','555-1047'),(48,'Victoria','Bailey','victoria.bailey48@example.com','555-1048'),(49,'Luke','Rivera','luke.rivera49@example.com','555-1049'),(50,'Riley','Cooper','riley.cooper50@example.com','555-1050'),(51,'Caleb','Richardson','caleb.richardson51@example.com','555-1051'),(52,'Zoey','Cox','zoey.cox52@example.com','555-1052'),(53,'Isaac','Howard','isaac.howard53@example.com','555-1053'),(54,'Nora','Ward','nora.ward54@example.com','555-1054'),(55,'Nathan','Flores','nathan.flores55@example.com','555-1055'),(56,'Lily','Coleman','lily.coleman56@example.com','555-1056'),(57,'Hunter','Gray','hunter.gray57@example.com','555-1057'),(58,'Hannah','James','hannah.james58@example.com','555-1058'),(59,'Eli','Watson','eli.watson59@example.com','555-1059'),(60,'Lillian','Brooks','lillian.brooks60@example.com','555-1060'),(61,'Thomas','Kelly','thomas.kelly61@example.com','555-1061'),(62,'Addison','Sanders','addison.sanders62@example.com','555-1062'),(63,'Grayson','Price','grayson.price63@example.com','555-1063'),(64,'Eleanor','Bennett','eleanor.bennett64@example.com','555-1064'),(65,'Josiah','Wood','josiah.wood65@example.com','555-1065'),(66,'Natalie','Barnes','natalie.barnes66@example.com','555-1066'),(67,'Adrian','Ross','adrian.ross67@example.com','555-1067'),(68,'Luna','Henderson','luna.henderson68@example.com','555-1068'),(69,'Christopher','Cole','christopher.cole69@example.com','555-1069'),(70,'Savannah','Jenkins','savannah.jenkins70@example.com','555-1070'),(71,'Maverick','Perry','maverick.perry71@example.com','555-1071'),(72,'Brooklyn','Powell','brooklyn.powell72@example.com','555-1072'),(73,'Isaiah','Long','isaiah.long73@example.com','555-1073'),(74,'Leah','Patterson','leah.patterson74@example.com','555-1074'),(75,'Joshua','Hughes','joshua.hughes75@example.com','555-1075'),(76,'Zoe','Flores','zoe.flores76@example.com','555-1076'),(77,'Andrew','Washington','andrew.washington77@example.com','555-1077'),(78,'Stella','Butler','stella.butler78@example.com','555-1078'),(79,'Liam','Taylor','liam.taylor79@example.com','555-1079'),(80,'Olivia','Johnson','olivia.johnson80@example.com','555-1080');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` int NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `pay_rate` decimal(10,2) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'James','Hotelier',25.00,'Concierge'),(2,'Mary','Cleaner',18.00,'Housekeeping'),(3,'David','Chef',30.00,'Head Chef'),(4,'Steve','Security',22.00,'Security Guard'),(5,'Linda','Manager',45.00,'General Manager'),(6,'Angela','Lopez',20.00,'Front Desk Agent'),(7,'Brian','Carter',28.00,'Sous Chef'),(8,'Rachel','Kim',19.50,'Server'),(9,'Tom','Henderson',21.00,'Bellman'),(10,'Sophia','Nguyen',32.00,'Event Coordinator'),(11,'Carlos','Ramirez',24.00,'Maintenance Technician'),(12,'Emma','Thompson',17.50,'Laundry Attendant'),(13,'Oliver','White',26.00,'Night Auditor'),(14,'Grace','Miller',23.00,'Reservation Specialist'),(15,'Henry','Davis',40.00,'Assistant Manager');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `event_id` int NOT NULL,
  `host_party_id` int NOT NULL,
  `billing_account_id` int DEFAULT NULL,
  `event_name` varchar(150) DEFAULT NULL,
  `event_duration` decimal(10,0) DEFAULT NULL,
  `est_attendance` int DEFAULT NULL,
  `est_guest_count` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `host_party_id` (`host_party_id`),
  KEY `billing_account_id` (`billing_account_id`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`host_party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`billing_account_id`) REFERENCES `billing_account` (`billing_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,3,2,'TechGlobal Q3 Summit',3,50,45),(2,6,5,'Johnson Rehearsal Dinner',4,30,0),(3,6,5,'Johnson Wedding Reception',6,150,100);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_facility_use`
--

DROP TABLE IF EXISTS `event_facility_use`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_facility_use` (
  `event_facility_use_id` int NOT NULL,
  `event_id` int NOT NULL,
  `facility_id` int NOT NULL,
  `timeslot_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`event_facility_use_id`),
  KEY `event_id` (`event_id`),
  KEY `facility_id` (`facility_id`),
  KEY `timeslot_id` (`timeslot_id`),
  CONSTRAINT `event_facility_use_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  CONSTRAINT `event_facility_use_ibfk_2` FOREIGN KEY (`facility_id`) REFERENCES `facility` (`facility_id`),
  CONSTRAINT `event_facility_use_ibfk_3` FOREIGN KEY (`timeslot_id`) REFERENCES `timeslot` (`timeslot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_facility_use`
--

LOCK TABLES `event_facility_use` WRITE;
/*!40000 ALTER TABLE `event_facility_use` DISABLE KEYS */;
INSERT INTO `event_facility_use` VALUES (1,1,1,3,'2024-06-15'),(2,1,1,3,'2024-06-16'),(3,2,4,4,'2024-06-24');
/*!40000 ALTER TABLE `event_facility_use` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_room_use`
--

DROP TABLE IF EXISTS `event_room_use`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_room_use` (
  `event_room_use_id` int NOT NULL,
  `event_id` int NOT NULL,
  `room_id` int NOT NULL,
  `timeslot_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`event_room_use_id`),
  KEY `event_id` (`event_id`),
  KEY `room_id` (`room_id`),
  KEY `timeslot_id` (`timeslot_id`),
  CONSTRAINT `event_room_use_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  CONSTRAINT `event_room_use_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`),
  CONSTRAINT `event_room_use_ibfk_3` FOREIGN KEY (`timeslot_id`) REFERENCES `timeslot` (`timeslot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_room_use`
--

LOCK TABLES `event_room_use` WRITE;
/*!40000 ALTER TABLE `event_room_use` DISABLE KEYS */;
INSERT INTO `event_room_use` VALUES (1,1,10,2,'2024-06-15'),(2,1,10,4,'2024-06-15'),(3,1,10,2,'2024-06-16'),(4,1,10,4,'2024-06-16'),(5,3,11,5,'2024-06-25');
/*!40000 ALTER TABLE `event_room_use` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facility`
--

DROP TABLE IF EXISTS `facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facility` (
  `facility_id` int NOT NULL,
  `building_id` int NOT NULL,
  `wing_id` int DEFAULT NULL,
  `floor` int DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  PRIMARY KEY (`facility_id`),
  KEY `building_id` (`building_id`),
  KEY `wing_id` (`wing_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `facility_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`),
  CONSTRAINT `facility_ibfk_2` FOREIGN KEY (`wing_id`) REFERENCES `wing` (`wing_id`),
  CONSTRAINT `facility_ibfk_3` FOREIGN KEY (`type_id`) REFERENCES `facility_type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facility`
--

LOCK TABLES `facility` WRITE;
/*!40000 ALTER TABLE `facility` DISABLE KEYS */;
INSERT INTO `facility` VALUES (1,1,1,1,200,'Open',1),(2,1,2,5,50,'Open',2),(3,1,1,1,20,'Closed',10),(4,2,4,1,300,'Open',7),(5,1,3,1,80,'Open',3),(6,1,7,5,40,'Open',8),(7,1,14,2,120,'Open',7),(8,1,14,2,60,'Closed',7),(9,2,8,1,100,'Open',1),(10,2,10,1,500,'Reserved',7),(11,2,23,1,30,'Open',4),(12,3,11,1,15,'Open',2),(13,3,27,1,25,'Open',7),(14,3,26,1,10,'Closed',3),(15,4,16,1,120,'Open',1),(16,4,19,2,200,'Open',6),(17,4,18,1,50,'Closed',8),(18,5,23,1,25,'Open',4),(19,5,20,1,40,'Open',8),(20,5,22,1,60,'Open',9);
/*!40000 ALTER TABLE `facility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facility_type`
--

DROP TABLE IF EXISTS `facility_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facility_type` (
  `type_id` int NOT NULL,
  `type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facility_type`
--

LOCK TABLES `facility_type` WRITE;
/*!40000 ALTER TABLE `facility_type` DISABLE KEYS */;
INSERT INTO `facility_type` VALUES (1,'Restaurant'),(2,'Pool'),(3,'Gym'),(4,'Spa'),(5,'Meeting Room'),(6,'Ballroom'),(7,'Event Space'),(8,'Lounge'),(9,'Wellness'),(10,'Business Center');
/*!40000 ALTER TABLE `facility_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization` (
  `organization_id` int NOT NULL,
  `organization_name` varchar(150) NOT NULL,
  `main_contact_person` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (1,'TechGlobal Inc','Sarah Connor','555-9000','123 Silicon Valley'),(2,'Johnson-Bride Wedding','Emily Bride','555-9100','10 Church St'),(3,'Audit Corp','Boss Man','555-9200','500 Wall St'),(4,'Sunrise Travel Agency','Linda Tours','555-9300','88 Travel Plaza'),(5,'GreenLeaf Consulting','Mark Green','555-9400','200 Business Park Blvd'),(6,'Blue Ocean Conferences','Jason Blue','555-9500','77 Harbor Road');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party`
--

DROP TABLE IF EXISTS `party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `party` (
  `party_id` int NOT NULL,
  `party_type` varchar(20) NOT NULL,
  `customer_id` int DEFAULT NULL,
  `organization_id` int DEFAULT NULL,
  PRIMARY KEY (`party_id`),
  KEY `customer_id` (`customer_id`),
  KEY `organization_id` (`organization_id`),
  CONSTRAINT `party_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `party_ibfk_2` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party`
--

LOCK TABLES `party` WRITE;
/*!40000 ALTER TABLE `party` DISABLE KEYS */;
INSERT INTO `party` VALUES (1,'Customer',1,NULL),(2,'Customer',2,NULL),(3,'Organization',NULL,1),(4,'Customer',4,NULL),(5,'Customer',6,NULL),(6,'Organization',NULL,2),(7,'Customer',7,NULL),(8,'Customer',8,NULL),(9,'Organization',NULL,3);
/*!40000 ALTER TABLE `party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL,
  `billing_account_id` int NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `billing_account_id` (`billing_account_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`billing_account_id`) REFERENCES `billing_account` (`billing_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,3,'Credit Card',360.00,'2024-06-30 00:00:00'),(2,4,'Corporate Amex',4000.00,'2024-07-15 00:00:00');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_request`
--

DROP TABLE IF EXISTS `reservation_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation_request` (
  `reservation_id` int NOT NULL,
  `party_id` int NOT NULL,
  `bed_info_preferences` varchar(255) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `num_guest` int DEFAULT NULL,
  `num_room` int DEFAULT NULL,
  `is_smoking_pref` bit(1) DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `party_id` (`party_id`),
  CONSTRAINT `reservation_request_ibfk_1` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_request`
--

LOCK TABLES `reservation_request` WRITE;
/*!40000 ALTER TABLE `reservation_request` DISABLE KEYS */;
INSERT INTO `reservation_request` VALUES (1,1,'King Bed','2024-06-01','2024-06-04','Completed',2,1,_binary '\0'),(2,2,'Two Queens','2024-06-02','2024-06-06','Checked In',3,2,_binary '\0'),(3,3,'Adjoining Rooms','2024-06-03','2024-06-06','Confirmed',4,1,_binary '\0'),(4,4,'High Floor','2024-06-04','2024-06-08','Cancelled',5,3,_binary '\0'),(5,5,'Near Elevator','2024-06-05','2024-06-08','Future',2,1,_binary ''),(6,6,'King Bed','2024-06-06','2024-06-09','Completed',3,2,_binary '\0'),(7,7,'Two Queens','2024-06-07','2024-06-10','Checked In',4,1,_binary ''),(8,8,'Adjoining Rooms','2024-06-08','2024-06-11','Confirmed',5,3,_binary '\0'),(9,9,'High Floor','2024-06-09','2024-06-12','Cancelled',2,1,_binary '\0'),(10,1,'Near Elevator','2024-06-10','2024-06-13','Future',3,2,_binary '\0'),(11,2,'King Bed','2024-06-11','2024-06-15','Completed',4,1,_binary '\0'),(12,3,'Two Queens','2024-06-12','2024-06-15','Checked In',5,3,_binary ''),(13,4,'Adjoining Rooms','2024-06-13','2024-06-17','Confirmed',2,2,_binary '\0'),(14,5,'High Floor','2024-06-14','2024-06-18','Cancelled',3,1,_binary '\0'),(15,6,'Near Elevator','2024-06-15','2024-06-19','Future',4,3,_binary '\0'),(16,7,'King Bed','2024-06-16','2024-06-19','Completed',5,2,_binary ''),(17,8,'Two Queens','2024-06-17','2024-06-21','Checked In',2,1,_binary '\0'),(18,9,'Adjoining Rooms','2024-06-18','2024-06-22','Confirmed',3,2,_binary '\0'),(19,1,'High Floor','2024-06-19','2024-06-23','Cancelled',4,1,_binary '\0'),(20,2,'Near Elevator','2024-06-20','2024-06-24','Future',5,3,_binary '\0'),(21,3,'King Bed','2024-06-21','2024-06-25','Completed',2,1,_binary '\0'),(22,4,'Two Queens','2024-06-22','2024-06-26','Checked In',3,2,_binary ''),(23,5,'Adjoining Rooms','2024-06-23','2024-06-27','Confirmed',4,1,_binary '\0'),(24,6,'High Floor','2024-06-24','2024-06-28','Cancelled',5,3,_binary '\0'),(25,7,'Near Elevator','2024-06-25','2024-06-29','Future',2,2,_binary '\0'),(26,8,'King Bed','2024-06-26','2024-06-30','Completed',3,1,_binary '\0'),(27,9,'Two Queens','2024-06-27','2024-07-01','Checked In',4,2,_binary ''),(28,1,'Adjoining Rooms','2024-06-28','2024-07-02','Confirmed',5,3,_binary '\0'),(29,2,'High Floor','2024-06-29','2024-07-03','Cancelled',2,1,_binary '\0'),(30,3,'Near Elevator','2024-06-30','2024-07-04','Future',3,2,_binary ''),(31,4,'King Bed','2024-07-01','2024-07-04','Completed',4,1,_binary '\0'),(32,5,'Two Queens','2024-07-02','2024-07-06','Checked In',5,3,_binary '\0'),(33,6,'Adjoining Rooms','2024-07-03','2024-07-07','Confirmed',2,1,_binary '\0'),(34,7,'High Floor','2024-07-04','2024-07-08','Cancelled',3,2,_binary '\0'),(35,8,'Near Elevator','2024-07-05','2024-07-09','Future',4,1,_binary '\0'),(36,9,'King Bed','2024-07-06','2024-07-10','Completed',5,3,_binary ''),(37,1,'Two Queens','2024-07-07','2024-07-11','Checked In',2,2,_binary '\0'),(38,2,'Adjoining Rooms','2024-07-08','2024-07-12','Confirmed',3,1,_binary '\0'),(39,3,'High Floor','2024-07-09','2024-07-13','Cancelled',4,2,_binary ''),(40,4,'Near Elevator','2024-07-10','2024-07-14','Future',5,1,_binary '\0'),(41,5,'King Bed','2024-07-11','2024-07-15','Completed',2,3,_binary '\0'),(42,6,'Two Queens','2024-07-12','2024-07-16','Checked In',3,1,_binary '\0'),(43,7,'Adjoining Rooms','2024-07-13','2024-07-17','Confirmed',4,2,_binary ''),(44,8,'High Floor','2024-07-14','2024-07-18','Cancelled',5,1,_binary '\0'),(45,9,'Near Elevator','2024-07-15','2024-07-19','Future',2,3,_binary '\0'),(46,1,'King Bed','2024-07-16','2024-07-20','Completed',3,1,_binary '\0'),(47,2,'Two Queens','2024-07-17','2024-07-21','Checked In',4,2,_binary '\0'),(48,3,'Adjoining Rooms','2024-07-18','2024-07-22','Confirmed',5,3,_binary ''),(49,4,'High Floor','2024-07-19','2024-07-23','Cancelled',2,2,_binary '\0'),(50,5,'Near Elevator','2024-07-20','2024-07-24','Future',3,1,_binary '\0'),(51,6,'King Bed','2024-07-21','2024-07-25','Completed',4,2,_binary ''),(52,7,'Two Queens','2024-07-22','2024-07-26','Checked In',5,1,_binary '\0'),(53,8,'Adjoining Rooms','2024-07-23','2024-07-27','Confirmed',2,3,_binary '\0'),(54,9,'High Floor','2024-07-24','2024-07-28','Cancelled',3,1,_binary '\0'),(55,1,'Near Elevator','2024-07-25','2024-07-29','Future',4,2,_binary '\0'),(56,2,'King Bed','2024-07-26','2024-07-30','Completed',5,3,_binary '\0'),(57,3,'Two Queens','2024-07-27','2024-07-31','Checked In',2,1,_binary ''),(58,4,'Adjoining Rooms','2024-07-28','2024-08-01','Confirmed',3,2,_binary '\0'),(59,5,'High Floor','2024-07-29','2024-08-02','Cancelled',4,1,_binary '\0'),(60,6,'Near Elevator','2024-07-30','2024-08-03','Future',5,3,_binary '\0'),(61,7,'King Bed','2024-07-31','2024-08-04','Completed',2,1,_binary '\0'),(62,8,'Two Queens','2024-08-01','2024-08-05','Checked In',3,2,_binary '\0'),(63,9,'Adjoining Rooms','2024-08-02','2024-08-06','Confirmed',4,1,_binary ''),(64,1,'High Floor','2024-08-03','2024-08-07','Cancelled',5,3,_binary '\0'),(65,2,'Near Elevator','2024-08-04','2024-08-08','Future',2,1,_binary '\0'),(66,3,'King Bed','2024-08-05','2024-08-09','Completed',3,2,_binary '\0'),(67,4,'Two Queens','2024-08-06','2024-08-10','Checked In',4,1,_binary '\0'),(68,5,'Adjoining Rooms','2024-08-07','2024-08-11','Confirmed',5,3,_binary ''),(69,6,'High Floor','2024-08-08','2024-08-12','Cancelled',2,2,_binary '\0'),(70,7,'Near Elevator','2024-08-09','2024-08-13','Future',3,1,_binary '\0'),(71,8,'King Bed','2024-08-10','2024-08-14','Completed',4,2,_binary '\0'),(72,9,'Two Queens','2024-08-11','2024-08-15','Checked In',5,3,_binary ''),(73,1,'Adjoining Rooms','2024-08-12','2024-08-16','Confirmed',2,1,_binary '\0'),(74,2,'High Floor','2024-08-13','2024-08-17','Cancelled',3,2,_binary '\0'),(75,3,'Near Elevator','2024-08-14','2024-08-18','Future',4,1,_binary '\0'),(76,4,'King Bed','2024-08-15','2024-08-19','Completed',5,3,_binary '\0'),(77,5,'Two Queens','2024-08-16','2024-08-20','Checked In',2,2,_binary ''),(78,6,'Adjoining Rooms','2024-08-17','2024-08-21','Confirmed',3,1,_binary '\0'),(79,7,'High Floor','2024-08-18','2024-08-22','Cancelled',4,2,_binary '\0'),(80,8,'Near Elevator','2024-08-19','2024-08-23','Future',5,1,_binary '\0'),(81,9,'King Bed','2024-08-20','2024-08-24','Completed',2,3,_binary '\0'),(82,1,'Two Queens','2024-08-21','2024-08-25','Checked In',3,1,_binary ''),(83,2,'Adjoining Rooms','2024-08-22','2024-08-26','Confirmed',4,2,_binary '\0'),(84,3,'High Floor','2024-08-23','2024-08-27','Cancelled',5,1,_binary '\0'),(85,4,'Near Elevator','2024-08-24','2024-08-28','Future',2,3,_binary '\0'),(86,5,'King Bed','2024-08-25','2024-08-29','Completed',3,1,_binary '\0'),(87,6,'Two Queens','2024-08-26','2024-08-30','Checked In',4,2,_binary '\0'),(88,7,'Adjoining Rooms','2024-08-27','2024-08-31','Confirmed',5,3,_binary ''),(89,8,'High Floor','2024-08-28','2024-09-01','Cancelled',2,1,_binary '\0'),(90,9,'Near Elevator','2024-08-29','2024-09-02','Future',3,2,_binary '\0'),(91,1,'King Bed','2024-08-30','2024-09-03','Completed',4,1,_binary '\0'),(92,2,'Two Queens','2024-08-31','2024-09-04','Checked In',5,3,_binary ''),(93,3,'Adjoining Rooms','2024-09-01','2024-09-05','Confirmed',2,2,_binary '\0'),(94,4,'High Floor','2024-09-02','2024-09-06','Cancelled',3,1,_binary '\0'),(95,5,'Near Elevator','2024-09-03','2024-09-07','Future',4,3,_binary '\0'),(96,6,'King Bed','2024-09-04','2024-09-08','Completed',5,2,_binary '\0'),(97,7,'Two Queens','2024-09-05','2024-09-09','Checked In',2,1,_binary ''),(98,8,'Adjoining Rooms','2024-09-06','2024-09-10','Confirmed',3,2,_binary '\0'),(99,9,'High Floor','2024-09-07','2024-09-11','Cancelled',4,1,_binary '\0'),(100,1,'Near Elevator','2024-09-08','2024-09-12','Future',5,3,_binary '\0'),(101,2,'King Bed','2024-09-09','2024-09-13','Completed',2,1,_binary '\0'),(102,3,'Two Queens','2024-09-10','2024-09-14','Checked In',3,2,_binary '\0'),(103,4,'Adjoining Rooms','2024-09-11','2024-09-15','Confirmed',4,1,_binary ''),(104,5,'High Floor','2024-09-12','2024-09-16','Cancelled',5,2,_binary '\0'),(105,6,'Near Elevator','2024-09-13','2024-09-17','Future',2,3,_binary '\0'),(106,7,'King Bed','2024-09-14','2024-09-18','Completed',3,1,_binary ''),(107,8,'Two Queens','2024-09-15','2024-09-19','Checked In',4,2,_binary '\0'),(108,9,'Adjoining Rooms','2024-09-16','2024-09-20','Confirmed',5,1,_binary '\0'),(109,1,'High Floor','2024-09-17','2024-09-21','Cancelled',2,2,_binary '\0'),(110,2,'Near Elevator','2024-09-18','2024-09-22','Future',3,3,_binary '\0'),(111,3,'King Bed','2024-09-19','2024-09-23','Completed',4,1,_binary '\0'),(112,4,'Two Queens','2024-09-20','2024-09-24','Checked In',5,2,_binary ''),(113,5,'Adjoining Rooms','2024-09-21','2024-09-25','Confirmed',2,1,_binary '\0'),(114,6,'High Floor','2024-09-22','2024-09-26','Cancelled',3,3,_binary '\0'),(115,7,'Near Elevator','2024-09-23','2024-09-27','Future',4,1,_binary '\0'),(116,8,'King Bed','2024-09-24','2024-09-28','Completed',5,2,_binary ''),(117,9,'Two Queens','2024-09-25','2024-09-29','Checked In',2,3,_binary '\0'),(118,1,'Adjoining Rooms','2024-09-26','2024-09-30','Confirmed',3,1,_binary '\0'),(119,2,'High Floor','2024-10-01','2024-10-05','Cancelled',4,2,_binary '\0'),(120,3,'Near Elevator','2024-10-02','2024-10-06','Future',5,1,_binary '\0'),(121,4,'King Bed','2024-10-03','2024-10-07','Completed',2,2,_binary '\0'),(122,5,'Two Queens','2024-10-04','2024-10-08','Checked In',3,1,_binary ''),(123,6,'Adjoining Rooms','2024-10-05','2024-10-09','Confirmed',4,3,_binary '\0'),(124,7,'High Floor','2024-10-06','2024-10-10','Cancelled',5,2,_binary '\0'),(125,8,'Near Elevator','2024-10-07','2024-10-11','Future',2,1,_binary '\0'),(126,9,'King Bed','2024-10-08','2024-10-12','Completed',3,3,_binary ''),(127,1,'Two Queens','2024-10-09','2024-10-13','Checked In',4,1,_binary '\0'),(128,2,'Adjoining Rooms','2024-10-10','2024-10-14','Confirmed',5,2,_binary '\0'),(129,3,'High Floor','2024-10-11','2024-10-15','Cancelled',2,3,_binary '\0'),(130,4,'Near Elevator','2024-10-12','2024-10-16','Future',3,1,_binary ''),(131,5,'King Bed','2024-10-13','2024-10-17','Completed',4,2,_binary '\0'),(132,6,'Two Queens','2024-10-14','2024-10-18','Checked In',5,3,_binary '\0'),(133,7,'Adjoining Rooms','2024-10-15','2024-10-19','Confirmed',2,1,_binary ''),(134,8,'High Floor','2024-10-16','2024-10-20','Cancelled',3,2,_binary '\0'),(135,9,'Near Elevator','2024-10-17','2024-10-21','Future',4,3,_binary '\0'),(136,1,'King Bed','2024-10-18','2024-10-22','Completed',5,1,_binary '\0'),(137,2,'Two Queens','2024-10-19','2024-10-23','Checked In',2,2,_binary ''),(138,3,'Adjoining Rooms','2024-10-20','2024-10-24','Confirmed',3,1,_binary '\0'),(139,4,'High Floor','2024-10-21','2024-10-25','Cancelled',4,3,_binary '\0'),(140,5,'Near Elevator','2024-10-22','2024-10-26','Future',5,1,_binary '\0'),(141,6,'King Bed','2024-10-23','2024-10-27','Completed',2,2,_binary ''),(142,7,'Two Queens','2024-10-24','2024-10-28','Checked In',3,1,_binary '\0'),(143,8,'Adjoining Rooms','2024-10-25','2024-10-29','Confirmed',4,2,_binary '\0'),(144,9,'High Floor','2024-10-26','2024-10-30','Cancelled',5,3,_binary '\0'),(145,1,'Near Elevator','2024-10-27','2024-10-31','Future',2,1,_binary ''),(146,2,'King Bed','2024-10-28','2024-11-01','Completed',3,2,_binary '\0'),(147,3,'Two Queens','2024-10-29','2024-11-02','Checked In',4,1,_binary '\0'),(148,4,'Adjoining Rooms','2024-10-30','2024-11-03','Confirmed',5,3,_binary ''),(149,5,'High Floor','2024-10-31','2024-11-04','Cancelled',2,2,_binary '\0'),(150,6,'Near Elevator','2024-11-01','2024-11-05','Future',3,1,_binary '\0');
/*!40000 ALTER TABLE `reservation_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_id` int NOT NULL,
  `building_id` int NOT NULL,
  `wing_id` int NOT NULL,
  `bed_info_id` int DEFAULT NULL,
  `room_number` varchar(20) NOT NULL,
  `room_type` varchar(50) DEFAULT NULL,
  `floor` int DEFAULT NULL,
  `is_smoking` bit(1) DEFAULT b'0',
  `status` varchar(50) DEFAULT NULL,
  `base_rate` decimal(10,2) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  PRIMARY KEY (`room_id`),
  KEY `building_id` (`building_id`),
  KEY `wing_id` (`wing_id`),
  KEY `bed_info_id` (`bed_info_id`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`),
  CONSTRAINT `room_ibfk_2` FOREIGN KEY (`wing_id`) REFERENCES `wing` (`wing_id`),
  CONSTRAINT `room_ibfk_3` FOREIGN KEY (`bed_info_id`) REFERENCES `bed_info` (`bed_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,1,1,1,'101','Suite',1,_binary '\0','Available',350.00,2),(2,1,1,2,'102','Double',1,_binary '\0','Occupied',200.00,4),(3,1,1,4,'103','Standard',1,_binary '\0','Occupied',180.00,2),(4,1,1,4,'104','Standard',1,_binary '\0','Occupied',180.00,2),(5,1,2,1,'201','Penthouse',2,_binary '','Available',600.00,2),(6,1,2,1,'202','Suite',2,_binary '\0','Cleaning',350.00,2),(7,1,2,2,'203','Double',2,_binary '\0','Renovation',200.00,4),(8,1,3,1,'301','Standard',3,_binary '\0','Available',180.00,2),(9,1,3,1,'302','Standard',3,_binary '\0','Available',180.00,2),(10,2,4,NULL,'Conf A','Meeting',1,_binary '\0','Available',150.00,50),(11,2,4,NULL,'Grand BR','Banquet',1,_binary '\0','Reserved',1000.00,300),(12,3,5,1,'V01','Villa',1,_binary '','Occupied',800.00,6),(13,1,6,1,'401','Suite',4,_binary '\0','Available',320.00,2),(14,1,6,2,'402','Double',4,_binary '\0','Occupied',210.00,4),(15,1,6,4,'403','Standard',4,_binary '\0','Cleaning',170.00,2),(16,1,7,1,'501','Executive Suite',5,_binary '\0','Available',500.00,2),(17,1,7,1,'502','Executive Suite',5,_binary '\0','Available',500.00,2),(18,1,7,2,'503','Executive Double',5,_binary '\0','Occupied',260.00,4),(19,2,8,4,'L-101','Standard',1,_binary '\0','Available',160.00,2),(20,2,8,4,'L-102','Standard',1,_binary '\0','Available',160.00,2),(21,2,8,2,'L-103','Double',1,_binary '\0','Maintenance',200.00,4),(22,2,10,NULL,'EV-A','Event Room',1,_binary '\0','Available',300.00,80),(23,2,10,NULL,'EV-B','Event Room',1,_binary '\0','Reserved',350.00,120),(24,3,11,1,'V-02','Villa',1,_binary '','Available',850.00,6),(25,3,11,1,'V-03','Villa',1,_binary '\0','Occupied',900.00,6),(26,4,16,1,'401','Harbor Suite',4,_binary '\0','Available',330.00,2),(27,4,16,2,'402','Double',4,_binary '\0','Occupied',210.00,4),(28,4,16,4,'403','Standard',4,_binary '\0','Cleaning',170.00,2),(29,4,17,1,'501','Executive Suite',5,_binary '\0','Available',520.00,2),(30,4,17,2,'502','Executive Double',5,_binary '\0','Occupied',260.00,4),(31,4,18,4,'B-101','Business Standard',1,_binary '\0','Available',180.00,2),(32,4,18,1,'B-102','Business King',1,_binary '\0','Available',240.00,2),(33,4,19,NULL,'CONF-1','Conference Room',2,_binary '\0','Reserved',800.00,80),(34,4,19,NULL,'CONF-2','Conference Room',2,_binary '\0','Available',750.00,60),(35,4,19,NULL,'MEET-1','Meeting Room',2,_binary '\0','Available',300.00,20),(36,4,19,NULL,'MEET-2','Meeting Room',2,_binary '\0','Occupied',320.00,25),(37,5,20,1,'A-201','Residence Suite',2,_binary '\0','Available',280.00,2),(38,5,20,2,'A-202','Residence Double',2,_binary '\0','Occupied',220.00,4),(39,5,20,4,'A-203','Residence Standard',2,_binary '\0','Cleaning',160.00,2),(40,5,21,1,'B-201','Deluxe Suite',2,_binary '\0','Available',320.00,2),(41,5,21,2,'B-202','Deluxe Double',2,_binary '\0','Available',240.00,4),(42,5,22,4,'G-101','Garden Standard',1,_binary '\0','Available',150.00,2),(43,5,22,4,'G-102','Garden Standard',1,_binary '\0','Occupied',155.00,2),(44,5,22,2,'G-103','Garden Double',1,_binary '\0','Available',190.00,4),(45,5,23,NULL,'SPA-1','Wellness Therapy Room',1,_binary '\0','Available',500.00,4),(46,5,23,NULL,'SPA-2','Wellness Therapy Room',1,_binary '\0','Occupied',550.00,4),(47,5,23,NULL,'YOGA-1','Yoga Room',1,_binary '\0','Available',200.00,20),(48,5,23,NULL,'FIT-1','Fitness Studio',1,_binary '\0','Renovation',300.00,30),(49,6,24,1,'R-01','Reef Suite',1,_binary '\0','Available',450.00,2),(50,6,24,2,'R-02','Reef Double',1,_binary '\0','Available',300.00,4),(51,6,24,4,'R-03','Reef Standard',1,_binary '\0','Occupied',220.00,2),(52,6,25,1,'L-01','Lagoon Suite',1,_binary '\0','Available',480.00,2),(53,6,25,2,'L-02','Lagoon Double',1,_binary '\0','Cleaning',310.00,4),(54,6,26,1,'CS-101','Coral Luxury Suite',1,_binary '\0','Available',600.00,2),(55,6,26,1,'CS-102','Coral Luxury Suite',1,_binary '\0','Occupied',620.00,2),(56,6,26,2,'CS-103','Coral Family Suite',1,_binary '\0','Available',650.00,4),(57,6,27,1,'OV-01','Oceanfront Villa',1,_binary '\0','Available',1200.00,6),(58,6,27,1,'OV-02','Oceanfront Villa',1,_binary '\0','Occupied',1300.00,6),(59,6,27,1,'OV-03','Oceanfront Villa',1,_binary '\0','Reserved',1350.00,6),(60,6,27,1,'OV-04','Oceanfront Villa',1,_binary '\0','Cleaning',1100.00,6);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_adjacency`
--

DROP TABLE IF EXISTS `room_adjacency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_adjacency` (
  `room_id_a` int NOT NULL,
  `room_id_b` int NOT NULL,
  `door_between` bit(1) DEFAULT b'0',
  PRIMARY KEY (`room_id_a`,`room_id_b`),
  KEY `room_id_b` (`room_id_b`),
  CONSTRAINT `room_adjacency_ibfk_1` FOREIGN KEY (`room_id_a`) REFERENCES `room` (`room_id`),
  CONSTRAINT `room_adjacency_ibfk_2` FOREIGN KEY (`room_id_b`) REFERENCES `room` (`room_id`),
  CONSTRAINT `room_adjacency_chk_1` CHECK ((`room_id_a` <> `room_id_b`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_adjacency`
--

LOCK TABLES `room_adjacency` WRITE;
/*!40000 ALTER TABLE `room_adjacency` DISABLE KEYS */;
INSERT INTO `room_adjacency` VALUES (1,3,_binary '\0'),(2,3,_binary '\0'),(2,4,_binary ''),(5,6,_binary ''),(6,7,_binary '\0'),(8,9,_binary ''),(10,11,_binary '\0'),(12,24,_binary '\0'),(19,20,_binary ''),(20,21,_binary '\0'),(24,25,_binary ''),(26,27,_binary ''),(27,28,_binary '\0'),(29,30,_binary ''),(31,32,_binary '\0'),(37,38,_binary ''),(38,39,_binary '\0'),(40,41,_binary ''),(42,43,_binary '\0'),(43,44,_binary ''),(49,50,_binary ''),(50,51,_binary '\0'),(52,53,_binary '\0'),(54,55,_binary ''),(55,56,_binary '\0'),(57,58,_binary ''),(58,59,_binary '\0'),(59,60,_binary '');
/*!40000 ALTER TABLE `room_adjacency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_assignment`
--

DROP TABLE IF EXISTS `room_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_assignment` (
  `room_assignment_id` int NOT NULL,
  `reservation_id` int NOT NULL,
  `room_id` int NOT NULL,
  `assign_date` datetime DEFAULT NULL,
  `check_in_date` datetime DEFAULT NULL,
  `check_out_date` datetime DEFAULT NULL,
  PRIMARY KEY (`room_assignment_id`),
  KEY `reservation_id` (`reservation_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `room_assignment_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation_request` (`reservation_id`),
  CONSTRAINT `room_assignment_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_assignment`
--

LOCK TABLES `room_assignment` WRITE;
/*!40000 ALTER TABLE `room_assignment` DISABLE KEYS */;
INSERT INTO `room_assignment` VALUES (1,1,2,'2024-06-01 12:00:00','2024-06-01 14:00:00','2024-06-04 11:00:00'),(2,2,10,'2024-06-02 09:00:00','2024-06-02 09:30:00','2024-06-06 12:00:00'),(3,3,3,'2024-06-03 15:00:00','2024-06-03 16:00:00','2024-06-06 10:00:00'),(4,4,4,'2024-06-04 13:00:00','2024-06-04 14:10:00','2024-06-08 11:00:00'),(5,5,12,'2024-06-05 11:00:00','2024-06-05 11:45:00','2024-06-08 10:00:00'),(6,10,1,'2024-06-10 12:30:00','2024-06-10 13:00:00','2024-06-13 11:00:00'),(7,11,2,'2024-06-11 10:30:00','2024-06-11 11:00:00','2024-06-15 10:00:00'),(8,12,6,'2024-06-12 09:50:00','2024-06-12 10:15:00','2024-06-15 11:30:00'),(9,13,7,'2024-06-13 14:20:00','2024-06-13 15:00:00','2024-06-17 09:00:00'),(10,14,3,'2024-06-14 13:10:00','2024-06-14 14:00:00','2024-06-18 11:00:00'),(11,15,4,'2024-06-15 12:00:00','2024-06-15 12:30:00','2024-06-19 11:00:00'),(12,16,5,'2024-06-16 11:30:00','2024-06-16 12:00:00','2024-06-19 12:00:00'),(13,17,8,'2024-06-17 13:00:00','2024-06-17 13:30:00','2024-06-21 11:00:00'),(14,18,9,'2024-06-18 14:40:00','2024-06-18 15:15:00','2024-06-22 10:00:00'),(15,19,1,'2024-06-19 15:00:00','2024-06-19 16:00:00','2024-06-23 12:00:00'),(16,20,2,'2024-06-20 10:00:00','2024-06-20 10:30:00','2024-06-24 11:00:00'),(17,21,3,'2024-06-21 11:00:00','2024-06-21 11:40:00','2024-06-25 09:30:00'),(18,22,4,'2024-06-22 12:00:00','2024-06-22 12:20:00','2024-06-26 10:00:00'),(19,23,5,'2024-06-23 13:00:00','2024-06-23 13:30:00','2024-06-27 12:00:00'),(20,24,6,'2024-06-24 14:00:00','2024-06-24 14:20:00','2024-06-28 11:00:00'),(21,30,7,'2024-06-30 10:00:00','2024-06-30 10:45:00','2024-07-04 10:00:00'),(22,40,8,'2024-07-10 14:00:00','2024-07-10 14:10:00','2024-07-14 11:00:00'),(23,50,9,'2024-07-20 11:20:00','2024-07-20 12:00:00','2024-07-24 09:00:00'),(24,60,10,'2024-07-30 15:00:00','2024-07-30 15:45:00','2024-08-03 11:00:00'),(25,70,11,'2024-08-09 12:20:00','2024-08-09 12:45:00','2024-08-13 10:00:00'),(26,80,12,'2024-08-19 09:00:00','2024-08-19 09:30:00','2024-08-23 11:00:00'),(27,90,1,'2024-08-29 10:00:00','2024-08-29 10:30:00','2024-09-02 10:00:00'),(28,100,2,'2024-09-08 14:20:00','2024-09-08 14:50:00','2024-09-12 12:00:00'),(29,110,3,'2024-09-18 11:10:00','2024-09-18 11:40:00','2024-09-22 11:00:00'),(30,120,4,'2024-09-28 13:00:00','2024-09-28 13:20:00','2024-10-02 12:00:00');
/*!40000 ALTER TABLE `room_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_type`
--

DROP TABLE IF EXISTS `service_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_type` (
  `service_id` int NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_type`
--

LOCK TABLES `service_type` WRITE;
/*!40000 ALTER TABLE `service_type` DISABLE KEYS */;
INSERT INTO `service_type` VALUES (1,'Room Service - Breakfast',25.00),(2,'Spa - Full Massage',120.00),(3,'Dry Cleaning',15.00),(4,'Conference Catering Per Head',30.00),(5,'Valet Parking (Daily)',35.00),(6,'In-Room Movie',12.99),(7,'Wedding Cake',500.00);
/*!40000 ALTER TABLE `service_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_usage`
--

DROP TABLE IF EXISTS `service_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_usage` (
  `service_usage_id` int NOT NULL,
  `service_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `billing_account_id` int DEFAULT NULL,
  `usage_time` datetime DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `total_amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`service_usage_id`),
  KEY `service_id` (`service_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  KEY `billing_account_id` (`billing_account_id`),
  CONSTRAINT `service_usage_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `service_type` (`service_id`),
  CONSTRAINT `service_usage_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `service_usage_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `service_usage_ibfk_4` FOREIGN KEY (`billing_account_id`) REFERENCES `billing_account` (`billing_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_usage`
--

LOCK TABLES `service_usage` WRITE;
/*!40000 ALTER TABLE `service_usage` DISABLE KEYS */;
INSERT INTO `service_usage` VALUES (1,6,4,NULL,3,NULL,2,25.98),(2,3,6,2,4,NULL,3,45.00),(3,2,2,3,6,NULL,1,120.00);
/*!40000 ALTER TABLE `service_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeslot`
--

DROP TABLE IF EXISTS `timeslot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timeslot` (
  `timeslot_id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `is_eating_slot` bit(1) DEFAULT b'0',
  PRIMARY KEY (`timeslot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeslot`
--

LOCK TABLES `timeslot` WRITE;
/*!40000 ALTER TABLE `timeslot` DISABLE KEYS */;
INSERT INTO `timeslot` VALUES (1,'Breakfast','07:00:00','09:00:00',_binary ''),(2,'Morning Session','09:00:00','12:00:00',_binary '\0'),(3,'Lunch','12:00:00','13:30:00',_binary ''),(4,'Afternoon Session','13:30:00','17:00:00',_binary '\0'),(5,'Evening','18:00:00','22:00:00',_binary ''),(6,'All Day Access','08:00:00','20:00:00',_binary '\0');
/*!40000 ALTER TABLE `timeslot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wing`
--

DROP TABLE IF EXISTS `wing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wing` (
  `wing_id` int NOT NULL,
  `building_id` int NOT NULL,
  `wing_name` varchar(100) NOT NULL,
  PRIMARY KEY (`wing_id`),
  KEY `building_id` (`building_id`),
  CONSTRAINT `wing_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wing`
--

LOCK TABLES `wing` WRITE;
/*!40000 ALTER TABLE `wing` DISABLE KEYS */;
INSERT INTO `wing` VALUES (1,1,'East Wing - Sunrise'),(2,1,'West Wing - Sunset'),(3,1,'North Wing - Views'),(4,2,'Main Hall'),(5,3,'Villa Cluster A'),(6,1,'South Wing - Horizon'),(7,1,'Executive Wing - Skyline Level'),(8,2,'Garden Wing - Lotus Section'),(9,2,'Garden Wing - Bamboo Section'),(10,2,'Event Hall Wing'),(11,3,'Villa Cluster B'),(12,3,'Villa Cluster C'),(13,3,'Private Suites Wing'),(14,1,'Conference Wing - Summit Level'),(15,2,'Spa & Wellness Wing'),(16,4,'Harbor East Wing'),(17,4,'Harbor West Wing'),(18,4,'Business Wing'),(19,4,'Skyline Conference Wing'),(20,5,'Palm Residence A'),(21,5,'Palm Residence B'),(22,5,'Palm Garden Wing'),(23,5,'Palm Wellness Wing'),(24,6,'Reef Wing'),(25,6,'Lagoon Wing'),(26,6,'Coral Suites Wing'),(27,6,'Oceanfront Villa Wing');
/*!40000 ALTER TABLE `wing` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-10 10:50:12
