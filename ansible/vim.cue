package ansible

#VimTask: #ArchTask & {
	tags: ["vim"]
}

#vim: [
	#VimTask & #FetchUserTask & {},
	#VimTask & {
		name:   "Install vim & neovim"
		become: "yes"
		pacman: {
			state: "present"
			name: [
				"vim",
				"neovim",
			]
		}
	},
	#VimTask & {
		name: "Check if vimplug is installed"
		stat: {
			path: "{{ user_var.home }}/.vim/autoload/plug.vim"
		}
		register: "plug"
	},
	#VimTask & {
		name: "Create autoplug dir"
		file: {
			path:  "{{ user_var.home }}/.vim/autoload"
			state: "directory"
		}
	},
	#VimTask & {
		name: "Fetch vimplug"
		when: #ArchTask.when + ["plug.stat.exists == False"]
		get_url: {
			url:  "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
			dest: "{{ user_var.home }}/.vim/autoload/plug.vim"
		}
	},
	#VimTask & {
		name: "Create nvim dir"
		file: {
			path:  "{{ user_var.home }}/.config/nvim"
			state: "directory"
		}
	},
	#VimTask & {
		name: "Symlink vimrc file"
		file: {
			src:   "{{ repo_path }}/ansible/files/vim/vimrc"
			dest:  "/home/{{ user.name }}/.vimrc"
			state: "link"
			force: true
		}
	}, {
		name: "Symlink init.vim file"
		file: {
			src:   "{{ repo_path }}/ansible/files/vim/init.vim"
			dest:  "{{ user_var.home }}/.config/nvim/init.vim"
			state: "link"
			force: true
		}
	}]
