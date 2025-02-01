
### Documentation for Downloading Release Binaries:

https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG

https://github.com/etcd-io/etcd/releases/tag/v3.5.18


### Step 1 - Download Server Binaries (Run this in Control Plane Node):

```sh
mkdir /root/binaries

cd /root/binaries

wget https://dl.k8s.io/v1.32.1/kubernetes-server-linux-amd64.tar.gz

tar -xzvf kubernetes-server-linux-amd64.tar.gz

ls -lh /root/binaries/kubernetes/server/bin/

wget https://github.com/etcd-io/etcd/releases/download/v3.5.18/etcd-v3.5.18-linux-amd64.tar.gz

tar -xzvf etcd-v3.5.18-linux-amd64.tar.gz
```

### Step 2 - Download Node Binaries (Run this in Worker Node):
```sh
mkdir /root/binaries

cd /root/binaries

wget https://dl.k8s.io/v1.32.1/kubernetes-node-linux-amd64.tar.gz

tar -xzvf kubernetes-node-linux-amd64.tar.gz

ls -lh /root/binaries/kubernetes/node/bin/
```
