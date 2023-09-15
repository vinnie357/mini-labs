# cilium on kind

https://docs.cilium.io/en/stable/installation/kind/

## tools
docker
kubectl
helm
kind


## setup

```bash
kind create cluster --config=kind-config.yaml

kubectl cluster-info --context kind-kind

helm repo add cilium https://helm.cilium.io/

docker pull quay.io/cilium/cilium:v1.14.2
kind load docker-image quay.io/cilium/cilium:v1.14.2 --name kind

helm install cilium cilium/cilium --version 1.14.2 \
   --namespace kube-system \
   --set image.pullPolicy=IfNotPresent \
   --set ipam.mode=kubernetes


cilium version --client

cilium status --wait

cilium connectivity test
```
