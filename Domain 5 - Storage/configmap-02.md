### Base ConfigMap Manifest File Used (configmap.yaml)

```sh
apiVersion: v1
kind: ConfigMap
metadata:
   name: demo-configmap
data:
   DB_HOST: "172.31.10.30:3306"
   DB_USER: "dbadmin"
   DB_PASS: "db!2312$#"
   APP_MODE: "production"
   APP_CAPACITY: "100%"

   large-data: |
      This is Line 1
      This is Line 2
      This is Line 3
```
```sh
kubectl create -f configmap.yaml
```

### Base Pod Manifest File

```sh
apiVersion: v1
kind: Pod
metadata:
  name: configmap-pod
spec:
  containers:
    - name: test-container
      image: nginx
```


### Part 1 - Mount ConfigMap using Volumes

Documentation Referenced:

https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#add-configmap-data-to-a-volume

```sh
apiVersion: v1
kind: Pod
metadata:
  name: configmap-volume-pod
spec:
 containers:
 - name: nginx-container
   image: nginx
   volumeMounts:
   - name: config-volume
     mountPath: /etc/config
 volumes:
   - name: config-volume
     configMap:
       name: demo-configmap
```
```sh
kubectl apply -f pod.yaml
```
### Part 2 - Fetching ConfigMap data as Env Variables

```sh
apiVersion: v1
kind: Pod
metadata:
  name: configmap-env-pod
spec:
 containers:
 - name: nginx-container
   image: nginx
   env:
     - name: MODE_APP
       valueFrom:
         configMapKeyRef:
           name: demo-configmap
           key:  APP_MODE   
```
```sh
kubectl apply -f pod-env.yaml
```

### Delete all the Resources After Completing Practical

```sh
kubectl delete -f configmap.yaml
kubectl delete -f pod.yaml
kubectl delete -f pod-env.yaml
```