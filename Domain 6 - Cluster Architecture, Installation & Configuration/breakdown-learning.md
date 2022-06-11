
#### Run POD for testing before bringing cluster components down
```sh
kubectl run nginx-before --image=nginx
```
## 1. kube-scheduler

#### Bring Down kube-scheduler
```sh
systemctl stop kube-scheduler
systemctl status kube-scheduler
```
#### Testing
```sh
kubectl run nginx-after --image=nginx
kubectl get pods
kubectl describe pod nginx-before
```
#### Bring Up kube-scheduler
```sh
systemctl start kube-scheduler
kubectl get pods
```
## 2. kubelet

#### Bring Down kube-scheduler (Worker Node)
```sh
systemctl stop kubelet
systemctl status kubelet
```
#### Testing
```sh
kubectl run kubelet --image=nginx
kubectl get pods
kubectl describe pod kubelet
```
#### Bring Up kubelet
```sh
systemctl start kubelet (worker node)
kubectl get pods  (matser node)
```
## 3. Controller Manager

#### Initial Setup
```sh
kubectl create namespace namespace-1
kubectl get sa -n namespace-1
```
#### Bring Down kube-controller-manager (Master Node)
```sh
systemctl stop kube-controller-manager
systemctl status kube-controller-manager
```
#### Testing
```sh
kubectl create namespace namespace-2
kubectl get sa -n namespace-2

kubectl delete namespace namespace-1
```
#### Bring Up kube-controller-manager and Verify
```sh
systemctl start kube-controller-manager (worker node)
kubectl get namespace
kubectl get sa -n namespace-2
```
