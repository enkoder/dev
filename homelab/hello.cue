package homelab

_base: label: component: "homelab"

deployment: hello: {
	kind:  "deployment"
	image: "nginxdemos/hello"
}

//apiVersion: apps/v1
//kind: Deployment
//metadata:
//  labels:
//    app: example1
//  name: example1
//spec:
//  replicas: 1
//  selector:
//    matchLabels:
//      app: example1
//  template:
//    metadata:
//      labels:
//        app: example1
//    spec:
//      containers:
//      - image: nginx:latest
//        name: nginx
