### Documentation Referenced:

https://kubernetes.io/docs/concepts/storage/storage-classes/

### Important Pre-Requisite

This practical was performed on a Managed Kubernetes Cluster by Digital Ocean

### Get details of Storage Class Available

```sh
kubectl get storageclass
```
### PVC with Storage Class with Reclaim policy of Delete
```sh
nano pvc.yaml
```
```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: csi-pvc
spec:
  storageClassName: do-block-storage
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```
```sh
kubectl create -f pvc.yaml

kubectl get pvc

kubectl get pv

kubectl delete -f pvc.yaml
```
### PVC with Storage Class with Reclaim policy of Retain

```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: csi-pvc
spec:
  storageClassName: do-block-storage-retain
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

```sh
kubectl create -f pvc.yaml

kubectl get pvc

kubectl get pv

kubectl delete -f pvc.yaml

kubectl get pv
```

### Note:

Make sure to manually delete the PV and the Volume from Digital Ocean after completing the practical.