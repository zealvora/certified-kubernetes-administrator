## Documentation Referenced:

https://kubernetes.io/docs/concepts/services-networking/service/

#### Step 1: Create Backend Pod
```sh
kubectl run backend-pod --image=nginx
```
#### Step 2: Create Frontend Pod
```sh
kubectl run frontend-pod --image=alpine/curl --command -- sleep 36000
```
#### Step 3: Test the Connection between Frontend and Backend PODs
```sh
kubectl get pods -o wide
kubectl exec -it frontend-pod -- sh
curl <BACKEND-POD-1-IP>
```
#### Step 4: Create a new Service


`service.yaml` file

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

```sh
kubectl exec -it frontend-pod -- sh

curl <SERVICE-IP>
```
#### Step 5: Create  Endpoint for Service

`endpoint.yaml` file

Make sure to replace the IP address with the `backend-pod` IP.


```sh
apiVersion: discovery.k8s.io/v1
kind: EndpointSlice
metadata:
  name: simple-service
  labels:
    kubernetes.io/service-name: simple-service
addressType: IPv4
ports:
    - appProtocol: http
      protocol: TCP
      port: 80
endpoints:
   - addresses:
      - "10.244.0.5"
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

kubectl delete -f endpoint.yaml

kubectl delete pod backend-pod frontend-pod
```
