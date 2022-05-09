-- Pruebas para usuario produccionfabrica

-- Puede ingresar un nuevo modelo de guitarra y utilizar las SP a la que le dimos permiso

/* Nota: Si al hacer esta transaccion da error de CANNOT UPDATE CHILD ROW, chequear el numero de id
de guitarra que esta en el SP de los detalles, puede haber quedado mal por las pruebas anteriores, se
puede volver al id haciendo ALTER TABLE a la tabla pedidos o bien poner el id correspondiente en los
SP. */

DELIMITER //
START TRANSACTION;
INSERT INTO guitarras (id, tipo, modelo, ano, stock) VALUES 
(NULL,'Electrica','SG','2022','200');

CALL sp_ingresar_materiales_guitarras (7,22,1);
CALL sp_ingresar_materiales_guitarras (17,22,1);
CALL sp_ingresar_materiales_guitarras (26,22,1);
CALL sp_ingresar_materiales_guitarras (34,22,1);
// DELIMITER ;

-- Opcion COMMIT;
-- COMMIT;

-- Opcion ROLLBACK;
-- ROLLBACK;

/* En el caso de hacer un ROLLBACK podemos hacer un ALTER TABLE de la tabla guitarras y volver el auto increment
al numero anterior gracias a que también le dimos permiso para eso. */

-- Puede actualizar el costo de un material y utilizar la SP a la que le dimos permiso
/* Cuando realicemos el movimiento podemos chequear que la actualización de precio quedo reflejada en la tabla
movimientos_materiales con el nuevo usuario. También se actualizaran los precios de las guitarras con id 5 y 21
gracias al funcionamiento del SP, que son las que utilizan este material. */

DELIMITER //
START TRANSACTION;
CALL sp_actcosto_mat(14, 5500);
// DELIMITER ;

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK
-- ROLBACK;

-- Puede hacer consultas de cualquier tipo a las tablas y vistas disponibles.

SELECT * FROM proveedores;
SELECT * FROM materiales WHERE tipo = 'microfonos';
SELECT * FROM vs_stock_bajo_guitarras WHERE tipo = 'electrica';
SELECT * FROM vs_stock_bajo_materiales WHERE tipo = 'maderas';

-- Puede utilizar las FX disponibles.

SELECT fx_calc_cst_guit(15);