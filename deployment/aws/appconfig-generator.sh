# ##### START - Variable section
RESTAURANT_SVC_BASEURL=$1
# ##### END - Variable section

# ***** START - Function section
createAngularConfigFile()
{
	## Dynamically create Angular configuration file for the environment
    echo ${cyn}Dynamically create Angular configuration file ...${end}
    cat > $PWD/dist/windfire-restaurants-ui/assets/config/config-aws.json << EOF
{
    "RESTAURANT_SVC_BASEURL": "$RESTAURANT_SVC_BASEURL"
}
EOF
    echo ${cyn}Done${end}
    echo
}
# ***** END - Function section

# ##############################################
# #################### MAIN ####################
# ##############################################
createAngularConfigFile