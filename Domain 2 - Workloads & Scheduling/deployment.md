
### Create Deployment through CLI Command
```sh
kubectl create deployment nginx-deployment --image=nginx
```
```sh
kubectl get deployment
kubectl get pods
kubectl get rs
```
### Generate Deployment Manifest File
```sh
kubectl create deployment nginx-deployment --image=nginx --dry-run=client -o yaml > deployment.yaml
```

### Update Image of Deployment
```sh
kubectl set image --help

kubectl set image deployment/nginx-deployment nginx=httpd:latest

kubectl get pods
```
### Rollout Undo (Revert the Changes)
```sh
kubectl rollout history deployment/nginx-deployment

kubectl get rs

kubectl rollout undo deployment nginx-deployment

kubectl get rs
```
```sh
kubectl rollout undo --help

kubectl rollout undo deployment nginx-deployment --to-revision=2
```
### Scale Deployment
```sh
kubectl scale --replicas=3 deployment nginx-deployment
```
### Delete the Deployment
```sh
kubectl delete deployment nginx-deployment

kubectl get rs
```

