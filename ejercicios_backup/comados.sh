# descargar la imagen de docker de alpine
# docker pull alpine
# docker pull ubuntu

docker run -d --name nginx_bkp --network pr-penso-plantilla-003_default nginx

#Permite ingresar en modo consola al contenedor.
docker exec -it nginx_bkp sh

apt-get install postgresql-client iputils-ping


psql -h pg_10 -U postgres -p 5432 --password

# Se crea el archivo

bkp.sh

# Se dan permisos de ejecución

chmod +x bkp.sh

# Ejecutar el script

sh /bkp/bkp.sh