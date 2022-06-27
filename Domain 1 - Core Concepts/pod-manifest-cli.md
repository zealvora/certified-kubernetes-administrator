#### 1. Create a Pod from Nginx Image

```sh
kubectl run nginx --image=nginx

kubectl get pods
```
#### 2. Create a Pod and Expose a Port
```sh
kubectl run nginx-port --image=nginx --port=80
kubectl describe pod nginx-port
```


#### 3. Output the Manifest File
```sh
kubectl run nginx --image=nginx --port=80 --dry-run=client -o yaml
```


#### 4. Delete PODS
```sh
kubectl delete pod nginx

kubectl delete pod --all
```