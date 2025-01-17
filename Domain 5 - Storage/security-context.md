### Base Insecure Pod Manifest File Used (pod.yaml)

```sh
apiVersion: v1
kind: Pod
metadata:
  name: insecure-pod
spec:
 containers:
 - name: demo-container
   image: busybox:latest
   command: ["sleep", "36000"]
   volumeMounts:
    - name: host-root
      mountPath: /host
 volumes:
  - name: host-root
    hostPath:
      path: /  
```

```sh
kubectl apply -f pod.yaml
```

```sh
kubectl exec -it insecure-pod -- sh
id
cd /hosts 
ls
```

### Documentation Referenced for Security Context:

https://kubernetes.io/docs/tasks/configure-pod-container/security-context/

### Adding Security Context to Pod Manifest with HostPath Volume Mount

pod-controlled.yaml

```sh
apiVersion: v1
kind: Pod
metadata:
  name: controlled-pod
spec:
 securityContext:
   runAsUser: 1000
   runAsGroup: 2000
   fsGroup: 3000
 containers:
 - name: demo-container
   image: busybox:latest
   command: ["sleep", "36000"]
   volumeMounts:
    - name: host-root
      mountPath: /host
 volumes:
  - name: host-root
    hostPath:
      path: /  
```

```sh
kubectl apply -f pod-controlled.yaml
kubectl exec -it controlled-pod -- sh
id

cd /host/tmp
touch test.txt
ls -l
```
### Security Context with EmptyDir Volume (pod-fs.yaml)

```sh
apiVersion: v1
kind: Pod
metadata:
  name: fsgroup-pod
spec:
 securityContext:
   runAsUser: 1000
   runAsGroup: 2000
   fsGroup: 3000
 volumes:
  - name: host-root
    emptyDir: {}
 containers:
 - name: demo-container
   image: busybox:latest
   command: ["sleep", "36000"]
   volumeMounts:
    - name: host-root
      mountPath: /host
```

```sh
kubectl apply -f pod-fs.yaml

kubectl exec -it fsgroup-pod -- sh
id
cd /host/tmp
touch test.txt
ls -l
```

