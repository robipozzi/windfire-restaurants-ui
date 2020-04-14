# Windfire Restaurants UI
This repository holds the code for UI of my *Windfire Restaurants* management application, along with scripts, playbooks and configurations to automate application run and deployment to target infrastructures.

## Before you start
The *Windfire Restaurants UI* microservice of the application is developed using Angular technology; to test it locally, you need to install Angular on your workstation, follow the instructions at Angular website (*https://angular.io/guide/setup-local*) to setup Angular and all its prerequisites.

Before starting to use and test the application you also need to ensure all the dependencies for the application are installed, I provided *app-init.sh* script for your convenience, just run it and it will do it for you.

## TODO
The application uses Angular environment customization mechanism to run with different configurations, available in *src/environments* folder.

Script *app-run.sh* is provided to start the application, letting choose which environment configuration is to be applied; currently the 

![](images/app-run.png)

## DevOps automation
The scripts provided are based on Ansible technology (https://www.ansible.com/) for task automation; refer to Ansible technical 
documentation (https://docs.ansible.com/) for detailed instructions regarding installation and setup.

A file, named *ansible.cfg*, is provided to set basic configurations needed to run Ansible; if you launch Ansible from the repo root directory, this file will be read and used as the source for configuration settings (unless you have set an ANSIBLE_CONFIG environment variable, which has precedence), the basic configuration you should have is something like this:

![](images/app-run.png)
where:

* *private_key_file* points to the SSH private key used by Ansible to connect and launch tasks on the target infrastructure;
* *inventory* defines where Ansible will look for the inventory file, which is used by Ansible to know which servers to connect and manage.

Change the parameters according to your environment.

## References
I wrote a more extensive article on how to use Ansible to automate various installation, configuration and application deployment tasks on Raspberry Pi, you can read it at the link here *https://bit.ly/3b13V9h*.