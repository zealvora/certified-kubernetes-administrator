### Documentation Referenced in Video

https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2F.exe+download

#### Step 1 - Install Docker:
```sh
# Add Docker's official GPG key:
sudo apt update && apt -y install ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
```
```sh
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
```
#### Step 2 - Install Configure Minikube:
```sh
wget https://github.com/kubernetes/minikube/releases/download/v1.37.0/minikube-linux-amd64

mv minikube-linux-amd64 minikube

chmod +x minikube

sudo mv ./minikube /usr/local/bin/minikube
```
```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo mv kubectl /usr/local/bin

chmod +x /usr/local/bin/kubectl
```

#### Step 3 - Create a New user for testing
```sh
useradd -m -s /bin/bash -G sudo,docker zeal
visudo -f /etc/sudoers.d/zeal
zeal ALL=(ALL) NOPASSWD:ALL
su - zeal
```

#### Step 4: Start Minikube

```sh
minikube start --force
```

#### Step 5: Verification
```sh
minikube status

kubectl get nodes
```
