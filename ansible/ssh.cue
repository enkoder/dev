package ansible

#SSHTask: #GenericTask & {
	tags: ["ssh"]
}

#ssh: [
	#SSHTask & #FetchUserTask & {},
	#SSHTask & {
		name: "Fetch the ssh priv key from onepass if the env is set"
		command: {
			cmd: "op get document id_rsa"
			environment: {
				OP_SESSION_my: "{{ lookup('env','OP_SESSION_my') }}"
			}
		}
		register: "id_rsa"
	},
	#SSHTask & {
		name: "Fetch ssh key"
		copy: {
			dest:    "{{ user_var.home }}/.ssh/id_rsa"
			content: "{{ id_rsa.stdout }}"
			mode:    "0600"
		}
	},
	#SSHTask & {
		name: "Fetch the ssh pub key from onepass"
		command: {
			cmd: "op get document id_rsa.pub"
			environment: {
				OP_SESSION_my: "{{ lookup('env','OP_SESSION_my') }}"
			}
		}
		register: "id_rsa_pub"
	},
	#SSHTask & {
		name: "Fetch ssh key"
		copy: {
			dest:    "{{ user_var.home }}/.ssh/id_rsa.pub"
			content: "{{ id_rsa_pub.stdout }}"
		}
	},
]
