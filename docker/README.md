## COMANDOS DOCKER

Contenedores disponibles que están iniciados en docker

```
docker ps [-a = podemos ver todos los contenedores] 
```

Crear un contenedor en modo detach

```
docker run --name [Nombre del contendor] -d -p [Puerto Host:Puerto Contenedor] -v [Volumenes] imagen:tag
```

Iniciar un contenedor
```
docker start [Nombre del contenedor]
```

Detener un contenedor
```
docker stop [Nombre del contenedor]
```

Eliminar un contenedor
```
docker rm [Nombre del contenedor]
```

Descargar una imagen de un contenedor
```
docker pull [nombre_de_contenedor:tag]
```

Eliminar imagen de docker
```
docker rmi [ID Imagen]
```