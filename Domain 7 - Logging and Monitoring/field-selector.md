
#### List all the PODS from All Namespaces
```sh
kubectl get pods --all-namespaces
```
#### List all PODS from ALL namespaces except default namespace
```sh
kubectl get pods --field-selector metadata.namespace!=default
```
#### List all Pods from ALL namespace except a specific POD
```sh
kubectl get pods --field-selector metadata.name!=<ADD-POD-NAME-HERE>
```
#### Create New Deployment
```sh
kubectl create deployment test-deployment --replicas 3 --image=nginx
```
#### Get Events with Output JSON
```sh
kubectl get events -o json
```
#### Get Events Associated with a Specific POD
```sh
kubectl get events --field-selector involvedObject.name=event-pod
```
#### Default Configuration
```sh
kubectl get pods --field-selector ""
```