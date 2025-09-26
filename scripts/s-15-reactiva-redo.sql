--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   09/12/24
--@Descripciòn      script para reactivar la generaciòn de datos de REDO tras la carga inicial de datos
connect sys/system3@tana_ventas as sysdba

alter tablespace catalogos_tbs logging;
alter tablespace tarjeta_cliente_tbs logging;
alter tablespace indices_tbs logging;
alter tablespace pagos_tbs logging;
alter tablespace ordenes_compra_tbs logging;
alter tablespace ubicaciones_tbs logging;

connect sys/system3@tana_subastas as sysdba

alter tablespace usuarios_tbs logging;
alter tablespace catalogos_tbs logging;
alter tablespace calificaciones_tbs logging;
alter tablespace productos_tbs logging;
alter tablespace subastas_tbs logging;
alter tablespace historico_producto_tbs logging;
alter tablespace indices_tbs logging;
alter tablespace fotos_usuario_tbs logging;
alter tablespace fotos_producto_tbs logging;
