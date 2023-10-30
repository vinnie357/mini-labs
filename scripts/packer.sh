#!/bin/bash
echo "---installing packer---"
VERSION=${1:-${PACKER_VERSION:-"1.9.4"}}
sudo wget https://releases.hashicorp.com/packer/$VERSION/packer_"$VERSION"_linux_amd64.zip
sudo unzip ./packer_"$VERSION"_linux_amd64.zip -d /usr/local/bin/
sudo rm ./packer_"$VERSION"_linux_amd64.zip
echo "---packer done---"