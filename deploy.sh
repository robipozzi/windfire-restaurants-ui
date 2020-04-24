source setenv.sh

# ##### START - Variable section
SCRIPT=deploy.sh
PLATFORM_OPTION=$1
DEPLOY_FUNCTION=
# ##### END - Variable section

# ***** START - Function section
removeAngularDistFolder()
{
	## Remove Angular distribution folder
    echo ${cyn}Removing Angular dist folder $ANGULAR_DIST_DIR ...${end}
    rm -rf $ANGULAR_DIST_DIR
    echo ${cyn}Angular dist folder removed${end}
}

buildAngularApp()
{
	## Build Angular app for appropriate environment
    echo ${cyn}Building Angular app with the following: ng build $BUILD_OPTIONS ...${end}
    ng build $BUILD_OPTIONS
    echo ${cyn}Angular app built${end}
    echo
}

deployToRaspberry()
{
	## Deploy Angular application to remote Raspberry box
    echo ${cyn}Deploy application to Raspberry Pi ...${end}
    export ANSIBLE_CONFIG=$PWD/deployment/raspberry/ansible.cfg
    ansible-playbook deployment/raspberry/deploy.yaml 
    echo ${cyn}Done${end}
    echo
}

deployToAWS()
{
	## Deploy Angular application to AWS
    echo ${cyn}Deploy application to AWS ...${end}
    ANSIBLE_CONFIG_FILE=ansible-aws.cfg
    echo ${cyn}Invoking ansible-config.sh to dynamically create configuration files for Ansible ...${end}
    deployment/aws/ansible-config.sh $ANSIBLE_CONFIG_FILE
    export ANSIBLE_CONFIG=$PWD/deployment/aws/$ANSIBLE_CONFIG_FILE
    echo
    ansible-playbook -i deployment/aws/windfire.aws_ec2.yaml deployment/aws/deploy.yaml
    echo ${cyn}Done${end}
    echo
}

deploy()
{
    if [ -z $PLATFORM_OPTION ]; then 
        printSelectPlatform
    fi
    removeAngularDistFolder
    buildAngularApp
    $DEPLOY_FUNCTION
	removeAngularDistFolder
}

printSelectPlatform()
{
	echo ${grn}Select deployment platform : ${end}
	echo "${grn}1. Raspberry (with restaurants mockup)${end}"
    echo "${grn}2. Raspberry${end}"
    echo "${grn}3. AWS (with restaurants mockup)${end}"
	read PLATFORM_OPTION
	setDeployFunction
}

setDeployFunction()
{
	case $PLATFORM_OPTION in
		1)  DEPLOY_FUNCTION="deployToRaspberry"
            BUILD_OPTIONS="--configuration=mockup"
			;;
        2)  DEPLOY_FUNCTION="deployToRaspberry"
            BUILD_OPTIONS="--configuration=raspberry"
			;;
        3)  DEPLOY_FUNCTION="deployToAWS"
            BUILD_OPTIONS="--configuration=mockup"
			;;
		*) 	printf "\n${red}No valid option selected${end}\n"
			printSelectPlatform
			;;
	esac
}
# ***** END - Function section

# ##############################################
# #################### MAIN ####################
# ##############################################
# ************ START evaluate args ************"
if [ "$1" != "" ]; then
    setDeployFunction
fi
# ************** END evaluate args **************"
RUN_FUNCTION=deploy
$RUN_FUNCTION