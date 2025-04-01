
### Create Secret
```sh
kubectl create secret --help

kubectl create secret generic --help

kubectl create secret generic auth-secret --from-literal=admin=password
```

### Fetch Secret Details

kubectl get secret

kubectl describe secret auth-secret

kubectl get secret auth-secret -o yaml

### Generate Secret Manifest File
```sh
kubectl create secret generic auth-secret --dry-run=client -o yaml --from-literal=admin=password
```
Reference Output:

```sh
apiVersion: v1
data:
  admin: cGFzc3dvcmQ=
kind: Secret
metadata:
  creationTimestamp: null
  name: auth-secret
```
### Base Pod Manifest File Used

```sh
kind: Pod
metadata:
  name: demo-pod
spec:
  containers:
    - name: test-container
      image: nginx
```
### Documentation Referenced:

https://kubernetes.io/docs/concepts/configuration/secret/

### Mounting Secret Inside Pod using Volume Mounts (pod-secret.yaml)

```sh
kind: Pod
metadata:
  name: demo-pod
spec:
  volumes:
   - name: secret-volume
     secret:
       secretName: auth-secret
  containers:
    - name: test-container
      image: nginx
      volumeMounts:
        - name: secret-volume
          mountPath: "/etc/secret-volume"
```
```sh
kubectl apply -f pod-secret.yaml

kubectl exec -it demo-pod -- bash
cd /etc/secret-volume
cat admin
```
### Documentation Referenced:

https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/#define-container-environment-variables-using-secret-data

### Mounting Secret Inside Pod using Env Variables
pod-secret-env.yaml
```sh
apiVersion: v1
kind: Pod
metadata:
  name: demo-pod-env
spec:
  containers:
    - name: test-container
      image: nginx
      env:
      - name: DB_PASSWORD
        valueFrom:
          secretKeyRef:
            name: auth-secret
            key:  admin
```
```sh
kubectl apply -f pod-secret-env.yaml

kubectl exec -it demo-pod-env -- bash
echo $DB_PASSWORD
```

### Delete the Resources Created

```sh

kubectl delete secret auth-secret
kubectl delete -f pod-secret.yaml
kubectl delete -f pod-secret-env.yaml
```