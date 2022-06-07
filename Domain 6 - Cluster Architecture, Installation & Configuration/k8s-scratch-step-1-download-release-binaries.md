
##### Documentation for Downloading Release Binaries:

https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG

https://github.com/etcd-io/etcd/releases/tag/v3.5.4


#### Download Server Binaries (Run this in Master Node):

```sh
mkdir /root/binaries
cd /root/binaries
wget https://dl.k8s.io/v1.24.1/kubernetes-server-linux-amd64.tar.gz
tar -xzvf kubernetes-server-linux-amd64.tar.gz
cd /root/binaries/kubernetes/server/bin/
wget https://github.com/etcd-io/etcd/releases/download/v3.5.4/etcd-v3.5.4-linux-amd64.tar.gz
tar -xzvf etcd-v3.5.4-linux-amd64.tar.gz
```

#### Download Node Binaries (Run this in Worker Node):
```sh
mkdir /root/binaries
cd /root/binaries
wget https://dl.k8s.io/v1.24.1/kubernetes-node-linux-amd64.tar.gz
tar -xzvf kubernetes-node-linux-amd64.tar.gz
```
