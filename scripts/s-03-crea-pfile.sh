#!/bin/bash
#@Author          Rodrigo Tapia Navarro
#@Fecha creaciòn  6/12/2024
#@Descripciòn     Script para crear el archivo de parametros

export ORACLE_SID=free
OVERWRITE_FLAG="${1}"
BKP_ROUTE="${2}"

USER=$(whoami)

if [ "${USER}" != 'oracle' ]; then
  echo "el script debe ejecutarse con oracle"
  exit 1
fi

pfile=$ORACLE_HOME/dbs/init${ORACLE_SID}.ora
#pfile=/proyecto-final-bda/scripts/test1.sh


function create_spfile(){
  echo \
    "db_name=${ORACLE_SID}
    db_domain=fi.unam
    memory_target=768M
    db_recovery_file_dest_size=5G
    db_recovery_file_dest='/proyecto-final-bda/disks/fast-reco-area'
    db_flashback_retention_target=30
    log_archive_max_processes=2
    log_archive_format='arch_%t_%s_%r.arc'
    log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST MANDATORY'
    log_archive_dest_2='LOCATION=/proyecto-final-bda/archivedlogs01'
    log_archive_dest_3='LOCATION=/proyecto-final-bda/archivedlogs02'
    log_archive_min_succeed_dest=1
    enable_pluggable_database=true
    " > $pfile

    cat ${pfile}

    sqlplus -s sys/Hola1234* as sysdba  << EOF
    create pfile from spfile
EOF

  ls $ORACLE_HOME/dbs/
}

if [ -f "${pfile}" ]; then
  if [[ -n "${OVERWRITE_FLAG}" && "${OVERWRITE_FLAG}" == 'o' ]]; then

    echo "Existe un pfile, el pfile actual se sobreescribira"

    if [ -n "${BKP_ROUTE}" ]; then

      echo "se hara un backup, pero primero se revisa la ruta"
        if ! [ -d "${BKP_ROUTE}" ]; then
          echo "el directorio no existe no se puede hacer backup del pfile anterior, finaliza el programa"
          exit 1
        fi

      cp "${pfile}" $BKP_ROUTE/bkp_pfile.ora
      echo la ruta fue valida, se copia el archivo
    fi
    echo "sobreescribiendo el pfile"
    create_spfile
  fi
else
  echo "No existe un pfile, se creara uno nuevo"
  create_spfile
fi;


echo "fin del script"