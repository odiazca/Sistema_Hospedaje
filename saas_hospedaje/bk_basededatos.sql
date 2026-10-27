-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.4.3 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para saas_hospedaje
CREATE DATABASE IF NOT EXISTS `saas_hospedaje` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `saas_hospedaje`;

-- Volcando estructura para tabla saas_hospedaje.caja_sesiones
CREATE TABLE IF NOT EXISTS `caja_sesiones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `monto_inicial` decimal(10,2) NOT NULL DEFAULT '0.00',
  `monto_esperado` decimal(10,2) DEFAULT NULL,
  `monto_final` decimal(10,2) DEFAULT NULL,
  `diferencia` decimal(10,2) DEFAULT NULL,
  `estado` enum('abierta','cerrada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'abierta',
  `abierta_at` timestamp NULL DEFAULT NULL,
  `cerrada_at` timestamp NULL DEFAULT NULL,
  `notas` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `caja_sesiones_user_id_foreign` (`user_id`),
  KEY `caja_sesiones_empresa_id_index` (`empresa_id`),
  CONSTRAINT `caja_sesiones_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.caja_sesiones: ~10 rows (aproximadamente)
DELETE FROM `caja_sesiones`;
INSERT INTO `caja_sesiones` (`id`, `empresa_id`, `user_id`, `monto_inicial`, `monto_esperado`, `monto_final`, `diferencia`, `estado`, `abierta_at`, `cerrada_at`, `notas`, `created_at`, `updated_at`) VALUES
	(41, 1, 3, 200.00, 1571.02, 1569.52, -1.50, 'cerrada', '2026-08-29 12:00:00', '2026-08-30 00:30:00', 'DEMO cierre de caja', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(42, 1, 3, 200.00, 915.47, 916.27, 0.80, 'cerrada', '2026-08-30 12:00:00', '2026-08-31 00:30:00', 'DEMO cierre de caja', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(43, 1, 3, 200.00, 1299.27, 1297.37, -1.90, 'cerrada', '2026-08-31 12:00:00', '2026-09-01 00:30:00', 'DEMO cierre de caja', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(44, 1, 3, 200.00, 944.19, 945.09, 0.90, 'cerrada', '2026-09-01 12:00:00', '2026-09-02 00:30:00', 'DEMO cierre de caja', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(45, 1, 3, 200.00, 1414.19, 1411.99, -2.20, 'cerrada', '2026-09-02 12:00:00', '2026-09-03 00:30:00', 'DEMO cierre de caja', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(46, 1, 3, 200.00, 952.78, 952.28, -0.50, 'cerrada', '2026-09-03 12:00:00', '2026-09-04 00:30:00', 'DEMO cierre de caja', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(47, 1, 3, 200.00, 992.97, 993.27, 0.30, 'cerrada', '2026-09-04 12:00:00', '2026-09-05 00:30:00', 'DEMO cierre de caja', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(48, 1, 3, 200.00, 712.31, 711.91, -0.40, 'cerrada', '2026-09-05 12:00:00', '2026-09-06 00:30:00', 'DEMO cierre de caja', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(49, 1, 3, 200.00, 673.08, 670.58, -2.50, 'cerrada', '2026-09-06 12:00:00', '2026-09-07 00:30:00', 'DEMO cierre de caja', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(50, 1, 3, 200.00, NULL, NULL, NULL, 'abierta', '2026-09-07 12:00:00', NULL, 'DEMO caja del día', '2026-09-07 13:10:11', '2026-09-07 13:10:11');

-- Volcando estructura para tabla saas_hospedaje.configuracions
CREATE TABLE IF NOT EXISTS `configuracions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `clave` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `configuracions_empresa_id_clave_unique` (`empresa_id`,`clave`),
  KEY `configuracions_empresa_id_index` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.configuracions: ~3 rows (aproximadamente)
DELETE FROM `configuracions`;
INSERT INTO `configuracions` (`id`, `empresa_id`, `clave`, `valor`, `created_at`, `updated_at`) VALUES
	(1, 2, 'nombre_hotel', 'Hostal El Viajero', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(2, 2, 'simbolo_moneda', 'S/', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(3, 2, 'igv', '18', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(4, 1, 'nombre_hotel', 'Hotel Sistema Hospedaje', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(5, 1, 'ruc', '20123456789', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(6, 1, 'direccion', 'Av. Principal 123, Lima - Perú', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(7, 1, 'telefono', '(01) 555-1234', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(8, 1, 'email', 'reservas@hospedaje.com', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(9, 1, 'moneda', 'PEN', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(10, 1, 'simbolo_moneda', 'S/', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(11, 1, 'igv', '18', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(12, 1, 'checkin_hora', '14:00', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(13, 1, 'checkout_hora', '12:00', '2026-06-09 21:13:02', '2026-06-09 21:13:02');

-- Volcando estructura para tabla saas_hospedaje.consumos
CREATE TABLE IF NOT EXISTS `consumos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `reserva_id` bigint unsigned NOT NULL,
  `producto_id` bigint unsigned DEFAULT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int unsigned NOT NULL DEFAULT '1',
  `precio_unit` decimal(10,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(10,2) NOT NULL DEFAULT '0.00',
  `fecha` date NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `consumos_reserva_id_foreign` (`reserva_id`),
  KEY `consumos_user_id_foreign` (`user_id`),
  KEY `consumos_empresa_id_index` (`empresa_id`),
  KEY `consumos_producto_id_index` (`producto_id`),
  CONSTRAINT `consumos_reserva_id_foreign` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `consumos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=576 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.consumos: ~130 rows (aproximadamente)
DELETE FROM `consumos`;
INSERT INTO `consumos` (`id`, `empresa_id`, `reserva_id`, `producto_id`, `descripcion`, `cantidad`, `precio_unit`, `subtotal`, `fecha`, `user_id`, `created_at`, `updated_at`) VALUES
	(1, 1, 2, 3, 'Cerveza', 2, 10.00, 20.00, '2026-06-09', 3, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(2, 1, 57, 4, 'Snack / galletas', 3, 7.00, 21.00, '2026-06-09', 3, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(3, 1, 57, 4, 'Snack / galletas', 2, 7.00, 14.00, '2026-06-09', 3, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(4, 1, 10, 4, 'Snack / galletas', 2, 7.00, 14.00, '2026-06-09', 3, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(5, 1, 41, 5, 'Desayuno buffet', 3, 25.00, 75.00, '2026-06-09', 3, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(6, 1, 88, 2, 'Gaseosa lata', 3, 6.00, 18.00, '2026-06-09', 3, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(7, 1, 30, 2, 'Gaseosa lata', 3, 6.00, 18.00, '2026-06-09', 3, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(8, 1, 30, 7, 'Lavandería (kg)', 2, 15.00, 30.00, '2026-06-09', 3, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(9, 1, 37, 6, 'Almuerzo ejecutivo', 3, 35.00, 105.00, '2026-06-09', 3, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(10, 1, 20, 3, 'Cerveza', 2, 10.00, 20.00, '2026-06-09', 3, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(11, 1, 20, 6, 'Almuerzo ejecutivo', 1, 35.00, 35.00, '2026-06-09', 3, '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(12, 1, 20, 8, 'Late check-out', 1, 40.00, 40.00, '2026-06-09', 3, '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(13, 1, 8, 5, 'Desayuno buffet', 2, 25.00, 50.00, '2026-06-09', 3, '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(14, 1, 8, 7, 'Lavandería (kg)', 1, 15.00, 15.00, '2026-06-09', 3, '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(15, 1, 29, 6, 'Almuerzo ejecutivo', 3, 35.00, 105.00, '2026-06-09', 3, '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(16, 1, 29, 5, 'Desayuno buffet', 2, 25.00, 50.00, '2026-06-09', 3, '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(462, 1, 506, 57, 'Estacionamiento/día', 3, 20.00, 60.00, '2026-08-31', 3, '2026-09-07 13:10:09', '2026-09-07 13:10:09'),
	(463, 1, 506, 57, 'Estacionamiento/día', 1, 20.00, 20.00, '2026-08-31', 3, '2026-09-07 13:10:09', '2026-09-07 13:10:09'),
	(464, 1, 506, 52, 'Cena romántica', 1, 90.00, 90.00, '2026-08-31', 3, '2026-09-07 13:10:09', '2026-09-07 13:10:09'),
	(465, 1, 507, 54, 'Spa / masaje', 1, 120.00, 120.00, '2026-08-31', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(466, 1, 507, 58, 'Kit de aseo', 3, 15.00, 45.00, '2026-08-31', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(467, 1, 507, 3, 'Cerveza', 2, 10.00, 20.00, '2026-08-31', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(468, 1, 510, 6, 'Almuerzo ejecutivo', 1, 35.00, 35.00, '2026-09-02', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(469, 1, 510, 7, 'Lavandería (kg)', 2, 15.00, 30.00, '2026-09-02', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(470, 1, 512, 8, 'Late check-out', 3, 40.00, 120.00, '2026-09-02', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(471, 1, 512, 2, 'Gaseosa lata', 2, 6.00, 12.00, '2026-09-02', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(472, 1, 512, 4, 'Snack / galletas', 1, 7.00, 7.00, '2026-09-02', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(473, 1, 515, 49, 'Botella de vino', 2, 45.00, 90.00, '2026-09-03', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(474, 1, 515, 3, 'Cerveza', 3, 10.00, 30.00, '2026-09-03', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(475, 1, 515, 50, 'Jugo natural', 2, 8.00, 16.00, '2026-09-03', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(476, 1, 518, 55, 'Planchado (unidad)', 2, 8.00, 16.00, '2026-09-03', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(477, 1, 519, 2, 'Gaseosa lata', 1, 6.00, 6.00, '2026-09-04', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(478, 1, 519, 49, 'Botella de vino', 3, 45.00, 135.00, '2026-09-04', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(479, 1, 520, 53, 'Traslado aeropuerto', 2, 60.00, 120.00, '2026-09-03', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(480, 1, 520, 8, 'Late check-out', 1, 40.00, 40.00, '2026-09-03', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(481, 1, 524, 51, 'Café premium', 1, 12.00, 12.00, '2026-09-04', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(482, 1, 526, 52, 'Cena romántica', 1, 90.00, 90.00, '2026-09-05', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(483, 1, 526, 51, 'Café premium', 3, 12.00, 36.00, '2026-09-05', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(484, 1, 528, 2, 'Gaseosa lata', 1, 6.00, 6.00, '2026-09-06', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(485, 1, 528, 2, 'Gaseosa lata', 1, 6.00, 6.00, '2026-09-06', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(486, 1, 528, 49, 'Botella de vino', 2, 45.00, 90.00, '2026-09-06', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(487, 1, 529, 49, 'Botella de vino', 1, 45.00, 45.00, '2026-09-07', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(488, 1, 529, 57, 'Estacionamiento/día', 1, 20.00, 20.00, '2026-09-07', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(489, 1, 530, 50, 'Jugo natural', 1, 8.00, 8.00, '2026-09-06', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(490, 1, 532, 49, 'Botella de vino', 3, 45.00, 135.00, '2026-09-21', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(491, 1, 532, 6, 'Almuerzo ejecutivo', 3, 35.00, 105.00, '2026-09-21', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(492, 1, 532, 6, 'Almuerzo ejecutivo', 1, 35.00, 35.00, '2026-09-21', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(493, 1, 534, 52, 'Cena romántica', 3, 90.00, 270.00, '2026-09-12', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(494, 1, 534, 4, 'Snack / galletas', 2, 7.00, 14.00, '2026-09-12', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(495, 1, 536, 6, 'Almuerzo ejecutivo', 3, 35.00, 105.00, '2026-09-15', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(496, 1, 538, 2, 'Gaseosa lata', 2, 6.00, 12.00, '2026-09-27', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(497, 1, 539, 53, 'Traslado aeropuerto', 2, 60.00, 120.00, '2026-09-25', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(498, 1, 539, 51, 'Café premium', 3, 12.00, 36.00, '2026-09-25', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(499, 1, 541, 6, 'Almuerzo ejecutivo', 2, 35.00, 70.00, '2026-09-19', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(500, 1, 541, 50, 'Jugo natural', 1, 8.00, 8.00, '2026-09-19', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(501, 1, 542, 49, 'Botella de vino', 1, 45.00, 45.00, '2026-09-07', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(502, 1, 542, 54, 'Spa / masaje', 1, 120.00, 120.00, '2026-09-07', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(503, 1, 545, 6, 'Almuerzo ejecutivo', 1, 35.00, 35.00, '2026-09-03', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(504, 1, 545, 53, 'Traslado aeropuerto', 1, 60.00, 60.00, '2026-09-03', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(505, 1, 546, 3, 'Cerveza', 1, 10.00, 10.00, '2026-09-04', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(506, 1, 547, 8, 'Late check-out', 1, 40.00, 40.00, '2026-09-04', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(507, 1, 547, 49, 'Botella de vino', 1, 45.00, 45.00, '2026-09-04', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(508, 1, 548, 53, 'Traslado aeropuerto', 1, 60.00, 60.00, '2026-04-10', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(509, 1, 548, 1, 'Agua mineral 600ml', 3, 5.00, 15.00, '2026-04-10', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(510, 1, 550, 8, 'Late check-out', 1, 40.00, 40.00, '2026-04-11', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(511, 1, 550, 58, 'Kit de aseo', 1, 15.00, 15.00, '2026-04-11', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(512, 1, 550, 51, 'Café premium', 2, 12.00, 24.00, '2026-04-11', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(513, 1, 552, 57, 'Estacionamiento/día', 3, 20.00, 60.00, '2026-04-05', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(514, 1, 552, 49, 'Botella de vino', 2, 45.00, 90.00, '2026-04-05', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(515, 1, 552, 2, 'Gaseosa lata', 3, 6.00, 18.00, '2026-04-05', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(516, 1, 554, 57, 'Estacionamiento/día', 3, 20.00, 60.00, '2026-04-06', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(517, 1, 554, 51, 'Café premium', 3, 12.00, 36.00, '2026-04-06', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(518, 1, 554, 4, 'Snack / galletas', 3, 7.00, 21.00, '2026-04-06', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(519, 1, 555, 1, 'Agua mineral 600ml', 1, 5.00, 5.00, '2026-04-09', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(520, 1, 556, 56, 'Tabla de quesos', 3, 55.00, 165.00, '2026-04-12', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(521, 1, 557, 57, 'Estacionamiento/día', 1, 20.00, 20.00, '2026-05-11', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(522, 1, 557, 8, 'Late check-out', 1, 40.00, 40.00, '2026-05-11', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(523, 1, 559, 56, 'Tabla de quesos', 3, 55.00, 165.00, '2026-05-12', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(524, 1, 560, 7, 'Lavandería (kg)', 3, 15.00, 45.00, '2026-05-07', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(525, 1, 561, 8, 'Late check-out', 1, 40.00, 40.00, '2026-05-26', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(526, 1, 562, 52, 'Cena romántica', 1, 90.00, 90.00, '2026-05-22', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(527, 1, 564, 5, 'Desayuno buffet', 3, 25.00, 75.00, '2026-05-06', 3, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(528, 1, 565, 5, 'Desayuno buffet', 1, 25.00, 25.00, '2026-05-04', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(529, 1, 565, 50, 'Jugo natural', 3, 8.00, 24.00, '2026-05-04', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(530, 1, 566, 55, 'Planchado (unidad)', 3, 8.00, 24.00, '2026-05-23', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(531, 1, 568, 53, 'Traslado aeropuerto', 1, 60.00, 60.00, '2026-06-14', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(532, 1, 569, 7, 'Lavandería (kg)', 2, 15.00, 30.00, '2026-06-19', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(533, 1, 570, 1, 'Agua mineral 600ml', 3, 5.00, 15.00, '2026-06-17', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(534, 1, 571, 58, 'Kit de aseo', 3, 15.00, 45.00, '2026-06-07', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(535, 1, 571, 58, 'Kit de aseo', 3, 15.00, 45.00, '2026-06-07', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(536, 1, 572, 8, 'Late check-out', 1, 40.00, 40.00, '2026-06-06', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(537, 1, 572, 53, 'Traslado aeropuerto', 1, 60.00, 60.00, '2026-06-06', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(538, 1, 572, 7, 'Lavandería (kg)', 2, 15.00, 30.00, '2026-06-06', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(539, 1, 573, 7, 'Lavandería (kg)', 3, 15.00, 45.00, '2026-06-01', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(540, 1, 573, 7, 'Lavandería (kg)', 1, 15.00, 15.00, '2026-06-01', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(541, 1, 573, 7, 'Lavandería (kg)', 3, 15.00, 45.00, '2026-06-01', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(542, 1, 574, 50, 'Jugo natural', 1, 8.00, 8.00, '2026-06-17', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(543, 1, 574, 8, 'Late check-out', 2, 40.00, 80.00, '2026-06-17', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(544, 1, 575, 7, 'Lavandería (kg)', 1, 15.00, 15.00, '2026-06-03', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(545, 1, 576, 57, 'Estacionamiento/día', 3, 20.00, 60.00, '2026-06-19', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(546, 1, 577, 6, 'Almuerzo ejecutivo', 1, 35.00, 35.00, '2026-06-01', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(547, 1, 577, 55, 'Planchado (unidad)', 1, 8.00, 8.00, '2026-06-01', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(548, 1, 577, 51, 'Café premium', 2, 12.00, 24.00, '2026-06-01', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(549, 1, 579, 3, 'Cerveza', 3, 10.00, 30.00, '2026-07-04', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(550, 1, 583, 50, 'Jugo natural', 1, 8.00, 8.00, '2026-07-10', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(551, 1, 583, 2, 'Gaseosa lata', 2, 6.00, 12.00, '2026-07-10', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(552, 1, 583, 49, 'Botella de vino', 3, 45.00, 135.00, '2026-07-10', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(553, 1, 587, 55, 'Planchado (unidad)', 2, 8.00, 16.00, '2026-07-13', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(554, 1, 587, 53, 'Traslado aeropuerto', 2, 60.00, 120.00, '2026-07-13', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(555, 1, 587, 6, 'Almuerzo ejecutivo', 2, 35.00, 70.00, '2026-07-13', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(556, 1, 590, 8, 'Late check-out', 2, 40.00, 80.00, '2026-07-12', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(557, 1, 590, 52, 'Cena romántica', 3, 90.00, 270.00, '2026-07-12', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(558, 1, 591, 55, 'Planchado (unidad)', 1, 8.00, 8.00, '2026-07-20', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(559, 1, 592, 53, 'Traslado aeropuerto', 1, 60.00, 60.00, '2026-08-04', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(560, 1, 595, 5, 'Desayuno buffet', 3, 25.00, 75.00, '2026-08-01', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(561, 1, 595, 52, 'Cena romántica', 3, 90.00, 270.00, '2026-08-01', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(562, 1, 595, 51, 'Café premium', 3, 12.00, 36.00, '2026-08-01', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(563, 1, 596, 8, 'Late check-out', 2, 40.00, 80.00, '2026-08-05', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(564, 1, 596, 2, 'Gaseosa lata', 2, 6.00, 12.00, '2026-08-05', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(565, 1, 598, 8, 'Late check-out', 3, 40.00, 120.00, '2026-08-11', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(566, 1, 598, 7, 'Lavandería (kg)', 3, 15.00, 45.00, '2026-08-11', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(567, 1, 599, 58, 'Kit de aseo', 1, 15.00, 15.00, '2026-08-26', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(568, 1, 599, 2, 'Gaseosa lata', 3, 6.00, 18.00, '2026-08-26', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(569, 1, 600, 52, 'Cena romántica', 3, 90.00, 270.00, '2026-08-15', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(570, 1, 601, 6, 'Almuerzo ejecutivo', 2, 35.00, 70.00, '2026-08-14', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(571, 1, 601, 1, 'Agua mineral 600ml', 1, 5.00, 5.00, '2026-08-14', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(572, 1, 603, 54, 'Spa / masaje', 2, 120.00, 240.00, '2026-08-10', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(573, 1, 603, 1, 'Agua mineral 600ml', 1, 5.00, 5.00, '2026-08-10', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(574, 1, 604, 7, 'Lavandería (kg)', 2, 15.00, 30.00, '2026-08-16', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(575, 1, 604, 54, 'Spa / masaje', 1, 120.00, 120.00, '2026-08-16', 3, '2026-09-07 13:10:11', '2026-09-07 13:10:11');

-- Volcando estructura para tabla saas_hospedaje.empresas
CREATE TABLE IF NOT EXISTS `empresas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ruc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan_id` bigint unsigned DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `suscripcion_hasta` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `empresas_slug_unique` (`slug`),
  KEY `empresas_plan_id_index` (`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.empresas: ~2 rows (aproximadamente)
DELETE FROM `empresas`;
INSERT INTO `empresas` (`id`, `nombre`, `slug`, `ruc`, `email`, `telefono`, `direccion`, `plan_id`, `activo`, `trial_ends_at`, `suscripcion_hasta`, `created_at`, `updated_at`) VALUES
	(1, 'Hotel Sistema Hospedaje', 'hotel-demo', '20123456789', 'reservas@hospedaje.com', '(01) 555-1234', 'Av. Principal 123, Lima - Perú', 2, 1, NULL, '2027-06-09', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(2, 'Hostal El Viajero', 'hostal-el-viajero', '20555666777', 'contacto@elviajero.com', '(01) 444-5566', 'Jr. Comercio 456, Cusco - Perú', 1, 1, '2026-06-27 21:12:59', NULL, '2026-06-09 21:12:59', '2026-06-09 21:12:59');

-- Volcando estructura para tabla saas_hospedaje.facturacion_configs
CREATE TABLE IF NOT EXISTS `facturacion_configs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `habilitado` tinyint(1) NOT NULL DEFAULT '0',
  `emitir_automatico` tinyint(1) NOT NULL DEFAULT '0',
  `driver` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ninguno',
  `entorno` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'beta',
  `ruc` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_comercial` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion_fiscal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ubigeo` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departamento` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provincia` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `distrito` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario_sol` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clave_sol` text COLLATE utf8mb4_unicode_ci,
  `certificado_ruta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certificado_clave` text COLLATE utf8mb4_unicode_ci,
  `serie_boleta` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'B001',
  `serie_factura` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F001',
  `serie_nota_credito` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'FC01',
  `moneda` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PEN',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `facturacion_configs_empresa_id_unique` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.facturacion_configs: ~0 rows (aproximadamente)
DELETE FROM `facturacion_configs`;
INSERT INTO `facturacion_configs` (`id`, `empresa_id`, `habilitado`, `emitir_automatico`, `driver`, `entorno`, `ruc`, `razon_social`, `nombre_comercial`, `direccion_fiscal`, `ubigeo`, `departamento`, `provincia`, `distrito`, `usuario_sol`, `clave_sol`, `certificado_ruta`, `certificado_clave`, `serie_boleta`, `serie_factura`, `serie_nota_credito`, `moneda`, `created_at`, `updated_at`) VALUES
	(1, 1, 0, 0, 'ninguno', 'beta', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'B001', 'F001', 'FC01', 'PEN', '2026-08-06 12:54:47', '2026-08-06 12:54:47');

-- Volcando estructura para tabla saas_hospedaje.facturacion_resumenes
CREATE TABLE IF NOT EXISTS `facturacion_resumenes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `identificador` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correlativo` int unsigned NOT NULL DEFAULT '1',
  `fecha_referencia` date NOT NULL,
  `ticket` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'generado',
  `total_boletas` int unsigned NOT NULL DEFAULT '0',
  `mensaje` text COLLATE utf8mb4_unicode_ci,
  `cdr_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enviado_at` timestamp NULL DEFAULT NULL,
  `aceptado_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facturacion_resumenes_empresa_id_index` (`empresa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.facturacion_resumenes: ~0 rows (aproximadamente)
DELETE FROM `facturacion_resumenes`;

-- Volcando estructura para tabla saas_hospedaje.facturas
CREATE TABLE IF NOT EXISTS `facturas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `numero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_comprobante` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serie` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correlativo` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `moneda` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PEN',
  `reserva_id` bigint unsigned NOT NULL,
  `fecha` date NOT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT '0.00',
  `igv` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `estado` enum('pendiente','pagada','anulada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `metodo_pago` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sunat_estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no_emitido',
  `sunat_ticket` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sunat_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sunat_mensaje` text COLLATE utf8mb4_unicode_ci,
  `sunat_xml_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sunat_cdr_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sunat_enviado_at` timestamp NULL DEFAULT NULL,
  `resumen_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `facturas_numero_unique` (`numero`),
  KEY `facturas_reserva_id_foreign` (`reserva_id`),
  KEY `facturas_empresa_id_index` (`empresa_id`),
  KEY `facturas_resumen_id_index` (`resumen_id`),
  CONSTRAINT `facturas_reserva_id_foreign` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=605 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.facturas: ~201 rows (aproximadamente)
DELETE FROM `facturas`;
INSERT INTO `facturas` (`id`, `empresa_id`, `numero`, `tipo_comprobante`, `serie`, `correlativo`, `moneda`, `reserva_id`, `fecha`, `subtotal`, `igv`, `total`, `estado`, `metodo_pago`, `sunat_estado`, `sunat_ticket`, `sunat_hash`, `sunat_mensaje`, `sunat_xml_path`, `sunat_cdr_path`, `sunat_enviado_at`, `resumen_id`, `created_at`, `updated_at`) VALUES
	(1, 1, 'F001-000001', NULL, NULL, NULL, 'PEN', 1, '2026-01-10', 135.59, 24.41, 160.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(2, 1, 'F001-000002', NULL, NULL, NULL, 'PEN', 2, '2026-01-06', 245.76, 44.24, 290.00, 'pendiente', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:01'),
	(3, 1, 'F001-000003', NULL, NULL, NULL, 'PEN', 3, '2026-01-05', 593.22, 106.78, 700.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(4, 1, 'F001-000004', NULL, NULL, NULL, 'PEN', 4, '2026-01-07', 135.59, 24.41, 160.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(5, 1, 'F001-000005', NULL, NULL, NULL, 'PEN', 5, '2026-01-28', 118.64, 21.36, 140.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(6, 1, 'F001-000006', NULL, NULL, NULL, 'PEN', 6, '2026-01-31', 889.83, 160.17, 1050.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(7, 1, 'F001-000007', NULL, NULL, NULL, 'PEN', 7, '2026-01-04', 76.27, 13.73, 90.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(8, 1, 'F001-000008', NULL, NULL, NULL, 'PEN', 8, '2026-01-31', 1538.14, 276.86, 1815.00, 'pendiente', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:02'),
	(9, 1, 'F001-000009', NULL, NULL, NULL, 'PEN', 9, '2026-01-11', 296.61, 53.39, 350.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(10, 1, 'F001-000010', NULL, NULL, NULL, 'PEN', 10, '2026-01-13', 418.64, 75.36, 494.00, 'pendiente', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(11, 1, 'F001-000011', NULL, NULL, NULL, 'PEN', 11, '2026-01-15', 677.97, 122.03, 800.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(12, 1, 'F001-000012', NULL, NULL, NULL, 'PEN', 12, '2026-01-24', 593.22, 106.78, 700.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(13, 1, 'F001-000013', NULL, NULL, NULL, 'PEN', 13, '2026-01-10', 677.97, 122.03, 800.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(14, 1, 'F001-000014', NULL, NULL, NULL, 'PEN', 14, '2026-01-10', 228.81, 41.19, 270.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(15, 1, 'F001-000015', NULL, NULL, NULL, 'PEN', 15, '2026-02-09', 177.97, 32.03, 210.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(16, 1, 'F001-000016', NULL, NULL, NULL, 'PEN', 16, '2026-02-15', 237.29, 42.71, 280.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(17, 1, 'F001-000017', NULL, NULL, NULL, 'PEN', 17, '2026-02-08', 711.86, 128.14, 840.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(18, 1, 'F001-000018', NULL, NULL, NULL, 'PEN', 18, '2026-02-07', 474.58, 85.42, 560.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(19, 1, 'F001-000019', NULL, NULL, NULL, 'PEN', 19, '2026-02-07', 355.93, 64.07, 420.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(20, 1, 'F001-000020', NULL, NULL, NULL, 'PEN', 20, '2026-02-19', 317.80, 57.20, 375.00, 'pendiente', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:02'),
	(21, 1, 'F001-000021', NULL, NULL, NULL, 'PEN', 21, '2026-02-15', 381.36, 68.64, 450.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(22, 1, 'F001-000022', NULL, NULL, NULL, 'PEN', 22, '2026-02-21', 889.83, 160.17, 1050.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(23, 1, 'F001-000023', NULL, NULL, NULL, 'PEN', 23, '2026-02-09', 1186.44, 213.56, 1400.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(24, 1, 'F001-000024', NULL, NULL, NULL, 'PEN', 24, '2026-02-09', 271.19, 48.81, 320.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(25, 1, 'F001-000025', NULL, NULL, NULL, 'PEN', 25, '2026-02-28', 305.08, 54.92, 360.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(26, 1, 'F001-000026', NULL, NULL, NULL, 'PEN', 26, '2026-02-26', 593.22, 106.78, 700.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(27, 1, 'F001-000027', NULL, NULL, NULL, 'PEN', 27, '2026-02-28', 228.81, 41.19, 270.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(28, 1, 'F001-000028', NULL, NULL, NULL, 'PEN', 28, '2026-02-13', 271.19, 48.81, 320.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(29, 1, 'F001-000029', NULL, NULL, NULL, 'PEN', 29, '2026-02-18', 1317.80, 237.20, 1555.00, 'pendiente', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:02'),
	(30, 1, 'F001-000030', NULL, NULL, NULL, 'PEN', 30, '2026-02-10', 116.95, 21.05, 138.00, 'pendiente', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(31, 1, 'F001-000031', NULL, NULL, NULL, 'PEN', 31, '2026-02-15', 1483.05, 266.95, 1750.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(32, 1, 'F001-000032', NULL, NULL, NULL, 'PEN', 32, '2026-03-06', 677.97, 122.03, 800.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(33, 1, 'F001-000033', NULL, NULL, NULL, 'PEN', 33, '2026-03-10', 355.93, 64.07, 420.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(34, 1, 'F001-000034', NULL, NULL, NULL, 'PEN', 34, '2026-03-27', 177.97, 32.03, 210.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(35, 1, 'F001-000035', NULL, NULL, NULL, 'PEN', 35, '2026-03-31', 711.86, 128.14, 840.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(36, 1, 'F001-000036', NULL, NULL, NULL, 'PEN', 36, '2026-03-30', 889.83, 160.17, 1050.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(37, 1, 'F001-000037', NULL, NULL, NULL, 'PEN', 37, '2026-03-19', 241.53, 43.47, 285.00, 'pendiente', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(38, 1, 'F001-000038', NULL, NULL, NULL, 'PEN', 38, '2026-03-12', 1483.05, 266.95, 1750.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(39, 1, 'F001-000039', NULL, NULL, NULL, 'PEN', 39, '2026-03-06', 593.22, 106.78, 700.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(40, 1, 'F001-000040', NULL, NULL, NULL, 'PEN', 40, '2026-03-20', 228.81, 41.19, 270.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(41, 1, 'F001-000041', NULL, NULL, NULL, 'PEN', 41, '2026-03-22', 470.34, 84.66, 555.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(42, 1, 'F001-000042', NULL, NULL, NULL, 'PEN', 42, '2026-03-05', 593.22, 106.78, 700.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(43, 1, 'F001-000043', NULL, NULL, NULL, 'PEN', 43, '2026-03-17', 1483.05, 266.95, 1750.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(44, 1, 'F001-000044', NULL, NULL, NULL, 'PEN', 44, '2026-03-25', 271.19, 48.81, 320.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(45, 1, 'F001-000045', NULL, NULL, NULL, 'PEN', 45, '2026-03-23', 135.59, 24.41, 160.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(46, 1, 'F001-000046', NULL, NULL, NULL, 'PEN', 46, '2026-03-20', 76.27, 13.73, 90.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(47, 1, 'F001-000047', NULL, NULL, NULL, 'PEN', 47, '2026-03-14', 406.78, 73.22, 480.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(48, 1, 'F001-000048', NULL, NULL, NULL, 'PEN', 48, '2026-03-24', 152.54, 27.46, 180.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(49, 1, 'F001-000049', NULL, NULL, NULL, 'PEN', 49, '2026-03-23', 711.86, 128.14, 840.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(50, 1, 'F001-000050', NULL, NULL, NULL, 'PEN', 50, '2026-03-08', 1186.44, 213.56, 1400.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(51, 1, 'F001-000051', NULL, NULL, NULL, 'PEN', 51, '2026-03-07', 593.22, 106.78, 700.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(52, 1, 'F001-000052', NULL, NULL, NULL, 'PEN', 52, '2026-03-15', 889.83, 160.17, 1050.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(53, 1, 'F001-000053', NULL, NULL, NULL, 'PEN', 53, '2026-04-06', 296.61, 53.39, 350.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(54, 1, 'F001-000054', NULL, NULL, NULL, 'PEN', 54, '2026-04-19', 711.86, 128.14, 840.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(55, 1, 'F001-000055', NULL, NULL, NULL, 'PEN', 55, '2026-04-16', 305.08, 54.92, 360.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(56, 1, 'F001-000056', NULL, NULL, NULL, 'PEN', 56, '2026-04-29', 228.81, 41.19, 270.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(57, 1, 'F001-000057', NULL, NULL, NULL, 'PEN', 57, '2026-04-20', 741.53, 133.47, 875.00, 'pendiente', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(58, 1, 'F001-000058', NULL, NULL, NULL, 'PEN', 58, '2026-04-26', 237.29, 42.71, 280.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(59, 1, 'F001-000059', NULL, NULL, NULL, 'PEN', 59, '2026-04-30', 406.78, 73.22, 480.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(60, 1, 'F001-000060', NULL, NULL, NULL, 'PEN', 60, '2026-04-08', 542.37, 97.63, 640.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(61, 1, 'F001-000061', NULL, NULL, NULL, 'PEN', 61, '2026-04-03', 593.22, 106.78, 700.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(62, 1, 'F001-000062', NULL, NULL, NULL, 'PEN', 62, '2026-04-28', 1186.44, 213.56, 1400.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(63, 1, 'F001-000063', NULL, NULL, NULL, 'PEN', 63, '2026-04-08', 305.08, 54.92, 360.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(64, 1, 'F001-000064', NULL, NULL, NULL, 'PEN', 64, '2026-04-13', 593.22, 106.78, 700.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(65, 1, 'F001-000065', NULL, NULL, NULL, 'PEN', 65, '2026-04-22', 152.54, 27.46, 180.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(66, 1, 'F001-000066', NULL, NULL, NULL, 'PEN', 66, '2026-04-19', 237.29, 42.71, 280.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(67, 1, 'F001-000067', NULL, NULL, NULL, 'PEN', 67, '2026-04-08', 381.36, 68.64, 450.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(68, 1, 'F001-000068', NULL, NULL, NULL, 'PEN', 68, '2026-04-29', 228.81, 41.19, 270.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(69, 1, 'F001-000069', NULL, NULL, NULL, 'PEN', 69, '2026-04-09', 152.54, 27.46, 180.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(70, 1, 'F001-000070', NULL, NULL, NULL, 'PEN', 70, '2026-04-07', 271.19, 48.81, 320.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(71, 1, 'F001-000071', NULL, NULL, NULL, 'PEN', 71, '2026-05-19', 593.22, 106.78, 700.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(72, 1, 'F001-000072', NULL, NULL, NULL, 'PEN', 72, '2026-05-25', 76.27, 13.73, 90.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(73, 1, 'F001-000073', NULL, NULL, NULL, 'PEN', 73, '2026-05-11', 406.78, 73.22, 480.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(74, 1, 'F001-000074', NULL, NULL, NULL, 'PEN', 74, '2026-05-19', 296.61, 53.39, 350.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(75, 1, 'F001-000075', NULL, NULL, NULL, 'PEN', 75, '2026-05-16', 76.27, 13.73, 90.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(76, 1, 'F001-000076', NULL, NULL, NULL, 'PEN', 76, '2026-05-09', 474.58, 85.42, 560.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(77, 1, 'F001-000077', NULL, NULL, NULL, 'PEN', 77, '2026-05-04', 889.83, 160.17, 1050.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(78, 1, 'F001-000078', NULL, NULL, NULL, 'PEN', 78, '2026-05-24', 305.08, 54.92, 360.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(79, 1, 'F001-000079', NULL, NULL, NULL, 'PEN', 79, '2026-05-23', 593.22, 106.78, 700.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(80, 1, 'F001-000080', NULL, NULL, NULL, 'PEN', 80, '2026-05-14', 118.64, 21.36, 140.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(81, 1, 'F001-000081', NULL, NULL, NULL, 'PEN', 81, '2026-05-16', 533.90, 96.10, 630.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(82, 1, 'F001-000082', NULL, NULL, NULL, 'PEN', 82, '2026-05-12', 76.27, 13.73, 90.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(83, 1, 'F001-000083', NULL, NULL, NULL, 'PEN', 83, '2026-05-28', 76.27, 13.73, 90.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(84, 1, 'F001-000084', NULL, NULL, NULL, 'PEN', 84, '2026-05-23', 593.22, 106.78, 700.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(85, 1, 'F001-000085', NULL, NULL, NULL, 'PEN', 85, '2026-05-20', 355.93, 64.07, 420.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(86, 1, 'F001-000086', NULL, NULL, NULL, 'PEN', 86, '2026-05-18', 118.64, 21.36, 140.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(87, 1, 'F001-000087', NULL, NULL, NULL, 'PEN', 87, '2026-05-13', 889.83, 160.17, 1050.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(88, 1, 'F001-000088', NULL, NULL, NULL, 'PEN', 88, '2026-06-19', 1201.69, 216.31, 1418.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(89, 1, 'F001-000089', NULL, NULL, NULL, 'PEN', 89, '2026-06-08', 118.64, 21.36, 140.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(90, 1, 'F001-000090', NULL, NULL, NULL, 'PEN', 90, '2026-06-26', 406.78, 73.22, 480.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(91, 1, 'F001-000091', NULL, NULL, NULL, 'PEN', 91, '2026-06-13', 177.97, 32.03, 210.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(92, 1, 'F001-000092', NULL, NULL, NULL, 'PEN', 92, '2026-06-20', 889.83, 160.17, 1050.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(93, 1, 'F001-000093', NULL, NULL, NULL, 'PEN', 93, '2026-06-18', 271.19, 48.81, 320.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(94, 1, 'F001-000094', NULL, NULL, NULL, 'PEN', 94, '2026-06-29', 1483.05, 266.95, 1750.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(95, 1, 'F001-000095', NULL, NULL, NULL, 'PEN', 95, '2026-06-07', 271.19, 48.81, 320.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(96, 1, 'F001-000096', NULL, NULL, NULL, 'PEN', 96, '2026-06-23', 677.97, 122.03, 800.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(97, 1, 'F001-000097', NULL, NULL, NULL, 'PEN', 97, '2026-06-18', 237.29, 42.71, 280.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(98, 1, 'F001-000098', NULL, NULL, NULL, 'PEN', 98, '2026-06-27', 135.59, 24.41, 160.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(99, 1, 'F001-000099', NULL, NULL, NULL, 'PEN', 99, '2026-06-22', 542.37, 97.63, 640.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(100, 1, 'F001-000100', NULL, NULL, NULL, 'PEN', 100, '2026-06-20', 677.97, 122.03, 800.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(101, 1, 'F001-000101', NULL, NULL, NULL, 'PEN', 101, '2026-06-23', 305.08, 54.92, 360.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(102, 1, 'F001-000102', NULL, NULL, NULL, 'PEN', 102, '2026-06-10', 296.61, 53.39, 350.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(506, 1, 'DEMO-001102', NULL, NULL, NULL, 'PEN', 506, '2026-09-03', 372.88, 67.12, 440.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:09', '2026-09-07 13:10:09'),
	(507, 1, 'DEMO-001103', NULL, NULL, NULL, 'PEN', 507, '2026-09-04', 699.15, 125.85, 825.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(508, 1, 'DEMO-001104', NULL, NULL, NULL, 'PEN', 508, '2026-09-03', 152.54, 27.46, 180.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(509, 1, 'DEMO-001105', NULL, NULL, NULL, 'PEN', 509, '2026-09-06', 305.08, 54.92, 360.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(510, 1, 'DEMO-001106', NULL, NULL, NULL, 'PEN', 510, '2026-09-05', 411.02, 73.98, 485.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(511, 1, 'DEMO-001107', NULL, NULL, NULL, 'PEN', 511, '2026-09-06', 305.08, 54.92, 360.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(512, 1, 'DEMO-001108', NULL, NULL, NULL, 'PEN', 512, '2026-09-06', 1304.24, 234.76, 1539.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(513, 1, 'DEMO-001109', NULL, NULL, NULL, 'PEN', 513, '2026-09-05', 228.81, 41.19, 270.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(514, 1, 'DEMO-001110', NULL, NULL, NULL, 'PEN', 514, '2026-09-06', 533.90, 96.10, 630.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(515, 1, 'DEMO-001111', NULL, NULL, NULL, 'PEN', 515, '2026-09-05', 386.44, 69.56, 456.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(516, 1, 'DEMO-001112', NULL, NULL, NULL, 'PEN', 516, '2026-09-06', 406.78, 73.22, 480.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(517, 1, 'DEMO-001113', NULL, NULL, NULL, 'PEN', 517, '2026-09-05', 271.19, 48.81, 320.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(518, 1, 'DEMO-001114', NULL, NULL, NULL, 'PEN', 518, '2026-09-05', 250.85, 45.15, 296.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(519, 1, 'DEMO-001115', NULL, NULL, NULL, 'PEN', 519, '2026-09-08', 661.86, 119.14, 781.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(520, 1, 'DEMO-001116', NULL, NULL, NULL, 'PEN', 520, '2026-09-06', 364.41, 65.59, 430.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(521, 1, 'DEMO-001117', NULL, NULL, NULL, 'PEN', 521, '2026-09-07', 228.81, 41.19, 270.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(522, 1, 'DEMO-001118', NULL, NULL, NULL, 'PEN', 522, '2026-09-08', 355.93, 64.07, 420.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(523, 1, 'DEMO-001119', NULL, NULL, NULL, 'PEN', 523, '2026-09-09', 711.86, 128.14, 840.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(524, 1, 'DEMO-001120', NULL, NULL, NULL, 'PEN', 524, '2026-09-06', 162.71, 29.29, 192.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(525, 1, 'DEMO-001121', NULL, NULL, NULL, 'PEN', 525, '2026-09-10', 1186.44, 213.56, 1400.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(526, 1, 'DEMO-001122', NULL, NULL, NULL, 'PEN', 526, '2026-09-07', 259.32, 46.68, 306.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(527, 1, 'DEMO-001123', NULL, NULL, NULL, 'PEN', 527, '2026-09-08', 355.93, 64.07, 420.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(528, 1, 'DEMO-001124', NULL, NULL, NULL, 'PEN', 528, '2026-09-08', 238.98, 43.02, 282.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(529, 1, 'DEMO-001125', NULL, NULL, NULL, 'PEN', 529, '2026-09-09', 292.37, 52.63, 345.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(530, 1, 'DEMO-001126', NULL, NULL, NULL, 'PEN', 530, '2026-09-09', 235.59, 42.41, 278.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(531, 1, 'DEMO-001127', NULL, NULL, NULL, 'PEN', 531, '2026-09-09', 355.93, 64.07, 420.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(532, 1, 'DEMO-001128', NULL, NULL, NULL, 'PEN', 532, '2026-09-23', 470.34, 84.66, 555.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(533, 1, 'DEMO-001129', NULL, NULL, NULL, 'PEN', 533, '2026-09-12', 406.78, 73.22, 480.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(534, 1, 'DEMO-001130', NULL, NULL, NULL, 'PEN', 534, '2026-09-15', 469.49, 84.51, 554.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(535, 1, 'DEMO-001131', NULL, NULL, NULL, 'PEN', 535, '2026-09-19', 542.37, 97.63, 640.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(536, 1, 'DEMO-001132', NULL, NULL, NULL, 'PEN', 536, '2026-09-18', 317.80, 57.20, 375.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(537, 1, 'DEMO-001133', NULL, NULL, NULL, 'PEN', 537, '2026-09-22', 271.19, 48.81, 320.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(538, 1, 'DEMO-001134', NULL, NULL, NULL, 'PEN', 538, '2026-10-01', 315.25, 56.75, 372.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(539, 1, 'DEMO-001135', NULL, NULL, NULL, 'PEN', 539, '2026-09-29', 1318.64, 237.36, 1556.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(540, 1, 'DEMO-001136', NULL, NULL, NULL, 'PEN', 540, '2026-09-16', 542.37, 97.63, 640.00, 'pendiente', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(541, 1, 'DEMO-001137', NULL, NULL, NULL, 'PEN', 541, '2026-09-22', 600.00, 108.00, 708.00, 'anulada', NULL, 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(542, 1, 'DEMO-001138', NULL, NULL, NULL, 'PEN', 542, '2026-09-08', 258.47, 46.53, 305.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(543, 1, 'DEMO-001139', NULL, NULL, NULL, 'PEN', 543, '2026-09-10', 355.93, 64.07, 420.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(544, 1, 'DEMO-001140', NULL, NULL, NULL, 'PEN', 544, '2026-09-10', 889.83, 160.17, 1050.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(545, 1, 'DEMO-001141', NULL, NULL, NULL, 'PEN', 545, '2026-09-04', 216.10, 38.90, 255.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(546, 1, 'DEMO-001142', NULL, NULL, NULL, 'PEN', 546, '2026-09-05', 84.75, 15.25, 100.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(547, 1, 'DEMO-001143', NULL, NULL, NULL, 'PEN', 547, '2026-09-05', 368.64, 66.36, 435.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(548, 1, 'DEMO-001144', NULL, NULL, NULL, 'PEN', 548, '2026-04-12', 334.75, 60.25, 395.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(549, 1, 'DEMO-001145', NULL, NULL, NULL, 'PEN', 549, '2026-05-01', 542.37, 97.63, 640.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(550, 1, 'DEMO-001146', NULL, NULL, NULL, 'PEN', 550, '2026-04-16', 1550.00, 279.00, 1829.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(551, 1, 'DEMO-001147', NULL, NULL, NULL, 'PEN', 551, '2026-04-09', 381.36, 68.64, 450.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(552, 1, 'DEMO-001148', NULL, NULL, NULL, 'PEN', 552, '2026-04-09', 854.24, 153.76, 1008.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(553, 1, 'DEMO-001149', NULL, NULL, NULL, 'PEN', 553, '2026-04-16', 711.86, 128.14, 840.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(554, 1, 'DEMO-001150', NULL, NULL, NULL, 'PEN', 554, '2026-04-10', 811.02, 145.98, 957.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(555, 1, 'DEMO-001151', NULL, NULL, NULL, 'PEN', 555, '2026-04-12', 894.07, 160.93, 1055.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(556, 1, 'DEMO-001152', NULL, NULL, NULL, 'PEN', 556, '2026-04-14', 377.12, 67.88, 445.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(557, 1, 'DEMO-001153', NULL, NULL, NULL, 'PEN', 557, '2026-05-15', 525.42, 94.58, 620.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(558, 1, 'DEMO-001154', NULL, NULL, NULL, 'PEN', 558, '2026-05-08', 271.19, 48.81, 320.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(559, 1, 'DEMO-001155', NULL, NULL, NULL, 'PEN', 559, '2026-05-14', 377.12, 67.88, 445.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(560, 1, 'DEMO-001156', NULL, NULL, NULL, 'PEN', 560, '2026-05-12', 1521.19, 273.81, 1795.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(561, 1, 'DEMO-001157', NULL, NULL, NULL, 'PEN', 561, '2026-05-29', 440.68, 79.32, 520.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(562, 1, 'DEMO-001158', NULL, NULL, NULL, 'PEN', 562, '2026-05-23', 211.86, 38.14, 250.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(563, 1, 'DEMO-001159', NULL, NULL, NULL, 'PEN', 563, '2026-05-19', 305.08, 54.92, 360.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(564, 1, 'DEMO-001160', NULL, NULL, NULL, 'PEN', 564, '2026-05-07', 139.83, 25.17, 165.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(565, 1, 'DEMO-001161', NULL, NULL, NULL, 'PEN', 565, '2026-05-09', 931.36, 167.64, 1099.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(566, 1, 'DEMO-001162', NULL, NULL, NULL, 'PEN', 566, '2026-05-27', 562.71, 101.29, 664.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(567, 1, 'DEMO-001163', NULL, NULL, NULL, 'PEN', 567, '2026-05-30', 305.08, 54.92, 360.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(568, 1, 'DEMO-001164', NULL, NULL, NULL, 'PEN', 568, '2026-06-17', 584.75, 105.25, 690.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(569, 1, 'DEMO-001165', NULL, NULL, NULL, 'PEN', 569, '2026-06-22', 915.25, 164.75, 1080.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(570, 1, 'DEMO-001166', NULL, NULL, NULL, 'PEN', 570, '2026-06-18', 131.36, 23.64, 155.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(571, 1, 'DEMO-001167', NULL, NULL, NULL, 'PEN', 571, '2026-06-08', 211.86, 38.14, 250.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(572, 1, 'DEMO-001168', NULL, NULL, NULL, 'PEN', 572, '2026-06-10', 652.54, 117.46, 770.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(573, 1, 'DEMO-001169', NULL, NULL, NULL, 'PEN', 573, '2026-06-05', 1275.42, 229.58, 1505.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(574, 1, 'DEMO-001170', NULL, NULL, NULL, 'PEN', 574, '2026-06-20', 481.36, 86.64, 568.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(575, 1, 'DEMO-001171', NULL, NULL, NULL, 'PEN', 575, '2026-06-07', 555.08, 99.92, 655.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(576, 1, 'DEMO-001172', NULL, NULL, NULL, 'PEN', 576, '2026-06-24', 644.07, 115.93, 760.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(577, 1, 'DEMO-001173', NULL, NULL, NULL, 'PEN', 577, '2026-06-05', 361.86, 65.14, 427.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(578, 1, 'DEMO-001174', NULL, NULL, NULL, 'PEN', 578, '2026-07-21', 406.78, 73.22, 480.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(579, 1, 'DEMO-001175', NULL, NULL, NULL, 'PEN', 579, '2026-07-07', 254.24, 45.76, 300.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(580, 1, 'DEMO-001176', NULL, NULL, NULL, 'PEN', 580, '2026-07-19', 228.81, 41.19, 270.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(581, 1, 'DEMO-001177', NULL, NULL, NULL, 'PEN', 581, '2026-07-19', 381.36, 68.64, 450.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(582, 1, 'DEMO-001178', NULL, NULL, NULL, 'PEN', 582, '2026-07-31', 542.37, 97.63, 640.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(583, 1, 'DEMO-001179', NULL, NULL, NULL, 'PEN', 583, '2026-07-11', 207.63, 37.37, 245.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(584, 1, 'DEMO-001180', NULL, NULL, NULL, 'PEN', 584, '2026-07-17', 355.93, 64.07, 420.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(585, 1, 'DEMO-001181', NULL, NULL, NULL, 'PEN', 585, '2026-07-27', 228.81, 41.19, 270.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(586, 1, 'DEMO-001182', NULL, NULL, NULL, 'PEN', 586, '2026-07-08', 135.59, 24.41, 160.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(587, 1, 'DEMO-001183', NULL, NULL, NULL, 'PEN', 587, '2026-07-15', 411.86, 74.14, 486.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(588, 1, 'DEMO-001184', NULL, NULL, NULL, 'PEN', 588, '2026-07-16', 593.22, 106.78, 700.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(589, 1, 'DEMO-001185', NULL, NULL, NULL, 'PEN', 589, '2026-07-18', 355.93, 64.07, 420.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(590, 1, 'DEMO-001186', NULL, NULL, NULL, 'PEN', 590, '2026-07-14', 889.83, 160.17, 1050.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(591, 1, 'DEMO-001187', NULL, NULL, NULL, 'PEN', 591, '2026-07-25', 684.75, 123.25, 808.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(592, 1, 'DEMO-001188', NULL, NULL, NULL, 'PEN', 592, '2026-08-08', 593.22, 106.78, 700.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(593, 1, 'DEMO-001189', NULL, NULL, NULL, 'PEN', 593, '2026-08-27', 135.59, 24.41, 160.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(594, 1, 'DEMO-001190', NULL, NULL, NULL, 'PEN', 594, '2026-08-22', 889.83, 160.17, 1050.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(595, 1, 'DEMO-001191', NULL, NULL, NULL, 'PEN', 595, '2026-08-05', 1509.32, 271.68, 1781.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(596, 1, 'DEMO-001192', NULL, NULL, NULL, 'PEN', 596, '2026-08-08', 484.75, 87.25, 572.00, 'pagada', 'efectivo', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(597, 1, 'DEMO-001193', NULL, NULL, NULL, 'PEN', 597, '2026-08-29', 271.19, 48.81, 320.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(598, 1, 'DEMO-001194', NULL, NULL, NULL, 'PEN', 598, '2026-08-12', 275.42, 49.58, 325.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(599, 1, 'DEMO-001195', NULL, NULL, NULL, 'PEN', 599, '2026-08-29', 434.75, 78.25, 513.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(600, 1, 'DEMO-001196', NULL, NULL, NULL, 'PEN', 600, '2026-08-18', 1118.64, 201.36, 1320.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(601, 1, 'DEMO-001197', NULL, NULL, NULL, 'PEN', 601, '2026-08-19', 953.39, 171.61, 1125.00, 'pagada', 'yape', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(602, 1, 'DEMO-001198', NULL, NULL, NULL, 'PEN', 602, '2026-08-25', 305.08, 54.92, 360.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(603, 1, 'DEMO-001199', NULL, NULL, NULL, 'PEN', 603, '2026-08-12', 478.81, 86.19, 565.00, 'pagada', 'transferencia', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(604, 1, 'DEMO-001200', NULL, NULL, NULL, 'PEN', 604, '2026-08-20', 432.20, 77.80, 510.00, 'pagada', 'tarjeta', 'no_emitido', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-07 13:10:11', '2026-09-07 13:10:11');

-- Volcando estructura para tabla saas_hospedaje.habitaciones
CREATE TABLE IF NOT EXISTS `habitaciones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `numero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_habitacion_id` bigint unsigned NOT NULL,
  `piso` tinyint unsigned NOT NULL DEFAULT '1',
  `precio_noche` decimal(10,2) NOT NULL DEFAULT '0.00',
  `capacidad` tinyint unsigned NOT NULL DEFAULT '1',
  `estado` enum('disponible','ocupada','mantenimiento','limpieza') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'disponible',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `habitaciones_empresa_id_numero_unique` (`empresa_id`,`numero`),
  KEY `habitaciones_tipo_habitacion_id_foreign` (`tipo_habitacion_id`),
  KEY `habitaciones_empresa_id_index` (`empresa_id`),
  CONSTRAINT `habitaciones_tipo_habitacion_id_foreign` FOREIGN KEY (`tipo_habitacion_id`) REFERENCES `tipo_habitaciones` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.habitaciones: ~42 rows (aproximadamente)
DELETE FROM `habitaciones`;
INSERT INTO `habitaciones` (`id`, `empresa_id`, `numero`, `tipo_habitacion_id`, `piso`, `precio_noche`, `capacidad`, `estado`, `descripcion`, `created_at`, `updated_at`) VALUES
	(1, 1, '101', 1, 1, 90.00, 1, 'ocupada', 'Habitación Individual en piso 1.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(2, 1, '102', 1, 1, 90.00, 1, 'ocupada', 'Habitación Individual en piso 1.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(3, 1, '103', 5, 1, 350.00, 4, 'ocupada', 'Habitación Suite en piso 1.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(4, 1, '104', 3, 1, 160.00, 2, 'ocupada', 'Habitación Matrimonial en piso 1.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(5, 1, '105', 1, 1, 90.00, 1, 'ocupada', 'Habitación Individual en piso 1.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(6, 1, '106', 3, 1, 160.00, 2, 'ocupada', 'Habitación Matrimonial en piso 1.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(7, 1, '107', 5, 1, 350.00, 4, 'ocupada', 'Habitación Suite en piso 1.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(8, 1, '108', 1, 1, 90.00, 1, 'ocupada', 'Habitación Individual en piso 1.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(9, 1, '109', 3, 1, 160.00, 2, 'limpieza', 'Habitación Matrimonial en piso 1.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(10, 1, '110', 5, 1, 350.00, 4, 'limpieza', 'Habitación Suite en piso 1.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(11, 1, '111', 5, 1, 350.00, 4, 'limpieza', 'Habitación Suite en piso 1.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(12, 1, '201', 4, 2, 210.00, 3, 'limpieza', 'Habitación Triple en piso 2.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(13, 1, '202', 2, 2, 140.00, 2, 'limpieza', 'Habitación Doble en piso 2.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(14, 1, '203', 4, 2, 210.00, 3, 'limpieza', 'Habitación Triple en piso 2.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(15, 1, '204', 1, 2, 90.00, 1, 'mantenimiento', 'Habitación Individual en piso 2.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(16, 1, '205', 5, 2, 350.00, 4, 'mantenimiento', 'Habitación Suite en piso 2.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(17, 1, '206', 5, 2, 350.00, 4, 'mantenimiento', 'Habitación Suite en piso 2.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(18, 1, '207', 1, 2, 90.00, 1, 'mantenimiento', 'Habitación Individual en piso 2.', '2026-06-09 21:13:00', '2026-07-02 12:12:49'),
	(19, 1, '208', 4, 2, 210.00, 3, 'disponible', 'Habitación Triple en piso 2.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(20, 1, '209', 5, 2, 350.00, 4, 'disponible', 'Habitación Suite en piso 2.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(21, 1, '210', 1, 2, 90.00, 1, 'disponible', 'Habitación Individual en piso 2.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(22, 1, '211', 2, 2, 140.00, 2, 'disponible', 'Habitación Doble en piso 2.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(23, 1, '301', 4, 3, 210.00, 3, 'disponible', 'Habitación Triple en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(24, 1, '302', 5, 3, 350.00, 4, 'disponible', 'Habitación Suite en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(25, 1, '303', 5, 3, 350.00, 4, 'disponible', 'Habitación Suite en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(26, 1, '304', 4, 3, 210.00, 3, 'disponible', 'Habitación Triple en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(27, 1, '305', 2, 3, 140.00, 2, 'disponible', 'Habitación Doble en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(28, 1, '306', 3, 3, 160.00, 2, 'disponible', 'Habitación Matrimonial en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(29, 1, '307', 2, 3, 140.00, 2, 'disponible', 'Habitación Doble en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(30, 1, '308', 4, 3, 210.00, 3, 'disponible', 'Habitación Triple en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(31, 1, '309', 1, 3, 90.00, 1, 'disponible', 'Habitación Individual en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(32, 1, '310', 2, 3, 140.00, 2, 'disponible', 'Habitación Doble en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(33, 1, '311', 5, 3, 350.00, 4, 'disponible', 'Habitación Suite en piso 3.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(34, 1, '401', 3, 4, 160.00, 2, 'disponible', 'Habitación Matrimonial en piso 4.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(35, 1, '402', 2, 4, 140.00, 2, 'disponible', 'Habitación Doble en piso 4.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(36, 1, '403', 3, 4, 160.00, 2, 'disponible', 'Habitación Matrimonial en piso 4.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(37, 1, '404', 3, 4, 160.00, 2, 'disponible', 'Habitación Matrimonial en piso 4.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(38, 1, '405', 2, 4, 140.00, 2, 'disponible', 'Habitación Doble en piso 4.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(39, 1, '406', 3, 4, 160.00, 2, 'disponible', 'Habitación Matrimonial en piso 4.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(40, 1, '407', 3, 4, 160.00, 2, 'disponible', 'Habitación Matrimonial en piso 4.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(41, 1, '408', 3, 4, 160.00, 2, 'disponible', 'Habitación Matrimonial en piso 4.', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(42, 1, '409', 3, 4, 160.00, 2, 'disponible', 'Habitación Matrimonial en piso 4.', '2026-06-09 21:13:00', '2026-06-09 21:13:00');

-- Volcando estructura para tabla saas_hospedaje.huespedes
CREATE TABLE IF NOT EXISTS `huespedes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `nombres` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidos` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documento_tipo` enum('DNI','CE','Pasaporte','RUC') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DNI',
  `documento_numero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nacionalidad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Peru',
  `direccion` text COLLATE utf8mb4_unicode_ci,
  `fecha_nacimiento` date DEFAULT NULL,
  `notas` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `huespedes_empresa_id_index` (`empresa_id`),
  KEY `huespedes_documento_numero_index` (`documento_numero`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.huespedes: ~35 rows (aproximadamente)
DELETE FROM `huespedes`;
INSERT INTO `huespedes` (`id`, `empresa_id`, `nombres`, `apellidos`, `documento_tipo`, `documento_numero`, `telefono`, `email`, `nacionalidad`, `direccion`, `fecha_nacimiento`, `notas`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Rosa', 'Flores Flores', 'DNI', '62226177', '930166033', 'huesped0@correo.com', 'Peru', 'Av. Siempre Viva 134', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(2, 1, 'Carmen', 'Ramos Díaz', 'DNI', '57691692', '982023830', 'huesped1@correo.com', 'Peru', 'Av. Siempre Viva 272', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(3, 1, 'Rosa', 'Chávez Huamán', 'DNI', '66412402', '920321388', 'huesped2@correo.com', 'Peru', 'Av. Siempre Viva 663', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(4, 1, 'Miguel', 'Sánchez Díaz', 'DNI', '62834320', '973020990', 'huesped3@correo.com', 'Peru', 'Av. Siempre Viva 126', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(5, 1, 'Sofía', 'Sánchez Ramos', 'DNI', '66016947', '976100706', 'huesped4@correo.com', 'Peru', 'Av. Siempre Viva 144', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(6, 1, 'Raúl', 'Díaz Ramos', 'DNI', '42064728', '921194781', 'huesped5@correo.com', 'Peru', 'Av. Siempre Viva 632', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(7, 1, 'Ana', 'Huamán Vargas', 'DNI', '77629184', '961899952', 'huesped6@correo.com', 'Peru', 'Av. Siempre Viva 864', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(8, 1, 'Lucía', 'Castro Ramos', 'DNI', '52368703', '981484266', 'huesped7@correo.com', 'Peru', 'Av. Siempre Viva 318', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(9, 1, 'Luis', 'Chávez Chávez', 'DNI', '76986640', '937114581', 'huesped8@correo.com', 'Peru', 'Av. Siempre Viva 231', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(10, 1, 'Diego', 'Sánchez Huamán', 'DNI', '75244037', '956275226', 'huesped9@correo.com', 'Peru', 'Av. Siempre Viva 601', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(11, 1, 'José', 'Sánchez Castro', 'DNI', '79879471', '917000963', 'huesped10@correo.com', 'Peru', 'Av. Siempre Viva 388', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(12, 1, 'José', 'Torres Sánchez', 'DNI', '68050767', '989863765', 'huesped11@correo.com', 'Peru', 'Av. Siempre Viva 924', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(13, 1, 'Sofía', 'Mamani Flores', 'DNI', '57017326', '955005137', 'huesped12@correo.com', 'Peru', 'Av. Siempre Viva 485', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(14, 1, 'Luis', 'Huamán Chávez', 'DNI', '66968042', '911264598', 'huesped13@correo.com', 'Peru', 'Av. Siempre Viva 254', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(15, 1, 'Diego', 'Flores Huamán', 'DNI', '70805549', '983689195', 'huesped14@correo.com', 'Peru', 'Av. Siempre Viva 527', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(16, 1, 'Lucía', 'Rojas Rojas', 'DNI', '64762009', '957991204', 'huesped15@correo.com', 'Peru', 'Av. Siempre Viva 515', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(17, 1, 'Carlos', 'Torres Quispe', 'DNI', '41980496', '946608784', 'huesped16@correo.com', 'Peru', 'Av. Siempre Viva 694', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(18, 1, 'Rosa', 'Torres Chávez', 'DNI', '75174622', '927619707', 'huesped17@correo.com', 'Peru', 'Av. Siempre Viva 575', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(19, 1, 'Carmen', 'Quispe Flores', 'DNI', '59416485', '937986433', 'huesped18@correo.com', 'Peru', 'Av. Siempre Viva 250', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(20, 1, 'María', 'Chávez Mamani', 'DNI', '58740647', '918071153', 'huesped19@correo.com', 'Peru', 'Av. Siempre Viva 655', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(21, 1, 'Sofía', 'Chávez Vargas', 'DNI', '60469987', '992722578', 'huesped20@correo.com', 'Peru', 'Av. Siempre Viva 690', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(22, 1, 'Sofía', 'Vargas Rojas', 'DNI', '59531231', '999903287', 'huesped21@correo.com', 'Peru', 'Av. Siempre Viva 354', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(23, 1, 'Carlos', 'Rojas Díaz', 'DNI', '66654380', '951345751', 'huesped22@correo.com', 'Peru', 'Av. Siempre Viva 228', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(24, 1, 'Diego', 'Chávez Huamán', 'DNI', '55627188', '952151447', 'huesped23@correo.com', 'Peru', 'Av. Siempre Viva 490', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(25, 1, 'Lucía', 'Torres Díaz', 'DNI', '47669345', '941621729', 'huesped24@correo.com', 'Peru', 'Av. Siempre Viva 505', NULL, NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(66, 1, 'Carmen', 'Chávez Quispe', 'DNI', '53398430', '983111245', 'demo.0@correo.com', 'Peru', 'Av. Siempre Viva 248', NULL, NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(67, 1, 'Lucía', 'Huamán Mamani', 'DNI', '61826001', '939479652', 'demo.1@correo.com', 'Peru', 'Av. Siempre Viva 434', NULL, NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(68, 1, 'Miguel', 'Flores Torres', 'DNI', '69223361', '918534459', 'demo.2@correo.com', 'Peru', 'Av. Siempre Viva 698', NULL, NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(69, 1, 'Lucía', 'Díaz Díaz', 'DNI', '64453224', '969483288', 'demo.3@correo.com', 'Peru', 'Av. Siempre Viva 116', NULL, NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(70, 1, 'Carlos', 'Chávez Torres', 'DNI', '58555407', '993099970', 'demo.4@correo.com', 'Peru', 'Av. Siempre Viva 875', NULL, NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(71, 1, 'Luis', 'Vargas Díaz', 'DNI', '77092893', '934341980', 'demo.5@correo.com', 'Peru', 'Av. Siempre Viva 483', NULL, NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(72, 1, 'Ana', 'Mamani Huamán', 'DNI', '54215934', '919050712', 'demo.6@correo.com', 'Peru', 'Av. Siempre Viva 919', NULL, NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(73, 1, 'Carlos', 'Flores Ramos', 'DNI', '70230425', '990060876', 'demo.7@correo.com', 'Peru', 'Av. Siempre Viva 691', NULL, NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(74, 1, 'Luis', 'Quispe Díaz', 'DNI', '44620707', '984023640', 'demo.8@correo.com', 'Peru', 'Av. Siempre Viva 655', NULL, NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(75, 1, 'José', 'Castro Torres', 'DNI', '67738001', '927026942', 'demo.9@correo.com', 'Peru', 'Av. Siempre Viva 780', NULL, NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06');

-- Volcando estructura para tabla saas_hospedaje.ia_configs
CREATE TABLE IF NOT EXISTS `ia_configs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned NOT NULL,
  `proveedor` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'gemini',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clave` text COLLATE utf8mb4_unicode_ci,
  `resumen` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ia_configs_empresa_id_unique` (`empresa_id`),
  CONSTRAINT `ia_configs_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.ia_configs: ~1 rows (aproximadamente)
DELETE FROM `ia_configs`;
INSERT INTO `ia_configs` (`id`, `empresa_id`, `proveedor`, `url`, `modelo`, `clave`, `resumen`, `created_at`, `updated_at`) VALUES
	(1, 1, 'gemini', 'https://generativelanguage.googleapis.com/v1beta/openai', 'gemini-3.5-flash-lite', 'eyJpdiI6IlExRVZDbzJzZUwrZWhDK1hMVDZVWWc9PSIsInZhbHVlIjoiM1VSOW4zandIZ1Z0eU96V1FEc2tQR1BjdEp2bkhycXVLK00yc3JTdUFWV1A3aW5MTEFJZXdIK0RjWCtHL2tpTDRsMWdRTFU1OUYyN3FGU1prblJEVHc9PSIsIm1hYyI6ImFlMGY4ZTM0OTk2Nzg4MmY5YWM1NDFkODQyZWYwMWU4Zjg3MmI4N2U3ZDljMTRhMWQyOWM5YmY2ODNmNmRiZTQiLCJ0YWciOiIifQ==', 1, '2026-10-01 16:58:07', '2026-10-01 16:58:18');

-- Volcando estructura para tabla saas_hospedaje.ia_consultas
CREATE TABLE IF NOT EXISTS `ia_consultas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `pregunta` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titulo` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sql_texto` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `grafico` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favorito` tinyint(1) NOT NULL DEFAULT '0',
  `veces` int unsigned NOT NULL DEFAULT '1',
  `ultimo_uso` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ia_consultas_user_id_foreign` (`user_id`),
  KEY `ia_consultas_empresa_id_user_id_favorito_index` (`empresa_id`,`user_id`,`favorito`),
  CONSTRAINT `ia_consultas_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ia_consultas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.ia_consultas: ~0 rows (aproximadamente)
DELETE FROM `ia_consultas`;
INSERT INTO `ia_consultas` (`id`, `empresa_id`, `user_id`, `pregunta`, `titulo`, `sql_texto`, `grafico`, `favorito`, `veces`, `ultimo_uso`, `created_at`, `updated_at`) VALUES
	(1, 1, 3, 'las reservaciones', 'Listado de Reservas Activas', 'SELECT reserva_id, codigo, fecha_checkin, fecha_checkout, noches, personas, huesped, nacionalidad, habitacion, tipo_habitacion, total_cuenta, estado, creada_en FROM v_ia_reservas WHERE estado <> \'cancelada\' ORDER BY creada_en DESC LIMIT 50', '{"tipo":"none","x":"","y":""}', 0, 1, '2026-10-01 11:58:42', '2026-10-01 16:58:42', '2026-10-01 16:58:42');

-- Volcando estructura para tabla saas_hospedaje.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.migrations: ~20 rows (aproximadamente)
DELETE FROM `migrations`;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_planes_table', 1),
	(3, '0001_01_01_000002_create_empresas_table', 1),
	(4, '2026_01_01_000100_create_tipo_habitaciones_table', 1),
	(5, '2026_01_01_000200_create_habitaciones_table', 1),
	(6, '2026_01_01_000300_create_huespedes_table', 1),
	(7, '2026_01_01_000400_create_reservas_table', 1),
	(8, '2026_01_01_000500_create_facturas_table', 1),
	(9, '2026_01_01_000600_create_configuracions_table', 1),
	(10, '2026_01_01_000700_create_tarifa_temporadas_table', 1),
	(11, '2026_01_01_000800_create_caja_sesiones_table', 1),
	(12, '2026_01_01_000900_create_pagos_table', 1),
	(13, '2026_01_01_001000_create_productos_table', 1),
	(14, '2026_01_01_001100_create_consumos_table', 1),
	(15, '2026_01_01_001200_create_permiso_rol_table', 1),
	(16, '2026_01_01_001300_add_suscripcion_to_empresas', 1),
	(17, '2026_01_01_001400_create_suscripcion_pagos_table', 1),
	(18, '2026_02_01_000100_create_facturacion_configs_table', 2),
	(19, '2026_02_01_000200_add_sunat_fields_to_facturas_table', 2),
	(20, '2026_02_01_000300_create_facturacion_resumenes_table', 3),
	(21, '2026_10_01_000100_create_ia_tables', 4);

-- Volcando estructura para tabla saas_hospedaje.pagos
CREATE TABLE IF NOT EXISTS `pagos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `factura_id` bigint unsigned NOT NULL,
  `reserva_id` bigint unsigned DEFAULT NULL,
  `caja_sesion_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` enum('efectivo','tarjeta','yape','transferencia') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'efectivo',
  `fecha` date NOT NULL,
  `nota` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pagos_factura_id_foreign` (`factura_id`),
  KEY `pagos_user_id_foreign` (`user_id`),
  KEY `pagos_empresa_id_index` (`empresa_id`),
  KEY `pagos_reserva_id_index` (`reserva_id`),
  KEY `pagos_caja_sesion_id_index` (`caja_sesion_id`),
  CONSTRAINT `pagos_factura_id_foreign` FOREIGN KEY (`factura_id`) REFERENCES `facturas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pagos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=495 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.pagos: ~158 rows (aproximadamente)
DELETE FROM `pagos`;
INSERT INTO `pagos` (`id`, `empresa_id`, `factura_id`, `reserva_id`, `caja_sesion_id`, `user_id`, `monto`, `metodo_pago`, `fecha`, `nota`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 1, NULL, 3, 160.00, 'yape', '2026-01-10', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(2, 1, 2, 2, NULL, 3, 270.00, 'transferencia', '2026-01-06', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(3, 1, 5, 5, NULL, 3, 140.00, 'transferencia', '2026-01-28', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(4, 1, 6, 6, NULL, 3, 1050.00, 'transferencia', '2026-01-31', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(5, 1, 7, 7, NULL, 3, 90.00, 'efectivo', '2026-01-04', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(6, 1, 8, 8, NULL, 3, 1750.00, 'transferencia', '2026-01-31', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(7, 1, 9, 9, NULL, 3, 350.00, 'tarjeta', '2026-01-11', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(8, 1, 10, 10, NULL, 3, 480.00, 'tarjeta', '2026-01-13', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(9, 1, 13, 13, NULL, 3, 800.00, 'yape', '2026-01-10', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(10, 1, 14, 14, NULL, 3, 270.00, 'tarjeta', '2026-01-10', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(11, 1, 16, 16, NULL, 3, 280.00, 'yape', '2026-02-15', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(12, 1, 17, 17, NULL, 3, 840.00, 'efectivo', '2026-02-08', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(13, 1, 18, 18, NULL, 3, 560.00, 'efectivo', '2026-02-07', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(14, 1, 19, 19, NULL, 3, 420.00, 'efectivo', '2026-02-07', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(15, 1, 20, 20, NULL, 3, 280.00, 'transferencia', '2026-02-19', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(16, 1, 23, 23, NULL, 3, 1400.00, 'efectivo', '2026-02-09', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(17, 1, 26, 26, NULL, 3, 700.00, 'tarjeta', '2026-02-26', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(18, 1, 27, 27, NULL, 3, 270.00, 'tarjeta', '2026-02-28', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(19, 1, 28, 28, NULL, 3, 320.00, 'transferencia', '2026-02-13', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(20, 1, 29, 29, NULL, 3, 1400.00, 'transferencia', '2026-02-18', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(21, 1, 30, 30, NULL, 3, 90.00, 'tarjeta', '2026-02-10', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(22, 1, 31, 31, NULL, 3, 1750.00, 'transferencia', '2026-02-15', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(23, 1, 32, 32, NULL, 3, 800.00, 'transferencia', '2026-03-06', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(24, 1, 33, 33, NULL, 3, 420.00, 'tarjeta', '2026-03-10', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(25, 1, 35, 35, NULL, 3, 840.00, 'transferencia', '2026-03-31', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(26, 1, 37, 37, NULL, 3, 180.00, 'tarjeta', '2026-03-19', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(27, 1, 38, 38, NULL, 3, 1750.00, 'yape', '2026-03-12', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(28, 1, 42, 42, NULL, 3, 700.00, 'efectivo', '2026-03-05', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(29, 1, 43, 43, NULL, 3, 1750.00, 'yape', '2026-03-17', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(30, 1, 44, 44, NULL, 3, 320.00, 'yape', '2026-03-25', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(31, 1, 45, 45, NULL, 3, 160.00, 'efectivo', '2026-03-23', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(32, 1, 46, 46, NULL, 3, 90.00, 'yape', '2026-03-20', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(33, 1, 48, 48, NULL, 3, 180.00, 'yape', '2026-03-24', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(34, 1, 49, 49, NULL, 3, 840.00, 'tarjeta', '2026-03-23', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(35, 1, 50, 50, NULL, 3, 1400.00, 'transferencia', '2026-03-08', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(36, 1, 51, 51, NULL, 3, 700.00, 'yape', '2026-03-07', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(37, 1, 53, 53, NULL, 3, 350.00, 'yape', '2026-04-06', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(38, 1, 55, 55, NULL, 3, 360.00, 'transferencia', '2026-04-16', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(39, 1, 56, 56, NULL, 3, 270.00, 'yape', '2026-04-29', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(40, 1, 57, 57, NULL, 3, 840.00, 'yape', '2026-04-20', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(41, 1, 58, 58, NULL, 3, 280.00, 'efectivo', '2026-04-26', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(42, 1, 59, 59, NULL, 3, 480.00, 'efectivo', '2026-04-30', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(43, 1, 60, 60, NULL, 3, 640.00, 'tarjeta', '2026-04-08', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(44, 1, 61, 61, NULL, 3, 700.00, 'efectivo', '2026-04-03', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(45, 1, 62, 62, NULL, 3, 1400.00, 'transferencia', '2026-04-28', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(46, 1, 63, 63, NULL, 3, 360.00, 'efectivo', '2026-04-08', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(47, 1, 64, 64, NULL, 3, 700.00, 'yape', '2026-04-13', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(48, 1, 65, 65, NULL, 3, 180.00, 'efectivo', '2026-04-22', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(49, 1, 66, 66, NULL, 3, 280.00, 'yape', '2026-04-19', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(50, 1, 67, 67, NULL, 3, 450.00, 'transferencia', '2026-04-08', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(51, 1, 68, 68, NULL, 3, 270.00, 'transferencia', '2026-04-29', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(52, 1, 69, 69, NULL, 3, 180.00, 'transferencia', '2026-04-09', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(53, 1, 71, 71, NULL, 3, 700.00, 'yape', '2026-05-19', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(54, 1, 72, 72, NULL, 3, 90.00, 'yape', '2026-05-25', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(55, 1, 73, 73, NULL, 3, 480.00, 'transferencia', '2026-05-11', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(56, 1, 74, 74, NULL, 3, 350.00, 'yape', '2026-05-19', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(57, 1, 76, 76, NULL, 3, 560.00, 'tarjeta', '2026-05-09', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(58, 1, 77, 77, NULL, 3, 1050.00, 'tarjeta', '2026-05-04', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(59, 1, 81, 81, NULL, 3, 630.00, 'transferencia', '2026-05-16', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(60, 1, 83, 83, NULL, 3, 90.00, 'yape', '2026-05-28', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(61, 1, 84, 84, NULL, 3, 700.00, 'tarjeta', '2026-05-23', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(62, 1, 85, 85, NULL, 3, 420.00, 'tarjeta', '2026-05-20', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(63, 1, 86, 86, NULL, 3, 140.00, 'transferencia', '2026-05-18', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(64, 1, 87, 87, NULL, 3, 1050.00, 'yape', '2026-05-13', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(65, 1, 90, 90, NULL, 3, 480.00, 'yape', '2026-06-26', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(66, 1, 91, 91, NULL, 3, 210.00, 'transferencia', '2026-06-13', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(67, 1, 95, 95, NULL, 3, 320.00, 'yape', '2026-06-07', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(68, 1, 96, 96, NULL, 3, 800.00, 'yape', '2026-06-23', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(69, 1, 98, 98, NULL, 3, 160.00, 'tarjeta', '2026-06-27', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(70, 1, 102, 102, NULL, 3, 350.00, 'efectivo', '2026-06-10', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(407, 1, 506, 506, NULL, 3, 440.00, 'efectivo', '2026-09-03', 'DEMO', '2026-09-07 13:10:09', '2026-09-07 13:10:09'),
	(408, 1, 507, 507, NULL, 3, 825.00, 'transferencia', '2026-09-04', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(409, 1, 508, 508, NULL, 3, 180.00, 'yape', '2026-09-03', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(410, 1, 509, 509, NULL, 3, 360.00, 'transferencia', '2026-09-06', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(411, 1, 511, 511, NULL, 3, 360.00, 'transferencia', '2026-09-06', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(412, 1, 512, 512, NULL, 3, 1539.00, 'tarjeta', '2026-09-06', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(413, 1, 513, 513, NULL, 3, 270.00, 'tarjeta', '2026-09-05', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(414, 1, 516, 516, NULL, 3, 480.00, 'yape', '2026-09-06', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(415, 1, 518, 518, NULL, 3, 296.00, 'yape', '2026-09-05', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(416, 1, 519, 519, NULL, 3, 781.00, 'efectivo', '2026-09-08', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(417, 1, 521, 521, NULL, 3, 270.00, 'transferencia', '2026-09-07', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(418, 1, 522, 522, NULL, 3, 420.00, 'transferencia', '2026-09-08', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(419, 1, 523, 523, NULL, 3, 840.00, 'tarjeta', '2026-09-09', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(420, 1, 524, 524, NULL, 3, 192.00, 'efectivo', '2026-09-06', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(421, 1, 525, 525, NULL, 3, 1400.00, 'transferencia', '2026-09-10', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(422, 1, 526, 526, NULL, 3, 306.00, 'yape', '2026-09-07', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(423, 1, 527, 527, NULL, 3, 420.00, 'transferencia', '2026-09-08', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(424, 1, 528, 528, NULL, 3, 282.00, 'transferencia', '2026-09-08', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(425, 1, 530, 530, NULL, 3, 278.00, 'efectivo', '2026-09-09', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(426, 1, 531, 531, NULL, 3, 420.00, 'yape', '2026-09-09', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(427, 1, 534, 534, NULL, 3, 554.00, 'efectivo', '2026-09-15', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(428, 1, 535, 535, NULL, 3, 640.00, 'tarjeta', '2026-09-19', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(429, 1, 536, 536, NULL, 3, 375.00, 'tarjeta', '2026-09-18', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(430, 1, 537, 537, NULL, 3, 320.00, 'tarjeta', '2026-09-22', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(431, 1, 539, 539, NULL, 3, 1556.00, 'transferencia', '2026-09-29', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(432, 1, 542, 542, NULL, 3, 305.00, 'transferencia', '2026-09-08', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(433, 1, 543, 543, NULL, 3, 420.00, 'efectivo', '2026-09-10', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(434, 1, 544, 544, NULL, 3, 1050.00, 'yape', '2026-09-10', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(435, 1, 545, 545, NULL, 3, 255.00, 'tarjeta', '2026-09-04', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(436, 1, 546, 546, NULL, 3, 100.00, 'yape', '2026-09-05', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(437, 1, 547, 547, NULL, 3, 435.00, 'efectivo', '2026-09-05', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(438, 1, 548, 548, NULL, 3, 395.00, 'tarjeta', '2026-04-12', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(439, 1, 549, 549, NULL, 3, 640.00, 'yape', '2026-05-01', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(440, 1, 550, 550, NULL, 3, 1829.00, 'yape', '2026-04-16', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(441, 1, 551, 551, NULL, 3, 450.00, 'transferencia', '2026-04-09', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(442, 1, 552, 552, NULL, 3, 1008.00, 'tarjeta', '2026-04-09', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(443, 1, 553, 553, NULL, 3, 840.00, 'transferencia', '2026-04-16', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(444, 1, 554, 554, NULL, 3, 957.00, 'transferencia', '2026-04-10', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(445, 1, 555, 555, NULL, 3, 1055.00, 'efectivo', '2026-04-12', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(446, 1, 556, 556, NULL, 3, 445.00, 'yape', '2026-04-14', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(447, 1, 557, 557, NULL, 3, 620.00, 'yape', '2026-05-15', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(448, 1, 558, 558, NULL, 3, 320.00, 'efectivo', '2026-05-08', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(449, 1, 559, 559, NULL, 3, 445.00, 'yape', '2026-05-14', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(450, 1, 560, 560, NULL, 3, 1795.00, 'tarjeta', '2026-05-12', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(451, 1, 561, 561, NULL, 3, 520.00, 'tarjeta', '2026-05-29', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(452, 1, 562, 562, NULL, 3, 250.00, 'transferencia', '2026-05-23', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(453, 1, 563, 563, NULL, 3, 360.00, 'transferencia', '2026-05-19', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(454, 1, 564, 564, NULL, 3, 165.00, 'transferencia', '2026-05-07', 'DEMO', '2026-09-07 13:10:10', '2026-09-07 13:10:10'),
	(455, 1, 565, 565, NULL, 3, 1099.00, 'efectivo', '2026-05-09', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(456, 1, 566, 566, NULL, 3, 664.00, 'transferencia', '2026-05-27', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(457, 1, 567, 567, NULL, 3, 360.00, 'efectivo', '2026-05-30', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(458, 1, 568, 568, NULL, 3, 690.00, 'tarjeta', '2026-06-17', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(459, 1, 569, 569, NULL, 3, 1080.00, 'yape', '2026-06-22', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(460, 1, 570, 570, NULL, 3, 155.00, 'tarjeta', '2026-06-18', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(461, 1, 571, 571, NULL, 3, 250.00, 'tarjeta', '2026-06-08', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(462, 1, 572, 572, NULL, 3, 770.00, 'tarjeta', '2026-06-10', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(463, 1, 573, 573, NULL, 3, 1505.00, 'efectivo', '2026-06-05', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(464, 1, 574, 574, NULL, 3, 568.00, 'yape', '2026-06-20', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(465, 1, 575, 575, NULL, 3, 655.00, 'tarjeta', '2026-06-07', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(466, 1, 576, 576, NULL, 3, 760.00, 'efectivo', '2026-06-24', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(467, 1, 577, 577, NULL, 3, 427.00, 'tarjeta', '2026-06-05', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(468, 1, 578, 578, NULL, 3, 480.00, 'yape', '2026-07-21', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(469, 1, 579, 579, NULL, 3, 300.00, 'efectivo', '2026-07-07', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(470, 1, 580, 580, NULL, 3, 270.00, 'efectivo', '2026-07-19', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(471, 1, 581, 581, NULL, 3, 450.00, 'yape', '2026-07-19', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(472, 1, 582, 582, NULL, 3, 640.00, 'transferencia', '2026-07-31', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(473, 1, 583, 583, NULL, 3, 245.00, 'yape', '2026-07-11', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(474, 1, 584, 584, NULL, 3, 420.00, 'efectivo', '2026-07-17', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(475, 1, 585, 585, NULL, 3, 270.00, 'transferencia', '2026-07-27', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(476, 1, 586, 586, NULL, 3, 160.00, 'yape', '2026-07-08', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(477, 1, 587, 587, NULL, 3, 486.00, 'tarjeta', '2026-07-15', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(478, 1, 588, 588, NULL, 3, 700.00, 'tarjeta', '2026-07-16', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(479, 1, 589, 589, NULL, 3, 420.00, 'efectivo', '2026-07-18', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(480, 1, 590, 590, NULL, 3, 1050.00, 'efectivo', '2026-07-14', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(481, 1, 591, 591, NULL, 3, 808.00, 'yape', '2026-07-25', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(482, 1, 592, 592, NULL, 3, 700.00, 'transferencia', '2026-08-08', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(483, 1, 593, 593, NULL, 3, 160.00, 'tarjeta', '2026-08-27', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(484, 1, 594, 594, NULL, 3, 1050.00, 'tarjeta', '2026-08-22', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(485, 1, 595, 595, NULL, 3, 1781.00, 'efectivo', '2026-08-05', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(486, 1, 596, 596, NULL, 3, 572.00, 'efectivo', '2026-08-08', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(487, 1, 597, 597, NULL, 3, 320.00, 'tarjeta', '2026-08-29', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(488, 1, 598, 598, NULL, 3, 325.00, 'tarjeta', '2026-08-12', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(489, 1, 599, 599, NULL, 3, 513.00, 'yape', '2026-08-29', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(490, 1, 600, 600, NULL, 3, 1320.00, 'transferencia', '2026-08-18', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(491, 1, 601, 601, NULL, 3, 1125.00, 'yape', '2026-08-19', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(492, 1, 602, 602, NULL, 3, 360.00, 'tarjeta', '2026-08-25', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(493, 1, 603, 603, NULL, 3, 565.00, 'transferencia', '2026-08-12', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(494, 1, 604, 604, NULL, 3, 510.00, 'tarjeta', '2026-08-20', 'DEMO', '2026-09-07 13:10:11', '2026-09-07 13:10:11');

-- Volcando estructura para tabla saas_hospedaje.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.password_reset_tokens: ~0 rows (aproximadamente)
DELETE FROM `password_reset_tokens`;

-- Volcando estructura para tabla saas_hospedaje.permiso_rol
CREATE TABLE IF NOT EXISTS `permiso_rol` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `rol` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permiso` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permiso_rol_empresa_id_rol_permiso_unique` (`empresa_id`,`rol`,`permiso`),
  KEY `permiso_rol_empresa_id_index` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.permiso_rol: ~11 rows (aproximadamente)
DELETE FROM `permiso_rol`;
INSERT INTO `permiso_rol` (`id`, `empresa_id`, `rol`, `permiso`, `created_at`, `updated_at`) VALUES
	(1, 2, 'recepcionista', 'calendario.ver', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(2, 2, 'recepcionista', 'reservas.gestionar', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(3, 2, 'recepcionista', 'huespedes.gestionar', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(4, 2, 'recepcionista', 'facturacion.ver', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(5, 2, 'recepcionista', 'caja.gestionar', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(6, 2, 'recepcionista', 'housekeeping.gestionar', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(7, 2, 'recepcionista', 'habitaciones.gestionar', '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(8, 2, 'recepcionista', 'productos.gestionar', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(9, 2, 'recepcionista', 'reportes.ver', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(10, 2, 'housekeeping', 'calendario.ver', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(11, 2, 'housekeeping', 'housekeeping.gestionar', '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(12, 1, 'recepcionista', 'calendario.ver', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(13, 1, 'recepcionista', 'reservas.gestionar', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(14, 1, 'recepcionista', 'huespedes.gestionar', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(15, 1, 'recepcionista', 'facturacion.ver', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(16, 1, 'recepcionista', 'caja.gestionar', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(17, 1, 'recepcionista', 'housekeeping.gestionar', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(18, 1, 'recepcionista', 'habitaciones.gestionar', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(19, 1, 'recepcionista', 'productos.gestionar', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(20, 1, 'recepcionista', 'reportes.ver', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(21, 1, 'housekeeping', 'calendario.ver', '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(22, 1, 'housekeeping', 'housekeeping.gestionar', '2026-06-09 21:13:02', '2026-06-09 21:13:02');

-- Volcando estructura para tabla saas_hospedaje.planes
CREATE TABLE IF NOT EXISTS `planes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio_mensual` decimal(10,2) NOT NULL DEFAULT '0.00',
  `max_habitaciones` int unsigned DEFAULT NULL,
  `max_usuarios` int unsigned DEFAULT NULL,
  `permite_reportes` tinyint(1) NOT NULL DEFAULT '1',
  `permite_temporadas` tinyint(1) NOT NULL DEFAULT '1',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `planes_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.planes: ~2 rows (aproximadamente)
DELETE FROM `planes`;
INSERT INTO `planes` (`id`, `nombre`, `slug`, `precio_mensual`, `max_habitaciones`, `max_usuarios`, `permite_reportes`, `permite_temporadas`, `descripcion`, `activo`, `created_at`, `updated_at`) VALUES
	(1, 'Free', 'free', 0.00, 10, 2, 1, 0, 'Ideal para empezar.', 1, '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(2, 'Pro', 'pro', 99.00, 60, 10, 1, 1, 'Para hoteles en crecimiento.', 1, '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(3, 'Empresarial', 'empresarial', 249.00, NULL, NULL, 1, 1, 'Sin límites para cadenas.', 1, '2026-06-09 21:12:59', '2026-06-09 21:12:59');

-- Volcando estructura para tabla saas_hospedaje.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` enum('minibar','restaurante','lavanderia','servicios','otros') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'otros',
  `precio` decimal(10,2) NOT NULL DEFAULT '0.00',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productos_empresa_id_index` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.productos: ~18 rows (aproximadamente)
DELETE FROM `productos`;
INSERT INTO `productos` (`id`, `empresa_id`, `nombre`, `categoria`, `precio`, `descripcion`, `activo`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Agua mineral 600ml', 'minibar', 5.00, NULL, 1, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(2, 1, 'Gaseosa lata', 'minibar', 6.00, NULL, 1, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(3, 1, 'Cerveza', 'minibar', 10.00, NULL, 1, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(4, 1, 'Snack / galletas', 'minibar', 7.00, NULL, 1, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(5, 1, 'Desayuno buffet', 'restaurante', 25.00, NULL, 1, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(6, 1, 'Almuerzo ejecutivo', 'restaurante', 35.00, NULL, 1, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(7, 1, 'Lavandería (kg)', 'lavanderia', 15.00, NULL, 1, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(8, 1, 'Late check-out', 'servicios', 40.00, NULL, 1, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(49, 1, 'Botella de vino', 'minibar', 45.00, 'DEMO', 1, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(50, 1, 'Jugo natural', 'minibar', 8.00, 'DEMO', 1, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(51, 1, 'Café premium', 'restaurante', 12.00, 'DEMO', 1, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(52, 1, 'Cena romántica', 'restaurante', 90.00, 'DEMO', 1, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(53, 1, 'Traslado aeropuerto', 'servicios', 60.00, 'DEMO', 1, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(54, 1, 'Spa / masaje', 'servicios', 120.00, 'DEMO', 1, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(55, 1, 'Planchado (unidad)', 'lavanderia', 8.00, 'DEMO', 1, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(56, 1, 'Tabla de quesos', 'restaurante', 55.00, 'DEMO', 1, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(57, 1, 'Estacionamiento/día', 'servicios', 20.00, 'DEMO', 1, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(58, 1, 'Kit de aseo', 'otros', 15.00, 'DEMO', 1, '2026-09-07 13:10:06', '2026-09-07 13:10:06');

-- Volcando estructura para tabla saas_hospedaje.reservas
CREATE TABLE IF NOT EXISTS `reservas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `huesped_id` bigint unsigned NOT NULL,
  `habitacion_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `fecha_checkin` date NOT NULL,
  `fecha_checkout` date NOT NULL,
  `noches` smallint unsigned NOT NULL DEFAULT '1',
  `adultos` tinyint unsigned NOT NULL DEFAULT '1',
  `ninos` tinyint unsigned NOT NULL DEFAULT '0',
  `tarifa_noche` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `estado` enum('pendiente','confirmada','checkin','checkout','cancelada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `notas` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reservas_codigo_unique` (`codigo`),
  KEY `reservas_huesped_id_foreign` (`huesped_id`),
  KEY `reservas_habitacion_id_foreign` (`habitacion_id`),
  KEY `reservas_user_id_foreign` (`user_id`),
  KEY `reservas_empresa_id_index` (`empresa_id`),
  CONSTRAINT `reservas_habitacion_id_foreign` FOREIGN KEY (`habitacion_id`) REFERENCES `habitaciones` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `reservas_huesped_id_foreign` FOREIGN KEY (`huesped_id`) REFERENCES `huespedes` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `reservas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=605 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.reservas: ~201 rows (aproximadamente)
DELETE FROM `reservas`;
INSERT INTO `reservas` (`id`, `empresa_id`, `codigo`, `huesped_id`, `habitacion_id`, `user_id`, `fecha_checkin`, `fecha_checkout`, `noches`, `adultos`, `ninos`, `tarifa_noche`, `total`, `estado`, `notas`, `created_at`, `updated_at`) VALUES
	(1, 1, 'RSV-00001', 14, 9, 3, '2026-01-09', '2026-01-10', 1, 1, 0, 160.00, 160.00, 'checkout', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(2, 1, 'RSV-00002', 12, 31, 3, '2026-01-03', '2026-01-06', 3, 1, 1, 90.00, 270.00, 'checkout', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(3, 1, 'RSV-00003', 20, 33, 3, '2026-01-03', '2026-01-05', 2, 2, 0, 350.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(4, 1, 'RSV-00004', 14, 40, 3, '2026-01-06', '2026-01-07', 1, 2, 1, 160.00, 160.00, 'checkout', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(5, 1, 'RSV-00005', 24, 27, 3, '2026-01-27', '2026-01-28', 1, 1, 0, 140.00, 140.00, 'checkout', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(6, 1, 'RSV-00006', 9, 14, 3, '2026-01-26', '2026-01-31', 5, 1, 0, 210.00, 1050.00, 'checkout', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(7, 1, 'RSV-00007', 4, 21, 3, '2026-01-03', '2026-01-04', 1, 2, 1, 90.00, 90.00, 'checkout', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(8, 1, 'RSV-00008', 18, 3, 3, '2026-01-26', '2026-01-31', 5, 2, 1, 350.00, 1750.00, 'checkout', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(9, 1, 'RSV-00009', 14, 24, 3, '2026-01-10', '2026-01-11', 1, 2, 0, 350.00, 350.00, 'checkout', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(10, 1, 'RSV-00010', 1, 37, 3, '2026-01-10', '2026-01-13', 3, 1, 0, 160.00, 480.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(11, 1, 'RSV-00011', 12, 41, 3, '2026-01-10', '2026-01-15', 5, 2, 1, 160.00, 800.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(12, 1, 'RSV-00012', 6, 17, 3, '2026-01-22', '2026-01-24', 2, 2, 0, 350.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(13, 1, 'RSV-00013', 11, 37, 3, '2026-01-05', '2026-01-10', 5, 1, 1, 160.00, 800.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(14, 1, 'RSV-00014', 4, 21, 3, '2026-01-07', '2026-01-10', 3, 1, 1, 90.00, 270.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(15, 1, 'RSV-00015', 10, 30, 3, '2026-02-08', '2026-02-09', 1, 1, 2, 210.00, 210.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(16, 1, 'RSV-00016', 16, 35, 3, '2026-02-13', '2026-02-15', 2, 1, 2, 140.00, 280.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(17, 1, 'RSV-00017', 14, 23, 3, '2026-02-04', '2026-02-08', 4, 1, 2, 210.00, 840.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(18, 1, 'RSV-00018', 12, 38, 3, '2026-02-03', '2026-02-07', 4, 2, 0, 140.00, 560.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(19, 1, 'RSV-00019', 24, 26, 3, '2026-02-05', '2026-02-07', 2, 1, 0, 210.00, 420.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(20, 1, 'RSV-00020', 5, 29, 3, '2026-02-17', '2026-02-19', 2, 1, 1, 140.00, 280.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(21, 1, 'RSV-00021', 6, 15, 3, '2026-02-10', '2026-02-15', 5, 1, 2, 90.00, 450.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(22, 1, 'RSV-00022', 17, 17, 3, '2026-02-18', '2026-02-21', 3, 1, 1, 350.00, 1050.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(23, 1, 'RSV-00023', 6, 10, 3, '2026-02-05', '2026-02-09', 4, 1, 1, 350.00, 1400.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(24, 1, 'RSV-00024', 11, 36, 3, '2026-02-07', '2026-02-09', 2, 2, 2, 160.00, 320.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(25, 1, 'RSV-00025', 5, 8, 3, '2026-02-24', '2026-02-28', 4, 1, 1, 90.00, 360.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(26, 1, 'RSV-00026', 4, 29, 3, '2026-02-21', '2026-02-26', 5, 1, 1, 140.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(27, 1, 'RSV-00027', 15, 21, 3, '2026-02-25', '2026-02-28', 3, 1, 2, 90.00, 270.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(28, 1, 'RSV-00028', 11, 39, 3, '2026-02-11', '2026-02-13', 2, 1, 2, 160.00, 320.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(29, 1, 'RSV-00029', 13, 17, 3, '2026-02-14', '2026-02-18', 4, 1, 1, 350.00, 1400.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(30, 1, 'RSV-00030', 6, 31, 3, '2026-02-09', '2026-02-10', 1, 2, 1, 90.00, 90.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(31, 1, 'RSV-00031', 2, 11, 3, '2026-02-10', '2026-02-15', 5, 2, 1, 350.00, 1750.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(32, 1, 'RSV-00032', 2, 41, 3, '2026-03-01', '2026-03-06', 5, 1, 1, 160.00, 800.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(33, 1, 'RSV-00033', 1, 12, 3, '2026-03-08', '2026-03-10', 2, 1, 2, 210.00, 420.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(34, 1, 'RSV-00034', 10, 23, 3, '2026-03-26', '2026-03-27', 1, 2, 0, 210.00, 210.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(35, 1, 'RSV-00035', 19, 19, 3, '2026-03-27', '2026-03-31', 4, 2, 2, 210.00, 840.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(36, 1, 'RSV-00036', 9, 23, 3, '2026-03-25', '2026-03-30', 5, 2, 0, 210.00, 1050.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(37, 1, 'RSV-00037', 4, 1, 3, '2026-03-17', '2026-03-19', 2, 1, 2, 90.00, 180.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(38, 1, 'RSV-00038', 5, 33, 3, '2026-03-07', '2026-03-12', 5, 2, 2, 350.00, 1750.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(39, 1, 'RSV-00039', 16, 38, 3, '2026-03-01', '2026-03-06', 5, 1, 1, 140.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(40, 1, 'RSV-00040', 15, 18, 3, '2026-03-17', '2026-03-20', 3, 1, 2, 90.00, 270.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(41, 1, 'RSV-00041', 6, 42, 3, '2026-03-19', '2026-03-22', 3, 2, 2, 160.00, 480.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(42, 1, 'RSV-00042', 25, 3, 3, '2026-03-03', '2026-03-05', 2, 1, 2, 350.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(43, 1, 'RSV-00043', 15, 7, 3, '2026-03-12', '2026-03-17', 5, 2, 1, 350.00, 1750.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(44, 1, 'RSV-00044', 3, 28, 3, '2026-03-23', '2026-03-25', 2, 1, 1, 160.00, 320.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(45, 1, 'RSV-00045', 3, 6, 3, '2026-03-22', '2026-03-23', 1, 2, 1, 160.00, 160.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(46, 1, 'RSV-00046', 8, 21, 3, '2026-03-19', '2026-03-20', 1, 2, 1, 90.00, 90.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(47, 1, 'RSV-00047', 9, 42, 3, '2026-03-11', '2026-03-14', 3, 1, 1, 160.00, 480.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(48, 1, 'RSV-00048', 8, 8, 3, '2026-03-22', '2026-03-24', 2, 1, 2, 90.00, 180.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(49, 1, 'RSV-00049', 23, 19, 3, '2026-03-19', '2026-03-23', 4, 1, 1, 210.00, 840.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(50, 1, 'RSV-00050', 21, 24, 3, '2026-03-04', '2026-03-08', 4, 1, 1, 350.00, 1400.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(51, 1, 'RSV-00051', 15, 22, 3, '2026-03-02', '2026-03-07', 5, 1, 1, 140.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(52, 1, 'RSV-00052', 16, 26, 3, '2026-03-10', '2026-03-15', 5, 2, 1, 210.00, 1050.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(53, 1, 'RSV-00053', 10, 3, 3, '2026-04-05', '2026-04-06', 1, 2, 1, 350.00, 350.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(54, 1, 'RSV-00054', 19, 23, 3, '2026-04-15', '2026-04-19', 4, 1, 1, 210.00, 840.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(55, 1, 'RSV-00055', 4, 18, 3, '2026-04-12', '2026-04-16', 4, 2, 0, 90.00, 360.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(56, 1, 'RSV-00056', 21, 21, 3, '2026-04-26', '2026-04-29', 3, 1, 1, 90.00, 270.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(57, 1, 'RSV-00057', 14, 19, 3, '2026-04-16', '2026-04-20', 4, 2, 0, 210.00, 840.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(58, 1, 'RSV-00058', 21, 27, 3, '2026-04-24', '2026-04-26', 2, 2, 1, 140.00, 280.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(59, 1, 'RSV-00059', 22, 42, 3, '2026-04-27', '2026-04-30', 3, 1, 0, 160.00, 480.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(60, 1, 'RSV-00060', 7, 9, 3, '2026-04-04', '2026-04-08', 4, 2, 2, 160.00, 640.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(61, 1, 'RSV-00061', 19, 25, 3, '2026-04-01', '2026-04-03', 2, 2, 1, 350.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(62, 1, 'RSV-00062', 23, 10, 3, '2026-04-24', '2026-04-28', 4, 2, 0, 350.00, 1400.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(63, 1, 'RSV-00063', 11, 21, 3, '2026-04-04', '2026-04-08', 4, 1, 1, 90.00, 360.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(64, 1, 'RSV-00064', 16, 20, 3, '2026-04-11', '2026-04-13', 2, 2, 1, 350.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(65, 1, 'RSV-00065', 15, 8, 3, '2026-04-20', '2026-04-22', 2, 2, 0, 90.00, 180.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(66, 1, 'RSV-00066', 8, 27, 3, '2026-04-17', '2026-04-19', 2, 1, 2, 140.00, 280.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(67, 1, 'RSV-00067', 5, 2, 3, '2026-04-03', '2026-04-08', 5, 1, 2, 90.00, 450.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(68, 1, 'RSV-00068', 8, 2, 3, '2026-04-26', '2026-04-29', 3, 2, 1, 90.00, 270.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(69, 1, 'RSV-00069', 25, 21, 3, '2026-04-07', '2026-04-09', 2, 2, 1, 90.00, 180.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(70, 1, 'RSV-00070', 7, 28, 3, '2026-04-05', '2026-04-07', 2, 2, 1, 160.00, 320.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(71, 1, 'RSV-00071', 18, 25, 3, '2026-05-17', '2026-05-19', 2, 1, 0, 350.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(72, 1, 'RSV-00072', 5, 1, 3, '2026-05-24', '2026-05-25', 1, 1, 1, 90.00, 90.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(73, 1, 'RSV-00073', 9, 40, 3, '2026-05-08', '2026-05-11', 3, 2, 1, 160.00, 480.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(74, 1, 'RSV-00074', 5, 10, 3, '2026-05-18', '2026-05-19', 1, 2, 1, 350.00, 350.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(75, 1, 'RSV-00075', 22, 21, 3, '2026-05-15', '2026-05-16', 1, 1, 1, 90.00, 90.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(76, 1, 'RSV-00076', 1, 38, 3, '2026-05-05', '2026-05-09', 4, 1, 1, 140.00, 560.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(77, 1, 'RSV-00077', 8, 16, 3, '2026-05-01', '2026-05-04', 3, 2, 1, 350.00, 1050.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(78, 1, 'RSV-00078', 17, 21, 3, '2026-05-20', '2026-05-24', 4, 1, 2, 90.00, 360.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(79, 1, 'RSV-00079', 11, 32, 3, '2026-05-18', '2026-05-23', 5, 2, 2, 140.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(80, 1, 'RSV-00080', 15, 29, 3, '2026-05-13', '2026-05-14', 1, 2, 1, 140.00, 140.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(81, 1, 'RSV-00081', 20, 12, 3, '2026-05-13', '2026-05-16', 3, 2, 0, 210.00, 630.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(82, 1, 'RSV-00082', 17, 8, 3, '2026-05-11', '2026-05-12', 1, 2, 1, 90.00, 90.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(83, 1, 'RSV-00083', 16, 1, 3, '2026-05-27', '2026-05-28', 1, 2, 1, 90.00, 90.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(84, 1, 'RSV-00084', 9, 22, 3, '2026-05-18', '2026-05-23', 5, 2, 2, 140.00, 700.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(85, 1, 'RSV-00085', 23, 23, 3, '2026-05-18', '2026-05-20', 2, 1, 0, 210.00, 420.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(86, 1, 'RSV-00086', 1, 27, 3, '2026-05-17', '2026-05-18', 1, 2, 0, 140.00, 140.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(87, 1, 'RSV-00087', 5, 26, 3, '2026-05-08', '2026-05-13', 5, 1, 2, 210.00, 1050.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(88, 1, 'RSV-00088', 24, 24, 3, '2026-06-15', '2026-06-19', 4, 2, 1, 350.00, 1400.00, 'pendiente', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(89, 1, 'RSV-00089', 23, 38, 3, '2026-06-07', '2026-06-08', 1, 2, 0, 140.00, 140.00, 'pendiente', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(90, 1, 'RSV-00090', 13, 36, 3, '2026-06-23', '2026-06-26', 3, 2, 1, 160.00, 480.00, 'confirmada', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(91, 1, 'RSV-00091', 3, 30, 3, '2026-06-12', '2026-06-13', 1, 2, 1, 210.00, 210.00, 'checkin', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(92, 1, 'RSV-00092', 10, 3, 3, '2026-06-17', '2026-06-20', 3, 2, 0, 350.00, 1050.00, 'checkin', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(93, 1, 'RSV-00093', 18, 6, 3, '2026-06-16', '2026-06-18', 2, 2, 0, 160.00, 320.00, 'pendiente', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(94, 1, 'RSV-00094', 10, 24, 3, '2026-06-24', '2026-06-29', 5, 1, 2, 350.00, 1750.00, 'pendiente', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(95, 1, 'RSV-00095', 7, 4, 3, '2026-06-05', '2026-06-07', 2, 2, 1, 160.00, 320.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(96, 1, 'RSV-00096', 22, 34, 3, '2026-06-18', '2026-06-23', 5, 1, 1, 160.00, 800.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(97, 1, 'RSV-00097', 9, 22, 3, '2026-06-16', '2026-06-18', 2, 1, 0, 140.00, 280.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(98, 1, 'RSV-00098', 2, 6, 3, '2026-06-26', '2026-06-27', 1, 2, 2, 160.00, 160.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(99, 1, 'RSV-00099', 17, 9, 3, '2026-06-18', '2026-06-22', 4, 1, 2, 160.00, 640.00, 'pendiente', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(100, 1, 'RSV-00100', 6, 37, 3, '2026-06-15', '2026-06-20', 5, 2, 0, 160.00, 800.00, 'confirmada', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(101, 1, 'RSV-00101', 13, 2, 3, '2026-06-19', '2026-06-23', 4, 2, 0, 90.00, 360.00, 'confirmada', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(102, 1, 'RSV-00102', 7, 25, 3, '2026-06-09', '2026-06-10', 1, 2, 1, 350.00, 350.00, 'checkout', NULL, '2026-06-09 21:13:01', '2026-06-09 21:13:01'),
	(506, 1, 'DEMO-01102', 67, 1, 3, '2026-08-31', '2026-09-03', 3, 1, 0, 90.00, 440.00, 'checkin', NULL, '2026-08-31 05:00:00', '2026-09-07 13:10:09'),
	(507, 1, 'DEMO-01103', 5, 4, 3, '2026-08-31', '2026-09-04', 4, 1, 1, 160.00, 825.00, 'confirmada', NULL, '2026-08-31 05:00:00', '2026-09-07 13:10:10'),
	(508, 1, 'DEMO-01104', 10, 15, 3, '2026-09-01', '2026-09-03', 2, 1, 0, 90.00, 180.00, 'checkout', NULL, '2026-08-30 05:00:00', '2026-09-07 13:10:10'),
	(509, 1, 'DEMO-01105', 74, 21, 3, '2026-09-02', '2026-09-06', 4, 2, 1, 90.00, 360.00, 'checkout', NULL, '2026-08-30 05:00:00', '2026-09-07 13:10:10'),
	(510, 1, 'DEMO-01106', 14, 29, 3, '2026-09-02', '2026-09-05', 3, 2, 1, 140.00, 485.00, 'checkin', NULL, '2026-08-30 05:00:00', '2026-09-07 13:10:10'),
	(511, 1, 'DEMO-01107', 1, 21, 3, '2026-09-02', '2026-09-06', 4, 1, 1, 90.00, 360.00, 'checkout', NULL, '2026-08-31 05:00:00', '2026-09-07 13:10:10'),
	(512, 1, 'DEMO-01108', 7, 33, 3, '2026-09-02', '2026-09-06', 4, 1, 1, 350.00, 1539.00, 'checkin', NULL, '2026-09-02 05:00:00', '2026-09-07 13:10:10'),
	(513, 1, 'DEMO-01109', 23, 5, 3, '2026-09-02', '2026-09-05', 3, 1, 0, 90.00, 270.00, 'checkout', NULL, '2026-09-02 05:00:00', '2026-09-07 13:10:10'),
	(514, 1, 'DEMO-01110', 7, 19, 3, '2026-09-03', '2026-09-06', 3, 1, 0, 210.00, 630.00, 'confirmada', NULL, '2026-09-01 05:00:00', '2026-09-07 13:10:10'),
	(515, 1, 'DEMO-01111', 1, 34, 3, '2026-09-03', '2026-09-05', 2, 1, 1, 160.00, 456.00, 'checkin', NULL, '2026-09-01 05:00:00', '2026-09-07 13:10:10'),
	(516, 1, 'DEMO-01112', 19, 6, 3, '2026-09-03', '2026-09-06', 3, 2, 0, 160.00, 480.00, 'checkin', NULL, '2026-09-03 05:00:00', '2026-09-07 13:10:10'),
	(517, 1, 'DEMO-01113', 12, 28, 3, '2026-09-03', '2026-09-05', 2, 2, 1, 160.00, 320.00, 'checkout', NULL, '2026-09-02 05:00:00', '2026-09-07 13:10:10'),
	(518, 1, 'DEMO-01114', 6, 38, 3, '2026-09-03', '2026-09-05', 2, 2, 0, 140.00, 296.00, 'checkin', NULL, '2026-09-02 05:00:00', '2026-09-07 13:10:10'),
	(519, 1, 'DEMO-01115', 66, 39, 3, '2026-09-04', '2026-09-08', 4, 1, 0, 160.00, 781.00, 'confirmada', NULL, '2026-09-04 05:00:00', '2026-09-07 13:10:10'),
	(520, 1, 'DEMO-01116', 8, 21, 3, '2026-09-03', '2026-09-06', 3, 2, 2, 90.00, 430.00, 'confirmada', NULL, '2026-09-03 05:00:00', '2026-09-07 13:10:10'),
	(521, 1, 'DEMO-01117', 22, 21, 3, '2026-09-04', '2026-09-07', 3, 2, 0, 90.00, 270.00, 'checkin', NULL, '2026-09-03 05:00:00', '2026-09-07 13:10:10'),
	(522, 1, 'DEMO-01118', 1, 32, 3, '2026-09-05', '2026-09-08', 3, 2, 0, 140.00, 420.00, 'checkout', NULL, '2026-09-05 05:00:00', '2026-09-07 13:10:10'),
	(523, 1, 'DEMO-01119', 25, 26, 3, '2026-09-05', '2026-09-09', 4, 2, 1, 210.00, 840.00, 'checkin', NULL, '2026-09-04 05:00:00', '2026-09-07 13:10:10'),
	(524, 1, 'DEMO-01120', 5, 31, 3, '2026-09-04', '2026-09-06', 2, 2, 1, 90.00, 192.00, 'confirmada', NULL, '2026-09-02 05:00:00', '2026-09-07 13:10:10'),
	(525, 1, 'DEMO-01121', 14, 16, 3, '2026-09-06', '2026-09-10', 4, 1, 1, 350.00, 1400.00, 'confirmada', NULL, '2026-09-06 05:00:00', '2026-09-07 13:10:10'),
	(526, 1, 'DEMO-01122', 12, 2, 3, '2026-09-05', '2026-09-07', 2, 1, 2, 90.00, 306.00, 'checkout', NULL, '2026-09-02 05:00:00', '2026-09-07 13:10:10'),
	(527, 1, 'DEMO-01123', 67, 14, 3, '2026-09-06', '2026-09-08', 2, 1, 0, 210.00, 420.00, 'confirmada', NULL, '2026-09-04 05:00:00', '2026-09-07 13:10:10'),
	(528, 1, 'DEMO-01124', 20, 2, 3, '2026-09-06', '2026-09-08', 2, 1, 0, 90.00, 282.00, 'confirmada', NULL, '2026-09-05 05:00:00', '2026-09-07 13:10:10'),
	(529, 1, 'DEMO-01125', 69, 27, 3, '2026-09-07', '2026-09-09', 2, 1, 0, 140.00, 345.00, 'checkin', NULL, '2026-09-05 05:00:00', '2026-09-07 13:10:10'),
	(530, 1, 'DEMO-01126', 71, 21, 3, '2026-09-06', '2026-09-09', 3, 2, 1, 90.00, 278.00, 'checkin', NULL, '2026-09-04 05:00:00', '2026-09-07 13:10:10'),
	(531, 1, 'DEMO-01127', 10, 26, 3, '2026-09-07', '2026-09-09', 2, 1, 0, 210.00, 420.00, 'checkout', NULL, '2026-09-04 05:00:00', '2026-09-07 13:10:10'),
	(532, 1, 'DEMO-01128', 25, 22, 3, '2026-09-21', '2026-09-23', 2, 1, 0, 140.00, 555.00, 'pendiente', NULL, '2026-09-21 05:00:00', '2026-09-07 13:10:10'),
	(533, 1, 'DEMO-01129', 73, 37, 3, '2026-09-09', '2026-09-12', 3, 2, 2, 160.00, 480.00, 'pendiente', NULL, '2026-09-06 05:00:00', '2026-09-07 13:10:10'),
	(534, 1, 'DEMO-01130', 23, 1, 3, '2026-09-12', '2026-09-15', 3, 1, 1, 90.00, 554.00, 'confirmada', NULL, '2026-09-11 05:00:00', '2026-09-07 13:10:10'),
	(535, 1, 'DEMO-01131', 3, 40, 3, '2026-09-15', '2026-09-19', 4, 1, 0, 160.00, 640.00, 'confirmada', NULL, '2026-09-13 05:00:00', '2026-09-07 13:10:10'),
	(536, 1, 'DEMO-01132', 17, 15, 3, '2026-09-15', '2026-09-18', 3, 1, 1, 90.00, 375.00, 'confirmada', NULL, '2026-09-13 05:00:00', '2026-09-07 13:10:10'),
	(537, 1, 'DEMO-01133', 12, 36, 3, '2026-09-20', '2026-09-22', 2, 1, 0, 160.00, 320.00, 'checkin', NULL, '2026-09-17 05:00:00', '2026-09-07 13:10:10'),
	(538, 1, 'DEMO-01134', 17, 15, 3, '2026-09-27', '2026-10-01', 4, 2, 2, 90.00, 372.00, 'checkin', NULL, '2026-09-24 05:00:00', '2026-09-07 13:10:10'),
	(539, 1, 'DEMO-01135', 24, 3, 3, '2026-09-25', '2026-09-29', 4, 2, 0, 350.00, 1556.00, 'checkout', NULL, '2026-09-24 05:00:00', '2026-09-07 13:10:10'),
	(540, 1, 'DEMO-01136', 22, 6, 3, '2026-09-12', '2026-09-16', 4, 2, 1, 160.00, 640.00, 'checkout', NULL, '2026-09-11 05:00:00', '2026-09-07 13:10:10'),
	(541, 1, 'DEMO-01137', 22, 19, 3, '2026-09-19', '2026-09-22', 3, 2, 1, 210.00, 708.00, 'cancelada', NULL, '2026-09-17 05:00:00', '2026-09-07 13:10:10'),
	(542, 1, 'DEMO-01138', 17, 27, 3, '2026-09-07', '2026-09-08', 1, 1, 2, 140.00, 305.00, 'confirmada', NULL, '2026-09-07 05:00:00', '2026-09-07 13:10:10'),
	(543, 1, 'DEMO-01139', 16, 13, 3, '2026-09-07', '2026-09-10', 3, 2, 2, 140.00, 420.00, 'confirmada', NULL, '2026-09-05 05:00:00', '2026-09-07 13:10:10'),
	(544, 1, 'DEMO-01140', 1, 24, 3, '2026-09-07', '2026-09-10', 3, 2, 0, 350.00, 1050.00, 'confirmada', NULL, '2026-09-05 05:00:00', '2026-09-07 13:10:10'),
	(545, 1, 'DEMO-01141', 1, 6, 3, '2026-09-03', '2026-09-07', 1, 1, 1, 160.00, 255.00, 'checkin', NULL, '2026-09-02 05:00:00', '2026-09-07 13:10:10'),
	(546, 1, 'DEMO-01142', 25, 31, 3, '2026-09-04', '2026-09-07', 1, 1, 2, 90.00, 100.00, 'checkin', NULL, '2026-09-01 05:00:00', '2026-09-07 13:10:10'),
	(547, 1, 'DEMO-01143', 68, 33, 3, '2026-09-04', '2026-09-07', 1, 2, 1, 350.00, 435.00, 'checkin', NULL, '2026-09-02 05:00:00', '2026-09-07 13:10:10'),
	(548, 1, 'DEMO-01144', 22, 34, 3, '2026-04-10', '2026-04-12', 2, 1, 2, 160.00, 395.00, 'checkout', NULL, '2026-04-07 05:00:00', '2026-09-07 13:10:10'),
	(549, 1, 'DEMO-01145', 21, 4, 3, '2026-04-27', '2026-05-01', 4, 1, 2, 160.00, 640.00, 'checkout', NULL, '2026-04-27 05:00:00', '2026-09-07 13:10:10'),
	(550, 1, 'DEMO-01146', 73, 20, 3, '2026-04-11', '2026-04-16', 5, 2, 2, 350.00, 1829.00, 'checkout', NULL, '2026-04-11 05:00:00', '2026-09-07 13:10:10'),
	(551, 1, 'DEMO-01147', 16, 18, 3, '2026-04-04', '2026-04-09', 5, 2, 2, 90.00, 450.00, 'checkout', NULL, '2026-04-01 05:00:00', '2026-09-07 13:10:10'),
	(552, 1, 'DEMO-01148', 17, 23, 3, '2026-04-05', '2026-04-09', 4, 2, 2, 210.00, 1008.00, 'checkout', NULL, '2026-04-03 05:00:00', '2026-09-07 13:10:10'),
	(553, 1, 'DEMO-01149', 13, 12, 3, '2026-04-12', '2026-04-16', 4, 2, 2, 210.00, 840.00, 'checkout', NULL, '2026-04-09 05:00:00', '2026-09-07 13:10:10'),
	(554, 1, 'DEMO-01150', 22, 12, 3, '2026-04-06', '2026-04-10', 4, 2, 1, 210.00, 957.00, 'checkout', NULL, '2026-04-06 05:00:00', '2026-09-07 13:10:10'),
	(555, 1, 'DEMO-01151', 22, 24, 3, '2026-04-09', '2026-04-12', 3, 2, 1, 350.00, 1055.00, 'checkout', NULL, '2026-04-08 05:00:00', '2026-09-07 13:10:10'),
	(556, 1, 'DEMO-01152', 69, 13, 3, '2026-04-12', '2026-04-14', 2, 2, 2, 140.00, 445.00, 'checkout', NULL, '2026-04-10 05:00:00', '2026-09-07 13:10:10'),
	(557, 1, 'DEMO-01153', 19, 13, 3, '2026-05-11', '2026-05-15', 4, 1, 1, 140.00, 620.00, 'checkout', NULL, '2026-05-09 05:00:00', '2026-09-07 13:10:10'),
	(558, 1, 'DEMO-01154', 21, 34, 3, '2026-05-06', '2026-05-08', 2, 1, 1, 160.00, 320.00, 'checkout', NULL, '2026-05-03 05:00:00', '2026-09-07 13:10:10'),
	(559, 1, 'DEMO-01155', 10, 35, 3, '2026-05-12', '2026-05-14', 2, 2, 0, 140.00, 445.00, 'checkout', NULL, '2026-05-12 05:00:00', '2026-09-07 13:10:10'),
	(560, 1, 'DEMO-01156', 15, 20, 3, '2026-05-07', '2026-05-12', 5, 1, 2, 350.00, 1795.00, 'checkout', NULL, '2026-05-05 05:00:00', '2026-09-07 13:10:10'),
	(561, 1, 'DEMO-01157', 21, 39, 3, '2026-05-26', '2026-05-29', 3, 2, 0, 160.00, 520.00, 'checkout', NULL, '2026-05-23 05:00:00', '2026-09-07 13:10:10'),
	(562, 1, 'DEMO-01158', 15, 28, 3, '2026-05-22', '2026-05-23', 1, 1, 0, 160.00, 250.00, 'checkout', NULL, '2026-05-21 05:00:00', '2026-09-07 13:10:10'),
	(563, 1, 'DEMO-01159', 71, 31, 3, '2026-05-15', '2026-05-19', 4, 1, 1, 90.00, 360.00, 'checkout', NULL, '2026-05-14 05:00:00', '2026-09-07 13:10:10'),
	(564, 1, 'DEMO-01160', 18, 5, 3, '2026-05-06', '2026-05-07', 1, 1, 0, 90.00, 165.00, 'checkout', NULL, '2026-05-03 05:00:00', '2026-09-07 13:10:10'),
	(565, 1, 'DEMO-01161', 69, 26, 3, '2026-05-04', '2026-05-09', 5, 2, 0, 210.00, 1099.00, 'checkout', NULL, '2026-05-03 05:00:00', '2026-09-07 13:10:11'),
	(566, 1, 'DEMO-01162', 13, 34, 3, '2026-05-23', '2026-05-27', 4, 1, 1, 160.00, 664.00, 'checkout', NULL, '2026-05-23 05:00:00', '2026-09-07 13:10:11'),
	(567, 1, 'DEMO-01163', 68, 5, 3, '2026-05-26', '2026-05-30', 4, 1, 0, 90.00, 360.00, 'checkout', NULL, '2026-05-23 05:00:00', '2026-09-07 13:10:11'),
	(568, 1, 'DEMO-01164', 3, 19, 3, '2026-06-14', '2026-06-17', 3, 1, 1, 210.00, 690.00, 'checkout', NULL, '2026-06-14 05:00:00', '2026-09-07 13:10:11'),
	(569, 1, 'DEMO-01165', 8, 7, 3, '2026-06-19', '2026-06-22', 3, 1, 1, 350.00, 1080.00, 'checkout', NULL, '2026-06-16 05:00:00', '2026-09-07 13:10:11'),
	(570, 1, 'DEMO-01166', 72, 22, 3, '2026-06-17', '2026-06-18', 1, 2, 0, 140.00, 155.00, 'checkout', NULL, '2026-06-14 05:00:00', '2026-09-07 13:10:11'),
	(571, 1, 'DEMO-01167', 3, 36, 3, '2026-06-07', '2026-06-08', 1, 1, 1, 160.00, 250.00, 'checkout', NULL, '2026-06-04 05:00:00', '2026-09-07 13:10:11'),
	(572, 1, 'DEMO-01168', 12, 41, 3, '2026-06-06', '2026-06-10', 4, 2, 2, 160.00, 770.00, 'checkout', NULL, '2026-06-03 05:00:00', '2026-09-07 13:10:11'),
	(573, 1, 'DEMO-01169', 4, 20, 3, '2026-06-01', '2026-06-05', 4, 1, 1, 350.00, 1505.00, 'checkout', NULL, '2026-05-30 05:00:00', '2026-09-07 13:10:11'),
	(574, 1, 'DEMO-01170', 4, 4, 3, '2026-06-17', '2026-06-20', 3, 1, 2, 160.00, 568.00, 'checkout', NULL, '2026-06-17 05:00:00', '2026-09-07 13:10:11'),
	(575, 1, 'DEMO-01171', 25, 39, 3, '2026-06-03', '2026-06-07', 4, 2, 1, 160.00, 655.00, 'checkout', NULL, '2026-06-02 05:00:00', '2026-09-07 13:10:11'),
	(576, 1, 'DEMO-01172', 1, 38, 3, '2026-06-19', '2026-06-24', 5, 1, 0, 140.00, 760.00, 'checkout', NULL, '2026-06-19 05:00:00', '2026-09-07 13:10:11'),
	(577, 1, 'DEMO-01173', 70, 2, 3, '2026-06-01', '2026-06-05', 4, 2, 1, 90.00, 427.00, 'checkout', NULL, '2026-05-30 05:00:00', '2026-09-07 13:10:11'),
	(578, 1, 'DEMO-01174', 13, 4, 3, '2026-07-18', '2026-07-21', 3, 1, 1, 160.00, 480.00, 'checkout', NULL, '2026-07-17 05:00:00', '2026-09-07 13:10:11'),
	(579, 1, 'DEMO-01175', 71, 18, 3, '2026-07-04', '2026-07-07', 3, 1, 0, 90.00, 300.00, 'checkout', NULL, '2026-07-01 05:00:00', '2026-09-07 13:10:11'),
	(580, 1, 'DEMO-01176', 70, 18, 3, '2026-07-16', '2026-07-19', 3, 2, 2, 90.00, 270.00, 'checkout', NULL, '2026-07-13 05:00:00', '2026-09-07 13:10:11'),
	(581, 1, 'DEMO-01177', 7, 21, 3, '2026-07-14', '2026-07-19', 5, 1, 0, 90.00, 450.00, 'checkout', NULL, '2026-07-12 05:00:00', '2026-09-07 13:10:11'),
	(582, 1, 'DEMO-01178', 8, 39, 3, '2026-07-27', '2026-07-31', 4, 1, 2, 160.00, 640.00, 'checkout', NULL, '2026-07-27 05:00:00', '2026-09-07 13:10:11'),
	(583, 1, 'DEMO-01179', 10, 1, 3, '2026-07-10', '2026-07-11', 1, 2, 2, 90.00, 245.00, 'checkout', NULL, '2026-07-08 05:00:00', '2026-09-07 13:10:11'),
	(584, 1, 'DEMO-01180', 75, 32, 3, '2026-07-14', '2026-07-17', 3, 2, 0, 140.00, 420.00, 'checkout', NULL, '2026-07-12 05:00:00', '2026-09-07 13:10:11'),
	(585, 1, 'DEMO-01181', 1, 31, 3, '2026-07-24', '2026-07-27', 3, 1, 2, 90.00, 270.00, 'checkout', NULL, '2026-07-24 05:00:00', '2026-09-07 13:10:11'),
	(586, 1, 'DEMO-01182', 4, 40, 3, '2026-07-07', '2026-07-08', 1, 1, 0, 160.00, 160.00, 'checkout', NULL, '2026-07-04 05:00:00', '2026-09-07 13:10:11'),
	(587, 1, 'DEMO-01183', 11, 32, 3, '2026-07-13', '2026-07-15', 2, 2, 0, 140.00, 486.00, 'checkout', NULL, '2026-07-10 05:00:00', '2026-09-07 13:10:11'),
	(588, 1, 'DEMO-01184', 22, 38, 3, '2026-07-11', '2026-07-16', 5, 1, 1, 140.00, 700.00, 'checkout', NULL, '2026-07-08 05:00:00', '2026-09-07 13:10:11'),
	(589, 1, 'DEMO-01185', 20, 35, 3, '2026-07-15', '2026-07-18', 3, 1, 2, 140.00, 420.00, 'checkout', NULL, '2026-07-14 05:00:00', '2026-09-07 13:10:11'),
	(590, 1, 'DEMO-01186', 4, 17, 3, '2026-07-12', '2026-07-14', 2, 1, 2, 350.00, 1050.00, 'checkout', NULL, '2026-07-12 05:00:00', '2026-09-07 13:10:11'),
	(591, 1, 'DEMO-01187', 3, 9, 3, '2026-07-20', '2026-07-25', 5, 1, 0, 160.00, 808.00, 'checkout', NULL, '2026-07-17 05:00:00', '2026-09-07 13:10:11'),
	(592, 1, 'DEMO-01188', 66, 36, 3, '2026-08-04', '2026-08-08', 4, 2, 0, 160.00, 700.00, 'checkout', NULL, '2026-08-01 05:00:00', '2026-09-07 13:10:11'),
	(593, 1, 'DEMO-01189', 2, 9, 3, '2026-08-26', '2026-08-27', 1, 1, 1, 160.00, 160.00, 'checkout', NULL, '2026-08-25 05:00:00', '2026-09-07 13:10:11'),
	(594, 1, 'DEMO-01190', 11, 20, 3, '2026-08-19', '2026-08-22', 3, 1, 1, 350.00, 1050.00, 'checkout', NULL, '2026-08-17 05:00:00', '2026-09-07 13:10:11'),
	(595, 1, 'DEMO-01191', 18, 24, 3, '2026-08-01', '2026-08-05', 4, 2, 1, 350.00, 1781.00, 'checkout', NULL, '2026-07-30 05:00:00', '2026-09-07 13:10:11'),
	(596, 1, 'DEMO-01192', 14, 37, 3, '2026-08-05', '2026-08-08', 3, 1, 1, 160.00, 572.00, 'checkout', NULL, '2026-08-03 05:00:00', '2026-09-07 13:10:11'),
	(597, 1, 'DEMO-01193', 71, 6, 3, '2026-08-27', '2026-08-29', 2, 1, 0, 160.00, 320.00, 'checkout', NULL, '2026-08-26 05:00:00', '2026-09-07 13:10:11'),
	(598, 1, 'DEMO-01194', 73, 4, 3, '2026-08-11', '2026-08-12', 1, 1, 2, 160.00, 325.00, 'checkout', NULL, '2026-08-09 05:00:00', '2026-09-07 13:10:11'),
	(599, 1, 'DEMO-01195', 20, 42, 3, '2026-08-26', '2026-08-29', 3, 1, 0, 160.00, 513.00, 'checkout', NULL, '2026-08-23 05:00:00', '2026-09-07 13:10:11'),
	(600, 1, 'DEMO-01196', 8, 7, 3, '2026-08-15', '2026-08-18', 3, 2, 0, 350.00, 1320.00, 'checkout', NULL, '2026-08-14 05:00:00', '2026-09-07 13:10:11'),
	(601, 1, 'DEMO-01197', 69, 23, 3, '2026-08-14', '2026-08-19', 5, 1, 1, 210.00, 1125.00, 'checkout', NULL, '2026-08-14 05:00:00', '2026-09-07 13:10:11'),
	(602, 1, 'DEMO-01198', 22, 21, 3, '2026-08-21', '2026-08-25', 4, 2, 0, 90.00, 360.00, 'checkout', NULL, '2026-08-21 05:00:00', '2026-09-07 13:10:11'),
	(603, 1, 'DEMO-01199', 67, 9, 3, '2026-08-10', '2026-08-12', 2, 2, 0, 160.00, 565.00, 'checkout', NULL, '2026-08-10 05:00:00', '2026-09-07 13:10:11'),
	(604, 1, 'DEMO-01200', 23, 8, 3, '2026-08-16', '2026-08-20', 4, 2, 0, 90.00, 510.00, 'checkout', NULL, '2026-08-13 05:00:00', '2026-09-07 13:10:11');

-- Volcando estructura para tabla saas_hospedaje.suscripcion_pagos
CREATE TABLE IF NOT EXISTS `suscripcion_pagos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `plan_id` bigint unsigned DEFAULT NULL,
  `plan_nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `monto` decimal(10,2) NOT NULL DEFAULT '0.00',
  `periodo_inicio` date NOT NULL,
  `periodo_fin` date NOT NULL,
  `fecha_pago` date NOT NULL,
  `metodo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tarjeta',
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pagado',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `suscripcion_pagos_empresa_id_index` (`empresa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.suscripcion_pagos: ~0 rows (aproximadamente)
DELETE FROM `suscripcion_pagos`;

-- Volcando estructura para tabla saas_hospedaje.tarifa_temporadas
CREATE TABLE IF NOT EXISTS `tarifa_temporadas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('alta','baja','especial') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'alta',
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `ajuste_tipo` enum('porcentaje','fijo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'porcentaje',
  `ajuste_valor` decimal(10,2) NOT NULL DEFAULT '0.00',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tarifa_temporadas_empresa_id_index` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.tarifa_temporadas: ~13 rows (aproximadamente)
DELETE FROM `tarifa_temporadas`;
INSERT INTO `tarifa_temporadas` (`id`, `empresa_id`, `nombre`, `tipo`, `fecha_inicio`, `fecha_fin`, `ajuste_tipo`, `ajuste_valor`, `activo`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Temporada Alta - Fiestas Patrias', 'alta', '2026-07-26', '2026-07-31', 'porcentaje', 25.00, 1, '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(2, 1, 'Temporada Alta - Fin de Año', 'alta', '2026-12-20', '2026-12-31', 'porcentaje', 30.00, 1, '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(3, 1, 'Temporada Baja - Otoño', 'baja', '2026-05-01', '2026-06-30', 'porcentaje', -10.00, 1, '2026-06-09 21:13:02', '2026-06-09 21:13:02'),
	(44, 1, 'DEMO Feriado Largo', 'alta', '2026-07-06', '2026-07-09', 'porcentaje', 20.00, 1, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(45, 1, 'DEMO Fiestas Patrias', 'alta', '2026-07-26', '2026-07-31', 'porcentaje', 30.00, 1, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(46, 1, 'DEMO Aniversario Ciudad', 'especial', '2026-08-15', '2026-08-18', 'porcentaje', 15.00, 1, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(47, 1, 'DEMO Primavera', 'baja', '2026-09-01', '2026-09-30', 'porcentaje', -10.00, 1, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(48, 1, 'DEMO Día de la Canción', 'especial', '2026-10-30', '2026-10-31', 'fijo', 25.00, 1, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(49, 1, 'DEMO Todos los Santos', 'alta', '2026-11-01', '2026-11-02', 'porcentaje', 15.00, 1, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(50, 1, 'DEMO Black Friday', 'baja', '2026-11-27', '2026-11-29', 'porcentaje', -20.00, 1, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(51, 1, 'DEMO Navidad', 'alta', '2026-12-22', '2026-12-26', 'porcentaje', 35.00, 1, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(52, 1, 'DEMO Fin de Año', 'alta', '2026-12-29', '2026-12-31', 'porcentaje', 40.00, 1, '2026-09-07 13:10:11', '2026-09-07 13:10:11'),
	(53, 1, 'DEMO Verano', 'alta', '2027-01-01', '2027-02-28', 'porcentaje', 25.00, 1, '2026-09-07 13:10:11', '2026-09-07 13:10:11');

-- Volcando estructura para tabla saas_hospedaje.tipo_habitaciones
CREATE TABLE IF NOT EXISTS `tipo_habitaciones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `capacidad` tinyint unsigned NOT NULL DEFAULT '1',
  `precio_base` decimal(10,2) NOT NULL DEFAULT '0.00',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_habitaciones_empresa_id_index` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.tipo_habitaciones: ~5 rows (aproximadamente)
DELETE FROM `tipo_habitaciones`;
INSERT INTO `tipo_habitaciones` (`id`, `empresa_id`, `nombre`, `descripcion`, `capacidad`, `precio_base`, `activo`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Individual', '1 cama individual, ideal para viajeros solos.', 1, 90.00, 1, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(2, 1, 'Doble', '2 camas o 1 matrimonial.', 2, 140.00, 1, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(3, 1, 'Matrimonial', '1 cama matrimonial, vista a la ciudad.', 2, 160.00, 1, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(4, 1, 'Triple', '3 camas, ideal para familias pequeñas.', 3, 210.00, 1, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(5, 1, 'Suite', 'Suite de lujo con sala y jacuzzi.', 4, 350.00, 1, '2026-06-09 21:13:00', '2026-06-09 21:13:00');

-- Volcando estructura para tabla saas_hospedaje.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rol` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'recepcionista',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_empresa_id_index` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla saas_hospedaje.users: ~14 rows (aproximadamente)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `empresa_id`, `name`, `email`, `telefono`, `rol`, `activo`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Super Admin', 'superadmin@hospedaje.com', '900000000', 'superadmin', 1, NULL, '$2y$12$bCUb1e470IH8l5IjtmLt2urciaY54VuEZWJS1WWRcMJgfzujDbIz6', NULL, '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(2, 2, 'Ana Torres', 'admin@elviajero.com', '988111222', 'admin', 1, NULL, '$2y$12$tm2XmIFQQRtEjNYNqrhr4ue6GrdBX6ZKJAQ8.SGwlv8Vm.pd0YGgy', NULL, '2026-06-09 21:12:59', '2026-06-09 21:12:59'),
	(3, 1, 'Administrador', 'admin@hospedaje.com', '999000111', 'admin', 1, NULL, '$2y$12$FopXuI/IfnmiOH5Llq0XYenKqcLhxU.u5jBSbHwVf793wY6sNwNAu', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(4, 1, 'Recepcionista', 'recepcion@hospedaje.com', '999000222', 'recepcionista', 1, NULL, '$2y$12$A0PPwUcS1OTdoa5/9xlVFeqE1XoULdOK8x0YdNhA5qZNWtWXFc/ly', NULL, '2026-06-09 21:13:00', '2026-06-09 21:13:00'),
	(45, 1, 'Colaborador 1', 'demo.staff1@hospedaje.com', '948155354', 'recepcionista', 1, NULL, '$2y$12$7wON.1iS7VxyiKbBir471uQkyIhZTh0ZVABJfz6OH9k.hGf5dbHVa', NULL, '2026-09-07 13:10:06', '2026-09-07 13:10:06'),
	(46, 1, 'Colaborador 2', 'demo.staff2@hospedaje.com', '933971315', 'housekeeping', 1, NULL, '$2y$12$riIsQ5sN4vAwdHvV/LlYR.f1GTsiMqWGGLtUbythCEctbJY136kFG', NULL, '2026-09-07 13:10:07', '2026-09-07 13:10:07'),
	(47, 1, 'Colaborador 3', 'demo.staff3@hospedaje.com', '977312646', 'recepcionista', 1, NULL, '$2y$12$SSlm/LMXEqCHqHqbfqKkqec/IHFJGLIk973BCwbtzR7n51nwfsRPW', NULL, '2026-09-07 13:10:07', '2026-09-07 13:10:07'),
	(48, 1, 'Colaborador 4', 'demo.staff4@hospedaje.com', '959903605', 'housekeeping', 1, NULL, '$2y$12$BQNQUbfQLUZnm.12g0Q9e.e2HEeskxpQ4JLXCVT6iJf5AS4p2z7Wi', NULL, '2026-09-07 13:10:07', '2026-09-07 13:10:07'),
	(49, 1, 'Colaborador 5', 'demo.staff5@hospedaje.com', '965474161', 'recepcionista', 1, NULL, '$2y$12$PY3GoYaibcuovx2pob3IYOSYti1lkBHBeWiQKswOzVdiHZq4W73SG', NULL, '2026-09-07 13:10:08', '2026-09-07 13:10:08'),
	(50, 1, 'Colaborador 6', 'demo.staff6@hospedaje.com', '936648632', 'housekeeping', 1, NULL, '$2y$12$VGDIWYJEZXPVMRpLpE/POu5bfyS.O/c3dFxJjcLKebLe.1Dvc3qC6', NULL, '2026-09-07 13:10:08', '2026-09-07 13:10:08'),
	(51, 1, 'Colaborador 7', 'demo.staff7@hospedaje.com', '926455995', 'recepcionista', 1, NULL, '$2y$12$WOH33S5l2P8fcIgp6MNgsePQhynqgB0AdV2VYUqNevvtHrUmPvY4e', NULL, '2026-09-07 13:10:08', '2026-09-07 13:10:08'),
	(52, 1, 'Colaborador 8', 'demo.staff8@hospedaje.com', '944124321', 'housekeeping', 1, NULL, '$2y$12$kiTRjKZnd1hsPFBKSPIO3.0QRZz8TErN9OaOMs7KHhq/zYwjJZD2m', NULL, '2026-09-07 13:10:09', '2026-09-07 13:10:09'),
	(53, 1, 'Colaborador 9', 'demo.staff9@hospedaje.com', '983520993', 'recepcionista', 1, NULL, '$2y$12$/uza0C6UNblzCDZqx13tU.qmbmnf5L41b/avTheteASt1j6UivIpK', NULL, '2026-09-07 13:10:09', '2026-09-07 13:10:09'),
	(54, 1, 'Colaborador 10', 'demo.staff10@hospedaje.com', '943318537', 'housekeeping', 1, NULL, '$2y$12$Huo3XQ5.wmaBPk4NhW6m4uoLcnuQDXyQvk4DJVTamiS2Uhlp.wtM2', NULL, '2026-09-07 13:10:09', '2026-09-07 13:10:09');

-- Volcando estructura para vista saas_hospedaje.vb_ia_cajas
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vb_ia_cajas` (
	`empresa_id` BIGINT UNSIGNED NULL,
	`caja_id` BIGINT UNSIGNED NOT NULL,
	`fecha_apertura` TIMESTAMP NULL,
	`fecha_cierre` TIMESTAMP NULL,
	`cajero` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`monto_inicial` DECIMAL(10,2) NOT NULL,
	`monto_esperado` DECIMAL(10,2) NULL,
	`monto_final` DECIMAL(10,2) NULL,
	`diferencia` DECIMAL(10,2) NULL,
	`total_cobrado` DECIMAL(32,2) NOT NULL,
	`estado` ENUM('abierta','cerrada') NOT NULL COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista saas_hospedaje.vb_ia_consumos
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vb_ia_consumos` (
	`empresa_id` BIGINT UNSIGNED NULL,
	`consumo_id` BIGINT UNSIGNED NOT NULL,
	`fecha` DATE NOT NULL,
	`descripcion` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`producto` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`categoria` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`cantidad` INT UNSIGNED NOT NULL,
	`precio_unitario` DECIMAL(10,2) NOT NULL,
	`importe` DECIMAL(10,2) NOT NULL,
	`reserva_codigo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`huesped` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`habitacion` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`estado_reserva` ENUM('pendiente','confirmada','checkin','checkout','cancelada') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`registrado_por` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista saas_hospedaje.vb_ia_facturas
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vb_ia_facturas` (
	`empresa_id` BIGINT UNSIGNED NULL,
	`factura_id` BIGINT UNSIGNED NOT NULL,
	`numero` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`tipo_comprobante` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`comprobante` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`fecha` DATE NOT NULL,
	`subtotal` DECIMAL(10,2) NOT NULL,
	`igv` DECIMAL(10,2) NOT NULL,
	`total` DECIMAL(10,2) NOT NULL,
	`estado` ENUM('pendiente','pagada','anulada') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`metodo_pago` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`sunat_estado` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`huesped` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`documento` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`habitacion` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`reserva_codigo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`total_pagado` DECIMAL(32,2) NOT NULL,
	`saldo_pendiente` DECIMAL(33,2) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista saas_hospedaje.vb_ia_habitaciones
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vb_ia_habitaciones` (
	`empresa_id` BIGINT UNSIGNED NULL,
	`habitacion_id` BIGINT UNSIGNED NOT NULL,
	`numero` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`tipo_habitacion` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`piso` TINYINT UNSIGNED NOT NULL,
	`capacidad` TINYINT UNSIGNED NOT NULL,
	`precio_noche` DECIMAL(10,2) NOT NULL,
	`estado` ENUM('disponible','ocupada','mantenimiento','limpieza') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`num_reservas` BIGINT NOT NULL,
	`noches_vendidas` DECIMAL(27,0) NOT NULL,
	`ingreso_hospedaje` DECIMAL(32,2) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista saas_hospedaje.vb_ia_huespedes
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vb_ia_huespedes` (
	`empresa_id` BIGINT UNSIGNED NULL,
	`huesped_id` BIGINT UNSIGNED NOT NULL,
	`nombre` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`tipo_documento` ENUM('DNI','CE','Pasaporte','RUC') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`numero_documento` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`nacionalidad` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`telefono` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`email` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`creado_en` TIMESTAMP NULL,
	`num_reservas` BIGINT NOT NULL,
	`noches_totales` DECIMAL(27,0) NOT NULL,
	`total_gastado` DECIMAL(32,2) NOT NULL,
	`ultima_estadia` DATE NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista saas_hospedaje.vb_ia_noches
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vb_ia_noches` (
	`empresa_id` BIGINT UNSIGNED NULL,
	`fecha` DATE NULL,
	`reserva_id` BIGINT UNSIGNED NOT NULL,
	`reserva_codigo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`habitacion` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`tipo_habitacion` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`ingreso_noche` DECIMAL(10,2) NOT NULL,
	`estado` ENUM('pendiente','confirmada','checkin','checkout','cancelada') NOT NULL COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista saas_hospedaje.vb_ia_pagos
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vb_ia_pagos` (
	`empresa_id` BIGINT UNSIGNED NULL,
	`pago_id` BIGINT UNSIGNED NOT NULL,
	`fecha` DATE NOT NULL,
	`monto` DECIMAL(10,2) NOT NULL,
	`metodo_pago` ENUM('efectivo','tarjeta','yape','transferencia') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`factura` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`huesped` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`cajero` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`caja_id` BIGINT UNSIGNED NULL,
	`nota` TEXT NULL COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista saas_hospedaje.vb_ia_productos
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vb_ia_productos` (
	`empresa_id` BIGINT UNSIGNED NULL,
	`producto_id` BIGINT UNSIGNED NOT NULL,
	`producto` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`categoria` ENUM('minibar','restaurante','lavanderia','servicios','otros') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`precio` DECIMAL(10,2) NOT NULL,
	`activo` TINYINT(1) NOT NULL,
	`unidades_vendidas` DECIMAL(32,0) NOT NULL,
	`importe_vendido` DECIMAL(32,2) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista saas_hospedaje.vb_ia_reservas
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vb_ia_reservas` (
	`empresa_id` BIGINT UNSIGNED NULL,
	`reserva_id` BIGINT UNSIGNED NOT NULL,
	`codigo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`fecha_checkin` DATE NOT NULL,
	`fecha_checkout` DATE NOT NULL,
	`noches` SMALLINT UNSIGNED NOT NULL,
	`adultos` TINYINT UNSIGNED NOT NULL,
	`ninos` TINYINT UNSIGNED NOT NULL,
	`personas` INT UNSIGNED NOT NULL,
	`huesped` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`nacionalidad` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`habitacion` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`tipo_habitacion` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`piso` TINYINT UNSIGNED NOT NULL,
	`tarifa_noche` DECIMAL(10,2) NOT NULL,
	`total_hospedaje` DECIMAL(10,2) NOT NULL,
	`total_consumos` DECIMAL(32,2) NOT NULL,
	`total_cuenta` DECIMAL(33,2) NOT NULL,
	`estado` ENUM('pendiente','confirmada','checkin','checkout','cancelada') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`registrado_por` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`creada_en` TIMESTAMP NULL,
	`dias_anticipacion` INT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista saas_hospedaje.vb_ia_tarifas_temporada
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vb_ia_tarifas_temporada` (
	`empresa_id` BIGINT UNSIGNED NULL,
	`tarifa_id` BIGINT UNSIGNED NOT NULL,
	`nombre` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`tipo` ENUM('alta','baja','especial') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`fecha_inicio` DATE NOT NULL,
	`fecha_fin` DATE NOT NULL,
	`ajuste_tipo` ENUM('porcentaje','fijo') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`ajuste_valor` DECIMAL(10,2) NOT NULL,
	`activo` TINYINT(1) NOT NULL,
	`vigente_hoy` INT NOT NULL
) ENGINE=MyISAM;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vb_ia_cajas`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vb_ia_cajas` AS select `cs`.`empresa_id` AS `empresa_id`,`cs`.`id` AS `caja_id`,`cs`.`abierta_at` AS `fecha_apertura`,`cs`.`cerrada_at` AS `fecha_cierre`,coalesce(`u`.`name`,'Sin usuario') AS `cajero`,`cs`.`monto_inicial` AS `monto_inicial`,`cs`.`monto_esperado` AS `monto_esperado`,`cs`.`monto_final` AS `monto_final`,`cs`.`diferencia` AS `diferencia`,coalesce(`pg`.`t`,0) AS `total_cobrado`,`cs`.`estado` AS `estado` from ((`caja_sesiones` `cs` left join `users` `u` on((`u`.`id` = `cs`.`user_id`))) left join (select `pagos`.`caja_sesion_id` AS `caja_sesion_id`,sum(`pagos`.`monto`) AS `t` from `pagos` group by `pagos`.`caja_sesion_id`) `pg` on((`pg`.`caja_sesion_id` = `cs`.`id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vb_ia_consumos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vb_ia_consumos` AS select `c`.`empresa_id` AS `empresa_id`,`c`.`id` AS `consumo_id`,`c`.`fecha` AS `fecha`,`c`.`descripcion` AS `descripcion`,coalesce(`p`.`nombre`,`c`.`descripcion`) AS `producto`,coalesce(`p`.`categoria`,'otros') AS `categoria`,`c`.`cantidad` AS `cantidad`,`c`.`precio_unit` AS `precio_unitario`,`c`.`subtotal` AS `importe`,`r`.`codigo` AS `reserva_codigo`,concat(`hu`.`nombres`,' ',`hu`.`apellidos`) AS `huesped`,`h`.`numero` AS `habitacion`,`r`.`estado` AS `estado_reserva`,coalesce(`u`.`name`,'Sin usuario') AS `registrado_por` from (((((`consumos` `c` join `reservas` `r` on((`r`.`id` = `c`.`reserva_id`))) join `huespedes` `hu` on((`hu`.`id` = `r`.`huesped_id`))) join `habitaciones` `h` on((`h`.`id` = `r`.`habitacion_id`))) left join `productos` `p` on((`p`.`id` = `c`.`producto_id`))) left join `users` `u` on((`u`.`id` = `c`.`user_id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vb_ia_facturas`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vb_ia_facturas` AS select `f`.`empresa_id` AS `empresa_id`,`f`.`id` AS `factura_id`,`f`.`numero` AS `numero`,`f`.`tipo_comprobante` AS `tipo_comprobante`,concat(coalesce(`f`.`serie`,''),'-',coalesce(`f`.`correlativo`,'')) AS `comprobante`,`f`.`fecha` AS `fecha`,`f`.`subtotal` AS `subtotal`,`f`.`igv` AS `igv`,`f`.`total` AS `total`,`f`.`estado` AS `estado`,`f`.`metodo_pago` AS `metodo_pago`,`f`.`sunat_estado` AS `sunat_estado`,concat(`hu`.`nombres`,' ',`hu`.`apellidos`) AS `huesped`,`hu`.`documento_numero` AS `documento`,`h`.`numero` AS `habitacion`,`r`.`codigo` AS `reserva_codigo`,coalesce(`pg`.`pagado`,0) AS `total_pagado`,(case when (`f`.`estado` = 'pendiente') then greatest((`f`.`total` - coalesce(`pg`.`pagado`,0)),0) else 0 end) AS `saldo_pendiente` from ((((`facturas` `f` join `reservas` `r` on((`r`.`id` = `f`.`reserva_id`))) join `huespedes` `hu` on((`hu`.`id` = `r`.`huesped_id`))) join `habitaciones` `h` on((`h`.`id` = `r`.`habitacion_id`))) left join (select `pagos`.`factura_id` AS `factura_id`,sum(`pagos`.`monto`) AS `pagado` from `pagos` group by `pagos`.`factura_id`) `pg` on((`pg`.`factura_id` = `f`.`id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vb_ia_habitaciones`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vb_ia_habitaciones` AS select `h`.`empresa_id` AS `empresa_id`,`h`.`id` AS `habitacion_id`,`h`.`numero` AS `numero`,`th`.`nombre` AS `tipo_habitacion`,`h`.`piso` AS `piso`,`h`.`capacidad` AS `capacidad`,`h`.`precio_noche` AS `precio_noche`,`h`.`estado` AS `estado`,coalesce(`x`.`n_res`,0) AS `num_reservas`,coalesce(`x`.`noches`,0) AS `noches_vendidas`,coalesce(`x`.`ingreso`,0) AS `ingreso_hospedaje` from ((`habitaciones` `h` join `tipo_habitaciones` `th` on((`th`.`id` = `h`.`tipo_habitacion_id`))) left join (select `reservas`.`habitacion_id` AS `habitacion_id`,count(0) AS `n_res`,sum(`reservas`.`noches`) AS `noches`,sum(`reservas`.`total`) AS `ingreso` from `reservas` where (`reservas`.`estado` <> 'cancelada') group by `reservas`.`habitacion_id`) `x` on((`x`.`habitacion_id` = `h`.`id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vb_ia_huespedes`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vb_ia_huespedes` AS select `hu`.`empresa_id` AS `empresa_id`,`hu`.`id` AS `huesped_id`,concat(`hu`.`nombres`,' ',`hu`.`apellidos`) AS `nombre`,`hu`.`documento_tipo` AS `tipo_documento`,`hu`.`documento_numero` AS `numero_documento`,`hu`.`nacionalidad` AS `nacionalidad`,`hu`.`telefono` AS `telefono`,`hu`.`email` AS `email`,`hu`.`created_at` AS `creado_en`,coalesce(`x`.`n_res`,0) AS `num_reservas`,coalesce(`x`.`noches`,0) AS `noches_totales`,coalesce(`x`.`gasto`,0) AS `total_gastado`,`x`.`ultima` AS `ultima_estadia` from (`huespedes` `hu` left join (select `reservas`.`huesped_id` AS `huesped_id`,count(0) AS `n_res`,sum(`reservas`.`noches`) AS `noches`,sum(`reservas`.`total`) AS `gasto`,max(`reservas`.`fecha_checkin`) AS `ultima` from `reservas` where (`reservas`.`estado` <> 'cancelada') group by `reservas`.`huesped_id`) `x` on((`x`.`huesped_id` = `hu`.`id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vb_ia_noches`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vb_ia_noches` AS select `r`.`empresa_id` AS `empresa_id`,(`r`.`fecha_checkin` + interval `n`.`n` day) AS `fecha`,`r`.`id` AS `reserva_id`,`r`.`codigo` AS `reserva_codigo`,`h`.`numero` AS `habitacion`,`th`.`nombre` AS `tipo_habitacion`,`r`.`tarifa_noche` AS `ingreso_noche`,`r`.`estado` AS `estado` from (((`reservas` `r` join `habitaciones` `h` on((`h`.`id` = `r`.`habitacion_id`))) join `tipo_habitaciones` `th` on((`th`.`id` = `h`.`tipo_habitacion_id`))) join (select ((`a`.`d` + (`b`.`d` * 10)) + (`c`.`d` * 100)) AS `n` from (((select 0 AS `d` union all select 1 AS `1` union all select 2 AS `2` union all select 3 AS `3` union all select 4 AS `4` union all select 5 AS `5` union all select 6 AS `6` union all select 7 AS `7` union all select 8 AS `8` union all select 9 AS `9`) `a` join (select 0 AS `d` union all select 1 AS `1` union all select 2 AS `2` union all select 3 AS `3` union all select 4 AS `4` union all select 5 AS `5` union all select 6 AS `6` union all select 7 AS `7` union all select 8 AS `8` union all select 9 AS `9`) `b`) join (select 0 AS `d` union all select 1 AS `1` union all select 2 AS `2` union all select 3 AS `3` union all select 4 AS `4` union all select 5 AS `5` union all select 6 AS `6` union all select 7 AS `7` union all select 8 AS `8` union all select 9 AS `9`) `c`)) `n` on((`n`.`n` < `r`.`noches`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vb_ia_pagos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vb_ia_pagos` AS select `pg`.`empresa_id` AS `empresa_id`,`pg`.`id` AS `pago_id`,`pg`.`fecha` AS `fecha`,`pg`.`monto` AS `monto`,`pg`.`metodo_pago` AS `metodo_pago`,`f`.`numero` AS `factura`,concat(`hu`.`nombres`,' ',`hu`.`apellidos`) AS `huesped`,coalesce(`u`.`name`,'Sin usuario') AS `cajero`,`pg`.`caja_sesion_id` AS `caja_id`,`pg`.`nota` AS `nota` from ((((`pagos` `pg` join `facturas` `f` on((`f`.`id` = `pg`.`factura_id`))) left join `reservas` `r` on((`r`.`id` = `f`.`reserva_id`))) left join `huespedes` `hu` on((`hu`.`id` = `r`.`huesped_id`))) left join `users` `u` on((`u`.`id` = `pg`.`user_id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vb_ia_productos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vb_ia_productos` AS select `p`.`empresa_id` AS `empresa_id`,`p`.`id` AS `producto_id`,`p`.`nombre` AS `producto`,`p`.`categoria` AS `categoria`,`p`.`precio` AS `precio`,`p`.`activo` AS `activo`,coalesce(`x`.`unid`,0) AS `unidades_vendidas`,coalesce(`x`.`imp`,0) AS `importe_vendido` from (`productos` `p` left join (select `consumos`.`producto_id` AS `producto_id`,sum(`consumos`.`cantidad`) AS `unid`,sum(`consumos`.`subtotal`) AS `imp` from `consumos` group by `consumos`.`producto_id`) `x` on((`x`.`producto_id` = `p`.`id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vb_ia_reservas`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vb_ia_reservas` AS select `r`.`empresa_id` AS `empresa_id`,`r`.`id` AS `reserva_id`,`r`.`codigo` AS `codigo`,`r`.`fecha_checkin` AS `fecha_checkin`,`r`.`fecha_checkout` AS `fecha_checkout`,`r`.`noches` AS `noches`,`r`.`adultos` AS `adultos`,`r`.`ninos` AS `ninos`,(`r`.`adultos` + `r`.`ninos`) AS `personas`,concat(`hu`.`nombres`,' ',`hu`.`apellidos`) AS `huesped`,`hu`.`nacionalidad` AS `nacionalidad`,`h`.`numero` AS `habitacion`,`th`.`nombre` AS `tipo_habitacion`,`h`.`piso` AS `piso`,`r`.`tarifa_noche` AS `tarifa_noche`,`r`.`total` AS `total_hospedaje`,coalesce(`cs`.`s`,0) AS `total_consumos`,(`r`.`total` + coalesce(`cs`.`s`,0)) AS `total_cuenta`,`r`.`estado` AS `estado`,coalesce(`u`.`name`,'Sin usuario') AS `registrado_por`,`r`.`created_at` AS `creada_en`,(to_days(`r`.`fecha_checkin`) - to_days(cast(`r`.`created_at` as date))) AS `dias_anticipacion` from (((((`reservas` `r` join `huespedes` `hu` on((`hu`.`id` = `r`.`huesped_id`))) join `habitaciones` `h` on((`h`.`id` = `r`.`habitacion_id`))) join `tipo_habitaciones` `th` on((`th`.`id` = `h`.`tipo_habitacion_id`))) left join `users` `u` on((`u`.`id` = `r`.`user_id`))) left join (select `consumos`.`reserva_id` AS `reserva_id`,sum(`consumos`.`subtotal`) AS `s` from `consumos` group by `consumos`.`reserva_id`) `cs` on((`cs`.`reserva_id` = `r`.`id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vb_ia_tarifas_temporada`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vb_ia_tarifas_temporada` AS select `t`.`empresa_id` AS `empresa_id`,`t`.`id` AS `tarifa_id`,`t`.`nombre` AS `nombre`,`t`.`tipo` AS `tipo`,`t`.`fecha_inicio` AS `fecha_inicio`,`t`.`fecha_fin` AS `fecha_fin`,`t`.`ajuste_tipo` AS `ajuste_tipo`,`t`.`ajuste_valor` AS `ajuste_valor`,`t`.`activo` AS `activo`,((`t`.`activo` = 1) and (curdate() between `t`.`fecha_inicio` and `t`.`fecha_fin`)) AS `vigente_hoy` from `tarifa_temporadas` `t`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
