CREATE DATABASE  IF NOT EXISTS `harrypotter` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `harrypotter`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: harrypotter
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `broom`
--

DROP TABLE IF EXISTS `broom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `broom` (
  `Broom_id` int NOT NULL,
  `Brand` varchar(64) NOT NULL,
  `Model` varchar(64) DEFAULT NULL,
  `Acceleration` int DEFAULT NULL,
  PRIMARY KEY (`Broom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `broom`
--

LOCK TABLES `broom` WRITE;
/*!40000 ALTER TABLE `broom` DISABLE KEYS */;
INSERT INTO `broom` VALUES (1,'Nimbus','2000',100),(2,'Nimbus',NULL,120),(3,'Firebolt','',150),(4,'Cleansweep','5',40),(5,'Cleansweep','11',70),(6,'Comet','260',60),(7,'Cleansweep','1',25),(8,'Cleansweep','2',30),(9,'Cleansweep','3',40),(10,'Cleansweep','7',80),(11,'Comet','140',35),(12,'Comet','180',50),(13,'Comet','290',60),(14,'Moontrimmer',NULL,20),(15,'Nimbus','1000',100),(16,'Nimbus','1001',100),(17,'Nimbus','1500',100),(18,'Nimbus','1700',100),(19,'Oakshaft','79',15);
/*!40000 ALTER TABLE `broom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentator`
--

DROP TABLE IF EXISTS `commentator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentator` (
  `Name` varchar(64) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentator`
--

LOCK TABLES `commentator` WRITE;
/*!40000 ALTER TABLE `commentator` DISABLE KEYS */;
INSERT INTO `commentator` VALUES ('Lee Jordan'),('Luna Lovegood'),('Seamus Finnigan'),('Zacharias Smith');
/*!40000 ALTER TABLE `commentator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `head_of_house`
--

DROP TABLE IF EXISTS `head_of_house`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `head_of_house` (
  `Name` varchar(64) NOT NULL,
  `Start_year` year NOT NULL,
  `End_year` year DEFAULT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `head_of_house`
--

LOCK TABLES `head_of_house` WRITE;
/*!40000 ALTER TABLE `head_of_house` DISABLE KEYS */;
INSERT INTO `head_of_house` VALUES ('Filius Flitwick',1975,NULL),('Minerva McGonagall',1910,NULL),('Pomona Sprout',1980,2017),('Severus Snape',1981,1997);
/*!40000 ALTER TABLE `head_of_house` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `injury_report`
--

DROP TABLE IF EXISTS `injury_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `injury_report` (
  `Player_id` int NOT NULL,
  `Afflicted_body_part` varchar(64) DEFAULT NULL,
  `Description` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`Player_id`),
  CONSTRAINT `injury_report_ibfk_1` FOREIGN KEY (`Player_id`) REFERENCES `player` (`Player_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `injury_report`
--

LOCK TABLES `injury_report` WRITE;
/*!40000 ALTER TABLE `injury_report` DISABLE KEYS */;
INSERT INTO `injury_report` VALUES (3,'','Seasonal flu'),(18,'Right knee',' Sprained, MRI needed'),(27,'Head','Concussion');
/*!40000 ALTER TABLE `injury_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match`
--

DROP TABLE IF EXISTS `match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match` (
  `Matchup_number` int NOT NULL,
  `Season` int NOT NULL,
  `Team_caught_snitch` varchar(64) DEFAULT NULL,
  `Weather_desc` varchar(64) DEFAULT NULL,
  `Team1_Score` int DEFAULT NULL,
  `Team2_Score` int DEFAULT NULL,
  PRIMARY KEY (`Matchup_number`,`Season`),
  KEY `Season` (`Season`),
  KEY `Team_caught_snitch` (`Team_caught_snitch`),
  CONSTRAINT `match_ibfk_1` FOREIGN KEY (`Matchup_number`) REFERENCES `matchup` (`Matchup_number`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `match_ibfk_2` FOREIGN KEY (`Season`) REFERENCES `season` (`Year`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `match_ibfk_3` FOREIGN KEY (`Team_caught_snitch`) REFERENCES `team` (`House`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match`
--

LOCK TABLES `match` WRITE;
/*!40000 ALTER TABLE `match` DISABLE KEYS */;
INSERT INTO `match` VALUES (1,1991,'Gryffindor','Clear sunny day',200,30),(1,1992,'Gryffindor','Cold',170,60),(1,1993,'Gryffindor',NULL,150,60),(1,1994,'Gryffindor',NULL,230,20),(1,1996,'Gryffindor','Hot and dry',190,10),(1,1997,'Gryffindor',NULL,380,130),(2,1992,'Ravenclaw','Windy and warm',170,150),(2,1994,'Ravenclaw','Windy, relatively warm',70,190),(2,1996,'Ravenclaw',NULL,40,200),(2,2022,'Ravenclaw','Rainy',80,170),(3,1992,'Slytherin',NULL,50,210),(3,1994,'Slytherin',NULL,180,200),(4,1992,'Gryffindor','Heavy rain, cold',180,20),(4,1994,'Hufflepuff','Heavy rain, ferocious wind, thunder and lightning',50,150),(4,1996,'Gryffindor',NULL,230,240),(4,1997,'Hufflepuff',NULL,60,320),(5,1992,'Slytherin','Light breeze, temperate',40,230),(5,1994,'Slytherin',NULL,120,300),(5,1996,'Hufflepuff','Overcast, termperate',190,170),(6,1992,'Ravenclaw',NULL,30,280),(6,1994,'Gryffindor','Partly cloudy',230,30),(6,1996,'Gryffindor','Fine clear day',210,160),(6,1997,'Gryffindor','Cold, windy day',450,140);
/*!40000 ALTER TABLE `match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchtocommentator`
--

DROP TABLE IF EXISTS `matchtocommentator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matchtocommentator` (
  `MatchNo` int NOT NULL,
  `SeasonNo` int NOT NULL,
  `CommentatorName` varchar(64) NOT NULL,
  PRIMARY KEY (`MatchNo`,`SeasonNo`,`CommentatorName`),
  KEY `SeasonNo` (`SeasonNo`),
  KEY `CommentatorName` (`CommentatorName`),
  CONSTRAINT `matchtocommentator_ibfk_1` FOREIGN KEY (`MatchNo`) REFERENCES `match` (`Matchup_number`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `matchtocommentator_ibfk_2` FOREIGN KEY (`SeasonNo`) REFERENCES `season` (`Year`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `matchtocommentator_ibfk_3` FOREIGN KEY (`CommentatorName`) REFERENCES `commentator` (`Name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchtocommentator`
--

LOCK TABLES `matchtocommentator` WRITE;
/*!40000 ALTER TABLE `matchtocommentator` DISABLE KEYS */;
INSERT INTO `matchtocommentator` VALUES (1,1991,'Lee Jordan'),(1,1992,'Lee Jordan'),(2,1992,'Lee Jordan'),(2,1992,'Luna Lovegood'),(3,1992,'Lee Jordan'),(4,1992,'Lee Jordan'),(5,1992,'Lee Jordan'),(6,1992,'Lee Jordan'),(1,1993,'Lee Jordan'),(1,1994,'Lee Jordan'),(2,1994,'Seamus Finnigan'),(3,1994,'Seamus Finnigan'),(4,1994,'Lee Jordan'),(5,1994,'Seamus Finnigan'),(6,1994,'Lee Jordan'),(1,1996,'Lee Jordan'),(2,1996,'Lee Jordan'),(4,1996,'Lee Jordan'),(5,1996,'Lee Jordan'),(6,1996,'Lee Jordan'),(6,1996,'Seamus Finnigan'),(1,1997,'Zacharias Smith'),(4,1997,'Luna Lovegood'),(6,1997,'Zacharias Smith');
/*!40000 ALTER TABLE `matchtocommentator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchtoreferee`
--

DROP TABLE IF EXISTS `matchtoreferee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matchtoreferee` (
  `MatchNo` int NOT NULL,
  `SeasonNo` int NOT NULL,
  `RefereeName` varchar(64) NOT NULL,
  PRIMARY KEY (`MatchNo`,`SeasonNo`,`RefereeName`),
  KEY `SeasonNo` (`SeasonNo`),
  KEY `RefereeName` (`RefereeName`),
  CONSTRAINT `matchtoreferee_ibfk_1` FOREIGN KEY (`MatchNo`) REFERENCES `match` (`Matchup_number`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `matchtoreferee_ibfk_2` FOREIGN KEY (`SeasonNo`) REFERENCES `season` (`Year`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `matchtoreferee_ibfk_3` FOREIGN KEY (`RefereeName`) REFERENCES `referee` (`Name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchtoreferee`
--

LOCK TABLES `matchtoreferee` WRITE;
/*!40000 ALTER TABLE `matchtoreferee` DISABLE KEYS */;
INSERT INTO `matchtoreferee` VALUES (1,1991,'Rolanda Hooch'),(1,1992,'Rolanda Hooch'),(1,1992,'Severus Snape'),(2,1992,'Rolanda Hooch'),(3,1992,'Rolanda Hooch'),(4,1992,'Severus Snape'),(5,1992,'Rolanda Hooch'),(6,1992,'Rolanda Hooch'),(1,1993,'Rolanda Hooch'),(1,1994,'Rolanda Hooch'),(2,1994,'Rolanda Hooch'),(3,1994,'Rolanda Hooch'),(4,1994,'Rolanda Hooch'),(5,1994,'Rolanda Hooch'),(6,1994,'Rolanda Hooch'),(1,1996,'Rolanda Hooch'),(2,1996,'Rolanda Hooch'),(4,1996,'Rolanda Hooch'),(5,1996,'Rolanda Hooch'),(6,1996,'Rolanda Hooch'),(1,1997,'Rolanda Hooch'),(4,1997,'Rolanda Hooch'),(6,1997,'Rolanda Hooch');
/*!40000 ALTER TABLE `matchtoreferee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchup`
--

DROP TABLE IF EXISTS `matchup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matchup` (
  `Matchup_number` int NOT NULL,
  `Team1` varchar(64) NOT NULL,
  `Team2` varchar(64) NOT NULL,
  `Month` varchar(64) NOT NULL,
  PRIMARY KEY (`Matchup_number`),
  KEY `Team1` (`Team1`),
  KEY `Team2` (`Team2`),
  CONSTRAINT `matchup_ibfk_1` FOREIGN KEY (`Team1`) REFERENCES `team` (`House`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `matchup_ibfk_2` FOREIGN KEY (`Team2`) REFERENCES `team` (`House`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchup`
--

LOCK TABLES `matchup` WRITE;
/*!40000 ALTER TABLE `matchup` DISABLE KEYS */;
INSERT INTO `matchup` VALUES (1,'Gryffindor','Slytherin','November'),(2,'Hufflepuff','Ravenclaw','November'),(3,'Ravenclaw','Slytherin','Feburary'),(4,'Gryffindor','Hufflepuff','March'),(5,'Hufflepuff','Slytherin','May'),(6,'Gryffindor','Ravenclaw','May');
/*!40000 ALTER TABLE `matchup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `Player_id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `Position` enum('seeker','keeper','beater','chaser') NOT NULL,
  `Grad_year` year NOT NULL,
  `Broom` int DEFAULT NULL,
  `Points_scored` int DEFAULT NULL,
  `Team` varchar(64) NOT NULL,
  PRIMARY KEY (`Player_id`),
  KEY `Broom` (`Broom`),
  KEY `Team` (`Team`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`Broom`) REFERENCES `broom` (`Broom_id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `player_ibfk_2` FOREIGN KEY (`Team`) REFERENCES `team` (`House`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'Harry Potter','seeker',1998,3,900,'Gryffindor'),(2,'Oliver Wood','keeper',1994,10,0,'Gryffindor'),(3,'Fred Weasly','beater',1996,4,20,'Gryffindor'),(4,'George Weasly','beater',1996,4,30,'Gryffindor'),(5,'Draco Malfoy','seeker',1998,6,300,'Slytherin'),(6,'Angelina Johnson','chaser',1996,17,70,'Gryffindor'),(7,'Marcus Flint','chaser',1994,2,120,'Slytherin'),(8,'James Potter','seeker',1979,1,450,'Gryffindor'),(9,'Ronald Weasly','keeper',1998,5,10,'Gryffindor'),(10,'Cho Chang','seeker',1997,6,300,'Ravenclaw'),(11,'Minerva McGonagall','seeker',1954,11,1500,'Gryffindor'),(12,'Ginny Weasley','chaser',1999,5,210,'Gryffindor'),(13,'Katie Bell','chaser',1997,10,80,'Gryffindor'),(14,'Demelza Robins','chaser',2002,8,100,'Gryffindor'),(15,'Jimmy Peakes','beater',2001,19,30,'Gryffindor'),(16,'Ritchie Coote','beater',2000,14,20,'Gryffindor'),(17,'Cormac McLaggen','keeper',1998,11,0,'Gryffindor'),(18,'Dean Thomas','chaser',1998,17,300,'Gryffindor'),(19,'Vaisey Urquhart','chaser',2002,2,230,'Slytherin'),(20,'Blaise Zabini','chaser',1998,2,60,'Slytherin'),(21,'Vincent Crabbe','beater',1998,2,100,'Slytherin'),(22,'Gergory Goyle','beater',1998,2,110,'Slytherin'),(23,'Rose Granger-Weasley','chaser',2024,4,410,'Gryffindor'),(24,'Alicia Spinnet','chaser',1996,7,70,'Gryffindor'),(25,'Jack Sloper','beater',2002,19,40,'Gryffindor'),(26,'Andrew Kirke','beater',2002,14,20,'Gryffindor'),(27,'Zacharias Smith','chaser',1999,12,80,'Hufflepuff'),(28,'Roger Davis','chaser',1987,7,140,'Ravenclaw'),(29,'Miles Bletchley','keeper',1996,2,0,'Slytherin'),(30,'Cedric Diggory','seeker',1997,18,750,'Hufflepuff'),(31,'Malcolm Preece','chaser',2000,14,60,'Hufflepuff'),(32,'Heidi Macavoy','chaser',1996,7,270,'Hufflepuff'),(33,'Tamsin Applebee','chaser',2000,4,80,'Hufflepuff'),(34,'Maxine O\'Flaherty','beater',1999,3,130,'Hufflepuff'),(35,'Anthony Rickett','beater',2000,17,50,'Hufflepuff'),(36,'Herbert Fleet','keeper',1999,2,0,'Hufflepuff'),(37,'Michael McManus','beater',1997,16,50,'Hufflepuff'),(38,'Jeremy Stretton','chaser',1998,10,90,'Ravenclaw'),(39,'Randolph Burrow','chaser',2001,10,110,'Ravenclaw'),(40,'Duncan Inglebee','beater',1999,10,30,'Ravenclaw'),(41,'Jason Samuels','beater',1999,10,10,'Ravenclaw'),(42,'Grant Page','keeper',1999,10,0,'Ravenclaw'),(43,'Lucian Bole','beater',1995,2,70,'Slytherin'),(44,'Graham Montague','chaser',1997,2,40,'Slytherin'),(45,'Peregrine Derrick','beater',1995,2,40,'Slytherin'),(46,'Adrian Pucey','chaser',1996,2,230,'Slytherin'),(47,'Charles Weasley','seeker',1991,15,450,'Gryffindor'),(48,'Regulus Black','seeker',1978,16,600,'Slytherin');
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referee`
--

DROP TABLE IF EXISTS `referee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referee` (
  `Name` varchar(64) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referee`
--

LOCK TABLES `referee` WRITE;
/*!40000 ALTER TABLE `referee` DISABLE KEYS */;
INSERT INTO `referee` VALUES ('Rolanda Hooch'),('Severus Snape');
/*!40000 ALTER TABLE `referee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `season`
--

DROP TABLE IF EXISTS `season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `season` (
  `Year` int NOT NULL,
  `Winning_team` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`Year`),
  KEY `Winning_team` (`Winning_team`),
  CONSTRAINT `season_ibfk_1` FOREIGN KEY (`Winning_team`) REFERENCES `team` (`House`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `season`
--

LOCK TABLES `season` WRITE;
/*!40000 ALTER TABLE `season` DISABLE KEYS */;
INSERT INTO `season` VALUES (1993,NULL),(1995,NULL),(1998,NULL),(2022,NULL),(1970,'Gryffindor'),(1974,'Gryffindor'),(1978,'Gryffindor'),(1980,'Gryffindor'),(1986,'Gryffindor'),(1994,'Gryffindor'),(1996,'Gryffindor'),(1997,'Gryffindor'),(1971,'Hufflepuff'),(1972,'Hufflepuff'),(1981,'Hufflepuff'),(1983,'Hufflepuff'),(1988,'Hufflepuff'),(1976,'Ravenclaw'),(1982,'Ravenclaw'),(1985,'Ravenclaw'),(1990,'Ravenclaw'),(1973,'Slytherin'),(1975,'Slytherin'),(1977,'Slytherin'),(1979,'Slytherin'),(1984,'Slytherin'),(1987,'Slytherin'),(1989,'Slytherin'),(1991,'Slytherin'),(1992,'Slytherin');
/*!40000 ALTER TABLE `season` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_champ` AFTER INSERT ON `season` FOR EACH ROW BEGIN
			UPDATE Team SET Total_champs = Total_champs + 1 WHERE House = NEW.Winning_team;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `House` varchar(64) NOT NULL,
  `Colors` varchar(64) NOT NULL,
  `Emblem` varchar(64) NOT NULL,
  `Head_of_house` varchar(64) NOT NULL,
  `Total_champs` int DEFAULT NULL,
  `Captain` int NOT NULL,
  PRIMARY KEY (`House`),
  KEY `Head_of_house` (`Head_of_house`),
  KEY `Captain` (`Captain`),
  CONSTRAINT `team_ibfk_1` FOREIGN KEY (`Head_of_house`) REFERENCES `head_of_house` (`Name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `team_ibfk_2` FOREIGN KEY (`Captain`) REFERENCES `player` (`Player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES ('Gryffindor','Red and Gold','Lion','Minerva McGonagall',8,1),('Hufflepuff','Yellow and Black','Badger','Pomona Sprout',5,30),('Ravenclaw','Blue and Bronze','Raven','Filius Flitwick',4,10),('Slytherin','Green and Silver','Snake','Severus Snape',9,7);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'harrypotter'
--
/*!50003 DROP FUNCTION IF EXISTS `getCaptain` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getCaptain`(
	playerID INT
) RETURNS varchar(64) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE capName VARCHAR(64);
    
    SELECT `Name` INTO capName
		FROM player WHERE player_id = playerID;

	RETURN capName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addBroom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addBroom`(Brand VARCHAR(64), Model VARCHAR(64), 
							Acceleration INT)
BEGIN
	DECLARE Broom_id INT;
	SET Broom_id = (SELECT MAX(Broom.Broom_id) FROM Broom) + 1;

	INSERT INTO Broom values(Broom_id, Brand, Model, Acceleration);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addComm` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addComm`(Name VARCHAR(64))
BEGIN

	INSERT INTO Commentator values(Name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addInj` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addInj`(Player_id int, Afflicted_body_part VARCHAR(64), Description VARCHAR(64))
BEGIN
	INSERT INTO Injury_Report values(Player_id, Afflicted_body_part, Description);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addMatch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addMatch`(Matchup_number INT, Season INT, Team_caught_snitch VARCHAR(64), 
							Weather_desc VARCHAR(64), Team1_Score INT, Team2_Score INT)
BEGIN
	IF (SELECT Year FROM season WHERE season.Year = Season) IS NULL THEN
		INSERT INTO season VALUES (Season, null);
	END IF;
    
    INSERT INTO `Match` VALUES(Matchup_number, Season, Team_caught_snitch, Weather_desc, Team1_Score, Team2_Score);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addPlayer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addPlayer`(Player_id INT, Name VARCHAR(64), Position ENUM("seeker", "keeper", "beater", "chaser"), 
							Grad_year YEAR, Broom INT, Points_scored INT, Team VARCHAR(64))
BEGIN
	-- check if the broom exists here? but we only know the id, not any other good info ...
	INSERT INTO Player values(Player_id, Name, Position, Grad_year, Broom, Points_scored, Team);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addRef` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addRef`(Name VARCHAR(64))
BEGIN
	INSERT INTO Referee values(Name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addSeason` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addSeason`(yr INT, Winning_team VARCHAR(64))
BEGIN
	INSERT INTO season values(yr, Winning_team);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `allBroomIds` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `allBroomIds`()
BEGIN
    SELECT Broom_Id FROM broom;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `allBrooms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `allBrooms`()
BEGIN
    SELECT * FROM broom;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `allMatchups` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `allMatchups`()
BEGIN
    SELECT * FROM matchup;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `allTeams` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `allTeams`()
BEGIN
    SELECT * FROM team;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assignCommToMatch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assignCommToMatch`(Name VARCHAR(64), Match_No INT, Season INT)
BEGIN
	IF (SELECT `Name` FROM Commentator WHERE Commentator.Name = Name) IS NULL THEN
		INSERT INTO Commentator values(Name);
	END IF;
	INSERT INTO matchToCommentator values(Match_No, Season, Name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `assignRefToMatch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `assignRefToMatch`(Name VARCHAR(64), Match_No INT, Season INT)
BEGIN
	IF (SELECT `Name` FROM Referee WHERE Referee.Name = Name) IS NULL THEN
		INSERT INTO Referee values(Name);
	END IF;
	INSERT INTO matchToReferee values(Match_No, Season, Name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delBroom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delBroom`(
	Broom_id INT
)
BEGIN
	DELETE FROM broom WHERE broom.Broom_id = Broom_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delInj` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delInj`(Player_id int)
BEGIN
	DELETE FROM  Injury_Report WHERE Player_id = Player_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getBroom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getBroom`(id INT)
BEGIN
	SELECT brand, model FROM broom WHERE Broom_id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getComm` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getComm`(Match_No INT, Season_No INT)
BEGIN
    SELECT CommentatorName FROM matchtocommentator
    WHERE MatchNo = Match_No AND SeasonNo = Season_No;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getInjuries` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getInjuries`()
BEGIN
	SELECT player.`Name`, injury_report.Player_id, Afflicted_body_part, `Description` FROM
		injury_report, player WHERE player.Player_id = injury_report.Player_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMatches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMatches`()
BEGIN
	SELECT Season, `match`.Matchup_number, Team1, Team1_score, Team2, Team2_score
		FROM `match`, matchup WHERE `match`.Matchup_number = matchup.Matchup_number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMatchInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMatchInfo`(season INT, matchNum INT)
BEGIN
	SELECT  `Month`, Team1, Team1_score, Team2, Team2_score, Team_caught_snitch, Weather_desc
		FROM `match`, matchup WHERE `match`.Matchup_number = matchup.Matchup_number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPlayers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPlayers`()
BEGIN
	SELECT * FROM player;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRef` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getRef`(Match_No INT, Season_No INT)
BEGIN
    SELECT RefereeName FROM matchtoreferee
    WHERE MatchNo = Match_No AND SeasonNo = Season_No;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSeasons` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSeasons`()
BEGIN
	SELECT * FROM season;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modBroom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `modBroom`(Player_id int, Broom_id int)
BEGIN
	UPDATE Player SET Broom = Broom_id WHERE Player_id = Player_id;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modCap` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `modCap`(House VARCHAR(64), Player_id int)
BEGIN
	UPDATE Team SET Captain = Player_id WHERE Team.House = House;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modHoH` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `modHoH`(Name VARCHAR(64), Start_year year, House VARCHAR(64))
BEGIN
	INSERT INTO Head_Of_House values(Name, Start_year, null);
	UPDATE Team SET Head_of_house = Name WHERE Team.House = House;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `orderMatches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `orderMatches`(des INT, field VARCHAR(64))
BEGIN
	
	IF field = "Differential" THEN
		IF des != 0 THEN
			SELECT Season, `match`.Matchup_number, Team1, Team1_score, Team2, Team2_score
				FROM `match`, matchup WHERE `match`.Matchup_number = matchup.Matchup_number
				ORDER BY (abs(Team1_Score - Team2_Score)) DESC, `match`.Matchup_number;
		ELSE
			SELECT Season, `match`.Matchup_number, Team1, Team1_score, Team2, Team2_score
				FROM `match`, matchup WHERE `match`.Matchup_number = matchup.Matchup_number
				ORDER BY (abs(Team1_Score - Team2_Score)) ASC, `match`.Matchup_number;
		END IF;
    ELSEIF field = "Total" THEN
		IF des != 0 THEN
			SELECT Season, `match`.Matchup_number, Team1, Team1_score, Team2, Team2_score
				FROM `match`, matchup WHERE `match`.Matchup_number = matchup.Matchup_number
				ORDER BY (Team1_Score + Team2_Score) DESC, `match`.Matchup_number;
		ELSE
			SELECT Season, `match`.Matchup_number, Team1, Team1_score, Team2, Team2_score
				FROM `match`, matchup WHERE `match`.Matchup_number = matchup.Matchup_number
				ORDER BY (Team1_Score + Team2_Score) ASC, `match`.Matchup_number;
		END IF;
	ELSE 
		IF des != 0 THEN
			SELECT Season, `match`.Matchup_number, Team1, Team1_score, Team2, Team2_score
				FROM `match`, matchup WHERE `match`.Matchup_number = matchup.Matchup_number
				ORDER BY (season) DESC, `match`.Matchup_number;
		ELSE
			SELECT Season, `match`.Matchup_number, Team1, Team1_score, Team2, Team2_score
				FROM `match`, matchup WHERE `match`.Matchup_number = matchup.Matchup_number
				ORDER BY (season) ASC, `match`.Matchup_number;
		END IF;
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `orderPlayers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `orderPlayers`(des INT, field VARCHAR(64), filterField VARCHAR(64), filterValue VARCHAR(64))
BEGIN
    IF filterField = "Graduation Year" THEN
		CREATE TEMPORARY TABLE temp SELECT * FROM player WHERE Grad_year = filterValue;
    ELSEIF filterField = "Position" THEN
		CREATE TEMPORARY TABLE temp SELECT * FROM player WHERE Position = filterValue;
    ELSEIF filterField = "Brooms" THEN
		CREATE TEMPORARY TABLE temp SELECT * FROM player WHERE Broom = filterValue;
    ELSE
		CREATE TEMPORARY TABLE temp SELECT * FROM player;
    END IF;
    
	IF field = "Grad" THEN
		IF des != 0 THEN
			SELECT * FROM temp ORDER BY Grad_year DESC;
		ELSE
			SELECT * FROM temp ORDER BY Grad_year ASC;
		END IF;
    ELSEIF field = "Points" THEN
		IF des != 0 THEN
			SELECT * FROM temp ORDER BY Points_scored DESC;
		ELSE
			SELECT * FROM temp ORDER BY Points_scored ASC;
		END IF;
	ELSE 
		IF des != 0 THEN
			SELECT * FROM temp ORDER BY `Name` DESC;
		ELSE
			SELECT * FROM temp ORDER BY `Name` ASC;
		END IF;
    END IF;
    DROP TEMPORARY TABLE temp;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `orderSeasons` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `orderSeasons`(des INT, champs VARCHAR(64))
BEGIN
	IF champs = "All" THEN
		IF des != 0 THEN
			SELECT * FROM season ORDER BY Year DESC;
		ELSE
			SELECT * FROM season ORDER BY Year ASC;
		END IF;
    ELSE
		IF des != 0 THEN
			SELECT * FROM season WHERE Winning_team = champs ORDER BY Year DESC;
		ELSE
			SELECT * FROM season WHERE Winning_team = champs ORDER BY Year ASC;
		END IF;
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-27 23:45:21
