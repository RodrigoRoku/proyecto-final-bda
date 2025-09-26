col name format a40
select name, sequence#, is_recovery_dest_file, archived,
  round((blocks*block_size)/1024/1024,2) as size_mb
from v$archived_log;


--consultas redo
-- Inciso C (B)
select group#, sequence#, round(bytes/1024/1024, 2) size_mb, blocksize, members,
  status, first_change#, first_time ,next_change#
from v$log;

prompt Mostrando datos de los miembros de redo logs

col member format a70

--Inciso D
select group#, status, type, member
from v$logfile;



--Algunas consultas para revisar la carga inicial;

-- en modulo de subastas
select count(*) from usuario where usuario_id > 500;
select count(*) from vendedor where usuario_id > 500;
select count(*) from comprador where usuario_id > 500;

select tf.usuario_id , tf.num_telefono from 
telefono_comprador tf
join (
  select usuario_id from
  comprador where usuario_id > 500
) a
on tf.usuario_id = a.usuario_id;


select oferta_id from oferta where oferta_id  > 400;