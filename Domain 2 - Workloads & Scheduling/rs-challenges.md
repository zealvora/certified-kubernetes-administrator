
### Base ReplicaSet Manifest File Used (rs.yaml)

```sh
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: webserver-replicaset
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webserver
  template:
    metadata:
      labels:
        app: webserver
    spec:
      containers:
      - name: nginx-container
        image: nginx:latest
```
```sh
kubectl apply -f rs.yaml
```

### Commands Used in Video

```sh
kubectl get rs
kubectl get pods
```

### Changing the Image of ReplicaSet to Observe Effects

```sh
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: webserver-replicaset
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webserver
  template:
    metadata:
      labels:
        app: webserver
    spec:
      containers:
      - name: nginx-container
        image: httpd:latest
```
```sh
kubectl apply -f rs.yaml
```

```sh
kubectl get pods

kubectl describe rs webserver-replicaset

kubetl describe pod <pod-name>

kubectl delete pod <pod-name>

kubectl get pods

kubectl scale rs/webserver-replicaset --replicas=0
kubectl scale rs/webserver-replicaset --replicas=3
```

### Label Collision Use-Case
```sh
kubectl delete -f rs.yaml

kubectl run pod external-pod --image=nginx
kubectl label pod external-pod app=webserver
kubectl get pods --show-labels

kubectl apply -f rs.yaml
kubectl get pods

kubectl delete -f rs.yaml
kubectl get pods
```

### Multiple Labels and Selector Use-Case

```sh
kubectl run pod external-pod --image=nginx
kubectl label pod external-pod app=webserver
```
Adding one more label in the selector and template.

```sh
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: webserver-replicaset
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webserver
      env: prod
  template:
    metadata:
      labels:
        app: webserver
        env: prod
    spec:
      containers:
      - name: nginx-container
        image: httpd:latest
```
```sh
kubectl apply -f rs.yaml

kubectl get pods --show-labels

kubectl delete -f rs.yaml
```