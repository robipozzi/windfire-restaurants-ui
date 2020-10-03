source setenv.sh

# ##### START - Variable section
SCRIPT=undeploy.sh
PLATFORM_OPTION=$1
DEPLOY_FUNCTION=
# ##### END - Variable section

# ***** START - Function section
undeployFromRaspberry()
{
	## Undeploy Windfire Restaurants UI component from remote Raspberry box
    echo ${cyn}Undeploy Windfire Restaurants backend component from Raspberry Pi ...${end}
    export ANSIBLE_CONFIG=$PWD/deployment/raspberry/ansible.cfg
    echo ${red}***************** TODO *****************${end}
    #ansible-playbook deployment/raspberry/remove.yaml 
    echo ${cyn}Done${end}
    echo
}

undeployFromAWS()
{
	## Undeploy Windfire Restaurants UI component from AWS
    echo ${cyn}Uneploy Windfire Restaurants UI component from AWS ...${end}
    ANSIBLE_CONFIG_FILE=ansible-aws.cfg
    echo ${red}***************** TODO *****************${end}
    #echo ${cyn}Invoking ansible-config.sh to dynamically create configuration files for Ansible ...${end}
    #deployment/aws/ansible-config.sh $ANSIBLE_CONFIG_FILE
    export ANSIBLE_CONFIG=$PWD/deployment/aws/$ANSIBLE_CONFIG_FILE
    echo
    #ansible-playbook -i deployment/aws/windfire.aws_ec2.yaml deployment/aws/remove.yaml
    echo ${cyn}Done${end}
    echo
}

undeployFromOpenShift()
{
	## Undeploy Windfire Restaurants UI component from Red Hat OpenShift
    echo ${cyn}Undeploy Windfire Restaurants UI component from Red Hat OpenShift ...${end}
    deployment/openshift/undeploy.sh
    echo ${cyn}Done${end}
    echo
}

undeploy()
{
    if [ -z $PLATFORM_OPTION ]; then 
        printSelectPlatform
    fi
    $DEPLOY_FUNCTION
}

printSelectPlatform()
{
	echo ${grn}Select deployment platform : ${end}
    echo "${grn}1. Raspberry${end}"
    echo "${grn}2. AWS${end}"
    echo "${grn}3. OpenShift${end}"
	read PLATFORM_OPTION
	setUnDeployFunction
}

setUnDeployFunction()
{
	case $PLATFORM_OPTION in
		1)  DEPLOY_FUNCTION="undeployFromRaspberry"
			;;
        2)  DEPLOY_FUNCTION="undeployFromAWS"
            ;;
        3)  DEPLOY_FUNCTION="undeployFromOpenShift"
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
    setUnDeployFunction
fi
# ************** END evaluate args **************"
RUN_FUNCTION=undeploy
$RUN_FUNCTION