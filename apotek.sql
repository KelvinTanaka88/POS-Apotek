-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Bulan Mei 2023 pada 03.57
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apotek`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `akses`
--

CREATE TABLE `akses` (
  `akses_id` tinyint(3) UNSIGNED NOT NULL,
  `jenis` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `akses`
--

INSERT INTO `akses` (`akses_id`, `jenis`) VALUES
(1, 'Viewer'),
(2, 'Manager'),
(3, 'Admin');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `cur_month_masuk`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `cur_month_masuk` (
`idobat` int(11)
,`merek_dagang` varchar(150)
,`kuantitas` int(11)
,`tanggal` date
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `login`
--

CREATE TABLE `login` (
  `email` varchar(200) NOT NULL,
  `password` text NOT NULL,
  `akses_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `login`
--

INSERT INTO `login` (`email`, `password`, `akses_id`) VALUES
('admin', 'admin', 3),
('nicholsyoung25@gmail.com', '7@6P4y25', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `masuk`
--

CREATE TABLE `masuk` (
  `idmasuk` int(11) NOT NULL,
  `idobat` int(11) NOT NULL,
  `kuantitas` int(11) NOT NULL,
  `id_supplier` int(11) NOT NULL,
  `tanggal` date NOT NULL DEFAULT curdate(),
  `besarharga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `masuk`
--

INSERT INTO `masuk` (`idmasuk`, `idobat`, `kuantitas`, `id_supplier`, `tanggal`, `besarharga`) VALUES
(1, 14, 15, 8, '2023-01-04', 200000),
(2, 16, 11, 8, '2022-11-11', 7500),
(3, 12, 15, 7, '2022-11-17', 300000),
(4, 12, 2, 7, '2023-01-10', 120000),
(5, 17, 4, 7, '2022-12-21', 100000),
(6, 16, 30, 7, '2023-01-10', 600000),
(7, 14, 5, 8, '2023-01-10', 50000),
(8, 14, 5, 7, '2023-01-10', 10000),
(9, 17, 1, 8, '2023-01-10', 10000),
(10, 12, 15, 7, '2023-01-11', 300000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `stock`
--

CREATE TABLE `stock` (
  `idobat` int(11) NOT NULL,
  `merek_dagang` varchar(150) NOT NULL,
  `harga` bigint(20) NOT NULL,
  `satuan` enum('item','tablet','kapsul','tetesan','suppositori','hirup') NOT NULL,
  `exp_date` date NOT NULL,
  `stock` int(11) NOT NULL,
  `supplier` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `stock`
--

INSERT INTO `stock` (`idobat`, `merek_dagang`, `harga`, `satuan`, `exp_date`, `stock`, `supplier`) VALUES
(12, 'Panadol', 20000, 'tetesan', '2022-12-29', 54, 7),
(13, 'Paracetamol', 5000, 'tablet', '2022-12-22', 17, 7),
(14, 'Ibuprofen', 8000, 'tablet', '2031-12-19', 42, 7),
(16, 'Aspirin', 7500, 'suppositori', '2030-11-18', 41, 8),
(17, 'Zestril', 25000, 'item', '2023-01-26', 17, 8);

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `idsup` int(11) NOT NULL,
  `nama_supplier` varchar(100) NOT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `no_telp` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`idsup`, `nama_supplier`, `alamat`, `no_telp`) VALUES
(7, 'Pandawan', 'Jln. Boulevard Raya', '08123456789'),
(8, 'Surya', 'Jln. Penang Paris no.213', '01920891021');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` bigint(20) NOT NULL,
  `no_faktur` varchar(255) NOT NULL,
  `tanggal_transaksi` timestamp NOT NULL DEFAULT current_timestamp(),
  `jumlah` int(11) NOT NULL,
  `nominal` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_berpreskripsi`
--

CREATE TABLE `transaksi_berpreskripsi` (
  `id_transaksi` bigint(20) NOT NULL,
  `no_faktur` varchar(255) NOT NULL,
  `nama_pelanggan` text NOT NULL,
  `nama_dokter` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur untuk view `cur_month_masuk`
--
DROP TABLE IF EXISTS `cur_month_masuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cur_month_masuk`  AS SELECT `m`.`idobat` AS `idobat`, `s`.`merek_dagang` AS `merek_dagang`, `m`.`kuantitas` AS `kuantitas`, `m`.`tanggal` AS `tanggal` FROM (`masuk` `m` left join `stock` `s` on(`m`.`idobat` = `s`.`idobat`)) WHERE month(`m`.`tanggal`) = month(curdate())  ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `akses`
--
ALTER TABLE `akses`
  ADD PRIMARY KEY (`akses_id`);

--
-- Indeks untuk tabel `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`email`),
  ADD KEY `akses_id` (`akses_id`);

--
-- Indeks untuk tabel `masuk`
--
ALTER TABLE `masuk`
  ADD PRIMARY KEY (`idmasuk`),
  ADD KEY `id_supplier` (`id_supplier`),
  ADD KEY `idobat` (`idobat`);

--
-- Indeks untuk tabel `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`idobat`),
  ADD KEY `supplier` (`supplier`);

--
-- Indeks untuk tabel `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`idsup`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indeks untuk tabel `transaksi_berpreskripsi`
--
ALTER TABLE `transaksi_berpreskripsi`
  ADD KEY `transaksi_berpreskripsi_ibfk_1` (`id_transaksi`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `masuk`
--
ALTER TABLE `masuk`
  MODIFY `idmasuk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `stock`
--
ALTER TABLE `stock`
  MODIFY `idobat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT untuk tabel `supplier`
--
ALTER TABLE `supplier`
  MODIFY `idsup` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `login_ibfk_1` FOREIGN KEY (`akses_id`) REFERENCES `akses` (`akses_id`);

--
-- Ketidakleluasaan untuk tabel `masuk`
--
ALTER TABLE `masuk`
  ADD CONSTRAINT `masuk_ibfk_1` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`idsup`),
  ADD CONSTRAINT `masuk_ibfk_2` FOREIGN KEY (`idobat`) REFERENCES `stock` (`idobat`);

--
-- Ketidakleluasaan untuk tabel `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`idsup`);

--
-- Ketidakleluasaan untuk tabel `transaksi_berpreskripsi`
--
ALTER TABLE `transaksi_berpreskripsi`
  ADD CONSTRAINT `transaksi_berpreskripsi_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
