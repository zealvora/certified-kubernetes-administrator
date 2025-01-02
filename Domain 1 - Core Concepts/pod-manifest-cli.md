#### 1. Create a Pod from Nginx Image

```sh
kubectl run nginx --image=nginx

kubectl get pods
```

#### 2. Create a Pod from Nginx Image with Dry Run

```sh
kubectl run nginx2 --image=nginx --dry-run=client

kubectl get pods
```
#### 3. Create a Pod from Nginx Image with Output of YAML

```sh
kubectl run nginx2 --image=nginx -o yaml
```
#### 4. Main Command of this Video to Create Manifest File

```sh
kubectl run nginx4 --image=nginx --dry-run=client -o yaml

kubectl run nginx4 --image=nginx --dry-run=client -o yaml > pod-custom.yaml
```

#### 4. Delete All Pods
```sh
kubectl delete pod --all
```