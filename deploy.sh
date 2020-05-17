source setenv.sh

# ##### START - Variable section
SCRIPT=deploy.sh
PLATFORM_OPTION=$1
AWS_ACCESS_KEY=$2
AWS_SECRET_KEY=$3
DEPLOY_FUNCTION=
BACKEND_INSTANCE_PUBLIC_DNS=
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
    if [ "$AWS_ACCESS_KEY" == "" ]; then
        printInsertAWS_KEY
    fi
    if [ "$AWS_SECRET_KEY" == "" ]; then
        printInsertAWS_SECRET
    fi
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY
	##### Deploy Angular application to AWS
    echo ${cyn}Deploy application to AWS ...${end}
    ## Dynamically create Ansible configuration files for AWS deployment
    ANSIBLE_CONFIG_FILE=ansible-aws.cfg
    echo ${cyn}Invoking ansible-config.sh to dynamically create configuration files for Ansible ...${end}
    deployment/aws/ansible-config.sh $ANSIBLE_CONFIG_FILE $PLATFORM_OPTION
    export ANSIBLE_CONFIG=$PWD/deployment/aws/$ANSIBLE_CONFIG_FILE
    echo
    ## Dynamically create Angular configuration file for AWS deployment
    echo ${cyn}Invoking appconfig-generator.sh to dynamically create Angular configuration file ...${end}
    echo "Backend Host Public DNS = " ${cyn}$BACKEND_INSTANCE_PUBLIC_DNS${end}
    deployment/aws/appconfig-generator.sh $BACKEND_INSTANCE_PUBLIC_DNS
    ## Run Ansible playbook for AWS deployment
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

printInsertAWS_KEY()
{
	echo ${grn}Insert AWS Key : ${end}
	read AWS_ACCESS_KEY
}

printInsertAWS_SECRET()
{
	echo ${grn}Insert AWS Secret : ${end}
	read AWS_SECRET_KEY
}

printSelectPlatform()
{
	echo ${grn}Select deployment platform : ${end}
	echo "${grn}1. Raspberry (with restaurants mockup)${end}"
    echo "${grn}2. Raspberry${end}"
    echo "${grn}3. AWS - Single Zone${end}"
    echo "${grn}4. AWS - Multi Zone${end}"
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
            BUILD_OPTIONS="--prod"
			;;
        3)  DEPLOY_FUNCTION="deployToAWS"
            BUILD_OPTIONS="--prod"
            BACKEND_INSTANCE_PUBLIC_DNS=$(terraform output -state=../windfire-restaurants-devops/aws/SingleZone/terraform.tfstate backend-public_dns)
            ;;
        4)  DEPLOY_FUNCTION="deployToAWS"
            BUILD_OPTIONS="--prod"
            BACKEND_INSTANCE_PUBLIC_DNS=$(terraform output -state=../windfire-restaurants-devops/aws/MultiZone/terraform.tfstate alb-public_dns)
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