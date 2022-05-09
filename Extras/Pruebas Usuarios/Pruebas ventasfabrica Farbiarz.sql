-- Pruebas para usuario ventasfabrica.

-- Puede hacer consultas a la tabla guitarras.
SELECT * FROM guitarras;

-- No puede insertar, actualizar ni borrar en la tabla guitarras.
INSERT INTO guitarras (id, tipo, modelo, ano, stock) VALUES 
(NULL,'Electrica','Stratocaster','2020','570');

UPDATE guitarras
SET ano = 2021
WHERE id = 5;

DELETE FROM guitarras
WHERE id = 10;

/* Puede hacer consultas, insertar, actualizar y borrar registros de las tablas
pedidos, pedidos_detalle, clientes, direcciones_envio y movimientos_pedidos. */

-- También puede utilizar los SP para los cuales le dimos permiso.

/* Nota: Si al hacer esta transaccion da error de CANNOT UPDATE CHILD ROW, chequear el numero de id
de pedido que esta en el SP de los detalles, puede haber quedado mal por las pruebas anteriores, se
puede volver al id haciendo ALTER TABLE a la tabla pedidos o bien poner el id correspondiente en los
SP. */

DELIMITER //
START TRANSACTION;
INSERT INTO pedidos (id, cliente_id, fecha, direnvio_id) VALUES
(NULL,'1', CURDATE(),'2');
CALL sp_ingresar_detalle_pedido(16,4,40);
CALL sp_ingresar_detalle_pedido(16,7,36);
CALL sp_ingresar_detalle_pedido(16,14,25);
CALL sp_ingresar_detalle_pedido(16,17,8);
// DELIMITER ;

-- Podemos chequear en la tabla de movimientos que quedo registrado el pedido con el nuevo usuario

-- Opcion COMMIT
-- COMMIT;

/* Opcion ROLLBACK, podemos chequear que puede hacerlo gracias al permiso de la tabla movimiento_pedidos
ya que al borrar el pedido también borra el movimiento registrado. */

-- ROLLBACK;

/* En el caso de hacer un ROLLBACK podemos hacer un ALTER TABLE de la tabla pedidos y volver el auto increment
al numero anterior gracias a que también le dimos permiso para eso. */

-- Puede eliminar un cliente

DELIMITER //
START TRANSACTION;
DELETE FROM clientes
WHERE id = 9;
// DELIMITER ;

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK
-- ROLLBACK;

-- Puede modificar una direccion de envío

DELIMITER //
START TRANSACTION;
UPDATE direcciones_envio
SET localidad = 'Moron'
WHERE id = 8;
// DELIMITER ;

-- Opcion COMMIT
-- COMMIT;

-- Opcion ROLLBACK
-- ROLLBACK;

-- Hacer cualquier tipo de consultas a las tablas y vistas disponibles

SELECT * FROM guitarras;
SELECT * FROM vs_pedidos_clientes WHERE valor > 500000;
SELECT nombre, apellido FROM clientes WHERE id = 4;

-- Puede utilizar las FX disponibles

SELECT fx_calc_ctped_cl(5);