#### Documentation Referred:

https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

https://doc.traefik.io/traefik/getting-started/kubernetes/


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
kubectl create ingress main-ingress --class=traefik --rule="example.internal/*=example-service:80" --rule="kplabs.internal/*=kplabs-service:80"

kubectl describe ingress main-ingress
```

### Step 4: Install Traefik Ingress Controller:
```sh
helm repo add traefik https://traefik.github.io/charts

helm repo update

helm install traefik traefik/traefik --namespace traefik --create-namespace --set service.type=ClusterIP
```

### Step 5: Verify the Ingress Controller Resource
```sh
kubectl get pods -n traefik

kubectl get service -n traefik

kubectl get ingressclass
```

### Step 6: Forward a Local Port to Traefik (for local kind based k8s clusters)

Since there is no external load balancer created in the local kind based k8s cluster setup, we create a tunnel from your machine to the Traefik service.
```sh
kubectl port-forward -n traefik service/traefik 8080:80
```

This command keeps running. Leave it running and open a second terminal for the next step.



### Step 7: Verify the Setup
```sh
curl -H "Host: example.internal" http://localhost:8080

curl -H "Host: kplabs.internal" http://localhost:8080

curl -i -H "Host: unknown.internal" http://localhost:8080
```

### Step 8: Delete All Resource
```sh
helm uninstall traefik -n traefik
kubectl delete ingress main-ingress
kubectl delete service example-service
kubectl delete service kplabs-service
kubectl delete pod example-pod
kubectl delete pod kplabs-pod
```

