package ansible

#PacmanTask: #ArchTask & {
	tags: ["pacman"]
}

let pacman_conf = """
	[options]
	HoldPkg = pacman glibc
	Architecture = auto
	CheckSpace
	SigLevel = Required DatabaseOptional
	LocalFileSigLevel = Optional

	[core]
	Include = /etc/pacman.d/mirrorlist

	[extra]
	Include = /etc/pacman.d/mirrorlist

	[community]
	Include = /etc/pacman.d/mirrorlist

	[multilib]
	Include = /etc/pacman.d/mirrorlist
	"""

let paccache_timer = """
	[Unit]
	Description=Clean-up Old Pacman Files

	[Timer]
	OnCalendar=daily
	AccuracySec=1h
	Persistent=True

	[Install]
	WantedBy=multi-user.target
	"""

let paccache_service = """
	[Unit]
	Description=Clean-up Old Pacman Files

	[Service]
	Type=oneshot
	IOSchedulingClass=idle
	CPUSchedulingPolicy=idle
	ExecStart=/usr/bin/paccache -r
	ExecStart=/usr/bin/paccache -ruk0
	"""

#pacman: [
	#PacmanTask & {
		name:   "Copy pacman configuration file"
		become: "yes"
		copy: {
			content: pacman_conf
			dest:    "/etc/pacman.conf"
		}
	},
	#PacmanTask & {
		name:   "Refresh pacman mirrors"
		become: "yes"
		pacman: update_cache: "yes"
	},
	#PacmanTask & {
		name: "Install universal base packages"
		pacman: {
			name:  "{{ base_packages }}"
			state: "present"
		}
		become: "yes"
	},
	#PacmanTask & {
		name:   "Create pacman hook directory"
		become: "yes"
		file: {
			path:  "/etc/pacman.d/hooks"
			state: "directory"
		}
	},
	#PacmanTask & {
		name:   "Use all cores when compressing packages"
		become: "yes"
		lineinfile: {
			dest:   "/etc/makepkg.conf"
			regexp: "^COMPRESSXZ"
			line:   "COMPRESSXZ=(xz -c -z - --threads=0)"
		}
	},
	#PacmanTask & {
		name:   "Push pacman cache cleanup service"
		become: "yes"
		copy: {
			content: paccache_service
			dest:    "/etc/systemd/system/paccache.service"
		}
		// TODO: add notify meta handlers
		//notify: ["reload systemd config"]
	},
	#PacmanTask & {
		name:   "Push pacman cache cleanup timer"
		become: "yes"
		copy: {
			content: paccache_timer
			dest:    "/etc/systemd/system/paccache.timer"
		}
		// TODO: add notify meta handlers
		//notify: [
		// "reload systemd config",
		// "restart paccache",
		//]
	},
	#PacmanTask & {
		name:   "Enable and start pacman cache cleanup timer"
		become: "yes"
		service: {
			name:    "paccache.timer"
			enabled: "yes"
			state:   "started"
		}
	},
]
