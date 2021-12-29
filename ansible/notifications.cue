package ansible

#NotificationsTask: #ArchTask & {
	tags: ["notifs"]
}

#notifications: [
	#NotificationsTask & #FetchUserTask & {},
	#NotificationsTask & {
		name: "Install mako"
		aur: {
			name:  "mako"
			state: "present"
		}
	},
	#NotificationsTask & {
		name: "Create mako dir"
		file: {
			path:  "{{ user_var.home }}/.config/mako"
			state: "directory"
		}
	},
	#NotificationsTask & {
		name: "Symlink config file"
		file: {
			src:   "{{ repo_path }}/ansible/files/mako/config"
			dest:  "{{ user_var.home }}/.config/mako/config"
			state: "link"
			force: true
		}
	},
]
