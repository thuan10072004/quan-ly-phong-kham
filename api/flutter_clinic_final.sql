-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 12, 2025 lúc 09:06 PM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `flutter_clinic_final`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `category` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `category`) VALUES
(1, 'Panadol Extra', 15000, 'Giảm đau'),
(2, 'Vitamin C', 50000, 'Vitamin'),
(3, 'Paracetamol 500mg', 15000, 'Giảm đau'),
(4, 'Ibuprofen 400mg', 25000, 'Giảm đau'),
(5, 'Efferalgan Codeine', 65000, 'Giảm đau'),
(6, 'Amoxicillin 500mg', 30000, 'Kháng sinh'),
(7, 'Augmentin 1g', 150000, 'Kháng sinh'),
(8, 'Cephalexin 500mg', 40000, 'Kháng sinh'),
(9, 'Vitamin C 1000mg', 50000, 'Vitamin'),
(10, 'Vitamin 3B (B1-B6-B12)', 35000, 'Vitamin'),
(11, 'Canxi Corbiere', 120000, 'Vitamin'),
(12, 'Omeprazol 20mg', 25000, 'Dạ dày'),
(13, 'Gaviscon (Gói)', 5000, 'Dạ dày'),
(14, 'Phosphalugel (Chữ P)', 4500, 'Dạ dày'),
(15, 'Berberin', 10000, 'Tiêu hóa'),
(16, 'Smecta', 3500, 'Tiêu hóa'),
(17, 'Men vi sinh Enterogermina', 8000, 'Tiêu hóa'),
(18, 'Nước muối sinh lý 0.9%', 5000, 'Vật tư y tế'),
(19, 'Cồn y tế 70 độ', 7000, 'Vật tư y tế'),
(20, 'Bông băng y tế', 12000, 'Vật tư y tế'),
(21, 'Khẩu trang y tế 4 lớp', 35000, 'Vật tư y tế'),
(22, 'Siro ho Prospan', 75000, 'Hô hấp');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
