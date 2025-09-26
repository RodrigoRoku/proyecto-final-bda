--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   09/12/24
--@Descripciòn      script para la creacion de los usuarios.

connect sys/system3 as sysdba

create user c##tana_bkp identified by tana_bkp;

grant sysbackup to c##tana_bkpM

connect sys/system3@tana_subastas as sysdba

create user tana_subastas identified by subastas
  quota unlimited on usuarios_tbs
  quota unlimited on catalogos_tbs
  quota unlimited on calificaciones_tbs
  quota unlimited on productos_tbs
  quota unlimited on subastas_tbs
  quota unlimited on historico_producto_tbs
  quota unlimited on indices_tbs
  quota unlimited on fotos_usuario_tbs
  quota unlimited on fotos_producto_tbs
  default tablespace usuarios_tbs;


grant create session, create table, create procedure, create sequence to tana_subastas;

connect sys/system3@tana_ventas as sysdba

create user tana_ventas identified by ventas
  quota unlimited on catalogos_tbs
  quota unlimited on tarjeta_cliente_tbs
  quota unlimited on indices_tbs
  quota unlimited on pagos_tbs
  quota unlimited on ordenes_compra_tbs
  quota unlimited on ubicaciones_tbs
  default tablespace pagos_tbs;

grant create session, create table, create procedure, create sequence to tana_ventas;