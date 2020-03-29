source setenv.sh

echo ${cyn}Removing $DOCKER_CONTAINER_NAME Docker container ...${end}
docker rm -f $DOCKER_CONTAINER_NAME
echo ${cyn}Docker container removed${end}
echo
echo ${cyn}Running Docker container ...${end}
docker run -it -p 8080:80 --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION