
### 1 - Always Restart Policy
```sh
kubectl run test-pod --image=busybox -- nonexistentcommand
```
```sh
kubectl get pods -w
```

### 2- Never Restart Policy
```sh
kubectl run test-pod-2 --restart=Never --image=busybox -- nonexistentcommand

kubectl get pods
```

### 3- OnFailure Restart Policy

```sh
kubectl run test-pod-3 --restart=OnFailure --image=busybox -- nonexistentcommand

kubectl run test-pod-4 --restart=OnFailure --image=busybox -- echo "Hello Kubernetes"
```

### Manifest File with Restart Policy
```sh
kubectl run test-pod-5 --restart=OnFailure --dry-run=client -o yaml --image=busybox -- echo "Hello Kubernetes"
```
Rererence Manifest File:
```sh
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: test-pod-5
  name: test-pod-5
spec:
  containers:
  - args:
    - echo
    - Hello Kubernetes
    image: busybox
    name: test-pod-5
  restartPolicy: OnFailure
```