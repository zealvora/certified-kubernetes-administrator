
### Step 1 - Create Two Persistent Volumes
```sh
nano pv-1.yaml
```
```sh
apiVersion: v1
kind: PersistentVolume
metadata:
  name: manual-pv-1gb
spec:
  storageClassName: manual
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data/1gb
```
```sh
kubectl create -f pv-1.yaml
```

```sh
nano pv-2.yaml
```
```sh
apiVersion: v1
kind: PersistentVolume
metadata:
  name: manual-pv-3gb
spec:
  storageClassName: manual
  capacity:
    storage: 3Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data/2gb
```

```sh
kubectl create -f pv-1.yaml
```

```sh
kubectl get pv
```

### Step 2 - Create Persistent Volume Claim
```sh
nano pvc.yaml
```
```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: manual-pvc-2gb
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  storageClassName: manual
```
```sh
kubectl get pvc
```

### Step 3 - Create Pod
```sh
nano pod-pvc.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
    - name: app
      image: busybox
      command: ["sleep", "3600"]
      volumeMounts:
        - mountPath: "/data"
          name: mydata
  volumes:
    - name: mydata
      persistentVolumeClaim:
        claimName: manual-pvc-2gb
```
```sh
kubectl create -f pod-pvc.yaml
```
```sh
kubectl exec -it busybox -- sh

ls -l /
```

### Delete the Resources
```sh
kubectl delete -f pod-pvc.yaml
kubectl delete -f pvc.yaml
kubectl delete -f pv-1.yaml
kubectl delete -f pv.yaml
```