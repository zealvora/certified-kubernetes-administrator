
###  Documentation Link for Resources Discussed in Video

https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/

https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#metadata



### newpod.yaml file
```sh
apiVersion: v1
kind: Pod
metadata:
  name: nginxwebserver
spec:
  containers:
  -  image: nginx
     name: democontainer
```
```sh
kubectl apply -f newpod.yaml
```

#### List the Running Pods
```sh
kubectl get pods
```
#### Delete the Resources Created via newpod.yaml file
```sh
kubectl delete -f newpod.yaml
```
