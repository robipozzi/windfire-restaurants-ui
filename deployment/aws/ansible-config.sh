# ##### START - Variable section
ANSIBLE_CONFIG_FILE=$1
SSH_PRIVATE_KEY_FILE=aws-key.pem
SSH_CONFIG_FILE=ansible-ssh.cfg
BASTION_IP=52.29.176.94
BASTION_HOSTNAME=ec2-52-29-176-94.eu-central-1.compute.amazonaws.com
USER=ec2-user
HOST=10.0.*.*
# ##### END - Variable section

# ***** START - Function section
createAnsibleConfigFile()
{
	## Create Ansible configuration file 
    echo ${cyn}Creating Ansible configuration file  ...${end}
    cat > deployment/aws/$ANSIBLE_CONFIG_FILE << EOF
[defaults]
private_key_file = $HOME/.ssh/$SSH_PRIVATE_KEY_FILE
[inventory]
enable_plugins = auto, yaml, ini
[ssh_connection]
ssh_args = -C -F $PWD/deployment/aws/$SSH_CONFIG_FILE -o ControlMaster=auto -o ControlPersist=30m
control_path = ~/.ssh/ansible-%%r@%%h:%%p
EOF
    echo ${cyn}Done${end}
    echo
}

createSSHConfigFile()
{
	## Create SSH configuration file for Ansible
    echo ${cyn}Creating SSH configuration file for Ansible ...${end}
    cat > deployment/aws/$SSH_CONFIG_FILE << EOF
Host $HOST
ProxyCommand ssh -W %h:%p $USER@$BASTION_IP
IdentityFile ~/.ssh/$SSH_PRIVATE_KEY_FILE

Host $BASTION_IP
Hostname $BASTION_HOSTNAME
User $USER
IdentityFile ~/.ssh/$SSH_PRIVATE_KEY_FILE
ControlMaster auto
ControlPath ~/.ssh/ansible-%r@%h:%p
ControlPersist 5m
EOF
    echo ${cyn}Done${end}
    echo
}

# ##############################################
# #################### MAIN ####################
# ##############################################
createAnsibleConfigFile
createSSHConfigFile