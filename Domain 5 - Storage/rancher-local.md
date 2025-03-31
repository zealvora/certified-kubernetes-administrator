### Documentation Referenced:

https://github.com/rancher/local-path-provisioner

### Deploy Local Path Provisioner by Rancher

```sh
kubectl create -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.31/deploy/local-path-storage.yaml
```
```sh
kubectl get storageclass
```

### Create PersistentVolumeClaim
```sh
nano rancher-pvc.yaml
```
```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: local-path-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: local-path
  resources:
    requests:
      storage: 128Mi
```
```sh
kubectl create -f rancher-pvc.yaml

kubectl get pvc

kubectl describe pvc local-path-pvc
```

### Create Pod
```sh
nano test-pod.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: volume-test
    image: nginx
    volumeMounts:
    - name: local-path
      mountPath: /data
    ports:
    - containerPort: 80
  volumes:
  - name: local-path
    persistentVolumeClaim:
      claimName: local-path-pvc
```

```sh
kubectl create -f test-pod.yaml

kubectl get pvc

kubectl get pv
```
