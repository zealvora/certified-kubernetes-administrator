
### API Documentation Referenced in the Video

https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.32/

### Command Used

```sh
kubectl api-resources
```

### pod.yaml
```sh
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx-container
    image: nginx
```