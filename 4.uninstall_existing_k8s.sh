#!/bin/bash -x
#
kubeadm reset -f

# delete calico
rm -rf /var/lib/cni
rm -rf /etc/cni/net.d
ip route flush proto bird

# delete calixxx NIC
ip link list | grep cali | awk '{print $2}' | cut -c 1-15 | xargs -I {} ip link delete {}

iptables-save | egrep -v "cali|KUBE-" | iptables-restore



