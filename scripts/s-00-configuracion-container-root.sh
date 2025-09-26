#!/bin/bash
#@Author          Rodrigo Tapia Navarro
#@Fecha creaciòn  2/12/2024
#@Descripciòn     Script para configurar las variables de entorno y el prompt de sqlplus de un contendor


USER="$(whoami)"
ORACLE_BASE=/opt/oracle
ORACLE_HOME=${ORACLE_BASE}/product/23ai/dbhomeFree

echo $USER

if [ ${USER} != "root" ]; then
  echo "El script debe ejecutarse con el usuario root"
  exit 1
fi

echo "Configurando las variables de entorno"

cd /etc/profile.d

if ! [ -f "99-custom-env.sh" ]; then
  echo "
    export ORACLE_HOSTNAME=d3-bda-rtn.fi.unam
    export ORACLE_BASE=/opt/oracle
    export ORACLE_HOME=${ORACLE_HOME}
    export ORA_INVENTORY=${ORACLE_BASE}/oraInventory
    export ORACLE_SID=free
    export NLS_LANG=American_America.AL32UTF8
    export PATH=$ORACLE_HOME/bin:$PATH
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
    export NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss'

    #aliases 
    alias sqlplus='rlwrap sqlplus'
    alias rman='rlwrap rman'
  " > 99-custom-env.sh

  cat 99-custom-env.sh
fi

echo "Configurando el prompt de sqlplus"

cd ${ORACLE_HOME}/sqlplus/admin

#Para evitar escribir multiples veces las configuraciones a glogin.sql
if ! [ -f "glogin_bkp.sql" ]; then
  cp glogin.sql glogin_bkp.sql
fi
  cp glogin_bkp.sql glogin.sql

if [ -f "glogin_bkp.sql" ]; then
  echo "
    define _edito=nano
      --personalizar el prompt
    define prompt_value=idle
    col prompt_name new_value prompt_value
    col prompt_name noprint
    set heading off
    set termout off
    select lower(sys_context('userenv','current_user')
    ||'@'
    ||sys_context('userenv','db_name'))
    as prompt_name
    from dual;
    set sqlprompt '&prompt_value> '
    set heading on
    set termout on
    col prompt_name print
    set trimspool on
    " >> glogin.sql
  fi

chmod 755 glogin.sql

#AHORA CONFIGURA EL LISTENER 