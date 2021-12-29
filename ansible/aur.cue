package ansible

#AURTask: #ArchTask & {
	tags: ["aur"]
}

#aur: [
	#AURTask & #FetchUserTask & {},
	#AURTask & {
		name: "Create AUR directory"
		file: {
			path:  "{{ user_var.home }}/{{ aur.dir }}"
			state: "directory"
			owner: "{{ user.name }}"
			group: "{{ user.group }}"
		}
	},
	#AURTask & {
		name: "Check if yay was cloned"
		stat: path: "{{ user_var.home }}/github.com/yay"
		register: "yay_git"
	},
	#AURTask & {
		name:          "Check is yay installed"
		shell:         "command -v yay >/dev/null 2>&1"
		register:      "yay"
		ignore_errors: "yes"
	},
	#AURTask & {
		name:        "Clone yay"
		when:        #AURTask.when + ["yay_git.stat.exists == False"]
		become:      "yes"
		become_user: "{{ user.name }}"
		git: {
			repo: "https://aur.archlinux.org/yay.git"
			dest: "{{ user_var.home }}/github.com/yay"
		}
	},
	#AURTask & {
		name: "Install yay deps"
		pacman: {
			name:  "go"
			state: "present"
		}
	},
	#AURTask & {
		name:        "Install yay"
		become:      "yes"
		become_user: "{{ user.name }}"
		//when:        #AURTask.when + ["yay.rc != 0"]
		shell: {
			cmd:   "makepkg -i -f --noconfirm"
			chdir: "{{ user_var.home }}/github.com/yay"
		}
	},
	#AURTask & {
		name:        "Upgrade aur"
		become:      "yes"
		become_user: "{{ user.name }}"
		aur: {
			upgrade:  "yes"
			aur_only: "yes"
		}
	},
	#AURTask & {
		name:        "Install AUR base packages"
		become:      "yes"
		become_user: "{{ user.name }}"
		aur: {
			name:  "{{ aur.packages }}"
			state: "present"
		}
	},
]
