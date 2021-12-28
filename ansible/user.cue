package ansible

#UserTask: #ArchTask & {
	tags: ["user"]
}

#user: [
	#UserTask & {
		name:   "Create user group"
		become: "yes"
		group: {
			name:  "{{ user.group }}"
			state: "present"
		}
	},
	#UserTask & {
		name:        "Create user and assign to group"
		become:      "yes"
		become_user: "root"
		user: {
			name:            "{{ user.name }}"
			group:           "{{ user.group }}"
			password:        "{{ user_password|password_hash('sha512') }}"
			shell:           "{{ user.shell }}"
			update_password: "on_create"
			uid:             "{{ user.uid }}"
			groups: [ "uucp", "wheel"]
			append: "yes"
		}
	},
	#UserTask & {
		name:   "Create user socket directory"
		become: "yes"
		file: {
			path:  "/run/user/{{ user.uid }}"
			state: "directory"
			owner: "{{ user.name }}"
			group: "{{ user.group }}"
			mode:  0o700
		}
	},
	#UserTask & {
		name:   "Start user systemd instance"
		become: "yes"
		service: {
			name:  "user@{{ user.uid }}"
			state: "started"
		}
		//TODO figure out notifiy
		//notify: "stop systemd per-user instance"
	},
]
