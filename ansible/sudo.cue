package ansible

#SudoTask: #GenericTask & {
	tags: ["sudo"]
}

let sudoers_file = """
	## User privilege specification
	##
	root ALL=(ALL) ALL

	%wheel ALL=(ALL) ALL
	{{ user.name }} ALL=(ALL) NOPASSWD: /usr/bin/yay, /usr/bin/pacman
	"""

#sudo: [
	#SudoTask & {
		name:   "Install sudo"
		become: "yes"
		pacman: {
			name:  "sudo"
			state: "present"
		}
	},
	#SudoTask & {
		name:   "Copy sudo configuration"
		become: "yes"
		copy: {
			content:  sudoers_file
			dest:     "/etc/sudoers"
			mode:     440
			validate: "visudo -cf %s"
		}
	},
]
