source setenv.sh

# ##### START - Variable section
RUN_FUNCTION=
# ##### END - Variable section

# ***** START - Function section
undeploy()
{
    oc project $OPENSHIFT_PROJECT
    oc delete all -l app=$OPENSHIFT_APP_LABEL
}
# ***** END - Function section

# ##############################################
# #################### MAIN ####################
# ##############################################
RUN_FUNCTION=undeploy
$RUN_FUNCTION