
### Example 1 - Echo Pod
```sh
kubectl run echo-pod --image=busybox:latest --command -- "Hello World!"

kubectl logs echo-pod

kubectl delete pod echo-pod
```

### Example 2 - Ping Pod
```sh
kubectl run ping-pod --image=busybox:latest --command -- ping "-c" "30" "google.com

kubectl logs ping-pod

kubectl delete pod ping-pod
```
### Example 3 - Manifest File

#### 1 - Base Pod Manifest File Used as Reference
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

#### 2 - Final Pod Manifest with CMD and Args (cmd-args.yaml)

```sh
apiVersion: v1
kind: Pod
metadata:
  name: new-ping-pod
spec:
 containers:
 - name: ping-container
   image: busybox:latest
   command: ["ping"]
   args: ["-c","60","google.com"]
```

```sh
kubectl apply -f cmd-args.yaml
kubectl get pods
kubectl logs new-ping-pod
```

