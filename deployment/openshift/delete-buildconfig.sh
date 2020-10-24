source ../../setenv.sh

# ##### START - Variable section
RUN_FUNCTION=
# ##### END - Variable section

# ***** START - Function section
deleteBuildConfig()
{
    oc project $OPENSHIFT_PROJECT
    oc delete bc $OPENSHIFT_JENKINS_BUILDCONFIG
}
# ***** END - Function section

# ##############################################
# #################### MAIN ####################
# ##############################################
RUN_FUNCTION=deleteBuildConfig
$RUN_FUNCTION