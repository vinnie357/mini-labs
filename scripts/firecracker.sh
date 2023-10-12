#!/bin/bash
release_url="https://github.com/firecracker-microvm/firecracker/releases"
latest=$(basename $(curl -fsSLI -o /dev/null -w  %{url_effective} ${release_url}/latest))
arch=`uname -m`
curl -L ${release_url}/download/${latest}/firecracker-${latest}-${arch}.tgz \
| tar -xz
mv release-${latest}-$(uname -m) firecracker
sudo cp firecracker/firecracker-${latest}-$(uname -m) /usr/bin/firecracker
firecracker --version
rm -rf firecracker