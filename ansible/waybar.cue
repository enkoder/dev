package ansible

#WaybarTask: #ArchTask & {
	tags: ["waybar"]
}

#waybar: [
	#WaybarTask & #FetchUserTask & {},
	#WaybarTask & {
		name: "Create waybar dir"
		file: {
			path:  "{{ user_var.home }}/.config/waybar"
			state: "directory"
		}
	},
	#WaybarTask & {
		name: "Symlink config file"
		file: {
			src:   "{{ repo_path }}/ansible/files/waybar/config"
			dest:  "{{ user_var.home }}/.config/waybar/config"
			state: "link"
			force: true
		}
	},
	#WaybarTask & {
		name: "Symlink styles"
		file: {
			src:   "{{ repo_path }}/ansible/files/waybar/styles.css"
			dest:  "{{ user_var.home }}/.config/waybar/style.css"
			state: "link"
			force: true
		}
	},
]
