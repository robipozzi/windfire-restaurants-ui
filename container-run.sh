source setenv.sh

echo ${cyn}Removing $CONTAINER_NAME container ...${end}
docker rm -f $CONTAINER_NAME
echo ${cyn}Container removed${end}
echo
echo ${cyn}Running $CONTAINER_NAME container ...${end}
CMD_RUN="docker run -it -p 8080:8080 --name $CONTAINER_NAME $DOCKER_HUB_ID/$CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION"
echo ${cyn}Running Docker container with:${end} ${grn}$CMD_RUN${end}
$CMD_RUN