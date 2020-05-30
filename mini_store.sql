-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2020 at 05:25 PM
-- Server version: 10.1.40-MariaDB
-- PHP Version: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mini_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL,
  `branch_name` varchar(40) DEFAULT NULL,
  `manger_id` int(11) DEFAULT NULL,
  `manger_start_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `branch_name`, `manger_id`, `manger_start_date`) VALUES
(1, 'alexandria', 100, '2005-01-08'),
(2, 'cairo', 102, '1992-04-06'),
(3, 'matroh', 106, '1998-02-13'),
(4, 'mansora', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `branch_supplier`
--

CREATE TABLE `branch_supplier` (
  `branch_id` int(11) NOT NULL,
  `supplier_name` varchar(40) NOT NULL,
  `supply_type` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `branch_supplier`
--

INSERT INTO `branch_supplier` (`branch_id`, `supplier_name`, `supply_type`) VALUES
(1, 'apple', 'pens'),
(2, 'rizk', 'mobile'),
(3, 'samsung', 'electronic devices');

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `client_id` int(11) NOT NULL,
  `client_name` varchar(40) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`client_id`, `client_name`, `branch_id`) VALUES
(400, 'ziad', 2),
(401, 'rwan', 2),
(402, 'gaber', 3);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL,
  `first_name` varchar(40) DEFAULT NULL,
  `last_name` varchar(40) DEFAULT NULL,
  `birth_day` date DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `super_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `first_name`, `last_name`, `birth_day`, `gender`, `salary`, `super_id`, `branch_id`) VALUES
(100, 'ahmed', 'mohmed', '1950-10-16', 'M', 250000, NULL, 1),
(101, 'noha', 'ahmed', '1960-03-12', 'F', 110000, 100, 1),
(102, 'Michael', 'amgad', '1974-04-15', 'M', 75000, 100, 2),
(103, 'mariam', 'shawky', '1981-06-25', 'F', 63000, 102, 2),
(106, 'mahmoud', 'reda', '1959-02-05', 'M', 78000, 100, 3),
(107, 'mina', 'ashraf', '1973-07-22', 'M', 65000, 106, 3);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `emp_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `total_sales` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`emp_id`, `client_id`, `total_sales`) VALUES
(100, 402, 55000),
(103, 400, 267000),
(107, 401, 22500);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`),
  ADD KEY `manger_id` (`manger_id`);

--
-- Indexes for table `branch_supplier`
--
ALTER TABLE `branch_supplier`
  ADD PRIMARY KEY (`branch_id`,`supplier_name`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`client_id`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `branch_id` (`branch_id`),
  ADD KEY `super_id` (`super_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`emp_id`,`client_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `branch`
--
ALTER TABLE `branch`
  ADD CONSTRAINT `branch_ibfk_1` FOREIGN KEY (`manger_id`) REFERENCES `employee` (`emp_id`) ON DELETE SET NULL;

--
-- Constraints for table `branch_supplier`
--
ALTER TABLE `branch_supplier`
  ADD CONSTRAINT `branch_supplier_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE CASCADE;

--
-- Constraints for table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`super_id`) REFERENCES `employee` (`emp_id`) ON DELETE SET NULL;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
