-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-05-2021 a las 06:20:07
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_de_inventario_y_facturacion_panaderia`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `listarpoid` (`p_id` INT)  select * from tb_detalle where id=p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spclientes` (IN `p_cedula_clientes` BIGINT(20), IN `p_nombre` VARCHAR(50), IN `p_apellido` VARCHAR(50), IN `p_telefono` BIGINT(20), OUT `estado` VARCHAR(250))  NO SQL
if (select count(p_cedula_clientes) from tb_clientes where cedula_clientes=p_cedula_clientes)= 1 then
    select "ya existe cliente" into estado;
else
    insert into         tb_clientes(cedula_clientes,nombre,apellido,telefono)
    values(p_cedula_clientes,p_nombre,p_apellido,p_telefono);
    select "se registro cliente" into estado;
end if$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spprod` (IN `p_codigo_producto` CHAR(10), IN `p_nombre_producto` VARCHAR(50), IN `p_stock` BIGINT(20), IN `p_unidades_disponibles` BIGINT(20), IN `p_fecha_de_fabricacion` DATE, IN `p_fecha_de_vencimiento` DATE, OUT `estado` VARCHAR(250))  NO SQL
if (select count(p_codigo_producto) from tb_producto where codigo_producto=p_codigo_producto)= 1 then
    select "ya existe producto" into estado;
else
    insert into tb_producto(codigo_producto,nombre_producto,stock,unidades_disponibles,fecha_de_fabricacion,fecha_de_vencimiento)
    values(p_codigo_producto,p_nombre_producto,p_stock,p_unidades_disponibles,p_fecha_de_fabricacion,p_fecha_de_vencimiento);
    select "se registro producto" into estado;
end if$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spregfac` (IN `p_id` INT(11), IN `p_precio_unitario` DOUBLE, IN `p_cantidad_vendida` BIGINT(20), IN `p_total_vendido` DOUBLE, IN `p_codigo_factura` CHAR(10), IN `p_codigo_producto` CHAR(10), OUT `estado` VARCHAR(250))  NO SQL
if (select count(p_id) from tb_detalle where id=p_id)= 1 then
    select "ya existe factura" into estado;
else
    insert into tb_detalle(id,precio_unitario,cantidad_vendida,total_vendido,codigo_factura,codigo_producto)
    values(p_id,p_precio_unitario,p_cantidad_vendida,p_total_vendido,p_codigo_factura,p_codigo_producto);
    select "se registro factura" into estado;
end if$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `vercli` (`p_id` INT)  select * from tb_factura where codigo_factura=p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verpro` (IN `p_id` INT)  select * from tb_producto where codigo_producto=p_id$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `castock` (`stock` INT, `canvend` INT) RETURNS INT(11) begin
     return stock-canvend;
 end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `SALUDO` (`nombre` VARCHAR(20), `apellido` VARCHAR(20)) RETURNS VARCHAR(270) CHARSET utf8mb4 begin
 declare msg varchar(250);
 set msg= "";
     return concat(msg," " ,nombre, " ",apellido);
 end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `sumar` (`numero1` INT, `numero2` INT) RETURNS INT(11) begin


              return numero1 + numero2;

end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `vtotal` (`cantidad_vendida` INT, `precio_unitario` DOUBLE) RETURNS DOUBLE begin
     return cantidad_vendida*precio_unitario;
 end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_clientes`
--

CREATE TABLE `tb_clientes` (
  `cedula_clientes` bigint(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_clientes`
--

INSERT INTO `tb_clientes` (`cedula_clientes`, `nombre`, `apellido`, `telefono`) VALUES
(1042688, 'michael', 'forero', 8883055),
(10002568, 'pedro', 'angulo', 8882255),
(10245877, 'carlos', 'londoño', 3205857710),
(10259630, 'dorlan', 'pavon', 3205442511),
(102476366, 'alejandro', 'gutierrez', 3105552080),
(105845290, 'valeri', 'osorio', 3125478899),
(106668571, 'raul', 'gonzales', 8859910),
(1020222587, 'kakaroto', 'sayayin', 8002570),
(1053787584, 'pedro', 'perez', 8847898),
(1053787589, 'jhony', 'pereira', 3205443628),
(1054985746, 'juan', 'rodriguez', 8745252),
(1055888999, 'jhon', 'eugenio', 8885412),
(10587412583, 'pablo', 'serna', 8889252),
(10589632587, 'amilkar', 'garcia', 8745482),
(10782228477, 'lina', 'pineda', 8866252),
(10842668755, 'dario', 'franco', 87778552);

--
-- Disparadores `tb_clientes`
--
DELIMITER $$
CREATE TRIGGER `trg_borrar_cliente` AFTER DELETE ON `tb_clientes` FOR EACH ROW INSERT INTO tb_log(id,des,fecha)
VALUES(null,'se ha borrado un cliente',
now())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_nuevo_cliente` AFTER INSERT ON `tb_clientes` FOR EACH ROW INSERT INTO tb_log(id,des,fecha)
VALUES(null,'se ha ingresado un usuario',
now())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle`
--

CREATE TABLE `tb_detalle` (
  `id` int(11) NOT NULL,
  `precio_unitario` double NOT NULL,
  `cantidad_vendida` bigint(20) NOT NULL,
  `total_vendido` double NOT NULL,
  `codigo_factura` char(10) NOT NULL,
  `codigo_producto` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_detalle`
--

INSERT INTO `tb_detalle` (`id`, `precio_unitario`, `cantidad_vendida`, `total_vendido`, `codigo_factura`, `codigo_producto`) VALUES
(3, 2000, 5, 10000, '01', '1590'),
(4, 2000, 10, 20000, '02', '2222'),
(5, 2500, 3, 7500, '03', '3333'),
(6, 2000, 2, 4000, '04', '21506');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_factura`
--

CREATE TABLE `tb_factura` (
  `codigo_factura` char(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `cedula_clientes` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_factura`
--

INSERT INTO `tb_factura` (`codigo_factura`, `fecha_hora`, `cedula_clientes`) VALUES
('01', '2021-05-04 16:48:42', 10245877),
('02', '2021-05-05 14:27:50', 1042688),
('03', '2021-05-06 14:27:50', 10589632587),
('04', '2021-05-06 14:38:11', 1055888999),
('05', '2021-05-06 14:38:11', 10589632587);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_log`
--

CREATE TABLE `tb_log` (
  `id` int(11) NOT NULL,
  `des` varchar(80) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_log`
--

INSERT INTO `tb_log` (`id`, `des`, `fecha`) VALUES
(1, 'se ha borrado un usuario', '2021-05-04'),
(2, 'se ha ingresado un usuario', '2021-05-04'),
(3, 'se ha borrado un producto', '2021-05-04'),
(4, 'se ha borrado un cliente', '2021-05-04'),
(5, 'se ha ingresado un producto', '2021-05-04'),
(6, 'se ha ingresado un producto', '2021-05-04'),
(7, 'se ha ingresado un usuario', '2021-05-04'),
(8, 'se ha ingresado un usuario', '2021-05-06'),
(9, 'se ha ingresado un usuario', '2021-05-06'),
(10, 'se ha ingresado un producto', '2021-05-06'),
(11, 'se ha ingresado un producto', '2021-05-06'),
(12, 'se ha ingresado un producto', '2021-05-06'),
(13, 'se ha ingresado un usuario', '2021-05-15'),
(14, 'se ha ingresado un usuario', '2021-05-15'),
(15, 'se ha ingresado un usuario', '2021-05-16'),
(16, 'se ha ingresado un usuario', '2021-05-16'),
(17, 'se ha ingresado un usuario', '2021-05-16'),
(18, 'se ha ingresado un usuario', '2021-05-16'),
(19, 'se ha ingresado un usuario', '2021-05-16'),
(20, 'se ha ingresado un usuario', '2021-05-16'),
(21, 'se ha ingresado un producto', '2021-05-16'),
(22, 'se ha borrado un cliente', '2021-05-16'),
(23, 'se ha borrado un cliente', '2021-05-16'),
(24, 'se ha borrado un cliente', '2021-05-16'),
(25, 'se ha borrado un cliente', '2021-05-16'),
(26, 'se ha borrado un cliente', '2021-05-16'),
(27, 'se ha borrado un cliente', '2021-05-16'),
(28, 'se ha borrado un cliente', '2021-05-16'),
(29, 'se ha borrado un cliente', '2021-05-16'),
(30, 'se ha ingresado un producto', '2021-05-16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_producto`
--

CREATE TABLE `tb_producto` (
  `codigo_producto` char(10) NOT NULL,
  `nombre_producto` varchar(50) NOT NULL,
  `stock` bigint(20) NOT NULL,
  `unidades_disponibles` bigint(20) NOT NULL,
  `fecha_de_fabricacion` date NOT NULL,
  `fecha_de_vencimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_producto`
--

INSERT INTO `tb_producto` (`codigo_producto`, `nombre_producto`, `stock`, `unidades_disponibles`, `fecha_de_fabricacion`, `fecha_de_vencimiento`) VALUES
('1574', 'aguapanela', 30, 10, '2010-05-21', '2010-06-21'),
('1590', 'pan aliñado', 50, 0, '2021-04-10', '2021-04-30'),
('21485', 'pan leche', 50, 0, '2021-04-17', '2021-04-24'),
('21501', 'pan bogotano', 50, 0, '2021-05-01', '2021-04-30'),
('21502', 'pan mariquiteño', 50, 0, '2021-04-10', '2021-04-30'),
('21505', 'tostadas', 50, 0, '2021-04-10', '2021-04-30'),
('21506', 'pandequeso', 50, 0, '2021-04-10', '2021-04-30'),
('21507', 'chicharones', 50, 0, '2021-04-10', '2021-05-01'),
('21508', 'empanadas', 20, 0, '2021-04-03', '2021-04-30'),
('2222', 'pandequeso', 30, 0, '2021-05-02', '2021-05-11'),
('258', 'chocolate', 50, 40, '2010-05-21', '2010-06-21'),
('3333', 'dedos de queso', 20, 0, '2021-05-02', '2021-05-06'),
('4', '1000', 30, 30000, '0000-00-00', '0000-00-00'),
('8080', 'pan salchicha', 30, 10, '2027-05-04', '2029-05-07'),
('null', '1000', 30, 30000, '0000-00-00', '0000-00-00');

--
-- Disparadores `tb_producto`
--
DELIMITER $$
CREATE TRIGGER `trg_borrar` AFTER DELETE ON `tb_producto` FOR EACH ROW INSERT INTO tb_log(id,des,fecha)
VALUES(null,'se ha borrado un producto',
now())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_ingresar_producto` AFTER INSERT ON `tb_producto` FOR EACH ROW INSERT INTO tb_log(id,des,fecha)
VALUES(null,'se ha ingresado un producto',
now())
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tb_clientes`
--
ALTER TABLE `tb_clientes`
  ADD PRIMARY KEY (`cedula_clientes`);

--
-- Indices de la tabla `tb_detalle`
--
ALTER TABLE `tb_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codigo_factura` (`codigo_factura`),
  ADD KEY `codigo_producto` (`codigo_producto`);

--
-- Indices de la tabla `tb_factura`
--
ALTER TABLE `tb_factura`
  ADD PRIMARY KEY (`codigo_factura`),
  ADD KEY `cedula_clientes` (`cedula_clientes`);

--
-- Indices de la tabla `tb_log`
--
ALTER TABLE `tb_log`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tb_producto`
--
ALTER TABLE `tb_producto`
  ADD PRIMARY KEY (`codigo_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tb_detalle`
--
ALTER TABLE `tb_detalle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tb_log`
--
ALTER TABLE `tb_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tb_detalle`
--
ALTER TABLE `tb_detalle`
  ADD CONSTRAINT `tb_detalle_ibfk_1` FOREIGN KEY (`codigo_factura`) REFERENCES `tb_factura` (`codigo_factura`),
  ADD CONSTRAINT `tb_detalle_ibfk_2` FOREIGN KEY (`codigo_producto`) REFERENCES `tb_producto` (`codigo_producto`);

--
-- Filtros para la tabla `tb_factura`
--
ALTER TABLE `tb_factura`
  ADD CONSTRAINT `tb_factura_ibfk_1` FOREIGN KEY (`cedula_clientes`) REFERENCES `tb_clientes` (`cedula_clientes`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
