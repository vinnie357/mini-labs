# helm

`keep in mind that helm installs itself into your k8s cluster so you should have one running for the init process.`

## setup
```bash
helm version
helm init

kubectl get all --all-namespaces | grep tiller
# service account
# kubectl create serviceaccount --namespace kube-system tiller
# kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
# kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```

## troubleshooting

