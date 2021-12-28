package ansible

#ZpreztoTask: #ArchTask & {
	tags: ["zprezto"]
}

#zprezto: [
	#ZpreztoTask & #FetchUserTask & {},
	#ZpreztoTask & {
		name: "Check if zprezto was cloned"
		stat: path: "{{ user_var.home }}/.zprezto"
		register: "zprezto"
	},
	#ZpreztoTask & {
		name: "Clone zprezto"
		when: #ZpreztoTask.when + ["zprezto.stat.exists == False"]
		git: {
			repo:      "https://github.com/sorin-ionescu/prezto.git"
			dest:      "{{ user_var.home }}/.zprezto"
			update:    "yes"
			recursive: true
		}
	},
]
