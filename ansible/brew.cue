package ansible

#brew: [
	#MacTask & {
		name: "Install brew packages for a Mac device"
		tags: ["brew"]
		homebrew: {
			name:            "{{ brew_packages }}"
			state:           "present"
			update_homebrew: "yes"
		}
	},
]
