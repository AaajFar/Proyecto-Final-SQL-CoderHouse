-- Creacion de Schema

DROP SCHEMA IF EXISTS fabrica_guitarras;

CREATE SCHEMA IF NOT EXISTS fabrica_guitarras;

USE fabrica_guitarras;

SET @@AUTOCOMMIT = 0;

-- PRUEBA PARA AUTOCOMMIT
-- SELECT @@AUTOCOMMIT;


-- Creacion de tablas

-- Tabla de proveedores

CREATE TABLE IF NOT EXISTS proveedores
(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(60) NOT NULL,
direccion VARCHAR(100) NOT NULL,
telefono INT NOT NULL,
mail VARCHAR(60) NOT NULL DEFAULT 'Pedir mail'
) ENGINE=INNODB;

-- Tabla de materiales

CREATE TABLE IF NOT EXISTS materiales
(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('clavijas', 'microfonos', 'maderas', 'cuerdas') NOT NULL,
marca VARCHAR(60) DEFAULT NULL,
modelo VARCHAR(60) NOT NULL,
descripcion VARCHAR(100) DEFAULT NULL,
stock INT UNSIGNED NOT NULL,
costo FLOAT NOT NULL
) ENGINE=INNODB;

-- Tabla de relacion de materiales y proveedores

CREATE TABLE IF NOT EXISTS proveedores_materiales
(
mat_id INT NOT NULL,
prov_id INT NOT NULL,
PRIMARY KEY(mat_id, prov_id),
FOREIGN KEY (mat_id) REFERENCES fabrica_guitarras.materiales(id) ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (prov_id) REFERENCES fabrica_guitarras.proveedores(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=INNODB;

-- Tabla de guitarras

CREATE TABLE IF NOT EXISTS guitarras
(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('electrica', 'clasica', 'electroacustica', 'clasica nino', 'clasica concierto') NOT NULL,
modelo VARCHAR(60) NOT NULL,
ano YEAR NOT NULL,
stock INT UNSIGNED NOT NULL,
precio FLOAT DEFAULT 0
) ENGINE=INNODB;

-- Tabla de relacion de materiales y guitarras

CREATE TABLE IF NOT EXISTS materiales_guitarras
(
mat_id INT NOT NULL,
guit_id INT NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (mat_id, guit_id),
FOREIGN KEY (mat_id) REFERENCES fabrica_guitarras.materiales(id) ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (guit_id) REFERENCES fabrica_guitarras.guitarras(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=INNODB;

-- Tabla de clientes

CREATE TABLE IF NOT EXISTS clientes
(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
apellido VARCHAR(45) NOT NULL,
direccion VARCHAR(200) DEFAULT NULL,
telefono INT NOT NULL,
mail VARCHAR(60) NOT NULL DEFAULT 'Pedir mail'
) ENGINE=INNODB;

-- Tabla de direcciones de envio de los clientes

CREATE TABLE IF NOT EXISTS direcciones_envio
(
id INT AUTO_INCREMENT PRIMARY KEY,
cliente_id INT NOT NULL,
direccion VARCHAR(200) NOT NULL,
localidad VARCHAR(60) NOT NULL,
provincia VARCHAR(30) NOT NULL,
FOREIGN KEY (cliente_id) REFERENCES fabrica_guitarras.clientes(id)
) ENGINE=INNODB;

-- Tabla de pedidos

CREATE TABLE IF NOT EXISTS pedidos
(
id INT AUTO_INCREMENT PRIMARY KEY,
cliente_id INT NOT NULL,
precio_total FLOAT DEFAULT 0,
fecha DATE NOT NULL,
direnvio_id INT NOT NULL,
FOREIGN KEY (cliente_id) REFERENCES fabrica_guitarras.clientes(id) ON UPDATE CASCADE,
FOREIGN KEY (direnvio_id) REFERENCES fabrica_guitarras.direcciones_envio(id) ON UPDATE CASCADE
) ENGINE=INNODB;

-- Tabla de detalles de los pedidos

CREATE TABLE IF NOT EXISTS pedidos_detalle
(
id INT NOT NULL AUTO_INCREMENT,
ped_id INT NOT NULL,
guit_id INT NOT NULL,
guit_cant INT NOT NULL,
guit_precio FLOAT NOT NULL,
PRIMARY KEY (id, ped_id, guit_id),
FOREIGN KEY (ped_id) REFERENCES fabrica_guitarras.pedidos(id) ON UPDATE CASCADE,
FOREIGN KEY (guit_id) REFERENCES fabrica_guitarras.guitarras(id) ON UPDATE CASCADE
) ENGINE=INNODB;

-- Creacion de tablas de movimientos, logs, bitacoras.

-- Tabla de movimientos realizados en la tabla pedidos

CREATE TABLE IF NOT EXISTS movimientos_pedidos
(id_mov INT PRIMARY KEY AUTO_INCREMENT,
fecha_mov DATE NOT NULL,
hora_mov TIME NOT NULL,
usuario_mov VARCHAR(50) NOT NULL,
id_ped INT NOT NULL,
cliente VARCHAR(100) NOT NULL
) ENGINE=INNODB;

-- Tabla de movimientos realizados en la tabla materiales

CREATE TABLE IF NOT EXISTS movimientos_materiales
(id_mov INT PRIMARY KEY AUTO_INCREMENT,
fecha_mov DATE NOT NULL,
hora_mov TIME NOT NULL,
usuario_mov VARCHAR(50) NOT NULL,
id_mat INT NOT NULL,
tipo_mat ENUM('maderas', 'microfonos', 'clavijas', 'cuerdas') NOT NULL,
costo_mat INT NOT NULL,
costo_viejo INT,
costo_dif VARCHAR(10),
detalle VARCHAR(30)
);


-- Insercion de datos

USE fabrica_guitarras;

-- Insercion de datos de proveedores

DELIMITER //
START TRANSACTION;
INSERT INTO proveedores VALUES
(NULL, 'Music Shop', 'Guatemala 2044, CABA', '48722685', 'musicshop@gmail.com'),
(NULL, 'Fender Accesorios', 'Solis 3052, CABA', '49552828', 'fenderacc@gmail.com'),
(NULL, 'Gibson Music', 'Av Nazca 3155, CABA', '45883371', 'gibsonint@gmail.com'),
(NULL, 'Yamaha Accesorios', 'Callao 1233, CABA', '46418892', 'yamahaarg@gmail.com'),
(NULL, 'Gotoh International', 'Lavalle 4882, CABA', '49123355', 'gotohinternacional@gmail.com'),
(NULL, 'Maderas del sur', 'Hipolito Irigoyen 2255, Lanus GBA', '47229822', 'maderasdelsur@info.com.ar'),
(NULL, 'Gutierrez Maderas', 'Av J B Alberdi 5244, CABA', '43228789', DEFAULT),
(NULL, 'Maderera Tres Hermanos', 'Av Alvarez Jonte 2573, CABA', '45838877', 'treshermanosmaderera@hotmail.com'),
(NULL, 'Maderera El Carpintero', 'Av San Martin 2188, CABA', '49928633', DEFAULT),
(NULL, 'Devoto Maderas', 'Av Francisco Beiro 4122, CABA', '46228899', 'devotomaderas@gmail.com');
// DELIMITER ;

COMMIT;

-- Insercion de datos de materiales

DELIMITER //
START TRANSACTION;
INSERT INTO materiales VALUES
(NULL, 'clavijas', 'MXP', 'MX218 A', 'Set x6 para clasica', '3200', '1000'),
(NULL, 'clavijas', 'Shimura', '214n', 'Set x6 para clasica', '2550','1200'),
(NULL, 'clavijas', 'Shimura', '218A', 'Set x6 para clasica', '1980','1300'),
(NULL, 'clavijas', 'Fender', '099-0818-000', 'Set x6 para electrica', '2202','2000'),
(NULL, 'clavijas', 'Fender', '0990820100', 'Set x6 para electrica', '2560','2500'),
(NULL, 'clavijas', 'Gibson', 'PMMH-025 GOLD', 'Set x6 para electrica', '3150','2000'),
(NULL, 'clavijas', 'Gibson', 'PMMH-030 BLACK', 'Set x6 para electrica', '3200','2500'),
(NULL, 'clavijas', 'Yamaha', 'TM 30', 'Set x6 para electrica o acustica', '2500','1500'),
(NULL, 'clavijas', 'Gotoh', '1503b-z', 'Set x6 para electrica', '1800','2000'),
(NULL, 'clavijas', 'Gotoh', '1502c', 'Set x6 para electrica', '1980','2500'),
(NULL, 'clavijas', 'Gotoh', '1513c', 'Set x6 para electrica', '2150','3000'),
(NULL, 'microfonos', 'DS Pickups', 'DS10-N-M-B', 'Set x3 para electrica', '3658','4000'),
(NULL, 'microfonos', 'DS Pickups', 'DS10-N-M-B', 'Set x3 para electrica', '3200','4500'),
(NULL, 'microfonos', 'Fender', 'Tex Mex', 'Set x3 para electrica', '4150','5000'),
(NULL, 'microfonos', 'Fender', 'Vintage Noiseless', 'Set x3 para electrica', '3500','6000'),
(NULL, 'microfonos', 'Dimarzio', 'Rainmaker Dreamcatcher', 'Set x2 para electrica', '2100','5500'),
(NULL, 'microfonos', 'Dimarzio', 'DP227 DP228', 'Set x2 para electrica', '1920','5500'),
(NULL, 'microfonos', 'Fishman', 'Blend 301', 'Para guitarra acustica', '1750','2000'),
(NULL, 'microfonos', 'Cherub', 'GS3', 'Para guitarra acustica', '2650','2500'),
(NULL, 'microfonos', 'Dimarzio', 'Dp136', 'Para guitarra acustica', '3155','3500'),
(NULL, 'cuerdas', 'D addario', 'ez900', 'Set x6 para acustica .010', '4850','1000'),
(NULL, 'cuerdas', 'Ernie Ball', 'Super Slinky', 'Set x6 para electrica .009', '2170','1200'),
(NULL, 'cuerdas', 'Fender', '150R', 'Set x6 para electrica .010', '1850','1100'),
(NULL, 'cuerdas', 'Fender', '150L', 'Set x6 para electrica .009', '2110','1200'),
(NULL, 'cuerdas', 'Gibson', 'sag-mb11', 'Set x6 para acustica .011', '3658','1250'),
(NULL, 'cuerdas', 'Gibson', 'seg-700l', 'Set x6 para electrica .010', '1870','1350'),
(NULL, 'cuerdas', 'D addario', 'EJ-30', 'Set x6 para clasica', '2500','1000'),
(NULL, 'cuerdas', 'Cantata', '630', 'Set x6 para clasica', '5000','800'),
(NULL, 'maderas', NULL, 'Alamo', 'Para guitarra electrica', '1980','2000'),
(NULL, 'maderas', NULL, 'Ebano', 'Para guitarra electrica', '1840','3000'),
(NULL, 'maderas', NULL, 'Pino Abeto', 'Para guitarra clasica', '2300','1500'),
(NULL, 'maderas', NULL, 'Cedro Español', 'Para guitarra clasica', '2488','4000'),
(NULL, 'maderas', NULL, 'Caoba', 'Para guitarra clasica', '2150','5000'),
(NULL, 'maderas', NULL, 'Palorosa', 'Para guitarra electrica', '3000','5000'),
(NULL, 'maderas', NULL, 'Arce', 'Para guitarra clasica', '2500','4500'),
(NULL, 'maderas', NULL, 'Fresno', 'Para guitarra acustica', '1940','3500'),
(NULL, 'maderas', NULL, 'Wengue', 'Para guitarra acustica', '2122','5000');
// DELIMITER ;

COMMIT;

-- Insercion de datos de relacion proveedores materiales

DELIMITER //
START TRANSACTION;
INSERT INTO proveedores_materiales VALUES
('1','1'),
('2','1'),
('3','1'),
('4','2'),
('5','2'),
('6','3'),
('7','3'),
('8','4'),
('9','5'),
('10','5'),
('11','5'),
('12','1'),
('13','1'),
('14','2'),
('15','2'),
('16','1'),
('17','1'),
('18','3'),
('19','2'),
('20','1'),
('21','1'),
('22','1'),
('23','2'),
('24','2'),
('25','3'),
('26','3'),
('27','1'),
('28','5'),
('29','6'),
('30','8'),
('31','7'),
('32','10'),
('33','8'),
('34','9'),
('35','7'),
('36','8'),
('37','10');
// DELIMITER ;

COMMIT;

-- Insercion de datos de guitarras sin los precios de venta

DELIMITER //
START TRANSACTION ;
INSERT INTO guitarras (id, tipo, modelo, ano, stock) VALUES 
(NULL,'Electrica','Stratocaster','2020','570'),
(NULL,'Electrica','Stratocaster','2021','650'),
(NULL,'Electrica','Les Paul','2019','700'),
(NULL,'Electrica','335','2020','720'),
(NULL,'Electrica','Stratocaster','2018','312'),
(NULL,'Electrica','Stratocaster','2019','510'),
(NULL,'Electroacustica','345','2020','300'),
(NULL,'Electroacustica','CD80','2019','680'),
(NULL,'Electroacustica','CE400','2021','470'),
(NULL,'Electroacustica','CD90','2021','510'),
(NULL,'Clasica','C40','2020','500'),
(NULL,'Clasica','C50','2020','780'),
(NULL,'Clasica','C60','2021','860'),
(NULL,'Clasica','M5','2020','202'),
(NULL,'Clasica','M6','2019','310'),
(NULL,'Clasica','C60LR','2022','520'),
(NULL,'Clasica Nino','C40M','2020','112'),
(NULL,'Clasica Nino','C50M','2020','521'),
(NULL,'Clasica Concierto','C100','2016','121'),
(NULL,'Clasica Concierto','C102','2018','320');
// DELIMITER ;

COMMIT;


/* Stored Procedure Extra #1: Esta creado pensando en la automatización del sistema, sirve para ingresar el detalle
de materiales que lleva una guitarra. Al llamarlo ingresamos como parametros el id del material, el id de la 
la guitarra que utiliza ese material y la cantidad. Primero se declara una variable para obtener el precio de venta de 
la guitarra por unidad llamada v_precio_venta, que luego la usaremos para actualizar la columna precio de la
tabla guitarras y declaramos otra variable llamada v_mat_rest para guardar la cantidad de material que se utilizo 
en base al stock ingresadode la guitarra que luego usaremos para actualizar la columna stock de la tabla materiales. 
Declaramos un EXIT HANDLER para el error 1264 (out of range value), ya que el campo stock de la tabla materiales es 
UNSIGNED, osea que no puede ser negativo, por lo tanto si no disponemos stock del material hace un rollback dandonos 
un mensaje de alerta de que la operacion ha sido cancelada. Hacemos un INSERT a la tabla materiales_guitarras con los 
datos ingresados al llamar al SP. Le damos valor a la variable v_precio_venta haciendo un SELECT del costo del material 
de la tabla materiales multiplicandolo por 1.7 donde el id del material sea igual al id_material ingresado al llamar al SP. 
Hacemos un UPDATE en la tabla guitarras indicando que el precio va a ser igual al precio que ya tiene sumado a la variable 
v_precia_venta donde el id de la guitarra sea igual al id_guitarra ingresado al llamar al SP. Le damos valor a la variable 
v_mat_rest haciendo un SELECT del stock de guitarras ingresado en la tabla guitarras por la cantidad de material utilizada que
ingresamos al llamar al SP donde el id de la guitarra sea igual al id_guitarra ingresado al llamar al SP. En el ultimo
paso con este valor hacemos un UPDATE en la tabla materiales diciendole que el stock va a ser igual al stock actual menos
la variable v_mat_rest donde el id del material sea igual al id_material ingresado al llamar al SP. Es muy beneficioso 
para el sistema ya que cada vez que ingresamos un material a la guitarra va a ir sumando los costos de los materiales 
ya multiplicados por el valor total a marcar para la venta de productos y cuando finalicemos de cargar los materiales 
tendremos el valor de venta de la guitarra, y a su vez nos va a descontar los materiales utilizados para la fabricacion
dandonos un mensaje de alerta en el caso de que haya una inconsistencia entre el stock de guitarras ingresado y la 
cantidad de material que hay que utilizar. */

DELIMITER //
CREATE PROCEDURE sp_ingresar_materiales_guitarras (IN id_material INT,
												   IN id_guitarra INT,
												   IN cantidad INT)
BEGIN
	DECLARE v_precio_venta FLOAT;
    DECLARE v_mat_rest FLOAT;
    
	DECLARE EXIT HANDLER FOR 1264
    BEGIN
		ROLLBACK;
        SELECT CONCAT('El material con ID ', id_material, ' utilizado para el producto seleccionado
						con ID ', id_guitarra, ' no cuenta con stock suficiente, la operacion ha sido cancelada') 
                        AS alerta;
	END;
    
	INSERT INTO materiales_guitarras VALUES
    (id_material, id_guitarra, cantidad);
	
    SELECT (costo * 1.7) * cantidad
    INTO v_precio_venta
    FROM materiales
    WHERE id = id_material;

    UPDATE guitarras
    SET precio = precio + v_precio_venta
    WHERE id = id_guitarra;
    
    SELECT guit.stock * cantidad
    INTO v_mat_rest
    FROM guitarras guit
    WHERE guit.id = id_guitarra;
    
    UPDATE materiales mat
    SET mat.stock = mat.stock - v_mat_rest
    WHERE mat.id = id_material;
    
END;    
// 
DELIMITER ;

/* Insercion de datos de los materiales correspondientes a cada guitarra con su cantidad con el SP creado,
este proceso nos dara los precios finales de venta de las guitarras y descontara el correspondiente stock
de materiales utilizados*/

DELIMITER //
START TRANSACTION;
CALL sp_ingresar_materiales_guitarras (4,1,1);
CALL sp_ingresar_materiales_guitarras (12,1,1);
CALL sp_ingresar_materiales_guitarras (24,1,1);
CALL sp_ingresar_materiales_guitarras (29,1,1);
CALL sp_ingresar_materiales_guitarras (5,2,1);
CALL sp_ingresar_materiales_guitarras (13,2,1);
CALL sp_ingresar_materiales_guitarras (23,2,1);
CALL sp_ingresar_materiales_guitarras (29,2,1);
CALL sp_ingresar_materiales_guitarras (6,3,1);
CALL sp_ingresar_materiales_guitarras (17,3,1);
CALL sp_ingresar_materiales_guitarras (26,3,1);
CALL sp_ingresar_materiales_guitarras (30,3,1);
CALL sp_ingresar_materiales_guitarras (7,4,1);
CALL sp_ingresar_materiales_guitarras (16,4,1);
CALL sp_ingresar_materiales_guitarras (26,4,1);
CALL sp_ingresar_materiales_guitarras (30,4,1);
CALL sp_ingresar_materiales_guitarras (9,5,1);
CALL sp_ingresar_materiales_guitarras (14,5,1);
CALL sp_ingresar_materiales_guitarras (22,5,1);
CALL sp_ingresar_materiales_guitarras (34,5,1);
CALL sp_ingresar_materiales_guitarras (11,6,1);
CALL sp_ingresar_materiales_guitarras (15,6,1);
CALL sp_ingresar_materiales_guitarras (22,6,1);
CALL sp_ingresar_materiales_guitarras (34,6,1);
CALL sp_ingresar_materiales_guitarras (8,7,1);
CALL sp_ingresar_materiales_guitarras (18,7,1);
CALL sp_ingresar_materiales_guitarras (21,7,1);
CALL sp_ingresar_materiales_guitarras (36,7,1);
CALL sp_ingresar_materiales_guitarras (8,8,1);
CALL sp_ingresar_materiales_guitarras (19,8,1);
CALL sp_ingresar_materiales_guitarras (25,8,1);
CALL sp_ingresar_materiales_guitarras (36,8,1);
CALL sp_ingresar_materiales_guitarras (8,9,1);
CALL sp_ingresar_materiales_guitarras (18,9,1);
CALL sp_ingresar_materiales_guitarras (21,9,1);
CALL sp_ingresar_materiales_guitarras (36,9,1);
CALL sp_ingresar_materiales_guitarras (8,10,1);
CALL sp_ingresar_materiales_guitarras (20,10,1);
CALL sp_ingresar_materiales_guitarras (25,10,1);
CALL sp_ingresar_materiales_guitarras (37,10,1);
CALL sp_ingresar_materiales_guitarras (1,11,1);
CALL sp_ingresar_materiales_guitarras (28,11,1);
CALL sp_ingresar_materiales_guitarras (31,11,1);
CALL sp_ingresar_materiales_guitarras (1,12,1);
CALL sp_ingresar_materiales_guitarras (28,12,1);
CALL sp_ingresar_materiales_guitarras (31,12,1);
CALL sp_ingresar_materiales_guitarras (1,13,1);
CALL sp_ingresar_materiales_guitarras (28,13,1);
CALL sp_ingresar_materiales_guitarras (35,13,1);
CALL sp_ingresar_materiales_guitarras (2,14,1);
CALL sp_ingresar_materiales_guitarras (27,14,1);
CALL sp_ingresar_materiales_guitarras (32,14,1);
CALL sp_ingresar_materiales_guitarras (3,15,1);
CALL sp_ingresar_materiales_guitarras (27,15,1);
CALL sp_ingresar_materiales_guitarras (33,15,1);
CALL sp_ingresar_materiales_guitarras (3,16,1);
CALL sp_ingresar_materiales_guitarras (28,16,1);
CALL sp_ingresar_materiales_guitarras (35,16,1);
CALL sp_ingresar_materiales_guitarras (1,17,1);
CALL sp_ingresar_materiales_guitarras (28,17,1);
CALL sp_ingresar_materiales_guitarras (31,17,1);
CALL sp_ingresar_materiales_guitarras (2,18,1);
CALL sp_ingresar_materiales_guitarras (28,18,1);
CALL sp_ingresar_materiales_guitarras (31,18,1);
CALL sp_ingresar_materiales_guitarras (3,19,1);
CALL sp_ingresar_materiales_guitarras (21,19,1);
CALL sp_ingresar_materiales_guitarras (35,19,1);
CALL sp_ingresar_materiales_guitarras (3,20,1);
CALL sp_ingresar_materiales_guitarras (21,20,1);
CALL sp_ingresar_materiales_guitarras (33,20,1);
// DELIMITER ;

COMMIT;


-- PRUEBAS PARA Stored Procedure Extra #1 'sp_ingresar_materiales_guitarras'

/* En una transaccion ingresamos un nuevo modelo de guitarras, luego usamos el SP para ingresar el detalle
de los materiales que usamos para la misma, todo funciona correctamente*/

/*
DELIMITER //
START TRANSACTION;
INSERT INTO guitarras (id, tipo, modelo, ano, stock) VALUES 
(NULL,'Electrica','Stratocaster','2022','50');

CALL sp_ingresar_materiales_guitarras (5,21,1);
CALL sp_ingresar_materiales_guitarras (14,21,1);
CALL sp_ingresar_materiales_guitarras (23,21,1);
CALL sp_ingresar_materiales_guitarras (30,21,1);
// DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;


/* En una transaccion ingresamos un nuevo modelo pero no se cuenta con stock de todos los materiales.
Al ingresar el material que no tiene stock nos da error, como tenemos un ROLLBACK dentro del EXIT
HANDLER toda la operacion va a quedar cancelada y nos va a dar que material es el que no cuenta
con stock, de esta forma podemos revisar y corregir. */

/*
DELIMITER //
START TRANSACTION;
INSERT INTO guitarras (id, tipo, modelo, ano, stock) VALUES 
(NULL,'Clasica','C70','2022','1200');

CALL sp_ingresar_materiales_guitarras (3,22,1);
CALL sp_ingresar_materiales_guitarras (27,22,1);
CALL sp_ingresar_materiales_guitarras (33,22,1);
// DELIMITER ;
*/

/* NOTA: Por las dudas hacer un alter table de la tabla guitarras, ir al a solapa options
y volver el Auto Increment a 22 */

-- Insercion de datos de clientes

DELIMITER //
START TRANSACTION; 
INSERT INTO clientes VALUES
(NULL,'Juan','Perez','Boyaca 555, CABA','1152889655','juanperez@gmail.com'),
(NULL,'Jose','Ceballos','Caracas 2155, CABA','1187923355','joseceballos@mail.com'),
(NULL,'Carla','Farias','Av Segurola 2322 1°B, CABA','1155224855','carlafarias@gmail.com'),
(NULL,'Carolina','Gomez','Av Hipolito Yirigoyen 522, Lanus, GBA','1166128799','gomezcarolina33@gmail.com'),
(NULL,'Norberto','Carrizo','Av Mitre 2251 5°A, Avellaneda, GBA','1165442525','carrizonorberto@mail.com'),
(NULL,'Paula','Carrasco','Av Nazca 859, CABA','1144558484','carrascop@gmail.com'),
(NULL,'Jorge','Gonzalez','Serrano 755, CABA','1154883255', DEFAULT),
(NULL,'Jonathan','Garcia','Av Libertador 5233 11°C, CABA','1154552300','garciajonathan11@gmail.com'),
(NULL,'Cinthia','Morales','Av Callao 202, CABA','1189655145', DEFAULT),
(NULL,'Debora','Caruso','Carlos Calvo 3255 4°A, CABA','1144887784','deboracar@gmail.com');
// DELIMITER ;

COMMIT;

-- Insercion de datos de direcciones de envio de clientes

DELIMITER //
START TRANSACTION;
INSERT INTO direcciones_envio VALUES
(NULL,'1','Av Eva Peron 2155','CABA','Buenos Aires'),
(NULL,'1','Av 25 de Mayo 522','San Rafael','Mendoza'),
(NULL,'2','Av Jujuy 5221','Resistencia','Chaco'),
(NULL,'2','Av 9 de Julio 521','Rosario','Santa Fe'),
(NULL,'2','Carlos Casares 422','Villa Maria','Cordoba'),
(NULL,'3','Gral Cesar Diaz 5524','CABA','Buenos Aires'),
(NULL,'4','Ceballos 252','Lujan','Buenos Aires'),
(NULL,'4','Quitana 5050','Moreno','Buenos Aires'),
(NULL,'5','Bufano 722','CABA','Buenos Aires'),
(NULL,'5','Peru 2666','Salta','Salta'),
(NULL,'5','Av del Campo 526','Rosario','Santa Fe'),
(NULL,'6','Lima 888','CABA','Buenos Aires');
// DELIMITER ;

COMMIT;

-- Insercion de datos de pedidos sin el precio final

DELIMITER //
START TRANSACTION ; 
INSERT INTO pedidos (id, cliente_id, fecha, direnvio_id) VALUES
(NULL,'1','2022/01/22','2'),
(NULL,'5','2022/01/25','10'),
(NULL,'5','2022/01/25','10'),
(NULL,'4','2022/01/30','8'),
(NULL,'1','2022/02/05','2'),
(NULL,'3','2022/02/15','6'),
(NULL,'4','2022/02/17','7'),
(NULL,'4','2022/02/17','7'),
(NULL,'1','2022/02/25','1'),
(NULL,'5','2022/02/26','11'),
(NULL,'5','2022/02/26','11'),
(NULL,'6','2022/03/02','12'),
(NULL,'2','2022/03/10','4');
// DELIMITER ;

COMMIT;


/* Stored Procedure Extra #2: Esta creado pensando en la automatización del sistema, sirve para ingresar el detalle
de un pedido. Al llamarlo ingresamos como parametros el id del pedido al cual vamos a ingresar el detalle, el id de 
la guitarra que se esta pidiendo y la cantidad. Se declaran dos variables, una para obtener el precio de la guitarra
por unidad llamada v_precio_guit y otra para obtener el importe total multiplicando el precio de la guitarra por 
la cantidad llamada v_importe_total. Declaramos un EXIT HANDLER para el error 1690 (BIGINT UNSIGNED) ya que la
columna stock de la tabla guitarras no puede ser negativa, por lo tanto si no tenemos stock suficiente para el
pedido nos dara un mensaje de alerta con el id de guitarra que no cuenta con stock, es muy ventajoso ya que podemos
ingresar varios detalles de un pedido en una sola transaccion y en el caso de que uno de los detalles no tuviera
stock nos va a dar una alerta pero el resto va a quedar guardado, de esta forma tenemos la opcion de ingresar
otro modelo y cantidad, finalizarlo o inclusive hacer un rollback para borrar todo. Primero hacemos un UPDATE
en la tabla guitarras diciendole que el stock va a ser igual al stock actual menos la cantidad ingresada al
llamar al SP donde el id de la guitarra sea igual al id_guitarra ingresado al llamar al SP, es el primer paso
ya que si no contamos con stock el EXIT HANDLER anulara el resto. Como segundo paso hacemos un SELECT para 
obtener el precio de la guitarra de la tabla guitarras donde el id de la misma sea igual al ingresado al SP 
como parametro y se lo damos como valor a la variable v_precio_guit, luego de eso hacemos un INSERT a la tabla 
pedidos_detalle con los datos ingresados al SP y el valor de v_precio_guit. Una vez que ya ingresamos el registro 
del detalle procedemos a darle valor a la variable v_importe_total haciendo un SELECT de la variable v_precio_guit 
por la cantidad ingresada en el SP obteniendo el precio total de este registro para finalizar haciendo un UPDATE 
en la tabla pedidos indicando que el campo precio_total va a tener el valor de este mismo campo sumado a la 
variable v_importe_total donde el id del pedido sea igual al id_pedido ingresado en el llamado a la SP. 
De esta forma cada vez que ingresamos un pedido al ir ingresando el detalle automaticamente se iran sumando 
los valores y cuando finalicemos tendremos el total en nuestra tabla pedidos, a su vez se descontara la cantidad
pedida de nuestro stock de guitarras y se verifica que la misma cuente con stock suficiente. */

DELIMITER //
CREATE PROCEDURE sp_ingresar_detalle_pedido (IN id_pedido INT,
											IN id_guitarra INT,
                                            IN cantidad INT)
BEGIN
	DECLARE v_precio_guit FLOAT;
    DECLARE v_importe_total FLOAT;
    
	DECLARE EXIT HANDLER FOR 1690
    BEGIN
        SELECT CONCAT('La guitarra con el ID ', id_guitarra, ' no cuenta con stock suficiente para la
						operacion') 
                        AS alerta;
	END;
    
	UPDATE guitarras
    SET stock = stock - cantidad
    WHERE id = id_guitarra;
    
	SELECT precio
    INTO v_precio_guit
    FROM guitarras
    WHERE id = id_guitarra;
	
	INSERT INTO pedidos_detalle VALUES
    (NULL, id_pedido, id_guitarra, cantidad, v_precio_guit);

	
    SELECT v_precio_guit * cantidad
    INTO v_importe_total;

    UPDATE pedidos
    SET precio_total = precio_total + v_importe_total
    WHERE id = id_pedido;
    
END;    
// 
DELIMITER ;

/* Insercion de datos de detalles de pedidos con el SP creado, esto tambien nos dara los precios 
finales de los pedidos en la tabla pedidos y nos descontara la cantidad de guitarras pedidas del 
stock de la tabla guitarras. */

DELIMITER //
START TRANSACTION;
CALL sp_ingresar_detalle_pedido(1,5,10);
CALL sp_ingresar_detalle_pedido(1,6,5);
CALL sp_ingresar_detalle_pedido(1,17,20);
CALL sp_ingresar_detalle_pedido(2,11,4);
CALL sp_ingresar_detalle_pedido(2,13,10);
CALL sp_ingresar_detalle_pedido(3,4,9);
CALL sp_ingresar_detalle_pedido(3,5,7);
CALL sp_ingresar_detalle_pedido(3,10,20);
CALL sp_ingresar_detalle_pedido(3,14,12);
CALL sp_ingresar_detalle_pedido(4,3,4);
CALL sp_ingresar_detalle_pedido(4,16,5);
CALL sp_ingresar_detalle_pedido(5,12,22);
CALL sp_ingresar_detalle_pedido(5,17,15);
CALL sp_ingresar_detalle_pedido(5,2,10);
CALL sp_ingresar_detalle_pedido(6,1,20);
CALL sp_ingresar_detalle_pedido(7,2,5);
CALL sp_ingresar_detalle_pedido(7,6,10);
CALL sp_ingresar_detalle_pedido(7,8,6);
CALL sp_ingresar_detalle_pedido(8,1,12);
CALL sp_ingresar_detalle_pedido(8,2,10);
CALL sp_ingresar_detalle_pedido(9,16,10);
CALL sp_ingresar_detalle_pedido(9,13,5);
CALL sp_ingresar_detalle_pedido(9,11,10);
CALL sp_ingresar_detalle_pedido(9,3,6);
CALL sp_ingresar_detalle_pedido(10,5,4);
CALL sp_ingresar_detalle_pedido(10,4,10);
CALL sp_ingresar_detalle_pedido(11,7,14);
CALL sp_ingresar_detalle_pedido(11,8,20);
CALL sp_ingresar_detalle_pedido(11,16,10);
CALL sp_ingresar_detalle_pedido(12,17,2);
CALL sp_ingresar_detalle_pedido(12,13,11);
CALL sp_ingresar_detalle_pedido(12,4,5);
CALL sp_ingresar_detalle_pedido(13,3,10);
CALL sp_ingresar_detalle_pedido(13,15,5);
// DELIMITER ;

COMMIT;


-- PRUEBAS PARA Stored Procedure Extra #2 'sp_ingresar_detalle_pedido'

/* Modificamos el pedido con id 13 en una transaccion cargando nuevos detalles pero no se cuenta con stock 
de todo lo pedido, nos dara dos mensajes de alerta indicando cuales son las guitarras que no hay stock, pero
el resto queda actualizado en el stock de guitarras, en el precio final del pedido y en el detalle, ahora
tenemos la opcion de ofrecerle otro producto, dejarlo asi o bien hacer un rollback y eliminar todo */

/*
DELIMITER //
START TRANSACTION;
CALL sp_ingresar_detalle_pedido(13,14,100);
CALL sp_ingresar_detalle_pedido(13,17,100);
CALL sp_ingresar_detalle_pedido(13,19,150);
CALL sp_ingresar_detalle_pedido(13,11,50);
// DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK
-- ROLLBACK;


/* En una transaccion ingresamos un nuevo pedido y el respectivo detalle con el id de pedido 14 ya que seria
el siguiente por el autoincrement, todo funciona correctamente */

/*
DELIMITER //
START TRANSACTION;
INSERT INTO pedidos (id, cliente_id, fecha, direnvio_id) VALUES
(NULL,'4', CURDATE(),'5');
CALL sp_ingresar_detalle_pedido(14,2,30);
CALL sp_ingresar_detalle_pedido(14,4,25);
CALL sp_ingresar_detalle_pedido(14,9,100);
CALL sp_ingresar_detalle_pedido(14,13,10);
// DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;

/* En una transaccion ingresamos un nuevo pedido y el respectivo detalle con el id de pedido 15 ya que seria
el siguiente por el autoincrement, al no contar con stock de todo lo pedido, nos dara un mensaje de alerta 
indicando cual es la guitarra que no hay stock, pero el resto queda actualizado en el stock de guitarras, 
en el precio final del pedido y en el detalle, ahora tenemos la opcion de ofrecerle otro producto, 
dejarlo asi o bien hacer un rollback y eliminar todo */

/*
DELIMITER //
START TRANSACTION;
INSERT INTO pedidos (id, cliente_id, fecha, direnvio_id) VALUES
(NULL,'5', CURDATE(),'10');
CALL sp_ingresar_detalle_pedido(15,7,50);
CALL sp_ingresar_detalle_pedido(15,10,500);
CALL sp_ingresar_detalle_pedido(15,14,200);
CALL sp_ingresar_detalle_pedido(15,16,80);
// DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK
-- ROLLBACK;

/* NOTA: En el caso de hacer un ROLLBACK por las dudas hacer un alter table de la tabla pedidos, ir al 
a solapa options y volver el Auto Increment a 15 */


-- Creacion de vistas

DELIMITER //
USE fabrica_guitarras;
//
DELIMITER ;

/* Vista #1: Sirve para saber el costo de fabricación de todas las guitarras. El resultado que arroja es la sumatoria
de los costos de los materiales (esto lo logramos con la función SUM de MySQL) y el id de cada una de las guitarras 
gracias al filtro GROUP BY que hace que se agrupen por id. Interactua con las tablas materiales, materiales_guitarras 
y guitarras y es de gran utilidad ya que haciendo filtros podríamos obtener el costo de una sola guitarra o determinadas 
guitarras que querramos saber.*/

DELIMITER //
CREATE OR REPLACE VIEW vs_costo_guitarras
AS SELECT guit.id id_guitarra, SUM(mat.costo) costo
FROM materiales mat
INNER JOIN materiales_guitarras mg ON mat.id = mg.mat_id
INNER JOIN guitarras guit ON guit.id = mg.guit_id
GROUP BY guit.id;
// DELIMITER ;

-- Pruebas para Vista #1 'vs_costo_guitarras'

-- SELECT * FROM vs_costo_guitarras;

/* SELECT * FROM vs_costo_guitarras
WHERE id_guitarra = 5; */

/* SELECT * FROM vs_costo_guitarras
WHERE id_guitarra IN (5,6,7); */


/* Vista #2: Sirve para saber el valor total de mis ventas (esto lo logramos gracias a la función SUM de MySQL) 
y en que cantidad de pedidos (esto lo logramos gracias a la función COUNT de MySQL). Interactúa solamente con 
la tabla pedidos haciendo el conteo de id de pedidos (cantidad de pedidos en que se vendió) y la sumatoria de 
los precios (total vendido).*/

DELIMITER //
CREATE OR REPLACE VIEW vs_total_ventas
AS SELECT COUNT(id) cantidad_pedidos, SUM(precio_total) total
FROM pedidos ped
// DELIMITER ;

-- Pruebas para vista #2 'vs_total_ventas'

-- SELECT * FROM vs_total_ventas;

/* - Vista #3: Sirve para obtener los datos importantes de los proveedores del tipo de material "maderas". 
A través de los INNER JOIN podemos combinar la información usando el filtro WHERE para que solo nos traiga 
información de los proveedores del tipo de material maderas, y con el GROUP BY los agrupamos para no tener 
información repetida. Interactúa con las tablas proveedores, proveedores_materiales y materiales, de gran 
utilidad para obtener una vista rápida de mis proveedores para materiales que son de los más utilizados 
en la fábrica. */

DELIMITER //
CREATE OR REPLACE VIEW vs_proveedores_maderas
AS SELECT prov.nombre, prov.telefono, prov.mail
FROM proveedores prov
INNER JOIN proveedores_materiales pm ON pm.prov_id = prov.id
INNER JOIN materiales mat ON mat.id = pm.mat_id
WHERE mat.tipo = "maderas"
GROUP BY prov.nombre;
// DELIMITER ;

-- Pruebas para vista #3 'vs_proveedores_maderas'

-- SELECT * FROM vs_proveedores_maderas;

/* SELECT * FROM vs_proveedores_maderas
WHERE mail LIKE 'pedir mail'; */

/* Vista #4: Sirve para ver todos los pedidos junto a su valor y dirección de envío. Interactúa con las 
tablas pedidos, clientes y direcciones_envio, dando un vistazo rápido al pedido, su valor y su dirección 
de envío, esto lo logramos gracias a los INNER JOIN que nos trae información de las tablas que necesitamos. 
De gran utilidad para poder identificar a donde hay que enviar cada pedido, también se puede utilizar el 
filtro WHERE para filtrar por el id_pedido y obtener esta misma información de uno o más pedidos determinados. */

DELIMITER //
CREATE OR REPLACE VIEW vs_pedidos_clientes
AS SELECT ped.id id_pedido, ped.precio_total valor, CONCAT(cl.nombre, ' ', cl.apellido) nombre_apellido, 
dir.direccion direccion_envio, dir.localidad, dir.provincia
FROM pedidos ped
INNER JOIN clientes cl ON ped.cliente_id = cl.id
INNER JOIN direcciones_envio dir ON ped.direnvio_id = dir.id
ORDER BY ped.fecha;
// DELIMITER ;

-- Pruebas para vista #4 'vs_pedidos_clientes'

-- SELECT * FROM vs_pedidos_clientes;

/* SELECT * FROM vs_pedidos_clientes
WHERE nombre_apellido LIKE '%carolina%'; */

/* SELECT * FROM vs_pedidos_clientes
WHERE localidad LIKE 'rosario'; */


/* Vista #5: Sirve para saber que materiales necesito para fabricar cada guitarra. Interactúa con las tablas 
materiales, materiales_guitarras y guitarras obteniendo el id de la guitarra, el tipo, y los materiales que 
la componen con sus respectivos tipos e id, esto lo logramos gracias a los INNER JOIN que nos trae información 
de las tablas que necesitamos. Es de gran utilidad ya que si necesito saber que materiales necesito para 
fabricar una determinada guitarra puedo utilizar el filtro WHERE con la vista pasándole el id_guitarra para 
que solo me devuelva esos datos, o bien podríamos usar el filtro WHERE con el id del material para saber que 
guitarras utilizan determinado material. */

DELIMITER //
CREATE OR REPLACE VIEW vs_material_p_guitarra
AS SELECT guit.id id_guitarra, guit.tipo tipo_guitarra, guit.modelo modelo_guitarra, mat.id id_material, 
mat.tipo tipo_material, mat.marca marca_material, mat.modelo modelo_material
FROM materiales mat
INNER JOIN materiales_guitarras mg ON mat.id = mg.mat_id
INNER JOIN guitarras guit ON guit.id = mg.guit_id;
// DELIMITER ;

-- Pruebas para vista #5 'vs_material_p_guitarra'

-- SELECT * FROM vs_material_p_guitarra;

/* SELECT * FROM vs_material_p_guitarra
WHERE id_guitarra = 11; */

/* SELECT * FROM vs_material_p_guitarra
WHERE id_material = 5; */


/* Vista #6: Sirve para saber de qué materiales tengo stock bajo junto con los datos del proveedor 
que lo vende. Interactúa con las tablas materiales, proveedores_materiales y proveedores, con los 
INNER JOIN matcheamos las tablas de las cuales necesitamos traer la información, y gracias al filtro 
WHERE le indicamos que el stock del material tiene que ser menor o igual a 500 para que solo nos traiga 
los resultados inferiores a ese número. Es de gran utilidad para hacer reposición de materiales ya que 
podemos saber de forma rápida cual es el stock bajo y quien es el que lo provee de estos materiales, 
también con el filtro WHERE podríamos traer stock bajo de determinados tipos de materiales o de 
determinados proveedores.*/

DELIMITER //
CREATE OR REPLACE VIEW vs_stock_bajo_materiales
AS SELECT mat.id id_material, mat.tipo, mat.modelo, mat.stock, prov.nombre nombre_proveedor, 
prov.telefono, prov.mail
FROM materiales mat
INNER JOIN proveedores_materiales pm ON mat.id = pm.mat_id
INNER JOIN proveedores prov ON prov.id = pm.prov_id
WHERE mat.stock <= 500;
// DELIMITER ;

-- Pruebas para vista #6 'vs_stock_bajo_materiales'

-- SELECT * FROM vs_stock_bajo_materiales;

/* SELECT * FROM vs_stock_bajo_materiales
WHERE tipo LIKE 'cuerdas'; */

/* SELECT * FROM vs_stock_bajo_materiales
WHERE nombre_proveedor LIKE '%tres%'; */

/* Vista #7: Sirve para saber de qué guitarras tengo stock bajo para fabricar más. Interactúa solamente 
con la tabla guitarras, dando un vistazo rápido de las guitarras que tienen menos de 200 unidades de 
stock con su id, tipo y modelo, esto lo logramos gracias al filtro WHERE indicándole que el stock tiene 
que ser menor o igual a 200 para que solo nos traiga los resultados inferiores a ese número. Con el 
filtro WHERE podríamos traer stock bajo de guitarras de determinado tipo que es un detalle interesante 
si por ejemplo solo quisiéramos saber de qué guitarras eléctricas tenemos stock bajo. */

DELIMITER //
CREATE OR REPLACE VIEW vs_stock_bajo_guitarras
AS SELECT id, tipo, modelo, stock
FROM guitarras
WHERE stock <= 200;
// DELIMITER ;

-- Pruebas para vista #7 'vs_stock_bajo_materiales'

-- SELECT * FROM vs_stock_bajo_guitarras;

/* SELECT * FROM vs_stock_bajo_guitarras
WHERE tipo LIKE '%clasica%'; */


/* Vista #8: Sirve para saber cuál es el promedio de ventas y en qué cantidad de pedidos. Interactúa 
solamente con la tabla pedidos, esto lo logramos gracias a la función AVG en el caso del promedio de 
ventas y a la función COUNT en el caso de cantidad de pedidos, una forma rápida de tener un vistazo 
del promedio de ventas.  */

DELIMITER //
CREATE OR REPLACE VIEW vs_promedio_ventas
AS SELECT ROUND(AVG(precio_total), 2) promedio_venta, COUNT(id) total_pedidos
FROM pedidos;
// DELIMITER ;

-- Pruebas para vista #8 'vs_promedio_ventas'

-- SELECT * FROM vs_promedio_ventas;


-- Creacion de funciones

DELIMITER //
USE fabrica_guitarras;
// DELIMITER ;

/* Funcion #1: Sirve para calcular el costo de un pedido mediante el id del mismo. Declaramos la variable 
v_resultado la cual va a guardar la sumatoria de los costos de los materiales según el id de pedido que 
se ingrese al llamar a la FX multiplicándolo por la cantidad del pedido, dando como resultado el costo total 
para ese pedido, esto con ayuda de los INNER JOIN que nos traen información de las tablas que necesitamos y 
el filtro WHERE al cual le indicamos que el id del pedido tiene que ser el mismo que ingresamos al llamar a 
la FX. Interactúa con las tablas materiales, materiales_guitarras, guitarras y pedidos_detalle. Es de gran 
utilidad a la hora de ingresar un pedido nuevo para saber cuál sería el costo de fabricación del mismo.*/

DELIMITER //
CREATE FUNCTION `fx_calc_cst_ped` (id INT)
RETURNS FLOAT
READS SQL DATA
BEGIN
	DECLARE v_resultado FLOAT;
    
    SELECT SUM((mat.costo * mg.cantidad) * pd.guit_cant)
    INTO v_resultado
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
    INNER JOIN pedidos_detalle pd ON pd.guit_id = guit.id
	WHERE pd.ped_id = id;
    
	RETURN v_resultado;
END
// DELIMITER ;

-- Pruebas para funcion #1 'fx_calc_cst_ped'

-- SELECT fx_calc_cst_ped(11);


/* Funcion #2: Sirve para calcular el costo de fabricación de una guitarra mediante el id de la misma. 
Declaramos la variable v_resultado la cual va a guardar la sumatoria de los costos de materiales según 
el id de guitarra y devuelve el total, esto lo logramos gracias a la función SUM para sumar los costos, 
los INNER JOIN para traer la información necesaria, y el filtro WHERE donde indicamos que el id de la 
guitarra tiene que ser igual al id ingresado al llamar al SP. Interactúa con las tablas materiales,
materiales_guitarras y guitarras, de gran utilidad para saber el costo de una guitarra de forma rápida, 
bien podríamos multiplicar la función por el número de guitarras que queremos fabricar para obtener el 
costo total del proceso. También nos será muy útil mas adelante para el Stored Procedure de actualización 
de costo de un material para poder actualizar también el nuevo precio de venta de una guitarra en base al 
nuevo costo del material.  */

DELIMITER //
CREATE FUNCTION `fx_calc_cst_guit`(id INT) 
RETURNS FLOAT
READS SQL DATA
BEGIN
	DECLARE v_resultado FLOAT;
    
    SELECT SUM(mat.costo)
    INTO v_resultado
	FROM materiales mat
	INNER JOIN materiales_guitarras mg ON mg.mat_id = mat.id
	INNER JOIN guitarras guit ON guit.id = mg.guit_id
	WHERE guit.id = id;
    
	RETURN v_resultado;
END
// DELIMITER ;

-- Pruebas para funcion #2 'fx_calc_cst_guit'

-- SELECT fx_calc_cst_guit(2);

-- SELECT fx_calc_cst_guit(10) * 50;

/* Funcion #3: Sirve para calcular cuántos pedidos realizo un cliente mediante el id del mismo. Declaramos 
la variable v_resultado que va a guardar el resultado del conteo de cantidad de pedidos, esto lo logramos 
gracias a la función COUNT donde como parámetro le pasamos el id que ingresamos al llamar al SP y al filtro 
WHERE donde le indicamos que el id del cliente tiene que ser igual también al id que ingresamos. Puede ser 
útil para sacar estadísticas de quienes son los clientes que más compras realizan y en base a eso definir de 
qué forma pueden pagar o si tienen algún tipo de descuento.*/

DELIMITER //
CREATE FUNCTION `fx_calc_ctped_cl`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE v_resultado INT;
    
	SELECT COUNT(id)
    INTO v_resultado
	FROM pedidos
	WHERE cliente_id = id;
    
	RETURN v_resultado;
END
// DELIMITER ;

-- Pruebas para funcion #3 'fx_calc_ctped_cl'

-- SELECT fx_calc_ctped_cl(5);

/* SELECT fx_calc_ctped_cl(4) cantidad_pedidos, cl.id id_cliente, cl.nombre, cl.apellido
FROM clientes cl
WHERE id = 4; */


/* Funcion #4: Sirve para calcular cuántos días pasaron desde el ultimo pedido que hizo un cliente 
mediante su id. Con la variable v_fecha1  guardamos la última fecha en la que realizó un pedido 
según el id que se ingrese al llamar a la FX, esto lo logramos gracias al ORDER BY de manera 
descendente y limitando los resultados a 1 en la consulta, con la variable v_fecha2 guardamos la 
fecha actual gracias al método CURDATE, luego en la variable v_resultado sacamos la diferencia 
entre estas dos para obtener el total de días gracias al método DATEDIFF. Interactúa solamente 
con la tabla pedidos y es de gran utilidad para saber si por ejemplo paso mucho tiempo desde que 
un cliente no realiza un pedido. */

DELIMITER //
CREATE FUNCTION `fx_calc_ctdi_ultped`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE v_fecha1 DATE;
    DECLARE v_fecha2 DATE;
    DECLARE v_resultado INT;
    
	SELECT ped.fecha
    INTO v_fecha1
	FROM pedidos ped
	WHERE cliente_id = id
	ORDER BY fecha DESC
	LIMIT 1;
    
    SELECT CURDATE() FROM DUAL
    INTO v_fecha2;
    
    SELECT DATEDIFF(v_fecha2,v_fecha1)
    INTO v_resultado;
    
	RETURN v_resultado;
END
// DELIMITER ;

-- Pruebas para funcion #4 'fx_calc_ctdi_ultped'

-- SELECT fx_calc_ctdi_ultped(2);

/* SELECT cl.id id_cliente, cl.nombre, cl.apellido, fx_calc_ctdi_ultped(5) dias_ultped
FROM clientes cl
WHERE cl.id = 5; */


/* Funcion #5: Sirve para calcular la cantidad de pedidos entre 2 fechas que ingrese el usuario. 
La función recibe como parámetros las dos fechas entre las cuales queremos saber el total, 
declaramos una variable v_resultado done vamos a guardar esta diferencia, luego le damos valor 
haciendo una consulta con el método COUNT haciendo un conteo del campo id de la tabla pedidos y 
con el filtro WHERE decimos que la fecha tiene que estar entre las dos ingresadas al llamar a la FX. 
Es de gran utilidad para saber cuántos pedidos se tuvo en un determinado periodo de forma rápida.*/

DELIMITER //
CREATE FUNCTION `fx_calc_ctped_xfech`(fecha1 DATE, fecha2 DATE) 
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_resultado INT;
    
	SELECT COUNT(id)
    INTO v_resultado
	FROM pedidos
	WHERE fecha BETWEEN fecha1 AND fecha2;
    
	RETURN v_resultado;
END
// DELIMITER ;

-- Pruebas para funcion #6 'fx_calc_ctped_xfech'

-- SELECT fx_calc_ctped_xfech('2022-01-01', '2022-01-31');


-- Creacion de Stored Procedures

/* Stored Procedure #1: Sirve para ordenar la tabla de guitarras según los parametros que ingresa
el usuario. En total recibe 2 parametros, el primero corresponde a sobre que campo se va a hacer
el orden, el segundo corresponde a la forma en que se va a hacer ese orden (ASC, DESC).
Para poder realizarlo utilicé el condicional CASE para cada caso, de tal forma que cuando se llama
al SP los parametros que espera son de tipo INT, siendo que en el caso del campo son valores
del 1 al 6 y son en el mismo orden que esta la tabla, y en el caso del orden son valores 1 para
ASC y 2 para DESC. Por ejemplo si hicieramos un CALL con parametros 3 y 2 lo ordenaría por 
modelo de forma descendente. Interactúa con la tabla guitarras, es beneficiosa para poder hacer
consultas rapidas en una tabla que va a ser muy utilizada.*/

DELIMITER //
CREATE PROCEDURE sp_orden_guitarras (IN campo INT, IN orden INT)
BEGIN
    SELECT * 
    FROM guitarras 
    ORDER BY
    CASE WHEN campo = 1 AND orden = 1 THEN id END,
    CASE WHEN campo = 1 AND orden = 2 THEN id END DESC,
    CASE WHEN campo = 2 AND orden = 1 THEN tipo END,
	CASE WHEN campo = 2 AND orden = 2 THEN tipo END DESC,
	CASE WHEN campo = 3 AND orden = 1 THEN modelo END,
	CASE WHEN campo = 3 AND orden = 2 THEN modelo END DESC,
	CASE WHEN campo = 4 AND orden = 1 THEN ano END,
	CASE WHEN campo = 4 AND orden = 2 THEN ano END DESC,
	CASE WHEN campo = 5 AND orden = 1 THEN stock END,
	CASE WHEN campo = 5 AND orden = 2 THEN stock END DESC,
	CASE WHEN campo = 6 AND orden = 1 THEN precio END,
	CASE WHEN campo = 6 AND orden = 2 THEN precio END DESC;
END
// DELIMITER ;

-- Pruebas para Stored Procedure #1 'sp_orden_guitarras'

-- Por precio descendente
-- CALL sp_orden_guitarras(6,2);

-- Por ano ascendente
-- CALL sp_orden_guitarras(4,1);


/* Stored Procedure #2: Sirve para eliminar registros en la tabla pedidos, su funcionamiento
es muy simple, al llamar al stored procedure se ingresa el id del pedido que se desea eliminar
y este es comparado con el id de pedido de la tabla pedidos_detalle, busca los iguales y los elimina, 
una vez hecho esto hace lo mismo con la tabla pedidos, primero tiene que eliminar el detalle
del pedido ya que por la FK que tienen no podría eliminar el pedido si no elimino primero el detalle. 
Interactua con las tablas pedidos y pedidos_detalle, es una forma rapida y facil de eliminar registros 
en una tabla con mucha interaccion, es normal que algun pedido pueda ser cancelado o se quiera eliminar 
un pedido viejo.*/

DELIMITER //
CREATE PROCEDURE sp_eliminar_pedido (IN id INT)
BEGIN
	DELETE FROM pedidos_detalle pd
    WHERE pd.ped_id = id;
	DELETE FROM pedidos ped
    WHERE ped.id = id;
END					
// DELIMITER ; 

-- Prueba para Stored Procedure #2 'sp_elimiar_pedido'

-- CALL sp_eliminar_pedido(5);

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK;
-- ROLLBACK;

/* Store Procedure #3: Sirve para ingresar nuevos clientes, cuando se lo llama se ingresan los 
parámetros de nombre, apellido, dirección, teléfono y mail y crea un nuevo registro en la tabla 
de clientes con el próximo id. Una forma rápida y simple de ingresar un nuevo cliente.*/

DELIMITER //
CREATE PROCEDURE sp_ingresar_cliente (IN nombre VARCHAR(45),
                                      IN apellido VARCHAR(45),
                                      IN direccion VARCHAR(200),
                                      IN telefono INT,
                                      IN mail VARCHAR(60))
BEGIN
	INSERT INTO clientes VALUES
    (NULL, nombre, apellido, direccion, telefono, mail);
END
// DELIMITER ;

-- Prueba para Stored Procedure #3 'sp_ingresar_cliente'

-- CALL sp_ingresar_cliente('Josefina', 'Vera', 'Peru 233, CABA', 1154332244, 'josevera@gmail.com');

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK
-- ROLLBACK;

/* NOTA: En el caso de hacer un ROLLBACK por las dudas hacer un alter table de la tabla clientes, ir al 
a solapa options y volver el Auto Increment a 11. */


/* Stored Procedure #4: Sirve para ingresar stock de las guitarras fabricadas, su gran ventaja
es que también hace una actualización del stock de los materiales utilizados para la fabricacion.
Al ser llamado se ingresan como parametros el id de la guitarra que se desea actualizar y el stock
que le queremos agregar. Declaramos tres variables, v_idmat, v_cantmat y v_finbucle que nos van a 
ayudar a guardar la informacion generada ya que a continuacion declaramos un CURSOR que va a hacer
un SELECT de el id del material y cantidad de la tabla materiales_guitarras donde el id de la 
guitarra sea igual al id ingresado al llamar al SP, luego con un loop va a recorrer todos los
materiales cuyo id de guitarra coincida. Declaramos un CONTINUE HANDLER para NOT FOUND y le decimos
que actualice la variable v_finbucle a 1 (su DEFAULT es 0, funcionaria como TRUE or FALSE), esto 
nos va a ayudar a poder parar el loop ya que sino seria infinito. Declaramos un EXIT HANDLER para 
el error 1690 (BIGINT UNSIGNED) ya que el campo stock de la tabla materiales no puede ser negativo
por lo tanto si no disponemos stock suficiente para la actualizacion hace un rollback y nos da 
una alerta de que la operacion fue cancelada y cual es el id del material que no cuenta con stock
suficiente. El primer paso es hacer un UPDATE en la tabla guitarras y le decimos que 
el campo stock es igual al stock actual sumado a la cantidad ingresada al llamar al SP donde el 
id de la guitarra es igual al id ingresado al llamar al SP (esto debe ser antes de abrir el cursor
ya que sino entra en el loop). Ahora abrimos el cursor, declaramos al nombre bucle como LOOP,
y hacemos un FETCH del cursor a las variables v_idmat y v_cantmat, gracias al loop hara el recorrido
e ira guardando los valores que necesitamos. A continuacion abrimos un IF y le decimos que si la
variable v_finbucle es igual a 1 deje el loop, esto es gracias a que anteriormente hicimos el 
CONTINUE HANDLER para que cuando ya no encontrara resultados que coincidan ponga esta variable en 1.
Por ultimo hacemos un UPDATE en la tabla materiales y le decimos que el stock va a ser igual al 
stock actual menos la cantidad ingresada cuando llamamos al SP, osea la cantidad de guitarras, 
por la variable v_cantmat que es la que va recorriendo la cantidad de materiales utilizados segun
el id de guitarra de la tabla materiales_guitarras donde el id del material coincida con la variable
v_idmat que es la que va recorriendo los id de materiales segun el id de guitarra en la tabla
materiales_guitarras, todo esto gracias al loop. Finalizamos dejando el bucle y cerrando el cursor.
Es una forma rapida para hacer varias actualizaciones en un solo paso, cuando terminamos el proceso de 
fabricacion y vamos a ingresar mas stock de un modelo tambien actualizamos el stock de los materiales 
que se utilizaron para todo. */

DELIMITER //
CREATE PROCEDURE sp_actstock_guitarra (IN id INT,
										IN cant INT)
BEGIN
	DECLARE v_idmat INT;
    DECLARE v_cantmat INT;
    DECLARE v_finbucle INT DEFAULT 0;
    
    DECLARE cursormat CURSOR FOR SELECT mat_id, cantidad FROM materiales_guitarras WHERE guit_id = id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finbucle = 1;
    
    DECLARE EXIT HANDLER FOR 1690
    BEGIN
		ROLLBACK;
        SELECT CONCAT('	El material con ID ', v_idmat, ' utilizado para el producto seleccionado con
						ID ', id, ' no cuenta con stock suficiente, la operacion ha sido cancelada') 
                        AS alerta;
	END;
    
    UPDATE `guitarras` guit
    SET guit.stock = guit.stock + cant
    WHERE guit.id = id;
    
    OPEN cursormat;
    
    bucle: LOOP
		
        FETCH cursormat INTO v_idmat, v_cantmat;
        
        IF v_finbucle = 1 THEN
			LEAVE bucle;
		END IF;
    
    UPDATE `materiales` mat
    SET mat.stock = mat.stock - (cant * v_cantmat) 
    WHERE mat.id = v_idmat;

END LOOP bucle;
CLOSE cursormat;
    
END			
// DELIMITER ;

-- Prueba para Stored Procedure #4 'sp_actstock_guitarra'

/* Hacemos una actualizacion de la guitarra con id 1 y le ingresamos 30 unidades al stock en una transaccion, 
todo funciona correctamente, podemos chequear que tambien se restaron las unidades correspondientes de los
materiales con id 4, 12, 24 y 29, podemos ver esta relacion en la tabla materiales_guitarras. */

/*
DELIMITER //
START TRANSACTION;
CALL sp_actstock_guitarra(1, 30);
// DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;

/* Hacemos una actualizacion de la guitarra con id 2 y le ingresamos 1500 unidades al stock en una transaccion, 
pero no se cuenta con stock de todos los materiales, gracias al HANDLER EXIT que hace el rollback se anula toda
la operacion y nos da una alerta de cual es el material que esta faltando, ahora podemos revisar si el stock
de guitarras que ingresamos estuvo bien, o si por ejemplo hubiese algun material asignado que estuviese mal. */

/* 
DELIMITER //
START TRANSACTION;
CALL sp_actstock_guitarra(2, 1500);
// DELIMITER ;
*/

/* Stored procedure #5: Sirve para actualizar el costo de un material (ya sea que haya bajado o subido su valor),
y es de gran utilidad ya segun el id del material selecciona todas las guitarras que utilicen el mismo y actualiza
su precio de venta en base al nuevo costo del material. Los parametros que va a recibir cuando lo llamamos son el
id del material que queremos actualizar y su costo. Declaramos una variable llamada v_idguit que nos va a ayudar
a obtener todos los id de guitarras que usen ese material gracias a un cursor y otra variable llamada v_finbucle
que nos ayudara a detener el loop del cursor. Declaramos el cursor llamado cursorguit para que seleccione todos 
los id de guitarra de la tabla materiales_guitarras donde el id del material coincida con el id ingresado al 
llamar al SP, luego declaramos un CONTINUE HANDLER para NOT FOUND (no encuentras mas resultados) y seteamos la 
variable v_finbucle con valor 1 para que detenga el loop. Primero hacemos un UPDATE en la tabla materiales y 
actualizamos el costo con el valor ingresado al llamar al SP donde el id de material coincida con el id ingresado 
al llamar al SP (es importante que esto sea primero ya que sino queda dentro del loop). Ahora si abrimos el cursor
y declaramos al bucle como LOOP, luego hacemos un FETCH del cursor a la variable v_idguit, la cual va actualizando 
su valor con todos los id de guitarra que correspondan al material, ponemos un condicional IF para que cuando la
variable v_finbucle sea igual a 1 haga un LEAVE del bucle, esto gracias al CONTINUE HANDLER declarado anteriormente.
Como ultimos pasos hacemos un UPDATE en la tabla guitarras y le decimos que actualice el precio (aqui utilizamos la
funcion 'fx_calc_cst_guit' la cual nos va a ayudar a calcular el nuevo costo de la guitarra con el costo del material
actualizado y como parametro le vamos a pasar la variable v_idguit que es la que va recorriendo todos los id de las
guitarras que hay que actualizar y lo multiplicamos por 1.7 para ya obtener nuestro precio final de venta) donde el
id de la guitarra sea igual a la variable v_idguit que como ya dijimos es la que recorre todos los id de guitarras
correspondientes. Para finalizar hacemos un END LOOP del bucle y cerramos el cursor. */

DELIMITER //
CREATE PROCEDURE sp_actcosto_mat (IN id INT,
								  IN costo INT)
BEGIN
	DECLARE v_idguit INT;
    DECLARE v_finbucle INT DEFAULT 0;
	DECLARE cursorguit CURSOR FOR SELECT guit_id FROM materiales_guitarras WHERE mat_id = id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finbucle = 1;
    
	UPDATE materiales mat
    SET mat.costo = costo
    WHERE mat.id = id;
    
    OPEN cursorguit;
    
    bucle: LOOP
		
        FETCH cursorguit INTO v_idguit;
        
        IF v_finbucle = 1 THEN
			LEAVE bucle;
		END IF;
        
    UPDATE guitarras guit
    SET guit.precio = fx_calc_cst_guit(v_idguit) * 1.7
    WHERE guit.id = v_idguit;
    
    END LOOP bucle;
CLOSE cursorguit;

END
// DELIMITER ;

-- Pruebas para stored procedure #5 'sp_actcosto_mat'

/* Actualizamos el costo del material 2 a 2000 (aumento), podemos chequear que su costo ha cambiado en la 
tabla de materiales y tambien se ha actualizado el costo de las guitarras correspondientes con id 14 y 18,
podemos chequear la relacion del material con las guitarras en la tabla materiales_guitarras. Tambien
podremos ver el movimiento en la tabla movimientos_materiales gracias al trigger #3 explicado mas adelante. */

/*
DELIMITER //
START TRANSACTION;
CALL sp_actcosto_mat (2, 2000);
// DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK
-- ROLLBACK;

/* Actualizamos el costo del material 26 a 1300 (disminuyo), podemos chequear que su costo ha cambiado en la 
tabla de materiales y tambien se ha actualizado el costo de las guitarras correspondientes con id 3 y 4,
podemos chequear la relacion del material con las guitarras en la tabla materiales_guitarras. Tambien
podremos ver el movimiento en la tabla movimientos_materiales gracias al trigger #3 explicado mas adelante. */

/*
DELIMITER //
START TRANSACTION;
CALL sp_actcosto_mat (26, 1300);
// DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK
-- ROLLBACK;


-- Creacion de Triggers

/* Trigger #1: Guarda información de fecha y usuario que realizo el movimiento y el id y cliente del pedido 
sobre el cual se realizó cuando hacemos un INSERT en la tabla pedidos. Utilizamos las variables @nom y @ape 
para guardar el nombre y el apellido de la tabla clientes, luego lo concatenamos en la variable @dat que 
vamos a utilizar para poder insertar el nombre y apellido del cliente dentro del campo cliente de la tabla 
de movimientos, también utilizamos los métodos CURDATE, CURTIME y USER para obtener los datos de fecha, 
horario y usuario que realizó el movimiento. Es muy útil a futuro ya que podemos tener registros de quien 
fue el que ingreso un pedido en el caso de que se haya ingresado mal algún dato.*/

DELIMITER //
CREATE TRIGGER `ingreso_nuevo_pedido`
AFTER INSERT ON `pedidos`
FOR EACH ROW
BEGIN
SELECT nombre, apellido INTO @nom, @ape FROM clientes WHERE clientes.id = NEW.cliente_id ;
SET @dat = CONCAT(@nom, ' ', @ape);
INSERT INTO `movimientos_pedidos` (id_mov, fecha_mov, hora_mov, usuario_mov, id_ped, cliente)
VALUES (NULL, CURDATE(), CURTIME(), USER(), NEW.id, 
		CONCAT('Se ingreso un nuevo pedido del cliente ', @dat));
END
// DELIMITER ;

-- Prueba para Trigger #1 'ingreso_nuevo_pedido'

/*
DELIMITER //
INSERT INTO pedidos (id, cliente_id, fecha, direnvio_id) VALUES
(NULL,'4', CURDATE(),'5');
// DELIMITER ;
*/

-- Detalle para el nuevo pedido

/*
DELIMITER //
START TRANSACTION;
CALL sp_ingresar_detalle_pedido(15,3,25);
CALL sp_ingresar_detalle_pedido(15,7,32);
CALL sp_ingresar_detalle_pedido(15,10,41);
CALL sp_ingresar_detalle_pedido(15,15,32);
// DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;


/* Trigger #2: Guarda información de fecha y usuario que realizo el movimiento y el id y cliente del 
pedido sobre el cual se realizó cuando hacemos un DELETE en la tabla pedidos. Utilizamos las variables
@nom y @ape para guardar el nombre y el apellido de la tabla clientes, luego lo concatenamos en la 
variable @dat que vamos a utilizar para poder insertar el nombre y apellido del cliente dentro del 
campo cliente de la tabla de movimientos, también utilizamos los métodos CURDATE, CURTIME y USER 
para obtener los datos de fecha, horario y usuario que realizó el movimiento. Es muy útil a futuro 
ya que podemos tener registros de quien fue el que elimino un pedido si se eliminó mal o cual había 
sido su valor. */

DELIMITER //
CREATE TRIGGER `borrar_pedido`
BEFORE DELETE ON `pedidos`
FOR EACH ROW
BEGIN
SELECT nombre, apellido INTO @nom, @ape FROM clientes WHERE clientes.id = OLD.cliente_id ;
SET @dat = CONCAT(@ape, ' ', @nom);

INSERT INTO `movimientos_pedidos` (id_mov, fecha_mov, hora_mov, usuario_mov, id_ped, cliente)
VALUES (NULL, CURDATE(), CURTIME(), USER(), OLD.id, CONCAT('Se elimino un pedido del cliente ', @dat,
							' con el precio de $ ', OLD.precio_total));
END
// DELIMITER ;


-- Prueba para Trigger #2 'borrar_pedido'

/* Eliminamos un pedido llamando al SP 'sp_eliminar_pedido' que nos facilita la
tarea ya que tambien nos borra el detalle por la FK que tienen entre ambas. */

/*
DELIMITER //
CALL sp_eliminar_pedido(10);
// DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK
-- ROLLBACK;

/* Trigger #3: Guarda información de fecha y usuario que realizo el movimiento y el id, tipo, 
costo viejo, costo nuevo y diferencia de costo en % del material sobre el cual se realizó 
cuando hacemos un UPDATE en la tabla materiales sobre el campo costo. Gracias al condicional 
IF donde ponemos que el OLD(viejo) costo tiene que ser diferente del NEW(nuevo) costo este 
trigger solamente se activara cuando haya actualizaciones de costo, también utilizamos los 
métodos CURDATE, CURTIME y USER para fecha, hora y usuario del movimiento y el método ROUND 
para redondear el resultado cuando hacemos el cálculo de la diferencia en porcentaje. Tiene 
2 utilidades, la primera es poder saber quién realizo el movimiento en el caso de que haya 
habido algún error a la hora de modificar un precio, la segunda es poder saber en qué porcentaje 
aumento o disminuyo el costo del material. */

DELIMITER //
CREATE TRIGGER `actualizar_costo_material`
BEFORE UPDATE ON `materiales`
FOR EACH ROW
BEGIN
	IF OLD.costo <> NEW.costo THEN
		INSERT INTO `movimientos_materiales` (id_mov, fecha_mov, hora_mov, usuario_mov, id_mat, 
									  tipo_mat, costo_mat, costo_viejo, costo_dif, detalle)
		VALUES (NULL, CURDATE(), CURTIME(), USER(), OLD.id, OLD.tipo, NEW.costo, OLD.costo, 
		CONCAT(ROUND((((NEW.costo - OLD.costo) * 100) / OLD.costo),2), ' %'), 
        'Actualizacion de precio');
	END IF;
END
// DELIMITER ;

-- Prueba para Trigger #3 'actualizar_costo_material'

/* Con esta prueba aparte de poder ver el movimiento en la tabla movimiento_materiales
podemos chequear que los precios de las guitarras con id 15, 16, 19 y 20 que son las que
utilizan este material gracias al 'sp_actcosto_mat'. */

/*
DELIMITER //
CALL sp_actcosto_mat (3, 1800);
//
DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK
-- ROLLBACK;


/* Trigger #4: Guarda información de fecha y usuario que realizo el movimiento y el id, tipo 
y costo del material sobre el cual se realizó cuando hacemos un INSERT en la tabla materiales. 
Usamos los métodos CURDATE, CURTIME y USER para traer la fecha, hora y usuario que realizo el
movimiento. Su beneficio es poder saber quién hizo el ingreso de un nuevo material al sistema 
en el caso de que se haya ingresado algún dato mal o poder saber en qué fecha ingreso por 
última vez un material para calcular cuánto hubo de gasto.  */

DELIMITER //
CREATE TRIGGER `ingresar_material`
AFTER INSERT ON `materiales`
FOR EACH ROW
BEGIN
INSERT INTO `movimientos_materiales` (id_mov, fecha_mov, hora_mov, usuario_mov, id_mat, 
									  tipo_mat, costo_mat, costo_viejo, costo_dif, detalle)
VALUES (NULL, CURDATE(), CURTIME(), USER(), NEW.id, NEW.tipo, NEW.costo, NULL, NULL, 
		'Ingreso nuevo material');
END
// DELIMITER ;

-- Prueba para Trigger #4 'ingresar_material'

/*
DELIMITER //
INSERT INTO materiales VALUES
(NULL, 'microfonos', 'Fender', 'Texas Special', 'Set x3 para electrica', '250', '8000');
//
DELIMITER ;
*/

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK;
-- ROLLBACK;