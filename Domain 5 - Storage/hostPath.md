### Documentation Referenced:

https://kubernetes.io/docs/concepts/storage/volumes/#hostpath

### Create Pod with hostPath Volume

```sh
nano hostPath.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: test-container
    image: busybox
    command: ["sleep", "3600"]
    volumeMounts:
    - name: host-volume
      mountPath: /worker-node-data
  volumes:
  - name: host-volume
    hostPath:
      path: /
```

```sh
kubectl create -f hostPath.yaml
```

### Verification
```sh
kubectl get pods

ls -l /

cd /worker-node-data

ls -l /
```

### Delete the Resources
```sh
kubectl delete -f hostPath.yaml
```