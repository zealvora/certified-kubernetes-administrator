#### Documentation Referred:

https://github.com/kubernetes-sigs/metrics-server

#### Install Metric Server
```sh
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/high-availability.yaml
```
#### Verify 
```sh
kubectl top pods
kubectl top nodes
```