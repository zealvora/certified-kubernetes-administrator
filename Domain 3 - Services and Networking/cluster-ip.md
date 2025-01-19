
### Base Service Manifest File Used in Practical

service.yaml

```sh
apiVersion: v1
kind: Service
metadata:
   name: simple-service
spec:
   ports:
   - port: 80
     targetPort: 80
```
```sh
kubectl create -f service.yaml

kubectl get service
```

### Create Cluster IP Service through CLI Command
```sh
kubectl create service --help

kubectl create service clusterip --help

kubectl create service clusterip test-service --tcp=80:80

kubectl get service

kubectl create service clusterip test-service --tcp=80:80 --dry-run=client -o yaml
```