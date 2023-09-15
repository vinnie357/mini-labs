#!/bin/bash
#https://www.virtualizationhowto.com/2021/11/install-minikube-in-wsl-2-with-kubectl-and-helm/
# git clone https://github.com/DamionGans/ubuntu-wsl2-systemd-script.git
# cd ubuntu-wsl2-systemd-script/
# bash ubuntu-wsl2-systemd-script.sh

sudo apt update && sudo apt upgrade -y
sudo apt install -y conntrack

# Download the latest Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Make it executable
chmod +x ./minikube

# Move it to your user's executable PATH
sudo mv ./minikube /usr/local/bin/

#Set the driver version to Docker
#minikube config set driver docker
