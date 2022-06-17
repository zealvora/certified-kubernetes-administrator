
#### Pre-Requisite Step 1: Create a new POD with name nginx
```sh
kubectl run nginx --image=nginx
```
#### Pre-Requisite Step 2: Create a New Deployment
```sh
nano service-deployment.yaml
```
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kplabs-deployment
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
      - name: nginx
        image: nginx
```
```sh
kubectl apply -f service-deployment.yaml
```
#### Step 1: Generate Service Manifest - POD
```sh
kubectl expose pod nginx --name nginx-service --port=80 --target-port=80 --dry-run=client -o yaml

kubectl expose pod nginx --name nginx-service --port=80 --target-port=80 --dry-run=client -o yaml > service-01.yaml

kubectl describe service nginx-svc
```
#### Step 2: Generate NodePort Service Manifest - POD
```sh
kubectl expose pod nginx --name nginx-nodeport-service --port=80 --target-port=80 --type=NodePort --dry-run=client -o yaml

kubectl get service
```

#### Step 3: Generate  Service Manifest - Deployment
```sh
kubectl expose deployment kplabs-deployment --name nginx-deployment-service --port=80 --target-port=8000

kubectl describe service nginx-deployment-service
```

### Step 4: Delete Resources
```sh
kubectl delete pod nginx
kubectl delete deployment kplabs-deployment
kubectl delete service nginx-service
kubectl delete service nginx-nodeport-service
kubectl delete service nginx-deployment-service
```
