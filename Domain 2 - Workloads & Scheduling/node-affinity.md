#### Documentation Referred:

https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/

### Example 1 - (Hard Preference) [nodeAffinity-required.yaml]

```sh
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd            
  containers:
  - name: nginx
    image: nginx
```

### Example 2 - (Soft Preference) [nodeAffinity-preferred.yaml]

```sh
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  affinity:
    nodeAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd          
  containers:
  - name: nginx
    image: nginx
```
```sh
kubectl apply -f nodeAffinity-preferred.yaml
```

### Adding Label to Node for Testing
```sh
kubectl label node <node-name> disk=ssd 
```