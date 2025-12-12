#!/bin/bash -x

#sudo apt install -y python3 python3-pip python-is-python3
#pip install pyyaml


python3 ./export_tar__from_imgs.py $(kubeadm config images list --kubernetes-version="v1.34.3") k8s_cores_images.tar



# for calico https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart#step-2-install-calico
# wget https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/tigera-operator.yaml
# wget https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/custom-resources.yaml
# wget https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/calico.yaml
# wget https://raw.githubusercontent.com/projectcalico/calico/v3.31.2/manifests/operator-crds.yaml
#
python3 ./export_tar__from_imgs.py $(python3 ./extract_imgs_from_yaml.py tigera-operator.yaml) tigera_images.tar
python3 ./export_tar__from_imgs.py $(python3 ./extract_imgs_from_yaml.py calico.yaml) calico_images.tar

python3 ./export_tar__from_imgs.py quay.io/calico/pod2daemon-flexvol:v3.31.2 calico1_images.tar



