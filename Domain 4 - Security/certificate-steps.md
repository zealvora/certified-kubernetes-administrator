#### Pre-Requisite:

Connect the linux box with existing K8s setup.

```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

mv kubectl /usr/local/bin
```
Make sure to also copy the contents of your kubeconfig file from local laptop to server
```sh
mkdir ~/.kube
nano ~/.kube/config
````
```sh
kubectl get pods
```
#### Step 1: Create a new private key  and CSR

```sh
mkdir /root/certificates
cd /root/certificates
```
```sh
openssl genrsa -out zeal.key 2048
openssl req -new -key zeal.key -out zeal.csr -subj "/CN=zeal/O=kplabs"
```
#### Step 2: Decode the csr
```sh
cat zeal.csr | base64 | tr -d '\n'
```

#### Step 3: Generate the Kubernetes Signing Request
```sh
nano csr-requests.yaml
```
```sh
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: zeal-csr
spec:
  groups:
  - system:authenticated
  request: ADD-YOUR-CSR-HERE
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - digital signature
  - key encipherment
  - client auth
```
#### Step 4: Apply the Signing Requests:
```sh
kubectl apply -f csr-requests.yaml
```
You can optionally verify with  kubectl get csr

#### Step 5: Approve the csr
```sh
kubectl certificate approve zeal-csr
```
#### Step 6: Download the Certificate from csr
```sh
kubectl get csr zeal-csr -o jsonpath='{.status.certificate}' | base64 -d > zeal.crt
```
#### Step 7: Create a new context
```sh
kubectl config set-credentials zeal --client-certificate=zeal.crt --client-key=zeal.key
```
#### Step 8: Set new Context
```sh
kubectl config set-context zeal-context --cluster [YOUR-CLUSTER-HERE] --user=zeal
```
#### Step 9: Use Context to Verify
```sh
kubectl --context=zeal-context get pods
```

#### Step 10: Create RBAC Role Allowing List PODS Operation

```sh
nano role.yaml
```
```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["list"]
```
```sh
kubectl apply -f role.yaml
```

#### Step 11: Create a New Role Binding
```sh
nano rolebinding.yaml
```
```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: zeal
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```
```sh
kubectl apply -f rolebinding.yaml
```

#### Step 12: Verify Permissions

```sh
kubectl --context=zeal-context get pods
```

#### Step 13: Delete Resources Created in this Lab
```sh
kubectl delete -f role.yaml
kubectl delete -f rolebinding.yaml
```
