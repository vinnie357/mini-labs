#!/bin/bash
DIR=$(pwd)
mkdir -p machines
KERNERL_VERSION=5.10.198
ARCH="$(uname -m)"

cd machines

# Download a linux kernel binary
wget -nc https://s3.amazonaws.com/spec.ccfc.min/firecracker-ci/v1.6/${ARCH}/vmlinux-${KERNERL_VERSION}

# Download a rootfs
wget -nc https://s3.amazonaws.com/spec.ccfc.min/firecracker-ci/v1.6/${ARCH}/ubuntu-22.04.ext4

# Download the ssh key for the rootfs
wget -nc https://s3.amazonaws.com/spec.ccfc.min/firecracker-ci/v1.6/${ARCH}/ubuntu-22.04.id_rsa

# Set user read permission on the ssh key
chmod 400 ./ubuntu-22.04.id_rsa

cd $DIR

echo "=== Done ==="