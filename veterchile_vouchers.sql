-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 29-06-2026 a las 22:44:26
-- Versión del servidor: 5.7.33
-- Versión de PHP: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `veterchile_vouchers`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditor_notificaciones`
--

CREATE TABLE `auditor_notificaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_id` bigint(20) UNSIGNED DEFAULT NULL,
  `alerta_id` bigint(20) UNSIGNED DEFAULT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mensaje` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `leido` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_lectura` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `auditor_notificaciones`
--

INSERT INTO `auditor_notificaciones` (`id`, `voucher_id`, `alerta_id`, `titulo`, `mensaje`, `leido`, `fecha_lectura`, `created_at`, `updated_at`) VALUES
(1, 81, NULL, 'Riesgo en validación de atención', 'El voucher VT-20260609064232-SKWRC fue validado con riesgo medio.', 0, NULL, '2026-06-11 02:43:46', '2026-06-11 02:43:46'),
(2, 82, NULL, 'Riesgo en validación de atención', 'El voucher VT-20260609074524-SWYOS fue validado con riesgo medio.', 0, NULL, '2026-06-11 07:22:52', '2026-06-11 07:22:52'),
(3, 83, NULL, 'Riesgo en validación de atención', 'El voucher VT-20260609074524-WD71U fue validado con riesgo medio.', 0, NULL, '2026-06-11 07:23:15', '2026-06-11 07:23:15'),
(4, 84, NULL, 'Riesgo en validación de atención', 'El voucher VT-20260610221525-XNYQM fue validado con riesgo medio.', 0, NULL, '2026-06-11 07:23:36', '2026-06-11 07:23:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campanas`
--

CREATE TABLE `campanas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_autorizaciones`
--

CREATE TABLE `cliente_autorizaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cliente_id` bigint(20) UNSIGNED NOT NULL,
  `dispositivo_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tipo_accion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referencia_tipo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referencia_id` bigint(20) UNSIGNED DEFAULT NULL,
  `token` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('pendiente','aprobada','rechazada','expirada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `ip_solicitante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expira_at` timestamp NULL DEFAULT NULL,
  `aprobada_at` timestamp NULL DEFAULT NULL,
  `rechazada_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cliente_autorizaciones`
--

INSERT INTO `cliente_autorizaciones` (`id`, `cliente_id`, `dispositivo_id`, `tipo_accion`, `referencia_tipo`, `referencia_id`, `token`, `estado`, `ip_solicitante`, `expira_at`, `aprobada_at`, `rechazada_at`, `created_at`, `updated_at`) VALUES
(1, 9, 1, 'ver_datos_sensibles', 'voucher', 1, 'ImGiHCkYYAA6illTX9jrY8WXTN2mwLkcoCd16omIUFbo5hXM1vVMs8En4iJiS1w4FzORy5c5DOkOr1qN', 'aprobada', '127.0.0.1', '2026-06-08 03:00:00', '2026-06-08 02:57:41', NULL, '2026-06-08 02:55:00', '2026-06-08 02:57:41'),
(2, 9, 2, 'ver_datos_sensibles', 'voucher', 1, 'qtwq0lROzwQCQGM09UcUK1n19HZmQM14OShxGhktaUjHNwqSrJmbele3M5ak0tNptXYwkDsZ1NTQ8cd2', 'pendiente', '127.0.0.1', '2026-06-08 04:35:41', NULL, NULL, '2026-06-08 04:30:41', '2026-06-08 04:30:41'),
(3, 9, 1, 'ver_datos_sensibles', 'voucher', 1, 'jCDsChDMyDJxPSUJuyVaLwZNAxER2asUDHp7aimgdtYkquJA8EqsxPGsJs4Gp54mAtS2FeyAxg7INDYw', 'aprobada', '127.0.0.1', '2026-06-08 05:04:01', '2026-06-08 05:02:16', NULL, '2026-06-08 04:59:01', '2026-06-08 05:02:16'),
(4, 9, 1, 'ver_datos_dueno', 'mascota', 1, 'S1rRKDsU89ZtbytqPspBmk1YykVbnJgzwIW12e3vJgqrFi0qttlNaeNkMNJNyjvJnBXFLz1Ez7jF7nOo', 'aprobada', '127.0.0.1', '2026-06-08 06:33:18', '2026-06-08 06:29:00', NULL, '2026-06-08 06:28:18', '2026-06-08 06:29:00'),
(5, 9, 1, 'ver_datos_dueno', 'mascota', 1, 'JsCNj8WzBwm48NlgtdfFjQ4tLgMnsyFZOlCiIgBOs3qtNTV1LRVKq4olVUs0WlyldCQRyPBqoUxSqjSG', 'pendiente', '127.0.0.1', '2026-06-08 07:24:56', NULL, NULL, '2026-06-08 07:19:56', '2026-06-08 07:19:56'),
(6, 9, 1, 'ver_datos_dueno', 'mascota', 1, 'YfRW2KZIXE88liy30HDRhIr3WhzXNjQILhLGwo8lVhlDsLCGKDHhibmbsQ3F742uPKxcCaGoGijTJlSM', 'pendiente', '127.0.0.1', '2026-06-08 07:33:46', NULL, NULL, '2026-06-08 07:28:46', '2026-06-08 07:28:46'),
(7, 9, 1, 'ver_datos_dueno', 'mascota', 1, '8H29QQLAgQ16KXhwy2CEPksnxDR2xN3qGeoc0GJeA8HsuAUIMe3eo4OQ6xQQ34PhMVT5apoboexaPVIa', 'pendiente', '127.0.0.1', '2026-06-08 07:34:13', NULL, NULL, '2026-06-08 07:29:13', '2026-06-08 07:29:13'),
(8, 9, 1, 'ver_datos_dueno', 'mascota', 1, 'vaY4gAMK0UEy1oqlOfwAprFqZusxy1JlHhc5RuVCQETN0MPN9QQ9wuB0b7AFlOQTRUf8Y64Sjp8SCAKv', 'pendiente', '127.0.0.1', '2026-06-08 07:36:54', NULL, NULL, '2026-06-08 07:31:54', '2026-06-08 07:31:54'),
(9, 9, 1, 'ver_datos_dueno', 'mascota', 1, 'J9pvLsmK8fclUMUqYvQ2aTo7m4zYB8BgM6TWVNfxskPeUaKm6rluNTC0BeyYGRiCydSDhYb6yg0TCq28', 'pendiente', '127.0.0.1', '2026-06-08 07:36:57', NULL, NULL, '2026-06-08 07:31:57', '2026-06-08 07:31:57'),
(10, 9, 1, 'ver_datos_dueno', 'mascota', 1, 'PVE5i2HGn0nqMzYRGIzpkGGitjBiHpw0WU1QdsrYlm7FGUF0DafUHpn5aJ2ondfX0wVAXnHSttNGfCRW', 'pendiente', '127.0.0.1', '2026-06-08 07:46:03', NULL, NULL, '2026-06-08 07:41:03', '2026-06-08 07:41:03'),
(11, 9, 1, 'ver_datos_dueno', 'mascota', 1, 'bfGAlYLbUW8uVl2wrob37rDCAxCYsNswDdFboTnkfxfYj1pNMJVWyXxkbuPwNwsBySeHGiyIXGnYIqCP', 'pendiente', '127.0.0.1', '2026-06-08 07:46:48', NULL, NULL, '2026-06-08 07:41:48', '2026-06-08 07:41:48'),
(12, 9, 1, 'ver_datos_dueno', 'mascota', 1, 'bMExoPDLpfguIqkarNiX8Wqk7szXpljFQeOh5KTFnfOQaQeXvWAscZiMB7LfPkIx2JB17t9aKLesGv73', 'pendiente', '127.0.0.1', '2026-06-08 08:06:05', NULL, NULL, '2026-06-08 08:01:05', '2026-06-08 08:01:05'),
(13, 9, 1, 'ver_datos_dueno', 'mascota', 1, 'HbLo0Bj0k55plqvzw1G7hL0CvV8ONzYMea7tBCSNxZOfUr2c6E3fYKmPQsBqe5o7VC8KxucYv4gxNLI5', 'pendiente', '127.0.0.1', '2026-06-08 08:08:27', NULL, NULL, '2026-06-08 08:03:27', '2026-06-08 08:03:27'),
(14, 9, 1, 'ver_datos_dueno', 'mascota', 1, 'hTjy61IPyCOngu8X4N7ImxsqlOYszeLznD8C3u4ubZFPcVfjqgMwhJs5CmaX6CdfIC0rW2GvwDml1EYP', 'expirada', '127.0.0.1', '2026-06-08 08:14:27', NULL, NULL, '2026-06-08 08:09:27', '2026-06-08 08:14:53'),
(15, 9, 1, 'ver_datos_dueno', 'mascota', 2, 'j5ZxpgWBmXoOFv3moyfP5pO8Xxn6Q4ezzDuAwNqlDqTbGwpJ5kPTP0Kq0VojhYx6JQXROpTisYrfB4jQ', 'pendiente', '127.0.0.1', '2026-06-09 05:59:14', NULL, NULL, '2026-06-09 05:54:14', '2026-06-09 05:54:14'),
(16, 9, 1, 'ver_datos_dueno', 'mascota', 2, 'PyhADbcKT5DmjkBnXR1rjtjF72Jk3OGKYzq9LntU7DaMyCUwUVaiWc5UwR5ztGNEINenPazWdsJRe3JU', 'pendiente', '127.0.0.1', '2026-06-29 08:16:07', NULL, NULL, '2026-06-29 08:11:07', '2026-06-29 08:11:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_dispositivos`
--

CREATE TABLE `cliente_dispositivos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cliente_id` bigint(20) UNSIGNED NOT NULL,
  `imei_hash` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_dispositivo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('activo','bloqueado','pendiente') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `ultimo_uso_at` timestamp NULL DEFAULT NULL,
  `ip_registro` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cliente_dispositivos`
--

INSERT INTO `cliente_dispositivos` (`id`, `cliente_id`, `imei_hash`, `device_token`, `nombre_dispositivo`, `estado`, `ultimo_uso_at`, `ip_registro`, `created_at`, `updated_at`) VALUES
(1, 9, 'e8ea2c20a6b9f25c12cb49f911de65c86c82a74f4f14d087375cebb15a4769d7', 'TOKEN-DEMO', 'Android Katherine', 'activo', '2026-06-08 04:27:48', '127.0.0.1', '2026-06-08 02:54:08', '2026-06-08 04:27:48'),
(2, 9, '51d94495a20651bc4852b31d963412e902de31ed4df8df0bcc8b6f958983b0eb', 'IOS-CORDOVA-DEMO', 'mi disp', 'activo', '2026-06-08 03:55:42', '127.0.0.1', '2026-06-08 03:55:42', '2026-06-08 03:55:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente_saldos`
--

CREATE TABLE `cliente_saldos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_id` bigint(20) UNSIGNED DEFAULT NULL,
  `voucher_consumido_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cliente_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cliente_rut_hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monto` int(11) NOT NULL DEFAULT '0',
  `origen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'voucher_invalidado',
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'disponible',
  `consumido_en` timestamp NULL DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ip_autorizadas`
--

CREATE TABLE `ip_autorizadas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rol` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_auditorias`
--

CREATE TABLE `login_auditorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resultado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fallido',
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `login_auditorias`
--

INSERT INTO `login_auditorias` (`id`, `user_id`, `email`, `resultado`, `ip`, `user_agent`, `created_at`, `updated_at`) VALUES
(1, 4, 'admin@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-04 00:11:31', '2026-06-04 00:11:31'),
(2, NULL, 'jkran@gmail.com', 'fallido', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-11 00:07:35', '2026-06-11 00:07:35'),
(3, NULL, 'jkran@gmail.com', 'fallido', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-11 00:08:05', '2026-06-11 00:08:05'),
(4, 23, 'jkran@gmail.com', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-11 00:14:45', '2026-06-11 00:14:45'),
(5, 23, 'jkran@gmail.com', 'logout', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-11 00:32:35', '2026-06-11 00:32:35'),
(6, NULL, 'jkriman@gmail.com', 'fallido', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-11 00:32:41', '2026-06-11 00:32:41'),
(7, 4, 'admin@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-11 00:33:10', '2026-06-11 00:33:10'),
(8, 23, 'jkran@gmail.com', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-11 02:21:03', '2026-06-11 02:21:03'),
(9, 4, 'admin@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-11 07:45:12', '2026-06-11 07:45:12'),
(10, 23, 'jkran@gmail.com', 'logout', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-12 08:51:36', '2026-06-12 08:51:36'),
(11, 24, 'asistente@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-06-12 08:52:03', '2026-06-12 08:52:03'),
(12, 6, 'usuariodemo@gmail.com', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:07:05', '2026-06-25 02:07:05'),
(13, 1, 'vendedor@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:13:37', '2026-06-25 02:13:37'),
(14, 1, 'vendedor@veterchile.cl', 'logout', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:14:06', '2026-06-25 02:14:06'),
(15, 2, 'profesional@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:14:13', '2026-06-25 02:14:13'),
(16, 2, 'profesional@veterchile.cl', 'logout', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:14:45', '2026-06-25 02:14:45'),
(17, NULL, 'auditor@veterchile.cl', 'fallido', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:14:51', '2026-06-25 02:14:51'),
(18, NULL, 'auditor@veterchile.cl', 'fallido', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:14:58', '2026-06-25 02:14:58'),
(19, NULL, 'auditor@veterchile.cl', 'fallido', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:15:13', '2026-06-25 02:15:13'),
(20, 3, 'auditor@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:15:37', '2026-06-25 02:15:37'),
(21, 3, 'auditor@veterchile.cl', 'logout', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:19:20', '2026-06-25 02:19:20'),
(22, 4, 'admin@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:19:27', '2026-06-25 02:19:27'),
(23, 4, 'admin@veterchile.cl', 'logout', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:22:08', '2026-06-25 02:22:08'),
(24, 9, 'katherine.bastias91@gmail.com', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:22:16', '2026-06-25 02:22:16'),
(25, 9, 'katherine.bastias91@gmail.com', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:31:10', '2026-06-25 02:31:10'),
(26, 9, 'katherine.bastias91@gmail.com', 'logout', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:37:28', '2026-06-25 02:37:28'),
(27, 4, 'admin@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-25 02:43:33', '2026-06-25 02:43:33'),
(28, 4, 'admin@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-26 04:12:26', '2026-06-26 04:12:26'),
(29, 4, 'admin@veterchile.cl', 'logout', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-26 06:08:18', '2026-06-26 06:08:18'),
(30, 9, 'katherine.bastias91@gmail.com', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-26 06:08:41', '2026-06-26 06:08:41'),
(31, 9, 'katherine.bastias91@gmail.com', 'logout', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-26 06:09:21', '2026-06-26 06:09:21'),
(32, NULL, 'clienteusuario@veterchile.cl', 'fallido', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-26 06:10:41', '2026-06-26 06:10:41'),
(33, NULL, 'clienteusuario@veterchile.cl', 'fallido', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-26 06:10:53', '2026-06-26 06:10:53'),
(34, NULL, 'admin@veterchile.cl', 'fallido', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-26 06:11:03', '2026-06-26 06:11:03'),
(35, 1, 'vendedor@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-26 06:12:45', '2026-06-26 06:12:45'),
(36, 4, 'admin@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-27 13:13:19', '2026-06-27 13:13:19'),
(37, 4, 'admin@veterchile.cl', 'exitoso', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-29 04:43:23', '2026-06-29 04:43:23'),
(38, 4, 'admin@veterchile.cl', 'logout', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-29 06:13:24', '2026-06-29 06:13:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2026_05_26_020606_create_vouchers_table', 1),
(6, '2026_05_26_033802_add_finanzas_to_vouchers_table', 2),
(7, '2026_05_26_032715_create_voucher_pagos_table', 3),
(8, '2026_05_26_053406_create_voucher_cobros_table', 4),
(9, '2026_05_26_234938_create_voucher_rendicions_table', 5),
(10, '2026_05_27_000436_add_rendicion_id_to_voucher_cobros_table', 6),
(11, '2026_05_27_035437_add_vendedor_id_to_vouchers_table', 7),
(12, '2026_05_27_041342_create_voucher_vendedors_table', 8),
(13, '2026_05_27_081722_create_voucher_profesionals_table', 9),
(14, '2026_05_27_082740_add_profesional_id_to_vouchers_table', 10),
(15, '2026_05_27_105637_create_voucher_auditorias_table', 11),
(16, '2026_05_27_182307_create_voucher_liquidacions_table', 12),
(17, '2026_05_27_193645_add_roles_to_users_table', 13),
(18, '2026_05_28_173702_create_voucher_servicios_table', 14),
(19, '2026_05_29_010810_add_servicio_id_to_vouchers_table', 15),
(20, '2026_05_29_210853_add_cliente_flujo_to_vouchers_table', 16),
(21, '2026_05_29_220810_create_voucher_alertas_table', 17),
(22, '2026_05_30_045903_add_profesional_id_to_voucher_cobros_table', 18),
(23, '2026_05_31_001347_create_voucher_mascotas_table', 19),
(24, '2026_05_31_032611_add_rut_telefono_to_users_table', 20),
(25, '2026_05_31_193849_add_encrypted_fields_to_users_table', 21),
(26, '2026_05_31_212856_add_security_fields_to_vouchers_table', 22),
(27, '2026_05_31_213052_create_voucher_logs_table', 23),
(28, '2026_05_31_230818_add_cliente_rut_hash_to_vouchers_table', 24),
(29, '2026_05_31_232801_encrypt_existing_cliente_rut_in_vouchers_table', 25),
(30, '2026_05_31_234519_add_otp_fields_to_vouchers_table', 26),
(31, '2026_06_01_031259_create_cliente_saldos_table', 27),
(32, '2026_06_01_031557_add_invalidacion_fields_to_vouchers_table', 27),
(33, '2026_06_01_040121_add_consumo_fields_to_cliente_saldos_table', 28),
(34, '2026_06_01_041241_add_saldo_cliente_aplicado_to_vouchers_table', 29),
(35, '2026_06_01_044958_create_auditor_notificacions_table', 29),
(36, '2026_06_01_053318_create_login_auditorias_table', 30),
(37, '2026_06_01_172019_add_login_otp_fields_to_users_table', 31),
(44, '2026_06_02_043013_create_ip_autorizadas_table', 32),
(45, '2026_06_02_052801_create_totems_table', 32),
(46, '2026_06_02_052841_create_totem_sesions_table', 32),
(47, '2026_06_02_052853_create_totem_ventas_table', 32),
(48, '2026_06_02_052913_create_totem_venta_detalles_table', 32),
(49, '2026_06_02_052939_create_totem_logs_table', 32),
(50, '2026_06_02_144758_add_entrega_to_totem_ventas_table', 33),
(51, '2026_06_02_145940_add_totem_venta_id_to_vouchers_table', 34),
(52, '2026_06_02_152203_add_index_to_totem_venta_id_on_vouchers_table', 35),
(53, '2026_06_02_152753_add_cliente_contacto_to_totem_ventas_table', 36),
(54, '2026_06_02_160509_add_prestador_to_totem_ventas_table', 37),
(55, '2026_06_03_202850_add_ultimo_ping_to_totems_table', 38),
(56, '2026_06_03_211235_create_campanas_table', 39),
(57, '2026_06_04_050719_add_datos_clinicos_to_totem_ventas_table', 40),
(58, '2026_06_04_050855_add_datos_clinicos_to_vouchers_table', 41),
(59, '2026_06_07_053447_add_cliente_id_to_voucher_mascotas_table', 42),
(60, '2026_06_07_221143_create_cliente_dispositivos_table', 43),
(61, '2026_06_07_221304_create_cliente_autorizaciones_table', 43),
(62, '2026_06_07_235728_create_security_logs_table', 44),
(63, '2026_06_08_011700_add_dueno_hashes_to_voucher_mascotas_table', 45),
(64, '2026_06_10_041207_create_voucher_agendas_table', 46),
(65, '2026_06_10_041232_create_voucher_atenciones_table', 46),
(66, '2026_06_10_041310_add_validacion_atencion_to_vouchers_table', 46),
(67, '2026_06_12_051954_create_pago_autorizacions_table', 47);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago_autorizaciones`
--

CREATE TABLE `pago_autorizaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_liquidacion_id` bigint(20) UNSIGNED DEFAULT NULL,
  `voucher_rendicion_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profesional_id` bigint(20) UNSIGNED DEFAULT NULL,
  `admin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `token` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `ip_solicitud` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_respuesta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expira_at` timestamp NULL DEFAULT NULL,
  `aprobada_at` timestamp NULL DEFAULT NULL,
  `rechazada_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pago_autorizaciones`
--

INSERT INTO `pago_autorizaciones` (`id`, `voucher_liquidacion_id`, `voucher_rendicion_id`, `profesional_id`, `admin_id`, `token`, `estado`, `ip_solicitud`, `ip_respuesta`, `device_id`, `expira_at`, `aprobada_at`, `rechazada_at`, `created_at`, `updated_at`) VALUES
(1, 2, 4, 2, NULL, '73106af0-5dc8-4a1c-be23-219421dddcf4', 'aprobada', '127.0.0.1', '127.0.0.1', 'SAMSUNG-S24', '2026-06-15 09:53:28', '2026-06-14 10:21:51', NULL, '2026-06-14 09:53:28', '2026-06-14 10:21:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `security_logs`
--

CREATE TABLE `security_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cliente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `accion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modelo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelo_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ok',
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `security_logs`
--

INSERT INTO `security_logs` (`id`, `user_id`, `cliente_id`, `accion`, `modelo`, `modelo_id`, `ip`, `device`, `estado`, `detalle`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 'prueba_seguridad', 'Sistema', 1, '127.0.0.1', 'Symfony', 'ok', 'Prueba inicial security log', '2026-06-08 04:10:58', '2026-06-08 04:10:58'),
(2, NULL, 9, 'autorizacion_sensible_aprobada', 'ClienteAutorizacion', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'aprobada', 'Respuesta enviada desde dispositivo autorizado', '2026-06-08 05:02:16', '2026-06-08 05:02:16'),
(3, NULL, 9, 'autorizacion_sensible_aprobada', 'ClienteAutorizacion', 4, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'aprobada', 'Respuesta enviada desde dispositivo autorizado', '2026-06-08 06:29:00', '2026-06-08 06:29:00'),
(4, NULL, 9, 'datos_dueno_visualizados', 'VoucherMascota', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'ok', 'Datos sensibles del dueño visualizados con autorización aprobada', '2026-06-08 06:29:22', '2026-06-08 06:29:22'),
(5, NULL, 9, 'intento_ver_dueno_sin_autorizacion', 'VoucherMascota', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'rechazado', 'Intento de ver datos del dueño sin autorización válida', '2026-06-08 06:32:52', '2026-06-08 06:32:52'),
(6, NULL, 9, 'intento_ver_dueno_sin_autorizacion', 'VoucherMascota', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'rechazado', 'Intento de ver datos del dueño sin autorización válida', '2026-06-08 06:36:34', '2026-06-08 06:36:34'),
(7, NULL, 9, 'voucher_hora_solicitada', 'VoucherAgenda', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'ok', 'Hora solicitada para voucher', '2026-06-10 09:28:02', '2026-06-10 09:28:02'),
(8, NULL, 9, 'voucher_hora_confirmada', 'VoucherAgenda', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'ok', 'Hora confirmada para voucher', '2026-06-10 09:28:26', '2026-06-10 09:28:26'),
(9, NULL, 9, 'voucher_atencion_cerrada', 'VoucherAtencion', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'ok', 'Atención cerrada por profesional', '2026-06-10 11:33:35', '2026-06-10 11:33:35'),
(10, NULL, 9, 'voucher_atencion_validada_asistente', 'VoucherAtencion', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'ok', 'Atención validada por asistente. Riesgo: medio', '2026-06-10 11:57:16', '2026-06-10 11:57:16'),
(11, 23, 9, 'intento_cobro_web_sin_validacion_clinica', 'Voucher', 38, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'rechazado', 'Intento de cobro web sin atención validada', '2026-06-11 02:24:14', '2026-06-11 02:24:14'),
(12, NULL, 9, 'voucher_atencion_validada_asistente', 'VoucherAtencion', 4, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'ok', 'Atención validada por asistente. Riesgo: medio', '2026-06-11 07:22:52', '2026-06-11 07:22:52'),
(13, NULL, 9, 'voucher_atencion_validada_asistente', 'VoucherAtencion', 6, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'ok', 'Atención validada por asistente. Riesgo: medio', '2026-06-11 07:23:15', '2026-06-11 07:23:15'),
(14, NULL, 9, 'voucher_atencion_validada_asistente', 'VoucherAtencion', 7, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'ok', 'Atención validada por asistente. Riesgo: medio', '2026-06-11 07:23:36', '2026-06-11 07:23:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `totems`
--

CREATE TABLE `totems` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubicacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_autorizada` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `version` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ultimo_acceso` timestamp NULL DEFAULT NULL,
  `ultimo_ping` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `totems`
--

INSERT INTO `totems` (`id`, `codigo`, `nombre`, `ubicacion`, `ip_autorizada`, `token`, `activo`, `version`, `serial`, `ultimo_acceso`, `ultimo_ping`, `created_at`, `updated_at`) VALUES
(1, 'TOTEM001', 'VeterChile Concon', 'Concon', NULL, 'Qo62OcQ9K3yy2veVJFj2wFxFCywkVZrD0moA30VwUOBC473CR81wR01kMYi6pab2Cb73ankL2nes00Rw', 1, '1.0.0', NULL, '2026-06-29 08:11:45', '2026-06-29 08:11:45', NULL, '2026-06-29 08:11:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `totem_logs`
--

CREATE TABLE `totem_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `totem_id` bigint(20) UNSIGNED NOT NULL,
  `evento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `totem_logs`
--

INSERT INTO `totem_logs` (`id`, `totem_id`, `evento`, `detalle`, `ip`, `created_at`, `updated_at`) VALUES
(1, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 10:06:05', '2026-06-02 10:06:05'),
(2, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 10:19:50', '2026-06-02 10:19:50'),
(3, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 10:25:12', '2026-06-02 10:25:12'),
(4, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 10:29:26', '2026-06-02 10:29:26'),
(5, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 10:30:39', '2026-06-02 10:30:39'),
(6, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 10:31:10', '2026-06-02 10:31:10'),
(7, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 17:50:06', '2026-06-02 17:50:06'),
(8, 1, 'venta_creada', 'Venta creada desde tótem ID 1', '127.0.0.1', '2026-06-02 17:50:07', '2026-06-02 17:50:07'),
(9, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 17:53:56', '2026-06-02 17:53:56'),
(10, 1, 'venta_creada', 'Venta creada desde tótem ID 2', '127.0.0.1', '2026-06-02 17:53:57', '2026-06-02 17:53:57'),
(11, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 17:54:47', '2026-06-02 17:54:47'),
(12, 1, 'venta_creada', 'Venta creada desde tótem ID 3', '127.0.0.1', '2026-06-02 17:54:47', '2026-06-02 17:54:47'),
(13, 1, 'venta_creada', 'Venta creada desde tótem ID 4', '127.0.0.1', '2026-06-02 18:01:19', '2026-06-02 18:01:19'),
(14, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 18:01:19', '2026-06-02 18:01:19'),
(15, 1, 'pago_confirmado', 'Pago confirmado venta ID 4', '127.0.0.1', '2026-06-02 18:24:48', '2026-06-02 18:24:48'),
(16, 1, 'venta_creada', 'Venta creada desde tótem ID 5', '127.0.0.1', '2026-06-02 18:24:48', '2026-06-02 18:24:48'),
(17, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 18:24:48', '2026-06-02 18:24:48'),
(18, 1, 'venta_creada', 'Venta creada desde tótem ID 6', '127.0.0.1', '2026-06-02 18:28:21', '2026-06-02 18:28:21'),
(19, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 18:28:22', '2026-06-02 18:28:22'),
(20, 1, 'pago_confirmado', 'Pago confirmado venta ID 6 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-02 18:45:21', '2026-06-02 18:45:21'),
(21, 1, 'venta_creada', 'Venta creada desde tótem ID 7', '127.0.0.1', '2026-06-02 18:45:21', '2026-06-02 18:45:21'),
(22, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 18:45:22', '2026-06-02 18:45:22'),
(23, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 6', '127.0.0.1', '2026-06-02 18:58:19', '2026-06-02 18:58:19'),
(24, 1, 'pago_confirmado', 'Pago confirmado venta ID 7 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-02 19:32:50', '2026-06-02 19:32:50'),
(25, 1, 'venta_creada', 'Venta creada desde tótem ID 8', '127.0.0.1', '2026-06-02 19:32:50', '2026-06-02 19:32:50'),
(26, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 19:32:50', '2026-06-02 19:32:50'),
(27, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 19:36:45', '2026-06-02 19:36:45'),
(28, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 19:37:56', '2026-06-02 19:37:56'),
(29, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 19:49:55', '2026-06-02 19:49:55'),
(30, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 19:53:39', '2026-06-02 19:53:39'),
(31, 1, 'pago_confirmado', 'Pago confirmado venta ID 8 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-02 20:15:06', '2026-06-02 20:15:06'),
(32, 1, 'venta_creada', 'Venta creada desde tótem ID 9', '127.0.0.1', '2026-06-02 20:15:06', '2026-06-02 20:15:06'),
(33, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 20:15:06', '2026-06-02 20:15:06'),
(34, 1, 'venta_creada', 'Venta creada desde tótem ID 10', '127.0.0.1', '2026-06-02 20:16:58', '2026-06-02 20:16:58'),
(35, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 20:16:58', '2026-06-02 20:16:58'),
(36, 1, 'pago_confirmado', 'Pago confirmado venta ID 9 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-02 20:17:59', '2026-06-02 20:17:59'),
(37, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 20:25:46', '2026-06-02 20:25:46'),
(38, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 20:26:36', '2026-06-02 20:26:36'),
(39, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 20:27:53', '2026-06-02 20:27:53'),
(40, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 20:40:50', '2026-06-02 20:40:50'),
(41, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 20:56:50', '2026-06-02 20:56:50'),
(42, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 20:58:22', '2026-06-02 20:58:22'),
(43, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 20:58:49', '2026-06-02 20:58:49'),
(44, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 21:02:57', '2026-06-02 21:02:57'),
(45, 1, 'venta_creada', 'Venta creada desde tótem ID 11', '127.0.0.1', '2026-06-02 21:04:36', '2026-06-02 21:04:36'),
(46, 1, 'pago_confirmado', 'Pago confirmado venta ID 11 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-02 21:04:36', '2026-06-02 21:04:36'),
(47, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 11', '127.0.0.1', '2026-06-02 21:04:36', '2026-06-02 21:04:36'),
(48, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 21:12:32', '2026-06-02 21:12:32'),
(49, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-02 21:19:46', '2026-06-02 21:19:46'),
(50, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 05:57:47', '2026-06-03 05:57:47'),
(51, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 21:32:25', '2026-06-03 21:32:25'),
(52, 1, 'venta_creada', 'Venta creada desde tótem ID 12', '127.0.0.1', '2026-06-03 21:33:43', '2026-06-03 21:33:43'),
(53, 1, 'pago_confirmado', 'Pago confirmado venta ID 12 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-03 21:33:43', '2026-06-03 21:33:43'),
(54, 1, 'voucher_entregado', 'Entrega por veterinario venta ID 12', '127.0.0.1', '2026-06-03 21:33:43', '2026-06-03 21:33:43'),
(55, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 21:39:54', '2026-06-03 21:39:54'),
(56, 1, 'venta_creada', 'Venta creada desde tótem ID 13', '127.0.0.1', '2026-06-03 21:40:42', '2026-06-03 21:40:42'),
(57, 1, 'pago_confirmado', 'Pago confirmado venta ID 13 con 0 voucher(s) generado(s)', '127.0.0.1', '2026-06-03 21:40:42', '2026-06-03 21:40:42'),
(58, 1, 'voucher_entregado', 'Entrega por app venta ID 13', '127.0.0.1', '2026-06-03 21:40:42', '2026-06-03 21:40:42'),
(59, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 21:40:58', '2026-06-03 21:40:58'),
(60, 1, 'venta_creada', 'Venta creada desde tótem ID 14', '127.0.0.1', '2026-06-03 21:41:12', '2026-06-03 21:41:12'),
(61, 1, 'pago_confirmado', 'Pago confirmado venta ID 14 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-03 21:41:12', '2026-06-03 21:41:12'),
(62, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 14', '127.0.0.1', '2026-06-03 21:41:12', '2026-06-03 21:41:12'),
(63, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 21:51:59', '2026-06-03 21:51:59'),
(64, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 21:52:16', '2026-06-03 21:52:16'),
(65, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 22:14:20', '2026-06-03 22:14:20'),
(66, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 22:26:46', '2026-06-03 22:26:46'),
(67, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 22:27:36', '2026-06-03 22:27:36'),
(68, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 22:34:29', '2026-06-03 22:34:29'),
(69, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 22:40:38', '2026-06-03 22:40:38'),
(70, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:35:04', '2026-06-03 23:35:04'),
(71, 1, 'venta_creada', 'Venta creada desde tótem ID 15', '127.0.0.1', '2026-06-03 23:35:26', '2026-06-03 23:35:26'),
(72, 1, 'pago_confirmado', 'Pago confirmado venta ID 15 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-03 23:35:27', '2026-06-03 23:35:27'),
(73, 1, 'voucher_entregado', 'Entrega por app venta ID 15', '127.0.0.1', '2026-06-03 23:35:27', '2026-06-03 23:35:27'),
(74, 1, 'venta_creada', 'Venta creada desde tótem ID 16', '127.0.0.1', '2026-06-03 23:35:39', '2026-06-03 23:35:39'),
(75, 1, 'pago_confirmado', 'Pago confirmado venta ID 16 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-03 23:35:39', '2026-06-03 23:35:39'),
(76, 1, 'voucher_entregado', 'Entrega por app venta ID 16', '127.0.0.1', '2026-06-03 23:35:40', '2026-06-03 23:35:40'),
(77, 1, 'venta_creada', 'Venta creada desde tótem ID 17', '127.0.0.1', '2026-06-03 23:35:47', '2026-06-03 23:35:47'),
(78, 1, 'pago_confirmado', 'Pago confirmado venta ID 17 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-03 23:35:47', '2026-06-03 23:35:47'),
(79, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 17', '127.0.0.1', '2026-06-03 23:35:48', '2026-06-03 23:35:48'),
(80, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:36:22', '2026-06-03 23:36:22'),
(81, 1, 'venta_creada', 'Venta creada desde tótem ID 18', '127.0.0.1', '2026-06-03 23:36:37', '2026-06-03 23:36:37'),
(82, 1, 'pago_confirmado', 'Pago confirmado venta ID 18 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-03 23:36:37', '2026-06-03 23:36:37'),
(83, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 18', '127.0.0.1', '2026-06-03 23:36:37', '2026-06-03 23:36:37'),
(84, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:48:46', '2026-06-03 23:48:46'),
(85, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:46', '2026-06-03 23:49:46'),
(86, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:47', '2026-06-03 23:49:47'),
(87, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:47', '2026-06-03 23:49:47'),
(88, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:47', '2026-06-03 23:49:47'),
(89, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:47', '2026-06-03 23:49:47'),
(90, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(91, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(92, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(93, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(94, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(95, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(96, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:50', '2026-06-03 23:49:50'),
(97, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:50', '2026-06-03 23:49:50'),
(98, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:50', '2026-06-03 23:49:50'),
(99, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(100, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(101, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(102, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(103, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(104, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(105, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(106, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:53', '2026-06-03 23:49:53'),
(107, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:53', '2026-06-03 23:49:53'),
(108, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:54', '2026-06-03 23:49:54'),
(109, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:54', '2026-06-03 23:49:54'),
(110, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:54', '2026-06-03 23:49:54'),
(111, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:54', '2026-06-03 23:49:54'),
(112, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:54', '2026-06-03 23:49:54'),
(113, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:55', '2026-06-03 23:49:55'),
(114, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:55', '2026-06-03 23:49:55'),
(115, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:49:55', '2026-06-03 23:49:55'),
(116, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-03 23:59:31', '2026-06-03 23:59:31'),
(117, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:00:01', '2026-06-04 00:00:01'),
(118, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:00:31', '2026-06-04 00:00:31'),
(119, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:00:40', '2026-06-04 00:00:40'),
(120, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:01:10', '2026-06-04 00:01:10'),
(121, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:01:40', '2026-06-04 00:01:40'),
(122, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:02:10', '2026-06-04 00:02:10'),
(123, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:02:40', '2026-06-04 00:02:40'),
(124, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:03:10', '2026-06-04 00:03:10'),
(125, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:03:12', '2026-06-04 00:03:12'),
(126, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:03:40', '2026-06-04 00:03:40'),
(127, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:03:42', '2026-06-04 00:03:42'),
(128, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:04:10', '2026-06-04 00:04:10'),
(129, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:04:38', '2026-06-04 00:04:38'),
(130, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:04:40', '2026-06-04 00:04:40'),
(131, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:04:40', '2026-06-04 00:04:40'),
(132, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:04:41', '2026-06-04 00:04:41'),
(133, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:04:41', '2026-06-04 00:04:41'),
(134, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:05:10', '2026-06-04 00:05:10'),
(135, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:05:39', '2026-06-04 00:05:39'),
(136, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:05:56', '2026-06-04 00:05:56'),
(137, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:06:23', '2026-06-04 00:06:23'),
(138, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:06:40', '2026-06-04 00:06:40'),
(139, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:07:10', '2026-06-04 00:07:10'),
(140, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:07:40', '2026-06-04 00:07:40'),
(141, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:08:56', '2026-06-04 00:08:56'),
(142, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:09:39', '2026-06-04 00:09:39'),
(143, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:10:10', '2026-06-04 00:10:10'),
(144, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:10:40', '2026-06-04 00:10:40'),
(145, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:11:10', '2026-06-04 00:11:10'),
(146, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:11:40', '2026-06-04 00:11:40'),
(147, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:12:56', '2026-06-04 00:12:56'),
(148, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:13:56', '2026-06-04 00:13:56'),
(149, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:14:56', '2026-06-04 00:14:56'),
(150, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:15:56', '2026-06-04 00:15:56'),
(151, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:16:56', '2026-06-04 00:16:56'),
(152, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:17:17', '2026-06-04 00:17:17'),
(153, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:17:40', '2026-06-04 00:17:40'),
(154, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:18:10', '2026-06-04 00:18:10'),
(155, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:18:56', '2026-06-04 00:18:56'),
(156, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:19:56', '2026-06-04 00:19:56'),
(157, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:20:56', '2026-06-04 00:20:56'),
(158, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:21:56', '2026-06-04 00:21:56'),
(159, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:22:56', '2026-06-04 00:22:56'),
(160, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:23:56', '2026-06-04 00:23:56'),
(161, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:24:56', '2026-06-04 00:24:56'),
(162, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:25:56', '2026-06-04 00:25:56'),
(163, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:26:56', '2026-06-04 00:26:56'),
(164, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:27:56', '2026-06-04 00:27:56'),
(165, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:28:56', '2026-06-04 00:28:56'),
(166, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:29:56', '2026-06-04 00:29:56'),
(167, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:30:56', '2026-06-04 00:30:56'),
(168, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:31:56', '2026-06-04 00:31:56'),
(169, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:32:56', '2026-06-04 00:32:56'),
(170, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:33:56', '2026-06-04 00:33:56'),
(171, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:34:56', '2026-06-04 00:34:56'),
(172, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:35:56', '2026-06-04 00:35:56'),
(173, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:36:56', '2026-06-04 00:36:56'),
(174, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:37:56', '2026-06-04 00:37:56'),
(175, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:38:56', '2026-06-04 00:38:56'),
(176, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:39:56', '2026-06-04 00:39:56'),
(177, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:40:56', '2026-06-04 00:40:56'),
(178, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:41:56', '2026-06-04 00:41:56'),
(179, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:42:56', '2026-06-04 00:42:56'),
(180, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:48:56', '2026-06-04 00:48:56'),
(181, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:49:56', '2026-06-04 00:49:56'),
(182, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:50:56', '2026-06-04 00:50:56'),
(183, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:51:56', '2026-06-04 00:51:56'),
(184, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:52:56', '2026-06-04 00:52:56'),
(185, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:53:56', '2026-06-04 00:53:56'),
(186, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:54:56', '2026-06-04 00:54:56'),
(187, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:55:00', '2026-06-04 00:55:00'),
(188, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:55:56', '2026-06-04 00:55:56'),
(189, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:56:56', '2026-06-04 00:56:56'),
(190, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:57:56', '2026-06-04 00:57:56'),
(191, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:58:56', '2026-06-04 00:58:56'),
(192, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 00:59:56', '2026-06-04 00:59:56'),
(193, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:00:56', '2026-06-04 01:00:56'),
(194, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:01:56', '2026-06-04 01:01:56'),
(195, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:02:21', '2026-06-04 01:02:21'),
(196, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:02:56', '2026-06-04 01:02:56'),
(197, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:03:56', '2026-06-04 01:03:56'),
(198, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:04:56', '2026-06-04 01:04:56'),
(199, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:05:56', '2026-06-04 01:05:56'),
(200, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:06:56', '2026-06-04 01:06:56'),
(201, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:07:47', '2026-06-04 01:07:47'),
(202, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:07:56', '2026-06-04 01:07:56'),
(203, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:08:56', '2026-06-04 01:08:56'),
(204, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:09:56', '2026-06-04 01:09:56'),
(205, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:10:56', '2026-06-04 01:10:56'),
(206, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:11:56', '2026-06-04 01:11:56'),
(207, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:12:56', '2026-06-04 01:12:56'),
(208, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:13:56', '2026-06-04 01:13:56'),
(209, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:14:56', '2026-06-04 01:14:56'),
(210, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:15:56', '2026-06-04 01:15:56'),
(211, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:16:56', '2026-06-04 01:16:56'),
(212, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:17:56', '2026-06-04 01:17:56'),
(213, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:18:56', '2026-06-04 01:18:56'),
(214, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:19:56', '2026-06-04 01:19:56'),
(215, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:20:56', '2026-06-04 01:20:56'),
(216, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:21:56', '2026-06-04 01:21:56'),
(217, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:22:56', '2026-06-04 01:22:56'),
(218, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:23:56', '2026-06-04 01:23:56'),
(219, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:24:56', '2026-06-04 01:24:56'),
(220, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:25:56', '2026-06-04 01:25:56'),
(221, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:26:56', '2026-06-04 01:26:56'),
(222, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:27:56', '2026-06-04 01:27:56'),
(223, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:28:56', '2026-06-04 01:28:56'),
(224, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:29:56', '2026-06-04 01:29:56'),
(225, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:30:56', '2026-06-04 01:30:56'),
(226, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:31:56', '2026-06-04 01:31:56'),
(227, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:32:56', '2026-06-04 01:32:56'),
(228, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:33:56', '2026-06-04 01:33:56'),
(229, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:34:56', '2026-06-04 01:34:56'),
(230, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:35:56', '2026-06-04 01:35:56'),
(231, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:36:56', '2026-06-04 01:36:56'),
(232, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:37:56', '2026-06-04 01:37:56'),
(233, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:38:56', '2026-06-04 01:38:56'),
(234, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:39:56', '2026-06-04 01:39:56'),
(235, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:40:56', '2026-06-04 01:40:56'),
(236, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:41:56', '2026-06-04 01:41:56'),
(237, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:42:46', '2026-06-04 01:42:46'),
(238, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:42:56', '2026-06-04 01:42:56'),
(239, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:43:56', '2026-06-04 01:43:56'),
(240, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:44:56', '2026-06-04 01:44:56'),
(241, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:45:56', '2026-06-04 01:45:56'),
(242, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:46:56', '2026-06-04 01:46:56'),
(243, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:47:56', '2026-06-04 01:47:56'),
(244, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:48:24', '2026-06-04 01:48:24'),
(245, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:48:56', '2026-06-04 01:48:56'),
(246, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:49:56', '2026-06-04 01:49:56'),
(247, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:50:56', '2026-06-04 01:50:56'),
(248, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:51:56', '2026-06-04 01:51:56'),
(249, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:52:56', '2026-06-04 01:52:56'),
(250, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:53:56', '2026-06-04 01:53:56'),
(251, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:54:56', '2026-06-04 01:54:56'),
(252, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:55:01', '2026-06-04 01:55:01'),
(253, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:55:56', '2026-06-04 01:55:56'),
(254, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:56:23', '2026-06-04 01:56:23'),
(255, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:56:56', '2026-06-04 01:56:56'),
(256, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:57:56', '2026-06-04 01:57:56'),
(257, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:58:56', '2026-06-04 01:58:56'),
(258, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 01:59:56', '2026-06-04 01:59:56'),
(259, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:00:56', '2026-06-04 02:00:56'),
(260, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:01:56', '2026-06-04 02:01:56'),
(261, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:02:45', '2026-06-04 02:02:45'),
(262, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:02:56', '2026-06-04 02:02:56'),
(263, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:03:56', '2026-06-04 02:03:56'),
(264, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:04:56', '2026-06-04 02:04:56'),
(265, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:05:56', '2026-06-04 02:05:56'),
(266, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:06:56', '2026-06-04 02:06:56'),
(267, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:07:56', '2026-06-04 02:07:56'),
(268, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:08:56', '2026-06-04 02:08:56'),
(269, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:09:11', '2026-06-04 02:09:11'),
(270, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:09:56', '2026-06-04 02:09:56'),
(271, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:10:56', '2026-06-04 02:10:56'),
(272, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:11:56', '2026-06-04 02:11:56'),
(273, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:12:56', '2026-06-04 02:12:56'),
(274, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:13:56', '2026-06-04 02:13:56'),
(275, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:14:56', '2026-06-04 02:14:56'),
(276, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:15:56', '2026-06-04 02:15:56'),
(277, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:16:56', '2026-06-04 02:16:56'),
(278, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:17:57', '2026-06-04 02:17:57'),
(279, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:18:56', '2026-06-04 02:18:56'),
(280, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:19:56', '2026-06-04 02:19:56'),
(281, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:20:56', '2026-06-04 02:20:56'),
(282, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:21:56', '2026-06-04 02:21:56'),
(283, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:22:56', '2026-06-04 02:22:56'),
(284, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:23:56', '2026-06-04 02:23:56'),
(285, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:24:40', '2026-06-04 02:24:40'),
(286, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:24:56', '2026-06-04 02:24:56'),
(287, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:25:56', '2026-06-04 02:25:56'),
(288, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:26:56', '2026-06-04 02:26:56'),
(289, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:27:56', '2026-06-04 02:27:56'),
(290, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:28:56', '2026-06-04 02:28:56'),
(291, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:29:56', '2026-06-04 02:29:56'),
(292, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:30:56', '2026-06-04 02:30:56'),
(293, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:31:56', '2026-06-04 02:31:56'),
(294, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:32:56', '2026-06-04 02:32:56'),
(295, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:33:56', '2026-06-04 02:33:56'),
(296, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:34:56', '2026-06-04 02:34:56'),
(297, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:35:56', '2026-06-04 02:35:56'),
(298, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:36:56', '2026-06-04 02:36:56'),
(299, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:37:56', '2026-06-04 02:37:56'),
(300, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:38:56', '2026-06-04 02:38:56'),
(301, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:39:56', '2026-06-04 02:39:56'),
(302, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:40:56', '2026-06-04 02:40:56'),
(303, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:41:56', '2026-06-04 02:41:56'),
(304, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:42:56', '2026-06-04 02:42:56'),
(305, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:43:56', '2026-06-04 02:43:56'),
(306, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:44:56', '2026-06-04 02:44:56'),
(307, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:45:56', '2026-06-04 02:45:56'),
(308, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:46:56', '2026-06-04 02:46:56'),
(309, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:47:56', '2026-06-04 02:47:56'),
(310, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:48:56', '2026-06-04 02:48:56'),
(311, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:49:56', '2026-06-04 02:49:56'),
(312, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:50:56', '2026-06-04 02:50:56'),
(313, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:51:56', '2026-06-04 02:51:56'),
(314, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:52:56', '2026-06-04 02:52:56'),
(315, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:53:56', '2026-06-04 02:53:56'),
(316, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:54:56', '2026-06-04 02:54:56'),
(317, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:55:56', '2026-06-04 02:55:56'),
(318, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:56:56', '2026-06-04 02:56:56'),
(319, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:57:56', '2026-06-04 02:57:56'),
(320, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:58:56', '2026-06-04 02:58:56'),
(321, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:59:39', '2026-06-04 02:59:39'),
(322, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:59:55', '2026-06-04 02:59:55'),
(323, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:59:56', '2026-06-04 02:59:56'),
(324, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:59:56', '2026-06-04 02:59:56'),
(325, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:59:57', '2026-06-04 02:59:57'),
(326, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:59:57', '2026-06-04 02:59:57'),
(327, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:59:57', '2026-06-04 02:59:57'),
(328, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 02:59:58', '2026-06-04 02:59:58'),
(329, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:00:17', '2026-06-04 03:00:17'),
(330, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:00:40', '2026-06-04 03:00:40'),
(331, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:01:01', '2026-06-04 03:01:01'),
(332, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:01:10', '2026-06-04 03:01:10'),
(333, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:01:40', '2026-06-04 03:01:40'),
(334, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:02:56', '2026-06-04 03:02:56'),
(335, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:03:33', '2026-06-04 03:03:33'),
(336, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:03:40', '2026-06-04 03:03:40'),
(337, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:04:10', '2026-06-04 03:04:10'),
(338, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:04:25', '2026-06-04 03:04:25'),
(339, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:04:27', '2026-06-04 03:04:27'),
(340, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:04:56', '2026-06-04 03:04:56'),
(341, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:05:45', '2026-06-04 03:05:45'),
(342, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:05:50', '2026-06-04 03:05:50'),
(343, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:06:03', '2026-06-04 03:06:03'),
(344, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:06:33', '2026-06-04 03:06:33'),
(345, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:07:03', '2026-06-04 03:07:03'),
(346, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:07:33', '2026-06-04 03:07:33'),
(347, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:08:03', '2026-06-04 03:08:03'),
(348, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:08:33', '2026-06-04 03:08:33'),
(349, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:09:03', '2026-06-04 03:09:03'),
(350, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:09:33', '2026-06-04 03:09:33'),
(351, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:10:56', '2026-06-04 03:10:56'),
(352, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:11:56', '2026-06-04 03:11:56'),
(353, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:12:56', '2026-06-04 03:12:56'),
(354, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:13:56', '2026-06-04 03:13:56'),
(355, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:14:56', '2026-06-04 03:14:56'),
(356, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:15:56', '2026-06-04 03:15:56'),
(357, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:16:56', '2026-06-04 03:16:56'),
(358, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:17:56', '2026-06-04 03:17:56'),
(359, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:18:56', '2026-06-04 03:18:56'),
(360, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:19:56', '2026-06-04 03:19:56'),
(361, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:20:56', '2026-06-04 03:20:56'),
(362, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:21:56', '2026-06-04 03:21:56'),
(363, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:22:56', '2026-06-04 03:22:56'),
(364, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:23:56', '2026-06-04 03:23:56'),
(365, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:24:56', '2026-06-04 03:24:56'),
(366, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:25:56', '2026-06-04 03:25:56'),
(367, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:26:56', '2026-06-04 03:26:56'),
(368, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:27:56', '2026-06-04 03:27:56'),
(369, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:28:56', '2026-06-04 03:28:56'),
(370, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:29:56', '2026-06-04 03:29:56'),
(371, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:30:56', '2026-06-04 03:30:56'),
(372, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:31:56', '2026-06-04 03:31:56'),
(373, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:32:56', '2026-06-04 03:32:56'),
(374, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:33:56', '2026-06-04 03:33:56'),
(375, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:34:01', '2026-06-04 03:34:01'),
(376, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:34:56', '2026-06-04 03:34:56'),
(377, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:35:56', '2026-06-04 03:35:56'),
(378, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:36:56', '2026-06-04 03:36:56'),
(379, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:37:56', '2026-06-04 03:37:56'),
(380, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:38:56', '2026-06-04 03:38:56'),
(381, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:39:56', '2026-06-04 03:39:56'),
(382, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:40:57', '2026-06-04 03:40:57'),
(383, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:41:56', '2026-06-04 03:41:56'),
(384, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:42:56', '2026-06-04 03:42:56'),
(385, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:43:56', '2026-06-04 03:43:56'),
(386, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:44:56', '2026-06-04 03:44:56'),
(387, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:45:56', '2026-06-04 03:45:56'),
(388, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:46:56', '2026-06-04 03:46:56'),
(389, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:47:56', '2026-06-04 03:47:56'),
(390, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:48:56', '2026-06-04 03:48:56'),
(391, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:49:56', '2026-06-04 03:49:56'),
(392, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:50:56', '2026-06-04 03:50:56'),
(393, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:51:56', '2026-06-04 03:51:56'),
(394, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:52:56', '2026-06-04 03:52:56'),
(395, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:53:56', '2026-06-04 03:53:56'),
(396, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:54:56', '2026-06-04 03:54:56'),
(397, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:55:56', '2026-06-04 03:55:56'),
(398, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:56:56', '2026-06-04 03:56:56'),
(399, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:57:56', '2026-06-04 03:57:56'),
(400, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:58:56', '2026-06-04 03:58:56'),
(401, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 03:59:56', '2026-06-04 03:59:56'),
(402, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:00:56', '2026-06-04 04:00:56'),
(403, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:01:56', '2026-06-04 04:01:56'),
(404, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:02:56', '2026-06-04 04:02:56'),
(405, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:03:56', '2026-06-04 04:03:56'),
(406, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:04:56', '2026-06-04 04:04:56'),
(407, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:05:56', '2026-06-04 04:05:56'),
(408, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:06:56', '2026-06-04 04:06:56'),
(409, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:07:56', '2026-06-04 04:07:56'),
(410, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:08:56', '2026-06-04 04:08:56'),
(411, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:09:56', '2026-06-04 04:09:56'),
(412, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:10:45', '2026-06-04 04:10:45'),
(413, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:10:46', '2026-06-04 04:10:46'),
(414, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:10:56', '2026-06-04 04:10:56'),
(415, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:11:56', '2026-06-04 04:11:56'),
(416, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:12:56', '2026-06-04 04:12:56'),
(417, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:13:56', '2026-06-04 04:13:56'),
(418, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:14:56', '2026-06-04 04:14:56'),
(419, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:15:56', '2026-06-04 04:15:56'),
(420, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:16:56', '2026-06-04 04:16:56'),
(421, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:17:56', '2026-06-04 04:17:56'),
(422, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:18:56', '2026-06-04 04:18:56'),
(423, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:19:56', '2026-06-04 04:19:56'),
(424, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:20:56', '2026-06-04 04:20:56'),
(425, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:21:56', '2026-06-04 04:21:56'),
(426, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:22:56', '2026-06-04 04:22:56'),
(427, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:23:56', '2026-06-04 04:23:56'),
(428, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:24:56', '2026-06-04 04:24:56'),
(429, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:25:56', '2026-06-04 04:25:56'),
(430, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:26:56', '2026-06-04 04:26:56'),
(431, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:27:56', '2026-06-04 04:27:56'),
(432, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:28:56', '2026-06-04 04:28:56'),
(433, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:29:56', '2026-06-04 04:29:56'),
(434, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:30:56', '2026-06-04 04:30:56'),
(435, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:31:56', '2026-06-04 04:31:56'),
(436, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:32:56', '2026-06-04 04:32:56'),
(437, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:33:56', '2026-06-04 04:33:56'),
(438, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:34:56', '2026-06-04 04:34:56'),
(439, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:35:56', '2026-06-04 04:35:56'),
(440, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:36:56', '2026-06-04 04:36:56'),
(441, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:38:40', '2026-06-04 04:38:40'),
(442, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:38:41', '2026-06-04 04:38:41'),
(443, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:38:56', '2026-06-04 04:38:56'),
(444, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:39:56', '2026-06-04 04:39:56'),
(445, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:39:57', '2026-06-04 04:39:57'),
(446, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 04:40:56', '2026-06-04 04:40:56'),
(447, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:02:56', '2026-06-04 05:02:56'),
(448, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:02:56', '2026-06-04 05:02:56'),
(449, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:02:58', '2026-06-04 05:02:58'),
(450, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:03:56', '2026-06-04 05:03:56'),
(451, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:04:56', '2026-06-04 05:04:56'),
(452, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:05:32', '2026-06-04 05:05:32'),
(453, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:05:56', '2026-06-04 05:05:56'),
(454, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:06:56', '2026-06-04 05:06:56'),
(455, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:07:56', '2026-06-04 05:07:56'),
(456, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:08:56', '2026-06-04 05:08:56'),
(457, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:09:15', '2026-06-04 05:09:15'),
(458, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:09:17', '2026-06-04 05:09:17'),
(459, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:09:18', '2026-06-04 05:09:18'),
(460, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:09:26', '2026-06-04 05:09:26'),
(461, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:09:27', '2026-06-04 05:09:27'),
(462, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:09:56', '2026-06-04 05:09:56'),
(463, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:10:56', '2026-06-04 05:10:56'),
(464, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:11:56', '2026-06-04 05:11:56'),
(465, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:12:56', '2026-06-04 05:12:56'),
(466, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:13:56', '2026-06-04 05:13:56'),
(467, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:14:56', '2026-06-04 05:14:56'),
(468, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:15:56', '2026-06-04 05:15:56'),
(469, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:16:56', '2026-06-04 05:16:56'),
(470, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:17:56', '2026-06-04 05:17:56'),
(471, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:18:41', '2026-06-04 05:18:41'),
(472, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:18:42', '2026-06-04 05:18:42'),
(473, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:18:43', '2026-06-04 05:18:43'),
(474, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:18:56', '2026-06-04 05:18:56'),
(475, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:19:35', '2026-06-04 05:19:35'),
(476, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:19:56', '2026-06-04 05:19:56');
INSERT INTO `totem_logs` (`id`, `totem_id`, `evento`, `detalle`, `ip`, `created_at`, `updated_at`) VALUES
(477, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:20:56', '2026-06-04 05:20:56'),
(478, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:21:56', '2026-06-04 05:21:56'),
(479, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:22:56', '2026-06-04 05:22:56'),
(480, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:23:56', '2026-06-04 05:23:56'),
(481, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:24:56', '2026-06-04 05:24:56'),
(482, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:25:56', '2026-06-04 05:25:56'),
(483, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:26:56', '2026-06-04 05:26:56'),
(484, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:27:56', '2026-06-04 05:27:56'),
(485, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:28:56', '2026-06-04 05:28:56'),
(486, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:29:56', '2026-06-04 05:29:56'),
(487, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:30:56', '2026-06-04 05:30:56'),
(488, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:31:56', '2026-06-04 05:31:56'),
(489, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:32:56', '2026-06-04 05:32:56'),
(490, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:33:56', '2026-06-04 05:33:56'),
(491, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:34:56', '2026-06-04 05:34:56'),
(492, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:35:56', '2026-06-04 05:35:56'),
(493, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:36:56', '2026-06-04 05:36:56'),
(494, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:37:56', '2026-06-04 05:37:56'),
(495, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:38:56', '2026-06-04 05:38:56'),
(496, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:39:56', '2026-06-04 05:39:56'),
(497, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:40:56', '2026-06-04 05:40:56'),
(498, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:41:56', '2026-06-04 05:41:56'),
(499, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:42:56', '2026-06-04 05:42:56'),
(500, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:43:56', '2026-06-04 05:43:56'),
(501, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:44:56', '2026-06-04 05:44:56'),
(502, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:45:56', '2026-06-04 05:45:56'),
(503, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:46:56', '2026-06-04 05:46:56'),
(504, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:47:56', '2026-06-04 05:47:56'),
(505, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:48:56', '2026-06-04 05:48:56'),
(506, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:49:56', '2026-06-04 05:49:56'),
(507, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:50:56', '2026-06-04 05:50:56'),
(508, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:51:56', '2026-06-04 05:51:56'),
(509, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 05:52:56', '2026-06-04 05:52:56'),
(510, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:50:21', '2026-06-04 06:50:21'),
(511, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:50:56', '2026-06-04 06:50:56'),
(512, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:51:56', '2026-06-04 06:51:56'),
(513, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:52:56', '2026-06-04 06:52:56'),
(514, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:53:56', '2026-06-04 06:53:56'),
(515, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:54:19', '2026-06-04 06:54:19'),
(516, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:54:56', '2026-06-04 06:54:56'),
(517, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:55:08', '2026-06-04 06:55:08'),
(518, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:55:22', '2026-06-04 06:55:22'),
(519, 1, 'venta_creada', 'Venta creada desde tótem ID 19', '127.0.0.1', '2026-06-04 06:55:53', '2026-06-04 06:55:53'),
(520, 1, 'pago_confirmado', 'Pago confirmado venta ID 19 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-04 06:55:53', '2026-06-04 06:55:53'),
(521, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 19', '127.0.0.1', '2026-06-04 06:55:54', '2026-06-04 06:55:54'),
(522, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:55:56', '2026-06-04 06:55:56'),
(523, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:56:56', '2026-06-04 06:56:56'),
(524, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:57:56', '2026-06-04 06:57:56'),
(525, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:58:56', '2026-06-04 06:58:56'),
(526, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 06:59:56', '2026-06-04 06:59:56'),
(527, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:00:56', '2026-06-04 07:00:56'),
(528, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:01:56', '2026-06-04 07:01:56'),
(529, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:02:56', '2026-06-04 07:02:56'),
(530, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:03:56', '2026-06-04 07:03:56'),
(531, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:04:56', '2026-06-04 07:04:56'),
(532, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:05:56', '2026-06-04 07:05:56'),
(533, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:06:56', '2026-06-04 07:06:56'),
(534, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:07:56', '2026-06-04 07:07:56'),
(535, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:08:56', '2026-06-04 07:08:56'),
(536, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:09:56', '2026-06-04 07:09:56'),
(537, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:10:56', '2026-06-04 07:10:56'),
(538, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:11:56', '2026-06-04 07:11:56'),
(539, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:12:56', '2026-06-04 07:12:56'),
(540, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:13:55', '2026-06-04 07:13:55'),
(541, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:13:56', '2026-06-04 07:13:56'),
(542, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:14:33', '2026-06-04 07:14:33'),
(543, 1, 'venta_creada', 'Venta creada desde tótem ID 20', '127.0.0.1', '2026-06-04 07:14:45', '2026-06-04 07:14:45'),
(544, 1, 'pago_confirmado', 'Pago confirmado venta ID 20 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-04 07:14:46', '2026-06-04 07:14:46'),
(545, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 20', '127.0.0.1', '2026-06-04 07:14:46', '2026-06-04 07:14:46'),
(546, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:14:56', '2026-06-04 07:14:56'),
(547, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:15:43', '2026-06-04 07:15:43'),
(548, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:15:56', '2026-06-04 07:15:56'),
(549, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:16:56', '2026-06-04 07:16:56'),
(550, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:17:56', '2026-06-04 07:17:56'),
(551, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:18:04', '2026-06-04 07:18:04'),
(552, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:18:19', '2026-06-04 07:18:19'),
(553, 1, 'venta_creada', 'Venta creada desde tótem ID 21', '127.0.0.1', '2026-06-04 07:18:44', '2026-06-04 07:18:44'),
(554, 1, 'pago_confirmado', 'Pago confirmado venta ID 21 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-04 07:18:44', '2026-06-04 07:18:44'),
(555, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 21', '127.0.0.1', '2026-06-04 07:18:44', '2026-06-04 07:18:44'),
(556, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:18:56', '2026-06-04 07:18:56'),
(557, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:19:27', '2026-06-04 07:19:27'),
(558, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:19:31', '2026-06-04 07:19:31'),
(559, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:20:02', '2026-06-04 07:20:02'),
(560, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:20:08', '2026-06-04 07:20:08'),
(561, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:20:32', '2026-06-04 07:20:32'),
(562, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:21:02', '2026-06-04 07:21:02'),
(563, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:21:32', '2026-06-04 07:21:32'),
(564, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:22:02', '2026-06-04 07:22:02'),
(565, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:22:27', '2026-06-04 07:22:27'),
(566, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:22:32', '2026-06-04 07:22:32'),
(567, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:23:56', '2026-06-04 07:23:56'),
(568, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:24:56', '2026-06-04 07:24:56'),
(569, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:25:53', '2026-06-04 07:25:53'),
(570, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:25:56', '2026-06-04 07:25:56'),
(571, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:26:08', '2026-06-04 07:26:08'),
(572, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:26:26', '2026-06-04 07:26:26'),
(573, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:26:56', '2026-06-04 07:26:56'),
(574, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:27:56', '2026-06-04 07:27:56'),
(575, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:28:56', '2026-06-04 07:28:56'),
(576, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:29:56', '2026-06-04 07:29:56'),
(577, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:30:28', '2026-06-04 07:30:28'),
(578, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:30:56', '2026-06-04 07:30:56'),
(579, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:31:56', '2026-06-04 07:31:56'),
(580, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:32:56', '2026-06-04 07:32:56'),
(581, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:33:28', '2026-06-04 07:33:28'),
(582, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:33:56', '2026-06-04 07:33:56'),
(583, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:34:56', '2026-06-04 07:34:56'),
(584, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:35:56', '2026-06-04 07:35:56'),
(585, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:36:56', '2026-06-04 07:36:56'),
(586, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:37:56', '2026-06-04 07:37:56'),
(587, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:38:56', '2026-06-04 07:38:56'),
(588, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:39:56', '2026-06-04 07:39:56'),
(589, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:40:56', '2026-06-04 07:40:56'),
(590, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:41:56', '2026-06-04 07:41:56'),
(591, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:42:56', '2026-06-04 07:42:56'),
(592, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:43:56', '2026-06-04 07:43:56'),
(593, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:44:36', '2026-06-04 07:44:36'),
(594, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:44:56', '2026-06-04 07:44:56'),
(595, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:45:56', '2026-06-04 07:45:56'),
(596, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:46:56', '2026-06-04 07:46:56'),
(597, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:47:38', '2026-06-04 07:47:38'),
(598, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:47:56', '2026-06-04 07:47:56'),
(599, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:48:56', '2026-06-04 07:48:56'),
(600, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:49:56', '2026-06-04 07:49:56'),
(601, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:50:56', '2026-06-04 07:50:56'),
(602, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:51:56', '2026-06-04 07:51:56'),
(603, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:52:19', '2026-06-04 07:52:19'),
(604, 1, 'venta_creada', 'Venta creada desde tótem ID 22', '127.0.0.1', '2026-06-04 07:52:51', '2026-06-04 07:52:51'),
(605, 1, 'pago_confirmado', 'Pago confirmado venta ID 22 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-04 07:52:51', '2026-06-04 07:52:51'),
(606, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 22', '127.0.0.1', '2026-06-04 07:52:51', '2026-06-04 07:52:51'),
(607, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:52:56', '2026-06-04 07:52:56'),
(608, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:53:56', '2026-06-04 07:53:56'),
(609, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:54:56', '2026-06-04 07:54:56'),
(610, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:55:56', '2026-06-04 07:55:56'),
(611, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:56:56', '2026-06-04 07:56:56'),
(612, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:57:56', '2026-06-04 07:57:56'),
(613, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:58:56', '2026-06-04 07:58:56'),
(614, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 07:59:56', '2026-06-04 07:59:56'),
(615, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:00:56', '2026-06-04 08:00:56'),
(616, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:01:56', '2026-06-04 08:01:56'),
(617, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:02:56', '2026-06-04 08:02:56'),
(618, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:03:56', '2026-06-04 08:03:56'),
(619, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:04:56', '2026-06-04 08:04:56'),
(620, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:05:56', '2026-06-04 08:05:56'),
(621, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:06:56', '2026-06-04 08:06:56'),
(622, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:07:56', '2026-06-04 08:07:56'),
(623, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:08:56', '2026-06-04 08:08:56'),
(624, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:09:56', '2026-06-04 08:09:56'),
(625, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:10:56', '2026-06-04 08:10:56'),
(626, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:11:56', '2026-06-04 08:11:56'),
(627, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:12:56', '2026-06-04 08:12:56'),
(628, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:13:56', '2026-06-04 08:13:56'),
(629, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:14:56', '2026-06-04 08:14:56'),
(630, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:15:56', '2026-06-04 08:15:56'),
(631, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:16:56', '2026-06-04 08:16:56'),
(632, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:17:56', '2026-06-04 08:17:56'),
(633, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:18:56', '2026-06-04 08:18:56'),
(634, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:19:56', '2026-06-04 08:19:56'),
(635, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:21:04', '2026-06-04 08:21:04'),
(636, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:21:56', '2026-06-04 08:21:56'),
(637, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:22:56', '2026-06-04 08:22:56'),
(638, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:23:56', '2026-06-04 08:23:56'),
(639, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:24:56', '2026-06-04 08:24:56'),
(640, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:25:56', '2026-06-04 08:25:56'),
(641, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:26:56', '2026-06-04 08:26:56'),
(642, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:27:56', '2026-06-04 08:27:56'),
(643, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:28:56', '2026-06-04 08:28:56'),
(644, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:29:56', '2026-06-04 08:29:56'),
(645, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:30:56', '2026-06-04 08:30:56'),
(646, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:31:56', '2026-06-04 08:31:56'),
(647, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:32:56', '2026-06-04 08:32:56'),
(648, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:33:56', '2026-06-04 08:33:56'),
(649, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:34:56', '2026-06-04 08:34:56'),
(650, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:35:56', '2026-06-04 08:35:56'),
(651, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:36:56', '2026-06-04 08:36:56'),
(652, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:37:56', '2026-06-04 08:37:56'),
(653, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:38:56', '2026-06-04 08:38:56'),
(654, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:39:56', '2026-06-04 08:39:56'),
(655, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:40:56', '2026-06-04 08:40:56'),
(656, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:41:56', '2026-06-04 08:41:56'),
(657, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:42:56', '2026-06-04 08:42:56'),
(658, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:43:56', '2026-06-04 08:43:56'),
(659, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:44:56', '2026-06-04 08:44:56'),
(660, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:45:56', '2026-06-04 08:45:56'),
(661, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:46:56', '2026-06-04 08:46:56'),
(662, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:47:56', '2026-06-04 08:47:56'),
(663, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:48:56', '2026-06-04 08:48:56'),
(664, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:49:56', '2026-06-04 08:49:56'),
(665, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:50:56', '2026-06-04 08:50:56'),
(666, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:51:56', '2026-06-04 08:51:56'),
(667, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:52:56', '2026-06-04 08:52:56'),
(668, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:53:56', '2026-06-04 08:53:56'),
(669, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:54:56', '2026-06-04 08:54:56'),
(670, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:55:56', '2026-06-04 08:55:56'),
(671, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:56:56', '2026-06-04 08:56:56'),
(672, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:57:56', '2026-06-04 08:57:56'),
(673, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:58:56', '2026-06-04 08:58:56'),
(674, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 08:59:56', '2026-06-04 08:59:56'),
(675, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:00:56', '2026-06-04 09:00:56'),
(676, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:01:56', '2026-06-04 09:01:56'),
(677, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:02:56', '2026-06-04 09:02:56'),
(678, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:03:56', '2026-06-04 09:03:56'),
(679, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:04:56', '2026-06-04 09:04:56'),
(680, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:05:56', '2026-06-04 09:05:56'),
(681, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:06:56', '2026-06-04 09:06:56'),
(682, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:07:56', '2026-06-04 09:07:56'),
(683, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:08:56', '2026-06-04 09:08:56'),
(684, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:09:56', '2026-06-04 09:09:56'),
(685, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:10:56', '2026-06-04 09:10:56'),
(686, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:11:56', '2026-06-04 09:11:56'),
(687, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:12:56', '2026-06-04 09:12:56'),
(688, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:13:56', '2026-06-04 09:13:56'),
(689, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:14:56', '2026-06-04 09:14:56'),
(690, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:15:56', '2026-06-04 09:15:56'),
(691, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:16:56', '2026-06-04 09:16:56'),
(692, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:17:56', '2026-06-04 09:17:56'),
(693, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:18:56', '2026-06-04 09:18:56'),
(694, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:19:56', '2026-06-04 09:19:56'),
(695, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:20:56', '2026-06-04 09:20:56'),
(696, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:21:56', '2026-06-04 09:21:56'),
(697, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:22:56', '2026-06-04 09:22:56'),
(698, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:23:56', '2026-06-04 09:23:56'),
(699, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:24:56', '2026-06-04 09:24:56'),
(700, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:25:56', '2026-06-04 09:25:56'),
(701, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:26:56', '2026-06-04 09:26:56'),
(702, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:27:56', '2026-06-04 09:27:56'),
(703, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:28:56', '2026-06-04 09:28:56'),
(704, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:29:56', '2026-06-04 09:29:56'),
(705, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:30:56', '2026-06-04 09:30:56'),
(706, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:31:56', '2026-06-04 09:31:56'),
(707, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:32:56', '2026-06-04 09:32:56'),
(708, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:33:56', '2026-06-04 09:33:56'),
(709, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:34:56', '2026-06-04 09:34:56'),
(710, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:35:56', '2026-06-04 09:35:56'),
(711, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:36:56', '2026-06-04 09:36:56'),
(712, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:37:56', '2026-06-04 09:37:56'),
(713, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:38:56', '2026-06-04 09:38:56'),
(714, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:39:56', '2026-06-04 09:39:56'),
(715, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:40:56', '2026-06-04 09:40:56'),
(716, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:41:56', '2026-06-04 09:41:56'),
(717, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:42:56', '2026-06-04 09:42:56'),
(718, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:43:56', '2026-06-04 09:43:56'),
(719, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:44:56', '2026-06-04 09:44:56'),
(720, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:45:56', '2026-06-04 09:45:56'),
(721, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:46:56', '2026-06-04 09:46:56'),
(722, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:47:56', '2026-06-04 09:47:56'),
(723, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:48:56', '2026-06-04 09:48:56'),
(724, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:49:56', '2026-06-04 09:49:56'),
(725, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:50:56', '2026-06-04 09:50:56'),
(726, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:51:56', '2026-06-04 09:51:56'),
(727, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:52:56', '2026-06-04 09:52:56'),
(728, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:53:56', '2026-06-04 09:53:56'),
(729, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:54:56', '2026-06-04 09:54:56'),
(730, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:55:56', '2026-06-04 09:55:56'),
(731, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:56:56', '2026-06-04 09:56:56'),
(732, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:57:56', '2026-06-04 09:57:56'),
(733, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:58:56', '2026-06-04 09:58:56'),
(734, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 09:59:56', '2026-06-04 09:59:56'),
(735, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:00:56', '2026-06-04 10:00:56'),
(736, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:01:56', '2026-06-04 10:01:56'),
(737, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:02:56', '2026-06-04 10:02:56'),
(738, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:03:56', '2026-06-04 10:03:56'),
(739, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:04:56', '2026-06-04 10:04:56'),
(740, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:05:56', '2026-06-04 10:05:56'),
(741, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:06:56', '2026-06-04 10:06:56'),
(742, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:07:56', '2026-06-04 10:07:56'),
(743, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:08:56', '2026-06-04 10:08:56'),
(744, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:09:56', '2026-06-04 10:09:56'),
(745, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:10:56', '2026-06-04 10:10:56'),
(746, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:11:56', '2026-06-04 10:11:56'),
(747, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:12:56', '2026-06-04 10:12:56'),
(748, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:13:56', '2026-06-04 10:13:56'),
(749, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:14:56', '2026-06-04 10:14:56'),
(750, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:15:56', '2026-06-04 10:15:56'),
(751, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:16:56', '2026-06-04 10:16:56'),
(752, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:17:56', '2026-06-04 10:17:56'),
(753, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:18:56', '2026-06-04 10:18:56'),
(754, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:19:56', '2026-06-04 10:19:56'),
(755, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:20:56', '2026-06-04 10:20:56'),
(756, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:21:56', '2026-06-04 10:21:56'),
(757, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:22:56', '2026-06-04 10:22:56'),
(758, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:23:56', '2026-06-04 10:23:56'),
(759, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:24:56', '2026-06-04 10:24:56'),
(760, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:25:56', '2026-06-04 10:25:56'),
(761, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:26:56', '2026-06-04 10:26:56'),
(762, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:27:56', '2026-06-04 10:27:56'),
(763, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:28:56', '2026-06-04 10:28:56'),
(764, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:29:56', '2026-06-04 10:29:56'),
(765, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:30:56', '2026-06-04 10:30:56'),
(766, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:31:56', '2026-06-04 10:31:56'),
(767, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:32:56', '2026-06-04 10:32:56'),
(768, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:33:56', '2026-06-04 10:33:56'),
(769, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:34:56', '2026-06-04 10:34:56'),
(770, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:35:56', '2026-06-04 10:35:56'),
(771, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:36:56', '2026-06-04 10:36:56'),
(772, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:37:56', '2026-06-04 10:37:56'),
(773, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:38:56', '2026-06-04 10:38:56'),
(774, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:39:41', '2026-06-04 10:39:41'),
(775, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:39:56', '2026-06-04 10:39:56'),
(776, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:40:56', '2026-06-04 10:40:56'),
(777, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:41:58', '2026-06-04 10:41:58'),
(778, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:42:56', '2026-06-04 10:42:56'),
(779, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:43:56', '2026-06-04 10:43:56'),
(780, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:44:56', '2026-06-04 10:44:56'),
(781, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:45:56', '2026-06-04 10:45:56'),
(782, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:46:56', '2026-06-04 10:46:56'),
(783, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:47:56', '2026-06-04 10:47:56'),
(784, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:48:56', '2026-06-04 10:48:56'),
(785, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:49:56', '2026-06-04 10:49:56'),
(786, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:50:56', '2026-06-04 10:50:56'),
(787, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:51:56', '2026-06-04 10:51:56'),
(788, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:52:56', '2026-06-04 10:52:56'),
(789, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:53:56', '2026-06-04 10:53:56'),
(790, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:54:34', '2026-06-04 10:54:34'),
(791, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:54:56', '2026-06-04 10:54:56'),
(792, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:55:56', '2026-06-04 10:55:56'),
(793, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:56:56', '2026-06-04 10:56:56'),
(794, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:57:56', '2026-06-04 10:57:56'),
(795, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:58:56', '2026-06-04 10:58:56'),
(796, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 10:59:56', '2026-06-04 10:59:56'),
(797, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:00:56', '2026-06-04 11:00:56'),
(798, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:01:56', '2026-06-04 11:01:56'),
(799, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:02:56', '2026-06-04 11:02:56'),
(800, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:03:56', '2026-06-04 11:03:56'),
(801, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:04:56', '2026-06-04 11:04:56'),
(802, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:05:56', '2026-06-04 11:05:56'),
(803, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:06:56', '2026-06-04 11:06:56'),
(804, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:07:51', '2026-06-04 11:07:51'),
(805, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:07:56', '2026-06-04 11:07:56'),
(806, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:08:56', '2026-06-04 11:08:56'),
(807, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:09:56', '2026-06-04 11:09:56'),
(808, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:10:56', '2026-06-04 11:10:56'),
(809, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:11:56', '2026-06-04 11:11:56'),
(810, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:12:56', '2026-06-04 11:12:56'),
(811, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:13:56', '2026-06-04 11:13:56'),
(812, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:14:56', '2026-06-04 11:14:56'),
(813, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:15:56', '2026-06-04 11:15:56'),
(814, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:16:56', '2026-06-04 11:16:56'),
(815, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:17:56', '2026-06-04 11:17:56'),
(816, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:18:56', '2026-06-04 11:18:56'),
(817, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:19:56', '2026-06-04 11:19:56'),
(818, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:20:56', '2026-06-04 11:20:56'),
(819, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:21:56', '2026-06-04 11:21:56'),
(820, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:22:56', '2026-06-04 11:22:56'),
(821, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:23:56', '2026-06-04 11:23:56'),
(822, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:24:56', '2026-06-04 11:24:56'),
(823, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:25:56', '2026-06-04 11:25:56'),
(824, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:26:56', '2026-06-04 11:26:56'),
(825, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:27:56', '2026-06-04 11:27:56'),
(826, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:28:56', '2026-06-04 11:28:56'),
(827, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:29:56', '2026-06-04 11:29:56'),
(828, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:30:56', '2026-06-04 11:30:56'),
(829, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:31:56', '2026-06-04 11:31:56'),
(830, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:32:56', '2026-06-04 11:32:56'),
(831, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:33:56', '2026-06-04 11:33:56'),
(832, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:34:56', '2026-06-04 11:34:56'),
(833, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:35:58', '2026-06-04 11:35:58'),
(834, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:36:56', '2026-06-04 11:36:56'),
(835, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:37:56', '2026-06-04 11:37:56'),
(836, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:38:56', '2026-06-04 11:38:56'),
(837, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:39:53', '2026-06-04 11:39:53'),
(838, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:39:56', '2026-06-04 11:39:56'),
(839, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:40:44', '2026-06-04 11:40:44'),
(840, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:40:56', '2026-06-04 11:40:56'),
(841, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:41:34', '2026-06-04 11:41:34'),
(842, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:41:36', '2026-06-04 11:41:36'),
(843, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:41:56', '2026-06-04 11:41:56'),
(844, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:42:56', '2026-06-04 11:42:56'),
(845, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:43:56', '2026-06-04 11:43:56'),
(846, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:44:56', '2026-06-04 11:44:56'),
(847, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:45:56', '2026-06-04 11:45:56'),
(848, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:46:56', '2026-06-04 11:46:56'),
(849, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:47:56', '2026-06-04 11:47:56'),
(850, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:48:56', '2026-06-04 11:48:56'),
(851, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:49:56', '2026-06-04 11:49:56'),
(852, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:50:56', '2026-06-04 11:50:56'),
(853, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:51:56', '2026-06-04 11:51:56'),
(854, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:52:56', '2026-06-04 11:52:56'),
(855, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:53:56', '2026-06-04 11:53:56'),
(856, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:54:56', '2026-06-04 11:54:56'),
(857, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:55:56', '2026-06-04 11:55:56'),
(858, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:56:56', '2026-06-04 11:56:56'),
(859, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:57:56', '2026-06-04 11:57:56'),
(860, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:58:56', '2026-06-04 11:58:56'),
(861, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 11:59:56', '2026-06-04 11:59:56'),
(862, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:00:40', '2026-06-04 12:00:40'),
(863, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:00:56', '2026-06-04 12:00:56'),
(864, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:01:56', '2026-06-04 12:01:56'),
(865, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:02:56', '2026-06-04 12:02:56'),
(866, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:03:56', '2026-06-04 12:03:56'),
(867, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:04:56', '2026-06-04 12:04:56'),
(868, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:05:56', '2026-06-04 12:05:56'),
(869, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:06:56', '2026-06-04 12:06:56'),
(870, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:07:56', '2026-06-04 12:07:56'),
(871, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:08:56', '2026-06-04 12:08:56'),
(872, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:09:56', '2026-06-04 12:09:56'),
(873, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:10:56', '2026-06-04 12:10:56'),
(874, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:11:56', '2026-06-04 12:11:56'),
(875, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:12:56', '2026-06-04 12:12:56'),
(876, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:13:56', '2026-06-04 12:13:56'),
(877, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:14:56', '2026-06-04 12:14:56'),
(878, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:15:56', '2026-06-04 12:15:56'),
(879, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:16:56', '2026-06-04 12:16:56'),
(880, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:17:56', '2026-06-04 12:17:56'),
(881, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:18:56', '2026-06-04 12:18:56'),
(882, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:19:08', '2026-06-04 12:19:08'),
(883, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:19:56', '2026-06-04 12:19:56'),
(884, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:20:56', '2026-06-04 12:20:56'),
(885, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:21:16', '2026-06-04 12:21:16'),
(886, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:21:56', '2026-06-04 12:21:56'),
(887, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:22:56', '2026-06-04 12:22:56'),
(888, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:23:56', '2026-06-04 12:23:56'),
(889, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:24:56', '2026-06-04 12:24:56'),
(890, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:25:56', '2026-06-04 12:25:56'),
(891, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:26:56', '2026-06-04 12:26:56'),
(892, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:27:56', '2026-06-04 12:27:56'),
(893, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:28:56', '2026-06-04 12:28:56'),
(894, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:29:46', '2026-06-04 12:29:46'),
(895, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:29:56', '2026-06-04 12:29:56'),
(896, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:30:20', '2026-06-04 12:30:20'),
(897, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:30:56', '2026-06-04 12:30:56'),
(898, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:31:09', '2026-06-04 12:31:09'),
(899, 1, 'venta_creada', 'Venta creada desde tótem ID 23', '127.0.0.1', '2026-06-04 12:31:43', '2026-06-04 12:31:43'),
(900, 1, 'pago_confirmado', 'Pago confirmado venta ID 23 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-04 12:31:43', '2026-06-04 12:31:43'),
(901, 1, 'voucher_entregado', 'Entrega por app venta ID 23', '127.0.0.1', '2026-06-04 12:31:43', '2026-06-04 12:31:43'),
(902, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:31:56', '2026-06-04 12:31:56'),
(903, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:32:56', '2026-06-04 12:32:56'),
(904, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:33:56', '2026-06-04 12:33:56'),
(905, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:34:56', '2026-06-04 12:34:56'),
(906, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:35:56', '2026-06-04 12:35:56'),
(907, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:36:56', '2026-06-04 12:36:56'),
(908, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:37:56', '2026-06-04 12:37:56'),
(909, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:38:56', '2026-06-04 12:38:56'),
(910, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:39:56', '2026-06-04 12:39:56'),
(911, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:40:56', '2026-06-04 12:40:56'),
(912, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:41:56', '2026-06-04 12:41:56'),
(913, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:42:56', '2026-06-04 12:42:56'),
(914, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:43:56', '2026-06-04 12:43:56'),
(915, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:44:56', '2026-06-04 12:44:56'),
(916, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:45:56', '2026-06-04 12:45:56'),
(917, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:46:56', '2026-06-04 12:46:56'),
(918, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:47:56', '2026-06-04 12:47:56'),
(919, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:48:56', '2026-06-04 12:48:56'),
(920, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:49:56', '2026-06-04 12:49:56'),
(921, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:50:56', '2026-06-04 12:50:56'),
(922, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:51:56', '2026-06-04 12:51:56'),
(923, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:52:56', '2026-06-04 12:52:56'),
(924, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:53:56', '2026-06-04 12:53:56'),
(925, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:54:56', '2026-06-04 12:54:56'),
(926, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:55:56', '2026-06-04 12:55:56'),
(927, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:56:56', '2026-06-04 12:56:56'),
(928, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:57:56', '2026-06-04 12:57:56'),
(929, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:58:56', '2026-06-04 12:58:56'),
(930, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 12:59:56', '2026-06-04 12:59:56'),
(931, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 13:00:56', '2026-06-04 13:00:56'),
(932, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 13:01:56', '2026-06-04 13:01:56'),
(933, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 13:02:56', '2026-06-04 13:02:56'),
(934, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:09:35', '2026-06-04 21:09:35'),
(935, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:10:56', '2026-06-04 21:10:56'),
(936, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:11:56', '2026-06-04 21:11:56'),
(937, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:12:56', '2026-06-04 21:12:56'),
(938, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:13:56', '2026-06-04 21:13:56'),
(939, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:14:56', '2026-06-04 21:14:56'),
(940, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:15:56', '2026-06-04 21:15:56'),
(941, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:16:56', '2026-06-04 21:16:56'),
(942, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:17:56', '2026-06-04 21:17:56'),
(943, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:18:56', '2026-06-04 21:18:56'),
(944, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:19:56', '2026-06-04 21:19:56'),
(945, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:20:56', '2026-06-04 21:20:56'),
(946, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:21:31', '2026-06-04 21:21:31'),
(947, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:21:56', '2026-06-04 21:21:56'),
(948, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:22:56', '2026-06-04 21:22:56'),
(949, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:23:56', '2026-06-04 21:23:56'),
(950, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:24:56', '2026-06-04 21:24:56'),
(951, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:25:56', '2026-06-04 21:25:56'),
(952, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:26:56', '2026-06-04 21:26:56'),
(953, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:27:56', '2026-06-04 21:27:56'),
(954, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:28:56', '2026-06-04 21:28:56'),
(955, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:29:56', '2026-06-04 21:29:56'),
(956, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:30:56', '2026-06-04 21:30:56');
INSERT INTO `totem_logs` (`id`, `totem_id`, `evento`, `detalle`, `ip`, `created_at`, `updated_at`) VALUES
(957, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:31:56', '2026-06-04 21:31:56'),
(958, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:32:56', '2026-06-04 21:32:56'),
(959, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:33:56', '2026-06-04 21:33:56'),
(960, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:34:56', '2026-06-04 21:34:56'),
(961, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:35:56', '2026-06-04 21:35:56'),
(962, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:36:56', '2026-06-04 21:36:56'),
(963, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:37:56', '2026-06-04 21:37:56'),
(964, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:38:56', '2026-06-04 21:38:56'),
(965, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:39:56', '2026-06-04 21:39:56'),
(966, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:40:56', '2026-06-04 21:40:56'),
(967, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:41:56', '2026-06-04 21:41:56'),
(968, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:42:56', '2026-06-04 21:42:56'),
(969, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:43:56', '2026-06-04 21:43:56'),
(970, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:44:56', '2026-06-04 21:44:56'),
(971, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:45:56', '2026-06-04 21:45:56'),
(972, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:46:56', '2026-06-04 21:46:56'),
(973, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:47:09', '2026-06-04 21:47:09'),
(974, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:47:26', '2026-06-04 21:47:26'),
(975, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:47:56', '2026-06-04 21:47:56'),
(976, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:48:56', '2026-06-04 21:48:56'),
(977, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:49:56', '2026-06-04 21:49:56'),
(978, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:50:56', '2026-06-04 21:50:56'),
(979, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:51:56', '2026-06-04 21:51:56'),
(980, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:52:56', '2026-06-04 21:52:56'),
(981, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:53:56', '2026-06-04 21:53:56'),
(982, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:54:56', '2026-06-04 21:54:56'),
(983, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:55:56', '2026-06-04 21:55:56'),
(984, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:56:56', '2026-06-04 21:56:56'),
(985, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:57:56', '2026-06-04 21:57:56'),
(986, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:58:56', '2026-06-04 21:58:56'),
(987, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 21:59:56', '2026-06-04 21:59:56'),
(988, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:00:56', '2026-06-04 22:00:56'),
(989, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:01:56', '2026-06-04 22:01:56'),
(990, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:02:56', '2026-06-04 22:02:56'),
(991, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:03:56', '2026-06-04 22:03:56'),
(992, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:04:56', '2026-06-04 22:04:56'),
(993, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:05:56', '2026-06-04 22:05:56'),
(994, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:06:56', '2026-06-04 22:06:56'),
(995, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:07:56', '2026-06-04 22:07:56'),
(996, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:08:56', '2026-06-04 22:08:56'),
(997, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:09:56', '2026-06-04 22:09:56'),
(998, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:10:56', '2026-06-04 22:10:56'),
(999, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:11:56', '2026-06-04 22:11:56'),
(1000, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:12:56', '2026-06-04 22:12:56'),
(1001, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:13:56', '2026-06-04 22:13:56'),
(1002, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:14:56', '2026-06-04 22:14:56'),
(1003, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:15:56', '2026-06-04 22:15:56'),
(1004, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-04 22:16:56', '2026-06-04 22:16:56'),
(1005, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:28:34', '2026-06-05 04:28:34'),
(1006, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:29:56', '2026-06-05 04:29:56'),
(1007, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:30:56', '2026-06-05 04:30:56'),
(1008, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:31:56', '2026-06-05 04:31:56'),
(1009, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:32:30', '2026-06-05 04:32:30'),
(1010, 1, 'venta_creada', 'Venta creada desde tótem ID 24', '127.0.0.1', '2026-06-05 04:32:53', '2026-06-05 04:32:53'),
(1011, 1, 'pago_confirmado', 'Pago confirmado venta ID 24 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-05 04:32:53', '2026-06-05 04:32:53'),
(1012, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 24', '127.0.0.1', '2026-06-05 04:32:53', '2026-06-05 04:32:53'),
(1013, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:32:56', '2026-06-05 04:32:56'),
(1014, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:33:56', '2026-06-05 04:33:56'),
(1015, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:34:56', '2026-06-05 04:34:56'),
(1016, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:35:56', '2026-06-05 04:35:56'),
(1017, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:36:56', '2026-06-05 04:36:56'),
(1018, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:37:56', '2026-06-05 04:37:56'),
(1019, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:38:56', '2026-06-05 04:38:56'),
(1020, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:39:48', '2026-06-05 04:39:48'),
(1021, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:39:56', '2026-06-05 04:39:56'),
(1022, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:40:56', '2026-06-05 04:40:56'),
(1023, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:41:56', '2026-06-05 04:41:56'),
(1024, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:42:56', '2026-06-05 04:42:56'),
(1025, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:43:56', '2026-06-05 04:43:56'),
(1026, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:44:56', '2026-06-05 04:44:56'),
(1027, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:45:56', '2026-06-05 04:45:56'),
(1028, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:46:56', '2026-06-05 04:46:56'),
(1029, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:47:56', '2026-06-05 04:47:56'),
(1030, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:48:56', '2026-06-05 04:48:56'),
(1031, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:49:56', '2026-06-05 04:49:56'),
(1032, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:50:56', '2026-06-05 04:50:56'),
(1033, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:51:56', '2026-06-05 04:51:56'),
(1034, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:52:56', '2026-06-05 04:52:56'),
(1035, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:53:56', '2026-06-05 04:53:56'),
(1036, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:54:56', '2026-06-05 04:54:56'),
(1037, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:55:56', '2026-06-05 04:55:56'),
(1038, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:56:56', '2026-06-05 04:56:56'),
(1039, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:57:56', '2026-06-05 04:57:56'),
(1040, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:58:56', '2026-06-05 04:58:56'),
(1041, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 04:59:56', '2026-06-05 04:59:56'),
(1042, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:00:56', '2026-06-05 05:00:56'),
(1043, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:01:56', '2026-06-05 05:01:56'),
(1044, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:02:56', '2026-06-05 05:02:56'),
(1045, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:03:56', '2026-06-05 05:03:56'),
(1046, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:04:56', '2026-06-05 05:04:56'),
(1047, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:05:56', '2026-06-05 05:05:56'),
(1048, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:06:00', '2026-06-05 05:06:00'),
(1049, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:06:56', '2026-06-05 05:06:56'),
(1050, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:07:56', '2026-06-05 05:07:56'),
(1051, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:08:56', '2026-06-05 05:08:56'),
(1052, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:09:56', '2026-06-05 05:09:56'),
(1053, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:10:56', '2026-06-05 05:10:56'),
(1054, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:11:37', '2026-06-05 05:11:37'),
(1055, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:11:56', '2026-06-05 05:11:56'),
(1056, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:12:56', '2026-06-05 05:12:56'),
(1057, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:13:56', '2026-06-05 05:13:56'),
(1058, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:14:56', '2026-06-05 05:14:56'),
(1059, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:15:56', '2026-06-05 05:15:56'),
(1060, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:16:56', '2026-06-05 05:16:56'),
(1061, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:17:56', '2026-06-05 05:17:56'),
(1062, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:18:27', '2026-06-05 05:18:27'),
(1063, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:18:56', '2026-06-05 05:18:56'),
(1064, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:19:56', '2026-06-05 05:19:56'),
(1065, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:20:56', '2026-06-05 05:20:56'),
(1066, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:21:56', '2026-06-05 05:21:56'),
(1067, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:22:56', '2026-06-05 05:22:56'),
(1068, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:23:56', '2026-06-05 05:23:56'),
(1069, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:24:56', '2026-06-05 05:24:56'),
(1070, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:25:56', '2026-06-05 05:25:56'),
(1071, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:26:56', '2026-06-05 05:26:56'),
(1072, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:27:56', '2026-06-05 05:27:56'),
(1073, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:28:56', '2026-06-05 05:28:56'),
(1074, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:29:56', '2026-06-05 05:29:56'),
(1075, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:30:56', '2026-06-05 05:30:56'),
(1076, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:31:56', '2026-06-05 05:31:56'),
(1077, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:32:56', '2026-06-05 05:32:56'),
(1078, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:33:56', '2026-06-05 05:33:56'),
(1079, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:34:56', '2026-06-05 05:34:56'),
(1080, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:35:56', '2026-06-05 05:35:56'),
(1081, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:36:56', '2026-06-05 05:36:56'),
(1082, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:37:56', '2026-06-05 05:37:56'),
(1083, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:38:56', '2026-06-05 05:38:56'),
(1084, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:39:56', '2026-06-05 05:39:56'),
(1085, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:40:56', '2026-06-05 05:40:56'),
(1086, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:41:56', '2026-06-05 05:41:56'),
(1087, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:42:56', '2026-06-05 05:42:56'),
(1088, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:43:56', '2026-06-05 05:43:56'),
(1089, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:44:56', '2026-06-05 05:44:56'),
(1090, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:45:56', '2026-06-05 05:45:56'),
(1091, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:46:56', '2026-06-05 05:46:56'),
(1092, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:47:56', '2026-06-05 05:47:56'),
(1093, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:48:56', '2026-06-05 05:48:56'),
(1094, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:49:56', '2026-06-05 05:49:56'),
(1095, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:50:56', '2026-06-05 05:50:56'),
(1096, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:51:56', '2026-06-05 05:51:56'),
(1097, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:52:56', '2026-06-05 05:52:56'),
(1098, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:53:56', '2026-06-05 05:53:56'),
(1099, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:54:56', '2026-06-05 05:54:56'),
(1100, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:55:56', '2026-06-05 05:55:56'),
(1101, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:56:56', '2026-06-05 05:56:56'),
(1102, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:57:56', '2026-06-05 05:57:56'),
(1103, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:58:56', '2026-06-05 05:58:56'),
(1104, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 05:59:56', '2026-06-05 05:59:56'),
(1105, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:00:56', '2026-06-05 06:00:56'),
(1106, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:01:56', '2026-06-05 06:01:56'),
(1107, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:02:56', '2026-06-05 06:02:56'),
(1108, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:03:56', '2026-06-05 06:03:56'),
(1109, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:04:56', '2026-06-05 06:04:56'),
(1110, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:05:56', '2026-06-05 06:05:56'),
(1111, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:06:56', '2026-06-05 06:06:56'),
(1112, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:07:56', '2026-06-05 06:07:56'),
(1113, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:08:56', '2026-06-05 06:08:56'),
(1114, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:09:56', '2026-06-05 06:09:56'),
(1115, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:10:56', '2026-06-05 06:10:56'),
(1116, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:11:56', '2026-06-05 06:11:56'),
(1117, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:12:56', '2026-06-05 06:12:56'),
(1118, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:13:56', '2026-06-05 06:13:56'),
(1119, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:14:56', '2026-06-05 06:14:56'),
(1120, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:15:56', '2026-06-05 06:15:56'),
(1121, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:16:56', '2026-06-05 06:16:56'),
(1122, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:17:56', '2026-06-05 06:17:56'),
(1123, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:18:56', '2026-06-05 06:18:56'),
(1124, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:19:56', '2026-06-05 06:19:56'),
(1125, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:20:56', '2026-06-05 06:20:56'),
(1126, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:21:56', '2026-06-05 06:21:56'),
(1127, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:22:56', '2026-06-05 06:22:56'),
(1128, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:23:56', '2026-06-05 06:23:56'),
(1129, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:24:56', '2026-06-05 06:24:56'),
(1130, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:25:56', '2026-06-05 06:25:56'),
(1131, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:26:56', '2026-06-05 06:26:56'),
(1132, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:27:56', '2026-06-05 06:27:56'),
(1133, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:28:56', '2026-06-05 06:28:56'),
(1134, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:29:56', '2026-06-05 06:29:56'),
(1135, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:30:56', '2026-06-05 06:30:56'),
(1136, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:31:56', '2026-06-05 06:31:56'),
(1137, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:32:56', '2026-06-05 06:32:56'),
(1138, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:33:56', '2026-06-05 06:33:56'),
(1139, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:34:56', '2026-06-05 06:34:56'),
(1140, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:35:56', '2026-06-05 06:35:56'),
(1141, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:36:56', '2026-06-05 06:36:56'),
(1142, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:37:56', '2026-06-05 06:37:56'),
(1143, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:38:56', '2026-06-05 06:38:56'),
(1144, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:39:56', '2026-06-05 06:39:56'),
(1145, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:40:56', '2026-06-05 06:40:56'),
(1146, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:41:56', '2026-06-05 06:41:56'),
(1147, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:42:56', '2026-06-05 06:42:56'),
(1148, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:43:56', '2026-06-05 06:43:56'),
(1149, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:44:56', '2026-06-05 06:44:56'),
(1150, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:45:56', '2026-06-05 06:45:56'),
(1151, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:46:56', '2026-06-05 06:46:56'),
(1152, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:47:56', '2026-06-05 06:47:56'),
(1153, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:48:56', '2026-06-05 06:48:56'),
(1154, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:49:56', '2026-06-05 06:49:56'),
(1155, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:50:56', '2026-06-05 06:50:56'),
(1156, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:51:56', '2026-06-05 06:51:56'),
(1157, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:52:56', '2026-06-05 06:52:56'),
(1158, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:53:56', '2026-06-05 06:53:56'),
(1159, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:54:56', '2026-06-05 06:54:56'),
(1160, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:55:56', '2026-06-05 06:55:56'),
(1161, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:56:56', '2026-06-05 06:56:56'),
(1162, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:57:56', '2026-06-05 06:57:56'),
(1163, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:58:56', '2026-06-05 06:58:56'),
(1164, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 06:59:56', '2026-06-05 06:59:56'),
(1165, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:00:56', '2026-06-05 07:00:56'),
(1166, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:01:56', '2026-06-05 07:01:56'),
(1167, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:02:56', '2026-06-05 07:02:56'),
(1168, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:03:56', '2026-06-05 07:03:56'),
(1169, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:04:56', '2026-06-05 07:04:56'),
(1170, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:05:56', '2026-06-05 07:05:56'),
(1171, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:06:56', '2026-06-05 07:06:56'),
(1172, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:07:56', '2026-06-05 07:07:56'),
(1173, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:08:56', '2026-06-05 07:08:56'),
(1174, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:09:56', '2026-06-05 07:09:56'),
(1175, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:10:56', '2026-06-05 07:10:56'),
(1176, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:11:56', '2026-06-05 07:11:56'),
(1177, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:12:56', '2026-06-05 07:12:56'),
(1178, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:13:56', '2026-06-05 07:13:56'),
(1179, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:14:56', '2026-06-05 07:14:56'),
(1180, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:15:56', '2026-06-05 07:15:56'),
(1181, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:16:56', '2026-06-05 07:16:56'),
(1182, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:17:56', '2026-06-05 07:17:56'),
(1183, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:18:56', '2026-06-05 07:18:56'),
(1184, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:19:56', '2026-06-05 07:19:56'),
(1185, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:20:56', '2026-06-05 07:20:56'),
(1186, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:21:56', '2026-06-05 07:21:56'),
(1187, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:22:56', '2026-06-05 07:22:56'),
(1188, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:23:56', '2026-06-05 07:23:56'),
(1189, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:24:08', '2026-06-05 07:24:08'),
(1190, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:24:56', '2026-06-05 07:24:56'),
(1191, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:25:56', '2026-06-05 07:25:56'),
(1192, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:26:56', '2026-06-05 07:26:56'),
(1193, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:27:56', '2026-06-05 07:27:56'),
(1194, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:28:56', '2026-06-05 07:28:56'),
(1195, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:29:56', '2026-06-05 07:29:56'),
(1196, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:30:56', '2026-06-05 07:30:56'),
(1197, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:31:56', '2026-06-05 07:31:56'),
(1198, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:32:56', '2026-06-05 07:32:56'),
(1199, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:33:56', '2026-06-05 07:33:56'),
(1200, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:34:56', '2026-06-05 07:34:56'),
(1201, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:35:56', '2026-06-05 07:35:56'),
(1202, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:36:56', '2026-06-05 07:36:56'),
(1203, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:38:05', '2026-06-05 07:38:05'),
(1204, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:38:56', '2026-06-05 07:38:56'),
(1205, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:39:56', '2026-06-05 07:39:56'),
(1206, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:40:56', '2026-06-05 07:40:56'),
(1207, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:41:56', '2026-06-05 07:41:56'),
(1208, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:42:56', '2026-06-05 07:42:56'),
(1209, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:43:56', '2026-06-05 07:43:56'),
(1210, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:44:56', '2026-06-05 07:44:56'),
(1211, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:45:56', '2026-06-05 07:45:56'),
(1212, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:46:56', '2026-06-05 07:46:56'),
(1213, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:47:56', '2026-06-05 07:47:56'),
(1214, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:48:56', '2026-06-05 07:48:56'),
(1215, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:49:56', '2026-06-05 07:49:56'),
(1216, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:50:56', '2026-06-05 07:50:56'),
(1217, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:51:56', '2026-06-05 07:51:56'),
(1218, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:52:56', '2026-06-05 07:52:56'),
(1219, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:53:56', '2026-06-05 07:53:56'),
(1220, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:54:56', '2026-06-05 07:54:56'),
(1221, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:55:56', '2026-06-05 07:55:56'),
(1222, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:56:56', '2026-06-05 07:56:56'),
(1223, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:57:56', '2026-06-05 07:57:56'),
(1224, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:58:56', '2026-06-05 07:58:56'),
(1225, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:59:13', '2026-06-05 07:59:13'),
(1226, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 07:59:21', '2026-06-05 07:59:21'),
(1227, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:08:28', '2026-06-05 08:08:28'),
(1228, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:32:51', '2026-06-05 08:32:51'),
(1229, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:39:56', '2026-06-05 08:39:56'),
(1230, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:40:37', '2026-06-05 08:40:37'),
(1231, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:43:54', '2026-06-05 08:43:54'),
(1232, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:48:57', '2026-06-05 08:48:57'),
(1233, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:51:25', '2026-06-05 08:51:25'),
(1234, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:53:03', '2026-06-05 08:53:03'),
(1235, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:53:04', '2026-06-05 08:53:04'),
(1236, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:53:05', '2026-06-05 08:53:05'),
(1237, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:53:06', '2026-06-05 08:53:06'),
(1238, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:53:06', '2026-06-05 08:53:06'),
(1239, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:53:06', '2026-06-05 08:53:06'),
(1240, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:53:07', '2026-06-05 08:53:07'),
(1241, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:53:07', '2026-06-05 08:53:07'),
(1242, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:53:07', '2026-06-05 08:53:07'),
(1243, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 08:53:08', '2026-06-05 08:53:08'),
(1244, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 09:00:00', '2026-06-05 09:00:00'),
(1245, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 09:00:28', '2026-06-05 09:00:28'),
(1246, 1, 'venta_creada', 'Venta creada desde tótem ID 25', '127.0.0.1', '2026-06-05 09:00:57', '2026-06-05 09:00:57'),
(1247, 1, 'pago_confirmado', 'Pago confirmado venta ID 25 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-05 09:00:59', '2026-06-05 09:00:59'),
(1248, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 25', '127.0.0.1', '2026-06-05 09:00:59', '2026-06-05 09:00:59'),
(1249, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 09:19:40', '2026-06-05 09:19:40'),
(1250, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 09:28:36', '2026-06-05 09:28:36'),
(1251, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 09:28:37', '2026-06-05 09:28:37'),
(1252, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 09:28:39', '2026-06-05 09:28:39'),
(1253, 1, 'venta_creada', 'Venta creada desde tótem ID 26', '127.0.0.1', '2026-06-05 09:29:26', '2026-06-05 09:29:26'),
(1254, 1, 'pago_confirmado', 'Pago confirmado venta ID 26 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-05 09:29:27', '2026-06-05 09:29:27'),
(1255, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 26', '127.0.0.1', '2026-06-05 09:29:27', '2026-06-05 09:29:27'),
(1256, 1, 'venta_creada', 'Venta creada desde tótem ID 27', '127.0.0.1', '2026-06-05 09:32:58', '2026-06-05 09:32:58'),
(1257, 1, 'pago_confirmado', 'Pago confirmado venta ID 27 con 0 voucher(s) generado(s)', '127.0.0.1', '2026-06-05 09:32:58', '2026-06-05 09:32:58'),
(1258, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 10:00:17', '2026-06-05 10:00:17'),
(1259, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 10:27:04', '2026-06-05 10:27:04'),
(1260, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 10:35:19', '2026-06-05 10:35:19'),
(1261, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 10:38:27', '2026-06-05 10:38:27'),
(1262, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 10:38:58', '2026-06-05 10:38:58'),
(1263, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 10:48:00', '2026-06-05 10:48:00'),
(1264, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 10:50:42', '2026-06-05 10:50:42'),
(1265, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:20:41', '2026-06-05 21:20:41'),
(1266, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:22:06', '2026-06-05 21:22:06'),
(1267, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:23:46', '2026-06-05 21:23:46'),
(1268, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:23:57', '2026-06-05 21:23:57'),
(1269, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:24:38', '2026-06-05 21:24:38'),
(1270, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:26:12', '2026-06-05 21:26:12'),
(1271, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:28:14', '2026-06-05 21:28:14'),
(1272, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:29:39', '2026-06-05 21:29:39'),
(1273, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:35:07', '2026-06-05 21:35:07'),
(1274, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:42:06', '2026-06-05 21:42:06'),
(1275, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:42:46', '2026-06-05 21:42:46'),
(1276, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:43:31', '2026-06-05 21:43:31'),
(1277, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:45:22', '2026-06-05 21:45:22'),
(1278, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:46:51', '2026-06-05 21:46:51'),
(1279, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-05 21:54:23', '2026-06-05 21:54:23'),
(1280, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-06 06:56:42', '2026-06-06 06:56:42'),
(1281, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-06 07:42:42', '2026-06-06 07:42:42'),
(1282, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-06 07:52:27', '2026-06-06 07:52:27'),
(1283, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-06 08:09:21', '2026-06-06 08:09:21'),
(1284, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-06 08:20:55', '2026-06-06 08:20:55'),
(1285, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-06 08:27:57', '2026-06-06 08:27:57'),
(1286, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-06 08:29:28', '2026-06-06 08:29:28'),
(1287, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 09:24:43', '2026-06-07 09:24:43'),
(1288, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 09:53:39', '2026-06-07 09:53:39'),
(1289, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 10:03:15', '2026-06-07 10:03:15'),
(1290, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 10:10:16', '2026-06-07 10:10:16'),
(1291, 1, 'venta_creada', 'Venta creada desde tótem ID 28', '127.0.0.1', '2026-06-07 10:17:13', '2026-06-07 10:17:13'),
(1292, 1, 'pago_confirmado', 'Pago confirmado venta ID 28 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 10:17:14', '2026-06-07 10:17:14'),
(1293, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 28', '127.0.0.1', '2026-06-07 10:17:14', '2026-06-07 10:17:14'),
(1294, 1, 'venta_creada', 'Venta creada desde tótem ID 29', '127.0.0.1', '2026-06-07 10:19:48', '2026-06-07 10:19:48'),
(1295, 1, 'pago_confirmado', 'Pago confirmado venta ID 29 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 10:19:48', '2026-06-07 10:19:48'),
(1296, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 29', '127.0.0.1', '2026-06-07 10:19:49', '2026-06-07 10:19:49'),
(1297, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 10:32:05', '2026-06-07 10:32:05'),
(1298, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 10:36:07', '2026-06-07 10:36:07'),
(1299, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 10:37:00', '2026-06-07 10:37:00'),
(1300, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 10:48:56', '2026-06-07 10:48:56'),
(1301, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 11:11:41', '2026-06-07 11:11:41'),
(1302, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 11:12:25', '2026-06-07 11:12:25'),
(1303, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 11:16:14', '2026-06-07 11:16:14'),
(1304, 1, 'venta_creada', 'Venta creada desde tótem ID 30', '127.0.0.1', '2026-06-07 11:19:03', '2026-06-07 11:19:03'),
(1305, 1, 'pago_confirmado', 'Pago confirmado venta ID 30 con 3 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 11:19:03', '2026-06-07 11:19:03'),
(1306, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 30', '127.0.0.1', '2026-06-07 11:19:04', '2026-06-07 11:19:04'),
(1307, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 11:32:47', '2026-06-07 11:32:47'),
(1308, 1, 'venta_creada', 'Venta creada desde tótem ID 31', '127.0.0.1', '2026-06-07 11:34:33', '2026-06-07 11:34:33'),
(1309, 1, 'pago_confirmado', 'Pago confirmado venta ID 31 con 2 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 11:34:33', '2026-06-07 11:34:33'),
(1310, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 31', '127.0.0.1', '2026-06-07 11:34:33', '2026-06-07 11:34:33'),
(1311, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 11:49:36', '2026-06-07 11:49:36'),
(1312, 1, 'venta_creada', 'Venta creada desde tótem ID 32', '127.0.0.1', '2026-06-07 11:50:43', '2026-06-07 11:50:43'),
(1313, 1, 'pago_confirmado', 'Pago confirmado venta ID 32 con 2 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 11:50:43', '2026-06-07 11:50:43'),
(1314, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 32', '127.0.0.1', '2026-06-07 11:50:44', '2026-06-07 11:50:44'),
(1315, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 11:51:07', '2026-06-07 11:51:07'),
(1316, 1, 'venta_creada', 'Venta creada desde tótem ID 33', '127.0.0.1', '2026-06-07 11:52:45', '2026-06-07 11:52:45'),
(1317, 1, 'pago_confirmado', 'Pago confirmado venta ID 33 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 11:52:45', '2026-06-07 11:52:45'),
(1318, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 33', '127.0.0.1', '2026-06-07 11:52:45', '2026-06-07 11:52:45'),
(1319, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 12:00:37', '2026-06-07 12:00:37'),
(1320, 1, 'venta_creada', 'Venta creada desde tótem ID 34', '127.0.0.1', '2026-06-07 12:02:47', '2026-06-07 12:02:47'),
(1321, 1, 'pago_confirmado', 'Pago confirmado venta ID 34 con 3 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 12:02:47', '2026-06-07 12:02:47'),
(1322, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 34', '127.0.0.1', '2026-06-07 12:02:47', '2026-06-07 12:02:47'),
(1323, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 12:10:14', '2026-06-07 12:10:14'),
(1324, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 12:11:55', '2026-06-07 12:11:55'),
(1325, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 12:12:13', '2026-06-07 12:12:13'),
(1326, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 12:27:43', '2026-06-07 12:27:43'),
(1327, 1, 'venta_creada', 'Venta creada desde tótem ID 35', '127.0.0.1', '2026-06-07 12:32:38', '2026-06-07 12:32:38'),
(1328, 1, 'pago_confirmado', 'Pago confirmado venta ID 35 con 3 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 12:32:38', '2026-06-07 12:32:38'),
(1329, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 35', '127.0.0.1', '2026-06-07 12:32:38', '2026-06-07 12:32:38'),
(1330, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 12:32:51', '2026-06-07 12:32:51'),
(1331, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 12:40:35', '2026-06-07 12:40:35'),
(1332, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 12:45:20', '2026-06-07 12:45:20'),
(1333, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 12:45:55', '2026-06-07 12:45:55'),
(1334, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 12:49:05', '2026-06-07 12:49:05'),
(1335, 1, 'venta_creada', 'Venta creada desde tótem ID 36', '127.0.0.1', '2026-06-07 12:50:03', '2026-06-07 12:50:03'),
(1336, 1, 'pago_confirmado', 'Pago confirmado venta ID 36 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 12:50:03', '2026-06-07 12:50:03'),
(1337, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 36', '127.0.0.1', '2026-06-07 12:50:03', '2026-06-07 12:50:03'),
(1338, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 13:07:38', '2026-06-07 13:07:38'),
(1339, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 13:10:33', '2026-06-07 13:10:33'),
(1340, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:05:12', '2026-06-07 22:05:12'),
(1341, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:09:54', '2026-06-07 22:09:54'),
(1342, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:12:54', '2026-06-07 22:12:54'),
(1343, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:15:09', '2026-06-07 22:15:09'),
(1344, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:15:48', '2026-06-07 22:15:48'),
(1345, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:18:57', '2026-06-07 22:18:57'),
(1346, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:28:44', '2026-06-07 22:28:44'),
(1347, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:31:03', '2026-06-07 22:31:03'),
(1348, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:38:32', '2026-06-07 22:38:32'),
(1349, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:41:22', '2026-06-07 22:41:22'),
(1350, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:41:27', '2026-06-07 22:41:27'),
(1351, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:41:27', '2026-06-07 22:41:27'),
(1352, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:51:53', '2026-06-07 22:51:53'),
(1353, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 22:59:09', '2026-06-07 22:59:09'),
(1354, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 23:01:18', '2026-06-07 23:01:18'),
(1355, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 23:07:41', '2026-06-07 23:07:41'),
(1356, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 23:37:27', '2026-06-07 23:37:27'),
(1357, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 23:37:31', '2026-06-07 23:37:31'),
(1358, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 23:37:32', '2026-06-07 23:37:32'),
(1359, 1, 'venta_creada', 'Venta creada desde tótem ID 37', '127.0.0.1', '2026-06-07 23:38:19', '2026-06-07 23:38:19'),
(1360, 1, 'pago_confirmado', 'Pago confirmado venta ID 37 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 23:38:19', '2026-06-07 23:38:19'),
(1361, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 37', '127.0.0.1', '2026-06-07 23:38:20', '2026-06-07 23:38:20'),
(1362, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-07 23:53:09', '2026-06-07 23:53:09'),
(1363, 1, 'venta_creada', 'Venta creada desde tótem ID 38', '127.0.0.1', '2026-06-07 23:55:02', '2026-06-07 23:55:02'),
(1364, 1, 'pago_confirmado', 'Pago confirmado venta ID 38 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 23:55:02', '2026-06-07 23:55:02'),
(1365, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 38', '127.0.0.1', '2026-06-07 23:55:02', '2026-06-07 23:55:02'),
(1366, 1, 'venta_creada', 'Venta creada desde tótem ID 39', '127.0.0.1', '2026-06-07 23:55:03', '2026-06-07 23:55:03'),
(1367, 1, 'pago_confirmado', 'Pago confirmado venta ID 39 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-07 23:55:03', '2026-06-07 23:55:03'),
(1368, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 39', '127.0.0.1', '2026-06-07 23:55:03', '2026-06-07 23:55:03'),
(1369, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 01:08:38', '2026-06-08 01:08:38'),
(1370, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 01:10:26', '2026-06-08 01:10:26'),
(1371, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 01:13:09', '2026-06-08 01:13:09'),
(1372, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 01:13:22', '2026-06-08 01:13:22'),
(1373, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 01:14:44', '2026-06-08 01:14:44'),
(1374, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 01:14:46', '2026-06-08 01:14:46'),
(1375, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 01:14:51', '2026-06-08 01:14:51'),
(1376, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 07:18:03', '2026-06-08 07:18:03'),
(1377, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 07:19:41', '2026-06-08 07:19:41'),
(1378, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 08:00:49', '2026-06-08 08:00:49'),
(1379, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 21:25:13', '2026-06-08 21:25:13'),
(1380, 1, 'venta_creada', 'Venta creada desde tótem ID 40', '127.0.0.1', '2026-06-08 21:26:45', '2026-06-08 21:26:45'),
(1381, 1, 'pago_confirmado', 'Pago confirmado venta ID 40 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-08 21:26:46', '2026-06-08 21:26:46'),
(1382, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 40', '127.0.0.1', '2026-06-08 21:26:46', '2026-06-08 21:26:46'),
(1383, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 21:28:31', '2026-06-08 21:28:31'),
(1384, 1, 'venta_creada', 'Venta creada desde tótem ID 41', '127.0.0.1', '2026-06-08 21:30:23', '2026-06-08 21:30:23'),
(1385, 1, 'pago_confirmado', 'Pago confirmado venta ID 41 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-08 21:30:23', '2026-06-08 21:30:23'),
(1386, 1, 'voucher_entregado', 'Entrega por veterinario venta ID 41', '127.0.0.1', '2026-06-08 21:30:23', '2026-06-08 21:30:23'),
(1387, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 21:31:28', '2026-06-08 21:31:28'),
(1388, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-08 21:37:17', '2026-06-08 21:37:17'),
(1389, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 05:53:33', '2026-06-09 05:53:33'),
(1390, 1, 'venta_creada', 'Venta creada desde tótem ID 42', '127.0.0.1', '2026-06-09 05:55:05', '2026-06-09 05:55:05'),
(1391, 1, 'pago_confirmado', 'Pago confirmado venta ID 42 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 05:55:07', '2026-06-09 05:55:07'),
(1392, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 42', '127.0.0.1', '2026-06-09 05:55:07', '2026-06-09 05:55:07'),
(1393, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 05:57:50', '2026-06-09 05:57:50'),
(1394, 1, 'venta_creada', 'Venta creada desde tótem ID 43', '127.0.0.1', '2026-06-09 05:58:27', '2026-06-09 05:58:27'),
(1395, 1, 'pago_confirmado', 'Pago confirmado venta ID 43 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 05:58:27', '2026-06-09 05:58:27'),
(1396, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 43', '127.0.0.1', '2026-06-09 05:58:27', '2026-06-09 05:58:27'),
(1397, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 05:58:56', '2026-06-09 05:58:56'),
(1398, 1, 'venta_creada', 'Venta creada desde tótem ID 44', '127.0.0.1', '2026-06-09 06:01:00', '2026-06-09 06:01:00'),
(1399, 1, 'pago_confirmado', 'Pago confirmado venta ID 44 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 06:01:00', '2026-06-09 06:01:00'),
(1400, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 44', '127.0.0.1', '2026-06-09 06:01:00', '2026-06-09 06:01:00'),
(1401, 1, 'venta_creada', 'Venta creada desde tótem ID 45', '127.0.0.1', '2026-06-09 06:01:01', '2026-06-09 06:01:01'),
(1402, 1, 'pago_confirmado', 'Pago confirmado venta ID 45 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 06:01:01', '2026-06-09 06:01:01'),
(1403, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 45', '127.0.0.1', '2026-06-09 06:01:02', '2026-06-09 06:01:02'),
(1404, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 06:01:20', '2026-06-09 06:01:20'),
(1405, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:01:06', '2026-06-09 08:01:06'),
(1406, 1, 'venta_creada', 'Venta creada desde tótem ID 46', '127.0.0.1', '2026-06-09 08:02:19', '2026-06-09 08:02:19'),
(1407, 1, 'pago_confirmado', 'Pago confirmado venta ID 46 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 08:02:20', '2026-06-09 08:02:20'),
(1408, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 46', '127.0.0.1', '2026-06-09 08:02:20', '2026-06-09 08:02:20'),
(1409, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:04:31', '2026-06-09 08:04:31'),
(1410, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:06:10', '2026-06-09 08:06:10'),
(1411, 1, 'venta_creada', 'Venta creada desde tótem ID 47', '127.0.0.1', '2026-06-09 08:07:17', '2026-06-09 08:07:17'),
(1412, 1, 'pago_confirmado', 'Pago confirmado venta ID 47 con 3 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 08:07:17', '2026-06-09 08:07:17'),
(1413, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 47', '127.0.0.1', '2026-06-09 08:07:17', '2026-06-09 08:07:17'),
(1414, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:08:26', '2026-06-09 08:08:26'),
(1415, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:08:42', '2026-06-09 08:08:42'),
(1416, 1, 'venta_creada', 'Venta creada desde tótem ID 48', '127.0.0.1', '2026-06-09 08:10:08', '2026-06-09 08:10:08'),
(1417, 1, 'pago_confirmado', 'Pago confirmado venta ID 48 con 3 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 08:10:09', '2026-06-09 08:10:09');
INSERT INTO `totem_logs` (`id`, `totem_id`, `evento`, `detalle`, `ip`, `created_at`, `updated_at`) VALUES
(1418, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 48', '127.0.0.1', '2026-06-09 08:10:09', '2026-06-09 08:10:09'),
(1419, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:11:15', '2026-06-09 08:11:15'),
(1420, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:42:47', '2026-06-09 08:42:47'),
(1421, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:42:49', '2026-06-09 08:42:49'),
(1422, 1, 'venta_creada', 'Venta creada desde tótem ID 49', '127.0.0.1', '2026-06-09 08:43:51', '2026-06-09 08:43:51'),
(1423, 1, 'pago_confirmado', 'Pago confirmado venta ID 49 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 08:43:52', '2026-06-09 08:43:52'),
(1424, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 49', '127.0.0.1', '2026-06-09 08:43:52', '2026-06-09 08:43:52'),
(1425, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:45:30', '2026-06-09 08:45:30'),
(1426, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:46:27', '2026-06-09 08:46:27'),
(1427, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:47:55', '2026-06-09 08:47:55'),
(1428, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:49:12', '2026-06-09 08:49:12'),
(1429, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 08:57:14', '2026-06-09 08:57:14'),
(1430, 1, 'venta_creada', 'Venta creada desde tótem ID 50', '127.0.0.1', '2026-06-09 08:58:23', '2026-06-09 08:58:23'),
(1431, 1, 'pago_confirmado', 'Pago confirmado venta ID 50 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 08:58:23', '2026-06-09 08:58:23'),
(1432, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 50', '127.0.0.1', '2026-06-09 08:58:23', '2026-06-09 08:58:23'),
(1433, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 09:00:06', '2026-06-09 09:00:06'),
(1434, 1, 'venta_creada', 'Venta creada desde tótem ID 51', '127.0.0.1', '2026-06-09 09:00:47', '2026-06-09 09:00:47'),
(1435, 1, 'pago_confirmado', 'Pago confirmado venta ID 51 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 09:00:47', '2026-06-09 09:00:47'),
(1436, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 51', '127.0.0.1', '2026-06-09 09:00:47', '2026-06-09 09:00:47'),
(1437, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 09:11:39', '2026-06-09 09:11:39'),
(1438, 1, 'venta_creada', 'Venta creada desde tótem ID 52', '127.0.0.1', '2026-06-09 09:12:23', '2026-06-09 09:12:23'),
(1439, 1, 'pago_confirmado', 'Pago confirmado venta ID 52 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 09:12:23', '2026-06-09 09:12:23'),
(1440, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 52', '127.0.0.1', '2026-06-09 09:12:23', '2026-06-09 09:12:23'),
(1441, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 09:23:05', '2026-06-09 09:23:05'),
(1442, 1, 'venta_creada', 'Venta creada desde tótem ID 53', '127.0.0.1', '2026-06-09 09:24:09', '2026-06-09 09:24:09'),
(1443, 1, 'pago_confirmado', 'Pago confirmado venta ID 53 con 2 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 09:24:09', '2026-06-09 09:24:09'),
(1444, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 53', '127.0.0.1', '2026-06-09 09:24:09', '2026-06-09 09:24:09'),
(1445, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:00:59', '2026-06-09 10:00:59'),
(1446, 1, 'venta_creada', 'Venta creada desde tótem ID 54', '127.0.0.1', '2026-06-09 10:01:37', '2026-06-09 10:01:37'),
(1447, 1, 'pago_confirmado', 'Pago confirmado venta ID 54 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 10:01:37', '2026-06-09 10:01:37'),
(1448, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 54', '127.0.0.1', '2026-06-09 10:01:37', '2026-06-09 10:01:37'),
(1449, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:19:10', '2026-06-09 10:19:10'),
(1450, 1, 'venta_creada', 'Venta creada desde tótem ID 55', '127.0.0.1', '2026-06-09 10:19:48', '2026-06-09 10:19:48'),
(1451, 1, 'pago_confirmado', 'Pago confirmado venta ID 55 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 10:19:48', '2026-06-09 10:19:48'),
(1452, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 55', '127.0.0.1', '2026-06-09 10:19:48', '2026-06-09 10:19:48'),
(1453, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:22:18', '2026-06-09 10:22:18'),
(1454, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:22:19', '2026-06-09 10:22:19'),
(1455, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:22:19', '2026-06-09 10:22:19'),
(1456, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:22:20', '2026-06-09 10:22:20'),
(1457, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:22:26', '2026-06-09 10:22:26'),
(1458, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:22:26', '2026-06-09 10:22:26'),
(1459, 1, 'venta_creada', 'Venta creada desde tótem ID 56', '127.0.0.1', '2026-06-09 10:22:56', '2026-06-09 10:22:56'),
(1460, 1, 'pago_confirmado', 'Pago confirmado venta ID 56 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 10:22:56', '2026-06-09 10:22:56'),
(1461, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 56', '127.0.0.1', '2026-06-09 10:22:56', '2026-06-09 10:22:56'),
(1462, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:32:44', '2026-06-09 10:32:44'),
(1463, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:32:48', '2026-06-09 10:32:48'),
(1464, 1, 'venta_creada', 'Venta creada desde tótem ID 57', '127.0.0.1', '2026-06-09 10:33:20', '2026-06-09 10:33:20'),
(1465, 1, 'pago_confirmado', 'Pago confirmado venta ID 57 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 10:33:20', '2026-06-09 10:33:20'),
(1466, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 57', '127.0.0.1', '2026-06-09 10:33:21', '2026-06-09 10:33:21'),
(1467, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:42:03', '2026-06-09 10:42:03'),
(1468, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:42:04', '2026-06-09 10:42:04'),
(1469, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:42:05', '2026-06-09 10:42:05'),
(1470, 1, 'venta_creada', 'Venta creada desde tótem ID 58', '127.0.0.1', '2026-06-09 10:42:31', '2026-06-09 10:42:31'),
(1471, 1, 'pago_confirmado', 'Pago confirmado venta ID 58 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 10:42:32', '2026-06-09 10:42:32'),
(1472, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 10:59:46', '2026-06-09 10:59:46'),
(1473, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 11:29:59', '2026-06-09 11:29:59'),
(1474, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 11:43:07', '2026-06-09 11:43:07'),
(1475, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-09 11:44:42', '2026-06-09 11:44:42'),
(1476, 1, 'venta_creada', 'Venta creada desde tótem ID 59', '127.0.0.1', '2026-06-09 11:45:23', '2026-06-09 11:45:23'),
(1477, 1, 'pago_confirmado', 'Pago confirmado venta ID 59 con 2 voucher(s) generado(s)', '127.0.0.1', '2026-06-09 11:45:24', '2026-06-09 11:45:24'),
(1478, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 59', '127.0.0.1', '2026-06-09 11:45:24', '2026-06-09 11:45:24'),
(1479, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-10 09:27:06', '2026-06-10 09:27:06'),
(1480, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-10 09:27:52', '2026-06-10 09:27:52'),
(1481, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-10 09:52:23', '2026-06-10 09:52:23'),
(1482, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-10 11:33:15', '2026-06-10 11:33:15'),
(1483, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-10 11:52:06', '2026-06-10 11:52:06'),
(1484, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-10 11:56:54', '2026-06-10 11:56:54'),
(1485, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-11 02:14:51', '2026-06-11 02:14:51'),
(1486, 1, 'venta_creada', 'Venta creada desde tótem ID 60', '127.0.0.1', '2026-06-11 02:15:24', '2026-06-11 02:15:24'),
(1487, 1, 'pago_confirmado', 'Pago confirmado venta ID 60 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-11 02:15:26', '2026-06-11 02:15:26'),
(1488, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 60', '127.0.0.1', '2026-06-11 02:15:26', '2026-06-11 02:15:26'),
(1489, 1, 'venta_creada', 'Venta creada desde tótem ID 61', '127.0.0.1', '2026-06-11 02:16:31', '2026-06-11 02:16:31'),
(1490, 1, 'pago_confirmado', 'Pago confirmado venta ID 61 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-11 02:16:31', '2026-06-11 02:16:31'),
(1491, 1, 'voucher_entregado', 'Entrega por app venta ID 61', '127.0.0.1', '2026-06-11 02:16:31', '2026-06-11 02:16:31'),
(1492, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-11 05:37:42', '2026-06-11 05:37:42'),
(1493, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-11 07:22:34', '2026-06-11 07:22:34'),
(1494, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-11 09:14:02', '2026-06-11 09:14:02'),
(1495, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-13 07:45:20', '2026-06-13 07:45:20'),
(1496, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-25 02:44:04', '2026-06-25 02:44:04'),
(1497, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-25 02:44:34', '2026-06-25 02:44:34'),
(1498, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-25 02:44:40', '2026-06-25 02:44:40'),
(1499, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-25 02:45:10', '2026-06-25 02:45:10'),
(1500, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-29 07:34:45', '2026-06-29 07:34:45'),
(1501, 1, 'login', 'Login exitoso del tótem', '127.0.0.1', '2026-06-29 08:10:47', '2026-06-29 08:10:47'),
(1502, 1, 'venta_creada', 'Venta creada desde tótem ID 62', '127.0.0.1', '2026-06-29 08:11:43', '2026-06-29 08:11:43'),
(1503, 1, 'pago_confirmado', 'Pago confirmado venta ID 62 con 1 voucher(s) generado(s)', '127.0.0.1', '2026-06-29 08:11:44', '2026-06-29 08:11:44'),
(1504, 1, 'voucher_entregado', 'Entrega por whatsapp venta ID 62', '127.0.0.1', '2026-06-29 08:11:44', '2026-06-29 08:11:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `totem_sesiones`
--

CREATE TABLE `totem_sesiones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `totem_id` bigint(20) UNSIGNED NOT NULL,
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inicio` timestamp NOT NULL,
  `fin` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `totem_sesiones`
--

INSERT INTO `totem_sesiones` (`id`, `totem_id`, `token`, `inicio`, `fin`, `created_at`, `updated_at`) VALUES
(1, 1, 'io0MYIbJCGSIcIRozYOUKQAPOqLXPh8afnroaEIuG27AMmRWWf9jpqUvf5DoZH0qzKKuCwt8DgJp2ZUD', '2026-06-02 10:06:05', NULL, '2026-06-02 10:06:05', '2026-06-02 10:06:05'),
(2, 1, 'HxJsuC6uCaWRinS7Qnts2kvsHe7vIUMCOQxNmLYPOc2mJ5JJjnctI9wxRdD4DQw6EcHXEAV2jmpyLhoj', '2026-06-02 10:19:50', NULL, '2026-06-02 10:19:50', '2026-06-02 10:19:50'),
(3, 1, '353VV2n96mICpFDdEhzDoLDoNnRTepznfsKwuCSQ7tdvoyflhsfRJScJ97NYkQaaleCOgiFLm6gSy4JY', '2026-06-02 10:25:12', NULL, '2026-06-02 10:25:12', '2026-06-02 10:25:12'),
(4, 1, 'p1jjmefXuX6s9JMv105gO0z5HD0I2d5mcwqRWetHkbwjPS7ZoEazTlvo2S81CV90Zx4qDk4BrYvIJqz3', '2026-06-02 10:29:26', NULL, '2026-06-02 10:29:26', '2026-06-02 10:29:26'),
(5, 1, 'RNOT6UVTD8cvG7ZlYvtTVyNK9iNiAayB1zQRT7zXjEw1bHigurRrnrFrKOpMK7TSFRLawRfQWGn4LVgp', '2026-06-02 10:30:39', NULL, '2026-06-02 10:30:39', '2026-06-02 10:30:39'),
(6, 1, 'liXy7J34VcyCNWHsarbJlGeAXJ91GSFPMEopnSvHBxRDf24QtAQEe0iKpUQ2A0zZACklaD3EemLwOQ8F', '2026-06-02 10:31:10', NULL, '2026-06-02 10:31:10', '2026-06-02 10:31:10'),
(7, 1, 'TtZ8Pmzk54SiAQObYVgxOtfgNNMUfKHlDEDuIiCC44oEJ9DaueOKWSMd3EbueA44WQLhvxmXC60npT3f', '2026-06-02 17:50:06', NULL, '2026-06-02 17:50:06', '2026-06-02 17:50:06'),
(8, 1, 'BiJ4DxOomMXsRW3pko0sVZRtHueS9AR8GXVprouoEYTI4PlazB4D363dw47h5jYqlXN2qM17WJZpQJrj', '2026-06-02 17:53:56', NULL, '2026-06-02 17:53:56', '2026-06-02 17:53:56'),
(9, 1, 'hS54XGrlWmS0oJ7NbhHH07UZmNFs7zEyRkEAD9ewOFGKqoDA8BTVLA9Cz2Yg1WbBw7QyRkBUuFxAsmBf', '2026-06-02 17:54:47', NULL, '2026-06-02 17:54:47', '2026-06-02 17:54:47'),
(10, 1, 'dNpyssW5sMV0GxopoXkmXpBc7GTUNsXPBqgYBrqFD9i2LurySd8sRV25URP9OhdmzFCXOZTYBSNl2XvT', '2026-06-02 18:01:19', NULL, '2026-06-02 18:01:19', '2026-06-02 18:01:19'),
(11, 1, 'tUY9DPVgf7F6uYnnI9FVhJGORthHc0ztICPX5hhL04K0BNk2AhmXJ3nmOeOUHtsa243RKJZPhcfKLhnN', '2026-06-02 18:24:48', NULL, '2026-06-02 18:24:48', '2026-06-02 18:24:48'),
(12, 1, 'o3CnhAQTFJACqN1KsS2jjtZgVpmeVlYdzXKDqYwFv5Gu7Fw9Ko2otTASqbTfMdlBWAXciydRi9fVuYdr', '2026-06-02 18:28:22', NULL, '2026-06-02 18:28:22', '2026-06-02 18:28:22'),
(13, 1, '3sV8CAUuVVXcbBoone6ABSKzUqZe5baZxoAortaoGex9SjkELGzKyySGtaP7adhnAdbt10ClVnSeUZY7', '2026-06-02 18:45:22', NULL, '2026-06-02 18:45:22', '2026-06-02 18:45:22'),
(14, 1, 'hqmDPS3M7XKjDeUFJDLR8TWD6ZP1Zg6CsGJn1HnCQp2dGiuEgseGdmYrXa9rsG7yVYiKP1lVzevbOLEg', '2026-06-02 19:32:50', NULL, '2026-06-02 19:32:50', '2026-06-02 19:32:50'),
(15, 1, 'DcMiJAeUzLdqXURI8s7wY6rtdyyrIFadIRMfsGJ8i32uJTS12S3aZzDILTfcbo50jXjLTir0JwV0FS9q', '2026-06-02 19:36:45', NULL, '2026-06-02 19:36:45', '2026-06-02 19:36:45'),
(16, 1, 'rr4vHpvwgWqFuY2Pvzc0tUlJ0wql7GB9XAPqI2W0A74YgFMqycHdPQN7svpIlj0zg6oLTR5QoBjygXgJ', '2026-06-02 19:37:56', NULL, '2026-06-02 19:37:56', '2026-06-02 19:37:56'),
(17, 1, 'Vy0Q9WOF5or3TyFxd6lwRQ1NiaDvAqtpoF0Q035vO5t7fM3aBOHrTxaz4NOGSW3G5v5FL9lHEzFqxJGw', '2026-06-02 19:49:55', NULL, '2026-06-02 19:49:55', '2026-06-02 19:49:55'),
(18, 1, 'wghnnepP0bNZL3IzTd7wYbRt4vINxEGiNG2imKTtNCdRcWTzTwkOmaYp8V4MicBqrR4RF7Ek4XQvJjJj', '2026-06-02 19:53:39', NULL, '2026-06-02 19:53:39', '2026-06-02 19:53:39'),
(19, 1, 'cUzh3frr4lkiN6wx7QSg3mI5i5HEsBLc9U61ampCK0S1NXKeBIVzZzyCWZPbgkaIXSmOdWOqA5uOCiF5', '2026-06-02 20:15:06', NULL, '2026-06-02 20:15:06', '2026-06-02 20:15:06'),
(20, 1, 'IYjTjPevxN3L8tNv4QCwagF5kiOrUdSnANtih0r9Rk3T006MZ155JigkyQosz7RegkeaAGxHiw2L3rmb', '2026-06-02 20:16:58', NULL, '2026-06-02 20:16:58', '2026-06-02 20:16:58'),
(21, 1, 'ZIOY08UAl18EYZaamJ2pc4sxHkiKiFO2KUKXef7nCq59Q01EFY4kIDUPDFH356LVhKUzz7OkeB0BBq5k', '2026-06-02 20:25:46', NULL, '2026-06-02 20:25:46', '2026-06-02 20:25:46'),
(22, 1, '6BFz8GsF7nmcb3I1DcQDQ9gHYFaw47VusqaxwrNuKykAT4hQZ0zY1gXMwIl9TbGraIciTdRANxbjKU7F', '2026-06-02 20:26:36', NULL, '2026-06-02 20:26:36', '2026-06-02 20:26:36'),
(23, 1, 'sufTnnz8DJPwzFSYFmciy7GvsB1IqXWHl9lPWgtoIHtHSjDD6ULRfOjryNGg91otPgR0QAjEe0JOkEij', '2026-06-02 20:27:53', NULL, '2026-06-02 20:27:53', '2026-06-02 20:27:53'),
(24, 1, '8g6Cvne3UhtnMlr7iJdpAkiHzYACv3m7pzIhOLXatiZo7XVk37OrWPdHL1D1MRflulpH9gzMQqbc7Jzo', '2026-06-02 20:40:50', NULL, '2026-06-02 20:40:50', '2026-06-02 20:40:50'),
(25, 1, 'XuftNCHGVJvZ2zpOcRFhz8fHKdkGmKR15wA9f9T09jSZVV97PmjOfKtNScYPHsuCj2LP1cI9SKKHeJiZ', '2026-06-02 20:56:50', NULL, '2026-06-02 20:56:50', '2026-06-02 20:56:50'),
(26, 1, 'Rr4y9UPStzXgXih83dAKXwSEzdwOsdvjFIyoUGIHek35XZYmAnoDxGtgEbmlgKfD8YNx84p37M35fdzl', '2026-06-02 20:58:22', NULL, '2026-06-02 20:58:22', '2026-06-02 20:58:22'),
(27, 1, 'DTYQ9FHxITArrneHntllKpUjFBIUH3mlJxyirVT8VjlXVNLaHZqy2pLmpOYEEMOuNCZNN3R6CWykKI3y', '2026-06-02 20:58:49', NULL, '2026-06-02 20:58:49', '2026-06-02 20:58:49'),
(28, 1, '0XG5QbgaLPLdDSdSIopldfrR1lkuY1V1YTP0tmwfrqirHM87PkrPg2RNOba0pzpAWt4QbEwGUMzNplCe', '2026-06-02 21:02:57', NULL, '2026-06-02 21:02:57', '2026-06-02 21:02:57'),
(29, 1, 'KmvWu2twCsB89fOvn4OXgWuttUxCjc9NiHjfp8EGSUw7p06m47SrNNbNLEbSKkIDIlnDCR0nQrp1e3U2', '2026-06-02 21:12:32', NULL, '2026-06-02 21:12:32', '2026-06-02 21:12:32'),
(30, 1, '44SU7On5JetKRtj5E0ccquXlHiMkKIpLVDq9oixOKrA4MqbgzyFk8YRcdWAQv6NdBLw3sZATiF3Jx2SN', '2026-06-02 21:19:46', NULL, '2026-06-02 21:19:46', '2026-06-02 21:19:46'),
(31, 1, '2LuucezoBkeWOgFUMtADDDe6S4xKmg53rlYGvnlGp0VylR35d3t1GLJqlLEC5IBEOLGPkfgX1YcOvVOW', '2026-06-03 05:57:47', NULL, '2026-06-03 05:57:47', '2026-06-03 05:57:47'),
(32, 1, 'MWrbfWTmvZETsJ4ObDCy3JEswANJBnZnXxKm2FzfcrB73FKjIsDxcTCfOldOZuPDJfSt57kirBe5iGj1', '2026-06-03 21:32:25', NULL, '2026-06-03 21:32:25', '2026-06-03 21:32:25'),
(33, 1, 'bJoAAsfylK3tVr6lyvgxilSMPxsZYIRkKH61L8Zx2yn834XHN9K5iybbQN8BR0rofqzdfuiWFIAQfKjj', '2026-06-03 21:39:54', NULL, '2026-06-03 21:39:54', '2026-06-03 21:39:54'),
(34, 1, 'o1etyrARqV8eF7SB10d7gm3KQuRDoOvSxFN1ld3Ub2LoGAfXEKdTLyMMVM8B5bdFOWXVK2dykqxQPh3m', '2026-06-03 21:40:58', NULL, '2026-06-03 21:40:58', '2026-06-03 21:40:58'),
(35, 1, 'IbqYTnGJRxiBhONpCRLkruAcrcgfJv2O55ygaxHtaAYfxtMCRiyubLJaW1N9tUSpfunxzJiDANWXjPch', '2026-06-03 21:51:59', NULL, '2026-06-03 21:51:59', '2026-06-03 21:51:59'),
(36, 1, 'sig9xCDNKMaIKZfd9SfifiAWWVfO7efgFGC3zpCIHrcNwHx8YwuSuWS70diVH50AHEesu7ntIJiULSn9', '2026-06-03 21:52:16', NULL, '2026-06-03 21:52:16', '2026-06-03 21:52:16'),
(37, 1, 'pkubdIcQ87OVu0DDq8X3ic5gOUKDTKGGeC9chxjKssB2xM9UD83A0jgUZDN0w7jZfP3txwoB9IsTsZAn', '2026-06-03 22:14:20', NULL, '2026-06-03 22:14:20', '2026-06-03 22:14:20'),
(38, 1, 'auLF8wpBeSJzPiSDLAxbSYY0SETp2RFECD4fb7w6k90as4ZbvpnQrHjX9Y9LupoMyBWHFX666N5M7IsY', '2026-06-03 22:26:46', NULL, '2026-06-03 22:26:46', '2026-06-03 22:26:46'),
(39, 1, 'f5iA0NNUpZVLeL0DeZwCG3vHwL0mPC9avLhG2QAkQmmmH3qgLAoKyvgk4YyS2rUY5KdNA1HYn1F3hqm6', '2026-06-03 22:27:36', NULL, '2026-06-03 22:27:36', '2026-06-03 22:27:36'),
(40, 1, 'idN3HKuLzE8jm41QakpwR7hmo99pBdgA26cJj70Ej9qfLnFolczm9hZF6fAaK5RNdz7SO6bkvmfWwOPx', '2026-06-03 22:34:29', NULL, '2026-06-03 22:34:29', '2026-06-03 22:34:29'),
(41, 1, 'jQA2XYe1MLag0WT6jQ2ARa3Z3ibouDMp0Vvum9bsVRcdUvCWIkgJcNwfgwEF0vHUh2jWMB8al3sJ4GWe', '2026-06-03 22:40:38', NULL, '2026-06-03 22:40:38', '2026-06-03 22:40:38'),
(42, 1, 'CAboX182AD3SK8Bv7O8wMdPGWfXf9zDocI4vJkn2fKiM1aUqWBxe4pZDFrOlLAdnNuKKamf1R4U7pxLG', '2026-06-03 23:35:04', NULL, '2026-06-03 23:35:04', '2026-06-03 23:35:04'),
(43, 1, '9HLazZJTVwVJwNH3w08vwQI6ScA2Z5nSKDGGxS29AZXujwnE2YS0SzNfJPiCrClLZBQ4OWXXnaZ5IvZX', '2026-06-03 23:36:22', NULL, '2026-06-03 23:36:22', '2026-06-03 23:36:22'),
(44, 1, '2y9tjiozWoTYVxSj0CSVgYSF64NBeyQXlHhkIrjosyNFkDAk5Nwm3qLGVJxdsw98XCHmm7tQjRghBBKI', '2026-06-03 23:48:46', NULL, '2026-06-03 23:48:46', '2026-06-03 23:48:46'),
(45, 1, '10JewvtIc8rRGaABS8dFDZzCkr4rh6HMYzkcTursKrE5kaDAZp9kEOxrP0dnlRBE2zp32Jex7KRH44bM', '2026-06-03 23:49:46', NULL, '2026-06-03 23:49:46', '2026-06-03 23:49:46'),
(46, 1, 'k4g3Hr04EVJLRx372Bxta8d6Z7dpjZIiA4t50FMVSVt3XbbZ0gvNZph4IPQaC6I2SMfnaBkJowiZGDHV', '2026-06-03 23:49:47', NULL, '2026-06-03 23:49:47', '2026-06-03 23:49:47'),
(47, 1, '2TSsGLgrWQPBPMNE3AcSSXJBrbZTHY9qv4zij3lWmKqXU6R0bYUVDOOVGKGWAbwBFICC7HAxkneZFeK4', '2026-06-03 23:49:47', NULL, '2026-06-03 23:49:47', '2026-06-03 23:49:47'),
(48, 1, 'keXRjzNcy50sFPRWg5zXYSEHC3hjHqlSEkASpsorCuEKSQ4PcEP9XFmUzXyxUUM2cli6NIPi94784uSQ', '2026-06-03 23:49:47', NULL, '2026-06-03 23:49:47', '2026-06-03 23:49:47'),
(49, 1, 'sZOVrwDC5bQx3z62HTi0MU1sRlBaaAcNRJtcsrSwvhlPNtzdnpGc2P3OkZ2OUaBhKyGfBvX20GWFOyeL', '2026-06-03 23:49:47', NULL, '2026-06-03 23:49:47', '2026-06-03 23:49:47'),
(50, 1, 'tj1DKVlq3Q4f9otgREYs6II8OzJmFZnJ25jcPnY7JhJ9DY8BanFkVsNqY2TXN6KkCbEXj6GIG3c2PkJP', '2026-06-03 23:49:48', NULL, '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(51, 1, 'm0uxOWUC7WvajN2cUbkPolWuhl4fWl7IXtMkm5zf7ehc5PKXMSrTNgOo8we0UBUTm4ylQvjmHNjfZoVp', '2026-06-03 23:49:48', NULL, '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(52, 1, 'n80PYWbt9fYW0WOz0uJVGUNynF3IJk833cUz7hp56C4h40LbUIuj3p6CW0KlPyklSFDtf3Nm0qhxLHt5', '2026-06-03 23:49:48', NULL, '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(53, 1, 'DJpRZ1jXUNPar78JTYBwW5uXSt0u5hrTLgrb8QCVB3PZcAD9fAtVVbu62RqNsPENDAPAmKOIKlbJEfzd', '2026-06-03 23:49:48', NULL, '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(54, 1, 'p6iZAhe3DQYmrwVrNIvJkZi2gWpTNTUA01S1UVytDA5kkFHLn6GlmPzkZzaTK6Ly8WLU4Ed34NdudnvP', '2026-06-03 23:49:48', NULL, '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(55, 1, 'WRqwJUsUdnHRSWEvHQuQY4mUXo8LU5BEMGAnXw5h1afSzwi3Jtu4ik85if9qkAg4QySMjZADXCk2aERi', '2026-06-03 23:49:48', NULL, '2026-06-03 23:49:48', '2026-06-03 23:49:48'),
(56, 1, 'pyJmJBsC3SDxpZ5o1Nu4FzHpmd8W1uy9jff31Rc2nkuGhCVywrerRCMMlMsNJUrqLiONnhPyGkVB6YDh', '2026-06-03 23:49:50', NULL, '2026-06-03 23:49:50', '2026-06-03 23:49:50'),
(57, 1, 'kelAOaHy4iTeMmkmJtVZE3nBjwIKY04VaeFcDEzt8XVq2pNZNsS1wVDLBxqeM6O6lGdARvVLylUeAI1d', '2026-06-03 23:49:50', NULL, '2026-06-03 23:49:50', '2026-06-03 23:49:50'),
(58, 1, 'CCmsqGA8GWZN8WxTLEhqDg4Rw5j4iUx1Ayr7FT5Dl2jbD3S7v24hVvkdr9KXlL3y3CjG7adUGURcaLYE', '2026-06-03 23:49:50', NULL, '2026-06-03 23:49:50', '2026-06-03 23:49:50'),
(59, 1, 'TygBvZbVDoGY0xAnpKHhq7EkrVLV6hJaRAg9EUCR3VTiSSyWEa0Rn5UkgUbTWUkkTiXe99r8ErPf9fij', '2026-06-03 23:49:51', NULL, '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(60, 1, 'feyv9ClNCC8IeyJOvB0EiIWzi32BJmOwuxKJk5Os0FnNuXP6Ez4f8lSbFKWxHdlNR4Fj0TETGsPCceOY', '2026-06-03 23:49:51', NULL, '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(61, 1, '7Sh8tPwxUtWlpCZuG80GAa1r3fTgcAJPW1nOUyi8w3EuvYG7PIvbm57ZAD2pk1qQY9Hmx42xsAZdiWTL', '2026-06-03 23:49:51', NULL, '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(62, 1, 'JCEZBqHpggaGLBR1Xm89I6mSyQN79LaVgnxXaokpIPnpZhcAxKQLPo5Mjjs4mGAQbeRJo4kKG9Q7gm0G', '2026-06-03 23:49:51', NULL, '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(63, 1, 'lnSkXcKeB2ul94tU3rlo6RsnasbuQna2K7CmWhbvi02cDV5LfilT52Or71FnUYpHuRQwn2uefiwEgnlK', '2026-06-03 23:49:51', NULL, '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(64, 1, 'AKPgtoiK96o5Im2Saw0EzvEbevs2kdnv8xB7jnH5mvPxajYMfUUB3s4d2f28V9XkYwV2Yab5vW2NNmjY', '2026-06-03 23:49:51', NULL, '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(65, 1, 'f74sR1c2BnXkNEZeterQA3yF7iovlQYIF1VkdHAiJ98SEURyFb5eFztcP3NQChJjRKEuf0g0CZBqmq5M', '2026-06-03 23:49:51', NULL, '2026-06-03 23:49:51', '2026-06-03 23:49:51'),
(66, 1, 'b9U56ustB9Z14J2628sdVNauYJz6ydPKM5WHonOyWCmDsDdPOyS5TUINAXKmvmVETUBaK7haJPxrUzYx', '2026-06-03 23:49:53', NULL, '2026-06-03 23:49:53', '2026-06-03 23:49:53'),
(67, 1, '2hJJLm8mHdOad0pGI6oN0Q1ImwC7UUJu0VIyBdIGB0xkkslwH7HL6lNTIvlnY4sLqWQez8FibTCa9WTu', '2026-06-03 23:49:53', NULL, '2026-06-03 23:49:53', '2026-06-03 23:49:53'),
(68, 1, 'pkkdCZTkoRnepk2RTYj4FVXXkY8nr12RvMaED3mpSOsrBLtUbs2jGFJXK1GLd5Am3ooZLjvfnYaFC95s', '2026-06-03 23:49:54', NULL, '2026-06-03 23:49:54', '2026-06-03 23:49:54'),
(69, 1, 'vWVEgztA68V3MmmY37nhJzMjyJkClcNG5s0eYeDfzxARjuifappQJhe15Gt6XHc3FCKiJ2MkRR5MS7VD', '2026-06-03 23:49:54', NULL, '2026-06-03 23:49:54', '2026-06-03 23:49:54'),
(70, 1, 'V2jDQOUdBkv6BEobKAlteB69NMvh3lBnFmr0JPuUJu2WRBXa7aZR3rnQlCHuuyZhiTehSPIFi7CDADmp', '2026-06-03 23:49:54', NULL, '2026-06-03 23:49:54', '2026-06-03 23:49:54'),
(71, 1, '041LA0NmerIXEoBh01XLIhuKEpxMQiTJH7Rk9hUGpi1mzFalhF8mHCkTaJekQUlfwUhV9tEq8d0VluOF', '2026-06-03 23:49:54', NULL, '2026-06-03 23:49:54', '2026-06-03 23:49:54'),
(72, 1, 'e4W83egM5f5bwcZcqTyhgJZDraK5Zck11Ahhzr4KltXcEXaQub6ZO4uqYxxnDPxSxw28aP05AJYi61YB', '2026-06-03 23:49:54', NULL, '2026-06-03 23:49:54', '2026-06-03 23:49:54'),
(73, 1, 'aEBpUmUUFswTuJmz3UXzFrYrzyh7fbhWzrMq3WkhfPsAdBJTCctHszxXDNInVdYy9QymhIdcA5X4zcVL', '2026-06-03 23:49:55', NULL, '2026-06-03 23:49:55', '2026-06-03 23:49:55'),
(74, 1, 'E7xjbzsxbBYakIXevMk7ot4RDdvQGZ3cXD9BcaK1libsfIqXFQCRAvBrtHO8Gs99mB5l0kARmpgLjzr3', '2026-06-03 23:49:55', NULL, '2026-06-03 23:49:55', '2026-06-03 23:49:55'),
(75, 1, 'Ls3sPwvr96xXSauz60ej2V3KkKfYwF7iuwFnaVyxiWVEDWjCZfDZV3dyhjKBwoKTSI9sst2bGVsnwi5A', '2026-06-03 23:49:55', NULL, '2026-06-03 23:49:55', '2026-06-03 23:49:55'),
(76, 1, 'YZqH6J7b7daxyEcfudKA8uy5Vn48USNvZ49c11A4v1q7VN53wy2TQ79OHdiszsbLR2ApGH52mLdMaXDX', '2026-06-03 23:59:31', NULL, '2026-06-03 23:59:31', '2026-06-03 23:59:31'),
(77, 1, 'jTJ8rmqbAlDvPnHqPbJtHbl8OnXfROIU9jWKR6P8J5nWyrxp3AeZ1Vl56UIgI8ljKqB1jEIXKQHYu6io', '2026-06-04 00:00:01', NULL, '2026-06-04 00:00:01', '2026-06-04 00:00:01'),
(78, 1, 'sf8eoA2v5ZODMjChGUoTzXtf9cztoBkVCXXhSZjXKVARlOmI2ArlmlYAE3iJ4oj1an8YtLJAFgbutJId', '2026-06-04 00:00:31', NULL, '2026-06-04 00:00:31', '2026-06-04 00:00:31'),
(79, 1, 'ba6mfyMomyRw3VVcwbIjww6sca3YGP0BAOZU9D2G6QqndDH8sBlWnF0mdLneUBTbo82Hauu5qYHhnftI', '2026-06-04 00:00:40', NULL, '2026-06-04 00:00:40', '2026-06-04 00:00:40'),
(80, 1, 'bPEAC8e8C9B7eIVFFSiOqvmb8YIK4umCiQhCyU0YEXs3RoJLV21OwGUDNzTLFs9KCGi4tGBNJaMwigaR', '2026-06-04 00:01:10', NULL, '2026-06-04 00:01:10', '2026-06-04 00:01:10'),
(81, 1, 'RAgP8oO0l1xF8lNN9bSF55yOsusGPmTKTLJ80geSWqW5emOQjBoRXx4zX9NKL7wL7Pncf20GlejpZ7Ri', '2026-06-04 00:01:40', NULL, '2026-06-04 00:01:40', '2026-06-04 00:01:40'),
(82, 1, 'h1qnNlXb8qmd4KSWa1hXTqvxpZTLoSczTt9EtXbgBymqksgU17RvbQzIalDAO9VkH2zRTSjQ3hFa8Ege', '2026-06-04 00:02:10', NULL, '2026-06-04 00:02:10', '2026-06-04 00:02:10'),
(83, 1, 'aQRBYeBi9JQro6AYVYIijZjr1f7lopbxWKBXSujwWfenVLL3A8Zz0zxswS7vW56O9fZBBO6YLUSpkYII', '2026-06-04 00:02:40', NULL, '2026-06-04 00:02:40', '2026-06-04 00:02:40'),
(84, 1, 'x6uOoR2FQNaeOF98ef40VhmdSQ0kSuHqm7mMyxEFi8QtJXcAtmC433A4405jyn9ThMSYIzLwKDnFj0ni', '2026-06-04 00:03:10', NULL, '2026-06-04 00:03:10', '2026-06-04 00:03:10'),
(85, 1, 'D0dHwBoDo8JGtA7Pw2PKuzHKjYcTYpjkYIyGUUOwkDccEunN7pSS3ujUmuvyaOYY3xN0rrg1yQxGdvvZ', '2026-06-04 00:03:12', NULL, '2026-06-04 00:03:12', '2026-06-04 00:03:12'),
(86, 1, 'bi6241FqqcOZQIpnBL3mCtHQ3jthVKaF3Wp3ltE4mkN2GYQB1AqW8JanjOH3nBe11TAbexCDVO0GqAVC', '2026-06-04 00:03:40', NULL, '2026-06-04 00:03:40', '2026-06-04 00:03:40'),
(87, 1, '2S7D9NfbP8jUxTLEeZlAjdKtLwJxjZOgeTG6y3yEDTFlTWTLkEGeaBdwtJdQyVvV3oZxImMOQ8OqxW1O', '2026-06-04 00:03:42', NULL, '2026-06-04 00:03:42', '2026-06-04 00:03:42'),
(88, 1, 'RSOK6y5UXFp3JljnzaaWIDnmKpeI1YhvdzQUBkE0T55pNuG1jjsKyebZhmxPdDnH7UaaiyoXFbdWmtmH', '2026-06-04 00:04:10', NULL, '2026-06-04 00:04:10', '2026-06-04 00:04:10'),
(89, 1, '2Rua1Ej1pk8JT2peMSCbK1Ep91Osis4LZYjQdbzbRlVCfpOs69AjONhm8MvKrtGmrb8Q2SC2JpEhCaou', '2026-06-04 00:04:38', NULL, '2026-06-04 00:04:38', '2026-06-04 00:04:38'),
(90, 1, '55S6tFw3YNJBKUazc0rNpvlaxAeb4lw07uOoFAjWckCOaRuOJIprGHmRsYfn3LwSFWFoCd8gC2Ci1dE5', '2026-06-04 00:04:40', NULL, '2026-06-04 00:04:40', '2026-06-04 00:04:40'),
(91, 1, 'SMvOAUVgYjVccsG6VUmiYgPhxHwiqfnzPivVO0OzfNF7J4gAGspG3zh6RcvceCTTF9r5Mj8ohqHyBTu4', '2026-06-04 00:04:40', NULL, '2026-06-04 00:04:40', '2026-06-04 00:04:40'),
(92, 1, '8pbEVoLJqiTIptFu9DrskJXmQnscZrusvyRZ4RZUgxrnQ2HjQg8Wr7Y6hiWyWPqgB0oNZS2Agu45Hd2H', '2026-06-04 00:04:41', NULL, '2026-06-04 00:04:41', '2026-06-04 00:04:41'),
(93, 1, 'qzjW2qgQ4lNw48MtaBjhjWHaSwxgXd4Lj7zOufTtmcOmKYlU2WksVVETh1Rg0qyqPGhfHV3qohOybW0x', '2026-06-04 00:04:41', NULL, '2026-06-04 00:04:41', '2026-06-04 00:04:41'),
(94, 1, 'pGXbLLKJdEFTZ3HpZqdWt9RZrAFHWvEOBu720MxE2dmqRLpJcefJ0TTpMnzFYmcPreVAozQl0qB4ICLU', '2026-06-04 00:05:10', NULL, '2026-06-04 00:05:10', '2026-06-04 00:05:10'),
(95, 1, 'JaT7nnOD5cywuQAUNUBv0HEdh2NvphMafrGLUaGcu4B5ZazXGmxQ8o4OMEqL3zFXw4Q2xt4RMIXYHdt8', '2026-06-04 00:05:39', NULL, '2026-06-04 00:05:39', '2026-06-04 00:05:39'),
(96, 1, 'L09X3uVaiZkIJhCb2sCrUupQn2R8luoePINlgtu6uJYuvuJkAn40rR4oHx5sF2Ww79KmcuWIztWIyTRK', '2026-06-04 00:05:56', NULL, '2026-06-04 00:05:56', '2026-06-04 00:05:56'),
(97, 1, 'vIg72vQIG2ydeOLBySqjoSEVUGijm5tiuEgAxpv9BswIEfmaCmVLhL9E8MmvfCI901FEpwgBUIaiQQ9B', '2026-06-04 00:06:23', NULL, '2026-06-04 00:06:23', '2026-06-04 00:06:23'),
(98, 1, '2nGLqPyg50rnG5FjAd5I0M7kzURGvMUuTJyk3X7HDXeMBM32xuSPU9oIgLo4M7dRok6V8LYGZDZxg6dS', '2026-06-04 00:06:40', NULL, '2026-06-04 00:06:40', '2026-06-04 00:06:40'),
(99, 1, 'mGVODxeO6gKXOnbBKbCsSNMC9Idmly201cvlAq2MXjSdNoRKp5keuHLdSIlRxo90FB0k1CFC7n2eMOjN', '2026-06-04 00:07:10', NULL, '2026-06-04 00:07:10', '2026-06-04 00:07:10'),
(100, 1, 'B3iNtZ4TbywzAdmZHPpAsnUcENT45NrlfgdSxhGoAwtEHYEyxC77Asfcw5247hLUR6IhUIMLs7mBCHuh', '2026-06-04 00:07:40', NULL, '2026-06-04 00:07:40', '2026-06-04 00:07:40'),
(101, 1, 'qwd4mCkHdOWu4tU1R7RgVLqoxxJPPo5dLVAhcg1SBMa8o28DWvEe0tWrw3wRi9L8aZLJQBlTuFGV77pY', '2026-06-04 00:08:56', NULL, '2026-06-04 00:08:56', '2026-06-04 00:08:56'),
(102, 1, 'Dlk48QFPUyjeMuGGEhGubDwYRGODT2o1ZOpLk3db9grRgCClcknhMA2fCfJQc7COstoNjfe18ASHo2sA', '2026-06-04 00:09:39', NULL, '2026-06-04 00:09:39', '2026-06-04 00:09:39'),
(103, 1, 'CZapkThfIsLWse4rGKkUhE6vwgeRD7OS0oqvsAFQu9ChRisgycUXjiJLRm8duZ1zbyqGntXLJUirJH0R', '2026-06-04 00:10:10', NULL, '2026-06-04 00:10:10', '2026-06-04 00:10:10'),
(104, 1, 'SmQJx3fzv4IEKY6J6Nq610xeNHLuOZHX8NPyCbROPLlCtaxDbaflKizjG8fIGmIukdXFsnkCO05uQL1S', '2026-06-04 00:10:40', NULL, '2026-06-04 00:10:40', '2026-06-04 00:10:40'),
(105, 1, 'LMJ9aqiuS8OJ0wD0ZHf5xSUotj3Bfk1Dhp7HxZi7MDNPQYiUvd5oBijID8paeo4Pi6Rfr2RiiUKAP8lV', '2026-06-04 00:11:10', NULL, '2026-06-04 00:11:10', '2026-06-04 00:11:10'),
(106, 1, 'ehbALujpzjuR5bAr528wFF3vqmx4iAvUv5UlHPiUrMXHypQ7zEaJlAWVRsOeTTdMkuODSrG9IfJ1vHRB', '2026-06-04 00:11:40', NULL, '2026-06-04 00:11:40', '2026-06-04 00:11:40'),
(107, 1, '5pCVWPvCKYbOuB5saqPuFPoUxMw0mjAaZIMeY5769nVR3bh6X1bXGsQGfvIx9gYYi3WbISyoT3oRDvMP', '2026-06-04 00:12:56', NULL, '2026-06-04 00:12:56', '2026-06-04 00:12:56'),
(108, 1, 'wUXC43xIQtvdjxzznP484GC01QTzBHL5Pwl7eJO9RTlcYatT5EkeggQ4KRXjuDsTujK8MnOFRFEtqmpZ', '2026-06-04 00:13:56', NULL, '2026-06-04 00:13:56', '2026-06-04 00:13:56'),
(109, 1, 'A1ptAecs5lUUJlzZQRpGnlGlx1ENn2Jva0kUJdWZbHOAVVEg6DMbbH0KjXoWFyJS7zl7NFZnD2EQy3VB', '2026-06-04 00:14:56', NULL, '2026-06-04 00:14:56', '2026-06-04 00:14:56'),
(110, 1, 'dvkZkWDHn4d6G8O2qQAZoIbHIAvNo1FPHO0hgUlFl0NLxekeS9YgLKL0SNEt6wmnE6g7c1cO5520DDVX', '2026-06-04 00:15:56', NULL, '2026-06-04 00:15:56', '2026-06-04 00:15:56'),
(111, 1, 'uDkzLFVD0hZchiz86xbxqO5axp2Q7LWthKtjpDyJtxmnMj0YW3STzDCWBhZRaYWSTpK5XJquSZ37Aubj', '2026-06-04 00:16:56', NULL, '2026-06-04 00:16:56', '2026-06-04 00:16:56'),
(112, 1, 'dK60GEjaOygHSKQrXkZsyzsipK2u6GbnPjoQeryO63MBHtIx1fg7cjuxrB3mPOnZdClfn7dKEondSada', '2026-06-04 00:17:17', NULL, '2026-06-04 00:17:17', '2026-06-04 00:17:17'),
(113, 1, 'McshDD4N6c7PVzThDsvftMeRmxHJcOFjqEeEHLNfd51eAVpmeNKUH3mgCv4HPtauHNJLmLnd4FGoQyWI', '2026-06-04 00:17:40', NULL, '2026-06-04 00:17:40', '2026-06-04 00:17:40'),
(114, 1, 'OdGF7UJU7CrKy4xVvhEWKrCnwhridSjWu77ytjjWsrqRaY6XhuZavRo09e8g0LDsGOhVSS9tVMIx2Oq2', '2026-06-04 00:18:10', NULL, '2026-06-04 00:18:10', '2026-06-04 00:18:10'),
(115, 1, '5z9Ts6sZoQqs4wxYuNyTCZrY8zYQoVMawQ9QJUSnK2BygmZtovLSs2Tfzy6sq5Bg4WYhDiQx7wnCnZmW', '2026-06-04 00:18:56', NULL, '2026-06-04 00:18:56', '2026-06-04 00:18:56'),
(116, 1, '9kL1sYHFSpTC0ZbrkfxvQAnsJS8pT5POKIu1zfFzh74mUhy2XuQVy3n8M4PhXRhgPo2RfYB4PKHWshfy', '2026-06-04 00:19:56', NULL, '2026-06-04 00:19:56', '2026-06-04 00:19:56'),
(117, 1, 'UsAPk4WjDIbysNlVsAQJrIGrplGuwpeVxQYncdUPRfYkOMpru2tvvoFs1lWH1Zu62wERWBKWlrPUrY5p', '2026-06-04 00:20:56', NULL, '2026-06-04 00:20:56', '2026-06-04 00:20:56'),
(118, 1, '9sk7R5YDHzLD7ABAuJNdAnxY4IltgCEyoZjw1PaW58N7QsVhIEuNlHY8z9PEH4OZspKrzNl6KF4bwqPa', '2026-06-04 00:21:56', NULL, '2026-06-04 00:21:56', '2026-06-04 00:21:56'),
(119, 1, 'qULjVA57tp8omgqU17uZXtTojfCfIpxZNuo5UgjuJnLY0BRip6gsooeWReu8PiCuo12vPRCIjR1sOLVX', '2026-06-04 00:22:56', NULL, '2026-06-04 00:22:56', '2026-06-04 00:22:56'),
(120, 1, 'BgYSGcfTtfyR0sMvSkknq6RIQhiijZQwkvuVJNN7KCrTxCMFIKlbJBF0QRq7emyfrgXDQoCGaNADZgVg', '2026-06-04 00:23:56', NULL, '2026-06-04 00:23:56', '2026-06-04 00:23:56'),
(121, 1, 'TNFEZCyirVxowHGxzbDISnKHLrpJld8DvGegAHPU5MC0KYC98WkjRw06pchvRPfRHDXwzxJNXaYqFHAc', '2026-06-04 00:24:56', NULL, '2026-06-04 00:24:56', '2026-06-04 00:24:56'),
(122, 1, 'khuqcBHm72vTpzip3R2AvhSqmbTGJ5CTdg1zngrRN9IwHEKBgsiH5KpVY4hkjaEMedOX33Tyf71j0bJY', '2026-06-04 00:25:56', NULL, '2026-06-04 00:25:56', '2026-06-04 00:25:56'),
(123, 1, '3IJfqvmrcqXkkZPIlMuiKKLznLlEb51uPTk5DfvOkrGsMKH5C2GCBgOUucGlSdcoQkEg3TkIt9HXfVwi', '2026-06-04 00:26:56', NULL, '2026-06-04 00:26:56', '2026-06-04 00:26:56'),
(124, 1, 'j4iHg6G9tQbpDDciIorDvNTGie4WvL6cELzgFfO5pYgbfImdkjHab86i1LFPcpE2ZqJvIbrkLMI3IeAn', '2026-06-04 00:27:56', NULL, '2026-06-04 00:27:56', '2026-06-04 00:27:56'),
(125, 1, '1JBhUthWOAkZdYeZC7nRobw128zpmDe8lltQoWKOmck1l1elfMUyrFuiHd5u8pPo2a4Gqfy6Welhi5Np', '2026-06-04 00:28:56', NULL, '2026-06-04 00:28:56', '2026-06-04 00:28:56'),
(126, 1, '6yvvBifemmVptT2wQFgGpjh8afDdSNiHyigfr5g8YYBmtrFFmKceSom4WMFXhPXxLDrRzuCLA8xG55eG', '2026-06-04 00:29:56', NULL, '2026-06-04 00:29:56', '2026-06-04 00:29:56'),
(127, 1, 'IZV8u7hGRXBSwdENMHGnlxbiiFkl6oYJsQBW94loMqRJ1iOgKxxtDte8YfciSN70BuuEeXG4RQI9vGcc', '2026-06-04 00:30:56', NULL, '2026-06-04 00:30:56', '2026-06-04 00:30:56'),
(128, 1, 'R9DUc2jMLiitjOMQDqQnvLS8ifUvgaxtaUDBLvwuU5Rf88259jDhcrct9zc9jZpfm4r9ND5nj1Zckcqy', '2026-06-04 00:31:56', NULL, '2026-06-04 00:31:56', '2026-06-04 00:31:56'),
(129, 1, 'XRdWh4v4R69PdO33N6NcrcG5NuVNvRhU9MC9vo5tKGXMWS2t48UX6PtabBeMyLkMbkTINNO4xILI3PAi', '2026-06-04 00:32:56', NULL, '2026-06-04 00:32:56', '2026-06-04 00:32:56'),
(130, 1, 'tNqDmJMzYV85ddtu2iua4Nx7uVB6DzQz1iF3SYVMMW2zphMB1EvWISvDg02AHGNA6PEWZ8kYNHAA7V8D', '2026-06-04 00:33:56', NULL, '2026-06-04 00:33:56', '2026-06-04 00:33:56'),
(131, 1, 'cdTRz88RroI5ZqPZQHKn6JcUqTOlD0ecBdxRzo2ewj7Fe8fDANbCdAOUX81BoYkjViuqQSHafP21NXVL', '2026-06-04 00:34:56', NULL, '2026-06-04 00:34:56', '2026-06-04 00:34:56'),
(132, 1, 'ayQe0wmdO5WyuJZ2aEsN3WfHXwmtRyD87nWVrrbyA6G66ZsbjVaqbB4o9fdgx6BsLF0tFMMZqVg4LZEW', '2026-06-04 00:35:56', NULL, '2026-06-04 00:35:56', '2026-06-04 00:35:56'),
(133, 1, 'vZDJdo3sJY5Kj70gvT2IFX9fk90gWsYcTW9O5VjQkVkMu0zuFZTTOOJadZyLAGoFBjHyy4HbetdvUBGr', '2026-06-04 00:36:56', NULL, '2026-06-04 00:36:56', '2026-06-04 00:36:56'),
(134, 1, '8uyR6ldxfisJj5nrjcZJrQsFxO6yunH4A5yUh0FoeqhhYC0HVq107CgbgByUUz0SXQ8VGP87Sk1rXr9e', '2026-06-04 00:37:56', NULL, '2026-06-04 00:37:56', '2026-06-04 00:37:56'),
(135, 1, 'DgLHd3raxxhbZ1WAEqurqeaorzJWJwSpoUtltoe31x8jBhlHpnUF1876wGYMadEEFEJwnAmULX29oyjM', '2026-06-04 00:38:56', NULL, '2026-06-04 00:38:56', '2026-06-04 00:38:56'),
(136, 1, '11voQ6GS0w2PIpXsV4UgErY8Z8OaKt3A0iT5JmecqT08t1nvNj2tMRYgYVqgVCz8YEfDCqc1h0EIg5ig', '2026-06-04 00:39:56', NULL, '2026-06-04 00:39:56', '2026-06-04 00:39:56'),
(137, 1, 'SsaFuQQ0tHU3cYmJaNrk4zs6EzdgRqOTEv0GQQWeM1GVUhQlOHaNZgY2Bx9b2KxrEItVSQ6MPBvdFcb1', '2026-06-04 00:40:56', NULL, '2026-06-04 00:40:56', '2026-06-04 00:40:56'),
(138, 1, 'CBSA4rBIwMeQhnGt95uwJxYKYNnZWGsrlOY4rENj2bDpCyMQBMRbiR6HjPaxQ1gDQUoZsmMs18FumWyU', '2026-06-04 00:41:56', NULL, '2026-06-04 00:41:56', '2026-06-04 00:41:56'),
(139, 1, 'VFoA1s5fN8kroRQH84tQTQIbCEh61jfjHCNnFjMjMpapiOruvuGyLzJOZak3bcg0GjjU3naEMvnF0x5J', '2026-06-04 00:42:56', NULL, '2026-06-04 00:42:56', '2026-06-04 00:42:56'),
(140, 1, '6pWHUdlm7x45LMqcNvV99biu4xg5M9XkCF2dnQaWN9tCQCG6hBfUdIRMt5jwNzwoHLMqVp2roGGaP2dH', '2026-06-04 00:48:56', NULL, '2026-06-04 00:48:56', '2026-06-04 00:48:56'),
(141, 1, 'mnEbHaSjLh8j4PFWTPvE36rQqY6iX7eb0k5iJxwkqcH6Qis7YOTQpmetgSWLNfLpYJ2VNiRhqc1i44NQ', '2026-06-04 00:49:56', NULL, '2026-06-04 00:49:56', '2026-06-04 00:49:56'),
(142, 1, 'GxBjj07PKpL1QwLt16HNvBHHJzO2hrL97naMxuGIfpfTho4VtooFrc2CEp9mOIhofcQPrYxS1qOZAOq8', '2026-06-04 00:50:56', NULL, '2026-06-04 00:50:56', '2026-06-04 00:50:56'),
(143, 1, 'u0U4nfRHZfhnW4XvWixQJ1JNSIIkvhp8RVaGeqbWCwKUwLqVaeRvP7O5Nc4SSzFmeVgKyYzBMyhAKsa3', '2026-06-04 00:51:56', NULL, '2026-06-04 00:51:56', '2026-06-04 00:51:56'),
(144, 1, 'BL3ojzcGsdM3sK8Oy5ewsrQSIvgNG2cMtT9jqPmwPLdU21lOfvoWgKinyHz6SuRNXQZpQjr2diK0yApE', '2026-06-04 00:52:56', NULL, '2026-06-04 00:52:56', '2026-06-04 00:52:56'),
(145, 1, 'Q4F8NAVZQxdmVJaHDakJ8dcUIy2lZ8VNghBBoh7rFIMtAgLIluWmmmji54OnUZT6C1zC6oZuWjY1NHK0', '2026-06-04 00:53:56', NULL, '2026-06-04 00:53:56', '2026-06-04 00:53:56'),
(146, 1, '0rYCTaExeEQMz8EYs7pJahINaSs9L5jcXUvPX5FDEXvbVFgZnO61vhmnFd3DGOQyejQHhCqgBJ2c5wCj', '2026-06-04 00:54:56', NULL, '2026-06-04 00:54:56', '2026-06-04 00:54:56'),
(147, 1, 'mAlRagsgW37P560lWgsm4aZKCwtZlqtirpQgMBY0IOlp5fIGHvaGQlQ6zmj0Zp6m2hk1GuCt5BBqFUL1', '2026-06-04 00:55:00', NULL, '2026-06-04 00:55:00', '2026-06-04 00:55:00'),
(148, 1, '4MwBYcgDrjWvGuPV9tABKolXmOqljNI611zaFbTRNUCSA5D576CKAMJfA7iPyfbv6LsebKKs6lnuEgLX', '2026-06-04 00:55:56', NULL, '2026-06-04 00:55:56', '2026-06-04 00:55:56'),
(149, 1, 't8o1fZ0EopAjtWVyOHoWvOnApZ9nNH0LfHO6za6H6XGDCZ96JtFKpg50er7s7GKJPQzLXYtbYk8nw5nM', '2026-06-04 00:56:56', NULL, '2026-06-04 00:56:56', '2026-06-04 00:56:56'),
(150, 1, 'GqpaFnEAvoWAmkqnTimPWMljpPNSDvnxbMvOIR2G6W09LSRbRusX1dnhrKpOAlg1HvkXwxHWuonCQpsE', '2026-06-04 00:57:56', NULL, '2026-06-04 00:57:56', '2026-06-04 00:57:56'),
(151, 1, 'AqB4CLXqQzIPlK7NMnzyHyY07snzyK30oAsiPCt8WLt8IJb8FR9NMYSiqCjKDSGItLpaUPhDZtWcmFB0', '2026-06-04 00:58:56', NULL, '2026-06-04 00:58:56', '2026-06-04 00:58:56'),
(152, 1, 'GmFBqRfivQXQBM9vag3H5XaBEvBTBrmoO0itjBZTjUcqlNMAssrryqlYL6Gqd9FTpVxK58cxTQ5rZQRn', '2026-06-04 00:59:56', NULL, '2026-06-04 00:59:56', '2026-06-04 00:59:56'),
(153, 1, 'hoF8lPMrEJWGUi1kDuKPd39Sb2mBYVHYSw84P9GhU7OTSBJC4eqI8wl8nfESlLjptqXKUNfnWX0f3FPY', '2026-06-04 01:00:56', NULL, '2026-06-04 01:00:56', '2026-06-04 01:00:56'),
(154, 1, 'DrLwtIduC91d001M1rdkgqLUMXsFXyjQJem1a94fcEacvZsNfBGloyOBPcM0Wv9sIP0jYxCugJiDe140', '2026-06-04 01:01:56', NULL, '2026-06-04 01:01:56', '2026-06-04 01:01:56'),
(155, 1, 'ORLCXit8LlQcJDadzAtCfbq1THqOOPa1LUmSHgwNWMjACzUcS2nV1vPusbyTXluqZiSd49zRwlQkMkd9', '2026-06-04 01:02:21', NULL, '2026-06-04 01:02:21', '2026-06-04 01:02:21'),
(156, 1, 'pvmK1VALmTy8uUJO91V4uCIeB7F9GzJM9hgU4WnGRyeg4IMxZslYkTZsct2J7YrYGVjtaUc36edr09wJ', '2026-06-04 01:02:56', NULL, '2026-06-04 01:02:56', '2026-06-04 01:02:56'),
(157, 1, 'IB5fJBLU3xPs1DruzvoEkwnUF75nvuYtEPpNdOAOXHwcyPLw7SF4XoKaWbjhBE4tMDa3xi7E5U3kLWOR', '2026-06-04 01:03:56', NULL, '2026-06-04 01:03:56', '2026-06-04 01:03:56'),
(158, 1, 'Mp4REOoZBrwrmeGJKaUNwetpH8l3KG0N4d20uTkTHdQrvrtNFyJr9NpX5jsoLeey8t047bEUAS8Em7bz', '2026-06-04 01:04:56', NULL, '2026-06-04 01:04:56', '2026-06-04 01:04:56'),
(159, 1, 'Sx2hS4J1D5eBHL8sXEQPWteXikb762Q2rwhkhIuMOxcUcO3iNrGkZTymVYDBhfn3VNkOefnW68fImV0H', '2026-06-04 01:05:56', NULL, '2026-06-04 01:05:56', '2026-06-04 01:05:56'),
(160, 1, 'tkCDnyrjYatxuDPw1B8t9glKZTt7ebcJE3r9jCK085GvmJHHtjbVKk3ch15fuFflwoscoW8VoXZaVOz2', '2026-06-04 01:06:56', NULL, '2026-06-04 01:06:56', '2026-06-04 01:06:56'),
(161, 1, 'oZupw8pYme17bZtCsJjq2X4qjXB4NSCyPAtkNOU8byUW70RXStzKuaAIcX894mg7uWDc7EJemkNLEQNQ', '2026-06-04 01:07:47', NULL, '2026-06-04 01:07:47', '2026-06-04 01:07:47'),
(162, 1, 'GD5URAZGygUEqr9GDRQCRkzmKTXwtB9ARVQvzNHhgNKyI7UneDgEF54r4CDYIyVtZGU6lFdl6lpRji7m', '2026-06-04 01:07:56', NULL, '2026-06-04 01:07:56', '2026-06-04 01:07:56'),
(163, 1, 'GStn6WvOhl5m4ap31pSpEvE10tnF8dwpoIexZqjxVYggfcHCE2Ne4LnVsf8kkzkyhPGgxH5tIYc7kNzH', '2026-06-04 01:08:56', NULL, '2026-06-04 01:08:56', '2026-06-04 01:08:56'),
(164, 1, 'mGEzxAkTLzyLCCwGlLkBSuR1ZQqKgnw7amVkwEkIHviVT46pJ9L0t3JtSYkaC8YV31ggMfNYWsoh4I02', '2026-06-04 01:09:56', NULL, '2026-06-04 01:09:56', '2026-06-04 01:09:56'),
(165, 1, 'vgjBpsiH0BgSeI5M7HnZOLilf6rrI5ptyQuWkF1CGBJE6JYjQBq4OjPGAziHO25ThWD1ny5Waj2tue1u', '2026-06-04 01:10:56', NULL, '2026-06-04 01:10:56', '2026-06-04 01:10:56'),
(166, 1, 'RS4P1ZM0D5bzK21YlFz3Jh92laCN3YEe5VW2X1ZaqN1dW1nWYUhBlsjuSgO8Jg0P68lkUaawtYTe1q1o', '2026-06-04 01:11:56', NULL, '2026-06-04 01:11:56', '2026-06-04 01:11:56'),
(167, 1, 'lsBAdNKnMPFEKVM6eQQbRdIrmCD5wS2IvMAZ1sBHjhjHOIEt0zzzaz4eqLFp0REwiFu6qgTVoRyERRDX', '2026-06-04 01:12:56', NULL, '2026-06-04 01:12:56', '2026-06-04 01:12:56'),
(168, 1, 'HsHdfE78w5d5qtbIjllBNPOwVwYnfK6RbjTFinaLRvL9IxWMQbIWrvbf7EVMJ4l0q18m8RShGqT7DCCO', '2026-06-04 01:13:56', NULL, '2026-06-04 01:13:56', '2026-06-04 01:13:56'),
(169, 1, 'BiwnvZwLQlWduokE1aeqeSEk9TojEEcL2G0S4WSJYCFSZGpnz3Rf5t0q14n7RHjfN4vkN6ZJzioqAgAY', '2026-06-04 01:14:56', NULL, '2026-06-04 01:14:56', '2026-06-04 01:14:56'),
(170, 1, '4EocqVi9BHkSIpaWrCxErE9CUSuW2YczfBRza2vOsLSgjmanQQJSj6808qo44NsG69oFZUNJ8eEOjFv0', '2026-06-04 01:15:56', NULL, '2026-06-04 01:15:56', '2026-06-04 01:15:56'),
(171, 1, 'GhWpyPtQSuiZ0EWo860023j5DAxCDOGqh3RJs9L9mq6SRuZsPvQLE9mnBvwaKZWh5GgNxr35OwQc1utM', '2026-06-04 01:16:56', NULL, '2026-06-04 01:16:56', '2026-06-04 01:16:56'),
(172, 1, '5pm9vTgo48QlIPu2MRSQHdqx4YW8zpsCtFz0jKsGOPeageFdx2leWI2NqTFfmgOJMkMchgJReROeuIkE', '2026-06-04 01:17:56', NULL, '2026-06-04 01:17:56', '2026-06-04 01:17:56'),
(173, 1, 'tuQDhoq0JRMHLPSZbVDRSMX8ZENk6xx2LuMMtOFNWe3L4uWy0IMY2MaC6iYnN7GkSfTeCh7z64O7DEtK', '2026-06-04 01:18:56', NULL, '2026-06-04 01:18:56', '2026-06-04 01:18:56'),
(174, 1, 'zEcbtlvQv6AiK8m8OSvkkcC5YpEBytcgwEkjfho3fSd4xw9tFYJ0vJrrdldt0ffAdX1XH8WH5Yr4dLBa', '2026-06-04 01:19:56', NULL, '2026-06-04 01:19:56', '2026-06-04 01:19:56'),
(175, 1, '45FrZFCodG33Onw2JnWB7F9TeH9xZYKFdeaMSZqLaP2aiZr8hWUDUdRpP98RIEnnSLRf1SB4HupXJFbz', '2026-06-04 01:20:56', NULL, '2026-06-04 01:20:56', '2026-06-04 01:20:56'),
(176, 1, 'jodcNCfArfWNZ9C2fMdaTI4QwxTodFAU5VVa803eHPd7hLmpM8riYg9oY6m3DKfdO7t4C7wDN8DKZjhT', '2026-06-04 01:21:56', NULL, '2026-06-04 01:21:56', '2026-06-04 01:21:56'),
(177, 1, 'SmvLVRRR8TqLWJIVPkl5GChL8jT5hfquMbx3bv0VcC6FooUpHWgVSkpAn6fz6j9jP8JZkpJ7Bql3cfeJ', '2026-06-04 01:22:56', NULL, '2026-06-04 01:22:56', '2026-06-04 01:22:56'),
(178, 1, '0g8C3kwpzjRsOJMJw59scuzMFv2X6AiL6f3wM25rd6Ln2Smd0uAwbxlyxZJjMZDRPy1HUt0CJWwFILfu', '2026-06-04 01:23:56', NULL, '2026-06-04 01:23:56', '2026-06-04 01:23:56'),
(179, 1, '4E36rgDXBjgDCOgKjAfBbhhjPOGOM9s4ykD2qdJJXQAiXGjmZksXRfwcrJjcGovmXlP5JJGBrGWvBfEi', '2026-06-04 01:24:56', NULL, '2026-06-04 01:24:56', '2026-06-04 01:24:56'),
(180, 1, 'FjJe67SFZVbpNGMXj27UTAPwISoScKQ0pQmRvl1AhM1GhFCjAfN9PpTsU5RzqDsREeTFZsLQZjsKSlhI', '2026-06-04 01:25:56', NULL, '2026-06-04 01:25:56', '2026-06-04 01:25:56'),
(181, 1, '7orOxxE3ruJe5sE8pG4Jcc6vkKEKmrmUyOUIqDwsnpjJ7pqJef17kJvnU2Qo1Jo6YjmDk8MZpUHVIXyY', '2026-06-04 01:26:56', NULL, '2026-06-04 01:26:56', '2026-06-04 01:26:56'),
(182, 1, 'IzVBS9LVLeqZvOkc6gMJbJqEjaDnDWJDD0hQ7rk9wSieYoqytyVIxC8GSY4K0Lc561pqW5o5clbEx6Qt', '2026-06-04 01:27:56', NULL, '2026-06-04 01:27:56', '2026-06-04 01:27:56'),
(183, 1, 'ObXJRU4yqPAhTkfEAJWK0jr6S6JMgT3wSjPVvHrQavpssVak4VjBYUXqf6X9QCf2Yk35eiB6n0Bm3sIp', '2026-06-04 01:28:56', NULL, '2026-06-04 01:28:56', '2026-06-04 01:28:56'),
(184, 1, 'SDVyxTIlgXZX4JbFpYSX9NoQTqjdzYRO9IuIXIhIKqSLsDt99s6jGlE3EYRQB7GNXqFgoRsXTsXGCaNt', '2026-06-04 01:29:56', NULL, '2026-06-04 01:29:56', '2026-06-04 01:29:56'),
(185, 1, 'HCcEny3FxxF5JhgEGtIr9ViFj5VxGjhDgKdkwGLy16oZKIGB9mYGhW7a2h1QSRKup6ypLkfPgyRMvNJf', '2026-06-04 01:30:56', NULL, '2026-06-04 01:30:56', '2026-06-04 01:30:56'),
(186, 1, 'apHVIZyBbamQwQXHcfgkLbZOSwMTCYr0f1XZS5LyZ8pl1Zxd2NfPNnyBS4oATQD07hU7DasOzbpDJkk2', '2026-06-04 01:31:56', NULL, '2026-06-04 01:31:56', '2026-06-04 01:31:56'),
(187, 1, 'kFTtX6J83l3T6giTrlTbIGsTiQ0KOEw2Mh6800Euh6XC5KV2jq1gfmBhxf07RCbwkiBitLwP6kAH5nE2', '2026-06-04 01:32:56', NULL, '2026-06-04 01:32:56', '2026-06-04 01:32:56'),
(188, 1, 'ub87ZKWf5ge6Sx5gzPzwEjv0FwqsvRf7bKCGPQXUtQAgctvMixz3jai6mTbEwZbZNbCpVdGJ7A3DYm84', '2026-06-04 01:33:56', NULL, '2026-06-04 01:33:56', '2026-06-04 01:33:56'),
(189, 1, 'JWgnnzKFKyLKrrfTkZfgNhbG6v0uHZH5EOKbORq2NLGyT5kz7ndr0okvQ42szf90CPcoRIW0PQOjbkWQ', '2026-06-04 01:34:56', NULL, '2026-06-04 01:34:56', '2026-06-04 01:34:56'),
(190, 1, '3r9cLEI99f3n084APF8hUcRe2WKHX76yWtpqulqCR8WueP1Ol75o9DxwdH4S2YoJquNXQCexF23evj42', '2026-06-04 01:35:56', NULL, '2026-06-04 01:35:56', '2026-06-04 01:35:56'),
(191, 1, 'i6CrxcRgYtxJTnpYJYeNfRyNiAFvUc3whbyfx5lvVFxBenjX4vROcYsqEpCg2gtaixpWtH4peLeDHT3S', '2026-06-04 01:36:56', NULL, '2026-06-04 01:36:56', '2026-06-04 01:36:56'),
(192, 1, 'lO6hgfDHyBlEhUH8p9w6Q3bLa96Lhvutc4PTAaQyRoGYUOvjyGNitg8pcLH5agOHfaAuhBRnFXgzIJyK', '2026-06-04 01:37:56', NULL, '2026-06-04 01:37:56', '2026-06-04 01:37:56'),
(193, 1, '7TxG7O3v0Kzddr325sWF6eo1okF9F2Qqfcc67sAG6GyjymTMwGFkQ33e1owL1Gatgv7kW8mllYrGxHQz', '2026-06-04 01:38:56', NULL, '2026-06-04 01:38:56', '2026-06-04 01:38:56'),
(194, 1, 'HTyVm9pG1Bw7C27xT1ZSNYiMwCM1YiZCxvxD322AH1qr0yFdWnQK4YL9CKO6ytgtwDXA78eWxV1nWYlJ', '2026-06-04 01:39:56', NULL, '2026-06-04 01:39:56', '2026-06-04 01:39:56'),
(195, 1, 'rkYQTslsW3KKZlgRD1yYr3dNI3ylHn3d8RCildEB3KkaeQeEPu3m9EglMaAOOOlVp5RgJWzccD8UvxVr', '2026-06-04 01:40:56', NULL, '2026-06-04 01:40:56', '2026-06-04 01:40:56'),
(196, 1, '5DDOp00loywkEIv3354GXIQWVKvi2QROh0n2HtGdSRlcvD98nGuH6r9jYyJyXY9SS54po6WR1tOR7cNn', '2026-06-04 01:41:56', NULL, '2026-06-04 01:41:56', '2026-06-04 01:41:56'),
(197, 1, 'ZPnAx1ZxRWV4SjAEepFIrL3p48mRr5ic9x39rX2FhTKNc3OiCn6hYbOWXpZ7V7xilPZdbIDeGnUlP7dY', '2026-06-04 01:42:46', NULL, '2026-06-04 01:42:46', '2026-06-04 01:42:46'),
(198, 1, 'EHK3rhd214ZAdIgMPt8n6cDMVZr9pfEFTgD0lAylUll8Otg8C3L4pWcajfWygDh1C9cW9nC1nXk6llZt', '2026-06-04 01:42:56', NULL, '2026-06-04 01:42:56', '2026-06-04 01:42:56'),
(199, 1, '9Ko2ZB0xOlyHvd3BcPjf1mbSWQsH1IRiq3SI8etFR5pxyb21bRQXShJLhoQjM03TlQWpE58nIXnKgtN8', '2026-06-04 01:43:56', NULL, '2026-06-04 01:43:56', '2026-06-04 01:43:56'),
(200, 1, 'pRiJduCArI6YAtrKYFjDy0IP80CJcV2BBVsaHUbpJ5GNG9h3QDWgY41mDIWqQQeOkGAVNmeF1VQQNEMH', '2026-06-04 01:44:56', NULL, '2026-06-04 01:44:56', '2026-06-04 01:44:56'),
(201, 1, '1xXeew4jR56p2lAOJULYkgk4YMznxv3DbYJ8TIPULcH5zGAUEY5VRfD7R2Oacis0KkOdv6yT3GouNP40', '2026-06-04 01:45:56', NULL, '2026-06-04 01:45:56', '2026-06-04 01:45:56'),
(202, 1, '09DTyKwmEptOuCW38c0ywj7UBXLwWjgtsjTh7RqBRN90T7MIpQzyGb5cuRuphIpsJ6D5Cu9r4bY2hAo5', '2026-06-04 01:46:56', NULL, '2026-06-04 01:46:56', '2026-06-04 01:46:56'),
(203, 1, '95Yd0mWSVejRTE08tahp1MX4cYD7oJRzRvCm7uKEVSCGItblGnOVA49VZ0wD2WyCif49JL7vHPoKr0v8', '2026-06-04 01:47:56', NULL, '2026-06-04 01:47:56', '2026-06-04 01:47:56'),
(204, 1, 'Z7CJevr2wwIaIHIraBmQHYFa5KU5q2bqxnD6k4xuEdKUE0tAY6cC0XPLLRDaCRWJrwHi0MB571q0HzQd', '2026-06-04 01:48:24', NULL, '2026-06-04 01:48:24', '2026-06-04 01:48:24'),
(205, 1, 'nzJ5qf5987HSP2yfLmYDw2OsHOK6S0SKFNXr9m2v5HGQLRxVtkB5MnKRMBImxLyIeqO8ebNYeuYom30o', '2026-06-04 01:48:56', NULL, '2026-06-04 01:48:56', '2026-06-04 01:48:56'),
(206, 1, 'BM4kR2oB8QLNL7R6nyFKAdDvqCKOHgQ9YhbpmuiygjUNbEG39GqqdizGLMcc8t4SQ6nVpvpQ0hIkMlCz', '2026-06-04 01:49:56', NULL, '2026-06-04 01:49:56', '2026-06-04 01:49:56'),
(207, 1, 'q7tNAGvrxQuao6m15IlAKWdkbjo0GkksOa8R3ndmmMNPcLt8aJr4JLeMi3Eu6sjAmILLaikHzVIDjsmq', '2026-06-04 01:50:56', NULL, '2026-06-04 01:50:56', '2026-06-04 01:50:56'),
(208, 1, 'gEQv9703aPsS7IfjHNxCzyQvuAxO526O8ePn0sQczmdJMLhvZIvrkS1GmIaiH0e76jJ6qQWxEX2QRKuk', '2026-06-04 01:51:56', NULL, '2026-06-04 01:51:56', '2026-06-04 01:51:56'),
(209, 1, 'ECUwrM28AZUTk5G5nXWlvlb3UEEPlYvZD9uXw8C5SVJQxOXfkThb5NkwBMvOhWfPEUp6mXFLLU41a00D', '2026-06-04 01:52:56', NULL, '2026-06-04 01:52:56', '2026-06-04 01:52:56'),
(210, 1, 'v9pXHfQrIqdSYbZlNgG74dF8Ro3dbmDB0Wmc10iu9T1I19T9vDvfbTCngxjFEGu1panrbvodFuz7skAF', '2026-06-04 01:53:56', NULL, '2026-06-04 01:53:56', '2026-06-04 01:53:56'),
(211, 1, '0gFHjYsXXvawkGiNhQVPtTWaKvJCktK0BGgZVHJtR2snB4O3fgq2rMsZ3gpnTX7kuXTajcxvN5zVDfZu', '2026-06-04 01:54:56', NULL, '2026-06-04 01:54:56', '2026-06-04 01:54:56'),
(212, 1, 'ToFGwoGjy7PirDpoZd7NMznqHWbHXZ7SznaLCEgfqWj8LmdBNOLdjqm6n8ZICU7kT9yfaiasxVPZ3llO', '2026-06-04 01:55:01', NULL, '2026-06-04 01:55:01', '2026-06-04 01:55:01'),
(213, 1, 'Qt62SSUCFzdEpQy3stnHlYas9Jjv2XeJR9PvK6FHMO9thmt9cojqwIiOJ8IGB2ZIgqcluajGNin7fB5T', '2026-06-04 01:55:56', NULL, '2026-06-04 01:55:56', '2026-06-04 01:55:56'),
(214, 1, '16xLZGurReOe0OlUWCBRyScwWhPeTIuVUTTMd7kjRP7SBxEdJYNWZXxW8zna1JIIotHnIjUExCQK9Yeb', '2026-06-04 01:56:23', NULL, '2026-06-04 01:56:23', '2026-06-04 01:56:23'),
(215, 1, 'tmEqYxzqaHzLXXWQG06TMqfpQG2P6ToMdFjCSFQcnFe8BwxIWToYAtgPRC5w3jyKswg8d7asjcMNJhvq', '2026-06-04 01:56:56', NULL, '2026-06-04 01:56:56', '2026-06-04 01:56:56'),
(216, 1, '9vVS87K8mEYQ7iHlnUXryIUwjM5hfZaq4ZEmq5S7xNAvQq6gzyb1XGKTI3GFUcR2dMlAR1nQZMChywz5', '2026-06-04 01:57:56', NULL, '2026-06-04 01:57:56', '2026-06-04 01:57:56'),
(217, 1, 'JXZXpvXmOZTgoZ5ErZaBGDJyrdjZNBVecPpx1bBIfhHXJDbAyXQ5lbiv2MoHngYXyZZEOqgEE8NKBTtG', '2026-06-04 01:58:56', NULL, '2026-06-04 01:58:56', '2026-06-04 01:58:56'),
(218, 1, 'jQ2AWsZkWLG54sAg2A1OwQ3I0sEYMb9g1IpT5tdAQnPgMBNKh3qTNb6v1wf3y2Z9gvCJIPNXH9ouixXe', '2026-06-04 01:59:56', NULL, '2026-06-04 01:59:56', '2026-06-04 01:59:56'),
(219, 1, 'Vfv38zGg9RWwfPpP4lZ3SEAEZ1BzeKUkuX4nkErrqe1XWbOzzHoiybij2zNLHiv5vauZ97bOmIkOadaz', '2026-06-04 02:00:56', NULL, '2026-06-04 02:00:56', '2026-06-04 02:00:56'),
(220, 1, 'GuNHcjoahBWfM4ityuSHdwIRvPpsnqi8zAcHT5sUNqPao1dedbjCjeLwlIPw6KfFhEmWLUr8xXLO5BPD', '2026-06-04 02:01:56', NULL, '2026-06-04 02:01:56', '2026-06-04 02:01:56'),
(221, 1, 'Aip1DqDuetvKfGHxEAnVZj8lXD8Mx1JVByGXhxVZObWp5cIQGLcJK9LfoaUhIvsC8AKJhOyyR3pK3vFw', '2026-06-04 02:02:45', NULL, '2026-06-04 02:02:45', '2026-06-04 02:02:45'),
(222, 1, 'IV3bemRTXGpU2MaXb3iMV4RzTqpMphIqfeiiqOB8Wm00rq27QZIN8tUwklg91IPSYGUUQKKg3SpSlLTS', '2026-06-04 02:02:56', NULL, '2026-06-04 02:02:56', '2026-06-04 02:02:56'),
(223, 1, '5gXZjlnPSnEigGYqnVhHz41X2J7Nxoy66vbCsVL2YjcdtuvfSrorbjOk0rA3A3cSKGyEJnJHP3w0Ihai', '2026-06-04 02:03:56', NULL, '2026-06-04 02:03:56', '2026-06-04 02:03:56'),
(224, 1, 'luIiLKnKGBshiwReRJkIAQImD90fWdUx3duczD5lOkk5NUuRWGbivyDnpH0jLYTjJ7HQYCuwhXGxE2KB', '2026-06-04 02:04:56', NULL, '2026-06-04 02:04:56', '2026-06-04 02:04:56'),
(225, 1, 'wPKCRdpA7YGEu6YbKTY8jsKOdiUcIkltVlGCyds0gqXQZxclOxabaiD2Tv4fEn3WPRUb6hp84DXhSzkk', '2026-06-04 02:05:56', NULL, '2026-06-04 02:05:56', '2026-06-04 02:05:56'),
(226, 1, 'stszJnfTI6K77YhEJDr26fMOnGwwEbMsTOApKqAp2eGD7tmfYMS5Lb6SuskdDzshYB22xtMKim7XB8FS', '2026-06-04 02:06:56', NULL, '2026-06-04 02:06:56', '2026-06-04 02:06:56'),
(227, 1, 'Vq5qT3PoZ96CurXtk7dMy7YmWdjNc5J1FeWCweYVgJbx4NmZsBpji6V00gDYBazYmpUdQqx4DNS5ed2T', '2026-06-04 02:07:56', NULL, '2026-06-04 02:07:56', '2026-06-04 02:07:56'),
(228, 1, 'ZSw403M1GCgo1yaP5IN2XsLCBhgoVqGywWGtGfq5YSASKKoO7doxfVZ9DKuWpgFJt6UsHExuKplqCwMb', '2026-06-04 02:08:56', NULL, '2026-06-04 02:08:56', '2026-06-04 02:08:56'),
(229, 1, 'ObUqPsOj75slGdtIrLHBMS0YFDt4TS6Zk4esYW1gIlegeNCS9A4VNzZopgd1Zz39Btzi2inePVPIzZ0Y', '2026-06-04 02:09:11', NULL, '2026-06-04 02:09:11', '2026-06-04 02:09:11'),
(230, 1, '67qeoNZoNDVHeGLOX0xVvM2SvNXCbZ6rzTd1f8erg7dJwmUJoJv6tI1gqtrx8hJGxGQBePh6ctHHYWpC', '2026-06-04 02:09:56', NULL, '2026-06-04 02:09:56', '2026-06-04 02:09:56'),
(231, 1, 'KDTdWEOUbGESeaPGimWpPSsKgtsbBaunVgMbR5SKZ0qnvv57eytqqxbrDRTuLxGI9buxQKyXnBF6Isvj', '2026-06-04 02:10:56', NULL, '2026-06-04 02:10:56', '2026-06-04 02:10:56'),
(232, 1, 'xCwoeRvslvpRVTme2CsDrcSM2MXih0ZCitMt8okr7mKcbR0gwF7pgtaUSSwkoH8zpVFexYhxT21WAS7b', '2026-06-04 02:11:56', NULL, '2026-06-04 02:11:56', '2026-06-04 02:11:56'),
(233, 1, 'klHWgQSZF3hReKf9y5mTYesyLEk0y9wX3XlofdznNQiZ4ZNSpKRkSdCR24PDbr426N5JOFQg1HezB0VP', '2026-06-04 02:12:56', NULL, '2026-06-04 02:12:56', '2026-06-04 02:12:56'),
(234, 1, 'cWWjqwAGhusWrMjjPwnqIIGiCvtdp6fnQJdzLi3riSNGd2ZzKtGQH1Z801lSXcPkwXxveQg9WllfI8go', '2026-06-04 02:13:56', NULL, '2026-06-04 02:13:56', '2026-06-04 02:13:56'),
(235, 1, 't0G4Ilu3gwiNLab7p2tgsaN3ozWBXrlww0kAtaZDfhP6z8OF3wGlPrREEduWr3DS8ddmPps8PDG1zlv2', '2026-06-04 02:14:56', NULL, '2026-06-04 02:14:56', '2026-06-04 02:14:56'),
(236, 1, 'tNVVbSxkD6nzwiSE8DGPCA9urOxLyyfPm9NsARdCn82E0riQVFH5nUKey2T6K6tlI3gOvjMigKzMhPB4', '2026-06-04 02:15:56', NULL, '2026-06-04 02:15:56', '2026-06-04 02:15:56'),
(237, 1, 'qWMNQ9HTRtjGbS6RNJxWK0QchNvGpzddOXUiVOEUuhbPtGb4543a8LCqWr2xQZnvLLwhaNvbHMF1EP9H', '2026-06-04 02:16:56', NULL, '2026-06-04 02:16:56', '2026-06-04 02:16:56'),
(238, 1, '8aCQFonAFvT7g1v24iaN4SzwXB52SBswfGtmzZPMzMCY7XENM6b81B1gKcfw0vRA3Xdd51xVRTKnAbn8', '2026-06-04 02:17:57', NULL, '2026-06-04 02:17:57', '2026-06-04 02:17:57'),
(239, 1, 'nNTUFcFYLAiSNfg2SXvj6ZIXxGSWUoYKwkZnU3iR1LNX2kwmTFpIDtnkYzpCP1x3MyogUHUWGfP6txBC', '2026-06-04 02:18:56', NULL, '2026-06-04 02:18:56', '2026-06-04 02:18:56'),
(240, 1, 'hQduf8hFWRtVELAtTvkoUZRL623QEmGeOhMj4tPqRUrhngEjI5AgbGXCDFUA9anvukvZPv3aWa9wlUXt', '2026-06-04 02:19:56', NULL, '2026-06-04 02:19:56', '2026-06-04 02:19:56'),
(241, 1, 'PwxxWi8wyOKinEuPFK3R7BvL7ctbz8N2j9sOO49fAESQrQF57EJz8edt0pwBVZWzsL4LfwHpQCzwfNyG', '2026-06-04 02:20:56', NULL, '2026-06-04 02:20:56', '2026-06-04 02:20:56'),
(242, 1, 'fLAUCFl2DxlAxLLenNkS7bCaT9zrrTUpHMb9JozOCKZQucAwr6QR7gBbJXf0jKMSTsLN2NzSlUvRMzvl', '2026-06-04 02:21:56', NULL, '2026-06-04 02:21:56', '2026-06-04 02:21:56'),
(243, 1, 'zXWgnozjsNsrcuDjGVG3tOzOEMPaSsPgt2P20LKK0L9bQZDE2TfMQWVBPryoVLlOlMKeY25UNYIz9Zgt', '2026-06-04 02:22:56', NULL, '2026-06-04 02:22:56', '2026-06-04 02:22:56'),
(244, 1, 'mW5UMlZAEw3eDF2cmMRZwNGkQIz1PstlXcGGnrMmgKCuubTGBLZ0ZjG4ejkbdPbErHYPVEfii0sOwheX', '2026-06-04 02:23:56', NULL, '2026-06-04 02:23:56', '2026-06-04 02:23:56'),
(245, 1, 'dZgrFUBRB4STirc5NfQnYjYQ7YW5Bk05AeBPdu0EEMMyr0voCGgWHIZ4gklf1XAKfzRvj2iz3nWw2Tvz', '2026-06-04 02:24:40', NULL, '2026-06-04 02:24:40', '2026-06-04 02:24:40'),
(246, 1, 'tYlZ1r30DnZyMngoxEjvvb2x5sfLbc3xYmZdnnsPWi27ospL15wC39ek92cEsN0dFJYPiFLEl7jm0gDf', '2026-06-04 02:24:56', NULL, '2026-06-04 02:24:56', '2026-06-04 02:24:56'),
(247, 1, 'uyeHxXRQe5hPRLRpRIj0UVO1wY5vsFTvkxh8Jf8sc5U1qThZRHKOvup0qffkfzfMTPd63byMx7x1TgJR', '2026-06-04 02:25:56', NULL, '2026-06-04 02:25:56', '2026-06-04 02:25:56'),
(248, 1, '2k6M1NdWgSnAtIayKe7CN4BP2pUOAtuOrrYZwHpRqAAGkFCGCtS5atrIJc9ZpdAcPDnBg09FV6ZPgAqb', '2026-06-04 02:26:56', NULL, '2026-06-04 02:26:56', '2026-06-04 02:26:56'),
(249, 1, '2ASqQXvIhrUmHJAV4Hh2c17bxvINQLMJRJIrCFkAEK8ZARiLXySdXnk6xaYjvmj01kFzx1FuKrMjDq4y', '2026-06-04 02:27:56', NULL, '2026-06-04 02:27:56', '2026-06-04 02:27:56'),
(250, 1, 'wNOTgdZiNljPZeIBz0KT1bM7sZRdMYr74mRlwSxUX0khbmWlYzuxnpbg2ZfdUyXYxMf0tWjjMqZ2AoxO', '2026-06-04 02:28:56', NULL, '2026-06-04 02:28:56', '2026-06-04 02:28:56'),
(251, 1, '3YXGMTw3KWopafl2jnPbk1yAB0MHydzkz4HjvD689iBc9fn5LYn8S1YrVPjmMBtj0IrilQp6JxA3i8Rm', '2026-06-04 02:29:56', NULL, '2026-06-04 02:29:56', '2026-06-04 02:29:56'),
(252, 1, 'UM94TI2D41NQBr6p1mm75YT8HzEdJmeSgBM7AM7ZrW6efiMT1z5CJffe3HySypBePM59doztapEG2no3', '2026-06-04 02:30:56', NULL, '2026-06-04 02:30:56', '2026-06-04 02:30:56'),
(253, 1, 'm7JpMSn1q1xHUqoX7d8ZPzZQQBfkIztxTEL69IoXOukLAuVkaIz6KzvDk0lTwHsNVWA3OTt90f8Z84Q2', '2026-06-04 02:31:56', NULL, '2026-06-04 02:31:56', '2026-06-04 02:31:56'),
(254, 1, 'u8f8Fk6yEd2JrgrDkhENTgJCBZ7cvWl77hZbNxnsJaEOeB9x7GwnSYHkxFqDvYPIDy3MzuLWTYFdGIw6', '2026-06-04 02:32:56', NULL, '2026-06-04 02:32:56', '2026-06-04 02:32:56'),
(255, 1, 'kOzFdq7plhRQKHjOl0JWOajLj3G219fEKE0mRYQbBN00wZfA3Z3mOsCznIEjFOAxe1mpqX9wV40dnCAb', '2026-06-04 02:33:56', NULL, '2026-06-04 02:33:56', '2026-06-04 02:33:56'),
(256, 1, 'EY7EPwT6HiJNoMRmzkFafQ2Nm7bC2UfIM3Mh03T1mE35q6sRNGXZTZ2gaVtVWdJao7acVCZFsH9gGQsS', '2026-06-04 02:34:56', NULL, '2026-06-04 02:34:56', '2026-06-04 02:34:56'),
(257, 1, 'hnl5jSvhdBqNByeFoIDchtI0X5qkOjqCaJPCf8P71DJ5QRezVDRpKXTGiG4wSHqBFe13t9qZbUl9pmlX', '2026-06-04 02:35:56', NULL, '2026-06-04 02:35:56', '2026-06-04 02:35:56'),
(258, 1, 'k05VrwBREYM0slyomFuiYVfdykMmIK2A6pB8mkn9fxxAAPkhqtColUOgG1Yk5ed19W1jUA2cWiwjmhRY', '2026-06-04 02:36:56', NULL, '2026-06-04 02:36:56', '2026-06-04 02:36:56'),
(259, 1, 'JflWl4i7K7webEKuQZqaS2jK5epzjeF0TGybCoDyse1GBScgB4VY10EMI2T2doYN2ysWfLiyzq8bKksb', '2026-06-04 02:37:56', NULL, '2026-06-04 02:37:56', '2026-06-04 02:37:56'),
(260, 1, 'IvvAiOQUsNyW2DXu9cpl9GTAPN832ttRhhS1zgAQq1IhOLolyTB5shb1e6eu76HHIFdWlknriOcMlFgk', '2026-06-04 02:38:56', NULL, '2026-06-04 02:38:56', '2026-06-04 02:38:56'),
(261, 1, 'y3Su2uRdAMu160GMY2zyb3WFDZ5Lc2GGbWwkKwUCqNg3tYUu5mG0dunpP9Vk0xqw1KCFZvcExJ2sWnie', '2026-06-04 02:39:56', NULL, '2026-06-04 02:39:56', '2026-06-04 02:39:56'),
(262, 1, '4GFtRAYB85z53zqVqdiImOmYKnYxEoD1GPAYkPHxlnBCBlCtbgmX36rLmyqqMmSJcZCSAcNihrwYVbq6', '2026-06-04 02:40:56', NULL, '2026-06-04 02:40:56', '2026-06-04 02:40:56'),
(263, 1, 'nZvnGrWdeoR48AhK1sny71stk3eK75mgPUAi3eEtzTu6t6CIFyg0YAl3gS4QEJ6NReKIGNLuRHDUnDR2', '2026-06-04 02:41:56', NULL, '2026-06-04 02:41:56', '2026-06-04 02:41:56'),
(264, 1, 'XBNeoeWOCCoGYEs0a5YS5nFscTsQ7rtssw0tV7adyargsiT1EVOlO5tQ4dV76O7eeN25cZnoncaAg1PN', '2026-06-04 02:42:56', NULL, '2026-06-04 02:42:56', '2026-06-04 02:42:56'),
(265, 1, 'jHLUGryEP6AUvYV2sJJ5e1LdSwUKf9MMcybEGU2eB4v0nqlxkUYdACSigu46K6K2C1bpaYpnHbyR5iyv', '2026-06-04 02:43:56', NULL, '2026-06-04 02:43:56', '2026-06-04 02:43:56'),
(266, 1, 'slHrcrl4KyxtepCK2LXablUbryNy4lJ5GzdViBmV5olYsbbJegFOUvHe3xeeCVlBd25vMsuigBQT9ob1', '2026-06-04 02:44:56', NULL, '2026-06-04 02:44:56', '2026-06-04 02:44:56'),
(267, 1, 'PYfAoLBQCR7CjIYTwN8ds5rfcRSwKnvUZFLTaWv6Q4Uc46Jjvh3Mo0lD12Ktj1ziSNrx9vSa6o2GG7i2', '2026-06-04 02:45:56', NULL, '2026-06-04 02:45:56', '2026-06-04 02:45:56'),
(268, 1, 'peRlPx807SZB7G4QW7B59vixBMWhOB3Jg82TYotWnY4ztFHaztcdlUY89m8578OJBuFEl8FMEMFmUz3I', '2026-06-04 02:46:56', NULL, '2026-06-04 02:46:56', '2026-06-04 02:46:56'),
(269, 1, 'AnFPSrHxbb3XyOP6OvRZiII8YRsfZSfdBYVx88VLEZisLTA56Zz2sRMAa6xxSyOHjjO6I4QlNFJ5Y1pN', '2026-06-04 02:47:56', NULL, '2026-06-04 02:47:56', '2026-06-04 02:47:56'),
(270, 1, '2gzOLSxPOo1LzQqOswQ7hntfzXixMwM2BWKKtWhAzxrYRTaF8i6ErEw6OzhcLw9Jvw4IUPyH09NC5biu', '2026-06-04 02:48:56', NULL, '2026-06-04 02:48:56', '2026-06-04 02:48:56'),
(271, 1, 'SKIl8VWXFxlEQzVWyYgJqjac6oaDFYpFHpsoWhLYARB82sfIoJT9AAKUp7tFVyn1ClUns5ITMFtzqWY4', '2026-06-04 02:49:56', NULL, '2026-06-04 02:49:56', '2026-06-04 02:49:56'),
(272, 1, '7WiFyXgd5ln9fyAvBvZqs4xojBCydqc8eKeT7OQ2PMDcrrrJtYGjbq6gLKtxdAp7W1w2IXmtLrxUQymy', '2026-06-04 02:50:56', NULL, '2026-06-04 02:50:56', '2026-06-04 02:50:56'),
(273, 1, 'IR0JNhSTWZkCtISKDzWgDPAk5csYVxAh2pY2B8ry03ujkjUD3MY3OhRbMoOsjQP75M0BdqeGw11hJXKy', '2026-06-04 02:51:56', NULL, '2026-06-04 02:51:56', '2026-06-04 02:51:56'),
(274, 1, 'SR4rjpo9yTPXBuYFiuOB2ZOuj7pEt34PJBkR9xiTxeEwouWuimD470CbVRSfQOmKLjQ4Bj6BRBUOT1se', '2026-06-04 02:52:56', NULL, '2026-06-04 02:52:56', '2026-06-04 02:52:56'),
(275, 1, 'MiAhrUmc1wio0N2AG00PBurVnapmOy4FB9L5eTT6BDCrAwZktjAlXJJ5YxNRLoYR4dikxVFZ4YfvcqD5', '2026-06-04 02:53:56', NULL, '2026-06-04 02:53:56', '2026-06-04 02:53:56'),
(276, 1, 'WQx4ouTSXnD6ATax6d9JPG3bdNzG8PybQXHM7TcGPRNsnkNAXtwRU47ugwbfzAFP1I3lzWkOj7SyqnqB', '2026-06-04 02:54:56', NULL, '2026-06-04 02:54:56', '2026-06-04 02:54:56'),
(277, 1, '5xJLZUYtLmbhrd776eIDeCiGuVJTQD92geJdhLG8vKswaFFFu714P88YZWvYOsJqG1tQ8vHhDFAq2KYt', '2026-06-04 02:55:56', NULL, '2026-06-04 02:55:56', '2026-06-04 02:55:56'),
(278, 1, '3Q7KNxClkBoqGi9IZVWtubqyBSvuST1kRByMKMOvUSgowarUtScOeNHClvsSpzYPG8QBmuN1KZgzBREu', '2026-06-04 02:56:56', NULL, '2026-06-04 02:56:56', '2026-06-04 02:56:56'),
(279, 1, 'Wsgbnj2ToayTHA2x9MbQZ7Waoj5X4mb23rUmy3U46bnr9or6Zd79EDMNT9o5yUQJHyHvDIgBOnsKMYLt', '2026-06-04 02:57:56', NULL, '2026-06-04 02:57:56', '2026-06-04 02:57:56'),
(280, 1, 'B3IGzaJj4McqwgY9uyt7RrFHvhib79f5XjkhmDszelLm7MK0zwOnNvwFifgwTbwmsuXxfLn7hZtQrMR1', '2026-06-04 02:58:56', NULL, '2026-06-04 02:58:56', '2026-06-04 02:58:56'),
(281, 1, 'pgg1FDh2reGmEb4GD1k4FTiVXTIAiVD80z8bxurrKtNCx5goeFb5QEH0aaa6Bdm1jdqjMfDAz3VvCdA8', '2026-06-04 02:59:39', NULL, '2026-06-04 02:59:39', '2026-06-04 02:59:39'),
(282, 1, 'XlwjQkyITddVFq7bqOy1WNsP2A39xzMaxsgr1jSEgf6sEWyG9GOKAhb6xpJu9bMzgRUTdSummbUFzbKG', '2026-06-04 02:59:55', NULL, '2026-06-04 02:59:55', '2026-06-04 02:59:55'),
(283, 1, 'NxBbB1SisakX15n9M1ayAZS8hVgTNtqsx8HbZvP3Y8qkD0Z0ZlLDlSH6Ntujpl3TzOEPIQb3dC1Ju5qC', '2026-06-04 02:59:56', NULL, '2026-06-04 02:59:56', '2026-06-04 02:59:56'),
(284, 1, 'jgsIuFqqPmmNhd41VsWMO2KsrwlrzDwf4Ra7pmoew2f5MI7NsJH2ssMDZ1uAyYQKAMd56fCgooc9aG1a', '2026-06-04 02:59:56', NULL, '2026-06-04 02:59:56', '2026-06-04 02:59:56'),
(285, 1, 'pgRps8XpOg2QwmkaxlHwwAkB1IpbsY9FGDOWzB1PW3vb2ikJcJIXduzcVwxdCYDFOFaevvXac51abRAi', '2026-06-04 02:59:57', NULL, '2026-06-04 02:59:57', '2026-06-04 02:59:57'),
(286, 1, 'Oh95lzhI3y1iZLtqiisfM1Q3syjq1I6mGNbQEb7QWQUx8e3VsiNCsRlDLSI0PxKgYsV5E307dJIEl0YN', '2026-06-04 02:59:57', NULL, '2026-06-04 02:59:57', '2026-06-04 02:59:57'),
(287, 1, 'YP32GY32qkjrxtcWTtK1sgcUrQXXE6IrMzS8EvUM0szdNiRXtJx5P7NlrVsXqVUmLq0dm52g5TGrqPWg', '2026-06-04 02:59:57', NULL, '2026-06-04 02:59:57', '2026-06-04 02:59:57'),
(288, 1, 'pRjpj4Y4cO4s3454i1WvB8FEWDr4Z8IkF1rNI5PGF83vroI5camBpkg0JG1Du1O5s3RvFNXHJOokvzjb', '2026-06-04 02:59:58', NULL, '2026-06-04 02:59:58', '2026-06-04 02:59:58'),
(289, 1, 'jiNhMWtt3lConwR1oUm0wYc5tPN4Hsi38pyRUVaN4hIDhfJtZXz2Ff6gxhZTOKCbyeOrhWiyMfrNaG3o', '2026-06-04 03:00:17', NULL, '2026-06-04 03:00:17', '2026-06-04 03:00:17'),
(290, 1, '52a4SAA3al7L6taHrp8T2sf07gxVlFXRZjPKUiHzX4PS96sEGxoJAvCpuNeDnoeRLo2dtZnBNJq8vf0M', '2026-06-04 03:00:40', NULL, '2026-06-04 03:00:40', '2026-06-04 03:00:40'),
(291, 1, 'a4LeeTG3GTvt1gqxxiRtxJB7TIV0N1h0WCDk3ZOmQZfdpxoQiJAIKUUZarhBfciSlTzQZ4vpF19tBfWT', '2026-06-04 03:01:01', NULL, '2026-06-04 03:01:01', '2026-06-04 03:01:01'),
(292, 1, 'voU5quWLSwWjTuIFCmOJu717B0H8t9VdlNf02jA61c4qPv1e0mRXCSluTry9qSluciPW1O3y9dQ4DuFi', '2026-06-04 03:01:10', NULL, '2026-06-04 03:01:10', '2026-06-04 03:01:10'),
(293, 1, 'Tpj9n6HIerLnKMuGkBZebaV1HJBCD7o4dm1SpwSNPbJN9GH75t7bhvrbRIup7JSkkgIb7Ow0xPd3B5hJ', '2026-06-04 03:01:40', NULL, '2026-06-04 03:01:40', '2026-06-04 03:01:40'),
(294, 1, 'KOvnDFS6kLCkZT4HwqPkrl2gTKApkeC7ElSjZU05JxKXIylmqYjHSABlwfwuihUmDLRhjL6SsMelUitT', '2026-06-04 03:02:56', NULL, '2026-06-04 03:02:56', '2026-06-04 03:02:56'),
(295, 1, 'HOL7oJsLmR5Teo6A7JVssjYtmlkCaGyh57BGaH6y2OIzvD39COzWzShzTgllW9QBX4DR7iPR2WNmOqBB', '2026-06-04 03:03:33', NULL, '2026-06-04 03:03:33', '2026-06-04 03:03:33'),
(296, 1, 'yI0fotJvMWJ84K4HHS7JFY5sjVg1280udBsYTVPYhBrt3OfzpYmRH7Es95iC2KvoeWgrTrJUCw6uhOQu', '2026-06-04 03:03:40', NULL, '2026-06-04 03:03:40', '2026-06-04 03:03:40'),
(297, 1, 'OJ6HCn4KHK1ADkb5HqLBvIUizf4MQnt7T26o2vX0C68JaQBv7KBZe1FkIG70vzeb8JgEncZWkIoetGgL', '2026-06-04 03:04:10', NULL, '2026-06-04 03:04:10', '2026-06-04 03:04:10'),
(298, 1, 'T6k2uU8OtjS8bSAhFRlozcCTMlYXl2D0Vct0j24864OG4VXyoAWcMe5lZYlt3PnFvK0s7bqwowmpexHz', '2026-06-04 03:04:25', NULL, '2026-06-04 03:04:25', '2026-06-04 03:04:25'),
(299, 1, 'DD8JSHWsQgmM6fJLvGbtLlrG6irCHM5r4co2RAuRE7nN4YcE9Ujtnlf0KiQLt4jYLTqg8otOfoSSPg35', '2026-06-04 03:04:27', NULL, '2026-06-04 03:04:27', '2026-06-04 03:04:27');
INSERT INTO `totem_sesiones` (`id`, `totem_id`, `token`, `inicio`, `fin`, `created_at`, `updated_at`) VALUES
(300, 1, '4kpC5yAc4FOc5RDdZ8SydUZVDZ3g3n0WcXAgFjT717hDLMtQkmdKOJBSwXwSXPBG35iUMsbOGTN0QszZ', '2026-06-04 03:04:56', NULL, '2026-06-04 03:04:56', '2026-06-04 03:04:56'),
(301, 1, 'ze2J5wCITrUjXz1V37cD2aarvY8cQjrrhwcyRt1ygnhp8sRKaLTaNRWtRLhzYlznLUt5PwQb9PUFNBKN', '2026-06-04 03:05:45', NULL, '2026-06-04 03:05:45', '2026-06-04 03:05:45'),
(302, 1, 'zkqQvpp3mZf2CYZjOlotJHIaoUsduAI1cw6eWk9o26CrkksRIwxDTIlxdBxfcmOpjpX4J7FyPm0phhHm', '2026-06-04 03:05:50', NULL, '2026-06-04 03:05:50', '2026-06-04 03:05:50'),
(303, 1, 'bM11U2cMDboNIK1C2skt41F8eotlZ7WB3fAube26qvCQ1L7tJhPZ0yupdDqKrdpfyCZd3x4aXCcaxFDH', '2026-06-04 03:06:03', NULL, '2026-06-04 03:06:03', '2026-06-04 03:06:03'),
(304, 1, 'JjJqNuKZEGjHqCq4XY1FHjOD4jUQN7fRtHv60lnkVWxni1Spukok1vsjjRrDXh0Unc8kcbH8IPknqqSH', '2026-06-04 03:06:33', NULL, '2026-06-04 03:06:33', '2026-06-04 03:06:33'),
(305, 1, 'gRpOtPfI5G15wjB8jfuOaPrHl8pEbP2grQUuFhHmFmamwSfwqKYv7DYB6v4AAWy94A71iSecvGidvv1Q', '2026-06-04 03:07:03', NULL, '2026-06-04 03:07:03', '2026-06-04 03:07:03'),
(306, 1, 'IVFJOkc89UgbRHgONGKaVREsuXnG3ZWgJ11wz3tsSQtdalLImwIrqXGDhTv2o2KHRxIOUE4eZpsYXASn', '2026-06-04 03:07:33', NULL, '2026-06-04 03:07:33', '2026-06-04 03:07:33'),
(307, 1, 'fBPFoQJTMeyOH3VXtzp1gBxo10kO89yjFq5gouSM6Pj0qQ2ffGRAcCGx5UtErkQAjKP5giimcqJX49bK', '2026-06-04 03:08:03', NULL, '2026-06-04 03:08:03', '2026-06-04 03:08:03'),
(308, 1, 'Xqyn6MpvpLel65pCVKlfaJpONZHDjogUB2q1jodkCN3d6Yx6FUw13sLmIgWkDXzgXzurWOokamvQk3fn', '2026-06-04 03:08:33', NULL, '2026-06-04 03:08:33', '2026-06-04 03:08:33'),
(309, 1, 'ZW2rI3XL4HXYQZwtNRhvEI5Vg3QnAgnGeYN0WpfdqO0fjh8ZvBHbVILf0TlXgA4lsWiCgZsGHG1IyWjh', '2026-06-04 03:09:03', NULL, '2026-06-04 03:09:03', '2026-06-04 03:09:03'),
(310, 1, 'ysXliY51vyeanz31sbPqNhPLY93wM5x8stczAYFq0AFmBB4EjDXqvkGcAZX0qcghU5EsmyNkoi9t9v78', '2026-06-04 03:09:33', NULL, '2026-06-04 03:09:33', '2026-06-04 03:09:33'),
(311, 1, 'mPU4byncWTbymlXDVsNv95zRdT6rYTmNc9NncmVoCFGRcIUBu0TM9XsYEq6yWuW5Q2HJPpDPzNXNX0mp', '2026-06-04 03:10:56', NULL, '2026-06-04 03:10:56', '2026-06-04 03:10:56'),
(312, 1, 'i3NxIFXs2BHSubQstxQZ1TaT3KdFwNxi8gdfcbN0LZRx7vK5YL792M5hFT8xm5pKn5oKvLChJyr7OefV', '2026-06-04 03:11:56', NULL, '2026-06-04 03:11:56', '2026-06-04 03:11:56'),
(313, 1, 'LCg8HLzfUMcsmqOLJmlVId2gbBk9lC2p2bJepFE1BJHB0vj9KptJdQiVGHhQ9t5fLLFCv8drdq2D6PTd', '2026-06-04 03:12:56', NULL, '2026-06-04 03:12:56', '2026-06-04 03:12:56'),
(314, 1, 'xAbYGkYEuZ4dlxy6lG8QN8hsnOvNT7MVs6lteVT5htZ3R1ik53l347ZhRJJfKVR6eXIt7Ps7AqxqzORo', '2026-06-04 03:13:56', NULL, '2026-06-04 03:13:56', '2026-06-04 03:13:56'),
(315, 1, 'BCML9040jZX91PHDA0D1lzzXMEev19yLUOpQ6Mxfhzec3eJ7JxxJwEzYVBE7LVVULCQPGXgnKQU4UlwF', '2026-06-04 03:14:56', NULL, '2026-06-04 03:14:56', '2026-06-04 03:14:56'),
(316, 1, 'k3RRnzTTkBm18WA9roQ40cUCHRg2LYVAEipC1lfgTmy176XCwe95gyW0l04Jk61HAymB7F1Yz7R9hJHR', '2026-06-04 03:15:56', NULL, '2026-06-04 03:15:56', '2026-06-04 03:15:56'),
(317, 1, 'KJNTEKMFAqWFFEiuCTExmeWIGlVeAAKXi0pMxR1UwKt4LEk6fvo8NEYgMpZ9i3DhI0BF7vJ78f5WGpio', '2026-06-04 03:16:56', NULL, '2026-06-04 03:16:56', '2026-06-04 03:16:56'),
(318, 1, 'huiYIvKbVmDyykEteq4vwAvC39xAgfgVhdSGYmFVro5ggKYUSZ55dvBLzUz0A7YMktgrHOsc3ofky5wn', '2026-06-04 03:17:56', NULL, '2026-06-04 03:17:56', '2026-06-04 03:17:56'),
(319, 1, 'H4PkRB6DxDw8Vnj75gx605D9Wmsel5yTw1R0hNYoKTIORDknGoqVsNv7zwKtjINod9JzqqTZawN4gmsH', '2026-06-04 03:18:56', NULL, '2026-06-04 03:18:56', '2026-06-04 03:18:56'),
(320, 1, 'TpNfKrohkfyEDI328A22GurGzoGB8wDKjdIyocTsJvuWYaEHjIuBZdmkZjpSaVu6UOc67K4rZUhdGZWI', '2026-06-04 03:19:56', NULL, '2026-06-04 03:19:56', '2026-06-04 03:19:56'),
(321, 1, 'q0Rs0zDSyEcDabR3kGEdSBKHLjRWe4qZbT9yD8ndnXbsf2PHGF769tIO7cUf3LAL83ZdLBgCYbT1B9Iz', '2026-06-04 03:20:56', NULL, '2026-06-04 03:20:56', '2026-06-04 03:20:56'),
(322, 1, 's982ypzzdPhb6VvnpClN1Y2ZTLhnDmTOOEl686u6EDF96NZciybNpa4bT9qLYX9VV0illdgsKtpqPjKT', '2026-06-04 03:21:56', NULL, '2026-06-04 03:21:56', '2026-06-04 03:21:56'),
(323, 1, 'lPc7qw1kaAVx2ssXteC206jH1RR120FsoHidVtWayJ657BueT6eb92FF4asCPAlhLSRt9FWJ08riJE7M', '2026-06-04 03:22:56', NULL, '2026-06-04 03:22:56', '2026-06-04 03:22:56'),
(324, 1, 'E0edp5gNhS6UBcuJvsrwmJ6KivoKNOHcbHDaK5PV421TwyRCjaOxx4KOOsefiilMelJRBc8IuX7ga0SR', '2026-06-04 03:23:56', NULL, '2026-06-04 03:23:56', '2026-06-04 03:23:56'),
(325, 1, 'zZWncrTMkJOfKbHNVwCFGWgUsI1CUlM4zs0j1geXesGMCj8wuKrOk7baLxFKxQpjvZFIfndZtkvC2k0r', '2026-06-04 03:24:56', NULL, '2026-06-04 03:24:56', '2026-06-04 03:24:56'),
(326, 1, 'M95Sc2zXUmpFvVonbiQeQ5Zb6XYjjaGZtRyr1kvVcg8yl4LS7nKmUcN7iVtCNX81x3TaT550yihke3tz', '2026-06-04 03:25:56', NULL, '2026-06-04 03:25:56', '2026-06-04 03:25:56'),
(327, 1, 'QZNarmNrH5FiZu7ZYtV7aZaAe9bZLVayJdo9bza1pv0AYcEITYjfgtR2p7RQl3wjtbMiSozxXziKK6UL', '2026-06-04 03:26:56', NULL, '2026-06-04 03:26:56', '2026-06-04 03:26:56'),
(328, 1, '51ajoOPw5375pt0o8OUxfXcH04vkNLZiyyglQmF5m9N2TXb5EnZtHefunO6EuuchknMljCSPFMsoISLa', '2026-06-04 03:27:56', NULL, '2026-06-04 03:27:56', '2026-06-04 03:27:56'),
(329, 1, 'j9nujaPLUXrO3MrG5PzGuXGHhBX54W8LvEzy5LMLJ0fg5etd8VoIRuBbLI6Tn9EnRxMmqs0GejJDAegf', '2026-06-04 03:28:56', NULL, '2026-06-04 03:28:56', '2026-06-04 03:28:56'),
(330, 1, '8O9qUzfNikX8Hi0AsFUzBpTFCynyy9MwdDlw9qKQD7qTrdb2bZYADDb52tMdaZTPaMMX4jG2z1W2XvWB', '2026-06-04 03:29:56', NULL, '2026-06-04 03:29:56', '2026-06-04 03:29:56'),
(331, 1, 'hHCS4ZyqqIBqWY6vMDCTdIHugPC5nk2SMZI2AzgxJZlIumxv9hn2SUOT66Aac2s1c3WWDnSmdiFoeMUb', '2026-06-04 03:30:56', NULL, '2026-06-04 03:30:56', '2026-06-04 03:30:56'),
(332, 1, '2dbSG8mNDRVUyxjNbR3qGqTmOnRMU9RAvMgxiulz4OBQBq2XUmE70d4A1ehGDf0agCmc2d1YvLTgmFk7', '2026-06-04 03:31:56', NULL, '2026-06-04 03:31:56', '2026-06-04 03:31:56'),
(333, 1, 'tb0eKxZGhXkCMLxwVIbiZOdwPNJLWWEkMyUpOfCUW6YARSxU8b56wnpIL3tow9HCd4a5nTUlVN1bT9BM', '2026-06-04 03:32:56', NULL, '2026-06-04 03:32:56', '2026-06-04 03:32:56'),
(334, 1, 'FPpYXqilCZL4yMjKZhmhwx0roBghctT53cGDRf1N7g8jjzDsregkQCK9S2s3mXtXfPczJJfbtm7dcsb1', '2026-06-04 03:33:56', NULL, '2026-06-04 03:33:56', '2026-06-04 03:33:56'),
(335, 1, 'NSjAXk5akfiIRH9fvFwiITmVesZ3OFzdOuNHt7dXijzGxyn66Q6LZL3ANiS8E9U2T3kyp878I4vLVpjd', '2026-06-04 03:34:01', NULL, '2026-06-04 03:34:01', '2026-06-04 03:34:01'),
(336, 1, 'RQdrq8nEcTPjP1oAVlm2NBUuUxN0VpeePI4uQSF2b9HdfXbpOuRvOLMBiDv5lS88m6APGmA49aPpMplZ', '2026-06-04 03:34:56', NULL, '2026-06-04 03:34:56', '2026-06-04 03:34:56'),
(337, 1, 'y2xkYIl0DL4qifMU8YBnT45d0w8ixsRgnZYOapWMb85lb9XcmLAhaggE5Xw3iyBBTHkUuEiDqbmYolev', '2026-06-04 03:35:56', NULL, '2026-06-04 03:35:56', '2026-06-04 03:35:56'),
(338, 1, 'dOXpxvkRDuSY6diOmMI37NgLugUVZwmWGcJmX1amskcP7Lpmyjn3VYYWRpRfUtFWWnittV9fjxZBegsn', '2026-06-04 03:36:56', NULL, '2026-06-04 03:36:56', '2026-06-04 03:36:56'),
(339, 1, 'lhAcljn3Iuk6pJpsgZ6tSStObT4Q5Vxu97KPXTrAOeCMQg8t9Cq3HQpgmYbzgLOEHp7r5jSZVs8On17j', '2026-06-04 03:37:56', NULL, '2026-06-04 03:37:56', '2026-06-04 03:37:56'),
(340, 1, 'ehrgmXxHN1p1hz6l2iP0qGtx0xtP7fiJCB4gBY40YEhNqOUPffGNfWJSJKr7adWV7UqGmDG1AclNpPDF', '2026-06-04 03:38:56', NULL, '2026-06-04 03:38:56', '2026-06-04 03:38:56'),
(341, 1, 'wDDhz5COXoj2SBvgTemCQfC5GuAwgg4em8AuTylIbow12TUXqmLQ073kAH537a60LLQnT3swUonmqqFA', '2026-06-04 03:39:56', NULL, '2026-06-04 03:39:56', '2026-06-04 03:39:56'),
(342, 1, 'K8uVuYmdpds0f9uJ4oSR933sAvkgs0aZomWTZt5ICF9PMRAaxNBzuz5M26K7D1iwlAaK3m232vYVVLrl', '2026-06-04 03:40:57', NULL, '2026-06-04 03:40:57', '2026-06-04 03:40:57'),
(343, 1, '50zcgIADRQAaRdBaqq2mo7IQ0OpwHx8WG073lqENx3I2sEMpIHwvcFbOAIsYFKS5aGAq8Rs1zmvELtH9', '2026-06-04 03:41:56', NULL, '2026-06-04 03:41:56', '2026-06-04 03:41:56'),
(344, 1, 'PGlCarsCdoeQsVvdcPozLhOeJkpYQJl4mv0BE2bVgQXZsTuXeq2XM6DH3CFMH2kM0YJ7AEGppxaoyKgT', '2026-06-04 03:42:56', NULL, '2026-06-04 03:42:56', '2026-06-04 03:42:56'),
(345, 1, 'yTMCpjMm0EzO4AVyye7rf5ApuA0NXLr7NVHtlhHcX6Q6jR2JDXECAlBkk9lwnnYNvSy0Plsn12dG21bz', '2026-06-04 03:43:56', NULL, '2026-06-04 03:43:56', '2026-06-04 03:43:56'),
(346, 1, 'Wl0WFcEZzl2LaP6yAAgmCuSvkUGYv2FL2i9RYoZ4IbrXu0cpsspeqogVehjhn1sz1IVuy60VZkVfUbpg', '2026-06-04 03:44:56', NULL, '2026-06-04 03:44:56', '2026-06-04 03:44:56'),
(347, 1, 'kicSU6SMjvffM5FRgJGyFSI1dMUi7klyUZGDFMNkp2KoqiKg8sWNGPoSaarbtw1Bi7nD6XKv5iOnI1Ly', '2026-06-04 03:45:56', NULL, '2026-06-04 03:45:56', '2026-06-04 03:45:56'),
(348, 1, 'b8QBpAWSG1cC2Qo0a3z7NMtjSw85xrHvm2ROOAgvWVCpwC76zAQks0EPTDpzjdXhwn1UyUMJMpyYMS70', '2026-06-04 03:46:56', NULL, '2026-06-04 03:46:56', '2026-06-04 03:46:56'),
(349, 1, 'usBoEZBQZwIisev3N7nsHTXyz4THW3iIa8eUEYi4HmANIg85b4592r5xABWtFM5ualvIstjyFDDe8Cio', '2026-06-04 03:47:56', NULL, '2026-06-04 03:47:56', '2026-06-04 03:47:56'),
(350, 1, 'J1l6iZGO35vZr0PowGZggc6ma4dMjZQQAcsDhAAaEK6KzvP0dISUaU3g0rNzqeWJ2Jwf5RpL4G9acyhY', '2026-06-04 03:48:56', NULL, '2026-06-04 03:48:56', '2026-06-04 03:48:56'),
(351, 1, '8fzFEhIA72iQzTJxy5goxWQXq2Dz5urhR5qcXQTT5WLbzlGy9TaBtQbQhDonoOe7OfTN9QcssB4VrKt6', '2026-06-04 03:49:56', NULL, '2026-06-04 03:49:56', '2026-06-04 03:49:56'),
(352, 1, '1liybpmZyp0qfvIf3LwbTbpMibNcXNXwHd2BnA99vdZQTgnx8o0h6lyBJqZ7U1IIaX93SpFLypoerLkf', '2026-06-04 03:50:56', NULL, '2026-06-04 03:50:56', '2026-06-04 03:50:56'),
(353, 1, 'MJjs5Av48yPA5xCmbCO5bEctt7LE5IFR8SpQ5jDHXGrAyQy0F5QtdPNiYX316Sj1JeiJDKLMjEq1e3KD', '2026-06-04 03:51:56', NULL, '2026-06-04 03:51:56', '2026-06-04 03:51:56'),
(354, 1, 'gPOLCAOOh0efr4Fb7exVd6WsHF2glIfow96abQApboGZdwEbdWyVdcEo5DMzzmRPs2qkephjWhC5p0fp', '2026-06-04 03:52:56', NULL, '2026-06-04 03:52:56', '2026-06-04 03:52:56'),
(355, 1, 'jLH9kdXwJ3HXeDYm9PPr0OUsVGumQoHjNRGF1VT5th0gKYuBihf0wmsYvJ4Pn4DI00YPxwmvmtCHKKWG', '2026-06-04 03:53:56', NULL, '2026-06-04 03:53:56', '2026-06-04 03:53:56'),
(356, 1, 'aXTINqu18sAEbCNLP3QuAXDXqeHe6VrBveFYROv59Gul9YMf0oArcGBq29Oxlg3QG2uQouoPrsDNZ3EQ', '2026-06-04 03:54:56', NULL, '2026-06-04 03:54:56', '2026-06-04 03:54:56'),
(357, 1, 'xcLTAg1MRRvQmcfyq9e0lhPcS0QDqh2ULJuNnefeh00eUFGl5FhZpj4rSKQzCw2TDLLpiR0tI8IEgPGv', '2026-06-04 03:55:56', NULL, '2026-06-04 03:55:56', '2026-06-04 03:55:56'),
(358, 1, 'VTb0J9IyZFpBT0oTJJxnAplevhkgFbLnnTCtHbXUy0KxYEMgKnHTwAl6DO9PTCDhCXOcJvNS1ZwVMGn6', '2026-06-04 03:56:56', NULL, '2026-06-04 03:56:56', '2026-06-04 03:56:56'),
(359, 1, 'maIwVMxyBPIPlTkDLUefBRIBJhNWh8ja17zmxToDSoaGXNqy3z4DYIu5IKUW0QEZpojPybf4zjQdjzyZ', '2026-06-04 03:57:56', NULL, '2026-06-04 03:57:56', '2026-06-04 03:57:56'),
(360, 1, 'VSyr1nbrBnJLPlOQ4GAwQZ1K9IblxA6CZ0FGU3zVi9osTangeeuuJ6fFcAjWCnpNC9pH2Pjf34BIXVCq', '2026-06-04 03:58:56', NULL, '2026-06-04 03:58:56', '2026-06-04 03:58:56'),
(361, 1, 'C1AXKCGdFNLQzojciqt0XfF7JpP9lmF7SvJFAFYybzvjEiejyLJ3yRxF6qimOaIQpQdJIHc5BfaJrO52', '2026-06-04 03:59:56', NULL, '2026-06-04 03:59:56', '2026-06-04 03:59:56'),
(362, 1, 'LPTxlAEGCYJ3qXBurCcdzNwdkNn49CZljUGO9JGOgIg8jAI029QlFRPCG65EoWTaTC5OBSOqtFXYSZy4', '2026-06-04 04:00:56', NULL, '2026-06-04 04:00:56', '2026-06-04 04:00:56'),
(363, 1, 'k0ZFP5v0fqM8mGKp1VFy8H2zU7J8Ozj8l9aecCxxMjp89AvHvHkQlEqsgixf1ZuPu5w51s41ZpLy3vHj', '2026-06-04 04:01:56', NULL, '2026-06-04 04:01:56', '2026-06-04 04:01:56'),
(364, 1, 'tq8DHhXKVhFqBeW88sEROnVBmM8b78l6Nb4g8F4qklpYwAmW5JT7vlFHjz509r8WTPyZAZSetM1TVd5W', '2026-06-04 04:02:56', NULL, '2026-06-04 04:02:56', '2026-06-04 04:02:56'),
(365, 1, 'rVxMwaTHtWBZsftJj2PUo9dP379Aoxe9Of4uDAVk16gUp13XlmiBA3rEynOUPo6jfcxTfmnv8oyt1qoZ', '2026-06-04 04:03:56', NULL, '2026-06-04 04:03:56', '2026-06-04 04:03:56'),
(366, 1, 'fTJDpUCwzgZk1z34gY5aGlizL5gLlqBKYbQx9ouGnBO2BWNPAgM4GLbmAv7rvkSsmSmew2UdmgCYvXzv', '2026-06-04 04:04:56', NULL, '2026-06-04 04:04:56', '2026-06-04 04:04:56'),
(367, 1, '7FDtw7lvDq9XwjQ9offpy2r2k77t50Vi1WhK4SQvmzZuKSatxHxz4pOlJ2s68Y5azXDTOPANKhIVeNb1', '2026-06-04 04:05:56', NULL, '2026-06-04 04:05:56', '2026-06-04 04:05:56'),
(368, 1, 'XoYKY3wcSllulmi0ZiC2uARA7wyi86t2YZxZ2UmgqPO3IxSz4Bbb0o1O3rIkTdc5DEuZfx8X6b3mSVFK', '2026-06-04 04:06:56', NULL, '2026-06-04 04:06:56', '2026-06-04 04:06:56'),
(369, 1, 'w3ivk9xf054FPTYTh2C6QbcDwP8ujdcX2NhYyezcy77fVflJtaoEfLlm2vgz3GDVofrzKhcbO8QtxMMh', '2026-06-04 04:07:56', NULL, '2026-06-04 04:07:56', '2026-06-04 04:07:56'),
(370, 1, 'N7hHmT0s9YOYPA2y08PqjgFMs60dqDh4UEbBfi31mwLtlkKF0Iw93vAx2StduEGy6xLMbh0qvEtMRt9I', '2026-06-04 04:08:56', NULL, '2026-06-04 04:08:56', '2026-06-04 04:08:56'),
(371, 1, 'E8mx8YKo1JKzs7cO4MDL7GlVfwdTnIdKC0T0pwsPT3feBHVzwQ9gazg6Y4ZeOZhQEHKiy6hG4kYycKtr', '2026-06-04 04:09:56', NULL, '2026-06-04 04:09:56', '2026-06-04 04:09:56'),
(372, 1, '535Pi7Y28qYLrwl2GnLDHmtxRDt6DBAQJDliRXcw80IeCPbLX8l4r0UCQcwpAJii9tede9GPsGszpl9v', '2026-06-04 04:10:45', NULL, '2026-06-04 04:10:45', '2026-06-04 04:10:45'),
(373, 1, 'qgoWDGN5Ij8iyHGUwwYw7UqY9beSvktMLcVcwdAsLWx94y9EyuIUMzhHl3Cjod2bH2f7c4eOh8aMIhF9', '2026-06-04 04:10:46', NULL, '2026-06-04 04:10:46', '2026-06-04 04:10:46'),
(374, 1, 'Lct7qr6hLAM7MpW5sD1LZTB9EriNZI5WuOsyA89S7Z34trMTEdZIUV0t2cKZjDZslv60vn1CgUoFOeXa', '2026-06-04 04:10:56', NULL, '2026-06-04 04:10:56', '2026-06-04 04:10:56'),
(375, 1, 'vUrmb9oY7DCZSvmAeDgrhK0eJXUD2PPkPSrqnalFcJ9kGRLbFX6Cok5pdve3hcQ69odPsibtCFOy4Pb4', '2026-06-04 04:11:56', NULL, '2026-06-04 04:11:56', '2026-06-04 04:11:56'),
(376, 1, '84eoz9Y4IGEFvxtLuhjpaC6jDjNFSLWX1DuCjcCsv5gKLRrrOR0nv3ctDddP2K6bJAHgIqRumDFnbge8', '2026-06-04 04:12:56', NULL, '2026-06-04 04:12:56', '2026-06-04 04:12:56'),
(377, 1, 'OAggFxrpAfV42Lzyaezl81X9jHf09gEf1afSPt5ve51LofTzITet1mJYSiUk3NEAZwKySfomoJdWKaPY', '2026-06-04 04:13:56', NULL, '2026-06-04 04:13:56', '2026-06-04 04:13:56'),
(378, 1, 'PkQoNLou2RMsMkJeByNq5jM8cxiC4r0U8fOX5BNv23G3dpedY0du2QFQxYjvvMb3b4rvmmixHB7fuYKF', '2026-06-04 04:14:56', NULL, '2026-06-04 04:14:56', '2026-06-04 04:14:56'),
(379, 1, 'OIqABvnnjkJNxbgpsp4F9sw7zZ1B288FXxxzUFG3wtJ5vBWcAipdJ1fi8xSSiO8ij4UsAYK5ASJwCqNn', '2026-06-04 04:15:56', NULL, '2026-06-04 04:15:56', '2026-06-04 04:15:56'),
(380, 1, 'lZtxc2Mer1C49QwDlsLp2wzpnkpNZfpX4kJjvcCrmCXyi8uSnhW9JlbVpEA1anT70c0gGei6TzeKyekP', '2026-06-04 04:16:56', NULL, '2026-06-04 04:16:56', '2026-06-04 04:16:56'),
(381, 1, '610CXC7ChC2BIUgB0JGJwsc73qV3pT8lPhQVqPqFskHi9Mao2tbG53scQ6kvBrD5fDRLRzjylSBY5TQL', '2026-06-04 04:17:56', NULL, '2026-06-04 04:17:56', '2026-06-04 04:17:56'),
(382, 1, 'TklCBAindHX0qsHOIMztqD0Im4V9OsTSFQvlDGDhE1c9T4Cok7ZsppkqnMAv8KeOUTZTWK5cQ3ziTHYp', '2026-06-04 04:18:56', NULL, '2026-06-04 04:18:56', '2026-06-04 04:18:56'),
(383, 1, '8JULwLmmyUeQNdIxKABfaGU6RfSefRgqNOm3Y6q4fqaOQmaVxoUGgZVOMAGAABKtVMBVB07wOQyEe4I4', '2026-06-04 04:19:56', NULL, '2026-06-04 04:19:56', '2026-06-04 04:19:56'),
(384, 1, 'p9OwFyC8mXBvA575HqI1917h5DN82hDJidFXPfb0QIPg641jcO3nuOk7XyQpx6qaDe8TF5HRzdRCLDB8', '2026-06-04 04:20:56', NULL, '2026-06-04 04:20:56', '2026-06-04 04:20:56'),
(385, 1, 'qPdcsGamF1GrGeUWQpaq7HYVSWxXk98VDcqtka1zgeuLGDVqHxrBYrJVEWczkCWMmczSWH3PAoPdAa9s', '2026-06-04 04:21:56', NULL, '2026-06-04 04:21:56', '2026-06-04 04:21:56'),
(386, 1, 'L4NGpPK9c0kacNKP52yk7PsizZSobkOiISPoJAnE09cPDHEtSGVy9jen44HK6LLAgNb70f6VZd6IRueL', '2026-06-04 04:22:56', NULL, '2026-06-04 04:22:56', '2026-06-04 04:22:56'),
(387, 1, 'lbGrvbEQezhotQAjCvPku8EK612yBl4Z6wqlo70tXcuKXMf5eWx68rgAG7GufQXrVciKBwnQy2P8eW3H', '2026-06-04 04:23:56', NULL, '2026-06-04 04:23:56', '2026-06-04 04:23:56'),
(388, 1, 'zHdPE76sLNvwsKyCQ6ifhy7WKqn96yVpBI6LRt4dWXhOUJL31qqM7clp8jVgXyJ91N86ozyhOaGfY65L', '2026-06-04 04:24:56', NULL, '2026-06-04 04:24:56', '2026-06-04 04:24:56'),
(389, 1, 'PPrIYk0qWCiKzUAUQGqSQ0nuAume7NSRFb641HT7mEa8Vg6legVk10HZof0FVHaoP8ehAzqsPDDcDWI3', '2026-06-04 04:25:56', NULL, '2026-06-04 04:25:56', '2026-06-04 04:25:56'),
(390, 1, 'ulujZPqOLHIaLgbzqB6humOP6FbCmCABdqXBz0qL8VVHPcDbg6wDLCJYzfDGwdUa9rhkSKdvjyKVoYDz', '2026-06-04 04:26:56', NULL, '2026-06-04 04:26:56', '2026-06-04 04:26:56'),
(391, 1, 'THpfYhyGu8lALLzdLoy5UjCEx9AeAVJNDfeXeIKkpG2tW7HpMrGvlr4ytTJtAOmP1DPAUz2qE19BEVh4', '2026-06-04 04:27:56', NULL, '2026-06-04 04:27:56', '2026-06-04 04:27:56'),
(392, 1, '63hfFPGck8DsdH3P8DI6Gz0DWlkOuC4sTElgvMYsHrMYZQ2kJIR2fA4iBKtk8CHGCkT16N0IbAnODa9X', '2026-06-04 04:28:56', NULL, '2026-06-04 04:28:56', '2026-06-04 04:28:56'),
(393, 1, 'qRF37kehI9gbX9WrgkU8OsafZA3h93lJ17JWA2wI7MZoc2RS5E8oIBouCtMLuac6ePTupFskQdVCLf9x', '2026-06-04 04:29:56', NULL, '2026-06-04 04:29:56', '2026-06-04 04:29:56'),
(394, 1, 'vJq28yDuISh2SbqYKlMPTKDlontC0SOQQGAdqjSdEsDZJ5tc69DwYCjXPElGjWZAnpHhgSw9Bz36c4En', '2026-06-04 04:30:56', NULL, '2026-06-04 04:30:56', '2026-06-04 04:30:56'),
(395, 1, 'k3I0hBQ6iso2UYtCCiXgcQWUJcD3ikzyPUlXyCSwosPzsZ2YbSmXIoAUfiNFaAGmbR5PBH30NBKHNREK', '2026-06-04 04:31:56', NULL, '2026-06-04 04:31:56', '2026-06-04 04:31:56'),
(396, 1, 'uoAJrR98ivj4u8zLSaazOwEH8BnIhGZZ3ihpQNqbdVNcZoqR1CiKY3f5ezUrCwduqUm9ekzsNRtuGZfb', '2026-06-04 04:32:56', NULL, '2026-06-04 04:32:56', '2026-06-04 04:32:56'),
(397, 1, 'CVgLxL8b7o99ExEeNcactwWVNFNgrTq2Zoq5MJB4gDB6Pq5X00WK5jALhGNQUCdvPFOkoCXoCEjz04x9', '2026-06-04 04:33:56', NULL, '2026-06-04 04:33:56', '2026-06-04 04:33:56'),
(398, 1, 'nP9AEj4Nw3K2l9pE2xMRmFYHB30CJ5Nod7fA3E0QAMW1a8Aj7LIg0P8xAjygdDQB36HdqXH3N4wevf4j', '2026-06-04 04:34:56', NULL, '2026-06-04 04:34:56', '2026-06-04 04:34:56'),
(399, 1, 'flTGUCjpxao3jBP4CwQzNcboHJsmU2r5Ymdafr7J7HTPtI2EUD8eXd8c7oE34NMc2Lvn503hoZR1m0PJ', '2026-06-04 04:35:56', NULL, '2026-06-04 04:35:56', '2026-06-04 04:35:56'),
(400, 1, 'TPq0BQcV9oQeACQbHDOgZD6wlFktymonl3frPmp5DcQMHEBMf5mF2x7kZiZuAEEITWrdFy2LwUGnJI0J', '2026-06-04 04:36:56', NULL, '2026-06-04 04:36:56', '2026-06-04 04:36:56'),
(401, 1, 'u4YMB0XOP5vCYjwTghCUzNy2TpVspmoqtoiqxPhce5Px8NFWlABUEJ0OOGjfB6C1zQZ3V8PQnlGXA5kn', '2026-06-04 04:38:40', NULL, '2026-06-04 04:38:40', '2026-06-04 04:38:40'),
(402, 1, '63yN8aKSrfpWkRW7R1aqm7naxm6eXgSrtf3BMrwO6XhdlFiybXnpEjCURMohP9TrTZFvnNID90T4K0oS', '2026-06-04 04:38:41', NULL, '2026-06-04 04:38:41', '2026-06-04 04:38:41'),
(403, 1, 'xfim3HF35vJKebUsxVwmx8kuyaywSukaV9jhS07BZWolbdDscOrd5mBPShf8nl5oH74KfCd6uyKEfJnK', '2026-06-04 04:38:56', NULL, '2026-06-04 04:38:56', '2026-06-04 04:38:56'),
(404, 1, 'GUiFWKpJmgedH4CaRxfBTENpVLap3Kg5tjfRCFfckhQHlcQo100N2WEW07pcaESCcgQz6ySLCGy5kiIL', '2026-06-04 04:39:56', NULL, '2026-06-04 04:39:56', '2026-06-04 04:39:56'),
(405, 1, 'vspsljwaEJ0aUi3nTqR3umu240HNivMfFtgmdFasZTaMFvlC5ZPSTtnFzFuooukQU0VTrtJT1ghSOt8N', '2026-06-04 04:39:57', NULL, '2026-06-04 04:39:57', '2026-06-04 04:39:57'),
(406, 1, 'DFg5Ts1KIHRPuPOGOeoPCrDyxuW9bgY5wfBGP9lKoCl4eU0Ur0UEn10fKOllEN0L1YEhLYwRhOM4OyJB', '2026-06-04 04:40:56', NULL, '2026-06-04 04:40:56', '2026-06-04 04:40:56'),
(407, 1, 'I5FFyQQ72pILXZ3Y7nPwFxwMjIKg6Ba1KC57PHG0CTnxw6Q6oiwQDmv9PDwog8FuNFaeihvFOcvzRMG6', '2026-06-04 05:02:56', NULL, '2026-06-04 05:02:56', '2026-06-04 05:02:56'),
(408, 1, 'EwTpu4yAFBtzK7WnoHUBomCcz4M5RATmA9h8EUP1SXrlN17CiKZhrjR5BOQpY7nWgZ87T4OnbfjBxSEF', '2026-06-04 05:02:56', NULL, '2026-06-04 05:02:56', '2026-06-04 05:02:56'),
(409, 1, 'zerZQWX8Nzz3CvWjPjiDfibqOft3VNjN83YC6PquGkForBafGvHOFfMNKsWGhBiPftOaKaTra43mweej', '2026-06-04 05:02:58', NULL, '2026-06-04 05:02:58', '2026-06-04 05:02:58'),
(410, 1, 'uZBf30KRL272fIpwmdviJ0SNIlrbegSIa5FGnksOTrDOMRs3UPkL3NLC85lWbHNwTRqnAvFQObZ18Plm', '2026-06-04 05:03:56', NULL, '2026-06-04 05:03:56', '2026-06-04 05:03:56'),
(411, 1, 'Gg5n0YZIVVk3Xt3yqWjAp8CokYVA1QjngOdCvwV3nNbW111Vd7289IsrrmtpuMWvclqSeHtBw4ptpGqr', '2026-06-04 05:04:56', NULL, '2026-06-04 05:04:56', '2026-06-04 05:04:56'),
(412, 1, 'n14N0B8JU1ju1hGf8U6HpEW40n3OwfZoEYjOXsp6weyDdbzL7uDKQpSbuVLtK2IJ8HM8o0JnyFxgR6Wd', '2026-06-04 05:05:32', NULL, '2026-06-04 05:05:32', '2026-06-04 05:05:32'),
(413, 1, '0u0LieWBCk1C9Q67nQnA9KwH5NuMRxuyW7MGLzD8PFG6L64EeCEWPtcktjaEFzbgDxnXs3NrhDlTaXZ3', '2026-06-04 05:05:56', NULL, '2026-06-04 05:05:56', '2026-06-04 05:05:56'),
(414, 1, 'dOCuz57KufgGie6NxlZcBzlWDrxvNrDmd7D8OZjf12ihc1q7JazPOPTqzQSMDs6NV7M0nk7co7nf4rNz', '2026-06-04 05:06:56', NULL, '2026-06-04 05:06:56', '2026-06-04 05:06:56'),
(415, 1, 'MYAsotVXxemAXXn3JNU07YuMbH3QzaD8su9RF64QkvdKnL3d4Rd5ltDTXXG8BIdf1MsRcRBkNuDfIqRu', '2026-06-04 05:07:56', NULL, '2026-06-04 05:07:56', '2026-06-04 05:07:56'),
(416, 1, 'd45uDwM8P3EyCnKRH2aTql0k8P6eFAczxb0qQWw2tDC2XDKnNZUWqtFdRtNtZeuAeCuGoPhjOmQemV6S', '2026-06-04 05:08:56', NULL, '2026-06-04 05:08:56', '2026-06-04 05:08:56'),
(417, 1, 'jLuHlWU6UHdCGyRYj1c8v4UMojeSJp8q5k4UsByDvRkSOK0qLVQadbe1jCjzYOgc9Y7oTtYJXBP2DM1m', '2026-06-04 05:09:15', NULL, '2026-06-04 05:09:15', '2026-06-04 05:09:15'),
(418, 1, 'GMVo8nqOcbp05T068oenRsxnyn7cxG5SQ4fBhBRcAFUIiT0zVPB4otVzWzjEAle8l1eDzWu6NqIYZTpl', '2026-06-04 05:09:17', NULL, '2026-06-04 05:09:17', '2026-06-04 05:09:17'),
(419, 1, 'jb9w8WYIVT8wYglGVzZisE51U1RkvDlkQAIqMwm7d0MTYwz3F2uUYfB8qWMT57zSZeJ94uHimk5Sqx4x', '2026-06-04 05:09:18', NULL, '2026-06-04 05:09:18', '2026-06-04 05:09:18'),
(420, 1, 'bXihYJJZGRY3fyTRsIDi0BM4ZYNH7CwK32GBFQmfA6tlPBWkOMncsCrsmVs04Pp3z5LR8HEXKrcjoRcx', '2026-06-04 05:09:26', NULL, '2026-06-04 05:09:26', '2026-06-04 05:09:26'),
(421, 1, 'MUiN8fKMyiLQnZxyMlsfJcf6lPYFrZtmthzU2auGKI50YemaVzUek0H1adF9FwrOGozMv2iAHZxv0hwg', '2026-06-04 05:09:27', NULL, '2026-06-04 05:09:27', '2026-06-04 05:09:27'),
(422, 1, 'hbBCdIXtFi3zgVHGC8YuWmkAWmKYEZ8SvNAIeYd0oviKQpp3QrgAaGeM7UgnartPzOXXHpxK5maKey6b', '2026-06-04 05:09:56', NULL, '2026-06-04 05:09:56', '2026-06-04 05:09:56'),
(423, 1, 'u0idZ76mWIeaoWJ3PJEX4vwYuHv0iiduYKY0Bybxubr0y8A1PnK7n25nWogOaSJadebj8ZRIYEloN1xt', '2026-06-04 05:10:56', NULL, '2026-06-04 05:10:56', '2026-06-04 05:10:56'),
(424, 1, 'hExN7VDWH9DkPYYfADj7yBNgq4vLs8uuidOeJwhIkOiCprLCSOHYocB8UEO8TmPtVtTUjdGNgQt8xKvE', '2026-06-04 05:11:56', NULL, '2026-06-04 05:11:56', '2026-06-04 05:11:56'),
(425, 1, 'rd3A6RQcMS3ky5Vg2AhbV7ZmR63h7eXFxI3KOJAewS0nDvKLf552TeL3GASe3CbnhH6ayKVMY1K0BCWt', '2026-06-04 05:12:56', NULL, '2026-06-04 05:12:56', '2026-06-04 05:12:56'),
(426, 1, 'd3aiSMvGJVTEqBI6hBawetKzU6jmNbrxYakVaMCRJOZNvy5nbvrfHFddwWtkllgr9VPGFxKSbkcIY2kI', '2026-06-04 05:13:56', NULL, '2026-06-04 05:13:56', '2026-06-04 05:13:56'),
(427, 1, '6XMRGfJpqU2tRqj9S0IhKhws0fiF20q9AXQeObMD0CMo8RSWU8DrlZvSHy6y8oOQ8TrEHVEbMLLZ70M8', '2026-06-04 05:14:56', NULL, '2026-06-04 05:14:56', '2026-06-04 05:14:56'),
(428, 1, 'cITmV1kqX7SWsf4rtVrviF5n0GfW6z3Afxtv8IWUuS31TPwkmj6QiDrUHadyIni5BmhfnLONWNmc6Vc4', '2026-06-04 05:15:56', NULL, '2026-06-04 05:15:56', '2026-06-04 05:15:56'),
(429, 1, '9rBI1cxl0EwBIG9rPCRiPhktqJ9qAzhAlJ8EnovkAq45Y2M8egAbwU9PGB00FElwses0KLYAylSYPire', '2026-06-04 05:16:56', NULL, '2026-06-04 05:16:56', '2026-06-04 05:16:56'),
(430, 1, 'TqDuloGiNSKDynbt0HTLUB7c24opqKTfScn5cuSqa6gKxV7fYtfacWgovnkAw8I2UZ5M0zmC6N9LkQVV', '2026-06-04 05:17:56', NULL, '2026-06-04 05:17:56', '2026-06-04 05:17:56'),
(431, 1, 'JbDm4uIOohQiGB51gE1L7EhHpCsRv3hVEcf61560jFACPDMm98eHUOpCGYiMksU8sFgLPI2SfW8DaQ0d', '2026-06-04 05:18:41', NULL, '2026-06-04 05:18:41', '2026-06-04 05:18:41'),
(432, 1, 'LfnHQv8v0fSuAz3ZE3YpHAo8M9IpHJCCRA3z6ChqBp0P2NQRNes9sJQnD8PD7FsjCNMWgxjid2FlTmPW', '2026-06-04 05:18:42', NULL, '2026-06-04 05:18:42', '2026-06-04 05:18:42'),
(433, 1, 'RK2gGADjeuHSdiDGKzHftPPFgDcJexsPwJzD3myDwsmwBjkDb1W7CNzr8B2YCGz2wWeLyR9t46YZKtgU', '2026-06-04 05:18:43', NULL, '2026-06-04 05:18:43', '2026-06-04 05:18:43'),
(434, 1, '4qmPWLvFY258jHFcHo33iZM9qXpBEK5tcHmZfLzOjxsG2URd0kEKOGBCgGUt7qyhTcsBEkyRCpa8r7KY', '2026-06-04 05:18:56', NULL, '2026-06-04 05:18:56', '2026-06-04 05:18:56'),
(435, 1, 'xnrt9a61FKtSZmEWwWKyU3ruSGmKjJl9e58bsfUgaGc3sNVxyX3qdYFEwzn8slpLBEK5uxtb3WmPH0Jt', '2026-06-04 05:19:35', NULL, '2026-06-04 05:19:35', '2026-06-04 05:19:35'),
(436, 1, 'NfdfH90WjOBmbocLAauoskomm1eRUKwGb2D3HVpeWJyx2DFu8eevHv6Bcv7ckQmMGr7Ft5f3Rk8lQlXA', '2026-06-04 05:19:56', NULL, '2026-06-04 05:19:56', '2026-06-04 05:19:56'),
(437, 1, 'ewe029cWM6FTEYx4gZX7GG8SZbQRwetrPs6WeA5o8yfdL7DJHQ5ClbKoradHK9XmrmVfNaieklwlaroX', '2026-06-04 05:20:56', NULL, '2026-06-04 05:20:56', '2026-06-04 05:20:56'),
(438, 1, 'XvW1ZbVeRrm0AKtYkJ8gm2X1ghdtJQInM19nw2VUKP5FrUl8UGgfGHLXFsyh8HByTs70KgKRNhB9CtmV', '2026-06-04 05:21:56', NULL, '2026-06-04 05:21:56', '2026-06-04 05:21:56'),
(439, 1, 'j8Va6jMulzc9CZbdEgwIhshf6MDZZR0dhlMf0Vgm1mL8O1gk7WKBSf1ntQUFJGaKIRHvucDZzyfuCz3W', '2026-06-04 05:22:56', NULL, '2026-06-04 05:22:56', '2026-06-04 05:22:56'),
(440, 1, 'WfMU8i4WKcgbHZ8CfFG2ltzFQzA7USWZcHINYDtWhEBkF1gl3ATviPKVVUZ0oHLameoKVRGeYZSrgm1C', '2026-06-04 05:23:56', NULL, '2026-06-04 05:23:56', '2026-06-04 05:23:56'),
(441, 1, '0ekm9Wu7nq6A5L3OdIizbTSFYvQTCcbfTNYXNDPzZ3S2O8WIKaplUiIaLBy47NwVZHHuwwi6bTexFHwH', '2026-06-04 05:24:56', NULL, '2026-06-04 05:24:56', '2026-06-04 05:24:56'),
(442, 1, 'JuZ3ip2FJvkCT7I5PZvzYk1Y6jVjH9wTcehBNo1YqwcB0dVq2mKsYGnFnzNaV4Iub5Lyev8Doeteweit', '2026-06-04 05:25:56', NULL, '2026-06-04 05:25:56', '2026-06-04 05:25:56'),
(443, 1, 'sscauJq61hU91OP6Xu6drsQNOhC7CoFNF4AiTUwxx5uT5Dg5Bzw4IyetRgZwtjxq18aQKCWPiCYzCOJe', '2026-06-04 05:26:56', NULL, '2026-06-04 05:26:56', '2026-06-04 05:26:56'),
(444, 1, '5Nr9j3u2X9Tyr0suK1c85P9dRK79hejo5QpPnAj0hkOXfPQLCn1oznkEBXy19gRZlkG9idG4oUMTVCx8', '2026-06-04 05:27:56', NULL, '2026-06-04 05:27:56', '2026-06-04 05:27:56'),
(445, 1, 'z7QhFZEwN1yooR3AkUmyas0uV2Zhg72DpF0W7DtiP5jCsVZgtceE9JWuP7XbpRyQY4y5bbs1yzk2wnEH', '2026-06-04 05:28:56', NULL, '2026-06-04 05:28:56', '2026-06-04 05:28:56'),
(446, 1, 'b49gsp0bAKgHJk37nCjVCn0nL391n0wMi9nuuIKcvs2GqXit9WcKq1K693ZwrMEZuShbgrwc3gagcf8p', '2026-06-04 05:29:56', NULL, '2026-06-04 05:29:56', '2026-06-04 05:29:56'),
(447, 1, 'ZsFxJnFCMO9fNNmPc2rWtORt5L2jceQknYUENNAcg0IJHunIBUp2uZJIrmOZqBKOwtLIjkhse1jem0Cp', '2026-06-04 05:30:56', NULL, '2026-06-04 05:30:56', '2026-06-04 05:30:56'),
(448, 1, 'ZnOjyeQ0gjyhwBM3r1AGX65b8r8O4k2AoDygqCTAUhAcKq1qoQTgea32TWBNsTNXLMKUigJBRp7MumWq', '2026-06-04 05:31:56', NULL, '2026-06-04 05:31:56', '2026-06-04 05:31:56'),
(449, 1, '7z62B2KXG9xQtsOW8gUc8VpYGT6o3bubr2Gp4QH5EaOfPrHM563VRhJNcIh07JbEbdeTDTIuPw0u0JW5', '2026-06-04 05:32:56', NULL, '2026-06-04 05:32:56', '2026-06-04 05:32:56'),
(450, 1, 'EtJdVrwuGDU5EH4rgy9KsoAVJ1NvF6TSlok58hwBCYXTv0EjLC6ODY022tMA1Llo9nbT2mW6DzYTXmRi', '2026-06-04 05:33:56', NULL, '2026-06-04 05:33:56', '2026-06-04 05:33:56'),
(451, 1, 'MafplhQ8gi8dE0ccu86Vm3BynpKcrzA5iWLwNQCV5sLbxdmxQbvcPfYnkKKxnf3hqoBOodnKmE84sYbT', '2026-06-04 05:34:56', NULL, '2026-06-04 05:34:56', '2026-06-04 05:34:56'),
(452, 1, 'f7e5Y5UyCTFKd6czk0IpxInRdiW4BKLnIgOrSXtNXhpyYT8A8xDmVNdh0hRlgctpWHUrku3wHHXdQxX9', '2026-06-04 05:35:56', NULL, '2026-06-04 05:35:56', '2026-06-04 05:35:56'),
(453, 1, 'G7Xvl7ecgI4gPNkPEZpiInY9CiZ73awKFH6zKox6OMMBrOaq7RRx3kwyj3jzat9XLygR95DWvnwOtCdM', '2026-06-04 05:36:56', NULL, '2026-06-04 05:36:56', '2026-06-04 05:36:56'),
(454, 1, 'BKcoBY1eQ000s6wy1nF4U8WOve6vmUlNcDqIPtaqAkfabQtl2jlUorTP2aYafsZbQiLVxM2krv0jb8q2', '2026-06-04 05:37:56', NULL, '2026-06-04 05:37:56', '2026-06-04 05:37:56'),
(455, 1, 'ORpXnZeGYXScySd7bIWBpdA6lFgTukyK7F4GtvrrXcs3jBZpKHjHxqCXHqSJ8S4r8yViQAcnKnFJa2t7', '2026-06-04 05:38:56', NULL, '2026-06-04 05:38:56', '2026-06-04 05:38:56'),
(456, 1, 'Bmc0NvXThUgp6F7UHXF8XMiM2QCXdhSNE43gNe2wNy5GiTybq0usdtTv1JLYBmRxlCn1VRTaiTegrt6g', '2026-06-04 05:39:56', NULL, '2026-06-04 05:39:56', '2026-06-04 05:39:56'),
(457, 1, '9E2ox3cSEx1vqEQwgzu3hyLWRNA0OOKwbus7zJ7ztEoZVQZvOwA8yNgCDB0QaqWIoHwfwvJKxIdsRS4J', '2026-06-04 05:40:56', NULL, '2026-06-04 05:40:56', '2026-06-04 05:40:56'),
(458, 1, 'IBpMegmue7mCV2B1opHUSIcIuTmK8pVYvjGwj46xXxTzGosz0NzUl5kK78XbIt0UwavBVcG2Ka5G36fz', '2026-06-04 05:41:56', NULL, '2026-06-04 05:41:56', '2026-06-04 05:41:56'),
(459, 1, 'CjFAsmNzgOTnMCXN30YlrrBTqanSOANZ5lK0LnLyA2miBaQwZrKiPFJlkRjpuRWO49BaQzaI4M4gUHpX', '2026-06-04 05:42:56', NULL, '2026-06-04 05:42:56', '2026-06-04 05:42:56'),
(460, 1, 'R5H6q9W9oC7H8cd8ZSXsvUC5kYyqph80284GaLWUUtQjAH0H0nFGI0eeG5xrr6QnwtQD7mgq7G2rWxYM', '2026-06-04 05:43:56', NULL, '2026-06-04 05:43:56', '2026-06-04 05:43:56'),
(461, 1, 'Wj4ie8Z4WGBAnpI4WvRLGBEEwXYdVp2S0gV2ntjmckgPJ1B8tAIwrLDPwbJyxrNEh8Y0RPtw1PQWf90q', '2026-06-04 05:44:56', NULL, '2026-06-04 05:44:56', '2026-06-04 05:44:56'),
(462, 1, 'ALWbpnIkIS0x83KtLoK6oJ34twKNLavkjXwlhqyw9Q2kA330w7Tzkee5LqneZThc1WMd5QjVHkCTqB2V', '2026-06-04 05:45:56', NULL, '2026-06-04 05:45:56', '2026-06-04 05:45:56'),
(463, 1, 'SfwMOZcFB5haHgKoa8CONfJP5ZpLTW7yZV1lYuxMMGqM595CZ6AXlnwQ4aNbZQKYlt3FcJcnvRPBVTY0', '2026-06-04 05:46:56', NULL, '2026-06-04 05:46:56', '2026-06-04 05:46:56'),
(464, 1, 'LK8PZe0JSMhURpSZExUVSLbDf360TgUdAA2ZzV5YapETS9wg2nOgiewjVmSdupPXddzt000Y6mX5zn0s', '2026-06-04 05:47:56', NULL, '2026-06-04 05:47:56', '2026-06-04 05:47:56'),
(465, 1, 'iIGSJC6qAOaQaR8EdO2ClBSpgXJRBlYgP0C20wD59QoPlcXniQzleEDEmAROA8WNDIqhxVAEzq7MpWbt', '2026-06-04 05:48:56', NULL, '2026-06-04 05:48:56', '2026-06-04 05:48:56'),
(466, 1, 'CT0XLVnrevqEb8r4tcBUKDmPJsKxa7Hpf0tt65kZYY0sXQr48Gmwv6irZi4aAZbx33t7RSJRjNrrYXq3', '2026-06-04 05:49:56', NULL, '2026-06-04 05:49:56', '2026-06-04 05:49:56'),
(467, 1, 'F6AKYQbuSPFth5aHhxlasevkqdVfwAnIwuwKvFhsCsV5uD1j2DBIqiGlRXPkEt3msYC9Ef7c9HGIj39h', '2026-06-04 05:50:56', NULL, '2026-06-04 05:50:56', '2026-06-04 05:50:56'),
(468, 1, '5CJJ5laaOR5gDO9o2IhfndE6G7EtOEd4ypnqTYbDAV2EkgvZAvO1yaNHe8RydnvYnOwj4qycGkrBUnlx', '2026-06-04 05:51:56', NULL, '2026-06-04 05:51:56', '2026-06-04 05:51:56'),
(469, 1, 'OS1ZvERPtirfl9V1miXNnzCqYAqSCDOBfDAYpDwgXAzzLYaS5TXZ0WdMKmiS4zx9Mkz2wwexgZtwaIU7', '2026-06-04 05:52:56', NULL, '2026-06-04 05:52:56', '2026-06-04 05:52:56'),
(470, 1, 'SeTd4qX6MV3gq6ZjH0ZnIFhfXRRRv1dix6f75HNSbifIQhihzDEwdl5gh8Sbabb2Xi2yO1b9C3RpbS0o', '2026-06-04 06:50:21', NULL, '2026-06-04 06:50:21', '2026-06-04 06:50:21'),
(471, 1, '10oedeVuMaaO1i5A2XtqTRn2NLYj1nDAarViTzWuj100Bi6stfrye6mFCGh35Xip0VoHqgsyDQeic4PD', '2026-06-04 06:50:56', NULL, '2026-06-04 06:50:56', '2026-06-04 06:50:56'),
(472, 1, 'ORpAh6jGPuOhz0d5f26Ey8OfEAYNGpEwIUNrbK9TDe7kLgCGfjdxSk5AGvw9smZJ3vkTN0CVkKq0ts5U', '2026-06-04 06:51:56', NULL, '2026-06-04 06:51:56', '2026-06-04 06:51:56'),
(473, 1, 'Tjtd9kDHAIGwPKNkXR4CR5i2LuDmpJ5VUswEN4W9zxhkIkzXFJZyCU5eaOQ0fccqKoP9u2pBwlaRGZ6n', '2026-06-04 06:52:56', NULL, '2026-06-04 06:52:56', '2026-06-04 06:52:56'),
(474, 1, 'FqzGTJ3IomDnIRg0zO8865IoUfyIBwDoaOR2HxPT76dULRW5Qgqb0ipy4RfzfNEopJFGjNHOTQW2Nxfv', '2026-06-04 06:53:56', NULL, '2026-06-04 06:53:56', '2026-06-04 06:53:56'),
(475, 1, 'NDIUdH21ZU3tHGc7x560X6uCgnhEzbsQVr8NYwLd3yIUbj8B6QZV24WWFTjlOtMo4w1a9BOtpKaUs99L', '2026-06-04 06:54:19', NULL, '2026-06-04 06:54:19', '2026-06-04 06:54:19'),
(476, 1, 'sNk522hkmumq0fjM4lpZ4qlncMvt4t2GPJBkbEbEonKDz5BtdKu5VTcxtbdlEveOlsYSg0WUeo1ey9Wb', '2026-06-04 06:54:56', NULL, '2026-06-04 06:54:56', '2026-06-04 06:54:56'),
(477, 1, '2HDIvfiD3JNB3dO7IlRCIvHA4tcte0cWpJJk0Nl2RbJCPO5cFnGFMcVw13C6IkOzcmObQz5KEQfwFm4W', '2026-06-04 06:55:08', NULL, '2026-06-04 06:55:08', '2026-06-04 06:55:08'),
(478, 1, 'TzooKfYywXAT04wwYuX72zXBW3GOxugaKCkuR0p3PnSa6B6asenebhDmywIq3VowiTJQH83nSejzgoBL', '2026-06-04 06:55:22', NULL, '2026-06-04 06:55:22', '2026-06-04 06:55:22'),
(479, 1, 'QrGN6756GcIjuTzno9OtPNQuNzbjXR6kbVmhDXy8wKwsbE6jqdYBXAOchswoJu3NGr543J0EU7kcTapc', '2026-06-04 06:55:56', NULL, '2026-06-04 06:55:56', '2026-06-04 06:55:56'),
(480, 1, '7VLhYxCWuG1Vbx1burCBybLGMnlPykKvnhrCLI57cUQvDNNCNguTkwwPTjGBezuudr77Kry345AejnDF', '2026-06-04 06:56:56', NULL, '2026-06-04 06:56:56', '2026-06-04 06:56:56'),
(481, 1, 'L4DoUZ67EZzLO21aaioYuOGieNjFPUNpx7aBKP1GVkIwdNeYMnNCALqpqZsYi0qOJRuUa9jUoTr7IU7K', '2026-06-04 06:57:56', NULL, '2026-06-04 06:57:56', '2026-06-04 06:57:56'),
(482, 1, 'QVZZboQiWuIPwnOGWl96okiltoHvU3N3KZqXgV06KuDaDPxQvJzpk7snBATyRiFxCRjXGTZ8Ka7lLY06', '2026-06-04 06:58:56', NULL, '2026-06-04 06:58:56', '2026-06-04 06:58:56'),
(483, 1, 'JokLRhnJxPj8vj4okLgOtICi5pCfmP1uP4Rcm4djvo8SzvE0uSZJQS5NwDqxwzZdxphbnFhyBVit0gUU', '2026-06-04 06:59:56', NULL, '2026-06-04 06:59:56', '2026-06-04 06:59:56'),
(484, 1, '39mre16L5aUTkeBaxBYD7rf2za3iJTgqH7hAuQ80LkZX4ipqg7LGsOu9qv2rvO74dRzvCQAk9IkD9tN0', '2026-06-04 07:00:56', NULL, '2026-06-04 07:00:56', '2026-06-04 07:00:56'),
(485, 1, 'Qg6YyvdqOI9HpXYZsiYbf6Pk6C5XhWBr5XfHL0wKtFx2JuZnZ8UylKLW3eilblDG7fcnqj3OWO3ldRbM', '2026-06-04 07:01:56', NULL, '2026-06-04 07:01:56', '2026-06-04 07:01:56'),
(486, 1, 'QGpDFLI1tfo3c9IiiWbxepWLuqDmZeX3IQKbsqUs7JJHWOnTPE6JRtfkniKuZSoNw7pALnasIbncOfYh', '2026-06-04 07:02:56', NULL, '2026-06-04 07:02:56', '2026-06-04 07:02:56'),
(487, 1, 'ZgzF8G8IYOLsqenccHvBplFRqySiQAEcI9k1WylbopZHp8uAWhVDdLjD3gHXcyFNNcafg1MZZeEA4zzZ', '2026-06-04 07:03:56', NULL, '2026-06-04 07:03:56', '2026-06-04 07:03:56'),
(488, 1, '14xgYfbu397qyVLbaUuYJA6hGp5PFkvwhQfSLsVGCLedRoXt70hyOt0H1RGCJnAAYpCZt79t0pDOHi0y', '2026-06-04 07:04:56', NULL, '2026-06-04 07:04:56', '2026-06-04 07:04:56'),
(489, 1, 'frZTqOxAwWYKRZi4SBgLOdWVWHmDr2B9w0QQO06cWCIKGd2iltrvmhn5vF0pl3SFmsqLXz5UVnQpWXaR', '2026-06-04 07:05:56', NULL, '2026-06-04 07:05:56', '2026-06-04 07:05:56'),
(490, 1, 'e5Kb62S7luO5hJAhLRVwCvUlRrm5IEuOzgra15P7ZlPWeP03gTpZnsZFI70TNnecMdFJiJkf7CwliUxh', '2026-06-04 07:06:56', NULL, '2026-06-04 07:06:56', '2026-06-04 07:06:56'),
(491, 1, '9Lsa7qJYWDVFZ3FSK2n28S6o0YtNV1rs6dJnXKspMQt88eYu0K5lyHUZFjIwZHkG9jEp2Y0JZd108gy6', '2026-06-04 07:07:56', NULL, '2026-06-04 07:07:56', '2026-06-04 07:07:56'),
(492, 1, 'PU4MTsNOthPoDwim3fTF7S5qpliwWy9fhdKQwMNmkqZVV07FIngCMDo3W5Qv6IOsoIodAfIWYWOtdRe5', '2026-06-04 07:08:56', NULL, '2026-06-04 07:08:56', '2026-06-04 07:08:56'),
(493, 1, 'KQTbt9Qnd8lctwfeJIfbTwM3VVQlxAAZnJkS3kHrMTsOCMPSPYXywcB5lufnwiAQeLn7t9Gbf1WoXYlr', '2026-06-04 07:09:56', NULL, '2026-06-04 07:09:56', '2026-06-04 07:09:56'),
(494, 1, 'WhyTBYuGYXchqOtIJOKV2cMC74uHjO6bNSmqDqeO835dF4dics0tAOXyAclJLKNMmJ8j2RyJBp5RFMKe', '2026-06-04 07:10:56', NULL, '2026-06-04 07:10:56', '2026-06-04 07:10:56'),
(495, 1, 'vlpr499QKgSfI2smDDT8aLI6MDENxeDxabfzvSor9FaoNzzmcyWdaXY43ADPeYFe4cA7FPSNN3T9PCF6', '2026-06-04 07:11:56', NULL, '2026-06-04 07:11:56', '2026-06-04 07:11:56'),
(496, 1, '3P1tKX3z0f3sJD6mOI9vDoZpvhrzrPQioU4D9EG4MYdztv4DGsez6HoEhgsBGzViqLWqMJnge37B3uwj', '2026-06-04 07:12:56', NULL, '2026-06-04 07:12:56', '2026-06-04 07:12:56'),
(497, 1, 'Pl7vu3qisFcxjbMn66FlH7LrNkyFOoZbDa40zShJyckEGKyiK05XtK9iulgQqfEkHs6RFhanW7QsowDo', '2026-06-04 07:13:55', NULL, '2026-06-04 07:13:55', '2026-06-04 07:13:55'),
(498, 1, 'kSsE6TCAwiHxCo07JCMR4oYMpBkbhHc7QwNwdMhtUpYPP4rLJPNx6GFYD9AbdnshhqF8kmCxRHx388hf', '2026-06-04 07:13:56', NULL, '2026-06-04 07:13:56', '2026-06-04 07:13:56'),
(499, 1, 'LtW7t1E9PtMLrCXKWQr5Z3rpPjMscMb8GLlzeB5nD4E2nK1XsOdDBYAxpguBVifKruNy8N8PwMhRkzXv', '2026-06-04 07:14:33', NULL, '2026-06-04 07:14:33', '2026-06-04 07:14:33'),
(500, 1, 'GwQHkMj5caOx7TNLbvKe6WnmQCUj0QwlFmEbo4LD3jTCzJAJFHO5AhcezNyUTiyf3fkbbNyxDZjigSB5', '2026-06-04 07:14:56', NULL, '2026-06-04 07:14:56', '2026-06-04 07:14:56'),
(501, 1, '10zPEPgRLPPaGmpDrTXEWYaiwEHdQGmjf5CFJWbpCSWyTTIAn4crtitYW8Sn1bHxHp6XtObAbgNhrigx', '2026-06-04 07:15:43', NULL, '2026-06-04 07:15:43', '2026-06-04 07:15:43'),
(502, 1, 'wkDIpqpqp0GxPacvflM5NF4dt1bLNrlKp8adOT23B3KFa1eodrVaQEmIAhXyvHjvQkeydOyrL8QJIr9u', '2026-06-04 07:15:56', NULL, '2026-06-04 07:15:56', '2026-06-04 07:15:56'),
(503, 1, 'bpAYle1AnP5zemCTksU1E43xIOKKqUwkQFJbRVk267OrHaCprMcy99MFwJpf990AQ2EBFmFAyF75rzC2', '2026-06-04 07:16:56', NULL, '2026-06-04 07:16:56', '2026-06-04 07:16:56'),
(504, 1, '4vcPcDEpjmC7yXL1B90uAyOFsyEiAzf3SNwoR5YRG8A5sPdDNQdUSytuDaI4B3mI2xmOnF5HgW5H83Cl', '2026-06-04 07:17:56', NULL, '2026-06-04 07:17:56', '2026-06-04 07:17:56'),
(505, 1, 'tzQZJ2xEKwvDROp8UPW3QrdiSu0SBZ5krlrIwmnVLPPso7KmCn8O3QevFB6i1wYQ1lvBhKmBtIdQCpty', '2026-06-04 07:18:04', NULL, '2026-06-04 07:18:04', '2026-06-04 07:18:04'),
(506, 1, 'P9IrvEcJMZzVsYEtBrT2LscvtPpamePPwVzAliM7p419SKFvcWJyreGlUC90bVEBR06P9S8T3DAMtBgY', '2026-06-04 07:18:19', NULL, '2026-06-04 07:18:19', '2026-06-04 07:18:19'),
(507, 1, 'OfphfCrgxmgmsgbvMLKaAF68FfB7E8WEwjBTSjMEKJSx2Xoxn4PcHeacs9u62Dm4iQxrh7HVCkvl83IN', '2026-06-04 07:18:56', NULL, '2026-06-04 07:18:56', '2026-06-04 07:18:56'),
(508, 1, 'AzHnnCpKHUQIseEMcMp4P3cdYyBwFuAUbbyi6HqmeuJj0rhz6NLNnbH2Os0BESilgOtl4uwvszUsEgEs', '2026-06-04 07:19:27', NULL, '2026-06-04 07:19:27', '2026-06-04 07:19:27'),
(509, 1, '7JMYy0aMesk2jIJO0ijUFsKWU1G8b2WQ3X0nZLwExk1SIocXdXz90BlguSxQ0CMu9sRcFDEGvO0MB95p', '2026-06-04 07:19:31', NULL, '2026-06-04 07:19:31', '2026-06-04 07:19:31'),
(510, 1, 'S0m8W1DeE5QP6T19SGv3yhfYgsTO1y8UjDMR6Ho3qqawHkRtobcF7KkEHWP8VALpGnH4xiH6hk9tEEFZ', '2026-06-04 07:20:02', NULL, '2026-06-04 07:20:02', '2026-06-04 07:20:02'),
(511, 1, 'VlqPVR7mCTGGnzZ9lDU3DH6VxYB0RdWR0NbGHgrJI96Ik5NRm3QlB6TWCT5oCunyqfsVfDusrzkLDZTz', '2026-06-04 07:20:08', NULL, '2026-06-04 07:20:08', '2026-06-04 07:20:08'),
(512, 1, 'mahoydGeTD5ZHIOgwsOfJCDhV8j2IQa1wnsmeaNNaeF17XHcGSMyJ7lrOdfrK0ak3I9OocYHUIqf5uuG', '2026-06-04 07:20:32', NULL, '2026-06-04 07:20:32', '2026-06-04 07:20:32'),
(513, 1, 'Qdu6loZw9WLyj90LvpkRDZnmTX2xcZkc7ySq9fo0X1ydETjUW3m10GBOIwNPFb1geCestVx2wqGgph7L', '2026-06-04 07:21:02', NULL, '2026-06-04 07:21:02', '2026-06-04 07:21:02'),
(514, 1, 'ZnYvOEfI1QTI9ixGhGfwM32qAVLTGeFguzMygJT2ffmPAXTXgKfF23TlhTYDXdNhnvFwBdWDugHaZSx8', '2026-06-04 07:21:32', NULL, '2026-06-04 07:21:32', '2026-06-04 07:21:32'),
(515, 1, 'yiD96qVXYeWTj9PZpO4Ftor44NnY4xORP0YfJKjTysTM2GfcAOS3ZCK4F7IuS8dnZxfb2UiTCvUGWTny', '2026-06-04 07:22:02', NULL, '2026-06-04 07:22:02', '2026-06-04 07:22:02'),
(516, 1, 'JBij5culIpFAAa9jpJaAaimY44Pw3HbgMg54wK1t2eQdudG7EjaVDEKKGu8mxFFCZqR5rYDXtsmrNOIc', '2026-06-04 07:22:27', NULL, '2026-06-04 07:22:27', '2026-06-04 07:22:27'),
(517, 1, 'JyNy1rs2PO4BNfniyyXiVr2djJj62o7eVCHd27AnvBTZiXGrne08QTc91k27Zi8HzSPu7Tpu5MhY2IJs', '2026-06-04 07:22:32', NULL, '2026-06-04 07:22:32', '2026-06-04 07:22:32'),
(518, 1, 'NJS6srQZl9Hw7Id5nTLtsUbIS2d6jbrHImHvfovlpvIKYaLu34iaqJWyARDTJ4F7BiUJJFoZN2C2VIlF', '2026-06-04 07:23:56', NULL, '2026-06-04 07:23:56', '2026-06-04 07:23:56'),
(519, 1, 'qeFiGPy6UgOkSVKMyWaOztsiHnpSnRoQxe36WI1MCQbBVdWyWDeTkN2P8Bx96HdB7iFNdXEHuiem7nFw', '2026-06-04 07:24:56', NULL, '2026-06-04 07:24:56', '2026-06-04 07:24:56'),
(520, 1, 'pKawXlVcnV9PJmure6TZQS1IIh9sZYHxWOR9ctuEX9q6AZvGs9A0oqRAPKmEK1LQr9M6jjbn0883of5v', '2026-06-04 07:25:53', NULL, '2026-06-04 07:25:53', '2026-06-04 07:25:53'),
(521, 1, 'ewhUnftO305IUOjvVBB9QhSJV9uSxjpow2KLZb87IGW3pdOMeXaH3Ymht8IY0Odj2DXy7KRZCRk6o5H7', '2026-06-04 07:25:56', NULL, '2026-06-04 07:25:56', '2026-06-04 07:25:56'),
(522, 1, '0AJx34GJGcr2w4JN93OnNYN8S5zXvrGBL9UNV0VeWpXFYnbTAoQHuUajBfQJBpUBZRceM0tl282aoej9', '2026-06-04 07:26:08', NULL, '2026-06-04 07:26:08', '2026-06-04 07:26:08'),
(523, 1, 'sT9Ti8PMp6QwzCfR0G00RnPZgC3wuD4jmvuWTr8mEhsINYZ7MHiKlUGoQHz3NKxQPhVEPEGVTAE2B0Wj', '2026-06-04 07:26:26', NULL, '2026-06-04 07:26:26', '2026-06-04 07:26:26'),
(524, 1, '26U2aUwAjvrU6pLqEjAGKdwqRNHLZ18HlgkrZESc0pew4jQd966ehnJib8uwP0jQZmP7HR87b2zbubAt', '2026-06-04 07:26:56', NULL, '2026-06-04 07:26:56', '2026-06-04 07:26:56'),
(525, 1, 'c7gozLvZYtst2Y8qrpbY9Y9ZuyJ97Mkiye1pbs7o9OSXDAkKCqWyKZXyUzH126D9Y78HFOn1vIN9zLVr', '2026-06-04 07:27:56', NULL, '2026-06-04 07:27:56', '2026-06-04 07:27:56'),
(526, 1, 'HsXxlMUJruS0qA4FJw8eeupjCyjWNNQf5qTbdUxNl447ypIR1J9yBVovCTu3aIrhlEJsouyBiN1NuLdZ', '2026-06-04 07:28:56', NULL, '2026-06-04 07:28:56', '2026-06-04 07:28:56'),
(527, 1, 'ilLtq0gdTNJ1h9KzgdvbQ28VmJ2pgivzfMmEFYYYB0zmSO01GKy2IOR8pTmZa5dsWOF3jqMWQBM0YIp7', '2026-06-04 07:29:56', NULL, '2026-06-04 07:29:56', '2026-06-04 07:29:56'),
(528, 1, 'FegMKmhy2dkgYLnKbaenqJFSdnUSoQYD1Kuo0ZHx7V3tDMODxvL6rQgGemYLzX5gsM7eVRZpgjPfVfQl', '2026-06-04 07:30:28', NULL, '2026-06-04 07:30:28', '2026-06-04 07:30:28'),
(529, 1, '5SHwohJFXm8OZITG8TvKjcquvEV2wjqM0iNN9BVAcBqjp12f3glZKyjIRdbaW1KzV54KiLR7aq64QIvh', '2026-06-04 07:30:56', NULL, '2026-06-04 07:30:56', '2026-06-04 07:30:56'),
(530, 1, '0GA0S0W2l4iYfcALOtak4xYeQPukjEqMdSYBEJlwHARY0ajQBakOShE1Bt4iBOPgaXwBfTch0LvRW4Ua', '2026-06-04 07:31:56', NULL, '2026-06-04 07:31:56', '2026-06-04 07:31:56'),
(531, 1, 'PlZDHCztFM0eMyzMmsbtvtAmBm6f4D2qyOJWpNIVloDzCIclmnrG02qSVx8yridnMtvLw6NCiyrKSCQy', '2026-06-04 07:32:56', NULL, '2026-06-04 07:32:56', '2026-06-04 07:32:56'),
(532, 1, 'IE6wgm0bP7TtoCqZJ5g5oHXHXIXrPXLM8ZGNThIkxVIKMGWSLsS8P5Snuib1Ps0Ro07k4q3gPQLB7SOa', '2026-06-04 07:33:28', NULL, '2026-06-04 07:33:28', '2026-06-04 07:33:28'),
(533, 1, 'p1xRGBwrgccb3vpSYjg5URTBImAsnhuXc21zZM0oNq7ComRz6gWMO7uXfaycxpvPmqc5gLHyDVb35eYN', '2026-06-04 07:33:56', NULL, '2026-06-04 07:33:56', '2026-06-04 07:33:56'),
(534, 1, 'jFOaiEqar83ESNAsHgHVHMk9VpfI2YU4kkwZcGcaMtn1CSfFs6G6ChmluIMzuAZr1tJnZCCi8LJcHrB6', '2026-06-04 07:34:56', NULL, '2026-06-04 07:34:56', '2026-06-04 07:34:56'),
(535, 1, 'a5tdDv0uFBHGq7hUuN0oSEs2pN97pECP7q5DxA0cKqAd1R5nyQ3k8bMJbhY65RQ2WMO7c7x4NwLSZbf3', '2026-06-04 07:35:56', NULL, '2026-06-04 07:35:56', '2026-06-04 07:35:56'),
(536, 1, '3diydCVHsBzQblT2lzhp5FZPBVerHoIjKyKAiPG2NsT75YJkDb93FSyiJbbTRGCBWTuc1XhLnEQB3Ppk', '2026-06-04 07:36:56', NULL, '2026-06-04 07:36:56', '2026-06-04 07:36:56'),
(537, 1, 'FEHS6oL70oYLHWw63DRInzNU7PrEuWaFxtq5oftb4CR6LEsbPg8aGUKKS0BRZdxv0pIdDUOuqsfWlyhh', '2026-06-04 07:37:56', NULL, '2026-06-04 07:37:56', '2026-06-04 07:37:56'),
(538, 1, 'kK3GRFjF3tLmeBN3vmCRItyC7lEzaoJLa278q1kUPZonIb4bQeESJMpSuRHnWn9Bzxz7UuSyk9Cd1QKQ', '2026-06-04 07:38:56', NULL, '2026-06-04 07:38:56', '2026-06-04 07:38:56'),
(539, 1, 'EbtRvvTfzHNg9BFD8nyYk0nDci5kVJfCMcv1VpHX3wnz7GDgWPEbUl7oLp2puoLE7BqZ94XsEk7X0Ykw', '2026-06-04 07:39:56', NULL, '2026-06-04 07:39:56', '2026-06-04 07:39:56'),
(540, 1, 'men76JxsVVDg35GJFeveUn4ywbf86WnJrl87DIIuMjj99plxW3IA8SgGysXmbyJxmKdKCpn5dhm2JLk5', '2026-06-04 07:40:56', NULL, '2026-06-04 07:40:56', '2026-06-04 07:40:56'),
(541, 1, 'DgGdHcK1WEN1YHSixIYwdB43WWHz3iM8PkkY3hMWXZDPjcIbXl9O6rwQXjf5XFMHSWdzaSvZUVWkSxFh', '2026-06-04 07:41:56', NULL, '2026-06-04 07:41:56', '2026-06-04 07:41:56'),
(542, 1, 'LePvKqE90CzaXWdepEr8i080DOpvEmCL3F2xXE0OxYR7gnmqgfxREcmTsETqoCmrTg4nRcutOs645Nr6', '2026-06-04 07:42:56', NULL, '2026-06-04 07:42:56', '2026-06-04 07:42:56'),
(543, 1, 'mMfqsYOGqfhfmfxER0AQggvpGa8R6oUmSxcHiRrwfqsotsv1nWU03TwxLlNrivCqk5wEVgFoSASDPnkK', '2026-06-04 07:43:56', NULL, '2026-06-04 07:43:56', '2026-06-04 07:43:56'),
(544, 1, 'Zcmq8R9Xhe6KhhVZrE6Pa4AryKzglXbQ5AHcjhSj5Oz710l7J263UZwXfVv6QCRmWrZQeRtw7dP3yDYz', '2026-06-04 07:44:36', NULL, '2026-06-04 07:44:36', '2026-06-04 07:44:36'),
(545, 1, 'o2pwG78AZc87rj3tvabQw7c1droyl7nMSzoqyETLQgLNQNSjKkSddAsYcx9MT7nWx16ZfFngyacrWbLR', '2026-06-04 07:44:56', NULL, '2026-06-04 07:44:56', '2026-06-04 07:44:56'),
(546, 1, '4vt9ezUDVRIAYqvTq4vjeSHwLLlboAb9fKbRRDKGtY4CnjW4HXH3tsTGZVnXnzPFJBare73MGgSQi6nD', '2026-06-04 07:45:56', NULL, '2026-06-04 07:45:56', '2026-06-04 07:45:56'),
(547, 1, 'Dw7bYbTSgGEKCMWTFXqDek9QpIZx3LwO5StOIIXBCLzASvGGMPNxjwf72NDHCWoR7Xx9iyCXJUCYJaDQ', '2026-06-04 07:46:56', NULL, '2026-06-04 07:46:56', '2026-06-04 07:46:56'),
(548, 1, 'Vm2lJ1qaLNCUyPsZvGdHZmpOKxmRn07jmNIS3R4vcrJtGgIh0GWfWSevcD9K8TrShxZu2riiRKhnxKuf', '2026-06-04 07:47:38', NULL, '2026-06-04 07:47:38', '2026-06-04 07:47:38'),
(549, 1, 'Mgnnc4rnqaZKHKc3LUSmC64zxOilu5q4iIJWobAdMViAJf5bPROm4UaWV8NiiQL5zJ83kzwJigF0y4K7', '2026-06-04 07:47:56', NULL, '2026-06-04 07:47:56', '2026-06-04 07:47:56'),
(550, 1, 'Ec46MF6QZSzQ4v8aZYIRjkYcjYLbzMG5dEDY1X9fY8eznWZggSOu3ai5Id7ZESMRhJAnLAKALSo5svgn', '2026-06-04 07:48:56', NULL, '2026-06-04 07:48:56', '2026-06-04 07:48:56'),
(551, 1, 'oj0J67K7rr8tFOTMPLtz9QnL8kIGAPa9q9YvKey6fgcbwae3S6QD3npdaGe3psk6u9LCoKTYDH3nVDCN', '2026-06-04 07:49:56', NULL, '2026-06-04 07:49:56', '2026-06-04 07:49:56'),
(552, 1, 'sCIMEkR0nJNej5No6AYQ0U7MNfaZwx83gDrlWM6SUSkDqcCgVgRSk5043H9o4EEKmNSZKSU0SQuD9ui5', '2026-06-04 07:50:56', NULL, '2026-06-04 07:50:56', '2026-06-04 07:50:56'),
(553, 1, 'EXUQVSTVUHVaHMDrtoI6hkeh8ymrbIdpXQu1DllR1KvE3TyagYgLj8hCsAKe77amlbMrnsrNjEErUqAq', '2026-06-04 07:51:56', NULL, '2026-06-04 07:51:56', '2026-06-04 07:51:56'),
(554, 1, 'n4dQkciMSGrcu229pSveA5oAE5ITRdffBImLQhVAJ63EmeVmmy7HHH5rpgyKuMHvoNjS0odCqM3BBWVu', '2026-06-04 07:52:19', NULL, '2026-06-04 07:52:19', '2026-06-04 07:52:19'),
(555, 1, 'IzwPg19Y1TUY6UDPgqVlwaDKz94BeISBFqjwCwimtOshfQxfgnF2fzaFIZF6PbjWWqKXv8oKHkY62gSV', '2026-06-04 07:52:56', NULL, '2026-06-04 07:52:56', '2026-06-04 07:52:56'),
(556, 1, 'WvjIvQdaSIP3kAsU6kGxdFQpztrrnW4VG8hXS4fjkfRZjwPgG23jFkmIT9isQczYnRm4MNAdb9TWanGy', '2026-06-04 07:53:56', NULL, '2026-06-04 07:53:56', '2026-06-04 07:53:56'),
(557, 1, '8aejM8r4LHNErmDhUVC9gFevb2ZHqxSl1MUD2MPm3i7exgJvfpKbaHq9wcAkiHIsLRIBwAjdYVTbakP7', '2026-06-04 07:54:56', NULL, '2026-06-04 07:54:56', '2026-06-04 07:54:56'),
(558, 1, 'VNomtMMsCZrCk29NjjCSOJXNRHMc5Ivrc9pNS8UGl4Y3XFXOeeLJUXaWF0wDkxthPVQPb1LwZ0di0JoA', '2026-06-04 07:55:56', NULL, '2026-06-04 07:55:56', '2026-06-04 07:55:56'),
(559, 1, 'GSZpaM7K8gDq9DkRvxg9GFpvXIfCnZE8oWfDXdJSwux9KMks7IJZlRllKac2ig5wiY2B7B2DdDrV0qSX', '2026-06-04 07:56:56', NULL, '2026-06-04 07:56:56', '2026-06-04 07:56:56'),
(560, 1, 'QECjwZm04xqLtt7W5i2JRxihLHWLLZ1nQmc1XXINCkWdAL8QUIDS7ol3ch38GSNH9biixdIukUHUnVSc', '2026-06-04 07:57:56', NULL, '2026-06-04 07:57:56', '2026-06-04 07:57:56'),
(561, 1, 'iEetsx1gkw9fOcC3nMfdBHmr91J5sJbA7BcqnB7w51On6MPTu4deVdXk2jp92nkhKWzu6r1Gm2cmPwfT', '2026-06-04 07:58:56', NULL, '2026-06-04 07:58:56', '2026-06-04 07:58:56'),
(562, 1, 'AYQbPhQXZ644ZJpyGfyM64OD54wuw9h3F5aB6zd5B5Uoc25I3Qn8EErs998QttKGmr3xVUgiwT3B7fBY', '2026-06-04 07:59:56', NULL, '2026-06-04 07:59:56', '2026-06-04 07:59:56'),
(563, 1, '9hbbag307RzvyDljASgrFHW27S3F4851pspC4N36a7YlJn0fE5gFML8wZ0ZqATYuF43bylOLlqfqUCGx', '2026-06-04 08:00:56', NULL, '2026-06-04 08:00:56', '2026-06-04 08:00:56'),
(564, 1, 'swTHMmhVM0ztYiYcY56dna8aA6Ia5ep5krRCLdiwOXCkpKB6JcjnC1kED4z9NVHBRRT8kRM6jo5HdjQo', '2026-06-04 08:01:56', NULL, '2026-06-04 08:01:56', '2026-06-04 08:01:56'),
(565, 1, 'RieO9PqCCUsty8JgvAkBUgvfUVQZuUVGRtnr8rNYsPZ9PDyxWTROMfM8tqsN4kdX6JLMr2AVtJVFx4pF', '2026-06-04 08:02:56', NULL, '2026-06-04 08:02:56', '2026-06-04 08:02:56'),
(566, 1, 'dBVc34a7YoHvVelNoPf0Qn1myCmu2LLROQp7n20zpZW3VTxI5hqSEoyAcP6rbtNDCsChwDeuX6Ki24oB', '2026-06-04 08:03:56', NULL, '2026-06-04 08:03:56', '2026-06-04 08:03:56'),
(567, 1, '3G9WiNkCQZm2A1u8SDDIwcXuUprEnFx0Vn9pN5BcUKIoqCvDf86yEfNWIaoS5tZzKG6qKVBTPt84oFIW', '2026-06-04 08:04:56', NULL, '2026-06-04 08:04:56', '2026-06-04 08:04:56'),
(568, 1, 'j9b8i1B9djvQokSdlVlNvxQE2PI3oAzdi96300QcGpVGHWEdb68GI6IbMDyf5VoSsnOqBMpWRcH4vxCT', '2026-06-04 08:05:56', NULL, '2026-06-04 08:05:56', '2026-06-04 08:05:56'),
(569, 1, 'fOZw9Hfxhsgcs32yIgo2EMOMyfG6CBAb8QEUZOiTB4WQQDHI3xdJR1H7ofFVAhsAPI28SsGq5jvfaNuz', '2026-06-04 08:06:56', NULL, '2026-06-04 08:06:56', '2026-06-04 08:06:56'),
(570, 1, 'RnY6r5yfxX0zPFOP3p9EmylcFv5Qn2zoWN4EYr5UJ0wLUVptQKi4wsyJep6y6gyjbr0Sx6EIU6bNh8OU', '2026-06-04 08:07:56', NULL, '2026-06-04 08:07:56', '2026-06-04 08:07:56'),
(571, 1, 'hsJGSRPPM0e927GIr3poP5urTTjAVCYPp3BpYKdmLXhp8LH9c86h9HXQUxChGgZwINDxcltDwvVXYV0P', '2026-06-04 08:08:56', NULL, '2026-06-04 08:08:56', '2026-06-04 08:08:56'),
(572, 1, 'odxVukEugKxbmnZmv16x3e2xMLEYLtbnay5CfYQTd5KuMjsIuSaiCZJzBqqzb24WS7XQn2q5CHFbGcUL', '2026-06-04 08:09:56', NULL, '2026-06-04 08:09:56', '2026-06-04 08:09:56'),
(573, 1, '41ysdBvMONEvFML3tFX7IEeeDChaVsgOka1IkiUTV9Nk1oPkAgLR9g3aBJ6HThIF2AoD9Fazkhnlsl2O', '2026-06-04 08:10:56', NULL, '2026-06-04 08:10:56', '2026-06-04 08:10:56'),
(574, 1, 'aFwspeV3k8HB6Q9FxE0iRVxDXgw5xCUKOBag75uYvlc56x3Ak3uS6HZEUjZfuiSTFaa0dZSrLSgeec6y', '2026-06-04 08:11:56', NULL, '2026-06-04 08:11:56', '2026-06-04 08:11:56'),
(575, 1, 'G6QJqzlhrhEbrtmQokG8qrpwna2HfUm0jiNn8leZrzI8zjtwRuFEpwiNmt3APX1bolSdwcKKQaNckzdt', '2026-06-04 08:12:56', NULL, '2026-06-04 08:12:56', '2026-06-04 08:12:56'),
(576, 1, 'NxiSP68aIZslaefjiKi4quhdid2svBGyljARog5Ons7zMhEvMwJ6h5zq1wK6OGMCuNn5e9hbeHLhEFCw', '2026-06-04 08:13:56', NULL, '2026-06-04 08:13:56', '2026-06-04 08:13:56'),
(577, 1, 'VbZTfCxGBq2QEVJ6pkEcCeZLBjEhLZnX9ShlhO66q0DwojkA4ApJrlcJODhXbHE0LPUMHQPn9NghsNXr', '2026-06-04 08:14:56', NULL, '2026-06-04 08:14:56', '2026-06-04 08:14:56'),
(578, 1, 'Zs9jle0OVgKMeYP8ChvwHTj7s8jWLBV99Jb28muARtwcL4ZvYM3z9zYytuoRqAHVeT1uWxIB3G4I7mMh', '2026-06-04 08:15:56', NULL, '2026-06-04 08:15:56', '2026-06-04 08:15:56'),
(579, 1, 'zXCH2hiMOLCD3gORS5rDeVROAavIXEj287rsPzH9ZjEoLSMVioxJzNJKKV3mbSCupfYfqZjR1pNcwkhU', '2026-06-04 08:16:56', NULL, '2026-06-04 08:16:56', '2026-06-04 08:16:56'),
(580, 1, 'cNIE7W42SPElNWPCj6grxIL7ItTFdQ3qknSDl2uLlNqn4yOIbl61WYq2a5HCq1Q25z5LmI3F1mQjA78l', '2026-06-04 08:17:56', NULL, '2026-06-04 08:17:56', '2026-06-04 08:17:56'),
(581, 1, 'kWATVMeOYmpP0jt7J1pYi9660X1FycgHVEgreV2akxuJBseROkrQJWJRg895JVGLCiYVASbwU8qMlNz0', '2026-06-04 08:18:56', NULL, '2026-06-04 08:18:56', '2026-06-04 08:18:56'),
(582, 1, 'I1t25V8l5bMj68L8cRpv1PIqVRbXGnJZWzEBYMOIHAKSvvTHPEY8kLinjYv9pbwGArAMdeoLVtcCAsCk', '2026-06-04 08:19:56', NULL, '2026-06-04 08:19:56', '2026-06-04 08:19:56'),
(583, 1, '19iqIe1hzKe8L4tQzGhjTJjVsLRxq37QWKagMudptAdvh6ZkQxM0i0F4syMtFbqyFjvBsJYz3v6F3A1y', '2026-06-04 08:21:04', NULL, '2026-06-04 08:21:04', '2026-06-04 08:21:04'),
(584, 1, 'Vgt9p9nf2pGKGqrvCE2FSqOMaMtmIO4tBEey2zC0aRRWLN6C2Y9u1p7Ocn0ynqByh51pFOCvnuaKaQ1l', '2026-06-04 08:21:56', NULL, '2026-06-04 08:21:56', '2026-06-04 08:21:56'),
(585, 1, 'cAmoEQ8mBEEWuciG8EniwPYesbGsBSXfBa0145giDJ0AH1g5DSa5qfokwFCo8c2PA2940b3O12H3V3td', '2026-06-04 08:22:56', NULL, '2026-06-04 08:22:56', '2026-06-04 08:22:56'),
(586, 1, '7mglbjIbRczlhtHzsrnJyDNkFjInw8NezJyi8ZId3LEfFlIPdXhob8mamwqqZYBzHRHIcRlqCbUqx16N', '2026-06-04 08:23:56', NULL, '2026-06-04 08:23:56', '2026-06-04 08:23:56'),
(587, 1, 'AyYEozSxZM5ANSNXP2v9qn0lumZ1zSw2J5ejdA5bv3ig0jyclUcNm8uDfEJ3RmegH12Wc1U7LjOnAaee', '2026-06-04 08:24:56', NULL, '2026-06-04 08:24:56', '2026-06-04 08:24:56'),
(588, 1, 'bM9qjBUiYUVCBzrcR57HztHY2nw4shrfm02fVUv0mva9PXt4zkOcVgcdoyyWjxJcqN7yj28621Gan5iE', '2026-06-04 08:25:56', NULL, '2026-06-04 08:25:56', '2026-06-04 08:25:56'),
(589, 1, 'ZfBaQOm1AHaUhlCiJ8QtmgcDanVasuQ5ZL5bn2Rapu4yCTBwoiwGzaAlDUxcgIlogamsgZwn8VaUMogl', '2026-06-04 08:26:56', NULL, '2026-06-04 08:26:56', '2026-06-04 08:26:56'),
(590, 1, 'aaZ7xc01sPsR1CcBRmDTy2RA5FV4sezhNSG1KmtysZXnOSDg2cW5F8CFDSfSFGaFcCvyQpswV8axlFKA', '2026-06-04 08:27:56', NULL, '2026-06-04 08:27:56', '2026-06-04 08:27:56'),
(591, 1, 'rdQYzZzmtpd2W4Y2pIF20QYUXpm7ddZ4L4cl0mwGQbPo4vWPjLNnSgSw3X1SSMcua9hVnnczAnM5wafR', '2026-06-04 08:28:56', NULL, '2026-06-04 08:28:56', '2026-06-04 08:28:56'),
(592, 1, 'wvmZTOkcgD51NMzV1uLgyQn1Dk7NCeXv7Uiac1D9m2gLrd76F6MpzurM1Gwq8V0miux2Ib10qlnDoyJh', '2026-06-04 08:29:56', NULL, '2026-06-04 08:29:56', '2026-06-04 08:29:56'),
(593, 1, '14y92XsvwzlTGbfYt0vyjpPs7ErlNyIzMcJk40qGZfdcyPJ7sT6pnmDoQv0j9XUKr0Su6xGUHY6277rc', '2026-06-04 08:30:56', NULL, '2026-06-04 08:30:56', '2026-06-04 08:30:56'),
(594, 1, 'sFJqh2wHuXb3im1hJaovZE03dq0wEHX9zigpwNdaPtVRpBmE4tpOVFJeA9mNhnPLHTzryI8LEQfVudgo', '2026-06-04 08:31:56', NULL, '2026-06-04 08:31:56', '2026-06-04 08:31:56'),
(595, 1, 'DCl1oYZTuRbNA6QnpCZoG0QI9L07Dy4tDqx3xX92EUz86EORKyYcfC8fe9iq6HhQ350qqZs2gchBtaoc', '2026-06-04 08:32:56', NULL, '2026-06-04 08:32:56', '2026-06-04 08:32:56'),
(596, 1, 'VBCnVp242gW7YSrUQGToSAKqecly9t5WUR6DfhmRMIjjJ1OPh1tOwcCVcchSC5AIPP9QaXiMtTnRRpwS', '2026-06-04 08:33:56', NULL, '2026-06-04 08:33:56', '2026-06-04 08:33:56'),
(597, 1, 'La1vjLaXpdVpCKruVj8oRoWB7QWZLx6ll5rEXlGbMEHs6xHs6tVhPRqeKD3130qYLEYRFgpmm2xIEqeQ', '2026-06-04 08:34:56', NULL, '2026-06-04 08:34:56', '2026-06-04 08:34:56');
INSERT INTO `totem_sesiones` (`id`, `totem_id`, `token`, `inicio`, `fin`, `created_at`, `updated_at`) VALUES
(598, 1, 'oEaWg105PJCsfUKuzg0FFa1lY5SKCsOzu0fpYhSyNcFO93vIrdUVOdpGWokzMoxGW1JJJjWoSBptrQYD', '2026-06-04 08:35:56', NULL, '2026-06-04 08:35:56', '2026-06-04 08:35:56'),
(599, 1, 'xHd2gpUzlMm71hcVCxlngdltBVrE0PUDDqCVxUSdSEr4r7QLrpihEi9NebGUvUdRsHbuOnCBMeUqKjJy', '2026-06-04 08:36:56', NULL, '2026-06-04 08:36:56', '2026-06-04 08:36:56'),
(600, 1, '6FA7ozhNri3Uo7ahBqmvAt2fGc1jXUIHUdf3hbjPTY9qLNjBn4lslwbUp16mZG7EOLX6ie9InB2Dp8LR', '2026-06-04 08:37:56', NULL, '2026-06-04 08:37:56', '2026-06-04 08:37:56'),
(601, 1, 'x5GVG7VhCeKilRAY4oWVUpMgWph0VarQke739WaxeuGRtrPMp0xTa0Lw5AgXeEfXVSi6dVW63Kf9TQXt', '2026-06-04 08:38:56', NULL, '2026-06-04 08:38:56', '2026-06-04 08:38:56'),
(602, 1, 'uxMMSR4TJnNNvK4emgsiDPpBwIpz2Dh6KhNJd8Y0J9SYlf9RrJI5dhTMEuOtAt2FsW5lc0uN3UerzYsh', '2026-06-04 08:39:56', NULL, '2026-06-04 08:39:56', '2026-06-04 08:39:56'),
(603, 1, '0FNN5JmPufUuAGPbngKvCANngZ4muXPQeeCjJVrBYcMJn4VgTJcIvvtmz9kdsphtVSI1jeHBAsShtUz3', '2026-06-04 08:40:56', NULL, '2026-06-04 08:40:56', '2026-06-04 08:40:56'),
(604, 1, 'jdg1Y1IoEPhs2WATwZiOog5kS1BuKTKDDubTwMXSufgkom1ShRVYGp5IWbl5MqsHpZnaw7oyEzjbCoAN', '2026-06-04 08:41:56', NULL, '2026-06-04 08:41:56', '2026-06-04 08:41:56'),
(605, 1, 'Nse56QMnjBBBxI8jWcNYtLfU3yi9UnwnDSQSV4PjAWWupbyM2pZZDCZAriAtrd7b5JYZnIqJNoUP1uYI', '2026-06-04 08:42:56', NULL, '2026-06-04 08:42:56', '2026-06-04 08:42:56'),
(606, 1, 'LU0qWS6YXjmglSEswEMidZvlTd25MgsihwpwsoI33oQHzXiNHg37ABhyoNTLTY14khAOrHbgFr0jjngd', '2026-06-04 08:43:56', NULL, '2026-06-04 08:43:56', '2026-06-04 08:43:56'),
(607, 1, '1aYBof1O4baICfz66cND9jJ4Co99sSEHUG1MI2bzmy1zOPBpQd8pbyCKq71AhL6pAN2rApkJQJUkXzIp', '2026-06-04 08:44:56', NULL, '2026-06-04 08:44:56', '2026-06-04 08:44:56'),
(608, 1, 'PeGnMpJ0AdjIFY1yLsY7fHTPo4Bq8AbyRT5ui8ifYA6n1nViR8kbTLyGDFidD3R0ErRprUgXqhmVWiNH', '2026-06-04 08:45:56', NULL, '2026-06-04 08:45:56', '2026-06-04 08:45:56'),
(609, 1, 'n207l887CZfDhWvEbWYqb92jO92OB4fYr6gxgzoPyAI2j9zJuaaRrlpkxjHUlC8jn6s8kBHqVafU68JN', '2026-06-04 08:46:56', NULL, '2026-06-04 08:46:56', '2026-06-04 08:46:56'),
(610, 1, 'NXgEqXhueOnWGpypSa02aybFwguutFqXfjsWQYggAwTv4oNCC0k1uvdym90972BT4nTYVvPbTqBtWQnH', '2026-06-04 08:47:56', NULL, '2026-06-04 08:47:56', '2026-06-04 08:47:56'),
(611, 1, 'Kb20GnV3HIiVAanqhitxpeds6EKshb7gOOzIX80M3G9RcU5w4W2uqnXCjAsuYtZjo74nQhtv53Crinlz', '2026-06-04 08:48:56', NULL, '2026-06-04 08:48:56', '2026-06-04 08:48:56'),
(612, 1, 'Hs9K03wxc0yiXlOmTfqEEY4PbYSyE5O6EFXEhXsvBTjdrsYMBkP8hn2e8ZYfMIG6hIqjcPTMKN1OYjQb', '2026-06-04 08:49:56', NULL, '2026-06-04 08:49:56', '2026-06-04 08:49:56'),
(613, 1, 'VOzrE0ZLWfqGMfMPH6uhmfeHfDDfVYT7kkxAkOwypf3q4ZnjoyOHJSXCy2FMHYBTaB211c64D6tSIJpo', '2026-06-04 08:50:56', NULL, '2026-06-04 08:50:56', '2026-06-04 08:50:56'),
(614, 1, 'VqpZUV5GHAIGgkqgPAK8o7FxsyvINGMqu1p6KQtUQG7TAWUlH9HX8k1By6QqEqKvw8BwhkO9aoYce9ev', '2026-06-04 08:51:56', NULL, '2026-06-04 08:51:56', '2026-06-04 08:51:56'),
(615, 1, 'BnzVR5QZNxScUahGhMyz7rWatdwhO4Qy1I93GFCOWDfROc2c9jT6BVG49hfomugmRMrI7SnorpsLvtG7', '2026-06-04 08:52:56', NULL, '2026-06-04 08:52:56', '2026-06-04 08:52:56'),
(616, 1, 'DKvo3xiuSeXi2K7OI3yszeqhmoWaq4mZ2JMqddpS1q739bbg5pUqxUR6dTZRlUXGuwp0TwYOcjE3myqN', '2026-06-04 08:53:56', NULL, '2026-06-04 08:53:56', '2026-06-04 08:53:56'),
(617, 1, 'nzv3jcA2ODCQ6GMFtKljECu5WLfB3igx39SoAvkofCffdiJmJ7Gc2QMwIEDtPDLyVuvdsBbfpijTVvvV', '2026-06-04 08:54:56', NULL, '2026-06-04 08:54:56', '2026-06-04 08:54:56'),
(618, 1, 'N5Seo3ZJYtkqB2QbjlElugsHIXBGi49BBgMXtESLSfA9DdplIVHwuOyxdlaKXz4ReZOJ3Apx1MY50wJZ', '2026-06-04 08:55:56', NULL, '2026-06-04 08:55:56', '2026-06-04 08:55:56'),
(619, 1, 'iuuwZPp1WAYlG5FbBEyMqufkrc3cG7FGhcpHuJSxIgPLbvB303ThSBnBsnvUw6EyhHj848wFnxBHxuFc', '2026-06-04 08:56:56', NULL, '2026-06-04 08:56:56', '2026-06-04 08:56:56'),
(620, 1, 'DOxxdzVmi7p5QoFHlmsgfNBPGLREUAOrx0JsFzXQS7OiPhfvqis17Iw4QuGFKlKL6DDQBKOd10O5zkK7', '2026-06-04 08:57:56', NULL, '2026-06-04 08:57:56', '2026-06-04 08:57:56'),
(621, 1, 'K5HLyV4kng053P0SAladrF2aGMsH6Opuv3lz0WjoaNyaMfHYzqC6EQ8iK1M5OWveXOfvPGrE6exEetjm', '2026-06-04 08:58:56', NULL, '2026-06-04 08:58:56', '2026-06-04 08:58:56'),
(622, 1, 'nY7khixMUSzpUZDsohxbhMwkGeXYl3tG8Vxzl8ly4Pqf1qqNHjACZsiIlLuweExUhHbhsa4SKlmMnO1g', '2026-06-04 08:59:56', NULL, '2026-06-04 08:59:56', '2026-06-04 08:59:56'),
(623, 1, 'ILJvuuxCGtq8TFLRTWAQoCnk5qptfEpXVUmgAWgiMb2jYbeBhA1kNmWLGM0DzYnIYWCNvAAPqLdn1VyB', '2026-06-04 09:00:56', NULL, '2026-06-04 09:00:56', '2026-06-04 09:00:56'),
(624, 1, 'ewGBIYJG7UbBkUPgB9EyLOCSiaoVEsQgQ8Ve93Vr9lU0olSsKkTGq1dpa1bViMJwVR5ZDqlGvqeYjXhW', '2026-06-04 09:01:56', NULL, '2026-06-04 09:01:56', '2026-06-04 09:01:56'),
(625, 1, '5EVn31Gvqsc5T0XYbWDH5xoXp37v8TPxiLVi8pCkBPKhB9nAExvu9s29OOSzFXAoPHaV8qWy8C2R0QZq', '2026-06-04 09:02:56', NULL, '2026-06-04 09:02:56', '2026-06-04 09:02:56'),
(626, 1, 'DFmF6DS4yUdDBrcpNyd8fGOcwHmjEfd6OHlkrG9hy3Vb4PTKS0aYA53qH4wi809zDaaI7DIDHClegDXO', '2026-06-04 09:03:56', NULL, '2026-06-04 09:03:56', '2026-06-04 09:03:56'),
(627, 1, 'bd0V8UiiWTONypHKWvEdcnGjoK7m47RTd33EBSpzUySF6Zt0ZbChjQOwdThbSL6VQa0gy7vWdDedOkc5', '2026-06-04 09:04:56', NULL, '2026-06-04 09:04:56', '2026-06-04 09:04:56'),
(628, 1, 'wQIdkZRFAVo6Y7lpTLl98dWa899Jx8aouILh1dAid03xLKIEynzAXZNgreAELZMGnLv1DZCSwa8ARJGw', '2026-06-04 09:05:56', NULL, '2026-06-04 09:05:56', '2026-06-04 09:05:56'),
(629, 1, 'CP6ipJyoR6WQE1JOcIMjhA6bXYtySsxHZb3g3Yd16yf0jxNkdA70GHGC9LPGObg63njOkzqK51WFzgBG', '2026-06-04 09:06:56', NULL, '2026-06-04 09:06:56', '2026-06-04 09:06:56'),
(630, 1, 'ktqC9VzXixfal31X0UIBsJSb3Stnf0eNYqGh0WntiFuxsbi4PX7cklFQhtYZIDKffdriNvc8lWZ3GuOO', '2026-06-04 09:07:56', NULL, '2026-06-04 09:07:56', '2026-06-04 09:07:56'),
(631, 1, 'FLBgWMTlGd89blrcYYQFMSOPPR4ua81sV3vD4CUvj4x2Zf1JcFi55D7YsInFd0SHTcwJMDs69SHIBgom', '2026-06-04 09:08:56', NULL, '2026-06-04 09:08:56', '2026-06-04 09:08:56'),
(632, 1, 'YHSfWXpfSu6jWT1luzUdx7blLQZHa3rrrKi0lJGUJEd5PLanzSl2g0YqhJIJPv5pki26uxO6Eou26zYe', '2026-06-04 09:09:56', NULL, '2026-06-04 09:09:56', '2026-06-04 09:09:56'),
(633, 1, 'jtZqxaK2uWcu0yIRkzdwupZ5MWu2WCd09Ne4h67FVSAWEyM3ihmttJe1VIj2Mmtc2DjpmwXJ3v7u8aNz', '2026-06-04 09:10:56', NULL, '2026-06-04 09:10:56', '2026-06-04 09:10:56'),
(634, 1, 'bQid31YIhvnHaw18e33nxiFAIyZDELjhUyj4EXaGlutr2yzzWEyerP8BW6FiS7vEQ7cQvAhKbFFGpDSF', '2026-06-04 09:11:56', NULL, '2026-06-04 09:11:56', '2026-06-04 09:11:56'),
(635, 1, '7G269cryu52ook3NDUt0VVIcfeWU6GuL4xCgGyw6Y6BGAzq8L2ngWC4E2lvpxRfFxJxa8kBKQH2Yxz5g', '2026-06-04 09:12:56', NULL, '2026-06-04 09:12:56', '2026-06-04 09:12:56'),
(636, 1, '4Gk2MogED1v1V0qs8dkNbcZ7wB5ZvnyMEzlIvAjZIeZ0XeYrwHe5dywPipsxkb6PrRamWLTaga7rlFOd', '2026-06-04 09:13:56', NULL, '2026-06-04 09:13:56', '2026-06-04 09:13:56'),
(637, 1, '1FQ6E0yCuTtcLWIv4zzutnm911rQoRcmEiA4lRn2VM9hJJU31It2tLGynN2GVpwpeeZBVkVFN48NZRho', '2026-06-04 09:14:56', NULL, '2026-06-04 09:14:56', '2026-06-04 09:14:56'),
(638, 1, 'Ys5YMsHiz7bkslQhQTQj8xjDRHdhk2pGSEkzPlJ4j1oiMLXh4LFeZwhyv6ahMBieRYJ9GqDlkwgs4MLv', '2026-06-04 09:15:56', NULL, '2026-06-04 09:15:56', '2026-06-04 09:15:56'),
(639, 1, 'Cqw1XEUNrfHXw9ZLoFmo5v62JsJNsmQFWvBgMpfleoBVpP3nWDR88wcxuGrC8Iux20qzlw4A22U6vU70', '2026-06-04 09:16:56', NULL, '2026-06-04 09:16:56', '2026-06-04 09:16:56'),
(640, 1, 'FCuP4gDKd71k5CGdOdcmoQwGP34qJt1oeUUw1EnOrmgoxMnLasMtTsxn3thmgNZ3SGjXXouCBFNvVU4j', '2026-06-04 09:17:56', NULL, '2026-06-04 09:17:56', '2026-06-04 09:17:56'),
(641, 1, 'G5r7viGIlQ1buJH9J7ZxbgaTwRP4YL8VtW8O7dBVUN7jeRD8cwbJmKJNSdKBVt2xlv7gJCCiojLa0VJN', '2026-06-04 09:18:56', NULL, '2026-06-04 09:18:56', '2026-06-04 09:18:56'),
(642, 1, 'd2gnvIeiRMumqRIoglWMn0W5COnW8Yxafuv8AANzNW79OVPBp7prIe3HWhEpmItsrWfZWCRTTWbKPBPv', '2026-06-04 09:19:56', NULL, '2026-06-04 09:19:56', '2026-06-04 09:19:56'),
(643, 1, 'IAgIA34eRHjUFE29JZJq9Ix8Iu3rkTfoY9eCVdQI41gM4ZB6otTmMNaSXiK59MPDfZHQJqZz52CsGzl9', '2026-06-04 09:20:56', NULL, '2026-06-04 09:20:56', '2026-06-04 09:20:56'),
(644, 1, 'OHC19FZ7p2EHWEm4SNrDIkWAlkQvh4tgmmnkooVAAevceKp68Ejyyzn87L8kPyt3QdQKHlnzXxJqrNCw', '2026-06-04 09:21:56', NULL, '2026-06-04 09:21:56', '2026-06-04 09:21:56'),
(645, 1, 'ZTqUQRph8H6ZYxHCd4H98aknwVGp9P0pwa3mZMrXeqeUf6tP96VKIGo7cKMbhJ1WlDT3bm6DKjSGzK4z', '2026-06-04 09:22:56', NULL, '2026-06-04 09:22:56', '2026-06-04 09:22:56'),
(646, 1, 'LcMuIErDiUwi93hEyXrOEH1kFzIgAiriSi3frCkyiHf2ytl5jUfdEbjbhST8gpxb0WEozCKaxTqfw4iO', '2026-06-04 09:23:56', NULL, '2026-06-04 09:23:56', '2026-06-04 09:23:56'),
(647, 1, '8zF3JStjvmbXhsiopkSp8LwrBQhPG1W00PIlO3qQoVuNy29pGmmd6FLUqUN4yU8Dr0NbwpNpmcTKXPjn', '2026-06-04 09:24:56', NULL, '2026-06-04 09:24:56', '2026-06-04 09:24:56'),
(648, 1, 'x3ULDTxhmF5hTrzOIDdeAcaEuK8jfdM2cE9WOInKNyZFo13uGXdh8hsHojTiJD8zrJfrsfEAUEko0dO4', '2026-06-04 09:25:56', NULL, '2026-06-04 09:25:56', '2026-06-04 09:25:56'),
(649, 1, 'sWCFjOUlFA8kmTae99dnUGFsSihm8R1lLUcGwgApzXhUTHbQSTbEhDvPkqTP12pWX7L5OQZiyO8kGuks', '2026-06-04 09:26:56', NULL, '2026-06-04 09:26:56', '2026-06-04 09:26:56'),
(650, 1, 'PMaLz09dL4vcrNCeuh8ZFDO7IP2itPTmVd2jocvutPli44R4Ah7KXKvfpeDOUJzmSoDYrUdHPD3OFFCq', '2026-06-04 09:27:56', NULL, '2026-06-04 09:27:56', '2026-06-04 09:27:56'),
(651, 1, 'mChZeX2e2VdYwR051lcVbgEt9TCJRJWDQDb7C6pA9FwhrWo9dHPwDu9AOKopsVPDHzWn2sXchmcP6ee5', '2026-06-04 09:28:56', NULL, '2026-06-04 09:28:56', '2026-06-04 09:28:56'),
(652, 1, '9z58orMUxc3BurRCJOtza99ZrM4BBEQ5THPjF6aQKKsp6tjeeaAkh4CZXRZTXO8CAESzxvYxJedO6w4T', '2026-06-04 09:29:56', NULL, '2026-06-04 09:29:56', '2026-06-04 09:29:56'),
(653, 1, 'PGqT32lF0Bi7Nx6d7jGe6590z5uqoLGDZ6Ikb1iCPX5O1UsbsPljuQ6foAuH9Vh40NBRLjlUuzm2IAsu', '2026-06-04 09:30:56', NULL, '2026-06-04 09:30:56', '2026-06-04 09:30:56'),
(654, 1, '8spLrzPGuhHnonlbNpb3FbsvYTqtlC26UMxt4C2wLd7OjX3GWlhjx3W2iLzbQ27rXuZSWwilRcn3lAj1', '2026-06-04 09:31:56', NULL, '2026-06-04 09:31:56', '2026-06-04 09:31:56'),
(655, 1, 'EMGgFCJ3stxbs9LKESXNF0ShqIIDCm1LVEVQM12z8eSqApUTmZnXMNChngt2XS69d3khQb1CVfT5Smzk', '2026-06-04 09:32:56', NULL, '2026-06-04 09:32:56', '2026-06-04 09:32:56'),
(656, 1, 'Nv9fAyMyyEmIurcGvhzeLmTeUo1EJ0kSDRuW41KZPM7Fbmc2ORYEDt3zvLc9Hasd54JrzUl0AY4LW2LZ', '2026-06-04 09:33:56', NULL, '2026-06-04 09:33:56', '2026-06-04 09:33:56'),
(657, 1, 'BkeDs7T1B88P3Fy7isv5PeGO19UduCtC2QjL6Y675qMay6WNRuxgE6nK0okhCPpFIGpDafEYK6KAvKIR', '2026-06-04 09:34:56', NULL, '2026-06-04 09:34:56', '2026-06-04 09:34:56'),
(658, 1, '6F3zd2dkESsLGxUjZ46N0PrpH36mfnEc8gcRG7akXTJDSn0spyBC9yxBYFY2aMaVCaiDhv8Q0oQwdYbA', '2026-06-04 09:35:56', NULL, '2026-06-04 09:35:56', '2026-06-04 09:35:56'),
(659, 1, 'JJ4Hm1pFeMzQQw9Ajf4JLtxcNdSnXXwvIVBKRz0Yp21FCdsKZjvvk75sz0L3W4bhOI53YylL1pkptlSw', '2026-06-04 09:36:56', NULL, '2026-06-04 09:36:56', '2026-06-04 09:36:56'),
(660, 1, 'LpQ2dE2ZZrRzVqU7XjHPIFjInVVgjyTZQVKVgxBHnGudXkbrVN1c2lOHiDPBlM021YPB0lrzTRJBTJ0c', '2026-06-04 09:37:56', NULL, '2026-06-04 09:37:56', '2026-06-04 09:37:56'),
(661, 1, 'WdRUiGZXvHYUbR63D8CE7j1tfBbnn0r9k4wHxcijlOeMx7Iww1sqN5D5MtzzWbfn9egRNII0jHQnmXyK', '2026-06-04 09:38:56', NULL, '2026-06-04 09:38:56', '2026-06-04 09:38:56'),
(662, 1, 'XZriRrXQLjBKBLEnUP61FHhO9VJne9ozCfCtszSdLGljhj3M0Rvddsul2nCBZ1Uoq7hYgdWE7zzdcCLb', '2026-06-04 09:39:56', NULL, '2026-06-04 09:39:56', '2026-06-04 09:39:56'),
(663, 1, 'xFxkKT0mmu3rcoKu6rCdgLJlklENszIRN1ESl9VPQ81klvgrzq3DpskYcYSDc3scPFe7pFwB4YSkDv8O', '2026-06-04 09:40:56', NULL, '2026-06-04 09:40:56', '2026-06-04 09:40:56'),
(664, 1, 'JZ6SjL6Y4e4y44wJ671dM6lGbYbgUKZB5ImfhzvPwfRiWbxlAg9LlePcQMphlUM0eXy3ltqwK6GuR9ro', '2026-06-04 09:41:56', NULL, '2026-06-04 09:41:56', '2026-06-04 09:41:56'),
(665, 1, 'siSEkjHyt9I5eJgY7ueARvA92WJ7PUKcBNdhIciBpReTwucTOosIyA2bMSWNTmpkBBpxxJH8aBGsZt5d', '2026-06-04 09:42:56', NULL, '2026-06-04 09:42:56', '2026-06-04 09:42:56'),
(666, 1, 'Tcb1oLzTdluiHbEQ7w1QjBQcGCnwrNx0CxAKgh3LO3BGE9VfS6px2dH7C8H21cXPtyuMEwJOqwEteaIN', '2026-06-04 09:43:56', NULL, '2026-06-04 09:43:56', '2026-06-04 09:43:56'),
(667, 1, 'rT0ujvJpG9ApMalI6MOPWFoL2BY2Yjb2olquQhiOgfkucioNqGaxUPmbTxL8ZEFjWHPFzZGcnjGll7iG', '2026-06-04 09:44:56', NULL, '2026-06-04 09:44:56', '2026-06-04 09:44:56'),
(668, 1, 'eZK66fxNJZM2vjvsIWns22MriqRyxYpLfyCjvUJtCLPKK4KQrp7yrRsnPQZ3PzqC01t05hQCWEqGRznx', '2026-06-04 09:45:56', NULL, '2026-06-04 09:45:56', '2026-06-04 09:45:56'),
(669, 1, 'VFzyJTEiyMNU1RS3mBpCUv7I1alyle0GRPQF594s3pkPObxTu5PGafiw8T5zhsbpgNVmB4LmamKuOOD0', '2026-06-04 09:46:56', NULL, '2026-06-04 09:46:56', '2026-06-04 09:46:56'),
(670, 1, 'MIywfwwOxDwRTwEGeQ6dyFp4TvGj7OeisFfxieBZ4Pb4OAvSKY417StpThiwHFmAIrwMcgMrxy33ZuGv', '2026-06-04 09:47:56', NULL, '2026-06-04 09:47:56', '2026-06-04 09:47:56'),
(671, 1, 'Uq8u2ATO5EmMtc6qVInRi0MNXLfG6JfqM4BGzHXCDcGXlCUT9rDt0UOCLkQ82U4XinbDvUDYcTkXDrPx', '2026-06-04 09:48:56', NULL, '2026-06-04 09:48:56', '2026-06-04 09:48:56'),
(672, 1, 'jqzUFhjlt49ZZjOW781QQZC4ODn0n6wgggYtlOdZQ3Q4696lEyne4f6eB9ZV0xlNR9k2MSCxfJRDDZJF', '2026-06-04 09:49:56', NULL, '2026-06-04 09:49:56', '2026-06-04 09:49:56'),
(673, 1, 'XhE2OHBXIpz4RI4sJuwbwiDtji1rJ314ksJWmbYgrP7bRsPEKF3MVJ2TGV8cr44kjdyGYizz6Jz0fJLZ', '2026-06-04 09:50:56', NULL, '2026-06-04 09:50:56', '2026-06-04 09:50:56'),
(674, 1, 'F7Qd4npjAbX6q4CIGRJ2ZsYozSjnF16TTxXVsQrE7X7bSYoQqTR7E1CwsOHrYxZDrsHNLUj7Biom20J0', '2026-06-04 09:51:56', NULL, '2026-06-04 09:51:56', '2026-06-04 09:51:56'),
(675, 1, 'trqxae08nVcWDXIFb9AaXAJXXnoYtuRj0krTyzlCpH6GmTisiakDywEI5l6vXn8v7lCjK5YPhj297EfB', '2026-06-04 09:52:56', NULL, '2026-06-04 09:52:56', '2026-06-04 09:52:56'),
(676, 1, 'MHHeZf0948HBVgyhw3bx8Ftni7gww0zKVqeE8hTOQh2RKCpLPIDt3LZRSDOn5vaNV0C1e4iRunekBCfg', '2026-06-04 09:53:56', NULL, '2026-06-04 09:53:56', '2026-06-04 09:53:56'),
(677, 1, 'NOKnSIowRWCLvTbZJMsDGqkEjvLjhmaLbEdO0m4RpqvU67s5cRRhtBzuUmTxaTaO0yRcsTVjpqbCPsxG', '2026-06-04 09:54:56', NULL, '2026-06-04 09:54:56', '2026-06-04 09:54:56'),
(678, 1, '7HMf1WpF0ShQhmhUyxoMlnFezF0XY38kEYBTb3JgdAIkr9Trq06AQQ5Q5TZcL3O5HMdQQBv00BqTnnrZ', '2026-06-04 09:55:56', NULL, '2026-06-04 09:55:56', '2026-06-04 09:55:56'),
(679, 1, 'uIYHUehsYjefLn0nUN14Mt8lG7BBSD4383qocizThhv0LCQcMu64m2OFGu3huXyRTQ0iIniRMnxGd6qU', '2026-06-04 09:56:56', NULL, '2026-06-04 09:56:56', '2026-06-04 09:56:56'),
(680, 1, '32b8Ged6tHCOuvjo4LCGWQdCpG9MDhuc26ybZyNMhjQu54Cvp04TXGvm2GZWF4itGXdg1O2WlVwbzm2D', '2026-06-04 09:57:56', NULL, '2026-06-04 09:57:56', '2026-06-04 09:57:56'),
(681, 1, 'J2bn8J3taCWyWQNvvDNfafQBKgsSfh7KknWTcbVQiiihhuekLrG9QE9y28WoQUPmso67sdrlRX0q0OXX', '2026-06-04 09:58:56', NULL, '2026-06-04 09:58:56', '2026-06-04 09:58:56'),
(682, 1, 'zlghr8UlhHfjkyY8NoM1ynvkDHrtXcrHe1MR6EJLtozlS0rA6YqWD5XOehU5BmEWUBYqgx8IiTR1kSsw', '2026-06-04 09:59:56', NULL, '2026-06-04 09:59:56', '2026-06-04 09:59:56'),
(683, 1, 'D0ORga4nIYWNoDU98zev6GaaVCkDLotOnf89YIFmUiIWlUJbvky82AnyESCH1AndhZQOZccO2wi9aIN3', '2026-06-04 10:00:56', NULL, '2026-06-04 10:00:56', '2026-06-04 10:00:56'),
(684, 1, 'oEtVUNDKTxDcUen4ZQQxrwQQRsWVa5vesFQ2AmPTbB1frDfODfBmUxNFQxMsxhWaaug1QRf5MOQBVTF9', '2026-06-04 10:01:56', NULL, '2026-06-04 10:01:56', '2026-06-04 10:01:56'),
(685, 1, 'B6w1lbuayrBtpbV4Z7mowzrVA6AyAi180UvfNgewHB52uu0111fbpoSKMGKEDBIOAsSw1VgbedUQ8G1a', '2026-06-04 10:02:56', NULL, '2026-06-04 10:02:56', '2026-06-04 10:02:56'),
(686, 1, 'Sa6NJJWBSyq7iVk79aZ1OwB7OWyi0Pw5f9ltgrml1YlMjWvjuvHkKGU12TZC7fQIV2ZXipgAgyb0zpBX', '2026-06-04 10:03:56', NULL, '2026-06-04 10:03:56', '2026-06-04 10:03:56'),
(687, 1, 'TuVdTFAmm0hTv0c2KfjYr53KZhnXMpzlgX5blX5v66ZEOXnlnV1GG2TEkawpkm3d5y50CWRxoTZl9JXs', '2026-06-04 10:04:56', NULL, '2026-06-04 10:04:56', '2026-06-04 10:04:56'),
(688, 1, 'CiAORqb8qxjJrrF5Sb9ahWlmcQbIChAp9wcrvgq19VauBUUYtXtm78mx5sQcBSWcKyz4Old5jHCr44Ra', '2026-06-04 10:05:56', NULL, '2026-06-04 10:05:56', '2026-06-04 10:05:56'),
(689, 1, 'AsMijlYuX23t0Gkfs1NTQflwUsv7gL2c01h4AzsRTGmzwXZ8Hqf3iarvCWiWNEDLAj9IrEBT1KcKy4cc', '2026-06-04 10:06:56', NULL, '2026-06-04 10:06:56', '2026-06-04 10:06:56'),
(690, 1, 'asHk12IRmxAiqvsQojEdzkq4cTDog1eP36cfgy1hjI238fOmfDSRlHQYCD6cFfRoWW5pMWvHyNiThlEg', '2026-06-04 10:07:56', NULL, '2026-06-04 10:07:56', '2026-06-04 10:07:56'),
(691, 1, 'cMr8feVRz6449m3vXO04Ht8OVuLeeALrynEGnIbc3Ji1whXF5gCy7T2hnUQU4Ct2co9vOlBSICvVXftk', '2026-06-04 10:08:56', NULL, '2026-06-04 10:08:56', '2026-06-04 10:08:56'),
(692, 1, 'YMmmgnkn361qYH68kDtYrAzg2GeCa0MLjURkzRnz6KnKo0h3Q0Aq7TTqMtg69JbsVZ63E1U1OENAdmge', '2026-06-04 10:09:56', NULL, '2026-06-04 10:09:56', '2026-06-04 10:09:56'),
(693, 1, 'qHcmJPkdJ47Qp2hPw2UZ99G3YkJf7qditDq7ghFqzSJlJHldicbVHlWRmttuBqfxUIVRhMQmpaa93f5X', '2026-06-04 10:10:56', NULL, '2026-06-04 10:10:56', '2026-06-04 10:10:56'),
(694, 1, 'VszYXDF5fQRkaVR57Lu55Xc80TCZUNvf4dvANeRsxYLXVolhe2ptFIoPEpFIZEIg74Vfn1mSrvfzt9uK', '2026-06-04 10:11:56', NULL, '2026-06-04 10:11:56', '2026-06-04 10:11:56'),
(695, 1, 'DfYPw5qQun1hg3LVa6pMZnZ5b4xGvMNrT2xqEBlT3hDJc741nFrPG7reWxHIRfas9wYEgK9SPe7Z5ygd', '2026-06-04 10:12:56', NULL, '2026-06-04 10:12:56', '2026-06-04 10:12:56'),
(696, 1, 'tLOqwPSdCjHKkqLSXPLtI1PScAVhGlXTd2Nh1tRKej9is06PkaW7x5IRFnYVPNYkydesS9Lv5uhqhYMM', '2026-06-04 10:13:56', NULL, '2026-06-04 10:13:56', '2026-06-04 10:13:56'),
(697, 1, 'gxjwQDfui4xLoFaKUxZ8PTf6ySROOXoCwFzTwKFCVFaq7f3lAmxO00Bw83RqmZ54cgwLVIE6uxhVjbLX', '2026-06-04 10:14:56', NULL, '2026-06-04 10:14:56', '2026-06-04 10:14:56'),
(698, 1, '6gCKYOkwtdTHj5ezwNkM8v2eJGIHwQR3LgqDWn76PyR5bBiGq9Gncs9Y9BMxVzv62CTkLUODOfPJQ9zp', '2026-06-04 10:15:56', NULL, '2026-06-04 10:15:56', '2026-06-04 10:15:56'),
(699, 1, 'dyOG3uKRlmtyP7Z9EniuzYPtycCII6BbqeeNBX3octfnqpcpgvd8nUHx5ojkFvLPa1z0VVJ2w0zxkm2e', '2026-06-04 10:16:56', NULL, '2026-06-04 10:16:56', '2026-06-04 10:16:56'),
(700, 1, 'WEABiSTc94rfveo28vT68q1tHiAuf2ZWFa5gu7O0XTJkVtUJUb8qL6hvVsWHEO7ALvUy8tMM9NLvkuc8', '2026-06-04 10:17:56', NULL, '2026-06-04 10:17:56', '2026-06-04 10:17:56'),
(701, 1, 'QTWICsYqSROc2u1UxeJLJrZPpceTyrB6g75BpVFtn2esl8LPeyWzmZWCSQvYEZl42VfkxBebQaeFlWno', '2026-06-04 10:18:56', NULL, '2026-06-04 10:18:56', '2026-06-04 10:18:56'),
(702, 1, 'sEMo39TcWgbdXXrsbNkAUA0nTwXe2VLvb012JGklOjSpP3QX5lD4T1UGl9UrA4zZFGEJSKFRXwMlKIxC', '2026-06-04 10:19:56', NULL, '2026-06-04 10:19:56', '2026-06-04 10:19:56'),
(703, 1, 'fCTo8zlk6RKDdR5m8MOQ0pVDrSm6JGXaX1dW1ViqWINZRgEUnQ9NYKkfXwgI88ltYn6JcqmVY251rimn', '2026-06-04 10:20:56', NULL, '2026-06-04 10:20:56', '2026-06-04 10:20:56'),
(704, 1, 'cRJsrzyaKRyphlkqTGK3OOdqs4FwGPf4tJeVAOMYFQMWtnYJxnD0a9rIgMlvctJRhqcsBUeNkZXSFzwR', '2026-06-04 10:21:56', NULL, '2026-06-04 10:21:56', '2026-06-04 10:21:56'),
(705, 1, 'hs23nYuaigsBz9BSBFh272yzEBca1NQd4A1zVFdBH7YxuKyIBLNS4hrFeoNHNiqIa3sWSRMvZdxnbNq1', '2026-06-04 10:22:56', NULL, '2026-06-04 10:22:56', '2026-06-04 10:22:56'),
(706, 1, 'WPJFBAbs2Kk1MuPjwCeKWvkbi2ENbWeyiZV6R0ZeBACbGHWAg940i5XQ7d47GPSjgOigTv7xFKlSb5io', '2026-06-04 10:23:56', NULL, '2026-06-04 10:23:56', '2026-06-04 10:23:56'),
(707, 1, 'gDVl6IqIXqG5mf9JumBP76ZBcvm5pO8DbFGkARtwhPOwywmbuzjIC4WiqqGjy5kvv4FpD6puvwleERQB', '2026-06-04 10:24:56', NULL, '2026-06-04 10:24:56', '2026-06-04 10:24:56'),
(708, 1, 'Q115AGz8VcQVxjXj83X23GmyybCZ5I2hPjc8f1gQkcyVuO8B7GS1bjj1phisATLryJJa1xcFka0xtQkK', '2026-06-04 10:25:56', NULL, '2026-06-04 10:25:56', '2026-06-04 10:25:56'),
(709, 1, 'vrAuPp78yWv3NoBTwCPdcwSiE3KqOU2vGMfAVFYF99nxl6VLR4dgIBpWGscrt9LvbGLDZTOO4z7hLjdC', '2026-06-04 10:26:56', NULL, '2026-06-04 10:26:56', '2026-06-04 10:26:56'),
(710, 1, 'tlAwdOXDKXsjimCQQntRfnKw47rHkFFpBobxPnqlPDBWyB4Q47Cb8jPaKRCSzJwPYzsSqTJMulAUztFO', '2026-06-04 10:27:56', NULL, '2026-06-04 10:27:56', '2026-06-04 10:27:56'),
(711, 1, 'vPaXmQXQ3lTsEkH2KohCfnb61GGOhhes3fePYC9sWDzDeb1Khu6uofR74VjxLG26uIfImu6EwduFef9v', '2026-06-04 10:28:56', NULL, '2026-06-04 10:28:56', '2026-06-04 10:28:56'),
(712, 1, 'dNpuKgoYa8vMdFRd7qIeaQHlaewlJsM9iFLIvp2qR2tbYVwSJhxswuxs62sZ8qe9OFIgHX3ukkgNTAxg', '2026-06-04 10:29:56', NULL, '2026-06-04 10:29:56', '2026-06-04 10:29:56'),
(713, 1, 'vnZZWnVS0rxq6j3SmsnL5wS0i2avxvA8VJ8nIOn22z9FhaM9StDFwoVTSdaVs77NVFrzVDzuRjU2kmO2', '2026-06-04 10:30:56', NULL, '2026-06-04 10:30:56', '2026-06-04 10:30:56'),
(714, 1, '8LcJZL4uw0wtphj7BJRGNwbp9TCq7MiGAqomhEMH5SwqW15gJPhRHmOdoeM8CMgJJLZCw0HZA5i324Tt', '2026-06-04 10:31:56', NULL, '2026-06-04 10:31:56', '2026-06-04 10:31:56'),
(715, 1, 'azv5NXzMrbhGNdqqeNMtDN5XFodeqYXudlKz2CSL2pfWsaADmjHajU7bY9FNZN5JMUYLXz7xFxFV3PfH', '2026-06-04 10:32:56', NULL, '2026-06-04 10:32:56', '2026-06-04 10:32:56'),
(716, 1, 'f0DRbZ86UUMkkQmLhCi0B6sCg67XbjxOjQ0LrWLWxI5t9itqE2zPivQneHSQejQEOVVWJ9p70IGtrdIJ', '2026-06-04 10:33:56', NULL, '2026-06-04 10:33:56', '2026-06-04 10:33:56'),
(717, 1, 'XvgKLTDizLGmDRuDfbiu4XLaXyrYH6kFgi1iwXviu76cDIlQ8K5fjaFM6kUp57dqZniX3pSynB9GuMbb', '2026-06-04 10:34:56', NULL, '2026-06-04 10:34:56', '2026-06-04 10:34:56'),
(718, 1, 'fr7ARsDP7gHhvAftN8PxkLvF9mTSfrdDPgWUkZbHjDEbMwcVZRqDOaXvZo2rUbRi11EiA75Jql8KTKJL', '2026-06-04 10:35:56', NULL, '2026-06-04 10:35:56', '2026-06-04 10:35:56'),
(719, 1, 'YbPOgAh4jRuuX2GhPqx1OBpLkNb3iPbaBjzZt5Rt1GjZeCE7zz6aLG90Y1lGxnC4aiBZ8BOZeLIHdoF1', '2026-06-04 10:36:56', NULL, '2026-06-04 10:36:56', '2026-06-04 10:36:56'),
(720, 1, 'HLGfvy21QuLCXQ9HDtiRfQtLsgfWnQicLw5CXquX55IX5frS6ashS0XVa6ciUrwPwlmQrHPv4FaZ5TJ0', '2026-06-04 10:37:56', NULL, '2026-06-04 10:37:56', '2026-06-04 10:37:56'),
(721, 1, 'k2FCJzdn1VIHVQtkAZc6OWKaVEYQXV8NjbL1RbqBcOQI9We3XvQ65sKe9uzdl8L2xNm166jOuO6a5LKY', '2026-06-04 10:38:56', NULL, '2026-06-04 10:38:56', '2026-06-04 10:38:56'),
(722, 1, 'yvBcoP1zMfetNJTkj89NUqDDKNvfhXhTWhf8crvpYhogC0rtFNuEYr8tqlq3T7Hcixu9IUt1YrPL6yaN', '2026-06-04 10:39:41', NULL, '2026-06-04 10:39:41', '2026-06-04 10:39:41'),
(723, 1, '9nCJFCY8nRY5YwTLovZ04vvW3X8XOhkKVemYUREqZ0xUc19WXTwfKuRgOS3FKMDhYogtgzA5DQvJx2Qy', '2026-06-04 10:39:56', NULL, '2026-06-04 10:39:56', '2026-06-04 10:39:56'),
(724, 1, 'u2KoIPPC2qlI7hx2XDqRDRsM5caS7TVcx9rXfYuElEvAguk8VKBCuokhSoZ6pnD3A8uK1SQPowKRJVM3', '2026-06-04 10:40:56', NULL, '2026-06-04 10:40:56', '2026-06-04 10:40:56'),
(725, 1, 'Q4AXqZU6JjFf8ovDzufsQBMs8rE4apvbsPsnH6s9lr5QYOCF1YKRcQgHzMBkPfoAqZpQVcYhNrj9MJ2w', '2026-06-04 10:41:58', NULL, '2026-06-04 10:41:58', '2026-06-04 10:41:58'),
(726, 1, 'I0wtvUAvgWcQ5krltnN5LfkqsoeucOki5ubAc8Ck05e66HvlhrxPWEuWACY2fqQKtoPlKvliFjw3cTYr', '2026-06-04 10:42:56', NULL, '2026-06-04 10:42:56', '2026-06-04 10:42:56'),
(727, 1, 'Hnq2pThNu9oOL8q5xc3jkLzy9Xs7D9eFyurJQFwn6Dg88L2E8sDwoeOTjnreBlpZc8ND5jQnlWYv0oAH', '2026-06-04 10:43:56', NULL, '2026-06-04 10:43:56', '2026-06-04 10:43:56'),
(728, 1, 'wCnZned0v0avdZDq5Sbm6ldP6z4Bq4eab89s8G0TQiePWUaj9yPZSubah4KxnkAoqVUzSIiYVDeSXNXn', '2026-06-04 10:44:56', NULL, '2026-06-04 10:44:56', '2026-06-04 10:44:56'),
(729, 1, 'yJy6cZ3qQN3CcdpQ6E3nWucmPWeIMvH2BWvf0IXqLp7hlZZ8nICAOkCXONbufsCQjpcR17zOQL0HTAF7', '2026-06-04 10:45:56', NULL, '2026-06-04 10:45:56', '2026-06-04 10:45:56'),
(730, 1, '9eCiTo5iQpmchvwwFbsOeAREWshlPU5udJaQRaIxxj9YvahLCQOYJOFZl3zfWZiySSDMUAEJopJAPsIm', '2026-06-04 10:46:56', NULL, '2026-06-04 10:46:56', '2026-06-04 10:46:56'),
(731, 1, 'AEDJr4aiVWRNZpfvrpnpSkITIMIMidXW05D1eX6VDyFKO0y1vNPefKiPKs7XeEaoQzeeTtxNWqWIUv8H', '2026-06-04 10:47:56', NULL, '2026-06-04 10:47:56', '2026-06-04 10:47:56'),
(732, 1, 'Hmwkq3VwkU2omgcKJZnUAxZvvyf86vKB51UMSKpc98R0XMucAvvllmMZ8UkXxLsSwGfDqTzlxIiUUg0f', '2026-06-04 10:48:56', NULL, '2026-06-04 10:48:56', '2026-06-04 10:48:56'),
(733, 1, 'JMbjddXfZH0fmWAWPJ8quTk58ymexJIg49caGmBYXC0RCJzBxyexbwJmggtSQ32aJ40FYornUwpMH6Wx', '2026-06-04 10:49:56', NULL, '2026-06-04 10:49:56', '2026-06-04 10:49:56'),
(734, 1, 'hcXrYJCUnYrdylcXc8n73yVaUBz8MZC7RcDwREl3GGy4VYlFtoEKbASMmsxK4pEM2vZ3oXtnasfkI2e6', '2026-06-04 10:50:56', NULL, '2026-06-04 10:50:56', '2026-06-04 10:50:56'),
(735, 1, 'kjTqbJUP6qG088iCmntCOCy542lWfLZBS4ghXoTfPsAAigFdLUhaejRxIYtnrWT8aZgKARKbZDdQHZqQ', '2026-06-04 10:51:56', NULL, '2026-06-04 10:51:56', '2026-06-04 10:51:56'),
(736, 1, 'OBJisENdzhHQx174Cdud9D1hS81UyKNfTm2eFEaMxxySEkPwZLwt33YMo6LyR1X2R3whsp1KxqTs32Gg', '2026-06-04 10:52:56', NULL, '2026-06-04 10:52:56', '2026-06-04 10:52:56'),
(737, 1, 'xVeFL1Ukr9FXelGBCaPHeuf3tvvztHBCTzL0DOFRFvxy8iQ7S9nbU6IRqLTLO0jOr5Hgwji1uejJiIcE', '2026-06-04 10:53:56', NULL, '2026-06-04 10:53:56', '2026-06-04 10:53:56'),
(738, 1, 'wWcDRz8M38RTFWwW5IBaraWEWB4a7H2XaUbQm9zt1dN6kzSkc6bKNXjPZ7xoZIV29TbrNxBEiUA5t3Dr', '2026-06-04 10:54:34', NULL, '2026-06-04 10:54:34', '2026-06-04 10:54:34'),
(739, 1, 'chvrt54hv3ObIm7a84NqxdKMla54bsxKHRnggTIAX5YXyHKtMUw31t67ehbCczRcGz7OVo8oclz96sIM', '2026-06-04 10:54:56', NULL, '2026-06-04 10:54:56', '2026-06-04 10:54:56'),
(740, 1, 'oJ1rNDViYnBnuF0RByjjD8IRYwxa88017OQk8WmQZ3MlykcM06DZhAOYTsuLFtZBBIBYjjIkYy9ZnzhH', '2026-06-04 10:55:56', NULL, '2026-06-04 10:55:56', '2026-06-04 10:55:56'),
(741, 1, 'qhMFDTkqBcRo0dB4I3emJUbJq3LHnnIGecNa8Z4w7zMqLDUJOyIs23F7xXxf21hO80EGK3AIYSQ8KI1q', '2026-06-04 10:56:56', NULL, '2026-06-04 10:56:56', '2026-06-04 10:56:56'),
(742, 1, 'NgIgP6e6mI0mz1kmT793VAfZeA1BgMZ4tagpRbrPxrYBPU4artNvNgW0kOtxOXb1a2UklTa0Zn6aIezT', '2026-06-04 10:57:56', NULL, '2026-06-04 10:57:56', '2026-06-04 10:57:56'),
(743, 1, 'JvBuq31RkwT9nM7QF2ZakaNAXFDTyykwJeMZ4qyaQevTdX0mgcoVWTqDsAOF5D4QPYrNFgQvV583AXGz', '2026-06-04 10:58:56', NULL, '2026-06-04 10:58:56', '2026-06-04 10:58:56'),
(744, 1, 'v39ImJsOcFCFbYH4EcFe7BO4rWpLRAG3ncdYuSRf8pl38nHcJ0NU3cU9O8KyUPux6HLfvtgDGvRr6xut', '2026-06-04 10:59:56', NULL, '2026-06-04 10:59:56', '2026-06-04 10:59:56'),
(745, 1, 'cIgqxKm39EKNVXX4rBDm20ksM4rR6dNb9eNF1rPuIaQozv33T5rGANDIfKW7MRdXYrxqvFQ1qGC8VCY3', '2026-06-04 11:00:56', NULL, '2026-06-04 11:00:56', '2026-06-04 11:00:56'),
(746, 1, 'h72Pyiqr6GcdiRKjcU7JCtMhQML7qPfObXGaGE8xK4UakamK5lrLy33yKwtk1fH6M1xfh9Jp7SY9LUT3', '2026-06-04 11:01:56', NULL, '2026-06-04 11:01:56', '2026-06-04 11:01:56'),
(747, 1, 'tb0AuVA3griwoTspoiePTi2U3l52qsycKl7zinKne17iqfaNz4o0cQkygqz9PXYC7S0vJ2KwifDfm0wW', '2026-06-04 11:02:56', NULL, '2026-06-04 11:02:56', '2026-06-04 11:02:56'),
(748, 1, 'oKx1By7zwaETUVKEkAPxrvzNdQshlIZ6HAsJMmZeRX1onIdAZxu40Up0hmHOeFlNoDM7DJ4ECaRGKeb5', '2026-06-04 11:03:56', NULL, '2026-06-04 11:03:56', '2026-06-04 11:03:56'),
(749, 1, 'WDbWtjJZcU3qNRwLiMpf1YGLxlQTweBRANZVIXq6eBztLjCajkgYjiPuXr5MeVzpf9WdUsLTeKV9Becg', '2026-06-04 11:04:56', NULL, '2026-06-04 11:04:56', '2026-06-04 11:04:56'),
(750, 1, 'qdK8dvJvAiOoncgPYcpipD8SmKkBEk3F4u58cQ3yAe1gTUhFGIz9XeR8Xu7dB19Goh5b8erf6u6mRrMd', '2026-06-04 11:05:56', NULL, '2026-06-04 11:05:56', '2026-06-04 11:05:56'),
(751, 1, 'ohTKlzmMNpRHEZtBvFSn53k585uKkkTJT5iB3rp4lciOJM75s3y45tRKRnyjmqZOyJomUA5Yh8B0OUj1', '2026-06-04 11:06:56', NULL, '2026-06-04 11:06:56', '2026-06-04 11:06:56'),
(752, 1, 'iu8NHp8Al3Ujn0hWK0qgEV6WeYoMbZe4pt1xanaMrmrpR79NR25LtwKIDgx67XfBUA1slOTuRA8ZvISY', '2026-06-04 11:07:51', NULL, '2026-06-04 11:07:51', '2026-06-04 11:07:51'),
(753, 1, '55BGnHloyN3m4YRnielnMPzckhjPToV42FPRnUFoQFfmEruOHTOJR2PKbGfVe6ikcXGGzh5xzHEVoSVv', '2026-06-04 11:07:56', NULL, '2026-06-04 11:07:56', '2026-06-04 11:07:56'),
(754, 1, 'lhDLr48nkLHeGJE3pvhS19bxPsryNhPETnx3o8o0GFAXKQOLQKtamPSnLhtxaXDUwFPDBZW7SgKqrmXO', '2026-06-04 11:08:56', NULL, '2026-06-04 11:08:56', '2026-06-04 11:08:56'),
(755, 1, 'Ej5p8Y1DTLZ1LjTSUurvOERRR4THi1OwZHdgZLvHG89kwmIpKyhl2UDILqzKZRZwPpRUoE1cNFdo1QiP', '2026-06-04 11:09:56', NULL, '2026-06-04 11:09:56', '2026-06-04 11:09:56'),
(756, 1, 'JF83VSIDdPGG88Zral0g7dliTqM52DXCoPKslxYmE0xOhJHjBFyvbyZcw7aPOyCPTsRDEEOWUfczgeJh', '2026-06-04 11:10:56', NULL, '2026-06-04 11:10:56', '2026-06-04 11:10:56'),
(757, 1, 'p1p2sHKnOmckwe7HFjitNDnm9foPU4tiM8g8Da7IJo466O9jokagC7Ymhe8VT0U2VCgISPYzaxz54sq0', '2026-06-04 11:11:56', NULL, '2026-06-04 11:11:56', '2026-06-04 11:11:56'),
(758, 1, 'UwVaxzXCKOHc7L6tPed6YPy9XcFDOtm1aMTVzxzM8l2piR73YD4DfNtsWke1vQ46UOfqSkygBcwuCu4d', '2026-06-04 11:12:56', NULL, '2026-06-04 11:12:56', '2026-06-04 11:12:56'),
(759, 1, 'zz2j4BdxbdX2xIjvri36oarwtn9GgmNwu2zyv2gEDmVm0lDLjOwvk1TbvA9EtkDIpvvDSx0p5uCwfcuc', '2026-06-04 11:13:56', NULL, '2026-06-04 11:13:56', '2026-06-04 11:13:56'),
(760, 1, 'imhjx7i7TDyRZfaj0k331aakKPVZEIPeUWJkYU3UqzNp7dNkaO7kjLHdkrQfujRXPDhv2SGeZZxdQMUl', '2026-06-04 11:14:56', NULL, '2026-06-04 11:14:56', '2026-06-04 11:14:56'),
(761, 1, 'eU45l13FzpnsS7CpNcZu641lXyQIo5HgjtTBsG7ePeKcxwYIQpbgfGtPvYwZcBECJvZ5SIuOiP4RvuVl', '2026-06-04 11:15:56', NULL, '2026-06-04 11:15:56', '2026-06-04 11:15:56'),
(762, 1, 'RiTQQqARHLj1UiIX8Gn339eKc8gvhUi5rYn8aVrXC3hpkgLCrwyDswNkhWwhWQLbo9tKoUhbTm1LLHtc', '2026-06-04 11:16:56', NULL, '2026-06-04 11:16:56', '2026-06-04 11:16:56'),
(763, 1, 'PU8YcJnkeLAQYuV5km15xIecZCM3IYq83nx4ABgmankNbaRY6eFjTb7alX57u3L4GU3pg6s6AJygQ2ah', '2026-06-04 11:17:56', NULL, '2026-06-04 11:17:56', '2026-06-04 11:17:56'),
(764, 1, 'q2G5IMlVTnL9bxRcMoFYEcdm5X6UQUP1yTvZ4MHNbkbUgNOx9e9tAADIYioOnFiw8PkwCWCreBQoHAwf', '2026-06-04 11:18:56', NULL, '2026-06-04 11:18:56', '2026-06-04 11:18:56'),
(765, 1, 'LE8LCcFdcrixgOXcIa2IifswzGLDur22LmXCzKj4cOkKWLDjXV3lR2MgncuW2jJKtfoCgOqAH2jataea', '2026-06-04 11:19:56', NULL, '2026-06-04 11:19:56', '2026-06-04 11:19:56'),
(766, 1, 'w7K3WRjH5ZovcgU8K7nVeKwV8zA5MM6dkfKjmmQ6UI673uvmolCV3kTogSPvhHdHGO6oul8zfQz7d3rE', '2026-06-04 11:20:56', NULL, '2026-06-04 11:20:56', '2026-06-04 11:20:56'),
(767, 1, 'dVeJxdZNapEjydRr7pwS4R3bGJbDDWjMMREc3MvDt9x4A4K2vgsH8wXl4GC30axzWPRaXIwj44s4dNd5', '2026-06-04 11:21:56', NULL, '2026-06-04 11:21:56', '2026-06-04 11:21:56'),
(768, 1, '6MJjGxhulNDvL5vvjOaoWqaBjtn1nR63ChHGUn6Vy89eqoEAEXE9kOUx4JQrmQFdy78RTgZyr8ivaasz', '2026-06-04 11:22:56', NULL, '2026-06-04 11:22:56', '2026-06-04 11:22:56'),
(769, 1, '3MtiBoO6GJO1xBbNc2ZjmI5TqeJfjqqm4X4IfntWpS0Mf540TbQsEn9RBcU8sSTEE8hIpqoIuqMqGr5D', '2026-06-04 11:23:56', NULL, '2026-06-04 11:23:56', '2026-06-04 11:23:56'),
(770, 1, 'SZWEObawRBeQ9aU41XQ6goLyiBYNkJJ4xIeE5yIEJc7hYKXyvtWrrUhksIUvA4aoxy19XtXMCvtwFabr', '2026-06-04 11:24:56', NULL, '2026-06-04 11:24:56', '2026-06-04 11:24:56'),
(771, 1, '2HYt9cfm2fx4I6S7uebzsN5P4s6LgB7LpjGHxBA4mZWd3b0kxBSYTSDs7qgclUwYCEEST8icwQxajS3o', '2026-06-04 11:25:56', NULL, '2026-06-04 11:25:56', '2026-06-04 11:25:56'),
(772, 1, '0kmftAqfmUphAeYFQdpdDCiK1XhXesaRBOcvKQ3TGGn3xPgwVBLUqsiENnvPHktam7r8PIRdojUeVyu4', '2026-06-04 11:26:56', NULL, '2026-06-04 11:26:56', '2026-06-04 11:26:56'),
(773, 1, 'hoE6DO9YGjtMJpb4NJ4mqtFGtbQCZnoulyXGNtEPGiGwCpY4oBjX3xL0OxOyb6dvtBWqys3LWnsLsdS0', '2026-06-04 11:27:56', NULL, '2026-06-04 11:27:56', '2026-06-04 11:27:56'),
(774, 1, 'ZJH1LmJkJktfGa9xJ0Sxr9vFLr0ociqHVy2w3EHOYfexw62MSMpRfeLtLhIjdVwDSvavw3BRhUnlJ337', '2026-06-04 11:28:56', NULL, '2026-06-04 11:28:56', '2026-06-04 11:28:56'),
(775, 1, 'JKiPE7zrvtmyMWJowfpwmwSLx8bqGuu16zLBrx6alu5d1F9oSuvg1i9EbHdM3QL3hlvQHU9VJ2JvVmIH', '2026-06-04 11:29:56', NULL, '2026-06-04 11:29:56', '2026-06-04 11:29:56'),
(776, 1, 'pMGt7r8xyXnZKMgYaUqq8kw9eDxglvmHF7grTQSIMI2BFDlO0k5rJbhhvo88Z09jdTwbPe5UtIz7IgZN', '2026-06-04 11:30:56', NULL, '2026-06-04 11:30:56', '2026-06-04 11:30:56'),
(777, 1, 'UvTOzyF1nhwtWBzgQ1tAogv4i8SGBCLXqzUyMWRuMnYE5wBe4cLdPcr8YwVkDVd7KF5CVGGEtzL1s0TJ', '2026-06-04 11:31:56', NULL, '2026-06-04 11:31:56', '2026-06-04 11:31:56'),
(778, 1, 'vKJAMfcvaSTaySqJ9UjsC2T2Lg6f1FYq1yeb4hXwWEcA9V8S8E3XBwkWHxGRofddlrIHt5O9iS9CLdtP', '2026-06-04 11:32:56', NULL, '2026-06-04 11:32:56', '2026-06-04 11:32:56'),
(779, 1, 'U1XQG599BmwNLkEEiQ1EbVw95zgPfUrU9YqXmJlzOGl9wOAq2HSFtTJglUy9R3NwsUm07U5mdO9kxd3k', '2026-06-04 11:33:56', NULL, '2026-06-04 11:33:56', '2026-06-04 11:33:56'),
(780, 1, 'N9y5ibGex9bEhhwLZDkdzblyCPylpKaEkDdDLadSuhXGd2t5M38reOQQOtsapJ6KOvF4W76M1tLwPrUS', '2026-06-04 11:34:56', NULL, '2026-06-04 11:34:56', '2026-06-04 11:34:56'),
(781, 1, 'ESCRU42n8736lLNpPHcyI2t2DESODbyjGeMEGML5eFRw6AsahO0JZlGBpHY34pR2D0m5TXKlY6joGp2B', '2026-06-04 11:35:58', NULL, '2026-06-04 11:35:58', '2026-06-04 11:35:58'),
(782, 1, 'nyWUwtsnFVWzLziVvlvqcZA9LeaPk8Hgm4URqmMYVmgf9FbiedrRa0Bf1I603YKuKH6lPuclSPDyQKBk', '2026-06-04 11:36:56', NULL, '2026-06-04 11:36:56', '2026-06-04 11:36:56'),
(783, 1, 'OAss5jKULP3K2Rzp4dLtMpWJSCF4ibiKAfXNemdBxB0HSJVjNKdXpdgkz429gGnodL3uTPmhtpxZPB0k', '2026-06-04 11:37:56', NULL, '2026-06-04 11:37:56', '2026-06-04 11:37:56'),
(784, 1, 'npDacPd90iR02mTokIELKg1CDjGrtjORk8T774H3OYc4NzyrrXBE5669t9501w2lXjM0BTlIxubHJJqA', '2026-06-04 11:38:56', NULL, '2026-06-04 11:38:56', '2026-06-04 11:38:56'),
(785, 1, '5GEOhJAUPoVkj4QWrH7Kmqloy6pN6WkALK5c3SAqUAVq7uKQkVpPiE2N3Hu0uj4GF5BOnKFsk44TLTir', '2026-06-04 11:39:53', NULL, '2026-06-04 11:39:53', '2026-06-04 11:39:53'),
(786, 1, 's3xYDxiJK9QDZZ5svBhZ5JfJVNE5gXe8iSl3zaZ8QKDB0qGlq4iIFN32m3UgurlBe6lTWklW0sY4ldxH', '2026-06-04 11:39:56', NULL, '2026-06-04 11:39:56', '2026-06-04 11:39:56'),
(787, 1, 'K7OpNAKMjlEUOawSv7hlyDd43NZsqDa1fdPeJuQHkAHPO8VoHGjFJkEw3xVdrwIY3WkTOmUwJD9LbdSY', '2026-06-04 11:40:44', NULL, '2026-06-04 11:40:44', '2026-06-04 11:40:44'),
(788, 1, 'Kj2fRMccZ3H7swVQOlOsXYAjNZqF6OuvqFVBR3fsz9fs7aKCy6GdJAvABTdWlCWGV2QCuoxihKEVC9I2', '2026-06-04 11:40:56', NULL, '2026-06-04 11:40:56', '2026-06-04 11:40:56'),
(789, 1, 'GPYqc5hbsjXjId7zHuUMch56pEMviGxseI6h9e4XQdhYNlWyEzWi5MhYB613OEOGFO0xhunzWfDCqy7L', '2026-06-04 11:41:34', NULL, '2026-06-04 11:41:34', '2026-06-04 11:41:34'),
(790, 1, 'G3q0GK2tkUWS5lr6V84pAQB284XYVHHstViSYxpP6My8Nrd37nWkQXqVo14uJS5hdzkfODIDIjKw4kok', '2026-06-04 11:41:36', NULL, '2026-06-04 11:41:36', '2026-06-04 11:41:36'),
(791, 1, 'H4jstvZD7zkQgke1SyVEW6Xy9OmXkFaFyapEBeRewJYWDAwaoOzGy7QGbXc6guY9ooTbVw2mPv6GSSaB', '2026-06-04 11:41:56', NULL, '2026-06-04 11:41:56', '2026-06-04 11:41:56'),
(792, 1, 'CcX7r6k8Nyawtf0ygYc1xbQ1oibuQyjrQiiUl3HsXzVZBVaT9k1GDl5RJgAYPzpd29fXbhnMhIeH5K0U', '2026-06-04 11:42:56', NULL, '2026-06-04 11:42:56', '2026-06-04 11:42:56'),
(793, 1, 'IimltITpTR5kTJG4HyHp209AUr4ymtNhA9cre3l4IVUa4SAcigWfRCUGZOi4Hpd2gDhSgb5RZgaFgtqd', '2026-06-04 11:43:56', NULL, '2026-06-04 11:43:56', '2026-06-04 11:43:56'),
(794, 1, '3NPhUi7wyy0QZKKcyyxq12KPBIBRt6rjMQGfsm3RRK9yOYmdLCweSUqzm3tNrcdQMX37n62ld4xWM4FY', '2026-06-04 11:44:56', NULL, '2026-06-04 11:44:56', '2026-06-04 11:44:56'),
(795, 1, 'RUfgnKYc2qXMrlajdzbpg58wd2OG35l7cSnJxQSEqXSNWgfkJGsrBk7VhCdxfY6k0jfmBIKtIurO14bm', '2026-06-04 11:45:56', NULL, '2026-06-04 11:45:56', '2026-06-04 11:45:56'),
(796, 1, 'lk6x7o4yNw8h9vrG8bwLnpWkxnDW5D3ujyweyARdgSJBwOsEuNl1cJdnuZIiLofgmty27AY1JAy5ofPN', '2026-06-04 11:46:56', NULL, '2026-06-04 11:46:56', '2026-06-04 11:46:56'),
(797, 1, '6B82o5RaVjRKwN3veyQ1MWrbBq6ysGdG5hl5KWnpWIcZLautTosCnYBtn6Ewi6IDwx8JMspqahp7fvS9', '2026-06-04 11:47:56', NULL, '2026-06-04 11:47:56', '2026-06-04 11:47:56'),
(798, 1, 'LkKQ8EV9sj007Tw0KkCEmoVjZFTRqs5nqNeeSs3FiIDRX0ECfpJG3b8j9iSbmd8ymHRJ0bjkECoKBxjK', '2026-06-04 11:48:56', NULL, '2026-06-04 11:48:56', '2026-06-04 11:48:56'),
(799, 1, 'e0kLuyyebrF5hwznWJiIUnnQFwrvXZEcp3Aeua7DeD9gI8LUvNfuYJwWPvnuBCE6NnIvycw0vbQQUUHs', '2026-06-04 11:49:56', NULL, '2026-06-04 11:49:56', '2026-06-04 11:49:56'),
(800, 1, 'LUFWzD0wqaj2roFieDknRDGEZkoOGXLluv2KVY6YqgL8yFjGIKK2Dhurnsc5ePBVEH8wubUr0sC4ww2E', '2026-06-04 11:50:56', NULL, '2026-06-04 11:50:56', '2026-06-04 11:50:56'),
(801, 1, 'yNOKH7BKqCrY8sqCCPlehXM07cg5H2Z5Qo5OFPGJSQXOOqhhqNSbbgabkq7s2StZZj3vdga2Fwo2Fagf', '2026-06-04 11:51:56', NULL, '2026-06-04 11:51:56', '2026-06-04 11:51:56'),
(802, 1, 'eAxelUs68owtAjSs3gButCf3l62WFtd9hLFt9CjZxmX3tqyjUZd7B4lLGy9iRrBQEoAdzFCVnvYBHXzX', '2026-06-04 11:52:56', NULL, '2026-06-04 11:52:56', '2026-06-04 11:52:56'),
(803, 1, 'si5HVetw6iZiAE65JbPgATHBCPdaZejPDDFpEDtZFpl48wiFkEdi0EJER7RMfUcrHbaCjKxF5CjxW0Hu', '2026-06-04 11:53:56', NULL, '2026-06-04 11:53:56', '2026-06-04 11:53:56'),
(804, 1, 'fowIcWg2az3vUKNu84NFoqRP28ixAB0PFacBHsUQXqEJlgiWmjXOFIHyfktykjJCbgKrvcNOyp4cP6OM', '2026-06-04 11:54:56', NULL, '2026-06-04 11:54:56', '2026-06-04 11:54:56'),
(805, 1, 'RYc6XzA0GxJl9Ktn9iBmkSDZOdZnypuONs9X3VzzlDDZRkIJQ079B61LXLTPl5FxVcHBJ3ssgK5rhX0U', '2026-06-04 11:55:56', NULL, '2026-06-04 11:55:56', '2026-06-04 11:55:56'),
(806, 1, 'ExesStNgQrOK27u7rFFpARFzV9lcvx1yeQ3pGGeQQld4y9nnsQ246HJwwUV3x01UpTmv4BjfJHQhpzov', '2026-06-04 11:56:56', NULL, '2026-06-04 11:56:56', '2026-06-04 11:56:56'),
(807, 1, '4zU4v46p5L8IvlHmPS2LsP5lVsyxQMfPsZVwNw5lssVV86JwBkQiiJZXaxwVawc5hwnpF8OnVBXY6ckk', '2026-06-04 11:57:56', NULL, '2026-06-04 11:57:56', '2026-06-04 11:57:56'),
(808, 1, 'oavYEegy9EMbXu3wasNTqOCyUEWTNDebiNSdRjD9uLe6TmQjWWE6q1k9cg2y3GH7ntfY82aaSzEgbuD6', '2026-06-04 11:58:56', NULL, '2026-06-04 11:58:56', '2026-06-04 11:58:56'),
(809, 1, 'FPFReYBE8YkJBzXiwIRLGmbLDwdlS6eF4rI44gqaLXRdiImOzMa3y0smVdQdUWoNjmRgs0nbcNBzybOM', '2026-06-04 11:59:56', NULL, '2026-06-04 11:59:56', '2026-06-04 11:59:56'),
(810, 1, 'UYoDI0Siy5OL51vK9FmxL8qOO2TyaHRnZ1kFMpzHmjy2OvYIX4D94yjfM99h1SCwADtaDJRG5K8siWTW', '2026-06-04 12:00:40', NULL, '2026-06-04 12:00:40', '2026-06-04 12:00:40'),
(811, 1, 'vabzrYV7GhU2Maf0npzPCHgJuBsjw8y5pFaKOWauIklngmY1S4VlThRlCw7IkA7sCPPgRxCEe5h9nDH9', '2026-06-04 12:00:56', NULL, '2026-06-04 12:00:56', '2026-06-04 12:00:56'),
(812, 1, '3k6GxsMJ4K2tvArSitTan7EG4NTfsOWFigVeJjuw6orsFkdFSC7p5ZXOfZpb3BQ3Pv63jMnfRbuXjWTT', '2026-06-04 12:01:56', NULL, '2026-06-04 12:01:56', '2026-06-04 12:01:56'),
(813, 1, 'll0JfInfEHOEIU2QfhaWXNLeSub0YMwo1kgKpkytSg5trwbnfX41Fm9bmi7ysz40KjmMweT8hgbBmtke', '2026-06-04 12:02:56', NULL, '2026-06-04 12:02:56', '2026-06-04 12:02:56'),
(814, 1, 'clbjLDVRzbNdl7cReWX066fComvBUYTP4uOV2hQ5wUQcYb4qYVWu50IXhLJv6wLIaxnSA4haE6ONMws8', '2026-06-04 12:03:56', NULL, '2026-06-04 12:03:56', '2026-06-04 12:03:56'),
(815, 1, 'PtbweAJjuM3zQDlFHJTIEhBaAWxUFcTbfy0z4uzWrvdf2hIn2xkRJF4AYE1IdKzpSp5i1KPLESZM3jd4', '2026-06-04 12:04:56', NULL, '2026-06-04 12:04:56', '2026-06-04 12:04:56'),
(816, 1, 'pd9X4poxGynlUEPRTW7sPumiHXORdAoSr9tsqXpjAb52amUPOpJzNeEf5VsD5NIUi4rin3PkeeHRfwzu', '2026-06-04 12:05:56', NULL, '2026-06-04 12:05:56', '2026-06-04 12:05:56'),
(817, 1, 'BGjbHjyzorSbVgXbUVCC7usDrZDRiByoNSY9Nbn2PLy1wpfEjb3R29KmvuUmAFAfBhP3awbQHsrc9o9B', '2026-06-04 12:06:56', NULL, '2026-06-04 12:06:56', '2026-06-04 12:06:56'),
(818, 1, 'Vn47I2faskvds5U2sGFtzeRqlg4WuZ5M83F4PEhWjcPkSmbGSTLrcuzI6bNjiksc3C35bHkMUUNuH3FJ', '2026-06-04 12:07:56', NULL, '2026-06-04 12:07:56', '2026-06-04 12:07:56'),
(819, 1, '2f1hVdm67k6cqthK8jMcah6jsPxRjPplTVv0s0bYNsm5B1htxUSfG5RM9PKcyKXNhonhNud46y5nmP0c', '2026-06-04 12:08:56', NULL, '2026-06-04 12:08:56', '2026-06-04 12:08:56'),
(820, 1, 'c7Y6MiCj6eynQ1WRGJ88ZW2spyCzO53T0L89L0pZxGY31CoEhccG5ExtUUQ9vyCN35NAMcLPzerhb0NL', '2026-06-04 12:09:56', NULL, '2026-06-04 12:09:56', '2026-06-04 12:09:56'),
(821, 1, 'GEQZSekMRnR6L5VDXsUIihEgGxmyTAzMGbNBJXfvFbng5IIW1X1onfoBmex3zhuhlNtXpSVLYB324Rmz', '2026-06-04 12:10:56', NULL, '2026-06-04 12:10:56', '2026-06-04 12:10:56'),
(822, 1, 'y5byGM7W97BMgQUdv2ZtWiE3NPnpzKHww88SWc7l7bvmTHXCdC6KNIT4ZcU8iQya8rgnoSotBy2OyToE', '2026-06-04 12:11:56', NULL, '2026-06-04 12:11:56', '2026-06-04 12:11:56'),
(823, 1, 'QcUF7a9eBjuXs01O1XlXga2JMyj97H3bkx0hR4vGVVCet6xNy47uw2GRb2BLF1BouqI5ZnJd66irNhW8', '2026-06-04 12:12:56', NULL, '2026-06-04 12:12:56', '2026-06-04 12:12:56'),
(824, 1, 'rp4PYzQ6R1iNb2PjtuYG5hmOzYjoWy0zuooVbhXJ8HNIdlmZOj7TLGU53ZHxQpB5xgyIao72ZGE3JQm2', '2026-06-04 12:13:56', NULL, '2026-06-04 12:13:56', '2026-06-04 12:13:56'),
(825, 1, 'nq00KH2XvCLWNTwHKWjhIeOcos63M0iQVEtCzBaoXZXlR5mSHrWB23X8mcVnLGrzVSuOWGBtk25U5UdG', '2026-06-04 12:14:56', NULL, '2026-06-04 12:14:56', '2026-06-04 12:14:56'),
(826, 1, 'qHqkTtBT9rdDrQBX9a8mTscTKI1XYzcMOYPobK7sGMNZCcrpwZ3CXItj60upF3pgZ9QSsNyaWnc29gHu', '2026-06-04 12:15:56', NULL, '2026-06-04 12:15:56', '2026-06-04 12:15:56'),
(827, 1, 'bxTSiBisAzLHrj391fHyPPOUuWdkYHe5kNCct43DnrAjVE1yt7VNZIkP7kKpDUWNa0CpITU5xuSbLRye', '2026-06-04 12:16:56', NULL, '2026-06-04 12:16:56', '2026-06-04 12:16:56'),
(828, 1, 'cita2vBq5LsAUKyT8lluMvVO70axYgkj5Qh4Y4F9BSpbU52fhxPbpkAKdI4jN6ZZa0ZKbLIftH1Yj6Uv', '2026-06-04 12:17:56', NULL, '2026-06-04 12:17:56', '2026-06-04 12:17:56'),
(829, 1, 'GBLtTA9L4MngxBBdNddp5ggva7XKEXDgqxyIX2dxiNgTIO07ufLImJoNwzN7YiHfELwB8S234x3zGj6D', '2026-06-04 12:18:56', NULL, '2026-06-04 12:18:56', '2026-06-04 12:18:56'),
(830, 1, 'zK9teighPJd1Fi66a70frj1XlQkVXXlOIgUN1jIQEWyV2qhT0rntbbJoLob0Vba7xJN4yww6lw2KnS24', '2026-06-04 12:19:08', NULL, '2026-06-04 12:19:08', '2026-06-04 12:19:08'),
(831, 1, 'nrkEijZQbmV4LW1XAw1T3cjgx00DvuKpvFQHoNHNaelBWaZpm7dxikrrbCRKjI4gsh6tHC0UX1NtoOhP', '2026-06-04 12:19:56', NULL, '2026-06-04 12:19:56', '2026-06-04 12:19:56'),
(832, 1, 'f7gJf5J7I8zpizZlgfhzTTNnIEuocA2GbeL4KvM59Vj04cNMJ1GI9MU2IZC1KaMw7b1J1vDnQBfhSPHe', '2026-06-04 12:20:56', NULL, '2026-06-04 12:20:56', '2026-06-04 12:20:56'),
(833, 1, 'jfLVdz0FDmpkdUyptiRRsE7WMZ8QxiIaKJdOuonQ4ybFKBdAazc9qRD7GGMFIwDjHu7VEkMBSbqvk2Y3', '2026-06-04 12:21:16', NULL, '2026-06-04 12:21:16', '2026-06-04 12:21:16'),
(834, 1, 'J1ce2buhKNnSsWxGHeQZRBO7p7Za7bJEB73TCqI14DZRLEDhXxYxUnqXzIfX022sscp4hQJebWDuWVXN', '2026-06-04 12:21:56', NULL, '2026-06-04 12:21:56', '2026-06-04 12:21:56'),
(835, 1, 'iUg2sBIqf6OaUs7XWKJCBfpa8HtKukxhOCYdhIfJqbJbVWfUJtEmJcY6MBfCyNNKTSP9d28jB2Gh9Lrx', '2026-06-04 12:22:56', NULL, '2026-06-04 12:22:56', '2026-06-04 12:22:56'),
(836, 1, 'Zj4BinvUC0PW3eKKSfKAlCGpG6dKfRqBWsmY9zmstee6DUfbyuVMUkW3a6ofhItjD11Ook4GNvCQvr2Y', '2026-06-04 12:23:56', NULL, '2026-06-04 12:23:56', '2026-06-04 12:23:56'),
(837, 1, '20ghyPFt4TVdfWfhnopplpkXkHLn6rAzcrcFoZUfc9tUKPqQogRGhPmYLBrTiR1sQ14dEBdTOYGtNTBx', '2026-06-04 12:24:56', NULL, '2026-06-04 12:24:56', '2026-06-04 12:24:56'),
(838, 1, 'M5jfX4HwEpHJEMTWDwCuUzsLorXZ2tuNQXDpXKtkRcO7FW0W9NxeimiUykcRnSIP3gMaK5Hnc5GVDGuF', '2026-06-04 12:25:56', NULL, '2026-06-04 12:25:56', '2026-06-04 12:25:56'),
(839, 1, 'HMoJI0lYHiaMapqqLWal5HU2PAe0fl6hw5wmQ4AQbhX8A0m8ZQAUVIx8JGcaU80qPyApssRErrmRvKEq', '2026-06-04 12:26:56', NULL, '2026-06-04 12:26:56', '2026-06-04 12:26:56'),
(840, 1, 'MkAUEbs1IU8PBfzY0PWE3Msu7mEkTyWSKdFiI5aSRrN6mMHmtnkISZk0CigWDy4mq0YKNRCcQtlPNdXp', '2026-06-04 12:27:56', NULL, '2026-06-04 12:27:56', '2026-06-04 12:27:56'),
(841, 1, 'ii7DMRHtXxaY6raXyN3zYd5RMZaO2bqBslwBKUiI4u6ALkqBFPkVd2xv7KWX9S0TxAhqQNe8cuSQI05b', '2026-06-04 12:28:56', NULL, '2026-06-04 12:28:56', '2026-06-04 12:28:56'),
(842, 1, 'Z5zWXpb5HEudNlTIATRZeSGCBzVcy7cR3URU4PK3nyXsctTgyHBEDwGACIhWETBFlN1dG7Qfq5LWmFkc', '2026-06-04 12:29:46', NULL, '2026-06-04 12:29:46', '2026-06-04 12:29:46'),
(843, 1, 'yA9jPKJsPFYehbyEzTBdFscZAp3gQMwlqVCdsjJEGemqmSqSXXmzIlF60UDj7HiaFVoe2xvhTdZ0ahsl', '2026-06-04 12:29:56', NULL, '2026-06-04 12:29:56', '2026-06-04 12:29:56'),
(844, 1, 'd2uod6Y3CXDgP50dZBluKX4PpGlppoDJRbErL27OjaCURuFtkzfVkKcSALXgMFqeE4nfJhgT7EPJ7xCa', '2026-06-04 12:30:20', NULL, '2026-06-04 12:30:20', '2026-06-04 12:30:20'),
(845, 1, 'y9lTIbcCfmS9IN4TD9L8h5tJpasMRMDHLtzBiKRJTZccPNSp5MzwESbh98NREEAdI8PIUFq5QIOaI6pv', '2026-06-04 12:30:56', NULL, '2026-06-04 12:30:56', '2026-06-04 12:30:56'),
(846, 1, 'EoyZkcYsbmpg3jb4HGNEQkZp9RFZI2GtIs5ovRwk8GNEfd4QFeiUXc2Ef4WPLOs7Q0NbmgITojqiU1Nr', '2026-06-04 12:31:09', NULL, '2026-06-04 12:31:09', '2026-06-04 12:31:09'),
(847, 1, 'QebD0bonPapWay6gw5DbJjE6dViJDf8xKTTnzUZqi3ukkvLxKOkcKtyJDDmeGL8K3412ben1lq2rP2Qy', '2026-06-04 12:31:56', NULL, '2026-06-04 12:31:56', '2026-06-04 12:31:56'),
(848, 1, 't2PPS8WEaodURL5LYp52sPHBgMT2kayqfP3rP2SISkr2a7eJcFCV7dXIVNaN92EkImRD12w0E6oARHoh', '2026-06-04 12:32:56', NULL, '2026-06-04 12:32:56', '2026-06-04 12:32:56'),
(849, 1, 'uoaLTlbwmvKkTFxjrp3a0W2K4n5ljb2pZew1ARJUYKWbluEGV72dViF2e3VARAJ54a2NXcg1G1ePiJKY', '2026-06-04 12:33:56', NULL, '2026-06-04 12:33:56', '2026-06-04 12:33:56'),
(850, 1, 'tpLe5hCfvGTP1pTwNFD2JmYscuo4uACAOjCfxnkyZF4g1EgyWQg5xCXTgooJQ8GubNypJvzLLSiuwIaY', '2026-06-04 12:34:56', NULL, '2026-06-04 12:34:56', '2026-06-04 12:34:56'),
(851, 1, 'XOSUpy8VD1wmOavEsrIcQFIccmOpzRErxAzdKHEd9II8GjhlEs4kIXP3Hba5XhsmJR2hcYlVAEb9VZb0', '2026-06-04 12:35:56', NULL, '2026-06-04 12:35:56', '2026-06-04 12:35:56'),
(852, 1, 'LZ625DW1lYvEV7LaNzHkD37vDPlvgq2dFjY62BrLDRFRRzmwPb3rmjBAoJpr5sOiq6hUP1Wuyc2EsQem', '2026-06-04 12:36:56', NULL, '2026-06-04 12:36:56', '2026-06-04 12:36:56'),
(853, 1, 'iYZcpAn5Yem1OQ294zPMwd4EC84qjSeduqSlOpbh1gPXiRRVhdAWXTD3XsIjHdnPxNjmyrd60VIqs4Fr', '2026-06-04 12:37:56', NULL, '2026-06-04 12:37:56', '2026-06-04 12:37:56'),
(854, 1, 'tosyW3VQrH0qt0y3V6d3QUGfvk6z9MXNZeAovRylXaslre9qW0DPdH0eBDpi8hs8hpCzAfczGf429zQg', '2026-06-04 12:38:56', NULL, '2026-06-04 12:38:56', '2026-06-04 12:38:56'),
(855, 1, 'lm6WN2hl2SPvdob5NCVh0p0WG1oyxgwcCEieOQNmmhivOay3EY4ctYZqw6RE9fz3Di90LmyxzzcfHLXW', '2026-06-04 12:39:56', NULL, '2026-06-04 12:39:56', '2026-06-04 12:39:56'),
(856, 1, 'PRXR1zgdIUXOeZZDcHHt5d6wEmf1Vr4FAmpnx1KYflrkx6Pp7pC0yMUpC8TmKze4ZmHQlxF4vC6VMjq0', '2026-06-04 12:40:56', NULL, '2026-06-04 12:40:56', '2026-06-04 12:40:56'),
(857, 1, 'cVPnArq8gbgApfuzYbzNtzy5efz6IN5h9pwcLJ1GpZDyf6ZafMDmh1H4kXquRYD1kuNSgWfNigPohezU', '2026-06-04 12:41:56', NULL, '2026-06-04 12:41:56', '2026-06-04 12:41:56'),
(858, 1, 'rniCIJcSKmpU4TZGGbvtNwB9ru9cE9w3RubsoJITjU4BvLB0iLUO0MJUJv5aa5Iqj4WRotl4zlUrNL3q', '2026-06-04 12:42:56', NULL, '2026-06-04 12:42:56', '2026-06-04 12:42:56'),
(859, 1, 'O7MFVkUm2ZGuoEyjmIbMIHZtNtp8NEFdCZjHxHpaDgmh6T3wHiGj5Cb1HYHIqtgIVsBn4IROMhqslium', '2026-06-04 12:43:56', NULL, '2026-06-04 12:43:56', '2026-06-04 12:43:56'),
(860, 1, '2imR9xd15mMX3C9FJsrbyH6x78qmJl0yZi3gwWMTWcVycXlTv0yyzDVqbpPucgz0Td8jjRMFyb6umqgP', '2026-06-04 12:44:56', NULL, '2026-06-04 12:44:56', '2026-06-04 12:44:56'),
(861, 1, '83RJI45WUTjkQRGjgTO2fuzV3IieFBPTssbJpoAEfcGJrZJUG3vquLL0U33DkQ7VCsOZHvTVXBnkASxo', '2026-06-04 12:45:56', NULL, '2026-06-04 12:45:56', '2026-06-04 12:45:56'),
(862, 1, 'vBBnKmEgvIIjFhCFG1LCWPjogzDbFJOOFB6HDufNE8cows2A3AzoBxMQSY4OiAlb9MmfxCH70wq9nCHY', '2026-06-04 12:46:56', NULL, '2026-06-04 12:46:56', '2026-06-04 12:46:56'),
(863, 1, 'Kkerw6wW2Dn5eqDZrw5eFMNAiljRNLZV2DSrSciDsPgqUFACZD6KRmqLfRO6C6VMiFC0jafFxc0fleCP', '2026-06-04 12:47:56', NULL, '2026-06-04 12:47:56', '2026-06-04 12:47:56'),
(864, 1, 'opJdU6JheGqI4UANjQKu23kFkQFHesjukGUKzZyr3KU6HSM6Ufc5P6edvR8SXLI5hLejHie9B9NVNZTA', '2026-06-04 12:48:56', NULL, '2026-06-04 12:48:56', '2026-06-04 12:48:56'),
(865, 1, 'YyFYfHV788d7fUTokd4DfHYxBn3mKv6WvDOR3IvRqzNY9F6txmh5fQSce7AvMjWyZ1vdFgvv5QOhRYy9', '2026-06-04 12:49:56', NULL, '2026-06-04 12:49:56', '2026-06-04 12:49:56'),
(866, 1, 'sKDjUMu0uVhfK8XxUukee5Op8XEmelzNtS6Or4HxtfYs2WslkjgUS5isXgNnIhmMWfiDXs7faAq6dzK8', '2026-06-04 12:50:56', NULL, '2026-06-04 12:50:56', '2026-06-04 12:50:56'),
(867, 1, '57dppgvQXb23YUAFwQ3rAixUkXyDkWxsBieEFMIlceSSkMaer225IeXGwpIrXJbKa9N04Lk0746cBjdX', '2026-06-04 12:51:56', NULL, '2026-06-04 12:51:56', '2026-06-04 12:51:56'),
(868, 1, 'Gjlw3z4ICj94kVKgQ26ZhyPwSfLk0iFxngpRworJRzuQbFLJtPdmC6pc89BsjKTiLYJVZuNEdYlX5gQX', '2026-06-04 12:52:56', NULL, '2026-06-04 12:52:56', '2026-06-04 12:52:56'),
(869, 1, 'Ld2X6OsSz2Tx1pn2QXzdgBpbBsa7wfYmW25QhlDXDFC4KfRDKQHyURt54FIrm1k41coMWqiL1QqTsQk7', '2026-06-04 12:53:56', NULL, '2026-06-04 12:53:56', '2026-06-04 12:53:56'),
(870, 1, 'C4eLOHC0dUuZvtqNECQgsbRK81zcAJcbwxjW5VVluZVvzwR6GdtzISPWLYjWP4lSV10h5JsmQhc12Q0s', '2026-06-04 12:54:56', NULL, '2026-06-04 12:54:56', '2026-06-04 12:54:56'),
(871, 1, 'bHLwghx3iu3CEML0knQDCvCdf8q7wqYCCvi2B6J1SawA76SzqWvSx6dgaGnLA0EdQuMZc5EOAGatPSf2', '2026-06-04 12:55:56', NULL, '2026-06-04 12:55:56', '2026-06-04 12:55:56'),
(872, 1, 'N7VMS4QdbvSy8bFOyj16ntXN6lNZenjY8sYSAFp0TO7gLA8Obn18UgfCCj2psNWR59JboNjYuMUld24m', '2026-06-04 12:56:56', NULL, '2026-06-04 12:56:56', '2026-06-04 12:56:56'),
(873, 1, 'dbbFrXSPFt9qJQMFqu6xaSOHUBAdQslODfVnB1T2TanXbBd6DIDuDUwFXXRcldpUvdiPEwGv9rF6ynr1', '2026-06-04 12:57:56', NULL, '2026-06-04 12:57:56', '2026-06-04 12:57:56'),
(874, 1, 'apVLyL8fIDorXQCpIR8EMtTcGysdsbSW4vRtpZtwoXcZuT5jbAJpYWPqRI81LlgIFH7vPq7nDn0C9pYH', '2026-06-04 12:58:56', NULL, '2026-06-04 12:58:56', '2026-06-04 12:58:56'),
(875, 1, 'RdkBqchlGXTN2DDpKy0HsxckdI004rCnJoeyM8wJXpfQDZbkwW80a61UFkie31krrCHmO3VDa5WSJvTE', '2026-06-04 12:59:56', NULL, '2026-06-04 12:59:56', '2026-06-04 12:59:56'),
(876, 1, 'D77TmQTaxBKVoM6siFn2WehObBm2DWjPlFJ2U96wbZDhQkTa47KkgjjzpO74rYjDh4yMdE6YMAsHh62T', '2026-06-04 13:00:56', NULL, '2026-06-04 13:00:56', '2026-06-04 13:00:56'),
(877, 1, 'cTvgxcx0quHdAUcc0IYHtsWAr3uAQ49EZYuwMg1t8RkjWT7i13BTiDsJRbogIaJWR0UCRKd4gHziB7Qr', '2026-06-04 13:01:56', NULL, '2026-06-04 13:01:56', '2026-06-04 13:01:56'),
(878, 1, 'BiSWy6aQDdRM2DdDUOAwe3UEUx9AUjcMmDaqL9RCogeHkONhcxtdVU0KFz1QBDFJtIoIcNakg5IOcNOa', '2026-06-04 13:02:56', NULL, '2026-06-04 13:02:56', '2026-06-04 13:02:56'),
(879, 1, 'hH0AtjEPBI8zgri42cc1pExykedQgjJ995wWLX4sO3SXjqFU07pYNsybsrXyExsu48gZyKUzlmzDdvRH', '2026-06-04 21:09:35', NULL, '2026-06-04 21:09:35', '2026-06-04 21:09:35'),
(880, 1, 'qidEz9nYUQGCg7i5TtufFewa3SolKVTJD7qw8tWEg1Pa3cCnkyb52XYT1xkvtlem9LYOxFw5uBi7rInJ', '2026-06-04 21:10:56', NULL, '2026-06-04 21:10:56', '2026-06-04 21:10:56'),
(881, 1, 'WFtrpX61HvlmIRP5xycZZAR5hj2Y2FvLIPhZHhvD3wotlnU8TVxTYfq8Yf55xv6DxYcSDZJKowvqHx6x', '2026-06-04 21:11:56', NULL, '2026-06-04 21:11:56', '2026-06-04 21:11:56'),
(882, 1, 'fiRpdm65PfPLF7ioEYA84IbKfTHzY4iUD6nEN7ZZjBi1DGRyXs69bHtz6bghlxolJIFATUtfG1Ws0nh4', '2026-06-04 21:12:56', NULL, '2026-06-04 21:12:56', '2026-06-04 21:12:56'),
(883, 1, 'U6d3l5AghogT6UYGCTIxJZfONGZQ5yxKFMAogSk88XYPeIPiN5OiMqvQ96FVsQO8KU2FXSBO3oPc2Vbx', '2026-06-04 21:13:56', NULL, '2026-06-04 21:13:56', '2026-06-04 21:13:56'),
(884, 1, 'n3pmGbj5Ali9T5xPVz2raEQmp4uFl2Yu8zCgAb82nSdL7mcHx31bWjCcIDEViY8jh2Pfj8S4mbAxb01z', '2026-06-04 21:14:56', NULL, '2026-06-04 21:14:56', '2026-06-04 21:14:56'),
(885, 1, 'uQTeIxjkmbDU51MPfHWVW4ZZLDoBpUApiWoMCklwwKBWYZxVIE7VvMPZKd3g6t87Ulz2Cna9ezJ9vn7S', '2026-06-04 21:15:56', NULL, '2026-06-04 21:15:56', '2026-06-04 21:15:56'),
(886, 1, 'vSmlBPRk1JX48ifSdAfnQFnK44rsxjuxFdAa1ARcGvcuoL8QkfXs03zjI7eFd8sJxF4MVMO0OQHtrhNn', '2026-06-04 21:16:56', NULL, '2026-06-04 21:16:56', '2026-06-04 21:16:56'),
(887, 1, 'bA38Rd3HZ2gInGnD8OkbolWteBoKYl9XqZtSBuwcyMcMJP4ksg4t0h9pnXHFsilvIZs9i4gKjIuLDwco', '2026-06-04 21:17:56', NULL, '2026-06-04 21:17:56', '2026-06-04 21:17:56'),
(888, 1, '3I0Lvd66cmX3rPEFZD3SiNyemVt1G6KzzCXwHxvCXbwzkb8b8V8LKCA97uwCaHcXdNdZ0Cb39edNWCxL', '2026-06-04 21:18:56', NULL, '2026-06-04 21:18:56', '2026-06-04 21:18:56'),
(889, 1, 'If1zCFR3HObdVGM2lOKZE9orHQxR009c6SptcDlLTH2BQz7LCjnX1lmLrmBTVJldcv3ElGYUjR49pB4l', '2026-06-04 21:19:56', NULL, '2026-06-04 21:19:56', '2026-06-04 21:19:56'),
(890, 1, 'MYB5IRKNoj9gB2jyBMcIYPS31JiBJ9Xm3WUmsxdnGL05fDrCrDl7ZQMKh21JefefXO2XMC5sZTPL13nk', '2026-06-04 21:20:56', NULL, '2026-06-04 21:20:56', '2026-06-04 21:20:56'),
(891, 1, 'FXceQA4XpgQZPw8qIF860HD2RcoMGHfZxsJG4K3MTxZcH2MgWQEvPKV8m4LBbzPWOYDfrKbuCW1N90V6', '2026-06-04 21:21:31', NULL, '2026-06-04 21:21:31', '2026-06-04 21:21:31'),
(892, 1, 'VqXY0FgxvbO7BVSKVntQ0FP6rIvsq1PV88zea8El56UMAT6BRndiHWLBOKgu4wi7S0Y8jGNhLeql2d4P', '2026-06-04 21:21:56', NULL, '2026-06-04 21:21:56', '2026-06-04 21:21:56'),
(893, 1, 'Aj8ypC36I6eDn0okyYAVgLtbJ2Un5khEPjh8pcMhQ3cfOeQBE2T06l5io6KBdQKqaeD9PcIKulG6VTVD', '2026-06-04 21:22:56', NULL, '2026-06-04 21:22:56', '2026-06-04 21:22:56'),
(894, 1, 'B3bnUVvGdlsO5nLPtznoJjfrxSQHPxherGVHfVtkUXpjvzBxnWMiAyUwKNdg6mpanZa5MciQ6iRvFMRg', '2026-06-04 21:23:56', NULL, '2026-06-04 21:23:56', '2026-06-04 21:23:56'),
(895, 1, '9ddyDgVENxUcVaQyx7xqmN8epbyenxLnnuqSaWKJxBGNRTffHq7w6hWsnIcifJTIVfh3dwdPIrbAFJYE', '2026-06-04 21:24:56', NULL, '2026-06-04 21:24:56', '2026-06-04 21:24:56');
INSERT INTO `totem_sesiones` (`id`, `totem_id`, `token`, `inicio`, `fin`, `created_at`, `updated_at`) VALUES
(896, 1, 'NwJo8kHfzFhFCh4UAYevcRuAUFJJCcsie2KzIYtvt9XpnezL7es8R25Kb8cTYhxWwmKAajg8uzveEzcL', '2026-06-04 21:25:56', NULL, '2026-06-04 21:25:56', '2026-06-04 21:25:56'),
(897, 1, 'cQPNodDrZ4X32cw2wgbT8i7F9sBCQPW7jcWY3NeqwWgNOzGtesGaVBeDXgY8V8gggXkIELCOEeFBgZCn', '2026-06-04 21:26:56', NULL, '2026-06-04 21:26:56', '2026-06-04 21:26:56'),
(898, 1, 'ArD3jRDltG21ekZxYaRER5WPRhfWmt7GmpMfdvulb51Ek4TTPG2HgArY75tQtPiBBrV26pPoS4oZSaYc', '2026-06-04 21:27:56', NULL, '2026-06-04 21:27:56', '2026-06-04 21:27:56'),
(899, 1, 'YXkzVf0VjjtnN6uwKWCwLU0Or2kWbpcJ7Jt4T2PtLolAfHNX4tkkvgnqWqLs9vflge8RyEaPqWoa56QU', '2026-06-04 21:28:56', NULL, '2026-06-04 21:28:56', '2026-06-04 21:28:56'),
(900, 1, 'tM2QQVKm8aS9od1m9twWyBRS8F2pIEY9P9TPXEmqbkGkp10J0kY32gz72JcoEuHKChYzYpN6X1Wu1PO5', '2026-06-04 21:29:56', NULL, '2026-06-04 21:29:56', '2026-06-04 21:29:56'),
(901, 1, '53gXpXaPUVXs9WxIRe1wvsrHusXOjvhVnqRT6fAO2EUCjidr15utFa3CJXMq5WXt102RruXYiKY4oKzd', '2026-06-04 21:30:56', NULL, '2026-06-04 21:30:56', '2026-06-04 21:30:56'),
(902, 1, 'LqswrLptne71F1nhBfXJZ8CdjtIANAaZkM1Kse651dfYiw57liBByvcgedAsWGf5fqHAOhibC0BUudx9', '2026-06-04 21:31:56', NULL, '2026-06-04 21:31:56', '2026-06-04 21:31:56'),
(903, 1, 'sO3UdPPLe9VwPvaGFjsiZkPVzhNhM0ZjOeyO8ISNgspyXJeeq4xqUybqluOPiLT9QgtaF2KPATtZmXJo', '2026-06-04 21:32:56', NULL, '2026-06-04 21:32:56', '2026-06-04 21:32:56'),
(904, 1, 'xM5GK6QRExy88be7dgMmGQVS23dxJ6ygbf9BhBmVMUQ18q1pbTG50x5NqT0Mdt5Op6zseNNkN2JKR3Qm', '2026-06-04 21:33:56', NULL, '2026-06-04 21:33:56', '2026-06-04 21:33:56'),
(905, 1, 'lbWuEQvHkbLdxjSAjd5Fcc4xKjMs5vvaUA5VkLvAc8C3PMxhMSjcpqI05pCYpzdIdpGA11ymAScrjfbp', '2026-06-04 21:34:56', NULL, '2026-06-04 21:34:56', '2026-06-04 21:34:56'),
(906, 1, 'zuefaS74rh9XSu5MyD6lrgaAYY5Ybz6v24WeXsypYIPISsXbEvprNPaCAy1RjoNuUFoyep1FSj7BNfDT', '2026-06-04 21:35:56', NULL, '2026-06-04 21:35:56', '2026-06-04 21:35:56'),
(907, 1, 'W1eeCErni8LCC7KUjvLD2zfC27GSBhK7ZOituNmhWREi1YzBKEZzOPXaPSBEUi1iOY68NQ3ZlZrqqp2j', '2026-06-04 21:36:56', NULL, '2026-06-04 21:36:56', '2026-06-04 21:36:56'),
(908, 1, 'hpO3rWnjKYUHnIeh3Qkt0k4ayuRYEiU3XSHgnb1exnd2qQr97ciQ0P5ETcJTkUmCM3mIyHlIZPmgz2GE', '2026-06-04 21:37:56', NULL, '2026-06-04 21:37:56', '2026-06-04 21:37:56'),
(909, 1, 'XC2rzydIOi7xw8AmEDkQXPrUbMnJ7oOc8KDofR3fdZ2rEcF1idPJvP8DV4AI76ynXNsXypblIrhMSu1h', '2026-06-04 21:38:56', NULL, '2026-06-04 21:38:56', '2026-06-04 21:38:56'),
(910, 1, 'ORonV5FuCZ2ZkoaFiH0qR6KWNuc8ZiNyDxWNzsiFqu3gzUCV3xZXuoJBzaSRDzC0zDo99eCuSi51hjWq', '2026-06-04 21:39:56', NULL, '2026-06-04 21:39:56', '2026-06-04 21:39:56'),
(911, 1, '1ebr8gj4MxFyL7s8wlMxUNNadcEF5zIHfys4pQKD6ImfrLRO5cBks47lervh77eX05rBDkPRrCQE4pfa', '2026-06-04 21:40:56', NULL, '2026-06-04 21:40:56', '2026-06-04 21:40:56'),
(912, 1, 'DrvdN2IgaXtj897QIMtvwZ6uMmr2zonbXg88rXM2sRaM6EcK8P8yhzei4sZyN3irSqHoI23O0rruonao', '2026-06-04 21:41:56', NULL, '2026-06-04 21:41:56', '2026-06-04 21:41:56'),
(913, 1, 'REXmF3MsP3w6eAqJqDbvdj81UkszoFBUROaQ5d2tfsQYXyinIfLEHljR0gnnaG6n6LLFLd2P0bu6eHEm', '2026-06-04 21:42:56', NULL, '2026-06-04 21:42:56', '2026-06-04 21:42:56'),
(914, 1, 'BfMwqJLxzXFQKXTdDZoKNzFNqvsDjwGM9ZlLEICq9RqNT32fNIpDg65xCAaA4YCx8QhvYE8mCucLMiFc', '2026-06-04 21:43:56', NULL, '2026-06-04 21:43:56', '2026-06-04 21:43:56'),
(915, 1, 'vmqCyyQBojHMBenFNCF55MWUBcSn7aRpvjHoAiHNbbqOSOYPfL121RErUyh7UlLsacUslG2QjYNH6Uff', '2026-06-04 21:44:56', NULL, '2026-06-04 21:44:56', '2026-06-04 21:44:56'),
(916, 1, 'sm8g32BvO1aWHWYkStk6ItSXspPiylTUiuZNdUdN6lPZXMC98YFp90UbhaoNpEJIct2rUAypCjo2s5gm', '2026-06-04 21:45:56', NULL, '2026-06-04 21:45:56', '2026-06-04 21:45:56'),
(917, 1, 'BCVOOu9rCQHJczMLyvDKhi1IptNrPto98Guo2Qh0Lm8LPsUGCUfb3qZ76hL1MyrgkRr7ZGmcxmTMHKN2', '2026-06-04 21:46:56', NULL, '2026-06-04 21:46:56', '2026-06-04 21:46:56'),
(918, 1, 'UWbekUs3O4urxI2w3OkzxDzlCIscFzhHYetyaTReuJhPb7vmnXOTwsdCgo048mrGuX68J5pWMF5GCC9c', '2026-06-04 21:47:09', NULL, '2026-06-04 21:47:09', '2026-06-04 21:47:09'),
(919, 1, 'OEjH4V5ixyr8imzGFpwmh3eJeKAfV7rbsY002P1dGCI8WfB3qFynPsUt52JnWXT4ZpOVpRHHaLrbIKe9', '2026-06-04 21:47:26', NULL, '2026-06-04 21:47:26', '2026-06-04 21:47:26'),
(920, 1, 'xYI0738EQPu53iIWFrB9hbrlakauiLGNH3fyU8htIQFhbQKjxdxuYmGWTteJxXmQt9y3qndZlNBWogOP', '2026-06-04 21:47:56', NULL, '2026-06-04 21:47:56', '2026-06-04 21:47:56'),
(921, 1, '01b5T6CgMxdq0oW4b4AUb2egXStOqya2PVi0I2aKtP5MlqMnTxMIufDKWz2Po4KLx0P3x4Uw8p7k0fyW', '2026-06-04 21:48:56', NULL, '2026-06-04 21:48:56', '2026-06-04 21:48:56'),
(922, 1, '1xlonQSy4oBCfgPuHqTM0OPqQb4VBPFH69p65RfaRuhgKGnsedPnwGU8Q9iETCCwem2HKBvkOPQL7vWF', '2026-06-04 21:49:56', NULL, '2026-06-04 21:49:56', '2026-06-04 21:49:56'),
(923, 1, 'CNwG5IgbJnrRRCXdSE7cLjvMFLIKmWwcZUnEHXqZqTYrxLOZzgO6x197mnQr9NPtHzX9ebhOHzCDo4c4', '2026-06-04 21:50:56', NULL, '2026-06-04 21:50:56', '2026-06-04 21:50:56'),
(924, 1, 'NSByo3PjzefC8NMTQGQygoFFCxm5AMCDc3KwSKe5guDgSkGWJ5bgyCypP1BpCh8TTd0PmEHoDjWWvsNx', '2026-06-04 21:51:56', NULL, '2026-06-04 21:51:56', '2026-06-04 21:51:56'),
(925, 1, 'sUIwWAOvtYlFkoOnQdFCbdq9ITU3T2HlOeVGSmKjHDKsVEqmE9UJZUylPX1bQxJODp8TYQ1UUZBmlLn3', '2026-06-04 21:52:56', NULL, '2026-06-04 21:52:56', '2026-06-04 21:52:56'),
(926, 1, 'ozz8wgr1P6Rl6F2iD1PRdXAtaPkrhgVT4Ik2s8zp6CuTrCbztyBEz0gclv66R8kdPvfgaECXXOfdoBcV', '2026-06-04 21:53:56', NULL, '2026-06-04 21:53:56', '2026-06-04 21:53:56'),
(927, 1, 'Wh0Ktc1QwxpUxqjs0JKeFRuSWPohSvy9kKhCB2dTdaq7qmOSYC0h4CGXkaZGwbjxJ0OTd4NHwegNbZV5', '2026-06-04 21:54:56', NULL, '2026-06-04 21:54:56', '2026-06-04 21:54:56'),
(928, 1, '10eM0g6igUvn2XYzIJuC0TZ4AJ9bsRcumXDgz6CVOSZgLsHPyNyPoqgQ5hNANjJ5XvWd0BYCHq9megoq', '2026-06-04 21:55:56', NULL, '2026-06-04 21:55:56', '2026-06-04 21:55:56'),
(929, 1, 'lMWyLOdtjyy8XMmsy48Pia0K3htZrMrcyFzIUNeRAqH69rNlqBldD1gh6aB6YV8DvrqBR2ehh3jNjjSA', '2026-06-04 21:56:56', NULL, '2026-06-04 21:56:56', '2026-06-04 21:56:56'),
(930, 1, 'SSYk57hisygtLpNZFA9XF7V8nLBbIJaJeTMNlrjU8e08ZOhpy8nraXFrP7TdQ4Q1x39IbEym2yTI7Q2u', '2026-06-04 21:57:56', NULL, '2026-06-04 21:57:56', '2026-06-04 21:57:56'),
(931, 1, 'PbRhtCmGNlUYFBEmaIkZ7kodGbY9cDK2fSf9PXVitR2oZtL1w8c3qW31OO614iQBefvMpu7DbM24g4w8', '2026-06-04 21:58:56', NULL, '2026-06-04 21:58:56', '2026-06-04 21:58:56'),
(932, 1, 'saxBn4a1glsZ7XMNoR5CLUMKw9dQWk9i0jfTJkzxaR3eSlqYUJEVPjgxt4VwUIlL8g0RIndBUAc0YadG', '2026-06-04 21:59:56', NULL, '2026-06-04 21:59:56', '2026-06-04 21:59:56'),
(933, 1, '8u4wDIIntLKt4uzi0IykW0hxp942ZUuNU8GjhHA8FeBlGcnhdREs4YWjdJCWcw0CjJ2wWWiYQ14NTHm4', '2026-06-04 22:00:56', NULL, '2026-06-04 22:00:56', '2026-06-04 22:00:56'),
(934, 1, 'n1dgwjzLf2QTUvFehRvzgylmogp4nZW6iBngfeHtJP0JZ3KH6SB7yprrYFYDUoQStD7W5fpp2wkoHAb5', '2026-06-04 22:01:56', NULL, '2026-06-04 22:01:56', '2026-06-04 22:01:56'),
(935, 1, '5Y9XAotgOhetb0fqgPabT3Wm0KbxJ334pULXhobWxgVCiXySd9GUTOyXPyxrPnPJgwhIITlHbFdLQXOU', '2026-06-04 22:02:56', NULL, '2026-06-04 22:02:56', '2026-06-04 22:02:56'),
(936, 1, 'cxqrkxHdZSKDKj2H3l6BRmsuvOd8NTmhDaUBzBDdISKHyFsNIMMVK5ijXBdXZoN2iCAmpl5CRuwFlrZs', '2026-06-04 22:03:56', NULL, '2026-06-04 22:03:56', '2026-06-04 22:03:56'),
(937, 1, 'SEoofxE9nY2w9qJNyIVNBaVGkvVK72UdipRbsm9C0CQQtBoa8Rwd3rf2ZBdkXl5nL7xZ9e5NMsmLEN0p', '2026-06-04 22:04:56', NULL, '2026-06-04 22:04:56', '2026-06-04 22:04:56'),
(938, 1, 'JmnrAO6aFruniuMgzkp8wVL9661d8tzoE6VlNp9W5uMRwY7LmgnJbJobcNtY6COD7kWmZV1oQxXKPbx1', '2026-06-04 22:05:56', NULL, '2026-06-04 22:05:56', '2026-06-04 22:05:56'),
(939, 1, 'OlU6gw4dQQlqfye3HPde8ROfVBP9mt5argPySDwDKb1rTWSl8r8KZy5S87lN9AjAt5DqUJgCbkErLGgJ', '2026-06-04 22:06:56', NULL, '2026-06-04 22:06:56', '2026-06-04 22:06:56'),
(940, 1, 'uJs4HcK6lsKFuLg82fGidwFHd58WJsL4je3cEUyZt4WFHtAm77xi19gF6ZrMX95Ph7CpM6APyJOkJB1h', '2026-06-04 22:07:56', NULL, '2026-06-04 22:07:56', '2026-06-04 22:07:56'),
(941, 1, '1SU8VnWp9QWIISudShtIBTd11mb5LG6vvEqXBIn0KgxxJ98C426TyQXetkM3y7oMO6y57jHYikvNu2Wv', '2026-06-04 22:08:56', NULL, '2026-06-04 22:08:56', '2026-06-04 22:08:56'),
(942, 1, 'h53OCDg1J22EFpSOoAABobsxrsQKOt6WNCTbagmyQIsFsjH6qVE4hXSoqfgX4IfUiri0dTAr6EWRGKJ0', '2026-06-04 22:09:56', NULL, '2026-06-04 22:09:56', '2026-06-04 22:09:56'),
(943, 1, '2AC6X2TqEvJZtqsfRhQuBlWWN0S4AmYJxmRORirYjX8yvg7QimYKhpkUZ3gUqPm5w7MLGCxLZnz1CXYV', '2026-06-04 22:10:56', NULL, '2026-06-04 22:10:56', '2026-06-04 22:10:56'),
(944, 1, 'OkZ4aMxFd5jKVcAheyVdMeTMo92MvyKAa93VonkDn6X8j9Z0j6zZrIYoBxxncYPNm9ImUmVv1cYoEnrP', '2026-06-04 22:11:56', NULL, '2026-06-04 22:11:56', '2026-06-04 22:11:56'),
(945, 1, 'alfdSdfnIWttWDSTfNanyPu7qXFZTpQuNYV9XANf4kbnwjO8NaY7eN5L2xGQUtKmAKPoIyGCKsQdDq4l', '2026-06-04 22:12:56', NULL, '2026-06-04 22:12:56', '2026-06-04 22:12:56'),
(946, 1, 'Rz9rGoTf58FBsZTY7Rgikz3T65sqevZE8MvAEoJrPQGELRAPAuOHD5dqz5JyH14yT8fel2hornW0aR3R', '2026-06-04 22:13:56', NULL, '2026-06-04 22:13:56', '2026-06-04 22:13:56'),
(947, 1, 'Uxr5H5xtgfKeiTQeu712hOTlvLrb9prwqg0iPWKfEtBCql91aUODXEanJUTEshtAgkoeZZmPgUB8uLny', '2026-06-04 22:14:56', NULL, '2026-06-04 22:14:56', '2026-06-04 22:14:56'),
(948, 1, 'KcpPu8No881iAp30gnMdl5PZesgt9N1nrR5K0Vm6hKUXuEsiHaXkFbMDDoqRti8smNDH63kq9XAzGZZA', '2026-06-04 22:15:56', NULL, '2026-06-04 22:15:56', '2026-06-04 22:15:56'),
(949, 1, 'o2lktvOMgxyPJSpwXWSzP8JfU7N6JVByCkG2L4QxzdUcq5vwAhIhHd7aoIMJd8nGI2H5XifbfOcw4qjS', '2026-06-04 22:16:56', NULL, '2026-06-04 22:16:56', '2026-06-04 22:16:56'),
(950, 1, 'YRbx1EbkSjNvXWtkXBwdLfRtAfuWvtM0m3r9Ywm5vdLNIoUbfRMkgXVhSRJVIvT3vDWWDVxRBGLGcQ3I', '2026-06-05 04:28:34', NULL, '2026-06-05 04:28:34', '2026-06-05 04:28:34'),
(951, 1, 'QUvr1Tan33OSYP88m9TcQuJBnvLZUnbZ6VTDIMQLtvUiV2UbKVs7hksSI7WUCVYOxQ5AtnsdufflgoEX', '2026-06-05 04:29:56', NULL, '2026-06-05 04:29:56', '2026-06-05 04:29:56'),
(952, 1, 'I91FepYndTyslL9PZLMJtxB47wUJSTbQSe8528S5bzgwTjEsGXJ6uDvfkGuMn9DdSCcDnFC9WqTRdpVL', '2026-06-05 04:30:56', NULL, '2026-06-05 04:30:56', '2026-06-05 04:30:56'),
(953, 1, 'Qj8iK6ZvLw5IQMyOL3KfqfTjdVi1o4B7VqGsLHH5Kuvc5lB9u5AhuYhnyCF2qzaRPZptXK6FljX58OWa', '2026-06-05 04:31:56', NULL, '2026-06-05 04:31:56', '2026-06-05 04:31:56'),
(954, 1, 'AvlvZkUQN1rVsZpL4fFHaQcx0UCjOnnU945ufCvLEdivqcZfKv3Z78zWF9TVF6m0UUeuLiqyElDgnUdh', '2026-06-05 04:32:30', NULL, '2026-06-05 04:32:30', '2026-06-05 04:32:30'),
(955, 1, 'aVlMOaAOcJCz9IO8gjQbYBmKCZK1txwxe2XkpKg4OVtTEazSrtMq20d33g7LGC2LQ9l27DH4QXdxnhoY', '2026-06-05 04:32:56', NULL, '2026-06-05 04:32:56', '2026-06-05 04:32:56'),
(956, 1, 'mIp8FvhngKwsRzyHIPZzJm16rDDhwTLRdg6Xj3Y9JJMXY17r2UGTP20PSQEvcPPXdQeHOyNEvcbTdhVn', '2026-06-05 04:33:56', NULL, '2026-06-05 04:33:56', '2026-06-05 04:33:56'),
(957, 1, 'pljQ8rMZS9NXHoOaN4ihhv5XPRPSlCcIiYgpqrhYMn4WKdYEUvt8stM1jevnCQRvWUoaiJCbxGIFsztj', '2026-06-05 04:34:56', NULL, '2026-06-05 04:34:56', '2026-06-05 04:34:56'),
(958, 1, 'fBjrsldMqXPNEMctaej6PuAaPKQsVGWdsaaAcPSn1PHSrh7fwwBlvsCpmnORliqRHXr1X8jvDRAKprZa', '2026-06-05 04:35:56', NULL, '2026-06-05 04:35:56', '2026-06-05 04:35:56'),
(959, 1, 'PuR7wCoQSGl1nS6qYc2bzfkPHqrJ85qDWfxdgCYqEOSu6eRD0IxKa0naXg0w20g14BPT5JEgfNnOtvVW', '2026-06-05 04:36:56', NULL, '2026-06-05 04:36:56', '2026-06-05 04:36:56'),
(960, 1, 'e1z0dgcCOe0v7Kuz4Y6BViFpPDVMYnViZxAwVTNdyeqSN1e4S2yOH2VqvnwdSsd411zBiY6to6XNCjdP', '2026-06-05 04:37:56', NULL, '2026-06-05 04:37:56', '2026-06-05 04:37:56'),
(961, 1, 'D3EhZs5rJywHNd6wSrQN2j08FGeMoyBayioXIcjSPtC55OHHTyDi0pH4ovWcWaUQ5ERkOZav2iob9lLy', '2026-06-05 04:38:56', NULL, '2026-06-05 04:38:56', '2026-06-05 04:38:56'),
(962, 1, 'gEYnehJK3E6KqLhdj4lyD8pawyqc0cXx1dki858Hm6zyiQxSvGfCMEyQV6NsSqCzyNDe8x9GnwQY8WXO', '2026-06-05 04:39:48', NULL, '2026-06-05 04:39:48', '2026-06-05 04:39:48'),
(963, 1, 'dl80KKM52ozswFH2aInEeUNdsdc8W8h6xSNsX13fSGjJSn3Wd1zKvyzefYaphRfVGW0qVNTFtIlhcQvm', '2026-06-05 04:39:56', NULL, '2026-06-05 04:39:56', '2026-06-05 04:39:56'),
(964, 1, 'KUQdrcGYveu8ge96lBgTPJ76MqrSgrfdLxuPkrTEqzvNYyfDEffndCjrWGhjnAjvpotSwpxa2M4NxEXb', '2026-06-05 04:40:56', NULL, '2026-06-05 04:40:56', '2026-06-05 04:40:56'),
(965, 1, '5anV2HfLJZSlalJucpxJVP0AhDPXSvpIhiTfStroJFbHG7JKGDlX9zE3x8DVyp671ZirHgQMUJlgOxOU', '2026-06-05 04:41:56', NULL, '2026-06-05 04:41:56', '2026-06-05 04:41:56'),
(966, 1, '1eh1Kbghh5RRXaWvbMB7x0NfTR4u3rSZT1xxHQUph1jiJrOWlLmGFay65HwdvwVJHCSU6mePi08kDrmQ', '2026-06-05 04:42:56', NULL, '2026-06-05 04:42:56', '2026-06-05 04:42:56'),
(967, 1, 'QwZbAVcCfJA5pjh6Zuuiv6KdX6IRbj0buIwkHnphUf5QuKUh6cyOFidOMGDmudZkSzNhYxNjN4miKWt5', '2026-06-05 04:43:56', NULL, '2026-06-05 04:43:56', '2026-06-05 04:43:56'),
(968, 1, 'fCZpLVaFquKnS3RjrYZGVDlzynwFli1wwBgi7xsprUcjuyKVmcbfKA5TyGZUQUIEXnKPbuchEwAjfvHr', '2026-06-05 04:44:56', NULL, '2026-06-05 04:44:56', '2026-06-05 04:44:56'),
(969, 1, 'VB6Zt65UK2qvVamjpORhlsOlBnL93EgwcLLBhrT0r9WjUrEDtYPCbFGNxN8xLhu9g4bYHoyjqz33wqbN', '2026-06-05 04:45:56', NULL, '2026-06-05 04:45:56', '2026-06-05 04:45:56'),
(970, 1, 'uANG9O7qXeRQas7JQhGyQ1EPcAHDrRBjGCtDmmL7Bgxzq7ZKICjpaI8Qz3bNnAatOSSfPirCKDs8evdb', '2026-06-05 04:46:56', NULL, '2026-06-05 04:46:56', '2026-06-05 04:46:56'),
(971, 1, 'cMbyph3WLtC3xxtDMmqv78chPiD8oBoRY0BiaQA1g9946aLILxa1IZPBxkYuUIlGmYEP5MGlI4E01POe', '2026-06-05 04:47:56', NULL, '2026-06-05 04:47:56', '2026-06-05 04:47:56'),
(972, 1, 'H5P2iECUjPRQp6Jz0VTTXxcMMePgoQzEdDyIco2L1rvZCIqwuVYJxnWDU4LmQEth6EbShbZKld4uj7p4', '2026-06-05 04:48:56', NULL, '2026-06-05 04:48:56', '2026-06-05 04:48:56'),
(973, 1, 'TdqcKbkxRztw2EMx2SXWcHjlp6agX1TcC7A7P9fli5QnjGCvAul35SUMNoKX8530BXYWlbo5DaYSoJrK', '2026-06-05 04:49:56', NULL, '2026-06-05 04:49:56', '2026-06-05 04:49:56'),
(974, 1, 'Ej1EZ1XAaKAfXaGi4HsEHckLRZSscDVWj7TQsjjN3ZmQlCmcHbMQ683dcXdWCtHWkathuvXdgoRW29Vz', '2026-06-05 04:50:56', NULL, '2026-06-05 04:50:56', '2026-06-05 04:50:56'),
(975, 1, 'VE2mA28GKy5g2znKksdcLGsMCKutCxECgNducJUct6PuOsSY8Uv4RxpZ4yeXbcaly0hFu3FQ5ubhoju9', '2026-06-05 04:51:56', NULL, '2026-06-05 04:51:56', '2026-06-05 04:51:56'),
(976, 1, 'UU5zvhS5ZGVCzpVwXdgmFDJJQuXRnM7NLK3YxHDpVTfI3zsbOrlkibvY2cYqDhtFT34E2xm5BfpOkHE9', '2026-06-05 04:52:56', NULL, '2026-06-05 04:52:56', '2026-06-05 04:52:56'),
(977, 1, 'hvAU9bbuaGRdNAyzCL0hVC9bjXXlylez1acmEVMOZ79qVeAFxqLHL8VfLX0tE0UZLEYFk46TVw9RlR0G', '2026-06-05 04:53:56', NULL, '2026-06-05 04:53:56', '2026-06-05 04:53:56'),
(978, 1, 'NoqCQFORYKwRBZaFbpt4yMl3iq1tCYiedjb9rfOLJ1M4hrEXcu7WV5dIgYEkVPVOQAiAN5iqJL8fhjrr', '2026-06-05 04:54:56', NULL, '2026-06-05 04:54:56', '2026-06-05 04:54:56'),
(979, 1, 'DTqpAcJvoXEioz1wiC0UCRGZjTjND1bC6w0Vg08MMeWFu633Zjdl5lmmilcquEoPnHi0i18O2RZ0ocdZ', '2026-06-05 04:55:56', NULL, '2026-06-05 04:55:56', '2026-06-05 04:55:56'),
(980, 1, 'PaVJkkXre6WWC63NJujXf93V09QIlA67jJnPaXuWHWlcss9xlJQXP9fuL5kOQrRdEy60jzUNSdCWKP54', '2026-06-05 04:56:56', NULL, '2026-06-05 04:56:56', '2026-06-05 04:56:56'),
(981, 1, 'DDdSpizgyoUydKRHenMxelgSP6RLcRGf8FP0U5ui2oDYkOP1SCY3LUxELX7GnP3upbBxMa8WAQDdQihn', '2026-06-05 04:57:56', NULL, '2026-06-05 04:57:56', '2026-06-05 04:57:56'),
(982, 1, 'evQv7q98tRqSQ48dInZiMqcjTLMomH5eJrY4Pc3C64jTSUxTSgO4JPixt426owZyRPT90unvRVxrYeGX', '2026-06-05 04:58:56', NULL, '2026-06-05 04:58:56', '2026-06-05 04:58:56'),
(983, 1, 'EcYX4ApzNCvzjjQmOEXZwU0SPbtInoSxvWPTfqqCcYAlhzqZnZtgXEN74pXZFkkF3xWc2P1dvS5T7iRZ', '2026-06-05 04:59:56', NULL, '2026-06-05 04:59:56', '2026-06-05 04:59:56'),
(984, 1, '4n7sbvzB7HQSHwz7zgFTbhHgdrJiuj1gCtLB9xU1zICk2lDfp2yOvV963h7dFJJx1qiZCi90ZrdC3GNN', '2026-06-05 05:00:56', NULL, '2026-06-05 05:00:56', '2026-06-05 05:00:56'),
(985, 1, 'E186qn9mjcDSsh9AnUCfMZ2M3z8EH7cIUeJWKoPSgCAo7HfAoAkCriOEgOQoGZykE5Rbu7HwyzFRYhZG', '2026-06-05 05:01:56', NULL, '2026-06-05 05:01:56', '2026-06-05 05:01:56'),
(986, 1, '0pZaLTK0r46FEo14F8oH3V7f9yEqxSnyt68kiMGYp7Ln3YMTKohs3cKUAUujc52qhAdcn9DYqCmRHZqM', '2026-06-05 05:02:56', NULL, '2026-06-05 05:02:56', '2026-06-05 05:02:56'),
(987, 1, '32hQLwEI0UtnHdFrnMgDU1DHDukiP7GBiipR4SedD7kHjIa8HgUJTi6w3xIwP9M2M1C7ti9jx5tbwdj8', '2026-06-05 05:03:56', NULL, '2026-06-05 05:03:56', '2026-06-05 05:03:56'),
(988, 1, 'xvaT9pOyMaayggR6MelteLHKVNHOzxQqS1ObF7qlUcpOSRQbpa2MFuZQLyUBH7Ztv3Ug8ND786wW45pu', '2026-06-05 05:04:56', NULL, '2026-06-05 05:04:56', '2026-06-05 05:04:56'),
(989, 1, 'jyH97Tx4dDEZUMCgaVbqdV9Y0gK5jMasICPlUfUkn1uPwrPlJ8YHTN96XTzVgBZSnlcOTEQdslZzhLtb', '2026-06-05 05:05:56', NULL, '2026-06-05 05:05:56', '2026-06-05 05:05:56'),
(990, 1, 'zV5e9KRPLx6XH8I13BHKh0WtozjxUlPR6bMkFrwcO6scIBNge2r1wQqi452T6c3YkWjcWJzDiZ76jWaI', '2026-06-05 05:06:00', NULL, '2026-06-05 05:06:00', '2026-06-05 05:06:00'),
(991, 1, '7s6BpARM69DRvciwpn1GfMjkMpqQTur8vZmQI6uDzjHbMhbQmTlq9dVoOZRzEIY1iSyyBP4hsTzpZSjX', '2026-06-05 05:06:56', NULL, '2026-06-05 05:06:56', '2026-06-05 05:06:56'),
(992, 1, 'PvKDLaSfp9dLZskGt4TK5uAwkxC84ghVJ1pIk0hfTebqQTcPJze07XQ38rsK2ag4Ur4fQ2yCosOW71K6', '2026-06-05 05:07:56', NULL, '2026-06-05 05:07:56', '2026-06-05 05:07:56'),
(993, 1, 'THV7Ec9vkJQ1C6kvJU1NG1o8Xa9xSEJM1mSYSDlieKne46K9ZDVA1G2IJ7AgNAJhlWwAzoiSPETVOPXo', '2026-06-05 05:08:56', NULL, '2026-06-05 05:08:56', '2026-06-05 05:08:56'),
(994, 1, 'b0OUqgiSqudMM7dDqWx88lycAvnvqZiNPDvBm5RZoeFGCJ4HO7XizADbfUIMRqGkbXWvhKZyfnTZHib5', '2026-06-05 05:09:56', NULL, '2026-06-05 05:09:56', '2026-06-05 05:09:56'),
(995, 1, 'UwurkGwer0zXXlBViVqNs3RwWg4X5nEiGqET9Yss5QMq8N7Ab50ln4WDOgCSufBoPtLUOKb7r0jaexV3', '2026-06-05 05:10:56', NULL, '2026-06-05 05:10:56', '2026-06-05 05:10:56'),
(996, 1, 'QhAhi0vjAOFRtINOdIePTvipSTslKjNomShR2xfYNKsQkPrqgKqgXEuJexJkgNQAoxtOGRJJuTuSGmrg', '2026-06-05 05:11:37', NULL, '2026-06-05 05:11:37', '2026-06-05 05:11:37'),
(997, 1, 'N2E7IrEPwc4qO9xtI2tnaaIrCbv3daWfhQigqwHBjWTeUP9QlMa4wLQsqbuyV1vUknalnSW6kaT6BTdf', '2026-06-05 05:11:56', NULL, '2026-06-05 05:11:56', '2026-06-05 05:11:56'),
(998, 1, 'ZIntBrfzjVJxoXxeOtxiowHJ82j2uFbDxootLQgE7pPRzkoveEejOOESzJ8dnelPaLJvqb4sDVn8uQXO', '2026-06-05 05:12:56', NULL, '2026-06-05 05:12:56', '2026-06-05 05:12:56'),
(999, 1, 'ydElzod89R3hGox2zL9ghxFY4BJxnpONOqkpNW7VjlHA1P8SBaSCqIfJOQ8JfnukWVpd7wmi7y1ezZ0Q', '2026-06-05 05:13:56', NULL, '2026-06-05 05:13:56', '2026-06-05 05:13:56'),
(1000, 1, 'YvHMtjjeqM9Neh7CcfhQEnaHvDtyH67VylphoW3kkbCFetIaVpoEARZJLgamAH7fHLIQQrKK6fUDXJgp', '2026-06-05 05:14:56', NULL, '2026-06-05 05:14:56', '2026-06-05 05:14:56'),
(1001, 1, 'X2RlicTm7bF1Z1JubprzOU4E2GlSCGbCMtZ5Zmq35R1h9kZiwKYJg9LXsHqNeFgl5jP9ZR6jD0onKPWC', '2026-06-05 05:15:56', NULL, '2026-06-05 05:15:56', '2026-06-05 05:15:56'),
(1002, 1, 'InRsqQsYKWUqjljsETkkHvD77ZfEhjJuGoVoDKlm0zfqi3SYT7muXm5o3RkrwBFiULi16M2polqBf6Hy', '2026-06-05 05:16:56', NULL, '2026-06-05 05:16:56', '2026-06-05 05:16:56'),
(1003, 1, 'oXxpxCFJwWhvQRJVf0rfqTCcwj9ZMWvY8kdqMY8f1AfqKcesFktRlGEOoprB02OGvRUCUHwt5CDmuVaN', '2026-06-05 05:17:56', NULL, '2026-06-05 05:17:56', '2026-06-05 05:17:56'),
(1004, 1, '13PmIaGDZvibGL5VJUztE2CRVRv0LX0RTKFmOL0FHmi4AJIpGhJ05jmc6dKigjYchGGDn49PB6ExqueD', '2026-06-05 05:18:27', NULL, '2026-06-05 05:18:27', '2026-06-05 05:18:27'),
(1005, 1, 'NyayldxdFpKJ6jVxyX7rmB7KzvZ1J0pJNwVGf4MNo7yPoFHBWxuHuRNcu7z6XkCm1CB1050Wew7CYfAa', '2026-06-05 05:18:56', NULL, '2026-06-05 05:18:56', '2026-06-05 05:18:56'),
(1006, 1, 'ZBav1iwAhnNpMINGykeEJl8hIPzmRq89AFvhNt1T9Pi4sfzDjF8MZrmyrAi9oemoJpeYVRqDIkKXYKzR', '2026-06-05 05:19:56', NULL, '2026-06-05 05:19:56', '2026-06-05 05:19:56'),
(1007, 1, 'n0uP4SCIDl0zvbgnhHYBfmCDO8J2dUdFSW1TBm4irxKwVIF85vToOlN11p9ntJbZZjX0ELqS1wn1DAUZ', '2026-06-05 05:20:56', NULL, '2026-06-05 05:20:56', '2026-06-05 05:20:56'),
(1008, 1, 'mBWmgw6mH7AZxaDAzfbkO4Gu8UiDbvRKmkz9dG1Ff26sQcn73oAwJy8H3jOWTbpbWnobUYNoa4ksud3i', '2026-06-05 05:21:56', NULL, '2026-06-05 05:21:56', '2026-06-05 05:21:56'),
(1009, 1, 'NEPtmSZAZ84McmExzMJA2b1pXHkZzhj4fufW7rUS1ukirkRkMKKuCHHCV8nBEEzrRtVKL2dlH2iNLjXb', '2026-06-05 05:22:56', NULL, '2026-06-05 05:22:56', '2026-06-05 05:22:56'),
(1010, 1, 'TBp7URoIiIaL6DitbmlHMamhP2d7AUOXe4j0pTAzInvt00UmNR2zaill46tgzlQjcWCTKxslcvROuzE0', '2026-06-05 05:23:56', NULL, '2026-06-05 05:23:56', '2026-06-05 05:23:56'),
(1011, 1, 'B4a8lpyptFTSc9Zaz0xmeIusUnBBIDSz3NGaYrATDqZwonEv2P580E7i7uEigtyJW8kEXfuG8DhaOR8o', '2026-06-05 05:24:56', NULL, '2026-06-05 05:24:56', '2026-06-05 05:24:56'),
(1012, 1, 'V4T7Ghhowdbfgp5lq72V91PiK0LAqYjL4SQPwxrSTxkIH0ohBPOabO6n52xbPcLWarXspNPtygn3snze', '2026-06-05 05:25:56', NULL, '2026-06-05 05:25:56', '2026-06-05 05:25:56'),
(1013, 1, 'SfX9UbQe0wN1HvMU6VRshoAbpTHtm1Sd8FDwRFO0ccQm3ZOFBGG7uQvJKmeNWQYUjA8VNVwbFH1L6LFU', '2026-06-05 05:26:56', NULL, '2026-06-05 05:26:56', '2026-06-05 05:26:56'),
(1014, 1, 'wncPZDwBBq841haRmpLE5XtmIXjftIkb6O2swI0sf5BxswIoS8V2aEwCF6vBAKXUNFRtVl7Jjw6uNQ0i', '2026-06-05 05:27:56', NULL, '2026-06-05 05:27:56', '2026-06-05 05:27:56'),
(1015, 1, 'nQThLhOJHswjlB1Emumsx1rquA9rffFT1q8HCewWPVN653paJuHCxsP2TUpIVjq8NejO6rZsACoAF1NN', '2026-06-05 05:28:56', NULL, '2026-06-05 05:28:56', '2026-06-05 05:28:56'),
(1016, 1, 'ag1rusjU7NNZsxWRnqgZoFhozSbvf0i0F7VWmuzZ4DOwn0M4PcqVxkPtfaQZyMu2oOg5K18y63HtXH0p', '2026-06-05 05:29:56', NULL, '2026-06-05 05:29:56', '2026-06-05 05:29:56'),
(1017, 1, 'OIr3VOPJpbgSfoDthfKvKbFOPNWzEZnJErzXTViJvgvq6LIcwGikfbmMmJjWSBYTbXVUKvgMeAerlyvG', '2026-06-05 05:30:56', NULL, '2026-06-05 05:30:56', '2026-06-05 05:30:56'),
(1018, 1, 'Def6fTQy9p7os4dJYpoFM80q7uuikamPs0HthF1OuyK5sURnERlUY5BxFroM6SZlqpwP9NpbG5OBcJbV', '2026-06-05 05:31:56', NULL, '2026-06-05 05:31:56', '2026-06-05 05:31:56'),
(1019, 1, 'I0mKJF3wTwUH4X3YEGunWQRsrhZJSl7tlRTONPSLbJDFgWysY1QVMO4ANGCMMnSrlcqvY4ARhTcMW0Gp', '2026-06-05 05:32:56', NULL, '2026-06-05 05:32:56', '2026-06-05 05:32:56'),
(1020, 1, '19QDqJPNj87QxHDVV9NV6VO4S1LlLkDyKK9trT56H5FJUDEoKrwWoMwiAhDRjP2PnCwOGOtDQYbjRp9n', '2026-06-05 05:33:56', NULL, '2026-06-05 05:33:56', '2026-06-05 05:33:56'),
(1021, 1, 'kNcrQW6hvURtKuf2sKNAO0LeDOvernNX2gmZppbXWjhCD5k9ZOOh8zXW2ZSiQAJklNSzKK2g7unegSwq', '2026-06-05 05:34:56', NULL, '2026-06-05 05:34:56', '2026-06-05 05:34:56'),
(1022, 1, 'jnYDHdlQUwlbKbho2EfBMhH2EkytHZdrhuXy1N9mFTvLEWvc8RgdezGDPbQ0A5lIVmoF2ZDbBDlIC2oI', '2026-06-05 05:35:56', NULL, '2026-06-05 05:35:56', '2026-06-05 05:35:56'),
(1023, 1, '4SLp64oSJDo3IdhBccn2IQKXGax2cjK8UzlG827WUttVgz8ooOZ6PPp5GDEFstFqgAGzIQrsk2mbKYCd', '2026-06-05 05:36:56', NULL, '2026-06-05 05:36:56', '2026-06-05 05:36:56'),
(1024, 1, 'SodHzkA0yslfRh6z1rJqmeqyyMtwUUa0bICPGcrydXFpQZS8NaqrBLXSNZCUbi7BuQu6tngxqPeU3XR0', '2026-06-05 05:37:56', NULL, '2026-06-05 05:37:56', '2026-06-05 05:37:56'),
(1025, 1, 'bSb8D5BgZAm3jOiSqYZGUBlXQ7dtT36e7xNiGt0kA98uCBVksDd2adNkmYAyJgoVxDfxVsIL42KMjwRD', '2026-06-05 05:38:56', NULL, '2026-06-05 05:38:56', '2026-06-05 05:38:56'),
(1026, 1, 'St1kAq9gR07NpS8BWKD084LPyx9Pe0DlCulzzHOa3etbsOs0edFJvsuQKUzvcmAcPgnmLSVglT9nYln1', '2026-06-05 05:39:56', NULL, '2026-06-05 05:39:56', '2026-06-05 05:39:56'),
(1027, 1, 'qe0JE4gufPbjSplbiBQ7I7lMHIk7TXCyqVvBDPAtJQD9scofmWMTi04czCk3PuC43mPb2q6Oh1hriun1', '2026-06-05 05:40:56', NULL, '2026-06-05 05:40:56', '2026-06-05 05:40:56'),
(1028, 1, 'fKi6EbYyTH49Qn4FWiniITUcGkG2UXtKlN0p4bXBNYkrlLKs7vOOSpJHos0v3t4SpbS0Wbf4vKzM1GRT', '2026-06-05 05:41:56', NULL, '2026-06-05 05:41:56', '2026-06-05 05:41:56'),
(1029, 1, 'LhesotAGXhX1Tpy24z20e6WkUgYvB4eWwD798ol6aRmu86AHw8gwZiP6FFQIxCLMTobsJU0kSRATiRee', '2026-06-05 05:42:56', NULL, '2026-06-05 05:42:56', '2026-06-05 05:42:56'),
(1030, 1, 'xPL4LF510balIdTUIEyrD0FN7ALePTon1pSFIpc8CKjHhp5lUcr9dkmnL3jAnfm1UiZIXX6Qasvb4zfI', '2026-06-05 05:43:56', NULL, '2026-06-05 05:43:56', '2026-06-05 05:43:56'),
(1031, 1, 'CfYxLknr6LMR5RwJ4amECVSlcf1J6qEfEnD6uv7OWkSXaR5NiReVvqTVfAR98Q8lbYo8LDN4t7PpBeid', '2026-06-05 05:44:56', NULL, '2026-06-05 05:44:56', '2026-06-05 05:44:56'),
(1032, 1, '81nDDw65CirCyLYd2Ae8bOpgZ7p9v8aLUeq3xmw3rmopJN7FdwqzbIK4E4iBasUL6ajZP1ocoioRfEww', '2026-06-05 05:45:56', NULL, '2026-06-05 05:45:56', '2026-06-05 05:45:56'),
(1033, 1, '5m5D36vic7BIUdpI0zSMftWFCgp7W663yOEkPHIwsyLYIiZwB7jAVjz7FZcWo1eJIjLT0uhd5BYJ1oh7', '2026-06-05 05:46:56', NULL, '2026-06-05 05:46:56', '2026-06-05 05:46:56'),
(1034, 1, 'PGtDhwh7XqxjZ8zJq5wuxbdHbvItI76nyQKzaPzg5DTMpKil8AcW77m7Lvpd40y3LewjdMB1qb7EFLKZ', '2026-06-05 05:47:56', NULL, '2026-06-05 05:47:56', '2026-06-05 05:47:56'),
(1035, 1, '5jWWOHrJDEvwKSstcpsYpz5AMoDigtQTMviNSyGacE9onMVb8m1beHD2S217ocrf2o2UhBzeQUgjl4zo', '2026-06-05 05:48:56', NULL, '2026-06-05 05:48:56', '2026-06-05 05:48:56'),
(1036, 1, 'wffGYNT0knZKZheiNzwKR1wOpdMX0CPg2uCOqbuPtsEVOsQfORrDcTaOtNcEYapP0JkyEkIt8CZmOcVG', '2026-06-05 05:49:56', NULL, '2026-06-05 05:49:56', '2026-06-05 05:49:56'),
(1037, 1, 'PIi5kssljvtCgBsmSjfpzKtbu2eNwstffAOKnFey7kBFOVZs0QJxuv5lMgK1WZwAm1EaoSRSAlNzDArl', '2026-06-05 05:50:56', NULL, '2026-06-05 05:50:56', '2026-06-05 05:50:56'),
(1038, 1, 'bUcDzLzoFBFlCrdx4dcIYANND4vt6rz9fqvkfijtukCVY1bGXx39f2ZeU7HOhUq5h1OMCvmK35YmuA5n', '2026-06-05 05:51:56', NULL, '2026-06-05 05:51:56', '2026-06-05 05:51:56'),
(1039, 1, 'lsuHc8Glr1StK1rcoXwtWWy3TQHmIp7GrWVw6yNHlzGmA9Uwm9aMa3mXueekT1kvbyaNhWlJd1Gm8ax7', '2026-06-05 05:52:56', NULL, '2026-06-05 05:52:56', '2026-06-05 05:52:56'),
(1040, 1, 'lQjf7zxcNep8UjDTqlz1creokNRI1cdVUZFLg35Zq56E205zGA0K6VI9s2dKoUjWI5ByU0qfLbiMhhOD', '2026-06-05 05:53:56', NULL, '2026-06-05 05:53:56', '2026-06-05 05:53:56'),
(1041, 1, 'djgHgVxKFTjT6eoOWyBo7emUfELmcYKsSUaNc2aN0aM8pTL4rUGvFg9nLosPvB4JIszuqkFS08siryi7', '2026-06-05 05:54:56', NULL, '2026-06-05 05:54:56', '2026-06-05 05:54:56'),
(1042, 1, 'NZoyYQKV2bmQxzbYoWaVZhOHbNX4d82HRaZZqQOAVnAbie3Q5y3DbKFIUiQMw7bct8SmCYCv6163Xdrs', '2026-06-05 05:55:56', NULL, '2026-06-05 05:55:56', '2026-06-05 05:55:56'),
(1043, 1, 'ybLbgUvlcHmTQeTpg7qmA75IuYJ5QB91H3NzJWBhEyQH7oUYyUAiWqhod845m3fHotImRgVz1gGgqJVi', '2026-06-05 05:56:56', NULL, '2026-06-05 05:56:56', '2026-06-05 05:56:56'),
(1044, 1, 'SH0R6FwHAWlTpY2iaFlizs3WGfM1zDfcmYK0FhY3VVYjPA6Hci4mmgEbp0Zy8T6VrFjq7Z29QqOGouDN', '2026-06-05 05:57:56', NULL, '2026-06-05 05:57:56', '2026-06-05 05:57:56'),
(1045, 1, 'aTkSiDPFRtfEhC0Cj13HnJVS5CLhgAXaSZUpB2neME0SLhwOGR9D2RVnR3nYu158eGbe9cnm8cnp1g8Q', '2026-06-05 05:58:56', NULL, '2026-06-05 05:58:56', '2026-06-05 05:58:56'),
(1046, 1, 'cbiQmGc3SenGAb6Sr2V9E7e0AcTng16ObXBVNqtOYiYohESn8ZMpg0WNJUwbU4DdpuaW6lUQI11H6sKi', '2026-06-05 05:59:56', NULL, '2026-06-05 05:59:56', '2026-06-05 05:59:56'),
(1047, 1, '2mGmcpnhnbkaXtUltW7waVOM5LuDM4DnlaMnzblnlphDzzu5VYRUetqD1hAmXWhVNqhvxcNP5BJAjXrQ', '2026-06-05 06:00:56', NULL, '2026-06-05 06:00:56', '2026-06-05 06:00:56'),
(1048, 1, 'H60prRKAj5JSayfQvLOb71UmtUsd0axcDkDH1Agaxeasse8Xr4i17wRr1KVOVIlEJw6afVXeL02SouEy', '2026-06-05 06:01:56', NULL, '2026-06-05 06:01:56', '2026-06-05 06:01:56'),
(1049, 1, '2S96md4aSZNeVYqmig1OJyfUPGbe97oKVM4QyZyEhyBYRih4z8wUxy1YD3EGkPZZSiX9Mq8oNCMWDTHH', '2026-06-05 06:02:56', NULL, '2026-06-05 06:02:56', '2026-06-05 06:02:56'),
(1050, 1, 'DHDVwCpAS3kyMnkVEWYRaLutaTfmYy4h9jyZqvKKPGbqyP3QbJIg5xe0p0qRYnUFA9DVelsiYUjIAVis', '2026-06-05 06:03:56', NULL, '2026-06-05 06:03:56', '2026-06-05 06:03:56'),
(1051, 1, 'tT8MCc6G8j9W3GpLHP9fhw0DsSC5E7BlC709FHUNhl6mmlYqq4XVVZfc8d4oHmjjM6gJMc8ab8mwRBnu', '2026-06-05 06:04:56', NULL, '2026-06-05 06:04:56', '2026-06-05 06:04:56'),
(1052, 1, 'CUVw53dencfMVGvehjsipnlQ1ZBLSIxkoo9ZxkjM0VeTL9Bf7xk1tY4DDlwfPP2ZHGuKsOs1lFbHJw2V', '2026-06-05 06:05:56', NULL, '2026-06-05 06:05:56', '2026-06-05 06:05:56'),
(1053, 1, 'XRftuiIeJngdkECU4ISTojg28GtgT5PmgnVqX6WkWhaRovuY95CvGBwBFhey1x9PdZYAZxZNZ1URluk4', '2026-06-05 06:06:56', NULL, '2026-06-05 06:06:56', '2026-06-05 06:06:56'),
(1054, 1, 'SIYkeFbCHlRIEW2N3cK7s9KiC2qdAckamHNDtAPmF8W3743BCHgcAjSkKc6aAC3w2FKKDa1Ouvh6r38R', '2026-06-05 06:07:56', NULL, '2026-06-05 06:07:56', '2026-06-05 06:07:56'),
(1055, 1, 'R4zsumN3sjGm7e1HdOBjRTjANDUUfnXR5ek47cG8aqs9x4dwosMCC0IDbdXwFA4YTdpEf3PPuNFvBjBt', '2026-06-05 06:08:56', NULL, '2026-06-05 06:08:56', '2026-06-05 06:08:56'),
(1056, 1, 'S4Z0Sb6HBiCVWSwvrAb2CigzbC36eAwu6OzcNTKSrTAvaZyEbtlgsS7o4fZi6mfJWkwY1yUEZZdg0rvk', '2026-06-05 06:09:56', NULL, '2026-06-05 06:09:56', '2026-06-05 06:09:56'),
(1057, 1, 'ilrKVkokMLqYNqowBmEtOdILmjQB8IQkkI9McB7CSFE9YlIXMptD2w82egIBN6b9DdVTZn8tjM2WNsRN', '2026-06-05 06:10:56', NULL, '2026-06-05 06:10:56', '2026-06-05 06:10:56'),
(1058, 1, 'ITRR2l7nuTLpbDr2SYm0WBwdm2HAiBnYQDVKa6jc8tTvqUe5kCVgPfURJ2v3wAIKTpCVtIhDyjcKoeXE', '2026-06-05 06:11:56', NULL, '2026-06-05 06:11:56', '2026-06-05 06:11:56'),
(1059, 1, 'iriXuThPJv5YbvmRryMDCgwGVT7hPu0QpCEcqOvN36OzU9O2y9b21ShEtSrHWrzv0Zlk28vySRrRzXre', '2026-06-05 06:12:56', NULL, '2026-06-05 06:12:56', '2026-06-05 06:12:56'),
(1060, 1, 'eGDQUDpGA7Cybl0EvkxSNcm57pg0bVL0bRakbp3Wk6q4kgSWhmk3Aid1Y7e1Cf5yTDR3dGnkYHw2EqtO', '2026-06-05 06:13:56', NULL, '2026-06-05 06:13:56', '2026-06-05 06:13:56'),
(1061, 1, 'gBTr95cGAK5WJLCCYSLZURFdpxwvdjl0pVUsVLSBjktZZ9cUuOvu2oJaWAILJStUN2agnhMLDeqkP1TU', '2026-06-05 06:14:56', NULL, '2026-06-05 06:14:56', '2026-06-05 06:14:56'),
(1062, 1, 'JHxQR7BYnimZY26qb2TYOpQzB73N22q0UI9yRQnCLBVeLixoo3dRyzQSuTW7L7El0fdXRUCrDuODlrd6', '2026-06-05 06:15:56', NULL, '2026-06-05 06:15:56', '2026-06-05 06:15:56'),
(1063, 1, 'qy3Xt74UxsyOmOB6dyEl0AfMdcEM4nsKDEyUrExhdMIX3YDr51uKbZlHgLj6cpBh8V89bEZv8ALI4i0y', '2026-06-05 06:16:56', NULL, '2026-06-05 06:16:56', '2026-06-05 06:16:56'),
(1064, 1, 'AG8eJtkFjQv4wyIxYZjHfnjxrD0WZnspDjxHH1JUEukwhGhDgI71GBbgusxjSNrJnT1255PmdTS6qb5d', '2026-06-05 06:17:56', NULL, '2026-06-05 06:17:56', '2026-06-05 06:17:56'),
(1065, 1, 'UzAzN7IL3IJ7yPEphEB9qbsUT3A3MSX2hzVr9MM8XASpg2QMk9NKcevqCnxP56jYcr221fg6PYF2C6zR', '2026-06-05 06:18:56', NULL, '2026-06-05 06:18:56', '2026-06-05 06:18:56'),
(1066, 1, '9nkNLqOVgBLgkHNe40yKqxUy5GUE2kjYDLxd1QWAsXLVbXepiPYlR414IYNpXaSlUd0j2KhufbyCXZMl', '2026-06-05 06:19:56', NULL, '2026-06-05 06:19:56', '2026-06-05 06:19:56'),
(1067, 1, 'gts2N41UzY5D8Pyg9bdnjgqYLrewAYi8PE7XwVVh3tCxtWWOXMdupVJHbJ7DimHhmW6dp7CNDgTNiKas', '2026-06-05 06:20:56', NULL, '2026-06-05 06:20:56', '2026-06-05 06:20:56'),
(1068, 1, 'N5CoIfirOTh1FnQULuW5pflJMlDuuvnPe2iqUGU7Yt75HNOtYsQCZUojQI1fzyiJPZ6JtVowq7J5dbl0', '2026-06-05 06:21:56', NULL, '2026-06-05 06:21:56', '2026-06-05 06:21:56'),
(1069, 1, 'YpBcjAJLbZAxqvUuil2JhiHc9brsbVUte2DHDnj1ji4e3F58P7RnGaEyQQxbGhJXsvynqBMKugHgSjLK', '2026-06-05 06:22:56', NULL, '2026-06-05 06:22:56', '2026-06-05 06:22:56'),
(1070, 1, '0mEVPMfuXyyfzJTsWjkiANRaw5SKoG0o5XaWzRr4jMGcEaVfqCQrqD7tvVEo6LRt83iphHdq9qBCTUdY', '2026-06-05 06:23:56', NULL, '2026-06-05 06:23:56', '2026-06-05 06:23:56'),
(1071, 1, 'rQ0zCGFkY8fDuoB3Rnh93KgkOcZTF4uGeZnhkO5Ueld6DvvQaQ0uOijnH1jckD32egVotdDfw5cZvhTr', '2026-06-05 06:24:56', NULL, '2026-06-05 06:24:56', '2026-06-05 06:24:56'),
(1072, 1, 'iTx71C5K4vV5B86ZQgYMCSujbjUOOW1iON9AnReSJ4eeoa56KYQvyYNtEliwyP1uyd5ZKdo8laeStKGP', '2026-06-05 06:25:56', NULL, '2026-06-05 06:25:56', '2026-06-05 06:25:56'),
(1073, 1, 'Cbei3nEZotqbXoCT0IOFEwQ7abKQG6W4xQrcv5EalHyHDK96jGUmGWkqotAFEAhWi6lzFaYlKhxGsETi', '2026-06-05 06:26:56', NULL, '2026-06-05 06:26:56', '2026-06-05 06:26:56'),
(1074, 1, 'nh5LURuOmxHWyk80WrBkivpGPFv6RBYlV8LiJWdu7G5Q8c1TZTuNgaVmmZNCmssBbaEpuhhfC9kT0cSC', '2026-06-05 06:27:56', NULL, '2026-06-05 06:27:56', '2026-06-05 06:27:56'),
(1075, 1, 'p2GufShcj6mgAtvBTfpJVYBlMRDxCYoIuytYR2rBqznUXRYWm6FD8UpxauiLTTs7bc3Jlr80dxvI0UBN', '2026-06-05 06:28:56', NULL, '2026-06-05 06:28:56', '2026-06-05 06:28:56'),
(1076, 1, 'sNwF5ydUN5lqkSOvhLRdsHKmCRwT2WeD7OXrFMZFm8rR7F7KZ8n29ysYS9XAMGQ3w4ZXNpZpZ9h9u62l', '2026-06-05 06:29:56', NULL, '2026-06-05 06:29:56', '2026-06-05 06:29:56'),
(1077, 1, '7oIJdepNU6zdwGRAf6C0LnC4symK5pXeHCTQI5cT4C2HYUHAwUtfAfnVHzzsfkmEcf2xJu7l9YDuF734', '2026-06-05 06:30:56', NULL, '2026-06-05 06:30:56', '2026-06-05 06:30:56'),
(1078, 1, 'SaWZREccY5xVALjjVjkPrrKpZf9d3BtG0poiQAGOjLuhGCBCU0VL4cc1BcS2q5DYvhNyvVip7Vkug2Hs', '2026-06-05 06:31:56', NULL, '2026-06-05 06:31:56', '2026-06-05 06:31:56'),
(1079, 1, 'QYMl4dwebqBHjmyNXpBH0ZLsQVhrrXJuHZVpHcIWVoXWnZO5LmAMwhqEZskhdMjCcjI4JqsAAbImIFCb', '2026-06-05 06:32:56', NULL, '2026-06-05 06:32:56', '2026-06-05 06:32:56'),
(1080, 1, 'D0yLp6oNzZO5n9KWpryaLfdwZOsQB8ak27p7t3JvDSoslWRFrEZW7z5aZFXYsB4ErZt5hz20fYQCi5dH', '2026-06-05 06:33:56', NULL, '2026-06-05 06:33:56', '2026-06-05 06:33:56'),
(1081, 1, '8977HOIoe8f7ZbVHYAjniaIIGeck2urcWZUNzOeNUtg9A7ReeDXm4ioiFGa2AMp4sujpgT3nAA4SC7pD', '2026-06-05 06:34:56', NULL, '2026-06-05 06:34:56', '2026-06-05 06:34:56'),
(1082, 1, 'ukOgGKjRinD5N3Bp6ZFHfB4kDG32bFFgEwjOnhDeEYyErhxY5myGDIsCMIL5W5k4rqVQocS3Lr9I0z2A', '2026-06-05 06:35:56', NULL, '2026-06-05 06:35:56', '2026-06-05 06:35:56'),
(1083, 1, 'xr5MBINEQpyfnEOQ3Yr0il35jRc06sfOi3wUaTqJJtYPTGY7QIg6W1aJAetuk7tWTxNLaq8F5YlZJXbn', '2026-06-05 06:36:56', NULL, '2026-06-05 06:36:56', '2026-06-05 06:36:56'),
(1084, 1, 'xUJ5tzynOE4SLDad4M0VyUPnsclHjNbONpk3aPPY8f1w7Lr28kcX0LQKbOHoN95ZfdyqeFgURfQSxFvf', '2026-06-05 06:37:56', NULL, '2026-06-05 06:37:56', '2026-06-05 06:37:56'),
(1085, 1, 'zQKo3sOK5bzcUAWSlBxGKW46k702yTKN5ObhfPw782aj8lF6QSM0Jnhcr7Bp0Vvyj0V1xwP8SKILFncc', '2026-06-05 06:38:56', NULL, '2026-06-05 06:38:56', '2026-06-05 06:38:56'),
(1086, 1, 'vpQkDDEtZTPRcJrOkkkZxnRGw4Ucm1JER0iNREt7hIGF87wDyiLfECNC5nWtKYFPypx2JpBNixgiMFWS', '2026-06-05 06:39:56', NULL, '2026-06-05 06:39:56', '2026-06-05 06:39:56'),
(1087, 1, 'zUkpYpRCei6LXG5rws0K8yNb8H25bCOJUCOhPHDizMM8XZRx9SktytTIBuAHkZLGFeyzhUOx7YlWFMAu', '2026-06-05 06:40:56', NULL, '2026-06-05 06:40:56', '2026-06-05 06:40:56'),
(1088, 1, 'p8WkNjmQdX2UUAeCo8CPBsyHj3vungAEdCPiTu6WsdjYYW088RLPolfU9LOzg143AErv79pnOWQ4W47y', '2026-06-05 06:41:56', NULL, '2026-06-05 06:41:56', '2026-06-05 06:41:56'),
(1089, 1, 'G7pyO9xyH6QPPSLj1esFHOzuMiKimC3OCnpvJgKC50yWEzTVTrNw1Qysb1GaZQdwjmRobCr4EkOuE8i5', '2026-06-05 06:42:56', NULL, '2026-06-05 06:42:56', '2026-06-05 06:42:56'),
(1090, 1, 'nXBALupGGNgGARk0cDTUqRaIR5co0fvPH2kZZFpdn0bnOpMRlEEyv9QkHaYItIQ0SOvjJ4a4K84QNJwQ', '2026-06-05 06:43:56', NULL, '2026-06-05 06:43:56', '2026-06-05 06:43:56'),
(1091, 1, 'f5wglUZSQGQwULFaT5YYzk1CwKZFd29LVj6T1ln7XXPUoj8McxzsOFnt3MO9tnm8cDVCazug7rAQyWvZ', '2026-06-05 06:44:56', NULL, '2026-06-05 06:44:56', '2026-06-05 06:44:56'),
(1092, 1, 'TCHvTkrVV1ih433saffKu42t9uoX4Lbrm2rAO9HkrE6eDp0zJUG9C9SiXCLKBPEX89smSfA93VKtb8wX', '2026-06-05 06:45:56', NULL, '2026-06-05 06:45:56', '2026-06-05 06:45:56'),
(1093, 1, 'psqHePqBKefrpY7Lm4Bsaq0GKyAPEpWybQqq7mspmjjAXaZw8dni6JOChnbBePgdFHaLa7HcMbupsctb', '2026-06-05 06:46:56', NULL, '2026-06-05 06:46:56', '2026-06-05 06:46:56'),
(1094, 1, 'zugTmfKoZrRpWuhXPXh6S9O8yAab4MGqqTPlkfb7GWFDFpkAgmR47dfV2OjciRQ43UUHYhZGxFi6p0wl', '2026-06-05 06:47:56', NULL, '2026-06-05 06:47:56', '2026-06-05 06:47:56'),
(1095, 1, 'Uzx1GuSMQTZm7Zdht1PRpRaueM9ccZ6HbGUVhHZuAWKG8gyMjEX2VZf4AEVnfyonjBxy9Nop6r1Oqh1C', '2026-06-05 06:48:56', NULL, '2026-06-05 06:48:56', '2026-06-05 06:48:56'),
(1096, 1, 'sfq0L6rE30Ip0YV1LbFAvESgcHDPg8zPHG0m4ptUbLf4vlEfvjLgVIgHbMraOO2dC3M80kJUTPyJBqay', '2026-06-05 06:49:56', NULL, '2026-06-05 06:49:56', '2026-06-05 06:49:56'),
(1097, 1, 'F2ynV7iBv3gQukGrUW4cpCmgFhWpm1ESnbTuejjalz86zKpqW0WNqF64mXKfLL24ZwKZ6AV8k1H2uwuJ', '2026-06-05 06:50:56', NULL, '2026-06-05 06:50:56', '2026-06-05 06:50:56'),
(1098, 1, 'lmS14zuWAMCbfcWsqfOGCKXa0pCDjCaJ82DkDcacto4iHauP50iwC0u7aVKDHJzJZNzeXnunPl7La2tH', '2026-06-05 06:51:56', NULL, '2026-06-05 06:51:56', '2026-06-05 06:51:56'),
(1099, 1, '3kOakbc3XGXOUuU9qlwGlIpxSKyBHRTPp5ht8uFRte616YfheVCdiDp2pkcPhu1jhbGbbk6YD39rwZgA', '2026-06-05 06:52:56', NULL, '2026-06-05 06:52:56', '2026-06-05 06:52:56'),
(1100, 1, '2cKTgPHTF4Sk0e7uzniWL13JHAAxN3wihlS20xqeega74eRL1vTSkauKeG5IA9ngFtJZ0oAQjaT3LE8d', '2026-06-05 06:53:56', NULL, '2026-06-05 06:53:56', '2026-06-05 06:53:56'),
(1101, 1, 'idpokB13AMXZyftKEwr3TVX6D2JKwE9Nx0qVBsML4SFvPTSEbdYUTAGQzcwvHx8Gw4A8vH4nBUmJqvW9', '2026-06-05 06:54:56', NULL, '2026-06-05 06:54:56', '2026-06-05 06:54:56'),
(1102, 1, 'xnTvUYzpN7YVKzZmp5xjX0lHNNu8IiesBlPc1CCnOrxG7ANdBjsFPvL4NMHGsiCsU1LrmV7yerLYq8S6', '2026-06-05 06:55:56', NULL, '2026-06-05 06:55:56', '2026-06-05 06:55:56'),
(1103, 1, 'QJ3j9417FmxTkw4Cg3BbGp8hNbhOgPeNHNdoe0JVHXRAdg8OxcD5d0PfkhuvZq5tClrWetP0XVLEfAiC', '2026-06-05 06:56:56', NULL, '2026-06-05 06:56:56', '2026-06-05 06:56:56'),
(1104, 1, 'WtAn4ZjemSlm4GXDws3xEjVy5BGmtief0uZYA2VcAKfpmeDKX00Gab02H9LPjZrhZN0fvrSbMWx98b6F', '2026-06-05 06:57:56', NULL, '2026-06-05 06:57:56', '2026-06-05 06:57:56'),
(1105, 1, 'LmO99mijPOg9ZJxDcsLLU6w8vRjLWVyzOLa93yCM0KWcaRwCCHOxDnUw9mFRgLhse8MAfHxdjlcrBPVh', '2026-06-05 06:58:56', NULL, '2026-06-05 06:58:56', '2026-06-05 06:58:56'),
(1106, 1, 'g0oohMmMqsJI2gx5bp8YdsMElEeXvdFaaTJdEyJvsOr9I1Di91xftSiqaEFPsQqYUYfHfvqX3Vt3zsJZ', '2026-06-05 06:59:56', NULL, '2026-06-05 06:59:56', '2026-06-05 06:59:56'),
(1107, 1, '3uLj5OgxY8X8L4UzLgAELAa37HOoQlIKCE573kgCuCM9Sggl8nEE3tQOdeNpgYLFFGlDSXZDbdteGHFT', '2026-06-05 07:00:56', NULL, '2026-06-05 07:00:56', '2026-06-05 07:00:56'),
(1108, 1, 'iTCy8IW8RcfCQhwrq1IO7u0AevsADfprVy85OTlLlHJlVBA4JDAETlVzCp1ZPMVeWN6cJGBrE1RoUo8W', '2026-06-05 07:01:56', NULL, '2026-06-05 07:01:56', '2026-06-05 07:01:56'),
(1109, 1, 'taMFNZfnwhNXh4HaWyDKSMNTODf7Io09KMvDyuu8q6N3PZdXeOfOZmOx8pJMCKgm4Gz4yHo77cE3QMIy', '2026-06-05 07:02:56', NULL, '2026-06-05 07:02:56', '2026-06-05 07:02:56'),
(1110, 1, 'nsZ1NvHupZ76tSWhzynh2dV0kDDVEL3dRsq1YTW6HQy6OD0fu7SfEQlUnK9bY72AmWK4UQy9OUb9SXIZ', '2026-06-05 07:03:56', NULL, '2026-06-05 07:03:56', '2026-06-05 07:03:56'),
(1111, 1, 'WLKd4TYLbez9DibkjmFIpyRfLUQeb3AkUIZGbmIFhk2KAuEA9xnhWAtAi4GwAF2r2LEVayCSEZjwps4v', '2026-06-05 07:04:56', NULL, '2026-06-05 07:04:56', '2026-06-05 07:04:56'),
(1112, 1, 'bk0e8eCwZVOb3NjCxAOTaVer0imEwVEjgYsiSEGYUKBeaQuKlg3XknlKQO4RgKMFPsSGAWfZfVg4hDIX', '2026-06-05 07:05:56', NULL, '2026-06-05 07:05:56', '2026-06-05 07:05:56'),
(1113, 1, 'ajS4YzLseFMKwm9SarCsaBx9zLlHqTjTjuU5HwfcVLIGD1f5ECsJanUIKODmI4cgcDAokmwTUPiVoMNt', '2026-06-05 07:06:56', NULL, '2026-06-05 07:06:56', '2026-06-05 07:06:56'),
(1114, 1, 'ZIG4A7nG9DmLTc1RGQ9sNVbUGabUNLlIiKT63enW5s4FXwO3KN5xHF6MbWn9GHMVFlhauuoQ01jHmBZV', '2026-06-05 07:07:56', NULL, '2026-06-05 07:07:56', '2026-06-05 07:07:56'),
(1115, 1, 'p9usGyr7pfetHSgaciv0Cno3uNssXRrnv9XAO4TPjr5mhWqckBnjGy0xDtOGUGLccAVwf3vwoRYnm9FZ', '2026-06-05 07:08:56', NULL, '2026-06-05 07:08:56', '2026-06-05 07:08:56'),
(1116, 1, 'ehN43VVgS82BzxoSvzutUzNFtsNq6fn8sOlIHiA935M3pwPRoxGWALj4U8ed7WtD5fGTlW4IIJKeprnx', '2026-06-05 07:09:56', NULL, '2026-06-05 07:09:56', '2026-06-05 07:09:56'),
(1117, 1, 'O3w8oPBz4UeyLWEFBJUj3Ejl9gLK5hbAhz2sjbiyeyBjB3VVbYKFqgilXxridMYXHjMkFFrM31ct5xq4', '2026-06-05 07:10:56', NULL, '2026-06-05 07:10:56', '2026-06-05 07:10:56'),
(1118, 1, 'ypxqW7aFayt0tgEqt0BIkLX0uLKrkX0BR6y5rcV99udqe09kQ5m2YwSIYuQO8D7IlQp1bcbi5iDarkMD', '2026-06-05 07:11:56', NULL, '2026-06-05 07:11:56', '2026-06-05 07:11:56'),
(1119, 1, 'Q9qAZMBckhzzHlZvx2iNvBTGEFItoudbYcmx2nEr4ifZoVJiT1Rb2fN82S0YCZ8ngodpn98chYFLh3qK', '2026-06-05 07:12:56', NULL, '2026-06-05 07:12:56', '2026-06-05 07:12:56'),
(1120, 1, 'Y90rselCLTlzGy3xsGdzCAq7bpcyWKWvQBPa4Xt4BD0AuU6s22Eeqvf6pzj880PGqQrZtShpHE70zfEF', '2026-06-05 07:13:56', NULL, '2026-06-05 07:13:56', '2026-06-05 07:13:56'),
(1121, 1, '6hSdhfgyvfiUIdfjQwG07CexaheGBBg5ftnrqkvXSAfl1jJY35oOFHKgwL513CxKNkqO9jQDwBQhQVuS', '2026-06-05 07:14:56', NULL, '2026-06-05 07:14:56', '2026-06-05 07:14:56'),
(1122, 1, 'nMbSdbTWY5SvCLoZhV1SEc9MWCbFWmHR0xitfDjySxLmj6dHv3C1VMCNI7DnVw51qZOydV4nYuRwZ8VZ', '2026-06-05 07:15:56', NULL, '2026-06-05 07:15:56', '2026-06-05 07:15:56'),
(1123, 1, '3dbF1QJql33keWXiEsEde4PskgNOIUaYQgo1RJ7k5izpoxz8A3Ax9TplAGlgidYMUTklzBrsSalHNLKc', '2026-06-05 07:16:56', NULL, '2026-06-05 07:16:56', '2026-06-05 07:16:56'),
(1124, 1, 'zShhRfr5CKTU3zRPYYnq59ygbglMtaw2sje40smYXFYXyVyMPlYoo9l169KOk5El9kkyXZcTW6EsD01d', '2026-06-05 07:17:56', NULL, '2026-06-05 07:17:56', '2026-06-05 07:17:56'),
(1125, 1, '3xqwWCCzqFb8bNuNPrRzIMEh2H5csO0pvscqAFhv5ogpiXzjgWecWrqkjxuCEMy7hmbeNuUyD68fVMZl', '2026-06-05 07:18:56', NULL, '2026-06-05 07:18:56', '2026-06-05 07:18:56'),
(1126, 1, 'jBjOrwEBU57ND0CHBxTG3VkNmrGCMkvzc22muyFjXa5kEXngndWa6lZYyldWMQeA2V1gZ7WSYfEgOUdi', '2026-06-05 07:19:56', NULL, '2026-06-05 07:19:56', '2026-06-05 07:19:56'),
(1127, 1, 'VqXsaP9mrSezMpLnLmhGXPxRKt0RAVgScCRt99jpRAchTVjUqsxNG1ASeB0OpPyQBceVmmVca400edw1', '2026-06-05 07:20:56', NULL, '2026-06-05 07:20:56', '2026-06-05 07:20:56'),
(1128, 1, 'CIQn5xMh7flHVJQLg0jYh4xorWfNyNLIUSN3LpcbTFloP9r4lAK4Ihlu5kk2VK3mLOSIGcRLVEb0fYoh', '2026-06-05 07:21:56', NULL, '2026-06-05 07:21:56', '2026-06-05 07:21:56'),
(1129, 1, 'AOYuEbzcGo4A3hEg3eUvPLOk5SVQXZfrGLr3TjKVwMDug7zpaJATdloy92f2z3z0lSPBACdWyxQWKDnZ', '2026-06-05 07:22:56', NULL, '2026-06-05 07:22:56', '2026-06-05 07:22:56'),
(1130, 1, 'D5yY4JyigbCEEq2b4tptlJBqvhXZCeRjYbrSarm60qsJHQnSn0w1uw61LMBWOKmML7Cm6j3hoQUNAcDt', '2026-06-05 07:23:56', NULL, '2026-06-05 07:23:56', '2026-06-05 07:23:56'),
(1131, 1, 'Fd8SLhqfYSOdjry0iJuGGnNGo2osptBNKTpR3SePEvhDasaIH8JjPvOxvU7sOgFMx6iNfPR6kfDK0KEX', '2026-06-05 07:24:08', NULL, '2026-06-05 07:24:08', '2026-06-05 07:24:08'),
(1132, 1, 'Zx87D6z6VdwHympkLzihFmb58VJmU8vfjBbiWG9iB7KmhlVNjeJkQqwZn37ja8m8h7yLGRCZgNYPBm5n', '2026-06-05 07:24:56', NULL, '2026-06-05 07:24:56', '2026-06-05 07:24:56'),
(1133, 1, '6FAptCREjjJ6CaoRcG09WyMTTHxkYvOzoY7RqwE8DJYm2PrUACqaSNRBBXyrPh6m5gUqOa5Y8ZRuYSay', '2026-06-05 07:25:56', NULL, '2026-06-05 07:25:56', '2026-06-05 07:25:56'),
(1134, 1, 'fbQ9d1HHKfSnt3yYJ0NTBR2Sp2gpc3jnbcB5kKMuxJEX7FsHYoqUmPNQsviNODj9P8VvDS7U5pc6WFzf', '2026-06-05 07:26:56', NULL, '2026-06-05 07:26:56', '2026-06-05 07:26:56'),
(1135, 1, 'kdsPLEUdG58k4eQZxQIQSS8faxdEdgTBhjN2Fe1xlSP0XSsn00JWU0K3IxnB0gkTwC0W5Tr1cNHG8pMF', '2026-06-05 07:27:56', NULL, '2026-06-05 07:27:56', '2026-06-05 07:27:56'),
(1136, 1, 'DP5HaFnX05vjuFR6yuvm90A4LOMEmLyxQfUrAV6MgvtMV0D9y4vCZ9bhHs5InC7WTEOjZDtD2RVlsMoQ', '2026-06-05 07:28:56', NULL, '2026-06-05 07:28:56', '2026-06-05 07:28:56'),
(1137, 1, '183SyWMMsibwZ3DPYJ79rsE5UBXh5ZMZkuojPnTgRDbo7ucWi0UzKLeZikShXqVuyIsMyk03RBHrUEQa', '2026-06-05 07:29:56', NULL, '2026-06-05 07:29:56', '2026-06-05 07:29:56'),
(1138, 1, 'srEWBL6aEyWhZOasH3lIPfT7AMw7lbYcGZyuThUQVX71ZzE2lWSEU3Desk7kfH4ABNBgkDbCRoBSasAu', '2026-06-05 07:30:56', NULL, '2026-06-05 07:30:56', '2026-06-05 07:30:56'),
(1139, 1, 'QDpnTClqJo6VPJbqlqhaCz1a3PuEaOs74z4IMabywyC2775Ba9QrtQ64qd1LMCaFLM9YQebF3DKZaV6K', '2026-06-05 07:31:56', NULL, '2026-06-05 07:31:56', '2026-06-05 07:31:56'),
(1140, 1, 'uHaBDu8sM26i4FMUxGYRRUbb42B3WAvThqUBWWrvDPlRwsWUTtG2Do4yQijSpJwsL5aoji1NoMdwFJaz', '2026-06-05 07:32:56', NULL, '2026-06-05 07:32:56', '2026-06-05 07:32:56'),
(1141, 1, 'v6Y5op1HEUSpEEpQxU71hhw4eHHnJa19NPlxiGhUwuGj8sCpqhPjttJGfAcT4YrMAFxGs99m6wpzDewc', '2026-06-05 07:33:56', NULL, '2026-06-05 07:33:56', '2026-06-05 07:33:56'),
(1142, 1, '16I5Ag6zZV0VngFpEfjZpqzluwmUhbOhIDsjseJQCJ8e0cfFlvNftyx0VLK6kJd5CkUVUb4bPt2J8gH3', '2026-06-05 07:34:56', NULL, '2026-06-05 07:34:56', '2026-06-05 07:34:56'),
(1143, 1, '38G4ayTyTXJTMnm7GxGUMJEWVIvLu9TvSM9xbNTTUzIOTO4edDjIsh7dMeLG3bgTqaVXKcXUFV4VvoBn', '2026-06-05 07:35:56', NULL, '2026-06-05 07:35:56', '2026-06-05 07:35:56'),
(1144, 1, 'F9s6l7e5u67tExB3QZ1pDFg991mJEzVOOLeGYRJg7YnYPrbUmU4IxgVMTbH5hi3ifq2rr3lbCffoPJmn', '2026-06-05 07:36:56', NULL, '2026-06-05 07:36:56', '2026-06-05 07:36:56'),
(1145, 1, 'oT8QJ399qcCdEmF3n5TSJ1i1mSmfRDfcqsIcTdAAp3H4kiZNvWtZm6Trtbwx86cx1WVhrdvdrzXHS0Bt', '2026-06-05 07:38:05', NULL, '2026-06-05 07:38:05', '2026-06-05 07:38:05'),
(1146, 1, 'a7taCen9yWnibny0qLBhibOqjREV74WLloBDEVQqVPqhuFDsrZgwgo56SOggfYNbn846d9zXfdbNNkND', '2026-06-05 07:38:56', NULL, '2026-06-05 07:38:56', '2026-06-05 07:38:56'),
(1147, 1, 'YhRWOpNaCxFWW86sLdwpgGaIH6dxpAw5ZEu3lNVRGrP6iOEK7Ik3C5Ce1VOTlNwa31YsdK77lR8VoWu0', '2026-06-05 07:39:56', NULL, '2026-06-05 07:39:56', '2026-06-05 07:39:56'),
(1148, 1, 'kSRK2mwVEjbOJ5eQbp4Hlv6jbi7ta1ENqwWGHa4bNnvBytybyS7WWR5eS5JvqXD1mneHKsETYPITvWFo', '2026-06-05 07:40:56', NULL, '2026-06-05 07:40:56', '2026-06-05 07:40:56'),
(1149, 1, 'yyZOMljBAuGy8lxSvB0RdbfTCtBH5rgrEqJfdF2RHrLjwoAFoJZQ8B7UkhbEHyXvInB9XUqENd3hZ0yn', '2026-06-05 07:41:56', NULL, '2026-06-05 07:41:56', '2026-06-05 07:41:56'),
(1150, 1, 'cZJRTXzO45R1fmImtobEZY7iCqr4Rh1RQerbYTkS3KPxkZwI8zHNjqRh1C0ycehqjNQhFmrbbZRyVWgB', '2026-06-05 07:42:56', NULL, '2026-06-05 07:42:56', '2026-06-05 07:42:56'),
(1151, 1, 'soO20yvh07gw4DRwZ7JbAkic9WV96HsWLiIqeIP10rIeO9BkEpvDqNJKpCK1EhIEtWmVsohlBDb28iXs', '2026-06-05 07:43:56', NULL, '2026-06-05 07:43:56', '2026-06-05 07:43:56'),
(1152, 1, 'ZNXNA0iSW6hbTjkowDCcHdzU7UWpEirKSETaUpFl4I6App8GglTB1Q0j66PE4xLRX1Tvsud5DlWAlU0U', '2026-06-05 07:44:56', NULL, '2026-06-05 07:44:56', '2026-06-05 07:44:56'),
(1153, 1, '7oGVaMzPlzzeTtf4PBrsezUm1VmdxcxYvVwBkNrljzIYJ4Fs3ce64RrhrOpkIkKzxF4EVJtG124GDc85', '2026-06-05 07:45:56', NULL, '2026-06-05 07:45:56', '2026-06-05 07:45:56'),
(1154, 1, 't2dx90cE1FIZg97mOJYoMt8VRspSrzyTh5CiWS1mlC9ZjMRruVkt0Z59oXOqYDTZcwb0Dnmtk8AqytPM', '2026-06-05 07:46:56', NULL, '2026-06-05 07:46:56', '2026-06-05 07:46:56'),
(1155, 1, 'Wgp8rY06qELyXcX0GTh5cdzp0Uar0PDtomeAy09yNnbGqzrcipFHVwwVFgLhsytMjRHiwgTigzvTP5Uh', '2026-06-05 07:47:56', NULL, '2026-06-05 07:47:56', '2026-06-05 07:47:56'),
(1156, 1, 'cyjQJZLVB07c59azNuBHUrzMEiD2be1rkBi34efbJdrnRgvM9M6b2LRhW56xWBB18yiOd7b13Tt34IxG', '2026-06-05 07:48:56', NULL, '2026-06-05 07:48:56', '2026-06-05 07:48:56'),
(1157, 1, 'GMxinRnqTWH6ltE4Sw9adMiaANPyrjQastHtgpUW0iWnBLjsn9epA7fCNvARlDEl33Qt9xqoq74ZOI9T', '2026-06-05 07:49:56', NULL, '2026-06-05 07:49:56', '2026-06-05 07:49:56'),
(1158, 1, 'YQtrGGVhZ3f6dk5NGvVgl90HQ1TPdFmTNQwPDp5UCQPRUooDjWQxQTRd9CrRD2s5ZxXQWz0IuSxfZO36', '2026-06-05 07:50:56', NULL, '2026-06-05 07:50:56', '2026-06-05 07:50:56'),
(1159, 1, 'AynBgU5W38iV7hys0qemT6SCk8EGI0orxRoQJJ0vfqCI8EAezy38f1LXfKDgSgzZxXesijvTOzQlqSBO', '2026-06-05 07:51:56', NULL, '2026-06-05 07:51:56', '2026-06-05 07:51:56'),
(1160, 1, 'ehctWxPtDx0G0ENeDttXMZVwRoqKL1RlL4E2FaTtz9Qjz2nkJfmg4tCaZrctXEOHswPOWLxr7aUKXIMI', '2026-06-05 07:52:56', NULL, '2026-06-05 07:52:56', '2026-06-05 07:52:56'),
(1161, 1, 'D09ZJ0y1LDVtGkk74pju8IMy9R65seGZFc1I5Vvxzd8nmb43Nk0TOZvA9z99FtEdOcbc5rUdaL5ScI4g', '2026-06-05 07:53:56', NULL, '2026-06-05 07:53:56', '2026-06-05 07:53:56'),
(1162, 1, 'xPuEMtvymDNfNM46QwQFe7SrhWKbSEYUNcErzfbzuR3pdX5kI9QxepslkMNaKBL8JeYsx2IpIOKiZk2r', '2026-06-05 07:54:56', NULL, '2026-06-05 07:54:56', '2026-06-05 07:54:56'),
(1163, 1, '5lin0mjwKrW0v3zZP3qGcDGp65CNXTTgrPzMPJipQpZPs4iDQ6S4w4VMD6BwifbIYKdBjnKbk6UL71l5', '2026-06-05 07:55:56', NULL, '2026-06-05 07:55:56', '2026-06-05 07:55:56'),
(1164, 1, '04ZOfjuD4EKM22x35JXQWhQxT805HLT2fXtAXLSvWoJVVDB0uC7lQiX9K7UJJgJvorAqu6XKRHGTTdBd', '2026-06-05 07:56:56', NULL, '2026-06-05 07:56:56', '2026-06-05 07:56:56'),
(1165, 1, 'CyCS81wg7OH7ql3jFKvxJVi70SAhoFvoW8w4A5PXB1mr9KtnqQrcN17bnJrgXB5DxddO3Ff6Amysx0qc', '2026-06-05 07:57:56', NULL, '2026-06-05 07:57:56', '2026-06-05 07:57:56'),
(1166, 1, 'MYqNbODnGJ6w9RKBrXzQkpdf8xmx68VKNAV0m8m3l2rM1hOPgY8gsAY1pu8YCUbfp10l4IjY7gYm1TiQ', '2026-06-05 07:58:56', NULL, '2026-06-05 07:58:56', '2026-06-05 07:58:56'),
(1167, 1, 'Yxfc6nATAI59UZz8jbr4BwguxHE0mhRbk7a1vSkKS0izHEzZ1MEwONsZCzl9EgtLv0zbYUEMa8SmXznJ', '2026-06-05 07:59:13', NULL, '2026-06-05 07:59:13', '2026-06-05 07:59:13'),
(1168, 1, 'TWA5iArTKMMfnRgdrx1sGzGU98M3MTElQR2ywvb6UDp19vS7NoZuzVW2fbUjbIjd08kPqd3Pzpp6HQLQ', '2026-06-05 07:59:21', NULL, '2026-06-05 07:59:21', '2026-06-05 07:59:21'),
(1169, 1, '0w0JuKQeL5PRnxvc9juOzmiiHAEfq3nE1l8GSWqhulcBGhHYuMXXsFLLgi9GQzSK9Fp3KMh7cGFKAzob', '2026-06-05 08:08:28', NULL, '2026-06-05 08:08:28', '2026-06-05 08:08:28'),
(1170, 1, 'aWXptk9F2YFrQ7tgsSf0TbMzOYL7A1R1CzHhHs873ymhUdSU13NHf7avcTU6aq3k3Bdmku9v3bJ3bFMR', '2026-06-05 08:32:51', NULL, '2026-06-05 08:32:51', '2026-06-05 08:32:51'),
(1171, 1, 'MIfbQerfIrwErFxozcLmMaUy4YaGQsCYA7d3x8p0QlLMCp3UobxgiFXNN6Z3hCEj4I3YmohYpXYqa2Qr', '2026-06-05 08:39:56', NULL, '2026-06-05 08:39:56', '2026-06-05 08:39:56'),
(1172, 1, 'gT6UGS1Zsgcek1ZZX9FAiBf7kSxThwrt81SWn5OY4WpPF5EHoE4admxXPqbESYBFbk3LkYjg3UwOtl9q', '2026-06-05 08:40:36', NULL, '2026-06-05 08:40:36', '2026-06-05 08:40:36'),
(1173, 1, '59yCYLsgfRwmY0vcBex83aDVJR3XwVQZzJwtF7jNh8OQGLKbm8ypx2DehKDUALiOYef3moU9gVLBgPGZ', '2026-06-05 08:43:54', NULL, '2026-06-05 08:43:54', '2026-06-05 08:43:54'),
(1174, 1, 'HVagDrCrz5tA8p8yMzJRHYxX7PoyCWBUcrZsouCKJmML5Ju6ig3Rwijc0omj7O6xlBF1ZW7KuMtYjYl8', '2026-06-05 08:48:57', NULL, '2026-06-05 08:48:57', '2026-06-05 08:48:57'),
(1175, 1, 'M9hu2qi4jYkkxJthkpaCICwxP36tayvHQ8s9p2EOMbdLSN14rlAIdI1K1vvPdwANgFduHb8vHkarR1t6', '2026-06-05 08:51:25', NULL, '2026-06-05 08:51:25', '2026-06-05 08:51:25'),
(1176, 1, 'oQJscq6NLxlfsplQHItbkUMomKp3BsDVgiZW0hJGF5KafR38vgGPnwh3zWT3HKu0TaFiItXcxYCt93Os', '2026-06-05 08:53:03', NULL, '2026-06-05 08:53:03', '2026-06-05 08:53:03'),
(1177, 1, 'k7ENUIxm0juRTvAD7uqHXwC01G0ZL7kWxJ0EhKrwF5LONKO5V5ViFzEKRPdNUpJqrZWTElhWZBJIAmrG', '2026-06-05 08:53:04', NULL, '2026-06-05 08:53:04', '2026-06-05 08:53:04'),
(1178, 1, '1HL0D0QZS7YUKfsPk6Tjz3MRKFhsdUo2sRjWkyEP0S6Svh7617qkEw0waevISrYxFy633CB49UOpIhBq', '2026-06-05 08:53:05', NULL, '2026-06-05 08:53:05', '2026-06-05 08:53:05'),
(1179, 1, 'TSRbvmH15QdeTJScJsRFiIjw1fXrTYXygG94chhhdRY3uK2gmyxjjz6lTXGZrSNmoM7HM0plKJJPmFZS', '2026-06-05 08:53:06', NULL, '2026-06-05 08:53:06', '2026-06-05 08:53:06'),
(1180, 1, 'NABtNV9QozYafpNxXr6FUr0WBuBaHn4mwnaS9vcSdVmfHSkvDlwkdfMhEobaL5lNZUGaTAZ4SdyvzTyT', '2026-06-05 08:53:06', NULL, '2026-06-05 08:53:06', '2026-06-05 08:53:06'),
(1181, 1, 'zZvPLyGbXeTsznr8ZyV2C87wnI6QDhDkUMODYnMOTqNQibpOEHITNltcAP5dUhoXQ16ZQG2oxsrbOUzc', '2026-06-05 08:53:06', NULL, '2026-06-05 08:53:06', '2026-06-05 08:53:06'),
(1182, 1, 'mmtX19GZZ6hTOK6knonVuFkdSCbgFpIODTh3NQJEpGDCouAHZve8LJN6vbZd6dLcWshNh8U5zRirXA4I', '2026-06-05 08:53:07', NULL, '2026-06-05 08:53:07', '2026-06-05 08:53:07'),
(1183, 1, 'nzWvP0mxP1is7tRZJf4AIuCWaQTaJd7Lyfi7OjkwnAMZRKXR03dYjPRCMHSQon9xVIfbIeYIj8i8Kbwv', '2026-06-05 08:53:07', NULL, '2026-06-05 08:53:07', '2026-06-05 08:53:07'),
(1184, 1, 'G5TuU2vTnpU84zfPe8CJtW3J1UTHl9udeZHvaxc0ToJxJO8BPei0hRyo2ieMfRl0gWQMgSPiI2r7FzOv', '2026-06-05 08:53:07', NULL, '2026-06-05 08:53:07', '2026-06-05 08:53:07'),
(1185, 1, '18D7tBmHi8OP9Zzsqvep9g7EgizbqS1Vj7OWGv8e20tQWVWp0GERqbPF5dcUYpZabGlsZBCzLetZ9qBI', '2026-06-05 08:53:08', NULL, '2026-06-05 08:53:08', '2026-06-05 08:53:08'),
(1186, 1, '49HYpiWqUlvUd2fp7ZbgV9lQk83JOFdGAKdE7Y2889O8GVq3qggCDuiXMCXBjV5ePuidh4OCYclb4p2E', '2026-06-05 09:00:00', NULL, '2026-06-05 09:00:00', '2026-06-05 09:00:00'),
(1187, 1, 'YjsuR3gNGsELWBQ5TcK5tTWFmhbRYO679yPTcyXnbJR6su6Ye1NrgdwOMmprHOLC39QHDXqDxJ3ZzUiD', '2026-06-05 09:00:28', NULL, '2026-06-05 09:00:28', '2026-06-05 09:00:28'),
(1188, 1, 'U8TRcUxTBBZLQTOLHaC5LJAAzdLaYBPfGf0TlgbaZcC97laIPNtj8nb0xFmsfJgvgRphcXF2OrEiRojC', '2026-06-05 09:19:40', NULL, '2026-06-05 09:19:40', '2026-06-05 09:19:40'),
(1189, 1, 'fLLmvzDKyMz0K1AWTKSDudvZ63FGWeiKheInUDI58vPoSKupOStvhG1kvRbkn0C5kFH90pc3KUEyPi7g', '2026-06-05 09:28:36', NULL, '2026-06-05 09:28:36', '2026-06-05 09:28:36'),
(1190, 1, '5fW34SnPkpajD487hTYKJKw1c1NMv23UoMRWeYZXNXxiGwQ5OBy44ZZqUdDP5qQCE0VZ4MmGNsHZDodw', '2026-06-05 09:28:37', NULL, '2026-06-05 09:28:37', '2026-06-05 09:28:37'),
(1191, 1, 'GwflS5HOb5sgC7XPLBUVd3zTwDLz2wOj9yVfekDKBOFt7aJQVORWdZcdzxabIJuGxDidAtt8PmUM6Dqj', '2026-06-05 09:28:39', NULL, '2026-06-05 09:28:39', '2026-06-05 09:28:39'),
(1192, 1, 'QR1s3sc17eXAz5146gsEd6mvppVL1sd8y02BiQ0NxhsdyP7TJUqjCp9sXjuHhTnRbSdDeUCHHdQTJOY5', '2026-06-05 10:00:17', NULL, '2026-06-05 10:00:17', '2026-06-05 10:00:17');
INSERT INTO `totem_sesiones` (`id`, `totem_id`, `token`, `inicio`, `fin`, `created_at`, `updated_at`) VALUES
(1193, 1, 'WrkGBSh46v5NI2tqJ2S1TJmybHYGfhfuKmSnYVR2U2xomNzISKvCJV0RIkEjpIMBJ1bvjiEbXpPEW1JL', '2026-06-05 10:27:04', NULL, '2026-06-05 10:27:04', '2026-06-05 10:27:04'),
(1194, 1, 'RsdGMuPyj3T5YGa5gQo35Zg4zSOidkEq4YoXyVc32C12gOyDc5hm8MaB3Z1QzwLlCFxDEfR5SvgGSMfb', '2026-06-05 10:35:19', NULL, '2026-06-05 10:35:19', '2026-06-05 10:35:19'),
(1195, 1, 'MAAE3m61KfX8ejW8tsPZpvlD7KCijgeViaBpwM8WpHbsWe9m2AIyWPXPVW1G3FqwNlwR2FIchoZkoYmC', '2026-06-05 10:38:27', NULL, '2026-06-05 10:38:27', '2026-06-05 10:38:27'),
(1196, 1, 'D5Vs3mLBMNIY7fTn32U883aH8hAMaRimTbDIVs9zhqCF6cA3i4WvF3645h3kmUsbBapBdG4gW0WeNE1b', '2026-06-05 10:38:58', NULL, '2026-06-05 10:38:58', '2026-06-05 10:38:58'),
(1197, 1, 'gC96BH73Lof4nhOdY7Db56kKNhz2aAJ5V44uCxJpmLmwxiABe50GIpT0veVdaAd54RsCicgVLjlb3IGD', '2026-06-05 10:48:00', NULL, '2026-06-05 10:48:00', '2026-06-05 10:48:00'),
(1198, 1, 'VQqiEySQno4Tjn5MeUJJwmOBaGIy2ZZGvGW8QbOkWUyftPXYF1kKLM3RWYiIQdppWOpnlSXhVHjHzQ5z', '2026-06-05 10:50:42', NULL, '2026-06-05 10:50:42', '2026-06-05 10:50:42'),
(1199, 1, 'QNRbikx2sVoKwhQkTG7m7TRIGg55Tqm0vIawRHuWskvE802dcy0JfTBKYL8cbSV4nA6PS0clQjOTGPCt', '2026-06-05 21:20:41', NULL, '2026-06-05 21:20:41', '2026-06-05 21:20:41'),
(1200, 1, 'Wt664cAGhpPbgxXyXit28vWhPhzLohcEdIt5uGEicxFCC62zECHGk7KDujaEYJ0BGCraOFMs9JWwESVq', '2026-06-05 21:22:06', NULL, '2026-06-05 21:22:06', '2026-06-05 21:22:06'),
(1201, 1, 'T2zP3EI0YiR9N2pZtyJK9XBTP3qCvGMQVbXadw1ea1ZgTnAdnUy6ONxKuFCsu7Q6cBD38Y1oQkavJLzA', '2026-06-05 21:23:46', NULL, '2026-06-05 21:23:46', '2026-06-05 21:23:46'),
(1202, 1, 'eOp3XtD8U7sqk8sdG7YUiOisJr93DRMNRPOR50isCZ2HzRyW0gPju1Tdgrumwxa9YvuMPeUjpr0aPn31', '2026-06-05 21:23:57', NULL, '2026-06-05 21:23:57', '2026-06-05 21:23:57'),
(1203, 1, 'zKNarr9pcSMPxS9UA228fmo9Edq68TH0RVwHO9ZiL4fFbn7JUJ2ivu7lZhDLE7qbTcxb78VqpT26fH43', '2026-06-05 21:24:38', NULL, '2026-06-05 21:24:38', '2026-06-05 21:24:38'),
(1204, 1, 'Uhf0LranHFk0YIuHLIGr5MAyKqb9lT6mPLR1NKGCzDUGOE7yV71ZgrTbw8odYSFVFFAFzo3YNW5fTR7c', '2026-06-05 21:26:12', NULL, '2026-06-05 21:26:12', '2026-06-05 21:26:12'),
(1205, 1, 'lbuMutCEx3lvhipBN9szQG2v337868Zb6xNZ8hCyO886fzPiXoX9hSYDekS5jB9HFiy2dqEPEacEu9Jb', '2026-06-05 21:28:14', NULL, '2026-06-05 21:28:14', '2026-06-05 21:28:14'),
(1206, 1, 'vYEhv5YEKioErrLxahzmNdggDFzYflQ9HN6OOcs0YkXcFbACJu5lJtgK6f3cHx8rkQvgpBE4SBWH8it1', '2026-06-05 21:29:39', NULL, '2026-06-05 21:29:39', '2026-06-05 21:29:39'),
(1207, 1, 'EYli1dn1CL3ICYFCInaTjaTYNe2fcIWuzfA52c0IfxF4CskjzxgHGPlvRHPMgtU4usZCBlardnNb5pxQ', '2026-06-05 21:35:07', NULL, '2026-06-05 21:35:07', '2026-06-05 21:35:07'),
(1208, 1, 'rvi9bbfgliRNiYPDF2d6odiaQ0mI0TVmFPxyImlJFyPwewEfdnrfgrQIWswJmJNzGgGEtepXdKQg0wOg', '2026-06-05 21:42:06', NULL, '2026-06-05 21:42:06', '2026-06-05 21:42:06'),
(1209, 1, 'Pvcf0sK9t91T5UKGSyhJkyvLMKk7XCC4gVY36JNWaVFm8GAoKlbJ8EzePqh2rw1WFDJE4Q902CGQEmjo', '2026-06-05 21:42:46', NULL, '2026-06-05 21:42:46', '2026-06-05 21:42:46'),
(1210, 1, 'dDljJcBa3fFhll5FEHVFFfgks25clRafxX1iMqqZSlMPGlUuJNvammSSbBwXXTawmAzA1EEa3ypHPH3U', '2026-06-05 21:43:31', NULL, '2026-06-05 21:43:31', '2026-06-05 21:43:31'),
(1211, 1, 'IBIefYFq1WJRClh1Hnn2Jc66wchA2eavhb5Dnb11CPiG4FehnXbd4LoAohD042Lg3xdFc0toaSoyl1Te', '2026-06-05 21:45:22', NULL, '2026-06-05 21:45:22', '2026-06-05 21:45:22'),
(1212, 1, 'eXv2XsInrD6xtoZyHc8SKQG7KMATbp607nHyTTIgULyGfX9yNTr4hbAhNO5BfFcCk2fvKQr5Rp6sfARV', '2026-06-05 21:46:51', NULL, '2026-06-05 21:46:51', '2026-06-05 21:46:51'),
(1213, 1, 'IjMcxpswav0yoFVelkrvV0SsmsLBQTb2ggeOfhTwVIDd6NV8C79o9VJGYBAoY8OrwKJDwjX6I0A2g5kr', '2026-06-05 21:54:23', NULL, '2026-06-05 21:54:23', '2026-06-05 21:54:23'),
(1214, 1, 'JP2wvSCikYlEmJmBbp5OuR4G4iKAsUxzxDLMiU4bmFw2fQdrFQxpshwVTVeB9H3ek9M3mCzkRJDUAJsN', '2026-06-06 06:56:42', NULL, '2026-06-06 06:56:42', '2026-06-06 06:56:42'),
(1215, 1, 'ByA8AWxJGAvKUIGitZSKOwUVAW3FBfM4xmoWfJq3cmOCnzFS3hHIUxJWCxiey43byAONMEWTZt5tRo6O', '2026-06-06 07:42:42', NULL, '2026-06-06 07:42:42', '2026-06-06 07:42:42'),
(1216, 1, 'wNyYjinsac7VQycvRCGY13QQRjMe5MtG3Ad90nWTAoMbBvsJFsAMnc4JGKa7C93jjO8fU3jD6icgD33N', '2026-06-06 07:52:27', NULL, '2026-06-06 07:52:27', '2026-06-06 07:52:27'),
(1217, 1, 'G1yAz3EIzbwnoCcYd2sC5pf0RqYZAFGsfGC7P1cm8IqJrHNlwucWSFiN25qtAA6DRa5HlXtwYHEfBUYO', '2026-06-06 08:09:21', NULL, '2026-06-06 08:09:21', '2026-06-06 08:09:21'),
(1218, 1, 'AIkx6hWDEIWdZF3AThzQHCluczkWhfHiLoSgsJ9UejULwTO4kdhG1XxzzXW0SFeZsJSZ2KJBPPee3IWh', '2026-06-06 08:20:55', NULL, '2026-06-06 08:20:55', '2026-06-06 08:20:55'),
(1219, 1, '1vu1polMjhzZXbp8Tc5qsuWGYugC2FSF8BA9et5Achr15mhGbg65ZbFsm8GGwp1yI0IfzQjbjSpjusBt', '2026-06-06 08:27:57', NULL, '2026-06-06 08:27:57', '2026-06-06 08:27:57'),
(1220, 1, 'ByQN3LXZCjjq4BEKAvpwPVBENMcYcGGpwerKbdkurgkukmJVnwlpGM7piKpniCyiaxrRMhezD0QyV6rR', '2026-06-06 08:29:28', NULL, '2026-06-06 08:29:28', '2026-06-06 08:29:28'),
(1221, 1, 'iPE65QsaTRegJTicuujAAxbJDkXxD3HGgWAzeVlorUT6utsAcZcho1jsgGEAKZCx94nInW9FcyWhUXYc', '2026-06-07 09:24:43', NULL, '2026-06-07 09:24:43', '2026-06-07 09:24:43'),
(1222, 1, 'eH07zuhybJlduZesw3XFicoFaWPpKAsXRBOcEyMNgXBTtmHz6WcLYGlcKZJTZ4zCZXkEY30S1ocUxatb', '2026-06-07 09:53:39', NULL, '2026-06-07 09:53:39', '2026-06-07 09:53:39'),
(1223, 1, '4KJGKy21kE7BrMTE0zrQGdf3h0pJordssRDzAt08g5GS29VQsteJOQHeJYTHderlFIbcMVRIu3vkQbKW', '2026-06-07 10:03:15', NULL, '2026-06-07 10:03:15', '2026-06-07 10:03:15'),
(1224, 1, 'jaDTK8aRmozBHa4dGStQKABjYEN3l3Lfw086Cd5b6kF557kJy4UaQDeefAxmLb2ZNrSnixEuJIXzGAbo', '2026-06-07 10:10:16', NULL, '2026-06-07 10:10:16', '2026-06-07 10:10:16'),
(1225, 1, 'ljJLEQnXAKGeengzHC7KHk4zD9sw3xf5LGTf6qs8kXXCqkpj8lT0z2C2F9utpr4lE7saClgrGFp9WRNV', '2026-06-07 10:32:05', NULL, '2026-06-07 10:32:05', '2026-06-07 10:32:05'),
(1226, 1, 'btway11pUGViZDZLbiS1bFDsH4jrwNwfKalfRMxJVbr9DFIVHVE2KSBBQD7L1LqSfnjOa07YwB9QLnz9', '2026-06-07 10:36:07', NULL, '2026-06-07 10:36:07', '2026-06-07 10:36:07'),
(1227, 1, 'LZpojQZIxtklJ3srcGJrpXbdKS4m3j3K0FYz6Dp2HGhGkDaUic8uKMGZXTFNnBXzxGS3GMzXmMnruLt3', '2026-06-07 10:37:00', NULL, '2026-06-07 10:37:00', '2026-06-07 10:37:00'),
(1228, 1, 'VIaf6Dho9Iqk8dmR9rKAHwBm2fqbf8vhLo5gqmqQLAe9NHebCWsfmAOFxNlcwvdPTt7o7jHJdylU8VpS', '2026-06-07 10:48:56', NULL, '2026-06-07 10:48:56', '2026-06-07 10:48:56'),
(1229, 1, 'eAsw4h2NuKnxzRnmRZ8oHtAt4ujhBqGHOeBNA0QTcusTz0FFnEIEpEdUyM3iSaWEMN82g9fmQOQ4v8US', '2026-06-07 11:11:41', NULL, '2026-06-07 11:11:41', '2026-06-07 11:11:41'),
(1230, 1, 'a51H54QFWCmeMFnVYRRoyI0PDFy6ZZEU6Y4Q5og0VOlQm4oy1NARnBu2i1xTExdVVTGkFl21zMx0jMIE', '2026-06-07 11:12:25', NULL, '2026-06-07 11:12:25', '2026-06-07 11:12:25'),
(1231, 1, 'Sg9kmBuYgAH1NtbVKrBo3wpBGoLpO4vUVpJg76ENm0bZ7nDjJABbEF6ia1p1lzeHIhqQhprEVGIjlZ5u', '2026-06-07 11:16:14', NULL, '2026-06-07 11:16:14', '2026-06-07 11:16:14'),
(1232, 1, '4sPbA5Y2w1IehhElSnnnJxxwSA17LBcrM2DdYHehcWImGEqjYc3MqWheinlcIxi4tphZfaX1oeK1nwn2', '2026-06-07 11:32:47', NULL, '2026-06-07 11:32:47', '2026-06-07 11:32:47'),
(1233, 1, 'Rxri02qDbqWirWJHROvtW3sunZh33yXgTgDP8ONkrR8F2pQssxvPcGPYddEV7RSlWyogiUeTTCX0I0HK', '2026-06-07 11:49:36', NULL, '2026-06-07 11:49:36', '2026-06-07 11:49:36'),
(1234, 1, 'Lw5UaYFSNjPYohkwbp5N6pL6ZwbMoIiOe0mtfCtexbbgCV0gJPp8tkIknWWzNReF1h57RjxHltGGHDyD', '2026-06-07 11:51:07', NULL, '2026-06-07 11:51:07', '2026-06-07 11:51:07'),
(1235, 1, 'z1jRgKakHTRaJRm7DevcoX8ioQ4GPHUiLKyWXDDmUlk0yDnKhPjZL9PmElDsR5kg77pWTe5RNg5lEcj6', '2026-06-07 12:00:37', NULL, '2026-06-07 12:00:37', '2026-06-07 12:00:37'),
(1236, 1, '62vOFdlc4jYhiPQwnUP8p5JI4rM1qCrnCnf0P5Cr4U0rtxzhisexUsjlJYmLQyeceyE6S8fUlRKQeNcU', '2026-06-07 12:10:14', NULL, '2026-06-07 12:10:14', '2026-06-07 12:10:14'),
(1237, 1, 'vW1e79m0TDQSK50RU4xnLmDNNxKp01KT9bZoO6s6MAKBeDrVkEFas7ENs2OGYttCZv5SKUy9NgSDFf4J', '2026-06-07 12:11:55', NULL, '2026-06-07 12:11:55', '2026-06-07 12:11:55'),
(1238, 1, 'PMh021OCy6pAVUj0VkkeNnkvONkZKrCVhFd6kvObBUcufOUhuQdZbhxh53Pr684VAteBrEwL4plTAbkg', '2026-06-07 12:12:13', NULL, '2026-06-07 12:12:13', '2026-06-07 12:12:13'),
(1239, 1, '56DjGCeHa22KNntd3AcBfoTt7y5SHhS01AY4FkXV5zKnUrKv1osoaQUCyrLZ5PJQH2cgayLEVPOwr6Uj', '2026-06-07 12:27:43', NULL, '2026-06-07 12:27:43', '2026-06-07 12:27:43'),
(1240, 1, 'NYaEVpEiiclTSAJd9fc3Wo8ShhNGWKp4I00iJkq55a0BATTa0DZxLmDTQeEuLKHNdOlID6xqmqtNshVn', '2026-06-07 12:32:51', NULL, '2026-06-07 12:32:51', '2026-06-07 12:32:51'),
(1241, 1, 'occFRuSccebtSRBZdXGgcIm2cZxYtEuDALjMOSwPJHMVjZr0FXvOcvwpWHzHuWRRgPOivTRa2jXERhBC', '2026-06-07 12:40:35', NULL, '2026-06-07 12:40:35', '2026-06-07 12:40:35'),
(1242, 1, 's20BS1cXgajuH89fDxoiTKUqtoDYZLFFLt1VXYAsMJfRTmIe8A3k3tOIFdy0tNnTh3qH963dPyx1wyR8', '2026-06-07 12:45:20', NULL, '2026-06-07 12:45:20', '2026-06-07 12:45:20'),
(1243, 1, 'r3RQ6GCBYXhISuY1pcrMXL8NcFp5jMCEOXmeJ0o5jPNgQuJT8lvSsqDo2CaA5W0M5E0svj1ATuDbmB4P', '2026-06-07 12:45:55', NULL, '2026-06-07 12:45:55', '2026-06-07 12:45:55'),
(1244, 1, 'dntMjYPb21zTN7d6sGKnL9oZKlNyCOVwveuKcAU78YszXzNZJeJDQ5hpHC6xcigS3WziJXaxKxHzn0nI', '2026-06-07 12:49:05', NULL, '2026-06-07 12:49:05', '2026-06-07 12:49:05'),
(1245, 1, 'SZyP0VbuhzoZp46L1whWD8Lgx18ykhfkhF6CIvJbs9lVdJEAVfkNpgBfnDDRhgzn8Ky0GPPqlpSeAu2d', '2026-06-07 13:07:38', NULL, '2026-06-07 13:07:38', '2026-06-07 13:07:38'),
(1246, 1, 'nsSK6erI72fhepHjewiTMw8MiAja6aDC870yAwnKEqiYpzZiMrIW0fPmxjz5hlyOu3PYlmq724J4n5p1', '2026-06-07 13:10:33', NULL, '2026-06-07 13:10:33', '2026-06-07 13:10:33'),
(1247, 1, 'WFGPQxqqRhNESeotiDr7JvabsZITnnSgHydx3eFmRnfSpuMG11CyArE3sOeipeP5ys6VUWzRs7YFq0Zm', '2026-06-07 22:05:12', NULL, '2026-06-07 22:05:12', '2026-06-07 22:05:12'),
(1248, 1, '4bI48JBqF90UuVIMbGQjWte30czAH8Sl1EfyDtlpSzYGilbMz701oCfjf4tD6Dhnga2LoXvgwDbhSZQw', '2026-06-07 22:09:54', NULL, '2026-06-07 22:09:54', '2026-06-07 22:09:54'),
(1249, 1, 'aXoFunai0Sp5Uy3gRY4eQORu5TUDzZ6RhOsCTrmW7sxQVBnuJVTYwcJM2DUmMJNItMi1SOZxde8gpNEW', '2026-06-07 22:12:54', NULL, '2026-06-07 22:12:54', '2026-06-07 22:12:54'),
(1250, 1, 'u24MihXVb7RFAkZjqyBny5E5msp7DhlOAoPWjh1etFElte0QmQZFRrzmU9sOUZIouRrXJl6TaTrC6n4s', '2026-06-07 22:15:09', NULL, '2026-06-07 22:15:09', '2026-06-07 22:15:09'),
(1251, 1, 'QiLWGu9LwNrvmgMqWgjACxWKpLAYKE8h2Rkowofnpm3upkcSi9tz3pt3YykUdf13oV0ezJbmJTyuZNVb', '2026-06-07 22:15:48', NULL, '2026-06-07 22:15:48', '2026-06-07 22:15:48'),
(1252, 1, 'IFsMV9i1qmNcvVh8ScwqBRhiY2k9g00NDh9FJoh9X3Wit90Dlko0e17AaBQpT73debSa9TcIjHV12BH5', '2026-06-07 22:18:57', NULL, '2026-06-07 22:18:57', '2026-06-07 22:18:57'),
(1253, 1, '5FlqFdiddSpAu0T53WfNLNrUbIsw9BuiRhpCOIAFd4PsnS8F3tfdLfMLNJCIt5WT5KkO203PS8cnYWgb', '2026-06-07 22:28:44', NULL, '2026-06-07 22:28:44', '2026-06-07 22:28:44'),
(1254, 1, 'OGcKs9SlZKAKMy5KAKkzCjwnGqELsNGNGkwsbtqJMPmhNEtJghDxfWSlwu73ExHzQP0PwGiKlUwVxHCz', '2026-06-07 22:31:03', NULL, '2026-06-07 22:31:03', '2026-06-07 22:31:03'),
(1255, 1, 'nOSfF820pW2QlFoR8plkFQHdXzEoTLAVGPMRAO3uXWlEys2LPE8gs5CsX0i9cWutWEhbt3GZYrC3kgGY', '2026-06-07 22:38:32', NULL, '2026-06-07 22:38:32', '2026-06-07 22:38:32'),
(1256, 1, '0ep7YermPVJxxJR2XRnxwcs2TNVG6DbhQaHtLyrY06nh4MRqN5biX5lXIVLLxkXzQ0IZt8PzJWcLFr1G', '2026-06-07 22:41:22', NULL, '2026-06-07 22:41:22', '2026-06-07 22:41:22'),
(1257, 1, 'vA05WezQJtScdPxLYrYqaKFlJImGRRp39lAvRyCizeiSkq3Bypp5QaqjxLEzD9XCIe9oj2nfE7L2jHo7', '2026-06-07 22:41:27', NULL, '2026-06-07 22:41:27', '2026-06-07 22:41:27'),
(1258, 1, 'DkEX0f887d8w8S8EDwIGvkUErcrN1rJCaz7NXT4adPReTRKQBLwcvahCNqbwuRSSlW8Q3BoXr1Bqwyzq', '2026-06-07 22:41:27', NULL, '2026-06-07 22:41:27', '2026-06-07 22:41:27'),
(1259, 1, 'D5gHIb6SjBieSK3YcqjiIKw3tqzF7KqfLmjEr32JaC8k0LWFWsrUrUxpkbefEvyrkPf0jutsDtFZG0AO', '2026-06-07 22:51:53', NULL, '2026-06-07 22:51:53', '2026-06-07 22:51:53'),
(1260, 1, 'H8xJVde1sBa0VaSTN74x67I0i0iDtFxyv5VheVATESsfz6WDB5RsgcunQiL0UIAS6KoIEm80uZZm3eZG', '2026-06-07 22:59:09', NULL, '2026-06-07 22:59:09', '2026-06-07 22:59:09'),
(1261, 1, 'K1uQir6S72v9vI2fkrNZQJn1KEKBRsRgRcliegM3oz4mq8exa8DQdGiXaMMr6GZRQUFjzPQsQw207l0V', '2026-06-07 23:01:18', NULL, '2026-06-07 23:01:18', '2026-06-07 23:01:18'),
(1262, 1, '2GedHL4C9sUOwMCJNfm7aMlRyvm5IuLUNnNtFl2m7X3se2JNAlDwyK44C66kRX7DKiSyXu0rPppPy2Is', '2026-06-07 23:07:41', NULL, '2026-06-07 23:07:41', '2026-06-07 23:07:41'),
(1263, 1, 'zTpuP2mo6lCs098GPJXbshXXVv4ZaWl4t7GidmCP3Ahs7GPuIMGSeUBUEwn37t1dSbWxKcvUyqvqwy4h', '2026-06-07 23:37:27', NULL, '2026-06-07 23:37:27', '2026-06-07 23:37:27'),
(1264, 1, '80lw6PEIogKoqC5CH7aotLlWE5JAFICZXRL8ftYSGZof3BvIhYLR0SqyYAqVIZ6YdHQ9yl8TYz6PPp4d', '2026-06-07 23:37:31', NULL, '2026-06-07 23:37:31', '2026-06-07 23:37:31'),
(1265, 1, '3z4hUGrv2XxUHnS1MWS6h4Z4qsZtFpkgQeYE5ThrAuXiqj1sL2Fda3dAytJoMXnmdWpwevcLsfkUDWdR', '2026-06-07 23:37:32', NULL, '2026-06-07 23:37:32', '2026-06-07 23:37:32'),
(1266, 1, 'GYzSJjCugsADnNpkooQN6rzctu0ERS0n1W03swydjgZ3jwKT1b9CVr1bPsKQBlwACpKbZlET2A5HjAAL', '2026-06-07 23:53:09', NULL, '2026-06-07 23:53:09', '2026-06-07 23:53:09'),
(1267, 1, 'g5XAap6OedFiqkX1EIHEucdLcroqryWzWRpGBEoksKLymUn4Qg5JhpOho7FnfUJR3gnUrWTzAGqP4hc5', '2026-06-08 01:08:38', NULL, '2026-06-08 01:08:38', '2026-06-08 01:08:38'),
(1268, 1, 'slKMfqMEEOx0jLg5OzvcQLdfDcgctMZQKZ3Rr8G3JAf0cOzltE0Z99mcTltD95tCry58wh7cY5XwrtVA', '2026-06-08 01:10:26', NULL, '2026-06-08 01:10:26', '2026-06-08 01:10:26'),
(1269, 1, 'uL39gdxxWt3EMk9CxlXaV9vqi0eEn0HubrunaXd2wKL2NABEIrtx58Lbata5sNdJSTgPYPuZ4rtnmCwr', '2026-06-08 01:13:09', NULL, '2026-06-08 01:13:09', '2026-06-08 01:13:09'),
(1270, 1, 'pgaL64oMtVZhMiX5NOt9MhNLmJU7lgccKSbhQWW4ZufyooetGXm6qp6yAupVAr0dZ4A5F8kYwRxY8G9U', '2026-06-08 01:13:22', NULL, '2026-06-08 01:13:22', '2026-06-08 01:13:22'),
(1271, 1, 'zumkVIO5xKdgyh8yywfcdQLI94QrItEd1K5XT1dZhsQZqCRvdZAeZJ6DncGHAC8jqwjKV6HciJJk1vN0', '2026-06-08 01:14:44', NULL, '2026-06-08 01:14:44', '2026-06-08 01:14:44'),
(1272, 1, 'CsogirxAOeahaa0q4DThcuA1TW7tbACPBJOKUb27VJ93pLgJ5zowGv4LcsZBKPt989w5H4Uc2OmgsulM', '2026-06-08 01:14:46', NULL, '2026-06-08 01:14:46', '2026-06-08 01:14:46'),
(1273, 1, '2JuJKIt2erXpLAaHsPFeBuSF6xNmnVVAmMv7qilV2DEWpeIJyFaJVSFd7n8IddKu6MfEjCND687l1Yu8', '2026-06-08 01:14:51', NULL, '2026-06-08 01:14:51', '2026-06-08 01:14:51'),
(1274, 1, 'CqTLSbhTsE9lthCgqwPgG9adB6zNSvFv6WWkR5yJuJysAZ5KUwsh1ixeCAA4vS5XQAFK7UJ99xPU047K', '2026-06-08 07:18:03', NULL, '2026-06-08 07:18:03', '2026-06-08 07:18:03'),
(1275, 1, 'Ooc45hU3TSFrBK9zPRZRACKvPM560FXv9fpiCOyKtcAGROcbGiwgc2JKK0dFoODFu9aAX5dxPzFkBUNK', '2026-06-08 07:19:41', NULL, '2026-06-08 07:19:41', '2026-06-08 07:19:41'),
(1276, 1, '5xSBIZdwnTPNsW41LdVVlYUQ2yISS50flfIDUzjVTWKUAQaZfrfjRuPe5CxXOKDd7pgpJeP8xNq8U9O4', '2026-06-08 08:00:49', NULL, '2026-06-08 08:00:49', '2026-06-08 08:00:49'),
(1277, 1, '7U2j55EgQ7dtG4wdZcnCbOqFzVbkFgeGBSoPhvHxPyuBmWjU7iXeRQGaGno26oxI9wcwXNA7EPnYmBYI', '2026-06-08 21:25:13', NULL, '2026-06-08 21:25:13', '2026-06-08 21:25:13'),
(1278, 1, 'yHHP5Ea1tDf87ZhAM5PlJrogV53BTwfAmGUQJlJX2W8ioMxxmnCpgUCpBeytRkfQcaOND0LRqIcfpZvs', '2026-06-08 21:28:31', NULL, '2026-06-08 21:28:31', '2026-06-08 21:28:31'),
(1279, 1, 'SgktpCEKt8vKo9z7QtKewUTjBxyW4TXTSPbZxGigjKP4zKrumxxRYN8J0gVNInocCRMOLp64asOmgl5t', '2026-06-08 21:31:28', NULL, '2026-06-08 21:31:28', '2026-06-08 21:31:28'),
(1280, 1, 'DQlSmB7bH3DMFzw6VXUj1USJvl61odEJRJmqFe5sxI979sYYscnhjiOCAvurMGIUSYt60ST32vIuHIdb', '2026-06-08 21:37:17', NULL, '2026-06-08 21:37:17', '2026-06-08 21:37:17'),
(1281, 1, 'D5lzwkSlDGhFne4zBsgnJ48QKGugg09oUi6wME2IEllaytHy5nY7bTF9pIgd2bMD1gs43VyNsVgKM7yz', '2026-06-09 05:53:33', NULL, '2026-06-09 05:53:33', '2026-06-09 05:53:33'),
(1282, 1, 'DafogMlJsfmihhdkny53dqB6UJHttvdy5DYTNYc4wkj72GOePvrJSvVkNk9l4funHeSjSu4XSvgUViLT', '2026-06-09 05:57:50', NULL, '2026-06-09 05:57:50', '2026-06-09 05:57:50'),
(1283, 1, 'qUlVGIlJMZhfDXdEFyz546ncvP5fE4dhPvm9ATDv1j2UZXHUPmKXgRJXXq2eayVBGoidL2h5cSTpclLy', '2026-06-09 05:58:56', NULL, '2026-06-09 05:58:56', '2026-06-09 05:58:56'),
(1284, 1, 'CdEQ5ZjkkUOH7lhbSpZFnUtLRNl5ylx1Xx0dwOvA9cIMN1wdjO4fRkxRDuonBmZCYlAsiAWRxuqfjeeW', '2026-06-09 06:01:20', NULL, '2026-06-09 06:01:20', '2026-06-09 06:01:20'),
(1285, 1, 'X6OXny4UzlFl7TsumaoNwbWOH6chJn2b0OP4le35ZRzmkZ5BSWiZPkDxZRPh9XbTjbCihc6JTI05Ojsv', '2026-06-09 08:01:06', NULL, '2026-06-09 08:01:06', '2026-06-09 08:01:06'),
(1286, 1, 'YCR1vRen2oarnOjiZlkypdj73JWfejCy6xKBfb2bBrVAgVIUpdzMtJ3tpF1RdqJo1aiPtSgPhmilaO5f', '2026-06-09 08:04:31', NULL, '2026-06-09 08:04:31', '2026-06-09 08:04:31'),
(1287, 1, 'C7is4F921pbamMKZwlRzQTukCr5aVThfPV8ygLBiCUryKfc1DltZS68lvzcdEWXrpRkyQyr9zro7ohFJ', '2026-06-09 08:06:10', NULL, '2026-06-09 08:06:10', '2026-06-09 08:06:10'),
(1288, 1, 'eJJTmwG2JVHLqzR85W2amTzJYrMeS5A5aJIR1VemtoUvbPUnnLE20rtwwutWTLAr16vdYjZSSgi50RBd', '2026-06-09 08:08:26', NULL, '2026-06-09 08:08:26', '2026-06-09 08:08:26'),
(1289, 1, 'KEryXsQ3QBWLaflQucwDyPXehLlPM4PP4v5b9xYhmrtHDYtuxyVijlfvbg4x2Cv0nlNjXkRFxvsHmVaR', '2026-06-09 08:08:42', NULL, '2026-06-09 08:08:42', '2026-06-09 08:08:42'),
(1290, 1, 'fT9lM9J2j1RuQfCZ5GHFTTrNfLgw9INg50ATuoqoDusChJJs2VlkXDJVAFjG3pl27wtjUvNXU7sDy5M1', '2026-06-09 08:11:15', NULL, '2026-06-09 08:11:15', '2026-06-09 08:11:15'),
(1291, 1, '4Vx4YNsmFNMFcEgBG0Zrr1oKUZ4P6QeAOMzTPee3alMuhwkfPKqHaIius2fMvaxHwR3m3wy6o3YXibwM', '2026-06-09 08:42:47', NULL, '2026-06-09 08:42:47', '2026-06-09 08:42:47'),
(1292, 1, 'SfS5BjRsNOW8vGe2tHpKQpBMmxnFncT9gUQg3S8nOlefdfaVk76L8K7lTIt55nZuTBKzLVR4U8fXDhGI', '2026-06-09 08:42:49', NULL, '2026-06-09 08:42:49', '2026-06-09 08:42:49'),
(1293, 1, 'VZQ85TKv6r5ZJfV56whsDKrP1HfOsiN7uGQ8yu27sFKK8MahxY20GiF5hhEJsSIb202MWqceeBqL6KYg', '2026-06-09 08:45:30', NULL, '2026-06-09 08:45:30', '2026-06-09 08:45:30'),
(1294, 1, 'KGGriZ44jVkLeLjG9VEgSAfikGAbt5je83cPXyMJMbAPnZ0eQcTdmrjhYApQaKPM1EgGDVlKivOPjPg6', '2026-06-09 08:46:27', NULL, '2026-06-09 08:46:27', '2026-06-09 08:46:27'),
(1295, 1, 'Luo64WjPDHPRwYv6HgwyTpKf5yQNjimXSXyHyHPbnft6NzfNG4gbGYuWFIdCYnrVbUubGW9z0t2GmLd9', '2026-06-09 08:47:55', NULL, '2026-06-09 08:47:55', '2026-06-09 08:47:55'),
(1296, 1, 'cdZn40T3HGDMQoEleighsAl2yn0JGv2oXsY28r8N6dTnvnoQ7Y3HnRLF71YD4Pu3PE2hRnq7OTrlFUBO', '2026-06-09 08:49:12', NULL, '2026-06-09 08:49:12', '2026-06-09 08:49:12'),
(1297, 1, 'f9xNznlEFew7YsDiVbPh3sn8ACURSVz0O6VpZsT3bWzNXscm90SUD7IcVyUanJWl34GHGjOLeZ5ZQIHb', '2026-06-09 08:57:14', NULL, '2026-06-09 08:57:14', '2026-06-09 08:57:14'),
(1298, 1, 'tcS7374pfiLi0CObVdwh0DW1Xe7TNPnfrKXLzgS4PGHy2UfjA1Y9oTKg46BcUfxtDYCst2XiJ0IR7Ywo', '2026-06-09 09:00:06', NULL, '2026-06-09 09:00:06', '2026-06-09 09:00:06'),
(1299, 1, 'QoAdfFMbF1NKPhTWdlZjPVHEeQW3HlZoeHsU70c0zA1pU8dqDza1pmJg3vz16kYYXq4XgByFlL1hpbFW', '2026-06-09 09:11:39', NULL, '2026-06-09 09:11:39', '2026-06-09 09:11:39'),
(1300, 1, 'seOEwa1J7wqnFz5G5zVDiI4DWiRI0IrqlOpMErP1ACs1U5thDMoHrOmupgS8el1TRErvPGv4yNjcQu5W', '2026-06-09 09:23:05', NULL, '2026-06-09 09:23:05', '2026-06-09 09:23:05'),
(1301, 1, 'e3L9IuyuwxGqWOjhSQE7KPUvDhYtprWWNYIqGwQaYv9nlGoEZlLhB5ule2DtRRYeTGa9fuBSTmQGxI2M', '2026-06-09 10:00:59', NULL, '2026-06-09 10:00:59', '2026-06-09 10:00:59'),
(1302, 1, 'ANmWlmWMIUVVMPZqqfpVAGw9YaFwCfdzo5CowJHrPv0RP1p6aOAKmSbxgxzyWs52Az76p28gxcbyqMJp', '2026-06-09 10:19:10', NULL, '2026-06-09 10:19:10', '2026-06-09 10:19:10'),
(1303, 1, 'M6V5taPY8XIMWbiXCXVfiy8DggXpNNGoqksQuAfayAWBa8pWuzdR6AIAJTnv5eOnreGk4AwcwdUEXBuO', '2026-06-09 10:22:18', NULL, '2026-06-09 10:22:18', '2026-06-09 10:22:18'),
(1304, 1, 'nUyRoNnVrCGVZWyGoXiub4yxhgADDT7GaKycxdUDScjNXJTj3Jse2DYTIWlR8ENyJKNhCr0b6m7ToeM7', '2026-06-09 10:22:19', NULL, '2026-06-09 10:22:19', '2026-06-09 10:22:19'),
(1305, 1, 'LNoTfQYGSkrGGlQcgaNEb2MzBD2s3N1ZbVEBjamGyF5HR9EN61QPXeqpgDMuaGjdobObeqJkt68pMFUP', '2026-06-09 10:22:19', NULL, '2026-06-09 10:22:19', '2026-06-09 10:22:19'),
(1306, 1, 'lPs3NYPJoMUNb69m9QEBD2sgGYpBc58LN3G5MKRaqiPCsh0IItnBnFdf4GWVL7LL5fwRLmb4WIAppVh1', '2026-06-09 10:22:20', NULL, '2026-06-09 10:22:20', '2026-06-09 10:22:20'),
(1307, 1, 'ibrcF4ETkcxRE6NIv4uHPFtH4iMD2Mzx7wDDNZmj6DK0v6kqNVwX0A2MBtDDydUsxLvD2B4uzDHHUrt4', '2026-06-09 10:22:26', NULL, '2026-06-09 10:22:26', '2026-06-09 10:22:26'),
(1308, 1, 'bYBPOSrNGCtu66hUrvdLAyZ7zzQECimUtpIHz8mDrFCQhGXpqIz29zojCcknKuWqvzJVuDybak5qvUXo', '2026-06-09 10:22:26', NULL, '2026-06-09 10:22:26', '2026-06-09 10:22:26'),
(1309, 1, 'daY6HNcGdnCbSz4DPbm7fTFDqGGTXRHk3UHpJl5NENgedSYRKi2XTuX8664aNPEujuZlYaOJ4ZLJe5ev', '2026-06-09 10:32:44', NULL, '2026-06-09 10:32:44', '2026-06-09 10:32:44'),
(1310, 1, 'p9rjmciSwY7xtbc2PHUWUXORDrOovPJV6SvRah5io287KX8iPxvVPoItXYLn7J37B745mlRhMX1ehBeV', '2026-06-09 10:32:48', NULL, '2026-06-09 10:32:48', '2026-06-09 10:32:48'),
(1311, 1, 'i1yf0lE9kMUQVzfITltPgv5xtcvlT9ik2WBVpYk8kzMY2dVOoVTfcsWifnB1ByCPzC0pT8SCOn69NVLa', '2026-06-09 10:42:03', NULL, '2026-06-09 10:42:03', '2026-06-09 10:42:03'),
(1312, 1, 'buMNJNM67FPFwWrgEOHHrQqjGwlRg2PhowKAU3qaotr2Bzrq3EEKuGQrb6MwXwGfAwpSdP7bddZwNxIs', '2026-06-09 10:42:04', NULL, '2026-06-09 10:42:04', '2026-06-09 10:42:04'),
(1313, 1, '2Y15ulhLKodk11wEtJrx0Kx1uRG8RDFCdzr31F7uTtDhYpVeIyB6C1CAB9zJJTBqX4jFtRq3QXxlTB3v', '2026-06-09 10:42:05', NULL, '2026-06-09 10:42:05', '2026-06-09 10:42:05'),
(1314, 1, 'FSZmbAOnWp0cnimgoLlnZ2za0yBstnLbsTQcTeJ5kurKia6G71epdHW0QUjvOI8j1IiSr4fPsHdfQ73u', '2026-06-09 10:59:46', NULL, '2026-06-09 10:59:46', '2026-06-09 10:59:46'),
(1315, 1, 'HMoRuUbgdy66tYkIAnGE2qDQihjeAOJocKRnBYACh8UV43w7zoX9M2QBOwIZOOfdIU3GUwOtXsOgeXIF', '2026-06-09 11:29:59', NULL, '2026-06-09 11:29:59', '2026-06-09 11:29:59'),
(1316, 1, 'GKHIuSsvLsAymsm7xcDJwntzdgLr2COVbLrCFOrLW1tWwwqGbu1iLGXxFh7SqMg5mJHRfh2PbzDUhB1t', '2026-06-09 11:43:07', NULL, '2026-06-09 11:43:07', '2026-06-09 11:43:07'),
(1317, 1, 'D5AsCTDUoy3nCb3mvD4YmD9aLrufiJ82MQY4SneBH2pDUBT2pYi9ympVnWmvOtxqhJKZeLV4QZbXXnjn', '2026-06-09 11:44:42', NULL, '2026-06-09 11:44:42', '2026-06-09 11:44:42'),
(1318, 1, 'PhXEIKR2fiTQJJUo4TBNifJ1928A2ubeSJwRSAlw3A7cSZD4VKVDHwa9t3Px8bITsBn07eG7oF6hrtAW', '2026-06-10 09:27:06', NULL, '2026-06-10 09:27:06', '2026-06-10 09:27:06'),
(1319, 1, 'n3nfVmR2QgV1Ono1lTqONBCNPJ6Amb8uFdBWBXIkqWc3nXUg9Udv3EN82dusSMFSO8luU3oLexiGqGDU', '2026-06-10 09:27:52', NULL, '2026-06-10 09:27:52', '2026-06-10 09:27:52'),
(1320, 1, 'ZnAkL4QZqfM5Cegj0fVq67MNlqDLkY50OIrb3tJe3ziXNFUpgGNqEZTkAoUCvGwg1IyObm1zB3L9Xx5y', '2026-06-10 09:52:23', NULL, '2026-06-10 09:52:23', '2026-06-10 09:52:23'),
(1321, 1, '2S4bACLDwM0QmmC2RbpNKU6YKOPbX9KB3sSoXmQSzjbtyt0JmAUqxGGAV0Wm8gOrtK4AdrEvzosfnSJ4', '2026-06-10 11:33:15', NULL, '2026-06-10 11:33:15', '2026-06-10 11:33:15'),
(1322, 1, '5lNNMoSSXkkJpAnXZBkJ9ZE4dneCKKg34HwM4R17AqRtnACntwG9CWuRi16cMOMpLnM1PZFwBFTNJ6IP', '2026-06-10 11:52:06', NULL, '2026-06-10 11:52:06', '2026-06-10 11:52:06'),
(1323, 1, '9bEdq8rh9ASpv1B8gnUQsyS4KSsPiVGL4o1eZEJ1M2XssAjC53ZaghiNtvOr00vAgsLLjSqP9or6F8LI', '2026-06-10 11:56:54', NULL, '2026-06-10 11:56:54', '2026-06-10 11:56:54'),
(1324, 1, '6WFRV9q1KoZ7ZD8xYQtnLn2jvRcht9oaPQFI2JxlXz7duQkGIn9NCYVHIdFjIHMxQKOhQ5pyCpVgcHJW', '2026-06-11 02:14:50', NULL, '2026-06-11 02:14:50', '2026-06-11 02:14:50'),
(1325, 1, 'grMDD7JtIWEZn949lMr2fC3RLSurjIuFyPCZQQIssE4rxgdYvOIWNkrhM8NDGGvgmkzNNXTMWRuAPqBP', '2026-06-11 05:37:42', NULL, '2026-06-11 05:37:42', '2026-06-11 05:37:42'),
(1326, 1, 'FP3znJxEYrBGn3hGxGh9G7DPrIJaW2OmEIAS7YpSpQSByNAusk5KQEZk8DLMD16Y6bccwEq13c1db9qU', '2026-06-11 07:22:34', NULL, '2026-06-11 07:22:34', '2026-06-11 07:22:34'),
(1327, 1, 'rz47OpPerCbp4WniBnL7evlKkTNbDp5ypUWPXSjsqvJe3a1G2L2UHquTlUEuKGmP0DH4N4aelSWa6xUA', '2026-06-11 09:14:02', NULL, '2026-06-11 09:14:02', '2026-06-11 09:14:02'),
(1328, 1, '7Tfw6L8qNtfR6S4BZAmhIFL5NBiyLLGpiGeqN2BdH7xRnpCZbMVNTIA1qht90Id2TqPziiI1bIOweNMK', '2026-06-13 07:45:20', NULL, '2026-06-13 07:45:20', '2026-06-13 07:45:20'),
(1329, 1, 'P6ecyQhrKzXJ0Fx2XzC1bfH1cbub2Sqfqj4nU30IxzdU9j7eCsxc92ENvdHW8CpZsxNWSIE97ZCu0hfa', '2026-06-25 02:44:04', NULL, '2026-06-25 02:44:04', '2026-06-25 02:44:04'),
(1330, 1, 'vpXUo5IrJXXkI2iP6VHnxBI1qDVRRFEAgFi2R0rqxc33UL8GU0Oy30k62qAWy90bxPhXC9p0NzORGu4j', '2026-06-25 02:44:34', NULL, '2026-06-25 02:44:34', '2026-06-25 02:44:34'),
(1331, 1, 'mrE3bcmhFyKxIwqXdraHFID5LKjmcJQnYKqawiwp0MHU4WdEv4DZOOZC8cLaLLE3ClyT11R4sQFrhzvp', '2026-06-25 02:44:40', NULL, '2026-06-25 02:44:40', '2026-06-25 02:44:40'),
(1332, 1, 'c2r6Q8lJj8GGnutMlHllJa5cT7Dk2Unsfc8eXiYHfPc0Qwz3uJkIY9MTPnx7U0kwZMOiHVRW5BphJR0n', '2026-06-25 02:45:10', NULL, '2026-06-25 02:45:10', '2026-06-25 02:45:10'),
(1333, 1, '1ErBUfjwLF9SrpaYW49fgx2sRKWCq9e1cUjs9UiV69hHelnTumuwv73ovyCeurFeQ8sIDgsmKSWYPKzf', '2026-06-29 07:34:45', NULL, '2026-06-29 07:34:45', '2026-06-29 07:34:45'),
(1334, 1, 'Qo62OcQ9K3yy2veVJFj2wFxFCywkVZrD0moA30VwUOBC473CR81wR01kMYi6pab2Cb73ankL2nes00Rw', '2026-06-29 08:10:47', NULL, '2026-06-29 08:10:47', '2026-06-29 08:10:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `totem_sesions`
--

CREATE TABLE `totem_sesions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `totem_ventas`
--

CREATE TABLE `totem_ventas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `totem_id` bigint(20) UNSIGNED NOT NULL,
  `cliente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cliente_rut` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cliente_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cliente_telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cliente_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mascota_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mascota_edad` int(11) DEFAULT NULL,
  `mascota_raza` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_tipo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_id` bigint(20) UNSIGNED DEFAULT NULL,
  `prestador_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_rut` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_especialidad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(12,2) NOT NULL,
  `valor_total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `copago_seguro` decimal(12,2) NOT NULL DEFAULT '0.00',
  `copago_cliente` decimal(12,2) NOT NULL DEFAULT '0.00',
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `medio_pago` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_transaccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `canal_entrega` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `destino_entrega` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entregado_en` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `totem_ventas`
--

INSERT INTO `totem_ventas` (`id`, `totem_id`, `cliente_id`, `cliente_rut`, `cliente_nombre`, `cliente_telefono`, `cliente_email`, `mascota_nombre`, `mascota_edad`, `mascota_raza`, `prestador_tipo`, `prestador_id`, `prestador_nombre`, `prestador_rut`, `prestador_especialidad`, `prestador_email`, `prestador_telefono`, `prestador_direccion`, `total`, `valor_total`, `copago_seguro`, `copago_cliente`, `estado`, `medio_pago`, `codigo_transaccion`, `canal_entrega`, `destino_entrega`, `entregado_en`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pendiente', 'tarjeta', NULL, NULL, NULL, NULL, '2026-06-02 17:50:07', '2026-06-02 17:50:07'),
(2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pendiente', 'tarjeta', NULL, NULL, NULL, NULL, '2026-06-02 17:53:57', '2026-06-02 17:53:57'),
(3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pendiente', 'tarjeta', NULL, NULL, NULL, NULL, '2026-06-02 17:54:47', '2026-06-02 17:54:47'),
(4, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'TX123456', NULL, NULL, NULL, '2026-06-02 18:01:19', '2026-06-02 18:24:48'),
(5, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pendiente', 'tarjeta', NULL, NULL, NULL, NULL, '2026-06-02 18:24:48', '2026-06-02 18:24:48'),
(6, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'TX999999', 'whatsapp', '+56912345678', '2026-06-02 18:58:19', '2026-06-02 18:28:21', '2026-06-02 18:58:19'),
(7, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'TXCLIENTE001', NULL, NULL, NULL, '2026-06-02 18:45:21', '2026-06-02 19:32:50'),
(8, 1, NULL, '12345678-9', 'Cliente Prueba', '+56912345678', 'cliente@demo.cl', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'TXVET001', NULL, NULL, NULL, '2026-06-02 19:32:50', '2026-06-02 20:15:06'),
(9, 1, 9, '16187674-k', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'TXVET002', NULL, NULL, NULL, '2026-06-02 20:15:06', '2026-06-02 20:17:59'),
(10, 1, 9, '16187674-k', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pendiente', 'tarjeta', NULL, NULL, NULL, NULL, '2026-06-02 20:16:58', '2026-06-02 20:16:58'),
(11, 1, 9, '16187674-k', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780419876364', 'whatsapp', '95474661', '2026-06-02 21:04:36', '2026-06-02 21:04:36', '2026-06-02 21:04:36'),
(12, 1, 9, '16187674-k', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780508023125', 'veterinario', '95474661', '2026-06-03 21:33:43', '2026-06-03 21:33:43', '2026-06-03 21:33:43'),
(13, 1, 9, '16187674-k', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'alimentos', 3, 'Alimentos Vet', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780508442332', 'app', '95474661', '2026-06-03 21:40:42', '2026-06-03 21:40:42', '2026-06-03 21:40:42'),
(14, 1, 9, '16187674-k', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780508472076', 'whatsapp', '95474661', '2026-06-03 21:41:12', '2026-06-03 21:41:12', '2026-06-03 21:41:12'),
(15, 1, 9, '16187674-k', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780515326847', 'app', '95474661', '2026-06-03 23:35:27', '2026-06-03 23:35:26', '2026-06-03 23:35:27'),
(16, 1, 9, '16187674-k', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780515339447', 'app', '95474661', '2026-06-03 23:35:40', '2026-06-03 23:35:39', '2026-06-03 23:35:40'),
(17, 1, 9, '16187674-k', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780515347510', 'whatsapp', '95474661', '2026-06-03 23:35:48', '2026-06-03 23:35:47', '2026-06-03 23:35:48'),
(18, 1, 9, '16187674-k', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780515397251', 'whatsapp', '95474661', '2026-06-03 23:36:37', '2026-06-03 23:36:37', '2026-06-03 23:36:37'),
(19, 1, NULL, NULL, 'Invitado', NULL, NULL, NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780541753688', 'whatsapp', NULL, '2026-06-04 06:55:54', '2026-06-04 06:55:53', '2026-06-04 06:55:54'),
(20, 1, NULL, NULL, 'Invitado', NULL, NULL, NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780542885982', 'whatsapp', NULL, '2026-06-04 07:14:46', '2026-06-04 07:14:45', '2026-06-04 07:14:46'),
(21, 1, NULL, NULL, 'Invitado', NULL, NULL, NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780543124306', 'whatsapp', NULL, '2026-06-04 07:18:44', '2026-06-04 07:18:44', '2026-06-04 07:18:44'),
(22, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '0.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780545171649', 'whatsapp', '95474661', '2026-06-04 07:52:51', '2026-06-04 07:52:51', '2026-06-04 07:52:51'),
(23, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '10000.00', '0.00', '10000.00', 'pagado', 'tarjeta', 'DEMO-1780561903489', 'app', '95474661', '2026-06-04 12:31:43', '2026-06-04 12:31:43', '2026-06-04 12:31:43'),
(24, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '10000.00', '0.00', '10000.00', 'pagado', 'tarjeta', 'DEMO-1780619573064', 'whatsapp', '95474661', '2026-06-05 04:32:53', '2026-06-05 04:32:53', '2026-06-05 04:32:53'),
(25, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '10000.00', '0.00', '10000.00', 'pagado', 'tarjeta', 'DEMO-1780635657964', 'whatsapp', '95474661', '2026-06-05 09:00:59', '2026-06-05 09:00:57', '2026-06-05 09:00:59'),
(26, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 3, 'pastor', 'veterinario', 1, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780637366897', 'whatsapp', '95474661', '2026-06-05 09:29:27', '2026-06-05 09:29:26', '2026-06-05 09:29:27'),
(27, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 3, 'pastor', 'veterinario', 3, 'Dr. Veterinario Demo', '12.345.678-9', 'cirugia veterinaria', 'consulta@vet.cl', '+56912345678', NULL, '20000.00', '20000.00', '14000.00', '6000.00', 'pagado', 'tarjeta', 'DEMO-1780637578288', NULL, NULL, NULL, '2026-06-05 09:32:58', '2026-06-05 09:32:58'),
(28, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780813033944', 'whatsapp', '95474661', '2026-06-07 10:17:14', '2026-06-07 10:17:13', '2026-06-07 10:17:14'),
(29, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780813188589', 'whatsapp', '95474661', '2026-06-07 10:19:48', '2026-06-07 10:19:48', '2026-06-07 10:19:48'),
(30, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 4, 'Pastor Aleman', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '38000.00', '38000.00', '26600.00', '11400.00', 'pagado', 'tarjeta', 'DEMO-1780816743236', 'whatsapp', '95474661', '2026-06-07 11:19:04', '2026-06-07 11:19:03', '2026-06-07 11:19:04'),
(31, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 4, 'Dra. daniela Demo', '15.455.789-5', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, '28000.00', '28000.00', '19600.00', '8400.00', 'pagado', 'tarjeta', 'DEMO-1780817673225', 'whatsapp', '95474661', '2026-06-07 11:34:33', '2026-06-07 11:34:33', '2026-06-07 11:34:33'),
(32, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 4, 'Dra. daniela Demo', '15.455.789-5', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, '25000.00', '25000.00', '17500.00', '7500.00', 'pagado', 'tarjeta', 'DEMO-1780818643817', 'whatsapp', '95474661', '2026-06-07 11:50:44', '2026-06-07 11:50:43', '2026-06-07 11:50:44'),
(33, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780818765092', 'whatsapp', '95474661', '2026-06-07 11:52:45', '2026-06-07 11:52:45', '2026-06-07 11:52:45'),
(34, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '50000.00', '50000.00', '35000.00', '15000.00', 'pagado', 'tarjeta', 'DEMO-1780819367034', 'whatsapp', '95474661', '2026-06-07 12:02:47', '2026-06-07 12:02:47', '2026-06-07 12:02:47'),
(35, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 8, 'pastor', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '38000.00', '38000.00', '26600.00', '11400.00', 'pagado', 'tarjeta', 'DEMO-1780821158467', 'whatsapp', '95474661', '2026-06-07 12:32:38', '2026-06-07 12:32:38', '2026-06-07 12:32:38'),
(36, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 8, 'pastor', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780822203613', 'whatsapp', '95474661', '2026-06-07 12:50:03', '2026-06-07 12:50:03', '2026-06-07 12:50:03'),
(37, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780861099689', 'whatsapp', '95474661', '2026-06-07 23:38:20', '2026-06-07 23:38:19', '2026-06-07 23:38:20'),
(38, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780862102028', 'whatsapp', '95474661', '2026-06-07 23:55:02', '2026-06-07 23:55:02', '2026-06-07 23:55:02'),
(39, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780862103036', 'whatsapp', '95474661', '2026-06-07 23:55:03', '2026-06-07 23:55:03', '2026-06-07 23:55:03'),
(40, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 4, 'Dra. daniela Demo', '15.455.789-5', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, '35000.00', '35000.00', '24500.00', '10500.00', 'pagado', 'tarjeta', 'DEMO-1780939605386', 'whatsapp', '95474661', '2026-06-08 21:26:46', '2026-06-08 21:26:45', '2026-06-08 21:26:46'),
(41, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780939823573', 'veterinario', '95474661', '2026-06-08 21:30:23', '2026-06-08 21:30:23', '2026-06-08 21:30:23'),
(42, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 8, 'pastor', 'veterinario', 4, 'Dra. daniela Demo', '15.455.789-5', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, '18000.00', '18000.00', '12600.00', '5400.00', 'pagado', 'tarjeta', 'DEMO-1780970105879', 'whatsapp', '95474661', '2026-06-09 05:55:07', '2026-06-09 05:55:05', '2026-06-09 05:55:07'),
(43, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '25000.00', '25000.00', '17500.00', '7500.00', 'pagado', 'tarjeta', 'DEMO-1780970307508', 'whatsapp', '95474661', '2026-06-09 05:58:27', '2026-06-09 05:58:27', '2026-06-09 05:58:27'),
(44, 1, NULL, '17174188-2', 'Invitado', NULL, NULL, NULL, NULL, NULL, 'veterinario', 4, 'Dra. daniela Demo', '15.455.789-5', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, '10000.00', '10000.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780970460417', 'whatsapp', NULL, '2026-06-09 06:01:00', '2026-06-09 06:01:00', '2026-06-09 06:01:00'),
(45, 1, NULL, '17174188-2', 'Invitado', NULL, NULL, NULL, NULL, NULL, 'veterinario', 4, 'Dra. daniela Demo', '15.455.789-5', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, '10000.00', '10000.00', '0.00', '0.00', 'pagado', 'tarjeta', 'DEMO-1780970461711', 'whatsapp', NULL, '2026-06-09 06:01:02', '2026-06-09 06:01:01', '2026-06-09 06:01:02'),
(46, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 4, 'Dra. daniela Demo', '15.455.789-5', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, '25000.00', '25000.00', '17500.00', '7500.00', 'pagado', 'tarjeta', 'DEMO-1780977739930', 'whatsapp', '95474661', '2026-06-09 08:02:20', '2026-06-09 08:02:19', '2026-06-09 08:02:20'),
(47, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '37000.00', '37000.00', '25900.00', '11100.00', 'pagado', 'tarjeta', 'DEMO-1780978037046', 'whatsapp', '95474661', '2026-06-09 08:07:17', '2026-06-09 08:07:17', '2026-06-09 08:07:17'),
(48, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '34000.00', '34000.00', '23800.00', '10200.00', 'pagado', 'tarjeta', 'DEMO-1780978208946', 'whatsapp', '95474661', '2026-06-09 08:10:09', '2026-06-09 08:10:08', '2026-06-09 08:10:09'),
(49, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780980231371', 'whatsapp', '95474661', '2026-06-09 08:43:52', '2026-06-09 08:43:51', '2026-06-09 08:43:52'),
(50, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 4, 'Dra. daniela Demo', '15.455.789-5', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780981103367', 'whatsapp', '95474661', '2026-06-09 08:58:23', '2026-06-09 08:58:23', '2026-06-09 08:58:23'),
(51, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780981247258', 'whatsapp', '95474661', '2026-06-09 09:00:47', '2026-06-09 09:00:47', '2026-06-09 09:00:47'),
(52, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '35000.00', '35000.00', '24500.00', '10500.00', 'pagado', 'tarjeta', 'DEMO-1780981943523', 'whatsapp', '95474661', '2026-06-09 09:12:23', '2026-06-09 09:12:23', '2026-06-09 09:12:23'),
(53, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 8, 'pastor', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '30000.00', '30000.00', '21000.00', '9000.00', 'pagado', 'tarjeta', 'DEMO-1780982649180', 'whatsapp', '95474661', '2026-06-09 09:24:09', '2026-06-09 09:24:09', '2026-06-09 09:24:09'),
(54, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780984897025', 'whatsapp', '95474661', '2026-06-09 10:01:37', '2026-06-09 10:01:37', '2026-06-09 10:01:37'),
(55, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'Firulais', NULL, 'Mestizo', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1780985988590', 'whatsapp', '95474661', '2026-06-09 10:19:48', '2026-06-09 10:19:48', '2026-06-09 10:19:48'),
(56, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 8, 'pastor', 'veterinario', 4, 'Dra. daniela Demo', '15.455.789-5', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, '22000.00', '22000.00', '15400.00', '6600.00', 'pagado', 'tarjeta', 'DEMO-1780986176602', 'whatsapp', '95474661', '2026-06-09 10:22:56', '2026-06-09 10:22:56', '2026-06-09 10:22:56'),
(57, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 8, 'pastor', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '12000.00', '12000.00', '8400.00', '3600.00', 'pagado', 'tarjeta', 'DEMO-1780986800707', 'whatsapp', '95474661', '2026-06-09 10:33:21', '2026-06-09 10:33:20', '2026-06-09 10:33:21'),
(58, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 8, 'pastor', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '15000.00', '15000.00', '10500.00', '4500.00', 'pagado', 'tarjeta', 'DEMO-1780987351919', NULL, NULL, NULL, '2026-06-09 10:42:31', '2026-06-09 10:42:32'),
(59, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 8, 'pastor', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '27000.00', '27000.00', '18900.00', '8100.00', 'pagado', 'tarjeta', 'DEMO-1780991123970', 'whatsapp', '95474661', '2026-06-09 11:45:24', '2026-06-09 11:45:23', '2026-06-09 11:45:24'),
(60, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', NULL, NULL, NULL, 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '15000.00', '15000.00', '10500.00', '4500.00', 'pagado', 'tarjeta', 'DEMO-1781129725027', 'whatsapp', '95474661', '2026-06-11 02:15:26', '2026-06-11 02:15:24', '2026-06-11 02:15:26'),
(61, 1, NULL, NULL, 'Invitado', NULL, NULL, NULL, NULL, NULL, 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '18000.00', '18000.00', '12600.00', '5400.00', 'pagado', 'tarjeta', 'DEMO-1781129791154', 'app', NULL, '2026-06-11 02:16:31', '2026-06-11 02:16:31', '2026-06-11 02:16:31'),
(62, 1, 9, '16.187.674-K', 'KATHERINE BASTIAS', '95474661', 'katherine.bastias91@gmail.com', 'pillan', 8, 'pastor', 'veterinario', 2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, '10000.00', '10000.00', '7000.00', '3000.00', 'pagado', 'tarjeta', 'DEMO-1782706303709', 'whatsapp', '95474661', '2026-06-29 08:11:44', '2026-06-29 08:11:43', '2026-06-29 08:11:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `totem_venta_detalles`
--

CREATE TABLE `totem_venta_detalles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `venta_id` bigint(20) UNSIGNED NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referencia_id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT '1',
  `precio` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `totem_venta_detalles`
--

INSERT INTO `totem_venta_detalles` (`id`, `venta_id`, `tipo`, `referencia_id`, `cantidad`, `precio`, `created_at`, `updated_at`) VALUES
(1, 1, 'voucher', 1, 1, '10000.00', '2026-06-02 17:50:07', '2026-06-02 17:50:07'),
(2, 2, 'voucher', 1, 1, '10000.00', '2026-06-02 17:53:57', '2026-06-02 17:53:57'),
(3, 3, 'voucher', 1, 1, '10000.00', '2026-06-02 17:54:47', '2026-06-02 17:54:47'),
(4, 4, 'voucher', 1, 1, '10000.00', '2026-06-02 18:01:19', '2026-06-02 18:01:19'),
(5, 5, 'voucher', 1, 1, '10000.00', '2026-06-02 18:24:48', '2026-06-02 18:24:48'),
(6, 6, 'voucher', 1, 1, '10000.00', '2026-06-02 18:28:21', '2026-06-02 18:28:21'),
(7, 7, 'voucher', 1, 1, '10000.00', '2026-06-02 18:45:21', '2026-06-02 18:45:21'),
(8, 8, 'voucher', 1, 1, '10000.00', '2026-06-02 19:32:50', '2026-06-02 19:32:50'),
(9, 9, 'voucher', 1, 1, '10000.00', '2026-06-02 20:15:06', '2026-06-02 20:15:06'),
(10, 10, 'voucher', 1, 1, '10000.00', '2026-06-02 20:16:58', '2026-06-02 20:16:58'),
(11, 11, 'voucher', 1, 1, '10000.00', '2026-06-02 21:04:36', '2026-06-02 21:04:36'),
(12, 12, 'voucher', 1, 1, '10000.00', '2026-06-03 21:33:43', '2026-06-03 21:33:43'),
(13, 13, 'alimentos', 1, 1, '10000.00', '2026-06-03 21:40:42', '2026-06-03 21:40:42'),
(14, 14, 'voucher', 1, 1, '10000.00', '2026-06-03 21:41:12', '2026-06-03 21:41:12'),
(15, 15, 'voucher', 1, 1, '10000.00', '2026-06-03 23:35:26', '2026-06-03 23:35:26'),
(16, 16, 'voucher', 1, 1, '10000.00', '2026-06-03 23:35:39', '2026-06-03 23:35:39'),
(17, 17, 'voucher', 1, 1, '10000.00', '2026-06-03 23:35:47', '2026-06-03 23:35:47'),
(18, 18, 'voucher', 1, 1, '10000.00', '2026-06-03 23:36:37', '2026-06-03 23:36:37'),
(19, 19, 'voucher', 1, 1, '10000.00', '2026-06-04 06:55:53', '2026-06-04 06:55:53'),
(20, 20, 'voucher', 1, 1, '10000.00', '2026-06-04 07:14:45', '2026-06-04 07:14:45'),
(21, 21, 'voucher', 1, 1, '10000.00', '2026-06-04 07:18:44', '2026-06-04 07:18:44'),
(22, 22, 'voucher', 1, 1, '10000.00', '2026-06-04 07:52:51', '2026-06-04 07:52:51'),
(23, 23, 'voucher', 1, 1, '10000.00', '2026-06-04 12:31:43', '2026-06-04 12:31:43'),
(24, 24, 'voucher', 1, 1, '10000.00', '2026-06-05 04:32:53', '2026-06-05 04:32:53'),
(25, 25, 'voucher', 1, 1, '10000.00', '2026-06-05 09:00:57', '2026-06-05 09:00:57'),
(26, 26, 'voucher', 1, 1, '10000.00', '2026-06-05 09:29:26', '2026-06-05 09:29:26'),
(27, 27, 'alimentos', 1, 1, '20000.00', '2026-06-05 09:32:58', '2026-06-05 09:32:58'),
(28, 28, 'voucher', 1, 1, '10000.00', '2026-06-07 10:17:13', '2026-06-07 10:17:13'),
(29, 29, 'voucher', 1, 1, '10000.00', '2026-06-07 10:19:48', '2026-06-07 10:19:48'),
(30, 30, 'voucher', 1, 1, '10000.00', '2026-06-07 11:19:03', '2026-06-07 11:19:03'),
(31, 30, 'voucher', 2, 1, '18000.00', '2026-06-07 11:19:03', '2026-06-07 11:19:03'),
(32, 30, 'voucher', 3, 1, '10000.00', '2026-06-07 11:19:03', '2026-06-07 11:19:03'),
(33, 31, 'voucher', 1, 1, '10000.00', '2026-06-07 11:34:33', '2026-06-07 11:34:33'),
(34, 31, 'voucher', 2, 1, '18000.00', '2026-06-07 11:34:33', '2026-06-07 11:34:33'),
(35, 32, 'voucher', 1, 1, '10000.00', '2026-06-07 11:50:43', '2026-06-07 11:50:43'),
(36, 32, 'voucher', 2, 1, '15000.00', '2026-06-07 11:50:43', '2026-06-07 11:50:43'),
(37, 33, 'voucher', 1, 1, '10000.00', '2026-06-07 11:52:45', '2026-06-07 11:52:45'),
(38, 34, 'voucher', 1, 1, '10000.00', '2026-06-07 12:02:47', '2026-06-07 12:02:47'),
(39, 34, 'voucher', 2, 1, '18000.00', '2026-06-07 12:02:47', '2026-06-07 12:02:47'),
(40, 34, 'voucher', 3, 1, '22000.00', '2026-06-07 12:02:47', '2026-06-07 12:02:47'),
(41, 35, 'voucher', 1, 1, '10000.00', '2026-06-07 12:32:38', '2026-06-07 12:32:38'),
(42, 35, 'voucher', 2, 1, '18000.00', '2026-06-07 12:32:38', '2026-06-07 12:32:38'),
(43, 35, 'voucher', 3, 1, '10000.00', '2026-06-07 12:32:38', '2026-06-07 12:32:38'),
(44, 36, 'voucher', 1, 1, '10000.00', '2026-06-07 12:50:03', '2026-06-07 12:50:03'),
(45, 37, 'voucher', 1, 1, '10000.00', '2026-06-07 23:38:19', '2026-06-07 23:38:19'),
(46, 38, 'voucher', 1, 1, '10000.00', '2026-06-07 23:55:02', '2026-06-07 23:55:02'),
(47, 39, 'voucher', 1, 1, '10000.00', '2026-06-07 23:55:03', '2026-06-07 23:55:03'),
(48, 40, 'voucher', 1, 1, '35000.00', '2026-06-08 21:26:45', '2026-06-08 21:26:45'),
(49, 41, 'voucher', 1, 1, '10000.00', '2026-06-08 21:30:23', '2026-06-08 21:30:23'),
(50, 42, 'voucher', 1, 1, '18000.00', '2026-06-09 05:55:05', '2026-06-09 05:55:05'),
(51, 43, 'voucher', 1, 1, '25000.00', '2026-06-09 05:58:27', '2026-06-09 05:58:27'),
(52, 44, 'voucher', 1, 1, '10000.00', '2026-06-09 06:01:00', '2026-06-09 06:01:00'),
(53, 45, 'voucher', 1, 1, '10000.00', '2026-06-09 06:01:01', '2026-06-09 06:01:01'),
(54, 46, 'voucher', 1, 1, '25000.00', '2026-06-09 08:02:19', '2026-06-09 08:02:19'),
(55, 47, 'voucher', 1, 1, '10000.00', '2026-06-09 08:07:17', '2026-06-09 08:07:17'),
(56, 47, 'voucher', 2, 1, '15000.00', '2026-06-09 08:07:17', '2026-06-09 08:07:17'),
(57, 47, 'voucher', 3, 1, '12000.00', '2026-06-09 08:07:17', '2026-06-09 08:07:17'),
(58, 48, 'voucher', 1, 1, '10000.00', '2026-06-09 08:10:08', '2026-06-09 08:10:08'),
(59, 48, 'voucher', 2, 1, '12000.00', '2026-06-09 08:10:08', '2026-06-09 08:10:08'),
(60, 48, 'voucher', 3, 1, '12000.00', '2026-06-09 08:10:08', '2026-06-09 08:10:08'),
(61, 49, 'voucher', 1, 1, '10000.00', '2026-06-09 08:43:51', '2026-06-09 08:43:51'),
(62, 50, 'voucher', 1, 1, '10000.00', '2026-06-09 08:58:23', '2026-06-09 08:58:23'),
(63, 51, 'voucher', 1, 1, '10000.00', '2026-06-09 09:00:47', '2026-06-09 09:00:47'),
(64, 52, 'voucher', 1, 1, '35000.00', '2026-06-09 09:12:23', '2026-06-09 09:12:23'),
(65, 53, 'voucher', 1, 1, '10000.00', '2026-06-09 09:24:09', '2026-06-09 09:24:09'),
(66, 53, 'voucher', 2, 1, '20000.00', '2026-06-09 09:24:09', '2026-06-09 09:24:09'),
(67, 54, 'voucher', 1, 1, '10000.00', '2026-06-09 10:01:37', '2026-06-09 10:01:37'),
(68, 55, 'voucher', 1, 1, '10000.00', '2026-06-09 10:19:48', '2026-06-09 10:19:48'),
(69, 56, 'voucher', 1, 1, '22000.00', '2026-06-09 10:22:56', '2026-06-09 10:22:56'),
(70, 57, 'voucher', 1, 1, '12000.00', '2026-06-09 10:33:20', '2026-06-09 10:33:20'),
(71, 58, 'voucher', 1, 1, '15000.00', '2026-06-09 10:42:31', '2026-06-09 10:42:31'),
(72, 59, 'voucher', 1, 1, '15000.00', '2026-06-09 11:45:23', '2026-06-09 11:45:23'),
(73, 59, 'voucher', 2, 1, '12000.00', '2026-06-09 11:45:23', '2026-06-09 11:45:23'),
(74, 60, 'voucher', 1, 1, '15000.00', '2026-06-11 02:15:24', '2026-06-11 02:15:24'),
(75, 61, 'voucher', 1, 1, '18000.00', '2026-06-11 02:16:31', '2026-06-11 02:16:31'),
(76, 62, 'voucher', 1, 1, '10000.00', '2026-06-29 08:11:43', '2026-06-29 08:11:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rut` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rut_encrypted` text COLLATE utf8mb4_unicode_ci,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono_encrypted` text COLLATE utf8mb4_unicode_ci,
  `rol` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'vendedor',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `vendedor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profesional_id` bigint(20) UNSIGNED DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `login_otp_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_otp_expira` timestamp NULL DEFAULT NULL,
  `login_otp_validado_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `rut`, `rut_encrypted`, `telefono`, `telefono_encrypted`, `rol`, `activo`, `vendedor_id`, `profesional_id`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `login_otp_hash`, `login_otp_expira`, `login_otp_validado_at`) VALUES
(1, 'Vendedor Demo', 'vendedor@veterchile.cl', NULL, NULL, NULL, NULL, 'vendedor', 1, 1, NULL, NULL, '$2y$10$/8qGHkACxe8WNEhRS7pu7OSLXjlKsjIXBldxkERj3ql9BdmsH6pD6', NULL, '2026-05-27 19:58:40', '2026-05-31 06:22:38', NULL, NULL, NULL),
(2, 'Profesional Demo', 'profesional@veterchile.cl', NULL, NULL, NULL, NULL, 'profesional', 1, NULL, 1, NULL, '$2y$10$3D/lHgeK6Gn6O1OPdbWX2.sLqvvRsqX.JInEU0/P7T8QpWKTyBa3S', 'uDXb7OD5kncHEIyOANGH5UgBfeCt3Pqxz4pGRqjyUtSyPTC9jm2tnH6iQ8Rk', '2026-05-27 19:58:40', '2026-05-30 08:02:12', NULL, NULL, NULL),
(3, 'Auditor Demo', 'auditor@veterchile.cl', NULL, NULL, NULL, NULL, 'auditor', 1, NULL, NULL, NULL, '$2y$10$3D/lHgeK6Gn6O1OPdbWX2.sLqvvRsqX.JInEU0/P7T8QpWKTyBa3S', NULL, '2026-05-27 19:58:40', '2026-05-27 19:58:40', NULL, NULL, NULL),
(4, 'Admin Demo', 'admin@veterchile.cl', NULL, NULL, NULL, NULL, 'admin', 1, NULL, NULL, NULL, '$2y$10$98AV.Ci5Gb8w30BKqcU0b.OcQDQF6rHKg9ZXjGIVLEmocEVcHV8gC', 'VLImMJ8SiZgKb5NFiz1F7mSbmW3oSCaqpyOTHgQRsDH4y19w83EKS9P3XMSi', '2026-05-27 21:49:47', '2026-05-31 03:18:13', NULL, NULL, NULL),
(9, 'KATHERINE BASTIAS', 'katherine.bastias91@gmail.com', '16.187.674-K', NULL, '95474661', NULL, 'cliente', 1, 1, 1, NULL, '$2y$10$AzpviChSh.xg59jqfWHlDeBENb.of0ncQHTpqT35ZWGpJUAlOgeAa', NULL, '2026-05-31 09:48:16', '2026-05-31 14:43:18', NULL, NULL, NULL),
(24, 'Asistente VETERCHILE', 'asistente@veterchile.cl', NULL, NULL, NULL, NULL, 'asistente', 1, NULL, NULL, NULL, '$2y$10$Tlp9ii8iRVgpYkpo2PWyMeOYPvpOT3xwjNWvW1FHIYFuNIEEYeiEG', NULL, '2026-06-11 10:18:41', '2026-06-12 08:51:08', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vouchers`
--

CREATE TABLE `vouchers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `totem_venta_id` bigint(20) UNSIGNED DEFAULT NULL,
  `vendedor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profesional_id` bigint(20) UNSIGNED DEFAULT NULL,
  `prestador_rut` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_especialidad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prestador_direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `servicio_id` bigint(20) UNSIGNED DEFAULT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qr_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cliente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mascota_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mascota_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mascota_edad` int(11) DEFAULT NULL,
  `mascota_raza` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `criadero_cachorro_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cliente_rut` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cliente_rut_hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cliente_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_servicio` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT '0.00',
  `valor_total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `porcentaje_descuento` decimal(5,2) NOT NULL DEFAULT '100.00',
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `fecha_vencimiento` timestamp NULL DEFAULT NULL,
  `usado_en` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `copago_usuario` decimal(10,2) NOT NULL DEFAULT '0.00',
  `saldo_cliente_aplicado` int(11) NOT NULL DEFAULT '0',
  `saldo_veterinario` decimal(10,2) NOT NULL DEFAULT '0.00',
  `comision_veterchile` decimal(10,2) NOT NULL DEFAULT '0.00',
  `cliente_aceptado_en` timestamp NULL DEFAULT NULL,
  `cliente_rechazado_en` timestamp NULL DEFAULT NULL,
  `motivo_rechazo_cliente` text COLLATE utf8mb4_unicode_ci,
  `qr_firma` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr_expira` timestamp NULL DEFAULT NULL,
  `qr_usado` tinyint(1) NOT NULL DEFAULT '0',
  `qr_usado_at` timestamp NULL DEFAULT NULL,
  `invalidado_en` timestamp NULL DEFAULT NULL,
  `motivo_invalidacion` text COLLATE utf8mb4_unicode_ci,
  `copago_devuelto` tinyint(1) NOT NULL DEFAULT '0',
  `otp_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp_expira` timestamp NULL DEFAULT NULL,
  `otp_validado_at` timestamp NULL DEFAULT NULL,
  `agenda_id` bigint(20) UNSIGNED DEFAULT NULL,
  `atencion_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profesional_atendio_id` bigint(20) UNSIGNED DEFAULT NULL,
  `asistente_valido_id` bigint(20) UNSIGNED DEFAULT NULL,
  `atencion_cerrada_at` datetime DEFAULT NULL,
  `validado_at` datetime DEFAULT NULL,
  `ip_profesional` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_asistente` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_validacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `riesgo_validacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vouchers`
--

INSERT INTO `vouchers` (`id`, `totem_venta_id`, `vendedor_id`, `profesional_id`, `prestador_rut`, `prestador_nombre`, `prestador_especialidad`, `prestador_email`, `prestador_telefono`, `prestador_direccion`, `servicio_id`, `codigo`, `qr_token`, `cliente_id`, `mascota_id`, `mascota_nombre`, `mascota_edad`, `mascota_raza`, `criadero_cachorro_id`, `cliente_rut`, `cliente_rut_hash`, `cliente_nombre`, `tipo_servicio`, `valor`, `valor_total`, `porcentaje_descuento`, `estado`, `fecha_vencimiento`, `usado_en`, `created_at`, `updated_at`, `copago_usuario`, `saldo_cliente_aplicado`, `saldo_veterinario`, `comision_veterchile`, `cliente_aceptado_en`, `cliente_rechazado_en`, `motivo_rechazo_cliente`, `qr_firma`, `qr_expira`, `qr_usado`, `qr_usado_at`, `invalidado_en`, `motivo_invalidacion`, `copago_devuelto`, `otp_hash`, `otp_expira`, `otp_validado_at`, `agenda_id`, `atencion_id`, `profesional_atendio_id`, `asistente_valido_id`, `atencion_cerrada_at`, `validado_at`, `ip_profesional`, `ip_asistente`, `estado_validacion`, `riesgo_validacion`) VALUES
(1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'AHQIBAJHTU', '9ad8c3a4-2ed2-49c1-8cee-259d85f86f16', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6IlcreG05aGhiWC9EeEJXZVN5eUsyenc9PSIsInZhbHVlIjoiOFRXQk5lQW1vS0I3QUpJQlFxYmx5Zz09IiwibWFjIjoiNWFmNGM4ODhhOGU0YjY0YTUwZjlhMDFmODllMjBkMTg4YmQzODBjZWZiM2FlYWE3MjNjZjQzMDBhYTMwZDM3MyIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Primera consulta veterinaria', '15000.00', '0.00', '100.00', 'usado', '2026-06-25 06:36:40', '2026-05-26 06:40:18', '2026-05-26 06:36:40', '2026-05-26 06:40:18', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TSK6HVULMP', '9fd395e7-14dd-494e-a795-1d6d458358b9', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6IjZjWFdETGE5K1plS0tCM3N6cXlyNEE9PSIsInZhbHVlIjoic0FIQnhjSjhzdUtPUHM2UjdzcENFQT09IiwibWFjIjoiYWFhOTc3MWJhOWM2OThkMzZlOTMxYzc2YjY3OWY2ZTk4ZGVhN2ZjNzFkYmRiMzBlODVhMmZiZmYwN2U2NmI3ZCIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Primera consulta veterinaria', '15000.00', '0.00', '100.00', 'usado', '2026-06-25 07:03:26', '2026-05-31 00:39:36', '2026-05-26 07:03:27', '2026-05-31 00:39:36', '0.00', 0, '20000.00', '0.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'JWAIQKZXQK', 'b60f0ce2-58de-4072-be7f-6299cce064ad', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6Ik9CYkJZR2ZzaWgxbDMxbzI1MzcyM0E9PSIsInZhbHVlIjoidjZqa0FVamNJZU1yMHJmcG55eVAwQT09IiwibWFjIjoiOWNmZDM5OWY0MGE3MTU3OWIwODc1ZDYyZjM2NWY2NTAzODNkYTQxMTI0NTIzNWQ1MWY1NzJkNGRkNjVkMDdkNiIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Consulta veterinaria', '20000.00', '0.00', '100.00', 'pendiente_pago', '2026-06-25 08:12:21', NULL, '2026-05-26 08:12:21', '2026-05-26 08:12:21', '5000.00', 0, '13000.00', '2000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'KUU1DYIAVY', 'dff1593d-741b-4487-bdad-12b9bf05083c', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6ImhKRlc3dks4MUVYUHZZUGhoV2NuZEE9PSIsInZhbHVlIjoiWGhRUXRJMXh0ZjNGL2tlTkFFRnd6UT09IiwibWFjIjoiMGQ5NTY2MGRmMDAzNjUxNjE3ZDBkODljN2E3MzgzZmIwNzM0NzU0M2NmYWFjMTA0Y2NiNGRkNzNjNDU5ODA5NiIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Primera consulta veterinaria', '20000.00', '0.00', '100.00', 'pendiente_pago', '2026-06-25 08:54:50', NULL, '2026-05-26 08:54:50', '2026-05-26 08:54:50', '5000.00', 0, '13000.00', '2000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2ZCCNHSWP8', '82a3d3a0-fa9f-4241-a5bb-c48d4758c400', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6IlNMa3VFM0xkcnVsbkwrUUc4clhJdFE9PSIsInZhbHVlIjoiM2xpb3ZJWmZNOXRDSE1NQ1g4US9mUT09IiwibWFjIjoiZmM4NDM3NTBjMjQyNDBlNmVmMDM3NjE3NmNiNjkwNmI3M2YzNWQzMTQ1ZWYwZmQwNGQwYTQxN2U2MWQ1NjY0NCIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Primera consulta veterinaria', '15000.00', '0.00', '100.00', 'usado', '2026-06-25 08:56:13', '2026-05-30 09:33:33', '2026-05-26 08:56:13', '2026-05-30 09:33:33', '0.00', 0, '15000.00', '0.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'BOQC0WDV1U', 'ceedecd4-333b-4380-b70d-9a39109332b5', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6InVSNmVDN3Q0SVJwT0wyNjErUHhzVXc9PSIsInZhbHVlIjoiTk1BSnFSaEpDVjFQNCtTcXZOODVKdz09IiwibWFjIjoiZWZjOWY3NGUxY2YwMGZkYTBkODQ2MTI0Njk0MjE2MDZiNTk4OTJkZDBmNjU0ZWVhY2EwYmI2NTg2ODZhZDAzNyIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Primera consulta veterinaria', '15000.00', '0.00', '100.00', 'usado', '2026-06-25 08:56:19', '2026-05-30 09:24:29', '2026-05-26 08:56:19', '2026-05-30 09:24:29', '0.00', 0, '15000.00', '0.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ZCTCAAECPO', '01ecb385-acbd-4394-b884-ca6185470184', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6Ik90RU96ZG1LM0ZBU1pGUkl4V25lNVE9PSIsInZhbHVlIjoiaFlqYkNKbE9odjJvL1QxTUJtS0luQT09IiwibWFjIjoiN2ZjNjY1Yzc4NGU3ODVkZGNiOWRjZTgwMjVkNjA4M2E0Y2MzMGQ5MTBhMWE0Yjk1ZThlN2VhZTIzM2NlOGQ3OSIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Primera consulta veterinaria', '20000.00', '0.00', '100.00', 'pendiente_pago', '2026-06-25 08:58:52', NULL, '2026-05-26 08:58:52', '2026-05-26 08:58:52', '5000.00', 0, '13000.00', '2000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'KVQQAOQXTL', 'a57296ab-42a9-4d9b-87ef-78b3210ed918', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6InF5R1BWbnlvd1RwVE9QTUVuWUJwYXc9PSIsInZhbHVlIjoiaTVvRDhJTzVqM2MzTzJ5bkhYOTZ2dz09IiwibWFjIjoiMDhkM2VlYmNkMzExNDgwMDcyZWRiMzUxODNiYjc1MDkxMTBhNzVjZjRkOGEzYmQyYzBlNDRkNmViYzI5ODUzOSIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Primera consulta veterinaria', '20000.00', '0.00', '100.00', 'usado', '2026-06-25 09:01:06', '2026-05-26 21:48:04', '2026-05-26 09:01:06', '2026-05-26 21:48:04', '5000.00', 0, '13000.00', '2000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VUJQVWHU5Y', '3d867d54-d4bd-4e05-997f-50d2ba9ae953', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6IlI3VHp6L2JVNUxxN1NmQ2NkMGlxYVE9PSIsInZhbHVlIjoidzhkWis1UW9BTlQ5KzROTE1GZVBSQT09IiwibWFjIjoiNDY2ZjFlODEwZWMxZTJjYWE3YTYwZWVkN2ViNWRkMWY0MDA2YWExYTE2MjVjYjU5NzAxYTM2MDljMWFkOWY4ZCIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Primera consulta veterinaria', '20000.00', '0.00', '100.00', 'usado', '2026-06-25 09:11:15', '2026-05-26 10:53:12', '2026-05-26 09:11:15', '2026-05-26 10:53:12', '5000.00', 0, '13000.00', '2000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I2SU6VIJCO', 'd9195ada-cea3-489a-b506-2093d83cf921', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6ImtJTGZLb2c1d3YrS0lEWC9Qd3NBSWc9PSIsInZhbHVlIjoiUklvdThEUlJBMm9Fem9NUVpLakxkZz09IiwibWFjIjoiNmVlZjcyMWQ2YjQyYTI2YzgxMmYxYmUxZjhjNTZhNjFmYTMwMzQ1MDFiNjU1NThhNTZhN2UyZmI2ODUzZTgxMCIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Consulta', '20000.00', '0.00', '100.00', 'pendiente_pago', '2026-06-25 11:29:10', NULL, '2026-05-26 11:29:10', '2026-05-26 11:29:10', '5000.00', 0, '13000.00', '2000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'YHYBMZSIBP', 'a7b2d68d-a31b-4f6c-af3b-16b6df758d9a', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6Ik5mV2JTeVJaR2U0eFU5RlhJdis2dnc9PSIsInZhbHVlIjoiQ1g2OTkyV1R1eW1sb3R4S21JaUFmdz09IiwibWFjIjoiMzk0YjdhZmU5OTI5OGI2MjBiZTQ3ODYyMjcwNzFmOGJjZWZlZDU0ZTYzOGE2YmM0ODFkMGVmMTBkOGVmZjU1ZSIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Consulta', '20000.00', '0.00', '100.00', 'pendiente_pago', '2026-06-25 11:37:37', NULL, '2026-05-26 11:37:37', '2026-05-26 11:37:37', '5000.00', 0, '13000.00', '2000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NY4673QSDG', 'c778cf70-1f73-4316-ac11-82fc9843500f', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6ImhQOFVMTmtEKzF6b1R5OVVEaVE1eWc9PSIsInZhbHVlIjoiNUIxbE5tSjBJaFVrZC9jZnQ5SS81dz09IiwibWFjIjoiYmViOTkwNDJjZWE0M2UzODUyNjY1NjI5MjEyOTc5MGZkY2I3ZTgwYzIwMTliZTM2MWQwZWZmODhjNTU4ZGViOSIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Primera consulta veterinaria', '15000.00', '0.00', '100.00', 'activo', '2026-06-25 21:35:24', NULL, '2026-05-26 21:35:24', '2026-05-26 21:35:24', '0.00', 0, '15000.00', '0.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'DRGUC2PMZZ', '4ebe8944-b9df-4344-b2c3-49ea5fcf7481', NULL, NULL, NULL, NULL, NULL, NULL, 'eyJpdiI6IjZ0VlhaNFltcFEzY2FWMGMrTWduSXc9PSIsInZhbHVlIjoiMmUwaTlZUjFGUUl2NG5lY1RQR0xkQT09IiwibWFjIjoiOWQ0NDI0ZTFmMGUxYmRlZDYwNTllZTQwZTY1NjA1MjY3ZGNjZTViMTQ3MGE5NDVjZGFkMjU4OWRkOWYxZDcxZiIsInRhZyI6IiJ9', '82b6b205739a404c49c90593f3f2b3a6b3208cd1293dcfd42a3fe52327a03814', 'jaime kriman', 'consulta', '30000.00', '0.00', '100.00', 'pendiente_pago', '2026-06-25 21:37:38', NULL, '2026-05-26 21:37:38', '2026-05-26 21:37:38', '20000.00', 0, '7000.00', '3000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CEJ698K2NI', '883c0762-dc91-4220-ac44-032c3c2a31f5', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6IkRjcjFYcEJTRUNLVTdkcS9UamVBVlE9PSIsInZhbHVlIjoieE1EUFo4MTZxMjc1blBsZDlob1FxUT09IiwibWFjIjoiOWYwNWVkODFiYjY0ZmYyNGFhMDkwNmEzYWQ0YWI3NjEyYTAxZDY0YTE1MGE2Njc0OTgxMjhiYTBjNGJmMjNlYSIsInRhZyI6IiJ9', '8f999e571717001962fadf3d43af9f8f3c0f7f481c1925e9c11039ca87171e73', 'jose araya', 'vacuna', '32000.00', '0.00', '100.00', 'en_atencion', '2026-06-26 05:14:49', '2026-05-31 05:14:59', '2026-05-27 05:14:49', '2026-05-27 05:14:59', '10000.00', 0, '19000.00', '3000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'RYHSBOOO4P', '6b937114-14ed-4f6f-92fe-ba5ce346fa31', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6IllyMHBhcmJ3R0JnR0J1SkFjNVZrS1E9PSIsInZhbHVlIjoidW1FSlA4Y01zRll3eVh3NFpLUnFuUT09IiwibWFjIjoiN2U3NTY0MjQxZTEzMTJjNjg5MjQ2N2FjNTZjOWZjM2E2MzI1NGU2YzY4ZDM2ODA1ZDcyNzljODEyOGM3MTE1MiIsInRhZyI6IiJ9', '29ae054df99332fa6a573a720ec4867fe12e25b55cc8b7c111fd2309f5c0729d', 'jose araya', 'consulta', '30000.00', '0.00', '100.00', 'en_atencion', '2026-06-26 07:45:33', NULL, '2026-05-27 07:45:33', '2026-05-27 07:45:33', '15000.00', 0, '12000.00', '3000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NKLQSUIWKP', 'd97ebc33-1cbb-4270-9c9d-a124d4fd91ef', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6ImJNeE0xQTk1eEZoU25tSlFoVmYwM3c9PSIsInZhbHVlIjoiMTl5QVJOSWVPQTFvOWhhQi8vMWdRZz09IiwibWFjIjoiMTM3MjZhNGQxNTdhNDg5MjUwMzkyZDVkNTQzNGI2ZTE0MDdlY2M1NzBkMzRhMjZjZjkzNmFhOGVhMjY2ODAwNCIsInRhZyI6IiJ9', '29ae054df99332fa6a573a720ec4867fe12e25b55cc8b7c111fd2309f5c0729d', 'jose araya', 'consulta', '30000.00', '0.00', '100.00', 'pendiente_pago', '2026-06-26 08:11:09', NULL, '2026-05-27 08:11:09', '2026-05-27 08:11:09', '15000.00', 0, '14000.00', '1000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I0KDRMQK9Q', '53cf6dbd-40e8-4bef-aa4c-8648e20ec165', NULL, NULL, NULL, NULL, NULL, NULL, 'eyJpdiI6IkhsaFFVaTZQdEVtamR4Q0VJd2lNN0E9PSIsInZhbHVlIjoiQ3VDT1lDSFBwRnA1ckx1d2kzTmpWUT09IiwibWFjIjoiOWRkZTAzOTEwYWM4Y2EzMDdiMzBlMTYzNmI4YjhlOGZkMjRhYmU2NDUxOTcxNTA2NDhkZGQ1YzgwM2YwNGY0MyIsInRhZyI6IiJ9', '29ae054df99332fa6a573a720ec4867fe12e25b55cc8b7c111fd2309f5c0729d', 'jaime kran', 'consulta', '30000.00', '0.00', '100.00', 'usado', '2026-06-26 08:12:09', '2026-05-27 08:12:20', '2026-05-27 08:12:09', '2026-05-27 08:12:20', '15000.00', 0, '14000.00', '1000.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'XRV4HGBWXH', 'c0686d8f-253f-43dc-b651-d13a9e4dd035', 3, 1, NULL, NULL, NULL, NULL, 'eyJpdiI6Ik8xeVF0Ty9VTTRmenEzMGc2OVVsc2c9PSIsInZhbHVlIjoiUnFDTkluTkZ4ak5seUx6d2pWZ3k0QT09IiwibWFjIjoiYjlmZTlhZDI3ZjFlY2MzZGNhYWQyOTc5NmEyZGViYzRkZjBjMGU0YjQ1MzUyZTc3MDYyZDQzYjMxOWVkODlhMyIsInRhZyI6IiJ9', '5dedf71e6903bbb3c0b08ab5d94db62a4a5dea268bf2ef8d591089345989f82f', 'Cliente Demo', 'Primera consulta veterinaria', '15000.00', '0.00', '100.00', 'usado', '2026-06-27 20:04:23', '2026-05-31 01:50:50', '2026-05-28 20:04:23', '2026-05-31 01:50:50', '0.00', 0, '15000.00', '0.00', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260602144521-OAMI', 'g7q6XhIilskr8ZlYYr2JwAmC8ZmkOFRXBk1X76zFArmbF99ShtiiwNexJZ05rMkXSOcMFpkQLI33mJDA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-02 18:45:21', NULL, '2026-06-02 18:45:21', '2026-06-02 18:45:21', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-02 18:45:21', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260602153250-DEO2', 'ZZqeoQGQPwKB3G2RLEsnJj6JIFStFqNxExvM49wVBnI8x83JZc6Ka62K1IAnmLslHsawRv42aR88vJ6c', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-02 19:32:50', NULL, '2026-06-02 19:32:50', '2026-06-02 19:32:50', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-02 19:32:50', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260602161506-LZXD', 'PzRy6iICClEiU8L54kDHX2exjJZM9oLvT690ISUkeIoZ7J4plvZRpI0o9Ta5aXpjy2By2iJ6Tl6TYDCJ', NULL, NULL, NULL, NULL, NULL, NULL, '12345678-9', NULL, 'Cliente Prueba', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-02 20:15:06', NULL, '2026-06-02 20:15:06', '2026-06-02 20:15:06', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-02 20:15:06', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 9, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260602161759-E7Z1', 'H9AXmcDRURlc0OcKqbPH06kKEni4FK7hHpze8aqRm9Yt25dlGwST8r3rJ8v5pZRebXUyQ9woqsXbZIAN', 9, NULL, NULL, NULL, NULL, NULL, '16187674-k', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-02 20:17:59', NULL, '2026-06-02 20:17:59', '2026-06-02 20:17:59', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-02 20:17:59', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 11, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260602170436-JMQN', 'czf6jKmVt9dmUUB60ZpHCi4LqghpGIdvSOs7w2lYEAQvcq22BUgzBJnfSVSo9aMjdwSt0FMUPSY9TVa2', 9, NULL, NULL, NULL, NULL, NULL, '16187674-k', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-02 21:04:36', NULL, '2026-06-02 21:04:36', '2026-06-02 21:04:36', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-02 21:04:36', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 12, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260603173343-EEYZ', 'sCjCwaUUf7waI1ftlbisGqRsADc83HIYFTEXsoJgtyaOghBtb6DsZygu5vy0YlMAYkbvcNjhQWtOlUGq', 9, NULL, NULL, NULL, NULL, NULL, '16187674-k', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-03 21:33:43', NULL, '2026-06-03 21:33:43', '2026-06-03 21:33:43', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-03 21:33:43', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 14, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260603174112-R3BA', 'ADWCbrgLjPMoj31qIzZKpEbwH2P6abtv0uzSRDJQwVhsH0XGMejqagEoJY58psbZFKSTZi1N8wr4DQJy', 9, NULL, NULL, NULL, NULL, NULL, '16187674-k', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-03 21:41:12', NULL, '2026-06-03 21:41:12', '2026-06-03 21:41:12', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-03 21:41:12', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 15, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260603193527-K1BM', 'TQh4jp5wrFIGiqL9E95ghXhRdrqnPTHYYFfy9kJbZrKFQWcakCHfCG8VkF2RuvGOWHhcMP2jH5P62dKa', 9, NULL, NULL, NULL, NULL, NULL, '16187674-k', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-03 23:35:27', NULL, '2026-06-03 23:35:27', '2026-06-03 23:35:27', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-03 23:35:27', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 16, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260603193539-K90Z', 'KDAZQwM7tYaNDYCWVhTSDCa6qZWJR0dru6DbTVVWf5fs52Zsonm1iGA1dT24kUsnklzl5z7fCyZ7Rzuz', 9, NULL, NULL, NULL, NULL, NULL, '16187674-k', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-03 23:35:39', NULL, '2026-06-03 23:35:39', '2026-06-03 23:35:39', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-03 23:35:39', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 17, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260603193547-Y5AJ', 'FLmHid8jp2jbzr9WroyMrRfgbn9rudP4mnLhGZHnSRWQJCtsxuz16CzY4sI3O8sqQYkkWgqDc4onfMNv', 9, NULL, NULL, NULL, NULL, NULL, '16187674-k', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-03 23:35:47', NULL, '2026-06-03 23:35:47', '2026-06-03 23:35:47', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-03 23:35:47', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 18, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260603193637-AM9H', 'ALnA4fLRcNLNnbHTVhPIGfX8lp9XJr6IikaVJq40JaxJdVtNue2yjWoNr4Le8lBt6ss1C8GXAhT1Z1lc', 9, NULL, NULL, NULL, NULL, NULL, '16187674-k', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-03 23:36:37', NULL, '2026-06-03 23:36:37', '2026-06-03 23:36:37', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-03 23:36:37', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 19, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260604025553-QRKZ', 's17SQXfL7lm6b01vkSfG7wqpesk9vrDKpTnFu4vy0WwzDti5WbR68HNPBo3Uu5TDJ53v1a7ZvELcpoO2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Invitado', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-04 06:55:53', NULL, '2026-06-04 06:55:53', '2026-06-04 06:55:53', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-04 06:55:53', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 20, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260604031446-EHTH', 'nCcbsoXmWE9CCgTaI8OtZNckTqQE57Bq2IMxw4NMCexMXHwiMCBfw9DGUxXMZraMnsrextTTCipc2Rs5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Invitado', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-04 07:14:46', NULL, '2026-06-04 07:14:46', '2026-06-04 07:14:46', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-04 07:14:46', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 21, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260604031844-7IXB', 'fw5LcjSGnKz1p0koahhndos4L4ethQc1N1evp6exB97PSBh7oJ9RiRx30BcNQGp8UstGQWN9gwbu0AXy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Invitado', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-04 07:18:44', NULL, '2026-06-04 07:18:44', '2026-06-04 07:18:44', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-04 07:18:44', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 22, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'VT-20260604035251-CQZ5', 'wEjRURl6PKLqbuji0trcEeDSOtZ8vDMX4GfQIqYK9VYGZKr64o60bVi3x2XBRneNJNaBUODRM0Mh76zr', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '0.00', '100.00', 'activo', '2026-07-04 07:52:51', NULL, '2026-06-04 07:52:51', '2026-06-04 07:52:51', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-04 07:52:51', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(34, 23, NULL, 1, NULL, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, 'VT-20260604083143-MCSY', 'KWljgknOT1nb36F7DbeyzRKv0Joj16LwVVeboPlV2YSnSMBB7OdcSV0uKkacOEPQhjN8LeZofAoZ3A7w', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-04 12:31:43', NULL, '2026-06-04 12:31:43', '2026-06-04 12:31:43', '10000.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-04 12:31:43', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(35, 24, NULL, 1, NULL, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, 'VT-20260605003253-J8QA', 'Wlf6W6J33AveoDQPXEXw4Otgf00O6xaBme6W33GoGJKVRUET1goCnNmPGpk9SZwrKmxBeXhXT0Hg7Xsi', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-05 04:32:53', NULL, '2026-06-05 04:32:53', '2026-06-05 04:32:53', '10000.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-05 04:32:53', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(36, 25, NULL, 1, NULL, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, 'VT-20260605050058-WDQYJ', '4d54ba66-55d5-4660-9620-b1f9be9b8fc4', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-05 09:00:59', NULL, '2026-06-05 09:00:59', '2026-06-05 09:00:59', '10000.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-05 09:00:59', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(37, 26, NULL, 1, NULL, 'Veterinaria Demo', NULL, NULL, NULL, NULL, NULL, 'VT-20260605052927-JBF4W', '5b525386-210c-48eb-8836-adc4366c9a6d', 9, NULL, 'pillan', 3, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-05 09:29:27', NULL, '2026-06-05 09:29:27', '2026-06-05 09:29:27', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-05 09:29:27', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(38, 28, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607061714-O3Q58', 'f60893b9-6ef0-4ca0-b7a5-f1217b1bce55', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'atencion_cerrada', '2026-07-07 10:17:14', NULL, '2026-06-07 10:17:14', '2026-06-11 03:17:28', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 10:17:14', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(39, 29, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607061948-0R0GM', '603f4a07-0ed7-4715-a49c-e354f4c37b91', 9, NULL, 'pillan', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'atencion_cerrada', '2026-07-07 10:19:48', NULL, '2026-06-07 10:19:48', '2026-06-11 03:17:34', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 10:19:48', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(40, 30, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607071903-DKHNB', '82947de8-6bd4-46d4-a670-7cc89dbfa91f', 9, NULL, 'pillan', 4, 'Pastor Aleman', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '38000.00', '100.00', 'activo', '2026-07-07 11:19:03', NULL, '2026-06-07 11:19:03', '2026-06-07 11:19:03', '11400.00', 0, '26600.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 11:19:03', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 30, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607071903-PJX7K', 'd09629d9-0c04-484a-b69f-6282efc6aa78', 9, NULL, 'pillan', 4, 'Pastor Aleman', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '18000.00', '38000.00', '100.00', 'atencion_cerrada', '2026-07-07 11:19:03', NULL, '2026-06-07 11:19:03', '2026-06-11 07:01:02', '11400.00', 0, '26600.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 11:19:03', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 30, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607071903-ELZFF', '7300488e-e9b0-41ea-b7ee-e062f52f553a', 9, NULL, 'pillan', 4, 'Pastor Aleman', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '38000.00', '100.00', 'activo', '2026-07-07 11:19:03', NULL, '2026-06-07 11:19:03', '2026-06-07 11:19:03', '11400.00', 0, '26600.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 11:19:03', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 31, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260607073433-DKHFZ', '681eb721-0de7-44e4-b0d1-577725d0236d', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '28000.00', '100.00', 'activo', '2026-07-07 11:34:33', NULL, '2026-06-07 11:34:33', '2026-06-07 11:34:33', '8400.00', 0, '19600.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 11:34:33', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 31, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260607073433-VV50Q', 'a5c85056-db8a-4e4d-b490-0509fbc016ee', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '18000.00', '28000.00', '100.00', 'activo', '2026-07-07 11:34:33', NULL, '2026-06-07 11:34:33', '2026-06-07 11:34:33', '8400.00', 0, '19600.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 11:34:33', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(45, 32, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260607075043-CMKZL', '386ec818-c689-41b5-bee9-4fc085f287da', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '25000.00', '100.00', 'activo', '2026-07-07 11:50:43', NULL, '2026-06-07 11:50:43', '2026-06-07 11:50:43', '7500.00', 0, '17500.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 11:50:43', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(46, 32, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260607075043-EKQTZ', 'a7ed1e77-0d04-4491-bc2e-bf834bed14af', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '15000.00', '25000.00', '100.00', 'activo', '2026-07-07 11:50:43', NULL, '2026-06-07 11:50:43', '2026-06-07 11:50:43', '7500.00', 0, '17500.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 11:50:43', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, 33, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607075245-33RJ4', 'a944f653-77d0-48a9-944f-2172eb35a7fc', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-07 11:52:45', NULL, '2026-06-07 11:52:45', '2026-06-07 11:52:45', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 11:52:45', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(48, 34, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607080247-YFTA9', '2bd045f2-d8e0-4281-996e-26bdfc33d19d', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '50000.00', '100.00', 'activo', '2026-07-07 12:02:47', NULL, '2026-06-07 12:02:47', '2026-06-07 12:02:47', '15000.00', 0, '35000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 12:02:47', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 34, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607080247-PWT9N', 'b44bce03-5231-4cfe-b0de-dd4ca5268480', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '18000.00', '50000.00', '100.00', 'activo', '2026-07-07 12:02:47', NULL, '2026-06-07 12:02:47', '2026-06-07 12:02:47', '15000.00', 0, '35000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 12:02:47', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 34, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607080247-CF4BR', 'd2bbaf78-8730-42e2-b94b-a05e1e2c40cf', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '22000.00', '50000.00', '100.00', 'activo', '2026-07-07 12:02:47', NULL, '2026-06-07 12:02:47', '2026-06-07 12:02:47', '15000.00', 0, '35000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 12:02:47', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(51, 35, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607083238-TVORQ', '566bfda6-f4bd-4c34-a25f-aa73e420c351', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '38000.00', '100.00', 'activo', '2026-07-07 12:32:38', NULL, '2026-06-07 12:32:38', '2026-06-07 12:32:38', '11400.00', 0, '26600.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 12:32:38', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(52, 35, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607083238-OOCHE', 'c53a951d-c166-4572-abd1-5628322be871', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '18000.00', '38000.00', '100.00', 'activo', '2026-07-07 12:32:38', NULL, '2026-06-07 12:32:38', '2026-06-07 12:32:38', '11400.00', 0, '26600.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 12:32:38', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 35, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607083238-HGTIB', '9a16c40f-d282-4335-a3e7-3e5e7f1917bf', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '38000.00', '100.00', 'activo', '2026-07-07 12:32:38', NULL, '2026-06-07 12:32:38', '2026-06-07 12:32:38', '11400.00', 0, '26600.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 12:32:38', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(54, 36, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607085003-ANKVD', 'd82e6b3a-c61d-4677-b7b7-c517200c62f9', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-07 12:50:03', NULL, '2026-06-07 12:50:03', '2026-06-07 12:50:03', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 12:50:03', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(55, 37, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607193819-YYPUP', 'ab3e91e3-724b-4adf-b3e6-fbbec3bcfd52', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-07 23:38:19', NULL, '2026-06-07 23:38:19', '2026-06-07 23:38:19', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 23:38:19', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 38, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607195502-XJ8CQ', 'd1151ae9-6973-43db-86c0-49257ae9151e', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-07 23:55:02', NULL, '2026-06-07 23:55:02', '2026-06-07 23:55:02', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 23:55:02', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(57, 39, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260607195503-5DNCV', 'cb55db39-4069-4162-925a-a3f0bec79863', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-07 23:55:03', NULL, '2026-06-07 23:55:03', '2026-06-07 23:55:03', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-07 23:55:03', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(58, 40, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260608172645-IMIRI', 'b81f8dda-492e-4feb-9328-002d5cf5f2b0', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '35000.00', '35000.00', '100.00', 'activo', '2026-07-08 21:26:46', NULL, '2026-06-08 21:26:46', '2026-06-08 21:26:46', '10500.00', 0, '24500.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-08 21:26:46', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(59, 41, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260608173023-YFWXA', 'faeec298-be28-46ce-b5c3-dc9d4d7e5947', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-08 21:30:23', NULL, '2026-06-08 21:30:23', '2026-06-08 21:30:23', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-08 21:30:23', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(60, 42, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260609015506-6CARL', '6bde17e2-ef7a-4c35-be65-d0cf132ae7b0', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '18000.00', '18000.00', '100.00', 'activo', '2026-07-09 05:55:07', NULL, '2026-06-09 05:55:07', '2026-06-09 05:55:07', '5400.00', 0, '12600.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 05:55:07', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(61, 43, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609015827-AZXI4', 'fd6fa35b-c886-4dc5-9400-894679eb6bb4', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '25000.00', '25000.00', '100.00', 'activo', '2026-07-09 05:58:27', NULL, '2026-06-09 05:58:27', '2026-06-09 05:58:27', '7500.00', 0, '17500.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 05:58:27', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(62, 44, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260609020100-UMSHR', 'e29fa3b2-f812-4048-91cb-6aec87c69bde', NULL, NULL, NULL, NULL, NULL, NULL, '17174188-2', NULL, 'Invitado', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-09 06:01:00', NULL, '2026-06-09 06:01:00', '2026-06-09 06:01:00', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 06:01:00', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(63, 45, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260609020101-FVSZ0', 'df7c6c8b-e741-488e-9dee-1149ece09010', NULL, NULL, NULL, NULL, NULL, NULL, '17174188-2', NULL, 'Invitado', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-09 06:01:01', NULL, '2026-06-09 06:01:01', '2026-06-09 06:01:01', '0.00', 0, '0.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 06:01:01', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(64, 46, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260609040220-S2ZRI', 'f05c31b0-15ae-4a54-9b52-45df3f34ca7b', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '25000.00', '25000.00', '100.00', 'activo', '2026-07-09 08:02:20', NULL, '2026-06-09 08:02:20', '2026-06-09 08:02:20', '7500.00', 0, '17500.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 08:02:20', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(65, 47, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609040717-BIZYK', '83f41b85-e1e7-4706-93ab-9858079bc859', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '37000.00', '100.00', 'activo', '2026-07-09 08:07:17', NULL, '2026-06-09 08:07:17', '2026-06-09 08:07:17', '11100.00', 0, '25900.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 08:07:17', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(66, 47, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609040717-7FNYJ', '84cb119a-afe6-41b1-9812-eb7a57adf14b', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '15000.00', '37000.00', '100.00', 'activo', '2026-07-09 08:07:17', NULL, '2026-06-09 08:07:17', '2026-06-09 08:07:17', '11100.00', 0, '25900.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 08:07:17', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(67, 47, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609040717-LMNKJ', 'f851690f-51c3-4263-ab09-5b8da098912f', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '12000.00', '37000.00', '100.00', 'activo', '2026-07-09 08:07:17', NULL, '2026-06-09 08:07:17', '2026-06-09 08:07:17', '11100.00', 0, '25900.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 08:07:17', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(68, 48, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609041009-MXOEO', '09eaf201-47a4-44b3-b0ae-00725296fd97', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '34000.00', '100.00', 'activo', '2026-07-09 08:10:09', NULL, '2026-06-09 08:10:09', '2026-06-09 08:10:09', '10200.00', 0, '23800.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 08:10:09', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(69, 48, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609041009-TKTJL', 'dbb1f061-b7e2-48cb-8c70-3f8bbe486cbd', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '12000.00', '34000.00', '100.00', 'activo', '2026-07-09 08:10:09', NULL, '2026-06-09 08:10:09', '2026-06-09 08:10:09', '10200.00', 0, '23800.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 08:10:09', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(70, 48, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609041009-DEBRV', 'c31e5573-2993-4085-ac20-579627417ee3', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '12000.00', '34000.00', '100.00', 'activo', '2026-07-09 08:10:09', NULL, '2026-06-09 08:10:09', '2026-06-09 08:10:09', '10200.00', 0, '23800.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 08:10:09', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(71, 49, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609044351-WPAC6', '81628788-422d-4f02-91e3-71cbf8e48dab', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-09 08:43:52', NULL, '2026-06-09 08:43:52', '2026-06-09 08:43:52', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 08:43:52', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(72, 50, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260609045823-MSTYM', '845a26b3-81c0-4771-8fa4-5e55765dbd29', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-09 08:58:23', NULL, '2026-06-09 08:58:23', '2026-06-09 08:58:23', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 08:58:23', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(73, 51, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609050047-EWV9Z', '36f7b477-5286-427f-80ab-151347ef2874', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-09 09:00:47', NULL, '2026-06-09 09:00:47', '2026-06-09 09:00:47', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 09:00:47', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(74, 52, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609051223-KT4EE', '3a06792a-3fbc-4313-8066-cd7892b33ffb', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '35000.00', '35000.00', '100.00', 'activo', '2026-07-09 09:12:23', NULL, '2026-06-09 09:12:23', '2026-06-09 09:12:23', '10500.00', 0, '24500.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 09:12:23', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(75, 53, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609052409-XDVU0', 'cafd4d2a-fa9d-41c6-a5b3-dee648832193', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '30000.00', '100.00', 'activo', '2026-07-09 09:24:09', NULL, '2026-06-09 09:24:09', '2026-06-09 09:24:09', '9000.00', 0, '21000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 09:24:09', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(76, 53, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609052409-RIBUU', 'ea556dd2-c98a-41bc-b068-d35ab8cd8e4a', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '20000.00', '30000.00', '100.00', 'activo', '2026-07-09 09:24:09', NULL, '2026-06-09 09:24:09', '2026-06-09 09:24:09', '9000.00', 0, '21000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 09:24:09', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(77, 54, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609060137-4CX9K', '9e5afe5d-07ac-403a-948c-81d548eb7795', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-09 10:01:37', NULL, '2026-06-09 10:01:37', '2026-06-09 10:01:37', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 10:01:37', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(78, 55, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609061948-MKJDB', '42005542-25b5-4f93-b849-7fe1b89e2de8', 9, NULL, 'Firulais', NULL, 'Mestizo', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-09 10:19:48', NULL, '2026-06-09 10:19:48', '2026-06-09 10:19:48', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 10:19:48', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(79, 56, NULL, 4, '15.455.789-5', 'Dra. daniela Demo', 'Ginecologia-Veterinaria', 'consultagine@vet.cl', '+56921212121', NULL, NULL, 'VT-20260609062256-3MRCO', '1bfed1b8-9df4-4697-88da-fb3763ac75bb', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '22000.00', '22000.00', '100.00', 'activo', '2026-07-09 10:22:56', NULL, '2026-06-09 10:22:56', '2026-06-09 10:22:56', '6600.00', 0, '15400.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 10:22:56', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `vouchers` (`id`, `totem_venta_id`, `vendedor_id`, `profesional_id`, `prestador_rut`, `prestador_nombre`, `prestador_especialidad`, `prestador_email`, `prestador_telefono`, `prestador_direccion`, `servicio_id`, `codigo`, `qr_token`, `cliente_id`, `mascota_id`, `mascota_nombre`, `mascota_edad`, `mascota_raza`, `criadero_cachorro_id`, `cliente_rut`, `cliente_rut_hash`, `cliente_nombre`, `tipo_servicio`, `valor`, `valor_total`, `porcentaje_descuento`, `estado`, `fecha_vencimiento`, `usado_en`, `created_at`, `updated_at`, `copago_usuario`, `saldo_cliente_aplicado`, `saldo_veterinario`, `comision_veterchile`, `cliente_aceptado_en`, `cliente_rechazado_en`, `motivo_rechazo_cliente`, `qr_firma`, `qr_expira`, `qr_usado`, `qr_usado_at`, `invalidado_en`, `motivo_invalidacion`, `copago_devuelto`, `otp_hash`, `otp_expira`, `otp_validado_at`, `agenda_id`, `atencion_id`, `profesional_atendio_id`, `asistente_valido_id`, `atencion_cerrada_at`, `validado_at`, `ip_profesional`, `ip_asistente`, `estado_validacion`, `riesgo_validacion`) VALUES
(80, 57, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609063320-EAMMG', 'f453b9e8-b6aa-47a7-9b9f-e395fad19f04', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '12000.00', '12000.00', '100.00', 'activo', '2026-07-09 10:33:20', NULL, '2026-06-09 10:33:20', '2026-06-09 10:33:20', '3600.00', 0, '8400.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 10:33:20', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(81, 58, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609064232-SKWRC', '38396020-1dd2-41e8-859d-fdd0c92e7faf', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '15000.00', '15000.00', '100.00', 'cobrado', '2026-07-09 10:42:32', '2026-06-11 00:01:36', '2026-06-09 10:42:32', '2026-06-11 00:01:36', '4500.00', 0, '10500.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 10:42:32', 1, '2026-06-11 00:01:36', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(82, 59, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609074524-SWYOS', '5cf360ee-4193-454e-96df-f9fec0df2372', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '15000.00', '27000.00', '100.00', 'validado_atencion', '2026-07-09 11:45:24', NULL, '2026-06-09 11:45:24', '2026-06-11 07:22:52', '8100.00', 0, '18900.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 11:45:24', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(83, 59, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260609074524-WD71U', 'bc683256-047a-4509-89a8-93662c119294', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '12000.00', '27000.00', '100.00', 'validado_atencion', '2026-07-09 11:45:24', NULL, '2026-06-09 11:45:24', '2026-06-11 07:23:15', '8100.00', 0, '18900.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-09 11:45:24', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(84, 60, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260610221525-XNYQM', 'd7ac338c-dfed-49e3-b8e3-9bcf7336f2a3', 9, NULL, NULL, NULL, NULL, NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '15000.00', '15000.00', '100.00', 'validado_atencion', '2026-07-11 02:15:26', NULL, '2026-06-11 02:15:26', '2026-06-11 07:23:36', '4500.00', 0, '10500.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-11 02:15:26', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(85, 61, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260610221631-OJZSX', '4336f080-7977-4d75-9ff0-ddb763afd1da', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Invitado', 'Voucher Tótem', '18000.00', '18000.00', '100.00', 'activo', '2026-07-11 02:16:31', NULL, '2026-06-11 02:16:31', '2026-06-11 02:16:31', '5400.00', 0, '12600.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-11 02:16:31', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(86, 62, NULL, 2, '6.521.212-3', 'jacob kriman', 'veterinaria clinica', 'jkran@gmail.com', '9 9547 4633', NULL, NULL, 'VT-20260629041143-WJAU4', 'a04e2e75-42de-40c4-88c7-29e5d9a4afde', 9, NULL, 'pillan', 8, 'pastor', NULL, '16.187.674-K', NULL, 'KATHERINE BASTIAS', 'Voucher Tótem', '10000.00', '10000.00', '100.00', 'activo', '2026-07-29 08:11:44', NULL, '2026-06-29 08:11:44', '2026-06-29 08:11:44', '3000.00', 0, '7000.00', '0.00', NULL, NULL, NULL, NULL, '2026-07-29 08:11:44', 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_agendas`
--

CREATE TABLE `voucher_agendas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_id` bigint(20) UNSIGNED NOT NULL,
  `cliente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mascota_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profesional_id` bigint(20) UNSIGNED DEFAULT NULL,
  `centro_atencion_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fecha_hora_solicitada` datetime DEFAULT NULL,
  `fecha_hora_confirmada` datetime DEFAULT NULL,
  `estado` enum('hora_solicitada','hora_confirmada','paciente_cancela','prestador_cancela','atencion_realizada','no_asiste') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'hora_solicitada',
  `observacion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_agendas`
--

INSERT INTO `voucher_agendas` (`id`, `voucher_id`, `cliente_id`, `mascota_id`, `profesional_id`, `centro_atencion_id`, `fecha_hora_solicitada`, `fecha_hora_confirmada`, `estado`, `observacion`, `created_at`, `updated_at`) VALUES
(1, 81, 9, NULL, 2, NULL, '2026-06-10 10:00:00', '2026-06-10 10:00:00', 'atencion_realizada', 'Control general', '2026-06-10 09:28:02', '2026-06-10 11:33:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_alertas`
--

CREATE TABLE `voucher_alertas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_id` bigint(20) UNSIGNED NOT NULL,
  `tipo_alerta` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nivel` enum('verde','amarillo','rojo') COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `resuelta` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_alertas`
--

INSERT INTO `voucher_alertas` (`id`, `voucher_id`, `tipo_alerta`, `nivel`, `descripcion`, `resuelta`, `created_at`, `updated_at`) VALUES
(1, 1, 'duplicado_dia', 'rojo', 'Mascota repetida mismo día', 1, '2026-05-30 02:56:33', '2026-05-30 06:56:53'),
(2, 81, 'riesgo_validacion_atencion', 'amarillo', 'Atención validada con riesgo medio. Prueba antifraude.', 0, '2026-06-11 02:32:51', '2026-06-11 02:32:51'),
(3, 82, 'riesgo_validacion_atencion', 'amarillo', 'Atención validada con riesgo medio. Revisar IP/profesional/asistente.', 0, '2026-06-11 07:22:52', '2026-06-11 07:22:52'),
(4, 83, 'riesgo_validacion_atencion', 'amarillo', 'Atención validada con riesgo medio. Revisar IP/profesional/asistente.', 0, '2026-06-11 07:23:15', '2026-06-11 07:23:15'),
(5, 84, 'riesgo_validacion_atencion', 'amarillo', 'Atención validada con riesgo medio. Revisar IP/profesional/asistente.', 0, '2026-06-11 07:23:36', '2026-06-11 07:23:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_atenciones`
--

CREATE TABLE `voucher_atenciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_id` bigint(20) UNSIGNED NOT NULL,
  `agenda_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cliente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mascota_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profesional_id` bigint(20) UNSIGNED DEFAULT NULL,
  `asistente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `inicio_atencion` datetime DEFAULT NULL,
  `fin_atencion` datetime DEFAULT NULL,
  `cerrada_at` datetime DEFAULT NULL,
  `validada_at` datetime DEFAULT NULL,
  `ip_profesional` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_asistente` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent_profesional` text COLLATE utf8mb4_unicode_ci,
  `user_agent_asistente` text COLLATE utf8mb4_unicode_ci,
  `lat` decimal(10,7) DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('abierta','cerrada_por_profesional','validada_por_asistente','observada','rechazada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'abierta',
  `riesgo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'bajo',
  `hash_auditoria` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacion` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_atenciones`
--

INSERT INTO `voucher_atenciones` (`id`, `voucher_id`, `agenda_id`, `cliente_id`, `mascota_id`, `profesional_id`, `asistente_id`, `inicio_atencion`, `fin_atencion`, `cerrada_at`, `validada_at`, `ip_profesional`, `ip_asistente`, `user_agent_profesional`, `user_agent_asistente`, `lat`, `lng`, `direccion`, `estado`, `riesgo`, `hash_auditoria`, `observacion`, `created_at`, `updated_at`) VALUES
(1, 81, 1, 9, NULL, 2, 101, '2026-06-10 07:33:35', '2026-06-10 07:33:35', '2026-06-10 07:33:35', '2026-06-10 07:57:16', '127.0.0.1', '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CL) WindowsPowerShell/5.1.19041.6456', NULL, NULL, 'Recepcion VeterChile', 'validada_por_asistente', 'medio', '2215710cc73b04a98659dbc59ea621e6294cda044ca6f08d88075b7e7277c56a', NULL, '2026-06-10 11:33:35', '2026-06-10 11:57:16'),
(2, 38, NULL, 9, NULL, 2, NULL, '2026-06-10 23:17:28', '2026-06-10 23:17:28', '2026-06-10 23:17:28', NULL, '127.0.0.1', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', NULL, NULL, NULL, NULL, 'cerrada_por_profesional', 'bajo', NULL, 'Atención finalizada desde panel profesional', '2026-06-11 03:17:28', '2026-06-11 03:17:28'),
(3, 39, NULL, 9, NULL, 2, NULL, '2026-06-10 23:17:34', '2026-06-10 23:17:34', '2026-06-10 23:17:34', NULL, '127.0.0.1', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', NULL, NULL, NULL, NULL, 'cerrada_por_profesional', 'bajo', NULL, 'Atención finalizada desde panel profesional', '2026-06-11 03:17:34', '2026-06-11 03:17:34'),
(4, 82, NULL, 9, NULL, 2, NULL, '2026-06-10 23:17:36', '2026-06-10 23:17:36', '2026-06-10 23:17:36', NULL, '127.0.0.1', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', NULL, NULL, NULL, NULL, 'cerrada_por_profesional', 'bajo', NULL, 'Atención finalizada desde panel profesional', '2026-06-11 03:17:36', '2026-06-11 03:17:36'),
(5, 41, NULL, 9, NULL, 2, NULL, '2026-06-11 03:01:02', '2026-06-11 03:01:02', '2026-06-11 03:01:02', NULL, '127.0.0.1', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', NULL, NULL, NULL, NULL, 'cerrada_por_profesional', 'bajo', NULL, 'Atención finalizada desde panel profesional', '2026-06-11 07:01:02', '2026-06-11 07:01:02'),
(6, 83, NULL, 9, NULL, 2, NULL, '2026-06-11 03:01:04', '2026-06-11 03:01:04', '2026-06-11 03:01:04', NULL, '127.0.0.1', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', NULL, NULL, NULL, NULL, 'cerrada_por_profesional', 'bajo', NULL, 'Atención finalizada desde panel profesional', '2026-06-11 07:01:04', '2026-06-11 07:01:04'),
(7, 84, NULL, 9, NULL, 2, NULL, '2026-06-11 03:01:06', '2026-06-11 03:01:06', '2026-06-11 03:01:06', NULL, '127.0.0.1', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', NULL, NULL, NULL, NULL, 'cerrada_por_profesional', 'bajo', NULL, 'Atención finalizada desde panel profesional', '2026-06-11 07:01:06', '2026-06-11 07:01:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_auditorias`
--

CREATE TABLE `voucher_auditorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_id` bigint(20) UNSIGNED DEFAULT NULL,
  `accion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario_tipo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario_id` bigint(20) UNSIGNED DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_auditorias`
--

INSERT INTO `voucher_auditorias` (`id`, `voucher_id`, `accion`, `usuario_tipo`, `usuario_id`, `descripcion`, `ip`, `created_at`, `updated_at`) VALUES
(1, 18, 'atencion_finalizada', 'profesional', 1, 'Atención finalizada y voucher enviado a cobro/rendición', '127.0.0.1', '2026-05-30 09:24:27', '2026-05-30 09:24:27'),
(2, 6, 'atencion_finalizada', 'profesional', 1, 'Atención finalizada y voucher enviado a cobro/rendición', '127.0.0.1', '2026-05-30 09:24:29', '2026-05-30 09:24:29'),
(3, 5, 'atencion_finalizada', 'profesional', 1, 'Atención finalizada y voucher enviado a cobro/rendición', '127.0.0.1', '2026-05-30 09:33:33', '2026-05-30 09:33:33'),
(4, 2, 'atencion_finalizada', 'profesional', 1, 'Atención finalizada y voucher enviado a cobro/rendición', '127.0.0.1', '2026-05-31 00:39:36', '2026-05-31 00:39:36'),
(5, 18, 'atencion_finalizada', 'profesional', 1, 'Atención finalizada y voucher enviado a cobro/rendición', '127.0.0.1', '2026-05-31 01:50:50', '2026-05-31 01:50:50'),
(6, 83, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 00:32:15', '2026-06-11 00:32:15'),
(7, 83, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 00:32:19', '2026-06-11 00:32:19'),
(8, 83, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 00:32:23', '2026-06-11 00:32:23'),
(9, 82, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 00:32:24', '2026-06-11 00:32:24'),
(10, 38, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:28', '2026-06-11 02:21:28'),
(11, 38, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:35', '2026-06-11 02:21:35'),
(12, 85, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:37', '2026-06-11 02:21:37'),
(13, 85, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:39', '2026-06-11 02:21:39'),
(14, 85, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:41', '2026-06-11 02:21:41'),
(15, 84, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:42', '2026-06-11 02:21:42'),
(16, 84, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:44', '2026-06-11 02:21:44'),
(17, 83, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:46', '2026-06-11 02:21:46'),
(18, 82, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:48', '2026-06-11 02:21:48'),
(19, 80, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:52', '2026-06-11 02:21:52'),
(20, 84, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:55', '2026-06-11 02:21:55'),
(21, 84, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:55', '2026-06-11 02:21:55'),
(22, 83, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:56', '2026-06-11 02:21:56'),
(23, 83, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:57', '2026-06-11 02:21:57'),
(24, 82, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:58', '2026-06-11 02:21:58'),
(25, 82, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:59', '2026-06-11 02:21:59'),
(26, 82, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:21:59', '2026-06-11 02:21:59'),
(27, 80, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:22:01', '2026-06-11 02:22:01'),
(28, 80, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:22:01', '2026-06-11 02:22:01'),
(29, 38, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:22:20', '2026-06-11 02:22:20'),
(30, 38, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:22:24', '2026-06-11 02:22:24'),
(31, 38, 'cobro_rechazado_sin_otp', 'profesional', 23, 'Intento de cobro sin validación OTP', '127.0.0.1', '2026-06-11 02:24:41', '2026-06-11 02:24:41'),
(32, 38, 'atencion_cerrada_profesional', 'profesional', 23, 'Atención cerrada por profesional. Pendiente validación asistente.', '127.0.0.1', '2026-06-11 03:17:28', '2026-06-11 03:17:28'),
(33, 39, 'atencion_cerrada_profesional', 'profesional', 23, 'Atención cerrada por profesional. Pendiente validación asistente.', '127.0.0.1', '2026-06-11 03:17:34', '2026-06-11 03:17:34'),
(34, 82, 'atencion_cerrada_profesional', 'profesional', 23, 'Atención cerrada por profesional. Pendiente validación asistente.', '127.0.0.1', '2026-06-11 03:17:36', '2026-06-11 03:17:36'),
(35, 41, 'atencion_cerrada_profesional', 'profesional', 23, 'Atención cerrada por profesional. Pendiente validación asistente.', '127.0.0.1', '2026-06-11 07:01:02', '2026-06-11 07:01:02'),
(36, 83, 'atencion_cerrada_profesional', 'profesional', 23, 'Atención cerrada por profesional. Pendiente validación asistente.', '127.0.0.1', '2026-06-11 07:01:04', '2026-06-11 07:01:04'),
(37, 84, 'atencion_cerrada_profesional', 'profesional', 23, 'Atención cerrada por profesional. Pendiente validación asistente.', '127.0.0.1', '2026-06-11 07:01:06', '2026-06-11 07:01:06'),
(38, NULL, 'liquidacion_autorizada_profesional', 'profesional', 2, 'Liquidación autorizada desde dispositivo profesional', '127.0.0.1', '2026-06-14 10:21:51', '2026-06-14 10:21:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_cobros`
--

CREATE TABLE `voucher_cobros` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_id` bigint(20) UNSIGNED NOT NULL,
  `profesional_id` bigint(20) UNSIGNED DEFAULT NULL,
  `voucher_rendicion_id` bigint(20) UNSIGNED DEFAULT NULL,
  `veterinario_id` bigint(20) UNSIGNED DEFAULT NULL,
  `veterinario_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sucursal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monto_cobrado` decimal(10,2) NOT NULL DEFAULT '0.00',
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente_rendicion',
  `cobrado_en` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_cobros`
--

INSERT INTO `voucher_cobros` (`id`, `voucher_id`, `profesional_id`, `voucher_rendicion_id`, `veterinario_id`, `veterinario_nombre`, `sucursal`, `monto_cobrado`, `estado`, `cobrado_en`, `created_at`, `updated_at`) VALUES
(1, 8, 1, 1, NULL, 'Veterinaria Demo', 'Sucursal Centro', '13000.00', 'rendido', '2026-05-26 21:48:04', '2026-05-26 21:48:04', '2026-05-27 05:12:46'),
(2, 14, 1, 2, NULL, 'Veterinaria Demo', 'Sucursal Centro', '19000.00', 'rendido', '2026-05-27 05:14:59', '2026-05-27 05:14:59', '2026-05-31 01:50:31'),
(3, 17, 1, 2, NULL, 'Veterinaria Demo', 'Sucursal Centro', '14000.00', 'rendido', '2026-05-27 08:12:21', '2026-05-27 08:12:21', '2026-05-31 01:50:31'),
(4, 18, 1, 2, NULL, 'Veterinaria Demo', 'Sucursal principal', '15000.00', 'rendido', '2026-05-30 09:24:27', '2026-05-30 09:24:27', '2026-05-31 01:50:31'),
(5, 6, 1, 2, NULL, 'Veterinaria Demo', 'Sucursal principal', '15000.00', 'rendido', '2026-05-30 09:24:29', '2026-05-30 09:24:29', '2026-05-31 01:50:31'),
(6, 5, 1, 2, NULL, 'Veterinaria Demo', 'Sucursal principal', '15000.00', 'rendido', '2026-05-30 09:33:33', '2026-05-30 09:33:33', '2026-05-31 01:50:31'),
(7, 2, 1, 2, NULL, 'Veterinaria Demo', 'Sucursal principal', '20000.00', 'rendido', '2026-05-31 00:39:36', '2026-05-31 00:39:36', '2026-05-31 01:50:31'),
(8, 18, 1, 3, NULL, 'Veterinaria Demo', 'Sucursal principal', '15000.00', 'rendido', '2026-05-31 01:50:50', '2026-05-31 01:50:50', '2026-05-31 03:29:45'),
(9, 81, 2, 4, NULL, 'jacob kriman', 'Sucursal Centro', '10500.00', 'rendido', '2026-06-11 00:01:28', '2026-06-11 00:01:28', '2026-06-11 00:32:01'),
(10, 82, 2, NULL, NULL, 'jacob kriman', 'Sucursal principal', '18900.00', 'pendiente_rendicion', '2026-06-11 07:22:52', '2026-06-11 07:22:52', '2026-06-11 07:22:52'),
(11, 83, 2, NULL, NULL, 'jacob kriman', 'Sucursal principal', '18900.00', 'pendiente_rendicion', '2026-06-11 07:23:15', '2026-06-11 07:23:15', '2026-06-11 07:23:15'),
(12, 84, 2, NULL, NULL, 'jacob kriman', 'Sucursal principal', '10500.00', 'pendiente_rendicion', '2026-06-11 07:23:36', '2026-06-11 07:23:36', '2026-06-11 07:23:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_liquidaciones`
--

CREATE TABLE `voucher_liquidaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_rendicion_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profesional_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profesional_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banco` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_cuenta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_cuenta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monto_profesional` decimal(10,2) NOT NULL DEFAULT '0.00',
  `comision_veterchile` decimal(10,2) NOT NULL DEFAULT '0.00',
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente_pago',
  `medio_pago` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comprobante_transferencia` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagado_en` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_liquidaciones`
--

INSERT INTO `voucher_liquidaciones` (`id`, `voucher_rendicion_id`, `profesional_id`, `profesional_nombre`, `banco`, `tipo_cuenta`, `numero_cuenta`, `monto_profesional`, `comision_veterchile`, `estado`, `medio_pago`, `comprobante_transferencia`, `pagado_en`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 'Veterinaria Demo', 'Banco Estado', 'Cuenta Corriente', '123456789', '15000.00', '0.00', 'pendiente_pago', NULL, NULL, NULL, '2026-05-31 03:29:50', '2026-05-31 03:29:50'),
(2, 4, 2, 'jacob kriman', 'itau', 'corriente', '521221212', '10500.00', '0.00', 'pendiente_revision_admin', NULL, NULL, NULL, '2026-06-11 01:45:50', '2026-06-14 10:21:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_logs`
--

CREATE TABLE `voucher_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `accion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_mascotas`
--

CREATE TABLE `voucher_mascotas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cliente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `especie` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `raza` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sexo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `microchip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dueno_rut` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dueno_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dueno_telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dueno_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `dueno_rut_hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dueno_telefono_hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dueno_email_hash` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_mascotas`
--

INSERT INTO `voucher_mascotas` (`id`, `cliente_id`, `nombre`, `especie`, `raza`, `sexo`, `fecha_nacimiento`, `edad`, `color`, `microchip`, `dueno_rut`, `dueno_nombre`, `dueno_telefono`, `dueno_email`, `activo`, `created_at`, `updated_at`, `dueno_rut_hash`, `dueno_telefono_hash`, `dueno_email_hash`) VALUES
(1, 9, 'Firulais', 'Canino', 'Mestizo', 'Macho', NULL, NULL, NULL, NULL, 'eyJpdiI6Illwd3RCRkRJajFhaXVFZ0hjRkVaSEE9PSIsInZhbHVlIjoiazZwT2xUdWlBRzdOVXFQNldtcWhiUT09IiwibWFjIjoiYmYxZjliNjFmNGZkNmU0MzNjNmJhMDBhZDA4M2E1OGEyNWMyZjgzZjVhMjI1OGNiZWNjNzYzZTM1ZjE5ZGY3MSIsInRhZyI6IiJ9', 'eyJpdiI6Im80K3VobFJNT1ZtMEk1LzBFVmx2WlE9PSIsInZhbHVlIjoiZnZEaXgxUWVQdjE5QmY1TTRxYnVQdzNwVHpZMlB0RTlJZ25lU1lDSzE0Yz0iLCJtYWMiOiJiMmIyZDZlMWY1MzJkNTNlYWIxMjRjNmI2OWFkMGRjYjQ4YzhiM2U2Y2I0OTRlNGU1YWNhZGE4NmFkMDNjMDg1IiwidGFnIjoiIn0=', 'eyJpdiI6IkRJQ3JNVnAyMFd0QytpUmV5cFZFMGc9PSIsInZhbHVlIjoibUl1NHpyQktleTUwTDdkOHB4THI1QT09IiwibWFjIjoiZWEyNTFiOTYwMzAyMDEwOTQxZTkyMzM1OThiMjgwNTQ0MDE3NzAzODY2ZjA0MDZmNjU1YTYwNmVlM2JlNmRhZCIsInRhZyI6IiJ9', NULL, 1, '2026-05-31 02:54:03', '2026-06-08 05:55:15', '2cf1ab00ee248d2fc337d34be06f557518e8e5075f76705369ba6219c5b2f9aa', '80cadc37e32c5e257f68136c91a82cca4a1ac1c66e2e403e7bc9153ca4dca291', NULL),
(2, 9, 'pillan', 'canino', 'pastor', NULL, NULL, 8, NULL, NULL, 'eyJpdiI6IktuOXJ1aU0vd1gySk5PY042d2xYZGc9PSIsInZhbHVlIjoiaXVpaC9TS0ZWSTZXa0k0VkZiKzI3QT09IiwibWFjIjoiNmQ5MTU1NjFmN2Q3NTVkNDcwYmM0MWUxNzgyYzVlMmVlOTcwMzdmYjFkMGE2MzZmYmRjZTNjNDBhMDNiNjc3NyIsInRhZyI6IiJ9', 'eyJpdiI6IitxM2ZvZ2YyaFNDUnRvVCsrZ2hDNFE9PSIsInZhbHVlIjoiWjkrbUJTajdGZDQvaXAwb3NDR3hRUT09IiwibWFjIjoiMmFkZjk5MDlmOWY5Y2RmOTIxNjc0MzBlZGM1ZDQ3YjMyYzZjNmI1MzUyNGUwZDEyNjc1ZjUzYzU2ZmE5NDY1ZiIsInRhZyI6IiJ9', NULL, NULL, 1, '2026-06-07 12:28:17', '2026-06-08 05:55:15', '5c8bbad3d829ce24fd03225c93ff4c6aa1667f56220400b89cd0be6202eeb236', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_pagos`
--

CREATE TABLE `voucher_pagos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `voucher_id` bigint(20) UNSIGNED NOT NULL,
  `monto_pagado_usuario` decimal(10,2) NOT NULL DEFAULT '0.00',
  `metodo_pago` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_pago` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `comprobante` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_pagos`
--

INSERT INTO `voucher_pagos` (`id`, `voucher_id`, `monto_pagado_usuario`, `metodo_pago`, `estado_pago`, `comprobante`, `created_at`, `updated_at`) VALUES
(1, 9, '5000.00', 'demo', 'pagado', NULL, '2026-05-26 09:11:15', '2026-05-26 10:49:27'),
(2, 10, '5000.00', 'pendiente', 'pendiente', NULL, '2026-05-26 11:29:10', '2026-05-26 11:29:10'),
(3, 11, '5000.00', 'pendiente', 'pendiente', NULL, '2026-05-26 11:37:38', '2026-05-26 11:37:38'),
(4, 12, '0.00', 'pendiente', 'pagado', NULL, '2026-05-26 21:35:24', '2026-05-26 21:35:24'),
(5, 18, '0.00', 'pendiente', 'pagado', NULL, '2026-05-28 20:04:23', '2026-05-28 20:04:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_profesionales`
--

CREATE TABLE `voucher_profesionales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rut` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `especialidad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `banco` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_cuenta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_cuenta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `titular_cuenta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rut_cuenta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_profesionales`
--

INSERT INTO `voucher_profesionales` (`id`, `nombre`, `rut`, `especialidad`, `telefono`, `email`, `activo`, `banco`, `tipo_cuenta`, `numero_cuenta`, `titular_cuenta`, `rut_cuenta`, `created_at`, `updated_at`) VALUES
(1, 'Veterinaria Demo', '22222222-2', 'Veterinaria general', '999999999', 'vetdemo@veterchile.cl', 1, 'Banco Estado', 'Cuenta Corriente', '123456789', 'Veterinaria Demo SpA', '76222222-2', '2026-05-27 08:36:33', '2026-05-27 08:36:33'),
(2, 'jacob kriman', '6.521.212-3', 'veterinaria clinica', '9 9547 4633', 'jkran@gmail.com', 1, 'itau', 'corriente', '521221212', 'jacob kriman', '454564564', '2026-05-28 21:21:05', '2026-05-28 21:21:05'),
(3, 'Dr. Veterinario Demo', '12.345.678-9', 'cirugia veterinaria', '+56912345678', 'consulta@vet.cl', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Dra. daniela Demo', '15.455.789-5', 'Ginecologia-Veterinaria', '+56921212121', 'consultagine@vet.cl', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_rendiciones`
--

CREATE TABLE `voucher_rendiciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `veterinario_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sucursal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_cobrado` decimal(10,2) NOT NULL DEFAULT '0.00',
  `cantidad_vouchers` int(11) NOT NULL DEFAULT '0',
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `rendida_en` timestamp NULL DEFAULT NULL,
  `pagada_en` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_rendiciones`
--

INSERT INTO `voucher_rendiciones` (`id`, `veterinario_nombre`, `sucursal`, `total_cobrado`, `cantidad_vouchers`, `estado`, `rendida_en`, `pagada_en`, `created_at`, `updated_at`) VALUES
(1, 'Veterinaria Demo', 'Sucursal Centro', '13000.00', 1, 'pendiente', '2026-05-27 05:12:46', NULL, '2026-05-27 05:12:46', '2026-05-27 05:12:46'),
(2, 'Profesional Demo', 'Sucursal principal', '98000.00', 6, 'pendiente', '2026-05-31 01:50:31', NULL, '2026-05-31 01:50:31', '2026-05-31 01:50:31'),
(3, 'Veterinaria Demo', 'Sucursal Centro', '15000.00', 1, 'liquidacion_generada', '2026-05-31 03:29:45', NULL, '2026-05-31 03:29:45', '2026-05-31 03:29:50'),
(4, 'Jacob Kriman', 'Sucursal principal', '10500.00', 1, 'autorizada_por_profesional', '2026-06-11 00:32:01', NULL, '2026-06-11 00:32:01', '2026-06-14 10:21:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_servicios`
--

CREATE TABLE `voucher_servicios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `valor_base` decimal(10,2) NOT NULL DEFAULT '0.00',
  `copago_base` decimal(10,2) NOT NULL DEFAULT '0.00',
  `comision_veterchile` decimal(10,2) NOT NULL DEFAULT '0.00',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_servicios`
--

INSERT INTO `voucher_servicios` (`id`, `nombre`, `descripcion`, `valor_base`, `copago_base`, `comision_veterchile`, `activo`, `created_at`, `updated_at`) VALUES
(1, 'Consulta General', 'Consulta veterinaria general', '20000.00', '5000.00', '2000.00', 1, '2026-05-31 02:53:35', '2026-05-31 02:53:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voucher_vendedores`
--

CREATE TABLE `voucher_vendedores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rut` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `voucher_vendedores`
--

INSERT INTO `voucher_vendedores` (`id`, `nombre`, `rut`, `email`, `telefono`, `activo`, `created_at`, `updated_at`) VALUES
(1, 'Vendedor Demo', '11111111-1', 'demo@veterchile.cl', '999999999', 1, '2026-05-27 04:31:01', '2026-05-27 04:31:01'),
(2, 'francisco rojo', '455521212-3', 'jkrim@gmail.com', '9 95399660', 1, '2026-05-28 21:32:27', '2026-05-28 21:32:27'),
(3, 'vendedorvaucher', '455521212-3', 'vv@gmail.com', '9 95399660', 1, '2026-05-29 07:59:41', '2026-05-29 07:59:41'),
(4, 'ventas', '6.187.474-k', 'ventas@veterchile.cl', '9 95399660', 1, '2026-05-29 08:33:14', '2026-05-29 08:33:14');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditor_notificaciones`
--
ALTER TABLE `auditor_notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `auditor_notificaciones_voucher_id_index` (`voucher_id`),
  ADD KEY `auditor_notificaciones_alerta_id_index` (`alerta_id`),
  ADD KEY `auditor_notificaciones_leido_index` (`leido`);

--
-- Indices de la tabla `campanas`
--
ALTER TABLE `campanas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cliente_autorizaciones`
--
ALTER TABLE `cliente_autorizaciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cliente_autorizaciones_token_unique` (`token`),
  ADD KEY `cliente_autorizaciones_cliente_id_index` (`cliente_id`),
  ADD KEY `cliente_autorizaciones_dispositivo_id_index` (`dispositivo_id`),
  ADD KEY `cliente_autorizaciones_tipo_accion_index` (`tipo_accion`);

--
-- Indices de la tabla `cliente_dispositivos`
--
ALTER TABLE `cliente_dispositivos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cliente_dispositivos_imei_hash_unique` (`imei_hash`),
  ADD KEY `cliente_dispositivos_cliente_id_index` (`cliente_id`);

--
-- Indices de la tabla `cliente_saldos`
--
ALTER TABLE `cliente_saldos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_saldos_cliente_rut_hash_index` (`cliente_rut_hash`),
  ADD KEY `cliente_saldos_voucher_id_index` (`voucher_id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `ip_autorizadas`
--
ALTER TABLE `ip_autorizadas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ip_autorizadas_rol_index` (`rol`),
  ADD KEY `ip_autorizadas_user_id_index` (`user_id`),
  ADD KEY `ip_autorizadas_ip_index` (`ip`);

--
-- Indices de la tabla `login_auditorias`
--
ALTER TABLE `login_auditorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `login_auditorias_user_id_index` (`user_id`),
  ADD KEY `login_auditorias_email_index` (`email`),
  ADD KEY `login_auditorias_resultado_index` (`resultado`),
  ADD KEY `login_auditorias_ip_index` (`ip`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pago_autorizaciones`
--
ALTER TABLE `pago_autorizaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `security_logs`
--
ALTER TABLE `security_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `security_logs_user_id_index` (`user_id`),
  ADD KEY `security_logs_cliente_id_index` (`cliente_id`),
  ADD KEY `security_logs_accion_index` (`accion`);

--
-- Indices de la tabla `totems`
--
ALTER TABLE `totems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `totems_codigo_unique` (`codigo`);

--
-- Indices de la tabla `totem_logs`
--
ALTER TABLE `totem_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `totem_logs_totem_id_foreign` (`totem_id`);

--
-- Indices de la tabla `totem_sesiones`
--
ALTER TABLE `totem_sesiones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `totem_sesiones_totem_id_foreign` (`totem_id`);

--
-- Indices de la tabla `totem_sesions`
--
ALTER TABLE `totem_sesions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `totem_ventas`
--
ALTER TABLE `totem_ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `totem_ventas_totem_id_foreign` (`totem_id`);

--
-- Indices de la tabla `totem_venta_detalles`
--
ALTER TABLE `totem_venta_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `totem_venta_detalles_venta_id_foreign` (`venta_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indices de la tabla `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vouchers_codigo_unique` (`codigo`),
  ADD UNIQUE KEY `vouchers_qr_token_unique` (`qr_token`),
  ADD KEY `vouchers_cliente_rut_hash_index` (`cliente_rut_hash`),
  ADD KEY `vouchers_totem_venta_id_index` (`totem_venta_id`),
  ADD KEY `vouchers_agenda_id_index` (`agenda_id`),
  ADD KEY `vouchers_atencion_id_index` (`atencion_id`),
  ADD KEY `vouchers_profesional_atendio_id_index` (`profesional_atendio_id`),
  ADD KEY `vouchers_asistente_valido_id_index` (`asistente_valido_id`),
  ADD KEY `vouchers_estado_validacion_index` (`estado_validacion`),
  ADD KEY `vouchers_riesgo_validacion_index` (`riesgo_validacion`);

--
-- Indices de la tabla `voucher_agendas`
--
ALTER TABLE `voucher_agendas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voucher_agendas_voucher_id_index` (`voucher_id`),
  ADD KEY `voucher_agendas_cliente_id_index` (`cliente_id`),
  ADD KEY `voucher_agendas_mascota_id_index` (`mascota_id`),
  ADD KEY `voucher_agendas_profesional_id_index` (`profesional_id`),
  ADD KEY `voucher_agendas_centro_atencion_id_index` (`centro_atencion_id`);

--
-- Indices de la tabla `voucher_alertas`
--
ALTER TABLE `voucher_alertas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `voucher_atenciones`
--
ALTER TABLE `voucher_atenciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voucher_atenciones_voucher_id_index` (`voucher_id`),
  ADD KEY `voucher_atenciones_agenda_id_index` (`agenda_id`),
  ADD KEY `voucher_atenciones_cliente_id_index` (`cliente_id`),
  ADD KEY `voucher_atenciones_mascota_id_index` (`mascota_id`),
  ADD KEY `voucher_atenciones_profesional_id_index` (`profesional_id`),
  ADD KEY `voucher_atenciones_asistente_id_index` (`asistente_id`);

--
-- Indices de la tabla `voucher_auditorias`
--
ALTER TABLE `voucher_auditorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `voucher_cobros`
--
ALTER TABLE `voucher_cobros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voucher_cobros_voucher_id_foreign` (`voucher_id`);

--
-- Indices de la tabla `voucher_liquidaciones`
--
ALTER TABLE `voucher_liquidaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `voucher_logs`
--
ALTER TABLE `voucher_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `voucher_mascotas`
--
ALTER TABLE `voucher_mascotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voucher_mascotas_cliente_id_index` (`cliente_id`),
  ADD KEY `voucher_mascotas_dueno_rut_hash_index` (`dueno_rut_hash`),
  ADD KEY `voucher_mascotas_dueno_telefono_hash_index` (`dueno_telefono_hash`),
  ADD KEY `voucher_mascotas_dueno_email_hash_index` (`dueno_email_hash`);

--
-- Indices de la tabla `voucher_pagos`
--
ALTER TABLE `voucher_pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voucher_pagos_voucher_id_foreign` (`voucher_id`);

--
-- Indices de la tabla `voucher_profesionales`
--
ALTER TABLE `voucher_profesionales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `voucher_rendiciones`
--
ALTER TABLE `voucher_rendiciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `voucher_servicios`
--
ALTER TABLE `voucher_servicios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `voucher_vendedores`
--
ALTER TABLE `voucher_vendedores`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditor_notificaciones`
--
ALTER TABLE `auditor_notificaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `campanas`
--
ALTER TABLE `campanas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente_autorizaciones`
--
ALTER TABLE `cliente_autorizaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `cliente_dispositivos`
--
ALTER TABLE `cliente_dispositivos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cliente_saldos`
--
ALTER TABLE `cliente_saldos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ip_autorizadas`
--
ALTER TABLE `ip_autorizadas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `login_auditorias`
--
ALTER TABLE `login_auditorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT de la tabla `pago_autorizaciones`
--
ALTER TABLE `pago_autorizaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `security_logs`
--
ALTER TABLE `security_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `totems`
--
ALTER TABLE `totems`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `totem_logs`
--
ALTER TABLE `totem_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1505;

--
-- AUTO_INCREMENT de la tabla `totem_sesiones`
--
ALTER TABLE `totem_sesiones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1335;

--
-- AUTO_INCREMENT de la tabla `totem_sesions`
--
ALTER TABLE `totem_sesions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `totem_ventas`
--
ALTER TABLE `totem_ventas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT de la tabla `totem_venta_detalles`
--
ALTER TABLE `totem_venta_detalles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `voucher_agendas`
--
ALTER TABLE `voucher_agendas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `voucher_alertas`
--
ALTER TABLE `voucher_alertas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `voucher_atenciones`
--
ALTER TABLE `voucher_atenciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `voucher_auditorias`
--
ALTER TABLE `voucher_auditorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `voucher_cobros`
--
ALTER TABLE `voucher_cobros`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `voucher_liquidaciones`
--
ALTER TABLE `voucher_liquidaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `voucher_logs`
--
ALTER TABLE `voucher_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `voucher_mascotas`
--
ALTER TABLE `voucher_mascotas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `voucher_pagos`
--
ALTER TABLE `voucher_pagos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `voucher_profesionales`
--
ALTER TABLE `voucher_profesionales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `voucher_rendiciones`
--
ALTER TABLE `voucher_rendiciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `voucher_servicios`
--
ALTER TABLE `voucher_servicios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `voucher_vendedores`
--
ALTER TABLE `voucher_vendedores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `totem_logs`
--
ALTER TABLE `totem_logs`
  ADD CONSTRAINT `totem_logs_totem_id_foreign` FOREIGN KEY (`totem_id`) REFERENCES `totems` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `totem_sesiones`
--
ALTER TABLE `totem_sesiones`
  ADD CONSTRAINT `totem_sesiones_totem_id_foreign` FOREIGN KEY (`totem_id`) REFERENCES `totems` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `totem_ventas`
--
ALTER TABLE `totem_ventas`
  ADD CONSTRAINT `totem_ventas_totem_id_foreign` FOREIGN KEY (`totem_id`) REFERENCES `totems` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `totem_venta_detalles`
--
ALTER TABLE `totem_venta_detalles`
  ADD CONSTRAINT `totem_venta_detalles_venta_id_foreign` FOREIGN KEY (`venta_id`) REFERENCES `totem_ventas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `voucher_cobros`
--
ALTER TABLE `voucher_cobros`
  ADD CONSTRAINT `voucher_cobros_voucher_id_foreign` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `voucher_pagos`
--
ALTER TABLE `voucher_pagos`
  ADD CONSTRAINT `voucher_pagos_voucher_id_foreign` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
