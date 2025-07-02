-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (arm64)
--
-- Host: localhost    Database: votaciones_realtime
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `opciones`
--

DROP TABLE IF EXISTS `opciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_votacion` int DEFAULT NULL,
  `texto` varchar(255) NOT NULL,
  `votos` int DEFAULT '0',
  `ronda` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id_votacion` (`id_votacion`),
  CONSTRAINT `opciones_ibfk_1` FOREIGN KEY (`id_votacion`) REFERENCES `votaciones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opciones`
--

LOCK TABLES `opciones` WRITE;
/*!40000 ALTER TABLE `opciones` DISABLE KEYS */;
INSERT INTO `opciones` VALUES (12,1,'Velocidad',1,1),(17,2,'pasta',0,1),(18,2,'ensalada',0,1),(19,2,'carne',0,1),(20,2,'comida rapida',0,1),(21,3,'pasta',0,1),(22,3,'ensaladas',0,1),(23,3,'carne',0,1),(24,3,'rapida',0,1),(25,3,'otra',0,1),(26,4,'invisibilidad',1,1),(30,1,'Velocidad',0,2),(31,2,'pasta',0,2),(32,2,'ensalada',0,2),(33,2,'carne',0,2),(34,2,'comida rapida',0,2),(35,3,'pasta',0,2),(36,3,'ensaladas',0,2),(37,3,'carne',0,2),(38,3,'rapida',0,2),(39,3,'otra',0,2),(40,4,'invisibilidad',250,2);
/*!40000 ALTER TABLE `opciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('admin','votante') DEFAULT 'votante',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Yael Jiménez','yael@ejemplo.com','voto2025','admin'),(2,'Admin02','admin02@ejemplo.com','voto2025','admin'),(3,'Admin03','admin03@ejemplo.com','voto2025','admin'),(4,'Admin04','admin04@ejemplo.com','voto2025','admin'),(5,'Admin05','admin05@ejemplo.com','voto2025','admin'),(6,'Admin06','admin06@ejemplo.com','voto2025','admin'),(7,'Admin07','admin07@ejemplo.com','voto2025','admin'),(8,'Admin08','admin08@ejemplo.com','voto2025','admin'),(9,'Admin09','admin09@ejemplo.com','voto2025','admin'),(10,'Admin10','admin10@ejemplo.com','voto2025','admin'),(11,'Votante001','votante001@ejemplo.com','voto2025','votante'),(12,'Votante002','votante002@ejemplo.com','voto2025','votante'),(13,'Votante003','votante003@ejemplo.com','voto2025','votante'),(14,'Votante004','votante004@ejemplo.com','voto2025','votante'),(15,'Votante005','votante005@ejemplo.com','voto2025','votante'),(16,'Votante006','votante006@ejemplo.com','voto2025','votante'),(17,'Votante007','votante007@ejemplo.com','voto2025','votante'),(18,'Votante008','votante008@ejemplo.com','voto2025','votante'),(19,'Votante009','votante009@ejemplo.com','voto2025','votante'),(20,'Votante010','votante010@ejemplo.com','voto2025','votante'),(21,'Votante011','votante011@ejemplo.com','voto2025','votante'),(22,'Votante012','votante012@ejemplo.com','voto2025','votante'),(23,'Votante013','votante013@ejemplo.com','voto2025','votante'),(24,'Votante014','votante014@ejemplo.com','voto2025','votante'),(25,'Votante015','votante015@ejemplo.com','voto2025','votante'),(26,'Votante016','votante016@ejemplo.com','voto2025','votante'),(27,'Votante017','votante017@ejemplo.com','voto2025','votante'),(28,'Votante018','votante018@ejemplo.com','voto2025','votante'),(29,'Votante019','votante019@ejemplo.com','voto2025','votante'),(30,'Votante020','votante020@ejemplo.com','voto2025','votante'),(31,'Votante021','votante021@ejemplo.com','voto2025','votante'),(32,'Votante022','votante022@ejemplo.com','voto2025','votante'),(33,'Votante023','votante023@ejemplo.com','voto2025','votante'),(34,'Votante024','votante024@ejemplo.com','voto2025','votante'),(35,'Votante025','votante025@ejemplo.com','voto2025','votante'),(36,'Votante026','votante026@ejemplo.com','voto2025','votante'),(37,'Votante027','votante027@ejemplo.com','voto2025','votante'),(38,'Votante028','votante028@ejemplo.com','voto2025','votante'),(39,'Votante029','votante029@ejemplo.com','voto2025','votante'),(40,'Votante030','votante030@ejemplo.com','voto2025','votante'),(41,'Votante031','votante031@ejemplo.com','voto2025','votante'),(42,'Votante032','votante032@ejemplo.com','voto2025','votante'),(43,'Votante033','votante033@ejemplo.com','voto2025','votante'),(44,'Votante034','votante034@ejemplo.com','voto2025','votante'),(45,'Votante035','votante035@ejemplo.com','voto2025','votante'),(46,'Votante036','votante036@ejemplo.com','voto2025','votante'),(47,'Votante037','votante037@ejemplo.com','voto2025','votante'),(48,'Votante038','votante038@ejemplo.com','voto2025','votante'),(49,'Votante039','votante039@ejemplo.com','voto2025','votante'),(50,'Votante040','votante040@ejemplo.com','voto2025','votante'),(51,'Votante041','votante041@ejemplo.com','voto2025','votante'),(52,'Votante042','votante042@ejemplo.com','voto2025','votante'),(53,'Votante043','votante043@ejemplo.com','voto2025','votante'),(54,'Votante044','votante044@ejemplo.com','voto2025','votante'),(55,'Votante045','votante045@ejemplo.com','voto2025','votante'),(56,'Votante046','votante046@ejemplo.com','voto2025','votante'),(57,'Votante047','votante047@ejemplo.com','voto2025','votante'),(58,'Votante048','votante048@ejemplo.com','voto2025','votante'),(59,'Votante049','votante049@ejemplo.com','voto2025','votante'),(60,'Votante050','votante050@ejemplo.com','voto2025','votante'),(61,'Votante051','votante051@ejemplo.com','voto2025','votante'),(62,'Votante052','votante052@ejemplo.com','voto2025','votante'),(63,'Votante053','votante053@ejemplo.com','voto2025','votante'),(64,'Votante054','votante054@ejemplo.com','voto2025','votante'),(65,'Votante055','votante055@ejemplo.com','voto2025','votante'),(66,'Votante056','votante056@ejemplo.com','voto2025','votante'),(67,'Votante057','votante057@ejemplo.com','voto2025','votante'),(68,'Votante058','votante058@ejemplo.com','voto2025','votante'),(69,'Votante059','votante059@ejemplo.com','voto2025','votante'),(70,'Votante060','votante060@ejemplo.com','voto2025','votante'),(71,'Votante061','votante061@ejemplo.com','voto2025','votante'),(72,'Votante062','votante062@ejemplo.com','voto2025','votante'),(73,'Votante063','votante063@ejemplo.com','voto2025','votante'),(74,'Votante064','votante064@ejemplo.com','voto2025','votante'),(75,'Votante065','votante065@ejemplo.com','voto2025','votante'),(76,'Votante066','votante066@ejemplo.com','voto2025','votante'),(77,'Votante067','votante067@ejemplo.com','voto2025','votante'),(78,'Votante068','votante068@ejemplo.com','voto2025','votante'),(79,'Votante069','votante069@ejemplo.com','voto2025','votante'),(80,'Votante070','votante070@ejemplo.com','voto2025','votante'),(81,'Votante071','votante071@ejemplo.com','voto2025','votante'),(82,'Votante072','votante072@ejemplo.com','voto2025','votante'),(83,'Votante073','votante073@ejemplo.com','voto2025','votante'),(84,'Votante074','votante074@ejemplo.com','voto2025','votante'),(85,'Votante075','votante075@ejemplo.com','voto2025','votante'),(86,'Votante076','votante076@ejemplo.com','voto2025','votante'),(87,'Votante077','votante077@ejemplo.com','voto2025','votante'),(88,'Votante078','votante078@ejemplo.com','voto2025','votante'),(89,'Votante079','votante079@ejemplo.com','voto2025','votante'),(90,'Votante080','votante080@ejemplo.com','voto2025','votante'),(91,'Votante081','votante081@ejemplo.com','voto2025','votante'),(92,'Votante082','votante082@ejemplo.com','voto2025','votante'),(93,'Votante083','votante083@ejemplo.com','voto2025','votante'),(94,'Votante084','votante084@ejemplo.com','voto2025','votante'),(95,'Votante085','votante085@ejemplo.com','voto2025','votante'),(96,'Votante086','votante086@ejemplo.com','voto2025','votante'),(97,'Votante087','votante087@ejemplo.com','voto2025','votante'),(98,'Votante088','votante088@ejemplo.com','voto2025','votante'),(99,'Votante089','votante089@ejemplo.com','voto2025','votante'),(100,'Votante090','votante090@ejemplo.com','voto2025','votante'),(101,'Votante091','votante091@ejemplo.com','voto2025','votante'),(102,'Votante092','votante092@ejemplo.com','voto2025','votante'),(103,'Votante093','votante093@ejemplo.com','voto2025','votante'),(104,'Votante094','votante094@ejemplo.com','voto2025','votante'),(105,'Votante095','votante095@ejemplo.com','voto2025','votante'),(106,'Votante096','votante096@ejemplo.com','voto2025','votante'),(107,'Votante097','votante097@ejemplo.com','voto2025','votante'),(108,'Votante098','votante098@ejemplo.com','voto2025','votante'),(109,'Votante099','votante099@ejemplo.com','voto2025','votante'),(110,'Votante100','votante100@ejemplo.com','voto2025','votante'),(111,'Votante101','votante101@ejemplo.com','voto2025','votante'),(112,'Votante102','votante102@ejemplo.com','voto2025','votante'),(113,'Votante103','votante103@ejemplo.com','voto2025','votante'),(114,'Votante104','votante104@ejemplo.com','voto2025','votante'),(115,'Votante105','votante105@ejemplo.com','voto2025','votante'),(116,'Votante106','votante106@ejemplo.com','voto2025','votante'),(117,'Votante107','votante107@ejemplo.com','voto2025','votante'),(118,'Votante108','votante108@ejemplo.com','voto2025','votante'),(119,'Votante109','votante109@ejemplo.com','voto2025','votante'),(120,'Votante110','votante110@ejemplo.com','voto2025','votante'),(121,'Votante111','votante111@ejemplo.com','voto2025','votante'),(122,'Votante112','votante112@ejemplo.com','voto2025','votante'),(123,'Votante113','votante113@ejemplo.com','voto2025','votante'),(124,'Votante114','votante114@ejemplo.com','voto2025','votante'),(125,'Votante115','votante115@ejemplo.com','voto2025','votante'),(126,'Votante116','votante116@ejemplo.com','voto2025','votante'),(127,'Votante117','votante117@ejemplo.com','voto2025','votante'),(128,'Votante118','votante118@ejemplo.com','voto2025','votante'),(129,'Votante119','votante119@ejemplo.com','voto2025','votante'),(130,'Votante120','votante120@ejemplo.com','voto2025','votante'),(131,'Votante121','votante121@ejemplo.com','voto2025','votante'),(132,'Votante122','votante122@ejemplo.com','voto2025','votante'),(133,'Votante123','votante123@ejemplo.com','voto2025','votante'),(134,'Votante124','votante124@ejemplo.com','voto2025','votante'),(135,'Votante125','votante125@ejemplo.com','voto2025','votante'),(136,'Votante126','votante126@ejemplo.com','voto2025','votante'),(137,'Votante127','votante127@ejemplo.com','voto2025','votante'),(138,'Votante128','votante128@ejemplo.com','voto2025','votante'),(139,'Votante129','votante129@ejemplo.com','voto2025','votante'),(140,'Votante130','votante130@ejemplo.com','voto2025','votante'),(141,'Votante131','votante131@ejemplo.com','voto2025','votante'),(142,'Votante132','votante132@ejemplo.com','voto2025','votante'),(143,'Votante133','votante133@ejemplo.com','voto2025','votante'),(144,'Votante134','votante134@ejemplo.com','voto2025','votante'),(145,'Votante135','votante135@ejemplo.com','voto2025','votante'),(146,'Votante136','votante136@ejemplo.com','voto2025','votante'),(147,'Votante137','votante137@ejemplo.com','voto2025','votante'),(148,'Votante138','votante138@ejemplo.com','voto2025','votante'),(149,'Votante139','votante139@ejemplo.com','voto2025','votante'),(150,'Votante140','votante140@ejemplo.com','voto2025','votante'),(151,'Votante141','votante141@ejemplo.com','voto2025','votante'),(152,'Votante142','votante142@ejemplo.com','voto2025','votante'),(153,'Votante143','votante143@ejemplo.com','voto2025','votante'),(154,'Votante144','votante144@ejemplo.com','voto2025','votante'),(155,'Votante145','votante145@ejemplo.com','voto2025','votante'),(156,'Votante146','votante146@ejemplo.com','voto2025','votante'),(157,'Votante147','votante147@ejemplo.com','voto2025','votante'),(158,'Votante148','votante148@ejemplo.com','voto2025','votante'),(159,'Votante149','votante149@ejemplo.com','voto2025','votante'),(160,'Votante150','votante150@ejemplo.com','voto2025','votante'),(161,'Votante151','votante151@ejemplo.com','voto2025','votante'),(162,'Votante152','votante152@ejemplo.com','voto2025','votante'),(163,'Votante153','votante153@ejemplo.com','voto2025','votante'),(164,'Votante154','votante154@ejemplo.com','voto2025','votante'),(165,'Votante155','votante155@ejemplo.com','voto2025','votante'),(166,'Votante156','votante156@ejemplo.com','voto2025','votante'),(167,'Votante157','votante157@ejemplo.com','voto2025','votante'),(168,'Votante158','votante158@ejemplo.com','voto2025','votante'),(169,'Votante159','votante159@ejemplo.com','voto2025','votante'),(170,'Votante160','votante160@ejemplo.com','voto2025','votante'),(171,'Votante161','votante161@ejemplo.com','voto2025','votante'),(172,'Votante162','votante162@ejemplo.com','voto2025','votante'),(173,'Votante163','votante163@ejemplo.com','voto2025','votante'),(174,'Votante164','votante164@ejemplo.com','voto2025','votante'),(175,'Votante165','votante165@ejemplo.com','voto2025','votante'),(176,'Votante166','votante166@ejemplo.com','voto2025','votante'),(177,'Votante167','votante167@ejemplo.com','voto2025','votante'),(178,'Votante168','votante168@ejemplo.com','voto2025','votante'),(179,'Votante169','votante169@ejemplo.com','voto2025','votante'),(180,'Votante170','votante170@ejemplo.com','voto2025','votante'),(181,'Votante171','votante171@ejemplo.com','voto2025','votante'),(182,'Votante172','votante172@ejemplo.com','voto2025','votante'),(183,'Votante173','votante173@ejemplo.com','voto2025','votante'),(184,'Votante174','votante174@ejemplo.com','voto2025','votante'),(185,'Votante175','votante175@ejemplo.com','voto2025','votante'),(186,'Votante176','votante176@ejemplo.com','voto2025','votante'),(187,'Votante177','votante177@ejemplo.com','voto2025','votante'),(188,'Votante178','votante178@ejemplo.com','voto2025','votante'),(189,'Votante179','votante179@ejemplo.com','voto2025','votante'),(190,'Votante180','votante180@ejemplo.com','voto2025','votante'),(191,'Votante181','votante181@ejemplo.com','voto2025','votante'),(192,'Votante182','votante182@ejemplo.com','voto2025','votante'),(193,'Votante183','votante183@ejemplo.com','voto2025','votante'),(194,'Votante184','votante184@ejemplo.com','voto2025','votante'),(195,'Votante185','votante185@ejemplo.com','voto2025','votante'),(196,'Votante186','votante186@ejemplo.com','voto2025','votante'),(197,'Votante187','votante187@ejemplo.com','voto2025','votante'),(198,'Votante188','votante188@ejemplo.com','voto2025','votante'),(199,'Votante189','votante189@ejemplo.com','voto2025','votante'),(200,'Votante190','votante190@ejemplo.com','voto2025','votante'),(201,'Votante191','votante191@ejemplo.com','voto2025','votante'),(202,'Votante192','votante192@ejemplo.com','voto2025','votante'),(203,'Votante193','votante193@ejemplo.com','voto2025','votante'),(204,'Votante194','votante194@ejemplo.com','voto2025','votante'),(205,'Votante195','votante195@ejemplo.com','voto2025','votante'),(206,'Votante196','votante196@ejemplo.com','voto2025','votante'),(207,'Votante197','votante197@ejemplo.com','voto2025','votante'),(208,'Votante198','votante198@ejemplo.com','voto2025','votante'),(209,'Votante199','votante199@ejemplo.com','voto2025','votante'),(210,'Votante200','votante200@ejemplo.com','voto2025','votante'),(211,'Votante201','votante201@ejemplo.com','voto2025','votante'),(212,'Votante202','votante202@ejemplo.com','voto2025','votante'),(213,'Votante203','votante203@ejemplo.com','voto2025','votante'),(214,'Votante204','votante204@ejemplo.com','voto2025','votante'),(215,'Votante205','votante205@ejemplo.com','voto2025','votante'),(216,'Votante206','votante206@ejemplo.com','voto2025','votante'),(217,'Votante207','votante207@ejemplo.com','voto2025','votante'),(218,'Votante208','votante208@ejemplo.com','voto2025','votante'),(219,'Votante209','votante209@ejemplo.com','voto2025','votante'),(220,'Votante210','votante210@ejemplo.com','voto2025','votante'),(221,'Votante211','votante211@ejemplo.com','voto2025','votante'),(222,'Votante212','votante212@ejemplo.com','voto2025','votante'),(223,'Votante213','votante213@ejemplo.com','voto2025','votante'),(224,'Votante214','votante214@ejemplo.com','voto2025','votante'),(225,'Votante215','votante215@ejemplo.com','voto2025','votante'),(226,'Votante216','votante216@ejemplo.com','voto2025','votante'),(227,'Votante217','votante217@ejemplo.com','voto2025','votante'),(228,'Votante218','votante218@ejemplo.com','voto2025','votante'),(229,'Votante219','votante219@ejemplo.com','voto2025','votante'),(230,'Votante220','votante220@ejemplo.com','voto2025','votante'),(231,'Votante221','votante221@ejemplo.com','voto2025','votante'),(232,'Votante222','votante222@ejemplo.com','voto2025','votante'),(233,'Votante223','votante223@ejemplo.com','voto2025','votante'),(234,'Votante224','votante224@ejemplo.com','voto2025','votante'),(235,'Votante225','votante225@ejemplo.com','voto2025','votante'),(236,'Votante226','votante226@ejemplo.com','voto2025','votante'),(237,'Votante227','votante227@ejemplo.com','voto2025','votante'),(238,'Votante228','votante228@ejemplo.com','voto2025','votante'),(239,'Votante229','votante229@ejemplo.com','voto2025','votante'),(240,'Votante230','votante230@ejemplo.com','voto2025','votante'),(241,'Votante231','votante231@ejemplo.com','voto2025','votante'),(242,'Votante232','votante232@ejemplo.com','voto2025','votante'),(243,'Votante233','votante233@ejemplo.com','voto2025','votante'),(244,'Votante234','votante234@ejemplo.com','voto2025','votante'),(245,'Votante235','votante235@ejemplo.com','voto2025','votante'),(246,'Votante236','votante236@ejemplo.com','voto2025','votante'),(247,'Votante237','votante237@ejemplo.com','voto2025','votante'),(248,'Votante238','votante238@ejemplo.com','voto2025','votante'),(249,'Votante239','votante239@ejemplo.com','voto2025','votante'),(250,'Votante240','votante240@ejemplo.com','voto2025','votante'),(251,'Votante241','votante241@ejemplo.com','voto2025','votante'),(252,'Votante242','votante242@ejemplo.com','voto2025','votante'),(253,'Votante243','votante243@ejemplo.com','voto2025','votante'),(254,'Votante244','votante244@ejemplo.com','voto2025','votante'),(255,'Votante245','votante245@ejemplo.com','voto2025','votante'),(256,'Votante246','votante246@ejemplo.com','voto2025','votante'),(257,'Votante247','votante247@ejemplo.com','voto2025','votante'),(258,'Votante248','votante248@ejemplo.com','voto2025','votante'),(259,'Votante249','votante249@ejemplo.com','voto2025','votante'),(260,'Votante250','votante250@ejemplo.com','voto2025','votante'),(261,'Votante251','votante251@ejemplo.com','voto2025','votante'),(262,'Votante252','votante252@ejemplo.com','voto2025','votante'),(263,'Votante253','votante253@ejemplo.com','voto2025','votante'),(264,'Votante254','votante254@ejemplo.com','voto2025','votante'),(265,'Votante255','votante255@ejemplo.com','voto2025','votante'),(266,'Votante256','votante256@ejemplo.com','voto2025','votante'),(267,'Votante257','votante257@ejemplo.com','voto2025','votante'),(268,'Votante258','votante258@ejemplo.com','voto2025','votante'),(269,'Votante259','votante259@ejemplo.com','voto2025','votante'),(270,'Votante260','votante260@ejemplo.com','voto2025','votante'),(271,'Votante261','votante261@ejemplo.com','voto2025','votante'),(272,'Votante262','votante262@ejemplo.com','voto2025','votante'),(273,'Votante263','votante263@ejemplo.com','voto2025','votante'),(274,'Votante264','votante264@ejemplo.com','voto2025','votante'),(275,'Votante265','votante265@ejemplo.com','voto2025','votante'),(276,'Votante266','votante266@ejemplo.com','voto2025','votante'),(277,'Votante267','votante267@ejemplo.com','voto2025','votante'),(278,'Votante268','votante268@ejemplo.com','voto2025','votante'),(279,'Votante269','votante269@ejemplo.com','voto2025','votante'),(280,'Votante270','votante270@ejemplo.com','voto2025','votante'),(281,'Votante271','votante271@ejemplo.com','voto2025','votante'),(282,'Votante272','votante272@ejemplo.com','voto2025','votante'),(283,'Votante273','votante273@ejemplo.com','voto2025','votante'),(284,'Votante274','votante274@ejemplo.com','voto2025','votante'),(285,'Votante275','votante275@ejemplo.com','voto2025','votante'),(286,'Votante276','votante276@ejemplo.com','voto2025','votante'),(287,'Votante277','votante277@ejemplo.com','voto2025','votante'),(288,'Votante278','votante278@ejemplo.com','voto2025','votante'),(289,'Votante279','votante279@ejemplo.com','voto2025','votante'),(290,'Votante280','votante280@ejemplo.com','voto2025','votante'),(291,'Votante281','votante281@ejemplo.com','voto2025','votante'),(292,'Votante282','votante282@ejemplo.com','voto2025','votante'),(293,'Votante283','votante283@ejemplo.com','voto2025','votante'),(294,'Votante284','votante284@ejemplo.com','voto2025','votante'),(295,'Votante285','votante285@ejemplo.com','voto2025','votante'),(296,'Votante286','votante286@ejemplo.com','voto2025','votante'),(297,'Votante287','votante287@ejemplo.com','voto2025','votante'),(298,'Votante288','votante288@ejemplo.com','voto2025','votante'),(299,'Votante289','votante289@ejemplo.com','voto2025','votante'),(300,'Votante290','votante290@ejemplo.com','voto2025','votante'),(301,'Votante291','votante291@ejemplo.com','voto2025','votante'),(302,'Votante292','votante292@ejemplo.com','voto2025','votante'),(303,'Votante293','votante293@ejemplo.com','voto2025','votante'),(304,'Votante294','votante294@ejemplo.com','voto2025','votante'),(305,'Votante295','votante295@ejemplo.com','voto2025','votante'),(306,'Votante296','votante296@ejemplo.com','voto2025','votante'),(307,'Votante297','votante297@ejemplo.com','voto2025','votante'),(308,'Votante298','votante298@ejemplo.com','voto2025','votante'),(309,'Votante299','votante299@ejemplo.com','voto2025','votante'),(310,'Votante300','votante300@ejemplo.com','voto2025','votante');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votaciones`
--

DROP TABLE IF EXISTS `votaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `votaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `id_creador` int NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `ronda_inicio` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votaciones`
--

LOCK TABLES `votaciones` WRITE;
/*!40000 ALTER TABLE `votaciones` DISABLE KEYS */;
INSERT INTO `votaciones` VALUES (1,'¿Cuál es tu superpoder favorito?',1,'2025-06-26 13:21:06','2025-06-27 01:46:14'),(2,'comida favorita',1,'2025-06-27 00:04:12','2025-06-27 01:46:17'),(3,'comida favorita',1,'2025-06-27 00:07:00','2025-06-27 01:46:20'),(4,'¿Cuál sería el mejor superpoder?',1,'2025-06-27 00:51:40','2025-06-27 01:46:24');
/*!40000 ALTER TABLE `votaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votos`
--

DROP TABLE IF EXISTS `votos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `votos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `id_opcion` int DEFAULT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_opcion` (`id_opcion`),
  CONSTRAINT `votos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `votos_ibfk_2` FOREIGN KEY (`id_opcion`) REFERENCES `opciones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votos`
--

LOCK TABLES `votos` WRITE;
/*!40000 ALTER TABLE `votos` DISABLE KEYS */;
/*!40000 ALTER TABLE `votos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-02  0:27:31
