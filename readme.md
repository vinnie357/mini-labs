# laptop lab

settings for local laptop lab

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

```bash
# hyperv

# vagrant
. ./scripts/vagrant.sh
```