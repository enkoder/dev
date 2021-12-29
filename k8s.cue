import "github.com/enkoder/dev/ansible"

#User: {
	uid:        1000
	name:       "enkoder"
	group:      "enkoder"
	shell:      "/usr/bin/zsh"
	email:      "kodiegoodwin@gmail.com"
	github:     "enkoder"
	first_name: "Kodie"
	last_name:  "Goodwin"
}

[ansible.#Playbook & {
	hosts: "k8s"
	tasks: ansible.#user + ansible.#sudo + ansible.#pacman + ansible.#onepass
	vars_prompt: [
		{name: "user_password", prompt: "Enter desired user password"},
	]
	handlers: [
		ansible.#ReloadSystemdHandler,
		ansible.#ReloadUserSystemdHandler,
		ansible.#RestartPaccacheHandler,
		ansible.#StopSystemdUserHandler,
	]
	vars: {
		base_packages: [
			// base stuff
			"base", "ntp", "man-db", "man-pages", "pacman-contrib", "wmname", "inetutils", "openssh",
			// dev things
			"vi", "neovim", "docker", "python-pip", "tmux", "git", "rsync", "jq", "screen", "tree", "unzip", "htop",
		]
		repo_path:  "/home/enkoder/github.com/enkoder/dev"
		user:       #User
		op_version: "1.12.3"
	}
}]
