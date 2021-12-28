package ansible

#HostnameTask: #ArchTask & {
	tags: ["hostname"]
}

#hostname: [
	#HostnameTask & {
		name:   "Set the hostname"
		become: "yes"
		hostname:
			name: "{{ inventory_hostname }}"
	},
]
