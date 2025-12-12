#!/bin/bash -x

export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl taint nodes --all node-role.kubernetes.io/control-plane:NoSchedule-

kubectl apply -f operator-crds.yaml
kubectl apply -f tigera-operator.yaml

sleep 10
kubectl apply -f custom-resources.yaml

