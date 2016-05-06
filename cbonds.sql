-- MySQL dump 10.13  Distrib 5.5.48, for Win64 (x86)
--
-- Host: localhost    Database: cbonds
-- ------------------------------------------------------
-- Server version	5.5.48

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bond_types`
--

DROP TABLE IF EXISTS `bond_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bond_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bond_types`
--

LOCK TABLES `bond_types` WRITE;
/*!40000 ALTER TABLE `bond_types` DISABLE KEYS */;
INSERT INTO `bond_types` VALUES (1,''),(5,'Облигация АО'),(4,'Облигация АО процентная'),(3,'Облигация биржевая'),(2,'Облигация федерального займа');
/*!40000 ALTER TABLE `bond_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emitents`
--

DROP TABLE IF EXISTS `emitents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emitents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `short_name` varchar(40) NOT NULL,
  `type` int(10) unsigned NOT NULL,
  `release_num` varchar(20) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `date_gos_reg` date NOT NULL,
  `date_reg` date NOT NULL,
  `code_gos_reg` varchar(20) NOT NULL,
  `dkk` varchar(20) NOT NULL,
  `rts` varchar(20) NOT NULL,
  `isin` varchar(20) NOT NULL,
  `blocked` varchar(255) NOT NULL,
  `cfi` varchar(20) NOT NULL,
  `account_dkk` varchar(20) NOT NULL,
  `service_type` int(10) unsigned NOT NULL,
  `release_title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `service_type` (`service_type`),
  CONSTRAINT `emitents_ibfk_2` FOREIGN KEY (`service_type`) REFERENCES `service_types` (`id`),
  CONSTRAINT `emitents_ibfk_1` FOREIGN KEY (`type`) REFERENCES `bond_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emitents`
--

LOCK TABLES `emitents` WRITE;
/*!40000 ALTER TABLE `emitents` DISABLE KEYS */;
INSERT INTO `emitents` VALUES (2,'Министерство финансов Российской Федерации','МинФин РФ',2,'',1000.00,'2009-07-30','2009-08-05','25067RMFS','RF0000015823','','RU000A0JQ987','','','',3,'Обл.Минфин 25067'),(3,'Общество с ограниченной ответственностью \"УНИКУМ-ФИНАНС\"','ООО \"УНИКУМ-ФИНАНС\"',1,'Вып. 1',1000.00,'2006-09-21','2007-01-16','4-01-36189-R','RF0000009986','','RU000A0JNZL2','','','',3,'Обл.УНИКУМ-ФИНАНС 01'),(4,'Открытое акционерное общество \"Авиационная компания \"ТРАНСАЭРО\"','ОАО \"АК \"ТРАНСАЭРО\"',3,'Вып. 1',1000.00,'2011-08-16','2012-03-06','4B02-01-00165-A','RF0000018078','','RU000A0JS4W4','','','3290023081',3,'Обл.ТРАНСАЭРО ОБ1'),(5,'Открытое акционерное общество \"Мечел\"','ОАО \"Мечел\"',1,'Вып. 3',1000.00,'2009-02-05','2010-04-28','4B02-03-55005-E','RF0000015741','','RU000A0JQV20','','','',3,'Обл.Мечел ОБ03'),(6,'Открытое акционерное общество \"Московский комбинат хлебопродуктов\"','ОАО \"Московский КХП\"',4,'Вып. 2',1000.00,'2006-08-10','2006-09-21','4-02-01996-A','RF0000009208','','RU000A0JNJR3','','','',3,'Обл.МосКомХлеб 02'),(7,'Открытое акционерное общество \"Агропромышленная компания \"ОГО\"','ОАО \"АПК \"ОГО\"',5,'Вып. 2',700.00,'2006-01-26','2006-03-28','4-02-06193-A','RF0000008300','AOGO02','RU000A0GN1A4','','','',3,'Обл. АПК ОГО 02'),(8,'Открытое акционерное общество \"Федеральная сетевая компания Единой энергетической системы\"','ОАО \"ФСК ЕЭС\"',5,'Вып. 8',1000.00,'2009-11-05','2010-10-05','4-08-65018-D','RF0000016315','FEES08','RU000A0JR209','','','',3,'Обл. ФСК ЕЭС 08'),(9,'Открытое акционерное общество \"Мобильные ТелеСистемы\"','ОАО \"МТС\"',5,'Вып. 1',1000.00,'2007-12-27','2008-11-24','4-01-04715-A','RF0000013989','','RU000A0JQ0D4','','','',3,'Обл. МТС 01'),(10,'Открытое акционерное общество \"Уфимское моторостроительное производственное объединение\"','ОАО \"Уфимское МПО\"',1,'Вып. 3',1000.00,'2008-06-24','2009-08-13','4-03-30132-D','RF0000014742','UFMO03','RU000A0JQ6H2','','','157201',3,'Обл.Уфимское МПО 03'),(11,'Открытое акционерное общество \"Вымпел-Коммуникации\"','ОАО \"ВымпелКом\"',5,'Вып. 4',1000.00,'2011-06-23','2012-04-24','4-04-00027-A','RF0000018113','','RU000A0JS5F6','','','',3,'Обл.Вымпелком 04'),(12,'Общество с ограниченной ответственностью \"Ютэйр-Финанс\"','ООО \"Ютэйр-Финанс\"',1,'Вып. 5',1000.00,'2011-06-30','2011-08-01','4-05-36059-R','RF0000017398','UTRF05','RU000A0JRN60','','','',3,'Обл.Ютэйр-Финанс 05'),(13,'Открытое акционерное общество \"Российские Железные Дороги\"','ОАО \"РЖД\"',5,'Вып. 10',1000.00,'2008-06-17','2009-03-17','4-10-65045-D','RF0000014433','RZHD10','RU000A0JQ4F1','','','',3,'Обл. РЖД 10'),(14,'Министерство финансов Российской Федерации','МинФин РФ',1,'',1000.00,'2011-03-21','2011-03-23','26204RMFS','RF0000016982','','RU000A0JRCJ6','','','',3,'Обл.Минфин 26204'),(15,'Открытое акционерное общество \"ОТП Банк\"','ОАО \"ОТП Банк\"',3,'Вып. 3',1000.00,'2011-07-15','2011-11-07','4B020302766B','RF0000017625','','RU000A0JRV94','','','',3,'Обл.ОТП Банк ОБ 03'),(16,'Общество с ограниченной ответственностью \"Престиж-Экспресс-Сервис\"','ООО \"Престиж-Экспресс-Сервис\"',1,'Вып. 1',1000.00,'2008-01-15','2008-03-27','4-01-00103-R','RF0000012473','','RU000A0JPM55','','','',3,'Обл.Прест-Эксп-Сер01'),(17,'Открытое акционерное общество \"Акционерный инвестиционный коммерческий Банк \"Татфондбанк\"','ОАО \"АИКБ \"Татфондбанк\"',1,'Вып. 6',1000.00,'2009-03-02','2010-03-18','40603058B','RF0000015361','TATF06','RU000A0JQMY6','','','',3,'Обл.Татфондбанк 06');
/*!40000 ALTER TABLE `emitents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_types`
--

DROP TABLE IF EXISTS `service_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_types`
--

LOCK TABLES `service_types` WRITE;
/*!40000 ALTER TABLE `service_types` DISABLE KEYS */;
INSERT INTO `service_types` VALUES (1,''),(3,'Облигации (основной)');
/*!40000 ALTER TABLE `service_types` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-05 22:12:40
