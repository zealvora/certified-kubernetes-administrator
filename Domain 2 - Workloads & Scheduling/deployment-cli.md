
#### Create Simple Deployment Manifest
```sh
kubectl create deployment my-deployment --image=nginx --dry-run=client -o yaml
```
#### Create Simple Deployment Manifest with 3 Replicas
```sh
kubectl create deployment my-deployment --image=nginx --replicas 3--dry-run=client -o yaml
```
#### Create Deployment using CLI Command
```sh
kubectl create deployment my-deployment --image=nginx --replicas 3
```
```sh
kubectl get deployment

kubectl get pods
```
#### Delete Deployment using CLI Command
```sh
kubectl delete deployment my-deployment
```