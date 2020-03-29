source setenv.sh

removeAngularDistFolder()
{
	## Remove Angular distribution folder
    echo ${cyn}Removing Angular dist folder $ANGULAR_DIST_DIR ...${end}
    rm -rf ../$ANGULAR_DIST_DIR
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
    ansible-playbook deployment/raspberry/deploy.yaml 
    echo ${cyn}Done${end}
    echo
}

deploy()
{
    printSelectPlatform
    removeAngularDistFolder
    buildAngularApp
    $DEPLOY_FUNCTION
	removeAngularDistFolder
}

printSelectPlatform()
{
	echo ${grn}Select deployment platform : ${end}
	echo ${grn}1. Raspberry - with restaurants mockup${end}
    echo ${grn}2. Raspberry${end}
	read PLATFORM_OPTION
	DEPLOY_FUNCTION=
	case $PLATFORM_OPTION in
		1)  DEPLOY_FUNCTION="deployToRaspberry"
            BUILD_OPTIONS="--configuration=mockup"
			;;
        2)  DEPLOY_FUNCTION="deployToRaspberry"
            BUILD_OPTIONS="--configuration=raspberry"
			;;
		*) 	printf "\n${red}No valid option selected${end}\n"
			printSelectPlatform
			;;
	esac
}

###### Main section
RUN_FUNCTION=deploy
$RUN_FUNCTION