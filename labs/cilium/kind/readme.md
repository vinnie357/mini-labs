# cilium on kind

https://docs.cilium.io/en/stable/installation/kind/

## tools
docker
kubectl
helm3
kind
cilium-cli

## setup

```bash
CILIUM_VERSION=1.14.2

kind create cluster --config=kind-config.yaml

kubectl cluster-info --context kind-kind

helm repo add cilium https://helm.cilium.io/

helm repo update

docker pull quay.io/cilium/cilium:v1.14.2
kind load docker-image quay.io/cilium/cilium:v1.14.2 --name kind

helm install cilium cilium/cilium --version 1.14.2 \
   --namespace kube-system \
   --set image.pullPolicy=IfNotPresent \
   --set ipam.mode=kubernetes

cilium status --wait


cilium version --client

cilium connectivity test

```

done
```bash
kind delete cluster
```


## wsl2 fun

 looks like 22.04 is missing something that allows the agents to install their iptable rules.
 so the cilium dataplane pods can't start.

```bash
level=fatal msg="failed to start: daemon creation failed: error while initializing daemon: failed while reinitializing datapath: failed to install iptables rules: cannot install static proxy rules: unable to run 'iptables -t raw -A CILIUM_PRE_raw -m mark --mark 0x00000200/0x00000f00 -m comment --comment
```

checking out using older versions

   https://www.danami.com/clients/knowledgebase/194/How-can-I-switch-back-to-iptables-from-nftables-after-upgrading-to-Ubuntu-20.04.2-LTS.html
   ```bash
   update-alternatives --config iptables
   ```
   