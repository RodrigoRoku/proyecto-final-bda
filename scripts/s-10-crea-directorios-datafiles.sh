#!/bin/bash
#@Author          Rodrigo Tapia Navarro
#@Fecha creaciòn  09/12/2024
#@Descripciòn     Script para creacion de puntos de montaje para los datafiles

set -e
set -o pipefail

export ORACLE_SID=free
pdb_ventas=tana_ventas
pdb_subastas=tana_subastas

USER=$(whoami)

if [ $USER != 'root' ]; then
  echo "El script debe ejecutarse con el usuario root"
  exit 1
fi

cd /proyecto-final-bda/disks || exit

for i in {1..6}
do
    mkdir -p ventas/d0$i/oradata/${ORACLE_SID^^}/${pdb_ventas} 
    chown -R oracle:oinstall ventas/d0$i/
    chmod -R 750 ventas/d0$i/
done;


for i in {1..14}
do
    mkdir -p subastas/d0$i/oradata/${ORACLE_SID^^}/${pdb_subastas} 
    chown -R oracle:oinstall subastas/d0$i/
    chmod -R 750 subastas/d0$i/
done;