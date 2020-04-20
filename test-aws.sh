echo "****** START --> test.sh PWD = " $PWD " - ANSIBLE_CONFIG = " $ANSIBLE_CONFIG
ansible-config view
export ANSIBLE_CONFIG=$PWD/deployment/aws/ansible.cfg
echo "ANSIBLE_CONFIG set to " $ANSIBLE_CONFIG
ansible-config view
ansible-inventory -i deployment/aws/windfire.aws_ec2.yaml --graph
ansible-playbook -i deployment/aws/windfire.aws_ec2.yaml deployment/aws/deploy.yaml
echo "****** END --> test.sh PWD = " $PWD " - ANSIBLE_CONFIG = " $ANSIBLE_CONFIG