package ansible

#RofiTask: #ArchTask & {
	tags: ["rofi"]
}

#rofi: [
	#RofiTask & #FetchUserTask & {},
	#RofiTask & {
		name:   "Install rofi"
		become: "yes"
		pacman: {
			name:  "rofi"
			state: "present"
		}
	},
	#RofiTask & {
		name: "Make sure config folder exists"
		file: {
			path:  "{{ user_var.home }}/.config/rofi"
			state: "directory"
		}
	},
	#RofiTask & {
		name: "Link rofi config"
		file: {
			src:   "{{item.src}}"
			dest:  "{{ user_var.home }}/.config/rofi/{{ item.path }}"
			force: true
			state: "link"
			mode:  "{{item.mode}}"
		}
		with_filetree: "{{ repo_path }}/ansible/files/rofi/config"
		when:          #ArchTask.when + ["item.state == 'file'"]
	},
	#RofiTask & {
		name: "Make sure theme folder exists"
		file: {
			path:  "{{ user_var.home }}/.local/share/rofi/themes"
			state: "directory"
		}
	},
	#RofiTask & {
		name: "Link rofi themes"
		file: {
			src:   "{{item.src}}"
			dest:  "{{ user_var.home }}/.local/share/rofi/themes/{{ item.path }}"
			force: true
			state: "link"
			mode:  "{{item.mode}}"
		}
		with_filetree: "{{ repo_path }}/ansible/files/rofi/themes"
		when:          #ArchTask.when + ["item.state == 'file'"]
	},
]
