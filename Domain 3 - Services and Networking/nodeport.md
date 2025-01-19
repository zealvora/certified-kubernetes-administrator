### Base Service Manifest File Used

service.yaml 

```sh
apiVersion: v1
kind: Service
metadata:
   name: nodeport-service
spec:
   selector:
     app: backend
   ports:
   - port: 80
     targetPort: 80
```

### Creating NodePort Service Type

```sh
apiVersion: v1
kind: Service
metadata:
   name: nodeport-service
spec:
   selector:
     app: backend
   type: NodePort
   ports:
   - port: 80
     targetPort: 80
```
```sh
kubectl create -f service.yaml
```
### Create Necessary Pods to Match Service Selector
```sh
kubectl run backend-pod --image=nginx

kubectl label pod backend-pod app=backend

kubectl describe service nodeport-service
```
### Fetch the Worker Node IP to make a request
```sh
kubectl get nodes -o wide

curl <IP:NodePort>
```
### Create NodePort Manifest from CLI
```sh
kubectl create service nodeport --help

kubectl create service nodeport test-nodeport --tcp=80:80 --dry-run=client -o ya```ml
```

### Manually Define NodePort in Manifest

```sh
apiVersion: v1
kind: Service
metadata:
   name: nodeport-service
spec:
   type: NodePort
   ports:
   - port: 80
     targetPort: 80
     nodePort: 30556
```
```sh
kubectl delete service nodeport-service

kubectl create -f service.yaml
```

#### Step 5: Delete All the Resources
```sh
kubectl delete pod backend-pod
kubectl delete -f service.yaml
```
