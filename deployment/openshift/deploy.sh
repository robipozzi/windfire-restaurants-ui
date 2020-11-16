source setenv.sh

# ##### START - Variable section
RUN_FUNCTION=
# ##### END - Variable section

# ***** START - Function section
deploy()
{
    echo $PWD
    oc new-project $OPENSHIFT_PROJECT
    oc project $OPENSHIFT_PROJECT
    oc create configmap $OPENSHIFT_APP_LABEL-config --from-file=$PWD/deployment/openshift/config/config.json
    oc new-app --name $OPENSHIFT_APP_LABEL docker.io/robipozzi/windfire-restaurants-ui:1.0
    oc set volume dc/$OPENSHIFT_APP_LABEL --name $OPENSHIFT_APP_LABEL-volume --add --type=configmap --configmap-name=$OPENSHIFT_APP_LABEL-config --mount-path=/usr/share/nginx/html/assets/config --overwrite
    oc expose svc $OPENSHIFT_APP_LABEL
    oc patch route $OPENSHIFT_APP_LABEL --type=json -p '[{"op": "replace", "path": "/spec/port/targetPort", "value":8080-tcp}]'
    ROUTE_URL=$(oc get route windfire-restaurants-ui -o jsonpath='{.spec.host}')
    echo Test it at ${grn}$ROUTE_URL${end}
}
# ***** END - Function section

# ##############################################
# #################### MAIN ####################
# ##############################################
RUN_FUNCTION=deploy
$RUN_FUNCTION