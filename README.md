# Windfire Restaurants UI
This repository holds the code for UI of my *Windfire Restaurants* management application, along with scripts, playbooks and configurations to automate application run and deployment to target infrastructures.

## Before you start
The *Windfire Restaurants UI* microservice of the application is developed using Angular technology; to test it locally, you need to install Angular on your workstation, follow the instructions at Angular website (*https://angular.io/guide/setup-local*) to setup Angular and all its prerequisites.

Before starting to use and test the application you also need to ensure all the dependencies for the application are installed, I provided *app-init.sh* script for your convenience, just run it and it will do it for you.

## Run the application
The application uses Angular environment customization mechanism to run with different configurations, defined as files (with *.ts* extension) available in *src/environments* folder.

Script *app-run.sh* is provided to start the application, letting choose which environment configuration is to be applied; currently the script exposes 2 options:

![](images/app-run.png)

As it can be seen in the figure above, options are the following:
* *Mockup configuration* uses environment configuration defined in *src/environment/environment.mockup.ts*, which basically mocks the Restaurant Service, returning a fixed restaurant list. No other microservices are actually invoked;
* *Default configuration* uses standard environment configuration defined in *src/environment/environment.ts*, which points to another microservice endpoint, to which restaurant list retrieval is delegated.

## DevOps automation
Automation is based on Ansible technology (https://www.ansible.com/): refer to Ansible technical documentation (https://docs.ansible.com/) for detailed instructions regarding installation and setup.

A file, named *ansible.cfg*, is provided to set basic configurations needed to run Ansible; if you launch Ansible from the repo root directory, this file will be read and used as the source for configuration settings (unless you have set an ANSIBLE_CONFIG environment variable, which has precedence), the basic configuration you should have is something like this:

![](images/ansible-config.png)
where:

* *private_key_file* points to the SSH private key used by Ansible to connect and launch tasks on the target infrastructure;
* *inventory* defines where Ansible will look for the inventory file, which is used by Ansible to know which servers to connect and manage.

Change the parameters according to your environment.

Finally, script *deploy.sh* is also provided to run deployment automation tasks. 

![](images/deploy.png)

As it can be seen in the figure above, the script currently exposes 2 deployment options:
* *Raspberry (with restaurants mockup)* : it automates deployment to a Raspberry Pi, enabling application with the mockup configuration (as defined in *src/environment/environment.mockup.ts*)
* *Raspberry* : it automates deployment to a Raspberry Pi, enabling application with the default configuration (as defined in *src/environment/environment.ts*)
* *AWS (with restaurants mockup)* : it automates deployment to AWS, enabling application with the mockup configuration (as defined in *src/environment/environment.mockup.ts*)

As said before, the script wraps Ansible to automate deployment tasks, using the Ansible playbook *deployment/deploy.yaml*.

### Raspberry deployment architecture
Both Raspberry options assume Apache2 as web server target for deployment and are based on the following High level architecture:

![](images/Raspberry-architecture-single-server.png)

You can refer to my article *https://bit.ly/3b13V9h* on Medium and to my other GitHub repository *https://github.com/robipozzi/windfire-raspberry.git* for instructions and code to setup Apache2 on Raspberry Pi.

### AWS architecture
AWS target deployment environment is based on the following Architecture

![](images/AWS-robipozzi_windfire-restaurants.png)


More deployment environment options will be added in the future.

## References
I wrote some more extensive articles on how to install and configure software on Raspberry Pi, which can be useful:
* Use Ansible to automate infrastructure installation, configuration and application deployment on Raspberry Pi : *https://bit.ly/3b13V9h*;
* Install Apache2 on Raspberry Pi : https://bit.ly/2xvuIf4
* Secure Raspberry Pi with self signed SSL certificates : https://bit.ly/3b8ujhs