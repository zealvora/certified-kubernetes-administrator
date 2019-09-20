
##### Step 1: Download CNI Plugins:
```sh
wget https://github.com/containernetworking/plugins/releases/download/v0.8.2/cni-plugins-linux-amd64-v0.8.2.tgz
```
##### Step 2: Configure Base Directories:
```sh
mkdir -p \
  /etc/cni/net.d \
  /opt/cni/bin \
  /var/run/kubernetes
```
##### Step 3: Move CNI Tar File And Extract it.
```sh
mv cni-plugins-linux-amd64-v0.8.2.tgz /opt/cni/bin
cd /opt/cni/bin
tar -xzvf cni-plugins-linux-amd64-v0.8.2.tgz
```
##### Step 4: Configuring Weave
```sh
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.IPALLOC_RANGE=10.200.0.0/16"
```
