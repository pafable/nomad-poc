#!/bin/bash
# ansible needs to be installed before playbooks can be executed!
printf '\n Installing ansible... \n\n'
sudo amazon-linux-extras install epel -y
sudo yum install ansible -y