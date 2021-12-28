package ansible

#TailscaleTask: #ArchTask & {
	tags: ["tailscale"]
}

#tailscale: [
	#TailscaleTask & {
		name:   "Install tailscale"
		become: "yes"
		pacman: "name=tailscale"
	},
	#TailscaleTask & {
		name:   "Start and enable tailscaled"
		become: "yes"
		service: {
			name:    "tailscaled"
			state:   "started"
			enabled: "yes"
		}
	},
]
