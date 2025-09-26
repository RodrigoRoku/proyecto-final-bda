connect tana_ventas/ventas@tana_ventas

truncate table pago cascade;
truncate table factura cascade;
truncate table ubicacion_paquete cascade;
truncate table orden_compra cascade;
truncate table empresa_paqueteria cascade;
truncate table tarjeta cascade;
truncate table banco;

connect tana_subastas/subastas@tana_subastas

truncate table oferta cascade;

truncate table subasta cascade;

truncate table historico_status_producto cascade;

truncate table multimedia cascade;

truncate table producto cascade;

truncate table categoria_producto cascade;

truncate table status_producto cascade;

truncate table calificacion_comprador cascade;

truncate table vendedor cascade;

truncate table telefono_comprador cascade;

truncate table comprador cascade;

truncate table ocupacion cascade;

truncate table usuario cascade;

