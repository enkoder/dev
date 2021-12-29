package ansible

H_RELOAD_SYSTEMD:      "reload systemd config"
H_RELOAD_USER_SYSTEMD: "reload systemd user config"
H_RESTART_PACCACHE:    "restart paccache"
H_RELOAD_XRDB:         "reload xrdb"
H_STOP_SYSTEMD_USER:   "stop systemd per-user instance"

#ReloadSystemdHandler: #ArchTask & {
	name:    H_RELOAD_SYSTEMD
	command: "systemctl daemon-reload"
}

#ReloadUserSystemdHandler: #ArchTask & {
	name:    H_RELOAD_USER_SYSTEMD
	command: "systemctl --user daemon-reload"
}

#RestartPaccacheHandler: #ArchTask & {
	name: H_RESTART_PACCACHE
	service: {
		name:  "paccache.timer"
		state: "restarted"
	}
}

#ReloadXRDBHandler: #ArchTask & {
	name: H_RELOAD_XRDB
	command: {
		cmd: "xrdb -merge /home/{{ user.name }}/.Xresources"
	}
}

#StopSystemdUserHandler: #ArchTask & {
	name: H_STOP_SYSTEMD_USER
	service: {
		name:  "user@{{ user.uid }}"
		state: "stopped"
	}
}
