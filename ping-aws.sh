source ./setenv.sh

# ##### START - Variable section
SCRIPT=ping-aws.sh
ANSIBLE_CONFIG_FILE=ansible-aws.cfg
# ##### END - Variable section

# ##############################################
# #################### MAIN ####################
# ##############################################
echo "****** START --> $SCRIPT"
echo "PWD = " $PWD
echo "ANSIBLE_CONFIG = " $ANSIBLE_CONFIG
ansible-config view
echo
deployment/aws/ansible-config.sh $ANSIBLE_CONFIG_FILE
export ANSIBLE_CONFIG=$PWD/deployment/aws/$ANSIBLE_CONFIG_FILE
echo "ANSIBLE_CONFIG set to " $ANSIBLE_CONFIG
ansible-config view
echo
echo ${cyn}Getting host inventory from AWS ... ${end} 
ansible-inventory -i deployment/aws/windfire.aws_ec2.yaml --graph
ansible-playbook -i deployment/aws/windfire.aws_ec2.yaml deployment/aws/ping.yaml
echo
echo "PWD = " $PWD
echo "ANSIBLE_CONFIG = " $ANSIBLE_CONFIG
echo "****** END --> $SCRIPT"