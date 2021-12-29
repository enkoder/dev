package ansible

#K8sTask: #ArchTask & {
	tags: ["k8s"]
}

#k8s: [
	#K8sTask & {
		name:        "Install aur dependencies"
		become:      "yes"
		become_user: "{{ user.name }}"
		aur: {
			name: ["etcd"]
			state: "present"
		}
	},
	#K8sTask & {
		name:        "Install pacman dependencies"
		become:      "yes"
		become_user: "{{ user.name }}"
		pacman: {
			name: ["kubernetes-control-plane", "kubernetes-node", "kubeadm", "kubelet", "containerd"]
			state: "present"
		}
	},
	#K8sTask & {
		name:   "Disable system swap"
		become: "yes"
		shell:  "swapoff -a"
	},
	#K8sTask & {
		name:   "Disable swappiness and pass bridged IPv4 traffic to iptable's chains"
		become: "yes"
		sysctl: {
			name:  "{{ item.name }}"
			value: "{{ item.value }}"
			state: "present"
		}
		with_items: [
			{name: "vm.swappiness", value:                      0},
			{name: "net.bridge.bridge-nf-call-iptables", value: 1},
		]
	},
	#K8sTask & {
		name:   "Reload kubelet daemon"
		become: "yes"
		systemd: {
			name:          "kubelet"
			daemon_reload: "yes"
			enabled:       "yes"
		}
	},
]
