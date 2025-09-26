
connect sys/system3@tana_ventas as sysdba

define rutabase = "/proyecto-final-bda/disks/ventas/"
define suffix ="oradata/FREE/tana_ventas"


create tablespace catalogos_tbs
  datafile '&rutabase/d01/&suffix/catalogos_tbs_01.dbf' size 50m
    autoextend on next 10m 
    maxsize 100m
  nologging
  extent management local autoallocate;

create tablespace tarjeta_cliente_tbs
  datafile '&rutabase/d02/&suffix/tarjeta_cliente_01.dbf' size 200m 
    autoextend on next 100m 
    maxsize 500m
  nologging
  extent management local autoallocate;

create tablespace indices_tbs 
  datafile '&rutabase/d03/&suffix/indices_tbs_01.dbf' size 100m
    autoextend on next 50m
    maxsize 500m
  nologging
  default
    index compress advanced high   
  extent management local autoallocate;

create tablespace pagos_tbs
  datafile '&rutabase/d04/&suffix/pagos_tbs_01.dbf' size 300m
    autoextend on next 50m
    maxsize 800m
  nologging
  default
    table compress for oltp
  extent management local autoallocate
  flashback on;

create tablespace ordenes_compra_tbs
  datafile '&rutabase/d05/&suffix/ordenes_compra_tbs_01.dbf' size 100m 
    autoextend on next 50m 
    maxsize 500m
  nologging
  extent management local autoallocate;

create tablespace ubicaciones_tbs
  datafile '&rutabase/d06/&suffix/ubicaciones_tbs_01.dbf' size 100m 
    autoextend on next 10m 
    maxsize 500m
  nologging
  extent management local autoallocate;







