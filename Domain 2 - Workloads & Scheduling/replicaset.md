#### Documentation Referred:

https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/

#### Step 1: Create a ReplicaSet Manifest File (replicaset.yaml)

```sh
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend-replicaset
spec:
  replicas: 3
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
        image: us-docker.pkg.dev/google-samples/containers/gke/gb-frontend:v5
```

```sh
kubectl apply -f replicaset.yaml 
```
#### Step 2: Verify Replicaset Creation
```sh
kubectl get replicaset

kubectl get pods

kubectl get pods --show-labels
```
#### Step 3: Scaling ReplicaSet
```sh
kubectl scale --replicas=5 rs/frontend-replicaset
kubectl scale --replicas=1 rs/frontend-replicaset
```

#### Step 4: Delete Replica Set
```sh
kubectl delete -f replicaset.yaml 
```