#### Step 1. Generate Certificate for Administrator User
```sh
cd /root/certificates
openssl genrsa -out admin.key 2048
openssl req -new -key admin.key -subj "/CN=admin/O=system:masters" -out admin.csr
openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out admin.crt -days 1000
```

#### Step 2. Create KubeConfig file:

Note: Replace the IP address from the below snippet in line 5 with your IP address.


```sh
{
  kubectl config set-cluster kubernetes-from-scratch \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://134.209.159.37:6443 \
    --kubeconfig=admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=admin.crt \
    --client-key=admin.key \
    --embed-certs=true \
    --kubeconfig=admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-from-scratch \
    --user=admin \
    --kubeconfig=admin.kubeconfig

  kubectl config use-context default --kubeconfig=admin.kubeconfig
}
```
#### Step 3: Verify Cluster Status
```sh
kubectl get componentstatuses --kubeconfig=admin.kubeconfig
cp /root/certificates/admin.kubeconfig ~/.kube/config
kubectl get componentstatuses
```
#### Step 4: Verify Kubernetes Objects Creation
```sh
kubectl create namespace kplabs
kubectl get namespace kplabs -o yaml
kubectl get serviceaccount --namespace kplabs
kubectl get secret --namespace kplabs
kubectl create serviceaccount demo
```
