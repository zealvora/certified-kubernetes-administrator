
##### Kubernetes Documentation for Downloading Release Binaries:

https://kubernetes.io/docs/setup/release/

##### Download Server Binaries:

```sh
yum -y install nano wget
https://dl.k8s.io/v1.15.0/kubernetes-server-linux-amd64.tar.gz
tar -xzvf kubernetes-server-linux-amd64.tar.gz
```

##### Download Node Binaries:
```sh
yum -y install nano wget
wget https://dl.k8s.io/v1.15.0/kubernetes-node-linux-amd64.tar.gz
tar -xzvf kubernetes-node-linux-amd64.tar.gz
```

##### GitHub Page for ETCD:

https://github.com/etcd-io/etcd
```sh
wget https://github.com/etcd-io/etcd/releases/download/v3.4.0/etcd-v3.4.0-linux-amd64.tar.gz
```
