
connect sys/system3@tana_ventas as sysdba

drop tablespace if exists catalogos_tbs including contents and datafiles;

drop tablespace if exists tarjeta_cliente_tbs including contents and datafiles;

drop tablespace if exists indices_tbs including contents and datafiles;

drop tablespace if exists pagos_tbs including contents and datafiles;

drop tablespace if exists ordenes_compra_tbs including contents and datafiles;

drop tablespace if exists ubicaciones_tbs including contents and datafiles;

connect sys/system3@tana_subastas as sysdba

drop tablespace if exists usuarios_tbs including contents and datafiles;

drop tablespace if exists catalogos_tbs including contents and datafiles;

drop tablespace if exists calificaciones_tbs including contents and datafiles;

drop tablespace if exists productos_tbs including contents and datafiles;

drop tablespace if exists subastas_tbs including contents and datafiles;

drop tablespace if exists historico_producto_tbs including contents and datafiles;

drop tablespace if exists indices_tbs including contents and datafiles;

drop tablespace if exists fotos_usuario_tbs including contents and datafiles;

drop tablespace if exists fotos_producto_tbs including contents and datafiles;
