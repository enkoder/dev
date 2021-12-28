import "github.com/enkoder/dev/ansible"

#User: {
	uid:        1000
	name:       "kodiegoodwin"
	group:      "enkoder"
	shell:      "/usr/bin/zsh"
	email:      "kodiegoodwin@gmail.com"
	github:     "enkoder"
	first_name: "Kodie"
	last_name:  "Goodwin"
}

[ansible.#Playbook & {
	hosts: "mac-laptop"
	tasks: ansible.#dotfiles + ansible.#brew + ansible.#repo + ansible.#ssh + ansible.#docker + ansible.#omz
	vars: {
		brew_packages: ["htop"]
		repo_path: "/Users/kodiegoodwin/github.com/enkoder/dev"
		user:      #User
	}
}]
