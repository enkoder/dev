package ansible

#SwayTask: #ArchTask & {
	tags: ["sway"]
}

#sway: [
	#SwayTask & #FetchUserTask & {},
	#SwayTask & {
		name: "Install sway"
		aur: {
			name: ["swaynagmode", "bemenu-wlroots"]
		}
	},
	#SwayTask & {
		name:   "Install screen lock deps"
		become: "yes"
		pacman: {
			state: "present"
			name: [
				"sway",
				"wlroots",
				"grim",
				"slurp",
				"imagemagick",
			]
		}
	},
	#SwayTask & {
		name:   "Move lock script"
		become: "yes"
		file: {
			src:   "{{ repo_path }}/ansible/files/sway/lock"
			dest:  "/bin/lock"
			force: true
			state: "link"
		}
	},
	#SwayTask & {
		name: "Make sway config dir"
		file: {
			path:  "{{ user_var.home }}/.config/sway"
			state: "directory"
		}
	},
	#SwayTask & {
		name: "Symlink config file"
		file: {
			src:   "{{ repo_path }}/ansible/files/sway/config"
			dest:  "{{ user_var.home }}/.config/sway/config"
			state: "link"
			force: true
		}
	},
	#SwayTask & {
		name: "Symlinks wallpaper dir"
		file: {
			src:   "{{ repo_path }}/ansible/files/sway/wallpapers"
			dest:  "{{ user_var.home }}/wallpapers"
			state: "link"
			force: "yes"
		}
	},
]
