cd /etc/profile.d

PARAM1="${1}"
ORACLE_BASE=/opt/oracle
ORACLE_HOME=${ORACLE_BASE}/product/23ai/dbhomeFree

if ! [ -f "99-custom-env.sh" ]; then
  echo "El archivo no existe"
  ls
  exit 1
fi

cd /proyecto-final-bda/scripts

# if [[ -n "${PARAM1}" && "${PARAM1}" == 'yes' ]]; then
#   echo "el parametro 1 no es nulo y es yes"
# else 
#   echo "el parametro 1 es nulo o no ES YES"
# fi

for i in {1..5}
do
    mkdir -p d0$i
    chown oracle:oinstall d0$i
    chmod 755 d0$i
done;