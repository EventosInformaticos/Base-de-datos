-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2022 at 12:23 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `empresaeventos`
--

-- --------------------------------------------------------

--
-- Table structure for table `actividades`
--

CREATE TABLE `actividades` (
  `IdActividad` int(11) NOT NULL,
  `Nombre` varchar(25) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `Fecha` date NOT NULL,
  `Hora` int(11) NOT NULL,
  `Duracion` int(11) NOT NULL COMMENT 'en minutos',
  `IdSubEvento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `detalleparticipante`
--

CREATE TABLE `detalleparticipante` (
  `IdSubEvento` int(11) NOT NULL,
  `IdParticipante` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `eventos`
--

CREATE TABLE `eventos` (
  `IdEvento` int(11) NOT NULL,
  `Titulo` varchar(25) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `Fecha` date NOT NULL COMMENT 'fecha',
  `Duracion` int(11) NOT NULL COMMENT 'en Dias'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `lugar`
--

CREATE TABLE `lugar` (
  `IdLugar` int(11) NOT NULL,
  `Tipo` char(1) NOT NULL COMMENT 'P: Presencial / O: Online',
  `Enlace` varchar(100) NOT NULL,
  `Nombre` varchar(25) NOT NULL,
  `Capacidad` int(11) NOT NULL,
  `Aula` int(11) NOT NULL,
  `Direccion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `participantes`
--

CREATE TABLE `participantes` (
  `IdParticipante` int(11) NOT NULL,
  `Nombre` varchar(25) NOT NULL,
  `Apellido` varchar(25) NOT NULL,
  `Correo` varchar(50) NOT NULL,
  `Edad` int(11) NOT NULL,
  `Telefono` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subeventos`
--

CREATE TABLE `subeventos` (
  `IdSubEvento` int(11) NOT NULL,
  `Titulo` varchar(25) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `Fecha` date NOT NULL,
  `Duracion` int(11) NOT NULL COMMENT 'en minutos',
  `IdEvento` int(11) NOT NULL,
  `IdLugar` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`IdActividad`),
  ADD KEY `IdSubEvento` (`IdSubEvento`);

--
-- Indexes for table `detalleparticipante`
--
ALTER TABLE `detalleparticipante`
  ADD PRIMARY KEY (`IdSubEvento`,`IdParticipante`),
  ADD KEY `IdParticipante` (`IdParticipante`);

--
-- Indexes for table `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`IdEvento`);

--
-- Indexes for table `lugar`
--
ALTER TABLE `lugar`
  ADD PRIMARY KEY (`IdLugar`);

--
-- Indexes for table `participantes`
--
ALTER TABLE `participantes`
  ADD PRIMARY KEY (`IdParticipante`);

--
-- Indexes for table `subeventos`
--
ALTER TABLE `subeventos`
  ADD PRIMARY KEY (`IdSubEvento`),
  ADD KEY `IdEvento` (`IdEvento`),
  ADD KEY `IdLugar` (`IdLugar`),
  ADD KEY `IdLugar_2` (`IdLugar`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `actividades`
--
ALTER TABLE `actividades`
  ADD CONSTRAINT `actividades_ibfk_1` FOREIGN KEY (`IdSubEvento`) REFERENCES `subeventos` (`IdSubEvento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detalleparticipante`
--
ALTER TABLE `detalleparticipante`
  ADD CONSTRAINT `detalleparticipante_ibfk_1` FOREIGN KEY (`IdParticipante`) REFERENCES `participantes` (`IdParticipante`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalleparticipante_ibfk_2` FOREIGN KEY (`IdSubEvento`) REFERENCES `subeventos` (`IdSubEvento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subeventos`
--
ALTER TABLE `subeventos`
  ADD CONSTRAINT `subeventos_ibfk_1` FOREIGN KEY (`IdEvento`) REFERENCES `eventos` (`IdEvento`),
  ADD CONSTRAINT `subeventos_ibfk_2` FOREIGN KEY (`IdLugar`) REFERENCES `lugar` (`IdLugar`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
