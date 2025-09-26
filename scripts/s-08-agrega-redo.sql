--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   08/12/24
--@Descripciòn      script para aagragar los miembros faltantes de los grupos de redo.
connect sys/system3 as sysdba

set linesize window;


prompt Mostrando grupos de redo logs

define ruta1 = "/proyecto-final-bda/disks/disk01/app/oracle/oradata/FREE"
define ruta2 = "/proyecto-final-bda/disks/disk02/app/oracle/oradata/FREE"


prompt creando nuevos grupos de redo con dos miembros

alter database
  add logfile member '&ruta1/redo01b.log', '&ruta2/redo01c.log'  to group 1;

alter database
  add logfile member '&ruta1/redo02b.log', '&ruta2/redo02c.log'  to group 2;

alter database
  add logfile member '&ruta1/redo03b.log', '&ruta2/redo03c.log' to group 3;

select group#, members,
   round(bytes/1024/1024,2) as size_mb ,status 
from v$log;