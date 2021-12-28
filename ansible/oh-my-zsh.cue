package ansible

#OMZTask: #ArchTask & {
	tags: ["oh-my-zsh"]
}

#omz: [
	#OMZTask & #FetchUserTask & {},
	#OMZTask & {
		name:   "Install ZSH"
		become: "yes"
		pacman: {
			name: [ "zsh", "zsh-completions"]
			state: "present"
		}
	},
	#OMZTask & {
		name: "Check if oh-my-zsh was cloned"
		stat: path: "{{ user_var.home }}/.oh-my-zsh"
		register: "ohmyzsh"
	},
	#OMZTask & {
		name: "Clone oh-my-zsh"
		when: #ArchTask.when + ["ohmyzsh.stat.exists == False"]
		git: {
			repo:      "https://github.com/ohmyzsh/ohmyzsh.git"
			dest:      "{{ user_var.home }}/.oh-my-zsh"
			update:    "yes"
			recursive: true
		}
	},
	#OMZTask & {
		name: "Check if zsh-autosuggestions was cloned"
		stat: path: "{{ user_var.home }}/.oh-my-zsh/plugins/zsh-autosuggestions"
		register: "zsha"
	},
	#OMZTask & {
		name: "Clone zsh-autocomplete"
		when: #ArchTask.when + ["ohmyzsh.stat.exists == False"]
		git: {
			repo:      "https://github.com/zsh-users/zsh-autosuggestions"
			dest:      "{{ user_var.home }}/.oh-my-zsh/plugins/zsh-autosuggestions"
			update:    "yes"
			recursive: true
		}
	},
]
