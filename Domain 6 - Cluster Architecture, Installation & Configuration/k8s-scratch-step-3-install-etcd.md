#### Pre-Requisite:
```sh
sudo su -
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
```

#### Step 1: Configure the Certificates:
```sh
cd /root/certificates/
openssl genrsa -out etcd.key 2048
```
#### Note: Replace the value associated with IP.1 in the below step.

```sh
cat > etcd.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
IP.1 = SERVER-IP
IP.2 = 127.0.0.1
EOF
```
```sh
openssl req -new -key etcd.key -subj "/CN=etcd" -out etcd.csr -config etcd.cnf

openssl x509 -req -in etcd.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out etcd.crt -extensions v3_req -extfile etcd.cnf -days 1000
```
#### Step 2: Copy the Certificates and Key to /etc/etcd
```sh
mkdir /etc/etcd
cp etcd.crt etcd.key ca.crt /etc/etcd
```
#### Step 3: Copy the ETCD and ETCDCTL Binaries to the Path
```sh
cd /root/binaries/kubernetes/server/bin/etcd-v3.4.10-linux-amd64/
cp etcd etcdctl /usr/local/bin/
```

#### Step 4: Configure the Systemd File

Add IP Address to Enviornement Variable of Server_IP.
```sh
SERVER_IP=YOUR-IP-ADDRESS-HERE
```
#### Create a service file:
```sh
cat <<EOF | sudo tee /etc/systemd/system/etcd.service
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/local/bin/etcd \\
  --name master-1 \\
  --cert-file=/etc/etcd/etcd.crt \\
  --key-file=/etc/etcd/etcd.key \\
  --peer-cert-file=/etc/etcd/etcd.crt \\
  --peer-key-file=/etc/etcd/etcd.key \\
  --trusted-ca-file=/etc/etcd/ca.crt \\
  --peer-trusted-ca-file=/etc/etcd/ca.crt \\
  --peer-client-cert-auth \\
  --client-cert-auth \\
  --initial-advertise-peer-urls https://${SERVER_IP}:2380 \\
  --listen-peer-urls https://${SERVER_IP}:2380 \\
  --listen-client-urls https://${SERVER_IP}:2379,https://127.0.0.1:2379 \\
  --advertise-client-urls https://${SERVER_IP}:2379 \\
  --initial-cluster-token etcd-cluster-0 \\
  --initial-cluster master-1=https://${SERVER_IP}:2380 \\
  --initial-cluster-state new \\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```
#### Start Service:
```sh
systemctl start etcd
systemctl status etcd
systemctl enable etcd
```
#### Verification Commands:

When we try with etcdctl --endpoints=https://127.0.0.1:2379 get foo, it gives unknown certificate authority.
```sh
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/ca.crt --cert=/etc/etcd/etcd.crt --key=/etc/etcd/etcd.key put course "kplabs cka course is awesome"
```
```sh
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/ca.crt --cert=/etc/etcd/etcd.crt --key=/etc/etcd/etcd.key get course
```
