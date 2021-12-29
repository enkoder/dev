package ansible

#RedshiftTask: #ArchTask & {
	tags: ["redshift"]
}

#redshift: [
	#RedshiftTask & #FetchUserTask & {},
	#RedshiftTask & {
		name: "Install redshift"
		yay: {
			name:  "redshift-wayland-git"
			state: "present"
		}
		become: "yes"
	},
	#RedshiftTask & {
		name: "Make sure config folder exists"
		file: {
			path:  "{{ user_var.home }}/.config/redshift"
			state: "directory"
		}
	},
	#RedshiftTask & {
		name: "Link redshift config"
		file: {
			src:   "{{ repo_path }}/ansible/files/redshift/redshift.conf"
			dest:  "{{ user_var.home }}/.config/redshift/redshift.conf"
			force: true
			state: "link"
		}
	},
]
