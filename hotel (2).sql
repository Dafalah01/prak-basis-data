-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 10, 2025 at 04:03 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_booking` (IN `p_id_tamu` INT, IN `p_tgl_booking` DATE, IN `p_id_kamar` INT)   BEGIN
  DECLARE new_booking_id INT;

  INSERT INTO booking (id_tamu, tgl_booking)
  VALUES (p_id_tamu, p_tgl_booking);

  SET new_booking_id = LAST_INSERT_ID();

  INSERT INTO detail_booking (id_booking, id_kamar)
  VALUES (new_booking_id, p_id_kamar);

  UPDATE kamar SET status = 'dibooking' WHERE id_kamar = p_id_kamar;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `total_biaya_reservasi` (`p_id_reservasi` INT) RETURNS DECIMAL(10,2) DETERMINISTIC BEGIN
  DECLARE total DECIMAL(10,2);

  SELECT SUM(k.harga * DATEDIFF(r.tgl_cekout, r.tgl_cekin))
  INTO total
  FROM reservasi r
  JOIN detail_reservasi dr ON r.id_reservasi = dr.id_reservasi
  JOIN kamar k ON dr.id_kamar = k.id_kamar
  WHERE r.id_reservasi = p_id_reservasi;

  RETURN IFNULL(total, 0.00);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id_booking` int(11) NOT NULL,
  `id_tamu` int(11) DEFAULT NULL,
  `tgl_booking` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id_booking`, `id_tamu`, `tgl_booking`) VALUES
(1, 1, '2025-06-01'),
(2, 2, '2025-06-02'),
(3, 3, '2025-06-03'),
(4, 4, '2025-06-04'),
(5, 5, '2025-06-05'),
(6, 2, '2025-06-10');

-- --------------------------------------------------------

--
-- Table structure for table `detail_booking`
--

CREATE TABLE `detail_booking` (
  `id_detail_bok` int(11) NOT NULL,
  `id_booking` int(11) DEFAULT NULL,
  `id_kamar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_booking`
--

INSERT INTO `detail_booking` (`id_detail_bok`, `id_booking`, `id_kamar`) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 4),
(4, 4, 1),
(5, 5, 5),
(6, 6, 5);

-- --------------------------------------------------------

--
-- Table structure for table `detail_reservasi`
--

CREATE TABLE `detail_reservasi` (
  `id_detail_res` int(11) NOT NULL,
  `id_reservasi` int(11) DEFAULT NULL,
  `id_kamar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_reservasi`
--

INSERT INTO `detail_reservasi` (`id_detail_res`, `id_reservasi`, `id_kamar`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `id_kamar` int(11) NOT NULL,
  `no_kamar` varchar(10) DEFAULT NULL,
  `tipe_kamar` varchar(50) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `status` enum('tersedia','dibooking','ditempati') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`id_kamar`, `no_kamar`, `tipe_kamar`, `harga`, `status`) VALUES
(1, 'A101', 'Standard', 300000.00, 'tersedia'),
(2, 'A102', 'Deluxe', 450000.00, 'dibooking'),
(3, 'B201', 'Suite', 700000.00, 'tersedia'),
(4, 'B202', 'Standard', 300000.00, 'ditempati'),
(5, 'C301', 'Deluxe', 500000.00, 'dibooking');

-- --------------------------------------------------------

--
-- Stand-in structure for view `kamar_dibooking`
-- (See below for the actual view)
--
CREATE TABLE `kamar_dibooking` (
`id_kamar` int(11)
,`no_kamar` varchar(10)
,`tipe_kamar` varchar(50)
,`harga` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran_bok`
--

CREATE TABLE `pembayaran_bok` (
  `id_bayar_bok` int(11) NOT NULL,
  `id_booking` int(11) DEFAULT NULL,
  `detail_bayar_bok` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran_bok`
--

INSERT INTO `pembayaran_bok` (`id_bayar_bok`, `id_booking`, `detail_bayar_bok`) VALUES
(1, 1, 'Transfer BCA'),
(2, 2, 'Kartu Kredit'),
(3, 3, 'Transfer Mandiri'),
(4, 4, 'Tunai'),
(5, 5, 'QRIS');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran_res`
--

CREATE TABLE `pembayaran_res` (
  `id_bayar_res` int(11) NOT NULL,
  `id_reservasi` int(11) DEFAULT NULL,
  `detail_bayar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran_res`
--

INSERT INTO `pembayaran_res` (`id_bayar_res`, `id_reservasi`, `detail_bayar`) VALUES
(1, 1, 'Lunas via BRI'),
(2, 2, 'DP 50%'),
(3, 3, 'Lunas via BNI'),
(4, 4, 'Refund 100%'),
(5, 5, 'Belum bayar');

-- --------------------------------------------------------

--
-- Table structure for table `reservasi`
--

CREATE TABLE `reservasi` (
  `id_reservasi` int(11) NOT NULL,
  `id_tamu` int(11) DEFAULT NULL,
  `tgl_cekin` date DEFAULT NULL,
  `tgl_cekout` date DEFAULT NULL,
  `status` enum('aktif','selesai','dibatalkan') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservasi`
--

INSERT INTO `reservasi` (`id_reservasi`, `id_tamu`, `tgl_cekin`, `tgl_cekout`, `status`) VALUES
(1, 1, '2025-06-10', '2025-06-12', 'aktif'),
(2, 2, '2025-06-11', '2025-06-13', 'aktif'),
(3, 3, '2025-06-12', '2025-06-14', 'selesai'),
(4, 4, '2025-06-13', '2025-06-15', 'dibatalkan'),
(5, 5, '2025-06-14', '2025-06-16', 'aktif');

--
-- Triggers `reservasi`
--
DELIMITER $$
CREATE TRIGGER `after_reservasi_update` AFTER UPDATE ON `reservasi` FOR EACH ROW BEGIN
  IF NEW.status = 'dibatalkan' THEN
    UPDATE kamar
    SET status = 'tersedia'
    WHERE id_kamar IN (
      SELECT id_kamar FROM detail_reservasi WHERE id_reservasi = NEW.id_reservasi
    );
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tamu`
--

CREATE TABLE `tamu` (
  `id_tamu` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tamu`
--

INSERT INTO `tamu` (`id_tamu`, `nama`, `no_hp`, `email`) VALUES
(1, 'Bayu Saputra', '081234567890', 'bayu@email.com'),
(2, 'Siti Aminah', '082345678901', 'siti@email.com'),
(3, 'Andi Kurniawan', '083456789012', 'andi@email.com'),
(4, 'Rina Marlina', '084567890123', 'rina@email.com'),
(5, 'Dedi Prasetyo', '085678901234', 'dedi@email.com');

-- --------------------------------------------------------

--
-- Structure for view `kamar_dibooking`
--
DROP TABLE IF EXISTS `kamar_dibooking`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `kamar_dibooking`  AS SELECT `k`.`id_kamar` AS `id_kamar`, `k`.`no_kamar` AS `no_kamar`, `k`.`tipe_kamar` AS `tipe_kamar`, `k`.`harga` AS `harga` FROM `kamar` AS `k` WHERE `k`.`status` = 'dibooking' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id_booking`),
  ADD KEY `id_tamu` (`id_tamu`),
  ADD KEY `idx_id_tamu_booking` (`id_tamu`);

--
-- Indexes for table `detail_booking`
--
ALTER TABLE `detail_booking`
  ADD PRIMARY KEY (`id_detail_bok`),
  ADD KEY `id_booking` (`id_booking`),
  ADD KEY `id_kamar` (`id_kamar`);

--
-- Indexes for table `detail_reservasi`
--
ALTER TABLE `detail_reservasi`
  ADD PRIMARY KEY (`id_detail_res`),
  ADD KEY `id_reservasi` (`id_reservasi`),
  ADD KEY `id_kamar` (`id_kamar`);

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id_kamar`),
  ADD KEY `idx_status_kamar` (`status`);

--
-- Indexes for table `pembayaran_bok`
--
ALTER TABLE `pembayaran_bok`
  ADD PRIMARY KEY (`id_bayar_bok`),
  ADD UNIQUE KEY `id_booking` (`id_booking`);

--
-- Indexes for table `pembayaran_res`
--
ALTER TABLE `pembayaran_res`
  ADD PRIMARY KEY (`id_bayar_res`),
  ADD UNIQUE KEY `id_reservasi` (`id_reservasi`);

--
-- Indexes for table `reservasi`
--
ALTER TABLE `reservasi`
  ADD PRIMARY KEY (`id_reservasi`),
  ADD KEY `id_tamu` (`id_tamu`);

--
-- Indexes for table `tamu`
--
ALTER TABLE `tamu`
  ADD PRIMARY KEY (`id_tamu`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id_booking` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `detail_booking`
--
ALTER TABLE `detail_booking`
  MODIFY `id_detail_bok` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `detail_reservasi`
--
ALTER TABLE `detail_reservasi`
  MODIFY `id_detail_res` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pembayaran_bok`
--
ALTER TABLE `pembayaran_bok`
  MODIFY `id_bayar_bok` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pembayaran_res`
--
ALTER TABLE `pembayaran_res`
  MODIFY `id_bayar_res` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reservasi`
--
ALTER TABLE `reservasi`
  MODIFY `id_reservasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tamu`
--
ALTER TABLE `tamu`
  MODIFY `id_tamu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`id_tamu`) REFERENCES `tamu` (`id_tamu`);

--
-- Constraints for table `detail_booking`
--
ALTER TABLE `detail_booking`
  ADD CONSTRAINT `detail_booking_ibfk_1` FOREIGN KEY (`id_booking`) REFERENCES `booking` (`id_booking`),
  ADD CONSTRAINT `detail_booking_ibfk_2` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`);

--
-- Constraints for table `detail_reservasi`
--
ALTER TABLE `detail_reservasi`
  ADD CONSTRAINT `detail_reservasi_ibfk_1` FOREIGN KEY (`id_reservasi`) REFERENCES `reservasi` (`id_reservasi`),
  ADD CONSTRAINT `detail_reservasi_ibfk_2` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`);

--
-- Constraints for table `pembayaran_bok`
--
ALTER TABLE `pembayaran_bok`
  ADD CONSTRAINT `pembayaran_bok_ibfk_1` FOREIGN KEY (`id_booking`) REFERENCES `booking` (`id_booking`);

--
-- Constraints for table `pembayaran_res`
--
ALTER TABLE `pembayaran_res`
  ADD CONSTRAINT `pembayaran_res_ibfk_1` FOREIGN KEY (`id_reservasi`) REFERENCES `reservasi` (`id_reservasi`);

--
-- Constraints for table `reservasi`
--
ALTER TABLE `reservasi`
  ADD CONSTRAINT `reservasi_ibfk_1` FOREIGN KEY (`id_tamu`) REFERENCES `tamu` (`id_tamu`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
