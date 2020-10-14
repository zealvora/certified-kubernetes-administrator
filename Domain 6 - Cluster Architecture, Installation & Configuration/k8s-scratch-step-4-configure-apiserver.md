#### Reference Documentation mentioned in the video:

https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/

https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/

#### Pre:Requisite Step: Move the kube-apiserver binary to /usr/bin directory.

```sh
cd /root/binaries/kubernetes/server/bin/
cp kube-apiserver /usr/local/bin/
```

#### Step 1. Generate Configuration File for CSR Creation.
```sh
cd /root/certificates
```
```sh
cat <<EOF | sudo tee api.conf
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = kubernetes
DNS.2 = kubernetes.default
DNS.3 = kubernetes.default.svc
DNS.4 = kubernetes.default.svc.cluster.local
IP.1 = 127.0.0.1
IP.2 = ${SERVER_IP}
IP.3 = 10.32.0.1
EOF
```
#### Step 2: Generate Certificates for API Server
```sh
openssl genrsa -out kube-api.key 2048
openssl req -new -key kube-api.key -subj "/CN=kube-apiserver" -out kube-api.csr -config api.conf
openssl x509 -req -in kube-api.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-api.crt -extensions v3_req -extfile api.conf -days 1000
```
#### Step 3: Generate Certificate for Service Account:
```sh
openssl genrsa -out service-account.key 2048
openssl req -new -key service-account.key -subj "/CN=service-accounts" -out service-account.csr
openssl x509 -req -in service-account.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out service-account.crt -days 100
```

#### Step 4: Copy the certificate files to /var/lib/kubernetes directory
```sh
mkdir /var/lib/kubernetes
cp etcd.crt etcd.key ca.crt kube-api.key kube-api.crt service-account.crt service-account.key /var/lib/kubernetes
```

#### Step 5: Creating Encryption key and Configuration
```sh
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
```
```sh
cat > encryption-at-rest.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF
```
```sh
cp encryption-at-rest.yaml /var/lib/kubernetes/encryption-at-rest.yaml
```
#### Step 6: Creating Systemd service file:

Systemd file:

```sh
cat <<EOF | sudo tee /etc/systemd/system/kube-apiserver.service
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-apiserver \
--advertise-address=134.209.159.37 \
--allow-privileged=true \
--authorization-mode=Node,RBAC \
--client-ca-file=/var/lib/kubernetes/ca.crt \
--enable-admission-plugins=NamespaceLifecycle,NodeRestriction,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota \
--enable-bootstrap-token-auth=true \
--etcd-cafile=/var/lib/kubernetes/ca.crt \
--etcd-certfile=/var/lib/kubernetes/etcd.crt \
--etcd-keyfile=/var/lib/kubernetes/etcd.key \
--etcd-servers=https://127.0.0.1:2379 \
--kubelet-certificate-authority=/var/lib/kubernetes/ca.crt \
--kubelet-client-certificate=/var/lib/kubernetes/kube-api.crt \
--kubelet-client-key=/var/lib/kubernetes/kube-api.key \
--kubelet-https=true \
--service-account-key-file=/var/lib/kubernetes/service-account.crt \
--service-cluster-ip-range=10.32.0.0/24 \
--tls-cert-file=/var/lib/kubernetes/kube-api.crt \
--tls-private-key-file=/var/lib/kubernetes/kube-api.key \
--requestheader-client-ca-file=/var/lib/kubernetes/ca.crt \
--service-node-port-range=30000-32767 \
--audit-log-maxage=30 \
--audit-log-maxbackup=3 \
--audit-log-maxsize=100 \
--audit-log-path=/var/log/kube-api-audit.log \
--bind-address=0.0.0.0 \
--event-ttl=1h \
--encryption-provider-config=/var/lib/kubernetes/encryption-at-rest.yaml \
--v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```
#### Step 7: Start the kube-api service:
```sh
systemctl start kube-apiserver
systemctl status kube-apiserver
systemctl enable kube-apiserver
```
