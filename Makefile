pk:
	packer init ./packer
	packer build -var-file='./packer/vars.pkrvars.hcl' ./packer

tfinit:
	terraform -chdir="./terraform" init

tfwrk:
	terraform -chdir="./terraform" workspace new Dev

tfplan:
	terraform -chdir="./terraform" plan -var-file=vars.tfvars -out plan

tfapply:
	terraform -chdir="./terraform" apply plan

tfpland:
	terraform -chdir="./terraform" plan -var-file=vars.tfvars -out plan -destroy

tffmt:
	terraform -chdir="./terraform" fmt

main:
	make pk
	make tffmt
	make tfinit
	make tfplan
	make tfapply

des:
	make tfpland
	make tfapply