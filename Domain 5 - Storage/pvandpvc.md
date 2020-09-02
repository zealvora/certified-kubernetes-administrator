##### pv.yaml

```sh
apiVersion: v1
kind: PersistentVolume
metadata:
  name: block-pv
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /tmp/data
```

##### pvc.yaml

```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: manual
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```
##### pod-pvc.yaml
```sh
kind: Pod
apiVersion: v1
metadata:
  name: kplabs-pvc
spec:
  containers:
    - name: my-frontend
      image: nginx
      volumeMounts:
      - mountPath: "/data"
        name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc

```
