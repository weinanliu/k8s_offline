#!/bin/bash -x

kubectl taint nodes --all node-role.kubernetes.io/control-plane:NoSchedule-

kubectl apply -f tigera-operator.yaml

sleep 10
kubectl apply -f custom-resources.yaml

