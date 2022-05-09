USE mysql;

-- Script para chequear los usuarios
SELECT * FROM USER;

-- Generacion de usuario de ventas de la fabrica
CREATE USER 'ventasfabrica'@'localhost' IDENTIFIED BY '123456';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla pedidos, tambien
le damos permiso de ALTER para que si tiene un error pueda volver el auto increment al numero anterior. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.pedidos TO 'ventasfabrica'@'localhost';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla pedidos_detalle, tambien
le damos permiso de ALTER para que si tiene un error pueda volver el auto increment al numero anterior. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.pedidos_detalle TO 'ventasfabrica'@'localhost';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla clientes, tambien
le damos permiso de ALTER para que si tiene un error pueda volver el auto increment al numero anterior. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.clientes TO 'ventasfabrica'@'localhost';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla direcciones_envio, tambien
le damos permiso de ALTER para que si tiene un error pueda volver el auto increment al numero anterior. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.direcciones_envio TO 'ventasfabrica'@'localhost';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla movimientos_pedidos,
esto es necesario ya que si por ejemplo ingresara un pedido mal y quisiera hacer un ROLLBACK no podría porque también
estaría eliminando el registro guardado de la tabla de movimientos. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.movimientos_pedidos TO 'ventasfabrica'@'localhost';

-- Le damos permiso para que pueda ver registros de la tabla guitarras
GRANT SELECT ON fabrica_guitarras.guitarras TO 'ventasfabrica'@'localhost';

-- Le damos permiso para que pueda hacer consultas a esta vista que nos facilita datos de pedidos
GRANT SELECT ON fabrica_guitarras.vs_pedidos_clientes TO 'ventasfabrica'@'localhost';

-- Le damos permiso para que pueda usar algunas FX que le van a facilitar tareas
GRANT EXECUTE ON FUNCTION fabrica_guitarras.fx_calc_ctdi_ultped TO 'ventasfabrica'@'localhost';
GRANT EXECUTE ON FUNCTION fabrica_guitarras.fx_calc_ctped_cl TO 'ventasfabrica'@'localhost';
GRANT EXECUTE ON FUNCTION fabrica_guitarras.fx_calc_ctped_xfech TO 'ventasfabrica'@'localhost';

-- Le damos permiso para que pueda usar algunos SP que le van a facilitar tareas
GRANT EXECUTE ON PROCEDURE fabrica_guitarras.sp_eliminar_pedido TO 'ventasfabrica'@'localhost';
GRANT EXECUTE ON PROCEDURE fabrica_guitarras.sp_ingresar_cliente TO 'ventasfabrica'@'localhost';
GRANT EXECUTE ON PROCEDURE fabrica_guitarras.sp_ingresar_detalle_pedido TO 'ventasfabrica'@'localhost';
GRANT EXECUTE ON PROCEDURE fabrica_guitarras.sp_orden_guitarras TO 'ventasfabrica'@'localhost';


-- Generacion de usuario de produccion de la fabrica
CREATE USER 'produccionfabrica'@'localhost' IDENTIFIED BY '234567';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla proveedores, tambien
le damos permiso de ALTER para que si tiene un error pueda volver el auto increment al numero anterior. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.proveedores TO 'produccionfabrica'@'localhost';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla proveedores_materiales, 
tambien le damos permiso de ALTER para que si tiene un error pueda volver el auto increment al numero anterior. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.proveedores_materiales TO 'produccionfabrica'@'localhost';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla materiales, tambien
le damos permiso de ALTER para que si tiene un error pueda volver el auto increment al numero anterior. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.materiales TO 'produccionfabrica'@'localhost';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla materiales_guitarras, 
tambien le damos permiso de ALTER para que si tiene un error pueda volver el auto increment al numero anterior. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.materiales_guitarras TO 'produccionfabrica'@'localhost';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla guitarras, tambien
le damos permiso de ALTER para que si tiene un error pueda volver el auto increment al numero anterior. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.guitarras TO 'produccionfabrica'@'localhost';

/* Le damos permiso para que pueda ver, insertar, actualizar y borrar registros de la tabla movimientos_materiales,
esto es necesario ya que si por ejemplo ingresara un material mal y quisiera hacer un ROLLBACK no podría porque también
estaría eliminando el registro guardado de la tabla de movimientos. */
GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON fabrica_guitarras.movimientos_materiales TO 'produccionfabrica'@'localhost';

-- Le damos permiso para que pueda hacer consultas a estas vistas que nos facilitan algunos datos
GRANT SELECT ON fabrica_guitarras.vs_costo_guitarras TO 'produccionfabrica'@'localhost';
GRANT SELECT ON fabrica_guitarras.vs_material_p_guitarra TO 'produccionfabrica'@'localhost';
GRANT SELECT ON fabrica_guitarras.vs_stock_bajo_guitarras TO 'produccionfabrica'@'localhost';
GRANT SELECT ON fabrica_guitarras.vs_stock_bajo_materiales TO 'produccionfabrica'@'localhost';

-- Le damos permiso para que pueda usar algunas FX que le van a facilitar tareas
GRANT EXECUTE ON FUNCTION fabrica_guitarras.fx_calc_cst_guit TO 'produccionfabrica'@'localhost';

-- Le damos permiso para que pueda usar algunos SP que le van a facilitar tareas
GRANT EXECUTE ON PROCEDURE fabrica_guitarras.sp_actcosto_mat TO 'produccionfabrica'@'localhost';
GRANT EXECUTE ON PROCEDURE fabrica_guitarras.sp_actstock_guitarra TO 'produccionfabrica'@'localhost';
GRANT EXECUTE ON PROCEDURE fabrica_guitarras.sp_ingresar_materiales_guitarras TO 'produccionfabrica'@'localhost';

