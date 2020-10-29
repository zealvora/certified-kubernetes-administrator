##### Documentation Link:

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

##### Step 1: Configure Docker
```sh
apt-get update
apt-get -y install apt-transport-https ca-certificates curl  gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update && apt-get -y install docker-ce docker-ce-cli
systemctl start docker
```

##### Step 2: Kernel Parameter Configuration
```sh
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
```

##### Step 3:Installation (Master+Worker)
```sh
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
```

##### Video Starts from here
```sh
apt-cache madison kubeadm
apt-get install -qy kubeadm=1.18.0-00 kubelet=1.18.0-00 kubectl=1.18.0-00
apt-mark hold kubelet kubeadm kubectl
kubeadm version
kubeadm init --pod-network-cidr=10.244.0.0/16
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

##### Upgrade Steps

```sh
apt-mark unhold kubelet kubectl
apt-get update && apt-get install -y kubelet=1.19.1-00 kubectl=1.19.1-00
apt-mark hold kubelet kubectl
systemctl daemon-reload
systemctl restart kubelet
```
