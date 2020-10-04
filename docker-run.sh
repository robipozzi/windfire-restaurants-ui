source setenv.sh

echo ${cyn}Removing $CONTAINER_NAME container ...${end}
docker rm -f $CONTAINER_NAME
echo ${cyn}Container removed${end}
echo
echo ${cyn}Running $CONTAINER_NAME container ...${end}
docker run -it -p 8080:8080 --name $CONTAINER_NAME $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION