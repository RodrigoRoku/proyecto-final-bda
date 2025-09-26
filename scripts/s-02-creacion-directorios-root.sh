#!/bin/bash
#@Author          Rodrigo Tapia Navarro
#@Fecha creaciòn  06/12/2024
#@Descripciòn     Script para crear la estructura de directorios.

DELETEFLAG="${1}"

USER=$(whoami)

echo $DELETEFLAG

if [ $USER != 'root' ]; then
  echo "El script debe ejecutarse con el usuario root"
  exit 1
fi

cd /proyecto-final-bda

if [ "${DELETEFLAG}" == 'd' ]; then
  rm -rf disks
fi

mkdir disks

export ORA_DIR=/opt/oracle
#
#directorio para CDB$root
cd "${ORA_DIR}"
mkdir -p oradata/${ORACLE_SID^^}
chown -R oracle:oinstall oradata
chmod -R 750 oradata

#Directorio para PDB$seed
cd /opt/oracle/oradata/${ORACLE_SID^^}
mkdir pdbseed
chown oracle:oinstall pdbseed
chmod 750 pdbseed

#Directorio para los datafiles de los tablespaces adicionales de la PDB
#Para ventas y subastas
cd /proyecto-final-bda/disks

mkdir -p ventas
chown -R oracle:oinstall ventas
chmod -R 750 ventas

mkdir -p subastas 
chown -R oracle:oinstall subastas
chmod  -R 750 subastas

mkdir -p fast-reco-area 
chown -R oracle:oinstall fast-reco-area
chmod  -R 750 fast-reco-area

mkdir -p archivedlogs01 
chown -R oracle:oinstall archivedlogs01
chmod  -R 750 archivedlogs01

mkdir -p archivedlogs02 
chown -R oracle:oinstall archivedlogs02
chmod  -R 750 archivedlogs02

mkdir -p backups/backup01 
mkdir -p backups/backup02
chown -R oracle:oinstall backups/
chmod  -R 750 backups

#Directorios para redo-logs y control files

mkdir -p disk01/app/oracle/oradata/${ORACLE_SID^^}
chown -R oracle:oinstall disk01/app
chmod -R 750 disk01/app

mkdir -p disk02/app/oracle/oradata/${ORACLE_SID^^}
chown -R oracle:oinstall disk02/app
chmod -R 750 disk02/app

mkdir -p disk03/app/oracle/oradata/${ORACLE_SID^^}
chown -R oracle:oinstall disk03/app
chmod -R 750 disk03/app


echo "Creando directorios para discos"







