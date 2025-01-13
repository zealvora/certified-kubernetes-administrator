
### Documentation Referenced:

https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

### Base Pod Manifest File (request-limit.yaml)

```sh
apiVersion: v1
kind: Pod
metadata:
  name: kplabs-pod
spec:
  containers:
  - name: kplabs-container
    image: nginx
```

### Final Pod Manifest File with Request and Limits

```sh
apiVersion: v1
kind: Pod
metadata:
  name: kplabs-pod
spec:
  containers:
  - name: kplabs-container
    image: nginx
    resources:
      requests:
        memory: "128Mi"
        cpu: "0.1"
      limits:
        memory: "500Mi"
        cpu: "1"
```

### Commands Used in Video
```sh
kubectl describe node <node-name>

kubectl apply -f request-limit.yaml

kubectl delete -f request-limit.yaml
```