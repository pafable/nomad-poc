# Build a Nomad POC Environment

## Create AMI for Nomad Server and Client
**Initialization**
```
packer init .
```
**Server**
```
packer build .
```

## Provision Nomad Server and Client Clusters
**Server**
```
terraform plan -var-file=vars.tfvars -out plan'
```
```
terraform apply plan
```

**Destroying Environment**
```
terraform plan -var-file=vars.tfvars -out plan -destroy
```

```
terraform apply plan
```
### TODO
- Create AMI for client
- Create Terraform for client
- Install Docker