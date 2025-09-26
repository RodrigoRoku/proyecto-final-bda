--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   09/12/24
--@Descripciòn      script para administraciòn de algunos parametros de la CDB, para modo compartido y pooled

connect sys/system3 as sysdba;


--Paràmetros para el modo compartido
alter system set max_dispatchers=10 scope=both;
alter system set dispatchers='(PROTOCOL = TCP)(DISPATCHERS = 2)' scope=both;

alter system set max_shared_servers=20 scope=both;
alter system set shared_servers=2 scope=both;

--para el modo pooled
exec dbms_connection_pool.start_pool();

exec dbms_connection_pool.alter_param('','MAXSIZE', '30');
exec dbms_connection_pool.alter_param('', 'MINSIZE', '10');

exec dbms_connection_pool.alter_param('', 'INACTIVITY_TIMEOUT','1800');
exec dbms_connection_pool.alter_param('', 'MAX_THINK_TIME', '1800');




