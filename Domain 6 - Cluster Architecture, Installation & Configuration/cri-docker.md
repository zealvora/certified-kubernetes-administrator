### External Websites Referenced

https://github.com/Mirantis/cri-dockerd8

### Step 1 - Installing Docker and Related Packages
```sh
sudo apt update
sudo apt install -y docker.io golang-go
sudo systemctl enable --now docker
```
### Step 2 - Download the CRI Docker
```sh
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.17/cri-dockerd_0.3.17.3-0.ubuntu-jammy_amd64.deb

dpkg -i cri-dockerd_0.3.17.3-0.ubuntu-jammy_amd64.deb

systemctl status cri-docker

systemctl enable cri-docker
```

### Step 3 - Configure Kernel Parameters
```sh
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo sysctl --system
```
```sh
modprobe overlay
modprobe br_netfilter
```
### Step 4 - Configure Repo and Installation
```sh
sudo apt-get update
apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```
```sh
sudo apt-get update

apt-get install -y kubelet=1.32.0-1.1 kubeadm=1.32.0-1.1 kubectl=1.32.0-1.1 cri-tools=1.32.0-1.1

sudo apt-mark hold kubelet kubeadm kubectl

systemctl enable --now kubelet
```
### Step 5 - Initialize Cluster with kubeadm:
```sh
kubeadm init --pod-network-cidr=192.168.0.0/16 --kubernetes-version=1.32.0 --cri-socket=unix:///var/run/cri-dockerd.sock
```
```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

### Step 6 - Remove Taint from Control Plane Node
```sh
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
```

### Step 7 - Install Network Addon (Calico):
```sh
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/tigera-operator.yaml

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/custom-resources.yaml
```
### Step 8 - Verification
```sh
kubectl get nodes
kubectl run nginx --image=nginx
kubectl get pods
```
### Step 9 - Testing
```sh
systemctl stop cri-docker

kubectl run nginx-2 --image=nginx

kubectl get pods

journalctl -u kubelet

systemctl start cri-docker

kubectl get pods
```