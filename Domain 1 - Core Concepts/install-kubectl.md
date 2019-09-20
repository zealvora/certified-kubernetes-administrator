# Installing and Configuring Kubectl for Linux

### Digital Ocean Referral Code:

https://m.do.co/c/74dcb0137794

###  Documentation Link for kubectl

https://kubernetes.io/docs/tasks/tools/install-kubectl/   


### Installing Kubectl:
```sh
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

chmod +x kubectl
mv kubectl /usr/local/bin
```
### Configuring Kubectl:
```sh
mkdir ~/.kube
cd ~/.kube
touch config
```
Copy the config file which you have downloaded inside the config file in ~/kube directory.
### Verification:
```sh
kubectl get nodes
```
