### Documentation Referred:

https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/


#### Create New Service Account
```sh
kubectl create serviceaccount custom-sa
```

#### Generate Base Pod Manifest
```sh
kubectl run custom-pod --image=nginx --dry-run=client -o yaml > custom-pod-sa.yaml
```
#### Final Edited Manifest
```sh
apiVersion: v1
kind: Pod
metadata:
  name: custom-pod
spec:
  serviceAccountName: custom-sa
  containers:
  - image: nginx
    name: custom-pod
```
```sh
kubectl apply -f custom-pod-sa.yaml
``````