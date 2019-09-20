##### Test 1: Deployments.
```sh
kubectl run nginx --image=nginx --port=80
```
```sh
kubectl scale deployment/nginx --replicas=3
```
#####  Test 2: Secrets
```sh
kubectl create secret generic kplabs-secret \
--from-literal="course=kplabs-cka"
```
```sh
kubectl get secret kplabs-secret -o yaml
```
```sh
echo "encoded-value" | base64 -d
```

#####  Test 3: Services
```sh
kubectl expose deployment nginx --type=NodePort
```

#####  Test 4: Exec Functionality
```sh
kubectl exec -it POD-NAME -- nginx -v
```

#####  Tests 5: Basic Networking

i)  Pod to Cluster IP Communication
```sh
kubectl run busybox --image=busybox:1.28 --command -- sleep 3600
```
```sh
wget [NGINX-SERVICE-IP]
```
ii) Pod to Internet Communication.
```sh
ping google.com
```
iii) Inter-Pod Communication.
```sh
kubectl get pods -o wide
```
```sh
ping [Pods-IP]
```
iv) kube-proxy validation
```sh
kubectl proxy --port=8080
```

