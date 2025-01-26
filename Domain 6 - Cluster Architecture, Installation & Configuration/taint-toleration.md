### Documentation Refernced in Video

https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/

### Find Taint for a Node
```sh
kubectl get nodes

kubectl describe node <node-name>
```

### Taint a Node with Effect of NoSchedule
```sh
kubectl taint node worker-01 key=value:NoSchedule
```
### Test with Deployment
```sh
kubectl create deployment test-deploy --image=nginx --replicas=5

kubectl get pods -o wide
```
### Define Tolerations
```sh
kubectl create deployment test-deploy --image=nginx --replicas=5 --dry-run=client -o yaml > deployment-toleration.yaml
```
Final File Manifest file after adding toleration

```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: test-deploy
  name: test-deploy
spec:
  replicas: 5
  selector:
    matchLabels:
      app: test-deploy
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: test-deploy
    spec:
      containers:
      - image: nginx
        name: nginx
      tolerations:
      - key: "key"
        operator: "Exists"
        effect: "NoSchedule"
```
```sh
kubectl create -f deployment-toleration.yaml

kubectl get pods -o wide
```
### Taint a Node with Effect of NoExecute
```sh
kubectl taint node worker-01 key=value:NoExecute

kubectl get pods -o wide
```
### Remove Taint from a Node
```sh
kubectl taint node worker-01 key=value:NoSchedule-

kubectl taint node worker-01 key=value:NoExecute-
```