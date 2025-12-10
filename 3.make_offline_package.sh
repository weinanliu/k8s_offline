#!/bin/bash -x

sudo apt install python3 python3-pip python-is-python3 python3-xyz
pip install pyyaml


./export_tar__from_imgs.py $(kubeadm config images list) k8s_cores.tar



# for calico https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart#step-2-install-calico
# wget https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/tigera-operator.yaml
# wget https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/custom-resources.yaml
# wget https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/calico.yaml
#
./export_tar__from_imgs.py $(./extract_imgs_from_yaml.py tigera-operator.yaml) tigera.tar
./export_tar__from_imgs.py $(./extract_imgs_from_yaml.py calico.yaml) calico.tar




