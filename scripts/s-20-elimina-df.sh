#!/bin/bash
#@Author          Rodrigo Tapia Navarro
#@Fecha creaciòn  09/12/2024
#@Descripciòn     Script para


USER=$(whoami)

if [ $USER != 'oracle' ]; then 
  exit 1;
fi

cd /proyecto-final-bda/disks/ventas/d06/oradata/FREE/tana_ventas

rm 