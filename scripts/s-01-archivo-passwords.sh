#!/bin/bash
#@Author          Rodrigo Tapia Navarro
#@Fecha creaciòn  5/12/2024
#@Descripciòn     Script para creacion del archivo de passwords

USER="$(whoami)"

if [ $USER != "oracle" ]; then
  echo "El script debe de ejecutarse con el usuario ORACLE"
  exit 1;
fi

echo "Creando el archivo de passwords"

orapwd FILE='${ORACLE_HOME}/dbs/orapw${ORACLE_SID}' \
  FORMAT=12.2 \
  SYS=password password="Hola1234*"
