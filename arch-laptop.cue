import ( "github.com/enkoder/dev/ansible"

	//- hosts: arch-laptop
	//  roles:
	//    - { role: 1pass, tags: ['1pass'] }
	//    - { role: ssh, tags: ['ssh'] }
	//    - { role: dotfiles, tags: ['dotfiles'] }
	//    - { role: vim, tags: ['vim'] }
	//    - { role: zprezto, tags: ['zprezto'] }
	//    - { role: sway, tags: ['sway'] }
	//    - { role: waybar, tags: ['waybar'] }
	//    - { role: docker, tags: ['docker'] }
	//    - { role: audio, tags: ['audio'] }
	//    - { role: terminal, tags: ['terminal'] }
	//    - { role: notifs, tags: ['notifs'] }
)

[ansible.#Playbook & {
	hosts: "arch-laptop"
	tasks: ansible.#user + ansible.#sudo + ansible.#pacman + ansible.#aur +
		ansible.#pulseaudio + ansible.#i3 + ansible.#waybar +
		ansible.#notifications + ansible.#rofi + ansible.#omz +
		ansible.#sway + ansible.#vim
	vars: {
		repo_path: "/home/enkoder/github.com/enkoder/dev"
		user: {
			uid:        1000
			name:       "enkoder"
			group:      "enkoder"
			shell:      "/usr/bin/zsh"
			email:      "kodiegoodwin@gmail.com"
			github:     "enkoder"
			first_name: "Kodie"
			last_name:  "Goodwin"
		}

		aur: {
			dir: "aur"
			packages: [
				"powerline-fonts",
				"git",
				"nerd-fonts",
				"font-manager",
				"google-chrome",
				"spotify",
				"tlpui",
				"git",
				"google-cloud-sdk",
				"starship"]
		}

		base_packages: [
			// base stuff
			"base", "devel", "ntp", "man-db", "man-pages", "pacman-contrib", "wmname", "inetutils", "openssh",
			// power & laptop things
			"acpi", "tlp", "tlp-rdw", "acpi_call", "tp_smapi",
			// terminal
			"alacritty",
			// i3 & x
			"xorg-server", "xorg-xinit", "xorg-xrdb", "xorg-xrandr", "feh",
			// sway
			"wl-clipboard", "mako", "python-i3ipc", "bemenu", "waybar", "neofetch",
			// dev things
			"neovim", "code", "docker", "python-pip", "tmux", "git", "rsync", "jq", "screen", "virtualbox", "pyenv",
			"tree", "unzip", "htop",
			// audio
			"pulseaudio", "pavucontrol",
			// video things
			"arandr",
		]

		wallpaper:  "nord-mountain.jpg"
		terminal:   "alacritty"
		op_version: "1.0.0"
	}
},
]
