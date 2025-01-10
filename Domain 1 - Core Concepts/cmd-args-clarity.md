
### Base File Used in the Video
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

### Example 1 - Using Only Command without Args (cmd-clarity.yaml)
```sh
apiVersion: v1
kind: Pod
metadata:
  name: new-ping-pod
spec:
 containers:
 - name: ping-container
   image: busybox:latest
   command: ["ping","-c","60","google.com"]
   args: []
```
```sh
kubectl apply -f cmd-clarity.yaml
kubectl get pods
kubectl logs new-ping-pod
kubectl delete pod new-ping-pod
```
### Example 2 - Specifying Command in a List Format
```sh
apiVersion: v1
kind: Pod
metadata:
  name: new-ping-pod
spec:
 containers:
 - name: ping-container
   image: busybox:latest
   command: 
     - "ping"
     -  "-c"
     -  "60"
     - "google.com"
```
```sh
kubectl apply -f cmd-clarity.yaml
kubectl get pods
kubectl logs new-ping-pod
kubectl delete pod new-ping-pod
```