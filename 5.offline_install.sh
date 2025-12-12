#!/bin/bash -x
#
#
#
#
sleep 10

sudo swapoff -a

sudo sed -i 's|sandbox_image = .*|sandbox_image = "registry.k8s.io/pause:3.10.1"|g' /etc/containerd/config.toml
sudo systemctl restart containerd

sudo systemctl enable --now kubelet

for imgtar in *images.tar; do
  ctr -n k8s.io images import ${imgtar}
done

kubeadm init  \
        --pod-network-cidr=192.168.0.0/16 \
	--kubernetes-version="v1.34.3" \
	2>&1 | tee  kubeadm_init.log

export KUBECONFIG=/etc/kubernetes/admin.conf

watch -n 1 kubectl get pods -A

