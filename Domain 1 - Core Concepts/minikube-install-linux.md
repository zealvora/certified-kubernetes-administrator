# MiniKube Installation for Linux

### Note:

For RedHat based systems, make sure that SELinux is not running. Verify with following command:
```sh
getenforce
```
If the output is "Enforcing", then it means SELinux is running and in blocking stage. This can affect the  Minikube installation. You can go ahead and disable SELinux with the following commands:
```sh
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
```
### Official Documentation 

https://kubernetes.io/docs/tasks/tools/install-minikube/ 

### Docker Installation - Pre-Requisite Step:
```sh
yum -y install docker
systemctl start docker
systemctl enable docker
```
### Minikube Installation Commands:

```sh
grep -E --color 'vmx|svm' /proc/cpuinfo

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x miniku
 
 mv minikube /usr/local/bin
 
minikube start --vm-driver=none --extra-config=kubelet.cgroup-driver=systemd

```
### Minikube Installation Commands:
```sh
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

chmod +x minikube
mv minikube /usr/local/bin
kubectl get nodes 
```
