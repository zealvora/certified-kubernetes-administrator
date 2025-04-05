### Documentation Referenced:

https://kubernetes.io/docs/concepts/workloads/pods/init-containers/

### Init Container Manifest
```sh
nano init.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
  - name: app-container
    image: nginx
  initContainers:
  - name: check-google
    image: alpine/curl
    command: ["ping", "-c", "10", "google.com"]
  - name: check-kubernetes
    image: alpine/curl
    command: ["curl", "kubernetes.io"]
```

```sh
kubectl create -f init.yaml

kubectl get pods -w
```