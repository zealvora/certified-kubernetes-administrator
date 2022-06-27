
### Step 1: Verify the Label of Node
```sh
kubectl get nodes
kubectl describe node <node-name>
```

### Step 2: Label Worker Node
```sh
kubectl label node <node-1> disk=hdd
kubectl label node <node-2> disk=ssd
kubectl label node <node-3> disk=hdd
```

### Step 3: Create NodeSelector Configuration
```sh
nano nodeselector.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: service-pod
spec:
  containers:
  - name: service-pod
    image: nginx
  nodeSelector:
    disk: ssd
```
```sh
kubectl apply -f nodeselector.yaml
```

### Step 4: Verify
```sh
kubectl get pods -o wide
```

### Step 5: Destroy Resources created in this video
```sh
kubectl delete -f nodeselector.yaml
```
