#!/bin/bash

# Get the Kubernetes gpg key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Add the Kubernetes repository
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Update your packages
sudo apt-get update

# Install Docker, kubelet, kubeadm, and kubectl
sudo apt-get install -y kubelet=1.15.7-00 kubeadm=1.15.7-00 kubectl=1.15.7-00

# Hold them at the current version
sudo apt-mark hold kubelet kubeadm kubectl

# Add the iptables rule to sysctl.conf
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf

# Enable iptables immediately
sudo sysctl -p