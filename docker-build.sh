source setenv.sh

rm -rf $ANGULAR_DIST_DIR
echo ${cyn}Building Angular app ...${end}
ng build --prod
echo ${cyn}Angular app built${end}
echo
echo ${cyn}Removing Docker image ...${end}
docker rmi -f $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION
echo ${cyn}Docker image removed${end}
echo
echo ${cyn}Building Docker image ...${end}
docker build -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION .
echo ${cyn}Docker image built${end}
echo
echo ${cyn}Pushing Docker image to Docker Hub...${end}
docker tag $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION $DOCKER_HUB_ID/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION
docker push $DOCKER_HUB_ID/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION
echo ${cyn}Docker image pushed${end}
echo
rm -rf $ANGULAR_DIST_DIR