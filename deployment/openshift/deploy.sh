source setenv.sh

# ##### START - Variable section
RUN_FUNCTION=
# ##### END - Variable section

# ***** START - Function section
deploy()
{
    echo ${red}***************** TODO *****************${end}
    oc new-project $OPENSHIFT_PROJECT
    oc project $OPENSHIFT_PROJECT
    #oc new-app --name $OPENSHIFT_APP_LABEL https://github.com/robipozzi/windfire-restaurants-ui --strategy=source
    #oc new-app --name $OPENSHIFT_APP_LABEL docker.io/robipozzi/windfire-restaurants-ui:1.0
    oc new-app --name $OPENSHIFT_APP_LABEL -i nginx https://github.com/robipozzi/windfire-restaurants-ui
    #oc patch svc OPENSHIFT_APP_LABEL --type=json -p '[{"op": "replace", "path": "/spec/ports/0/targetPort", "value":8082}]'
    oc expose svc $OPENSHIFT_APP_LABEL
    #oc new-app -f $PWD/deployment/openshift/windfire-restaurants-template.yaml
    ROUTE_URL=$(oc get route windfire-restaurants-ui -o jsonpath='{.spec.host}')
    echo Test it at ${grn}$ROUTE_URL${end}
}
# ***** END - Function section

# ##############################################
# #################### MAIN ####################
# ##############################################
RUN_FUNCTION=deploy
$RUN_FUNCTION