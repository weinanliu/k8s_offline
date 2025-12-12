#!/bin/bash -x
#
#
#
#
sleep 10

sudo swapoff -a

sudo systemctl enable --now kubelet

ctr -n k8s.io images import k8s_cores.tar
ctr -n k8s.io images import calico.tar
ctr -n k8s.io images import tigera.tar

# kubeadm init的时候总有人想找k8s.io
#ctr -n k8s.io images tag  registry.aliyuncs.com/google_containers/pause:3.10.1 registry.k8s.io/pause:3.10.1
	#--control-plane-endpoint=10.211.55.4 \
	#--apiserver-advertise-address=10.211.55.4 \


kubeadm init  \
        --pod-network-cidr=192.168.0.0/16 \
	--kubernetes-version="v1.34.3" \
	2>&1 | tee  kubeadm_init.log

sleep 90
kubectl taint nodes --all node-role.kubernetes.io/control-plane:NoSchedule-

kubectl apply -f tigera-operator.yaml

sleep 10
kubectl apply -f custom-resources.yaml

