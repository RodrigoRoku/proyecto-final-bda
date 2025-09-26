--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   08/12/24
--@Descripciòn      script para creaciòn de las PDB de los modulos propuestos

connect sys/system3 as sysdba

create pluggable database tana_ventas
admin user tana_ventas_admin identified by tana_admin
path_prefix = '/opt/oracle/oradata/FREE'
file_name_convert = ('/pdbseed/', '/tana_ventas/');

alter pluggable database tana_ventas open;
alter pluggable database tana_ventas save state;

create pluggable database tana_subastas
admin user tana_subastas_admin identified by tana_admin
path_prefix = '/opt/oracle/oradata/FREE'
file_name_convert = ('/pdbseed/', '/tana_subastas/');

alter pluggable database tana_subastas open;
alter pluggable database tana_subastas save state;


--Crear aliases de servicio despuès de este punto;

