.PHONY: local

local:
	ansible-playbook playbook.yaml -i localhost
