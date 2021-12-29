package homelab

// _base defines settings that apply to all cloud objects
_base: {
	name: string

	label: [string]: string

	// k8s is a set of Kubernetes-specific settings that will be merged in at
	// the top-level. The allowed fields are type specfic.
	kubernetes: {}
}

deployment: [Name=_]: _base & {
	// Allow any string, but take Name by default.
	name: string | *Name
	label: [string]: string
	kind:     *"deployment" | "stateful" | "daemon"
	replicas: int | *1

	// required image string
	image: string

	// expose port defines named ports that is exposed in the service
	expose: port: [string]: int

	// port defines named ports that is not exposed in the service.
	port: [string]: int

	arg: [string]: string
	args: *[ for k, v in arg {"-\(k)=\(v)"}] | [...string]

	// Environment variables
	env: [string]: string

	envSpec: [string]: {}
	envSpec: {
		for k, v in env {
			"\(k)": value: v
		}
	}

	volume: [Name=_]: {
		name:      string | *Name
		mountPath: string
		subPath:   string | *null
		readOnly:  *false | true
		kubernetes: {}
	}
}

service: [Name=_]: _base & {
	name: *Name | string
	label: [string]: string

	port: [Name=_]: {
		name: string | *Name

		port:     int
		protocol: *"TCP" | "UDP"
	}
}

configMap: [string]: {}

kubernetes: services: {
	// Note that we cannot write
	//   kubernetes services "\(k)": {} for k, x in service
	// "service" is also a field comprehension and the spec prohibits one field
	// comprehension referencing another within the same struct.
	// In general it is good practice to define a comprehension in the smallest
	// struct possible.
	for k, x in service {
		"\(k)": x.kubernetes & {
			apiVersion: "v1"
			kind:       "Service"

			metadata: name:   x.name
			metadata: labels: x.label
			spec: selector:   x.label

			spec: ports: [ for p in x.port {p}] // convert struct to list
		}
	}
}

kubernetes: deployments: {
	for k, x in deployment if x.kind == "deployment" {
		"\(k)": (_k8sSpec & {X: x}).X.kubernetes & {
			apiVersion: "extensions/v1beta1"
			kind:       "Deployment"
			spec: replicas: x.replicas
		}
	}
}

kubernetes: statefulSets: {
	for k, x in deployment if x.kind == "stateful" {
		"\(k)": (_k8sSpec & {X: x}).X.kubernetes & {
			apiVersion: "apps/v1beta1"
			kind:       "StatefulSet"
			spec: replicas: x.replicas
		}
	}
}

kubernetes: daemonSets: {
	for k, x in deployment if x.kind == "daemon" {
		"\(k)": (_k8sSpec & {X: x}).X.kubernetes & {
			apiVersion: "extensions/v1beta1"
			kind:       "DaemonSet"
		}
	}
}

kubernetes: configMaps: {
	for k, v in configMap {
		"\(k)": {
			apiVersion: "v1"
			kind:       "ConfigMap"

			metadata: name: k
			metadata: labels: component: _base.label.component
			data: v
		}
	}
}

// _k8sSpec injects Kubernetes definitions into a deployment
// Unify the deployment at X and read out kubernetes to obtain
// the conversion.
// TODO: use alias
_k8sSpec: X: kubernetes: {
	metadata: name: X.name
	metadata: labels: component: X.label.component

	spec: template: {
		metadata: labels: X.label

		spec: containers: [{
			name:  X.name
			image: X.image
			args:  X.args
			if len(X.envSpec) > 0 {
				env: [ for k, v in X.envSpec {v, name: k}]
			}

			ports: [ for k, p in X.expose.port & X.port {
				name:          k
				containerPort: p
			}]
		}]
	}

	// Volumes
	spec: template: spec: {
		if len(X.volume) > 0 {
			volumes: [
				for v in X.volume {
					v.kubernetes

					name: v.name
				},
			]
		}

		containers: [{
			// TODO: using conversions this would look like:
			// volumeMounts: [ k8s.VolumeMount(v) for v in d.volume ]
			if len(X.volume) > 0 {
				volumeMounts: [
					for v in X.volume {
						name:      v.name
						mountPath: v.mountPath
						if v.subPath != null {
							subPath: v.subPath
						}
						if v.readOnly {
							readOnly: v.readOnly
						}
					},
				]
			}
		}]
	}
}
