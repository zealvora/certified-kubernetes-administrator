#### Documentation Referred:

https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

https://kubernetes.github.io/ingress-nginx/deploy/

### Step 1 - Create 2 Pods for Example Service and Kplabs Service
```sh
kubectl run example-pod --image=nginx
kubectl run kplabs-pod --image=httpd
```
### Step 2 - Create Service for Both the pods
```sh
kubectl expose pod example-pod --name example-service --port=80 --target-port=80

kubectl expose pod kplabs-pod --name kplabs-service --port=80 --target-port=80

kubectl get service
```
### Step 3 - Create Ingress Resource with 2 Rules
```sh
kubectl create ingress main-ingress --class=nginx --rule="example.internal/*=example-service:80" --rule="kplabs.internal/*=kplabs-service:80" 

kubectl describe ingress main-ingress
```
#### Step 4: Install Nginx Ingress Controller:
```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/cloud/deploy.yaml
```

#### Step 5: Verify the Ingress Controller Resource
```sh
kubectl get pods -n ingress-nginx
kubectl get service -n ingress-nginx
```
Verify if a new load balancer is created in Digital Ocean.


#### Step 6: Verify the Setup
```sh
curl -H "Host: example.internal" <LB-IP>
curl -H "Host: kplabs.internal" <LB-IP>
```

#### Step 7: Delete All Resource

```sh
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/cloud/deploy.yaml

kubectl delete ingress main-ingress

kubectl delete service example-service
kubectl delete service kplabs-service
kubectl delete pod example-pod
kubectl delete pod kplabs-pod
```
