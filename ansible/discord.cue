// TODO: fix it up to work in the new structure
[{
	name: "Check if discord-{{ item.release_channel }} is installed"
	stat: path: "/usr/local/bin/discord-{{ item.release_channel }}"
	register: "discord_bin"
	tags: [
		"discord",
	]
}, {
	name:   "Make discord dir"
	become: "yes"
	file: {
		name:  "{{ discord_dir }}"
		state: "directory"
		owner: "{{ user.name }}"
		group: "{{ user.name }}"
	}
}, {
	name:   "Make discord-{{ item.release_channel }} dir"
	when:   "discord_bin.stat.exists == False"
	become: "yes"
	tags: [
		"discord",
	]
	file: {
		owner: "{{ user.name }}"
		group: "{{ user.name }}"
		path:  "{{ discord_dir }}/discord-{{ item.release_channel }}"
		state: "directory"
	}
}, {
	name: "Download discord"
	when: "discord_bin.stat.exists == False"
	tags: [
		"discord",
	]
	get_url: {
		url:  "https://discord.com/api/download/{{ item.release_channel }}?platform=linux&format=tar.gz"
		dest: "/tmp/discord-{{ item.release_channel }}.tar.gz"
	}
}, {
	name: "Unarchive discord"
	when: "discord_bin.stat.exists == False"
	tags: [
		"discord",
	]
	unarchive: {
		owner: "{{ user.name }}"
		src:   "/tmp/discord-{{ item.release_channel }}.tar.gz"
		dest:  "{{ discord_dir }}/discord-{{ item.release_channel }}"
		extra_opts: ["--strip-components=1"]
	}
}, {
	name:   "Link binary"
	when:   "discord_bin.stat.exists == False"
	become: "yes"
	tags: [
		"discord",
	]
	file: {
		owner: "{{ user.name }}"
		src:   "/opt/discord/discord-{{ item.release_channel }}/{{ item.binary_name }}"
		dest:  "/usr/local/bin/discord-{{ item.release_channel }}"
		state: "link"
	}
}]
