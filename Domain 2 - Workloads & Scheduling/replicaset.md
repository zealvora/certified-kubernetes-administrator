#### Documentation Referred:

https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/

#### Step 1: Create a ReplicaSet

##### replicaset.yaml 
```sh
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: kplabs-replicaset
spec:
  replicas: 5
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: php-redis
        image: nginx
```
```sh
kubectl apply -f replicaset.yaml 
```
#### Step 2: Verify Replicaset Creation
```sh
kubectl get replicaset

kubectl get pods
```

#### Step 3: Testing ReplicSet capability
```sh
kubectl delete pod <1-POD-from-ReplicaSet>

kubectl get pods --show-labels
```

#### Step 4: Delete Replica Set
```sh
kubectl delete -f replicaset.yaml 
```