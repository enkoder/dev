package ansible

#TerminalTask: #ArchTask & {
	tags: ["terminal"]
}

#terminal: [
	#TerminalTask & #FetchUserTask & {},
	#TerminalTask & {
		name: "Create alacritty dir"
		file: {
			path:  "{{ user_var.home }}/.config/alacritty"
			state: "directory"
		}
	},
	#TerminalTask & {
		name: "Symlink config file"
		file: {
			src:   "{{ repo_path }}/ansible/files/terminal/alacritty.yml"
			dest:  "{{ user_var.home }}/.config/alacritty/alacritty.yml"
			state: "link"
			force: true
		}
	},
]
