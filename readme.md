# mini-labs

settings for local laptop labs using Wsl2 where possible.

current equipment is a surface pro 9 with win11.


## laptop tools
windows 11
hyperv
vagrant
minikube
docker-ce

vscode
    plugins
    GitHub.copilot


## setup

depends on what tools you want to use

### common

```bash
. ./scripts/wsl-conf.sh
# restart wsl
```

restart wsl

### kind with docker

```bash

. ./scripts/docker.sh
. ./scripts/kind.sh
. ./scripts/kubectl.sh
# https://kind.sigs.k8s.io/docs/user/quick-start/#creating-a-cluster
kind create cluster
kubectl get pods --all-namespaces
kind delete cluster
```


### vagrant with hyperv

`note: requires enabling hyperv`
 - add windows features
    - windows hypervisor


# hyperv

[install hyperv](docs/hyperv.md)

```bash
# vagrant
. ./scripts/vagrant.sh
```

### [hashi-stack](labs/hashicorp/hashi-stack/readme.md)

```bash
# docker
. /scripts/docker.sh

# docker-compose
. /scripts/docker-compose.sh

cd labs/hashicorp/hashi-stack

```

### [firecracker](labs/firecracker/readme.md)

```bash
# kvm
. scripts/kvm-qemu.sh
# firecracker 
. scripts/firecracker.sh

```