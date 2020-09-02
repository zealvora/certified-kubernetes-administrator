##### Documentation Link:

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

##### Step 1: Configure Docker
```sh
yum -y install docker
systemctl start docker
systemctl enable docker
```
##### Step 2: Configure repo
```sh
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
```

##### Step 3: Basic Configurations
```sh
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable --now kubelet
```
```sh
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
```
```sh
sysctl --system
```
##### Step 4: Initialize Cluster with kubeadm
```sh
kubeadm init --pod-network-cidr=10.244.0.0/16
```
##### Step 5:

Will be available after cluster is initialized.

##### Step 6: Install Network Addon (flannel)

```sh
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```
