# Creating our First POD Configuration File


###  Documentation Link for Resources Discussed in Video

https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.19/

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
