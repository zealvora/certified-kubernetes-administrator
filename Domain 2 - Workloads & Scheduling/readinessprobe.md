#### readinessprobe.yaml

```sh
apiVersion: v1
kind: Pod
metadata:
  name: readiness
spec:
  containers:
  - name: readiness
    image: ubuntu
    tty: true
    readinessProbe:
     exec:
       command:
       - cat
       - /tmp/healthy
     initialDelaySeconds: 5
     periodSeconds: 5
```

#### Create the file at the readiness probe path
```sh
kubectl exec -it readiness touch /tmp/healthy
```
#### Verify if POD is ready:
```sh
kubectl get pods
```
