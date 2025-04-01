### Documentation Referenced:

https://kubernetes.io/docs/concepts/storage/volumes/#emptydir

### Base Manifest for Multi-Container Pod
```sh
nano multi-container.yaml
```
```sh
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
spec:
 containers:
 - name: busybox-container-1
   image: busybox
   command: ["sleep", "36000"]

 - name: busybox-container-2
   image: busybox
   command: ["sleep", "36000"]
```

### Final Manifest with emptyDir volume

```sh
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
spec:
 volumes:
 - name: kplabs-emptydir
   emptyDir: {}

 containers:
 - name: busybox-container-1
   image: busybox
   command: ["sleep", "36000"]
   volumeMounts:
   - name: kplabs-emptydir
     mountPath: /shared-folder

 - name: busybox-container-2
   image: busybox
   command: ["sleep", "36000"]
   volumeMounts:
   - name: kplabs-emptydir
     mountPath: /shared-folder
```
```sh
kubectl create -f  multi-container.yaml

kubectl get pods
```
### Verification
```sh
kubectl exec -it multi-container-pod -c busybox-container-1 -- sh

ls -l /

cd /shared-folder

touch container-1-file.txt
```
```sh
kubectl exec -it multi-container-pod -c busybox-container-2 -- sh

cd /shared-folder

ls
```

### Delete the Resources
```sh
kubectl delete -f multi-container.yaml
```