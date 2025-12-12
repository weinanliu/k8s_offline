#!/bin/bash -x

export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl taint nodes --all node-role.kubernetes.io/control-plane:NoSchedule-

kubectl create -f operator-crds.yaml
kubectl create -f tigera-operator.yaml

sleep 10
kubectl create -f custom-resources.yaml

