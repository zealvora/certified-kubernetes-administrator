#### Documentation Referred:

https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

#### Create a new Deployment 
```sh
kubectl create deployment kplabs-deployment --image=nginx
```
```sh
kubectl get pods
```
#### Set a New Image to Existing Deployment
```sh
kubectl set image deployment/kplabs-deployment nginx=apache
```
```sh
kubectl get pods
```
#### Rolling Back changes
```sh
kubectl rollout history deployment kplabs-deployment
```
```sh
kubectl rollout undo deployment/kplabs-deployment
```
#### Adding a Record Instruction
```sh
kubectl set image deployment/kplabs-deployment nginx=httpd
```
```sh
kubectl rollout history deployment kplabs-deployment
```
#### Scaling Deployment

```sh
kubectl scale deployment/kplabs-deployment --replicas=10
```
```sh
kubectl get deployments
kubectl get pods
```

#### Delete the resources created in this lecture
```sh
kubectl delete deployment kplabs-deployment
```