#!/bin/bash

cd packer
packer build -var-file='vars.pkrvars.hcl' .

echo "current dir: $(pwd)"
terraform -chdir='../terraform' plan -var-file='vars.tfvars' -out plan 