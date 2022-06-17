
#### List Namespaces in Cluster
```sh
kubectl get namespace
```

#### List PODS in a specific namespace:
```sh
kubectl get pods -n kube-system
```

#### Create a new Namespace
```sh
kubectl create namespace teama
kubectl get namespace
```

#### Create a new POD in specific namespace:
```sh
kubectl run nginx --image=nginx --namespace teama
kubectl get pods --namespace teama
```
