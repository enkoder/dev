package ansible

#GenericTask: {
	name: string
	tags: [...string]
	when?:     string | [...string]
	register?: string | [...string]
	...
}

#FetchUserTask: #GenericTask & {
	name: "Fetching user information to get home dir"
	user: {
		name: "{{ user.name }}"
	}
	register: "user_var"
}

#ArchTask: #GenericTask & {
	when: ["ansible_os_family == 'Archlinux'", ...]
	...
}

#MacTask: #GenericTask & {
	when: ["ansible_os_family == 'Darwin'"]
	...
}

#Role: {
	role: string
	tags: [...string]
}

#Playbook: {
	hosts: string
	roles?: [...#Role]
	tasks?: [...#GenericTask]
	...
}
