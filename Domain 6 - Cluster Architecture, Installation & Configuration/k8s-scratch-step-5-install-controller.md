
#### 1. Generate Certificates:
```sh
cd /root/certificates
```
```sh
openssl genrsa -out kube-controller-manager.key 2048
openssl req -new -key kube-controller-manager.key -subj "/CN=system:kube-controller-manager" -out kube-controller-manager.csr
openssl x509 -req -in kube-controller-manager.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out kube-controller-manager.crt -days 1000
```
#### 2. Generating KubeConfig
```sh
cp /root/binaries/kubernetes/server/bin/kubectl /usr/local/bin
```
```sh
kubectl config set-cluster kubernetes-from-scratch \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-controller-manager.kubeconfig
```
```sh
kubectl config set-cluster kubernetes-from-scratch \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-controller-manager.kubeconfig

kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=kube-controller-manager.crt \
    --client-key=kube-controller-manager.key \
    --embed-certs=true \
    --kubeconfig=kube-controller-manager.kubeconfig

kubectl config set-context default \
    --cluster=kubernetes-from-scratch \
    --user=system:kube-controller-manager \
    --kubeconfig=kube-controller-manager.kubeconfig
```
```sh
kubectl config use-context default --kubeconfig=kube-controller-manager.kubeconfig
```
#### Step 3: Copying the files to kubernetes directory
```sh
cp kube-controller-manager.crt kube-controller-manager.key kube-controller-manager.kubeconfig ca.key /var/lib/kubernetes/
```
#### Step 4: Configuring SystemD service file:
```sh
cat <<EOF | sudo tee /etc/systemd/system/kube-controller-manager.service
[Unit]
Description=Kubernetes Controller Manager
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-controller-manager \\
--address=0.0.0.0 \\
--service-cluster-ip-range=10.32.0.0/24 \\
--cluster-cidr=10.200.0.0/16 \\
--kubeconfig=/var/lib/kubernetes/kube-controller-manager.kubeconfig \\
--authentication-kubeconfig=/var/lib/kubernetes/kube-controller-manager.kubeconfig \\
--authorization-kubeconfig=/var/lib/kubernetes/kube-controller-manager.kubeconfig \\
--leader-elect=true \\
--cluster-signing-cert-file=/var/lib/kubernetes/ca.crt \\
--cluster-signing-key-file=/var/lib/kubernetes/ca.key \\
--root-ca-file=/var/lib/kubernetes/ca.crt \\
--service-account-private-key-file=/var/lib/kubernetes/service-account.key \\
--use-service-account-credentials=true \\
--v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

#### Start Controller Manager:
```sh
cp /root/binaries/kubernetes/server/bin/kube-controller-manager /usr/local/bin
systemctl start kube-controller-manager
systemctl status kube-controller-manager
systemctl enable kube-controller-manager
```
