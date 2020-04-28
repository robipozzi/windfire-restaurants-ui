source setenv.sh

ENV=$1
RUN_OPTIONS=

run()
{
    # The following command launches Angular application in the appropriate environment
    # It uses the configuration defined in one of the 2 files environment files:
    # - src/environments/environment.ts
    # - src/environments/environment-mockup.ts
	printSelectPlatform
	RUN_CMD="ng serve $RUN_OPTIONS --open"
    echo Running Angular application with the following command: ${cyn}$RUN_CMD${end}
    $RUN_CMD
}

printSelectPlatform()
{
	echo ${grn}Select Angular environment run option : ${end}
	echo ${grn}1. Mockup configuration${end}
    echo ${grn}2. Default configuration${end}
	read PLATFORM_OPTION
	configureRunOptions
}

configureRunOptions()
{
	case $PLATFORM_OPTION in
		1)  RUN_OPTIONS="--configuration=mockup"
			;;
        2)  RUN_OPTIONS=
			;;
		*) 	printf "\n${red}No valid option selected${end}\n"
			printSelectPlatform
			;;
	esac
}

###### Main section
RUN_FUNCTION=run
$RUN_FUNCTION