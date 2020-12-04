source setenv.sh

rm -rf $ANGULAR_DIST_DIR
echo ${cyn}Building Angular app ...${end}
ng build --prod
echo ${cyn}Angular app built${end}
echo
echo ${cyn}Removing $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION image ...${end}
docker rmi -f $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
echo ${cyn}Container image removed${end}
echo
echo ${cyn}Removing $DOCKER_HUB_ID/$CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION image ...${end}
docker rmi -f $DOCKER_HUB_ID/$CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
echo ${cyn}Container image removed${end}
echo
echo
echo ${cyn}Building $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION image ...${end}
docker build -t $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION .
echo ${cyn}Container image built${end}
echo
echo ${cyn}Pushing $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION image to Docker Hub...${end}
docker tag $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION $DOCKER_HUB_ID/$CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
echo
echo ${cyn}Removing $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION image ...${end}
docker rmi -f $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
echo ${cyn}Container image removed${end}
echo
docker push $DOCKER_HUB_ID/$CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
echo ${cyn}Container image pushed to Docker Hub${end}
echo
rm -rf $ANGULAR_DIST_DIR