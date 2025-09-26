connect sys/system3@tana_subastas as sysdba

define rutabase = "/proyecto-final-bda/disks/subastas"
define suffix ="oradata/FREE/tana_subastas"

create smallfile tablespace usuarios_tbs
  datafile '&rutabase/d01/&suffix/usuarios_tbs_01.dbf' size 100m
    autoextend on next 50m 
    maxsize 300m,
  '&rutabase/d02/&suffix/usuarios_tbs_02.dbf' size 100m
      autoextend on next 50m 
      maxsize 300m,
  '&rutabase/d03/&suffix/usuarios_tbs_03.dbf' size 100m
    autoextend on next 50m 
    maxsize 300m
  nologging
  extent management local autoallocate;
 
create tablespace catalogos_tbs
  datafile '&rutabase/d04/&suffix/catalogos_tbs_01.dbf' size 50m
    autoextend on next 10m 
    maxsize 100m
  nologging
  extent management local autoallocate;

create tablespace calificaciones_tbs 
  datafile '&rutabase/d05/&suffix/calificaciones_tbs_01.dbf' size 200m
    autoextend on next 50m 
    maxsize 400m,
  '&rutabase/d06/&suffix/calificaciones_tbs_02.dbf' size 200m
    autoextend on next 50m 
    maxsize 400m
  nologging
  extent management local autoallocate;

create tablespace productos_tbs
    datafile '&rutabase/d07/&suffix/productos_tbs_01.dbf' size 300m
    autoextend on next 100m 
    maxsize 600m
  nologging
  extent management local autoallocate;

create tablespace subastas_tbs
    datafile '&rutabase/d08/&suffix/subastas_tbs_01.dbf' size 100m
    autoextend on next 100m 
    maxsize 600m
  nologging
  extent management local autoallocate;

create tablespace historico_producto_tbs 
  datafile '&rutabase/d09/&suffix/historico_producto_tbs_01.dbf' size 100m
    autoextend on next 50m 
    maxsize 300m,
  '&rutabase/d010/&suffix/historico_producto_tbs_02.dbf' size 100m
    autoextend on next 50m 
    maxsize 300m
  nologging
  extent management local autoallocate;

create tablespace indices_tbs 
  datafile '&rutabase/d011/&suffix/indices_tbs_01.dbf' size 100m
    autoextend on next 50m 
    maxsize 500m
  nologging
  extent management local autoallocate;


create bigfile tablespace fotos_usuario_tbs
  datafile '&rutabase/d012/&suffix/fotos_usuario_tbs_01.dbf' size 100m
    autoextend on next 100m 
    maxsize 3g
  nologging
  default
    table compress for oltp
  extent management local autoallocate;

create tablespace fotos_producto_tbs
  datafile '&rutabase/d013/&suffix/fotos_producto_tbs_01.dbf' size 100m
    autoextend on next 100m 
    maxsize 1500m ,
  '&rutabase/d014/&suffix/fotos_producto_tbs_02.dbf' size 100m
    autoextend on next 100m 
    maxsize 1500m 
  nologging
  default
    table compress for oltp
  extent management local autoallocate;