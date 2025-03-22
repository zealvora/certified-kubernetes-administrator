#### Documentation Referred:

https://github.com/kubernetes-sigs/metrics-server

#### Install Metric Server
```sh
kubectl apply -f https://raw.githubusercontent.com/zealvora/certified-kubernetes-administrator/refs/heads/master/Domain%203%20-%20Services%20and%20Networking/metric-server.yaml
```
#### Verify 
```sh
kubectl top pods

kubectl top pods -A

kubectl top nodes
```
