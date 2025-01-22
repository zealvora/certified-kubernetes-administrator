
### Fetch Pod Details

kubectl get pods

kubectl get pods --all-namespaces

### Running Pod in Default Namespace

kubectl run test-pod --image=nginx


#### List PODS in a specific namespace:
```sh
kubectl get pods -n kube-system
```

#### Create a new Namespace
```sh
kubectl create namespace development
kubectl create namespace qa
kubectl get namespace
```

#### Create a new POD in specific namespace:
```sh
kubectl run development-pod --image=nginx -n development
kubectl run qa-pod --image=nginx -n qa

kubectl get pods - development

kubectl run test-pod --image=nginx --dry-run=client -o yaml
```
