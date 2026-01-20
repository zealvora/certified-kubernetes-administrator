### Create KubeConfig from scratch

#### 1. Add cluster details.
```sh
kubectl config --kubeconfig=base-config set-cluster development --server=https://1.2.3.4
```

#### 2. Add user details
```sh
kubectl config --kubeconfig=base-config set-credentials development-admin --username=test-user--password=some-password
```
#### 3. Setting Contexts
```sh
kubectl config --kubeconfig=base-config set-context dev-cluster --cluster=development --namespace=dev --user=development-user
```
#### 4. Add Details for Prod Kubernetes Cluster
```sh
kubectl config --kubeconfig=base-config set-cluster production --server=https://4.5.6.7
```
```sh
kubectl config --kubeconfig=base-config set-credentials production-admin --username=prod-user --password=prod-password
```
```sh
kubectl config --kubeconfig=base-config set-context prod-cluster --cluster=production --namespace=prod --user=production-admin
```
### Next Steps:

1. View Kubeconfig
```sh
kubectl config --kubeconfig=base-config view
```
2. Get current conext information:
```sh
kubectl config --kubeconfig=base-config get-contexts
```
3. Switch Conexts:
```sh
kubectl config --kubeconfig=base-config use-context dev-cluster
```
