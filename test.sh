ansible-inventory -i deployment/aws/windfire.aws_ec2.yaml --graph
ansible-playbook -i deployment/aws/windfire.aws_ec2.yaml deployment/aws/deploy.yaml