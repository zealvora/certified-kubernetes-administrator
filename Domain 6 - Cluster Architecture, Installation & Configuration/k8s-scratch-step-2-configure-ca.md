#### 1. Create base directory for Certificate Storage

```sh
mkdir /root/certificates
cd /root/certificates
```

#### 2. Creating a private key for Certificate Authority
```sh
openssl genrsa -out ca.key 2048
```
#### 3. Creating CSR
```sh
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
```
#### 4. Self-Sign the CSR
```sh
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt -days 1000
```
#### 5. See Contents of Certificate
```sh
openssl x509 -in ca.crt -text -noout
```
#### 6. Remove CSR
```sh
rm -f ca.csr
```
