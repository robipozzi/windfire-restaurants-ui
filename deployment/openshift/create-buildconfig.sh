source ../../setenv.sh

# ##### START - Variable section
RUN_FUNCTION=
# ##### END - Variable section

# ***** START - Function section
createBuildConfig()
{
    oc project $OPENSHIFT_PROJECT
    oc create -f $PWD/buildconfig.yaml
    oc set triggers bc/$OPENSHIFT_JENKINS_BUILDCONFIG --from-github
}
# ***** END - Function section

# ##############################################
# #################### MAIN ####################
# ##############################################
RUN_FUNCTION=createBuildConfig
$RUN_FUNCTION