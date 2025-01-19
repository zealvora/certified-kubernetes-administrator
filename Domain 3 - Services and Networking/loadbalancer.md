### Base Service Manifest File Used

lb-service.yaml

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

### Create Load Balancer Service

lb-service.yaml

```sh
apiVersion: v1
kind: Service
metadata:
   name: simple-service
spec:
   selector:
     app: backend
   type: LoadBalancer
   ports:
   - port: 80
     targetPort: 80
```
```sh
kubectl create -f lb-service.yaml

kubectl get service
```

####  Create Pod with Label Matching Service Selector
```sh
kubectl run backend-pod --image=nginx

kubectl label pod backend-pod app=backend
```

Fetch the External IP and verify if the Nginx webpage loads.

####  Delete the Resources
```sh
kubectl delete pod backend-pod
kubectl delete -f lb-service.yaml
```
