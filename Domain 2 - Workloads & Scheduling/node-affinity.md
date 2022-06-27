#### Documentation Referred:

https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/

## Required Scheduling (Hard Preference)

#### Step 1: Node Affinity - Required
```sh
nano nodeAffinity-required.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: kplabs-node-affinity
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disk
            operator: In
            values:
            - ssd
  containers:
  - name: with-node-affinity
    image: nginx
```
```sh
kubectl apply -f nodeAffinity-required.yaml
```
#### Step 2 - Verify and Clean Resources
```sh
kubectl get pods -o wide
kubectl describe node <node-name>
kubectl delete -f nodeAffinity-required.yaml
```
#### Step 3: Node Affinity - Required using NotIn Operator

Modify the In operator to NotIn in the same file.

```sh
apiVersion: v1
kind: Pod
metadata:
  name: kplabs-node-affinity
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disk
            operator: NotIn
            values:
            - ssd
  containers:
  - name: with-node-affinity
    image: nginx
```
```sh
kubectl apply -f nodeAffinity-required.yaml
```

#### Step 4 - Verify and Clean Resources
```sh
kubectl get pods -o wide
kubectl describe node <node-name>
kubectl delete -f nodeAffinity-required.yaml
```
#### Step 5: Node Affinity Using Unknown Label

Modify the same file to Add a label value that does not match any node.

```sh
apiVersion: v1
kind: Pod
metadata:
  name: kplabs-node-affinity
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disk
            operator: In
            values:
            - ssd2
  containers:
  - name: with-node-affinity
    image: nginx
```
```sh
kubectl apply -f nodeAffinity-required.yaml
```

#### Step 4 - Verify and Clean Resources
```sh
kubectl get pods
kubectl describe pod kplabs-node-affinity
kubectl delete -f nodeAffinity-required.yaml
```

## Preferred Scheduling (Soft Preference)
```sh
nano nodeAffinity-preferred.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: kplabs-node-affinity-preferred
spec:
  affinity:
    nodeAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: memory
            operator: In
            values:
            - high
            - medium
  containers:
  - name: kplabs-affinity-prefferd
    image: nginx
```
```sh
kubectl apply -f nodeAffinity-preferred.yaml
```

#### Step 2 - Verify and Clean Resources
```sh
kubectl get pods -o wide
kubectl describe node <node-name>
kubectl delete -f nodeAffinity-preferred.yaml
```
