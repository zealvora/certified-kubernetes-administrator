### Documentation Referenced:

https://kubernetes.io/docs/concepts/storage/storage-classes/

### Important Pre-Requisite:

For the practical demonstrations in this video, we utilized a DigitalOcean Managed Kubernetes Cluster in conjunction with the Local Path Provisioner, the configuration of which was covered in our previous videos.

### PVC Manifest Used
```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: csi-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: do-block-storage
```
```sh
kubectl create -f pvc.yaml
```
### Pod Manifest Used

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
  volumes:
  - name: local-path
    persistentVolumeClaim:
      claimName: csi-pvc
```

```sh
kubectl create -f test-pod.yaml
```