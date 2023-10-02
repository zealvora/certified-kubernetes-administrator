#### Documentation Referred:

https://github.com/kubernetes-sigs/metrics-server

#### Install Metric Server
```sh
kubectl apply -f https://raw.githubusercontent.com/zealvora/certified-kubernetes-administrator/master/Domain%207%20-%20Logging%20and%20Monitoring/metric-server.yaml
```
#### Verify 
```sh
kubectl top pods
kubectl top nodes
```
