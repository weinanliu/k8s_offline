#!/bin/bash -x
#
#


# install cni plugins
CNI_PLUGINS_VERSION="v1.3.0"
ARCH="amd64"
DEST="/opt/cni/bin"
#curl -L "https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VERSION}/cni-plugins-linux-${ARCH}-${CNI_PLUGINS_VERSION}.tgz"
sudo mkdir -p "$DEST"
sudo tar -C "$DEST" -xzf cni-plugins-linux-amd64-v1.3.0.tgz


DOWNLOAD_DIR=/usr/local/bin
sudo mkdir "-p $DOWNLOAD_DIR"



# install crictl
CRICTL_VERSION="v1.31.0"
ARCH="amd64"
#curl -L "https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-linux-${ARCH}.tar.gz"
sudo tar -C $DOWNLOAD_DIR -xzf crictl-v1.31.0-linux-amd64.tar.gz

containerd config default > /etc/containerd/config.toml
systemctl restart containerd


#RELEASE="$(curl -sSL https://dl.k8s.io/release/stable.txt)"
RELEASE="v1.34.2"

ARCH="amd64"
#curl -L --remote-name-all https://dl.k8s.io/release/${RELEASE}/bin/linux/${ARCH}/{kubeadm,kubelet}

sudo cp kubeadm $DOWNLOAD_DIR
sudo chmod +x $DOWNLOAD_DIR/kubeadm
sudo cp kubelet $DOWNLOAD_DIR
sudo chmod +x $DOWNLOAD_DIR/kubelet

#curl -LO "https://dl.k8s.io/release/${RELEASE}/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl ${DOWNLOAD_DIR}/kubectl


RELEASE_VERSION="v0.16.2"
#wget "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_VERSION}/cmd/krel/templates/latest/kubelet/kubelet.service"
cat kubelet.service | sed "s:/usr/bin:${DOWNLOAD_DIR}:g" | sudo tee /usr/lib/systemd/system/kubelet.service

sudo mkdir -p /usr/lib/systemd/system/kubelet.service.d
#wget "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_VERSION}/cmd/krel/templates/latest/kubeadm/10-kubeadm.conf"
cat 10-kubeadm.conf | sed "s:/usr/bin:${DOWNLOAD_DIR}:g" | sudo tee /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf


