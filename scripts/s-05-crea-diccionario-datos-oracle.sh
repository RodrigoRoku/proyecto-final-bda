#!/bin/bash
#@Author          Rodrigo Tapia Navarro
#@Fecha creaciòn  08/12/2024
#@Descripciòn     Script para crear el diccionario de datos

mkdir /tmp/dd-logs
cd /tmp/dd-logs
perl -I $ORACLE_HOME/rdbms/admin \
$ORACLE_HOME/rdbms/admin/catcdb.pl \
--logDirectory /tmp/dd-logs \
--logFilename dd.log \
--logErrorsFilename dderror.log
