package ansible

#PulseTask: #ArchTask & {
	tags: ["audio"]
}

let service_file = """
	[Unit]
	Description=Pulseaudio Sound Service
	Requires=pulseaudio.socket
	
	[Service]
	Type=notify
	ExecStart=/usr/bin/pulseaudio --verbose --daemonize=no
	Restart=on-failure
	
	[Install]
	Also=pulseaudio.socket
	WantedBy=default.target
	"""

let socket_file = """
	[Unit]
	Description=Pulseaudio Sound System
	
	[Socket]
	Priority=6
	Backlog=5
	ListenStream=%t/pulse/native
	
	[Install]
	WantedBy=sockets.target
	"""

#pulseaudio: [
	#PulseTask & {
		name:   "Install Pulse"
		pacman: "name=pulseaudio"
	},
	#PulseTask & {
		name: "Make user systemd user dir exists"
		file: "path=/home/{{ user.name }}/.config/systemd/user state=directory"
	},
	#PulseTask & {
		name: "Symlink service file"
		file: {
			contents: service_file
			dest:     "/home/{{ user.name }}/.config/systemd/user/pulseaudio.service"
			state:    "link"
			force:    true
		}
		notify: [
			"reload systemd user config",
		]
	},
	#PulseTask & {
		name: "Symlink socket file"
		file: {
			content: socket_file
			dest:    "/home/{{ user.name }}/.config/systemd/user/pulseaudio.socket"
			state:   "link"
			force:   true
		}
		notify: [
			"reload systemd user config",
		]
	},
	#PulseTask & {
		name: "Enable and start pulseaudio service"
		systemd: {
			name:    "pulseaudio.service"
			enabled: "yes"
			state:   "started"
			scope:   "user"
		}
	},
]
