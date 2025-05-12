
### Pending Phase Example
```sh
nano pending-pod.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: app-pod
spec:
  containers:
  - name: myapp-container
    image: nginx
    resources:
      requests:
        memory: "100Gi"
        cpu: "100"
```
```sh
kubectl create -f pending-pod.yaml
```
```sh
kubectl get pods
```
### Succeeded Phase Example
```sh
nano pod-succeded.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  restartPolicy: Never
  containers:
  - name: busybox
    image: busybox
    command: ["echo", "Hello, Kubernetes!"]
```

```sh
kubectl create -f pod-succeded.yaml
```
```sh
kubectl get pods
```

### Failed Phase Example
```sh
kubectl run failpod --image=busybox --restart=Never -- /bin/sh -c "exit 1"
```

### Additional Testing
```sh
kubectl run nginx-pod --image=nginx:notexistent

kubectl run curl-pod --image=alpine/curl
```
