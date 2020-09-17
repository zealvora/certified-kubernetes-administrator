
##### Documentation for Downloading Release Binaries:

https://kubernetes.io/docs/setup/release/notes/

https://github.com/etcd-io/etcd/releases/tag/v3.4.10

##### Download Server Binaries (Run this in Master Node):

```sh
yum -y install  wget
mkdir /root/binaries
cd /root/binaries
wget https://dl.k8s.io/v1.18.0/kubernetes-server-linux-amd64.tar.gz
tar -xzvf kubernetes-server-linux-amd64.tar.gz
cd /root/binaries/kubernetes/server/bin/
wget https://github.com/etcd-io/etcd/releases/download/v3.4.10/etcd-v3.4.10-linux-amd64.tar.gz
tar -xzvf etcd-v3.4.10-linux-amd64.tar.gz
```

##### Download Node Binaries (Run this in Worker Node):
```sh
yum -y install  wget
mkdir /root/binaries
cd /root/binaries
wget https://dl.k8s.io/v1.18.0/kubernetes-node-linux-amd64.tar.gz
tar -xzvf kubernetes-node-linux-amd64.tar.gz
```
