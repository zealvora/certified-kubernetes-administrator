###  PVC Manifest using Read-Write-Once Access Mode

```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: demo-pvc
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

kubectl get pv
```


### Create 2 Test Pods that Mounts the PV
```sh
nano pod-1.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: test-pod-1
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
        claimName: demo-pvc
```
```sh
nano pod-2.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: test-pod-2
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
        claimName: demo-pvc
```
```sh
kubectl create -f pod-1.yaml

kubectl create -f pod-2.yaml
```
### Testing the Setup for ReadWriteOnce Access Mode

Run this in Terminal Tab 1
```sh
kubectl exec -it test-pod-1 -- sh

ls -l /

cd /data

touch pod-1-file.txt
```

Run this in Terminal Tab 2
```sh
kubectl exec -it test-pod-2 -- sh

ls -l /

cd /data

ls

touch pod-2-file.txt
```

```sh
kubectl delete -f pod-1.yaml

kubectl delete -f pod-2.yaml

kubectl delete -f pvc.yaml
```

###  PVC Manifest using Read-Write-Once-Pod Access Mode

```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: demo-pvc
spec:
  storageClassName: do-block-storage
  accessModes:
  - ReadWriteOncePod
  resources:
    requests:
      storage: 1Gi
```
```sh
kubectl create -f pvc.yaml

kubectl create -f pod-1.yaml

kubectl get pods

kubectl create -f pod-2.yaml

kubectl get pods

kubectl describe pod test-pod-2
```

###  PVC Manifest using ReadOnlyMany Access Mode (Unsupported)

```sh
kubectl delete -f pvc.yaml

kubectl delete -f pod-1.yaml

kubectl delete -f pod-2.yaml
```
```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: demo-pvc
spec:
  storageClassName: do-block-storage
  accessModes:
  - ReadOnlyMany
  resources:
    requests:
      storage: 1Gi
```
```sh
kubectl create -f pvc.yaml

kubectl get pv
```