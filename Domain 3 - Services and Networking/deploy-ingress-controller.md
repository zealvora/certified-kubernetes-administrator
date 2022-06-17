#### Documentation Referred:

https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

https://kubernetes.github.io/ingress-nginx/deploy/


#### Step 1: Install Nginx Ingress Controller:
```sh
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace
```

#### Step 2: Verify the Ingress Controller Resource
```sh
helm list --all-namespaces
kubectl get ingressclass
kubectl get service -n ingress-nginx
```
Verify if a new load balancer is created in Digital Ocean.

#### Step 3: Modify Ingress Resource to Add Controller Data

Add following content under .spec section of ingress.yaml file
```sh
ingressClassName: nginx
```

```sh
kubectl apply -f ingress.yaml
```

#### Step 4: Verify the Ingress Controller Setup
```sh
kubectl exec -it frontend-pod -- bash
```
```sh
nano /etc/hosts
```
```sh
<ADD-LOAD-BALANCER-IP> website01.example.internal website02.example.internal
```

```sh
curl website01.example.internal
curl website02.example.internal
```

#### Step 5: Change the Default Nginx Page for Each Service

```sh
kubectl exec -it service-pod-1 -- bash
cd /usr/share/nginx/html
echo "This is Website 1" > index.html
```
```sh
kubectl exec -it service-pod-2 -- bash
cd /usr/share/nginx/html
echo "This is Website 2" > index.html
```

#### Step 6: Verification

```sh
kubectl exec -it frontend-pod -- bash
curl website01.example.internal
curl website02.example.internal
```
#### Step 7: Delete All Resource

```sh
helm uninstall ingress-nginx -n ingress-nginx
kubectl delete -f ingress.yaml
kubectl delete service service1
kubectl delete service service2
kubectl delete pod service-pod-1
kubectl delete pod service-pod-2
kubectl delete pod frontend-pod
```
