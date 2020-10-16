### Pre-Requisite:  Common steps to configure etcd in both servers



##### Step 1. Create base directories
```sh
mkdir /root/certificates
mkdir /root/binaries
```
##### Step 2. Install packages
```sh
yum -y install nano wget openssl tar gzip
```
##### Step 3. Download ETCD binary and copy them to the path
```sh
cd /root/binaries
wget https://github.com/etcd-io/etcd/releases/download/v3.4.0/etcd-v3.4.0-linux-amd64.tar.gz
tar -xzvf etcd-v3.4.0-linux-amd64.tar.gz
cd /root/binaries/etcd-v3.4.0-linux-amd64
cp etcd etcdctl /usr/bin/
```

##### Step 4. Turn Off SELinux and Swap
```sh
setenforce 0
swapoff -a
```
##### Step 5. Generate Certificates:
```sh
cd /root/certificates
openssl genrsa -out ca.key 2048
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
openssl x509 -req -in ca.csr -signkey ca.key -CAcreateserial  -out ca.crt -days 1000
openssl genrsa -out etcd.key 2048
```

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
IP.1 = SERVER-IP-HERE
IP.3 = 127.0.0.1
EOF
```
```sh
openssl req -new -key etcd.key -subj "/CN=etcd" -out etcd.csr -config etcd.cnf
openssl x509 -req -in etcd.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out etcd.crt -extensions v3_req -extfile etcd.cnf -days 1000
```
##### Step 6: Copy certificates to etcd
```sh
mkdir /etc/etcd
cp etcd.crt etcd.key ca.crt /etc/etcd
```
#####  Step 7: Configure Systemd file:
```sh
SERVER_IP=YOUR-IP-ADDRESS-HERE
```
```sh
cat <<EOF | sudo tee /etc/systemd/system/etcd.service
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/bin/etcd \\
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
Step : Start the service:
```sh
systemctl start etcd
systemctl status etcd
systemctl enable etcd
```


### Steps for Server 1 (ETCD Backup)

##### Step 1. Add a sample data to ETCD database
```sh
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/ca.crt --cert=/etc/etcd/etcd.crt --key=/etc/etcd/etcd.key put course "kplabs cka course is awesome"
```
#####  Step 2. Verify if data is added successfully
```sh
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/ca.crt --cert=/etc/etcd/etcd.crt --key=/etc/etcd/etcd.key get course
```
##### Step 3. Take snapshot from the primary ETCD
```sh
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/ca.crt --cert=/etc/etcd/etcd.crt --key=/etc/etcd/etcd.key snapshot save /tmp/snapshot.db
```
##### Step 4. Check details of the snapshot
```sh
etcdctl --write-out=table snapshot status /tmp/snapshot.db
```
### Steps for Server 2 (ETCD Restore)

##### Step 1. Create a user for transferring files from Server 1 to Server 2
```sh
useradd zeal
passwd zeal
```
##### Step 2. Modify the SSH configuration to allow PasswordAuthentication
```sh
nano /etc/ssh/sshd_config
```
```sh
PasswordAuthentication yes
```
##### Step 3. Restart SSHD service
```sh
systemctl restart sshd
```
#####  Step 4. Move the snapshot from server 1 to server 2
```sh
scp /tmp/snapshot.db zeal@SERVER2-IP:/tmp
```
##### Step 5. Perform the Restore Command
```sh
cd /tmp
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/ca.crt --cert=/etc/etcd/etcd.crt --key=/etc/etcd/etcd.key snapshot restore snapshot.db
```
##### Step 6. Remove the files from /var/lib/etcd directory
```sh
systemctl stop etcd
```
```sh
rm -rf /var/lib/etcd/*
```

##### Step 7. Copy the files from restored snapshot to /var/lib/etcd
```sh
mv /tmp/default.etcd/* /var/lib/etcd
```
##### 8. Start ETCD Service
```sh
systemctl start etcd
```
##### 9. Verify the restore
```sh
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/ca.crt --cert=/etc/etcd/etcd.crt --key=/etc/etcd/etcd.key get course
```
