
### Daemonset Manifest File (daemonset-custom.yaml)

```sh
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: anti-virus
spec:
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
```

```sh
kubectl apply -f daemonset-custom.yaml

kubectl get pods

kubectl get nodes

kubectl delete -f daemonset-custom.yaml
```