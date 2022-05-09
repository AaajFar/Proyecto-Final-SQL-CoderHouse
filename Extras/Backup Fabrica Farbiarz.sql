CREATE DATABASE  IF NOT EXISTS `fabrica_guitarras` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fabrica_guitarras`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: fabrica_guitarras
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` int NOT NULL,
  `mail` varchar(60) NOT NULL DEFAULT 'Pedir mail',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Juan','Perez','Boyaca 555, CABA',1152889655,'juanperez@gmail.com'),(2,'Jose','Ceballos','Caracas 2155, CABA',1187923355,'joseceballos@mail.com'),(3,'Carla','Farias','Av Segurola 2322 1°B, CABA',1155224855,'carlafarias@gmail.com'),(4,'Carolina','Gomez','Av Hipolito Yirigoyen 522, Lanus, GBA',1166128799,'gomezcarolina33@gmail.com'),(5,'Norberto','Carrizo','Av Mitre 2251 5°A, Avellaneda, GBA',1165442525,'carrizonorberto@mail.com'),(6,'Paula','Carrasco','Av Nazca 859, CABA',1144558484,'carrascop@gmail.com'),(7,'Jorge','Gonzalez','Serrano 755, CABA',1154883255,'Pedir mail'),(8,'Jonathan','Garcia','Av Libertador 5233 11°C, CABA',1154552300,'garciajonathan11@gmail.com'),(9,'Cinthia','Morales','Av Callao 202, CABA',1189655145,'Pedir mail'),(10,'Debora','Caruso','Carlos Calvo 3255 4°A, CABA',1144887784,'deboracar@gmail.com');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direcciones_envio`
--

DROP TABLE IF EXISTS `direcciones_envio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direcciones_envio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `localidad` varchar(60) NOT NULL,
  `provincia` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  CONSTRAINT `direcciones_envio_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direcciones_envio`
--

LOCK TABLES `direcciones_envio` WRITE;
/*!40000 ALTER TABLE `direcciones_envio` DISABLE KEYS */;
INSERT INTO `direcciones_envio` VALUES (1,1,'Av Eva Peron 2155','CABA','Buenos Aires'),(2,1,'Av 25 de Mayo 522','San Rafael','Mendoza'),(3,2,'Av Jujuy 5221','Resistencia','Chaco'),(4,2,'Av 9 de Julio 521','Rosario','Santa Fe'),(5,2,'Carlos Casares 422','Villa Maria','Cordoba'),(6,3,'Gral Cesar Diaz 5524','CABA','Buenos Aires'),(7,4,'Ceballos 252','Lujan','Buenos Aires'),(8,4,'Quitana 5050','Moreno','Buenos Aires'),(9,5,'Bufano 722','CABA','Buenos Aires'),(10,5,'Peru 2666','Salta','Salta'),(11,5,'Av del Campo 526','Rosario','Santa Fe'),(12,6,'Lima 888','CABA','Buenos Aires');
/*!40000 ALTER TABLE `direcciones_envio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guitarras`
--

DROP TABLE IF EXISTS `guitarras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guitarras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` enum('electrica','clasica','electroacustica','clasica nino','clasica concierto') NOT NULL,
  `modelo` varchar(60) NOT NULL,
  `ano` year NOT NULL,
  `stock` int unsigned NOT NULL,
  `precio` float DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guitarras`
--

LOCK TABLES `guitarras` WRITE;
/*!40000 ALTER TABLE `guitarras` DISABLE KEYS */;
INSERT INTO `guitarras` VALUES (1,'electrica','Stratocaster',2020,538,15640),(2,'electrica','Stratocaster',2021,625,17170),(3,'electrica','Les Paul',2019,680,20145),(4,'electrica','335',2020,696,20995),(5,'electrica','Stratocaster',2018,291,22440),(6,'electrica','Stratocaster',2019,495,25840),(7,'electroacustica','345',2020,286,13600),(8,'electroacustica','CD80',2019,654,14875),(9,'electroacustica','CE400',2021,470,13600),(10,'electroacustica','CD90',2021,490,19125),(11,'clasica','C40',2020,486,5610),(12,'clasica','C50',2020,758,5610),(13,'clasica','C60',2021,834,10710),(14,'clasica','M5',2020,190,10540),(15,'clasica','M6',2019,305,12410),(16,'clasica','C60LR',2022,495,11220),(17,'clasica nino','C40M',2020,75,5610),(18,'clasica nino','C50M',2020,521,5950),(19,'clasica concierto','C100',2016,121,11560),(20,'clasica concierto','C102',2018,320,12410);
/*!40000 ALTER TABLE `guitarras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materiales`
--

DROP TABLE IF EXISTS `materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` enum('clavijas','microfonos','maderas','cuerdas') NOT NULL,
  `marca` varchar(60) DEFAULT NULL,
  `modelo` varchar(60) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `stock` int unsigned NOT NULL,
  `costo` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiales`
--

LOCK TABLES `materiales` WRITE;
/*!40000 ALTER TABLE `materiales` DISABLE KEYS */;
INSERT INTO `materiales` VALUES (1,'clavijas','MXP','MX218 A','Set x6 para clasica',948,1000),(2,'clavijas','Shimura','214n','Set x6 para clasica',1827,1200),(3,'clavijas','Shimura','218A','Set x6 para clasica',709,1300),(4,'clavijas','Fender','099-0818-000','Set x6 para electrica',1632,2000),(5,'clavijas','Fender','0990820100','Set x6 para electrica',1910,2500),(6,'clavijas','Gibson','PMMH-025 GOLD','Set x6 para electrica',2450,2000),(7,'clavijas','Gibson','PMMH-030 BLACK','Set x6 para electrica',2480,2500),(8,'clavijas','Yamaha','TM 30','Set x6 para electrica o acustica',540,1500),(9,'clavijas','Gotoh','1503b-z','Set x6 para electrica',1488,2000),(10,'clavijas','Gotoh','1502c','Set x6 para electrica',1980,2500),(11,'clavijas','Gotoh','1513c','Set x6 para electrica',1640,3000),(12,'microfonos','DS Pickups','DS10-N-M-B','Set x3 para electrica',3088,4000),(13,'microfonos','DS Pickups','DS10-N-M-B','Set x3 para electrica',2550,4500),(14,'microfonos','Fender','Tex Mex','Set x3 para electrica',3838,5000),(15,'microfonos','Fender','Vintage Noiseless','Set x3 para electrica',2990,6000),(16,'microfonos','Dimarzio','Rainmaker Dreamcatcher','Set x2 para electrica',1380,5500),(17,'microfonos','Dimarzio','DP227 DP228','Set x2 para electrica',1220,5500),(18,'microfonos','Fishman','Blend 301','Para guitarra acustica',980,2000),(19,'microfonos','Cherub','GS3','Para guitarra acustica',1970,2500),(20,'microfonos','Dimarzio','Dp136','Para guitarra acustica',2645,3500),(21,'cuerdas','D addario','ez900','Set x6 para acustica .010',3639,1000),(22,'cuerdas','Ernie Ball','Super Slinky','Set x6 para electrica .009',1348,1200),(23,'cuerdas','Fender','150R','Set x6 para electrica .010',1200,1100),(24,'cuerdas','Fender','150L','Set x6 para electrica .009',1540,1200),(25,'cuerdas','Gibson','sag-mb11','Set x6 para acustica .011',2468,1250),(26,'cuerdas','Gibson','seg-700l','Set x6 para electrica .010',450,1350),(27,'cuerdas','D addario','EJ-30','Set x6 para clasica',1988,1000),(28,'cuerdas','Cantata','630','Set x6 para clasica',1707,800),(29,'maderas',NULL,'Alamo','Para guitarra electrica',760,2000),(30,'maderas',NULL,'Ebano','Para guitarra electrica',420,3000),(31,'maderas',NULL,'Pino Abeto','Para guitarra clasica',387,1500),(32,'maderas',NULL,'Cedro Español','Para guitarra clasica',2286,4000),(33,'maderas',NULL,'Caoba','Para guitarra clasica',1520,5000),(34,'maderas',NULL,'Palorosa','Para guitarra electrica',2178,5000),(35,'maderas',NULL,'Arce','Para guitarra clasica',999,4500),(36,'maderas',NULL,'Fresno','Para guitarra acustica',490,3500),(37,'maderas',NULL,'Wengue','Para guitarra acustica',1612,5000);
/*!40000 ALTER TABLE `materiales` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingresar_material` AFTER INSERT ON `materiales` FOR EACH ROW BEGIN
INSERT INTO `movimientos_materiales` (id_mov, fecha_mov, hora_mov, usuario_mov, id_mat, 
									  tipo_mat, costo_mat, costo_viejo, costo_dif, detalle)
VALUES (NULL, CURDATE(), CURTIME(), USER(), NEW.id, NEW.tipo, NEW.costo, NULL, NULL, 
		'Ingreso nuevo material');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_costo_material` BEFORE UPDATE ON `materiales` FOR EACH ROW BEGIN
	IF OLD.costo <> NEW.costo THEN
		INSERT INTO `movimientos_materiales` (id_mov, fecha_mov, hora_mov, usuario_mov, id_mat, 
									  tipo_mat, costo_mat, costo_viejo, costo_dif, detalle)
		VALUES (NULL, CURDATE(), CURTIME(), USER(), OLD.id, OLD.tipo, NEW.costo, OLD.costo, 
		CONCAT(ROUND((((NEW.costo - OLD.costo) * 100) / OLD.costo),2), ' %'), 
        'Actualizacion de precio');
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `materiales_guitarras`
--

DROP TABLE IF EXISTS `materiales_guitarras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiales_guitarras` (
  `mat_id` int NOT NULL,
  `guit_id` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`mat_id`,`guit_id`),
  KEY `guit_id` (`guit_id`),
  CONSTRAINT `materiales_guitarras_ibfk_1` FOREIGN KEY (`mat_id`) REFERENCES `materiales` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `materiales_guitarras_ibfk_2` FOREIGN KEY (`guit_id`) REFERENCES `guitarras` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiales_guitarras`
--

LOCK TABLES `materiales_guitarras` WRITE;
/*!40000 ALTER TABLE `materiales_guitarras` DISABLE KEYS */;
INSERT INTO `materiales_guitarras` VALUES (1,11,1),(1,12,1),(1,13,1),(1,17,1),(2,14,1),(2,18,1),(3,15,1),(3,16,1),(3,19,1),(3,20,1),(4,1,1),(5,2,1),(6,3,1),(7,4,1),(8,7,1),(8,8,1),(8,9,1),(8,10,1),(9,5,1),(11,6,1),(12,1,1),(13,2,1),(14,5,1),(15,6,1),(16,4,1),(17,3,1),(18,7,1),(18,9,1),(19,8,1),(20,10,1),(21,7,1),(21,9,1),(21,19,1),(21,20,1),(22,5,1),(22,6,1),(23,2,1),(24,1,1),(25,8,1),(25,10,1),(26,3,1),(26,4,1),(27,14,1),(27,15,1),(28,11,1),(28,12,1),(28,13,1),(28,16,1),(28,17,1),(28,18,1),(29,1,1),(29,2,1),(30,3,1),(30,4,1),(31,11,1),(31,12,1),(31,17,1),(31,18,1),(32,14,1),(33,15,1),(33,20,1),(34,5,1),(34,6,1),(35,13,1),(35,16,1),(35,19,1),(36,7,1),(36,8,1),(36,9,1),(37,10,1);
/*!40000 ALTER TABLE `materiales_guitarras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos_materiales`
--

DROP TABLE IF EXISTS `movimientos_materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos_materiales` (
  `id_mov` int NOT NULL AUTO_INCREMENT,
  `fecha_mov` date NOT NULL,
  `hora_mov` time NOT NULL,
  `usuario_mov` varchar(50) NOT NULL,
  `id_mat` int NOT NULL,
  `tipo_mat` enum('maderas','microfonos','clavijas','cuerdas') NOT NULL,
  `costo_mat` int NOT NULL,
  `costo_viejo` int DEFAULT NULL,
  `costo_dif` varchar(10) DEFAULT NULL,
  `detalle` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_mov`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_materiales`
--

LOCK TABLES `movimientos_materiales` WRITE;
/*!40000 ALTER TABLE `movimientos_materiales` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimientos_materiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos_pedidos`
--

DROP TABLE IF EXISTS `movimientos_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos_pedidos` (
  `id_mov` int NOT NULL AUTO_INCREMENT,
  `fecha_mov` date NOT NULL,
  `hora_mov` time NOT NULL,
  `usuario_mov` varchar(50) NOT NULL,
  `id_ped` int NOT NULL,
  `cliente` varchar(100) NOT NULL,
  PRIMARY KEY (`id_mov`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_pedidos`
--

LOCK TABLES `movimientos_pedidos` WRITE;
/*!40000 ALTER TABLE `movimientos_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimientos_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `precio_total` float DEFAULT '0',
  `fecha` date NOT NULL,
  `direnvio_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `direnvio_id` (`direnvio_id`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`direnvio_id`) REFERENCES `direcciones_envio` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,465800,'2022-01-22',2),(2,5,129540,'2022-01-25',10),(3,5,855015,'2022-01-25',10),(4,4,136680,'2022-01-30',8),(5,1,379270,'2022-02-05',2),(6,3,312800,'2022-02-15',6),(7,4,433500,'2022-02-17',7),(8,4,359380,'2022-02-17',7),(9,1,342720,'2022-02-25',1),(10,5,299710,'2022-02-26',11),(11,5,600100,'2022-02-26',11),(12,6,234005,'2022-03-02',12),(13,2,263500,'2022-03-10',4);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ingreso_nuevo_pedido` AFTER INSERT ON `pedidos` FOR EACH ROW BEGIN
SELECT nombre, apellido INTO @nom, @ape FROM clientes WHERE clientes.id = NEW.cliente_id ;
SET @dat = CONCAT(@nom, ' ', @ape);
INSERT INTO `movimientos_pedidos` (id_mov, fecha_mov, hora_mov, usuario_mov, id_ped, cliente)
VALUES (NULL, CURDATE(), CURTIME(), USER(), NEW.id, 
		CONCAT('Se ingreso un nuevo pedido del cliente ', @dat));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borrar_pedido` BEFORE DELETE ON `pedidos` FOR EACH ROW BEGIN
SELECT nombre, apellido INTO @nom, @ape FROM clientes WHERE clientes.id = OLD.cliente_id ;
SET @dat = CONCAT(@ape, ' ', @nom);

INSERT INTO `movimientos_pedidos` (id_mov, fecha_mov, hora_mov, usuario_mov, id_ped, cliente)
VALUES (NULL, CURDATE(), CURTIME(), USER(), OLD.id, CONCAT('Se elimino un pedido del cliente ', @dat,
							' con el precio de $ ', OLD.precio_total));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pedidos_detalle`
--

DROP TABLE IF EXISTS `pedidos_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_detalle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ped_id` int NOT NULL,
  `guit_id` int NOT NULL,
  `guit_cant` int NOT NULL,
  `guit_precio` float NOT NULL,
  PRIMARY KEY (`id`,`ped_id`,`guit_id`),
  KEY `ped_id` (`ped_id`),
  KEY `guit_id` (`guit_id`),
  CONSTRAINT `pedidos_detalle_ibfk_1` FOREIGN KEY (`ped_id`) REFERENCES `pedidos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pedidos_detalle_ibfk_2` FOREIGN KEY (`guit_id`) REFERENCES `guitarras` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_detalle`
--

LOCK TABLES `pedidos_detalle` WRITE;
/*!40000 ALTER TABLE `pedidos_detalle` DISABLE KEYS */;
INSERT INTO `pedidos_detalle` VALUES (1,1,5,10,22440),(2,1,6,5,25840),(3,1,17,20,5610),(4,2,11,4,5610),(5,2,13,10,10710),(6,3,4,9,20995),(7,3,5,7,22440),(8,3,10,20,19125),(9,3,14,12,10540),(10,4,3,4,20145),(11,4,16,5,11220),(12,5,12,22,5610),(13,5,17,15,5610),(14,5,2,10,17170),(15,6,1,20,15640),(16,7,2,5,17170),(17,7,6,10,25840),(18,7,8,6,14875),(19,8,1,12,15640),(20,8,2,10,17170),(21,9,16,10,11220),(22,9,13,5,10710),(23,9,11,10,5610),(24,9,3,6,20145),(25,10,5,4,22440),(26,10,4,10,20995),(27,11,7,14,13600),(28,11,8,20,14875),(29,11,16,10,11220),(30,12,17,2,5610),(31,12,13,11,10710),(32,12,4,5,20995),(33,13,3,10,20145),(34,13,15,5,12410);
/*!40000 ALTER TABLE `pedidos_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` int NOT NULL,
  `mail` varchar(60) NOT NULL DEFAULT 'Pedir mail',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'Music Shop','Guatemala 2044, CABA',48722685,'musicshop@gmail.com'),(2,'Fender Accesorios','Solis 3052, CABA',49552828,'fenderacc@gmail.com'),(3,'Gibson Music','Av Nazca 3155, CABA',45883371,'gibsonint@gmail.com'),(4,'Yamaha Accesorios','Callao 1233, CABA',46418892,'yamahaarg@gmail.com'),(5,'Gotoh International','Lavalle 4882, CABA',49123355,'gotohinternacional@gmail.com'),(6,'Maderas del sur','Hipolito Irigoyen 2255, Lanus GBA',47229822,'maderasdelsur@info.com.ar'),(7,'Gutierrez Maderas','Av J B Alberdi 5244, CABA',43228789,'Pedir mail'),(8,'Maderera Tres Hermanos','Av Alvarez Jonte 2573, CABA',45838877,'treshermanosmaderera@hotmail.com'),(9,'Maderera El Carpintero','Av San Martin 2188, CABA',49928633,'Pedir mail'),(10,'Devoto Maderas','Av Francisco Beiro 4122, CABA',46228899,'devotomaderas@gmail.com');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores_materiales`
--

DROP TABLE IF EXISTS `proveedores_materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores_materiales` (
  `mat_id` int NOT NULL,
  `prov_id` int NOT NULL,
  PRIMARY KEY (`mat_id`,`prov_id`),
  KEY `prov_id` (`prov_id`),
  CONSTRAINT `proveedores_materiales_ibfk_1` FOREIGN KEY (`mat_id`) REFERENCES `materiales` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `proveedores_materiales_ibfk_2` FOREIGN KEY (`prov_id`) REFERENCES `proveedores` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores_materiales`
--

LOCK TABLES `proveedores_materiales` WRITE;
/*!40000 ALTER TABLE `proveedores_materiales` DISABLE KEYS */;
INSERT INTO `proveedores_materiales` VALUES (1,1),(2,1),(3,1),(12,1),(13,1),(16,1),(17,1),(20,1),(21,1),(22,1),(27,1),(4,2),(5,2),(14,2),(15,2),(19,2),(23,2),(24,2),(6,3),(7,3),(18,3),(25,3),(26,3),(8,4),(9,5),(10,5),(11,5),(28,5),(29,6),(31,7),(35,7),(30,8),(33,8),(36,8),(34,9),(32,10),(37,10);
/*!40000 ALTER TABLE `proveedores_materiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vs_costo_guitarras`
--

DROP TABLE IF EXISTS `vs_costo_guitarras`;
/*!50001 DROP VIEW IF EXISTS `vs_costo_guitarras`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vs_costo_guitarras` AS SELECT 
 1 AS `id_guitarra`,
 1 AS `costo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vs_material_p_guitarra`
--

DROP TABLE IF EXISTS `vs_material_p_guitarra`;
/*!50001 DROP VIEW IF EXISTS `vs_material_p_guitarra`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vs_material_p_guitarra` AS SELECT 
 1 AS `id_guitarra`,
 1 AS `tipo_guitarra`,
 1 AS `modelo_guitarra`,
 1 AS `id_material`,
 1 AS `tipo_material`,
 1 AS `marca_material`,
 1 AS `modelo_material`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vs_pedidos_clientes`
--

DROP TABLE IF EXISTS `vs_pedidos_clientes`;
/*!50001 DROP VIEW IF EXISTS `vs_pedidos_clientes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vs_pedidos_clientes` AS SELECT 
 1 AS `id_pedido`,
 1 AS `valor`,
 1 AS `nombre_apellido`,
 1 AS `direccion_envio`,
 1 AS `localidad`,
 1 AS `provincia`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vs_promedio_ventas`
--

DROP TABLE IF EXISTS `vs_promedio_ventas`;
/*!50001 DROP VIEW IF EXISTS `vs_promedio_ventas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vs_promedio_ventas` AS SELECT 
 1 AS `promedio_venta`,
 1 AS `total_pedidos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vs_proveedores_maderas`
--

DROP TABLE IF EXISTS `vs_proveedores_maderas`;
/*!50001 DROP VIEW IF EXISTS `vs_proveedores_maderas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vs_proveedores_maderas` AS SELECT 
 1 AS `nombre`,
 1 AS `telefono`,
 1 AS `mail`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vs_stock_bajo_guitarras`
--

DROP TABLE IF EXISTS `vs_stock_bajo_guitarras`;
/*!50001 DROP VIEW IF EXISTS `vs_stock_bajo_guitarras`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vs_stock_bajo_guitarras` AS SELECT 
 1 AS `id`,
 1 AS `tipo`,
 1 AS `modelo`,
 1 AS `stock`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vs_stock_bajo_materiales`
--

DROP TABLE IF EXISTS `vs_stock_bajo_materiales`;
/*!50001 DROP VIEW IF EXISTS `vs_stock_bajo_materiales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vs_stock_bajo_materiales` AS SELECT 
 1 AS `id_material`,
 1 AS `tipo`,
 1 AS `modelo`,
 1 AS `stock`,
 1 AS `nombre_proveedor`,
 1 AS `telefono`,
 1 AS `mail`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vs_total_ventas`
--

DROP TABLE IF EXISTS `vs_total_ventas`;
/*!50001 DROP VIEW IF EXISTS `vs_total_ventas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vs_total_ventas` AS SELECT 
 1 AS `cantidad_pedidos`,
 1 AS `total`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'fabrica_guitarras'
--
/*!50003 DROP FUNCTION IF EXISTS `fx_calc_cst_guit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fx_calc_cst_guit`(id INT) RETURNS float
    READS SQL DATA
BEGIN
	DECLARE v_resultado FLOAT;
    
    SELECT SUM(mat.costo)
    INTO v_resultado
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
	WHERE guit.id = id;
    
	RETURN v_resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fx_calc_cst_ped` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fx_calc_cst_ped`(id INT) RETURNS float
    READS SQL DATA
BEGIN
	DECLARE v_resultado FLOAT;
    
    SELECT SUM((mat.costo * mg.cantidad) * pd.guit_cant)
    INTO v_resultado
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
    INNER JOIN pedidos_detalle pd ON pd.guit_id = guit.id
	WHERE pd.ped_id = id;
    
	RETURN v_resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fx_calc_ctdi_ultped` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fx_calc_ctdi_ultped`(id INT) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE v_fecha1 DATE;
    DECLARE v_fecha2 DATE;
    DECLARE v_resultado INT;
    
	SELECT ped.fecha
    INTO v_fecha1
	FROM pedidos ped
	WHERE cliente_id = id
	ORDER BY fecha DESC
	LIMIT 1;
    
    SELECT CURDATE() FROM DUAL
    INTO v_fecha2;
    
    SELECT DATEDIFF(v_fecha2,v_fecha1)
    INTO v_resultado;
    
	RETURN v_resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fx_calc_ctped_cl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fx_calc_ctped_cl`(id INT) RETURNS int
    READS SQL DATA
BEGIN
	DECLARE v_resultado INT;
    
	SELECT COUNT(id)
    INTO v_resultado
	FROM pedidos
	WHERE cliente_id = id;
    
	RETURN v_resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fx_calc_ctped_xfech` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fx_calc_ctped_xfech`(fecha1 DATE, fecha2 DATE) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE v_resultado INT;
    
	SELECT COUNT(id)
    INTO v_resultado
	FROM pedidos
	WHERE fecha BETWEEN fecha1 AND fecha2;
    
	RETURN v_resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_actcosto_mat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actcosto_mat`(IN id INT,
								  IN costo INT)
BEGIN
	DECLARE v_idguit INT;
    DECLARE v_finbucle INT DEFAULT 0;
	DECLARE cursorguit CURSOR FOR SELECT guit_id FROM materiales_guitarras WHERE mat_id = id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finbucle = 1;
    
	UPDATE materiales mat
    SET mat.costo = costo
    WHERE mat.id = id;
    
    OPEN cursorguit;
    
    bucle: LOOP
		
        FETCH cursorguit INTO v_idguit;
        
        IF v_finbucle = 1 THEN
			LEAVE bucle;
		END IF;
        
    UPDATE guitarras guit
    SET guit.precio = fx_calc_cst_guit(v_idguit) * 1.7
    WHERE guit.id = v_idguit;
    
    END LOOP bucle;
CLOSE cursorguit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_actstock_guitarra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actstock_guitarra`(IN id INT,
										IN cant INT)
BEGIN
	DECLARE v_idmat INT;
    DECLARE v_cantmat INT;
    DECLARE v_finbucle INT DEFAULT 0;
    
    DECLARE cursormat CURSOR FOR SELECT mat_id, cantidad FROM materiales_guitarras WHERE guit_id = id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finbucle = 1;
    
    DECLARE EXIT HANDLER FOR 1690
    BEGIN
		ROLLBACK;
        SELECT CONCAT('	El material con ID ', v_idmat, ' utilizado para el producto seleccionado con
						ID ', id, ' no cuenta con stock suficiente, la operacion ha sido cancelada') 
                        AS alerta;
	END;
    
    UPDATE `guitarras` guit
    SET guit.stock = guit.stock + cant
    WHERE guit.id = id;
    
    OPEN cursormat;
    
    bucle: LOOP
		
        FETCH cursormat INTO v_idmat, v_cantmat;
        
        IF v_finbucle = 1 THEN
			LEAVE bucle;
		END IF;
    
    UPDATE `materiales` mat
    SET mat.stock = mat.stock - (cant * v_cantmat) 
    WHERE mat.id = v_idmat;

END LOOP bucle;
CLOSE cursormat;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_eliminar_pedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_pedido`(IN id INT)
BEGIN
	DELETE FROM pedidos_detalle pd
    WHERE pd.ped_id = id;
	DELETE FROM pedidos ped
    WHERE ped.id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ingresar_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ingresar_cliente`(IN nombre VARCHAR(45),
                                      IN apellido VARCHAR(45),
                                      IN direccion VARCHAR(200),
                                      IN telefono INT,
                                      IN mail VARCHAR(60))
BEGIN
	INSERT INTO clientes VALUES
    (NULL, nombre, apellido, direccion, telefono, mail);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ingresar_detalle_pedido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ingresar_detalle_pedido`(IN id_pedido INT,
											IN id_guitarra INT,
                                            IN cantidad INT)
BEGIN
	DECLARE v_precio_guit FLOAT;
    DECLARE v_importe_total FLOAT;
    
	DECLARE EXIT HANDLER FOR 1690
    BEGIN
        SELECT CONCAT('La guitarra con el ID ', id_guitarra, ' no cuenta con stock suficiente para la
						operacion') 
                        AS alerta;
	END;
    
	UPDATE guitarras
    SET stock = stock - cantidad
    WHERE id = id_guitarra;
    
	SELECT precio
    INTO v_precio_guit
    FROM guitarras
    WHERE id = id_guitarra;
	
	INSERT INTO pedidos_detalle VALUES
    (NULL, id_pedido, id_guitarra, cantidad, v_precio_guit);

	
    SELECT v_precio_guit * cantidad
    INTO v_importe_total;

    UPDATE pedidos
    SET precio_total = precio_total + v_importe_total
    WHERE id = id_pedido;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ingresar_materiales_guitarras` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ingresar_materiales_guitarras`(IN id_material INT,
												   IN id_guitarra INT,
												   IN cantidad INT)
BEGIN
	DECLARE v_precio_venta FLOAT;
    DECLARE v_mat_rest FLOAT;
    
	DECLARE EXIT HANDLER FOR 1264
    BEGIN
		ROLLBACK;
        SELECT CONCAT('El material con ID ', id_material, ' utilizado para el producto seleccionado
						con ID ', id_guitarra, ' no cuenta con stock suficiente, la operacion ha sido cancelada') 
                        AS alerta;
	END;
    
	INSERT INTO materiales_guitarras VALUES
    (id_material, id_guitarra, cantidad);
	
    SELECT (costo * 1.7) * cantidad
    INTO v_precio_venta
    FROM materiales
    WHERE id = id_material;

    UPDATE guitarras
    SET precio = precio + v_precio_venta
    WHERE id = id_guitarra;
    
    SELECT guit.stock * cantidad
    INTO v_mat_rest
    FROM guitarras guit
    WHERE guit.id = id_guitarra;
    
    UPDATE materiales mat
    SET mat.stock = mat.stock - v_mat_rest
    WHERE mat.id = id_material;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_orden_guitarras` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_orden_guitarras`(IN campo INT, IN orden INT)
BEGIN
    SELECT * 
    FROM guitarras 
    ORDER BY
    CASE WHEN campo = 1 AND orden = 1 THEN id END,
    CASE WHEN campo = 1 AND orden = 2 THEN id END DESC,
    CASE WHEN campo = 2 AND orden = 1 THEN tipo END,
	CASE WHEN campo = 2 AND orden = 2 THEN tipo END DESC,
	CASE WHEN campo = 3 AND orden = 1 THEN modelo END,
	CASE WHEN campo = 3 AND orden = 2 THEN modelo END DESC,
	CASE WHEN campo = 4 AND orden = 1 THEN ano END,
	CASE WHEN campo = 4 AND orden = 2 THEN ano END DESC,
	CASE WHEN campo = 5 AND orden = 1 THEN stock END,
	CASE WHEN campo = 5 AND orden = 2 THEN stock END DESC,
	CASE WHEN campo = 6 AND orden = 1 THEN precio END,
	CASE WHEN campo = 6 AND orden = 2 THEN precio END DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vs_costo_guitarras`
--

/*!50001 DROP VIEW IF EXISTS `vs_costo_guitarras`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vs_costo_guitarras` AS select `guit`.`id` AS `id_guitarra`,sum(`mat`.`costo`) AS `costo` from ((`materiales` `mat` join `materiales_guitarras` `mg` on((`mat`.`id` = `mg`.`mat_id`))) join `guitarras` `guit` on((`guit`.`id` = `mg`.`guit_id`))) group by `guit`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vs_material_p_guitarra`
--

/*!50001 DROP VIEW IF EXISTS `vs_material_p_guitarra`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vs_material_p_guitarra` AS select `guit`.`id` AS `id_guitarra`,`guit`.`tipo` AS `tipo_guitarra`,`guit`.`modelo` AS `modelo_guitarra`,`mat`.`id` AS `id_material`,`mat`.`tipo` AS `tipo_material`,`mat`.`marca` AS `marca_material`,`mat`.`modelo` AS `modelo_material` from ((`materiales` `mat` join `materiales_guitarras` `mg` on((`mat`.`id` = `mg`.`mat_id`))) join `guitarras` `guit` on((`guit`.`id` = `mg`.`guit_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vs_pedidos_clientes`
--

/*!50001 DROP VIEW IF EXISTS `vs_pedidos_clientes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vs_pedidos_clientes` AS select `ped`.`id` AS `id_pedido`,`ped`.`precio_total` AS `valor`,concat(`cl`.`nombre`,' ',`cl`.`apellido`) AS `nombre_apellido`,`dir`.`direccion` AS `direccion_envio`,`dir`.`localidad` AS `localidad`,`dir`.`provincia` AS `provincia` from ((`pedidos` `ped` join `clientes` `cl` on((`ped`.`cliente_id` = `cl`.`id`))) join `direcciones_envio` `dir` on((`ped`.`direnvio_id` = `dir`.`id`))) order by `ped`.`fecha` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vs_promedio_ventas`
--

/*!50001 DROP VIEW IF EXISTS `vs_promedio_ventas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vs_promedio_ventas` AS select round(avg(`pedidos`.`precio_total`),2) AS `promedio_venta`,count(`pedidos`.`id`) AS `total_pedidos` from `pedidos` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vs_proveedores_maderas`
--

/*!50001 DROP VIEW IF EXISTS `vs_proveedores_maderas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vs_proveedores_maderas` AS select `prov`.`nombre` AS `nombre`,`prov`.`telefono` AS `telefono`,`prov`.`mail` AS `mail` from ((`proveedores` `prov` join `proveedores_materiales` `pm` on((`pm`.`prov_id` = `prov`.`id`))) join `materiales` `mat` on((`mat`.`id` = `pm`.`mat_id`))) where (`mat`.`tipo` = 'maderas') group by `prov`.`nombre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vs_stock_bajo_guitarras`
--

/*!50001 DROP VIEW IF EXISTS `vs_stock_bajo_guitarras`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vs_stock_bajo_guitarras` AS select `guitarras`.`id` AS `id`,`guitarras`.`tipo` AS `tipo`,`guitarras`.`modelo` AS `modelo`,`guitarras`.`stock` AS `stock` from `guitarras` where (`guitarras`.`stock` <= 200) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vs_stock_bajo_materiales`
--

/*!50001 DROP VIEW IF EXISTS `vs_stock_bajo_materiales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vs_stock_bajo_materiales` AS select `mat`.`id` AS `id_material`,`mat`.`tipo` AS `tipo`,`mat`.`modelo` AS `modelo`,`mat`.`stock` AS `stock`,`prov`.`nombre` AS `nombre_proveedor`,`prov`.`telefono` AS `telefono`,`prov`.`mail` AS `mail` from ((`materiales` `mat` join `proveedores_materiales` `pm` on((`mat`.`id` = `pm`.`mat_id`))) join `proveedores` `prov` on((`prov`.`id` = `pm`.`prov_id`))) where (`mat`.`stock` <= 500) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vs_total_ventas`
--

/*!50001 DROP VIEW IF EXISTS `vs_total_ventas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vs_total_ventas` AS select count(`ped`.`id`) AS `cantidad_pedidos`,sum(`ped`.`precio_total`) AS `total` from `pedidos` `ped` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-07 20:51:38
