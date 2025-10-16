edit-vault:
	ansible-vault edit ansible/group_vars/all/vault.yml
create-vault:
	ansible-vault encrypt ansible/group_vars/all/vault.yml