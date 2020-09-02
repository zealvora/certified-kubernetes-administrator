
##### 1. Create a secret
```sh
kubectl create secret generic kplabs-secret \
--from-literal="course=kplabs-cka"
```

##### 2. Fetch the Secret directly from ETCD
```sh
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/ca.crt --cert=/etc/etcd/etcd.crt --key=/etc/etcd/etcd.key get /registry/secrets/default/kplabs-secret | hexdump -C
```
### 3.  Add this to kube-apiserver

##### Step 1: Create Encryption Key:
```sh
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
```
##### Step 2: Create Encryption Configuration:
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
##### Step 3:  Copy the config file to /var/lib/kubernetes
```sh
cp encryption-at-rest.yaml /var/lib/kubernetes
```
##### Step 4: Add the flag at kube-apiserver
```sh
--encryption-provider-config=/var/lib/kubernetes/encryption-at-rest.yaml
```
```sh
systemctl daemon-reload
systemctl restart kube-apiserver
systemctl status kube-apiserver
```
##### Step 5: Verification:
```sh
kubectl create secret generic new-secret \
--from-literal="course=kplabs-cka"
```sh
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/etcd/ca.crt --cert=/etc/etcd/etcd.crt --key=/etc/etcd/etcd.key get /registry/secrets/default/new-secret | hexdump -C
```
