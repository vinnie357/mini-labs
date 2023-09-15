# kind


## create

https://kind.sigs.k8s.io/docs/user/quick-start/#creating-a-cluster

```bash

kind --version

kind create cluster

kind get clusters

kind delete cluster


```

## load images

https://kind.sigs.k8s.io/docs/user/quick-start/#loading-an-image-into-your-cluster

```bash
# from archive
kind load image-archive /my-image-archive.tar --name kind
# cluster name is kind by default
kind load docker-image my-custom-image-0 my-custom-image-1 --name kind

# list default name is kind-control-plane
docker exec -it kind-control-plane crictl images
```

### private images

https://kind.sigs.k8s.io/docs/user/private-registries

