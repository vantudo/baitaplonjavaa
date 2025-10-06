-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 05, 2025 lúc 01:00 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `restaurant`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `customer` (`id`, `phoneNumber`, `name`, `address`, `birthday`) VALUES
(1, '0911175581', 'Cường', 'Nghệ An', '2000-04-09 10:00:00'),
(2, '0911175581', 'Linh', 'Hà Nội', '2000-09-16 10:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `startDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `permission` varchar(50) NOT NULL COMMENT 'manager-quản lý\r\nstaff-nhân viên\r\ninactive-nghỉ việc',
  `salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `employee`
--

INSERT INTO `employee` (`id`, `username`, `password`, `name`, `phoneNumber`, `startDate`, `permission`, `salary`) VALUES
(1, 'admin', 'admin', 'Admin', '0911175581', '2020-11-23 17:00:00', 'manager', 10600000),
(2, 'nhanvien', '2', 'Tea', '0911175581', '2020-11-24 05:15:08', 'staff', 0),
(30, 'nhanvien1', 'nhanvien1', 'Đỗ Văn Tú', '1234124', '2025-10-05 06:31:57', 'staff', 100000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `food_category`
--

CREATE TABLE `food_category` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `food_category`
--

INSERT INTO `food_category` (`id`, `name`, `slug`) VALUES
(9, 'Rau ăn lá', 'rau-an-la'),
(10, 'Rau ăn củ', 'rau-an-cu'),
(11, 'Rau gia vị', 'rau-gia-vi');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `food_item`
--

CREATE TABLE `food_item` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `urlImage` varchar(50) DEFAULT NULL,
  `unitName` varchar(20) NOT NULL,
  `unitPrice` bigint(20) NOT NULL,
  `idCategory` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `idTable` int(11) DEFAULT NULL,
  `type` varchar(45) NOT NULL DEFAULT 'local' COMMENT 'local - tại quán\nonline - đặt online',
  `status` varchar(45) NOT NULL DEFAULT 'unpaid' COMMENT 'unpaid - chưa thanh toán\npaid - đã thanh toán',
  `orderDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `payDate` timestamp NULL DEFAULT NULL,
  `paidAmount` bigint(20) DEFAULT 0,
  `totalAmount` bigint(20) NOT NULL DEFAULT 0,
  `discount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order`
--

INSERT INTO `order` (`id`, `idEmployee`, `idTable`, `type`, `status`, `orderDate`, `payDate`, `paidAmount`, `totalAmount`, `discount`) VALUES
(39, 1, 16, 'local', 'unpaid', '2025-10-05 06:20:41', NULL, 0, 0, 0),
(40, 1, 17, 'online', 'unpaid', '2025-10-05 06:22:45', NULL, 0, 0, 0),
(42, 1, 17, 'local', 'unpaid', '2025-10-05 10:52:08', NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_item`
--

CREATE TABLE `order_item` (
  `idOrder` int(11) NOT NULL,
  `idFoodItem` int(11) NOT NULL,
  `idTopping` int(11) NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `foodPrice` bigint(20) NOT NULL DEFAULT 0,
  `toppingPrice` bigint(20) NOT NULL DEFAULT 0,
  `note` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `session`
--

CREATE TABLE `session` (
  `id` int(11) NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `startTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `endTime` timestamp NULL DEFAULT NULL,
  `message` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `session`
--

INSERT INTO `session` (`id`, `idEmployee`, `startTime`, `endTime`, `message`) VALUES
(20, 1, '2020-12-26 05:58:09', '2020-12-26 05:58:15', 'logout'),
(21, 2, '2020-12-26 10:21:50', '2020-12-26 10:22:06', 'logout'),
(23, 2, '2020-12-26 10:22:59', '2020-12-26 12:13:20', 'logout'),
(24, 1, '2020-12-26 15:46:25', '2020-12-26 15:47:22', 'logout'),
(25, 1, '2020-12-27 05:46:33', '2020-12-27 06:53:14', 'logout'),
(26, 1, '2020-12-27 06:55:49', '2020-12-27 07:25:30', 'logout'),
(27, 1, '2020-12-27 07:25:37', '2020-12-27 09:37:44', 'logout'),
(28, 1, '2020-12-27 09:39:08', '2020-12-27 09:51:08', 'logout'),
(30, 1, '2020-12-27 15:13:40', '2020-12-27 15:13:51', 'logout'),
(31, 1, '2020-12-27 15:14:33', '2020-12-27 15:15:08', 'logout'),
(32, 1, '2020-12-27 15:15:23', '2020-12-27 15:15:32', 'logout'),
(33, 1, '2020-12-27 15:18:00', '2020-12-27 15:18:05', 'logout'),
(34, 1, '2020-12-27 15:19:20', '2020-12-27 15:19:25', 'logout'),
(35, 1, '2020-12-28 15:30:20', '2020-12-28 15:31:00', 'logout'),
(36, 1, '2020-12-28 15:35:36', '2020-12-28 15:36:39', 'logout'),
(37, 1, '2020-12-28 15:36:53', '2020-12-28 15:37:03', 'logout'),
(38, 1, '2020-12-28 16:10:47', '2020-12-28 16:17:10', 'logout'),
(39, 1, '2020-12-28 16:20:28', '2020-12-28 16:21:11', 'logout'),
(40, 1, '2020-12-28 16:21:43', '2020-12-28 16:21:58', 'logout'),
(41, 1, '2020-12-28 16:22:09', '2020-12-28 16:22:20', 'logout'),
(42, 1, '2020-12-28 16:22:31', '2020-12-28 16:22:53', 'logout'),
(43, 1, '2020-12-28 16:23:04', '2020-12-28 16:23:17', 'logout'),
(44, 1, '2020-12-28 16:23:27', NULL, 'login'),
(45, 1, '2020-12-28 16:37:35', '2020-12-28 16:37:47', 'logout'),
(46, 1, '2020-12-28 16:39:34', '2020-12-28 16:39:53', 'logout'),
(47, 1, '2020-12-28 16:40:02', '2020-12-28 16:40:14', 'logout'),
(48, 1, '2020-12-29 07:17:33', '2020-12-29 07:17:42', 'logout'),
(49, 1, '2020-12-29 07:18:06', '2020-12-29 07:18:14', 'logout'),
(50, 1, '2020-12-29 07:18:23', '2020-12-29 07:18:28', 'logout'),
(51, 1, '2020-12-29 07:18:37', '2020-12-29 07:18:44', 'logout'),
(52, 1, '2020-12-29 07:18:54', '2020-12-29 07:19:00', 'logout'),
(53, 1, '2020-12-29 07:19:12', '2020-12-29 07:19:18', 'logout'),
(54, 1, '2020-12-29 07:19:33', '2020-12-29 07:19:38', 'logout'),
(55, 1, '2021-01-09 03:42:06', NULL, 'login'),
(56, 1, '2021-01-10 14:17:16', '2021-01-10 14:17:42', 'logout'),
(57, 1, '2021-01-10 14:20:51', '2021-01-10 14:21:12', 'logout'),
(58, 1, '2025-10-04 21:58:24', '2025-10-04 21:59:27', 'logout'),
(59, 1, '2025-10-04 21:59:55', '2025-10-04 22:02:51', 'logout'),
(60, 1, '2025-10-04 22:03:59', '2025-10-04 22:09:44', 'logout'),
(61, 1, '2025-10-04 22:06:21', '2025-10-04 22:09:40', 'logout'),
(62, 1, '2025-10-04 22:10:15', '2025-10-04 22:18:25', 'logout'),
(63, 1, '2025-10-04 22:18:31', '2025-10-04 22:22:10', 'logout'),
(64, 1, '2025-10-04 22:23:09', '2025-10-04 22:31:03', 'logout'),
(65, 1, '2025-10-04 22:38:10', '2025-10-04 22:47:04', 'logout'),
(66, 1, '2025-10-04 22:49:55', '2025-10-04 22:50:22', 'logout'),
(67, 1, '2025-10-04 22:50:47', '2025-10-04 22:54:39', 'logout'),
(68, 1, '2025-10-04 23:03:17', '2025-10-04 23:05:09', 'logout'),
(69, 1, '2025-10-04 23:05:24', '2025-10-04 23:07:59', 'logout'),
(70, 1, '2025-10-04 23:08:14', '2025-10-04 23:10:57', 'logout'),
(71, 2, '2025-10-04 23:11:21', '2025-10-04 23:30:45', 'logout'),
(72, 1, '2025-10-04 23:17:15', '2025-10-04 23:17:56', 'logout'),
(73, 1, '2025-10-04 23:19:53', '2025-10-04 23:23:11', 'logout'),
(74, 1, '2025-10-04 23:29:47', '2025-10-04 23:30:01', 'logout'),
(75, 1, '2025-10-04 23:31:04', '2025-10-04 23:32:30', 'logout'),
(76, 1, '2025-10-04 23:33:36', '2025-10-05 00:00:44', 'logout'),
(77, 1, '2025-10-05 02:42:38', NULL, 'login'),
(78, 1, '2025-10-05 03:07:05', '2025-10-05 03:34:57', 'logout'),
(79, 1, '2025-10-05 03:35:45', '2025-10-05 03:46:22', 'logout'),
(80, 1, '2025-10-05 03:46:11', '2025-10-05 03:46:19', 'logout'),
(81, 1, '2025-10-05 03:48:38', '2025-10-05 03:50:15', 'logout'),
(82, 1, '2025-10-05 03:51:38', NULL, 'login');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shipment`
--

CREATE TABLE `shipment` (
  `idOrder` int(11) NOT NULL,
  `idCustomer` int(11) NOT NULL,
  `shipperName` varchar(50) NOT NULL,
  `shipperPhoneNumber` varchar(20) NOT NULL,
  `shipCost` int(11) NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'topay' COMMENT 'topay - chờ xác nhận\ntoship - chờ lấy hàng\ntoreceive - đang giao\ncompleted - hoàn thành\ncancelled - đã hủy',
  `notice` varchar(45) DEFAULT NULL,
  `startDate` timestamp NULL DEFAULT current_timestamp(),
  `endDate` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `table`
--

CREATE TABLE `table` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'free' COMMENT 'free-Trống\nserving-Đang phục vụ\nreserving-Đặt trước'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `table`
--

INSERT INTO `table` (`id`, `name`, `status`) VALUES
(16, 'ray', 'serving'),
(17, 'dah', 'serving');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Chỉ mục cho bảng `food_category`
--
ALTER TABLE `food_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `food_item`
--
ALTER TABLE `food_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `fk_item_category` (`idCategory`);

--
-- Chỉ mục cho bảng `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_employee_order` (`idEmployee`),
  ADD KEY `fk_order_table` (`idTable`);

--
-- Chỉ mục cho bảng `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`idOrder`,`idFoodItem`,`idTopping`),
  ADD KEY `fk_order_main_item` (`idFoodItem`),
  ADD KEY `fk_order_topping` (`idTopping`);

--
-- Chỉ mục cho bảng `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_session` (`idEmployee`);

--
-- Chỉ mục cho bảng `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`idOrder`),
  ADD KEY `fk_ship_customer` (`idCustomer`);

--
-- Chỉ mục cho bảng `table`
--
ALTER TABLE `table`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `food_category`
--
ALTER TABLE `food_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `food_item`
--
ALTER TABLE `food_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT cho bảng `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT cho bảng `session`
--
ALTER TABLE `session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT cho bảng `table`
--
ALTER TABLE `table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `food_item`
--
ALTER TABLE `food_item`
  ADD CONSTRAINT `fk_item_category` FOREIGN KEY (`idCategory`) REFERENCES `food_category` (`id`);

--
-- Các ràng buộc cho bảng `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `fk_employee_order` FOREIGN KEY (`idEmployee`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `fk_order_table` FOREIGN KEY (`idTable`) REFERENCES `table` (`id`);

--
-- Các ràng buộc cho bảng `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `fk_order_item` FOREIGN KEY (`idOrder`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `fk_order_main_item` FOREIGN KEY (`idFoodItem`) REFERENCES `food_item` (`id`),
  ADD CONSTRAINT `fk_order_topping` FOREIGN KEY (`idTopping`) REFERENCES `food_item` (`id`);

--
-- Các ràng buộc cho bảng `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `fk_session` FOREIGN KEY (`idEmployee`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `shipment`
--
ALTER TABLE `shipment`
  ADD CONSTRAINT `fk_order_ship` FOREIGN KEY (`idOrder`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `fk_ship_customer` FOREIGN KEY (`idCustomer`) REFERENCES `customer` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
