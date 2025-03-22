
### Create Deployment and Service
```sh
nano deployment.yaml
```
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: php-apache
spec:
  selector:
    matchLabels:
      run: php-apache
  template:
    metadata:
      labels:
        run: php-apache
    spec:
      containers:
      - name: php-apache
        image: registry.k8s.io/hpa-example
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 50m
---
apiVersion: v1
kind: Service
metadata:
  name: php-apache
  labels:
    run: php-apache
spec:
  ports:
  - port: 80
  selector:
    run: php-apache
```
```sh
kubectl create -f deployment.yaml
```

### Step 2 - Create HPA
```sh
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=3

kubectl get hpa
```

### Step 3 - Testing

Terminal Tab 1 
```sh
kubectl get hpa php-apache --watch
```

Terminal Tab 2 
```sh
kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
```
```sh
kubectl get pods
```

### Step 4 - Delete the Setup
```sh
kubectl delete -f deployment.yaml

kubectl delete hpa php-apache

kubectl delete pod load-generator
```