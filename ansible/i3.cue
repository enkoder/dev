package ansible

#i3Task: #ArchTask & {
	tags: ["i3"]
}

#i3: [
	#i3Task & {
		name: "Install i3-gap"
		aur:  "name=i3-gaps-next-git"
	},
	#i3Task & {
		name: "Install screen lock deps"
		pacman: {
			state: "present"
			name: [
				"i3lock",
				"scrot",
				"imagemagick",
			]
		}
	},
	#i3Task & {
		name:   "Move lock script"
		become: "yes"
		file: {
			src:   "{{ repo_path }}/ansible/files/i3/lock.sh"
			dest:  "/bin/lock"
			force: true
			state: "link"
		}
	},
	#i3Task & #FetchUserTask & {},
	#i3Task & {
		name: "Make i3 config dir"
		file: {
			path:  "{{ user_var.home }}/.config/i3"
			state: "directory"
		}
	},
	#i3Task & {
		name: "Symlink config file"
		file: {
			src:   "{{ repo_path }}/ansible/files/i3/config"
			dest:  "{{ user_var.home }}/.config/i3/config"
			state: "link"
			force: true
		}
	},
	#i3Task & {
		name: "Symlinks wallpaper dir"
		file: {
			src:   "{{ repo_path }}/ansible/files/wallpapers"
			dest:  "{{ user_var.home }}/wallpapers"
			state: "link"
			force: "yes"
		}
	},
]
