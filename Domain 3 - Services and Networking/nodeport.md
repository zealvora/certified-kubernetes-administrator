## Documentation Referenced:

https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport

### Creating NodePort Service Type
`nodeport-service.yaml` file

```sh
apiVersion: v1
kind: Service
metadata:
   name: nodeport-service
spec:
   type: NodePort
   selector:
     app: backend
   ports:
   - port: 80
     targetPort: 80
```
```sh
kubectl create -f nodeport-service.yaml

kubectl describe service nodeport-service
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
> [!NOTE]
>When you use kind (Kubernetes IN Docker), the Kubernetes nodes are essentially Docker containers running inside a hidden Linux VM (or WSL2 >backend). Your Windows / macOS host OS does not have a direct network route to the Docker bridge network where that internal IP (172.18.0.2) >lives. One of the alternative solution / workaround is to use kubectl port-forward.


```sh
kubectl port-forward service/nodeport-service <YOUR-SERVICE-NODE-PORT>:80

curl 127.0.0.1:NodePort
```
### Create NodePort Manifest from CLI
```sh
kubectl create service nodeport --help

kubectl create service my-ns --tcp=5678:8080 --dry-run=client -o yaml

kubectl create service my-ns --tcp=5678:8080

kubectl get service
```

### Manually Define NodePort in Manifest

```sh
apiVersion: v1
kind: Service
metadata:
   name: nodeport-service-2
spec:
   type: NodePort
   ports:
   - port: 80
     targetPort: 80
     nodePort: 30556
```
```sh
kubectl create -f nodeport-service.yaml

kubectl get service
```


#### Step 5: Delete All the Resources
```sh
kubectl delete -f nodeport-service.yaml

kubectl delete service nodeport-service my-ns 

kubectl delete pod backend-pod
```
