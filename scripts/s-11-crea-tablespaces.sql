--@Author:          Rodrigo Tapia Navarro
--@Fecha creaciòn   09/12/24
--@Descripciòn      script para creaciòn de los tablespaces para ambos mòdulos

connect sys/system3 as sysdba

set verify off

@ventas/s-11-crea-tablespaces-ventas.sql

@subastas/s-11-crea-tablespaces-subastas.sql

set verify on
