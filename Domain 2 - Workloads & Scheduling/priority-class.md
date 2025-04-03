
### Create 2 Priority Classes (High and Low)
```sh
kubectl create priorityclass high-priority --value=1000 --description="high priority"

kubectl create priorityclass low-priority --value=100 --description="low priority"
```


### Create Deployment with 3 Low-Priority Pods
```sh
nano low-priority.yaml
```
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: low-priority-deploy
spec:
  replicas: 3
  selector:
    matchLabels:
      app: low-priority
  template:
    metadata:
      labels:
        app: low-priority
    spec:
      priorityClassName: low-priority
      containers:
      - name: busybox
        image: nginx
        resources:
          requests:
            memory: "50Mi"
            cpu: "30m"
```
```sh
kubectl apply -f low-priority.yaml
```

### Create Deployment with No Priority Pods

```sh
nano no-priority.yaml
```

```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: no-priority-deploy
spec:
  replicas: 3
  selector:
    matchLabels:
      app: no-priority
  template:
    metadata:
      labels:
        app: no-priority
    spec:
      containers:
      - name: busybox
        image: nginx
        resources:
          requests:
            memory: "50Mi"
            cpu: "30m"
```

```sh
kubectl create -f no-priority.yaml

kubectl get deployments

kubectl get pods

kubectl delete -f no-priority.yaml
```
### Create Deployment with 3 High-Priority Pods
```sh
nano high-priority.yaml
```
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: high-priority-deploy
spec:
  replicas: 3
  selector:
    matchLabels:
      app: high-priority
  template:
    metadata:
      labels:
        app: high-priority
    spec:
      priorityClassName: high-priority
      containers:
      - name: busybox
        image: nginx
        resources:
          requests:
            memory: "50Mi"
            cpu: "30m"
```

```sh
kubectl create -f high-priority.yaml

kubectl get deployments -w

kubectl get pods
```

### Delete the Resources
```sh
kubectl delete -f low-priority.yaml

kubectl delete -f high-priority.yaml

kubectl delete priorityclass high-priority

kubectl delete priorityclass low-priority
```
