
### Describe Node to Check Capacity, Allocated and Alloctable
```sh
kubectl get nodes

kubectl describe node <node-name>
```
### Pod 1 (Fit Pod) Manifest File
```sh
nano pod-1.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: fit-pod
spec:
  containers:
  - name: successful-container
    image: nginx
    resources:
      requests:
        memory: "854Mi"
        cpu: "198m"
      limits: 
        memory: "854Mi"
        cpu: "198m"
```
```sh
kubectl create -f pod-1.yaml

kubectl delete -f pod-1.yaml
```
### Pod 1 (Unfit Pod) Manifest File
```sh
nano pod-2.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: unfit-pod
spec:
  containers:
  - name: successful-container
    image: nginx
    resources:
      requests:
        memory: "500Mi"
        cpu: "200m"
      limits:
        memory: "854Mi"
        cpu: "200m"
```
```sh
kubectl create -f pod-2.yaml

kubectl delete -f pod-2.yaml
```
### Pod 3 (Tmp Pod) Manifest File
```sh
nano pod-3.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: tmp-pod
spec:
  containers:
  - name: successful-container
    image: nginx
    resources:
      requests:
        memory: "1Mi"
        cpu: "1m"
```
```sh
kubectl create -f pod-3.yaml

kubectl delete -f pod-3.yaml
```

### Create Alpine Pod
```sh
kubectl run curl-pod --image=alpine/curl -- sleep 36000
```