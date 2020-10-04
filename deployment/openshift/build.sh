source setenv.sh

# ##### START - Variable section
RUN_FUNCTION=
# ##### END - Variable section

# ***** START - Function section
build()
{
    echo ${cyn}Removing $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION image ...${end}
    docker rmi -f $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
    echo ${cyn}Container image removed${end}
    echo
    echo ${cyn}Building $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION image ...${end}
    docker build -t $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION .
    echo ${cyn}Container image built${end}
    echo
}
# ***** END - Function section

# ##############################################
# #################### MAIN ####################
# ##############################################
RUN_FUNCTION=build
$RUN_FUNCTION