-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: Universitas
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `mahasiswa_nilai`
--

DROP TABLE IF EXISTS `mahasiswa_nilai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mahasiswa_nilai` (
  `npm` varchar(15) DEFAULT NULL,
  `nama_mahasiswa` varchar(100) DEFAULT NULL,
  `jurusan` varchar(50) DEFAULT NULL,
  `nama_matkul` varchar(100) DEFAULT NULL,
  `nilai` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mahasiswa_nilai`
--

LOCK TABLES `mahasiswa_nilai` WRITE;
/*!40000 ALTER TABLE `mahasiswa_nilai` DISABLE KEYS */;
INSERT INTO `mahasiswa_nilai` VALUES ('220001','Ahmad Fauzi','Informatika','Basis Data',85.00),('220001','Ahmad Fauzi','Informatika','Pemrograman',90.00),('220002','Budi Santoso','Informatika','Basis Data',80.00),('220002','Budi Santoso','Informatika','Algoritma',88.00),('220003','Citra Dewi','Manajemen','Manajemen Keuangan',92.00),('220003','Citra Dewi','Manajemen','Basis Data',78.00),('220004','Dewi Lestari','Akuntansi','Akuntansi Dasar',87.00),('220004','Dewi Lestari','Akuntansi','Manajemen Keuangan',85.00),('220005','Eka Saputra','Manajemen','Manajemen Keuangan',89.00),('220005','Eka Saputra','Manajemen','Pemrograman',75.00);
/*!40000 ALTER TABLE `mahasiswa_nilai` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-12 21:29:52
