##### Pre-Requisite:

- Create a Linux container / Linux server were we can run openssl commands.

```sh
yum -y install openssl nano
```
- Connect the linux box with existing K8s setup.

##### Step 1: Create a new private key  and CSR
```sh
openssl genrsa -out zeal.key 2048
openssl req -new -key zeal.key -out zeal.csr -subj "/CN=zeal/O=kplabs"
```
##### Step 2: Encode the csr
```sh
cat zeal.csr | base64 | tr -d '\n'
```

##### Step 3: Generate the Kubernetes Signing Request
```sh
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  name: zeal-csr
spec:
  groups:
  - system:authenticated
  request: ADD-YOUR-CSR-HERE
  usages:
  - digital signature
  - key encipherment
  - client auth
```
##### Step 4: Apply the Signing Requests:
```sh
kubectl apply -f csr-requests.yaml
```
You can optionally verify with  kubectl get csr

##### Step 5: Approve the csr
```sh
kubectl certificate approve zeal-csr
```
##### Step 6: Download the Certificate from csr
```sh
kubectl get csr zeal-csr -o jsonpath='{.status.certificate}' | base64 -d > zeal.crt
```
##### Step 7: Create a new context
```sh
kubectl config set-credentials zeal --client-certificate=zeal.crt --client-key=zeal.key
```
##### Step 8: Set new Context
```sh
kubectl config set-context zeal-context --cluster [YOUR-CLUSTER-HERE] --user=zeal
```
##### Step 9: Use Context to Verify
```sh
kubectl --context=zeal-context get pods
```
