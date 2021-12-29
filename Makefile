cmd = ansible-playbook -i hosts.ini --ask-become
ifdef TAGS
	cmd :=  $(cmd) --tags $(TAGS)
endif

mac-laptop:
	cue export --force --out=yaml --outfile playbook.yaml mac-laptop.cue
	$(cmd) --limit mac-laptop playbook.yaml

arch-laptop:
	cue export --force --out=yaml --outfile playbook.yaml arch-laptop.cue
	$(cmd) --limit arch-laptop playbook.yaml

k8s:
	cue export --force --out=yaml --outfile playbook.yaml k8s.cue
	$(cmd) --limit k8s playbook.yaml
