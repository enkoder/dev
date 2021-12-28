package ansible

#OnepassTask: #GenericTask & {
	tags: ["onepass"]
}

#onepass: [
	#OnepassTask & {
		name: "Check if op exists"
		stat: {
			path: "/usr/local/bin/op-{{ op_version }}"
		}
		register: "op"
	},
	#OnepassTask & {
		name: "Download zip"
		when: "op.stat.exists == False"
		get_url: {
			url:  "https://cache.agilebits.com/dist/1P/op/pkg/v{{ op_version }}/op_linux_amd64_v{{ op_version }}.zip"
			dest: "/tmp/op_linux_amd64_{{ op_version }}.zip"
		}
	},
	#OnepassTask & {
		name: "Unarchive zip"
		when: "op.stat.exists == False"
		when: "ansible_distribution != 'MacOSX'"
		unarchive: {
			src:  "/tmp/op_linux_amd64_{{ op_version }}.zip"
			dest: "/tmp"
		}
	},
	#OnepassTask & {
		name: "Moves op to /usr/local/bin"
		when: "op.stat.exists == False"
		copy: {
			owner: "{{ user.name }}"
			group: "{{ user.group }}"
			src:   "/tmp/op"
			dest:  "/usr/local/bin/op"
			mode:  "u+rwx"
		}
		become: "yes"
	},
]
