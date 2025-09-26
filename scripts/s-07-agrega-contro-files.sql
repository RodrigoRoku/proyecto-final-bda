--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   08/12/24
--@Descripciòn      script para agregar los control files a los discos fuera de la FRA.

connect sys/system3 as sysdba

shutdown immediate

startup nomount

alter system set control_files='/proyecto-final-bda/disks/fast-reco-area/FREE/controlfile/o1_mf_modolsng_.ctl', '/proyecto-final-bda/disks/disk01/app/oracle/oradata/FREE/control01.ctl', '/proyecto-final-bda/disks/disk02/app/oracle/oradata/FREE/control02.ctl' scope=spfile;

shutdown immediate

startup

set linesize window
col name format a80
select * from v$controlfile;