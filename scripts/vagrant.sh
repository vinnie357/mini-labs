#!/bin/bash
#apt-cache madison vagrant
VERSION=${1:-${VAGRANT_VERSION:-"2.4.0-1"}}
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update && sudo apt upgrade -y
sudo apt install vagrant=${VERSION} -y

echo 'export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"' >> ~/.profile

source ~/.profile
