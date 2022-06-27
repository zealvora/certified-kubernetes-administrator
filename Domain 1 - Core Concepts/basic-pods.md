
#### List the Worker Node
```sh
kubectl get nodes 
```
#### Create a new POD from Nginx Image
```sh
kubectl run mywebserver --image=nginx
```
#### List  the PODS that are currently running.
```sh
kubectl get pods
```
#### Connect inside the POD
```sh
kubectl exec -it mywebserver -- bash
```
You can come out of the POD with CTRL+D
```sh
kubectl exec -it mywebserver -- ls -l /
```
#### Delete the POD
```sh
kubectl delete pod mywebserver
```

