# Build a Nomad POC Environment

## Create AMI for Nomad Server and Client
Server
```
packer build nomad-server-ami.pkr.hcl
```

## Provision Nomad Server and Client Clusters
Server
```
terraform plan -var='key_name=<YOUR-KEY> -var='sg=<SECURITY-GROUP> -out plan'
```
```
terraform apply plan
```

## TODO
- Create AMI for client
- Create Terraform for client