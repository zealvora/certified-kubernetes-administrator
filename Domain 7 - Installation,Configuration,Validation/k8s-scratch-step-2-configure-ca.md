##### 1. Creating a private key for Certificate Authority
```sh
openssl genrsa -out ca.key 2048
```
##### 2. Creating CSR
```sh
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
```
##### 3. Self-Sign the CSR
```sh
openssl x509 -req -in ca.csr -signkey ca.key -CAcreateserial  -out ca.crt -days 1000
```
