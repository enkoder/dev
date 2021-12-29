package ansible

#RepoTask: #GenericTask & {
	tags: ["repo"]
}

#repo: [
	#RepoTask & {
		name:     "Check if dev was cloned"
		register: "repo"
		stat: {
			path: "{{ repo_path }}"
		}
	},
	#RepoTask & {
		name: "Make repo"
		when: "repo.stat.exists == False"
		file: "path={{ repo_path }} state=directory"
	},
	#RepoTask & {
		name: "Clone repo"
		git: {
			repo:      "https://github.com/enkoder/dev.git"
			dest:      "{{ repo_path }}"
			recursive: true
			update:    "yes"
		}
	},
	#RepoTask & {
		name: "Update ownership of repo"
		when: "repo.stat.exists == False"
		file: {
			path:    "{{ repo_path }}"
			owner:   "{{ user.name }}"
			group:   "{{ user.group }}"
			recurse: true
		}
	},
]
