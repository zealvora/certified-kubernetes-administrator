
### Configuring Kubectl for Linux:

```sh
mkdir ~/.kube
cd ~/.kube
nano config
```

Add  the config file which you have downloaded inside the config file in ~/kube directory.

### Verification:
```sh
kubectl get nodes
```

### Reference to Custom Kubeconfig file in non-default Path
```sh
kubectl get nodes --kubeconfig "config"
```