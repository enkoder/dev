# TODO
* virtualbox

# Kubernetes Home Lab

```
make k8s

# on control plane node
sudo kubeadm init --control-plane-endpoint=100.107.220.83 --pod-network-cidr=10.244.0.0/16
k create -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# on worker node