#!/bin/bash
echo "=====install rad-cli ====="
#wget -q "https://raw.githubusercontent.com/radius-project/radius/main/deploy/install.sh" -O - | /bin/bash

VERSION=${1:-${RADIUS_VERSION:-"0.26.8"}}
ARCH_NAME=$(dpkg --print-architecture)

#https://github.com/radius-project/radius/releases/download/v0.26.8/rad_linux_amd64
wget --quiet https://github.com/radius-project/radius/releases/download/v${VERSION}/rad_linux_${ARCH_NAME}
sudo chmod +x rad_linux_${ARCH_NAME}
sudo mv rad_linux_${ARCH_NAME} /usr/bin/rad
rad version
rad bicep download
echo "===== rad-cli done ====="
