
#### Step 1: Create Backend Pod
```sh
kubectl run backend-pod --image=nginx
```
#### Step 2: Create Frontend Pod
```sh
kubectl run frontend-pod --image=ubuntu --command -- sleep 36000
```
#### Step 3: Test the Connection between Frontend and Backend PODs
```sh
kubectl get pods -o wide
kubectl exec -it frontend-pod -- bash
apt-get update && apt-get -y install curl
curl <BACKEND-POD-1-IP>
```
#### Step 4: Create a new Service

```sh
service.yaml file
```
```sh
apiVersion: v1
kind: Service
metadata:
   name: simple-service
spec:
   ports:
   - port: 80
     targetPort: 80
```
```
kubectl create -f service.yaml
kubectl get service
kubectl describe service simple-service
```
#### Step 5: Create  Endpoint for Service
```sh
endpoint.yaml
```
Make sure to change the IP address to `backend-pod` ip.

```sh
apiVersion: v1
kind: Endpoints
metadata:
  name: simple-service
subsets:
  - addresses:
      - ip: 10.244.0.23
    ports:
      - port: 80
```
```sh
kubectl create -f endpoint.yaml

kubectl describe service simple-service
```
#### Step 6: Test the Connection
```sh
kubectl exec -it frontend-pod -- bash
curl <SERVICE-IP>
```

### Step 7: Testing Port vs TargetPort

Modify the `service.yaml` file to change Port to 8080
```sh
apiVersion: v1
kind: Service
metadata:
   name: simple-service
spec:
   ports:
   - port: 8080
     targetPort: 80
```
```
kubectl delete -f service.yaml

kubectl create -f service.yaml
kubectl create -f endpoint.yaml
kubectl describe service simple-service
```

#### Step 8: Test the Connectivity
```sh
kubectl exec -it frontend-pod -- bash
curl <SERVICE-IP>:8080
```

#### Step 9: Delete the Created Resources
```sh
kubectl delete -f service.yaml

kubectl delete pod backend-pod

kubectl delete pod frontend-pod
```
