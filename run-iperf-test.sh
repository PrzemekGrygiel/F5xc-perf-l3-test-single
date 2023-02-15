#!/bin/bash
JUMPHOST=$(terraform output --raw pg-vpc2-jump-public-ip)
WORKLOAD=$(terraform output --raw pg-vpc2-vm1-Private-IP)
ssh -o "StrictHostKeyChecking=no" -o ProxyCommand="ssh -o "StrictHostKeyChecking=no" -i ~/Documents/keys/aws/przemek-oregon.pem -W %h:%p ubuntu@$JUMPHOST" -i ~/Documents/keys/aws/przemek-oregon.pem ubuntu@$WORKLOAD iperf3 -s -D
JUMPHOST=$(terraform output --raw pg-vpc1-jump-public-ip)
CLIENT1=$(terraform output --raw pg-vpc2-vm1-Private-IP)

ssh -o "StrictHostKeyChecking=no" -o ProxyCommand="ssh -o "StrictHostKeyChecking=no" -i ~/Documents/keys/aws/przemek-oregon.pem -W %h:%p ubuntu@$JUMPHOST" -i ~/Documents/keys/aws/przemek-oregon.pem ubuntu@$WORKLOAD iperf3 -c 10.131.1.100 -P 64 -t 30

