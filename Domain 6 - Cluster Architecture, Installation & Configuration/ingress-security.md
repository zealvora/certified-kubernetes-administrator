### Documentation Referred:

https://kubernetes.io/docs/concepts/services-networking/ingress/

### Step 1 - Create Basic Pod and Service
```sh
kubectl run example-pod --image=nginx

kubectl expose pod example-pod --name example-service --port=80 --target-port=80

kubectl get service

kubectl describe service example-service
```
### Step 2 - Configure Nginx Ingress Controller
```sh
kubectl create -f https://raw.githubusercontent.com/zealvora/certified-kubernetes-security-specialist/refs/heads/main/domain-1-cluster-setup/nginx-controller.yaml

kubectl get pods -n ingress-nginx

kubectl get service -n ingress-nginx

```

### Step 3 - Create Self Signed Certificate for Domain:
```sh
mkdir /root/ingress
cd /root/ingress
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ingress.key -out ingress.crt -subj "/CN=example.internal/O=security"
```

### Step 4 - Verify the Default TLS Certificate
Use the NodePort associated with TLS
```sh
curl -kv <IP>:NodePort 
```
### Step 5 - Create Kubernetes TLS based secret :
```sh
kubectl create secret tls tls-certificate --key ingress.key --cert ingress.crt
kubectl get secret tls-certificate -o yaml
```
### Step 6 - Create Kubernetes Ingress with TLS:
```sh
kubectl create ingress demo-ingress --class=nginx --rule=example.internal/*=example-service:80,tls=tls-certificate
```
### Step 7 - Make a request to Controller:
```sh
kubectl get service -n ingress-nginx
```
Add the `/etc/hosts` entry for mapping before running this command
```sh
curl -kv https://example.internal:31893
```

## Don't delete the resources created for this practical. We will need it in the next video. 
### Step 8 - Delete All Resources 

ALERT: Don't delete the resources created in this practical. It will be used in the next video.
```sh
kubectl delete pod nginx-pod
kubectl delete service example-service
kubectl delete ingress demo-ingress
kubectl delete secret tls-certificate

kubectl delete -f https://raw.githubusercontent.com/zealvora/certified-kubernetes-security-specialist/refs/heads/main/domain-1-cluster-setup/nginx-controller.yaml
```