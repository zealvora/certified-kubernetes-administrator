# Installing and Configuring Kubectl for Linux


###  Documentation Link for kubectl

https://kubernetes.io/docs/tasks/tools/install-kubectl/   


### Installing Kubectl in Linux:
```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
mv kubectl /usr/local/bin
```

### Verification
```sh
kubectl
```

