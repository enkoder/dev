package homelab

import (
	"strings"
	"encoding/yaml"
)

command: ls: {
	task: print: {
		kind: "print"
		let Lines = [
			for x in objects {
				"\(x.kind)  \t\(x.metadata.labels.component)   \t\(x.metadata.name)"
			},
		]
		text: strings.Join(Lines, "\n")
	}
}

command: dump: {
	task: print: {
		kind: "print"
		text: yaml.MarshalStream(objects)
	}
}

command: create: {
	task: kube: {
		kind:   "exec"
		cmd:    "kubectl create --dry-run -f -"
		stdin:  yaml.MarshalStream(objects)
		stdout: string
	}
	task: display: {
		kind: "print"
		text: task.kube.stdout
	}
}
