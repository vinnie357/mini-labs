#!/bin/bash
echo "=====install cni-plugins ====="

set -e

VERSION=${1:-${CNI_VERSION:-"1.4.1"}}
CNI_ROOT=${2:-${CNI_PLUGINS_ROOT:-"/opt"}}

curl -L -o cni-plugins.tgz "https://github.com/containernetworking/plugins/releases/download/v${VERSION}/cni-plugins-linux-$([ $(uname -m) = aarch64 ] && echo arm64 || echo amd64)"-v${VERSION}.tgz

if [ $CNI_ROOT == "/opt" ]; then
    echo installing to $CNI_ROOT/cni/bin
    sudo mkdir -p $CNI_ROOT/cni/bin
    sudo tar -C $CNI_ROOT/cni/bin -xzf cni-plugins.tgz
else
    echo installing to $CNI_ROOT/cni/bin
    mkdir -p $CNI_ROOT/bin
    tar -C $CNI_ROOT/bin -xzf cni-plugins.tgz
fi

rm -f cni-plugins.tgz

echo "===== cni-plugins done ====="