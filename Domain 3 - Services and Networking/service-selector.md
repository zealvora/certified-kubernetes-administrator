#### Base Service Manifest File Used:

service.yaml 

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


#### Adding Selector in Service Manifest
```sh
apiVersion: v1
kind: Service
metadata:
   name: simple-service
spec:
   selector:
     app: backend
   ports:
   - port: 80
     targetPort: 80
```
```sh
kubectl create -f service.yaml
```
#### Create Pods with Appropriate Labels
```sh
kubectl run backend-pod-1 --image=nginx
kubectl run backend-pod-2 --image=nginx

kubectl label pod backend-pod-1 app=backend
kubectl label pod backend-pod-2 app=backend
```
#### Verification
```sh
kubectl describe service simple-service

kubectl label pod backend-pod-1 app-

kubectl describe service simple-service
```

#### Delete Created Resources
```sh
kubectl delete -f service.yaml

kubectl delete pod backend-pod-1
kubectl delete pod backend-pod-2
```
