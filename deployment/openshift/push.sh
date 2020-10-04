source setenv.sh

# ##### START - Variable section
RUN_FUNCTION=
# ##### END - Variable section

# ***** START - Function section
push()
{
    echo ${cyn}Pushing $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION image to Docker Hub...${end}
    docker tag $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION $DOCKER_HUB_ID/$CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
    docker push $DOCKER_HUB_ID/$CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
    echo ${cyn}Container image pushed to Docker Hub${end}
    echo
}
# ***** END - Function section

# ##############################################
# #################### MAIN ####################
# ##############################################
RUN_FUNCTION=push
$RUN_FUNCTION