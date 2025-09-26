--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   08/12/24
--@Descripciòn      script para crear la base de datos, tiene las configuraciones para activar el modo archived y enviar archivos a la FRA

connect sys/Hola1234* as sysdba

startup nomount

whenever sqlerror exit rollback

create database free
  user sys identified by system3
  user system identified by system3
  logfile group 1 size 50m blocksize 512,
  group 2 size 50m blocksize 512,
  group 3 size 50m blocksize 512
  maxloghistory 1
  maxlogfiles 9
  maxlogmembers 3
  maxdatafiles 1024
  archivelog
  character set AL32UTF8
  national character set AL16UTF16
extent management local
  datafile '/opt/oracle/oradata/FREE/system01.dbf'
    size 500m autoextend on next 10m maxsize unlimited
sysaux datafile '/opt/oracle/oradata/FREE/sysaux01.dbf'
  size 300m autoextend on next 10m maxsize unlimited
default tablespace users
  datafile '/opt/oracle/oradata/FREE/users01.dbf'
    size 50m autoextend on next 10m maxsize unlimited
default temporary tablespace tempts1
  tempfile '/opt/oracle/oradata/FREE/temp01.dbf'
    size 20m autoextend on next 1m maxsize unlimited
undo tablespace undotbs1
  datafile '/opt/oracle/oradata/FREE/undotbs01.dbf'
    size 100m autoextend on next 5m maxsize unlimited
enable pluggable database
  seed
    file_name_convert = ('/opt/oracle/oradata/FREE',
                          '/opt/oracle/oradata/FREE/pdbseed')
system datafiles size 250m autoextend on next 10m maxsize unlimited
sysaux datafiles size 200m autoextend on next 10m maxsize unlimited
local undo on
;

alter user sys identified by system3;
alter user system identified by system3;