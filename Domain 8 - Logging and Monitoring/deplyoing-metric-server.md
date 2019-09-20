#### Metric Server GitHub Page:

https://github.com/kubernetes/kube-state-metrics

#### Commands to Deploy Metric Server:
```sh
git clone https://github.com/kubernetes-incubator/metrics-server.git
```
```sh
cd metrics-server/deploy/1.8+
```
Modify the metrics-server-deployment.yaml to include following lines:
```sh
command:
 - /metrics-server
 - --kubelet-insecure-tls
 - --kubelet-preferred-address-types=InternalIP
 ```
 Go back one directory up with cd ../
 ```sh
 kubectl apply -f 1.8+
 ```
 Commands to View Metrics:
 ```sh
 kubectl top pods
 kubectl top nodes
```
