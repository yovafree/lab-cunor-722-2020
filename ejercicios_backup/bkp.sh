#!/bin/bash
#Fecha actual yyyy-MM-dd

NOW_DATE=$(date +%F)

#Hora actual en formato hh:mm:ss

NOW_TIME=$(date +%T)

#Fecha actual con hora

NOW="$NOW_DATE($NOW_TIME)"

MONTH_YEAR=$(date +"%Y%b-")

#Dirección donde se almacenaran las copias

LOCATION=/bkp/$MONTH_YEAR

# Se crea un directorio

mkdir -p $LOCATION

#Usuario de BD
DB_USER_NAME=postgres
#Contraseña de BD
export PGPASSWORD=""
#Nombre de BD
DB_NAME=bd_cunor


FILE_NAME=bd_cunor_$NOW.backup
echo "==================================== Inicio $NOW  ==================================="
echo "#Inicia copia de seguridad......"

pg_dump -U $DB_USER_NAME -h pg_10 -F t $DB_NAME > $LOCATION/$FILE_NAME

echo "====================================  Fin $NOW   ===================================="