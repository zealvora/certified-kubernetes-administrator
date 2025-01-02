
### Base Pod Manifest File Used

```sh
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
 containers:
 - name: nginx-container
   image: nginx
```

### Multi-Container Pod Manifest (multi-container-pod.yaml)

```sh
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
spec:
 containers:
 - name: nginx-container
   image: nginx
 - name: redis-container
   image: redis
```

### Base Commands Used in Video
```sh
kubectl apply -f pod.yaml
kubectl apply -f multi-container-pod.yaml
kubectl get pods
kubectl describe pod multi-container-pod
```

### Exec into Multi Container Pod
```sh
kubectl exec -it multi-container-pod -- bash

kubectl exec -it multi-container-pod -c redis-container -- bash
```

### Delete the Resource Created in this Video

```sh
kubectl delete -f pod.yaml

kubectl delete -f multi-container-pod.yaml
```
