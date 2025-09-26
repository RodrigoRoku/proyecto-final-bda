--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   09/12/24
--@Descripciòn      script para simular la generacion de datos de REDO diaria de la base.


--whenever sqlerror exit rollback

@subastas/s-17-redo-subastas.sql

@ventas/s-17-redo-ventas.sql


-- select factura_id from factura where factura_id > 200;


