# Build a Nomad POC Environment

## Create AMI for Nomad Server and Client

Create a `vars.pkrvars.hcl` in the packer directory and add the following.

```
tags = {
    "Owner" = "<YOUR_NAME>",
    "Name" = "nomad-server-client",
    "Email" = "<YOUR_EMAIL>"
  }
```

**Initialization**

```
packer init .
```

**Server and Client**

```
packer build -var-file='vars.pkrvars.hcl' .
```

## Provision Nomad Server and Client Clusters

**Server and Client**

Create a `vars.tfvars` file in the terraform directory and add the following.

```
owner_id = "<YOUR_AWS_ID>"
key_name = "<YOUR_SSH_KEY_NAME>"

tags = {
  "Owner" : "<YOUR_NAME>",
  "Email" : "<YOUR_EMAIL>"
}
```

**Initialization**

```
terraform init
```

```
terraform plan -var-file='vars.tfvars' -out plan
```

```
terraform apply plan
```

**Destroying Environment**

```
terraform plan -var-file='vars.tfvars' -out plan -destroy
```

```
terraform apply plan
```
