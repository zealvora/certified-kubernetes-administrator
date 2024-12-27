
### pod.yaml
```sh
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx-container
    image: nginx
```

### Create Pod Using Manifest File
```sh
kubectl apply -f pod.yaml
```

#### List the Running Pods
```sh
kubectl get pods
```
#### Delete the Resources Created via pod.yaml file
```sh
kubectl delete -f pod.yaml
```
