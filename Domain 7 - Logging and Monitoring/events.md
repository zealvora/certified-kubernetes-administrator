#### Documentation Referred:

https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/

#### Get the Events
```sh
kubectl get events
```
#### Create POD
```sh
kubectl run event-pod --image=nginx
```
#### Check for Evetns
```sh
kubectl get events
```
#### Check for Events based on Namespace
```sh
kubectl get events -n kube-system
kubectl get events -n default
```