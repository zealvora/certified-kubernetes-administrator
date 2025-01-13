### Base Pod Manifest File Used in Video (nodeSelector-pod.yaml)

```sh
apiVersion: v1
kind: Pod
metadata:
  name: kplabs-pod
spec:
  containers:
  - name: nginx-pod
    image: nginx
```

### Adding Node Selector Configuration to Base Pod Manifest File

```sh
apiVersion: v1
kind: Pod
metadata:
  name: kplabs-pod
spec:
  nodeSelector:
    size: Large
  containers:
  - name: nginx-pod
    image: nginx
```

```sh
kubectl apply -f nodeSelector-pod.yaml
```
### Verify the Label of Node
```sh
kubectl get nodes
kubectl describe node <node-name>
```

### Step 2: Label Worker Node
```sh
kubectl label node <node-1> size=Large
```

### Verify Pod status
```sh
kubectl get pods -o wide
```

### Step 5: Destroy Resources created in this video
```sh
kubectl label node <node-1> size-

kubectl delete -f nodeSelector-pod.yaml
```
