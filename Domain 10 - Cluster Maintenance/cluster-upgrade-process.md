### Installing kubeadm in Ubuntu Node (Master)
```sh
nano install-kubeadm-master.sh
```
```sh
#!/bin/bash
apt-get update && apt-get install docker.io -y
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
apt-get install -y kubelet=1.15.6-00 kubeadm=1.15.6-00 kubectl=1.15.6-00
apt-mark hold kubelet kubeadm kubectl
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sysctl -p
kubeadm init --pod-network-cidr=10.244.0.0/16
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```
```sh
chmod +x install-kubeadm-master.sh
```
```sh
./install-kubeadm-master.sh
```

### Installing kubeadm in Ubuntu Node (Worker) 
```sh
nano install-kubeadm-worker.sh
```

```sh
#!/bin/bash
apt-get update && apt-get install docker.io -y
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
apt-get install -y kubelet=1.15.6-00 kubeadm=1.15.6-00
apt-mark hold kubelet kubeadm
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sysctl -p
```
```sh
chmod +x install-kubeadm-worker.sh
```
```sh
./install-kubeadm-worker.sh
```
### Cluster Upgrade Process - Master Node

#### Step 1: Find the list of available versions
```sh
apt-cache policy kubeadm
```
#### Step 2: Upgrade the control plane node:
```sh
apt-get install -y kubeadm=1.16.3-00 && apt-mark hold kubeadm
```
#### Step 3: Verify if download has the expected version
```sh
kubeadm version
```
#### Step 4: Perform an upgrade plan
```sh
kubeadm upgrade plan
```
#### Step 5: Apply the upgrade:
```sh
kubeadm upgrade apply v1.16.3
```
#### Step 6: Upgrade the kubelet and kubectl
```sh
apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.16.3-00 kubectl=1.16.3-00 && \
apt-mark hold kubelet kubectl
```
#### Step 7: Restart Kubelet
```sh
systemctl restart kubelet
```
### Worker Nodes Upgrade Process:

#### Step 1: Upgrade the kubeadm on worker node:
```sh
apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.16.3-00 && \
apt-mark hold kubeadm
```
#### Step 2: Drain the Worker Node:
```sh
kubectl drain $NODE --ignore-daemonsets
```
#### Step 3: Upgrade Kubelet Configuration
```sh
kubeadm upgrade node
```
#### Step 4: Upgrade kubelet and kubectl
```sh
apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.16.3-00 kubectl=1.16.3-00 && \
apt-mark hold kubelet kubectl
```
#### Step 5: Restart Kubelet
```sh
systemctl restart kubelet
```
#### Step 6: Uncordon the node:
```sh
kubectl uncordon $NODE
```
