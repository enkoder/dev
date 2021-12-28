package ansible

#DockerTask: #ArchTask & {
	tags: ["docker"]
}

#docker: [
	#DockerTask & {
		name: "Install docke"
		pacman: {
			name:  "docker"
			state: "present"
		}
	},
	#DockerTask & {
		name: "Create docker group"
		group:
		{
			name:  "docker"
			state: "present"
		}
	},
	#DockerTask & {
		name:   "Add user to docker group"
		become: "yes"
		user: {
			name:   "{{ user.name }}"
			groups: "docker"
			append: "yes"
		}
	},
	#DockerTask & {
		name: "Ensure docker has started and is enabled"
		systemd: {
			state:   "started"
			name:    "docker"
			enabled: "yes"
		}
	},
]
