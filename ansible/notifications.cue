package ansible

#NotificationsTask: #ArchTask & {
	tags: ["notifs"]
}

#notifications: [
	#NotificationsTask & #FetchUserTask & {},
	#i3Task & {
		name: "Install mako"
		aur: {
			name:  "mako"
			state: "present"
		}
	},
	#i3Task & {
		name: "Create mako dir"
		file:
			path: "{{ user_var.home }}/.config/mako state=directory"
	},
	#i3Task & {
		name: "Symlink config file"
		file: {
			src:   "{{ repo_path }}/ansible/files/mako/config"
			dest:  "{{ user_var.home }}/.config/mako/config"
			state: "link"
			force: true
		}
	},
]
