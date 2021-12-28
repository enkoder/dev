package ansible

#PolybarTask: #ArchTask & {
	tags: ["polybar"]
}

#polybar: [
	#PolybarTask & #FetchUserTask & {},
	#PolybarTask & {
		name: "Install polybar-git"
		aur: {
			name:  "polybar-git"
			state: "present"
		}
	},
	#PolybarTask & {
		name: "Ensure polybar config dir exists"
		file: {
			path:  "{{ user_var.home }}/.config/polybar"
			state: "directory"
		}
	},
	#PolybarTask & {
		name: "Symlink config files"
		file: {
			src:   "{{item.src}}"
			dest:  "{{ user_var.home }}/.config/polybar/{{item.path}}"
			state: "link"
			force: "yes"
			mode:  "{{item.mode}}"
		}
		with_filetree: "{{ repo_path }}/ansible/polybar/files"
		when:          #ArchTask.when + ["item.state == 'file'"]
	},
]
