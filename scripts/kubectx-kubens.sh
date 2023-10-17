#!/bin/bash
echo "---installing kubctx/kubens---"

version=${1:-"0.9.5"}
set -e


curl -LOs https://github.com/ahmetb/kubectx/releases/download/v${version}/kubectx
sudo chmod +x ./kubectx
sudo mv ./kubectx /usr/local/bin/kubectx
kubectx -h
curl -LOs https://github.com/ahmetb/kubectx/releases/download/v${version}/kubens
sudo chmod +x ./kubens
sudo mv ./kubens /usr/local/bin/kubens
kubens -h

echo "---kubctx/kubens done---"