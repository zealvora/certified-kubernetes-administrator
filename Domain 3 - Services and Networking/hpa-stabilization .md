## Create Deployment and Service
```sh
nano deployment-svc.yaml
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
kubectl create -f deployment-svc.yaml
```

### Step 2 - Create HPA with Stabilization Window
```sh
nano hpa-stabilization.yaml
```
```sh
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: cpu-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: php-apache
  minReplicas: 1
  maxReplicas: 5
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 60
```

```sh
kubectl create -f hpa-stabilization.yaml
```

### Step 3 - Testing

Terminal Tab 1 
```sh
kubectl get hpa cpu-hpa --watch
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
kubectl delete -f deployment-svc.yaml

kubectl delete hpa cpu-hpa
```
