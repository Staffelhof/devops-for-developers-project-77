edit-vault:
	ansible-vault edit ansible/group_vars/all/vault.yml
create-vault:
	ansible-vault encrypt ansible/group_vars/all/vault.yml

init:
	cd terraform && terraform init -backend-config=secret.backend.tfvars

i-migrate:
	cd terraform && terraform init -migrate-state -backend-config=secret.backend.tfvars

plan:
	cd terraform && terraform plan

apply:
	cd terraform && terraform apply

destroy:
	cd terraform && terraform destroy

show:
	cd terraform && terraform show

graph:
	cd terraform && terraform graph