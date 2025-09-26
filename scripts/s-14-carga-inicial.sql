--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   09/12/24
--@Descripciòn      script para poblar las tablas de ambos modulos

whenever sqlerror exit rollback

connect tana_ventas/ventas@tana_ventas

@ventas/carga/banco.sql
@ventas/carga/empresa_paqueteria.sql
@ventas/carga/orden_compra.sql
@ventas/carga/factura.sql
@ventas/carga/tarjeta.sql
@ventas/carga/pago.sql
@ventas/carga/ubicacion_paquete.sql

commit;

connect tana_subastas/subastas@tana_subastas

@subastas/carga/usuario.sql
@subastas/carga/ocupacion.sql
@subastas/carga/comprador.sql
@subastas/carga/vendedor.sql
@subastas/carga/telefono_comprador.sql
@subastas/carga/calificacion_comprador.sql
@subastas/carga/status_producto.sql
@subastas/carga/categoria_producto.sql
@subastas/carga/producto.sql
@subastas/carga/HISTORICO_STATUS_PRODUCTO.sql
@subastas/carga/MULTIMEDIA.sql
@subastas/carga/subasta.sql
@subastas/carga/oferta.sql

commit;