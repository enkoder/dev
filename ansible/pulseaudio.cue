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
	#PulseTask & #FetchUserTask & {},
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
		copy: {
			content: service_file
			dest:    "{{ user_var.home }}/.config/systemd/user/pulseaudio.service"
			force:   true
		}
		notify: [H_RELOAD_USER_SYSTEMD]
	},
	#PulseTask & {
		name: "Symlink socket file"
		copy: {
			content: socket_file
			dest:    "{{ user_var.home }}/.config/systemd/user/pulseaudio.socket"
			force:   true
		}
		notify: [H_RELOAD_USER_SYSTEMD]
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
