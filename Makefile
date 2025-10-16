encrypt:
	ansible-vault encrypt terraform/secret.auto.tfvars ansible/group_vars/webservers/secrets.yml --vault-password-file .vault-password

decrypt:
	ansible-vault decrypt terraform/secret.auto.tfvars ansible/group_vars/webservers/secrets.yml --vault-password-file .vault-password

terraform-init:
	terraform init -backend-config=secret.backend.tfvars

terraform-upgrade:
	terraform init -upgrade -backend-config=secret.backend.tfvars

terraform-migrate:
	terraform init -migrate-state -backend-config=secret.backend.tfvars

terraform-plan:
	terraform plan

terraform-apply:
	terraform apply

terraform-destroy:
	terraform destroy

terraform-show:
	terraform show

install-deps:
	ansible-galaxy install -r requirements.yml

deploy:
	ansible-playbook -i inventory.ini playbook.yml

prepare:
	ansible-playbook -i inventory.ini playbook.yml --tags setup

redmine:
	ansible-playbook -i inventory.ini playbook.yml --tags redmine

datadog:
	ansible-playbook -i inventory.ini playbook.yml --tags datadog