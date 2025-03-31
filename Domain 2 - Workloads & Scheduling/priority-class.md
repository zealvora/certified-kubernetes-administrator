
### Create 2 Priority Classes (High and Low)
```sh
kubectl create priorityclass high-priority --value=1000 --description="high priority"

kubectl create priorityclass low-priority --value=100 --description="high priority"
```


### Create Deployment with 5 Low-Priority Pods
```sh
nano low-priority-class.yaml
```
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: low-priority-deploy
spec:
  replicas: 5
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
            memory: "100Mi"
            cpu: "100m"
```
```sh
kubectl apply -f low-priority-class.yaml
```
### Create Deployment with 5 High-Priority Pods
```sh
nano high-priority-class.yaml
```
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: high-priority-deploy
spec:
  replicas: 5
  selector:
    matchLabels:
      app: high-priority
  template:
    metadata:
      labels:
        app: high-priority
    spec:
      priorityClassName: low-priority
      containers:
      - name: busybox
        image: nginx
        resources:
          requests:
            memory: "100Mi"
            cpu: "100m"
```

