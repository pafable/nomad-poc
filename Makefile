pk:
	cd packer
	packer init .
	packer build -var-file='vars.pkrvars.hcl' .

tfwrk:
	terraform -chdir="./terraform" workspace new Dev

tfinit:
	terraform -chdir="./terraform" init

tfplan:
	terraform -chdir="./terraform" plan -var-file=vars.tfvars -out plan

tfapply:
	terraform -chdir="./terraform" apply plan

tfpland:
	terraform -chdir="./terraform" plan -var-file=vars.tfvars -out plan -destroy

tffmt:
	terraform -chdir="./terraform" fmt
