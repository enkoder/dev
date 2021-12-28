package ansible

#DotfilesTask: #GenericTask & {
	tags: ["dotfiles"]
}

#dotfiles: [
	#DotfilesTask & #FetchUserTask & {},
	#DotfilesTask & {
		name: "Print some debug information"
		debug: {
			msg: "{{ repo_path }}/ansible/files/dotfiles"
		}
	},
	#DotfilesTask & {
		name: "Find dotfiles in repo_dir"
		find: {
			paths:     "{{ repo_path }}/ansible/files/dotfiles"
			hidden:    "yes"
			file_type: "file"
		}
		register: "dots"
	},
	#DotfilesTask & {
		name:       "Print some debug information"
		with_items: "{{ dots.files }}"
		debug: msg: "{{ item }}"
	},
	#DotfilesTask & {
		name: "Symlinks all dotfiles"
		file: {
			src:   "{{ item.path }}"
			dest:  "{{ user_var.home }}/{{item.path | basename }}"
			state: "link"
			force: "yes"
			mode:  "{{ item.mode }}"
		}
		with_items: "{{ dots.files }}"
	},
]
