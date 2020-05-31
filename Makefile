.PHONY: local-ask

local-ask:
	ansible-playbook --ask-become-pass playbook.yaml -i localhost

local:
	ansible-playbook playbook.yaml -i localhost
