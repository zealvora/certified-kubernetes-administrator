
#### Step 1: Creating Deployments
```sh
nano demo-deployment.yaml
```
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```
```sh
kubectl apply -f demo-deployment.yaml
```

#### Step 2: Creating Service
```sh
nano service-selector.yaml
```
```sh
apiVersion: v1
kind: Service
metadata:
   name: kplabs-service-selector
spec:
   selector:
     app: nginx
   ports:
   - port: 80
     targetPort: 80
```
```sh
kubectl apply -f service-selector.yaml
```

#### Step 3: Verify Endpoints in Service
```sh
kubectl describe service kplabs-service-selector
```

#### Step 4: Scale Deployments
```sh
kubectl scale deployment/nginx-deployment --replicas=10
```

#### Step 5: Verify Endpoints in Service
```sh
kubectl describe service kplabs-service-selector
```

#### Step 6: Create a New Manual POD and Add a Label
```sh
kubectl run manual-pod --image=nginx
kubectl label pods manual-pod app=nginx
```

#### Step 7: Verify Endpoints in Service
```sh
kubectl describe service kplabs-service-selector
kubectl describe endpoints kplabs-service-selector
```

#### Step 8: Delete Created Resources
```sh
kubectl delete service kplabs-service-selector
kubectl delete -f demo-deployment.yaml
kubectl delete pod manual-pod
```
